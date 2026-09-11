Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F2CC88E4C
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 11:40:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C405110F4A4;
	Fri, 11 Sep 2026 11:40:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="SYi4RtFZ";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 85C3C10F431
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 11:40:45 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E76916A3;
 Fri, 11 Sep 2026 04:40:41 -0700 (PDT)
Received: from e120398-lin.trondheim.arm.com (e120398-lin.trondheim.arm.com
 [10.42.46.160])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F8403F59E;
 Fri, 11 Sep 2026 04:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1789126844; bh=TnOmt3K1qTraKX6HLPhVaaYc0aQNiV5Lzudv8VcOZYg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SYi4RtFZsNAjADmmS5RaD/dT2civ/7Qn3NNLKk38NC64VLkpA2JSYbBqOKn4hpEEK
 PH291uMHq9Ek5Ld3gzINZqFr4jwqsmObttExv2eSpoaqtpXVx2BoSpkFcslFFL8JR9
 n+eKwLzXAJtn2eTEep+k06aUYj8opalmv/KvDwkw=
From: Ketil Johnsen <ketil.johnsen@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Florent Tomasin <florent.tomasin@arm.com>,
 Paul Toadere <paul.toadere@arm.com>,
 Samuel Percival <samuel.percival@arm.com>,
 Ketil Johnsen <ketil.johnsen@arm.com>
Subject: [PATCH v3 5/6] drm/panthor: Add support for entering and exiting
 protected mode
Date: Fri, 11 Sep 2026 13:40:13 +0200
Message-ID: <20260911114014.79139-6-ketil.johnsen@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911114014.79139-1-ketil.johnsen@arm.com>
References: <20260911114014.79139-1-ketil.johnsen@arm.com>
MIME-Version: 1.0
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

From: Florent Tomasin <florent.tomasin@arm.com>

This patch modifies the Panthor driver code to allow handling
of the GPU HW protected mode enter and exit.

The logic added by this patch includes:
- the mechanisms needed for entering and exiting protected mode.
- the handling of protected mode IRQs and FW interactions.
- the scheduler changes needed to decide when to enter
  protected mode based on CSG scheduling.
- GPU fault handling during protected mode execution.

Note that the submission of a protected mode jobs are done
from the user space.

The following is a summary of how protected mode is entered
and exited:
- When the GPU detects a protected mode job needs to be
  executed, an IRQ is sent to the CPU to notify the kernel
  driver that the job is blocked until the GPU has entered
  protected mode. The entering of protected mode is controlled
  by the kernel driver.
- The Mali Panthor CSF driver will schedule a tick and evaluate
  which CS in the CSG to schedule on slot needs protected mode.
  If the priority of the CSG is not sufficiently high, the
  protected mode job will not progress until the CSG is
  scheduled at top priority.
- The Panthor scheduler notifies the GPU that the blocked
  protected jobs will soon be able to progress.
- Once all CSG and CS slots are updated, the scheduler
  requests the GPU to enter protected mode and waits for
  it to be acknowledged.
- If successful, all protected mode jobs will resume execution
  while normal mode jobs block until the GPU exits
  protected mode, or the kernel driver rotates the CSGs
  and forces the GPU to exit protected mode.
- If unsuccessful, the scheduler will request a GPU reset.
- Faults during protected mode are reported GPU wide, and not as
  CSG/CS errors. We allow only one CSG to run in protected mode at a
  time so we know which CSG to blame for the fault.
- All faults during protected mode are handled with a GPU reset.
- When a protected mode job is suspended as a result of
  the CSGs rotation, the GPU will send an IRQ to the CPU
  to notify that the protected mode job needs to resume.

This sequence will continue so long the user space is
submitting protected mode jobs.

Signed-off-by: Florent Tomasin <florent.tomasin@arm.com>
Co-developed-by: Paul Toadere <paul.toadere@arm.com>
Signed-off-by: Paul Toadere <paul.toadere@arm.com>
Co-developed-by: Samuel Percival <samuel.percival@arm.com>
Signed-off-by: Samuel Percival <samuel.percival@arm.com>
Co-developed-by: Ketil Johnsen <ketil.johnsen@arm.com>
Signed-off-by: Ketil Johnsen <ketil.johnsen@arm.com>

---

v3:
- Rebase
  - Required changes due to new IRQ handling (events_lock).
  - Required changes due to memory reclaim (more places to sync with protm).
- Count number of enter and exits to and from protected mode.
- Added helper function wait_protm_enter() to check protm enter condition, using
  the counters mentioned above.
- Tweaks to timeouts.
- Removed disable/enable of GPU_IRQ_PROTM_FAULT. No longer recall what issue it
  was supposed to fix.
- protm_fault changed to atomic.
- Moved sync with protm out from panthor_vm_lock_region() and
  panthor_vm_unlock_region().
  - Avoids special dealing with as.slots_lock and GPU reset.
  - Block and unblock of protm in same function, so easier to see.
  - We no longer need to add panthor_vm_expand_locked_region() (different patch).
  - The downside is that we might block protm mode more than necessary.
- Added panthor_sched_protm_try_block() used by memory reclaim case.
- protm_pending_queues made atomic (following the same change for fatal_queues).
- Only clear bits from protm_pending_queues when we ACK CS_PROTM_PENDING.
- Clear any pending CS_PROTM_PENDING on slot reset.
- Ack all CS_PROTM_PENDING in tick_ctx_handle_protm_group(), no matter the value
  of protm_pending_queues.
