Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C04C4CD6E55
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 22:25:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2984A112429;
	Wed,  3 Jun 2026 22:25:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="iBCjyRqy";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A58C711242A
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 22:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CpXQCqcgom63Ow8nmkO+w8FCE3Yl6MWK7STCPFxraxw=; b=iBCjyRqyOEDmIM2L3H0SLMzxYq
 AvjHhsD2opmnSbSWTP9pPWWTBMx8rPuQ/O5wtuq2VKp5YNzHBhZVLifc++QhDWLLdjMHbV3p6yGbx
 0Yd8Q5YBNb8CAd4Df8KsFvjA4jvRzXJjoUH+0y7RxnIPC4GUDgmnQA/LJffigVqGYSKPr39yWqv+l
 u2BbWAtOCU//mXKrA6nfq93Lyhj23r6ETI3wzQhmRoJQBV8Ku1pac+QehArnoO0Y5onIbslDopUb9
 LjPgz9i+ZM+n7CfCgTPEgIMkz4uEiBraXgCjji57mui/fworDOn7XT1D+XzYih1fSCjPICbw6iR1K
 fLMFhBSA==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wUu1j-00CNgx-9E; Thu, 04 Jun 2026 00:25:31 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Wed, 03 Jun 2026 19:25:06 -0300
Subject: [PATCH v3 04/14] drm/v3d: Replace spin_lock_irqsave() with spin_lock()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260603-v3d-sched-misc-fixes-v3-4-d7114bba55a0@igalia.com>
References: <20260603-v3d-sched-misc-fixes-v3-0-d7114bba55a0@igalia.com>
In-Reply-To: <20260603-v3d-sched-misc-fixes-v3-0-d7114bba55a0@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3631; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=rdhQuTWLWWba4sJsEpcV9w1vtli4QK8MeBjtnKxQbPU=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqIKnGPHQJ3wOlpQRboaMOGxC1f9Ed0fKmtcFuP
 fCl20D4p/eJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCaiCpxgAKCRA/8w6Kdoj6
 qo8qB/9ZUqKQ2iWdcBhjC8l+fSOhTun6Dd7FX25MPvsPs4OKTOdlQOZKHsj8DUpRDcRIpVErPTI
 mwIsEqq2xvQtLMFYi0GA3S2QzNQlH2rNSc/GrRQdvr9wcoXnObxp8xkerStG1siwsko2jfluIN8
 VHVqiI99YFNkYLUPS5GSaKIKIrxkQlltcCnbt6Ja4fuAT4pN5P71vQOS3X7Co0mj1nalBbQo0sY
 8czdVupxixy34ODNUnOweQBkQGHvcEwaN32AnMHhVYEWTyX/6xVNzX04L8LERI6x4NuPxzHd9Y4
 oUNZsfWn0Cy9igUZ6nXt9nl2tSPCDXZRV5MOjDqXiWGxgHeF
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

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
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
index 46f4fc09c59e..04fd1a365576 100644
--- a/drivers/gpu/drm/v3d/v3d_sched.c
+++ b/drivers/gpu/drm/v3d/v3d_sched.c
@@ -190,7 +190,6 @@ static struct dma_fence *v3d_bin_job_run(struct drm_sched_job *sched_job)
 	struct v3d_queue_state *queue = &v3d->queue[V3D_BIN];
 	struct drm_device *dev = &v3d->drm;
 	struct dma_fence *fence;
-	unsigned long irqflags;
 
 	if (unlikely(job->base.base.s_fence->finished.error))
 		goto out_clean_job;
@@ -198,13 +197,13 @@ static struct dma_fence *v3d_bin_job_run(struct drm_sched_job *sched_job)
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
 
@@ -240,9 +239,9 @@ static struct dma_fence *v3d_bin_job_run(struct drm_sched_job *sched_job)
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

