Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42BE3C5AC82
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 20:54:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3352410F2D4;
	Thu,  6 Aug 2026 20:54:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uCRvK5a6";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010040.outbound.protection.outlook.com
 [40.93.198.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F8F210F2BA;
 Thu,  6 Aug 2026 20:54:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YC+Dggr2ru35cdmHzPXO0nP1xm9G7054WDc59Eau+TzZ2XL0Gb8eh7u8DJNa3/2z7q6OnErIFgj9tK05JU/ssXAUotzFO8SitLF3UsNjmFBKGIGahMatQJnR8ECw8atnN461idfGjATiEoTRlBdq7F9dvEIN0v3d9mgfe8GBChsbha9XxyvNzfUpdPjL/8zgu4kysIEkkxKrvgfQnTqook8tzmCHlOInSmape9y4uQrSgBjzmWVacUrfsUGIkGzX696IyBCcJPDh/sI/vj1s5Fiu3UWCqP4MkjIIS3RS8+otG7NQ49D+gJldXB4rbnQT4NKyth06tewXMth6Qc6ZJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QqtqTaHYs7StWdprnXyAIzlUFMZ3njXz0cT196Y+Z7s=;
 b=H0gQpI6E8nZ3jG57SiOvVd5Og+w7+pXDvlt3zmvsvxIOJ7vf8TCBgExvo1rXL+A6Fj6Pt1+Sy2wcgTaCuqFXR8ZVBJfOm2nuNH54xtitkp8P7iKOzRT7oqYnp423uCdIoInf0cEbzFYsNX4tMlgn+ekXL40A7cAKhwdwFUsYTJcQAGDL8xHhGZr7hQXFtKbeLnwgH/Omu7dimDcfZsjkhjl6i4EVZcQV+Q6mNNhmnoMefGlFJ7Bth4ZgMsIe34S1br2HHGjsMtSqkx31QHF/fx7QX4+4nHq5gFETdCYrqWbPaQWO9KcRThoulU/Ca0uq1eLiYuj/NFIg15rpLccNWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QqtqTaHYs7StWdprnXyAIzlUFMZ3njXz0cT196Y+Z7s=;
 b=uCRvK5a6aFzQ28N/iDsL94FwbJ60Y3BmxrrXd8lLslAMkAWqx+sbo/JMHLFKG7/TC8aTU4xU3t/sTXYGSrTNukTHarv3LwPgqj5p5LxKBhAUfFe4opVL9u5FTuCqbeK5dUU8ATUQuHBQ7nAlfDeZuEzg6l+XY1yyzsZPsxTTUWI=
Received: from BN8PR04CA0038.namprd04.prod.outlook.com (2603:10b6:408:d4::12)
 by DS7PR12MB8346.namprd12.prod.outlook.com (2603:10b6:8:e5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Thu, 6 Aug
 2026 20:54:01 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:408:d4:cafe::7f) by BN8PR04CA0038.outlook.office365.com
 (2603:10b6:408:d4::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.21 via Frontend Transport; Thu, 6
 Aug 2026 20:54:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Thu, 6 Aug 2026 20:54:00 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 6 Aug
 2026 15:53:56 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, =?UTF-8?q?Tomasz=20Paku=C5=82a?=
 <tomasz.pakula.oficjalny@gmail.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>,
 Bernhard Berger <bernhard.berger@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/4] drm/edid: parse HDMI 2.1 gaming (ALLM/VRR)
 capabilities from HF-VSDB
Date: Thu, 6 Aug 2026 16:54:46 -0400
Message-ID: <20260806205449.16806-3-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806205449.16806-1-jerry.zuo@amd.com>
References: <20260730171754.704049-1-jerry.zuo@amd.com>
 <20260806205449.16806-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|DS7PR12MB8346:EE_
X-MS-Office365-Filtering-Correlation-Id: b1377b20-9992-4426-d0c1-08def3fcd791
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|82310400026|1800799024|36860700016|6133799003|11063799006|5023799004|4143699003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: UsDnRpdZ7/h8jNXEWerHXbonJxsXVqdKcnsAhuGnzIEB20gAXrYkul4UxUfoa4sYzTsovvwkPY6jWIPTKwcqvDFxtZ0pvJKsvMBjbHxHJjxtNmxdlMoUdmW80NCeupWsK0OvNY2abjGYW+ZcBE7azhCCs8q7Rw7S1yYd+I7FPofU0c3WS9rFb7tDqbnvEgvWwnvp/L+NnvrMVztOH7erpNtjJ7SbwgkhPYr1iZbfOvazLsEsRcqWmpn4TjX4TbZNnmdmaeoaR7gNaNgoCgxrMMiGT36pIp0b2fok9C1dcF2o0na1S05LrDKa9+vB9MG0yzCVbtb3z2pk7ERahcM2xj9BREuAvr3cQE+IMC0cBEPnJ+PIzU+RBVj76lLI6AhTewMAhJ1XTkaBKVVY68mUHsSJoq1oQUaY0BTON4KuZ5YQWCZfshiCxSFHf9PqkHx2IPjfTj+WzmqnzSmcSiCWt97NRkxOVYRr5SEJUH+/jtdWCuNAW6wyJp1dhQJXZMz2Bc6Ny+qjF0AuhymLrqbZeGvDNMiYsGYobUrH8vhwo3U/aWH4VxTjCIW3QseP8yW27uHrrc3RgwrEETHL8xKrEwlkEwyjynBQGmjtC126z/enNaKrZYDY27KyXXHjr6MU0+KWBGx8j/nngp8CETRRpcbw5T0Z2dCLWGv2TDttY9QOjxgdh7IsB3dMZETKsRtISFFv92cr4ZP8MakVsqbDfQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(82310400026)(1800799024)(36860700016)(6133799003)(11063799006)(5023799004)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bUBHfehg5NXh84wnCR01ABWlofV9ZQI+AcU/ScLAb5+bNmu0x6G3wdlJO0tSaPDQjqvVVU00HuUb7ggwgVK7I1zKEKUyQ+fI6slI7vqEd2I3Zsce+7axdyjAgmrZObjK2kLlaZj2D4BohTIbcJjKifiixH3ixaKoRlVnvjnc60jzRwUo3VNeN/u16V24E/pr0vI+IY+U6bOGgbH/BZ+UjtDV7ALdhqO9PEMFp27vCRXuBuISgcvVqcUJIHWDYhCQEO1s/B5ot4FvwiXoetBn2vHk5Unrvrir5DoBQaQ4KgSkxwml1205NTFphO/G8Sdag6pFfS1ZPdta8VhR+musnhgzyrzy9whCvLVtwNJWLviYqmJxCaPNlGPlzEIJJ8QZjhbvGRZEwT/Wk0N5RkUQw1AJkb6P2pmjNbjSFbcizosWMczXbyeug6TJ4RdxrX2+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 20:54:00.6721 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1377b20-9992-4426-d0c1-08def3fcd791
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8346
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

