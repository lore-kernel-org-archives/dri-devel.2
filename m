Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A2E606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 10:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lijjo1oz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CAB710FD1E;
	Wed, 21 Oct 2026 10:04:16 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 286DD10FD1E;
 Wed, 21 Oct 2026 10:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792577050; x=1824113050;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Y731MA0SPGv8MqUMkz8AkXTmihCZEYAiIUinYx6g8Vk=;
 b=lijjo1ozT7tOffbBn3PuIfii8y3ASkld+Q+Fn3k5NJNrCffQlvRtONu1
 uzYKjOG8xnF0WIBzRFizP8x1KZrv1IGFRfdaZPH4a2QnNo7FoJ58thBV9
 ljFO/5e1uAWDjdlgQXTKYk0YktU5fL9vFE58IUxxYNpnkIFmHjtCyToNP
 BOHS2zi+XCzFJnSmlojypxGWge1vZZLQz7IhntqSanXqmCE+GlKXwoxrY
 m3zAUsds1IH1iJkY+Y354XuU+2gpmOFSuyBSkpBW/DXyM+SWpWO4eNRBn
 NTuBlVODkedd/9gRYjEO7FfEfGGOl4Hr6ka3nNDCgQaE4ShaXqCEggi1C g==;
X-CSE-ConnectionGUID: fAVN3DhzQl2Ozcm/DzUwZQ==
X-CSE-MsgGUID: AQmkFixdTTWWHaNi6lzglA==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1290321"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1290321"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 03:04:09 -0700
X-CSE-ConnectionGUID: C0wmPZfmRy6bNJ7ejdh4LA==
X-CSE-MsgGUID: Jf/7sE13RvO1Dz239z682g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="3382151"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 03:04:07 -0700
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: matthew.brost@intel.com, himal.prasad.ghimiray@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com
Subject: [RFC v3 13/17] drm/xe: Isolate a wedged device before notifying
 userspace
Date: Wed, 21 Oct 2026 15:33:14 +0530
Message-ID: <20261021100322.1014449-14-arvind.yadav@intel.com>
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

A permanently wedged device must stop interrupt and DMA activity before
userspace is notified that recovery is required.

Run the sleepable isolation steps from the wedge worker. Shut down and
unregister the display, suspend interrupts and clear PCI bus mastering,
then invalidate VRAM mappings. Mapping teardown does not access hardware,
so it runs after DMA has stopped.

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

v3:
 - Protect display registration with the common device I/O gate.
   (Sashiko)
 - Track display PM suspend state to avoid a second display suspend.
   (Sashiko)
 - Keep display lifecycle checks inside the display helpers. (Sashiko)
 - Suspend interrupts and clear PCI bus mastering before invalidating
   VRAM CPU mappings.

Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Assisted-by: LLM
Suggested-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
---
 drivers/gpu/drm/xe/display/xe_display.c | 39 ++++++++++++++++---
 drivers/gpu/drm/xe/xe_device.c          | 45 +++++++++++++++++++---
 drivers/gpu/drm/xe/xe_device_types.h    | 13 +++++++
 drivers/gpu/drm/xe/xe_pci.c             | 51 +++++++++++++++++++++----
 4 files changed, 131 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/xe/display/xe_display.c b/drivers/gpu/drm/xe/display/xe_display.c
index aab416485e3e..62d607afbf38 100644
--- a/drivers/gpu/drm/xe/display/xe_display.c
+++ b/drivers/gpu/drm/xe/display/xe_display.c
@@ -4,6 +4,7 @@
  */
 
 #include "xe_display.h"
+#include "xe_device.h"
 #include "regs/xe_irq_regs.h"
 
 #include <linux/acpi.h>
@@ -141,35 +142,55 @@ int xe_display_init(struct xe_device *xe)
 void xe_display_register(struct xe_device *xe)
 {
 	struct intel_display *display = xe->display;
+	int io_idx;
 
 	if (!xe->info.probe_display)
 		return;
 
+	if (xe_device_io_get(xe, &io_idx))
+		return;
+
+	if (xe->display_registered)
+		goto out;
+
 	intel_display_driver_register(display);
 	intel_display_driver_runtime_pm_enable(display);
+
+	xe->display_registered = true;
+
+out:
+	xe_device_io_put(io_idx);
 }
 
 void xe_display_unregister(struct xe_device *xe)
 {
 	struct intel_display *display = xe->display;
 
-	if (!xe->info.probe_display)
+	if (!xe->info.probe_display || !xe->display_registered)
 		return;
 
-	intel_display_driver_runtime_pm_disable(display);
+	if (!xe->display_shutdown && !xe->display_pm_suspended)
+		intel_display_driver_runtime_pm_disable(display);
+
 	intel_display_driver_unregister(display);
+
+	xe->display_registered = false;
 }
 
 void xe_display_shutdown(struct xe_device *xe)
 {
 	struct intel_display *display = xe->display;
 
-	if (!xe->info.probe_display)
+	if (!xe->info.probe_display || !xe->display_registered ||
+	    xe->display_shutdown ||
+	    xe->display_pm_suspended)
 		return;
 
 	intel_display_driver_shutdown(display);
 
 	intel_opregion_suspend(display, PCI_D3cold);
+
+	xe->display_shutdown = true;
 }
 
 void xe_display_shutdown_late(struct xe_device *xe)
