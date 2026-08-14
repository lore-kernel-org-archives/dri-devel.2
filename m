Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50B89C5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 16:43:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9265510E585;
	Fri, 14 Aug 2026 16:43:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VReFLjaf";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011043.outbound.protection.outlook.com [52.101.62.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7125710E584;
 Fri, 14 Aug 2026 16:43:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U2BFq8RBen+rw8H6GNKL/Q3M7cGOFXEvgtU7etFSQDdnUP7BWwrE6Vinxm/a/8efjn/zoldac+2+A+qKLV0bw8ntcln9mDnleB76eX6mQF8w8mlo/1154NJUKgzI+7nfzfS/FVlVgLbKxwHiWoubPAYhYMV7yh6herAb4Bk0hPvwYvT7VbOP2mPxBHHUyKp4oA2yNYB+UAejKA5uyqSeI39eaXNi+TFYVuP4OZvHdBaSp9ra0rf/ddmOhvhIWHYS5FWlzKuCLfX1t8zfVs7xsPJ8R13KN0Yk2bJdszNaDCk+i71uhVf+kinbFK3I5IHNDEcK60mwsS3GhXR+3y0QaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jDqkSutGDtaOPGlpQNv/KaLWhLWrtK4V6TT+I5NSOq0=;
 b=EO07/rGz+LEFPfHsHN/lUflD/ilXSiKpUouQHBcWNAJLwKYmPZAX+IO1NpiEctqe3vYme/PAXc1vrO9COFG9nRQSDjcMNDAffgmKRLSjnFv8DPnxDqnTqipW5jvlRoWwvCq5nsH1pWlRZuuctzDGVZvC7ozsRQlvws6qjOKFr+mV5oc0AQUdLIemIjRFEMIxjPBzHwr3JOfLk/LCWOkHnHILDl0wdxEnARUeAIL8C66xg62OddRqKpLlMO09Rd1r5yQfguGiJou0BTi/2CI7poaomZMA9vDFRq+A1kJTxDkQFjfDIwwODxOPFkLO28SNl1d1AzUFf0A8S2Sx8qYv3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDqkSutGDtaOPGlpQNv/KaLWhLWrtK4V6TT+I5NSOq0=;
 b=VReFLjafYOZ9ymPqUTCrqZdF9jY22b3a/UIKzLxUnFgvr0XuB+g3b2gBqquK170P3j/BU3TA2f4y+9U5uPlO6HYAcXAs2km1SwSVHlWGvu9RX2C/eHC/kz1tqHVM88MaHmzt6j0pIbw0mAyMptnuDum7I/yriR+Byijg6V5NQD0=
Received: from BL1PR13CA0009.namprd13.prod.outlook.com (2603:10b6:208:256::14)
 by IA0PPF04DCE520E.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bc5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 16:43:31 +0000
