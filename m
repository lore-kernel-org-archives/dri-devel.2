Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80681C88E72
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 21:30:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1F3A10F2A4;
	Mon, 14 Sep 2026 21:30:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=stgolabs.net header.i=@stgolabs.net header.b="BiGpW2hk";
	dkim-atps=neutral
X-Greylist: delayed 468 seconds by postgrey-1.36 at gabe;
 Mon, 14 Sep 2026 21:30:49 UTC
Received: from dog.elm.relay.mailchannels.net (dog.elm.relay.mailchannels.net
 [23.83.212.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93FBB10F2A4
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 21:30:49 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id E2542720527;
 Mon, 14 Sep 2026 21:23:01 +0000 (UTC)
Received: from pdx1-sub0-mail-a247.dreamhost.com
 (trex-green-3.trex.outbound.svc.cluster.local [100.100.68.70])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id B116A720968;
 Mon, 14 Sep 2026 21:23:01 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Soft-Whistle: 3a3d47cb4edfe880_1789420981837_1410610308
X-MC-Loop-Signature: 1789420981837:1682820129
X-MC-Ingress-Time: 1789420981836
Received: from pdx1-sub0-mail-a247.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.100.68.70 (trex/8.0.2); Mon, 14 Sep 2026 21:23:01 +0000
Received: from offworld.lan (unknown [76.167.199.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dave@stgolabs.net)
 by pdx1-sub0-mail-a247.dreamhost.com (Postfix) with ESMTPSA id 4hkJ5x06xpzyrD; 
 Mon, 14 Sep 2026 14:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
 s=dreamhost; t=1789420981;
 bh=m8rfwDK1X1NpPD/EyT7uYwRVnALvlAqDvKBxfrxrlaM=;
 h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
 b=BiGpW2hkMBPjMn5D3OQbzNyPxvrt4j+e1WXBYR0PfbCKKpalfbPFuiu0JJ2IjRi7T
 rfzudTu+d7peGqsE4awYjzz3MYnToeAjQx3lXCeRMeWKMju7eQIjYvZG5l9eME8tmj
 XgjWs5Jh/B3iTfMdmLO+8nRdy9rvzEQxFUVglsklfLms+tQca5eDHl6aADp/ATRPLo
 BOsin15yeDI6VYeg7kXEim3UvdpvEcmE/ilxfOoeBQGtf/PfXckS6d8j/KQyXgU+99
 ukc44RXYF+bUTTUlfrMHgpv8KXxenMei6tnp+wvKejvRL/nd4V2g8qwFtxM1NZmvgX
 NV7Pf4y6Vx1Kw==
From: Davidlohr Bueso <dave@stgolabs.net>
To: sumit.semwal@linaro.org,
	christian.koenig@amd.com,
	phasta@kernel.org
Cc: benjamin.gaignard@collabora.com, jstultz@google.com, tjmercier@google.com,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH 2/3] dma-buf: system_heap: fix the allocation ladder on non-4K
 base pages
Date: Mon, 14 Sep 2026 14:22:57 -0700
Message-Id: <20260914212258.2657788-3-dave@stgolabs.net>
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

The orders for large base page sizes are calculated incorrectly, and
currently only hold for the 4K case. Order 9 is intended for 2MB but
will be 8MB on 16K, for example. Adjust the orders/sizes accordingly.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/dma-buf/heaps/system_heap.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
index 621cf238ef97..341631e4a9ec 100644
--- a/drivers/dma-buf/heaps/system_heap.c
+++ b/drivers/dma-buf/heaps/system_heap.c
@@ -16,12 +16,15 @@
 #include <linux/dma-heap.h>
 #include <linux/err.h>
 #include <linux/highmem.h>
+#include <linux/log2.h>
 #include <linux/mem_encrypt.h>
+#include <linux/minmax.h>
 #include <linux/mm.h>
 #include <linux/set_memory.h>
 #include <linux/module.h>
 #include <linux/pgtable.h>
 #include <linux/scatterlist.h>
+#include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 
@@ -55,15 +58,18 @@ struct dma_heap_attachment {
 #define HIGH_ORDER_GFP  (((GFP_HIGHUSER | __GFP_ZERO | __GFP_NOWARN \
 				| __GFP_NORETRY) & ~__GFP_RECLAIM) \
 				| __GFP_COMP)
-static gfp_t order_flags[] = {HIGH_ORDER_GFP, HIGH_ORDER_GFP,
-			      HIGH_ORDER_GFP, LOW_ORDER_GFP};
+#define SIZE_ORDER(sz) \
+	MIN(MAX(const_ilog2(sz) - PAGE_SHIFT, 0), MAX_PAGE_ORDER)
+
 /*
  * The selection of the orders used for allocation (2MB, 1MB, 64K, 4K) is
  * designed to match with the sizes often found in IOMMUs. Using larger order
  * pages instead of order 0 pages can significantly improve the performance of
  * many IOMMUs by reducing TLB pressure and time spent updating page tables.
  */
-static const unsigned int orders[] = {9, 8, 4, 0};
+static const unsigned int orders[] = {
+	SIZE_ORDER(SZ_2M), SIZE_ORDER(SZ_1M), SIZE_ORDER(SZ_64K), 0
+};
 #define NUM_ORDERS ARRAY_SIZE(orders)
 
 static int system_heap_set_page_decrypted(struct page *page)
@@ -384,11 +390,13 @@ static struct page *alloc_largest_available(unsigned long size,
 	gfp_t flags;
 
 	for (i = 0; i < NUM_ORDERS; i++) {
+		if (i && orders[i] == orders[i - 1])
+			continue;
 		if (size <  (PAGE_SIZE << orders[i]))
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

