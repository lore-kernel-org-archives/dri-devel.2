Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95191C9830E
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 11:03:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0FFB10E533;
	Sun, 27 Sep 2026 11:03:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KL1ZbT8P";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6F0A10E533
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 11:03:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E257D60AAE
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 11:03:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EE201F000FF;
 Sun, 27 Sep 2026 11:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790507027;
 bh=6p2lQqM1rZnlab+H96/Oh2JzAW61ozyeIjuE6v/qx00=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KL1ZbT8PdewrEN8SinIeyIRHBNyNqa1J4uB0uXHbJxNugMAVYbBAoiT14B8+Rw1O8
 vytN21YuQIfc6eXsoXYl0gIWacWSwOgVc3HKi3IritggTaErwMvuhD8SWLxrwM1IQv
 3HbfyyDlaVMqtxhj9AbKGvXm6UcrI8wQhFG/PHfBPV6TLOiVV25i+e0pxQ5UUKXfPa
 bt9BFaVgcum5aueWoKrA5pa5EFwNMMo3OVNBq9QSbESsTsLvQ9qg8rgdypKhJPkAYg
 XdCD44cKWqtERZl70LeI1+oqtwMB8ttqT7EkpTuZ6c9qo3K0eA6PU+x9uRZabd3Xfp
 BUqfvYqt2+CqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] drm/radeon: Check the VBIOS signature after copying
 it from VRAM
To: "Imre Kaloz" <kaloz@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260927105555.8771-2-kaloz@kernel.org>
References: <20260927105555.8771-1-kaloz@kernel.org>
 <20260927105555.8771-2-kaloz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 11:03:47 +0000
Message-Id: <20260927110347.6EE201F000FF@smtp.kernel.org>
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
- [Medium] radeon: inefficient 256KB MMIO copy and allocation before VBIOS =
signature check
--

commit e7cbdfb764010827fd7b2b511a029cf30846ddbe
Author: Imre Kaloz <kaloz@kernel.org>

drm/radeon: Check the VBIOS signature after copying it from VRAM

This commit modifies the VBIOS reading logic to check the signature after
copying the data from VRAM. This is done to avoid a sparc64 fault caused
by a plain load through an ioremap() cookie.

> diff --git a/drivers/gpu/drm/radeon/radeon_bios.c b/drivers/gpu/drm/radeo=
n/radeon_bios.c
> index 8595f4c6e2e5c..a8367e4811821 100644
> --- a/drivers/gpu/drm/radeon/radeon_bios.c
> +++ b/drivers/gpu/drm/radeon/radeon_bios.c
> @@ -63,10 +63,6 @@ static bool igp_read_bios_from_vram(struct radeon_devi=
ce *rdev)
>  		return false;
>  	}
> =20
> -	if (size =3D=3D 0 || bios[0] !=3D 0x55 || bios[1] !=3D 0xaa) {
> -		iounmap(bios);
> -		return false;
> -	}
>  	rdev->bios =3D kmalloc(size, GFP_KERNEL);
>  	if (rdev->bios =3D=3D NULL) {
>  		iounmap(bios);
> @@ -74,6 +70,12 @@ static bool igp_read_bios_from_vram(struct radeon_devi=
ce *rdev)
>  	}
>  	memcpy_fromio(rdev->bios, bios, size);
>  	iounmap(bios);
> +
> +	if (size =3D=3D 0 || rdev->bios[0] !=3D 0x55 || rdev->bios[1] !=3D 0xaa=
) {

[Severity: Medium]
Does this sequence perform an expensive unconditional 256KB kmalloc() and
PCIe MMIO read (memcpy_fromio()) for discrete GPUs before validating the
VBIOS header signature?

During device probe, radeon_get_bios() tries multiple fallback methods and
calls igp_read_bios_from_vram(). This allows posted discrete GPUs to procee=
d.
The new logic maps VRAM, immediately allocates 256KB, copies it, and only
then checks if the first two bytes match the expected 0x55 and 0xaa
signature. This wastes allocation overhead and introduces a noticeable boot
delay, as reading 256KB of un-cached MMIO over PCIe takes significant time.

To fix the sparc64 __iomem access fault without creating a performance
regression, could this code use readb(&bios[0]) for the signature validation
before performing the 256KB allocation and copy, matching the pattern
established in radeon_read_bios()?

> +		kfree(rdev->bios);
> +		rdev->bios =3D NULL;
> +		return false;
> +	}
>  	return true;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927105555.8771=
-1-kaloz@kernel.org?part=3D1
