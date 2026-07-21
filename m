Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40750C44532
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 16:46:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71C5910E70E;
	Tue, 21 Jul 2026 16:46:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nLy8fE/G";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010056.outbound.protection.outlook.com [52.101.56.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 086D610E5CD;
 Tue, 21 Jul 2026 16:46:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CHbz4Dz9OkH321KSJhgCiTUnG4Wg58KIocYBnCnN2WoxLwam3qV+FQC5qY9jTMaWQrsKxRrBlblA+cJw7RwIjyflSrsIjHTwS2TfA1iioqvsgV0TJYs0Nb/0qdmoJ2PRyrJa10pIvWA/XA95fttgqQUPF2/Vu7n6vg8MWFy7edXYIUwlo/aNsn2KDTJLBaWEhT/B/Pmr+DDpMNHLwwpg7npz66oMRxTWGafdxnJyhauj5DGOod8J4s7XPFzYJL4YeFmm0WZhEh1HPQZ4b1Cwe0wzsQziVatqgYxk/pUTnDpdnqdav5SEEGuyGzwKTNFsTdjuzb1bOVIHMegIqnVV+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fOkrdwfAxpUds4dhmlOglxRoPmYwAavJG+Kb5a6ABmg=;
 b=O6zqhmHxKLBXLLDSIwgs4TY6ItKBAkqtHw5ShZxwSCDEZD31RDsRAGTru72V/JilL3MuQWzV8beLgTEptn+Vz5osm5gL6lLGyBhZsFcr8VsWCj5Zg37pLCTJFpOCfKp/RUlfu5PPsx6nPVJi5zgH04+bbk1sEiwqUVJL/fULpXPHCvDPBxoQ8XZHWSrPmXQxnQK6mYHoqpMDAE2gGCsnPO7IbwO2V+8V82CUdiFlnd1sk8hdDFi+HGuXSk3tlJ5FysI5ZI1CRd9HnHsQySJMg+zTOSr2QSE0LqzY5mS19AhMmJRQ8jOBoXTZjtuOqALtHE4tmMv+V954OoCDGkcH/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOkrdwfAxpUds4dhmlOglxRoPmYwAavJG+Kb5a6ABmg=;
 b=nLy8fE/Go48BnzawiNbbz9RLCLEjwb44gBHD1xaGAy1J5lK01ebO4boLazS8FMlKaZuJws5qyaMqpWBlFiqJlmmvy32YO3DdwzsUF5KuDT5WStL5Jma5Dvj7L/wTkWkzZwsWiWEQmgyjmAfG7PhVnmRs7e74YpGDyYovoE5xlGs=
