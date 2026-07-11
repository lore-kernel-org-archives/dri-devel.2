Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C796C4450F
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 02:56:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D34510E2E6;
	Sat, 11 Jul 2026 02:56:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="A4HGH2S1";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8297C10E2B3;
 Sat, 11 Jul 2026 02:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783738589; x=1815274589;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=oONWfXcGN7dykszZMF3s5GrFoyW5itcyTj2Wj+JGar4=;
 b=A4HGH2S1gRqrqnrpynlUiCvMqn7qNRO1XXBfpfhtuh8elsTTSDFF+w2d
 uTkD6TsOCsk5lTnursjfyA/DXSFuA++ESTyRCY+qCUtSHRQsQ8VN+SjgM
 YGvXh3bSYPNktRILPpbOH7TIQkc7n5VlRXLlBytcwY9LqcA0zxrntaXf0
 +wn7wPWZ7ZNW9yVIijzLVmjowTN6ylWt4tCH35K4kHA+4CRiVBuGoxEej
 UwYH0jUijB0hR0AzJGzgbggTZE/OcF6tVMc7DXssV1HJdqCDMvdySBREb
 TCtAeuq/t3Mo3kPwNPME46k+mERjrdJLukCHkZ2iB1TfFIfmN4NPngWSe Q==;
X-CSE-ConnectionGUID: RRZbbqOWTqeUAou5tkyPpg==
X-CSE-MsgGUID: JNpkBOgRQvuPR/jmII4jSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="101986259"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="101986259"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 19:56:28 -0700
X-CSE-ConnectionGUID: A4vZywhMSXKA5BYxqQkmoQ==
X-CSE-MsgGUID: RNB1sH47RxefFxS3weIybw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="256987711"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 19:56:28 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Subject: [PATCH v3 12/33] drm/xe: Add debugfs stats for DMA-mapped pages per
 order
Date: Fri, 10 Jul 2026 19:55:58 -0700
Message-Id: <20260711025619.2540575-13-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260711025619.2540575-1-matthew.brost@intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
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
as happens on the defrag page-borrowing path.

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

Assisted-by: GitHub_Copilot:claude-opus-4.8
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>

---

v3:
 - Fix drm_gpusvm_init() argument order, clamp DMA-page order to
   NR_PAGE_ORDERS - 1, and drain DMA-page accounting after
   xe_bo_dev_fini() (Sashiko)
---
 drivers/gpu/drm/xe/xe_bo.c           | 46 ++++++++++++++++++++
 drivers/gpu/drm/xe/xe_debugfs.c      | 26 ++++++++++++
 drivers/gpu/drm/xe/xe_device.c       | 30 +++++++++++++
 drivers/gpu/drm/xe/xe_device_types.h | 17 ++++++++
 drivers/gpu/drm/xe/xe_svm.c          | 44 ++++++++++++++++++-
 drivers/gpu/drm/xe/xe_svm.h          |  4 +-
 drivers/gpu/drm/xe/xe_userptr.c      | 63 ++++++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_userptr.h      |  1 +
 8 files changed, 228 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 85e6d9a0f575..60e0e568aa31 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -367,6 +367,50 @@ struct xe_ttm_tt {
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
@@ -396,6 +440,7 @@ static int xe_tt_map_sg(struct xe_device *xe, struct ttm_tt *tt)
 		return ret;
 	}
 
+	xe_tt_account_dma_pages(xe, xe_tt, 1);
 	return 0;
 }
 
@@ -404,6 +449,7 @@ static void xe_tt_unmap_sg(struct xe_device *xe, struct ttm_tt *tt)
 	struct xe_ttm_tt *xe_tt = container_of(tt, struct xe_ttm_tt, ttm);
 
 	if (xe_tt->sg) {
+		xe_tt_account_dma_pages(xe, xe_tt, -1);
 		dma_unmap_sgtable(xe->drm.dev, xe_tt->sg,
 				  DMA_BIDIRECTIONAL, 0);
 		sg_free_table(xe_tt->sg);
diff --git a/drivers/gpu/drm/xe/xe_debugfs.c b/drivers/gpu/drm/xe/xe_debugfs.c
index 8c391c7b017a..97b47c5c4213 100644
--- a/drivers/gpu/drm/xe/xe_debugfs.c
+++ b/drivers/gpu/drm/xe/xe_debugfs.c
@@ -6,6 +6,7 @@
 #include "xe_debugfs.h"
 
 #include <linux/debugfs.h>
+#include <linux/mmzone.h>
 #include <linux/fault-inject.h>
 #include <linux/string_helpers.h>
 
@@ -231,6 +232,28 @@ static int dgfx_pcie_link_residencies_show(struct seq_file *m, void *data)
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
@@ -632,6 +655,9 @@ void xe_debugfs_register(struct xe_device *xe)
 	if (man)
 		ttm_resource_manager_create_debugfs(man, root, "stolen_mm");
 
+	debugfs_create_file("dma_mapped_pages", 0444, root, xe,
+			    &dma_mapped_pages_fops);
+
 	for_each_tile(tile, xe, tile_id)
 		xe_tile_debugfs_register(tile);
 
diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index ad7f3e61d457..97cc2d185e45 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -455,12 +455,42 @@ bool xe_device_is_admin_only(const struct xe_device *xe)
 }
 #endif
 
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
index 022e08205897..95e7cea91cbf 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -6,6 +6,7 @@
 #ifndef _XE_DEVICE_TYPES_H_
 #define _XE_DEVICE_TYPES_H_
 
+#include <linux/mmzone.h>
 #include <linux/pci.h>
 
 #include <drm/drm_device.h>
@@ -279,6 +280,22 @@ struct xe_device {
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
index b228a737cfd6..ebe48cb76ad9 100644
--- a/drivers/gpu/drm/xe/xe_svm.c
+++ b/drivers/gpu/drm/xe/xe_svm.c
@@ -827,10 +827,50 @@ static int xe_svm_get_pagemaps(struct xe_vm *vm)
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
@@ -925,8 +965,8 @@ int xe_svm_init(struct xe_vm *vm)
 		}
 	} else {
 		err = drm_gpusvm_init(&vm->svm.gpusvm, "Xe SVM (simple)",
-				      NULL, 0, 0, 0, NULL,
-				      NULL, 0);
+				      NULL, 0, 0, 0,
+				      xe_userptr_gpusvm_ops_get(), NULL, 0);
 	}
 
 	return err;
diff --git a/drivers/gpu/drm/xe/xe_svm.h b/drivers/gpu/drm/xe/xe_svm.h
index a921556d3466..8e347137a7a6 100644
--- a/drivers/gpu/drm/xe/xe_svm.h
+++ b/drivers/gpu/drm/xe/xe_svm.h
@@ -194,6 +194,7 @@ struct drm_pagemap *xe_drm_pagemap_from_fd(int fd, u32 region_instance);
 
 #else
 #include <linux/interval_tree.h>
+#include "xe_userptr.h"
 #include "xe_vm.h"
 
 struct drm_pagemap_addr;
@@ -236,7 +237,8 @@ int xe_svm_init(struct xe_vm *vm)
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
index 8b2d461ea0b2..6b9e1530ead4 100644
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

