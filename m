Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D706FB5EBC
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 04:49:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E1718918D;
	Tue, 17 Mar 2026 04:49:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E/3RRUHl";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012032.outbound.protection.outlook.com [52.101.43.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACF1B10E343
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 04:49:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VqYRmHyt0LyUdYkUVnbSTtoIuR+xa6T/GyWru51Y1rA3SSfQvgtfSQpKS29ie2QUWruHquZsm6HpDDwTXxeLb8Yfe1LsniswsNNMRbThX9yxRKcMITG2paR0vdOXWpQpMYbUkJy0F41HamngwC/Oh2hVtnuhOgs1pSW3dXGrprBN8rNygrHZ4LJy7DQVz30NfoyX95s6tQzsfgJRi7HF+tIo2WGTtJUoanAapFb4UdLzxNqvfTgHa11+EE0/0vp1lV9oXPPfm4X/W7pv/3BLe17yjnNxxtLpRFYrEmD4QOWOy3yuZOTYSG2TFZEkcBHS83Kv8D2n80yxFNQqaZblgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KC04QrIF2pu/QLeFv7uMcS/wFN8Ri3Uq4KiWS2WHG9g=;
 b=WgWp17hSL/notnLMmG8+CcW6/Ahb5n0dJLHDhjOforHOFfP11cIUAH/Da6+7+pe5lx7Br8KsfYjkwEM3O3wGIxvBkhVx+1tMD1viw5XUraA/4C8fAm3GXxjlQP0qp66xpDOOwCOW+kBPU/1YSyBywYeBWkseERDc9RCIhpe8kFTUwUBSjFcfFFqXlkTw2Z37Sqby22Blmy54gvz7dMm+OKAiwiIoSHt/UAr8HKdbl150HVIYY0WaI3kd2giE8jcWmMlj8g8NWtPjGJwFrgw5oKIdhpftr2rIG+TNGkEBq7QIX8KhR2Z/qxIr+gfOtOkVCfgqTEYWGAWLDet+44hWkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KC04QrIF2pu/QLeFv7uMcS/wFN8Ri3Uq4KiWS2WHG9g=;
 b=E/3RRUHlk6evquT/6pzX35YFRU6WqKNt9WqTAH2NlSEFSJ1zvvwS5RhOWjKiwP6CKtqBWmy5j2ikACGXyae7/Jq5gedwBTOnERhfSd1aa95HWeM5EkXpmz4DnZh1p4RA0vGrJp0z8IzsrRwVDp0FsiRGiQvacKjwvD5XjRE/dlQ=
Received: from SN7PR04CA0072.namprd04.prod.outlook.com (2603:10b6:806:121::17)
 by BN7PPF2E18BD747.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6ca) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Tue, 17 Mar
 2026 04:49:11 +0000
