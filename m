Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42CB910F9968
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 20:15:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DDCF10E17C;
	Wed,  8 Apr 2026 20:15:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="DTsJIUIx";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26E3910E092;
 Wed,  8 Apr 2026 20:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775679345; x=1807215345;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=aygaCYAExa8prpUfmcHlYxyU405lNM6CqMVwA2t84As=;
 b=DTsJIUIxPLhBSJ/7cTDobOviDXs2OtihhZAo6iadOau0s9QLuGZ26OMI
 JTy70ocfvEHadVvU9PjTElE1Kwpho0AbtpwSwYu4/Qf4QbKJf98eaAik+
 mVqzrvXwzEbsDEmdN2eAbQkeiFDTp03zsc42kE5JVMIbSgijCT3s+ZVcQ
 WSOPahKnaJq8ncAH5QISLyp2qbzh301eFUKyceyvC+XT+aHeg1mOoGfVS
 F2wsWcv1tjzHRmAile4MqNcot5dWXpa43ToMOhDbM4BFvq714+ltrrOJL
 NqLA+c49LkdXXGgenB1zoNndw9qLtu2OIQIFN21LwXYArvPS9QCbJ8hDz Q==;
X-CSE-ConnectionGUID: uJ5ArM6XSOy0bIL17VdSgg==
X-CSE-MsgGUID: r645+YlrQ9OT+MFvL8m6+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="94063727"
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; d="scan'208";a="94063727"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 13:15:44 -0700
X-CSE-ConnectionGUID: 8YwGr1gnSQa1Rayb9fu49A==
X-CSE-MsgGUID: ZFV6ISwGTN2AelIWroyfgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; d="scan'208";a="228451021"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 13:15:44 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 francois.dugast@intel.com
Subject: [PATCH v6 4/5] drm/pagemap: Use dma-map IOVA alloc, link,
 and sync API for DRM pagemap
Date: Wed,  8 Apr 2026 13:15:36 -0700
Message-Id: <20260408201537.3580549-5-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260408201537.3580549-1-matthew.brost@intel.com>
References: <20260408201537.3580549-1-matthew.brost@intel.com>
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

The dma-map IOVA alloc, link, and sync APIs perform significantly better
than dma-map / dma-unmap, as they avoid costly IOMMU synchronizations.
This difference is especially noticeable when mapping a 2MB region in
4KB pages.

Use the IOVA alloc, link, and sync APIs for DRM pagemap, which create DMA
mappings between the CPU and GPU for copying data.

Signed-off-by: Matthew Brost <matthew.brost@intel.com>

---
v6: Fix drm_pagemap_migrate_map_system_pages kernel doc (Francois)
---
 drivers/gpu/drm/drm_pagemap.c | 85 ++++++++++++++++++++++++++++-------
 1 file changed, 70 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
index ee4d9f90bf67..ed62866b52f6 100644
--- a/drivers/gpu/drm/drm_pagemap.c
+++ b/drivers/gpu/drm/drm_pagemap.c
@@ -291,6 +291,19 @@ drm_pagemap_migrate_map_device_private_pages(struct device *dev,
 	return 0;
 }
 
