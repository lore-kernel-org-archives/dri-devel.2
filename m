Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D910C44536
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 16:46:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C23410E72F;
	Tue, 21 Jul 2026 16:46:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Po/R6oPU";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010017.outbound.protection.outlook.com [52.101.61.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72A2A10E5CD;
 Tue, 21 Jul 2026 16:46:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nAQySgp7w4l2tmdF+/s9YAWS9uj8eRqdVvBRdNuu/qtANYb7J9YWaQPJAhcycJohANtjVB+0elvJ6JqwKimoDnXsf71d7rnx5w/mXjwwS5PEf0tGJrRLjM/BjdH06IrsB/aeofVkQGwzukyepwevWMwMVxFrrWHPlYw6FOgo8r67PPkVg2jytSjjm5yDoP341KgPae/TYSMHGpb56IjBTGhD9kuU70ojrYtmVOX0a2CP1yCY6OCMe+4jeYrwT5f/Ui9QGM7jifw+OF3Efxidm3AKzSoFZliGHhPn/x0ZBhOAUHXOdo9W1szAuSZfcMNTAYm+KqVXdARQv7u6QE8KxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xG5Iwbd7cjnp2NhLXAudg+2XnKa9oM31hNWMj+L38TM=;
 b=rTfuRZzUItlXLsM++1awNe92KJtJDF28fHarcYc2NLOzfKFPKAGxpUEAqX9uQ0SzoO/x8Zmtb4ipr7haWhK9xNmbSJeDl5UJjWcY64VdL33EUJOPWfNrTD9u/nNrXBaAIbB46Ykk2OKPjAXCh4HQMf/9vaGeBonS2Nni86QlIY1FNjpzo3qii62wdxFan5tOuVrELF+er7pR38Rzw94eLAQsO223WgaKTkMonzmKXJ1/Ff0iW1Aygck5INUAE1BXANhQf6iaQyiuO7IBm7vVg7bkNEaHbMAsSkVDMvbNu4bfuxA7NcGEKMrc4NpbmlMorPW/Ki8yYHg4BfDNc59X/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xG5Iwbd7cjnp2NhLXAudg+2XnKa9oM31hNWMj+L38TM=;
 b=Po/R6oPUxXOy9nBXMc0p5k2sZX9YZdloNHnf4lfL+LhRkAzG0w9iDn7PEBMeZfdKrA76bF8Wx5J8TtWStI7KGpebpZDO+G5KrUEE5tshhSVo3r62Feraz6LMSWlQLZKhtKX343Jg1V1afC9jNwSqc87azK8rG7UsrDZ5GNIb5/8=
