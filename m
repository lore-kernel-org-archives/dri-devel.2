Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B9760A3808
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 20:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RyeS2DS8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A40B11255B;
	Thu, 29 Oct 2026 20:45:19 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF05A10E1D8
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 20:45:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B98C36062D;
 Thu, 29 Oct 2026 20:45:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55CB21F01824;
 Thu, 29 Oct 2026 20:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793306711;
 bh=FhjLcQNDwiBN3Cg1HsolvBYVqfiaG1XpGSEGEsxi/MI=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=RyeS2DS8GlN/1OPwoyd5dOat5tfC6JchGkWWryHCtk+lgo0tJNO2oavAfZM2vwkjF
 wEvWEIuGK6VGIWbmKdwFLSWzAVRkcwxvUcTE+QcPoXSptQVPXtLVhOhpGyOStB+4ke
 ztAvY8sS69PzTlYvbREZS6dRIf01tQFQPB3hvFGRQBTavAko6uxNsdqPkbHPSBNHMj
 z5Yid8DRiqs8tOQZe2Z64skftDE+5COZmqEsDCGicIvQPNygfgfZPMo9q1G51ceWXh
 otT+Q2kIVuk3jRu1iLW6o0KV/PufnHpd6zcResB9NY1h1ljmJA/NJEb+kmOvcH2rEH
 /qmp74L810MOQ==
Message-ID: <sashiko-outbox-189938@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 12/16] drm/msm/a8xx: devcoredump state capture support
To: "Rob Clark" <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261029201730.151754-13-robin.clark@oss.qualcomm.com>
References: <20261029201730.151754-1-robin.clark@oss.qualcomm.com>
 <20261029201730.151754-13-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 20:45:10 +0000
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] drm/msm/a8xx: wrong GX power check and early GX read in a8xx_gpu_s=
tate_get()
- [High] drm/msm/a8xx: invalid slice 0 access and inner-only break in gen8_=
snapshot_mempool()
- [High] drm/msm/a8xx: UAF of preempt_bo[0] in a8xx_gpu_state_get() if pree=
mpt init fails
- [Medium] drm/msm/a8xx: dirty CP_APERTURE_CNTL_HOST state in a8xx_gpu_stat=
e_get()
--

commit 1f4e0c9ba2440c4987c100bc88fda75f8ca6244a
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm/a8xx: devcoredump state capture support

This commit adds GPU state capture and devcoredump support for Adreno A8xx
GPUs, including crashdumper script execution and fallback AHB register and
debugbus dumping.

> diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu_state.c b/drivers/gpu/dr=
m/msm/adreno/a8xx_gpu_state.c
> new file mode 100644
> index 0000000000000..786812b6cda10
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu_state.c
> @@ -0,0 +1,1402 @@

[ ... ]

> +static void gen8_legacy_snapshot_registers(struct msm_gpu *gpu,
> +					   struct adreno_gpu_state *state,
> +					   const struct gen8_reg_list *regs,
> +					   u32 slice_id)
> +{
> +	int count;
> +
> +	/* Figure out how many registers we are going to dump */
> +	count =3D adreno_snapshot_regs_count(regs->regs);
> +
> +	snapshot_sect (state, MVC_V3, 4 * count, {
> +		.ctxt_id =3D 0,
> +		.cluster_id =3D CLUSTER_NONE,
> +		.pipe_id =3D PIPE_NONE,
> +		.location_id =3D UINT_MAX,
> +		.sp_id =3D UINT_MAX,
> +		.usptp_id =3D UINT_MAX,
> +		.slice_id =3D HEADER_SLICE_ID(regs->slice_region, slice_id),
> +	}) {
> +		unsigned long flags;
> +
> +		if (regs->sel)
> +			gpu_write(gpu, regs->sel->host_reg, regs->sel->val);
> +
> +		if (regs->slice_region) {
> +			u32 val =3D GEN8_CP_APERTURE_REG_VAL(slice_id, 0, 0, 0);
> +			a8xx_aperture_acquire_raw(gpu, val, &flags);
> +		}
> +
> +		/* Make sure the previous writes are posted before reading */
> +		mb();
> +
> +		for (const u32 *ptr =3D regs->regs; ptr[0] !=3D UINT_MAX; ptr +=3D 2) {
> +			snapshot_mvc_regs_v3_subheader(&sect, ptr);
> +
> +			for (int k =3D ptr[0]; k <=3D ptr[1]; k++) {
> +				snapshot_sect_u32(&sect, reg_read(gpu, k));
> +			}
> +		}
> +
> +		if (regs->slice_region)
> +			a8xx_aperture_release(gpu, flags);
> +	}
> +}

