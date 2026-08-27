Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C4F7C61DC2
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 10:18:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A776510E3DC;
	Thu, 27 Aug 2026 10:18:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="PuUJtBGa";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D495410EF92;
 Thu, 27 Aug 2026 10:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787825919; x=1819361919;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Whu9r795dXhNFA3wLb6AFivB5+R7vRa0XznDo+tbGdU=;
 b=PuUJtBGagwuwbzE8MP0jvCIcwdQLXqIwq2ppghsmRF+5JLvqZBZ1iP29
 SfXAc2prxRJu+CWuZFJLsTV9Dl208UEnvMUrOoJutKu38WnZy0fwIjSC1
 S+szWu8U8nTYcyC6Y08Hs2AVlKvT0GeV8NgOWOnxPABajKsG3sYY+g54s
 4OSTQgBps8BjTySjdMuDwov3NguPXVgiDH93Kd1LDWYOk3/H067taT3xD
 SbJrlvuhczDklY1t7uHZcYR0FxfaLLFf9Q41dj6SzVF2AzaeOtEx8FtGr
 sc9BQAjjofmvEorg2RTuzHCPXMXD7eCnXPBGLIlP5JGMhofqjnY0Mu8N5 A==;
X-CSE-ConnectionGUID: mrAksDypSTeObkLq1BtJJA==
X-CSE-MsgGUID: CK2PjqZNRnem/5XQizk/9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="88445866"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; d="scan'208";a="88445866"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 03:18:39 -0700
X-CSE-ConnectionGUID: YMExoz9TTeuWMfIydXQH4g==
X-CSE-MsgGUID: pPORnhlrQ9WEFNYZcanVbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; d="scan'208";a="306057628"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 03:18:38 -0700
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: matthew.brost@intel.com, himal.prasad.ghimiray@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com
Subject: [PATCH 05/13] drm/xe: Send wedged notification from a worker
Date: Thu, 27 Aug 2026 15:47:53 +0530
Message-ID: <20260827101801.1247654-6-arvind.yadav@intel.com>
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

Move the wedged event to a device worker. This provides a sleepable
context for later isolation work and allows it to complete before
userspace is notified.

Keep one-time wedge bookkeeping on the first transition, but rescan the
GT state on later declarations because the recovery method may change.
For example, survivability handling can add VENDOR recovery after an
earlier REBIND notification.

Track the last reported method and resample it after each event so an
update is not lost when the worker is already running.

Drain the worker before probe cleanup, remove, shutdown and IRQ teardown
to prevent it from racing device teardown.

Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
---
 drivers/gpu/drm/xe/xe_device.c       | 77 +++++++++++++++++++++++-----
 drivers/gpu/drm/xe/xe_device_types.h |  4 ++
 2 files changed, 67 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index a92e90acdf0d..ffbaf85eaab1 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -83,6 +83,8 @@
 #include <generated/xe_device_wa_oob.h>
 #include <generated/xe_wa_oob.h>
 
