Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9E7606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 06:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eG3Zefx+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE4AB10E434;
	Mon, 16 Nov 2026 06:28:31 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86D0210E434;
 Mon, 16 Nov 2026 06:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794810504; x=1826346504;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=g9dbwB+hwpOmdvKXi+DhcyO5TLIsvixuWvFo5lOEhnM=;
 b=eG3Zefx+c8FVi+le7hnGCpnFBJb7xS+bCvY67o+eTiprWHpKKpBahGpY
 A4S6sQkMKi1eBjQSBN3iL2ioAyzNdw520qCKv2b6IF76SWKkXITrIxwK6
 pVVblybjHZd/LTdeJOqB7g/EV0rTAWTsG70+goBHjPdSb5JEICc+SqRRy
 7JpjVKinw9pWWewwFZmY/wJ8pqW6RJMBEGxbzJc7lq5qppJQEYZ+050ls
 uayhoaElw6b4HYZ32ZKBlCte2FFzBbrhw8tTW7CgyW1/eldtKBiZ2Xock
 wg44wqTBHPUXtj3EWKrVGR0chlzjTaq+pZZVXG0/L4CH2Z4D0gATL/q6+ Q==;
X-CSE-ConnectionGUID: +d0koU4iQLyzkfallxFZ/g==
X-CSE-MsgGUID: Hq2k80uJTQWXbUpfatR8nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3575734"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3575734"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2026 22:28:23 -0800
X-CSE-ConnectionGUID: ER0XxJWgQryifPxWb0U1NA==
X-CSE-MsgGUID: dss/ZbJvR1KD2IUigc6lpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9344715"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2026 22:28:21 -0800
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: rodrigo.vivi@intel.com, matthew.brost@intel.com,
 himal.prasad.ghimiray@intel.com, thomas.hellstrom@linux.intel.com,
 sanjay.kumar.yadav@intel.com, tejas.upadhyay@intel.com,
 daniel.charles@intel.com
Subject: [PATCH v3 3/3] drm/xe: Defer VM teardown until exec queue cleanup
 completes
Date: Mon, 16 Nov 2026 11:58:04 +0530
Message-ID: <20261116062804.1242511-4-arvind.yadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116062804.1242511-1-arvind.yadav@intel.com>
References: <20261116062804.1242511-1-arvind.yadav@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Exec queue destruction continues after xe_exec_queue_put() returns.
User queues can also outlive the VM handle. Closing the VM before
those queues finish cleanup can remove mappings still in use.

Track user exec queues and user-created bind queues until final queue
destruction. Add each close count under vm->lock so VM close cannot
miss a queue being created. Keep the bind queue's user_vm reference
until final queue destruction.

If tracked queues remain, retain the mappings and defer VM close
until the last queue is freed. Keep the existing scheduling-disable
wait on file close without adding a wait for the close count.

VM destroy can therefore return while mappings remain. Userspace
must destroy the remaining queue handles or close the DRM file
before those queues can finish cleanup.

Let pending user bind jobs drain during file close and queue destroy.
Killing these queues can make pending PT bind jobs clear mappings
while hardware queues still use them.

Exclude the VM-owned bind queue from the close count. Release it
after xe_vm_close() has waited for DMA_RESV_USAGE_BOOKKEEP fences.

Reject exec requests on closing VMs before userptr pinning, out-sync
signaling and rebind. Run deferred close on the module-lifetime
destroy workqueue and hold an extra VM reference until the worker
has released its runtime-PM reference and unplug guard.

v3:
- Remove the deadline calculation and use zero wait explicitly on file close.
  (Tejas)
- Document that internal bind queue cleanup can also defer VM teardown.
  (Sashiko)
- Clarify that mappings remain until all tracked exec queues finish cleanup.
  (Sashiko)
- Keep the counter recheck under close.lock to avoid missing the last
  queue's cleanup. (Sashiko)
- Keep VM-owned bind queues alive until pending bind fences complete.
  (Sashiko)
- Track user bind queues when assigning their file reference.
  (Sashiko)