Received: from SA2PEPF00003AE5.namprd02.prod.outlook.com
 (2603:10b6:806:121:cafe::70) by SN7PR04CA0072.outlook.office365.com
 (2603:10b6:806:121::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.25 via Frontend Transport; Tue,
 17 Mar 2026 04:48:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE5.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 04:49:10 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 16 Mar
 2026 23:49:10 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Mar
 2026 23:49:09 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 16 Mar 2026 23:49:09 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <maciej.falkowski@linux.intel.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <max.zhen@amd.com>, <sonal.santan@amd.com>
Subject: [PATCH V2] accel/amdxdna: Support retrieving hardware context debug
 information
Date: Mon, 16 Mar 2026 21:49:06 -0700
Message-ID: <20260317044906.1513133-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE5:EE_|BN7PPF2E18BD747:EE_
X-MS-Office365-Filtering-Correlation-Id: c18d27e8-1cb9-4f13-6554-08de83e087b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: sAm0ucevVr1tGpvG57mpjrndv5JZ2C2b/IA6Rlsj6wPm/UwZDKQS6OLh2n1rIo0UxN2AFl/hxM0LTRahbX6CC1fWlZRndcf/SEc6nY2wNarrsgZ1BUfBrAzW+tAtD4beZr1r62nqAkNyPc122K6hVUyY6WLGblcuTSRoZpJywNVt4ooNX5mlZkHUw2RZi2b146F08NW0+pdho+cwcJydo4FzspwHZp5piNZQ4FIrPhN4dgjpd5Z0TZ06JUYURFNZEiSYjnpQxskGBPDURxN2gdZIaxv32ArEHjyzNp4ZlNiVqpxN0k3i6MfBmClkPsHQmupvP2CV65ter0YfMVMdDyV3Xy6UcuimbZfH7WfF+d/vnH2LYpXhSiEBnNQt+bb6/0yfTjoR2lhOeAVlumm7Fd56Tzb1XYXaX5prYjAhWwBgZOpQFAlww6FDBY4OPJ91eOuKZ7NqqcrajSOPxHsYGMtFmwME6HGvqiaEDSFKApkXJRRUHgAoaVf1RWuQVutezR8v6YgyiueRgothTmcUbWIFKm9yaI9Y+bE0V5F2M9pvXZj9vYX7AtO8GM4J8QjfwM/olb5ZRfQTzQXV/2XUldNSK+gsWWUTxYZjbQkzclKS9dOXUW8Y2XgxmxgbvVHUBJ8xFFsq6FworYDygxpxsmQUA6Tq89Hr9ko1HxF8idmGw2huIdpLFH3jp7Mc7iQgnyCMxbTxaC7p0ls6dDSVLd/Pdt8UlJEUbno3ESj8WyPdoLUSwUpXP8Src8sDy2m5w3mp/uBLXnFPCi1rQ0u5Cw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4QIqNy4m2x+oyQ4zipMAdwplXZzTYuMBbK9eLMHCgBHyAVWZraUIEvhkj8D+ApaejxrTEypizOj+6xtd/lgdfvNwv5wyA8wP0ErKPUWenpoiwhyxMx5UAiT08dLuCqaNyIYj9FiQdlbHO+fWNTKH6uAn2Rsaew3ssgkYwKSkokgcTKWgQh6Twv23YCjumtjFThsTqNgBRFpx+VexkvZ+SI5YwGUn6BIjRsKNmGTPs+ZfI4L37WzGLX8AweElaMBYMHhmdvadFs8PF/+4EYI7e3cz6VI4PkOdpoRmcGEofSYZpyijWVvOax29zzzOR1YZeDxWJEQmpbBCosGlXFyHKEfku1blYAQ2Q6CHeHNAMop07Ja8ezbRqfbztFYCDD9BIu3ZqxNLik7opjH+okWHAsDQoGx70gv6ZlqW1BwF8FX2h0vgQGO8dQHBOWiCRMbf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 04:49:10.5374 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c18d27e8-1cb9-4f13-6554-08de83e087b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF2E18BD747
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

The firmware implements the GET_APP_HEALTH command to collect debug
information for a specific hardware context.

When a command times out, the driver issues this command to collect the
relevant debug information. User space tools can also retrieve this
information through the hardware context query IOCTL.

Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/aie2_ctx.c      | 85 ++++++++++++++++++++++++---
 drivers/accel/amdxdna/aie2_message.c  | 41 +++++++++++++
 drivers/accel/amdxdna/aie2_msg_priv.h | 52 ++++++++++++++++
 drivers/accel/amdxdna/aie2_pci.c      | 14 +++++
 drivers/accel/amdxdna/aie2_pci.h      |  5 ++
 drivers/accel/amdxdna/amdxdna_ctx.c   |  6 +-
 drivers/accel/amdxdna/amdxdna_ctx.h   | 18 +++++-
 drivers/accel/amdxdna/npu4_regs.c     |  3 +-
 8 files changed, 213 insertions(+), 11 deletions(-)

diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
index 779ac70d62d7..6292349868c5 100644
--- a/drivers/accel/amdxdna/aie2_ctx.c
+++ b/drivers/accel/amdxdna/aie2_ctx.c
@@ -29,6 +29,16 @@ MODULE_PARM_DESC(force_cmdlist, "Force use command list (Default true)");
 
 #define HWCTX_MAX_TIMEOUT	60000 /* milliseconds */
 
+struct aie2_ctx_health {
+	struct amdxdna_ctx_health header;
+	u32 txn_op_idx;
+	u32 ctx_pc;
+	u32 fatal_error_type;
+	u32 fatal_error_exception_type;
+	u32 fatal_error_exception_pc;
+	u32 fatal_error_app_module;
+};
+
 static void aie2_job_release(struct kref *ref)
 {
 	struct amdxdna_sched_job *job;
@@ -39,6 +49,7 @@ static void aie2_job_release(struct kref *ref)
 	wake_up(&job->hwctx->priv->job_free_wq);
 	if (job->out_fence)
 		dma_fence_put(job->out_fence);
+	kfree(job->aie2_job_health);
 	kfree(job);
 }
 
@@ -176,6 +187,50 @@ aie2_sched_notify(struct amdxdna_sched_job *job)
 	aie2_job_put(job);
 }
 
