Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF74C624A4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:33:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CE4610F2C5;
	Thu,  3 Sep 2026 07:33:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=x6u.co header.i=@x6u.co header.b="PL0Mq0MX";
	dkim-atps=neutral
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com
 [209.85.128.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5939310EDF1
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 17:09:22 +0000 (UTC)
Received: by mail-yw1-f171.google.com with SMTP id
 00721157ae682-85a50f6a7f7so2762697b3.2
 for <dri-devel@lists.freedesktop.org>; Tue, 01 Sep 2026 10:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=x6u.co; s=google; t=1788282561; x=1788887361; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+HsJ7WWSDXGGxM5KQ2N5tTmcNL3Nov2eFWn2UfdJVq4=;
 b=PL0Mq0MXlb2phBaB/IqqxuuPeHhbgujUxSlMfTkrndAeeV6plmJ+yWKJB4bpJ5P1Qo
 ttBUKEs2yIuf2HqLAbE1Cs47XMK3UDJDEI//3nsfVj8EP0bdAy8ZgIVrLO+MSIiyPyB9
 PnEuu9+EIKzqhGVLKEo0uf2iyl0OUBfgRg5+U1BzTu3oBxRacd/ejRVdmvKsERclJ5oo
 dxAqkyGhq4MlukMAhyLbLOrSOFz3xVy9mTZFzMEzxeu06bCgwfmZP4ys1CJk6bmDE9em
 MW9x/C07KAsQNG4Hq1R5OqZ11lUE6zda5uzGJwird8sBzHbozt7SfBkUVnWHwe6119CB
 UPHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788282561; x=1788887361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+HsJ7WWSDXGGxM5KQ2N5tTmcNL3Nov2eFWn2UfdJVq4=;
 b=Rk/OzNNO8DcR3ArOEEFA+nXI2Q57CnTtb79Rs9eQ1pZx0yU9PKJNPiw4EqMzj0su+D
 thu6YrUrxS+/FjmhwnaNA3TbCP0DRalm/66NDo4udVI76A1jV/USv8GC/UZoxWiKFlyV
 gM7tWMspgvKfRATBapmEv/rNI8csLl4yuKbLymOzojDCiFXgN7DbP+TWUfTVeJnrBdqO
 BrY3Px3FOL9uHAjyh8IndFaxqV7MIrlfTHoltO83AeH3tBl8G9EzN0Y7DCRjKvEn6V6C
 PdlqF5sGi9kFitbpRF4X6/554Omiy3lOBOE6HjNalFLuPVKI3A1qi7VpJ3C0RHitrvNx
 WA/g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwT4kQQHlcRYGO/MidfCeZoMfRF5GIKYlgJldd245EheQopiV9gWTlWoiQXpFD9QwZ81SCE8T5FC8Y=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mT/NpCzB3z9THz1XblPbRfjwOjNoXySNArwLKbD7ufIsQXuiZN
 kF52xgvtYarO4AUj788hAWWuUe6LTWLxiSCJzo8TSa4HWf6hOdgC+Mj+1xRZJ+nXRMSv
X-Gm-Gg: AYBFou0u5GsPoKBeP0btEZCdmuUJ1RNiyxUZtHwLU4UcXVuAOCC82atU3KFv9/n1WmM
 T8tVz0fKx2Sso8sBpkJxcUzVt+w3oUo81olr7A2iGLerGFj8MhzVFJNCJ5+11pZVSASVYrbO+v+
 vxjexYczOckobQNX+3X1KjjuZ9qZJVMUI/CjzjtTA4mAWvJE4/l1xX5ACz4bxs1dQlQw/CiiGnP
 3BuqxgV1iOlXyglLsrD31Lbrqbcy4fbvY6cZM+sfBgbVevKPhjXLDyjHZO7B84GWFiaTQOIZx68
 YfcfHIhE6uiNKHkYcXtI2w4TgOkqEsBfRnr5fOChTti0RDygmeRTc/4qgRy9igfuqPRJnmbBB/H
 ws+/u58bjRoQQx+KysZHaci+gTua+PZc3WdUNR6UG+r0ts1fSnuh41M+gxXuks+hpXZiFXgTE16
 VdI2hPFdf4jiZ8nZ8ZqAaY8lOBbfKsDPcn/p15Q004YQsnhqO1W0Tmd6EB75LfrIdIZP1pf0NTR
 HYFv3dBpSz17asfVSpiIvEOAJ7w1a976rCxIFpbqf84pzxICToGs5FkYV0edjiPBUgyQxnbBvGA
 0x8=
X-Received: by 2002:a05:690c:6603:b0:81f:e85b:f9f4 with SMTP id
 00721157ae682-85d6b8472ebmr126795317b3.27.1788282561098; 
 Tue, 01 Sep 2026 10:09:21 -0700 (PDT)
Received: from worldpeace10.c.googlers.com.com
 (109.243.150.34.bc.googleusercontent.com. [34.150.243.109])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-85e65f146edsm79761867b3.32.2026.09.01.10.09.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 10:09:20 -0700 (PDT)
From: David Hu <dhu@x6u.co>
To: sumit.semwal@linaro.org,
	christian.koenig@amd.com
Cc: alex@shazbot.org, ankita@nvidia.com, chriscli@google.com,
 david.laight.linux@gmail.com, dri-devel@lists.freedesktop.org,
 iommu@lists.linux.dev, jgg@ziepe.ca, jmoroni@google.com,
 kevin.tian@intel.com, kpberry@google.com, leon@kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, nicolinc@nvidia.com, praan@google.com,
 sashiko-bot@kernel.org, stable@vger.kernel.org, viursachi@google.com,
 xuehaohu@google.com, Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH v8 2/2] dma-buf: Split sgl by largest page-aligned chunk
