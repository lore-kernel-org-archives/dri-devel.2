Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE002CD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 14:25:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D22210F480;
	Mon,  8 Jun 2026 14:25:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bQ8SjdBg";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0593710F480
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 14:25:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 324EF6001D;
 Mon,  8 Jun 2026 14:25:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13AC01F00893;
 Mon,  8 Jun 2026 14:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780928738;
 bh=6y7P1ubOGoA3FYSPM72XvKyDBdGmbLV7vn8CSDRNpk0=;
 h=From:To:Cc:Subject:Date;
 b=bQ8SjdBgG9CS4cm45K1zZxEFmVjB9v5zgIhQu1UKxCj2QsOM9ao80XRW9zoSCMO9Y
 Sh1PEmmxcslC66jMN5MCUoL6QNXSB6H61Ez00QnWVFWxVh0vwhMjSWEj+SIDYayhcp
 lmDh5CghUTljgS/GFyVHKfJl7uPMP3oC3/d8ksshvtPCnxZEHXB9gCaGf0uaT0K19G
 5HOQqEZ0WI4yHnKlFE2WkH5D3AVhf4Mm8QXl504kVS/D+9EbVG7JPeAHQZoAmHewAE
 N53HAIxO3UvXt+mTqoGxIBdp2DEU/Acw2p6UfveRZSHeA5omkPzrDzW2zNTrXWvShQ
 lRLzRqLNvuNfA==
From: Philipp Stanner <phasta@kernel.org>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>, Daniel Almeida <dwlsalmeida@gmail.com>,
 Gary Guo <gary@garyguo.net>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Philipp Stanner <phasta@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>
Subject: [RFC PATCH] dma-fence: Fix races of fence callbacks versus
 destructors by locking
Date: Mon,  8 Jun 2026 16:24:37 +0200
Message-ID: <20260608142436.265820-2-phasta@kernel.org>
X-Mailer: git-send-email 2.54.0
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

The dma_fence backend_ops can access a fence. Hereby, a driver callback
will be running which likely will access driver specific data through
container_of(). If now, simultaneously, a driver signals the fence and
afterwards expects to run a driver specific destructor (using the same
data accessed through container_of()), there can be a race.

A driver very likely trusts that once it has signaled a fence, no one
will be accessing it anymore. Moreover, it might already want to free up
resources, making UAF bugs possible.

The race occurs because there are only pragmatic checks for the signaled
flag of a fence, without taking the fence lock. RCU guards exist, but
their purpose is to guard accesses through the backend_ops callbacks
against the driver (which implements the TEXT segment these callbacks
live in) from unloading.

Proper synchronization can be ensured by taking the fence lock. RCU is
still simultaneously required to guard against the unload.

Fix the races by taking the lock for all non-deprecated backend_ops
callbacks.

Conveniently, this also fixes a race where backend_ops->set_deadline()
might try to set a deadline for an already signaled fence.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
We discovered this problem through our Rust abstractions, but it can
also occur in C.

The by far cleanest solution seems to be to use the fence lock. This RFC
serves to discuss whether there is anything preventing that.

