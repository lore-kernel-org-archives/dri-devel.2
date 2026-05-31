Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA32CD6E5E
	for <dri-devel@archiver.kernel.org>; Sun, 31 May 2026 13:59:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CA68112B6F;
	Sun, 31 May 2026 13:59:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="V7whiK7N";
	dkim-atps=neutral
Received: from out30-98.freemail.mail.aliyun.com
 (out30-98.freemail.mail.aliyun.com [115.124.30.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABA5410E5B7
 for <dri-devel@lists.freedesktop.org>; Sun, 31 May 2026 09:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1780220519; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=4/Z+ZPm/plftxIVQEjNwZFqBQEqg7EIjfcS2GaMAQFU=;
 b=V7whiK7NxTeE9PmXfQ77t59b44yf9cCQjoCrX2W89RYfMKsKAf+CEDH2XR7Zl8uOURlQKFpeA73ack9/no1KydLFGXhpUU7GQHaNWHpCDx77496Mkf5tR0cL2QGHZf/14ISDWT9pIMcEO9c6bRuzxcj2KpRq9VzGD2m12AsJDII=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R331e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033032089153;
 MF=guanghuifeng@linux.alibaba.com; NM=1; PH=DS; RN=27; SR=0;
 TI=SMTPD_---0X3tRVrQ_1780220215; 
Received: from
 VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com
 fp:SMTPD_---0X3tRVrQ_1780220215 cluster:ay36) by smtp.aliyun-inc.com;
 Sun, 31 May 2026 17:36:55 +0800
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
Subject: [PATCH 9/9] iommu: remove deprecated iova_to_phys from domain_ops and
 io_pgtable_ops
Date: Sun, 31 May 2026 17:36:37 +0800
Message-ID: <20260531093637.3893199-10-guanghuifeng@linux.alibaba.com>
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

Now that all drivers implement iova_to_phys_length and all callers
have migrated, remove the deprecated interfaces:

- Remove .iova_to_phys from struct iommu_domain_ops
- Remove .iova_to_phys from struct io_pgtable_ops
- Remove fallback in iommu_iova_to_phys_length()
- Make iommu_iova_to_phys() a thin wrapper
- Remove old wrapper functions from io-pgtable implementations

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Acked-by: Shiqiang Zhang <shiyu.zsq@linux.alibaba.com>
Acked-by: Simon Guo <wei.guo.simon@linux.alibaba.com>
---
 drivers/iommu/io-pgtable-arm-v7s.c | 11 -----------
 drivers/iommu/io-pgtable-arm.c     | 11 -----------
 drivers/iommu/io-pgtable-dart.c    | 11 -----------
 drivers/iommu/iommu.c              |  4 ----
 include/linux/io-pgtable.h         |  3 ---
 include/linux/iommu.h              |  3 ---
 6 files changed, 43 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index 54e8cc673eb6..00c09710b01b 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -641,16 +641,6 @@ static size_t arm_v7s_unmap_pages(struct io_pgtable_ops *ops, unsigned long iova
 	return unmapped;
 }
 
-static phys_addr_t arm_v7s_iova_to_phys_length(struct io_pgtable_ops *ops,
-						unsigned long iova,
-						size_t *mapped_length);
-
-static phys_addr_t arm_v7s_iova_to_phys(struct io_pgtable_ops *ops,
-					unsigned long iova)
-{
-	return arm_v7s_iova_to_phys_length(ops, iova, NULL);
-}
-
 static phys_addr_t arm_v7s_iova_to_phys_length(struct io_pgtable_ops *ops,
 						unsigned long iova,
 						size_t *mapped_length)
@@ -730,7 +720,6 @@ static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
 	data->iop.ops = (struct io_pgtable_ops) {
 		.map_pages	= arm_v7s_map_pages,
 		.unmap_pages	= arm_v7s_unmap_pages,
-		.iova_to_phys	= arm_v7s_iova_to_phys,
 		.iova_to_phys_length	= arm_v7s_iova_to_phys_length,
 	};
 
diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index e2ea84669fbf..c7419f812e79 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -731,16 +731,6 @@ static int visit_iova_to_phys(struct io_pgtable_walk_data *walk_data, int lvl,
 	return 0;
 }
 
-static phys_addr_t arm_lpae_iova_to_phys_length(struct io_pgtable_ops *ops,
-						 unsigned long iova,
-						 size_t *mapped_length);
-
-static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
-					 unsigned long iova)
-{
-	return arm_lpae_iova_to_phys_length(ops, iova, NULL);
-}
-
 static phys_addr_t arm_lpae_iova_to_phys_length(struct io_pgtable_ops *ops,
 						 unsigned long iova,
 						 size_t *mapped_length)
