Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFEA2CA5FC4
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 16:47:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5056510E1E2;
	Wed, 30 Sep 2026 16:47:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d6q8NLk0";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010008.outbound.protection.outlook.com
 [40.93.198.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8682C10E1E2
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 16:47:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=exiYj2zZyK4updf/dfXe56di+WBiy8XPUO9DY1+Upb4bKYLUIbbTQC50irK3n5/rDMa05Vylpom1ecn1ExqYJrLUJ0znlrj28IMDRhuDq2tMcwdMSPJVeQQ2S8V5yBdIDqbTJIH2GyAZs7ZE1zxSHJPIlb4y/UiyZAZX3tSsZQAF53qTMzjt/vMni/QZdsrn+ZEjM30SaGud+CY/SNAMr41UADCL8F/aH2id7yrLt4KMSAXg5U1T5NJmmoq9RX4pkIwe6bfP6CiP4/wmw0LFIanHBAFFl5QHD3uOZWFEae6IxXig3jvPvEpgE1OYgBeyixKZNSaIz9M4Bc0BsYs3mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KiooRF0clAQJd5g1rOze72dOJjYwC0thCCzaN5zyKdc=;
 b=bb1zky/mfOqRCu83pVg+gJTojfhURhSSfXlKkSd44319TL5Xz3jW7fJk12zGdmS7Yvr0BKaSm6DDs83YXJHquyfSF3Ac5ZqdOrH/OMWzXbcUlpSI4eupBE5STrFuYx22aajL5grk8hIE3JDIklHLVNotIlT0BrQS26emNcKDZIdvQc2x4nkUyYF2BXr+slfIPbHNcK+jN8wVgqe/kcTwwPuPZ7531ZNxx3NPw1/FJMYGBoo7NpiuFOoE0wxIbxkF1xG41G7Z+kVfhhDR34/bSNwaqxgEAjxa+Z+d9nJvHtZnf/gBk9dbTKphxgB6KPDKwEhO8FZYIGHOx6lwXW0cAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KiooRF0clAQJd5g1rOze72dOJjYwC0thCCzaN5zyKdc=;
 b=d6q8NLk0vtlEIdRWNxLFGgeiEmRq0cIew+5Bp0sVSh7ScNpXNQmCZBRY5H1WB4lVj/jR7taVuaarXPVMvsEyVcxA4WE1Yc9ID7AzE8FwHZvmwLsWUm/y+dn3VSNf0RHVfACji2Lxsv5VvaItijtYEk59JCKSNZBgc3EWlwI+ROU=
Received: from BLAPR03CA0163.namprd03.prod.outlook.com (2603:10b6:208:32f::7)
 by IA1PR12MB7591.namprd12.prod.outlook.com (2603:10b6:208:429::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 16:47:08 +0000
Received: from BN6PEPF00000074.namprd03.prod.outlook.com
 (2603:10b6:208:32f:cafe::3f) by BLAPR03CA0163.outlook.office365.com
 (2603:10b6:208:32f::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Wed,
 30 Sep 2026 16:47:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN6PEPF00000074.mail.protection.outlook.com (10.167.248.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 16:47:07 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 11:47:06 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 30 Sep 2026 11:47:06 -0500
From: Max Zhen <max.zhen@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>, <lizhi.hou@amd.com>
CC: Max Zhen <max.zhen@amd.com>, <linux-kernel@vger.kernel.org>,
 <sonal.santan@amd.com>
Subject: [PATCH V1] accel/amdxdna: eliminate GFP_KERNEL allocation from
 mailbox send path
Date: Wed, 30 Sep 2026 09:47:04 -0700
Message-ID: <20260930164704.1049735-1-max.zhen@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PEPF00000074:EE_|IA1PR12MB7591:EE_
X-MS-Office365-Filtering-Correlation-Id: ca96ee95-d38f-43fe-39c8-08df1f127722
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|5023799004|6133799003|3023799007|10067099003|260925022911599003|260925021311599003|260925021911599003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: Xu4qmLEZAKpWtaBCnpWchP81vGcwqQ0ZLbVrbiFml6eB2REXRx2B5VwhGd5x01Bx9bC2U3/NeKJXY/FRR9xLWEywrxv/eURO4l7EFi4VoRlhmIqOlMhDyOBRDnDXjCBAUHcGsAZR/I96sNEQv91E/Vuid6Lb6nIfZojizdwunVBz+Ttczh43Bswl0sBkBXIIjUKPcdThU/oRyI0fT+Vjyz8PCBm9K5EolaO/vN+kP7YygN4nkpelBCUGNHfr9aSISnfxU5b7Phw+YwEu02KPIZ7w9XxRcIMpI9qMAILZ/5Qivnbj8Xxv/e2N2503ZjDMyvFK5C7IuYQU8KsVDzVZjN2OJgJFYL6d1JCW6tgGWR4U2sfHlrYUTFAVLNcMx9qC4YLXk4zWX5mBDJ5J3Y8OrB9Hy8BxISiEMZRYkEvX0iv/2IecAwVCqNVJMeiojF2H1VE1/++ahUMWrmUGFBp+3Hi/cTgsnomiJ0s0Q/2WxacvLuQtk309sPid2wqBmW8wHVnhEacke1hlhP9L+makBQVL1oTsXjLwt93ox6gAFuk9E6aAjUk97pf31wyJTm1pCeSFAMi7ca5aG6QQrB3JzkJ43fvRUzMIPrIIzJjxTBpZGFiHiZjZaV6JDDPF3CAhh6sECZYHr1ZnNhzC0fM85+qmWMheSFh/GUyBOKBjT7fQpX8GDRPf3AHGrS/jxR0g4XX5RhcGrw9deYDIWvjTWQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(5023799004)(6133799003)(3023799007)(10067099003)(260925022911599003)(260925021311599003)(260925021911599003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dS431R38v5pNmlZTj01XWY9ErRiuraoaGy7D5IQuT80eb9fCHqNRcFB5PClWeNUEk3D1SugXKE+92pZyU6NFMznPn0hWgXu1Cdfy3uLk9ugMencqGpfwRlAbVvYTFHJcTmYR2IIiuDQU6Sb+2bhQwqMduelnFVKda92bSONuIkDcmi8sOAiUga7086E+pbF9WAby3YBGbQ336zhJm4v0sAO9LVythA+BGP7IZbC4eaJ+aCYObDDrxkWDWCd88fQMF4olq+nH+tcPDmFw1E1kF9B2ngcpRpgdQ+65iH4p0vQpjDFNC7V1YrHefe5GspdlOBTTk8Gys6SZ4FAwKMTi1XVVSQN/O8qsGBBK0jZR+X5nZsoODcKcVtnxlNde2J2iuv9SkSorIZ9BYOWE4Vhl20sp/u9DPdUfDdl7WrGGIQMp4knug+KQhcgZgvD492s3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 16:47:07.8069 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca96ee95-d38f-43fe-39c8-08df1f127722
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN6PEPF00000074.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7591
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

Replace the per-message kzalloc() with a pre-allocated pool of N slots.
Each slot is rb_size bytes which is the combined size of the mailbox_msg
metadata and the package payload must not exceed rb_size. No dynamic
allocation is needed in the send hot path.

msg_id encodes the slot index as (slot | MAGIC_VAL), allowing O(1)
lookup on response. A bool busy field tracks slot occupancy; it is set
after the memset() that initialises the slot so the flag is not zeroed
out, and cleared in mailbox_msg_done() before invoking the callback so
the slot is available for reuse by the time the callback returns.

mailbox_msg_done() is introduced as a helper that saves the callback
pointer, clears busy via smp_store_release(), then invokes the callback.
The release barrier ensures the loads of notify_cb and handle complete
before busy is cleared. Without it, a concurrent sender could overwrite
those fields after observing busy == false. mailbox_acquire_msgid() uses
smp_load_acquire() on busy to pair with the release store. Callers hold
a per-channel mutex, so only one sender runs at a time and no atomic
slot claim is needed.

NULL notify_cb is handled inside mailbox_msg_done() so fire-and-forget
sends (e.g. aie2_config_cu with no callback) are correctly tracked as
in-flight until the response arrives.

mailbox_get_resp() guards against duplicate or stale firmware responses
by checking busy before dispatching. A spurious response for an idle
slot is logged as a warning and ignored to keep the channel alive.

xdna_mailbox_wait_ack() on timeout logs a warning and returns success.
The message is already published to the ring buffer and firmware may
still consume it, so returning an error would mislead callers into
freeing resources that firmware can still DMA into.

The management channel slot count and async event pool size both use a
static AMDXDNA_MAX_ASYNC_EVENT_BUFS of 4. The channel must be
initialised before total_col is known from firmware, so the value
cannot be derived from ndev. Both counts must stay equal. The channel
is sized AMDXDNA_MAX_ASYNC_EVENT_BUFS + 1 (one extra for other
management commands), so the pool cannot exceed that.

Signed-off-by: Max Zhen <max.zhen@amd.com>
---
 drivers/accel/amdxdna/aie2_error.c            |   9 +-
 drivers/accel/amdxdna/aie2_message.c          |  16 +-
 drivers/accel/amdxdna/aie2_pci.c              |  10 +-
 drivers/accel/amdxdna/aie2_pci.h              |   2 +-
 drivers/accel/amdxdna/aie4_pci.c              |   8 +-
 drivers/accel/amdxdna/amdxdna_error.h         |  10 +
 drivers/accel/amdxdna/amdxdna_mailbox.c       | 224 +++++++++++++-----
 drivers/accel/amdxdna/amdxdna_mailbox.h       |  10 +-
 .../accel/amdxdna/amdxdna_mailbox_helper.c    |   2 +-
 9 files changed, 208 insertions(+), 83 deletions(-)

diff --git a/drivers/accel/amdxdna/aie2_error.c b/drivers/accel/amdxdna/aie2_error.c
index babdac0157ab..8516574e33eb 100644
--- a/drivers/accel/amdxdna/aie2_error.c
+++ b/drivers/accel/amdxdna/aie2_error.c
@@ -343,15 +343,14 @@ void aie2_error_async_events_free(struct amdxdna_dev_hdl *ndev)
 	kfree(events);
 }
 
-int aie2_error_async_events_alloc(struct amdxdna_dev_hdl *ndev)
+int aie2_error_async_events_alloc(struct amdxdna_dev_hdl *ndev, u32 num_events)
 {
 	struct amdxdna_dev *xdna = ndev->aie.xdna;
-	u32 total_col = ndev->total_col;
-	u32 total_size = ASYNC_BUF_SIZE * total_col;
+	u32 total_size = ASYNC_BUF_SIZE * num_events;
 	struct async_events *events;
 	int i, ret;
 
-	events = kzalloc_flex(*events, event, total_col);
+	events = kzalloc_flex(*events, event, num_events);
 	if (!events)
 		return -ENOMEM;
 
@@ -361,7 +360,7 @@ int aie2_error_async_events_alloc(struct amdxdna_dev_hdl *ndev)
 		goto free_events;
 	}
 	events->size = total_size;
-	events->event_cnt = total_col;
+	events->event_cnt = num_events;
 
 	events->wq = alloc_ordered_workqueue("async_wq", 0);
 	if (!events->wq) {
diff --git a/drivers/accel/amdxdna/aie2_message.c b/drivers/accel/amdxdna/aie2_message.c
index f658760c3d48..11fcf47cd7eb 100644
--- a/drivers/accel/amdxdna/aie2_message.c
+++ b/drivers/accel/amdxdna/aie2_message.c
@@ -261,8 +261,9 @@ int aie2_create_context(struct amdxdna_dev_hdl *ndev, struct amdxdna_hwctx *hwct
 		goto del_ctx_req;
 	}
 
+	/* +1 for the config_cu message that can be in-flight concurrently */
 	ret = xdna_mailbox_start_channel(hwctx->priv->mbox_chann, &x2i, &i2x,
-					 intr_reg, ret);
+					 intr_reg, ret, HWCTX_MAX_CMDS + 1);
 	if (ret) {
 		XDNA_ERR(xdna, "Not able to create channel");
 		ret = -EINVAL;
@@ -545,7 +546,8 @@ int aie2_config_cu(struct amdxdna_hwctx *hwctx,
 	msg.handle = hwctx;
 	msg.opcode = MSG_OP_CONFIG_CU;
 	msg.notify_cb = notify_cb;
-	return xdna_mailbox_send_msg(chann, &msg, TX_TIMEOUT);
+
+	return xdna_mailbox_send_msg(chann, &msg, 0);
 }
 
 static int aie2_init_exec_cu_req(struct amdxdna_gem_obj *cmd_bo, void *req,
@@ -950,7 +952,7 @@ int aie2_execbuf(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *job,
 	print_hex_dump_debug("cmd: ", DUMP_PREFIX_OFFSET, 16, 4, &req,
 			     0x40, false);
 
-	ret = xdna_mailbox_send_msg(chann, &msg, TX_TIMEOUT);
+	ret = xdna_mailbox_send_msg(chann, &msg, 0);
 	if (ret) {
 		XDNA_ERR(xdna, "Send message failed");
 		return ret;
@@ -1039,7 +1041,7 @@ int aie2_cmdlist_multi_execbuf(struct amdxdna_hwctx *hwctx,
 	msg.send_size = sizeof(req);
 	print_hex_dump_debug("cmdlist msg: ", DUMP_PREFIX_OFFSET, 16, 4,
 			     &req, msg.send_size, false);
-	ret = xdna_mailbox_send_msg(chann, &msg, TX_TIMEOUT);
+	ret = xdna_mailbox_send_msg(chann, &msg, 0);
 	if (ret) {
 		XDNA_ERR(xdna, "Send message failed");
 		return ret;
@@ -1086,7 +1088,7 @@ int aie2_cmdlist_single_execbuf(struct amdxdna_hwctx *hwctx,
 	msg.send_size = sizeof(req);
 	print_hex_dump_debug("cmdlist msg: ", DUMP_PREFIX_OFFSET, 16, 4,
 			     &req, msg.send_size, false);
-	ret = xdna_mailbox_send_msg(chann, &msg, TX_TIMEOUT);
+	ret = xdna_mailbox_send_msg(chann, &msg, 0);
 	if (ret) {
 		XDNA_ERR(hwctx->client->xdna, "Send message failed");
 		return ret;
@@ -1122,7 +1124,7 @@ int aie2_sync_bo(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *job,
 	msg.send_size = sizeof(req);
 	msg.opcode = MSG_OP_SYNC_BO;
 
-	ret = xdna_mailbox_send_msg(chann, &msg, TX_TIMEOUT);
+	ret = xdna_mailbox_send_msg(chann, &msg, 0);
 	if (ret) {
 		XDNA_ERR(xdna, "Send message failed");
 		return ret;
@@ -1157,7 +1159,7 @@ int aie2_config_debug_bo(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *
 	msg.send_size = sizeof(req);
 	msg.opcode = MSG_OP_CONFIG_DEBUG_BO;
 
-	return xdna_mailbox_send_msg(chann, &msg, TX_TIMEOUT);
+	return xdna_mailbox_send_msg(chann, &msg, 0);
 }
 
 int aie2_query_app_health(struct amdxdna_dev_hdl *ndev, u32 context_id,
diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
index 7a4314ca843b..a92785163bd4 100644
--- a/drivers/accel/amdxdna/aie2_pci.c
+++ b/drivers/accel/amdxdna/aie2_pci.c
@@ -24,6 +24,7 @@
 #include "aie2_pci.h"
 #include "aie2_solver.h"
 #include "amdxdna_ctx.h"
+#include "amdxdna_error.h"
 #include "amdxdna_gem.h"
 #include "amdxdna_mailbox.h"
 #include "amdxdna_pci_drv.h"
@@ -385,11 +386,16 @@ static int aie2_hw_start(struct amdxdna_dev *xdna)
 	}
 
 	xdna_mailbox_intr_reg = ndev->aie.mgmt_i2x.mb_head_ptr_reg + 4;
+	/*
+	 * At any given time, at most AMDXDNA_MAX_ASYNC_EVENT_BUFS async event
+	 * messages plus 1 other management command can be unresponded.
+	 */
 	ret = xdna_mailbox_start_channel(ndev->aie.mgmt_chann,
 					 &ndev->aie.mgmt_x2i,
 					 &ndev->aie.mgmt_i2x,
 					 xdna_mailbox_intr_reg,
-					 mgmt_mb_irq);
+					 mgmt_mb_irq,
+					 AMDXDNA_MAX_ASYNC_EVENT_BUFS + 1);
 	if (ret) {
 		XDNA_ERR(xdna, "failed to start management mailbox channel");
 		ret = -EINVAL;
@@ -414,7 +420,7 @@ static int aie2_hw_start(struct amdxdna_dev *xdna)
 		goto stop_fw;
 	}
 
-	ret = aie2_error_async_events_alloc(ndev);
+	ret = aie2_error_async_events_alloc(ndev, AMDXDNA_MAX_ASYNC_EVENT_BUFS);
 	if (ret) {
 		XDNA_ERR(xdna, "Allocate async events failed, ret %d", ret);
 		goto stop_fw;
diff --git a/drivers/accel/amdxdna/aie2_pci.h b/drivers/accel/amdxdna/aie2_pci.h
index 2c7019bd26b5..a5fd71329b93 100644
--- a/drivers/accel/amdxdna/aie2_pci.h
+++ b/drivers/accel/amdxdna/aie2_pci.h
@@ -244,7 +244,7 @@ int aie2_pm_set_mode(struct amdxdna_dev_hdl *ndev, enum amdxdna_power_mode_type
 int aie2_pm_set_dpm(struct amdxdna_dev_hdl *ndev, u32 dpm_level);
 
 /* aie2_error.c */
-int aie2_error_async_events_alloc(struct amdxdna_dev_hdl *ndev);
+int aie2_error_async_events_alloc(struct amdxdna_dev_hdl *ndev, u32 num_events);
 void aie2_error_async_events_free(struct amdxdna_dev_hdl *ndev);
 int aie2_error_async_msg_thread(void *data);
 int aie2_get_array_async_error(struct amdxdna_dev_hdl *ndev,
diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
index a58a83af42a4..e99ad35870ef 100644
--- a/drivers/accel/amdxdna/aie4_pci.c
+++ b/drivers/accel/amdxdna/aie4_pci.c
@@ -12,6 +12,7 @@
 #include "aie.h"
 #include "aie4_msg_priv.h"
 #include "aie4_pci.h"
+#include "amdxdna_error.h"
 #include "amdxdna_mailbox.h"
 #include "amdxdna_mailbox_helper.h"
 #include "amdxdna_pci_drv.h"
@@ -181,11 +182,16 @@ static int aie4_mailbox_start(struct amdxdna_dev *xdna,
 		goto free_channel;
 	}
 
+	/*
+	 * At any given time, at most AMDXDNA_MAX_ASYNC_EVENT_BUFS async event
+	 * messages plus 1 other management command can be unresponded.
+	 */
 	ret = xdna_mailbox_start_channel(ndev->aie.mgmt_chann,
 					 &ndev->aie.mgmt_x2i,
 					 &ndev->aie.mgmt_i2x,
 					 NO_IOHUB,
-					 mgmt_mb_irq);
+					 mgmt_mb_irq,
+					 AMDXDNA_MAX_ASYNC_EVENT_BUFS + 1);
 	if (ret) {
 		XDNA_ERR(xdna, "failed to start management mailbox channel");
 		ret = -EINVAL;
diff --git a/drivers/accel/amdxdna/amdxdna_error.h b/drivers/accel/amdxdna/amdxdna_error.h
index c51de86ec12b..326d7153b17d 100644
--- a/drivers/accel/amdxdna/amdxdna_error.h
+++ b/drivers/accel/amdxdna/amdxdna_error.h
@@ -56,4 +56,14 @@ enum amdxdna_error_module {
 	(FIELD_PREP(AMDXDNA_EXTRA_ERR_COL_MASK, col) |			\
 	 FIELD_PREP(AMDXDNA_EXTRA_ERR_ROW_MASK, row))
 
+/*
+ * Maximum number of async event buffers. This value is used in two places:
+ * (1) to size the management mailbox channel, which must happen before
+ * total_col is known from firmware; (2) to allocate the async event pool,
+ * which runs after total_col is known. Both counts must match. The channel
+ * is sized AMDXDNA_MAX_ASYNC_EVENT_BUFS + 1 (one extra for other management
+ * commands), so the pool cannot exceed AMDXDNA_MAX_ASYNC_EVENT_BUFS slots.
+ */
+#define AMDXDNA_MAX_ASYNC_EVENT_BUFS	4
+
 #endif /* _AMDXDNA_ERROR_H_ */
diff --git a/drivers/accel/amdxdna/amdxdna_mailbox.c b/drivers/accel/amdxdna/amdxdna_mailbox.c
index 05c3786de135..2e838cd9c4c8 100644
--- a/drivers/accel/amdxdna/amdxdna_mailbox.c
+++ b/drivers/accel/amdxdna/amdxdna_mailbox.c
@@ -9,7 +9,6 @@
 #include <linux/interrupt.h>
 #include <linux/iopoll.h>
 #include <linux/slab.h>
-#include <linux/xarray.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/amdxdna.h>
@@ -35,9 +34,12 @@
 		      (_chann)->msix_irq, ##args); \
 })
 
+#define MSG_BUF_SZ(chann)					\
+	(mailbox_get_ringbuf_size(chann, CHAN_RES_X2I) +	\
+	 sizeof(struct mailbox_msg))
+
 #define MAGIC_VAL			0x1D000000U
 #define MAGIC_VAL_MASK			0xFF000000
-#define MAX_MSG_ID_ENTRIES		256
 #define MSG_RX_TIMER			200 /* milliseconds */
 #define MAILBOX_NAME			"xdna_mailbox"
 
@@ -57,8 +59,6 @@ struct mailbox_channel {
 	struct xdna_mailbox_chann_res	res[CHAN_RES_NUM];
 	int				msix_irq;
 	u32				iohub_int_addr;
-	struct xarray			chan_xa;
-	u32				next_msgid;
 	u32				x2i_tail;
 
 	/* Received msg related fields */
@@ -66,6 +66,12 @@ struct mailbox_channel {
 	struct work_struct		rx_work;
 	u32				i2x_head;
 	bool				bad_state;
+
+	/* Pre-allocated message buffer pool */
+	void				*msg_buf;
+	u32				msg_buf_num;
+	u32				next_slot; /* next slot index to try for allocation */
+	struct mutex			lock;
 };
 
 #define MSG_BODY_SZ		GENMASK(10, 0)
@@ -90,12 +96,36 @@ struct mailbox_pkg {
 #define TOMBSTONE		0xDEADFACE
 
 struct mailbox_msg {
+	bool			busy;
 	void			*handle;
 	int			(*notify_cb)(void *handle, void __iomem *data, size_t size);
 	size_t			pkg_size; /* package size in bytes */
 	struct mailbox_pkg	pkg;
 };
 
+/*
+ * Clear busy before invoking the callback so that a new submission can
+ * reuse the slot immediately ? by the time notify_cb returns, the caller
+ * may already have submitted a new job that needs this slot.
+ *
+ * notify_cb and handle are cached in locals first. smp_store_release()
+ * ensures those loads complete before busy is cleared ? without it the
+ * compiler or CPU could sink the loads past the store, letting a
+ * concurrent sender overwrite notify_cb/handle before we read them.
+ * Paired with smp_load_acquire() in mailbox_acquire_msgid().
+ */
+static int mailbox_msg_done(struct mailbox_msg *mb_msg, void __iomem *data, size_t size)
+{
+	int (*notify_cb)(void *, void __iomem *, size_t) = mb_msg->notify_cb;
+	void *handle = mb_msg->handle;
+
+	/* Pairs with smp_load_acquire() in mailbox_acquire_msgid(). */
+	smp_store_release(&mb_msg->busy, false);
+	if (notify_cb)
+		return notify_cb(handle, data, size);
+	return 0;
+}
+
 static void mailbox_reg_write(struct mailbox_channel *mb_chann, u32 mbox_reg, u32 data)
 {
 	struct xdna_mailbox_res *mb_res = &mb_chann->mb->res;
@@ -161,38 +191,57 @@ static inline int mailbox_validate_msgid(int msg_id)
 	return (msg_id & MAGIC_VAL_MASK) == MAGIC_VAL;
 }
 
-static int mailbox_acquire_msgid(struct mailbox_channel *mb_chann, struct mailbox_msg *mb_msg)
+static struct mailbox_msg *mailbox_msg_ptr(struct mailbox_channel *mb_chann, u32 slot)
 {
-	u32 msg_id;
-	int ret;
+	return mb_chann->msg_buf + slot * MSG_BUF_SZ(mb_chann);
+}
 
-	ret = xa_alloc_cyclic_irq(&mb_chann->chan_xa, &msg_id, mb_msg,
-				  XA_LIMIT(0, MAX_MSG_ID_ENTRIES - 1),
-				  &mb_chann->next_msgid, GFP_NOWAIT);
-	if (ret < 0)
-		return ret;
+static int mailbox_acquire_msgid(struct mailbox_channel *mb_chann)
+{
+	struct mailbox_msg *mb_msg;
+	u32 slot;
+	u32 i;
 
 	/*
-	 * Add MAGIC_VAL to the higher bits.
+	 * msg_id = slot | MAGIC_VAL. Scan slots starting from next_slot.
+	 * smp_load_acquire() pairs with smp_store_release() in mailbox_msg_done()
+	 * to ensure that once we observe busy == false, notify_cb and handle are
+	 * also visible as their post-completion values before we overwrite them.
 	 */
-	msg_id |= MAGIC_VAL;
-	return msg_id;
-}
+	for (i = 0; i < mb_chann->msg_buf_num; i++) {
+		slot = (mb_chann->next_slot + i) % mb_chann->msg_buf_num;
+		mb_msg = mailbox_msg_ptr(mb_chann, slot);
+		/* Pairs with smp_store_release() in mailbox_msg_done(). */
+		if (!smp_load_acquire(&mb_msg->busy)) {
+			mb_chann->next_slot = (slot + 1) % mb_chann->msg_buf_num;
+			return slot | MAGIC_VAL;
+		}
+	}
 
-static void mailbox_release_msgid(struct mailbox_channel *mb_chann, int msg_id)
-{
-	msg_id &= ~MAGIC_VAL_MASK;
-	xa_erase_irq(&mb_chann->chan_xa, msg_id);
+	return -ENOBUFS;
 }
 
-static void mailbox_release_msg(struct mailbox_channel *mb_chann,
-				struct mailbox_msg *mb_msg)
+static struct mailbox_msg *mailbox_get_msg_buf(struct mailbox_channel *mb_chann,
+					       size_t msg_size)
 {
-	MB_DBG(mb_chann, "msg_id 0x%x msg opcode 0x%x",
-	       mb_msg->pkg.header.id, mb_msg->pkg.header.opcode);
-	if (mb_msg->notify_cb)
-		mb_msg->notify_cb(mb_msg->handle, NULL, 0);
-	kfree(mb_msg);
+	struct mailbox_msg *mb_msg;
+	int msg_id;
+	u32 slot;
+
+	/* msg_id = slot | MAGIC_VAL */
+	msg_id = mailbox_acquire_msgid(mb_chann);
+	if (msg_id < 0) {
+		MB_ERR(mb_chann, "No free message slot");
+		return NULL;
+	}
+
+	slot = msg_id & ~MAGIC_VAL_MASK;
+	mb_msg = mailbox_msg_ptr(mb_chann, slot);
+	memset(mb_msg, 0, msg_size + sizeof(*mb_msg));
+	mb_msg->busy = true;
+	mb_msg->pkg.header.id = msg_id;
+
+	return mb_msg;
 }
 
 static int
@@ -248,8 +297,9 @@ mailbox_get_resp(struct mailbox_channel *mb_chann, struct xdna_msg_header *heade
 		 void __iomem *data)
 {
 	struct mailbox_msg *mb_msg;
-	int msg_id;
 	int ret = 0;
+	int msg_id;
+	u32 slot;
 
 	msg_id = header->id;
 	if (!mailbox_validate_msgid(msg_id)) {
@@ -257,22 +307,25 @@ mailbox_get_resp(struct mailbox_channel *mb_chann, struct xdna_msg_header *heade
 		return -EINVAL;
 	}
 
-	msg_id &= ~MAGIC_VAL_MASK;
-	mb_msg = xa_erase_irq(&mb_chann->chan_xa, msg_id);
-	if (!mb_msg) {
-		MB_ERR(mb_chann, "Cannot find msg 0x%x", msg_id);
+	slot = msg_id & ~MAGIC_VAL_MASK;
+	if (unlikely(slot >= mb_chann->msg_buf_num)) {
+		MB_ERR(mb_chann, "Invalid msg_id 0x%x", msg_id);
 		return -EINVAL;
 	}
+	mb_msg = mailbox_msg_ptr(mb_chann, slot);
 
 	MB_DBG(mb_chann, "opcode 0x%x size %d id 0x%x",
 	       header->opcode, header->total_size, header->id);
-	if (mb_msg->notify_cb) {
-		ret = mb_msg->notify_cb(mb_msg->handle, data, header->total_size);
-		if (unlikely(ret))
-			MB_ERR(mb_chann, "Message callback ret %d", ret);
+
+	if (unlikely(!mb_msg->busy)) {
+		MB_WARN_ONCE(mb_chann, "Unexpected response for idle slot 0x%x", msg_id);
+		return 0;
 	}
 
-	kfree(mb_msg);
+	ret = mailbox_msg_done(mb_msg, data, header->total_size);
+	if (unlikely(ret))
+		MB_ERR(mb_chann, "Message callback ret %d", ret);
+
 	return ret;
 }
 
@@ -398,8 +451,33 @@ static void mailbox_rx_worker(struct work_struct *rx_work)
 		goto again;
 }
 
+static int xdna_mailbox_wait_ack(struct mailbox_channel *mb_chann, u64 tx_timeout_ms)
+{
+	u32 tail = mb_chann->x2i_tail;
+	u32 head;
+	int ret;
+
+	/*
+	 * Poll until firmware advances the head pointer past our message,
+	 * confirming it has consumed (acknowledged) the send.
+	 */
+	ret = read_poll_timeout(mailbox_get_headptr, head,
+				head == tail, 1000, tx_timeout_ms * 1000,
+				false, mb_chann, CHAN_RES_X2I);
+	/*
+	 * A timeout here means firmware has not yet consumed the message, but
+	 * it has already been published to the ring buffer. Returning an error
+	 * would mislead the caller into thinking the send failed and freeing
+	 * resources that firmware may still DMA into. Log and treat as success.
+	 */
+	if (ret)
+		MB_WARN_ONCE(mb_chann, "Wait for ack timeout");
+
+	return 0;
+}
+
 int xdna_mailbox_send_msg(struct mailbox_channel *mb_chann,
-			  const struct xdna_mailbox_msg *msg, u64 tx_timeout)
+			  const struct xdna_mailbox_msg *msg, u64 tx_timeout_ms)
 {
 	struct xdna_msg_header *header;
 	struct mailbox_msg *mb_msg;
@@ -428,9 +506,12 @@ int xdna_mailbox_send_msg(struct mailbox_channel *mb_chann,
 		return -EPIPE;
 	}
 
-	mb_msg = kzalloc(sizeof(*mb_msg) + pkg_size, GFP_KERNEL);
-	if (!mb_msg)
-		return -ENOMEM;
+	mutex_lock(&mb_chann->lock);
+	mb_msg = mailbox_get_msg_buf(mb_chann, pkg_size);
+	if (!mb_msg) {
+		mutex_unlock(&mb_chann->lock);
+		return -ENOBUFS;
+	}
 
 	mb_msg->handle = msg->handle;
 	mb_msg->notify_cb = msg->notify_cb;
@@ -447,28 +528,21 @@ int xdna_mailbox_send_msg(struct mailbox_channel *mb_chann,
 	header->opcode = msg->opcode;
 	memcpy(mb_msg->pkg.payload, msg->send_data, msg->send_size);
 
-	ret = mailbox_acquire_msgid(mb_chann, mb_msg);
-	if (unlikely(ret < 0)) {
-		MB_ERR(mb_chann, "mailbox_acquire_msgid failed");
-		goto msg_id_failed;
-	}
-	header->id = ret;
-
 	MB_DBG(mb_chann, "opcode 0x%x size %d id 0x%x",
 	       header->opcode, header->total_size, header->id);
 
 	ret = mailbox_send_msg(mb_chann, mb_msg);
 	if (ret) {
 		MB_DBG(mb_chann, "Error in mailbox send msg, ret %d", ret);
-		goto release_id;
+		mb_msg->busy = false;
+		mutex_unlock(&mb_chann->lock);
+		return ret;
 	}
+	mutex_unlock(&mb_chann->lock);
 
-	return 0;
+	if (tx_timeout_ms)
+		ret = xdna_mailbox_wait_ack(mb_chann, tx_timeout_ms);
 
-release_id:
-	mailbox_release_msgid(mb_chann, header->id);
-msg_id_failed:
-	kfree(mb_msg);
 	return ret;
 }
 
@@ -487,6 +561,7 @@ struct mailbox_channel *xdna_mailbox_alloc_channel(struct mailbox *mb)
 		goto free_chann;
 	}
 	mb_chann->mb = mb;
+	mutex_init(&mb_chann->lock);
 
 	return mb_chann;
 
@@ -500,7 +575,9 @@ void xdna_mailbox_free_channel(struct mailbox_channel *mb_chann)
 	if (!mb_chann)
 		return;
 
+	kfree(mb_chann->msg_buf);
 	destroy_workqueue(mb_chann->work_q);
+	mutex_destroy(&mb_chann->lock);
 	kfree(mb_chann);
 }
 
@@ -509,7 +586,7 @@ xdna_mailbox_start_channel(struct mailbox_channel *mb_chann,
 			   const struct xdna_mailbox_chann_res *x2i,
 			   const struct xdna_mailbox_chann_res *i2x,
 			   u32 iohub_int_addr,
-			   int mb_irq)
+			   int mb_irq, u32 n_msg)
 {
 	int ret;
 
@@ -523,7 +600,16 @@ xdna_mailbox_start_channel(struct mailbox_channel *mb_chann,
 	memcpy(&mb_chann->res[CHAN_RES_X2I], x2i, sizeof(*x2i));
 	memcpy(&mb_chann->res[CHAN_RES_I2X], i2x, sizeof(*i2x));
 
-	xa_init_flags(&mb_chann->chan_xa, XA_FLAGS_ALLOC | XA_FLAGS_LOCK_IRQ);
+	/*
+	 * msg_buf is a flat array of n_msg slots, separate from the hardware
+	 * ring buffer. Each slot is rb_size bytes ? the combined size of the
+	 * mailbox_msg metadata and the package payload must not exceed rb_size.
+	 */
+	mb_chann->msg_buf = kcalloc(n_msg, MSG_BUF_SZ(mb_chann), GFP_KERNEL);
+	if (!mb_chann->msg_buf)
+		return -ENOMEM;
+
+	mb_chann->msg_buf_num = n_msg;
 	mb_chann->x2i_tail = mailbox_get_tailptr(mb_chann, CHAN_RES_X2I);
 	mb_chann->i2x_head = mailbox_get_headptr(mb_chann, CHAN_RES_I2X);
 
@@ -531,6 +617,8 @@ xdna_mailbox_start_channel(struct mailbox_channel *mb_chann,
 	ret = request_irq(mb_irq, mailbox_irq_handler, 0, MAILBOX_NAME, mb_chann);
 	if (ret) {
 		MB_ERR(mb_chann, "Failed to request irq %d ret %d", mb_irq, ret);
+		kfree(mb_chann->msg_buf);
+		mb_chann->msg_buf = NULL;
 		return ret;
 	}
 
@@ -544,7 +632,7 @@ xdna_mailbox_start_channel(struct mailbox_channel *mb_chann,
 void xdna_mailbox_stop_channel(struct mailbox_channel *mb_chann)
 {
 	struct mailbox_msg *mb_msg;
-	unsigned long msg_id;
+	u32 i;
 
 	if (!mb_chann)
 		return;
@@ -555,12 +643,22 @@ void xdna_mailbox_stop_channel(struct mailbox_channel *mb_chann)
 	/* Cancel RX work and wait for it to finish */
 	drain_workqueue(mb_chann->work_q);
 
-	/* We can clean up and release resources */
-	xa_for_each_start(&mb_chann->chan_xa, msg_id, mb_msg, mb_chann->next_msgid)
-		mailbox_release_msg(mb_chann, mb_msg);
-	xa_for_each_range(&mb_chann->chan_xa, msg_id, mb_msg, 0, mb_chann->next_msgid - 1)
-		mailbox_release_msg(mb_chann, mb_msg);
-	xa_destroy(&mb_chann->chan_xa);
+	/* Release any in-flight messages in the pool
+	 *
+	 * Drain in submission order: next_slot points to the slot after
+	 * the most recently assigned one, so start from next_slot and
+	 * wrap around so callbacks fire oldest-first.
+	 */
+	for (i = 0; i < mb_chann->msg_buf_num; i++) {
+		u32 slot = (mb_chann->next_slot + i) % mb_chann->msg_buf_num;
+
+		mb_msg = mailbox_msg_ptr(mb_chann, slot);
+		if (!mb_msg->busy)
+			continue;
+		MB_DBG(mb_chann, "msg_id 0x%x msg opcode 0x%x",
+		       mb_msg->pkg.header.id, mb_msg->pkg.header.opcode);
+		mailbox_msg_done(mb_msg, NULL, 0);
+	}
 
 	MB_DBG(mb_chann, "Mailbox channel stopped, irq: %d", mb_chann->msix_irq);
 }
diff --git a/drivers/accel/amdxdna/amdxdna_mailbox.h b/drivers/accel/amdxdna/amdxdna_mailbox.h
index 2908404303ae..cb6d5634e61d 100644
--- a/drivers/accel/amdxdna/amdxdna_mailbox.h
+++ b/drivers/accel/amdxdna/amdxdna_mailbox.h
@@ -88,6 +88,10 @@ struct mailbox_channel *xdna_mailbox_alloc_channel(struct mailbox *mb);
  * @i2x: firmware to host mailbox resources
  * @xdna_mailbox_intr_reg: register addr of MSI-X interrupt
  * @mb_irq: Linux IRQ number associated with mailbox MSI-X interrupt vector index
+ * @n_msg: number of message slots to pre-allocate; must be non-zero for
+ *         the PCI transport (the platform transport ignores this argument).
+ *         Each slot is rb_size bytes. The caller must ensure at most n_msg
+ *         messages are in flight at any time.
  *
  * Return: If success, return a handle of mailbox channel. Otherwise, return NULL.
  */
@@ -96,7 +100,7 @@ xdna_mailbox_start_channel(struct mailbox_channel *mb_chann,
 			   const struct xdna_mailbox_chann_res *x2i,
 			   const struct xdna_mailbox_chann_res *i2x,
 			   u32 xdna_mailbox_intr_reg,
-			   int mb_irq);
+			   int mb_irq, u32 n_msg);
 
 /*
  * xdna_mailbox_free_channel() -- free mailbox channel
@@ -117,11 +121,11 @@ void xdna_mailbox_stop_channel(struct mailbox_channel *mailbox_chann);
  *
  * @mailbox_chann: Mailbox channel handle
  * @msg: message struct for message information
- * @tx_timeout: the timeout value for sending the message in ms.
+ * @tx_timeout_ms: the timeout value for sending the message in ms.
  *
  * Return: If success return 0, otherwise, return error code
  */
 int xdna_mailbox_send_msg(struct mailbox_channel *mailbox_chann,
-			  const struct xdna_mailbox_msg *msg, u64 tx_timeout);
+			  const struct xdna_mailbox_msg *msg, u64 tx_timeout_ms);
 
 #endif /* _AIE_MAILBOX_ */
diff --git a/drivers/accel/amdxdna/amdxdna_mailbox_helper.c b/drivers/accel/amdxdna/amdxdna_mailbox_helper.c
index 6d0c24513476..d5ce8d6c1a51 100644
--- a/drivers/accel/amdxdna/amdxdna_mailbox_helper.c
+++ b/drivers/accel/amdxdna/amdxdna_mailbox_helper.c
@@ -44,7 +44,7 @@ int xdna_send_msg_wait(struct amdxdna_dev *xdna, struct mailbox_channel *chann,
 	struct xdna_notify *hdl = msg->handle;
 	int ret;
 
-	ret = xdna_mailbox_send_msg(chann, msg, TX_TIMEOUT);
+	ret = xdna_mailbox_send_msg(chann, msg, 0);
 	if (ret) {
 		XDNA_ERR(xdna, "Send message failed, ret %d", ret);
 		return ret;
-- 
2.34.1