- Inlined helper function panthor_sched_protm_enter().

v2:
- Heavily reworked, although conceptually similar to v1.
---
 drivers/gpu/drm/panthor/panthor_device.c |   1 +
 drivers/gpu/drm/panthor/panthor_device.h |  31 ++
 drivers/gpu/drm/panthor/panthor_fw.c     |  92 +++++-
 drivers/gpu/drm/panthor/panthor_fw.h     |   4 +
 drivers/gpu/drm/panthor/panthor_gpu.c    |  47 ++-
 drivers/gpu/drm/panthor/panthor_gpu.h    |   4 +
 drivers/gpu/drm/panthor/panthor_mmu.c    |  24 +-
 drivers/gpu/drm/panthor/panthor_sched.c  | 350 +++++++++++++++++++++--
 drivers/gpu/drm/panthor/panthor_sched.h  |   4 +
 9 files changed, 533 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
index 9687c59de3505..0a41f69c473c3 100644
--- a/drivers/gpu/drm/panthor/panthor_device.c
+++ b/drivers/gpu/drm/panthor/panthor_device.c
@@ -172,6 +172,7 @@ int panthor_device_init(struct panthor_device *ptdev)
 
 	ptdev->soc_data = of_device_get_match_data(ptdev->base.dev);
 
+	init_rwsem(&ptdev->protm.lock);
 	init_completion(&ptdev->unplug.done);
 	ret = drmm_mutex_init(&ptdev->base, &ptdev->unplug.lock);
 	if (ret)
diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index b55a3f9edd414..f1b7f51f5ae1e 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -336,6 +336,37 @@ struct panthor_device {
 		struct list_head node;
 	} gems;
 #endif
+	/** @protm: Protected mode related data. */
+	struct {
+		/**
+		 * @lock: Lock to prevent MMU operations during protected mode.
+		 *
+		 * The MMU HW will silently ignore commands issued when the
+		 * GPU is in protected mode. It is important that we handle this
+		 * for some of the MMU HW interactions.
+		 *
+		 * Code which interacts with the MMU, typically by calling
+		 * panthor_vm_lock_region(), should therefore ensure the
+		 * scheduler is not in and will not enter protected mode first.
+		 * This is done by calling either
+		 * - panthor_sched_protm_block(), or
+		 * - panthor_sched_protm_try_block()
+		 *
+		 * Once the MMU operations have completed, call
+		 * panthor_sched_protm_unblock() to tell the scheduler that
+		 * it is safe to enter protected mode again.
+		 *
+		 * The block/unblock for MMU operations take this as reader.
+		 * The scheduler holds this as writer when switching into protm.
+		 */
+		struct rw_semaphore lock;
+
+		/** @protm_enter_count: Number of times entered protm. */
+		atomic64_t protm_enter_count;
+
+		/** @protm_exit_count: Number of times exited protm. */
+		atomic64_t protm_exit_count;
+	} protm;
 };
 
 struct panthor_gpu_usage {
diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index 5f9f7a92c56a8..96770ce34da84 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -1067,7 +1067,9 @@ static void panthor_fw_init_global_iface(struct panthor_device *ptdev)
 					 GLB_CFG_PROGRESS_TIMER |
 					 GLB_CFG_POWEROFF_TIMER |
 					 GLB_IDLE_EN |
-					 GLB_IDLE;
+					 GLB_IDLE |
+					 GLB_PROTM_ENTER |
+					 GLB_PROTM_EXIT;
 
 	if (panthor_fw_has_glb_state(ptdev))
 		glb_iface->input->ack_irq_mask |= GLB_STATE_MASK;
@@ -1281,6 +1283,9 @@ int panthor_fw_post_reset(struct panthor_device *ptdev)
 		return ret;
 	}
 
+	atomic64_set(&ptdev->protm.protm_enter_count, 0);
+	atomic64_set(&ptdev->protm.protm_exit_count, 0);
+
 	/* We must re-initialize the global interface even on fast-reset. */
 	panthor_fw_init_global_iface(ptdev);
 	return 0;
@@ -1476,6 +1481,91 @@ static void panthor_fw_ping_work(struct work_struct *work)
 	}
 }
 
