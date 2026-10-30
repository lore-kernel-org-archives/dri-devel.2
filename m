Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3205606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 10:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NnryI49d
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CBD910E87C;
	Fri, 30 Oct 2026 10:23:52 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAD1510E87C
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 10:23:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8D85D42A92
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 10:23:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ADCA1F000C1;
 Fri, 30 Oct 2026 10:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793355825;
 bh=eKnxHaSozVTafc3nNXWlkr60/mOmEM0mALOMcy2tFRc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NnryI49dQ8lLwwbwLLuRbY03RYZfU5vDjkOuCqRjGNOQgYxLrtswyGUk4U9Q1de7S
 GBQXoSfAheS+Ei6F6UPj+uwX03tKT/7ywMlbKJeIjAV9VBJ4qO3CpD3scfYInjXbG3
 +y3RiHoQkPXwjGc0z/fhMKKWQHcn5sDDqhroit2ktiyIZ8Ek7fmt5auJVfN9WArKKz
 eAejkkBSuowMne1aH5lWrCBOAQL6aUA2bW2YKutY0SEDqYtkMGapT+tjplaKwDuko5
 A0J1/WgN2ArPmWHZJBnFg5X3JAGXypUtTaZiJjoLWoKYl/Y1x9suWF8L6otRn5QY+h
 +k6A3hO+nNanA==
Message-ID: <sashiko-outbox-190826@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/8] drm/msm/a6xx: Add IFPC tables for Adreno 630
To: "Konrad Dybcio" <konradybcio@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261030-topic-a6xx_ifpc-v1-5-6992841a9a32@oss.qualcomm.com>
References: <20261030-topic-a6xx_ifpc-v1-0-6992841a9a32@oss.qualcomm.com>
 <20261030-topic-a6xx_ifpc-v1-5-6992841a9a32@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 10:23:44 +0000
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
- [Medium] drm/msm/a6xx: perfcntr select regs lost across IFPC on A630
- [Medium] drm/msm/a6xx: shutdown idle timeout in a6xx_gmu_shutdown() on A6=
30
--

commit e4f747633a2babaf9194dc940b8cefe42bf15c0f
Author: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

drm/msm/a6xx: Add IFPC tables for Adreno 630

This commit adds the IFPC and power-up register list tables for Adreno 630
and enables ADRENO_QUIRK_IFPC in its catalog entry.

> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/=
msm/adreno/a6xx_catalog.c
> index 4ef2bd6e7ad26..5e1d91a73a4e1 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c

[ ... ]

> @@ -1014,7 +1092,8 @@ static const struct adreno_info a6xx_gpus[] =3D {
>  		},
>  		.gmem =3D SZ_1M,
>  		.quirks =3D ADRENO_QUIRK_HAS_CACHED_COHERENT |
> -			  ADRENO_QUIRK_4GB_VA,
> +			  ADRENO_QUIRK_4GB_VA |
> +			  ADRENO_QUIRK_IFPC,

[Severity: Medium]
Does enabling ADRENO_QUIRK_IFPC on Adreno 630 cause a6xx_gmu_shutdown() to
time out waiting for idle when the GPU is runtime-resumed and suspended
without running hw_init()?

On Adreno 630 (ADRENO_6XX_GEN1), a6xx_gmu_init() sets gmu->legacy =3D true,=
 and
with ADRENO_QUIRK_IFPC set it now also configures gmu->idle_level =3D
GMU_IDLE_STATE_IFPC. When the GPU is resumed via
a6xx_gmu_pm_resume() -> a6xx_gmu_resume() -> a6xx_gmu_fw_start(),
a6xx_gmu_gfx_rail_on() asserts GMU_OOB_BOOT_SLUMBER:

drivers/gpu/drm/msm/adreno/a6xx_gmu.c:a6xx_gmu_gfx_rail_on() {
	...
	/* Let the GMU know the boot sequence has started */
	return a6xx_gmu_set_oob(gmu, GMU_OOB_BOOT_SLUMBER);
}

Normally, GMU_OOB_BOOT_SLUMBER is cleared at the end of hw_init():

drivers/gpu/drm/msm/adreno/a6xx_gpu.c:hw_init() {
	...
	if (a6xx_gpu->gmu.legacy) {
		/* Take the GMU out of its special boot mode */
		a6xx_gmu_clear_oob(&a6xx_gpu->gmu, GMU_OOB_BOOT_SLUMBER);
	}
}

