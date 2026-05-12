Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 195C5CD4F21
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 19:20:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8193E10EC00;
	Tue, 12 May 2026 19:20:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="EO/HyWHp";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 890E310EC00;
 Tue, 12 May 2026 19:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778613639; x=1810149639;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rlohRXGNCTcR+Ehy5LuCXsrgQ99ZDmhXhXa5dYsoOXc=;
 b=EO/HyWHpQoERIiPoi2ybwCOhWNcoMP3A98xBO8mq96V7BogV0O7PizyQ
 yguQ8ke7Cr5ZTaaUTkf8nRYzyhXI5NEnlKIy6wRtQmTtAh+XorO25Bq+t
 3nhk/ms3TQ5xrudq4wnSskLAzbWqPaC2R1r9dRM5Ko30bKbLUENbQzg6t
 bw009IW9IF+UTIDLpsskexJ4ud+QONvs/BZ39Qq6+po1+57OK8PWKw8Xt
 Vqpu3Dy2N66NgzK5eyHjviJrOnoAgaIjLRszdTpxt7+MQPEK/1NCJQF34
 k9n/+ji0Ngovto4QvFDoH1cftAsxb7x3MV2Sbd1zGp/BULvk+4zMcEJZB g==;
X-CSE-ConnectionGUID: 0lKx7M0PTMy4elsPmp8gRA==
X-CSE-MsgGUID: 3fnCfLxqQ5uy0mw3CK//dw==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="83406477"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; d="scan'208";a="83406477"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2026 12:20:36 -0700
X-CSE-ConnectionGUID: k6AqtWQQQSq68DYn34r+5A==
X-CSE-MsgGUID: p5ucdyk8Q2WQMIK4zFHJZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; d="scan'208";a="237781606"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by orviesa008.jf.intel.com with ESMTP; 12 May 2026 12:20:31 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org
Cc: simona.vetter@ffwll.ch, airlied@gmail.com, kuba@kernel.org,
 lijo.lazar@amd.com, Hawking.Zhang@amd.com, davem@davemloft.net,
 pabeni@redhat.com, edumazet@google.com, maarten@lankhorst.se,
 zachary.mckevitt@oss.qualcomm.com, rodrigo.vivi@intel.com,
 riana.tauro@intel.com, michal.wajdeczko@intel.com,
 matthew.d.roper@intel.com, umesh.nerlige.ramappa@intel.com,
 mallesh.koujalagi@intel.com, anoop.c.vijay@intel.com,
 aravind.iddamsetty@linux.intel.com, Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v2 8/9] drm/xe/xe_ras: Move xe drm_ras registration
Date: Wed, 13 May 2026 00:46:09 +0530
Message-ID: <20260512191610.1817578-9-raag.jadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512191610.1817578-1-raag.jadav@intel.com>
References: <20260512191610.1817578-1-raag.jadav@intel.com>
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

From: Riana Tauro <riana.tauro@intel.com>

gove xe drm_ras registration to RAS initialization flow and keep
gardware error initialization for processing errors reported
via irq.

Also reorder soc remapper and system controller initialization to
early probe as ras init is dependent on both.

Cc: Anoop Vijay <anoop.c.vijay@intel.com>
Cc: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
Signed-off-by: Riana Tauro <riana.tauro@intel.com>
---
 drivers/gpu/drm/xe/xe_device.c   | 19 +++++++++++--------
 drivers/gpu/drm/xe/xe_hw_error.c | 13 -------------
 drivers/gpu/drm/xe/xe_ras.c      | 20 ++++++++++++++++++++
 drivers/gpu/drm/xe/xe_ras.h      |  1 +
 4 files changed, 32 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index 65f107ba1410..402504971e3d 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -63,6 +63,7 @@
 #include "xe_psmi.h"
 #include "xe_pxp.h"
 #include "xe_query.h"
+#include "xe_ras.h"
 #include "xe_shrinker.h"
 #include "xe_soc_remapper.h"
 #include "xe_survivability_mode.h"
@@ -964,6 +965,16 @@ int xe_device_probe(struct xe_device *xe)
 	if (err)
 		return err;
 