[Severity: Medium]
Can this leave REG_A8XX_CP_APERTURE_CNTL_HOST and a6xx_gpu->cached_aperture
with stale slice or cluster routing during and after state capture?

Looking at drivers/gpu/drm/msm/adreno/a8xx_gpu.c, a8xx_aperture_acquire_raw=
()
takes a6xx_gpu->aperture_lock, writes REG_A8XX_CP_APERTURE_CNTL_HOST, and
updates a6xx_gpu->cached_aperture, while a8xx_aperture_release() only drops
aperture_lock without clearing the aperture register:

drivers/gpu/drm/msm/adreno/a8xx_gpu.c:a8xx_aperture_release() {
	struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
	struct a6xx_gpu *a6xx_gpu =3D to_a6xx_gpu(adreno_gpu);

	spin_unlock_irqrestore(&a6xx_gpu->aperture_lock, flags);
}

In gen8_legacy_snapshot_registers(), a8xx_aperture_acquire_raw() is only
called when regs->slice_region is SLICE, and the aperture is not cleared on
release or before UNSLICE reads. When iterating over b->pre_crashdumper_regs
or b->reg_list (when dumper is NULL), SLICE entries are followed by UNSLICE
entries, so subsequent UNSLICE blocks are read while
REG_A8XX_CP_APERTURE_CNTL_HOST still has A8XX_CP_APERTURE_CNTL_HOST_USESLIC=
EID
and the previous slice_id programmed.

Also in gen8_legacy_snapshot_registers(), regs->sel->host_reg is written
before a8xx_aperture_acquire_raw(), outside aperture_lock and before the
target slice aperture is selected (unlike gen8_legacy_snapshot_mvc() and the
crashdumper path in gen8_reglist_snapshot()).

Finally, at the out label of a8xx_gpu_state_get(), a8xx_aperture_clear(gpu)
is not called. When dumper is NULL (such as on the SMMU stall-on-fault path
where the GPU resumes after state capture without a reset) or if
gen8_snapshot_mempool() is not reached, REG_A8XX_CP_APERTURE_CNTL_HOST and
a6xx_gpu->cached_aperture remain left at the last slice/pipe/cluster/context
value.

Should gen8_legacy_snapshot_registers() program the aperture for both SLICE
and UNSLICE regions before writing regs->sel->host_reg, and should
a8xx_gpu_state_get() call a8xx_aperture_clear(gpu) at the out label?

[ ... ]

