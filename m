Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A60C4C531D0
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 07:08:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77C1810EFD2;
	Thu, 23 Jul 2026 07:07:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=x6u.co header.i=@x6u.co header.b="EA0/C/p7";
	dkim-atps=neutral
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com
 [209.85.128.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACCD510E30F
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 23:39:38 +0000 (UTC)
Received: by mail-yw1-f182.google.com with SMTP id
 00721157ae682-81e69a2db34so803887b3.0
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 16:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=x6u.co; s=google; t=1784763578; x=1785368378; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=czUeoqytFwl2f4wSjedp4ua+inBVMuooqHyWYibjU+0=;
 b=EA0/C/p71Wem1n9Rtyl4AYt7Qq1W1olJIGjKlf1sXPLlfhGoRz0mLpdYDnjNk3v/LM
 csEsbXVywztE6WKlKWtrvlkXN61gbbjIiN4ugp7QttSaN71Almyo6TqJYFNM2z6ygVlC
 y0+z20Us+C8ls+ICpdSTaNH/LeBV7C4eAc0XVJwqJdL1w1EHHLXecVfAlazdJ4sD/D0n
 NhONxOecLptdJdcXQOyq1wzF9zAUycKXDHDsK+eDruc8LDUshPGyydZS0gSHTohLMg6p
 pjlkgGh9Ybhl7eGkvrQ7dFNO6ARYoB22SnNznFOvuMZlxNPWr3VDbIjuLaLKAcT1oDHY
 Fr2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784763578; x=1785368378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=czUeoqytFwl2f4wSjedp4ua+inBVMuooqHyWYibjU+0=;
 b=SkC+MYkgab1RzCocmGrmB2DrOCoM5uxY/mlF84WeVl+HnaNLALzq1Sf5f40RI5r0rV
 I7klieh0uYukgAWeYjGohzAO+u/hIaAUXVKIQcLKT31f10OJZpSFQzgmxFMmZq4tq/3q
 llhTp+Qnw3OeeDibeZq072zjN21CARlyqdJiyT2S3xjUVi6z+0U1JehLvL6D/bLrYUhY
 0bcDgXasZTmklkHoLo/e6WGTfLWCr8PZ2AISd91vwH7t4SJIW9J3n4QiIz1b1EjLwyfK
 FasXdtkVWcLugzox82ilCMMN9VItXfXhmdBjfvSf8HpcGSYBSRipo8RPwn+HlTbtlrLI
 RwqA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoCqtmis7zFbGWGIx9KT3WFzA4loY91ffZJb6lpzGANxiV5vslt+4iAKTJ+ul0L/lvaJYlWuOrYqug=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw1hTtcvdHs8TCaTINk8K8c5gKnH82ttZI3W+xzh2rF0hIgIVjV
 tXhIMOWDTqkbu+vOVYQKCEpddCgKOveKc/G3L1TrCIMa1EkOV3lKFgfYZe2HJYEEAZMl
X-Gm-Gg: AR+sD12BB7D9CtBEf7n3RzYatrwrw4y7I52zOBpEBTayw0GgudJVGU3KvSMLIm38NP8
 9qSoaoGbM92KS1XDwXHqExXjZlQfA0OI5KSZUjpHFT074zA0rKqObvy5xBaU9KLvEaX6t8WcBbk
 7S2n3E2OLN7mIEI27NdLB70b/JAXLvzOBOqZkHJARkox4iOncZbMtQdR+xsFgtEvglnwNiiTpCl
 czn/fSo0AnKYN8j+kb2ZrQLSl5wLzZx/K4L8OScO5jTR3ZOfYN2eTRFLg+305aA43eKwTBPafNN
 p/D0QZEBOU8ugvV5M/3NYuCSKS57anC6RfLodZ+cejc1Ub7vBEzHGiG5BDhFDP7Qeo011+Q0U2V
 yiCcE6TuPRVwgUV4i6w/ooGC+3u3RJDTxfNhd42DbyzQw8uhXr8yblHnmXVC2mPCzPQagNMVGEw
 67vTdqpwPlvQodFB7J1g0vAi8oKeIKqUyj1m8dXkdmGzEAwalCOcH8kUvdSKvdDt9av3U=
X-Received: by 2002:a05:690c:9a87:b0:7ff:19d6:74ee with SMTP id
 00721157ae682-81f4c31fe46mr2273147b3.33.1784763577509; 
 Wed, 22 Jul 2026 16:39:37 -0700 (PDT)
Received: from worldpeace10.c.googlers.com.com
 (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66890794b1asm2152505d50.20.2026.07.22.16.39.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 16:39:37 -0700 (PDT)
From: dhu@x6u.co
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
 David Laight <david.laight.linux@gmail.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>,
 Alex Williamson <alex@shazbot.org>, Pranjal Shrivastava <praan@google.com>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, stable@vger.kernel.org, jmoroni@google.com,
 kpberry@google.com, chriscli@google.com, viursachi@google.com,
 xuehaohu@google.com, sashiko-bot <sashiko-bot@kernel.org>
Subject: [PATCH v3] dma-buf: Split sgl by largest page-aligned chunk
Date: Wed, 22 Jul 2026 23:39:32 +0000
Message-ID: <20260722233932.3997681-1-dhu@x6u.co>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260623015459.1153884-1-xuehaohu@google.com>
References: <20260623015459.1153884-1-xuehaohu@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 23 Jul 2026 07:07:31 +0000
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

From: David Hu <xuehaohu@google.com>

Currently, `fill_sg_entry()` splits the scatterlist using `UINT_MAX`.
This creates a non-page-aligned DMA length (`0xFFFFFFFF`) for the
first entry, resulting in non-page-aligned DMA addresses for all
subsequent entries.

While the underlying IOMMU mapping may be contiguous, hardware
DMA engines often require explicit address alignment (e.g., page,
cacheline, or storage sector boundaries). Passing unaligned
addresses and lengths can cause explicit failures in DMA descriptor
creation or silent data corruption if lower unaligned bits are
truncated.

In addition, a non-page-aligned sgl length will trigger an edge case
in `ib_umem_find_best_pgsz()`. In case of a discontinuity in later
buffers, we will have a `va` with lowest bit set to 1. That will lead
to `ib_umem_find_best_pgsz()` always return 0, and break the promise
to find best page size for the mapping on the NIC side.

Fix this by splitting the scatterlist by the largest possible page
aligned chunk within `UINT_MAX` (`ALIGN_DOWN(UINT_MAX, PAGE_SIZE)`).
This ensures all scatterlist DMA addresses and lengths remain page
aligned, while minimizing the total number of sgl entries.

Page-aligned entries allow the system to cleanly chunk payloads into
PCIe MaxPayloadSize (MPS) (e.g., 128 bytes, 256 bytes, 512 bytes).
As a result, this may help reduce TLP fragmentation in P2P transfers
and alleviate potential congestion within a logical PCIe switch
partition, especially when Relaxed Ordering is not possible due to
hardware constraints.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260609165431.778061F00893@smtp.kernel.org/
Fixes: 3aa31a8bb11e ("dma-buf: provide phys_vec to scatter-gather mapping routine")
Cc: stable@vger.kernel.org
Signed-off-by: David Hu <xuehaohu@google.com>
---
 Changes in v3:
 - Removed the type cast for `min` (David Laight)
 - Reverted max ent size to be `ALIGN_DOWN(UINT_MAX, PAGE_SIZE)` and
   updated commit message to reflect that (Jason Gunthorpe)
 - Updated commit message to reflect that this also fixes an edge case
   in `ib_umem_find_best_pgsz()`

 Changes in v2:
 - Updated commit title and message to reflect the switch to 2G chunks
 - Switch to using 2G as the max sg entry size as it naturally aligns
   with most hardware boundaries, while allowing compiler optimizations
   with bit shifts (David Laight)
 - Optimized away division calculation for `nent`, and multiplication
   calculation for sgl address, by dropping the `for` loop in favor of a
   `while (length)` loop (David Laight)
 - Dropped `min_t` in favor of `min()` to maintain a strict type
   checking safety net (David Laight)

 drivers/dma-buf/dma-buf-mapping.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-buf-mapping.c
index 794acff2546a..50ded9daf5fb 100644
--- a/drivers/dma-buf/dma-buf-mapping.c
+++ b/drivers/dma-buf/dma-buf-mapping.c
@@ -5,16 +5,17 @@
  */
 #include <linux/dma-buf-mapping.h>
 #include <linux/dma-resv.h>
+#include <linux/align.h>
+
+#define MAX_SG_ENT_SZ ALIGN_DOWN(UINT_MAX, PAGE_SIZE)
 
 static struct scatterlist *fill_sg_entry(struct scatterlist *sgl, size_t length,
 					 dma_addr_t addr)
 {
-	unsigned int len, nents;
-	int i;
+	size_t len;
 
-	nents = DIV_ROUND_UP(length, UINT_MAX);
-	for (i = 0; i < nents; i++) {
-		len = min_t(size_t, length, UINT_MAX);
+	while (length) {
+		len = min(length, MAX_SG_ENT_SZ);
 		length -= len;
 		/*
 		 * DMABUF abuses scatterlist to create a scatterlist
@@ -24,8 +25,10 @@ static struct scatterlist *fill_sg_entry(struct scatterlist *sgl, size_t length,
 		 * does not require the CPU list for mapping or unmapping.
 		 */
 		sg_set_page(sgl, NULL, 0, 0);
-		sg_dma_address(sgl) = addr + (dma_addr_t)i * UINT_MAX;
+		sg_dma_address(sgl) = addr;
 		sg_dma_len(sgl) = len;
+		addr += len;
+		/* Unconditionally advance. On last segment, this becomes NULL */
 		sgl = sg_next(sgl);
 	}
 
@@ -41,14 +44,14 @@ static unsigned int calc_sg_nents(struct dma_iova_state *state,
 
 	if (!state || !dma_use_iova(state)) {
 		for (i = 0; i < nr_ranges; i++)
-			nents += DIV_ROUND_UP(phys_vec[i].len, UINT_MAX);
+			nents += DIV_ROUND_UP(phys_vec[i].len, MAX_SG_ENT_SZ);
 	} else {
 		/*
 		 * In IOVA case, there is only one SG entry which spans
 		 * for whole IOVA address space, but we need to make sure
 		 * that it fits sg->length, maybe we need more.
 		 */
-		nents = DIV_ROUND_UP(size, UINT_MAX);
+		nents = DIV_ROUND_UP(size, MAX_SG_ENT_SZ);
 	}
 
 	return nents;
-- 
2.55.0.229.g6434b31f56-goog

