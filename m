Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3500D606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 23:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UahLLjMY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 904C910F826;
	Tue, 20 Oct 2026 23:14:07 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 763C810E90C
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 23:14:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 69AC660416;
 Tue, 20 Oct 2026 23:14:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E4BF1F000C9;
 Tue, 20 Oct 2026 23:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792538040;
 bh=MN73Yo4Pep8IIHGh2rCAda1Kkp9Tg0aLb2e3Wuajzqg=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=UahLLjMYG7CKU9CHBAMd9Y5rCEzJiXkuUxeJT8WGxJezXrCCtJpjIVIRjFVBIaQWy
 eDKA6ZCBEmWJnAXR2ZJgYwEw/vOx7SnKzKDJ2FJpaDEMAREvOJB7wvc2Fr349U9JEP
 XPXOFbO0XazlbcyfakRhnFjdZEzPx5Z0NI3USjfwwBhkhbslP8RMTa/QznPn2OB0Zq
 ljbjr3JnSnpusR6XdMXfJ40IdAPtkMn+8ySfkk9fOgrf/avI1yM5quqinkPJtQI/AJ
 ZAFn2VrdIxlpfKtRrRli/EawJEJ9GTyFcI9EN+hxZcarcw15zS6C64D3DqY1FrdhUJ
 3Cp99xP6H2CbQ==
Message-ID: <sashiko-outbox-179596@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/12] drm/msm/a8xx: devcoredump state capture support
To: "Rob Clark" <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261020204728.28844-10-robin.clark@oss.qualcomm.com>
References: <20261020204728.28844-1-robin.clark@oss.qualcomm.com>
 <20261020204728.28844-10-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 23:13:59 +0000
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] drm/msm/a8xx: wrong GX power check and early GX read in a8xx_gpu_s=
tate_get()
- [High] drm/msm/a8xx: off-by-one slice ID and ignored error in gen8_snapsh=
ot_mempool()
- [Medium] drm/msm/a8xx: unrestored DBGC config after gen8_debugbus_interna=
l_read_setup()
- [Medium] drm/msm/a8xx: hardcoded context 0 in gen8_snapshot_dbgahb_regs()=
 SP_READ_SEL
- [Medium] drm/msm/a8xx: broken host aperture setup in legacy AHB snapshot =
helpers
- [Low] drm/msm/a8xx: 32-bit GENMASK(63, 44) overflow in CD_WRITE() and CD_=
READ()
--

commit 2b161a7f68dabf614abb5d253ffd0443bf998e9b
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm/a8xx: devcoredump state capture support

This commit adds devcoredump GPU state capture and crashdumper support for
Adreno A8xx (Gen8) GPUs, along with snapshot section helpers in
adreno_snapshot.h.

> diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu_state.c b/drivers/gpu/dr=
m/msm/adreno/a8xx_gpu_state.c
> new file mode 100644
> index 0000000000000..e4eb2f335a890
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu_state.c
> @@ -0,0 +1,1253 @@

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
> +		if (regs->slice_region)
> +			a8xx_aperture_acquire_slice(gpu, PIPE_NONE, slice_id, false, &flags);
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

[ ... ]

