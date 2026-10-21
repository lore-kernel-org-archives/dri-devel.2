Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E141D606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 10:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=koYSMOUN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DB9310FD30;
	Wed, 21 Oct 2026 10:04:13 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE2B010FD24;
 Wed, 21 Oct 2026 10:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792577034; x=1824113034;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=epuWW+RZ+gSklBnDYUYImYy3SDmKJJVA/HE/uewBN+E=;
 b=koYSMOUNM1gIUMlK2PGL/OXcAd78qj/8RkbVHvp+5gpeMRnj0PktZEH+
 1PMCyaFN01JzZgP4mMoFtgjiPQzt9JQA9rTCnwkkIEFKtmYFph9wzUf4A
 MFF7VrH2t1sy/8Ga7LU9fUsV9TQmsH9AhIvV+FHA/iBTipG8Sls4wPGDi
 JjDAwva0tgODNd6p1N/3VZwFwT7czbakdLvGryBDJMsZCanSUQcDyi2SH
 FpfOiUk7QvdcxZ/4hVXMjYUQ3cfs4tQIAIjrHRUfDoTIUHB/eFy4r8K9G
 79B1WJA2Ckvw0VM7OG3GkUC1YDHxQ2k583f9o99xVwS1MdwdCNbzJAga9 Q==;
X-CSE-ConnectionGUID: ayP7en9yS0aE/V+diz0pmA==
X-CSE-MsgGUID: OPihChWaTUyj3usnMBIhmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1290289"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1290289"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 03:03:54 -0700
X-CSE-ConnectionGUID: 0gpFKFmBQ2aYGm4LCuQKAQ==
X-CSE-MsgGUID: sv9ulJUqROaSXHadyFvZgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="3382082"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 03:03:51 -0700
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: matthew.brost@intel.com, himal.prasad.ghimiray@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com
Subject: [RFC v3 06/17] drm/xe: Stop VM work when device I/O is blocked
Date: Wed, 21 Oct 2026 15:33:07 +0530
Message-ID: <20261021100322.1014449-7-arvind.yadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021100322.1014449-1-arvind.yadav@intel.com>
References: <20261021100322.1014449-1-arvind.yadav@intel.com>
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

v3:
 - Use DRM device SRCU for VM and SVM hardware access.
 - Protect the SVM garbage collector worker with the common I/O gate.
 - Keep the original TLB invalidation warning because cancellation is
   converted to success by the lower layer.

Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Assisted-by: LLM
Suggested-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
---
 drivers/gpu/drm/xe/xe_svm.c | 26 +++++++++++++++++++++++---
 drivers/gpu/drm/xe/xe_vm.c  | 11 +++++++++--
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
index 909a602d091e..226dfa57cc06 100644
--- a/drivers/gpu/drm/xe/xe_svm.c
+++ b/drivers/gpu/drm/xe/xe_svm.c
@@ -12,6 +12,7 @@
 #include <drm/ttm/ttm_bo.h>
 
 #include "xe_bo.h"
+#include "xe_device.h"
 #include "xe_exec_queue_types.h"
 #include "xe_gt_stats.h"
 #include "xe_log.h"
@@ -457,9 +458,15 @@ static void xe_svm_garbage_collector_work_func(struct work_struct *w)
 {
 	struct xe_vm *vm = container_of(w, struct xe_vm,
 					svm.garbage_collector.work);
+	int io_idx;
 
 	guard(rwsem_read)(&vm->lock);
+
+	if (xe_device_io_get(vm->xe, &io_idx))
+		return;
+
 	xe_svm_garbage_collector(vm);
+	xe_device_io_put(io_idx);
 }
 
 #if IS_ENABLED(CONFIG_DRM_XE_PAGEMAP)
@@ -600,6 +607,8 @@ static int xe_svm_copy(struct page **pages,
 #define XE_VRAM_ADDR_INVALID	~0x0ull
 	u64 vram_addr = XE_VRAM_ADDR_INVALID;
 	int err = 0, pos = 0;
+	bool io_held = false;
+	int io_idx;
 	bool sram = dir == XE_SVM_COPY_TO_SRAM;
 	ktime_t start = xe_gt_stats_ktime_get();
 
@@ -630,6 +639,12 @@ static int xe_svm_copy(struct page **pages,
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
 
@@ -750,6 +765,9 @@ static int xe_svm_copy(struct page **pages,
 	if (pre_migrate_fence)
 		dma_fence_wait(pre_migrate_fence, false);
 
+	if (io_held)
+		xe_device_io_put(io_idx);
+
 	/*
 	 * XXX: We can't derive the GT here (or anywhere in this functions, but
 	 * compute always uses the primary GT so accumulate stats on the likely
@@ -1124,8 +1142,9 @@ static int xe_drm_pagemap_populate_mm(struct drm_pagemap *dpagemap,
 	struct xe_bo *bo;
 	int err = 0, idx;
 
-	if (!drm_dev_enter(&xe->drm, &idx))
-		return -ENODEV;
+	err = xe_device_io_get(xe, &idx);
+	if (err)
+		return err;
 
 	xe_pm_runtime_get(xe);
 
@@ -1167,7 +1186,8 @@ static int xe_drm_pagemap_populate_mm(struct drm_pagemap *dpagemap,
 		xe_bo_put(bo);
 	}
 	xe_pm_runtime_put(xe);
-	drm_dev_exit(idx);
+
+	xe_device_io_put(idx);
 
 	return err;
 }
diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index d12365b11186..645c5e906224 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -541,6 +541,7 @@ static void preempt_rebind_work_func(struct work_struct *w)
 	unsigned int fence_count = 0;
 	LIST_HEAD(preempt_fences);
 	int err = 0;
+	int io_idx;
 	long wait;
 	int __maybe_unused tries = 0;
 
@@ -574,6 +575,12 @@ static void preempt_rebind_work_func(struct work_struct *w)
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
 
@@ -581,8 +588,7 @@ static void preempt_rebind_work_func(struct work_struct *w)
 		drm_exec_retry_on_contention(&exec);
 		xe_validation_retry_on_oom(&ctx, &err);
 		if (err || done) {
-			xe_validation_ctx_fini(&ctx);
-			goto out_unlock_outer;
+			goto out_unlock;
 		}
 	}
 
@@ -628,6 +634,7 @@ static void preempt_rebind_work_func(struct work_struct *w)
 
 out_unlock:
 	xe_validation_ctx_fini(&ctx);
+	xe_device_io_put(io_idx);
 out_unlock_outer:
 	if (err == -EAGAIN) {
 		trace_xe_vm_rebind_worker_retry(vm);
-- 
2.43.0

