Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF947C531C9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 10:07:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B4A310F345;
	Fri, 24 Jul 2026 10:07:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="StPBMpeo";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF20410F345;
 Fri, 24 Jul 2026 10:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784887649; x=1816423649;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uZCz9VJqNxvd4EAqe1G4WGRgqlvZd6LuTmOA0y17K3E=;
 b=StPBMpeoI7wxtLsYA1s0pumbeVmHZVwwK15iMPxe4E8t8akSjXxBB16h
 k93Hfjxt2NBG0+KvsWxAAEBr5yNjPr1rKG5PPnLIcF9x9EiTaxZ8ZfRFW
 FgvXBIr5NNS9AkvXB/LyZ3yTZ4zBR3q112ZN+8OkdDbWiJb/Zqt7rmZwb
 YgraF9eau03pnYPnAsNfsqf3eWUuWeLYx59Z4BnrRYRPh9eGNYJfvBUhE
 0S/muktckUA3RYutfPSKewADoAN9uX9dvu92Ocw6hZFIGLxG/tMJZX5Nh
 ykqGLB3YTsfUeti2RY0fc/mVRwty0EWUXWJ69rQrUzlGbMYDbobTtJJLn A==;
X-CSE-ConnectionGUID: sJRgIYKUTOuhQfNUefdo/w==
X-CSE-MsgGUID: ret5q7z3S26/FD42ulTLaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="85669020"
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; d="scan'208";a="85669020"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jul 2026 03:07:28 -0700
X-CSE-ConnectionGUID: 92f2XnccStK2Mxjv4Fpd0A==
X-CSE-MsgGUID: XqRiuTHITfOAuhsd4Lb5Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; d="scan'208";a="262459900"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by orviesa004.jf.intel.com with ESMTP; 24 Jul 2026 03:07:22 -0700
From: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rodrigo.vivi@intel.com
Cc: andrealmeid@igalia.com, christian.koenig@amd.com, airlied@gmail.com,
 simona.vetter@ffwll.ch, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 anshuman.gupta@intel.com, badal.nilawar@intel.com, riana.tauro@intel.com,
 karthik.poosa@intel.com, sk.anirban@intel.com, raag.jadav@intel.com,
 Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Subject: [PATCH v12 4/4] drm/xe/ras: Use fault-inject to trigger punit error
 handler
Date: Fri, 24 Jul 2026 15:33:07 +0530
Message-ID: <20260724100302.706685-10-mallesh.koujalagi@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724100302.706685-6-mallesh.koujalagi@intel.com>
References: <20260724100302.706685-6-mallesh.koujalagi@intel.com>
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

Use fault-inject framework to trigger punit_error_handler()
for testing.

Usage:
  echo 100 > .../inject_punit_error/probability
  echo 1   > .../inject_punit_error/times

Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
---
 drivers/gpu/drm/xe/xe_debugfs.c |  4 ++++
 drivers/gpu/drm/xe/xe_debugfs.h |  2 ++
 drivers/gpu/drm/xe/xe_ras.c     | 17 +++++++++++++++++
 3 files changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_debugfs.c b/drivers/gpu/drm/xe/xe_debugfs.c
index 5a3877fcb0f0..5599d493feca 100644
--- a/drivers/gpu/drm/xe/xe_debugfs.c
+++ b/drivers/gpu/drm/xe/xe_debugfs.c
@@ -42,6 +42,7 @@
 
 DECLARE_FAULT_ATTR(gt_reset_failure);
 DECLARE_FAULT_ATTR(inject_csc_hw_error);
+DECLARE_FAULT_ATTR(inject_punit_error);
 
 static bool csc_hw_error_available(struct xe_device *xe)
 {
@@ -62,6 +63,8 @@ static struct {
 	{ .name = "inject_csc_hw_error",
 	  .attr = &inject_csc_hw_error,
 	  .is_visible = csc_hw_error_available },
+	{ .name = "inject_punit_error",
+	  .attr = &inject_punit_error },
 };
 
 /*
@@ -76,6 +79,7 @@ bool xe_fault_##name(void)				\
 
 FAULT_ACTION(gt_reset, gt_reset_failure)
 FAULT_ACTION(csc_hw_error, inject_csc_hw_error)
+FAULT_ACTION(punit_error, inject_punit_error)
 
 static void xe_fault_inject_debugfs_register(struct xe_device *xe,
 					     struct dentry *root)
diff --git a/drivers/gpu/drm/xe/xe_debugfs.h b/drivers/gpu/drm/xe/xe_debugfs.h
index cd56f7442b99..dd57914dd4f2 100644
--- a/drivers/gpu/drm/xe/xe_debugfs.h
+++ b/drivers/gpu/drm/xe/xe_debugfs.h
@@ -13,10 +13,12 @@ struct xe_device;
 #ifdef CONFIG_DEBUG_FS
 bool xe_fault_gt_reset(void);
 bool xe_fault_csc_hw_error(void);
+bool xe_fault_punit_error(void);
 void xe_debugfs_register(struct xe_device *xe);
 #else
 static inline bool xe_fault_gt_reset(void) { return false; }
 static inline bool xe_fault_csc_hw_error(void) { return false; }
+static inline bool xe_fault_punit_error(void) { return false; }
 static inline void xe_debugfs_register(struct xe_device *xe) { }
 #endif
 
diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
index 92b4181026cb..da06c16cf7ed 100644
--- a/drivers/gpu/drm/xe/xe_ras.c
+++ b/drivers/gpu/drm/xe/xe_ras.c
@@ -3,6 +3,7 @@
  * Copyright © 2026 Intel Corporation
  */
 
+#include "xe_debugfs.h"
 #include "xe_device.h"
 #include "xe_drm_ras.h"
 #include "xe_pm.h"
@@ -391,6 +392,22 @@ enum xe_ras_recovery_action xe_ras_process_errors(struct xe_device *xe)
 	size_t rlen;
 	int ret;
 
+	/*
+	 * Only allow the injected PUNIT error once the DRM device is registered.
+	 * xe_ras_process_errors() also runs during probe (via xe_ras_init()), before
+	 * drm_dev_register() calls device_add() on the DRM minor's kdev. At that
+	 * point kdev->kobj.parent is not yet linked into the sysfs hierarchy, so
+	 * kobject_get_path() returns "/card0" instead of the real sysfs path.
+	 * drm_dev_wedged_event() would then emit a KOBJ_CHANGE uevent with a wrong
+	 * DEVPATH that udev cannot resolve, silently dropping the event and leaving
+	 * the cold-reset recovery broken.
+	 */
+	if (xe->drm.registered && xe_fault_punit_error()) {
+		xe_err(xe, "[RAS]: PUNIT error injected\n");
+		punit_error_handler(xe);
+		return XE_RAS_RECOVERY_ACTION_DISCONNECT;
+	}
+
 	if (!xe->info.has_sysctrl)
 		return XE_RAS_RECOVERY_ACTION_RESET;
 
-- 
2.48.1

