Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 333B6C61DB9
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 14:35:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D75310EA93;
	Tue, 25 Aug 2026 14:35:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VHO9OZuW";
	dkim-atps=neutral
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com
 [209.85.128.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 616A010E7C5
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 14:08:07 +0000 (UTC)
Received: by mail-yw1-f172.google.com with SMTP id
 00721157ae682-836cde02992so42326717b3.2
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 07:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787580486; x=1788185286; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HjcuIYMPT9C9kbhn3WnVAyI2bGT3SrHgj0fSx/Nh5HI=;
 b=VHO9OZuWqYIXnyU4b/ZK1eqETqvJT8O3eLLzK1ly1lougdh4xbvB3UForgwjCaPQus
 NsWHp78u8IvMmliLrEO6zkBfIEg4fXw5GeHgg8c6nK9g8QCf82/msA7x6nEkFUDC9X0B
 ygg0OjJq8GAoVMctUrvsZHukWsNEiQpJJaNnyBg1w1td8fLgBI3HLmMMqwx2z0Kv3su7
 6fOPFJIqPHvhmclyjhfVgCeaaCmNoQ7xkSpW2OKqTd4H2o1EhwARGUm/OpnJWN0qZSpz
 s4nq/4D455t5zBlBbj+5IabhiiGcXni8OHEiYjIRFXE9qekAmFaEGIBbvPLkqSGbNuKE
 WC/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787580486; x=1788185286;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HjcuIYMPT9C9kbhn3WnVAyI2bGT3SrHgj0fSx/Nh5HI=;
 b=W4MxMsNGtfForYqOUxMYWgtINw5duP8GEpmJP7YXnIVaKJvXGYY6ixc6mS8q+pzVZL
 59upqX3SOrCJeOiQWwpszJRiXLr0b5fpNIkti/6fg2ToVtUkaBT/Edhlhzk8HQBuKoNp
 4gdMT/gjgBNLboyaI846SIn2MHIqfbh67z+o+G1LUjXlG5wybgCc90BLTl8NYzIRnP50
 k3egKqwXcFvRxy1QFzw1M+JS4/jQS+7f7gmNLtnBAnrbdW5Af2tawPEzhNHDUPtNfM3R
 dd9LWmJBsC7M/JvWoNm3Bu3XwKr6OAmoNlgZ3HHWHjfSDpqZVLHSBJfvvsOU+Z6JKdtU
 iT8A==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro5iq+Xa9y5nGd4iMsDLqBZq8QPWhImPYDs/int4EpsQQJJXNRbg9/eRp7DN6i/V47bMHNGicInaBY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nNfySMuAF8J9XkPFGvLOIzhHZevayWt4iiM7CaH0FKq1Yml145
 tnWPY28tZUJMLhPv2yRyjtfNR83foHrTU4P2MgT0B0697DI3L2BVoolr
X-Gm-Gg: AR+sD10y78wZXQoBLt9W7Ii0zCMyhPYKgw8qF2+zvauqqAjQSZz19t0AEqvueXYMrVz
 bHS8Z0/FvqbzW7LgR2qukFBtzcmjSpH8y3Mj6cRxiCG+xgf+D7ZXakD6KMoX4BdC5myuzbdovkP
 bmuQ2qutlwmrvZPT08dmUPHDZcojT0HzHdPOJlqZlhGuz+ROW6+ea3+jX4GmlngRqRNoqmQ5t/8
 9Q5UgX3zJJV0+OHXtiVno4jHfIPnYJGAfZMTubKNb3BROgvNSZEzaT9UFU+9Q6MvgmnWL3N11Hk
 ezbst12a5B8bhss8pdH0we5q4yTZZRz2XuySh6cAmpZQMTMMtWv1SnYNRNdN5imzej+mvHaW6ny
 AQoS6usJONiqLrzKp70VTWZ35fttWUNzZBPQ3kscX/6vNihJ39PsMxBwKDF8xaFvBpS4KtHsoGt
 3Aafjuf1ax1rPo2NJKs9qFLX58jQxxbfyyTaavtueh15lI3fa9oBjcWTlHCBSrTUXpNjWMLudpl
 4rJpfPrDY6ifWz4AfUcdZWOFGTUVL8b1djiJE0=
X-Received: by 2002:a05:690c:e15c:20b0:81e:45a6:bd5a with SMTP id
 00721157ae682-849ebd3ae8emr69438287b3.0.1787580486277; 
 Mon, 24 Aug 2026 07:08:06 -0700 (PDT)
Received: from lord ([170.246.211.189]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-853ff053a84sm3326337b3.4.2026.08.24.07.08.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 07:08:05 -0700 (PDT)
From: =?UTF-8?q?Tales=20A=2E=20Mendon=C3=A7a?= <talesam@gmail.com>
To: intel-xe@lists.freedesktop.org
Cc: matthew.brost@intel.com, daniele.ceraolospurio@intel.com,
 stuart.summers@intel.com, julia.filipchuk@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com,
 navonjohnlukose@gmail.com, dri-devel@lists.freedesktop.org,
 =?UTF-8?q?Tales=20A=2E=20Mendon=C3=A7a?= <talesam@gmail.com>
Subject: [PATCH v3 2/3] drm/xe: Log when a timed out TLB invalidation ack
 finally arrives
Date: Mon, 24 Aug 2026 11:07:47 -0300
Message-ID: <20260824140748.54974-3-talesam@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824140748.54974-1-talesam@gmail.com>
References: <20260824140748.54974-1-talesam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 25 Aug 2026 14:35:48 +0000
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

