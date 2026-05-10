Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73BE1CD37B2
	for <dri-devel@archiver.kernel.org>; Sun, 10 May 2026 22:12:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D630E10E435;
	Sun, 10 May 2026 22:12:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="AJLaA3nP";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD33D10E435
 for <dri-devel@lists.freedesktop.org>; Sun, 10 May 2026 22:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=c3VUU1ThhuXGrnJhzOSePKUdMf9ILg+Oa/1v8oMsF7Y=; b=AJLaA3nPUxMuWiQvQ5myOF72z9
 Z41hzzu355oubOJT6CLTyeMvPjmQV8d/SBxrLaZWbf2tezFMu97YGSUlIXqOShxcvt+r0yT6DWJP9
 lKkSm7BFO0j6KQsc+cPG6vX4B6m2Ua9bDjAxTwZmGw+0UXnlGvF4NN2YEByJobWYDmEN+SiSVGPab
 zmTINlqN52fc/JhcM3v+AJc0l+DghvVKfwuvpDyATM5HAQ2K6I4rhI2PxbL8sQhaKdNbribwZPmtJ
 49/RildjB/ur/OTWJX07nDatBrN4qA0C4Xnp0FIMCgsW6rM+Tq5FuGklHg3U47CnuhQCGlYoMSTw9
 7iVzChHw==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wMCNw-008k1J-Cl; Mon, 11 May 2026 00:12:27 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Sun, 10 May 2026 19:12:01 -0300
Subject: [PATCH v2 04/14] drm/v3d: Replace spin_lock_irqsave() with spin_lock()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260510-v3d-sched-misc-fixes-v2-4-ca4aba343ef6@igalia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3574; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=nWXVgLvfeXapfBl+TknZa1R0p58YVmbslFrgiapXWCU=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqAQK0SiXRuBTcmAgJ9djXJWfEd2nUtRmciRcBK
 dyDjTDL7uSJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCagECtAAKCRA/8w6Kdoj6
 qsx6CACcQc+dhsxHSHJZRsg+2BVu7PWDX6cAQtoUT1WDZl6iF3nHMQJ6DnB2oKn5a/6kUvCE59S
 o8lKWcvx01wf/VoErpf+ufLrSUitWCq0GAObzlzMpglBuI1vEdes/q+nA5FvkWG+7+nslRrwtaB
 /QzoEtgSsyGWy0VNV1a90OOjOtCL3JNg2IzJBFhLJ54RYnf29V/nWiO9jFuCll4bZB9JaZaCQOh
 z3t1oc0+9KIObS2JXA6mrkFPLaI7VI3k3lQI/e1GfXNF0SpjersWeT3QeXJe4Q6DJnzDh0cSmvX
 BOJSJmlg7QXlLA7RpPm48fdOQPoORrgvA3m/RieEtLqezIuH
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

queue->queue_lock is only acquired from v3d_overflow_mem_work() and
v3d_bin_job_run(), both of which run from workqueue context. The hard
IRQ handler does not take this lock, so disabling interrupts while
holding it is unnecessary.

Drop the spin_lock_irqsave() and use plain spin_(un)lock() instead.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_irq.c   | 17 +++++++----------
 drivers/gpu/drm/v3d/v3d_sched.c | 21 ++++++++++-----------
 2 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_irq.c b/drivers/gpu/drm/v3d/v3d_irq.c
index 86efaef2722c..754a969b862b 100644
--- a/drivers/gpu/drm/v3d/v3d_irq.c
+++ b/drivers/gpu/drm/v3d/v3d_irq.c
@@ -47,7 +47,6 @@ v3d_overflow_mem_work(struct work_struct *work)
 	struct v3d_queue_state *queue = &v3d->queue[V3D_BIN];
 	struct v3d_bin_job *bin_job;
 	struct drm_gem_object *obj;
-	unsigned long irqflags;
 
 	if (IS_ERR(bo)) {
 		drm_err(dev, "Couldn't allocate binner overflow mem\n");
@@ -64,18 +63,16 @@ v3d_overflow_mem_work(struct work_struct *work)
 	 * bin job got scheduled, that's fine.  We'll just give them
 	 * some binner pool anyway.
 	 */
-	spin_lock_irqsave(&queue->queue_lock, irqflags);
-	bin_job = (struct v3d_bin_job *)queue->active_job;
+	scoped_guard(spinlock, &queue->queue_lock) {
+		bin_job = (struct v3d_bin_job *)queue->active_job;
 
-	if (!bin_job) {
-		spin_unlock_irqrestore(&queue->queue_lock, irqflags);
-		goto out;
+		if (!bin_job)
+			goto out;
+
+		drm_gem_object_get(obj);
+		list_add_tail(&bo->unref_head, &bin_job->render->unref_list);
 	}
 
-	drm_gem_object_get(obj);
-	list_add_tail(&bo->unref_head, &bin_job->render->unref_list);
-	spin_unlock_irqrestore(&queue->queue_lock, irqflags);
-
 	v3d_mmu_flush_all(v3d);
 
 	V3D_CORE_WRITE(0, V3D_PTB_BPOA, bo->node.start << V3D_MMU_PAGE_SHIFT);
diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
index 66569b538e4e..cc3212e2cb5d 100644
--- a/drivers/gpu/drm/v3d/v3d_sched.c
+++ b/drivers/gpu/drm/v3d/v3d_sched.c
@@ -204,7 +204,6 @@ static struct dma_fence *v3d_bin_job_run(struct drm_sched_job *sched_job)
 	struct v3d_queue_state *queue = &v3d->queue[V3D_BIN];
 	struct drm_device *dev = &v3d->drm;
 	struct dma_fence *fence;
-	unsigned long irqflags;
 
 	if (unlikely(job->base.base.s_fence->finished.error))
 		goto out_clean_job;
@@ -212,13 +211,13 @@ static struct dma_fence *v3d_bin_job_run(struct drm_sched_job *sched_job)
 	/* Lock required around bin_job update vs
 	 * v3d_overflow_mem_work().
 	 */
-	spin_lock_irqsave(&queue->queue_lock, irqflags);
-	queue->active_job = &job->base;
-	/* Clear out the overflow allocation, so we don't
-	 * reuse the overflow attached to a previous job.
-	 */
-	V3D_CORE_WRITE(0, V3D_PTB_BPOS, 0);
-	spin_unlock_irqrestore(&queue->queue_lock, irqflags);
+	scoped_guard(spinlock, &queue->queue_lock) {
+		queue->active_job = &job->base;
+		/* Clear out the overflow allocation, so we don't
+		 * reuse the overflow attached to a previous job.
+		 */
+		V3D_CORE_WRITE(0, V3D_PTB_BPOS, 0);
+	}
 
 	v3d_invalidate_caches(v3d);
 
@@ -254,9 +253,9 @@ static struct dma_fence *v3d_bin_job_run(struct drm_sched_job *sched_job)
 	return fence;
 
 out_clean_job:
-	spin_lock_irqsave(&queue->queue_lock, irqflags);
-	queue->active_job = NULL;
-	spin_unlock_irqrestore(&queue->queue_lock, irqflags);
+	scoped_guard(spinlock, &queue->queue_lock) {
+		queue->active_job = NULL;
+	}
 	return NULL;
 }
 

-- 
2.54.0

