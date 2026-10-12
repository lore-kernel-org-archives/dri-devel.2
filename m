Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69672CA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 13:00:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3CB910F0B3;
	Mon, 12 Oct 2026 13:00:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 583A310F0C7
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:00:09 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD9C31655;
 Mon, 12 Oct 2026 06:00:05 -0700 (PDT)
Received: from e120398-lin.trondheim.arm.com (e120398-lin.trondheim.arm.com
 [10.42.46.160])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D9BE3F66F;
 Mon, 12 Oct 2026 06:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1791810009; bh=Wla+/mAFE8PQAvhkn1IfIMOcXAwLfJnJmGIZiDPGe1g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=On4vpm7jaqWKmMCN1U9aUBYv6bf4gJa2eHTNmC5N8kBJ9mBydRKnkAk2WawQKZZRv
 gXJkCTxf/fyML3fMU8j+Ev1cKZQu8zYjTVPwOyOOOKphEwj//CI1yZp+DP0i81I/hM
 BZrBf6nzNmBYdzhQrYiLsxPNzgbMPcpiZedPYum4=
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
Subject: [PATCH v4 05/12] drm/panthor: Add support for entering and exiting
 protected mode
Date: Mon, 12 Oct 2026 14:59:33 +0200
Message-ID: <20261012125940.3291951-6-ketil.johnsen@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012125940.3291951-1-ketil.johnsen@arm.com>
References: <20261012125940.3291951-1-ketil.johnsen@arm.com>
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

Note that the submission of protected mode jobs are done
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

v4:
- Do not pick any more groups if first group requests protm.
  Prevous versions allowed lower pri groups to stay on slot.
- Moved the rwsem for protm sync into scheduler.
- Added protm exit handling to start of scheduler tick.
- Scheduler will notify MMU code when it enters and exits protm.
- When in protected mode, MMU code will do "delayed updates" of VMs
  which are not "running". This avoids unnecessary preemptions and
  blocking during unrelated VM_BIND ops.
- Page table updates to FW VM and currently running protm VM can
  not proceed before protm is exited (preempted).
- Ensure ticking during protm (so we can evaluate preemption).
- Added special protm preempt code with preempt_protm_group().
- Poll for protm enter and exit without FW event wait queue.
  Protm enter simply use read_poll_timeout().
  Protm exit use a custom loop as this needs to be interruptible (long waits).
- Reversed check order in panthor_gpu_protm_fault_pending()
- Do not print error message in panthor_fw_protm_exit(), leave that to caller
  since it can some times be expected.
- Reintroduce disabling of GPU_IRQ_PROTM_FAULT while handling them.
- Reset protm_fault and re-enable GPU_IRQ_PROTM_FAULT after FW have re-started.
- Tweaks to tick_ctx_handle_protm_group(), take events_lock and ack everything!
- Use "protm block" with DEFINE_GUARD helpers (MMU code).
- Minor spelling/wording and naming changes.

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
 drivers/gpu/drm/panthor/panthor_device.h |   8 +
 drivers/gpu/drm/panthor/panthor_fw.c     |  94 ++++-
 drivers/gpu/drm/panthor/panthor_fw.h     |   4 +
 drivers/gpu/drm/panthor/panthor_gpu.c    |  49 ++-
 drivers/gpu/drm/panthor/panthor_gpu.h    |   4 +
 drivers/gpu/drm/panthor/panthor_mmu.c    | 283 +++++++++-----
 drivers/gpu/drm/panthor/panthor_mmu.h    |   6 +
 drivers/gpu/drm/panthor/panthor_sched.c  | 467 +++++++++++++++++++++--
 drivers/gpu/drm/panthor/panthor_sched.h  |   5 +
 9 files changed, 806 insertions(+), 114 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index b55a3f9edd414..4362c55bcd7e4 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -336,6 +336,14 @@ struct panthor_device {
 		struct list_head node;
 	} gems;
 #endif
+	/** @protm: Protected mode related data. */
+	struct {
+		/** @protm_enter_count: Number of times we entered protm. */
+		atomic64_t protm_enter_count;
+
+		/** @protm_exit_count: Number of times we exited protm. */
+		atomic64_t protm_exit_count;
+	} protm;
 };
 
 struct panthor_gpu_usage {
diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index 5f9f7a92c56a8..e639ffeac7a32 100644
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
@@ -1476,6 +1481,93 @@ static void panthor_fw_ping_work(struct work_struct *work)
 	}
 }
 
