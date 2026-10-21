Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C6C606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 21:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=asFjCVGl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A831F10E2B5;
	Wed, 21 Oct 2026 21:15:58 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F26F210E2B5
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 21:15:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0294D60098;
 Wed, 21 Oct 2026 21:15:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97CF31F000C1;
 Wed, 21 Oct 2026 21:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792617350;
 bh=YQyb8Jx7bsthoumof3CCnhkVP+oPJx9g6e5cUliyzfE=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=asFjCVGlNALhy6rAgUE4M2pzTtc+FsUtyYgs2VTPEqdJYwExy8D9qZhU/OnZLdNEe
 cTObEBo8JKs0A2h8V5xHun8dKuN1fTiUjwmF2mle32hZqA8GjYpAjudds1U5mMhjhE
 Zn3ATmsrGzzIDa+z48iJJA5dbSzNWWcZSBYoDZsOgJgSONwYD45CBL9G+VPkTth+L6
 Xfn9hC1zxoy8kTRkJhOsCAvPSOHSmJihde15ewAdjI3Wc88L8RIXQEkXGEgAH8ahBe
 3KbV/UExOi/qpihx6dSQCrtEzYZNmj6jv+Jt9OtvHIgm1qWPSKPPLXN+1tXjY8Nqex
 1c9Cete0Vv6hQ==
Message-ID: <sashiko-outbox-180689@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/14] drm/msm/a8xx: devcoredump state capture support
To: "Rob Clark" <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261021204244.67160-12-robin.clark@oss.qualcomm.com>
References: <20261021204244.67160-1-robin.clark@oss.qualcomm.com>
 <20261021204244.67160-12-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 21:15:50 +0000
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
- [High] drm/msm/a8xx: wrong GX power check and unpowered read in a8xx_gpu_=
state_get()
- [High] drm/msm/a8xx: NULL dereference in __snapshot_sect_fini() on alloc =
failure
- [Medium] drm/msm/a8xx: inverted return check in gen8_snapshot_mempool()
- [Medium] drm/msm/a8xx: unrestored DBGC config after gen8_debugbus_interna=
l_read_setup()
- [Medium] drm/msm/a8xx: missing aperture clear and unlocked sel write in s=
tate dump
- [Low] drm/msm/a8xx: 32-bit build failure in CD_WRITE() and CD_READ() with=
 GENMASK()
--

commit 219b73628f6b0835c639eddc9f3de8e4b31b60a5
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm/a8xx: devcoredump state capture support

This commit adds devcoredump GPU state capture and crashdumper support for
Adreno Gen8 (A8xx) GPUs, along with snapshot section builder helpers.

> diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu_state.c b/drivers/gpu/dr=
m/msm/adreno/a8xx_gpu_state.c
> new file mode 100644
> index 0000000000000..b0b2624da5e08
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu_state.c
> @@ -0,0 +1,1278 @@

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
In drivers/gpu/drm/msm/adreno/a8xx_gpu_state.c,
gen8_legacy_snapshot_registers() writes regs->sel->host_reg before calling
a8xx_aperture_acquire_raw(), unlike gen8_legacy_snapshot_mvc() which acquir=
es
the aperture first. Should the selector write happen after acquiring the
slice aperture so that it is serialized under a6xx_gpu->aperture_lock and
routed to the target slice?

Also, a8xx_aperture_acquire_raw() programs REG_A8XX_CP_APERTURE_CNTL_HOST a=
nd
updates a6xx_gpu->cached_aperture, while a8xx_aperture_release() only drops
a6xx_gpu->aperture_lock without clearing the register. When state is captur=
ed
through the host AHB path (such as for b->pre_crashdumper_regs, or when
dumper is NULL during an SMMU stall-on-fault via
adreno_fault_handler() -> msm_gpu_fault_crashstate_capture() ->
msm_gpu_crashstate_capture() -> a8xx_gpu_state_get()), can leaving the
aperture programmed after SLICE register lists,
gen8_snapshot_cp_indexed_regs(), or gen8_legacy_snapshot_mvc() misroute
subsequent UNSLICE reads and later un-apertured host MMIO accesses?

drivers/gpu/drm/msm/adreno/a8xx_gpu_state.c:gen8_legacy_snapshot_mvc() {
	...
		u32 val =3D GEN8_CP_APERTURE_REG_VAL(
			slice_id, cluster->pipe_id,
			cluster->cluster_id, cluster->context_id);
		a8xx_aperture_acquire_raw(gpu, val, &flags);
	...
		a8xx_aperture_release(gpu, flags);
	}
}

