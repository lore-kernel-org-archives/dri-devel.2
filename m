Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2FAECA6002
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 04:23:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3B4310EF83;
	Tue,  6 Oct 2026 04:23:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uQuu1HS5";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012055.outbound.protection.outlook.com [52.101.48.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4ACD810EF7C
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 04:23:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m3kuOc8DpkC+F3f+K7G577NlcSI4J/QfDDazVtL/IfM5X4OChik5WIOoc9NjuGVwp0gKvrnEAt7uCDysZBecAKq6mtT9J72zKT9FbKn44H3ucRmTxAf9zJdhIo3LQLKBSJgGctslAmEvajWr+1hFiJicCue7VjbBQy13RhCMiJPnaKahAfzPur92bXoXft6NSdC2oyp366cuahqvfBmDHKheZd23+cZVwzFMQhT+OIC6RrhoSBi2Xrh/9ZMsbXDFv1KzWsHfjTt/Kxyi8rXJkGRrK2XAWe6MVFKqVtI8CAsKjOis7Rl5voh7PQWCmKuMHnexp9aenmdRzKibXnv6jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nmvOwzoh2pXCdgnk2rlddsPWsHQ6TRzOLhyDRcmfKk=;
 b=iy2KCavlJ5gP4A6pYuCT+tKqPkt/PJaoF55kkKDRUGdWlljz344xSv41m8ZS4LO5P11Y45SHfdER73o+CrfOPrGIjdBiwQi1TYKjgJx/FXrpCWOpFNYGwkfNGxtvqbyjcSw/LjcavB4pkgbpOumun7lLPPbwJgYVTT43rpPeFLyQJ/WS064gO9WOlxeHF8U4/hYbk8HRrp/YRKoKr58Ie6lsFQZJ1lxCzT7nc1dZVM8lwXVCbs2w82t4D4voGEVTGp2asu2aD4bTImtJymjXIpbsmvwd6C48yh7ij4mnozVfYoCAb5tOpII38nRh0OqIp1eL2K1SI+E9LCQJjnDz0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nmvOwzoh2pXCdgnk2rlddsPWsHQ6TRzOLhyDRcmfKk=;
 b=uQuu1HS5L0cgyhIiCe28UIsINdMs5awt2Ubx+/+x/fLrD0oNIoRV4vQXizQL7WLIXhAg9cFiJCBig1RnSN5NYboRyPFc+m1k7FT7MUg0/Myztbp06uAAmpvC2/Leqft1nqXS0etz2Mn+Md7O36yAdLjqOKjlmERp3lbXeNOpjCg=