+static void aie2_set_cmd_timeout(struct amdxdna_sched_job *job)
+{
+	struct aie2_ctx_health *aie2_health __free(kfree) = NULL;
+	struct amdxdna_dev *xdna = job->hwctx->client->xdna;
+	struct amdxdna_gem_obj *cmd_abo = job->cmd_bo;
+	struct app_health_report *report = job->aie2_job_health;
+	u32 fail_cmd_idx = 0;
+
+	if (!report)
+		goto set_timeout;
+
+	XDNA_ERR(xdna, "Firmware timeout state capture:");
+	XDNA_ERR(xdna, "\tVersion: %d.%d", report->major, report->minor);
+	XDNA_ERR(xdna, "\tReport size: 0x%x", report->size);
+	XDNA_ERR(xdna, "\tContext ID: %d", report->context_id);
+	XDNA_ERR(xdna, "\tDPU PC: 0x%x", report->dpu_pc);
+	XDNA_ERR(xdna, "\tTXN OP ID: 0x%x", report->txn_op_id);
+	XDNA_ERR(xdna, "\tContext PC: 0x%x", report->ctx_pc);
+	XDNA_ERR(xdna, "\tFatal error type: 0x%x", report->fatal_info.fatal_type);
+	XDNA_ERR(xdna, "\tFatal error exception type: 0x%x", report->fatal_info.exception_type);
+	XDNA_ERR(xdna, "\tFatal error exception PC: 0x%x", report->fatal_info.exception_pc);
+	XDNA_ERR(xdna, "\tFatal error app module: 0x%x", report->fatal_info.app_module);
+	XDNA_ERR(xdna, "\tFatal error task ID: %d", report->fatal_info.task_index);
+	XDNA_ERR(xdna, "\tTimed out sub command ID: %d", report->run_list_id);
+
+	fail_cmd_idx = report->run_list_id;
+	aie2_health = kzalloc_obj(*aie2_health);
+	if (!aie2_health)
+		goto set_timeout;
+
+	aie2_health->header.version = AMDXDNA_CMD_CTX_HEALTH_V1;
+	aie2_health->header.npu_gen = AMDXDNA_CMD_CTX_HEALTH_AIE2;
+	aie2_health->txn_op_idx = report->txn_op_id;
+	aie2_health->ctx_pc = report->ctx_pc;
+	aie2_health->fatal_error_type = report->fatal_info.fatal_type;
+	aie2_health->fatal_error_exception_type = report->fatal_info.exception_type;
+	aie2_health->fatal_error_exception_pc = report->fatal_info.exception_pc;
+	aie2_health->fatal_error_app_module = report->fatal_info.app_module;
+
+set_timeout:
+	amdxdna_cmd_set_error(cmd_abo, job, fail_cmd_idx, ERT_CMD_STATE_TIMEOUT,
+			      aie2_health, sizeof(*aie2_health));
+}
+
 static int
 aie2_sched_resp_handler(void *handle, void __iomem *data, size_t size)
 {
@@ -187,13 +242,13 @@ aie2_sched_resp_handler(void *handle, void __iomem *data, size_t size)
 	cmd_abo = job->cmd_bo;
 
 	if (unlikely(job->job_timeout)) {
-		amdxdna_cmd_set_error(cmd_abo, job, 0, ERT_CMD_STATE_TIMEOUT);
+		aie2_set_cmd_timeout(job);
 		ret = -EINVAL;
 		goto out;
 	}
 
 	if (unlikely(!data) || unlikely(size != sizeof(u32))) {
-		amdxdna_cmd_set_error(cmd_abo, job, 0, ERT_CMD_STATE_ABORT);
+		amdxdna_cmd_set_error(cmd_abo, job, 0, ERT_CMD_STATE_ABORT, NULL, 0);
 		ret = -EINVAL;
 		goto out;
 	}
@@ -203,7 +258,7 @@ aie2_sched_resp_handler(void *handle, void __iomem *data, size_t size)
 	if (status == AIE2_STATUS_SUCCESS)
 		amdxdna_cmd_set_state(cmd_abo, ERT_CMD_STATE_COMPLETED);
 	else
-		amdxdna_cmd_set_error(cmd_abo, job, 0, ERT_CMD_STATE_ERROR);
+		amdxdna_cmd_set_error(cmd_abo, job, 0, ERT_CMD_STATE_ERROR, NULL, 0);
 
 out:
 	aie2_sched_notify(job);
@@ -237,21 +292,21 @@ aie2_sched_cmdlist_resp_handler(void *handle, void __iomem *data, size_t size)
 	struct amdxdna_sched_job *job = handle;
 	struct amdxdna_gem_obj *cmd_abo;
 	struct amdxdna_dev *xdna;
+	u32 fail_cmd_idx = 0;
 	u32 fail_cmd_status;
-	u32 fail_cmd_idx;
 	u32 cmd_status;
 	int ret = 0;
 
 	cmd_abo = job->cmd_bo;
 
 	if (unlikely(job->job_timeout)) {
-		amdxdna_cmd_set_error(cmd_abo, job, 0, ERT_CMD_STATE_TIMEOUT);
+		aie2_set_cmd_timeout(job);
 		ret = -EINVAL;
 		goto out;
 	}
 
 	if (unlikely(!data) || unlikely(size != sizeof(u32) * 3)) {
-		amdxdna_cmd_set_error(cmd_abo, job, 0, ERT_CMD_STATE_ABORT);
+		amdxdna_cmd_set_error(cmd_abo, job, 0, ERT_CMD_STATE_ABORT, NULL, 0);
 		ret = -EINVAL;
 		goto out;
 	}
@@ -271,10 +326,10 @@ aie2_sched_cmdlist_resp_handler(void *handle, void __iomem *data, size_t size)
 		 fail_cmd_idx, fail_cmd_status);
 
 	if (fail_cmd_status == AIE2_STATUS_SUCCESS) {
-		amdxdna_cmd_set_error(cmd_abo, job, fail_cmd_idx, ERT_CMD_STATE_ABORT);
+		amdxdna_cmd_set_error(cmd_abo, job, fail_cmd_idx, ERT_CMD_STATE_ABORT, NULL, 0);
 		ret = -EINVAL;
 	} else {
-		amdxdna_cmd_set_error(cmd_abo, job, fail_cmd_idx, ERT_CMD_STATE_ERROR);
+		amdxdna_cmd_set_error(cmd_abo, job, fail_cmd_idx, ERT_CMD_STATE_ERROR, NULL, 0);
 	}
 
 out:
