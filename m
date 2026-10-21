Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D20606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 10:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DmlUmryt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5016510FD39;
	Wed, 21 Oct 2026 10:04:19 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06EBC10FD2F;
 Wed, 21 Oct 2026 10:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792577040; x=1824113040;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/YsWyzIe9mXGuMgAe7y84syney5sQJH+YhQ3NjODW/4=;
 b=DmlUmryt07PlKC/HeK8DM8WxWcTVjkVwOrbwDLPK+IpzaQKJeeY7MH2r
 P+3CF8Pt2AbXJldHc6G3i0VmUfzfdAEQxgLCdlxekkTx+nfd7Bxbfc1Mg
 pzByiour4Bv7Xdc+YlIkaTbtpJStAV5WdsnHFXsBOMe4oySpU+Tsd9nXf
 GCoL0SSjgYEPeTSeYdNI4mrEVDrZ5Ya7Dv6gtiIxV0HoexaKzpMFxH1rq
 MZ24So5a2ugQftoFqVjp7BZ6N4UKp4PXZ6vOXSgxjrqoiLXyNjPNlgFpL
 qpPpjbRG2BBxJZJWq6OTebeMLEn5FsTaX6QJdDnQnf7X4vijd1MElsOFC g==;
X-CSE-ConnectionGUID: k5gxbQQXQ6KvSFewM1id6g==
X-CSE-MsgGUID: n6c/6MZ5RBWZVKAQvpfSCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1290305"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1290305"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 03:04:00 -0700
X-CSE-ConnectionGUID: vo0EOkOzTyadnT7UEHiaDQ==
X-CSE-MsgGUID: hLV0Nxj/Q2GS6l32CNUj4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="3382106"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 03:03:58 -0700
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: matthew.brost@intel.com, himal.prasad.ghimiray@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com
Subject: [RFC v3 09/17] drm/xe: Send wedged notification from a worker
Date: Wed, 21 Oct 2026 15:33:10 +0530
Message-ID: <20261021100322.1014449-10-arvind.yadav@intel.com>
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

Move the wedged event to a device worker. This provides a sleepable
context for later isolation work and allows it to complete before
userspace is notified.

Prepare the GTs only on the first wedge declaration. Reject queue
publication after the wedge under the submission lock, so a queue
cannot appear after the scan.

Later declarations can update the recovery method and requeue
notification without repeating GT preparation.

Track the last reported method and resample it after each event so an
update is not lost when the worker is already running.

Stop the worker before probe cleanup, remove, shutdown and GT devres
cleanup so it cannot race device teardown.

v2:
 - Update reported_method only when drm_dev_wedged_event() succeeds.
   (Andi)
 - Requeue only if the recovery method changed, avoiding repeated
   retries when notification fails.
 - Make wedge worker shutdown one-shot.

v3:
 - Use cmpxchg() when setting the default recovery method to avoid
   overwriting a concurrent method update. (Sashiko)
 - Stop the wedge worker before GT devres cleanup.
 - Stop wedge handling explicitly if GT initialization fails.
 - Run GT preparation only on the first wedge declaration.
 - Reject queue publication after a permanent wedge.

Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Assisted-by: LLM
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
---
 drivers/gpu/drm/xe/xe_device.c       | 85 +++++++++++++++++++++++-----
 drivers/gpu/drm/xe/xe_device_types.h |  6 ++
 drivers/gpu/drm/xe/xe_guc_submit.c   |  9 +++
 3 files changed, 86 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index 9112462bda6d..4d4139fa1be4 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -85,6 +85,8 @@
 #include <generated/xe_device_wa_oob.h>
 #include <generated/xe_wa_oob.h>
 
