Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D109EC55838
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 14:34:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 890CC10EAAE;
	Tue,  4 Aug 2026 14:34:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YS+lz7a6";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012041.outbound.protection.outlook.com [52.101.53.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C700A10E670;
 Tue,  4 Aug 2026 14:34:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nKeD4C862kcJEN57QCrEwui3BJHEXQwCrbO4cESMJfRLvKwcWRqBGh9OpguOaj/3i3pAf8MxscuntFm8t14kf5fLgVwgTiN6d2TJe8SPSxww5ijgvCw24jEzS76hf/SiM3mtbUZq3g1ZUP3tXY305A4FKx3k6+L5BWX23B9NyL4WQ0Fz/X/KAQDuU7u8vqZk6cBW5YGGqf0pkOtcIFhE5GWkzcMtqIqdSUlTVCvHNKTJPLmaqJUNY6iZk/i1rkK2PxPByzw+ITaHKHaTRZfjF+WHMnkrK5cO3WMHj9NQROzE4ptgpqn1I4pdsLAKl3H8NiQR8GF8Y4RZCfM4gIAOxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i4j0qbqs01YGXAAhmUG0ZLeS2gx/WgH9CkjycqDiPx0=;
 b=DyCASCspQLecHmnSJvw+1/JB5uXWmK4FjvEmnqZQVSrh21S6ITM0j0oArby3YGMTyzMVzQfK8e9SICXUAqS0iXYwZwvEr4ER4pwomHSWyjwJzueKd4YsFD3MEmRoAomBqr/u6jkDmgpV28FcXRun2WOuZuELVXmI2hpA2Pslk9qJOGsMyZcPT4S7efvEdtSKE08IWJeIs4hIH7tV34LUJi9no21ExSAx6E6dewZ/CAsVDMbpzWW69a+6PJ0GZET5IrMj55hRM7VPvclvi3duAv/SXqfwtkkMm0VW6wFn2uy6kqBfipY+YRPjeqc6a0I1qf65gcBtQGT8hcQXM+TpOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4j0qbqs01YGXAAhmUG0ZLeS2gx/WgH9CkjycqDiPx0=;
 b=YS+lz7a6ev/ghAkAcUanpxrGLD9xPffWNhXoE4Kl4BS/mFQWvSPzVcd0yxtBRs6zl5FhFPU89i3IBvQoR7zwBKm1sQmG86W6FEXNeWERlLmqftBJ+oj8M+dClOd06D2Uq9poTtp5F/xGuVCHuv86UL7aJE5tVAFIZ3xENHyp4fM=
