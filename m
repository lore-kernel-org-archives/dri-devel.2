Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612FF606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 10:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XijseRWA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B986A10FB50;
	Wed, 28 Oct 2026 10:31:54 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A1A010FB3E;
 Wed, 28 Oct 2026 10:31:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E0ADA60120;
 Wed, 28 Oct 2026 10:31:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B601F01825;
 Wed, 28 Oct 2026 10:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793183504;
 bh=VAjeFdERu4BPExsIO4TdMzxKq+luS4JyFfMYKUdYpiQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=XijseRWAjYAxPIZEFTF4euy0aj+08AmpRte4GgHYGx6LI/Ju93KF8h0MOMfmgsuAW
 cIV2NlDajefxjB32WT6Jrzo2szP9h1FTFePZwQ6z6tltZJuSpT2w3QTzQ59wM9Lv2Q
 wIoB4txqmHJatNmjEtV7HvJX3v11ChUKDz1MA/xS0+X/pCz1hegAvf/Cxu7xCB8JPI
 fqrULSTpwmep/SYfeeV1qPm539vhKI/90K7OB163vkCPvQB4EkR6M9vJ2SE/4uzFqa
 kg+9chKOpItlQBVTVozA84qE5qExyAxLPfhlNg/Zac9qn34xNr2Fy77Mk/srp3vMdV
 TPR2pStZZVQEg==
From: Philipp Stanner <phasta@kernel.org>
To: Lucas Stach <l.stach@pengutronix.de>,
 Russell King <linux+etnaviv@armlinux.org.uk>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 Philipp Stanner <phasta@kernel.org>
Subject: [PATCH 2/2] drm/etnaviv: Remove deprecated fence_ops->release()
Date: Wed, 28 Oct 2026 11:31:30 +0100
Message-ID: <20261028103129.1036380-3-phasta@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028103129.1036380-2-phasta@kernel.org>
References: <20261028103129.1036380-2-phasta@kernel.org>
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

The dma_fence->ops->release() callback is deprecated because it prevents
drivers from unloading. All etnaviv does in its implementation is invoke
a kfree_rcu() on the fence.

The fence backend by now also frees fences with kfree_rcu() if
ops->release() is not implemented.

Remove the deprecated callback.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
Just compile-tested.
---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index e51a310c8d70..e75dab5e407d 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -1176,18 +1176,10 @@ static bool etnaviv_fence_signaled(struct dma_fence *fence)
 	return (s32)(f->gpu->completed_fence - f->base.seqno) >= 0;
 }
 
-static void etnaviv_fence_release(struct dma_fence *fence)
-{
-	struct etnaviv_fence *f = to_etnaviv_fence(fence);
-
-	kfree_rcu(f, base.rcu);
-}
-
 static const struct dma_fence_ops etnaviv_fence_ops = {
 	.get_driver_name = etnaviv_fence_get_driver_name,
 	.get_timeline_name = etnaviv_fence_get_timeline_name,
 	.signaled = etnaviv_fence_signaled,
-	.release = etnaviv_fence_release,
 };
 
 static struct dma_fence *etnaviv_gpu_fence_alloc(struct etnaviv_gpu *gpu)
-- 
2.56.0

