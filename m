Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D6BCD6E68
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 09:50:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD0FE112713;
	Thu,  4 Jun 2026 09:50:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="jtc+lYcN";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A92D112713;
 Thu,  4 Jun 2026 09:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780566639; x=1812102639;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=u+J4fL5pYetSuc1o086u36Z4jaib7dbLRBdbYLBnZk8=;
 b=jtc+lYcNTWNzZTXRpRFjAp/6gj6Om6XzhqtUhgdhnR3EzirREbSgr3eP
 +T76nUYTUlVmCpgM2G6QF3wba1YKc7SaUpVHqlCjk5rZNGz3Hk1DGsJvn
 o2Hr3beOSrqkb5iyRVaXNxIm0HOH2YAT0BT6QVyznjb0Ql641T+WA+baR
 cyAfeR6NM/uivt2blade4M/Gf55JcMEa0NzXGS4AAIAoXQb4C1pJMAa6B
 YsddOaGgrZQRG+BuahLcN1kLWcjD3rdeG6DvDvwg5xmPKcVz4cY/7D+Fx
 NMXiJD4J+v1iV236nOaomxpqSBSwAH/pzIns7Kl91X8Y7N0bwvt+JHVVQ g==;
X-CSE-ConnectionGUID: QgLKeBR+Q0yaEsTIufOI8w==
X-CSE-MsgGUID: fBSZRSxkQaqVeoWl/NeC7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="98810526"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; d="scan'208";a="98810526"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2026 02:50:39 -0700
X-CSE-ConnectionGUID: ZaIqmCjqSxSv8Byxreaf6w==
X-CSE-MsgGUID: t+eeq+7USM+ynLUV3K2MAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; d="scan'208";a="282602405"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2026 02:50:37 -0700
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: matthew.brost@intel.com, himal.prasad.ghimiray@intel.com,
 thomas.hellstrom@linux.intel.com
Subject: [RFC v3 6/7] drm/xe/vm: Wire MADVISE_AUTORESET notifiers into VM
 lifecycle
Date: Thu,  4 Jun 2026 15:20:11 +0530
Message-ID: <20260604095012.367231-7-arvind.yadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604095012.367231-1-arvind.yadav@intel.com>
References: <20260604095012.367231-1-arvind.yadav@intel.com>
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

Initialise the MADVISE_AUTORESET notifier infrastructure for fault-mode
VMs and tear it down during VM close.

VM close drops vm->lock around xe_vm_madvise_fini(), since the madvise
worker takes vm->lock while draining pending unmap work. The close path
then retakes vm->lock before xe_svm_fini().

The MADVISE ioctl collects CPU mirror VMA ranges under vm->lock and
registers interval notifiers after dropping it. Registration is
best-effort because mmu_interval_notifier_insert() may take mmap_lock.

If registration fails, disable MADV_AUTORESET for the exact VMA range but
keep cpu_autoreset_active set, since the VMA is still CPU-only until the
first successful GPU fault.

Also skip SVM PTE zapping for CPU mirror VMAs while cpu_autoreset_active
is set, since no GPU PTEs should exist yet.

v2:
  - Register notifiers outside vm->lock; take vm->lock only for dedup and
    mtree_store_range. (Matt)
  - Collect VMA ranges under vm->lock and register notifiers after
    unlock. (Matt)

v3:
  - Allocate notifier ranges before mutating VMA state.
  - Fix notifier-lock unwind when the madvise type is invalid.
  - On notifier registration failure, clear MADV_AUTORESET but keep
    cpu_autoreset_active.

Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
---
 drivers/gpu/drm/xe/xe_svm.c        |   9 +++
 drivers/gpu/drm/xe/xe_vm.c         |  14 ++++
 drivers/gpu/drm/xe/xe_vm_madvise.c | 105 ++++++++++++++++++++++++++++-
 3 files changed, 125 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
index b58857668d48..4169cfae7b51 100644
--- a/drivers/gpu/drm/xe/xe_svm.c
+++ b/drivers/gpu/drm/xe/xe_svm.c
@@ -914,6 +914,15 @@ int xe_svm_init(struct xe_vm *vm)
 			drm_pagemap_release_owner(&vm->svm.peer);
 			return err;
 		}
