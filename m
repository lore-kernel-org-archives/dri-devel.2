Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1425BCA5FDD
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 22:06:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10B1D10F779;
	Thu,  1 Oct 2026 22:06:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="R6x/WZmU";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DEC710E498;
 Thu,  1 Oct 2026 22:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790892400; x=1822428400;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9c7bGW4r2ZbGapJyTmfEei09wVnfqXp1OJnBziyjTvI=;
 b=R6x/WZmUWaGGi900vjZDasPjPfSKotyf6ASoxYNRpJIEQ017LFupxZ4r
 65nUISDKT7nr2t9m06pFkeSEp2g/WNWjoa0giUlzSWYLsikOiB7/R0JY5
 Z1c8biNaXddRsrVw6970CvcriyctqtZ3n20LOkPXUYSJYQMKjrit+mP9T
 7SFiMITYmmSbJ46Soh98QAL4u+wP7P1ebysbPIP/9tByp9ISjNy7zlqKS
 RDYgueT8fGeK2Pc8n1YXiMleyjHn9tIPy0GAkqkinfjvz9SAcGMtTEuE2
 EhdCi4oT79ldPuwwx4S/zXOkehyTzopmm7AfEELVLcVm4p3mcJnAH3Jwz w==;
X-CSE-ConnectionGUID: 1gO69XeaRu2JqDVQ9dqggA==
X-CSE-MsgGUID: q/Cc1t9DQxGUroEArkWuwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="91526798"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; d="scan'208";a="91526798"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 15:06:38 -0700
X-CSE-ConnectionGUID: IJF0IkQWSQ+7cPGu9Vk0YQ==
X-CSE-MsgGUID: EPyn4fBCRT+Ebq9o9DyAfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; d="scan'208";a="274190016"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 15:06:38 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Alice Ryhl <aliceryhl@google.com>,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Liviu Dudau <liviu.dudau@arm.com>, Lyude Paul <lyude@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maxime Ripard <mripard@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Sean Paul <sean@poorly.run>,
 Shuah Khan <skhan@linuxfoundation.org>, Simona Vetter <simona@ffwll.ch>,
 Steven Price <steven.price@arm.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Francois Dugast <francois.dugast@intel.com>
Subject: [PATCH v3 2/8] drm/xe: lock the resident BOs of an exec last
Date: Thu,  1 Oct 2026 15:06:26 -0700
Message-Id: <20261001220632.3190896-3-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261001220632.3190896-1-matthew.brost@intel.com>
References: <20261001220632.3190896-1-matthew.brost@intel.com>
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

xe_exec_ioctl() locks the dma-resv of every BO mapped in the VM in one
drm_exec transaction, then validates, rebinds and submits. Any migration
or fault-in a client needs therefore happens while it holds the dma-resv
of every object it has mapped, including the ones shared with other
processes. A client faulting in a large buffer of its own stalls whoever
else has those shared objects mapped, so the compositor it is presenting
to can miss a deadline over a set of BOs it has nothing to do with.

Most of those objects are not ones the exec has to validate. Make the
exec transaction two pass, so that it locks the evicted BOs first,
validates them, and only then locks the resident ones. It ends up
holding exactly the locks it holds today, it just takes the ones it does
not have to validate last, once the expensive work is already done.

Only the external BOs are actually split between the passes. The VM's
dma-resv is held from the start, as before, so the evicted private BOs
are validated in the early pass too, without anything extra being
locked for them.

Nothing is unlocked in between the passes, so this needs no recheck and
no fallback. The late pass can still find something to validate, since a
BO it had not locked yet may have been evicted meanwhile; that is handled
the way it is today, with every lock held.

Two details are worth pointing out. xe_vm_rebind() rebinds the whole
rebind list in one go and attaches a fence to the dma-resv of every BO
on it, so it needs all of them locked; the early pass deliberately does
not hold the resident ones, so it leaves the rebind to the late pass
entirely. That is also the better order, since rebinding allocates page
tables and can therefore evict the very BOs the early pass is trying to
leave alone. And the sched job's fence slot is reserved in the late pass
only, that being the one which holds every lock the transaction is going
to hold, so it is still reserved exactly once per object.

A concern with splitting the passes is that validating in the early pass
could evict the very BOs the late pass is about to lock, moving the work
back under the full set of locks. Xe is immune to this by construction:
__xe_bo_validate() brackets its ttm_bo_validate() call with
xe_vm_set_validating(), and xe_bo_eviction_valuable() walks the
drm_gpuvm_bos of any eviction candidate and refuses the ones bound to a VM
the current task is validating. The early pass therefore cannot evict a BO
mapped in the VM it is validating, whether or not the late pass was going
to lock it. That guard predates this patch; self-eviction is pointless
work in a single pass too.

