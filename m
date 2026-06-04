Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DBB3CD6E75
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 20:32:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEDA010F0D8;
	Thu,  4 Jun 2026 20:32:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="BihJD0rf";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2048910F0D8
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 20:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bdP71f/ifbAyXzWUa081iqk+wlRkr0dWO8a3nS2bdeo=; b=BihJD0rfKYX+eq7EvSpDb/S0js
 GI2i2ppFcdmRuPxhSR86MMXxi+8/2uTQzwlek3YYy+kU19E3Fqxq83pY+OjoHu9+efQTsmFXAR7lf
 pIQHgb+Dk8Xe588VZl9CCw1uGK+vgjPt65bxUkkJbARMT6dKMQw2774HclHgtjizu/tWd6DVpcmPm
 lSCNFJWiu6t7ls6cjfBII+LYCQlBrr80XSF0eMZI1J2M8mvYEj4R7f2RHs8PhCdqtp1S7JcqSVN6K
 5aR8aXi6TnXp6uiuSyX6TK36LzUlR9MJaXfQVwe2p75E6hSSDdf6YpcVooOh6/2J+fn3v1rRq9sdd
 YlHJxYtw==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wVEjx-00CoGD-41; Thu, 04 Jun 2026 22:32:33 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Thu, 04 Jun 2026 17:32:15 -0300
Subject: [PATCH v4 02/12] drm/v3d: Clear queue->active_job when
 v3d_fence_create() fails
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260604-v3d-sched-misc-fixes-v4-2-c068f5bf5ccf@igalia.com>
References: <20260604-v3d-sched-misc-fixes-v4-0-c068f5bf5ccf@igalia.com>
In-Reply-To: <20260604-v3d-sched-misc-fixes-v4-0-c068f5bf5ccf@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5625; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=x6b9YrU2z9Y21AC1rJ60E5P1oJOK/VQULn6HRGMe9D4=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqIeDTDcdXFbHpLCeM6aJcYaunnJc+Y8CPUiI16
 cFqFlIb6ReJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCaiHg0wAKCRA/8w6Kdoj6
 qnXfB/9z3XxoNcexraLbXQcuWX0EUytl4Dxtjngm7vrXbDHP3MK33Tr8C0GE1WLlWFtgfsHb/3A
 QP54XoM063cJIVkfTB+WWn92IR2UKplS7tswRURpo7IcvdIis35/66iJ+svYrYX8DLT7Lcu3L45
 lZnZv3ZegLYv1f0jxe7u+msFLUjKE03UD0RbjpoW4KdhZqlbdnEj104ayH1Hcr4p9GR4pVHTxZC
 Y9zBmGeoqJfZ/3qvW5ABIBo5tH44iax2Tl+eCSU1Bs1jdAb50J7BIXMuIpiR6Tke0RSoMO8b77X
 ZHUNzHzuApDP297Kqg+aZu+W6TlXcx0Z18XG6DzE86ti/6n3
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
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

The run_job() callbacks for BIN, RENDER, TFU and CSD assign the incoming
job to queue->active_job before calling v3d_fence_create(). If
v3d_fence_create() fails, the callback returns NULL without clearing
active_job, leaving a dangling pointer.

Create a failure path in all run_job() callbacks that clears the active
job before returning NULL. The BIN path takes queue->queue_lock around the
clear as it races against v3d_overflow_mem_work(); RENDER, TFU and CSD
paths have no concurrent reader, so the clear is lock-free.

Fixes: a783a09ee76d ("drm/v3d: Refactor job management.")
Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_sched.c | 60 +++++++++++++++++++++++------------------
 1 file changed, 34 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
index 0e266b29317f..7f9a71022e5e 100644
--- a/drivers/gpu/drm/v3d/v3d_sched.c
+++ b/drivers/gpu/drm/v3d/v3d_sched.c
@@ -189,15 +189,11 @@ static struct dma_fence *v3d_bin_job_run(struct drm_sched_job *sched_job)
 	struct v3d_dev *v3d = job->base.v3d;
 	struct v3d_queue_state *queue = &v3d->queue[V3D_BIN];
 	struct drm_device *dev = &v3d->drm;
-	struct dma_fence *fence;
+	struct dma_fence *fence = NULL;
 	unsigned long irqflags;
 
