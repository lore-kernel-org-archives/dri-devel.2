Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A7ECC624DB
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 15:15:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88A4910E652;
	Sat,  5 Sep 2026 15:15:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jKxmvv2g";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86D0110E652
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 15:15:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 07D5B406B5;
 Sat,  5 Sep 2026 15:15:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B228F1F00A3A;
 Sat,  5 Sep 2026 15:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788621323;
 bh=FEbp4ecDZQjhGUT5o9cCcDFsiWpqKwwgRCsfPMRbSIg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jKxmvv2gF/tEa60gPPNKsuTvbYnU8dWAnX+F2MKBFFqMMJFDcAISzUBlRhLI2xqxz
 lUFzjI/bxKmELSoSssAQKVBtJmpzMXLPElnwa3jRyC83ezzIeuMooKe0oUTiI6U7lc
 dvz9/naq0C1V534eYEMcgLlYs4WyjWhUqGu4ITFQbOnnNeeFbehOo3eYPua536gMkt
 zIbpQev6JahIJBXCsUi3h0k16eFua0I7bd265CFgf/nNifISul/YKwyYSMsrE2kzDR
 ef/NsMlDrEdVvO9liNlMSKNRQjJ5sXl1mf9hQ8ZIFBoeDH48yuOtJtyqxON5F6f3JU
 vnFE33h+8Rk/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdgpu/gfx8: fix register_list_format leak in
 gfx_v8_0_init_microcode
To: "Willian Oliveira" <williandossantosdeoliveira287@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260905133405.3733-1-williandossantosdeoliveira287@gmail.com>
References: <20260905133405.3733-1-williandossantosdeoliveira287@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 15:15:23 +0000
Message-Id: <20260905151523.B228F1F00A3A@smtp.kernel.org>
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
- [Critical] Missing bounds checking and potential integer overflow in firm=
ware header parsing leading to a heap buffer overflow.
--

commit 85ca74ba24e5f9c96f4d94f3bcb428aa05e58c7a
Author: Willian Oliveira <williandossantosdeoliveira287@gmail.com>

drm/amdgpu/gfx8: fix register_list_format leak in gfx_v8_0_init_microcode
   =20
gfx_v8_0_init_microcode() allocates rlc.register_list_format before
loading the MEC firmware.

If loading one of the subsequent firmware files fails, the function
returns through the error path without freeing register_list_format.

Use gfx_v8_0_free_microcode() in the error path so all previously
allocated firmware resources, including register_list_format, are
released.

> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v8_0.c
> index 6cf4279950787..92c56d811975c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -1211,12 +1211,7 @@ static int gfx_v8_0_init_microcode(struct amdgpu_d=
evice *adev)
>  out:
>  	if (err) {
>  		dev_err(adev->dev, "gfx8: Failed to load firmware %s gfx firmware\n", =
chip_name);
> -		amdgpu_ucode_release(&adev->gfx.pfp_fw);
> -		amdgpu_ucode_release(&adev->gfx.me_fw);
> -		amdgpu_ucode_release(&adev->gfx.ce_fw);
> -		amdgpu_ucode_release(&adev->gfx.rlc_fw);
> -		amdgpu_ucode_release(&adev->gfx.mec_fw);
> -		amdgpu_ucode_release(&adev->gfx.mec2_fw);
> +		gfx_v8_0_free_microcode(adev);

[Severity: Critical]
This is a pre-existing issue, but while reviewing this function's error
handling, I noticed a potential integer overflow in the allocation of
register_list_format higher up in gfx_v8_0_init_microcode():

	adev->gfx.rlc.reg_list_format_size_bytes =3D
			le32_to_cpu(rlc_hdr->reg_list_format_size_bytes);
	adev->gfx.rlc.reg_list_size_bytes =3D
			le32_to_cpu(rlc_hdr->reg_list_size_bytes);

	adev->gfx.rlc.register_list_format =3D
			kmalloc(adev->gfx.rlc.reg_list_format_size_bytes +
					adev->gfx.rlc.reg_list_size_bytes, GFP_KERNEL);

Are we sure reg_list_format_size_bytes and reg_list_size_bytes can't overfl=
ow
when added together?

If a maliciously crafted RLC firmware provides large values for these two
variables, the 32-bit addition could wrap around, resulting in a very small
allocation.

Because the subsequent loops iterate over the original un-overflowed values
like this:

	for (i =3D 0 ; i < (adev->gfx.rlc.reg_list_format_size_bytes >> 2); i++)
		adev->gfx.rlc.register_list_format[i] =3D le32_to_cpu(tmp[i]);

could this cause out-of-bounds writes into the undersized heap buffer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905133405.3733=
-1-williandossantosdeoliveira287@gmail.com?part=3D1
