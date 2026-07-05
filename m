Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D924C43458
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 10:14:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABAA789A1F;
	Sun,  5 Jul 2026 10:14:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JFc23Vx5";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76C3F89E1D
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 10:14:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8964A60052;
 Sun,  5 Jul 2026 10:14:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 173CD1F000E9;
 Sun,  5 Jul 2026 10:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783246491;
 bh=HJ+ro5FBoWIR77oSosh2AeXzwrnlL5pDe69IJegqKNs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JFc23Vx5jfJwKAO5rmXkLUduAjJEop1JtgxsRdrUJLPnHfmE42FyxJJf9B+teLEHn
 jtjxuqxgQ3O9pc0SBqLHoTgzV7a2ML3BzR+rI2gCueU0dQjolJ1y4CWXGwh9r2aJZE
 wRGUY6Irjs9fBYy9ZrFKoj2UtKuDtJ4Tzoo973q5HMGUcfMcAljU+r8+O5vqmqpiyS
 p+DRsVe+lQBUipwN8VJM/FIhlyc8Z9HrL5OEZQ8490I0dMNi5T899mD3Chl61JZkVN
 gDG5lhvWqGf8vztIpGaTBm233wgh0IohI2Sz54BEspAlqPUBZ58WJ0l1PW1NyDANvy
 VTu3xpnGxAfFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/amd/amdgpu: add firmware file fallback for APU
 VBIOS discovery
To: "Oz Tiram" <oz@shift-computing.de>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260705100436.6877-1-oz@shift-computing.de>
References: <716a31c5-0484-4ef9-b49e-b71310f92d86@amd.com>
 <20260705100436.6877-1-oz@shift-computing.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 05 Jul 2026 10:14:50 +0000
Message-Id: <20260705101451.173CD1F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Insufficient size bounds checks in `check_atom_bios()` lead to out=
-of-bounds memory reads when validating the VBIOS image.
--

commit f277c5eb3a5ff47c43a2c9dc08a427a7be71788e
Author: Oz Tiram <oz@shift-computing.de>

drm/amd/amdgpu: add firmware file fallback for APU VBIOS discovery

This patch adds a fallback method to load the APU VBIOS from a firmware file
when all other discovery methods (VFCT, VRAM BAR, ROM BAR, platform BIOS)
fail. This allows hybrid graphics systems with incorrect ACPI metadata to
initialize successfully by placing an extracted VBIOS in the firmware path.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_bios.c
> index 3ebdd792feec1..64b226cb17e3a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c

[ ... ]

> @@ -463,6 +464,28 @@ static bool amdgpu_get_bios_apu(struct amdgpu_device=
 *adev)
>  		goto success;
>  	}
> =20
> +	{
> +		const struct firmware *fw;
> +		char fw_name[32];
> +		size_t fw_size;
> +
> +		snprintf(fw_name, sizeof(fw_name), "amdgpu/%04x_%04x.bin",
> +			 adev->pdev->vendor, adev->pdev->device);
> +		if (request_firmware(&fw, fw_name, adev->dev) =3D=3D 0) {
> +			adev->bios =3D kmemdup(fw->data, fw->size, GFP_KERNEL);
> +			fw_size =3D fw->size;
> +			release_firmware(fw);
> +			if (!adev->bios || !check_atom_bios(adev, fw_size)) {
                                                           ^^^^^^^^^^^^^^^^=
^^

[Severity: High]
This isn't a bug introduced by this patch, but passing an arbitrary firmware
file size to check_atom_bios() can trigger out-of-bounds reads due to
insufficient bounds checks in that function.

If the firmware file size is exactly 73 bytes (size =3D=3D 0x49), the initi=
al
check in check_atom_bios() passes:

check_atom_bios() {
	...
	if (!bios || size < 0x49) {
		...
		return false;
	}
	...

However, the subsequent header read accesses bios[0x49], which is 1 byte
past the end of a 73-byte buffer:

	...
	bios_header_start =3D bios[0x48] | (bios[0x49] << 8);
	...

Similarly, if the firmware size is equal to tmp, the length check passes:

	...
	tmp =3D bios_header_start + 4;
	if (size < tmp) {
		...
		return false;
	}
	...

But the memcmp() that follows will read 4 bytes starting exactly at the
end of the allocated buffer:

	...
	if (!memcmp(bios + tmp, "ATOM", 4) ||
	    !memcmp(bios + tmp, "MOTA", 4)) {
	...

Could this lead to memory safety issues if a malformed firmware file is
provided? Should the checks in check_atom_bios() be updated to ensure size
is strictly greater than 0x49, and that size >=3D tmp + 4 before the memcmp=
()
evaluation?

> +				amdgpu_bios_release(adev);
> +			} else {
> +				adev->bios_size =3D fw_size;
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705100436.6877=
-1-oz@shift-computing.de?part=3D1
