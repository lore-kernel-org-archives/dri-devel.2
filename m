Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7619FB5164
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 21:49:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 370AB10E2F1;
	Mon,  6 Apr 2026 21:49:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ql5GTX9e";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9D3C10E2F1
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Apr 2026 21:49:45 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 9C15860180;
 Mon,  6 Apr 2026 21:49:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE36FC4CEF7;
 Mon,  6 Apr 2026 21:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775512184;
 bh=N+z22Wq+UEerxVHAHodhIfMR6FsXxwnZoZShwWjnMK0=;
 h=From:To:Cc:Subject:Date:From;
 b=Ql5GTX9eykHVTn0dJcvGAyRizNvXj1F315Z9c/ibdXYR25xTk3qp4CXm7MLy52cpa
 OWgpQ2n6zIIpH3rWtG6co4qZ9DcV/uZGrNPgvHLwnt09ra0JgvHyAbxEe8B5e924gu
 Lrv814OFg1k6eMYasonNNSbK8UmzDKpSm2iVvHzf5IEILthB6dlRhfsWYm95SX4v+B
 BtWsyWwG2kcOW2AWVOHHJPZVWEExfOW5+BgmtAy0tqfARhfaM1sb1WwRAydlW9KwIR
 6GIqblsKkLrfsa8gCi2o/LcSPMCcgus1qf+F6c8tN+xdbf9m569SGTmxx9ckctHrQY
 UTjPM16TasV+A==
From: "Barry Song (Xiaomi)" <baohua@kernel.org>
To: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
Cc: linux-kernel@vger.kernel.org, Xueyuan Chen <Xueyuan.chen21@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 "T . J . Mercier" <tjmercier@google.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Barry Song <baohua@kernel.org>
Subject: [PATCH] dma-buf: system_heap: Optimize sg_table-to-pages conversion
 in vmap
Date: Tue,  7 Apr 2026 05:49:38 +0800
Message-Id: <20260406214938.24142-1-baohua@kernel.org>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
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

From: Xueyuan Chen <Xueyuan.chen21@gmail.com>

Replace the heavy for_each_sgtable_page() iterator in system_heap_do_vmap()
with a more efficient nested loop approach.

Instead of iterating page by page, we now iterate through the scatterlist
entries via for_each_sgtable_sg(). Because pages within a single sg entry
are physically contiguous, we can populate the page array with a in an
inner loop using simple pointer math. This save a lot of time.

The WARN_ON check is also pulled out of the loop to save branch
instructions.

Performance results mapping a 2GB buffer on Radxa O6:
- Before: ~1440000 ns
- After:  ~232000 ns
(~84% reduction in iteration time, or ~6.2x faster)

Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc: Brian Starkey <Brian.Starkey@arm.com>
Cc: John Stultz <jstultz@google.com>
Cc: T.J. Mercier <tjmercier@google.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Xueyuan Chen <Xueyuan.chen21@gmail.com>
Signed-off-by: Barry Song (Xiaomi) <baohua@kernel.org>
---
 drivers/dma-buf/heaps/system_heap.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
index b3650d8fd651..769f01f0cc96 100644
--- a/drivers/dma-buf/heaps/system_heap.c
+++ b/drivers/dma-buf/heaps/system_heap.c
@@ -224,16 +224,21 @@ static void *system_heap_do_vmap(struct system_heap_buffer *buffer)
 	int npages = PAGE_ALIGN(buffer->len) / PAGE_SIZE;
 	struct page **pages = vmalloc(sizeof(struct page *) * npages);
 	struct page **tmp = pages;
-	struct sg_page_iter piter;
 	void *vaddr;
+	u32 i, j, count;
+	struct page *base_page;
+	struct scatterlist *sg;
 
 	if (!pages)
 		return ERR_PTR(-ENOMEM);
 
-	for_each_sgtable_page(table, &piter, 0) {
-		WARN_ON(tmp - pages >= npages);
-		*tmp++ = sg_page_iter_page(&piter);
+	for_each_sgtable_sg(table, sg, i) {
+		base_page = sg_page(sg);
+		count = sg->length >> PAGE_SHIFT;
+		for (j = 0; j < count; j++)
+			*tmp++ = base_page + j;
 	}
+	WARN_ON(tmp - pages != npages);
 
 	vaddr = vmap(pages, npages, VM_MAP, PAGE_KERNEL);
 	vfree(pages);
-- 
2.39.3 (Apple Git-146)

