Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F02C5CD98F2
	for <dri-devel@archiver.kernel.org>; Sun, 21 Jun 2026 17:50:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44D7310E1BC;
	Sun, 21 Jun 2026 17:50:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="f6elkNMR";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7FA910E1BC
 for <dri-devel@lists.freedesktop.org>; Sun, 21 Jun 2026 17:50:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 711E643948;
 Sun, 21 Jun 2026 17:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB971F000E9;
 Sun, 21 Jun 2026 17:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782064226;
 bh=kvHOYnLTzTEWcFyAumq5ZAckyeFovcJcXxTIeuaw/JA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=f6elkNMRaedrHNZDKmNwq2pzlwoL534e4ATUnVvCi7cqBFVp2sSC7mq4saOHn+ya+
 TLKgSW6PHPcEUtqO0RRLtNDAsqmDnN+dthl2ftsVtEesCmjqwKoPjkryJvDfzeY0ea
 /cD2ADv3/CKW9A7PY8mYiOsVt7kcs3GrCusJM9JDvIzBUryWzyeB6x7PoEBnqiC5c0
 P0Xy3wtZcOoB/WDdT96ErcITFKB55qwIkqccOgYLDJV1eXLLQyVQScWW1gME9oFwv3
 B8Fgix6VPk/xm4xOc1NbNim2V5r/PUm8ZpX1dQYMmg0U5mpzcoBgyTe3fEd+hgI8Qx
 zhSJWZmkcCaHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amd/amdgpu: add firmware file fallback for APU
 VBIOS discovery
To: "Oz Tiram" <oz@shift-computing.de>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260621173211.28443-1-oz@shift-computing.de>
References: <20260621173211.28443-1-oz@shift-computing.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 21 Jun 2026 17:50:25 +0000
Message-Id: <20260621175025.ADB971F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The firmware file fallback for APU VBIOS discovery does not valida=
te the loaded firmware with `check_atom_bios()`, potentially leading to a k=
ernel panic or out-of-bounds reads.

Pre-existing issues:
- [High] Pre-existing off-by-one boundary checks in `check_atom_bios()` all=
ow out-of-bounds memory reads when evaluating truncated or malformed VBIOS =
images.
--

commit 3e01d007e8160f9d82a04903ddd4a636561ac6f7
Author: Oz Tiram <oz@shift-computing.de>

drm/amd/amdgpu: add firmware file fallback for APU VBIOS discovery

This patch adds a fifth fallback path for APU VBIOS discovery using a
firmware file loaded via request_firmware(). This allows a VBIOS image
extracted from running hardware to be used when other methods like VFCT
or ROM BAR fail.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_bios.c
> index aa039e148a5ee..491f88f495a66 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c

[ ... ]

> @@ -457,6 +458,24 @@ static bool amdgpu_get_bios_apu(struct amdgpu_device=
 *adev)
>  		goto success;
>  	}
> =20
> +	{
> +		const struct firmware *fw;
> +		char fw_name[32];
> +
> +		snprintf(fw_name, sizeof(fw_name), "amdgpu/%04x_%04x.bin",
> +			 adev->pdev->vendor, adev->pdev->device);
> +		if (request_firmware(&fw, fw_name, adev->dev) =3D=3D 0) {
> +			adev->bios =3D kmemdup(fw->data, fw->size, GFP_KERNEL);
> +			adev->bios_size =3D fw->size;
> +			release_firmware(fw);
> +			if (adev->bios) {

[Severity: High]
Does this new firmware fallback path need to validate the fetched memory us=
ing
check_atom_bios()?

All other VBIOS discovery paths appear to validate the fetched memory before
accepting the BIOS image. If the provided firmware file is empty (size 0),
kmemdup() returns ZERO_SIZE_PTR (which evaluates to true). The driver will
later dereference this pointer during ATOM BIOS parsing, which could cause a
kernel page fault.

Additionally, if the firmware is malformed or undersized, the ATOM BIOS par=
ser
could read out-of-bounds.

[Severity: High]
This is a pre-existing issue, but check_atom_bios() appears to have off-by-=
one
boundary checks that can allow out-of-bounds memory reads when evaluating
malformed or truncated VBIOS images:

drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c:check_atom_bios() {
    ...
	if (!bios || size < 0x49) {
		dev_dbg(adev->dev, "VBIOS mem is null or mem size is wrong\n");
		return false;
	}

	...

	bios_header_start =3D bios[0x48] | (bios[0x49] << 8);
    ...
}

If size is exactly 0x49 (73 bytes), the check size < 0x49 passes, but the c=
ode
then accesses bios[0x49], which is the 74th byte, resulting in a 1-byte
out-of-bounds read.

There is another similar boundary check later in the same function:

drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c:check_atom_bios() {
    ...
	tmp =3D bios_header_start + 4;
	if (size < tmp) {
		dev_dbg(adev->dev, "VBIOS header is broken\n");
		return false;
	}

	if (!memcmp(bios + tmp, "ATOM", 4) ||
    ...
}

If the buffer size is exactly equal to tmp, size < tmp passes, but the
subsequent memcmp() reads 4 bytes starting at tmp, which is completely past
the end of the allocated buffer. Can these boundary checks be updated to
prevent KASAN out-of-bounds warnings when parsing VBIOS blobs?

> +				dev_info(adev->dev, "Fetched VBIOS from firmware file %s\n",
> +					 fw_name);
> +				goto success;
> +			}
> +		}
> +	}
> +
>  	dev_err(adev->dev, "Unable to locate a BIOS ROM\n");
>  	return false;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260621173211.2844=
3-1-oz@shift-computing.de?part=3D1
