Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4CF606A334
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 17:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RSb3dD0F
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F3AD11261E;
	Thu, 26 Nov 2026 17:21:25 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34F0F10E1A0;
 Thu, 26 Nov 2026 17:21:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F20D7404A8;
 Thu, 26 Nov 2026 17:21:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04F6A1F000C4;
 Thu, 26 Nov 2026 17:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795713674;
 bh=84lfspAujxWatUK6nKbRCWveeDZXMspVq2UyqNuKz60=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=RSb3dD0FYkKYzmj+j0RNPHk6jGetS4tHhO4QV/aNGksxYSQ/gxNul5VsT7CxSj27a
 bbhDrvUnW8wVrwmjHsFTJT7M3owq2ohkLtfoaBv8rkiOwnQXL4nJgkmOEFynVbZGK1
 3/lSmoaFA5poNXLmPXMRIFR45di+UwQ7lZK9Yk8o8swkQ3+SEK+dQp0c+AGXg7/m7K
 Mgh8wobwFMzaPbwuQNBrYYu1fo87vb+WL3wVlkT/tT/nNd3KL6h+VYkmpaWOqkr4tZ
 yWI+r7K2DpSq/QUMvbnXKWr1AWYxqJBGxCryUwT8xUS4jKbw5pKmRb9atdvkxehWBE
 F9xkQmE++Kd7Q==
From: Philipp Stanner <phasta@kernel.org>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 Chris Wilson <chris@chris-wilson.co.uk>,
 Luben Tuikov <ltuikov89@gmail.com>,
 Shashank Sharma <shashank.sharma@amd.com>,
 "Paul E . McKenney" <paulmck@kernel.org>, Gary Guo <gary@garyguo.net>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 stable@vger.kernel.org
Subject: [PATCH 1/3] dma-buf: dma-fence: Hot-fix timestamp misordering
Date: Thu, 26 Nov 2026 18:20:45 +0100
Message-ID: <20261126172046.2473303-3-phasta@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261126172046.2473303-2-phasta@kernel.org>
References: <20261126172046.2473303-2-phasta@kernel.org>
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

fence timestamps can be written and read without any memory ordering
since, presumably, forever. This can cause real bugs, other than false
accounting, for parties whose algorithms depend on the timestamp.

Hot-fix the problem for now so that it can be backported until we found
a suitable way forward for mainline.

Cc: stable@vger.kernel.org
Fixes: 76250f2b743b ("dma-buf/fence: Avoid use of uninitialised timestamp")
Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/dma-buf/dma-fence.c | 9 +++++++++
 include/linux/dma-fence.h   | 8 ++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index bd58688b81a7..8a842fc8168f 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -378,6 +378,15 @@ void dma_fence_signal_timestamp_locked(struct dma_fence *fence,
 	list_replace(&fence->cb_list, &cb_list);
 
 	fence->timestamp = timestamp;
+	/*
+	 * TODO:
+	 * This is a temporary hotfix to prevent misordering until we
+	 * can completely remove the TIMESTAMP bit.
+	 *
+	 * The counterpart of this barrier are the test_bit_acquire()s in
+	 * dma_fence_timestamp().
+	 */
+	smp_mb__before_atomic();
 	set_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &fence->flags);
 
 	list_for_each_entry_safe(cur, tmp, &cb_list, node) {
diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
index 64330bf52561..6b16095e8521 100644
--- a/include/linux/dma-fence.h
+++ b/include/linux/dma-fence.h
@@ -715,10 +715,14 @@ static inline void dma_fence_set_error(struct dma_fence *fence,
  */
 static inline ktime_t dma_fence_timestamp(struct dma_fence *fence)
 {
-	if (WARN_ON(!test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags)))
+	/*
+	 * The test_bit_acquire() calls order against the
+	 * smp_mb__before_atomic() in dma_fence_signal_timestamp_locked().
+	 */
+	if (WARN_ON(!test_bit_acquire(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags)))
 		return ktime_get();
 
-	while (!test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &fence->flags))
+	while (!test_bit_acquire(DMA_FENCE_FLAG_TIMESTAMP_BIT, &fence->flags))
 		cpu_relax();
 
 	return fence->timestamp;
-- 
2.56.0

