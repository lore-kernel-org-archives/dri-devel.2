Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400DE6070327
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 21:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Gx0UBUWe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7634B10E412;
	Wed,  4 Nov 2026 21:52:52 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31BEA10E071;
 Wed,  4 Nov 2026 21:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793829167; x=1825365167;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qZ2OSlZ8Vef1JDtEvDv3/FAu98FD0cZfznCaHt7yv4o=;
 b=Gx0UBUWeHtUIkFA2CMumXKvy9L2RTItmH62nROOivg5eatqbaL2EhgbU
 I+hb8HL+t/lyiJ+tG0TpCG0i2kLA+IOsmrzdV6NhS3R1C6CjRk5UqHwaS
 /WBGz5JuYWMv1sa4BYa6XGxQ+aUu8w8f4dvEO7sdzrEprwmScfFUvZQgT
 BHhfoIe7eqkvzYdqA7BPwetuyCwfeboqiYQmYpnbYI396Jwa8MWYHUj8g
 ejU7Ze3iG+vZUuDZqKau/8GmgagqKHKTg+qeGLLuA7fapBhoFGBXUjsI2
 07qV4BYyfmyp6jh7g7q3QOpi/VNjJPDMMipImtm8zbw64A81aLhKtZqYe A==;
X-CSE-ConnectionGUID: rW/E9mODRouNpOwWTwILnA==
X-CSE-MsgGUID: 38Mm0TKnSBOgMICMraOq+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2477176"
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="2477176"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 13:52:36 -0800
X-CSE-ConnectionGUID: tiE3e56vSHiRyasgtWmDGg==
X-CSE-MsgGUID: VRo31C/2SRKY1W2DVo/jMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="8689461"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 13:52:36 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Subject: [PATCH 2/2] drm/xe: Add debugfs stats for DMA-mapped pages per order
Date: Wed,  4 Nov 2026 13:52:28 -0800
Message-Id: <20261104215228.1533692-2-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261104215228.1533692-1-matthew.brost@intel.com>
References: <20261104215228.1533692-1-matthew.brost@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Thomas Hellström <thomas.hellstrom@linux.intel.com>

Expose per-page-order DMA mapping counts for the system memory that the
xe driver maps for GPU access, split into two categories: TTM buffer
objects, and the GPU SVM / userptr ranges (which share a single
drm_gpusvm instance per VM).

The stats are visible at:

  <debugfs>/dri/<N>/dma_mapped_pages

and are broken out into two rows (bo, svm/userptr), one column per page
order, mirroring the layout of the TTM pool page_pool stat.

For TTM BOs the per-order counts are derived from the DMA scatter-gather
table: each mapped segment is physically contiguous, so its page count is
split into the largest power-of-two runs (a segment of N pages contributes
a 2^k chunk for the largest k with 2^k <= N, repeated for the remainder).
Driving the accounting off the sg table rather than the pages[] array keeps
it correct even when pages[] entries are cleared while still DMA-mapped,
as happens on the defrag page-borrowing path. Dma-buf BOs are not
accounted for in dma_mapped_pages stats.

For the SVM and userptr ranges the accounting is driven by the
drm_gpusvm @dma_map_account callback, which fires once per dma_addr[]
entry at the exact point the entry is DMA-mapped and unmapped. This
makes the accounting symmetric by construction and avoids driver-side
walks that could drift across migration, partial unmaps and the iova vs
non-iova paths. Only DRM_INTERCONNECT_SYSTEM entries are real DMA maps
and counted; device interconnect (VRAM, P2P) entries are skipped, so the
counter reflects only system pages actually mapped through the DMA layer.

The callback is shared between the full SVM instance (fault mode) and the
core drm_gpusvm_pages-only instance used for userptr, so userptr
mappings are accounted in both the CONFIG_DRM_XE_GPUSVM=y and =n (but
CONFIG_DRM_GPUSVM=y) configurations, into the same svm/userptr counter.

Since the counts are only ever consumed through debugfs, gate the counter
storage and all accounting on CONFIG_DEBUG_FS so that builds without
debugfs carry no extra atomic traffic or device state; the drm_gpusvm
callback is simply left unregistered in that case.

On device teardown assert that every counter has returned to zero, to
catch any unbalanced accounting (a leaked DMA mapping) during testing.

