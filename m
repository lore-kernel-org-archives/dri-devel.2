Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FF0606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 16:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X0zJEr5g
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B67C510F7DA;
	Tue, 10 Nov 2026 16:01:45 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 276A910F7D5
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 16:01:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 08EE643384;
 Tue, 10 Nov 2026 16:01:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 187251F0089F;
 Tue, 10 Nov 2026 16:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794326498;
 bh=ywMaUI7ZJ5wOv93gV2K9f4mZmHqyuEiNzOW/bzQiuiE=;
 h=From:To:Cc:Subject:Date;
 b=X0zJEr5gl0LaP1t3NZMUHeLPSFv7l49feBlDgVSQ0Wvj5XNc3N0PxO+YUyeFgq/7m
 G8rS1LwnOP1KX2bp8Yt1p9oOw1QtwU4NzwGuq7rNjoa63SxiTz0lmDX7SXzxVs/rpr
 5RT0xfQgbBOckQASLVyEjfYBqNlMEVfp2h4JYIe4Gd6a5S3D68kLLIlUfEicGOxarV
 5RAoNnZ+7Urb1JByIfa/xK1iUcnnTyxR8it1vfoAGwKPPIM64YDeacixodZ3fCCGxx
 AhwFRSEtWJGEa4nDxVfvbh5uCumb2cfNQefc520AEefgzFGbKU3jn0HLenjtd3aMNF
 SZ3IrHJNR2eMQ==
From: Philipp Stanner <phasta@kernel.org>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, Alice Ryhl <aliceryhl@google.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Simona Vetter <simona.vetter@ffwll.ch>,
 "Paul E . McKenney" <paulmck@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] dma-buf/dma-fence: Close race window against error checks
Date: Tue, 10 Nov 2026 16:58:19 +0100
Message-ID: <20261110155817.1492359-3-phasta@kernel.org>
X-Mailer: git-send-email 2.56.0
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Many users of dma_fence do things like:

// Thread A
dma_fence_set_error(f, -EINVAL);
dma_fence_signal(f); // <- Takes lock, which orders against the above.

// Thread B
if (dma_fence_is_signaled(f)) // <- Does test_bit(), no ordering.
	pr_info("err: %i\n", f->error); // <- Can be loaded first.

There is no memory ordering between reading of the signaled-bit and
reading of the error code.

Though dma_fence_get_status() does take the fence lock, it is equally
broken because the misordering can simply happen within the critical
section I think?

(dma_fence_is_signaled() shouldn't even exist for users btw, a user
should always only call a working, ordered dma_fence_get_status() so he
cannot that easily ignore the error code

Likewise, dma_fence_set_error() should not exist since it massively
incentivizes messing up. I suppose the _locked functions came to be to
fix that up in hindsight?).

Since I want to work towards a dma_fence implementation where users do
not take the fence lock manually anymore, the proposed fix is: Order
dma_fence_is_signaled() with the lock, and
dma_fence_is_signaled_locked() with a barrier.

In the mid-term, we would deprecate all XXX_locked functions. The
self-locking fence API can satisfy all user requirements with the
inline-lock.

Ordering dma_fence_is_signaled() with the spinlock instead of a barrier
also has the advantage of protecting against frequent bugs where people
run into UAF because they got their refcounting wrong and rely on the
fence being freeable once the signaled-bit lights up:

	commit c8a5d5ea3ba6 ("nouveau: fix client work fence deletion race")
	commit 7c703a7d3f2b ("drm/amdgpu: Fix one use-after-free of VM")

This related pattern works:

	dma_fence_lock_irqsave(f, flags);
	dma_fence_set_error(f, -EINVAL);
	dma_fence_signal_locked(f); // uses test_and_set_bit(), which is strongly ordered
	dma_fence_unlock_irqrestore(f, flags);

This is all very subtle and implicit.

Regardless, I think we really need to establish what the signaled-bit
really means and who is responsible where for its evaluation semantics.

Lucas recently (rightfully) pointed out that the signaled-bit originally
was supposed to *only* mean that the hardware is done. But this is just
not the API reality anymore, where we have to use the signaled-state for
driver-unload and for correct evaluation of error codes.

Note at this point my proposal to transition fence to a stable state
where these subtleties disappear. The time window to add this change
right now is unusually good because the inline_lock is not used by
anyone yet except for our Rust abstractions, so we can get things right
without breaking old drivers.

Link: https://lore.kernel.org/dri-devel/20261020100034.759183-2-phasta@kernel.org/

Fixes: d6c99f4bf093 ("dma-fence: Wrap querying the fence->status")
Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
Regarding ordering between

dma_fence_get_status()

and

dma_fence_set_error() followed by
dma_fence_signal()

Would probably be good if those highly experienced with ordering (Paul,
Gary) can share their opinion whether there's actually a problem that
can occurr in reality.
---
 include/linux/dma-fence.h | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
index dd07d128adc3..fe6fbc5a5a35 100644
--- a/include/linux/dma-fence.h
+++ b/include/linux/dma-fence.h
@@ -517,8 +517,18 @@ static inline bool
 dma_fence_is_signaled_locked(struct dma_fence *fence)
 {
 	const struct dma_fence_ops *ops;
+	bool signaled;
 
-	if (dma_fence_test_signaled_flag(fence))
+	signaled = dma_fence_test_signaled_flag(fence);
+	/*
+	 * Whoever holds the lock might next try to obtain the fence's error
+	 * code - but there is no ordering between reading the signaled flag
+	 * and the reading of the error code.
+	 *
+	 * Order properly with rmb() since fences might be involved in IO.
+	 */
+	rmb();
+	if (signaled)
 		return true;
 
 	rcu_read_lock();
@@ -553,9 +563,17 @@ static inline bool
 dma_fence_is_signaled(struct dma_fence *fence)
 {
 	const struct dma_fence_ops *ops;
+	unsigned long flags;
 
-	if (dma_fence_test_signaled_flag(fence))
+	/*
+	 * Take the lock to order against people reading the fence's error code.
+	 */
+	dma_fence_lock_irqsave(fence, flags);
+	if (dma_fence_test_signaled_flag(fence)) {
+		dma_fence_unlock_irqrestore(fence, flags);
 		return true;
+	}
+	dma_fence_unlock_irqrestore(fence, flags);
 
 	rcu_read_lock();
 	ops = rcu_dereference(fence->ops);
-- 
2.56.0

