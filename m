Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30469C55ABA
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 07:15:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 341E710E882;
	Tue,  4 Aug 2026 07:15:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CVOQYC61";
	dkim-atps=neutral
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 358FE10E0CB
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 02:14:51 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-848595b338cso5120512b3a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 03 Aug 2026 19:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785809691; x=1786414491; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=77YWyWlpagNTntnUNFo27tzPCpAXJXHsPD/lVPDULrM=;
 b=CVOQYC61U3zALk6DsSM1SvtVkHixmlA7AgUCLjPB1XxYwmJ6OEeiT2G2eXRn1QcDVh
 JLIy7AAYvCCOW8kHbCg1VdB4es8jZjfvrvCYptkszmpBQO6MkgTRREotKuzZA/F95mbp
 x5do9EleVg1uq/GmgNQzwqMIVtSvLBVqz4EmK8rvQV3VZNtILhrzYVkW32ubIUyvXG9U
 1oBFaOIqJmfVYP5L9HAKR3vjUdPDm0GEiAM4mWUw66dMw3oIaEdPm8S+xsbXr9zUW6mu
 lYvJ3LArHuLiimMWUsYF/aPDdPFHK6MhMQ1cF3j8gfIkfA9VMgxjRsOflMwS4ezdK8fH
 n9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785809691; x=1786414491;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=77YWyWlpagNTntnUNFo27tzPCpAXJXHsPD/lVPDULrM=;
 b=l8813rEqY5rpWjAY+hY3fTGRRsorMg3mayanPNaIOVAT+f0cDuNtE4d6pBD7ri1r42
 7b7Grb/p87ePdUeIQl/CSOEq2NTteqtXDyNcXVXxJ5krqAJv9ohC8BRsajiN93PKQZT+
 b/x4DopV8sxEMvqRI+DtElYdaVNDgxHvRe3Qb4o1mOqm5Dej7hpfDy8w9uTIAKXpgK2f
 7xzJxe9oRnHNQZrSSbAknY6bfvdEYJnKkHXqb+41V+Uhspul9G89IQlOwXFjYyvlUt7N
 /2MY7qdSxYUMtAXqXlbfmSxZXtKyo01gspylEhzdJ/UQ20dr4GdATxVRY7fkA0RJZivo
 glyw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpZm4dFn17wA06eFwyEXpFjDX0uSjAmVFzMoshIjup6ghkuc5okd8BjrE4QhsgA0ih14OEueCCVVDk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YypPwVvdWIuCsI0/Cnv516YxrM1JdcJxe29rWfAnkcwPgXbrS0H
 L5rx/YYjbInRlbN8NRCdCx9M7B5ZBxpaDUgc2g/O5dlbe3tq1grm4l+0
X-Gm-Gg: AR+sD10VvDOz3FdER8vvIN+IeQtueQuu/Lj9b2miDHk7B3Kw79WTRdhaW/iG8X+FZG3
 z0dies2/HnvAMi55j8zuxtej7mJcewBy1xnLMesHDbX79Qq11x7tI90uYDLy0sM06/p/1q19jZt
 NIrjRfcU+Wg5I/UsFkX1cguUG5YbggLwikFoNHmfoSo+J1zEZrDFaexxmblH6mfps291l/GjNfh
 aneOLGSb7EJHlRyp8qz38gLMXbFPXgXidHbt3A6IBSBSFkVfgGqZm+XniKOx2xSPOw61Wdt2vaM
 g7FMH7wvb1zQlf1Crj2n4x8svwj8pMINfjJHsOYiT+hBA52fmF8VjlvPhdxcYEdF2+NoI8106rX
 tMUmE3/ampSl1jjfKJT3HVOf8b/58606PPopEAbECrYcckHujFh8bT95uOvz7MA+I/JN+l4CztT
 0QLA5shnA9tvhPteEO4zR9SlqqUiC2EALlQCupTsjsskKdFmA7uvBMx3BprarjfF9/iIz94gTc5
 K/LfROrHPrz8QYabEE3rNgVSf2mUtBkA2Xjsawmv/s+XYgkRQ==
X-Received: by 2002:a05:6a20:3ca2:b0:3c3:9aff:7a46 with SMTP id
 adf61e73a8af0-3c92a5d35b9mr14298418637.32.1785809690686; 
 Mon, 03 Aug 2026 19:14:50 -0700 (PDT)