> +static bool gen8_snapshot_mempool(struct msm_gpu *gpu,
> +				  struct adreno_gpu_state *state,
> +				  struct adreno_crashdumper *dumper)
> +{
> +	const struct gen8_snapshot_block_list *b =3D block_list(gpu);
> +	u32 slice_mask =3D to_a6xx_gpu(to_adreno_gpu(gpu))->slice_mask;
> +	u32 first_slice =3D ffs(slice_mask);
> +
> +	for (int i =3D 0; i < b->mempool_index_registers_len; i++) {
> +		const struct gen8_cp_indexed_reg *cp_indexed_reg =3D
> +			&b->mempool_index_registers[i];
> +		unsigned long flags;
> +		u32 j;
> +
> +		FOR_EACH_SLICE (j, cp_indexed_reg->slice_region, slice_mask) {
> +
> +			/* TODO: Remove hardcoded values */
> +			/* Set CP_CHICKEN_DBG[StabilizeMVC] to stabilize it while dumping */
> +			a8xx_aperture_acquire_slice(gpu, cp_indexed_reg->pipe_id, first_slice=
, false, &flags);
> +			gpu_rmw(gpu, REG_A8XX_CP_CHICKEN_DBG_PIPE, BIT(2), BIT(2));
> +			a8xx_aperture_release(gpu, flags);
> +
> +			a8xx_aperture_acquire_slice(gpu, cp_indexed_reg->pipe_id, j, true, &f=
lags);
> +			gpu_rmw(gpu, REG_A8XX_CP_SLICE_CHICKEN_DBG_PIPE, BIT(2), BIT(2));
> +			a8xx_aperture_release(gpu, flags);
> +
> +			gen8_snapshot_indexed_registers(gpu, state, dumper,
> +				cp_indexed_reg->addr,
> +				cp_indexed_reg->data, 0,
> +				cp_indexed_reg->size,
> +				cp_indexed_reg->pipe_id,
> +				HEADER_SLICE_ID(cp_indexed_reg->slice_region, j));
> +
> +			/* Reset CP_CHICKEN_DBG[StabilizeMVC] once we are done */
> +			a8xx_aperture_acquire_slice(gpu, cp_indexed_reg->pipe_id, first_slice=
, false, &flags);
> +			gpu_rmw(gpu, REG_A8XX_CP_CHICKEN_DBG_PIPE, BIT(2), 0);
> +			a8xx_aperture_release(gpu, flags);
> +
> +			a8xx_aperture_acquire_slice(gpu, cp_indexed_reg->pipe_id, j, true, &f=
lags);
> +			gpu_rmw(gpu, REG_A8XX_CP_SLICE_CHICKEN_DBG_PIPE, BIT(2), 0);
> +			a8xx_aperture_release(gpu, flags);
> +		}
> +	}
> +
> +	/* Clear aperture register */
> +	a8xx_aperture_clear(gpu);
> +
> +	return true;
> +}

[Severity: High]
In drivers/gpu/drm/msm/adreno/a8xx_gpu_state.c, when a8xx_gpu_state_get()
calls gen8_snapshot_mempool(), first_slice is computed as ffs(slice_mask).
Because ffs() returns a 1-based bit index (unlike a8xx_get_first_slice() in
drivers/gpu/drm/msm/adreno/a8xx_gpu.c, which uses ffs(a6xx_gpu->slice_mask)=
 -
1), passing first_slice to a8xx_aperture_acquire_slice() before modifying
REG_A8XX_CP_CHICKEN_DBG_PIPE programs an off-by-one slice ID. On a 1-slice
GPU such as Milos (where slice_mask is 0x1) or when slice ffs(slice_mask) is
fused off in slice_mask, this selects a non-existent or harvested slice.

In addition, for UNSLICE entries in b->mempool_index_registers, FOR_EACH_SL=
ICE
sets j =3D 0 regardless of slice_mask, and gen8_snapshot_mempool() still
programs the aperture for slice j =3D 0 with use_slice =3D true to modify
REG_A8XX_CP_SLICE_CHICKEN_DBG_PIPE even if slice 0 is fused off.

Finally, gen8_snapshot_mempool() ignores the return value of
gen8_snapshot_indexed_registers() and always returns true. If the crashdump=
er
times out during mempool capture, a8xx_gpu_state_get() will not bail out via
goto out and will continue issuing register accesses.

Should first_slice be ffs(slice_mask) - 1, should
REG_A8XX_CP_SLICE_CHICKEN_DBG_PIPE only be accessed when
cp_indexed_reg->slice_region =3D=3D SLICE, and should gen8_snapshot_mempool=
()
propagate failures from gen8_snapshot_indexed_registers()?

> +static void gen8_legacy_snapshot_mvc(struct msm_gpu *gpu,
> +				     struct adreno_gpu_state *state,
> +				     const struct gen8_cluster_registers *cluster,
> +				     u32 slice_id)
> +{
> +	int count;
> +
> +	/* Figure out how many registers we are going to dump */
> +	count =3D adreno_snapshot_regs_count(cluster->regs);
> +
> +	snapshot_sect (state, MVC_V3, 4 * count, {
> +		.ctxt_id =3D (cluster->context_id =3D=3D STATE_FORCE_CTXT_1) ? 1 : 0,
> +		.cluster_id =3D cluster->cluster_id,
> +		.pipe_id =3D cluster->pipe_id,
> +		.location_id =3D UINT_MAX,
> +		.sp_id =3D UINT_MAX,
> +		.usptp_id =3D UINT_MAX,
> +		.slice_id =3D HEADER_SLICE_ID(cluster->slice_region, slice_id),
> +	}) {
> +		unsigned long flags;
> +
> +		/*
> +		 * Set the AHB control for the Host to read from the
> +		 * cluster/context for this iteration.
> +		 */
> +		a8xx_aperture_acquire_slice(gpu, cluster->pipe_id, slice_id, true, &fl=
ags);
> +
> +		if (cluster->sel)
> +			gpu_write(gpu, cluster->sel->host_reg, cluster->sel->val);
> +
> +		/* Make sure the previous writes are posted before reading */
> +		mb();
> +
> +		for (const u32 *ptr =3D cluster->regs; ptr[0] !=3D UINT_MAX; ptr +=3D =
2) {
> +			snapshot_mvc_regs_v3_subheader(&sect, ptr);
> +
> +			for (int k =3D ptr[0]; k <=3D ptr[1]; k++) {
> +				snapshot_sect_u32(&sect, reg_read(gpu, k));
> +			}
> +		}
> +
> +		a8xx_aperture_release(gpu, flags);
> +	}
> +}

