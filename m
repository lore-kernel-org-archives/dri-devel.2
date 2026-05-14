Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1091CD4F39
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 06:56:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4049610E376;
	Thu, 14 May 2026 06:56:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eOcyo/R7";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012026.outbound.protection.outlook.com [52.101.53.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AE1610E376;
 Thu, 14 May 2026 06:56:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EAKNhPUgn1AZtwiEYDyCcD41yYFPHAlz38CbYltJoWu8tGys8zTgGkS/qgrmQQ2SD9weQTTRCeu1FgieEvRJW0eEbGVV6ruMtOUi4yn36nrosl3rT/7Ym2dxTBMXTWukGP9ufUvyxuxKRyfIp/ePnBD8xCZcc0QOq14YedmyxOy+T0wLTpiE6frIHJ1FHE91po1l0DMf1fzDpFoMB3dFtmrMdszHcE5aq4oMAUjscjD4mH06hE+Lt40MkzNhX5hcsIvTZp27tGGJt87UbtG0xiCjCmhqqeNr0rgqkWn/5TiBn3/zwvuA8nwaOP1NypIJ3DzmshZqgIheuuqq8fEcdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Np94mYyekBUoD22MgXpter1gj41ItCKZ0nasKBQcsec=;
 b=Ep1qyqSVnnB8x/zgSctALviMepXDrbG3f0Ha0Vb7mqJ4a4QZvPlfExhGJ/y8skfP1o8siv2e5McK72v552Z4T9G72LQz72laeaBvVi+APa+j1VCN+mKY+l1/kprVEVGQ+wHwosQY+GBDxvA4vHBmXypjyPtgwvmu4uN81bY6S1XgsGIoc5sJC+izhTYlLr8LgF4Bzu7X9d2lLfoI1PpX1GjfdnjmaDvMb5LBYMVxuGorvbv1mAaSqtx5r8gNMj8KfJTus/DjFP9MN5g5LptofTGrqwmVyPMmvzJvfrXY9ah27rA4Vfi7g76dYnegHHPL1jc6tmzQjACHn22QlxaMVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Np94mYyekBUoD22MgXpter1gj41ItCKZ0nasKBQcsec=;
 b=eOcyo/R7GijebyS8JaZFUon+s4cMYUcLjMG1FMiGNjk5fKUHck28gNLjWVLvZtJoC0owYYcX9m8YyCKkp2+UNqJai99unp44gX2plpGhMJ26gDsV25rCzrBitPL7aqXPHB1i9VVA5no2tK1UQEVuUOuTxosVfstG8eapWwtMWr0=
