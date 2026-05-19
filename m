Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15346CD4851
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 06:24:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7457110EA8D;
	Tue, 19 May 2026 06:24:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CD2v9CJp";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 843BE10EA77
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 06:24:39 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 3944943D36;
 Tue, 19 May 2026 06:24:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A715C2BCB3;
 Tue, 19 May 2026 06:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779171879;
 bh=VcUrD//oUZnQvql1wMIPcTSBy0GWQBFqjz1wAD1jEJo=;
 h=From:To:Cc:Subject:Date:From;
 b=CD2v9CJpTSarRp+GoMDt5TQdmsvn+jquUX8iP5O+RihoGx+qCzcVuYeeJEdNTZ3ty
 W+0yvOKHtcYgzFZOJv/qT6OmNCusoneHcxOQyLx2ZAuLLNws9c3iynitrTAmIgNOwg
 9i3rg7NUvdpiYmjXwTW33wFCPl74rCpt4xQEn2XaImN/pq14BeHagYSGR+RXjkO1Fc
 IsO+8z0gfRUBD+oUYUX55L2+lcMwEal6SgQVY5XtKzEKNn1loAYz/I5NJHC9LehnBi
 9NIdBlFvQEeQsVYEO3PB/ahPg43sJp/Q+a1+uLfSRmFUMAcBZ484IW9qG9uD4T2nOX
 x1LZ4WKSgxkNg==
From: Jisheng Zhang <jszhang@kernel.org>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 "T . J . Mercier" <tjmercier@google.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dma-buf: system_heap: Use LIST_HEAD() to initialize on stack
 list head
Date: Tue, 19 May 2026 14:05:32 +0800
Message-ID: <20260519060532.13221-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.51.0
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

Use LIST_HEAD to initialize on stack list head. No intentional
functional impact.

Change generated with below coccinelle script:

@@
identifier name;
@@
- struct list_head name;
+ LIST_HEAD(name);
... when != name
- INIT_LIST_HEAD(&name);

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/dma-buf/heaps/system_heap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
index 03c2b87cb111..6f8b7138ff56 100644
--- a/drivers/dma-buf/heaps/system_heap.c
+++ b/drivers/dma-buf/heaps/system_heap.c
@@ -409,7 +409,7 @@ static struct dma_buf *system_heap_allocate(struct dma_heap *heap,
 	struct dma_buf *dmabuf;
 	struct sg_table *table;
 	struct scatterlist *sg;
-	struct list_head pages;
+	LIST_HEAD(pages);
 	struct page *page, *tmp_page;
 	int i, ret = -ENOMEM;
 
@@ -423,7 +423,6 @@ static struct dma_buf *system_heap_allocate(struct dma_heap *heap,
 	buffer->len = len;
 	buffer->cc_shared = cc_shared;
 
-	INIT_LIST_HEAD(&pages);
 	i = 0;
 	while (size_remaining > 0) {
 		/*
-- 
2.53.0

