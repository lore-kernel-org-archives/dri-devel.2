Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34677606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 10:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YYSJGW5s
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C1DE10FD32;
	Wed, 21 Oct 2026 10:04:00 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 501BD10F9D3;
 Wed, 21 Oct 2026 10:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792577025; x=1824113025;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7v2LyiAubmziCUNn8BdIP/1A3IR+kCHal4ikR50WDNU=;
 b=YYSJGW5s2Xfr9kSrG+oahMKW+kWFM3e82VZEL9NqG3sYkiF4I1b4sybd
 Kv3zo5qFRqQCRRKwgktTvNy/4Ew5M/FY84a+VUM+7jBpivSfStVaJXKcT
 qh+24gP/xBgSlVRZoVBSM8dPR7Gqv2DkdEB1548ONOrerNo0pPtkos8+A
 oDQ4BIABLMJn0ov6Unvcq/OybysCcu+35RpJ9nMmbR9+qFK3ghXuW01Hu
 gdDqjo821fUndDPCrXavFQBySSQan7WoZhiNpmeyzd58m5u9sY/8sBXLk
 yqZTJjS5e7VWj1sLAf4DMvl9e9ibQ8wkDBNeRWR7cJUvtT2RFC5ve/m+7 g==;
X-CSE-ConnectionGUID: S7kmmQSORT6nUUWS4lA9Zw==
X-CSE-MsgGUID: o8bSeEIqRJienYMr1eSeLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1290257"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1290257"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 03:03:45 -0700
X-CSE-ConnectionGUID: p/8zc1I+S1CVD89ve17S5g==
X-CSE-MsgGUID: IefHea6aTBaXKJ3RxN2MgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="3382027"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 03:03:42 -0700
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: matthew.brost@intel.com, himal.prasad.ghimiray@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com
Subject: [RFC v3 02/17] drm/xe: Separate AER reset state from device wedging
Date: Wed, 21 Oct 2026 15:33:03 +0530
Message-ID: <20261021100322.1014449-3-arvind.yadav@intel.com>
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

PCI error recovery currently uses xe->wedged.flag to block driver
access. This mixes a temporary AER reset with a permanent device wedge.

If the device wedges during AER recovery, the wedge is not seen as the
first transition. The AER resume callback may then clear the flag and
make the permanently wedged device appear usable again.

Keep the old device blocked while slot reset removes it, and block the
new device until the AER resume callback.

The old AER path took a runtime PM reference to balance
xe_device_wedged_fini(), which drops one when wedged.flag is set. AER no
longer sets that flag, so keeping the Xe-owned reference would leak it.
pcie_do_recovery() holds a PCI-core runtime PM reference across the
error_detected, slot_reset and resume callbacks.

v2:
 - Return -ECANCELED for GuC sends blocked by AER recovery,
   keeping -ENOTRECOVERABLE for permanent wedges. This matches
   the existing cancellation path. (Sashiko)
 - Keep GuC CT cancellation retryable during AER recovery
 - Use one helper for GuC CT cancellation errors

Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Assisted-by: LLM
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
---
 drivers/gpu/drm/xe/xe_bo.c            |  2 +-
 drivers/gpu/drm/xe/xe_device.c        |  4 ++--
 drivers/gpu/drm/xe/xe_device.h        | 12 ++++++++++++
 drivers/gpu/drm/xe/xe_guc_ct.c        | 17 ++++++++++++-----
 drivers/gpu/drm/xe/xe_guc_pc.c        | 10 +++++-----
 drivers/gpu/drm/xe/xe_guc_rc.c        |  4 ++--
 drivers/gpu/drm/xe/xe_guc_submit.c    |  8 ++++++--
 drivers/gpu/drm/xe/xe_guc_tlb_inval.c |  8 +++++++-
 drivers/gpu/drm/xe/xe_pci_error.c     | 18 +++++-------------
 drivers/gpu/drm/xe/xe_sriov_pf.c      |  2 +-
 10 files changed, 53 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 1b74331b15ec..5e1f2002953a 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -2203,7 +2203,7 @@ static vm_fault_t xe_bo_cpu_fault(struct vm_fault *vmf)
 	int err = 0;
 	int idx;
 
