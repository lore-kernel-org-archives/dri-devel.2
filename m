Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DC4BC5AD55
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 00:38:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 725AC10E271;
	Tue, 11 Aug 2026 00:38:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VVvnLL13";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011046.outbound.protection.outlook.com [52.101.57.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0467910E267;
 Tue, 11 Aug 2026 00:38:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OBg/zonmjM/yfMz34cPu0HdZBVy185gzzNLAfJAuHIGzANQ3ch2sEXmnh1NeusE+hu6w0JiCiid/9xVQIGOod81OF7nTJetwC4afwEoO+wIIirksKVaQkEl+nyifULf+DaCTuzgGbHZ0JMQ+FlXQb7WOZWE60K/THDACAYwdAbqzJ8Ejd73TEk16GBDAMsDZ4HC5ZmkTRSoVd+ndx2LckM4Jokok449zbKO31tW4S7HxeDCTHO7ABRyrA1xX01yImvuWLU7kfKGrrLkDPOhY+/esDgCP1w16hXk5RKbjywAszpdK1iejR02Ht9OcFlTCpkeFRmy7Z/ytd8Q9NN5vQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G2iZBXiE2Mbz3EZAtNLuyn0CNv/Bd9JwtTBJ3A2qp+s=;
 b=LOjRjuVK4SFVcRJ/0eZ492orrAcZ123g7s39uP6qBmBnZHp0KGNBUYIIF87w4BIc0v/HJ8dz6A4F3Pfoc8dJBQG/aaanAjHglykfgeLI/A6yQwKiUrqmxgGzo1gXeQ/ml6RfX53kIJOgIkq3UvmycUeeVLA21UaDVpzXqSHo+lzVzV+/Ou2jy/zxy1HbULWn5b8rt1zEi/8bzEvYSvNDVVOZgkERY8mrzS4Pi+ZbrLXtMT/lH+91/Tgrm91KiyULs72td/SDHqhWUIwHxgRVjN/3tHMz71goKCMLfge1jiRo2TilKi1e7XhNGzl5kZ40KHWkBFGvI7jQ6uYO5C6K/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2iZBXiE2Mbz3EZAtNLuyn0CNv/Bd9JwtTBJ3A2qp+s=;
 b=VVvnLL13w8SwJTPbdzitEEer9AiaI23agu9itcHLqIdGo5iTv7j34iCbO98DgAiuP2qJMAKNYRNT+y4cBnAzcrFru3QbuFQjnGVXuRcujI+WLUmY4a39o5mfKFH4R+/4ILL9fCBP5XLdSukIy33D2hz2nj4Txn/2PyOE72Q5Wb4=
Received: from MW4PR04CA0364.namprd04.prod.outlook.com (2603:10b6:303:81::9)
 by DM4PR12MB6375.namprd12.prod.outlook.com (2603:10b6:8:a2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 00:38:43 +0000
Received: from CO1PEPF000066EB.namprd05.prod.outlook.com
 (2603:10b6:303:81:cafe::19) by MW4PR04CA0364.outlook.office365.com
 (2603:10b6:303:81::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Tue,
 11 Aug 2026 00:38:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066EB.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 00:38:43 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 10 Aug
 2026 19:38:42 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Harry Wentland
 <harry.wentland@amd.com>, =?UTF-8?q?Tomasz=20Paku=C5=82a?=
 <tomasz.pakula.oficjalny@gmail.com>, Fangzhi Zuo <jerry.zuo@amd.com>,
 "Fangzhi Zuo" <Jerry.Zuo@amd.com>
Subject: [PATCH v3 4/4] drm/amd/display: Add HDMI ALLM support
Date: Mon, 10 Aug 2026 20:39:21 -0400
Message-ID: <20260811003921.1398292-5-jerry.zuo@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EB:EE_|DM4PR12MB6375:EE_
X-MS-Office365-Filtering-Correlation-Id: 3649e721-7c9d-4912-4910-08def740e58f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|23010399003|82310400026|18092099006|22082099003|18002099003|11063799006|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: nNxuPT4QsQieO3Glsj5WA49TjrTZ337wXDX4EtxY5O1SLFsIQEK28fqv7qrYP+uocAqkvosUVFFufpjnb9IiyC8oTc8QvgGdWEAM4v737SEPIi/CLcsZyrKO/Bs0YZM/2ooChTvBCG8hWb2ZNs1NC6dLqTMTa7wrg6QbIbFM5XhAiac8m1M4wYdX8skiTt3dRzp/0/0G9lDqV5dffMAohuhQXJvShlGvyHKGaVaafrWFKh109CJt5RYt8qK8Lprqc5xVKentMH+rKojUICcCvHZfyG3vXPfB7g/fBGIK2mzSB6PFfGDxtU0qTtzFcxbaakXMmX7YhmHCX5j8l3BItsI3bOj2+h2HsseGfckKmtSI/Ke9DSLNtSq+n/FvY+hE34FnyV8jNP7nSz6z1syI88WqAwy9Lfkuv5EldR+ggKZUb99jF1VrSFHJAJQSdM7zayf5kG3jftBWH7CDisD/4RcwPqKuQKIBsPBNnbfp2EIJS/q5OsebxwY6+iPQgtmkfYUuoOa9xzIH72nk+mkZyIQL2Q2IFS9JkL5WUsY6gqYn+SdFW56So//u0wASk7++RsLwwUCvOIExriQFgmI8egEGJlcpCOKXVhUJu7ikj0bMtLH6o9xs3Los/lcj3cntR6/Mj+lKBH3q27oi20SU96ra5Xr0yXrQMqacJBZcVTAjPfdLOZc0Sa5kXLuQEETsvfxwddOP5dr7hv/M6KfwFg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(23010399003)(82310400026)(18092099006)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oAqDWi54IZDWfJiMqxHnfKYtSIK30udtT7wZyrC8a/nmVAfR1iAN7D4BLr+w9UgsTqT7Dss1nuTsmXv1dRbjfXyv7HkmzsIGT16fPo9Zg8l0LHuf+w+02PMuAF5Xg9Izt5N/0QwDqjSURqz0tIBLWvHk0sty8Yb9ynW93V2L3wZ1DKHyybiiLbK/Pqw+Z/lgPdurzMvuQ6zE/tsDI7fOB/WZI7FMeyLR+knDMQfToC2VADzlqV6cy+EAZI6gYS4AkUxlYJcHC5GBXokS57OCLGZbSZXPFKHVC3L/uTtPkAxpA0snGD9wdYRROQpoPwxWb1Flj52WNpCMuRaVPlgiqb8qiJTJevpihTvL6c2GjgSsmIiZdqfLWIA0iA6/BYu28BB2hPRDgBVIWEh3LzGFMt4CIJE/Yb6D0tSpNQNhky2doLK6qXQAat9taSz8vPLj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 00:38:43.3836 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3649e721-7c9d-4912-4910-08def740e58f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6375
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
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
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
index 2fe7bfb1e88f..953b2a470734 100644
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
index 382c339b67b1..0fa72c77415e 100644
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

