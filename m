Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D33FEC43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 12:54:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30A6810E971;
	Mon,  6 Jul 2026 12:54:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VXmo4dlM";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F57810E971
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 12:54:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 84D28600FC;
 Mon,  6 Jul 2026 12:54:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 048D41F000E9;
 Mon,  6 Jul 2026 12:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783342448;
 bh=oceVGSHWVJ1LVqwuIdHu/3w4DcAK6NT5oD96eQmcbi4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VXmo4dlMeYELXOrWrgLomiXuEU29gyY9LuoA4lCRzsOlTnWfIS8exo9VYtMqHLHnb
 nbRBWmeAsx76PDC1Ln2vKQlQ9ZXqJXKFoUZL29McI2GQjcDAh9IuH8rRWCXxqapBPZ
 24s4hBDEqgw18jYgGBjtK4Zrsq73Ll94P6T2VIv+xonjiTElS95JsOaxjV32YXDGcL
 9kQrS58q122hTPxtjVeTm8LaubbFTD4BISt+nI5nUK0U7GfWboa4DnwW/4a9CnBNJH
 F0DUja1uOlOCksNOl2VCsS/nc8Hl69PiCTNC9sQ6AAp+Njrm1vpuUVdOkT9JKjNfNM
 U99Gfql67Li8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 01/20] rust: io: add dynamically-sized `Region` type
To: "Gary Guo" <gary@garyguo.net>
Cc: dri-devel@lists.freedesktop.org, "Danilo Krummrich" <dakr@kernel.org>,
 "Alexandre
 Courbot" <acourbot@nvidia.com>, linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260706-io_projection-v6-1-72cd5d055d54@garyguo.net>
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
 <20260706-io_projection-v6-1-72cd5d055d54@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 12:54:07 +0000
Message-Id: <20260706125408.048D41F000E9@smtp.kernel.org>
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

> Currently many I/O related structs carry a `SIZE` parameter to denote the
> minimum size of the I/O region, while they also carry a field indicating
> the actual size. Proliferation of the pattern creates a lot of duplicated
> code, and makes it hard to create typed views of I/O.
>=20
> Introduce a `Region` type that carries the `SIZE` parameter. It is a
> wrapper of `[u8]`, which makes it dynamically sized with a metadata of
> `usize`. This way, pointers to `Region` naturally carry size information.
> This type is required to be 4-byte aligned.
>=20
> Expose the minimum size information via `MIN_SIZE` constant of the
> `KnownSize` trait. Similarly, expose the minimum alignment information via
> `KnownSize::MIN_ALIGN`.
>=20
> With these changes, it is possible to add an associated type to `Io` trait
> to represent the type of I/O region. For untyped regions, this is the new=
ly
> added `Region` type. Remove `IoKnownSize` as it is no longer necessary. U=
se
> the same mechanism to indicate minimum size of PCI config spaces.
>=20
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-io_project=
ion-v6-0-72cd5d055d54@garyguo.net?part=3D1

