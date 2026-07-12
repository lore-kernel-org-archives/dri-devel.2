Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A641C43458
	for <dri-devel@archiver.kernel.org>; Sun, 12 Jul 2026 13:55:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4DDA10E47B;
	Sun, 12 Jul 2026 13:55:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="neYk2q+f";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 220A110E474
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 13:55:07 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 361AC1684;
 Sun, 12 Jul 2026 06:55:02 -0700 (PDT)
Received: from e120398-lin.trondheim.arm.com (e120398-lin.trondheim.arm.com
 [10.42.46.160])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 42ADD3F7D8;
 Sun, 12 Jul 2026 06:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1783864506; bh=SuAGa9RdvYtLYejjWCIFCFM2nkX4livSCeWV2Mg3d8I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=neYk2q+fREij7y7U7wJGn9+qWQv3vMfDWnQ0yG3eba4pK3JoExo61Vt06QYh1h3Fj
 VjPN8XzLAOIv/XfpdquMugySHWR9f/sdivA0EiUbZUURyWctS6RhvQHLqbflryeapN
 WqlPL97yGO8UIrvrMr1gtKSBeacfVLEj51NMAVCQ=
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
Subject: [PATCH v2 6/7] drm/panthor: Add support for entering and exiting
 protected mode
Date: Sun, 12 Jul 2026 15:54:38 +0200
Message-ID: <20260712135439.1546950-7-ketil.johnsen@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260712135439.1546950-1-ketil.johnsen@arm.com>
References: <20260712135439.1546950-1-ketil.johnsen@arm.com>
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
 drivers/gpu/drm/panthor/panthor_device.c |   1 +
 drivers/gpu/drm/panthor/panthor_device.h |  33 +++
 drivers/gpu/drm/panthor/panthor_fw.c     |  90 +++++-
 drivers/gpu/drm/panthor/panthor_fw.h     |   5 +
 drivers/gpu/drm/panthor/panthor_gpu.c    |  53 +++-
 drivers/gpu/drm/panthor/panthor_gpu.h    |   4 +
 drivers/gpu/drm/panthor/panthor_mmu.c    |  29 +-
 drivers/gpu/drm/panthor/panthor_sched.c  | 333 ++++++++++++++++++++++-
 drivers/gpu/drm/panthor/panthor_sched.h  |   4 +
 9 files changed, 533 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
index bd417d6ae8c00..c0cdefd330799 100644
--- a/drivers/gpu/drm/panthor/panthor_device.c
+++ b/drivers/gpu/drm/panthor/panthor_device.c
@@ -172,6 +172,7 @@ int panthor_device_init(struct panthor_device *ptdev)
 
 	ptdev->soc_data = of_device_get_match_data(ptdev->base.dev);
 
+	init_rwsem(&ptdev->protm.lock);
 	init_completion(&ptdev->unplug.done);
 	ret = drmm_mutex_init(&ptdev->base, &ptdev->unplug.lock);
 	if (ret)
diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index 35679bfa1f3a6..e5df42f095717 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -332,6 +332,26 @@ struct panthor_device {
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
+		 * panthor_vm_lock_region() will down this as a reader, and
+		 * this will prevent any new transition into protected mode.
+		 * panthor_vm_lock_region() will then wait for GPU to return
+		 * to normal mode before proceeding.
+		 * It is now safe to carry out page table modifications.
+		 * Only the switch into protected mode itself will down this
+		 * as a writer. The wait for GPU to leave protected mode
+		 * in panthor_vm_lock_region() will ensure this is enough.
+		 */
+		struct rw_semaphore lock;
+	} protm;
 };
 
 struct panthor_gpu_usage {
@@ -628,6 +648,19 @@ static inline void panthor_ ## __name ## _irq_disable_events(struct panthor_irq
 		gpu_write(pirq->iomem, INT_MASK, pirq->mask);					\
 }
 
