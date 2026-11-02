Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB89A606D813
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 22:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AO9k3X0v
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F0DD10E708;
	Mon,  2 Nov 2026 22:28:27 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B900010E708
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 22:28:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 601AF4079F;
 Mon,  2 Nov 2026 22:28:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 277821F00A18;
 Mon,  2 Nov 2026 22:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793658501;
 bh=cNAI0wERN7L5RzPl9GMXe9AVAsOvIjVyRrQ2yF8Mj8M=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=AO9k3X0vHAcCgM0LPCaXA45+25jVuEROg8+R1GwvXdHY+doqWx/oN4KMMMZ5IAApi
 IvSvQcqoyIycvVFLBKpxxda9+6i9SH6Yi72z8Zzkkn6AEsFr1Wnnd3hMnsnMxZkP7U
 Wiwv/aqKgYGn721LhW68S+WOu1ZUjE4v3iQ73toipoIUt3iolYGOKLJOMr+X7/vG81
 q95OKfmKc40JZy4LcCZxcs7GVNc/M8zW5UgrpTBtTGddUhvCguHVp7plf4mn+6SYc3
 CtDyrMtCb0bwNuVuQwqsa/7GiFV59QZNCr6jOBOuBqy83/AWl34lni/HG0c4Ewwon6
 8E+Z59dDS1Ixg==
Message-ID: <sashiko-outbox-194286@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 11/15] drm/msm/a8xx: devcoredump state capture support
To: "Rob Clark" <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261102220405.30730-12-robin.clark@oss.qualcomm.com>
References: <20261102220405.30730-1-robin.clark@oss.qualcomm.com>
 <20261102220405.30730-12-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 22:28:20 +0000
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
- [High] drm/msm/a8xx: wrong GX power check helper in a8xx_gpu_state_get()
- [High] drm/msm/a8xx: invalid slice 0 access in gen8_snapshot_mempool()
- [High] drm/msm/a8xx: unguarded preempt_bo loop in a8xx_gpu_state_get() ca=
uses UAF
- [Medium] drm/msm/a8xx: dirty CP_APERTURE_CNTL_HOST state in a8xx_gpu_stat=
e_get()
--

commit c7a029a7073f0aadd364139ec43ceeb070ef9dae
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm/a8xx: devcoredump state capture support

This commit adds devcoredump GPU state capture support for Adreno A8xx GPUs,
including register lists, indexed registers, mempool, MVC clusters, shader
blocks, debugbus, and GMU state.

> diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu_state.c b/drivers/gpu/dr=
m/msm/adreno/a8xx_gpu_state.c
> new file mode 100644
> index 0000000000000..b75de2370e2e3
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu_state.c

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
As reported by Sashiko on v4 [1], can gen8_legacy_snapshot_registers() leave
REG_A8XX_CP_APERTURE_CNTL_HOST and a6xx_gpu->cached_aperture programmed to a
previous slice when reading subsequent UNSLICE register blocks?

In drivers/gpu/drm/msm/adreno/a8xx_gpu.c, a8xx_aperture_acquire_raw() writes
to REG_A8XX_CP_APERTURE_CNTL_HOST and updates a6xx_gpu->cached_aperture,
whereas a8xx_aperture_release() only drops a6xx_gpu->aperture_lock:

drivers/gpu/drm/msm/adreno/a8xx_gpu.c:a8xx_aperture_release() {
	spin_unlock_irqrestore(&a6xx_gpu->aperture_lock, flags);
}

Because gen8_legacy_snapshot_registers() only calls
a8xx_aperture_acquire_raw() when regs->slice_region is SLICE and does not
clear the aperture afterward, when b->pre_crashdumper_regs or b->reg_list h=
as
SLICE entries followed by UNSLICE entries, the UNSLICE entries are read whi=
le
REG_A8XX_CP_APERTURE_CNTL_HOST still has A8XX_CP_APERTURE_CNTL_HOST_USESLIC=
EID
and the previous slice_id set.

In addition, regs->sel->host_reg is written before a8xx_aperture_acquire_ra=
w()
selects the target slice and outside aperture_lock, and a8xx_gpu_state_get()
exits via the out label without calling a8xx_aperture_clear(gpu) to reset
REG_A8XX_CP_APERTURE_CNTL_HOST and a6xx_gpu->cached_aperture after
gen8_snapshot_mvc_regs(), gen8_snapshot_cp_indexed_regs(), and
gen8_legacy_snapshot_registers() run.

