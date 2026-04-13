Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E0A5F34C4E
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 13:32:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC6A210E454;
	Mon, 13 Apr 2026 13:32:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="W8NdDH0d";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0474010E44F;
 Mon, 13 Apr 2026 13:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776087170; x=1807623170;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=eTVOs0lgxRPRj6pP4FTKl4e3VmjJ4U2LM3S6JG7hk3w=;
 b=W8NdDH0dBw0b0++APSP0rGjO8fZuTwrB0VHoQX4ouimk0SRLCJqqZmnH
 jUvmztJoN7jqyyZrB7pTD/3pVkQvPqLlHMV7qjsS4UpzB++CbqUybZ9TF
 qQNAVoKHuZ8JSQ2kxQn5TS8VYoBp2SKqEMMkEp/sIeGN+r6TIHT7WEWUq
 WwTJLmyuAm0E6+/d8Lshn3TQUIrNHjp4lCdOyTyDNmAPyIVXuTeLBGGAW
 ddjV+NtioxNaZldcIstBnwklraAC7ZwmUiu00voUvRU4K48DnXmVkoNel
 7xKAHdh9ph9iKtgvyogvoUqkAGi/QwUxXPRS43r+JUqU4QLljAAoCb+B3 w==;
X-CSE-ConnectionGUID: 5dpJEY0ATR2Xf6utfhGw/Q==
X-CSE-MsgGUID: srdj7wGjTkq0qMWMM8SLsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="94594631"
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; d="scan'208";a="94594631"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Apr 2026 06:32:50 -0700
X-CSE-ConnectionGUID: hcXq5Qb+QgaZSMxFkOZk/g==
X-CSE-MsgGUID: chbdoTwnSvuN5sAWjgJUBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; d="scan'208";a="229659615"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by orviesa009.jf.intel.com with ESMTP; 13 Apr 2026 06:32:45 -0700
From: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rodrigo.vivi@intel.com
Cc: andrealmeid@igalia.com, christian.koenig@amd.com, airlied@gmail.com,
 simona.vetter@ffwll.ch, mripard@kernel.org, anshuman.gupta@intel.com,
 badal.nilawar@intel.com, riana.tauro@intel.com, karthik.poosa@intel.com,
 sk.anirban@intel.com, raag.jadav@intel.com,
 Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Subject: [PATCH v4 1/4] Introduce Xe Uncorrectable Error Handling
Date: Mon, 13 Apr 2026 19:00:15 +0530
Message-ID: <20260413133013.560239-7-mallesh.koujalagi@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260413133013.560239-6-mallesh.koujalagi@intel.com>
References: <20260413133013.560239-6-mallesh.koujalagi@intel.com>
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
 drivers/gpu/drm/xe/Makefile                   |   2 +
 drivers/gpu/drm/xe/xe_device.c                |  10 +
 drivers/gpu/drm/xe/xe_device.h                |  15 +
 drivers/gpu/drm/xe/xe_device_types.h          |   6 +
 drivers/gpu/drm/xe/xe_gt.c                    |  14 +-
 drivers/gpu/drm/xe/xe_guc_submit.c            |   9 +-
 drivers/gpu/drm/xe/xe_pci.c                   |   3 +
 drivers/gpu/drm/xe/xe_pci_error.c             | 118 +++++++
 drivers/gpu/drm/xe/xe_ras.c                   | 318 ++++++++++++++++++
 drivers/gpu/drm/xe/xe_ras.h                   |  16 +
 drivers/gpu/drm/xe/xe_ras_types.h             | 203 +++++++++++
 drivers/gpu/drm/xe/xe_survivability_mode.c    |  12 +-
 drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h |  13 +
 13 files changed, 731 insertions(+), 8 deletions(-)
 create mode 100644 drivers/gpu/drm/xe/xe_pci_error.c
 create mode 100644 drivers/gpu/drm/xe/xe_ras.c
 create mode 100644 drivers/gpu/drm/xe/xe_ras.h
 create mode 100644 drivers/gpu/drm/xe/xe_ras_types.h

