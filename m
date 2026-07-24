Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32493C531FA
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 16:18:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 539C110F441;
	Fri, 24 Jul 2026 16:18:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="umqAej7V";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010015.outbound.protection.outlook.com [52.101.61.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3538510E38B;
 Fri, 24 Jul 2026 16:18:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k7fuzQnvT09f//auDjkztjwPDeTEm2GtQ8iZnjmsZkHLkdQxyjwVJMT24BisqiIB7uL0EM7GYL7qE2AP6cJz8bm5aOAQhCRL8e5sNk6m0ZGl5pB3FFROzYmZxxhGmQBr53uo3KUixWy4Orv7Advr/Vv7Dk6RRNfkuqxYit3Dty68kPDb9jxq1xtq/Z+UJ5uhnPhYin08oEtT38vdFEap1Md/sqtQERExW3GqYhsat3vyOv+VXCv1XD4jGJR55+ynzGZssXz2KdrHEYSBnmCLzSxOFI4ycDfWI6Z44CX9oh160r8vDdmgTelPgs5pxQmTs9YNqKx6MoRWwQ4DfLygMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xWvYjF+Ewft1MmckU6Iod6mjugUf+Q2C6IRBnpKp50E=;
 b=Wu948GkOaDNlQNlJwegGDII5GTm5IWsA/7kaQ2ylt6BODEuys1O5ykWnr9FN04sK4j/lg+FlRxTjy+WMzPrHQ7sqsvF4GOXuipTn+bvBW7cOqzFi8RCaWohlpmKjwRjnOsa4l+v2R/fssdjaO+yO3Yu05yfhS5BIiYwqt/5cGIKwBbaB/elxxKW+F7FrYkBozoMO/yHblDkcWdqMVxvt2rVf02jWCZ+Cl8mnX4pGGUA5XUpBJ/fGNIHaPgcOJhfUVZMOsbsvywIargFj+D8wivHBIOeadSgA3vKXS/nnsdll2gwTWrxgUxGylLDyEitY6y/d+3JaYU7/+x1ic2fJqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWvYjF+Ewft1MmckU6Iod6mjugUf+Q2C6IRBnpKp50E=;
 b=umqAej7VQ+38HbpBgCzADvbJkzksgdUG6WUw7DUDCOTrIuWN9NtuRnBDOUeU9/RklhiB7ic4KgWCpuCRwNNbbrUmLfk0ilQWXruCsfwLj5fXS3galNbXiLRD7NZtTCV+cjIqL+ziWM1vyiqWN4IDYj+iQOUV0A0Or+vrvTxmjbA=
Received: from SN7PR04CA0033.namprd04.prod.outlook.com (2603:10b6:806:120::8)
 by CYYPR12MB8940.namprd12.prod.outlook.com (2603:10b6:930:bd::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 16:17:58 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:806:120:cafe::84) by SN7PR04CA0033.outlook.office365.com
 (2603:10b6:806:120::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.12 via Frontend Transport; Fri,
 24 Jul 2026 16:17:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Fri, 24 Jul 2026 16:17:58 +0000
Received: from MKMALEXHUAN01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 24 Jul
 2026 11:17:56 -0500
From: Alex Huang <Alex.Huang2@amd.com>
To: <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <harry.wentland@amd.com>, <sunpeng.li@amd.com>, <siqueira@igalia.com>,
 <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <superm1@kernel.org>, <alex.hung@amd.com>
CC: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, Alex Huang <Alex.Huang2@amd.com>
Subject: [PATCH v2 3/4] drm/amd/display: Clean up FreeSync capability detection
Date: Fri, 24 Jul 2026 12:17:12 -0400
Message-ID: <20260724161713.119382-4-Alex.Huang2@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260724161713.119382-1-Alex.Huang2@amd.com>
References: <20260724161713.119382-1-Alex.Huang2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|CYYPR12MB8940:EE_
X-MS-Office365-Filtering-Correlation-Id: f8d31363-9cc4-4ad8-4297-08dee99f2054
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|82310400026|376014|36860700016|23010399003|22082099003|18002099003|11063799006|5023799004|921020|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: bXUtnU74Jk5uswaV8FjLysaz3PuREAVSSGcsQQ3/P8m/RxYT3qvNvAb4c7iW1zDcDfVbERC9AMei/6WUunudgfI0ns0e16Oef6tmDNYGHGUStUKpFczUMl6dXowDd0gh+alE3WKllKOvHkeGAEozkIqAebzEw7tW+kigK0g2PyPeEqUQSBW5Xl47emDQGVz2kZbImLRKwzwSpMJR1Ms7o0yjSKfvFjR2nZ6IK8xOYdD7uxJgghF8XwiaY5m6KmNAJGF9yQKi+IIoPKcnfx6CB1Wvklo1prXVyfFycY29j+dVv84stuSN4dJIUMkB5CTn4SpceJ86DHP668FJq51KrN7fzAmbntuNO5VXEgfpccNcr1vbqIUKH4juVBfURin0grabyPDeaJXzVY+LK6tL3GqUCcW1v+OMAWEHuBVTHTgWIE2A8GWTiYTe9s2ukWPBd7VzIiRtz4sECqvgIk6EWGXOEGgulkV+K2sjZpAnvr2gcUY1UmfdE1D7ZZvhakIYHdGEcVkqY2Qmme18Id2t3X1gitNBBAc65NzJLg0dKS5Qa8ww5ZjDL7fOOKhZW1sOlbUGUilmrBfPJWfjX6oeVvlTpZ6MKOEhKpckWeuRC45ei5OpVC1NtR4UjywIn8oTtTikO5YtVYaDcdCsqp7twVCjruSw9OQ1U1widUot/UsGq5Lt648C4sKp5jYTYpwr3ta2z0Vgwt9tfqhbb/2yP22BSUxPezswfPt4TarT6IWXu6XnHI9FgbN+AZl0rmkF
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(22082099003)(18002099003)(11063799006)(5023799004)(921020)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: djcZ4RRqcFkY8k4uDPaowa9uESqVRyghmFaKZxwHiUlVn+YiH8f/E/8uvEZARkk2aLckRrgrGazHCEvx9Dw0sqsEjv7TjzGCqQgwZhMfoUQWWeL6MZ+GXqxUWIe43vf8GhOqq6JYr6QaIKUR+Z7+UW5MSmRQbJzWIv4sBF/uIvrz+NtUsZHZjYPlABIp6DZycFiEBx/iL/I6iduiUSm6t+M4hZ6nv0Nta1jX28gmfRtTuGOpUQQ5O28XcJJmiXr6PWEf+eNZustcdn7BwqtQ+auMzePdg3N0nwr5sR4yR7arMVIvm4Y6JST0gWvmh/tAGtEEQFq9p5ud/8RX+HsTeKVeUutlkM9RNg72me+cWy1cxVbS4RWBSVnjn3FF4aK9cdE0QDug622Nei37cdAQq8YVNtFriLHNAuzdMfRXK0Y53QJIR1LXWPnxRARGEx3h
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 16:17:58.4010 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8d31363-9cc4-4ad8-4297-08dee99f2054
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8940
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
 1 file changed, 38 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index fd9bb205c8f0..06ab1c2ef951 100644
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
@@ -13751,63 +13751,57 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
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