While at it, xe_gpuvm_validate() is changed to clear the evicted state
with drm_gpuvm_bo_evict() rather than by assigning drm_gpuvm_bo::evicted
behind GPUVM's back, so that the bookkeeping GPUVM now does there is not
bypassed.

Cc: Abhinav Kumar <abhinav.kumar@linux.dev>
Cc: Alice Ryhl <aliceryhl@google.com>
Cc: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Cc: Antonino Maniscalco <antomani103@gmail.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: David Airlie <airlied@gmail.com>
Cc: Dmitry Baryshkov <lumag@kernel.org>
Cc: Jessica Zhang <jesszhan0024@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Lyude Paul <lyude@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Sean Paul <sean@poorly.run>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Steven Price <steven.price@arm.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Assisted-by: LLM
Reviewed-by: Francois Dugast <francois.dugast@intel.com>
---
v3:
 - Follow the drm_gpuvm_exec_pass_ function renames (Danilo)
---
 drivers/gpu/drm/xe/xe_exec.c | 23 ++++++++++++++++---
 drivers/gpu/drm/xe/xe_vm.c   | 43 ++++++++++++++++++++++++++++++------
 drivers/gpu/drm/xe/xe_vm.h   |  3 ++-
 3 files changed, 58 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_exec.c b/drivers/gpu/drm/xe/xe_exec.c
index d5293bc33a67..abe522c19ec9 100644
--- a/drivers/gpu/drm/xe/xe_exec.c
+++ b/drivers/gpu/drm/xe/xe_exec.c
@@ -79,8 +79,10 @@
  *	<----------------------------------------------------------------------|
  *	Lock global VM lock in read mode                                       |
  *	Pin userptrs (also finds userptr invalidated since last exec)          |
- *	Lock exec (VM dma-resv lock, external BOs dma-resv locks)              |
+ *	Lock exec early pass (VM and evicted external BOs dma-resv locks)      |
  *	Validate BOs that have been evicted                                    |
+ *	Lock exec late pass (the external BOs left out above)                  |
+ *	Validate any BO evicted since the early pass looked at it              |
  *	Create job                                                             |
  *	Rebind invalidated userptrs + evicted BOs (non-compute-mode)           |
  *	Add rebind fence dependency to job                                     |
@@ -95,15 +97,22 @@
 /*
  * Add validation and rebinding to the drm_exec locking loop, since both can
  * trigger eviction which may require sleeping dma_resv locks.
+ *
+ * Called once per pass, see xe_exec_ioctl(). The fence slot is intended for
+ * the exec sched job and is only reserved in the pass which holds every lock
+ * the transaction is going to hold, so that it is reserved exactly once.
  */
 static int xe_exec_fn(struct drm_gpuvm_exec *vm_exec)
 {
 	struct xe_vm *vm = container_of(vm_exec->vm, struct xe_vm, gpuvm);
+	unsigned int num_fences;
 	int ret;
 
-	/* The fence slot added here is intended for the exec sched job. */
+	num_fences = vm_exec->pass == DRM_GPUVM_EXEC_PASS_EARLY ? 0 : 1;
+
 	xe_vm_set_validation_exec(vm, &vm_exec->exec);
-	ret = xe_vm_validate_rebind(vm, &vm_exec->exec, 1);
+	ret = xe_vm_validate_rebind(vm, &vm_exec->exec, num_fences,
+				    vm_exec->pass);
 	xe_vm_set_validation_exec(vm, NULL);
 	return ret;
 }
@@ -268,6 +277,14 @@ int xe_exec_ioctl(struct drm_device *dev, void *data, struct drm_file *file)
 	if (!xe_vm_in_lr_mode(vm)) {
 		vm_exec.vm = &vm->gpuvm;
 		vm_exec.flags = DRM_EXEC_INTERRUPTIBLE_WAIT;
+		/*
+		 * Only the evicted BOs need validating, so lock those first,
+		 * validate them, and only then lock the resident ones. A
+		 * client faulting in a huge buffer of its own then no longer
+		 * holds, for the duration of that, the dma-resv of a BO it
+		 * shares with the compositor it presents to.
+		 */
+		vm_exec.two_pass = true;
 		err = xe_validation_exec_lock(&ctx, &vm_exec, &xe->val);
 		if (err)
 			goto err_unlock_list;
diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 2422bfde9177..0befae97008c 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -357,7 +357,7 @@ static int xe_gpuvm_validate(struct drm_gpuvm_bo *vm_bo, struct drm_exec *exec)
 
 	/* Skip re-populating purged BOs, rebind maps scratch pages. */
 	if (xe_bo_is_purged(bo)) {
-		vm_bo->evicted = false;
+		drm_gpuvm_bo_evict(vm_bo, false);
 		return 0;
 	}
 
@@ -368,7 +368,7 @@ static int xe_gpuvm_validate(struct drm_gpuvm_bo *vm_bo, struct drm_exec *exec)
 	if (ret)
 		return ret;
 
-	vm_bo->evicted = false;
+	drm_gpuvm_bo_evict(vm_bo, false);
 	return 0;
 }
 
