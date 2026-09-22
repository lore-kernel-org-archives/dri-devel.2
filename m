Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 801C6C982FF
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 10:17:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E93D910EC2C;
	Tue, 22 Sep 2026 10:17:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="MLAa29kh";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11A2810E6C1;
 Tue, 22 Sep 2026 10:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790072264; x=1821608264;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Cm7fADvZECOCB3hgfTcBrPEFhJoSz8dYVOfL1YvbFCI=;
 b=MLAa29khUyxQp5f5eZaH5JOcafn+1twzDcA+U8yw8IuMpnJALyCUxlod
 sN+wkqS1DYTr75Z/rCQyDztQQTQ0Sv4sW5Hp9LYK9ybZHYkIJ5kc+EJZU
 GZBxHRM6/ylEYKULIVwZFG4w8FTdBttJf/rCtc5YLB3Hii7puAGKVYr9M
 zcESg1yxNxwJLpzf0QVoBUrwIRl2AbxIUBFhNdKZrbuu0LUrmOImDqLqc
 ZHCel/oyvp1zpIRRC86L5u0NWoOIT5/c+NvwN3ygj6ZX/K13oAL5WAR+/
 TzvH8vCJq3L3FV0UkswP4rA7A/X61APvrs5UGczqXIEub0WAMt9h0tnJL w==;
X-CSE-ConnectionGUID: nQl0QmSjS06hkimI4s6jbA==
X-CSE-MsgGUID: P9lhskX+SfqF9TRQeeWTwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="101322789"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="101322789"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 03:17:44 -0700
X-CSE-ConnectionGUID: XoynDHonTLGnPGYI5Pdg/Q==
X-CSE-MsgGUID: 64VkGzT6RD6f2sRxwx4EyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="299307785"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 03:17:42 -0700
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: matthew.brost@intel.com, himal.prasad.ghimiray@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com
Subject: [PATCH v2 04/15] drm/xe: Protect device I/O with DRM device SRCU
Date: Tue, 22 Sep 2026 15:46:49 +0530
Message-ID: <20260922101721.1583542-5-arvind.yadav@intel.com>
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

A device state check alone cannot stop reset or wedging from racing with
a caller that has already passed the check.

Add xe_device_io_get() and xe_device_io_put() wrappers around
drm_dev_enter() and drm_dev_exit(). Check the device state inside the
DRM SRCU critical section so new access is rejected after PCI recovery
starts or the device becomes wedged.

After blocking new access, PCI recovery wedges the GTs to signal pending
fences and drains existing readers before disabling the PCI device.

Permanent wedge isolation uses the same DRM SRCU domain to drain active
hardware users before stopping interrupts and DMA.

Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Assisted-by: Claude:claude-opus-4-8
Suggested-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
---
 drivers/gpu/drm/xe/xe_bo.c            |  6 ++---
 drivers/gpu/drm/xe/xe_device.c        | 33 +++++++++++++++++++--------
 drivers/gpu/drm/xe/xe_device.h        | 29 +++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_guc_ct.c        |  9 +++++++-
 drivers/gpu/drm/xe/xe_guc_tlb_inval.c | 13 +++++++----
 drivers/gpu/drm/xe/xe_pci_error.c     |  6 +++++
 6 files changed, 78 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index dee1a39fac13..b39b07b55f64 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -2106,9 +2106,9 @@ static vm_fault_t xe_bo_cpu_fault(struct vm_fault *vmf)
 	struct drm_exec exec;
 	vm_fault_t ret;
 	int err = 0;
-	int idx;
+	int io_idx;
 
-	if (xe_device_io_blocked(xe) || !drm_dev_enter(&xe->drm, &idx))
+	if (xe_device_io_get(xe, &io_idx))
 		return ttm_bo_vm_dummy_page(vmf, vmf->vma->vm_page_prot);
 
 	ret = xe_bo_cpu_fault_fastpath(vmf, xe, bo, needs_rpm);
@@ -2195,7 +2195,7 @@ static vm_fault_t xe_bo_cpu_fault(struct vm_fault *vmf)
 	if (retry_after_wait)
 		xe_bo_put(bo);
 out:
-	drm_dev_exit(idx);
+	xe_device_io_put(io_idx);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index 0e3139aa96d5..9a940ba8dc1c 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -235,16 +235,20 @@ static long xe_drm_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct drm_file *file_priv = file->private_data;
 	struct xe_device *xe = to_xe_device(file_priv->minor->dev);
