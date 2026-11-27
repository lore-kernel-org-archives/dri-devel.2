Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB786606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 10:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OC8Foa0M
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23CE41129DA;
	Fri, 27 Nov 2026 10:21:03 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A32501129D4;
 Fri, 27 Nov 2026 10:20:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7C5C543C01;
 Fri, 27 Nov 2026 10:20:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE2D21F00925;
 Fri, 27 Nov 2026 10:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795774851;
 bh=LJAOAOmUEmG/SIqbDw1V2AKXbo1TznTck0yy9LpnC3E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=OC8Foa0MNiS34e6fL7RZdfr4ORrStCI7g2Vvlf1MeFKS+ntVkpsSOodYrAK1Wjzz0
 PxQb1GhcqM3PYiI/axiF5lh+7T9vwe5V/rjBdOilW7wyISUKtfdrsjoXqoi9l+SVEZ
 y8uoeQ4wG+5Pxud4f5IRr6CEI7eDlmQvToc6w056iCgF4OjUeCaIpQS6qoekqwJ1xV
 mt39fr05NrBizGhX08CF7vEMkkSjXr7WqmRiwZ3jDbtXviHWoh6bVNpl2nPWGMfJ8X
 KVgB9RMza6zO7owH7uzkaVFSfmvsH2G3Zv/t60aOTYutgI2ODWmwBvqhErp76m+Du7
 kAu9GJ68IvTkQ==
From: Philipp Stanner <phasta@kernel.org>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Ruslan Vagner <rusya92266@gmail.com>,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 Chris Wilson <chris@chris-wilson.co.uk>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
Subject: [RFC PATCH 8/8] dma-buf: dma-fence: Remove TIMESTAMP bit
Date: Fri, 27 Nov 2026 11:18:13 +0100
Message-ID: <20261127101812.2706432-10-phasta@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261127101812.2706432-2-phasta@kernel.org>
References: <20261127101812.2706432-2-phasta@kernel.org>
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

All users of DMA_FENCE_FLAG_TIMESTAMP_BIT have been removed. Remove the
bit now, too.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/dma-buf/dma-fence.c | 2 --
 include/linux/dma-fence.h   | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index ab02afdb0f18..58faee7166ae 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -376,9 +376,7 @@ void dma_fence_signal_timestamp_locked(struct dma_fence *fence,
 
 	/* Stash the cb_list before replacing it with the timestamp */
 	list_replace(&fence->cb_list, &cb_list);
-
 	fence->timestamp = timestamp;
-	set_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &fence->flags);
 
 	list_for_each_entry_safe(cur, tmp, &cb_list, node) {
 		INIT_LIST_HEAD(&cur->node);
diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
index 70bb8434ac1a..bab0aa339e05 100644
--- a/include/linux/dma-fence.h
+++ b/include/linux/dma-fence.h
@@ -52,7 +52,6 @@ struct seq_file;
  * DMA_FENCE_FLAG_INITIALIZED_BIT - fence was initialized
  * DMA_FENCE_FLAG_INLINE_LOCK_BIT - use inline spinlock instead of external one
  * DMA_FENCE_FLAG_SIGNALED_BIT - fence is already signaled
- * DMA_FENCE_FLAG_TIMESTAMP_BIT - timestamp recorded for fence signaling
  * DMA_FENCE_FLAG_ENABLE_SIGNAL_BIT - enable_signaling might have been called
  * DMA_FENCE_FLAG_USER_BITS - start of the unused bits, can be used by the
  * implementer of the fence for its own purposes. Can be used in different
@@ -114,7 +113,6 @@ enum dma_fence_flag_bits {
 	DMA_FENCE_FLAG_INLINE_LOCK_BIT,
 	DMA_FENCE_FLAG_SEQNO64_BIT,
 	DMA_FENCE_FLAG_SIGNALED_BIT,
-	DMA_FENCE_FLAG_TIMESTAMP_BIT,
 	DMA_FENCE_FLAG_ENABLE_SIGNAL_BIT,
 
 	DMA_FENCE_FLAG_USER_BITS, /* must always be last member */
-- 
2.56.0

