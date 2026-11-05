Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38266606A326
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 21:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RiMp8bYX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D31611230F;
	Thu,  5 Nov 2026 21:41:25 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BAF41124BC
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 21:41:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4179640DDA;
 Thu,  5 Nov 2026 21:41:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04F311F0089F;
 Thu,  5 Nov 2026 21:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793914879;
 bh=Vfk1GQFC7T3sUuGuXV37LsCirLvqPhN5qI1Lzs68Tk8=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=RiMp8bYXsluIQAbpX5FN/nAX+gGDVZKdeUS2cOEdnTUrvar6vnOL9sV8jQhwS6oNh
 IlbUNuLDjFKUbBtlKmkg8eSC8S9gda5/YvGj/NOayLKTkL3GgivL+yOTbQo3ZK8MtA
 fwagPhxcxBoUo4HHMnbTYAKDRawR23xbGpZUYI9IXGxyqYLtPHnKlmJGwVKaJsnrZH
 nYh7f0nyLJ7KXid1gTry0giabySr+u/pAzD2wT3xiU9xfCisqlau0lE7CNRTeTQ5Yw
 efmyTVQZGcnMf4N37149IXKVEHl4mADYJS+/09Um5Yv0A3BVi/9Les+0v8EKF8yLhb
 /D5sGVKJkdfCg==
Message-ID: <sashiko-outbox-200256@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 11/15] drm/msm/a8xx: devcoredump state capture support
To: "Rob Clark" <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261105203057.66520-12-robin.clark@oss.qualcomm.com>
References: <20261105203057.66520-1-robin.clark@oss.qualcomm.com>
 <20261105203057.66520-12-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 21:41:18 +0000
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] drm/msm/a8xx: disabled slice 0 access in gen8_snapshot_mempool()
- [Medium] drm/msm/a8xx: 9-bit PING_BLK_SEL mask truncates Slice 3 debugbus=
 IDs
- [Medium] drm/msm/a8xx: un-cleared CP_APERTURE_CNTL_HOST in a8xx_gpu_state=
_get()
- [Medium] drm/msm/a8xx: snapshot_debugbus ignored in a8xx_gpu_state_get()
- [Low] drm/msm/a8xx: missing linux/bitfield.h include in adreno_snapshot.h=
 and a8xx_gpu_state.c
--

commit f22e1319de2cba0abee931eb64f476ff41f591ee
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm/a8xx: devcoredump state capture support

This commit adds GPU state capture and devcoredump support for Adreno A8xx
GPUs, including register, indexed register, mempool, MVC cluster, shader,
debugbus, and GMU state dumping.

> diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu_state.c b/drivers/gpu/dr=
m/msm/adreno/a8xx_gpu_state.c
> new file mode 100644
> index 0000000000000..0692e21da59c8
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu_state.c
> @@ -0,0 +1,1403 @@

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

[Severity: High]
As reported by Sashiko on v5 [1], on A8xx GEN2+ GPUs with partial slice
configurations where slice 0 is disabled in a6xx_gpu->slice_mask, can
gen8_snapshot_mempool() access a fused-off slice and trigger an AHB/NoC bus
error?

In b->mempool_index_registers, the first two entries have slice_region set =
to
UNSLICE. For UNSLICE entries, FIRST_SLICE(UNSLICE, slice_mask) sets j =3D 0
regardless of a6xx_gpu->slice_mask.

While the REG_A8XX_CP_CHICKEN_DBG_PIPE update uses first_slice, the
subsequent update to the per-slice register REG_A8XX_CP_SLICE_CHICKEN_DBG_P=
IPE
uses GEN8_CP_APERTURE_REG_VAL(j, pipe_id, 0, 0), which selects slice 0 when
j =3D 0 even if slice 0 is not present in slice_mask.

Should FIRST_SLICE() start at next_slice(0, _slice_mask), or should
REG_A8XX_CP_SLICE_CHICKEN_DBG_PIPE only be programmed when
cp_indexed_reg->slice_region =3D=3D SLICE?

[ ... ]

> +static void gen8_dbgc_debugbus_select(struct msm_gpu *gpu, u32 block_id,=
 u32 index)
