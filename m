Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A5ECF53D96
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 20:49:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6220410E32B;
	Mon, 16 Mar 2026 20:49:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZOxA7A/H";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010039.outbound.protection.outlook.com
 [40.93.198.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54E2F10E32B
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 20:49:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TTh5qEzPwi6Cq7UEQcXgPSTVszlR2CsReEx/PLAsTrN2qFmA2CrmQxYSllxsFgbTXEScc54Ks27bH9Ch3iBGxQPqFbvm5MM+uIygOge87GICVB6ixAkDNrJFpXggepbFyVBgjzrbCCfyGHWJz+usIBSN3jbVgXMpGhOSEoDVYHMau0+1zGZiqDEO5vVtVjw/ZfqfoIeOQTn5zMw6QdOjmAznLzMAYvW1frAOx1sv1w+mfAzVXrieabyvkw8PtRDdzubhayvJAeecatSTy6JaXLpObo9HBm83LPU0pJ1u8eTW4OJn2Eb9IlWt6evt+LNL9pF+5AvfYxdcbLWEPhp3dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K6czNdzarOm4ex6F/hI2qOJPKH4VLARCz0F5hiEpgzA=;
 b=JfIr4URQnk96KjGn6F5s24Q282UfZgQtvrId2UJral4eMOojvMT5ByrAc9NluP1zN4y4gi4aPVl8Tzjt/mC81ukePtzzhDaOV0wpiRQxRw00qmR/7dnqEWxtTIJhimnWGWdd0CyjqQYRZUNDgoGYNksVR4VAs3V2PSokcJ34QGcliZxsEwPFOMn4JInVFTZjjlproeu2CVlvpZohuYn3T5+I8sf3YsTdpo+hvKFALc2X61DDPi4qs7EvXl7gJDjWcmgsgfKx2Tc74tETzWC0qxoiAh/LsJ6d3HdhkD9pTAagbyEtZWSXHTDVAeZVhW0OuSp06tiHuEMJkGy/BiiSlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K6czNdzarOm4ex6F/hI2qOJPKH4VLARCz0F5hiEpgzA=;
 b=ZOxA7A/HcaM6TVr3CcubpLCM1OScsYhDKkcQXyTZFUgsReDzrjxMTz5etE6L4geRKCweNaFUJRVZmWdjHx4cV4Il/0+LQthSYepZ1Uzqfv59jnsRx98mHyY2Ia8p19frJWQEBAxRksQGkeisRBB55ySV5J1XD/elQdaT1wj+npM=
Received: from SA1P222CA0119.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::18)
 by PH8PR12MB6938.namprd12.prod.outlook.com (2603:10b6:510:1bd::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 20:49:08 +0000
Received: from SA2PEPF00003F67.namprd04.prod.outlook.com
 (2603:10b6:806:3c5:cafe::e6) by SA1P222CA0119.outlook.office365.com
 (2603:10b6:806:3c5::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.25 via Frontend Transport; Mon,
 16 Mar 2026 20:49:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003F67.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Mon, 16 Mar 2026 20:49:08 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 16 Mar
 2026 15:49:08 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 16 Mar
 2026 13:49:07 -0700
Received: from aaurabin-tumbleweed.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Mon, 16 Mar 2026 15:49:07 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <dri-devel@lists.freedesktop.org>
CC: Simona Vetter <simona@ffwll.ch>, David Airlie <airlied@gmail.com>, "Thomas
 Zimmermann" <tzimmermann@suse.de>, Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/edid: fix off-by-2 byte offsets in HF-SCDB parsing
Date: Mon, 16 Mar 2026 16:49:07 -0400
Message-ID: <20260316204907.3852592-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F67:EE_|PH8PR12MB6938:EE_
X-MS-Office365-Filtering-Correlation-Id: aabe38c1-3c70-402f-6919-08de839d782e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 0dDS1C6hxzXD14GmKpu/jDf2lTJFCydmY1zOJUPZTPdhp8GX84OboCcgSFq1sWExm6Zn6EfWqvrTjVdQq1R1B82zSJgf21PE9hwEmLIL/KZsjdGRpTC/26qfxIhH30KPihYAva0HzxjE++9TcMifZOYAzLhMEELzojL3rrcLFk1L8HNDJWMRGYWwdeFEun88nH8UF6QFh4+INFQ0vfbtGpPGFzwrSVyLk6stpokMRs2NEAeTnO3Qac4BWL61ASKtBJdRx5oqNQPUc8B/kRJ87tzu8RqmupaXIptjmTXqrmujf4xbJpGwPJ4nk874E8URMAvp1yLvms2DhOfmrGzMaZM7xQfVL9qLeSvYF+fQmByoQhSQDS50EQ6DEw2N44ZyBVVrvoRDXW1v5gXCDDBiPiKIKABRyaDF2aZHGQhwKkMTcahto8bFB/ELaoAIHxblSVkXJaYd2ZS7/iN3L1KGLL6csi9iZJF2ofVrInwxJGMOnJ+md9p8eYDQmy4eWeLrFOp0nXRIjB63fuBogFTN3BI/0jISleC08zpt/ovLuCFPKEDu+kd54Lgsyi3OqFDy33tle30XhNgedczM1LQOXsuWFa3m3XJnf1TqnswQiMjCuOE/iK5EHoFPamS1CgZwVTIkiDg/V3P9hLLl0htvMhuooMlxpeoFYVvf3O4vhnNoeohVxNocw8Xj8bCy+1P6D+OZzLXSGKfGZieB1KvZY+1dWMNfWsHsFRwqX8Jg6qoPICvZ9+qd/hWXdch1HE9qJVmUA6/2gNlscon2sDFnkg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CTEf8/7uFPhvoeIGeOiJ1KCHBRIUjDkST5rBKpSBU71DKY2NG2kYi3Mwq/mj2dqf/XN5k5AEBN/FBBkJGVeMnzSzTkdt9oabTVQMVO/gVXX+buYyUkZZ/hxGRAE6NjjDNljl1sBYquR9kaWoy0EXZ+3gLZhQUQZpQVnZloIubfhtwBgPBO5mcryd4I+/UBCWouesoZcnddUZUDIPB6d0fVaEVOPBfRsoKezyfAFu009kJ0mE8NR1xdC6p7dFUPXdzCcPM+sntRU6+BIgTTkJmudpw+YDGyGA14veOkWK0v4ZGeOyFAqlh8m+2hnchKuvfgBfkvMsbZwJwUAagaXm1CEnyA5W0YkzG3EdmpUNdn0uARmCF1dlD4R1RiARPAKC6CFvDEAsEHxURPnW0NNulB6XwRowpBXWX3sAfmvEVKdKeQScMcLXKalQrXPOckvs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 20:49:08.2246 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aabe38c1-3c70-402f-6919-08de839d782e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F67.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6938
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

drm_parse_hdmi_forum_scds() used HF-VSDB byte offsets for both HF-VSDB
and HF-SCDB block types. HF-VSDB has a 4-byte header (1 tag_len +
3 OUI) while HF-SCDB has a 2-byte header (1 tag_len + 1 ext_tag), so
all field accesses were off by 2 for the SCDB case.

This caused SCDC support, max TMDS clock, scrambling, FRL rate,
YCbCr420 deep color, and DSC capabilities to be read from wrong byte
positions when parsed from an HF-SCDB block.

Fix by passing a pointer to the Version byte (first field after
block-specific headers) and an explicit length to the parsing
functions, so both block types use the same normalized layout:
 - HF-VSDB: data + 4, payload_len - 3 (skip tag_len + 3-byte OUI)
 - HF-SCDB: data + 2, payload_len - 1 (skip tag_len + 1-byte ext_tag)

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/drm_edid.c | 59 +++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 26bb7710a462..13174876b04c 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -6143,45 +6143,45 @@ void drm_get_max_frl_rate(int max_frl_rate, u8 *max_lanes, u8 *max_rate_per_lane
 }
 
 static void drm_parse_ycbcr420_deep_color_info(struct drm_connector *connector,
-					       const u8 *db)
+					       const u8 *hf_scds)
 {
 	u8 dc_mask;
 	struct drm_hdmi_info *hdmi = &connector->display_info.hdmi;
 
-	dc_mask = db[7] & DRM_EDID_YCBCR420_DC_MASK;
+	dc_mask = hf_scds[3] & DRM_EDID_YCBCR420_DC_MASK;
 	hdmi->y420_dc_modes = dc_mask;
 }
 
 static void drm_parse_dsc_info(struct drm_hdmi_dsc_cap *hdmi_dsc,
-			       const u8 *hf_scds)
+			       const u8 *hf_scds, int hf_scds_len)
 {
-	hdmi_dsc->v_1p2 = hf_scds[11] & DRM_EDID_DSC_1P2;
+	hdmi_dsc->v_1p2 = hf_scds[7] & DRM_EDID_DSC_1P2;
 
 	if (!hdmi_dsc->v_1p2)
 		return;
 
-	hdmi_dsc->native_420 = hf_scds[11] & DRM_EDID_DSC_NATIVE_420;
-	hdmi_dsc->all_bpp = hf_scds[11] & DRM_EDID_DSC_ALL_BPP;
+	hdmi_dsc->native_420 = hf_scds[7] & DRM_EDID_DSC_NATIVE_420;
+	hdmi_dsc->all_bpp = hf_scds[7] & DRM_EDID_DSC_ALL_BPP;
 
-	if (hf_scds[11] & DRM_EDID_DSC_16BPC)
+	if (hf_scds[7] & DRM_EDID_DSC_16BPC)
 		hdmi_dsc->bpc_supported = 16;
-	else if (hf_scds[11] & DRM_EDID_DSC_12BPC)
+	else if (hf_scds[7] & DRM_EDID_DSC_12BPC)
 		hdmi_dsc->bpc_supported = 12;
-	else if (hf_scds[11] & DRM_EDID_DSC_10BPC)
+	else if (hf_scds[7] & DRM_EDID_DSC_10BPC)
 		hdmi_dsc->bpc_supported = 10;
 	else
 		/* Supports min 8 BPC if DSC 1.2 is supported*/
 		hdmi_dsc->bpc_supported = 8;
 
-	if (cea_db_payload_len(hf_scds) >= 12 && hf_scds[12]) {
+	if (hf_scds_len >= 9 && hf_scds[8]) {
 		u8 dsc_max_slices;
 		u8 dsc_max_frl_rate;
 
-		dsc_max_frl_rate = (hf_scds[12] & DRM_EDID_DSC_MAX_FRL_RATE_MASK) >> 4;
+		dsc_max_frl_rate = (hf_scds[8] & DRM_EDID_DSC_MAX_FRL_RATE_MASK) >> 4;
 		drm_get_max_frl_rate(dsc_max_frl_rate, &hdmi_dsc->max_lanes,
 				     &hdmi_dsc->max_frl_rate_per_lane);
 
-		dsc_max_slices = hf_scds[12] & DRM_EDID_DSC_MAX_SLICES;
+		dsc_max_slices = hf_scds[8] & DRM_EDID_DSC_MAX_SLICES;
 
 		switch (dsc_max_slices) {
 		case 1:
@@ -6219,13 +6219,13 @@ static void drm_parse_dsc_info(struct drm_hdmi_dsc_cap *hdmi_dsc,
 		}
 	}
 
-	if (cea_db_payload_len(hf_scds) >= 13 && hf_scds[13])
-		hdmi_dsc->total_chunk_kbytes = hf_scds[13] & DRM_EDID_DSC_TOTAL_CHUNK_KBYTES;
+	if (hf_scds_len >= 10 && hf_scds[9])
+		hdmi_dsc->total_chunk_kbytes = hf_scds[9] & DRM_EDID_DSC_TOTAL_CHUNK_KBYTES;
 }
 
 /* Sink Capability Data Structure */
 static void drm_parse_hdmi_forum_scds(struct drm_connector *connector,
-				      const u8 *hf_scds)
+				      const u8 *hf_scds, int hf_scds_len)
 {
 	struct drm_display_info *info = &connector->display_info;
 	struct drm_hdmi_info *hdmi = &info->hdmi;
@@ -6236,9 +6236,9 @@ static void drm_parse_hdmi_forum_scds(struct drm_connector *connector,
 
 	info->has_hdmi_infoframe = true;
 
-	if (hf_scds[6] & 0x80) {
+	if (hf_scds[2] & 0x80) {
 		hdmi->scdc.supported = true;
-		if (hf_scds[6] & 0x40)
+		if (hf_scds[2] & 0x40)
 			hdmi->scdc.read_request = true;
 	}
 
@@ -6251,11 +6251,11 @@ static void drm_parse_hdmi_forum_scds(struct drm_connector *connector,
 	 * Lets check it out.
 	 */
 
-	if (hf_scds[5]) {
+	if (hf_scds[1]) {
 		struct drm_scdc *scdc = &hdmi->scdc;
 
 		/* max clock is 5000 KHz times block value */
-		max_tmds_clock = hf_scds[5] * 5000;
+		max_tmds_clock = hf_scds[1] * 5000;
 
 		if (max_tmds_clock > 340000) {
 			info->max_tmds_clock = max_tmds_clock;
@@ -6265,21 +6265,21 @@ static void drm_parse_hdmi_forum_scds(struct drm_connector *connector,
 			scdc->scrambling.supported = true;
 
 			/* Few sinks support scrambling for clocks < 340M */
-			if ((hf_scds[6] & 0x8))
+			if ((hf_scds[2] & 0x8))
 				scdc->scrambling.low_rates = true;
 		}
 	}
 
-	if (hf_scds[7]) {
-		max_frl_rate = (hf_scds[7] & DRM_EDID_MAX_FRL_RATE_MASK) >> 4;
+	if (hf_scds[3]) {
+		max_frl_rate = (hf_scds[3] & DRM_EDID_MAX_FRL_RATE_MASK) >> 4;
 		drm_get_max_frl_rate(max_frl_rate, &hdmi->max_lanes,
 				     &hdmi->max_frl_rate_per_lane);
 	}
 
 	drm_parse_ycbcr420_deep_color_info(connector, hf_scds);
 
-	if (cea_db_payload_len(hf_scds) >= 11 && hf_scds[11]) {
-		drm_parse_dsc_info(hdmi_dsc, hf_scds);
+	if (hf_scds_len >= 8 && hf_scds[7]) {
+		drm_parse_dsc_info(hdmi_dsc, hf_scds, hf_scds_len);
 		dsc_support = true;
 	}
 
@@ -6444,9 +6444,14 @@ static void drm_parse_cea_ext(struct drm_connector *connector,
 
 		if (cea_db_is_hdmi_vsdb(db))
 			drm_parse_hdmi_vsdb_video(connector, data);
-		else if (cea_db_is_hdmi_forum_vsdb(db) ||
-			 cea_db_is_hdmi_forum_scdb(db))
-			drm_parse_hdmi_forum_scds(connector, data);
+		else if (cea_db_is_hdmi_forum_vsdb(db))
+			drm_parse_hdmi_forum_scds(connector,
+						  data + 4,
+						  cea_db_payload_len(db) - 3);
+		else if (cea_db_is_hdmi_forum_scdb(db))
+			drm_parse_hdmi_forum_scds(connector,
+						  data + 2,
+						  cea_db_payload_len(db) - 1);
 		else if (cea_db_is_microsoft_vsdb(db))
 			drm_parse_microsoft_vsdb(connector, data);
 		else if (cea_db_is_y420cmdb(db))
-- 
2.53.0

