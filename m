Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92870CD98D5
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 06:47:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E700210F2A0;
	Fri, 12 Jun 2026 06:47:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dvZpX+st";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90F5710F2A0
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 06:47:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EC6AB6001D;
 Fri, 12 Jun 2026 06:47:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760D81F000E9;
 Fri, 12 Jun 2026 06:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781246852;
 bh=qoHE8vA0FRK/tiM2Ch1l6c0H7HjUzkRM79/O6myVYqs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dvZpX+stxN5lI1LWeXtXFxwXxH7eezU2VrL31cT6MgNId9+hBoDaTpzi5bA9+IuSf
 tFa4MkDXxF/LyVDK6dLRcxrWoh2I0/8ccxmE8fKY7EkjMd6VhE1DyVLhtkANpSwnVE
 p0ISWpj8JyLB4dwctC6gTuI3itaalIcSMIPAgShLguomy8avrjzXKhy3Fcgl4V3RM7
 U8nShUDCEhc3Bnj5EcarxKmc0AZz06Z+Ku4ITrFPodXoo+PV87igM1eFqsfiMhrLTZ
 R0MaMhhUxgZGhOlMuNOAPqbM6NTvgxQ84mjOSzkhj4ta8vKJb1dFN1552OXEOvZGaX
 3FXQ/R07qGWfA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/7] drm/tegra: vic: Add Tegra264 support
To: "Mikko Perttunen" <mperttunen@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260612-t264-host1x-v1-6-8d934987de67@nvidia.com>
References: <20260612-t264-host1x-v1-6-8d934987de67@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 06:47:32 +0000
Message-Id: <20260612064732.760D81F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Out-of-bounds read when parsing the RISC-V firmware descriptor.

Pre-existing issues:
- [High] Out-of-bounds read and potential crash when parsing internal offse=
ts from the loaded firmware image.
- [High] Use-After-Free in error paths of `vic_load_firmware()` due to dang=
ling pointer.
--

commit e93ea0b6d1fe675fec33102f35c8bdffae0a5687
Author: Mikko Perttunen <mperttunen@nvidia.com>

drm/tegra: vic: Add Tegra264 support

Add support for VIC on Tegra264. The Tegra264 VIC uses a RISC-V based
Falcon microcontroller instead of the traditional Falcon previously,
and has the TRANSCFG register in a different place.

> diff --git a/drivers/gpu/drm/tegra/vic.c b/drivers/gpu/drm/tegra/vic.c
> --- a/drivers/gpu/drm/tegra/vic.c
> +++ b/drivers/gpu/drm/tegra/vic.c
[ ... ]
> @@ -85,31 +92,50 @@ static int vic_boot(struct vic *vic)
>  			CG_WAKEUP_DLY_CNT(4),
>  		   NV_PVIC_MISC_PRI_VIC_CG);
[ ... ]
> +	} else {
> +		u32 fce_ucode_size, fce_bin_data_offset;
> +		void *hdr;
> +
> +		hdr =3D vic->falcon.firmware.virt;
> +		fce_bin_data_offset =3D *(u32 *)(hdr + VIC_UCODE_FCE_DATA_OFFSET);
> +
> +		/* Old VIC firmware needs kernel help with setting up FCE microcode. */
> +		if (fce_bin_data_offset !=3D 0x0 && fce_bin_data_offset !=3D 0xa5a5a5a=
5) {
> +			hdr =3D vic->falcon.firmware.virt +
> +				*(u32 *)(hdr + VIC_UCODE_FCE_HEADER_OFFSET);
> +			fce_ucode_size =3D *(u32 *)(hdr + FCE_UCODE_SIZE_OFFSET);

[Severity: High]
This is a pre-existing issue, but does this code perform an out-of-bounds
read when parsing internal offsets from the loaded firmware image?

It appears that nested offsets are read directly from the firmware image
without verifying that the firmware size is large enough, or that the
offsets point within the valid firmware boundaries. If a malformed or
truncated firmware file is provided, could this arbitrary offset lead to an
out-of-bounds read and a kernel page fault?

> +
> +			falcon_execute_method(&vic->falcon, VIC_SET_FCE_UCODE_SIZE,
> +					      fce_ucode_size);
> +			falcon_execute_method(
> +				&vic->falcon, VIC_SET_FCE_UCODE_OFFSET,
> +				(vic->falcon.firmware.iova + fce_bin_data_offset) >> 8);
> +		}
[ ... ]
> @@ -277,6 +303,8 @@ static int vic_load_firmware(struct vic *vic)
> =20
>  	if (!vic->config->supports_sid) {
>  		vic->can_use_context =3D false;
> +	} else if (vic->config->has_riscv) {
> +		vic->can_use_context =3D true;
>  	} else if (fce_bin_data_offset !=3D 0x0 && fce_bin_data_offset !=3D 0xa=
5a5a5a5) {
>  		/*
>  		 * Firmware will access FCE through STREAMID0, so context

[Severity: High]
This is a pre-existing issue, but can the error path in vic_load_firmware()
lead to a use-after-free?

If an error occurs during firmware loading, such as a failure in
falcon_load_firmware(), the cleanup path frees the allocated DMA memory
but seems to leave the firmware pointers dangling:

cleanup:
        if (!client->group)
                dma_free_coherent(vic->dev, size, virt, iova);
        else
                tegra_drm_free(tegra, size, virt, iova);

        mutex_unlock(&lock);
        return err;

If the device attempts to load the firmware again later, it might see
the non-null pointer, return success, and proceed to use the freed DMA
memory. Could this result in IOMMU faults and potential system crashes?

[ ... ]
> @@ -495,6 +537,7 @@ static int vic_probe(struct platform_device *pdev)
> =20
>  	vic->falcon.dev =3D dev;
>  	vic->falcon.regs =3D vic->regs;
> +	vic->falcon.riscv =3D vic->config->has_riscv;
> =20
>  	err =3D falcon_init(&vic->falcon);

[Severity: High]
Does enabling RISC-V support here expose an out-of-bounds read when
parsing the RISC-V firmware descriptor?

In falcon_parse_firmware_desc(), the descriptor data is cast to
struct falcon_fw_riscv_desc and fields at large offsets are read without
a preceding length check on the firmware size:

struct falcon_fw_riscv_desc *desc =3D
        (struct falcon_fw_riscv_desc *)falcon->firmware.desc_firmware->data;

falcon->firmware.code.offset =3D desc->code_offset;

If a truncated descriptor file is provided by userspace, could this
cause a buffer over-read and lead to a kernel page fault?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612-t264-host1=
x-v1-0-8d934987de67@nvidia.com?part=3D6
