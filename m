Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5F57C5B56D
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 00:38:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6514C10EA0A;
	Tue, 11 Aug 2026 00:38:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e9AqToPk";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012018.outbound.protection.outlook.com [40.107.209.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0237010E25B;
 Tue, 11 Aug 2026 00:38:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CBYYvldoQmTU9edUMqfEmIfo6SG5dlbd1/fdM/i2QFcuSkdcQICa3uKkKDJIgMKi8kyreM31VoylGeDz1m3wayiWpzS57CCtFgq6yZwbugiZjt6ic9CQaPK+f47/9zgA1W1U2CVuCvBOoEKFpaPya841mVklE3NZ8sWHUhbzmxJ702eOmyvxdjC2CmOU5NM1gnPxklKTMSHwkljYupi097aMzzyzjVS/Q/4WQYBZUNYfM/XXdrWy6aonf7fSvval4Ifq4IpYJ9bTaQ5waQGlVMLbQ1XkX1jOeSVRCywP/M4e56CgrS1hH+mVogoEUgV4gmcFh6JaCShOMVPShMIuOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k0G1Jx8/Di8+kTv+6L2Y0ffBdY/6F8qqyZIUgX3jN68=;
 b=B2eCQaZRG/WMk0JeASeyMmWf8oRaNXYWdLgvK9T4Nf/6WygcyWIvFR5Wumnj7LDOskmndbozJurDEXKs0F/UvJBSBnFPYLpCpK7JHAbxS9Ruvj7xEGa1LFIaKx25p09NIhy817N9ETAUOLzI2iQjOhVX0+bdAuUkdYW8hEwhT9d9ClmtN1XvMf/Cy3g+3VKoQaGDQSEK/AoPujoOD3BKAWCtNxYI7uQC9ryBIj0kc4PHfcVMSeHcgNyzdBUjJK2staUU9ljk8hyWu5GM6fDL28aVAqFlL4Hitla7MY0W2GA4sExJGJLhr/Ih/dT08U7obhyFPKVRCBHu/+bWVdn8lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0G1Jx8/Di8+kTv+6L2Y0ffBdY/6F8qqyZIUgX3jN68=;
 b=e9AqToPkBkGnP6oznI6YB3mp1EO5sX+AqvQSaUgjW4iZdEmnMtFwN9pN5yAD0T2Ope6cYx/0vE7YP585sZDrloB9il69XX3hmhDaNafcck1rsYmxHSkglbatygBatg0RIM7sIso4QqII9dt0caYS2ioyBl5MEh3CdPxMb9AffrM=
