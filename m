Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C1D8CD6E55
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 15:19:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2ED810FFFE;
	Wed,  3 Jun 2026 15:19:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VG1+aTII";
	dkim-atps=neutral
Received: from out30-111.freemail.mail.aliyun.com
 (out30-111.freemail.mail.aliyun.com [115.124.30.111])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D033110FFF4
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 15:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1780499953; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=z2Kf6oWvFzK2XhYhSCFrdVJy4nHOxnzI3msx6A4kv/w=;
 b=VG1+aTIISjUeCLgYsDD3IYjcTBSgiQofCwgeFW1hIW0z/YKQrq6hl0KBAkoMGhA25WQjExPD6+Kv3BvNPYxxshSq8h3S7c8hFLhDpj93gOl5aChI3MymA3zrLjdRoa1ZSSHpVC7yff1mD98dXIYxZMwff4TiOsp/atY1kJfCysg=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037026112;
 MF=guanghuifeng@linux.alibaba.com; NM=1; PH=DS; RN=28; SR=0;
 TI=SMTPD_---0X47fR8q_1780499950; 
Received: from
 VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com
 fp:SMTPD_---0X47fR8q_1780499950 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 03 Jun 2026 23:19:10 +0800
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
Subject: [PATCH v3 32/32] iommu: remove iova_to_phys from domain_ops and
 io_pgtable_ops
Date: Wed,  3 Jun 2026 23:18:04 +0800
Message-ID: <20260603151804.1963871-33-guanghuifeng@linux.alibaba.com>
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

Now that all drivers implement iova_to_phys_length and all callers
have migrated, remove the deprecated interfaces:

- Remove .iova_to_phys from struct iommu_domain_ops
- Remove .iova_to_phys from struct io_pgtable_ops
- Remove fallback path in iommu_iova_to_phys_length()
- iommu_iova_to_phys() remains as a thin wrapper calling _length with NULL

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/iommu/iommu.c      | 16 ++--------------
 include/linux/io-pgtable.h | 12 +++++-------
 include/linux/iommu.h      |  3 ---
 3 files changed, 7 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 320ea13488e7..1ad4787925cd 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2561,8 +2561,6 @@ phys_addr_t iommu_iova_to_phys_length(struct iommu_domain *domain,
 				       dma_addr_t iova,
 				       size_t *mapped_length)
 {
-	phys_addr_t phys;
-
 	if (domain->type == IOMMU_DOMAIN_IDENTITY) {
 		if (mapped_length)
 			*mapped_length = PAGE_SIZE;
@@ -2572,20 +2570,10 @@ phys_addr_t iommu_iova_to_phys_length(struct iommu_domain *domain,
 	if (mapped_length)
 		*mapped_length = 0;
 
-	if (domain->ops->iova_to_phys_length)
-		return domain->ops->iova_to_phys_length(domain, iova, mapped_length);
-
-	/* Fallback to legacy iova_to_phys without length info */
-	if (!domain->ops->iova_to_phys)
+	if (!domain->ops->iova_to_phys_length)
 		return PHYS_ADDR_MAX;
 
-	phys = domain->ops->iova_to_phys(domain, iova);
-	if (!phys)
-		return PHYS_ADDR_MAX;
-
-	if (mapped_length)
-		*mapped_length = PAGE_SIZE;
-	return phys;
+	return domain->ops->iova_to_phys_length(domain, iova, mapped_length);
 }
 EXPORT_SYMBOL_GPL(iommu_iova_to_phys_length);
 
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index 42bcdd309b88..ea7e473146e4 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -202,11 +202,11 @@ struct arm_lpae_io_pgtable_walk_data {
  *
  * @map_pages:    Map a physically contiguous range of pages of the same size.
  * @unmap_pages:  Unmap a range of virtually contiguous pages of the same size.
- * @iova_to_phys: Translate iova to physical address.
- * @iova_to_phys_length: Translate iova to physical address and return the
- *			  remaining mapped length from iova to the end of the
- *			  mapping entry via @mapped_length. If @mapped_length is
- *			  NULL, only the physical address is returned.
+ * @iova_to_phys_length: Translate iova to physical address and return, via
+ *			  @mapped_length, the full size of the mapping entry
+ *			  that covers @iova (e.g. 4KB/2MB/1GB). If
+ *			  @mapped_length is NULL, only the physical address
+ *			  is returned.
  * @pgtable_walk: (optional) Perform a page table walk for a given iova.
  * @read_and_clear_dirty: Record dirty info per IOVA. If an IOVA is dirty,
  *			  clear its dirty state from the PTE unless the
@@ -222,8 +222,6 @@ struct io_pgtable_ops {
 	size_t (*unmap_pages)(struct io_pgtable_ops *ops, unsigned long iova,
 			      size_t pgsize, size_t pgcount,
 			      struct iommu_iotlb_gather *gather);
-	phys_addr_t (*iova_to_phys)(struct io_pgtable_ops *ops,
-				    unsigned long iova);
 	phys_addr_t (*iova_to_phys_length)(struct io_pgtable_ops *ops,
 					   unsigned long iova,
 					   size_t *mapped_length);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 19da84c2922c..ca585647180b 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -746,7 +746,6 @@ struct iommu_ops {
  *                         array->entry_num to report the number of handled
  *                         invalidation requests. The driver data structure
  *                         must be defined in include/uapi/linux/iommufd.h
- * @iova_to_phys: translate iova to physical address
  * @iova_to_phys_length: translate iova to physical address and additionally
  *                       return the page size of the PTE mapping at @iova
  *                       through @mapped_length.
@@ -777,8 +776,6 @@ struct iommu_domain_ops {
 	int (*cache_invalidate_user)(struct iommu_domain *domain,
 				     struct iommu_user_data_array *array);
 
-	phys_addr_t (*iova_to_phys)(struct iommu_domain *domain,
-				    dma_addr_t iova);
 	phys_addr_t (*iova_to_phys_length)(struct iommu_domain *domain,
 					    dma_addr_t iova,
 					    size_t *mapped_length);
-- 
2.43.7