+/**
+ * struct drm_pagemap_iova_state - DRM pagemap IOVA state
+ * @dma_state: DMA IOVA state.
+ * @offset: Current offset in IOVA.
+ *
+ * This structure acts as an iterator for packing all IOVA addresses within a
+ * contiguous range.
+ */
+struct drm_pagemap_iova_state {
+	struct dma_iova_state dma_state;
+	unsigned long offset;
+};
+
 /**
  * drm_pagemap_migrate_map_system_pages() - Map system or device coherent
  * migration pages for GPU SVM migration
@@ -299,22 +312,25 @@ drm_pagemap_migrate_map_device_private_pages(struct device *dev,
  * @migrate_pfn: Array of page frame numbers of system pages or peer pages to map.
  * @npages: Number of system or device coherent pages to map.
  * @dir: Direction of data transfer (e.g., DMA_BIDIRECTIONAL)
+ * @state: DMA IOVA state for mapping.
  *
  * This function maps pages of memory for migration usage in GPU SVM. It
  * iterates over each page frame number provided in @migrate_pfn, maps the
  * corresponding page, and stores the DMA address in the provided @dma_addr
  * array.
  *
- * Returns: 0 on success, -EFAULT if an error occurs during mapping.
+ * Returns: 0 on success, negative error code on failure.
  */
 static int
 drm_pagemap_migrate_map_system_pages(struct device *dev,
 				     struct drm_pagemap_addr *pagemap_addr,
 				     unsigned long *migrate_pfn,
 				     unsigned long npages,
-				     enum dma_data_direction dir)
+				     enum dma_data_direction dir,
+				     struct drm_pagemap_iova_state *state)
 {
 	unsigned long i;
+	bool try_alloc = false;
 
 	for (i = 0; i < npages;) {
 		struct page *page = migrate_pfn_to_page(migrate_pfn[i]);
@@ -329,9 +345,31 @@ drm_pagemap_migrate_map_system_pages(struct device *dev,
 		folio = page_folio(page);
 		order = folio_order(folio);
 
-		dma_addr = dma_map_page(dev, page, 0, page_size(page), dir);
-		if (dma_mapping_error(dev, dma_addr))
-			return -EFAULT;
+		if (!try_alloc) {
+			dma_iova_try_alloc(dev, &state->dma_state,
+					   (npages - i) * PAGE_SIZE >=
+					   HPAGE_PMD_SIZE ?
+					   HPAGE_PMD_SIZE : 0,
+					   npages * PAGE_SIZE);
+			try_alloc = true;
+		}
+
+		if (dma_use_iova(&state->dma_state)) {
+			int err = dma_iova_link(dev, &state->dma_state,
+						page_to_phys(page),
+						state->offset, page_size(page),
+						dir, 0);
+			if (err)
+				return err;
+
+			dma_addr = state->dma_state.addr + state->offset;
+			state->offset += page_size(page);
+		} else {
+			dma_addr = dma_map_page(dev, page, 0, page_size(page),
+						dir);
+			if (dma_mapping_error(dev, dma_addr))
+				return -EFAULT;
+		}
 
 		pagemap_addr[i] =
 			drm_pagemap_addr_encode(dma_addr,
@@ -342,6 +380,9 @@ drm_pagemap_migrate_map_system_pages(struct device *dev,
 		i += NR_PAGES(order);
 	}
 
+	if (dma_use_iova(&state->dma_state))
+		return dma_iova_sync(dev, &state->dma_state, 0, state->offset);
+
 	return 0;
 }
 
@@ -353,6 +394,7 @@ drm_pagemap_migrate_map_system_pages(struct device *dev,
  * @pagemap_addr: Array of DMA information corresponding to mapped pages
  * @npages: Number of pages to unmap
  * @dir: Direction of data transfer (e.g., DMA_BIDIRECTIONAL)
+ * @state: DMA IOVA state for mapping.
  *
  * This function unmaps previously mapped pages of memory for GPU Shared Virtual
  * Memory (SVM). It iterates over each DMA address provided in @dma_addr, checks
@@ -362,10 +404,17 @@ static void drm_pagemap_migrate_unmap_pages(struct device *dev,
 					    struct drm_pagemap_addr *pagemap_addr,
 					    unsigned long *migrate_pfn,
 					    unsigned long npages,
-					    enum dma_data_direction dir)
+					    enum dma_data_direction dir,
+					    struct drm_pagemap_iova_state *state)
 {
 	unsigned long i;
 
+	if (state && dma_use_iova(&state->dma_state)) {
+		dma_iova_unlink(dev, &state->dma_state, 0, state->offset, dir, 0);
+		dma_iova_free(dev, &state->dma_state);
+		return;
+	}
+
 	for (i = 0; i < npages;) {
 		struct page *page = migrate_pfn_to_page(migrate_pfn[i]);
 
@@ -420,7 +469,7 @@ drm_pagemap_migrate_remote_to_local(struct drm_pagemap_devmem *devmem,
 			       devmem->pre_migrate_fence);
 out:
 	drm_pagemap_migrate_unmap_pages(remote_device, pagemap_addr, local_pfns,
-					npages, DMA_FROM_DEVICE);
+					npages, DMA_FROM_DEVICE, NULL);
 	return err;
 }
 
@@ -430,11 +479,13 @@ drm_pagemap_migrate_sys_to_dev(struct drm_pagemap_devmem *devmem,
 			       struct page *local_pages[],
 			       struct drm_pagemap_addr pagemap_addr[],
 			       unsigned long npages,
-			       const struct drm_pagemap_devmem_ops *ops)
+			       const struct drm_pagemap_devmem_ops *ops,
+			       struct drm_pagemap_iova_state *state)
 {
 	int err = drm_pagemap_migrate_map_system_pages(devmem->dev,
 						       pagemap_addr, sys_pfns,
-						       npages, DMA_TO_DEVICE);
+						       npages, DMA_TO_DEVICE,
+						       state);
 
 	if (err)
 		goto out;
@@ -443,7 +494,7 @@ drm_pagemap_migrate_sys_to_dev(struct drm_pagemap_devmem *devmem,
 				  devmem->pre_migrate_fence);
 out:
 	drm_pagemap_migrate_unmap_pages(devmem->dev, pagemap_addr, sys_pfns, npages,
-					DMA_TO_DEVICE);
+					DMA_TO_DEVICE, state);
 	return err;
 }
 