+static bool wait_protm_enter(struct panthor_device *ptdev,
+			     long long enter_count)
+{
+	return (panthor_gpu_status(ptdev) & GPU_STATUS_PROTM_ACTIVE) ||
+	       (atomic64_read(&ptdev->protm.protm_exit_count) >= enter_count);
+}
+
+int panthor_fw_protm_enter(struct panthor_device *ptdev)
+{
+	struct panthor_fw_global_iface *glb_iface =
+		panthor_fw_get_glb_iface(ptdev);
+	u32 acked;
+	int ret;
+	long long enter_count;
+
+	/* Restart the watchdog timer, so it doesn't hit immediately
+	 * after entering protected mode, since this will cause GPU
+	 * to exit protected mode to respond to the ping request.
+	 */
+	mod_delayed_work(ptdev->reset.wq, &ptdev->fw->watchdog.ping_work,
+			 msecs_to_jiffies(PING_INTERVAL_MS));
+
+	panthor_fw_toggle_reqs(glb_iface, req, ack, GLB_PROTM_ENTER);
+	panthor_fw_ring_doorbell(ptdev, CSF_GLB_DOORBELL_ID);
+
+	ret = panthor_fw_glb_wait_acks(ptdev, GLB_PROTM_ENTER, &acked, 250);
+	if (ret) {
+		drm_err(&ptdev->base,
+			"Wait for FW protected mode acknowledge timed out");
+		return ret;
+	}
+
+	enter_count = atomic64_inc_return(&ptdev->protm.protm_enter_count);
+
+	/* Poll for the entry of protected mode.
+	 * It is possible that GPU_STATUS_PROTM_ACTIVE is set and cleared
+	 * before we check it below, so we must also check for GLB_PROTM_EXIT.
+	 * GLB_PROTM_EXIT can not be checked directly, because this could also
+	 * be handled and clear before we check below. We count number of
+	 * protm enters and exits to safely handle that case.
+	 */
+	ret = wait_event_timeout(ptdev->fw->req_waitqueue,
+				 wait_protm_enter(ptdev, enter_count),
+				 msecs_to_jiffies(500));
+	if (!ret) {
+		drm_err(&ptdev->base,
+			"Wait for GPU protected mode enter timed out");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+int panthor_fw_protm_exit_wait(struct panthor_device *ptdev, u32 timeout_ms)
+{
+	int ret;
+
+	ret = wait_event_timeout(ptdev->fw->req_waitqueue,
+				 !(panthor_gpu_status(ptdev) &
+				   GPU_STATUS_PROTM_ACTIVE),
+				 msecs_to_jiffies(timeout_ms));
+	if (!ret)
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
+int panthor_fw_protm_exit(struct panthor_device *ptdev, u32 timeout_ms)
+{
+	struct panthor_fw_global_iface *glb_iface =
+		panthor_fw_get_glb_iface(ptdev);
+	int ret;
+
+	/* Send PING request to force an exit */
+	panthor_fw_toggle_reqs(glb_iface, req, ack, GLB_PING);
+	panthor_fw_ring_doorbell(ptdev, CSF_GLB_DOORBELL_ID);
+
+	ret = panthor_fw_protm_exit_wait(ptdev, timeout_ms);
+	if (ret)
+		drm_err(&ptdev->base,
+			"Wait for GPU protected mode exit timed out");
+
+	return ret;
+}
+
 /**
  * panthor_fw_init() - Initialize FW related data.
  * @ptdev: Device.
diff --git a/drivers/gpu/drm/panthor/panthor_fw.h b/drivers/gpu/drm/panthor/panthor_fw.h
index a99a9b6f4825c..4eda8f8e714c1 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.h
+++ b/drivers/gpu/drm/panthor/panthor_fw.h
@@ -529,4 +529,8 @@ static inline int panthor_fw_resume(struct panthor_device *ptdev)
 int panthor_fw_init(struct panthor_device *ptdev);
 void panthor_fw_unplug(struct panthor_device *ptdev);
 
+int panthor_fw_protm_enter(struct panthor_device *ptdev);
+int panthor_fw_protm_exit(struct panthor_device *ptdev, u32 timeout_ms);
+int panthor_fw_protm_exit_wait(struct panthor_device *ptdev, u32 timeout_ms);
+
 #endif
diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
index a383b04f101ed..27617f3a72394 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu.c
+++ b/drivers/gpu/drm/panthor/panthor_gpu.c
@@ -46,6 +46,9 @@ struct panthor_gpu {
 
 	/** @cache_flush_lock: Lock to serialize cache flushes */
 	struct mutex cache_flush_lock;
+
+	/** @protm_fault: True if a GPU_IRQ_PROTM_FAULT has been raised */
+	atomic_t protm_fault;
 };
 
 #define GPU_INTERRUPTS_MASK	\
@@ -91,6 +94,34 @@ static void panthor_gpu_irq_handler(struct panthor_irq *pirq, u32 status)
 	struct panthor_device *ptdev = pirq->ptdev;
 	struct panthor_gpu *gpu = ptdev->gpu;
 
+	if (status & GPU_IRQ_PROTM_FAULT) {
+		/* Make a note of this fault before we clear the interrupt.
+		 * This ensures panthor_gpu_protm_fault_pending() can always
+		 * give an accurate answer.
+		 *
+		 * There is a race we need to handle between two interrupts,
+		 * this GPU_IRQ_PROTM_FAULT and JOB_INT_GLOBAL_IF with the
+		 * GLB_PROTM_EXIT event.
+		 *
+		 * Although GPU_IRQ_PROTM_FAULT is always raised first,
+		 * processing of GLB_PROTM_EXIT could still execute first.
+		 * The handling of GLB_PROTM_EXIT MUST know if a
+		 * GPU_IRQ_PROTM_FAULT has been raised or not, otherwise it
+		 * could incorrectly think everything is fine and resume
+		 * with normal scheduling to early.
+		 *
+		 * We still need to do fault handling (reset) here as well,
+		 * because some failures during protected mode do not
+		 * automatically exit protected mode (no GLB_PROTM_EXIT).
+		 * This means there is a slim chance we do two GPU resets
+		 * instead of just one. This is not ideal, but should be safe.
+		 */
+		atomic_set(&gpu->protm_fault, 1);
+
+		drm_warn(&ptdev->base, "GPU Fault in protected mode\n");
+		panthor_device_schedule_reset(ptdev);
+	}
+
 	gpu_write(gpu->irq.iomem, INT_CLEAR, status);
 
 	if (tracepoint_enabled(gpu_power_status) && (status & GPU_POWER_INTERRUPTS_MASK))
@@ -107,8 +138,6 @@ static void panthor_gpu_irq_handler(struct panthor_irq *pirq, u32 status)
 			 fault_status, panthor_exception_name(ptdev, fault_status & 0xFF),
 			 address);
 	}
