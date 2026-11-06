Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EB0606A31B
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 00:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=ceJGH/zo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EAC7112A28;
	Fri,  6 Nov 2026 00:10:54 +0000 (UTC)
Received: from zebra.cherry.relay.mailchannels.net
 (zebra.cherry.relay.mailchannels.net [23.83.223.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05F8F112A28
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 00:10:46 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 62523402B78;
 Fri, 06 Nov 2026 00:10:46 +0000 (UTC)
Received: from pdx1-sub0-mail-a238.dreamhost.com
 (trex-green-3.trex.outbound.svc.cluster.local [100.99.186.37])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 05663402915;
 Fri, 06 Nov 2026 00:10:46 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Daffy-Supply: 51d886c061b63621_1793923846234_974726844
X-MC-Loop-Signature: 1793923846234:645033397
X-MC-Ingress-Time: 1793923846234
Received: from pdx1-sub0-mail-a238.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.99.186.37 (trex/8.0.2); Fri, 06 Nov 2026 00:10:46 +0000
Received: from offworld.tailf5af7a.ts.net (unknown [190.113.127.252])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dave@stgolabs.net)
 by pdx1-sub0-mail-a238.dreamhost.com (Postfix) with ESMTPSA id 4jLKMS1MqRzylk; 
 Thu,  5 Nov 2026 16:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
 s=dreamhost; t=1793923845;
 bh=tASfhQ0mo1iZyYEs0dPzXgbNfzze51oZYXL83+4KnYA=;
 h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
 b=ceJGH/zobiQSkUdChiHfIlxomPwWyTwTLEej2dIBpp+inw2Thnvzl9HdojgiCOyUM
 qtjAifvivjUrLtp5/g5LetRlQAxuprlJfpHZuE+Rh99Nsir12TO5io5eErtm8ObXj8
 YyZm/qDsUYjIfTIgxP/H02i4UMI5vEoBl3FjDjm3DFGdFcQtAhweWZ5LmaQZpujqya
 gFyIk9hs5ZVzp6uD0QU2c/N9WJP9LDy+yMHM9A6kSeDcSRNQxgpP6KQAkHTlD4kkqs
 P/88gX9++TM7YI0eUb8L6KUePP1qQKQN/26kKuHDFCVBzsvyra4GrDn8ljskQ9TQWt
 VVcrHHKhxeSzA==
From: Davidlohr Bueso <dave@stgolabs.net>
To: sumit.semwal@linaro.org
Cc: christian.koenig@amd.com, phasta@kernel.org,
 benjamin.gaignard@collabora.com, jstultz@google.com, tjmercier@google.com,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 dave@stgolabs.net
Subject: [PATCH v3] dma-buf: system_heap: optimize allocation orders for x86
Date: Thu,  5 Nov 2026 16:10:37 -0800
Message-Id: <20261106001037.2583001-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

Only x86 gets the new order, and it also drops the 64KB order as neither
VT-d nor the AMD-Vi v2 format has a 64KB leaf. Document the current
differences and the effect of fragmentation.

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
changes from v2:
 - removed the 64K on x86 (Christian)
 - patch is retitled to make it more generic

 Documentation/userspace-api/dma-buf-heaps.rst |  4 ++++
 drivers/dma-buf/heaps/system_heap.c           | 24 ++++++++++++++-----
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/Documentation/userspace-api/dma-buf-heaps.rst b/Documentation/userspace-api/dma-buf-heaps.rst
index 92099188893e..af3746aba15f 100644
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
index c8959eadc71d..b3ed6a2533bb 100644
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
+ * x86 uses 2MB, 1MB and 4K. VT-d and AMD-Vi v2 have no 1MB leaf and
+ * AMD-Vi v1 encodes one as 256 replicated 4K entries, so 2MB is the smallest
+ * chunk that installs a single entry. 1MB stays as a fallback for when 2MB
+ * blocks are gone but 1MB ones are not.
+ *
+ * Everywhere else uses 1MB, 64K and 4K, which is optimized for 4K-page Arm
+ * platforms. Here stable performance is preferred to keep the system heap
+ * driver independent, and be less susceptible to fragmentation.
  */
+#ifdef CONFIG_X86
+static const unsigned int orders[] = {9, 8, 0};
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