@@ -240,12 +261,16 @@ void xe_display_pm_suspend(struct xe_device *xe)
 	struct intel_display *display = xe->display;
 	bool s2idle = suspend_to_idle();
 
-	if (!xe->info.probe_display)
+	if (!xe->info.probe_display || !xe->display_registered ||
+	    xe->display_shutdown ||
+	    xe->display_pm_suspended)
 		return;
 
 	intel_display_driver_pm_suspend(display);
 
 	intel_opregion_suspend(display, s2idle ? PCI_D1 : PCI_D3cold);
+
+	xe->display_pm_suspended = true;
 }
 
 void xe_display_pm_suspend_late(struct xe_device *xe)
@@ -273,7 +298,9 @@ void xe_display_pm_resume(struct xe_device *xe)
 {
 	struct intel_display *display = xe->display;
 
-	if (!xe->info.probe_display)
+	if (!xe->info.probe_display || !xe->display_registered ||
+	    xe->display_shutdown ||
+	    !xe->display_pm_suspended)
 		return;
 
 	intel_dmc_resume(display);
@@ -284,6 +311,8 @@ void xe_display_pm_resume(struct xe_device *xe)
 	intel_display_driver_init_hw(display);
 
 	intel_display_driver_pm_resume(display);
+
+	xe->display_pm_suspended = false;
 }
 
 static void xe_display_enable_d3cold(struct xe_device *xe)
diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index fa025da253d5..6c1725da732f 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -501,6 +501,7 @@ int xe_device_init_early(struct xe_device *xe)
 	int err;
 
 	INIT_WORK(&xe->wedged.work, xe_device_wedged_work);
+	init_completion(&xe->wedged.prepared);
 	xe->wedged.reported_method = ~0UL;
 
 	err = ttm_device_init(&xe->ttm, &xe_ttm_funcs, xe->drm.dev,
@@ -929,6 +930,41 @@ static void xe_uid_probe(struct xe_device *xe)
 		xe->device_uid = xe_mmio_read64_2x32(xe_root_tile_mmio(xe), CRI_DEVICE_UID);
 }
 
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
@@ -936,9 +972,7 @@ static void xe_device_wedged_work(struct work_struct *work)
 	unsigned long method;
 	int err;
 
-	/* Drain active faults before invalidating VRAM mappings. */
-	xe_device_io_drain(xe);
-	xe_bo_wedged_invalidate_mmaps(xe);
+	xe_device_wedged_isolate(xe);
 
 	/* Report at most one recovery method per worker invocation. */
 	method = READ_ONCE(xe->wedged.method);
@@ -1216,7 +1250,6 @@ int xe_device_probe(struct xe_device *xe)
 void xe_device_remove(struct xe_device *xe)
 {
 	xe_device_wedged_disable(xe);
-
 	xe_display_unregister(xe);
 
 	drm_dev_unplug(&xe->drm);
@@ -1234,7 +1267,6 @@ void xe_device_shutdown(struct xe_device *xe)
 	drm_dbg(&xe->drm, "Shutting down device\n");
 
 	xe_device_wedged_disable(xe);
-
 	xe_display_shutdown(xe);
 
 	xe_irq_suspend(xe);
@@ -1557,6 +1589,9 @@ void xe_device_declare_wedged(struct xe_device *xe)
 	     READ_ONCE(xe->wedged.method) !=
 	     READ_ONCE(xe->wedged.reported_method)))
 		queue_work(xe->unordered_wq, &xe->wedged.work);
+
+	if (first)
+		complete_all(&xe->wedged.prepared);
 }
 
 /**
diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index 7cb257912b75..1d3f72f6f315 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -6,6 +6,7 @@
 #ifndef _XE_DEVICE_TYPES_H_
 #define _XE_DEVICE_TYPES_H_
 
+#include <linux/completion.h>
 #include <linux/mutex.h>
 #include <linux/pci.h>
 
@@ -113,6 +114,14 @@ struct xe_device {
 #if IS_ENABLED(CONFIG_DRM_XE_DISPLAY)
 	/** @display: display device data, must be placed after drm device member */
 	struct intel_display *display;
+	/** @display_registered: Display userspace interfaces are registered */
+	bool display_registered;
+	/**
+	 * @display_pm_suspended: Display was suspended by system PM
+	 */
+	bool display_pm_suspended;
+	/** @display_shutdown: Display hardware shutdown has completed */
+	bool display_shutdown;
 #endif
 
 	/** @devcoredump: device coredump */
@@ -573,8 +582,12 @@ struct xe_device {
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
index 0c13eb901aa7..e0e593ff8b62 100644
--- a/drivers/gpu/drm/xe/xe_pci.c
+++ b/drivers/gpu/drm/xe/xe_pci.c
@@ -1337,19 +1337,38 @@ static int xe_pci_suspend(struct device *dev)
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
 
@@ -1363,6 +1382,8 @@ static int xe_pci_suspend(struct device *dev)
 static int xe_pci_resume(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
+	struct xe_device *xe = pdev_to_xe_device(pdev);
+	int io_idx;
 	int err;
 
 	/* Give back the D3Cold decision to the runtime P M*/
@@ -1374,13 +1395,29 @@ static int xe_pci_resume(struct device *dev)
 
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

