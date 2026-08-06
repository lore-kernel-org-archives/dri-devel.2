Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C04DC5AC67
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 20:54:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CB3E10F2DC;
	Thu,  6 Aug 2026 20:54:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mfOmvi2B";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012071.outbound.protection.outlook.com
 [40.107.200.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54B9210F2B1;
 Thu,  6 Aug 2026 20:54:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pk1XZXqjEW6WDZVh2zTwJLGNcmzrExnko88mFMrqwAzJmp7ah9PlO4mhAufKSS2GYBc2iKECCjQ5x5Y6rfrkP8KfLWnyWYesdRB2c2ilBbPLdepGQ2dbzwV6R+2l0mhuJxQtHyEjOCW40YcfiMMMvROZpN9UpFUg0r/NIEalGqm4sZUOVvgrkG9i7CA6Y+MoYEXK5NaTnT24cCAbpgBz79fVVFsRhs5eEREYsHbOmz7nnz+4K9f05GL2TAMXyGKAe3gcotThbn2EptqsUT7z4RPVxpK8YStJDlug2OpOPkNK8WXTeeKQcX5nV5gWNHEk9YTviqPG2uWWQ8Lj2mqPnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mmxsv6VURkobNCHf/M6Aia80zPpYtZRDn8LwUMKFUXg=;
 b=bx1CMRtwar0VUoKGIb/FvQKC4/h5ZikcwNy0hvuUX/zRqj6M0aNiGGYH//wkvVGy/UkAX+gI3ZCTD/YVO5f0jFVJLqWcBvAYyjm7wJYsxniLGgNsxZnSVpM1lVnQyy2IP5Eskx1nhpERCOV+P0utoHxt8yosG0lp/ZCHiyxJNoSOYmAm269Hr755YNurfS0abubwq1HqEKf4wOxakH3QmecxkaLy6mpI4KuROS5L274a0FtTF1saSpBjb9f8EepZ1aSKqyL7rEmAw5z3e/MyJztlekw7Ifc+2GY0igU54QPhHEVHL7oojyOR3fYbWJsVPQt47oDRgSF5R4H6ir6+5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mmxsv6VURkobNCHf/M6Aia80zPpYtZRDn8LwUMKFUXg=;
 b=mfOmvi2BRo60/h2WOUGsV/ASV1z84RCGYgLud1f2UeCvIN/NzRbbO8jw0om/68HfA2MSkXUxw5/nkaboFFH3ExhBVT9sq//EllRtgJs//TqRY7XLXey1mL2+34Zf/hpxvnEyWoaHUqXu92WmSqecJ5nxee9MH6X4YEATwj7W4Ek=
Received: from BN8PR04CA0066.namprd04.prod.outlook.com (2603:10b6:408:d4::40)
 by SJ2PR12MB8064.namprd12.prod.outlook.com (2603:10b6:a03:4cc::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.22; Thu, 6 Aug
 2026 20:53:59 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:408:d4:cafe::38) by BN8PR04CA0066.outlook.office365.com
 (2603:10b6:408:d4::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.20 via Frontend Transport; Thu, 6
 Aug 2026 20:53:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Thu, 6 Aug 2026 20:53:57 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 6 Aug
 2026 15:53:55 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Fangzhi Zuo <Jerry.Zuo@amd.com>, "Harry
 Wentland" <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, "Rodrigo
 Siqueira" <siqueira@igalia.com>, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, open list
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/4] drm/amd/display: Add 2.1 FreeSync support for AMD VSDB
 EDID Block
Date: Thu, 6 Aug 2026 16:54:45 -0400
Message-ID: <20260806205449.16806-2-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806205449.16806-1-jerry.zuo@amd.com>
References: <20260730171754.704049-1-jerry.zuo@amd.com>
 <20260806205449.16806-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|SJ2PR12MB8064:EE_
X-MS-Office365-Filtering-Correlation-Id: 84b262de-1b46-446f-ebb4-08def3fcd591
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|22082099003|18002099003|4143699003|11063799006|5023799004|56012099006|3023799007|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: /auR8GcFQXmwoV8XfwKKPoTw1cQHSThwNc+UbNRh//jwuXq36Pqf4k8hQXpmjLk8NT5Sc4Zd8GbkVo9QjULwQ/oU33Rd73+RSUzM4nHiBIlmqxyyyg/YeL/X7+BX4mxurkJRk1EC8CZizLKB/Jx7DZbxepYaEXRCe+PxrGC1qBm+aI1yloa2S9KWXSd/jyxJQBUrE4mHt2U2b1Clll3qFnoG9Mz7fYdjsNhiXyjfMIgsB02JRe6a1BkEQinQvNvgtPZe0crvwMzr5ERXHLSAnounWOp3BSpoNGrkLrknM6tZz+zv3tq4FrhSFHPfVDMoSQuOYvBDECac9boYukoGb8p1i9+Wsdaj8ypJViO5UsjQ6JhJFl8Mtk1PhZe5Z9JdMaZourFOnRZvIm951SiArPcfVnOqLC9k54dUOQYdaDbR+Z5uxl3zxx0p1mCIv/MKeXLQT2QwkRZ1zx0LtGpgu9Hv7Y9PL9lt59ytBmAzqcE9Pe1z2ibCyZwFPQdvgk1kQFOF0T8EATco/3SHnvMe3VIaEo1PUFHSlaip1sAyhXUtF3JMugaJ6TWT9SfdY0lyrCGptgQ5ksOPo88+WuAQfvhkZb6NfCedDW91P6yxnvP5xATqda/44NxAEVNiLDu1M9lU/uoHrEHI84TKN6szGclerP96h24PYGA9GVmvCcUPQsRI7tXQ6PaqvtzEFG+cVtc6kzXJcDMrtqZ0apVl/A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(4143699003)(11063799006)(5023799004)(56012099006)(3023799007)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5bO1XrpAumGFfgtWiIHsCCOTkDYqwGHVzNAb7pX5ZaQGGGAp/i/ga95oVKwm2ABMqDy/+hVKkLrvBMD33/sWvh8n+T148Prq8FBpoLRq4AIaBBI7AuZpW+xcDkUSs6ybdHY0V/SNwDWtEDr/XSVCyoimLSG6bTZKYm8xAzFR9wcfJYbKtxK4gRuk1adsRN3InlN2B68ZR4ogCNz1Ld3+4R8JCb3iJZIbBYGBOuKMELDW6VBxIDLdeeAZw6Om3yTwiFN6wuN/BspCSoBGQgC3k+XIexbm+5upMF9cnE8jfBZB18VAURUEmzKFFylHytpQA57U+ZcZHn5sBYloE+y9yEMG1G1Gwo1IcbPHcxrUT3gYYUSwI/yfhS1AWOlgxTRh1YjuQQhyWUmb7VmZ7PssVL4Y2UhSsPft38v1DNRVKP6QQWyde6h1oFAKGpuukUfI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 20:53:57.3046 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84b262de-1b46-446f-ebb4-08def3fcd591
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8064
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

From: Fangzhi Zuo <Jerry.Zuo@amd.com>

why:
HDMI FRL sinks were not parsed for the AMD VSDB and no VTEM info packet
was emitted for them, so 2.1 FreeSync over HDMI FRL did not work. It is
backward-compatible with 2.0 FreeSync.

how:
- Accept SIGNAL_TYPE_HDMI_FRL alongside SIGNAL_TYPE_HDMI_TYPE_A when
  parsing the AMD VSDB in amdgpu_dm_update_freesync_caps().
- Build and send the VTEM info packet via mod_build_infopacket_vtem()
  when the stream signal is HDMI FRL during the freesync state update.
- Set the VTEM Data_Set_Length to 0 when no VTEM feature is enabled.
  build_infopacket_header_vtem() hardcodes Data_Set_Length = 4, so a VTEM
  with Data_Set_Length = 4 would be transmitted even when no VTEM feature
  is enabled (VRR_EN = 0 and no FVA), e.g. when the sink advertises
  VRRMIN = 0 and vrr_capable is false. This fails HDMI GCTS HF1-58 step
  6.2.
  The VTEM must keep being transmitted every MTW while VRR is enabled
  (HF1-58 steps 8.1 and 8.3), so it cannot simply be suppressed per
  frame. Instead, follow the MLDS option in HDMI 2.1 10.10.2.4: keep
  transmitting the VTEM but set Data_Set_Length = 0 when no feature is
  enabled. When VRR becomes active the full Data_Set_Length = 4 payload
  with VRR_EN = 1 is sent as before.

Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |   4 +-
 .../display/amdgpu_dm/amdgpu_dm_freesync.c    |   4 +
 .../amd/display/modules/inc/mod_info_packet.h |   4 +
 .../display/modules/info_packet/info_packet.c | 109 ++++++++++++++++++
 4 files changed, 120 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 4304520d2484..5e7ab9158995 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -3838,7 +3838,9 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 			amdgpu_dm_connector->as_type = ADAPTIVE_SYNC_TYPE_EDP;
 		}
 
