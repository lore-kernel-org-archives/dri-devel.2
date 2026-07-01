Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7AF8C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 15:56:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A6FE10EE48;
	Wed,  1 Jul 2026 15:56:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dSg45mjE";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011046.outbound.protection.outlook.com [52.101.52.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6942810EE48
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 15:56:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XMAO5Xmn3lo1rLkjCpDRGR824hglpH/mH+58cgWD9Q14uuOEYXLEY/SUx6BmEMZqdxyznx8ZRGcXJQGjocU8W/GfAb6XsgCwPxPZNTUdBrVT4CXbPGFvVj1i/Q13Ks52SU/lOGeyVTA2RIm0ourFhoGvJmE9TsT8++9dCGXbyX88qVJsRx2AVat+d8AJCgfICV2CNXOzaeD50KcsVPEDSRMwopnZxqSZuQ+XHoM5xI6XBspTwaGaNBKWEt+Ox5JCbABURtczR+Aol3ItUwlxw4rbuhWSnwkTy5bU1Gik6lEXHHaRz0AXd+NxOT79aD9peEuKyZdkNHfcfpfzAfq+1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5yYQK15DElm/m0IzugfYfYLP9MNzklphGFhC5HlHZdg=;
 b=vl9PjNheuf6pm0lvARIDPFnGUqkxPd73xofwuiOMsNx2gJ3WckxW/e6VesXorrEoJ1oYe2f6j0Txw5XzCq6onrauJQp1uXvggGgOLG3I+B/RXyP+6ul0PAALbsAiZCJ8JY8GzgCatlQS11MzKaK9vLxmkWsdVBDLlmUayOaI81SNbZK2Oc8Gl1VD+0oNNKSdpQ5v4jkk1H+JeX2dHHdTn6lTUpfy4JLcgu//VkdPxV+mz7+dFoEaUlcI/LKTP5EfVbLjVbJ49zS+BehwFgX1tEqU4ueYGGjzcExsW3KjBirc0ZGQfqGt2eWHyO2ASjiHPHup7oRBO73E+ur/cgs7/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5yYQK15DElm/m0IzugfYfYLP9MNzklphGFhC5HlHZdg=;
 b=dSg45mjEwuKYJ9M406Ft3kJZ2eiOzvzcRc1JKzmw7+WMDjbvkHx2XDH8Kh/U8tSAiC3516RX2aGR+d/Amo5DTDDWyxmwDY7jgzV4sJhHmazTwdVlDdPBKplwa2U4AJXoe/Ic7jsUooCaHa8yfN8BZ8lVLL11DZGqVC77KFDVvJo=
