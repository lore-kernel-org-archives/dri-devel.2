Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5DADCD5BA6
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 02:14:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35D1B10EEC0;
	Wed, 20 May 2026 02:14:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FlG5J8Vw";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011030.outbound.protection.outlook.com [40.107.208.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3186110EEC0;
 Wed, 20 May 2026 02:14:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EEOw5wmga7QOR5m9JYJ33cxrv55yWWglcFw9UuDGpLks682VPUq+AoTm9URWLYnosM3ae5gsU1A4BGMS3NOjruOghtGuHE33A2xlkptI42fyteUx+eY7RzSSXTzganusM0glvauoQCSvoX5E+xLuDe1IgHifYA9hCdWXxiio1S1rElHoUkC0o40/alAokdRC7sDE/KbZnSeS5gZwYgk0ewJu9OSq+PQlq4w1mytJ5+0yARkPVbAVMrMypxyqQUCKqL9Wy55pHY3z4BRHU08guBfL3XeR34Wsqg6+Dx+jKZTwL0WQUaneSdXlziJ5oDUInKdhluI/ODIMyx9nhKPuFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eAXEqgA7Hvotkt9fKiOLST2j55zGhmanQTpQzm7IYXE=;
 b=TcFEedKRzP0HaHYBJjoJrWv9bR2eJeCRC6ndsScpBFKh9QjkWD/BIcTJ3Spr6LJz1AxDOAWdLWtDWzVuJuW24YGp+YKMcr8AOSxvkdxyMH74MB3X0P2P26HklptRaf54P21UlavCDkUywv4XlgUFK2c04UmC7kYy1iHkuQY58ajUpE0lZUSourltUAROmw5irknojKkBqMNR3dhYFXeCQKVOvTbxsUiakptZYKI05uFYcvkBItprXo4orJZg04Kw51Nahk3+gFqF/uMx+BrHZpzuAfpg6BiYEubuGH/Z6Rl7Y1vMAZQtN4nJ7tfRa+6ITVhRrG3Jn1444tJTotdREQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eAXEqgA7Hvotkt9fKiOLST2j55zGhmanQTpQzm7IYXE=;
 b=FlG5J8Vw4b6wbeuXsCJhM0ctwUIHR4EpU+JLsbSsF3v41q/hghgp/aZYkE6OI4ikDjF3sY53efMwpCilBAIDtNRbYrk2e6KR/J9BcOsX73d5sTlhdhmY/wpMX4Axy4J26UCkRn9QnvjLetZvx9GS+0TVDjPbQ5HXbmmpL0IFkMs=
