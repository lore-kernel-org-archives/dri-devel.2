Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B16AC43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 22:36:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A277010E4B2;
	Fri, 10 Jul 2026 22:36:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="d4+OcAnL";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48E2D10E27D
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 22:36:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8A78360051;
 Fri, 10 Jul 2026 22:36:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 212231F000E9;
 Fri, 10 Jul 2026 22:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783723012;
 bh=3mHomSvoxxd8xnUn9DoTxm11u/CgWvAUAUYKDpKn0TA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=d4+OcAnLUb7TkrF8E5mClOYhFSwVA6rixZ+42HtLN2qNAKgskk1TvtIUCng38QQe0
 QCW3KY2jvXSSLoO7PiEKS2GY6MuO49AvVXuhT3ih6S7d39rK5+X768s+t8Zsoa58wL
 aKL2WJvUahyESeX8GCFtLecwDh4LO8zWe80xgn9Dg3R3ntOntwzzSu3xJyRFFmLEOD
 YZVT4JqX9hOrv5Kcv5DBZeh2V6dK/7LV15nISds/lenr11SDKxPUFUsVZwiD/73VKK
 W5ywl4MGVgPktlduBhMBFnWgVhnxwFxADh9avSCvnyAd2jzYv2bNZxRuXMhxTPcUle
 F2KLS8tfZLm/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 32/33] drm/xe: Finalize defrag-IOVA moves with
 post-copy job
To: "Matthew Brost" <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260710215442.2444235-33-matthew.brost@intel.com>
References: <20260710215442.2444235-1-matthew.brost@intel.com>
 <20260710215442.2444235-33-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 22:36:51 +0000
Message-Id: <20260710223652.212231F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [Critical] Error paths tear down the destination IOVA mapping without wai=
ting for the submitted asynchronous GPU copy job, leading to IOMMU faults a=
nd Write-After-Free.
- [High] xe_bo_defrag_use_iova() checks only the new_tt for IOVA support, i=
gnoring whether old_tt actually uses IOVA, leading to invalid IOVA transfer=
 and IOMMU corruption.
- [High] TLB/L2 cache invalidation for the IOVA defrag is scheduled too ear=
ly, leading to stale entries in the GPU TLB after the IOMMU update complete=
s.
- [High] Allocating memory with GFP_KERNEL while holding the BO's dma_resv =
lock creates an AB-BA deadlock risk with the DRM memory shrinker.
- [High] Incomplete SWIOTLB bounce buffer handling causes the GPU to read u=
ninitialized memory after defragmentation.
- [Medium] The return value of dma_iova_sync() is ignored in the defrag fin=
alize job, potentially leaving the IOTLB/cache unflushed.
--

--- Patch [32]: [PATCH v2 32/33] drm/xe: Finalize defrag-IOVA moves with po=
st-copy job ---
commit 23b117a272c85c9d94147e6761afd74a17131d1f
Author: Matthew Brost <matthew.brost@intel.com>
Subject: drm/xe: Finalize defrag-IOVA moves with post-copy job

This commit wires up end-to-end defrag for IOVA-mapped BOs. A defrag move
is eligible whenever the destination TT is IOVA mapped. The packed-copy
step moves only changed pages, and a post-copy finalize job tears down the
temporary packed mapping and relinks the copied pages.

> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> index 16d9e135cba2e..0eee53f4d653f 100644
> --- a/drivers/gpu/drm/xe/xe_bo.c
> +++ b/drivers/gpu/drm/xe/xe_bo.c

[ ... ]

