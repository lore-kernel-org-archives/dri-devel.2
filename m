Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46847C55162
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 11:46:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AA0810EEDD;
	Thu, 30 Jul 2026 11:46:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="iNDaksjJ";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48E1510EEDD
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 11:46:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785411955; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=gNNRi+DRSxZc/h/xndiUcQkc1nMQicQnhX5qwakhVZe6czc/7VM8wZ/jWQg+UYbOBpdOhSPcIpFusxHHMluHn5XrdLg6Dn8n2qdPNoFljJcDt5TGhKWA+YUvj6ljoQgtY7a1litwnHwFfzWdv+AQn5MfdkuxqrTqVxzwib61ObQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785411955;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=WZYKskC3NYdXOolgCIkESE4GDSx+2rqs8T/qiiL/BSo=; 
 b=I3qqSYP/J7bhHR+4sxrY3MakY670gaQIccxN5u/gmtc76nLMc2Yih0njyD7CvtB5RrqbGMhVbEtFyYJ8IODW1afalVOYzn7vchwdeo3CoTuBOaXsJWeFWCL1eJ6TR/r1VP+8L/tgqC4khunGlmnyFgv7yR7I54J/8Y5S1krih+4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785411955; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=WZYKskC3NYdXOolgCIkESE4GDSx+2rqs8T/qiiL/BSo=;
 b=iNDaksjJ6Hi+mYUthXKf1Hy826MvjoMXgAw2wIwogeBYVwcSTOc8H88yGVDIGQRf
 27zVHkFx7p2C/CfB0iCyVBq1vWJ0fXMqOsUQCNS4zPocUvWYHs3s76pj7nbx9Pq844f
 QCE5qpSjQ5V1+or0DRibHWBarib8qYfvGnG8ZPAs=
Received: by mx.zohomail.com with SMTPS id 1785411954553897.0919123267404;
 Thu, 30 Jul 2026 04:45:54 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Thu, 30 Jul 2026 13:45:16 +0200
Subject: [PATCH v2 3/3] drm/panthor: Add tracepoints for cache flushing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-panthor-cache-flush-fix-v2-3-28790478bfff@collabora.com>
References: <20260730-panthor-cache-flush-fix-v2-0-28790478bfff@collabora.com>
In-Reply-To: <20260730-panthor-cache-flush-fix-v2-0-28790478bfff@collabora.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 K Prateek Nayak <kprateek.nayak@amd.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
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

Add two new event tracepoints: gpu_cache_flush_start to be emitted after
acquiring the flush mutex and reqs spinlock, and gpu_cache_flush_end to
be emitted when leaving the function.

This allows debugging the duration a flush takes irrespective of initial
function entry lock contention by subtracting the start tracepoint's
timestamp from the end tracepoint timestamp, and additionally contains
information such as which caches were flushed.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_gpu.c   |  3 ++
 drivers/gpu/drm/panthor/panthor_trace.h | 49 +++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
index f015bde80abf..a25955ad668b 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu.c
+++ b/drivers/gpu/drm/panthor/panthor_gpu.c
@@ -336,6 +336,7 @@ int panthor_gpu_flush_caches(struct panthor_device *ptdev,
 	guard(mutex)(&ptdev->gpu->cache_flush_lock);
 
 	spin_lock(&ptdev->gpu->reqs_lock);
+	trace_gpu_cache_flush_start(ptdev->base.dev, l2, lsc, other);
 	if (!(ptdev->gpu->pending_reqs & GPU_IRQ_CLEAN_CACHES_COMPLETED)) {
 		ptdev->gpu->pending_reqs |= GPU_IRQ_CLEAN_CACHES_COMPLETED;
 		gpu_write(gpu->iomem, GPU_CMD, GPU_FLUSH_CACHES(l2, lsc, other));
@@ -345,6 +346,7 @@ int panthor_gpu_flush_caches(struct panthor_device *ptdev,
 
 	if (ret) {
 		spin_unlock(&ptdev->gpu->reqs_lock);
+		trace_gpu_cache_flush_end(ptdev->base.dev, l2, lsc, other);
 		return ret;
 	}
 
@@ -358,6 +360,7 @@ int panthor_gpu_flush_caches(struct panthor_device *ptdev,
 			ptdev->gpu->pending_reqs &= ~GPU_IRQ_CLEAN_CACHES_COMPLETED;
 	}
 	spin_unlock(&ptdev->gpu->reqs_lock);
+	trace_gpu_cache_flush_end(ptdev->base.dev, l2, lsc, other);
 
 	if (ret) {
 		panthor_device_schedule_reset(ptdev);
diff --git a/drivers/gpu/drm/panthor/panthor_trace.h b/drivers/gpu/drm/panthor/panthor_trace.h
index 6ffeb4fe6599..6951b95b1de7 100644
--- a/drivers/gpu/drm/panthor/panthor_trace.h
+++ b/drivers/gpu/drm/panthor/panthor_trace.h
@@ -76,6 +76,55 @@ TRACE_EVENT(gpu_job_irq,
 		  __entry->events, __entry->duration_ns)
 );
 
+DECLARE_EVENT_CLASS(gpu_cache_flush_template,
+	TP_PROTO(const struct device *dev, u32 l2, u32 lsc, u32 other),
+	TP_ARGS(dev, l2, lsc, other),
+	TP_STRUCT__entry(
+		__string(dev_name, dev_name(dev))
+		__field(u32, l2)
+		__field(u32, lsc)
+		__field(u32, other)
+	),
+	TP_fast_assign(
+		__assign_str(dev_name);
+		__entry->l2     = l2;
+		__entry->lsc    = lsc;
+		__entry->other  = other;
+	),
+	TP_printk("%s: l2=0x%x lsc=0x%x other=0x%x", __get_str(dev_name),
+		  __entry->l2, __entry->lsc, __entry->other)
+);
+
+/**
+ * gpu_cache_flush_start - called after cache flush locks taken, before flush
+ * @dev: pointer to the &struct device, for printing the device name
+ * @l2: "l2" flush flags
+ * @lsc: "lsc" flush flags
+ * @other: "other" flush flags
+ *
+ * Fires after any initial lock contention around the locks needed for flushing
+ * caches, but before the actual cache flush is requested.
+ */
+DEFINE_EVENT(gpu_cache_flush_template, gpu_cache_flush_start,
+	     TP_PROTO(const struct device *dev, u32 l2, u32 lsc, u32 other),
+	     TP_ARGS(dev, l2, lsc, other)
+);
+
+/**
+ * gpu_cache_flush_end - called after cache flush
+ * @dev: pointer to the &struct device, for printing the device name
+ * @l2: "l2" flush flags
+ * @lsc: "lsc" flush flags
+ * @other: "other" flush flags
+ *
+ * Fires after either the cache flush is complete, or has failed. Can be used
+ * together with gpu_cache_flush_start to get how long the flush has taken.
+ */
+DEFINE_EVENT(gpu_cache_flush_template, gpu_cache_flush_end,
+	     TP_PROTO(const struct device *dev, u32 l2, u32 lsc, u32 other),
+	     TP_ARGS(dev, l2, lsc, other)
+);
+
 #endif /* __PANTHOR_TRACE_H__ */
 
 #undef TRACE_INCLUDE_PATH

-- 
2.55.0

