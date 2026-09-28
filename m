Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D7D5CA5FA3
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 20:23:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C7F710EBC9;
	Mon, 28 Sep 2026 20:23:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=stgolabs.net header.i=@stgolabs.net header.b="VgQSPCWn";
	dkim-atps=neutral
Received: from dog.elm.relay.mailchannels.net (dog.elm.relay.mailchannels.net
 [23.83.212.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B81E010E999
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 20:23:54 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 4AF014C0A8A;
 Mon, 28 Sep 2026 19:58:55 +0000 (UTC)
Received: from pdx1-sub0-mail-a209.dreamhost.com
 (100-96-3-213.trex-nlb.outbound.svc.cluster.local [100.96.3.213])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 0A9D74C0981;
 Mon, 28 Sep 2026 19:58:55 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Stop-Madly: 12e05b0e4599c17b_1790625535215_161803816
X-MC-Loop-Signature: 1790625535215:1035580471
X-MC-Ingress-Time: 1790625535215
Received: from pdx1-sub0-mail-a209.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.96.3.213 (trex/8.0.2); Mon, 28 Sep 2026 19:58:55 +0000
Received: from offworld.lan (unknown [76.167.199.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dave@stgolabs.net)
 by pdx1-sub0-mail-a209.dreamhost.com (Postfix) with ESMTPSA id 4htsZQ2Rs1z1Pr; 
 Mon, 28 Sep 2026 12:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
 s=dreamhost; t=1790625534;
 bh=jaBMsr2o3eEt85eYJWBiqf5Zi50lGEnm38IUJ3i3Vr8=;
 h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
 b=VgQSPCWn22b4R3Th1g5qGbqptLabrvu23tx3QF+pjqTg+ZQA/1KBf97rRi4aMFTqF
 Kihbc1YgCjXgZOKdOdJwG1VsqIhe4WyeyWs7jpHf5UiBi1nCRZEjqx6KH+lyKPMxIj
 ICX7hjN7AMffny272TNHn1fj2ersMtiX+lZo5KJMj9YNPCmK1gYoiiZjTULhGTkesM
 6iBXPgE3xBoAh6jPM/YCp/ljBM86xx3s5D4wi4jYn9gh9cJ8hzA8o/JAQTM3nMeR+T
 AyggRBAb4UZ0CNIhd/+/9eAYULeo12f9obpfKOpxoAgBX1A2moGL8dI4z/bdsChhAX
 ma3ZInaxOUtdQ==
From: Davidlohr Bueso <dave@stgolabs.net>
To: sumit.semwal@linaro.org,
	christian.koenig@amd.com,
	phasta@kernel.org
Cc: benjamin.gaignard@collabora.com, jstultz@google.com, tjmercier@google.com,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 dave@stgolabs.net
Subject: [PATCH v2 2/2] dma-buf: system_heap: allocate 2MB chunks on x86
Date: Mon, 28 Sep 2026 12:58:50 -0700
Message-Id: <20260928195850.1982569-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260928195850.1982569-1-dave@stgolabs.net>
References: <20260928195850.1982569-1-dave@stgolabs.net>
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
mappings, but no 1MB leaf. A 1MB chunk requires 256 4KB leaf
entries unless it can be combined with adjacent chunks into a
suitably aligned larger mapping.

Adding a 2MB allocation order provides naturally aligned, physically
contiguous chunks matching the 2MB leaf size, without relying on this
being accidental for separate smaller allocations. The new cost
is one failed order-9 attempt (keeping current large allocation semantics)
per buffer when 2MB pages are exhausted.

Only x86 gets the new order. The existing orders are optimized for
4K-page Arm platforms, so they are left as they are. Document the
current differences and the effect of fragmentation.

Two benchmarks, measured on an AMD EPYC 7313P.

(i) Mapping, into an idle NVMe function's translated DMA-FQ domain,
measuring map/unmap, with the v1 page table restricted to 4K/2M/1G
(amd_iommu=v2_pgsizes_only), a 1GB buffer goes from 1024 1MB chunks,
only one of whose 2MB windows was superpage-mappable in that run, to
512 2MB chunks with all 512 mappable. dma_buf_map_attachment() costs
decrease by ~16x on average with ~32x for the worst cases. Unmapping
that buffer drops from ~500 us to 1.25 us.

(ii) A microbench that measures the cost of DMA_HEAP_IOCTL_ALLOC+close
across various thread counts decreases by factors of ~3-7x alleviating
allocator's zone->lock contention by being PMD order and so pcpu list
eligible. Once the buffer size is large enough then the cost of the
zeroing takes over.

Reviewed-by: T.J. Mercier <tjmercier@google.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 Documentation/userspace-api/dma-buf-heaps.rst |  4 ++++
 drivers/dma-buf/heaps/system_heap.c           | 24 ++++++++++++++-----
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/Documentation/userspace-api/dma-buf-heaps.rst b/Documentation/userspace-api/dma-buf-heaps.rst
index f56b743cdb36..03452b653b7c 100644
--- a/Documentation/userspace-api/dma-buf-heaps.rst
+++ b/Documentation/userspace-api/dma-buf-heaps.rst
@@ -15,6 +15,10 @@ A heap represents a specific allocator. The Linux kernel currently supports the
 following heaps:
 
  - The ``system`` heap allocates virtually contiguous, cacheable, buffers.
+   They are assembled from the largest free page blocks the heap can get
+   without reclaiming or compacting memory, so the physical layout of a
+   buffer, and with it how efficiently an IOMMU can map it, depends on how
+   fragmented free memory is at allocation time.
 
  - The ``system_cc_shared`` heap allocates virtually contiguous, cacheable,
    buffers using shared (decrypted) memory. It is only present on
diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
index c8959eadc71d..07721c136c71 100644
--- a/drivers/dma-buf/heaps/system_heap.c
+++ b/drivers/dma-buf/heaps/system_heap.c
@@ -55,14 +55,26 @@ struct dma_heap_attachment {
 #define HIGH_ORDER_GFP  (((GFP_HIGHUSER | __GFP_ZERO | __GFP_NOWARN \
 				| __GFP_NORETRY) & ~__GFP_RECLAIM) \
 				| __GFP_COMP)
-static gfp_t order_flags[] = {HIGH_ORDER_GFP, HIGH_ORDER_GFP, LOW_ORDER_GFP};
 /*
- * The selection of the orders used for allocation (1MB, 64K, 4K) is designed
- * to match with the sizes often found in IOMMUs. Using order 4 pages instead
- * of order 0 pages can significantly improve the performance of many IOMMUs
- * by reducing TLB pressure and time spent updating page tables.
+ * The selection of the orders used for allocation is designed to match with
+ * the sizes often found in IOMMUs. Using large order pages instead of order 0
+ * pages can significantly improve performance by reducing TLB pressure and
+ * time spent updating page tables.
+ *
+ * x86 uses 2MB, 1MB, 64K and 4K. VT-d and AMD-Vi v2 have no 1MB leaf and
+ * AMD-Vi v1 encodes one as 256 replicated 4K entries, so 2MB is the smallest
+ * chunk that installs a single entry. 1MB stays as a fallback for when 2MB
+ * blocks are gone but 1MB ones are not.
+ *
+ * Everywhere else uses 1MB, 64K and 4K, which is optimized for 4K-page Arm
+ * platforms. Here stable performance is preferred to keep the system heap
+ * driver independent, and be less susceptible to fragmentation.
  */
+#ifdef CONFIG_X86
+static const unsigned int orders[] = {9, 8, 4, 0};
+#else
 static const unsigned int orders[] = {8, 4, 0};
+#endif
 #define NUM_ORDERS ARRAY_SIZE(orders)
 
 static int system_heap_set_page_decrypted(struct page *page)
@@ -387,7 +399,7 @@ static struct page *alloc_largest_available(unsigned long size,
 			continue;
 		if (max_order < orders[i])
 			continue;
-		flags = order_flags[i];
+		flags = orders[i] ? HIGH_ORDER_GFP : LOW_ORDER_GFP;
 		if (mem_accounting)
 			flags |= __GFP_ACCOUNT;
 		page = alloc_pages(flags, orders[i]);
-- 
2.39.5

