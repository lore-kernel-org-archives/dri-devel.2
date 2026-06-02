Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A514DCD6E64
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 10:47:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 272E510EECF;
	Tue,  2 Jun 2026 10:46:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OZx1uMVq";
	dkim-atps=neutral
Received: from out30-124.freemail.mail.aliyun.com
 (out30-124.freemail.mail.aliyun.com [115.124.30.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC51C10EECD
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 10:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1780397214; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=FC9R9YWoWnAD2vr8QBlJXcutq/kUNU/P6obcP1gCGZU=;
 b=OZx1uMVqe2pX2En1+uZWNwp08FER8otR9fxXVTRIIUfsHKrr7qRmri/Wc2oWqgBg41wjIEcufBjelRFKASdw2bpHUVle7Xu9Amv0MzKQbPJqYg/9VFfp9Q0tqJ4mL3tmO8zWnEmGQ0ONyL5818+wt9s0QSXPJ+8d9nGo8lP8HbE=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R551e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033032089153;
 MF=guanghuifeng@linux.alibaba.com; NM=1; PH=DS; RN=28; SR=0;
 TI=SMTPD_---0X44E93E_1780397212; 
Received: from
 VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com
 fp:SMTPD_---0X44E93E_1780397212 cluster:ay36) by smtp.aliyun-inc.com;
 Tue, 02 Jun 2026 18:46:52 +0800
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
Subject: [PATCH v2 05/30] iommu/generic_pt: implement iova_to_phys_length
Date: Tue,  2 Jun 2026 18:46:12 +0800
Message-ID: <20260602104637.1219810-6-guanghuifeng@linux.alibaba.com>
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

Extend the Generic Page Table framework to implement iova_to_phys_length.
Use pt_entry_oa_lg2sz() to determine PTE block size. Update
IOMMU_PT_DOMAIN_OPS macro to set .iova_to_phys_length.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Acked-by: Shiqiang Zhang <shiyu.zsq@linux.alibaba.com>
Acked-by: Simon Guo <wei.guo.simon@linux.alibaba.com>
---
 drivers/iommu/generic_pt/iommu_pt.h | 57 ++++++++++++++++++-----------
 include/linux/generic_pt/iommu.h    | 13 ++++---
 2 files changed, 42 insertions(+), 28 deletions(-)

diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
index dc91fb4e2f61..7563ca83061d 100644
--- a/drivers/iommu/generic_pt/iommu_pt.h
+++ b/drivers/iommu/generic_pt/iommu_pt.h
@@ -145,13 +145,18 @@ static inline unsigned int compute_best_pgsize(struct pt_state *pts,
 				      pts->range->va, pts->range->last_va, oa);
 }
 
