Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24B4606AB09
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 22:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FgPzMxbK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EA6410E8F3;
	Wed,  4 Nov 2026 22:15:14 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15C5D10E8F3;
 Wed,  4 Nov 2026 22:15:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 15083605D5;
 Wed,  4 Nov 2026 22:15:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA5B1F000C1;
 Wed,  4 Nov 2026 22:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793830505;
 bh=lpuKgaKZLphGQq+nkJEMKKsf/L55t5EnBR7GyfxQ4xE=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=FgPzMxbKgXsW+GqQue6ufMN28nQ2rLkkMkO0Et1zOINbsA3Ze9S8BqbGJaVJU+T9T
 7lcrlM9yDm3qVMeZUwsCweHXKOF6SGW7cs/u4BmW5fPz+ZjIud+rvxdWPMeW8qlm5n
 zbAENCSmkhsZQKv1zu2NXQ3ME6n8ZPUuvyqtlnolODpHzzqSFAMvwWntj4AXggIoul
 jhQDyy14FDFK2bXXS0iNFa+B68woluPhRlsOcvU1Wjv0Lng8ZlLT4cj6+uVHUZuvdW
 qGoQkL+ppgThQ/BpuwGgK4CuDS+5dPzwgqfAdzwtpL6YkQB4g2HuZzaGzShMXSdl3y
 w8KXT6cD8MYPg==
Message-ID: <sashiko-outbox-198211@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/xe: Add debugfs stats for DMA-mapped pages per
 order
To: "Matthew Brost" <matthew.brost@intel.com>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261104215228.1533692-2-matthew.brost@intel.com>
References: <20261104215228.1533692-1-matthew.brost@intel.com>
 <20261104215228.1533692-2-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 22:15:05 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] drm/xe: premature xe_device_assert_dma_pages_zero() before ttm_d=
evice_fini()
- [Low] drm/xe: duplicate dma_map_account callbacks in xe_svm.c and xe_user=
ptr.c
--

commit d97316f4a4863b594d6196037dc27dd4e278bdd0
Author: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>

drm/xe: Add debugfs stats for DMA-mapped pages per order

This commit adds per-order DMA-mapped system page counters for TTM buffer
objects and GPU SVM / userptr ranges, exposes them via debugfs at
dma_mapped_pages, and asserts that all counters return to zero during device
teardown.

> diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_devic=
e.c
> index 273e2c45fea9b..c40bb8f7c697a 100644
> --- a/drivers/gpu/drm/xe/xe_device.c
> +++ b/drivers/gpu/drm/xe/xe_device.c
> @@ -377,12 +377,42 @@ bool xe_device_is_admin_only(const struct xe_device=
 *xe)