+	int io_idx;
 	long ret;
 
-	if (xe_device_io_blocked(xe))
-		return -ECANCELED;
+	ret = xe_device_io_get(xe, &io_idx);
+	if (ret)
+		return ret;
 
-	ACQUIRE(xe_pm_runtime_ioctl, pm)(xe);
-	ret = ACQUIRE_ERR(xe_pm_runtime_ioctl, &pm);
-	if (ret >= 0)
+	scoped_cond_guard(xe_pm_runtime_ioctl,
+			  ret = ACQUIRE_ERR(xe_pm_runtime_ioctl, &scope),
+			  xe) {
 		ret = drm_ioctl(file, cmd, arg);
+	}
 
+	xe_device_io_put(io_idx);
 	return ret;
 }
 
@@ -253,16 +257,20 @@ static long xe_drm_compat_ioctl(struct file *file, unsigned int cmd, unsigned lo
 {
 	struct drm_file *file_priv = file->private_data;
 	struct xe_device *xe = to_xe_device(file_priv->minor->dev);
+	int io_idx;
 	long ret;
 
-	if (xe_device_io_blocked(xe))
-		return -ECANCELED;
+	ret = xe_device_io_get(xe, &io_idx);
+	if (ret)
+		return ret;
 
-	ACQUIRE(xe_pm_runtime_ioctl, pm)(xe);
-	ret = ACQUIRE_ERR(xe_pm_runtime_ioctl, &pm);
-	if (ret >= 0)
+	scoped_cond_guard(xe_pm_runtime_ioctl,
+			  ret = ACQUIRE_ERR(xe_pm_runtime_ioctl, &scope),
+			  xe) {
 		ret = drm_compat_ioctl(file, cmd, arg);
+	}
 
+	xe_device_io_put(io_idx);
 	return ret;
 }
 #else
@@ -432,6 +440,11 @@ struct xe_device *xe_device_create(struct pci_dev *pdev)
 }
 ALLOW_ERROR_INJECTION(xe_device_create, ERRNO); /* See xe_pci_probe() */
 
+void xe_device_io_drain(struct xe_device *xe)
+{
+	drm_dev_srcu_synchronize(&xe->drm);
+}
+
 static void xe_device_parse_modparam(struct xe_device *xe)
 {
 	xe->atomic_svm_timeslice_ms = 5;
diff --git a/drivers/gpu/drm/xe/xe_device.h b/drivers/gpu/drm/xe/xe_device.h
index ecd46e2000d2..36b8da20345a 100644
--- a/drivers/gpu/drm/xe/xe_device.h
+++ b/drivers/gpu/drm/xe/xe_device.h
@@ -6,6 +6,7 @@
 #ifndef _XE_DEVICE_H_
 #define _XE_DEVICE_H_
 
+#include <drm/drm_drv.h>
 #include <drm/drm_util.h>
 
 #include "xe_device_types.h"
@@ -224,6 +225,34 @@ static inline bool xe_device_io_blocked(struct xe_device *xe)
 	return xe_device_wedged(xe) || xe_device_is_in_reset(xe);
 }
 