Assisted-by: LLM
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/xe/xe_bo.c           | 53 ++++++++++++++++++++---
 drivers/gpu/drm/xe/xe_debugfs.c      | 26 ++++++++++++
 drivers/gpu/drm/xe/xe_device.c       | 30 +++++++++++++
 drivers/gpu/drm/xe/xe_device_types.h | 17 ++++++++
 drivers/gpu/drm/xe/xe_svm.c          | 44 ++++++++++++++++++-
 drivers/gpu/drm/xe/xe_svm.h          |  4 +-
 drivers/gpu/drm/xe/xe_userptr.c      | 63 ++++++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_userptr.h      |  1 +
 8 files changed, 230 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 42a6aa1a2e4a..a8031cb9c74f 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -396,6 +396,50 @@ struct xe_ttm_tt {
 	bool purgeable;
 };
 
+/*
+ * xe_tt_account_dma_pages - account DMA-mapped tt pages per order
+ * @xe: the xe device
+ * @xe_tt: the xe_ttm_tt whose sg table to walk
+ * @sign: +1 to add, -1 to subtract
+ *
+ * Walk the tt's DMA scatter-gather table and split each (physically
+ * contiguous) segment into the largest power-of-two page runs: a segment of N
+ * pages contributes a 2^k chunk for the largest k with 2^k <= N, repeated for
+ * the remainder. Accumulate the count of 2^k pages into
+ * xe->mem.dma_mapped_pages[k]. Driving this off the sg table rather than
+ * tt->pages keeps the accounting correct even when pages[] entries are cleared
+ * while still DMA-mapped (e.g. the defrag page-borrowing path).
+ */
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+static void xe_tt_account_dma_pages(struct xe_device *xe,
+				    struct xe_ttm_tt *xe_tt, int sign)
+{
+	struct scatterlist *sg;
+	unsigned int i;
+
+	for_each_sgtable_sg(xe_tt->sg, sg, i) {
+		unsigned long nr_pages = sg->length >> PAGE_SHIFT;
+
+		while (nr_pages) {
+			unsigned int order = min_t(unsigned int,
+						   __fls(nr_pages),
+						   MAX_PAGE_ORDER);
+			unsigned long chunk = 1UL << order;
+
+			atomic_long_add((long)chunk * sign,
+					&xe->mem.dma_mapped_pages[order]);
+
+			nr_pages -= chunk;
+		}
+	}
+}
+#else
+static void xe_tt_account_dma_pages(struct xe_device *xe,
+				    struct xe_ttm_tt *xe_tt, int sign)
+{
+}
+#endif
+
 static int xe_tt_map_sg(struct xe_device *xe, struct ttm_tt *tt)
 {
 	struct xe_ttm_tt *xe_tt = container_of(tt, struct xe_ttm_tt, ttm);
@@ -425,6 +469,7 @@ static int xe_tt_map_sg(struct xe_device *xe, struct ttm_tt *tt)
 		return ret;
 	}
 
+	xe_tt_account_dma_pages(xe, xe_tt, 1);
 	return 0;
 }
 
@@ -433,6 +478,7 @@ static void xe_tt_unmap_sg(struct xe_device *xe, struct ttm_tt *tt)
 	struct xe_ttm_tt *xe_tt = container_of(tt, struct xe_ttm_tt, ttm);
 
 	if (xe_tt->sg) {
+		xe_tt_account_dma_pages(xe, xe_tt, -1);
 		dma_unmap_sgtable(xe->drm.dev, xe_tt->sg,
 				  DMA_BIDIRECTIONAL, 0);
 		sg_free_table(xe_tt->sg);
@@ -1800,11 +1846,8 @@ int xe_bo_dma_unmap_pinned(struct xe_bo *bo)
 			ttm_bo->sg = NULL;
 			xe_tt->sg = NULL;
 		} else if (xe_tt->sg) {
-			dma_unmap_sgtable(ttm_to_xe_device(ttm_bo->bdev)->drm.dev,
-					  xe_tt->sg,
-					  DMA_BIDIRECTIONAL, 0);
-			sg_free_table(xe_tt->sg);
-			xe_tt->sg = NULL;
+			xe_tt_unmap_sg(ttm_to_xe_device(ttm_bo->bdev),
+				       &xe_tt->ttm);
 		}
 	}
 
diff --git a/drivers/gpu/drm/xe/xe_debugfs.c b/drivers/gpu/drm/xe/xe_debugfs.c
index e59d4964d811..1a306b6523e7 100644
--- a/drivers/gpu/drm/xe/xe_debugfs.c
+++ b/drivers/gpu/drm/xe/xe_debugfs.c
@@ -7,6 +7,7 @@
 
 #include <linux/bits.h>
 #include <linux/debugfs.h>
