Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AD68C55ABE
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 07:15:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B44C10E889;
	Tue,  4 Aug 2026 07:15:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a9Z3H3Tt";
	dkim-atps=neutral
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B51510E0E0
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 02:14:56 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-848643382fcso3519178b3a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 03 Aug 2026 19:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785809696; x=1786414496; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9MB0UMCnM2+3hlgPNsuT+ZmJq5NXPuSRNqgcWkcgqmc=;
 b=a9Z3H3TtxgUrxgF85vw9oK8+qQnlRPDwqrhAuCTFQdkinjxeCGbBMkIznts4wPk5oZ
 wW3EIFtAdQ/6Ur1XZ4OoJeNfeED7yjZpwI88EQR9muxVIjySCENtGnkGh/sp1aZbEtyX
 hSKIcjeeS/03YlNLSvsIJATwpd4IUOgVXdeOVTou5SKaTU0w2e43GfP2/iw9GB6NqNNj
 0kkeyK4P8fwuiCVRd6hJiLDeIlJaj7n5t1iQsJwvl5MWo7IKICgCf10GzT0ty/F5aKh2
 kw9MBpZeWKyqIb7ywJGl5L/stVO7P2CqqCxuoZxmZho0nZP++xOOezO++lrziDRdcSk7
 Z6Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785809696; x=1786414496;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9MB0UMCnM2+3hlgPNsuT+ZmJq5NXPuSRNqgcWkcgqmc=;
 b=AdHMV3MGaVrm5VQnVkjDza26mH1WArYUP2EBhXLtYEiXBEzBJ8eD1vW12jM+uzhAps
 QP9GGZosAMXTbi+xHn4iAwhsdXPbFceE9rcbvtWOvX4nwxJzqYfhOTcjhaYGKkq7nhzl
 3aZ7vlN5Xh1u3YCkcLNlLubtMEVLMtqekmw8lEbrfrQLzs+QKlHIqBhVCxB7g3gc3twv
 f8ixvAkRL7hKMI7rxmE+uYIMLOOtbqyQ1ryMZzK7tGLcnJWdOeRixFFk+HVPUTFDnhsk
 tmiK3AvBN+DTOA1FsVg0furtxkbIrTwA7/r2T2jgT7apVIRk8ptouuy/XEYa3k3IPxzn
 c5xA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqNP41okgb8OIX7KMGnDuanM7FAD/LgXElFmJwc+zqbifx37RemOFcOykiLAI/z4i7bwUNPFxfbJ20=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwoVNufYH988qCtpYGY01CLXfLkU+g7zpk38xp91+/3G+CeBUac
 vE5hYHFWM39rdMTFDQbLeVx48TTEs8N8FbTWKJE2wFPF3gA5WSCzQUBl
X-Gm-Gg: AR+sD13BZ6H2rdWQvkMzQgNpj3NnNNZjdMFko0bCIq/tJCqjq+odBoDDldzekQS3lyS
 mGsm/jwNXg+9Wm02iU5pTCOIfnYdqj1ZNUhCbquaUHTw9RZeLHMysTSecpoU14f+qwdSeKytO3n
 PqXCs1JsY/MxtaSXFTL0Crxe0kF1k5f1nWwdrhPvmUXJnHZencBp7CPYl0fsmEP4qu01QedoC/o
 lcN/cgC0nHaVspVZj6NdW5UF0TBSUei/QAThBDzA2Sk7Uz6l2BKJLUWjUUb7/evbkpAeBNDVk5F
 idoUxNleXLC2kFvZsyB3Ii8g49K7cq5pcsxYWAAkKWqBqHTxoB7aPIIeXXGUt5lZN9LhY25KbAX
 tI7tA5I1GXo0xpx9BuCL9hJIOtzSnyOKG7tVBB1bjghvDU7rhQUV5pJ8iTVSA2puFwMoow9hbTI
 tYxvGGWnfmLQ1dFgRw9Ag1em/sReGoy+ujBlHaI3MzFRrHo2Bf5Z6u9OzBrKqv78vRtC/If4xz+
 HvkYzd0250LflaM9bf3INnskJSDcKdUm8LLQhI=
X-Received: by 2002:a05:6a20:4387:b0:3c3:ab31:3d2c with SMTP id
 adf61e73a8af0-3c92a8a5d2amr11842109637.35.1785809695600; 
 Mon, 03 Aug 2026 19:14:55 -0700 (PDT)
