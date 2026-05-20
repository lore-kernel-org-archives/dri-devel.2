Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FBCDCD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 11:37:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D39A210F031;
	Wed, 20 May 2026 11:36:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="GrV3pcU+";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB73010F031;
 Wed, 20 May 2026 11:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779277019; x=1810813019;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2iW4SiMEgHjRhPTqQY/rZAZfyVg9/4STQOI9mCIVQTs=;
 b=GrV3pcU+HPG0MRRcx0efZItGiNIS+9WjbR6DOgo7O3rEpIe4mn30VlAN
 IM2AnAT7hEsTu71aN6t9JXQFrApwZzy01Y345v/cEVlg43xICQVoNhWyo
 vZonW+ZsO01RqS98nC8HASafnmXliEGxgr6x2zfov2+nZBb2zVcmpGFub
 lJ45aDBkyl3/Bpd1ATGNsAnQhyyDS01qKOV1Mrr+2ujv982g9T3UztV7g
 JrHfx9U6JjYU70bHU0AuJoQq/V3TOSfI9MlzXuMT93iIn4JRUST0baflY
 WVkb13USViez5wKB+kf0R/QRlAnAuiCpKqklVc8DQL/xm3egWC0SBPWH5 A==;
X-CSE-ConnectionGUID: rNliM8a5Qui60pU3bpVh/w==
X-CSE-MsgGUID: ZAvB1ZXSQBKLmFUt3Ll9wQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="84027472"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="84027472"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 04:36:59 -0700
X-CSE-ConnectionGUID: 0ilFZdhzRVGiQguSuX/sPw==
X-CSE-MsgGUID: rUx58sEsT3aNpt1Ws2uoAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="237153503"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by fmviesa007.fm.intel.com with ESMTP; 20 May 2026 04:36:53 -0700
From: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rodrigo.vivi@intel.com
Cc: andrealmeid@igalia.com, christian.koenig@amd.com, airlied@gmail.com,
 simona.vetter@ffwll.ch, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 anshuman.gupta@intel.com, badal.nilawar@intel.com, riana.tauro@intel.com,
 karthik.poosa@intel.com, sk.anirban@intel.com, raag.jadav@intel.com,
 Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Subject: [PATCH v6 1/5] Introduce Xe Uncorrectable Error Handling
Date: Wed, 20 May 2026 17:03:53 +0530
Message-ID: <20260520113351.171119-8-mallesh.koujalagi@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520113351.171119-7-mallesh.koujalagi@intel.com>
References: <20260520113351.171119-7-mallesh.koujalagi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

From: Riana Tauro <riana.tauro@intel.com>

DO NOT REVIEW. COMPILATION ONLY
This patch is from https://patchwork.freedesktop.org/series/160482/
Added only for Compilation.

Signed-off-by: Riana Tauro <riana.tauro@intel.com>
Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
---
 drivers/gpu/drm/xe/Makefile                   |   1 +
 drivers/gpu/drm/xe/xe_device.c                |  19 +-
 drivers/gpu/drm/xe/xe_device.h                |  15 +
 drivers/gpu/drm/xe/xe_device_types.h          |   6 +
 drivers/gpu/drm/xe/xe_gt.c                    |  14 +-
 drivers/gpu/drm/xe/xe_guc_submit.c            |   9 +-
 drivers/gpu/drm/xe/xe_pci.c                   |  10 +
 drivers/gpu/drm/xe/xe_pci_error.c             | 138 +++++
 drivers/gpu/drm/xe/xe_ras.c                   | 493 ++++++++++++++++++
 drivers/gpu/drm/xe/xe_ras.h                   |   5 +-
 drivers/gpu/drm/xe/xe_ras_types.h             | 215 ++++++++
 drivers/gpu/drm/xe/xe_survivability_mode.c    |  13 +-
 drivers/gpu/drm/xe/xe_sysctrl_event.c         |   2 +-
 drivers/gpu/drm/xe/xe_sysctrl_event_types.h   |   2 +-
 drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h |  11 +
 15 files changed, 933 insertions(+), 20 deletions(-)
 create mode 100644 drivers/gpu/drm/xe/xe_pci_error.c

diff --git a/drivers/gpu/drm/xe/Makefile b/drivers/gpu/drm/xe/Makefile
index 09661f079d03..091872771e98 100644
--- a/drivers/gpu/drm/xe/Makefile
+++ b/drivers/gpu/drm/xe/Makefile
@@ -101,6 +101,7 @@ xe-y += xe_bb.o \
 	xe_page_reclaim.o \
 	xe_pat.o \
 	xe_pci.o \
+	xe_pci_error.o \
 	xe_pci_rebar.o \
 	xe_pcode.o \
 	xe_pm.o \
diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index 576095cf0952..5a852e353258 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -61,6 +61,7 @@
 #include "xe_psmi.h"
 #include "xe_pxp.h"
 #include "xe_query.h"
+#include "xe_ras.h"
 #include "xe_shrinker.h"
 #include "xe_soc_remapper.h"
 #include "xe_survivability_mode.h"
@@ -963,6 +964,16 @@ int xe_device_probe(struct xe_device *xe)
 	if (err)
 		return err;
 
+	err = xe_soc_remapper_init(xe);
+	if (err)
+		return err;
+
+	err = xe_sysctrl_init(xe);
+	if (err)
+		return err;
+
+	xe_ras_init(xe);
+
 	/*
 	 * Now that GT is initialized (TTM in particular),
 	 * we can try to init display, and inherit the initial fb.
@@ -1003,10 +1014,6 @@ int xe_device_probe(struct xe_device *xe)
 
 	xe_nvm_init(xe);
 
-	err = xe_soc_remapper_init(xe);
-	if (err)
-		return err;
-
 	err = xe_heci_gsc_init(xe);
 	if (err)
 		return err;
@@ -1045,10 +1052,6 @@ int xe_device_probe(struct xe_device *xe)
 	if (err)
 		goto err_unregister_display;
 
-	err = xe_sysctrl_init(xe);
-	if (err)
-		goto err_unregister_display;
-
 	err = xe_device_sysfs_init(xe);
 	if (err)
 		goto err_unregister_display;
diff --git a/drivers/gpu/drm/xe/xe_device.h b/drivers/gpu/drm/xe/xe_device.h
index 355d69dc8f54..765e90f4220f 100644
--- a/drivers/gpu/drm/xe/xe_device.h
+++ b/drivers/gpu/drm/xe/xe_device.h
@@ -181,6 +181,21 @@ static inline bool xe_device_has_mert(const struct xe_device *xe)
 	return xe->info.has_mert;
 }
 
+static inline bool xe_device_is_in_reset(struct xe_device *xe)
+{
+	return atomic_read(&xe->in_reset);
+}
+
+static inline void xe_device_set_in_reset(struct xe_device *xe)
+{
+	atomic_set(&xe->in_reset, 1);
+}
+
+static inline void xe_device_clear_in_reset(struct xe_device *xe)
+{
+	atomic_set(&xe->in_reset, 0);
+}
+
 u32 xe_device_ccs_bytes(struct xe_device *xe, u64 size);
 
 void xe_device_snapshot_print(struct xe_device *xe, struct drm_printer *p);
diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index 32dd2ffbc796..f64e1a149cee 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -483,6 +483,9 @@ struct xe_device {
 	/** @needs_flr_on_fini: requests function-reset on fini */
 	bool needs_flr_on_fini;
 
