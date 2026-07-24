Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C64CC53215
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 16:18:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C238110F43F;
	Fri, 24 Jul 2026 16:18:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="klE9K1BR";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010042.outbound.protection.outlook.com [52.101.61.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 580A510F43E;
 Fri, 24 Jul 2026 16:18:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tJOWg99AujY4uafLFio3iiysMw7pdd7JiJaj2ic1o+/0sAODnny/vU056WL0quBESIRx9+ZhM+S+fjE6CIJNcxaB4qjeR7bqIp2SUbdbNNjIqpwnFrPNiYdW8DR+1JwOVV2lXg9YmwiZtmqsSUqz98gaBIPjPfSMvHiQJd1UQ5G6+nsSfuhFaixZvfPRNB8IQrV8umTUxB6oU2e+cB6s22LB9zTFGylSfGjrSokhdFZ8rv8UFyV7Bq3BuEewlgG/5GBcQMYUNq5gwiw/GWViUJBTk404hlcmL7l4bJFhzX/EgT6LNu63cZ8WgPCwy9J+cSAutpSrNWeV8dHS1F7e9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fOkrdwfAxpUds4dhmlOglxRoPmYwAavJG+Kb5a6ABmg=;
 b=Rz17V1+aGFZTF4qyVivORNEZz4RNG/mIo5sgXA7GVBuZ2nnAp/iuW4W9UIzSuYwD7K7b9RACZRuujS62G872l/aGwDTewDFpbxIph3CElEgmMDsKmDRRonBAZEyFWgKtXcg3MrA4oCTmlhLEucPhp3WKkCiC+KBR7JAowElRAXYY3eITarbIeK0FC2cWFw1PdMpF6DYcU+5LUQBZh5zEsv0FUT23GEydKox6u85A8Zk9UBPSGNS65GwJRUL3kfGp0z1i1fvoZT2UE8RlEPvv6ns6zzsyXSTOE4CUq4e2CzhtAx5s8W6FDZb3brqdp8x2qysVgRsS+hgg5Da8mdlsSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOkrdwfAxpUds4dhmlOglxRoPmYwAavJG+Kb5a6ABmg=;
 b=klE9K1BRkWLnMmqq9A5ARVdD3v6/fsikOZFOFBLKx+xkzmBn8nNreLU3K114+uN5RsO8u8Eq6Y3Ak5j2/Ekgv8nSI29kaMyG8oeyWQGoRiDFuU6LSF4nOYdJxoEwZz7mECz+dzEZMbe3kReRP1jTdx9CwZ0CdGbKtbebokXx6Jc=
Received: from SN7PR04CA0031.namprd04.prod.outlook.com (2603:10b6:806:120::6)
 by IA1PR12MB6018.namprd12.prod.outlook.com (2603:10b6:208:3d6::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Fri, 24 Jul
 2026 16:17:58 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:806:120:cafe::29) by SN7PR04CA0031.outlook.office365.com
 (2603:10b6:806:120::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.12 via Frontend Transport; Fri,
 24 Jul 2026 16:17:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Fri, 24 Jul 2026 16:17:56 +0000
Received: from MKMALEXHUAN01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 24 Jul
 2026 11:17:54 -0500
From: Alex Huang <Alex.Huang2@amd.com>
To: <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <harry.wentland@amd.com>, <sunpeng.li@amd.com>, <siqueira@igalia.com>,
 <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <superm1@kernel.org>, <alex.hung@amd.com>
CC: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, Alex Huang <Alex.Huang2@amd.com>
Subject: [PATCH v2 2/4] drm/amd/display: Use HDMI FreeSync range from common
 EDID parser
Date: Fri, 24 Jul 2026 12:17:11 -0400
Message-ID: <20260724161713.119382-3-Alex.Huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|IA1PR12MB6018:EE_
X-MS-Office365-Filtering-Correlation-Id: 5894a264-b468-40f6-2d5d-08dee99f1f63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|7416014|921020|6133799003|18002099003|22082099003|3023799007|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: zCIVAf74m9YhX0iEEv4LZ9yQgWeDbDxUENe4vJ0XMyFIounOya7yZex68CqNqxjQRv0sI7b9sChcL9i6OBWx547i299DUpY0OjtPyxv0R4ndh06kOOLIKkyx2qjb+MqPjrytB1DoNSV4/VqQ+DBnQ25sbmFll1/TzzOj3fLkqXeiX5SlNEuT6YU58fC9Qyra0GGT/pCR/Hh2Q88nPl9XLKzBKPzy6z6FaEbb6qtgytwcr6rhbwcGVlM17bMAG+AquYN2nGRpsUgYyq2/yx4jL5F3pUgOTT/ASqNba3ncGh1tiAqsjDW+sLMk/e5fcFCC/ESQzsUqETez9cfpgJOypRnH8ax9WPXsvoMB5lQD7Eg45XiRYgmJFET0dTgAJPtV/Qvzj/5T4cpOoaw7yE+eXoQJprRuTa4GZQvjVi/9XihUj1d03qW2GObDK+jwAzuXgStVrGTkdnZE10UgazK7mqNZepHIWDt66Cqupao5sVledoNCs3Z7uwXkv7FZC52ffuYl+MPqBR1dvdCm7SDJsax7D2BThJmP7XTIooqTTQ/TiQNZ4AiyNsEmmEIcraM2nFct28GK5WEbk0rODXjvdBvjRBd/W31rDnDndJkjcgK3ck/UtW+WJy5MnfeLTaRfku9qiQeVvFcvQpFhhG08cbZ1ZmEXqvvXQUm2oPA1TPmtE/kdBL6RS96GdjMMPKxQggd29ijkSCBOTxxgqndDNxqW9kHzDuBvP32sJLhCX4ILThUpBO2NMIauRY4/yQGB
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(7416014)(921020)(6133799003)(18002099003)(22082099003)(3023799007)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MEuruwC7EN/MYbqYo+32SQQdFG93HVedd14xTIPfX82WHC/RyxDN0gIANmHFg4FaBW4gHaDzkgqvMYVxWihlsb9khEufQI++YfF9ZdP9gvD5RP+yMi2WZZoHviUVfXUIMu4S+ZeV7cisTHQUpcCKPv8EIMNCLRqCByJZF6LG+xq0NUoRm6t6jgOWQJ9mJ4C9zrL9GcQNUJMMqCPe1t8e3ewwDxI6sw4zYHOikX+Z56+1ZMrf7i0li76m7dMs5gVJMejjE+KYkXO0m7KYBLn+wq/H6xMbkKwC/s7gVnik+pSWOBKWJsCbTrCJmqerEWAVZcwHkiY46RnKebxY1cuLZEjeVtoFhl9xNs6t0FlNBRMSJDdZjbz3KkLGbw1BO+WOJBp9MM/jT2aJ3dfO/yaYjbTmN3vbxeZvVeE+1/n+ebPWE9eZrKvUNy1Sa8+8MpJb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 16:17:56.8226 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5894a264-b468-40f6-2d5d-08dee99f1f63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6018
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

