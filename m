Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E697CCA9ED0
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 17:20:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25B2510E4AC;
	Mon, 12 Oct 2026 17:20:10 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5760310E4AC
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 17:20:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3681342A3F;
 Mon, 12 Oct 2026 17:20:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 195A71F0089B;
 Mon, 12 Oct 2026 17:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791825604;
 bh=/+kYat3Js03LLBNLv0RvM8p5SjFSuufv4UsSaTtr3vg=;
 h=From:To:Cc:Subject:Date;
 b=WCZIeTx48JYsbkqPJ8oGRb8Z6K0VhXDe7aglI7KhvjXQyj2HPezQGvCQXRlWz7804
 oE4iRPBXmYgyFKSCVRSoKRduwu69Gk+uz9eDqcPNFRnTgmAHK6GXE2iZsc6DlgcF18
 AilMXoUHzDoe82GDn6aFzLAZPLpa5waoW+EdBo1+cNL9PsrXc0kvTzlEp9bkw/p20i
 WG/QZabuOj+/PZjv2ozkwd2qRcRgRk5gxO3CaOuA2YAwsIBESkETY67uW9SejIjyhT
 zkqcFBLJrU73NjDg/vuLs8HWLVL2KDZqoxTc+PSPBKPg7GIBvaeCIWNEFuyd4ghqju
 J+xFKtK7Iv7Qw==
From: Philipp Stanner <phasta@kernel.org>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 dakr@kernel.org
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Philipp Stanner <phasta@kernel.org>
Subject: [PATCH v2] dma-buf/dma-fence: Mark two callbacks as deprecated
Date: Mon, 12 Oct 2026 19:19:40 +0200
Message-ID: <20261012171939.390365-2-phasta@kernel.org>
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
Changes in v2:
  - Drop confusing sentence (Christian).
---
 include/linux/dma-fence.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
index dd07d128adc3..388c07d11e70 100644
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
@@ -243,6 +245,8 @@ struct dma_fence_ops {
 	/**
 	 * @release:
 	 *
+	 * DEPRECATED!
+	 *
 	 * Called on destruction of fence to release additional resources.
 	 * Can be called from irq context.  This callback is optional. If it is
 	 * NULL, then dma_fence_free() is instead called as the default
@@ -254,6 +258,12 @@ struct dma_fence_ops {
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
 

base-commit: 3e32932d3626d0279f9b3531bd648f8c0a16cb08
-- 
2.55.0

