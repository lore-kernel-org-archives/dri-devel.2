Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F42DCA6001
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 04:23:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB38210EF76;
	Tue,  6 Oct 2026 04:23:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uH55X1iG";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010012.outbound.protection.outlook.com [52.101.46.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03A5410EF74
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 04:23:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tscz/fma6pZ3UXiu5I/iXt/gHceGDTVHwhqYd5rfVYvjDauDgWPrJMQBLikipynfQV7wqfJiIEoVI6rPgrGvN8Tn+YTFA3mNsA5Mw+VS+eUQe5T8GHazbfMkKeCpgEvMsPfB+PdUBwxn0l87nxthJhCsTulYNUa5M3eFXXG4gWpn7z0tM1lvPwT1yOG7BEYhHzxVnY8nzKCfSdy6Q7cDC0RCljhWBTCaScxta7yH1onpMB55utYynysFBsEsbpBp+qj3GXXcgTkOz7O7YkupoLKk7h49aBsSGi1JIuOf8tehU8fhi4MV1lZRsv/Jecn0O8oSk++xtlctDErKZGwbgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8c/cH9MJoOudEzLhll7Kpk7OUr2RsY4BeLqMXxAxcAY=;
 b=WaRbmLRyxsalRKI7ANWrwAV+bJCVPLyPFT5wRFczUff00YHygvRtZWKCFSU+Ex6j2cKd3Gb38LLVUtMdVg4obNu18QbCY0iqyrMC6rJO4qPKhb8sNbb0DWgMpKidPaQegQDWZUJZS/GxJ0wEOXGj6fnj7v7okq3NTey4iumaIzB67t6QzO8XKNjmYGQ6DegQGYb+eOlnez/wkn8TYtN7PHY5zERhb8ZAUYo9HDJyiyAGbOj6nQfSWi9YLThbMv3LRPdANEPDE1Lt2SEqfnlFhkjfmQdwUPFSInT05MsQI7Mnk+v5FKaoclP0oM69znx4KyiTKzNdCYQj39LvhCycTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8c/cH9MJoOudEzLhll7Kpk7OUr2RsY4BeLqMXxAxcAY=;
 b=uH55X1iGvfwhum7mvjajJuMo7GjxLA33vCiJIQWyWVIkucRH4GKC+zdXuFpCIeOX86KZMzcaW/CEQVzxswUDr3Ii6LfdyAwpn+/6BeVyo6g9E9RA/1F4Gqp43WSM+r9o/xRRox4rJqCDmjESbIks6ZF2N2y2UXfyZ77FeI1+4ZE=
Received: from BN0PR02CA0034.namprd02.prod.outlook.com (2603:10b6:408:e5::9)
 by CH3PR12MB363094.namprd12.prod.outlook.com (2603:10b6:610:360::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.21; Tue, 6 Oct
 2026 04:22:55 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:408:e5:cafe::aa) by BN0PR02CA0034.outlook.office365.com
 (2603:10b6:408:e5::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue, 6
 Oct 2026 04:22:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Tue, 6 Oct 2026 04:22:55 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 23:22:49 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Mon, 5 Oct 2026 23:22:48 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>
Subject: [PATCH V2 04/20] accel/amdxdna: Upgrade firmware version to 6.0
Date: Mon, 5 Oct 2026 21:22:14 -0700
Message-ID: <20261006042230.547807-5-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261006042230.547807-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20261006042230.547807-1-yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|CH3PR12MB363094:EE_
X-MS-Office365-Filtering-Correlation-Id: a5a14857-469d-48a6-d5fe-08df23617efa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|23010399003|22082099003|18002099003|11063799006|4143699003|3023799007|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: CnSWYUg0jlSQombdYydycFUkQJWdy5aQ4/DcTEO96VnlUetCIR/8s97favQX16sBkqLzKkugWw6rIXikKDpvvoIAXNWyTMl9RyiqCztwIOSAljpBK/Mj1vg+gqhs7pcplSErbGSZLZcKVfWEdC1E53wbPER16/ZV7pDZggvsvMHab1TLh3Zf0klX1nTvgulxxL4E9zJGqw2sY9A7ALiL0PLr8sGFzgg7qzm9ul/u7OlUxYIYVPwG9A+0H073C4M8TUedEgmUzKkXF/xdCngHw/IcmnFPaQGcSPpIiuKVn+c/mn9DFYVfCmOCXE+Q6Mg1KwTIREjdvC1HFgmKS6o18ZFPl4hQINMBKO9vm2U24mQmu6vsWD9EpH527gr5d6B1trfSTBqgixfWUbQlAudTrTw390aC1cBGKs4Y5r0zMa1RLO3ximzU+SyR1uJelDcAf8pG/CTIqz81LQEK/niZDn5MjBB6bVGaAJVR1kDocvF0wwxAP95qOEybtrKy2ls7zppoyVw0HAEl5/503mCMnwSdOVlX3dta1HORYYBK8orLN8QA203W33w7lZm+iPupkT2suxlu+bTDmpZI2rAKiWpo6QT/uwvNIjApooDo5nsDaAFLJddBYSAALV1qzCa+s+eBnphM3ghoyxROlY1iCQ9saxx7NogUGV6pywWxDGgPBhj9vhfmcZ0ZJ79E4g4jiDpqCh/vfxXYNzfm1A4r8Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(23010399003)(22082099003)(18002099003)(11063799006)(4143699003)(3023799007)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Pyz5Jc3QhuUMC+/y7rTKY1thUoWAQzbr/5fXgfWIw8TvkbB8Y9781YZnz/3qRT3DlsyE0Ikxgsjy6BG/16nHKcCzGb63b712XoUppbfBOLnzjMugxoIT/+5xTFR89y9QF8FvEB/3yTqvRMADrrq7kPQUJYejCEYsZmkDdlOe6dq9sNrsIkOD5E/1ZFHhq/lhWU5GIj0mmlKNITC81JnfoSjIha3Hknw+3O5BsQ59+rrKYW//oee10an/oDk1egroGvHMOeE0ereGYrVOuTJ4ppdgzKs6jqxdBBYIVMNQjgQonptStEncuhJdCUfukBEeToBy0G2s7Cf0h74xxr2Ki5Ylr77rVBPk45HYGDXTOyQ+8dlKN8Tb6d3teF8ilPx0ogPPrRcK6Ua6SGGik9LNMlwto87XKFzP4ytz8x/fyhourcK7cF2IBd0qVECYHc1g
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 04:22:55.8645 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5a14857-469d-48a6-d5fe-08df23617efa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB363094
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