> @@ -855,7 +854,6 @@ struct xe_tt_iova_run_collect {
>  };
> =20
>  /* Geometrically grow @arr (element size @elem) to hold at least @need s=
lots. */
> -__maybe_unused
>  static int xe_tt_iova_grow(void **arr, unsigned int *cap, unsigned int n=
eed,
>  			   size_t elem)
>  {
> @@ -866,13 +864,12 @@ static int xe_tt_iova_grow(void **arr, unsigned int=
 *cap, unsigned int need,
>  		return 0;
> =20
>  	new_cap =3D *cap ? *cap * 2 : 64;
>  	if (new_cap < need)
>  		new_cap =3D need;
> =20
>  	p =3D krealloc_array(*arr, new_cap, elem, GFP_KERNEL);

[Severity: High]
Is it safe to use GFP_KERNEL here? This is called from xe_bo_move() while
holding the buffer object's dma_resv lock.

If the memory allocator triggers direct reclaim, it can invoke the DRM
memory shrinker, which will attempt to acquire dma_resv locks to evict
buffer objects, leading to an AB-BA deadlock.

>  	if (!p)
>  		return -ENOMEM;

[ ... ]

> @@ -1047,6 +1041,129 @@ static int xe_tt_map_iova_copy(struct xe_device *=
xe, struct ttm_tt *new_tt,
> +static struct dma_fence *xe_iova_defrag_job_run(struct xe_dep_job *dep_j=
ob)
> +{

[ ... ]

> +	/*
> +	 * Relink the freshly copied new pages from the snapshot captured at job
> +	 * creation. The destination tt's page array may have been mutated (or
> +	 * torn down) by TTM since then, so it is never dereferenced here.
> +	 * Borrowed pages are shared with the old tt and stay correctly linked
> +	 * for free, so the snapshot only covers the changed runs.
> +	 */
> +	for (l =3D 0; l < job->copy.nr_links; l++) {
> +		int ret =3D dma_iova_link(dev, &xe_tt->iova,
> +					job->copy.links[l].phys,
> +					job->copy.links[l].offset,
> +					job->copy.links[l].len,
> +					DMA_BIDIRECTIONAL,
> +					DMA_ATTR_SKIP_CPU_SYNC);

[Severity: High]
Does skipping CPU sync here break configurations using SWIOTLB?

When using DMA_ATTR_SKIP_CPU_SYNC, the DMA API allocates a new bounce
buffer for the physical page but bypasses copying the physical page
contents into it.

This would cause the new IOVA mapping to point to an uninitialized bounce
buffer, leading to the GPU reading uninitialized memory.

> +		/*
> +		 * Point of no failure: the data is already copied and the
> +		 * reservation ownership has been transferred. A relink failure
> +		 * leaves a hole in the mapping; there is no safe recovery, so
> +		 * just warn.
> +		 */
> +		drm_WARN_ON(&xe->drm, ret);
> +	}
> +
> +	/* Sync the relinked changed runs into the device's view. */
> +	for (r =3D 0; r < job->copy.nr_runs; r++) {
> +		size_t off =3D (size_t)job->copy.runs[r].start << PAGE_SHIFT;
> +		size_t len =3D (size_t)job->copy.runs[r].count << PAGE_SHIFT;
> +
> +		dma_iova_sync(dev, &xe_tt->iova, off, len);

[Severity: Medium]
Should the return value of dma_iova_sync() be checked here?

While this is a point of no return and the job cannot be aborted gracefully,
silently ignoring the error hides IOMMU cache sync failures.

A failure could result in stale IOMMU caches and GPU data corruption, so
perhaps at least a drm_WARN_ON() is warranted, similar to the
dma_iova_link() call above.

> +	}

[ ... ]

> @@ -1063,7 +1180,6 @@ static int xe_tt_map_iova_copy(struct xe_device *xe=
, struct ttm_tt *new_tt,
> -__maybe_unused
>  static void xe_tt_iova_transfer(struct xe_device *xe,
>  				struct xe_ttm_tt *new_tt,
>  				struct xe_ttm_tt *old_tt)
>  {
>  	new_tt->iova =3D old_tt->iova;

[Severity: High]
What happens if the original old_tt failed to allocate an IOVA mapping and
fell back to an SG mapping?

If old_tt->use_iova is false, old_tt->iova would be uninitialized or empty.
Copying it here would overwrite the valid new_tt->iova state, which could
lead to IOMMU corruption when the finalize job attempts to link pages.

>  	new_tt->iova_linked =3D true;

[ ... ]

> +static struct dma_fence *
> +xe_bo_defrag_iova_copy(struct xe_device *xe, struct xe_migrate *migrate,
> +		       struct xe_bo *bo, struct ttm_resource *old_mem,
> +		       struct ttm_resource *new_mem, struct ttm_tt *old_tt,
> +		       bool handle_system_ccs)
> +{

[ ... ]

> +	job =3D kzalloc(sizeof(*job), GFP_KERNEL);

[Severity: High]
Could this GFP_KERNEL allocation cause a deadlock?

Just like the allocation in xe_tt_iova_grow(), this executes under the
buffer object's dma_resv lock during xe_bo_move(). If memory pressure
triggers the shrinker, it might try to acquire the same dma_resv lock.

> +	if (!job) {
> +		err =3D -ENOMEM;
> +		goto err_fence;
> +	}

[ ... ]

> +err_job_init:
> +	drm_sched_job_cleanup(&job->dep.drm);
> +err_job:
> +	kfree(job);
> +err_fence:
> +	dma_fence_put(copy_fence);
> +err_unmap:
> +	if (packed)
> +		dma_iova_unlink(xe->drm.dev, &new_xe_tt->iova, 0,
> +				(size_t)copy.nr_changed << PAGE_SHIFT,
> +				DMA_BIDIRECTIONAL, DMA_ATTR_SKIP_CPU_SYNC);

[Severity: Critical]
Is it safe to unlink the IOVA mapping here without waiting for copy_fence
to signal?

By destroying the destination IOVA page tables immediately, the asynchronous
GPU migration job might still be actively writing to those addresses.

This could result in IOMMU faults or write-after-free corruption if TTM
aborts the move and frees the physical pages while the GPU blit is still
running.

> +err_copy:
> +	xe_tt_iova_copy_fini(&copy);
> +	return ERR_PTR(err);
> +}

[ ... ]

> +/*
> + * xe_bo_defrag_use_iova - Whether a defrag move should use the packed I=
OVA path.
> + */
> +static bool xe_bo_defrag_use_iova(struct ttm_buffer_object *ttm_bo)
> +{
> +	struct xe_ttm_tt *xe_tt;
> +
> +	if (!ttm_bo->defrag_old_tt || !ttm_bo->ttm)
> +		return false;
> +
> +	xe_tt =3D container_of(ttm_bo->ttm, struct xe_ttm_tt, ttm);
> +	return xe_tt->use_iova;

[Severity: High]
Does this check adequately ensure the old_tt is actually using IOVA?

The function verifies new_tt->use_iova, but omits checking
old_tt->use_iova.

If the initial old_tt fell back to an SG mapping, this path would still
return true as long as new_tt is IOVA-eligible. This would then misroute
the move to xe_bo_defrag_iova_copy() and trigger the uninitialized IOVA
transfer mentioned earlier.

> +}

[ ... ]

> @@ -1388,6 +1647,8 @@ static int xe_bo_trigger_rebind(struct xe_device *x=
e, struct xe_bo *bo,
>  			 */
>  			if (!xe_vm_flush_vm_bo_tlb_async(vm, bo, vm_bo))
>  				continue;
> +			else if (defrag_iova)
> +				drm_gpuvm_bo_evict(vm_bo, true);

[Severity: High]
Can this sequence cause the GPU to access freed physical pages?

The function xe_vm_flush_vm_bo_tlb_async() flushes the TLB asynchronously
based on the current fences in the reservation. However, this is executed
before the migration and finalize jobs are added to the buffer object's
reservation.

Because the eviction marking is skipped for defrag_iova, the userspace GPU
context is not stopped. It can access the buffer object and repopulate the
GPU TLB with the old IOMMU translations after this premature flush
completes, but before the finalize job actually updates the IOMMU.

>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710215442.2444=
235-1-matthew.brost@intel.com?part=3D32