Received: from MW4PR04CA0054.namprd04.prod.outlook.com (2603:10b6:303:6a::29)
 by LV3PR12MB9412.namprd12.prod.outlook.com (2603:10b6:408:211::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 14:34:00 +0000
Received: from CO1PEPF000075F0.namprd03.prod.outlook.com
 (2603:10b6:303:6a:cafe::10) by MW4PR04CA0054.outlook.office365.com
 (2603:10b6:303:6a::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.16 via Frontend Transport; Tue, 4
 Aug 2026 14:34:00 +0000
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
 2026 09:33:58 -0500
From: Alex Huang <Alex.Huang2@amd.com>
To: <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <harry.wentland@amd.com>, <sunpeng.li@amd.com>, <siqueira@igalia.com>,
 <alexander.deucher@amd.com>, <christian.koenig@amd.com>, <alex.hung@amd.com>
CC: <superm1@kernel.org>, <dri-devel@lists.freedesktop.org>,
 <amd-gfx@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, Alex Huang
 <Alex.Huang2@amd.com>
Subject: [PATCH v3 2/4] drm/amd/display: Use HDMI FreeSync range from common
 EDID parser
Date: Tue, 4 Aug 2026 10:33:37 -0400
Message-ID: <20260804143339.714548-3-Alex.Huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F0:EE_|LV3PR12MB9412:EE_
X-MS-Office365-Filtering-Correlation-Id: 770339b8-fbd9-43e2-dd5f-08def2356c93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|82310400026|1800799024|36860700016|23010399003|22082099003|6133799003|18002099003|3023799007|56012099006|11063799006|10067099003|921020;
X-Microsoft-Antispam-Message-Info: jh5p8XL5D4nRKq6OeDgZlO1hr+46uYbhFUX9QOzaXgXdwsusJZoe9SqDyBzbceaJKIfObS6VZ/aQrwHcjlWEgscT8X9jjes2NDHMoXWgMbV2Z9N6tjBv+ajN6+PWmZ8Pniwrf27Z3a72XZxdtbQmpjUpQCFaoYtO2VdW3phDaSn2mw5wEENaqLJGBRl8rHAD0SPSZN8pK2v8okGSIvkPAJz6qh43o27sbDljHH33WP4FFzYxqWUSj8Bofbo9RQbd6fKFJq2P8YbWBiD11zrZPdspZqWx4SpyoCYjndNK3pgWTo8XLDLxjaOg+N5ZPJHb/1iw4AHTUPQPKKWo0jskbSOWIMMCc0Vjyp/omf7r9gJb5q3qlZyam8Gf8zvlITPH3obcgxsGk6uXHMHzvE7ssr8NjsUIk+wA10cqlEZ2lGKTOMhSNbGDoIk3aCvMWME7FpltxrfU8Ug3+Cd6vQW4cL5gUM5zAOjPF1xhmYQQ0dVZ9pvZZXLKD1aVYWQT+bfDcJarrP/rsFM+XU+KcE8prc0CZ43/PyLtSw9C5nvl9T2NDWstFNZFg+ROyZMCeok1uDKMya/FYcUUXl1aEvOmgCVZelEC5bBRNeie3KNba7NhN2SwDPd1Z78rJfmIOrRwv1onh5KD2usf3XPDKHGGI51/3kUFMkRL7nqtNqLGWfFvwOBZjy+EFBUjpbRmDjkFIr10PNYonTqfd5iunnuEOP2/PqLF7gjjU2FJvNjYAueaJTqkqlSG5CcjqU4MFAvK
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700016)(23010399003)(22082099003)(6133799003)(18002099003)(3023799007)(56012099006)(11063799006)(10067099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jhqVY6QLsBkWhEDeskLAFCaBZV0Okn/55cUz9QDHBmI8Nj/YVv/LTtmXqa0Ezzsm9m5uo6B+1f1XfPJBatjlBB3PdXFtWLjnAIwngrcrRlnoSk2exNIoS6UozWERJOjL10DcYAWRipikKvXO77ej2g24/DuLFyrKUelRP2FFkqT5X6CwrYD53gLOlDtJ01CbsbSkNbDDSX8iqChJUnEvgsaY0w54qgH/3CETJvAOWRChjrd9naJhQIqKsC5rU/Zt0CY6MK3DTJzhFgOswUWEnj/bP5bQKzLg3PJbv2H8FMjI0dxig4BJlrJ8ujJSklSjGK5HMgWan5er4g8Sp1rv11CRCCkz+Ta4SqVl9j9ABcrwduxaRgFezhmOYbmkUCt4oHZr5qfJLxw4HoCfoJriPCTtFGNGtGX/V6J5AN8paaFybGFNtzbrl+tnuRAzG0Q0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 14:34:00.0666 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 770339b8-fbd9-43e2-dd5f-08def2356c93
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9412
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

HDMI FreeSync on amdgpu is detected using the AMD VSDB parser in the
DMUB firmware, now that the common DRM EDID parser can do the same, use
the common parser.

Extend get_amd_vsdb() to copy the relevant flags and data now being
extracted from the AMD VSDB. Additionally, parse_hdmi_amd_vsdb() and the
parse_edid_cea() firmware helpers now have no callers; remove them.

Signed-off-by: Alex Huang <Alex.Huang2@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 178 +-----------------
 1 file changed, 8 insertions(+), 170 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 1820547b1dde..44b8dd000f5c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -36,7 +36,6 @@
 #include "dc/inc/hw/dmcu.h"
 #include "dc/inc/hw/abm.h"
 #include "dc/dc_dmub_srv.h"
-#include "dc/dc_edid_parser.h"
 #include "dc/dc_stat.h"
 #include "dc/dc_state.h"
 #include "amdgpu_dm_trace.h"
@@ -13647,139 +13646,6 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 	return ret;
 }
 
-static bool dm_edid_parser_send_cea(struct amdgpu_display_manager *dm,
-		unsigned int offset,
-		unsigned int total_length,
-		u8 *data,
-		unsigned int length,
-		struct amdgpu_hdmi_vsdb_info *vsdb)
-{
-	bool res;
-	union dmub_rb_cmd cmd;
-	struct dmub_cmd_send_edid_cea *input;
-	struct dmub_cmd_edid_cea_output *output;
-
-	if (length > DMUB_EDID_CEA_DATA_CHUNK_BYTES)
-		return false;
-
-	memset(&cmd, 0, sizeof(cmd));
-
-	input = &cmd.edid_cea.data.input;
-
-	cmd.edid_cea.header.type = DMUB_CMD__EDID_CEA;
-	cmd.edid_cea.header.sub_type = 0;
-	cmd.edid_cea.header.payload_bytes =
-		sizeof(cmd.edid_cea) - sizeof(cmd.edid_cea.header);
-	input->offset = offset;
-	input->length = length;
-	input->cea_total_length = total_length;
-	memcpy(input->payload, data, length);
-
-	res = dc_wake_and_execute_dmub_cmd(dm->dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY);
-	if (!res) {
-		drm_err(adev_to_drm(dm->adev), "EDID CEA parser failed\n");
-		return false;
-	}
-
-	output = &cmd.edid_cea.data.output;
-
-	if (output->type == DMUB_CMD__EDID_CEA_ACK) {
-		if (!output->ack.success) {
-			drm_err(adev_to_drm(dm->adev), "EDID CEA ack failed at offset %d\n",
-					output->ack.offset);
-		}
-	} else if (output->type == DMUB_CMD__EDID_CEA_AMD_VSDB) {
-		if (!output->amd_vsdb.vsdb_found)
-			return false;
-
-		vsdb->freesync_supported = output->amd_vsdb.freesync_supported;
-		vsdb->amd_vsdb_version = output->amd_vsdb.amd_vsdb_version;
-		vsdb->min_refresh_rate_hz = output->amd_vsdb.min_frame_rate;
-		vsdb->max_refresh_rate_hz = output->amd_vsdb.max_frame_rate;
-		vsdb->freesync_mccs_vcp_code = output->amd_vsdb.freesync_mccs_vcp_code;
-	} else {
-		drm_warn(adev_to_drm(dm->adev), "Unknown EDID CEA parser results\n");
-		return false;
-	}
-
-	return true;
-}
-
-static bool parse_edid_cea_dmcu(struct amdgpu_display_manager *dm,
-		u8 *edid_ext, int len,
-		struct amdgpu_hdmi_vsdb_info *vsdb_info)
-{
-	int i;
-
-	/* send extension block to DMCU for parsing */
-	for (i = 0; i < len; i += 8) {
-		bool res;
-		int offset;
-
-		/* send 8 bytes a time */
-		if (!dc_edid_parser_send_cea(dm->dc, i, len, &edid_ext[i], 8))
-			return false;
-
-		if (i+8 == len) {
-			/* EDID block sent completed, expect result */
-			int version, min_rate, max_rate;
-
-			res = dc_edid_parser_recv_amd_vsdb(dm->dc, &version, &min_rate, &max_rate);
-			if (res) {
-				/* amd vsdb found */
-				vsdb_info->freesync_supported = 1;
-				vsdb_info->amd_vsdb_version = version;
-				vsdb_info->min_refresh_rate_hz = min_rate;
-				vsdb_info->max_refresh_rate_hz = max_rate;
-				/* Not enabled on DMCU*/
-				vsdb_info->freesync_mccs_vcp_code = 0;
-				return true;
-			}
-			/* not amd vsdb */
-			return false;
-		}
-
-		/* check for ack*/
-		res = dc_edid_parser_recv_cea_ack(dm->dc, &offset);
-		if (!res)
-			return false;
-	}
-
-	return false;
-}
-
-static bool parse_edid_cea_dmub(struct amdgpu_display_manager *dm,
-		u8 *edid_ext, int len,
-		struct amdgpu_hdmi_vsdb_info *vsdb_info)
-{
-	int i;
-
-	/* send extension block to DMCU for parsing */
-	for (i = 0; i < len; i += 8) {
-		/* send 8 bytes a time */
-		if (!dm_edid_parser_send_cea(dm, i, len, &edid_ext[i], 8, vsdb_info))
-			return false;
-	}
-
-	return vsdb_info->freesync_supported;
-}
-
-static bool parse_edid_cea(struct amdgpu_dm_connector *aconnector,
-		u8 *edid_ext, int len,
-		struct amdgpu_hdmi_vsdb_info *vsdb_info)
-{
-	struct amdgpu_device *adev = drm_to_adev(aconnector->base.dev);
-	bool ret;
-
-	mutex_lock(&adev->dm.dc_lock);
-	if (adev->dm.dmub_srv)
-		ret = parse_edid_cea_dmub(&adev->dm, edid_ext, len, vsdb_info);
-	else
-		ret = parse_edid_cea_dmcu(&adev->dm, edid_ext, len, vsdb_info);
-	mutex_unlock(&adev->dm.dc_lock);
-	return ret;
-}
-
 static void parse_edid_displayid_vrr(struct drm_connector *connector,
 				     const struct edid *edid)
 {
@@ -13830,42 +13696,14 @@ static int get_amd_vsdb(struct amdgpu_dm_connector *aconnector,
 
 	vsdb_info->replay_mode = connector->display_info.amd_vsdb.replay_mode;
 	vsdb_info->amd_vsdb_version = connector->display_info.amd_vsdb.version;
+	vsdb_info->freesync_supported = connector->display_info.amd_vsdb.freesync_supported;
+	vsdb_info->min_refresh_rate_hz = connector->display_info.amd_vsdb.min_frame_rate;
+	vsdb_info->max_refresh_rate_hz = connector->display_info.amd_vsdb.max_frame_rate;
+	vsdb_info->freesync_mccs_vcp_code = connector->display_info.amd_vsdb.freesync_vcp_code;
 
 	return connector->display_info.amd_vsdb.version != 0;
 }
 
-static int parse_hdmi_amd_vsdb(struct amdgpu_dm_connector *aconnector,
-			       const struct edid *edid,
-			       struct amdgpu_hdmi_vsdb_info *vsdb_info)
-{
-	u8 *edid_ext = NULL;
-	int i;
-	bool valid_vsdb_found = false;
-
-	/*----- drm_find_cea_extension() -----*/
-	/* No EDID or EDID extensions */
-	if (edid == NULL || edid->extensions == 0)
-		return -ENODEV;
-
-	/* Find CEA extension */
-	for (i = 0; i < edid->extensions; i++) {
-		edid_ext = (uint8_t *)edid + EDID_LENGTH * (i + 1);
-		if (edid_ext[0] == CEA_EXT)
-			break;
-	}
-
-	if (i == edid->extensions)
-		return -ENODEV;
-
-	/*----- cea_db_offsets() -----*/
-	if (edid_ext[0] != CEA_EXT)
-		return -ENODEV;
-
-	valid_vsdb_found = parse_edid_cea(aconnector, edid_ext, EDID_LENGTH, vsdb_info);
-
-	return valid_vsdb_found ? i : -ENODEV;
-}
-
 /**
  * amdgpu_dm_update_freesync_caps - Update Freesync capabilities
  *
@@ -13947,8 +13785,8 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 		}
 
 	} else if (drm_edid && sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A) {
-		i = parse_hdmi_amd_vsdb(amdgpu_dm_connector, edid, &vsdb_info);
-		if (i >= 0) {
+		i = get_amd_vsdb(amdgpu_dm_connector, &vsdb_info);
+		if (i) {
 			amdgpu_dm_connector->vsdb_info = vsdb_info;
 			sink->edid_caps.freesync_vcp_code = vsdb_info.freesync_mccs_vcp_code;
 
@@ -13968,8 +13806,8 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 		as_type = dm_get_adaptive_sync_support_type(amdgpu_dm_connector->dc_link);
 
 	if (as_type == FREESYNC_TYPE_PCON_IN_WHITELIST) {
-		i = parse_hdmi_amd_vsdb(amdgpu_dm_connector, edid, &vsdb_info);
-		if (i >= 0) {
+		i = get_amd_vsdb(amdgpu_dm_connector, &vsdb_info);
+		if (i) {
 			amdgpu_dm_connector->vsdb_info = vsdb_info;
 			sink->edid_caps.freesync_vcp_code = vsdb_info.freesync_mccs_vcp_code;
 
-- 
2.34.1

