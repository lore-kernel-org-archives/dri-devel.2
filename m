Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 481F9C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 08:43:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2F6910E76B;
	Mon, 13 Jul 2026 08:43:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ZK8soW8s";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C2E410E804;
 Mon, 13 Jul 2026 08:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783932211; x=1815468211;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RG0vpfipCCIQ9ePMFRvG1rogYs2H67IUjGi7Xs9KTgk=;
 b=ZK8soW8sNC4TDfZ8d06Gphjo9t+3os+05iK4cdBYn1EZlhWIpqW9uM13
 4clYI+BeyF2uY59W0zbPhKY2fz/E+DmPHPJ0U/zTyHvK0cpge5XlXsyti
 jxRPJ9dAn81Y4QMWGWGv6ra0iJPUl2PGTJqsjealWoIyoiFnSupOIPmfu
 PId97y5rgtO5r/NlhAIEaKdra1Ub/zZDFDUzYPjEsGlpUIREl1BTcx7KL
 uTdrfYCzlvYoVJRF9xPG3UwLm+ynNwDsP4cK7Av+AMZFXU/kWrNncAiyY
 /En62pLVxgL8EOophMaWNsOfffsG962FDs/6iN0KfW+l1eepSHl7vNsPn Q==;
X-CSE-ConnectionGUID: JtuEfA5FTeehqAtW6DJhlQ==
X-CSE-MsgGUID: ms8nx25wT4+RbftHstHQaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="95903956"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="95903956"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jul 2026 01:43:30 -0700
X-CSE-ConnectionGUID: 5SO2CJh2SHuLK1/Ug72C6A==
X-CSE-MsgGUID: XetzrjuMSNidgVS7NvDahg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="251073024"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by fmviesa006.fm.intel.com with ESMTP; 13 Jul 2026 01:43:26 -0700
From: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rodrigo.vivi@intel.com
Cc: andrealmeid@igalia.com, christian.koenig@amd.com, airlied@gmail.com,
 simona.vetter@ffwll.ch, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 anshuman.gupta@intel.com, badal.nilawar@intel.com, riana.tauro@intel.com,
 karthik.poosa@intel.com, sk.anirban@intel.com, raag.jadav@intel.com,
 Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Subject: [PATCH v10 1/4] drm/xe/xe_ras: Do not Review, compilation only.
Date: Mon, 13 Jul 2026 14:09:41 +0530
Message-ID: <20260713083939.251872-7-mallesh.koujalagi@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713083939.251872-6-mallesh.koujalagi@intel.com>
References: <20260713083939.251872-6-mallesh.koujalagi@intel.com>
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

DO NOT REVIEW. COMPILATION ONLY
This patch is from https://patchwork.freedesktop.org/series/160482/
Added only for Compilation.

Signed-off-by: Riana Tauro <riana.tauro@intel.com>
Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
---
 drivers/gpu/drm/xe/xe_ras.c       | 43 +++++++++++++++++
 drivers/gpu/drm/xe/xe_ras_types.h | 80 +++++++++++++++++++++++++++++++
 2 files changed, 123 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
index 74d5016d9ffe..3d39bb95e94d 100644
--- a/drivers/gpu/drm/xe/xe_ras.c
+++ b/drivers/gpu/drm/xe/xe_ras.c
@@ -9,6 +9,7 @@
 #include "xe_printk.h"
 #include "xe_ras.h"
 #include "xe_ras_types.h"
+#include "xe_survivability_mode.h"
 #include "xe_sysctrl.h"
 #include "xe_sysctrl_event_types.h"
 #include "xe_sysctrl_mailbox.h"
@@ -193,6 +194,48 @@ static void ras_usp_aer_init(struct xe_device *xe)
 	dev_dbg(&usp->dev, "Uncorrectable Internal Errors downgraded and unmasked\n");
 }
 