> +static bool gen8_snapshot_mempool(struct msm_gpu *gpu,
> +				  struct adreno_gpu_state *state,
> +				  struct adreno_crashdumper *dumper)
> +{
> +	const struct gen8_snapshot_block_list *b =3D block_list(gpu);
> +	struct a6xx_gpu *a6xx_gpu =3D to_a6xx_gpu(to_adreno_gpu(gpu));
> +	u32 slice_mask =3D a6xx_gpu->slice_mask;
> +	u32 first_slice =3D a8xx_get_first_slice(a6xx_gpu);
> +	bool ret =3D true;
> +
> +	for (int i =3D 0; i < b->mempool_index_registers_len; i++) {
> +		const struct gen8_cp_indexed_reg *cp_indexed_reg =3D
> +			&b->mempool_index_registers[i];
> +		unsigned long flags;
> +		u32 j;
> +
> +		FOR_EACH_SLICE (j, cp_indexed_reg->slice_region, slice_mask) {
> +			u32 pipe_id =3D cp_indexed_reg->pipe_id;
> +
> +			/* Set CP_CHICKEN_DBG[StabilizeMVC] to stabilize it while dumping */
> +			a8xx_aperture_acquire_raw(gpu,
> +				GEN8_CP_APERTURE_REG_VAL_NS(first_slice, pipe_id, 0, 0),
> +				&flags);
> +			gpu_rmw(gpu, REG_A8XX_CP_CHICKEN_DBG_PIPE, BIT(2), BIT(2));
> +			a8xx_aperture_release(gpu, flags);
> +
> +			a8xx_aperture_acquire_raw(gpu,
> +				GEN8_CP_APERTURE_REG_VAL(j, pipe_id, 0, 0),
> +				&flags);
> +			gpu_rmw(gpu, REG_A8XX_CP_SLICE_CHICKEN_DBG_PIPE, BIT(2), BIT(2));
> +			a8xx_aperture_release(gpu, flags);
> +
> +			ret =3D gen8_snapshot_indexed_registers(gpu, state, dumper,
> +				cp_indexed_reg->addr,
> +				cp_indexed_reg->data, 0,
> +				cp_indexed_reg->size,
> +				cp_indexed_reg->pipe_id,
> +				HEADER_SLICE_ID(cp_indexed_reg->slice_region, j));
> +
> +			/* Reset CP_CHICKEN_DBG[StabilizeMVC] once we are done */
> +			a8xx_aperture_acquire_raw(gpu,
> +				GEN8_CP_APERTURE_REG_VAL_NS(first_slice, pipe_id, 0, 0),
> +				&flags);
> +			gpu_rmw(gpu, REG_A8XX_CP_CHICKEN_DBG_PIPE, BIT(2), 0);
> +			a8xx_aperture_release(gpu, flags);
> +
> +			a8xx_aperture_acquire_raw(gpu,
> +				GEN8_CP_APERTURE_REG_VAL(j, pipe_id, 0, 0),
> +				&flags);
> +			gpu_rmw(gpu, REG_A8XX_CP_SLICE_CHICKEN_DBG_PIPE, BIT(2), 0);
> +			a8xx_aperture_release(gpu, flags);
> +
> +			if (!ret)
> +				break;
> +		}
> +	}

[Severity: High]
What happens in gen8_snapshot_mempool() when cp_indexed_reg->slice_region is
UNSLICE and slice 0 is fused off in slice_mask, or when
gen8_snapshot_indexed_registers() fails?

For UNSLICE entries in b->mempool_index_registers (such as
CP_MEM_POOL_DBG_ADDR_PIPE), FIRST_SLICE(UNSLICE, slice_mask) sets j =3D 0:

	#define FIRST_SLICE(_region, _slice_mask) \
		((_region =3D=3D UNSLICE) ? 0 : NEXT_SLICE(0, _region, _slice_mask))

Inside FOR_EACH_SLICE, gen8_snapshot_mempool() unconditionally programs
GEN8_CP_APERTURE_REG_VAL(j, pipe_id, 0, 0) (which sets
A8XX_CP_APERTURE_CNTL_HOST_USESLICEID with slice 0) and RMWs the per-slice
register REG_A8XX_CP_SLICE_CHICKEN_DBG_PIPE even when
cp_indexed_reg->slice_region is UNSLICE. On ADRENO_8XX_GEN2+ parts with
ADRENO_QUIRK_SOFTFUSE where slice 0 can be disabled in slice_mask (which is
why first_slice is queried via a8xx_get_first_slice(a6xx_gpu) for
REG_A8XX_CP_CHICKEN_DBG_PIPE), won't this access a fused-off slice 0?

In addition, if gen8_snapshot_indexed_registers() returns false (for example
on a crashdumper timeout), the break on !ret only exits the inner
FOR_EACH_SLICE loop. The outer loop over b->mempool_index_registers_len
continues to the remaining entries, performing further AHB accesses and
crashdumper runs after the timeout and overwriting ret.

Should REG_A8XX_CP_SLICE_CHICKEN_DBG_PIPE only be accessed when
cp_indexed_reg->slice_region =3D=3D SLICE (and REG_A8XX_CP_CHICKEN_DBG_PIPE=
 when
UNSLICE), and should a failure in gen8_snapshot_indexed_registers() break o=
ut
of the outer loop as well?

[ ... ]

> +struct msm_gpu_state *a8xx_gpu_state_get(struct msm_gpu *gpu)
> +{
> +	const struct gen8_snapshot_block_list *b =3D block_list(gpu);
> +	struct adreno_crashdumper _dumper =3D { 0 }, *dumper =3D NULL;
> +	struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
> +	struct a6xx_gpu *a6xx_gpu =3D to_a6xx_gpu(adreno_gpu);
> +	struct adreno_gpu_state *state;
> +	// TODO need to get status from SMMU on some gen8..
> +	bool stalled =3D !!(gpu_read(gpu, REG_A8XX_RBBM_MISC_STATUS) &
> +			A8XX_RBBM_MISC_STATUS_SMMU_STALLED_ON_FAULT);
> +
> +	/*
> +	 * GPU state snapshot is inherently single threaded.  All paths
> +	 * are serialized on gpu->lock.  Make that clear, and prevent
> +	 * future bugs:
> +	 */
> +	WARN_ON_ONCE(!mutex_is_locked(&gpu->lock));
> +
> +	if (!b)
> +		return NULL;
> +
> +	state =3D kzalloc_obj(*state);
> +	if (!state)
> +		return ERR_PTR(-ENOMEM);
> +
> +	INIT_LIST_HEAD(&state->objs);
> +
> +	/* Get the generic state from the adreno core */
> +	adreno_gpu_state_get(gpu, &state->base);
> +
> +	adreno_snapshot_registers_v2(gpu, state, b->gmu_cx_unsliced_regs);
> +
> +	a8xx_snapshot_gmu_bo(state, &a6xx_gpu->gmu.log, SNAPSHOT_GMU_MEM_LOG);
> +	a8xx_snapshot_gmu_bo(state, &a6xx_gpu->gmu.hfi, SNAPSHOT_GMU_MEM_HFI);
> +	a8xx_snapshot_gmu_bo(state, &a6xx_gpu->gmu.debug, SNAPSHOT_GMU_MEM_DEBU=
G);
> +
> +	a8xx_snapshot_gmu_hfi_history(gpu, state);
> +
> +	snapshot_sect (state, DEBUG, 4, {
> +		.type =3D SNAPSHOT_DEBUG_SLICE_MASK,
> +		.size =3D 1,
> +	}) {
> +		snapshot_sect_u32(&sect, a6xx_gpu->slice_mask);
> +	}
> +	gen8_snapshot_cx_debugbus(gpu, state);
> +
> +	/* If GX isn't on the rest of the data isn't going to be accessible */
> +	if (!a6xx_gmu_gx_is_on(adreno_gpu))
> +		return &state->base;

[Severity: High]
Could this cause unclocked GX/GMU register reads when GX is powered off, or
misdetect GX power state on A8xx?

First, at the top of a8xx_gpu_state_get(), REG_A8XX_RBBM_MISC_STATUS (in the
GX domain) is read unconditionally via gpu_read() to initialize stalled
before checking whether the GX domain is powered on, even though stalled is
only used after the GX power check.

Second, the GX power check calls a6xx_gmu_gx_is_on(adreno_gpu), which reads
REG_A6XX_GMU_SPTPRAC_PWR_CLK_STATUS and checks the A6xx bitfields:

drivers/gpu/drm/msm/adreno/a6xx_gmu.c:a6xx_gmu_gx_is_on() {
	...
	val =3D gmu_read(gmu, REG_A6XX_GMU_SPTPRAC_PWR_CLK_STATUS);

	if (adreno_is_a7xx(adreno_gpu))
		return !(val &
			(A7XX_GMU_SPTPRAC_PWR_CLK_STATUS_GX_HM_GDSC_POWER_OFF |
			A7XX_GMU_SPTPRAC_PWR_CLK_STATUS_GX_HM_CLK_OFF));

	return !(val &
		(A6XX_GMU_SPTPRAC_PWR_CLK_STATUS_GX_HM_GDSC_POWER_OFF |
		A6XX_GMU_SPTPRAC_PWR_CLK_STATUS_GX_HM_CLK_OFF));
}

On A8xx, a8xx_gpu_funcs.gx_is_on is wired to a8xx_gmu_gx_is_on(), which
checks REG_A8XX_CX_MISC_GFX_PWR_CLK_STATUS on the A850 family (where GMU MX
may be off) or REG_A8XX_GMU_PWR_CLK_STATUS on other A8xx GPUs:

drivers/gpu/drm/msm/adreno/a6xx_gmu.c:a8xx_gmu_gx_is_on() {
	...
	if (adreno_is_a850_family(adreno_gpu)) {
		val =3D a6xx_cx_misc_read(a6xx_gpu, REG_A8XX_CX_MISC_GFX_PWR_CLK_STATUS);

		return !(val &
			(A8XX_CX_MISC_GFX_PWR_CLK_STATUS_GX_GDSC_POWER_OFF |
			 A8XX_CX_MISC_GFX_PWR_CLK_STATUS_GX_CLK_OFF));
	}

	val =3D gmu_read(gmu, REG_A8XX_GMU_PWR_CLK_STATUS);

	return !(val &
		(A8XX_GMU_PWR_CLK_STATUS_GX_HM_GDSC_POWER_OFF |
		 A8XX_GMU_PWR_CLK_STATUS_GX_HM_CLK_OFF));
}

Should a8xx_gpu_state_get() call a8xx_gmu_gx_is_on(adreno_gpu) (or
adreno_gpu->funcs->gx_is_on(adreno_gpu)), and defer reading
REG_A8XX_RBBM_MISC_STATUS until after verifying that GX is on?

[ ... ]

> +	/*
> +	 * Capture preempt records after cp_clusters, to make this easier
> +	 * to decode (ie. so we already know CP_CONTEXT_SWITCH_SMMU_INFO and
> +	 * CP_CONTEXT_SWITCH_PRIV_NON_SECURE_RESTORE_ADDR) when crashdec sees
> +	 * the logged GPU objs)
> +	 */
> +	for (unsigned i =3D 0; i < gpu->nr_rings; i++) {
> +		a8xx_snapshot_gpu_bo(state, a6xx_gpu->preempt_bo[i],
> +				     a6xx_gpu->preempt_iova[i]);
> +		a8xx_snapshot_gpu_bo(state, a6xx_gpu->preempt_smmu_bo[i],
> +				     a6xx_gpu->preempt_smmu_iova[i]);
> +	}

[Severity: High]
Can this trigger a use-after-free on a6xx_gpu->preempt_bo[0] if
a6xx_preempt_init() failed during GPU initialization?

During a6xx_gpu_init(), A8xx GPUs start with gpu->nr_rings =3D 4 and call
a6xx_preempt_init(gpu). If preempt_init_ring() succeeds for ring 0 (setting
a6xx_gpu->preempt_bo[0] and a6xx_gpu->preempt_smmu_bo[0]) and a subsequent
ring or postamble allocation fails, a6xx_preempt_init() cleans up and falls
back to a single ring without failing GPU init:

drivers/gpu/drm/msm/adreno/a6xx_preempt.c:a6xx_preempt_init() {
	...
fail:
	/*
	 * On any failure our adventure is over. Clean up and
	 * set nr_rings to 1 to force preemption off
	 */
	a6xx_preempt_fini(gpu);
	gpu->nr_rings =3D 1;
}

However, a6xx_preempt_fini() frees a6xx_gpu->preempt_bo[i] via
msm_gem_kernel_put() without setting a6xx_gpu->preempt_bo[i] =3D NULL (and =
does
not free a6xx_gpu->preempt_smmu_bo[i]):

drivers/gpu/drm/msm/adreno/a6xx_preempt.c:a6xx_preempt_fini() {
	...
	for (i =3D 0; i < gpu->nr_rings; i++)
		msm_gem_kernel_put(a6xx_gpu->preempt_bo[i], gpu->vm);
}

When a8xx_gpu_state_get() later runs with gpu->nr_rings =3D=3D 1, this loop
passes the freed non-NULL a6xx_gpu->preempt_bo[0] pointer to
a8xx_snapshot_gpu_bo(), which dereferences bo->size and calls
msm_gem_get_vaddr(bo).

Should this loop be guarded by if (gpu->nr_rings > 1) like the other
preemption paths, or should a6xx_preempt_fini() also release
preempt_smmu_bo[i] and clear the pointers to NULL?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029201730.1517=
54-1-robin.clark@oss.qualcomm.com?part=3D12