-	if (status & GPU_IRQ_PROTM_FAULT)
-		drm_warn(&ptdev->base, "GPU Fault in protected mode\n");
 
 	spin_lock(&ptdev->gpu->reqs_lock);
 	if (status & ptdev->gpu->pending_reqs) {
@@ -123,6 +152,13 @@ static irqreturn_t panthor_gpu_irq_threaded_handler(int irq, void *data)
 	return panthor_irq_default_threaded_handler(data, panthor_gpu_irq_handler);
 }
 
+bool panthor_gpu_protm_fault_pending(struct panthor_device *ptdev)
+{
+	return atomic_read(&ptdev->gpu->protm_fault) ||
+	       gpu_read(ptdev->gpu->irq.iomem, INT_RAWSTAT) &
+		       GPU_IRQ_PROTM_FAULT;
+}
+
 /**
  * panthor_gpu_unplug() - Called when the GPU is unplugged.
  * @ptdev: Device to unplug.
@@ -404,6 +440,8 @@ int panthor_gpu_soft_reset(struct panthor_device *ptdev)
 	struct panthor_gpu *gpu = ptdev->gpu;
 	bool timedout = false;
 
+	atomic_set(&ptdev->gpu->protm_fault, 0);
+
 	scoped_guard(spinlock, &ptdev->gpu->reqs_lock) {
 		if (!drm_WARN_ON(&ptdev->base,
 				ptdev->gpu->pending_reqs & GPU_IRQ_RESET_COMPLETED)) {
@@ -508,3 +546,8 @@ int panthor_gpu_coherency_init(struct panthor_device *ptdev)
 	drm_err(&ptdev->base, "Coherency not supported by the device");
 	return -ENOTSUPP;
 }
+
+u32 panthor_gpu_status(struct panthor_device *ptdev)
+{
+	return gpu_read(ptdev->gpu->iomem, GPU_STATUS);
+}
diff --git a/drivers/gpu/drm/panthor/panthor_gpu.h b/drivers/gpu/drm/panthor/panthor_gpu.h
index f615feb056094..00ec9a8c5d7fd 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu.h
+++ b/drivers/gpu/drm/panthor/panthor_gpu.h
@@ -60,4 +60,8 @@ u64 panthor_gpu_get_cycle_count(struct panthor_device *ptdev);
 
 int panthor_gpu_coherency_init(struct panthor_device *ptdev);
 
+u32 panthor_gpu_status(struct panthor_device *ptdev);
+
+bool panthor_gpu_protm_fault_pending(struct panthor_device *ptdev);
+
 #endif
diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 3e5f20768d545..1e1a158aa12ed 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -2505,6 +2505,11 @@ int panthor_vm_evict_bo_mappings_locked(struct panthor_gem_object *bo)
 		if (!mutex_trylock(&vm->op_lock))
 			return -EDEADLK;
 
+		if (panthor_sched_protm_try_block(vm->ptdev)) {
+			mutex_unlock(&vm->op_lock);
+			return -EDEADLK;
+		}
+
 		/* It can be that the vm_bo was already evicted but a new
 		 * mapping pointing to this BO got created in the meantime,
 		 * thus turning the vm_bo in partially evicted state. In that case
@@ -2540,6 +2545,7 @@ int panthor_vm_evict_bo_mappings_locked(struct panthor_gem_object *bo)
 			vma->evicted = true;
 		}
 
+		panthor_sched_protm_unblock(vm->ptdev);
 		mutex_unlock(&vm->op_lock);
 
 		if (ret)
@@ -2612,6 +2618,10 @@ static int remap_evicted_vma(struct drm_gpuvm_bo *vm_bo,
 	}
 
 	if (found) {
+		ret = panthor_sched_protm_block(vm->ptdev);
+		if (ret)
+			goto out_unlock;
+
 		vm->op_ctx = op_ctx;
 		ret = panthor_vm_lock_region(vm, evicted_vma->base.va.addr,
 					     evicted_vma->base.va.range);
@@ -2633,9 +2643,12 @@ static int remap_evicted_vma(struct drm_gpuvm_bo *vm_bo,
 			panthor_vm_unlock_region(vm);
 		}
 
+		panthor_sched_protm_unblock(vm->ptdev);
+
 		vm->op_ctx = NULL;
 	}
 
+out_unlock:
 	mutex_unlock(&vm->op_lock);
 
 out_cleanup:
@@ -2726,9 +2739,13 @@ panthor_vm_exec_op(struct panthor_vm *vm, struct panthor_vm_op_ctx *op,
 	mutex_lock(&vm->op_lock);
 	vm->op_ctx = op;
 
+	ret = panthor_sched_protm_block(vm->ptdev);
+	if (ret)
+		goto out_unlock;
+
 	ret = panthor_vm_lock_region(vm, op->va.addr, op->va.range);
 	if (ret)
-		goto out;
+		goto out_unblock;
 
 	switch (op_type) {
 	case DRM_PANTHOR_VM_BIND_OP_TYPE_MAP: {
@@ -2759,10 +2776,13 @@ panthor_vm_exec_op(struct panthor_vm *vm, struct panthor_vm_op_ctx *op,
 
 	panthor_vm_unlock_region(vm);
 
-out:
+out_unblock:
+	panthor_sched_protm_unblock(vm->ptdev);
+
 	if (ret && flag_vm_unusable_on_failure)
 		panthor_vm_declare_unusable(vm);
 
+out_unlock:
 	vm->op_ctx = NULL;
 	mutex_unlock(&vm->op_lock);
 
diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 0c8ea07fc7b9d..1fe77e5c41995 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -306,6 +306,17 @@ struct panthor_scheduler {
 		 */
 		struct list_head stopped_groups;
 	} reset;
