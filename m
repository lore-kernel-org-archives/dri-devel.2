Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1EE3CD98C7
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 17:46:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5467C10F045;
	Thu, 11 Jun 2026 17:46:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QJXEE54c";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C50810F045
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 17:46:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E42284436E;
 Thu, 11 Jun 2026 17:46:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5665E1F00893;
 Thu, 11 Jun 2026 17:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781199967;
 bh=tJqbP7Pqgv8wTQVr8/KiKdpcDKGcbwu2ETXfBiAKjYc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QJXEE54cDBNpblcxg0efzfnqoz8Sx3unObSqcMj1KBjJS9NVZlG4PGoZihIDzuPBy
 7rH3j11XMeLgBzVy2bg0U6x4wzYQXs6/f9XcYNrhzmzna/dDvex/77Qf15JOcG5PGY
 V4iN55N1/NXuAaLtfgBY5E3Kele4pckwA82lqqGrulennmcIuQwUoFlYCJmr3f1wHa
 DhlHoXjbY7NV2//KTF/AThSrfLx5n9xld+d7kY/p5Tkfv5H+m8Vm6AW1hrhLLudZq5
 ZvG6hURnBXZOt90IJgL104o8XoiPB/e9oTRwiN9s54jbA/g6Lt5aPvchuTN7Tw2eLp
 AEnDoENHiH1Sg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/20] rust: io: use view types instead of addresses
 for `Io`
To: "Gary Guo" <gary@garyguo.net>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org,
 ojeda@kernel.org, "Danilo
 Krummrich" <dakr@kernel.org>, linux-pci@vger.kernel.org
In-Reply-To: <20260611-io_projection-v4-9-1f7224b02dcb@garyguo.net>
References: <20260611-io_projection-v4-9-1f7224b02dcb@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 17:46:06 +0000
Message-Id: <20260611174607.5665E1F00893@smtp.kernel.org>
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
> designk, as they do not carry sufficient information. For example,
> `ConfigSpace` needs `&pci::Device` in addition to the address.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611-io_project=
ion-v4-0-1f7224b02dcb@garyguo.net?part=3D9