@@ -963,7 +953,6 @@ arm_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg)
 	data->iop.ops = (struct io_pgtable_ops) {
 		.map_pages	= arm_lpae_map_pages,
 		.unmap_pages	= arm_lpae_unmap_pages,
-		.iova_to_phys	= arm_lpae_iova_to_phys,
 		.iova_to_phys_length	= arm_lpae_iova_to_phys_length,
 		.read_and_clear_dirty = arm_lpae_read_and_clear_dirty,
 		.pgtable_walk	= arm_lpae_pgtable_walk,
diff --git a/drivers/iommu/io-pgtable-dart.c b/drivers/iommu/io-pgtable-dart.c
index fa250f5d16ed..f71c04a4c15e 100644
--- a/drivers/iommu/io-pgtable-dart.c
+++ b/drivers/iommu/io-pgtable-dart.c
@@ -333,16 +333,6 @@ static size_t dart_unmap_pages(struct io_pgtable_ops *ops, unsigned long iova,
 	return i * pgsize;
 }
 
-static phys_addr_t dart_iova_to_phys_length(struct io_pgtable_ops *ops,
-					    unsigned long iova,
-					    size_t *mapped_length);
-
-static phys_addr_t dart_iova_to_phys(struct io_pgtable_ops *ops,
-				     unsigned long iova)
-{
-	return dart_iova_to_phys_length(ops, iova, NULL);
-}
-
 static phys_addr_t dart_iova_to_phys_length(struct io_pgtable_ops *ops,
 					    unsigned long iova,
 					    size_t *mapped_length)
@@ -414,7 +404,6 @@ dart_alloc_pgtable(struct io_pgtable_cfg *cfg)
 	data->iop.ops = (struct io_pgtable_ops) {
 		.map_pages		= dart_map_pages,
 		.unmap_pages		= dart_unmap_pages,
-		.iova_to_phys		= dart_iova_to_phys,
 		.iova_to_phys_length	= dart_iova_to_phys_length,
 	};
 
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 43323229a1df..df56635de39d 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2573,10 +2573,6 @@ phys_addr_t iommu_iova_to_phys_length(struct iommu_domain *domain,
 		return domain->ops->iova_to_phys_length(domain, iova,
 							mapped_length);
 
-	/* Fallback to legacy iova_to_phys without length info */
-	if (domain->ops->iova_to_phys)
-		return domain->ops->iova_to_phys(domain, iova);
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(iommu_iova_to_phys_length);
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index 42bcdd309b88..c595f5b51e61 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -202,7 +202,6 @@ struct arm_lpae_io_pgtable_walk_data {
  *
  * @map_pages:    Map a physically contiguous range of pages of the same size.
  * @unmap_pages:  Unmap a range of virtually contiguous pages of the same size.
- * @iova_to_phys: Translate iova to physical address.
  * @iova_to_phys_length: Translate iova to physical address and return the
  *			  remaining mapped length from iova to the end of the
  *			  mapping entry via @mapped_length. If @mapped_length is
@@ -222,8 +221,6 @@ struct io_pgtable_ops {
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

