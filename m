Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A50C4450F
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:55:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCF4310F97D;
	Fri, 10 Jul 2026 21:54:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Vdrquzm2";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79FFB10F93B;
 Fri, 10 Jul 2026 21:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783720491; x=1815256491;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fcfidIWa/KEJET7cTgO4bJxp85TYE9V8rmHRIgVials=;
 b=Vdrquzm2hfK4wkavDsjQzK35oKTHbdLzi9BcxuuRbpL3BCDSNJGBrwTA
 Q5LvRCwLyN5Onkz1Rx/rreIlixwAIsv1ZDQCRTPsgGyZzscN6CBTQa2RS
 KKcVsjNmbWduqO9lJsbE7E84OjRLyPV6fadmniVlFMJnsuvy454ENGgp/
 Sq6fT9Ip1REyw+EhOxmpOAxyXMAiybfFCP3CH6SJU5zSxI+KryvJAAzWV
 LAFi+CPqYmkgnUFU6R1cS0NdZVV16TRnnZc3PN12Xprg1c4aFY3ZqZIf2
 V49H01g+Mk0TpMVJIvoM/GjbLu3XUy1qwxX7GqzlVB0hchMxlBuu1f2CG g==;
X-CSE-ConnectionGUID: L6TZ+qgcQOmWlySrNrvRXQ==
X-CSE-MsgGUID: 1XDLwObiSmydJuBzxENPRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="83543128"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="83543128"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 14:54:51 -0700
X-CSE-ConnectionGUID: p7kqIlWNSPKfmipr3YSW8A==
X-CSE-MsgGUID: X31lQl/bThO2VkOK++zY7Q==
X-ExtLoop1: 1
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 14:54:51 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Tejas Upadhyay <tejas.upadhyay@intel.com>
Subject: [PATCH v2 13/33] drm/xe: Flush L2 asynchronously in
 xe_bo_trigger_rebind()
Date: Fri, 10 Jul 2026 14:54:22 -0700
Message-Id: <20260710215442.2444235-14-matthew.brost@intel.com>
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

On L2-flush-optimized HW with a dma-resv (non-fault) VM, evicting a BO
only needs to flush the L2 cache before the migration copy runs; the
mappings themselves are torn down and rebuilt lazily via
drm_gpuvm_bo_evict() and a subsequent rebind. Today this flush is done
by waiting for the BO to go idle and then issuing a synchronous TLB
invalidation per mapping VMA from inside xe_bo_trigger_rebind(). Both
the idle wait and the synchronous invalidation stall the calling thread
while holding the BO dma-resv lock, serializing the move behind all
in-flight GPU work on the BO.

Replace this with an asynchronous flush. Add xe_vm_flush_vm_bo_tlb_async()
which, for each VMA mapping the BO on each present tile, queues a TLB
invalidation job on the tile migrate (kernel) exec queue. The jobs depend
on the BO's in-flight GPU work, captured once as a singleton over
DMA_RESV_USAGE_BOOKKEEP, so the flush only fires once the GPU is done with
the current mapping. Each job's completion fence is installed into the
BO's dma-resv as a DMA_RESV_USAGE_KERNEL fence, so the migration copy -
which waits on the resv - waits on the flush without stalling this thread.

No PTEs are zapped and vma->tile_invalidated is left untouched: the
mapping stays valid until the lazy rebind, and the only work performed
here is the L2 flush. On any failure the caller falls back to the
existing blocking wait-idle plus xe_vm_invalidate_vma() path.

Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>
Assisted-by: GitHub_Copilot:claude-opus-4.8
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/xe/xe_bo.c |   7 +++
 drivers/gpu/drm/xe/xe_vm.c | 125 +++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_vm.h |   5 ++
 3 files changed, 137 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 60e0e568aa31..cca617cf34d1 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -732,6 +732,13 @@ static int xe_bo_trigger_rebind(struct xe_device *xe, struct xe_bo *bo,
 			 */
 			if (!xe_device_is_l2_flush_optimized(xe))
 				continue;
+
+			/*
+			 * Attempt to flush L2 async, fallback to sync flush on
+			 * failure
+			 */
+			if (!xe_vm_flush_vm_bo_tlb_async(vm, bo, vm_bo))
+				continue;
 		}
 
 		if (!idle) {
diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 73ac031ffb04..4557a8a4d270 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -39,6 +39,7 @@
 #include "xe_sync.h"
 #include "xe_tile.h"
 #include "xe_tlb_inval.h"
+#include "xe_tlb_inval_job.h"
 #include "xe_trace_bo.h"
 #include "xe_vm_madvise.h"
 #include "xe_wa.h"
@@ -4401,6 +4402,130 @@ int xe_vm_invalidate_vma(struct xe_vma *vma)
 	return ret;
 }
 