diff --git a/drivers/gpu/drm/xe/Makefile b/drivers/gpu/drm/xe/Makefile
index 110fef511fe2..2c0017e47644 100644
--- a/drivers/gpu/drm/xe/Makefile
+++ b/drivers/gpu/drm/xe/Makefile
@@ -100,6 +100,7 @@ xe-y += xe_bb.o \
 	xe_page_reclaim.o \
 	xe_pat.o \
 	xe_pci.o \
+	xe_pci_error.o \
 	xe_pci_rebar.o \
 	xe_pcode.o \
 	xe_pm.o \
@@ -111,6 +112,7 @@ xe-y += xe_bb.o \
 	xe_pxp_debugfs.o \
 	xe_pxp_submit.o \
 	xe_query.o \
+	xe_ras.o \
 	xe_range_fence.o \
 	xe_reg_sr.o \
 	xe_reg_whitelist.o \
diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index cbce1d0ffe48..32892a1a7377 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -60,6 +60,7 @@
 #include "xe_psmi.h"
 #include "xe_pxp.h"
 #include "xe_query.h"
+#include "xe_ras.h"
 #include "xe_shrinker.h"
 #include "xe_soc_remapper.h"
 #include "xe_survivability_mode.h"
@@ -440,6 +441,7 @@ struct xe_device *xe_device_create(struct pci_dev *pdev,
 				   const struct pci_device_id *ent)
 {
 	struct xe_device *xe;
+	void *devres_id;
 	int err;
 
 	xe_display_driver_set_hooks(&driver);
@@ -448,10 +450,16 @@ struct xe_device *xe_device_create(struct pci_dev *pdev,
 	if (err)
 		return ERR_PTR(err);
 
+	devres_id = devres_open_group(&pdev->dev, NULL, GFP_KERNEL);
+	if (!devres_id)
+		return ERR_PTR(-ENOMEM);
+
 	xe = devm_drm_dev_alloc(&pdev->dev, &driver, struct xe_device, drm);
 	if (IS_ERR(xe))
 		return xe;
 
+	xe->devres_group_id = devres_id;
+
 	err = ttm_device_init(&xe->ttm, &xe_ttm_funcs, xe->drm.dev,
 			      xe->drm.anon_inode->i_mapping,
 			      xe->drm.vma_offset_manager, 0);
@@ -1016,6 +1024,8 @@ int xe_device_probe(struct xe_device *xe)
 
 	xe_vsec_init(xe);
 
+	xe_ras_init(xe);
+
 	err = xe_sriov_init_late(xe);
 	if (err)
 		goto err_unregister_display;
diff --git a/drivers/gpu/drm/xe/xe_device.h b/drivers/gpu/drm/xe/xe_device.h
index e4b9de8d8e95..60db2492cb92 100644
--- a/drivers/gpu/drm/xe/xe_device.h
+++ b/drivers/gpu/drm/xe/xe_device.h
@@ -43,6 +43,21 @@ static inline struct xe_device *ttm_to_xe_device(struct ttm_device *ttm)
 	return container_of(ttm, struct xe_device, ttm);
 }
 
+static inline bool xe_device_is_in_recovery(struct xe_device *xe)
+{
+	return atomic_read(&xe->in_recovery);
+}
+
+static inline void xe_device_set_in_recovery(struct xe_device *xe)
+{
+	atomic_set(&xe->in_recovery, 1);
+}
+
+static inline void xe_device_clear_in_recovery(struct xe_device *xe)
+{
+	 atomic_set(&xe->in_recovery, 0);
+}
+
 struct xe_device *xe_device_create(struct pci_dev *pdev,
 				   const struct pci_device_id *ent);
 int xe_device_probe_early(struct xe_device *xe);
diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index 150c76b2acaf..c89e2d31583c 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -494,6 +494,12 @@ struct xe_device {
 		bool inconsistent_reset;
 	} wedged;
 
+	/** @in_recovery: Indicates if device is in recovery */
+	atomic_t in_recovery;
+
+	/** @devres_group_id: id for devres group */
+	void *devres_group_id;
+
 	/** @bo_device: Struct to control async free of BOs */
 	struct xe_bo_dev {
 		/** @bo_device.async_free: Free worker */
diff --git a/drivers/gpu/drm/xe/xe_gt.c b/drivers/gpu/drm/xe/xe_gt.c
index 8a31c963c372..5ea5524d83af 100644
--- a/drivers/gpu/drm/xe/xe_gt.c
+++ b/drivers/gpu/drm/xe/xe_gt.c
@@ -917,6 +917,9 @@ static void gt_reset_worker(struct work_struct *w)
 	if (xe_device_wedged(gt_to_xe(gt)))
 		goto err_pm_put;
 
+	if (xe_device_is_in_recovery(gt_to_xe(gt)))
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
+	if (xe_device_is_in_recovery(xe))
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
index 10556156eaad..1f32fb14a5c1 100644
--- a/drivers/gpu/drm/xe/xe_guc_submit.c
+++ b/drivers/gpu/drm/xe/xe_guc_submit.c
@@ -1522,7 +1522,7 @@ guc_exec_queue_timedout_job(struct drm_sched_job *drm_job)
 	 * If devcoredump not captured and GuC capture for the job is not ready
 	 * do manual capture first and decide later if we need to use it
 	 */
-	if (!exec_queue_killed(q) && !xe->devcoredump.captured &&
+	if (!xe_device_is_in_recovery(xe) && !exec_queue_killed(q) && !xe->devcoredump.captured &&
 	    !xe_guc_capture_get_matching_and_lock(q)) {
 		/* take force wake before engine register manual capture */
 		CLASS(xe_force_wake, fw_ref)(gt_to_fw(q->gt), XE_FORCEWAKE_ALL);
@@ -1544,8 +1544,8 @@ guc_exec_queue_timedout_job(struct drm_sched_job *drm_job)
 	set_exec_queue_banned(q);
 
 	/* Kick job / queue off hardware */
-	if (!wedged && (exec_queue_enabled(primary) ||
-			exec_queue_pending_disable(primary))) {
+	if (!xe_device_is_in_recovery(xe) && !wedged &&
+	    (exec_queue_enabled(primary) || exec_queue_pending_disable(primary))) {
 		int ret;
 
 		if (exec_queue_reset(primary))
@@ -1613,7 +1613,8 @@ guc_exec_queue_timedout_job(struct drm_sched_job *drm_job)
 
 	trace_xe_sched_job_timedout(job);
 
-	if (!exec_queue_killed(q))
+	/* Do not access device if in recovery */
+	if (!xe_device_is_in_recovery(xe) && !exec_queue_killed(q))
 		xe_devcoredump(q, job,
 			       "Timedout job - seqno=%u, lrc_seqno=%u, guc_id=%d, flags=0x%lx",
 			       xe_sched_job_seqno(job), xe_sched_job_lrc_seqno(job),
diff --git a/drivers/gpu/drm/xe/xe_pci.c b/drivers/gpu/drm/xe/xe_pci.c
index 6e560ef84a97..7ac433742f82 100644
--- a/drivers/gpu/drm/xe/xe_pci.c
+++ b/drivers/gpu/drm/xe/xe_pci.c
@@ -1324,6 +1324,8 @@ static const struct dev_pm_ops xe_pm_ops = {
 };
 #endif
 
+extern const struct pci_error_handlers xe_pci_error_handlers;
+
 static struct pci_driver xe_pci_driver = {
 	.name = DRIVER_NAME,
 	.id_table = pciidlist,
@@ -1331,6 +1333,7 @@ static struct pci_driver xe_pci_driver = {
 	.remove = xe_pci_remove,
 	.shutdown = xe_pci_shutdown,
 	.sriov_configure = xe_pci_sriov_configure,
+	.err_handler = &xe_pci_error_handlers,
 #ifdef CONFIG_PM_SLEEP
 	.driver.pm = &xe_pm_ops,
 #endif
diff --git a/drivers/gpu/drm/xe/xe_pci_error.c b/drivers/gpu/drm/xe/xe_pci_error.c
new file mode 100644
index 000000000000..71b6152c1593
--- /dev/null
+++ b/drivers/gpu/drm/xe/xe_pci_error.c
@@ -0,0 +1,118 @@
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
+static void xe_pci_error_handling(struct pci_dev *pdev)
+{
+	struct xe_device *xe = pdev_to_xe_device(pdev);
+	struct xe_gt *gt;
+	u8 id;
+
+	/* Return if device is wedged or in survivability mode */
+	if (xe_survivability_mode_is_boot_enabled(xe) || xe_device_wedged(xe))
+		return;
+
+	/* Wedge the device to prevent userspace access but don't send the event yet */
+	atomic_set(&xe->wedged.flag, 1);
+
+	for_each_gt(gt, xe, id)
+		xe_gt_declare_wedged(gt);
+
+	pci_disable_device(pdev);
+}
+
+/* Mapping of RAS recovery action to PCI error result */
+static const pci_ers_result_t ras_recovery_action_to_pci_result[] = {
+	[XE_RAS_RECOVERY_ACTION_RECOVERED] = PCI_ERS_RESULT_RECOVERED,
+	[XE_RAS_RECOVERY_ACTION_RESET] = PCI_ERS_RESULT_NEED_RESET,
+	[XE_RAS_RECOVERY_ACTION_DISCONNECT] = PCI_ERS_RESULT_DISCONNECT,
+};
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
+	xe_device_set_in_recovery(xe);
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
+	action = xe_ras_process_errors(xe);
+
+	return ras_recovery_action_to_pci_result[action];
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
+	 * Secondary Bus Reset wipes out all device memory
+	 * requiring XE KMD to perform a device removal and reprobe.
+	 */
+	pdev->driver->remove(pdev);
+	devres_release_group(&pdev->dev, xe->devres_group_id);
+
+	if (!pdev->driver->probe(pdev, ent))
+		return PCI_ERS_RESULT_RECOVERED;
+
+	return PCI_ERS_RESULT_DISCONNECT;
+}
+
+static void xe_pci_error_resume(struct pci_dev *pdev)
+{
+	struct xe_device *xe = pdev_to_xe_device(pdev);
+
+	dev_info(&pdev->dev, "Xe Pci error recovery: Recovered\n");
+
+	xe_device_clear_in_recovery(xe);
+}
+
+const struct pci_error_handlers xe_pci_error_handlers = {
+	.error_detected	= xe_pci_error_detected,
+	.mmio_enabled	= xe_pci_error_mmio_enabled,
+	.slot_reset	= xe_pci_error_slot_reset,
+	.resume		= xe_pci_error_resume,
+};
diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
new file mode 100644
index 000000000000..437811845c01
--- /dev/null
+++ b/drivers/gpu/drm/xe/xe_ras.c
@@ -0,0 +1,318 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright © 2026 Intel Corporation
+ */
+
+#include "xe_assert.h"
+#include "xe_device_types.h"
+#include "xe_printk.h"
+#include "xe_ras.h"
+#include "xe_ras_types.h"
+#include "xe_survivability_mode.h"
+#include "xe_sysctrl_mailbox.h"
+#include "xe_sysctrl_mailbox_types.h"
+
+#define COMPUTE_ERROR_SEVERITY_MASK		GENMASK(26, 25)
+#define GLOBAL_UNCORR_ERROR			2
+/* Modify as needed */
+#define XE_SYSCTRL_ERROR_FLOOD			16
+
+/* Severity classification of detected errors */
+enum xe_ras_severity {
+	XE_RAS_SEVERITY_NOT_SUPPORTED = 0,
+	XE_RAS_SEVERITY_CORRECTABLE,
+	XE_RAS_SEVERITY_UNCORRECTABLE,
+	XE_RAS_SEVERITY_INFORMATIONAL,
+	XE_RAS_SEVERITY_MAX
+};
+
+/* major IP blocks where errors can originate */
+enum xe_ras_component {
+	XE_RAS_COMPONENT_NOT_SUPPORTED = 0,
+	XE_RAS_COMPONENT_DEVICE_MEMORY,
+	XE_RAS_COMPONENT_CORE_COMPUTE,
+	XE_RAS_COMPONENT_RESERVED,
+	XE_RAS_COMPONENT_PCIE,
+	XE_RAS_COMPONENT_FABRIC,
+	XE_RAS_COMPONENT_SOC_INTERNAL,
+	XE_RAS_COMPONENT_MAX
+};
+
+static const char * const xe_ras_severities[] = {
+	[XE_RAS_SEVERITY_NOT_SUPPORTED]		= "Not Supported",
+	[XE_RAS_SEVERITY_CORRECTABLE]		= "Correctable",
+	[XE_RAS_SEVERITY_UNCORRECTABLE]		= "Uncorrectable",
+	[XE_RAS_SEVERITY_INFORMATIONAL]		= "Informational",
+};
+
+static_assert(ARRAY_SIZE(xe_ras_severities) == XE_RAS_SEVERITY_MAX);
+
+static const char * const xe_ras_components[] = {
+	[XE_RAS_COMPONENT_NOT_SUPPORTED]	= "Not Supported",
+	[XE_RAS_COMPONENT_DEVICE_MEMORY]	= "Device Memory",
+	[XE_RAS_COMPONENT_CORE_COMPUTE]		= "Core Compute",
+	[XE_RAS_COMPONENT_RESERVED]		= "Reserved",
+	[XE_RAS_COMPONENT_PCIE]			= "PCIe",
+	[XE_RAS_COMPONENT_FABRIC]		= "Fabric",
+	[XE_RAS_COMPONENT_SOC_INTERNAL]		= "SoC Internal",
+};
+
+static_assert(ARRAY_SIZE(xe_ras_components) == XE_RAS_COMPONENT_MAX);
+
+static inline const char *severity_to_str(struct xe_device *xe, u32 severity)
+{
+	xe_assert(xe, severity < XE_RAS_SEVERITY_MAX);
+
+	return severity < XE_RAS_SEVERITY_MAX ? xe_ras_severities[severity] : "Unknown";
+}
+
+static inline const char *comp_to_str(struct xe_device *xe, u32 comp)
+{
+	xe_assert(xe, comp < XE_RAS_COMPONENT_MAX);
+
+	return comp < XE_RAS_COMPONENT_MAX ? xe_ras_components[comp] : "Unknown";
+}
+
+static enum xe_ras_recovery_action handle_compute_errors(struct xe_device *xe,
+							 struct xe_ras_error_array *arr)
+{
+	struct xe_ras_compute_error *error_info = (struct xe_ras_compute_error *)arr->error_details;
+	struct xe_ras_error_common common = arr->error_class.common;
+	u8 uncorr_type;
+
+	uncorr_type = FIELD_GET(COMPUTE_ERROR_SEVERITY_MASK, error_info->error_log_header);
+
+	xe_err(xe, "[RAS]: %s %s Error detected", severity_to_str(xe, common.severity),
+	       comp_to_str(xe, common.component));
+
+	/* Request a RESET if error is global */
+	if (uncorr_type == GLOBAL_UNCORR_ERROR)
+		return XE_RAS_RECOVERY_ACTION_RESET;
+
+	/* Local errors are recovered using a engine reset by GuC */
+	return XE_RAS_RECOVERY_ACTION_RECOVERED;
+}
+
+static enum xe_ras_recovery_action handle_soc_internal_errors(struct xe_device *xe,
+							      struct xe_ras_error_array *arr)
+{
+	struct xe_ras_soc_error *error_info =
+		(struct xe_ras_soc_error *)arr->error_details;
+	struct xe_ras_soc_error_source source = error_info->error_source;
+	struct xe_ras_error_common common = arr->error_class.common;
+
+	xe_err(xe, "[RAS]: %s %s Error detected", severity_to_str(xe, common.severity),
+	       comp_to_str(xe, common.component));
+
+	if (source.csc) {
+		struct xe_ras_csc_error *csc_error =
+			(struct xe_ras_csc_error *)error_info->additional_details;
+
+		/*
+		 * CSC uncorrectable errors are classified as hardware errors and firmware errors.
+		 * CSC firmware errors are critical errors that can be recovered only by firmware
+		 * update via SPI driver. PCODE enables FDO mode and sets the bit in the capability
+		 * register. On receiving this error, the driver enables runtime survivability mode
+		 * which notifies userspace that a firmware update is required.
+		 */
+		if (csc_error->hec_uncorr_fw_err_dw0) {
+			xe_err(xe, "[RAS]: CSC %s error detected: 0x%x\n",
+			       severity_to_str(xe, common.severity),
+			       csc_error->hec_uncorr_fw_err_dw0);
+			xe_survivability_mode_runtime_enable(xe);
+			return XE_RAS_RECOVERY_ACTION_DISCONNECT;
+		}
+	}
+
+	if (source.soc) {
+		struct xe_ras_ieh_error *ieh_error =
+			(struct xe_ras_ieh_error *)error_info->additional_details;
+
+		if (ieh_error->global_error_status & XE_RAS_IEH_PUNIT_ERROR) {
+			xe_err(xe, "[RAS]: PUNIT %s error detected: 0x%x\n",
+			       severity_to_str(xe, common.severity),
+			       ieh_error->global_error_status);
+			/** TODO: Add PUNIT error handling */
+			return XE_RAS_RECOVERY_ACTION_DISCONNECT;
+		}
+	}
+
+	/* For other SOC internal errors, request a reset as recovery mechanism */
+	return XE_RAS_RECOVERY_ACTION_RESET;
+}
+
+static void prepare_sysctrl_command(struct xe_sysctrl_mailbox_command *command,
+				    u32 cmd_mask, void *request, size_t request_len,
+				    void *response, size_t response_len)
+{
+	struct xe_sysctrl_app_msg_hdr hdr = {0};
+	u32 req_hdr;
+
+	req_hdr = FIELD_PREP(APP_HDR_GROUP_ID_MASK, XE_SYSCTRL_GROUP_GFSP) |
+		  FIELD_PREP(APP_HDR_COMMAND_MASK, cmd_mask);
+
+	hdr.data = req_hdr;
+	command->header = hdr;
+	command->data_in = request;
+	command->data_in_len = request_len;
+	command->data_out = response;
+	command->data_out_len = response_len;
+}
+
+/**
+ * xe_ras_process_errors - Process and contain hardware errors
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
+	struct xe_ras_get_error_response response;
+	enum xe_ras_recovery_action final_action;
+	u32 count = 0;
+	size_t rlen;
+	int ret;
+
+	/* Default action */
+	final_action = XE_RAS_RECOVERY_ACTION_RECOVERED;
+
+	if (!xe->info.has_sysctrl)
+		return XE_RAS_RECOVERY_ACTION_RESET;
+
+	prepare_sysctrl_command(&command, XE_SYSCTRL_CMD_GET_SOC_ERROR, NULL, 0,
+				&response, sizeof(response));
+
+	do {
+		memset(&response, 0, sizeof(response));
+		rlen = 0;
+
+		ret = xe_sysctrl_send_command(&xe->sc, &command, &rlen);
+		if (ret) {
+			xe_err(xe, "[RAS]: Sysctrl error ret %d\n", ret);
+			goto err;
+		}
+
+		if (rlen != sizeof(response)) {
+			xe_err(xe, "[RAS]: Sysctrl response size mismatch. Expected %zu, got %zu\n",
+			       sizeof(response), rlen);
+			goto err;
+		}
+
+		for (int i = 0; i < response.num_errors &&  i < XE_RAS_NUM_ERROR_ARR; i++) {
+			struct xe_ras_error_array arr = response.error_arr[i];
+			enum xe_ras_recovery_action action;
+			struct xe_ras_error_class error_class;
+			u8 component;
+
+			error_class = arr.error_class;
+			component = error_class.common.component;
+
+			switch (component) {
+			case XE_RAS_COMPONENT_CORE_COMPUTE:
+				action = handle_compute_errors(xe, &arr);
+				break;
+			case XE_RAS_COMPONENT_SOC_INTERNAL:
+				action = handle_soc_internal_errors(xe, &arr);
+				break;
+			default:
+				xe_err(xe, "[RAS]: Unknown error component %u\n", component);
+				action = XE_RAS_RECOVERY_ACTION_RESET;
+				break;
+			}
+
+			/*
+			 * Retain the highest severity action. Process and log all errors
+			 * and then take appropriate recovery action.
+			 */
+			if (action > final_action)
+				final_action = action;
+		}
+
+		/* Break if system controller floods responses */
+		if (++count > XE_SYSCTRL_ERROR_FLOOD) {
+			xe_err(xe, "[RAS]: Sysctrl response flooding\n");
+			break;
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
+	 /* Gfx Device Hierarchy: USP-->VSP-->SGunit */
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
+	if (!aer_cap)
+		return;
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
+	if (!xe->info.has_sysctrl)
+		return;
+
+#ifdef CONFIG_PCIEAER
+	aer_unmask_and_downgrade_internal_error(xe);
+#endif
+}
diff --git a/drivers/gpu/drm/xe/xe_ras.h b/drivers/gpu/drm/xe/xe_ras.h
new file mode 100644
index 000000000000..e191ab80080c
--- /dev/null
+++ b/drivers/gpu/drm/xe/xe_ras.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright © 2026 Intel Corporation
+ */
+
+#ifndef _XE_RAS_H_
+#define _XE_RAS_H_
+
+#include "xe_ras_types.h"
+
+struct xe_device;
+
+void xe_ras_init(struct xe_device *xe);
+enum xe_ras_recovery_action  xe_ras_process_errors(struct xe_device *xe);
+
+#endif
diff --git a/drivers/gpu/drm/xe/xe_ras_types.h b/drivers/gpu/drm/xe/xe_ras_types.h
new file mode 100644
index 000000000000..65158bf716a7
--- /dev/null
+++ b/drivers/gpu/drm/xe/xe_ras_types.h
@@ -0,0 +1,203 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright © 2026 Intel Corporation
+ */
+
+#ifndef _XE_RAS_TYPES_H_
+#define _XE_RAS_TYPES_H_
+
+#include <linux/types.h>
+
+#define XE_RAS_NUM_ERROR_ARR		3
+#define XE_RAS_MAX_ERROR_DETAILS	16
+#define XE_RAS_IEH_PUNIT_ERROR		BIT(1)
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
+ * struct xe_ras_error_common - Common RAS error class
+ *
+ * This structure contains error severity and component information
+ * across all products
+ */
+struct xe_ras_error_common {
+	/** @severity: Error Severity */
+	u8 severity;
+	/** @component: IP where the error originated */
+	u8 component;
+} __packed;
+
+/**
+ * struct xe_ras_error_unit - Error unit information
+ */
+struct xe_ras_error_unit {
+	/** @tile: Tile identifier */
+	u8 tile;
+	/** @instance: Instance identifier within a component */
+	u32 instance;
+} __packed;
+
+/**
+ * struct xe_ras_error_cause - Error cause information
+ */
+struct xe_ras_error_cause {
+	/** @cause: Cause */
+	u32 cause;
+	/** @reserved: For future use */
+	u8 reserved;
+} __packed;
+
+/**
+ * struct xe_ras_error_product - Error fields that are specific to the product
+ */
+struct xe_ras_error_product {
+	/** @unit: Unit within IP block */
+	struct xe_ras_error_unit unit;
+	/** @error_cause: Cause/checker */
+	struct xe_ras_error_cause error_cause;
+} __packed;
+
+/**
+ * struct xe_ras_error_class - Complete RAS Error Class
+ *
+ * This structure provides the complete error classification by combining
+ * the common error class with the product-specific error class.
+ */
+struct xe_ras_error_class {
+	/** @common: Common error severity and component */
+	struct xe_ras_error_common common;
+	/** @product: Product-specific unit and cause */
+	struct xe_ras_error_product product;
+} __packed;
+
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
+	u32 error_details[XE_RAS_MAX_ERROR_DETAILS];
+} __packed;
+
+/**
+ * struct xe_ras_get_error_response - Response for XE_SYSCTRL_GET_SOC_ERROR
+ */
+struct xe_ras_get_error_response {
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
+	/** @internal_error_log: Internal Error log */
+	u32 internal_error_log;
+	/** @fabric_log: Fabric Error log */
+	u32 fabric_log;
+	/** @internal_error_addr_log0: Internal Error addr log */
+	u32 internal_error_addr_log0;
+	/** @internal_error_addr_log1: Internal Error addr log */
+	u32 internal_error_addr_log1;
+	/** @packet_log0: Packet log */
+	u32 packet_log0;
+	/** @packet_log1: Packet log */
+	u32 packet_log1;
+	/** @packet_log2: Packet log */
+	u32 packet_log2;
+	/** @packet_log3: Packet log */
+	u32 packet_log3;
+	/** @packet_log4: Packet log */
+	u32 packet_log4;
+	/** @misc_log0: Misc log */
+	u32 misc_log0;
+	/** @misc_log1: Misc log */
+	u32 misc_log1;
+	/** @spare_log0: Spare log */
+	u32 spare_log0;
+	/** @spare_log1: Spare log */
+	u32 spare_log1;
+	/** @spare_log2: Spare log */
+	u32 spare_log2;
+	/** @spare_log3: Spare log */
+	u32 spare_log3;
+} __packed;
+
+/**
+ * struct xe_ras_soc_error_source - Source of SOC error
+ */
+struct xe_ras_soc_error_source {
+	/** @csc: CSC error */
+	u32 csc:1;
+	/** @soc: SOC error */
+	u32 soc:1;
+	/** @reserved: Reserved for future use */
+	u32 reserved:30;
+} __packed;
+
+/**
+ * struct xe_ras_soc_error - SOC error details
+ */
+struct xe_ras_soc_error {
+	/** @error_source: Error Source */
+	struct xe_ras_soc_error_source error_source;
+	/** @additional_details: Additional details */
+	u32 additional_details[15];
+} __packed;
+
+/**
+ * struct xe_ras_csc_error - CSC error details
+ */
+struct xe_ras_csc_error {
+	/** @hec_uncorr_err_status: CSC error */
+	u32 hec_uncorr_err_status;
+	/** @hec_uncorr_fw_err_dw0: CSC f/w error */
+	u32 hec_uncorr_fw_err_dw0;
+} __packed;
+
+/**
+ * struct xe_ras_ieh_error - SoC IEH (Integrated Error Handler) details
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
+#endif
diff --git a/drivers/gpu/drm/xe/xe_survivability_mode.c b/drivers/gpu/drm/xe/xe_survivability_mode.c
index db64cac39c94..ad51a58831b0 100644
--- a/drivers/gpu/drm/xe/xe_survivability_mode.c
+++ b/drivers/gpu/drm/xe/xe_survivability_mode.c
@@ -98,6 +98,15 @@
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
+ *       enabled
+ *
  * When such errors occur, userspace is notified with the drm device wedged uevent and runtime
  * survivability mode. User can then initiate a firmware flash using userspace tools like fwupd
  * to restore device to normal operation.
@@ -296,7 +305,8 @@ static int create_survivability_sysfs(struct pci_dev *pdev)
 	if (ret)
 		return ret;
 
-	if (check_boot_failure(xe)) {
+	/* Survivability info is not required if enabled via configfs */
+	if (!xe_configfs_get_survivability_mode(pdev)) {
 		ret = devm_device_add_group(dev, &survivability_info_group);
 		if (ret)
 			return ret;
diff --git a/drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h b/drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h
index 89456aec6097..a4260920dfb4 100644
--- a/drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h
+++ b/drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h
@@ -10,6 +10,19 @@
 
 #include "abi/xe_sysctrl_abi.h"
 
+/**
+ * enum xe_sysctrl_mailbox_command_id - RAS Command ID's for GFSP group
+ *
+ * @XE_SYSCTRL_CMD_GET_SOC_ERROR: Get basic error information
+ */
+enum xe_sysctrl_mailbox_command_id {
+	XE_SYSCTRL_CMD_GET_SOC_ERROR = 1
+};
+
+enum xe_sysctrl_group {
+	XE_SYSCTRL_GROUP_GFSP = 1
+};
+
 /**
  * struct xe_sysctrl_mailbox_command - System Controller mailbox command
  */
-- 
2.34.1

