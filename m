Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3042EC982FF
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 10:17:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8697F10E6B7;
	Tue, 22 Sep 2026 10:17:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="GydHJtsA";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8637C10E47C;
 Tue, 22 Sep 2026 10:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790072271; x=1821608271;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QhOew8Rpn6+bCVCk0NHh1xLTmtn4gWTmtrQ7K4yP998=;
 b=GydHJtsAIKXv6eZf+k1+HUeN6o6mm9/dj+JMveB2CAZdqLOMfH3A1jsG
 fpFo1cGni4urkQxCpMm5B4usrt8RpWU+3P24PCj3x1h9BkVfigw/MZ5em
 c9Smb+N2ra0a5stPSBeShLFQaoHHxlmzhP/DJptDAfDRpg4CrOqJibMif
 SO7sAebSHD4tNjsa7nKIlkTnmWMhA1dmEXEKxO8VZmwXUHS8mU0abJgIF
 lrlKmqzL8mA0VeoeKlhmzIRdS/nLaZMvU395gAvxSkoHD/3KGLtzl+dmc
 3MeSKNkpYasBIr6Jh1bJU7/CirQuhsgJdHafbAw++boUrz9DQrdNLzFz0 Q==;
X-CSE-ConnectionGUID: oTeKszjJQNWJcpmUcAJ7Bg==
X-CSE-MsgGUID: czJlBgvqQA2QQj27K5DgNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="101322811"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="101322811"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 03:17:50 -0700
X-CSE-ConnectionGUID: D8iXfOG8R2+8Dl+z9/eGcw==
X-CSE-MsgGUID: a0DvETp9RYa08G1TgIWRSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="299307822"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 03:17:48 -0700
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: matthew.brost@intel.com, himal.prasad.ghimiray@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com
Subject: [PATCH v2 07/15] drm/xe: Send wedged notification from a worker
Date: Tue, 22 Sep 2026 15:46:52 +0530
Message-ID: <20260922101721.1583542-8-arvind.yadav@intel.com>
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

v2:
 - Update reported_method only when drm_dev_wedged_event() succeeds.
   (Andi)
 - Requeue only if the recovery method changed, avoiding repeated
   retries when notification fails.
 - Make wedge worker shutdown one-shot.

Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
---
 drivers/gpu/drm/xe/xe_device.c       | 83 +++++++++++++++++++++++-----
 drivers/gpu/drm/xe/xe_device_types.h |  6 ++
 2 files changed, 75 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index 9a940ba8dc1c..045b5844e5c3 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -84,6 +84,8 @@
 #include <generated/xe_device_wa_oob.h>
 #include <generated/xe_wa_oob.h>
 