Received: from DM6PR10CA0004.namprd10.prod.outlook.com (2603:10b6:5:60::17) by
 DS0PR12MB8317.namprd12.prod.outlook.com (2603:10b6:8:f4::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.18; Thu, 14 May 2026 06:56:23 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:5:60:cafe::1e) by DM6PR10CA0004.outlook.office365.com
 (2603:10b6:5:60::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Thu,
 14 May 2026 06:56:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Thu, 14 May 2026 06:56:22 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 14 May
 2026 01:56:21 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 14 May 2026 01:56:14 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, "Ray
 Wu" <Ray.Wu@amd.com>, Limonciello Mario <Mario.Limonciello@amd.com>, "Jani
 Nikula" <jani.nikula@intel.com>, Chenyu Chen <chen-yu.chen@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH 1/2] drm/edid: parse panel type from DisplayID 2.x Display
 Parameters block
Date: Thu, 14 May 2026 14:54:20 +0800
Message-ID: <20260514065606.1151834-2-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260514065606.1151834-1-chen-yu.chen@amd.com>
References: <20260514065606.1151834-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|DS0PR12MB8317:EE_
X-MS-Office365-Filtering-Correlation-Id: 386ef127-b76f-4b74-f05f-08deb185e8e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|11063799003|22082099003|18002099003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info: PhExA3r5TRJepmiTDVghgYgVW9CXDwzooQxRz+nXFQVI/JaEk+ihtto5EIA/hMswoLHY5J5yCt6KXGOBgl18ZukI7kYPuW+pnMcct/fJjyKmNwyKuhycI135WN4Q7JeJEssY8HNa4+LdCI40azFDDdnXpfRrTxECNBSiQEUA44pmANkZPzLxuHtK9sanFjuOrvO0DFW3BvmiT0m7XyIc9Ia8JYlhd70r1r+MtqvD5JF0lA9N0WUbYGM3c1Dbpwd3r3A4AECMB8nns0MgMOrL18Naj0AESLd1IKXcx9NkYbstO6i7LpRIjC+LkE85ddmCpikER2qd/VFrqIZ4zD06WvuYqHl6VOCQLZI3yLUGcnF6n/jMVwWU1OAec5mL/0wrRqS4HmOl5D28dKaE0cxMxKO28nnnuGOynv82jYtDjafYHw/tnxMI/DhhgrFMTyyPuRVzzyPReO23RoxWlgCUpq8Q3OyJs8zjfunuZiOnb+XGzC7BT6BkmkV1WbhweoPnAJOP+W/Rml6ioiBJAEb32P7bzvQH1J2HfdvRsj8ChrhAKZoo1CrpWpsy+CANmR25wV2jT4Q9nHMnBkDJJGq2Qkd4PqGEC523J2nmSyGNbCKnlUEvGaH02sfm084JfciajSQM4PD0u48AMYVky10GIbXH8+bF2M+Cp2K7kY7ndP5bHp5QQuWA5fj9Nz3wKg2H0rSvNCiKXiTNZRRVEPH4TF1cA+zaVXbwAQDF6dHp7HI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(11063799003)(22082099003)(18002099003)(56012099003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GB/gDLb2PZo5G/wCDRpp6UHGvjj0TzFYsnMzq8ObJu4XiC5ovJ+byjgv5CqbrCZPDjq4FkFk/NZt+JnC4r73UhS3JtYd/sCdE0Jca/hYoBnCP9w9cttv7PF/9cDpZecRSk4KNHqwDT9pfrDqzd0oarc6sPd9lBLagVxTF0rs7uGm+UNTCZj2s+GRaO4Xbm1Pm7cacs5FvG8ejz+CZrX5SmMFvPie2LY2qo/gFCaXk72Fcx7Xf7kNJ/PpqM4wJfYQdMhFwKzancpisPKvsRWVaEa2H4kbiC+LMy5RRgijcPzQXrMiOeJDy0QOTohnP6/95GZjJXVJoqWBF/4y0gXjmRaKJczXMExsZ0qAYIFE6lCe4NYXcbRaBdib/BI+/SOv3HnYLNmZcAor7r6OW/24pJVbVw7gbtYohaPlEgFM3OAKgmFEXRUhNG1Sfsd9teF7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 06:56:22.8380 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 386ef127-b76f-4b74-f05f-08deb185e8e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8317
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
field from payload byte 27, bits [6:4], which indicates whether the
panel is LCD (001b) or OLED (010b).

Store the result in drm_display_info.did_panel_type so that downstream
drivers can use it for panel-type-dependent behavior.

Assisted-by: Copilot:Claude-Opus-4.6
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/drm_displayid_internal.h | 25 ++++++++++
 drivers/gpu/drm/drm_edid.c               | 61 +++++++++++++++++++-----
 include/drm/drm_connector.h              |  6 +++
 include/uapi/drm/drm_mode.h              |  1 +
 4 files changed, 82 insertions(+), 11 deletions(-)

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
index 8031f021d4d0..9b160a878df4 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -6713,6 +6713,8 @@ static void drm_reset_display_info(struct drm_connector *connector)
 
 	info->source_physical_address = CEC_PHYS_ADDR_INVALID;
 	memset(&info->amd_vsdb, 0, sizeof(info->amd_vsdb));
+
+	info->did_panel_type = DRM_MODE_PANEL_TYPE_UNKNOWN;
 }
 
 static void update_displayid_info(struct drm_connector *connector,
@@ -6721,24 +6723,61 @@ static void update_displayid_info(struct drm_connector *connector,
 	struct drm_display_info *info = &connector->display_info;
 	const struct displayid_block *block;
 	struct displayid_iter iter;
+	const u8 *section = NULL;
 
 	displayid_iter_edid_begin(drm_edid, &iter);
 	displayid_iter_for_each(block, &iter) {
+		if (section != iter.section) {
+			drm_dbg_kms(connector->dev,
+				    "[CONNECTOR:%d:%s] DisplayID extension version 0x%02x, primary use 0x%02x\n",
+				    connector->base.id, connector->name,
+				    displayid_version(&iter),
+				    displayid_primary_use(&iter));
+			if (displayid_version(&iter) == DISPLAY_ID_STRUCTURE_VER_20 &&
+			    (displayid_primary_use(&iter) == PRIMARY_USE_HEAD_MOUNTED_VR ||
+			     displayid_primary_use(&iter) == PRIMARY_USE_HEAD_MOUNTED_AR))
+				info->non_desktop = true;
+			section = iter.section;
+		}
+
 		drm_dbg_kms(connector->dev,
-			    "[CONNECTOR:%d:%s] DisplayID extension version 0x%02x, primary use 0x%02x\n",
+			    "[CONNECTOR:%d:%s] DisplayID block tag 0x%02x, rev 0x%02x, size %u\n",
 			    connector->base.id, connector->name,
-			    displayid_version(&iter),
-			    displayid_primary_use(&iter));
+			    block->tag, block->rev, block->num_bytes);
+
 		if (displayid_version(&iter) == DISPLAY_ID_STRUCTURE_VER_20 &&
-		    (displayid_primary_use(&iter) == PRIMARY_USE_HEAD_MOUNTED_VR ||
-		     displayid_primary_use(&iter) == PRIMARY_USE_HEAD_MOUNTED_AR))
-			info->non_desktop = true;
+		    block->tag == DATA_BLOCK_2_DISPLAY_PARAMETERS) {
+			const struct displayid_display_params_block *params =
+				(const struct displayid_display_params_block *)block;
+			u8 tech;
+
+			if (block->num_bytes < DISPLAYID_DISPLAY_PARAMS_MIN_LEN) {
+				drm_dbg_kms(connector->dev,
+					    "[CONNECTOR:%d:%s] DisplayID Display Parameters block too short (%u < %zu)\n",
+					    connector->base.id, connector->name,
+					    block->num_bytes,
+					    DISPLAYID_DISPLAY_PARAMS_MIN_LEN);
+				continue;
+			}
 
-		/*
-		 * We're only interested in the base section here, no need to
-		 * iterate further.
-		 */
-		break;
+			tech = FIELD_GET(DISPLAYID_DISPLAY_PARAMS_DEVICE_TECH,
+					 params->device_tech_byte);
+
+			drm_dbg_kms(connector->dev,
+				    "[CONNECTOR:%d:%s] DisplayID Display Parameters: device technology %u\n",
+				    connector->base.id, connector->name, tech);
+
+			switch (tech) {
+			case 1: /* LCD */
+				info->did_panel_type = DRM_MODE_PANEL_TYPE_LCD;
+				break;
+			case 2: /* OLED */
+				info->did_panel_type = DRM_MODE_PANEL_TYPE_OLED;
+				break;
+			default:
+				break;
+			}
+		}
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

