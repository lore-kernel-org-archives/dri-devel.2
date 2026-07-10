Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C44EBC44506
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:55:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 508B910F9BA;
	Fri, 10 Jul 2026 21:55:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="O+kNYV5G";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ADFF10F9A8;
 Fri, 10 Jul 2026 21:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783720498; x=1815256498;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=s8nV69rF9JvhqU/iw2lgCgvsuNYQ0qwOG4N9ZK38jvo=;
 b=O+kNYV5G+JtO1IpCRvA6klE/t7QDOCop+6/SSLnO6h6Ku8dvasYcloJU
 FI0P8hrIjx0jwVVrUmiJn/jfYUw63AGPKMbEFr8CsXq7k9EFhSzgqD5Mk
 oT3U4N8BF7iN3djay/+0/uQxR82XtWM/A4TjQoxv1j5TSVlGI34eKA49M
 RwebvMlHF28WrRtv1j1HXaJbsbWLXuDnCweNlEEhbleyUsxgn0xBJ0QT1
 5CluQr/+fHHsIzAKFnn6PDmjfYrk2IxRM5ylujFdu8UnucwKw+xQt5yRW
 jJE3kAB6AC9TDAMfTl9VRoG5BpA85/3ztuQ8Bxsjt3/M3ZaVtrKNbAImm A==;
X-CSE-ConnectionGUID: HFrpb2RxS+WMqFXGhMH2TQ==
X-CSE-MsgGUID: myyAGkgvQPWB8zbFw6evoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="83543286"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="83543286"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 14:54:58 -0700
X-CSE-ConnectionGUID: CvMBT9ifRLWCWxSnpRvugQ==
X-CSE-MsgGUID: LMlacjv6TC2Ju+0XkowfrA==
X-ExtLoop1: 1
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 14:54:57 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: Carlos Santa <carlos.santa@intel.com>, Ryan Neph <ryanneph@google.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Subject: [PATCH v2 32/33] drm/xe: Finalize defrag-IOVA moves with post-copy job
Date: Fri, 10 Jul 2026 14:54:41 -0700
Message-Id: <20260710215442.2444235-33-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260710215442.2444235-1-matthew.brost@intel.com>
References: <20260710215442.2444235-1-matthew.brost@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Wire up end-to-end defrag for IOVA-mapped BOs. A defrag move
is eligible whenever the destination TT is IOVA mapped. The
packed-copy step moves only changed pages; the IOVA reservation
is transferred to the new backing so device-visible addresses
are preserved, avoiding GPU rebind overhead.

Add xe_bo_defrag_use_iova() to select the IOVA defrag path.
Add xe_bo_defrag_iova_copy() to drive the move: diff new vs
stashed old TT, link changed pages packed, blit them, then
queue a post-copy finalize job.

The finalize job tears down the temporary packed mapping,
transfers the full old TT reservation to the new one, and
relinks the copied pages at natural offsets.

Borrowed pages skip the copy and simply adopt the old
reservation.

Since reservation transfer preserves device-visible addresses,
xe_bo_trigger_rebind() skips drm_gpuvm_bo_evict() marking;
GPU PTEs stay valid.

Cc: Carlos Santa <carlos.santa@intel.com>
Cc: Ryan Neph <ryanneph@google.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Assisted-by: GitHub_Copilot:claude-opus-4.8
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/xe/xe_bo.c | 302 +++++++++++++++++++++++++++++++++++--
 1 file changed, 288 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 16d9e135cba2..0eee53f4d653 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -13,6 +13,7 @@
 #include <drm/drm_dumb_buffers.h>
 #include <drm/drm_gem_ttm_helper.h>
 #include <drm/drm_managed.h>
+#include <drm/gpu_scheduler.h>
 #include <drm/ttm/ttm_backup.h>
 #include <drm/ttm/ttm_device.h>
 #include <drm/ttm/ttm_placement.h>
@@ -25,6 +26,7 @@
 #include <trace/events/gpu_mem.h>
 
 #include "xe_device.h"
