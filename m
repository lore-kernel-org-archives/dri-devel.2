Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69496606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 21:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XSTyLcSd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9AD410E8EA;
	Fri, 30 Oct 2026 21:46:31 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2F2510E8EA
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:46:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0E5FE601F8;
 Fri, 30 Oct 2026 21:46:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E46A1F000C1;
 Fri, 30 Oct 2026 21:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793396779;
 bh=6dSc5TCnRBZ4GFF7sqv7lufHqY+PPsKq4DtTqCUjU4U=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=XSTyLcSdwJ9GWd0JLImKfiUv9Tkoo2r61agPeiNP2O707XJRe8IdNqD2A3zhaAR1s
 PW0Nxnf/KXBwBifUsmWGnyeHZq7tnTOgaKBWc6o2owgjdMo41kq1t8+WDa0gom1CM6
 prVAaZLpFdC1AQaTHEOVZ5AxzuMX5aMH84sbAqNV9baDxN1aSpmEBjD5jyBPSRCBpK
 hYArmDIH/mXsvcN0669IvjiijBSmHdhb/Ljt0qVkfqKWiXSXrfWcWwwGV7vX3qxIm1
 8QeZPln5C4R4SCOZ2fPjF4dO8L2QNv1G5afv9e2RPMHQROEQldPeNPpsF2HbVM2trW
 ZseKPywcQcS7A==
Message-ID: <sashiko-outbox-191551@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 15/19] drm/msm/a8xx: devcoredump state capture support
To: "Rob Clark" <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261030211928.45761-16-robin.clark@oss.qualcomm.com>
References: <20261030211928.45761-1-robin.clark@oss.qualcomm.com>
 <20261030211928.45761-16-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 21:46:19 +0000
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
- [High] drm/msm/a8xx: inverted BO check and UAF in a8xx_snapshot_gpu_bo()
- [High] drm/msm/a8xx: wrong GX power check helper in a8xx_gpu_state_get()
- [High] drm/msm/a8xx: invalid slice 0 access in gen8_snapshot_mempool()
- [Medium] drm/msm/a8xx: dirty CP_APERTURE_CNTL_HOST state in a8xx_gpu_stat=
e_get()
--

commit 7da07b63ff0536a6ed00689438a2759bfa00dddf
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm/a8xx: devcoredump state capture support

This commit adds devcoredump GPU state capture and snapshot formatting
support for Adreno Gen8 (A8xx) GPUs, including crashdumper script
execution, register and shader block dumping, debugbus capture, and GMU
state collection.

> diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu_state.c b/drivers/gpu/dr=
m/msm/adreno/a8xx_gpu_state.c
> new file mode 100644
> index 0000000000000..3c696244cd663
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu_state.c
> @@ -0,0 +1,1401 @@

[ ... ]

> +#define NEXT_SLICE(_slice, _region, _slice_mask) \
> +	((_region =3D=3D UNSLICE) ? fls(_slice_mask) : next_slice(_slice, _slic=
e_mask))
> +
> +#define FIRST_SLICE(_region, _slice_mask) \
> +	((_region =3D=3D UNSLICE) ? 0 : NEXT_SLICE(0, _region, _slice_mask))
> +
> +#define FOR_EACH_SLICE(_slice, _region, _slice_mask) \
> +	for (_slice =3D FIRST_SLICE(_region, _slice_mask); \
> +	     _slice < fls(_slice_mask); \
> +	     _slice =3D NEXT_SLICE(++(_slice), _region, _slice_mask))

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
As reported by Sashiko on v3 [1], does gen8_legacy_snapshot_registers()
leave REG_A8XX_CP_APERTURE_CNTL_HOST and a6xx_gpu->cached_aperture with a
stale slice configuration when transitioning from a SLICE entry to an
UNSLICE entry?

