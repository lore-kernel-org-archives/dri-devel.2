Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6870606A8B2
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 11:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=ZoLwxyTh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E320F10EF76;
	Mon, 16 Nov 2026 11:26:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id BA29410E9D8
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 11:26:41 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 597FF1713;
 Mon, 16 Nov 2026 03:26:38 -0800 (PST)
Received: from e120398-lin.trondheim.arm.com (e120398-lin.trondheim.arm.com
 [10.42.46.160])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A3243F632;
 Mon, 16 Nov 2026 03:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1794828401; bh=pTmAPU0AWri9ZJkNICM4EH4bd5DodrWk4dxDnjl7lCw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ZoLwxyTh4Oore1s3X1tqhRbRwoCdWHOy+DG8hkXhzhPpmmeRhl5kLVuRZl1T4vG2/
 zQaZv6ha0/PhJRbp6Kcjsip+Knu/Jo4k7U9R/E14ZCa3Z+lVAbSpT0W3WGpuuw1i+W
 97qu+ehW2wFeTDdAgf3nVtFjuwl+HEwSFhwo1Oi4=
From: Ketil Johnsen <ketil.johnsen@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Akash Goel <akash.goel@arm.com>, Karunika Choo <karunika.choo@arm.com>,
 Lukas Zapolskas <lukas.zapolskas@arm.com>,
 Chris Diamand <chris.diamand@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, Florent Tomasin <florent.tomasin@arm.com>,
 Paul Toadere <paul.toadere@arm.com>,
 Samuel Percival <samuel.percival@arm.com>,
 Ketil Johnsen <ketil.johnsen@arm.com>
Subject: [PATCH v5 05/13] drm/panthor: Add support for entering and exiting
 protected mode
Date: Mon, 16 Nov 2026 12:25:53 +0100
Message-ID: <20261116112601.3483649-6-ketil.johnsen@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116112601.3483649-1-ketil.johnsen@arm.com>
References: <20261116112601.3483649-1-ketil.johnsen@arm.com>
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

v5:
- Use empty transtab trickery for "dormant" VMs during protm
  instead of the "delayed update" mask in previous version.
- Ditched "try block", no need to block protm in reclaim path.
- Split remap_evicted_vma() to avoid mixed cleanup approaches.
- Take protm.lock in panthor_sched_post_reset()
- Halt processing of async VM ops for VM executing in protm.
- Minor formating fixes.
- Minor kernel doc fixes.

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
 drivers/gpu/drm/panthor/panthor_mmu.c    | 351 +++++++++++++-----
 drivers/gpu/drm/panthor/panthor_mmu.h    |   5 +
 drivers/gpu/drm/panthor/panthor_sched.c  | 438 +++++++++++++++++++++--
 drivers/gpu/drm/panthor/panthor_sched.h  |  16 +
 9 files changed, 847 insertions(+), 122 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index b55a3f9edd414..ac779059a9397 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -336,6 +336,14 @@ struct panthor_device {
 		struct list_head node;
 	} gems;
 #endif
+	/** @protm: Protected mode related data. */
+	struct {
+		/** @protm.protm_enter_count: Number of times we entered protm. */
+		atomic64_t protm_enter_count;
+
+		/** @protm.protm_exit_count: Number of times we exited protm. */
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
index b8df5663f04e4..5fcfdba08deff 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu.c
+++ b/drivers/gpu/drm/panthor/panthor_gpu.c
@@ -47,6 +47,9 @@ struct panthor_gpu {
 
 	/** @cache_flush_lock: Lock to serialize cache flushes */
 	struct mutex cache_flush_lock;
+
+	/** @protm_fault: True if a GPU_IRQ_PROTM_FAULT has been raised */
+	atomic_t protm_fault;
 };
 
 #define GPU_INTERRUPTS_MASK	\
@@ -92,6 +95,35 @@ static void panthor_gpu_irq_handler(struct panthor_irq *pirq, u32 status)
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
@@ -108,8 +140,6 @@ static void panthor_gpu_irq_handler(struct panthor_irq *pirq, u32 status)
 			 fault_status, panthor_exception_name(ptdev, fault_status & 0xFF),
 			 address);
 	}