+static __maybe_unused enum xe_ras_recovery_action
+handle_soc_internal_errors(struct xe_device *xe,
+			   struct xe_ras_error_array *arr)
+{
+	struct xe_ras_soc_error *info = (void *)arr->details;
+	struct xe_ras_soc_error_source *source = &info->source;
+	struct xe_ras_error_class *counter = &arr->counter;
+
+	if (source->csc) {
+		struct xe_ras_csc_error *csc_error = (void *)info->details;
+
+		/*
+		 * CSC uncorrectable errors are classified as hardware errors and firmware errors.
+		 * CSC firmware errors are critical errors that can be recovered only by firmware
+		 * update via SPI driver. On a CSC firmware error, PCODE enables FDO mode and sets
+		 * the bit in the capability register. On receiving this error, the driver enables
+		 * runtime survivability mode which notifies userspace that a firmware update
+		 * is required.
+		 */
+		if (csc_error->hec_fw_error) {
+			xe_err(xe, "[RAS]: CSC %s detected: 0x%x\n",
+			       sev_to_str(counter->common.severity),
+			       csc_error->hec_fw_error);
+			xe_survivability_mode_runtime_enable(xe);
+			return XE_RAS_RECOVERY_ACTION_DISCONNECT;
+		}
+	} else if (source->ieh) {
+		struct xe_ras_ieh_error *ieh_error = (void *)info->details;
+
+		if (ieh_error->global_error_status & XE_RAS_SOC_IEH_PUNIT) {
+			xe_err(xe, "[RAS]: PUNIT %s detected: 0x%x\n",
+			       sev_to_str(counter->common.severity),
+			       ieh_error->global_error_status);
+			/* TODO: Add PUNIT error handling */
+			return XE_RAS_RECOVERY_ACTION_DISCONNECT;
+		}
+	}
+
+	/* For other SOC internal errors, request a reset as recovery mechanism */
+	return XE_RAS_RECOVERY_ACTION_RESET;
+}
+
 void xe_ras_counter_threshold_crossed(struct xe_device *xe,
 				      struct xe_sysctrl_event_response *response)
 {
diff --git a/drivers/gpu/drm/xe/xe_ras_types.h b/drivers/gpu/drm/xe/xe_ras_types.h
index 6688e11f57a8..3c165096ea20 100644
--- a/drivers/gpu/drm/xe/xe_ras_types.h
+++ b/drivers/gpu/drm/xe/xe_ras_types.h
@@ -9,6 +9,7 @@
 #include <linux/types.h>
 
 #define XE_RAS_NUM_COUNTERS			16
+#define XE_RAS_SOC_IEH_PUNIT			BIT(1)
 
 /**
  * struct xe_ras_error_common - Error fields that are common across all products
@@ -121,4 +122,83 @@ struct xe_ras_clear_counter_response {
 	/** @reserved1: Reserved for future use */
 	u32 reserved1[3];
 } __packed;
+
+/**
+ * enum xe_ras_recovery_action - RAS recovery actions
+ *
+ * @XE_RAS_RECOVERY_ACTION_RECOVERED: Error recovered
+ * @XE_RAS_RECOVERY_ACTION_RESET: Requires reset
+ * @XE_RAS_RECOVERY_ACTION_DISCONNECT: Requires disconnect
+ * @XE_RAS_RECOVERY_ACTION_MAX: Max action value
+ */
+enum xe_ras_recovery_action {
+	XE_RAS_RECOVERY_ACTION_RECOVERED = 0,
+	XE_RAS_RECOVERY_ACTION_RESET,
+	XE_RAS_RECOVERY_ACTION_DISCONNECT,
+	XE_RAS_RECOVERY_ACTION_MAX
+};
+
+/**
+ * struct xe_ras_error_array - Details of the error types
+ */
+struct xe_ras_error_array {
+	/** @counter_value: Counter value of the returned error */
+	u32 counter_value;
+	/** @counter: Error counter */
+	struct xe_ras_error_class counter;
+	/** @timestamp: Timestamp */
+	u64 timestamp;
+	/** @details: Error details specific to the counter */
+	u32 details[XE_RAS_NUM_COUNTERS];
+} __packed;
+
+/**
+ * struct xe_ras_soc_error_source - Source of SoC error
+ */
+struct xe_ras_soc_error_source {
+	/** @csc: CSC */
+	u32 csc:1;
+	/** @ieh: IEH (Integrated Error Handler) */
+	u32 ieh:1;
+	/** @reserved: Reserved for future use */
+	u32 reserved:30;
+} __packed;
+
+/**
+ * struct xe_ras_soc_error - Error details of SoC internal error
+ */
+struct xe_ras_soc_error {
+	/** @source: Error source */
+	struct xe_ras_soc_error_source source;
+	/** @details: Error details specific to the error source */
+	u32 details[15];
+} __packed;
+
+/**
+ * struct xe_ras_csc_error - CSC error details
+ */
+struct xe_ras_csc_error {
+	/** @reserved: Reserved */
+	u32 reserved;
+	/** @hec_fw_error: CSC firmware error */
+	u32 hec_fw_error;
+} __packed;
+
+/**
+ * struct xe_ras_ieh_error - SoC IEH (Integrated Error Handler) error details
+ */
+struct xe_ras_ieh_error {
+	/** @ieh_instance: IEH instance */
+	u32 ieh_instance:2;
+	/** @reserved: Reserved for future use */
+	u32 reserved:30;
+	/** @global_error_status: Global error status */
+	u32 global_error_status;
+	/** @local_error_status: Local error status */
+	u32 local_error_status;
+	/** @gerr_mask: Global error mask */
+	u32 gerr_mask;
+	/** @info: Additional information */
+	u32 info[10];
+} __packed;
 #endif
-- 
2.48.1

