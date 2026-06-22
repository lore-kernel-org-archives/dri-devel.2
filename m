Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B63CDB46F
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 13:19:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC53210E6C8;
	Mon, 22 Jun 2026 13:19:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="M4Qb60rE";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58DBE10E6D6;
 Mon, 22 Jun 2026 13:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782134337; x=1813670337;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NvHd+4NPCcPjKND07FEgVqG1lY2RrTGJgZcgBc8T8Sc=;
 b=M4Qb60rEcuHBBuSi1+zBOqyrv/WHVkjLbKvTO558Ue0KA9HuwUZVY1hK
 1/sa9nSrOTfu8a95Peh518LtAW2XJGbfSo8pdKEy1zj58iXDGxki+sLlv
 birck3MJV0MZGbHrBi7n6cIPbL8oCAlxQwJbnYcjb9r0itk79z7A6M5Dn
 k13cUXkUQgbcNDunbrjysCG4u8c4TEH8ET8E0QJXPKtw8zso6MM8lpiec
 B9G1YpGHrGPfSADzW8B6oli+mc/tLI52pHe8mpUZ8BcTAqBpcbuEXtHIm
 DPdu7phxJazUOrSGaESVSwYwMGFTGnKd8pl2Qw9RNavzZXOeZtOkdQvsH Q==;
X-CSE-ConnectionGUID: p5NcZwIaSkKC5y2Psr8Y5g==
X-CSE-MsgGUID: AoQivkXHSM2fFtIaEy5ThQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11824"; a="93458828"
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; d="scan'208";a="93458828"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2026 06:18:57 -0700
X-CSE-ConnectionGUID: xeWooNDqQRmy2/Opf9eKxw==
X-CSE-MsgGUID: RgzTxIRSRGq7SXl849lP5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; d="scan'208";a="245074781"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by fmviesa010.fm.intel.com with ESMTP; 22 Jun 2026 06:18:53 -0700
From: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rodrigo.vivi@intel.com
Cc: andrealmeid@igalia.com, christian.koenig@amd.com, airlied@gmail.com,
 simona.vetter@ffwll.ch, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 anshuman.gupta@intel.com, badal.nilawar@intel.com, riana.tauro@intel.com,
 karthik.poosa@intel.com, sk.anirban@intel.com, raag.jadav@intel.com,
 Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Subject: [PATCH v9 6/6] drm/xe/ras: Use fault-inject to trigger punit error
 handler
Date: Mon, 22 Jun 2026 18:45:05 +0530
Message-ID: <20260622131458.144873-14-mallesh.koujalagi@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260622131458.144873-8-mallesh.koujalagi@intel.com>
References: <20260622131458.144873-8-mallesh.koujalagi@intel.com>
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
 drivers/gpu/drm/xe/xe_debugfs.c |  3 +++
 drivers/gpu/drm/xe/xe_ras.c     | 14 ++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_debugfs.c b/drivers/gpu/drm/xe/xe_debugfs.c
index 22b471303984..3a90deb5596c 100644
--- a/drivers/gpu/drm/xe/xe_debugfs.c
+++ b/drivers/gpu/drm/xe/xe_debugfs.c
@@ -40,6 +40,7 @@
 
 DECLARE_FAULT_ATTR(gt_reset_failure);
 DECLARE_FAULT_ATTR(inject_csc_hw_error);
+DECLARE_FAULT_ATTR(inject_punit_error);
 
 static void read_residency_counter(struct xe_device *xe, struct xe_mmio *mmio,
 				   u32 offset, const char *name, struct drm_printer *p)
@@ -612,6 +613,8 @@ void xe_debugfs_register(struct xe_device *xe)
 
 	fault_create_debugfs_attr("fail_gt_reset", root, &gt_reset_failure);
 
+	fault_create_debugfs_attr("inject_punit_error", root, &inject_punit_error);
+
 	if (IS_SRIOV_PF(xe))
 		xe_sriov_pf_debugfs_register(xe, root);
 	else if (IS_SRIOV_VF(xe))
diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
index 5a2fee5a1308..bb8502472f73 100644
--- a/drivers/gpu/drm/xe/xe_ras.c
+++ b/drivers/gpu/drm/xe/xe_ras.c
@@ -3,6 +3,8 @@
  * Copyright © 2026 Intel Corporation
  */
 
+#include <linux/fault-inject.h>
+
 #include "xe_assert.h"
 #include "xe_bo.h"
 #include "xe_device.h"
@@ -690,6 +692,13 @@ void xe_ras_init(struct xe_device *xe)
 		xe_drm_ras_init(xe);
 }
 
+extern struct fault_attr inject_punit_error;
+
+static bool fault_inject_punit_error(void)
+{
+	return IS_ENABLED(CONFIG_DEBUG_FS) && should_fail(&inject_punit_error, 1);
+}
+
 /**
  * xe_ras_process_errors() - Process and contain hardware errors
  * @xe: xe device instance
@@ -708,6 +717,11 @@ enum xe_ras_recovery_action xe_ras_process_errors(struct xe_device *xe)
 	size_t rlen;
 	int ret;
 
+	if (fault_inject_punit_error()) {
+		punit_error_handler(xe);
+		return XE_RAS_RECOVERY_ACTION_DISCONNECT;
+	}
+
 	if (!xe->info.has_sysctrl)
 		return XE_RAS_RECOVERY_ACTION_RESET;
 
-- 
2.34.1

