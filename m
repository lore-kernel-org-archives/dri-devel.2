Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1370C43327
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 09:45:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D023F10EE92;
	Wed,  1 Jul 2026 09:45:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="XACDvwdp";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F28B10E327;
 Wed,  1 Jul 2026 09:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782899100; x=1814435100;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=R9hFtEKgYS471ndT+08iOQmnZI/274Kw2I1LXOyop3Y=;
 b=XACDvwdpwm5Pt5s+tUNUp/YCBdK80EHI0aWxqX+EjqsH+KawDi6qO1av
 0xiH70ZTQmNOjZKB3hYLoEonAPEriFoQ+C9DCqMnc6MRbPNcF6gsEm4jI
 eOiCl0uPpIDNN+60K9SJkS6OzYxvkrRakvt4EoCK7357mZi6P/z3OTQ95
 UXQTY8L7BJRBOheIN21oQ4fX6rzdWuN1J1acuBQfMha8xoBg2F2ipMBJY
 B3aofkV+n6c/7xXxTR06Pjo2C68rJ0HJm9BPGiXKm82skA7t1m8WpzZ9B
 pFVkSvk4LvMu3q5BW/i1xsNyeDR/GdcPGu880g3FRdHBQYkZoGnc34Y7w w==;
X-CSE-ConnectionGUID: YY2rEdz3Rz+l0Uw8a7XB5Q==
X-CSE-MsgGUID: ShsjCgq2SReVurR/42Mdiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="94781524"
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; d="scan'208";a="94781524"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2026 02:45:00 -0700
X-CSE-ConnectionGUID: h+SKyAf4Sgysm53Tfai9Zw==
X-CSE-MsgGUID: ViEjRa2ISH6GFxpvtHxWgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; d="scan'208";a="248541521"
Received: from rtauro-desk.iind.intel.com ([10.190.238.50])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2026 02:44:52 -0700
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
Subject: [PATCH v4 3/3] drm/xe/xe_ras: Add error-event support for CRI
Date: Wed,  1 Jul 2026 15:14:13 +0530
Message-ID: <20260701094409.129131-8-riana.tauro@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260701094409.129131-5-riana.tauro@intel.com>
References: <20260701094409.129131-5-riana.tauro@intel.com>
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

Add error-event support for Correctable errors in CRI. Report an error
event to userspace for every component that has crossed the threshold on
receiving an interrupt.

Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>
Signed-off-by: Riana Tauro <riana.tauro@intel.com>
---
v2: add warns for unexpected values from system controller (Michal)
    send an event at most once per component for each interrupt (Raag)
    use correct parameters for get_counter (Sashiko)
---
 drivers/gpu/drm/xe/xe_ras.c | 75 +++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
index 44f4e1a3455b..b71d51285954 100644
--- a/drivers/gpu/drm/xe/xe_ras.c
+++ b/drivers/gpu/drm/xe/xe_ras.c
@@ -77,6 +77,18 @@ static u8 drm_to_xe_ras_severity(u8 severity)
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
@@ -95,6 +107,24 @@ static u8 drm_to_xe_ras_component(u8 component)
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
@@ -131,14 +161,41 @@ static inline const char *comp_to_str(u8 component)
 	return xe_ras_components[component];
 }
 
+static void ras_send_error_event(struct xe_device *xe, u8 severity, u8 component)
+{
+	u8 drm_severity, drm_component;
+	u32 value;
+	int ret;
+
+	drm_severity = xe_to_drm_ras_severity(severity);
+	if (drm_severity == DRM_XE_RAS_ERR_SEV_MAX) {
+		xe_warn(xe, "sysctrl: unexpected severity %u\n", severity);
+		return;
+	}
+
+	drm_component = xe_to_drm_ras_component(component);
+	if (drm_component == DRM_XE_RAS_ERR_COMP_MAX) {
+		xe_warn(xe, "sysctrl: unexpected component %u\n", component);
+		return;
+	}
+
+	ret = xe_ras_get_counter(xe, drm_severity, drm_component, &value);
+	if (ret)
+		return;
+
+	xe_drm_ras_event(xe, drm_component, drm_severity, value, GFP_KERNEL);
+}
+
 void xe_ras_counter_threshold_crossed(struct xe_device *xe,
 				      struct xe_sysctrl_event_response *response)
 {
 	struct xe_ras_threshold_crossed *pending = (void *)&response->data;
 	struct xe_ras_error_class *errors = pending->counters;
 	u32 id, ncounters = pending->ncounters;
+	u8 sent = 0;
 
 	BUILD_BUG_ON(sizeof(response->data) < sizeof(*pending));
+	BUILD_BUG_ON(XE_RAS_COMP_MAX > (BITS_PER_BYTE * sizeof(sent)));
 	xe_device_assert_mem_access(xe);
 
 	if (!ncounters || ncounters > XE_RAS_NUM_COUNTERS)
@@ -154,6 +211,24 @@ void xe_ras_counter_threshold_crossed(struct xe_device *xe,
 
 		xe_warn(xe, "[RAS]: %s %s detected\n",
 			comp_to_str(component), sev_to_str(severity));
+
+		if (severity != XE_RAS_SEV_CORRECTABLE) {
+			xe_warn(xe, "sysctrl: unexpected severity %s (%u)\n", sev_to_str(severity),
+				severity);
+			continue;
+		}
+
+		if (component >= XE_RAS_COMP_MAX) {
+			xe_warn(xe, "sysctrl: unexpected component %u\n", component);
+			continue;
+		}
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