Should gen8_legacy_snapshot_registers() program the aperture for both SLICE
and UNSLICE regions (and write regs->sel->host_reg after acquiring the
aperture), and should a8xx_gpu_state_get() call a8xx_aperture_clear(gpu) at
the out label?

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
As reported by Sashiko on v4 [2], does gen8_snapshot_mempool() access slice=
 0
even when cp_indexed_reg->slice_region is UNSLICE and slice 0 is fused off =
in
slice_mask?

For UNSLICE entries in b->mempool_index_registers, FIRST_SLICE(UNSLICE,
slice_mask) sets j to 0 regardless of slice_mask:

#define FIRST_SLICE(_region, _slice_mask) \
	((_region =3D=3D UNSLICE) ? 0 : NEXT_SLICE(0, _region, _slice_mask))

Inside FOR_EACH_SLICE, gen8_snapshot_mempool() uses first_slice when
accessing REG_A8XX_CP_CHICKEN_DBG_PIPE, but then unconditionally programs
GEN8_CP_APERTURE_REG_VAL(j, pipe_id, 0, 0) and RMWs the per-slice register
REG_A8XX_CP_SLICE_CHICKEN_DBG_PIPE on slice j =3D 0 before and after
gen8_snapshot_indexed_registers().

On A8xx GPUs with partial slice configurations where slice 0 is disabled in
a6xx_gpu->slice_mask, won't touching REG_A8XX_CP_SLICE_CHICKEN_DBG_PIPE on
slice 0 during UNSLICE mempool dumps access a fused-off slice and cause an
AHB/NoC bus error?

[ ... ]

> +struct msm_gpu_state *a8xx_gpu_state_get(struct msm_gpu *gpu)
> +{

[ ... ]

> +	/* If GX isn't on the rest of the data isn't going to be accessible */
> +	if (!a6xx_gmu_gx_is_on(adreno_gpu))
> +		return &state->base;

[Severity: High]
As reported by Sashiko on v4 [3], should a8xx_gpu_state_get() call
a8xx_gmu_gx_is_on(adreno_gpu) (or adreno_gpu->funcs->gx_is_on(adreno_gpu))
here instead of a6xx_gmu_gx_is_on(adreno_gpu)?

In drivers/gpu/drm/msm/adreno/a6xx_gmu.c, a6xx_gmu_gx_is_on() reads
REG_A6XX_GMU_SPTPRAC_PWR_CLK_STATUS and checks A6xx bit definitions when
adreno_is_a7xx() is false:

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

On A8xx hardware, GX power and clock status is checked via
a8xx_gmu_gx_is_on(), which reads REG_A8XX_CX_MISC_GFX_PWR_CLK_STATUS on
A850-family GPUs (where GMU MX may be off) or REG_A8XX_GMU_PWR_CLK_STATUS on
other A8xx GPUs. Calling a6xx_gmu_gx_is_on() on A8xx reads the wrong regist=
er
and bitmask, which can touch unpowered GMU MMIO on A850-family GPUs or fals=
ely
report GX as powered on and proceed with unclocked GX register reads.

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
As reported by Sashiko on v4 [4], can this loop trigger a use-after-free on
a6xx_gpu->preempt_bo[0] when preemption initialization fails and falls back
to a single ring?

In drivers/gpu/drm/msm/adreno/a6xx_preempt.c, if a6xx_preempt_init() fails
after allocating ring 0's preempt_bo[0], it calls a6xx_preempt_fini(gpu) and
sets gpu->nr_rings =3D 1:

drivers/gpu/drm/msm/adreno/a6xx_preempt.c:a6xx_preempt_fini() {
	for (i =3D 0; i < gpu->nr_rings; i++)
		msm_gem_kernel_put(a6xx_gpu->preempt_bo[i], gpu->vm);
}

Because a6xx_preempt_fini() frees a6xx_gpu->preempt_bo[0] without clearing
the pointer to NULL, and a8xx_gpu_state_get() iterates up to gpu->nr_rings
without checking gpu->nr_rings > 1, iteration i =3D 0 will pass the freed
a6xx_gpu->preempt_bo[0] pointer to a8xx_snapshot_gpu_bo(). Should this loop
be guarded by gpu->nr_rings > 1 like the other preemption paths?

[1] https://lore.kernel.org/r/20261030211928.45761-16-robin.clark@oss.qualc=
omm.com
[2] https://lore.kernel.org/r/20261030211928.45761-16-robin.clark@oss.qualc=
omm.com
[3] https://lore.kernel.org/r/20261030211928.45761-16-robin.clark@oss.qualc=
omm.com
[4] https://lore.kernel.org/r/20261030211928.45761-16-robin.clark@oss.qualc=
omm.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102220405.3073=
0-1-robin.clark@oss.qualcomm.com?part=3D11
