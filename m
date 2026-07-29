Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEEDDC53219
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 06:20:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FFA910EAA2;
	Wed, 29 Jul 2026 06:20:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="Vz/LGo0p";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C368810EAA2
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 06:20:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785306026; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ZqBhOYJl57gOs3Sy5PyTF6kBSPOhtHwac2NVs0AtXoI9V6Cn+fpKRELyWnLv9+c+y/x4slS3xV0qI4CWoPvxU89N1Tkxtmw4p1TeV4FlRYrE51lgYqQogYHLSHtQBDNUIiSj2YcMbDAzyVuMegkUA3qhzojPL0BgABmQk1cH51I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785306026;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Ma+lZ5QNyxZxer0Ym87GEltZSfTY77AtEeTcaF29F0w=; 
 b=evbzXhshkUBLzz3IRswS4mXYSfTauE7yR0TDtUkkdqp4/FkzR6TrqjczL9DPMBnuK/ppZG/T+POyaVMGweet4G9AZWymIkjRLrh0oour89giMtlOThqhXNQWLXdSOEMElze8U8K4sLQZLa32ucn+/izXcf0oIPZP9EYibWX3Zzc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785306026; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=Ma+lZ5QNyxZxer0Ym87GEltZSfTY77AtEeTcaF29F0w=;
 b=Vz/LGo0pqywxrIslOkWKVUNW8OUjyoKNYme+xOJKoFb9jgO5fmpSVcNoXtmEwsrW
 LSLCvBVhSPH1lECl9ZYT0yB7iIrxtpB0fUjRX0uCI9QFLfRn/8HeddixMkT8ZBGZxpw
 wtKp+Cxyd6UXbdU8LvqQO51PVcgHxrqlXkRJQz6w=
Received: by mx.zohomail.com with SMTPS id 1785306025420434.1534945169226;
 Tue, 28 Jul 2026 23:20:25 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Wed, 29 Jul 2026 08:19:51 +0200
Subject: [PATCH 3/3] drm/panthor: Add tracepoints for cache flushing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-panthor-cache-flush-fix-v1-3-205921ed3c81@collabora.com>
References: <20260729-panthor-cache-flush-fix-v1-0-205921ed3c81@collabora.com>
In-Reply-To: <20260729-panthor-cache-flush-fix-v1-0-205921ed3c81@collabora.com>
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
 drivers/gpu/drm/panthor/panthor_trace.h | 58 +++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

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
index 6ffeb4fe6599..5e2a9b8d0481 100644
--- a/drivers/gpu/drm/panthor/panthor_trace.h
+++ b/drivers/gpu/drm/panthor/panthor_trace.h
@@ -76,6 +76,64 @@ TRACE_EVENT(gpu_job_irq,
 		  __entry->events, __entry->duration_ns)
 );
 
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
+TRACE_EVENT(gpu_cache_flush_start,
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
+		__entry->l2	= l2;
+		__entry->lsc	= lsc;
+		__entry->other	= other;
+	),
+	TP_printk("%s: l2=0x%x lsc=0x%x other=0x%x", __get_str(dev_name),
+		  __entry->l2, __entry->lsc, __entry->other)
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
+TRACE_EVENT(gpu_cache_flush_end,
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
+		__entry->l2	= l2;
+		__entry->lsc	= lsc;
+		__entry->other	= other;
+	),
+	TP_printk("%s: l2=0x%x lsc=0x%x other=0x%x", __get_str(dev_name),
+		  __entry->l2, __entry->lsc, __entry->other)
+);
+
 #endif /* __PANTHOR_TRACE_H__ */
 
 #undef TRACE_INCLUDE_PATH

-- 
2.55.0

