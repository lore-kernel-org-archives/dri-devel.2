Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D40C5DF87
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 15:01:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4681010F08E;
	Thu, 20 Aug 2026 15:01:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="Ma6tz2BA";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 67BB410F08E
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 15:01:03 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED6E41BCA;
 Thu, 20 Aug 2026 08:00:58 -0700 (PDT)
Received: from e122027.cambridge.arm.com (e122027.cambridge.arm.com
 [10.1.25.29])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 398033F85F;
 Thu, 20 Aug 2026 08:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1787238062; bh=H394JPwKh5ipjx6sMEgyDYJ0A1zAKvArd6u5QxFZBh4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Ma6tz2BAfOirAgwCL52wKz4U4JocafrPECKECXDxFMJVGrUtFe5TVjJLfoEHZwVcd
 2fbXRiQgpsChx/8M8CZJMFewUOoA0XhabztzKG39rFilW8Vmyf9iV4DjIVxIsGzUbY
 RUyxOno7+OBcAKqNj/Tlm8ov3angvrNIaVsDZHEs=
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
 Suzuki K Poulose <suzuki.poulose@arm.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2 3/4] dma-buf: heaps: Zero system shared heap pages after
 conversion
Date: Thu, 20 Aug 2026 16:00:32 +0100
Message-ID: <20260820150034.88729-4-steven.price@arm.com>
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

The system_cc_shared heap allocates pages with __GFP_ZERO before converting
them from private to shared with set_memory_decrypted(). This assumes that
the conversion preserves the contents of the pages.

For Arm CCA with MEC (Memory Encryption Contexts) the key used to access
the page will change, and so by default the visible data will change.
The host could ensure that it zeros the page after decryption, but
rather than relying on the host's behaviour it's best if the guest
simply zeros after the decryption rather than before.

For CC shared buffers, defer zeroing until each page has been converted
successfully. For other buffers keep the existing behaviour.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Fixes: 78b30c50a7ac ("dma-buf: heaps: system: add system_cc_shared heap for explicitly shared memory")
Signed-off-by: Steven Price <steven.price@arm.com>
---
 drivers/dma-buf/heaps/system_heap.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
index c8959eadc71d..f14930904089 100644
--- a/drivers/dma-buf/heaps/system_heap.c
+++ b/drivers/dma-buf/heaps/system_heap.c
@@ -376,7 +376,8 @@ static const struct dma_buf_ops system_heap_buf_ops = {
 };
 
 static struct page *alloc_largest_available(unsigned long size,
-					    unsigned int max_order)
+					    unsigned int max_order,
+					    bool defer_zero)
 {
 	struct page *page;
 	int i;
@@ -388,6 +389,9 @@ static struct page *alloc_largest_available(unsigned long size,
 		if (max_order < orders[i])
 			continue;
 		flags = order_flags[i];
+		/* Decryption can change the contents, so clear it afterwards. */
+		if (defer_zero)
+			flags &= ~__GFP_ZERO;
 		if (mem_accounting)
 			flags |= __GFP_ACCOUNT;
 		page = alloc_pages(flags, orders[i]);
@@ -438,7 +442,8 @@ static struct dma_buf *system_heap_allocate(struct dma_heap *heap,
 			goto free_buffer;
 		}
 
-		page = alloc_largest_available(size_remaining, max_order);
+		page = alloc_largest_available(size_remaining, max_order,
+					       cc_shared_buffer(buffer));
 		if (!page)
 			goto free_buffer;
 
@@ -461,9 +466,12 @@ static struct dma_buf *system_heap_allocate(struct dma_heap *heap,
 
 	if (cc_shared_buffer(buffer)) {
 		for_each_sgtable_sg(table, sg, i) {
-			ret = system_heap_set_page_decrypted(sg_page(sg));
+			page = sg_page(sg);
+			ret = system_heap_set_page_decrypted(page);
 			if (ret)
 				goto free_pages;
+
+			clear_pages(page_address(page), 1 << compound_order(page));
 		}
 	}
 
-- 
2.43.0

