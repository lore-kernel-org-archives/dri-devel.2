Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26C58C982EA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 07:53:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 410D810EF4C;
	Wed, 23 Sep 2026 07:53:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Fg1WS7Ux";
	dkim-atps=neutral
Received: from mail-vs2-f40.google.com (mail-vs2-f40.google.com
 [74.125.227.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 436B2892F6
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 14:46:53 +0000 (UTC)
Received: by mail-vs2-f40.google.com with SMTP id
 71dfb90a1353d-5c9b0bdf5b5so1775186e0c.0
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 07:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790088412; x=1790693212; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=73qduwrUzwo4elRsz+wDE8IKOKEhoC0t5sDSBXNaR/g=;
 b=Fg1WS7Uxkx8cMUedNOTbcUThwEYOCxOPkjNj5CRc4lIKPT0f9pKFgoif4pNjKJU+F7
 bOXbd8k9o1WGg5Tg/ZyLJ1yUNa9PNTYfqJR3UO6xMyhT3iUBco25CvCxd2PVxTVD8FN1
 8DHLjX1YkKzV8ZmfxJqzMC+coHmpZg65PJmXORReYG7lvgYvXEvGwW9EMHlRf6Hl1f+1
 xULrUmkQ0sDahumyxW0dnTWC12mhPKRTa37ZEhQEdHVxCRo6oFmEagnH7yk1JzZ+nFBU
 BRKIQnK5b++ZkSR4dfI3eQyXGGpvFLN8+DwRd3RFrcdMe+xBpjc7zIzHlAxNuruLz+8K
 jSJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790088412; x=1790693212;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=73qduwrUzwo4elRsz+wDE8IKOKEhoC0t5sDSBXNaR/g=;
 b=Jc1DONCQbZab+OkF5zflT2ysWG7FPg/GH5rvlL+B0d+cmcGMFjDtFj9mHl0BTjkOON
 6oVP9YE+OFTewkcUVoWdcsBtHO3bhnm+s+nx3klJZo8XF4UJeywVkR+UjXDRSom7E9Bw
 4IvTwj08WJzuFo7WqjS7U2VsrSc5qke44sQCUX0M2gQBw8bgA9guSdyJ3vwgIEPkZB25
 Eldak/eOY89F/2zb/HViiKmYDpFTXeLxSkG3tGRPPPsH+ZnnKagvhlTu/d4JFUzDGo+J
 lqNE6wYDmlIOHkPKy5u4Q0MmJ8N7bgFSBEaLr3K0Bd+bazUh6ZHeppNWtMkw38TrEpT1
 22KA==
X-Forwarded-Encrypted: i=1;
 AKwUvBye3K1/Tt49sbCNo1M9sfEorla5+AuuZwwHWgVDRNC8sIiplSYpOgFN8SpZoswNOOUqVqp53iCozY8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mVFy67sNrXa+B6ZqZ9OyjIoBYo6eOyXMDC6P/nEfPtcjy50gSf
 Y24UpfNmt1xCvf8QPIYHvf+odoCdz71bSWqqI82Dpkkt/uNhDOR7gBy+
X-Gm-Gg: AYBFou1kOPHbRZe2Y6ZrrvAPLrk5JMiIELrIrCWbASeqXylilu4jX0hik67v2UIR94I
 IeUe7Ip7z16LoNVch0gc+yBGhQeIn4xiBBHRMUQiTP56H0HewiO6SwTLln9vaOqyr1Tkku4jh+c
 357sxXKocZXdwljmIlYsoYRNnboikxSvKkdZuHTkxrnPZTxgciy81ZSG+sEnlfvl8lROg/h2s6D
 ND+kz1QZPJMhgJnPBUNKyCBXi+5fIYWrFmefaQjh2ACRkv6cWHVQrHaIMbAcomYXYOjo701aywC
 3jjTX5BNNWMXfnbKTkZC/XhVRnuXU+qBabe1iTA/ptjFu8yzjrd8ehn2ABKm/kK5JHdlJ5qfjsM
 nirgBfywt6ZEcWLZb8rWRWOBuwJwWA8u9S5B++QTXlW1KR83fs/wLFTuhTG0cX4T2CS9dNv16HW
 jiu/mYY0woDNEmeYM8on2b1awo22oAPYjKdnKsP9Dvj4BZdAH1BhCKcrn+qR9FYfLhRK7w/CkQh
 OHouhKr+59nhekmGkf6EiOWrDVZ8E86pGuMv/ku5d30HrzgpH4Itu7z8kzDelM=
X-Received: by 2002:a05:6122:3381:b0:5c9:a60b:e5c9 with SMTP id
 71dfb90a1353d-5c9b59c2f99mr9542000e0c.12.1790088412113; 
 Tue, 22 Sep 2026 07:46:52 -0700 (PDT)
Received: from lord.bigscale.net ([170.246.210.5])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-9850d661d77sm2017067241.7.2026.09.22.07.46.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 07:46:51 -0700 (PDT)
From: =?UTF-8?q?Tales=20A=2E=20Mendon=C3=A7a?= <talesam@gmail.com>
To: intel-xe@lists.freedesktop.org
Cc: matthew.brost@intel.com, daniele.ceraolospurio@intel.com,
 stuart.summers@intel.com, julia.filipchuk@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com,
 jani.nikula@intel.com, navonjohnlukose@gmail.com,
 dri-devel@lists.freedesktop.org,
 =?UTF-8?q?Tales=20A=2E=20Mendon=C3=A7a?= <talesam@gmail.com>
Subject: [PATCH v6 2/3] drm/xe: Log when a timed out TLB invalidation ack
 finally arrives
Date: Tue, 22 Sep 2026 11:46:33 -0300
Message-ID: <20260922144634.55130-3-talesam@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922144634.55130-1-talesam@gmail.com>
References: <20260922144634.55130-1-talesam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 23 Sep 2026 07:53:55 +0000
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
  TLB invalidation late ack: seqno=10992 recv=10992,
    request-to-ack=2314ms, timeout-to-ack=45ms

Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8678
Signed-off-by: Tales A. Mendonça <talesam@gmail.com>
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/xe/xe_tlb_inval.c       | 19 +++++++++++++++++++
 drivers/gpu/drm/xe/xe_tlb_inval_types.h | 17 +++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_tlb_inval.c b/drivers/gpu/drm/xe/xe_tlb_inval.c
index f7d6640d345..c9cc5842d65 100644
--- a/drivers/gpu/drm/xe/xe_tlb_inval.c
+++ b/drivers/gpu/drm/xe/xe_tlb_inval.c
@@ -14,6 +14,7 @@
 #include "xe_guc_tlb_inval.h"
 #include "xe_mmio.h"
 #include "xe_pm.h"
+#include "xe_printk.h"
 #include "xe_tlb_inval.h"
 #include "xe_trace.h"
 
@@ -110,6 +111,11 @@ static void xe_tlb_inval_fence_timeout(struct work_struct *work)
 		}
 
 		timedout_seqno = fence->seqno;
+		if (!tlb_inval->timedout_seqno) {
+			tlb_inval->timedout_seqno = fence->seqno;
+			tlb_inval->timedout_inval_time = fence->inval_time;
+			tlb_inval->timedout_time = ktime_get();
+		}
 
 		fence->base.error = -ETIME;
 		xe_tlb_inval_fence_signal(fence);
@@ -242,6 +248,7 @@ void xe_tlb_inval_reset(struct xe_tlb_inval *tlb_inval)
 	else
 		pending_seqno = tlb_inval->seqno - 1;
 	WRITE_ONCE(tlb_inval->seqno_recv, pending_seqno);
+	tlb_inval->timedout_seqno = 0;
 
 	list_for_each_entry_safe(fence, next,
 				 &tlb_inval->pending_fences, link)
@@ -470,6 +477,18 @@ void xe_tlb_inval_done_handler(struct xe_tlb_inval *tlb_inval, int seqno)
 
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
index d77be1aedc9..80d2019fa20 100644
--- a/drivers/gpu/drm/xe/xe_tlb_inval_types.h
+++ b/drivers/gpu/drm/xe/xe_tlb_inval_types.h
@@ -112,6 +112,23 @@ struct xe_tlb_inval {
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