@@ -471,6 +522,7 @@ static int drm_pagemap_migrate_range(struct drm_pagemap_devmem *devmem,
 				     const struct migrate_range_loc *cur,
 				     const struct drm_pagemap_migrate_details *mdetails)
 {
+	struct drm_pagemap_iova_state state = {};
 	int ret = 0;
 
 	if (cur->start == 0)
@@ -498,7 +550,7 @@ static int drm_pagemap_migrate_range(struct drm_pagemap_devmem *devmem,
 						     &pages[last->start],
 						     &pagemap_addr[last->start],
 						     cur->start - last->start,
-						     last->ops);
+						     last->ops, &state);
 
 out:
 	*last = *cur;
@@ -1060,6 +1112,7 @@ EXPORT_SYMBOL(drm_pagemap_put);
 int drm_pagemap_evict_to_ram(struct drm_pagemap_devmem *devmem_allocation)
 {
 	const struct drm_pagemap_devmem_ops *ops = devmem_allocation->ops;
+	struct drm_pagemap_iova_state state = {};
 	unsigned long npages, mpages = 0;
 	struct page **pages;
 	unsigned long *src, *dst;
@@ -1101,7 +1154,7 @@ int drm_pagemap_evict_to_ram(struct drm_pagemap_devmem *devmem_allocation)
 	err = drm_pagemap_migrate_map_system_pages(devmem_allocation->dev,
 						   pagemap_addr,
 						   dst, npages,
-						   DMA_FROM_DEVICE);
+						   DMA_FROM_DEVICE, &state);
 	if (err)
 		goto err_finalize;
 
@@ -1125,7 +1178,7 @@ int drm_pagemap_evict_to_ram(struct drm_pagemap_devmem *devmem_allocation)
 	migrate_device_pages(src, dst, npages);
 	migrate_device_finalize(src, dst, npages);
 	drm_pagemap_migrate_unmap_pages(devmem_allocation->dev, pagemap_addr, dst, npages,
-					DMA_FROM_DEVICE);
+					DMA_FROM_DEVICE, &state);
 
 err_free:
 	kvfree(buf);
@@ -1170,6 +1223,7 @@ static int __drm_pagemap_migrate_to_ram(struct vm_area_struct *vas,
 				  MIGRATE_VMA_SELECT_COMPOUND,
 		.fault_page	= page,
 	};
+	struct drm_pagemap_iova_state state = {};
 	struct drm_pagemap_zdd *zdd;
 	const struct drm_pagemap_devmem_ops *ops;
 	struct device *dev = NULL;
@@ -1229,7 +1283,7 @@ static int __drm_pagemap_migrate_to_ram(struct vm_area_struct *vas,
 
 	err = drm_pagemap_migrate_map_system_pages(dev, pagemap_addr,
 						   migrate.dst, npages,
-						   DMA_FROM_DEVICE);
+						   DMA_FROM_DEVICE, &state);
 	if (err)
 		goto err_finalize;
 
@@ -1254,7 +1308,8 @@ static int __drm_pagemap_migrate_to_ram(struct vm_area_struct *vas,
 	migrate_vma_finalize(&migrate);
 	if (dev)
 		drm_pagemap_migrate_unmap_pages(dev, pagemap_addr, migrate.dst,
-						npages, DMA_FROM_DEVICE);
+						npages, DMA_FROM_DEVICE,
+						&state);
 err_free:
 	kvfree(buf);
 err_out:
-- 
2.34.1