Received: from lord ([170.246.208.189]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153dd4f0f0sm42267698eec.2.2026.08.03.19.14.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 19:14:55 -0700 (PDT)
From: =?UTF-8?q?Tales=20A=2E=20Mendon=C3=A7a?= <talesam@gmail.com>
To: intel-xe@lists.freedesktop.org
Cc: matthew.brost@intel.com, thomas.hellstrom@linux.intel.com,
 rodrigo.vivi@intel.com, dri-devel@lists.freedesktop.org,
 =?UTF-8?q?Tales=20A=2E=20Mendon=C3=A7a?= <talesam@gmail.com>
Subject: [RFC PATCH 3/3] drm/xe: Kick GuC while TLB invalidation acks are
 overdue
Date: Mon,  3 Aug 2026 23:14:41 -0300
Message-ID: <20260804021441.3054424-4-talesam@gmail.com>
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

On ARL with GuC 70.53.0, TLB invalidation acks intermittently stall:
the H2G request is consumed from the CTB immediately, but the G2H ack
only arrives ~2.3s later, tens of milliseconds after the fence timeout
has fired. During the stall the GPU keeps rendering; only work blocked
on the invalidation (e.g. Wayland compositors performing buffer
unmaps) hitches for the full 2.3s. Observed on three machines so far
(7d51, 7dd1, plus an Arc Pro 130T report), see Link.

Experiments ruled out the obvious suspects:

 * GT C6 parking: holding forcewake across the whole GT (C6 residency
   pinned at 0ms) still produced 9 timeouts in a row.
 * Lost interrupt/CT processing on the host: the G2H CTB is empty at
   timeout time; the ack genuinely has not been sent by the firmware.

What does help is poking the GuC while the ack is overdue. Add a
delayed work that fires XE_TLB_INVAL_KICK_DELAY_MS after an
invalidation is issued and, while any ack is pending, re-reads the GuC
status register, flushes the CT fast-path and rings the GuC doorbell
(xe_guc_notify()), re-arming itself until the ack arrives; the
existing TDR still bounds the total wait.

Instrumented results from two ARL machines over several days:

 * Without kicks: every stall lasts the full ~2.3s and is reported as
   a fence timeout (-ETIME), ~1/hour on a desktop workload.
 * With kicks: the majority of stalls resolve 15-276ms after one of
   the kicks, e.g.:

     TLB invalidation ack after kick: seqno=36405 recv=36405, request-to-ack=528ms, last-kick-to-ack=15ms, kicks=2

 * A minority of severe episodes ignore 8-9 consecutive doorbells and
   still run to the timeout (worst observed: ack 5996ms after request,
   3.7s after the last kick), suggesting the firmware is internally
   blocked for the whole window rather than missing a wake event.

This is a workaround, not a fix - the root cause looks like a GuC
firmware issue - but it turns a guaranteed 2.3s stall into a sub-500ms
hiccup for most occurrences, and the "ack after kick" log documents
the firmware behavior for further debugging.

Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8678
Signed-off-by: Tales A. Mendonça <talesam@gmail.com>
---
 drivers/gpu/drm/xe/xe_tlb_inval.c       | 95 +++++++++++++++++++++++--
 drivers/gpu/drm/xe/xe_tlb_inval_types.h | 25 +++++++
 2 files changed, 116 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_tlb_inval.c b/drivers/gpu/drm/xe/xe_tlb_inval.c
index 9dd04d5bc4c..16c32d5669f 100644
--- a/drivers/gpu/drm/xe/xe_tlb_inval.c
+++ b/drivers/gpu/drm/xe/xe_tlb_inval.c
@@ -10,7 +10,9 @@
 #include "xe_force_wake.h"
 #include "xe_gt_stats.h"
 #include "xe_gt_types.h"
+#include "xe_guc.h"
 #include "xe_guc_ct.h"
+#include "xe_guc_pc.h"
 #include "xe_guc_tlb_inval.h"
 #include "xe_mmio.h"
 #include "xe_pm.h"
@@ -30,6 +32,15 @@
 
 #define FENCE_STACK_BIT		DMA_FENCE_FLAG_USER_BITS
 
+/*
+ * Delay before poking the GuC about a pending invalidation that has not been
+ * acked yet. Acks normally arrive in microseconds; when the GuC stalls they
+ * only show up seconds later, after the timeout has already fired.
+ */
+#define XE_TLB_INVAL_KICK_DELAY_MS	250
+
+static void xe_tlb_inval_kick(struct work_struct *work);
+
 /* The frontend is only ever embedded in a GT */
 static struct xe_gt *tlb_inval_to_gt(struct xe_tlb_inval *tlb_inval)
 {
@@ -54,8 +65,10 @@ xe_tlb_inval_fence_signal(struct xe_tlb_inval_fence *fence)
 	lockdep_assert_held(&fence->tlb_inval->pending_lock);
 
 	list_del(&fence->link);
-	if (list_empty(&tlb_inval->pending_fences))
+	if (list_empty(&tlb_inval->pending_fences)) {
 		cancel_delayed_work(&tlb_inval->fence_tdr);
+		cancel_delayed_work(&tlb_inval->kick_work);
+	}
 	trace_xe_tlb_inval_fence_signal(fence->tlb_inval->xe, fence);
 	xe_tlb_inval_fence_fini(fence);
 	dma_fence_signal(&fence->base);
@@ -168,6 +181,7 @@ int xe_gt_tlb_inval_init_early(struct xe_gt *gt)
 	spin_lock_init(&tlb_inval->pending_lock);
 	spin_lock_init(&tlb_inval->lock);
 	INIT_DELAYED_WORK(&tlb_inval->fence_tdr, xe_tlb_inval_fence_timeout);
+	INIT_DELAYED_WORK(&tlb_inval->kick_work, xe_tlb_inval_kick);
 
 	err = drmm_mutex_init(&xe->drm, &tlb_inval->seqno_lock);
 	if (err)
@@ -218,6 +232,7 @@ void xe_tlb_inval_reset(struct xe_tlb_inval *tlb_inval)
 	mutex_lock(&tlb_inval->seqno_lock);
 	spin_lock_irq(&tlb_inval->pending_lock);
 	cancel_delayed_work(&tlb_inval->fence_tdr);
+	cancel_delayed_work(&tlb_inval->kick_work);
 	/*
 	 * We might have various kworkers waiting for TLB flushes to complete
 	 * which are not tracked with an explicit TLB fence, however at this
@@ -231,6 +246,8 @@ void xe_tlb_inval_reset(struct xe_tlb_inval *tlb_inval)
 		pending_seqno = tlb_inval->seqno - 1;
 	WRITE_ONCE(tlb_inval->seqno_recv, pending_seqno);
 	tlb_inval->timedout_seqno = 0;
+	tlb_inval->kicked_seqno = 0;
+	tlb_inval->kicked_count = 0;
 
 	list_for_each_entry_safe(fence, next,
 				 &tlb_inval->pending_fences, link)
@@ -268,6 +285,55 @@ static bool xe_tlb_inval_seqno_past(struct xe_tlb_inval *tlb_inval, int seqno)
 	return seqno_recv >= seqno;
 }
 
+static void xe_tlb_inval_kick(struct work_struct *work)
+{
+	struct xe_tlb_inval *tlb_inval = container_of(work, struct xe_tlb_inval,
+						      kick_work.work);
+	struct xe_gt *gt = tlb_inval_to_gt(tlb_inval);
+	struct xe_tlb_inval_fence *fence;
+	ktime_t inval_time = 0;
+	int seqno = 0;
+
+	spin_lock_irq(&tlb_inval->pending_lock);
+	fence = list_first_entry_or_null(&tlb_inval->pending_fences,
+					 struct xe_tlb_inval_fence, link);
+	if (fence) {
+		seqno = fence->seqno;
+		inval_time = fence->inval_time;
+	}
+	spin_unlock_irq(&tlb_inval->pending_lock);
+
+	if (!seqno)
+		return;
+
+	/*
+	 * Poke the GuC: read its status register, flush the CT fast-path and
+	 * ring the doorbell. On ARL with GuC 70.53.0 the ack for a pending
+	 * invalidation sometimes only arrives seconds after the request even
+	 * though the H2G was consumed immediately; a doorbell ring while the
+	 * ack is overdue usually unsticks it within ~250ms (see Link in the
+	 * commit message). Keep kicking every interval until the ack shows
+	 * up; the TDR bounds how long this can go on.
+	 */
+	if (gt->gtidle.idle_residency)
+		xe_guc_pc_c_status(&gt->uc.guc.pc);
+	tlb_inval->ops->flush(tlb_inval);
+	xe_guc_notify(&gt->uc.guc);
+
+	spin_lock_irq(&tlb_inval->pending_lock);
+	if (!xe_tlb_inval_seqno_past(tlb_inval, seqno)) {
+		if (tlb_inval->kicked_seqno != seqno)
+			tlb_inval->kicked_count = 0;
+		tlb_inval->kicked_seqno = seqno;
+		tlb_inval->kicked_inval_time = inval_time;
+		tlb_inval->kicked_time = ktime_get();
+		tlb_inval->kicked_count++;
+		queue_delayed_work(tlb_inval->timeout_wq, &tlb_inval->kick_work,
+				   msecs_to_jiffies(XE_TLB_INVAL_KICK_DELAY_MS));
+	}
+	spin_unlock_irq(&tlb_inval->pending_lock);
+}
+
 static void xe_tlb_inval_fence_prep(struct xe_tlb_inval_fence *fence)
 {
 	struct xe_tlb_inval *tlb_inval = fence->tlb_inval;
@@ -279,9 +345,12 @@ static void xe_tlb_inval_fence_prep(struct xe_tlb_inval_fence *fence)
 	fence->inval_time = ktime_get();
 	list_add_tail(&fence->link, &tlb_inval->pending_fences);
 
-	if (list_is_singular(&tlb_inval->pending_fences))
+	if (list_is_singular(&tlb_inval->pending_fences)) {
 		queue_delayed_work(tlb_inval->timeout_wq, &tlb_inval->fence_tdr,
 				   tlb_inval->ops->timeout_delay(tlb_inval));
+		queue_delayed_work(tlb_inval->timeout_wq, &tlb_inval->kick_work,
+				   msecs_to_jiffies(XE_TLB_INVAL_KICK_DELAY_MS));
+	}
 	spin_unlock_irq(&tlb_inval->pending_lock);
 
 	tlb_inval->seqno = (tlb_inval->seqno + 1) %
@@ -440,6 +509,20 @@ void xe_tlb_inval_done_handler(struct xe_tlb_inval *tlb_inval, int seqno)
 		tlb_inval->timedout_seqno = 0;
 	}
 
+	if (tlb_inval->kicked_seqno &&
+	    xe_tlb_inval_seqno_past(tlb_inval, tlb_inval->kicked_seqno)) {
+		ktime_t now = ktime_get();
+
+		drm_warn(&xe->drm,
+			 "TLB invalidation ack after kick: seqno=%d recv=%d, request-to-ack=%lldms, last-kick-to-ack=%lldms, kicks=%d",
+			 tlb_inval->kicked_seqno, seqno,
+			 ktime_ms_delta(now, tlb_inval->kicked_inval_time),
+			 ktime_ms_delta(now, tlb_inval->kicked_time),
+			 tlb_inval->kicked_count);
+		tlb_inval->kicked_seqno = 0;
+		tlb_inval->kicked_count = 0;
+	}
+
 	list_for_each_entry_safe(fence, next,
 				 &tlb_inval->pending_fences, link) {
 		trace_xe_tlb_inval_fence_recv(xe, fence);
@@ -450,12 +533,16 @@ void xe_tlb_inval_done_handler(struct xe_tlb_inval *tlb_inval, int seqno)
 		xe_tlb_inval_fence_signal(fence);
 	}
 
-	if (!list_empty(&tlb_inval->pending_fences))
+	if (!list_empty(&tlb_inval->pending_fences)) {
 		mod_delayed_work(tlb_inval->timeout_wq,
 				 &tlb_inval->fence_tdr,
 				 tlb_inval->ops->timeout_delay(tlb_inval));
-	else
+		mod_delayed_work(tlb_inval->timeout_wq, &tlb_inval->kick_work,
+				 msecs_to_jiffies(XE_TLB_INVAL_KICK_DELAY_MS));
+	} else {
 		cancel_delayed_work(&tlb_inval->fence_tdr);
+		cancel_delayed_work(&tlb_inval->kick_work);
+	}
 
 	spin_unlock_irqrestore(&tlb_inval->pending_lock, flags);
 }
