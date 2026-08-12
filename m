Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBCF0C5B56A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 14:08:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F39010EFF6;
	Wed, 12 Aug 2026 14:08:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="WR1pPQD1";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34D2E10EFF6
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 14:08:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1786543665; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=mVuLC0Y1n+VHUgIJe7Ew7Him+6dSZDYpxEIhyulZxQnIUm9IMasPbJyZMdtrVpTaBO7XcVfoHcEuQSzSjQ+iCccAwTzDP5UvniRLLqK1NsYzEHM41bx6K1vYomAHEvUwFFKmSQZX3ub1a4teeWX+p1bNkIq3xsmseKpZRppA7oI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1786543665;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=I6vWnS1wTCIKEgK1Y1hzrODYhhOal746YWUq+5WuGqI=; 
 b=YlasFehSX8uLWbdL23GZvDW3ypd5d2TANhzghlRGvgGDkCFA4GIzXhevObKV1SahdqLw7G/z91FrhPki7DX3OAs7SLwP5Cd9GSEUWC9T/EBEsxeNvkqZ81ny7154axw+tKZ9wZsd+efPcw1Cmqhk8trwWGynp/tjP2FCv45J+GA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786543665; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=I6vWnS1wTCIKEgK1Y1hzrODYhhOal746YWUq+5WuGqI=;
 b=WR1pPQD1jUs1gjNa+CgU8+1b9XuEGNoi4eLXFhjoKq4PbLpy2//MQliqBQvOEGU7
 GY+qrwXL3OWlJT6tl5kvRwHOVGkrLlbYtPkhs22NVtADmExHOgMygOSelka0XuDmT1Y
 I1SBXaOjtgNTwzlQeM3dbf22gmqwLPLt8DlR13Ys=
Received: by mx.zohomail.com with SMTPS id 1786543662895618.0778032572175;
 Wed, 12 Aug 2026 07:07:42 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Wed, 12 Aug 2026 16:07:18 +0200
Subject: [PATCH v4 1/3] drm/panthor: Add tracepoint for cache flushing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-panthor-cache-flush-fix-v4-1-751e32901898@collabora.com>
References: <20260812-panthor-cache-flush-fix-v4-0-751e32901898@collabora.com>
In-Reply-To: <20260812-panthor-cache-flush-fix-v4-0-751e32901898@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Grant Likely <grant.likely@linaro.org>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 kernel@collabora.com, Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.15.2
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

Add a new event tracepoint: gpu_cache_flush to be emitted after a GPU
cache flush completes, with duration and return status arguments.

This allows debugging the duration a flush takes irrespective of initial
function entry lock contention, and communicates information about
whether the flush timed out or errored out in other ways, and which
caches were flushed.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_gpu.c   | 26 +++++++++++++++++++++-
 drivers/gpu/drm/panthor/panthor_trace.h | 38 +++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
index c013d6bf9a59..7088371c6d64 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu.c
+++ b/drivers/gpu/drm/panthor/panthor_gpu.c
@@ -317,6 +317,21 @@ int panthor_gpu_l2_power_on(struct panthor_device *ptdev)
 	return panthor_gpu_power_on(ptdev, L2, 1, 20000);
 }
 
+static inline void panthor_gpu_emit_flush_caches_tp(struct panthor_device *ptdev,
+						    u64 start, u32 l2, u32 lsc,
+						    u32 other, int ret)
+{
+	u32 duration;
+
+	if (!tracepoint_enabled(gpu_cache_flush) || !start)
+		return;
+
+	if (check_sub_overflow(ktime_get_ns(), start, &duration))
+		duration = U32_MAX;
+
+	trace_gpu_cache_flush(ptdev->base.dev, l2, lsc, other, duration, ret);
+}
+
 /**
  * panthor_gpu_flush_caches() - Flush caches
  * @ptdev: Device.
@@ -331,12 +346,17 @@ int panthor_gpu_flush_caches(struct panthor_device *ptdev,
 {
 	struct panthor_gpu *gpu = ptdev->gpu;
 	unsigned long flags;
+	u64 start = 0;
 	int ret = 0;
 
 	/* Serialize cache flush operations. */
 	guard(mutex)(&ptdev->gpu->cache_flush_lock);
 
 	spin_lock_irqsave(&ptdev->gpu->reqs_lock, flags);
