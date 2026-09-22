Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C34BDC98302
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 10:18:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCBA710EC33;
	Tue, 22 Sep 2026 10:18:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Aue95WKQ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E126210E47C;
 Tue, 22 Sep 2026 10:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790072271; x=1821608271;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MK1mvf6xNtyYREVj3kuGdMLVIlxhKmmIEr2WE5DpKts=;
 b=Aue95WKQHrYVhPIdMYHV17zC/dUkv4hPcBGhhQv8jPqvKpo4afUt/z0C
 yhByxYl9ZZ42TXPi7zD8GyrPRM5y2lQJ6e8omRLwNMX4IWHXJ7SM0BaXr
 UB8PKTp4l+ZEDvh4Hputypq3FKzrg4whDr3e00wVQ0xqHtBrdqq6SSb2r
 u2c0BqNID7fRPtOadIni1iRLvItNtQZTUrWUG864i/ii6MLtxFYH/95MC
 X1FyGTOjTPcOdC6r2eppKOKTpgxOA6IOKGccUgtJf28alrrdEIleVjDLK
 OazykdkkEZztQxjdhjy0+eMCwKDgtm6+wCXtZXoqhXstk5RpErwaeZm77 w==;
X-CSE-ConnectionGUID: LN069DSeRcepRmXZG8MZPA==
X-CSE-MsgGUID: QDfbxluHSqCrLCn5pQbWqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="101322803"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="101322803"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 03:17:48 -0700
X-CSE-ConnectionGUID: SRNNDT+WS3WF+yj+hmpdaA==
X-CSE-MsgGUID: cnrrCUNgTC6ZI1T2vMLdcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="299307812"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 03:17:46 -0700
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: matthew.brost@intel.com, himal.prasad.ghimiray@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com
Subject: [PATCH v2 06/15] drm/xe: Stop VM work when device I/O is blocked
Date: Tue, 22 Sep 2026 15:46:51 +0530
Message-ID: <20260922101721.1583542-7-arvind.yadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922101721.1583542-1-arvind.yadav@intel.com>
References: <20260922101721.1583542-1-arvind.yadav@intel.com>
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

SVM fault handling and VM rebind work may still run when PCI error
recovery starts or the device becomes permanently wedged. This work can
validate BOs, update page tables or submit migration work after device
I/O has been blocked.

Stop SVM fault handling, pagemap population, device-memory copies and
preempt rebind work when device I/O is blocked.

v2:
 - Protect VM and SVM hardware access with the common SRCU gate (Thomas)
 - Hold the gate across page-fault, migration and rebind work.
 - Remove the racy device state checks (Matt)

Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>

 drm/xe: Stop VM work when device I/O is blocked
---
 drivers/gpu/drm/xe/xe_svm.c | 29 +++++++++++++++++++++++++----
 drivers/gpu/drm/xe/xe_vm.c  | 11 +++++++++--
 2 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
index f39e647512ad..4788216546ff 100644
--- a/drivers/gpu/drm/xe/xe_svm.c
+++ b/drivers/gpu/drm/xe/xe_svm.c
@@ -11,6 +11,7 @@
 #include <drm/drm_pagemap_util.h>
 
 #include "xe_bo.h"
+#include "xe_device.h"
 #include "xe_exec_queue_types.h"
 #include "xe_gt_stats.h"
 #include "xe_log.h"
