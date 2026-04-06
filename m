Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98677F46C45
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 14:26:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02B1C10E25B;
	Mon,  6 Apr 2026 14:26:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="KsUxrAGD";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D29D10E258;
 Mon,  6 Apr 2026 14:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775485568; x=1807021568;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=t0kY1LjAPE6hicXORQEnqJ6niHhZMl9Z9DIvjdRiNCo=;
 b=KsUxrAGDCeB1RIAFSERO/hVZ+sivZkkA5dviHvnp2zgWJKKcuYlXu7id
 QvnTGkcoal2lBESJsoe6RV8ygZ3HQkWlArur0mvjTNDXH+ezPHOxKnwxe
 yUWwzGEA6NESh+TgGXnrTNT+jnAlZGT4erJ3DTX2k2h65YGMwp4seDa9n
 2qaTdFfGaborIplnd3icv6FHEFfjbWDDIgCrKpFoaWLdaSHfFSAxW5JRK
 1HRjD0khEpvmTft16VBiVxYp93TxX6qnS6ZniaiOhCE94mUExJiJjAys8
 G/oXkM1QnVWMdaid0d7FhDAKOEtZf+zrCGWCMKA3wV+6YbfovZOZD1vjP w==;
X-CSE-ConnectionGUID: iQeucom9SySgxMA+j/tpUA==
X-CSE-MsgGUID: 4qQ95N5DTT6GFhuxfdeg7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11750"; a="75603931"
X-IronPort-AV: E=Sophos;i="6.23,163,1770624000"; d="scan'208";a="75603931"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Apr 2026 07:26:08 -0700
X-CSE-ConnectionGUID: +qxAz/l9SEKrjfAdknjj6Q==
X-CSE-MsgGUID: Z8gNnCCcQUKUdnXe8ds3wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,163,1770624000"; d="scan'208";a="221309249"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by fmviesa009.fm.intel.com with ESMTP; 06 Apr 2026 07:26:04 -0700
From: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rodrigo.vivi@intel.com
Cc: andrealmeid@igalia.com, christian.koenig@amd.com, airlied@gmail.com,
 simona.vetter@ffwll.ch, mripard@kernel.org, anshuman.gupta@intel.com,
 badal.nilawar@intel.com, riana.tauro@intel.com, karthik.poosa@intel.com,
 sk.anirban@intel.com, raag.jadav@intel.com,
 Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Subject: [PATCH v3 4/4] drm/xe: Handle PUNIT errors by requesting cold-reset
 recovery
Date: Mon,  6 Apr 2026 19:53:30 +0530
Message-ID: <20260406142325.157035-10-mallesh.koujalagi@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260406142325.157035-6-mallesh.koujalagi@intel.com>
References: <20260406142325.157035-6-mallesh.koujalagi@intel.com>
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
and notify userspace that a complete device cold reset is required to
restore normal operation.

v3:
- Use PUNIT instead of PMU. (Riana)
- Use consistent wordingi.
- Remove log. (Raag)

Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
---
 drivers/gpu/drm/xe/xe_ras.c | 21 ++++++++++++++++++++-
 drivers/gpu/drm/xe/xe_ras.h |  1 +
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
index 437811845c01..e2e1ab3fb4ce 100644
--- a/drivers/gpu/drm/xe/xe_ras.c
+++ b/drivers/gpu/drm/xe/xe_ras.c
@@ -5,6 +5,7 @@
 
 #include "xe_assert.h"
 #include "xe_device_types.h"
+#include "xe_device.h"
 #include "xe_printk.h"
 #include "xe_ras.h"
 #include "xe_ras_types.h"
@@ -93,6 +94,24 @@ static enum xe_ras_recovery_action handle_compute_errors(struct xe_device *xe,
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
+void xe_punit_error_handler(struct xe_device *xe)
+{
+	xe_err(xe, "Recovery: Device cold reset required\n");
+
+	xe_device_set_wedged_method(xe, DRM_WEDGE_RECOVERY_COLD_RESET);
+	xe_device_declare_wedged(xe);
+}
+
 static enum xe_ras_recovery_action handle_soc_internal_errors(struct xe_device *xe,
 							      struct xe_ras_error_array *arr)
 {
@@ -132,7 +151,7 @@ static enum xe_ras_recovery_action handle_soc_internal_errors(struct xe_device *
 			xe_err(xe, "[RAS]: PUNIT %s error detected: 0x%x\n",
 			       severity_to_str(xe, common.severity),
 			       ieh_error->global_error_status);
-			/** TODO: Add PUNIT error handling */
+			xe_punit_error_handler(xe);
 			return XE_RAS_RECOVERY_ACTION_DISCONNECT;
 		}
 	}
diff --git a/drivers/gpu/drm/xe/xe_ras.h b/drivers/gpu/drm/xe/xe_ras.h
index e191ab80080c..ab1fde200625 100644
--- a/drivers/gpu/drm/xe/xe_ras.h
+++ b/drivers/gpu/drm/xe/xe_ras.h
@@ -11,6 +11,7 @@
 struct xe_device;
 
 void xe_ras_init(struct xe_device *xe);
+void xe_punit_error_handler(struct xe_device *xe);
 enum xe_ras_recovery_action  xe_ras_process_errors(struct xe_device *xe);
 
 #endif
-- 
2.34.1

