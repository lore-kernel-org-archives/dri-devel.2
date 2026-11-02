Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C521606A326
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 22:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=F4NUn6OI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CAB110E700;
	Mon,  2 Nov 2026 22:26:50 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5D6910E700;
 Mon,  2 Nov 2026 22:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793658404; x=1825194404;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=hMb54b75rKIlh8RbCKPpVBfKUcdbVI5pT+y3/mQ5Qm8=;
 b=F4NUn6OI7JrYMC1ciir7lve6TNa/TThu2tAXUqGzb9m9WG17leeh+E+a
 PebYLSIlIDjhsb1ndCjvjaVin44fnuSljLKmeFIHIxKSvOes0EvlTPCJR
 gZdm/dbRvo91lOG+Ly/ZaXviO8PcNoAVCRtrOIH+W88RO/5RQm+9ASAVj
 18VSpAE8mpgpTTFCxsfc+vLwMLSmS8Bo0CGMW0T3ZbP4A70KUn5SO5iu8
 +dw/1FWKZnQLelsNglySQWxYoFQNdPeIYXnk+Y5AKwD5+xYCYJvCwFxYW
 eMYEWxXvQbKC+Ms7iYkNlOrTnuN7mA2Jl0RRnEOczWwz1nUTCumSjvR6n w==;
X-CSE-ConnectionGUID: H6Ke/5JiSwiPb2eC30tvEQ==
X-CSE-MsgGUID: zQlvazecSd2tSXlGM76IjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2267777"
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="2267777"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 14:26:44 -0800
X-CSE-ConnectionGUID: jX/usv1vT7OOfzF/HevcYQ==
X-CSE-MsgGUID: 18hgdJWpQ1uFuF7cgwttAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="6626743"
Received: from aalteres-desk1.fm.intel.com ([10.121.64.173])
 by fmviesa007.fm.intel.com with ESMTP; 02 Nov 2026 14:26:43 -0800
From: Alan Previn <alan.previn.teres.alexis@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Alan Previn <alan.previn.teres.alexis@intel.com>,
 dri-devel@lists.freedesktop.org, Raag Jadav <raag.jadav@intel.com>,
 Riana Tauro <riana.tauro@intel.com>
Subject: [PATCH 1/1] drm/xe/survivability: broadcast dmesg when engaging
 survivability
Date: Mon,  2 Nov 2026 14:26:43 -0800
Message-ID: <20261102222643.1758080-2-alan.previn.teres.alexis@intel.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When user requests to enter survivabilty via configfs, or if
check_boot_failure is hit inside xe_survivability_mode_is_requested,
no indication is published. This patch adds some awareness in dmesg.

 v4 : - Remove logs from enable_boot_survivability_mode to avoid
        duplication (Riana + Sashiko).
      - Rename xe_survivability_mode_is_requested to
        xe_survivability_mode_is_required since it checks fw state
        on top of configfs request. Refactor to avoid duplicated logs.
 v3 : - Limit message to xe_survivability_mode_is_requested. (Riana)
 v2 : - Remove / modify messages to reflect underlying behavior. (Sashiko)

Signed-off-by: Alan Previn <alan.previn.teres.alexis@intel.com>
---
 drivers/gpu/drm/xe/xe_device.c             |  2 +-
 drivers/gpu/drm/xe/xe_survivability_mode.c | 46 +++++++++++++---------
 drivers/gpu/drm/xe/xe_survivability_mode.h |  2 +-
 3 files changed, 29 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index 07a7ab6ac083..608309745328 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -735,7 +735,7 @@ int xe_device_probe_early(struct xe_device *xe)
 	 * the driver will be blocked
 	 */
 	err = xe_pcode_probe_early(xe);
