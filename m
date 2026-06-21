Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B1CCD98F2
	for <dri-devel@archiver.kernel.org>; Sun, 21 Jun 2026 18:09:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F8DA10E274;
	Sun, 21 Jun 2026 18:09:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Km8fJVnF";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 283A210E274
 for <dri-devel@lists.freedesktop.org>; Sun, 21 Jun 2026 18:09:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5DEAE600AF;
 Sun, 21 Jun 2026 18:09:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAE191F00A3A;
 Sun, 21 Jun 2026 18:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782065359;
 bh=KxPk12pqGYP3g46kiWFLxAA88Xb09t2QWbvRtW6UcvU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Km8fJVnFE86qvnRD6urnCvLFJ3un+TWS0vU8IYVap5PKgnwK2bkx/Ea4lwUjZsOOF
 CU2zVmfclewYvao3RxIrrD/o36/cncuQRydlpNrZeiNqPPwJs7ICPvkRdnNyFmDZ79
 O1DMuArm/JQTVuSG2DJcHpuCmP3zBGABL4Db5wE+uEzceUAdO8AMcb3xwVOG3iyonO
 7ZcIrj1E/KkaanLhigbDzopUtt+iTqyaIRIBKhiBLsW8px73sU0q6A1tLHMBmi8l0s
 JeSgEUjsfL6i+iAbIFYM8m16KCSUwQRS3HVA0MYshVbnXFjt80+Uee/p4aDrquJiu9
 2FM3YDkqjP4Rw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amd/amdgpu: add firmware file fallback for APU
 VBIOS discovery
To: "Oz Tiram" <oz@shift-computing.de>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260621180154.30421-1-oz@shift-computing.de>
References: <20260621173211.28443-1-oz@shift-computing.de>
 <20260621180154.30421-1-oz@shift-computing.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 21 Jun 2026 18:09:18 +0000
Message-Id: <20260621180918.EAE191F00A3A@smtp.kernel.org>
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
- [High] Out-of-bounds reads in `check_atom_bios` when validating VBIOS hea=
ders, made directly reachable via the new user-supplied firmware file fallb=
ack.
--

commit a2fe12b488b874804f022bf152336e0c586847dc
Author: Oz Tiram <oz@shift-computing.de>

drm/amd/amdgpu: add firmware file fallback for APU VBIOS discovery

This commit adds a fifth fallback method to discover an APU VBIOS by
requesting a firmware file when all other methods fail. The fallback uses
request_firmware() and allocates the VBIOS buffer using kmemdup() with the
exact firmware size.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_bios.c
> index aa039e148a5ee..86064c753b099 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
[ ... ]
> @@ -457,6 +458,28 @@ static bool amdgpu_get_bios_apu(struct amdgpu_device=
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

[Severity: High]
This isn't a bug introduced by this patch, but allocating the buffer to the
exact firmware size via kmemdup() exposes existing out-of-bounds reads in
check_atom_bios().

Looking at check_atom_bios(), the initial size check is:

    if (!bios || size < 0x49) {
        ...
        return false;
    }

But then it reads bios[0x49]:

    bios_header_start =3D bios[0x48] | (bios[0x49] << 8);

If fw_size is exactly 0x49, bios[0x49] reads 1 byte past the end of the
kmemdup() buffer.

Similarly, check_atom_bios() later checks size against tmp before reading
4 bytes for the ATOM signature:

    tmp =3D bios_header_start + 4;
    if (size < tmp) {
        ...
        return false;
    }

    if (!memcmp(bios + tmp, "ATOM", 4) ||
        !memcmp(bios + tmp, "MOTA", 4)) {

If size is exactly tmp (or up to tmp + 3), memcmp() will read up to 4 bytes
past the end of the allocation.=20

Could a malformed firmware file loaded through this new path trigger KASAN
slab-out-of-bounds warnings or page faults due to these bounds checks?

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
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260621180154.3042=
1-1-oz@shift-computing.de?part=3D1
