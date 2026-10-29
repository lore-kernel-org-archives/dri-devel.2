Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018B6606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 14:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OnWgn9kb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F09C11234F;
	Thu, 29 Oct 2026 14:33:28 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4E0311234F
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 14:33:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8899940808;
 Thu, 29 Oct 2026 14:33:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 324D21F01825;
 Thu, 29 Oct 2026 14:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793284402;
 bh=sZeo/FDHvRmMrSw89uBLRUSgC6xoljRlrhmh8tIp1DM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OnWgn9kbRpQkIa8oJ2JQzhyU+CQe7e+RT3D4OIKvvunzCVtGxrwsJs2NgAS0jB1RC
 14SSzA2R8ahHPG2K9ZEtZeWqEZDWu0mvWkC3qXVl5tqCHi9xCv3CrhBci6/3fnB0vq
 ABlyecjJwWtWF3DIJl02VxFZFPxk7th0DkRCDf7148w5Zzg07rJS6Aik2f4H4xgbM2
 5ZwpsWu6iY6TT7c5ulLOuoy/Sfd+Ys3vW/zMJ5/QsOmDhEqBd48oqapzJZnUGwHOYR
 p3D/0TuI86P7lrz51yfSrjmHaLYnuaL77c5VL4j3a1Z8kmr+ds/ARTJTn6vRGdChsu
 wgriXrynVp5sA==
Message-ID: <sashiko-outbox-189527@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 09/14] drm/msm: initialize LPAC ring
To: "Anna Maniscalco" <anna.maniscalco2000@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261029-descriptive-name-lpac-upstream-v2-9-a21a5c850961@gmail.com>
References: <20261029-descriptive-name-lpac-upstream-v2-0-a21a5c850961@gmail.com>
 <20261029-descriptive-name-lpac-upstream-v2-9-a21a5c850961@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 14:33:21 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] drm/msm: adreno_gpu_init() enables LPAC without checking lpac_pdev
- [Medium] drm/msm/a6xx: shadow RPTR size and clear mismatch on preempt ini=
t fallback
- [Medium] drm/msm/a6xx: unhalted LPAC SQE in a6xx_recover() and a6xx_gpu_s=
tate_get()
- [Medium] drm/msm/a6xx: missing LPAC GX registers in A7xx IFPC/pwrup regli=
sts
--

commit 35ad03732804997c43b27fa187ec0be66e34e69c
Author: Anna Maniscalco <anna.maniscalco2000@gmail.com>

drm/msm: initialize LPAC ring

This commit programs the hardware registers required to start the LPAC ring
and sends the CP initialization sequence. It also updates ringbuffer
management, fence retirement, and scheduler suspend/resume paths to account
for the live LPAC ring.

> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/=
msm/adreno/a6xx_catalog.c
> index 3e6f409d13a2a..5ee00eead14c8 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> @@ -1394,6 +1394,7 @@ static const u32 a750_ifpc_reglist_regs[] =3D {
>  	REG_A6XX_SP_NC_MODE_CNTL,
>  	REG_A6XX_CP_DBG_ECO_CNTL,
>  	REG_A6XX_CP_PROTECT_CNTL,
> +	REG_A6XX_CP_LPAC_PROTECT_CNTL,

[Severity: Medium]
Should the other GX domain registers programmed for LPAC in hw_init() in
drivers/gpu/drm/msm/adreno/a6xx_gpu.c also be added to the A7xx IFPC and
power-up restore lists?

Specifically, hw_init() configures these registers when gpu->lpac_rb is
present:

drivers/gpu/drm/msm/adreno/a6xx_gpu.c:hw_init() {
	if (gpu->lpac_rb)
		gpu_rmw(gpu, REG_A6XX_UCHE_DEBUG_CNTL_1, BIT(30), BIT(30));
	...
	if (gpu->lpac_rb) {
		gpu_write(gpu, REG_A7XX_CP_LPAC_CHICKEN_DBG, 0x1);

		gpu_write(gpu, REG_A7XX_SP_CHICKEN_BITS_2, BIT(4));
		gpu_write(gpu, REG_A7XX_SP_LPAC_CHICKEN_BITS_2, BIT(4));
	}
}

On IFPC-capable A7xx targets such as Adreno 750, the GX power domain
collapses across IFPC without re-running hw_init(), and the CP only restores
registers recorded in a750_ifpc_reglist_regs and a7xx_pwrup_reglist_regs by
a7xx_patch_pwrup_reglist(). Because REG_A6XX_UCHE_DEBUG_CNTL_1,
REG_A7XX_CP_LPAC_CHICKEN_DBG, REG_A7XX_SP_CHICKEN_BITS_2, and
REG_A7XX_SP_LPAC_CHICKEN_BITS_2 are not in those lists, won't their LPAC
settings revert to reset defaults after the first IFPC cycle?

[ ... ]

> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/=
adreno/a6xx_gpu.c
> index 8b3bb2fd433ba..e7bc12de650ca 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c

[ ... ]

> @@ -1096,7 +1162,7 @@ static int a6xx_ucode_load(struct msm_gpu *gpu)
>  	if ((adreno_gpu->base.hw_apriv || a6xx_gpu->has_whereami) &&
>  	    !a6xx_gpu->shadow_bo) {
>  		a6xx_gpu->shadow =3D msm_gem_kernel_new(gpu->dev,
> -						      sizeof(u32) * gpu->nr_rings,
> +						      sizeof(u32) * (gpu->nr_rings + !!gpu->lpac_rb),
>  						      MSM_BO_WC | MSM_BO_MAP_PRIV,
>  						      gpu->vm, &a6xx_gpu->shadow_bo,
>  						      &a6xx_gpu->shadow_iova);

[ ... ]

> @@ -1451,7 +1533,10 @@ static int hw_init(struct msm_gpu *gpu)
>  	if (a6xx_gpu->shadow_bo) {
>  		gpu_write64(gpu, REG_A6XX_CP_RB_RPTR_ADDR,
>  			shadowptr(a6xx_gpu, gpu->rb[0]));
> -		for (unsigned int i =3D 0; i < gpu->nr_rings; i++)
> +		if (gpu->lpac_rb)
> +			gpu_write64(gpu, REG_A7XX_CP_LPAC_RB_RPTR_ADDR,
> +				shadowptr(a6xx_gpu, gpu->lpac_rb));
> +		for (unsigned int i =3D 0; i < (gpu->nr_rings + !!gpu->lpac_rb); i++)
>  			a6xx_gpu->shadow[i] =3D 0;
>  	}

[Severity: Medium]
Can a6xx_gpu->shadow[] be indexed past gpu->nr_rings + !!gpu->lpac_rb if
a6xx_preempt_init() falls back to a single ring?

During initialization in a6xx_gpu_init() -> adreno_gpu_init() ->
msm_gpu_init(), gpu->lpac_rb is created with ring->id set to nr_rings (4 wh=
en
preemption is enabled):

drivers/gpu/drm/msm/msm_gpu.c:msm_gpu_init() {
	if (config->has_lpac) {
		gpu->lpac_rb =3D msm_ringbuffer_new(gpu, nr_rings, memptrs, memptrs_iova);
}

After msm_gpu_init() returns, a6xx_gpu_init() calls a6xx_preempt_init(),
which falls back to gpu->nr_rings =3D 1 on allocation failure without updat=
ing
gpu->lpac_rb->id:

drivers/gpu/drm/msm/adreno/a6xx_preempt.c:a6xx_preempt_init() {
fail:
	/*
	 * On failure to init preemption, fall back to a single
	 * ring (ie. no preemption)
	 */
	a6xx_preempt_fini(gpu);
	gpu->nr_rings =3D 1;
}

When adreno_load_gpu() then calls a6xx_ucode_load() and hw_init(),
a6xx_gpu->shadow is sized for only 2 entries (gpu->nr_rings + !!gpu->lpac_r=
b)
and hw_init() only zeroes indices 0 and 1. However, shadowptr(a6xx_gpu,
gpu->lpac_rb) and a6xx_get_rptr() still index a6xx_gpu->shadow[ring->id] at
index 4:

drivers/gpu/drm/msm/adreno/a6xx_gpu.c:a6xx_get_rptr() {
	if (adreno_gpu->base.hw_apriv || a6xx_gpu->has_whereami)
		return a6xx_gpu->shadow[ring->id];
}

On subsequent hw_init() calls during runtime resume or GPU recovery, index 4
is not zeroed and retains its stale RPTR value (8 from the 8-dword CP_ME_IN=
IT
packet in lpac_cp_init()), which causes adreno_idle() to see get_rptr() =3D=
=3D
wptr and return before the LPAC CP has drained CP_ME_INIT.

> =20
> @@ -1469,9 +1554,17 @@ static int hw_init(struct msm_gpu *gpu)
>  	for (i =3D 0; i < gpu->nr_rings; i++)
>  		gpu->rb[i]->cur_ctx_seqno =3D 0;
> =20
> +	if (gpu->lpac_rb)
> +		gpu->lpac_rb->cur_ctx_seqno =3D 0;
> +
>  	/* Enable the SQE_to start the CP engine */
>  	gpu_write(gpu, REG_A6XX_CP_SQE_CNTL, 1);
> =20
> +	/* Enable the LPAC SQE_to start the CP engine */
> +	//TODO is this needed? Doesn't fw do this at init?
> +	if (gpu->lpac_rb)
> +		gpu_write(gpu, REG_A6XX_CP_LPAC_SQE_CNTL, 1);

[Severity: Medium]
Now that REG_A6XX_CP_LPAC_SQE_CNTL is enabled here, should a6xx_recover() in
drivers/gpu/drm/msm/adreno/a6xx_gpu.c and a6xx_gpu_state_get() in
drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c also halt the LPAC SQE by writi=
ng
3 to REG_A6XX_CP_LPAC_SQE_CNTL when gpu->lpac_rb is present?

Currently, a6xx_recover() and a6xx_gpu_state_get() only halt
REG_A6XX_CP_SQE_CNTL:

drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c:a6xx_gpu_state_get() {
	/* Halt SQE first */
	gpu_write(gpu, REG_A6XX_CP_SQE_CNTL, 3);
}

Leaving the LPAC SQE running while a6xx_gpu_state_get() reads indexed LPAC =
CP
registers (such as CP_LPAC_DRAW_STATE, CP_LPAC_ROQ_DBG, CP_SQE_AC_UCODE_DBG,
CP_SQE_AC_STAT, and CP_LPAC_FIFO_DBG) and executes the crashdumper, or while
a6xx_recover() prepares for reset, could result in inconsistent crash dump
state or ongoing LPAC CP activity during recovery.

[ ... ]

> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/ms=
m/adreno/adreno_gpu.c
> index 4389559e1d172..085e1b9044bc7 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c

[ ... ]

> @@ -1253,6 +1261,8 @@ int adreno_gpu_init(struct drm_device *drm, struct =
platform_device *pdev,
> =20
>  	adreno_gpu_config.nr_rings =3D nr_rings;
> =20
> +	adreno_gpu_config.has_lpac =3D !!(config->info->quirks & ADRENO_QUIRK_L=
PAC);

[Severity: High]
What happens on a target with ADRENO_QUIRK_LPAC when booting with an older
Device Tree that lacks the qcom,lpac child node?

Earlier in adreno_gpu_init(), gpu->lpac_pdev is only populated if the
qcom,lpac child node exists:

drivers/gpu/drm/msm/adreno/adreno_gpu.c:adreno_gpu_init() {
	lpac_node =3D of_get_compatible_child(pdev->dev.of_node, "qcom,lpac");
	if (lpac_node)
		gpu->lpac_pdev =3D of_find_device_by_node(lpac_node);
}

When gpu->lpac_pdev is NULL, adreno_iommu_create_vm() passes NULL for
lpac_dev to msm_iommu_gpu_new(), so iommu->lpac_domain is never allocated or
attached to SMMU context bank 1.

If adreno_gpu_config.has_lpac is set based solely on ADRENO_QUIRK_LPAC
without checking gpu->lpac_pdev (and adreno_hw_init() likewise calls
qcom_scm_set_gpu_smmu_lpac_aperture(1) based only on ADRENO_QUIRK_LPAC),
msm_gpu_init() will still create gpu->lpac_rb, hw_init() will initialize the
LPAC ring, and msm_submitqueue_create() will allow userspace
MSM_SUBMITQUEUE_LPAC submissions that switch to context bank 1 without an
attached IOMMU domain.

Should adreno_gpu_config.has_lpac require gpu->lpac_pdev !=3D NULL, and sho=
uld
adreno_hw_init() check gpu->lpac_rb before calling
qcom_scm_set_gpu_smmu_lpac_aperture(1)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-descriptiv=
e-name-lpac-upstream-v2-0-a21a5c850961@gmail.com?part=3D9
