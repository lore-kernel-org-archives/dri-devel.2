Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E8A606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 11:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S5dRIAt5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8008910FAE9;
	Wed, 18 Nov 2026 11:09:38 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFBD910FAE9
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 11:09:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7A89444898;
 Wed, 18 Nov 2026 11:09:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 255611F000C4;
 Wed, 18 Nov 2026 11:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795000172;
 bh=2r4uDbTO5b1ExxzqtmXHm/o8aZPr6mw3/GIXTKP7B9I=;
 h=From:To:Cc:Subject:Date;
 b=S5dRIAt5qwBtGu9sLynNj1ue2gSnNUi3qQxYNtq9CfPuguy487isOOrZE7uhXpbi+
 rodELKLsisj0lLLegSbkWLK8zbbSltNAq3shMzpVrl2leWwADCLISjIRLqBZiuy0Hp
 aADmEdvx0RMRPBHGOBrS+ltfgpL2D8+T9KbEK8kfV2l032iB3kdZb64T+a92eIiHcv
 TdwTqlaV30aVHlwuOkMVrpecY4aimC/5d2fA3Bo12lmNw3P1WjudRY140qm0PvlJdA
 xMNWDw6etnwlp7m5ngLhwLS0PtLzv6kDuAkikbxQTYL9i6gliTUu5tmhAoW57u/M1m
 5N2YjUDZNRBkQ==
From: Philipp Stanner <phasta@kernel.org>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Simona Vetter <simona.vetter@ffwll.ch>,
 Chris Wilson <chris@chris-wilson.co.uk>,
 Danilo Krummrich <dakr@kernel.org>, Gary Guo <gary@garyguo.net>,
 Alice Ryhl <aliceryhl@google.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v2] dma-buf/dma-fence: Prevent misordering for error checks
Date: Wed, 18 Nov 2026 12:09:15 +0100
Message-ID: <20261118110914.1471416-2-phasta@kernel.org>
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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
reading of the error code. This can result in outdated, wrong error
codes being evaluated by the user.

Though dma_fence_get_status() does take the fence lock, it is equally
broken because the misordering can simply happen within the critical
section.

It's not entirely clear since when this bug exists, but at least since
dma_fence_get_status() was added, which is why its birth commit is
marked as the Fixes commit here.

Ensure ordering for everyone evaluating the error code centrally by
using test_bit_acquire() in dma_fence_test_signaled_flag().

Cc: stable@vger.kernel.org
Fixes: d6c99f4bf093 ("dma-fence: Wrap querying the fence->status")
Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
Changes in v2:
  - Use classic C style comments. (Christian)
---
 include/linux/dma-fence.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
index dd07d128adc3..a3fa1341765e 100644
--- a/include/linux/dma-fence.h
+++ b/include/linux/dma-fence.h
@@ -496,7 +496,18 @@ const char __rcu *dma_fence_timeline_name(struct dma_fence *fence);
 static inline bool
 dma_fence_test_signaled_flag(struct dma_fence *fence)
 {
-	return test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags);
+	/*
+	 * Best-effort ordering of the locklessly evaluated signaled-bit,
+	 * especially so that reads of fence->error are not misordered.
+	 *
+	 * The release counterpart is typically ensured like this:
+	 *   a) Error codes must only be set before a fence signals and
+	 *   b) The fence's spinlock's barriers effective in dma_fence_signal()
+	 *      ensure ordering.
+	 *   c) For users of dma_fence_signal_locked(), the barrier implied in
+	 *      test_and_set_bit() should do the trick.
+	 */
+	return test_bit_acquire(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags);
 }
 
 /**
-- 
2.56.0

