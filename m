Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 874A1CA5FE6
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 19:01:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB2D810F9AC;
	Fri,  2 Oct 2026 19:01:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y3Mp0hza";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010005.outbound.protection.outlook.com
 [52.101.193.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B525D10F9A1;
 Fri,  2 Oct 2026 19:01:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bDyqyC3lbrh3xB1hYcQIyX1ZuhGVtaNk6Kw6y3dcxK4zgcgPpN63EG1kfVvL8YYCBshMYg1gFGjdRXb68QQLhOR9FmwqOoJznQrQvg3yuZnWQkPe8GRA395d5ondwrTMy+ANtf4q6VbU99QqPEB288oDdydAhzfLo+26ulsYCv0Si/nsj0u01QGcR4ZNMRGLFcl62O5lKascArCTSn8hctOCnWP1DW4ZmXVJDo5fOiqleuDFIQwar9ZF26QfHIRLCAqqURyPkGsSGVVTrmLzebNryuqKjBxcSUeHfczADB81VzUcb95cbDigz4BCDlejsCoAAZUBnoslU9cpY4HBxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kbGM5PBfODl/eNPNLzA/tojM+yS5w3jhEJgXGQKIDVw=;
 b=AcJoLPtupFPtD8UFyZUMcg0bNoC7hLuysqkVgJk7kFFBa2NTGqXrmmEiwN34sVtQmAI3iEwwm/BmYdQZNPCUicoRXliafozk9t+zGpevuLX+64sr4k9QL8CToAq5hkqRcPzvL5Ntu0CYG7wso9czErtu06Oj0EkdTqVfyrESi/9waeg468c+8mj5TDim99Cd8+Fqhls4/Vh2W6N96blX06e7Muo1EPD7vF3hbWb9iDPzJf9tWhe0UZdRPAgj9PTbMP8yS13hD4dmJZky1C6pOPOJPmG3EU00EnDpyl2z1ZKHelGMyoLqa197hmO7ypzWNqR/pxILlTLaEzdbf224Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbGM5PBfODl/eNPNLzA/tojM+yS5w3jhEJgXGQKIDVw=;
 b=Y3Mp0hzamPvSMlOrnvYAMbyPW7uqIAEc56k0fHmHW8M3RJUIdNA2PSIqEOaEOhMk16wEa0eHPRr83QV6mfQHTS896mJcWFStYRznc3hFtKDbp/tdgtO4wpLrsqbXRBvKatIc++0oijOEP3VkOW1VDeCfv7f2rdlIrCc/zzL94DA=
Received: from MW4PR03CA0020.namprd03.prod.outlook.com (2603:10b6:303:8f::25)
 by PH0PR12MB8030.namprd12.prod.outlook.com (2603:10b6:510:28d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Fri, 2 Oct
 2026 19:01:12 +0000
Received: from MW1PEPF0001615D.namprd21.prod.outlook.com
 (2603:10b6:303:8f:cafe::f) by MW4PR03CA0020.outlook.office365.com
 (2603:10b6:303:8f::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.17 via Frontend Transport; Fri, 2
 Oct 2026 19:01:12 +0000
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
 15.21.496.3 via Frontend Transport; Fri, 2 Oct 2026 19:01:12 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 14:01:10 -0500
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
Subject: [PATCH v9 07/21] drm: add panel and bridge connector luminance
 forwarding
Date: Fri, 2 Oct 2026 14:00:16 -0500
Message-ID: <20261002190030.211356-8-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615D:EE_|PH0PR12MB8030:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b21e2e2-8357-47de-873c-08df20b786f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|7416014|23010399003|1800799024|376014|82310400026|22082099003|18002099003|6133799003|3023799007|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: iBNqc+T/3zrdYUy8NSNY0CqHIncps/nUlWUmCs0WxWKt0U7EeltBxvHdVmPeueyEG6QPyTsDUVL5egFcpmJyP1sjIsHl9U3LieVZjq8huNzjzH53H3VAdTU7rmMuGHMrKajjhMn50jHFq8jyrydwis9fE5GUHdATa4dI9vWnoA8GwcSLVnQlE7XpQ8i1qJ9zol+GgxBtNHJUbS74LAJnhn48LM75w0wLbIuuqVAu14JQ/Eua8PjQoMoZNEJQ3Y6C+rsVRCk8Ve8qkksocDGp62I7lxha3mzGucv4n+UUDw07r4MFhyUkiqJl/oTSJ9RkJ1KqV5DdIspI2At2pzH3sHRLuFgh1YM8hEe5N3EbP+DVkAYK349KobakvOsD0d6JtFdLNBnu5X7stPfj2tWJwolp0q4sGVhbST/f2M/SZimmKhAw+CPtUs+XtF+WMuSNxSVYTCBUky4+kqyinaJLId1RPzeh6fPQr5qPspv8X9b0AguPOdx/voOWnN8Hmwt+3dyq4lHbMhOJqdKPgvxqM+/TNoFGAFtYQnE2sPKDDlcdm7NXxsQNnq/Q0XCnpUMD2PBdAja27C0Y2oQdouZqCrEJ152c6UEn53vt8nNvuUHO9kHt//rhE8SAKZDjL/EhVYx76GMKg7dz5bEYZd7RvFxPS/2JxyXeNh9SogGQqTkwlM5QVxG++SurK5wW9bH3QDgHkDNdeuoXr1ewVMx1Tw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(7416014)(23010399003)(1800799024)(376014)(82310400026)(22082099003)(18002099003)(6133799003)(3023799007)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4tvBLj24r9JIRY6RkHNH0Y+TT8hZY9BDa4L/blD2ta9v5XigaaA5Ucj0IE1eU5uO9xOCXiwXNLcDvGRADNNWWUSYM2P7XCR8ckeJn18xj4sJpd5eCC+1xQhblWQ4D/r57FMAOswxxqK9V27D259P534BtlP7J0fD92ot6ShFMew83l3Y74d3n6ipIaWiVpUPlW3dlTxjpX8HfY609vXdTYUjlxMqQISoJRUuIhDd94YT2adDr+UPY6Gaz9chTNxxHLNrSRT8jaJt0LVKFhgfMlfzfPJVYpVzj481Zr4d6E9fhTtS9wZdRtoBqNM50VK/Vi7UlFuB/2iSPHqYeCEn2b9nkVZONcE0VyrBvnZUdxtOp83Dxyr4OrJcguPEIcKk8VDYmSkxVMAwz9ZTX7fxKmW1TRM/6kqGOg7FZtWZj13YimxCO08UiWp05Dq0hBmX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 19:01:12.3881 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b21e2e2-8357-47de-873c-08df20b786f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF0001615D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8030
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

Forward connector luminance operations through panel and bridge connectors.
Allow bridges that own brightness control to expose luminance operations,
and route panel bridges to the panel backlight backend.

Attach the property only when a usable brightness backend is present and
CONFIG_DRM_LUMINANCE is enabled.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/bridge/panel.c                | 39 +++++++++++
 .../gpu/drm/display/drm_bridge_connector.c    | 65 +++++++++++++++++++
 drivers/gpu/drm/drm_panel.c                   | 55 ++++++++++++++++
 include/drm/drm_bridge.h                      | 26 ++++++++
 include/drm/drm_panel.h                       |  5 ++
 5 files changed, 190 insertions(+)

diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
index 02388a3de626e..e447b959cf407 100644
--- a/drivers/gpu/drm/bridge/panel.c
+++ b/drivers/gpu/drm/bridge/panel.c
@@ -45,9 +45,29 @@ static int panel_bridge_connector_get_modes(struct drm_connector *connector)
 	return drm_panel_get_modes(panel_bridge->panel, connector);
 }
 
+static void
+panel_bridge_connector_set_luminance(const struct drm_connector_state *conn_state)
+{
+	struct panel_bridge *panel_bridge =
+		drm_connector_to_panel_bridge(conn_state->connector);
+
+	drm_panel_set_luminance(panel_bridge->panel, conn_state->luminance);
+}
+
+static void
+panel_bridge_connector_disable_luminance(const struct drm_connector_state *conn_state)
+{
+	struct panel_bridge *panel_bridge =
+		drm_connector_to_panel_bridge(conn_state->connector);
+
+	drm_panel_disable_luminance(panel_bridge->panel);
+}
+
 static const struct drm_connector_helper_funcs
 panel_bridge_connector_helper_funcs = {
 	.get_modes = panel_bridge_connector_get_modes,
+	.set_luminance = panel_bridge_connector_set_luminance,
+	.disable_luminance = panel_bridge_connector_disable_luminance,
 };
 
 static const struct drm_connector_funcs panel_bridge_connector_funcs = {
@@ -82,6 +102,10 @@ static int panel_bridge_attach(struct drm_bridge *bridge,
 
 	drm_panel_bridge_set_orientation(connector, bridge);
 
+	ret = drm_panel_attach_luminance_property(panel_bridge->panel, connector);
+	if (ret)
+		return ret;
+
 	drm_connector_attach_encoder(&panel_bridge->connector,
 					  encoder);
 
@@ -233,6 +257,21 @@ bool drm_bridge_is_panel(const struct drm_bridge *bridge)
 }
 EXPORT_SYMBOL(drm_bridge_is_panel);
 
+/**
+ * drm_panel_bridge_to_panel - return the panel wrapped by a panel bridge
+ * @bridge: panel bridge
+ *
+ * Return: the wrapped panel, or %NULL if @bridge isn't a panel bridge
+ */
+struct drm_panel *drm_panel_bridge_to_panel(struct drm_bridge *bridge)
+{
+	if (!drm_bridge_is_panel(bridge))
+		return NULL;
+
+	return drm_bridge_to_panel_bridge(bridge)->panel;
+}
+EXPORT_SYMBOL(drm_panel_bridge_to_panel);
+
 /**
  * drm_panel_bridge_add - Creates a &drm_bridge and &drm_connector that
  * just calls the appropriate functions from &drm_panel.
diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index 707d7143e475f..99c83b1acbe5a 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -18,6 +18,7 @@
 #include <drm/drm_edid.h>
 #include <drm/drm_managed.h>
 #include <drm/drm_modeset_helper_vtables.h>
+#include <drm/drm_panel.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/display/drm_hdcp_helper.h>
@@ -123,6 +124,18 @@ struct drm_bridge_connector {
 	 * DRM_BRIDGE_OP_HDMI_CEC_NOTIFIER).
 	 */
 	struct drm_bridge *bridge_hdmi_cec;
+	/**
+	 * @bridge_luminance:
+	 *
+	 * The last bridge in the chain that controls panel luminance.
+	 */
+	struct drm_bridge *bridge_luminance;
+	/**
+	 * @panel:
+	 *
+	 * The panel at the end of the bridge chain, if any.
+	 */
+	struct drm_panel *panel;
 
 	/**
 	 * @hdmi_funcs:
@@ -420,6 +433,30 @@ static int drm_bridge_connector_atomic_check(struct drm_connector *connector,
 	return 0;
 }
 
+static void
+drm_bridge_connector_set_luminance(const struct drm_connector_state *conn_state)
+{
+	struct drm_bridge_connector *bridge_connector =
+		to_drm_bridge_connector(conn_state->connector);
+
+	drm_panel_set_luminance(bridge_connector->panel, conn_state->luminance);
+	if (bridge_connector->bridge_luminance)
+		bridge_connector->bridge_luminance->funcs->set_luminance
+			(bridge_connector->bridge_luminance, conn_state->luminance);
+}
+
+static void
+drm_bridge_connector_disable_luminance(const struct drm_connector_state *conn_state)
+{
+	struct drm_bridge_connector *bridge_connector =
+		to_drm_bridge_connector(conn_state->connector);
+
+	drm_panel_disable_luminance(bridge_connector->panel);
+	if (bridge_connector->bridge_luminance)
+		bridge_connector->bridge_luminance->funcs->set_luminance
+			(bridge_connector->bridge_luminance, 0);
+}
+
 static const struct drm_connector_helper_funcs drm_bridge_connector_helper_funcs = {
 	.get_modes = drm_bridge_connector_get_modes,
 	.detect_ctx = drm_bridge_connector_detect_ctx,
@@ -428,6 +465,8 @@ static const struct drm_connector_helper_funcs drm_bridge_connector_helper_funcs
 	.enable_hpd = drm_bridge_connector_enable_hpd,
 	.disable_hpd = drm_bridge_connector_disable_hpd,
 	.atomic_check = drm_bridge_connector_atomic_check,
+	.set_luminance = drm_bridge_connector_set_luminance,
+	.disable_luminance = drm_bridge_connector_disable_luminance,
 };
 
 static enum drm_mode_status
@@ -834,6 +873,7 @@ static void drm_bridge_connector_put_bridges(struct drm_device *dev, void *data)
 	drm_bridge_put(bridge_connector->bridge_hdmi_audio);
 	drm_bridge_put(bridge_connector->bridge_dp_audio);
 	drm_bridge_put(bridge_connector->bridge_hdmi_cec);
+	drm_bridge_put(bridge_connector->bridge_luminance);
 }
 
 /**
@@ -917,6 +957,13 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 			drm_bridge_put(bridge_connector->bridge_detect);
 			bridge_connector->bridge_detect = drm_bridge_get(bridge);
 		}
+		if (bridge->ops & DRM_BRIDGE_OP_LUMINANCE) {
+			if (!bridge->funcs->set_luminance)
+				return ERR_PTR(-EINVAL);
+
+			drm_bridge_put(bridge_connector->bridge_luminance);
+			bridge_connector->bridge_luminance = drm_bridge_get(bridge);
+		}
 		if (bridge->ops & DRM_BRIDGE_OP_HDMI) {
 			if (bridge_connector->bridge_hdmi)
 				return ERR_PTR(-EBUSY);
@@ -1143,6 +1190,24 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 	if (panel_bridge)
 		drm_panel_bridge_set_orientation(connector, panel_bridge);
 
+	if (panel_bridge) {
+		bridge_connector->panel = drm_panel_bridge_to_panel(panel_bridge);
+		ret = drm_panel_attach_luminance_property(bridge_connector->panel,
+							  connector);
+		if (ret)
+			return ERR_PTR(ret);
+	}
+
+	if (bridge_connector->bridge_luminance && !connector->luminance_property) {
+		struct drm_bridge *bridge = bridge_connector->bridge_luminance;
+
+		ret = drm_connector_attach_luminance_property(connector, 0,
+							      bridge->luminance_max,
+							     bridge->luminance);
+		if (ret)
+			return ERR_PTR(ret);
+	}
+
 	if (support_hdcp && IS_REACHABLE(CONFIG_DRM_DISPLAY_HELPER) &&
 	    IS_ENABLED(CONFIG_DRM_DISPLAY_HDCP_HELPER))
 		drm_connector_attach_content_protection_property(connector, true);
diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index f8f6082e637fd..25355748009a4 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -341,6 +341,61 @@ void drm_panel_disable(struct drm_panel *panel)
 }
 EXPORT_SYMBOL(drm_panel_disable);
 
+/**
+ * drm_panel_attach_luminance_property - expose a panel backlight through DRM
+ * @panel: panel whose backlight is controlled
+ * @connector: connector on which to expose the property
+ *
+ * The backlight class device remains the internal hardware backend. When the
+ * luminance UAPI is enabled, userspace controls that backend through the DRM
+ * connector property instead.
+ *
+ * Return: 0 on success or a negative error code
+ */
+int drm_panel_attach_luminance_property(struct drm_panel *panel,
+					struct drm_connector *connector)
+{
+	struct backlight_device *backlight;
+
+	if (!IS_ENABLED(CONFIG_DRM_LUMINANCE) || !panel)
+		return 0;
+
+	backlight = panel->backlight;
+	if (!backlight)
+		return 0;
+
+	return drm_connector_attach_luminance_property(connector, 0,
+					backlight->props.max_brightness,
+					backlight->props.brightness);
+}
+EXPORT_SYMBOL(drm_panel_attach_luminance_property);
+
+/**
+ * drm_panel_set_luminance - set a panel backlight's relative luminance
+ * @panel: panel whose backlight is controlled
+ * @luminance: relative luminance level
+ */
+void drm_panel_set_luminance(struct drm_panel *panel, unsigned int luminance)
+{
+	if (!panel || !panel->backlight)
+		return;
+
+	panel->backlight->props.brightness = luminance;
+	backlight_update_status(panel->backlight);
+}
+EXPORT_SYMBOL(drm_panel_set_luminance);
+
+/**
+ * drm_panel_disable_luminance - turn off a panel backlight
+ * @panel: panel whose backlight is controlled
+ */
+void drm_panel_disable_luminance(struct drm_panel *panel)
+{
+	if (panel)
+		backlight_disable(panel->backlight);
+}
+EXPORT_SYMBOL(drm_panel_disable_luminance);
+
 /**
  * drm_panel_get_modes - probe the available display modes of a panel
  * @panel: DRM panel
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 77b3ffe692304..56511d4ded55a 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -62,6 +62,15 @@ enum drm_bridge_attach_flags {
  * struct drm_bridge_funcs - drm_bridge control functions
  */
 struct drm_bridge_funcs {
+	/**
+	 * @set_luminance:
+	 *
+	 * Apply a relative luminance level to a bridge that controls panel
+	 * emission. Bridges implementing this callback shall set
+	 * @DRM_BRIDGE_OP_LUMINANCE.
+	 */
+	void (*set_luminance)(struct drm_bridge *bridge, unsigned int luminance);
+
 	/**
 	 * @attach:
 	 *
@@ -1021,6 +1030,11 @@ enum drm_bridge_ops {
 	 * &drm_bridge_funcs->hdmi_clear_spd_infoframe callbacks.
 	 */
 	DRM_BRIDGE_OP_HDMI_SPD_INFOFRAME = BIT(10),
+
+	/**
+	 * @DRM_BRIDGE_OP_LUMINANCE: The bridge controls panel luminance.
+	 */
+	DRM_BRIDGE_OP_LUMINANCE = BIT(11),
 };
 
 /**
@@ -1071,6 +1085,12 @@ struct drm_bridge {
 	void *driver_private;
 	/** @ops: bitmask of operations supported by the bridge */
 	enum drm_bridge_ops ops;
+
+	/** @luminance_max: Maximum relative luminance level. */
+	unsigned int luminance_max;
+
+	/** @luminance: Current relative luminance level. */
+	unsigned int luminance;
 	/**
 	 * @type: Type of the connection at the bridge output
 	 * (DRM_MODE_CONNECTOR_*). For bridges at the end of this chain this
@@ -1530,6 +1550,7 @@ struct drm_bridge *drm_panel_bridge_add_typed(struct drm_panel *panel,
 void drm_panel_bridge_remove(struct drm_bridge *bridge);
 int drm_panel_bridge_set_orientation(struct drm_connector *connector,
 				     struct drm_bridge *bridge);
+struct drm_panel *drm_panel_bridge_to_panel(struct drm_bridge *bridge);
 struct drm_bridge *devm_drm_panel_bridge_add(struct device *dev,
 					     struct drm_panel *panel);
 struct drm_bridge *devm_drm_panel_bridge_add_typed(struct device *dev,
@@ -1549,6 +1570,11 @@ static inline int drm_panel_bridge_set_orientation(struct drm_connector *connect
 {
 	return -EINVAL;
 }
+
+static inline struct drm_panel *drm_panel_bridge_to_panel(struct drm_bridge *bridge)
+{
+	return NULL;
+}
 #endif
 
 #if defined(CONFIG_OF) && defined(CONFIG_DRM_PANEL_BRIDGE)
diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
index b87323443f49c..dfd225ba05c8d 100644
--- a/include/drm/drm_panel.h
+++ b/include/drm/drm_panel.h
@@ -333,6 +333,11 @@ void drm_panel_unprepare(struct drm_panel *panel);
 void drm_panel_enable(struct drm_panel *panel);
 void drm_panel_disable(struct drm_panel *panel);
 
+int drm_panel_attach_luminance_property(struct drm_panel *panel,
+					struct drm_connector *connector);
+void drm_panel_set_luminance(struct drm_panel *panel, unsigned int luminance);
+void drm_panel_disable_luminance(struct drm_panel *panel);
+
 int drm_panel_get_modes(struct drm_panel *panel, struct drm_connector *connector);
 
 #if defined(CONFIG_OF) && defined(CONFIG_DRM_PANEL)
-- 
2.43.0