Received: from DM6PR08CA0046.namprd08.prod.outlook.com (2603:10b6:5:1e0::20)
 by SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.22; Wed, 20 May
 2026 02:14:43 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:5:1e0:cafe::be) by DM6PR08CA0046.outlook.office365.com
 (2603:10b6:5:1e0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Wed, 20
 May 2026 02:14:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 02:14:43 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 19 May
 2026 21:14:42 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 19 May
 2026 21:14:42 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 19 May 2026 21:14:40 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, "Ray
 Wu" <Ray.Wu@amd.com>, Limonciello Mario <Mario.Limonciello@amd.com>, "Jani
 Nikula" <jani.nikula@intel.com>, Chenyu Chen <chen-yu.chen@amd.com>, "Mario
 Limonciello" <superm1@kernel.org>
Subject: [PATCH v2 2/3] drm/edid: parse panel type from DisplayID 2.x Display
 Parameters
Date: Wed, 20 May 2026 10:13:52 +0800
Message-ID: <20260520021432.1301326-3-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520021432.1301326-1-chen-yu.chen@amd.com>
References: <20260520021432.1301326-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|SN7PR12MB8059:EE_
X-MS-Office365-Filtering-Correlation-Id: b6dcbf5e-dc62-4511-d338-08deb6158e68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|3023799007|18002099003|22082099003|11063799006|56012099003;
X-Microsoft-Antispam-Message-Info: LjeI1dMRP7pL3RZCYEyW0wzVEPnDlM6LQ1SbTKXMQKhJpy5PpUvNL8nfwUlGCLZUxnSr8cKKUc8NPaUDHTvp+Rmlbm1ObckQD/pIeRuh718ksu6pF0uDzaYJPb4hWhtn4vB+FIC4zjVR7W7WIQDWVh2HfUbVHDVOGPulNUgStXkO5ghrzQzsFaNRmTPHTzybtwcWx1dtsPipyIscxqygDc7JkB0CZDOZCSqq0nvNdEXNIi8I9OS0rSjiFfed6fujnX/GmBIByUUm/8EEve2JROynrQEloiUkbjn6iGeBnulQop6FNKvWLv1csgmYgFpbSrujXnvOp9IKu7mlFA9iCZIxn9fX7m1gOjwn46lQjm2UvXf1obZsNZ5DkJsZAO3p417GEiGqsuaUu/xYfkWy67qekecIKIuv7dWHopTok+0OFdlrbenifHacetmXuTuaAeZMqlDkFj4tSaLSU7Rl/LPIWYqI6wxpWMBYmuFp1NY+D9IuwAcxO32f6+aOHYSD0c/XgEV6fpj8xdx3qaGxsP4BLiFvlGLT23fIWyGnyxchmaE6xAS8QQL4PoTMw0yKLgo+fDy8gdaLlQuakwjKIH63W9zZIkjIOoKfre1LEDfYFPOIg1khrNqZM2kMmGxcvDGOWeYGlz6jcZs6NFITWC+Lmr+ZDgFxNciYzo2pUv5HORvSwfz6gu5YvsPbThDOST0zkuetT9EaJ+RpjJJ50rq1648n5CRLxtOrHYWyHdg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(3023799007)(18002099003)(22082099003)(11063799006)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: f67nG8TNB6tpE4wc1Y+MeDUEAS2X51yh+4PTt7eFrEvknosliimiLp0hcO73jQspJh44TZVg1v2V/N2g4Uo3SKRC2rf4cxov+sP6j0y7+6fekBod4v3bhGMDYq6KYD2cPGBs2aZ0OtdHSqDa6slmNiVkgik2dne3nRxzT+CqdRlAroA2YwrE28buFotbuJhDvMPM2gmLYv9AR91LxZ0iWj8m0QimqGeJLA5llv3/QX6QJqhAYwskN79F/RWvbWO5DBwv8SceHKhL/sdeCKbN+xeKwLW5lWCvO8p5gomYtXK3mp8UyaomOMQwd5yuLnUOFKG/9sqk6SpjnjoyGHsl7KDV/NilL769zesrB7suGUTQfsRRy9HSLZYUP90a4Epcm5IHjJ8vVgLvRkBm/f+PJsdT+1NkoJlimKNAzU9vS8RPPOPXMXBDeiJCg0d71WHO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 02:14:43.2290 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6dcbf5e-dc62-4511-d338-08deb6158e68
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8059
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

Parse the Display Parameters Data Block (tag 0x21) defined in
DisplayID v2.1a Section 4.2.6. Extract the Display Device Technology
field from payload byte 27 bits [6:4], which indicates whether the
panel uses LCD (001b) or OLED (010b) technology.

Add a did_panel_type field to struct drm_display_info and populate it
during DisplayID iteration so downstream drivers can use it for
panel-type-dependent behavior. Add DRM_MODE_PANEL_TYPE_LCD to the
UAPI constants for use as an internal communication value between
DRM core and drivers.

Assisted-by: Copilot:Claude-Opus-4.6
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/gpu/drm/drm_displayid_internal.h | 25 ++++++++++++++
 drivers/gpu/drm/drm_edid.c               | 44 ++++++++++++++++++++++++
 include/drm/drm_connector.h              |  6 ++++
 include/uapi/drm/drm_mode.h              |  1 +
 4 files changed, 76 insertions(+)

diff --git a/drivers/gpu/drm/drm_displayid_internal.h b/drivers/gpu/drm/drm_displayid_internal.h
index 5b1b32f73516..e0f7c54d2987 100644
--- a/drivers/gpu/drm/drm_displayid_internal.h
+++ b/drivers/gpu/drm/drm_displayid_internal.h
@@ -142,6 +142,31 @@ struct displayid_formula_timing_block {
 	struct displayid_formula_timings_9 timings[];
 } __packed;
 
+/*
+ * DisplayID v2.x Display Parameters Data Block (tag 0x21).
+ *
+ * Per VESA DisplayID v2.1a, Section 4.2.6, Table 4-14:
+ * Offset 0x1E (payload byte 27) contains Native Color Depth and
+ * Display Device Technology fields.
+ *   bits [2:0] = Native Color Depth
+ *   bit  [3]   = RESERVED
+ *   bits [6:4] = Display Device Technology
+ *     000b = not specified, 001b = LCD, 010b = OLED, others reserved
+ *   bit  [7]   = Display Device Theme Preference
+ */
+#define DISPLAYID_DISPLAY_PARAMS_DEVICE_TECH	GENMASK(6, 4)
+
+struct displayid_display_params_block {
+	struct displayid_block base;
+	u8 payload[27];
+	u8 device_tech_byte; /* bits [6:4] = Display Device Technology */
+	u8 reserved;
+} __packed;
+
+#define DISPLAYID_DISPLAY_PARAMS_MIN_LEN	\
+	(sizeof(struct displayid_display_params_block) -	\
+	 sizeof(struct displayid_block))
+
 #define DISPLAYID_VESA_MSO_OVERLAP	GENMASK(3, 0)
 #define DISPLAYID_VESA_MSO_MODE		GENMASK(6, 5)
 
diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 04878478ab78..d1de1a398677 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -6713,6 +6713,8 @@ static void drm_reset_display_info(struct drm_connector *connector)
 
 	info->source_physical_address = CEC_PHYS_ADDR_INVALID;
 	memset(&info->amd_vsdb, 0, sizeof(info->amd_vsdb));
+
+	info->did_panel_type = DRM_MODE_PANEL_TYPE_UNKNOWN;
 }
 
 static void drm_displayid_process_section_header(struct drm_connector *connector,
@@ -6731,6 +6733,44 @@ static void drm_displayid_process_section_header(struct drm_connector *connector
 		info->non_desktop = true;
 }
 
+static void
+drm_displayid_parse_display_params(struct drm_connector *connector,
+				   const struct displayid_block *block)
+{
+	struct drm_display_info *info = &connector->display_info;
+	const struct displayid_display_params_block *params =
+		(const struct displayid_display_params_block *)block;
+
+	u8 tech;
+
+	if (block->num_bytes < DISPLAYID_DISPLAY_PARAMS_MIN_LEN) {
+		drm_dbg_kms(connector->dev,
+			    "[CONNECTOR:%d:%s] DisplayID Display Parameters block too short (%u < %zu)\n",
+			    connector->base.id, connector->name,
+			    block->num_bytes,
+			    DISPLAYID_DISPLAY_PARAMS_MIN_LEN);
+		return;
+	}
+
+	tech = FIELD_GET(DISPLAYID_DISPLAY_PARAMS_DEVICE_TECH,
+			 params->device_tech_byte);
+
+	drm_dbg_kms(connector->dev,
+		    "[CONNECTOR:%d:%s] DisplayID Display Parameters: device technology %u\n",
+		    connector->base.id, connector->name, tech);
+
+	switch (tech) {
+	case 1: /* LCD */
+		info->did_panel_type = DRM_MODE_PANEL_TYPE_LCD;
+		break;
+	case 2: /* OLED */
+		info->did_panel_type = DRM_MODE_PANEL_TYPE_OLED;
+		break;
+	default:
+		break;
+	}
+}
+
 static void update_displayid_info(struct drm_connector *connector,
 				  const struct drm_edid *drm_edid)
 {
@@ -6744,6 +6784,10 @@ static void update_displayid_info(struct drm_connector *connector,
 			drm_displayid_process_section_header(connector, &iter);
 			header_processed = true;
 		}
+
+		if (displayid_version(&iter) == DISPLAY_ID_STRUCTURE_VER_20 &&
+		    block->tag == DATA_BLOCK_2_DISPLAY_PARAMETERS)
+			drm_displayid_parse_display_params(connector, block);
 	}
 	displayid_iter_end(&iter);
 }
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index c398dbc68bbc..b95aec34ddb7 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -899,6 +899,12 @@ struct drm_display_info {
 	 * @amd_vsdb: AMD-specific VSDB information.
 	 */
 	struct drm_amd_vsdb_info amd_vsdb;
+
+	/**
+	 * @did_panel_type: Panel type from DisplayID Display Parameters
+	 * Data Block (tag 0x21). Uses DRM_MODE_PANEL_TYPE_* constants.
+	 */
+	u8 did_panel_type;
 };
 
 int drm_display_info_set_bus_formats(struct drm_display_info *info,
diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
index 3693d82b5279..d7ca1040b92e 100644
--- a/include/uapi/drm/drm_mode.h
+++ b/include/uapi/drm/drm_mode.h
@@ -169,6 +169,7 @@ extern "C" {
 /* Panel type property */
 #define DRM_MODE_PANEL_TYPE_UNKNOWN	0
 #define DRM_MODE_PANEL_TYPE_OLED	1
+#define DRM_MODE_PANEL_TYPE_LCD		2
 
 /*
  * DRM_MODE_ROTATE_<degrees>
-- 
2.43.0