+static void xe_device_wedged_work(struct work_struct *work);
+
 static int xe_file_open(struct drm_device *dev, struct drm_file *file)
 {
 	struct xe_device *xe = to_xe_device(dev);
@@ -466,6 +468,9 @@ int xe_device_init_early(struct xe_device *xe)
 {
 	int err;
 
+	INIT_WORK(&xe->wedged.work, xe_device_wedged_work);
+	xe->wedged.reported_method = ~0UL;
+
 	err = ttm_device_init(&xe->ttm, &xe_ttm_funcs, xe->drm.dev,
 			      xe->drm.anon_inode->i_mapping,
 			      xe->drm.vma_offset_manager,
@@ -884,6 +889,40 @@ static int xe_debug_page_size_alloc_ctrl_init(struct xe_device *xe)
 }
 #endif
 
+static void xe_device_wedged_work(struct work_struct *work)
+{
+	struct xe_device *xe =
+			container_of(work, struct xe_device, wedged.work);
+	unsigned long method;
+	int err;
+
+	/* Report at most one recovery method per worker invocation. */
+	method = READ_ONCE(xe->wedged.method);
+	if (method != READ_ONCE(xe->wedged.reported_method)) {
+		err = drm_dev_wedged_event(&xe->drm, method, NULL);
+		if (!err)
+			WRITE_ONCE(xe->wedged.reported_method, method);
+	}
+
+	/*
+	 * Queue another pass if the method changed while the event was sent.
+	 * This preserves the update without keeping this worker in a loop.
+	 */
+	if (!atomic_read(&xe->wedged.stopping) &&
+	    READ_ONCE(xe->wedged.method) != method)
+		queue_work(xe->unordered_wq, &xe->wedged.work);
+}
+
+static void xe_device_wedged_disable(void *arg)
+{
+	struct xe_device *xe = arg;
+
+	if (atomic_xchg(&xe->wedged.stopping, 1))
+		return;
+
+	disable_work_sync(&xe->wedged.work);
+}
+
 int xe_device_probe(struct xe_device *xe)
 {
 	struct xe_tile *tile;
@@ -996,6 +1035,12 @@ int xe_device_probe(struct xe_device *xe)
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
@@ -1105,6 +1150,7 @@ int xe_device_probe(struct xe_device *xe)
 	return 0;
 
 err_unregister_display:
+	xe_device_wedged_disable(xe);
 	xe_display_unregister(xe);
 	drm_dev_unregister(&xe->drm);
 
@@ -1113,6 +1159,8 @@ int xe_device_probe(struct xe_device *xe)
 
 void xe_device_remove(struct xe_device *xe)
 {
+	xe_device_wedged_disable(xe);
+
 	xe_display_unregister(xe);
 
 	drm_dev_unplug(&xe->drm);
@@ -1127,6 +1175,8 @@ void xe_device_shutdown(struct xe_device *xe)
 
 	drm_dbg(&xe->drm, "Shutting down device\n");
 
+	xe_device_wedged_disable(xe);
+
 	xe_display_shutdown(xe);
 
 	xe_irq_suspend(xe);
@@ -1379,7 +1429,7 @@ u64 xe_device_uncanonicalize_addr(struct xe_device *xe, u64 address)
  */
 void xe_device_set_wedged_method(struct xe_device *xe, unsigned long method)
 {
-	xe->wedged.method = method;
+	WRITE_ONCE(xe->wedged.method, method);
 }
 
 #define WEDGED_URL	"https://docs.kernel.org/gpu/drm-uapi.html#device-wedging"
@@ -1406,6 +1456,7 @@ void xe_device_set_wedged_method(struct xe_device *xe, unsigned long method)
 void xe_device_declare_wedged(struct xe_device *xe)
 {
 	struct xe_gt *gt;
+	bool first;
 	u8 id;
 
 	if (xe->wedged.mode == XE_WEDGED_MODE_NEVER) {
@@ -1413,7 +1464,8 @@ void xe_device_declare_wedged(struct xe_device *xe)
 		return;
 	}
 
-	if (!atomic_xchg(&xe->wedged.flag, 1)) {
+	first = !atomic_xchg(&xe->wedged.flag, 1);
+	if (first) {
 		xe->needs_flr_on_fini = true;
 		xe_pm_runtime_get_noresume(xe);
 
@@ -1422,12 +1474,7 @@ void xe_device_declare_wedged(struct xe_device *xe)
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
@@ -1435,14 +1482,22 @@ void xe_device_declare_wedged(struct xe_device *xe)
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
+	if (!atomic_read(&xe->wedged.stopping) &&
+	    (first ||
+	     READ_ONCE(xe->wedged.method) !=
+	     READ_ONCE(xe->wedged.reported_method)))
+		queue_work(xe->unordered_wq, &xe->wedged.work);
 }
 
 /**
diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index bb4234f00453..df4e274bc719 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -554,6 +554,12 @@ struct xe_device {
 		unsigned long method;
 		/** @wedged.inconsistent_reset: Inconsistent reset policy state between GTs */
 		bool inconsistent_reset;
+		/** @wedged.work: Runs sleepable wedge handling */
+		struct work_struct work;
+		/** @wedged.stopping: Blocks worker requeue and repeated disable */
+		atomic_t stopping;
+		/** @wedged.reported_method: Last recovery method reported to userspace */
+		unsigned long reported_method;
 	} wedged;
 
 	/** @devres_group: devres group */
-- 
2.43.0