@@ -363,12 +418,26 @@ aie2_sched_job_timedout(struct drm_sched_job *sched_job)
 {
 	struct amdxdna_sched_job *job = drm_job_to_xdna_job(sched_job);
 	struct amdxdna_hwctx *hwctx = job->hwctx;
+	struct app_health_report *report;
 	struct amdxdna_dev *xdna;
+	int ret;
 
 	xdna = hwctx->client->xdna;
 	trace_xdna_job(sched_job, hwctx->name, "job timedout", job->seq);
 	job->job_timeout = true;
+
 	mutex_lock(&xdna->dev_lock);
+	report = kzalloc_obj(*report);
+	if (!report)
+		goto reset_hwctx;
+
+	ret = aie2_query_app_health(xdna->dev_handle, hwctx->fw_ctx_id, report);
+	if (ret)
+		kfree(report);
+	else
+		job->aie2_job_health = report;
+
+reset_hwctx:
 	aie2_hwctx_stop(xdna, hwctx, sched_job);
 
 	aie2_hwctx_restart(xdna, hwctx);
diff --git a/drivers/accel/amdxdna/aie2_message.c b/drivers/accel/amdxdna/aie2_message.c
index 798128b6b7b7..4ec591306854 100644
--- a/drivers/accel/amdxdna/aie2_message.c
+++ b/drivers/accel/amdxdna/aie2_message.c
@@ -1185,3 +1185,44 @@ int aie2_config_debug_bo(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *
 
 	return xdna_mailbox_send_msg(chann, &msg, TX_TIMEOUT);
 }
+
+int aie2_query_app_health(struct amdxdna_dev_hdl *ndev, u32 context_id,
+			  struct app_health_report *report)
+{
+	DECLARE_AIE2_MSG(get_app_health, MSG_OP_GET_APP_HEALTH);
+	struct amdxdna_dev *xdna = ndev->xdna;
+	struct app_health_report *buf;
+	dma_addr_t dma_addr;
+	u32 buf_size;
+	int ret;
+
+	if (!AIE2_FEATURE_ON(ndev, AIE2_APP_HEALTH)) {
+		XDNA_DBG(xdna, "App health feature not supported");
+		return -EOPNOTSUPP;
+	}
+
+	buf_size = sizeof(*report);
+	buf = aie2_alloc_msg_buffer(ndev, &buf_size, &dma_addr);
+	if (IS_ERR(buf)) {
+		XDNA_ERR(xdna, "Failed to allocate buffer for app health");
+		return PTR_ERR(buf);
+	}
+
+	req.buf_addr = dma_addr;
+	req.context_id = context_id;
+	req.buf_size = buf_size;
+
+	drm_clflush_virt_range(buf, sizeof(*report));
+	ret = aie2_send_mgmt_msg_wait(ndev, &msg);
+	if (ret) {
+		XDNA_ERR(xdna, "Get app health failed, ret %d status 0x%x", ret, resp.status);
+		goto free_buf;
+	}
+
+	/* Copy the report to caller's buffer */
+	memcpy(report, buf, sizeof(*report));
+
+free_buf:
+	aie2_free_msg_buffer(ndev, buf_size, buf, dma_addr);
+	return ret;
+}
diff --git a/drivers/accel/amdxdna/aie2_msg_priv.h b/drivers/accel/amdxdna/aie2_msg_priv.h
index 728ef56f7f0a..f18e89a39e35 100644
--- a/drivers/accel/amdxdna/aie2_msg_priv.h
+++ b/drivers/accel/amdxdna/aie2_msg_priv.h
@@ -31,6 +31,7 @@ enum aie2_msg_opcode {
 	MSG_OP_SET_RUNTIME_CONFIG          = 0x10A,
 	MSG_OP_GET_RUNTIME_CONFIG          = 0x10B,
 	MSG_OP_REGISTER_ASYNC_EVENT_MSG    = 0x10C,
+	MSG_OP_GET_APP_HEALTH              = 0x114,
 	MSG_OP_MAX_DRV_OPCODE,
 	MSG_OP_GET_PROTOCOL_VERSION        = 0x301,
 	MSG_OP_MAX_OPCODE
@@ -451,4 +452,55 @@ struct config_debug_bo_req {
 struct config_debug_bo_resp {
 	enum aie2_msg_status	status;
 } __packed;
+
+struct fatal_error_info {
+	__u32 fatal_type;         /* Fatal error type */
+	__u32 exception_type;     /* Only valid if fatal_type is a specific value */
+	__u32 exception_argument; /* Argument based on exception type */
+	__u32 exception_pc;       /* Program Counter at the time of the exception */
+	__u32 app_module;         /* Error module name */
+	__u32 task_index;         /* Index of the task in which the error occurred */
+	__u32 reserved[128];
+};
+
+struct app_health_report {
+	__u16 major;
+	__u16 minor;
+	__u32 size;
+	__u32 context_id;
+	/*
+	 * Program Counter (PC) of the last initiated DPU opcode, as reported by the ERT
+	 * application. Before execution begins or after successful completion, the value is set
+	 * to UINT_MAX. If execution halts prematurely due to an error, this field retains the
+	 * opcode's PC value.
+	 * Note: To optimize performance, the ERT may simplify certain aspects of reporting.
+	 * Proper interpretation requires familiarity with the implementation details.
+	 */
+	__u32 dpu_pc;
+	/*
+	 * Index of the last initiated TXN opcode.
+	 * Before execution starts or after successful completion, the value is set to UINT_MAX.
+	 * If execution halts prematurely due to an error, this field retains the opcode's ID.
+	 * Note: To optimize performance, the ERT may simplify certain aspects of reporting.
+	 * Proper interpretation requires familiarity with the implementation details.
+	 */
+	__u32 txn_op_id;
+	/* The PC of the context at the time of the report */
+	__u32 ctx_pc;
+	struct fatal_error_info		fatal_info;
+	/* Index of the most recently executed run list entry. */
+	__u32 run_list_id;
+};
+
+struct get_app_health_req {
+	__u32 context_id;
+	__u32 buf_size;
+	__u64 buf_addr;
+} __packed;
+
+struct get_app_health_resp {
+	enum aie2_msg_status status;
+	__u32 required_buffer_size;
+	__u32 reserved[7];
+} __packed;
 #endif /* _AIE2_MSG_PRIV_H_ */
diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
index ddd3d82f3426..9e39bfe75971 100644
--- a/drivers/accel/amdxdna/aie2_pci.c
+++ b/drivers/accel/amdxdna/aie2_pci.c
@@ -846,7 +846,10 @@ static int aie2_hwctx_status_cb(struct amdxdna_hwctx *hwctx, void *arg)
 	struct amdxdna_drm_hwctx_entry *tmp __free(kfree) = NULL;
 	struct amdxdna_drm_get_array *array_args = arg;
 	struct amdxdna_drm_hwctx_entry __user *buf;
+	struct app_health_report report;
+	struct amdxdna_dev_hdl *ndev;
 	u32 size;
+	int ret;
 
 	if (!array_args->num_element)
 		return -EINVAL;
@@ -869,6 +872,17 @@ static int aie2_hwctx_status_cb(struct amdxdna_hwctx *hwctx, void *arg)
 	tmp->latency = hwctx->qos.latency;
 	tmp->frame_exec_time = hwctx->qos.frame_exec_time;
 	tmp->state = AMDXDNA_HWCTX_STATE_ACTIVE;
+	ndev = hwctx->client->xdna->dev_handle;
+	ret = aie2_query_app_health(ndev, hwctx->fw_ctx_id, &report);
+	if (!ret) {
+		/* Fill in app health report fields */
+		tmp->txn_op_idx = report.txn_op_id;
+		tmp->ctx_pc = report.ctx_pc;
+		tmp->fatal_error_type = report.fatal_info.fatal_type;
+		tmp->fatal_error_exception_type = report.fatal_info.exception_type;
+		tmp->fatal_error_exception_pc = report.fatal_info.exception_pc;
+		tmp->fatal_error_app_module = report.fatal_info.app_module;
+	}
 
 	buf = u64_to_user_ptr(array_args->buffer);
 	size = min(sizeof(*tmp), array_args->element_size);
diff --git a/drivers/accel/amdxdna/aie2_pci.h b/drivers/accel/amdxdna/aie2_pci.h
index 885ae7e6bfc7..efcf4be035f0 100644
--- a/drivers/accel/amdxdna/aie2_pci.h
+++ b/drivers/accel/amdxdna/aie2_pci.h
@@ -10,6 +10,7 @@
 #include <linux/limits.h>
 #include <linux/semaphore.h>
 
+#include "aie2_msg_priv.h"
 #include "amdxdna_mailbox.h"
 
 #define AIE2_INTERVAL	20000	/* us */
@@ -261,6 +262,7 @@ enum aie2_fw_feature {
 	AIE2_NPU_COMMAND,
 	AIE2_PREEMPT,
 	AIE2_TEMPORAL_ONLY,
+	AIE2_APP_HEALTH,
 	AIE2_FEATURE_MAX
 };
 
@@ -271,6 +273,7 @@ struct aie2_fw_feature_tbl {
 	u32 min_minor;
 };
 
+#define AIE2_ALL_FEATURES	GENMASK_ULL(AIE2_FEATURE_MAX - 1, AIE2_NPU_COMMAND)
 #define AIE2_FEATURE_ON(ndev, feature)	test_bit(feature, &(ndev)->feature_mask)
 
 struct amdxdna_dev_priv {
@@ -341,6 +344,8 @@ int aie2_query_aie_version(struct amdxdna_dev_hdl *ndev, struct aie_version *ver
 int aie2_query_aie_metadata(struct amdxdna_dev_hdl *ndev, struct aie_metadata *metadata);
 int aie2_query_firmware_version(struct amdxdna_dev_hdl *ndev,
 				struct amdxdna_fw_ver *fw_ver);
+int aie2_query_app_health(struct amdxdna_dev_hdl *ndev, u32 context_id,
+			  struct app_health_report *report);
 int aie2_create_context(struct amdxdna_dev_hdl *ndev, struct amdxdna_hwctx *hwctx);
 int aie2_destroy_context(struct amdxdna_dev_hdl *ndev, struct amdxdna_hwctx *hwctx);
 int aie2_map_host_buf(struct amdxdna_dev_hdl *ndev, u32 context_id, u64 addr, u64 size);
diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/amdxdna_ctx.c
index 666dfd7b2a80..4b921715176d 100644
--- a/drivers/accel/amdxdna/amdxdna_ctx.c
+++ b/drivers/accel/amdxdna/amdxdna_ctx.c
@@ -137,7 +137,8 @@ u32 amdxdna_cmd_get_cu_idx(struct amdxdna_gem_obj *abo)
 
 int amdxdna_cmd_set_error(struct amdxdna_gem_obj *abo,
 			  struct amdxdna_sched_job *job, u32 cmd_idx,
-			  enum ert_cmd_state error_state)
+			  enum ert_cmd_state error_state,
+			  void *err_data, size_t size)
 {
 	struct amdxdna_client *client = job->hwctx->client;
 	struct amdxdna_cmd *cmd = abo->mem.kva;
@@ -156,6 +157,9 @@ int amdxdna_cmd_set_error(struct amdxdna_gem_obj *abo,
 	}
 
 	memset(cmd->data, 0xff, abo->mem.size - sizeof(*cmd));
+	if (err_data)
+		memcpy(cmd->data, err_data, min(size, abo->mem.size - sizeof(*cmd)));
+
 	if (cc)
 		amdxdna_gem_put_obj(abo);
 
diff --git a/drivers/accel/amdxdna/amdxdna_ctx.h b/drivers/accel/amdxdna/amdxdna_ctx.h
index fbdf9d000871..57db1527a93b 100644
--- a/drivers/accel/amdxdna/amdxdna_ctx.h
+++ b/drivers/accel/amdxdna/amdxdna_ctx.h
@@ -72,6 +72,13 @@ struct amdxdna_cmd_preempt_data {
 	u32 prop_args[];    /* properties and regular kernel arguments */
 };
 
+#define AMDXDNA_CMD_CTX_HEALTH_V1	1
+#define AMDXDNA_CMD_CTX_HEALTH_AIE2	0
+struct amdxdna_ctx_health {
+	u32 version;
+	u32 npu_gen;
+};
+
 /* Exec buffer command header format */
 #define AMDXDNA_CMD_STATE		GENMASK(3, 0)
 #define AMDXDNA_CMD_EXTRA_CU_MASK	GENMASK(11, 10)
@@ -122,6 +129,11 @@ struct amdxdna_drv_cmd {
 	u32			result;
 };
 
+struct app_health_report;
+union amdxdna_job_priv {
+	struct app_health_report *aie2_health;
+};
+
 struct amdxdna_sched_job {
 	struct drm_sched_job	base;
 	struct kref		refcnt;
@@ -136,10 +148,13 @@ struct amdxdna_sched_job {
 	u64			seq;
 	struct amdxdna_drv_cmd	*drv_cmd;
 	struct amdxdna_gem_obj	*cmd_bo;
+	union amdxdna_job_priv	priv;
 	size_t			bo_cnt;
 	struct drm_gem_object	*bos[] __counted_by(bo_cnt);
 };
 
+#define aie2_job_health priv.aie2_health
+
 static inline u32
 amdxdna_cmd_get_op(struct amdxdna_gem_obj *abo)
 {
@@ -169,7 +184,8 @@ void *amdxdna_cmd_get_payload(struct amdxdna_gem_obj *abo, u32 *size);
 u32 amdxdna_cmd_get_cu_idx(struct amdxdna_gem_obj *abo);
 int amdxdna_cmd_set_error(struct amdxdna_gem_obj *abo,
 			  struct amdxdna_sched_job *job, u32 cmd_idx,
-			  enum ert_cmd_state error_state);
+			  enum ert_cmd_state error_state,
+			  void *err_data, size_t size);
 
 void amdxdna_sched_job_cleanup(struct amdxdna_sched_job *job);
 void amdxdna_hwctx_remove_all(struct amdxdna_client *client);
diff --git a/drivers/accel/amdxdna/npu4_regs.c b/drivers/accel/amdxdna/npu4_regs.c
index ce25eef5fc34..619bff042e52 100644
--- a/drivers/accel/amdxdna/npu4_regs.c
+++ b/drivers/accel/amdxdna/npu4_regs.c
@@ -93,7 +93,8 @@ const struct aie2_fw_feature_tbl npu4_fw_feature_table[] = {
 	{ .features = BIT_U64(AIE2_NPU_COMMAND), .major = 6, .min_minor = 15 },
 	{ .features = BIT_U64(AIE2_PREEMPT), .major = 6, .min_minor = 12 },
 	{ .features = BIT_U64(AIE2_TEMPORAL_ONLY), .major = 6, .min_minor = 12 },
-	{ .features = GENMASK_ULL(AIE2_TEMPORAL_ONLY, AIE2_NPU_COMMAND), .major = 7 },
+	{ .features = BIT_U64(AIE2_APP_HEALTH), .major = 6, .min_minor = 18 },
+	{ .features = AIE2_ALL_FEATURES, .major = 7 },
 	{ 0 }
 };
 
-- 
2.34.1