Date: Tue,  1 Sep 2026 17:08:49 +0000
Message-ID: <20260901170849.4052816-3-dhu@x6u.co>
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
In-Reply-To: <20260901170849.4052816-1-dhu@x6u.co>
References: <20260901170849.4052816-1-dhu@x6u.co>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 03 Sep 2026 07:33:13 +0000
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
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
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
index 80f6ab2f4809..833be519e1e6 100644
--- a/drivers/dma-buf/dma-buf-mapping.c
+++ b/drivers/dma-buf/dma-buf-mapping.c
@@ -6,16 +6,17 @@
 #include <linux/dma-buf-mapping.h>
 #include <linux/dma-resv.h>
 #include <linux/overflow.h>
+#include <linux/align.h>
+
+#define MAX_SG_ENT_SZ ALIGN_DOWN(UINT_MAX, PAGE_SIZE)
 
 static struct scatterlist *fill_sg_entry(struct scatterlist *sgl, size_t length,
 					 dma_addr_t addr)
 {
-	unsigned int len, nents;
-	unsigned int i;
+	size_t len;
 
-	nents = DIV_ROUND_UP(length, UINT_MAX);
-	for (i = 0; i < nents; i++) {
-		len = min_t(size_t, length, UINT_MAX);
+	while (length) {
+		len = min(length, MAX_SG_ENT_SZ);
 		length -= len;
 		/*
 		 * DMABUF abuses scatterlist to create a scatterlist
@@ -25,8 +26,10 @@ static struct scatterlist *fill_sg_entry(struct scatterlist *sgl, size_t length,
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
 
@@ -42,7 +45,7 @@ static unsigned int calc_sg_nents(struct dma_iova_state *state,
 
 	if (!state || !dma_use_iova(state)) {
 		for (i = 0; i < nr_ranges; i++) {
-			unsigned int added = DIV_ROUND_UP(phys_vec[i].len, UINT_MAX);
+			unsigned int added = DIV_ROUND_UP(phys_vec[i].len, MAX_SG_ENT_SZ);
 
 			if (check_add_overflow(nents, added, &nents))
 				return 0;
@@ -53,7 +56,7 @@ static unsigned int calc_sg_nents(struct dma_iova_state *state,
 		 * for whole IOVA address space, but we need to make sure
 		 * that it fits sg->length, maybe we need more.
 		 */
-		nents = DIV_ROUND_UP(size, UINT_MAX);
+		nents = DIV_ROUND_UP(size, MAX_SG_ENT_SZ);
 	}
 
 	return nents;
-- 
2.55.0.897.gb25b4bd76c-goog