Received: from SA1P222CA0118.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::6)
 by SN7PR12MB7202.namprd12.prod.outlook.com (2603:10b6:806:2a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 15:56:15 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:806:3c5:cafe::1) by SA1P222CA0118.outlook.office365.com
 (2603:10b6:806:3c5::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.9 via Frontend Transport; Wed, 1
 Jul 2026 15:56:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 15:56:14 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 1 Jul
 2026 10:56:06 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 1 Jul
 2026 10:56:06 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 1 Jul 2026 10:56:05 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <shuvampandey1@gmail.com>, <karol.wachowski@linux.intel.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <max.zhen@amd.com>, <sonal.santan@amd.com>
Subject: [PATCH V1] accel/amdxdna: Fix use-after-free in debug BO command
 handling
Date: Wed, 1 Jul 2026 08:55:56 -0700
Message-ID: <20260701155556.663541-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|SN7PR12MB7202:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ccbf868-b903-4a35-95f2-08ded78947d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 0FH71POez39BgTDPDuh5TwToj7AVQ34IjfABBZFpHJJnnZw4G0NjmcuXH1PTekDc0Zyux0nbxYwHrtVqryi44ORJFWMKxjhmVs+UBFdfm7/YfEJzwt5+elNArVIbgN3WCqExT+850EqPpyqwwrdM26AlaY7GRXlE9JE4LPXHCFyW5sa64DCIfEjqzi3B2T3GiQySk3sAktrvAf94Ad7EZgucsm8NQo3/LBHgk46/vc225G1kq0l1eq0/hu618c9ccFJjIAZx+lIbnzJxRbDuRLLQri6uak1c6iMZRBhza0nFy6xMHmzPiq/Lnrcm35jk7OxGhLztSKF6zEQlBUKHzWgnne6vB7JjoJaK32aUl6yETzWTuYmeYeh02xtSvUypNo0Nq6UW99PLSO5oKyukTtzHJImhWQ1HTu4cypOx/BGvze8AAHCsw90aMUSd1qX72nt3/oj82Q/TvCEeAl1rTrX6asY/3G1Hule37xY2vO+ezh+GTzNkD53jDTPlo1KSEXzcJA07XA9RAuWQUQjsHTx9dIMRf62La0sYMXhshx8Xq0mIUAkfE7Fa5wB1Ahw7AmWxDEjUImSwCrVvN5XzuMGNJVeC+YPLp9AACHrz6A/b3BR2PbEpFtjO5ge2fsNNzITxG3CtFR9ghich3CJ7QZrMPjbl+/pjL1Wxs8ghhU7GKzDODCOUqMlpx9J8iitCe6veG/v/1PktwnLfGfJG3A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mjmjwFl4jF3YyIBK5oDyCW+DW8P2h+r7BOfhcclYcNLbEKqYcnt9z2uQ4z4osCaqrU11D4kOLmFLh0YC+kyivz11tMo2PGdP+vPts2kdlYH+lBuCcnTmoIuMcV89owkzujLNanLN908CL6hMYkiXter0NYWEWBVBDPNd/0Vme9dh780Lo2MDQDBniXyX6P2XenDiq2crvS5ni0dVYVBbgu3Va59bR4RMjIedfvYSYzMx+fiwBpK2HJ3V6UCRy0n32D1rVC1cAGS/gawO1CUs91hTCY+OUyRC7PvM4XVxigGL5TiW6KubSfuXrsMD0s/aSQj0nGMfStxViACUgohlPM0WhK3dhHWVd+QjpQQIPkborPrMaVQsahugv9jCdki8zTsKbQZgQhGLrHqqJZuNLPUfcSbma9O9h50RWfrX/xYRhJgtzRDyexPi6OoEkoPp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 15:56:14.8446 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ccbf868-b903-4a35-95f2-08ded78947d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7202
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

When a debug BO command completes, job->drv_cmd may already have been
freed. Accessing it from aie2_sched_drvcmd_resp_handler() can result in
a use-after-free and memory corruption.

Fix this by introducing reference counting for drv_cmd objects and
transferring ownership to the job while it is in flight. This ensures
that the command remains valid until the completion handler finishes
processing it.

Fixes: 7ea046838021 ("accel/amdxdna: Support firmware debug buffer")
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/aie2_ctx.c    | 68 +++++++++++++++++++++--------
 drivers/accel/amdxdna/amdxdna_ctx.h |  1 +
 2 files changed, 51 insertions(+), 18 deletions(-)

diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
index 55eb29dece5b..8ec8a4d69b14 100644
--- a/drivers/accel/amdxdna/aie2_ctx.c
+++ b/drivers/accel/amdxdna/aie2_ctx.c
@@ -59,6 +59,18 @@ static bool aie2_tdr_detect(struct amdxdna_dev *xdna)
 	return false;
 }
 
+static void aie2_cmd_release(struct kref *ref)
+{
+	struct amdxdna_drv_cmd *drv_cmd = container_of(ref, struct amdxdna_drv_cmd, refcnt);
+
+	kfree(drv_cmd);
+}
+
+static void aie2_cmd_put(struct amdxdna_drv_cmd *drv_cmd)
+{
+	kref_put(&drv_cmd->refcnt, aie2_cmd_release);
+}
+
 static void aie2_job_release(struct kref *ref)
 {
 	struct amdxdna_sched_job *job;
@@ -70,6 +82,8 @@ static void aie2_job_release(struct kref *ref)
 	wake_up(&job->hwctx->priv->job_free_wq);
 	if (job->out_fence)
 		dma_fence_put(job->out_fence);
+	if (job->drv_cmd)
+		aie2_cmd_put(job->drv_cmd);
 	kfree(job->aie2_job_health);
 	kfree(job);
 }
