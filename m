Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C44CA600C
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 03:24:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F97710E66E;
	Thu,  8 Oct 2026 03:24:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="doLQudew";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010051.outbound.protection.outlook.com [52.101.201.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF50310E66E
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 03:24:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V97W6g4S7V2NC2nexe8FVSA//MGwbcdfbwyeLzfMAhbeMY8sivPJuJIpZg1BMx1WeWNtiPvjoSFzHjyOi/pAZLSm85sWH4BnbGkiGtumsQQn6in1uGtq1R68kT9PqKLczjotznMtD4eAFjRmwyChBoRLhK/i2YlVeh68U/OttAN6tQToKTOxAA3ZuQZ74TaDbVfgqQo3GR/0U4ombQrAkXOd08mg2ItH2RnL38kPDbmtRWEEGz0WjfC+mfdmoz9uiX7aVE62nH+FlINBkUo7/c0+9Oqtx5kKcnJ9DhdgaRJteaaa9cS5wNl8wxLqwkEPq5/Y62ciH0m7p0ykVCJjhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8c/cH9MJoOudEzLhll7Kpk7OUr2RsY4BeLqMXxAxcAY=;
 b=i3SBqyU3bsleRvPPNXtoK1DnS4ENUtyQFsvl6+V8Sdilu5mswdegmeJudhYi7F+cBeO926EwZgE02Dj5fY1Vwvgp9VzMIi/qcYnPe5wTwallPQ3KJyE+8GqSs9E8XGFaLkcW4ep2UZN0SSWO5DglWH2WqxHitzGDkUoWjbImOO7dVKRD7nzn295hMRlWaCrWmo7xjaWjRu06KC4REDlQvFljzWQjH9R0idCRSoZugUH4WrB3LEBMn5+fzJq0WBbeI4Ejd1a74wRLmQoHZ7nDK95w+NXeGxMA47TSne8Xz24tGwiKxX1E7ooB5LSoUuSbeAokUvTbb+aGePbioQlsnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8c/cH9MJoOudEzLhll7Kpk7OUr2RsY4BeLqMXxAxcAY=;
 b=doLQudew1B2WTMX9vvP32hjCdnGKNbWDqynNGaXceHZddEWmwAiHDIcmX6dvWAUnjXBzl6d2fzJqpqvwIlfLUaZ5o+RPjGWdRFdCLFGklYYCBvtz+/Io8nheYx2EESFCvfJki0OGFCtTIvfgQ0Gd4JAOhXhFy/hO2NiFBjphdv8=
Received: from SJ0PR05CA0206.namprd05.prod.outlook.com (2603:10b6:a03:330::31)
 by PH7PR12MB5733.namprd12.prod.outlook.com (2603:10b6:510:1e0::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Thu, 8 Oct
 2026 03:24:00 +0000
Received: from SJ1PEPF000037AE.namprd03.prod.outlook.com
 (2603:10b6:a03:330:cafe::37) by SJ0PR05CA0206.outlook.office365.com
 (2603:10b6:a03:330::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Thu, 8
 Oct 2026 03:24:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037AE.mail.protection.outlook.com (10.167.244.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Thu, 8 Oct 2026 03:24:00 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 22:23:58 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 22:23:58 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Wed, 7 Oct 2026 22:23:57 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>
Subject: [PATCH V3 04/19] accel/amdxdna: Upgrade firmware version to 6.0
Date: Wed, 7 Oct 2026 20:23:33 -0700
Message-ID: <20261008032348.2044667-5-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261008032348.2044667-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20261008032348.2044667-1-yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AE:EE_|PH7PR12MB5733:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d04088e-8796-4087-9838-08df24eb986d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|10067099003|56012099006|11063799006|3023799007|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: KByASAosIlTqs0yjyYVhgqgcGaKEofp8fwbFxe9yg37IgMYaoc3kWIgyOPy1RsafEFPWkwxfvEDwAqW44V/lTK9VaG1TNxwYahTbYp83AKRtmfHknsLiNo4aThwX1ssCZDHykhL+ZcAtXIPGGriXakOv+pA/gZq8sJjkmKaP+yaezElWfb5uzqpHObDZvofdTdBsYHc3q8+8gX74QuLrdMGtt1OipZgOc9tz7eGCejXcoNDsNFetc/PkoT2N3Z5FUe8TmExSWmb3GTNnK0KOS4JMP8w8GgSp914t+2zAqqaruD9LCTwckaz4yI5PBBy6Fpw7tnvd74AxTeYjEyR/1ui3QmVSXsm370RtBh5/LvtA8sCAHyWdGn5KvIziAKf7YqbRZ/dUSibdap4TagNWjrcMoJD2+bTCA3BUtluU/Z7I3nw8VoFkOnuxoyoR2ocr53ul6FnMDK22yynu/giPvnIivpDNlI67Z3r32nU35aro75z20Vh809Xbrncj7edEqj0vfZ0v6A+W+bqfy4HISLL5Pwenc+ZTIv1Ykhg786LFPb5i8nJeYqKd29xKrdX8tIlyy9RrnEEEmACZMcUG/KMPzlvoCpQgT+jqDlBqZmsn4TefCwEjhB+mb4oyPHROtB50Vd27OjmGXK1DAV5vH7VcaBvz1lumyU5LreR6e2WJ5If2jyin5hZArMS5OhZ1SFTHN8X03OP2fv+XSkRxmw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(10067099003)(56012099006)(11063799006)(3023799007)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: seSSS+lcOm07djOMdEdqm7G6BZ5o/grHHCldLuIVrxUUXhhfWaQt2PBhSLZrhb3hIGvykRm85fBIM7oK9a2Jwo9rNrIffwPUf7WfY80PYFNFUsqwuK1OFZ6O7ErDYQ2GYB+ePsCmPYwKOLg6A0QAn5c8I1kCMsE60c3MEkDUoImphAMMZpvjxl8epHMNuNPF8o2ZeOAjRW8WgH8kaxpEGigw2qME46/VIAGkizZdkhfc3vLPIG++pkL8vglai4yd2VHcQ7vYteKFZjZfzdTpWMkg3CplDcWBRawcO/cbdznMr6tBlYm/JUhNRhs6Xr+3igA1jqB3z1MlbE0VzvRtTiaqYHPkZMTXi77MqQ727EBR0py7QX+Hy3IV9sa0dA1tvThWOF1esrLT+u2A/t9xRMSJRC70XGurG2RJDZWseFOULOwyMbzPSg0CfirmFvNG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 03:24:00.1877 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d04088e-8796-4087-9838-08df24eb986d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5733
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

Upgrade firmware interface version to 6.0. Update host queue layout,
opcode definitions, and context creation/destruction request structures.
Parse priority band and PASID for hardware context creation. Protocol
compatibility for this queue layout is validated against the CERT
firmware protocol version.

Signed-off-by: David Zhang <yidong.zhang@amd.com>
---
 drivers/accel/amdxdna/aie4_ctx.c        | 23 ++++++++++++++++++++---
 drivers/accel/amdxdna/aie4_host_queue.h |  7 +++++--
 drivers/accel/amdxdna/aie4_message.c    | 11 +++++++++++
 drivers/accel/amdxdna/aie4_msg_priv.h   | 20 +++++++++++++++++---
 drivers/accel/amdxdna/aie4_pci.h        |  1 +
 drivers/accel/amdxdna/npu3_regs.c       |  2 +-
 6 files changed, 55 insertions(+), 9 deletions(-)

diff --git a/drivers/accel/amdxdna/aie4_ctx.c b/drivers/accel/amdxdna/aie4_ctx.c
index 8157f2a6fd10..5eb918e1d58c 100644
--- a/drivers/accel/amdxdna/aie4_ctx.c
+++ b/drivers/accel/amdxdna/aie4_ctx.c
@@ -9,6 +9,7 @@
 #include <drm/drm_gem_shmem_helper.h>
 #include <drm/drm_print.h>
 #include <drm/gpu_scheduler.h>
+#include <linux/iommu.h>
 #include <linux/types.h>
 
 #include "aie.h"
@@ -110,6 +111,22 @@ static int aie4_msg_destroy_context(struct amdxdna_dev_hdl *ndev, u32 hw_context
 	return aie_send_mgmt_msg_wait(&ndev->aie, &msg);
 }
 
+static u8 aie4_parse_priority_to_dev(u32 priority)
+{
+	switch (priority) {
+	case AMDXDNA_QOS_LOW_PRIORITY:
+		return AIE4_CONTEXT_PRIORITY_BAND_IDLE;
+	case AMDXDNA_QOS_NORMAL_PRIORITY:
+		return AIE4_CONTEXT_PRIORITY_BAND_NORMAL;
+	case AMDXDNA_QOS_HIGH_PRIORITY:
+		return AIE4_CONTEXT_PRIORITY_BAND_FOCUS;
+	case AMDXDNA_QOS_REALTIME_PRIORITY:
+		return AIE4_CONTEXT_PRIORITY_BAND_REAL_TIME;
+	default:
+		return AIE4_CONTEXT_PRIORITY_BAND_NORMAL;
+	}
+}
+
 static int aie4_hwctx_create(struct amdxdna_hwctx *hwctx)
 {
 	DECLARE_AIE_MSG(aie4_msg_create_hw_context, AIE4_MSG_OP_CREATE_HW_CONTEXT);
@@ -129,9 +146,9 @@ static int aie4_hwctx_create(struct amdxdna_hwctx *hwctx)
 
 	req.partition_id = ndev->partition_id;
 	req.request_num_tiles = hwctx->num_tiles;
-	req.pasid = FIELD_PREP(AIE4_MSG_PASID, client->pasid) |
-		FIELD_PREP(AIE4_MSG_PASID_VLD, 1);
-	req.priority_band = hwctx->qos.priority;
+	req.pasid = aie4_msg_pasid(client);
+	req.pasid = req.pasid == IOMMU_PASID_INVALID ? 0 : req.pasid;
+	req.priority_band = aie4_parse_priority_to_dev(hwctx->qos.priority);
 
 	req.hsa_addr_high = upper_32_bits(amdxdna_gem_dev_addr(priv->umq_bo));
 	req.hsa_addr_low = lower_32_bits(amdxdna_gem_dev_addr(priv->umq_bo));
diff --git a/drivers/accel/amdxdna/aie4_host_queue.h b/drivers/accel/amdxdna/aie4_host_queue.h
index 1b33eda3f727..95ebbb714c6f 100644
--- a/drivers/accel/amdxdna/aie4_host_queue.h
+++ b/drivers/accel/amdxdna/aie4_host_queue.h
@@ -10,6 +10,7 @@
 
 #define CTX_MAX_CMDS                    32
 
+/* Host queue header layout. */
 struct host_queue_header {
 	__u64 read_index;
 	struct {
@@ -17,8 +18,10 @@ struct host_queue_header {
 		__u16 minor;
 	} version;
 	__u32 capacity; /* Queue capacity, must be power of two. */
-	__u64 write_index;
+	__u64 padding0[6];
+	__u64 write_index; /* different cacheline from read_index to avoid false sharing */
+	__u64 padding1[6];
 	__u64 data_address; /* The xdna dev addr for payload. */
-};
+} __packed;
 
 #endif /* _AIE4_HOST_QUEUE_H_ */
diff --git a/drivers/accel/amdxdna/aie4_message.c b/drivers/accel/amdxdna/aie4_message.c
index b137a2a40b34..bdbd1d116b61 100644
--- a/drivers/accel/amdxdna/aie4_message.c
+++ b/drivers/accel/amdxdna/aie4_message.c
@@ -5,6 +5,8 @@
 
 #include <drm/amdxdna_accel.h>
 #include <drm/drm_print.h>
+#include <linux/bitfield.h>
+#include <linux/iommu.h>
 #include <linux/mutex.h>
 
 #include "aie.h"
@@ -14,6 +16,15 @@
 #include "amdxdna_mailbox_helper.h"
 #include "amdxdna_pci_drv.h"
 
+u32 aie4_msg_pasid(struct amdxdna_client *client)
+{
+	if (!amdxdna_pasid_on(client))
+		return IOMMU_PASID_INVALID;
+
+	return FIELD_PREP(AIE4_MSG_PASID, client->pasid) |
+	       FIELD_PREP(AIE4_MSG_PASID_VLD, 1);
+}
+
 int aie4_suspend_fw(struct amdxdna_dev_hdl *ndev)
 {
 	DECLARE_AIE_MSG(aie4_msg_suspend, AIE4_MSG_OP_SUSPEND);
diff --git a/drivers/accel/amdxdna/aie4_msg_priv.h b/drivers/accel/amdxdna/aie4_msg_priv.h
index 5b97c8057de0..b9f7c61f36e3 100644
--- a/drivers/accel/amdxdna/aie4_msg_priv.h
+++ b/drivers/accel/amdxdna/aie4_msg_priv.h
@@ -12,7 +12,6 @@
 enum aie4_msg_opcode {
 	AIE4_MSG_OP_IDENTIFY                         = 0x10002,
 	AIE4_MSG_OP_SUSPEND                          = 0x10003,
-	AIE4_MSG_OP_ATTACH_WORK_BUFFER               = 0x1000D,
 	AIE4_MSG_OP_QUERY_CERT_FIRMWARE_VERSION      = 0x1000F,
 
 	AIE4_MSG_OP_CREATE_VFS                       = 0x20001,
@@ -23,6 +22,8 @@ enum aie4_msg_opcode {
 	AIE4_MSG_OP_CREATE_HW_CONTEXT                = 0x30003,
 	AIE4_MSG_OP_DESTROY_HW_CONTEXT               = 0x30004,
 	AIE4_MSG_OP_AIE_TILE_INFO                    = 0x30006,
+
+	AIE4_MSG_OP_ATTACH_WORK_BUFFER               = 0x40001,
 };
 
 enum aie4_msg_status {
@@ -32,6 +33,14 @@ enum aie4_msg_status {
 	MAX_AIE4_MSG_STATUS_CODE = 0x4,
 };
 
+enum aie4_msg_context_priority_band {
+	AIE4_CONTEXT_PRIORITY_BAND_IDLE = 0,
+	AIE4_CONTEXT_PRIORITY_BAND_NORMAL,
+	AIE4_CONTEXT_PRIORITY_BAND_FOCUS,
+	AIE4_CONTEXT_PRIORITY_BAND_REAL_TIME,
+	AIE4_CONTEXT_PRIORITY_BAND_COUNT
+};
+
 struct aie4_msg_identify_req {
 	__u32 rsvd;
 } __packed;
@@ -94,7 +103,9 @@ struct aie4_msg_create_hw_context_req {
 #define AIE4_MSG_PASID GENMASK(19, 0)
 #define AIE4_MSG_PASID_VLD GENMASK(31, 31)
 	__u32 pasid;
-	__u32 priority_band;
+	__u8 priority_band;
+	__u8 priority_level;
+	__u16 restore_id;
 } __packed;
 
 struct aie4_msg_create_hw_context_resp {
@@ -106,11 +117,14 @@ struct aie4_msg_create_hw_context_resp {
 
 struct aie4_msg_destroy_hw_context_req {
 	__u32 hw_context_id;
-	__u32 resvd1;
+#define AIE4_MSG_GRACEFUL_FLAG GENMASK(0, 0)
+	__u32 graceful_flag;
 } __packed;
 
 struct aie4_msg_destroy_hw_context_resp {
 	enum aie4_msg_status status;
+	__u16 restore_id;
+	__u16 resvd;
 } __packed;
 
 struct aie4_tile_info {
diff --git a/drivers/accel/amdxdna/aie4_pci.h b/drivers/accel/amdxdna/aie4_pci.h
index 8c62ee6a9b23..bdbb2d7cf0e7 100644
--- a/drivers/accel/amdxdna/aie4_pci.h
+++ b/drivers/accel/amdxdna/aie4_pci.h
@@ -75,6 +75,7 @@ int aie4_query_npu_firmware_version(struct amdxdna_dev_hdl *ndev,
 				    struct amdxdna_drm_query_firmware_version *fw_version);
 int aie4_query_cert_firmware_version(struct amdxdna_dev_hdl *ndev,
 				     struct amdxdna_drm_query_firmware_version *cert_version);
+u32 aie4_msg_pasid(struct amdxdna_client *client);
 
 /* aie4_ctx.c */
 int aie4_hwctx_init(struct amdxdna_hwctx *hwctx);
diff --git a/drivers/accel/amdxdna/npu3_regs.c b/drivers/accel/amdxdna/npu3_regs.c
index e82bc0a4f597..93f749acb5d5 100644
--- a/drivers/accel/amdxdna/npu3_regs.c
+++ b/drivers/accel/amdxdna/npu3_regs.c
@@ -38,7 +38,7 @@
 #define MP1_C2PMSG_60_ALT_1     0x3B109F0
 
 static const struct amdxdna_fw_feature_tbl npu3_fw_feature_table[] = {
-	{ .major = 5, .min_minor = 10 },
+	{ .major = 6, .min_minor = 0 },
 	{ 0 }
 };
 
-- 
2.34.1

