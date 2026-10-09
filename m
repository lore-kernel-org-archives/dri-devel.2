Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 012E9CA9EC1
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 22:54:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04CEA112306;
	Fri,  9 Oct 2026 22:54:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V2s1YOdQ";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011067.outbound.protection.outlook.com [40.107.208.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1451112308
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 22:54:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bCrFdZAI2bApo8eX3Zc1Hor9LW7v10/x/MXupZwulX7F4AJesrxsPaOAhsNf47PC46tZP7qH9wXCl2dajZBM8cvPHqTyxnsPQNy1Q+e6SVaswHwhJYaPTLoSi/L617LwAw0oHxzQp+/raN38uwXdH1dVO06Xv5Skc1GC5IdUVVk2KWj32FsuRIRolXHZlZMbbrtwKKg0L6C+EOUI7ZsPFhamES1u3y9Oy4Udnrim0m7Le+EvMA+sZd5rKu+1n6CexnEPwaIMOpi7Hl0vFaEA1puumCwY7EtfurLNI4KzC3kUWI9A5N2hQ3vCPMT/Y0IJwfXtwlOhSWJEvubeKd0amQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vEPb/5jeTM3tP6PyBgscYNhbkQmo4YSEq3jbNKo+ndw=;
 b=Esh4u7kexWQ2UInwScSr3adR55wADuZNTe6KbwoT5DrvEMUrSPYtRL8eZj2zDDfs65+4XHGYGskkwaXjSc8RLxCnbPOaUnLpm83v1iGi5vho44vpjjuO08HQMXxB1p1hzJRTIE1YRf7OFSJZ6SIi9wsGMnGTe527IEPf1w19n83/40+eNRtleMHtbmNu1CcDNcVjerf0Zrk83KMHqYweO4xnGgxEbZL8kH1ITsYlkCb+CNonH82eNvOUUwNkEItMXrzKeystLuH22CrBGc25c5mFOK2nTMmgQBKPa12fd2bgmfh2QhHWTAhv6PsNlCuqg1zOK/JuVT/2wXP6UfpBlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vEPb/5jeTM3tP6PyBgscYNhbkQmo4YSEq3jbNKo+ndw=;
 b=V2s1YOdQR7qizHuPAv3K65pnrCHe/pN1f3lIZuJD07qY7I128p7hsKA8I26jXw5lBGlP8PAAPeL0RmH8TCPFKYAtfuDY/zfQFv0HaTWheoWvJ622uqm5XJBUbeaiqkRfxT2P2G2nd6cRPk7VwNNfWzNXroZNRGPGGcqv1jIcybY=
Received: from BN0PR04CA0139.namprd04.prod.outlook.com (2603:10b6:408:ed::24)
 by IA0PR12MB7699.namprd12.prod.outlook.com (2603:10b6:208:431::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Fri, 9 Oct
 2026 22:54:02 +0000
Received: from BN2PEPF000055E0.namprd21.prod.outlook.com
 (2603:10b6:408:ed:cafe::a6) by BN0PR04CA0139.outlook.office365.com
 (2603:10b6:408:ed::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 9
 Oct 2026 22:54:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055E0.mail.protection.outlook.com (10.167.245.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.0 via Frontend Transport; Fri, 9 Oct 2026 22:54:01 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 9 Oct
 2026 17:53:55 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Fri, 9 Oct 2026 17:53:54 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>, Wendy Liang <wendy.liang@amd.com>
Subject: [PATCH V4 13/19] accel/amdxdna: Prepare for AIE4 command submission
Date: Fri, 9 Oct 2026 15:53:37 -0700
Message-ID: <20261009225343.3079074-14-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261009225343.3079074-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20261009225343.3079074-1-yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E0:EE_|IA0PR12MB7699:EE_
X-MS-Office365-Filtering-Correlation-Id: 6423f556-d61d-47ba-28aa-08df26583654
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|22082099003|3023799007|10067099003|56012099006|11063799006|18002099003|5023799004|4143699003;
X-Microsoft-Antispam-Message-Info: 15otoWv8gvI+6UQ35JUTkY+9q0jEoJdpjS9I4r8G3QOqZbgB4ULHLRzyJKAvMgoiOLsZ0//rOtTa3aetBSyAMRgoqmbIQTSZkCq8mM6L0yW0uXVVipIuhTXnKJC+Dk8OdcYZ3NJ7m4qknaKxrg1d1akHjM2qaWciyiJ/GufogqfQXTIdG6nff3o1Kw3/KsAOo4/iCf13RpzTRPrO7az3YasYvNe3G3+jkbi4W3er0lCRuheBcILZBYVHtEaUFqqEVS6ybLDy5NIA9CrCkDa8LHG/JrkkAfjWKoqwnei7f1YoZ0OYOTyBhE4lbPOlSrjC276vPUMHR1o62eX4DlAwEaNIF6Et3gr+PcJjyfwyx6VDoY9zNazHIMQZQ8NGAwXMdq6eQxnSMu63s8N1H3LxKNnxi1bnD542Nm8/PAlJFbNcG/eNYl6TFvCqlL4X9BKLWgOszOt2WA3TbGmsqLQcWfuN23Io+7rmr8PX7DVJT7ORu6fjuLskpZvWKP32DOf4kqwLsmbVn/URB7nz2of6/ha7GB3EJZwyBENe7wggY/Ic5dilJOVq65b6tPAz+Gm2y+b61ckN9gpu5sJqEkkhyWMaV4+0LFLgmhr53GXKVEOnJjfsOgumWeO9ixlj2qmUsOdmJHnGdIn+uGw0U3JZAIVMrhlY/PP8LpcqcRBJRcDkee8kUjZdXusZgf2gx/j/Y/4gH90U3SfsK3JJBiCOuQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(22082099003)(3023799007)(10067099003)(56012099006)(11063799006)(18002099003)(5023799004)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rrvjzzEjw2McHnoY9gxZJnyXl+btSOznim21nrmo27gARFaNE+6ZuBLaYnrLsHbHJkvpJGMluvhb/LmH1Ue2/QGsPJA2dCRbz30gr2BmcPHtWoVJV+06zioJno6IUKwY4CfiA4EhoUvOK0ySsZ1w2KsjScRJ87tU/WYVPXUNwfKs8RdpYaTWtNC+fJDMZs6Q3HGo/XY+9TSuKE4cGjYYvm+4x5p6O7SW556JiF0AR5MWQdmUKWAssqHV8mudSY1Ockumb7KQ5zPKhwKwxIGH4Rgo9Ivd6BvnPTua2BEIk+NEaPs0LlrVaILOooUFlxDNFojVGj/Xe6EG0/4zqUsoj0IPLoiJZrpndM8gAekaPpueJOqq29lQUykeWPNBN6dtknEZCGuv3z+VoFircF/z8uG3yI0un3AOsm1P5men/WB/dzlQs5iHz4WzrM1RlA0D
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 22:54:01.9935 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6423f556-d61d-47ba-28aa-08df26583654
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E0.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7699
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