Received: from BN3PEPF0000B36E.namprd21.prod.outlook.com
 (2603:10b6:208:256:cafe::87) by BL1PR13CA0009.outlook.office365.com
 (2603:10b6:208:256::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.5 via Frontend Transport; Fri, 14
 Aug 2026 16:43:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B36E.mail.protection.outlook.com (10.167.243.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.0 via Frontend Transport; Fri, 14 Aug 2026 16:43:31 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 11:43:27 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Harry Wentland
 <harry.wentland@amd.com>, =?UTF-8?q?Tomasz=20Paku=C5=82a?=
 <tomasz.pakula.oficjalny@gmail.com>, <daniel@fooishbar.org>, Fangzhi Zuo
 <Jerry.Zuo@amd.com>, Bernhard Berger <bernhard.berger@gmail.com>
Subject: [PATCH v4 2/4] drm/edid: parse HDMI 2.1 gaming (ALLM/VRR)
 capabilities from HF-VSDB
Date: Fri, 14 Aug 2026 12:43:42 -0400
Message-ID: <20260814164344.3098143-3-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260814164344.3098143-1-jerry.zuo@amd.com>
References: <20260811003921.1398292-1-jerry.zuo@amd.com>
 <20260814164344.3098143-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36E:EE_|IA0PPF04DCE520E:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f911497-8b93-4541-18d0-08defa232c87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|11063799006|5023799004|56012099006|18002099003|22082099003|10067099003|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info: qbe3puRuU1L7wwBxRs26hOXONez974vFR8XsRdwk4BUdHnN5z7x2+fSWti3K/m3wj97REetzxbxXMV3KAoa7fJ+4yBwcOytsHU+ruQzpvaFpbTyBVZXH066CbUGDc0tpQnV0/CiWpYA62uO380WfQMTRo2vNTZIyGM8QlcENRWuJ8N5cmo/iGKaCvcpHjM00hUA69y+NeuEjlkjn43o/09zN4zcC/w1kW+1O7ZS0eQlkvoBhh5EMktaLL9Pc7wpD4jwFzOmMaMhePRTgjnACMJjkE9oHJEJzs3q5hs8vbS6etw9dVQQ2GOEY9e0AEEjh/G1PHcoRU106rBFKCEhgJSyPGZ8vBm/2X4szlP5daAUWW1xwb4A8QDXQZ937BW0xTUI8xzQnYpoH57VxJgf42S96/n3eil1cfXcxxV+8sd1OSkDReaC+79xaUDfZqAfdYoJZraxmlhkSQWVcLjTR2Hj4SuMVajg3E+ezV9gJSVEoHBYg25VoiZGGAwI18yR6KnDUKbqcammHTNuAtUOFTLhkDVfqx6rnU96mYj38LBpkfD8huYDY7IVQ262hfYNHVadIxox+Z10Wy2L0KM1EPeDZ7m6gVnhzfbIfTTSkGxI9DzIUTCxLA1fKYoO1A3RMPLhZN990KCvDHy0FnAD46J61AnvWc+n6d/fQauO0zZIs0Pt2xh8lUcteW1yB/V9YvC5V4/YK/WlBDnEo9WpSMA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(11063799006)(5023799004)(56012099006)(18002099003)(22082099003)(10067099003)(4143699003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MofEThZQusohMhxdmtp6O+TOu+ONiPdiwVadBPYzUha6OPzUerxM6YWcP7CrI1JOhJtlTDWXEsQAidOGstQmeRNOrXgv71FjLbQgXdlb1kqlrD483MorWI3Nuekkgq/ZO0CvSvncnxjft30HVYa+M+WxjQJRiekRNw06hVZXXkFNhALxe3aZhDzp9JR+ZiDVdKkOQF+yjyMjWxCeqtsNRRRVy1z5SxPP+n3j8bJDG6X8jHwTENgITSHSRZC09NXOYuorskDYO7pIJsaFIMNKNp5cUkMwY8bHFXmP6NTaEweNUI4+fv2N/w4sS3+bYIrFf8EvYn1UM5q5Nycm8iJwu09W/4jcjGBZl4ob92S3Ovum8JV0QWFMFsMh4chCfBgjtY8WJD1sE2JnlbDriImhgOPxyvrjukkrqjYFDq3tikksuhUqbpTUMpp8OPFQBeBp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 16:43:31.0604 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f911497-8b93-4541-18d0-08defa232c87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF04DCE520E
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

From: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>

Parse the HDMI 2.1 gaming-related capabilities advertised in the HDMI
Forum VSDB (HF-VSDB) and expose them through struct drm_hdmi_info so
drivers can consume them.

Add struct drm_hdmi_vrr_cap describing the sink's VRR capabilities: Fast
VActive (Quick Frame Transport), Negative M VRR, Cinema VRR, MDelta, and
the VRRmin/VRRmax range, together with a "supported" flag derived from
that range. Add the fapa_start_location and allm (Auto Low Latency Mode)
flags to struct drm_hdmi_info.

drm_parse_hdmi_gaming_info() reads byte 8 of the HF-VSDB for the
FAPA/ALLM/FVA/CNMVRR/CinemaVRR/MDelta flags and bytes 9-10 for
VRRmin/VRRmax. Per HDMI 2.1, VRR is considered supported when VRRmin is
within 1-48 and VRRmax is either 0 (maximum based on the video mode) or
>= 100. It is invoked from drm_parse_hdmi_forum_scds(), and the parsed
values are logged for debugging.

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
Tested-by: Bernhard Berger <bernhard.berger@gmail.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/drm_edid.c  | 42 +++++++++++++++++++++++++++++++++
 include/drm/drm_connector.h | 47 +++++++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index ae26618a9a57..d508ec633c9b 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -6182,6 +6182,33 @@ static void drm_parse_ycbcr420_deep_color_info(struct drm_connector *connector,
 	hdmi->y420_dc_modes = dc_mask;
 }
 
+static void drm_parse_hdmi_gaming_info(struct drm_hdmi_info *hdmi, const u8 *db)
+{
+	struct drm_hdmi_vrr_cap *vrr = &hdmi->vrr_cap;
+
+	if (cea_db_payload_len(db) < 8)
+		return;
+
+	hdmi->fapa_start_location = db[8] & DRM_EDID_FAPA_START_LOCATION;
+	hdmi->allm = db[8] & DRM_EDID_ALLM;
+	vrr->fva = db[8] & DRM_EDID_FVA;
+	vrr->cnmvrr = db[8] & DRM_EDID_CNMVRR;
+	vrr->cinema_vrr = db[8] & DRM_EDID_CINEMA_VRR;
+	vrr->mdelta = db[8] & DRM_EDID_MDELTA;
+
+	if (cea_db_payload_len(db) < 9)
+		return;
+
+	vrr->vrr_min = db[9] & DRM_EDID_VRR_MIN_MASK;
+	vrr->supported = (vrr->vrr_min > 0 && vrr->vrr_min <= 48);
+
+	if (cea_db_payload_len(db) < 10)
+		return;
+
+	vrr->vrr_max = (db[9] & DRM_EDID_VRR_MAX_UPPER_MASK) << 2 | db[10];
+	vrr->supported &= (vrr->vrr_max == 0 || vrr->vrr_max >= 100);
+}
+
 static void drm_parse_dsc_info(struct drm_hdmi_dsc_cap *hdmi_dsc,
 			       const u8 *hf_scds)
 {
@@ -6308,6 +6335,8 @@ static void drm_parse_hdmi_forum_scds(struct drm_connector *connector,
 
 	drm_parse_ycbcr420_deep_color_info(connector, hf_scds);
 
+	drm_parse_hdmi_gaming_info(&connector->display_info.hdmi, hf_scds);
+
 	if (cea_db_payload_len(hf_scds) >= 11 && hf_scds[11]) {
 		drm_parse_dsc_info(hdmi_dsc, hf_scds);
 		dsc_support = true;
@@ -6317,6 +6346,19 @@ static void drm_parse_hdmi_forum_scds(struct drm_connector *connector,
 		    "[CONNECTOR:%d:%s] HF-VSDB: max TMDS clock: %d KHz, HDMI 2.1 support: %s, DSC 1.2 support: %s\n",
 		    connector->base.id, connector->name,
 		    max_tmds_clock, str_yes_no(max_frl_rate), str_yes_no(dsc_support));
+	drm_dbg_kms(connector->dev,
+		    "[CONNECTOR:%d:%s] FAPA in blanking: %s, ALLM support: %s, Fast Vactive support: %s\n",
+		    connector->base.id, connector->name, str_yes_no(hdmi->fapa_start_location),
+		    str_yes_no(hdmi->allm), str_yes_no(hdmi->vrr_cap.fva));
+	drm_dbg_kms(connector->dev,
+		    "[CONNECTOR:%d:%s] Negative M VRR support: %s, CinemaVRR support: %s, Mdelta: %d\n",
+		    connector->base.id, connector->name, str_yes_no(hdmi->vrr_cap.cnmvrr),
+		    str_yes_no(hdmi->vrr_cap.cinema_vrr), hdmi->vrr_cap.mdelta);
+	drm_dbg_kms(connector->dev,
+		    "[CONNECTOR:%d:%s] VRRmin: %u, VRRmax: %u, VRR supported: %s\n",
+		    connector->base.id, connector->name, hdmi->vrr_cap.vrr_min,
+		    hdmi->vrr_cap.vrr_max, str_yes_no(hdmi->vrr_cap.supported));
+
 }
 
 static void drm_parse_hdmi_deep_color_info(struct drm_connector *connector,
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index cd06a3b914a0..9f8f109c2dd1 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -254,6 +254,44 @@ struct drm_scdc {
 	struct drm_scrambling scrambling;
 };
 
+/**
+ * struct drm_hdmi_vrr_cap - Information about VRR capabilities of a HDMI sink
+ *
+ * Describes the VRR support provided by HDMI 2.1 sink. The information is
+ * fetched fom additional HFVSDB blocks defined for HDMI 2.1.
+ */
+struct drm_hdmi_vrr_cap {
+	/** @fva: flag for Fast VActive (Quick Frame Transport) support */
+	bool fva;
+
+	/** @mcnmvrr: flag for Negative M VRR support */
+	bool cnmvrr;
+
+	/** @mcinema_vrr: flag for Cinema VRR support */
+	bool cinema_vrr;
+
+	/** @mdelta: flag for limited frame-to-frame compensation support */
+	bool mdelta;
+
+	/**
+	 * @vrr_min : minimum supported variable refresh rate in Hz.
+	 * Valid values only inide 1 - 48 range
+	 */
+	u16 vrr_min;
+
+	/**
+	 * @vrr_max : maximum supported variable refresh rate in Hz (optional).
+	 * Valid values are either 0 (max based on video mode) or >= 100
+	 */
+	u16 vrr_max;
+
+	/**
+	 * @supported: flag for vrr support based on checking for VRRmin and
+	 * VRRmax values having correct values.
+	 */
+	bool supported;
+};
+
 /**
  * struct drm_hdmi_dsc_cap - DSC capabilities of HDMI sink
  *
@@ -330,6 +368,15 @@ struct drm_hdmi_info {
 	/** @max_lanes: supported by sink */
 	u8 max_lanes;
 
+	/** @fapa_start_location: flag for the FAPA in blanking support */
+	bool fapa_start_location;
+
+	/** @allm: flag for Auto Low Latency Mode support by sink */
+	bool allm;
+
+	/** @vrr_cap: VRR capabilities of the sink */
+	struct drm_hdmi_vrr_cap vrr_cap;
+
 	/** @dsc_cap: DSC capabilities of the sink */
 	struct drm_hdmi_dsc_cap dsc_cap;
 };
-- 
2.53.0

