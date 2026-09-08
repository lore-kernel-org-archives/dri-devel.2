Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3911FC79F99
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 04:41:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D903B10E9C9;
	Tue,  8 Sep 2026 04:41:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2Oi33wDo";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012034.outbound.protection.outlook.com
 [40.93.195.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8343010E9C8;
 Tue,  8 Sep 2026 04:41:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GtIyh2cX9GHawiITGFiNvopLXyP2N1M4wzUGNGfBlTEi5Qai/CFbD6cSy02e5XvSGghjUBJga7JKN4o495XOJOu8jRLMZwFjqhrUCkKbdc5cHeltK35rhyeK2oGUDzyv7Pawp1h7TSddSlU1GfkamNg+E1PVhM9a5bi+2MWuQMJL5lFgNi76vXeOA3fqxgXNg8dNhPb/vdjOpkMtbavTWxPcwcOho9+o1u40ndEopcTE+Qj3ZDR6jKGL6XukhkOe/es/A1V19ZVpgd+Jmc+ccTDKrO5hiAKqSmLkJGY6OdkHB/zs9QMd6YqerG9stoV36REIrKC0ZsaeBodH+5LJVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tuR39l//eSsUelrdRamkE6Ec+i1NxAFb8MiN1pXdcYY=;
 b=MbG0WUErcOFVDjIx2sRyiIRtj+XWFnPWuC0LgDU75x+oEam/87zn8FGDfzAMS+lxz57uGKBaMs9kXpOveN7rJ1Qq42VlyCPMGMdWuwk9v5/Tuy9maKYRlYdUrcFSzBSEVLhopT469OOR5ZMoVJjjIW+WS6gtjjSVRA6Y2VbB9I70ixRn66IwO+210lLrhnP5Ivvv9ISMEJ4vtusB5HpL8tcJoRu/IXXNwffRur2JEh6jPVKB5FCt287eNU6/Rjr9fuj0GGU7CN+i5+AZ8lOUwDQAwdQu+tQ0Pa7yjsefYLj2Ok09zFcCNlCzxXKjxgRDyr2Mlv91AIK0yoErizCeWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tuR39l//eSsUelrdRamkE6Ec+i1NxAFb8MiN1pXdcYY=;
 b=2Oi33wDo8p8aTKJrxull00rV1o+nLKLKpz1l5wYQik9iu2GvINjYNgUIrcUtnNhCo75Cp8RYwm8Lhsg55tAGWKjDQASYA/KY+Bjq28g35PSDXvPJvzYrFA8F2ONg4L6Hcu6nE0p7mkFRRcwlEzyN0XL12zB0DIJg9rfqCEqE3+g=
Received: from CYXPR03CA0033.namprd03.prod.outlook.com (2603:10b6:930:d2::10)
 by CH2PR12MB4261.namprd12.prod.outlook.com (2603:10b6:610:a9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 8 Sep
 2026 04:41:08 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:930:d2:cafe::72) by CYXPR03CA0033.outlook.office365.com
 (2603:10b6:930:d2::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 04:41:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 04:41:08 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 23:41:06 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <dri-devel@lists.freedesktop.org>, <harry.wentland@amd.com>, Simona Vetter
 <simona@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>
CC: Xaver Hugl <xaver.hugl@gmail.com>, <amd-gfx@lists.freedesktop.org>, "open
 list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-gfx@lists.freedesktop.org>, "open list:INTEL DRM DISPLAY FOR XE AND
 I915 DRIVERS" <intel-xe@lists.freedesktop.org>, Hans de Goede
 <hansg@kernel.org>, Mario Limonciello <mario.limonciello@amd.com>, "Mario
 Limonciello" <superm1@kernel.org>
Subject: [PATCH v8 11/14] drm/bridge: auto-link panel backlight in bridge
 connector
Date: Mon, 7 Sep 2026 23:40:32 -0500
Message-ID: <20260908044035.62093-12-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908044035.62093-1-mario.limonciello@amd.com>
References: <20260908044035.62093-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|CH2PR12MB4261:EE_
X-MS-Office365-Filtering-Correlation-Id: caaf5a2b-771b-4674-db7f-08df0d63667a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|376014|7416014|1800799024|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: deC9YlUpTKDReYf8SpVmk8Y/NxHukMD/joJJ7azriINV6yor2WK1oF07fI5g0OWKHZGnigVdWSaK5kFoy6kFeMH/g4D+vy91hWbHFrO568aXyQqDtwd+jN12JDXq4+LacXkvUyL7/x/qaDM/+Vx7I+8fcJ9kvblVOFQUWG4qL/nMjoBvCzllu1kyvnbEmxXA+rFo/e181d4P0hBGV5DK8VTpP6YP4BC7/TQQJPkrglQaygM5cVd9FisH9VNtj1Fcf68pq4/SgUqikZI5AIWYaD+vlIeB3a4mEcKdZQ6YmgttVMZTbmC4Wy/XXkKbSzxU2g4HKX0iDu2G37EmaMDv+johZBUMI6vr+CmTaFtPraxXE3x3uid2ZAeMhw04b0lGH829AId4omYnBz0ulT5newfhH4BKIhK3btSxH5kKbOQYOXIt/Ev3biyAqVx0fdbzJBQ41N55QHTkFvzYycMRAFYJ/NldaYBfpPIXJ/kF5rwCQ2PzU/JSRQsxkliYlHL869smXx3rb6iKS2ZoGIoi4xQdJ9DiUwG+Ph3vX1LmiIMMglruoKIeD8sozxLAJnEKFwl4a4SxSWmgyXFbo3uU2TI8P1RQHhql+vBR9b33zXXtXPNwP+/paqaUtVi3Ch+JjzD6RNGTY0MlSqY6WwwYh26AlR+Cdc6chsdWrUCS9kTv+IJhVmyJwkaeP9G/feU4r9thoQ9WgaXx9eETmIVfaw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(7416014)(1800799024)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hPg2BIKP6xwuaywHn4bkpI3OqYfIO3Eeg6ReCpEy/Y0xpP1Fum9g4I4//CHaEqcpi+vkyqVllR4IVTw1dgonho50HKUQTTUjiC+Znb4koaSRtxuwWR7X+V5zHBP+Wp2TR0kx0PAWKRhsJLwxlQffO4/JlV18RBFl4VKVr1PyTjyCtiCwfjTc+17c/rUjiQjMIivOFWpoffzXWy3eyr3suqzEWICZNiM5fczHpIMd897Zw5TvwCGdpPC2Rk3YqoKO7g3vLTQKoFwfhGr/I2kx48K2HhNVPaXrBw4f4Yh4MPYaIFtv9Q/2x+1i5I7PAfrpvDNhzbty3Imt2yuHYmjWGmDLMMM9Jz0s8jLnTOarq9fC/YVfuHwKQxr9k6OWfwsMH+7jXpiaezdQRQx0IS/6CQUqw4Ar1i0tAcIVi4aSW5l1mzJKOesXEF6fOQPWrgCK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 04:41:08.1531 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: caaf5a2b-771b-4674-db7f-08df0d63667a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4261
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

Link a panel's backlight_device to the bridge connector so
luminance-aware clients can drive it through the LUMINANCE property.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/gpu/drm/bridge/panel.c                 | 15 +++++++++++++++
 drivers/gpu/drm/display/drm_bridge_connector.c | 11 ++++++++++-
 include/drm/drm_bridge.h                       |  1 +
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
index 02388a3de626e..36005e10494d3 100644
--- a/drivers/gpu/drm/bridge/panel.c
+++ b/drivers/gpu/drm/bridge/panel.c
@@ -233,6 +233,21 @@ bool drm_bridge_is_panel(const struct drm_bridge *bridge)
 }
 EXPORT_SYMBOL(drm_bridge_is_panel);
 
+/**
+ * drm_panel_bridge_to_panel - get the drm_panel wrapped by a panel bridge
+ * @bridge: the panel bridge
+ *
+ * Returns the &drm_panel wrapped by @bridge, or NULL if @bridge is not a
+ * panel bridge.
+ */
+struct drm_panel *drm_panel_bridge_to_panel(struct drm_bridge *bridge)
+{
+	if (!drm_bridge_is_panel(bridge))
+		return NULL;
+	return drm_bridge_to_panel_bridge(bridge)->panel;
+}
+EXPORT_SYMBOL(drm_panel_bridge_to_panel);
+
 /**
  * drm_panel_bridge_add - Creates a &drm_bridge and &drm_connector that
  * just calls the appropriate functions from &drm_panel.
diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index 8b54069fa53a4..d4b4e59cea51c 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -11,7 +11,9 @@
 #include <linux/slab.h>
 
 #include <drm/drm_atomic_state_helper.h>
+#include <drm/drm_backlight.h>
 #include <drm/drm_bridge.h>
+#include <drm/drm_panel.h>
 #include <drm/drm_bridge_connector.h>
 #include <drm/drm_connector.h>
 #include <drm/drm_device.h>
@@ -1082,9 +1084,16 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 		connector->polled = DRM_CONNECTOR_POLL_CONNECT
 				  | DRM_CONNECTOR_POLL_DISCONNECT;
 
-	if (panel_bridge)
+	if (panel_bridge) {
+		struct drm_panel *panel;
+
 		drm_panel_bridge_set_orientation(connector, panel_bridge);
 
+		panel = drm_panel_bridge_to_panel(panel_bridge);
+		if (panel && panel->backlight)
+			drm_backlight_link(connector, panel->backlight);
+	}
+
 	if (support_hdcp && IS_REACHABLE(CONFIG_DRM_DISPLAY_HELPER) &&
 	    IS_ENABLED(CONFIG_DRM_DISPLAY_HDCP_HELPER))
 		drm_connector_attach_content_protection_property(connector, true);
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 58fff047f43b6..ce1fc8695b455 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -1475,6 +1475,7 @@ void drm_bridge_hpd_notify(struct drm_bridge *bridge,
 
 #ifdef CONFIG_DRM_PANEL_BRIDGE
 bool drm_bridge_is_panel(const struct drm_bridge *bridge);
+struct drm_panel *drm_panel_bridge_to_panel(struct drm_bridge *bridge);
 struct drm_bridge *drm_panel_bridge_add(struct drm_panel *panel);
 struct drm_bridge *drm_panel_bridge_add_typed(struct drm_panel *panel,
 					      u32 connector_type);
-- 
2.43.0