[Severity: Medium]
Does the host aperture programming in gen8_legacy_snapshot_mvc() and
gen8_legacy_snapshot_registers() in
drivers/gpu/drm/msm/adreno/a8xx_gpu_state.c match what the hardware expects
when dumping registers over AHB (for b->pre_crashdumper_regs and when dumper
is NULL, such as during an SMMU stall fault)?

1. In gen8_legacy_snapshot_mvc(), calling a8xx_aperture_acquire_slice() only
programs PIPEID, SLICEID, and USESLICEID in REG_A8XX_CP_APERTURE_CNTL_HOST,
leaving CLUSTERID and CONTEXTID3D as 0 (whereas the crashdumper path in
gen8_snapshot_mvc_regs() writes cluster->cluster_id and cluster->context_id
via GEN8_CP_APERTURE_REG_VAL()). All cluster and context-banked MVC registe=
rs
read on the CPU fallback path will therefore read cluster 0 and context 0.

2. In gen8_legacy_snapshot_registers():

		if (regs->sel)
			gpu_write(gpu, regs->sel->host_reg, regs->sel->val);

		if (regs->slice_region)
			a8xx_aperture_acquire_slice(gpu, PIPE_NONE, slice_id, false, &flags);

regs->sel->host_reg is written before acquiring the aperture lock or setting
the slice, a8xx_aperture_acquire_slice() is called with use_slice =3D false
instead of true for SLICE regions (omitting
A8XX_CP_APERTURE_CNTL_HOST_USESLICEID), and when a subsequent region has
regs->slice_region =3D=3D UNSLICE, the aperture is not cleared or updated, =
leaving
the previous slice selected.

3. Because a8xx_aperture_release() only drops a6xx_gpu->aperture_lock witho=
ut
clearing REG_A8XX_CP_APERTURE_CNTL_HOST, and the out: path in
a8xx_gpu_state_get() does not call a8xx_aperture_clear(gpu), a CPU-fallback
state capture during a non-reset SMMU stall fault leaves
REG_A8XX_CP_APERTURE_CNTL_HOST and a6xx_gpu->cached_aperture dirty for
subsequent host register accesses.

[ ... ]

