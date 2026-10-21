Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C735606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 10:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IfCFOFUn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63BE410FD2D;
	Wed, 21 Oct 2026 10:04:01 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FB7D10F9CB;
 Wed, 21 Oct 2026 10:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792577030; x=1824113030;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nNYnK9TmWe3eKF2G4m+/PHYfaQo4qfggQ3+lVROfb8U=;
 b=IfCFOFUnub/A2v7X5LebQcSDTO2y9KU0Ki0qa6h38X2AFrf52EwBzixN
 rBlArn24a8w2JxNIxq0+JQXCz4GXrdzZ/qgi/+CG4AYEEmFmvHc10HFAD
 9oKsBmWOuaq+PZLbS8vWk6hL/EWBFSZDLbIr5vMtcwYWVUbbMn871JZJQ
 RgbGASMPyPnoRDfWVASZuC9nh8ubpX4d7UZVRFjgIUFnPQGoJI+JGM5kK
 vv5hjClMtyZK6kPROYGRCw1bIAargW5N2n+Pkna22goSiW7kwYMlRbDEe
 ICzAYCO2ssJT1p74dvCRSmZsyupfAV54UY5mGxQforT90lhg1EBlVQH2Z g==;
X-CSE-ConnectionGUID: qgnl3BI8ThGEKTL2hJaLjQ==
X-CSE-MsgGUID: PSkUQNtXQuGN9IvRABdCww==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1290273"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1290273"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 03:03:49 -0700
X-CSE-ConnectionGUID: /iBdf7wDRmy38j9PT0n5Sw==
X-CSE-MsgGUID: WyXoyxwKQNq948M1fWu57A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="3382065"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 03:03:47 -0700
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: matthew.brost@intel.com, himal.prasad.ghimiray@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com
Subject: [RFC v3 04/17] drm/xe: Keep software waits outside the device I/O gate
Date: Wed, 21 Oct 2026 15:33:05 +0530
Message-ID: <20261021100322.1014449-5-arvind.yadav@intel.com>
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

xe_drm_ioctl() holds the device I/O gate across the whole ioctl.
Software waits can wait for a fence that userspace has not submitted.
Signalling GT fences cannot end these waits, so device I/O draining
can hang during reset or wedge isolation.

Release the outer gate before syncobj waits, syncobj transfers and
Xe user-fence waits. Protect each Xe user-fence memory read with the
gate, but release it before sleeping.

Wake Xe user-fence waiters when PCI recovery starts, the device wedges
or the device is unplugged, so they can observe the blocked state.

Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Assisted-by: LLM
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
---
 drivers/gpu/drm/xe/xe_device.c          | 28 +++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_pci_error.c       |  1 +
 drivers/gpu/drm/xe/xe_wait_user_fence.c | 12 ++++++++---
 3 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index 807cb0e98314..9112462bda6d 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -232,6 +232,19 @@ static const struct drm_ioctl_desc xe_ioctls[] = {
 			  DRM_RENDER_ALLOW),
 };
 
+static bool xe_drm_ioctl_is_wait(unsigned int cmd)
+{
+	switch (DRM_IOCTL_NR(cmd)) {
+	case DRM_IOCTL_NR(DRM_IOCTL_SYNCOBJ_WAIT):
+	case DRM_IOCTL_NR(DRM_IOCTL_SYNCOBJ_TIMELINE_WAIT):
+	case DRM_IOCTL_NR(DRM_IOCTL_SYNCOBJ_TRANSFER):
+	case DRM_IOCTL_NR(DRM_IOCTL_XE_WAIT_USER_FENCE):
+		return true;
+	default:
+		return false;
+	}
+}
+
 static long xe_drm_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct drm_file *file_priv = file->private_data;
@@ -243,6 +256,12 @@ static long xe_drm_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	if (ret)
 		return ret;
 