Received: from BN9PR03CA0069.namprd03.prod.outlook.com (2603:10b6:408:fc::14)
 by BY5PR12MB4228.namprd12.prod.outlook.com (2603:10b6:a03:20b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 16:46:27 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:408:fc:cafe::44) by BN9PR03CA0069.outlook.office365.com
 (2603:10b6:408:fc::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.18 via Frontend Transport; Tue,
 21 Jul 2026 16:46:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 16:46:27 +0000
Received: from MKMALEXHUAN01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 21 Jul
 2026 11:46:15 -0500
From: Alex Huang <Alex.Huang2@amd.com>
To: <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <harry.wentland@amd.com>, <sunpeng.li@amd.com>, <siqueira@igalia.com>,
 <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <superm1@kernel.org>, <alex.hung@amd.com>
CC: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, Alex Huang <Alex.Huang2@amd.com>
Subject: [PATCH 3/4] drm/amd/display: Clean up FreeSync capability detection
Date: Tue, 21 Jul 2026 12:44:29 -0400
Message-ID: <20260721164430.2121326-4-Alex.Huang2@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260721164430.2121326-1-Alex.Huang2@amd.com>
References: <20260721164430.2121326-1-Alex.Huang2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|BY5PR12MB4228:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a9bf9e9-b1b1-4d77-68fc-08dee7479bba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|7416014|23010399003|376014|5023799004|11063799006|56012099006|10067099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: cQBTZGbvH4i8Ymc+5RFUYI2583OLynGNICS1TBULK6pFNqSgolCh11LymAO8dF2pKn9XJ3IXTIFo8yJDQHFlSnWirFMalk5bmjykD2xUTyq7GSR/ygwvUcQhH6OayJYpDuQePGLOxl7MKFqcECWojlX7LaRQ0Bi+58TwmhaSXLr96DScFgfrwzD6Vh7bePSJXVP3mo9pDcmp1TSve0GBD0HhOFaZ5wqv+w6bsFvYPRmabUlDTc9KGx9ok5Y2FIaB3tQkoIvEdN7wsCeB+Y+Fnk5SemNBTWpyuxYahHX/UVZXOBWg3vYqFXn0lv3OaQnSt/ZgUKAmEOzrXdT/ljA6gcT3oqRfiFdXp1utWHRcIlHgfP9C9r3Zso0ugy+Qkvpm+dAxZe/gxcwkpdRQtvlmH2mP+2FdSXY8mQMqkJKolEqQR+m2MfvZNaDzINsqQwyxvXC3DNqduXNkc8AaV2kScLxJl7Fjg0L6LWqj2THJZcWNBgiOhnKrCATw1Z+d2PMM8bYngWfvNL2lQ2fbHerzRJcp9qUT05Y4STkC1qV41gFIyy1XYBfw9Q9LSOqYBZqp5lnAPXLXzoDX4pDORDjZGKqC9K/c7Uo51Nkzzuu2BNlSwzVBzYMFJSgWnFPSpzzRNH+183Z13eG53NHMq01TEy2hjGdJUONvLlvWnrGdYKpxZIzB89Nf28Crrs/6sV/RxnQgZ7jsa1Vvg2+Wh9pYnhbyXGPdbqj0iXE5IDmJ3O7sRxaVwd0bNXGatI0XEeiW
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(7416014)(23010399003)(376014)(5023799004)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0pmMr1V7xayJzTv3NaePPBFwHSqvAWmqenBLGBZ42dRX67K2qeHTmOgyjDag7MULquwgF6zEqZREOtuH6U42uE31mXRIR7SXF+oCIcuo2uD8hWvB3dGXCkm0/zAVS0MrgCN7Iq8CiJEzhClQkRL1h2qWcWdkVaO5FA1ux058IIGljF4Q9SAZgXoA1wtgNa5ayn788aSDOcqa6FbAaPbS9hx+gOiRGrgk6GvU9p0Cglg3ipZXM8l/EjJ46DlBxlc2V4p1D+dcHDHzxSF9QYp9xlwYA3T4EVix5tZqITKdVIDn5oxiAP3txxZYgVc7HJ/rxHLWZDZTVzVhYpy2XnX5HxoERwgWoQxB2cko1hPN1+8rGloBzxJiB2XRfxHsyGdGRPUzXp3220TBAcnvfBpQ3TLNeOPR0KWnylRlzAlUDZ8HBZcjugrUW0AgUPGqT2vI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 16:46:27.4128 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a9bf9e9-b1b1-4d77-68fc-08dee7479bba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4228
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
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 82 +++++++++----------
 1 file changed, 39 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index fd9bb205c8f0..23bfcefa1dbb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -13707,7 +13707,7 @@ static int get_amd_vsdb(struct amdgpu_dm_connector *aconnector,
 void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 				    const struct drm_edid *drm_edid, bool do_mccs)
 {
-	int i = 0;
+	bool has_vsdb = 0;
 	struct amdgpu_dm_connector *amdgpu_dm_connector =
 			to_amdgpu_dm_connector(connector);
 	struct dm_connector_state *dm_con_state = NULL;
@@ -13751,63 +13751,59 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
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
+		amdgpu_dm_connector->vsdb_info.amd_vsdb_version = vsdb_info.amd_vsdb_version;
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
 			amdgpu_dm_connector->vsdb_info.replay_mode = vsdb_info.replay_mode;
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