Received: from BN9PR03CA0072.namprd03.prod.outlook.com (2603:10b6:408:fc::17)
 by DS0PR12MB9040.namprd12.prod.outlook.com (2603:10b6:8:f5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 16:46:24 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:408:fc:cafe::70) by BN9PR03CA0072.outlook.office365.com
 (2603:10b6:408:fc::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.18 via Frontend Transport; Tue,
 21 Jul 2026 16:46:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 16:46:23 +0000
Received: from MKMALEXHUAN01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 21 Jul
 2026 11:46:09 -0500
From: Alex Huang <Alex.Huang2@amd.com>
To: <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <harry.wentland@amd.com>, <sunpeng.li@amd.com>, <siqueira@igalia.com>,
 <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <superm1@kernel.org>, <alex.hung@amd.com>
CC: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, Alex Huang <Alex.Huang2@amd.com>
Subject: [PATCH 2/4] drm/amd/display: Use HDMI FreeSync range from common EDID
 parser
Date: Tue, 21 Jul 2026 12:44:28 -0400
Message-ID: <20260721164430.2121326-3-Alex.Huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|DS0PR12MB9040:EE_
X-MS-Office365-Filtering-Correlation-Id: 52240f4a-b086-4898-92b7-08dee7479963
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|7416014|22082099003|18002099003|11063799006|3023799007|10067099003|56012099006|921020|6133799003;
X-Microsoft-Antispam-Message-Info: GqslBFOYRas+K2qLs/ng3yvjE+Wj7e+fdB4YMzggm6drhDNOi3OdzMTH1FDktCRJ1+55FtzzTZsvp4ZaiaGLgnJqR+9q2OoAadhCNLFl8UCCNcGPz0n4cUZc3ZB5gJKwU5XxNMhkOdvuujvYDs6Z0PrOc6o071gEHH6SI9n0INFwvEPUI/alpRPHlYaImhU8EUPxfbxZxctrv8NVi9olo+r0biapbDFzA9EB7wRt8GQooPhddJbNJHp+5HKKwExUpEH/pwnoluJyd0rNVZ1qW+FwDX/ki0KrQuXhYvCSfuNOfjXOnPnWJUp0XRoHybDi18FfjJdCEYneTQLJ5hdsS++jui281iOSzf5NnUU2jtrwymhdUQ88vqbZy+c5WE5XPRQjDvrO/hKK+bfQcQz84iAHT+mRMafQg4vYAG21CZT2NTGe/Q0+es4oTyI8o3d+Aviec0GAHl++Q4PRALdhOAUji0zVAk8VFMiHk6ZNT599zLmWsT/QbDp8E7JqxRiV9A3ePaZzEZv5mvy8S4xg7zrG7QsGzV/n/KeESGhTDpgRa76xRIsA6M3skRTuRMRtJolAOuo0hvMseJriXsK+qS326lehKJn9h4cmgFYJMuMriX9BQQ2d8bGp161H+Xl18wVMLFtSXNg8kC0P3xXisy2dD2cJF2XQKw+RzOIaHDit0sTeR7JkxHQMOyqmShEwtd0CgOdX/2DTr+rQzQQJnI1EIebm5TUafv8Kfvt/7wC90VJ4kixyirNdS4Vdg+RY
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(7416014)(22082099003)(18002099003)(11063799006)(3023799007)(10067099003)(56012099006)(921020)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CQyYeuqXXHBx0E9HMamCtGNrhwNNOdRMHONsZGUM1shcKFSAJerZ5RdXCdVXnEXbrE61TakVaDiAodwFqb+4NFn6pqubrTJqJsvCcezMHeBJbFr0zKtoWaBkycpn+BHgmhxs9XI0QD10hk1eRQukqb4BawMG4Mcjb+cKgrwDAr2F7W0Z2PMDGCkLKmL/gTgkcC2tenGIsBBbCAb7CDyGuw2JqGZk/h+OOesfrR0F2MxBuRY6t28ZvKL9DVxeVR9OPWE/PDVXl54T25UuBJJn2mmeKWZSxwY0n0J92q+5O4BBfPwL5kXtMpvOuSXtoDZmgA95iriDiO8pasmkyfpJyO0ZgwwSd5LOp/7u9ZYPu5BFtFpGOqZmYU4lmF3RvXAfgO+3J0ZmfUSf3dqGk1xkqIqffkORp4qIuPTsye7ig9IDyi1gN8NC/77RkOdAlye/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 16:46:23.4882 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52240f4a-b086-4898-92b7-08dee7479963
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9040
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
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 178 +-----------------
 1 file changed, 8 insertions(+), 170 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 9c564cd5edee..fd9bb205c8f0 100644
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
@@ -13632,139 +13631,6 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
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
@@ -13815,42 +13681,14 @@ static int get_amd_vsdb(struct amdgpu_dm_connector *aconnector,
 
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
@@ -13932,8 +13770,8 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 		}
 
 	} else if (drm_edid && sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A) {
-		i = parse_hdmi_amd_vsdb(amdgpu_dm_connector, edid, &vsdb_info);
-		if (i >= 0) {
+		i = get_amd_vsdb(amdgpu_dm_connector, &vsdb_info);
+		if (i) {
 			amdgpu_dm_connector->vsdb_info = vsdb_info;
 			sink->edid_caps.freesync_vcp_code = vsdb_info.freesync_mccs_vcp_code;
 
@@ -13953,8 +13791,8 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
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