drivers/gpu/drm/msm/adreno/a8xx_gpu_state.c:a8xx_gpu_state_get() {
	...
out:
	gpu_write(gpu, REG_A8XX_RBBM_SNAPSHOT_STATUS, 0x0);
	...
	return  &state->base;
}

Should gen8_legacy_snapshot_registers(), gen8_snapshot_mvc_regs(), and the
out path of a8xx_gpu_state_get() call a8xx_aperture_clear(gpu) to reset the
host aperture back to PIPE_NONE?

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
> +			if (ret)
> +				break;
> +		}
> +	}
> +
> +	/* Clear aperture register */
> +	a8xx_aperture_clear(gpu);
> +
> +	return ret;
> +}

[Severity: Medium]
In drivers/gpu/drm/msm/adreno/a8xx_gpu_state.c,
gen8_snapshot_indexed_registers() returns true on success and false when
CD_RUN() fails or times out:

drivers/gpu/drm/msm/adreno/a8xx_gpu_state.c:gen8_snapshot_indexed_registers=
() {
	...
	if (CD_RUN(&p, gpu))
		return false;

	snapshot_sect (state, INDEXED_REGS_V2, count * sizeof(u32), hdr) {
		const u32 *src =3D dumper->ptr + A8XX_CD_DATA_OFFSET;
		snapshot_sect_data(&sect, src, count * sizeof(u32));
	}

	return true;
}

In a8xx_gpu_state_get() -> gen8_snapshot_mempool(), doesn't checking
if (ret) break; invert the return value check?

When gen8_snapshot_indexed_registers() succeeds (ret is true), the inner
FOR_EACH_SLICE loop breaks after the first slice, skipping all remaining
slices on multi-slice GPUs. Conversely, when CD_RUN() times out (ret is
false), the loop continues to the next slice and the next entry in
b->mempool_index_registers, issuing further hardware accesses on a wedged
crashdumper and potentially overwriting ret with true.

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
REG_A6XX_DBGC_CFG_DBGBUS_CNTLT, REG_A6XX_DBGC_CFG_DBGBUS_CNTLM,
REG_A6XX_DBGC_CFG_DBGBUS_IVTL_0..3, REG_A6XX_DBGC_CFG_DBGBUS_BYTEL_0..1, and
REG_A6XX_DBGC_CFG_DBGBUS_MASKL_0..3 once before iterating through
b->debugbus_blocks and b->gbif_debugbus_blocks.

When gen8_snapshot_cx_dbgc_debugbus_block() encounters DEBUGBUS_CX_GC_US_I_=
0,
it calls gen8_debugbus_internal_read_setup(), which overwrites
REG_A6XX_DBGC_CFG_DBGBUS_OPL (enabling internal buffer mode),
REG_A6XX_DBGC_CFG_DBGBUS_BYTEL_0, REG_A6XX_DBGC_CFG_DBGBUS_MASKL_0, and
REG_A6XX_DBGC_CFG_DBGBUS_CNTLM.

Because those registers are not restored after reading DEBUGBUS_CX_GC_US_I_=
0,
won't all subsequent blocks in b->debugbus_blocks and b->gbif_debugbus_bloc=
ks
read corrupted debugbus data through gen8_cx_debug_bus_read() while DBGC
remains in internal buffer mode?

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
In drivers/gpu/drm/msm/adreno/a8xx_gpu_state.c, a8xx_gpu_state_get() reads
REG_A8XX_RBBM_MISC_STATUS at the top of the function before checking whether
the GX power domain is on, and then checks GX power by calling
a6xx_gmu_gx_is_on(adreno_gpu) instead of a8xx_gmu_gx_is_on(adreno_gpu) (or
adreno_gpu->funcs->gx_is_on(adreno_gpu)).

In drivers/gpu/drm/msm/adreno/a6xx_gmu.c, a6xx_gmu_gx_is_on() reads
REG_A6XX_GMU_SPTPRAC_PWR_CLK_STATUS and checks the A6xx bit definitions,
whereas A8xx reports GX power and clock status via
REG_A8XX_CX_MISC_GFX_PWR_CLK_STATUS (on the A850 family, avoiding GMUCX rea=
ds
when GMU MX is off) or REG_A8XX_GMU_PWR_CLK_STATUS in a8xx_gmu_gx_is_on():

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

