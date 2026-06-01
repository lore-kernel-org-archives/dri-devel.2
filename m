Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A5CCD6E55
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 20:00:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 341E410E906;
	Mon,  1 Jun 2026 20:00:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="JIKmLqKd";
	dkim-atps=neutral
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com
 [209.85.222.202])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1685810E906
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 20:00:17 +0000 (UTC)
Received: by mail-qk1-f202.google.com with SMTP id
 af79cd13be357-91550eceb13so354923085a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 13:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1780344016; x=1780948816;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=msbNDh9TiShw7R12hj6rcfm+XGYU44qZJxoBlWEONAk=;
 b=JIKmLqKdq7OVMw1Gnvl0VnnN7U2M5si4VQ2KsB2cfg2+6cgU5+TLbNkSY0mZwYfrqv
 iKdyzlzlyTUpfgudTb4AORglDnt6opvNWFn4xw0CROHySjOG2Ut6/FFtMT4xUczCw5IY
 5Dq+gOAt5DczH5pkpo1NI9gHYGy1B8ZyY0prHYGZ3u5LbGzbujnlCCyUT9xn9vofUlTW
 Ce3ZIe5xkCStmH3odAgny6T/V4nKYb7JBCb+5Wo+GGln7aNgyU5wesKIDkEmHOPTaGok
 5RWQsTtxBqra98FziOVMsPEuiR9orKQTwiVn0XX7+ZvuXZjLsNYOlnIQNcqg6hmELgDF
 bD0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780344016; x=1780948816;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=msbNDh9TiShw7R12hj6rcfm+XGYU44qZJxoBlWEONAk=;
 b=BcmpF9/OgKr0Y5vcsyg17u/VKwMOtCUGpl0Pg+m9jvRbVZ8vYBZ51NPwbE4eVDHcqI
 d7fjhv+82Qe6vuBnob43URPLpIc98mmxvl2pthMtNrSshKKQ/YHroFfzLixDMONYvU15
 +kfh6gDIEOBEyr/owJ66rmKpSB6qZ2ynax05utpayKskg6lY6itlQTTVbuw9FYng5CVe
 NyeA9BT5NHKSrOSL8Yw6+TnzRStK0CmUylPyg0cXOqlWvReirt8n/YiBrqG4JRdioiLY
 3UohxzCITZ78nUw86NiIMd/GRH6gGaHnM/Kg+uxYJy822lPK2Xh5EHKpa9h9y+DK9p3u
 PA+w==
X-Forwarded-Encrypted: i=1;
 AFNElJ8XcrexZ3CZSU7IFEtgxPsliNVgpSCImPAgTDa0YBpUf1hb+B+sPvccw6i2FfBABg/Ofo2prkSOPTI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzboly+hDMDFgVeCXt+40Xk5Rl3MiPon3Ba82Ffvt34rycIiX+M
 ocmHroACzBPath6J35QDl51ZBqXddFQvIfEjVALCrGLysiBvpmUVh7IgUZf0qVZmQRftI4CX8kg
 OhNnzRzG5Hw70
X-Received: from qknxz25.prod.google.com ([2002:a05:620a:5e19:b0:910:b90:6ec6])
 (user=xuehaohu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4612:b0:915:5930:94f1 with SMTP id
 af79cd13be357-91559309603mr1224141185a.47.1780344015096; 
 Mon, 01 Jun 2026 13:00:15 -0700 (PDT)
Date: Mon,  1 Jun 2026 20:00:12 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260601200012.3872274-1-xuehaohu@google.com>
Subject: [PATCH v5] dma-buf: Fix silent overflow for phys vec to sgt
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
by using `size_t` for `nents` and checking against `UINT_MAX`
and using `unsigned int` for the loop iterator in `fill_sg_entry`
to match.

Fixes: 3aa31a8bb11e ("dma-buf: provide phys_vec to scatter-gather mapping routine")
Cc: stable@vger.kernel.org
Cc: iommu@lists.linux.dev
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: David Hu <xuehaohu@google.com>
---
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

 drivers/dma-buf/dma-buf-mapping.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-buf-mapping.c
index 794acff2546a..607b7998463d 100644
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
@@ -133,6 +137,11 @@ struct sg_table *dma_buf_phys_vec_to_sgt(struct dma_buf_attachment *attach,
 	}
 
 	nents = calc_sg_nents(dma->state, phys_vec, nr_ranges, size);
+	if (!nents) {
+		ret = -EINVAL;
+		goto err_free_state;
+	}
+
 	ret = sg_alloc_table(&dma->sgt, nents, GFP_KERNEL | __GFP_ZERO);
 	if (ret)
 		goto err_free_state;
-- 
2.54.0.929.g9b7fa37559-goog

