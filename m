Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B463C79FAB
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 04:51:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D25E110E9DD;
	Tue,  8 Sep 2026 04:51:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CTcPqLsR";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 580EB10E9C1;
 Tue,  8 Sep 2026 04:51:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E502C43B54;
 Tue,  8 Sep 2026 04:51:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 963151F00A3A;
 Tue,  8 Sep 2026 04:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788843106;
 bh=RogFbCU75ldxus33sPR81N+DqP8PKDVBm2jsrCeUkHw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CTcPqLsRMBnC1TI9Ru5aLe9ckkyn6bb9Fz10D2R3Yz3AM3hNk7NjWIVxeDQYohWF5
 E2N92Q3ie8oqBOCuGESORX/htP3/LEhcbE3c/22z3D9Kt40wZitCmkFAsoCm232byh
 WZw17Rwl4SLa/5ckmwOwCMYcsS21RZn4BdGpwGD2DhOj5ln6cb1ziZlkCVnPEdC8oN
 O7PFt0WDwhWu5RAiaAmg2NKxYuyTso0A/ETfY5NuL+V+gKPPdy3A1LIKuweCHh3mN0
 /jRaMY7Njj9/RrQDv0K0TbA/yOIooQEKr9vpagTqVPR0CE6CShLpjr906qms2Ya6Yo
 6MBd6N9+2T2+g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 09/14] drm/amdgpu: Check bios_scratch_reg_offset in
 backlight level helper
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
In-Reply-To: <20260908044035.62093-10-mario.limonciello@amd.com>
References: <20260908044035.62093-1-mario.limonciello@amd.com>
 <20260908044035.62093-10-mario.limonciello@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 04:51:46 +0000
Message-Id: <20260908045146.963151F00A3A@smtp.kernel.org>
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
- [High] This problem wasn't introduced by this patch, but this patch provi=
des an incomplete fix. It adds a check for `!adev->bios_scratch_reg_offset`=
 in the backlight helper to prevent unmapped MMIO accesses, but fails to ad=
d this necessary safety check to several other functions that unconditional=
ly access scratch registers using the identical offset.
--

commit 23cd4f591b277fb308823be50c628e3526a8743e
Author: Mario Limonciello (AMD) <superm1@kernel.org>

drm/amdgpu: Check bios_scratch_reg_offset in backlight level helper

Ensure adev->bios_scratch_reg_offset is non-zero before accessing
scratch registers in amdgpu_atombios_scratch_regs_set_backlight_level()
to avoid dereferencing unmapped MMIO offsets.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_atombios.c
> index 27c0dc8f6137a..2d8c2ba04e670 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> @@ -1622,7 +1622,12 @@ void amdgpu_atombios_scratch_regs_engine_hung(stru=
ct amdgpu_device *adev,
>  void amdgpu_atombios_scratch_regs_set_backlight_level(struct amdgpu_devi=
ce *adev,
>  						      u32 backlight_level)
>  {
> -	u32 tmp =3D RREG32(adev->bios_scratch_reg_offset + 2);
> +	u32 tmp;
> +
> +	if (!adev->bios_scratch_reg_offset)
> +		return;
> +

[Severity: High]
This is a pre-existing issue, but while this patch adds a safety check here,
should we also add similar checks to other functions that access scratch
registers using the identical offset?=20

If the firmware info table is missing or fails to parse properly, leaving t=
he
offset at 0, these other paths are exposed to arbitrary MMIO writes:

In amdgpu_atombios_scratch_regs_engine_hung()
(drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c):
    u32 tmp =3D RREG32(adev->bios_scratch_reg_offset + 3);

In amdgpu_atombios_scratch_need_asic_init()
(drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c):
    u32 tmp =3D RREG32(adev->bios_scratch_reg_offset + 7);

In smu_v11_0_baco_set_state()
(drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c):
    WREG32(adev->bios_scratch_reg_offset + 6, 0);

Could this missing coverage lead to corrupting hardware state or triggering
machine check exceptions during GPU initialization, GPU reset, and BACO sta=
te
transitions if the offset is 0?

> +	tmp =3D RREG32(adev->bios_scratch_reg_offset + 2);
> =20
>  	tmp &=3D ~ATOM_S2_CURRENT_BL_LEVEL_MASK;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908044035.6209=
3-1-mario.limonciello@amd.com?part=3D9