+#include "xe_dep_job_types.h"
 #include "xe_dep_scheduler.h"
 #include "xe_dma_buf.h"
 #include "xe_drm_client.h"
@@ -542,7 +544,6 @@ static void xe_tt_unaccount_iova(struct xe_device *xe,
  * @xe_tt->iova_dma_pages[]. Used to (re)derive accounting that exactly matches
  * the pages a tt is actually mapped with.
  */
-__maybe_unused
 static void xe_tt_account_iova_pages(struct xe_device *xe,
 				     struct xe_ttm_tt *xe_tt)
 {
@@ -567,7 +568,6 @@ static void xe_tt_unaccount_iova(struct xe_device *xe,
 {
 }
 
-__maybe_unused
 static void xe_tt_account_iova_pages(struct xe_device *xe,
 				     struct xe_ttm_tt *xe_tt)
 {
@@ -806,7 +806,6 @@ struct xe_tt_iova_copy {
  * differ. Coalesce contiguous changed folios into runs and, for each run,
  * invoke @fn. Returns the total number of changed pages.
  */
-__maybe_unused
 static pgoff_t xe_tt_iova_walk_changed(struct ttm_tt *new_tt,
 				       struct ttm_tt *old_tt,
 				       void (*fn)(pgoff_t start, pgoff_t count,
@@ -855,7 +854,6 @@ struct xe_tt_iova_run_collect {
 };
 
 /* Geometrically grow @arr (element size @elem) to hold at least @need slots. */
-__maybe_unused
 static int xe_tt_iova_grow(void **arr, unsigned int *cap, unsigned int need,
 			   size_t elem)
 {
@@ -878,7 +876,6 @@ static int xe_tt_iova_grow(void **arr, unsigned int *cap, unsigned int need,
 	return 0;
 }
 
-__maybe_unused
 static void xe_tt_iova_store_run(pgoff_t start, pgoff_t count, void *arg)
 {
 	struct xe_tt_iova_run_collect *c = arg;
@@ -933,7 +930,6 @@ static void xe_tt_iova_store_run(pgoff_t start, pgoff_t count, void *arg)
  *
  * Return: 0 on success, -ENOMEM on allocation failure.
  */
-__maybe_unused
 static int xe_tt_iova_copy_init(struct ttm_tt *new_tt, struct ttm_tt *old_tt,
 				struct xe_tt_iova_copy *copy)
 {
@@ -969,7 +965,6 @@ static int xe_tt_iova_copy_init(struct ttm_tt *new_tt, struct ttm_tt *old_tt,
  * xe_tt_iova_copy_fini() - Release a struct xe_tt_iova_copy
  * @copy: The copy description to release.
  */
-__maybe_unused
 static void xe_tt_iova_copy_fini(struct xe_tt_iova_copy *copy)
 {
 	kfree(copy->runs);
@@ -1000,7 +995,6 @@ static void xe_tt_iova_copy_fini(struct xe_tt_iova_copy *copy)
  * Return: 0 on success, negative error code on failure (any partial linkage is
  * unwound).
  */
-__maybe_unused
 static int xe_tt_map_iova_copy(struct xe_device *xe, struct ttm_tt *new_tt,
 			       const struct xe_tt_iova_copy *copy)
 {
@@ -1047,6 +1041,129 @@ static int xe_tt_map_iova_copy(struct xe_device *xe, struct ttm_tt *new_tt,
 	return ret;
 }
 
+/**
+ * struct xe_iova_defrag_job - Post-copy finalize job for an IOVA defrag move.
+ *
+ * After the GPU defrag copy into the packed copy-step mapping completes, this
+ * dependency job runs the CPU-side IOMMU fixups at the point of no failure:
+ * tear down the temporary packed mapping, then per changed run unlink the old
+ * pages and link the new pages into the (transferred) reservation at their
+ * natural offset.
+ */
+struct xe_iova_defrag_job {
+	/** @dep: base generic dependency Xe job. */
+	struct xe_dep_job dep;
+	/** @xe: The xe device. */
+	struct xe_device *xe;
+	/** @new_tt: The destination tt being finalized (owns the reservation). */
+	struct ttm_tt *new_tt;
+	/**
+	 * @copy_iova: Snapshot of the new tt's original IOVA reservation that
+	 * held the temporary packed copy-step mapping. Destroyed by the job
+	 * (the new tt itself adopts the old tt's reservation at job creation).
+	 */
+	struct dma_iova_state copy_iova;
+	/** @copy_bytes: Byte length of the packed copy-step mapping. */
+	size_t copy_bytes;
+	/** @copy: Changed-page description; the job owns and frees @copy.runs. */
+	struct xe_tt_iova_copy copy;
+};
+
+static struct dma_fence *xe_iova_defrag_job_run(struct xe_dep_job *dep_job)
+{
+	struct xe_iova_defrag_job *job =
+		container_of(dep_job, typeof(*job), dep);
+	struct xe_device *xe = job->xe;
+	struct device *dev = xe->drm.dev;
+	struct xe_ttm_tt *xe_tt =
+		container_of(job->new_tt, struct xe_ttm_tt, ttm);
+	unsigned int r, l;
+
+	/*
+	 * Tear down the temporary packed copy-step mapping and free its
+	 * reservation. The new tt has already adopted the old tt's full
+	 * reservation (transferred at job creation), so this only touches the
+	 * snapshot taken before the transfer.
+	 *
+	 * This mapping was the GPU blit's write destination, so tear it down
+	 * with attrs 0 (not DMA_ATTR_SKIP_CPU_SYNC): for non-coherent or
+	 * bounced (SWIOTLB) mappings the device->CPU copy-back / cache sync of
+	 * the freshly copied data happens during unlink, exactly as
+	 * xe_tt_unmap_iova() does. Skipping it would silently drop the
+	 * defragmented data on those configs.
+	 */
+	if (job->copy_bytes)
+		dma_iova_destroy(dev, &job->copy_iova, job->copy_bytes,
+				 DMA_BIDIRECTIONAL, 0);
+	else
+		dma_iova_free(dev, &job->copy_iova);
+
+	/*
+	 * For each changed run, unlink the old pages (still linked from the
+	 * adopted reservation).
+	 */
+	for (r = 0; r < job->copy.nr_runs; r++) {
+		size_t off = (size_t)job->copy.runs[r].start << PAGE_SHIFT;
+		size_t len = (size_t)job->copy.runs[r].count << PAGE_SHIFT;
+
+		dma_iova_unlink(dev, &xe_tt->iova, off, len,
+				DMA_BIDIRECTIONAL, DMA_ATTR_SKIP_CPU_SYNC);
+	}
+
+	/*
+	 * Relink the freshly copied new pages from the snapshot captured at job
+	 * creation. The destination tt's page array may have been mutated (or
+	 * torn down) by TTM since then, so it is never dereferenced here.
+	 * Borrowed pages are shared with the old tt and stay correctly linked
+	 * for free, so the snapshot only covers the changed runs.
+	 */
+	for (l = 0; l < job->copy.nr_links; l++) {
+		int ret = dma_iova_link(dev, &xe_tt->iova,
+					job->copy.links[l].phys,
+					job->copy.links[l].offset,
+					job->copy.links[l].len,
+					DMA_BIDIRECTIONAL,
+					DMA_ATTR_SKIP_CPU_SYNC);
+		/*
+		 * Point of no failure: the data is already copied and the
+		 * reservation ownership has been transferred. A relink failure
+		 * leaves a hole in the mapping; there is no safe recovery, so
+		 * just warn.
+		 */
+		drm_WARN_ON(&xe->drm, ret);
+	}
+
+	/* Sync the relinked changed runs into the device's view. */
+	for (r = 0; r < job->copy.nr_runs; r++) {
+		size_t off = (size_t)job->copy.runs[r].start << PAGE_SHIFT;
+		size_t len = (size_t)job->copy.runs[r].count << PAGE_SHIFT;
+
+		dma_iova_sync(dev, &xe_tt->iova, off, len);
+	}
+
+	/*
+	 * All work is synchronous CPU-side IOMMU fixup, so there is no hardware
+	 * fence to wait on; returning NULL makes the scheduler signal the job's
+	 * finished fence immediately.
+	 */
+	return NULL;
+}
+
+static void xe_iova_defrag_job_free(struct xe_dep_job *dep_job)
+{
+	struct xe_iova_defrag_job *job =
+		container_of(dep_job, typeof(*job), dep);
+
+	xe_tt_iova_copy_fini(&job->copy);
+	drm_sched_job_cleanup(&job->dep.drm);
+	kfree(job);
+}
+
+static const struct xe_dep_job_ops xe_iova_defrag_job_ops = {
+	.run_job = xe_iova_defrag_job_run,
+	.free_job = xe_iova_defrag_job_free,
+};
+
 /*
  * xe_tt_iova_transfer - Transfer a full IOVA reservation old_tt -> new_tt.
  *
@@ -1063,7 +1180,6 @@ static int xe_tt_map_iova_copy(struct xe_device *xe, struct ttm_tt *new_tt,
  * folio walk of the new tt keeps xe->mem.dma_mapped_pages[] exact while the new
  * mapping lives, rather than carrying the old tt's stale distribution.
  */
-__maybe_unused
 static void xe_tt_iova_transfer(struct xe_device *xe,
 				struct xe_ttm_tt *new_tt,
 				struct xe_ttm_tt *old_tt)
@@ -1078,6 +1194,135 @@ static void xe_tt_iova_transfer(struct xe_device *xe,
 	old_tt->use_iova = false;
 }
 
+/*
+ * xe_bo_defrag_iova_copy - Run an IOVA defrag move with a packed copy mapping.
+ *
+ * Only the changed (non-borrowed) pages of @new_tt are DMA mapped, packed
+ * contiguously into the front of its reservation, the GPU copy blits them from
+ * the old tt at natural offsets, and a post-copy finalize job adopts the old
+ * tt's full reservation and relinks the changed runs. Returns the finalize
+ * job's finished fence (the fence the move waits on), or an ERR_PTR on failure
+ * with all partial state unwound.
+ */
+static struct dma_fence *
+xe_bo_defrag_iova_copy(struct xe_device *xe, struct xe_migrate *migrate,
+		       struct xe_bo *bo, struct ttm_resource *old_mem,
+		       struct ttm_resource *new_mem, struct ttm_tt *old_tt,
+		       bool handle_system_ccs)
+{
+	struct ttm_tt *new_tt = bo->ttm.ttm;
+	struct xe_ttm_tt *new_xe_tt = container_of(new_tt, struct xe_ttm_tt, ttm);
+	struct xe_ttm_tt *old_xe_tt = container_of(old_tt, struct xe_ttm_tt, ttm);
+	struct drm_sched_entity *entity =
+		xe_dep_scheduler_entity(xe->mem.defrag.iova_sched);
+	struct xe_iova_defrag_job *job;
+	struct dma_fence *copy_fence;
+	struct dma_fence *fence;
+	struct xe_tt_iova_copy copy;
+	bool packed = false;
+	int err;
+
+	xe_assert(xe, new_xe_tt->use_iova && !new_xe_tt->iova_linked);
+	xe_assert(xe, old_xe_tt->use_iova && old_xe_tt->iova_linked);
+
+	err = xe_tt_iova_copy_init(new_tt, old_tt, &copy);
+	if (err)
+		return ERR_PTR(err);
+
+	if (copy.nr_changed) {
+		err = xe_tt_map_iova_copy(xe, new_tt, &copy);
+		if (err)
+			goto err_copy;
+		packed = true;
+
+		copy_fence = xe_migrate_copy_defrag_iova(migrate, bo, old_mem,
+							 new_mem, old_tt,
+							 copy.nr_changed,
+							 handle_system_ccs);
+	} else {
+		copy_fence = dma_fence_get_stub();
+	}
+	if (IS_ERR(copy_fence)) {
+		err = PTR_ERR(copy_fence);
+		goto err_unmap;
+	}
+
+	job = kzalloc(sizeof(*job), GFP_KERNEL);
+	if (!job) {
+		err = -ENOMEM;
+		goto err_fence;
+	}
+
+	job->dep.ops = &xe_iova_defrag_job_ops;
+	job->xe = xe;
+	job->new_tt = new_tt;
+	job->copy_iova = new_xe_tt->iova;
+	job->copy_bytes = (size_t)copy.nr_changed << PAGE_SHIFT;
+	job->copy = copy;
+
+	err = drm_sched_job_init(&job->dep.drm, entity, 1, NULL, 0);
+	if (err)
+		goto err_job;
+
+	err = drm_sched_job_add_dependency(&job->dep.drm,
+					   dma_fence_get(copy_fence));
+	if (err)
+		goto err_job_init;
+
+	/*
+	 * Point of no failure: transfer the old tt's full reservation to the
+	 * new tt. The finalize job (already armed below) destroys the packed
+	 * copy mapping snapshot and relinks the changed runs.
+	 */
+	xe_tt_iova_transfer(xe, new_xe_tt, old_xe_tt);
+	memset(&copy, 0, sizeof(copy)); /* ownership moved to the job */
+
+	drm_sched_job_arm(&job->dep.drm);
+	fence = dma_fence_get(&job->dep.drm.s_fence->finished);
+	drm_sched_entity_push_job(&job->dep.drm);
+
+	dma_fence_put(copy_fence);
+
+	return fence;
+
+err_job_init:
+	drm_sched_job_cleanup(&job->dep.drm);
+err_job:
+	kfree(job);
+err_fence:
+	dma_fence_put(copy_fence);
+err_unmap:
+	if (packed)
+		dma_iova_unlink(xe->drm.dev, &new_xe_tt->iova, 0,
+				(size_t)copy.nr_changed << PAGE_SHIFT,
+				DMA_BIDIRECTIONAL, DMA_ATTR_SKIP_CPU_SYNC);
+err_copy:
+	xe_tt_iova_copy_fini(&copy);
+	return ERR_PTR(err);
+}
+
+/*
+ * xe_bo_defrag_use_iova - Whether a defrag move should use the packed IOVA path.
+ *
+ * Eligible when the move is a defrag (stashed old tt) and the destination tt is
+ * IOVA mapped. The IOVA reservation is transferred to the new backing, so the
+ * device-visible addresses are preserved and no GPU rebind is needed (see
+ * xe_bo_trigger_rebind()); this makes the path worthwhile regardless of BO
+ * size. A flat-CCS aux pass, if needed, is migrated packed alongside the data
+ * (changed pages only), so it does not disqualify the path. Otherwise the
+ * full-mapping defrag path is used.
+ */
+static bool xe_bo_defrag_use_iova(struct ttm_buffer_object *ttm_bo)
+{
+	struct xe_ttm_tt *xe_tt;
+
+	if (!ttm_bo->defrag_old_tt || !ttm_bo->ttm)
+		return false;
+
+	xe_tt = container_of(ttm_bo->ttm, struct xe_ttm_tt, ttm);
+	return xe_tt->use_iova;
+}
+
 /*
  * Account ttm pages against the device shrinker's shrinkable and
  * purgeable counts.
@@ -1357,6 +1602,7 @@ static int xe_bo_trigger_rebind(struct xe_device *xe, struct xe_bo *bo,
 	struct drm_gem_object *obj = &bo->ttm.base;
 	struct drm_gpuvm_bo *vm_bo;
 	bool idle = false;
+	bool defrag_iova;
 	int ret = 0;
 
 	dma_resv_assert_held(bo->ttm.base.resv);
@@ -1369,12 +1615,25 @@ static int xe_bo_trigger_rebind(struct xe_device *xe, struct xe_bo *bo,
 		dma_resv_iter_end(&cursor);
 	}
 
+	/*
+	 * A defrag move that reallocates IOVA-mapped backing preserves the
+	 * device-visible addresses: the IOVA reservation is transferred from
+	 * the old to the new tt, so the existing GPU PTEs stay valid and the
+	 * BO must not be marked evicted (the rebind paths in xe_exec_ioctl()
+	 * and preempt_rebind_work_func() would otherwise needlessly rebind).
+	 * Preempt fences still need to be triggered, and fault-mode / L2
+	 * flush-optimized configs still need a TLB invalidation below, so only
+	 * the eviction marking is skipped.
+	 */
+	defrag_iova = xe_bo_defrag_use_iova(&bo->ttm);
+
 	drm_gem_for_each_gpuvm_bo(vm_bo, obj) {
 		struct xe_vm *vm = gpuvm_to_vm(vm_bo->vm);
 		struct drm_gpuva *gpuva;
 
 		if (!xe_vm_in_fault_mode(vm)) {
-			drm_gpuvm_bo_evict(vm_bo, true);
+			if (!defrag_iova)
+				drm_gpuvm_bo_evict(vm_bo, true);
 			/*
 			 * L2 cache may not be flushed, so ensure that is done in
 			 * xe_vm_invalidate_vma() below
@@ -1388,6 +1647,8 @@ static int xe_bo_trigger_rebind(struct xe_device *xe, struct xe_bo *bo,
 			 */
 			if (!xe_vm_flush_vm_bo_tlb_async(vm, bo, vm_bo))
 				continue;
+			else if (defrag_iova)
+				drm_gpuvm_bo_evict(vm_bo, true);
 		}
 
 		if (!idle) {
@@ -2096,6 +2357,7 @@ static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
 	bool needs_clear;
 	bool handle_system_ccs = (!IS_DGFX(xe) && xe_bo_needs_ccs_pages(bo) &&
 				  ttm && ttm_tt_is_populated(ttm)) ? true : false;
+	bool defrag_iova = xe_bo_defrag_use_iova(ttm_bo);
 	int ret = 0;
 
 	/*
@@ -2144,7 +2406,12 @@ static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
 	needs_clear = (ttm && ttm->page_flags & TTM_TT_FLAG_ZERO_ALLOC) ||
 		(!ttm && ttm_bo->type == ttm_bo_type_device);
 
-	if (new_mem->mem_type == XE_PL_TT) {
+	/*
+	 * For a defrag move using the packed IOVA path the destination tt is
+	 * not fully mapped here; only the changed pages are mapped (packed) for
+	 * the copy, and the finalize job establishes the full mapping.
+	 */
+	if (new_mem->mem_type == XE_PL_TT && !defrag_iova) {
 		ret = xe_tt_map(xe, ttm);
 		if (ret)
 			goto out;
@@ -2254,9 +2521,16 @@ static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
 
 		fence = xe_migrate_clear(migrate, bo, new_mem, flags);
 	} else if (ttm_bo->defrag_old_tt) {
-		fence = xe_migrate_copy_defrag(migrate, bo, old_mem, new_mem,
-					       ttm_bo->defrag_old_tt,
-					       handle_system_ccs);
+		if (defrag_iova)
+			fence = xe_bo_defrag_iova_copy(xe, migrate, bo, old_mem,
+						       new_mem,
+						       ttm_bo->defrag_old_tt,
+						       handle_system_ccs);
+		else
+			fence = xe_migrate_copy_defrag(migrate, bo, old_mem,
+						       new_mem,
+						       ttm_bo->defrag_old_tt,
+						       handle_system_ccs);
 	} else {
 		fence = xe_migrate_copy(migrate, bo, bo, old_mem, new_mem,
 					handle_system_ccs);
-- 
2.34.1