+/**
+ * PANTHOR_IRQ_HANDLER_DECL() - Forward declare interrupt handlers helpers
+ *
+ * Exposes the IRQ helper functions panthor_xxx_irq_enable_events() and
+ * panthor_xxx_disable_events(), so these can be used from within the
+ * IRQ handler itself.
+ */
+#define PANTHOR_IRQ_HANDLER_DECL(__name)				     \
+static inline void panthor_ ## __name ## _irq_enable_events(		     \
+					struct panthor_irq *pirq, u32 mask); \
+static inline void panthor_ ## __name ## _irq_disable_events(		     \
+					struct panthor_irq *pirq, u32 mask);
+
 extern struct workqueue_struct *panthor_cleanup_wq;
 
 static inline void gpu_write(void __iomem *iomem, u32 reg, u32 data)
diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index 389f9182fac16..76792f9175b57 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -1035,7 +1035,9 @@ static void panthor_fw_init_global_iface(struct panthor_device *ptdev)
 					 GLB_CFG_PROGRESS_TIMER |
 					 GLB_CFG_POWEROFF_TIMER |
 					 GLB_IDLE_EN |
-					 GLB_IDLE;
+					 GLB_IDLE |
+					 GLB_PROTM_ENTER |
+					 GLB_PROTM_EXIT;
 
 	if (panthor_fw_has_glb_state(ptdev))
 		glb_iface->input->ack_irq_mask |= GLB_STATE_MASK;
@@ -1441,6 +1443,92 @@ static void panthor_fw_ping_work(struct work_struct *work)
 	}
 }
 
