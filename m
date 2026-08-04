Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06DC2C55838
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 14:34:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82F6110EABF;
	Tue,  4 Aug 2026 14:34:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P7qG9ILE";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011058.outbound.protection.outlook.com [52.101.52.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C66810EAA8;
 Tue,  4 Aug 2026 14:34:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XuORXSmer/BqgXPeWMOEQb5NRr/L+tJDifh41rOEggTUwMaplgzwvOZety6c69yqfPDptRrFXRBSYasDCam1zLvhFvgn1L/LQyf0Rum2GmzJKHyUwe6wNu6cPMb8NqcgvVesPjRivz9Hxop5pnslYSBxqG9i/E4bGjBEOtbeiHnuaBs2a4yvvBjwXjfQCWGPHrecBo8zaPRMeq1kLkxdPOsQKlhYZhBAcXFgGbpN+0SyeB1yHsaVSbFKzfrIQuJHqbg/fZI6mm16hgOJSKH5I3YapYbqPXb2mlLiF7NkNiN+n3Hf2Xv88SiVOs2nlJSKv5YGRvhquWuBCuGTVr9qbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oUO8OwmgyXpWvA7QjDHXssixtjtHeZ0zMAYoMHWUN4A=;
 b=FCEDhtiUVYmXRj4J5GLiJavyXwuolLBsdZEOp+AiYHL10GJm79RvRcgwfer4TwZOUR/XpPkBEuonNmG02WDIWUdSKmOE5X4BuAa2vkuDstRSHwh+gf8ZUCo4iXMIFbuOo5VRPqYhv3JX6RqLP+WMNuWD1gUBmijp7H3IRp7tUHx9yhgOgsobzcEVJorB2oJuztCjfiHpVyuM4n7qmKiO9pQTGzF0lv3OJn7KpQwWKJ8Dfqfu3qAkKEeVR3fn0yCjU7IrFXR50Ez3gKo7V43kru0uvOIyBlP65vc3kuxkOAWYf6tLeai1Vshee8e3XwPgESGTSH+/EgFOxKSJOfBwNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oUO8OwmgyXpWvA7QjDHXssixtjtHeZ0zMAYoMHWUN4A=;
 b=P7qG9ILEdEmjCD65y4PjJBqyTnA3r7s6AX/dlR1L1M3LFGXIzMCWaZihJedF32UDZfd1lHXJrbaah2wVkIBOYsiY7psQqUj7ibGvHIFrh8mgD2rhWs6bXO07glFQCXtdhKGgy2eZoD+k0BW9m0sWKdiwyqN+fmOfi/ej0QEUzjk=
