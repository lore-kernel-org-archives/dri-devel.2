Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88635C53200
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 16:18:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7E7310F436;
	Fri, 24 Jul 2026 16:18:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LNS9pHME";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011008.outbound.protection.outlook.com [52.101.62.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CC2910F435;
 Fri, 24 Jul 2026 16:18:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QOAAK6ZlYq5yfjxlEFJxeb5U7iYmq+0RiRi202JQMKNx3j+pA2G2uPLLogrnjsTiae2jxqZghbxKm5fSqskvGXpYh9X6BNFuBYBBSWwOSR4iPNAIyLnKYio6tmPOkl4XLXWH7nIdtpgrrQkzVO4fF5ayo+dXZaVQmBIG4K0ETfvkz6JL1+kZug2uVRujSBSqbLh3ZcPhb7ZzmH4xhHlJ8UuOnv7CEGPUcZCmeCObgL2St6RoaINIaUYNJk13rhOce7ouO0D5jGhmu6DXkum4CcXI9WJr3As2/iksb7hw3cfXrOas3rug1cxUsXovJ4Dx4TKqKFYGeDaLpggeF0sCmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AtnpzdFXhTH80rScA0PHwOBiwDG9ECV9Qag+1EtKUVI=;
 b=khmxLGIj/TmUqVMOiJFwMQgOp/Ili0H1MKI2T7SEr5xOEyMFgx96KX2O+yRwh4heYxxp3OaMbB2vzhbN1IbJc/xShGajLVCORc5kruDPWgub3Kl374/gfQES3NSWCBPElursFy4tuZqTc7mJrLv6X9IBVJ+piRbrPRA6W6deh3FIR6o0cxOp6t2ZtqLZ2Iv5Gs7ztUE1n3Z+CdlEEzPTrczm7BGmSofBibnaXCAzZoU3cBmY0UcRCFJyxZ/1VP6v5pwTxH22oB73TNQzpGa/987oY45mMTWFz2D6HaXZZIlSgfrv0iooC/etQRs3Js2qCgfQNP7t6do24LiBWvF+PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AtnpzdFXhTH80rScA0PHwOBiwDG9ECV9Qag+1EtKUVI=;
 b=LNS9pHMEK6SuJRSZzlg1Y/FepfUSUNNdEQkPe+BZgm5ealYWnxnrkIpLPwOVA+u17HF1NHV/Xd6OWq9e3o8d1iGiPke0WB3T9IQi94qG2n5sIoCydGjeNdgRfo8o0CfZ38G8YkC9qr+JKPPBf5+8uG7v6qx6d7qzILWsDogGstg=
Received: from SA9PR13CA0001.namprd13.prod.outlook.com (2603:10b6:806:21::6)
 by PH0PR12MB7888.namprd12.prod.outlook.com (2603:10b6:510:28b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 16:18:01 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:806:21:cafe::7d) by SA9PR13CA0001.outlook.office365.com
 (2603:10b6:806:21::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.5 via Frontend Transport; Fri, 24
 Jul 2026 16:18:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Fri, 24 Jul 2026 16:18:00 +0000
Received: from MKMALEXHUAN01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 24 Jul
 2026 11:17:59 -0500
From: Alex Huang <Alex.Huang2@amd.com>
To: <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <harry.wentland@amd.com>, <sunpeng.li@amd.com>, <siqueira@igalia.com>,
 <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <superm1@kernel.org>, <alex.hung@amd.com>
CC: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, Alex Huang <Alex.Huang2@amd.com>
Subject: [PATCH v2 4/4] drm/amd/display: Remove unused DMCU/DMUB EDID CEA
 parser
Date: Fri, 24 Jul 2026 12:17:13 -0400
Message-ID: <20260724161713.119382-5-Alex.Huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|PH0PR12MB7888:EE_
X-MS-Office365-Filtering-Correlation-Id: 19edf8df-f55f-45d4-1161-08dee99f21d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|1800799024|376014|7416014|921020|10067099003|5023799004|11063799006|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: cdga18yA3gABXe+jJLenWo4XfnvpVZpZlpA2Bd1LiDGYmR9Wycm4mZueolfbdYCdeY1nVetkbLWDYlOC95DxH9ZY1dvT68Vl6dm3vKSQirXQ6lweRFTn1/vtfTlozUz8V+3Xs/mSwOGMCWEanxT4GtGq5G3ZVdV28AAUH04qD4F/Klniz7J+0KvtRTn3jjWijogkX3upHPG7rT8i/jgmLt+Iop/EkOeh4TD2aMn05DDPnmoMfYC3+jgEBHuJjSeI6oI7YItt27HDOVAyzCW5MlLohemEG9NvvwJV97/OaihQkf2GfZUR6+sBxspw00lzxLQY/YBuOU4obZzs2cqpJOfzKNKj1k9K9EAGO9uZUhgeosNhGRiBZ11c7VJckN+eR7FGKj6J4KyKJhFA8LgsI9/+IW7a3q1nDVm3SYrj5jfdIcETQ6R2sQ088pUwj941cHUc9PlK3QZIKCrUQ69d9pgood491z00Epy2t4SEVYIEYrZIO+zH8aKaJll4q74T2vyPw+ohZWEqt39BGPDuqiFR9INiqykg4qoatKIqD78JfTeRLgRpDV7rg0GafWFhSn5EY5WkmIdfkUhrg/T5nCHq7KLzosLAViO/UjCHf+b6jwms5cUqzQAgP8EJ7N6CWXf4oZmMWt50VdUdN41ZKOPOHWDCY2y4euSomCqYwAiHrKgjP1oStnycquZK/iexQl4M+SwFBPUgIB3/AWzOpF/2dweSpoX2U+e/LH54cpovK7GkmvOtjFYJ5wk9m7oE
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(376014)(7416014)(921020)(10067099003)(5023799004)(11063799006)(56012099006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fL4TkNkl5LdxyHvNcsgx3heB9itmlkKTT/IrgH3k/bzTb1x+XXEZRfyJJVZdUMejZqgZPMqd5or3djQtbDdeitg8PFMrOi2mjpKLLtXvzmnboZYEnPeQ6uVDq4oSA+H+Bzhqa3fMXttFYC7ZXVmVOFhKUk31keb8tjp0R4WD4gpcdvlc1vmpbTTSqWamc2KPVV1sljWUEVuXFtuKmpOU9ocOWRqjoi54MnCTaNSCHCeVpdCGeULAGpFuLLVhEhaK7unecFdvkRHBYzFfZjtLwZoBSkcgapGv6M1hj8+oeZPyiH86x287mOTMW8S+zhWH8cmQD0alxP0iwRakwEGmTWWZ2TO46wqK4wr/XcCJfVaOx9pwFg9+AZcXFXyJotIOhbko4qseEGQDiqMc4Fbzwp7dLCe9+dybpManthUtOMgGe6RELQRl+NQ1cBA6t1NZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 16:18:00.9396 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19edf8df-f55f-45d4-1161-08dee99f21d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7888
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