+static int panthor_fw_protm_enter_wait(struct panthor_device *ptdev,
+				       u32 timeout_ms)
+{
+	struct panthor_fw_global_iface *glb_iface =
+		panthor_fw_get_glb_iface(ptdev);
+	int ret;
+
+	/* Poll for the entry of protected mode.
+	 * GLB_PROTM_EXIT is also checked as it may happen that FW enters and
+	 * exits protected mode very quickly and so the GPU_STATUS_PROTM_ACTIVE
+	 * bit is seen as 0 throughout the polling.
+	 */
+	ret = wait_event_timeout(ptdev->fw->req_waitqueue,
+				 (panthor_gpu_status(ptdev) &
+					GPU_STATUS_PROTM_ACTIVE) ||
+				((glb_iface->input->req ^ glb_iface->output->ack) &
+					 GLB_PROTM_EXIT),
+				 msecs_to_jiffies(timeout_ms));
+	if (!ret)
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
+int panthor_fw_protm_enter(struct panthor_device *ptdev)
+{
+	struct panthor_fw_global_iface *glb_iface =
+		panthor_fw_get_glb_iface(ptdev);
+	u32 acked;
+	int ret;
+
+	/* Restart the watchdog timer, so it doesn't hit immediately
+	 * after entering protected mode, since this will cause GPU
+	 * to exit protected mode to respond to the ping request.
+	 */
+	mod_delayed_work(ptdev->reset.wq, &ptdev->fw->watchdog.ping_work,
+		msecs_to_jiffies(PING_INTERVAL_MS));
+
+	panthor_fw_toggle_reqs(glb_iface, req, ack, GLB_PROTM_ENTER);
+	panthor_fw_ring_doorbell(ptdev, CSF_GLB_DOORBELL_ID);
+
+	ret = panthor_fw_glb_wait_acks(ptdev, GLB_PROTM_ENTER, &acked, 4000);
+	if (ret) {
+		drm_err(&ptdev->base,
+			"Wait for FW protected mode acknowledge timed out");
+		return ret;
+	}
+
+	/* Wait for the GPU to actually enter protected mode.
+	 * There would be some time gap between FW sending the
+	 * ACK for GLB_PROTM_ENTER and GPU entering protected mode.
+	 */
+	ret = panthor_fw_protm_enter_wait(ptdev, 500);
+	if (ret)
+		drm_err(&ptdev->base,
+			"Wait for GPU protected mode enter timed out");
+
+	return ret;
+}
+
+int panthor_fw_protm_exit_wait(struct panthor_device *ptdev, u32 timeout_ms)
+{
+	int ret;
+
+	ret = wait_event_timeout(ptdev->fw->req_waitqueue,
+				 !(panthor_gpu_status(ptdev) &
+					GPU_STATUS_PROTM_ACTIVE),
+				 msecs_to_jiffies(timeout_ms));
+	if (!ret)
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
+int panthor_fw_protm_exit(struct panthor_device *ptdev)
+{
+	struct panthor_fw_global_iface *glb_iface =
+		panthor_fw_get_glb_iface(ptdev);
+
+	/* Send PING request to force an exit */
+	panthor_fw_toggle_reqs(glb_iface, req, ack, GLB_PING);
+	panthor_fw_ring_doorbell(ptdev, CSF_GLB_DOORBELL_ID);
+
+	return panthor_fw_protm_exit_wait(ptdev, 500);
+}
+
 /**
  * panthor_fw_init() - Initialize FW related data.
  * @ptdev: Device.
diff --git a/drivers/gpu/drm/panthor/panthor_fw.h b/drivers/gpu/drm/panthor/panthor_fw.h
index a99a9b6f4825c..78658d64b807e 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.h
+++ b/drivers/gpu/drm/panthor/panthor_fw.h
@@ -529,4 +529,9 @@ static inline int panthor_fw_resume(struct panthor_device *ptdev)
 int panthor_fw_init(struct panthor_device *ptdev);
 void panthor_fw_unplug(struct panthor_device *ptdev);
 
+int panthor_fw_protm_enter(struct panthor_device *ptdev);
+int panthor_fw_protm_exit(struct panthor_device *ptdev);
+int panthor_fw_protm_exit_wait(struct panthor_device *ptdev,
+			       u32 timeout_ms);
+
 #endif
diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
index e52c5675981f5..9054ac251fd3e 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu.c
+++ b/drivers/gpu/drm/panthor/panthor_gpu.c
@@ -46,6 +46,9 @@ struct panthor_gpu {
 
 	/** @cache_flush_lock: Lock to serialize cache flushes */
 	struct mutex cache_flush_lock;
+
+	/** @protm_fault: True if a GPU_IRQ_PROTM_FAULT has been raised */
+	bool protm_fault;
 };
 
 #define GPU_INTERRUPTS_MASK	\
@@ -86,10 +89,42 @@ static void panthor_gpu_l2_config_set(struct panthor_device *ptdev)
 	gpu_write(gpu->iomem, GPU_L2_CONFIG, l2_config);
 }
 
+PANTHOR_IRQ_HANDLER_DECL(gpu);
+
 static void panthor_gpu_irq_handler(struct panthor_device *ptdev, u32 status)
 {
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
+		WRITE_ONCE(gpu->protm_fault, true);
+
+		drm_warn(&ptdev->base, "GPU Fault in protected mode\n");
+		panthor_gpu_irq_disable_events(&ptdev->gpu->irq,
+					       GPU_IRQ_PROTM_FAULT);
+		panthor_device_schedule_reset(ptdev);
+	}
+
 	gpu_write(gpu->irq.iomem, INT_CLEAR, status);
 
 	if (tracepoint_enabled(gpu_power_status) && (status & GPU_POWER_INTERRUPTS_MASK))
@@ -106,8 +141,6 @@ static void panthor_gpu_irq_handler(struct panthor_device *ptdev, u32 status)
 			 fault_status, panthor_exception_name(ptdev, fault_status & 0xFF),
 			 address);
 	}
