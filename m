Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868CD606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 10:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XzA+Mr6J
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 571DC10FD21;
	Wed, 21 Oct 2026 10:03:53 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 417A210F9BC;
 Wed, 21 Oct 2026 10:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792577027; x=1824113027;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JHVPiuFP31jl8dT8R/r6z4wYLMOgorck/f+yRTr8gJ8=;
 b=XzA+Mr6JC5pNvRkFD216fm4Y9wDvyOu8ICAiNBGUXKRuB+60+RMNKsCT
 Ay0RFOmJIJp7WJaepwRxgEmO8X/UVQS2oRVZWb4ACmiZAwSTwS210bJQC
 Bv62/+NDxSyrH4HVi4UyXg6hl0OaEZxA4oVA0bMXwb0dgVdCkk8onIzOy
 WbbWtMs2yCeextB+1/+T1d+tLP6inHVWGrGOkhsHaZYYdAPfOgBTxHbvB
 /qvSnI7thNmrARE+AuZ5HtAiJJZvsjYhlIulPcb/lNVCHlijiGzQkUB5r
 FrI6e7tBwllemFhmJwAnflJNWBS5iP3owwKZoMMMC5yN3X07TNxRhH4Z2 g==;
X-CSE-ConnectionGUID: /Aw+kWIqRN6wRAi4U1asYQ==
X-CSE-MsgGUID: B5zo5iiOR5W+it5Btkihvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1290262"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1290262"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 03:03:47 -0700
X-CSE-ConnectionGUID: VLbQ1Oy2QJegaB0JgJiueg==
X-CSE-MsgGUID: 2vg6Zu1mSQCIQn5ZVZNkeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="3382036"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 03:03:45 -0700
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: matthew.brost@intel.com, himal.prasad.ghimiray@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com
Subject: [RFC v3 03/17] drm/xe: Protect device I/O with DRM device SRCU
Date: Wed, 21 Oct 2026 15:33:04 +0530
Message-ID: <20261021100322.1014449-4-arvind.yadav@intel.com>
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

v3:
- Replace the private device I/O SRCU domain with DRM device SRCU.
  (Thomas)
- Keep the device I/O gate held until forcewake cleanup completes.
  (Sashiko)

Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Assisted-by: LLM
Suggested-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
---
 drivers/gpu/drm/xe/xe_bo.c            |  6 ++---
 drivers/gpu/drm/xe/xe_device.c        | 33 +++++++++++++++++++--------
 drivers/gpu/drm/xe/xe_device.h        | 29 +++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_guc_ct.c        |  9 +++++++-
 drivers/gpu/drm/xe/xe_guc_tlb_inval.c | 33 +++++++++++++++------------
 drivers/gpu/drm/xe/xe_pci_error.c     |  6 +++++
 6 files changed, 87 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 5e1f2002953a..8fef7fa99ac4 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -2201,9 +2201,9 @@ static vm_fault_t xe_bo_cpu_fault(struct vm_fault *vmf)
 	struct drm_exec exec;
 	vm_fault_t ret;
 	int err = 0;
-	int idx;
+	int io_idx;
 
-	if (xe_device_io_blocked(xe) || !drm_dev_enter(&xe->drm, &idx))
+	if (xe_device_io_get(xe, &io_idx))
 		return ttm_bo_vm_dummy_page(vmf, vmf->vma->vm_page_prot);
 
 	ret = xe_bo_cpu_fault_fastpath(vmf, xe, bo, needs_rpm);
@@ -2290,7 +2290,7 @@ static vm_fault_t xe_bo_cpu_fault(struct vm_fault *vmf)
 	if (retry_after_wait)
 		xe_bo_put(bo);
 out:
-	drm_dev_exit(idx);
+	xe_device_io_put(io_idx);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index 504957dd175d..807cb0e98314 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -236,16 +236,20 @@ static long xe_drm_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
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
 
@@ -254,16 +258,20 @@ static long xe_drm_compat_ioctl(struct file *file, unsigned int cmd, unsigned lo
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
@@ -439,6 +447,11 @@ struct xe_device *xe_device_create(struct pci_dev *pdev)
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
index e3c8ba9597b4..ac70db479d77 100644
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
index be0136c0e9e7..c2bd6f8ba063 100644
--- a/drivers/gpu/drm/xe/xe_guc_ct.c
+++ b/drivers/gpu/drm/xe/xe_guc_ct.c
@@ -1158,6 +1158,8 @@ static int __guc_ct_send_locked(struct xe_guc_ct *ct, const u32 *action,
 				struct g2h_fence *g2h_fence, bool defer_flush)
 {
 	struct xe_gt *gt = ct_to_gt(ct);
+	bool io_held = false;
+	int io_idx;
 	u16 seqno;
 	int ret;
 
@@ -1168,11 +1170,13 @@ static int __guc_ct_send_locked(struct xe_guc_ct *ct, const u32 *action,
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
 		ret = -ECONNABORTED;
 		goto out;
@@ -1229,6 +1233,9 @@ static int __guc_ct_send_locked(struct xe_guc_ct *ct, const u32 *action,
 	if (g2h_len)
 		spin_unlock_irq(&ct->fast_lock);
 out:
+	if (io_held)
+		xe_device_io_put(io_idx);
+
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/xe/xe_guc_tlb_inval.c b/drivers/gpu/drm/xe/xe_guc_tlb_inval.c
index 8daa9c968f4f..ef95b540958d 100644
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
@@ -84,21 +82,26 @@ static int send_tlb_inval_ggtt(struct xe_tlb_inval *tlb_inval, u32 seqno)
 
 		return send_tlb_inval(guc, action, ARRAY_SIZE(action));
 	} else if (xe_device_uc_enabled(xe)) {
-		struct xe_mmio *mmio = &gt->mmio;
-
-		if (IS_SRIOV_VF(xe))
+		if (xe_device_io_get(xe, &io_idx))
 			return -ECANCELED;
 
-		CLASS(xe_force_wake, fw_ref)(gt_to_fw(gt), XE_FW_GT);
-		if (xe->info.platform == XE_PVC || GRAPHICS_VER(xe) >= 20) {
-			xe_mmio_write32(mmio, PVC_GUC_TLB_INV_DESC1,
-					PVC_GUC_TLB_INV_DESC1_INVALIDATE);
-			xe_mmio_write32(mmio, PVC_GUC_TLB_INV_DESC0,
-					PVC_GUC_TLB_INV_DESC0_VALID);
-		} else {
-			xe_mmio_write32(mmio, GUC_TLB_INV_CR,
-					GUC_TLB_INV_CR_INVALIDATE);
+		if (!IS_SRIOV_VF(xe)) {
+			struct xe_mmio *mmio = &gt->mmio;
+
+			CLASS(xe_force_wake, fw_ref)(gt_to_fw(gt), XE_FW_GT);
+			if (xe->info.platform == XE_PVC ||
+			    GRAPHICS_VER(xe) >= 20) {
+				xe_mmio_write32(mmio, PVC_GUC_TLB_INV_DESC1,
+						PVC_GUC_TLB_INV_DESC1_INVALIDATE);
+				xe_mmio_write32(mmio, PVC_GUC_TLB_INV_DESC0,
+						PVC_GUC_TLB_INV_DESC0_VALID);
+			} else {
+				xe_mmio_write32(mmio, GUC_TLB_INV_CR,
+						GUC_TLB_INV_CR_INVALIDATE);
+			}
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