+/**
+ * xe_device_io_get - Enter a device access critical section
+ * @xe: Xe device
+ * @idx: SRCU index returned on success
+ *
+ * Return: 0 on success, -ENODEV after unplug, or -ECANCELED when
+ * device I/O is blocked.
+ */
+static inline int xe_device_io_get(struct xe_device *xe, int *idx)
+{
+	if (!drm_dev_enter(&xe->drm, idx))
+		return -ENODEV;
+
+	if (xe_device_io_blocked(xe)) {
+		drm_dev_exit(*idx);
+		return -ECANCELED;
+	}
+
+	return 0;
+}
+
+static inline void xe_device_io_put(int idx)
+{
+	drm_dev_exit(idx);
+}
+
+void xe_device_io_drain(struct xe_device *xe);
+
 #ifdef CONFIG_DRM_XE_DEBUG_PAGE_SIZE
 static inline bool xe_debug_page_size_supported(struct xe_device *xe)
 {
diff --git a/drivers/gpu/drm/xe/xe_guc_ct.c b/drivers/gpu/drm/xe/xe_guc_ct.c
index f82f57e6672d..5ec95e9551cc 100644
--- a/drivers/gpu/drm/xe/xe_guc_ct.c
+++ b/drivers/gpu/drm/xe/xe_guc_ct.c
@@ -1059,6 +1059,8 @@ static int __guc_ct_send_locked(struct xe_guc_ct *ct, const u32 *action,
 				struct g2h_fence *g2h_fence, bool defer_flush)
 {
 	struct xe_gt *gt = ct_to_gt(ct);
+	bool io_held = false;
+	int io_idx;
 	u16 seqno;
 	int ret;
 
@@ -1069,11 +1071,13 @@ static int __guc_ct_send_locked(struct xe_guc_ct *ct, const u32 *action,
 	xe_gt_assert(gt, g2h_len || !num_g2h);
 	lockdep_assert_held(&ct->lock);
 
-	if (xe_device_io_blocked(ct_to_xe(ct))) {
+	if (xe_device_io_get(ct_to_xe(ct), &io_idx)) {
 		ret = guc_ct_cancel_errno(ct);
 		goto out;
 	}
 
+	io_held = true;
+
 	if (unlikely(ct->ctbs.h2g.info.broken)) {
 		ret = -EPIPE;
 		goto out;
@@ -1130,6 +1134,9 @@ static int __guc_ct_send_locked(struct xe_guc_ct *ct, const u32 *action,
 	if (g2h_len)
 		spin_unlock_irq(&ct->fast_lock);
 out:
+	if (io_held)
+		xe_device_io_put(io_idx);
+
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/xe/xe_guc_tlb_inval.c b/drivers/gpu/drm/xe/xe_guc_tlb_inval.c
index 8daa9c968f4f..7a190e7cdb56 100644
--- a/drivers/gpu/drm/xe/xe_guc_tlb_inval.c
+++ b/drivers/gpu/drm/xe/xe_guc_tlb_inval.c
@@ -66,15 +66,13 @@ static int send_tlb_inval_ggtt(struct xe_tlb_inval *tlb_inval, u32 seqno)
 	struct xe_guc *guc = tlb_inval->private;
 	struct xe_gt *gt = guc_to_gt(guc);
 	struct xe_device *xe = guc_to_xe(guc);
+	int io_idx;
 
 	/*
 	 * Returning -ECANCELED in this function is squashed at the caller and
 	 * signals waiters.
 	 */
 
-	if (xe_device_io_blocked(xe))
-		return -ECANCELED;
-
 	if (xe_guc_ct_enabled(&guc->ct) && guc->submission_state.enabled) {
 		u32 action[] = {
 			XE_GUC_ACTION_TLB_INVALIDATION,
@@ -86,8 +84,13 @@ static int send_tlb_inval_ggtt(struct xe_tlb_inval *tlb_inval, u32 seqno)
 	} else if (xe_device_uc_enabled(xe)) {
 		struct xe_mmio *mmio = &gt->mmio;
 
-		if (IS_SRIOV_VF(xe))
+		if (xe_device_io_get(xe, &io_idx))
+			return -ECANCELED;
+
+		if (IS_SRIOV_VF(xe)) {
+			xe_device_io_put(io_idx);
 			return -ECANCELED;
+		}
 
 		CLASS(xe_force_wake, fw_ref)(gt_to_fw(gt), XE_FW_GT);
 		if (xe->info.platform == XE_PVC || GRAPHICS_VER(xe) >= 20) {
@@ -99,6 +102,8 @@ static int send_tlb_inval_ggtt(struct xe_tlb_inval *tlb_inval, u32 seqno)
 			xe_mmio_write32(mmio, GUC_TLB_INV_CR,
 					GUC_TLB_INV_CR_INVALIDATE);
 		}
+
+		xe_device_io_put(io_idx);
 	}
 
 	return -ECANCELED;
diff --git a/drivers/gpu/drm/xe/xe_pci_error.c b/drivers/gpu/drm/xe/xe_pci_error.c
index 4b09e74af92e..3e06f504f1b3 100644
--- a/drivers/gpu/drm/xe/xe_pci_error.c
+++ b/drivers/gpu/drm/xe/xe_pci_error.c
@@ -25,6 +25,12 @@ static void prepare_device_for_reset(struct pci_dev *pdev)
 	for_each_gt(gt, xe, id)
 		xe_gt_declare_wedged(gt);
 
+	/*
+	 * GT wedging signals pending fences. Existing hardware users can now
+	 * finish without blocking reset.
+	 */
+	xe_device_io_drain(xe);
+
 	pci_disable_device(pdev);
 }
 
-- 
2.43.0