-	if (status & GPU_IRQ_PROTM_FAULT)
-		drm_warn(&ptdev->base, "GPU Fault in protected mode\n");
 
 	spin_lock(&ptdev->gpu->reqs_lock);
 	if (status & ptdev->gpu->pending_reqs) {
@@ -118,6 +151,13 @@ static void panthor_gpu_irq_handler(struct panthor_device *ptdev, u32 status)
 }
 PANTHOR_IRQ_HANDLER(gpu, panthor_gpu_irq_handler);
 
+bool panthor_gpu_protm_fault_pending(struct panthor_device *ptdev)
+{
+	return READ_ONCE(ptdev->gpu->protm_fault) ||
+		gpu_read(ptdev->gpu->irq.iomem, INT_RAWSTAT) &
+			GPU_IRQ_PROTM_FAULT;
+}
+
 /**
  * panthor_gpu_unplug() - Called when the GPU is unplugged.
  * @ptdev: Device to unplug.
@@ -380,6 +420,10 @@ int panthor_gpu_soft_reset(struct panthor_device *ptdev)
 	unsigned long flags;
 
 	spin_lock_irqsave(&ptdev->gpu->reqs_lock, flags);
+
+	WRITE_ONCE(ptdev->gpu->protm_fault, false);
+	panthor_gpu_irq_enable_events(&ptdev->gpu->irq,	GPU_IRQ_PROTM_FAULT);
+
 	if (!drm_WARN_ON(&ptdev->base,
 			 ptdev->gpu->pending_reqs & GPU_IRQ_RESET_COMPLETED)) {
 		ptdev->gpu->pending_reqs |= GPU_IRQ_RESET_COMPLETED;
@@ -480,3 +524,8 @@ int panthor_gpu_coherency_init(struct panthor_device *ptdev)
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
index ed2ae5a6008d1..75c484118f6ba 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -1794,11 +1794,30 @@ static int panthor_vm_lock_region(struct panthor_vm *vm, u64 start, u64 size)
 	if (drm_WARN_ON(&ptdev->base, vm->locked_region.size))
 		return -EINVAL;
 
+	/* Prevent GPU from entering protected mode */
+	panthor_sched_protm_block(ptdev);
+
 	mutex_lock(&ptdev->mmu->as.slots_lock);
 	if (vm->as.id >= 0 && size) {
-		u64 region = pack_region_range(ptdev, &start, &size);
+		mutex_unlock(&ptdev->mmu->as.slots_lock);
 
-		ret = panthor_vm_apply_as_lock(vm, region);
+		/* Wait for GPU to exit protected mode.
+		 * There is a slim chance that the GPU has faulted in protected
+		 * mode. Such failures are handled with a GPU reset.
+		 * That is why we temporary release the as.slots_lock, while we
+		 * wait for protected mode to exit, since the same lock will
+		 * be acquired during the GPU reset procedure.
+		 */
+
+		panthor_sched_protm_exit(ptdev);
+
+		mutex_lock(&ptdev->mmu->as.slots_lock);
+
+		if (vm->as.id >= 0 && size) {
+			u64 region = pack_region_range(ptdev, &start, &size);
+
+			ret = panthor_vm_apply_as_lock(vm, region);
+		}
 	}
 
 	if (!ret) {
@@ -1807,6 +1826,9 @@ static int panthor_vm_lock_region(struct panthor_vm *vm, u64 start, u64 size)
 	}
 	mutex_unlock(&ptdev->mmu->as.slots_lock);
 
+	if (ret)
+		panthor_sched_protm_unblock(ptdev);
+
 	return ret;
 }
 
@@ -1890,6 +1912,9 @@ static void panthor_vm_unlock_region(struct panthor_vm *vm)
 	vm->locked_region.start = 0;
 	vm->locked_region.size = 0;
 	mutex_unlock(&ptdev->mmu->as.slots_lock);
+
+	/* Let scheduler know it is safe to enter protected mode again */
+	panthor_sched_protm_unblock(ptdev);
 }
 
 static void panthor_mmu_irq_handler(struct panthor_device *ptdev, u32 status)
diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 86c0f12b09e11..efa53b0a05d38 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -309,6 +309,17 @@ struct panthor_scheduler {
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
@@ -571,6 +582,16 @@ struct panthor_group {
 	/** @fatal_queues: Bitmask reflecting the queues that hit a fatal exception. */
 	u32 fatal_queues;
 
+	/**
+	 * @protm_pending_queues: Bitmask reflecting the queues that have raised
+	 *                        a CS_PROTM_PENDING.
+	 *
+	 * The GPU will set the bit associated to the queue pending protected
+	 * mode when a PROT_REGION command is executing or when trying to resume
+	 * previously suspended protected mode jobs.
+	 */
+	u32 protm_pending_queues;
+
 	/** @tiler_oom: Mask of queues that have a tiler OOM event to process. */
 	atomic_t tiler_oom;
 
@@ -1054,6 +1075,7 @@ group_unbind_locked(struct panthor_group *group)
 	slot = &ptdev->scheduler->csg_slots[group->csg_id];
 	panthor_vm_idle(group->vm);
 	group->csg_id = -1;
+	group->protm_pending_queues = 0;
 
 	/* Tiler OOM events will be re-issued next time the group is scheduled. */
 	atomic_set(&group->tiler_oom, 0);
@@ -1473,6 +1495,27 @@ csg_slot_prog_locked(struct panthor_device *ptdev, u32 csg_id, u32 priority)
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
+	lockdep_assert_held(&sched->lock);
+
+	if (!group)
+		return;
+
+	/* Do not allow user space work to switch into protected mode, as we
+	 * do not fully support this quite yet.
+	 */
+	group->fatal_queues |= BIT(cs_id);
+
+	sched_queue_delayed_work(sched, tick, 0);
+}
+
 static void
 cs_slot_process_fatal_event_locked(struct panthor_device *ptdev,
 				   u32 csg_id, u32 cs_id)
@@ -1719,6 +1762,9 @@ static bool cs_slot_process_irq_locked(struct panthor_device *ptdev,
 	if (events & CS_TILER_OOM)
 		cs_slot_process_tiler_oom_event_locked(ptdev, csg_id, cs_id);
 
+	if (events & CS_PROTM_PENDING)
+		cs_slot_process_protm_pending_event_locked(ptdev, csg_id, cs_id);
+
 	/* We don't acknowledge the TILER_OOM event since its handling is
 	 * deferred to a separate work.
 	 */
@@ -1849,6 +1895,34 @@ static void sched_process_idle_event_locked(struct panthor_device *ptdev)
 	sched_queue_delayed_work(ptdev->scheduler, tick, 0);
 }
 
+static void sched_process_protm_exit_event_locked(struct panthor_device *ptdev)
+{
+	struct panthor_fw_global_iface *glb_iface = panthor_fw_get_glb_iface(ptdev);
+	struct panthor_scheduler *sched = ptdev->scheduler;
+
+	lockdep_assert_held(&sched->lock);
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
+
+	group_put(sched->protm.active_group);
+	sched->protm.active_group = NULL;
+
+	sched_queue_delayed_work(sched, tick, 0);
+}
+
 /**
  * sched_process_global_irq_locked() - Process the scheduling part of a global IRQ
  * @ptdev: Device.
@@ -1864,6 +1938,9 @@ static void sched_process_global_irq_locked(struct panthor_device *ptdev)
 	ack = READ_ONCE(glb_iface->output->ack);
 	evts = (req ^ ack) & GLB_EVT_MASK;
 
+	if (evts & GLB_PROTM_EXIT)
+		sched_process_protm_exit_event_locked(ptdev);
+
 	if (evts & GLB_IDLE)
 		sched_process_idle_event_locked(ptdev);
 }
@@ -1873,23 +1950,87 @@ static void process_fw_events_work(struct work_struct *work)
 	struct panthor_scheduler *sched = container_of(work, struct panthor_scheduler,
 						      fw_events_work);
 	u32 events = atomic_xchg(&sched->fw_events, 0);
+	u32 csg_events = events & ~JOB_INT_GLOBAL_IF;
 	struct panthor_device *ptdev = sched->ptdev;
 
 	mutex_lock(&sched->lock);
 
+	while (csg_events) {
+		u32 csg_id = ffs(csg_events) - 1;
+
+		sched_process_csg_irq_locked(ptdev, csg_id);
+		csg_events &= ~BIT(csg_id);
+	}
+
 	if (events & JOB_INT_GLOBAL_IF) {
 		sched_process_global_irq_locked(ptdev);
 		events &= ~JOB_INT_GLOBAL_IF;
 	}
 
-	while (events) {
-		u32 csg_id = ffs(events) - 1;
+	mutex_unlock(&sched->lock);
+}
 
-		sched_process_csg_irq_locked(ptdev, csg_id);
-		events &= ~BIT(csg_id);
-	}
+static void handle_protm_fault(struct panthor_device *ptdev)
+{
+	struct panthor_scheduler *sched = ptdev->scheduler;
+	u32 csg_id;
+	struct panthor_group *protm_group;
 
-	mutex_unlock(&sched->lock);
+	guard(mutex)(&sched->lock);
+
+	protm_group = sched->protm.active_group;
+
+	if (!protm_group || !panthor_gpu_protm_fault_pending(ptdev))
+		return;
+
+	protm_group->fatal_queues |= GENMASK(protm_group->queue_count - 1, 0);
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
+	if (!panthor_fw_protm_exit(ptdev))
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
+		sched_process_csg_irq_locked(ptdev, group->csg_id);
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
 }
 
 /**
@@ -1935,6 +2076,12 @@ static void csgs_upd_ctx_init(struct panthor_csg_slots_upd_ctx *ctx)
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
@@ -1945,7 +2092,8 @@ static void csgs_upd_ctx_queue_reqs(struct panthor_device *ptdev,
 
 	ctx->requests[csg_id].value = (ctx->requests[csg_id].value & ~mask) | (value & mask);
 	ctx->requests[csg_id].mask |= mask;
-	ctx->update_mask |= BIT(csg_id);
+
+	csgs_upd_ctx_ring_doorbell(ctx, csg_id);
 }
 
 static int csgs_upd_ctx_apply_locked(struct panthor_device *ptdev,
@@ -1962,8 +2110,12 @@ static int csgs_upd_ctx_apply_locked(struct panthor_device *ptdev,
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
@@ -1980,6 +2132,9 @@ static int csgs_upd_ctx_apply_locked(struct panthor_device *ptdev,
 		int ret;
 
 		update_slots &= ~BIT(csg_id);
+		if (!req_mask)
+			continue;
+
 		csg_iface = panthor_fw_get_csg_iface(ptdev, csg_id);
 
 		ret = panthor_fw_csg_wait_acks(ptdev, csg_id, req_mask, &acked, 100);
@@ -2016,6 +2171,7 @@ struct panthor_sched_tick_ctx {
 	bool immediate_tick;
 	bool stop_tick;
 	u32 csg_upd_failed_mask;
+	struct panthor_group *protm_group;
 };
 
 static bool
@@ -2057,6 +2213,10 @@ tick_ctx_pick_groups_from_list(const struct panthor_scheduler *sched,
 		if (!owned_by_tick_ctx)
 			group_get(group);
 
+		/* Only the first pick is allowed to request switch to protm */
+		if (ctx->group_count == 0 && group->protm_pending_queues)
+			ctx->protm_group = group;
+
 		ctx->group_count++;
 
 		/* If we have more than one active group with the same priority,
@@ -2214,6 +2374,48 @@ static void group_term_work(struct work_struct *work)
 	group_put(group);
 }
 
+static int panthor_sched_protm_enter(struct panthor_device *ptdev)
+{
+	struct panthor_scheduler *sched = ptdev->scheduler;
+	int ret;
+
+	lockdep_assert_held(&sched->lock);
+
+	if (drm_WARN_ON(&ptdev->base, sched->protm.active_group))
+		return 0;
+
+	down_write(&ptdev->protm.lock);
+	ret = panthor_fw_protm_enter(ptdev);
+	up_write(&ptdev->protm.lock);
+
+	return ret;
+}
+
+void panthor_sched_protm_block(struct panthor_device *ptdev)
+{
+	down_read(&ptdev->protm.lock);
+}
+
+void panthor_sched_protm_unblock(struct panthor_device *ptdev)
+{
+	up_read(&ptdev->protm.lock);
+}
+
+int panthor_sched_protm_exit(struct panthor_device *ptdev)
+{
+	int ret;
+
+	/* First, wait a little bit for FW to exit protected mode on its own.
+	 * Only if that fails do we request a protected mode exit.
+	 */
+
+	ret = panthor_fw_protm_exit_wait(ptdev, 5);
+	if (ret)
+		ret = panthor_fw_protm_exit(ptdev);
+
+	return ret;
+}
+
 static void
 tick_ctx_cleanup(struct panthor_scheduler *sched,
 		 struct panthor_sched_tick_ctx *ctx)
