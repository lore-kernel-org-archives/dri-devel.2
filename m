Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 425B1C5DF66
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 09:43:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FD8E10F274;
	Thu, 13 Aug 2026 09:43:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ext4X+Rv";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2923610E49D
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 02:30:35 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2cf27856f9cso16850425ad.2
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 19:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786588235; x=1787193035; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RvrDzxvtZJ0VCPXwNvR8mVfRTwnBXMfxs9QoG31ICbg=;
 b=Ext4X+RvYfp/P84zVTqzCrGX+QsBgBAG5RGdQYI1AumIEtUqB/oBXS/RYqtuQpOpuT
 bYJhFjsb2SAh52gECvdTgLgPHoNPP+UUMnvAeYQ2nXN5Gmu4RkWXWT4Jd6xGqoeNhwV1
 66z42kJ0LG4fZ6WmBMgQd4z9e6kdf3TMWhzfcYodCSJ1z9tQBRJtf5/rIcidi6iur/et
 /AiBCUGjWyCuka16ePKDwmM7Zb65WCoRXOUAmkUl+tqa3NmubqWS64RwOFextWjzgH6V
 50jnJ+cjFA1IYJsqSdLb6ZhQAGvyxIg1zvdxuPJdzWuCoe1SBGgOp03vSiU70pWoQ3KE
 Kx8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786588235; x=1787193035;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RvrDzxvtZJ0VCPXwNvR8mVfRTwnBXMfxs9QoG31ICbg=;
 b=OoI+sKB3tS7k4mIa83FpdKgSxhNZcHlwuuNGFvK2r0u8pbjw8lYHwyhKSc+j/LrXMz
 VFq7Q35ldfu/bei39bjzBrFnAmujNbqL+2jo4kJJuk1Zfu/n7LVVDrDuI5gg3BkWx8va
 MMNxH7iQjPqZ86voa5HtpM2/zxj6Ozqd+52hc+X3db8vFp0S7fs3z54MUW8qsU8eTyJb
 qlDGoUNmb59xip9XbNfn2X6wwJiOtumfI5F4+7dZ3LEMRh20VscLXpBVEEpA06UFkuMV
 cThdiiXHNZgboPQPFuemfO5Ep2vBYkwROSJz7o6vkp17DDymIpwUPmft9R8rOkj7GRUa
 CsUQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpQ3d/49et0Rk3j9d+2vu+iEMkAevoG9LyL46iIAoyDvyEe669AmosljlreF2nprN/2t4wJNnyHKA4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyJ702fSpMZ/mFdqyJoEBfvOuouVPcg9mAXLS09FmrEaSWaH4fK
 QelE6Ndqh0bnxjlCDC3f/QZhvr1Y6DZEqOiCfurebbLWVM5QtbGsKxiZ
X-Gm-Gg: AR+sD133ZAGoPlikDRoLDOQf3mEawPKXJxLUKvFadfpPU8/7LDNT5LdCm/d5jiXDVEQ
 8CML8iyGJFODSqxTERBwa9r8CP/2zhbxeD10kgFXud9dS+m/TZs97AK+t5lO0CdilvXWXAlPSy/
 wxDxV0geK/P/uxXUSxUpzXEYhrv+KBitvD1mY4rkcI/SNRUYoN8LqjdxVx6miRcZLTdWO7p3yCg
 xsmFN+cxjUpd0bDCrs/Un2Yt89q2O5vc6BAmf/EA3+i1DOT5DkcKLKU+z16AG6rfp1g4PA2N1gE
 KKkoOJ4AxyJYJmVMgAbH0yp2s2I2OXmWBKpCPy9D7ypwxY8Y4FkQcn3JXEeyrZaXT5yMz3xTKfF
 zsPgBQTx2IgFzkf77EnlVvjBobovzHaqVNv1Jaf5HhwRq6stFDHhbjsuFetOxdu+43Mtn/AW5/8
 hdvKutpSPBKzfPQRtfI2+CcF/VzvuF84GtzBSsCPsBraqmY86ZyGWYfJd5Vfj0wwtT8IYX4kfH8
 cbVLDCed3CEO+wvRPwCeeJqUqsz/4fS1csnmCKsi5f88sKPYDOOtdzz
