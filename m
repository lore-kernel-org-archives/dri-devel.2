Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60823C61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 21:06:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47FB210EB1D;
	Mon, 31 Aug 2026 21:06:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SsTexeg6";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013033.outbound.protection.outlook.com
 [40.107.201.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73FCA10EB19;
 Mon, 31 Aug 2026 21:06:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CkWqf5NxV3/bA3CKCV6NYTYZ9nULoVCk7qE0xHMuyMbc/Js44i9Erl9ry5BcaqKz55bQyVs+IYrrQv/VdY2i62vaYUsZy9pVryKrRq8ZOMN2fgvg5OPoB7LgVw69+IPTJotcbTZ3LZ/GI++PgBMQC+XaxU8UfvmiS+EpxkzsXmxNpUxKlQRGjhazkV3wdn/+FivBN4eMN0kcL+XmxdeHOcCD0BpzMI8g3Vs3Ekl+opKS71D3je/oy4JoSLyrmvCpppufNwh9VsB+gnOG/U3/7ghuRcubZHh12n+Wc/2W38SNOA9Q7IeioaJ7D8tyWfGr7NXOrLID3xs9C0rEKWaUng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tuR39l//eSsUelrdRamkE6Ec+i1NxAFb8MiN1pXdcYY=;
 b=D5lVG+Nuv8GRWOnqiBUkQfNy3C/Lnp16+yXo7yjJJ4RZ/3WrzL49alNt4xf/eiOmrP2HhD0YEh5B0xe4eI/RJB/nYghwb2KHXeicu9Xe+J2wMQ66KUZAOBHcbme4/TLgiOdYIK3bTilX44soNjGJmEvTvZFw2Kp6RL0ACK1+veRLSco6aHuMah3pCQgZFYKw4zDbE04mp2qEsaux8isF+kEGuTNTNwRNIUZ//hc3K3a+HylfNEdmUxsahqVauBn20tdgK3z/6CSkWZtgIH4FWreoHJm1gouLJtjhl4Kie2FjfF8/iTwwWCwb0xWt48F6Z2T14XUIGXzmbZc8j63C8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tuR39l//eSsUelrdRamkE6Ec+i1NxAFb8MiN1pXdcYY=;
 b=SsTexeg6vjKovwFlK1l41U7ZcTvsvUDyx4vNAOLseg4E041fcao9j0l+oLQDWIF6TmRink16X3nFer85X77y+0cJYao2QnaSlypHzO3bjxeBYR08x2k4DcMIe6n0e8IYPdYE+oC7KDeaK2dYk8T0qtQviFvvvCECOOC68M4mwC8=
Received: from BN9P222CA0027.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::32)
 by MN2PR12MB4301.namprd12.prod.outlook.com (2603:10b6:208:1d4::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 21:06:04 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:408:10c:cafe::4b) by BN9P222CA0027.outlook.office365.com
 (2603:10b6:408:10c::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 21:06:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 21:06:04 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 16:06:03 -0500
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
Subject: [PATCH v7 09/12] drm/bridge: auto-link panel backlight in bridge
 connector
Date: Mon, 31 Aug 2026 16:05:28 -0500
Message-ID: <20260831210531.2334221-10-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831210531.2334221-1-mario.limonciello@amd.com>
References: <20260831210531.2334221-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|MN2PR12MB4301:EE_
X-MS-Office365-Filtering-Correlation-Id: 00e12b95-7e71-4d88-a02b-08df07a3ab67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|7416014|1800799024|36860700016|23010399003|376014|56012099006|10067099003|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: rEl9nMhvvTgDbEnNp7FuOyXXcbAVyxzmx+gdh2jF+d6S+c/MO9nRyQGY1az02YDjeqP46QgB3c266VRmU85SLQSdDhLLnlA6MSauyXOGHG8NZbeR0u7TkukIU91eZ9n2OvteQCs/sqbj6Id0WeK4yHgJk/KX8xscjmdy93HBYqBF4eCmge/ZoHCQ6A+jYudC7PI7P3Aq3d0g6w8d3a/fs+23fR9kLBxFi/RVs6UMQNTkQmhIUIfEA8JQe5UJaAb8ililFZoQzlw946+wUeaMBTwoxxYWoCniKEtwvov3aa5mlDnf6XNvb+xOpHxI5bFIgHA6hrxi/+ujDknLxL/PQiBulBmEHRnjH8yng3jC7VbWlVncaYuwAaCW+PogYcjyZ+OYZRYfaTVkBPrOyXRBCddexYJ9SXxVlvBOa1/0XZ18O57fKfU6IRfOZnNXA+G9qn2CNMQ8pTfaZOBkD707LcWC1H1AF5zIx64K0BZFnBRbmfND5dGpOZzW92Y51kJcBOaIyjUnPeUObE5YhaJ7tzBHZd3jLNQ9UevL7U8k+3+bh4+cv8xDMrI1/8EeSwWQp0xjVgt/OoYviuuY/LshtiM85LAg4bOukmkOom5bWOtnbg/HoDdq/kaXG89aYSVkmZ+IjNbT1t2JbSSv4Bs14JpwiqsvToh1VSaDYXDvVzkK5kxVNzbf3GqzJH5T+AClXKFDwSUTFTctVYLrHTi6gg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(7416014)(1800799024)(36860700016)(23010399003)(376014)(56012099006)(10067099003)(11063799006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 57IIszCenkOIC82pIuctqJ2IeWK6P7f/t4gRCAh7QJj0M3LnIyO+xVZ4zx/46UG/U8rbnzv/PY6y4jFG/z4AoY3/dixEdvzBtfJ4AxzH6aO5BP97w5VcQ257YX1ymO3W+leMKA9m1AIx/YbIqoh5IcsXJWGpZvXu0ir233NfvBLoQk1yCSyLO9h5uPiI6JZ+231RVM+1tcBXtMXgpgEcX0Fv9jmV9YP8uyX2hnYvZNPHiPsOT8yAPmkZ6EALvPVSOxwAHNrbkDkLsZcBFJG/8E2F5uiL4KWkB4uPuppI2xW9IPIFG27aHYGgmZeJBTTX5zySG3DsTin8iX/eSkX+EWmcShy20DbFI/Y7pkcqWMF/jUH5rtGVu4SIxYsZTm19+p0BryGcs4TtYdETqKX/64sBaxFRtbGDt/kwxGlLrqYcUlLOqucGa4+J9ql1qqnw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 21:06:04.6232 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00e12b95-7e71-4d88-a02b-08df07a3ab67
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4301
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