-	if (status & GPU_IRQ_PROTM_FAULT)
-		drm_warn(&ptdev->base, "GPU Fault in protected mode\n");
 
 	spin_lock(&ptdev->gpu->reqs_lock);
 	if (status & ptdev->gpu->pending_reqs) {
@@ -124,6 +154,13 @@ static irqreturn_t panthor_gpu_irq_threaded_handler(int irq, void *data)
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
@@ -431,6 +468,9 @@ int panthor_gpu_soft_reset(struct panthor_device *ptdev)
 		return -ETIMEDOUT;
 	}
 
+	atomic_set(&ptdev->gpu->protm_fault, 0);
+	panthor_irq_enable_events(&ptdev->gpu->irq, GPU_IRQ_PROTM_FAULT);
+
 	scoped_guard(spinlock, &ptdev->gpu->reqs_lock) {
 		ptdev->gpu->pending_reqs = 0;
 	}
@@ -512,3 +552,8 @@ int panthor_gpu_coherency_init(struct panthor_device *ptdev)
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
index 838753db95151..47e7d570683a6 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -268,6 +268,9 @@ struct panthor_vm {
 	/** @root_page_table: Stores the root page table pointer. */
 	void *root_page_table;
 
+	/** @empty_transtab_offset: Offset to a root page table with no entries */
+	u32 empty_transtab_offset;
+
 	/**
 	 * @op_lock: Lock used to serialize operations on a VM.
 	 *
@@ -450,6 +453,82 @@ struct panthor_vm_bind_job {
  */
 static struct kmem_cache *pt_cache;
 
+static void panthor_mmu_set_empty_pt(struct panthor_vm *vm)
+{
+	struct panthor_device *ptdev = vm->ptdev;
+	struct panthor_mmu *mmu = ptdev->mmu;
+	struct io_pgtable_cfg *cfg =
+		&io_pgtable_ops_to_pgtable(vm->pgtbl_ops)->cfg;
+	u32 empty_transtab_low =
+		(u32)(cfg->arm_lpae_s1_cfg.ttbr + vm->empty_transtab_offset);
+
+	guard(mutex)(&mmu->as.slots_lock);
+
+	if (vm->as.id < 0)
+		return;
+
+	gpu_write(mmu->iomem, AS_TRANSTAB(vm->as.id), empty_transtab_low);
+}
+
+static bool protm_block_timeout(struct panthor_vm *vm)
+{
+	/* Blocking of protected mode needs some explanation.
+	 *
+	 * GPU behavior we try to handle:
+	 * - Issuing MMU/AS commands during protm will have no effect.
+	 * - Exit of protm will resume normal work execution automatically.
+	 *
+	 * We do not want to block VM operations just because we are in protm.
+	 * Process N being blocked from mapping memory just because process P
+	 * is running in protm is seemingly unfair, so we want to avoid that.
+	 *
+	 * We also do not want to unschedule normal groups each time we enter
+	 * protm. This would just add latency before these groups can resume
+	 * execution after protm exit. We want GPU to resume this automatically.
+	 *
+	 * Combining our desires with the GPU protm limitations is challenging,
+	 * but this is how we are doing it:
+	 *
+	 * - Before every affected MMU/AS operations, we block the scheduler/GPU
+	 *   from entering protm.
+	 * - If the GPU is not in protm, then we proceed as normal.
+	 * - If the GPU is in protm (or about to enter, or have just exited),
+	 *   then we proceed with additional logic. This is what we try to
+	 *   handle right here in this function.
+	 *   - Processes which execute work in protm will preempt protm (itself).
+	 *     Preemption is not ideal, but it mainly affects itself.
+	 *   - Processes which do not execute work in protm, but have an active
+	 *     AS, will insert an empty page table (TRANSTAB) before continuing.
+	 *     - Continuing will potentially issue AS commands which will be
+	 *       ignored, but that is fine in this case.
+	 *     - We use the page fault handler to restore the correct page
+	 *       table. We should only see this once GPU have exited protm and
+	 *       resumed execution of normal work.
+	 *   - Processes with no active AS will need no further consideration,
+	 *     since VM ops to these will never touch the GPU HW anyway.
+	 */
+
+	enum protm_block_result res;
+
+	res = panthor_sched_protm_block_timeout(vm->ptdev, vm);
+	if (res == PROTM_BLOCK_ERROR)
+		return false;
+
+	if (res == PROTM_BLOCK_DORMANT)
+		panthor_mmu_set_empty_pt(vm);
+
+	return true;
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
+
 /**
  * alloc_pt() - Custom page table allocator
  * @cookie: Cookie passed at page table allocation time.
@@ -475,9 +554,10 @@ static void *alloc_pt(void *cookie, size_t size, gfp_t gfp)
 
 		drm_WARN_ON(&vm->ptdev->base, vm->op_ctx);
 		p = alloc_pages_node(dev_to_node(vm->ptdev->base.dev),
-				     gfp | __GFP_ZERO, get_order(size));
+				     gfp | __GFP_ZERO, get_order(size) * 2);
 		page = p ? page_address(p) : NULL;
 		vm->root_page_table = page;
+		vm->empty_transtab_offset = size;
 		return page;
 	}
 
@@ -1847,6 +1927,79 @@ static void panthor_vm_unlock_region(struct panthor_vm *vm)
 	mutex_unlock(&ptdev->mmu->as.slots_lock);
 }
 
+static bool handle_as_fault_locked(struct panthor_device *ptdev, u32 as)
+{
+	struct panthor_mmu *mmu = ptdev->mmu;
+	struct panthor_vm *vm = mmu->as.slots[as].vm;
+	struct io_pgtable_cfg *cfg;
+	u64 actual_transtab;
+	u32 empty_transtab_low;
+	u32 cur_transtab_low;
+	int ret;
+
+	lockdep_assert_held(&ptdev->mmu->as.slots_lock);
+
+	if (!vm)
+		return false;
+
+	cfg = &io_pgtable_ops_to_pgtable(vm->pgtbl_ops)->cfg;
+	actual_transtab = cfg->arm_lpae_s1_cfg.ttbr;
+	empty_transtab_low = (u32)(actual_transtab + vm->empty_transtab_offset);
+	cur_transtab_low = gpu_read(mmu->iomem, AS_TRANSTAB(as));
+
+	if (cur_transtab_low != empty_transtab_low)
+		return false;
+
+	gpu_write(mmu->iomem, AS_TRANSTAB(as), (u32)actual_transtab);
+	ret = as_send_cmd_and_wait(ptdev, as, AS_COMMAND_UPDATE);
+
+	return ret ? false : true;
+}
+
+static void report_unhandled_as_fault_locked(struct panthor_device *ptdev, u32 as)
+{
+	struct panthor_mmu *mmu = ptdev->mmu;
+	u64 addr;
+	u32 fault_status;
+	u32 exception_type;
+	u32 access_type;
+	u32 source_id;
+
+	lockdep_assert_held(&mmu->as.slots_lock);
+
+	fault_status = gpu_read(mmu->iomem, AS_FAULTSTATUS(as));
+	addr = gpu_read64(mmu->iomem, AS_FAULTADDRESS(as));
+
+	/* decode the fault status */
+	exception_type = fault_status & 0xFF;
+	access_type = (fault_status >> 8) & 0x3;
+	source_id = (fault_status >> 16);
+
+	mmu->as.faulty_mask |= MMU_INT_AS_FAULT(as);
+
+	/* terminal fault, print info about the fault */
+	drm_err(&ptdev->base,
+		"Unhandled Page fault in AS%d at VA 0x%016llX\n"
+		"raw fault status: 0x%X\n"
+		"decoded fault status: %s\n"
+		"exception type 0x%X: %s\n"
+		"access type 0x%X: %s\n"
+		"source id 0x%X\n",
+		as, addr, fault_status,
+		(fault_status & (1 << 10) ? "DECODER FAULT" : "SLAVE FAULT"),
+		exception_type,
+		panthor_exception_name(ptdev, exception_type),
+		access_type,
+		access_type_name(ptdev, fault_status),
+		source_id);
+
+	if (mmu->as.slots[as].vm)
+		mmu->as.slots[as].vm->unhandled_fault = true;
+
+	/* Disable the MMU to kill jobs on this AS. */
+	panthor_mmu_as_disable(ptdev, as);
+}
+
 static void panthor_mmu_irq_handler(struct panthor_irq *pirq, u32 status)
 {
 	struct panthor_device *ptdev = pirq->ptdev;
@@ -1857,55 +2010,19 @@ static void panthor_mmu_irq_handler(struct panthor_irq *pirq, u32 status)
 	while (status) {
 		u32 as = ffs(status | (status >> 16)) - 1;
 		u32 mask = MMU_INT_AS_FAULT(as);
-		u64 addr;
-		u32 fault_status;
-		u32 exception_type;
-		u32 access_type;
-		u32 source_id;
-
-		fault_status = gpu_read(mmu->iomem, AS_FAULTSTATUS(as));
-		addr = gpu_read64(mmu->iomem, AS_FAULTADDRESS(as));
-
-		/* decode the fault status */
-		exception_type = fault_status & 0xFF;
-		access_type = (fault_status >> 8) & 0x3;
-		source_id = (fault_status >> 16);
-
-		mutex_lock(&ptdev->mmu->as.slots_lock);
-
-		ptdev->mmu->as.faulty_mask |= mask;
-
-		/* terminal fault, print info about the fault */
-		drm_err(&ptdev->base,
-			"Unhandled Page fault in AS%d at VA 0x%016llX\n"
-			"raw fault status: 0x%X\n"
-			"decoded fault status: %s\n"
-			"exception type 0x%X: %s\n"
-			"access type 0x%X: %s\n"
-			"source id 0x%X\n",
-			as, addr,
-			fault_status,
-			(fault_status & (1 << 10) ? "DECODER FAULT" : "SLAVE FAULT"),
-			exception_type, panthor_exception_name(ptdev, exception_type),
-			access_type, access_type_name(ptdev, fault_status),
-			source_id);
-
-		/* We don't handle VM faults at the moment, so let's just clear the
-		 * interrupt and let the writer/reader crash.
-		 * Note that COMPLETED irqs are never cleared, but this is fine
-		 * because they are always masked.
-		 */
-		gpu_write(mmu->irq.iomem, INT_CLEAR, mask);
 
-		if (ptdev->mmu->as.slots[as].vm)
-			ptdev->mmu->as.slots[as].vm->unhandled_fault = true;
+		mutex_lock(&mmu->as.slots_lock);
+
+		if (!handle_as_fault_locked(ptdev, as)) {
+			report_unhandled_as_fault_locked(ptdev, as);
+			has_unhandled_faults = true;
+		}
+
+		gpu_write(mmu->irq.iomem, INT_CLEAR, mask);
 
-		/* Disable the MMU to kill jobs on this AS. */
-		panthor_mmu_as_disable(ptdev, as);
-		mutex_unlock(&ptdev->mmu->as.slots_lock);
+		mutex_unlock(&mmu->as.slots_lock);
 
 		status &= ~mask;
-		has_unhandled_faults = true;
 	}
 
 	if (has_unhandled_faults)
@@ -2563,12 +2680,55 @@ static struct panthor_vma *select_evicted_vma(struct drm_gpuvm_bo *vm_bo,
 	return first_evicted_vma;
 }
 
+static int remap_evicted_vma_locked(struct panthor_vm *vm,
+				    struct panthor_vma *evicted_vma,
+				    struct panthor_vm_op_ctx *op_ctx)
+{
+	struct panthor_gem_object *bo =
+		to_panthor_bo(evicted_vma->base.gem.obj);
+	int ret;
+
+	lockdep_assert_held(&vm->op_lock);
+
+	scoped_cond_guard(protm_block_timeout, ret = -ETIMEDOUT, vm)
+	{
+		vm->op_ctx = op_ctx;
+
+		ret = panthor_vm_lock_region(vm, evicted_vma->base.va.addr,
+					     evicted_vma->base.va.range);
+		if (!ret) {
+			struct drm_gpuva_op_map map_op = {
+				.va.addr = evicted_vma->base.va.addr,
+				.va.range = evicted_vma->base.va.range,
+				.gem.obj = &bo->base,
+				.gem.offset = evicted_vma->base.gem.offset,
+			};
+			if (evicted_vma->flags &
+			    DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE)
+				drm_WARN_ON_ONCE(&vm->ptdev->base,
+						 map_op.gem.offset !=
+							 (map_op.va.addr &
+							  (SZ_2M - 1)));
+
+			ret = panthor_vm_exec_map_op(vm, evicted_vma->flags,
+						     &map_op);
+			if (!ret)
+				evicted_vma->evicted = false;
+
+			panthor_vm_unlock_region(vm);
+		}
+
+		vm->op_ctx = NULL;
+	}
+
+	return ret;
+}
+
 static int remap_evicted_vma(struct drm_gpuvm_bo *vm_bo,
 			     struct panthor_vma *evicted_vma,
 			     struct panthor_vm_op_ctx *op_ctx)
 {
 	struct panthor_vm *vm = container_of(vm_bo->vm, struct panthor_vm, base);
-	struct panthor_gem_object *bo = to_panthor_bo(vm_bo->obj);
 	struct drm_gpuva *va;
 	bool found = false;
 	int ret;
@@ -2601,31 +2761,12 @@ static int remap_evicted_vma(struct drm_gpuvm_bo *vm_bo,
 		break;
 	}
 
-	if (found) {
-		vm->op_ctx = op_ctx;
-		ret = panthor_vm_lock_region(vm, evicted_vma->base.va.addr,
-					     evicted_vma->base.va.range);
-		if (!ret) {
-			struct drm_gpuva_op_map map_op = {
-				.va.addr = evicted_vma->base.va.addr,
-				.va.range = evicted_vma->base.va.range,
-				.gem.obj = &bo->base,
-				.gem.offset = evicted_vma->base.gem.offset,
-			};
-			if (evicted_vma->flags & DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE)
-				drm_WARN_ON_ONCE(&vm->ptdev->base, map_op.gem.offset !=
-						 (map_op.va.addr & (SZ_2M - 1)));
-
-			ret = panthor_vm_exec_map_op(vm, evicted_vma->flags, &map_op);
-			if (!ret)
-				evicted_vma->evicted = false;
-
-			panthor_vm_unlock_region(vm);
-		}
+	if (!found)
+		goto out_unlock;
 
-		vm->op_ctx = NULL;
-	}
+	ret = remap_evicted_vma_locked(vm, evicted_vma, op_ctx);
 
+out_unlock:
 	mutex_unlock(&vm->op_lock);
 
 out_cleanup:
@@ -2716,39 +2857,42 @@ panthor_vm_exec_op(struct panthor_vm *vm, struct panthor_vm_op_ctx *op,
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
@@ -3558,3 +3702,18 @@ void panthor_mmu_pt_cache_fini(void)
 {
 	kmem_cache_destroy(pt_cache);
 }
+
+bool panthor_vm_for_mcu(struct panthor_vm *vm)
+{
+	return vm->for_mcu;
+}
+
+void panthor_vm_protm_enter(struct panthor_vm *vm)
+{
+	panthor_vm_stop(vm);
+}
+
+void panthor_vm_protm_exit(struct panthor_vm *vm)
+{
+	panthor_vm_start(vm);
+}
diff --git a/drivers/gpu/drm/panthor/panthor_mmu.h b/drivers/gpu/drm/panthor/panthor_mmu.h
index e262fe2303f6c..a6ff21d9a0201 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.h
+++ b/drivers/gpu/drm/panthor/panthor_mmu.h
@@ -106,6 +106,11 @@ void panthor_vm_update_resvs(struct panthor_vm *vm, struct drm_exec *exec,
 int panthor_mmu_pt_cache_init(void);
 void panthor_mmu_pt_cache_fini(void);
 
+bool panthor_vm_for_mcu(struct panthor_vm *vm);
+
+void panthor_vm_protm_enter(struct panthor_vm *vm);
+void panthor_vm_protm_exit(struct panthor_vm *vm);
+
 #ifdef CONFIG_DEBUG_FS
 void panthor_mmu_debugfs_init(struct drm_minor *minor);
 #endif
diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index e67fd0fe20144..ca6aa6a55661a 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -307,6 +307,44 @@ struct panthor_scheduler {
 		 */
 		struct list_head stopped_groups;
 	} reset;
+
+	/** @protm: Protected mode related fields. */
+	struct {
+		/**
+		 * @protm.lock: Lock for the protected mode state (active_group)
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
+		 * This is done by calling panthor_sched_protm_block_timeout().
+		 *
+		 * Once the MMU operations have completed, call
+		 * panthor_sched_protm_unblock() to tell the scheduler that
+		 * it is safe to enter protected mode again.
+		 */
+		struct rw_semaphore lock;
+
+		/**
+		 * @protm.active_group: The active protected group.
+		 *
+		 * We only allow one protected group to run at the same time,
+		 * as it makes it easier to handle faults in protected mode.
+		 *
+		 * If the active_group member is set, then the scheduler
+		 * believes the GPU is in protected mode. If not set, then the
+		 * GPU is for sure not in normal mode.
+		 */
+		struct panthor_group *active_group;
+	} protm;
 };
 
 /**
@@ -571,6 +609,16 @@ struct panthor_group {
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
 
@@ -1154,8 +1202,9 @@ cs_slot_reset_locked(struct panthor_device *ptdev, u32 csg_id, u32 cs_id)
 	lockdep_assert_held(&ptdev->scheduler->lock);
 
 	panthor_fw_update_reqs(cs_iface, req,
-			       CS_STATE_STOP,
-			       CS_STATE_MASK);
+			       CS_STATE_STOP |
+			       (cs_iface->output->ack & CS_PROTM_PENDING),
+			       CS_STATE_MASK | CS_PROTM_PENDING);
 
 	queue_suspend_timeout(queue);
 
@@ -1394,6 +1443,27 @@ csg_slot_prog_locked(struct panthor_device *ptdev, u32 csg_id, u32 priority)
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
@@ -1642,6 +1712,9 @@ static bool cs_slot_process_irq_locked(struct panthor_device *ptdev,
 	if (events & CS_TILER_OOM)
 		cs_slot_process_tiler_oom_event_locked(ptdev, csg_id, cs_id);
 
+	if (events & CS_PROTM_PENDING)
+		cs_slot_process_protm_pending_event_locked(ptdev, csg_id, cs_id);
+
 	/* We don't acknowledge the TILER_OOM event since its handling is
 	 * deferred to a separate work.
 	 */
@@ -1856,6 +1929,30 @@ static void sched_process_idle_event_locked(struct panthor_device *ptdev)
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
@@ -1871,6 +1968,9 @@ static void sched_process_global_irq_locked(struct panthor_device *ptdev)
 	ack = READ_ONCE(glb_iface->output->ack);
 	evts = (req ^ ack) & GLB_EVT_MASK;
 
+	if (evts & GLB_PROTM_EXIT)
+		sched_process_protm_exit_event_locked(ptdev);
+
 	if (evts & GLB_IDLE)
 		sched_process_idle_event_locked(ptdev);
 }
@@ -1882,22 +1982,22 @@ static void sched_process_global_irq_locked(struct panthor_device *ptdev)
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
@@ -1983,6 +2083,66 @@ group_unbind_locked(struct panthor_group *group)
 	return 0;
 }
 
+static void handle_protm_fault(struct panthor_device *ptdev)
+{
+	struct panthor_scheduler *sched = ptdev->scheduler;
+	u32 csg_id;
+	struct panthor_group *protm_group;
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
@@ -2012,6 +2172,12 @@ static void csgs_upd_ctx_init(struct panthor_csg_slots_upd_ctx *ctx)
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
@@ -2022,7 +2188,8 @@ static void csgs_upd_ctx_queue_reqs(struct panthor_device *ptdev,
 
 	ctx->requests[csg_id].value = (ctx->requests[csg_id].value & ~mask) | (value & mask);
 	ctx->requests[csg_id].mask |= mask;
-	ctx->update_mask |= BIT(csg_id);
+
+	csgs_upd_ctx_ring_doorbell(ctx, csg_id);
 }
 
 static int csgs_upd_ctx_apply_locked(struct panthor_device *ptdev,
@@ -2039,8 +2206,12 @@ static int csgs_upd_ctx_apply_locked(struct panthor_device *ptdev,
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
@@ -2057,6 +2228,9 @@ static int csgs_upd_ctx_apply_locked(struct panthor_device *ptdev,
 		int ret;
 
 		update_slots &= ~BIT(csg_id);
+		if (!req_mask)
+			continue;
+
 		csg_iface = panthor_fw_get_csg_iface(ptdev, csg_id);
 
 		ret = panthor_fw_csg_wait_acks(ptdev, csg_id, req_mask, &acked, 100);
@@ -2093,6 +2267,7 @@ struct panthor_sched_tick_ctx {
 	bool immediate_tick;
 	bool stop_tick;
 	u32 csg_upd_failed_mask;
+	struct panthor_group *protm_group;
 };
 
 static bool
@@ -2134,6 +2309,13 @@ tick_ctx_pick_groups_from_list(const struct panthor_scheduler *sched,
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
@@ -2292,6 +2474,55 @@ static void group_term_work(struct work_struct *work)
 	group_put(group);
 }
 
+enum protm_block_result
+panthor_sched_protm_block_timeout(struct panthor_device *ptdev,
+				  struct panthor_vm *vm)
+{
+	struct panthor_scheduler *sched = ptdev->scheduler;
+	int ret;
+
+	if (!sched)
+		return PROTM_BLOCK_NORMAL;
+
+	down_read(&sched->protm.lock);
+
+	if (!sched->protm.active_group)
+		return PROTM_BLOCK_NORMAL; /* All good, we are in normal mode */
+
+	/* We will only exit protected mode for the passed vm and the MCU VM.
+	 * Other VMs have no active CSG work, so MMU updates can proceed,
+	 * although with special caution (delayed updates)!
+	 */
+	if (sched->protm.active_group->vm != vm && !panthor_vm_for_mcu(vm))
+		return PROTM_BLOCK_DORMANT; /* Specified VM can proceed, with caution. */
+
+	/* Give GPU a chance to finish ongoing protm work by itself */
+	ret = panthor_fw_protm_exit_wait(ptdev, 5);
+	if (!ret)
+		return PROTM_BLOCK_NORMAL; /* All good, we are back to normal mode */
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
+	return ret ? PROTM_BLOCK_ERROR : PROTM_BLOCK_NORMAL;
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
@@ -2419,6 +2650,41 @@ tick_ctx_schedule_group(struct panthor_scheduler *sched,
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
@@ -2488,6 +2754,9 @@ tick_ctx_apply(struct panthor_scheduler *sched, struct panthor_sched_tick_ctx *c
 		}
 	}
 
+	if (ctx->protm_group)
+		tick_ctx_handle_protm_group(sched, &upd_ctx, ctx->protm_group);
+
 	ret = csgs_upd_ctx_apply_locked(ptdev, &upd_ctx);
 	if (ret) {
 		panthor_device_schedule_reset(ptdev);
@@ -2495,6 +2764,23 @@ tick_ctx_apply(struct panthor_scheduler *sched, struct panthor_sched_tick_ctx *c
 		return;
 	}
 
+	if (ctx->protm_group) {
+		down_write(&sched->protm.lock);
+
+		sched->protm.active_group = ctx->protm_group;
+		group_get(sched->protm.active_group);
+
+		panthor_vm_protm_enter(ctx->protm_group->vm);
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
@@ -2531,12 +2817,12 @@ tick_ctx_apply(struct panthor_scheduler *sched, struct panthor_sched_tick_ctx *c
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
@@ -2552,6 +2838,38 @@ tick_ctx_update_resched_target(struct panthor_scheduler *sched,
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
@@ -2584,6 +2902,54 @@ static void tick_work(struct work_struct *work)
 	if (panthor_device_reset_is_pending(sched->ptdev))
 		goto out_unlock;
 
+	/* If we exited protm since last tick, then deal with that first */
+	if (sched->protm.active_group) {
+		bool protm = atomic64_read(&ptdev->protm.protm_exit_count) !=
+			     atomic64_read(&ptdev->protm.protm_enter_count);
+		if (!protm) {
+			/* No longer in protected mode, clear active_group */
+			down_write(&sched->protm.lock);
+			panthor_vm_protm_exit(sched->protm.active_group->vm);
+			group_put(sched->protm.active_group);
+			sched->protm.active_group = NULL;
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
@@ -2635,14 +3001,30 @@ static void tick_work(struct work_struct *work)
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
+	if (ctx.protm_group) {
+		/* Pick only idle groups with equal or lower priority than the
+		 * group triggering protected mode. Do not bother picking
+		 * unscheduled idle groups.
+		 */
+		for (prio = ctx.protm_group->priority;
+		     prio >= 0 && !tick_ctx_is_full(sched, &ctx); prio--) {
+			tick_ctx_pick_groups_from_list(sched, &ctx,
+						       &ctx.old_groups[prio],
+						       false, true);
+		}
+	} else {
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
@@ -2664,7 +3046,7 @@ static void tick_work(struct work_struct *work)
 	}
 
 	sched->last_tick = now;
-	resched_delay = tick_ctx_update_resched_target(sched, &ctx);
+	resched_delay = tick_update_resched_target(sched, ctx.stop_tick);
 	if (ctx.immediate_tick)
 		resched_delay = 0;
 
@@ -3069,6 +3451,8 @@ void panthor_sched_pre_reset(struct panthor_device *ptdev)
 	cancel_work_sync(&sched->sync_upd_work);
 	cancel_delayed_work_sync(&sched->tick_work);
 
+	handle_protm_fault(ptdev);
+
 	panthor_sched_suspend(ptdev);
 
 	/* Stop all groups that might still accept jobs, so we don't get passed
@@ -3094,6 +3478,13 @@ void panthor_sched_post_reset(struct panthor_device *ptdev, bool reset_failed)
 
 	mutex_lock(&sched->reset.lock);
 
+	down_write(&sched->protm.lock);
+	if (sched->protm.active_group) {
+		group_put(sched->protm.active_group);
+		sched->protm.active_group = NULL;
+	}
+	up_write(&sched->protm.lock);
+
 	list_for_each_entry_safe(group, group_tmp, &sched->reset.stopped_groups, run_node) {
 		/* Consider all previously running group as terminated if the
 		 * reset failed.
@@ -4170,6 +4561,7 @@ int panthor_sched_init(struct panthor_device *ptdev)
 	INIT_WORK(&sched->sync_upd_work, sync_upd_work);
 
 	spin_lock_init(&sched->events_lock);
+	init_rwsem(&sched->protm.lock);
 
 	ret = drmm_mutex_init(&ptdev->base, &sched->lock);
 	if (ret)
diff --git a/drivers/gpu/drm/panthor/panthor_sched.h b/drivers/gpu/drm/panthor/panthor_sched.h
index c509fcb5a0c9c..91c4277f1e551 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.h
+++ b/drivers/gpu/drm/panthor/panthor_sched.h
@@ -53,6 +53,22 @@ void panthor_sched_report_fw_events(struct panthor_device *ptdev, u32 events);
 
 void panthor_fdinfo_gather_group_samples(struct drm_file *file);
 
+enum protm_block_result {
+	/* GPU is currently, and will stay, in normal mode */
+	PROTM_BLOCK_NORMAL,
+
+	/* GPU might be in protected mode serving another vm */
+	PROTM_BLOCK_DORMANT,
+
+	/* GPU error */
+	PROTM_BLOCK_ERROR
+};
+
+enum protm_block_result
+panthor_sched_protm_block_timeout(struct panthor_device *ptdev,
+				  struct panthor_vm *vm);
+void panthor_sched_protm_unblock(struct panthor_device *ptdev);
+
 #ifdef CONFIG_DEBUG_FS
 void panthor_sched_debugfs_init(struct drm_minor *minor);
 #endif
-- 
2.43.0

