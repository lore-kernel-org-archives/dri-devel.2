Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 624C9CD37B2
	for <dri-devel@archiver.kernel.org>; Sun, 10 May 2026 22:12:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C59CD10E433;
	Sun, 10 May 2026 22:12:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="CGsYGy3j";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52B4B10E433
 for <dri-devel@lists.freedesktop.org>; Sun, 10 May 2026 22:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Z+mzO1dEG6/ujKUO/cYRaL2G+klRLeWblolrlm1OOoM=; b=CGsYGy3jlp7EKRRUyVhhPyyfDR
 yvAxRZw4yX/d1L9vx6ZK8pyOVEU7uJmCwH5588qbk2vd+RmsY2QQGzGYA4KOKPtz+tGcCunJaDOLF
 UxqhTFBFI3xRhqWRUSMy+HE8KAJ+Z4gPTG3BxLZsurXNw/5aOcKhuSHQ3D1lYq26B3s0n5yHk4dOq
 g0s1Uf3i1uYTybRO7XKuQNmWwCkVtrPvzGZkRxoNFBPyzunvJDhMi1xMSDXS7C6xxkYS8P7fBnyRq
 xBbDVDKmxjDxfn54e/M3Y9eE6/mSmVzpqZ1oqqBEOuVbFKxj8qTfCMDXnaMXNpxepa3AkYkd1ip1+
 ZHqTDq+w==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wMCNn-008k1J-KM; Mon, 11 May 2026 00:12:19 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Sun, 10 May 2026 19:11:59 -0300
Subject: [PATCH v2 02/14] drm/v3d: Clear queue->active_job when
 v3d_fence_create() fails
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260510-v3d-sched-misc-fixes-v2-2-ca4aba343ef6@igalia.com>
References: <20260510-v3d-sched-misc-fixes-v2-0-ca4aba343ef6@igalia.com>
In-Reply-To: <20260510-v3d-sched-misc-fixes-v2-0-ca4aba343ef6@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5021; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=DH3IDyBCl0LRGktlBYbiNuK1knm93bXQPH+s2C9f8ME=;
 b=owEBbAGT/pANAwAKAT/zDop2iPqqAcsmYgBqAQKztEE7ZZHqPgohO77XwA2Dap/ul/vZy0g3e
 1kryKNOg7GJATIEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCagECswAKCRA/8w6Kdoj6
 qtC/B/UYJeHIQoNNrNSMMxuNmfT/V7PVtu3eXv1rseMlXeBbwTiAbd4xv3GMDxjcHchGXfjG9Az
 DCrMYEnC4dGJNSuWmiyLTakqu+960gh0rvd3B2J4SXFogbX22ysjOZ3swmOC/mBApvDe4q0r2a8
 HGAkA3NhJYfS7kCledTEN1DJpT1e4Z1TDcE7VOAsshkr1N1DnWAKUpsR9zfv06w85W9lkeuSLIS
 i4uyZKWe22nIHf0IrHEP88Bk0/FoDz5tM/v2Mrk1BZwfIV4ibriZ8z4oY+A30dj3DbHrOIm7JCF
 Ml8HdCyh6ReH5DiemcpULh+vnyn/HCY8b1WxVbbIPqPiXWg=
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
 drivers/gpu/drm/v3d/v3d_sched.c | 52 ++++++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
index c01fa90def4c..66569b538e4e 100644
--- a/drivers/gpu/drm/v3d/v3d_sched.c
+++ b/drivers/gpu/drm/v3d/v3d_sched.c
@@ -206,12 +206,8 @@ static struct dma_fence *v3d_bin_job_run(struct drm_sched_job *sched_job)
 	struct dma_fence *fence;
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
@@ -228,7 +224,7 @@ static struct dma_fence *v3d_bin_job_run(struct drm_sched_job *sched_job)
 
 	fence = v3d_fence_create(v3d, V3D_BIN);
 	if (IS_ERR(fence))
