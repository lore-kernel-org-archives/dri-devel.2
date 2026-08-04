Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D136C55184
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 14:34:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CB6410EAA5;
	Tue,  4 Aug 2026 14:34:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DqRHA1vf";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011044.outbound.protection.outlook.com [52.101.52.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2ED5010EA94;
 Tue,  4 Aug 2026 14:34:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XcTywt1DaE8UZzUzqRHPEUbHEN9iG3JNzbSERnBfuwl6eTw4uP0nX6U3SRKfgdkVlvj1Dnsk5IbxjlmuQHZc3gFPHKRV1Mc6J7/ybFwegTAhkOvjmmjGrl0hEomjMUhk8dFfJXoa8TwDcSQuf9gDOnbhLx3za5DwCNToNk4ekRnlBenMhWChXUeeRsHgeTKZbdvHk/iMlN4s9E0bzqujeVWEpQkMFxkBEjIEnKId1pdUUn4pCWEmQBzMFsO/pgBspY5CQV4BoycPQyxfF1K9o0N3Mo+eYjaKKprLy7yhZdlJNX8pCKFvp7NtoZ8OZF6U48WNJPZz0HSSGA02NCkyHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VwJdaQUc27Kq/H1XYD3azV0P5HGfx76r8EzpkYPasLs=;
 b=LRnlFa05AfyTqh+si0LF3HlmqlZQhwhubBqPbBZmkOhNRpJzmn1o/oHOcarBq+mTqoIvNrU7aB+AmQ0wGY48JX7O/Zqu0QL/06zQMHOuDpasV+YrmKXMIEgFV/QQDLrLHZBUeREP/GtrFw83LGJNkdF7r7tvsih56GkAFsmWEiNZ7b9MOrjyoBNkoO8+cWRohOSUU/O6/8/4dV/CqhtFyHrP5bHtlb3cmxIULfcXgK3Q3kPF1oRqHNufPUI0ZtKKTFYwKZb79oD462JTc3mg4Ho5mn0ghojFCbUmxDBMFFaXye0viUE3wOqxt2tZSi6+0ZbgyfrSTEZoHGKgIrCwTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VwJdaQUc27Kq/H1XYD3azV0P5HGfx76r8EzpkYPasLs=;
 b=DqRHA1vfm07p/wV5OuP5mHnprQGLqjEqxIcxHAEksVWTFbSSO3K3qiclGOkZMNfXMPUoITGhisOevJ/jVdDqJLmGcsrUzx879y7FUIotDy3j6BloG0tWnCrpD/oEDCT5aVyA5jpNNasf8s3gCI1W3pRhNsTynYoRM4kv3i9r2E4=
