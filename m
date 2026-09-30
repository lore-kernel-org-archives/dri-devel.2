Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE59CA5FBE
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 03:33:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA51E10F165;
	Wed, 30 Sep 2026 03:33:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nsW7SFw9";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010066.outbound.protection.outlook.com
 [40.93.198.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D76810E9E0
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 03:32:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eZF7Ksg5oAlgRYsio+i7lnlxAUP1/0D4Dv/FYOfb0zvLKCKyr1+suTgaTPxPkWkf8n9banCEFTOMkUvqVNBaWi0dyAkoXdfJ0cIrCWH/ZbSC6IhMF+8vFriwRNAyim20HPSkRrfBdkky++vZu51sl6YasRu5wjJwtRqGX0oayZS2Sc9iVqCvacs0seG0ZiW9cTlNYAGhBOaPt18tK6BU+jCv2oELOYHatZAAPRGKkiOtvsBxjytbPeVxomloU74xB3UcE2iokrKpOxxYlc9emVemH9HDCBWpcFfe/GY02pRHCVf7PoWTi6zWKIsI+UPNdL8Wr5AMCYI/Tr82zA3YQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LtB3YCuHztMKGvU4nGY802UQ3TN+cnoEFRfCIs5hWss=;
 b=bZI2yeN2aW6r2AiF9jl46a0jnt/6fP9WhdqINKSE1dKjcLN+TOVLz1KqXnvmKH0VBUz9T6mYsOIpEyMjpwrLZEjT6R4OvlCa+0nBQAb7SvGn9KvkYjcDg/2bTIC/KTOmOl+He75KC2DZ7BQhbLN1MusIldAgaZ1h7SD3MkjxTgbGC29lT6GGqNgn+7RL4jQLf2zMoWbY23WnJBx6ul0l5hGF/cBC0kmRJXw5GfmRiAUlT8C2p5INSZj3YcI/T6WP96NtNAi+V6GwZ1duC1AkHj/yk5g6zlgslN0AAEPjlcIYkNDm1YOuvcBJYO18srVIdFBFL4g9Vp6Fx8Jg7x6msA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtB3YCuHztMKGvU4nGY802UQ3TN+cnoEFRfCIs5hWss=;
 b=nsW7SFw98lEk7BK9YUSCJA3eihJalUz5LgO/lXZAnuwXVTUQZ4YGAeZ/HzH9cFZUdcHXZSsoC+gi61amX0ko51colBiz1TbjwvHvLhR2ikeavTz+39PFAOyYRtqW05/rzQXpC5OEmzh1GOOBgr4lHjmkBIRECjqbdYJRcq/snu0=
Received: from DS7P220CA0121.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:25f::18) by
 CY1PR12MB9603.namprd12.prod.outlook.com (2603:10b6:930:108::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.24; Wed, 30 Sep 2026 03:32:54 +0000
Received: from DS2PEPF000061C8.namprd02.prod.outlook.com
 (2603:10b6:8:25f:cafe::8e) by DS7P220CA0121.outlook.office365.com
 (2603:10b6:8:25f::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Wed,
 30 Sep 2026 03:32:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF000061C8.mail.protection.outlook.com (10.167.23.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 03:32:53 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 22:32:53 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 22:32:52 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Tue, 29 Sep 2026 22:32:52 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>
Subject: [PATCH V1 04/20] accel/amdxdna: Upgrade firmware version to 6.0
Date: Tue, 29 Sep 2026 20:32:17 -0700
Message-ID: <20260930033233.1727265-5-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930033233.1727265-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20260930033233.1727265-1-yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C8:EE_|CY1PR12MB9603:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ee6902d-481a-4780-5285-08df1ea3832c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|82310400026|36860700016|18002099003|22082099003|4143699003|3023799007|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: tSsO65iFWlgQcCRqhoX2WC5djr6txA91vYVOwe+/GnLAnASDfE4IYsJkjmRu3CDcZTUy/lggIH/uuSAGg3F3ItCTeUkdCtCe7fkoQsh3TuCTydvZ67B/bsRoJYXwCV5pKRBiBiS5KgFxS5P6lezx4weAcMVecYuSyAZEMDXHyxN5/ikBoIlhC4aCaMaTQqWEDKSV5MKQEWg4j6z/P1Ryhil2HqAHLPbP9btRBflczTp2epxiJeuXZT9Ms5rLng36uPOLdy6lLnjtzbQYNZ7fw99qzT3UGsA6FPamEBm8LLrGxMiu0rC7qHAz1Qp/4iGr+WcSOJl+WjWIsT44G4kautUtELhHNDObkd8ol1Z5B8ihvpUlK58x9rBTHFV0FGlOO+wcqTpYOd8GpkWnKOqce6UJxUaFDr8RDnCbJJ2iDBDRmpcokyXv/WiM0PQl2PYOyU5Fzc6m2zxNXc9SuGeSCtcW8hpuMGYcxaXevZAlztNIUCbL2/0d8HL3xe9QlN3jdVrrLBhdzNaeZLzatNPr4rGzue35qK8CN7UU4rGYlB2pxeLye1KbSuUMoPV4UBxkdKefDZKNE7Eo1L/z82d7A7Jt39rhd/HH1CylUogtnZZBKP7pS5/KG+DE6EhGNg+DJsGuYU6XeJHczZp8iJHML1q6ODHPNXJe/JqyEMzSILUgE2hzK4Vzs+VQDIKX1TJeenZW871Zf0e9SVEdjZVqog==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(18002099003)(22082099003)(4143699003)(3023799007)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tAxmt8JXrF372YtcjIf2780lxW214oy4DwdCRGeWgbjJ4WiiBV979+OnzjDhRiLt4f30oDc+oUe6JlmG0mLN5QKzZ2tsPFksTivciaG0qrmypktN/LDlFm4i6ZKxGsWkBc6H64XPbP2rhIPDxu/ZOw+GkS04HxkGlU4zO3sfQTCc8Z8fojtUsUf5NPflZn2y/7VmspZnFCakkYSjDepdEWveQTtTfk7xk2yYiuk10WIje6/FjjrGznYkKm39bNftDD9blD+PrysvYd+7M5N7iCt/8YJmjczhtd4e634b28Xlfe5LTjb2n3JaBX3lrNGaljEo1Brv+TyORMcwvqQglZ4xrZFrgz/ly2VczDgZU13QhOy0Z4t3om8+o2OA5TO8zaMXtNOfku6cFNT4/MAUtFfvVF+oOALeRP1fRdiy6PSADbYPriprMB05wXaMjRfm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 03:32:53.8363 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ee6902d-481a-4780-5285-08df1ea3832c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9603
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
 drivers/accel/amdxdna/aie4_host_queue.h | 14 ++++++++++++--
 drivers/accel/amdxdna/aie4_message.c    | 11 +++++++++++
 drivers/accel/amdxdna/aie4_msg_priv.h   | 20 +++++++++++++++++---
 drivers/accel/amdxdna/aie4_pci.h        |  1 +
 drivers/accel/amdxdna/npu3_regs.c       |  2 +-
 6 files changed, 62 insertions(+), 9 deletions(-)

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
index 1b33eda3f727..97e535939b32 100644
--- a/drivers/accel/amdxdna/aie4_host_queue.h
+++ b/drivers/accel/amdxdna/aie4_host_queue.h
@@ -10,6 +10,14 @@
 
 #define CTX_MAX_CMDS                    32
 
+/*
+ * Host queue header layout.
+ *
+ * Note: Compatibility for this layout is checked against the CERT firmware
+ * protocol version (host_queue_major/minor) via aie_check_cert_protocol(),
+ * introduced in the preceding patch ("accel/amdxdna: Add CERT firmware
+ * version support").
+ */
 struct host_queue_header {
 	__u64 read_index;
 	struct {
@@ -17,8 +25,10 @@ struct host_queue_header {
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
index 31208c42ad5f..891c5f243ae5 100644
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