[ ... ]
>  static void xe_device_destroy(struct drm_device *dev, void *dummy)
>  {
>  	struct xe_device *xe =3D to_xe_device(dev);
> =20
>  	xe_bo_dev_fini(&xe->bo_device);
> =20
> +	/*
> +	 * Assert the DMA-mapped-pages accounting only after xe_bo_dev_fini()
> +	 * has flushed the async BO-free worker: BOs pending async free still
> +	 * hold their DMA mappings (and counts) until the worker runs, so
> +	 * asserting before the flush could trip a false positive.
> +	 */
> +	xe_device_assert_dma_pages_zero(xe);
> +
>  	if (xe->preempt_fence_wq)
>  		destroy_workqueue(xe->preempt_fence_wq);
> =20
>  	if (xe->ordered_wq)
>  		destroy_workqueue(xe->ordered_wq);
> =20
>  	if (xe->unordered_wq)
>  		destroy_workqueue(xe->unordered_wq);
> =20
>  	if (xe->destroy_wq)
>  		destroy_workqueue(xe->destroy_wq);
> =20
>  	ttm_device_fini(&xe->ttm);

[Severity: Medium]
Can xe_device_assert_dma_pages_zero() trigger a false-positive assertion he=
re
because it runs before ttm_device_fini(&xe->ttm)?

When BOs with a populated ttm_tt and DMA-mapped xe_tt->sg are released via
ttm_bo_put() -> ttm_bo_release(), TTM defers cleanup to bdev->wq
(xe->ttm.wq) whenever want_init_on_free() is active or reservation fences or
locks are busy:

drivers/gpu/drm/ttm/ttm_bo.c:ttm_bo_release()
	if (!dma_resv_test_signaled(&bo->base._resv,
				    DMA_RESV_USAGE_BOOKKEEP) ||
	    (want_init_on_free() && (bo->ttm !=3D NULL)) ||
	    bo->type =3D=3D ttm_bo_type_sg ||
	    !dma_resv_trylock(bo->base.resv)) {
		...
		INIT_WORK(&bo->delayed_delete, ttm_bo_delayed_delete);
		...
		queue_work_node(bdev->pool.nid, bdev->wq, &bo->delayed_delete);
		return;
	}

In that case, the DMA unmap and counter decrement via:

  ttm_bo_delayed_delete()
    -> ttm_bo_cleanup_memtype_use()
      -> ttm_bo_tt_destroy()
        -> ttm_tt_unpopulate()
          -> xe_ttm_tt_unpopulate()
            -> xe_tt_unmap_sg()
              -> xe_tt_account_dma_pages(xe, xe_tt, -1)

will not complete until ttm_device_fini() drains bdev->wq. Should
xe_device_assert_dma_pages_zero(xe) be called after ttm_device_fini(&xe->tt=
m)
instead?

> diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
> index 909a602d091ea..7a49882897495 100644
> --- a/drivers/gpu/drm/xe/xe_svm.c
> +++ b/drivers/gpu/drm/xe/xe_svm.c
> @@ -845,10 +845,50 @@ static int xe_svm_get_pagemaps(struct xe_vm *vm)
>  }
>  #endif
> =20
> +#if IS_ENABLED(CONFIG_DEBUG_FS)
> +/*
> + * xe_svm_dma_map_account - drm_gpusvm DMA-mapping accounting callback
> + * @gpusvm: The GPU SVM the mapping belongs to
> + * @addr: The address descriptor of the chunk being (un)mapped
> + * @sign: +1 when @addr was DMA-mapped, -1 when it is being unmapped
> + *
> + * Maintain per-order counts of the system-memory pages that the full SVM
> + * instance (SVM ranges, and userptr VMAs in fault mode) has DMA-mapped =
for GPU
> + * access. Only DRM_INTERCONNECT_SYSTEM entries are real DMA maps and co=
unted;
> + * device interconnect (VRAM, P2P) entries are skipped. The counts are s=
olely
> + * exposed through debugfs, so the callback is only registered when
> + * CONFIG_DEBUG_FS is enabled.
> + */
> +static void xe_svm_dma_map_account(struct drm_gpusvm *gpusvm,
> +				   const struct drm_pagemap_addr *addr,
> +				   int sign)
> +{
> +	struct xe_device *xe =3D gpusvm_to_vm(gpusvm)->xe;
> +	unsigned int order =3D addr->order;
> +
> +	if (addr->proto !=3D DRM_INTERCONNECT_SYSTEM)
> +		return;
> +
> +	/*
> +	 * The CPU-PTE map order reported by hmm can exceed MAX_PAGE_ORDER
> +	 * (e.g. an order-18 1GB mapping), so clamp the array index to avoid an
> +	 * out-of-bounds access. Clamping is symmetric across the +1/-1 calls,
> +	 * so the per-order counters stay balanced.
> +	 */
> +	order =3D min(order, (unsigned int)NR_PAGE_ORDERS - 1);
> +
> +	atomic_long_add((long)(1UL << addr->order) * sign,
> +			&xe->mem.dma_mapped_pages_svm[order]);
> +}
> +#endif
> +
>  static const struct drm_gpusvm_ops gpusvm_ops =3D {
>  	.range_alloc =3D xe_svm_range_alloc,
>  	.range_free =3D xe_svm_range_free,
>  	.invalidate =3D xe_svm_invalidate,
> +#if IS_ENABLED(CONFIG_DEBUG_FS)
> +	.dma_map_account =3D xe_svm_dma_map_account,
> +#endif
>  };
[ ... ]
> diff --git a/drivers/gpu/drm/xe/xe_userptr.c b/drivers/gpu/drm/xe/xe_user=
ptr.c
> index 9c1dac0fce6f1..40f97bd4751dd 100644
> --- a/drivers/gpu/drm/xe/xe_userptr.c
> +++ b/drivers/gpu/drm/xe/xe_userptr.c
> @@ -8,9 +8,72 @@
> =20
>  #include <linux/mm.h>
> =20
> +#include <drm/drm_pagemap.h>
> +
>  #include "xe_tlb_inval.h"
>  #include "xe_trace_bo.h"
> =20
> +#if IS_ENABLED(CONFIG_DEBUG_FS)
> +/*
> + * xe_userptr_dma_map_account - drm_gpusvm DMA-mapping accounting callba=
ck
> + * @gpusvm: The GPU SVM the mapping belongs to
> + * @addr: The address descriptor of the chunk being (un)mapped
> + * @sign: +1 when @addr was DMA-mapped, -1 when it is being unmapped
> + *
> + * Account, per page order, the system-memory pages DMA-mapped for GPU a=
ccess
> + * through the drm_gpusvm_pages instance shared by userptr (and, in faul=
t mode,
> + * SVM). Only DRM_INTERCONNECT_SYSTEM entries are real DMA maps and coun=
ted;
> + * device interconnect (VRAM, P2P) entries are skipped. The counts are s=
olely
> + * exposed through debugfs, so the callback is only registered when
> + * CONFIG_DEBUG_FS is enabled.
> + */
> +static void xe_userptr_dma_map_account(struct drm_gpusvm *gpusvm,
> +				       const struct drm_pagemap_addr *addr,
> +				       int sign)
> +{
> +	struct xe_vm *vm =3D container_of(gpusvm, struct xe_vm, svm.gpusvm);
> +	unsigned int order =3D addr->order;
> +
> +	if (addr->proto !=3D DRM_INTERCONNECT_SYSTEM)
> +		return;
> +
> +	/*
> +	 * The CPU-PTE map order reported by hmm can exceed MAX_PAGE_ORDER
> +	 * (e.g. an order-18 1GB mapping), so clamp the array index to avoid an
> +	 * out-of-bounds access. Clamping is symmetric across the +1/-1 calls,
> +	 * so the per-order counters stay balanced.
> +	 */
> +	order =3D min(order, (unsigned int)NR_PAGE_ORDERS - 1);
> +
> +	atomic_long_add((long)(1UL << addr->order) * sign,
> +			&vm->xe->mem.dma_mapped_pages_svm[order]);
> +}

[Severity: Low]
This isn't a bug, but the commit message and comment state that the
dma_map_account callback is shared between the fault-mode SVM instance and =
the
simple userptr instance, whereas xe_svm_dma_map_account() in
drivers/gpu/drm/xe/xe_svm.c and xe_userptr_dma_map_account() in
drivers/gpu/drm/xe/xe_userptr.c duplicate the same implementation.

Since CONFIG_DRM_XE_GPUSVM selects CONFIG_DRM_GPUSVM, could
xe_userptr_dma_map_account() be exposed and reused in gpusvm_ops instead of
defining two identical callbacks?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104215228.1533=
692-1-matthew.brost@intel.com?part=3D2