diff --git a/drivers/gpu/drm/xe/xe_tlb_inval_types.h b/drivers/gpu/drm/xe/xe_tlb_inval_types.h
index 38288966254..f8ae540dc4b 100644
--- a/drivers/gpu/drm/xe/xe_tlb_inval_types.h
+++ b/drivers/gpu/drm/xe/xe_tlb_inval_types.h
@@ -124,6 +124,31 @@ struct xe_tlb_inval {
 	 * the timeout interval is over.
 	 */
 	struct delayed_work fence_tdr;
+	/**
+	 * @kick_work: pokes the GuC while an invalidation ack is overdue,
+	 * bounding ack stalls on GuC firmware that misses CT notifications.
+	 */
+	struct delayed_work kick_work;
+	/**
+	 * @kicked_seqno: seqno the last kick was issued for, 0 if none.
+	 * Protected by @pending_lock.
+	 */
+	int kicked_seqno;
+	/**
+	 * @kicked_inval_time: request time of @kicked_seqno. Protected by
+	 * @pending_lock.
+	 */
+	ktime_t kicked_inval_time;
+	/**
+	 * @kicked_time: time the last kick for @kicked_seqno ran. Protected
+	 * by @pending_lock.
+	 */
+	ktime_t kicked_time;
+	/**
+	 * @kicked_count: number of kicks issued for @kicked_seqno. Protected
+	 * by @pending_lock.
+	 */
+	int kicked_count;
 	/** @job_wq: schedules TLB invalidation jobs */
 	struct workqueue_struct *job_wq;
 	/** @tlb_inval.lock: protects TLB invalidation fences */
-- 
2.55.0