- Let user bind jobs drain during file close instead of forcing pending
  PT updates to clear mappings before hardware queues have stopped.
  (Sashiko)
- Let user bind jobs drain in xe_exec_queue_destroy_ioctl().
- Count user bind queues before releasing vm->lock.
- Use user_vm_close_tracked to balance the count during final free,
  including creation failure paths.
- Make the bind queue helper static and remove the unused wait header.

Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Daniel Charles <daniel.charles@intel.com>
Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>
Assisted-by: LLM
Tested-by: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
---
 drivers/gpu/drm/xe/xe_device.c           |  22 +++-
 drivers/gpu/drm/xe/xe_exec.c             |   9 ++
 drivers/gpu/drm/xe/xe_exec_queue.c       |  39 ++++--
 drivers/gpu/drm/xe/xe_exec_queue_types.h |  11 ++
 drivers/gpu/drm/xe/xe_vm.c               | 156 +++++++++++++++++++++--
 drivers/gpu/drm/xe/xe_vm.h               |   4 +
 drivers/gpu/drm/xe/xe_vm_types.h         |  16 +++
 drivers/gpu/drm/xe/xe_wait_user_fence.c  |   5 +
 8 files changed, 237 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index 383afb2993a6..6eacb7cb65b1 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -177,6 +177,7 @@ static void xe_file_close(struct drm_device *dev, struct drm_file *file)
 	struct xe_file *xef = file->driver_priv;
 	struct xe_vm *vm;
 	struct xe_exec_queue *q;
+	bool close_deferred = false;
 	unsigned long idx;
 
 	guard(xe_pm_runtime)(xe);
@@ -194,16 +195,31 @@ static void xe_file_close(struct drm_device *dev, struct drm_file *file)
 	xa_for_each(&xef->exec_queue.xa, idx, q) {
 		if (q->vm && q->hwe->hw_engine_group)
 			xe_hw_engine_group_del_exec_queue(q->hwe->hw_engine_group, q);
-		xe_exec_queue_kill(q);
+		/*
+		 * Killing a bind queue can force pending PT jobs to clear
+		 * mappings while hardware exec queues are still running.
+		 * Let bind jobs drain before their queue is destroyed.
+		 */
+		if (!(q->flags & EXEC_QUEUE_FLAG_VM))
+			xe_exec_queue_kill(q);
 	}
 
 	xa_for_each(&xef->exec_queue.xa, idx, q) {
-		xe_exec_queue_kill_sync(q);
+		if (!(q->flags & EXEC_QUEUE_FLAG_VM))
+			xe_exec_queue_kill_sync(q);
 		xe_exec_queue_put(q);
 	}
 
+	/*
+	 * Queue cleanup is asynchronous. Retain VM mappings until tracked
+	 * queues complete final destruction.
+	 */
 	xa_for_each(&xef->vm.xa, idx, vm)