-	if (err || xe_survivability_mode_is_requested(xe)) {
+	if (err || xe_survivability_mode_is_required(xe)) {
 		int save_err = err;
 
 		/*
diff --git a/drivers/gpu/drm/xe/xe_survivability_mode.c b/drivers/gpu/drm/xe/xe_survivability_mode.c
index d73cdad0b3a9..0650bbca5f5d 100644
--- a/drivers/gpu/drm/xe/xe_survivability_mode.c
+++ b/drivers/gpu/drm/xe/xe_survivability_mode.c
@@ -364,11 +364,6 @@ static int enable_boot_survivability_mode(struct pci_dev *pdev)
 	if (ret)
 		goto failed;
 
-	if (check_boot_failure(xe))
-		xe_log_err_fatal(pdev, SURVIVABILITY, 0, "Boot Mode enabled!\n");
-	else
-		xe_log_info(pdev, SURVIVABILITY, "Boot Mode enabled!\n");
-
 	return 0;
 
 failed:
@@ -390,17 +385,7 @@ bool xe_survivability_mode_is_boot_enabled(struct xe_device *xe)
 	return survivability->mode && survivability->type == XE_SURVIVABILITY_TYPE_BOOT;
 }
 
-/**
- * xe_survivability_mode_is_requested - check if it's possible to enable survivability
- *					mode that was requested by firmware or userspace
- * @xe: xe device instance
- *
- * This function reads configfs and  boot status from Pcode.
- *
- * Return: true if platform support is available and boot status indicates
- * failure or if survivability mode is requested, false otherwise.
- */
-bool xe_survivability_mode_is_requested(struct xe_device *xe)
+static bool survivability_mode_required(struct xe_device *xe, bool log_on_action)
 {
 	struct xe_survivability *survivability = &xe->survivability;
 	struct xe_mmio *mmio = xe_root_tile_mmio(xe);
@@ -413,13 +398,36 @@ bool xe_survivability_mode_is_requested(struct xe_device *xe)
 
 	survivability_mode = xe_configfs_get_survivability_mode(pdev);
 	/* Enable survivability mode if set via configfs */
-	if (survivability_mode)
+	if (survivability_mode) {
+		if (log_on_action)
+			xe_log_info(xe, SURVIVABILITY, "Boot mode requested.\n");
 		return true;
+	}
 
 	data = xe_mmio_read32(mmio, PCODE_SCRATCH(0));
 	survivability->boot_status = REG_FIELD_GET(BOOT_STATUS, data);
 
-	return check_boot_failure(xe);
+	if (check_boot_failure(xe)) {
+		if (log_on_action)
+			xe_log_err_fatal(pdev, SURVIVABILITY, 0, "Boot Mode required!\n");
+		return true;
+	}
+	return false;
+}
+
+/**
+ * xe_survivability_mode_is_required - check if survivability mode is required based on
+ *                                     state of firmware or userspace request.
+ * @xe: xe device instance
+ *
+ * This function reads configfs and boot status from Pcode.
+ *
+ * Return: true if platform support is available and boot status indicates
+ * failure or if survivability mode is requested, false otherwise.
+ */
+bool xe_survivability_mode_is_required(struct xe_device *xe)
+{
+	return survivability_mode_required(xe, true);
 }
 
 /**
@@ -468,7 +476,7 @@ int xe_survivability_mode_boot_enable(struct xe_device *xe)
 	struct xe_survivability *survivability = &xe->survivability;
 	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
 
-	if (!xe_survivability_mode_is_requested(xe))
+	if (!survivability_mode_required(xe, false))
 		return 0;
 
 	populate_survivability_info(xe);
diff --git a/drivers/gpu/drm/xe/xe_survivability_mode.h b/drivers/gpu/drm/xe/xe_survivability_mode.h
index cd040e4d18bb..a68f071a8055 100644
--- a/drivers/gpu/drm/xe/xe_survivability_mode.h
+++ b/drivers/gpu/drm/xe/xe_survivability_mode.h
@@ -13,6 +13,6 @@ struct xe_device;
 int xe_survivability_mode_boot_enable(struct xe_device *xe);
 void xe_survivability_mode_runtime_enable(struct xe_device *xe);
 bool xe_survivability_mode_is_boot_enabled(struct xe_device *xe);
-bool xe_survivability_mode_is_requested(struct xe_device *xe);
+bool xe_survivability_mode_is_required(struct xe_device *xe);
 
 #endif /* _XE_SURVIVABILITY_MODE_H_ */

base-commit: 2cd78713d917a02987f21b437561a5e1e13ddda2
-- 
2.43.0

