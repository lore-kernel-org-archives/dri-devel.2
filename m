Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07806FF8862
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 10:05:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43F0510E680;
	Mon, 27 Apr 2026 10:05:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="B5VJ4nOm";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0911A10E67A
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 10:05:21 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E4E7940B4A;
 Mon, 27 Apr 2026 10:05:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FBAEC19425;
 Mon, 27 Apr 2026 10:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777284320;
 bh=w3bOeqsmZCH7lExtgu4jad1VQEqY+xcph4TYjp2BMBI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=B5VJ4nOma41s0tSADfOQR9W2KboiZ5piD1EE8wKy7Lp4uDXsd1vc5IH93y0jHLFlR
 qtU63wIhGahoxYHjENb8zzEGdVdvxiLtrqtee3WW4KzOhksF+gfTzSm02/0fDCRWMm
 bxlZPUWPJASgvS/Du7waektZBrDivA6Lnk87fEJQcY0TbvVAV9QPwtl+B1w/3Sb2vq
 iUSdEJPtrQ/jPlyjGWg1Q98AGkBnzOA0UYoUPgan+VqpsB7agz7Si+D3FxcJ4ytyL2
 qfYhZEEcead9FXCFlNR4Rx8iDk4wy3sVjc4Qzht4v5hcUyEJfSq3MEANulSG414zbq
 wR7Jh9aN2otRg==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 27 Apr 2026 12:04:59 +0200
Subject: [PATCH v5 3/4] dma-buf: heaps: system: Turn the heap into a module
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-dma-buf-heaps-as-modules-v5-3-b6f5678feefc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1533; i=mripard@kernel.org;
 h=from:subject:message-id; bh=w3bOeqsmZCH7lExtgu4jad1VQEqY+xcph4TYjp2BMBI=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDJnvTS5vnmz6+F/G9plFi7m0fTbkP81zXaDF2F544c+9S
 59jL6kKdUxlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJWC1lrK850i/wLebzr0Th
 XVO3qn+pPar2QHHF+Zyz7bfXi8ZUvXm0abfdnJU/Xr57aiJ10vG5mRljw/tXr6vY76X/jPKwvBj
 35oCe/YrXpXs77kax7QqTeqtddMs7bEl4RVVbzWfNq3MuV9SbAgA=
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

The system heap can be easily turned into a module by adding the usual
MODULE_* macros, importing the proper namespaces and changing the
Kconfig symbol to a tristate.

This heap won't be able to unload though, since we're missing a lot of
infrastructure to make it safe.

Reviewed-by: T.J. Mercier <tjmercier@google.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/dma-buf/heaps/Kconfig       | 2 +-
 drivers/dma-buf/heaps/system_heap.c | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/dma-buf/heaps/Kconfig b/drivers/dma-buf/heaps/Kconfig
index aed0b9b4febf..e273fb18feca 100644
--- a/drivers/dma-buf/heaps/Kconfig
+++ b/drivers/dma-buf/heaps/Kconfig
@@ -1,7 +1,7 @@
 config DMABUF_HEAPS_SYSTEM
-	bool "DMA-BUF System Heap"
+	tristate "DMA-BUF System Heap"
 	depends on DMABUF_HEAPS
 	help
 	  Choose this option to enable the system dmabuf heap. The system heap
 	  is backed by pages from the buddy allocator. If in doubt, say Y.
 
diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
index 03c2b87cb111..c92bdec356fc 100644
--- a/drivers/dma-buf/heaps/system_heap.c
+++ b/drivers/dma-buf/heaps/system_heap.c
@@ -535,5 +535,10 @@ static int __init system_heap_create(void)
 		return PTR_ERR(sys_heap);
 
 	return 0;
 }
 module_init(system_heap_create);
+
+MODULE_DESCRIPTION("DMA-BUF System Heap");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("DMA_BUF");
+MODULE_IMPORT_NS("DMA_BUF_HEAP");

-- 
2.53.0

