Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F80C5CFDB
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 16:43:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CEE410F465;
	Fri, 14 Aug 2026 16:43:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DKKEv//G";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012014.outbound.protection.outlook.com [40.107.209.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E839810F0DC;
 Fri, 14 Aug 2026 16:43:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IrKVQIUnkstwu5GF83r0T2Ke6ITxbMTvE3ogubtgBfFZq22EyYGOFXbTH/SjP5Zy5vV/skVuV7q/cenJvlAUFi3AUHgZyfGs4EmJ2xmKJUWgIvShdCHFavVdlfiIah0uRYYjiwZj1CeGyFULZuNRn7TJetCbaaYM5piEBPrSVZbL3MH/fDqOF3JjqROzzy1qC+ei2IuxMLZKq6pd/P9YxNtFkN0tasqP0mwYwkl9vn6dHbbburQPJDndnOJ9p3yR8BJ6TYDhTtgbN9zqeDrMEeFqCI0hE9oDTrEJmR7IAdUm9zIEqvQ1cXB4ovj5ppJfjq0bJWbjXDFLDN/LoDT3rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k0G1Jx8/Di8+kTv+6L2Y0ffBdY/6F8qqyZIUgX3jN68=;
 b=cFJYdtiqVanj92BMHiCi+jVSBklQbAUfdrT1/4CtS6Qtmfg1ZV++hVyau3xITl2Tsp23RovferFl9kqzksa533so42mKAJWe0VX2XEIRgrF6BByAdLh0Q2LFIDaJKgWSTqzTS8RKV7X44pEWzPHM9ErQhqpn8K3af19IUHn8+7YCq2b33zMQMwM9o+CpXJ/a6jn1hlFqgzjz8pRA96/bgPw8r7kCGdSlCm8OHfDA/Na/1j8+XzOQhBZix3Fqirjx6OHAcpU6fIwprcUmek2G2Yt9FjGa4MpjCEZD3nGk4UV+q33ZKRnVkVLYHNv+/SoP4Hd5TNqhi6KvJMmHVpO1bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0G1Jx8/Di8+kTv+6L2Y0ffBdY/6F8qqyZIUgX3jN68=;
 b=DKKEv//Ga87+By+LwGodercHXNy9gABr7r4yvY+OoDpstw1U97qAqKur07wm/sOOx9iUD8NvsgyHzzqe2hxaPOgT2ndFL49C5E20fk/UgwW+aGpmJ7vZzhfVJu8CZedg8dMqIZoeT/IS2CRxN72ki3ipeG3KOaLF0/cDjGVT9lM=
Received: from BL1PR13CA0001.namprd13.prod.outlook.com (2603:10b6:208:256::6)
 by PH0PR12MB8052.namprd12.prod.outlook.com (2603:10b6:510:28b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Fri, 14 Aug
 2026 16:43:30 +0000
Received: from BN3PEPF0000B36E.namprd21.prod.outlook.com
 (2603:10b6:208:256:cafe::4f) by BL1PR13CA0001.outlook.office365.com
 (2603:10b6:208:256::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.3 via Frontend Transport; Fri, 14
 Aug 2026 16:43:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B36E.mail.protection.outlook.com (10.167.243.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.0 via Frontend Transport; Fri, 14 Aug 2026 16:43:30 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 11:43:27 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Harry Wentland
 <harry.wentland@amd.com>, =?UTF-8?q?Tomasz=20Paku=C5=82a?=
 <tomasz.pakula.oficjalny@gmail.com>, <daniel@fooishbar.org>, Fangzhi Zuo
 <Jerry.Zuo@amd.com>
Subject: [PATCH v4 1/4] drm/amd/display: Add 2.1 FreeSync support for AMD VSDB
 EDID Block
Date: Fri, 14 Aug 2026 12:43:41 -0400
Message-ID: <20260814164344.3098143-2-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260814164344.3098143-1-jerry.zuo@amd.com>
References: <20260811003921.1398292-1-jerry.zuo@amd.com>
 <20260814164344.3098143-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36E:EE_|PH0PR12MB8052:EE_
X-MS-Office365-Filtering-Correlation-Id: bca92a2c-51f1-4f66-5b8b-08defa232c1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|11063799006|5023799004|10067099003|56012099006|22082099003|3023799007|18002099003|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info: e2ZjGjtnVwon33Lo4SWhMu16wxv9gMr8xA1ADkCe9a47JGzP/6P0/TIvoNs6j9V0OFmjiuL3i+ITVVt6BjCWyQhDax8MHcOs7wy6popS5B9ZWtnnmmanT7O8QrVXGVF3sJp4HGDlzumwqJoh1zwCkCvX8Ky67Y14PdcK7pIyILf3Y4H7YbfMbqOOGew4inQYjddJajKldOFAwCwC8G2jvRmlEbT5o7yGX+kKvqPp9uyIzPb/zrSD1Ln9c+yXcEyxPzrZ/MnwaFufoIC1Wv4U0RzkmzA4XwS4jjhpfmT4l9YaTj7MMzfnINOwKFn3IZ6ESOpdNQvGVsx1we/YqE2zTRKBg3GGHF+vV84epJswB4I5NQoJP4n5L/HTb2bFCUyuVeAbDNyFnEmNbOai78YrqzJGnTWFYeWMPwhCXEOGKs3Q7p4RAl/LD1wBhn/fkJtCWJvXtJqR8pAorjcWTniw7OaLtTUAzC6lRRmgptedRr/l8w9uNXQxBH3JA6GTCE4+m+SrCj9OeMg7IueTIbUXg4FFYGcLf9efurs9sEPl7FRsHYMI7hdJ81C4YRuMGTPY+z49Tmp+QcaYltDDCNoWYui+jXwp3zPHAuOCXmgKRgLRVcCAXvdzr0YOj4jJaPawv7u2xAKSZFhD3KCaBQWpop3nacQICRxKOwaO2sRzIOqHkLrRQX+6Oqdo0I/N+AKog3LJD6xxedjj9JndRDizEw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(11063799006)(5023799004)(10067099003)(56012099006)(22082099003)(3023799007)(18002099003)(6133799003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: m57JmWob8IEn4eKEczOYKs+MFprVh//lLH7bPJee6SgfzRRlYIoQVT53a10EFXozuu4n1rZ1/5BEyhi7hZQ51qQp33s0OMPUcuJJN+x4g5m3HvcdhtDtuNlV9t9zMg2QAEZ01d9CvJTCC9PMmmZ0vn1kY5zHfqsdZr7juU+wnLEsQiYKjd2RfFjTub0KIvgoZTZvXttyqztIxSGyPadg1SGap509L7LeulYuS1/tCrorKqv/RGcBNBtfAiMlfEiOuyBg3QCSKMTjyoXAxlGJLUMJisyaXXX91j0T424X7rv62r5FYDrccGwWJSq1Vyp2F0f+oZsqRwrkjAnXNbMtDc7Ac9seC5QWg0nniEU0dIejeVlp7Wp8vNPR0rENUNCzPOqyitIuPswAbQMEF+2EbZhBO7WPgilHIq3xNuq8WmqHXbKbjANoZd4j9uHhedFH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 16:43:30.3616 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bca92a2c-51f1-4f66-5b8b-08defa232c1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8052
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