+#include <linux/mmzone.h>
 #include <linux/fault-inject.h>
 #include <linux/string_helpers.h>
 
@@ -345,6 +346,28 @@ static int dgfx_pcie_link_residencies_show(struct seq_file *m, void *data)
 	return 0;
 }
 
+static int dma_mapped_pages_show(struct seq_file *m, void *data)
+{
+	struct xe_device *xe = m->private;
+	unsigned int i;
+
+	seq_printf(m, "%-11s ", "");
+	for (i = 0; i < NR_PAGE_ORDERS; i++)
+		seq_printf(m, " ---%2u---", i);
+	seq_printf(m, "\n%-11s:", "bo");
+	for (i = 0; i < NR_PAGE_ORDERS; i++)
+		seq_printf(m, " %8lu",
+			   atomic_long_read(&xe->mem.dma_mapped_pages[i]));
+	seq_printf(m, "\n%-11s:", "svm/userptr");
+	for (i = 0; i < NR_PAGE_ORDERS; i++)
+		seq_printf(m, " %8lu",
+			   atomic_long_read(&xe->mem.dma_mapped_pages_svm[i]));
+	seq_puts(m, "\n");
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(dma_mapped_pages);
+
 static const struct drm_info_list debugfs_list[] = {
 	{"info", info, 0},
 	{ .name = "sriov_info", .show = sriov_info, },
@@ -765,6 +788,9 @@ void xe_debugfs_register(struct xe_device *xe)
 
 	xe_ttm_vram_debugfs_init(xe, root);
 
+	debugfs_create_file("dma_mapped_pages", 0444, root, xe,
+			    &dma_mapped_pages_fops);
+
 	for_each_tile(tile, xe, tile_id)
 		xe_tile_debugfs_register(tile);
 
diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index 273e2c45fea9..c40bb8f7c697 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -377,12 +377,42 @@ bool xe_device_is_admin_only(const struct xe_device *xe)
 /* Number of allocated struct xe_device */
 static atomic_t xe_device_count;
 
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+static void xe_device_assert_dma_pages_zero(struct xe_device *xe)
+{
+	unsigned int i;
+
+	/*
+	 * All BOs, userptr VMAs and SVM ranges must have been torn down by the
+	 * time the device is destroyed, so every DMA-mapped-pages counter must
+	 * have returned to zero. A non-zero value indicates unbalanced
+	 * accounting, i.e. a missing unmap-side decrement.
+	 */
+	for (i = 0; i < NR_PAGE_ORDERS; i++) {
+		xe_assert(xe, !atomic_long_read(&xe->mem.dma_mapped_pages[i]));
+		xe_assert(xe, !atomic_long_read(&xe->mem.dma_mapped_pages_svm[i]));
+	}
+}
+#else
+static void xe_device_assert_dma_pages_zero(struct xe_device *xe)
+{
+}
+#endif
+
 static void xe_device_destroy(struct drm_device *dev, void *dummy)
 {
 	struct xe_device *xe = to_xe_device(dev);
 
 	xe_bo_dev_fini(&xe->bo_device);
 
+	/*
+	 * Assert the DMA-mapped-pages accounting only after xe_bo_dev_fini()
+	 * has flushed the async BO-free worker: BOs pending async free still
+	 * hold their DMA mappings (and counts) until the worker runs, so
+	 * asserting before the flush could trip a false positive.
+	 */
+	xe_device_assert_dma_pages_zero(xe);
+
 	if (xe->preempt_fence_wq)
 		destroy_workqueue(xe->preempt_fence_wq);
 
diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index d99881c6e1d5..e816db751da4 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -6,6 +6,7 @@
 #ifndef _XE_DEVICE_TYPES_H_
 #define _XE_DEVICE_TYPES_H_
 
+#include <linux/mmzone.h>
 #include <linux/pci.h>
 
 #include <drm/drm_device.h>
@@ -302,6 +303,22 @@ struct xe_device {
 		struct xe_shrinker *shrinker;
 		/** @mem.stolen_mgr: stolen memory manager. */
 		struct xe_ttm_stolen_mgr *stolen_mgr;
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+		/**
+		 * @mem.dma_mapped_pages: number of DMA-mapped pages per page
+		 * order currently live for this device, for TTM BOs. Only
+		 * accounted when CONFIG_DEBUG_FS is enabled, since it is solely
+		 * exposed through debugfs.
+		 */
+		atomic_long_t dma_mapped_pages[NR_PAGE_ORDERS];
+		/**
+		 * @mem.dma_mapped_pages_svm: number of DMA-mapped pages per
+		 * page order currently live for this device, for SVM ranges
+		 * and userptr VMAs (both share a single drm_gpusvm instance).
+		 * Only accounted when CONFIG_DEBUG_FS is enabled.
+		 */
+		atomic_long_t dma_mapped_pages_svm[NR_PAGE_ORDERS];
+#endif
 	} mem;
 
 	/** @sriov: device level virtualization data */
diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
index 909a602d091e..7a4988289749 100644
--- a/drivers/gpu/drm/xe/xe_svm.c
+++ b/drivers/gpu/drm/xe/xe_svm.c
@@ -845,10 +845,50 @@ static int xe_svm_get_pagemaps(struct xe_vm *vm)
 }
 #endif
 
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+/*
+ * xe_svm_dma_map_account - drm_gpusvm DMA-mapping accounting callback
+ * @gpusvm: The GPU SVM the mapping belongs to
+ * @addr: The address descriptor of the chunk being (un)mapped
+ * @sign: +1 when @addr was DMA-mapped, -1 when it is being unmapped
+ *
+ * Maintain per-order counts of the system-memory pages that the full SVM
+ * instance (SVM ranges, and userptr VMAs in fault mode) has DMA-mapped for GPU
+ * access. Only DRM_INTERCONNECT_SYSTEM entries are real DMA maps and counted;
+ * device interconnect (VRAM, P2P) entries are skipped. The counts are solely
+ * exposed through debugfs, so the callback is only registered when
+ * CONFIG_DEBUG_FS is enabled.
+ */
+static void xe_svm_dma_map_account(struct drm_gpusvm *gpusvm,
+				   const struct drm_pagemap_addr *addr,
+				   int sign)
+{
+	struct xe_device *xe = gpusvm_to_vm(gpusvm)->xe;
+	unsigned int order = addr->order;
+
+	if (addr->proto != DRM_INTERCONNECT_SYSTEM)
+		return;
+
+	/*
+	 * The CPU-PTE map order reported by hmm can exceed MAX_PAGE_ORDER
+	 * (e.g. an order-18 1GB mapping), so clamp the array index to avoid an
+	 * out-of-bounds access. Clamping is symmetric across the +1/-1 calls,
+	 * so the per-order counters stay balanced.
+	 */
+	order = min(order, (unsigned int)NR_PAGE_ORDERS - 1);
+
+	atomic_long_add((long)(1UL << addr->order) * sign,
+			&xe->mem.dma_mapped_pages_svm[order]);
+}
+#endif
+
 static const struct drm_gpusvm_ops gpusvm_ops = {
 	.range_alloc = xe_svm_range_alloc,
 	.range_free = xe_svm_range_free,
 	.invalidate = xe_svm_invalidate,
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+	.dma_map_account = xe_svm_dma_map_account,
+#endif
 };
 
 static const unsigned long fault_chunk_sizes[] = {
@@ -946,8 +986,8 @@ int xe_svm_init(struct xe_vm *vm)
 		}
 	} else {
 		err = drm_gpusvm_init(&vm->svm.gpusvm, "Xe SVM (simple)",
-				      NULL, 0, 0, 0, NULL,
-				      NULL, 0);
+				      NULL, 0, 0, 0,
+				      xe_userptr_gpusvm_ops_get(), NULL, 0);
 		if (err)
 			goto out_err;
 	}
