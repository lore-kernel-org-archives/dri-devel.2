Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7730C5AD55
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 11:20:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 505D810E7D0;
	Mon, 10 Aug 2026 11:20:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="hJzav1G1";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61A4710E7D0;
 Mon, 10 Aug 2026 11:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786360838; x=1817896838;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=z4xDF+9bp9QQvbFU55qOoRrC0n6y39VOJSTNB6rBof4=;
 b=hJzav1G1vy6LfBEbd0gmzECmoGKzQby9vltx1pykJmI+6SgkJk4UpLmZ
 /d2iXRC6l84MZwMbPKcNWejuuXT5Gu11zKwpzxzkw5kU9TCr+1qcANrjH
 XemxtDD3C3NkJToheli8z4cSiMRG8Dc+XVBTndidu3/maZTq3iFbl92gZ
 K9kHaLFkL06KRdNsV5s4Ngp7YQQ9mQGQLSobHM2Dg9FNq2WLVEjhPLEGq
 7rl+WzuFTfXBxoxOEPLX31GDprOy6tuLrGmza5G73ON2r5lFt/q6KL72+
 +JRsX+CWuE/idofmx9/cST7jZ1AkKA67AUeDDdhMTs/Z3tnLGtrBk6lf9 A==;
X-CSE-ConnectionGUID: 3BItyMOkRLezkQTmgEeaHw==
X-CSE-MsgGUID: eZAQiLAQRPSlSbdHyEq6eQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="97220946"
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; d="scan'208";a="97220946"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Aug 2026 04:20:38 -0700
X-CSE-ConnectionGUID: HEWE1GgCQJS1yC127j2rpw==
X-CSE-MsgGUID: YVPxZ02fS+uGJSGocq0z7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; d="scan'208";a="264998325"
Received: from rtauro-desk.iind.intel.com ([10.190.238.50])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Aug 2026 04:20:33 -0700
From: Riana Tauro <riana.tauro@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org
Cc: aravind.iddamsetty@linux.intel.com, anshuman.gupta@intel.com,
 rodrigo.vivi@intel.com, joonas.lahtinen@linux.intel.com, kuba@kernel.org,
 simona.vetter@ffwll.ch, airlied@gmail.com, pratik.bari@intel.com,
 joshua.santosh.ranjan@intel.com, ashwin.kumar.kulkarni@intel.com,
 shubham.kumar@intel.com, ravi.kishore.koppuravuri@intel.com,
 raag.jadav@intel.com, maarten.lankhorst@linux.intel.com,
 mallesh.koujalagi@intel.com, soham.purkait@intel.com,
 Riana Tauro <riana.tauro@intel.com>
Subject: [PATCH v7 2/2] drm/xe/xe_ras: Report correctable/uncorrectable error
 events to userspace
Date: Mon, 10 Aug 2026 16:50:11 +0530
Message-ID: <20260810112008.1858731-6-riana.tauro@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260810112008.1858731-4-riana.tauro@intel.com>
References: <20260810112008.1858731-4-riana.tauro@intel.com>
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

When an interrupt is received for correctable errors indicating that error
counter has crossed its threshold, read the current counter value and
deliver a drm-ras error-event to userspace for each affected component.

Also send drm-ras error-event to userspace for uncorrectable errors on
receiving an AER.

To avoid sending duplicate events when the same component appears multiple
times in the response, send the error-event once per component.

Signed-off-by: Riana Tauro <riana.tauro@intel.com>
Reviewed-by: Raag Jadav <raag.jadav@intel.com>
---
v2: add BUILD_BUG_ON and use BITS_PER_TYPE
    combine correctable/uncorrectable patches (Raag)
    use correct parameters for get_counter (Sashiko)
---
 drivers/gpu/drm/xe/xe_drm_ras.c | 31 +++++++++++++++
 drivers/gpu/drm/xe/xe_drm_ras.h |  3 ++
 drivers/gpu/drm/xe/xe_ras.c     | 69 +++++++++++++++++++++++++++++++++
 3 files changed, 103 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_drm_ras.c b/drivers/gpu/drm/xe/xe_drm_ras.c