> +static void gen8_legacy_snapshot_cluster_dbgahb(
> +	struct msm_gpu *gpu, struct adreno_gpu_state *state,
> +	const struct gen8_sptp_cluster_registers *cluster,
> +	u32 sp, u32 usptp, u32 slice_id)
> +{
> +	int count;
> +
> +	/* Figure out how many registers we are going to dump */
> +	count =3D adreno_snapshot_regs_count(cluster->regs);
> +
> +	snapshot_sect (state, MVC_V3, 4 * count, {
> +		.ctxt_id =3D cluster->context_id,
> +		.cluster_id =3D cluster->cluster_id,
> +		.pipe_id =3D cluster->pipe_id,
> +		.location_id =3D cluster->location_id,
> +		.sp_id =3D sp,
> +		.usptp_id =3D usptp,
> +		.slice_id =3D HEADER_SLICE_ID(cluster->slice_region, slice_id),
> +	}) {
> +		u32 read_sel =3D GEN8_SP_READ_SEL_VAL(
> +			0, slice_id, cluster->location_id, cluster->pipe_id,
> +			cluster->statetype, usptp, sp);
> +
> +		gpu_write(gpu, REG_A7XX_SP_READ_SEL, read_sel);

[ ... ]

> +static bool gen8_snapshot_dbgahb_regs(struct msm_gpu *gpu,
> +				      struct adreno_gpu_state *state,
> +				      struct adreno_crashdumper *dumper)
> +{

[ ... ]

> +					/* Build the crash script */
> +					struct cd_script p =3D CD_INIT(dumper);
> +
> +					u32 read_sel =3D GEN8_SP_READ_SEL_VAL(
> +						0, slice_id, cluster->location_id,
> +						cluster->pipe_id, cluster->statetype,
> +						usptp, sp);
> +
> +					/* Program the aperture */
> +					CD_WRITE(&p, REG_A7XX_SP_READ_SEL, read_sel);

[Severity: Medium]
In drivers/gpu/drm/msm/adreno/a8xx_gpu_state.c, both
gen8_legacy_snapshot_cluster_dbgahb() and gen8_snapshot_dbgahb_regs() record
.ctxt_id =3D cluster->context_id in the MVC_V3 section header, but pass a
hardcoded 0 instead of cluster->context_id as the first argument (_contexti=
d)
to GEN8_SP_READ_SEL_VAL() when programming REG_A7XX_SP_READ_SEL.

For multi-context SPTP cluster entries in the A8xx snapshot tables (where
cluster->context_id ranges from 0 to 15), won't this repeatedly dump contex=
t 0
for every context section?

[ ... ]

> +static void gen8_debugbus_internal_read_setup(struct msm_gpu *gpu)
> +{
> +	/* Clear the DBGC logic/events */
> +	gpu_write(gpu, REG_A6XX_DBGC_CFG_DBGBUS_CNTLM, 0x70000000);
> +
> +	/* Enable the internal buffer mode and program to tail mode */
> +	gpu_write(gpu, REG_A6XX_DBGC_CFG_DBGBUS_OPL, 0x28000000);
> +
> +	/* Program the logic unit 0 to high when the side data is 1 */
> +	gpu_write(gpu, REG_A6XX_DBGC_CFG_DBGBUS_BYTEL_0, 0x0000000c);
> +	gpu_write(gpu, REG_A6XX_DBGC_CFG_DBGBUS_MASKL_0, 0x000000f0);
> +
> +	/* Enable the DBGC logic/events */
> +	gpu_write(gpu, REG_A6XX_DBGC_CFG_DBGBUS_CNTLM, 0x07000000);
> +}

[ ... ]

> +static void gen8_snapshot_cx_dbgc_debugbus_block(
> +	struct msm_gpu *gpu, uint32_t block_id, size_t count,
> +	struct adreno_snapshot_sect *sect)
> +{
> +	/* This block requires an out of order access due to a HW limitation.
> +	 * (QCTDD12240539)
> +	 */
> +	if (block_id =3D=3D DEBUGBUS_CX_GC_US_I_0) {
> +		static u32 data[GEN8_DEBUGBUS_BLOCK_SIZE * 2];
> +		gen8_debugbus_internal_read_setup(gpu);
> +		for (int i =3D 0; i < GEN8_DEBUGBUS_BLOCK_IDX_1; i++)
> +			gen8_cx_gc_us_i_0_debugbus_read(gpu, block_id, i, &data[i * 2]);
> +		for (int i =3D GEN8_DEBUGBUS_BLOCK_IDX_2; i < GEN8_DEBUGBUS_BLOCK_SIZE=
; i++)
> +			gen8_cx_gc_us_i_0_debugbus_read(gpu, block_id, i, &data[i * 2]);
> +		for (int i =3D GEN8_DEBUGBUS_BLOCK_IDX_1; i < GEN8_DEBUGBUS_BLOCK_IDX_=
2; i++)
> +			gen8_cx_gc_us_i_0_debugbus_read(gpu, block_id, i, &data[i * 2]);
> +		snapshot_sect_arr(sect, data);
> +	} else {
> +		for (int i =3D 0; i < count; i++) {
> +			u32 data[2];
> +			gen8_cx_debug_bus_read(gpu, block_id, i, data);
> +			snapshot_sect_arr(sect, data);
> +		}
> +	}
> +}

[Severity: Medium]
In drivers/gpu/drm/msm/adreno/a8xx_gpu_state.c, gen8_get_debugbus() programs
the initial debugbus configuration into REG_A6XX_DBGC_CFG_DBGBUS_CNTLT,
REG_A6XX_DBGC_CFG_DBGBUS_CNTLM, REG_A6XX_DBGC_CFG_DBGBUS_IVTL_0..3,
REG_A6XX_DBGC_CFG_DBGBUS_BYTEL_0..1, and REG_A6XX_DBGC_CFG_DBGBUS_MASKL_0..3
before iterating through b->debugbus_blocks[] and b->gbif_debugbus_blocks[].

When gen8_snapshot_cx_dbgc_debugbus_block() encounters DEBUGBUS_CX_GC_US_I_0
(at index 2 of b->debugbus_blocks[] in the A8xx snapshot tables), it calls
gen8_debugbus_internal_read_setup(), which overwrites
REG_A6XX_DBGC_CFG_DBGBUS_CNTLM, REG_A6XX_DBGC_CFG_DBGBUS_OPL,
REG_A6XX_DBGC_CFG_DBGBUS_BYTEL_0, and REG_A6XX_DBGC_CFG_DBGBUS_MASKL_0 for
internal buffer mode.

Because those registers are not restored after reading DEBUGBUS_CX_GC_US_I_=
0,
won't all subsequent blocks in b->debugbus_blocks[] and
b->gbif_debugbus_blocks[] be read with the internal buffer mode configurati=
on
still active?

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
> +	/* If GX isn't on the rest of the data isn't going to be accessible */
> +	if (!a6xx_gmu_gx_is_on(adreno_gpu))
> +		return &state->base;

[Severity: High]
Can this cause unclocked or unpowered register accesses in
a8xx_gpu_state_get() in drivers/gpu/drm/msm/adreno/a8xx_gpu_state.c when st=
ate
capture is triggered via debugfs or fault/hang recovery while GX (or GMU MX=
 on
A850) is powered off?

First, at the top of a8xx_gpu_state_get(), REG_A8XX_RBBM_MISC_STATUS is read
before checking whether GX is powered on, even though stalled is only used
after the GX power check.

Second, the GX power check calls a6xx_gmu_gx_is_on(adreno_gpu) instead of
adreno_gpu->funcs->gx_is_on(adreno_gpu) (which points to a8xx_gmu_gx_is_on(=
)).
In drivers/gpu/drm/msm/adreno/a6xx_gmu.c:

bool a8xx_gmu_gx_is_on(struct adreno_gpu *adreno_gpu)
{
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

Calling a6xx_gmu_gx_is_on() reads REG_A6XX_GMU_SPTPRAC_PWR_CLK_STATUS (an
A6xx/A7xx register that is not valid on A8xx and accesses GMU MMIO even when
GMU MX is off on A850) and checks the wrong bits, allowing
a8xx_gpu_state_get() to proceed with GX register accesses when GX is powered
off.

[ ... ]

> diff --git a/drivers/gpu/drm/msm/adreno/adreno_snapshot.h b/drivers/gpu/d=
rm/msm/adreno/adreno_snapshot.h
> index f9956e0bc1d5f..e8ff102a628b7 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_snapshot.h
> +++ b/drivers/gpu/drm/msm/adreno/adreno_snapshot.h

[ ... ]

> +static inline void CD_WRITE(struct cd_script *p, u32 reg, u32 val)
> +{
> +	*(p->in++) =3D val;
> +	*(p->in++) =3D FIELD_PREP(GENMASK(63, 44), reg) | BIT(21) | BIT(0);
> +	__cd_check_overflow(p);
> +}
> +
> +static inline void CD_READ(struct cd_script *p, u32 reg, u32 dwords)
> +{
> +	*(p->in++) =3D p->out;
> +	*(p->in++) =3D FIELD_PREP(GENMASK(63, 44), reg) | dwords;
> +	p->out +=3D sizeof(u32) * dwords;
> +	__cd_check_overflow(p);
> +}

[Severity: Low]
In drivers/gpu/drm/msm/adreno/adreno_snapshot.h, CD_WRITE() and CD_READ() u=
se
GENMASK(63, 44) to build a 64-bit value for u64 *in. On 32-bit architectures
(such as 32-bit ARM builds with CONFIG_DRM_MSM and CONFIG_DRM_MSM_GPU_STATE
enabled), GENMASK() uses unsigned long (32-bit), which overflows the shift
count and triggers a BUILD_BUG_ON_MSG() failure in FIELD_PREP(). Should the=
se
use GENMASK_ULL(63, 44) instead?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020204728.2884=
4-1-robin.clark@oss.qualcomm.com?part=3D9