diff --git a/drivers/gpu/drm/xe/xe_svm.h b/drivers/gpu/drm/xe/xe_svm.h
index ffc1cc808102..f8b908a74ba9 100644
--- a/drivers/gpu/drm/xe/xe_svm.h
+++ b/drivers/gpu/drm/xe/xe_svm.h
@@ -249,6 +249,7 @@ struct drm_pagemap *xe_drm_pagemap_from_fd(int fd, u32 region_instance);
 
 #else
 #include <linux/interval_tree.h>
+#include "xe_userptr.h"
 #include "xe_vm.h"
 
 struct drm_pagemap_addr;
@@ -296,7 +297,8 @@ int xe_svm_init(struct xe_vm *vm)
 {
 #if IS_ENABLED(CONFIG_DRM_GPUSVM)
 	return drm_gpusvm_init(&vm->svm.gpusvm, "Xe SVM (simple)",
-			       NULL, 0, 0, 0, NULL, NULL, 0);
+			       NULL, 0, 0, 0,
+			       xe_userptr_gpusvm_ops_get(), NULL, 0);
 #else
 	return 0;
 #endif
diff --git a/drivers/gpu/drm/xe/xe_userptr.c b/drivers/gpu/drm/xe/xe_userptr.c
index 9c1dac0fce6f..40f97bd4751d 100644
--- a/drivers/gpu/drm/xe/xe_userptr.c
+++ b/drivers/gpu/drm/xe/xe_userptr.c
@@ -8,9 +8,72 @@
 
 #include <linux/mm.h>
 