+	/* These waits must not hold up device I/O draining. */
+	if (xe_drm_ioctl_is_wait(cmd)) {
+		xe_device_io_put(io_idx);
+		return drm_ioctl(file, cmd, arg);
+	}
+
 	scoped_cond_guard(xe_pm_runtime_ioctl,
 			  ret = ACQUIRE_ERR(xe_pm_runtime_ioctl, &scope),
 			  xe) {
@@ -265,6 +284,12 @@ static long xe_drm_compat_ioctl(struct file *file, unsigned int cmd, unsigned lo
 	if (ret)
 		return ret;
 
+	/* These waits must not hold up device I/O draining. */
+	if (xe_drm_ioctl_is_wait(cmd)) {
+		xe_device_io_put(io_idx);
+		return drm_compat_ioctl(file, cmd, arg);
+	}
+
 	scoped_cond_guard(xe_pm_runtime_ioctl,
 			  ret = ACQUIRE_ERR(xe_pm_runtime_ioctl, &scope),
 			  xe) {
@@ -1142,6 +1167,8 @@ void xe_device_remove(struct xe_device *xe)
 
 	drm_dev_unplug(&xe->drm);
 
+	wake_up_all(&xe->ufence_wq);
+
 	xe_bo_pci_dev_remove_all(xe);
 }
 
@@ -1441,6 +1468,7 @@ void xe_device_declare_wedged(struct xe_device *xe)
 	if (!atomic_xchg(&xe->wedged.flag, 1)) {
 		xe->needs_flr_on_fini = true;
 		xe_pm_runtime_get_noresume(xe);
+		wake_up_all(&xe->ufence_wq);
 
 		xe_log_err_fatal(xe, WEDGED, -EIO, "Device declared wedged!\n");
 		xe_err_once(xe, "IOCTLs and executions are now blocked!\n"
diff --git a/drivers/gpu/drm/xe/xe_pci_error.c b/drivers/gpu/drm/xe/xe_pci_error.c
index 3e06f504f1b3..3dfcef03850e 100644
--- a/drivers/gpu/drm/xe/xe_pci_error.c
+++ b/drivers/gpu/drm/xe/xe_pci_error.c
@@ -21,6 +21,7 @@ static void prepare_device_for_reset(struct pci_dev *pdev)
 
 	/* Block device access until PCI error recovery completes. */
 	xe_device_set_in_reset(xe);
+	wake_up_all(&xe->ufence_wq);
 
 	for_each_gt(gt, xe, id)
 		xe_gt_declare_wedged(gt);
diff --git a/drivers/gpu/drm/xe/xe_wait_user_fence.c b/drivers/gpu/drm/xe/xe_wait_user_fence.c
index e241f3ec3547..b5239c002368 100644
--- a/drivers/gpu/drm/xe/xe_wait_user_fence.c
+++ b/drivers/gpu/drm/xe/xe_wait_user_fence.c
@@ -14,13 +14,19 @@
 #include "xe_macros.h"
 #include "xe_exec_queue.h"
 
-static int do_compare(u64 addr, u64 value, u64 mask, u16 op)
+static int do_compare(struct xe_device *xe, u64 addr, u64 value, u64 mask, u16 op)
 {
 	u64 rvalue;
+	int io_idx;
 	int err;
 	bool passed;
 
+	err = xe_device_io_get(xe, &io_idx);
+	if (err)
+		return err;
+
 	err = copy_from_user(&rvalue, u64_to_user_ptr(addr), sizeof(rvalue));
+	xe_device_io_put(io_idx);
 	if (err)
 		return -EFAULT;
 
@@ -136,7 +142,7 @@ int xe_wait_user_fence_ioctl(struct drm_device *dev, void *data,
 
 	add_wait_queue(&xe->ufence_wq, &w_wait);
 	for (;;) {
-		err = do_compare(addr, args->value, args->mask, args->op);
+		err = do_compare(xe, addr, args->value, args->mask, args->op);
 		if (err <= 0)
 			break;
 
@@ -155,7 +161,7 @@ int xe_wait_user_fence_ioctl(struct drm_device *dev, void *data,
 
 		if (!timeout) {
 			LNL_FLUSH_WORKQUEUE(xe->ordered_wq);
-			err = do_compare(addr, args->value, args->mask,
+			err = do_compare(xe, addr, args->value, args->mask,
 					 args->op);
 			if (err <= 0) {
 				drm_dbg(&xe->drm, "LNL_FLUSH_WORKQUEUE resolved ufence timeout\n");
-- 
2.43.0