+static bool wait_protm_enter(struct panthor_device *ptdev,
+			     s64 protm_session_seqno)
+{
+	return (panthor_gpu_status(ptdev) & GPU_STATUS_PROTM_ACTIVE) ||
+	       (atomic64_read(&ptdev->protm.protm_exit_count) >=
+		protm_session_seqno);
+}
+
+int panthor_fw_protm_enter(struct panthor_device *ptdev)
+{
+	struct panthor_fw_global_iface *glb_iface =
+		panthor_fw_get_glb_iface(ptdev);
+	u32 acked;
+	int ret;
+	long long enter_count;
+	bool status;
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
+	ret = read_poll_timeout(wait_protm_enter, status, status, 100, 500000,
+				false, ptdev, enter_count);
+
+	if (ret) {
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
+	unsigned long deadline = jiffies + msecs_to_jiffies(timeout_ms);
+
+	do {
+		if (!(panthor_gpu_status(ptdev) & GPU_STATUS_PROTM_ACTIVE))
+			return 0;
+
+		if (signal_pending(current))
+			return -ERESTARTSYS;
+
+		usleep_range_state(100, 200, TASK_INTERRUPTIBLE);
+	} while (!time_after_eq(jiffies, deadline));
+
+	if (!(panthor_gpu_status(ptdev) & GPU_STATUS_PROTM_ACTIVE))
+		return 0;
+
+	return -ETIMEDOUT;
+}
+
+int panthor_fw_protm_exit(struct panthor_device *ptdev, u32 timeout_ms)
+{
+	struct panthor_fw_global_iface *glb_iface =
+		panthor_fw_get_glb_iface(ptdev);
+
+	/* Send PING request to force an exit */
+	panthor_fw_toggle_reqs(glb_iface, req, ack, GLB_PING);
+	panthor_fw_ring_doorbell(ptdev, CSF_GLB_DOORBELL_ID);
+
+	return panthor_fw_protm_exit_wait(ptdev, timeout_ms);
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
index a383b04f101ed..319282a22f669 100644
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
@@ -91,6 +94,35 @@ static void panthor_gpu_irq_handler(struct panthor_irq *pirq, u32 status)
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
+		panthor_irq_disable_events(&ptdev->gpu->irq,
+					   GPU_IRQ_PROTM_FAULT);
+		drm_warn(&ptdev->base, "GPU Fault in protected mode");
+		panthor_device_schedule_reset(ptdev);
+	}
+
 	gpu_write(gpu->irq.iomem, INT_CLEAR, status);
 
 	if (tracepoint_enabled(gpu_power_status) && (status & GPU_POWER_INTERRUPTS_MASK))
@@ -107,8 +139,6 @@ static void panthor_gpu_irq_handler(struct panthor_irq *pirq, u32 status)
 			 fault_status, panthor_exception_name(ptdev, fault_status & 0xFF),
 			 address);
 	}
-	if (status & GPU_IRQ_PROTM_FAULT)
-		drm_warn(&ptdev->base, "GPU Fault in protected mode\n");
 
 	spin_lock(&ptdev->gpu->reqs_lock);
 	if (status & ptdev->gpu->pending_reqs) {
@@ -123,6 +153,13 @@ static irqreturn_t panthor_gpu_irq_threaded_handler(int irq, void *data)
 	return panthor_irq_default_threaded_handler(data, panthor_gpu_irq_handler);
 }
 
+bool panthor_gpu_protm_fault_pending(struct panthor_device *ptdev)
+{
+	return gpu_read(ptdev->gpu->irq.iomem, INT_RAWSTAT) &
+		       GPU_IRQ_PROTM_FAULT ||
+	       atomic_read(&ptdev->gpu->protm_fault);
+}
+
 /**
  * panthor_gpu_unplug() - Called when the GPU is unplugged.
  * @ptdev: Device to unplug.
@@ -430,6 +467,9 @@ int panthor_gpu_soft_reset(struct panthor_device *ptdev)
 		return -ETIMEDOUT;
 	}
 
+	atomic_set(&ptdev->gpu->protm_fault, 0);
+	panthor_irq_enable_events(&ptdev->gpu->irq, GPU_IRQ_PROTM_FAULT);
+
 	scoped_guard(spinlock, &ptdev->gpu->reqs_lock) {
 		ptdev->gpu->pending_reqs = 0;
 	}
@@ -508,3 +548,8 @@ int panthor_gpu_coherency_init(struct panthor_device *ptdev)
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
index 3e5f20768d545..38e9986416dd9 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -77,6 +77,12 @@ struct panthor_mmu {
 		/** @as.faulty_mask: Bitmask encoding the faulty slots. */
 		unsigned long faulty_mask;
 
+		/** @as.delay_update_mask: Bitmask encoding slots which must use delayed updates */
+		u32 delay_update_mask;
+
+		/** @as.delayed_update_mask: Bitmask encoding slots with pending delayed updates */
+		u32 delayed_update_mask;
+
 		/** @as.slots: VMs currently bound to the AS slots. */
 		struct panthor_as_slot slots[MAX_AS_SLOTS];
 
