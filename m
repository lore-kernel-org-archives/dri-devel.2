Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EB7DC5DF6A
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 16:43:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 958AF10EDFC;
	Fri, 14 Aug 2026 16:43:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U2jY50kE";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012026.outbound.protection.outlook.com [40.107.209.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D01910F0DC;
 Fri, 14 Aug 2026 16:43:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k+N2x2P7LyamKhphsiSrQaoYsvRbiqpzjpx+D45hRCTBMHLyfu178J2pHcbrg8Ppi4vgo/OCviUA+lg3p9c2h4f/lh/RpsrRO1SX5pzDxsCc9SNfSKGoQRauQDkkClj3DkiN9+lcEDEQfYaY12KWpOXG7HBwOOvdk1mTV+nDmFLZd8ceqEE9i7jLQ098L8Fj6KykRxVyFLmhLnLZghrg5LHsNIWKGp5oPg1GftrrL2gNwmLMC+yRA+gEDCYTjvCTnnuk3RfO5K1tVFoMwOkzK4enTbFx6Zo22J1RwgKoJnuWj7z7LU+J9pFZGz3e5JjdSdfu+cLC9e0sEwpVEjGTtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zqu0YDvpg+UJQ5gI74MQG+zlDjG+gRFq1nGjCdSDOhA=;
 b=JKh2AVlVnoSb1pmj3Mxnp2kwRS8/YIzv+es2ujCx+0oWOAMKwq9cFsO4GoowypmZH8d0yTWqtQiPP+MlLwTUTDimvgXboEy3jmhmyII/VF7EA1Ii9N4bun53xB4lWjQOfDlBA97Lmi+4O3AxpJ2+O5pIG3VCJrihfVG3jOyYfJrb5Uqicy8LypMP3+aE9fBdk6Nx3OM5obBjSrtiOmf4lLppwSeY6KDTE9AJvjOEFSzcoWfBLCJipa2Ue4wL617H/GLTFtSYcYbFQsFTrSoeWJmBUZMwuxuXdWA39wt42GCU7I53BlKRw0tDKTu58IHLGEVAgkCl9CRCHEFkeGF8JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zqu0YDvpg+UJQ5gI74MQG+zlDjG+gRFq1nGjCdSDOhA=;
 b=U2jY50kEz20svtsvuYfoWB/H+vyyruCa0qwXs1XSNIBRQK0mkR5FUIXBAUyFYSpOWSp+yy4ruIkCROfKlaRLeXODqs5g3zHrTGnvUevpww2k9BKk1yZo/jzDL9e4h0XEDxcy2Pl0K8ry5i78tcEunY6U/sO0SKmlk0lm2Ygjjbg=
