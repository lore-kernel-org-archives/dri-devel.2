Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5535CD8CA8
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 09:30:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F5F010F3BA;
	Fri, 12 Jun 2026 09:30:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lksSjQf2";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90B6610F3BA
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 09:30:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 33AB840799;
 Fri, 12 Jun 2026 09:30:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A991F00A3A;
 Fri, 12 Jun 2026 09:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781256603;
 bh=oSfGlKDpjGuolsF1+tt/Ln1qZMjGawIMs6WKU2nmwco=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lksSjQf2psmiqzgRiKJ9o5SVr17n6vUZWID8W5D7/zOgnBrwagczYteRLtvtzQYIt
 U8TM4iKIfIXnJZROH6aFil4sAV0QtlOQqn3xWwrxN1+AMH1WUNifSNvlSBXzPJiAji
 xSzZUaCy/Ufv7ORJTTp+4ISP42Whywet+iHKo0DAYfH6VHJvdLB+4kiVX/uIUeY7rk
 dlvHG629o7Xq22UPyrUwOHIxTEoKSb2BvXw5KWn91qHSQlp9M/0WWMTfsQma/dWoEF
 qFBzRDBhVIQPLAQzOVCLrrVw07frQPiSy1sv0tXB1cEKHcbV+NrQka2R2qwfhPZFdQ
 Dz0zL7ll7IZIQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 08/18] drm/amdgpu: implement SVM range notifier and
 GC helpers
To: "Huang Rui" <ray.huang@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260612090928.29682-9-ray.huang@amd.com>
References: <20260612090928.29682-9-ray.huang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 09:30:02 +0000
Message-Id: <20260612093002.F0A991F00A3A@smtp.kernel.org>
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
- [High] Partial MMU notifier unmaps zap a subset of GPU PTEs but drop all =
backing pages or disable PTE zapping for the rest of the range, leading to =
stale GPU page tables and use-after-free vulnerabilities.
- [High] Concurrent MMU notifier and GC worker operations cause a double `l=
ist_add_tail()` on `svm->gc.list`, leading to linked list corruption.
- [High] Self-deadlock in `amdgpu_svm_range_invalidate_interval` due to pas=
sing `unlocked=3Dtrue` to `amdgpu_vm_update_range` while the VM PD lock is =
held.
- [High] `dma_fence_wait` inside the MMU notifier path is called outside of=
 the `memalloc_noreclaim` scope, causing fs_reclaim lockdep splats.
- [High] DMA pages are unmapped before the GPU TLB is flushed during range =
invalidation, risking memory corruption or IOMMU faults.
- [High] The GPU TLB flush is entirely skipped if an error occurs during pa=
ge table zapping, leaving stale mappings active.
--

commit 4b7d05253ea2ed3fdf73e5a506fb682970d5dd2a
Author: Honglei Huang <honghuan@amd.com>
Subject: drm/amdgpu: implement SVM range notifier and GC helpers

This commit adds MMU notifier event handling and garbage collection
infrastructure for the GPU SVM implementation.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_svm_range.c
> index e1b392b2cf56a..57bcbaf0fdd2b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c

[ ... ]

