Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88B91CD98DA
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 09:26:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0351110E306;
	Mon, 15 Jun 2026 09:26:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Q5II/wnL";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FBAD10E306;
 Mon, 15 Jun 2026 09:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=AFbxkkRxzTzUXO/FNSBftteSoe9VZ2wpMdFpozFnn6I=; b=Q5II/wnLB1zwvkjimGARjRvI9u
 AaFY5SzxWtMGgvnfZKhoogEnIC9rP5QLjZqjwP5IXzY2kE/KKMOG+vF8xOZOBG1UJxBaOW8HRrxdA
 XGZvUut5o5a21LeYsiR188Cgx0lTXeqohTexARCfNuNou2/N8Z5w+JcK2JAWol9db/HCJaNnTnq7y
 9b9hzmPm+FBqTsm272dCso2jkMrmH/j9UDSQzEB7gQ40g17fWOV0Yu+UpnJGBUpzZJf29Bdjj73GF
 /yd13X2ud88+EnFyrokU5Fa5Tje5vR0dZLxLhqISgUznBDx3i39nZoVImUV2sTZKihpZHq70oD1kk
 gw/tvOog==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wZ3a6-000A7X-Ii; Mon, 15 Jun 2026 11:26:10 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Philipp Stanner <phasta@kernel.org>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>, nouveau@lists.freedesktop.org
Subject: [PATCH v3] drm/nouveau: Simplify nouveau_cli_work
Date: Mon, 15 Jun 2026 10:26:07 +0100
Message-ID: <20260615092607.80917-1-tvrtko.ursulin@igalia.com>
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

Lets simplify and make clearer the fence lock cycling workaround in
nouveau_cli_work().

The reason for the workaround is that the worker processes the list of
pending work items (and so fence callbacks) opportunisticaly, while
dma_fence_is_signaled() returns true as soon as a the fence is signaled.
It is therefore not allowed for the opportunistic processing to free the
work item, since the fence callback processing can still be in the process
of dereferencing work->cb.

This wasn't very clear in the code so clarify it with a nice comment.

In the process we replace the somewhat interleaved and not very readable
nouveau_cli_work_ready() helper with a direct dma_fence_is_signaled, which
is even faster since it removes the lock cycling from the unsignaled fence
path.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: Lyude Paul <lyude@redhat.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: nouveau@lists.freedesktop.org
---
v2:
 * Don't dereference work after work->func(work) frees it.

v3:
 * Put back and explain lock cycling.
---
 drivers/gpu/drm/nouveau/nouveau_drm.c | 34 +++++++++++++--------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index 42a81166f3a9..7ea95ab960a0 100644
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
@@ -176,9 +160,25 @@ nouveau_cli_work(struct work_struct *w)
 	struct nouveau_cli_work *work, *wtmp;
 	mutex_lock(&cli->lock);
 	list_for_each_entry_safe(work, wtmp, &cli->worker, head) {
-		if (!work->fence || nouveau_cli_work_ready(work->fence)) {
+		struct dma_fence *fence = work->fence;
+
+		if (!fence || dma_fence_is_signaled(fence)) {
+			if (fence) {
+				unsigned long flags;
+
+				/*
+				 * Because fence can still be in the process of
+				 * processing the callback list, and the
+				 * callback references the work we are about to
+				 * free, we need to sync with the callback
+				 * processing before freeing the work.
+				 */
+				dma_fence_lock_irqsave(fence, flags);
+				dma_fence_unlock_irqrestore(fence, flags);
+			}
 			list_del(&work->head);
 			work->func(work);
+			dma_fence_put(fence);
 		}
 	}
 	mutex_unlock(&cli->lock);
-- 
2.54.0