-	} else if (drm_edid && sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A) {
+	} else if (drm_edid &&
+		  (sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A ||
+		   sink->sink_signal == SIGNAL_TYPE_HDMI_FRL)) {
 		i = parse_hdmi_amd_vsdb(amdgpu_dm_connector, edid, &vsdb_info);
 		if (i >= 0) {
 			amdgpu_dm_connector->vsdb_info = vsdb_info;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
index 7e484adb4120..1fa078cdba52 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
@@ -37,6 +37,7 @@
 #include "amdgpu_dm_freesync.h"
 #include "dm_helpers.h"
 #include "modules/inc/mod_freesync.h"
+#include "modules/inc/mod_info_packet.h"
 
 bool amdgpu_dm_is_dc_timing_adjust_needed(struct dm_crtc_state *old_state,
 					  struct dm_crtc_state *new_state)
@@ -229,6 +230,9 @@ void amdgpu_dm_update_freesync_state_on_stream(
 		&vrr_infopacket,
 		pack_sdp_v1_3);
 
+	if (new_stream->sink->sink_signal == SIGNAL_TYPE_HDMI_FRL)
+		mod_build_infopacket_vtem(new_stream, &vrr_params, 0, &vrr_infopacket);
+
 	new_crtc_state->freesync_vrr_info_changed |=
 		(memcmp(&new_crtc_state->vrr_infopacket,
 			&vrr_infopacket,
diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h b/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
index eee8206bc531..5181d889fe7f 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
@@ -67,6 +67,10 @@ struct AS_Df_params {
 	struct frame_duration_op decrease;
 };
 
+void mod_build_infopacket_vtem(const struct dc_stream_state *stream,
+		const struct mod_vrr_params *vrr, int fva_factor,
+		struct dc_info_packet *infopacket);
+
 void mod_build_adaptive_sync_infopacket(const struct dc_stream_state *stream,
 		enum adaptive_sync_type asType, const struct AS_Df_params *param,
 		struct dc_info_packet *info_packet);
diff --git a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
index f5ac4bf32a78..e956c707ac50 100644
--- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
+++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
@@ -291,6 +291,21 @@ void set_vsc_packet_colorimetry_data(
 	info_packet->sb[18] = 0;
 }
 
+static void setFieldWithMask(unsigned char *dest, unsigned int mask, unsigned int value)
+{
+	unsigned int shift = 0;
+
+	if (!mask || !dest)
+		return;
+
+	while (!((mask >> shift) & 1))
+		shift++;
+
+	*dest = *dest & ~mask;
+	value = value & (mask >> shift);
+	*dest = *dest | (value << shift);
+}
+
 void mod_build_vsc_infopacket(const struct dc_stream_state *stream,
 		struct dc_info_packet *info_packet,
 		enum dc_color_space cs,
@@ -644,6 +659,100 @@ void mod_build_hf_vsif_infopacket(const struct dc_stream_state *stream,
 		info_packet->valid = true;
 }
 
+static void build_vtem_infopacket_data(const struct dc_stream_state *stream,
+		const struct mod_vrr_params *vrr, int fva_factor,
+		struct dc_info_packet *infopacket)
+{
+	unsigned int fieldRateInHz;
+
+	/* FVA Factor setting */
+	setFieldWithMask(&infopacket->sb[VTEM_MD0], MASK_VTEM_MD0__FVA_FACTOR_M1,
+			(fva_factor > 0)?(fva_factor-1):0);
+	/* VRR Parameters */
+	if (vrr->state == VRR_STATE_ACTIVE_VARIABLE ||
+				vrr->state == VRR_STATE_ACTIVE_FIXED) {
+		setFieldWithMask(&infopacket->sb[VTEM_MD0], MASK_VTEM_MD0__VRR_EN, 1);
+	} else {
+		setFieldWithMask(&infopacket->sb[VTEM_MD0], MASK_VTEM_MD0__VRR_EN, 0);
+	}
+
+	if (vrr->state == VRR_STATE_ACTIVE_FIXED)
+		setFieldWithMask(&infopacket->sb[VTEM_MD0], MASK_VTEM_MD0__M_CONST, vrr->m_const);
+
+	if (!stream->timing.vic) {
+		setFieldWithMask(&infopacket->sb[VTEM_MD1], MASK_VTEM_MD1__BASE_VFRONT,
+				stream->timing.v_front_porch);
+
+
+		/* TODO: In dal2, we check mode flags for a reduced blanking timing.
+		 * Need a way to relay that information to this function.
+		 * if("ReducedBlanking")
+		 * {
+		 *   setFieldWithMask(&infopacket->sb[VRR_VTEM_MD2], MASK__VRR_VTEM_MD2__RB, 1;
+		 * }
+		 */
+
+		fieldRateInHz = stream->timing.pix_clk_100hz * 100;
+		fieldRateInHz /= stream->timing.h_total;
+		fieldRateInHz = (fieldRateInHz + stream->timing.v_total / 2)
+						/ stream->timing.v_total;
+
+		setFieldWithMask(&infopacket->sb[VTEM_MD2],  MASK_VTEM_MD2__BASE_REFRESH_RATE_98,
+				fieldRateInHz >> 8);
+		setFieldWithMask(&infopacket->sb[VTEM_MD3], MASK_VTEM_MD3__BASE_REFRESH_RATE_07,
+				fieldRateInHz);
+
+	}
+
+	/*
+	 * When no VTEM feature is enabled (neither VRR nor FVA), signal a
+	 * zero-length data set (MLDS) by clearing Data_Set_Length. HDMI 2.1
+	 * 10.10.2.4 requires the Source to either stop transmitting the VTEM
+	 * or set Data_Set_Length = 0 when no feature is enabled; keeping the
+	 * VTEM with Data_Set_Length = 0 preserves the every-MTW cadence while
+	 * staying compliant (e.g. HDMI GCTS HF1-58 step 6.2).
+	 */
+	if (vrr->state != VRR_STATE_ACTIVE_VARIABLE &&
+	    vrr->state != VRR_STATE_ACTIVE_FIXED && fva_factor == 0)
+		setFieldWithMask(&infopacket->sb[VTEM_PB6],
+				 MASK_VTEM_PB6__DATA_SET_LENGTH_LSB, 0);
+
+	infopacket->valid = true;
+}
+
+static void build_infopacket_header_vtem(enum signal_type signal,
+		struct dc_info_packet *infopacket)
+{
+	// HEADER
+
+	// HB0, HB1, HB2 indicates PacketType VTEMPacket
+	infopacket->hb0 = 0x7F;
+	infopacket->hb1 = 0xC0;
+	infopacket->hb2 = 0x00; //sequence_index
+
+	setFieldWithMask(&infopacket->sb[VTEM_PB0], MASK_VTEM_PB0__VFR, 1);
+	setFieldWithMask(&infopacket->sb[VTEM_PB2], MASK_VTEM_PB2__ORGANIZATION_ID, 1);
+	setFieldWithMask(&infopacket->sb[VTEM_PB3], MASK_VTEM_PB3__DATA_SET_TAG_MSB, 0);
+	setFieldWithMask(&infopacket->sb[VTEM_PB4], MASK_VTEM_PB4__DATA_SET_TAG_LSB, 1);
+	setFieldWithMask(&infopacket->sb[VTEM_PB5], MASK_VTEM_PB5__DATA_SET_LENGTH_MSB, 0);
+	setFieldWithMask(&infopacket->sb[VTEM_PB6], MASK_VTEM_PB6__DATA_SET_LENGTH_LSB, 4);
+}
+
+void mod_build_infopacket_vtem(const struct dc_stream_state *stream,
+		const struct mod_vrr_params *vrr, int fva_factor,
+		struct dc_info_packet *infopacket)
+{
+	//VTEM info packet for HdmiVrr
+
+	memset(infopacket, 0, sizeof(struct dc_info_packet));
+
+	//VTEM Packet is structured differently
+	build_infopacket_header_vtem(stream->signal, infopacket);
+	build_vtem_infopacket_data(stream, vrr, fva_factor, infopacket);
+
+	infopacket->valid = true;
+}
+
 void mod_build_adaptive_sync_infopacket(const struct dc_stream_state *stream,
 		enum adaptive_sync_type asType,
 		const struct AS_Df_params *param,
-- 
2.53.0

