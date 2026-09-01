Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D43C624D4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:34:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E21D610F3FB;
	Thu,  3 Sep 2026 07:33:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=x6u.co header.i=@x6u.co header.b="kD1EBGPN";
	dkim-atps=neutral
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com
 [209.85.128.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB97010EDF1
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 17:09:18 +0000 (UTC)
Received: by mail-yw1-f169.google.com with SMTP id
 00721157ae682-85aeb506b78so3226417b3.3
 for <dri-devel@lists.freedesktop.org>; Tue, 01 Sep 2026 10:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=x6u.co; s=google; t=1788282558; x=1788887358; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IbWwW5sIPuPDCzD8yPpWzav/RwZMe+wNYupbv2vHzg4=;
 b=kD1EBGPNnY7jwnD1kK444G6p5UB35/m0ZnX4pZ85IMYudJIjG1jmKIBSTQ8PoN9317
 COVhsJjEGL1D/dhKemG0vJVHCRyrbBahzgM7PDeW8BVbapDxZ5lGifX/oX8KlKKI42XM
 no7gNeB3SrHn8JcGU8lpQCbZp9TnmZAmc2Cc2arw9g1XOt0Cbb0j9IruA4KNotTtsglv
 GNLd6Ee1+yfUA9H3n1j420ECFVVkzHE/kzRZy39LyLDm4cIozwFmn6giWLzj5PcC5OG1
 8qqRsK0wnae/gb8qo3T0HJkyeWtaIlpOsDyJlSXjssFZcrAIZEYQTqMVC2A3oy9z3umU
 QFSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788282558; x=1788887358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IbWwW5sIPuPDCzD8yPpWzav/RwZMe+wNYupbv2vHzg4=;
 b=IN05zpIJf5M6VVDNloGAVD5zyDieWntqHEr4E5Qnys7jqw/0/S5DCEURJkOPs+WCxQ
 WAf89WjqlTvkMBjmxZEHxLpQgwwOU9HZd7GZW8y3rslBaG0Rvs9ptrIqYOt4Tfa3bxLi
 18e1SRTBpvyBAbecfYx21Ut5MdRVxglyk1bgTsSf8zZlN1mpVsXKgdXQDRvn5TCzRwjo
 AD2bytBN4t7rRAtc975QGIOAHfV2eh6pA5P9GjJk/k4Kks5y57ytGOJYTfs73K6RVYKT
 K1x81lBxR0pizVcK4M1Ss5M1ABNb5llM3c9RVfnhgwXpn0G9e1VITWMBAnxREdkJifoJ
 sH4g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwOWIGzhH7nhb28YgRYrZmTUzrrFhREKFS0zpOPNJeb7h2E+fbFrBsWGONfWNnkImjTgIq2VhDHbMM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lDYItzSTauSwGmlSXZVvNPoHgOX5y5G8xkYYv1zq4si6R60fui
 cEQ/JB24oUWdLtBNGLDAydrYRJq5PdKLlUVSOuTEPXIuorYuq3NEK7lTDq5FHHvMRo8b
X-Gm-Gg: AYBFou3RgDPvw9ClQ31NEvZi1WzOSRB6f/W8AfNg0nVTBw40DzDT/mPJ/9gGAaPvrHU
 7SKrCUdcEYZyvOLZafXPdC2yod8YJMyabN86yTPbA0lWZrqQcs5lkdOWhlXAVBgU7vrSIAH71B/
 kZsoVmEbA9OFIPNNYzdTJYrdy35+41SPrFu3biW+2/0ajuMCkmEjWnpPbPW9EZ9KeehY+wKDTSl
 /IUvzUyifJhcrd7qmTQpcgHlRZql6H5I5igMIfN5o2auW+fJ6xRobo8gs9vKPLvAUoSrz7D54qQ
 U8l5VSseRIJDj57YjoYi+5dfPdVrRVE9pmTd4hyEFgacPf+Pq6inEoIxChNynSWBdv6dyWtluBr
 uT+oO1SV2nCD0C+AkjtrUm2ifF2MfwMzxRW1zftPuc0eZsgDkrQ5A1AfK2jcaP4BCX+fTiJ3Eb0
 edqZgT7tqjzww3p+2u2wXeGOIaALvvvqdT6LG8blte1izxtZY+3+3ECJClW4MI+Z/5TJ6Ebr9el
 NqBcOepkdpVV9dbQHPS6ixZkFij9FEN4FpCwhJHfx7N2ExkVg845nkCmJ+5oI2076fwuoN/3vxA
 YQ==
X-Received: by 2002:a05:690c:a7c2:b0:854:74e:ad6b with SMTP id
 00721157ae682-8686ff0ecabmr35913247b3.15.1788282557505; 
 Tue, 01 Sep 2026 10:09:17 -0700 (PDT)
Received: from worldpeace10.c.googlers.com.com
 (109.243.150.34.bc.googleusercontent.com. [34.150.243.109])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-85e65f146edsm79761867b3.32.2026.09.01.10.09.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 10:09:17 -0700 (PDT)
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
 xuehaohu@google.com
Subject: [PATCH v8 1/2] dma-buf: Fix silent overflow for phys vec to sgt
Date: Tue,  1 Sep 2026 17:08:48 +0000
Message-ID: <20260901170849.4052816-2-dhu@x6u.co>
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
Reviewed-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: David Hu <xuehaohu@google.com>
---
Changes in v7:
 - Added a missing blank line after local variable declaration in
   `calc_sg_nents()` (Leon).
 - Collected Reviewed-by from Leon Romanovsky.

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

 drivers/dma-buf/dma-buf-mapping.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-buf-mapping.c
index 794acff2546a..80f6ab2f4809 100644
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
@@ -40,8 +41,12 @@ static unsigned int calc_sg_nents(struct dma_iova_state *state,
 	size_t i;
 
 	if (!state || !dma_use_iova(state)) {
-		for (i = 0; i < nr_ranges; i++)
-			nents += DIV_ROUND_UP(phys_vec[i].len, UINT_MAX);
+		for (i = 0; i < nr_ranges; i++) {
+			unsigned int added = DIV_ROUND_UP(phys_vec[i].len, UINT_MAX);
+
+			if (check_add_overflow(nents, added, &nents))
+				return 0;
+		}
 	} else {
 		/*
 		 * In IOVA case, there is only one SG entry which spans
@@ -95,9 +100,10 @@ struct sg_table *dma_buf_phys_vec_to_sgt(struct dma_buf_attachment *attach,
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
@@ -133,6 +139,8 @@ struct sg_table *dma_buf_phys_vec_to_sgt(struct dma_buf_attachment *attach,
 	}
 
 	nents = calc_sg_nents(dma->state, phys_vec, nr_ranges, size);
+
+	/* sg_alloc_table will cleanly fail and return -EINVAL if nents == 0 */
 	ret = sg_alloc_table(&dma->sgt, nents, GFP_KERNEL | __GFP_ZERO);
 	if (ret)
 		goto err_free_state;
-- 
2.55.0.897.gb25b4bd76c-goog

