Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E425CC5DF81
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 15:01:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A09310F090;
	Thu, 20 Aug 2026 15:01:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="AnIbFs3q";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 895D110F091
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 15:01:07 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4BB04153B;
 Thu, 20 Aug 2026 08:01:03 -0700 (PDT)
Received: from e122027.cambridge.arm.com (e122027.cambridge.arm.com
 [10.1.25.29])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50FF43F85F;
 Thu, 20 Aug 2026 08:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1787238067; bh=Adowm8TaRmLb4+nhfuTq8XG6Qz8i8b31EokqJq1SBFg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=AnIbFs3qOe6tXAa76/75xbIi30a6sclahiGuKAa7TNyNiW5Z+k4gQ8FETu4UTPSKO
 8Juo5IUGdb+gncLLrOLJBF1w9IYh74/rR/FXRuJR7tsoW1Se2JDZh0t2glua/wxv1v
 ZHr2qdGjJiBb9RZp3FHVr1rdzV1QZD3j0HcXo/HU=
From: Steven Price <steven.price@arm.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Marc Zyngier <maz@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Thomas Gleixner <tglx@kernel.org>
Cc: Steven Price <steven.price@arm.com>, "T.J. Mercier" <tjmercier@google.com>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
 Jiri Pirko <jiri@resnulli.us>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 4/4] dma-buf: heaps: Fix shared system heap allocation
 rollback
Date: Thu, 20 Aug 2026 16:00:33 +0100
Message-ID: <20260820150034.88729-5-steven.price@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820150034.88729-1-steven.price@arm.com>
References: <20260820150034.88729-1-steven.price@arm.com>
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

If converting one of the allocated pages to shared memory fails, the
cleanup path attempts to convert every page back to private memory.
Pages after the failed page have not been converted yet, so attempting
to convert them back can fail and cause otherwise reusable memory to be
leaked.

Count the pages converted successfully and only convert those and the
failed allocation back during cleanup. If converting the failed
allocation back succeeds it can be freed safely; otherwise it is leaked
because its state is unknown. Allocations that were not converted can be
freed directly.

Fixes: 78b30c50a7ac ("dma-buf: heaps: system: add system_cc_shared heap for explicitly shared memory")
Signed-off-by: Steven Price <steven.price@arm.com>
---
 drivers/dma-buf/heaps/system_heap.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
index f14930904089..8d3ffeb64e00 100644
--- a/drivers/dma-buf/heaps/system_heap.c
+++ b/drivers/dma-buf/heaps/system_heap.c
@@ -418,6 +418,7 @@ static struct dma_buf *system_heap_allocate(struct dma_heap *heap,
 	struct scatterlist *sg;
 	struct list_head pages;
 	struct page *page, *tmp_page;
+	int nr_decrypted = 0;
 	int i, ret = -ENOMEM;
 
 	buffer = kzalloc_obj(*buffer);
@@ -472,6 +473,7 @@ static struct dma_buf *system_heap_allocate(struct dma_heap *heap,
 				goto free_pages;
 
 			clear_pages(page_address(page), 1 << compound_order(page));
+			nr_decrypted++;
 		}
 	}
 
@@ -496,9 +498,11 @@ static struct dma_buf *system_heap_allocate(struct dma_heap *heap,
 		 * Intentionally leak pages that cannot be re-encrypted
 		 * to prevent shared memory from being reused.
 		 */
-		if (cc_shared_buffer(buffer) &&
-		    system_heap_set_page_encrypted(p))
-			continue;
+		if (cc_shared_buffer(buffer)) {
+			if (i <= nr_decrypted &&
+			    system_heap_set_page_encrypted(p))
+				continue;
+		}
 		__free_pages(p, compound_order(p));
 	}
 	sg_free_table(table);
-- 
2.43.0

