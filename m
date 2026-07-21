Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 875E6C4451C
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 17:11:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D51BD10E399;
	Tue, 21 Jul 2026 17:10:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dHf2daCU";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF5E810E369
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 17:10:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4F8C841A34;
 Tue, 21 Jul 2026 17:10:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC5D41F000E9;
 Tue, 21 Jul 2026 17:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784653858;
 bh=qJ1KOWwzv9XEFOtAFAj4aQZ54KKVw0y2EOtpksb+j10=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dHf2daCUixkYFVG6qoj1KofjttW+7JNZlIskKrPLW9+fON6j9dsjF/uTm7Uvg7zfZ
 LcYxV8jVzHo9YsaZqKVAxsG2CNy/wj4gkz+BWM4e7wTbU9JUbUocLSNjv1L3tyw6ct
 Pe+n29fBTVUFKAq9ZgqUc9gMnrO2MMbFkPSWh5dfx1Tliz9Ei9CMzhJFLWfuwUYxPN
 b0X6IkLDXPaHgpKEem3Y+GA2gM25Z5glypWRnIMLSNcEDZc4/Hr4yh+A83OLmL7t9t
 fHcpYh/WRS022W9LjoqXnyxO/HBjuqelGVu32g0bBH6/Bo7zvceKaBe2erdQZsK6mO
 rUrF218kmw9UA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/10] drm/tyr: specify base type for registers
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
 ojeda@kernel.org, "Danilo
 Krummrich" <dakr@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260721-typed_register-v1-3-452d72b60262@garyguo.net>
References: <20260721-typed_register-v1-0-452d72b60262@garyguo.net>
 <20260721-typed_register-v1-3-452d72b60262@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 17:10:57 +0000
Message-Id: <20260721171057.CC5D41F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `DOORBELL` register array exceeds the 2MB size of `TyrRegist=
ers`, which will cause bounds-checking failures during access.
--

--- Patch [3]: [PATCH 03/10] drm/tyr: specify base type for registers ---
commit 0835e2ca0e8718a373eb876a88da9c8e609d5b61
Author: Gary Guo <gary@garyguo.net>

drm/tyr: specify base type for registers

This commit adds a base parameter to register definitions in the tyr drm
driver, associating them with a new TyrRegisters type bounded to a 2MB size.

> diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
> index 8348c6cd39295..401a4b321eaf8 100644
> --- a/drivers/gpu/drm/tyr/driver.rs
> +++ b/drivers/gpu/drm/tyr/driver.rs

[ ... ]

> @@ -43,6 +43,7 @@
>  };
> =20
>  pub(crate) type IoMem<'a> =3D kernel::io::mem::IoMem<'a, SZ_2M>;
> +pub(crate) type TyrRegisters =3D kernel::io::Region<SZ_2M>;
> =20
>  pub(crate) struct TyrDrmDriver;
> =20

[ ... ]

> diff --git a/drivers/gpu/drm/tyr/regs.rs b/drivers/gpu/drm/tyr/regs.rs
> index 831357a8ef87d..ef21d90dbbc41 100644
> --- a/drivers/gpu/drm/tyr/regs.rs
> +++ b/drivers/gpu/drm/tyr/regs.rs

[ ... ]

> @@ -1637,6 +1677,8 @@ pub(crate) mod doorbell_block {
>      const STRIDE: usize =3D 0x10000;
> =20
>      register! {
> +        base: TyrRegisters;
> +
>          /// Doorbell request register. Write-only.
>          pub(crate) DOORBELL(u32)[NUM_DOORBELLS, stride =3D STRIDE] @ 0x8=
0000 {

[Severity: Medium]
Will this result in bounds-checking failures during access?

The DOORBELL register array is defined with an offset of 0x80000, 64 elemen=
ts,
and a stride of 0x10000. The final element is located at
0x80000 + (63 * 0x10000) =3D 0x470000, which is approximately 4.6MB.

However, this patch explicitly associates the DOORBELL array with the
TyrRegisters base type, which is constrained to SZ_2M (2MB).

When accessing DOORBELL with an index >=3D 24 via the TyrRegisters I/O regi=
on,
it will cause a compile-time build_assert! failure for static indices or a
failure for dynamic indices because the access is out of bounds.

Could the driver's mapped MMIO size of SZ_2M be undersized, or is the DOORB=
ELL
register improperly modeled here?

>              /// Doorbell set. Writing 1 triggers the doorbell.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-typed_regi=
ster-v1-0-452d72b60262@garyguo.net?part=3D3
