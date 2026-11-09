Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8F7606A322
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 14:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YbeqrCsY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 514B710E48B;
	Mon,  9 Nov 2026 14:49:03 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1E8110F35E
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 14:48:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0B364633A7;
 Mon,  9 Nov 2026 14:48:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C0D1F0089F;
 Mon,  9 Nov 2026 14:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794235735;
 bh=AHSIxd3NrH7jTUQtHk9OdBtQ9taS5EaNRqGjrrOJRYQ=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=YbeqrCsYr9UWLtKej/DWDC2jse5uCXzhorUK8PDB6ueGbpzexpImtHmAoonvCCrJU
 TcJj4LusWAdvtDJ0JMBFaxuHKoIhVwCxm0ylEFEFoHQLhFBEf5gGkhvFTMgdgZRw8W
 JAaFXRotfMzL1gZZo2xbJ3h4PGfJfnyYrZ0otOmFkS8qth+JKwXX9WLyoMXPYFU4al
 TWY3wuS/hxCZD+cc3yRqL4fLCxDOBuQ7kc5KR0s5Iln8g3oA8KFZeBgNSKavKpp8CD
 rk/IbiudvCVCqgO+JdP/+QyIIrgBghZvswBD8RgyTufZbzhP3goytSCgihuTDin5XB
 4cQ0qx29/r3bQ==
Message-ID: <sashiko-outbox-205129@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 11/15] drm/msm/a8xx: devcoredump state capture support
To: "Rob Clark" <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261109142111.256630-12-robin.clark@oss.qualcomm.com>
References: <20261109142111.256630-1-robin.clark@oss.qualcomm.com>
 <20261109142111.256630-12-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 14:48:55 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] drm/msm/a8xx: disabled slice 0 access in
  gen8_snapshot_mempool()
- [Medium] drm/msm/a8xx: swapped mux indices in
  gen8_cx_gc_us_i_0_debugbus_read()
- [Medium] drm/msm/a8xx: missing SQE halt and IFPC inhibition in
  a8xx_gpu_state_get()
--

commit 7342e242e878452594649efb772cccc770f9460e
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm/a8xx: devcoredump state capture support

This commit adds devcoredump GPU state capture and crashdumper support for
Adreno A8xx GPUs.

> diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu_state.c b/drivers/gpu/dr=
m/msm/adreno/a8xx_gpu_state.c
> new file mode 100644
> index 0000000000000..57c0ae1ef789a
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu_state.c
> @@ -0,0 +1,1409 @@
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
> +
> +			if (!ret)
> +				break;
> +		}
> +	}

[Severity: High]
Can gen8_snapshot_mempool() access REG_A8XX_CP_SLICE_CHICKEN_DBG_PIPE on
slice 0 when slice 0 is fused off in a6xx_gpu->slice_mask?

In b->mempool_index_registers, the first two entries have
cp_indexed_reg->slice_region =3D=3D UNSLICE.  For UNSLICE entries,
FIRST_SLICE() sets j =3D 0 regardless of slice_mask, and the loop
unconditionally programs GEN8_CP_APERTURE_REG_VAL(j, pipe_id, 0, 0) and
calls gpu_rmw() on the per-slice register
REG_A8XX_CP_SLICE_CHICKEN_DBG_PIPE.  On A8xx GEN2+ targets where slice 0
is disabled in REG_A8XX_CX_MISC_SLICE_ENABLE_FINAL, touching slice 0 over
AHB can trigger an AHB/NoC bus error and crash the system.

Should REG_A8XX_CP_SLICE_CHICKEN_DBG_PIPE only be modified when
cp_indexed_reg->slice_region =3D=3D SLICE (or using first_slice)?

[ ... ]

> +static void gen8_cx_gc_us_i_0_debugbus_read(
> +	struct msm_gpu *gpu, u32 block_id, u32 index, u32 data[2])
> +{
> +	gen8_cx_dbgc_debugbus_select(gpu, block_id, index);
> +
> +	/*
> +	 * Select lower 32 bits of internal buffer data for internal mux[1:0]
> +	 * DBGC_CFG_DBGBUS_IDX.internalIndex0 =3D 24 (0x18)
> +	 * DBGC_CFG_DBGBUS_IDX.internalIndex1 =3D 25 (0x19)
> +	 */
> +	cxdbg_write(gpu, REG_A6XX_CX_DBGC_CFG_DBGBUS_IDX, 0x00001918);
> +	udelay(1);
> +
> +	data[0] =3D cxdbg_read(gpu, REG_A6XX_CX_DBGC_CFG_DBGBUS_TRACE_BUF3);
> +
> +	/*
> +	 * Select upper 32 bits of internal buffer data for internal mux[1:0]
> +	 * DBGC_CFG_DBGBUS_IDX.internalIndex0 =3D 26 (0x1a)
> +	 * DBGC_CFG_DBGBUS_IDX.internalIndex1 =3D 27 (0x1b)
> +	 */
> +	cxdbg_write(gpu, REG_A6XX_CX_DBGC_CFG_DBGBUS_IDX, 0x00001a1b);
> +	udelay(1);
> +
> +	data[1] =3D cxdbg_read(gpu, REG_A6XX_CX_DBGC_CFG_DBGBUS_TRACE_BUF3);
> +}

[Severity: Medium]
Should the second write to REG_A6XX_CX_DBGC_CFG_DBGBUS_IDX be 0x00001b1a
instead of 0x00001a1b?

internalIndex0 is in bits [7:0] and internalIndex1 is in bits [15:8], as
in 0x00001918 above.  Writing 0x00001a1b sets internalIndex0 =3D 0x1b and
internalIndex1 =3D 0x1a, swapping the two 16-bit halves of data[1] in the
captured DEBUGBUS_CX_GC_US_I_0 dump.

[ ... ]

> +struct msm_gpu_state *a8xx_gpu_state_get(struct msm_gpu *gpu)
> +{
[ ... ]
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
As reported by Alexander Koskovich on v2 [1], can the GPU enter IFPC after
the single gx_is_on() check while a8xx_gpu_state_get() is still capturing
GX state?

Unlike a6xx_gpu_state_get(), which halts SQE by writing 3 to
REG_A6XX_CP_SQE_CNTL right after checking gx_is_on(), a8xx_gpu_state_get()
neither halts SQE via REG_A8XX_CP_SQE_CNTL nor holds an IFPC-inhibiting
GMU vote across gen8_snapshot_debugbus(), the 4 MB GEM buffer allocation
in a8xx_crashdumper_init(), and the subsequent crashdumper and GX MMIO
reads.  If in-flight work finishes during this window, the GMU powers down
GX and enables the AHB fence, causing GMU fence errors, a crashdumper poll
timeout and drm_WARN_ONCE() in __cd_run(), and an incomplete devcoredump.

[1] https://lore.kernel.org/r/FZvwtKTpIxRNzjzcqFf6bTw12mNTJvJZmg6j9lmi8MehH=
Bt91NogIW8oQd5yFHN5DSL8yIWL8p_b1cJPAJC57ZFkoe2BOAh_Y3kwph5SV_A=3D@pm.me

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109142111.2566=
30-1-robin.clark@oss.qualcomm.com?part=3D11
