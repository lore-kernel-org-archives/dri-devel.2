Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E443CA9EBB
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 22:54:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83DE710EB5C;
	Fri,  9 Oct 2026 22:54:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2B4KXOov";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011065.outbound.protection.outlook.com [52.101.52.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 771B510EB64
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 22:53:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QeH9AD065Bas5fxWt3do+2TpV0Y+Z6n5eijaii/G/2Nu4OT6sXO1K3pxN4XXvEbEQw4nUrJsxYGZV2446/JWO71PyJnmZjtiWoFfWV/NkQCCbVhSyuXd0Fzt1swaGzvSqnBrWHrmucDkzvCd8osjKpqUNoeray4EOcBhwAkIVb8n1fxLOwmrw9uhGVB30lhfHw8jBF1VSr48kIfMrjey0nSZLpgs5gNj+ywlvKN24ETnB4LaWdclMSeobBO1SVszbs3WDUBQtmTFOrKvq2eLCmr3fLg+QimwLB8UAGohJTRgasbB44O678AVmBTaYmqd2+z+QVeEtZXIHAMBYbWjsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J2G2ZEyrr6N19FTKkzO+RYJGvOjxzc88daEvajxs2TA=;
 b=qVxT4sihYp+QEY4oGDUA1kO6fO4ETrMXouBciw+L5OcdL/B58fCzGYGzMvi3fwZbs7xCQBurJVlnE2dSbwoORxB/oF32hx6YFlYwmUrHIsVgvFvsycdPhqZEgGwWY1NFqE6fESNHt/H7GE8IQlkAS0hvBRzvnd0m3q5+dDm5almNqAzzzML7JWRX0rMVZFhogKOeM2dSFn3Ypu9+T4i9Wux50qkrjDklqzwphzegeN3qQHMro4fQ9vW6kTH8m4gMSTqXpeDEafg8r4xutJHiMbjdpjPxAuddVGG69d99TWMk0OU1X2fpbJXEPsBuBHPNS8Jd0V43VozgGWqJP333cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2G2ZEyrr6N19FTKkzO+RYJGvOjxzc88daEvajxs2TA=;
 b=2B4KXOov/KZAsKxltPZpqFbEmEea7c5X88bz+hJ4ZX4wrBQ9c22B8tJ89k+gRNd84bsCblnlCvjKv+Le8Gqz2yedjhiLBdAaID6KDYMJolQ/TvTPRYP2ClxaTJJ2W8uLepGBm/DlHbMHSkCPbf7suPo1jmrFbbdZy9vA8nXc76k=
Received: from BL1P222CA0013.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::18)
 by CY0PR12MB388677.namprd12.prod.outlook.com (2603:10b6:930:132::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 22:53:53 +0000
Received: from BN2PEPF000055DC.namprd21.prod.outlook.com
 (2603:10b6:208:2c7:cafe::4c) by BL1P222CA0013.outlook.office365.com
 (2603:10b6:208:2c7::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 9
 Oct 2026 22:53:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DC.mail.protection.outlook.com (10.167.245.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.0 via Frontend Transport; Fri, 9 Oct 2026 22:53:52 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 9 Oct
 2026 17:53:45 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 9 Oct
 2026 17:53:45 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Fri, 9 Oct 2026 17:53:44 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>
Subject: [PATCH V4 04/19] accel/amdxdna: Support firmware 6.0
Date: Fri, 9 Oct 2026 15:53:28 -0700
Message-ID: <20261009225343.3079074-5-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261009225343.3079074-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20261009225343.3079074-1-yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DC:EE_|CY0PR12MB388677:EE_
X-MS-Office365-Filtering-Correlation-Id: cf84b1ee-ca7b-44d0-6a9b-08df265830ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|56012099006|4143699003|11063799006|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: al+2DOEIaUJQc1XG5Im8+9dbUAXU0VbfpEhYhgM8A3AlUI83kcR66L/vqQwjDFU9dbrI4nr2QRYw1qpQCbRvAJPOGCl1aKGD5ftY+uPPmy27hOGN0v14kUHeR+6bBy2x9QMJsUmtawFOs7utEC+YAX7S+yMTjLRfSauwV4Pqu0Eh0l17G0sMdJ5rHT04yQso5fhkZ2eM9iymmkyDs0TzwQgPjL8+7kQoQioI1J3x4gZydo4RPWjXc3HaJuXxGn3JDpXW4OFY8aVeDbvLch7v22xjy/L3PoQ2kfqC0EmD0icrHrejurAgsHCNVn64e6Stzo5qaL3fS6J85gnqDDzPRUmWsNXBX6tTK59Ci/962SsvtQifcH01Zb2IZN6x6ctcx0T0XaaPlo8MhIRfViPabj43fzPM85iLEY8TEmkAYQKtpv5aX1Eh8HJ8HtfuDIywU+JAKzSRl4lEaVKZ6OSvoFC8dfkGEtKBKQd4mCd6snLq/zLCZMlTHR1Mnek+wvFelrRUe8940tKdi+mQ428SIE9Fl7z5ytklTFMHAIDN3iC/yIz2eN1t4ycvT7VZ7M+PF1Pcuy8VlQlZR3OJklsJ+k6F36bgeXekYesTe0Son99lQUxd2WkyBiInwuF02DeuP4VtkdN0HQWCwUvNs5lJjtUOhQm00OBonVBxxJ43rrM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(56012099006)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FABT8JRyyIOb/WuDtXOBc09ataOsbKR1d0SQeEZSbgO03T67Fv4B63QudGL1h7fIySi2r6+6TeKxtSJ9QqkBBPcnTxC1dFg3zusig6lyJJPBIcgs/BZzTOv+wRWWn0X1QyHNAxc4HTnLOleU0Ozip6btvApt71oLg1Rna638DzqbEw4ApG1dwhQofNNg/EsMyqXZg3Qv35U5kpfqj4EoL3Ocrxq8iKxIh5b9ha4Zu5nelSe7lpHjX9bgbi5Fl7l4Za/p7yXdY2pDmiHh5kAnX4MmqzjI3vEWqXdaz41AZw1O8vsb/aqggTT1QiIUj8XM6lfLrDgDxb0qSAy+PHoHZ5GnffUBxH6Q5IM/74a3o3nepSlSyi6SJk6aplDmse+JhmUB3PF+HlF7FbJLg290HMyl0+qaUKbwLBkhCn4f1lPt7itu3Gy7AGuvVa/zjwhz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 22:53:52.5998 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf84b1ee-ca7b-44d0-6a9b-08df265830ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY0PR12MB388677
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

Support firmware interface version 6.0. Update host queue layout,
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
index 53f8e366b66c..f67aa8ba943c 100644
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