+	err = xe_soc_remapper_init(xe);
+	if (err)
+		return err;
+
+	err = xe_sysctrl_init(xe);
+	if (err)
+		return err;
+
+	xe_ras_init(xe);
+
 	/*
 	 * Now that GT is initialized (TTM in particular),
 	 * we can try to init display, and inherit the initial fb.
@@ -1004,10 +1015,6 @@ int xe_device_probe(struct xe_device *xe)
 
 	xe_nvm_init(xe);
 
-	err = xe_soc_remapper_init(xe);
-	if (err)
-		return err;
-
 	err = xe_heci_gsc_init(xe);
 	if (err)
 		return err;
@@ -1046,10 +1053,6 @@ int xe_device_probe(struct xe_device *xe)
 	if (err)
 		goto err_unregister_display;
 
-	err = xe_sysctrl_init(xe);
-	if (err)
-		goto err_unregister_display;
-
 	err = xe_device_sysfs_init(xe);
 	if (err)
 		goto err_unregister_display;
diff --git a/drivers/gpu/drm/xe/xe_hw_error.c b/drivers/gpu/drm/xe/xe_hw_error.c
index 5135e8e4093f..e0ae6fee2c0e 100644
--- a/drivers/gpu/drm/xe/xe_hw_error.c
+++ b/drivers/gpu/drm/xe/xe_hw_error.c
@@ -516,14 +516,6 @@ void xe_hw_error_irq_handler(struct xe_tile *tile, const u32 master_ctl)
 	}
 }
 
-static int hw_error_info_init(struct xe_device *xe)
-{
-	if (xe->info.platform != XE_PVC)
-		return 0;
-
-	return xe_drm_ras_init(xe);
-}
-
 /*
  * Process hardware errors during boot
  */
@@ -550,16 +542,11 @@ static void process_hw_errors(struct xe_device *xe)
 void xe_hw_error_init(struct xe_device *xe)
 {
 	struct xe_tile *tile = xe_device_get_root_tile(xe);
-	int ret;
 
 	if (!IS_DGFX(xe) || IS_SRIOV_VF(xe))
 		return;
 
 	INIT_WORK(&tile->csc_hw_error_work, csc_hw_error_work);
 
-	ret = hw_error_info_init(xe);
-	if (ret)
-		drm_err(&xe->drm, "Failed to initialize XE DRM RAS (%pe)\n", ERR_PTR(ret));
-
 	process_hw_errors(xe);
 }
diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
index 4548e5cb08b9..57ee0ed0d46c 100644
--- a/drivers/gpu/drm/xe/xe_ras.c
+++ b/drivers/gpu/drm/xe/xe_ras.c
@@ -4,6 +4,7 @@
  */
 
 #include "xe_device.h"
+#include "xe_drm_ras.h"
 #include "xe_pm.h"
 #include "xe_printk.h"
 #include "xe_ras.h"
@@ -221,3 +222,22 @@ int xe_ras_set_threshold(struct xe_device *xe, u32 severity, u32 component, u32
 	       comp_to_str(counter.common.component), sev_to_str(counter.common.severity));
 	return 0;
 }
+
+/**
+ * xe_ras_init - Initialize Xe RAS
+ * @xe: xe device instance
+ *
+ * Initialize Xe RAS
+ */
+void xe_ras_init(struct xe_device *xe)
+{
+	int ret;
+
+	if (xe->info.platform != XE_PVC)
+		return;
+
+	ret = xe_drm_ras_init(xe);
+	if (ret)
+		drm_err(&xe->drm, "Failed to initialize xe_drm_ras %d\n", ret);
+}
+
diff --git a/drivers/gpu/drm/xe/xe_ras.h b/drivers/gpu/drm/xe/xe_ras.h
index d1f71b1de723..b6bc50863fa6 100644
--- a/drivers/gpu/drm/xe/xe_ras.h
+++ b/drivers/gpu/drm/xe/xe_ras.h
@@ -11,6 +11,7 @@
 struct xe_device;
 struct xe_sysctrl_event_response;
 
+void xe_ras_init(struct xe_device *xe);
 void xe_ras_counter_threshold_crossed(struct xe_device *xe,
 				      struct xe_sysctrl_event_response *response);
 int xe_ras_get_threshold(struct xe_device *xe, u32 severity, u32 component, u32 *threshold);
-- 
2.43.0

