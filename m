Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDEA0C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 12:57:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CF6610E952;
	Mon,  6 Jul 2026 12:57:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WsYJYwel";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 435FA10E952
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 12:57:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BA115600BB;
 Mon,  6 Jul 2026 12:57:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E3461F00A3A;
 Mon,  6 Jul 2026 12:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783342629;
 bh=iJ2HSN9/NEIPB1aDkoCJ+eBaDaZcG3QsvKmwsfgZIe8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WsYJYwelsGO+05RxMuYbJ2aL+1qIhCxWwJFi3hi1N1on4FmWLZydp5KIBkRZdSbmt
 kt0EulDReoQGR9INMrIfMpro96/ekItOYluTIJ1bbGHRgZT9Dk/Pm46o+XrKr8PxvY
 MYvbF11Vtv4A5e3vmqRh6E4LK8AcR5h+l0t7KI7QmZqmWKQxjGAz3N5mukzcM/H8Zj
 5/7ujmqJpWXpVBJ4X69JENHY2cZ4d33Aw7hMZNXxhsGV8YnAPP0jGj9F2Ad5ZRGJBi
 4hmBRCixH/K/4tCN8RZZjKbRFNKAVx+FpMcIi5oQa+K5Ouhg5dJy9BOmvKyWAy80Mr
 AHWysw28fReWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 09/20] rust: io: use view types instead of addresses
 for `Io`
To: "Gary Guo" <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, linux-pci@vger.kernel.org,
 ojeda@kernel.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20260706-io_projection-v6-9-72cd5d055d54@garyguo.net>
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
 <20260706-io_projection-v6-9-72cd5d055d54@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 12:57:08 +0000
Message-Id: <20260706125709.1E3461F00A3A@smtp.kernel.org>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

> Currently, `io_read` and `io_write` methods require the exact type of `Io`
> plus an address. This means that they need to be monomorphized for each
> different `Io` instance. This also means that multiple I/O implementors f=
or
> the same I/O kind needs to duplicate implementation (e.g. `Mmio` and
> `MmioOwned`).
>=20
> Create a new `IoBackend` trait and define these operations on it instead.
> The operations are just going to receive a view type and operate on them.
> This has the additional advantage that the invariants can be moved from t=
he
> trait (and guaranteed via `unsafe`) to type invariants on the canonical
> view types of the backends, so `io_read` and `io_write` can be safe.
>=20
> Note that view type is needed; addresses are insufficient in this
> design, as they do not carry sufficient information. For example,
> `ConfigSpace` needs `&pci::Device` in addition to the address.
>=20
> `io_addr_assert` and `io_addr` are renamed to `io_view*` to reflect
> that they operate on views now, and make them standalone functions so
> they cannot be used by users to cast types outside io.rs.
>=20
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-io_project=
ion-v6-0-72cd5d055d54@garyguo.net?part=3D9