Received: from BL1PR13CA0014.namprd13.prod.outlook.com (2603:10b6:208:256::19)
 by SN7PR12MB7024.namprd12.prod.outlook.com (2603:10b6:806:26e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Fri, 14 Aug
 2026 16:43:32 +0000
Received: from BN3PEPF0000B36E.namprd21.prod.outlook.com
 (2603:10b6:208:256:cafe::20) by BL1PR13CA0014.outlook.office365.com
 (2603:10b6:208:256::19) with Microsoft SMTP Server (version=TLS1_3,
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
 2026 11:43:28 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Harry Wentland
 <harry.wentland@amd.com>, =?UTF-8?q?Tomasz=20Paku=C5=82a?=
 <tomasz.pakula.oficjalny@gmail.com>, <daniel@fooishbar.org>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>
Subject: [PATCH v4 3/4] drm/amd/display: Add HDMI 2.1 VRR support from HF-VSDB
Date: Fri, 14 Aug 2026 12:43:43 -0400
Message-ID: <20260814164344.3098143-4-jerry.zuo@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36E:EE_|SN7PR12MB7024:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aa9f81d-2e99-45b6-32db-08defa232cc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|376014|36860700016|5023799004|11063799006|4143699003|10067099003|56012099006|22082099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: U5nY1VSVSqF4vhe112GTx9nPxhcAlunWlQIHfdd5unVifBCXgWUdR16MUV8BlDlcRUPPxr2EIHsg8imtMaoUz4+Ni4Qy+QiZt8XOH1BWxJi6tgr5uPiZ8nTQhmp9HzxgdqyLZQ1pvuNNIYgCja1nDujdAt2i1JsgN4qa7MiYnMZ7t3ERbUuoTDTPB2Ugj2qrh9RSQF47c8n8MH1gMYr2hCYhAeoYJ5fXYE63h1kIdS41p86VI6wwGRXMhC+zqFXCUX6jadslwaQ6QEewxXC8lcnZthz9USQf8ZWS/iU2HxZVfeuV0f5GX4pwn+MOeyCqWtWk5sydCqzfND60ArQgPugCyMeBaAIsOjbruF7LgzzaXsRle6fHdQlJrfgLQBucoyZU6kXnz8kjlgTEjYuX46oET0FYBUkRwi+VtLu5MSoBSNc3yMDuf3KgroJj8BBLe0z8qE6UlwwxOUn7GqYk9WdvOtZxyzd2JWbBN242FQns2ecqjQtegor7ZUOCBn/FXjzbTONBjzMnC2VZml+41EopkDT4zcyRP6NC9gg84t2uw+ZaMZBer8PAcU3dhu1ASaF2QFH4np98Iy0PNKpF1AvaZyz04E1isKl1TJPq2K9an8pzS2ZMt1agTYELhUXmcdeJ3o9ZHXATmgA5cOM2COye/voGLga83G8jAiMI5ei/IMNM8KhZtO/vV5ydC6nKEhLfJcsUYoAlRH9r4mZiIQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(376014)(36860700016)(5023799004)(11063799006)(4143699003)(10067099003)(56012099006)(22082099003)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HHcsa1aH6VrpD5Iy1+zu/A4bH4zfrbIb+exEE8bASDRVExZKTIHb+mvvk74nezRlQ21lWSG8n9Y0O6cZKRo+E5aJTZiKQ+kGM0+YZqX6i7rRG2Q1RhEHrMCNxEpd9O0UlhthY7qdBNBV1Tb5rCQDpJZnCOKxE/DK10ZYqCve33Z0icHmY1hJodzFJtr9Rtd2hyjk/Xmb4l//OPqndSo4hEmcmbLLj5LltqnEGWvU0JBy6/9sHUtbSPRzLBWqDlfQvWEIvyb/LfDNbbC8c//Nr8PK8CRiQ77nXMIh824Io197l9w55R31RflYrmvCEg6wMgR8OxKvvuzYaTBCJts3wmLP5yfFtDKOGH7dbwrBkhbkF7JxwhfGwZaoXkY0/bZTI8NN418UrldJuje4pfR0tOlXmP5wB0SPA7c74K0EYhl6eFJF0fwPFSUvGdqgtDG0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 16:43:31.4352 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aa9f81d-2e99-45b6-32db-08defa232cc0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7024
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
HDMI 2.1 sinks advertise their VRR range in the HDMI Forum VSDB
(HF-VSDB), but amdgpu derived FreeSync capability only from the AMD
VSDB. Sinks that expose just the HDMI Forum VRR capability (e.g. HDMI
compliance EDIDs) were therefore reported as not VRR capable.

how:
- In amdgpu_dm_update_freesync_caps(), when the AMD VSDB does not
  provide a valid FreeSync range, fall back to the HDMI 2.1 VRR range
  parsed by DRM core from the HF-VSDB
  (connector->display_info.hdmi.vrr_cap). VRRMAX = 0 means "up to the
  Base Refresh Rate"; when the EDID provides no monitor range maximum
  either, fall back to the Base Refresh Rate (the highest refresh-rate
  mode of the preferred timing) so a valid VRR range is still reported
  to userspace.
- Add VRR debug logging along the FreeSync capability and config paths.

Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_connector.c   | 67 +++++++++++++++++++
 .../display/amdgpu_dm/amdgpu_dm_freesync.c    |  8 +++
 2 files changed, 75 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 9eaa20ec528e..2fe7bfb1e88f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -3812,6 +3812,15 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 	if (!adev->dm.freesync_module || !dc_supports_vrr(sink->ctx->dce_version))
 		goto update;
 
+	drm_dbg_driver(adev_to_drm(adev),
+		       "VRR: enter signal=%d hdmi_vrr=%d mrange[%d-%d] hdmi.vrr_cap[sup=%d min=%d max=%d]\n",
+		       sink->sink_signal, connector->display_info.hdmi.vrr_cap.supported,
+		       connector->display_info.monitor_range.min_vfreq,
+		       connector->display_info.monitor_range.max_vfreq,
+		       connector->display_info.hdmi.vrr_cap.supported,
+		       connector->display_info.hdmi.vrr_cap.vrr_min,
+		       connector->display_info.hdmi.vrr_cap.vrr_max);
+
 	/* FIXME: Get rid of drm_edid_raw() */
 	edid = drm_edid_raw(drm_edid);
 
@@ -3856,6 +3865,59 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 				connector->display_info.monitor_range.max_vfreq = vsdb_info.max_refresh_rate_hz;
 			}
 		}