+
+	/** @protm: Protected mode related fields. */
+	struct {
+		/**
+		 * @active_group: The active protected group.
+		 *
+		 * We only allow one protected group to run at the same time,
+		 * as it makes it easier to handle faults in protected mode.
+		 */
+		struct panthor_group *active_group;
+	} protm;
 };
 
 /**
@@ -570,6 +581,16 @@ struct panthor_group {
 	 */
 	atomic_t fatal_queues;
 
+	/**
+	 * @protm_pending_queues: Bitmask reflecting the queues that have raised
+	 *                        a CS_PROTM_PENDING.
+	 *
+	 * The GPU will set the bit associated to the queue pending protected
+	 * mode when a PROT_REGION command is executing or when trying to resume
+	 * previously suspended protected mode jobs.
+	 */
+	atomic_t protm_pending_queues;
+
 	/** @tiler_oom: Mask of queues that have a tiler OOM event to process. */
 	atomic_t tiler_oom;
 
@@ -1149,12 +1170,14 @@ cs_slot_reset_locked(struct panthor_device *ptdev, u32 csg_id, u32 cs_id)
 	struct panthor_fw_cs_iface *cs_iface = panthor_fw_get_cs_iface(ptdev, csg_id, cs_id);
 	struct panthor_group *group = ptdev->scheduler->csg_slots[csg_id].group;
 	struct panthor_queue *queue = group->queues[cs_id];
+	u32 val, mask;
 
 	lockdep_assert_held(&ptdev->scheduler->lock);
 
-	panthor_fw_update_reqs(cs_iface, req,
-			       CS_STATE_STOP,
-			       CS_STATE_MASK);
+	val = CS_STATE_STOP | (cs_iface->output->ack & CS_PROTM_PENDING);
+	mask = CS_STATE_MASK | CS_PROTM_PENDING;
+
+	panthor_fw_update_reqs(cs_iface, req, val, mask);
 
 	queue_suspend_timeout(queue);
 
@@ -1393,6 +1416,27 @@ csg_slot_prog_locked(struct panthor_device *ptdev, u32 csg_id, u32 priority)
 	return 0;
 }
 
+static void
+cs_slot_process_protm_pending_event_locked(struct panthor_device *ptdev,
+					   u32 csg_id, u32 cs_id)
+{
+	struct panthor_scheduler *sched = ptdev->scheduler;
+	struct panthor_csg_slot *csg_slot = &sched->csg_slots[csg_id];
+	struct panthor_group *group = csg_slot->group;
+
+	lockdep_assert_held(&sched->events_lock);
+
+	if (!group)
+		return;
+
+	/* Do not allow user space work to switch into protected mode, as we
+	 * do not fully support this quite yet.
+	 */
+	atomic_or(BIT(cs_id), &group->fatal_queues);
+
+	sched_queue_delayed_work(sched, tick, 0);
+}
+
 static void
 cs_slot_process_fatal_event_locked(struct panthor_device *ptdev,
 				   u32 csg_id, u32 cs_id)
@@ -1641,6 +1685,10 @@ static bool cs_slot_process_irq_locked(struct panthor_device *ptdev,
 	if (events & CS_TILER_OOM)
 		cs_slot_process_tiler_oom_event_locked(ptdev, csg_id, cs_id);
 
+	if (events & CS_PROTM_PENDING)
+		cs_slot_process_protm_pending_event_locked(ptdev, csg_id,
+							   cs_id);
+
 	/* We don't acknowledge the TILER_OOM event since its handling is
 	 * deferred to a separate work.
 	 */
@@ -1855,6 +1903,38 @@ static void sched_process_idle_event_locked(struct panthor_device *ptdev)
 	sched_queue_delayed_work(ptdev->scheduler, tick, 0);
 }
 
