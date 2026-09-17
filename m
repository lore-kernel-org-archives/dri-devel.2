Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E628CC88E75
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 07:10:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1A4210E52F;
	Fri, 18 Sep 2026 07:10:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XcknQWAq";
	dkim-atps=neutral
Received: from mail-vs2-f42.google.com (mail-vs2-f42.google.com
 [74.125.227.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC16110E474
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 16:36:06 +0000 (UTC)
Received: by mail-vs2-f42.google.com with SMTP id
 71dfb90a1353d-5c67e4d8d8aso616740e0c.1
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 09:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789662966; x=1790267766; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cy4JBzcYgTlVJ3CCegt21X3nFCpon3tLTKb2Uir12HE=;
 b=XcknQWAqkzVqjx8uQPL8U3YoqoagKoUSjhsLvB2UhluIXga8obmc7jf9xspJtiabRy
 hYCyUx8ZdJf9bMx0l+h8IvTTENu/aJPEhopZjxZ+SP0rL/klT2E4S50WCtZAmdlqK1e4
 yJVra0IAaGJp6xqPOGXm0QbGlNQKTQLIBC20zsSi3eQugWishUp4KnYqApB3s9Cu9R6h
 AiJH9avpGzVKn2G3pLTZBMONphVz6Lf5XtW/SsrC8qg91P9INJ6xmUyR53+hMZmRAurR
 p+bCWNFgIT2utyvNQ3+b2wypbDIErXiuDiKA+9plep7yqfdFjwQV06V4dNkQbDNntDgI
 /2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789662966; x=1790267766;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cy4JBzcYgTlVJ3CCegt21X3nFCpon3tLTKb2Uir12HE=;
 b=VPuja4WLb39EvVAMMiPHmvU0QYAoN3Ki66D3U+3Z7mDkpauegdeYRWsxAsPIOp4w0W
 Vbr6EC61uyGTKs4uS7IooGtHTvPsXHJrhx+mHHvaUQ/Vx+K/ZtfWC8+KgdAeJCXbHPAD
 chImXrop1fMV01jgh3ds/CYnKpuY9oIV6xHSfJWof4NK2Wdi+KRv0+8A9FHkULnApMvR
 uyiWTz3Xop7tDiTeBPcOY/gTZf+FMfIRkZVtj1ozA7RKnTwrbOKxB32Rkq0ZyOI0oeiq
 qKPaTjBEZM0qZ3V8LbORkPKlTcEhe0Hm0bG/lTeaD9U1OC8pNIet4sgoI0hKiOPrvywR
 CXcg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzR+fLbMiZKy7Fj8tMmnfGbsOjwlXivkRyR/NSUIppCEx791q8tuSY8Cu42UX56Gw6GLrdAQwjOBh8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m2ydmXsk2Ps6ipZswawHH5VqUsk8yUQYOlBHM5V+aInWeVzuay
 YQCye0i4TFYUna4F//G4hKSfWToknAqQfJ4r89K9TMAIuylhATAR1jl9
X-Gm-Gg: AYBFou3UJCemw0cpKJMPFMg7mmgAZB6tM0XMqe2HnLAqrWttdegncjEnSBaLlDnFGmW
 GG58U3f4XuTXdyujL3sC4+jSPhWTK7/YQBKExqed0VtVVPjYUgKu3Xn7s1f0t+A1t8Casm5y54+
 zP32+w4d4TzIJpsrSREgtTQBwc20VpOlAdBTn3sQQajKdMDZrZB+SQ6dOjnW2KNRuH55ynA3/vB
 rwUTa9Wqj/MZerJ2pXuWfrMZp6NPuZtfkYGXTW5QHQrOTCzsUMSOBTaPnd2AavNz3f4E/XW/KJ3
 8hkdB9FKhTfRkJZSMprKZUVX6/ei1y4em5djBZHbfbDujKpjQ+u8J0rROHSpHifMwHJh+DbMC/A
 7Q0ewhET1H8wneyS/yURF977IocrBF3phYauFhN5jcRbbJz3ywDDW9ZmV3w6T/c0G4X/5tmETcX
 JZUc+I9AEbBJPYmL+ahKzh1sYggv7AwSjbAFXyLknDaHaLbh/7dE5FXMtH7SLEfG7gFMSLUeBRR
 yTWyZuqbRwzfZ5rlEQlK8asCVAJM7vfVUSHtm7mhdLATko=
X-Received: by 2002:a05:6122:3a07:b0:5c9:a60c:2731 with SMTP id
 71dfb90a1353d-5c9a62dd8ddmr1314560e0c.9.1789662965694; 
 Thu, 17 Sep 2026 09:36:05 -0700 (PDT)
Received: from lord ([170.246.209.50]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5c9a53b2ba1sm3065363e0c.8.2026.09.17.09.36.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 09:36:05 -0700 (PDT)
From: =?UTF-8?q?Tales=20A=2E=20Mendon=C3=A7a?= <talesam@gmail.com>
To: intel-xe@lists.freedesktop.org
Cc: matthew.brost@intel.com, daniele.ceraolospurio@intel.com,
 stuart.summers@intel.com, julia.filipchuk@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com,
 jani.nikula@intel.com, navonjohnlukose@gmail.com,
 dri-devel@lists.freedesktop.org,
 =?UTF-8?q?Tales=20A=2E=20Mendon=C3=A7a?= <talesam@gmail.com>
Subject: [PATCH v4 1/3] drm/xe: Capture devcoredump on TLB invalidation timeout
Date: Thu, 17 Sep 2026 13:35:51 -0300
Message-ID: <20260917163553.1742580-2-talesam@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260917163553.1742580-1-talesam@gmail.com>
References: <20260917163553.1742580-1-talesam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 18 Sep 2026 07:10:00 +0000
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
index 7c3bf32d925..7a0c04fac60 100644
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

