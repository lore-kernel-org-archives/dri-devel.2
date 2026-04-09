Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 998DDF364A3
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 17:58:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F279310E852;
	Thu,  9 Apr 2026 17:58:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hQ0+jxUx";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010009.outbound.protection.outlook.com
 [40.93.198.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 283BC10E852
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 17:58:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=spKERNZAHDPVsL2z9862GAD/lKeDnmT+eKsin6tETpvaW3N+E1YhngjtyOdv/dDfyQIvjhhaV7NLMJln1ORS8QpBiynA6T6KHfB6CTPO3EUF1PmYt+o5QTEB4KEcGoVDNF+x4bkK5+soPEYO/tDrxKeLsC+M3qjtyqqX9P+paQblbbBSbDvREmBtiizYcuH39VqBseVfasbCDzKGo8O48KgGmHajFAuNAQue8AtoZ74nQ5iQ9OkyyeyeSd6V2vzko5A9y5ehhdFvHt7a3CGVtNPoXXd05wK5/tr4uiXXywKA53ZxCJYTOpBmeR9PKYOZ3NyQ/a2wC3A2jf/YdoOsug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Irf9HR+bEwKDPT0upWgcTAvKJhFZAzDLpO9E6AZvPBY=;
 b=o6+DjTkC+opbOf/GNXocdr8IJnSHbCOXuuAaaA/xkldE6D6St4XA6aUo7H90wuXUrFtoRnhdXZuaRi0oiYOrVmIZ1D4+yOf/36ZblmZkFqEuqc72KFvnXWnE/sZlAyyftpOQzEcnwwQInxHzlLSRrkO/oqmEraerQNGtqXdJzprASbKdKmnwSD2orJ0wmou4OdPdhsebI8YWwn4c3i5ALQku/LW1utx631WtgI/O6RabWGtxRsWSSfLHj7gOQOm36xVS4hLWZktsHRlJ0bzoQGvklYak/guzqn1I0XySi1psSBX7ju0ctFQYrKj01kn7Ts8LWGUeN6Kmgwuo3YY01A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Irf9HR+bEwKDPT0upWgcTAvKJhFZAzDLpO9E6AZvPBY=;
 b=hQ0+jxUx88a1C9Z9xITnOUap+jsnb4RnAgIG5jZn3eNkTiiZR7QR97KzYJxfzgtBrQDebRclcOdslY2mgFUQvzCKFr7rNSODmH8WReerhzMPADAr2zfbaRCppRs+ozt3PF9Hy2/pUiMtoWd/EbbbGOc5yrax+ZxRcAOR+ps6bpE=
Received: from SA0PR11CA0197.namprd11.prod.outlook.com (2603:10b6:806:1bc::22)
 by CH3PR12MB8547.namprd12.prod.outlook.com (2603:10b6:610:164::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Thu, 9 Apr
 2026 17:58:34 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:806:1bc:cafe::2d) by SA0PR11CA0197.outlook.office365.com
 (2603:10b6:806:1bc::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.41 via Frontend Transport; Thu,
 9 Apr 2026 17:58:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 17:58:33 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 9 Apr
 2026 12:58:33 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 9 Apr
 2026 12:58:32 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 9 Apr 2026 12:58:32 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <maciej.falkowski@linux.intel.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <max.zhen@amd.com>, <sonal.santan@amd.com>
Subject: [PATCH V1] accel/amdxdna: Check for device hang on job timeout
Date: Thu, 9 Apr 2026 10:58:26 -0700
Message-ID: <20260409175826.195665-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|CH3PR12MB8547:EE_
X-MS-Office365-Filtering-Correlation-Id: d1beae05-8514-42ee-3c6c-08de96619dc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: eeQog14vJDsZPxQ2ohkMpiY2JQ8ZUZ3dXjvR7k7fDQatIzdXzljZ2KAp8XCpUwWOwy6cbSo2NcwMC/ExY9UBmVcuiaYtG2B/tgKr8bI5zV/ZWDpEg8poQwOHA1B4S44QtMqTH0VWlmKYfDSJLtG+uxQUCd5R1kHzTpsvUJB3FQ8PPZWDErC1NkYrg0nXoiyTAsD/06kZ3gNVzvSXkAAxpSFDmKs2kY4oohj+D+C8g17cFY5yApsqtZx2fH7DOxb+E1F0bZnqThAfAa8nlOJfDjV6haSk6qahxtpa+fs14zK5BkbrxNpAhDVz5SFguDcJN9KstYBD+jh0baYd4CBFGyO6b8szxT5hlXs8Hz3PYP4ygmo8vnDknuv9TE6jVT8nImTzKQcgA/T6xzmScVwsFUPC0DZtie7QUpicJ0hRmwIG2l5aS13MpfxxvFXE2LlpRrmfX0E+5v8KwT3yauyXuXYE5QUzOwG/DwBRCVzWjounLEVZZkobhGUeTx6kSVZmGurQYtukWg0bOw74WdTkg+msxs5x//S1zOWM3zrH5HjXc7kmP4WwZMP+HJ9UP+B134jW59ODYJ54vK3b1d/sewb/7QLjF+I5cXW+cyxb1KcEWbr8sV3JJrIdu6YTlcdYdYaAfMY3y40BxbOR7OusWo1/3gsvdI4Gv8vhais+FwPE52yuL78fj1gLqWEqkC/+sWcBZ8h/lJ00eUT2HLDAuy5ymrgwPvjKuK5RScvcEryLhdKjNKsS++KWK5m5DpYOBCmuBzpLyUOSZ78uNWcIVQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WAb7X3/Yu3h1HzRUZ5987MfZ1Xz32+wQQZKDh93yaluLn/dhwml5KVUQTwzL+/w0gRB1uCrk9Xn3bmS8UEcgJuCg2J8rbu+7Jw1MsSx56MpjAHAR3Bq2Ga0pRpIooE7oz0da/jzzTzOlagddJZT0gOLKSb4OzSCvubnfOgSOzRUpR+TAV14dEZfTdDdrQtyI0t0JeTUE2shueaKDi3zrvd1HKUW51z7NLOkn6pgKTI/bXoh0RUmfEI2vFA48Q+eFBXdAwtWleFjGlYDH9+VuEQPyQm4unio1FAffn2LI+Az8/iAQRUlUeS+kzeYQua30wjmZPs1TCe6494YIeOybRuXI6zBxuy4xx3cAD5Y+iCcsstpgSL9DvAgBAfmYOptXwwnBP2bFduCP51IUV+bAoZCKO7tSnVe/Ac+Js6LJkAowck7m3WayvqwH01aeceVe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 17:58:33.5484 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1beae05-8514-42ee-3c6c-08de96619dc5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8547
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

A job timeout does not necessarily indicate that the device is hung, as
it may still be processing other jobs.

Track whether any jobs have been successfully submitted or completed,
and use this information to determine if the device is making forward
progress. If so, return DRM_GPU_SCHED_STAT_NO_HANG instead of treating
the timeout as a device hang.

In the meanwhile the timeout interval is changed to 2 seconds which meets
the userspace requirement.

Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/aie2_ctx.c | 36 +++++++++++++++++++++++++++-----
 drivers/accel/amdxdna/aie2_pci.h |  6 ++++++
 2 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
index f97755d60fa3..ddcf06a6b80c 100644
--- a/drivers/accel/amdxdna/aie2_ctx.c
+++ b/drivers/accel/amdxdna/aie2_ctx.c
@@ -27,7 +27,9 @@ static bool force_cmdlist = true;
 module_param(force_cmdlist, bool, 0600);
 MODULE_PARM_DESC(force_cmdlist, "Force use command list (Default true)");
 
-#define HWCTX_MAX_TIMEOUT	60000 /* milliseconds */
+uint tdr_timeout_ms = 2000;
+module_param(tdr_timeout_ms, int, 0400);
+MODULE_PARM_DESC(tdr_timeout_ms, "TDR (Timeout Detection and Recovery) timeout in milliseconds (0 = disable)");
 
 struct aie2_ctx_health {
 	struct amdxdna_ctx_health header;
@@ -39,6 +41,24 @@ struct aie2_ctx_health {
 	u32 fatal_error_app_module;
 };
 
+static inline void aie2_tdr_signal(struct amdxdna_dev *xdna)
+{
+	WRITE_ONCE(xdna->dev_handle->tdr_status, AIE2_TDR_SIGNALED);
+}
+
+static bool aie2_tdr_detect(struct amdxdna_dev *xdna)
+{
+	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
+
+	if (READ_ONCE(ndev->tdr_status) == AIE2_TDR_WAIT) {
+		XDNA_ERR(xdna, "TDR timeout detected");
+		return true;
+	}
+
+	WRITE_ONCE(ndev->tdr_status, AIE2_TDR_WAIT);
+	return false;
+}
+
 static void aie2_job_release(struct kref *ref)
 {
 	struct amdxdna_sched_job *job;
@@ -177,6 +197,7 @@ aie2_sched_notify(struct amdxdna_sched_job *job)
 
 	trace_xdna_job(&job->base, job->hwctx->name, "signaled fence", job->seq);
 
+	aie2_tdr_signal(job->hwctx->client->xdna);
 	job->hwctx->priv->completed++;
 	dma_fence_signal(fence);
 
@@ -385,6 +406,8 @@ aie2_sched_job_run(struct drm_sched_job *sched_job)
 		aie2_job_put(job);
 		mmput(job->mm);
 		fence = ERR_PTR(ret);
+	} else {
+		aie2_tdr_signal(hwctx->client->xdna);
 	}
 	trace_xdna_job(sched_job, hwctx->name, "sent to device", job->seq);
 
@@ -415,9 +438,12 @@ aie2_sched_job_timedout(struct drm_sched_job *sched_job)
 
 	xdna = hwctx->client->xdna;
 	trace_xdna_job(sched_job, hwctx->name, "job timedout", job->seq);
-	job->job_timeout = true;
 
-	mutex_lock(&xdna->dev_lock);
+	guard(mutex)(&xdna->dev_lock);
+
+	if (!aie2_tdr_detect(xdna))
+		return DRM_GPU_SCHED_STAT_NO_HANG;
+
 	report = kzalloc_obj(*report);
 	if (!report)
 		goto reset_hwctx;
@@ -429,10 +455,10 @@ aie2_sched_job_timedout(struct drm_sched_job *sched_job)
 		job->aie2_job_health = report;
 
 reset_hwctx:
+	job->job_timeout = true;
 	aie2_hwctx_stop(xdna, hwctx, sched_job);
 
 	aie2_hwctx_restart(xdna, hwctx);
-	mutex_unlock(&xdna->dev_lock);
 
 	return DRM_GPU_SCHED_STAT_RESET;
 }
@@ -608,7 +634,7 @@ int aie2_hwctx_init(struct amdxdna_hwctx *hwctx)
 		.ops = &sched_ops,
 		.num_rqs = DRM_SCHED_PRIORITY_COUNT,
 		.credit_limit = HWCTX_MAX_CMDS,
-		.timeout = msecs_to_jiffies(HWCTX_MAX_TIMEOUT),
+		.timeout = msecs_to_jiffies(tdr_timeout_ms),
 		.name = "amdxdna_js",
 		.dev = xdna->ddev.dev,
 	};
diff --git a/drivers/accel/amdxdna/aie2_pci.h b/drivers/accel/amdxdna/aie2_pci.h
index 7c308672b5fe..81564483cb16 100644
--- a/drivers/accel/amdxdna/aie2_pci.h
+++ b/drivers/accel/amdxdna/aie2_pci.h
@@ -165,6 +165,11 @@ struct aie2_exec_msg_ops {
 	u32 (*get_chain_msg_op)(u32 cmd_op);
 };
 
+enum aie2_tdr_status {
+	AIE2_TDR_WAIT,
+	AIE2_TDR_SIGNALED,
+};
+
 struct amdxdna_dev_hdl {
 	struct aie_device		aie;
 	const struct amdxdna_dev_priv	*priv;
@@ -197,6 +202,7 @@ struct amdxdna_dev_hdl {
 	u32				hwctx_num;
 
 	struct amdxdna_async_error	last_async_err;
+	enum aie2_tdr_status		tdr_status;
 };
 
 struct aie2_hw_ops {
-- 
2.34.1

