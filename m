Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B027110F997C
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 20:15:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EB2610E12F;
	Wed,  8 Apr 2026 20:15:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="boT5w+8c";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BCE510E0AB;
 Wed,  8 Apr 2026 20:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775679345; x=1807215345;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CJ7mip8ySPRr8YXN1vu1UPVHbFgshw6EcihFI3kF6oU=;
 b=boT5w+8ciejSee6cCdGj/+YbKPX8U+g42e+VeMak/6ye8pdcM/JUhmH1
 PtukZ4jUq9rC26onT2WxIh+ss7zmBc9S7KBodqvnpqesYSsT6Wss6pj0E
 LLTqz7owG+a00NvR9p/bXNMCoBhkv9gCkmOEC4u8leK5/qj6dwV+S6QZK
 4fmdSZUoilMUR86x5RLDUnp1giMQw2ZF9Ez/H9nsHMXcOym5sp5bPNQg+
 bcH+gsidtEmcIe8lO6fSdtT0xUhi5bkJYMzIYIZFpsBVOfMMOPstToiH9
 Hp4ifSwMBRbMXe1GBBgoNfM+b05vG7femE/C1LbwJ3UBkgtP6cZ0NUjI5 A==;
X-CSE-ConnectionGUID: 2Eg4tT2pR5iXGwco87ph6Q==
X-CSE-MsgGUID: PO47lqHqRi6EmQNuKq/eaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="94063723"
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; d="scan'208";a="94063723"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 13:15:44 -0700
X-CSE-ConnectionGUID: z/k5EwzrTYG2j0W+dPCW6g==
X-CSE-MsgGUID: rpDOiYQwQHOUzPxw2qiZKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; d="scan'208";a="228451013"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 13:15:44 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 francois.dugast@intel.com
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Subject: [PATCH v6 1/5] drm/gpusvm: Use dma-map IOVA alloc, link,
 and sync API in GPU SVM
Date: Wed,  8 Apr 2026 13:15:33 -0700
Message-Id: <20260408201537.3580549-2-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260408201537.3580549-1-matthew.brost@intel.com>
References: <20260408201537.3580549-1-matthew.brost@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Use the IOVA alloc, link, and sync APIs for GPU SVM, which create DMA
mappings between the CPU and GPU.

Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/drm_gpusvm.c | 55 ++++++++++++++++++++++++++++++------
 include/drm/drm_gpusvm.h     |  5 ++++
 2 files changed, 52 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
index 7993e85c0566..00744e3f72a7 100644
--- a/drivers/gpu/drm/drm_gpusvm.c
+++ b/drivers/gpu/drm/drm_gpusvm.c
@@ -1144,11 +1144,19 @@ static void __drm_gpusvm_unmap_pages(struct drm_gpusvm *gpusvm,
 		struct drm_gpusvm_pages_flags flags = {
 			.__flags = svm_pages->flags.__flags,
 		};
+		bool use_iova = dma_use_iova(&svm_pages->state);
+
+		if (use_iova) {
+			dma_iova_unlink(dev, &svm_pages->state, 0,
+					svm_pages->state_offset,
+					svm_pages->dma_addr[0].dir, 0);
+			dma_iova_free(dev, &svm_pages->state);
+		}
 
 		for (i = 0, j = 0; i < npages; j++) {
 			struct drm_pagemap_addr *addr = &svm_pages->dma_addr[j];
 
-			if (addr->proto == DRM_INTERCONNECT_SYSTEM)
+			if (!use_iova && addr->proto == DRM_INTERCONNECT_SYSTEM)
 				dma_unmap_page(dev,
 					       addr->addr,
 					       PAGE_SIZE << addr->order,
@@ -1413,6 +1421,7 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 	struct drm_gpusvm_pages_flags flags;
 	enum dma_data_direction dma_dir = ctx->read_only ? DMA_TO_DEVICE :
 							   DMA_BIDIRECTIONAL;
+	struct dma_iova_state *state = &svm_pages->state;
 
 retry:
 	if (time_after(jiffies, timeout))
@@ -1451,6 +1460,9 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 	if (err)
 		goto err_free;
 
+	*state = (struct dma_iova_state){};
+	svm_pages->state_offset = 0;
+
 map_pages:
 	/*
 	 * Perform all dma mappings under the notifier lock to not
@@ -1544,13 +1556,33 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 				goto err_unmap;
 			}
 
-			addr = dma_map_page(gpusvm->drm->dev,
-					    page, 0,
-					    PAGE_SIZE << order,
-					    dma_dir);
-			if (dma_mapping_error(gpusvm->drm->dev, addr)) {
-				err = -EFAULT;
-				goto err_unmap;
+			if (!i)
+				dma_iova_try_alloc(gpusvm->drm->dev, state,
+						   npages * PAGE_SIZE >=
+						   HPAGE_PMD_SIZE ?
+						   HPAGE_PMD_SIZE : 0,
+						   npages * PAGE_SIZE);
+
+			if (dma_use_iova(state)) {
+				err = dma_iova_link(gpusvm->drm->dev, state,
+						    hmm_pfn_to_phys(pfns[i]),
+						    svm_pages->state_offset,
+						    PAGE_SIZE << order,
+						    dma_dir, 0);
+				if (err)
+					goto err_unmap;
+
+				addr = state->addr + svm_pages->state_offset;
+				svm_pages->state_offset += PAGE_SIZE << order;
+			} else {
+				addr = dma_map_page(gpusvm->drm->dev,
+						    page, 0,
+						    PAGE_SIZE << order,
+						    dma_dir);
+				if (dma_mapping_error(gpusvm->drm->dev, addr)) {
+					err = -EFAULT;
+					goto err_unmap;
+				}
 			}
 
 			svm_pages->dma_addr[j] = drm_pagemap_addr_encode
@@ -1562,6 +1594,13 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 		flags.has_dma_mapping = true;
 	}
 
+	if (dma_use_iova(state)) {
+		err = dma_iova_sync(gpusvm->drm->dev, state, 0,
+				    svm_pages->state_offset);
+		if (err)
+			goto err_unmap;
+	}
+
 	if (pagemap) {
 		flags.has_devmem_pages = true;
 		drm_pagemap_get(dpagemap);
diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h
index 2578ac92a8d4..cd94bb2ee6ee 100644
--- a/include/drm/drm_gpusvm.h
+++ b/include/drm/drm_gpusvm.h
@@ -6,6 +6,7 @@
 #ifndef __DRM_GPUSVM_H__
 #define __DRM_GPUSVM_H__
 
+#include <linux/dma-mapping.h>
 #include <linux/kref.h>
 #include <linux/interval_tree.h>
 #include <linux/mmu_notifier.h>
@@ -136,6 +137,8 @@ struct drm_gpusvm_pages_flags {
  * @dma_addr: Device address array
  * @dpagemap: The struct drm_pagemap of the device pages we're dma-mapping.
  *            Note this is assuming only one drm_pagemap per range is allowed.
+ * @state: DMA IOVA state for mapping.
+ * @state_offset: DMA IOVA offset for mapping.
  * @notifier_seq: Notifier sequence number of the range's pages
  * @flags: Flags for range
  * @flags.migrate_devmem: Flag indicating whether the range can be migrated to device memory
@@ -147,6 +150,8 @@ struct drm_gpusvm_pages_flags {
 struct drm_gpusvm_pages {
 	struct drm_pagemap_addr *dma_addr;
 	struct drm_pagemap *dpagemap;
+	struct dma_iova_state state;
+	unsigned long state_offset;
 	unsigned long notifier_seq;
 	struct drm_gpusvm_pages_flags flags;
 };
-- 
2.34.1