X-Received: by 2002:a05:6a21:3204:b0:3c0:b943:f984 with SMTP id
 adf61e73a8af0-3cc54f31ac2mr3855446637.3.1786588234398; 
 Wed, 12 Aug 2026 19:30:34 -0700 (PDT)
Received: from lord.bigscale.net ([170.246.208.200])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31ebf731f95sm1950053eec.15.2026.08.12.19.30.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 19:30:33 -0700 (PDT)
From: =?UTF-8?q?Tales=20A=2E=20Mendon=C3=A7a?= <talesam@gmail.com>
To: intel-xe@lists.freedesktop.org
Cc: matthew.brost@intel.com, daniele.ceraolospurio@intel.com,
 stuart.summers@intel.com, julia.filipchuk@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com,
 dri-devel@lists.freedesktop.org,
 =?UTF-8?q?Tales=20A=2E=20Mendon=C3=A7a?= <talesam@gmail.com>
Subject: [PATCH v2 1/3] drm/xe: Capture devcoredump on TLB invalidation timeout
Date: Wed, 12 Aug 2026 23:30:14 -0300
Message-ID: <20260813023016.805573-2-talesam@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813023016.805573-1-talesam@gmail.com>
References: <20260813023016.805573-1-talesam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 13 Aug 2026 09:42:01 +0000
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

TLB invalidation timeouts currently leave no record of the firmware
state behind: there is no exec queue or job to blame, so nothing calls
xe_devcoredump() and the GuC log content at the time of the hang is
lost.

Add xe_devcoredump_gt(), a variant of xe_devcoredump() for hangs that
are not tied to an exec queue or job. It captures the GuC log and CT
state of the affected GT, reusing the existing snapshot machinery and
the "only first snapshot" policy, and hook it up to the TLB invalidation
timeout path.

This was instrumental in diagnosing GuC TLB invalidation ack stalls on
ARL (see Link), where the invalidation request is consumed from the H2G
CTB immediately but the ack G2H only arrives ~2.3s later, after the
timeout has already fired.

Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8678
Signed-off-by: Tales A. Mendonça <talesam@gmail.com>
---
 drivers/gpu/drm/xe/xe_devcoredump.c | 46 ++++++++++++++++-------------
 drivers/gpu/drm/xe/xe_devcoredump.h | 15 +++++++---
 drivers/gpu/drm/xe/xe_tlb_inval.c   | 20 +++++++++++++
 3 files changed, 56 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_devcoredump.c b/drivers/gpu/drm/xe/xe_devcoredump.c
index 5f2b90b18f9..6bee8933f95 100644
--- a/drivers/gpu/drm/xe/xe_devcoredump.c
+++ b/drivers/gpu/drm/xe/xe_devcoredump.c
@@ -74,11 +74,6 @@ static struct xe_device *coredump_to_xe(const struct xe_devcoredump *coredump)
 	return container_of(coredump, struct xe_device, devcoredump);
 }
 
-static struct xe_guc *exec_queue_to_guc(struct xe_exec_queue *q)
-{
-	return &q->gt->uc.guc;
-}
-
 static ssize_t __xe_devcoredump_read(char *buffer, ssize_t count,
 				     ssize_t start,
 				     struct xe_devcoredump *coredump)
