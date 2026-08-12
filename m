Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5360EC5B56A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 14:08:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FE8810F013;
	Wed, 12 Aug 2026 14:08:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="UCd6c/hc";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F64710F013
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 14:08:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1786543668; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=MAlBNkGUpZ2y2UwmGLeI/nYmFJ2gAvY6ty+TjWRv179utJX2qhtMjdIceXtX8wpdW3uXlEtmkc/bhQJkcb1GePL5Kpjmi3uvOWcVlQ7ssZXeOdDNCfzkty0RxujUxzkPMU9HPPy6+I6UXEvjBPNJZsLDgz9/CX53TarggNVkkO8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1786543668;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=4fITRmWPwYliTA04mteOIgcZ9Rsn8HY/JqMqrf0JF8w=; 
 b=ceJHCPtzdaSQqeHHwoqV1T4ozeYz0sllYsuQC3aPOjzUYXD1upDAHcwwK+21MAlfQ39YScs7zu8ViHQx1YN1SxjZsuJbfQqiQa8Tbh+jqUZ24KQKqXj49P7QJaVL0kC/RlKdXnmh+qP6+yJ5mWLSosE4uLPSv5A1+5h9n/apIdQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786543668; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=4fITRmWPwYliTA04mteOIgcZ9Rsn8HY/JqMqrf0JF8w=;
 b=UCd6c/hc79kPU/F2ZHLR9gE6oinAQ0QFdyis8jBL4R8U/+7oegLkJjz95KE3+YPG
 GMJS6iY6DFQrA9a1egX9UYfGNXqrAstH+EHiCSdZnmCw9QA1QWtRxxsmA5bAxFBdPDI
 5IIhnBcDgvJEitjFAVxQSToBh5YEHpiOwSxgmIis=
Received: by mx.zohomail.com with SMTPS id 1786543665869804.8658229040461;
 Wed, 12 Aug 2026 07:07:45 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Wed, 12 Aug 2026 16:07:19 +0200
Subject: [PATCH v4 2/3] drm/panthor: Revisit reqs_lock handling in
 flush/reset paths
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-panthor-cache-flush-fix-v4-2-751e32901898@collabora.com>
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

panthor_gpu_flush_caches() and panthor_gpu_soft_reset() acquire their
reqs_lock spinlock with the IRQ-disabling variants of the spinlocking
functions. This isn't necessary, as the lock is never taken from an
atomic context, as Panthor uses threaded interrupt handlers. The result
of this overly strict locking is that IRQs may be disabled more
frequently and for longer than they should be, resulting in increased
system latency.

Switch the locking to use non-IRQ-disabling scoped_guard statements for
locking. The wait_event_timeout read of pending_reqs outside of the
spinlock is fine as wait_event_timeout is a memory barrier according to
the Linux Memory Model.

Fixes: 5cd894e258c4 ("drm/panthor: Add the GPU logical block")
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_gpu.c | 72 ++++++++++++++++-------------------
 1 file changed, 33 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
