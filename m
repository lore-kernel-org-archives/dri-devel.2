Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E8B4FF4956
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 08:03:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94D7610E46C;
	Mon, 30 Mar 2026 08:03:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="GmfaFkCb";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5EB310E46C;
 Mon, 30 Mar 2026 08:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774857780; x=1806393780;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=kuKFZHF+lFo1cxlTyrO7nzp0Jw/QQObhSwNEPMh6obo=;
 b=GmfaFkCb893jMzJqqbBLO/b7sVpji5sEeMK780InBoRCc4uTjseN/qgt
 9WdgXPJSSnz0fqCd7gzOHDoW43bxiZ75+KoL3+UTFIbu2cGM+1gRV1DpT
 JRPHEm7Me7gJFvszrTMdaoiVUFqS5l2f4KgZ4iYBacBYVfwRR82WxsYWG
 pTXpm6yW6KJs/wyhqxETBhPeH1akcpEewrO5iM5kWhNvsRGiozoizex3p
 VojS2kVIt7E8mBOh8Ud0kAx3XnPjTlgBPD2Rtieq5WZqx3LCvJq0560zc
 H1rL/Ej5ibI/nmxUmJQXRAwo4KksxkI12wmf4QQjVkpTq++RzkGbdpJ7e w==;
X-CSE-ConnectionGUID: leP2eqTaTWu3aUQkRyylmw==
X-CSE-MsgGUID: Uo0rkIK0TzSx+bI53DeIgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="75740222"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; d="scan'208";a="75740222"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 01:02:59 -0700
X-CSE-ConnectionGUID: pSVJ/Y8iSPKBxWpfOt+1Tg==
X-CSE-MsgGUID: x4nrz4GQTiWPmELcvt20IQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; d="scan'208";a="225980390"
Received: from abityuts-desk.ger.corp.intel.com (HELO [10.245.245.95])
 ([10.245.245.95])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 01:02:57 -0700
Message-ID: <10289571cccff20ba52f224080754705c606ccfe.camel@linux.intel.com>
Subject: Re: [PATCH] drm/xe/bo: Cache vram_region_gpu_offset in struct xe_bo
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Yuri Martins <yurimartins2004@hotmail.com>, intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Matthew Auld <matthew.auld@intel.com>, Matt Roper
 <matthew.d.roper@intel.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Date: Mon, 30 Mar 2026 10:02:54 +0200
In-Reply-To: <CP9P284MB3908AC9B3875FD63E955D139A055A@CP9P284MB3908.BRAP284.PROD.OUTLOOK.COM>
References: <CP9P284MB3908AC9B3875FD63E955D139A055A@CP9P284MB3908.BRAP284.PROD.OUTLOOK.COM>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Sun, 2026-03-29 at 19:22 -0300, Yuri Martins wrote:
> The vram_region_gpu_offset() helper chases pointers through TTM
> resource
> manager structures on every call. An XXX comment in the codebase
> noted
> this was a problem in the VM bind hot path and suggested caching the
> value with a recalculation on BO move.
>=20
> Add a vram_gpu_offset field to struct xe_bo that is updated in
> xe_bo_move() at the 'out' label, which is the convergence point for
> all
> move paths. Provide xe_bo_vram_gpu_offset() as a static inline
> accessor.
>=20
> Convert five callers that always operate on the BO's current
> resource:
> =C2=A0 - xe_pt.c: xe_pt_stage_bind() (VM bind hot path)
> =C2=A0 - xe_bo.c: __xe_bo_addr()
> =C2=A0 - xe_ggtt.c: xe_ggtt_map_bo()
> =C2=A0 - xe_lmtt.c: lmtt_insert_bo()
> =C2=A0 - xe_migrate.c: xe_migrate_access_memory()
>=20
> Two callers in xe_migrate.c (pte_update_size and emit_pte) are
> intentionally not converted because they receive a ttm_resource that
> may refer to a move destination rather than the BO's current
> placement.
>=20
> Replace the XXX comment on vram_region_gpu_offset() with proper
> kernel
> doc that directs callers to prefer the cached accessor.
>=20
> Add a KUnit live test (xe_bo_vram_gpu_offset_kunit) that validates
> cache
> consistency across BO creation in VRAM, eviction to system memory,
> and
> restoration back to VRAM.
>=20
> Tested on ASUS Zenbook S14 (Intel Core Ultra 7 258V) with
> xe_live_test
> module on Fedora.
>=20
> Signed-off-by: Yuri Martins <yurimartins2004@hotmail.com>