@@ -2331,6 +2533,46 @@ tick_ctx_schedule_group(struct panthor_scheduler *sched,
 				CSG_ENDPOINT_CONFIG);
 }
 
+static void
+tick_ctx_handle_protm_group(struct panthor_scheduler *sched,
+			    struct panthor_csg_slots_upd_ctx *upd_ctx,
+			    struct panthor_group *group)
+{
+	struct panthor_device *ptdev = sched->ptdev;
+	struct panthor_fw_csg_iface *csg_iface;
+	u32 q;
+
+	if (drm_WARN_ON(&ptdev->base, group->csg_id < 0))
+		return;
+
+	csg_iface = panthor_fw_get_csg_iface(ptdev, group->csg_id);
+
+	if (!group->protm_pending_queues)
+		return;
+
+	for (q = 0; q < group->queue_count; q++) {
+		struct panthor_fw_cs_iface *cs_iface;
+
+		if (!(group->protm_pending_queues & BIT(q)))
+			continue;
+
+		cs_iface = panthor_fw_get_cs_iface(ptdev, group->csg_id, q);
+
+		/* Ack any pending CS_PROTM_PENDING so it can run in protm */
+		if ((cs_iface->output->ack ^ cs_iface->input->req) &
+		    CS_PROTM_PENDING) {
+			panthor_fw_update_reqs(cs_iface, req,
+					       cs_iface->output->ack,
+					       CS_PROTM_PENDING);
+			group->protm_pending_queues &= ~BIT(q);
+		}
+	}
+
+	panthor_fw_toggle_reqs(csg_iface, doorbell_req, doorbell_ack,
+			       group->protm_pending_queues);
+	csgs_upd_ctx_ring_doorbell(upd_ctx, group->csg_id);
+}
+
 static void
 tick_ctx_apply(struct panthor_scheduler *sched, struct panthor_sched_tick_ctx *ctx)
 {
@@ -2403,6 +2645,9 @@ tick_ctx_apply(struct panthor_scheduler *sched, struct panthor_sched_tick_ctx *c
 		}
 	}
 
