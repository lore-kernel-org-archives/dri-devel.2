Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F5CC44527
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 10:22:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB72A10E871;
	Mon, 20 Jul 2026 10:22:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="gzzrQmlE";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A030010E868;
 Mon, 20 Jul 2026 10:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784542942; x=1816078942;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=SHyNP0GNxFc1r+cfgsO7ph+KsgmOBjp6TH2QJkSNDKs=;
 b=gzzrQmlEr5TQRboRXZkGrVJ7TalK4rOsFnkXU2Jb6xCMLCy1jF7W8eEp
 0243sVxgoDegTcUeOXSIpGVil7IPjbtM/jBkDmJl9hqV6+PF9lJsYZeCp
 jCi/WaiveGsIFpcwQu4TSCsoc4mEAG1s3K2fraH0a5hjr2afw6P0yeIvH
 z7xCJMVsxa2S/WWtraMU4EcF/BPHAB9WQTi/C5AruyXeCf8X1sRkHRzB2
 ogUaeLsGOAikKMaYy+DFImMbiiG5Fmj+wkA2hWi0n9FDUFkU/6g6nbvv+
 wz7bZUSTjKHZ8wTORYzNpAbc1Up5nC0q11TUH+fxkJuFvxbkEylNAq1p4 Q==;
X-CSE-ConnectionGUID: n1PJFCNVT7mVCgChTEOwsw==
X-CSE-MsgGUID: JGhb+mAjR+qUTZ1kG0N4wg==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="85070544"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="85070544"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 03:22:22 -0700
X-CSE-ConnectionGUID: cyZ+0XgyTFeLMbifZhq5hw==
X-CSE-MsgGUID: VpD3d6LPSkaKtr1yH6C4zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="287475830"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by orviesa002.jf.intel.com with ESMTP; 20 Jul 2026 03:22:19 -0700
From: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rodrigo.vivi@intel.com
Cc: andrealmeid@igalia.com, christian.koenig@amd.com, airlied@gmail.com,
 simona.vetter@ffwll.ch, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 anshuman.gupta@intel.com, badal.nilawar@intel.com, riana.tauro@intel.com,
 karthik.poosa@intel.com, sk.anirban@intel.com, raag.jadav@intel.com,
 Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Subject: [PATCH v11 3/3] drm/xe: Handle PUNIT errors by requesting cold-reset
 recovery
Date: Mon, 20 Jul 2026 15:48:19 +0530
Message-ID: <20260720101815.526813-8-mallesh.koujalagi@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260720101815.526813-5-mallesh.koujalagi@intel.com>
References: <20260720101815.526813-5-mallesh.koujalagi@intel.com>
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

Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Reviewed-by: Raag Jadav <raag.jadav@intel.com>
---
v3:
- Use PUNIT instead of PMU. (Riana)
- Use consistent wording.
- Remove log. (Raag)

v4:
- Make function static. (Raag)

v5:
- Remove kdoc for static function. (Raag)
- Remove xe_ prefix for static function.

v9:
- Remove unwanted header. (Sashiko)
---
 drivers/gpu/drm/xe/xe_ras.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
index a31e06b8aa67..92b4181026cb 100644
--- a/drivers/gpu/drm/xe/xe_ras.c
+++ b/drivers/gpu/drm/xe/xe_ras.c
@@ -236,6 +236,12 @@ static u8 handle_core_compute_errors(struct xe_ras_error_array *arr)
 	return XE_RAS_RECOVERY_ACTION_RECOVERED;
 }
 
+static void punit_error_handler(struct xe_device *xe)
+{
+	xe_device_set_wedged_method(xe, DRM_WEDGE_RECOVERY_COLD_RESET);
+	xe_device_declare_wedged(xe);
+}
+
 static u8 handle_soc_internal_errors(struct xe_device *xe, struct xe_ras_error_array *arr)
 {
 	struct xe_ras_soc_error *info = (void *)arr->details;
@@ -267,7 +273,7 @@ static u8 handle_soc_internal_errors(struct xe_device *xe, struct xe_ras_error_a
 			xe_err(xe, "[RAS]: PUNIT %s detected: 0x%x\n",
 			       sev_to_str(counter->common.severity),
 			       ieh_error->global_error_status);
-			/* TODO: Add PUNIT error handling */
+			punit_error_handler(xe);
 			return XE_RAS_RECOVERY_ACTION_DISCONNECT;
 		}
 	}
-- 
2.48.1

