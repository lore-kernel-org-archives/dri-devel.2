Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE66606A32A
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 13:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cUMdBXQW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2A6110E9BF;
	Thu, 19 Nov 2026 13:19:50 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30C7710E9BF
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 13:19:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5439D636E7;
 Thu, 19 Nov 2026 13:19:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45BD31F000C4;
 Thu, 19 Nov 2026 13:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795094384;
 bh=tqYW6qfCA89hjEn5S9pqMagRU23Yv0iJY1QqK9VwBZY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=cUMdBXQWPwrmExTjmd3k4UHdq3e3AF8tfw03kNLYOkIghQLXXrteSD0JgH7nrp1WO
 kDoUisHmRH+urygOeK5JGPGx/YP9DMmKH+lZrji6Xp5C183puetxI3m9ngILxtDYtv
 vRFkeav0jbcQx8gjVvCVLG4Qfya7FKTO2HvwmJ20X3pWeGuWEXyS/tEMZIn8pCvBwv
 /Me5CdsmwbHBwb2/mxWvPcSvDHoRMVD1p/skM/7VDHr/cJLWGAnqlrAmXb5DrWltS6
 Jw2gLuAniYfQvNFrldjuaJQJ2TgqA1b9qCulsW0iVZWhCgEQfmBNuc84UbEngjXZA+
 os/qBDoL8d0tw==
From: Philipp Stanner <phasta@kernel.org>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Simona Vetter <simona.vetter@ffwll.ch>,
 Chris Wilson <chris@chris-wilson.co.uk>,
 Danilo Krummrich <dakr@kernel.org>, Gary Guo <gary@garyguo.net>,
 Alice Ryhl <aliceryhl@google.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 "Paul E . McKenney" <paulmck@kernel.org>,
 Yunxiang Li <Yunxiang.Li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH 1/3] dma-buf/dma-fence: Ensure correct ordering in
 dma_fence_timestamp()
Date: Thu, 19 Nov 2026 14:18:29 +0100
Message-ID: <20261119131830.2535266-3-phasta@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261119131830.2535266-2-phasta@kernel.org>
References: <20261119131830.2535266-2-phasta@kernel.org>
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

dma_fence_timestamp() tests two fence flags with test_bit(), not
providing any ordering.

The while loop + cpu_relax() seem to satisfy the desire to avoid
locking, effectively rebuilding a locks spinning behavior in the rare
case that a fence is signaling right now. Contrary to proper locking,
however, correct memory ordering is not guaranteed.

Ensure correct ordering with locking.

Cc: stable@vger.kernel.org
Fixes: b83ce9cb4a46 ("dma-buf: add dma_fence_timestamp helper")
Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 include/linux/dma-fence.h | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
index dd07d128adc3..34aefb63a7fe 100644
--- a/include/linux/dma-fence.h
+++ b/include/linux/dma-fence.h
@@ -708,13 +708,17 @@ static inline void dma_fence_set_error(struct dma_fence *fence,
  */
 static inline ktime_t dma_fence_timestamp(struct dma_fence *fence)
 {
-	if (WARN_ON(!test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags)))
-		return ktime_get();
+	unsigned long flags;
+	ktime_t ret;
 
-	while (!test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &fence->flags))
-		cpu_relax();
+	dma_fence_lock_irqsave(fence, flags);
+	if (WARN_ON(!dma_fence_test_signaled_flag(fence)))
+		ret = ktime_get();
+	else
+		ret = fence->timestamp;
+	dma_fence_unlock_irqrestore(fence, flags);
 
-	return fence->timestamp;
+	return ret;
 }
 
 signed long dma_fence_wait_timeout(struct dma_fence *,
-- 
2.56.0