-	if (xe_device_wedged(xe) || !drm_dev_enter(&xe->drm, &idx))
+	if (xe_device_io_blocked(xe) || !drm_dev_enter(&xe->drm, &idx))
 		return ttm_bo_vm_dummy_page(vmf, vmf->vma->vm_page_prot);
 
 	ret = xe_bo_cpu_fault_fastpath(vmf, xe, bo, needs_rpm);
diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index db0b883322ef..504957dd175d 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -238,7 +238,7 @@ static long xe_drm_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	struct xe_device *xe = to_xe_device(file_priv->minor->dev);
 	long ret;
 
-	if (xe_device_wedged(xe))
+	if (xe_device_io_blocked(xe))
 		return -ECANCELED;
 
 	ACQUIRE(xe_pm_runtime_ioctl, pm)(xe);
@@ -256,7 +256,7 @@ static long xe_drm_compat_ioctl(struct file *file, unsigned int cmd, unsigned lo
 	struct xe_device *xe = to_xe_device(file_priv->minor->dev);
 	long ret;
 
-	if (xe_device_wedged(xe))
+	if (xe_device_io_blocked(xe))
 		return -ECANCELED;
 
 	ACQUIRE(xe_pm_runtime_ioctl, pm)(xe);
diff --git a/drivers/gpu/drm/xe/xe_device.h b/drivers/gpu/drm/xe/xe_device.h
index 83d6dafab53c..e3c8ba9597b4 100644
--- a/drivers/gpu/drm/xe/xe_device.h
+++ b/drivers/gpu/drm/xe/xe_device.h
@@ -212,6 +212,18 @@ static inline bool xe_device_wedged(struct xe_device *xe)
 	return atomic_read(&xe->wedged.flag);
 }
 
