Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC5E606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 12:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aQva9aFT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96E6A10FBF9;
	Wed, 28 Oct 2026 12:21:55 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E295810FBF0;
 Wed, 28 Oct 2026 12:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793190109; x=1824726109;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fWiWE204ZDF7Pdlo06SKQfC4B2okcUUusSr+so0rGHY=;
 b=aQva9aFTDsaRJpG5NUieYfivI8Eqe20ycS2xqaD2cgSiLqrx41Tjz+pv
 6tTFkRnXfq9pHlX5zgfAHM2224aD4UKIrxh+gXaRDac/rJ1FOt5Po8T6K
 PQyhttRsh48ntRZfg0lB5UsH1g7mDofKCxtALHnvijNAytDo/YCJQAHZ/
 m/VfYelAkNSxj43VuW2oZ+Da7FQJLlTlDwnYeHAaYdr3Q0ZZEQypDcqrr
 0KQtvWRXb02bdhHyHHZ32BiReIyB5xSlDUDMSGKPBmNRI7dFx/Qq0zpon
 ZFKHgU1cSccO5pKg0Nz0fRJbY7VjF2E7nZoumBjLwrLYYpxcqknSjwNyQ w==;
X-CSE-ConnectionGUID: UuuFWrtTQiCKf821POuzJw==
X-CSE-MsgGUID: bvNLCCBrTfuJffyuhcacvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1939036"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1939036"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2026 05:21:48 -0700
X-CSE-ConnectionGUID: KrEdYOy5TTy9G/OGIObyCQ==
X-CSE-MsgGUID: TRXWuXBYQFSSgy8Vu7IN9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="4838525"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2026 05:21:47 -0700
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: rodrigo.vivi@intel.com, matthew.brost@intel.com,
 himal.prasad.ghimiray@intel.com, thomas.hellstrom@linux.intel.com,
 sanjay.kumar.yadav@intel.com
Subject: [PATCH v2 3/4] drm/xe: Mark VMs as closing before queue cleanup
Date: Wed, 28 Oct 2026 17:51:24 +0530
Message-ID: <20261028122125.3772832-4-arvind.yadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261028122125.3772832-1-arvind.yadav@intel.com>
References: <20261028122125.3772832-1-arvind.yadav@intel.com>
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Queue cleanup is asynchronous. New VM work can therefore race with file
close or VM destroy while cleanup is starting.

Add a closing state and set it before starting queue cleanup. Treat a
closing VM as unavailable for new exec, bind, rebind and page-fault work.

Keep vm->size valid while the VM is closing so SVM invalidation can still
drain existing mappings.

Also reject page faults on banned VMs, which cannot resume execution.

Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Assisted-by: LLM
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
---
 drivers/gpu/drm/xe/xe_device.c    |  4 ++++
 drivers/gpu/drm/xe/xe_pagefault.c |  2 +-
 drivers/gpu/drm/xe/xe_svm.c       |  3 ++-
 drivers/gpu/drm/xe/xe_vm.c        | 18 +++++++++++++++++-
 drivers/gpu/drm/xe/xe_vm.h        |  9 ++++++++-
 drivers/gpu/drm/xe/xe_vm_types.h  |  1 +
 6 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index d3bb42e4d0d7..7b4913d7665d 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -181,6 +181,10 @@ static void xe_file_close(struct drm_device *dev, struct drm_file *file)
 
 	guard(xe_pm_runtime)(xe);
 
