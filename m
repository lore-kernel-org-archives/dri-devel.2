Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9155D606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 10:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cKDz5tdi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F222E10E596;
	Fri, 30 Oct 2026 10:19:43 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6516F10E596
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 10:19:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4AFF740DBF
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 10:19:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 151BA1F000C1;
 Fri, 30 Oct 2026 10:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793355577;
 bh=I0309l1pvXOnSsqMwvhXayNC2pcyeXI32/WDJehDI6U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cKDz5tdii9O8kxRFi4SjoIiAvHLQGa3znALEy1d3fnBkxtSg5iueM5mWq79aoQjLR
 B+XnGfqa+9MaDO/WZRRU7IM2mkfRTfwwR6jmErg2lhE4teEWOeYdpDh40uPkANQhJK
 MGzZxti8O1JtoT2w3+ajJ1r0dv9s7xPHMalqDpI4omLfTBszH02dkEo2zwAa+TcvpV
 WS4OMjLmIEymDeZqRi+e2JFvDBUEaLSDl2zZJHmwPE0hp+yFZTfdX6s8gLE2QpczAe
 O7cT3eyC8r16DZlfkpJu42eexP8v9SnowoDz4gRMMAzzlycGJjCPa+0m9Z1ZY9Wobx
 EvKAADTjzcMCQ==
Message-ID: <sashiko-outbox-190822@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/8] drm/msm/a6xx: Add IFPC tables for Adreno 640/680
To: "Konrad Dybcio" <konradybcio@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261030-topic-a6xx_ifpc-v1-6-6992841a9a32@oss.qualcomm.com>
References: <20261030-topic-a6xx_ifpc-v1-0-6992841a9a32@oss.qualcomm.com>
 <20261030-topic-a6xx_ifpc-v1-6-6992841a9a32@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 10:19:36 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] drm/msm/a6xx: Adreno 680 omitted from WFI config in a6xx_set_hwc=
g()
- [Medium] drm/msm/a6xx: perfcntr SELECT regs lost across IFPC on A6xx
--

commit bea4548efa02d7657c1bf9c8e91e5ce4b34bbd1a
Author: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

drm/msm/a6xx: Add IFPC tables for Adreno 640/680

This commit adds the powerup register list for Adreno 640 and 680 and
enables ADRENO_QUIRK_IFPC along with the IFPC and powerup register tables
in the catalog entries for both GPUs.

> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/=
msm/adreno/a6xx_catalog.c
> index 5e1d91a73a4e1..89829fa8f4f46 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c

[ ... ]

> @@ -1115,7 +1152,8 @@ static const struct adreno_info a6xx_gpus[] =3D {
>  		},
>  		.gmem =3D SZ_1M,
>  		.quirks =3D ADRENO_QUIRK_HAS_CACHED_COHERENT |
> -			  ADRENO_QUIRK_4GB_VA,
> +			  ADRENO_QUIRK_4GB_VA |
> +			  ADRENO_QUIRK_IFPC,
>  		.inactive_period =3D DRM_MSM_INACTIVE_PERIOD,
>  		.funcs =3D &a6xx_gpu_funcs,
>  		.zapfw =3D "a640_zap.mdt",
> @@ -1124,6 +1162,8 @@ static const struct adreno_info a6xx_gpus[] =3D {
>  			.protect =3D &a630_protect,
>  			.gmu_cgc_mode =3D 0x00020202,
>  			.prim_fifo_threshold =3D 0x00180000,
> +			.ifpc_reglist =3D &a630_ifpc_reglist,
> +			.pwrup_reglist =3D &a640_pwrup_reglist,

[Severity: Medium]
When global performance counter streaming (MSM_PERFCNTR_STREAM) is active
via DRM_IOCTL_MSM_PERFCNTR_CONFIG, sample_worker() only inhibits IFPC while
reading the counter registers and re-enables IFPC between sampling
intervals, relying on pwrup_reglist to restore the configured SELECT
registers on IFPC exit.

However, in drivers/gpu/drm/msm/adreno/a6xx_gpu.c,
a6xx_perfcntr_configure() only populates pwrup_reglist_ptr on A7xx:

	if (to_adreno_gpu(gpu)->info->family >=3D ADRENO_7XX_GEN1) {
		WARN_ON(!a6xx_gpu->pwrup_reglist_emitted);

		struct cpu_gpu_lock *lock =3D a6xx_gpu->pwrup_reglist_ptr;
		...

With ADRENO_QUIRK_IFPC enabled on Adreno 640 and 680, won't GX power
collapse during IFPC reset the performance counter SELECT registers without
SQE restoring them when exiting IFPC?

>  		},
>  		.speedbins =3D ADRENO_SPEEDBINS(
>  			{ 0, 0 },
> @@ -1238,7 +1278,8 @@ static const struct adreno_info a6xx_gpus[] =3D {
>  		},
>  		.gmem =3D SZ_2M,
>  		.quirks =3D ADRENO_QUIRK_HAS_CACHED_COHERENT |
> -			  ADRENO_QUIRK_4GB_VA,
> +			  ADRENO_QUIRK_4GB_VA |
> +			  ADRENO_QUIRK_IFPC,
>  		.inactive_period =3D DRM_MSM_INACTIVE_PERIOD,
>  		.funcs =3D &a6xx_gpu_funcs,
>  		.zapfw =3D "a640_zap.mdt",
> @@ -1247,6 +1288,8 @@ static const struct adreno_info a6xx_gpus[] =3D {
>  			.protect =3D &a630_protect,
>  			.gmu_cgc_mode =3D 0x00020202,
>  			.prim_fifo_threshold =3D 0x00200200,
> +			.ifpc_reglist =3D &a630_ifpc_reglist,
> +			.pwrup_reglist =3D &a640_pwrup_reglist,

[Severity: Medium]
During hardware initialization (hw_init() -> a6xx_set_hwcg()),
drivers/gpu/drm/msm/adreno/a6xx_gpu.c configures
REG_A6XX_GMU_CX_GMU_WFI_CONFIG based on the GPU revision:

	/* TODO: Also A620 */
	if (adreno_is_a640(adreno_gpu) || adreno_is_a650(adreno_gpu))
		gmu_wfi_config =3D 0x2;
	else
		gmu_wfi_config =3D 0;

	...
	gmu_write(&a6xx_gpu->gmu, REG_A6XX_GMU_CX_GMU_WFI_CONFIG,
			state ? gmu_wfi_config : 0);

Because adreno_is_a640() only matches revn 640 rather than
adreno_is_a640_family() (which matches ADRENO_6XX_GEN2 for both Adreno 640
and Adreno 680), Adreno 680 will program REG_A6XX_GMU_CX_GMU_WFI_CONFIG to
0 instead of 0x2 despite sharing a640_gmu.bin, a640_hwcg, gmu_cgc_mode, and
a640_pwrup_reglist with Adreno 640.

Should a6xx_set_hwcg() check adreno_is_a640_family(adreno_gpu) so that
Adreno 680 also sets gmu_wfi_config =3D 0x2 with IFPC enabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030-topic-a6xx=
_ifpc-v1-0-6992841a9a32@oss.qualcomm.com?part=3D6
