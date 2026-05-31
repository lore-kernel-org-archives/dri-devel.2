Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27EBDCD6E5D
	for <dri-devel@archiver.kernel.org>; Sun, 31 May 2026 13:59:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6E28112B68;
	Sun, 31 May 2026 13:59:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="T1pSDEP8";
	dkim-atps=neutral
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFA1D10E5C0
 for <dri-devel@lists.freedesktop.org>; Sun, 31 May 2026 09:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1780220511; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=BqI3wj50bY1yFeJVxmRBlmJ+T2V4ZAm9w/2StB4gVpI=;
 b=T1pSDEP85eJ8m6zq5RYj/k220k/DxPzy4lgJMV14cfLd1MQPpH0OFTHsdy5Z7SnbWXR0Ikq8dI+eHv9KYyUbXft1uCamRLy5PH+t3ZxCjZ6e5Bweat4/meou4rwMl/5ZeBWQ6WMg5KIBgwgRNQgLGnHM4ikoJauHqEoSsVk+v4E=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R471e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam011083073210;
 MF=guanghuifeng@linux.alibaba.com; NM=1; PH=DS; RN=27; SR=0;
 TI=SMTPD_---0X3tRVoG_1780220206; 
Received: from
 VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com
 fp:SMTPD_---0X3tRVoG_1780220206 cluster:ay36) by smtp.aliyun-inc.com;
 Sun, 31 May 2026 17:36:47 +0800
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
Subject: [PATCH 1/9] iommu: introduce iova_to_phys_length in iommu_domain_ops
Date: Sun, 31 May 2026 17:36:29 +0800
Message-ID: <20260531093637.3893199-2-guanghuifeng@linux.alibaba.com>
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

Add iova_to_phys_length callback to struct iommu_domain_ops alongside
the existing iova_to_phys. The new callback returns both the physical
address and the PTE mapping page size in a single page table walk.

Add iommu_iova_to_phys_length() core function that:
- Checks ops->iova_to_phys_length first (preferred path)
- Falls back to ops->iova_to_phys for unmigrated drivers

This enables callers like VFIO to efficiently traverse IOVA space
by actual mapping granularity instead of fixed PAGE_SIZE steps.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Acked-by: Shiqiang Zhang <shiyu.zsq@linux.alibaba.com>
Acked-by: Simon Guo <wei.guo.simon@linux.alibaba.com>
---
 drivers/iommu/iommu.c | 34 ++++++++++++++++++++++++++++++++--
 include/linux/iommu.h |  9 +++++++++
 2 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d1a9e713d3a0..43323229a1df 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2545,15 +2545,45 @@ void iommu_detach_group(struct iommu_domain *domain, struct iommu_group *group)
 }
 EXPORT_SYMBOL_GPL(iommu_detach_group);
 
-phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
+/**
+ * iommu_iova_to_phys_length - Translate IOVA and return mapping page size
+ * @domain: IOMMU domain to query
+ * @iova: IO virtual address to translate
+ * @mapped_length: Output parameter for the PTE page size (e.g. 4KB/2MB/1GB)
+ *
+ * Like iommu_iova_to_phys() but additionally returns the page size of the
+ * PTE mapping at @iova through @mapped_length.
+ *
+ * Return: The physical address for the given IOVA, or 0 if no translation.
+ */
+phys_addr_t iommu_iova_to_phys_length(struct iommu_domain *domain,
+				       dma_addr_t iova,
+				       size_t *mapped_length)
 {
+	if (mapped_length)
+		*mapped_length = 0;
+
 	if (domain->type == IOMMU_DOMAIN_IDENTITY)
 		return iova;
 
 	if (domain->type == IOMMU_DOMAIN_BLOCKED)
 		return 0;
 
-	return domain->ops->iova_to_phys(domain, iova);
+	if (domain->ops->iova_to_phys_length)
+		return domain->ops->iova_to_phys_length(domain, iova,
+							mapped_length);
+
+	/* Fallback to legacy iova_to_phys without length info */
+	if (domain->ops->iova_to_phys)
+		return domain->ops->iova_to_phys(domain, iova);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iommu_iova_to_phys_length);
+
+phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
+{
+	return iommu_iova_to_phys_length(domain, iova, NULL);
 }
 EXPORT_SYMBOL_GPL(iommu_iova_to_phys);
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index e587d4ac4d33..19da84c2922c 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -747,6 +747,9 @@ struct iommu_ops {
  *                         invalidation requests. The driver data structure
  *                         must be defined in include/uapi/linux/iommufd.h
  * @iova_to_phys: translate iova to physical address
+ * @iova_to_phys_length: translate iova to physical address and additionally
+ *                       return the page size of the PTE mapping at @iova
+ *                       through @mapped_length.
  * @enforce_cache_coherency: Prevent any kind of DMA from bypassing IOMMU_CACHE,
  *                           including no-snoop TLPs on PCIe or other platform
  *                           specific mechanisms.
@@ -776,6 +779,9 @@ struct iommu_domain_ops {
 
 	phys_addr_t (*iova_to_phys)(struct iommu_domain *domain,
 				    dma_addr_t iova);
+	phys_addr_t (*iova_to_phys_length)(struct iommu_domain *domain,
+					    dma_addr_t iova,
+					    size_t *mapped_length);
 
 	bool (*enforce_cache_coherency)(struct iommu_domain *domain);
 	int (*set_pgtable_quirks)(struct iommu_domain *domain,
@@ -930,6 +936,9 @@ extern ssize_t iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
 			    struct scatterlist *sg, unsigned int nents,
 			    int prot, gfp_t gfp);
 extern phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova);
+extern phys_addr_t iommu_iova_to_phys_length(struct iommu_domain *domain,
+					      dma_addr_t iova,
+					      size_t *mapped_length);
 extern void iommu_set_fault_handler(struct iommu_domain *domain,
 			iommu_fault_handler_t handler, void *token);
 
-- 
2.43.7

