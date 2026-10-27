Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D13606A32E
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 13:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZyI/32R9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F14410F4D7;
	Tue, 27 Oct 2026 13:38:30 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5ABE10F4D7;
 Tue, 27 Oct 2026 13:38:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 33DA860219;
 Tue, 27 Oct 2026 13:38:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 403B71F01829;
 Tue, 27 Oct 2026 13:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793108303;
 bh=bdFuKFPvJb24h483XRJDDX0AS0+LMMV13jr+VJbbWIQ=;
 h=From:To:Cc:Subject:Date;
 b=ZyI/32R9ROwORaTnT0OlGJ+hZX6pcdFJdIWoIf6G8El5uRC/8gfdf5Vk4SVqr9CLI
 QOkqtdNKMggOR/N1wBcMMx4e8IQy6bBfaKWe2N8tL3SAeA3BNufFvysEJtwDzc9eYE
 1BGAkQ0rIj0o0JkiYqFN9gu0dDiyikg4j69XacO8Op4164xew5wRms62JrE5ykN4+p
 FGdSRhiIf95F9sk4VkKFclRefAB/71d3s99fg8aTagoYoIDbdMzyUaK5SyP9wXyd5y
 DqkoeqG3z6TFP73wDePrRUViVxlulFrHXJRKUA54OC+738ErVWAaP12Z/amAvRgXQ8
 hfHA8URGZii8A==
From: Philipp Stanner <phasta@kernel.org>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>, Jesse Zhang <jesse.zhang@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Kexin Sun <kexinsun@smail.nju.edu.cn>, Philipp Stanner <phasta@kernel.org>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH] drm/amdgpu: amdgpu_fence: remove ops->release()
Date: Tue, 27 Oct 2026 14:37:28 +0100
Message-ID: <20261027133727.748652-2-phasta@kernel.org>
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

amdgpu's fence implements the deprecated fence_ops->release() callback
which prevents the driver from ever unloading robustly.

amdgpu's implementation merely uses a call_rcu() that performs a kfree()
on the fence - this functionality is already centrally implemented by
the dma_fence backend.

The dma_fence backend invokes a kfree_rcu() on the dma_fence, which is
fine since this is always the first member of a struct amdgpu_fence.
Thus, amdgpu's implementation is redundant.

Remove fence_ops->release().

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
Just saw that this should be unnecessary? Don't have a setup for amdgpu
testing right now, so please take a close look, just compile-tested.

P.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 29 -----------------------
 1 file changed, 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 3043ad041bb4..3f8b2571d74a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -892,39 +892,10 @@ static bool amdgpu_fence_enable_signaling(struct dma_fence *f)
 	return true;
 }
 
-/**
- * amdgpu_fence_free - free up the fence memory
- *
- * @rcu: RCU callback head
- *
- * Free up the fence memory after the RCU grace period.
- */
-static void amdgpu_fence_free(struct rcu_head *rcu)
-{
-	struct dma_fence *f = container_of(rcu, struct dma_fence, rcu);
-
-	/* free fence_slab if it's separated fence*/
-	kfree(to_amdgpu_fence(f));
-}
-
-/**
- * amdgpu_fence_release - callback that fence can be freed
- *
- * @f: fence
- *
- * This function is called when the reference count becomes zero.
- * It just RCU schedules freeing up the fence.
- */
-static void amdgpu_fence_release(struct dma_fence *f)
-{
-	call_rcu(&f->rcu, amdgpu_fence_free);
-}
-
 static const struct dma_fence_ops amdgpu_fence_ops = {
 	.get_driver_name = amdgpu_fence_get_driver_name,
 	.get_timeline_name = amdgpu_fence_get_timeline_name,
 	.enable_signaling = amdgpu_fence_enable_signaling,
-	.release = amdgpu_fence_release,
 };
 
 /*

base-commit: 731ba09867520c047c7de53f92e384808e0b638e
-- 
2.56.0