+#include <drm/drm_pagemap.h>
+
 #include "xe_tlb_inval.h"
 #include "xe_trace_bo.h"
 
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+/*
+ * xe_userptr_dma_map_account - drm_gpusvm DMA-mapping accounting callback
+ * @gpusvm: The GPU SVM the mapping belongs to
+ * @addr: The address descriptor of the chunk being (un)mapped
+ * @sign: +1 when @addr was DMA-mapped, -1 when it is being unmapped
+ *
+ * Account, per page order, the system-memory pages DMA-mapped for GPU access
+ * through the drm_gpusvm_pages instance shared by userptr (and, in fault mode,
+ * SVM). Only DRM_INTERCONNECT_SYSTEM entries are real DMA maps and counted;
+ * device interconnect (VRAM, P2P) entries are skipped. The counts are solely
+ * exposed through debugfs, so the callback is only registered when
+ * CONFIG_DEBUG_FS is enabled.
+ */
+static void xe_userptr_dma_map_account(struct drm_gpusvm *gpusvm,
+				       const struct drm_pagemap_addr *addr,
+				       int sign)
+{
+	struct xe_vm *vm = container_of(gpusvm, struct xe_vm, svm.gpusvm);
+	unsigned int order = addr->order;
+
+	if (addr->proto != DRM_INTERCONNECT_SYSTEM)
+		return;
+
+	/*
+	 * The CPU-PTE map order reported by hmm can exceed MAX_PAGE_ORDER
+	 * (e.g. an order-18 1GB mapping), so clamp the array index to avoid an
+	 * out-of-bounds access. Clamping is symmetric across the +1/-1 calls,
+	 * so the per-order counters stay balanced.
+	 */
+	order = min(order, (unsigned int)NR_PAGE_ORDERS - 1);
+
+	atomic_long_add((long)(1UL << addr->order) * sign,
+			&vm->xe->mem.dma_mapped_pages_svm[order]);
+}
+
+static const struct drm_gpusvm_ops xe_userptr_gpusvm_ops = {
+	.dma_map_account = xe_userptr_dma_map_account,
+};
+#endif
+
+/**
+ * xe_userptr_gpusvm_ops_get() - Accounting ops for the simple gpusvm instance
+ *
+ * The core drm_gpusvm_pages-only instance used for userptr (and, in fault
+ * mode, shared with SVM) is initialised with these ops so that DMA-mapped
+ * system pages are accounted and exposed through debugfs. Returns NULL when
+ * CONFIG_DEBUG_FS is disabled, in which case no accounting is kept and the
+ * instance is initialised without ops.
+ *
+ * Return: Pointer to the restricted &drm_gpusvm_ops, or NULL.
+ */
+const struct drm_gpusvm_ops *xe_userptr_gpusvm_ops_get(void)
+{
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+	return &xe_userptr_gpusvm_ops;
+#else
+	return NULL;
+#endif
+}
+
 static void xe_userptr_assert_in_notifier(struct xe_vm *vm)
 {
 	lockdep_assert(lockdep_is_held_type(&vm->svm.gpusvm.notifier_lock, 0) ||
diff --git a/drivers/gpu/drm/xe/xe_userptr.h b/drivers/gpu/drm/xe/xe_userptr.h
index 2a3cd1b5efbb..1e9601be5713 100644
--- a/drivers/gpu/drm/xe/xe_userptr.h
+++ b/drivers/gpu/drm/xe/xe_userptr.h
@@ -108,6 +108,7 @@ int __xe_vm_userptr_needs_repin(struct xe_vm *vm);
 int xe_vm_userptr_check_repin(struct xe_vm *vm);
 int xe_vma_userptr_pin_pages(struct xe_userptr_vma *uvma);
 int xe_vma_userptr_check_repin(struct xe_userptr_vma *uvma);
+const struct drm_gpusvm_ops *xe_userptr_gpusvm_ops_get(void);
 #else
 static inline void xe_userptr_remove(struct xe_userptr_vma *uvma) {}
 
-- 
2.34.1