Received: from lord ([170.246.208.189]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153dd4f0f0sm42267698eec.2.2026.08.03.19.14.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 19:14:50 -0700 (PDT)
From: =?UTF-8?q?Tales=20A=2E=20Mendon=C3=A7a?= <talesam@gmail.com>
To: intel-xe@lists.freedesktop.org
Cc: matthew.brost@intel.com, thomas.hellstrom@linux.intel.com,
 rodrigo.vivi@intel.com, dri-devel@lists.freedesktop.org,
 =?UTF-8?q?Tales=20A=2E=20Mendon=C3=A7a?= <talesam@gmail.com>
Subject: [RFC PATCH 1/3] drm/xe: Capture devcoredump on TLB invalidation
 timeout
Date: Mon,  3 Aug 2026 23:14:39 -0300
Message-ID: <20260804021441.3054424-2-talesam@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260804021441.3054424-1-talesam@gmail.com>
References: <20260804021441.3054424-1-talesam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 04 Aug 2026 07:15:10 +0000
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
 drivers/gpu/drm/xe/xe_devcoredump.c | 68 +++++++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_devcoredump.h |  6 +++
 drivers/gpu/drm/xe/xe_tlb_inval.c   | 20 +++++++++
 3 files changed, 94 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_devcoredump.c b/drivers/gpu/drm/xe/xe_devcoredump.c
index 5f2b90b18f9..0ccaed176a4 100644
--- a/drivers/gpu/drm/xe/xe_devcoredump.c
+++ b/drivers/gpu/drm/xe/xe_devcoredump.c
@@ -403,6 +403,74 @@ void xe_devcoredump(struct xe_exec_queue *q, struct xe_sched_job *job, const cha
 	mutex_unlock(&coredump->lock);
 }
 
+static void devcoredump_snapshot_gt(struct xe_devcoredump *coredump,
+				    struct xe_gt *gt)
+{
+	struct xe_devcoredump_snapshot *ss = &coredump->snapshot;
+	struct xe_guc *guc = &gt->uc.guc;
+	bool cookie;
+
+	ss->snapshot_time = ktime_get_real();
+	ss->boot_time = ktime_get_boottime();
+
+	strscpy(ss->process_name, "no process");
+
+	ss->gt = gt;
+	INIT_WORK(&ss->work, xe_devcoredump_deferred_snap_work);
+
+	/* keep going if fw fails as we still want to save the SW data */
+	CLASS(xe_force_wake, fw_ref)(gt_to_fw(gt), XE_FORCEWAKE_ALL);
+
+	cookie = dma_fence_begin_signalling();
+
+	ss->guc.log = xe_guc_log_snapshot_capture(&guc->log, true);
+	ss->guc.ct = xe_guc_ct_snapshot_capture(&guc->ct);
+
+	queue_work(system_dfl_wq, &ss->work);
+
+	dma_fence_end_signalling(cookie);
+}
+
+/**
+ * xe_devcoredump_gt - Take GT-level snapshots and initialize coredump device.
+ * @gt: The GT where the issue was detected.
+ * @fmt: Printf format + args to describe the reason for the core dump
+ *
+ * Variant of xe_devcoredump() for hangs that are not tied to an exec queue
+ * or job, e.g. TLB invalidation timeouts. Captures the GuC log and CT state
+ * of @gt so the firmware side of the hang can be inspected. Skipped if a
+ * coredump is already captured, same as xe_devcoredump().
+ */
+__printf(2, 3)
+void xe_devcoredump_gt(struct xe_gt *gt, const char *fmt, ...)
+{
+	struct xe_device *xe = gt_to_xe(gt);
+	struct xe_devcoredump *coredump = &xe->devcoredump;
+	va_list varg;
+
+	mutex_lock(&coredump->lock);
+
+	if (coredump->captured) {
+		drm_dbg(&xe->drm, "Multiple hangs are occurring, but only the first snapshot was taken\n");
+		mutex_unlock(&coredump->lock);
+		return;
+	}
+
+	coredump->captured = true;
+
+	va_start(varg, fmt);
+	coredump->snapshot.reason = kvasprintf(GFP_ATOMIC, fmt, varg);
+	va_end(varg);
+
+	devcoredump_snapshot_gt(coredump, gt);
+
+	drm_info(&xe->drm, "Xe device coredump has been created\n");
+	drm_info(&xe->drm, "Check your /sys/class/drm/card%d/device/devcoredump/data\n",
+		 xe->drm.primary->index);
+
+	mutex_unlock(&coredump->lock);
+}
+
 static void xe_driver_devcoredump_fini(void *arg)
 {
 	struct drm_device *drm = arg;
diff --git a/drivers/gpu/drm/xe/xe_devcoredump.h b/drivers/gpu/drm/xe/xe_devcoredump.h
index 5391a80a4d1..f071bd11f24 100644
--- a/drivers/gpu/drm/xe/xe_devcoredump.h
+++ b/drivers/gpu/drm/xe/xe_devcoredump.h
@@ -11,10 +11,12 @@
 struct drm_printer;
 struct xe_device;
 struct xe_exec_queue;
+struct xe_gt;
 struct xe_sched_job;
 
 #ifdef CONFIG_DEV_COREDUMP
 void xe_devcoredump(struct xe_exec_queue *q, struct xe_sched_job *job, const char *fmt, ...);
+void xe_devcoredump_gt(struct xe_gt *gt, const char *fmt, ...);
 int xe_devcoredump_init(struct xe_device *xe);
 #else
 static inline void xe_devcoredump(struct xe_exec_queue *q,
@@ -23,6 +25,10 @@ static inline void xe_devcoredump(struct xe_exec_queue *q,
 {
 }
 
+static inline void xe_devcoredump_gt(struct xe_gt *gt, const char *fmt, ...)
+{
+}
+
 static inline int xe_devcoredump_init(struct xe_device *xe)
 {
 	return 0;
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