+static void sched_process_protm_exit_event_locked(struct panthor_device *ptdev)
+{
+	struct panthor_fw_global_iface *glb_iface =
+		panthor_fw_get_glb_iface(ptdev);
+	struct panthor_scheduler *sched = ptdev->scheduler;
+
+	lockdep_assert_held(&sched->events_lock);
+
+	atomic64_inc(&ptdev->protm.protm_exit_count);
+
+	/* Acknowledge the protm exit */
+	panthor_fw_update_reqs(glb_iface, req, glb_iface->output->ack,
+			       GLB_PROTM_EXIT);
+
+	/* If there are pending fault from protected mode execution, then early
+	 * out here. The GPU_IRQ_PROTM_FAULT handling will trigger the propper
+	 * error recovery via a GPU reset.
+	 */
+	if (panthor_gpu_protm_fault_pending(ptdev))
+		return;
+
+	/* Protected mode exited successfully. Clear protm.active_group so that
+	 * tick_work() is unblocked to schedule new work.
+	 */
+	if (sched->protm.active_group) {
+		group_put(sched->protm.active_group);
+		sched->protm.active_group = NULL;
+	}
+
+	sched_queue_delayed_work(sched, tick, 0);
+}
+
 /**
  * sched_process_global_irq_locked() - Process the scheduling part of a global IRQ
  * @ptdev: Device.
@@ -1870,6 +1950,9 @@ static void sched_process_global_irq_locked(struct panthor_device *ptdev)
 	ack = READ_ONCE(glb_iface->output->ack);
 	evts = (req ^ ack) & GLB_EVT_MASK;
 
+	if (evts & GLB_PROTM_EXIT)
+		sched_process_protm_exit_event_locked(ptdev);
+
 	if (evts & GLB_IDLE)
 		sched_process_idle_event_locked(ptdev);
 }
@@ -1881,22 +1964,22 @@ static void sched_process_global_irq_locked(struct panthor_device *ptdev)
  */
 void panthor_sched_report_fw_events(struct panthor_device *ptdev, u32 events)
 {
+	u32 csg_events = events & ~JOB_INT_GLOBAL_IF;
+
 	if (!ptdev->scheduler)
 		return;
 
 	guard(spinlock)(&ptdev->scheduler->events_lock);
 
-	if (events & JOB_INT_GLOBAL_IF) {
-		sched_process_global_irq_locked(ptdev);
-		events &= ~JOB_INT_GLOBAL_IF;
-	}
-
-	while (events) {
-		u32 csg_id = ffs(events) - 1;
+	while (csg_events) {
+		u32 csg_id = ffs(csg_events) - 1;
 
 		sched_process_csg_irq_locked(ptdev, csg_id);
-		events &= ~BIT(csg_id);
+		csg_events &= ~BIT(csg_id);
 	}
+
+	if (events & JOB_INT_GLOBAL_IF)
+		sched_process_global_irq_locked(ptdev);
 }
 
 /**
@@ -1982,6 +2065,69 @@ group_unbind_locked(struct panthor_group *group)
 	return 0;
 }
 
+static void handle_protm_fault(struct panthor_device *ptdev)
+{
+	struct panthor_scheduler *sched = ptdev->scheduler;
+	u32 csg_id;
+	struct panthor_group *protm_group;
+
+	guard(mutex)(&sched->lock);
+
+	protm_group = sched->protm.active_group;
+
+	if (!protm_group || !panthor_gpu_protm_fault_pending(ptdev))
+		return;
+
+	atomic_set(&protm_group->fatal_queues,
+		   GENMASK(protm_group->queue_count - 1, 0));
+
+	/* Different kinds of faults during protected mode can give different
+	 * behavior/state.
+	 * Case 1) The fault keeps the GPU in protected mode.
+	 *         In this case, the request to exit protected mode below will
+	 *         fail and we need to take some further action.
+	 * Case 2) The fault do not keep the GPU in protected mode.
+	 *         In this case, the request to exit protected
+	 *         mode below will succeed, and we don't need to take any
+	 *         further action right here.
+	 */
+	if (!panthor_fw_protm_exit(ptdev, 500))
+		return;
+
+	/* GPU failed to exit protected mode.
+	 * Mark all CSGs as suspended and unbind them, so that they are
+	 * unaffected by the GPU reset itself.
+	 * We can not suspend the groups in this case, because we are stuck
+	 * in protected mode. That is also the reason it is safe to unbind
+	 * without suspending first (the groups are already "suspended").
+	 * The failing protected group will be scheduled for termination.
+	 */
+
+	for (csg_id = 0; csg_id < sched->csg_slot_count; csg_id++) {
+		struct panthor_group *group = sched->csg_slots[csg_id].group;
+
+		if (!group)
+			continue;
+
+		group_get(group);
+
+		group->state = PANTHOR_CS_GROUP_SUSPENDED;
+		group_unbind_locked(group);
+
+		drm_WARN_ON(&group->ptdev->base, !list_empty(&group->run_node));
+
+		if (group_can_run(group)) {
+			list_add(&group->run_node,
+				 &sched->groups.idle[group->priority]);
+		} else {
+			list_del_init(&group->wait_node);
+			group_queue_work(group, term);
+		}
+
+		group_put(group);
+	}
+}
+
 static const char *fence_get_driver_name(struct dma_fence *fence)
 {
 	return "panthor";
@@ -2011,6 +2157,12 @@ static void csgs_upd_ctx_init(struct panthor_csg_slots_upd_ctx *ctx)
 	memset(ctx, 0, sizeof(*ctx));
 }
 
+static void csgs_upd_ctx_ring_doorbell(struct panthor_csg_slots_upd_ctx *ctx,
+				       u32 csg_id)
+{
+	ctx->update_mask |= BIT(csg_id);
+}
+
 static void csgs_upd_ctx_queue_reqs(struct panthor_device *ptdev,
 				    struct panthor_csg_slots_upd_ctx *ctx,
 				    u32 csg_id, u32 value, u32 mask)
