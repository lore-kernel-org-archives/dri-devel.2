Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B2D4F34C53
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 13:33:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A996A10E44F;
	Mon, 13 Apr 2026 13:33:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Kmujp7Fj";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DC5510E458;
 Mon, 13 Apr 2026 13:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776087183; x=1807623183;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=kNwFEj4Y9QsN2EBXPlVIbnvbfSCw/dTDZNq72Nntirw=;
 b=Kmujp7FjsSuhpSUvZfvyVd8z1lUvKtKOOeuhC7D94ZOJPNWsuxON02q+
 2AfEfIvI2F6aQ49bzsTRu3agaFB4KBYchp7EHkGAf615cYM2hVfaPXJeb
 JvI1o7DB3Mn1g6HrMOLD4K3pa84nMsgADiRZS3lL4iq02sJoIt/MmYMS0
 19DnPlgZZLHAVnbpP9798eNPCnxj/65/pVfBtuUgQ6VTgCtSfa1CHk9xK
 1iEt0J8K37sSlWyKMN26ug4Z04dzo7Sc+FnskXTwtcikh3I963nCN2wAn
 klM6c900mVp2MBqVHOO0gR4mmf5IZhCbdGH9ZUOoJ/c9C0zTBySjagqxR Q==;
X-CSE-ConnectionGUID: OptqWjr8Qj+sSyEFhNQmDw==
X-CSE-MsgGUID: pmpfXYG0SsSv/rhf4la7rA==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="94594730"
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; d="scan'208";a="94594730"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Apr 2026 06:33:02 -0700
X-CSE-ConnectionGUID: DSVcHptLTuKU61Yl6YsiEA==
X-CSE-MsgGUID: HJp3Li2nTzGBsw/QcHbtlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; d="scan'208";a="229659746"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by orviesa009.jf.intel.com with ESMTP; 13 Apr 2026 06:32:59 -0700
From: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rodrigo.vivi@intel.com
Cc: andrealmeid@igalia.com, christian.koenig@amd.com, airlied@gmail.com,
 simona.vetter@ffwll.ch, mripard@kernel.org, anshuman.gupta@intel.com,
 badal.nilawar@intel.com, riana.tauro@intel.com, karthik.poosa@intel.com,
 sk.anirban@intel.com, raag.jadav@intel.com,
 Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Subject: [PATCH v4 4/4] drm/xe: Handle PUNIT errors by requesting cold-reset
 recovery
Date: Mon, 13 Apr 2026 19:00:18 +0530
Message-ID: <20260413133013.560239-10-mallesh.koujalagi@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260413133013.560239-6-mallesh.koujalagi@intel.com>
References: <20260413133013.560239-6-mallesh.koujalagi@intel.com>
MIME-Version: 1.0
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

When PUNIT (power management unit) errors are detected that persist across
warm resets, mark the device as wedged with DRM_WEDGE_RECOVERY_COLD_RESET
and notify userspace that a complete device power cycle is required to
restore normal operation.

v3:
- Use PUNIT instead of PMU. (Riana)
- Use consistent wordingi.
- Remove log. (Raag)

v4:
- Make function static. (Raag)

Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
---
 drivers/gpu/drm/xe/xe_ras.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
index 437811845c01..653be0c67864 100644
--- a/drivers/gpu/drm/xe/xe_ras.c
+++ b/drivers/gpu/drm/xe/xe_ras.c
@@ -5,6 +5,7 @@
 
 #include "xe_assert.h"
 #include "xe_device_types.h"
+#include "xe_device.h"
 #include "xe_printk.h"
 #include "xe_ras.h"
 #include "xe_ras_types.h"
@@ -93,6 +94,22 @@ static enum xe_ras_recovery_action handle_compute_errors(struct xe_device *xe,
 	return XE_RAS_RECOVERY_ACTION_RECOVERED;
 }
 
+/**
+ * xe_punit_error_handler - Handler for Punit errors requiring cold reset
+ * @xe: device instance
+ *
+ * Handles Punit errors that affect the device and cannot be recovered
+ * through driver reload, PCIe reset, etc.
+ *
+ * Marks the device as wedged with DRM_WEDGE_RECOVERY_COLD_RESET method
+ * and notifies userspace that a device cold reset is required.
+ */
+static void xe_punit_error_handler(struct xe_device *xe)
+{
+	xe_device_set_wedged_method(xe, DRM_WEDGE_RECOVERY_COLD_RESET);
+	xe_device_declare_wedged(xe);
+}
+
 static enum xe_ras_recovery_action handle_soc_internal_errors(struct xe_device *xe,
 							      struct xe_ras_error_array *arr)
 {
@@ -132,7 +149,7 @@ static enum xe_ras_recovery_action handle_soc_internal_errors(struct xe_device *
 			xe_err(xe, "[RAS]: PUNIT %s error detected: 0x%x\n",
 			       severity_to_str(xe, common.severity),
 			       ieh_error->global_error_status);
-			/** TODO: Add PUNIT error handling */
+			xe_punit_error_handler(xe);
 			return XE_RAS_RECOVERY_ACTION_DISCONNECT;
 		}
 	}
-- 
2.34.1