+
+		/* Initialize after gpusvm. */
+		err = xe_vm_madvise_init(vm);
+		if (err) {
+			drm_gpusvm_fini(&vm->svm.gpusvm);
+			xe_svm_put_pagemaps(vm);
+			drm_pagemap_release_owner(&vm->svm.peer);
+			return err;
+		}
 	} else {
 		err = drm_gpusvm_init(&vm->svm.gpusvm, "Xe SVM (simple)",
 				      &vm->xe->drm, NULL, 0, 0, 0, NULL,
diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index dec5279f08a2..e93d715d3da9 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -1815,6 +1815,8 @@ struct xe_vm *xe_vm_create(struct xe_device *xe, u32 flags, struct xe_file *xef)
 err_svm_fini:
 	if (flags & XE_VM_FLAG_FAULT_MODE) {
 		vm->size = 0; /* close the vm */
+		/* Safe if madvise init did not run. */
+		xe_vm_madvise_fini(vm);
 		xe_svm_fini(vm);
 	}
 err_no_resv:
@@ -1959,6 +1961,18 @@ void xe_vm_close_and_put(struct xe_vm *vm)
 		xe_vma_destroy_unlocked(vma);
 	}
 
+	/*
+	 * The VM is closed here, so no new ioctl should enter. Drop vm->lock
+	 * while draining madvise workers because they take vm->lock.
+	 */
+	xe_assert(vm->xe, xe_vm_is_closed(vm));
+	up_write(&vm->lock);
+
+	if (vm->flags & XE_VM_FLAG_FAULT_MODE)
+		xe_vm_madvise_fini(vm);
+
+	down_write(&vm->lock);
+
 	xe_svm_fini(vm);
 
 	up_write(&vm->lock);
diff --git a/drivers/gpu/drm/xe/xe_vm_madvise.c b/drivers/gpu/drm/xe/xe_vm_madvise.c
index 6c42ce8e3f52..eb2d17abf9d4 100644
--- a/drivers/gpu/drm/xe/xe_vm_madvise.c
+++ b/drivers/gpu/drm/xe/xe_vm_madvise.c
@@ -28,6 +28,7 @@ struct xe_vmas_in_madvise_range {
 	int num_vmas;
 	bool has_bo_vmas;
 	bool has_svm_userptr_vmas;
+	bool has_cpu_addr_mirror_vmas;
 };
 
 /**
@@ -70,7 +71,11 @@ static int get_vmas(struct xe_vm *vm, struct xe_vmas_in_madvise_range *madvise_r
 
 		if (xe_vma_bo(vma))
 			madvise_range->has_bo_vmas = true;
-		else if (xe_vma_is_cpu_addr_mirror(vma) || xe_vma_is_userptr(vma))
+		else if (xe_vma_is_cpu_addr_mirror(vma)) {
+			/* CPU mirror VMAs use the SVM notifier lock. */
+			madvise_range->has_svm_userptr_vmas = true;
+			madvise_range->has_cpu_addr_mirror_vmas = true;
+		} else if (xe_vma_is_userptr(vma))
 			madvise_range->has_svm_userptr_vmas = true;
 
 		if (madvise_range->num_vmas == max_vmas) {
@@ -297,7 +302,12 @@ static u8 xe_zap_ptes_in_madvise_range(struct xe_vm *vm, u64 start, u64 end)
 			continue;
 
 		if (xe_vma_is_cpu_addr_mirror(vma)) {
-			tile_mask |= xe_svm_ranges_zap_ptes_in_range(vm,
+			/*
+			 * CPU-only mirror VMAs have no GPU PTEs yet.
+			 * Once GPU-touched, SVM zap applies.
+			 */
+			if (!xe_vma_has_cpu_autoreset_active(vma))
+				tile_mask |= xe_svm_ranges_zap_ptes_in_range(vm,
 								      xe_vma_start(vma),
 								      xe_vma_end(vma));
 		} else {
@@ -559,6 +569,32 @@ static bool check_bo_args_are_sane(struct xe_vm *vm, struct xe_vma **vmas,
 	}
 	return true;
 }
+
+/*
+ * Clear AUTORESET on CPU mirror VMAs in [start, end). Registration may
+ * fail after the VMA was split or merged, so do not rely on exact match.
+ */
+static void xe_vm_madvise_clear_autoreset_range(struct xe_vm *vm,
+						u64 start, u64 end)
+{
+	u64 addr = start;
+
+	lockdep_assert_held_write(&vm->lock);
+
+	while (addr < end) {
+		struct xe_vma *vma;
+
+		vma = xe_vm_find_overlapping_vma(vm, addr, end - addr);
+		if (!vma)
+			break;
+
+		if (xe_vma_is_cpu_addr_mirror(vma))
+			vma->gpuva.flags &= ~XE_VMA_MADV_AUTORESET;
+
+		addr = xe_vma_end(vma);
+	}
+}
+
 /**
  * xe_vm_madvise_ioctl - Handle MADVise ioctl for a VM
  * @dev: DRM device pointer
@@ -590,6 +626,11 @@ int xe_vm_madvise_ioctl(struct drm_device *dev, void *data, struct drm_file *fil
 	struct drm_exec exec;
 	int err, attr_type;
 	bool do_retained;
+	struct {
+		u64 start;
+		u64 end;
+	} *notifier_ranges = NULL;
+	int num_notifier_ranges = 0;
 
 	vm = xe_vm_lookup(xef, args->vm_id);
 	if (XE_IOCTL_DBG(xe, !vm))
@@ -661,6 +702,20 @@ int xe_vm_madvise_ioctl(struct drm_device *dev, void *data, struct drm_file *fil
 		}
 	}
 
+	/*
+	 * Allocate before taking BO dma-resv locks. GFP_KERNEL may enter
+	 * reclaim, which can reach TTM shrinkers and dma-resv locks.
+	 */
+	if (madvise_range.has_cpu_addr_mirror_vmas) {
+		notifier_ranges = kvmalloc_array(madvise_range.num_vmas,
+						 sizeof(*notifier_ranges),
+						 GFP_KERNEL);
+		if (!notifier_ranges) {
+			err = -ENOMEM;
+			goto free_vmas;
+		}
+	}
+
 	if (madvise_range.has_bo_vmas) {
 		if (args->type == DRM_XE_MEM_RANGE_ATTR_ATOMIC) {
 			if (!check_bo_args_are_sane(vm, madvise_range.vmas,
@@ -708,7 +763,7 @@ int xe_vm_madvise_ioctl(struct drm_device *dev, void *data, struct drm_file *fil
 	/* Ensure the madvise function exists for this type */
 	if (!madvise_funcs[attr_type]) {
 		err = -EINVAL;
-		goto err_fini;
+		goto err_unlock_notifier;
 	}
 
 	madvise_funcs[attr_type](xe, vm, madvise_range.vmas, madvise_range.num_vmas, args,
@@ -717,9 +772,29 @@ int xe_vm_madvise_ioctl(struct drm_device *dev, void *data, struct drm_file *fil
 	err = xe_vm_invalidate_madvise_range(vm, madvise_range.addr,
 					     madvise_range.addr + args->range);
 
+err_unlock_notifier:
 	if (madvise_range.has_svm_userptr_vmas)
 		xe_svm_notifier_unlock(vm);
 
+	if (err)
+		goto err_fini;
+
+	if (madvise_range.has_cpu_addr_mirror_vmas) {
+		for (int i = 0; i < madvise_range.num_vmas; i++) {
+			struct xe_vma *vma = madvise_range.vmas[i];
+
+			if (!xe_vma_is_cpu_addr_mirror(vma))
+				continue;
+			if (!(vma->gpuva.flags & XE_VMA_MADV_AUTORESET))
+				continue;
+			if (!xe_vma_has_cpu_autoreset_active(vma))
+				continue;
+			notifier_ranges[num_notifier_ranges].start = xe_vma_start(vma);
+			notifier_ranges[num_notifier_ranges].end   = xe_vma_end(vma);
+			num_notifier_ranges++;
+		}
+	}
+
 err_fini:
 	if (madvise_range.has_bo_vmas)
 		drm_exec_fini(&exec);
@@ -731,6 +806,30 @@ int xe_vm_madvise_ioctl(struct drm_device *dev, void *data, struct drm_file *fil
 unlock_vm:
 	up_write(&vm->lock);
 
+	if (!err) {
+		for (int i = 0; i < num_notifier_ranges; i++) {
+			int ret = xe_vm_madvise_register_notifier_range(vm,
+							notifier_ranges[i].start,
+							notifier_ranges[i].end);
+			if (ret) {
+				drm_warn(&vm->xe->drm,
+					 "Failed to register madvise notifier [%#llx-%#llx]: %d\n",
+					 notifier_ranges[i].start,
+					 notifier_ranges[i].end, ret);
+				/*
+				 * Disable AUTORESET, but keep cpu_autoreset_active.
+				 * The VMA is still CPU-only.
+				 */
+				down_write(&vm->lock);
+				xe_vm_madvise_clear_autoreset_range(vm,
+								    notifier_ranges[i].start,
+								    notifier_ranges[i].end);
+				up_write(&vm->lock);
+			}
+		}
+	}
+	kvfree(notifier_ranges);
+
 	/* Write retained value to user after releasing all locks */
 	if (!err && do_retained)
 		err = xe_madvise_purgeable_retained_to_user(&details);
-- 
2.43.0

