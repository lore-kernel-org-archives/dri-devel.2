Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 092F810D14B4
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 13:36:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60B7310E447;
	Mon, 30 Mar 2026 13:36:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="r7SD/jLT";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB38D10E452
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 13:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=OB2qHX3/E/OfwHyz3KlZXK1pTswdr7Ud7NtjnhGSaME=; b=r7SD/jLTge490yWowLLrZ47fFF
 laYtCSTcRtfi7blA06a0qzXV2uL9ELeHTa9pA3tnQ2VF7xcR+Ah1Op+IBH1hozmFXWGjso2VYuSkD
 8uuPkvGC9OWo9dzBiALNPtg/NjvMXGR8a/7Mt3RQRZR8pq9B3YuCXNDAywGzVU5pUzJuEv/ePPqiQ
 tW3v10dDr4NHW+49Z6VFjYMsuyYCtQ3zQTz0OwbapSpME+9g94WigwjQnvN9F+LYkm7qsU6QBJeCE
 evOFgx5Ys7GGH8Ugevs9W5dwAHnvcEwCZh0CQ8D7WP8biAI8ZOhJ4IYY7UuIyAnQat9f27jjGkHGi
 zBYom1aw==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1w7Cn4-008zww-JY; Mon, 30 Mar 2026 15:36:26 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: [PATCH] dma-fence: Move signalling tracepoint to before ops detach
Date: Mon, 30 Mar 2026 14:36:23 +0100
Message-ID: <20260330133623.17704-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Move the signalling tracepoint to before fence->ops are reset otherwise
tracepoint will dereference a null pointer.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Fixes: 541c8f2468b9 ("dma-buf: detach fence ops on signal v3")
Cc: Christian König <christian.koenig@amd.com>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: Boris Brezillon <boris.brezillon@collabora.com>
Cc: linux-media@vger.kernel.org
Cc: linaro-mm-sig@lists.linaro.org
---
 drivers/dma-buf/dma-fence.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index 1826ba73094c..1c1eaecaf1b0 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -363,6 +363,8 @@ void dma_fence_signal_timestamp_locked(struct dma_fence *fence,
 				      &fence->flags)))
 		return;
 
+	trace_dma_fence_signaled(fence);
+
 	/*
 	 * When neither a release nor a wait operation is specified set the ops
 	 * pointer to NULL to allow the fence structure to become independent
@@ -377,7 +379,6 @@ void dma_fence_signal_timestamp_locked(struct dma_fence *fence,
 
 	fence->timestamp = timestamp;
 	set_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &fence->flags);
-	trace_dma_fence_signaled(fence);
 
 	list_for_each_entry_safe(cur, tmp, &cb_list, node) {
 		INIT_LIST_HEAD(&cur->node);
-- 
2.52.0

