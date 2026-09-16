Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E176FC982C1
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 09:53:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AC4A10E7B4;
	Wed, 16 Sep 2026 09:53:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="U/5ORXpb";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BDA610E722;
 Wed, 16 Sep 2026 09:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789552434; x=1821088434;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BUOV6c+FWf+YSLm1AQhWt5ZxecXVw413d1DrYB/Epdw=;
 b=U/5ORXpbKA/rQrVWiPBHBDzCDnkOQ/ckw7FnPmE4e6LQXsovZPHpqsK0
 vzBkMxiZVgGtiFfDqvOWzt6vV+B/XivGKD//2DwtsdDW7VTH8YgKoboEk
 pzxB3z1VlR6G8gOxzkCwf0OtOhO+RDKY6aelFVetYmfvr0NZEEcaYEuxf
 Q1kd8Hb+85S2LKIU6I/6otrQRr87Rksc5c7l4c9jop3n2RrGEbi3FeGV7
 d2jex6yLoVl864Neb8o90YoREK0tyVj0KpzMUBkeaaH7OuYb5+ciBZeAd
 O9n4Fh6WYNp3v44tkrf0cMaawz8Cmw+009go0vSX+lNjw1D4eADU1Ojg4 g==;
X-CSE-ConnectionGUID: 9QUGio6ERc6BdRHooSR8Qg==
X-CSE-MsgGUID: HNvn9B25QWipltWd1qQVTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="429598"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="429598"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa116.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 02:53:54 -0700
X-CSE-ConnectionGUID: Lwt7g9vlTeOYLeXUqTLNbQ==
X-CSE-MsgGUID: XlGQIwmASSGzKjJKjfWLRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="277415558"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 02:53:52 -0700
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: rodrigo.vivi@intel.com, matthew.brost@intel.com,
 himal.prasad.ghimiray@intel.com, thomas.hellstrom@linux.intel.com
Subject: [PATCH 3/5] drm/xe: Mark VMs as closing before queue cleanup
Date: Wed, 16 Sep 2026 15:23:35 +0530
Message-ID: <20260916095337.3104891-4-arvind.yadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916095337.3104891-1-arvind.yadav@intel.com>
References: <20260916095337.3104891-1-arvind.yadav@intel.com>
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

Queue cleanup is asynchronous. New VM work can therefore race with file
close or VM destroy while cleanup is starting.

Add a closing state and set it before starting queue cleanup. Treat a
closing VM as unavailable for new exec, bind, rebind and page-fault work.

Keep vm->size valid while the VM is closing so SVM invalidation can still
drain existing mappings.

Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Assisted-by: Claude:claude-opus-4-8
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
index 205cb4e7f9e8..954f0965deb8 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -179,6 +179,10 @@ static void xe_file_close(struct drm_device *dev, struct drm_file *file)
 
 	guard(xe_pm_runtime)(xe);
 
+	/* Block new VM work before starting asynchronous queue teardown. */
+	xa_for_each(&xef->vm.xa, idx, vm)
+		xe_vm_close_start(vm);
+
 	/*
 	 * No need for exec_queue.lock here as there is no contention for it
 	 * when FD is closing as IOCTLs presumably can't be modifying the
diff --git a/drivers/gpu/drm/xe/xe_pagefault.c b/drivers/gpu/drm/xe/xe_pagefault.c
index aeb56ff5d58e..4bdd714b9f88 100644
--- a/drivers/gpu/drm/xe/xe_pagefault.c
+++ b/drivers/gpu/drm/xe/xe_pagefault.c
@@ -265,7 +265,7 @@ static int xe_pagefault_service(struct xe_pagefault *pf)
 
 	down_read(&vm->lock);
 
-	if (xe_vm_is_closed(vm)) {
+	if (xe_vm_is_closed_or_banned(vm)) {
 		err = -ENOENT;
 		goto unlock_vm;
 	}
diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
index 6c3033fc4db7..c2a9dd98f363 100644
--- a/drivers/gpu/drm/xe/xe_svm.c
+++ b/drivers/gpu/drm/xe/xe_svm.c
@@ -218,7 +218,8 @@ xe_svm_range_notifier_event_end(struct xe_vm *vm, struct drm_gpusvm_range *r,
 
 	drm_gpusvm_unmap_pages(&vm->svm.gpusvm, &(to_xe_range(r)->pages),
 			       drm_gpusvm_range_size(r) >> PAGE_SHIFT, &ctx);
-	if (!xe_vm_is_closed(vm) && mmu_range->event == MMU_NOTIFY_UNMAP)
+	if (!xe_vm_is_closed(vm) && !xe_vm_is_closing(vm) &&
+	    mmu_range->event == MMU_NOTIFY_UNMAP)
 		xe_svm_garbage_collector_add_range(vm, to_xe_range(r),
 						   mmu_range);
 }
diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 264bdab75de2..5d0b616a27b3 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -1913,6 +1913,20 @@ static void xe_vm_close(struct xe_vm *vm)
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
@@ -2214,8 +2228,10 @@ int xe_vm_destroy_ioctl(struct drm_device *dev, void *data,
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
index c5b900f38ded..70456ffe27e2 100644
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
index 648031e64145..16b051a0cf10 100644
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