@@ -377,31 +377,59 @@ static int xe_gpuvm_validate(struct drm_gpuvm_bo *vm_bo, struct drm_exec *exec)
  * @vm: The vm for which we are rebinding.
  * @exec: The struct drm_exec with the locked GEM objects.
  * @num_fences: The number of fences to reserve for the operation, not
- * including rebinds and validations.
+ * including rebinds and validations. Zero reserves none, which is what the
+ * %DRM_GPUVM_EXEC_PASS_EARLY pass wants.
+ * @pass: The &enum drm_gpuvm_exec_pass @exec was locked for.
  *
  * Validates all evicted gem objects and rebinds their vmas. Note that
  * rebindings may cause evictions and hence the validation-rebind
  * sequence is rerun until there are no more objects to validate.
  *
+ * In the %DRM_GPUVM_EXEC_PASS_EARLY pass only the validation is done, and
+ * only for the objects whose dma-resv @exec holds. The rest, along with the
+ * rebind and the fence reservation, is left to the
+ * %DRM_GPUVM_EXEC_PASS_LATE pass of the same transaction, which locks
+ * everything.
+ *
  * Return: 0 on success, negative error code on error. In particular,
  * may return -EINTR or -ERESTARTSYS if interrupted, and -EDEADLK if
  * the drm_exec transaction needs to be restarted.
  */
 int xe_vm_validate_rebind(struct xe_vm *vm, struct drm_exec *exec,
-			  unsigned int num_fences)
+			  unsigned int num_fences,
+			  enum drm_gpuvm_exec_pass pass)
 {
 	struct drm_gem_object *obj;
 	int ret;
 
 	do {
-		ret = drm_gpuvm_validate(&vm->gpuvm, exec);
+		ret = drm_gpuvm_exec_pass_validate(&vm->gpuvm, exec, pass);
 		if (ret)
 			return ret;
 
+		/*
+		 * xe_vm_rebind() rebinds the whole rebind list in one go and
+		 * attaches a fence to the dma-resv of every BO on it, so it
+		 * needs all of them locked. The early pass deliberately does
+		 * not lock the resident ones, so leave the rebind to the late
+		 * pass, which holds everything.
+		 */
+		if (pass == DRM_GPUVM_EXEC_PASS_EARLY)
+			continue;
+
 		ret = xe_vm_rebind(vm, false);
 		if (ret)
 			return ret;
-	} while (!list_empty(&vm->gpuvm.evict.list));
+	} while (drm_gpuvm_exec_pass_has_evicted(&vm->gpuvm, pass));
+
+	/*
+	 * The early pass reserves nothing. It attaches no fence itself, and
+	 * the objects it locks are still locked in the late pass, whose own
+	 * reservation below walks every object the transaction has
+	 * accumulated and so covers them too.
+	 */
+	if (!num_fences)
+		return 0;
 
 	drm_exec_for_each_locked_object(exec, obj) {
 		ret = dma_resv_reserve_fences(obj->resv, num_fences);
@@ -446,7 +474,8 @@ static int xe_preempt_work_begin(struct drm_exec *exec, struct xe_vm *vm,
 	 * The fence reservation here is intended for the new preempt fences
 	 * we attach at the end of the rebind work.
 	 */
-	return xe_vm_validate_rebind(vm, exec, vm->preempt.num_exec_queues);
+	return xe_vm_validate_rebind(vm, exec, vm->preempt.num_exec_queues,
+				     DRM_GPUVM_EXEC_PASS_ALL);
 }
 
 static bool vm_suspend_rebind_worker(struct xe_vm *vm)
diff --git a/drivers/gpu/drm/xe/xe_vm.h b/drivers/gpu/drm/xe/xe_vm.h
index 89c4f95984a2..e4f184752840 100644
--- a/drivers/gpu/drm/xe/xe_vm.h
+++ b/drivers/gpu/drm/xe/xe_vm.h
@@ -282,7 +282,8 @@ static inline void xe_vm_reactivate_rebind(struct xe_vm *vm)
 int xe_vm_lock_vma(struct drm_exec *exec, struct xe_vma *vma);
 
 int xe_vm_validate_rebind(struct xe_vm *vm, struct drm_exec *exec,
-			  unsigned int num_fences);
+			  unsigned int num_fences,
+			  enum drm_gpuvm_exec_pass pass);
 
 struct dma_fence *xe_vm_bind_kernel_bo(struct xe_vm *vm, struct xe_bo *bo,
 				       struct xe_exec_queue *q, u64 addr,
-- 
2.34.1

