Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5785960A2610
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 16:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=cPzYzYjg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A50CD10EF71;
	Mon, 19 Oct 2026 16:48:44 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010044.outbound.protection.outlook.com [52.101.85.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73B9A10EF4C
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 16:48:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kmQ9iaxT4x1+4Qao220wzV43rm7uuWV5wW/I29dGaZEPvNGgFH0WoUwH2i2M8YUw5rmWXaAkshTV53Plx3IIgS3CcXR3ldpF+X1GfVfbfUHDph6O48oJv7JSoUhvt7BkU9POIh2zqMdKjZlPQgqnl/Ooftn1qEZ3gPCr1F7KJZj43tTRFRrMC8ccNK2lLxoDFatMhZkieTab5/+6CelI5wUKZjmC0bf4wgrU9Y+1EtzvAN9zj2VuvMTpgbNcGvN9H/tS/T2OeBrCNZkEcaJY4M0LsrI3eogCfQB2wgR8feh1Gj/vCI+suBE07azQaOp09gEyKYwBZBc0voycs2UcHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2SRnAFD37fwNQIxvYDbvLrXlRniCOA92cu76eW/1Um8=;
 b=LJIvvO0V41mXupkGklyuxoSU5jguLzMsapEH6NowZn639hY0bF9EzY3f3NhFfpI5ddGeMhjfbOWhwLME1ubKF0uPmteBHUpf53IFutSNV6yeoRYGJrR8mNVWCGGD4t1pW3ISa3XQW+6MN/ySQ4Wche2nY80sqE3mZa7jajr1pKwwAcrRPTwVPxQec3xEzPNiGEFZNJO1Fs3GJtLvFm7ab71l20CVBxtHqMjl3Txp910OOO9fhSpC6F3JKFxRfCm9cXb8JijIvGITdRIvsZDj/nIgIeBdwZjgXKYOZbOmeAS41Ncey0SZGEht1ClnznnsKmrUSa5KqOSfmgBM0qGXUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2SRnAFD37fwNQIxvYDbvLrXlRniCOA92cu76eW/1Um8=;
 b=cPzYzYjgvGbkbKnoTHCAjzgDlRJaqtq/+0crB3LMQCKEKdh19/tov9x6UA6ccIuyLyeo5Lnl9In8W2X6qOFiVwjVgsxZnZGgfjKvoY6vtUzrzPlsOTFlac2MrWjZgf//ONjY8MVJkgE3ElUcjHUc90XGuIq0TpO2odZCq+rI0s8=
Received: from DS7P221CA0006.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:25b::19) by
 CY1PR12MB9625.namprd12.prod.outlook.com (2603:10b6:930:106::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 16:48:01 +0000
Received: from DS4PEPF000001BE.namprd21.prod.outlook.com
 (2603:10b6:8:25b:cafe::61) by DS7P221CA0006.outlook.office365.com
 (2603:10b6:8:25b::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 16:48:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS4PEPF000001BE.mail.protection.outlook.com (10.167.23.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.0 via Frontend Transport; Mon, 19 Oct 2026 16:48:01 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 11:47:53 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 11:47:53 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via
 Frontend Transport; Mon, 19 Oct 2026 11:47:52 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>, Wendy Liang <wendy.liang@amd.com>
Subject: [PATCH V5 13/19] accel/amdxdna: Prepare for AIE4 command submission
Date: Mon, 19 Oct 2026 09:47:40 -0700
Message-ID: <20261019164746.827277-14-yidong.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS4PEPF000001BE:EE_|CY1PR12MB9625:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a7ddd99-5d91-47ef-1c50-08df2e00bccf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|4143699003|11063799006|56012099006|5023799004|261009223027099003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: tlJQWehgnyTbyb65ExUylAZtFUJ/rgM+Z/vKN4tKc0Yt2GViOtQLiqQ462lG2FHSjKSDVigOoXAyhrzd2h0+V/2tNIgOcgOiFE7iJ8tBfMTU4/4PQJsKc7/92nTuU9TwURnQrg1q0jdAumDZ8/f1ftVSz8aHJWKxise5GSZVKeFljR1vP7Uvx2Gc1/GTZ+9MK6rKRPfFfLiyQumDLtAE+iLJRPhOi+tiTUqMd6h2qWyaojW8tPHvQiV/MqvF/X05XcXusXj4H2NShtBo0wKAeoiSOLbsP+2Q5ZyBCLFsifI4ZTorExatrKfM2ra6zdWaSpstyY83mdqNsbymTveIy7GQu+PvvDm6ET24t5h6JuBI5NfVpPbQ605DmXNHzUQCSIJ3m5wdbsofQ9jKNs0xWYxVAWb2oI9T4DKyds243OqAhrEge6oQTlGoyxpoYWYi//BiObvZToKpvrU9JlnZlbgJbFxxKyXtM9Y6yyMof0YanBBw87DDrB+sDWIDpn/caqiSszLvc5c5zWC3Gl58VHwYxeB042LH6RNxOPCAVu8zAmyl12eRcorTDb5c/+KP3+K+l4dTdXumJG66mI551wKefYlvuWzzX926O0Mb/VaxFyvUsYFCQ+EdDanOnQb4W1pYF79J2C/RNzT2xHq4FFkL6bHgg99vgowU3vkJFM8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(4143699003)(11063799006)(56012099006)(5023799004)(261009223027099003)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dLc4o7+dnQyRwEozve9d2w7JB9AV49L+PUFH1g87rVIFlrmvrz9Fdpgt96GQXYkNtpVoZSSrtXTR+KaUEvErhod0ThiN4gR0IEbB7K4Aj/j18mpengSYUlDbTvVdUGKV1Bh6z8jrkfd/51E8xWs3fkEvvLxGcOfOv+Gf2B44wS+DCHhdKE59x9Na9bm3lpY5oqoLnrer6TciPK+rm/t6cAtid0f9k7DrfMpWyKYs3q+T5ykbf4OirPvNSdofpIwhCP/Zyfme7LbFZX8ePlasmQkMK0kEjCGiEeGOUi3aubj4ycvwAS2eXC8az82SVI+3uwgKhTwHMFO8HdkJkxQd1fi7HHCnAXGCYFdRqul6o5TrgsrBAWlfEkGT7zaRQGZw9iA7T289NKdli3PFYffv32IuFs7P88cY45LIj9kt0u90dZxX9jRt5oEoSsFh1ufY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 16:48:01.1688 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a7ddd99-5d91-47ef-1c50-08df2e00bccf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS4PEPF000001BE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9625
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

Prepare the data structures and completion wait helpers required for
AIE4 command submission:
- Define struct amdxdna_cmd_start_dpu in amdxdna_ctx.h for the
  ERT_START_DPU payload.
- Extend union amdxdna_job_priv with an aie4 member for queue list
  linkage and job state tracking.
- Implement smp_rmb() ordering and non-sleeping retry in
  get_read_index(), returning zero (no completion) when the sample
  is still invalid after the retry.
- Add cmd_done_or_unlinked() to wake on completion or on asynchronous
  device disconnect and reset, detected via check_cert_comp_linked(),
  and record completion, so aie4_cmd_wait() does not re-read state
  that can change after the wait.

read_index is written by firmware to host memory, so the wait path
handles these cases:
- A torn or invalid read_index is never reported as a completion.
- -EAGAIN is returned only when the context is disconnected before
  completion is seen; the command state and fence are not affected.
- Completion is recorded inside the wait condition, so a context
  unlinked and relinked during the wait cannot report a false
  completion.

Co-developed-by: Max Zhen <max.zhen@amd.com>
Signed-off-by: Max Zhen <max.zhen@amd.com>
Co-developed-by: Wendy Liang <wendy.liang@amd.com>
Signed-off-by: Wendy Liang <wendy.liang@amd.com>
Signed-off-by: David Zhang <yidong.zhang@amd.com>
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/aie4_ctx.c    | 73 ++++++++++++++++++++---------
 drivers/accel/amdxdna/amdxdna_ctx.h | 20 ++++++++
 2 files changed, 71 insertions(+), 22 deletions(-)

diff --git a/drivers/accel/amdxdna/aie4_ctx.c b/drivers/accel/amdxdna/aie4_ctx.c
index 767ba6ecbfc6..bb126fbae10d 100644
--- a/drivers/accel/amdxdna/aie4_ctx.c
+++ b/drivers/accel/amdxdna/aie4_ctx.c
@@ -399,56 +399,85 @@ static inline bool valid_queue_index(u64 read, u64 write, u32 capacity)
 
 static u64 get_read_index(struct amdxdna_hwctx *hwctx)
 {
-	u64 wi = READ_ONCE(*hwctx->priv->umq_write_index);
-	u64 ri = READ_ONCE(*hwctx->priv->umq_read_index);
+	struct amdxdna_hwctx_priv *priv = hwctx->priv;
 	struct amdxdna_dev *xdna = hwctx->client->xdna;
+	u64 ri, wi;
+
+	/* Sample read_index before write_index to guarantee wi >= ri. */
+	ri = READ_ONCE(*priv->umq_read_index);
+	/* Order the read_index sample before the write_index sample. */
+	smp_rmb();
+	wi = READ_ONCE(priv->write_index);
 
-	/*
-	 * CERT cannot update read index as uint64 atomically. Driver may read
-	 * half-updated read index when it has bits in high 32bit. In case read
-	 * index is not valid, wait for some time and retry once. It should
-	 * allow CERT to complete the read index update.
-	 */
+	/* Non-atomic 64-bit counter update by CERT; re-sample once if invalid. */
 	if (!valid_queue_index(ri, wi, CTX_MAX_CMDS)) {
-		XDNA_WARN(xdna, "Invalid index, ri %llu, wi %llu", ri, wi);
-		usleep_range(100, 200);
-		ri = READ_ONCE(*hwctx->priv->umq_read_index);
+		ri = READ_ONCE(*priv->umq_read_index);
+		/* Order the read_index sample before the write_index sample. */
+		smp_rmb();
+		wi = READ_ONCE(priv->write_index);
 		if (!valid_queue_index(ri, wi, CTX_MAX_CMDS)) {
-			XDNA_ERR(xdna, "Invalid index after retry, ri %llu, wi %llu", ri, wi);
-			ri = 0;
+			/* 0 <= any seq: callers always treat it as "not done" and retry. */
+			XDNA_DBG(xdna, "Invalid index, ri %llu, wi %llu", ri, wi);
+			return 0;
 		}
 	}
 
 	return ri;
 }
 
-static inline bool check_cmd_done(struct amdxdna_hwctx *hwctx, u64 seq)
+/* Verify cert_comp remains linked to detect disconnect or reset. */
+static bool check_cert_comp_linked(struct amdxdna_hwctx *hwctx, struct cert_comp *comp)
 {
-	u64 read_idx = get_read_index(hwctx);
+	/* READ_ONCE pairs with the link/unlink WRITE_ONCE. */
+	return comp == READ_ONCE(hwctx->priv->cert_comp);
+}
 
-	return read_idx > seq;
+/*
+ * Lockless wait condition: wake on completion or disconnect. Record
+ * completion, so callers do not re-read state that can change after the
+ * wait.
+ */
+static inline bool cmd_done_or_unlinked(struct amdxdna_hwctx *hwctx, u64 seq,
+					struct cert_comp *comp, bool *done)
+{
+	*done = get_read_index(hwctx) > seq;
+	return *done || !check_cert_comp_linked(hwctx, comp);
 }
 
+/*
+ * Return 0 once seq completed, or -EAGAIN if the context is disconnected
+ * before seq completed.
+ */
 int aie4_cmd_wait(struct amdxdna_hwctx *hwctx, u64 seq, u32 timeout)
 {
 	unsigned long wait_jifs = MAX_SCHEDULE_TIMEOUT;
 	struct cert_comp *cert_comp = aie4_get_cert_comp(hwctx);
+	bool done = false;
 	long ret;
 
-	if (!cert_comp)
+	if (!cert_comp) {
+		/* Not connected: read_index in host memory is still valid. */
+		if (get_read_index(hwctx) > seq)
+			return 0;
 		return -EAGAIN;
+	}
 
 	if (timeout)
 		wait_jifs = msecs_to_jiffies(timeout);
 
 	ret = wait_event_interruptible_timeout(cert_comp->waitq,
-					       (check_cmd_done(hwctx, seq)),
+					       cmd_done_or_unlinked(hwctx, seq, cert_comp,
+								    &done),
 					       wait_jifs);
+	aie4_put_cert_comp(cert_comp);
 
+	if (ret < 0)
+		return ret;
+	if (done)
+		return 0;
 	if (!ret)
-		ret = -ETIME;
-
-	aie4_put_cert_comp(cert_comp);
+		return -ETIME;
 
-	return ret <= 0 ? ret : 0;
+	/* Woken by disconnect before seq completed. */
+	return -EAGAIN;
 }
diff --git a/drivers/accel/amdxdna/amdxdna_ctx.h b/drivers/accel/amdxdna/amdxdna_ctx.h
index 9bbc3db4ebde..b3677851d1c5 100644
--- a/drivers/accel/amdxdna/amdxdna_ctx.h
+++ b/drivers/accel/amdxdna/amdxdna_ctx.h
@@ -48,6 +48,18 @@ struct amdxdna_cmd_start_npu {
 	u32 prop_args[];  /* properties and regular kernel arguments */
 };
 
+/*
+ * struct amdxdna_cmd_start_dpu - interpretation of data payload for
+ * ERT_START_DPU in amdxdna_cmd.
+ */
+struct amdxdna_cmd_start_dpu {
+	u64 dtrace_buffer;		/* dtrace buffer address 2 words */
+	u64 instruction_buffer;		/* buffer address 2 words */
+	u32 instruction_buffer_size;	/* size of buffer in bytes */
+	u16 uc_index;			/* microblaze controller index */
+	u16 chained;			/* number of following amdxdna_cmd_start_dpu elements */
+};
+
 /*
  * Interpretation of the beginning of data payload for ERT_CMD_CHAIN in
  * amdxdna_cmd. The rest of the payload in amdxdna_cmd is cmd BO handles.
@@ -138,8 +150,14 @@ struct amdxdna_drv_cmd {
 };
 
 struct app_health_report;
+
 union amdxdna_job_priv {
 	struct app_health_report *aie2_health;
+	/* aie4 kernel submission: queue linkage + job state */
+	struct {
+		struct list_head	list;
+		u32			state;
+	} aie4;
 };
 
 struct amdxdna_sched_job {
@@ -162,6 +180,8 @@ struct amdxdna_sched_job {
 };
 
 #define aie2_job_health priv.aie2_health
+#define aie4_job_list	priv.aie4.list
+#define aie4_job_state	priv.aie4.state
 
 static inline u32
 amdxdna_cmd_get_op(struct amdxdna_gem_obj *abo)
-- 
2.34.1

