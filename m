Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33532CD8CA4
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 19:43:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FB5510F930;
	Mon,  8 Jun 2026 19:43:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="QZhbJ2Rb";
	dkim-atps=neutral
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com
 [209.85.160.202])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D3EC10F930
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 19:43:25 +0000 (UTC)
Received: by mail-qt1-f202.google.com with SMTP id
 d75a77b69052e-5176cc5bf2aso63920681cf.1
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 12:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1780947804; x=1781552604;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=v1WPgK4XhrSsWKxtc0VlcZjNH1lHogrTgrVmSMDXRnU=;
 b=QZhbJ2RbCcL0WFeqSNrsEGSseakyTOUP8Nw3NtLJewqrSiyA/HitI2hQO+rPHI2glj
 noYs2/uucDeUT1JA0VTxfAWvmU89q84vxrnRmiL7Zrj1cMIt7rn5OBzSDCgaFIl+HPmz
 N1vG6rK6z4vPrLwLO48jYIy17QtOJ3lKJlJDkOxd0t4ohtDPSHuQu30mN9r6Aw48+tmy
 aIp5BHsavTCbOtdjvlq/wo+0qMNLkv0fs36Dk14I9btHfbYRrPpmGgBLmyrMroamCebF
 tqq9Wxk0vabnbtBHb/iiGpW9boXsZ+u3LhZ6zULyi9n1w7/SiG/mlIpYy9T1+o+S2dIv
 lqig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780947804; x=1781552604;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v1WPgK4XhrSsWKxtc0VlcZjNH1lHogrTgrVmSMDXRnU=;
 b=HCIvb1I1eKOhHf0EwjlKyjLDRQmFcTbNDHdl9CrK3IzvInuYI07Zw5EqsUhHWyEkI0
 w0U9tzVHpWPkfR5bE43kOM71JmBuAM18zaL1aHYSUCOhGiHLttDA4O+OFrxN7imh9qOU
 YY9QCZhcYntK4SVPEtVPpTpwYv1De9qOJbynEgw5by0K1aIu70EXuCAnE6eqEXthYpmW
 S/c6Ef/k+sn4D0cAGl26CTjP2S15IlHVvGZUJDyAMmK4LWVmw2lt599cAakTxTHKB0E3
 ceIjuvcibhlOpKxJlCtNTR1O1jFptVIjbZ1Zu+IQ++7WsQxKnhX65g5EgB6mT8pw44Yq
 9jpw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Tk5U2uOvrSufp792RVoj7Fk6SImFTGsh2gmrRUwmfcp8LGHtNl1X4W73x3iVvgZrTfuO4qMQOqHg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzjDk+/iV70Q1LBXbMRL96rOGYdhcU6cyz3JdwLKZsvae6ruY2F
 sAPwuVGs2DAjHtPiOFPV+mctEh3XIN3TPWk4iYFI9REj4MHkeyzFulat2HHi+nbaLIZgZNYueQK
 mAcMCKUy0tgcW
X-Received: from qtss4-n2.prod.google.com
 ([2002:a05:622a:a9c4:20b0:517:85d0:ad3a])
 (user=xuehaohu job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5cd1:0:b0:516:df62:bde3 with SMTP id
 d75a77b69052e-51795c47f23mr242075611cf.54.1780947803937; 
 Mon, 08 Jun 2026 12:43:23 -0700 (PDT)
Date: Mon,  8 Jun 2026 19:43:21 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1064.gd145956f57-goog
Message-ID: <20260608194321.150838-1-xuehaohu@google.com>
Subject: [PATCH v6] dma-buf: Fix silent overflow for phys vec to sgt
From: David Hu <xuehaohu@google.com>
To: Sumit Semwal <sumit.semwal@linaro.org>, 
 "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, 
 Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>, 
 Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, jmoroni@google.com, 
 praan@google.com, David Hu <xuehaohu@google.com>, stable@vger.kernel.org
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
by using `check_add_overflow()` for `nents` and using
`unsigned int` for the loop iterator in `fill_sg_entry` to match.

Fixes: 3aa31a8bb11e ("dma-buf: provide phys_vec to scatter-gather mapping routine")
Cc: stable@vger.kernel.org
Cc: iommu@lists.linux.dev
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: David Hu <xuehaohu@google.com>
---
Changes in v6:
 - Used `check_add_overflow()` in `calc_sg_nents()` for safer
   accumulation (Leon).
 - Dropped explicit `!nents` check and added a comment noting that
   `sg_alloc_table` handles `nents == 0` (Leon).
 - Collected Reviewed-by from Kevin Tian.

Changes in v5:
 - Removed WARN_ON_ONCE from calc_sg_nents() to avoid log noise (Jason).
 - Added explicit check for `!nents` in dma_buf_phys_vec_to_sgt() to
   cleanly return -EINVAL on overflow (Jason).

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
 - Collected Reviewed-by from Pranjal Shrivastava.

 drivers/dma-buf/dma-buf-mapping.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-buf-mapping.c
index 794acff2546a..67a8ff52fb8f 100644
--- a/drivers/dma-buf/dma-buf-mapping.c
+++ b/drivers/dma-buf/dma-buf-mapping.c
@@ -5,12 +5,13 @@
  */
 #include <linux/dma-buf-mapping.h>
 #include <linux/dma-resv.h>
+#include <linux/overflow.h>
 
 static struct scatterlist *fill_sg_entry(struct scatterlist *sgl, size_t length,
 					 dma_addr_t addr)
 {
 	unsigned int len, nents;
-	int i;
+	unsigned int i;
 
 	nents = DIV_ROUND_UP(length, UINT_MAX);
 	for (i = 0; i < nents; i++) {
@@ -40,8 +41,11 @@ static unsigned int calc_sg_nents(struct dma_iova_state *state,
 	size_t i;
 
 	if (!state || !dma_use_iova(state)) {
-		for (i = 0; i < nr_ranges; i++)
-			nents += DIV_ROUND_UP(phys_vec[i].len, UINT_MAX);
+		for (i = 0; i < nr_ranges; i++) {
+			unsigned int added = DIV_ROUND_UP(phys_vec[i].len, UINT_MAX);
+			if (check_add_overflow(nents, added, &nents))
+				return 0;
+		}
 	} else {
 		/*
 		 * In IOVA case, there is only one SG entry which spans
@@ -95,9 +99,10 @@ struct sg_table *dma_buf_phys_vec_to_sgt(struct dma_buf_attachment *attach,
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
@@ -133,6 +138,8 @@ struct sg_table *dma_buf_phys_vec_to_sgt(struct dma_buf_attachment *attach,
 	}
 
 	nents = calc_sg_nents(dma->state, phys_vec, nr_ranges, size);
+
+	/* sg_alloc_table will cleanly fail and return -EINVAL if nents == 0 */
 	ret = sg_alloc_table(&dma->sgt, nents, GFP_KERNEL | __GFP_ZERO);
 	if (ret)
 		goto err_free_state;
-- 
2.54.0.1064.gd145956f57-goog

