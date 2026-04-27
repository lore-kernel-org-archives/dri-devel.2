Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC53CFF8861
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 10:05:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 651CD10E67A;
	Mon, 27 Apr 2026 10:05:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XYDX8QIv";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E93510E67F
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 10:05:18 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 0636D60145;
 Mon, 27 Apr 2026 10:05:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E2E4C2BCB8;
 Mon, 27 Apr 2026 10:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777284317;
 bh=DgPZwjzTFCrRVafEvDDt8RvwW+K7/Y0nWv4ZA667X40=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=XYDX8QIv5rn6XF6AN3mOs8DUJBbHzQ4lcb6GLGW4Ex+wswcwryiFJRPGWOGkSiFDA
 N5qaLLQldCWzxADjPFUxa3SX2HHiz5Vj9Sd0E4qZPKnU3/yBKYKYnSNxE0SeGoG6T+
 sSA8STxJC9vlPYvlIyobICgLPT5lctMnflKiPBQXRmPrkMGTw7K1/2O84alAAG+Ugz
 wSYmwb9ud5CQEbiztSggvtcdkopqBZ9w4O+Ht+1UQPvl7riDL4puO6W6u3gG2rWpjY
 SOA3v+eY2hdrTOgCxtpyj3EJvVo8juB9D5ZAO4TxbA5EEVfI3nAQAnKMQTTX1U3Pfi
 tiqXc9mMgbRUQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 27 Apr 2026 12:04:58 +0200
Subject: [PATCH v5 2/4] dma-buf: heaps: cma: Turn the heap into a module
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-dma-buf-heaps-as-modules-v5-2-b6f5678feefc@kernel.org>
References: <20260427-dma-buf-heaps-as-modules-v5-0-b6f5678feefc@kernel.org>
In-Reply-To: <20260427-dma-buf-heaps-as-modules-v5-0-b6f5678feefc@kernel.org>
To: Sumit Semwal <sumit.semwal@linaro.org>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, 
 "T.J. Mercier" <tjmercier@google.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1748; i=mripard@kernel.org;
 h=from:subject:message-id; bh=DgPZwjzTFCrRVafEvDDt8RvwW+K7/Y0nWv4ZA667X40=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDJnvTS7H/mDasOzXil2rF2y4GBjeWc2Xfag1r22CsoURM
 9P/7NwbHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAie30Z6+zcFMpK9LdFno2d
 KrJ3quyj8u91q/tDKuYwnq5Y6Mux+ew22dTMJweUVrH0Xqk1/1UpxFgfmnwu7ZC91dyFuZk85xo
 5Lwdej35VIPdbv0ug+uvy/l+/LF7vW16tpSbieNL72oxrCoIA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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

All the symbols used by the CMA heap are already exported, so turning it
into a module is straightforward. We only need to add the usual MODULE_*
macros, import the proper namespaces and change the Kconfig symbol to a
tristate.

This heap won't be able to unload though, since we're missing a lot of
infrastructure to make it safe.

Reviewed-by: T.J. Mercier <tjmercier@google.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/dma-buf/heaps/Kconfig    | 2 +-
 drivers/dma-buf/heaps/cma_heap.c | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/dma-buf/heaps/Kconfig b/drivers/dma-buf/heaps/Kconfig
index a5eef06c4226..aed0b9b4febf 100644
--- a/drivers/dma-buf/heaps/Kconfig
+++ b/drivers/dma-buf/heaps/Kconfig
@@ -4,11 +4,11 @@ config DMABUF_HEAPS_SYSTEM
 	help
 	  Choose this option to enable the system dmabuf heap. The system heap
 	  is backed by pages from the buddy allocator. If in doubt, say Y.
 
 config DMABUF_HEAPS_CMA
-	bool "DMA-BUF CMA Heap"
+	tristate "DMA-BUF CMA Heap"
 	depends on DMABUF_HEAPS && DMA_CMA
 	help
 	  Choose this option to enable dma-buf CMA heap. This heap is backed
 	  by the Contiguous Memory Allocator (CMA). If your system has these
 	  regions, you should say Y here.
diff --git a/drivers/dma-buf/heaps/cma_heap.c b/drivers/dma-buf/heaps/cma_heap.c
index a359aac45579..3fb4b946c91a 100644
--- a/drivers/dma-buf/heaps/cma_heap.c
+++ b/drivers/dma-buf/heaps/cma_heap.c
@@ -418,5 +418,8 @@ static int __init add_cma_heaps(void)
 
 	return 0;
 }
 module_init(add_cma_heaps);
 MODULE_DESCRIPTION("DMA-BUF CMA Heap");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("DMA_BUF");
+MODULE_IMPORT_NS("DMA_BUF_HEAP");

-- 
2.53.0

