Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BCA5C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 08:22:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56C2510E804;
	Mon, 20 Jul 2026 08:22:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="hTo9Tslq";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D47310E80C;
 Mon, 20 Jul 2026 08:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784535759; x=1816071759;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rIk48nY104apc/H2DpXtZihD/8wq4FWxOoHXstjyoZg=;
 b=hTo9TslqNvGerKc3EYJt77g4O6wrzu7fA52bkGchlB4Oq/BzFb55jXpL
 9QSENpsSXaZ5wlk9G+a81btq+obK+oexqzxMG2pL84Lcnuo5sPwK/5gYV
 PyB45BOdX8cZ6IZ2vawSbYS5no9i4Ggv+dezlHlF9oo5qQTpXDSidP+PJ
 PWGrYkNWQuXpB8NJtxqwoU9QiRn314pTIO7Y5ZxZmXNz1VFQ1XTmgm7Ps
 A/R7jkap6iqnl/2sKVik2JEZdcsFCP+R9o//XYgptemY4Y+rYqYPGCcGQ
 5IfJvDvtn+vAHdWUSeZNfBPqB01lB7VeJpcU02/Sajq1ODwTYTntP37Vy g==;
X-CSE-ConnectionGUID: RmsW0LCQQUaaAziDuEtApA==
X-CSE-MsgGUID: 00i68Ao3TDSM1mZrNuuAXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="85228605"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="85228605"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 01:22:39 -0700
X-CSE-ConnectionGUID: O48m47AGQnC9r8np3SjYIg==
X-CSE-MsgGUID: /5L3Py/2TjSX8ZENhHpZXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="258034744"
Received: from rtauro-desk.iind.intel.com ([10.190.238.50])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 01:22:35 -0700
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
 Riana Tauro <riana.tauro@intel.com>,
 Michal Wajdeczko <michal.wajdeczko@intel.com>
Subject: [PATCH v5 2/3] drm/xe/xe_ras: Report correctable error events to
 userspace
Date: Mon, 20 Jul 2026 13:52:11 +0530
Message-ID: <20260720082208.2648279-7-riana.tauro@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260720082208.2648279-5-riana.tauro@intel.com>
References: <20260720082208.2648279-5-riana.tauro@intel.com>
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

When an interrupt is received indicating that error counter has crossed
its threshold, read the current counter value and deliver a drm_ras error
event to userspace for each affected component.

To avoid sending duplicate events when the same component appears multiple
times in the response. Send the error-event once per component.

Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>
Signed-off-by: Riana Tauro <riana.tauro@intel.com>
---
v2: add warns for unexpected values from system controller (Michal)
    send an event at most once per component for each interrupt (Raag)
    use correct parameters for get_counter (Sashiko)

v3: move unsupported logs to drm_ras layer
    use get_counter directly
    use BITS_PER_TYPE
    move the checks before detected log (Raag)
---
 drivers/gpu/drm/xe/xe_drm_ras.c | 42 +++++++++++++++++++++
 drivers/gpu/drm/xe/xe_drm_ras.h |  3 ++
 drivers/gpu/drm/xe/xe_ras.c     | 67 +++++++++++++++++++++++++++++++++
 3 files changed, 112 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_drm_ras.c b/drivers/gpu/drm/xe/xe_drm_ras.c
index 7937d8ba0ed9..0287594e1026 100644
--- a/drivers/gpu/drm/xe/xe_drm_ras.c
+++ b/drivers/gpu/drm/xe/xe_drm_ras.c
@@ -185,6 +185,48 @@ static int register_nodes(struct xe_device *xe)
 	return ret;
 }
 
+/**
+ * xe_drm_ras_event() - Report drm_ras error event to userspace
+ * @xe: xe device structure
+ * @component: error component (see &enum drm_xe_ras_error_component)
+ * @severity: error severity (see &enum drm_xe_ras_error_severity)
+ * @value: value of error counter
+ *
+ * Report an error-event to userspace.
+ */
+void xe_drm_ras_event(struct xe_device *xe, u8 component, u8 severity, u32 value)
+{
+	struct xe_drm_ras *ras = &xe->ras;
+	struct xe_drm_ras_counter *info;
+	struct drm_ras_node *node;
+	int ret;
+
+	/* Event is supported only if drm_ras is enabled */
+	if (!xe->info.has_drm_ras)
+		return;
+
+	if (component >= DRM_XE_RAS_ERR_COMP_MAX) {
+		drm_warn(&xe->drm, "unsupported component %u\n", component);
+		return;
+	}
+
+	if (severity >= DRM_XE_RAS_ERR_SEV_MAX) {
+		drm_warn(&xe->drm, "unsupported severity %u\n", severity);
+		return;
+	}
+
+	node = &ras->node[severity];
+	info = ras->info[severity];
+
+	if (!info || !info[component].name)
+		return;
+
+	ret = drm_ras_nl_error_event(node, component, info[component].name, value);
+	if (ret)
+		drm_err_ratelimited(&xe->drm, "drm_ras error-event failed: %d for %s %s\n", ret,
+				    info[component].name, error_severity[severity]);
+}
+
 /**
  * xe_drm_ras_init() - Initialize DRM RAS
  * @xe: xe device instance
diff --git a/drivers/gpu/drm/xe/xe_drm_ras.h b/drivers/gpu/drm/xe/xe_drm_ras.h
index 365c70e93e82..add96bf1a7ab 100644
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
+void xe_drm_ras_event(struct xe_device *xe, u8 component, u8 severity, u32 value);
 
 #endif
diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
index a31e06b8aa67..b08c664778ff 100644
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
@@ -218,6 +250,26 @@ static void ras_usp_aer_init(struct xe_device *xe)
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
@@ -312,8 +364,10 @@ void xe_ras_counter_threshold_crossed(struct xe_device *xe,
 	struct xe_ras_threshold_crossed *pending = (void *)&response->data;
 	struct xe_ras_error_class *errors = pending->counters;
 	u32 id, ncounters = pending->ncounters;
+	u8 sent = 0;
 
 	BUILD_BUG_ON(sizeof(response->data) < sizeof(*pending));
+	BUILD_BUG_ON(BITS_PER_TYPE(sent) < XE_RAS_COMP_MAX);
 	xe_device_assert_mem_access(xe);
 
 	if (!ncounters || ncounters > XE_RAS_NUM_COUNTERS)
@@ -327,8 +381,21 @@ void xe_ras_counter_threshold_crossed(struct xe_device *xe,
 		severity = errors[id].common.severity;
 		component = errors[id].common.component;
 
+		if (severity != XE_RAS_SEV_CORRECTABLE) {
+			xe_warn(xe, "sysctrl: unexpected severity %s (%u)\n", sev_to_str(severity),
+				severity);
+			continue;
+		}
+
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
 
-- 
2.47.1

