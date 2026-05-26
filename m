Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFD51CD5BD0
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 03:03:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 555C010E443;
	Tue, 26 May 2026 03:03:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QxgrFuak";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010039.outbound.protection.outlook.com
 [52.101.193.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 967ED10E43F;
 Tue, 26 May 2026 03:03:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E1XIl78v2Z/ra9+O9Ri4BEyppZHMH4d6KqQkkD2adAkEEb4raNynkMwCB3nglJBmloxU8m88JqUo3qJZ1lPNQpEWT4dpX3f7TejW4Mx5sEac2YFzLMHHrGXCgXCaNHO7K6lG39UVDDGvmn+lo20WKRHJMZjkiSMq5LIUxy2CbI2XL6sVGAhnEcrL72SV5wVaeTGwCikcsyLkdg+7IeL7lkHicI1C/7sABTXAX1gk5D/36nFamtwIaCD7G+Qg+2E/oXE/9aEkY/OzHbCGkI4pP/r9qYDPLXucOmGr6TtoDHS7vA0z7RDfC6FrF/nmAE+zw5kpOL3Dao1rlaJOfTWLLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BFyAapi46Ayv4jsEpmrtFPXHEfxx14TfAi4TkGqVW8k=;
 b=alJyHkgIa02LeuwEAYbZb9xptejyQHHzWbAMshoKD7raMwhRJ3N+2CF25PjGpAy+7eLaOEgytplhqN7HXrQXE+cVqEOHyVg66JqroRNnSsvAKGeKXEd5f0xEGkqyf7YoJuhg8hgFsLDe/rx+obX9bfWBigwq8FDMvJw9U5mlxakD4yxLCeFfL3d+nnJ0ohMhb753NHczSU7ogE3jsnVAaM8EMcdkalzoCUGv7D9Zxr3Qbvb+8Y4uPAvacqWapGYr2OQ8mL9tUvo0fUAneiKNx/bxdWqbVpcJ7erMwbJsNprozZe6uZsNv4HMmLWxXVztGkaM8wvPkDDl7rQgFhUleA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BFyAapi46Ayv4jsEpmrtFPXHEfxx14TfAi4TkGqVW8k=;
 b=QxgrFuakHaW38gDQ/7rNXoBvJ79xwgnSI3TPcqL83xt/JxNujgY7q/YrwKuztL14eFTuQQKPEaqv9eYxVgS7NB43+ThPD3YNRss4SQpF+m5bpIepM1k96uTD4DYUfitHGeVHOCCX4jIhuTGym1RBOo13syhpqiyNTOHIsnJTtGM=
Received: from BL1PR13CA0242.namprd13.prod.outlook.com (2603:10b6:208:2ba::7)
 by BN7PPFDE2ACDA69.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6e6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Tue, 26 May
 2026 03:03:12 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:2ba:cafe::48) by BL1PR13CA0242.outlook.office365.com
 (2603:10b6:208:2ba::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.11 via Frontend Transport; Tue, 26
 May 2026 03:03:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 03:03:11 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Mon, 25 May
 2026 22:03:11 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 May
 2026 22:03:10 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 25 May 2026 22:03:09 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, "Ray
 Wu" <Ray.Wu@amd.com>, Limonciello Mario <Mario.Limonciello@amd.com>, "Jani
 Nikula" <jani.nikula@intel.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH v3 2/3] drm/edid: parse panel type from DisplayID 2.x Display
 Parameters
Date: Tue, 26 May 2026 10:59:50 +0800
Message-ID: <20260526030254.1460480-3-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526030254.1460480-1-chen-yu.chen@amd.com>
References: <20260526030254.1460480-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: chen-yu.chen@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|BN7PPFDE2ACDA69:EE_
X-MS-Office365-Filtering-Correlation-Id: cb7d1327-8bb3-406c-284e-08debad35261
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|22082099003|18002099003|56012099003|6133799003|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info: R/MjSZe+hVb0qgDaB3xqYg9VDxhL8dowVnh3Ttygdig27EYQxm7oBJxZ7xaSdBkYxTGlIwqy6sweWJ8t+ln8FWonrw9MDz+YfjMuWyCNqQrsTE019mfMdN1EYo5RwaXRXvE9jK4z/m/LZ0wwcn3ffa8RlIFBl40BrkHtV0XpxVT7o4adYZpmpwMm7SiMvC31Ai4UJxlrw2Il/ks6IHG5YkP/S5YlhKqYrDWnq9WzTaxLjMhGD6Af4MiLS32WG+RLv7TnfMSpxzjkwyCX4fGB87X24Hwrlwjkh31MFiOB4NY/a2SRusvq8aow0Boz88DVzfGKzVZObepgHQazJliWWWLd0jdNNq9YwpHuwfWedV851cDOGGJxFeUUHag/NhDcUq3s8RFIBNs/djNc+C4ZcU9oULBLdFcAI5+0EMsvKLX1dDIktrVA2+6slvIitLinzaRojgjw3wbUqH45dalbhVD/Wg+gHkAGCxn/YNm6gQ/+taKgX8+MsdQ/cq6Zw4aRZw3Q4v0VD22W7VIzM/Uku6srm8iJDJ2qGFMoIH3KO+K8V0T2nSvYaUsMofMYh+ISFSgUJb60209LNof6Fcp+siax4H4IVz/NFfDCgH3TAwGa21uiJoRxRLNRphoX2Yst58xhuFNGffbTwLTI/rWqu10f+Yam0xvqlPDCH0ok1jytXQjapAv/gAGz7a1s6JPHAbF11UdfzoXwKbw8YzwpnwnXaLYR8AXNWGmB9lbJuXs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(22082099003)(18002099003)(56012099003)(6133799003)(3023799007)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Jfg5oH4oIPKWwiYfVzPUnEws0S4o+gTgMclC9VUSudt3NJ2kUAooJY0JJXvEggK1ze4P3Q+8rXOoK+jfuF0pBeYQQ7RYorYbwFZdr2+CpGQyN+chv+GuwzRsJf3jK6LVdP+N5wrC0JQ1/DWH8sj400ipW/jifDoia1y8C3HQmUQK7QLIlHksIC5bW7YbrFD9wRbfZzAr+9MkeW9VU2GD461Zg3vnhIigyRrYIC8T6UhNPf0P3Bzs2/QZN4FnFhG1K7qjB+rTDYf2go/RK2rS1kpNvyOsj05Msf0OMjK0Hwn49uh1t2byK8jxxTiJbzRhr15XNIiNMPdSdVibFWGbqchBMnWXst1Nfb4GPHooXFMmRa5KWxQqJpKHdsruYWtT/LEM337Lu0zbeHl/7h7azn6KO+nlpbyYRQHEH+3pnu3FyFqK1c21KZG8+yrzuMMQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 03:03:11.5776 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb7d1327-8bb3-406c-284e-08debad35261
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFDE2ACDA69
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
field from the color depth and device technology byte, which indicates
whether the panel uses LCD or OLED technology.

Add a panel_type field to struct drm_display_info and populate it
during DisplayID iteration so downstream drivers can use it for
panel-type-dependent behavior. Add DRM_MODE_PANEL_TYPE_LCD to the UAPI
panel type property alongside the existing OLED value.

Assisted-by: Copilot:Claude-Opus-4.6
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 drivers/gpu/drm/drm_connector.c          |  3 +-
 drivers/gpu/drm/drm_displayid_internal.h | 24 +++++++++++++
 drivers/gpu/drm/drm_edid.c               | 45 ++++++++++++++++++++++++
 include/drm/drm_connector.h              |  6 ++++
 include/uapi/drm/drm_mode.h              |  1 +
 5 files changed, 78 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index aec05adbc889..f2ac4542a7d3 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -1176,6 +1176,7 @@ static const struct drm_prop_enum_list drm_link_status_enum_list[] = {
 static const struct drm_prop_enum_list drm_panel_type_enum_list[] = {
 	{ DRM_MODE_PANEL_TYPE_UNKNOWN, "unknown" },
 	{ DRM_MODE_PANEL_TYPE_OLED, "OLED" },
+	{ DRM_MODE_PANEL_TYPE_LCD, "LCD" },
 };
 
 /**
@@ -1508,7 +1509,7 @@ EXPORT_SYMBOL(drm_hdmi_connector_get_output_format_name);
  * 	never read back the value of "DPMS" because it can be incorrect.
  * panel_type:
  * 	Immutable enum property to indicate the type of connected panel.
- * 	Possible values are "unknown" (default) and "OLED".
+ * 	Possible values are "unknown" (default), "OLED", and "LCD".
  * PATH:
  * 	Connector path property to identify how this sink is physically
  * 	connected. Used by DP MST. This should be set by calling
diff --git a/drivers/gpu/drm/drm_displayid_internal.h b/drivers/gpu/drm/drm_displayid_internal.h
index 5b1b32f73516..6f431aafafcf 100644
--- a/drivers/gpu/drm/drm_displayid_internal.h
+++ b/drivers/gpu/drm/drm_displayid_internal.h
@@ -142,6 +142,30 @@ struct displayid_formula_timing_block {
 	struct displayid_formula_timings_9 timings[];
 } __packed;
 
+#define DISPLAYID_DEVICE_TECH_UNSPECIFIED	0
+#define DISPLAYID_DEVICE_TECH_LCD		1
+#define DISPLAYID_DEVICE_TECH_OLED		2
+
+#define DISPLAYID_DISPLAY_PARAMS_DEVICE_TECH	GENMASK(6, 4)
+
+struct displayid_display_params_block {
+	struct displayid_block base;
+	__le16 horiz_image_size;
+	__le16 vert_image_size;
+	__le16 horiz_pixel_count;
+	__le16 vert_pixel_count;
+	u8 features;
+	u8 primary_color1[3];
+	u8 primary_color2[3];
+	u8 primary_color3[3];
+	u8 white_point[3];
+	__le16 max_luminance_full;
+	__le16 max_luminance_10;
+	__le16 min_luminance;
+	u8 color_depth_and_tech;	/* [2:0] depth, [6:4] device tech, [7] theme */
+	u8 gamma_eotf;
+} __packed;
+
 #define DISPLAYID_VESA_MSO_OVERLAP	GENMASK(3, 0)
 #define DISPLAYID_VESA_MSO_MODE		GENMASK(6, 5)
 
diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 7ad3f939dbe6..a9d480981c8f 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -6713,6 +6713,8 @@ static void drm_reset_display_info(struct drm_connector *connector)
 
 	info->source_physical_address = CEC_PHYS_ADDR_INVALID;
 	memset(&info->amd_vsdb, 0, sizeof(info->amd_vsdb));
+
+	info->panel_type = DRM_MODE_PANEL_TYPE_UNKNOWN;
 }
 
 static void drm_displayid_process_base_section_header(struct drm_connector *connector,
@@ -6731,6 +6733,45 @@ static void drm_displayid_process_base_section_header(struct drm_connector *conn
 		info->non_desktop = true;
 }
 
+static void
+drm_displayid_parse_display_params(struct drm_connector *connector,
+				   const struct displayid_block *block)
+{
+	struct drm_display_info *info = &connector->display_info;
+	const struct displayid_display_params_block *params =
+		(const struct displayid_display_params_block *)block;
+	u8 tech;
+
+	if (block->num_bytes < sizeof(*params) - sizeof(params->base)) {
+		drm_dbg_kms(connector->dev,
+			    "[CONNECTOR:%d:%s] DisplayID Display Parameters block too short (%u < %zu)\n",
+			    connector->base.id, connector->name,
+			    block->num_bytes,
+			    sizeof(*params) - sizeof(params->base));
+		return;
+	}
+
+	tech = FIELD_GET(DISPLAYID_DISPLAY_PARAMS_DEVICE_TECH,
+			 params->color_depth_and_tech);
+
+	drm_dbg_kms(connector->dev,
+		    "[CONNECTOR:%d:%s] DisplayID Display Parameters: device technology %s\n",
+		    connector->base.id, connector->name,
+		    tech == DISPLAYID_DEVICE_TECH_LCD ? "LCD" :
+		    tech == DISPLAYID_DEVICE_TECH_OLED ? "OLED" : "unspecified");
+
+	switch (tech) {
+	case DISPLAYID_DEVICE_TECH_LCD:
+		info->panel_type = DRM_MODE_PANEL_TYPE_LCD;
+		break;
+	case DISPLAYID_DEVICE_TECH_OLED:
+		info->panel_type = DRM_MODE_PANEL_TYPE_OLED;
+		break;
+	default:
+		break;
+	}
+}
+
 static void update_displayid_info(struct drm_connector *connector,
 				  const struct drm_edid *drm_edid)
 {
@@ -6744,6 +6785,10 @@ static void update_displayid_info(struct drm_connector *connector,
 			drm_displayid_process_base_section_header(connector, &iter);
 			base_section_header_processed = true;
 		}
+
+		if (displayid_version(&iter) == DISPLAY_ID_STRUCTURE_VER_20 &&
+		    block->tag == DATA_BLOCK_2_DISPLAY_PARAMETERS)
+			drm_displayid_parse_display_params(connector, block);
 	}
 	displayid_iter_end(&iter);
 }
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index c398dbc68bbc..745cd917fe40 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -899,6 +899,12 @@ struct drm_display_info {
 	 * @amd_vsdb: AMD-specific VSDB information.
 	 */
 	struct drm_amd_vsdb_info amd_vsdb;
+
+	/**
+	 * @panel_type: Panel type from DisplayID Display Parameters
+	 * Data Block (tag 0x21). Uses DRM_MODE_PANEL_TYPE_* constants.
+	 */
+	u8 panel_type;
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

