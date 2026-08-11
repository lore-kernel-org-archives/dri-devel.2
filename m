Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A13FC5AD55
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 00:39:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3500D10EA28;
	Tue, 11 Aug 2026 00:39:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h4CqBk/3";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011028.outbound.protection.outlook.com [52.101.62.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75E1610E25B;
 Tue, 11 Aug 2026 00:38:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZwCbtpaKufL70e8p05HmmRf6e/Jw5yX+Xxy4gK3ZR5RgAhMF/lmHQ5KT7ACESv9atWTkrW5OODbNZ0W5wUNBRKgXckLRFSk6IX2HeaXeiuWB2LcoOohM3k98DzQnBawZT2ddWmV2W6o/OHJsZFExFIjKTLaMyBDvLu0JLhl5yZdNcKH7Po5oEbHdBCErw8fGz0vOstqPG106iBRJMSsNlg8b1EB9WmAcVQjH1giNvo/ojZSQEJ31e+PqekH2AW9rk82BdbYhgCL1M+7gtljZ79eKFVG5xH8LPLIVR/XZy+hMKVy7AMOfpvNybO8UHG8y8c4T7bDkw5DO1PfjNIifSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jDqkSutGDtaOPGlpQNv/KaLWhLWrtK4V6TT+I5NSOq0=;
 b=vLz+uHUzb6YQcKPWekQvYlxkUr+Y/0y7jE5KW3r3EfiMeZXf+f5cIaUEbdHRZFvl8dBT3kU3LsIhmKk9WJYPI7XSgHbzHVbqYKWJKTMhsS2Cw9ilqzGYILeaLwlbT0owCn4RnFuZqcXRINBA1zpyJCRHdoj+LaTQvVn/pA3Gp5FyRsiCwH2lLEFiOfPuVAjQ0bBw01xrefDEpAW5qw+LxIFRDSqJ7prASpdHZIC9fOBL3qLlwhgtiWnc1cWn11eqhH5ZtGw2+6lrl00rbsLYiDiDq6KXjpUDTv+IaEJx65Emx32CuSEwiB8/cvs7/BXGgpcxuv7AjXJ5kXSqMFb9qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDqkSutGDtaOPGlpQNv/KaLWhLWrtK4V6TT+I5NSOq0=;
 b=h4CqBk/3fmw/757a68tR0CEn0WoQh9QJuhDdH34GVZ6JjEfXRIuHezNrNVs9aMPKm/3tS8lF3nrK9SjHwMZP06tGz/Ls+u7j0uVSgADZoaqDWQeY+fOtTfp70XsCfdXGg29rlmMn7BCssGUJFQhnL8qHoyniX7e/jPBqxWY2qjA=
Received: from MW4PR02CA0008.namprd02.prod.outlook.com (2603:10b6:303:16d::27)
 by DM4PR12MB6086.namprd12.prod.outlook.com (2603:10b6:8:b2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 00:38:43 +0000
Received: from CO1PEPF000066EA.namprd05.prod.outlook.com
 (2603:10b6:303:16d:cafe::1) by MW4PR02CA0008.outlook.office365.com
 (2603:10b6:303:16d::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Tue,
 11 Aug 2026 00:38:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066EA.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 00:38:42 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 10 Aug
 2026 19:38:41 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Harry Wentland
 <harry.wentland@amd.com>, =?UTF-8?q?Tomasz=20Paku=C5=82a?=
 <tomasz.pakula.oficjalny@gmail.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>,
 Bernhard Berger <bernhard.berger@gmail.com>
Subject: [PATCH v3 2/4] drm/edid: parse HDMI 2.1 gaming (ALLM/VRR)
 capabilities from HF-VSDB
Date: Mon, 10 Aug 2026 20:39:19 -0400
Message-ID: <20260811003921.1398292-3-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811003921.1398292-1-jerry.zuo@amd.com>
References: <20260806205449.16806-1-jerry.zuo@amd.com>
 <20260811003921.1398292-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EA:EE_|DM4PR12MB6086:EE_
X-MS-Office365-Filtering-Correlation-Id: 69830982-4d90-4fe8-9077-08def740e523
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|22082099003|18002099003|56012099006|10067099003|11063799006|5023799004|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info: 3knNpYie55HyuGc5KlS6mtMaLK3SQENy7qNLl40b+3TGXj6uj86gGVR+bp60HnMp73yH2ypPDMH887veP3J6rfKaHIOAG1fxfOWsM1oruwk6aB+/dxnuWD4dzg2/y628t4Ldcz21Kdk/D5DNtLSQdU4BqmIUi1qtOvEZQY3n9Q03d45R25KBOrXW7hjtNfxGtC1HWBIn5QUubY1OMyMKuRQ8iPKKuLutwu05hEqpB5D2Nibdy4ECxfz+Y77DF9xKKrUIIWowllvi3debt+kfClFgpVARrgYH1p2kiWK7p803Inp6eDpczfWgqAHZy5QvFJCdzidvHZIMtmsheGnrcdLVoKC8TpZRj0McH0dfAwp15yQgUqr7Uo1RHvsvt5yh0RiAyJfnenqg2OXtXJtxm9a6SDmMKJK+j/ldt/LGgpga655BIBuPVrufuDFnD+GV3436xk1IZP29p412XZr8ib8+rWV+2z8V3TsNR4zIiWcfHhPyT+NbJ18huC0EFucBVr0FsN3qLDaWIQK1PPod8+vT2FU5D3g3+Xehdy/JGv3LNQRwoaKjUcqmcUEUTZXkDH8e3GsxN9602/mtxjIrdZ408h40lbHK6+mPd3/YeQkE1aRirr1k2l8WvnKDMRuHJIKzlDChg+UrSHOjPpGmZg1Va6iLyKxLOOwrChnY+ypOmLkb5y0rtev04sGC7c0AT89uYadqh/XKv+IcTkO7fQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(22082099003)(18002099003)(56012099006)(10067099003)(11063799006)(5023799004)(4143699003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: woKkFAfB/IKFhExrLYfIQU02bjIbQsqfUWYRxVJc1K7cN1IRkRPeplK5Bt50XDhfr5ZUM7RiPllGkhUX9rVYeJDgUcpHXNykoqgeZJw4hJJLUBMsnUwG4FoMOZ006qcIOS/bJRbwK3ARWLLFzhZuGCNk5rh9Xj7CNcIYEOGDzaotfGtYiN//wY5MarbNGowe2szi2bVY9qclsdiYjhnCxSjNT+sRojSmOUDAXueMG9VA/hDHPYOC5D2v40amCZAa/Ayb2vAJcwmvhDJw9O4+ED3uYVBMi/vonVQ86pDPNJ5quW4NKqBmZm8xkuGCyqeBV6YbViTUoTyl8obiIQxySqBME9Eb+ce7QYDsNq67FILc+QFsqcTMDFeihllToLtUYhifdJHurIvS2W8SF6hVokVJnFAx6GlJKzrpClqYnDfQw1lHoJQSsoF/iHwG4lOp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 00:38:42.6126 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69830982-4d90-4fe8-9077-08def740e523
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6086
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

