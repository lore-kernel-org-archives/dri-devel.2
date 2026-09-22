Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 356B8C98308
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 10:18:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA14B10EC4B;
	Tue, 22 Sep 2026 10:18:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="BIMrrQ3Q";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D448410EC37;
 Tue, 22 Sep 2026 10:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790072279; x=1821608279;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DobSsqx7+6Wup8PHjvA8v5KBUhAduRYBCQgrAB5VdKo=;
 b=BIMrrQ3QCtipADAQMZjR4gO6W47eyKVZIFuG6vVrxJVYZbB+mWloVIyW
 H1DUy9hDCPdnX8Iko/idCDkUX0lZ8OliXkFRFoxod74XWsu4odeaEFlc5
 f6omEX66bhDkcV6OG1/cNsqqafWPsPkjsTJM6HqL/wdy5McandeYEMO6E
 +tRtKjZ73VthDxpHX2g4mLD+GiLlnNsNFoCLEZR8fPnKnyRo2oqpFM+B4
 r/S55DEgFGroyGJsprpa7TWUTI6AlJktcHrb4fc7NU8eTbS5nb5SEbr97
 eDPZ/WXLNbMSmOPOFxLcPdAeIB2mcXB6Ti/lVFptUZMfj7osD0+F5pPTN g==;
X-CSE-ConnectionGUID: zT5zBUF0TuiIFKa9gLJm9g==
X-CSE-MsgGUID: eC3r6vCESoSgLFM2L9wUjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="101322841"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="101322841"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 03:17:59 -0700
X-CSE-ConnectionGUID: dFD5/AgAS8imuO85gVgyzg==
X-CSE-MsgGUID: P5+WcAI7Rx6BPvTk+ntlMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="299307910"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 03:17:57 -0700
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: matthew.brost@intel.com, himal.prasad.ghimiray@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com
Subject: [PATCH v2 11/15] drm/xe: Isolate a wedged device before notifying
 userspace
Date: Tue, 22 Sep 2026 15:46:56 +0530
Message-ID: <20260922101721.1583542-12-arvind.yadav@intel.com>
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

A permanently wedged device must stop interrupt and DMA activity before
userspace is notified that recovery is required.

Run the sleepable isolation steps from the wedge worker. Shut down and
unregister the display, suspend interrupts and clear PCI bus mastering,
then invalidate VRAM mappings. Mapping teardown does not access hardware,
so it runs after DMA has stopped

Track display and isolation state so later teardown does not repeat these
steps. Display shutdown already disables display power, so skip the
runtime PM disable when unregister follows shutdown.

System suspend may see the wedge flag before the worker is queued. Use a
completion to close this window and flush the worker before skipping
normal device suspend. The IRQ serialization keeps a racing resume from
enabling interrupts after isolation.

Resume always balances pci_disable_device() with pci_enable_device().
If the device is wedged, clear bus mastering and skip xe_pm_resume().

v2:
 - Run the common PCI suspend path for wedged devices so
   the D3Cold toggles remain paired. (Sashiko)
 - Move pci_enable_device() before the resume wedge check to
   balance pci_disable_device() even if the device wedges
   during suspend. (Sashiko)
 - Reuse the common device I/O SRCU gate
 - Remove the separate VRAM fault SRCU domain
 - Protect driver suspend and resume with the common SRCU gate
 - Wait for isolation when the device wedges during PM

Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
---
 drivers/gpu/drm/xe/display/xe_display.c | 17 +++++++--
 drivers/gpu/drm/xe/xe_device.c          | 45 +++++++++++++++++++---
 drivers/gpu/drm/xe/xe_device_types.h    |  9 +++++
 drivers/gpu/drm/xe/xe_pci.c             | 51 +++++++++++++++++++++----
 4 files changed, 106 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/xe/display/xe_display.c b/drivers/gpu/drm/xe/display/xe_display.c
index 7b25c0814674..74a6afd78263 100644
--- a/drivers/gpu/drm/xe/display/xe_display.c
+++ b/drivers/gpu/drm/xe/display/xe_display.c
@@ -150,21 +150,27 @@ void xe_display_register(struct xe_device *xe)
 {
 	struct intel_display *display = xe->display;
 
-	if (!xe->info.probe_display)
+	if (!xe->info.probe_display || xe->display_registered)
 		return;
 
 	intel_display_driver_register(display);
 	intel_display_driver_runtime_pm_enable(display);
+
+	xe->display_registered = true;
 }
 
 void xe_display_unregister(struct xe_device *xe)
 {
 	struct intel_display *display = xe->display;
 
-	if (!xe->info.probe_display)
+	if (!xe->info.probe_display || !xe->display_registered)
 		return;
 
-	intel_display_driver_runtime_pm_disable(display);
+	xe->display_registered = false;
+
+	if (!xe->display_shutdown)
+		intel_display_driver_runtime_pm_disable(display);
+
 	intel_display_driver_unregister(display);
 }
 
