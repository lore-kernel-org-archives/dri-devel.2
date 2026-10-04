Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A21BCA5FCE
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 15:42:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8413710E159;
	Sun,  4 Oct 2026 15:42:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="cCKmS4Nq";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CDCB10E159
 for <dri-devel@lists.freedesktop.org>; Sun,  4 Oct 2026 15:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=GiL6iXRQlAn7k07iDJpmMhMe/UWMauiAfzMX914rOrA=; b=cCKmS4NqVxJyQVSuP7pZhfkI+S
 O9WbeDie6WvJsnz0qi/bxTcHSqTdr6gHkvgw1K0afYXYkhYFiN+vKdabsRLi1ETtKPAuiOUTR3wSr
 7xe4VnL6M0GrcHxbcd64HwoPtmSlIrm2Pk5VSlWVJw+MOW3D6WZWnbMy6mVtvSCKtP001zOMtJNp4
 hv5F3F/4aGKTosRSvs9R9TX7utETrionnSJzJ5YODegBZXtC+6dDXIM0TKDvKzK3yPNeVAMPKZ7wO
 z4yBylMFAibV9W8xQCnJ4bQDlMPJIovM8rhcfi3PmpRZutb06lPTJX+RBVWtpJg9ZAErBFEcNz0GK
 juFksnkA==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xDOMF-00BNsh-14; Sun, 04 Oct 2026 17:42:35 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Sun, 04 Oct 2026 12:42:05 -0300
Subject: [PATCH 05/11] drm/vc4: Attach the job fences outside of job_lock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-vc4-misc-fixes-v1-5-b763df9e33e1@igalia.com>
References: <20261004-vc4-misc-fixes-v1-0-b763df9e33e1@igalia.com>
In-Reply-To: <20261004-vc4-misc-fixes-v1-0-b763df9e33e1@igalia.com>
To: Iago Toral <itoral@igalia.com>, Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2948; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=NX6Ac0LQk7p4C4UrVz5f4u7U8i9vlyN1NDHLrx+ibG8=;
 b=owGbwMvMwMVo/5mvq6zj1yrG02pJDFmHiq/bWhy5FB0lqGHbuVH1rK7c072KKk4urTHOi+87C
 apwht3pZDRmYWDkYpAVU2T58SS2llGsnF1zWflFmEGsTCBTGLg4BWAifIrsf6UntMo9b5j1NS8/
 Klh7nQjTHe3KDsdbJSs+J2mzlTNKnwopcbv2XjHqDf/F/IdP09cvM1+5qr89a/l8t53p3P87a91
 apXvO9O2eKxr0UVGivvdt7cWDC0S29hhtU3onOO1M+ULl+GrGOc+dOM4EuqzuXaBb0Sdy7eP5OF
 XV17M7Fv09qbekRsff76jJqe16lq0ex9vt/V45dt/0jDu7siZi33ffSb3iDbMc3FnXSRy2rPqVl
 hHvpb9u4wq/9sUyZhmBR/mdFdW1eRjc9kYmafJFvqxIO8zPOcc+iHW+DlfGT2PryIC/fBPbPsWr
 vf9SUC4ifWTfpMU+b522THTVYVn6W+3NTfX3W5/ne1wEAA==
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

vc4_attach_fences() adds the job fence to the reservation of every BO the
job touches, which is a O(bo_count) walk under job_lock. It was there
because vc4_exec_info could be freed by the job done worker the moment the
lock was dropped.

As vc4_exec_info is refcounted now, hand the fences over after the unlock.

Note that the render done handler dropped the fence as soon as the job
completed, so the walk could find exec->fence already cleared. Leave the
fence to be dropped by the release path. The submit path no longer needs
a reference of its own to publish the fence through the sync object either.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/vc4/vc4_gem.c | 23 ++++++-----------------
 drivers/gpu/drm/vc4/vc4_irq.c |  5 +----
 2 files changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_gem.c b/drivers/gpu/drm/vc4/vc4_gem.c
index 9cf343297f83..ae76868663ea 100644
--- a/drivers/gpu/drm/vc4/vc4_gem.c
+++ b/drivers/gpu/drm/vc4/vc4_gem.c
@@ -639,14 +639,6 @@ vc4_queue_submit(struct drm_device *dev, struct vc4_exec_info *exec,
 
 	kref_get(&exec->refcount);
 
-	/* The job can complete and drop exec->fence as soon as job_lock is
-	 * released, so hold our own reference.
-	 */
-	if (out_sync)
-		dma_fence_get(&fence->base);
-
-	vc4_attach_fences(exec);
-
 	list_add_tail(&exec->head, &vc4->bin_job_list);
 
 	/* If no bin job was executing and if the render job (if any) has the
@@ -663,12 +655,12 @@ vc4_queue_submit(struct drm_device *dev, struct vc4_exec_info *exec,
 
 	spin_unlock_irqrestore(&vc4->job_lock, irqflags);
 
+	vc4_attach_fences(exec);
+
 	drm_exec_fini(exec_ctx);
 
-	if (out_sync) {
+	if (out_sync)
 		drm_syncobj_replace_fence(out_sync, &fence->base);
-		dma_fence_put(&fence->base);
-	}
 
 	return 0;
 }
@@ -862,13 +854,10 @@ vc4_release_exec(struct kref *ref)
 	unsigned long irqflags;
 	unsigned i;
 
-	/* If we got force-completed because of GPU reset rather than
-	 * through our IRQ handler, signal the fence now.
+	/* The render done handler signals the fence, so only drop the
+	 * reference here.
 	 */
-	if (exec->fence) {
-		dma_fence_signal(exec->fence);
-		dma_fence_put(exec->fence);
-	}
+	dma_fence_put(exec->fence);
 
 	if (exec->bo) {
 		for (i = 0; i < exec->bo_count; i++) {
diff --git a/drivers/gpu/drm/vc4/vc4_irq.c b/drivers/gpu/drm/vc4/vc4_irq.c
index 6ced2835dfdc..241249b6582b 100644
--- a/drivers/gpu/drm/vc4/vc4_irq.c
+++ b/drivers/gpu/drm/vc4/vc4_irq.c
@@ -193,11 +193,8 @@ vc4_irq_finish_render_job(struct drm_device *dev)
 	else if (nextbin && nextbin->perfmon != exec->perfmon)
 		vc4_submit_next_bin_job(dev);
 
-	if (exec->fence) {
+	if (exec->fence)
 		dma_fence_signal_locked(exec->fence);
-		dma_fence_put(exec->fence);
-		exec->fence = NULL;
-	}
 
 	wake_up_all(&vc4->job_wait_queue);
 	schedule_work(&vc4->job_done_work);

-- 
2.55.0

