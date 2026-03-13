Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BFE5107BCD5
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 18:14:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7307310E373;
	Fri, 13 Mar 2026 18:14:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gKkBnhAH";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012056.outbound.protection.outlook.com [40.107.209.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9791010E373
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 18:14:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=suhUGCI4iFRuSqQpFGLDkvW4+RPu+r35hDdtLUzcL91aAV91y8t0/Vp+DYjP6gDAQMBxg1B3DZVCkBlxE5m2qxI7d7dB14ZZX53XEYlgD+z+r1YqfjZ+5SKQGSA7/dVuk5mKK4D9pchECOn2fc56/ZQdvXPtL6lTbSTe33T8N/gKX5WtCHEaJXr0/Vvq4A+ZfASjo2p+eYHLVWIwyzyhX7b3IAHIq517X1BZqQSerB0jX9e88kdDEw/8WPnQbLFB+wAHqFz4Onb9D1o4Nd7+OH1SfgMZ6Tznrz5eYKgfizY4mcPINzOHHAIkvOsHFEkDK3vZcr1ZKbLlofuVIPDEYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VUedgpbZ/y1ryB2GJmE1SP8seCog4kpggQN57ZnLHzA=;
 b=nPp3IC+dM8qrg6ekDPHmeRnfGqZNALNsh5huJjh0q8uTsewgH3sdTlSvvAq46dK/u6g/jaS8B+FUVJligp2AKrLAR2hGA9ttSPw2yxosM9sKtUnNQc8FJUZ/VGBjSym+IsM0jHHbWhZzEAJQ0gPZMkgNqDWY+u0PLXm81hK50ekjzuDI6dvgHwJ1jkFBnfSPNzx8zZ+lAzIAt40JMbSzoyHx27DMPShFyfS7G8dgMBbPBjhbJbjI6Y43Eeh4qN3LKSoNRsOoceUA5r3+3iTlcOSvoC0tm9XKBDgIXfqTqj7btXEz4ZzfRquo1CVvbE+gAeRcarPvcFjUpZltuq0Pwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VUedgpbZ/y1ryB2GJmE1SP8seCog4kpggQN57ZnLHzA=;
 b=gKkBnhAHKd1xfY7vQQ6OV7ADYlpHT/wqSuX7fv0VtEOQX66D5qQvFLmkIVh4SllZj2ZjV/Fw2yuWVyqjgP2c1ZZJUmiGEPLBmHTKurXYxyzbdmYGa/DP4Ms5qrThm4QkWh8XTDiTBW97BQ61Hg9Pomxl2JpaV4l69ijoI4Bso00=
