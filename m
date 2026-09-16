Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 418C9C88E5C
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 09:53:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13BA410E2D9;
	Wed, 16 Sep 2026 09:53:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="nnhcg29L";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF02910E2D9;
 Wed, 16 Sep 2026 09:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789552436; x=1821088436;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lgxkA1bB4pYrY8keHeknn2/hdP4Fev2Z9x6Bbgtu53s=;
 b=nnhcg29LUKE64Nw6CSzIG5viNolyTjjwCXQU0gMDlB9t+q90u6cqyBnY
 dKnzyXXjJ33HHEGNIlO0IN3xMXE9kbK4Hc3otVgYwjI2/l/Ofbl6zXmrv
 P0d+fK45WH5Gp2Z5GCgj/LYR8ap0HtCcc7yAX1TmgAcrvG4SgeutxQQip
 D9I1GNSQo7UBRLv/h2XLRuNdZCQnXjSos2nXg1XJ3ePAGS3hMg9iE5Xra
 0lJTqIVD0Kp+vcSONrdFKifgf4nd58LhdZ9TPeL+Lf53O3BGyQg2oJE9w
 PbryzjplC87l1HfOE5EQcto9iyJxoSLDuNqLPVZAz+59iePn3YTMA2ToJ A==;
X-CSE-ConnectionGUID: m4XvRb3uQbWvMBtZP+nCGg==
X-CSE-MsgGUID: 5jf2QNp+QiqVhHXroJ8YoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="429603"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="429603"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa116.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 02:53:56 -0700
X-CSE-ConnectionGUID: 5Wnk3SJoTJC7oTkzVoxd8A==
X-CSE-MsgGUID: omALPw6gQwO1K+gmPyGgJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="277415573"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 02:53:54 -0700
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: rodrigo.vivi@intel.com, matthew.brost@intel.com,
 himal.prasad.ghimiray@intel.com, thomas.hellstrom@linux.intel.com
Subject: [PATCH 4/5] drm/xe: Defer VM teardown until exec queue cleanup
 completes
Date: Wed, 16 Sep 2026 15:23:36 +0530
Message-ID: <20260916095337.3104891-5-arvind.yadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916095337.3104891-1-arvind.yadav@intel.com>
References: <20260916095337.3104891-1-arvind.yadav@intel.com>
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

Exec queue destruction is asynchronous. Closing a VM immediately after
killing its queues can remove mappings before GuC cleanup has finished.

Track the queues using each VM and keep the bind queue's user_vm
reference until final queue destruction. Start queue cleanup before
removing the VM mappings.

The count includes VM-owned bind queues. Release the VM's references
to these queues before waiting for their asynchronous cleanup.

During file close, use one five-second wait budget across all VMs.
If queues remain, defer VM close until the last queue is removed.
The existing runtime-PM reference remains held during this wait.

VM destroy does not wait for queue cleanup. If user exec queues still
reference the VM, its mappings remain after the ioctl returns until
those queues finish cleanup. Userspace must destroy the remaining queue
handles or close the DRM file to release them.

The five-second budget limits the new queue wait, not the lifetime of
the retained mappings. Recovery continues through the existing GuC
reset and teardown paths.

Run deferred close and final VM destruction on the module-lifetime
destroy workqueue. Hold an extra VM reference until the close worker
has released its PM and unplug guards. Final VM destruction retains
the device reference until cleanup finishes.

Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
---
 drivers/gpu/drm/xe/xe_device.c     |  21 +++-
 drivers/gpu/drm/xe/xe_exec_queue.c |  22 ++--
 drivers/gpu/drm/xe/xe_module.c     |   6 +-
 drivers/gpu/drm/xe/xe_vm.c         | 178 +++++++++++++++++++++++++----
 drivers/gpu/drm/xe/xe_vm.h         |   5 +
 drivers/gpu/drm/xe/xe_vm_types.h   |  15 +++
 6 files changed, 214 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index 954f0965deb8..8966a3bd6eac 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -8,6 +8,7 @@
 #include <linux/aperture.h>
 #include <linux/delay.h>
 #include <linux/fault-inject.h>
