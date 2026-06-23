Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA49CDB46B
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 01:55:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D23D10E5D3;
	Tue, 23 Jun 2026 01:55:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="LAjws0wA";
	dkim-atps=neutral
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com
 [209.85.160.201])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4615710E5D3
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 01:55:03 +0000 (UTC)
Received: by mail-qt1-f201.google.com with SMTP id
 d75a77b69052e-51a05146054so44255311cf.3
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 18:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1782179702; x=1782784502;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=lkITz2dGNs54nij5ccY4KCvNRYJG4BpFQmrxgUXzmOc=;
 b=LAjws0wA2s9xDd+VYR7YkrwodB8QAk42iCFHmkUgl+nZH39d77p94PJ2bO6csGTEou
 /hd+T8q7vkl2rPSnGh5jCY2RHpWItfw6GUJeYCWPcknWWbvfhIoCL4FIfmWnR39TzZT4
 V0BQ3DSE1ZCyL/FBPDWVgJEiXCVygPd61JjAtecU2J43ztWUF87ys0MeKs5FnZ0+5Kgz
 mZBD+RZtTBJLKuIkYwFnQESsESpjsCSHMoSU8Hpe0CLtgyLGBA39P4/BB5ZhbXZL8Hjw
 V8TBWPtKHZMWc/XMWIys7F9S3TtTEj8R/z3wpY5UZtgbjhEnzsagi1340vMAgIkZZVvd
 8PlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782179702; x=1782784502;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lkITz2dGNs54nij5ccY4KCvNRYJG4BpFQmrxgUXzmOc=;
 b=QhGghudDf65I8gQ2Q4umx9Gu8CPU/cOiuKsgc1Q5yMSPP3Hx+ZQjabOijCkOT9cKYu
 NIocPfUvTj5kOoB4cCLEzYvWDVjUA4gthvRYbKCN+khu0STd2S4LLBQflbTEjLLBKPwr
 bOrqYSH58lI3X3jGNmGxsG1gfHsxTzx8wf10suENfR5HgR7rly00R/8RygfSnJZ5e1W+
 57gwk59HKgfls5Ijnq4BDo6Q6PrUDJ4ERaJJtVMA0mqzYTktaWQ55OriU9h2m3pHouiJ
 fVZV0gd6ODbWQdey313LDzwicrveq1x4e8GZKhxn745YzHd2+ciQyO3qVRzqrJlmGnri
 BQjA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/CcbXCyqPGAYB9Cq2UtX810sjKQQtH197qW4kgtKvsQ7FKOzOo1I8/yGEFFIes52+y5BRBy6E6hSA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyMAVMvFF1KjIy44+sCk9j9baxgN/7hrkqeHdTHEwDkGZu1D7/8
 IQvczPByvRXRvRTGbXGf3kuB+uXeN+cnAo5LQTNKFae1xCaFSqUpDS0PesgGMrzqmVI5EHpYjO+
 9B/FRpENNEW5n
X-Received: from qtxx9-n2.prod.google.com
 ([2002:a05:622a:aac9:20b0:517:96a4:99ea])
 (user=xuehaohu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:2609:b0:519:89f6:6ed4 with SMTP id
 d75a77b69052e-51a548b6418mr13414611cf.47.1782179701475; 
 Mon, 22 Jun 2026 18:55:01 -0700 (PDT)
Date: Tue, 23 Jun 2026 01:54:59 +0000
In-Reply-To: <20260621222130.1667453-1-xuehaohu@google.com>
Mime-Version: 1.0
References: <20260621222130.1667453-1-xuehaohu@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260623015459.1153884-1-xuehaohu@google.com>
Subject: [PATCH v2] dma-buf: Split sgl into page-aligned 2G chunks
From: David Hu <xuehaohu@google.com>
To: Sumit Semwal <sumit.semwal@linaro.org>, 
 "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>
Cc: David Laight <david.laight.linux@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Nicolin Chen <nicolinc@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Kevin Tian <kevin.tian@intel.com>, 
 Ankit Agrawal <ankita@nvidia.com>, Alex Williamson <alex@shazbot.org>,
 linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, jmoroni@google.com, 
 praan@google.com, kpberry@google.com, chriscli@google.com, 
 sashiko-bot@kernel.org, stable@vger.kernel.org, 
 David Hu <xuehaohu@google.com>
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

Fix this by splitting the scatterlist into 2G chunks. An alternative
previously considered was to use the largest page aligned chunk within
`UINT_MAX` (`ALIGN_DOWN(UINT_MAX, PAGE_SIZE)`) to satisfy page
alignment. A 2G chunk is better as it naturally aligns with most known
hardware boundaries, while also allowing compiler optimizations with
simple bit shifts. This ensures all scatterlist DMA addresses and
lengths remain page aligned and satisfy hardware constraints.

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

 drivers/dma-buf/dma-buf-mapping.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-buf-mapping.c
index 794acff2546a..2d88e08c5ebf 100644
--- a/drivers/dma-buf/dma-buf-mapping.c
+++ b/drivers/dma-buf/dma-buf-mapping.c
@@ -5,16 +5,17 @@
  */
 #include <linux/dma-buf-mapping.h>
 #include <linux/dma-resv.h>
+#include <linux/sizes.h>
+
+#define MAX_SG_ENT_SZ ((size_t)SZ_2G)
 
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
@@ -24,11 +25,12 @@ static struct scatterlist *fill_sg_entry(struct scatterlist *sgl, size_t length,
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
-
 	return sgl;
 }
 
@@ -41,14 +43,14 @@ static unsigned int calc_sg_nents(struct dma_iova_state *state,
 
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
2.55.0.rc0.799.gd6f94ed593-goog