+/*
+ * Return true when device access must be blocked either permanently because
+ * the device is wedged or temporarily while PCI error recovery is running.
+ *
+ * Do not use this helper for one-way wedged-device decisions such as DMA
+ * isolation, IRQ resume suppression or recovery-method reporting.
+ */
+static inline bool xe_device_io_blocked(struct xe_device *xe)
+{
+	return xe_device_wedged(xe) || xe_device_is_in_reset(xe);
+}
+
 #ifdef CONFIG_DRM_XE_DEBUG_PAGE_SIZE
 static inline bool xe_debug_page_size_supported(struct xe_device *xe)
 {
diff --git a/drivers/gpu/drm/xe/xe_guc_ct.c b/drivers/gpu/drm/xe/xe_guc_ct.c
index e9fc55917fa3..be0136c0e9e7 100644
--- a/drivers/gpu/drm/xe/xe_guc_ct.c
+++ b/drivers/gpu/drm/xe/xe_guc_ct.c
@@ -1146,6 +1146,13 @@ static int h2g_write(struct xe_guc_ct *ct, const u32 *action, u32 len,
 	return 0;
 }
 
+static int guc_ct_cancel_errno(struct xe_guc_ct *ct)
+{
+	/* AER is temporary. Only a permanent wedge is terminal. */
+	return xe_device_wedged(ct_to_xe(ct)) ?
+		-ENOTRECOVERABLE : -ECANCELED;
+}
+
 static int __guc_ct_send_locked(struct xe_guc_ct *ct, const u32 *action,
 				u32 len, u32 g2h_len, u32 num_g2h,
 				struct g2h_fence *g2h_fence, bool defer_flush)
@@ -1161,8 +1168,8 @@ static int __guc_ct_send_locked(struct xe_guc_ct *ct, const u32 *action,
 	xe_gt_assert(gt, g2h_len || !num_g2h);
 	lockdep_assert_held(&ct->lock);
 
-	if (xe_device_wedged(ct_to_xe(ct))) {
-		ret = -ENOTRECOVERABLE;
+	if (xe_device_io_blocked(ct_to_xe(ct))) {
+		ret = guc_ct_cancel_errno(ct);
 		goto out;
 	}
 
@@ -1590,7 +1597,7 @@ static int guc_ct_send_recv(struct xe_guc_ct *ct, const u32 *action, u32 len,
 	if (g2h_fence.fail) {
 		if (g2h_fence.cancel) {
 			xe_gt_dbg(gt, "H2G request %#x canceled!\n", action[0]);
-			ret = xe_device_wedged(ct_to_xe(ct)) ? -ENOTRECOVERABLE : -ECANCELED;
+			ret = guc_ct_cancel_errno(ct);
 			goto unlock;
 		}
 		xe_gt_err(gt, "H2G request %#x failed: error %#x hint %#x\n",
@@ -1935,8 +1942,8 @@ static int g2h_read(struct xe_guc_ct *ct, u32 *msg, bool fast_path)
 	lockdep_assert_held(&ct->fast_lock);
 
 	/* Keep in sync with g2h_err_is_fatal() */
-	if (xe_device_wedged(xe))
-		return -ENOTRECOVERABLE;
+	if (xe_device_io_blocked(xe))
+		return guc_ct_cancel_errno(ct);
 
 	if (ct->state == XE_GUC_CT_STATE_DISABLED)
 		return -ENODEV;
diff --git a/drivers/gpu/drm/xe/xe_guc_pc.c b/drivers/gpu/drm/xe/xe_guc_pc.c
index e0105222a2c7..a731ae8d66b0 100644
--- a/drivers/gpu/drm/xe/xe_guc_pc.c
+++ b/drivers/gpu/drm/xe/xe_guc_pc.c
@@ -188,7 +188,7 @@ static int pc_action_reset(struct xe_guc_pc *pc)
 	int ret;
 
 	ret = xe_guc_ct_send(ct, action, ARRAY_SIZE(action), 0, 0);
-	if (ret && !(xe_device_wedged(pc_to_xe(pc)) && ret == -ECANCELED))
+	if (ret && !(xe_device_io_blocked(pc_to_xe(pc)) && ret == -ECANCELED))
 		xe_gt_err(pc_to_gt(pc), "GuC PC reset failed: %pe\n",
 			  ERR_PTR(ret));
 
@@ -212,7 +212,7 @@ static int pc_action_query_task_state(struct xe_guc_pc *pc)
 
 	/* Blocking here to ensure the results are ready before reading them */
 	ret = xe_guc_ct_send_block(ct, action, ARRAY_SIZE(action));
-	if (ret && !(xe_device_wedged(pc_to_xe(pc)) && ret == -ECANCELED))
+	if (ret && !(xe_device_io_blocked(pc_to_xe(pc)) && ret == -ECANCELED))
 		xe_gt_err(pc_to_gt(pc), "GuC PC query task state failed: %pe\n",
 			  ERR_PTR(ret));
 
@@ -235,7 +235,7 @@ static int pc_action_set_param(struct xe_guc_pc *pc, u8 id, u32 value)
 		return -EAGAIN;
 
 	ret = xe_guc_ct_send(ct, action, ARRAY_SIZE(action), 0, 0);
-	if (ret && !(xe_device_wedged(pc_to_xe(pc)) && ret == -ECANCELED))
+	if (ret && !(xe_device_io_blocked(pc_to_xe(pc)) && ret == -ECANCELED))
 		xe_gt_err(pc_to_gt(pc), "GuC PC set param[%u]=%u failed: %pe\n",
 			  id, value, ERR_PTR(ret));
 
@@ -257,7 +257,7 @@ static int pc_action_unset_param(struct xe_guc_pc *pc, u8 id)
 		return -EAGAIN;
 
 	ret = xe_guc_ct_send(ct, action, ARRAY_SIZE(action), 0, 0);
-	if (ret && !(xe_device_wedged(pc_to_xe(pc)) && ret == -ECANCELED))
+	if (ret && !(xe_device_io_blocked(pc_to_xe(pc)) && ret == -ECANCELED))
 		xe_gt_err(pc_to_gt(pc), "GuC PC unset param failed: %pe",
 			  ERR_PTR(ret));
 
@@ -1357,7 +1357,7 @@ static void xe_guc_pc_fini_hw(void *arg)
 	struct xe_guc_pc *pc = arg;
 	struct xe_device *xe = pc_to_xe(pc);
 
-	if (xe_device_wedged(xe))
+	if (xe_device_io_blocked(xe))
 		return;
 
 	xe_guc_pc_stop(pc);
diff --git a/drivers/gpu/drm/xe/xe_guc_rc.c b/drivers/gpu/drm/xe/xe_guc_rc.c
index 99fa127b261f..eb5ec443f7ee 100644
--- a/drivers/gpu/drm/xe/xe_guc_rc.c
+++ b/drivers/gpu/drm/xe/xe_guc_rc.c
@@ -40,7 +40,7 @@ static int guc_action_setup_gucrc(struct xe_guc *guc, u32 control)
 	int ret;
 
 	ret = xe_guc_ct_send(&guc->ct, action, ARRAY_SIZE(action), 0, 0);
-	if (ret && !(xe_device_wedged(guc_to_xe(guc)) && ret == -ECANCELED))
+	if (ret && !(xe_device_io_blocked(guc_to_xe(guc)) && ret == -ECANCELED))
 		xe_gt_err(guc_to_gt(guc),
 			  "GuC RC setup %s(%u) failed (%pe)\n",
 			   control == GUCRC_HOST_CONTROL ? "HOST_CONTROL" :
@@ -73,7 +73,7 @@ static void xe_guc_rc_fini_hw(void *arg)
 	struct xe_device *xe = guc_to_xe(guc);
 	struct xe_gt *gt = guc_to_gt(guc);
 
-	if (xe_device_wedged(xe))
+	if (xe_device_io_blocked(xe))
 		return;
 
 	CLASS(xe_force_wake, fw_ref)(gt_to_fw(gt), XE_FW_GT);
diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
index bc39cea08ecc..49417620dad3 100644
--- a/drivers/gpu/drm/xe/xe_guc_submit.c
+++ b/drivers/gpu/drm/xe/xe_guc_submit.c
@@ -2556,7 +2556,7 @@ static int guc_exec_queue_wait_suspend_done(struct xe_exec_queue *q, bool blocki
 						       WAIT_COND, HZ * 5);
 	}
 
-	if (!blocking && vf_recovery(guc) && !xe_device_wedged(xe))
+	if (!blocking && vf_recovery(guc) && !xe_device_io_blocked(xe))
 		return -EAGAIN;
 
 	if (!ret)
@@ -2816,7 +2816,11 @@ int xe_guc_submit_reset_prepare(struct xe_guc *guc)
 
 void xe_guc_submit_reset_wait(struct xe_guc *guc)
 {
-	wait_event(guc->ct.wq, xe_device_wedged(guc_to_xe(guc)) ||
+	/*
+	 * AER sets in_reset before declaring the GT wedged, which wakes this
+	 * waitqueue.
+	 */
+	wait_event(guc->ct.wq, xe_device_io_blocked(guc_to_xe(guc)) ||
 		   !xe_guc_read_stopped(guc));
 }
 
diff --git a/drivers/gpu/drm/xe/xe_guc_tlb_inval.c b/drivers/gpu/drm/xe/xe_guc_tlb_inval.c
index 111fef781b2a..8daa9c968f4f 100644
--- a/drivers/gpu/drm/xe/xe_guc_tlb_inval.c
+++ b/drivers/gpu/drm/xe/xe_guc_tlb_inval.c
@@ -34,6 +34,9 @@ static int send_tlb_inval(struct xe_guc *guc, const u32 *action, int len)
 
 	xe_gt_assert(gt, action[1]);	/* Seqno */
 
+	if (xe_device_io_blocked(guc_to_xe(guc)))
+		return -ECANCELED;
+
 	xe_gt_stats_incr(gt, XE_GT_STATS_ID_TLB_INVAL, 1);
 	return xe_guc_ct_send(&guc->ct, action, len,
 			      G2H_LEN_DW_TLB_INVALIDATE, 1);
@@ -69,6 +72,9 @@ static int send_tlb_inval_ggtt(struct xe_tlb_inval *tlb_inval, u32 seqno)
 	 * signals waiters.
 	 */
 
+	if (xe_device_io_blocked(xe))
+		return -ECANCELED;
+
 	if (xe_guc_ct_enabled(&guc->ct) && guc->submission_state.enabled) {
 		u32 action[] = {
 			XE_GUC_ACTION_TLB_INVALIDATION,
@@ -77,7 +83,7 @@ static int send_tlb_inval_ggtt(struct xe_tlb_inval *tlb_inval, u32 seqno)
 		};
 
 		return send_tlb_inval(guc, action, ARRAY_SIZE(action));
-	} else if (xe_device_uc_enabled(xe) && !xe_device_wedged(xe)) {
+	} else if (xe_device_uc_enabled(xe)) {
 		struct xe_mmio *mmio = &gt->mmio;
 
 		if (IS_SRIOV_VF(xe))
diff --git a/drivers/gpu/drm/xe/xe_pci_error.c b/drivers/gpu/drm/xe/xe_pci_error.c
index 79ce0c671549..4b09e74af92e 100644
--- a/drivers/gpu/drm/xe/xe_pci_error.c
+++ b/drivers/gpu/drm/xe/xe_pci_error.c
@@ -9,7 +9,6 @@
 #include "xe_gt.h"
 #include "xe_log.h"
 #include "xe_pci.h"
-#include "xe_pm.h"
 #include "xe_printk.h"
 #include "xe_ras.h"
 #include "xe_survivability_mode.h"
@@ -20,14 +19,7 @@ static void prepare_device_for_reset(struct pci_dev *pdev)
 	struct xe_gt *gt;
 	u8 id;
 
-	/*
-	 * Wedge the device to prevent userspace access but do not send the uevent.
-	 * xe_device_wedged_fini() releases runtime pm if wedged flag is set, so acquire a runtime
-	 * pm reference to avoid underflow.
-	 */
-	if (!atomic_xchg(&xe->wedged.flag, 1))
-		xe_pm_runtime_get_noresume(xe);
-
+	/* Block device access until PCI error recovery completes. */
 	xe_device_set_in_reset(xe);
 
 	for_each_gt(gt, xe, id)
@@ -116,7 +108,6 @@ static pci_ers_result_t xe_pci_error_slot_reset(struct pci_dev *pdev)
 	 * TODO: optimize by re-initializing only the hardware state and re-creating
 	 * kernel BOs.
 	 */
-	xe_device_clear_in_reset(xe);
 	pdev->driver->remove(pdev);
 	devres_release_group(&pdev->dev, xe->devres_group);
 
@@ -125,8 +116,8 @@ static pci_ers_result_t xe_pci_error_slot_reset(struct pci_dev *pdev)
 
 	xe = pdev_to_xe_device(pdev);
 
-	/* Wedge the device to prevent I/O operations till the resume callback */
-	atomic_set(&xe->wedged.flag, 1);
+	/* Block the new instance until the resume callback. */
+	xe_device_set_in_reset(xe);
 
 	return PCI_ERS_RESULT_RECOVERED;
 }
@@ -137,7 +128,8 @@ static void xe_pci_error_resume(struct pci_dev *pdev)
 
 	xe_info(xe, "PCI error: resume\n");
 
-	atomic_set(&xe->wedged.flag, 0);
+	/* Resume I/O operations. */
+	xe_device_clear_in_reset(xe);
 }
 
 const struct pci_error_handlers xe_pci_error_handlers = {
diff --git a/drivers/gpu/drm/xe/xe_sriov_pf.c b/drivers/gpu/drm/xe/xe_sriov_pf.c
index 33bd754d138f..568b7ed7c380 100644
--- a/drivers/gpu/drm/xe/xe_sriov_pf.c
+++ b/drivers/gpu/drm/xe/xe_sriov_pf.c
@@ -157,7 +157,7 @@ int xe_sriov_pf_wait_ready(struct xe_device *xe)
 	unsigned int id;
 	int err;
 
-	if (xe_device_wedged(xe))
+	if (xe_device_io_blocked(xe))
 		return -ECANCELED;
 
 	for_each_gt(gt, xe, id) {
-- 
2.43.0