Received: from BY3PR04CA0011.namprd04.prod.outlook.com (2603:10b6:a03:217::16)
 by IA1PR12MB8336.namprd12.prod.outlook.com (2603:10b6:208:3fc::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.7; Fri, 13 Mar
 2026 18:14:17 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::35) by BY3PR04CA0011.outlook.office365.com
 (2603:10b6:a03:217::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.16 via Frontend Transport; Fri,
 13 Mar 2026 18:14:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Fri, 13 Mar 2026 18:14:16 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 13 Mar
 2026 13:14:15 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 13 Mar
 2026 11:14:15 -0700
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 13 Mar 2026 13:14:15 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <maciej.falkowski@linux.intel.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <max.zhen@amd.com>, <sonal.santan@amd.com>
Subject: [PATCH V1] accel/amdxdna: Support retrieving hardware context debug
 information
Date: Fri, 13 Mar 2026 11:14:13 -0700
Message-ID: <20260313181413.1108841-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|IA1PR12MB8336:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cc89603-4419-4c60-86b7-08de812c56df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 23OomcZig2o16lOheRSXt9/+ritizvoQ21BUldAv6ytNMDO+W2qThNql3JrALOf9I2LgHBCZm1ayYQs0E2+aAcASNgkj7dX8PP8rpX5pIBwwbrIlTL/EVFI0kGXKBvFOcD3a9egc66Ffu+4BkCvM28q2ZgC06uxP1c5UZKEWmIJq/I+WrbvgS78wNnuYbOpp6Iz5jfmv7uPby3Hz0dTwNwb3cuOm960eXoXmuPI3p73P5Ybrmb0Cn5HdDB3sn1XDU/C9t6qeYrpNMd1V54VMmD6lOiXi9YQGD3YPFYhsvbhJIXzPxFkTrdSDNoenBtLLwkg/MBpw0nWqSGymOaG4f/z4NniL88m2ZbT6Xs4XxJSnhedJdC0wl3pL/ub9CL1S3dHXmvyzSYbgkzp9fr1jgD1c/DzTYNGlE0nE14uVc0DjRoq3CZyY/XykFIBp/sgnFf49AlfT4iBXuFBQha5W6WWw77lwspRT6OsUJ6hKUDaJJPyptlA/6za2OCcjiraHzOE0el6M+VLEt9RRx8oKftrwBkBh20li4dgxPyEMjF4FtRtdixHY+Fymo4xX9fzf2JoN3awYuXnBeV0gsDGdW6p033U32OF0i0yq4d/R42rlR6hO/neKFFXShPo1Yp6RKz1V1hp8ohdbxoePF6Y2PqZ3wV5gufg7fCsHiE1VfxT+iZqxWxkB0nQ7jvq9MDUxe/gUBmBKdEZzaEiaQnJXm7ks6NridvyuiKAjO6YHr1jYT3avHlNrx8dwZ6mXLNjS0EaHOwQN7hsjG/UPueUYrQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PHMAMCRqGg6nSXfqBRwl9w+oRL8wodCfwUHIkhCR1B6E2JNsEsUBBCKhIbeuBPrajVAA1lkPP8MI7n0najMKmaJicQdGX3WKK7oexMzezqcBF080NijTKLcNRepYYxYrXTN5AptHrnrHxanbLkhvHQf4QIqaKM2Yolp0YDQQ8RYxVYSTVVljjY5Tcdl+nIIGcYa/wOa32nXMQcLY3lNHvNruolAM/dpR9xJjg3VZ1Daqm3wn/iEJbXfXqE4G21BrkrJNSWGFta2e18945/P2rO93MHj4Q9deCnHEK4yTMq5miDi1es4+m7FFSOusBMMvVOhJNXwWVGl2avpamkHnw6ufjyF/YfY6plXIMFbi0X4h4SJwncafwnnWD0YHgXxdiW8INRuzwu0Z1h7anVzh45XqOzvNnJtODEnvrTemywiOsSLy53A/w+g7wL8/ivyh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 18:14:16.8378 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cc89603-4419-4c60-86b7-08de812c56df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8336
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
 drivers/accel/amdxdna/aie2_pci.h      |  4 ++
 drivers/accel/amdxdna/amdxdna_ctx.c   |  6 +-
 drivers/accel/amdxdna/amdxdna_ctx.h   | 11 +++-
 drivers/accel/amdxdna/npu4_regs.c     |  3 +-
 8 files changed, 205 insertions(+), 11 deletions(-)

diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
index 779ac70d62d7..8b7375d13e28 100644
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
+	kfree(job->priv);
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
+	struct app_health_report *report = job->priv;
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
+		job->priv = report;
+
+reset_hwctx:
 	aie2_hwctx_stop(xdna, hwctx, sched_job);
 
 	aie2_hwctx_restart(xdna, hwctx);
diff --git a/drivers/accel/amdxdna/aie2_message.c b/drivers/accel/amdxdna/aie2_message.c
index fa2f33c322d4..b764c7e8816a 100644
--- a/drivers/accel/amdxdna/aie2_message.c
+++ b/drivers/accel/amdxdna/aie2_message.c
@@ -1161,3 +1161,44 @@ int aie2_config_debug_bo(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *
 
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
index 885ae7e6bfc7..6cced8ab936b 100644
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
 
@@ -341,6 +343,8 @@ int aie2_query_aie_version(struct amdxdna_dev_hdl *ndev, struct aie_version *ver
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
index fbdf9d000871..c067688755af 100644
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
@@ -136,6 +143,7 @@ struct amdxdna_sched_job {
 	u64			seq;
 	struct amdxdna_drv_cmd	*drv_cmd;
 	struct amdxdna_gem_obj	*cmd_bo;
+	void			*priv;
 	size_t			bo_cnt;
 	struct drm_gem_object	*bos[] __counted_by(bo_cnt);
 };
@@ -169,7 +177,8 @@ void *amdxdna_cmd_get_payload(struct amdxdna_gem_obj *abo, u32 *size);
 u32 amdxdna_cmd_get_cu_idx(struct amdxdna_gem_obj *abo);
 int amdxdna_cmd_set_error(struct amdxdna_gem_obj *abo,
 			  struct amdxdna_sched_job *job, u32 cmd_idx,
-			  enum ert_cmd_state error_state);
+			  enum ert_cmd_state error_state,
+			  void *err_data, size_t size);
 
 void amdxdna_sched_job_cleanup(struct amdxdna_sched_job *job);
 void amdxdna_hwctx_remove_all(struct amdxdna_client *client);
diff --git a/drivers/accel/amdxdna/npu4_regs.c b/drivers/accel/amdxdna/npu4_regs.c
index ce25eef5fc34..d44fe8fd6cb0 100644
--- a/drivers/accel/amdxdna/npu4_regs.c
+++ b/drivers/accel/amdxdna/npu4_regs.c
@@ -93,7 +93,8 @@ const struct aie2_fw_feature_tbl npu4_fw_feature_table[] = {
 	{ .features = BIT_U64(AIE2_NPU_COMMAND), .major = 6, .min_minor = 15 },
 	{ .features = BIT_U64(AIE2_PREEMPT), .major = 6, .min_minor = 12 },
 	{ .features = BIT_U64(AIE2_TEMPORAL_ONLY), .major = 6, .min_minor = 12 },
-	{ .features = GENMASK_ULL(AIE2_TEMPORAL_ONLY, AIE2_NPU_COMMAND), .major = 7 },
+	{ .features = BIT_U64(AIE2_APP_HEALTH), .major = 6, .min_minor = 18 },
+	{ .features = GENMASK_ULL(AIE2_APP_HEALTH, AIE2_NPU_COMMAND), .major = 7 },
 	{ 0 }
 };
 
-- 
2.34.1

