Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ADB0C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 07:56:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAB0910E06F;
	Mon, 29 Jun 2026 07:56:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="F1sbhZmQ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4587A10E03A
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 07:56:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D90CF408E7;
 Mon, 29 Jun 2026 07:56:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB7381F000E9;
 Mon, 29 Jun 2026 07:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782719811;
 bh=S30NeagpEcZhtovpS5SpHMBaBOG2K6LplFkgTolUfE4=;
 h=From:To:Cc:Subject:Date;
 b=F1sbhZmQZWS0SZb2g0JeIHYjjl5aFLCfW6JZLHanihsXud50pPNQEZb3sC3/f67O/
 nHxmpvHm6FWqtxHHr7rYzl0sT538qJjr83vA98z5jjrqP5ZOg0zSCP0vuCbBcJD11I
 VtnAPOF0fqXMfxKHkb+KNlKOLjY3SJxPE+D+/jb1OaP6lA5EdCaeG4aoFGkyk7oLRq
 ocrvFFMBLuUiXdErJdrO0MY8GMoAK6WXXdGEwyeiftvFs8lls0uRJxKaTXn05L6FIA
 IHqFGZu8M6Tb5+MB1D5Ky+6GyKYXoynWW821t7IrZH4nI+rpEqLE2pgfwu6Pzjb6EB
 GK2PWYw3f2sLQ==
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
Subject: [PATCH v2] dma-buf: dma-fence: Fix potential NULL pointer dereference
Date: Mon, 29 Jun 2026 09:56:37 +0200
Message-ID: <20260629075636.2513214-2-phasta@kernel.org>
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

The commit mentioned in the fixes tag below introduced a mechanism
through which fence producers can fully decouple from fence consumers.
This, desirable, mechanism is based on the fence's signaled-bit as the
"decoupling point".

A sophisticated interaction between RCU and atomic instructions attempts
to ensure that fence consumers can still interact with fence producers
through the dma_fence_ops (callback pointers into the producer).

This is the desired behavior: to check for decoupling, the signaled-bit
is first checked. If it's not yet signaled, RCU ensures that the ops
pointer cannot yet be NULL.

Hereby, dma_fence_signal_timestamp_locked() first sets the signaled-bit,
and then sets the ops pointer to NULL. Readers first load the ops
pointer, and then check through the signaled-bit whether the pointer can
legally be accessed.

These set and load operations could occur out of order on weakly ordered
platforms. This problem can be solved very elegantly by using the ops
pointer itself as the synchronization point. The pointer is either NULL,
or cannot become NULL while it is being used thanks to RCU.

Replace the signaled-bit check in dma_fence_timeline_name() and
dma_fence_driver_name().

Cc: stable@vger.kernel.org
Fixes: f4cc3ab824d6 ("dma-buf: protected fence ops by RCU v8")
Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
Changes since v1:
  - Use ops pointer instead of memory barriers. (Christian)
  - Rephrase commit message.
---
 drivers/dma-buf/dma-fence.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index c7ea1e75d38a..0a025dfdf131 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -1170,7 +1170,7 @@ const char __rcu *dma_fence_driver_name(struct dma_fence *fence)
 
 	/* RCU protection is required for safe access to returned string */
 	ops = rcu_dereference(fence->ops);
-	if (!dma_fence_test_signaled_flag(fence))
+	if (ops)
 		return (const char __rcu *)ops->get_driver_name(fence);
 	else
 		return (const char __rcu *)"detached-driver";
@@ -1203,7 +1203,7 @@ const char __rcu *dma_fence_timeline_name(struct dma_fence *fence)
 
 	/* RCU protection is required for safe access to returned string */
 	ops = rcu_dereference(fence->ops);
-	if (!dma_fence_test_signaled_flag(fence))
+	if (ops)
 		return (const char __rcu *)ops->get_driver_name(fence);
 	else
 		return (const char __rcu *)"signaled-timeline";

base-commit: cdeb2ccd993ed8647adbbda2c3b103aa717fd6f7
-- 
2.54.0