index 7088371c6d64..55e33f145b40 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu.c
+++ b/drivers/gpu/drm/panthor/panthor_gpu.c
@@ -345,41 +345,36 @@ int panthor_gpu_flush_caches(struct panthor_device *ptdev,
 			     u32 l2, u32 lsc, u32 other)
 {
 	struct panthor_gpu *gpu = ptdev->gpu;
-	unsigned long flags;
 	u64 start = 0;
 	int ret = 0;
 
 	/* Serialize cache flush operations. */
 	guard(mutex)(&ptdev->gpu->cache_flush_lock);
 
-	spin_lock_irqsave(&ptdev->gpu->reqs_lock, flags);
-
-	if (tracepoint_enabled(gpu_cache_flush))
-		start = ktime_get_ns();
-
-	if (!(ptdev->gpu->pending_reqs & GPU_IRQ_CLEAN_CACHES_COMPLETED)) {
-		ptdev->gpu->pending_reqs |= GPU_IRQ_CLEAN_CACHES_COMPLETED;
-		gpu_write(gpu->iomem, GPU_CMD, GPU_FLUSH_CACHES(l2, lsc, other));
-	} else {
-		ret = -EIO;
-	}
-	spin_unlock_irqrestore(&ptdev->gpu->reqs_lock, flags);
-
-	if (ret) {
-		panthor_gpu_emit_flush_caches_tp(ptdev, start, l2, lsc, other, ret);
-		return ret;
+	scoped_guard(spinlock, &ptdev->gpu->reqs_lock) {
+		if (tracepoint_enabled(gpu_cache_flush))
+			start = ktime_get_ns();
+
+		if (!(ptdev->gpu->pending_reqs & GPU_IRQ_CLEAN_CACHES_COMPLETED)) {
+			ptdev->gpu->pending_reqs |= GPU_IRQ_CLEAN_CACHES_COMPLETED;
+			gpu_write(gpu->iomem, GPU_CMD, GPU_FLUSH_CACHES(l2, lsc, other));
+		} else {
+			panthor_gpu_emit_flush_caches_tp(ptdev, start, l2, lsc,
+							 other, -EIO);
+			return -EIO;
+		}
 	}
 
 	if (!wait_event_timeout(ptdev->gpu->reqs_acked,
 				!(ptdev->gpu->pending_reqs & GPU_IRQ_CLEAN_CACHES_COMPLETED),
 				msecs_to_jiffies(100))) {
-		spin_lock_irqsave(&ptdev->gpu->reqs_lock, flags);
-		if ((ptdev->gpu->pending_reqs & GPU_IRQ_CLEAN_CACHES_COMPLETED) != 0 &&
-		    !(gpu_read(gpu->irq.iomem, INT_RAWSTAT) & GPU_IRQ_CLEAN_CACHES_COMPLETED))
-			ret = -ETIMEDOUT;
-		else
-			ptdev->gpu->pending_reqs &= ~GPU_IRQ_CLEAN_CACHES_COMPLETED;
-		spin_unlock_irqrestore(&ptdev->gpu->reqs_lock, flags);
+		scoped_guard(spinlock, &ptdev->gpu->reqs_lock) {
+			if ((ptdev->gpu->pending_reqs & GPU_IRQ_CLEAN_CACHES_COMPLETED) != 0 &&
+			!(gpu_read(gpu->irq.iomem, INT_RAWSTAT) & GPU_IRQ_CLEAN_CACHES_COMPLETED))
+				ret = -ETIMEDOUT;
+			else
+				ptdev->gpu->pending_reqs &= ~GPU_IRQ_CLEAN_CACHES_COMPLETED;
+		}
 	}
 
 	panthor_gpu_emit_flush_caches_tp(ptdev, start, l2, lsc, other, ret);
@@ -402,27 +397,26 @@ int panthor_gpu_soft_reset(struct panthor_device *ptdev)
 {
 	struct panthor_gpu *gpu = ptdev->gpu;
 	bool timedout = false;
-	unsigned long flags;
 
-	spin_lock_irqsave(&ptdev->gpu->reqs_lock, flags);
-	if (!drm_WARN_ON(&ptdev->base,
-			 ptdev->gpu->pending_reqs & GPU_IRQ_RESET_COMPLETED)) {
-		ptdev->gpu->pending_reqs |= GPU_IRQ_RESET_COMPLETED;
-		gpu_write(gpu->irq.iomem, INT_CLEAR, GPU_IRQ_RESET_COMPLETED);
-		gpu_write(gpu->iomem, GPU_CMD, GPU_SOFT_RESET);
+	scoped_guard(spinlock, &ptdev->gpu->reqs_lock) {
+		if (!drm_WARN_ON(&ptdev->base,
+				ptdev->gpu->pending_reqs & GPU_IRQ_RESET_COMPLETED)) {
+			ptdev->gpu->pending_reqs |= GPU_IRQ_RESET_COMPLETED;
+			gpu_write(gpu->irq.iomem, INT_CLEAR, GPU_IRQ_RESET_COMPLETED);
+			gpu_write(gpu->iomem, GPU_CMD, GPU_SOFT_RESET);
+		}
 	}
-	spin_unlock_irqrestore(&ptdev->gpu->reqs_lock, flags);
 
 	if (!wait_event_timeout(ptdev->gpu->reqs_acked,
 				!(ptdev->gpu->pending_reqs & GPU_IRQ_RESET_COMPLETED),
 				msecs_to_jiffies(100))) {
-		spin_lock_irqsave(&ptdev->gpu->reqs_lock, flags);
-		if ((ptdev->gpu->pending_reqs & GPU_IRQ_RESET_COMPLETED) != 0 &&
-		    !(gpu_read(gpu->irq.iomem, INT_RAWSTAT) & GPU_IRQ_RESET_COMPLETED))
-			timedout = true;
-		else
-			ptdev->gpu->pending_reqs &= ~GPU_IRQ_RESET_COMPLETED;
-		spin_unlock_irqrestore(&ptdev->gpu->reqs_lock, flags);
+		scoped_guard(spinlock, &ptdev->gpu->reqs_lock) {
+			if ((ptdev->gpu->pending_reqs & GPU_IRQ_RESET_COMPLETED) != 0 &&
+			!(gpu_read(gpu->irq.iomem, INT_RAWSTAT) & GPU_IRQ_RESET_COMPLETED))
+				timedout = true;
+			else
+				ptdev->gpu->pending_reqs &= ~GPU_IRQ_RESET_COMPLETED;
+		}
 	}
 
 	if (timedout) {

-- 
2.55.0