@@ -2021,7 +2173,8 @@ static void csgs_upd_ctx_queue_reqs(struct panthor_device *ptdev,
 
 	ctx->requests[csg_id].value = (ctx->requests[csg_id].value & ~mask) | (value & mask);
 	ctx->requests[csg_id].mask |= mask;
-	ctx->update_mask |= BIT(csg_id);
+
+	csgs_upd_ctx_ring_doorbell(ctx, csg_id);
 }
 
 static int csgs_upd_ctx_apply_locked(struct panthor_device *ptdev,
@@ -2038,8 +2191,12 @@ static int csgs_upd_ctx_apply_locked(struct panthor_device *ptdev,
 	while (update_slots) {
 		struct panthor_fw_csg_iface *csg_iface;
 		u32 csg_id = ffs(update_slots) - 1;
+		u32 req_mask = ctx->requests[csg_id].mask;
 
 		update_slots &= ~BIT(csg_id);
+		if (!req_mask)
+			continue;
+
 		csg_iface = panthor_fw_get_csg_iface(ptdev, csg_id);
 		panthor_fw_update_reqs(csg_iface, req,
 				       ctx->requests[csg_id].value,
@@ -2056,6 +2213,9 @@ static int csgs_upd_ctx_apply_locked(struct panthor_device *ptdev,
 		int ret;
 
 		update_slots &= ~BIT(csg_id);
+		if (!req_mask)
+			continue;
+
 		csg_iface = panthor_fw_get_csg_iface(ptdev, csg_id);
 
 		ret = panthor_fw_csg_wait_acks(ptdev, csg_id, req_mask, &acked, 100);
@@ -2092,6 +2252,7 @@ struct panthor_sched_tick_ctx {
 	bool immediate_tick;
 	bool stop_tick;
 	u32 csg_upd_failed_mask;
+	struct panthor_group *protm_group;
 };
 
 static bool
@@ -2133,6 +2294,11 @@ tick_ctx_pick_groups_from_list(const struct panthor_scheduler *sched,
 		if (!owned_by_tick_ctx)
 			group_get(group);
 
+		/* Only the first pick is allowed to request switch to protm */
+		if (ctx->group_count == 0 &&
+		    atomic_read(&group->protm_pending_queues))
+			ctx->protm_group = group;
+
 		ctx->group_count++;
 
 		/* If we have more than one active group with the same priority,
@@ -2291,6 +2457,48 @@ static void group_term_work(struct work_struct *work)
 	group_put(group);
 }
 
+int panthor_sched_protm_block(struct panthor_device *ptdev)
+{
+	int ret;
+
+	down_read(&ptdev->protm.lock);
+
+	/* First, wait a little bit for FW to exit protected mode on its own.
+	 * Only if that fails do we request a protected mode exit.
+	 */
+
+	ret = panthor_fw_protm_exit_wait(ptdev, 5);
+	if (ret) {
+		ret = panthor_fw_protm_exit(ptdev, 2000);
+		if (ret)
+			up_read(&ptdev->protm.lock);
+	}
+
+	return ret;
+}
+
+int panthor_sched_protm_try_block(struct panthor_device *ptdev)
+{
+	int ret;
+
+	ret = down_read_trylock(&ptdev->protm.lock);
+	if (ret) {
+		if (panthor_gpu_status(ptdev) & GPU_STATUS_PROTM_ACTIVE) {
+			up_read(&ptdev->protm.lock);
+			return -EAGAIN;
+		}
+
+		return 0;
+	}
+
+	return -EAGAIN;
+}
+
+void panthor_sched_protm_unblock(struct panthor_device *ptdev)
+{
+	up_read(&ptdev->protm.lock);
+}
+
 static void
 tick_ctx_cleanup(struct panthor_scheduler *sched,
 		 struct panthor_sched_tick_ctx *ctx)
@@ -2414,6 +2622,46 @@ tick_ctx_schedule_group(struct panthor_scheduler *sched,
 	return 0;
 }
 
+static void
+tick_ctx_handle_protm_group(struct panthor_scheduler *sched,
+			    struct panthor_csg_slots_upd_ctx *upd_ctx,
+			    struct panthor_group *group)
+{
+	struct panthor_device *ptdev = sched->ptdev;
+	struct panthor_fw_csg_iface *csg_iface =
+		panthor_fw_get_csg_iface(ptdev, group->csg_id);
+	u32 q;
+	u32 cs_acked = 0;
+
+	if (drm_WARN_ON(&ptdev->base, group->csg_id < 0))
+		return;
+
+	for (q = 0; q < group->queue_count; q++) {
+		struct panthor_fw_cs_iface *cs_iface =
+			panthor_fw_get_cs_iface(ptdev, group->csg_id, q);
+
+		/* Ack any pending CS_PROTM_PENDING so it can run in protm */
+		if ((cs_iface->output->ack ^ cs_iface->input->req) &
+		    CS_PROTM_PENDING) {
+			drm_WARN_ON(
+				&ptdev->base,
+				!(atomic_read(&group->protm_pending_queues) &
+				  BIT(q)));
+
+			panthor_fw_update_reqs(cs_iface, req,
+					       cs_iface->output->ack,
+					       CS_PROTM_PENDING);
+			cs_acked |= BIT(q);
+		}
+	}
+
+	/* Clear only the ones we acked */
+	atomic_andnot(cs_acked, &group->protm_pending_queues);
+
+	panthor_fw_toggle_reqs(csg_iface, doorbell_req, doorbell_ack, cs_acked);
+	csgs_upd_ctx_ring_doorbell(upd_ctx, group->csg_id);
+}
+
 static void
 tick_ctx_apply(struct panthor_scheduler *sched, struct panthor_sched_tick_ctx *ctx)
 {
@@ -2483,6 +2731,9 @@ tick_ctx_apply(struct panthor_scheduler *sched, struct panthor_sched_tick_ctx *c
 		}
 	}
 
+	if (ctx->protm_group)
+		tick_ctx_handle_protm_group(sched, &upd_ctx, ctx->protm_group);
+
 	ret = csgs_upd_ctx_apply_locked(ptdev, &upd_ctx);
 	if (ret) {
 		panthor_device_schedule_reset(ptdev);
@@ -2490,6 +2741,24 @@ tick_ctx_apply(struct panthor_scheduler *sched, struct panthor_sched_tick_ctx *c
 		return;
 	}
 
+	if (ctx->protm_group) {
+		if (drm_WARN_ON(&ptdev->base, sched->protm.active_group))
+			group_put(sched->protm.active_group);
+
+		sched->protm.active_group = ctx->protm_group;
+		group_get(sched->protm.active_group);
+
+		down_write(&ptdev->protm.lock);
+
+		ret = panthor_fw_protm_enter(ptdev);
+		if (ret) {
+			panthor_device_schedule_reset(ptdev);
+			ctx->csg_upd_failed_mask = U32_MAX;
+		}
+
+		up_write(&ptdev->protm.lock);
+	}
+
 	for (prio = PANTHOR_CSG_PRIORITY_COUNT - 1; prio >= 0; prio--) {
 		list_for_each_entry_safe(group, tmp, &ctx->groups[prio], run_node) {
 			list_del_init(&group->run_node);
@@ -2579,6 +2848,23 @@ static void tick_work(struct work_struct *work)
 	if (panthor_device_reset_is_pending(sched->ptdev))
 		goto out_unlock;
 
+	if (sched->protm.active_group) {
+		bool rt_groups_waiting = !list_empty(
+			&sched->groups.runnable[PANTHOR_CSG_PRIORITY_RT]);
+
+		if (full_tick || rt_groups_waiting) {
+			/* We allow preemption in this case, but we must
+			 * ensure we are fully out of protected mode first.
+			 * We rely on the GLB_PROTM_EXIT (or error recovery)
+			 * to get a new tick.
+			 */
+			if (panthor_fw_protm_exit(ptdev, 500))
+				panthor_device_schedule_reset(ptdev);
+		}
+
+		goto out_unlock;
+	}
+
 	tick_ctx_init(sched, &ctx);
 	if (ctx.csg_upd_failed_mask)
 		goto out_cleanup_ctx;
@@ -2631,13 +2917,32 @@ static void tick_work(struct work_struct *work)
 	}
 
 	/* If we have free CSG slots left, pick idle groups */
-	for (prio = PANTHOR_CSG_PRIORITY_COUNT - 1;
-	     prio >= 0 && !tick_ctx_is_full(sched, &ctx);
-	     prio--) {
-		/* Check the old_group queue first to avoid reprogramming the slots */
-		tick_ctx_pick_groups_from_list(sched, &ctx, &ctx.old_groups[prio], false, true);
-		tick_ctx_pick_groups_from_list(sched, &ctx, &sched->groups.idle[prio],
-					       false, false);
+	if (ctx.protm_group) {
+		/* Pick only idle groups with equal or lower priority than the
+		 * group triggering protected mode. Do not bother picking
+		 * unscheduled idle groups.
+		 */
+		for (prio = ctx.protm_group->priority;
+		     prio >= 0 && !tick_ctx_is_full(sched, &ctx); prio--)
+			tick_ctx_pick_groups_from_list(sched, &ctx,
+						       &ctx.old_groups[prio],
+						       false, true);
+	} else {
+		/* No switch to protected, just pick any idle group according
+		 * to priority
+		 */
+		for (prio = PANTHOR_CSG_PRIORITY_COUNT - 1;
+		     prio >= 0 && !tick_ctx_is_full(sched, &ctx); prio--) {
+			/* Check the old_group queue first to avoid
+			 * reprogramming the slots
+			 */
+			tick_ctx_pick_groups_from_list(sched, &ctx,
+						       &ctx.old_groups[prio],
+						       false, true);
+			tick_ctx_pick_groups_from_list(sched, &ctx,
+						       &sched->groups.idle[prio],
+						       false, false);
+		}
 	}
 
 	tick_ctx_apply(sched, &ctx);
@@ -3064,6 +3369,8 @@ void panthor_sched_pre_reset(struct panthor_device *ptdev)
 	cancel_work_sync(&sched->sync_upd_work);
 	cancel_delayed_work_sync(&sched->tick_work);
 
+	handle_protm_fault(ptdev);
+
 	panthor_sched_suspend(ptdev);
 
 	/* Stop all groups that might still accept jobs, so we don't get passed
@@ -3089,6 +3396,11 @@ void panthor_sched_post_reset(struct panthor_device *ptdev, bool reset_failed)
 
 	mutex_lock(&sched->reset.lock);
 
+	if (sched->protm.active_group) {
+		group_put(sched->protm.active_group);
+		sched->protm.active_group = NULL;
+	}
+
 	list_for_each_entry_safe(group, group_tmp, &sched->reset.stopped_groups, run_node) {
 		/* Consider all previously running group as terminated if the
 		 * reset failed.
diff --git a/drivers/gpu/drm/panthor/panthor_sched.h b/drivers/gpu/drm/panthor/panthor_sched.h
index be7e1c8b4f563..1082c4d977c5e 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.h
+++ b/drivers/gpu/drm/panthor/panthor_sched.h
@@ -52,4 +52,8 @@ void panthor_sched_report_fw_events(struct panthor_device *ptdev, u32 events);
 
 void panthor_fdinfo_gather_group_samples(struct drm_file *file);
 
+int panthor_sched_protm_block(struct panthor_device *ptdev);
+int panthor_sched_protm_try_block(struct panthor_device *ptdev);
+void panthor_sched_protm_unblock(struct panthor_device *ptdev);
+
 #endif
-- 
2.43.0

