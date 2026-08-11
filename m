Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CB77C5B572
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 14:09:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA85510EC4D;
	Tue, 11 Aug 2026 14:09:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="eFJDCnlg";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2815E10EC4D
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 14:09:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1786457337; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=HCyq9S2V3I1Mtf68ds7L00AO8Xv2EcciiVlndEGeTTCc2RjSNRiD/870kXjgxaEFY+1M0cg37uxlQneAdpTi9h5apSBcOEslnANC6jlQQemSE3+qjloBuo+e4B93EpD4PmcZI+1a+9PHhXs+d2Rm38Y9qSsrVbcbwGoT8nH8BS0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1786457337;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=buKW6acYbnYNJBcgqhNSUCYVZ73rDAsq9w9efYzvsmg=; 
 b=M5LdKgtBpwbQzdPZHvs6iHaouCn487aWEyLiI9nnZfsl2v4HTFaGCNfeIOBCFMXblrGNc2V0rPy6N6RhP8bTRjpyo14A0Yhf32nSbSM6nSSL2UTRy2VzTiuXiWA3Qs5dIzUPaNDDuq9kjka6iMEQ2ozbWHEZ3K0TkQMmNgfm0PY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786457337; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=buKW6acYbnYNJBcgqhNSUCYVZ73rDAsq9w9efYzvsmg=;
 b=eFJDCnlgNgjnir49MmgpPvDMItz+duJpccJD5ZwirPckYsbzU9oYNdVStoisSCdL
 BuzhGRhFB6np510YsOOIe3OvXNwDz7nvlrh2Vak5U/dvHe4LH08rxr+gy5wejmQfPYo
 WcMVFOmfmkWfEhG+kuQyWxR0Bl21ypUrZ5hshDvs=
Received: by mx.zohomail.com with SMTPS id 1786457335348256.2269304580773;
 Tue, 11 Aug 2026 07:08:55 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Tue, 11 Aug 2026 16:08:32 +0200
Subject: [PATCH v3 2/3] drm/panthor: Revisit reqs_lock handling in
 flush/reset paths
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-panthor-cache-flush-fix-v3-2-47d2c1bb1dab@collabora.com>
References: <20260811-panthor-cache-flush-fix-v3-0-47d2c1bb1dab@collabora.com>
In-Reply-To: <20260811-panthor-cache-flush-fix-v3-0-47d2c1bb1dab@collabora.com>
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
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_gpu.c | 66 ++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
index 68e2dd2527df..cb5319d1c5de 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu.c
+++ b/drivers/gpu/drm/panthor/panthor_gpu.c
@@ -330,37 +330,32 @@ int panthor_gpu_flush_caches(struct panthor_device *ptdev,
 			     u32 l2, u32 lsc, u32 other)
 {
 	struct panthor_gpu *gpu = ptdev->gpu;
-	unsigned long flags;
 	int ret = 0;
 
 	/* Serialize cache flush operations. */
 	guard(mutex)(&ptdev->gpu->cache_flush_lock);
 
-	spin_lock_irqsave(&ptdev->gpu->reqs_lock, flags);
-	trace_gpu_cache_flush_start(ptdev->base.dev, l2, lsc, other);
-	if (!(ptdev->gpu->pending_reqs & GPU_IRQ_CLEAN_CACHES_COMPLETED)) {
-		ptdev->gpu->pending_reqs |= GPU_IRQ_CLEAN_CACHES_COMPLETED;
-		gpu_write(gpu->iomem, GPU_CMD, GPU_FLUSH_CACHES(l2, lsc, other));
-	} else {
-		ret = -EIO;
-	}
-	spin_unlock_irqrestore(&ptdev->gpu->reqs_lock, flags);
-
-	if (ret) {
-		trace_gpu_cache_flush_end(ptdev->base.dev, l2, lsc, other);
-		return ret;
+	scoped_guard(spinlock, &ptdev->gpu->reqs_lock) {
+		trace_gpu_cache_flush_start(ptdev->base.dev, l2, lsc, other);
+		if (!(ptdev->gpu->pending_reqs & GPU_IRQ_CLEAN_CACHES_COMPLETED)) {
+			ptdev->gpu->pending_reqs |= GPU_IRQ_CLEAN_CACHES_COMPLETED;
+			gpu_write(gpu->iomem, GPU_CMD, GPU_FLUSH_CACHES(l2, lsc, other));
+		} else {
+			trace_gpu_cache_flush_end(ptdev->base.dev, l2, lsc, other);
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
 
 	trace_gpu_cache_flush_end(ptdev->base.dev, l2, lsc, other);
@@ -383,27 +378,26 @@ int panthor_gpu_soft_reset(struct panthor_device *ptdev)
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

