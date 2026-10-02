Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A0FCA5FE5
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 19:01:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 732E710F9AB;
	Fri,  2 Oct 2026 19:01:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HQ4JEiy/";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013016.outbound.protection.outlook.com
 [40.93.196.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C95910E5FB;
 Fri,  2 Oct 2026 19:01:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yAm6RSz4rHDhLtyXajoCzD0uCGlG5z5cmFBVJtc7jjRo62fWSLKTi+eEBwh3w6wXAQWuAYxmKStqN8VNQrcorXCxytL+z/wArfjqP3NguZ0OaWLKTlw7PzG4uavyvyPL8r1GsKR5Kb2lW37IYnXqpjRqqo42LVxkvU9J+QML0q6mpuHE892heD/7xdPQnlmzpgN5MWcJukcfMWXWYmmfLLHrBon4QAuMpD8Ni1Rnd0ZciC0q+WqvguLZ/15vPA775F3HpKUeFbjdTH9YwANRL9PQNrc41xK/BoujzQlQPrfbCtfjJD1sZadhI5bekBzKGdMm6vA4UOK8poxo/97qrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qofG3XxmsxQLe79WT3mqiUygq20kNisb3/QunQloWjI=;
 b=Rmc9A7OcO1ejgpwX+RcKSL8L9QuxNPNw/pUf1v5vjU07+qlHPBOzm/yrQ03WHU4At8BWC0fOXm4HgM4SmBxw6JioPjvPZg72cbW3RGCnil+bMjZNGHVrnBZUZ6E1781u2PEEv1kHKcQ7rZL2PrSStGCCn1bO8sxh/fFOZvrlMyNIcjP4DLMgswZXEI0z6I3QZHuBFRYAF5IV4/Bhm9Zx9vDrQ/mjHDcWg6kt1WFIhEKjYDCCAPdq73azZ/Kb7O/J1Wuv9BnMmeoScBRn+6iZw8vX1R0Jwkn0/FidgmsVeeULb4P+07HRlrWWrB9K8Yo7DXIkg8W4bRvyd1wRB0n57w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qofG3XxmsxQLe79WT3mqiUygq20kNisb3/QunQloWjI=;
 b=HQ4JEiy/ViA8jSbgF+epm8Twtc1MMfiL9PLdoeIXRh2W768k9cnBq7HFFdca2UgU5/B97iHioAu+7JOljVQWbzz9gH/bDbpzlEP2wAd9Spt39Vzk3qpBxhT4fgoi80H+KVqxkcYqzCNNguPj+g/agB/vY54XLP5QjI9nSstC9vk=
Received: from MW4PR03CA0023.namprd03.prod.outlook.com (2603:10b6:303:8f::28)
 by PH0PR12MB7905.namprd12.prod.outlook.com (2603:10b6:510:28b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Fri, 2 Oct
 2026 19:01:08 +0000
Received: from MW1PEPF0001615D.namprd21.prod.outlook.com
 (2603:10b6:303:8f:cafe::34) by MW4PR03CA0023.outlook.office365.com
 (2603:10b6:303:8f::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.18 via Frontend Transport; Fri, 2
 Oct 2026 19:01:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF0001615D.mail.protection.outlook.com (10.167.249.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.3 via Frontend Transport; Fri, 2 Oct 2026 19:01:06 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 14:01:03 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <dri-devel@lists.freedesktop.org>, <harry.wentland@amd.com>, Simona Vetter
 <simona@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>
CC: Xaver Hugl <xaver.hugl@gmail.com>, <amd-gfx@lists.freedesktop.org>, "open
 list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-gfx@lists.freedesktop.org>, "open list:INTEL DRM DISPLAY FOR XE AND
 I915 DRIVERS" <intel-xe@lists.freedesktop.org>, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: [PATCH v9 01/21] drm: add connector LUMINANCE property
Date: Fri, 2 Oct 2026 14:00:10 -0500
Message-ID: <20261002190030.211356-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002190030.211356-1-mario.limonciello@amd.com>
References: <20261002190030.211356-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615D:EE_|PH0PR12MB7905:EE_
X-MS-Office365-Filtering-Correlation-Id: 1adc0fa2-76c5-4eef-4356-08df20b7835a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|7416014|23010399003|1800799024|10067099003|56012099006|11063799006|5023799004|22082099003|3023799007|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: MdDBsJWoQvVG9iJsiS1TiHJYFfV2Wszg2n2T6Z+9U9xBF/ojWsBt2h0xeq0CgotKZ/M9jE2yun4B9mneUv9THhaYI6j6/ER2ilQXhbNwvwB/kCbSnzH/wmAMhKn4I9eoXY1wV0QU4W1luSa7dOZ5yHuVhuAvHVLwkjwnwNQhm2fZ2Ye3XJB4WitMJNbsSw1BvkymHvR0E5D0xivpmEizF98ISCu2tSPSzsjrn5EiorY52fyin1q9uumTf6gB67FaYGf8ZTm91sU2SZRQg0CF0OgEpZ2FqtjTz25d2WbQpveMn1I+VnTeFUJVaeJ2Lk9Y/4PdTJsH5nEi41qDlieiVFP9WowEoMyfQHSHBULYdSGVC4im3T1VV6AOHbvHFS3LVihGHfExe2mRCfC/4en8izXLkDVQd+0PjAHtyjPvpnByzsan7g8/u5UPGBMPKzHGC3dqpx70fVBV2HkDctIWF4FKgTYQzarVxChU9A2z2K8+SV/VcGk+xex6L7vlej+l+XBUzsEL3c5h/vzBhxHGS5TxSjneYC9Y1XdzLdWbGebHn66G5vWaWPAQsMpUXzvByAyazheHsCyBWT1q6LtouhNXnaEJYsN6QgCK/5bRUBLI/jLHERBS5YXm8Ucog3hsaVFRG8sLbMFDZ0DTi3TPZGWwovQ8+NAyJLyXA3uoMIdt10wh/9IRG0EAjtqjFw8DUK6RN6/vVHtvP1Qlu8Swzg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(7416014)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(5023799004)(22082099003)(3023799007)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zMiha9hQCaOkiqssry4z7B6tUejx74yudDFWu5xBovpTNcfkns5GXAUoDRSku4e7UvK3XyqdusSQoM2lc+GM+BKL4Jn9KYs7wAj/2Vjl1SSk+faIfu7P0ZVy+iSi1iS2+6cYP+IHp0KeX6Ayb/DLTRLVRsW82oCk2q9CWs5PeQuMWnGKXbaX4lgN4PmC+ekxFxjK5IojPa0+gvBGJkwJYqniQnm3M91b1DaBT55y/+zwy/7FsXRyeZIhN7uAlb4pMOyjbr4SVSjjO8zMTHvIes8TTT9vCNmxQ6uZ2Q43TSkr3SymZ1ovw+/iuGWsue8QAMsCHCJTa2aVxmMmVFmO0vzjz38cEE8IB07eDJDFcZIQK7xIDiLD+kPDXGFZV1n2qUfN1OLJ2HB43T8AOj8HR7cEae6xDaNLPF3p27CwAfT/PGB/x/977MlyuSGuYeQK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 19:01:06.3384 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1adc0fa2-76c5-4eef-4356-08df20b7835a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF0001615D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7905
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

Panel brightness is a property of a display, and thus of a DRM
connector. Add an atomic per-connector LUMINANCE range property so
compositors can manage relative panel luminance together with the rest
of the display state.

Keep the core backend-agnostic. Drivers create the property with their
hardware range and implement connector helper callbacks to set luminance
or disable panel emission. The atomic helpers sequence those callbacks
around pipeline enable and disable, including luminance-only commits.

The stored property value is independent of display power. A commit made
while the connector is inactive is retained and applied on the next
enable; disabling the pipeline does not overwrite it.

LUMINANCE values are relative, driver-defined levels rather than
absolute luminance in cd/m^2. The interface supports emissive panels as
well as panels with a separate backlight.

Keep the interface behind a default-off DRM_LUMINANCE option. Migrated
drivers retain their legacy backlight class ABI unless the new interface
is explicitly selected, allowing the DRM UAPI and legacy compatibility
policy to remain separate.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/Kconfig                    | 14 +++++
 drivers/gpu/drm/drm_atomic_helper.c        | 73 +++++++++++++++++++++-
 drivers/gpu/drm/drm_atomic_state_helper.c  |  7 +++
 drivers/gpu/drm/drm_atomic_uapi.c          |  5 ++
 drivers/gpu/drm/drm_connector.c            | 57 +++++++++++++++++
 drivers/gpu/drm/tests/drm_connector_test.c | 28 +++++++++
 include/drm/drm_atomic_helper.h            |  3 +
 include/drm/drm_connector.h                | 16 +++++
 include/drm/drm_modeset_helper_vtables.h   | 25 ++++++++
 9 files changed, 227 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 65d46dfa72661..9c183c8e2b71b 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -33,6 +33,20 @@ endmenu
 
 if DRM
 
+config DRM_LUMINANCE
+	bool "DRM connector luminance support"
+	help
+	  Expose relative luminance as an atomic DRM connector property. Values
+	  are driver-defined levels rather than absolute luminance in cd/m^2.
+	  Drivers provide connector helper callbacks to program their hardware;
+	  the DRM core does not depend on a particular backend.
+
+	  Drivers migrated to this interface will use it instead of registering
+	  a legacy backlight class device. Leave this disabled to preserve the
+	  de-facto userspace ABI in /sys/class/backlight.
+
+	  If in doubt, say N.
+
 config DRM_MIPI_DBI
 	tristate
 	depends on DRM
diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 9d006f98413a5..1e9b7b8acccfe 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -1375,6 +1375,8 @@ EXPORT_SYMBOL(drm_atomic_helper_commit_encoder_bridge_post_disable);
 static void
 disable_outputs(struct drm_device *dev, struct drm_atomic_commit *state)
 {
+	drm_atomic_helper_commit_luminance_disables(state);
+
 	drm_atomic_helper_commit_encoder_bridge_disable(dev, state);
 
 	drm_atomic_helper_commit_encoder_bridge_post_disable(dev, state);
@@ -1382,6 +1384,45 @@ disable_outputs(struct drm_device *dev, struct drm_atomic_commit *state)
 	drm_atomic_helper_commit_crtc_disable(dev, state);
 }
 
+/**
+ * drm_atomic_helper_commit_luminance_disables - disable panel emission
+ * @state: atomic state object being committed
+ *
+ * Invokes each connector driver's luminance disable callback before a
+ * display pipeline is disabled. The connector property's stored value is left
+ * untouched so it can be restored when the pipeline is enabled again.
+ */
+void drm_atomic_helper_commit_luminance_disables(struct drm_atomic_commit *state)
+{
+	struct drm_connector_state *old_conn_state, *new_conn_state;
+	struct drm_connector *connector;
+	int i;
+
+	for_each_oldnew_connector_in_state(state, connector, old_conn_state,
+					   new_conn_state, i) {
+		const struct drm_connector_helper_funcs *funcs;
+		struct drm_crtc_state *old_crtc_state, *new_crtc_state = NULL;
+
+		if (!connector->luminance_property || !old_conn_state->crtc)
+			continue;
+
+		old_crtc_state =
+			drm_atomic_get_old_crtc_state(state, old_conn_state->crtc);
+		if (new_conn_state->crtc)
+			new_crtc_state =
+				drm_atomic_get_new_crtc_state(state, new_conn_state->crtc);
+
+		if (!crtc_needs_disable(old_crtc_state, new_crtc_state) ||
+		    !drm_atomic_crtc_needs_modeset(old_conn_state->crtc->state))
+			continue;
+
+		funcs = connector->helper_private;
+		if (funcs && funcs->disable_luminance)
+			funcs->disable_luminance(old_conn_state);
+	}
+}
+EXPORT_SYMBOL(drm_atomic_helper_commit_luminance_disables);
+
 /**
  * drm_atomic_helper_update_legacy_modeset_state - update legacy modeset state
  * @dev: DRM device
@@ -1771,10 +1812,41 @@ void drm_atomic_helper_commit_modeset_enables(struct drm_device *dev,
 
 	drm_atomic_helper_commit_encoder_bridge_enable(dev, state);
 
+	drm_atomic_helper_commit_luminance_enables(state);
+
 	drm_atomic_helper_commit_writebacks(dev, state);
 }
 EXPORT_SYMBOL(drm_atomic_helper_commit_modeset_enables);
 
+/**
+ * drm_atomic_helper_commit_luminance_enables - apply luminance
+ * @state: atomic state object being committed
+ *
+ * Invokes each connector driver's luminance callback after the display
+ * pipeline has been enabled. The callback is also invoked for brightness-only
+ * commits while the connector remains active. Changes committed while the
+ * connector is inactive remain stored in atomic state until a later enable.
+ */
+void drm_atomic_helper_commit_luminance_enables(struct drm_atomic_commit *state)
+{
+	struct drm_connector_state *new_conn_state;
+	struct drm_connector *connector;
+	int i;
+
+	for_each_new_connector_in_state(state, connector, new_conn_state, i) {
+		const struct drm_connector_helper_funcs *funcs;
+
+		if (!connector->luminance_property || !new_conn_state->crtc ||
+		    !new_conn_state->crtc->state->active)
+			continue;
+
+		funcs = connector->helper_private;
+		if (funcs && funcs->set_luminance)
+			funcs->set_luminance(new_conn_state);
+	}
+}
+EXPORT_SYMBOL(drm_atomic_helper_commit_luminance_enables);
+
 /*
  * For atomic updates which touch just a single CRTC, calculate the time of the
  * next vblank, and inform all the fences of the deadline.
@@ -4187,4 +4259,3 @@ drm_atomic_helper_bridge_get_hdmi_output_bus_fmts(struct drm_bridge *bridge,
 	return out_fmts;
 }
 EXPORT_SYMBOL(drm_atomic_helper_bridge_get_hdmi_output_bus_fmts);
-
diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
index 406157a3660fd..5c31bf2bdbe76 100644
--- a/drivers/gpu/drm/drm_atomic_state_helper.c
+++ b/drivers/gpu/drm/drm_atomic_state_helper.c
@@ -408,7 +408,14 @@ void
 __drm_atomic_helper_connector_state_init(struct drm_connector_state *conn_state,
 					 struct drm_connector *connector)
 {
+	u64 value;
+
 	conn_state->connector = connector;
+	if (connector->luminance_property &&
+	    !drm_object_property_get_default_value(&connector->base,
+						   connector->luminance_property,
+						   &value))
+		conn_state->luminance = value;
 }
 EXPORT_SYMBOL(__drm_atomic_helper_connector_state_init);
 
diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 1eebcf6f5e05b..dffc51cd8d13c 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -30,6 +30,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_atomic_uapi.h>
+#include <drm/drm_connector.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_print.h>
 #include <drm/drm_drv.h>
@@ -969,6 +970,8 @@ static int drm_atomic_connector_set_property(struct drm_connector *connector,
 		state->hdmi.broadcast_rgb = val;
 	} else if (property == connector->color_format_property) {
 		state->color_format = val;
+	} else if (property == connector->luminance_property) {
+		state->luminance = val;
 	} else if (connector->funcs->atomic_set_property) {
 		return connector->funcs->atomic_set_property(connector,
 				state, property, val);
@@ -1056,6 +1059,8 @@ drm_atomic_connector_get_property(struct drm_connector *connector,
 		*val = state->hdmi.broadcast_rgb;
 	} else if (property == connector->color_format_property) {
 		*val = state->color_format;
+	} else if (property == connector->luminance_property) {
+		*val = state->luminance;
 	} else if (connector->funcs->atomic_get_property) {
 		return connector->funcs->atomic_get_property(connector,
 				state, property, val);
diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index d94c86bfed866..2e433f76f467a 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -810,6 +810,47 @@ void drm_connector_attach_edid_property(struct drm_connector *connector)
 }
 EXPORT_SYMBOL(drm_connector_attach_edid_property);
 
+/**
+ * drm_connector_attach_luminance_property - attach luminance property
+ * @connector: connector to attach the property to
+ * @min: minimum supported relative brightness
+ * @max: maximum supported relative brightness
+ * @value: initial relative brightness
+ *
+ * Creates the atomic ``LUMINANCE`` range property for @connector.
+ * Drivers should call this during connector initialization. The property's
+ * units are driver-defined; they do not represent absolute luminance.
+ *
+ * Returns:
+ * Zero on success, a negative errno otherwise.
+ */
+int drm_connector_attach_luminance_property(struct drm_connector *connector,
+					    unsigned int min,
+					    unsigned int max,
+					    unsigned int value)
+{
+	struct drm_property *property;
+
+	if (drm_WARN_ON(connector->dev, min > max || value < min || value > max))
+		return -EINVAL;
+
+	if (connector->luminance_property)
+		return 0;
+
+	property = drm_property_create_range(connector->dev, DRM_MODE_PROP_ATOMIC,
+					     "LUMINANCE", min, max);
+	if (!property)
+		return -ENOMEM;
+
+	connector->luminance_property = property;
+	drm_object_attach_property(&connector->base, property, value);
+	if (connector->state)
+		connector->state->luminance = value;
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_connector_attach_luminance_property);
+
 /**
  * drm_connector_attach_encoder - attach a connector to an encoder
  * @connector: connector to attach
@@ -1681,6 +1722,22 @@ EXPORT_SYMBOL(drm_hdmi_connector_get_output_format_name);
  * 	Summarizing: Only set "DPMS" when the connector is known to be enabled,
  * 	assume that a successful SETCONFIG call also sets "DPMS" to on, and
  * 	never read back the value of "DPMS" because it can be incorrect.
+ * LUMINANCE:
+ *     Atomic range property for controlling a panel's relative luminance.
+ *     The unit and range are driver-defined and do not represent an absolute
+ *     luminance in cd/m^2. This name therefore also applies to emissive panels
+ *     that do not contain a separate backlight.
+ *
+ *     The property is independent of the connector's display-power state.
+ *     Changing it while the connector is inactive stores the new value without
+ *     turning the display on. The atomic helpers apply the stored value after
+ *     the display pipeline is enabled and invoke a separate driver callback
+ *     before disabling the pipeline; neither action changes the property value.
+ *
+ *     Drivers create the property with
+ *     drm_connector_attach_luminance_property() and implement the
+ *     corresponding &drm_connector_helper_funcs callbacks. Connectors that do
+ *     not support luminance control do not expose the property.
  * panel_type:
  * 	Immutable enum property to indicate the type of connected panel.
  * 	Possible values are "unknown" (default), "OLED", and "LCD".
diff --git a/drivers/gpu/drm/tests/drm_connector_test.c b/drivers/gpu/drm/tests/drm_connector_test.c
index 3368aedd4e669..e43692d38ebb8 100644
--- a/drivers/gpu/drm/tests/drm_connector_test.c
+++ b/drivers/gpu/drm/tests/drm_connector_test.c
@@ -137,6 +137,33 @@ static void drm_test_drmm_connector_init_null_ddc(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, ret, 0);
 }
 
+static void drm_test_connector_attach_luminance_property(struct kunit *test)
+{
+	struct drm_connector_init_priv *priv = test->priv;
+	struct drm_connector *connector = &priv->connector;
+	struct drm_property *property;
+	u64 value;
+	int ret;
+
+	ret = drmm_connector_init(&priv->drm, connector, &dummy_funcs,
+				  DRM_MODE_CONNECTOR_eDP, NULL);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_ASSERT_NULL(test, connector->state);
+
+	ret = drm_connector_attach_luminance_property(connector, 10, 100, 50);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	property = connector->luminance_property;
+	KUNIT_ASSERT_NOT_NULL(test, property);
+
+	ret = drm_object_property_get_default_value(&connector->base, property, &value);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, value, (u64)50);
+
+	drm_atomic_helper_connector_reset(connector);
+	KUNIT_ASSERT_NOT_NULL(test, connector->state);
+	KUNIT_EXPECT_EQ(test, connector->state->luminance, 50u);
+}
+
 /*
  * Test that the registration of a connector succeeds for all possible
  * connector types.
@@ -190,6 +217,7 @@ KUNIT_ARRAY_PARAM(drm_connector_init_type_valid,
 static struct kunit_case drmm_connector_init_tests[] = {
 	KUNIT_CASE(drm_test_drmm_connector_init),
 	KUNIT_CASE(drm_test_drmm_connector_init_null_ddc),
+	KUNIT_CASE(drm_test_connector_attach_luminance_property),
 	KUNIT_CASE_PARAM(drm_test_drmm_connector_init_type_valid,
 			 drm_connector_init_type_valid_gen_params),
 	{ }
diff --git a/include/drm/drm_atomic_helper.h b/include/drm/drm_atomic_helper.h
index 4cfeec70d648a..3084dd5cd6a1f 100644
--- a/include/drm/drm_atomic_helper.h
+++ b/include/drm/drm_atomic_helper.h
@@ -116,6 +116,9 @@ void drm_atomic_helper_commit_encoder_bridge_enable(struct drm_device *dev,
 void drm_atomic_helper_commit_modeset_enables(struct drm_device *dev,
 					  struct drm_atomic_commit *old_state);
 
+void drm_atomic_helper_commit_luminance_disables(struct drm_atomic_commit *state);
+void drm_atomic_helper_commit_luminance_enables(struct drm_atomic_commit *state);
+
 int drm_atomic_helper_prepare_planes(struct drm_device *dev,
 				     struct drm_atomic_commit *state);
 void drm_atomic_helper_unprepare_planes(struct drm_device *dev,
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 2ee7c59329aae..7f7d115b65f9f 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1369,6 +1369,11 @@ struct drm_connector_state {
 	 * @drm_atomic_helper_connector_hdmi_check().
 	 */
 	struct drm_connector_hdmi_state hdmi;
+
+	/**
+	 * @luminance: Relative panel luminance requested by userspace.
+	 */
+	unsigned int luminance;
 };
 
 struct drm_connector_hdmi_audio_funcs {
@@ -2714,6 +2719,13 @@ struct drm_connector {
 	 * @cec: CEC-related data.
 	 */
 	struct drm_connector_cec cec;
+
+	/**
+	 * @luminance_property: Optional atomic range property for relative panel
+	 * luminance. Drivers create it with
+	 * drm_connector_attach_luminance_property().
+	 */
+	struct drm_property *luminance_property;
 };
 
 #define obj_to_connector(x) container_of(x, struct drm_connector, base)
@@ -2980,6 +2992,10 @@ const char *drm_get_colorspace_name(enum drm_colorspace colorspace);
 
 int drm_connector_attach_color_format_property(struct drm_connector *connector,
 					       unsigned long supported_color_formats);
+int drm_connector_attach_luminance_property(struct drm_connector *connector,
+					    unsigned int min,
+					    unsigned int max,
+					    unsigned int value);
 
 /**
  * drm_for_each_connector_iter - connector_list iterator macro
diff --git a/include/drm/drm_modeset_helper_vtables.h b/include/drm/drm_modeset_helper_vtables.h
index 60b30cc269404..cecacc1755a36 100644
--- a/include/drm/drm_modeset_helper_vtables.h
+++ b/include/drm/drm_modeset_helper_vtables.h
@@ -1147,6 +1147,31 @@ struct drm_connector_helper_funcs {
 	void (*atomic_commit)(struct drm_connector *connector,
 			      struct drm_atomic_commit *state);
 
+	/**
+	 * @set_luminance:
+	 *
+	 * Apply &drm_connector_state.luminance to an active panel. The
+	 * atomic helpers call this after enabling the display pipeline and for
+	 * brightness-only commits while the connector remains active.
+	 *
+	 * This callback is optional and is only used by connectors exposing the
+	 * ``LUMINANCE`` property.
+	 */
+	void (*set_luminance)(const struct drm_connector_state *new_state);
+
+	/**
+	 * @disable_luminance:
+	 *
+	 * Turn panel light emission off before disabling the display pipeline.
+	 * This callback does not change the ``LUMINANCE`` property; the
+	 * stored value is restored through @set_luminance when the panel
+	 * is enabled again.
+	 *
+	 * This callback is optional and is only used by connectors exposing the
+	 * ``LUMINANCE`` property.
+	 */
+	void (*disable_luminance)(const struct drm_connector_state *old_state);
+
 	/**
 	 * @prepare_writeback_job:
 	 *
-- 
2.43.0