(Patch so far just compile tested, to have some groundlayer for the
rough idea, to discuss it first)
---
 drivers/dma-buf/dma-fence.c | 39 ++++++++++++++++++++++++++++---------
 include/linux/dma-fence.h   | 17 ++++++++++++----
 2 files changed, 43 insertions(+), 13 deletions(-)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index c7ea1e75d38a..b74f02f3cca8 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -629,7 +629,8 @@ EXPORT_SYMBOL(dma_fence_free);
 static bool __dma_fence_enable_signaling(struct dma_fence *fence)
 {
 	const struct dma_fence_ops *ops;
-	bool was_set;
+	bool was_set, success;
+	unsigned long flags;
 
 	dma_fence_assert_held(fence);
 
@@ -644,7 +645,10 @@ static bool __dma_fence_enable_signaling(struct dma_fence *fence)
 	if (!was_set && ops && ops->enable_signaling) {
 		trace_dma_fence_enable_signal(fence);
 
-		if (!ops->enable_signaling(fence)) {
+		dma_fence_lock_irqsave(fence, flags);
+		success = ops->enable_signaling(fence);
+		dma_fence_unlock_irqrestore(fence, flags);
+		if (!success) {
 			rcu_read_unlock();
 			dma_fence_signal_locked(fence);
 			return false;
@@ -1020,11 +1024,20 @@ EXPORT_SYMBOL(dma_fence_wait_any_timeout);
 void dma_fence_set_deadline(struct dma_fence *fence, ktime_t deadline)
 {
 	const struct dma_fence_ops *ops;
+	unsigned long flags;
 
 	rcu_read_lock();
 	ops = rcu_dereference(fence->ops);
-	if (ops && ops->set_deadline && !dma_fence_is_signaled(fence))
+	if (!ops || !ops->set_deadline) {
+		rcu_read_unlock();
+		return;
+	}
+
+	dma_fence_lock_irqsave(fence, flags);
+	if (!dma_fence_is_signaled_locked(fence))
 		ops->set_deadline(fence, deadline);
+
+	dma_fence_unlock_irqrestore(fence, flags);
 	rcu_read_unlock();
 }
 EXPORT_SYMBOL(dma_fence_set_deadline);
@@ -1166,14 +1179,18 @@ EXPORT_SYMBOL(dma_fence_init64);
  */
 const char __rcu *dma_fence_driver_name(struct dma_fence *fence)
 {
+	const char __rcu *name = "detached-driver";
 	const struct dma_fence_ops *ops;
+	unsigned long flags;
 
 	/* RCU protection is required for safe access to returned string */
 	ops = rcu_dereference(fence->ops);
+	dma_fence_lock_irqsave(fence, flags);
 	if (!dma_fence_test_signaled_flag(fence))
-		return (const char __rcu *)ops->get_driver_name(fence);
-	else
-		return (const char __rcu *)"detached-driver";
+		name = ops->get_driver_name(fence);
+	dma_fence_unlock_irqrestore(fence, flags);
+
+	return name;
 }
 EXPORT_SYMBOL(dma_fence_driver_name);
 
@@ -1199,13 +1216,17 @@ EXPORT_SYMBOL(dma_fence_driver_name);
  */
 const char __rcu *dma_fence_timeline_name(struct dma_fence *fence)
 {
+	const char __rcu *name = "signaled-timeline";
 	const struct dma_fence_ops *ops;
+	unsigned long flags;
 
 	/* RCU protection is required for safe access to returned string */
 	ops = rcu_dereference(fence->ops);
+	dma_fence_lock_irqsave(fence, flags);
 	if (!dma_fence_test_signaled_flag(fence))
-		return (const char __rcu *)ops->get_driver_name(fence);
-	else
-		return (const char __rcu *)"signaled-timeline";
+		name = ops->get_driver_name(fence);
+	dma_fence_unlock_irqrestore(fence, flags);
+
+	return name;
 }
 EXPORT_SYMBOL(dma_fence_timeline_name);
diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
index b52ab692b22e..b93c3f7f69fb 100644
--- a/include/linux/dma-fence.h
+++ b/include/linux/dma-fence.h
@@ -547,20 +547,29 @@ static inline bool
 dma_fence_is_signaled(struct dma_fence *fence)
 {
 	const struct dma_fence_ops *ops;
+	unsigned long flags;
+	bool signaled;
 
 	if (dma_fence_test_signaled_flag(fence))
 		return true;
 
 	rcu_read_lock();
 	ops = rcu_dereference(fence->ops);
-	if (ops && ops->signaled && ops->signaled(fence)) {
+	if (!ops || !ops->signaled) {
 		rcu_read_unlock();
-		dma_fence_signal(fence);
-		return true;
+		return false;
 	}
+
+	dma_fence_lock_irqsave(fence, flags);
+	signaled = ops->signaled(fence);
+
+	if (signaled)
+		dma_fence_signal_locked(fence);
+
+	dma_fence_unlock_irqrestore(fence, flags);
 	rcu_read_unlock();
 
-	return false;
+	return signaled;
 }
 
 /**
-- 
2.54.0

