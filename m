Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B04CD8CA8
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 17:22:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A5AD10F5EF;
	Fri, 12 Jun 2026 17:22:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="AQjTmxde";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C35510F5E0;
 Fri, 12 Jun 2026 17:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=giqX5YIC/sRKfgp5Q5cEU9Sqogo3TyEDFXoM3kzv0sE=; b=AQjTmxdenSQSLdMSarv9H5hZmG
 uNz5mgzbklXQibvDIEkg587KUAweFZSxqa7OGTG3V8+3Ay3YH8YqJVnGtyLXG+0ItxHFZCfp2msLx
 SB9q3gfqJs8sp5iogsS7pzVtiVkVUucxSyjfrX/fElEEih8ZNn3Y+CJRw3l/6yVl8FyhnxJhERDfL
 8Us1fXXv2OKI7Eq3ZIV02wfOyYsoPM23/jmIKdajKz0ARE/14i6Z63b2MNQXS1hpIIrxH7yYeQjrk
 Ja7jeQi3UOSZu7M9lqH0X+bqANgUONYzV8HX8vd0qZ7UkCPt4TxyIM5g3fTOnGt+Qu3IJSnEZgqkT
 RovFv7lQ==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wY5aP-00Ghm9-B1; Fri, 12 Jun 2026 19:22:29 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Philipp Stanner <phasta@kernel.org>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>, nouveau@lists.freedesktop.org
Subject: [PATCH v2] drm/nouveau: Simplify nouveau_cli_work
Date: Fri, 12 Jun 2026 18:22:27 +0100
Message-ID: <20260612172227.54893-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612165409.54447-1-tvrtko.ursulin@igalia.com>
References: <20260612165409.54447-1-tvrtko.ursulin@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

I don't claim this fixes anything but the code certainly was a bit
roundabout and this at least cleans it up.

The only semantic difference is releasing the fence reference after
the work callback is called. Which kind of make sense anyway.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: Lyude Paul <lyude@redhat.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: nouveau@lists.freedesktop.org
---
v2:
 * Don't dereference work after work->func(work) frees it.
---
Not even compile tested!
---
 drivers/gpu/drm/nouveau/nouveau_drm.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index 42a81166f3a9..e81ec261689a 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -153,22 +153,6 @@ nouveau_name(struct drm_device *dev)
 		return nouveau_platform_name(to_platform_device(dev->dev));
 }
 
-static inline bool
-nouveau_cli_work_ready(struct dma_fence *fence)
-{
-	unsigned long flags;
-	bool ret = true;
-
-	dma_fence_lock_irqsave(fence, flags);
-	if (!dma_fence_is_signaled_locked(fence))
-		ret = false;
-	dma_fence_unlock_irqrestore(fence, flags);
-
-	if (ret == true)
-		dma_fence_put(fence);
-	return ret;
-}
-
 static void
 nouveau_cli_work(struct work_struct *w)
 {
@@ -176,9 +160,12 @@ nouveau_cli_work(struct work_struct *w)
 	struct nouveau_cli_work *work, *wtmp;
 	mutex_lock(&cli->lock);
 	list_for_each_entry_safe(work, wtmp, &cli->worker, head) {
-		if (!work->fence || nouveau_cli_work_ready(work->fence)) {
+		struct dma_fence *fence = work->fence;
+
+		if (!fence || dma_fence_is_signaled(fence)) {
 			list_del(&work->head);
 			work->func(work);
+			dma_fence_put(fence);
 		}
 	}
 	mutex_unlock(&cli->lock);
-- 
2.54.0