However, if the GPU is woken without running msm_gpu_hw_init() (for example,
when userspace queries MSM_PARAM_TIMESTAMP in adreno_get_param() or
configures sysprof in msm_context_set_sysprof()), adreno_gpu->base.needs_hw=
_init
remains true when runtime suspend calls a6xx_gmu_shutdown():

drivers/gpu/drm/msm/adreno/a6xx_gmu.c:a6xx_gmu_shutdown() {
	...
	if (adreno_gpu->base.needs_hw_init) {
		if (a6xx_gmu_set_oob(&a6xx_gpu->gmu, GMU_OOB_GPU_SET))
			goto force_off;

		a6xx_gmu_clear_oob(&a6xx_gpu->gmu, GMU_OOB_GPU_SET);
	}

	if (test_and_clear_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status))
		a6xx_gmu_clear_oob(gmu, GMU_OOB_PERFCOUNTER_SET);

	ret =3D a6xx_gmu_wait_for_idle(gmu);
	if (ret)
		goto force_off;
}

Because a6xx_gmu_shutdown() does not clear GMU_OOB_BOOT_SLUMBER when
needs_hw_init is true on a legacy GMU, the GX rail stays powered on while
a6xx_gmu_wait_for_idle() -> a6xx_gmu_check_idle_level() polls for
GMU_IDLE_STATE_IFPC and !adreno_gpu->funcs->gx_is_on(adreno_gpu), which tim=
es
out and falls back to force_off.

>  		.inactive_period =3D DRM_MSM_INACTIVE_PERIOD,
>  		.funcs =3D &a6xx_gpu_funcs,
>  		.zapfw =3D "a630_zap.mdt",
> @@ -1023,6 +1102,8 @@ static const struct adreno_info a6xx_gpus[] =3D {
>  			.protect =3D &a630_protect,
>  			.gmu_cgc_mode =3D 0x00020202,
>  			.prim_fifo_threshold =3D 0x00180000,
> +			.ifpc_reglist =3D &a630_ifpc_reglist,
> +			.pwrup_reglist =3D &a630_pwrup_reglist,

[Severity: Medium]
With IFPC enabled on Adreno 630, will performance counter select registers
configured for global performance counter streaming (MSM_PERFCNTR_STREAM) be
lost across IFPC power collapse?

Commit 632ad5510114 ("drm/msm/a6xx: Restore perfcntr Selects on IFPC") chan=
ged
msm_gpu_sysprof_no_ifpc() to only check refcount_read(&gpu->sysprof_active)=
 > 1,
allowing IFPC while gpu->perfcntrs->stream is active and relying on
a6xx_perfcntr_configure() to append the configured select registers to
pwrup_reglist so the CP restores them on IFPC exit.

However, a6xx_perfcntr_configure() only populates reglist for ADRENO_7XX_GE=
N1
and newer:

drivers/gpu/drm/msm/adreno/a6xx_gpu.c:a6xx_perfcntr_configure() {
	...
	if (to_adreno_gpu(gpu)->info->family >=3D ADRENO_7XX_GEN1) {
		WARN_ON(!a6xx_gpu->pwrup_reglist_emitted);

		struct cpu_gpu_lock *lock =3D a6xx_gpu->pwrup_reglist_ptr;
		int off =3D (2 * lock->ifpc_list_len) +
			  (2 * lock->preemption_list_len) +
			  (3 * a6xx_gpu->dynamic_sel_reglist_offset);

		reglist =3D (uint32_t *)&lock->regs[0];
		reglist +=3D off;
		reglist_sel_start =3D reglist;
		...
	}
}

Similarly, a6xx_patch_pwrup_reglist() populates the A6xx 2-dword
(offset, value) list in lock->list_length without tracking dynamic select
register entries. On Adreno 630 (ADRENO_6XX_GEN1), reglist remains NULL in
a6xx_perfcntr_configure(), so entering IFPC between sample intervals will
reset the PERFCTR_*_SEL registers without restoring them on wakeup.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030-topic-a6xx=
_ifpc-v1-0-6992841a9a32@oss.qualcomm.com?part=3D5