index 7937d8ba0ed9..bf1b921f4183 100644
--- a/drivers/gpu/drm/xe/xe_drm_ras.c
+++ b/drivers/gpu/drm/xe/xe_drm_ras.c
@@ -185,6 +185,37 @@ static int register_nodes(struct xe_device *xe)
 	return ret;
 }
 
+/**
+ * xe_drm_ras_event() - Report drm-ras error event to userspace
+ * @xe: xe device structure
+ * @component: error component (see &enum drm_xe_ras_error_component)
+ * @severity: error severity (see &enum drm_xe_ras_error_severity)
+ * @value: value of error counter
+ *
+ * Report an error-event to userspace.
+ */
+void xe_drm_ras_event(struct xe_device *xe, u32 component, u32 severity, u32 value)
+{
+	struct xe_drm_ras *ras = &xe->ras;
+	struct xe_drm_ras_counter *info = ras->info[severity];
+	struct drm_ras_node *node;
+	int ret;
+
+	/* Event is supported only if drm-ras is enabled */
+	if (!xe->info.has_drm_ras)
+		return;
+
+	node = &ras->node[severity];
+
+	if (!info || !info[component].name)
+		return;
+
+	ret = drm_ras_nl_error_event(node, component, info[component].name, value);
+	if (ret)
+		drm_err_ratelimited(&xe->drm, "drm-ras error-event failed: %d for %s %s\n", ret,
+				    info[component].name, error_severity[severity]);
+}
+
 /**
  * xe_drm_ras_init() - Initialize DRM RAS
  * @xe: xe device instance
diff --git a/drivers/gpu/drm/xe/xe_drm_ras.h b/drivers/gpu/drm/xe/xe_drm_ras.h
index 365c70e93e82..723229b2cffb 100644
--- a/drivers/gpu/drm/xe/xe_drm_ras.h
+++ b/drivers/gpu/drm/xe/xe_drm_ras.h
@@ -5,11 +5,14 @@
 #ifndef _XE_DRM_RAS_H_
 #define _XE_DRM_RAS_H_
 
+#include <linux/types.h>
+
 struct xe_device;
 
 #define for_each_error_severity(i)	\
 	for (i = 0; i < DRM_XE_RAS_ERR_SEV_MAX; i++)
 
 int xe_drm_ras_init(struct xe_device *xe);
+void xe_drm_ras_event(struct xe_device *xe, u32 component, u32 severity, u32 value);
 
 #endif
diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
index 352f056fd9ef..48532447e1d8 100644
--- a/drivers/gpu/drm/xe/xe_ras.c
+++ b/drivers/gpu/drm/xe/xe_ras.c
@@ -90,6 +90,8 @@ static const char * const gpu_health_states[] = {
 };
 static_assert(ARRAY_SIZE(gpu_health_states) == XE_RAS_HEALTH_MAX);
 
+static int get_counter(struct xe_device *xe, struct xe_ras_error_class *counter, u32 *value);
+
 static u8 drm_to_xe_ras_severity(u8 severity)
 {
 	switch (severity) {
@@ -102,6 +104,18 @@ static u8 drm_to_xe_ras_severity(u8 severity)
 	}
 }
 
+static u8 xe_to_drm_ras_severity(u8 severity)
+{
+	switch (severity) {
+	case XE_RAS_SEV_CORRECTABLE:
+		return DRM_XE_RAS_ERR_SEV_CORRECTABLE;
+	case XE_RAS_SEV_UNCORRECTABLE:
+		return DRM_XE_RAS_ERR_SEV_UNCORRECTABLE;
+	default:
+		return DRM_XE_RAS_ERR_SEV_MAX;
+	}
+}
+
 static u8 drm_to_xe_ras_component(u8 component)
 {
 	switch (component) {
@@ -120,6 +134,24 @@ static u8 drm_to_xe_ras_component(u8 component)
 	}
 }
 
+static u8 xe_to_drm_ras_component(u8 component)
+{
+	switch (component) {
+	case XE_RAS_COMP_DEVICE_MEMORY:
+		return DRM_XE_RAS_ERR_COMP_DEVICE_MEMORY;
+	case XE_RAS_COMP_CORE_COMPUTE:
+		return DRM_XE_RAS_ERR_COMP_CORE_COMPUTE;
+	case XE_RAS_COMP_PCIE:
+		return DRM_XE_RAS_ERR_COMP_PCIE;
+	case XE_RAS_COMP_FABRIC:
+		return DRM_XE_RAS_ERR_COMP_FABRIC;
+	case XE_RAS_COMP_SOC_INTERNAL:
+		return DRM_XE_RAS_ERR_COMP_SOC_INTERNAL;
+	default:
+		return DRM_XE_RAS_ERR_COMP_MAX;
+	}
+}
+
 static int ras_status_to_errno(u32 status)
 {
 	switch (status) {
@@ -236,6 +268,26 @@ static void ras_usp_aer_init(struct xe_device *xe)
 	dev_dbg(&usp->dev, "Uncorrectable Internal Errors downgraded and unmasked\n");
 }
 
+static void ras_send_error_event(struct xe_device *xe, u8 severity, u8 component)
+{
+	struct xe_ras_error_class counter = {0};
+	u8 drm_severity, drm_component;
+	u32 value;
+	int ret;
+
+	counter.common.severity = severity;
+	counter.common.component = component;
+
+	ret = get_counter(xe, &counter, &value);
+	if (ret)
+		return;
+
+	drm_severity = xe_to_drm_ras_severity(severity);
+	drm_component = xe_to_drm_ras_component(component);
+
+	xe_drm_ras_event(xe, drm_component, drm_severity, value);
+}
+
 static u8 handle_core_compute_errors(struct xe_ras_error_array *arr)
 {
 	struct xe_ras_compute_error *error_info = (void *)arr->details;
@@ -330,8 +382,10 @@ void xe_ras_counter_threshold_crossed(struct xe_device *xe,
 	struct xe_ras_threshold_crossed *pending = (void *)&response->data;
 	struct xe_ras_error_class *errors = pending->counters;
 	u32 id, ncounters = pending->ncounters;
+	u8 sent = 0;
 
 	BUILD_BUG_ON(sizeof(response->data) < sizeof(*pending));
+	BUILD_BUG_ON(BITS_PER_TYPE(sent) < XE_RAS_COMP_MAX);
 	xe_device_assert_mem_access(xe);
 
 	if (!ncounters || ncounters > XE_RAS_NUM_COUNTERS)
@@ -350,6 +404,13 @@ void xe_ras_counter_threshold_crossed(struct xe_device *xe,
 
 		xe_warn(xe, "[RAS]: %s %s detected\n",
 			comp_to_str(component), sev_to_str(severity));
+
+		/* Send event once per component */
+		if (sent & BIT(component))
+			continue;
+		sent |= BIT(component);
+
+		ras_send_error_event(xe, severity, component);
 	}
 }
 
