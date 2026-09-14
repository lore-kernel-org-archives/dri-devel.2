Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A933C88E73
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 21:30:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4E1A10F2A6;
	Mon, 14 Sep 2026 21:30:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=stgolabs.net header.i=@stgolabs.net header.b="rdL4iT5O";
	dkim-atps=neutral
X-Greylist: delayed 467 seconds by postgrey-1.36 at gabe;
 Mon, 14 Sep 2026 21:30:49 UTC
Received: from purple.birch.relay.mailchannels.net
 (purple.birch.relay.mailchannels.net [23.83.209.150])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEA3F10F2A4
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 21:30:49 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 57801721DAB;
 Mon, 14 Sep 2026 21:23:01 +0000 (UTC)
Received: from pdx1-sub0-mail-a247.dreamhost.com
 (trex-green-1.trex.outbound.svc.cluster.local [100.100.67.126])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 073B8721D89;
 Mon, 14 Sep 2026 21:23:01 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Battle-Illegal: 4011a0a06d622046_1789420981272_1568935317
X-MC-Loop-Signature: 1789420981272:1443187600
X-MC-Ingress-Time: 1789420981272
Received: from pdx1-sub0-mail-a247.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.100.67.126 (trex/8.0.2); Mon, 14 Sep 2026 21:23:01 +0000
Received: from offworld.lan (unknown [76.167.199.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dave@stgolabs.net)
 by pdx1-sub0-mail-a247.dreamhost.com (Postfix) with ESMTPSA id 4hkJ5w36GrzyrG; 
 Mon, 14 Sep 2026 14:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
 s=dreamhost; t=1789420980;
 bh=0luPDCr1vELBAZ5cKhi59z+ffr0fEhQe2roACfBE8PI=;
 h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
 b=rdL4iT5O5V1uVSeRHIKUw6ViAux3AsGc046i38oaUR8pATsERO+hWQ8FBhWpuW6EP
 aj1DjrN6lBFEBEL0PcWwlHtxUsm5wkIwxAUDdzYY7MRQpFY2G09or0sh76oD1MRfjX
 lZAUP/2my9oaQ/wZl9PUiV4ehhwysnl9g9ihl+lqpMW2lMNP/NE0Dfuw+1urfZc4Vp
 L214uVxdWYNbmPFPs/AAWLb1jaeuQrORezEwOf7zh0hEQ7A5EULl6vau7qJ7JeXk3V
 0ThQlBTmjhVJ2ltsh3FhqGXCX0rsoj8H+qX6NRSEeX5uQo9j084NHflRbok0suaQFI
 namvTCHZI2yFQ==
From: Davidlohr Bueso <dave@stgolabs.net>
To: sumit.semwal@linaro.org,
	christian.koenig@amd.com,
	phasta@kernel.org
Cc: benjamin.gaignard@collabora.com, jstultz@google.com, tjmercier@google.com,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH 1/3] dma-buf: system_heap: add a 2MB allocation order for
 IOMMU superpages
Date: Mon, 14 Sep 2026 14:22:56 -0700
Message-Id: <20260914212258.2657788-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260914212258.2657788-1-dave@stgolabs.net>
References: <20260914212258.2657788-1-dave@stgolabs.net>
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

With 4KB base pages, the system heap allocates buffers in 1MB, 64KB
and 4KB chunks. The conventional Intel VT-d second-stage and AMD-Vi v2
page-table formats, and Arm SMMU's 64-bit long-descriptor format with
a 4KB translation granule, define 4KB pages and 2MB/1GB large-page
mappings, but no 1MB leaf. A 1MB chunk therefore requires 256 4KB leaf
entries unless it can be combined with adjacent chunks into a
suitably aligned larger mapping.

Adding a 2MB allocation order provides naturally aligned, physically
contiguous chunks matching the 2MB leaf size, without relying on this
being accidental for separate smaller allocations. The new cost
is one failed order-9 attempt (keeping current large allocation semantics)
per buffer when 2MB pages are exhausted.

Two benchmarks, measured on an AMD EPYC 7313P.

(i) Mapping, into an idle NVMe function's translated DMA-FQ domain,
measuring map/unmap: with the v1 page table restricted to 4K/2M/1G
(amd_iommu=v2_pgsizes_only), a 1GB buffer goes from 1024 1MB chunks,
only one of whose 2MB windows was superpage-mappable in that run, to
512 2MB chunks with all 512 mappable. dma_buf_map_attachment() costs
decrease by ~16x on average with ~32x for the worst cases. Unmapping
that buffer drops from ~500 us to 1.25 us.

(ii) A microbench that measures the cost of DMA_HEAP_IOCTL_ALLOC+close
across various thread counts decreases by factors of ~3-7x alleviating
allocator's zone->lock contention by being PMD order and therefore is
pcpu list eligible. Once the buffer size is large enough then the cost
of the zeroing takes over.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/dma-buf/heaps/system_heap.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
index c8959eadc71d..621cf238ef97 100644
--- a/drivers/dma-buf/heaps/system_heap.c
+++ b/drivers/dma-buf/heaps/system_heap.c
@@ -55,14 +55,15 @@ struct dma_heap_attachment {
 #define HIGH_ORDER_GFP  (((GFP_HIGHUSER | __GFP_ZERO | __GFP_NOWARN \
 				| __GFP_NORETRY) & ~__GFP_RECLAIM) \
 				| __GFP_COMP)
-static gfp_t order_flags[] = {HIGH_ORDER_GFP, HIGH_ORDER_GFP, LOW_ORDER_GFP};
+static gfp_t order_flags[] = {HIGH_ORDER_GFP, HIGH_ORDER_GFP,
+			      HIGH_ORDER_GFP, LOW_ORDER_GFP};
 /*
- * The selection of the orders used for allocation (1MB, 64K, 4K) is designed
- * to match with the sizes often found in IOMMUs. Using order 4 pages instead
- * of order 0 pages can significantly improve the performance of many IOMMUs
- * by reducing TLB pressure and time spent updating page tables.
+ * The selection of the orders used for allocation (2MB, 1MB, 64K, 4K) is
+ * designed to match with the sizes often found in IOMMUs. Using larger order
+ * pages instead of order 0 pages can significantly improve the performance of
+ * many IOMMUs by reducing TLB pressure and time spent updating page tables.
  */
-static const unsigned int orders[] = {8, 4, 0};
+static const unsigned int orders[] = {9, 8, 4, 0};
 #define NUM_ORDERS ARRAY_SIZE(orders)
 
 static int system_heap_set_page_decrypted(struct page *page)
-- 
2.39.5