+	/** @in_reset: Indicates if device is in reset */
+	atomic_t in_reset;
+
 	/** @wedged: Struct to control Wedged States and mode */
 	struct {
 		/** @wedged.flag: Xe device faced a critical error and is now blocked. */
@@ -495,6 +498,9 @@ struct xe_device {
 		bool inconsistent_reset;
 	} wedged;
 
+	/** @devres_group_id: id for devres group */
+	void *devres_group_id;
+
 	/** @bo_device: Struct to control async free of BOs */
 	struct xe_bo_dev {
 		/** @bo_device.async_free: Free worker */
diff --git a/drivers/gpu/drm/xe/xe_gt.c b/drivers/gpu/drm/xe/xe_gt.c
index 783eb6d631b5..c117f6cf5e3e 100644
--- a/drivers/gpu/drm/xe/xe_gt.c
+++ b/drivers/gpu/drm/xe/xe_gt.c
@@ -917,6 +917,9 @@ static void gt_reset_worker(struct work_struct *w)
 	if (xe_device_wedged(gt_to_xe(gt)))
 		goto err_pm_put;
 
+	if (xe_device_is_in_reset(gt_to_xe(gt)))
+		goto err_pm_put;
+
 	/* We only support GT resets with GuC submission */
 	if (!xe_device_uc_enabled(gt_to_xe(gt)))
 		goto err_pm_put;
@@ -977,18 +980,23 @@ static void gt_reset_worker(struct work_struct *w)
 
 void xe_gt_reset_async(struct xe_gt *gt)
 {
-	xe_gt_info(gt, "trying reset from %ps\n", __builtin_return_address(0));
+	struct xe_device *xe = gt_to_xe(gt);
+
+	if (xe_device_is_in_reset(xe))
+		return;
 
 	/* Don't do a reset while one is already in flight */
 	if (!xe_fault_inject_gt_reset() && xe_uc_reset_prepare(&gt->uc))
 		return;
 
+	xe_gt_info(gt, "trying reset from %ps\n", __builtin_return_address(0));
+
 	xe_gt_info(gt, "reset queued\n");
 
 	/* Pair with put in gt_reset_worker() if work is enqueued */
-	xe_pm_runtime_get_noresume(gt_to_xe(gt));
+	xe_pm_runtime_get_noresume(xe);
 	if (!queue_work(gt->ordered_wq, &gt->reset.worker))
-		xe_pm_runtime_put(gt_to_xe(gt));
+		xe_pm_runtime_put(xe);
 }
 
 void xe_gt_suspend_prepare(struct xe_gt *gt)
diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
index afd8cc7bd231..f21a1f709c4a 100644
--- a/drivers/gpu/drm/xe/xe_guc_submit.c
+++ b/drivers/gpu/drm/xe/xe_guc_submit.c
@@ -1514,7 +1514,7 @@ guc_exec_queue_timedout_job(struct drm_sched_job *drm_job)
 	 * If devcoredump not captured and GuC capture for the job is not ready
 	 * do manual capture first and decide later if we need to use it
 	 */
-	if (!exec_queue_killed(q) && !xe->devcoredump.captured &&
+	if (!xe_device_is_in_reset(xe) && !exec_queue_killed(q) && !xe->devcoredump.captured &&
 	    !xe_guc_capture_get_matching_and_lock(q)) {
 		/* take force wake before engine register manual capture */
 		CLASS(xe_force_wake, fw_ref)(gt_to_fw(q->gt), XE_FORCEWAKE_ALL);
@@ -1536,8 +1536,8 @@ guc_exec_queue_timedout_job(struct drm_sched_job *drm_job)
 	set_exec_queue_banned(q);
 
 	/* Kick job / queue off hardware */
-	if (!wedged && (exec_queue_enabled(primary) ||
-			exec_queue_pending_disable(primary))) {
+	if (!xe_device_is_in_reset(xe) && !wedged &&
+	    (exec_queue_enabled(primary) || exec_queue_pending_disable(primary))) {
 		int ret;
 
 		if (exec_queue_reset(primary))
@@ -1605,7 +1605,8 @@ guc_exec_queue_timedout_job(struct drm_sched_job *drm_job)
 
 	trace_xe_sched_job_timedout(job);
 
-	if (!exec_queue_killed(q))
+	/* Do not access device if in reset */
+	if (!xe_device_is_in_reset(xe) && !exec_queue_killed(q))
 		xe_devcoredump(q, job,
 			       "Timedout job - seqno=%u, lrc_seqno=%u, guc_id=%d, flags=0x%lx",
 			       xe_sched_job_seqno(job), xe_sched_job_lrc_seqno(job),
diff --git a/drivers/gpu/drm/xe/xe_pci.c b/drivers/gpu/drm/xe/xe_pci.c
index e2a1232c4fbf..b0b5f2fe7ba8 100644
--- a/drivers/gpu/drm/xe/xe_pci.c
+++ b/drivers/gpu/drm/xe/xe_pci.c
@@ -1063,6 +1063,7 @@ static int xe_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	const struct xe_device_desc *desc = (const void *)ent->driver_data;
 	const struct xe_subplatform_desc *subplatform_desc;
 	struct xe_device *xe;
+	void *devres_id;
 	int err;
 
 	xe_configfs_check_device(pdev);
@@ -1088,6 +1089,10 @@ static int xe_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (xe_display_driver_probe_defer(pdev))
 		return -EPROBE_DEFER;
 
+	devres_id = devres_open_group(&pdev->dev, NULL, GFP_KERNEL);
+	if (!devres_id)
+		return -ENOMEM;
+
 	err = pcim_enable_device(pdev);
 	if (err)
 		return err;
@@ -1096,6 +1101,8 @@ static int xe_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (IS_ERR(xe))
 		return PTR_ERR(xe);
 
+	xe->devres_group_id = devres_id;
+
 	pci_set_drvdata(pdev, &xe->drm);
 
 	xe_pm_assert_unbounded_bridge(xe);
@@ -1331,6 +1338,8 @@ static const struct dev_pm_ops xe_pm_ops = {
 };
 #endif
 
+extern const struct pci_error_handlers xe_pci_error_handlers;
+
 static struct pci_driver xe_pci_driver = {
 	.name = DRIVER_NAME,
 	.id_table = pciidlist,
@@ -1338,6 +1347,7 @@ static struct pci_driver xe_pci_driver = {
 	.remove = xe_pci_remove,
 	.shutdown = xe_pci_shutdown,
 	.sriov_configure = xe_pci_sriov_configure,
+	.err_handler = &xe_pci_error_handlers,
 #ifdef CONFIG_PM_SLEEP
 	.driver.pm = &xe_pm_ops,
 #endif
diff --git a/drivers/gpu/drm/xe/xe_pci_error.c b/drivers/gpu/drm/xe/xe_pci_error.c
new file mode 100644
index 000000000000..8d62bcbcbbb6
--- /dev/null
+++ b/drivers/gpu/drm/xe/xe_pci_error.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright © 2026 Intel Corporation
+ */
+#include <linux/pci.h>
+
+#include <drm/drm_drv.h>
+
+#include "xe_device.h"
+#include "xe_gt.h"
+#include "xe_pci.h"
+#include "xe_ras.h"
+#include "xe_survivability_mode.h"
+#include "xe_uc.h"
+
+static pci_ers_result_t ras_action_to_pci_result(enum xe_ras_recovery_action action)
+{
+	switch (action) {
+	case XE_RAS_RECOVERY_ACTION_RECOVERED:
+		return PCI_ERS_RESULT_RECOVERED;
+	case XE_RAS_RECOVERY_ACTION_RESET:
+		return PCI_ERS_RESULT_NEED_RESET;
+	case XE_RAS_RECOVERY_ACTION_DISCONNECT:
+		return PCI_ERS_RESULT_DISCONNECT;
+	default:
+		return PCI_ERS_RESULT_DISCONNECT;
+	}
+}
+
+static void xe_pci_error_handling(struct pci_dev *pdev)
+{
+	struct xe_device *xe = pdev_to_xe_device(pdev);
+	struct xe_gt *gt;
+	u8 id;
+
+	/*
+	 * Wedge the device to prevent userspace access but don't send the event yet.
+	 * Runtime PM ref is taken by PCI core for the duration of error handling.
+	 */
+	xe_device_set_in_reset(xe);
+	atomic_set(&xe->wedged.flag, 1);
+
+	for_each_gt(gt, xe, id)
+		xe_gt_declare_wedged(gt);
+
+	pci_disable_device(pdev);
+}
+
+static pci_ers_result_t xe_pci_error_detected(struct pci_dev *pdev, pci_channel_state_t state)
+{
+	struct xe_device *xe = pdev_to_xe_device(pdev);
+
+	dev_err(&pdev->dev, "Xe Pci error recovery: error detected state %d\n", state);
+
+	if (state == pci_channel_io_perm_failure)
+		return PCI_ERS_RESULT_DISCONNECT;
+
+	/* If the device is already wedged or in survivability mode, do not attempt recovery */
+	if (xe_survivability_mode_is_boot_enabled(xe) || xe_device_wedged(xe))
+		return PCI_ERS_RESULT_DISCONNECT;
+
+	switch (state) {
+	case pci_channel_io_normal:
+		return PCI_ERS_RESULT_CAN_RECOVER;
+	case pci_channel_io_frozen:
+		xe_pci_error_handling(pdev);
+		return PCI_ERS_RESULT_NEED_RESET;
+	default:
+		dev_err(&pdev->dev, "Unknown state %d\n", state);
+		return PCI_ERS_RESULT_NEED_RESET;
+	}
+}
+
+static pci_ers_result_t xe_pci_error_mmio_enabled(struct pci_dev *pdev)
+{
+	struct xe_device *xe = pdev_to_xe_device(pdev);
+	enum xe_ras_recovery_action action;
+
+	dev_err(&pdev->dev, "Xe Pci error recovery: MMIO enabled\n");
+
+	action = xe_ras_process_errors(xe);
+
+	return ras_action_to_pci_result(action);
+}
+
+static pci_ers_result_t xe_pci_error_slot_reset(struct pci_dev *pdev)
+{
+	const struct pci_device_id *ent = pci_match_id(pdev->driver->id_table, pdev);
+	struct xe_device *xe = pdev_to_xe_device(pdev);
+
+	dev_err(&pdev->dev, "Xe Pci error recovery: Slot reset\n");
+
+	pci_restore_state(pdev);
+
+	if (pci_enable_device(pdev)) {
+		dev_err(&pdev->dev,
+			"Cannot re-enable PCI device after reset\n");
+		return PCI_ERS_RESULT_DISCONNECT;
+	}
+
+	/*
+	 * Secondary Bus Reset causes all VRAM state to be lost along with
+	 * hardware state. As an initial step, re-probe the device to
+	 * re-initialize the driver and hardware.
+	 * TODO: optimize by re-initializing only the hardware state and re-creating
+	 * kernel BOs.
+	 */
+	xe_device_clear_in_reset(xe);
+	pdev->driver->remove(pdev);
+	devres_release_group(&pdev->dev, xe->devres_group_id);
+
+	if (pdev->driver->probe(pdev, ent))
+		return PCI_ERS_RESULT_DISCONNECT;
+
+	xe = pdev_to_xe_device(pdev);
+
+	/* Wedge the device to prevent I/O operations till the resume callback */
+	atomic_set(&xe->wedged.flag, 1);
+
+	return PCI_ERS_RESULT_RECOVERED;
+}
+
+static void xe_pci_error_resume(struct pci_dev *pdev)
+{
+	struct xe_device *xe = pdev_to_xe_device(pdev);
+
+	dev_info(&pdev->dev, "Xe Pci error recovery: Recovered\n");
+
+	/* Resume I/O operations */
+	atomic_set(&xe->wedged.flag, 0);
+}
+
+const struct pci_error_handlers xe_pci_error_handlers = {
+	.error_detected	= xe_pci_error_detected,
+	.mmio_enabled	= xe_pci_error_mmio_enabled,
+	.slot_reset	= xe_pci_error_slot_reset,
+	.resume		= xe_pci_error_resume,
+};
diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
index 4cb16b419b0c..d79f8a6589ac 100644
--- a/drivers/gpu/drm/xe/xe_ras.c
+++ b/drivers/gpu/drm/xe/xe_ras.c
@@ -3,12 +3,18 @@
  * Copyright © 2026 Intel Corporation
  */
 
+#include "xe_bo.h"
 #include "xe_device.h"
 #include "xe_printk.h"
 #include "xe_ras.h"
 #include "xe_ras_types.h"
 #include "xe_sysctrl.h"
 #include "xe_sysctrl_event_types.h"
+#include "xe_sysctrl_mailbox.h"
+#include "xe_sysctrl_mailbox_types.h"
+
+#define CORE_COMPUTE_UNCORR_TYPE	GENMASK(26, 25)
+#define  GLOBAL_UNCORR_ERROR		2
 
 /* Severity of detected errors  */
 enum xe_ras_severity {
@@ -31,12 +37,25 @@ enum xe_ras_component {
 	XE_RAS_COMP_MAX
 };
 
+static const int ras_status_to_errno_map[] = {
+	[XE_RAS_STATUS_SUCCESS]			= 0,
+	[XE_RAS_STATUS_INVALID_PARAM]		= -EINVAL,
+	[XE_RAS_STATUS_OP_NOT_SUPPORTED]	= -EOPNOTSUPP,
+	[XE_RAS_STATUS_TIMEOUT]			= -ETIMEDOUT,
+	[XE_RAS_STATUS_HARDWARE_FAILURE]	= -EIO,
+	[XE_RAS_STATUS_INSUFFICIENT_RESOURCES]	= -ENAVAIL,
+	[XE_RAS_STATUS_UNKNOWN_ERROR]		= -ENODATA
+};
+
+static_assert(ARRAY_SIZE(ras_status_to_errno_map) == XE_RAS_STATUS_UNKNOWN_ERROR + 1);
+
 static const char *const xe_ras_severities[] = {
 	[XE_RAS_SEV_NOT_SUPPORTED]		= "Not Supported",
 	[XE_RAS_SEV_CORRECTABLE]		= "Correctable Error",
 	[XE_RAS_SEV_UNCORRECTABLE]		= "Uncorrectable Error",
 	[XE_RAS_SEV_INFORMATIONAL]		= "Informational Error",
 };
+
 static_assert(ARRAY_SIZE(xe_ras_severities) == XE_RAS_SEV_MAX);
 
 static const char *const xe_ras_components[] = {
@@ -48,6 +67,7 @@ static const char *const xe_ras_components[] = {
 	[XE_RAS_COMP_FABRIC]			= "Fabric",
 	[XE_RAS_COMP_SOC_INTERNAL]		= "SoC Internal",
 };
+
 static_assert(ARRAY_SIZE(xe_ras_components) == XE_RAS_COMP_MAX);
 
 static inline const char *sev_to_str(u8 severity)
@@ -66,6 +86,296 @@ static inline const char *comp_to_str(u8 component)
 	return xe_ras_components[component];
 }
 
+static int ras_status_to_errno(enum xe_ras_response_status status)
+{
+	if (status > XE_RAS_STATUS_UNKNOWN_ERROR)
+		status = XE_RAS_STATUS_UNKNOWN_ERROR;
+
+	return ras_status_to_errno_map[status];
+}
+
+static void prepare_ras_command(struct xe_sysctrl_mailbox_command *command,
+				u32 cmd_mask, void *request, size_t request_len,
+				void *response, size_t response_len)
+{
+	struct xe_sysctrl_app_msg_hdr hdr = {0};
+
+	hdr.data = FIELD_PREP(APP_HDR_GROUP_ID_MASK, XE_SYSCTRL_GROUP_GFSP) |
+		   FIELD_PREP(APP_HDR_COMMAND_MASK, cmd_mask);
+
+	command->header = hdr;
+	command->data_in = request;
+	command->data_in_len = request_len;
+	command->data_out = response;
+	command->data_out_len = response_len;
+}
+
+static int send_page_offline(struct xe_device *xe, enum xe_ras_page_action action, u64 page_address)
+{
+	struct xe_sysctrl_mailbox_command command = {0};
+	struct xe_ras_page_offline_request request = {0};
+	struct xe_ras_page_offline_response response = {0};
+	size_t rlen;
+	int ret;
+
+	if (!xe->info.has_sysctrl)
+		return 0;
+
+	if (action >= XE_RAS_PAGE_ACTION_MAX) {
+		xe_err(xe, "[RAS]: Invalid page offline action %d\n", action);
+		return -EINVAL;
+	}
+
+	request.page_address = page_address;
+	request.action = action;
+
+	prepare_ras_command(&command, XE_SYSCTRL_CMD_PAGE_OFFLINE, &request,
+			    sizeof(request), &response, sizeof(response));
+
+	ret = xe_sysctrl_send_command(&xe->sc, &command, &rlen);
+	if (ret) {
+		xe_err(xe, "sysctrl: failed to send page offline command %d\n", ret);
+		return ret;
+	}
+
+	if (rlen != sizeof(response)) {
+		xe_err(xe, "sysctrl: unexpected page offline response length %zu (expected %zu)\n",
+		       rlen, sizeof(response));
+		return -EINVAL;
+	}
+
+	ret = ras_status_to_errno(response.status);
+	if (ret)
+		xe_err(xe, "sysctrl: page offline command failed with status %d\n",
+		       response.status);
+
+	return ret;
+}
+
+static int handle_page_offline(struct xe_device *xe, u64 page_address, bool send_offline_cmd)
+{
+	enum xe_ras_page_action action;
+	int ret;
+
+	if (!IS_ALIGNED(page_address, XE_PAGE_SIZE)) {
+		xe_err(xe, "sysctrl: Unaligned page address: 0x%llx\n", page_address);
+		return -EINVAL;
+	}
+
+	/*
+	 * TODO: Call function to handle address fault
+	 * ret = xe_ttm_vram_handle_addr_fault(xe, page_address);
+	 */
+
+	/*
+	 * Handle return code from address fault handling function:
+	 *  0: Address is valid and can be offlined
+	 * -EIO: Address belongs to a critical BO that cannot be offlined
+	 * -ENXIO: Invalid address
+	 * -EOPNOTSUPP: Address is valid and can be offlined but user policy is not to offline
+	 *
+	 * For any other non-zero error code, skip offlining.
+	 */
+
+	switch (ret) {
+	case 0:
+		action = XE_RAS_PAGE_ACTION_OFFLINE;
+		break;
+	/* User policy set to decline page offlining */
+	case -EOPNOTSUPP:
+		action = XE_RAS_PAGE_ACTION_DECLINE;
+		break;
+	case -EIO:
+		xe_err(xe, "[RAS]: Page address belongs to critical BO: 0x%llx\n",
+		       page_address);
+		return ret;
+	default:
+		xe_err(xe, "[RAS]: Failed to handle address fault 0x%llx: %d\n",
+		       page_address, ret);
+		return 0;
+	}
+
+	if (send_offline_cmd) {
+		ret = send_page_offline(xe, action, page_address);
+		if (ret)
+			xe_err(xe, "sysctrl: Failed to offline page for address 0x%llx: %d\n",
+			       page_address, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static enum xe_ras_recovery_action handle_core_compute_errors(struct xe_device *xe,
+							      struct xe_ras_error_array *arr)
+{
+	struct xe_ras_compute_error *error_info = (struct xe_ras_compute_error *)arr->error_details;
+	u8 uncorr_type;
+
+	uncorr_type = FIELD_GET(CORE_COMPUTE_UNCORR_TYPE, error_info->error_log_header);
+
+	/* Request a reset if error is global */
+	if (uncorr_type == GLOBAL_UNCORR_ERROR)
+		return XE_RAS_RECOVERY_ACTION_RESET;
+
+	/* Local errors are recovered using an engine reset by GuC */
+	return XE_RAS_RECOVERY_ACTION_RECOVERED;
+}
+
+static enum xe_ras_recovery_action handle_soc_internal_errors(struct xe_device *xe,
+							      struct xe_ras_error_array *arr)
+{
+	struct xe_ras_soc_error *error_info = (struct xe_ras_soc_error *)arr->error_details;
+	struct xe_ras_soc_error_source *source = &error_info->error_source;
+	struct xe_ras_error_class *error_class = &arr->error_class;
+	u8 tile_id = error_class->product.unit.tile;
+	struct xe_tile *tile;
+
+	if (tile_id >= xe->info.tile_count) {
+		xe_err(xe, "sysctrl: SOC internal error reported from invalid tile %u\n", tile_id);
+		return XE_RAS_RECOVERY_ACTION_RESET;
+	}
+
+	tile = &xe->tiles[tile_id];
+
+	if (source->csc) {
+		struct xe_ras_csc_error *csc_error =
+			(struct xe_ras_csc_error *)error_info->additional_details;
+
+		/*
+		 * CSC uncorrectable errors are classified as hardware errors and firmware errors.
+		 * CSC firmware errors are critical errors that can be recovered only by firmware
+		 * update via SPI driver. On a CSC firmware error, PCODE enables FDO mode and sets
+		 * the bit in the capability register. On receiving this error, the driver enables
+		 * runtime survivability mode which notifies userspace that a firmware update
+		 * is required.
+		 */
+		if (csc_error->hec_uncorr_fw_err_dw0) {
+			xe_err(xe, "[RAS]: CSC %s detected: 0x%x\n",
+			       sev_to_str(error_class->common.severity),
+			       csc_error->hec_uncorr_fw_err_dw0);
+			schedule_work(&tile->csc_hw_error_work);
+			return XE_RAS_RECOVERY_ACTION_DISCONNECT;
+		}
+	} else if (source->ieh) {
+		struct xe_ras_ieh_error *ieh_error =
+			(struct xe_ras_ieh_error *)error_info->additional_details;
+
+		if (ieh_error->global_error_status & XE_RAS_SOC_IEH_PUNIT) {
+			xe_err(xe, "[RAS]: PUNIT %s detected: 0x%x\n",
+			       sev_to_str(error_class->common.severity),
+			       ieh_error->global_error_status);
+			/* TODO: Add PUNIT error handling */
+			return XE_RAS_RECOVERY_ACTION_DISCONNECT;
+		}
+	}
+
+	/* For other SOC internal errors, request a reset as recovery mechanism */
+	return XE_RAS_RECOVERY_ACTION_RESET;
+}
+
+static enum xe_ras_recovery_action handle_device_memory_errors(struct xe_device *xe,
+							       struct xe_ras_error_array *arr)
+{
+	struct xe_ras_memory_error *error_info = (struct xe_ras_memory_error *)arr->error_details;
+	int ret;
+
+	if (error_info->category & XE_RAS_MEMORY_ECC) {
+		xe_err(xe, "[RAS]: double-bit ECC error detected at sw address 0x%llx\n",
+		       error_info->sw_address);
+		ret = handle_page_offline(xe, error_info->sw_address, true);
+		if (!ret)
+			return XE_RAS_RECOVERY_ACTION_RECOVERED;
+	}
+
+	/* Request a reset for other device memory errors and if page offlining failed */
+	return XE_RAS_RECOVERY_ACTION_RESET;
+}
+
+static void get_queued_pages(struct xe_device *xe)
+{
+	struct xe_sysctrl_mailbox_command command = {0};
+	struct xe_ras_page_offline_queue response = {0};
+	u32 count = 0;
+	size_t rlen;
+	int ret, i;
+
+	/* Supported only on platforms with system controller */
+	if (!xe->info.has_sysctrl)
+		return;
+
+	prepare_ras_command(&command, XE_SYSCTRL_CMD_GET_OFFLINE_QUEUE, NULL, 0,
+			    &response, sizeof(response));
+
+	do {
+		memset(&response, 0, sizeof(response));
+
+		ret = xe_sysctrl_send_command(&xe->sc, &command, &rlen);
+		if (ret) {
+			xe_err(xe, "sysctrl: failed to get page offline queue %d\n", ret);
+			return;
+		}
+
+		if (rlen != sizeof(response)) {
+			xe_err(xe, "sysctrl: unexpected page offline queue response length %zu (expected %zu)\n",
+			       rlen, sizeof(response));
+			return;
+		}
+
+		for (i = 0; i < response.pages_returned && i < XE_RAS_NUM_PAGES; i++)
+			handle_page_offline(xe, response.page_addresses[i], true);
+
+		count += response.pages_returned;
+		if (count > response.total_pages) {
+			xe_err(xe, "sysctrl: Pages returned from queue exceed total pages %u, returned %u\n",
+			       response.total_pages, count);
+			return;
+		}
+	} while (response.additional_data);
+}
+
+static void get_offlined_list(struct xe_device *xe)
+{
+	struct xe_sysctrl_mailbox_command command = {0};
+	struct xe_ras_page_offline_list response = {0};
+	u32 count = 0;
+	size_t rlen;
+	int ret, i;
+
+	/* Supported only on platforms with system controller */
+	if (!xe->info.has_sysctrl)
+		return;
+
+	prepare_ras_command(&command, XE_SYSCTRL_CMD_GET_OFFLINE_LIST, NULL, 0,
+			    &response, sizeof(response));
+
+	do {
+		memset(&response, 0, sizeof(response));
+
+		ret = xe_sysctrl_send_command(&xe->sc, &command, &rlen);
+		if (ret) {
+			xe_err(xe, "sysctrl: failed to get page offline list %d\n", ret);
+			return;
+		}
+
+		if (rlen != sizeof(response)) {
+			xe_err(xe, "sysctrl: unexpected page offline list response length %zu (expected %zu)\n",
+			       rlen, sizeof(response));
+			return;
+		}
+
+		for (i = 0; i < response.pages_returned && i < XE_RAS_NUM_PAGES; i++)
+			handle_page_offline(xe, response.page_addresses[i], false);
+
+		count += response.pages_returned;
+		if (count > response.total_pages) {
+			xe_err(xe, "sysctrl: Pages returned from list exceed total pages %u, returned %u\n",
+			       response.total_pages, count);
+			return;
+		}
+	} while (response.additional_data);
+}
+
 void xe_ras_counter_threshold_crossed(struct xe_device *xe,
 				      struct xe_sysctrl_event_response *response)
 {
@@ -91,3 +401,186 @@ void xe_ras_counter_threshold_crossed(struct xe_device *xe,
 			comp_to_str(component), sev_to_str(severity));
 	}
 }
+
+/**
+ * xe_ras_process_errors() - Process and contain hardware errors
+ * @xe: xe device instance
+ *
+ * Get error details from system controller and return recovery
+ * method. Called only from PCI error handling.
+ *
+ * Returns: recovery action to be taken
+ */
+enum xe_ras_recovery_action xe_ras_process_errors(struct xe_device *xe)
+{
+	struct xe_sysctrl_mailbox_command command = {0};
+	struct xe_ras_get_soc_error response;
+	enum xe_ras_recovery_action final_action;
+	u32 count = XE_SYSCTRL_FLOOD;
+	size_t rlen;
+	int ret;
+
+	if (!xe->info.has_sysctrl)
+		return XE_RAS_RECOVERY_ACTION_RESET;
+
+	/* Default action */
+	final_action = XE_RAS_RECOVERY_ACTION_RECOVERED;
+
+	prepare_ras_command(&command, XE_SYSCTRL_CMD_GET_SOC_ERROR, NULL, 0,
+			    &response, sizeof(response));
+
+	do {
+		memset(&response, 0, sizeof(response));
+
+		ret = xe_sysctrl_send_command(&xe->sc, &command, &rlen);
+		if (ret) {
+			xe_err(xe, "sysctrl: failed to get soc error %d\n", ret);
+			goto err;
+		}
+
+		if (rlen != sizeof(response)) {
+			xe_err(xe, "sysctrl: unexpected get soc error response length %zu (expected %zu)\n",
+			       rlen, sizeof(response));
+			goto err;
+		}
+
+		/* Report if number of errors exceeds the maximum errors supported */
+		if (response.num_errors > XE_RAS_NUM_ERROR_ARR)
+			xe_err(xe, "sysctrl: number of errors received %d out of bound (%d)\n",
+			       response.num_errors, XE_RAS_NUM_ERROR_ARR);
+
+		for (int i = 0; i < response.num_errors && i < XE_RAS_NUM_ERROR_ARR; i++) {
+			struct xe_ras_error_array *arr = &response.error_arr[i];
+			enum xe_ras_recovery_action action;
+			struct xe_ras_error_class error_class;
+			u8 component, severity;
+
+			error_class = arr->error_class;
+			component = error_class.common.component;
+			severity = error_class.common.severity;
+
+			xe_err(xe, "[RAS]: %s %s detected\n", comp_to_str(component),
+			       sev_to_str(severity));
+
+			switch (component) {
+			case XE_RAS_COMP_CORE_COMPUTE:
+				action = handle_core_compute_errors(xe, arr);
+				break;
+			case XE_RAS_COMP_SOC_INTERNAL:
+				action = handle_soc_internal_errors(xe, arr);
+				break;
+			case XE_RAS_COMP_DEVICE_MEMORY:
+				action = handle_device_memory_errors(xe, arr);
+				break;
+			default:
+				/* For any other component, reset */
+				action = XE_RAS_RECOVERY_ACTION_RESET;
+				break;
+			}
+
+			/* Process and log all errors and then trigger highest recovery action */
+			if (action > final_action)
+				final_action = action;
+		}
+
+		/* Treat flooding as an system controller error */
+		if (!--count) {
+			xe_err(xe, "[RAS]: sysctrl: get soc error response flooding\n");
+			return XE_RAS_RECOVERY_ACTION_RESET;
+		}
+
+	} while (response.additional_errors);
+
+	return final_action;
+
+err:
+	return XE_RAS_RECOVERY_ACTION_RESET;
+}
+
+#ifdef CONFIG_PCIEAER
+static void aer_unmask_and_downgrade_internal_error(struct xe_device *xe)
+{
+	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
+	struct pci_dev *vsp, *usp;
+	u32 aer_uncorr_mask, aer_uncorr_sev, aer_uncorr_status;
+	u16 aer_cap;
+
+	/*
+	 * Device Hierarchy:
+	 *
+	 * Upstream Switch Port (USP)--> Virtual Switch Port (VSP)--> SGunit (GPU endpoint)
+	 */
+	vsp = pci_upstream_bridge(pdev);
+	if (!vsp)
+		return;
+
+	usp = pci_upstream_bridge(vsp);
+	if (!usp)
+		return;
+
+	aer_cap = usp->aer_cap;
+
+	if (!aer_cap) {
+		dev_info(&usp->dev, "USP doesn't support AER capability\n");
+		return;
+	}
+
+	/*
+	 * Clear any stale Uncorrectable Internal Error Status event in Uncorrectable Error
+	 * Status Register.
+	 */
+	pci_read_config_dword(usp, aer_cap + PCI_ERR_UNCOR_STATUS, &aer_uncorr_status);
+	if (aer_uncorr_status & PCI_ERR_UNC_INTN)
+		pci_write_config_dword(usp, aer_cap + PCI_ERR_UNCOR_STATUS, PCI_ERR_UNC_INTN);
+
+	/*
+	 * All errors are steered to USP which is a PCIe AER Compliant device.
+	 * Downgrade all the errors to non-fatal to prevent PCIe bus driver
+	 * from triggering a Secondary Bus Reset (SBR). This allows error
+	 * detection, containment and recovery in the driver.
+	 *
+	 * The Uncorrectable Error Severity Register has the 'Uncorrectable
+	 * Internal Error Severity' set to fatal by default. Set this to
+	 * non-fatal and unmask the error.
+	 */
+
+	/* Initialize Uncorrectable Error Severity Register */
+	pci_read_config_dword(usp, aer_cap + PCI_ERR_UNCOR_SEVER, &aer_uncorr_sev);
+	aer_uncorr_sev &= ~PCI_ERR_UNC_INTN;
+	pci_write_config_dword(usp, aer_cap + PCI_ERR_UNCOR_SEVER, aer_uncorr_sev);
+
+	/* Initialize Uncorrectable Error Mask Register */
+	pci_read_config_dword(usp, aer_cap + PCI_ERR_UNCOR_MASK, &aer_uncorr_mask);
+	aer_uncorr_mask &= ~PCI_ERR_UNC_INTN;
+	pci_write_config_dword(usp, aer_cap + PCI_ERR_UNCOR_MASK, aer_uncorr_mask);
+
+	pci_save_state(usp);
+	dev_dbg(&usp->dev, "Uncorrectable Internal Errors downgraded and unmasked\n");
+}
+#endif
+
+/**
+ * xe_ras_init - Initialize Xe RAS
+ * @xe: xe device instance
+ *
+ * Initialize Xe RAS
+ */
+void xe_ras_init(struct xe_device *xe)
+{
+	if (!xe->info.has_sysctrl || IS_SRIOV_VF(xe))
+		return;
+
+#ifdef CONFIG_PCIEAER
+	aer_unmask_and_downgrade_internal_error(xe);
+#endif
+
+	get_queued_pages(xe);
+	get_offlined_list(xe);
+
+	/*
+	 * On init, process and log any errors detected by firmware before driver load.
+	 * Critical errors such as Punit, CSC are reported through PCode init failure,
+	 * causing the driver to enter survivability mode.
+	 */
+	xe_ras_process_errors(xe);
+}
diff --git a/drivers/gpu/drm/xe/xe_ras.h b/drivers/gpu/drm/xe/xe_ras.h
index ea90593b62dc..cdaad3114dae 100644
--- a/drivers/gpu/drm/xe/xe_ras.h
+++ b/drivers/gpu/drm/xe/xe_ras.h
@@ -6,10 +6,13 @@
 #ifndef _XE_RAS_H_
 #define _XE_RAS_H_
 
+#include "xe_ras_types.h"
+
 struct xe_device;
 struct xe_sysctrl_event_response;
 
 void xe_ras_counter_threshold_crossed(struct xe_device *xe,
 				      struct xe_sysctrl_event_response *response);
-
+void xe_ras_init(struct xe_device *xe);
+enum xe_ras_recovery_action xe_ras_process_errors(struct xe_device *xe);
 #endif
diff --git a/drivers/gpu/drm/xe/xe_ras_types.h b/drivers/gpu/drm/xe/xe_ras_types.h
index 4e63c67f806a..3ec64b4f5a17 100644
--- a/drivers/gpu/drm/xe/xe_ras_types.h
+++ b/drivers/gpu/drm/xe/xe_ras_types.h
@@ -8,7 +8,63 @@
 
 #include <linux/types.h>
 
+#define XE_RAS_NUM_ERROR_ARR			3
 #define XE_RAS_NUM_COUNTERS			16
+#define XE_RAS_SOC_IEH_PUNIT			BIT(1)
+#define XE_RAS_MEMORY_ECC			BIT(1)
+#define XE_RAS_NUM_PAGES			25
+
+/**
+ * enum xe_ras_recovery_action - RAS recovery actions
+ *
+ * @XE_RAS_RECOVERY_ACTION_RECOVERED: Error recovered
+ * @XE_RAS_RECOVERY_ACTION_RESET: Requires reset
+ * @XE_RAS_RECOVERY_ACTION_DISCONNECT: Requires disconnect
+ * @XE_RAS_RECOVERY_ACTION_MAX: Max action value
+ *
+ * This enum defines the possible recovery actions that can be taken in response
+ * to RAS errors.
+ */
+enum xe_ras_recovery_action {
+	XE_RAS_RECOVERY_ACTION_RECOVERED = 0,
+	XE_RAS_RECOVERY_ACTION_RESET,
+	XE_RAS_RECOVERY_ACTION_DISCONNECT,
+	XE_RAS_RECOVERY_ACTION_MAX
+};
+
+/**
+ * enum xe_ras_page_action - Page offline actions for page offline request
+ *
+ * @XE_RAS_PAGE_ACTION_OFFLINE: Instruct firmware to remove page from queue
+ * @XE_RAS_PAGE_ACTION_DECLINE: Instruct firmware to mark page as not offline
+ * @XE_RAS_PAGE_ACTION_MAX: Max value for validation
+ */
+enum xe_ras_page_action {
+	XE_RAS_PAGE_ACTION_OFFLINE,
+	XE_RAS_PAGE_ACTION_DECLINE,
+	XE_RAS_PAGE_ACTION_MAX
+};
+
+/**
+ * enum xe_ras_response_status - RAS response status codes
+ *
+ * @XE_RAS_STATUS_SUCCESS: Operation successful
+ * @XE_RAS_STATUS_INVALID_PARAM: Invalid parameter
+ * @XE_RAS_STATUS_OP_NOT_SUPPORTED: Operation not supported
+ * @XE_RAS_STATUS_TIMEOUT: Operation timed out
+ * @XE_RAS_STATUS_HARDWARE_FAILURE: Hardware failure
+ * @XE_RAS_STATUS_INSUFFICIENT_RESOURCES: Insufficient resources
+ * @XE_RAS_STATUS_UNKNOWN_ERROR: Unknown error
+ */
+enum xe_ras_response_status {
+	XE_RAS_STATUS_SUCCESS = 0,
+	XE_RAS_STATUS_INVALID_PARAM,
+	XE_RAS_STATUS_OP_NOT_SUPPORTED,
+	XE_RAS_STATUS_TIMEOUT,
+	XE_RAS_STATUS_HARDWARE_FAILURE,
+	XE_RAS_STATUS_INSUFFICIENT_RESOURCES,
+	XE_RAS_STATUS_UNKNOWN_ERROR
+};
 
 /**
  * struct xe_ras_error_common - Error fields that are common across all products
@@ -70,4 +126,163 @@ struct xe_ras_threshold_crossed {
 	struct xe_ras_error_class counters[XE_RAS_NUM_COUNTERS];
 } __packed;
 
+/**
+ * struct xe_ras_error_array - Details of the error types
+ */
+struct xe_ras_error_array {
+	/** @counter_value: Counter value of the returned error */
+	u32 counter_value;
+	/** @error_class: Error class */
+	struct xe_ras_error_class error_class;
+	/** @timestamp: Timestamp */
+	u64 timestamp;
+	/** @error_details: Error details specific to the class */
+	u32 error_details[XE_RAS_NUM_COUNTERS];
+} __packed;
+
+/**
+ * struct xe_ras_get_soc_error - Response from get soc error command
+ */
+struct xe_ras_get_soc_error {
+	/** @num_errors: Number of errors reported in this response */
+	u8 num_errors;
+	/** @additional_errors: Indicates if the errors are pending */
+	u8 additional_errors;
+	/** @error_arr: Array of up to 3 errors */
+	struct xe_ras_error_array error_arr[XE_RAS_NUM_ERROR_ARR];
+} __packed;
+
+/**
+ * struct xe_ras_compute_error - Error details of Core Compute error
+ */
+struct xe_ras_compute_error {
+	/** @error_log_header: Error Source and type */
+	u32 error_log_header;
+	/** @reserved: Reserved */
+	u32 reserved[15];
+} __packed;
+
+/**
+ * struct xe_ras_soc_error_source - Source of SoC error
+ */
+struct xe_ras_soc_error_source {
+	/** @csc: CSC */
+	u32 csc:1;
+	/** @ieh: IEH (Integrated Error Handler) */
+	u32 ieh:1;
+	/** @reserved: Reserved for future use */
+	u32 reserved:30;
+} __packed;
+
+/**
+ * struct xe_ras_soc_error - Error details of SoC internal error
+ */
+struct xe_ras_soc_error {
+	/** @error_source: Error source */
+	struct xe_ras_soc_error_source error_source;
+	/** @additional_details: Additional details */
+	u32 additional_details[15];
+} __packed;
+
+/**
+ * struct xe_ras_csc_error - CSC error details
+ */
+struct xe_ras_csc_error {
+	/** @hec_uncorr_err_status: CSC hardware error status */
+	u32 hec_uncorr_err_status;
+	/** @hec_uncorr_fw_err_dw0: CSC firmware error */
+	u32 hec_uncorr_fw_err_dw0;
+} __packed;
+
+/**
+ * struct xe_ras_ieh_error - SoC IEH (Integrated Error Handler) error details
+ */
+struct xe_ras_ieh_error {
+	/** @ieh_instance: IEH instance */
+	u32 ieh_instance:2;
+	/** @reserved: Reserved for future use */
+	u32 reserved:30;
+	/** @global_error_status: Global error status */
+	u32 global_error_status;
+	/** @local_error_status: Local error status */
+	u32 local_error_status;
+	/** @gerr_mask: Global error mask */
+	u32 gerr_mask;
+	/** @additional_info: Additional information */
+	u32 additional_info[10];
+} __packed;
+
+/**
+ * struct xe_ras_memory_error - Device memory error details
+ */
+struct xe_ras_memory_error {
+	/** @category: Device memory error category */
+	u8 category;
+	/** @reserved: Reserved for future use */
+	u8 reserved[7];
+	/** @hardware_address: Hardware physical address details */
+	u64 hardware_address;
+	/** @sw_address: Software address where error occurred */
+	u64 sw_address;
+	/** @reserved2: Reserved for future use */
+	u32 reserved2[10];
+} __packed;
+
+/**
+ * struct xe_ras_page_offline_list - Response from get offline list command
+ */
+struct xe_ras_page_offline_list {
+	/** @max_entries: Total no of pages that can be stored in flash */
+	u32 max_entries;
+	/** @total_pages: Total number of permanently offlined pages */
+	u32 total_pages;
+	/** @pages_returned: Number of pages returned in this response */
+	u32 pages_returned;
+	/** @page_addresses: Array of permanently offlined page addresses (4KB aligned) */
+	u64 page_addresses[XE_RAS_NUM_PAGES];
+	/** @additional_data: Indicates if more data is available */
+	u8 additional_data;
+	/** @reserved: Reserved for future use */
+	u8 reserved[3];
+} __packed;
+
+/**
+ * struct xe_ras_page_offline_queue - Response from get offline queue command
+ */
+struct xe_ras_page_offline_queue {
+	/** @total_pages: Total number of queued pages */
+	u32 total_pages;
+	/** @pages_returned: Number of pages returned in this response */
+	u32 pages_returned;
+	/** @page_addresses: Array of page addresses (4KB aligned) */
+	u64 page_addresses[XE_RAS_NUM_PAGES];
+	/** @additional_data: Indicates if more data is available */
+	u8 additional_data;
+	/** @reserved: Reserved for future use */
+	u8 reserved[3];
+} __packed;
+
+/**
+ * struct xe_ras_page_offline_request - Request for page offline command
+ *
+ * This structure provides the request format to offline/decline a page
+ */
+struct xe_ras_page_offline_request {
+	/** @page_address: Page address (4KB aligned) */
+	u64 page_address;
+	/** @action: Action to be performed, see &enum xe_ras_page_action */
+	u32 action;
+	/** @reserved: Reserved for future use */
+	u32 reserved;
+} __packed;
+
+/**
+ * struct xe_ras_page_offline_response - Response from page offline command
+ */
+struct xe_ras_page_offline_response {
+	/** @status: Status of the page offline request, see &enum xe_ras_response_status */
+	u32 status;
+	/** @reserved: Reserved for future use */
+	u32 reserved;
+} __packed;
 #endif
diff --git a/drivers/gpu/drm/xe/xe_survivability_mode.c b/drivers/gpu/drm/xe/xe_survivability_mode.c
index 427afd144f3a..4c506027fa94 100644
--- a/drivers/gpu/drm/xe/xe_survivability_mode.c
+++ b/drivers/gpu/drm/xe/xe_survivability_mode.c
@@ -54,7 +54,6 @@
  *	# cat /sys/bus/pci/devices/<device>/survivability_mode
  *	  Boot
  *
- *
  * Any additional debug information if present will be visible under the directory
  * ``survivability_info``::
  *
@@ -98,6 +97,15 @@
  *	# cat /sys/bus/pci/devices/<device>/survivability_mode
  *	  Runtime
  *
+ * On some CSC firmware errors, PCODE sets FDO mode and the only recovery possible is through
+ * firmware flash using SPI driver. Userspace can check if FDO mode is set by checking the below
+ * sysfs entry.
+ *
+ * .. code-block:: shell
+ *
+ *	# cat /sys/bus/pci/devices/<device>/survivability_info/fdo_mode
+ *	  enabled
+ *
  * When such errors occur, userspace is notified with the drm device wedged uevent and runtime
  * survivability mode. User can then initiate a firmware flash using userspace tools like fwupd
  * to restore device to normal operation.
@@ -296,7 +304,8 @@ static int create_survivability_sysfs(struct pci_dev *pdev)
 	if (ret)
 		return ret;
 
-	if (check_boot_failure(xe)) {
+	/* Survivability info is not required if enabled via configfs */
+	if (!xe_configfs_get_survivability_mode(pdev)) {
 		ret = devm_device_add_group(dev, &survivability_info_group);
 		if (ret)
 			return ret;
diff --git a/drivers/gpu/drm/xe/xe_sysctrl_event.c b/drivers/gpu/drm/xe/xe_sysctrl_event.c
index b4d17329af6c..faf6ba89ce98 100644
--- a/drivers/gpu/drm/xe/xe_sysctrl_event.c
+++ b/drivers/gpu/drm/xe/xe_sysctrl_event.c
@@ -16,7 +16,7 @@ static void get_pending_event(struct xe_sysctrl *sc, struct xe_sysctrl_mailbox_c
 {
 	struct xe_sysctrl_event_response *response = command->data_out;
 	struct xe_device *xe = sc_to_xe(sc);
-	u32 count = XE_SYSCTRL_EVENT_FLOOD;
+	u32 count = XE_SYSCTRL_FLOOD;
 	size_t len;
 	int ret;
 
diff --git a/drivers/gpu/drm/xe/xe_sysctrl_event_types.h b/drivers/gpu/drm/xe/xe_sysctrl_event_types.h
index c16c66b9fa7f..d236e22fe9dd 100644
--- a/drivers/gpu/drm/xe/xe_sysctrl_event_types.h
+++ b/drivers/gpu/drm/xe/xe_sysctrl_event_types.h
@@ -11,7 +11,7 @@
 #define XE_SYSCTRL_EVENT_DATA_LEN		59
 
 /* Modify as needed */
-#define XE_SYSCTRL_EVENT_FLOOD			16
+#define XE_SYSCTRL_FLOOD			16
 
 /**
  * enum xe_sysctrl_event - Events reported by System Controller
diff --git a/drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h b/drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h
index 84d7c647e743..12ffd011ee8e 100644
--- a/drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h
+++ b/drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h
@@ -22,10 +22,18 @@ enum xe_sysctrl_group {
 /**
  * enum xe_sysctrl_gfsp_cmd - Commands supported by GFSP group
  *
+ * @XE_SYSCTRL_CMD_GET_SOC_ERROR: Retrieve basic error information
  * @XE_SYSCTRL_CMD_GET_PENDING_EVENT: Retrieve pending event
+ * @XE_SYSCTRL_CMD_PAGE_OFFLINE: Instruct firmware to offline/decline a page
+ * @XE_SYSCTRL_CMD_GET_OFFLINE_LIST: Retrieve list of all offlined pages from flash
+ * @XE_SYSCTRL_CMD_GET_OFFLINE_QUEUE: Retrieve list of offlined queued pages from firmware
  */
 enum xe_sysctrl_gfsp_cmd {
+	XE_SYSCTRL_CMD_GET_SOC_ERROR		= 0x01,
 	XE_SYSCTRL_CMD_GET_PENDING_EVENT	= 0x07,
+	XE_SYSCTRL_CMD_PAGE_OFFLINE		= 0x08,
+	XE_SYSCTRL_CMD_GET_OFFLINE_LIST		= 0x09,
+	XE_SYSCTRL_CMD_GET_OFFLINE_QUEUE	= 0x0A,
 };
 
 /**
@@ -48,6 +56,9 @@ struct xe_sysctrl_mailbox_command {
 	size_t data_out_len;
 };
 
+/* Modify as needed */
+#define XE_SYSCTRL_FLOOD			16
+
 #define XE_SYSCTRL_MB_FRAME_SIZE	16
 #define XE_SYSCTRL_MB_MAX_FRAMES	64
 #define XE_SYSCTRL_MB_MAX_MESSAGE_SIZE	\
-- 
2.34.1

