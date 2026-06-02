Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C6B8CD6E6C
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 10:47:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87D5410EEE4;
	Tue,  2 Jun 2026 10:47:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VMu5Suwd";
	dkim-atps=neutral
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED50B10EEDD
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 10:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1780397226; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=FS/8CTbNUNtKKm1fU7W5+5c/18z86DAMGyOuBL/xGCw=;
 b=VMu5SuwdnaqXQ1NxNnItSuKNY7VetAgzT+lrSiT+D7189FXE3iB+unp1PjmBxV3sqP3MB97bnsNmE23PcessfTIB+c1LZeM2KtKyBawDes7NtxIqpgW+QvAG7hctQpzi4xxuAqwo2SOme77rWK7mcgOtxoisyofBFiGpWM6DTaY=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037033178;
 MF=guanghuifeng@linux.alibaba.com; NM=1; PH=DS; RN=28; SR=0;
 TI=SMTPD_---0X44E94t_1780397219; 
Received: from
 VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com
 fp:SMTPD_---0X44E94t_1780397219 cluster:ay36) by smtp.aliyun-inc.com;
 Tue, 02 Jun 2026 18:46:59 +0800
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
Subject: [PATCH v2 12/30] iommu/exynos: implement iova_to_phys_length
Date: Tue,  2 Jun 2026 18:46:19 +0800
Message-ID: <20260602104637.1219810-13-guanghuifeng@linux.alibaba.com>
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

Implement iova_to_phys_length for Exynos IOMMU driver,
returning the actual PTE mapping size.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/iommu/exynos-iommu.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 874d05f4b396..a9da28606cff 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -1372,13 +1372,17 @@ static size_t exynos_iommu_unmap(struct iommu_domain *iommu_domain,
 	return 0;
 }
 
-static phys_addr_t exynos_iommu_iova_to_phys(struct iommu_domain *iommu_domain,
-					  dma_addr_t iova)
+static phys_addr_t exynos_iommu_iova_to_phys_length(struct iommu_domain *iommu_domain,
+						 dma_addr_t iova,
+						 size_t *mapped_length)
 {
 	struct exynos_iommu_domain *domain = to_exynos_domain(iommu_domain);
 	sysmmu_pte_t *entry;
 	unsigned long flags;
-	phys_addr_t phys = 0;
+	phys_addr_t phys = PHYS_ADDR_MAX;
+
+	if (mapped_length)
+		*mapped_length = 0;
 
 	spin_lock_irqsave(&domain->pgtablelock, flags);
 
@@ -1386,13 +1390,20 @@ static phys_addr_t exynos_iommu_iova_to_phys(struct iommu_domain *iommu_domain,
 
 	if (lv1ent_section(entry)) {
 		phys = section_phys(entry) + section_offs(iova);
+		if (mapped_length)
+			*mapped_length = SECT_SIZE;
 	} else if (lv1ent_page(entry)) {
 		entry = page_entry(entry, iova);
 
-		if (lv2ent_large(entry))
+		if (lv2ent_large(entry)) {
 			phys = lpage_phys(entry) + lpage_offs(iova);
-		else if (lv2ent_small(entry))
+			if (mapped_length)
+				*mapped_length = LPAGE_SIZE;
+		} else if (lv2ent_small(entry)) {
 			phys = spage_phys(entry) + spage_offs(iova);
+			if (mapped_length)
+				*mapped_length = SPAGE_SIZE;
+		}
 	}
 
 	spin_unlock_irqrestore(&domain->pgtablelock, flags);
@@ -1484,7 +1495,7 @@ static const struct iommu_ops exynos_iommu_ops = {
 		.attach_dev	= exynos_iommu_attach_device,
 		.map_pages	= exynos_iommu_map,
 		.unmap_pages	= exynos_iommu_unmap,
-		.iova_to_phys	= exynos_iommu_iova_to_phys,
+		.iova_to_phys_length	= exynos_iommu_iova_to_phys_length,
 		.free		= exynos_iommu_domain_free,
 	}
 };
-- 
2.43.7

