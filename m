Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4A2CC5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 16:43:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1595E10F2DB;
	Fri, 14 Aug 2026 16:43:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Usq3+Meg";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013013.outbound.protection.outlook.com
 [40.93.196.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A789A10E585;
 Fri, 14 Aug 2026 16:43:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gFOxVSXzF91ky1SoyHh6ebKRqXOWaZN1P8gSk0Bkn6RCC+0hfk5+9YBzdibHrmBg0v8nruXmgIcL4b2C06Iro0OEM6mmQU7tABOwhfLKXdL6Pf+hldlAegHdwfhmR2uOHG74WXaajBH6xNImACvLJ5rAmeYY9y6a2EkFbKfhhpaxiaYFFqqU8U6RF3PcRrO1BiRe1GpbUBdI17d9nLMlUalcfCrB8zZiAG4dgZiJkDwWZQ8+3x7G4LC37E8gjZy5ed9PGrCK31RlTaMwFVDXjOOdCSCutjXJkMIFX/Dcj/SzIlSN4kkK3Z4xdVEAlLK3eIIIXIodntEK3loqbUN2pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7y3a+IJpebuOcaOWBhgVFo858y+xDkdpRuC7J6VDKGo=;
 b=fCDnzmlZUujyfwfGWqfdBL0jya+dmHecakIFuFg+yDomQZnd9WFA9vDg+qPcEBVM8P0hXBpAjzBRgWzXDvzHQOiIYtBiLoQKMDYBCFqKnDmd2SQEhB9q7jGhAsUTrIBB/dG8AaCkgm0dfCkRkLpmeVldMBOh5RPScrF/kEK+vUpsrhzazSdLeCtl0NRR0DBzINwCw2vDvfBgELoYP3Gj1NlRTPjn+Fd3ZGI6YjJCQiz3lE4ZSMS/UY+G/TQxciim/zPrciV2jrd7axkGoG+s36YNrHHsRnEIgbwMdjnbAezkLxamNtKy4cXCmjprDyLjxpySn197U9LXucJZapfUgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7y3a+IJpebuOcaOWBhgVFo858y+xDkdpRuC7J6VDKGo=;
 b=Usq3+Megu+UI9cMTvn0lxbITUNGMTI2XrKu2jpYo1lJysU7NHUhOqMzkOK6GXoAanCPfl97P7qL28jPx+A4Fgjb+NraWLWA4nqgn0Oayzxi72Wjjw4e63EBt3ynNMh/1YUSFCKTswMl5Sg2hc5XOxfbPCHJnDkuIOliP2DAjraQ=
Received: from BL1PR13CA0016.namprd13.prod.outlook.com (2603:10b6:208:256::21)
 by DM4PR12MB5939.namprd12.prod.outlook.com (2603:10b6:8:6a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 16:43:33 +0000
Received: from BN3PEPF0000B36E.namprd21.prod.outlook.com
 (2603:10b6:208:256:cafe::96) by BL1PR13CA0016.outlook.office365.com
 (2603:10b6:208:256::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.4 via Frontend Transport; Fri, 14
 Aug 2026 16:43:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B36E.mail.protection.outlook.com (10.167.243.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.0 via Frontend Transport; Fri, 14 Aug 2026 16:43:33 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 11:43:28 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Harry Wentland
 <harry.wentland@amd.com>, =?UTF-8?q?Tomasz=20Paku=C5=82a?=
 <tomasz.pakula.oficjalny@gmail.com>, <daniel@fooishbar.org>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>
Subject: [PATCH v4 4/4] drm/amd/display: Enable HDMI ALLM for Gaming-VRR
Date: Fri, 14 Aug 2026 12:43:44 -0400
Message-ID: <20260814164344.3098143-5-jerry.zuo@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36E:EE_|DM4PR12MB5939:EE_
X-MS-Office365-Filtering-Correlation-Id: e82e19b6-d936-4670-3f79-08defa232dcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|22082099003|18002099003|56012099006|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: 01Rdm6Ml+YIrbN4P94StG3D4MHw1+rMdJUUqan3bMwlTIumNmNHJx0jU5TTdaUTVyYnF4ppl6bFym3NaJ6wIz2HVnMfoT8MBz+bu7H+ZaYoWr9vINtWP12b1Nyt2C4x0SbwOO+ZjIdzUn5iZSKPtnZCCSKwXLO/SG065EhM8G1i01XVapociAx4CrTPAIFSRF/ye9tU/DO9BlA0LylVIR0zS/fsecWB+RM+5WcYolApiFv6UJ++dn/qkmzFBnK3tWklOBO9MYgZT6r/2vjg1tRrZ4AFre6XXSLUjRVLXBLnjuhHzpGjT4QuS2exL74wVdhpEvnnnsIKk2c8AWMPwDM9orgc1/yY3ekRDPmKAdZl3drzF57JvujT5o+umUeBrgS8HbrC9BkHYC7hiq9O223aqoo981C5TIoClQNTFh6PBDP13R7kVc9ijiVQcFN3iwd9GqTUHVqiTRxxwxTTErRv5t/UKe6EXjHikd4vx1ywj7xb+MNOuGHBxAKZtcwd9+RlwqHkxfo2TjATuVEXbQln/7A8Dfpes4syxFOj9pB3fpYvX1VqYsStVxZONNV0ujxrpGuUd+UUYW7HK19IhiKITTNyOcbmbAeVmvVdDjLYAaIal1J6j1r4JK8h8I18MGji5Rr7nlXCdGxPZcsHGuAl8BgRlFLp5uSe9XowpMAEutv9+mHQcb0EMrmVycKfwHhi2iaRojDCTaKHCnRd6kw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rkmxhi8r8UCmbUS5HyeskksWrjZQZ6d1Mr+EDyf7x+w/MiS9bNQI8RBrheFM18L3jyZOeYJnm+I/QX1k7MHeelHZIVLtXnb7qwmnm8L8quc+OqY5MASBbRFe11hG8cHSjwFHSFMW6Ix0/BzfLfURY3BpYCU00m0szWes8Uo5vtGPo94RpqsfxwGKh9kaMYZTANgOODv6bHIMMG1znPM2CLTuJeLOg/r7aPX8AIeBSPnlBCptpyjfCa/S2SJ77boB0jLawmMoRO5IAYVY1zgl6K++QkDTGtMZ/2xk74O9oTw8yzYDQ9Z0cV45XISkJCUf7q6Pkt5oXtSdDkyvYkOosjhXCCiGl4+5+2BL18nAtRJLlrPacZC0/UBOU5nFE89fQ7xsE/zOG8FimsycItvsMvL9FkXuovtA/LzeIkkNjVkrleKmAfBkENwhtM6oqGGq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 16:43:33.1926 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e82e19b6-d936-4670-3f79-08defa232dcc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5939
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
low-latency mode through the HF-VSIF. HDMI 2.1 Section 7.6.6 requires
that when Gaming-VRR is enabled (VRR_EN=1) and the Sink advertises ALLM
in the SCDS, the Source shall transmit the HF-VSIF and set ALLM_Mode=1.
amdgpu never set ALLM_Mode, so this requirement was not met.

how:
- In update_freesync_state_on_stream(), set ALLM_Mode=1 in the HF-VSIF
  when Gaming-VRR is active (vrr state ACTIVE_VARIABLE/ACTIVE_FIXED,
  i.e. VRR_EN=1) and the sink advertises ALLM, per HDMI 2.1 Section
  7.6.6, and push the updated HF-VSIF (vsp_infopacket) as a stream
  update.

ALLM is driven only by the mandatory Gaming-VRR case.

Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  5 +++-
 .../display/amdgpu_dm/amdgpu_dm_freesync.c    | 29 +++++++++++++++++++
 2 files changed, 33 insertions(+), 1 deletion(-)

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
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
index 382c339b67b1..63d10cb7f5ed 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
@@ -252,6 +252,35 @@ void amdgpu_dm_update_freesync_state_on_stream(
 	new_stream->vrr_infopacket = vrr_infopacket;
 	new_stream->allow_freesync = mod_freesync_get_freesync_enabled(&vrr_params);
 
+	/*
+	 * HDMI ALLM: when Gaming-VRR is active (VRR_EN=1) and the sink
+	 * advertises ALLM in the SCDS, the Source shall transmit the HF-VSIF
+	 * with ALLM_Mode=1 (HDMI 2.1 Section 7.6.6).
+	 */
+	if (new_stream->signal == SIGNAL_TYPE_HDMI_TYPE_A ||
+	    new_stream->signal == SIGNAL_TYPE_HDMI_FRL) {
+		struct dc_info_packet vsp_infopacket = {0};
+		bool sink_allm = aconn && aconn->base.display_info.hdmi.allm;
+		bool allm = sink_allm &&
+			(vrr_params.state == VRR_STATE_ACTIVE_VARIABLE ||
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
+				       "ALLM: flip on crtc=%u: sink_allm=%d vrr_state=%d -> ALLM_Mode=%d\n",
+				    new_crtc_state->base.crtc->base.id,
+				    sink_allm,
+				    vrr_params.state, allm);
+	}
+
 	if (new_crtc_state->freesync_vrr_info_changed)
 		drm_dbg_kms(adev_to_drm(adev), "VRR packet update: crtc=%u enabled=%d state=%d",
 			      new_crtc_state->base.crtc->base.id,
-- 
2.53.0

