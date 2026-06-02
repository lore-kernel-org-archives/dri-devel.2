Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41828CD6E5D
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 10:46:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A56510EECB;
	Tue,  2 Jun 2026 10:46:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YXPTGHjH";
	dkim-atps=neutral
Received: from out30-112.freemail.mail.aliyun.com
 (out30-112.freemail.mail.aliyun.com [115.124.30.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC1E310EEC8
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 10:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1780397212; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=NEcdkKuIoYfcjbKM7WhKOeSFYFCWaJe62lwiuJRVrJ0=;
 b=YXPTGHjHGC1JjXPkuAjGSHxn0Z//22h6Dy5TjFDeP6mxWhDBz//uQ3Lfa8hyuZ22xeLz/sTsOtx606mr5QYgirZOd5TuNnEGISVhgt9U1U9Bg+fEVKZoartPqSXEUofmfH9rC9jNUk/qUcjk5cfNd7tq/xWntbg3lRYtsYFasLk=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R391e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045133197;
 MF=guanghuifeng@linux.alibaba.com; NM=1; PH=DS; RN=28; SR=0;
 TI=SMTPD_---0X44E92e_1780397209; 
Received: from
 VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com
 fp:SMTPD_---0X44E92e_1780397209 cluster:ay36) by smtp.aliyun-inc.com;
 Tue, 02 Jun 2026 18:46:50 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: adrian.larumbe@collabora.com, airlied@gmail.com, alex@shazbot.org,
 baolu.lu@linux.intel.com, boris.brezillon@collabora.com,
 dri-devel@lists.freedesktop.org, dwmw2@infradead.org,
 iommu@lists.linux.dev, jgg@ziepe.ca, joro@8bytes.org, kevin.tian@intel.com,
 kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, liviu.dudau@arm.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 oliver.yang@linux.alibaba.com, robh@kernel.org, robin.murphy@arm.com,
 shiyu.zsq@linux.alibaba.com, steven.price@arm.com,
 suravee.suthikulpanit@amd.com, tzimmermann@suse.de,
 wei.guo.simon@linux.alibaba.com, will@kernel.org, xlpang@linux.alibaba.com
Cc: alikernel-developer@linux.alibaba.com
Subject: [PATCH v2 03/30] iommu/io-pgtable-arm-v7s: introduce
 iova_to_phys_length in io_pgtable_ops
Date: Tue,  2 Jun 2026 18:46:10 +0800
Message-ID: <20260602104637.1219810-4-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260602104637.1219810-1-guanghuifeng@linux.alibaba.com>
References: <20260531093637.3893199-1-guanghuifeng@linux.alibaba.com>
 <20260602104637.1219810-1-guanghuifeng@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Implement iova_to_phys_length in ARM v7s backend: returns block size
derived from level mask. The old iova_to_phys is kept as a thin wrapper.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/iommu/io-pgtable-arm-v7s.c | 34 ++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index 1dbef8c55007..5868d68e8a85 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -641,13 +641,27 @@ static size_t arm_v7s_unmap_pages(struct io_pgtable_ops *ops, unsigned long iova
 	return unmapped;
 }
 
+static phys_addr_t arm_v7s_iova_to_phys_length(struct io_pgtable_ops *ops,
+						unsigned long iova,
+						size_t *mapped_length);
+
 static phys_addr_t arm_v7s_iova_to_phys(struct io_pgtable_ops *ops,
 					unsigned long iova)
+{
+	phys_addr_t phys = arm_v7s_iova_to_phys_length(ops, iova, NULL);
+
+	return (phys == PHYS_ADDR_MAX) ? 0 : phys;
+}
+
+static phys_addr_t arm_v7s_iova_to_phys_length(struct io_pgtable_ops *ops,
+						unsigned long iova,
+						size_t *mapped_length)
 {
 	struct arm_v7s_io_pgtable *data = io_pgtable_ops_to_data(ops);
 	arm_v7s_iopte *ptep = data->pgd, pte;
 	int lvl = 0;
 	u32 mask;
+	size_t blk_size;
 
 	do {
 		ptep += ARM_V7S_LVL_IDX(iova, ++lvl, &data->iop.cfg);
@@ -656,11 +670,16 @@ static phys_addr_t arm_v7s_iova_to_phys(struct io_pgtable_ops *ops,
 	} while (ARM_V7S_PTE_IS_TABLE(pte, lvl));
 
 	if (!ARM_V7S_PTE_IS_VALID(pte))
-		return 0;
+		return PHYS_ADDR_MAX;
 
 	mask = ARM_V7S_LVL_MASK(lvl);
 	if (arm_v7s_pte_is_cont(pte, lvl))
 		mask *= ARM_V7S_CONT_PAGES;
+
+	blk_size = ~mask + 1U;
+	if (mapped_length)
+		*mapped_length = blk_size;
+
 	return iopte_to_paddr(pte, lvl, &data->iop.cfg) | (iova & ~mask);
 }
 
@@ -714,6 +733,7 @@ static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
 		.map_pages	= arm_v7s_map_pages,
 		.unmap_pages	= arm_v7s_unmap_pages,
 		.iova_to_phys	= arm_v7s_iova_to_phys,
+		.iova_to_phys_length	= arm_v7s_iova_to_phys_length,
 	};
 
 	/* We have to do this early for __arm_v7s_alloc_table to work... */
@@ -843,13 +863,13 @@ static int __init arm_v7s_do_selftests(void)
 	 * Initial sanity checks.
 	 * Empty page tables shouldn't provide any translations.
 	 */
-	if (ops->iova_to_phys(ops, 42))
+	if (ops->iova_to_phys_length(ops, 42, NULL) != PHYS_ADDR_MAX)
 		return __FAIL(ops);
 
-	if (ops->iova_to_phys(ops, SZ_1G + 42))
+	if (ops->iova_to_phys_length(ops, SZ_1G + 42, NULL) != PHYS_ADDR_MAX)
 		return __FAIL(ops);
 
-	if (ops->iova_to_phys(ops, SZ_2G + 42))
+	if (ops->iova_to_phys_length(ops, SZ_2G + 42, NULL) != PHYS_ADDR_MAX)
 		return __FAIL(ops);
 
 	/*
@@ -870,7 +890,7 @@ static int __init arm_v7s_do_selftests(void)
 				    &mapped))
 			return __FAIL(ops);
 
-		if (ops->iova_to_phys(ops, iova + 42) != (iova + 42))
+		if (ops->iova_to_phys_length(ops, iova + 42, NULL) != (iova + 42))
 			return __FAIL(ops);
 
 		iova += SZ_16M;
@@ -884,7 +904,7 @@ static int __init arm_v7s_do_selftests(void)
 		if (ops->unmap_pages(ops, iova, size, 1, NULL) != size)
 			return __FAIL(ops);
 
-		if (ops->iova_to_phys(ops, iova + 42))
+		if (ops->iova_to_phys_length(ops, iova + 42, NULL) != PHYS_ADDR_MAX)
 			return __FAIL(ops);
 
 		/* Remap full block */
@@ -892,7 +912,7 @@ static int __init arm_v7s_do_selftests(void)
 				   GFP_KERNEL, &mapped))
 			return __FAIL(ops);
 
-		if (ops->iova_to_phys(ops, iova + 42) != (iova + 42))
+		if (ops->iova_to_phys_length(ops, iova + 42, NULL) != (iova + 42))
 			return __FAIL(ops);
 
 		iova += SZ_16M;
-- 
2.43.7

