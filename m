Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 190D2C61DC2
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 10:18:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4AC810EF8A;
	Thu, 27 Aug 2026 10:18:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="SZcxqFuQ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C28C610EF88;
 Thu, 27 Aug 2026 10:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787825917; x=1819361917;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=FMN8z66o/LNQ8cgOHAyFoBi9E6pP2e+CTjzZRjF0Mzw=;
 b=SZcxqFuQgnp85NKMCJK2swLt5foqx/gw4vNBbRIsgfvGy8xCkc/ypmnI
 P4yQGmEO5d092+ivyXJ+VGqYAM5muN4wRXcZpRo1PwdgvYOApD3y8lOFk
 /yuj/NgFc6l5e5JTIMbqA/yyvibzQvlF6cz0pevoLdgzZKvXmw9+DWRm+
 f5ICCPhjrNyL0JsHMKos46Rreml7GPJz4zsHyHn4cIKqVKfUorb4dOk9q
 KjWJxsJVC8BsSQcYxqG0zhQ7FgRkGTlZsvqQH1QzCw2PKYrRrkwpTJ3Zg
 2KaHyulqCvB1H+nQrqarfV1OTZb1YJdWai3sIClKW6JATSFzvzuQWNLxW g==;
X-CSE-ConnectionGUID: QDFcYOSXQvy061zknZYEug==
X-CSE-MsgGUID: ukNANlxATgWtMtmrtXaoMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="88445864"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; d="scan'208";a="88445864"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 03:18:37 -0700
X-CSE-ConnectionGUID: qBjO/Bl5S+uqsGVFVIBgAA==
X-CSE-MsgGUID: tKpOQX/4RjWIHMsYTwIiLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; d="scan'208";a="306057623"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 03:18:36 -0700
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: matthew.brost@intel.com, himal.prasad.ghimiray@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com
Subject: [PATCH 04/13] drm/xe: Stop VM work when device I/O is blocked
Date: Thu, 27 Aug 2026 15:47:52 +0530
Message-ID: <20260827101801.1247654-5-arvind.yadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827101801.1247654-1-arvind.yadav@intel.com>
References: <20260827101801.1247654-1-arvind.yadav@intel.com>
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

SVM invalidation still performs its software cleanup. Do not warn when
TLB invalidation returns -ECANCELED because hardware access is blocked.

Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
---
 drivers/gpu/drm/xe/xe_svm.c | 21 ++++++++++++++++++++-
 drivers/gpu/drm/xe/xe_vm.c  | 16 ++++++++++++++++
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
index 627a741293d5..9e78131bfa39 100644
--- a/drivers/gpu/drm/xe/xe_svm.c
+++ b/drivers/gpu/drm/xe/xe_svm.c
@@ -11,6 +11,7 @@
 #include <drm/drm_pagemap_util.h>
 
 #include "xe_bo.h"
+#include "xe_device.h"
 #include "xe_exec_queue_types.h"
 #include "xe_gt_stats.h"
 #include "xe_migrate.h"
@@ -288,8 +289,11 @@ static void xe_svm_invalidate(struct drm_gpusvm *gpusvm,
 
 	err = xe_tlb_inval_range_tilemask_submit(xe, vm->usm.asid, adj_start, adj_end,
 						 tile_mask, &batch);
-	if (!WARN_ON_ONCE(err))
+	if (!err)
 		xe_tlb_inval_batch_wait(&batch);
+	else if (!(err == -ECANCELED &&
+		   xe_device_io_blocked(xe)))
+		WARN_ON_ONCE(err);
 
 range_notifier_event_end:
 	r = first;
@@ -631,6 +635,11 @@ static int xe_svm_copy(struct page **pages,
 		}
 		XE_WARN_ON(spage && xe_page_to_vr(spage) != vr);
 
+		if (vr && xe_device_io_blocked(xe)) {
+			err = -ECANCELED;
+			goto err_out;
+		}
+
 		/*
 		 * CPU page and device page valid, capture physical address on
 		 * first device page, check if physical contiguous on subsequent
@@ -1125,6 +1134,11 @@ static int xe_drm_pagemap_populate_mm(struct drm_pagemap *dpagemap,
 	if (!drm_dev_enter(&xe->drm, &idx))
 		return -ENODEV;
 
+	if (xe_device_io_blocked(xe)) {
+		err = -ECANCELED;
+		goto out_drm;
+	}
+
 	xe_pm_runtime_get(xe);
 
 	xe_validation_guard(&vctx, &xe->val, &exec, (struct xe_val_flags) {}, err) {
@@ -1165,6 +1179,8 @@ static int xe_drm_pagemap_populate_mm(struct drm_pagemap *dpagemap,
 		xe_bo_put(bo);
 	}
 	xe_pm_runtime_put(xe);
+
+out_drm:
 	drm_dev_exit(idx);
 
 	return err;
@@ -1301,6 +1317,9 @@ static int __xe_svm_handle_pagefault(struct xe_vm *vm, struct xe_vma *vma,
 		drm_gpusvm_range_put(&range->base);
 	}
 
+	if (xe_device_io_blocked(vm->xe))
+		return -ECANCELED;
+
 	/* Always process UNMAPs first so view SVM ranges is current */
 	err = xe_svm_garbage_collector(vm);
 	if (err)
diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 19b3d0be7928..0cee5306fb9c 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -497,6 +497,11 @@ static void preempt_rebind_work_func(struct work_struct *w)
 	}
 
 retry:
+	if (xe_device_io_blocked(vm->xe)) {
+		err = 0;
+		goto out_unlock_outer;
+	}
+
 	if (!try_wait_for_completion(&vm->xe->pm_block) && vm_suspend_rebind_worker(vm)) {
 		up_write(&vm->lock);
 		/* We don't actually block but don't make progress. */
@@ -518,6 +523,12 @@ static void preempt_rebind_work_func(struct work_struct *w)
 	drm_exec_until_all_locked(&exec) {
 		bool done = false;
 
+		if (xe_device_io_blocked(vm->xe)) {
+			xe_validation_ctx_fini(&ctx);
+			err = 0;
+			goto out_unlock_outer;
+		}
+
 		err = xe_preempt_work_begin(&exec, vm, &done);
 		drm_exec_retry_on_contention(&exec);
 		xe_validation_retry_on_oom(&ctx, &err);
@@ -531,6 +542,11 @@ static void preempt_rebind_work_func(struct work_struct *w)
 	if (err)
 		goto out_unlock;
 
+	if (xe_device_io_blocked(vm->xe)) {
+		err = 0;
+		goto out_unlock;
+	}
+
 	xe_vm_set_validation_exec(vm, &exec);
 	err = xe_vm_rebind(vm, true);
 	xe_vm_set_validation_exec(vm, NULL);
-- 
2.43.0