When a8xx_gpu_state_get() is called while GX is power-collapsed (for example
during IFPC or a GMU fault), can reading REG_A8XX_RBBM_MISC_STATUS before t=
he
power check and calling a6xx_gmu_gx_is_on() cause unpowered GX or GMU MMIO
accesses and trigger a bus error or SError panic?

[ ... ]

> diff --git a/drivers/gpu/drm/msm/adreno/adreno_snapshot.h b/drivers/gpu/d=
rm/msm/adreno/adreno_snapshot.h
> index f9956e0bc1d5f..1847bca38fe4a 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_snapshot.h
> +++ b/drivers/gpu/drm/msm/adreno/adreno_snapshot.h

[ ... ]

> @@ -319,3 +329,199 @@ struct adreno_snapshot_gmu_version {

[ ... ]

> +static void __snapshot_sect_fini(struct adreno_snapshot_sect *s)
> +{
> +	struct adreno_snapshot_section_header *hdr =3D (void *)s->obj->ptr;
> +	hdr->size =3D s->obj->size =3D ((u8 *)s->cur - (u8 *)s->obj->ptr);
> +}
> +
> +DEFINE_FREE(sect_fini, struct adreno_snapshot_sect, __snapshot_sect_fini=
(&_T));
> +
> +static struct adreno_snapshot_sect
> +__snapshot_sect_init(struct adreno_gpu_state *state, uint16_t id, size_t=
 extra_sz,
> +		     void *sect_hdr, size_t sect_hdr_sz, const char *func, int line)
> +{
> +	/* A few section types have no section header: */
> +	switch (id) {
> +	case ADRENO_SNAPSHOT_SECTION_REGS_V2:
> +		sect_hdr_sz =3D 0;
> +	default:
> +		break;
> +	}
> +
> +	pr_debug("%s:%d: snapshot_sect(id=3D%04x, extra_sz=3D%zu, sect_hdr_sz=
=3D%zu)\n",
> +		 func, line, id, extra_sz, sect_hdr_sz);
> +
> +	size_t sz =3D sizeof(struct adreno_snapshot_section_header) + sect_hdr_=
sz + extra_sz;
> +	struct adreno_state_memobj *obj =3D kzalloc_obj(*obj);
> +	void *ptr =3D kvzalloc(sz, GFP_KERNEL);
> +
> +	if (!obj || !ptr) {
> +		kfree(obj);
> +		kvfree(ptr);
> +		return (struct adreno_snapshot_sect){};
> +	}

[ ... ]

> +#define __snapshot_sect(_label, _state, _id, _extra_sz, ...)		\
> +	for (struct adreno_snapshot_sect sect __free(sect_fini) =3D ({	\
> +		struct STRUCT_ ## _id sect_hdr =3D __VA_ARGS__;		\
> +		__snapshot_sect_init(_state, ADRENO_SNAPSHOT_SECTION_ ## _id,	\
> +				     _extra_sz, &sect_hdr, 		\
> +				     sizeof(sect_hdr), 			\
> +				     __func__, __LINE__); });		\
> +	     sect.obj; ({ goto _label; }))				\
> +		if (false) {						\
> +_label:									\
> +			break;						\
> +		} else

[Severity: High]
In drivers/gpu/drm/msm/adreno/adreno_snapshot.h, if kzalloc_obj() or
kvzalloc() fails in __snapshot_sect_init() (which is particularly likely wh=
en
a8xx_gpu_state_get() is invoked from recover_worker() or
msm_gpu_fault_crashstate_capture() under memalloc_noreclaim_save()),
__snapshot_sect_init() returns a zeroed struct adreno_snapshot_sect with
sect.obj set to NULL.

When the for loop in __snapshot_sect() checks sect.obj, sees NULL, and exits
its scope, the __free(sect_fini) cleanup handler still runs
__snapshot_sect_fini(&sect). Since neither sect_fini nor
__snapshot_sect_fini() checks if (s->obj), won't dereferencing s->obj->ptr
cause a NULL pointer dereference?

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
GENMASK(63, 44) with FIELD_PREP() to build 64-bit crashdumper script entrie=
s.
Because drivers/gpu/drm/msm/adreno/a8xx_gpu_state.o is built whenever
CONFIG_DRM_MSM_GPU_STATE is enabled, including on 32-bit ARM builds where
unsigned long is 32 bits wide, won't GENMASK(63, 44) fail to compile on
32-bit architectures unless GENMASK_ULL(63, 44) is used?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021204244.6716=
0-1-robin.clark@oss.qualcomm.com?part=3D11
