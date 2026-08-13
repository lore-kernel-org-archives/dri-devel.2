Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7DBDC5DF67
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 09:42:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE69B10F251;
	Thu, 13 Aug 2026 09:42:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ShSwVQ8y";
	dkim-atps=neutral
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C88A10E4AD
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 02:30:39 +0000 (UTC)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-84a2dcede83so2286379b3a.3
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 19:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786588239; x=1787193039; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sxNYxgIWFSbjxofB7wHcYG1T8O9GSfTsl7dt7CNavF4=;
 b=ShSwVQ8ykwq+W7cLkPW88UaclRWlWL3K6OLFvdt3jZIhj9x5X/9sZIvJlRyBeqQBB5
 l9a0no079feSxTPS+E2UsLF7TKuueYH8vDIX9QtywV9s8njtSEUiCaQ2NZl//4NquddS
 qGw5MfmlL89zo0CC9djeh0csclzIawxRZNjSXFQvWnzMtWOTtNamzIv55nj+pMi3k+fJ
 auuvvXztk8j3SzWFdKVxRz/1D0oEZCZbTNImqhF59f5LszunGLS2eMTK7Kz3KBfDS2UR
 FtP3hafTy4+a6LxOVWZZLpaDQmMEFrOWd0qsBJmbhD5hi/g0+uQqNRWQkn/65VIKoekf
 Q5Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786588239; x=1787193039;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sxNYxgIWFSbjxofB7wHcYG1T8O9GSfTsl7dt7CNavF4=;
 b=kYI+hR1F278pQb+SIDQAyJDVmpvIvfZ+hQ6lortu02dGmqtWJUKSvgepe5NwiFHVQT
 saEHIu69eDlIeKf/okozglOezgDWxYWOZAwluGCU25N+E+CQF3VuNwPwGGwojCYqQPiy
 Vks2B6NIlrJadKy6VQoThegP5hTBksXwhL+QSMp05ePPhFI6eHtTQpZ0UhWkTqJafvJa
 PL1ijzXf94lwPOGsBuoCQXZLo3+MskCVT7flTdlhj/+vpVb6WW3ANHA8yG0venaJhzdc
 2+fz5RI4tXgYzDdnMGA7+hgN13/7O1BTbdZoiXp7NEJ3bN9XrThCrPLeyR/6+oH+zGFY
 PHAw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rry32zkmPvB931g40UkXRDK75qh6RTQOpdvyOANvlPLCxHTOORN1AKgmTsd/CNvI7bQIT/VxTSyqBE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzTeO073kiUeWeBFwq1iqmKKypQ5lur8YAAcq7tHM5oM0su3+dK
 QRj3RnIc7LHMAgK8sRRL+vGzXiq0Iq8camKLYkjwZ0MhW4+z0H/9+8BxKaCJDw==
X-Gm-Gg: AR+sD11eb4g5vlhvOfScvXTU5wT8o186rVhGjgm825XqAru5rszbVVSXMP3P/YAFLhb
 ocEfTR4pwLCgnMGsr5KaIa22OHIvCOirYtD7Rfh+cpijaakKJlmAupYK85n57iJd5Ly2D1XYl79
 vPVdb8wdfiHyZ4n9Jcba6pyiPn33kejhI32b79cfkkC3YvXjRTl0d84S69fdz1PScja2MNMb5JJ
 ijIhXswbE2Ib1z/MUiNIOtQ5/d7uZx8jU4AJnyt/L6k2yM/Jlqfa1oTahghGVp1YYifDD9/JaDl
 /YoAjOQIR9aevFBBozbEpRiWnNNDu9Iqls8Mg8B3OqwuA97ErxeR6BSA3J7M5XCde4qD9hFUiHi
 GGcFqItFEbkKBp2zOAiMz5tE2bgfzDj1NUj4XeMIOvBvrzO9OmcwUQPfbPAr6GTJoF72YoKFN+H
 +IK7DUPq3hAq6PtZye2aUQFdNL2wp7jRFUcUc7sy9dby4GKxhnvVLZ/ADQj2PT+E1wHPLICBwwM
 4yVSC+mjs+dUC3/ofAirQfIrmWqkbrIOzL4zENCQYNbNqoZwt47Hlgt
X-Received: by 2002:a05:6a20:cc97:b0:3b2:8685:1473 with SMTP id
 adf61e73a8af0-3cc54f4968dmr3960537637.7.1786588238629; 
 Wed, 12 Aug 2026 19:30:38 -0700 (PDT)
Received: from lord.bigscale.net ([170.246.208.200])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31ebf731f95sm1950053eec.15.2026.08.12.19.30.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 19:30:37 -0700 (PDT)
From: =?UTF-8?q?Tales=20A=2E=20Mendon=C3=A7a?= <talesam@gmail.com>
To: intel-xe@lists.freedesktop.org
Cc: matthew.brost@intel.com, daniele.ceraolospurio@intel.com,
 stuart.summers@intel.com, julia.filipchuk@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com,
 dri-devel@lists.freedesktop.org,
 =?UTF-8?q?Tales=20A=2E=20Mendon=C3=A7a?= <talesam@gmail.com>
