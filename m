Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E4C5CD6E6F
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 15:19:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A01D10FFEC;
	Wed,  3 Jun 2026 15:19:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kB8lIvHg";
	dkim-atps=neutral
Received: from out30-132.freemail.mail.aliyun.com
 (out30-132.freemail.mail.aliyun.com [115.124.30.132])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B73DD10FFDC
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 15:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1780499941; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=YhFCJ0OCDdDnQ9GsEesCvbAqOo6Zg3iFvNCzM+hu5ak=;
 b=kB8lIvHgB7Mf8hAADuyKaxGMB64JMCqGbupJuIST/2yOWLtvhgJiuJb5A0/i2eEs4KG+CoC/ScqH1h7Sb8haCOEFeLkjEm6LnbRbGgdcIGqAfopBc8xFWldM2jw2gp369UaTiuEVI/oDuA6KW2+YI917ysgnH0VMCkhJsev/L/o=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R231e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam011083073210;
 MF=guanghuifeng@linux.alibaba.com; NM=1; PH=DS; RN=28; SR=0;
 TI=SMTPD_---0X47fR6-_1780499939; 
Received: from
 VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com
 fp:SMTPD_---0X47fR6-_1780499939 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 03 Jun 2026 23:18:59 +0800
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
Subject: [PATCH v3 21/32] iommu/tegra-smmu: implement iova_to_phys_length
Date: Wed,  3 Jun 2026 23:17:53 +0800
Message-ID: <20260603151804.1963871-22-guanghuifeng@linux.alibaba.com>
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

Implement iova_to_phys_length for Tegra SMMU IOMMU driver,
returning the actual PTE mapping size.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/iommu/tegra-smmu.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 67e7a7b925f0..12f9bb623d87 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -803,8 +803,8 @@ static size_t tegra_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
 	return size;
 }
 
-static phys_addr_t tegra_smmu_iova_to_phys(struct iommu_domain *domain,
-					   dma_addr_t iova)
+static phys_addr_t tegra_smmu_iova_to_phys_length(struct iommu_domain *domain,
+					   dma_addr_t iova, size_t *mapped_length)
 {
 	struct tegra_smmu_as *as = to_smmu_as(domain);
 	unsigned long pfn;
@@ -813,10 +813,13 @@ static phys_addr_t tegra_smmu_iova_to_phys(struct iommu_domain *domain,
 
 	pte = tegra_smmu_pte_lookup(as, iova, &pte_dma);
 	if (!pte || !*pte)
-		return 0;
+		return PHYS_ADDR_MAX;
 
 	pfn = *pte & as->smmu->pfn_mask;
 
+	if (mapped_length)
+		*mapped_length = SZ_4K;
+
 	return SMMU_PFN_PHYS(pfn) + SMMU_OFFSET_IN_PAGE(iova);
 }
 
@@ -1007,7 +1010,7 @@ static const struct iommu_ops tegra_smmu_ops = {
 		.attach_dev	= tegra_smmu_attach_dev,
 		.map_pages	= tegra_smmu_map,
 		.unmap_pages	= tegra_smmu_unmap,
-		.iova_to_phys	= tegra_smmu_iova_to_phys,
+		.iova_to_phys_length = tegra_smmu_iova_to_phys_length,
 		.free		= tegra_smmu_domain_free,
 	}
 };
-- 
2.43.7