+	/* Block new VM work before starting asynchronous queue teardown. */
+	xa_for_each(&xef->vm.xa, idx, vm)
+		xe_vm_close_start(vm);
+
 	/*
 	 * No need for exec_queue.lock here as there is no contention for it
 	 * when FD is closing as IOCTLs presumably can't be modifying the
diff --git a/drivers/gpu/drm/xe/xe_pagefault.c b/drivers/gpu/drm/xe/xe_pagefault.c
index 5247321c805e..e1363bfbfbd9 100644
--- a/drivers/gpu/drm/xe/xe_pagefault.c
+++ b/drivers/gpu/drm/xe/xe_pagefault.c
@@ -291,7 +291,7 @@ static int xe_pagefault_service(struct xe_pagefault *pf)
 
 	down_read(&vm->lock);
 
-	if (xe_vm_is_closed(vm)) {
+	if (xe_vm_is_closed_or_banned(vm)) {
 		err = -ENOENT;
 		xe_pagefault_set_error(pf, XE_PAGEFAULT_ERROR_VM_CLOSED);
 		goto unlock_vm;
diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
index 909a602d091e..3b71d9636296 100644
--- a/drivers/gpu/drm/xe/xe_svm.c
+++ b/drivers/gpu/drm/xe/xe_svm.c
@@ -219,7 +219,8 @@ xe_svm_range_notifier_event_end(struct xe_vm *vm, struct drm_gpusvm_range *r,
 
 	drm_gpusvm_unmap_pages(&vm->svm.gpusvm, &(to_xe_range(r)->pages),
 			       drm_gpusvm_range_size(r) >> PAGE_SHIFT, &ctx);
-	if (!xe_vm_is_closed(vm) && mmu_range->event == MMU_NOTIFY_UNMAP)
+	if (!xe_vm_is_closed(vm) && !xe_vm_is_closing(vm) &&
+	    mmu_range->event == MMU_NOTIFY_UNMAP)
 		xe_svm_garbage_collector_add_range(vm, to_xe_range(r),
 						   mmu_range);
 }
diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index a1a4eaf3165f..6e548fd8a809 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -1975,6 +1975,20 @@ static void xe_vm_close(struct xe_vm *vm)
 		drm_dev_exit(idx);
 }
 
+void xe_vm_close_start(struct xe_vm *vm)
+{
+	down_write(&vm->lock);
+	if (xe_vm_in_fault_mode(vm))
+		xe_svm_notifier_lock(vm);
+
+	/* Keep size valid so SVM invalidation still performs its full drain. */
+	vm->flags |= XE_VM_FLAG_CLOSING;
+
+	if (xe_vm_in_fault_mode(vm))
+		xe_svm_notifier_unlock(vm);
+	up_write(&vm->lock);
+}
+
 void xe_vm_close_and_put(struct xe_vm *vm)
 {
 	LIST_HEAD(contested);
@@ -2268,8 +2282,10 @@ int xe_vm_destroy_ioctl(struct drm_device *dev, void *data,
 		xa_erase(&xef->vm.xa, args->vm_id);
 	mutex_unlock(&xef->vm.lock);
 
-	if (!err)
+	if (!err) {
+		xe_vm_close_start(vm);
 		xe_vm_close_and_put(vm);
+	}
 
 	return err;
 }
diff --git a/drivers/gpu/drm/xe/xe_vm.h b/drivers/gpu/drm/xe/xe_vm.h
index 351d08b3b378..a8b33cb2b559 100644
--- a/drivers/gpu/drm/xe/xe_vm.h
+++ b/drivers/gpu/drm/xe/xe_vm.h
@@ -59,6 +59,11 @@ static inline bool xe_vm_is_closed(struct xe_vm *vm)
 	return !vm->size;
 }
 
+static inline bool xe_vm_is_closing(struct xe_vm *vm)
+{
+	return vm->flags & XE_VM_FLAG_CLOSING;
+}
+
 static inline bool xe_vm_is_banned(struct xe_vm *vm)
 {
 	return vm->flags & XE_VM_FLAG_BANNED;
@@ -67,7 +72,8 @@ static inline bool xe_vm_is_banned(struct xe_vm *vm)
 static inline bool xe_vm_is_closed_or_banned(struct xe_vm *vm)
 {
 	lockdep_assert_held(&vm->lock);
-	return xe_vm_is_closed(vm) || xe_vm_is_banned(vm);
+	return xe_vm_is_closed(vm) || xe_vm_is_banned(vm) ||
+		xe_vm_is_closing(vm);
 }
 
 struct xe_vma *
@@ -214,6 +220,7 @@ int xe_vm_get_property_ioctl(struct drm_device *dev, void *data,
 			     struct drm_file *file);
 
 void xe_vm_close_and_put(struct xe_vm *vm);
+void xe_vm_close_start(struct xe_vm *vm);
 
 static inline bool xe_vm_in_fault_mode(struct xe_vm *vm)
 {
diff --git a/drivers/gpu/drm/xe/xe_vm_types.h b/drivers/gpu/drm/xe/xe_vm_types.h
index fb9305124679..6ca9ef9d0c0b 100644
--- a/drivers/gpu/drm/xe/xe_vm_types.h
+++ b/drivers/gpu/drm/xe/xe_vm_types.h
@@ -286,6 +286,7 @@ struct xe_vm {
 #define XE_VM_FLAG_SET_TILE_ID(tile)	FIELD_PREP(GENMASK(7, 6), (tile)->id)
 #define XE_VM_FLAG_GSC			BIT(8)
 #define XE_VM_FLAG_NO_VM_OVERCOMMIT     BIT(9)
+#define XE_VM_FLAG_CLOSING		BIT(10)
 	unsigned long flags;
 
 	/**
-- 
2.43.0

