Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73387FCD0C1
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 06:43:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5F6310E2D7;
	Wed, 18 Mar 2026 06:43:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Oapo7Rng";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 000E910E0AE;
 Wed, 18 Mar 2026 06:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773816197; x=1805352197;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CAjF+NZoz1/ahF6zv2eidZGNRhes5wl1FLa8e/Uer4A=;
 b=Oapo7RngGTl0LiAlfbThpK12ceNDQmhktno/mhbTPkJh4SxkO+tSnwkF
 Qsjo8mIoCjxhcGGjyF6jEwcD2HEFdTDADMOIwnDyspYDvkEANw3peTrnq
 oLKuUCgeaUGIxTILbaLzgQZokDdRuJry/7YBOAd89yuwxRGVVC1rPVuAO
 rREd4pPQUa+1uQLvdwR1wN6R3+igfburYyD5SIWlA9Y4qHTWrzB8tnYQv
 3oMys9kHMvYBeLPaL70huFZ/4ROgeMimvDyq1mF0IMzZq8HFxiEPuy7FZ
 kzOLml7zJDc1OfHYjRbEWuEaBg2S9JSjLLhLA/XrUDrSVS/iGLLgguUAG g==;
X-CSE-ConnectionGUID: 7vdsIGTKT2q5uwuocB0EWg==
X-CSE-MsgGUID: CzyBM5kgS0i1hvpy948boQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="78723361"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; d="scan'208";a="78723361"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2026 23:43:17 -0700
X-CSE-ConnectionGUID: vJ5sGgniRcGPWxOSvo/hcQ==
X-CSE-MsgGUID: 9Vxkzi2MQhq7FXGWP9Jg7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; d="scan'208";a="227464657"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by orviesa005.jf.intel.com with ESMTP; 17 Mar 2026 23:43:12 -0700
From: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rodrigo.vivi@intel.com
Cc: andrealmeid@igalia.com, christian.koenig@amd.com, airlied@gmail.com,
 simona.vetter@ffwll.ch, mripard@kernel.org, anshuman.gupta@intel.com,
 badal.nilawar@intel.com, riana.tauro@intel.com, karthik.poosa@intel.com,
 sk.anirban@intel.com, raag.jadav@intel.com,
 Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Subject: [PATCH v2 4/5] drm/xe: Add handler for power management unit errors
 which require cold-reset
Date: Wed, 18 Mar 2026 12:10:21 +0530
Message-ID: <20260318064016.374656-11-mallesh.koujalagi@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318064016.374656-7-mallesh.koujalagi@intel.com>
References: <20260318064016.374656-7-mallesh.koujalagi@intel.com>
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

This handler is designed to be called when power management unit errors are
detected that affect device-level state persisting across warm resets. The
cold reset recovery method signals to userspace that only a complete device
power cycle can restore normal operation.

v2:
- Add use case: Handling errors from power management unit,
  which requires a complete power cycle (cold reset)
  to recover. (Christian)

Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
---
 drivers/gpu/drm/xe/xe_hw_error.c | 27 +++++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_hw_error.h |  1 +
 drivers/gpu/drm/xe/xe_ras.c      |  3 ++-
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_hw_error.c b/drivers/gpu/drm/xe/xe_hw_error.c
index 2a31b430570e..ca965a2b092c 100644
--- a/drivers/gpu/drm/xe/xe_hw_error.c
+++ b/drivers/gpu/drm/xe/xe_hw_error.c
@@ -5,6 +5,7 @@
 
 #include <linux/bitmap.h>
 #include <linux/fault-inject.h>
+#include <drm/drm_drv.h>
 
 #include "regs/xe_gsc_regs.h"
 #include "regs/xe_hw_error_regs.h"
@@ -542,6 +543,32 @@ static void process_hw_errors(struct xe_device *xe)
 	}
 }
 
+/**
+ * xe_punit_error_handler - Handler for power management unit errors
+ * @xe: device instance
+ *
+ * Handles power management unit errors that affect the device and cannot
+ * be recovered through driver reload, PCIe reset, etc.
+ *
+ * Marks the device as wedged with DRM_WEDGE_RECOVERY_COLD_RESET method
+ * and notifies userspace that a complete device power cycle is required.
+ */
+void xe_punit_error_handler(struct xe_device *xe)
+{
+	drm_err(&xe->drm, "CRITICAL: PMU error detected\n");
+	drm_err(&xe->drm, "Recovery: Device cold reset required\n");
+
+	/* Set cold reset recovery method */
+	xe_device_set_wedged_method(xe, DRM_WEDGE_RECOVERY_COLD_RESET);
+
+	if (xe_device_wedged(xe)) {
+		drm_dev_wedged_event(&xe->drm, xe->wedged.method, NULL);
+	} else {
+		/* Declare device wedged - will trigger uevent with cold reset method */
+		xe_device_declare_wedged(xe);
+	}
+}
+
 /**
  * xe_hw_error_init - Initialize hw errors
  * @xe: xe device instance
diff --git a/drivers/gpu/drm/xe/xe_hw_error.h b/drivers/gpu/drm/xe/xe_hw_error.h
index d86e28c5180c..f588320eb94d 100644
--- a/drivers/gpu/drm/xe/xe_hw_error.h
+++ b/drivers/gpu/drm/xe/xe_hw_error.h
@@ -11,5 +11,6 @@ struct xe_tile;
 struct xe_device;
 
 void xe_hw_error_irq_handler(struct xe_tile *tile, const u32 master_ctl);
+void xe_punit_error_handler(struct xe_device *xe);
 void xe_hw_error_init(struct xe_device *xe);
 #endif
diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
index 777321021391..93257d0eaaa0 100644
--- a/drivers/gpu/drm/xe/xe_ras.c
+++ b/drivers/gpu/drm/xe/xe_ras.c
@@ -10,6 +10,7 @@
 #include "xe_survivability_mode.h"
 #include "xe_sysctrl_mailbox.h"
 #include "xe_sysctrl_mailbox_types.h"
+#include "xe_hw_error.h"
 
 #define COMPUTE_ERROR_SEVERITY_MASK		GENMASK(26, 25)
 #define GLOBAL_UNCORR_ERROR			2
@@ -148,7 +149,7 @@ static enum xe_ras_recovery_action handle_soc_internal_errors(struct xe_device *
 			xe_err(xe, "[RAS]: PUNIT %s error detected: 0x%x\n",
 			       severity_to_str(xe, common_info.severity),
 			       ieh_error->error_sources_ieh0.punit);
-			/** TODO: Add PUNIT error handling */
+			xe_punit_error_handler(xe);
 			action = XE_RAS_RECOVERY_ACTION_DISCONNECT;
 		}
 	}
-- 
2.34.1