@@ -242,6 +243,7 @@ static void xe_svm_invalidate(struct drm_gpusvm *gpusvm,
 	ktime_t start = xe_gt_stats_ktime_get();
 	u64 adj_start = mmu_range->start, adj_end = mmu_range->end;
 	u8 tile_mask = 0, id;
+	int io_idx;
 	long err;
 
 	xe_svm_assert_in_notifier(vm);
@@ -267,6 +269,9 @@ static void xe_svm_invalidate(struct drm_gpusvm *gpusvm,
 	if (xe_vm_is_closed(vm))
 		goto range_notifier_event_end;
 
+	if (xe_device_io_get(xe, &io_idx))
+		goto range_notifier_event_end;
+
 	/*
 	 * XXX: Less than ideal to always wait on VM's resv slots if an
 	 * invalidation is not required. Could walk range list twice to figure
@@ -283,7 +288,7 @@ static void xe_svm_invalidate(struct drm_gpusvm *gpusvm,
 							       &adj_start,
 							       &adj_end);
 	if (!tile_mask)
-		goto range_notifier_event_end;
+		goto out_io;
 
 	xe_device_wmb(xe);
 
@@ -292,6 +297,9 @@ static void xe_svm_invalidate(struct drm_gpusvm *gpusvm,
 	if (!WARN_ON_ONCE(err))
 		xe_tlb_inval_batch_wait(&batch);
 
+out_io:
+	xe_device_io_put(io_idx);
+
 range_notifier_event_end:
 	r = first;
 	drm_gpusvm_for_each_range(r, notifier, adj_start, adj_end)
@@ -599,6 +607,8 @@ static int xe_svm_copy(struct page **pages,
 #define XE_VRAM_ADDR_INVALID	~0x0ull
 	u64 vram_addr = XE_VRAM_ADDR_INVALID;
 	int err = 0, pos = 0;
+	bool io_held = false;
+	int io_idx;
 	bool sram = dir == XE_SVM_COPY_TO_SRAM;
 	ktime_t start = xe_gt_stats_ktime_get();
 
@@ -629,6 +639,12 @@ static int xe_svm_copy(struct page **pages,
 			vr = xe_page_to_vr(spage);
 			gt = xe_migrate_exec_queue(vr->migrate)->gt;
 			xe = vr->xe;
+
+			err = xe_device_io_get(xe, &io_idx);
+			if (err)
+				goto err_out;
+
+			io_held = true;
 		}
 		XE_WARN_ON(spage && xe_page_to_vr(spage) != vr);
 
@@ -749,6 +765,9 @@ static int xe_svm_copy(struct page **pages,
 	if (pre_migrate_fence)
 		dma_fence_wait(pre_migrate_fence, false);
 
+	if (io_held)
+		xe_device_io_put(io_idx);
+
 	/*
 	 * XXX: We can't derive the GT here (or anywhere in this functions, but
 	 * compute always uses the primary GT so accumulate stats on the likely
@@ -1123,8 +1142,9 @@ static int xe_drm_pagemap_populate_mm(struct drm_pagemap *dpagemap,
 	struct xe_bo *bo;
 	int err = 0, idx;
 
-	if (!drm_dev_enter(&xe->drm, &idx))
-		return -ENODEV;
+	err = xe_device_io_get(xe, &idx);
+	if (err)
+		return err;
 
 	xe_pm_runtime_get(xe);
 
@@ -1166,7 +1186,8 @@ static int xe_drm_pagemap_populate_mm(struct drm_pagemap *dpagemap,
 		xe_bo_put(bo);
 	}
 	xe_pm_runtime_put(xe);
-	drm_dev_exit(idx);
+
+	xe_device_io_put(idx);
 
 	return err;
 }
diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 17dc4debe7c1..565d2ce91829 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -483,6 +483,7 @@ static void preempt_rebind_work_func(struct work_struct *w)
 	unsigned int fence_count = 0;
 	LIST_HEAD(preempt_fences);
 	int err = 0;
+	int io_idx;
 	long wait;
 	int __maybe_unused tries = 0;
 
@@ -516,6 +517,12 @@ static void preempt_rebind_work_func(struct work_struct *w)
 	if (err)
 		goto out_unlock_outer;
 
+	if (xe_device_io_get(vm->xe, &io_idx)) {
+		xe_validation_ctx_fini(&ctx);
+		err = 0;
+		goto out_unlock_outer;
+	}
+
 	drm_exec_until_all_locked(&exec) {
 		bool done = false;
 
@@ -523,8 +530,7 @@ static void preempt_rebind_work_func(struct work_struct *w)
 		drm_exec_retry_on_contention(&exec);
 		xe_validation_retry_on_oom(&ctx, &err);
 		if (err || done) {
-			xe_validation_ctx_fini(&ctx);
-			goto out_unlock_outer;
+			goto out_unlock;
 		}
 	}
 
@@ -572,6 +578,7 @@ static void preempt_rebind_work_func(struct work_struct *w)
 
 out_unlock:
 	xe_validation_ctx_fini(&ctx);
+	xe_device_io_put(io_idx);
 out_unlock_outer:
 	if (err == -EAGAIN) {
 		trace_xe_vm_rebind_worker_retry(vm);
-- 
2.43.0