+static void xe_device_wedged_work(struct work_struct *work);
+
 static int xe_file_open(struct drm_device *dev, struct drm_file *file)
 {
 	struct xe_device *xe = to_xe_device(dev);
@@ -498,6 +500,9 @@ int xe_device_init_early(struct xe_device *xe)
 {
 	int err;
 
+	INIT_WORK(&xe->wedged.work, xe_device_wedged_work);
+	xe->wedged.reported_method = ~0UL;
+
 	err = ttm_device_init(&xe->ttm, &xe_ttm_funcs, xe->drm.dev,
 			      xe->drm.anon_inode->i_mapping,
 			      xe->drm.vma_offset_manager,
@@ -924,6 +929,40 @@ static void xe_uid_probe(struct xe_device *xe)
 		xe->device_uid = xe_mmio_read64_2x32(xe_root_tile_mmio(xe), CRI_DEVICE_UID);
 }
 
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
@@ -1044,10 +1083,18 @@ int xe_device_probe(struct xe_device *xe)
 
 	for_each_gt(gt, xe, id) {
 		err = xe_gt_init(gt);
-		if (err)
+		if (err) {
+			xe_device_wedged_disable(xe);
 			return err;
+		}
 	}
 
+	/* Stop wedge work before GT and IRQ devres cleanup. */
+	err = devm_add_action_or_reset(xe->drm.dev,
+				       xe_device_wedged_disable, xe);
+	if (err)
+		return err;
+
 	err = xe_vram_memtest(xe);
 	if (err)
 		return err;
@@ -1155,6 +1202,7 @@ int xe_device_probe(struct xe_device *xe)
 	return 0;
 
 err_unregister_display:
+	xe_device_wedged_disable(xe);
 	xe_display_unregister(xe);
 	drm_dev_unregister(&xe->drm);
 
@@ -1163,6 +1211,8 @@ int xe_device_probe(struct xe_device *xe)
 
 void xe_device_remove(struct xe_device *xe)
 {
+	xe_device_wedged_disable(xe);
+
 	xe_display_unregister(xe);
 
 	drm_dev_unplug(&xe->drm);
@@ -1179,6 +1229,8 @@ void xe_device_shutdown(struct xe_device *xe)
 
 	drm_dbg(&xe->drm, "Shutting down device\n");
 
+	xe_device_wedged_disable(xe);
+
 	xe_display_shutdown(xe);
 
 	xe_irq_suspend(xe);
@@ -1431,7 +1483,7 @@ u64 xe_device_uncanonicalize_addr(struct xe_device *xe, u64 address)
  */
 void xe_device_set_wedged_method(struct xe_device *xe, unsigned long method)
 {
-	xe->wedged.method = method;
+	WRITE_ONCE(xe->wedged.method, method);
 }
 
 #define WEDGED_URL	"https://docs.kernel.org/gpu/drm-uapi.html#device-wedging"
@@ -1458,6 +1510,7 @@ void xe_device_set_wedged_method(struct xe_device *xe, unsigned long method)
 void xe_device_declare_wedged(struct xe_device *xe)
 {
 	struct xe_gt *gt;
+	bool first;
 	u8 id;
 
 	if (xe->wedged.mode == XE_WEDGED_MODE_NEVER) {
@@ -1465,7 +1518,8 @@ void xe_device_declare_wedged(struct xe_device *xe)
 		return;
 	}
 
-	if (!atomic_xchg(&xe->wedged.flag, 1)) {
+	first = !atomic_xchg(&xe->wedged.flag, 1);
+	if (first) {
 		xe->needs_flr_on_fini = true;
 		xe_pm_runtime_get_noresume(xe);
 		wake_up_all(&xe->ufence_wq);
@@ -1475,12 +1529,7 @@ void xe_device_declare_wedged(struct xe_device *xe)
 			    "For recovery procedure, refer to %s\n"
 			    "Please file a _new_ bug report at %s\n",
 			    WEDGED_URL, XE_BUG_URL);
-	}
 
-	for_each_gt(gt, xe, id)
-		xe_gt_declare_wedged(gt);
-
-	if (xe_device_wedged(xe)) {
 		/*
 		 * XE_WEDGED_MODE_UPON_ANY_HANG_NO_RESET is intended for debugging
 		 * hangs, so wedge the device with 'none' recovery method and have
@@ -1488,14 +1537,22 @@ void xe_device_declare_wedged(struct xe_device *xe)
 		 */
 		if (xe->wedged.mode == XE_WEDGED_MODE_UPON_ANY_HANG_NO_RESET)
 			xe_device_set_wedged_method(xe, DRM_WEDGE_RECOVERY_NONE);
-		/* If no wedge recovery method is set, use default */
-		else if (!xe->wedged.method)
-			xe_device_set_wedged_method(xe, DRM_WEDGE_RECOVERY_REBIND |
-						    DRM_WEDGE_RECOVERY_BUS_RESET);
 
-		/* Notify userspace of wedged device */
-		drm_dev_wedged_event(&xe->drm, xe->wedged.method, NULL);
+		/* Prepare GTs only on the first wedge declaration. */
+		for_each_gt(gt, xe, id)
+			xe_gt_declare_wedged(gt);
 	}
+
+	/* Set the default only if no recovery method was selected. */
+	cmpxchg(&xe->wedged.method, 0UL,
+		DRM_WEDGE_RECOVERY_REBIND |
+		DRM_WEDGE_RECOVERY_BUS_RESET);
+
+	if (!atomic_read(&xe->wedged.stopping) &&
+	    (first ||
+	     READ_ONCE(xe->wedged.method) !=
+	     READ_ONCE(xe->wedged.reported_method)))
+		queue_work(xe->unordered_wq, &xe->wedged.work);
 }
 
 /**
diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index aa3a98ddb457..ab73dd08b5c6 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -565,6 +565,12 @@ struct xe_device {
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
diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
index 49417620dad3..aa948581576e 100644
--- a/drivers/gpu/drm/xe/xe_guc_submit.c
+++ b/drivers/gpu/drm/xe/xe_guc_submit.c
@@ -2185,6 +2185,12 @@ static int guc_exec_queue_init(struct xe_exec_queue *q)
 	q->entity = &ge->entity;
 
 	mutex_lock(&guc->submission_state.lock);
+	if (xe_device_wedged(guc_to_xe(guc))) {
+		mutex_unlock(&guc->submission_state.lock);
+		err = -ECANCELED;
+		goto err_entity;
+	}
+
 	if (xe_guc_read_stopped(guc) || vf_recovery(guc))
 		xe_sched_stop(sched);
 	publish_guc_id(guc, q);
@@ -2212,6 +2218,9 @@ static int guc_exec_queue_init(struct xe_exec_queue *q)
 
 	return 0;
 
+err_entity:
+	q->entity = NULL;
+	xe_sched_entity_fini(&ge->entity);
 err_sched:
 	xe_sched_fini(&ge->sched);
 err_release_id:
-- 
2.43.0