+
+	if (tracepoint_enabled(gpu_cache_flush))
+		start = ktime_get_ns();
+
 	if (!(ptdev->gpu->pending_reqs & GPU_IRQ_CLEAN_CACHES_COMPLETED)) {
 		ptdev->gpu->pending_reqs |= GPU_IRQ_CLEAN_CACHES_COMPLETED;
 		gpu_write(gpu->iomem, GPU_CMD, GPU_FLUSH_CACHES(l2, lsc, other));
@@ -345,8 +365,10 @@ int panthor_gpu_flush_caches(struct panthor_device *ptdev,
 	}
 	spin_unlock_irqrestore(&ptdev->gpu->reqs_lock, flags);
 
-	if (ret)
+	if (ret) {
+		panthor_gpu_emit_flush_caches_tp(ptdev, start, l2, lsc, other, ret);
 		return ret;
+	}
 
 	if (!wait_event_timeout(ptdev->gpu->reqs_acked,
 				!(ptdev->gpu->pending_reqs & GPU_IRQ_CLEAN_CACHES_COMPLETED),
@@ -360,6 +382,8 @@ int panthor_gpu_flush_caches(struct panthor_device *ptdev,
 		spin_unlock_irqrestore(&ptdev->gpu->reqs_lock, flags);
 	}
 
+	panthor_gpu_emit_flush_caches_tp(ptdev, start, l2, lsc, other, ret);
+
 	if (ret) {
 		panthor_device_schedule_reset(ptdev);
 		drm_err(&ptdev->base, "Flush caches timeout");
diff --git a/drivers/gpu/drm/panthor/panthor_trace.h b/drivers/gpu/drm/panthor/panthor_trace.h
index 6ffeb4fe6599..bd8652549ab4 100644
--- a/drivers/gpu/drm/panthor/panthor_trace.h
+++ b/drivers/gpu/drm/panthor/panthor_trace.h
@@ -76,6 +76,44 @@ TRACE_EVENT(gpu_job_irq,
 		  __entry->events, __entry->duration_ns)
 );
 
+/**
+ * gpu_cache_flush - emitted after cache flush completes
+ * @dev: pointer to the &struct device, for printing the device name
+ * @l2: "l2" flush flags
+ * @lsc: "lsc" flush flags
+ * @other: "other" flush flags
+ * @duration_ns: how long the cache flush operation took, in nanoseconds
+ * @ret: return status, 0 == success, negative errno on error
+ *
+ * Begins measuring after any initial lock contention around the locks needed
+ * for flushing caches, but before the actual cache flush is requested. Stops
+ * measuring and is emitted after flush operation is over.
+ */
+TRACE_EVENT(gpu_cache_flush,
+	    TP_PROTO(const struct device *dev, u32 l2, u32 lsc, u32 other,
+		     u32 duration_ns, int ret),
+	    TP_ARGS(dev, l2, lsc, other, duration_ns, ret),
+	    TP_STRUCT__entry(
+		    __string(dev_name, dev_name(dev))
+		    __field(u32, l2)
+		    __field(u32, lsc)
+		    __field(u32, other)
+		    __field(u32, duration_ns)
+		    __field(int, ret)
+	    ),
+	    TP_fast_assign(
+		    __assign_str(dev_name);
+		    __entry->l2          = l2;
+		    __entry->lsc         = lsc;
+		    __entry->other       = other;
+		    __entry->duration_ns = duration_ns;
+		    __entry->ret         = ret;
+	    ),
+	    TP_printk("%s: l2=0x%x lsc=0x%x other=0x%x duration_ns=%u ret=%d",
+		      __get_str(dev_name), __entry->l2, __entry->lsc,
+		      __entry->other, __entry->duration_ns, __entry->ret)
+);
+
 #endif /* __PANTHOR_TRACE_H__ */
 
 #undef TRACE_INCLUDE_PATH

-- 
2.55.0