-	if (unlikely(job->base.base.s_fence->finished.error)) {
-		spin_lock_irqsave(&queue->queue_lock, irqflags);
-		queue->active_job = NULL;
-		spin_unlock_irqrestore(&queue->queue_lock, irqflags);
-		return NULL;
-	}
+	if (unlikely(job->base.base.s_fence->finished.error))
+		goto out_clean_job;
 
 	/* Lock required around bin_job update vs
 	 * v3d_overflow_mem_work().
@@ -214,7 +210,7 @@ static struct dma_fence *v3d_bin_job_run(struct drm_sched_job *sched_job)
 
 	fence = v3d_fence_create(v3d, V3D_BIN);
 	if (IS_ERR(fence))
-		return NULL;
+		goto out_clean_job;
 
 	if (job->base.irq_fence)
 		dma_fence_put(job->base.irq_fence);
@@ -242,6 +238,12 @@ static struct dma_fence *v3d_bin_job_run(struct drm_sched_job *sched_job)
 	V3D_CORE_WRITE(0, V3D_CLE_CT0QEA, job->end);
 
 	return fence;
+
+out_clean_job:
+	spin_lock_irqsave(&queue->queue_lock, irqflags);
+	queue->active_job = NULL;
+	spin_unlock_irqrestore(&queue->queue_lock, irqflags);
+	return fence;
 }
 
 static struct dma_fence *v3d_render_job_run(struct drm_sched_job *sched_job)
@@ -249,12 +251,10 @@ static struct dma_fence *v3d_render_job_run(struct drm_sched_job *sched_job)
 	struct v3d_render_job *job = to_render_job(sched_job);
 	struct v3d_dev *v3d = job->base.v3d;
 	struct drm_device *dev = &v3d->drm;
-	struct dma_fence *fence;
+	struct dma_fence *fence = NULL;
 
-	if (unlikely(job->base.base.s_fence->finished.error)) {
-		v3d->queue[V3D_RENDER].active_job = NULL;
-		return NULL;
-	}
+	if (unlikely(job->base.base.s_fence->finished.error))
+		goto out_clean_job;
 
 	v3d->queue[V3D_RENDER].active_job = &job->base;
 
@@ -268,7 +268,7 @@ static struct dma_fence *v3d_render_job_run(struct drm_sched_job *sched_job)
 
 	fence = v3d_fence_create(v3d, V3D_RENDER);
 	if (IS_ERR(fence))
-		return NULL;
+		goto out_clean_job;
 
 	if (job->base.irq_fence)
 		dma_fence_put(job->base.irq_fence);
@@ -289,6 +289,10 @@ static struct dma_fence *v3d_render_job_run(struct drm_sched_job *sched_job)
 	V3D_CORE_WRITE(0, V3D_CLE_CT1QEA, job->end);
 
 	return fence;
+
+out_clean_job:
+	v3d->queue[V3D_RENDER].active_job = NULL;
+	return fence;
 }
 
 static struct dma_fence *
@@ -297,18 +301,16 @@ v3d_tfu_job_run(struct drm_sched_job *sched_job)
 	struct v3d_tfu_job *job = to_tfu_job(sched_job);
 	struct v3d_dev *v3d = job->base.v3d;
 	struct drm_device *dev = &v3d->drm;
-	struct dma_fence *fence;
+	struct dma_fence *fence = NULL;
 
-	if (unlikely(job->base.base.s_fence->finished.error)) {
-		v3d->queue[V3D_TFU].active_job = NULL;
-		return NULL;
-	}
+	if (unlikely(job->base.base.s_fence->finished.error))
+		goto out_clean_job;
 
 	v3d->queue[V3D_TFU].active_job = &job->base;
 
 	fence = v3d_fence_create(v3d, V3D_TFU);
 	if (IS_ERR(fence))
-		return NULL;
+		goto out_clean_job;
 
 	if (job->base.irq_fence)
 		dma_fence_put(job->base.irq_fence);
@@ -336,6 +338,10 @@ v3d_tfu_job_run(struct drm_sched_job *sched_job)
 	V3D_WRITE(V3D_TFU_ICFG(v3d->ver), job->args.icfg | V3D_TFU_ICFG_IOC);
 
 	return fence;
+
+out_clean_job:
+	v3d->queue[V3D_TFU].active_job = NULL;
+	return fence;
 }
 
 static struct dma_fence *
@@ -344,13 +350,11 @@ v3d_csd_job_run(struct drm_sched_job *sched_job)
 	struct v3d_csd_job *job = to_csd_job(sched_job);
 	struct v3d_dev *v3d = job->base.v3d;
 	struct drm_device *dev = &v3d->drm;
-	struct dma_fence *fence;
+	struct dma_fence *fence = NULL;
 	int i, csd_cfg0_reg;
 
-	if (unlikely(job->base.base.s_fence->finished.error)) {
-		v3d->queue[V3D_CSD].active_job = NULL;
-		return NULL;
-	}
+	if (unlikely(job->base.base.s_fence->finished.error))
+		goto out_clean_job;
 
 	v3d->queue[V3D_CSD].active_job = &job->base;
 
@@ -358,7 +362,7 @@ v3d_csd_job_run(struct drm_sched_job *sched_job)
 
 	fence = v3d_fence_create(v3d, V3D_CSD);
 	if (IS_ERR(fence))
-		return NULL;
+		goto out_clean_job;
 
 	if (job->base.irq_fence)
 		dma_fence_put(job->base.irq_fence);
@@ -385,6 +389,10 @@ v3d_csd_job_run(struct drm_sched_job *sched_job)
 	V3D_CORE_WRITE(0, csd_cfg0_reg, job->args.cfg[0]);
 
 	return fence;
+
+out_clean_job:
+	v3d->queue[V3D_CSD].active_job = NULL;
+	return fence;
 }
 
 static void

-- 
2.54.0

