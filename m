Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4043CD6E6E
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 15:19:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 044CA10FFEF;
	Wed,  3 Jun 2026 15:19:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="U3jtHoYm";
	dkim-atps=neutral
Received: from out30-99.freemail.mail.aliyun.com
 (out30-99.freemail.mail.aliyun.com [115.124.30.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECF4E10FFDE
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 15:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1780499938; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=B2CWGyb/jy+luBGe9CF0J2PFthBHN8proHGbNilHQH0=;
 b=U3jtHoYmI9JraEWIDtxZuZpVz1+6UrR/jq4EnXftNI2jhoxHQBEi/loi9mbYloL5gGRjCAUA+sSxZGmvV+5wMtM5rEfLz/r+CjKy3oRCTUmG3DcKN8PKfSePZGeC93WYRzNmaUxd0QbIMdlcTpEck/XeEuJCBadaJ9Gvc52pyms=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R921e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033032089153;
 MF=guanghuifeng@linux.alibaba.com; NM=1; PH=DS; RN=28; SR=0;
 TI=SMTPD_---0X47fR4e_1780499934; 
Received: from
 VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com
 fp:SMTPD_---0X47fR4e_1780499934 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 03 Jun 2026 23:18:54 +0800
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
Subject: [PATCH v3 16/32] iommu/omap: implement iova_to_phys_length
Date: Wed,  3 Jun 2026 23:17:48 +0800
Message-ID: <20260603151804.1963871-17-guanghuifeng@linux.alibaba.com>
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

Implement iova_to_phys_length for OMAP IOMMU driver,
returning the actual PTE mapping size.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/iommu/omap-iommu.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 8231d7d6bb6a..f4a416326f7c 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1592,15 +1592,16 @@ static void omap_iommu_domain_free(struct iommu_domain *domain)
 	kfree(omap_domain);
 }
 
-static phys_addr_t omap_iommu_iova_to_phys(struct iommu_domain *domain,
-					   dma_addr_t da)
+static phys_addr_t omap_iommu_iova_to_phys_length(struct iommu_domain *domain,
+						  dma_addr_t da,
+						  size_t *mapped_length)
 {
 	struct omap_iommu_domain *omap_domain = to_omap_domain(domain);
 	struct omap_iommu_device *iommu = omap_domain->iommus;
 	struct omap_iommu *oiommu = iommu->iommu_dev;
 	struct device *dev = oiommu->dev;
 	u32 *pgd, *pte;
-	phys_addr_t ret = 0;
+	phys_addr_t ret = PHYS_ADDR_MAX;
 
 	/*
 	 * all the iommus within the domain will have identical programming,
@@ -1609,19 +1610,27 @@ static phys_addr_t omap_iommu_iova_to_phys(struct iommu_domain *domain,
 	iopgtable_lookup_entry(oiommu, da, &pgd, &pte);
 
 	if (pte) {
-		if (iopte_is_small(*pte))
+		if (iopte_is_small(*pte)) {
 			ret = omap_iommu_translate(*pte, da, IOPTE_MASK);
-		else if (iopte_is_large(*pte))
+			if (mapped_length)
+				*mapped_length = IOPTE_SIZE;
+		} else if (iopte_is_large(*pte)) {
 			ret = omap_iommu_translate(*pte, da, IOLARGE_MASK);
-		else
+			if (mapped_length)
+				*mapped_length = IOLARGE_SIZE;
+		} else
 			dev_err(dev, "bogus pte 0x%x, da 0x%llx", *pte,
 				(unsigned long long)da);
 	} else {
-		if (iopgd_is_section(*pgd))
+		if (iopgd_is_section(*pgd)) {
 			ret = omap_iommu_translate(*pgd, da, IOSECTION_MASK);
-		else if (iopgd_is_super(*pgd))
+			if (mapped_length)
+				*mapped_length = IOSECTION_SIZE;
+		} else if (iopgd_is_super(*pgd)) {
 			ret = omap_iommu_translate(*pgd, da, IOSUPER_MASK);
-		else
+			if (mapped_length)
+				*mapped_length = IOSUPER_SIZE;
+		} else
 			dev_err(dev, "bogus pgd 0x%x, da 0x%llx", *pgd,
 				(unsigned long long)da);
 	}
@@ -1723,7 +1732,7 @@ static const struct iommu_ops omap_iommu_ops = {
 		.attach_dev	= omap_iommu_attach_dev,
 		.map_pages	= omap_iommu_map,
 		.unmap_pages	= omap_iommu_unmap,
-		.iova_to_phys	= omap_iommu_iova_to_phys,
+		.iova_to_phys_length	= omap_iommu_iova_to_phys_length,
 		.free		= omap_iommu_domain_free,
 	}
 };
-- 
2.43.7

