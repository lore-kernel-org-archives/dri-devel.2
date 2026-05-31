Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE9BBCD6E5E
	for <dri-devel@archiver.kernel.org>; Sun, 31 May 2026 13:59:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E12D1112B6A;
	Sun, 31 May 2026 13:59:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xY17vOl4";
	dkim-atps=neutral
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC5F710E5C0
 for <dri-devel@lists.freedesktop.org>; Sun, 31 May 2026 09:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1780220513; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=fMFLtmgtJGc7Xa/wXUQPOkhxPbCISpIgLbRDfLPPgtk=;
 b=xY17vOl4GkMgV2M2HO1+3xHjK7u3RXC6+CVIq/gq1wPcbiNjY+QZpXmT5oJeezDzSVYXozVKH831lmKGKxs5+Qon3w06MXfiknnZ2/bsbbaKOIk5Zi/uYxUxvokwkOhBF5eAR6jUeUebYnedSO2pBJ4vSgS0ST246UB4xnjLP0w=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045098064;
 MF=guanghuifeng@linux.alibaba.com; NM=1; PH=DS; RN=27; SR=0;
 TI=SMTPD_---0X3tRVpg_1780220210; 
Received: from
 VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com
 fp:SMTPD_---0X3tRVpg_1780220210 cluster:ay36) by smtp.aliyun-inc.com;
 Sun, 31 May 2026 17:36:50 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: boris.brezillon@collabora.com, robh@kernel.org, steven.price@arm.com,
 adrian.larumbe@collabora.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 liviu.dudau@arm.com, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, alex@shazbot.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, jgg@ziepe.ca, kevin.tian@intel.com,
 baolu.lu@linux.intel.com, suravee.suthikulpanit@amd.com,
 dwmw2@infradead.org
Cc: xlpang@linux.alibaba.com, oliver.yang@linux.alibaba.com,
 shiyu.zsq@linux.alibaba.com, wei.guo.simon@linux.alibaba.com
Subject: [PATCH 4/9] iommu/arm-smmu: implement iova_to_phys_length
Date: Sun, 31 May 2026 17:36:32 +0800
Message-ID: <20260531093637.3893199-5-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260531093637.3893199-1-guanghuifeng@linux.alibaba.com>
References: <20260529115116.GR2487554@ziepe.ca>
 <20260531093637.3893199-1-guanghuifeng@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 31 May 2026 13:58:32 +0000
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

Migrate ARM SMMU drivers to implement iova_to_phys_length, calling
ops->iova_to_phys_length on the io-pgtable layer to get both phys
and PTE page size.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Acked-by: Shiqiang Zhang <shiyu.zsq@linux.alibaba.com>
Acked-by: Simon Guo <wei.guo.simon@linux.alibaba.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c      | 10 +++++++---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c |  2 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.c            | 13 ++++++++-----
 drivers/iommu/arm/arm-smmu/qcom_iommu.c          | 11 +++++++----
 4 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index e8d7dbe495f0..c9f356c75bc5 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4069,14 +4069,18 @@ static void arm_smmu_iotlb_sync(struct iommu_domain *domain,
 }
 
 static phys_addr_t
-arm_smmu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
+arm_smmu_iova_to_phys_length(struct iommu_domain *domain, dma_addr_t iova,
+			     size_t *mapped_length)
 {
 	struct io_pgtable_ops *ops = to_smmu_domain(domain)->pgtbl_ops;
 
+	if (mapped_length)
+		*mapped_length = 0;
+
 	if (!ops)
 		return 0;
 
-	return ops->iova_to_phys(ops, iova);
+	return ops->iova_to_phys_length(ops, iova, mapped_length);
 }
 
 static struct platform_driver arm_smmu_driver;
@@ -4396,7 +4400,7 @@ static const struct iommu_ops arm_smmu_ops = {
 		.unmap_pages		= arm_smmu_unmap_pages,
 		.flush_iotlb_all	= arm_smmu_flush_iotlb_all,
 		.iotlb_sync		= arm_smmu_iotlb_sync,
-		.iova_to_phys		= arm_smmu_iova_to_phys,
+		.iova_to_phys_length	= arm_smmu_iova_to_phys_length,
 		.free			= arm_smmu_domain_free_paging,
 	}
 };
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
index 0bd21d206eb3..e29e0ea12f24 100644
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
@@ -1384,12 +1384,15 @@ static phys_addr_t arm_smmu_iova_to_phys_hard(struct iommu_domain *domain,
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
 		return 0;
 
@@ -1397,7 +1400,7 @@ static phys_addr_t arm_smmu_iova_to_phys(struct iommu_domain *domain,
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
diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index a1e8cf29f594..08bb6fce992f 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -489,19 +489,22 @@ static void qcom_iommu_iotlb_sync(struct iommu_domain *domain,
 	qcom_iommu_flush_iotlb_all(domain);
 }
 
-static phys_addr_t qcom_iommu_iova_to_phys(struct iommu_domain *domain,
-					   dma_addr_t iova)
+static phys_addr_t qcom_iommu_iova_to_phys_length(struct iommu_domain *domain,
+					   dma_addr_t iova, size_t *mapped_length)
 {
 	phys_addr_t ret;
 	unsigned long flags;
 	struct qcom_iommu_domain *qcom_domain = to_qcom_iommu_domain(domain);
 	struct io_pgtable_ops *ops = qcom_domain->pgtbl_ops;
 
+	if (mapped_length)
+		*mapped_length = 0;
+
 	if (!ops)
 		return 0;
 
 	spin_lock_irqsave(&qcom_domain->pgtbl_lock, flags);
-	ret = ops->iova_to_phys(ops, iova);
+	ret = ops->iova_to_phys_length(ops, iova, mapped_length);
 	spin_unlock_irqrestore(&qcom_domain->pgtbl_lock, flags);
 
 	return ret;
@@ -602,7 +605,7 @@ static const struct iommu_ops qcom_iommu_ops = {
 		.unmap_pages	= qcom_iommu_unmap,
 		.flush_iotlb_all = qcom_iommu_flush_iotlb_all,
 		.iotlb_sync	= qcom_iommu_iotlb_sync,
-		.iova_to_phys	= qcom_iommu_iova_to_phys,
+		.iova_to_phys_length = qcom_iommu_iova_to_phys_length,
 		.free		= qcom_iommu_domain_free,
 	}
 };
-- 
2.43.7

