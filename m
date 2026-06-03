Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78131CD6E55
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 15:19:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FEE610FFDC;
	Wed,  3 Jun 2026 15:19:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hV9Koh2c";
	dkim-atps=neutral
Received: from out30-118.freemail.mail.aliyun.com
 (out30-118.freemail.mail.aliyun.com [115.124.30.118])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA47810FFDC
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 15:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1780499940; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=QjZ8f27cqLiBL9quajEXvEuD5izxdrCDst1w3hORFvo=;
 b=hV9Koh2cxRoTfjnu9bgWdNIEROapxFIrFH7s2DA6Wf5GwVom6NfWlhUMgWczfQQpvgMpZgqXbYLbfEQrJVp3eZtJHPlkteFXfw3Jt8NqJ96sXRMgmPjQGRZn7LsLPcC3t4OE8LRXsw1luzi9R7wak5RZocgaNyzzbzoa+OtUJd8=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R531e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037026112;
 MF=guanghuifeng@linux.alibaba.com; NM=1; PH=DS; RN=28; SR=0;
 TI=SMTPD_---0X47fR5b_1780499938; 
Received: from
 VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com
 fp:SMTPD_---0X47fR5b_1780499938 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 03 Jun 2026 23:18:58 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: jgg@ziepe.ca
Cc: adrian.larumbe@collabora.com, airlied@gmail.com, alex@shazbot.org,
 alikernel-developer@linux.alibaba.com, baolu.lu@linux.intel.com,
 boris.brezillon@collabora.com, dri-devel@lists.freedesktop.org,
 dwmw2@infradead.org, iommu@lists.linux.dev, joro@8bytes.org,
 kevin.tian@intel.com, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 liviu.dudau@arm.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 oliver.yang@linux.alibaba.com, robh@kernel.org, robin.murphy@arm.com,
 shiyu.zsq@linux.alibaba.com, steven.price@arm.com,
 suravee.suthikulpanit@amd.com, tzimmermann@suse.de,
 wei.guo.simon@linux.alibaba.com, will@kernel.org, xlpang@linux.alibaba.com
Subject: [PATCH v3 20/32] iommu/sun50i: implement iova_to_phys_length
Date: Wed,  3 Jun 2026 23:17:52 +0800
Message-ID: <20260603151804.1963871-21-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260603151804.1963871-1-guanghuifeng@linux.alibaba.com>
References: <20260602104637.1219810-1-guanghuifeng@linux.alibaba.com>
 <20260603151804.1963871-1-guanghuifeng@linux.alibaba.com>
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

Implement iova_to_phys_length for sun50i IOMMU driver,
returning the actual PTE mapping size.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/iommu/sun50i-iommu.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index be3f1ce696ba..9f39fe4a9d4f 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -659,8 +659,9 @@ static size_t sun50i_iommu_unmap(struct iommu_domain *domain, unsigned long iova
 	return SZ_4K;
 }
 
-static phys_addr_t sun50i_iommu_iova_to_phys(struct iommu_domain *domain,
-					     dma_addr_t iova)
+static phys_addr_t sun50i_iommu_iova_to_phys_length(struct iommu_domain *domain,
+						    dma_addr_t iova,
+						    size_t *mapped_length)
 {
 	struct sun50i_iommu_domain *sun50i_domain = to_sun50i_domain(domain);
 	phys_addr_t pt_phys;
@@ -669,13 +670,16 @@ static phys_addr_t sun50i_iommu_iova_to_phys(struct iommu_domain *domain,
 
 	dte = sun50i_domain->dt[sun50i_iova_get_dte_index(iova)];
 	if (!sun50i_dte_is_pt_valid(dte))
-		return 0;
+		return PHYS_ADDR_MAX;
 
 	pt_phys = sun50i_dte_get_pt_address(dte);
 	page_table = (u32 *)phys_to_virt(pt_phys);
 	pte = page_table[sun50i_iova_get_pte_index(iova)];
 	if (!sun50i_pte_is_page_valid(pte))
-		return 0;
+		return PHYS_ADDR_MAX;
+
+	if (mapped_length)
+		*mapped_length = SZ_4K;
 
 	return sun50i_pte_get_page_address(pte) +
 		sun50i_iova_get_page_offset(iova);
@@ -857,7 +861,7 @@ static const struct iommu_ops sun50i_iommu_ops = {
 		.flush_iotlb_all = sun50i_iommu_flush_iotlb_all,
 		.iotlb_sync_map = sun50i_iommu_iotlb_sync_map,
 		.iotlb_sync	= sun50i_iommu_iotlb_sync,
-		.iova_to_phys	= sun50i_iommu_iova_to_phys,
+		.iova_to_phys_length	= sun50i_iommu_iova_to_phys_length,
 		.map_pages	= sun50i_iommu_map,
 		.unmap_pages	= sun50i_iommu_unmap,
 		.free		= sun50i_iommu_domain_free,
-- 
2.43.7

