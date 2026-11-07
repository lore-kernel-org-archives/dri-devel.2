Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0758606EE93
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 00:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gAAWmQHD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11D5110E053;
	Sat,  7 Nov 2026 00:47:15 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A2CB10E053
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 00:47:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4493541FD1;
 Sat,  7 Nov 2026 00:47:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D0CA1F0089F;
 Sat,  7 Nov 2026 00:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794012428;
 bh=7GEw0Z0jPxlt332C1AncAQAjdMf8+3lvJai5u1Jw4AM=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=gAAWmQHD5KdlyLvwZXZmISlS+etuu9zz+PcwrDg6Sn5ZVKpkEV7sfdalp5dX2hl6+
 8kbt1VTwGK0tH0kfgJStbJMl0dz4XieDqjRprvTeh1kNtpElmTqJUGTGtHR/nSIqRv
 g/JOKPmSI1WoSxHfe8SOwLY8uNJJ6qJvp6krQXAoNAOX3rdIegnApf0zMtol7tKA0u
 1nCQHTTZ3HYqF2wkTRNLRICkYpFIc4kdntBjPClVV/R7BH8Q4q6kPWyDiU9YNZtuaf
 6emsHPJPzEgCrwt6M2I/bD8geIk1ueG3R33ud+v4Ow/lK0HQfIZGKO5pGzFoeCggyl
 A3CQmyJw+4hKQ==
Message-ID: <sashiko-outbox-202444@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 11/15] drm/msm/a8xx: devcoredump state capture support
To: "Rob Clark" <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261106232220.47602-12-robin.clark@oss.qualcomm.com>
References: <20261106232220.47602-1-robin.clark@oss.qualcomm.com>
 <20261106232220.47602-12-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 00:47:07 +0000
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

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] drm/msm/a8xx: disabled slice 0 access in
  gen8_snapshot_mempool()
- [Medium] drm/msm/a8xx: missing IFPC inhibition and SQE halt in
  a8xx_gpu_state_get()
- [Low] drm/msm/a8xx: wrong CX_DBGC bitfield macros in
  gen8_cx_dbgc_debugbus_select()
- [Low] drm/msm/a8xx: unguarded gen8_snapshot_cx_debugbus() in
  a8xx_gpu_state_get()
--

commit b9d6ff67c11eafc0f39228630710e009a3fbc430
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm/a8xx: devcoredump state capture support

This commit adds GPU devcoredump state capture and crashdumper support for
Adreno A8xx GPUs.

> diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu_state.c b/drivers/gpu/dr=
m/msm/adreno/a8xx_gpu_state.c
> new file mode 100644
> index 0000000000000..44cf8ff75f98d
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu_state.c
> @@ -0,0 +1,1407 @@

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
Can gen8_snapshot_mempool() access REG_A8XX_CP_SLICE_CHICKEN_DBG_PIPE on
slice 0 when slice 0 is fused off?

In b->mempool_index_registers, the CP_MEM_POOL_DBG_ADDR_PIPE entries have
slice_region =3D=3D UNSLICE, for which FIRST_SLICE() sets j =3D 0 regardles=
s of
slice_mask.  Unlike REG_A8XX_CP_CHICKEN_DBG_PIPE (which uses first_slice),
the RMWs to the per-slice register REG_A8XX_CP_SLICE_CHICKEN_DBG_PIPE use
GEN8_CP_APERTURE_REG_VAL(j, pipe_id, 0, 0), performing an AHB access to
slice 0 even when it is disabled in slice_mask, which can trigger an AHB or
NoC bus error during crashstate capture.

Should REG_A8XX_CP_SLICE_CHICKEN_DBG_PIPE only be modified when
cp_indexed_reg->slice_region =3D=3D SLICE (or using first_slice for UNSLICE=
)?

[ ... ]

> +static void gen8_cx_dbgc_debugbus_select(struct msm_gpu *gpu, u32 block_=
id, u32 index)
> +{
> +	u32 reg;
> +
> +	reg =3D A7XX_CX_DBGC_CFG_DBGBUS_SEL_A_PING_INDEX(index) |
> +		A7XX_CX_DBGC_CFG_DBGBUS_SEL_A_PING_BLK_SEL(block_id);

[Severity: Low]
Should this use A8XX_CX_DBGC_CFG_DBGBUS_SEL_A_PING_INDEX() and
A8XX_CX_DBGC_CFG_DBGBUS_SEL_A_PING_BLK_SEL() instead of the A7XX macros?
This patch adds the wider A8XX_CX_DBGC domain in a6xx.xml, but leaves it
unused here.

[ ... ]

> +	snapshot_sect (state, DEBUG, 4, {
> +		.type =3D SNAPSHOT_DEBUG_SLICE_MASK,
> +		.size =3D 1,
> +	}) {
> +		snapshot_sect_u32(&sect, a6xx_gpu->slice_mask);
> +	}
> +	gen8_snapshot_cx_debugbus(gpu, state);

[Severity: Low]
Should gen8_snapshot_cx_debugbus() be guarded by snapshot_debugbus, matching
gen8_snapshot_debugbus() below and a6xx_get_debugbus() on A6xx/A7xx?

> +	/* If GX isn't on the rest of the data isn't going to be accessible */
> +	if (!adreno_gpu->funcs->gx_is_on(adreno_gpu))
> +		return &state->base;
> +
> +	if (snapshot_debugbus)
> +		gen8_snapshot_debugbus(gpu, state);
> +
> +	/*
> +	 * Try to initialize the crashdumper, if we are not dumping state
> +	 * with the SMMU stalled.  The crashdumper needs memory access to
> +	 * write out GPU state, so we need to skip this when the SMMU is
> +	 * stalled in response to an iova fault
> +	 */
> +	bool stalled =3D !!(gpu_read(gpu, REG_A8XX_RBBM_MISC_STATUS) &
> +			A8XX_RBBM_MISC_STATUS_SMMU_STALLED_ON_FAULT);
> +	if (!stalled && !gpu->needs_hw_init &&
> +	    !a8xx_crashdumper_init(gpu, &_dumper)) {
> +		dumper =3D &_dumper;
> +	}

[Severity: Medium]
As reported by Alexander Koskovich on v2 [1], can GX enter IFPC after the
gx_is_on() check while a8xx_gpu_state_get() is still dumping state?

Unlike a6xx_gpu_state_get(), a8xx_gpu_state_get() does not halt SQE via
REG_A8XX_CP_SQE_CNTL and holds no GMU OOB or keepalive vote to inhibit IFPC
across gen8_snapshot_debugbus(), the 4 MB GEM BO allocation in
a8xx_crashdumper_init(), and the subsequent crashdumper and GX register
accesses.  If in-flight work finishes during this window, the GMU collapses
GX into IFPC and enables the AHB fence mid-snapshot, causing GMU fence
errors and a crashdumper timeout warning in __cd_run().

[1] https://lore.kernel.org/r/FZvwtKTpIxRNzjzcqFf6bTw12mNTJvJZmg6j9lmi8MehH=
Bt91NogIW8oQd5yFHN5DSL8yIWL8p_b1cJPAJC57ZFkoe2BOAh_Y3kwph5SV_A=3D@pm.me

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106232220.4760=
2-1-robin.clark@oss.qualcomm.com?part=3D11
