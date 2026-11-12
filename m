Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2D8606A327
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 15:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=P5cmMcMJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01761112157;
	Thu, 12 Nov 2026 15:03:36 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8239D112157;
 Thu, 12 Nov 2026 15:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794495810; x=1826031810;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=j6WAwCJTG9ufa2wVYkdYc2slGg3Mud8aW1YxVGHqQWs=;
 b=P5cmMcMJzTMdpQ2cFbmmKX7fEWjZZF0G0k5YjW77ZOSQRVWsken+SATd
 A5cFCor4OfOn9CpqVcv7g56r6liG+1vqVpCnG16PlwwhfE/nm8C1EkFe1
 DVxodgj2fUj0pgTPPCxaw5vrulCZ2KGjgJFUQxzSYWHzzIUOTMjEBQsKb
 FhJELeGa6Q1ioK1Q+stej8RNjlgY4xFbmANVaHQSVi3ToX7BIGdlF3wyX
 TTS79hbTrlBERUgdg9+cMoGES2IZX3BS90HuaM5Hu2o9feQdaFwmJVufR
 sRwHZ7khY0sAxhz3PJ0sAzQJ3hRrAGjtHUDjKd82uI2Vbk8llScRStHJ9 Q==;
X-CSE-ConnectionGUID: PTy79ydzTv681fd6WAAqNA==
X-CSE-MsgGUID: ntVLpnRXR3++5MkqHmyIyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3308466"
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="3308466"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2026 07:03:16 -0800
X-CSE-ConnectionGUID: eE7S9VblQtavaedL/vUuqw==
X-CSE-MsgGUID: HaflbMhrTxu9laEcik4TCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="8766932"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2026 07:03:14 -0800
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 3/3] CI-ONLY:Defer VM teardown until exec queue cleanup
Date: Thu, 12 Nov 2026 20:33:02 +0530
Message-ID: <20261112150302.3837896-4-arvind.yadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112150302.3837896-1-arvind.yadav@intel.com>
References: <20261112150302.3837896-1-arvind.yadav@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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

Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
---
 drivers/gpu/drm/xe/xe_device.c     |  19 +++-
 drivers/gpu/drm/xe/xe_exec_queue.c |  22 ++--
 drivers/gpu/drm/xe/xe_vm.c         | 162 ++++++++++++++++++++++++++---
 drivers/gpu/drm/xe/xe_vm.h         |   5 +
 drivers/gpu/drm/xe/xe_vm_types.h   |  15 +++
 5 files changed, 200 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index 1ef9e276bbca..675226bd72ff 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -8,6 +8,7 @@
 #include <linux/aperture.h>
 #include <linux/delay.h>
 #include <linux/error-injection.h>
+#include <linux/jiffies.h>
 #include <linux/units.h>
 
 #include <drm/drm_client.h>
@@ -177,6 +178,8 @@ static void xe_file_close(struct drm_device *dev, struct drm_file *file)
 	struct xe_file *xef = file->driver_priv;
 	struct xe_vm *vm;
 	struct xe_exec_queue *q;
+	bool close_deferred = false;
+	unsigned long deadline;
 	unsigned long idx;
 
 	guard(xe_pm_runtime)(xe);
@@ -198,7 +201,21 @@ static void xe_file_close(struct drm_device *dev, struct drm_file *file)
 		xe_exec_queue_put(q);
 	}
 	xa_for_each(&xef->vm.xa, idx, vm)
-		xe_vm_close_and_put(vm);
+		 xe_vm_kill_bind_queues(vm);
+
+	deadline = jiffies;
+	xa_for_each(&xef->vm.xa, idx, vm) {
+		unsigned long now = jiffies;
+		unsigned long timeout =
+			time_before(now, deadline) ? deadline - now : 0;
+
+			close_deferred |=
+			xe_vm_close_and_put_deferred(vm, timeout);
+	}
+
+	if (close_deferred)
+		drm_dbg(&xe->drm,
+			"VM teardown deferred while exec queues are being stopped\n");
 
 	scoped_guard(mutex, &xef->mmio_gem.lock) {
 		if (xef->mmio_gem.pci_barrier) {
diff --git a/drivers/gpu/drm/xe/xe_exec_queue.c b/drivers/gpu/drm/xe/xe_exec_queue.c
index 7ade915c59a8..1ee727c485fb 100644
--- a/drivers/gpu/drm/xe/xe_exec_queue.c
+++ b/drivers/gpu/drm/xe/xe_exec_queue.c
@@ -155,9 +155,16 @@ static void __xe_exec_queue_free(struct xe_exec_queue *q)
 
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
 
@@ -253,8 +260,12 @@ static struct xe_exec_queue *__xe_exec_queue_alloc(struct xe_device *xe,
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
@@ -620,8 +631,10 @@ struct xe_exec_queue *xe_exec_queue_create_bind(struct xe_device *xe,
 			return ERR_PTR(err);
 		}
 
-		if (user_vm)
+		if (user_vm) {
 			q->user_vm = xe_vm_get(user_vm);
+			xe_vm_add_close_queue(user_vm);
+		}
 	}
 
 	return q;
@@ -653,11 +666,6 @@ void xe_exec_queue_destroy(struct kref *ref)
 	for_each_tlb_inval(q, i)
 		xe_exec_queue_tlb_inval_last_fence_put_unlocked(q, i);
 
-	if (q->user_vm) {
-		xe_vm_put(q->user_vm);
-		q->user_vm = NULL;
-	}
-
 	q->ops->destroy(q);
 }
 
diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 903ec8e7c5e6..feb6c5ef5663 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -1623,6 +1623,7 @@ static const struct xe_pt_ops xelp_pt_ops = {
 	.pde_encode_bo = xelp_pde_encode_bo,
 };
 
+static void vm_close_work_func(struct work_struct *w);
 static void vm_destroy_work_func(struct work_struct *w);
 
 /**
@@ -1766,6 +1767,10 @@ struct xe_vm *xe_vm_create(struct xe_device *xe, u32 flags, struct xe_file *xef)
 	ttm_lru_bulk_move_init(&vm->lru_bulk_move);
 
 	INIT_WORK(&vm->destroy_work, vm_destroy_work_func);
+	atomic_set(&vm->close.num_exec_queues, 0);
+	init_waitqueue_head(&vm->close.wq);
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
@@ -2093,6 +2086,140 @@ void xe_vm_close_and_put(struct xe_vm *vm)
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
+ * Callers must serialize teardown of @vm. Later calls are harmless because
+ * the first call clears the VM bind queue pointer.
+ */
+void xe_vm_kill_bind_queues(struct xe_vm *vm)
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
@@ -2139,7 +2266,7 @@ static void xe_vm_free(struct drm_gpuvm *gpuvm)
 	drm_dev_get(&vm->xe->drm);
 
 	/* To destroy the VM we need to be able to sleep */
-	queue_work(vm->xe->destroy_wq, &vm->destroy_work);
+	xe_destroy_wq_queue(&vm->destroy_work);
 }
 
 struct xe_vm *xe_vm_lookup(struct xe_file *xef, u32 id)
@@ -2285,7 +2412,12 @@ int xe_vm_destroy_ioctl(struct drm_device *dev, void *data,
 
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
index c90c9dc1351c..72978a99f389 100644
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
index 6ca9ef9d0c0b..6ebc6714534b 100644
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