In drivers/gpu/drm/msm/adreno/a8xx_gpu.c, a8xx_aperture_acquire_raw() writes
the aperture register and updates cached_aperture, while
a8xx_aperture_release() only unlocks a6xx_gpu->aperture_lock without
resetting the register:

drivers/gpu/drm/msm/adreno/a8xx_gpu.c:a8xx_aperture_release() {
	spin_unlock_irqrestore(&a6xx_gpu->aperture_lock, flags);
}

Because gen8_legacy_snapshot_registers() only calls
a8xx_aperture_acquire_raw() when regs->slice_region is non-zero (SLICE) and
does not clear the aperture on release or when regs->slice_region is
UNSLICE, any UNSLICE entry that follows a SLICE entry in
b->pre_crashdumper_regs or b->reg_list will be read while
A8XX_CP_APERTURE_CNTL_HOST_USESLICEID and the previous slice_id are still
active in REG_A8XX_CP_APERTURE_CNTL_HOST.

In addition, gen8_legacy_snapshot_registers() writes regs->sel->host_reg
before calling a8xx_aperture_acquire_raw(), so the selector register is
programmed before the target slice aperture is selected and outside
aperture_lock (unlike gen8_legacy_snapshot_mvc()).

Similarly, at the out label in a8xx_gpu_state_get(), a8xx_aperture_clear()
is not called before returning:

drivers/gpu/drm/msm/adreno/a8xx_gpu_state.c:a8xx_gpu_state_get() {
    ...
out:
	gpu_write(gpu, REG_A8XX_RBBM_SNAPSHOT_STATUS, 0x0);

	if (dumper)
		msm_gem_kernel_put(dumper->bo, gpu->vm);
}