+#include <linux/jiffies.h>
 #include <linux/units.h>
 
 #include <drm/drm_client.h>
@@ -175,6 +176,8 @@ static void xe_file_close(struct drm_device *dev, struct drm_file *file)
 	struct xe_file *xef = file->driver_priv;
 	struct xe_vm *vm;
 	struct xe_exec_queue *q;
+	bool close_deferred = false;
+	unsigned long deadline;
 	unsigned long idx;
 
 	guard(xe_pm_runtime)(xe);
@@ -195,8 +198,24 @@ static void xe_file_close(struct drm_device *dev, struct drm_file *file)
 		xe_exec_queue_kill(q);
 		xe_exec_queue_put(q);
 	}
+
+	/* Start all bind queue teardown before spending the shared wait budget. */
 	xa_for_each(&xef->vm.xa, idx, vm)
-		xe_vm_close_and_put(vm);
+		xe_vm_kill_bind_queues(vm);
+
+	deadline = jiffies + HZ * 5;
+	xa_for_each(&xef->vm.xa, idx, vm) {
+		unsigned long now = jiffies;
+		unsigned long timeout =
+			time_before(now, deadline) ? deadline - now : 0;
+
+		close_deferred |=
+			xe_vm_close_and_put_deferred(vm, timeout);
+	}
+
+	if (close_deferred)
+		drm_dbg(&xe->drm,
+			"VM teardown deferred while exec queues are being stopped\n");
 
 	scoped_guard(mutex, &xef->mmio_gem.lock) {
 		if (xef->mmio_gem.pci_barrier) {
diff --git a/drivers/gpu/drm/xe/xe_exec_queue.c b/drivers/gpu/drm/xe/xe_exec_queue.c
index e63559a2f582..82407dddfbbe 100644
--- a/drivers/gpu/drm/xe/xe_exec_queue.c
+++ b/drivers/gpu/drm/xe/xe_exec_queue.c
@@ -154,9 +154,16 @@ static void __xe_exec_queue_free(struct xe_exec_queue *q)
 
 	if (q->vm) {
 		xe_vm_remove_exec_queue(q->vm, q);
+		if (q->vm->xef)
+			xe_vm_remove_close_queue(q->vm);
 		xe_vm_put(q->vm);
 	}
 
+	if (q->user_vm) {
+		xe_vm_remove_close_queue(q->user_vm);
+		xe_vm_put(q->user_vm);
+	}
+
 	if (q->xef)
 		xe_file_put(q->xef);
 
@@ -250,8 +257,12 @@ static struct xe_exec_queue *__xe_exec_queue_alloc(struct xe_device *xe,
 		}
 	}
 
-	if (vm)
+	if (vm) {
 		q->vm = xe_vm_get(vm);
+		/* vm->xef stays unchanged until final VM destruction. */
+		if (vm->xef)
+			xe_vm_add_close_queue(vm);
+	}
 
 	if (extensions) {
 		/*
@@ -617,8 +628,10 @@ struct xe_exec_queue *xe_exec_queue_create_bind(struct xe_device *xe,
 			return ERR_PTR(err);
 		}
 
-		if (user_vm)
+		if (user_vm) {
 			q->user_vm = xe_vm_get(user_vm);
+			xe_vm_add_close_queue(user_vm);
+		}
 	}
 
 	return q;
@@ -657,11 +670,6 @@ void xe_exec_queue_destroy(struct kref *ref)
 			xe_exec_queue_put(eq);
 	}
 
-	if (q->user_vm) {
-		xe_vm_put(q->user_vm);
-		q->user_vm = NULL;
-	}
-
 	q->ops->destroy(q);
 }
 
diff --git a/drivers/gpu/drm/xe/xe_module.c b/drivers/gpu/drm/xe/xe_module.c
index 4bc28dfc1992..4e500156ed9b 100644
--- a/drivers/gpu/drm/xe/xe_module.c
+++ b/drivers/gpu/drm/xe/xe_module.c
@@ -114,9 +114,9 @@ static void xe_destroy_wq_module_exit(void)
  * xe_destroy_wq_queue() - Queue work on the destroy workqueue
  * @work: work item to queue
  *
- * The destroy workqueue has module lifetime and is used for GuC exec queue
- * teardown that can outlive a single xe_device. SVM pagemap destroy uses the
- * per-device xe->destroy_wq instead.
+ * Queue and VM cleanup can drop the last DRM device reference. This workqueue
+ * has module lifetime so device teardown cannot destroy a worker's own queue.
+ * SVM pagemap destroy uses the per-device xe->destroy_wq instead.
  *
  * Return: %true if @work was queued, %false if it was already pending.
  */
diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 5d0b616a27b3..152540a4741b 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -29,6 +29,7 @@
 #include "xe_exec_queue.h"
 #include "xe_gt.h"
 #include "xe_migrate.h"
+#include "xe_module.h"
 #include "xe_pat.h"
 #include "xe_pm.h"
 #include "xe_preempt_fence.h"
@@ -1558,6 +1559,7 @@ static const struct xe_pt_ops xelp_pt_ops = {
 	.pde_encode_bo = xelp_pde_encode_bo,
 };
 
+static void vm_close_work_func(struct work_struct *w);
 static void vm_destroy_work_func(struct work_struct *w);
 
 /**
@@ -1701,6 +1703,10 @@ struct xe_vm *xe_vm_create(struct xe_device *xe, u32 flags, struct xe_file *xef)
 	ttm_lru_bulk_move_init(&vm->lru_bulk_move);
 
 	INIT_WORK(&vm->destroy_work, vm_destroy_work_func);
+	atomic_set(&vm->close.num_exec_queues, 0);
+	init_waitqueue_head(&vm->close.wq);
+	spin_lock_init(&vm->close.lock);
+	INIT_WORK(&vm->close.work, vm_close_work_func);
 
 	INIT_LIST_HEAD(&vm->preempt.exec_queues);
 	for (id = 0; id < XE_MAX_TILES_PER_DEVICE * XE_MAX_GT_PER_TILE; ++id)
@@ -1948,25 +1954,7 @@ void xe_vm_close_and_put(struct xe_vm *vm)
 	if (xe_vm_in_fault_mode(vm))
 		xe_svm_close(vm);
 
-	down_write(&vm->lock);
-	for_each_tile(tile, xe, id) {
-		if (vm->q[id]) {
-			int i;
-
-			xe_exec_queue_last_fence_put(vm->q[id], vm);
-			for_each_tlb_inval(i)
-				xe_exec_queue_tlb_inval_last_fence_put(vm->q[id], vm, i);
-		}
-	}
-	up_write(&vm->lock);
-
-	for_each_tile(tile, xe, id) {
-		if (vm->q[id]) {
-			xe_exec_queue_kill(vm->q[id]);
-			xe_exec_queue_put(vm->q[id]);
-			vm->q[id] = NULL;
-		}
-	}
+	xe_vm_kill_bind_queues(vm);
 
 	down_write(&vm->lock);
 	xe_vm_lock(vm, false);
@@ -2038,6 +2026,148 @@ void xe_vm_close_and_put(struct xe_vm *vm)
 	xe_vm_put(vm);
 }
 
+static void vm_close_work_func(struct work_struct *w)
+{
+	struct xe_vm *vm = container_of(w, struct xe_vm, close.work);
+	struct xe_device *xe = vm->xe;
+	int idx;
+
+	/* Keep the VM and device alive until the PM and unplug guards unwind. */
+	xe_vm_get(vm);
+
+	if (drm_dev_enter(&xe->drm, &idx)) {
+		xe_pm_runtime_get(xe);
+		xe_vm_close_and_put(vm);
+		xe_pm_runtime_put(xe);
+		drm_dev_exit(idx);
+	} else {
+		/*
+		 * The device is gone. Drop the VM without a runtime PM reference.
+		 * xe_vm_close() guards its own register access.
+		 */
+		xe_vm_close_and_put(vm);
+	}
+
+	xe_vm_put(vm);
+}
+
+/**
+ * xe_vm_kill_bind_queues() - Kill and release the VM bind queues
+ * @vm: The VM whose bind queues should be stopped
+ *
+ * Callers must serialize teardown of @vm. Later calls are harmless because
+ * the first call clears the VM bind queue pointers.
+ */
+void xe_vm_kill_bind_queues(struct xe_vm *vm)
+{
+	struct xe_device *xe = vm->xe;
+	struct xe_tile *tile;
+	u8 id;
+
+	down_write(&vm->lock);
+	for_each_tile(tile, xe, id) {
+		if (vm->q[id]) {
+			int i;
+
+			xe_exec_queue_last_fence_put(vm->q[id], vm);
+			for_each_tlb_inval(i)
+				xe_exec_queue_tlb_inval_last_fence_put(vm->q[id],
+								       vm, i);
+		}
+	}
+	up_write(&vm->lock);
+
+	for_each_tile(tile, xe, id) {
+		if (vm->q[id]) {
+			xe_exec_queue_kill(vm->q[id]);
+			xe_exec_queue_put(vm->q[id]);
+			vm->q[id] = NULL;
+		}
+	}
+}
+
+/**
+ * xe_vm_add_close_queue() - Track an exec queue using the VM
+ * @vm: The VM used by the exec queue
+ *
+ * The queue is tracked until its asynchronous destruction completes.
+ */
+void xe_vm_add_close_queue(struct xe_vm *vm)
+{
+	atomic_inc(&vm->close.num_exec_queues);
+}
+
+/**
+ * xe_vm_remove_close_queue() - Stop tracking an exec queue
+ * @vm: The VM used by the exec queue
+ *
+ * If this is the last tracked queue and VM close was deferred, schedule
+ * the deferred VM close.
+ */
+void xe_vm_remove_close_queue(struct xe_vm *vm)
+{
+	bool queue_close = false;
+
+	if (!atomic_dec_and_test(&vm->close.num_exec_queues))
+		return;
+
+	wake_up_all(&vm->close.wq);
+
+	spin_lock(&vm->close.lock);
+	if (vm->close.deferred) {
+		vm->close.deferred = false;
+		queue_close = true;
+	}
+	spin_unlock(&vm->close.lock);
+
+	if (queue_close)
+		xe_destroy_wq_queue(&vm->close.work);
+}
+
+/**
+ * xe_vm_close_and_put_deferred() - Close a VM immediately or defer the close
+ * @vm: The VM reference to consume
+ * @timeout: Maximum time to wait for VM queues, in jiffies
+ *
+ * The VM must already be marked closing, and callers must serialize teardown.
+ * Release the VM-owned bind queues before waiting for queue cleanup. Callers
+ * may release them earlier to start cleanup for several VMs before waiting.
+ *
+ * If queues remain after @timeout, keep the mappings and finish VM close
+ * after the last tracked queue is freed. This consumes the caller's VM
+ * reference on both the immediate and deferred paths.
+ *
+ * Return: %true if VM close was deferred, or %false if it completed now.
+ */
+bool xe_vm_close_and_put_deferred(struct xe_vm *vm, unsigned long timeout)
+{
+	bool queue_close = false;
+
+	/* Drop VM-owned queue references before waiting for their final free. */
+	xe_vm_kill_bind_queues(vm);
+
+	if (!atomic_read(&vm->close.num_exec_queues) ||
+	    wait_event_timeout(vm->close.wq,
+			       !atomic_read(&vm->close.num_exec_queues),
+			       timeout)) {
+		xe_vm_close_and_put(vm);
+		return false;
+	}
+
+	spin_lock(&vm->close.lock);
+	vm->close.deferred = true;
+	if (!atomic_read(&vm->close.num_exec_queues)) {
+		vm->close.deferred = false;
+		queue_close = true;
+	}
+	spin_unlock(&vm->close.lock);
+
+	if (queue_close)
+		xe_destroy_wq_queue(&vm->close.work);
+
+	return true;
+}
+
 static void vm_destroy_work_func(struct work_struct *w)
 {
 	struct xe_vm *vm =
@@ -2083,8 +2213,7 @@ static void xe_vm_free(struct drm_gpuvm *gpuvm)
 	 */
 	drm_dev_get(&vm->xe->drm);
 
-	/* To destroy the VM we need to be able to sleep */
-	queue_work(system_dfl_wq, &vm->destroy_work);
+	xe_destroy_wq_queue(&vm->destroy_work);
 }
 
 struct xe_vm *xe_vm_lookup(struct xe_file *xef, u32 id)
@@ -2230,7 +2359,12 @@ int xe_vm_destroy_ioctl(struct drm_device *dev, void *data,
 
 	if (!err) {
 		xe_vm_close_start(vm);
-		xe_vm_close_and_put(vm);
+
+		/*
+		 * User exec queues can outlive the VM handle. Do not wait for
+		 * queues which this ioctl does not destroy.
+		 */
+		xe_vm_close_and_put_deferred(vm, 0);
 	}
 
 	return err;
diff --git a/drivers/gpu/drm/xe/xe_vm.h b/drivers/gpu/drm/xe/xe_vm.h
index 70456ffe27e2..efa427651c47 100644
--- a/drivers/gpu/drm/xe/xe_vm.h
+++ b/drivers/gpu/drm/xe/xe_vm.h
@@ -221,6 +221,11 @@ int xe_vm_get_property_ioctl(struct drm_device *dev, void *data,
 
 void xe_vm_close_and_put(struct xe_vm *vm);
 void xe_vm_close_start(struct xe_vm *vm);
+bool xe_vm_close_and_put_deferred(struct xe_vm *vm, unsigned long timeout);
+void xe_vm_kill_bind_queues(struct xe_vm *vm);
+
+void xe_vm_add_close_queue(struct xe_vm *vm);
+void xe_vm_remove_close_queue(struct xe_vm *vm);
 
 static inline bool xe_vm_in_fault_mode(struct xe_vm *vm)
 {
diff --git a/drivers/gpu/drm/xe/xe_vm_types.h b/drivers/gpu/drm/xe/xe_vm_types.h
index 16b051a0cf10..a3802f4fd00b 100644
--- a/drivers/gpu/drm/xe/xe_vm_types.h
+++ b/drivers/gpu/drm/xe/xe_vm_types.h
@@ -14,6 +14,7 @@
 #include <linux/kref.h>
 #include <linux/mmu_notifier.h>
 #include <linux/scatterlist.h>
+#include <linux/wait.h>
 
 #include "xe_device_types.h"
 #include "xe_pt_types.h"
@@ -314,6 +315,20 @@ struct xe_vm {
 	 */
 	struct work_struct destroy_work;
 
+	/** @close: State used to defer VM teardown until exec queues are gone. */
+	struct {
+		/** @close.num_exec_queues: Queues which can access this VM. */
+		atomic_t num_exec_queues;
+		/** @close.wq: Waitqueue for exec queue teardown. */
+		wait_queue_head_t wq;
+		/** @close.lock: Protects deferred and work scheduling. */
+		spinlock_t lock;
+		/** @close.deferred: VM close is waiting for queue teardown. */
+		bool deferred;
+		/** @close.work: Completes a deferred VM close. */
+		struct work_struct work;
+	} close;
+
 	/**
 	 * @rftree: range fence tree to track updates to page table structure.
 	 * Used to implement conflict tracking between independent bind engines.
-- 
2.43.0

