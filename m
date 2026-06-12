Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0FACCD8CA8
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 10:43:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 106E810E9B7;
	Fri, 12 Jun 2026 10:43:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LRnJAoBx";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E62AB10E9B7
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 10:43:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0DC066001D;
 Fri, 12 Jun 2026 10:43:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E53321F000E9;
 Fri, 12 Jun 2026 10:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781261001;
 bh=H4drlEs7mwLSm0ngtWZFdgIn1T1tuqSEWbBzTCWzvu8=;
 h=From:To:Cc:Subject:Date;
 b=LRnJAoBxc0NYKhdlNg8pyExFMQ1VQexXaygX4uk1JV5sKTwa6P5ibKMk029LcNl9b
 WqeTFrfEpy5wO9n5wOcoHNjwOb8Op86VVObGV3nYyevL8BEO2Qvh9lmdmgFn1747sH
 ecIkcLsADIOu3vRweEFE0px9gOhaZMk1ALbTXHGmjFj+IwB9RzooDaGIe2QsknlR70
 Z2Q7wUIkEr2toknvgvadlIm8x3kPkZ/N8DPwL6gxn2YXjyrafGWEugC+guYNOsCNb6
 wsOrDTTtgVYyaQoX/TIVRx2E+esX2p0FAhispV+6PrMfvII8MCYEKEPoyiJWnoV6rX
 4xsupVYSFOiRQ==
From: Philipp Stanner <phasta@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 "Paul E . McKenney" <paulmck@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Philipp Stanner <phasta@kernel.org>
Subject: [RFC PATCH] dma-buf/dma_fence: Make races for dma_fence_is_signaled()
 less likely
Date: Fri, 12 Jun 2026 12:42:52 +0200
Message-ID: <20260612104251.2264707-2-phasta@kernel.org>
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

dma_fence_is_signaled() returns whether a fence has been signaled
already. That function contains a fast path opportunistic check which is
not guarded by the lock and, according to Christian, cannot be guarded
by the lock without causing a massive performance regression.

This now means that dma_fence_is_signaled() can return true WHILE the
fence callbacks are still being executed. This is razy and has lead to
at least one bug solved in:

commit c8a5d5ea3ba6 ("nouveau: fix client work fence deletion race")

Make this race impossible, by simply setting the bit only once the
callbacks are actually completed.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/dma-buf/dma-fence.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index c7ea1e75d38a..2416cc86ce93 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -359,8 +359,19 @@ void dma_fence_signal_timestamp_locked(struct dma_fence *fence,
 
 	dma_fence_assert_held(fence);
 
-	if (unlikely(test_and_set_bit(DMA_FENCE_FLAG_SIGNALED_BIT,
-				      &fence->flags)))
+	/*
+	 * First test the bit, so we don't signal an already signaled fence again.
+	 * The lock protects against multiple parties setting the bit. The bit
+	 * is then set at the end of the function.
+	 *
+	 * The background is that there is a fast path check in
+	 * dma_fence_is_signaled() which does not use lock protection and can
+	 * return true *while* the fence callbacks are still executing.
+	 *
+	 * This fast path check supposedly cannot be guarded by the lock because
+	 * of significant performance regressions.
+	 */
+	if (unlikely(test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags)))
 		return;
 
 	trace_dma_fence_signaled(fence);
@@ -384,6 +395,9 @@ void dma_fence_signal_timestamp_locked(struct dma_fence *fence,
 		INIT_LIST_HEAD(&cur->node);
 		cur->func(fence, cur);
 	}
+
+	// TODO: we need some barrier here, don't we?
+	set_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags);
 }
 EXPORT_SYMBOL(dma_fence_signal_timestamp_locked);
 
-- 
2.54.0

