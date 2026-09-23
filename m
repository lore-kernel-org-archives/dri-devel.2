Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 647C0C9830B
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 15:03:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE16210F115;
	Wed, 23 Sep 2026 15:03:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CPo5UBcT";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BA2D10F115
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 15:03:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2F14540808;
 Wed, 23 Sep 2026 15:03:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 484271F000FF;
 Wed, 23 Sep 2026 15:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790175815;
 bh=lp7IcoO641wUtqngZtznzQ1y0Hc8tGtKJpxgcvn6F6Y=;
 h=From:To:Cc:Subject:Date;
 b=CPo5UBcTylNx2+RcvNXcqJH8wRxFkBOuwcA6tuiNjVMHdOG2bOENDUZ8AOt3+eUgA
 Dm0T6EHwSDbHQmQAVckjkWQtFd81C+gMIz7f2TYTOhENavcdb2kzVNeqKVDwumCZMd
 n5ioWSKF45w7Wa71yHsOvJVa+XuZ/qTnCKlHKbN/liGwzPNA/4RMrcBaXYO0ZzNlGE
 nX+/z38gb1lVGv9puGteSvyQuR2kkAx7g/u5eqiXZydS16s+AFEn5PSzL7IA4okdLn
 hoMUGUTet07UUw6PklQhHGitLfH6VD4QWv2jXfjjXO0MZZTC/bxa832YbPykRepLxj
 JuLqbJe3OjjOg==
From: Philipp Stanner <phasta@kernel.org>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Philipp Stanner <phasta@kernel.org>
Subject: [PATCH] dma-buf/dma-fence: Mark two callbacks as deprecated
Date: Wed, 23 Sep 2026 17:03:09 +0200
Message-ID: <20260923150308.1294592-2-phasta@kernel.org>
X-Mailer: git-send-email 2.55.0
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

dma_fence's backend_ops functions ops->wait() and ops->release() are
problematic because they prevent fence producers from unloading.
Moreover, they can easily be implemented through simpler means more
aligned with the dma_fence contract.

Since the declared goal of dma_fence is to move towards an
implementation that supports driver-unload in all circumstances, we must
prevent more parties from implementing those callbacks.

Deprecate ops->release() and ops->wait() and document what users should
do instead.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 include/linux/dma-fence.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
index dd07d128adc3..59af0159cd25 100644
--- a/include/linux/dma-fence.h
+++ b/include/linux/dma-fence.h
@@ -220,6 +220,8 @@ struct dma_fence_ops {
 	/**
 	 * @wait:
 	 *
+	 * DEPRECATED!
+	 *
 	 * Custom wait implementation, defaults to dma_fence_default_wait() if
 	 * not set.
 	 *
@@ -236,6 +238,10 @@ struct dma_fence_ops {
 	 * Implementing this callback prevents the fence from detaching after
 	 * signaling and so it is necessary for the module providing the
 	 * dma_fence_ops to stay loaded as long as the dma_fence exists.
+	 *
+	 * Deprecated for the reason mentioned above. No new users must be
+	 * implemented. Consumers of a fence can instead notify themselves by
+	 * registering a callback on the fence.
 	 */
 	signed long (*wait)(struct dma_fence *fence,
 			    bool intr, signed long timeout);
@@ -243,6 +249,8 @@ struct dma_fence_ops {
 	/**
 	 * @release:
 	 *
+	 * DEPRECATED!
+	 *
 	 * Called on destruction of fence to release additional resources.
 	 * Can be called from irq context.  This callback is optional. If it is
 	 * NULL, then dma_fence_free() is instead called as the default
@@ -254,6 +262,12 @@ struct dma_fence_ops {
 	 *
 	 * If the callback is implemented the memory backing the dma_fence
 	 * object must be freed RCU safe.
+	 *
+	 * Deprecated because it prevents the producer of a fence from
+	 * unloading. No new users must be implemented. Parties with a
+	 * hypothetical need for this callback can instead simply and directly
+	 * perform their custom release operations one RCU grace period after
+	 * they have signaled the fence.
 	 */
 	void (*release)(struct dma_fence *fence);
 

base-commit: 2302669bb4b52d581cc2589b90b3af7bb3783a28
-- 
2.55.0