-static __always_inline int __do_iova_to_phys(struct pt_range *range, void *arg,
-					     unsigned int level,
-					     struct pt_table_p *table,
-					     pt_level_fn_t descend_fn)
+struct iova_to_phys_length_data {
+	pt_oaddr_t phys;
+	size_t length;
+};
+
+static __always_inline int __do_iova_to_phys_length(struct pt_range *range,
+					       void *arg, unsigned int level,
+					       struct pt_table_p *table,
+					       pt_level_fn_t descend_fn)
 {
 	struct pt_state pts = pt_init(range, level, table);
-	pt_oaddr_t *res = arg;
+	struct iova_to_phys_length_data *data = arg;
 
 	switch (pt_load_single_entry(&pts)) {
 	case PT_ENTRY_EMPTY:
@@ -159,45 +164,53 @@ static __always_inline int __do_iova_to_phys(struct pt_range *range, void *arg,
 	case PT_ENTRY_TABLE:
 		return pt_descend(&pts, arg, descend_fn);
 	case PT_ENTRY_OA:
-		*res = pt_entry_oa_exact(&pts);
-		return 0;
+		break;
 	}
-	return -ENOENT;
+
+	data->phys = pt_entry_oa_exact(&pts);
+	data->length = log2_to_int(pt_entry_oa_lg2sz(&pts));
+
+	return 0;
 }
-PT_MAKE_LEVELS(__iova_to_phys, __do_iova_to_phys);
+PT_MAKE_LEVELS(__iova_to_phys_length, __do_iova_to_phys_length);
 
 /**
- * iova_to_phys() - Return the output address for the given IOVA
+ * iova_to_phys_length() - Translate IOVA returning both phys and page size
  * @domain: Table to query
  * @iova: IO virtual address to query
+ * @mapped_length: Output for the PTE page size in bytes
  *
- * Determine the output address from the given IOVA. @iova may have any
- * alignment, the returned physical will be adjusted with any sub page offset.
+ * Walk the IOMMU page table to translate @iova to a physical address while
+ * also returning the page size of the PTE entry through @mapped_length.
+ * This combines iova_to_phys and page size query into a single page table walk.
  *
  * Context: The caller must hold a read range lock that includes @iova.
  *
- * Return: 0 if there is no translation for the given iova.
+ * Return: The physical address, or PHYS_ADDR_MAX if there is no translation.
  */
-phys_addr_t DOMAIN_NS(iova_to_phys)(struct iommu_domain *domain,
-				    dma_addr_t iova)
+phys_addr_t DOMAIN_NS(iova_to_phys_length)(struct iommu_domain *domain,
+					    dma_addr_t iova,
+					    size_t *mapped_length)
 {
 	struct pt_iommu *iommu_table =
 		container_of(domain, struct pt_iommu, domain);
 	struct pt_range range;
-	pt_oaddr_t res;
+	struct iova_to_phys_length_data data;
 	int ret;
 
 	ret = make_range(common_from_iommu(iommu_table), &range, iova, 1);
 	if (ret)
-		return ret;
+		return PHYS_ADDR_MAX;
 
-	ret = pt_walk_range(&range, __iova_to_phys, &res);
-	/* PHYS_ADDR_MAX would be a better error code */
+	ret = pt_walk_range(&range, __iova_to_phys_length, &data);
 	if (ret)
-		return 0;
-	return res;
+		return PHYS_ADDR_MAX;
+
+	if (mapped_length)
+		*mapped_length = data.length;
+	return data.phys;
 }
-EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(iova_to_phys), "GENERIC_PT_IOMMU");
+EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(iova_to_phys_length), "GENERIC_PT_IOMMU");
 
 struct pt_iommu_dirty_args {
 	struct iommu_dirty_bitmap *dirty;
diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
index dd0edd02a48a..859b853e9dc7 100644
--- a/include/linux/generic_pt/iommu.h
+++ b/include/linux/generic_pt/iommu.h
@@ -249,8 +249,9 @@ struct pt_iommu_cfg {
 
 /* Generate the exported function signatures from iommu_pt.h */
 #define IOMMU_PROTOTYPES(fmt)                                                  \
-	phys_addr_t pt_iommu_##fmt##_iova_to_phys(struct iommu_domain *domain, \
-						  dma_addr_t iova);            \
+	phys_addr_t pt_iommu_##fmt##_iova_to_phys_length(			\
+		struct iommu_domain *domain, dma_addr_t iova,			\
+		size_t *mapped_length);						\
 	int pt_iommu_##fmt##_read_and_clear_dirty(                             \
 		struct iommu_domain *domain, unsigned long iova, size_t size,  \
 		unsigned long flags, struct iommu_dirty_bitmap *dirty);        \
@@ -267,11 +268,11 @@ struct pt_iommu_cfg {
 	IOMMU_PROTOTYPES(fmt)
 
 /*
- * A driver uses IOMMU_PT_DOMAIN_OPS to populate the iommu_domain_ops for the
- * iommu_pt
+ * A driver uses IOMMU_PT_DOMAIN_OPS to populate the iommu_domain_ops for
+ * the iommu_pt
  */
-#define IOMMU_PT_DOMAIN_OPS(fmt)                        \
-	.iova_to_phys = &pt_iommu_##fmt##_iova_to_phys
+#define IOMMU_PT_DOMAIN_OPS(fmt)					\
+	.iova_to_phys_length = &pt_iommu_##fmt##_iova_to_phys_length
 #define IOMMU_PT_DIRTY_OPS(fmt) \
 	.read_and_clear_dirty = &pt_iommu_##fmt##_read_and_clear_dirty
 
-- 
2.43.7