Received: from SJ0PR03CA0334.namprd03.prod.outlook.com (2603:10b6:a03:39c::9)
 by IA0PR12MB8974.namprd12.prod.outlook.com (2603:10b6:208:488::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 00:38:43 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::64) by SJ0PR03CA0334.outlook.office365.com
 (2603:10b6:a03:39c::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Tue,
 11 Aug 2026 00:38:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
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
 <tomasz.pakula.oficjalny@gmail.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>
Subject: [PATCH v3 1/4] drm/amd/display: Add 2.1 FreeSync support for AMD VSDB
 EDID Block
Date: Mon, 10 Aug 2026 20:39:18 -0400
Message-ID: <20260811003921.1398292-2-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811003921.1398292-1-jerry.zuo@amd.com>
References: <20260806205449.16806-1-jerry.zuo@amd.com>
 <20260811003921.1398292-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|IA0PR12MB8974:EE_
X-MS-Office365-Filtering-Correlation-Id: 8236b528-5804-4af9-fc13-08def740e4cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|18002099003|22082099003|10067099003|11063799006|5023799004|56012099006|4143699003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 0+nsMl7b+F0UdpgiYsdkNM2BIil0SPkjmLOQQGAjO9BLq2XFAtr34BVIxeCvoDhHCsVTfpi15L7wPmiOkU9Y6v/rEN53wEd78I2GWpVXNLzjGTG3l/HghQ4G1sWOQ9no3YmQbzViXWmSHXjgTcFH222sTz0nFcp266HZR86ujtEU+rSRikxf3tYn+WzU/PtKEAlAjTRNcZNwUC390JaEZWowvss+VavWlwOXBaVhlYM34grdAQ+9UIO0RxXQfAczWMOlbMPdXhyoiy1NP8Cn5Dk3l55u3GnUiyeQqyDscVmMkHgwvBHM0+Ah87qFIKX6rJgpXOIkzXKs9C9opQSBvtpkddztINS+ok2n8mju1XgluzTUXMRh/RQwkjBF25EWn3HaUJW3tZ3Hc8FrVSBglXYUax0Wu4io7r4/rSMgmaqr2UGgyLTtmgdezOIbXK2p8SGAOAjvc6pAHhktc17xJBqtvp96IDEB34FlBuXu6QJLFh4h2pUpt+dIYOycWLPsCu0546Y0DYZsEImk++twsWGSOYdZIEeHnnHp6iv+tyj+BQcDtjXrjrBh68JYs2IiibjuWQvw9pzox8NPtOqL11w7rEHn+T9afF5lRZL4h3upY1P4LFvPy3mjaad/z90xeC1/gDChwhYCKFuEGeLsUGFEtB6Xz4IgcKAb85mTe87t6xkLclQafArN2sZxRLsRX01BXWxPHBPZviDzR/N3sA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(18002099003)(22082099003)(10067099003)(11063799006)(5023799004)(56012099006)(4143699003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hwre7GUaEaCpG925SCxvQ10HTuEOVo9hobO0ZNwZDpIYR2QD5eZvQqKdJvaV/D07QoqfT9IhKWp0bTv+5pJFrmXMnwuAqK4SlRT0KMnme5k2PQ21Ox7VtHiSeak0lS9p+TvOnw4Bsa8jNIzF+PpR3Jnp5Yqoq5I//HlZb10uUl3Qh63r5ab/BgMC1vh7AIlUGRbUbp6Jl6SNfIEKjQPICQ+HvbqWW6mNdUPjCyT6NOQTSf7p+c1f4bgJcsNVQ5fXjoHjnpum0q4xGZjvJzDMPMR+/EHzQYZQzn/zGV/G6EdNvb7Mxp0t9VbRtnfLBSUHQwcDxaJS9pu0uHPxGE8kSW9w5iOxK0cC1OXYxoW+CnZ0M3qHnS3jdujbpndu/RLZv9HgZWFChtMevjq2IogBC7t2JPQKj/z6PLLhqxcDXgn3HXT7BNXeAFlSZueJhIqg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 00:38:42.0924 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8236b528-5804-4af9-fc13-08def740e4cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8974
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
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |   4 +-
 .../display/amdgpu_dm/amdgpu_dm_freesync.c    |   4 +
 .../amd/display/modules/inc/mod_info_packet.h |   4 +
 .../display/modules/info_packet/info_packet.c | 109 ++++++++++++++++++
 4 files changed, 120 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 2cc3734c992b..9eaa20ec528e 100644
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
index 46674b83183c..035d7e88c3ed 100644
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
index f5ac4bf32a78..32b697f46788 100644
--- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
+++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
@@ -291,6 +291,21 @@ void set_vsc_packet_colorimetry_data(
 	info_packet->sb[18] = 0;
 }
 
+static void set_field_with_mask(unsigned char *dest, unsigned int mask, unsigned int value)
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
+	unsigned int field_rate_in_hz;
+
+	/* FVA Factor setting */
+	set_field_with_mask(&infopacket->sb[VTEM_MD0], MASK_VTEM_MD0__FVA_FACTOR_M1,
+			(fva_factor > 0) ? (fva_factor - 1) : 0);
+	/* VRR Parameters */
+	if (vrr->state == VRR_STATE_ACTIVE_VARIABLE ||
+	    vrr->state == VRR_STATE_ACTIVE_FIXED) {
+		set_field_with_mask(&infopacket->sb[VTEM_MD0], MASK_VTEM_MD0__VRR_EN, 1);
+	} else {
+		set_field_with_mask(&infopacket->sb[VTEM_MD0], MASK_VTEM_MD0__VRR_EN, 0);
+	}
+
+	if (vrr->state == VRR_STATE_ACTIVE_FIXED)
+		set_field_with_mask(&infopacket->sb[VTEM_MD0], MASK_VTEM_MD0__M_CONST, vrr->m_const);
+
+	if (!stream->timing.vic) {
+		set_field_with_mask(&infopacket->sb[VTEM_MD1], MASK_VTEM_MD1__BASE_VFRONT,
+				stream->timing.v_front_porch);
+
+
+		/* TODO: In dal2, we check mode flags for a reduced blanking timing.
+		 * Need a way to relay that information to this function.
+		 * if("ReducedBlanking")
+		 * {
+		 *   set_field_with_mask(&infopacket->sb[VRR_VTEM_MD2], MASK__VRR_VTEM_MD2__RB, 1;
+		 * }
+		 */
+
+		field_rate_in_hz = stream->timing.pix_clk_100hz * 100;
+		field_rate_in_hz /= stream->timing.h_total;
+		field_rate_in_hz = (field_rate_in_hz + stream->timing.v_total / 2)
+						/ stream->timing.v_total;
+
+		set_field_with_mask(&infopacket->sb[VTEM_MD2],  MASK_VTEM_MD2__BASE_REFRESH_RATE_98,
+				field_rate_in_hz >> 8);
+		set_field_with_mask(&infopacket->sb[VTEM_MD3], MASK_VTEM_MD3__BASE_REFRESH_RATE_07,
+				field_rate_in_hz);
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
+		set_field_with_mask(&infopacket->sb[VTEM_PB6],
+				 MASK_VTEM_PB6__DATA_SET_LENGTH_LSB, 0);
+
+	infopacket->valid = true;
+}
+
+static void build_infopacket_header_vtem(enum signal_type signal,
+		struct dc_info_packet *infopacket)
+{
+	/* HEADER */
+
+	/* HB0, HB1, HB2 indicates PacketType VTEMPacket */
+	infopacket->hb0 = 0x7F;
+	infopacket->hb1 = 0xC0;
+	infopacket->hb2 = 0x00; /* sequence_index */
+
+	set_field_with_mask(&infopacket->sb[VTEM_PB0], MASK_VTEM_PB0__VFR, 1);
+	set_field_with_mask(&infopacket->sb[VTEM_PB2], MASK_VTEM_PB2__ORGANIZATION_ID, 1);
+	set_field_with_mask(&infopacket->sb[VTEM_PB3], MASK_VTEM_PB3__DATA_SET_TAG_MSB, 0);
+	set_field_with_mask(&infopacket->sb[VTEM_PB4], MASK_VTEM_PB4__DATA_SET_TAG_LSB, 1);
+	set_field_with_mask(&infopacket->sb[VTEM_PB5], MASK_VTEM_PB5__DATA_SET_LENGTH_MSB, 0);
+	set_field_with_mask(&infopacket->sb[VTEM_PB6], MASK_VTEM_PB6__DATA_SET_LENGTH_LSB, 4);
+}
+
+void mod_build_infopacket_vtem(const struct dc_stream_state *stream,
+		const struct mod_vrr_params *vrr, int fva_factor,
+		struct dc_info_packet *infopacket)
+{
+	/* VTEM info packet for HdmiVrr */
+
+	memset(infopacket, 0, sizeof(struct dc_info_packet));
+
+	/* VTEM Packet is structured differently */
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

