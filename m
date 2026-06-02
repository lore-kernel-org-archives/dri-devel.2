Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 320B5CD6E57
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 10:47:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39A5510EED4;
	Tue,  2 Jun 2026 10:47:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SRKSh7k6";
	dkim-atps=neutral
Received: from out30-111.freemail.mail.aliyun.com
 (out30-111.freemail.mail.aliyun.com [115.124.30.111])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E700F10EECD
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 10:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1780397216; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=lXbAa3wi4sVOE4GQK97qO7LGHZPOWW0jlxx/0XeuaBY=;
 b=SRKSh7k6oNEFSfdwTBvoDCMq4A4pd3ruwkaGaHzf6t/hT6HGRuyW9t44xci5xL2PZhDfxXPQKWF0dPXKTbrVX5yh+m9ZThUh2mPHajzWY2NYFKkpI+DPDlk77ROq7whPGnIJ/6qNHecL6WB9vmy0mmpuDyQADr+05fHNesGUQe0=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037026112;
 MF=guanghuifeng@linux.alibaba.com; NM=1; PH=DS; RN=28; SR=0;
 TI=SMTPD_---0X44E93i_1780397214; 
Received: from
 VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com
 fp:SMTPD_---0X44E93i_1780397214 cluster:ay36) by smtp.aliyun-inc.com;
 Tue, 02 Jun 2026 18:46:54 +0800
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
Subject: [PATCH v2 07/30] iommu/arm-smmu: implement iova_to_phys_length
Date: Tue,  2 Jun 2026 18:46:14 +0800
Message-ID: <20260602104637.1219810-8-guanghuifeng@linux.alibaba.com>
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

Migrate ARM SMMU to implement iova_to_phys_length, calling
ops->iova_to_phys_length on the io-pgtable layer. Update qcom-debug
caller accordingly.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c |  2 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.c            | 15 +++++++++------
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c
index 65e0ef6539fe..4fd01341157f 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c
@@ -415,7 +415,7 @@ irqreturn_t qcom_smmu_context_fault(int irq, void *dev)
 		return IRQ_HANDLED;
 	}
 
-	phys_soft = ops->iova_to_phys(ops, cfi.iova);
+	phys_soft = ops->iova_to_phys_length(ops, cfi.iova, NULL);
 
 	tmp = report_iommu_fault(&smmu_domain->domain, NULL, cfi.iova,
 				 cfi.fsynr & ARM_SMMU_CB_FSYNR0_WNR ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ);
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 0bd21d206eb3..dfbd541f9e3e 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1366,7 +1366,7 @@ static phys_addr_t arm_smmu_iova_to_phys_hard(struct iommu_domain *domain,
 			"iova to phys timed out on %pad. Falling back to software table walk.\n",
 			&iova);
 		arm_smmu_rpm_put(smmu);
-		return ops->iova_to_phys(ops, iova);
+		return ops->iova_to_phys_length(ops, iova, NULL);
 	}
 
 	phys = arm_smmu_cb_readq(smmu, idx, ARM_SMMU_CB_PAR);
@@ -1384,20 +1384,23 @@ static phys_addr_t arm_smmu_iova_to_phys_hard(struct iommu_domain *domain,
 	return addr;
 }
 
-static phys_addr_t arm_smmu_iova_to_phys(struct iommu_domain *domain,
-					dma_addr_t iova)
+static phys_addr_t arm_smmu_iova_to_phys_length(struct iommu_domain *domain,
+					dma_addr_t iova, size_t *mapped_length)
 {
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct io_pgtable_ops *ops = smmu_domain->pgtbl_ops;
 
+	if (mapped_length)
+		*mapped_length = 0;
+
 	if (!ops)
-		return 0;
+		return PHYS_ADDR_MAX;
 
 	if (smmu_domain->smmu->features & ARM_SMMU_FEAT_TRANS_OPS &&
 			smmu_domain->stage == ARM_SMMU_DOMAIN_S1)
 		return arm_smmu_iova_to_phys_hard(domain, iova);
 
-	return ops->iova_to_phys(ops, iova);
+	return ops->iova_to_phys_length(ops, iova, mapped_length);
 }
 
 static bool arm_smmu_capable(struct device *dev, enum iommu_cap cap)
@@ -1652,7 +1655,7 @@ static const struct iommu_ops arm_smmu_ops = {
 		.unmap_pages		= arm_smmu_unmap_pages,
 		.flush_iotlb_all	= arm_smmu_flush_iotlb_all,
 		.iotlb_sync		= arm_smmu_iotlb_sync,
-		.iova_to_phys		= arm_smmu_iova_to_phys,
+		.iova_to_phys_length	= arm_smmu_iova_to_phys_length,
 		.set_pgtable_quirks	= arm_smmu_set_pgtable_quirks,
 		.free			= arm_smmu_domain_free,
 	}
-- 
2.43.7

