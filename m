Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C3B60A3839
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 16:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=TwHKwwTC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13B4510E6E2;
	Mon, 19 Oct 2026 16:48:08 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010051.outbound.protection.outlook.com
 [52.101.193.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBC5110EA8A
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 16:47:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tJW9Tg/ScQvP3BPgGhOdjAmz8jKcZ4yYD3kVn1V2y6Ru9rq2Ps0U83beQJLsnTWHFE7aZV4tORBNb5DGzdTJObks0wULfGWGGQgyKhefdLDGE0hF81axabLseZUHViTe0wNSoKZE9K2Z3sUBa4968HtqqkcP/R3Lc8/mhXnFSIpB0DR8CDR9WyMVUI002gpnO+7zV03YnlqOd7LvmOiqm4zu3xkzkf3SZGXxiiEfDwIeFc1rPKXJ227uXk8p/r3YSpA7xDGqlpxUn4v/4dSeYTRVq1uZfLrTwC57Mnyp2AXPhS8fpb0PoPpy0k/rg9w/wtd6xf6zYSYsTBMykq4BJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tHVxfJLENTxmuDJW9oTAfi/pJFMtD6s1ip7NDLv8lIM=;
 b=vA/ZgFVKPCDlaRcgx015jbkcegLpekL7+Nj3TALtsf/F89nW0rHNvBXL72W0Dj0Gmf7VjQqmkPeHdCj190XLRV6DwCcDMYmYd7E/nhjRvfGzOI4g+8cJ7BVuWWsQkdU0E1QqATRw3XGeqqJtrO7aTy0ZT77C6++qzfv8IFxzSR901mOLE5yurI/dqBI8HZbeWuIXMgQQzTN8N5u9lUizsw0MAmMn0JBnfCF2o9cKT+4qNX24rlAbyKUvCQoxkkd3Di3bYCr0XAXybHbqTxcjMLcOTAchWxF2C09MaSsZyVaAQ4AYgN/I5T32cUYoFo8miLpx5DVrFd4ghEjPQ8rHqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tHVxfJLENTxmuDJW9oTAfi/pJFMtD6s1ip7NDLv8lIM=;
 b=TwHKwwTCP/Wh4J6NtQJdIbMq26CrkT72XhekfIXFD4fyGnj4OVhTJxTsRw9+KSOMRN/Q36X1Q95UX6fMBy7EydFWCJs1CkmDOkMCJ+76hkYBUKmbGu6VIdLY/uVNy6JEbQeLqQLOyR97EJ4Y/DCzSZC/Fx7yqD4Bq1jn9v2rsVg=
Received: from CH2PR18CA0044.namprd18.prod.outlook.com (2603:10b6:610:55::24)
 by PH0PR12MB7813.namprd12.prod.outlook.com (2603:10b6:510:286::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 16:47:53 +0000
Received: from DS4PEPF000001C3.namprd21.prod.outlook.com
 (2603:10b6:610:55:cafe::a4) by CH2PR18CA0044.outlook.office365.com
 (2603:10b6:610:55::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 16:47:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS4PEPF000001C3.mail.protection.outlook.com (10.167.23.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.0 via Frontend Transport; Mon, 19 Oct 2026 16:47:53 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 11:47:45 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 11:47:45 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via
 Frontend Transport; Mon, 19 Oct 2026 11:47:44 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>
Subject: [PATCH V5 04/19] accel/amdxdna: Support firmware 6.0
Date: Mon, 19 Oct 2026 09:47:31 -0700
Message-ID: <20261019164746.827277-5-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019164746.827277-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20261019164746.827277-1-yidong.zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PEPF000001C3:EE_|PH0PR12MB7813:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b642b6a-bb5f-4327-019b-08df2e00b83b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|22082099003|18002099003|10067099003|3023799007|4143699003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 510cNe86q2A2d8gZnS4V+OJlzInN9fY0y5XT36E9ibOKg37UMdtS1kqOt9oaqYSg7OYq4mYueItfXPxh8p42De+cSj4naNUyvi3w11A1pviowc8S70jVRGAqlqKO6JeEHBqhtErQPZkJV4iaThe5VFcjmhj7n7fLDpGt52dOGuTyClqjFTT3QVcTvkkIxAmFZ+ELH+IVlH1XzqJ2tHVEfn4IcsDj/4Kcewqxn/7/BotLsW5JOJ9MRRYOoRYWzpLGAPOYiV6/fpBDqU3c/d2Ppby5uaMiOOnXEVG2rblxYhu3U/Vdva5/eAt6/wCBGNwcazMHe/UnHDYLm/OSeLfuAWfCfzwmCeI113kO7XYtheUtULHLhRCvlO6Ii8YyQ7kObJKzr0vHXW9UVmpjomDGZ0V/tlnWu2L49xcEREgpfD0nbsTWQ5m0Pt6Jsgz6pJztHjo7U6Gg9kbGzQ9q5aAZtULwpMJuKbzs0nP0LHsx3YMoQmM668D3PeggKfJHbeyeqE/RufOlkw3x+P/ta7bjMEn3nvjIO61tjg+xS3pSXmf5N5aASZhU61ebjMiyJ9ueFSqOOo2k/fLD5mQ2l45iC/ddG0PkfZALKKZbMmEB06Mv8mAqZIFrWXE6RZUihXaS1ucau2/Qp/OVlj5fDLG2+OY46DiKNDmDPXdtTPtydbk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(22082099003)(18002099003)(10067099003)(3023799007)(4143699003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wQ1UW7vCyx3VAxUDDf8ndT0E1s2nvOJ34yOzPJiWdwBiGVPoMAkC5PSkVtdlPLA/nA3YAf7XJjvU3Lx499B702iB+aM8UpTfkvWvaSwpiAqlDmzOpsGzfhqDYM1fXNVm05UOykm1cEwLMOzXZJ0q3ngYRsx5F5zR9yAWO5CQk0WN70IcZtyU2DXpEt5xNkuRg3vvCOveK1NuNwH2TAG6CWnU6CO8WBTDyQwMvU97qcEpo0Y5ArIHAkZJ6FuRLMbjkLIA1zsV9fOLwx8+EkTpcZ2REK1KKIRhymwCbr+vvSIMybTXsDbplpUeHj8dsuzYClCF4+ru8obOqkCmHxLsTLTZ6X/KnscXUbSEIgHwB6IGOdFJSrYq6n00hnbn3RdKnXH+BULrHWM5ny4Er+anOY5/AQU7LFqxp7LhWHWfkLp5M+R2RMDzG0HGxP3GYIKZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 16:47:53.4865 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b642b6a-bb5f-4327-019b-08df2e00b83b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS4PEPF000001C3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7813
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Support firmware interface version 6.0. Update host queue layout,
opcode definitions, and context creation/destruction request structures.
Parse priority band and PASID for hardware context creation. Protocol
compatibility for this queue layout is validated against the CERT
firmware protocol version.

Signed-off-by: David Zhang <yidong.zhang@amd.com>
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
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