When dumper is NULL (such as during an SMMU stall-on-fault devcoredump where
the GPU resumes without a reset) or on an early goto out path, can leaving
REG_A8XX_CP_APERTURE_CNTL_HOST and cached_aperture programmed to the last
cluster, pipe, slice, and context corrupt subsequent host AHB accesses?

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
> +	for (int i =3D 0; i < b->mempool_index_registers_len && ret; i++) {
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
As reported by Sashiko on v3 [2], when cp_indexed_reg->slice_region is
UNSLICE in gen8_snapshot_mempool(), FIRST_SLICE(UNSLICE, slice_mask) sets j
to 0 regardless of slice_mask.

In that case, gen8_snapshot_mempool() still programs
GEN8_CP_APERTURE_REG_VAL(0, pipe_id, 0, 0) (which sets
A8XX_CP_APERTURE_CNTL_HOST_USESLICEID for slice 0) and performs a
read-modify-write on the per-slice register
REG_A8XX_CP_SLICE_CHICKEN_DBG_PIPE before and after
gen8_snapshot_indexed_registers().

On A8xx GPUs with partial slice configurations where slice 0 is fused off in
slice_mask (which is why first_slice is queried via a8xx_get_first_slice()
for REG_A8XX_CP_CHICKEN_DBG_PIPE), won't accessing
REG_A8XX_CP_SLICE_CHICKEN_DBG_PIPE on slice 0 during UNSLICE iterations
access a disabled slice and trigger an AHB/NoC bus error? Should
REG_A8XX_CP_SLICE_CHICKEN_DBG_PIPE only be touched when
cp_indexed_reg->slice_region =3D=3D SLICE (and REG_A8XX_CP_CHICKEN_DBG_PIPE=
 when
cp_indexed_reg->slice_region =3D=3D UNSLICE)?

[ ... ]

> +static void a8xx_snapshot_gpu_bo(struct adreno_gpu_state *state,
> +				 struct drm_gem_object *bo,
> +				 uint64_t iova)
> +{
> +	if (!IS_ERR_OR_NULL(bo))
> +		return;
> +
> +	snapshot_sect (state, GPU_OBJECT_V2, bo->size, {
> +		.type =3D SNAPSHOT_GPU_OBJECT_GLOBAL,
> +		.gpuaddr =3D iova,
> +		.size =3D bo->size / 4,  /* dwords */
> +	}) {
> +		void *ptr =3D msm_gem_get_vaddr(bo);
> +		snapshot_sect_data(&sect, ptr, bo->size);
> +		msm_gem_put_vaddr(bo);
> +	}
> +}

[Severity: High]
As reported by Sashiko on v3 [3], is the IS_ERR_OR_NULL(bo) check inverted =
in
a8xx_snapshot_gpu_bo()?

With if (!IS_ERR_OR_NULL(bo)) return;, valid GEM buffer objects return early
without being captured, while a NULL or ERR_PTR bo falls through and
dereferences bo->size (for example, when preemption is disabled and
a6xx_gpu->preempt_bo[0] and a6xx_gpu->preempt_smmu_bo[0] are NULL).

Even with the condition fixed to if (IS_ERR_OR_NULL(bo)) return;,
a8xx_gpu_state_get() calls a8xx_snapshot_gpu_bo() in a loop over
gpu->nr_rings:

drivers/gpu/drm/msm/adreno/a8xx_gpu_state.c:a8xx_gpu_state_get() {
    ...
	for (unsigned i =3D 0; i < gpu->nr_rings; i++) {
		a8xx_snapshot_gpu_bo(state, a6xx_gpu->preempt_bo[i],
				     a6xx_gpu->preempt_iova[i]);
		a8xx_snapshot_gpu_bo(state, a6xx_gpu->preempt_smmu_bo[i],
				     a6xx_gpu->preempt_smmu_iova[i]);
	}
}

If a6xx_preempt_init() fails after allocating a6xx_gpu->preempt_bo[0], it
calls a6xx_preempt_fini() and falls back to gpu->nr_rings =3D 1, but
a6xx_preempt_fini() frees a6xx_gpu->preempt_bo[i] via msm_gem_kernel_put()
without clearing the pointer to NULL. Should a8xx_gpu_state_get() guard this
loop with if (gpu->nr_rings > 1), and should a8xx_snapshot_gpu_bo() also
check IS_ERR(ptr) after msm_gem_get_vaddr(bo) before passing ptr to
snapshot_sect_data() and calling msm_gem_put_vaddr(bo)?

[ ... ]

> +struct msm_gpu_state *a8xx_gpu_state_get(struct msm_gpu *gpu)
> +{

[ ... ]

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
As reported by Sashiko on v3 [4], should a8xx_gpu_state_get() call
a8xx_gmu_gx_is_on(adreno_gpu) (or adreno_gpu->funcs->gx_is_on(adreno_gpu))
here instead of a6xx_gmu_gx_is_on(adreno_gpu)?

In drivers/gpu/drm/msm/adreno/a6xx_gmu.c, a6xx_gmu_gx_is_on() reads
REG_A6XX_GMU_SPTPRAC_PWR_CLK_STATUS and checks the A6xx GX power and clock
bits because adreno_is_a7xx(adreno_gpu) is false on A8xx:

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

On A8xx, GX power status is reported via REG_A8XX_CX_MISC_GFX_PWR_CLK_STATUS
on the A850 family (where GMU MX may be off) or REG_A8XX_GMU_PWR_CLK_STATUS
in a8xx_gmu_gx_is_on(). Can calling a6xx_gmu_gx_is_on() on A8xx misreport GX
power status and allow unclocked GX register accesses when GX is powered
off?

[1] https://lore.kernel.org/r/20261029201730.151754-13-robin.clark@oss.qual=
comm.com
[2] https://lore.kernel.org/r/20261029201730.151754-13-robin.clark@oss.qual=
comm.com
[3] https://lore.kernel.org/r/20261029201730.151754-13-robin.clark@oss.qual=
comm.com
[4] https://lore.kernel.org/r/20261029201730.151754-13-robin.clark@oss.qual=
comm.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030211928.4576=
1-1-robin.clark@oss.qualcomm.com?part=3D15
