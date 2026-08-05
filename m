Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2516FC56201
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 07:12:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A93B10ED38;
	Wed,  5 Aug 2026 07:12:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="JUP2Lt49";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6E7F10ED29;
 Wed,  5 Aug 2026 07:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785913940; x=1817449940;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=q1gFeNDq84BdsoAleZRni7R2ADJJ+s/Qb/6cYOf7tMA=;
 b=JUP2Lt49RKu7iWI7jHzVYnV8vIgw8nyCWnUQtCV6WWc9wWzkL7XisZom
 UEgwCcVZ5anre1aF4BpoExwcG+Mng5P58PxUN6490lovkY121srbi3d7n
 efJIDEzuVT9TlgmNEGbNzk7xemPO/qNl74n4jYAHFqYvL14AEqVuJ4G+W
 oHL7+Seo2SHkGAGzjnDify5vLUwZRryA4DKC06uZKqddzoCaUldIJNSZw
 El5kBISk13tcUxgQB/ra0Vlk+WorGiUr1LlukzskZkB5sCALW1gxgigYj
 9/Ay/s0IV6rgTZHsDNCOFZ263QJ7HF8CMH1aRgjzM4vY5e7cX4sYCtV4N Q==;
X-CSE-ConnectionGUID: H7HvlpapSvSFT4JT//yRyQ==
X-CSE-MsgGUID: YMDmvWfKS5Oh5bNDZK3L9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="89003247"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; d="scan'208";a="89003247"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 00:12:19 -0700
X-CSE-ConnectionGUID: Wnl6cXlyTH2HFIbgp69CRg==
X-CSE-MsgGUID: h0Pf+QXNQPO+eIpnNaC/pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; d="scan'208";a="260460969"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by orviesa010.jf.intel.com with ESMTP; 05 Aug 2026 00:12:15 -0700
From: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rodrigo.vivi@intel.com
Cc: andrealmeid@igalia.com, christian.koenig@amd.com, airlied@gmail.com,
 simona.vetter@ffwll.ch, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 anshuman.gupta@intel.com, badal.nilawar@intel.com, riana.tauro@intel.com,
 karthik.poosa@intel.com, sk.anirban@intel.com, raag.jadav@intel.com,
 Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Subject: [PATCH v13 4/4] drm/xe/ras: Use fault-inject to trigger cold-reset
 wedge
Date: Wed,  5 Aug 2026 12:41:57 +0530
Message-ID: <20260805071152.1225416-10-mallesh.koujalagi@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805071152.1225416-6-mallesh.koujalagi@intel.com>
References: <20260805071152.1225416-6-mallesh.koujalagi@intel.com>
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

Use the fault-inject framework to trigger the cold-reset
wedge path (punit_error_handler()) for testing the
wedge/recovery flow.

Usage:
  echo 100 > .../wedge_cold_reset/probability
  echo 1   > .../wedge_cold_reset/times

Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
---
v13:
- Rename inject_punit_error to wedge_cold_reset. (Riana)
- Sashiko corner case issue addressed with
  commit 20bc4883c7c0 ("drm/xe/ras: Fix boot-time ras error processing").
---
 drivers/gpu/drm/xe/xe_debugfs.c | 4 ++++
 drivers/gpu/drm/xe/xe_debugfs.h | 2 ++
 drivers/gpu/drm/xe/xe_ras.c     | 7 +++++++
 3 files changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_debugfs.c b/drivers/gpu/drm/xe/xe_debugfs.c
index 8de78cd0aa03..acd34cc5dcbd 100644
--- a/drivers/gpu/drm/xe/xe_debugfs.c
+++ b/drivers/gpu/drm/xe/xe_debugfs.c
@@ -42,6 +42,7 @@
 
 DECLARE_FAULT_ATTR(gt_reset_failure);
 DECLARE_FAULT_ATTR(inject_csc_hw_error);
+DECLARE_FAULT_ATTR(wedge_cold_reset);
 
 static bool csc_hw_error_available(struct xe_device *xe)
 {
@@ -62,6 +63,8 @@ static struct {
 	{ .name = "inject_csc_hw_error",
 	  .attr = &inject_csc_hw_error,
 	  .is_visible = csc_hw_error_available },
+	{ .name = "wedge_cold_reset",
+	  .attr = &wedge_cold_reset },
 };
 
 /*
@@ -76,6 +79,7 @@ bool xe_fault_##name(void)				\
 
 FAULT_ACTION(gt_reset, gt_reset_failure)
 FAULT_ACTION(csc_hw_error, inject_csc_hw_error)
+FAULT_ACTION(wedge_cold_reset, wedge_cold_reset)
 
 static void xe_fault_inject_debugfs_register(struct xe_device *xe,
 					     struct dentry *root)
diff --git a/drivers/gpu/drm/xe/xe_debugfs.h b/drivers/gpu/drm/xe/xe_debugfs.h
index cd56f7442b99..0dcd28fd7dc0 100644
--- a/drivers/gpu/drm/xe/xe_debugfs.h
+++ b/drivers/gpu/drm/xe/xe_debugfs.h
@@ -13,10 +13,12 @@ struct xe_device;
 #ifdef CONFIG_DEBUG_FS
 bool xe_fault_gt_reset(void);
 bool xe_fault_csc_hw_error(void);
+bool xe_fault_wedge_cold_reset(void);
 void xe_debugfs_register(struct xe_device *xe);
 #else
 static inline bool xe_fault_gt_reset(void) { return false; }
 static inline bool xe_fault_csc_hw_error(void) { return false; }
+static inline bool xe_fault_wedge_cold_reset(void) { return false; }
 static inline void xe_debugfs_register(struct xe_device *xe) { }
 #endif
 
diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
index 3033a377bace..7cd17f4b444a 100644
--- a/drivers/gpu/drm/xe/xe_ras.c
+++ b/drivers/gpu/drm/xe/xe_ras.c
@@ -3,6 +3,7 @@
  * Copyright © 2026 Intel Corporation
  */
 
+#include "xe_debugfs.h"
 #include "xe_device.h"
 #include "xe_drm_ras.h"
 #include "xe_pm.h"
@@ -415,6 +416,12 @@ enum xe_ras_recovery_action xe_ras_process_errors(struct xe_device *xe)
 	size_t rlen;
 	int ret;
 
+	if (xe_fault_wedge_cold_reset()) {
+		xe_err(xe, "[RAS]: cold-reset wedge injected\n");
+		punit_error_handler(xe);
+		return XE_RAS_RECOVERY_ACTION_DISCONNECT;
+	}
+
 	if (!xe->info.has_sysctrl)
 		return XE_RAS_RECOVERY_ACTION_RESET;
 
-- 
2.48.1

