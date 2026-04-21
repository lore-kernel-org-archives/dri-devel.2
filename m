Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9024BF94CA4
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 18:15:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3A2910E573;
	Tue, 21 Apr 2026 18:15:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ReukLebP";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013020.outbound.protection.outlook.com
 [40.93.201.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CB5810E832
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 18:15:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FSKF1SuDdNp1LKXU7Q9Y70Ox7oncYulWfHd4S7ghEX06nReWzJB1xUDn8d9OKOgKYIJ2yTIs0ioTscL4CEW57AqOoVRyh4MqZJW/CPakHwI6RFt6OoC2yPBVBa+eDBSiipDqojUO8+zvF+3aAmz/D4EAsMH6YiYHNtboSKx7fY3f9SvqZyZ3V79pkwDyZ6yzSsPlQ+e8kAY0X3kpixU29BwP22uDBu+aGtL1+l6Y4BLghixi5dTGbUkM3tWnfG0wFvvIOSVD4QQLN5EM1/EZEgV/qsjdDbFUml0LfkTVI02Vvds4LryeaRZG6giYl2ACwDoKvuzkNjnD4XIBWP2DWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rrIjSblCTQEKzIIYYXy4E1oBYitNlMnIu0GkVQYgIE0=;
 b=oQMP51xx+jZt1FL/gRKO2O7NpULIBhF3FY5Nu9ISmtjHDn1bpNyBlVKqzmpnrY+3/F7yX/7mQv69LZyAJTNTUb2nUrB86+M/m0K+8gN5NBqXg32XeUg13dB/v5DK/dTH8LAIVbkeXI0+r8bPRz9dvck6ugHf7vG3exLcHgzIXA2UB5FdESmDqiVSgp56XCSlwgtVwHXoR8Z+BVx3H+sO15FLHOmsDGrjRJFpBI6ORe58CJr3Gq8fOLx9lZWnNGWNUZLFdM3UTggJD9OojYYJgYagqObdcPJNxffIY+Yig1x8kmOi9FknI1INGtwkqxv61BcSJXBpdgJRiKROit6Ljw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rrIjSblCTQEKzIIYYXy4E1oBYitNlMnIu0GkVQYgIE0=;
 b=ReukLebPL8mtya3h8P3WrqcqdvpLekioAfiNg8+e8UuIzJGuPiNN82xCpkQz3hNymlCjZgl5US+fCw/QtsgnXX5ymlWKYz+rgSRh2R+6+ORs9/k9+0TJLikSi2TlwjFI+nx0lDUaW/+adX76ZpbcfzO6kShcChV54o0gGg7gluI=
Received: from SJ0PR05CA0169.namprd05.prod.outlook.com (2603:10b6:a03:339::24)
 by LV8PR12MB9181.namprd12.prod.outlook.com (2603:10b6:408:18d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 18:15:07 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:a03:339:cafe::dd) by SJ0PR05CA0169.outlook.office365.com
 (2603:10b6:a03:339::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Tue,
 21 Apr 2026 18:15:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 21 Apr 2026 18:15:05 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 21 Apr
 2026 13:15:04 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 21 Apr
 2026 13:15:04 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 21 Apr 2026 13:15:03 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <maciej.falkowski@linux.intel.com>
CC: Max Zhen <max.zhen@amd.com>, <linux-kernel@vger.kernel.org>,
 <sonal.santan@amd.com>, Lizhi Hou <lizhi.hou@amd.com>
Subject: [PATCH V1] accel/amdxdna: Improve tracing for job lifecycle and
 mailbox RX worker
Date: Tue, 21 Apr 2026 11:15:02 -0700
Message-ID: <20260421181502.1970263-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|LV8PR12MB9181:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bb4d6ba-99e6-471a-de96-08de9fd1ea2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: /iyTePIH4Ektw/aQ+hdIq1ixscToj+NyTAdgYTICJwZ9SpktxungkAh6otiORYCN6onqlonQcrkx0w/zFOlre4iTtQbhFeRje13EV4UCnKV2NBJfi0VkWzTiX3pphP2TBTpcmlxM7Hf8i+NiIrQ+8lI6Il7/tQJa0ZGHMoiOjRZQcodB0SkANyth5aVltmKEurhjf+g9OuIqq9psdCr9R2IxycF1x9cfjCN8ua+d1TyyodlPh4g8Mx/7P+7ETRiERaFqYugJv6cbOqNFFwBG3OFhO1I/BLandxw5L9JQ0x2M7ZOgz+sxqrRT6s80/XNLo925VmwNYIR0Ntn2dElmMlZfuzQPy8AX4IxcUp7oGKBhJpkV/oP3yqqcgHByKS7jBTSNY6fGXqxKhDLzayatWgL4gnV8GD9o2amDKB82B4rhyD5cMI4SJvjSJhtvbjj3hH3nuy3hbY28xYNslJ7knrYuQe8j7xHC3W9uIbCt0ZuN5B2rnf+WDud9J6aGWfBH0fTmmsegLeGletjT6jZx4bk1oOBJqQtpzEYUr/YYikZAi+rpi4oIFGqj+JPfMpXsZSvFZHIrK/1rg6ZG2MdYx0gbqn6hdS+pWDTNsDn/f/fv5JmOt9Jx9D2HmWmpn717InUTq9OBNTnCn58mMKRop8VGyziMbNxweJB+Fr1lcT+srp5tz29DvATCKFLCRtwwvptZ+gj8T6me76F60kD5kMNnrNtuvYkv9CTRgRMSD1IFkc3y9RlDHdeHttmxmfDRq6hdV1SYAHFBIkJcLteo1A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6ol6lMOdee5YHDEc8UDKM+2V7XzkUXtW3X7GCBFtA+yovAETHm1vt0p1JxAO8Ixw9J4g5GkQ8/zqAI/WjTvwSyVhBIGZrdOa08stw+ZQ84KfjBmTVjcdvxaP+qwZpp+ZtwCCV40pz67LBE+6i24stf4WliqxqUkK6njcaNrrJOuP9ZQdB25woR+YfZd/edToQ2umUhqyPIeRX3JviqRMTKPDP1tpodWO0vLgMTMoEOITcxHMd5MandgQg1CFBKKLyzRpVwIh0fQgiNChCs9z9CZeCXeJ4KKCEGFGr0Dzo+uvZsrNOmga3EcGCMRajGgKU0KxDIoGCp9bmaoQJRbhhkDtr50wTtuo/OaVtuNmu8o8JuDacLoPXVbzwsW3GhR1SlPTesWd7v+1HdURGcXRJmYy4pmXH1roKK02HwUm9N75mb4dF0XKvY3ItQKP2xFC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 18:15:05.8459 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bb4d6ba-99e6-471a-de96-08de9fd1ea2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9181
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

From: Max Zhen <max.zhen@amd.com>

Add more trace coverage to amdxdna job handling and mailbox receive
processing to make driver execution easier to debug.

Extend the xdna_job trace event to record the command opcode in
addition to the job sequence number. Use the enhanced tracepoint in
the job run, sent-to-device, signaled-fence, and job-free paths so
that trace output can be correlated with the command being executed.

Also add debug-point tracing when a command is received through the
submit ioctl path, and add a trace event when the mailbox RX worker
runs.

These changes improve visibility into job lifetime transitions and
mailbox activity, which helps debug command flow and scheduler issues.

Signed-off-by: Max Zhen <max.zhen@amd.com>
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/aie2_ctx.c        | 14 ++++++---
 drivers/accel/amdxdna/amdxdna_ctx.c     |  3 +-
 drivers/accel/amdxdna/amdxdna_ctx.h     |  1 +
 drivers/accel/amdxdna/amdxdna_mailbox.c |  1 +
 include/trace/events/amdxdna.h          | 42 ++++++++++++++++---------
 5 files changed, 42 insertions(+), 19 deletions(-)

diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
index d37123d925b6..3b0feba448c4 100644
--- a/drivers/accel/amdxdna/aie2_ctx.c
+++ b/drivers/accel/amdxdna/aie2_ctx.c
@@ -64,6 +64,7 @@ static void aie2_job_release(struct kref *ref)
 	struct amdxdna_sched_job *job;
 
 	job = container_of(ref, struct amdxdna_sched_job, refcnt);
+
 	amdxdna_sched_job_cleanup(job);
 	atomic64_inc(&job->hwctx->job_free_cnt);
 	wake_up(&job->hwctx->priv->job_free_wq);
@@ -195,7 +196,8 @@ aie2_sched_notify(struct amdxdna_sched_job *job)
 {
 	struct dma_fence *fence = job->fence;
 
-	trace_xdna_job(&job->base, job->hwctx->name, "signaled fence", job->seq);
+	trace_xdna_job(&job->base, job->hwctx->name, "signaling fence",
+		       job->seq, job->drv_cmd ? job->drv_cmd->opcode : DEFAULT_IO);
 
 	aie2_tdr_signal(job->hwctx->client->xdna);
 	job->hwctx->priv->completed++;
@@ -366,6 +368,9 @@ aie2_sched_job_run(struct drm_sched_job *sched_job)
 	struct dma_fence *fence;
 	int ret;
 
+	trace_xdna_job(sched_job, hwctx->name, "job run",
+		       job->seq, job->drv_cmd ? job->drv_cmd->opcode : DEFAULT_IO);
+
 	if (!hwctx->priv->mbox_chann)
 		return NULL;
 
@@ -409,7 +414,8 @@ aie2_sched_job_run(struct drm_sched_job *sched_job)
 	} else {
 		aie2_tdr_signal(hwctx->client->xdna);
 	}
-	trace_xdna_job(sched_job, hwctx->name, "sent to device", job->seq);
+	trace_xdna_job(sched_job, hwctx->name, "sent to device",
+		       job->seq, job->drv_cmd ? job->drv_cmd->opcode : DEFAULT_IO);
 
 	return fence;
 }
@@ -419,7 +425,8 @@ static void aie2_sched_job_free(struct drm_sched_job *sched_job)
 	struct amdxdna_sched_job *job = drm_job_to_xdna_job(sched_job);
 	struct amdxdna_hwctx *hwctx = job->hwctx;
 
-	trace_xdna_job(sched_job, hwctx->name, "job free", job->seq);
+	trace_xdna_job(sched_job, hwctx->name, "job free",
+		       job->seq, job->drv_cmd ? job->drv_cmd->opcode : DEFAULT_IO);
 	if (!job->job_done)
 		up(&hwctx->priv->job_sem);
 
@@ -437,7 +444,6 @@ aie2_sched_job_timedout(struct drm_sched_job *sched_job)
 	int ret;
 
 	xdna = hwctx->client->xdna;
-	trace_xdna_job(sched_job, hwctx->name, "job timedout", job->seq);
 
 	guard(mutex)(&xdna->dev_lock);
 
diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/amdxdna_ctx.c
index ff6c3e8e5a15..2c2c21992c87 100644
--- a/drivers/accel/amdxdna/amdxdna_ctx.c
+++ b/drivers/accel/amdxdna/amdxdna_ctx.c
@@ -514,7 +514,6 @@ int amdxdna_cmd_submit(struct amdxdna_client *client,
 		goto unlock_srcu;
 	}
 
-
 	job->hwctx = hwctx;
 	job->mm = current->mm;
 
@@ -612,6 +611,8 @@ int amdxdna_drm_submit_cmd_ioctl(struct drm_device *dev, void *data, struct drm_
 	if (args->ext || args->ext_flags)
 		return -EINVAL;
 
+	trace_amdxdna_debug_point(current->comm, args->type, "job received");
+
 	switch (args->type) {
 	case AMDXDNA_CMD_SUBMIT_EXEC_BUF:
 		return amdxdna_drm_submit_execbuf(client, args);
diff --git a/drivers/accel/amdxdna/amdxdna_ctx.h b/drivers/accel/amdxdna/amdxdna_ctx.h
index a8557d7e8923..355798687376 100644
--- a/drivers/accel/amdxdna/amdxdna_ctx.h
+++ b/drivers/accel/amdxdna/amdxdna_ctx.h
@@ -119,6 +119,7 @@ struct amdxdna_hwctx {
 	container_of(j, struct amdxdna_sched_job, base)
 
 enum amdxdna_job_opcode {
+	DEFAULT_IO,
 	SYNC_DEBUG_BO,
 	ATTACH_DEBUG_BO,
 	DETACH_DEBUG_BO,
diff --git a/drivers/accel/amdxdna/amdxdna_mailbox.c b/drivers/accel/amdxdna/amdxdna_mailbox.c
index 37771bdb24a1..cc8865f4e79c 100644
--- a/drivers/accel/amdxdna/amdxdna_mailbox.c
+++ b/drivers/accel/amdxdna/amdxdna_mailbox.c
@@ -361,6 +361,7 @@ static void mailbox_rx_worker(struct work_struct *rx_work)
 	int ret;
 
 	mb_chann = container_of(rx_work, struct mailbox_channel, rx_work);
+	trace_mbox_rx_worker(MAILBOX_NAME, mb_chann->msix_irq);
 
 	if (READ_ONCE(mb_chann->bad_state)) {
 		MB_ERR(mb_chann, "Channel in bad state, work aborted");
diff --git a/include/trace/events/amdxdna.h b/include/trace/events/amdxdna.h
index c6cb2da7b706..71da24267e52 100644
--- a/include/trace/events/amdxdna.h
+++ b/include/trace/events/amdxdna.h
@@ -30,26 +30,30 @@ TRACE_EVENT(amdxdna_debug_point,
 );
 
 TRACE_EVENT(xdna_job,
-	    TP_PROTO(struct drm_sched_job *sched_job, const char *name, const char *str, u64 seq),
+	    TP_PROTO(struct drm_sched_job *sched_job, const char *name,
+		     const char *str, u64 seq, u32 op),
 
-	    TP_ARGS(sched_job, name, str, seq),
+	    TP_ARGS(sched_job, name, str, seq, op),
 
 	    TP_STRUCT__entry(__string(name, name)
 			     __string(str, str)
 			     __field(u64, fence_context)
 			     __field(u64, fence_seqno)
-			     __field(u64, seq)),
+			     __field(u64, seq)
+			     __field(u32, op)),
 
 	    TP_fast_assign(__assign_str(name);
 			   __assign_str(str);
 			   __entry->fence_context = sched_job->s_fence->finished.context;
 			   __entry->fence_seqno = sched_job->s_fence->finished.seqno;
-			   __entry->seq = seq;),
+			   __entry->seq = seq;
+			   __entry->op = op;),
 
-	    TP_printk("fence=(context:%llu, seqno:%lld), %s seq#:%lld %s",
+	    TP_printk("fence=(context:%llu, seqno:%llu), %s seq#:%llu %s, op=%u",
 		      __entry->fence_context, __entry->fence_seqno,
 		      __get_str(name), __entry->seq,
-		      __get_str(str))
+		      __get_str(str),
+		      __entry->op)
 );
 
 DECLARE_EVENT_CLASS(xdna_mbox_msg,
@@ -81,18 +85,28 @@ DEFINE_EVENT(xdna_mbox_msg, mbox_set_head,
 	     TP_ARGS(name, chann_id, opcode, id)
 );
 
-TRACE_EVENT(mbox_irq_handle,
-	    TP_PROTO(char *name, int irq),
+DECLARE_EVENT_CLASS(xdna_mbox_name_id,
+		    TP_PROTO(char *name, int irq),
 
-	    TP_ARGS(name, irq),
+		    TP_ARGS(name, irq),
 
-	    TP_STRUCT__entry(__string(name, name)
-			     __field(int, irq)),
+		    TP_STRUCT__entry(__string(name, name)
+				     __field(int, irq)),
 
-	    TP_fast_assign(__assign_str(name);
-			   __entry->irq = irq;),
+		    TP_fast_assign(__assign_str(name);
+				   __entry->irq = irq;),
+
+		    TP_printk("%s.%d", __get_str(name), __entry->irq)
+);
+
+DEFINE_EVENT(xdna_mbox_name_id, mbox_irq_handle,
+	     TP_PROTO(char *name, int irq),
+	     TP_ARGS(name, irq)
+);
 
-	    TP_printk("%s.%d", __get_str(name), __entry->irq)
+DEFINE_EVENT(xdna_mbox_name_id, mbox_rx_worker,
+	     TP_PROTO(char *name, int irq),
+	     TP_ARGS(name, irq)
 );
 
 #endif /* !defined(_TRACE_AMDXDNA_H) || defined(TRACE_HEADER_MULTI_READ) */
-- 
2.34.1

