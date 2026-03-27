Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B6D510BA43C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 08:24:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFD3E10E40D;
	Fri, 27 Mar 2026 08:24:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XimvivjD";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012031.outbound.protection.outlook.com
 [40.93.195.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A68D510E398;
 Fri, 27 Mar 2026 08:24:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hrg50yYNJAMk1KKeg7poYyLXmchonsJ64A0kw7T0CA6Xy7bep9H7OosPjuOE36Cci4rCH85Iy8e9cMEB3LXgP0x6DdLdwLp2rkE4fgsfbxMk3DTngPze6u0/pZ7GePRkpklDITPrIPnvoVzVii4KHOgZF1IqIWnZwNjdIiS88FUQh6rCIdbPrRgZf629I5qKhr/xMse9/0tlVIv3JQvkKG8gpWPalq8KwfIDZRulYY3Kiqr4PYSIg54ENywxIiTLgcQCV3YApmjLKYlNlsXVJqCa80pjkzuO0++nxjZyT98Iq8XgVQ57B0GIVV5iiVyFfTrA9N/CtHEn41d9un5TCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4n3IxWIV1IVH9QYmj+ddhlwknVCn/ID15QsrRocUGR4=;
 b=BYOGt0kQhMHRijFP6RNtWBSayXbCm07SSqBYADSt65q04ELIiyq8C/5bdSFovXLTjHMdV9+nzeUtc74RVEWVPdsxBdAaVvJOVsEtzH21eJSUle7BfpmmuN/VthdbJUlhkahjN5bp6VYJoU9k3Hjapj50u2I4ZynIQkBezxRyh4o396OTQtHLm7ngwhDmI+a95MJ06o9V9ElUXbyP/Br6+jZzTPNSTQl80/KaCnDMZGH5+IKw7D3AGSfhhpEluWOHAKwyKp4irxGGBz7V7+uFxFDCVU3+EhzTqFLYszKFR0ULc3BL5wtgFzOVvC0StWI/hns69LNaar+7L/dSZhRNIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4n3IxWIV1IVH9QYmj+ddhlwknVCn/ID15QsrRocUGR4=;
 b=XimvivjDRvFTT/cl47SD8juxO90ScciSoAP/FHoe20fdGd/2l5CYeu1zz6SHCPruxmbj0I/zKrYf3sSdlQEQvrvcpEmqiqqMf/gD9jDXJrbYwbagIv3Mg96YVRcv707W8NfCTPE73bYFPK1dxmqjLw++dydB7FzRcsr+5F9PvVg=
Received: from CH2PR03CA0026.namprd03.prod.outlook.com (2603:10b6:610:59::36)
 by PH7PR12MB9201.namprd12.prod.outlook.com (2603:10b6:510:2e8::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Fri, 27 Mar
 2026 08:23:59 +0000
Received: from DS3PEPF0000C37E.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::3) by CH2PR03CA0026.outlook.office365.com
 (2603:10b6:610:59::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.22 via Frontend Transport; Fri,
 27 Mar 2026 08:23:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF0000C37E.mail.protection.outlook.com (10.167.23.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Fri, 27 Mar 2026 08:23:59 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 27 Mar
 2026 03:23:58 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Mar
 2026 03:23:58 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 27 Mar 2026 03:23:56 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Limonciello Mario <Mario.Limonciello@amd.com>, Chenyu Chen
 <chen-yu.chen@amd.com>
Subject: [PATCH 2/2] drm/amd/display: Use drm_display_info for AMD VSDB data
Date: Fri, 27 Mar 2026 16:21:59 +0800
Message-ID: <20260327082342.1286878-3-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327082342.1286878-1-chen-yu.chen@amd.com>
References: <20260327082342.1286878-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: chen-yu.chen@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37E:EE_|PH7PR12MB9201:EE_
X-MS-Office365-Filtering-Correlation-Id: 20ed74cc-3ff7-4c4c-2fc2-08de8bda3208
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|30052699003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: aTRcLMGBzEY6h4DMVC58MrqywgUiKhuWPdj+k8ub2Wz2+GnWgcNzm+O6LR/jSt/cmicLB+D2UXhgujNo+i0wekPbnjIHjZGI4QyyzzPLF7t2Wx6yawZYklMXPHLsaesuw2OAWRvR7hhdV8QdDHieYo32K/XUf2vURORrOpHZoPCkBpUvjhR61L9/kF6tSVqJFzIyJh7obEmPi4yCsZWvXU5dqqholBh3tDLA883t2XbtJsJiJFf1ob+koF3xEVFQe2r9GEDlpM0zPrdKrPn5YRpmSq4PEGN3j59xrDtVMje8BVPZpGaH98P/SNawvMLsGKqbL5W9s2rGiREUuOfBOcLQNduOWwXzfl1as3acdeqhrgTwEJrU6FnLY97WibbTNPcF4JNO0GEOYXUG7Fe060BognvtiTxWbWjMyjOuXx6tb2i5qJ96aomsA+4GoF9W/vqc9U3UawTQxBErZdXg2YTSv5I5NzZrSt/1bTjsKEeK9PVYc7C3/E4zUW/k8/RMBAw04fhLSVjFz++pgXUISY/QzHOhKDOJHwv+gKAK0tHlj5H++N9xyVV9IDNdabuA/e1CSOW4xYsTUx+xvVYKN9ygFExtTSxUuG9bI/6rKHGRoVqBGKx39kZAHrrLnPao36IT/1OLCftbmf0RxDQO3QCsR22KGAtJwujm1lsxaG09DJnijLwnYIUYgDYH3RssM6JrQyB6bFXnpmwS2wyB6tBcTw4SJhPGfzxTmCQsh8n02VWCqUg1T+G4AoSKsAYfOFW0kk4qR5GfPxm7yxxndg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(30052699003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: D6pFMJ4E0q+iE1FNl5LzIUrU6KTUsimzrwRQK5RJfWNBnMGbCLHEBMfpPNAEyWv3o5LVoqepHARIcwVhPF9Mhiyw08NmQwYSFUvOfTqbtlaNSDxHBBmls9io2/iRIXr+0hnwli9/96gyrrn323vFg5UGxryPykplx76QenVM4LBu1C9pPswOC0CXLZEbwwg7uNMy5Ic+oKzDjXNVxahUOhigThxMKwTNXb3JekvAyeRbNm6HfVWKsrCWrARGrv+CNodd75DR2oqtYpVBSEdLvA1xAUiG2liJipsev3spQOI8O+Bdl58IylJc6b7ZqdGBAHnnsyTpBmjE4W6Vs0Yx+2szA5Rjmls+sstM4D54cXhCKIUYHEpKT+ZZmC60xRTyAVXnPPOP6i0BScJ0l2DP83+xbaSttW6CaaPcQ9zeJT79AUURIDyIPq6khmuOvmF8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 08:23:59.1135 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20ed74cc-3ff7-4c4c-2fc2-08de8bda3208
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9201
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

Replace the raw EDID byte-walking in parse_amd_vsdb() with a read
from connector->display_info.amd_vsdb, now populated by drm_edid.

Factor out panel type determination into dm_set_panel_type(), which
checks VSDB panel_type, DPCD ext caps, and a luminance heuristic as
fallbacks.

Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 120 ++++++++++--------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  14 --
 2 files changed, 68 insertions(+), 66 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 48e12f9a1818..717e8d3feb8d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3823,6 +3823,66 @@ static struct drm_mode_config_helper_funcs amdgpu_dm_mode_config_helperfuncs = {
 	.atomic_commit_setup = amdgpu_dm_atomic_setup_commit,
 };
 
+#define DDC_MANUFACTURERNAME_SAMSUNG 0x2D4C
+
+static void dm_set_panel_type(struct amdgpu_dm_connector *aconnector)
+{
+	struct drm_connector *connector = &aconnector->base;
+	struct drm_display_info *display_info = &connector->display_info;
+	struct dc_link *link = aconnector->dc_link;
+	struct amdgpu_device *adev;
+
+	adev = drm_to_adev(connector->dev);
+
+	link->panel_type = PANEL_TYPE_NONE;
+
+	switch (display_info->amd_vsdb.panel_type) {
+	case AMD_VSDB_PANEL_TYPE_OLED:
+		link->panel_type = PANEL_TYPE_OLED;
+		break;
+	case AMD_VSDB_PANEL_TYPE_MINILED:
+		link->panel_type = PANEL_TYPE_MINILED;
+		break;
+	}
+
+	/* If VSDB didn't determine panel type, check DPCD ext caps */
+	if (link->panel_type == PANEL_TYPE_NONE) {
+		if (link->dpcd_sink_ext_caps.bits.miniled == 1)
+			link->panel_type = PANEL_TYPE_MINILED;
+		if (link->dpcd_sink_ext_caps.bits.oled == 1)
+			link->panel_type = PANEL_TYPE_OLED;
+	}
+
+	/*
+	 * TODO: get panel type from DID2 that has device technology field
+	 * to specify if it's OLED or not. But we need to wait for DID2
+	 * support in DC and EDID parser to be able to use it here.
+	 */
+
+	if (link->panel_type == PANEL_TYPE_NONE) {
+		struct drm_amd_vsdb_info *vsdb = &display_info->amd_vsdb;
+		u32 lum1_max = vsdb->luminance_range1.max_luminance;
+		u32 lum2_max = vsdb->luminance_range2.max_luminance;
+
+		if (vsdb->version && link->local_sink &&
+		    link->local_sink->edid_caps.manufacturer_id ==
+		    DDC_MANUFACTURERNAME_SAMSUNG &&
+		    lum1_max >= ((lum2_max * 3) / 2))
+			link->panel_type = PANEL_TYPE_MINILED;
+	}
+
+	if (link->panel_type == PANEL_TYPE_OLED)
+		drm_object_property_set_value(&connector->base,
+			adev_to_drm(adev)->mode_config.panel_type_property,
+			DRM_MODE_PANEL_TYPE_OLED);
+	else
+		drm_object_property_set_value(&connector->base,
+			adev_to_drm(adev)->mode_config.panel_type_property,
+			DRM_MODE_PANEL_TYPE_UNKNOWN);
+
+	drm_dbg_kms(aconnector->base.dev, "Panel type: %d\n", link->panel_type);
+}
+
 static void update_connector_ext_caps(struct amdgpu_dm_connector *aconnector)
 {
 	const struct drm_panel_backlight_quirk *panel_backlight_quirk;
@@ -3844,10 +3904,6 @@ static void update_connector_ext_caps(struct amdgpu_dm_connector *aconnector)
 	caps->ext_caps = &aconnector->dc_link->dpcd_sink_ext_caps;
 	caps->aux_support = false;
 
-	drm_object_property_set_value(&conn_base->base,
-				      adev_to_drm(adev)->mode_config.panel_type_property,
-				      caps->ext_caps->bits.oled ? DRM_MODE_PANEL_TYPE_OLED : DRM_MODE_PANEL_TYPE_UNKNOWN);
-
 	if (caps->ext_caps->bits.oled == 1
 	    /*
 	     * ||
@@ -4021,6 +4077,7 @@ void amdgpu_dm_update_connector_after_detect(
 
 		amdgpu_dm_update_freesync_caps(connector, aconnector->drm_edid);
 		update_connector_ext_caps(aconnector);
+		dm_set_panel_type(aconnector);
 	} else {
 		hdmi_cec_unset_edid(aconnector);
 		drm_dp_cec_unset_edid(&aconnector->dm_dp_aux.aux);
@@ -13167,56 +13224,15 @@ static void parse_edid_displayid_vrr(struct drm_connector *connector,
 	}
 }
 
-static int parse_amd_vsdb(struct amdgpu_dm_connector *aconnector,
-			  const struct edid *edid, struct amdgpu_hdmi_vsdb_info *vsdb_info)
+static int get_amd_vsdb(struct amdgpu_dm_connector *aconnector,
+			struct amdgpu_hdmi_vsdb_info *vsdb_info)
 {
-	u8 *edid_ext = NULL;
-	int i;
-	int j = 0;
-	int total_ext_block_len;
-
-	if (edid == NULL || edid->extensions == 0)
-		return -ENODEV;
-
-	/* Find DisplayID extension */
-	for (i = 0; i < edid->extensions; i++) {
-		edid_ext = (void *)(edid + (i + 1));
-		if (edid_ext[0] == DISPLAYID_EXT)
-			break;
-	}
-
-	total_ext_block_len = EDID_LENGTH * edid->extensions;
-	while (j < total_ext_block_len - sizeof(struct amd_vsdb_block)) {
-		struct amd_vsdb_block *amd_vsdb = (struct amd_vsdb_block *)&edid_ext[j];
-		unsigned int ieeeId = (amd_vsdb->ieee_id[2] << 16) | (amd_vsdb->ieee_id[1] << 8) | (amd_vsdb->ieee_id[0]);
-
-		if (ieeeId == HDMI_AMD_VENDOR_SPECIFIC_DATA_BLOCK_IEEE_REGISTRATION_ID &&
-				amd_vsdb->version == HDMI_AMD_VENDOR_SPECIFIC_DATA_BLOCK_VERSION_3) {
-			u8 panel_type;
-			vsdb_info->replay_mode = (amd_vsdb->feature_caps & AMD_VSDB_VERSION_3_FEATURECAP_REPLAYMODE) ? true : false;
-			vsdb_info->amd_vsdb_version = HDMI_AMD_VENDOR_SPECIFIC_DATA_BLOCK_VERSION_3;
-			drm_dbg_kms(aconnector->base.dev, "Panel supports Replay Mode: %d\n", vsdb_info->replay_mode);
-			panel_type = (amd_vsdb->color_space_eotf_support & AMD_VDSB_VERSION_3_PANEL_TYPE_MASK) >> AMD_VDSB_VERSION_3_PANEL_TYPE_SHIFT;
-			switch (panel_type) {
-			case AMD_VSDB_PANEL_TYPE_OLED:
-				aconnector->dc_link->panel_type = PANEL_TYPE_OLED;
-				break;
-			case AMD_VSDB_PANEL_TYPE_MINILED:
-				aconnector->dc_link->panel_type = PANEL_TYPE_MINILED;
-				break;
-			default:
-				aconnector->dc_link->panel_type = PANEL_TYPE_NONE;
-				break;
-			}
-			drm_dbg_kms(aconnector->base.dev, "Panel type: %d\n",
-				    aconnector->dc_link->panel_type);
+	struct drm_connector *connector = &aconnector->base;
 
-			return true;
-		}
-		j++;
-	}
+	vsdb_info->replay_mode = connector->display_info.amd_vsdb.replay_mode;
+	vsdb_info->amd_vsdb_version = connector->display_info.amd_vsdb.version;
 
-	return false;
+	return connector->display_info.amd_vsdb.version != 0;
 }
 
 static int parse_hdmi_amd_vsdb(struct amdgpu_dm_connector *aconnector,
@@ -13319,7 +13335,7 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 				freesync_capable = true;
 		}
 
-		parse_amd_vsdb(amdgpu_dm_connector, edid, &vsdb_info);
+		get_amd_vsdb(amdgpu_dm_connector, &vsdb_info);
 
 		if (vsdb_info.replay_mode) {
 			amdgpu_dm_connector->vsdb_info.replay_mode = vsdb_info.replay_mode;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index d1a14e0c12bd..63ce1f52b697 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -53,12 +53,6 @@
 
 #define AMDGPU_DMUB_NOTIFICATION_MAX 8
 
-#define HDMI_AMD_VENDOR_SPECIFIC_DATA_BLOCK_IEEE_REGISTRATION_ID 0x00001A
-#define AMD_VSDB_VERSION_3_FEATURECAP_REPLAYMODE 0x40
-#define AMD_VDSB_VERSION_3_PANEL_TYPE_MASK 0xC0
-#define AMD_VDSB_VERSION_3_PANEL_TYPE_SHIFT 6
-#define HDMI_AMD_VENDOR_SPECIFIC_DATA_BLOCK_VERSION_3 0x3
-
 enum amd_vsdb_panel_type {
 	AMD_VSDB_PANEL_TYPE_DEFAULT = 0,
 	AMD_VSDB_PANEL_TYPE_MINILED,
@@ -97,14 +91,6 @@ struct dc_plane_state;
 struct dmub_notification;
 struct dmub_cmd_fused_request;
 
-struct amd_vsdb_block {
-	unsigned char ieee_id[3];
-	unsigned char version;
-	unsigned char feature_caps;
-	unsigned char reserved[3];
-	unsigned char color_space_eotf_support;
-};
-
 struct common_irq_params {
 	struct amdgpu_device *adev;
 	enum dc_irq_source irq_src;
-- 
2.43.0

