Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B01BCDE008
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:05:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89FFC10E281;
	Fri, 26 Jun 2026 10:05:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PZs6rUkY";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BEFD10E281
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 10:05:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C34BA60122;
 Fri, 26 Jun 2026 10:05:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B83101F000E9;
 Fri, 26 Jun 2026 10:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782468346;
 bh=XPOnL3YaXcY5m5ZE7tv6kcrdVXllWoBe5sPRf2jXnF4=;
 h=From:To:Cc:Subject:Date;
 b=PZs6rUkYf9rAESRZeLEJuYSARXc9W6t080JPfO71cLYWXcyEgTuFTkHXIYKclq6gG
 euJHYHsWp6jtUC8y3lCHYOjKKbyhia1WduFm6BhN3rQxzTUQIYvkAKMeNnseHV8hl6
 bsbCOzZzZgga2sfNdrNj21lttW90LocD4TXyKqy5Y+zx1DOxX/5rmUN8YcbZc9pMW9
 sMtuu+LOqvFonMMC2nK+Jsih17DBX4ORaR4DrbrCSkN0qbULQ6sH5MmidGqOBqadZu
 p8hOYT6WDeHqrnd3lP3LA4fyeVVf4cfm114K50otfqHf4cGHPOrsNb4iEDgcfutswq
 26VioYZkSBhCA==
From: Philipp Stanner <phasta@kernel.org>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
 Danilo Krummrich <dakr@kernel.org>, Gary Guo <gary@garyguo.net>,
 "Paul E . McKenney" <paulmck@kernel.org>, Boqun Feng <boqun@kernel.org>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 Philipp Stanner <phasta@kernel.org>, stable@vger.kernel.org
Subject: [PATCH] dma-buf: dma-fence: Fix potential NULL pointer dereference
Date: Fri, 26 Jun 2026 12:04:42 +0200
Message-ID: <20260626100442.2202221-2-phasta@kernel.org>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The commit mentioned in the fixes tag below introduced a mechanism
through which fence producers can fully decouple from fence consumers.
This, desirable, mechanism is based on the fence's signaled-bit as the
"decoupling point".

A sophisticated interaction between RCU and atomic instructions attempts
to ensure that fence consumers can still interact with fence producers
through the dma_fence_ops, callback pointers into the producer.

This is the desired behavior: to check for decoupling, the signaled-bit
is first checked. If it's not yet signaled, RCU ensures that the ops
pointer cannot yet be NULL.

Hereby, dma_fence_signal_timestamp_locked() first sets the signaled-bit,
and then sets the ops pointer to NULL. Readers first load the ops
pointer, and then check through the signaled-bit whether the pointer can
legally be accessed.

These set and load operations could occur out of order on weakly ordered
platforms. Hence, we need to enforce strict ordering all the time.

Add the appropriate memory barriers.

Cc: stable@vger.kernel.org
Fixes: f4cc3ab824d6 ("dma-buf: protected fence ops by RCU v8")
Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
Tested with dmabuf and drm_sched unit tests.

Memory barriers are notoriously difficult, so I would appreciate if some
of the more experienced folks can check this. Notably, I am not sure
whether the smp_wmb() is necessary.

The documentation for test_and_set_bit() makes the mysterious statement
"This is an atomic fully-ordered operation (implied full memory
barrier)", but the kcsan_mb() seems to be some sort of debugging
barrier, and in any case the docu doesn't make it obvious to me whether
that "full barrier" comes before or after the bit setting takes place.

Moreover, in my opinion we should order dma_fence_is_signaled(), too –
but if we agree to merge Christian's new series [1] that need should
disappear.


[1] https://lore.kernel.org/dri-devel/20260624122917.2483-1-christian.koenig@amd.com/ 
---
 drivers/dma-buf/dma-fence.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index c7ea1e75d38a..2e80b01499de 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -363,6 +363,18 @@ void dma_fence_signal_timestamp_locked(struct dma_fence *fence,
 				      &fence->flags)))
 		return;
 
+	/*
+	 * Fully order setting of the bit above with setting of the ops pointer
+	 * to NULL below, so that all parties can use the signaled flag to
+	 * detect that the fence decoupled from its ops in a safe manner.
+	 *
+	 * The counter parts of this barrier are in dma_fence_timeline_name()
+	 * and dma_fence_driver_name(). All other future parties that rely on
+	 * the signaled flag for valid access to the ops pointer will need a
+	 * memory barrier.
+	 */
+	smp_wmb();
+
 	trace_dma_fence_signaled(fence);
 
 	/*
@@ -1170,6 +1182,12 @@ const char __rcu *dma_fence_driver_name(struct dma_fence *fence)
 
 	/* RCU protection is required for safe access to returned string */
 	ops = rcu_dereference(fence->ops);
+	/*
+	 * Fully order the dereference above with the flag check. Otherwise,
+	 * ops could be dereferenced as a NULL pointer. The barrier's
+	 * counterpart is in dma_fence_signal_timestamp_locked().
+	 */
+	smp_rmb();
 	if (!dma_fence_test_signaled_flag(fence))
 		return (const char __rcu *)ops->get_driver_name(fence);
 	else
@@ -1203,6 +1221,12 @@ const char __rcu *dma_fence_timeline_name(struct dma_fence *fence)
 
 	/* RCU protection is required for safe access to returned string */
 	ops = rcu_dereference(fence->ops);
+	/*
+	 * Fully order the dereference above with the flag check. Otherwise,
+	 * ops could be dereferenced as a NULL pointer. The barrier's
+	 * counterpart is in dma_fence_signal_timestamp_locked().
+	 */
+	smp_rmb();
 	if (!dma_fence_test_signaled_flag(fence))
 		return (const char __rcu *)ops->get_driver_name(fence);
 	else

base-commit: cdeb2ccd993ed8647adbbda2c3b103aa717fd6f7
-- 
2.54.0