@@ -323,40 +318,44 @@ static void xe_devcoredump_deferred_snap_work(struct work_struct *work)
 }
 
 static void devcoredump_snapshot(struct xe_devcoredump *coredump,
+				 struct xe_gt *gt,
 				 struct xe_exec_queue *q,
 				 struct xe_sched_job *job)
 {
 	struct xe_devcoredump_snapshot *ss = &coredump->snapshot;
-	struct xe_guc *guc = exec_queue_to_guc(q);
+	struct xe_guc *guc = &gt->uc.guc;
 	const char *process_name = "no process";
 	bool cookie;
 
 	ss->snapshot_time = ktime_get_real();
 	ss->boot_time = ktime_get_boottime();
 
-	if (q->vm && q->vm->xef) {
+	if (q && q->vm && q->vm->xef) {
 		process_name = q->vm->xef->process_name;
 		ss->pid = q->vm->xef->pid;
 	}
 
 	strscpy(ss->process_name, process_name);
 
-	ss->gt = q->gt;
+	ss->gt = gt;
 	INIT_WORK(&ss->work, xe_devcoredump_deferred_snap_work);
 
 	/* keep going if fw fails as we still want to save the memory and SW data */
-	CLASS(xe_force_wake, fw_ref)(gt_to_fw(q->gt), XE_FORCEWAKE_ALL);
+	CLASS(xe_force_wake, fw_ref)(gt_to_fw(gt), XE_FORCEWAKE_ALL);
 
 	cookie = dma_fence_begin_signalling();
 
 	ss->guc.log = xe_guc_log_snapshot_capture(&guc->log, true);
 	ss->guc.ct = xe_guc_ct_snapshot_capture(&guc->ct);
-	ss->ge = xe_guc_exec_queue_snapshot_capture(q);
-	if (job)
-		ss->job = xe_sched_job_snapshot_capture(job);
-	ss->vm = xe_vm_snapshot_capture(q->vm);
 
-	xe_engine_snapshot_capture_for_queue(q);
+	if (q) {
+		ss->ge = xe_guc_exec_queue_snapshot_capture(q);
+		if (job)
+			ss->job = xe_sched_job_snapshot_capture(job);
+		ss->vm = xe_vm_snapshot_capture(q->vm);
+
+		xe_engine_snapshot_capture_for_queue(q);
+	}
 
 	queue_work(system_dfl_wq, &ss->work);
 
@@ -364,19 +363,24 @@ static void devcoredump_snapshot(struct xe_devcoredump *coredump,
 }
 
 /**
- * xe_devcoredump - Take the required snapshots and initialize coredump device.
- * @q: The faulty xe_exec_queue, where the issue was detected.
- * @job: The faulty xe_sched_job, where the issue was detected.
+ * __xe_devcoredump - Take the required snapshots and initialize coredump device.
+ * @gt: The GT where the issue was detected.
+ * @q: The faulty xe_exec_queue, where the issue was detected, may be NULL for
+ *     hangs that are not tied to an exec queue (e.g. TLB invalidation
+ *     timeouts); in that case only the GT-level state (GuC log and CT state)
+ *     is captured.
+ * @job: The faulty xe_sched_job, where the issue was detected, may be NULL.
  * @fmt: Printf format + args to describe the reason for the core dump
  *
  * This function should be called at the crash time within the serialized
  * gt_reset. It is skipped if we still have the core dump device available
  * with the information of the 'first' snapshot.
  */
-__printf(3, 4)
-void xe_devcoredump(struct xe_exec_queue *q, struct xe_sched_job *job, const char *fmt, ...)
+__printf(4, 5)
+void __xe_devcoredump(struct xe_gt *gt, struct xe_exec_queue *q,
+		      struct xe_sched_job *job, const char *fmt, ...)
 {
-	struct xe_device *xe = gt_to_xe(q->gt);
+	struct xe_device *xe = gt_to_xe(gt);
 	struct xe_devcoredump *coredump = &xe->devcoredump;
 	va_list varg;
 
@@ -394,7 +398,7 @@ void xe_devcoredump(struct xe_exec_queue *q, struct xe_sched_job *job, const cha
 	coredump->snapshot.reason = kvasprintf(GFP_ATOMIC, fmt, varg);
 	va_end(varg);
 
-	devcoredump_snapshot(coredump, q, job);
+	devcoredump_snapshot(coredump, gt, q, job);
 
 	drm_info(&xe->drm, "Xe device coredump has been created\n");
 	drm_info(&xe->drm, "Check your /sys/class/drm/card%d/device/devcoredump/data\n",
diff --git a/drivers/gpu/drm/xe/xe_devcoredump.h b/drivers/gpu/drm/xe/xe_devcoredump.h
index 5391a80a4d1..bc4800b3a3f 100644
--- a/drivers/gpu/drm/xe/xe_devcoredump.h
+++ b/drivers/gpu/drm/xe/xe_devcoredump.h
@@ -11,15 +11,17 @@
 struct drm_printer;
 struct xe_device;
 struct xe_exec_queue;
+struct xe_gt;
 struct xe_sched_job;
 
 #ifdef CONFIG_DEV_COREDUMP
-void xe_devcoredump(struct xe_exec_queue *q, struct xe_sched_job *job, const char *fmt, ...);
+void __xe_devcoredump(struct xe_gt *gt, struct xe_exec_queue *q,
+		      struct xe_sched_job *job, const char *fmt, ...);
 int xe_devcoredump_init(struct xe_device *xe);
 #else
-static inline void xe_devcoredump(struct xe_exec_queue *q,
-				  struct xe_sched_job *job,
-				  const char *fmt, ...)
+static inline void __xe_devcoredump(struct xe_gt *gt, struct xe_exec_queue *q,
+				    struct xe_sched_job *job,
+				    const char *fmt, ...)
 {
 }
 
@@ -29,6 +31,11 @@ static inline int xe_devcoredump_init(struct xe_device *xe)
 }
 #endif
 
+#define xe_devcoredump(_q, _job, _fmt, ...) \
+	__xe_devcoredump((_q)->gt, _q, _job, _fmt, ##__VA_ARGS__)
+#define xe_devcoredump_gt(_gt, _fmt, ...) \
+	__xe_devcoredump(_gt, NULL, NULL, _fmt, ##__VA_ARGS__)
+
 void xe_print_blob_ascii85(struct drm_printer *p, const char *prefix, char suffix,
 			   const void *blob, size_t offset, size_t size);
 
diff --git a/drivers/gpu/drm/xe/xe_tlb_inval.c b/drivers/gpu/drm/xe/xe_tlb_inval.c
index bbd21d39306..833fb92cd3e 100644
--- a/drivers/gpu/drm/xe/xe_tlb_inval.c
+++ b/drivers/gpu/drm/xe/xe_tlb_inval.c
@@ -5,6 +5,7 @@
 
 #include <drm/drm_managed.h>
 
+#include "xe_devcoredump.h"
 #include "xe_device_types.h"
 #include "xe_force_wake.h"
 #include "xe_gt_stats.h"
@@ -29,6 +30,12 @@
 
 #define FENCE_STACK_BIT		DMA_FENCE_FLAG_USER_BITS
 
+/* The frontend is only ever embedded in a GT */
+static struct xe_gt *tlb_inval_to_gt(struct xe_tlb_inval *tlb_inval)
+{
+	return container_of(tlb_inval, struct xe_gt, tlb_inval);
+}
+
 static void xe_tlb_inval_fence_fini(struct xe_tlb_inval_fence *fence)
 {
 	if (WARN_ON_ONCE(!fence->tlb_inval))
@@ -73,6 +80,7 @@ static void xe_tlb_inval_fence_timeout(struct work_struct *work)
 	struct xe_device *xe = tlb_inval->xe;
 	struct xe_tlb_inval_fence *fence, *next;
 	long timeout_delay = tlb_inval->ops->timeout_delay(tlb_inval);
+	int timedout_seqno = 0;
 
 	tlb_inval->ops->flush(tlb_inval);
 
@@ -90,6 +98,8 @@ static void xe_tlb_inval_fence_timeout(struct work_struct *work)
 			"TLB invalidation fence timeout, seqno=%d recv=%d",
 			fence->seqno, tlb_inval->seqno_recv);
 
+		timedout_seqno = fence->seqno;
+
 		fence->base.error = -ETIME;
 		xe_tlb_inval_fence_signal(fence);
 	}
@@ -97,6 +107,16 @@ static void xe_tlb_inval_fence_timeout(struct work_struct *work)
 		queue_delayed_work(tlb_inval->timeout_wq, &tlb_inval->fence_tdr,
 				   timeout_delay);
 	spin_unlock_irq(&tlb_inval->pending_lock);
+
+	/*
+	 * Capture the GuC log and CT state so the firmware side of the hang
+	 * can be inspected; there is no queue or job to blame here. Must be
+	 * outside pending_lock as the capture takes sleeping locks.
+	 */
+	if (timedout_seqno)
+		xe_devcoredump_gt(tlb_inval_to_gt(tlb_inval),
+				  "TLB invalidation fence timeout, seqno=%d recv=%d",
+				  timedout_seqno, tlb_inval->seqno_recv);
 }
 
 /**
-- 
2.55.0