+/*
+ * xe_vma_tlb_flush_client - Queue an async TLB flush for one VMA on one client
+ *
+ * Create and push a TLB invalidation job on the tile migrate (kernel) exec
+ * queue covering @vma's range, depending on @dep (the BO's in-flight GPU work)
+ * so the flush only fires once the GPU is done with the current mapping. The
+ * job's completion fence is installed into @resv as a KERNEL fence so the
+ * subsequent migration waits on the flush. No PTEs are zapped; this only
+ * flushes L2 via the TLB invalidation.
+ */
+static int xe_vma_tlb_flush_client(struct xe_vm *vm, struct xe_vma *vma,
+				   struct xe_tile *tile, struct xe_gt *gt,
+				   struct dma_resv *resv, struct dma_fence *dep,
+				   int type)
+{
+	struct xe_exec_queue *q = xe_migrate_exec_queue(tile->migrate);
+	struct xe_tlb_inval_job *job;
+	struct dma_fence *fence;
+	int err;
+
+	job = xe_tlb_inval_job_create(q, &gt->tlb_inval,
+				      q->tlb_inval[type].dep_scheduler, vm,
+				      xe_vma_start(vma), xe_vma_end(vma), type);
+	if (IS_ERR(job))
+		return PTR_ERR(job);
+
+	err = xe_tlb_inval_job_alloc_dep(job);
+	if (err)
+		goto out_put;
+
+	err = dma_resv_reserve_fences(resv, 1);
+	if (err)
+		goto out_put;
+
+	/* Cannot fail; consumes a ref on @dep and returns a referenced fence. */
+	fence = xe_tlb_inval_job_push(job, tile->migrate, dep);
+	dma_resv_add_fence(resv, fence, DMA_RESV_USAGE_KERNEL);
+	dma_fence_put(fence);
+
+out_put:
+	/* Drop the creation reference (destroys the job if it was not pushed). */
+	xe_tlb_inval_job_put(job);
+	return err;
+}
+
+/**
+ * xe_vm_flush_vm_bo_tlb_async - Asynchronously flush TLBs for a vm_bo's mappings
+ * @vm: The VM @vm_bo belongs to
+ * @bo: The buffer object being moved
+ * @vm_bo: The gpuvm_bo linking @bo into @vm
+ *
+ * On L2-flush-optimized HW a BO move only needs to flush L2 (via a TLB
+ * invalidation) for the BO's live mappings; the mappings themselves are torn
+ * down and rebuilt lazily via the eviction/rebind path, so no PTEs need to be
+ * zapped here. Rather than blocking the caller on a synchronous invalidation,
+ * issue a TLB invalidation job per VMA per TLB-invalidation client (per present
+ * tile, primary and media GT). Each job waits on the BO's in-flight GPU work
+ * (all dma-resv usages) and its completion fence is installed into the BO's
+ * dma-resv KERNEL slots, so the following migration waits on the flush without
+ * stalling this thread.
+ *
+ * The caller must hold the BO's dma-resv lock and @vm must not be in fault
+ * mode.
+ *
+ * Return: 0 on success, negative error code on failure. On failure the caller
+ * should fall back to the blocking xe_vm_invalidate_vma() path; any jobs
+ * already queued install harmless extra flush fences.
+ */
+int xe_vm_flush_vm_bo_tlb_async(struct xe_vm *vm, struct xe_bo *bo,
+				struct drm_gpuvm_bo *vm_bo)
+{
+	struct xe_device *xe = vm->xe;
+	struct dma_resv *resv = bo->ttm.base.resv;
+	struct dma_fence *dep = NULL;
+	struct drm_gpuva *gpuva;
+	int err;
+
+	dma_resv_assert_held(resv);
+	xe_assert(xe, !xe_vm_in_fault_mode(vm));
+
+	/*
+	 * Single fence capturing all in-flight GPU work on the BO; the TLB
+	 * invalidation jobs depend on it so the flush fires only once the GPU
+	 * is done with the current mapping.
+	 */
+	err = dma_resv_get_singleton(resv, DMA_RESV_USAGE_BOOKKEEP, &dep);
+	if (err)
+		return err;
+	if (!dep)
+		dep = dma_fence_get_stub();
+
+	drm_gpuvm_bo_for_each_va(gpuva, vm_bo) {
+		struct xe_vma *vma = gpuva_to_vma(gpuva);
+		struct xe_tile *tile;
+		u8 id;
+
+		if (xe_vma_is_null(vma) || xe_vma_is_cpu_addr_mirror(vma))
+			continue;
+
+		for_each_tile(tile, xe, id) {
+			if (!(vma->tile_present & BIT(id)))
+				continue;
+
+			err = xe_vma_tlb_flush_client(vm, vma, tile,
+						      tile->primary_gt, resv, dep,
+						      XE_EXEC_QUEUE_TLB_INVAL_PRIMARY_GT);
+			if (err)
+				goto out;
+
+			if (tile->media_gt) {
+				err = xe_vma_tlb_flush_client(vm, vma, tile,
+							      tile->media_gt, resv, dep,
+							      XE_EXEC_QUEUE_TLB_INVAL_MEDIA_GT);
+				if (err)
+					goto out;
+			}
+		}
+	}
+
+out:
+	dma_fence_put(dep);
+	return err;
+}
+
 int xe_vm_validate_protected(struct xe_vm *vm)
 {
 	struct drm_gpuva *gpuva;
diff --git a/drivers/gpu/drm/xe/xe_vm.h b/drivers/gpu/drm/xe/xe_vm.h
index c5b900f38ded..dd5b070eaede 100644
--- a/drivers/gpu/drm/xe/xe_vm.h
+++ b/drivers/gpu/drm/xe/xe_vm.h
@@ -26,6 +26,8 @@ struct ttm_buffer_object;
 
 struct dma_fence;
 
+struct xe_bo;
+struct drm_gpuvm_bo;
 struct xe_exec_queue;
 struct xe_file;
 struct xe_pagefault;
@@ -254,6 +256,9 @@ int xe_vm_invalidate_vma(struct xe_vma *vma);
 
 int xe_vm_invalidate_vma_submit(struct xe_vma *vma, struct xe_tlb_inval_batch *batch);
 
+int xe_vm_flush_vm_bo_tlb_async(struct xe_vm *vm, struct xe_bo *bo,
+				struct drm_gpuvm_bo *vm_bo);
+
 int xe_vm_validate_protected(struct xe_vm *vm);
 
 static inline void xe_vm_queue_rebind_worker(struct xe_vm *vm)
-- 
2.34.1