This adds a pretty large amount of code and some fragility without a
clear proof of benefit. I think improvements like this needs some real
performance increase numbers.

> ---
> =C2=A0drivers/gpu/drm/xe/tests/xe_bo.c | 117
> +++++++++++++++++++++++++++++++
> =C2=A0drivers/gpu/drm/xe/xe_bo.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 17 +++--
> =C2=A0drivers/gpu/drm/xe/xe_bo.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 15 ++++
> =C2=A0drivers/gpu/drm/xe/xe_bo_types.h |=C2=A0=C2=A0 6 ++
> =C2=A0drivers/gpu/drm/xe/xe_ggtt.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 =
2 +-
> =C2=A0drivers/gpu/drm/xe/xe_lmtt.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 =
2 +-
> =C2=A0drivers/gpu/drm/xe/xe_migrate.c=C2=A0 |=C2=A0=C2=A0 2 +-
> =C2=A0drivers/gpu/drm/xe/xe_pt.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 2 +-
> =C2=A08 files changed, 155 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/xe/tests/xe_bo.c
> b/drivers/gpu/drm/xe/tests/xe_bo.c
> index 49c95ed67d7e..ed65e25c1b11 100644
> --- a/drivers/gpu/drm/xe/tests/xe_bo.c
> +++ b/drivers/gpu/drm/xe/tests/xe_bo.c
> @@ -603,9 +603,126 @@ static void xe_bo_shrink_kunit(struct kunit
> *test)
> =C2=A0	shrink_test_run_device(xe);
> =C2=A0}
> =C2=A0
> +/*
> + * Test that bo->vram_gpu_offset is kept in sync with the value
> computed
> + * by vram_region_gpu_offset() across BO creation, eviction to
> system
> + * memory, and restoration back to VRAM.
> + */
> +static void vram_gpu_offset_test_run_tile(struct xe_device *xe,
> +					=C2=A0 struct xe_tile *tile,
> +					=C2=A0 struct kunit *test)
> +{
> +	struct xe_bo *bo;
> +	unsigned int bo_flags =3D XE_BO_FLAG_VRAM_IF_DGFX(tile);
> +	struct drm_exec *exec =3D XE_VALIDATION_OPT_OUT;
> +	u64 expected;
> +	long timeout;
> +	int ret;
> +
> +	kunit_info(test, "Testing vram_gpu_offset cache on tile
> %u\n", tile->id);
> +
> +	bo =3D xe_bo_create_user(xe, NULL, SZ_1M,
> DRM_XE_GEM_CPU_CACHING_WC,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bo_flags, exec);
> +	if (IS_ERR(bo)) {
> +		KUNIT_FAIL(test, "Failed to create bo: %pe\n", bo);
> +		return;
> +	}
> +
> +	xe_bo_lock(bo, false);
> +
> +	/* After creation the BO should be in VRAM on DGFX. */
> +	ret =3D xe_bo_validate(bo, NULL, false, exec);
> +	if (ret) {
> +		KUNIT_FAIL(test, "Failed to validate bo: %d\n",
> ret);
> +		goto out_unlock;
> +	}
> +
> +	/* Wait for any async clears. */
> +	timeout =3D dma_resv_wait_timeout(bo->ttm.base.resv,
> +					DMA_RESV_USAGE_KERNEL,
> false, 5 * HZ);
> +	if (timeout <=3D 0) {
> +		KUNIT_FAIL(test, "Timeout waiting for bo after
> validate.\n");
> +		goto out_unlock;
> +	}
> +
> +	expected =3D vram_region_gpu_offset(bo->ttm.resource);
> +	KUNIT_EXPECT_EQ(test, xe_bo_vram_gpu_offset(bo), expected);
> +
> +	if (xe_bo_is_vram(bo))
> +		KUNIT_EXPECT_NE(test, xe_bo_vram_gpu_offset(bo), 0);
> +
> +	/* Evict to system memory =E2=80=94 cache must become 0. */
> +	ret =3D xe_bo_evict(bo, exec);
> +	if (ret) {
> +		KUNIT_FAIL(test, "Failed to evict bo: %d\n", ret);
> +		goto out_unlock;
> +	}
> +
> +	timeout =3D dma_resv_wait_timeout(bo->ttm.base.resv,
> +					DMA_RESV_USAGE_KERNEL,
> false, 5 * HZ);
> +	if (timeout <=3D 0) {
> +		KUNIT_FAIL(test, "Timeout waiting for bo after
> evict.\n");
> +		goto out_unlock;
> +	}
> +
> +	expected =3D vram_region_gpu_offset(bo->ttm.resource);
> +	KUNIT_EXPECT_EQ(test, xe_bo_vram_gpu_offset(bo), expected);
> +	KUNIT_EXPECT_EQ(test, xe_bo_vram_gpu_offset(bo), (u64)0);
> +
> +	/* Restore back to VRAM =E2=80=94 cache must be updated again. */
> +	ret =3D xe_bo_validate(bo, NULL, false, exec);
> +	if (ret) {
> +		KUNIT_FAIL(test, "Failed to validate bo back to
> vram: %d\n", ret);
> +		goto out_unlock;
> +	}
> +
> +	timeout =3D dma_resv_wait_timeout(bo->ttm.base.resv,
> +					DMA_RESV_USAGE_KERNEL,
> false, 5 * HZ);
> +	if (timeout <=3D 0) {
> +		KUNIT_FAIL(test, "Timeout waiting for bo after
> restore.\n");
> +		goto out_unlock;
> +	}
> +
> +	expected =3D vram_region_gpu_offset(bo->ttm.resource);
> +	KUNIT_EXPECT_EQ(test, xe_bo_vram_gpu_offset(bo), expected);
> +
> +	if (xe_bo_is_vram(bo))
> +		KUNIT_EXPECT_NE(test, xe_bo_vram_gpu_offset(bo), 0);
> +
> +out_unlock:
> +	xe_bo_unlock(bo);
> +	xe_bo_put(bo);
> +}
> +
> +static int vram_gpu_offset_test_run_device(struct xe_device *xe)
> +{
> +	struct kunit *test =3D kunit_get_current_test();
> +	struct xe_tile *tile;
> +	int id;
> +
> +	if (!IS_DGFX(xe)) {
> +		kunit_skip(test, "non-discrete device\n");
> +		return 0;
> +	}
> +
> +	guard(xe_pm_runtime)(xe);
> +	for_each_tile(tile, xe, id)
> +		vram_gpu_offset_test_run_tile(xe, tile, test);
> +
> +	return 0;
> +}
> +
> +static void xe_bo_vram_gpu_offset_kunit(struct kunit *test)
> +{
> +	struct xe_device *xe =3D test->priv;
> +
> +	vram_gpu_offset_test_run_device(xe);
> +}
> +
> =C2=A0static struct kunit_case xe_bo_tests[] =3D {
> =C2=A0	KUNIT_CASE_PARAM(xe_ccs_migrate_kunit,
> xe_pci_live_device_gen_param),
> =C2=A0	KUNIT_CASE_PARAM(xe_bo_evict_kunit,
> xe_pci_live_device_gen_param),
> +	KUNIT_CASE_PARAM(xe_bo_vram_gpu_offset_kunit,
> xe_pci_live_device_gen_param),
> =C2=A0	{}
> =C2=A0};
> =C2=A0
> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> index a7c2dc7f224c..30c4fe326827 100644
> --- a/drivers/gpu/drm/xe/xe_bo.c
> +++ b/drivers/gpu/drm/xe/xe_bo.c
> @@ -1164,6 +1164,9 @@ static int xe_bo_move(struct ttm_buffer_object
> *ttm_bo, bool evict,
> =C2=A0		ret =3D xe_sriov_vf_ccs_attach_bo(bo);
> =C2=A0
> =C2=A0out:
> +	bo->vram_gpu_offset =3D ttm_bo->resource ?
> +		vram_region_gpu_offset(ttm_bo->resource) : 0;
> +

Please avoid recalculate data like this in "move". In general we
invalidate mappings and cached data in "move_notify" and recalculate on
first use.


> =C2=A0	if ((!ttm_bo->resource || ttm_bo->resource->mem_type =3D=3D
> XE_PL_SYSTEM) &&
> =C2=A0	=C2=A0=C2=A0=C2=A0 ttm_bo->ttm) {
> =C2=A0		long timeout =3D dma_resv_wait_timeout(ttm_bo-
> >base.resv,
> @@ -2908,9 +2911,15 @@ int xe_managed_bo_reinit_in_vram(struct
> xe_device *xe, struct xe_tile *tile, str
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> -/*
> - * XXX: This is in the VM bind data path, likely should calculate
> this once and
> - * store, with a recalculation if the BO is moved.
> +/**
> + * vram_region_gpu_offset - Compute GPU offset for a TTM resource's
> memory region
> + * @res: The TTM resource.
> + *
> + * Computes the GPU-visible offset for @res based on its current
> memory type.
> + * Callers that always operate on a BO's current resource should
> prefer
> + * xe_bo_vram_gpu_offset() which returns a cached value.
> + *
> + * Return: The GPU-visible offset, or 0 for system/TT memory.
> =C2=A0 */
> =C2=A0uint64_t vram_region_gpu_offset(struct ttm_resource *res)
> =C2=A0{
> @@ -3173,7 +3182,7 @@ dma_addr_t __xe_bo_addr(struct xe_bo *bo, u64
> offset, size_t page_size)
> =C2=A0
> =C2=A0		xe_res_first(bo->ttm.resource, page << PAGE_SHIFT,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0 page_size, &cur);
> -		return cur.start + offset +
> vram_region_gpu_offset(bo->ttm.resource);
> +		return cur.start + offset +
> xe_bo_vram_gpu_offset(bo);
> =C2=A0	}
> =C2=A0}
> =C2=A0
> diff --git a/drivers/gpu/drm/xe/xe_bo.h b/drivers/gpu/drm/xe/xe_bo.h
> index 68dea7d25a6b..d911f7327e8b 100644
> --- a/drivers/gpu/drm/xe/xe_bo.h
> +++ b/drivers/gpu/drm/xe/xe_bo.h
> @@ -342,6 +342,21 @@ bool xe_bo_is_vm_bound(struct xe_bo *bo);
> =C2=A0bool xe_bo_has_single_placement(struct xe_bo *bo);
> =C2=A0uint64_t vram_region_gpu_offset(struct ttm_resource *res);
> =C2=A0
> +/**
> + * xe_bo_vram_gpu_offset - Return cached GPU offset for BO's memory
> region

Prefer funcion() format.

> + * @bo: The buffer object.
> + *
> + * Returns the GPU offset for the BO's current memory region. This
> value
> + * is cached on the BO and updated whenever the BO is moved,
> avoiding
> + * repeated pointer chasing through TTM resource manager structures.

Just comment what the function does. No need to re-justfiy here.

> + *
> + * Return: The GPU-visible offset, or 0 for system/TT memory.
> + */
> +static inline u64 xe_bo_vram_gpu_offset(struct xe_bo *bo)
> +{

Here you'd=20
if (unlikely(bo->vram_gpu_offset =3D=3D SOME_INVALID_VALUE))
	recalculate();


> +	return bo->vram_gpu_offset;
> +}
> +

Thanks,
Thomas




> =C2=A0bool xe_bo_can_migrate(struct xe_bo *bo, u32 mem_type);
> =C2=A0
> =C2=A0int xe_bo_migrate(struct xe_bo *bo, u32 mem_type, struct
> ttm_operation_ctx *ctc,
> diff --git a/drivers/gpu/drm/xe/xe_bo_types.h
> b/drivers/gpu/drm/xe/xe_bo_types.h
> index ff8317bfc1ae..622a1ec8231e 100644
> --- a/drivers/gpu/drm/xe/xe_bo_types.h
> +++ b/drivers/gpu/drm/xe/xe_bo_types.h
> @@ -109,6 +109,12 @@ struct xe_bo {
> =C2=A0	 */
> =C2=A0	u64 min_align;
> =C2=A0
> +	/**
> +	 * @vram_gpu_offset: Cached GPU offset for BO's current
> memory
> +	 * region, updated on move. Protected by the BO's dma-resv
> lock.
> +	 */
> +	u64 vram_gpu_offset;
> +
> =C2=A0	/**
> =C2=A0	 * @madv_purgeable: user space advise on BO purgeability,
> protected
> =C2=A0	 * by BO's dma-resv lock.
> diff --git a/drivers/gpu/drm/xe/xe_ggtt.c
> b/drivers/gpu/drm/xe/xe_ggtt.c
> index a848d1a41b9b..a24ae3e0e553 100644
> --- a/drivers/gpu/drm/xe/xe_ggtt.c
> +++ b/drivers/gpu/drm/xe/xe_ggtt.c
> @@ -705,7 +705,7 @@ static void xe_ggtt_map_bo(struct xe_ggtt *ggtt,
> struct xe_ggtt_node *node,
> =C2=A0						=C2=A0=C2=A0 pte |
> xe_res_dma(&cur));
> =C2=A0	} else {
> =C2=A0		/* Prepend GPU offset */
> -		pte |=3D vram_region_gpu_offset(bo->ttm.resource);
> +		pte |=3D xe_bo_vram_gpu_offset(bo);
> =C2=A0
> =C2=A0		for (xe_res_first(bo->ttm.resource, 0,
> xe_bo_size(bo), &cur);
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0 cur.remaining; xe_res_next(&cur, XE_PAGE=
_SIZE))
> diff --git a/drivers/gpu/drm/xe/xe_lmtt.c
> b/drivers/gpu/drm/xe/xe_lmtt.c
> index 0c726eda9390..f9257ba1728b 100644
> --- a/drivers/gpu/drm/xe/xe_lmtt.c
> +++ b/drivers/gpu/drm/xe/xe_lmtt.c
> @@ -492,7 +492,7 @@ static void lmtt_insert_bo(struct xe_lmtt *lmtt,
> unsigned int vfid, struct xe_bo
> =C2=A0	lmtt_assert(lmtt, IS_ALIGNED(xe_bo_size(bo), page_size));
> =C2=A0	lmtt_assert(lmtt, xe_bo_is_vram(bo));
> =C2=A0
> -	vram_offset =3D vram_region_gpu_offset(bo->ttm.resource);
> +	vram_offset =3D xe_bo_vram_gpu_offset(bo);
> =C2=A0	xe_res_first(bo->ttm.resource, 0, xe_bo_size(bo), &cur);
> =C2=A0	while (cur.remaining) {
> =C2=A0		addr =3D xe_res_dma(&cur);
> diff --git a/drivers/gpu/drm/xe/xe_migrate.c
> b/drivers/gpu/drm/xe/xe_migrate.c
> index fc918b4fba54..bdaea4979e89 100644
> --- a/drivers/gpu/drm/xe/xe_migrate.c
> +++ b/drivers/gpu/drm/xe/xe_migrate.c
> @@ -2499,7 +2499,7 @@ int xe_migrate_access_memory(struct xe_migrate
> *m, struct xe_bo *bo,
> =C2=A0
> =C2=A0	do {
> =C2=A0		struct dma_fence *__fence;
> -		u64 vram_addr =3D vram_region_gpu_offset(bo-
> >ttm.resource) +
> +		u64 vram_addr =3D xe_bo_vram_gpu_offset(bo) +
> =C2=A0			cursor.start;
> =C2=A0		int current_bytes;
> =C2=A0		u32 pitch;
> diff --git a/drivers/gpu/drm/xe/xe_pt.c b/drivers/gpu/drm/xe/xe_pt.c
> index 8e5f4f0dea3f..7cfce1a92a1a 100644
> --- a/drivers/gpu/drm/xe/xe_pt.c
> +++ b/drivers/gpu/drm/xe/xe_pt.c
> @@ -782,7 +782,7 @@ xe_pt_stage_bind(struct xe_tile *tile, struct
> xe_vma *vma,
> =C2=A0	}
> =C2=A0
> =C2=A0	xe_walk.default_vram_pte |=3D XE_PPGTT_PTE_DM;
> -	xe_walk.dma_offset =3D (bo && !is_purged) ?
> vram_region_gpu_offset(bo->ttm.resource) : 0;
> +	xe_walk.dma_offset =3D (bo && !is_purged) ?
> xe_bo_vram_gpu_offset(bo) : 0;
> =C2=A0	if (!range)
> =C2=A0		xe_bo_assert_held(bo);
> =C2=A0