Received: from BN9PR03CA0296.namprd03.prod.outlook.com (2603:10b6:408:f5::31)
 by DS7PR12MB5815.namprd12.prod.outlook.com (2603:10b6:8:77::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Tue, 6 Oct
 2026 04:22:58 +0000
Received: from BN2PEPF0000A805.namprd02.prod.outlook.com
 (2603:10b6:408:f5:cafe::44) by BN9PR03CA0296.outlook.office365.com
 (2603:10b6:408:f5::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue, 6
 Oct 2026 04:22:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A805.mail.protection.outlook.com (10.167.245.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Tue, 6 Oct 2026 04:22:57 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 23:22:56 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 23:22:56 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Mon, 5 Oct 2026 23:22:56 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>, Wendy Liang <wendy.liang@amd.com>
Subject: [PATCH V2 13/20] accel/amdxdna: Prepare for AIE4 command submission
Date: Mon, 5 Oct 2026 21:22:23 -0700
Message-ID: <20261006042230.547807-14-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261006042230.547807-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20261006042230.547807-1-yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A805:EE_|DS7PR12MB5815:EE_
X-MS-Office365-Filtering-Correlation-Id: c06787b6-f5b1-4b07-7677-08df23618035
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|10067099003|5023799004|56012099006|4143699003|11063799006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ARLUBa+7/3mDlr1Gr7lKCcUoJbrKliYHjL0i805JrWRNN5IwVFtw9Qe9DQUpoCrKOD8DDBhBUayzCmfhfxWLhpxPtbNAVNy/KWRKfSQO+OnOAuKNM4ZteeAMw0xZvMuFjC5napa29u8ky7bp7ehWOS/fN3aSJpUKgmo4t7HBX6zzBrxq4qzOtnxljpUi6QV7YlXch0TGwAz/u8wuCUJKSMQiV8WQ1OY6/FqA+zDpWoSn8Y5ZGgWG7nmhE9xZFR4xjoT7jba4yEcSIcfL5V+YykjSEiUesOb3j92wn+fBit5vmlxwvbH0uugYIBnK/hAAC+IpeVKjLgQDBWev3LaQEz8CnFlK3LvyXM7pjDZOoVkDWsU32jMrQ5S+5phQR/FQIPqH+MTFRWW2SpwyBFR3jVBAIOERREN4Dk7O9n+NjiJYIxvNRwEvgWjKR4wB4j2vExy1TA5yFxd6aq6FUVwgSH9xjXIJJbj2Qlus/7TXI0FHmZLe4Fq33G83BKolaZzCwX+dIfbCzlMaPxWYBPI3BmbofUKd5yWdhkWaeNLdi4yKUGGl+gthAzMXvN7rHoRV4kERPKErzTh5N+CUgdd3ucsxknybowp+6YgIJKO0uv2bGLcBObIdGtzvmioYNXG5NmaF5cXfeKBCDGAEomb/R561RYh/JXJY+JurBVOH3QOBmBbuWNVnZBvznTsHkZ0bTTGbXUayDSOuJ12MgpL1jA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(10067099003)(5023799004)(56012099006)(4143699003)(11063799006)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iHiSx2ClIOcOIdDnZNcStJCub86IvKjEjnEkckC2IqOPoIoXAPkE/ooUYEwSMfXvd/cPJlnaGGjR/crvBVu9jzc/1T/HxLDCR0K53f0KSQIkYbjSBdgwpnchXeS/kxcJJpGR4w5KGm9uqzkGvcrzRkFeV3SbommAeboj43g0e+i3cIjZ3sn1gSqD7Z5U5Nw5ZsHAhIPeB1eRK154unoIzI3MIZ5ujlZ5qTVYR4PQLrwI20Q4OStTXIg2WQ44AMAJjbLDh8OcqU3P/FHBh8w0UHktZoWTAVWdDIlyGUCULzARxFUDqlVJwbwWFHYsuP8hLGimJ1ZyeRy7NNBJnrUZ8erj1lHN/WoC6YGR5tdPSb2S5o5cE/4UObtbWncXtpqnDiss3lwJOWb9cPVeP7bMJZqEIFySbUZ9SgAu34Yi4WvQUFpojCdeSu/q0xVtpN3P
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 04:22:57.9267 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c06787b6-f5b1-4b07-7677-08df23618035
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A805.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5815
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
  get_read_index(), returning the cached last_read_index instead of
  zero when a torn read is detected.
- Update check_cmd_done() and aie4_cmd_wait() to detect asynchronous
  device disconnect and reset via check_cert_comp_linked().

Co-developed-by: Max Zhen <max.zhen@amd.com>
Signed-off-by: Max Zhen <max.zhen@amd.com>
Co-developed-by: Wendy Liang <wendy.liang@amd.com>
Signed-off-by: Wendy Liang <wendy.liang@amd.com>
Signed-off-by: David Zhang <yidong.zhang@amd.com>
---
 drivers/accel/amdxdna/aie4_ctx.c    | 59 ++++++++++++++++++++---------
 drivers/accel/amdxdna/amdxdna_ctx.h | 20 ++++++++++
 2 files changed, 61 insertions(+), 18 deletions(-)

diff --git a/drivers/accel/amdxdna/aie4_ctx.c b/drivers/accel/amdxdna/aie4_ctx.c
index 226570367f71..0672aba7c195 100644
--- a/drivers/accel/amdxdna/aie4_ctx.c
+++ b/drivers/accel/amdxdna/aie4_ctx.c
@@ -394,34 +394,52 @@ static inline bool valid_queue_index(u64 read, u64 write, u32 capacity)
 
 static u64 get_read_index(struct amdxdna_hwctx *hwctx)
 {
-	u64 wi = READ_ONCE(*hwctx->priv->umq_write_index);
-	u64 ri = READ_ONCE(*hwctx->priv->umq_read_index);
+	struct amdxdna_hwctx_priv *priv = hwctx->priv;
 	struct amdxdna_dev *xdna = hwctx->client->xdna;
+	u64 ri, wi;
 
-	/*
-	 * CERT cannot update read index as uint64 atomically. Driver may read
-	 * half-updated read index when it has bits in high 32bit. In case read
-	 * index is not valid, wait for some time and retry once. It should
-	 * allow CERT to complete the read index update.
-	 */
+	/* Sample read_index before write_index to guarantee wi >= ri. */
+	ri = READ_ONCE(*priv->umq_read_index);
+	/* Order the read_index sample before the write_index sample. */
+	smp_rmb();
+	wi = READ_ONCE(priv->write_index);
+
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
+			/* Fall back to cached read_index if sample is still invalid. */
+			XDNA_DBG(xdna, "Invalid index, ri %llu, wi %llu", ri, wi);
+			return READ_ONCE(priv->last_read_index);
 		}
 	}
 
+	/*
+	 * Cache valid sample as fallback for torn reads. Lockless on purpose:
+	 * a racing caller may store an older value, which only delays seeing
+	 * a completion until the next wakeup, never reports one early.
+	 */
+	WRITE_ONCE(priv->last_read_index, ri);
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
+static inline bool check_cmd_done(struct amdxdna_hwctx *hwctx, u64 seq, struct cert_comp *comp)
+{
+	/* Lockless check for wait_event condition; detects completion or disconnect. */
+	if (!check_cert_comp_linked(hwctx, comp))
+		return true;
+
+	return get_read_index(hwctx) > seq;
 }
 
 int aie4_cmd_wait(struct amdxdna_hwctx *hwctx, u64 seq, u32 timeout)
@@ -437,11 +455,16 @@ int aie4_cmd_wait(struct amdxdna_hwctx *hwctx, u64 seq, u32 timeout)
 		wait_jifs = msecs_to_jiffies(timeout);
 
 	ret = wait_event_interruptible_timeout(cert_comp->waitq,
-					       (check_cmd_done(hwctx, seq)),
+					       check_cmd_done(hwctx, seq, cert_comp),
 					       wait_jifs);
 
-	if (!ret)
+	if (!ret) {
 		ret = -ETIME;
+	} else if (ret > 0 && !check_cert_comp_linked(hwctx, cert_comp) &&
+		   get_read_index(hwctx) <= seq) {
+		/* Disconnect (suspend or TDR) before the command completed. */
+		ret = -EAGAIN;
+	}
 
 	aie4_put_cert_comp(cert_comp);
 
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