-		return NULL;
+		goto out_clean_job;
 
 	if (job->base.irq_fence)
 		dma_fence_put(job->base.irq_fence);
@@ -256,6 +252,12 @@ static struct dma_fence *v3d_bin_job_run(struct drm_sched_job *sched_job)
 	V3D_CORE_WRITE(0, V3D_CLE_CT0QEA, job->end);
 
 	return fence;
+
+out_clean_job:
+	spin_lock_irqsave(&queue->queue_lock, irqflags);
+	queue->active_job = NULL;
+	spin_unlock_irqrestore(&queue->queue_lock, irqflags);
+	return NULL;
 }
 
 static struct dma_fence *v3d_render_job_run(struct drm_sched_job *sched_job)
@@ -265,10 +267,8 @@ static struct dma_fence *v3d_render_job_run(struct drm_sched_job *sched_job)
 	struct drm_device *dev = &v3d->drm;
 	struct dma_fence *fence;
 
-	if (unlikely(job->base.base.s_fence->finished.error)) {
-		v3d->queue[V3D_RENDER].active_job = NULL;
-		return NULL;
-	}
+	if (unlikely(job->base.base.s_fence->finished.error))
+		goto out_clean_job;
 
 	v3d->queue[V3D_RENDER].active_job = &job->base;
 
@@ -282,7 +282,7 @@ static struct dma_fence *v3d_render_job_run(struct drm_sched_job *sched_job)
 
 	fence = v3d_fence_create(v3d, V3D_RENDER);
 	if (IS_ERR(fence))
-		return NULL;
+		goto out_clean_job;
 
 	if (job->base.irq_fence)
 		dma_fence_put(job->base.irq_fence);
@@ -303,6 +303,10 @@ static struct dma_fence *v3d_render_job_run(struct drm_sched_job *sched_job)
 	V3D_CORE_WRITE(0, V3D_CLE_CT1QEA, job->end);
 
 	return fence;
+
+out_clean_job:
+	v3d->queue[V3D_RENDER].active_job = NULL;
+	return NULL;
 }
 
 static struct dma_fence *
@@ -313,16 +317,14 @@ v3d_tfu_job_run(struct drm_sched_job *sched_job)
 	struct drm_device *dev = &v3d->drm;
 	struct dma_fence *fence;
 
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
@@ -350,6 +352,10 @@ v3d_tfu_job_run(struct drm_sched_job *sched_job)
 	V3D_WRITE(V3D_TFU_ICFG(v3d->ver), job->args.icfg | V3D_TFU_ICFG_IOC);
 
 	return fence;
+
+out_clean_job:
+	v3d->queue[V3D_TFU].active_job = NULL;
+	return NULL;
 }
 
 static struct dma_fence *
@@ -361,10 +367,8 @@ v3d_csd_job_run(struct drm_sched_job *sched_job)
 	struct dma_fence *fence;
 	int i, csd_cfg0_reg;
 
-	if (unlikely(job->base.base.s_fence->finished.error)) {
-		v3d->queue[V3D_CSD].active_job = NULL;
-		return NULL;
-	}
+	if (unlikely(job->base.base.s_fence->finished.error))
+		goto out_clean_job;
 
 	v3d->queue[V3D_CSD].active_job = &job->base;
 
@@ -372,7 +376,7 @@ v3d_csd_job_run(struct drm_sched_job *sched_job)
 
 	fence = v3d_fence_create(v3d, V3D_CSD);
 	if (IS_ERR(fence))
-		return NULL;
+		goto out_clean_job;
 
 	if (job->base.irq_fence)
 		dma_fence_put(job->base.irq_fence);
@@ -399,6 +403,10 @@ v3d_csd_job_run(struct drm_sched_job *sched_job)
 	V3D_CORE_WRITE(0, csd_cfg0_reg, job->args.cfg[0]);
 
 	return fence;
+
+out_clean_job:
+	v3d->queue[V3D_CSD].active_job = NULL;
+	return NULL;
 }
 
 static void

-- 
2.54.0