+static void xe_device_wedged_work(struct work_struct *work);
+
 static int xe_file_open(struct drm_device *dev, struct drm_file *file)
 {
 	struct xe_device *xe = to_xe_device(dev);
@@ -535,6 +537,9 @@ int xe_device_init_early(struct xe_device *xe)
 {
 	int err;
 
+	INIT_WORK(&xe->wedged.work, xe_device_wedged_work);
+	xe->wedged.reported_method = ~0UL;
+
 	err = ttm_device_init(&xe->ttm, &xe_ttm_funcs, xe->drm.dev,
 			      xe->drm.anon_inode->i_mapping,
 			      xe->drm.vma_offset_manager,
@@ -953,6 +958,35 @@ static int xe_debug_page_size_alloc_ctrl_init(struct xe_device *xe)
 }
 #endif
 
+static void xe_device_wedged_work(struct work_struct *work)
+{
+	struct xe_device *xe =
+			container_of(work, struct xe_device, wedged.work);
+	unsigned long method;
+
+	/* Report at most one recovery method per worker invocation. */
+	method = READ_ONCE(xe->wedged.method);
+	if (method != READ_ONCE(xe->wedged.reported_method)) {
+		drm_dev_wedged_event(&xe->drm, method, NULL);
+		WRITE_ONCE(xe->wedged.reported_method, method);
+	}
+
+	/*
+	 * Queue another pass if the method changed while the event was sent.
+	 * This preserves the update without keeping this worker in a loop.
+	 */
+	if (READ_ONCE(xe->wedged.method) !=
+	    READ_ONCE(xe->wedged.reported_method))
+		queue_work(xe->unordered_wq, &xe->wedged.work);
+}
+
+static void xe_device_wedged_disable(void *arg)
+{
+	struct xe_device *xe = arg;
+
+	disable_work_sync(&xe->wedged.work);
+}
+
 int xe_device_probe(struct xe_device *xe)
 {
 	struct xe_tile *tile;
@@ -1061,6 +1095,12 @@ int xe_device_probe(struct xe_device *xe)
 	if (err)
 		return err;
 
+	/* Drain wedge work before irq_uninstall() during devres unwind. */
+	err = devm_add_action_or_reset(xe->drm.dev,
+				       xe_device_wedged_disable, xe);
+	if (err)
+		return err;
+
 	for_each_gt(gt, xe, id) {
 		err = xe_gt_init(gt);
 		if (err)
@@ -1166,6 +1206,7 @@ int xe_device_probe(struct xe_device *xe)
 	return 0;
 
 err_unregister_display:
+	xe_device_wedged_disable(xe);
 	xe_display_unregister(xe);
 	drm_dev_unregister(&xe->drm);
 
@@ -1174,6 +1215,8 @@ int xe_device_probe(struct xe_device *xe)
 
 void xe_device_remove(struct xe_device *xe)
 {
+	xe_device_wedged_disable(xe);
+
 	xe_display_unregister(xe);
 
 	drm_dev_unplug(&xe->drm);
@@ -1188,6 +1231,8 @@ void xe_device_shutdown(struct xe_device *xe)
 
 	drm_dbg(&xe->drm, "Shutting down device\n");
 
+	xe_device_wedged_disable(xe);
+
 	xe_display_shutdown(xe);
 
 	xe_irq_suspend(xe);
@@ -1440,7 +1485,7 @@ u64 xe_device_uncanonicalize_addr(struct xe_device *xe, u64 address)
  */
 void xe_device_set_wedged_method(struct xe_device *xe, unsigned long method)
 {
-	xe->wedged.method = method;
+	WRITE_ONCE(xe->wedged.method, method);
 }
 
 #define WEDGED_URL	"https://docs.kernel.org/gpu/drm-uapi.html#device-wedging"
@@ -1467,6 +1512,7 @@ void xe_device_set_wedged_method(struct xe_device *xe, unsigned long method)
 void xe_device_declare_wedged(struct xe_device *xe)
 {
 	struct xe_gt *gt;
+	bool first;
 	u8 id;
 
 	if (xe->wedged.mode == XE_WEDGED_MODE_NEVER) {
@@ -1474,7 +1520,8 @@ void xe_device_declare_wedged(struct xe_device *xe)
 		return;
 	}
 
-	if (!atomic_xchg(&xe->wedged.flag, 1)) {
+	first = !atomic_xchg(&xe->wedged.flag, 1);
+	if (first) {
 		xe->needs_flr_on_fini = true;
 		xe_pm_runtime_get_noresume(xe);
 
@@ -1483,12 +1530,7 @@ void xe_device_declare_wedged(struct xe_device *xe)
 			    "For recovery procedure, refer to %s\n"
 			    "Please file a _new_ bug report at %s\n",
 			    WEDGED_URL, XE_BUG_URL);
-	}
-
-	for_each_gt(gt, xe, id)
-		xe_gt_declare_wedged(gt);
 
-	if (xe_device_wedged(xe)) {
 		/*
 		 * XE_WEDGED_MODE_UPON_ANY_HANG_NO_RESET is intended for debugging
 		 * hangs, so wedge the device with 'none' recovery method and have
@@ -1496,14 +1538,21 @@ void xe_device_declare_wedged(struct xe_device *xe)
 		 */
 		if (xe->wedged.mode == XE_WEDGED_MODE_UPON_ANY_HANG_NO_RESET)
 			xe_device_set_wedged_method(xe, DRM_WEDGE_RECOVERY_NONE);
-		/* If no wedge recovery method is set, use default */
-		else if (!xe->wedged.method)
-			xe_device_set_wedged_method(xe, DRM_WEDGE_RECOVERY_REBIND |
-						    DRM_WEDGE_RECOVERY_BUS_RESET);
-
-		/* Notify userspace of wedged device */
-		drm_dev_wedged_event(&xe->drm, xe->wedged.method, NULL);
 	}
+
+	/* Re-scan GT submission state on every declaration. */
+	for_each_gt(gt, xe, id)
+		xe_gt_declare_wedged(gt);
+
+	/* If no wedge recovery method is set, use default */
+	if (!READ_ONCE(xe->wedged.method))
+		xe_device_set_wedged_method(xe, DRM_WEDGE_RECOVERY_REBIND |
+					    DRM_WEDGE_RECOVERY_BUS_RESET);
+
+	if (first ||
+	    READ_ONCE(xe->wedged.method) !=
+	    READ_ONCE(xe->wedged.reported_method))
+		queue_work(xe->unordered_wq, &xe->wedged.work);
 }
 
 /**
diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index 180d450a6deb..382a2b470647 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -534,6 +534,10 @@ struct xe_device {
 		unsigned long method;
 		/** @wedged.inconsistent_reset: Inconsistent reset policy state between GTs */
 		bool inconsistent_reset;
+		/** @wedged.work: Runs sleepable wedge handling */
+		struct work_struct work;
+		/** @wedged.reported_method: Last recovery method reported to userspace */
+		unsigned long reported_method;
 	} wedged;
 
 	/** @devres_group: devres group */
-- 
2.43.0