+
+		drm_dbg_driver(adev_to_drm(adev),
+			       "VRR: amd_vsdb i=%d fs_sup=%d min=%d max=%d fs_capable=%d\n",
+			       i, vsdb_info.freesync_supported,
+			       vsdb_info.min_refresh_rate_hz,
+			       vsdb_info.max_refresh_rate_hz, freesync_capable);
+
+		/*
+		 * If AMD VSDB didn't provide a valid FreeSync range, fall back to
+		 * the HDMI 2.1 VRR capability parsed from the HF-VSDB.
+		 */
+		if (!freesync_capable && connector->display_info.hdmi.vrr_cap.supported) {
+			struct drm_hdmi_vrr_cap *vrr_cap =
+				&connector->display_info.hdmi.vrr_cap;
+
+			drm_dbg_driver(adev_to_drm(adev),
+				       "VRR: HF-VSDB fallback: hdmi_vrr=1 vrr_cap[sup=%d min=%d max=%d] mrange_max=%d\n",
+				       vrr_cap->supported, vrr_cap->vrr_min, vrr_cap->vrr_max,
+				       connector->display_info.monitor_range.max_vfreq);
+
+			if (vrr_cap->supported && vrr_cap->vrr_min > 0) {
+				amdgpu_dm_connector->min_vfreq = vrr_cap->vrr_min;
+				amdgpu_dm_connector->max_vfreq = vrr_cap->vrr_max ?
+					vrr_cap->vrr_max :
+					connector->display_info.monitor_range.max_vfreq;
+
+				/*
+				 * VRRMAX = 0 in the HF-VSDB means "up to the Base
+				 * Refresh Rate". If the EDID also did not provide a
+				 * monitor range max, fall back to the Base Refresh
+				 * Rate (the highest refresh rate of the preferred
+				 * timing) so a valid VRR range is still reported to
+				 * userspace.
+				 */
+				if (!amdgpu_dm_connector->max_vfreq) {
+					struct drm_display_mode *brr_mode =
+						amdgpu_dm_get_highest_refresh_rate_mode(amdgpu_dm_connector, true);
+
+					if (brr_mode)
+						amdgpu_dm_connector->max_vfreq =
+							drm_mode_vrefresh(brr_mode);
+				}
+
+				if (amdgpu_dm_connector->max_vfreq -
+				    amdgpu_dm_connector->min_vfreq > 10)
+					freesync_capable = true;
+
+				connector->display_info.monitor_range.min_vfreq =
+					amdgpu_dm_connector->min_vfreq;
+				connector->display_info.monitor_range.max_vfreq =
+					amdgpu_dm_connector->max_vfreq;
+			}
+		}
 	}
 
 	if (amdgpu_dm_connector->dc_link)
@@ -3911,6 +3973,11 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 	if (dm_con_state)
 		dm_con_state->freesync_capable = freesync_capable;
 
+	drm_dbg_driver(adev_to_drm(adev),
+		       "VRR: caps result: freesync_capable=%d min_vfreq=%d max_vfreq=%d\n",
+		       freesync_capable, amdgpu_dm_connector->min_vfreq,
+		       amdgpu_dm_connector->max_vfreq);
+
 	if (connector->state && amdgpu_dm_connector->dc_link && !freesync_capable &&
 	    amdgpu_dm_connector->dc_link->replay_settings.config.replay_supported) {
 		amdgpu_dm_connector->dc_link->replay_settings.config.replay_supported = false;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
index 035d7e88c3ed..382c339b67b1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
@@ -152,6 +152,14 @@ void amdgpu_dm_get_freesync_config_for_crtc(
 	}
 out:
 	new_crtc_state->freesync_config = config;
+
+	drm_dbg_driver(new_con_state->base.connector->dev,
+		       "VRR: cfg vrr_enabled=%d vrr_supported=%d fs_capable=%d vrefresh=%d min=%d max=%d state=%d\n",
+		       new_crtc_state->base.vrr_enabled,
+		       new_crtc_state->vrr_supported,
+		       new_con_state->freesync_capable, vrefresh,
+		       aconnector->min_vfreq, aconnector->max_vfreq,
+		       config.state);
 }
 EXPORT_IF_KUNIT(amdgpu_dm_get_freesync_config_for_crtc);
 
-- 
2.53.0