@@ -901,7 +915,7 @@ static int aie2_hwctx_cfg_debug_bo(struct amdxdna_hwctx *hwctx, u32 bo_hdl,
 {
 	struct amdxdna_client *client = hwctx->client;
 	struct amdxdna_dev *xdna = client->xdna;
-	struct amdxdna_drv_cmd cmd = { 0 };
+	struct amdxdna_drv_cmd *cmd;
 	struct amdxdna_gem_obj *abo;
 	u64 seq;
 	int ret;
@@ -912,32 +926,39 @@ static int aie2_hwctx_cfg_debug_bo(struct amdxdna_hwctx *hwctx, u32 bo_hdl,
 		return -EINVAL;
 	}
 
+	cmd = kzalloc_obj(*cmd);
+	if (!cmd) {
+		ret = -ENOMEM;
+		goto put_obj;
+	}
+	kref_init(&cmd->refcnt);
+
 	if (attach) {
 		if (abo->assigned_hwctx != AMDXDNA_INVALID_CTX_HANDLE) {
 			ret = -EBUSY;
-			goto put_obj;
+			goto put_cmd;
 		}
-		cmd.opcode = ATTACH_DEBUG_BO;
+		cmd->opcode = ATTACH_DEBUG_BO;
 	} else {
 		if (abo->assigned_hwctx != hwctx->id) {
 			ret = -EINVAL;
-			goto put_obj;
+			goto put_cmd;
 		}
-		cmd.opcode = DETACH_DEBUG_BO;
+		cmd->opcode = DETACH_DEBUG_BO;
 	}
 
-	ret = amdxdna_cmd_submit(client, &cmd, AMDXDNA_INVALID_BO_HANDLE,
+	ret = amdxdna_cmd_submit(client, cmd, AMDXDNA_INVALID_BO_HANDLE,
 				 &bo_hdl, 1, hwctx->id, &seq);
 	if (ret) {
 		XDNA_ERR(xdna, "Submit command failed");
-		goto put_obj;
+		goto put_cmd;
 	}
 
 	aie2_cmd_wait(hwctx, seq);
-	if (cmd.result) {
-		XDNA_ERR(xdna, "Response failure 0x%x", cmd.result);
+	if (cmd->result) {
+		XDNA_ERR(xdna, "Response failure 0x%x", cmd->result);
 		ret = -EINVAL;
-		goto put_obj;
+		goto put_cmd;
 	}
 
 	if (attach)
@@ -947,6 +968,8 @@ static int aie2_hwctx_cfg_debug_bo(struct amdxdna_hwctx *hwctx, u32 bo_hdl,
 
 	XDNA_DBG(xdna, "Config debug BO %d to %s", bo_hdl, hwctx->name);
 
+put_cmd:
+	aie2_cmd_put(cmd);
 put_obj:
 	amdxdna_gem_put_obj(abo);
 	return ret;
@@ -974,25 +997,32 @@ int aie2_hwctx_sync_debug_bo(struct amdxdna_hwctx *hwctx, u32 debug_bo_hdl)
 {
 	struct amdxdna_client *client = hwctx->client;
 	struct amdxdna_dev *xdna = client->xdna;
-	struct amdxdna_drv_cmd cmd = { 0 };
+	struct amdxdna_drv_cmd *cmd;
 	u64 seq;
 	int ret;
 
-	cmd.opcode = SYNC_DEBUG_BO;
-	ret = amdxdna_cmd_submit(client, &cmd, AMDXDNA_INVALID_BO_HANDLE,
+	cmd = kzalloc_obj(*cmd);
+	if (!cmd)
+		return -ENOMEM;
+	kref_init(&cmd->refcnt);
+
+	cmd->opcode = SYNC_DEBUG_BO;
+	ret = amdxdna_cmd_submit(client, cmd, AMDXDNA_INVALID_BO_HANDLE,
 				 &debug_bo_hdl, 1, hwctx->id, &seq);
 	if (ret) {
 		XDNA_ERR(xdna, "Submit command failed");
-		return ret;
+		goto put_cmd;
 	}
 
 	aie2_cmd_wait(hwctx, seq);
-	if (cmd.result) {
-		XDNA_ERR(xdna, "Response failure 0x%x", cmd.result);
-		return -EINVAL;
+	if (cmd->result) {
+		XDNA_ERR(xdna, "Response failure 0x%x", cmd->result);
+		ret = -EINVAL;
 	}
 
-	return 0;
+put_cmd:
+	aie2_cmd_put(cmd);
+	return ret;
 }
 
 static int aie2_populate_range(struct amdxdna_gem_obj *abo)
@@ -1139,6 +1169,8 @@ int aie2_cmd_submit(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *job,
 		dma_resv_add_fence(job->bos[i]->resv, job->out_fence, DMA_RESV_USAGE_WRITE);
 	job->seq = hwctx->priv->seq++;
 	kref_get(&job->refcnt);
+	if (job->drv_cmd)
+		kref_get(&job->drv_cmd->refcnt);
 	drm_sched_entity_push_job(&job->base);
 
 	*seq = job->seq;
diff --git a/drivers/accel/amdxdna/amdxdna_ctx.h b/drivers/accel/amdxdna/amdxdna_ctx.h
index aaae16430466..b6bef3af7dab 100644
--- a/drivers/accel/amdxdna/amdxdna_ctx.h
+++ b/drivers/accel/amdxdna/amdxdna_ctx.h
@@ -132,6 +132,7 @@ enum amdxdna_job_opcode {
 struct amdxdna_drv_cmd {
 	enum amdxdna_job_opcode	opcode;
 	u32			result;
+	struct kref		refcnt;
 };
 
 struct app_health_report;
-- 
2.34.1