@@ -450,6 +456,26 @@ struct panthor_vm_bind_job {
  */
 static struct kmem_cache *pt_cache;
 
+static bool protm_block_timeout(struct panthor_vm *vm)
+{
+	return panthor_sched_protm_block_timeout(vm->ptdev, vm);
+}
+
+static bool protm_try_block(struct panthor_vm *vm)
+{
+	return panthor_sched_protm_try_block(vm->ptdev);
+}
+
+static void protm_unblock(struct panthor_vm *vm)
+{
+	panthor_sched_protm_unblock(vm->ptdev);
+}
+
+/* Only cond variants can be used, hence the use of WARN_ON() here */
+DEFINE_GUARD(protm_block, struct panthor_vm*, WARN_ON(_T), protm_unblock(_T));
+DEFINE_GUARD_COND(protm_block, _timeout, protm_block_timeout(_T));
+DEFINE_GUARD_COND(protm_block, _try, protm_try_block(_T));
+
 /**
  * alloc_pt() - Custom page table allocator
  * @cookie: Cookie passed at page table allocation time.
@@ -1809,12 +1835,17 @@ static int panthor_vm_lock_region(struct panthor_vm *vm, u64 start, u64 size)
 
 	mutex_lock(&ptdev->mmu->as.slots_lock);
 	if (vm->as.id >= 0 && size) {
-		/* Lock the region that needs to be updated */
-		gpu_write64(ptdev->mmu->iomem, AS_LOCKADDR(vm->as.id),
-			    pack_region_range(ptdev, &start, &size));
+		if (ptdev->mmu->as.delay_update_mask & BIT(vm->as.id)) {
+			ptdev->mmu->as.delayed_update_mask |= BIT(vm->as.id);
+		} else {
+			/* Lock the region that needs to be updated */
+			gpu_write64(ptdev->mmu->iomem, AS_LOCKADDR(vm->as.id),
+				    pack_region_range(ptdev, &start, &size));
 
-		/* If the lock succeeded, update the locked_region info. */
-		ret = as_send_cmd_and_wait(ptdev, vm->as.id, AS_COMMAND_LOCK);
+			/* If the lock succeeded, update the locked_region info. */
+			ret = as_send_cmd_and_wait(ptdev, vm->as.id,
+						   AS_COMMAND_LOCK);
+		}
 	}
 
 	if (!ret) {
@@ -1832,25 +1863,31 @@ static void panthor_vm_unlock_region(struct panthor_vm *vm)
 
 	mutex_lock(&ptdev->mmu->as.slots_lock);
 	if (vm->as.id >= 0) {
-		int ret;
+		if (ptdev->mmu->as.delay_update_mask & BIT(vm->as.id)) {
+			ptdev->mmu->as.delayed_update_mask |= BIT(vm->as.id);
+		} else {
+			int ret;
 
-		/* flush+invalidate RW caches and invalidate RO ones.
-		 * TODO: See if we can use FLUSH_PA_RANGE when the physical
-		 * range is narrow enough and the HW supports it.
-		 */
-		ret = panthor_gpu_flush_caches(ptdev, CACHE_CLEAN | CACHE_INV,
-					       CACHE_CLEAN | CACHE_INV,
-					       CACHE_INV);
+			/* flush+invalidate RW caches and invalidate RO ones.
+			 * TODO: See if we can use FLUSH_PA_RANGE when the physical
+			 * range is narrow enough and the HW supports it.
+			 */
+			ret = panthor_gpu_flush_caches(ptdev,
+						       CACHE_CLEAN | CACHE_INV,
+						       CACHE_CLEAN | CACHE_INV,
+						       CACHE_INV);
 
-		/* Unlock the region if the flush is effective. */
-		if (!ret)
-			ret = as_send_cmd_and_wait(ptdev, vm->as.id, AS_COMMAND_UNLOCK);
+			/* Unlock the region if the flush is effective. */
+			if (!ret)
+				ret = as_send_cmd_and_wait(ptdev, vm->as.id,
+							   AS_COMMAND_UNLOCK);
 
-		/* If we fail to flush or unlock the region, schedule a GPU reset
-		 * to unblock the situation.
-		 */
-		if (ret)
-			panthor_device_schedule_reset(ptdev);
+			/* If we fail to flush or unlock the region, schedule a
+			 * GPU reset to unblock the situation.
+			 */
+			if (ret)
+				panthor_device_schedule_reset(ptdev);
+		}
 	}
 	vm->locked_region.start = 0;
 	vm->locked_region.size = 0;
@@ -2014,6 +2051,8 @@ void panthor_mmu_post_reset(struct panthor_device *ptdev)
 	 */
 	ptdev->mmu->as.alloc_mask = 0;
 	ptdev->mmu->as.faulty_mask = 0;
+	ptdev->mmu->as.delay_update_mask = 0;
+	ptdev->mmu->as.delayed_update_mask = 0;
 
 	for (u32 i = 0; i < ARRAY_SIZE(ptdev->mmu->as.slots); i++) {
 		struct panthor_vm *vm = ptdev->mmu->as.slots[i].vm;
@@ -2493,6 +2532,52 @@ void panthor_vm_update_bo_reclaim_lru_locked(struct panthor_gem_object *bo)
 	}
 }
 
