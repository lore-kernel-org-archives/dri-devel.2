Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAC4DC55162
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 11:45:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C8D710EED3;
	Thu, 30 Jul 2026 11:45:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="Ebnx7LtW";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 934E310EED3
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 11:45:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785411949; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=JS2HwOb/D7FhAdZW6SsjSeaYRFmuYW/zccFs1n/KxXuo89ITTtedEGljIMLrlfu9Y01btaAUTErePFoS5f7MOoSci9vscnx6NCMNbH3NwYgvg2md+uq78uGGJTWARtuQ806yvcuOdAaKK5xWv3QtCkddqG/iS2G7KMpL/IRxf08=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785411949;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=i1bEwzpAqbXOusu5i/g7M0H3+pJayV2PwHxpSPHzwqY=; 
 b=YvCjy1IJfkGlWvypKbEGPlVB0QiYABCRCJtBm+3Ik8fOXYrsFWS7ppXhF+oeZMgU1uug0PwgnVNywbJB+BaFCr+e7H7FN5LVB7hPB6akIv0ljID3zzmEx2/vcqvi99TfM1OH33hq3P9lfZBombOhlQ81ExsHn9/nQvSRR2eiCSY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785411949; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=i1bEwzpAqbXOusu5i/g7M0H3+pJayV2PwHxpSPHzwqY=;
 b=Ebnx7LtWfZ6Yb7cKRSolL8iN6BZjbXosWJlfUZMQifmEqxwr1kAu6SdM0s+rdXo2
 Bfn8inHYmwj8jjlsFcFJK2dnFceElnev+ttldcB7/L9RYYd9tBQZ+Jj0CUjrSlgv1yL
 uFfu+7eO/gp0qf9N8eNw806jb7n3qW4kTXgzsQHw=
Received: by mx.zohomail.com with SMTPS id 1785411948383939.3439287091678;
 Thu, 30 Jul 2026 04:45:48 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Thu, 30 Jul 2026 13:45:15 +0200
Subject: [PATCH v2 2/3] drm/panthor: Revisit reqs_lock handling in
 flush/reset paths
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-panthor-cache-flush-fix-v2-2-28790478bfff@collabora.com>
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

panthor_gpu_flush_caches() and panthor_gpu_soft_reset() would read (and
even reset) the contents of the pending_reqs register outside of holding
the reqs_lock. Additionally, when it did hold the lock, it did so with
the irqsave/irqrestore variants, even though the spinlock was never
acquired in an atomic context, just the threaded handler.

Use the new wait_event_lock_timeout() macro to check pending_reqs under
the lock, and only do so without disabling interrupts.

Fixes: 5cd894e258c4 ("drm/panthor: Add the GPU logical block")
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_gpu.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
index c013d6bf9a59..f015bde80abf 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu.c
+++ b/drivers/gpu/drm/panthor/panthor_gpu.c
@@ -330,35 +330,34 @@ int panthor_gpu_flush_caches(struct panthor_device *ptdev,
 			     u32 l2, u32 lsc, u32 other)
 {
 	struct panthor_gpu *gpu = ptdev->gpu;
-	unsigned long flags;
 	int ret = 0;
 
 	/* Serialize cache flush operations. */
 	guard(mutex)(&ptdev->gpu->cache_flush_lock);
 
-	spin_lock_irqsave(&ptdev->gpu->reqs_lock, flags);
+	spin_lock(&ptdev->gpu->reqs_lock);
 	if (!(ptdev->gpu->pending_reqs & GPU_IRQ_CLEAN_CACHES_COMPLETED)) {
 		ptdev->gpu->pending_reqs |= GPU_IRQ_CLEAN_CACHES_COMPLETED;
 		gpu_write(gpu->iomem, GPU_CMD, GPU_FLUSH_CACHES(l2, lsc, other));
 	} else {
 		ret = -EIO;
 	}
-	spin_unlock_irqrestore(&ptdev->gpu->reqs_lock, flags);
 
-	if (ret)
+	if (ret) {
+		spin_unlock(&ptdev->gpu->reqs_lock);
 		return ret;
+	}
 
-	if (!wait_event_timeout(ptdev->gpu->reqs_acked,
+	if (!wait_event_lock_timeout(ptdev->gpu->reqs_acked,
 				!(ptdev->gpu->pending_reqs & GPU_IRQ_CLEAN_CACHES_COMPLETED),
-				msecs_to_jiffies(100))) {
-		spin_lock_irqsave(&ptdev->gpu->reqs_lock, flags);
+				ptdev->gpu->reqs_lock, msecs_to_jiffies(100))) {
 		if ((ptdev->gpu->pending_reqs & GPU_IRQ_CLEAN_CACHES_COMPLETED) != 0 &&
 		    !(gpu_read(gpu->irq.iomem, INT_RAWSTAT) & GPU_IRQ_CLEAN_CACHES_COMPLETED))
 			ret = -ETIMEDOUT;
 		else
 			ptdev->gpu->pending_reqs &= ~GPU_IRQ_CLEAN_CACHES_COMPLETED;
-		spin_unlock_irqrestore(&ptdev->gpu->reqs_lock, flags);
 	}
+	spin_unlock(&ptdev->gpu->reqs_lock);
 
 	if (ret) {
 		panthor_device_schedule_reset(ptdev);
@@ -378,27 +377,25 @@ int panthor_gpu_soft_reset(struct panthor_device *ptdev)
 {
 	struct panthor_gpu *gpu = ptdev->gpu;
 	bool timedout = false;
-	unsigned long flags;
 
-	spin_lock_irqsave(&ptdev->gpu->reqs_lock, flags);
+	guard(spinlock)(&ptdev->gpu->reqs_lock);
+
 	if (!drm_WARN_ON(&ptdev->base,
 			 ptdev->gpu->pending_reqs & GPU_IRQ_RESET_COMPLETED)) {
 		ptdev->gpu->pending_reqs |= GPU_IRQ_RESET_COMPLETED;
 		gpu_write(gpu->irq.iomem, INT_CLEAR, GPU_IRQ_RESET_COMPLETED);
 		gpu_write(gpu->iomem, GPU_CMD, GPU_SOFT_RESET);
 	}
-	spin_unlock_irqrestore(&ptdev->gpu->reqs_lock, flags);
 
-	if (!wait_event_timeout(ptdev->gpu->reqs_acked,
+	if (!wait_event_lock_timeout(ptdev->gpu->reqs_acked,
 				!(ptdev->gpu->pending_reqs & GPU_IRQ_RESET_COMPLETED),
+				ptdev->gpu->reqs_lock,
 				msecs_to_jiffies(100))) {
-		spin_lock_irqsave(&ptdev->gpu->reqs_lock, flags);
 		if ((ptdev->gpu->pending_reqs & GPU_IRQ_RESET_COMPLETED) != 0 &&
 		    !(gpu_read(gpu->irq.iomem, INT_RAWSTAT) & GPU_IRQ_RESET_COMPLETED))
 			timedout = true;
 		else
 			ptdev->gpu->pending_reqs &= ~GPU_IRQ_RESET_COMPLETED;
-		spin_unlock_irqrestore(&ptdev->gpu->reqs_lock, flags);
 	}
 
 	if (timedout) {

-- 
2.55.0