Received: from MW4PR04CA0042.namprd04.prod.outlook.com (2603:10b6:303:6a::17)
 by SA3PR12MB8764.namprd12.prod.outlook.com (2603:10b6:806:317::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 14:34:01 +0000
Received: from CO1PEPF000075F0.namprd03.prod.outlook.com
 (2603:10b6:303:6a:cafe::70) by MW4PR04CA0042.outlook.office365.com
 (2603:10b6:303:6a::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.16 via Frontend Transport; Tue, 4
 Aug 2026 14:34:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075F0.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 14:34:00 +0000
Received: from MKMALEXHUAN01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 4 Aug
 2026 09:33:59 -0500
From: Alex Huang <Alex.Huang2@amd.com>
To: <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <harry.wentland@amd.com>, <sunpeng.li@amd.com>, <siqueira@igalia.com>,
 <alexander.deucher@amd.com>, <christian.koenig@amd.com>, <alex.hung@amd.com>
CC: <superm1@kernel.org>, <dri-devel@lists.freedesktop.org>,
 <amd-gfx@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, Alex Huang
 <Alex.Huang2@amd.com>
Subject: [PATCH v3 3/4] drm/amd/display: Clean up FreeSync capability detection
Date: Tue, 4 Aug 2026 10:33:38 -0400
Message-ID: <20260804143339.714548-4-Alex.Huang2@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260804143339.714548-1-Alex.Huang2@amd.com>
References: <20260804143339.714548-1-Alex.Huang2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F0:EE_|SA3PR12MB8764:EE_
X-MS-Office365-Filtering-Correlation-Id: 26e0eb0d-0a4d-4bfe-eacd-08def2356d1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|7416014|1800799024|82310400026|10067099003|921020|56012099006|22082099003|18002099003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: ze944VVUlkRoxkHS4w0vkEznL/3ZaCTcd9/CV2fVI3AleVtXczwWndFHgJzU02V3Vx/vF767bHDR0/US9HnHE/sJbV6WpQrqC5oGXRkQZIrdHEko0HrnqhpF8qOIYaI9+UWFiPVz4QSEVO/aHHTYBsVHRnRDMoNeQZCVoDX5EpUcZDl56duYqrdHRp6Wu0BPAOlAqD6qhGZikFkrFPUf4yQnSXwwYFHL1aWikg/lzsDVCJHwpLKG/pOMgIkwuCpYTf6HUsSej6JwXEpxdrml99Ya8vbdD8TXJCzC8bn25E4oA1yrhTAbVn/oVfVh9x/oIHMWn0odf7uXfrdP88j7tQbOgCTUPUBIa5Ge4pB98IXfWWSNss+1wOEDgung3x6/r3zk93v5Jf6CRNBiOJFfLMJwFKp1LMqhtGKY3spVPOmnFMd38jXTWEqfunBCi+SG9GIBCGVxzOFyt0RqTN4bMy15GvFFOPSxpzC1sOdTdaSnwkpLrSVBV65EsNwReQW6tXWgGii46CdbckHbanzdQO5OYd4q0AFecj0UJDCXY4Rbh0RCdlRUd3F8DheFUn7f/0kXz0aXV+zgsDzohdNgAB8plSLpV6cFmsDOqHIe/ztHkB1RjfdSRWvYbDn4nzw5FuUyI9GrJoJTZOMAJoyyzvcRWcXoT2Kx5AErfiFJB9evKR9crUj6cRiYB1ZXVd8njutWo7TxIKpnxb8neQ0Xn3IWVz/qngrZ4ZmbI1w8aEAZtBatF7eiPPdtdfwED0yV
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(7416014)(1800799024)(82310400026)(10067099003)(921020)(56012099006)(22082099003)(18002099003)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: C6yj27fo62CwVHoDHHLx8r7bALBvejx6JvijNFq2G7UoJggV9v3bp/wvxyo+dVqT2fQnNDaBBttm8L6iFAYgnc1YMF8Uf2ad8pYPveB7klr7SSYOLWJSdXe4und+7PoQUTuWhbPg5mfVvzL1GSDoP5QaG+WsVn0EGDNWqlXnFVrDCjTGq0E+rNkdwwN5pco8r7IRTT/Nq96EcByTtSOgRv9mGTt2N2BhbSJLUd198JUoi+LmCKcexMlAY9vhBzWDSM9VDwGlTAYGMId/6AzLrEpv11sRjFVQsW2usa/WybTNOYe6hmn8npLcOcIMgeieBgmGdDgtoPztC6ZSxDOwc9V5A8DL0RxGtHcWr7BLzwCJcmJ0x4qOSIrBeBc8Z2JaByZUdi9FYuDBKxg7M9+fc2/VJ/52XQ1u24b346bcZuoHAi+6O5c6p2fx/1yAmo3W
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 14:34:00.9580 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26e0eb0d-0a4d-4bfe-eacd-08def2356d1b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8764
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

Many duplicate codes can be extracted to common code, fill
amdgpu_dm_connector fields outside of the DP/eDP, HDMI branches,
pull the VSDB data once using get_amd_vsdb() and then derive the refresh
rate ranges.

When a monitor advertises support for FreeSync, the refresh rate from
the AMD VSDB is used, otherwise, falls back on the monitor_range, either
EDID refresh rate range field or DisplayID VRR data.

Signed-off-by: Alex Huang <Alex.Huang2@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 82 +++++++++----------
 1 file changed, 38 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 44b8dd000f5c..6d83e9a42537 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -13722,7 +13722,7 @@ static int get_amd_vsdb(struct amdgpu_dm_connector *aconnector,
 void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 				    const struct drm_edid *drm_edid, bool do_mccs)
 {
-	int i = 0;
+	bool has_vsdb = 0;
 	struct amdgpu_dm_connector *amdgpu_dm_connector =
 			to_amdgpu_dm_connector(connector);
 	struct dm_connector_state *dm_con_state = NULL;
@@ -13766,63 +13766,57 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 	     connector->display_info.monitor_range.max_vfreq == 0))
 		parse_edid_displayid_vrr(connector, edid);
 
-	if (edid && (sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT ||
-		     sink->sink_signal == SIGNAL_TYPE_EDP)) {
-		if (amdgpu_dm_connector->dc_link &&
-		    amdgpu_dm_connector->dc_link->dpcd_caps.allow_invalid_MSA_timing_param) {
-			amdgpu_dm_connector->min_vfreq = connector->display_info.monitor_range.min_vfreq;
-			amdgpu_dm_connector->max_vfreq = connector->display_info.monitor_range.max_vfreq;
-			if (amdgpu_dm_connector->max_vfreq - amdgpu_dm_connector->min_vfreq > 10)
-				freesync_capable = true;
+	has_vsdb = get_amd_vsdb(amdgpu_dm_connector, &vsdb_info) != 0;
+
+	if (has_vsdb) {
+		amdgpu_dm_connector->vsdb_info = vsdb_info;
+
+		/* copy refresh rate info as long as VSDB advertises FreeSync */
+		if (vsdb_info.freesync_supported) {
+			amdgpu_dm_connector->min_vfreq = vsdb_info.min_refresh_rate_hz;
+			amdgpu_dm_connector->max_vfreq = vsdb_info.max_refresh_rate_hz;
+
+			connector->display_info.monitor_range.min_vfreq =
+				vsdb_info.min_refresh_rate_hz;
+			connector->display_info.monitor_range.max_vfreq =
+				vsdb_info.max_refresh_rate_hz;
 		}
+	} else {
+		/* fall back to the base EDID range when there is no VSDB */
+		amdgpu_dm_connector->min_vfreq = connector->display_info.monitor_range.min_vfreq;
+		amdgpu_dm_connector->max_vfreq = connector->display_info.monitor_range.max_vfreq;
+	}
 
-		get_amd_vsdb(amdgpu_dm_connector, &vsdb_info);
+	if (sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT ||
+	    sink->sink_signal == SIGNAL_TYPE_EDP) {
+		if (amdgpu_dm_connector->dc_link &&
+		    amdgpu_dm_connector->dc_link->dpcd_caps.allow_invalid_MSA_timing_param &&
+		    amdgpu_dm_connector->max_vfreq - amdgpu_dm_connector->min_vfreq > 10)
+			freesync_capable = true;
 
 		if (vsdb_info.replay_mode) {
-			amdgpu_dm_connector->vsdb_info.replay_mode = vsdb_info.replay_mode;
-			amdgpu_dm_connector->vsdb_info.amd_vsdb_version = vsdb_info.amd_vsdb_version;
 			amdgpu_dm_connector->as_type = ADAPTIVE_SYNC_TYPE_EDP;
 		}
+	} else if (has_vsdb && sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A) {
+		sink->edid_caps.freesync_vcp_code = vsdb_info.freesync_mccs_vcp_code;
 
-	} else if (drm_edid && sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A) {
-		i = get_amd_vsdb(amdgpu_dm_connector, &vsdb_info);
-		if (i) {
-			amdgpu_dm_connector->vsdb_info = vsdb_info;
-			sink->edid_caps.freesync_vcp_code = vsdb_info.freesync_mccs_vcp_code;
-
-			if (vsdb_info.freesync_supported) {
-				amdgpu_dm_connector->min_vfreq = vsdb_info.min_refresh_rate_hz;
-				amdgpu_dm_connector->max_vfreq = vsdb_info.max_refresh_rate_hz;
-				if (amdgpu_dm_connector->max_vfreq - amdgpu_dm_connector->min_vfreq > 10)
-					freesync_capable = true;
-
-				connector->display_info.monitor_range.min_vfreq = vsdb_info.min_refresh_rate_hz;
-				connector->display_info.monitor_range.max_vfreq = vsdb_info.max_refresh_rate_hz;
-			}
-		}
+		if (vsdb_info.freesync_supported &&
+		    amdgpu_dm_connector->max_vfreq - amdgpu_dm_connector->min_vfreq > 10)
+			freesync_capable = true;
 	}
 
 	if (amdgpu_dm_connector->dc_link)
 		as_type = dm_get_adaptive_sync_support_type(amdgpu_dm_connector->dc_link);
 
-	if (as_type == FREESYNC_TYPE_PCON_IN_WHITELIST) {
-		i = get_amd_vsdb(amdgpu_dm_connector, &vsdb_info);
-		if (i) {
-			amdgpu_dm_connector->vsdb_info = vsdb_info;
-			sink->edid_caps.freesync_vcp_code = vsdb_info.freesync_mccs_vcp_code;
+	if (has_vsdb && as_type == FREESYNC_TYPE_PCON_IN_WHITELIST) {
+		sink->edid_caps.freesync_vcp_code = vsdb_info.freesync_mccs_vcp_code;
 
-			if (vsdb_info.freesync_supported && vsdb_info.amd_vsdb_version > 0) {
-				amdgpu_dm_connector->pack_sdp_v1_3 = true;
-				amdgpu_dm_connector->as_type = as_type;
+		if (vsdb_info.freesync_supported && vsdb_info.amd_vsdb_version > 0) {
+			amdgpu_dm_connector->pack_sdp_v1_3 = true;
+			amdgpu_dm_connector->as_type = as_type;
 
-				amdgpu_dm_connector->min_vfreq = vsdb_info.min_refresh_rate_hz;
-				amdgpu_dm_connector->max_vfreq = vsdb_info.max_refresh_rate_hz;
-				if (amdgpu_dm_connector->max_vfreq - amdgpu_dm_connector->min_vfreq > 10)
-					freesync_capable = true;
-
-				connector->display_info.monitor_range.min_vfreq = vsdb_info.min_refresh_rate_hz;
-				connector->display_info.monitor_range.max_vfreq = vsdb_info.max_refresh_rate_hz;
-			}
+			if (amdgpu_dm_connector->max_vfreq - amdgpu_dm_connector->min_vfreq > 10)
+				freesync_capable = true;
 		}
 	}
 
-- 
2.34.1