@@ -406,12 +467,14 @@ enum xe_ras_recovery_action xe_ras_process_errors(struct xe_device *xe)
 	enum xe_ras_recovery_action final_action;
 	u32 remaining = XE_SYSCTRL_FLOOD_LIMIT;
 	struct xe_ras_get_soc_error response;
+	u8 sent = 0;
 	size_t rlen;
 	int ret;
 
 	if (!xe->info.has_sysctrl)
 		return XE_RAS_RECOVERY_ACTION_RESET;
 
+	BUILD_BUG_ON(BITS_PER_TYPE(sent) < XE_RAS_COMP_MAX);
 	/* Default action */
 	final_action = XE_RAS_RECOVERY_ACTION_RECOVERED;
 
@@ -452,6 +515,12 @@ enum xe_ras_recovery_action xe_ras_process_errors(struct xe_device *xe)
 			xe_info(xe, "[RAS]: %s %s detected\n", comp_to_str(component),
 				sev_to_str(severity));
 
+			/* Send event once per component */
+			if (!(sent & BIT(component))) {
+				sent |= BIT(component);
+				ras_send_error_event(xe, severity, component);
+			}
+
 			switch (component) {
 			case XE_RAS_COMP_CORE_COMPUTE:
 				action = handle_core_compute_errors(arr);
-- 
2.47.1