Subject: [PATCH v2 2/3] drm/xe: Log when a timed out TLB invalidation ack
 finally arrives
Date: Wed, 12 Aug 2026 23:30:15 -0300
Message-ID: <20260813023016.805573-3-talesam@gmail.com>
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

When a TLB invalidation fence times out we log the timeout, but if the
ack for that seqno later shows up there is no record of it, making it
impossible to tell from logs whether the ack was lost forever or merely
(very) late.

Track the most recent timed out seqno and log how late its ack arrives,
relative to both the original request and the moment the fence was
signaled with -ETIME.

On ARL with GuC 70.53.0 this shows the acks are never lost: they
consistently arrive ~2.3s after the request, tens of milliseconds after
the TDR has already signaled the fence:

  TLB invalidation fence timeout, seqno=10992 recv=10991
  TLB invalidation late ack: seqno=10992 recv=10992, request-to-ack=2314ms, timeout-to-ack=45ms

Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8678
Signed-off-by: Tales A. Mendonça <talesam@gmail.com>
---
 drivers/gpu/drm/xe/xe_tlb_inval.c       | 19 +++++++++++++++++++
 drivers/gpu/drm/xe/xe_tlb_inval_types.h | 17 +++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_tlb_inval.c b/drivers/gpu/drm/xe/xe_tlb_inval.c
index 833fb92cd3e..e98c6a0b7a6 100644
--- a/drivers/gpu/drm/xe/xe_tlb_inval.c
+++ b/drivers/gpu/drm/xe/xe_tlb_inval.c
@@ -14,6 +14,7 @@
 #include "xe_guc_tlb_inval.h"
 #include "xe_mmio.h"
 #include "xe_pm.h"
+#include "xe_printk.h"
 #include "xe_tlb_inval.h"
 #include "xe_trace.h"
 
@@ -99,6 +100,11 @@ static void xe_tlb_inval_fence_timeout(struct work_struct *work)
 			fence->seqno, tlb_inval->seqno_recv);
 
 		timedout_seqno = fence->seqno;
+		if (!tlb_inval->timedout_seqno) {
+			tlb_inval->timedout_seqno = fence->seqno;
+			tlb_inval->timedout_inval_time = fence->inval_time;
+			tlb_inval->timedout_time = ktime_get();
+		}
 
 		fence->base.error = -ETIME;
 		xe_tlb_inval_fence_signal(fence);
@@ -227,6 +233,7 @@ void xe_tlb_inval_reset(struct xe_tlb_inval *tlb_inval)
 	else
 		pending_seqno = tlb_inval->seqno - 1;
 	WRITE_ONCE(tlb_inval->seqno_recv, pending_seqno);
+	tlb_inval->timedout_seqno = 0;
 
 	list_for_each_entry_safe(fence, next,
 				 &tlb_inval->pending_fences, link)
@@ -424,6 +431,18 @@ void xe_tlb_inval_done_handler(struct xe_tlb_inval *tlb_inval, int seqno)
 
 	WRITE_ONCE(tlb_inval->seqno_recv, seqno);
 
+	if (tlb_inval->timedout_seqno &&
+	    xe_tlb_inval_seqno_past(tlb_inval, tlb_inval->timedout_seqno)) {
+		ktime_t now = ktime_get();
+
+		xe_warn(xe,
+			"TLB invalidation late ack: seqno=%d recv=%d, request-to-ack=%lldms, timeout-to-ack=%lldms",
+			tlb_inval->timedout_seqno, seqno,
+			ktime_ms_delta(now, tlb_inval->timedout_inval_time),
+			ktime_ms_delta(now, tlb_inval->timedout_time));
+		tlb_inval->timedout_seqno = 0;
+	}
+
 	list_for_each_entry_safe(fence, next,
 				 &tlb_inval->pending_fences, link) {
 		trace_xe_tlb_inval_fence_recv(xe, fence);
diff --git a/drivers/gpu/drm/xe/xe_tlb_inval_types.h b/drivers/gpu/drm/xe/xe_tlb_inval_types.h
index 3d1797d186f..38288966254 100644
--- a/drivers/gpu/drm/xe/xe_tlb_inval_types.h
+++ b/drivers/gpu/drm/xe/xe_tlb_inval_types.h
@@ -102,6 +102,23 @@ struct xe_tlb_inval {
 	 * @pending_lock: protects @pending_fences and updating @seqno_recv.
 	 */
 	spinlock_t pending_lock;
+	/**
+	 * @timedout_seqno: seqno of the most recent timed out TLB
+	 * invalidation, 0 if none. Used to measure how late the ack for a
+	 * timed out invalidation actually arrives. Protected by
+	 * @pending_lock.
+	 */
+	int timedout_seqno;
+	/**
+	 * @timedout_inval_time: request time of @timedout_seqno. Protected by
+	 * @pending_lock.
+	 */
+	ktime_t timedout_inval_time;
+	/**
+	 * @timedout_time: time @timedout_seqno was signaled with -ETIME.
+	 * Protected by @pending_lock.
+	 */
+	ktime_t timedout_time;
 	/**
 	 * @fence_tdr: schedules a delayed call to xe_tlb_fence_timeout after
 	 * the timeout interval is over.
-- 
2.55.0