+static int evict_vm_bo_locked(struct drm_gpuvm_bo *vm_bo)
+{
+	struct drm_gpuva *va;
+
+	/* It can be that the vm_bo was already evicted but a new
+	 * mapping pointing to this BO got created in the meantime,
+	 * thus turning the vm_bo in partially evicted state. In that case
+	 * we don't call drm_gpuvm_bo_evict() again because this would
+	 * mess up with the internal gpuvm lists, but we do walk the
+	 * VAs on this vm_bo to make sure the non-evicted ones are
+	 * torn down.
+	 */
+	if (!vm_bo->evicted)
+		drm_gpuvm_bo_evict(vm_bo, true);
+
+	drm_gpuvm_bo_for_each_va(va, vm_bo) {
+		struct panthor_vm *vm =
+			container_of(vm_bo->vm, struct panthor_vm, base);
+		struct panthor_vma *vma =
+			container_of(va, struct panthor_vma, base);
+		int ret;
+
+		if (vma->evicted)
+			continue;
+
+		/* If something fail in the middle of a VM_BO eviction, the
+		 * VM_BO is considered fully evicted, but some of its VMAs might
+		 * still be active. That's okay because the pages won't be
+		 * released if this function returns an error.
+		 *
+		 * On the next job targeting this VM, the partially evicted
+		 * VM_BO will be validated, causing all its evicted VMAs to be
+		 * repopulated before the job runs. So no GPU fault expected.
+		 */
+		ret = panthor_vm_lock_region(vm, va->va.addr, va->va.range);
+		if (ret)
+			return ret;
+
+		panthor_vm_unmap_pages(vm, va->va.addr, va->va.range);
+		panthor_vm_unlock_region(vm);
+		vma->evicted = true;
+	}
+
+	return 0;
+}
+
 int panthor_vm_evict_bo_mappings_locked(struct panthor_gem_object *bo)
 {
 	struct drm_gpuvm_bo *vm_bo;
@@ -2500,48 +2585,13 @@ int panthor_vm_evict_bo_mappings_locked(struct panthor_gem_object *bo)
 
 	drm_gem_for_each_gpuvm_bo(vm_bo, &bo->base) {
 		struct panthor_vm *vm = container_of(vm_bo->vm, struct panthor_vm, base);
-		struct drm_gpuva *va;
-
-		if (!mutex_trylock(&vm->op_lock))
-			return -EDEADLK;
-
-		/* It can be that the vm_bo was already evicted but a new
-		 * mapping pointing to this BO got created in the meantime,
-		 * thus turning the vm_bo in partially evicted state. In that case
-		 * we don't call drm_gpuvm_bo_evict() again because this would
-		 * mess up with the internal gpuvm lists, but we do walk the
-		 * VAs on this vm_bo to make sure the non-evicted ones are
-		 * torn down.
-		 */
-		if (!vm_bo->evicted)
-			drm_gpuvm_bo_evict(vm_bo, true);
-
-		drm_gpuvm_bo_for_each_va(va, vm_bo) {
-			struct panthor_vma *vma = container_of(va, struct panthor_vma, base);
-
-			if (vma->evicted)
-				continue;
-
-			/* If something fail in the middle of a VM_BO eviction, the VM_BO
-			 * is considered fully evicted, but some of its VMAs might still be
-			 * active. That's okay because the pages won't be released if this
-			 * function returns an error.
-			 *
-			 * On the next job targeting this VM, the partially evicted VM_BO
-			 * will be validated, causing all its evicted VMAs to be repopulated
-			 * before the job runs. So no GPU fault expected.
-			 */
-			ret = panthor_vm_lock_region(vm, va->va.addr, va->va.range);
-			if (ret)
-				break;
 
-			panthor_vm_unmap_pages(vm, va->va.addr, va->va.range);
-			panthor_vm_unlock_region(vm);
-			vma->evicted = true;
+		scoped_cond_guard(mutex_try, ret = -EDEADLK, &vm->op_lock) {
+			scoped_cond_guard(protm_block_try, ret = -EDEADLK, vm) {
+				ret = evict_vm_bo_locked(vm_bo);
+			}
 		}
 
-		mutex_unlock(&vm->op_lock);
-
 		if (ret)
 			break;
 	}
@@ -2611,8 +2661,12 @@ static int remap_evicted_vma(struct drm_gpuvm_bo *vm_bo,
 		break;
 	}
 
-	if (found) {
+	if (!found)
+		goto out_unlock;
+
+	scoped_cond_guard(protm_block_timeout, ret = -ETIMEDOUT, vm) {
 		vm->op_ctx = op_ctx;
+
 		ret = panthor_vm_lock_region(vm, evicted_vma->base.va.addr,
 					     evicted_vma->base.va.range);
 		if (!ret) {
@@ -2636,6 +2690,7 @@ static int remap_evicted_vma(struct drm_gpuvm_bo *vm_bo,
 		vm->op_ctx = NULL;
 	}
 
+out_unlock:
 	mutex_unlock(&vm->op_lock);
 
 out_cleanup:
@@ -2726,39 +2781,42 @@ panthor_vm_exec_op(struct panthor_vm *vm, struct panthor_vm_op_ctx *op,
 	mutex_lock(&vm->op_lock);
 	vm->op_ctx = op;
 
-	ret = panthor_vm_lock_region(vm, op->va.addr, op->va.range);
-	if (ret)
-		goto out;
-
-	switch (op_type) {
-	case DRM_PANTHOR_VM_BIND_OP_TYPE_MAP: {
-		const struct drm_gpuvm_map_req map_req = {
-			.map.va.addr = op->va.addr,
-			.map.va.range = op->va.range,
-			.map.gem.obj = op->map.vm_bo->obj,
-			.map.gem.offset = op->map.bo_offset,
-		};
-
-		if (vm->unusable) {
-			ret = -EINVAL;
+	scoped_cond_guard(protm_block_timeout, ret = -ETIMEDOUT, vm) {
+		ret = panthor_vm_lock_region(vm, op->va.addr, op->va.range);
+		if (ret)
+			goto out;
+
+		switch (op_type) {
+		case DRM_PANTHOR_VM_BIND_OP_TYPE_MAP: {
+			const struct drm_gpuvm_map_req map_req = {
+				.map.va.addr = op->va.addr,
+				.map.va.range = op->va.range,
+				.map.gem.obj = op->map.vm_bo->obj,
+				.map.gem.offset = op->map.bo_offset,
+			};
+
+			if (vm->unusable) {
+				ret = -EINVAL;
+				break;
+			}
+
+			ret = drm_gpuvm_sm_map(&vm->base, vm, &map_req);
 			break;
 		}
 
-		ret = drm_gpuvm_sm_map(&vm->base, vm, &map_req);
-		break;
-	}
+		case DRM_PANTHOR_VM_BIND_OP_TYPE_UNMAP:
+			ret = drm_gpuvm_sm_unmap(&vm->base, vm, op->va.addr,
+						 op->va.range);
+			break;
 
-	case DRM_PANTHOR_VM_BIND_OP_TYPE_UNMAP:
-		ret = drm_gpuvm_sm_unmap(&vm->base, vm, op->va.addr, op->va.range);
-		break;
+		default:
+			ret = -EINVAL;
+			break;
+		}
 
-	default:
-		ret = -EINVAL;
-		break;
+		panthor_vm_unlock_region(vm);
 	}
 
-	panthor_vm_unlock_region(vm);
-
 out:
 	if (ret && flag_vm_unusable_on_failure)
 		panthor_vm_declare_unusable(vm);
@@ -3517,3 +3575,54 @@ void panthor_mmu_pt_cache_fini(void)
 {
 	kmem_cache_destroy(pt_cache);
 }
+
+bool panthor_vm_for_mcu(struct panthor_vm *vm)
+{
+	return vm->for_mcu;
+}
+
+void panthor_mmu_protm_enter_event(struct panthor_device *ptdev,
+				   struct panthor_vm *vm)
+{
+	/* Scheduler is entering protm mode with specified VM (AS).
+	 * Scheduler now promises it will not run any work using any other VM
+	 * than the provided vm and the FW VM until further notice.
+	 * This means we can do page table updates for all the other VMs, even
+	 * in protected mode, as long as we do the necessary cache operations
+	 * before normal scheduling is resumed. This is done on protm exit,
+	 * see panthor_mmu_protm_exit_event().
+	 */
+	if (drm_WARN_ON(&ptdev->base, !vm))
+		return;
+
+	if (drm_WARN_ON(&ptdev->base, vm->as.id < 0))
+		return;
+
+	guard(mutex)(&ptdev->mmu->as.slots_lock);
+
+	drm_WARN_ON(&ptdev->base, ptdev->mmu->as.delay_update_mask);
+
+	ptdev->mmu->as.delay_update_mask = ~(BIT(0) | BIT(vm->as.id));
+}
+
+void panthor_mmu_protm_exit_event(struct panthor_device *ptdev)
+{
+	/* We left protected mode and scheduler is about to resume normal
+	 * scheduling. Do the necessary cache operation so any page table
+	 * updates we might have done during protm is correctly visible
+	 * to the GPU.
+	 */
+	int ret;
+
+	guard(mutex)(&ptdev->mmu->as.slots_lock);
+
+	ptdev->mmu->as.delay_update_mask = 0;
+
+	if (!ptdev->mmu->as.delayed_update_mask)
+		return;
+
+	ret = panthor_gpu_flush_caches(ptdev, CACHE_CLEAN | CACHE_INV,
+				       CACHE_CLEAN | CACHE_INV, CACHE_INV);
+	if (ret)
+		panthor_device_schedule_reset(ptdev);
+}
diff --git a/drivers/gpu/drm/panthor/panthor_mmu.h b/drivers/gpu/drm/panthor/panthor_mmu.h
index e262fe2303f6c..9f9d690953ead 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.h
+++ b/drivers/gpu/drm/panthor/panthor_mmu.h
@@ -106,6 +106,12 @@ void panthor_vm_update_resvs(struct panthor_vm *vm, struct drm_exec *exec,
 int panthor_mmu_pt_cache_init(void);
 void panthor_mmu_pt_cache_fini(void);
 
+bool panthor_vm_for_mcu(struct panthor_vm *vm);
+
+void panthor_mmu_protm_enter_event(struct panthor_device *ptdev,
+				   struct panthor_vm *vm);
+void panthor_mmu_protm_exit_event(struct panthor_device *ptdev);
+
 #ifdef CONFIG_DEBUG_FS
 void panthor_mmu_debugfs_init(struct drm_minor *minor);
 #endif
diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index db801705f0d27..fff805fd794a5 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -307,6 +307,50 @@ struct panthor_scheduler {
 		 */
 		struct list_head stopped_groups;
 	} reset;
+
+	/** @protm: Protected mode related fields. */
+	struct {
+		/**
+		 * @lock: Lock for the protected mode state (active_group)
+		 *
+		 * This lock is used to manage current protected mode state,
+		 * as represented by the member active_group.
+		 *
+		 * Knowing this state is critical for MMU operations, because:
+		 * - The MMU will silently ignore commands issued when the GPU
+		 *   is in protected mode.
+		 * - There can not be any pending MMU LOCKS in place when
+		 *   entering protected mode.
+		 *
+		 * Code which interacts with the MMU, typically by calling
+		 * panthor_vm_lock_region(), should therefore ensure the
+		 * scheduler is not in and will not enter protected mode first.
+		 * This is done by calling either
+		 * - panthor_sched_protm_block_timeout(), or
+		 * - panthor_sched_protm_try_block()
+		 *
+		 * Once the MMU operations have completed, call
+		 * panthor_sched_protm_unblock() to tell the scheduler that
+		 * it is safe to enter protected mode again.
+		 */
+		struct rw_semaphore lock;
+
+		/**
+		 * @active_group: The active protected group.
+		 *
+		 * We only allow one protected group to run at the same time,
+		 * as it makes it easier to handle faults in protected mode.
+		 *
+		 * If the active_group member is set, then the scheduler
+		 * believes the GPU is in protected mode. If not set, then the
+		 * GPU is for sure not in normal mode.
+
+		 * Changes are done with both panthor_scheduler::lock and
+		 * panthor_scheduler::protm::lock held as writer.
+		 * This means you only need to hold one of these locks for read.
+		 */
+		struct panthor_group *active_group;
+	} protm;
 };
 
 /**
@@ -571,6 +615,16 @@ struct panthor_group {
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
 
@@ -1154,8 +1208,9 @@ cs_slot_reset_locked(struct panthor_device *ptdev, u32 csg_id, u32 cs_id)
 	lockdep_assert_held(&ptdev->scheduler->lock);
 
 	panthor_fw_update_reqs(cs_iface, req,
-			       CS_STATE_STOP,
-			       CS_STATE_MASK);
+			       CS_STATE_STOP | (cs_iface->output->ack &
+						CS_PROTM_PENDING),
+			       CS_STATE_MASK | CS_PROTM_PENDING);
 
 	queue_suspend_timeout(queue);
 
@@ -1394,6 +1449,27 @@ csg_slot_prog_locked(struct panthor_device *ptdev, u32 csg_id, u32 priority)
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
@@ -1642,6 +1718,10 @@ static bool cs_slot_process_irq_locked(struct panthor_device *ptdev,
 	if (events & CS_TILER_OOM)
 		cs_slot_process_tiler_oom_event_locked(ptdev, csg_id, cs_id);
 
+	if (events & CS_PROTM_PENDING)
+		cs_slot_process_protm_pending_event_locked(ptdev, csg_id,
+							   cs_id);
+
 	/* We don't acknowledge the TILER_OOM event since its handling is
 	 * deferred to a separate work.
 	 */
@@ -1856,6 +1936,30 @@ static void sched_process_idle_event_locked(struct panthor_device *ptdev)
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
+	sched_queue_delayed_work(sched, tick, 0);
+}
+
 /**
  * sched_process_global_irq_locked() - Process the scheduling part of a global IRQ
  * @ptdev: Device.
@@ -1871,6 +1975,9 @@ static void sched_process_global_irq_locked(struct panthor_device *ptdev)
 	ack = READ_ONCE(glb_iface->output->ack);
 	evts = (req ^ ack) & GLB_EVT_MASK;
 
+	if (evts & GLB_PROTM_EXIT)
+		sched_process_protm_exit_event_locked(ptdev);
+
 	if (evts & GLB_IDLE)
 		sched_process_idle_event_locked(ptdev);
 }
@@ -1882,22 +1989,22 @@ static void sched_process_global_irq_locked(struct panthor_device *ptdev)
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
@@ -1983,6 +2090,69 @@ group_unbind_locked(struct panthor_group *group)
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
@@ -2012,6 +2182,12 @@ static void csgs_upd_ctx_init(struct panthor_csg_slots_upd_ctx *ctx)
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
@@ -2022,7 +2198,8 @@ static void csgs_upd_ctx_queue_reqs(struct panthor_device *ptdev,
 
 	ctx->requests[csg_id].value = (ctx->requests[csg_id].value & ~mask) | (value & mask);
 	ctx->requests[csg_id].mask |= mask;
-	ctx->update_mask |= BIT(csg_id);
+
+	csgs_upd_ctx_ring_doorbell(ctx, csg_id);
 }
 
 static int csgs_upd_ctx_apply_locked(struct panthor_device *ptdev,
@@ -2039,8 +2216,12 @@ static int csgs_upd_ctx_apply_locked(struct panthor_device *ptdev,
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
@@ -2057,6 +2238,9 @@ static int csgs_upd_ctx_apply_locked(struct panthor_device *ptdev,
 		int ret;
 
 		update_slots &= ~BIT(csg_id);
+		if (!req_mask)
+			continue;
+
 		csg_iface = panthor_fw_get_csg_iface(ptdev, csg_id);
 
 		ret = panthor_fw_csg_wait_acks(ptdev, csg_id, req_mask, &acked, 100);
@@ -2093,13 +2277,14 @@ struct panthor_sched_tick_ctx {
 	bool immediate_tick;
 	bool stop_tick;
 	u32 csg_upd_failed_mask;
+	struct panthor_group *protm_group;
 };
 
 static bool
 tick_ctx_is_full(const struct panthor_scheduler *sched,
 		 const struct panthor_sched_tick_ctx *ctx)
 {
-	return ctx->group_count == sched->csg_slot_count;
+	return (ctx->group_count == sched->csg_slot_count) || ctx->protm_group;
 }
 
 static void
@@ -2134,6 +2319,13 @@ tick_ctx_pick_groups_from_list(const struct panthor_scheduler *sched,
 		if (!owned_by_tick_ctx)
 			group_get(group);
 
+		/* Only the first pick is allowed to request switch to protm */
+		if (ctx->group_count == 0 &&
+		    atomic_read(&group->protm_pending_queues)) {
+			ctx->protm_group = group;
+			ctx->stop_tick = false;
+		}
+
 		ctx->group_count++;
 
 		/* If we have more than one active group with the same priority,
@@ -2292,6 +2484,79 @@ static void group_term_work(struct work_struct *work)
 	group_put(group);
 }
 
+bool panthor_sched_protm_block_timeout(struct panthor_device *ptdev,
+				      struct panthor_vm *vm)
+{
+	struct panthor_scheduler *sched = ptdev->scheduler;
+	int ret;
+
+	if (!sched)
+		return true;
+
+	down_read(&sched->protm.lock);
+
+	if (!sched->protm.active_group)
+		return true; /* All good, we are in normal mode */
+
+	/* We will only exit protected mode for the passed vm and the MCU VM.
+	 * Other VMs have no active CSG work, so MMU updates can proceed,
+	 * although with special caution (delayed updates)!
+	 */
+	if (sched->protm.active_group->vm != vm && !panthor_vm_for_mcu(vm))
+		return true; /* Specified VM can proceed, with caution. */
+
+	/* Give GPU a chance to finish ongoing protm work by itself */
+	ret = panthor_fw_protm_exit_wait(ptdev, 5);
+	if (!ret)
+		return true; /* All good, we are back to normal mode */
+
+	/* We do not want this function to fail, because that can lead to
+	 * innocent processes failing. That is why we wait up to 2x the job
+	 * timeout for GPU to exit protm here. This shall cover the worst case
+	 * where protm work hangs and we must rely on job timeout to recover.
+	 */
+	ret = panthor_fw_protm_exit(ptdev, JOB_TIMEOUT_MS << 1);
+	if (ret)
+		up_read(&sched->protm.lock);
+
+	return ret ? false : true;
+}
+
+bool panthor_sched_protm_try_block(struct panthor_device *ptdev)
+{
+	struct panthor_scheduler *sched = ptdev->scheduler;
+	int ret;
+
+	if (!sched)
+		return false;
+
+	ret = down_read_trylock(&sched->protm.lock);
+	if (ret) {
+		/* Unlike panthor_sched_protm_block_timeout(), we don't bother
+		 * checking against a particular vm. It is not that important
+		 * to succeed in this use case.
+		 */
+		if (sched->protm.active_group) {
+			up_read(&sched->protm.lock);
+			return false;
+		}
+
+		return true;
+	}
+
+	return false;
+}
+
+void panthor_sched_protm_unblock(struct panthor_device *ptdev)
+{
+	struct panthor_scheduler *sched = ptdev->scheduler;
+
+	if (!sched)
+		return;
+
+	up_read(&sched->protm.lock);
+}
+
 static void
 tick_ctx_cleanup(struct panthor_scheduler *sched,
 		 struct panthor_sched_tick_ctx *ctx)
@@ -2419,6 +2684,41 @@ tick_ctx_schedule_group(struct panthor_scheduler *sched,
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
+
+	if (drm_WARN_ON(&ptdev->base, group->csg_id < 0))
+		return;
+
+	guard(spinlock)(&sched->events_lock);
+
+	for (q = 0; q < group->queue_count; q++) {
+		struct panthor_fw_cs_iface *cs_iface =
+			panthor_fw_get_cs_iface(ptdev, group->csg_id, q);
+
+		/* Ack any pending CS_PROTM_PENDING so it can run in protm */
+		if ((cs_iface->output->ack ^ cs_iface->input->req) &
+		    CS_PROTM_PENDING)
+			panthor_fw_update_reqs(cs_iface, req,
+					       cs_iface->output->ack,
+					       CS_PROTM_PENDING);
+	}
+
+	panthor_fw_toggle_reqs(csg_iface, doorbell_req, doorbell_ack,
+			       GENMASK(group->queue_count - 1, 0));
+
+	csgs_upd_ctx_ring_doorbell(upd_ctx, group->csg_id);
+
+	atomic_set(&group->protm_pending_queues, 0);
+}
+
 static void
 tick_ctx_apply(struct panthor_scheduler *sched, struct panthor_sched_tick_ctx *ctx)
 {
@@ -2488,6 +2788,9 @@ tick_ctx_apply(struct panthor_scheduler *sched, struct panthor_sched_tick_ctx *c
 		}
 	}
 
+	if (ctx->protm_group)
+		tick_ctx_handle_protm_group(sched, &upd_ctx, ctx->protm_group);
+
 	ret = csgs_upd_ctx_apply_locked(ptdev, &upd_ctx);
 	if (ret) {
 		panthor_device_schedule_reset(ptdev);
@@ -2495,6 +2798,24 @@ tick_ctx_apply(struct panthor_scheduler *sched, struct panthor_sched_tick_ctx *c
 		return;
 	}
 
+	if (ctx->protm_group) {
+		down_write(&sched->protm.lock);
+
+		sched->protm.active_group = ctx->protm_group;
+		group_get(sched->protm.active_group);
+
+		/* Tell MMU we are entering protm with this VM (AS) */
+		panthor_mmu_protm_enter_event(ptdev, ctx->protm_group->vm);
+
+		ret = panthor_fw_protm_enter(ptdev);
+		if (ret) {
+			panthor_device_schedule_reset(ptdev);
+			ctx->csg_upd_failed_mask = U32_MAX;
+		}
+
+		up_write(&sched->protm.lock);
+	}
+
 	for (prio = PANTHOR_CSG_PRIORITY_COUNT - 1; prio >= 0; prio--) {
 		list_for_each_entry_safe(group, tmp, &ctx->groups[prio], run_node) {
 			list_del_init(&group->run_node);
@@ -2531,12 +2852,12 @@ tick_ctx_apply(struct panthor_scheduler *sched, struct panthor_sched_tick_ctx *c
 }
 
 static u64
-tick_ctx_update_resched_target(struct panthor_scheduler *sched,
-			       const struct panthor_sched_tick_ctx *ctx)
+tick_update_resched_target(struct panthor_scheduler *sched,
+			   bool stop_tick)
 {
 	u64 resched_target;
 
-	if (ctx->stop_tick)
+	if (stop_tick)
 		goto no_tick;
 
 	resched_target = sched->last_tick + sched->tick_period;
@@ -2552,6 +2873,38 @@ tick_ctx_update_resched_target(struct panthor_scheduler *sched,
 	return U64_MAX;
 }
 
+static bool preempt_protm_group(struct panthor_group *group, bool full_tick)
+{
+	struct panthor_device *ptdev = group->ptdev;
+	struct panthor_scheduler *sched = ptdev->scheduler;
+	bool groups_waiting;
+
+	/* If the protm group can not run, then preempt! */
+	if (!group_can_run(group))
+		return true;
+
+	/* If we have RT groups waiting and we are not RT, then preempt! */
+	groups_waiting =
+		!list_empty(&sched->groups.runnable[PANTHOR_CSG_PRIORITY_RT]);
+	if (groups_waiting && group->priority < PANTHOR_CSG_PRIORITY_RT)
+		return true;
+
+	/* The below conditions for preempting are only valid for full ticks */
+	if (!full_tick)
+		return false;
+
+	for (int pri = PANTHOR_CSG_PRIORITY_RT - 1;
+	     pri >= sched->protm.active_group->priority; pri--) {
+		if (!list_empty(&sched->groups.runnable[pri])) {
+			groups_waiting = true;
+			break;
+		}
+	}
+
+	return groups_waiting;
+
+}
+
 static void tick_work(struct work_struct *work)
 {
 	struct panthor_scheduler *sched = container_of(work, struct panthor_scheduler,
@@ -2584,6 +2937,58 @@ static void tick_work(struct work_struct *work)
 	if (panthor_device_reset_is_pending(sched->ptdev))
 		goto out_unlock;
 
+	/* If we exited protm since last tick, then deal with that first */
+	if (sched->protm.active_group) {
+		bool protm = atomic64_read(&ptdev->protm.protm_exit_count) !=
+			     atomic64_read(&ptdev->protm.protm_enter_count);
+		if (!protm) {
+			down_write(&sched->protm.lock);
+
+			/* No longer in protected mode, clear active_group */
+			group_put(sched->protm.active_group);
+			sched->protm.active_group = NULL;
+
+			/* Allow MMU ops on all ASes again */
+			panthor_mmu_protm_exit_event(ptdev);
+
+			up_write(&sched->protm.lock);
+		}
+	}
+
+	if (sched->protm.active_group) {
+		/* A normal tick will issue CSG_STATUS_UPDATE requests in
+		 * tick_ctx_init(). If we do this while running in protm, then
+		 * the FW will preempt and exit protm in order to fullfill the
+		 * request. That is why we do a "SW only" check for preemption
+		 * in this case, so we avoid unnecessary preemption.
+		 */
+		if (preempt_protm_group(sched->protm.active_group, full_tick)) {
+			/* Ensure we are fully out of protected mode first.
+			 * We rely on the GLB_PROTM_EXIT (or error recovery)
+			 * to get a new tick.
+			 */
+			if (panthor_fw_protm_exit(ptdev, 500)) {
+				drm_warn(&ptdev->base,
+					 "Failed to preempt protm");
+				panthor_device_schedule_reset(ptdev);
+			}
+		} else {
+			sched->last_tick = now;
+
+			/* We can stop ticking if this was a full tick.
+			 * New work which can preempt this protm work will
+			 * generate new ticks.
+			 */
+			resched_delay =
+				tick_update_resched_target(sched, full_tick);
+			if (resched_delay != U64_MAX)
+				sched_queue_delayed_work(sched, tick,
+							 resched_delay);
+		}
+
+		goto out_unlock;
+	}
+
 	tick_ctx_init(sched, &ctx);
 	if (ctx.csg_upd_failed_mask)
 		goto out_cleanup_ctx;
@@ -2635,14 +3040,20 @@ static void tick_work(struct work_struct *work)
 		}
 	}
 
-	/* If we have free CSG slots left, pick idle groups */
-	for (prio = PANTHOR_CSG_PRIORITY_COUNT - 1;
-	     prio >= 0 && !tick_ctx_is_full(sched, &ctx);
-	     prio--) {
-		/* Check the old_group queue first to avoid reprogramming the slots */
-		tick_ctx_pick_groups_from_list(sched, &ctx, &ctx.old_groups[prio], false, true);
-		tick_ctx_pick_groups_from_list(sched, &ctx, &sched->groups.idle[prio],
-					       false, false);
+	/* No need to pick any more groups if we are going to run in protm */
+	if (!ctx.protm_group) {
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
@@ -2664,7 +3075,7 @@ static void tick_work(struct work_struct *work)
 	}
 
 	sched->last_tick = now;
-	resched_delay = tick_ctx_update_resched_target(sched, &ctx);
+	resched_delay = tick_update_resched_target(sched, ctx.stop_tick);
 	if (ctx.immediate_tick)
 		resched_delay = 0;
 
@@ -3069,6 +3480,8 @@ void panthor_sched_pre_reset(struct panthor_device *ptdev)
 	cancel_work_sync(&sched->sync_upd_work);
 	cancel_delayed_work_sync(&sched->tick_work);
 
+	handle_protm_fault(ptdev);
+
 	panthor_sched_suspend(ptdev);
 
 	/* Stop all groups that might still accept jobs, so we don't get passed
@@ -3094,6 +3507,11 @@ void panthor_sched_post_reset(struct panthor_device *ptdev, bool reset_failed)
 
 	mutex_lock(&sched->reset.lock);
 
+	if (sched->protm.active_group) {
+		group_put(sched->protm.active_group);
+		sched->protm.active_group = NULL;
+	}
+
 	list_for_each_entry_safe(group, group_tmp, &sched->reset.stopped_groups, run_node) {
 		/* Consider all previously running group as terminated if the
 		 * reset failed.
@@ -4170,6 +4588,7 @@ int panthor_sched_init(struct panthor_device *ptdev)
 	INIT_WORK(&sched->sync_upd_work, sync_upd_work);
 
 	spin_lock_init(&sched->events_lock);
+	init_rwsem(&sched->protm.lock);
 
 	ret = drmm_mutex_init(&ptdev->base, &sched->lock);
 	if (ret)
diff --git a/drivers/gpu/drm/panthor/panthor_sched.h b/drivers/gpu/drm/panthor/panthor_sched.h
index c509fcb5a0c9c..64d583de80c42 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.h
+++ b/drivers/gpu/drm/panthor/panthor_sched.h
@@ -53,6 +53,11 @@ void panthor_sched_report_fw_events(struct panthor_device *ptdev, u32 events);
 
 void panthor_fdinfo_gather_group_samples(struct drm_file *file);
 
+bool panthor_sched_protm_block_timeout(struct panthor_device *ptdev,
+				       struct panthor_vm *vm);
+bool panthor_sched_protm_try_block(struct panthor_device *ptdev);
+void panthor_sched_protm_unblock(struct panthor_device *ptdev);
+
 #ifdef CONFIG_DEBUG_FS
 void panthor_sched_debugfs_init(struct drm_minor *minor);
 #endif
-- 
2.43.0

