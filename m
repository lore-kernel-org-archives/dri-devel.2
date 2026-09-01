Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E8EC61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 19:13:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFD8C10EE9A;
	Tue,  1 Sep 2026 19:13:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="09iheZ4k";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013055.outbound.protection.outlook.com
 [40.93.201.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCB0F10E324;
 Tue,  1 Sep 2026 19:13:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f8Z1+wh9NnYQsN2Nw39X19mMGkEpfKXNOp/EaYSWeV++LFc79I8w729OtRqBbp+S2Wo2ifk4WwZZPXSDm9ivFdVvkZS23e9wHlsAMqCRGYie7FnEOqdCNpLzPZYgkhyABarzRiDVOA1o0/gu/fATW97uxp4FXI/Sa9m7W30DI10hvJ/kx0UrEJk+gVQqI24ZnE8mqfptECRi91TjSGovVcjJS1jhBTo5zubZdZ/dpFFEV+E8VhLhugHYSSK2UinXfQGqUogjnxfJmCPUQi1G1lRRMhYORXWmV9zS3V8SmkaFA8x5Goyb7bzAfWUUVw3DSFPWad73rTrsQ+Xurm4FyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w78hUy6vtKbm38h5LfmUXrJQj1WNdQpeU7PCbhSCD/w=;
 b=oHCkdLdsOlegHbt1mxzBl9OYhIOR36vpgfdsS0K8DhUbsa16kSFpgimUOEHEyLbinwxkKT/pOg161FWvJ++b/41qwTyAznhsKcLRRnaXa0j3+zur0ja3/r4hDi2X8zFYN78TSqXr8SMWFphZZxsBZmnEfwy2DFAIWBetLL0cWePnkFfC7lzYpz93YeCowd23mDNc9zoZK0IW7tS3UH6i5sFvPCV2dd91wJQEsghg/b45qPuMXkGg8K6cJtChAEpNOyluW4nQAQLLOFKA1DSc1vuv2OFWy630dJKpZEkYJZx+NUb9l44+xssniIWWhUq/PAZ+6ns6nEEySLE3rVyY6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w78hUy6vtKbm38h5LfmUXrJQj1WNdQpeU7PCbhSCD/w=;
 b=09iheZ4kbnQCkBj09K+THTck8Zg3vKP1G5ViccrluQnNL9W768ei7NORG2cAOxJwCgSd1AWCwT2fcu4P/nhY63qJkwUJA1zUtaeMuC3tgzaLJlBF+NLWewbP6QcUggdPFliD7mEKzft21+CGLEePpkvoBfyRGK7yQH7jUj9hvP4=
Received: from DM6PR03CA0094.namprd03.prod.outlook.com (2603:10b6:5:333::27)
 by SA3PR12MB9179.namprd12.prod.outlook.com (2603:10b6:806:3a1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 19:13:48 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:5:333:cafe::20) by DM6PR03CA0094.outlook.office365.com
 (2603:10b6:5:333::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 19:13:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 19:13:48 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 14:13:44 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <adolfotregosa@gmail.com>, <harry.wentland@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Tomasz=20Paku=C5=82a?=
 <tomasz.pakula.oficjalny@gmail.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>
Subject: [PATCH v1 2/3] drm/amd/display: Use passive_vrr properties in amdgpu
Date: Tue, 1 Sep 2026 15:12:50 -0400
Message-ID: <20260901191251.2653684-3-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901191251.2653684-1-jerry.zuo@amd.com>
References: <20260901191251.2653684-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|SA3PR12MB9179:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e7521d6-292b-4d6a-6edc-08df085d26c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|56012099006|10067099003|11063799006|5023799004|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: RZzR+MqBnaVtqSDUssUZExBmE0cVQtbo4cK71kP0vhAZ8wE4UiMn2SauJT1WfV/M4JQXUTGEpFWZKj8ROX5aA9RSRKmtTs/+OEIUk3zfEhiy9uBEh5StiQndJP8c8kD3wlnJCYby3YC2V8lXDfcUP/BPKLoPTICulaXxEZ0sinUI2ojWdxGaBbtSj5+tN9OXSp5nIRt8bblV2bTcK2tJNyH7jyM5rQLui6on7HzQmu7H70sXLv1CQD+Scv2rMxQJkcPpqUnr3Y+befsl+kgbQVZSftXpkf45SiNBLYqil3onoxM5uPnFKy6T/cg0ldBI73TmfsSf2+9zUZxjm164lZn8K3hRLmHwV60X2z78IAjtwktySVbgbMh4FiZ4jy737A14yR2idC8STnE77t1ByGtEpttP6Ht75GncRqtxX6Fzps6dS43dkxU+V3YBSiCBcmAmXFTyfTeY0UVPg8ue7RgHsAX4VvlZmypFgQdxtCBdKfCv5f+wmDb6kn/uEGwZSA1/CPwgF+RGGqiJjV5tSBjS/ku8741qYoeRifPs0ZxtcdiDXu94DpXE48tXnoIWF/bg7OwncO/b30n4Qs3/1wzmuBVXkSWtgk4lSxUVhRbWeOPm+Jz+PeLGP/eIouBEirZ9f5pFZsyYMZbFgae3oJtilUbUUFpUT30l9WU1x+bczgnQbDbMQRVJhfWBSyiajcx1DRN+sMKuFlRGvOrzHQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(56012099006)(10067099003)(11063799006)(5023799004)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UPIkozR9Ww4523xX0G1/fjya8c2jye/jLbrgZnN8iE5hzLgKnuCfE28IM62ejLNFUJ49oWF8zPBW6kjpYBA5gw6xSHmFnEgT9AoEM0KriCd+KQEuB4fdu9HV6syUhtj48n/+xkqN1zy2D1QaQYia70ukUvTDUVX/BjBqJSIWKC5XITnVLnQvpuHSzB6zI6NVKdrpqkwdPPgkNRMqTWTh2UhJv7ablAObdcCsml6zCVEvTpKfQ2OvFAPk1HJTxCJqL6qV1QJGUfYyLF7481oKDrTe1I9pUtGbaVO77bAokU6t2wBKvNsWbbG2C5P7IsUibAhb2ul5hi5377/gFzoqUEwCPWHPKyequBn6D+x+BhLPYuREbnzc40gz/6EDjAkl9GoBNah8MAw6fvB/0yHMiERbzIMUA75CM0OlvitiHOTRcuJwT8uv81NgEsbgQUuX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 19:13:48.4834 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e7521d6-292b-4d6a-6edc-08df085d26c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9179
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

Backport of upstream (Tomasz Pakula) amd-gfx v4 27-patch series patch
26/27, adapted to the split amdgpu_dm sources on amd-staging-drm-next.

Wire the passive_vrr DRM properties into amdgpu for HDMI/DP/eDP sinks:
- Add dm_connector_state.freesync_on_desktop_capable and copy it in
  amdgpu_dm_connector_atomic_duplicate_state().
- Attach the passive_vrr_capable connector property alongside
  vrr_capable for non-MST connectors.
- In amdgpu_dm_update_freesync_caps(), record freesync_on_desktop_capable
  and update the passive_vrr_capable property from freesync_capable.
- In amdgpu_dm_get_freesync_config_for_crtc(), drive
  stream->freesync_on_desktop from the inverse of passive_vrr_disabled
  when capable, hooking into the existing DC freesync_on_desktop logic
  that keeps the FreeSync-Active bit set during fixed-refresh (desktop)
  use.

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h    |  1 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c  | 12 ++++++++++--
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c   |  7 +++++++
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 089741ba0619..0b0ab7b2aa43 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1064,6 +1064,7 @@ struct dm_connector_state {
 	uint8_t underscan_hborder;
 	bool underscan_enable;
 	bool freesync_capable;
+	bool freesync_on_desktop_capable;
 	bool update_hdcp;
 	bool abm_sysfs_forbidden;
 	uint8_t abm_level;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 0e71ba498e8a..8b2eec1a683d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -1982,6 +1982,7 @@ amdgpu_dm_connector_atomic_duplicate_state(struct drm_connector *connector)
 	__drm_atomic_helper_connector_duplicate_state(connector, &new_state->base);
 
 	new_state->freesync_capable = state->freesync_capable;
+	new_state->freesync_on_desktop_capable = state->freesync_on_desktop_capable;
 	new_state->abm_level = state->abm_level;
 	new_state->scaling = state->scaling;
 	new_state->underscan_enable = state->underscan_enable;
@@ -3241,8 +3242,10 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 	    connector_type == DRM_MODE_CONNECTOR_eDP) {
 		drm_connector_attach_hdr_output_metadata_property(&aconnector->base);
 
-		if (!aconnector->mst_root)
+		if (!aconnector->mst_root) {
 			drm_connector_attach_vrr_capable_property(&aconnector->base);
+			drm_connector_attach_passive_vrr_capable_property(&aconnector->base);
+		}
 
 
 		if (adev->dm.hdcp_workqueue)
@@ -3978,8 +3981,10 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 		dm_helpers_mccs_vcp_set(adev->dm.dc->ctx, amdgpu_dm_connector->dc_link, sink);
 
 update:
-	if (dm_con_state)
+	if (dm_con_state) {
 		dm_con_state->freesync_capable = freesync_capable;
+		dm_con_state->freesync_on_desktop_capable = freesync_capable;
+	}
 
 	drm_dbg_driver(adev_to_drm(adev),
 		       "VRR: caps result: freesync_capable=%d min_vfreq=%d max_vfreq=%d\n",
@@ -3995,4 +4000,7 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 	if (connector->vrr_capable_property)
 		drm_connector_set_vrr_capable_property(connector,
 						       freesync_capable);
+
+	if (connector->passive_vrr_capable_property)
+		drm_connector_set_passive_vrr_capable_property(connector, freesync_capable);
 }
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
index 281c6cec9f4b..903d5ab387d4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
@@ -138,6 +138,12 @@ void amdgpu_dm_get_freesync_config_for_crtc(
 		config.vsif_supported = true;
 		config.btr = true;
 
+		if (new_con_state->freesync_on_desktop_capable)
+			new_crtc_state->stream->freesync_on_desktop =
+				!new_crtc_state->base.passive_vrr_disabled;
+		else
+			new_crtc_state->stream->freesync_on_desktop = false;
+
 		if (fs_vid_mode) {
 			config.state = VRR_STATE_ACTIVE_FIXED;
 			config.fixed_refresh_in_uhz = new_crtc_state->freesync_config.fixed_refresh_in_uhz;
@@ -149,6 +155,7 @@ void amdgpu_dm_get_freesync_config_for_crtc(
 		}
 	} else {
 		config.state = VRR_STATE_UNSUPPORTED;
+		new_crtc_state->stream->freesync_on_desktop = false;
 	}
 out:
 	new_crtc_state->freesync_config = config;
-- 
2.53.0

