Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7844FCD4F54
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 19:17:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB1AA10F5B6;
	Thu, 28 May 2026 19:17:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="NaGOHjYm";
	dkim-atps=neutral
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com
 [209.85.160.201])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 600BF10F5B6
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 19:17:02 +0000 (UTC)
Received: by mail-qt1-f201.google.com with SMTP id
 d75a77b69052e-516d51ffb59so61990431cf.3
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 12:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1779995821; x=1780600621;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ruTGaXcXn18lBWCvQSOsc+J+nN/WfLLq3tF9jPQMx3w=;
 b=NaGOHjYm+w+ttN5Wt8rdGK9jeHWWGMarDQ7rIpznx1yPyN1skeUQRdb34zpA3hzPzT
 wj4Gt3OZTrbOsYsomGaql0enFidPzgayYeQ35PZoHWcvWtRuUortF2Rxr95mM1UgBdsT
 2FcZn26OLsSycIprt+7Z8aQbTZu+JQjF9wfXat3C2Cy1A8EgVDu1uGBrl5o+9G4e34sX
 wT+jtnGPpGIYU5Z3C9hy+kPeRtTmfeouy5nsDW84TXUnP9PGiMaxfzMTFr8ue9DPBjbk
 Mp//B2p+E/GO62BtaOjY7AabIZloGgOkAnacKvSg7Z4OuXdkGx/uWDy5dtNCzn9/SM1T
 WYig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779995821; x=1780600621;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ruTGaXcXn18lBWCvQSOsc+J+nN/WfLLq3tF9jPQMx3w=;
 b=Xjmr5q/gE7a3ssNrxnvYlBycuTj5U+swzyGMrXjNd6vKCaX2cI8iV3/MIA0uUDUwPb
 Ptmlsgi7844IU6gtHTSR6vOf4Y8BVxQEDaJyn/cf3SEch1qk+p9CfOmXIV10DtVpDn9u
 EaL70rFJbXd6I40WFdzlivyAROXYeIGHkRwy5k36RaTCX7WAp05PGAQTrKMOGfZ88d/u
 KL8clXvVgc2YUlBYVyXxe6ACr+YQxPTWta1It8c+PP3GwMoyCxKbATAjzaIMQ5JjTX8q
 vqiOlW5QbwruscTvgvgwKjECdVBt6YcFOExbki3fXVDRrPl2Sf9Wh6jjXX+TMFRNk0VV
 MRYw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8kyQGenn2hnU3TeTFnzh3WHaeDHrUyCtoTb/anotBuz3hMH2sKJJ3Qc0RGe+8z+TU2ilDx9bSKr3g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx2xDu1yp8/B8sU4xVCh+GutYOG6G9BOQYWhqXaggEuffgDBFWN
 Mlt+jnY6BSTg9tDfIFKeqq3Gk5PQEL9BSmIgJ/4deOMYfreuNCHed93pDcf4cevDmMai1GLw6Lr
 SNGahyjZAjGfx
X-Received: from qtlo20.prod.google.com ([2002:ac8:4294:0:b0:50f:d8f5:705f])
 (user=xuehaohu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:4c8c:b0:516:e8aa:271 with SMTP id
 d75a77b69052e-5172cb95a12mr2327291cf.26.1779995821046; 
 Thu, 28 May 2026 12:17:01 -0700 (PDT)
Date: Thu, 28 May 2026 19:16:58 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260528191658.2506362-1-xuehaohu@google.com>
Subject: [PATCH v4] dma-buf: Fix silent overflow for phys vec to sgt
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
Changes in v4:
 - Added WARN_ON_ONCE() to the nents overflow check to prevent silent
   failures (Claude Bot).

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
index 794acff2546a..1aabc0ee70bb 100644
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
 
+	if (WARN_ON_ONCE(nents > UINT_MAX))
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
2.54.0.929.g9b7fa37559-goog

