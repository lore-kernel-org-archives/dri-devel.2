Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8301C606A31F
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 09:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cm6uDSBn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E729F10E0DA;
	Wed, 21 Oct 2026 09:56:54 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2CE010E0DA
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 09:56:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2041D60052;
 Wed, 21 Oct 2026 09:56:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC531F000C9;
 Wed, 21 Oct 2026 09:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792576606;
 bh=OBRANLxJ945k7D1G3lIFWXCIRvOVfhFWCqR5YEXkSkI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Cm6uDSBn8rUl0CV7nI5Aa3oolTOxPGbITFM/bWZPytq04QyetEjSd16NBzFq/3t5i
 BekTV8Djg2tYKAHk1xMr5vreTI6LimHfWkujWEMtXIof4E2UniWUFeO66WiLGux/yH
 mGHYQgLe2F6oKl7OuqGmbItsHPOB0hxHt+hd403oWeUDZE313RV8SrNAZ7wnCbHP45
 6Z31kGtXu7A/DrpdBjD/dXCtIO8Yl2SllSWOB0P567NVSJnw7CHoZFTzhN8jN3QR4C
 sbzCGXUQHsL7+JFQ1WULE5S4IB9Q/UOsknWA9/4m40MyAw1Eyk1X7Xpf8kRUGOVIWq
 O5n/5DNPt75ww==
From: Philipp Stanner <phasta@kernel.org>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Arnd Bergmann <arnd@arndb.de>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Danilo Krummrich <dakr@kernel.org>, Gary Guo <gary@garyguo.net>,
 "Paul E . McKenney" <paulmck@kernel.org>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 Philipp Stanner <phasta@kernel.org>
Subject: [PATCH 2/2] dma-buf/dma-fence: Order setting of the signaled-bit
 properly
Date: Wed, 21 Oct 2026 11:55:13 +0200
Message-ID: <20261021095512.1345191-4-phasta@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261021095512.1345191-2-phasta@kernel.org>
References: <20261021095512.1345191-2-phasta@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

dma_fence_is_signaled() can return true *while* the fence is still
signaling. This is fragile and has been involved in at least two bugs:

	commit c8a5d5ea3ba6 ("nouveau: fix client work fence deletion race")
	commit 7c703a7d3f2b ("drm/amdgpu: Fix one use-after-free of VM")

The signaled-bit is set under lock-protection but read without it.
Adding the lock has been rejected on the grounds of the lock-acquisition
shooting down cache lines of parties that merely want to check whether
the fence is already signaled.

Make sure the bit can only become visible as 1 once the callbacks have
ran. To achieve this, read the bit with test_bit_acquire() and set it
with set_bit_release().

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/dma-buf/dma-fence.c | 11 +++++++++--
 include/linux/dma-fence.h   |  6 +++++-
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index bd58688b81a7..07d499fa35ac 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -359,8 +359,7 @@ void dma_fence_signal_timestamp_locked(struct dma_fence *fence,
 
 	dma_fence_assert_held(fence);
 
-	if (unlikely(test_and_set_bit(DMA_FENCE_FLAG_SIGNALED_BIT,
-				      &fence->flags)))
+	if (unlikely(dma_fence_test_signaled_flag(fence)))
 		return;
 
 	trace_dma_fence_signaled(fence);
@@ -384,6 +383,14 @@ void dma_fence_signal_timestamp_locked(struct dma_fence *fence,
 		INIT_LIST_HEAD(&cur->node);
 		cur->func(fence, cur);
 	}
+
+	/*
+	 * This orders the signaled-state with the test_bit_acquire() in
+	 * dma_fence_test_signaled_flag(). This ensures that functions like
+	 * dma_fence_is_signaled() can only ever return true once signaling is
+	 * completed (i.e., after the callbacks above ran).
+	 */
+	set_bit_release(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags);
 }
 EXPORT_SYMBOL(dma_fence_signal_timestamp_locked);
 
diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
index dd07d128adc3..61522027af41 100644
--- a/include/linux/dma-fence.h
+++ b/include/linux/dma-fence.h
@@ -496,7 +496,11 @@ const char __rcu *dma_fence_timeline_name(struct dma_fence *fence);
 static inline bool
 dma_fence_test_signaled_flag(struct dma_fence *fence)
 {
-	return test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags);
+	/*
+	 * The counterpart of this ordered operation can be found in
+	 * dma_fence_signal_timestamp_locked().
+	 */
+	return test_bit_acquire(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags);
 }
 
 /**
-- 
2.56.0