Received: from MW3PR06CA0023.namprd06.prod.outlook.com (2603:10b6:303:2a::28)
 by IA0PR12MB8373.namprd12.prod.outlook.com (2603:10b6:208:40d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 14:34:04 +0000
Received: from CO1PEPF000075F1.namprd03.prod.outlook.com
 (2603:10b6:303:2a:cafe::75) by MW3PR06CA0023.outlook.office365.com
 (2603:10b6:303:2a::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.16 via Frontend Transport; Tue, 4
 Aug 2026 14:34:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075F1.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 14:34:02 +0000
Received: from MKMALEXHUAN01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 4 Aug
 2026 09:34:00 -0500
From: Alex Huang <Alex.Huang2@amd.com>
To: <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <harry.wentland@amd.com>, <sunpeng.li@amd.com>, <siqueira@igalia.com>,
 <alexander.deucher@amd.com>, <christian.koenig@amd.com>, <alex.hung@amd.com>
CC: <superm1@kernel.org>, <dri-devel@lists.freedesktop.org>,
 <amd-gfx@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, Alex Huang
 <Alex.Huang2@amd.com>
Subject: [PATCH v3 4/4] drm/amd/display: Remove unused DMCU/DMUB EDID CEA
 parser
Date: Tue, 4 Aug 2026 10:33:39 -0400
Message-ID: <20260804143339.714548-5-Alex.Huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F1:EE_|IA0PR12MB8373:EE_
X-MS-Office365-Filtering-Correlation-Id: 00246030-8a17-42ac-0f0b-08def2356e21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|7416014|23010399003|10067099003|5023799004|11063799006|56012099006|3023799007|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: PR0YfnmUNW3fV31TkYirJs3oJt5RwzMQErz+4tk07wi41jk4aAM+NfextBxDDqNB4L7OcExyCbdiY4cfWyjBTuipAL+rLoECBz9hXVMkafMZXVWkVbm3mkX9s1hk2bm9swooK8NyqpR4v0MjKf3LkU5jog8AUS4PKqdw+jWeVL88h/nUvAwDHQiJAt40pPXCAhf2aTlZmTev0E6oq8n3kgOdr5wO8juYAUMwU5oo1qt+GKkyRFVFpRpOIllf3m4bCLwXPjRvayAjIeG0Glsxuo5L14W4UnrAMePNZqfijEPsmDS8KoWtUlce3yl98n3j5m5TPmPVj9VPj19qhJ6ghZnz65k3BXWuevNNfR19Zfm/es6BFYgz8Usm/nU+Qg5qkDICCEV7mdI9ig1rSJp1cTc6PspkE43c9E/8/YIXSCssCnzwepZqy/NVhW0nF6Ib4pRmYMrAJ32t0hTaJ2vUqmonHUnZqSe1pGpbuHKAhqwdsoXme4Xu2gQMOEw5lbp6dcE8owANzYfChd+okuy8dlyZMflw7rAeB51MPq1alVf4tI5uCVS/Y3U4YIOYg4UzUYkxcAK2oABnRs38r9C31S49kQXzb1dPxhRet/uHRr9DaJVQ5lW+jQ99fk89utGvRimT7tKsJSjinSPdxmVDDPppoaXYjj7aYIcV9XovbxHxQPsPgKhD2xRUHfOks7L3ThUUrcoBZ2otYOcjPo0dMyIfniuvRMzk5LZBsrvewW0HCT9tAONdIrKhphnyiJ+P
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(7416014)(23010399003)(10067099003)(5023799004)(11063799006)(56012099006)(3023799007)(18002099003)(22082099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: E10sMLo0ija/MstIleNt9kLhEgbPAfXHUaU9nFulKaLgmb1ezRvN5iQTFW8lRUeYB6F93eK7UKM02HK3Cimf4wBsTWc6HP6qvbQUVH9capvxSX+JfP3HWbPGfriqeOtzL7jz9rGCs/HK40udJ6mtk8k1Ui0C+/zQ54ae3XGS/9naRFh4Iujs3KKysHqDuSyAWhyAVumqVrM5Mz6PvW3xb3oTrd3MJbdqIndd2m9wa7AFO/gVEvsDBxYEWsS/pyqkYIXinDvG8Tyc2dn2k6MUo8UUJGKyar7Rsvkzbb6DGUqNVloJeJILm5RzuPPsB80tYW6VDijuaJ/ARtCo2hMis9p7nK0U3eqteZNdD/8kJ8kyDiNa0c/JBLvWokTL4mKMzPnq1zMtgyykFS5aFJ9P1knKt/3iWbpYcSERAtgDtDQW0qOFG0XsPGYaTDaTiB0Q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 14:34:02.6694 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00246030-8a17-42ac-0f0b-08def2356e21
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8373
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

With HDMI FreeSync detection now sourced from the common DRM EDID
parser, the DMUB parsing for AMD VSDB is no longer used.

Remove all relevant fields and files for this flow, it is no longer
necessary to ever take firmware round-trip for this.

Signed-off-by: Alex Huang <Alex.Huang2@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/Makefile       |   1 -
 .../gpu/drm/amd/display/dc/dc_edid_parser.c   |  80 ------------
 .../gpu/drm/amd/display/dc/dc_edid_parser.h   |  44 -------
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c | 121 ------------------
 drivers/gpu/drm/amd/display/dc/inc/hw/dmcu.h  |  10 --
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  71 ----------
 6 files changed, 327 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dc_edid_parser.c
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dc_edid_parser.h

diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/display/dc/Makefile
index 93d02956c5eb..e88a9cea8d88 100644
--- a/drivers/gpu/drm/amd/display/dc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/Makefile
@@ -63,7 +63,6 @@ include $(AMD_DC)
 
 FILES =
 FILES += dc_dmub_srv.o
-FILES += dc_edid_parser.o
 FILES += dc_fused_io.o
 FILES += dc_helper.o
 FILES += core/dc.o
diff --git a/drivers/gpu/drm/amd/display/dc/dc_edid_parser.c b/drivers/gpu/drm/amd/display/dc/dc_edid_parser.c
deleted file mode 100644
index 0db5b49e9d5e..000000000000
--- a/drivers/gpu/drm/amd/display/dc/dc_edid_parser.c
+++ /dev/null
@@ -1,80 +0,0 @@
-/*
- * Copyright 2021 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
- *
- * Authors: AMD
- *
- */
-
-#include "dce/dce_dmcu.h"
-#include "dc_edid_parser.h"
-
-bool dc_edid_parser_send_cea(struct dc *dc,
-		int offset,
-		int total_length,
-		uint8_t *data,
-		int length)
-{
-	struct dmcu *dmcu = dc->res_pool->dmcu;
-
-	if (dmcu &&
-	    dmcu->funcs->is_dmcu_initialized(dmcu) &&
-	    dmcu->funcs->send_edid_cea) {
-		return dmcu->funcs->send_edid_cea(dmcu,
-				offset,
-				total_length,
-				data,
-				length);
-	}
-
-	return false;
-}
-
-bool dc_edid_parser_recv_cea_ack(struct dc *dc, int *offset)
-{
-	struct dmcu *dmcu = dc->res_pool->dmcu;
-
-	if (dmcu &&
-	    dmcu->funcs->is_dmcu_initialized(dmcu) &&
-	    dmcu->funcs->recv_edid_cea_ack) {
-		return dmcu->funcs->recv_edid_cea_ack(dmcu, offset);
-	}
-
-	return false;
-}
-
-bool dc_edid_parser_recv_amd_vsdb(struct dc *dc,
-		int *version,
-		int *min_frame_rate,
-		int *max_frame_rate)
-{
-	struct dmcu *dmcu = dc->res_pool->dmcu;
-
-	if (dmcu &&
-	    dmcu->funcs->is_dmcu_initialized(dmcu) &&
-	    dmcu->funcs->recv_amd_vsdb) {
-		return dmcu->funcs->recv_amd_vsdb(dmcu,
-				version,
-				min_frame_rate,
-				max_frame_rate);
-	}
-
-	return false;
-}
diff --git a/drivers/gpu/drm/amd/display/dc/dc_edid_parser.h b/drivers/gpu/drm/amd/display/dc/dc_edid_parser.h
deleted file mode 100644
index da67ec06f0a2..000000000000
--- a/drivers/gpu/drm/amd/display/dc/dc_edid_parser.h
+++ /dev/null
@@ -1,44 +0,0 @@
-/*
- * Copyright 2021 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
- *
- * Authors: AMD
- *
- */
-
-#ifndef _DC_EDID_PARSER_H_
-#define _DC_EDID_PARSER_H_
-
-#include "core_types.h"
-
-bool dc_edid_parser_send_cea(struct dc *dc,
-		int offset,
-		int total_length,
-		uint8_t *data,
-		int length);
-
-bool dc_edid_parser_recv_cea_ack(struct dc *dc, int *offset);
-
-bool dc_edid_parser_recv_amd_vsdb(struct dc *dc,
-		int *version,
-		int *min_frame_rate,
-		int *max_frame_rate);
-
-#endif /* _DC_EDID_PARSER_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c b/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
index 25ebd8a52ae4..23de1c793ec3 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
@@ -56,9 +56,6 @@
 #define MCP_BL_SET_PWM_FRAC 0x6A  /* Enable or disable Fractional PWM */
 #define CRC_WIN_NOTIFY 0x92
 #define CRC_STOP_UPDATE 0x93
-#define MCP_SEND_EDID_CEA 0xA0
-#define EDID_CEA_CMD_ACK 1
-#define EDID_CEA_CMD_NACK 2
 #define MASTER_COMM_CNTL_REG__MASTER_COMM_INTERRUPT_MASK   0x00000001L
 
 // PSP FW version
@@ -812,121 +809,6 @@ static bool dcn20_unlock_phy(struct dmcu *dmcu)
 	return true;
 }
 
-static bool dcn10_send_edid_cea(struct dmcu *dmcu,
-		int offset,
-		int total_length,
-		uint8_t *data,
-		int length)
-{
-	struct dce_dmcu *dmcu_dce = TO_DCE_DMCU(dmcu);
-	uint32_t header, data1, data2;
-
-	/* If microcontroller is not running, do nothing */
-	if (dmcu->dmcu_state != DMCU_RUNNING)
-		return false;
-
-	if (length > 8 || length <= 0)
-		return false;
-
-	header = ((uint32_t)offset & 0xFFFF) << 16 | (total_length & 0xFFFF);
-	data1 = (((uint32_t)data[0]) << 24) | (((uint32_t)data[1]) << 16) |
-		(((uint32_t)data[2]) << 8) | ((uint32_t)data[3]);
-	data2 = (((uint32_t)data[4]) << 24) | (((uint32_t)data[5]) << 16) |
-		(((uint32_t)data[6]) << 8) | ((uint32_t)data[7]);
-
-	/* waitDMCUReadyForCmd */
-	REG_WAIT(MASTER_COMM_CNTL_REG, MASTER_COMM_INTERRUPT, 0, 1, 10000);
-
-	/* setDMCUParam_Cmd */
-	REG_UPDATE(MASTER_COMM_CMD_REG, MASTER_COMM_CMD_REG_BYTE0, MCP_SEND_EDID_CEA);
-
-	REG_WRITE(MASTER_COMM_DATA_REG1, header);
-	REG_WRITE(MASTER_COMM_DATA_REG2, data1);
-	REG_WRITE(MASTER_COMM_DATA_REG3, data2);
-
-	/* notifyDMCUMsg */
-	REG_UPDATE(MASTER_COMM_CNTL_REG, MASTER_COMM_INTERRUPT, 1);
-
-	/* waitDMCUReadyForCmd */
-	REG_WAIT(MASTER_COMM_CNTL_REG, MASTER_COMM_INTERRUPT, 0, 1, 10000);
-
-	return true;
-}
-
-static bool dcn10_get_scp_results(struct dmcu *dmcu,
-		uint32_t *cmd,
-		uint32_t *data1,
-		uint32_t *data2,
-		uint32_t *data3)
-{
-	struct dce_dmcu *dmcu_dce = TO_DCE_DMCU(dmcu);
-
-	/* If microcontroller is not running, do nothing */
-	if (dmcu->dmcu_state != DMCU_RUNNING)
-		return false;
-
-	*cmd = REG_READ(SLAVE_COMM_CMD_REG);
-	*data1 =  REG_READ(SLAVE_COMM_DATA_REG1);
-	*data2 =  REG_READ(SLAVE_COMM_DATA_REG2);
-	*data3 =  REG_READ(SLAVE_COMM_DATA_REG3);
-
-	/* clear SCP interrupt */
-	REG_UPDATE(SLAVE_COMM_CNTL_REG, SLAVE_COMM_INTERRUPT, 0);
-
-	return true;
-}
-
-static bool dcn10_recv_amd_vsdb(struct dmcu *dmcu,
-		int *version,
-		int *min_frame_rate,
-		int *max_frame_rate)
-{
-	uint32_t data[4];
-	int cmd, ack, len;
-
-	if (!dcn10_get_scp_results(dmcu, &data[0], &data[1], &data[2], &data[3]))
-		return false;
-
-	cmd = data[0] & 0x3FF;
-	len = (data[0] >> 10) & 0x3F;
-	ack = data[1];
-
-	if (cmd != MCP_SEND_EDID_CEA || ack != EDID_CEA_CMD_ACK || len != 12)
-		return false;
-
-	if ((data[2] & 0xFF)) {
-		*version = (data[2] >> 8) & 0xFF;
-		*min_frame_rate = (data[3] >> 16) & 0xFFFF;
-		*max_frame_rate = data[3] & 0xFFFF;
-		return true;
-	}
-
-	return false;
-}
-
-static bool dcn10_recv_edid_cea_ack(struct dmcu *dmcu, int *offset)
-{
-	uint32_t data[4];
-	int cmd, ack;
-
-	if (!dcn10_get_scp_results(dmcu,
-				&data[0], &data[1], &data[2], &data[3]))
-		return false;
-
-	cmd = data[0] & 0x3FF;
-	ack = data[1];
-
-	if (cmd != MCP_SEND_EDID_CEA)
-		return false;
-
-	if (ack == EDID_CEA_CMD_ACK)
-		return true;
-
-	*offset = data[2]; /* nack */
-	return false;
-}
-
-
 #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
 static void dcn10_forward_crc_window(struct dmcu *dmcu,
 					struct rect *rect,
@@ -1030,9 +912,6 @@ static const struct dmcu_funcs dcn10_funcs = {
 	.get_psr_state = dcn10_get_dmcu_psr_state,
 	.set_psr_wait_loop = dcn10_psr_wait_loop,
 	.get_psr_wait_loop = dcn10_get_psr_wait_loop,
-	.send_edid_cea = dcn10_send_edid_cea,
-	.recv_amd_vsdb = dcn10_recv_amd_vsdb,
-	.recv_edid_cea_ack = dcn10_recv_edid_cea_ack,
 #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
 	.forward_crc_window = dcn10_forward_crc_window,
 	.stop_crc_win_update = dcn10_stop_crc_win_update,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dmcu.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dmcu.h
index de3113ecbc77..eebfd177463d 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dmcu.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dmcu.h
@@ -74,16 +74,6 @@ struct dmcu_funcs {
 	bool (*is_dmcu_initialized)(struct dmcu *dmcu);
 	bool (*lock_phy)(struct dmcu *dmcu);
 	bool (*unlock_phy)(struct dmcu *dmcu);
-	bool (*send_edid_cea)(struct dmcu *dmcu,
-			int offset,
-			int total_length,
-			uint8_t *data,
-			int length);
-	bool (*recv_amd_vsdb)(struct dmcu *dmcu,
-			int *version,
-			int *min_frame_rate,
-			int *max_frame_rate);
-	bool (*recv_edid_cea_ack)(struct dmcu *dmcu, int *offset);
 #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
 	void (*forward_crc_window)(struct dmcu *dmcu,
 			struct rect *rect,
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 6f6a59a23495..ffe8192d223b 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -1891,10 +1891,6 @@ enum dmub_cmd_type {
 	 * Command type used for interfacing with DPIA.
 	 */
 	DMUB_CMD__DPIA = 77,
-	/**
-	 * Command type used for EDID CEA parsing
-	 */
-	DMUB_CMD__EDID_CEA = 79,
 	/**
 	 * Command type used for getting usbc cable ID
 	 */
@@ -6732,69 +6728,6 @@ struct dmub_rb_cmd_transmitter_set_phy_fsm {
 	struct dmub_rb_cmd_transmitter_set_phy_fsm_data data; /**< payload */
 };
 
-/**
- * Maximum number of bytes a chunk sent to DMUB for parsing
- */
-#define DMUB_EDID_CEA_DATA_CHUNK_BYTES 8
-
-/**
- *  Represent a chunk of CEA blocks sent to DMUB for parsing
- */
-struct dmub_cmd_send_edid_cea {
-	uint16_t offset;	/**< offset into the CEA block */
-	uint8_t length;	/**< number of bytes in payload to copy as part of CEA block */
-	uint16_t cea_total_length;  /**< total length of the CEA block */
-	uint8_t payload[DMUB_EDID_CEA_DATA_CHUNK_BYTES]; /**< data chunk of the CEA block */
-	uint8_t pad[3]; /**< padding and for future expansion */
-};
-
-/**
- * Result of VSDB parsing from CEA block
- */
-struct dmub_cmd_edid_cea_amd_vsdb {
-	uint8_t vsdb_found;		/**< 1 if parsing has found valid AMD VSDB */
-	uint8_t freesync_supported;	/**< 1 if Freesync is supported */
-	uint16_t amd_vsdb_version;	/**< AMD VSDB version */
-	uint16_t min_frame_rate;	/**< Maximum frame rate */
-	uint16_t max_frame_rate;	/**< Minimum frame rate */
-	uint8_t freesync_mccs_vcp_code; /**< Freesync MCCS VCP code */
-};
-
-/**
- * Result of sending a CEA chunk
- */
-struct dmub_cmd_edid_cea_ack {
-	uint16_t offset;	/**< offset of the chunk into the CEA block */
-	uint8_t success;	/**< 1 if this sending of chunk succeeded */
-	uint8_t pad;		/**< padding and for future expansion */
-};
-
-/**
- * Specify whether the result is an ACK/NACK or the parsing has finished
- */
-enum dmub_cmd_edid_cea_reply_type {
-	DMUB_CMD__EDID_CEA_AMD_VSDB	= 1, /**< VSDB parsing has finished */
-	DMUB_CMD__EDID_CEA_ACK		= 2, /**< acknowledges the CEA sending is OK or failing */
-};
-
-/**
- * Definition of a DMUB_CMD__EDID_CEA command.
- */
-struct dmub_rb_cmd_edid_cea {
-	struct dmub_cmd_header header;	/**< Command header */
-	union dmub_cmd_edid_cea_data {
-		struct dmub_cmd_send_edid_cea input; /**< input to send CEA chunks */
-		struct dmub_cmd_edid_cea_output { /**< output with results */
-			uint8_t type;	/**< dmub_cmd_edid_cea_reply_type */
-			union {
-				struct dmub_cmd_edid_cea_amd_vsdb amd_vsdb;
-				struct dmub_cmd_edid_cea_ack ack;
-			};
-		} output;	/**< output to retrieve ACK/NACK or VSDB parsing results */
-	} data;	/**< Command data */
-
-};
-
 /**
  * struct dmub_cmd_cable_id_input - Defines the input of DMUB_CMD_GET_USBC_CABLE_ID command.
  */
@@ -7588,10 +7521,6 @@ union dmub_rb_cmd {
 	 * Definition of a DMUB_CMD__DPIA_SET_TPS_NOTIFICATION command.
 	 */
 	struct dmub_rb_cmd_set_tps_notification set_tps_notification;
-	/**
-	 * Definition of a DMUB_CMD__EDID_CEA command.
-	 */
-	struct dmub_rb_cmd_edid_cea edid_cea;
 	/**
 	 * Definition of a DMUB_CMD_GET_USBC_CABLE_ID command.
 	 */
-- 
2.34.1