@@ -172,7 +178,8 @@ void xe_display_shutdown(struct xe_device *xe)
 {
 	struct intel_display *display = xe->display;
 
-	if (!xe->info.probe_display)
+	if (!xe->info.probe_display || !xe->display_registered ||
+	    xe->display_shutdown)
 		return;
 
 	intel_display_driver_shutdown(display);
@@ -180,6 +187,8 @@ void xe_display_shutdown(struct xe_device *xe)
 	intel_opregion_suspend(display, PCI_D3cold);
 
 	intel_dmc_suspend(display);
+
+	xe->display_shutdown = true;
 }
 
 void xe_display_shutdown_late(struct xe_device *xe)
diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index 3549cf89a353..549504d2a9c4 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -469,6 +469,7 @@ int xe_device_init_early(struct xe_device *xe)
 	int err;
 
 	INIT_WORK(&xe->wedged.work, xe_device_wedged_work);
+	init_completion(&xe->wedged.prepared);
 	xe->wedged.reported_method = ~0UL;
 
 	err = ttm_device_init(&xe->ttm, &xe_ttm_funcs, xe->drm.dev,
@@ -889,6 +890,41 @@ static int xe_debug_page_size_alloc_ctrl_init(struct xe_device *xe)
 }
 #endif
 
+/*
+ * Isolate a permanently wedged device.
+ *
+ * May sleep and must be called from process context.
+ */
+static void xe_device_wedged_isolate(struct xe_device *xe)
+{
+	/*
+	 * Wait until xe_device_declare_wedged() has finished scanning GT
+	 * submission state before isolating the device.
+	 */
+	wait_for_completion(&xe->wedged.prepared);
+
+	if (xe->wedged.isolated)
+		return;
+
+	/*
+	 * GT wedging has signalled pending fences. Drain existing hardware
+	 * users before isolation starts.
+	 */
+	xe_device_io_drain(xe);
+
+	/* Shut down display hardware before stopping device access. */
+	xe_display_shutdown(xe);
+	xe_display_unregister(xe);
+
+	/* Stop interrupt and DMA activity before changing mappings. */
+	xe_irq_suspend(xe);
+	pci_clear_master(to_pci_dev(xe->drm.dev));
+
+	xe_bo_wedged_invalidate_mmaps(xe);
+
+	xe->wedged.isolated = true;
+}
+
 static void xe_device_wedged_work(struct work_struct *work)
 {
 	struct xe_device *xe =
@@ -896,9 +932,7 @@ static void xe_device_wedged_work(struct work_struct *work)
 	unsigned long method;
 	int err;
 
-	/* Drain active faults before invalidating VRAM mappings. */
-	xe_device_io_drain(xe);
-	xe_bo_wedged_invalidate_mmaps(xe);
+	xe_device_wedged_isolate(xe);
 
 	/* Report at most one recovery method per worker invocation. */
 	method = READ_ONCE(xe->wedged.method);
@@ -1164,7 +1198,6 @@ int xe_device_probe(struct xe_device *xe)
 void xe_device_remove(struct xe_device *xe)
 {
 	xe_device_wedged_disable(xe);
-
 	xe_display_unregister(xe);
 
 	drm_dev_unplug(&xe->drm);
@@ -1180,7 +1213,6 @@ void xe_device_shutdown(struct xe_device *xe)
 	drm_dbg(&xe->drm, "Shutting down device\n");
 
 	xe_device_wedged_disable(xe);
-
 	xe_display_shutdown(xe);
 
 	xe_irq_suspend(xe);
@@ -1502,6 +1534,9 @@ void xe_device_declare_wedged(struct xe_device *xe)
 	     READ_ONCE(xe->wedged.method) !=
 	     READ_ONCE(xe->wedged.reported_method)))
 		queue_work(xe->unordered_wq, &xe->wedged.work);
