Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00EF1F34C5E
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 15:05:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5940B10E4BA;
	Mon, 13 Apr 2026 15:05:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="sCKHg/h2";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4108310E4BA
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 15:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wQ1WqUpj6pYvp+PIoU39Hjk0t60+ZgqjyO47n+sx6RM=; b=sCKHg/h2OW+sdo+fmY2zmn8twA
 QM2rK/fxOA1IQnRYENYiHHVk9UKt/QfOul7gJD7LxCVuaN+qnVhEOjMoOIDZDzwjKus6SW5K/csM6
 yJqAgKvO2qwv1JL4694LGRY5qcwnDTpYi4KCnkbsdmL3AROIW1L0e8nlJMFScjWfqqbqlUhieMXZ2
 nDYQ5rkkgRZo2N+FHcHrFo2esmbo65PikQofla8JKJ/uOOuiEpUjkSkbHALriakYkrW37NUMyDPKU
 l2nGuJo5ecF3qMptiHuV6pjafT11y0n1q/1IMXvYS1tILwFK2zuhqNFCHoETYVnnLh9ejhG2nCXFR
 iPArcKNw==;
Received: from [189.7.87.169] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wCIr6-00FSq1-SH; Mon, 13 Apr 2026 17:05:41 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Mon, 13 Apr 2026 12:03:19 -0300
Subject: [PATCH 04/10] drm/v3d: Replace spin_lock_irqsave() with
 spin_lock_irq()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260413-v3d-sched-misc-fixes-v1-4-bac63a8ceb6c@igalia.com>
References: <20260413-v3d-sched-misc-fixes-v1-0-bac63a8ceb6c@igalia.com>
In-Reply-To: <20260413-v3d-sched-misc-fixes-v1-0-bac63a8ceb6c@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3086; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=StIcdVzeKR4LyxoWDRp9CuWz+vUgqaOZd5/59ffMx94=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBp3QYtRy/11cju9cifcxkt4OuX6P8qrxKnXzYm3
 wK0RXr6rqGJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCad0GLQAKCRA/8w6Kdoj6
 qqkNB/4iw0jQbBdGF4dr7Dn5+zrrm5TfsRXPeQl77S6fbHX3vPX/gpzQdSPafuZ26TpLAytAfqR
 /dvcr3EwtP5vVajLa5469u65EPHSlEkPkOv1yL7ol/sGE94H3Ald3UuWtStqQozNf44cvLkBKcG
 b6jKnq0wcqSyMfGrQhhZgMTZaWMPT+1KfDpBP6PRBpw3Fkt5Bc1L875HhwlteVeluIl+EaOvYJA
 D9W/orweV5JnlyQImqlvLRLUIUjFjUEJexcHtYs0BTWfMo2kHMT5QjVl8EeG3k0Ahp2wVmudyg5
 1rsMETU8EfV0vaBFSFE7ZFKY0kmis0TxZR9trKTvfksp9hsv
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

v3d_overflow_mem_work() and v3d_bin_job_run() both run from workqueue
context where IRQs are always enabled, so the flags save/restore of
spin_lock_irqsave() is unnecessary. Use spin_lock_irq() instead.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_irq.c   | 7 +++----
 drivers/gpu/drm/v3d/v3d_sched.c | 9 ++++-----
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_irq.c b/drivers/gpu/drm/v3d/v3d_irq.c
index 86efaef2722c..d4d7c39227be 100644
--- a/drivers/gpu/drm/v3d/v3d_irq.c
+++ b/drivers/gpu/drm/v3d/v3d_irq.c
@@ -47,7 +47,6 @@ v3d_overflow_mem_work(struct work_struct *work)
 	struct v3d_queue_state *queue = &v3d->queue[V3D_BIN];
 	struct v3d_bin_job *bin_job;
 	struct drm_gem_object *obj;
-	unsigned long irqflags;
 
 	if (IS_ERR(bo)) {
 		drm_err(dev, "Couldn't allocate binner overflow mem\n");
@@ -64,17 +63,17 @@ v3d_overflow_mem_work(struct work_struct *work)
 	 * bin job got scheduled, that's fine.  We'll just give them
 	 * some binner pool anyway.
 	 */
-	spin_lock_irqsave(&queue->queue_lock, irqflags);
+	spin_lock_irq(&queue->queue_lock);
 	bin_job = (struct v3d_bin_job *)queue->active_job;
 
 	if (!bin_job) {
-		spin_unlock_irqrestore(&queue->queue_lock, irqflags);
+		spin_unlock_irq(&queue->queue_lock);
 		goto out;
 	}
 
 	drm_gem_object_get(obj);
 	list_add_tail(&bo->unref_head, &bin_job->render->unref_list);
-	spin_unlock_irqrestore(&queue->queue_lock, irqflags);
+	spin_unlock_irq(&queue->queue_lock);
 
 	v3d_mmu_flush_all(v3d);
 
diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
index d42db75e639b..f3999678e5da 100644
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
+	spin_lock_irq(&queue->queue_lock);
 	queue->active_job = &job->base;
 	/* Clear out the overflow allocation, so we don't
 	 * reuse the overflow attached to a previous job.
 	 */
 	V3D_CORE_WRITE(0, V3D_PTB_BPOS, 0);
-	spin_unlock_irqrestore(&queue->queue_lock, irqflags);
+	spin_unlock_irq(&queue->queue_lock);
 
 	v3d_invalidate_caches(v3d);
 
@@ -254,9 +253,9 @@ static struct dma_fence *v3d_bin_job_run(struct drm_sched_job *sched_job)
 	return fence;
 
 out_clean_job:
-	spin_lock_irqsave(&queue->queue_lock, irqflags);
+	spin_lock_irq(&queue->queue_lock);
 	queue->active_job = NULL;
-	spin_unlock_irqrestore(&queue->queue_lock, irqflags);
+	spin_unlock_irq(&queue->queue_lock);
 	return NULL;
 }
 

-- 
2.53.0