> +bool
> +amdgpu_svm_range_notifier_event_begin(struct amdgpu_svm *svm,
> +				      struct drm_gpusvm_range *range,
> +				      const struct mmu_notifier_range *mmu_range)
> +{
> +	struct amdgpu_svm_range *svm_range =3D to_amdgpu_svm_range(range);
> +	unsigned long start_page, last_page;
> +
> +	amdgpu_svm_assert_in_notifier(svm);
> +
> +	AMDGPU_SVM_RANGE_DEBUG(svm_range, "NOTIFIER");
> +
> +	if (range->pages.flags.unmapped || !svm_range->gpu_mapped)
> +		return false;
> +
> +	AMDGPU_SVM_RANGE_DEBUG(svm_range, "NOTIFIER - EXECUTE");
> +
> +	start_page =3D max(drm_gpusvm_range_start(range),
> +			 mmu_range->start) >> PAGE_SHIFT;
> +	last_page =3D (min(drm_gpusvm_range_end(range),
> +			 mmu_range->end) >> PAGE_SHIFT) - 1;
> +
> +	amdgpu_svm_range_zap_ptes(svm, svm_range, start_page, last_page);

[Severity: High]
Does calling amdgpu_svm_range_zap_ptes() here risk deadlocks?

This executes in memory reclaim (fs_reclaim) context, but looking at
amdgpu_svm_range_zap_ptes(), the memalloc_noreclaim flags are restored
before waiting on a DMA fence:

amdgpu_svm_range_zap_ptes() {
    ...
    memalloc_noreclaim_restore(flags);
    if (!ret && fence) {
        ret =3D dma_fence_wait(fence, false);
    ...
}

Waiting on a DMA fence while in memory reclaim context violates locking
rules since the fence signaling may depend on other memory allocations.
Could this trigger lockdep warnings and potential deadlocks?

> +	amdgpu_svm_range_invalidate_gpu_mapping(svm_range);
> +
> +	return true;
> +}

[Severity: High]
When an MMU notifier reports a partial unmap, the code above zaps only
the affected subset of PTEs, but marks the entire range as unmapped.

Does this leave stale GPU page tables for the unzapped portion?

Because amdgpu_svm_range_notifier_event_end() unconditionally unmaps
the DMA IOVAs for the entire range, the GPU retains valid PTEs pointing
to DMA addresses that have now been unmapped from the IOMMU. If the OS
reallocates these pages, could the GPU access them via the stale PTEs
and cause IOMMU faults or use-after-free conditions?

[ ... ]

> +static void
> +amdgpu_svm_gc_enqueue(struct amdgpu_svm *svm,
> +		      struct amdgpu_svm_range *range,
> +		      unsigned long start_page, unsigned long last_page)
> +{
> +	if (atomic_read(&svm->exiting))
> +		return;
> +
> +	spin_lock(&svm->work_lock);
> +	if (range->queue_state =3D=3D AMDGPU_SVM_RANGE_NOT_QUEUED) {
> +		drm_gpusvm_range_get(&range->base);
> +		range->queue_state =3D AMDGPU_SVM_RANGE_IN_GC;
> +	}
> +
> +	range->pending_start_page =3D min(range->pending_start_page, start_page=
);
> +	range->pending_last_page =3D max(range->pending_last_page, last_page);
> +	if (range->pending_ops =3D=3D AMDGPU_SVM_RANGE_OP_NONE)
> +		list_add_tail(&range->work_node, &svm->gc.list);

[Severity: High]
Can concurrent MMU notifier and GC worker operations cause a double list
addition on svm->gc.list?

If the GC worker removes a range from gc.list via
amdgpu_svm_range_dequeue_locked(), it sets queue_state to=20
AMDGPU_SVM_RANGE_PROCESSING and pending_ops to AMDGPU_SVM_RANGE_OP_NONE.

Concurrently, an MMU notifier could trigger amdgpu_svm_gc_enqueue().
Because pending_ops is AMDGPU_SVM_RANGE_OP_NONE, it executes list_add_tail()
to re-add the range to gc.list and sets the UNMAP flag below, but leaves
queue_state as AMDGPU_SVM_RANGE_PROCESSING.

When the GC worker finishes, it calls amdgpu_svm_range_put_if_dequeued(),
observes queue_state is AMDGPU_SVM_RANGE_PROCESSING and the UNMAP flag is
set, and executes list_add_tail() again on the exact same node. Could this
corrupt the linked list?

> +	range->pending_ops |=3D AMDGPU_SVM_RANGE_OP_UNMAP;
> +	spin_unlock(&svm->work_lock);
> +
> +	queue_work(svm->gc.wq, &svm->gc.work);
> +}

[ ... ]

> +int
> +amdgpu_svm_range_invalidate_interval(struct amdgpu_svm *svm,
> +				     unsigned long start_page,
> +				     unsigned long last_page)
> +{
> +	unsigned long start =3D start_page << PAGE_SHIFT;
> +	unsigned long end =3D (last_page + 1) << PAGE_SHIFT;
> +	struct drm_gpusvm_notifier *notifier, *next_notifier;
> +	struct drm_gpusvm_ctx ctx =3D { .in_notifier =3D false };
> +	struct drm_exec exec;
> +	bool needs_flush =3D false;
> +	int ret;
> +
> +	amdgpu_svm_assert_locked(svm);
> +
> +	ret =3D amdgpu_svm_range_lock_vm_pd(svm, &exec, true);
> +	if (ret)
> +		return ret;

[Severity: High]
Does holding the VM root PD lock here cause a self-deadlock when calling
amdgpu_svm_range_zap_ptes() below?

amdgpu_svm_range_invalidate_interval() acquires the VM root PD lock using
the exec context. Later in the loop, it calls amdgpu_svm_range_zap_ptes(),
which unconditionally passes unlocked=3Dtrue to amdgpu_vm_update_range():

amdgpu_svm_range_zap_ptes() {
    ...
    ret =3D amdgpu_vm_update_range(svm->adev, svm->vm, false, true, true,
    ...
}

When unlocked=3Dtrue is passed, amdgpu_vm_update_range() attempts to
acquire the vm->root.bo lock using a new drm_exec context. Since the lock
is already held by this thread under a different context, will this
cause a deadlock or trigger a ww_mutex warning?

> +
> +	drm_gpusvm_for_each_notifier_safe(notifier, next_notifier, &svm->gpusvm,
> +					  start, end) {
> +		struct drm_gpusvm_range *range, *next_range;
> +
> +		drm_gpusvm_for_each_range_safe(range, next_range, notifier,
> +					       start, end) {
> +			struct amdgpu_svm_range *svm_range =3D to_amdgpu_svm_range(range);
> +			bool crosses_boundary =3D start > drm_gpusvm_range_start(range) ||
> +						end < drm_gpusvm_range_end(range);
> +
> +			if (svm_range->gpu_mapped) {
> +				AMDGPU_SVM_RANGE_DEBUG(svm_range,
> +					crosses_boundary ? "ATTR DESTROY" :
> +							   "ATTR ZAP PTE");
> +
> +				ret =3D amdgpu_svm_range_zap_ptes(svm, svm_range,
> +						drm_gpusvm_range_start(range) >> PAGE_SHIFT,
> +						(drm_gpusvm_range_end(range) >> PAGE_SHIFT) - 1);
> +				if (ret < 0) {
> +					drm_exec_fini(&exec);
> +					return ret;
> +				}

[Severity: High]
If amdgpu_svm_range_zap_ptes() fails, is it safe to return immediately
without flushing the TLB?

If previous ranges in the loop successfully zapped their PTEs, or if the
current range was partially updated before the failure, skipping the
svm->flush_tlb(svm) call leaves the GPU TLB out of sync with the page
tables. Could these stale TLB entries allow unauthorized memory accesses?

> +
> +				amdgpu_svm_range_invalidate_gpu_mapping(svm_range);
> +				needs_flush =3D true;
> +			}
> +
> +			if (crosses_boundary) {
> +				/* remove ranges crossing the boundary so GPU fault
> +				 * creates new ranges bounded by the updated
> +				 * attr_range boundaries.
> +				 * Evict devmem-backed pages back to sysmem first
> +				 * so VRAM-resident data is not lost when the range
> +				 * is destroyed. No-op for sysmem-only ranges.
> +				 */
> +				drm_gpusvm_range_get(range);
> +
> +				amdgpu_svm_range_evict(svm, range);
> +				amdgpu_svm_range_remove(svm, svm_range, &ctx);

[Severity: High]
Does unmapping DMA pages here risk memory corruption or IOMMU faults?

amdgpu_svm_range_remove() delegates to drm_gpusvm_range_unmap_pages(),
which unmaps the physical pages from the GPU's DMA address space.
However, the TLB flush (svm->flush_tlb(svm)) is deferred until after
the loop completes.

Between the DMA unmapping and the TLB flush, the GPU retains cached
translations to the unmapped physical pages. If the OS reallocates these
pages, could the GPU silently corrupt the newly allocated memory?

> +
> +				amdgpu_svm_range_unqueue(svm, svm_range);
> +
> +				drm_gpusvm_range_put(range);
> +			}
> +		}
> +	}
> +
> +	drm_exec_fini(&exec);
> +
> +	if (needs_flush)
> +		svm->flush_tlb(svm);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612090928.2968=
2-1-ray.huang@amd.com?part=3D8
