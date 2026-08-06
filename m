Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61DCBC56208
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 20:54:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADD3210F2C9;
	Thu,  6 Aug 2026 20:54:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X8Z2reOa";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012016.outbound.protection.outlook.com
 [40.93.195.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 032BF10F2BA;
 Thu,  6 Aug 2026 20:54:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HH0oiuFBDWHlhk5cH8j7EBAfkATQZlmR5YXRnZZtnem7sqas+S3umaK8V4zD0WAkN7cngY345xZXqexFd3gxtK1pI//ST9Px3dskmBN5cZG7CyXHteomN66qQSbiiXYDF8eENyCxF3yrWL4xKA8uviiOnp/GO8nS40DNUardpoIxWtnW+koC7LzTTq0dfF4EOHHB8iwdugi2Nkrkiot7kzViZa1iKQJlBhGh8154KbDV5RWODxALYuQ+f639BCoPAHsQhzAZWr6sRBVlEe02PqYQDJCpNUX8lhuJI0syJHGpHnu5nBi5PPR2EYLTCKH98QN+77xYHYwpFxoWgmrDKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ILy0+EoHYuFFpN7FYTL3dMq6JKL9yybL+61Si3Q6g8=;
 b=UzolSicIOKW35i0cFY7Zm3g/k0Gk5UG5u6L/wM/qMrM3xl+2i9kHuB2mIvp+s7yVETx3aNUvvjB3RuyfcHrSVtXYtHnxxSuLL8gA5Kk1tCnSR0vdDrl+7KSAW97TRbfHY6dP8guVlYLJ6hAlxUwFCqMwv8aH3doq3zikZWcHImcbrTl0mHM2kGce0sG7r/C/EI+iP6K19TsHV8zlWAMc4QOxTg+hcDFE9+9mqZL0rOtajxDoNUKrv2G2ZalBYdxoMWEFvyYbzkIgGv1yTydzO6qorPw6ct9iHrhhrK/VsNsniC65JsgCgn/Hcw2tidmkABnKZAe6O7WDErK8wr4EMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ILy0+EoHYuFFpN7FYTL3dMq6JKL9yybL+61Si3Q6g8=;
 b=X8Z2reOayL6/nlPYQExOY551tS4+pvMZjh1Ywv1hQf1/CeYuRreOv7JAEdRtdpzVQp3V9FCQB6hEgEx3i1KYCFot4mC7TDxIm0STWBjZ+EFWPcQBgMLSfLBH/hEONMuhpihSui8fkGAel9W4NucPRc5oHxw+WyXBVNm3Byd1fHA=
Received: from BN8PR04CA0047.namprd04.prod.outlook.com (2603:10b6:408:d4::21)
 by SJ0PR12MB6735.namprd12.prod.outlook.com (2603:10b6:a03:479::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 20:54:02 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:408:d4:cafe::75) by BN8PR04CA0047.outlook.office365.com
 (2603:10b6:408:d4::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.20 via Frontend Transport; Thu, 6
 Aug 2026 20:54:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Thu, 6 Aug 2026 20:54:02 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 6 Aug
 2026 15:53:57 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Fangzhi Zuo <jerry.zuo@amd.com>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 "Leo Li" <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>, Alex
 Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 4/4] drm/amd/display: Add HDMI ALLM support
Date: Thu, 6 Aug 2026 16:54:48 -0400
Message-ID: <20260806205449.16806-5-jerry.zuo@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|SJ0PR12MB6735:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f6ca710-45ec-4788-f826-08def3fcd864
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003|18092099006;
X-Microsoft-Antispam-Message-Info: EThmwPkkAO+UYOKi/fh6pqSEZXhwj3GQX0PvX8ggBlHOYaH6+/7inGE70HhHp1YTLya4y3jUGfMNmZ2bRYyxB3D/ToGWJ3fmYfu109OAd1fxuyfoSgEOPYEccldb8dWUtCcC6HeEuHbCw4CB+DYDUCEY04sKd50EStc2CS/GbD2G6KWFhEaf2tr5mn379szlIOk2egTgL7iERlNk/iSIIncG/C/oxVUpqjXSBYgL7lmsyrlu8P9/2kryBtsWx/kQA+46nwfaScGGbam7vHIR1h/05lJn4oLWEy1IVWGrEXw6IMA4W1Y/kiPeplOC9S+rLQ4gEcaWeIxcElyj/rV9MVVvmtYi64jWbupL9yCZwLz+xbLVHQkWsI3jTLVsw2+OQWJI0t7f/8sajm9iA79zp7MRtCuKrBdPvi/ZCUr21AgZcP8IOOyylud6SJevQbKZDePPc/ixHY533xnZgAgtDyzJ5Ms7BZE3WSkFOBA/kUDSkfn4MbI6wukla4Gx9DEyERoIYmMROMv/RM4OHYWmb3xdrQJuCOWYf36bAefDLMydk3DIoAw9mLWmLt58TuvalzjIq/UM7IuxEMyxLDXnoBZlyZy+c4g7RNN7nk7PKHrLvu9UoV01p5+lbgzz8305YIjIG/STSlFjkMkuQyLYbEY1QSiSALONXGVK/W3/1r7ZfKG8XspkLftNpWKzne1Sm9kqqpTpO3sP9fy61tptqA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003)(18092099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iUlfSVUVzhYgrkukacPCpF9PoGIuJQfgNljl5sKJlHJF+YshQ/OeQIy8eGueMED66LGwPQhNq3qU9ADRcUpSOpEsq+0a8WpIA7nzQccteylxbbmHs040APZuz8XzoPZop0WJJrH4fuyM9bn0wwG5mQiwZ6yXehPOXsxdv2987PAAJ9WPnFla4D5/eikkiP33Iyqvt8aUcivOMp2wzg6GsM2EJrZScq5DegYrxXILVM1pZj5SPLezUnJT6YRi+hbSTIwp4Ka6LwgJr+8oN1sJC0UJcyphO94XqrsXgqwZaDkRYguVHp0QcUhoFSCmrOcaFeuwg2tor+9mmJOB2ogX5nit+c8KFHO0dbWIZyto3xBUBMNGeccswm7cU95hzjMLo1X08YRGeAfcZDxWmk2KIKw59MvOPIFVp7R6mykMknrMov66xt7TT3QV6Rgybjcm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 20:54:02.0541 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f6ca710-45ec-4788-f826-08def3fcd864
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6735
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

why:
HDMI 2.1 Auto Low-Latency Mode (ALLM) lets a Source request the Sink's
low-latency mode through the HF-VSIF. amdgpu never set ALLM_Mode in the
HF-VSIF, so ALLM was never signalled to the sink.

how:
- In create_stream_for_sink(), build the HF-VSIF with ALLM_Mode set when
  the sink advertises ALLM (connector->display_info.hdmi.allm, parsed by
  DRM core from the HF-VSDB) and the content type is Game (content-type =
  Game is how userspace requests low-latency mode, HDMI GCTS HF1-56).
- In update_freesync_state_on_stream(), also set ALLM_Mode when
  Gaming-VRR is active (VRR_EN=1, HDMI GCTS HF1-58 step 8.3.1), and push
  the updated HF-VSIF (vsp_infopacket) as a stream update.

Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  5 ++-
 .../display/amdgpu_dm/amdgpu_dm_connector.c   | 18 +++++++++--
 .../display/amdgpu_dm/amdgpu_dm_freesync.c    | 31 +++++++++++++++++++
 3 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 567bf04979ee..ff0db0cb9880 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4029,9 +4029,12 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_commit *state,
 		}
 
 		if (acrtc_state->stream) {
-			if (acrtc_state->freesync_vrr_info_changed)
+			if (acrtc_state->freesync_vrr_info_changed) {
 				bundle->stream_update.vrr_infopacket =
 					&acrtc_state->stream->vrr_infopacket;
+				bundle->stream_update.vsp_infopacket =
+					&acrtc_state->stream->vsp_infopacket;
+			}
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index df39bc70ec6c..6cfd7526ab56 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -1572,8 +1572,22 @@ create_stream_for_sink(struct drm_connector *connector,
 	update_stream_signal(stream, sink);
 
 	if (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A ||
-	    stream->signal == SIGNAL_TYPE_HDMI_FRL)
-		mod_build_hf_vsif_infopacket(stream, &stream->vsp_infopacket, false, false);
+	    stream->signal == SIGNAL_TYPE_HDMI_FRL) {
+		/*
+		 * Enable HDMI ALLM (Auto Low-Latency Mode) when the sink
+		 * advertises ALLM in the SCDS and the content type is Game.
+		 * Setting content-type = Game is how userspace requests the
+		 * Sink's low-latency mode (HDMI GCTS HF1-56).
+		 */
+		bool allm = connector->display_info.hdmi.allm &&
+			stream->content_type == DISPLAY_CONTENT_TYPE_GAME;
+
+		drm_dbg_driver(dev,
+			       "ALLM: set mode: sink_allm=%d content_type=%d -> ALLM_Mode=%d\n",
+			    connector->display_info.hdmi.allm, stream->content_type, allm);
+
+		mod_build_hf_vsif_infopacket(stream, &stream->vsp_infopacket, allm, allm);
+	}
 
 	if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT ||
 	    stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST ||
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
index cb49184813de..c4bc6e717df9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
@@ -252,6 +252,37 @@ void amdgpu_dm_update_freesync_state_on_stream(
 	new_stream->vrr_infopacket = vrr_infopacket;
 	new_stream->allow_freesync = mod_freesync_get_freesync_enabled(&vrr_params);
 
+	/*
+	 * HDMI ALLM: transmit the HF-VSIF with ALLM_Mode=1 when the sink
+	 * advertises ALLM in the SCDS and either the content type is Game
+	 * (HF1-56) or Gaming-VRR is active (VRR_EN=1, HF1-58 step 8.3.1).
+	 * HDMI 2.1 7.6.6.
+	 */
+	if (new_stream->signal == SIGNAL_TYPE_HDMI_TYPE_A ||
+	    new_stream->signal == SIGNAL_TYPE_HDMI_FRL) {
+		struct dc_info_packet vsp_infopacket = {0};
+		bool sink_allm = aconn && aconn->base.display_info.hdmi.allm;
+		bool allm = sink_allm &&
+			(new_stream->content_type == DISPLAY_CONTENT_TYPE_GAME ||
+			 vrr_params.state == VRR_STATE_ACTIVE_VARIABLE ||
+			 vrr_params.state == VRR_STATE_ACTIVE_FIXED);
+		bool allm_changed;
+
+		mod_build_hf_vsif_infopacket(new_stream, &vsp_infopacket, allm, allm);
+
+		allm_changed = memcmp(&new_stream->vsp_infopacket, &vsp_infopacket,
+				      sizeof(vsp_infopacket)) != 0;
+		new_crtc_state->freesync_vrr_info_changed |= allm_changed;
+		new_stream->vsp_infopacket = vsp_infopacket;
+
+		if (allm_changed)
+			drm_dbg_driver(adev_to_drm(adev),
+				       "ALLM: flip on crtc=%u: sink_allm=%d content_type=%d vrr_state=%d -> ALLM_Mode=%d\n",
+				    new_crtc_state->base.crtc->base.id,
+				    sink_allm,
+				    new_stream->content_type, vrr_params.state, allm);
+	}
+
 	if (new_crtc_state->freesync_vrr_info_changed)
 		drm_dbg_kms(adev_to_drm(adev), "VRR packet update: crtc=%u enabled=%d state=%d",
 			      new_crtc_state->base.crtc->base.id,
-- 
2.53.0

