Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13596FA0C4B
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 08:32:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DA9E10E135;
	Wed, 15 Apr 2026 08:32:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="CuUWnSyB";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDDB310E6A5
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 08:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=TrNNJa1+30iJ08uCK6HKe3RckGkPHTEMVi6lOyyvx68=; b=CuUWnSyBc+gBlHsJ6JFDHP+Qtf
 pYJKQUPbpDJPB+ikIjqI7CwS79YPl/gtFyztASty4lFrrP/eCHLgR8A/JcSIWK+bhzJOV6m/7P6Um
 F+evbjOHn5PLzTEDSb8CxfnFPAlGZ5r540IJQ2voDNDGEzuh/PZ2zOD6Rk4IeFs7G/Tk4p8b4v3oO
 XeV1EpmK9m2cL1nLEZFyWA+pX3H2v54vMcnqwMEJ+eG4+TTSspVKAhf3TuftyonkI+BLJ4OD4GNOZ
 2pcA5zMUzVgPl7KmgzEzjypymMO2zZYZYJum1JxHgRHL9OefR/vvdT69aVmtHqVTG3EEZHWtgYkbl
 QrOmjsbw==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wCvfO-00GHZU-Td; Wed, 15 Apr 2026 10:32:11 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: [PATCH 2/2] dma-fence: Fix potential tracepoint null pointer
 dereferences
Date: Wed, 15 Apr 2026 09:32:07 +0100
Message-ID: <20260415083207.40513-2-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260415083207.40513-1-tvrtko.ursulin@igalia.com>
References: <20260415083207.40513-1-tvrtko.ursulin@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Trace_dma_fence_signaled, trace_dma_fence_wait_end and
trace_dma_fence_destroy can all currently dereference a null fence->ops
pointer after it has been reset on fence signalling.

Lets use the safe string getters for most tracepoints to avoid this class
of a problem, while for the signal tracepoint we move it to before ops are
cleared to avoid losing the driver and timeline name information. Apart
from moving it we also need to add a new tracepoint class to bypass the
safe name getters since the signaled bit is already set.

For dma_fence_init we also need to use the new tracepoint class since the
rcu read lock is not held there, and we can do the same for the enable
signaling since there we are certain the fence cannot be signaled while
we are holding the lock and have even validated the fence->ops.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Fixes: 541c8f2468b9 ("dma-buf: detach fence ops on signal v3")
Cc: Christian König <christian.koenig@amd.com>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: Boris Brezillon <boris.brezillon@collabora.com>
Cc: linux-media@vger.kernel.org
Cc: linaro-mm-sig@lists.linaro.org
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/dma-buf/dma-fence.c      |  3 ++-
 include/trace/events/dma_fence.h | 40 +++++++++++++++++++++++++++-----
 2 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index a2aa82f4eedd..b3bfa6943a8e 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -363,6 +363,8 @@ void dma_fence_signal_timestamp_locked(struct dma_fence *fence,
 				      &fence->flags)))
 		return;
 
+	trace_dma_fence_signaled(fence);
+
 	/*
 	 * When neither a release nor a wait operation is specified set the ops
 	 * pointer to NULL to allow the fence structure to become independent
@@ -377,7 +379,6 @@ void dma_fence_signal_timestamp_locked(struct dma_fence *fence,
 
 	fence->timestamp = timestamp;
 	set_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &fence->flags);
-	trace_dma_fence_signaled(fence);
 
 	list_for_each_entry_safe(cur, tmp, &cb_list, node) {
 		INIT_LIST_HEAD(&cur->node);
diff --git a/include/trace/events/dma_fence.h b/include/trace/events/dma_fence.h
index 3abba45c0601..5b10a9e06fb4 100644
--- a/include/trace/events/dma_fence.h
+++ b/include/trace/events/dma_fence.h
@@ -9,12 +9,40 @@
 
 struct dma_fence;
 
+DECLARE_EVENT_CLASS(dma_fence,
+
+	TP_PROTO(struct dma_fence *fence),
+
+	TP_ARGS(fence),
+
+	TP_STRUCT__entry(
+		__string(driver, dma_fence_driver_name(fence))
+		__string(timeline, dma_fence_timeline_name(fence))
+		__field(unsigned int, context)
+		__field(unsigned int, seqno)
+	),
+
+	TP_fast_assign(
+		__assign_str(driver);
+		__assign_str(timeline);
+		__entry->context = fence->context;
+		__entry->seqno = fence->seqno;
+	),
+
+	TP_printk("driver=%s timeline=%s context=%u seqno=%u",
+		  __get_str(driver), __get_str(timeline), __entry->context,
+		  __entry->seqno)
+);
+
 /*
  * Safe only for call sites which are guaranteed to not race with fence
- * signaling,holding the fence->lock and having checked for not signaled, or the
- * signaling path itself.
+ * signaling, holding the fence->lock and having checked for not signaled, or
+ * the signaling path itself.
+ *
+ * TODO: Remove the need for this event class when drivers switch to independent
+ *       fences.
  */
-DECLARE_EVENT_CLASS(dma_fence,
+DECLARE_EVENT_CLASS(dma_fence_ops,
 
 	TP_PROTO(struct dma_fence *fence),
 
@@ -46,7 +74,7 @@ DEFINE_EVENT(dma_fence, dma_fence_emit,
 	TP_ARGS(fence)
 );
 
-DEFINE_EVENT(dma_fence, dma_fence_init,
+DEFINE_EVENT(dma_fence_ops, dma_fence_init,
 
 	TP_PROTO(struct dma_fence *fence),
 
@@ -60,14 +88,14 @@ DEFINE_EVENT(dma_fence, dma_fence_destroy,
 	TP_ARGS(fence)
 );
 
-DEFINE_EVENT(dma_fence, dma_fence_enable_signal,
+DEFINE_EVENT(dma_fence_ops, dma_fence_enable_signal,
 
 	TP_PROTO(struct dma_fence *fence),
 
 	TP_ARGS(fence)
 );
 
-DEFINE_EVENT(dma_fence, dma_fence_signaled,
+DEFINE_EVENT(dma_fence_ops, dma_fence_signaled,
 
 	TP_PROTO(struct dma_fence *fence),
 
-- 
2.52.0