-		xe_vm_close_and_put(vm);
+		close_deferred |= xe_vm_close_and_put_deferred(vm);
+
+	if (close_deferred)
+		drm_dbg(&xe->drm,
+			"VM teardown deferred until exec queue cleanup completes\n");
 
 	scoped_guard(mutex, &xef->mmio_gem.lock) {
 		if (xef->mmio_gem.pci_barrier) {
diff --git a/drivers/gpu/drm/xe/xe_exec.c b/drivers/gpu/drm/xe/xe_exec.c
index 1949fb103fad..1c6f820eb17c 100644
--- a/drivers/gpu/drm/xe/xe_exec.c
+++ b/drivers/gpu/drm/xe/xe_exec.c
@@ -233,6 +233,15 @@ int xe_exec_ioctl(struct drm_device *dev, void *data, struct drm_file *file)
 	if (err)
 		goto err_hw_exec_mode;
 
+	if (xe_vm_is_closed_or_banned(vm)) {
+		err = -ECANCELED;
+		if (write_locked)
+			up_write(&vm->lock);
+		else
+			up_read(&vm->lock);
+		goto err_hw_exec_mode;
+	}
+
 	if (write_locked) {
 		err = xe_vm_userptr_pin(vm);
 		downgrade_write(&vm->lock);
diff --git a/drivers/gpu/drm/xe/xe_exec_queue.c b/drivers/gpu/drm/xe/xe_exec_queue.c
index af5d9e8f0b16..727440b4428c 100644
--- a/drivers/gpu/drm/xe/xe_exec_queue.c
+++ b/drivers/gpu/drm/xe/xe_exec_queue.c
@@ -155,9 +155,17 @@ static void __xe_exec_queue_free(struct xe_exec_queue *q)
 
 	if (q->vm) {
 		xe_vm_remove_exec_queue(q->vm, q);
+		if (q->vm->xef)
+			xe_vm_remove_close_queue(q->vm);
 		xe_vm_put(q->vm);
 	}
 
+	if (q->user_vm) {
+		if (q->user_vm_close_tracked)
+			xe_vm_remove_close_queue(q->user_vm);
+		xe_vm_put(q->user_vm);
+	}
+
 	if (q->xef)
 		xe_file_put(q->xef);
 
@@ -253,8 +261,12 @@ static struct xe_exec_queue *__xe_exec_queue_alloc(struct xe_device *xe,
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
@@ -653,11 +665,6 @@ void xe_exec_queue_destroy(struct kref *ref)
 	for_each_tlb_inval(q, i)
 		xe_exec_queue_tlb_inval_last_fence_put_unlocked(q, i);
 
-	if (q->user_vm) {
-		xe_vm_put(q->user_vm);
-		q->user_vm = NULL;
-	}
-
 	q->ops->destroy(q);
 }
 
@@ -1391,6 +1398,11 @@ int xe_exec_queue_create_ioctl(struct drm_device *dev, void *data,
 
 		q = xe_exec_queue_create_bind(xe, xe_device_get_root_tile(xe),
 					      vm, flags, args->extensions);
+		if (!IS_ERR(q)) {
+			/* Serialize close tracking with xe_vm_close_start(). */
+			q->user_vm_close_tracked = true;
+			xe_vm_add_close_queue(vm);
+		}
 		up_read(&vm->lock);
 		xe_vm_put(vm);
 		if (IS_ERR(q)) {
@@ -1466,6 +1478,7 @@ int xe_exec_queue_create_ioctl(struct drm_device *dev, void *data,
 	}
 
 	q->xef = xe_file_get(xef);
+
 	if (eci[0].engine_class != DRM_XE_ENGINE_CLASS_VM_BIND)
 		xe_vm_add_exec_queue(vm, q);
 
@@ -1660,17 +1673,27 @@ int xe_exec_queue_destroy_ioctl(struct drm_device *dev, void *data,
 
 	mutex_lock(&xef->exec_queue.lock);
 	q = xa_erase(&xef->exec_queue.xa, args->exec_queue_id);
-	if (q)
+	if (q) {
+		WRITE_ONCE(q->user_closed, true);
 		atomic_inc(&xef->exec_queue.pending_removal);
+	}
 	mutex_unlock(&xef->exec_queue.lock);
 
 	if (XE_IOCTL_DBG(xe, !q))
 		return -ENOENT;
 
+	/* Bind queues drain without kill, so wake their user-fence waiters here. */
+	wake_up_all(&xe->ufence_wq);
+
 	if (q->vm && q->hwe->hw_engine_group)
 		xe_hw_engine_group_del_exec_queue(q->hwe->hw_engine_group, q);
 
-	xe_exec_queue_kill(q);
+	/*
+	 * Let bind jobs drain. Killing their queue can turn pending PT binds
+	 * into PTE clears while hardware queues still use the VM.
+	 */
+	if (!(q->flags & EXEC_QUEUE_FLAG_VM))
+		xe_exec_queue_kill(q);
 
 	trace_xe_exec_queue_close(q);
 	xe_exec_queue_put(q);
diff --git a/drivers/gpu/drm/xe/xe_exec_queue_types.h b/drivers/gpu/drm/xe/xe_exec_queue_types.h
index 4882eeccb9bd..78af9ca7bdda 100644
--- a/drivers/gpu/drm/xe/xe_exec_queue_types.h
+++ b/drivers/gpu/drm/xe/xe_exec_queue_types.h
@@ -92,6 +92,11 @@ struct xe_exec_queue_group {
 struct xe_exec_queue {
 	/** @xef: Back pointer to xe file if this is user created exec queue */
 	struct xe_file *xef;
+	/**
+	 * @user_closed: The queue handle has been destroyed. Allows user-fence
+	 * waits to abort without killing pending bind jobs.
+	 */
+	bool user_closed;
 
 	/** @gt: GT structure this exec queue can submit to */
 	struct xe_gt *gt;
@@ -110,6 +115,12 @@ struct xe_exec_queue {
 	 * only)
 	 */
 	struct xe_vm *user_vm;
+	/**
+	 * @user_vm_close_tracked: This user bind queue holds a close count on
+	 * @user_vm. Set under user_vm->lock before publishing the queue and
+	 * unchanged until final free. VM-owned bind queues are not counted.
+	 */
+	bool user_vm_close_tracked;
 
 	/** @class: class of this exec queue */
 	enum xe_engine_class class;
diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index e6e53912448f..c091aceab56d 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -1623,7 +1623,9 @@ static const struct xe_pt_ops xelp_pt_ops = {
 	.pde_encode_bo = xelp_pde_encode_bo,
 };
 
+static void vm_close_work_func(struct work_struct *w);
 static void vm_destroy_work_func(struct work_struct *w);
+static void xe_vm_kill_bind_queues(struct xe_vm *vm);
 
 /**
  * xe_vm_create_scratch() - Setup a scratch memory pagetable tree for the
@@ -1766,6 +1768,9 @@ struct xe_vm *xe_vm_create(struct xe_device *xe, u32 flags, struct xe_file *xef)
 	ttm_lru_bulk_move_init(&vm->lru_bulk_move);
 
 	INIT_WORK(&vm->destroy_work, vm_destroy_work_func);
+	atomic_set(&vm->close.num_exec_queues, 0);
+	spin_lock_init(&vm->close.lock);
+	INIT_WORK(&vm->close.work, vm_close_work_func);
 
 	INIT_LIST_HEAD(&vm->preempt.exec_queues);
 	for (id = 0; id < XE_MAX_TILES_PER_DEVICE * XE_MAX_GT_PER_TILE; ++id)
@@ -2011,19 +2016,7 @@ void xe_vm_close_and_put(struct xe_vm *vm)
 	if (xe_vm_in_fault_mode(vm))
 		xe_svm_close(vm);
 
-	if (vm->q) {
-		int i;
-
-		down_write(&vm->lock);
-		xe_exec_queue_last_fence_put(vm->q, vm);
-		for_each_tlb_inval(vm->q, i)
-			xe_exec_queue_tlb_inval_last_fence_put(vm->q, vm, i);
-		up_write(&vm->lock);
-
-		xe_exec_queue_kill(vm->q);
-		xe_exec_queue_put(vm->q);
-		vm->q = NULL;
-	}
+	xe_vm_kill_bind_queues(vm);
 
 	down_write(&vm->lock);
 	xe_vm_lock(vm, false);
@@ -2093,6 +2086,134 @@ void xe_vm_close_and_put(struct xe_vm *vm)
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
+ * xe_vm_kill_bind_queues() - Kill and release the VM bind queue
+ * @vm: The VM whose bind queue should be stopped
+ *
+ * Called after xe_vm_close() has waited for pending bind fences. VM teardown
+ * is serialized by the caller.
+ */
+static void xe_vm_kill_bind_queues(struct xe_vm *vm)
+{
+	struct xe_exec_queue *q;
+	int i;
+
+	if (!vm->q)
+		return;
+
+	down_write(&vm->lock);
+	q = vm->q;
+	vm->q = NULL;
+	xe_exec_queue_last_fence_put(q, vm);
+	for_each_tlb_inval(q, i)
+		xe_exec_queue_tlb_inval_last_fence_put(q, vm, i);
+	up_write(&vm->lock);
+
+	xe_exec_queue_kill(q);
+	xe_exec_queue_put(q);
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
+ *
+ * The VM must already be marked closing, and callers must serialize teardown.
+ * Only user exec queues and user-created bind queues are tracked. Keep the
+ * VM-owned bind queue alive until xe_vm_close() has waited for pending bind
+ * fences. xe_vm_close_and_put() releases that queue afterwards.
+ *
+ * The caller's VM reference is consumed on both paths.
+ *
+ * Return: %true if VM close was deferred, or %false if it completed now.
+ */
+bool xe_vm_close_and_put_deferred(struct xe_vm *vm)
+{
+	bool queue_close = false;
+
+	/*
+	 * Keep the VM-owned bind queue alive. xe_vm_close_and_put() waits
+	 * for pending binds in xe_vm_close() before killing that queue.
+	 */
+	if (!atomic_read(&vm->close.num_exec_queues)) {
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
@@ -2289,7 +2410,14 @@ int xe_vm_destroy_ioctl(struct drm_device *dev, void *data,
 
 	if (!err) {
 		xe_vm_close_start(vm);
-		xe_vm_close_and_put(vm);
+
+		/*
+		 * User exec queues and user-created bind queues can outlive the
+		 * VM handle. Retain mappings until those queues finish cleanup.
+		 * The VM-owned bind queue is released by xe_vm_close_and_put().
+		 * The helper consumes the caller's VM reference.
+		 */
+		xe_vm_close_and_put_deferred(vm);
 	}
 
 	return err;
diff --git a/drivers/gpu/drm/xe/xe_vm.h b/drivers/gpu/drm/xe/xe_vm.h
index c90c9dc1351c..5632f0757b6a 100644
--- a/drivers/gpu/drm/xe/xe_vm.h
+++ b/drivers/gpu/drm/xe/xe_vm.h
@@ -221,6 +221,10 @@ int xe_vm_get_property_ioctl(struct drm_device *dev, void *data,
 
 void xe_vm_close_and_put(struct xe_vm *vm);
 void xe_vm_close_start(struct xe_vm *vm);
+bool xe_vm_close_and_put_deferred(struct xe_vm *vm);
+
+void xe_vm_add_close_queue(struct xe_vm *vm);
+void xe_vm_remove_close_queue(struct xe_vm *vm);
 
 static inline bool xe_vm_in_fault_mode(struct xe_vm *vm)
 {
diff --git a/drivers/gpu/drm/xe/xe_vm_types.h b/drivers/gpu/drm/xe/xe_vm_types.h
index 6ca9ef9d0c0b..bd2898c5ffb1 100644
--- a/drivers/gpu/drm/xe/xe_vm_types.h
+++ b/drivers/gpu/drm/xe/xe_vm_types.h
@@ -314,6 +314,22 @@ struct xe_vm {
 	 */
 	struct work_struct destroy_work;
 
+	/** @close: State used to defer VM teardown until exec queues are gone. */
+	struct {
+		/**
+		 * @close.num_exec_queues: User exec and user-created bind queues
+		 * that have not completed final free. Excludes the VM-owned bind
+		 * queue, which is released by xe_vm_close_and_put().
+		 */
+		atomic_t num_exec_queues;
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
diff --git a/drivers/gpu/drm/xe/xe_wait_user_fence.c b/drivers/gpu/drm/xe/xe_wait_user_fence.c
index e241f3ec3547..f78baa37e292 100644
--- a/drivers/gpu/drm/xe/xe_wait_user_fence.c
+++ b/drivers/gpu/drm/xe/xe_wait_user_fence.c
@@ -146,6 +146,11 @@ int xe_wait_user_fence_ioctl(struct drm_device *dev, void *data,
 		}
 
 		if (q) {
+			if (READ_ONCE(q->user_closed)) {
+				err = -EIO;
+				break;
+			}
+
 			if (q->ops->reset_status(q)) {
 				drm_info(&xe->drm, "exec queue reset detected\n");
 				err = -EIO;
-- 
2.43.0

