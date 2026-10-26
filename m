Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7CA606A31B
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 14:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MIai2ghn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D0D610E4A1;
	Mon, 26 Oct 2026 14:20:55 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C068810E03B;
 Mon, 26 Oct 2026 14:20:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7EE3B41AB6;
 Mon, 26 Oct 2026 14:20:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF0351F01825;
 Mon, 26 Oct 2026 14:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793024449;
 bh=C2HHrlRp9L/SfQGFTahAQ/ZmI7daYrPt8M6w3ijLAkg=;
 h=From:To:Cc:Subject:Date;
 b=MIai2ghnQdq34w5JBGVmeA6HhT7WYKC2zTuRfrCr4hC3H5ilmncWdsuMjAlIKj6fg
 VK7eWvK3pNRV5D/dplNhdij1KsElKKc+1YFXMe/4g7HafD5Xc/T5UweTYgCPt3MvYA
 nt4m5TZ9BUJvZIUvNSwEkEo4sFIKwUTsu6LbQngDtYMyri/as6WWFdUTOoFkEVphxa
 nJBcNBkAbrNBEJ4md25m1wAmGIUsivgioHSQ7N2VzqV58iXURCJ4F+YffJL9C1OAHn
 u6Y4cwZVLiO7YgC3l5aACoghco4Ivvkd4//JMbpq9/UtHAqz56/59JMSCOYbxWpUVT
 NrF/ikM0bdlWA==
From: Philipp Stanner <phasta@kernel.org>
To: Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 Philipp Stanner <phasta@kernel.org>
Subject: [PATCH] drm/amdgpu: Harden against potential deadlock
Date: Mon, 26 Oct 2026 15:15:42 +0100
Message-ID: <20261026141541.469727-2-phasta@kernel.org>
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

amdgpu's KFD eviction fence's dma_fence ops->enable_signaling() contains
a dma_fence_is_signaled() check.

ops->enable_signaling() is currently consistently being called with the
dma_fence lock held. dma_fence_is_signaled() might try to take this lock
in its dma_fence_signal() call.

This deadlock can currently not occur because the amdkfd_fence_ops do
not implement ops->signaled. Should that ever be added, however,
deadlocks might occur occasionally once the fastpath check in
dma_fence_is_signaled() is skipped.

Replace dma_fence_is_signaled() with dma_fence_is_signaled_locked().

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
As detailed in my recent discussions with Christian [1], I also think
that drivers should be very tightly constrained as to what they do in
the fence_ops. I think at the very least they shouldn't use any
dma_fence functions there.

So we could also remove this check here completely;
__dma_fence_enable_signaling() already checks the signaled-flag, after
all, but I'm not sure whether that might break amdgpu.


P.

[1] https://lore.kernel.org/dri-devel/320b6e7c75da6f05c015e89df0e2c7d11f20d70a.camel@mailbox.org/
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
index 9b10d015671c..61621eebb2b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
@@ -123,7 +123,8 @@ static bool amdkfd_fence_enable_signaling(struct dma_fence *f)
 	if (!fence)
 		return false;
 
-	if (dma_fence_is_signaled(f))
+	/* The enable_signaling() ops is called under lock protection. */
+	if (dma_fence_is_signaled_locked(f))
 		return true;
 
 	if (!kgd2kfd_schedule_evict_and_restore_process(fence->mm, fence->context_id, f))
-- 
2.56.0

