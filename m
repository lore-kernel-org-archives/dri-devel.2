Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B2BCD5BD0
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 20:50:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A74B110E9FF;
	Wed, 27 May 2026 20:50:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="bHLbiJCO";
	dkim-atps=neutral
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com
 [209.85.219.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9D0710E9FF
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 20:50:51 +0000 (UTC)
Received: by mail-qv1-f73.google.com with SMTP id
 6a1803df08f44-8ca1295e3a9so222487646d6.1
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 13:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1779915051; x=1780519851;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=OnsOZAwcaFX6qrXTkZ3llO87kDjoRN0331vlXYrms0w=;
 b=bHLbiJCOvdaVlLzCeQN7qKkefJFCMAeKHrAzcGoBSE6U34Bh3ToqVTejJJNjVPT034
 7ZXm53kNTU1zbyCjmyomRH7/TN0WT4XEJt09HM8C38ZnyME+c2kDKucoOhFn0S9FbSds
 ug7WgUM7OHZBPO65XNyXGY+57KFi50KmDbuV2UUwW7u5iv1fIOUJicxL+uZhS2AXefH7
 xQ1yYGRHZdNV+pfvTCsJkDnq2rF5txoeyf2/lMd3ivSuCX4mEOYk+YplAEx6qid0nVsK
 RjJDw4n+kvj7LksoOu7cdwb5Iz9DxMb58FnJZEckdfmBUf9aT5AvgkzdOfvL0zoNB0zk
 CYLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779915051; x=1780519851;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OnsOZAwcaFX6qrXTkZ3llO87kDjoRN0331vlXYrms0w=;
 b=Tmuv4hkDGSCyCqMvYrCkrikLBxfNGLrhqWbmBVXa7E9phI0dzdrj90BhlCXxDzZIko
 85K+ylV71DX5GyUaUicsBAzCsjG1jNDo+B2w5kfHF6Bm5Lkjxj+H6krKkdeQvUw3FA0m
 iixQ5xYHQ58cx1LC7h6oR3jsnn+wWDJSm5S6ND36j9vC+KNufBO6nRbP/hHKGRwPG/rC
 6PYe4wEpGNzDN67Q8gCkNHPv4UhCEfERcBDl+oTxsf2uBWz/TzM+s4iwFeOXuutxuR/B
 aVPvhGAnNNzrAblg6lVJEMC09n6FyvlBFf9QfK9LX2JrhEjko+/DuXel765rP+faIAys
 m+vA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/x9YL08+z+sBRIZmN4EPDeJprYWsZgX0wOeHoHmOEumvAba5rrXtri9MKK15WAozCY+pJ9NY0HSIc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzlEDhqgT3auYWP8yUm8TO64oMp+JnnxRIww1hfG+L0WY8890nF
 Pnzv/MHZLDdFtDIz3h9MvLA93hE2IfGj/j0cI6+cNy3KmfgqPeBa7bsZ0PGwTl4ChMk5UVG1i+T
 NCXt8qahcL5gX
X-Received: from qviu6.prod.google.com ([2002:a0c:c486:0:b0:8cc:2486:6603])
 (user=xuehaohu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:54ca:b0:8ac:b237:9fb5 with SMTP id
 6a1803df08f44-8cc7b5fe0d8mr387104406d6.49.1779915050519; 
 Wed, 27 May 2026 13:50:50 -0700 (PDT)
Date: Wed, 27 May 2026 20:50:47 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260527205048.2168808-1-xuehaohu@google.com>
Subject: [PATCH v2] dma-buf: Fix silent overflow for phys vec to sgt
From: David Hu <xuehaohu@google.com>
To: Sumit Semwal <sumit.semwal@linaro.org>, 
 "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Alex Williamson <alex@shazbot.org>,
 linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 linux-kernel@vger.kernel.org, jmoroni@google.com, praan@google.com, 
 leonro@nvidia.com, David Hu <xuehaohu@google.com>, stable@vger.kernel.org, 
 iommu@lists.linux.dev
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

to mapped_len, and leading to a silent overflow

Fixes: 3aa31a8bb11e ("dma-buf: provide phys_vec to scatter-gather mapping routine")
Cc: stable@vger.kernel.org
Cc: iommu@lists.linux.dev
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: David Hu <xuehaohu@google.com>
---
Changes in v2:
 Fixed 'IVOA' -> 'IOVA' typo and expanded commit message (Claude Bot).
 Added Reverse Xmas tree formatting (Pranjal).
 Folded in extra bounds checking for calc_sg_nents() (Pranjal).
 Folded in type consistency fix for fill_sg_entry() (Pranjal).
 Droped unnecessary `nents = 0` initialization (Claude Bot).

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