+
+	if (first)
+		complete_all(&xe->wedged.prepared);
 }
 
 /**
diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index f89d539df010..93bb38ed5975 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -6,6 +6,7 @@
 #ifndef _XE_DEVICE_TYPES_H_
 #define _XE_DEVICE_TYPES_H_
 
+#include <linux/completion.h>
 #include <linux/mutex.h>
 #include <linux/pci.h>
 
@@ -113,6 +114,10 @@ struct xe_device {
 #if IS_ENABLED(CONFIG_DRM_XE_DISPLAY)
 	/** @display: display device data, must be placed after drm device member */
 	struct intel_display *display;
+	/** @display_registered: Display userspace interfaces are registered */
+	bool display_registered;
+	/** @display_shutdown: Display hardware shutdown has completed */
+	bool display_shutdown;
 #endif
 
 	/** @devcoredump: device coredump */
@@ -562,8 +567,12 @@ struct xe_device {
 		struct work_struct work;
 		/** @wedged.stopping: Blocks worker requeue and repeated disable */
 		atomic_t stopping;
+		/** @wedged.prepared: First wedge declaration finished and work was queued */
+		struct completion prepared;
 		/** @wedged.reported_method: Last recovery method reported to userspace */
 		unsigned long reported_method;
+		/** @wedged.isolated: Terminal device isolation has completed */
+		bool isolated;
 	} wedged;
 
 	/** @devres_group: devres group */
diff --git a/drivers/gpu/drm/xe/xe_pci.c b/drivers/gpu/drm/xe/xe_pci.c
index d64e873d9e71..25992e4fad43 100644
--- a/drivers/gpu/drm/xe/xe_pci.c
+++ b/drivers/gpu/drm/xe/xe_pci.c
@@ -1326,19 +1326,38 @@ static int xe_pci_suspend(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct xe_device *xe = pdev_to_xe_device(pdev);
+	int io_idx;
 	int err;
 
 	if (xe_survivability_mode_is_boot_enabled(xe))
 		return -EBUSY;
 
-	err = xe_pm_suspend(xe);
-	if (err)
-		return err;
+	/*
+	 * Wait until wedge work is queued, then wait for isolation to
+	 * finish before skipping driver-level suspend.
+	 */
+	err = xe_device_io_get(xe, &io_idx);
+	if (err) {
+		if (!xe_device_wedged(xe))
+			return err;
+
+		wait_for_completion(&xe->wedged.prepared);
+		flush_work(&xe->wedged.work);
+	} else {
+		err = xe_pm_suspend(xe);
+		xe_device_io_put(io_idx);
+
+		if (xe_device_wedged(xe)) {
+			wait_for_completion(&xe->wedged.prepared);
+			flush_work(&xe->wedged.work);
+		} else if (err) {
+			return err;
+		}
+	}
 
 	/*
-	 * Enabling D3Cold is needed for S2Idle/S0ix.
-	 * It is save to allow here since xe_pm_suspend has evicted
-	 * the local memory and the direct complete optimization is disabled.
+	 * Keep PCI suspend common to both paths so resume performs
+	 * matching PCI enable and D3Cold operations.
 	 */
 	d3cold_toggle(pdev, D3COLD_ENABLE);
 
@@ -1352,6 +1371,8 @@ static int xe_pci_suspend(struct device *dev)
 static int xe_pci_resume(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
+	struct xe_device *xe = pdev_to_xe_device(pdev);
+	int io_idx;
 	int err;
 
 	/* Give back the D3Cold decision to the runtime P M*/
@@ -1363,13 +1384,29 @@ static int xe_pci_resume(struct device *dev)
 
 	pci_restore_state(pdev);
 
+	/* Balance PCI suspend regardless of the current wedge state. */
 	err = pci_enable_device(pdev);
 	if (err)
 		return err;
 
+	err = xe_device_io_get(xe, &io_idx);
+	if (err) {
+		pci_clear_master(pdev);
+		return xe_device_wedged(xe) ? 0 : err;
+	}
+
 	pci_set_master(pdev);
 
-	err = xe_pm_resume(pdev_to_xe_device(pdev));
+	err = xe_pm_resume(xe);
+	xe_device_io_put(io_idx);
+
+	if (xe_device_wedged(xe)) {
+		wait_for_completion(&xe->wedged.prepared);
+		flush_work(&xe->wedged.work);
+		pci_clear_master(pdev);
+		return 0;
+	}
+
 	if (err)
 		return err;
 
-- 
2.43.0

