Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82FF3CD5BD5
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 16:00:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E507610F3C8;
	Thu, 28 May 2026 16:00:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="av48r/vt";
	dkim-atps=neutral
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com
 [209.85.160.202])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B71FA10F3C8
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 16:00:08 +0000 (UTC)
Received: by mail-qt1-f202.google.com with SMTP id
 d75a77b69052e-50edf01172bso183176461cf.2
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 09:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1779984008; x=1780588808;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=MmPFy91yuYd+9nLUOi1wu2JWcf7o4ksos6H5oNntzCU=;
 b=av48r/vttmOxzH/TsgABmRsnckIguxoxSPyob0F7r+Kuefa+d+BzFqt0/bivX1Dfen
 JAx+GgqyyQgRPHPGee+M155gebnZ+pPnjUFJPd2fZSCGE1gx9X/OfqDXLd2PJS90u9gL
 Nl80MKUPhUVZsMcrqS6EKtBL3fdM+U47nFJ/xnSFtXZeNVnsbNbAhwwx9oW1d49wZmHG
 mk7pZzjWFTkQ+frMLzYBEa0RuIgjRETbFTbeR1bb5l/QCgaJsYuPuxs89NebfPVhiRqp
 pbIkOQxwqyX99C/sKfjj5uYPeav/tdR3vjTTSr32Qkuda/kQDVCs9BPO65Wkxru5FW2d
 xrtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779984008; x=1780588808;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MmPFy91yuYd+9nLUOi1wu2JWcf7o4ksos6H5oNntzCU=;
 b=dzNZapNfPGecI73qmDZ6dTxM6cRyEsfh1UI6fR/M3dTb3iQS+w2H12fAn2YmlT8nmL
 cXsaQEuhHQrKzQ9Shzg+fb1sAr8Lel2Cz1MJXZ5zMKkjWaAYxS1xlXHGbDAAumQFH8WG
 F2uSsLQ5bGvoBpF6o9G2WdrctmlSmE5H7xKeMPqfFf+ZIFrC8jwcOZDXtLuKHp6JhlwC
 GtEY6R8W2rEPQac1ayKdDYhdqIkEjIejhLeCY/NxBPv0m1+9fm42lNG6JcXEzKj+jFT8
 lSmt3f7UP0/SUw7eXyZLyPBNyOYQrtKhJarxdtsy3bKNwJ05lUH6je2DXYOeQktkqs9o
 VvBw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9HH63ClKDrGlesmzhar5FEmlnszXWJI4kAhXzgnMLLzKd+DmskzbMeqbxe+7xPsf7QlALaZ1nGtF8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YysixFYWMlSWHm/T2EtvqWRLUsyHjd7ra5evGFyBPz3/XGpfp9L
 Zb7FRli7HDgtQhhFkQIKxPt3CVpII3gRBWV6SxckSD96ma+ah+XvUJ+xeo4j02ImWw6DBtss3ZA
 ZcGX9jisuXSPz
X-Received: from qtxy12.prod.google.com ([2002:a05:622a:120c:b0:516:373e:a942])
 (user=xuehaohu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1488:b0:516:d6a4:fd69 with SMTP id
 d75a77b69052e-516d6a4fe46mr371616761cf.12.1779984005890; 
 Thu, 28 May 2026 09:00:05 -0700 (PDT)
Date: Thu, 28 May 2026 16:00:04 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260528160004.2452461-1-xuehaohu@google.com>
Subject: [PATCH v3] dma-buf: Fix silent overflow for phys vec to sgt
From: David Hu <xuehaohu@google.com>
To: Sumit Semwal <sumit.semwal@linaro.org>, 
 "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, 
 Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 linux-kernel@vger.kernel.org, jmoroni@google.com, praan@google.com, 
 David Hu <xuehaohu@google.com>, stable@vger.kernel.org, iommu@lists.linux.dev
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

In case MMIO size is bigger than 4G and peer2peer DMA goes
through host bridge, we trigger a code path that assigns the
total linked IOVA (which is greater than 4G) to mapped_len.

Previously, `mapped_len` was declared as 32-bit `unsigned int`.
When accumulating `size_t` lengths, this leads to a silent wrap-around.
This truncation causes truncated lengths to be passed to functions
like `fill_sg_entry()`.

Fix this by changing `mapped_len` to `size_t` (64-bit). While
at it, fix similar potential overflow issues in `calc_sg_nents`
by using `size_t` for `nents` and checking against `UINT_MAX`
and using `unsigned int` for the loop iterator in `fill_sg_entry`
to match.

Fixes: 3aa31a8bb11e ("dma-buf: provide phys_vec to scatter-gather mapping routine")
Cc: stable@vger.kernel.org
Cc: iommu@lists.linux.dev
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: David Hu <xuehaohu@google.com>
---
Changes in v3:
 - Removed leftover sentence fragment from the commit message.
 - Kept `nents = 0` initialization (previously stated as removed in the
   v2 changelog) as it is strictly required for the `+=` accumulation
   loop in `calc_sg_nents()`.

Changes in v2:
 - Fixed 'IVOA' -> 'IOVA' typo and expanded commit message (Claude Bot).
 - Added Reverse Xmas tree formatting (Pranjal).
 - Folded in extra bounds checking for calc_sg_nents() (Pranjal).
 - Folded in type consistency fix for fill_sg_entry() (Pranjal).

 drivers/dma-buf/dma-buf-mapping.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-buf-mapping.c
index 794acff2546a..5bc769fc42ea 100644
--- a/drivers/dma-buf/dma-buf-mapping.c
+++ b/drivers/dma-buf/dma-buf-mapping.c
@@ -10,7 +10,7 @@ static struct scatterlist *fill_sg_entry(struct scatterlist *sgl, size_t length,
 					 dma_addr_t addr)
 {
 	unsigned int len, nents;
-	int i;
+	unsigned int i;
 
 	nents = DIV_ROUND_UP(length, UINT_MAX);
 	for (i = 0; i < nents; i++) {
@@ -36,7 +36,7 @@ static unsigned int calc_sg_nents(struct dma_iova_state *state,
 				  struct phys_vec *phys_vec, size_t nr_ranges,
 				  size_t size)
 {
-	unsigned int nents = 0;
+	size_t nents = 0;
 	size_t i;
 
 	if (!state || !dma_use_iova(state)) {
@@ -51,6 +51,9 @@ static unsigned int calc_sg_nents(struct dma_iova_state *state,
 		nents = DIV_ROUND_UP(size, UINT_MAX);
 	}
 
+	if (nents > UINT_MAX)
+		return 0;
+
 	return nents;
 }
 
@@ -95,9 +98,10 @@ struct sg_table *dma_buf_phys_vec_to_sgt(struct dma_buf_attachment *attach,
 					 size_t nr_ranges, size_t size,
 					 enum dma_data_direction dir)
 {
-	unsigned int nents, mapped_len = 0;
 	struct dma_buf_dma *dma;
 	struct scatterlist *sgl;
+	size_t mapped_len = 0;
+	unsigned int nents;
 	dma_addr_t addr;
 	size_t i;
 	int ret;
-- 
2.54.0.794.g4f17f83d09-goog

