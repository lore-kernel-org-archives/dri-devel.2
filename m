Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED913C61DC2
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 10:18:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1489210EF8E;
	Thu, 27 Aug 2026 10:18:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Bazv87O0";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D1E810EFAB;
 Thu, 27 Aug 2026 10:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787825928; x=1819361928;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=55EB5RzEQQazdAmIy6GGaoNWFmMQ4n3v0FVdJ7/J+EQ=;
 b=Bazv87O0IppRTRh98rFsF6QzyRklY7ojfh8G0Q+RB0sox6NalyZCEmlw
 p/hXBLbXnQGYvxkChgc/kmO/BCZQ0eRjY+SWt6G9ZMmXjmZNch/w/FzyI
 u3IpwUsjfM1i/x4vXsw4Jcr24h0trmwMAgJXqcpjTujx45N0AIgDNAaZC
 MNUqEjG/qFhdxgC6UBsJxdU1qALgX+Hq8kmAvbsBlSo/lU8+Yi1Amwi3g
 DiIi7qN7j0RqWcAMuGphPGM6SlwwyTUZfevTFaUVsxcEj16731rr3jtRm
 xsf6OyRqiqB8SmiZegq07F0ONwBD3OBM15IPNeAVz5ILdfPl3ElC/Q1DH Q==;
X-CSE-ConnectionGUID: cGpCTQZ7Sh2gaGLI6/bMvw==
X-CSE-MsgGUID: tVqueg3DTOiQGq+iniFKEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="88445875"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; d="scan'208";a="88445875"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 03:18:48 -0700
X-CSE-ConnectionGUID: 7z0kcHzfSDmucA+Uq0SVug==
X-CSE-MsgGUID: wIWGw7eqTVWTJZNldKSReg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; d="scan'208";a="306057647"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 03:18:46 -0700
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: matthew.brost@intel.com, himal.prasad.ghimiray@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com
Subject: [PATCH 09/13] drm/xe: Isolate a wedged device before notifying
 userspace
Date: Thu, 27 Aug 2026 15:47:57 +0530
Message-ID: <20260827101801.1247654-10-arvind.yadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827101801.1247654-1-arvind.yadav@intel.com>
References: <20260827101801.1247654-1-arvind.yadav@intel.com>
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
unregister the display, invalidate VRAM mappings, suspend interrupts and
clear PCI bus mastering before sending the event. GTs are declared
wedged before the work is queued, so pending fences are signalled before
the worker waits for fault-side SRCU readers.

Track display and isolation state so later teardown does not repeat these
steps. Display shutdown already disables display power, so skip the
runtime PM disable when unregister follows shutdown.

System suspend may see the wedge flag before the worker is queued. Use a
completion to close this window and flush the worker before skipping
normal device suspend. The IRQ serialization keeps a racing resume from
enabling interrupts after isolation.

For a wedged device, resume restores PCI configuration and clears bus
mastering. Do not call pci_enable_device() because suspend did not take
the matching disable reference.

Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
---
 drivers/gpu/drm/xe/display/xe_display.c | 18 +++++++++---
 drivers/gpu/drm/xe/xe_device.c          | 38 +++++++++++++++++++++++--
 drivers/gpu/drm/xe/xe_device_types.h    |  9 ++++++
 drivers/gpu/drm/xe/xe_pci.c             | 23 ++++++++++++++-
 4 files changed, 81 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/xe/display/xe_display.c b/drivers/gpu/drm/xe/display/xe_display.c
index 7b25c0814674..ce9ebc6701ff 100644
--- a/drivers/gpu/drm/xe/display/xe_display.c
+++ b/drivers/gpu/drm/xe/display/xe_display.c
@@ -150,21 +150,28 @@ void xe_display_register(struct xe_device *xe)
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
+	/* Make display unregister idempotent. */
+	xe->display_registered = false;
+
+	if (!xe->display_shutdown)
+		intel_display_driver_runtime_pm_disable(display);
+
 	intel_display_driver_unregister(display);
 }
 
@@ -172,7 +179,8 @@ void xe_display_shutdown(struct xe_device *xe)
 {
 	struct intel_display *display = xe->display;
 
-	if (!xe->info.probe_display)
+	if (!xe->info.probe_display || !xe->display_registered ||
+	    xe->display_shutdown)
 		return;
 
 	intel_display_driver_shutdown(display);
@@ -180,6 +188,8 @@ void xe_display_shutdown(struct xe_device *xe)
 	intel_opregion_suspend(display, PCI_D3cold);
 
 	intel_dmc_suspend(display);
+
+	xe->display_shutdown = true;
 }
 
 void xe_display_shutdown_late(struct xe_device *xe)
diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index 98ef5123c841..101cfa8e2102 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -538,6 +538,7 @@ int xe_device_init_early(struct xe_device *xe)
 	int err;
 
 	INIT_WORK(&xe->wedged.work, xe_device_wedged_work);
+	init_completion(&xe->wedged.prepared);
 	xe->wedged.reported_method = ~0UL;
 
 	err = ttm_device_init(&xe->ttm, &xe_ttm_funcs, xe->drm.dev,
@@ -958,14 +959,44 @@ static int xe_debug_page_size_alloc_ctrl_init(struct xe_device *xe)
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
+	if (!xe->wedged.isolated) {
+		xe_display_shutdown(xe);
+		xe_display_unregister(xe);
+
+		/*
+		 * Drain faults and unmap VRAM before disabling IRQs and
+		 * DMA.
+		 */
+		xe_bo_wedged_invalidate_mmaps(xe);
+
+		/* Drain handlers before preventing any further device DMA. */
+		xe_irq_suspend(xe);
+		pci_clear_master(to_pci_dev(xe->drm.dev));
+
+		xe->wedged.isolated = true;
+	}
+}
+
 static void xe_device_wedged_work(struct work_struct *work)
 {
 	struct xe_device *xe =
 			container_of(work, struct xe_device, wedged.work);
 	unsigned long method;
 
-	/* Drain faults and invalidate existing VRAM mappings. */
-	xe_bo_wedged_invalidate_mmaps(xe);
+	xe_device_wedged_isolate(xe);
 
 	/* Report at most one recovery method per worker invocation. */
 	method = READ_ONCE(xe->wedged.method);
@@ -1556,6 +1587,9 @@ void xe_device_declare_wedged(struct xe_device *xe)
 	    READ_ONCE(xe->wedged.method) !=
 	    READ_ONCE(xe->wedged.reported_method))
 		queue_work(xe->unordered_wq, &xe->wedged.work);
+
+	if (first)
+		complete_all(&xe->wedged.prepared);
 }
 
 /**
diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index dda4d9919ca6..508ba3872e72 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -6,6 +6,7 @@
 #ifndef _XE_DEVICE_TYPES_H_
 #define _XE_DEVICE_TYPES_H_
 
+#include <linux/completion.h>
 #include <linux/mutex.h>
 #include <linux/pci.h>
 #include <linux/srcu.h>
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
@@ -547,8 +552,12 @@ struct xe_device {
 		bool inconsistent_reset;
 		/** @wedged.work: Runs sleepable wedge handling */
 		struct work_struct work;
+		/** @wedged.prepared: First wedge declaration finished and work was queued */
+		struct completion prepared;
 		/** @wedged.reported_method: Last recovery method reported to userspace */
 		unsigned long reported_method;
+		/** @wedged.isolated: Terminal device isolation has completed */
+		bool isolated;
 	} wedged;
 
 	/** @devres_group: devres group */
diff --git a/drivers/gpu/drm/xe/xe_pci.c b/drivers/gpu/drm/xe/xe_pci.c
index ab4da1d9a9f1..aaeb7d068175 100644
--- a/drivers/gpu/drm/xe/xe_pci.c
+++ b/drivers/gpu/drm/xe/xe_pci.c
@@ -1332,6 +1332,16 @@ static int xe_pci_suspend(struct device *dev)
 	if (xe_survivability_mode_is_boot_enabled(xe))
 		return -EBUSY;
 
+	/*
+	 * Wait until wedge work is queued, then wait for isolation to
+	 * finish before skipping normal suspend.
+	 */
+	if (xe_device_wedged(xe)) {
+		wait_for_completion(&xe->wedged.prepared);
+		flush_work(&xe->wedged.work);
+		return 0;
+	}
+
 	err = xe_pm_suspend(xe);
 	if (err)
 		return err;
@@ -1353,6 +1363,7 @@ static int xe_pci_suspend(struct device *dev)
 static int xe_pci_resume(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
+	struct xe_device *xe = pdev_to_xe_device(pdev);
 	int err;
 
 	/* Give back the D3Cold decision to the runtime P M*/
@@ -1364,13 +1375,23 @@ static int xe_pci_resume(struct device *dev)
 
 	pci_restore_state(pdev);
 
+	/*
+	 * Suspend skipped PCI disable for an already isolated device. Avoid
+	 * incrementing enable_cnt and clear bus mastering restored from the
+	 * saved configuration.
+	 */
+	if (xe_device_wedged(xe)) {
+		pci_clear_master(pdev);
+		return 0;
+	}
+
 	err = pci_enable_device(pdev);
 	if (err)
 		return err;
 
 	pci_set_master(pdev);
 
-	err = xe_pm_resume(pdev_to_xe_device(pdev));
+	err = xe_pm_resume(xe);
 	if (err)
 		return err;
 
-- 
2.43.0

