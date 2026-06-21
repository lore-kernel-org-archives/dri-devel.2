Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D84C9CD98F0
	for <dri-devel@archiver.kernel.org>; Sun, 21 Jun 2026 22:21:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9220110E3DB;
	Sun, 21 Jun 2026 22:21:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="PmTE0NLq";
	dkim-atps=neutral
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com
 [209.85.219.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0B4210E3DB
 for <dri-devel@lists.freedesktop.org>; Sun, 21 Jun 2026 22:21:33 +0000 (UTC)
Received: by mail-qv1-f73.google.com with SMTP id
 6a1803df08f44-8dd4e82d2c7so31226146d6.0
 for <dri-devel@lists.freedesktop.org>; Sun, 21 Jun 2026 15:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1782080493; x=1782685293;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=E/rPiB1Qh/2nTPaKmpZPHKT5hQGs3BX51WUl0ayz+VA=;
 b=PmTE0NLqzG8eLXn+jGiHgDKuE4bVxb4Mz5GhtGlFSSNSdYFzwx5P2NFjbv/PYx5PoA
 lJPpGFj5hsofHMtGoNpS2ok7EmYq7ol4lGWpwLs5qlLVPdr/5Ah4j9GKkg5OHfQnisva
 xFw0y/fAuEdGQmuQYxhUbM3jMteZ1FPzJTTVb4/9J8jSgd1qzYWO8SLTjsTlW0Pkf9pw
 oZiTZFRJBxpTe7IJ2ofRkFg1GpPVT7qZV98uT3kA4wXrnCxzjQu878EojCtqm9+qKYIJ
 ZP9KdW3fPpVbl6AJ0D/mDbL4xg+x6G4T4cCmYq2AwuQZd320eC0iNvjvRUZXn0ZG2HHF
 Sc+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782080493; x=1782685293;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E/rPiB1Qh/2nTPaKmpZPHKT5hQGs3BX51WUl0ayz+VA=;
 b=XBoIc2KGIj7FG+tRVvTruDHe0jgH66xmBP/r+tWzYCGPt1oah7/8oouEoauIfjnDrk
 /oK4gU67OxOsu3I3Tl1KLLWkCiXkW+kHKssPFWOlOAqr6vH6Nvb6ghP4pSIg3hO43WtS
 6Rl/ThgwdySKydQz2bkQkU9kPnHyvdwyUNXNgiSg5MbPTfz15af8Cs95rgfd/CtbX4N8
 6v3Tem4H4vzdDrnXUiCbCKP14I2Mgp1BJxBb5od+qRGcHKP5Zkb+SHvtQ6wxaqHncCXq
 GpzEXqlqDoRBjzKg08DvotlQ1Y+ME0LBlq8sEfte2IIBCJE9kyGOHiCvL+5BVHU3K1N3
 uIZQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoqJBC9v/KY+X6FhckeVcMJYbK4+nIu8gfscDNMAbfU6j6W1TSEkjMHnWn/mSVfiBWRto78HB1rXZY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzQM9Pm2UhidWM9alX0RhK0WG1o3rFXg/bJeYjy1EvZyinsYDCJ
 ENrd0OYJ06HbbuQ4gIEc9au7yLVHreXJqaNGPpy4HkKz0gloF9DDXIThYJ5+yRfFwNPGTEJSi7W
 Bdtb62GTl6r+3
X-Received: from qvbld29.prod.google.com
 ([2002:a05:6214:419d:b0:8db:f5ff:e5e9])
 (user=xuehaohu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:3f82:b0:8cc:6aa6:7035 with SMTP id
 6a1803df08f44-8de4c97e03amr175835356d6.19.1782080492419; 
 Sun, 21 Jun 2026 15:21:32 -0700 (PDT)
Date: Sun, 21 Jun 2026 22:21:30 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.738.g0c8ab3ebcc-goog
Message-ID: <20260621222130.1667453-1-xuehaohu@google.com>
Subject: [PATCH] dma-buf: Split sgl by largest page-aligned chunk
From: David Hu <xuehaohu@google.com>
To: Sumit Semwal <sumit.semwal@linaro.org>, 
 "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, 
 Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>, 
 Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, jmoroni@google.com, 
 praan@google.com, kpberry@google.com, David Hu <xuehaohu@google.com>, 
 sashiko-bot <sashiko-bot@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

Fix this by splitting the scatterlist by the largest possible page
aligned chunk within `UINT_MAX` (`ALIGN_DOWN(UINT_MAX, PAGE_SIZE)`).
This ensures all scatterlist DMA addresses and lengths remain page
aligned and satisfy hardware constraints.

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
 drivers/dma-buf/dma-buf-mapping.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-buf-mapping.c
index 794acff2546a..f2bde38fdb1f 100644
--- a/drivers/dma-buf/dma-buf-mapping.c
+++ b/drivers/dma-buf/dma-buf-mapping.c
@@ -5,6 +5,9 @@
  */
 #include <linux/dma-buf-mapping.h>
 #include <linux/dma-resv.h>
+#include <linux/align.h>
+
+#define MAX_ENT_SZ ALIGN_DOWN(UINT_MAX, PAGE_SIZE)
 
 static struct scatterlist *fill_sg_entry(struct scatterlist *sgl, size_t length,
 					 dma_addr_t addr)
@@ -12,9 +15,9 @@ static struct scatterlist *fill_sg_entry(struct scatterlist *sgl, size_t length,
 	unsigned int len, nents;
 	int i;
 
-	nents = DIV_ROUND_UP(length, UINT_MAX);
+	nents = DIV_ROUND_UP(length, MAX_ENT_SZ);
 	for (i = 0; i < nents; i++) {
-		len = min_t(size_t, length, UINT_MAX);
+		len = min_t(size_t, length, MAX_ENT_SZ);
 		length -= len;
 		/*
 		 * DMABUF abuses scatterlist to create a scatterlist
@@ -24,7 +27,7 @@ static struct scatterlist *fill_sg_entry(struct scatterlist *sgl, size_t length,
 		 * does not require the CPU list for mapping or unmapping.
 		 */
 		sg_set_page(sgl, NULL, 0, 0);
-		sg_dma_address(sgl) = addr + (dma_addr_t)i * UINT_MAX;
+		sg_dma_address(sgl) = addr + (dma_addr_t)i * MAX_ENT_SZ;
 		sg_dma_len(sgl) = len;
 		sgl = sg_next(sgl);
 	}
@@ -41,14 +44,14 @@ static unsigned int calc_sg_nents(struct dma_iova_state *state,
 
 	if (!state || !dma_use_iova(state)) {
 		for (i = 0; i < nr_ranges; i++)
-			nents += DIV_ROUND_UP(phys_vec[i].len, UINT_MAX);
+			nents += DIV_ROUND_UP(phys_vec[i].len, MAX_ENT_SZ);
 	} else {
 		/*
 		 * In IOVA case, there is only one SG entry which spans
 		 * for whole IOVA address space, but we need to make sure
 		 * that it fits sg->length, maybe we need more.
 		 */
-		nents = DIV_ROUND_UP(size, UINT_MAX);
+		nents = DIV_ROUND_UP(size, MAX_ENT_SZ);
 	}
 
 	return nents;
-- 
2.55.0.rc0.738.g0c8ab3ebcc-goog