+	if (ctx->protm_group)
+		tick_ctx_handle_protm_group(sched, &upd_ctx, ctx->protm_group);
+
 	ret = csgs_upd_ctx_apply_locked(ptdev, &upd_ctx);
 	if (ret) {
 		panthor_device_schedule_reset(ptdev);
@@ -2443,6 +2688,20 @@ tick_ctx_apply(struct panthor_scheduler *sched, struct panthor_sched_tick_ctx *c
 
 	sched->used_csg_slot_count = ctx->group_count;
 	sched->might_have_idle_groups = ctx->idle_group_count > 0;
+
+	if (ctx->protm_group) {
+		ret = panthor_sched_protm_enter(ptdev);
+		if (ret) {
+			panthor_device_schedule_reset(ptdev);
+			ctx->csg_upd_failed_mask = U32_MAX;
+		}
+
+		if (drm_WARN_ON(&ptdev->base, sched->protm.active_group))
+			group_put(sched->protm.active_group);
+
+		sched->protm.active_group = ctx->protm_group;
+		group_get(sched->protm.active_group);
+	}
 }
 
 static u64
@@ -2499,6 +2758,26 @@ static void tick_work(struct work_struct *work)
 	if (panthor_device_reset_is_pending(sched->ptdev))
 		goto out_unlock;
 
+	if (sched->protm.active_group) {
+		bool rt_groups_waiting =
+			!list_empty(&sched->groups.runnable[PANTHOR_CSG_PRIORITY_RT]);
+
+		if (full_tick || rt_groups_waiting) {
+			/* We allow preemption in this case, but we must
+			 * ensure we are fully out of protected mode first.
+			 * We rely on the GLB_PROTM_EXIT (or error recovery)
+			 * to get a new tick.
+			 */
+			if (panthor_fw_protm_exit(ptdev)) {
+				drm_err(&ptdev->base,
+					"Failed to exit protected mode");
+				panthor_device_schedule_reset(ptdev);
+			}
+		}
+
+		goto out_unlock;
+	}
+
 	tick_ctx_init(sched, &ctx);
 	if (ctx.csg_upd_failed_mask)
 		goto out_cleanup_ctx;
@@ -2551,13 +2830,34 @@ static void tick_work(struct work_struct *work)
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
+		     prio >= 0 && !tick_ctx_is_full(sched, &ctx);
+		     prio--)
+			tick_ctx_pick_groups_from_list(sched, &ctx,
+						       &ctx.old_groups[prio],
+						       false, true);
+	} else {
+		/* No switch to protected, just pick any idle group according
+		 * to priority
+		 */
+		for (prio = PANTHOR_CSG_PRIORITY_COUNT - 1;
+		     prio >= 0 && !tick_ctx_is_full(sched, &ctx);
+		     prio--) {
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
@@ -2979,6 +3279,8 @@ void panthor_sched_pre_reset(struct panthor_device *ptdev)
 	cancel_work_sync(&sched->sync_upd_work);
 	cancel_delayed_work_sync(&sched->tick_work);
 
+	handle_protm_fault(ptdev);
+
 	panthor_sched_suspend(ptdev);
 
 	/* Stop all groups that might still accept jobs, so we don't get passed
@@ -3004,6 +3306,9 @@ void panthor_sched_post_reset(struct panthor_device *ptdev, bool reset_failed)
 
 	mutex_lock(&sched->reset.lock);
 
+	group_put(sched->protm.active_group);
+	sched->protm.active_group = NULL;
+
 	list_for_each_entry_safe(group, group_tmp, &sched->reset.stopped_groups, run_node) {
 		/* Consider all previously running group as terminated if the
 		 * reset failed.
diff --git a/drivers/gpu/drm/panthor/panthor_sched.h b/drivers/gpu/drm/panthor/panthor_sched.h
index be7e1c8b4f563..fa4a914c9d05a 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.h
+++ b/drivers/gpu/drm/panthor/panthor_sched.h
@@ -52,4 +52,8 @@ void panthor_sched_report_fw_events(struct panthor_device *ptdev, u32 events);
 
 void panthor_fdinfo_gather_group_samples(struct drm_file *file);
 
+void panthor_sched_protm_block(struct panthor_device *ptdev);
+void panthor_sched_protm_unblock(struct panthor_device *ptdev);
+int panthor_sched_protm_exit(struct panthor_device *ptdev);
+
 #endif
-- 
2.43.0

