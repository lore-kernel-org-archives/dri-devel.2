Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9DC9C44524
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 07:08:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B3B810EFDE;
	Thu, 23 Jul 2026 07:07:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=x6u.co header.i=@x6u.co header.b="G8s8JGGy";
	dkim-atps=neutral
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com
 [74.125.224.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4409B10E30F
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 23:38:29 +0000 (UTC)
Received: by mail-yx1-f51.google.com with SMTP id
 956f58d0204a3-664ce3000e6so15168d50.0
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 16:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=x6u.co; s=google; t=1784763508; x=1785368308; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=czUeoqytFwl2f4wSjedp4ua+inBVMuooqHyWYibjU+0=;
 b=G8s8JGGyXvapHDPCbnThgapK3YH7KFoTWnvlqvrNokyaiuLgQDXQf90ciyaONdWEBU
 c1SNz0lDUP7y2Y0qFdYJjMxFY1B1KAWNO9LujJeiKlvgl/gGkNRAmTaf6vU+Qza0hbvz
 PQFx6d6wlYnPchlGYmqe4YQzAOwvhREQ3CcY8UZOY8OiMXBeF12SSngLNAPRt5eCU8K9
 xDnOba/COEbwG0QZPH+vQwbzZlxmA/tqmuTGTIivUqAXaHcT/uTE8cCIhU3f3PIRCXBe
 QD+FDWtVgRmpiYf5u0N05y95aCG9KuKtZNZv05egyk9ka4CsaeeC9muCp/M1dyofJacv
 egwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784763508; x=1785368308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=czUeoqytFwl2f4wSjedp4ua+inBVMuooqHyWYibjU+0=;
 b=qB5Ie6N5zXAInnEvVQ47j5EBgphG72B8W4gW8qv+927CM3Fvog6qyn2bIzCvfXqqpZ
 E+bxoXL880dlLF6unRIoS5OmnbuLiEQoy0CXlHFrTs7UKkprEqbGeZuzoyiPNs6b+X7B
 YVrnXbuqmjJLpuZdmgtcjO0qbGs4aYGDNCTV54oNyuiBkpGtD+Esu3SZL3hFqqQ3VpEu
 i6ZxXAERanMDr9hYM/gDqAeiMhGWZbtbUjMrgsU+D7jdS6U/437RmtVH0M2m9QDEBNDw
 tUaUbpBMwwWbs3tWOk98I4rsO0sQXnQ5ZheS7O8Hiqs2mI29Ws7L/5XppyN0ZGSnYT3W
 bW+g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr7Q2riz4bE9DGgWs7xogsvMR6f8DJhk0lO0XY1AsCjMwNPVKMsNW893XllM9QrFRAauHApkuMCNrs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyBrQYSSf7XOYK3r/MddnPSWZS9QeSBaS0dNlaL+Ol73x2DlhlA
 LDKajkzkHvcdOoxURIsDR79Z7ONYGUlAB+Y30VQSb5FdeIwfuhCWN0118ubBGmtXxcAI
X-Gm-Gg: AR+sD12LB/CA7ZpHIXI/u53ShK6HFJEO2UKShrjc6Vl6ehdOK9+SW7moswsPikZMubT
 ZitXs1RXuixdX/5j+a/N28g4iF3VDmpZYIzJ+kAQw42JKXFgQ6Ze7+stlffdeFttBqqh1mlXmXV
 ouBL+td/9QFAobHHlkJLYrJCYTZyiysSYzONzTSgQ+XV9g7ZouIRmHIdUEDBGsEj6F+uEjyMWOS
 FE25pMHNHbfo4iwemqcVn47t7RcAzmf/OxO86YNchFaTXhJbPOauQlYpA2kxVG7I+OF/fxhjMMJ
 wU7MvGfttv630u3YwyhPR2PAZEDieMytXvbxR49idV3Jo6EL0O14GagStUA1Dl1yAPFBy+01hMi
 1NGjCTc+gc4lcgCdiHFPxt7tKDD/xL3X/apb0m/v5VUfDnM+H2JfVnoUk2O5HlkJYUN2Grp5+Ec
 h3reC23QCUzJr4rvWA8Tih1d7WZ0RCIHNvcrV3FS+8afMqi9u3tdOO36vd
X-Received: by 2002:a53:ce84:0:b0:667:af05:2e8d with SMTP id
 956f58d0204a3-668a4fbd261mr142804d50.79.1784763507854; 
 Wed, 22 Jul 2026 16:38:27 -0700 (PDT)
Received: from worldpeace10.c.googlers.com.com
 (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66890521188sm2193219d50.1.2026.07.22.16.38.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 16:38:27 -0700 (PDT)
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
Date: Wed, 22 Jul 2026 23:38:06 +0000
Message-ID: <20260722233806.3922093-1-dhu@x6u.co>
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