> +{
> +	u32 reg;
> +
> +	reg =3D A7XX_DBGC_CFG_DBGBUS_SEL_D_PING_INDEX(index) |
> +		A7XX_DBGC_CFG_DBGBUS_SEL_D_PING_BLK_SEL(block_id);

[Severity: Medium]
Does A7XX_DBGC_CFG_DBGBUS_SEL_D_PING_BLK_SEL(block_id) truncate Slice 3
debugbus block IDs on 4-slice A8xx GPUs such as Glymur?

In drivers/gpu/drm/msm/adreno/adreno_gen8_snapshot.h and
drivers/gpu/drm/msm/adreno/catalog/adreno_glymur.h, the Slice 3 debugbus
blocks (DEBUGBUS_CP_GC_S_3_I_0 through DEBUGBUS_VFD_GC_S_3_I_1) have block
IDs 512 through 593, which require 10 bits.

However, DBGC_CFG_DBGBUS_SEL_D in drivers/gpu/drm/msm/registers/adreno/a6xx=
.xml
defines PING_BLK_SEL as bits 24:16 (9 bits, max 511):

	<reg32 offset=3D"0x0603" name=3D"DBGC_CFG_DBGBUS_SEL_D" variants=3D"A7XX-">
		<bitfield high=3D"7" low=3D"0" name=3D"PING_INDEX"/>
		<bitfield high=3D"24" low=3D"16" name=3D"PING_BLK_SEL"/>
	</reg32>

When block_id is 512..593, A7XX_DBGC_CFG_DBGBUS_SEL_D_PING_BLK_SEL(block_id)
masks off bit 9 and selects unslice debugbus blocks 0..81 instead.

[ ... ]

> +	gen8_snapshot_cx_debugbus(gpu, state);
> +
> +	/* If GX isn't on the rest of the data isn't going to be accessible */
> +	if (!adreno_gpu->funcs->gx_is_on(adreno_gpu))
> +		return &state->base;
> +
> +	gen8_snapshot_debugbus(gpu, state);

[Severity: Medium]
Should gen8_snapshot_cx_debugbus() and gen8_snapshot_debugbus() in
a8xx_gpu_state_get() be guarded by the snapshot_debugbus module parameter,
similar to a6xx_gpu_state_get()?

Currently these run unconditionally even when snapshot_debugbus is false by
default, which includes debugbus data in devcoredumps without opt-in and ad=
ds
over 100 ms of udelay(1) waits while holding gpu->lock (including during SM=
MU
stall-on-fault page fault captures).

[ ... ]

> +out:
> +	gpu_write(gpu, REG_A8XX_RBBM_SNAPSHOT_STATUS, 0x0);
> +
> +	if (dumper)
> +		msm_gem_kernel_put(dumper->bo, gpu->vm);
> +
> +	state->gpu_initialized =3D !gpu->needs_hw_init;
> +
> +	return  &state->base;
> +}

[Severity: Medium]
As reported by Sashiko on v5 [1], should a8xx_gpu_state_get() call
a8xx_aperture_clear(gpu) at the out label before returning?

When dumper is NULL (such as during SMMU stall-on-fault devcoredump capture
via adreno_fault_handler() -> msm_gpu_fault_crashstate_capture(), where the
GPU continues running without a reset) or when an earlier step jumps to out
before gen8_snapshot_mempool() clears the aperture, gen8_snapshot_mvc_regs(=
),
gen8_snapshot_cp_indexed_regs(), and gen8_legacy_snapshot_registers() leave
REG_A8XX_CP_APERTURE_CNTL_HOST and a6xx_gpu->cached_aperture programmed with
A8XX_CP_APERTURE_CNTL_HOST_USESLICEID and non-zero slice, pipe, cluster, and
context IDs.

Leaving A8XX_CP_APERTURE_CNTL_HOST_USESLICEID set causes subsequent host
writes that expect broadcast mode, such as
REG_A8XX_RBBM_SLICE_PERFCTR_FLUSH_HOST_CMD in a8xx_perfcntr_flush(), to only
reach a single slice, and leaves a6xx_gpu->cached_aperture out of sync with
the hardware reset value across IFPC.

Also, in gen8_legacy_snapshot_registers(), regs->sel->host_reg is written
before a8xx_aperture_acquire_raw() acquires a6xx_gpu->aperture_lock and
selects the target slice. Should the regs->sel->host_reg write happen after
acquiring the aperture, matching gen8_legacy_snapshot_mvc() and the
crashdumper path in gen8_reglist_snapshot()?

> diff --git a/drivers/gpu/drm/msm/adreno/adreno_snapshot.h b/drivers/gpu/d=
rm/msm/adreno/adreno_snapshot.h
> index f9956e0bc1d5f..1c56be7249f76 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_snapshot.h
> +++ b/drivers/gpu/drm/msm/adreno/adreno_snapshot.h

[ ... ]

> +static inline void CD_WRITE(struct cd_script *p, u32 reg, u32 val)
> +{
> +	*(p->in++) =3D val;
> +	*(p->in++) =3D FIELD_PREP(GENMASK_U64(63, 44), reg) | BIT(21) | BIT(0);
> +	__cd_check_overflow(p);
> +}
> +
> +static inline void CD_READ(struct cd_script *p, u32 reg, u32 dwords)
> +{
> +	*(p->in++) =3D p->out;
> +	*(p->in++) =3D FIELD_PREP(GENMASK_U64(63, 44), reg) | dwords;
> +	p->out +=3D sizeof(u32) * dwords;
> +	__cd_check_overflow(p);
> +}

[Severity: Low]
As reported by kernel test robot on v5 [2], adreno_snapshot.h and
a8xx_gpu_state.c use FIELD_PREP() and FIELD_GET() (in CD_WRITE(), CD_READ(),
gen8_dbgc_side_debug_bus_read(), gen8_cx_side_debug_bus_read(), and
a8xx_gpu_state_get()) without including linux/bitfield.h.

Can this cause implicit function declaration build failures on architectures
where linux/bitfield.h is not pulled in transitively?

[1] https://lore.kernel.org/r/sashiko-outbox-194286@kernel.org
[2] https://lore.kernel.org/r/202611040652.1Wy2glVj-lkp@intel.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105203057.6652=
0-1-robin.clark@oss.qualcomm.com?part=3D11
