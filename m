Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92404CA5FAB
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 03:33:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C08BA10E9E0;
	Wed, 30 Sep 2026 03:33:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ftOtmjCG";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013044.outbound.protection.outlook.com
 [40.93.196.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED56510E9E0
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 03:33:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sVnm38cD5Zz7RpfBuwQWFK0omYmTYUWRQHcQY+1KbsvH51LkeAbYfZSBszT04gkreaMl38AFGggW+Cd1RQCt/6qjhLGl1FgpkDxYWEueeEZPvyzzo878aQ7DMlxpNT87eJTFMu/rthnwqiHjQDW6E7MR6hrtJG5dmKN1ZkMSbcCAMcmYS24U/ekf+/GBpY4ivC5O3en21gQG9p+ZAk5qIdhvD0KcDQuUzgP8j/2TCVw4w1j6KDxk3TSy38haItGZgbJVmuLVWu4AokWPdOyCdoTTL7p9c0o4UpMma20rmD+Xn+BrWhotU7N19ZQmm1ms+EoWnxj7Fflc5fhuMQ0/cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xAgoAa/ZAvMAzEghT0Wtkip9gLyZyUct9jIBOs998/g=;
 b=LSGD/OIX3JxV1s+E/IQJ1AxnJS4G01nNDd5d8xqUEZUgkTZDygMYN2dBFt2q2OdjEG6aD9p1OJOlEtzMPgwcmAGA9sL0V7z3HnonJ1FxAlT2OO1xZ3EHOdCQ5Rf5yaLZpCfuvNRMvE/psX2NQjbacFtgP3EQXepORZqIJw9X2i/K0zckDNmdZI1ubuoR+FRx8GQ136VQfmDq0OZ3V84jh4Xa8h5trSr1vPAJGS3CYfJLqYNxDh//MY/PS1dbzLwycerI1fVDaK0M7/RSAnxpnIdSxbAxZLz3iRkvMPyhbgXsVrbwOFbhqpUSowhDKqc/E0OAQ9qq9QzSHjRzFZJ4bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xAgoAa/ZAvMAzEghT0Wtkip9gLyZyUct9jIBOs998/g=;
 b=ftOtmjCGxy4F0Pj0vWSzqyAdMgDiYMflDJQlgW9gVNvdtyXv63hO5xXSm4vREPMgKK5fLOUbOPUGX0k+wUInlyyMxrC/yp6nDADxm0VEBLxcr6XUz5vLZ0FqIFrPpjS9IOjkosHMKfoLdcwhpGk8r3+n9O/sUmkhbsyNgBKqqeY=
Received: from SJ0PR05CA0025.namprd05.prod.outlook.com (2603:10b6:a03:33b::30)
 by MN0PR12MB6367.namprd12.prod.outlook.com (2603:10b6:208:3d3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 03:33:06 +0000
Received: from SJ1PEPF00002323.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::34) by SJ0PR05CA0025.outlook.office365.com
 (2603:10b6:a03:33b::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.12 via Frontend Transport; Wed,
 30 Sep 2026 03:33:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002323.mail.protection.outlook.com (10.167.242.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 03:33:06 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 22:33:00 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Tue, 29 Sep 2026 22:33:00 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>, Wendy Liang <wendy.liang@amd.com>
Subject: [PATCH V1 13/20] accel/amdxdna: Prepare for AIE4 command submission
Date: Tue, 29 Sep 2026 20:32:26 -0700
Message-ID: <20260930033233.1727265-14-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930033233.1727265-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20260930033233.1727265-1-yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002323:EE_|MN0PR12MB6367:EE_
X-MS-Office365-Filtering-Correlation-Id: 67cea249-de29-4837-01dc-08df1ea38a9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|22082099003|18002099003|3023799007|6133799003|10067099003|11063799006|5023799004|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: W8OrtVRXqdOIH0PwkbFxaGxDsp6TTCNvQ5/xwyjWvcAeQNZZ7xt8usj1wkDahSdfU5oO6WWCA4dAFpXgTQ0WnaHzLychCqPjUc8ucH+5RweoE849RcCTZYKK7Liqiv5l5ybIUpUoKw0HJ25V06atCCZN2V9a47Ur/JTM5peLr6Yqf17BCXhVXcf5vZLwPsS/cwZO7HjFnhit91YLjT3mK+WRu3tF/8eJ4iOLZZiEmKAWybCjPFQ0sQLiLQtIGeoIpLhHZH5hQvmK/VNN6OP28cJrK+em8YH4OArIwVj7XQl0qyfIlZJaL5uq2pCESAJFyfwAg4mr3vTAHA9Lc1482gYs1n8gBEgKoahiD6IwvQmc3weIn0J1+3zmOs2HJ2cz+n9d0XhuBb2D23v+Ru76cGUr0xYWhkCjS6EglxjFi5L+dCa+sA5iVeZH8ibk600vYH/uEVQLr58DOkjcGdo+xIvCi1kVKB70UrKfsERA21Axk5+VU15sSjpxtVB23/VFUSUYIQ493dxgpQkwv6x6ghXwB/N+lsbOLtD2uzxDmcTwFDWtDVQqaaF/Y44pr0gePYhIYW9sB+caMABjHPBpP656A3H1HEFkPrO9oVqib0EjwtA94hiWhU4gswN/Sj/xIEipT69Qrpym96mLK7JcD5igK8TyTLs66h9jehBF8NhPBtmeUwTfDS6HZ0rZdeDI4G7+585x1pcjlg/8iEeQnQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(22082099003)(18002099003)(3023799007)(6133799003)(10067099003)(11063799006)(5023799004)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PdpoQXyAY5XlQcjN9l58N2+DzPd23FJOeq7haJGEOVBz579ygeT3hmkV32yQs8blvLS9QyX3yKyPXLWjZLLGXxnMPd8bkUJjaM3bjNyCAbCA9qeSxujpprZhpI/BbvBbcOQMDbuKvAGXFw5tyvK/9EpUcBHofMuFYOZHHOxXOfnivb/ergb2+6nk0g4pRlQkZWnoxBkFe1vp9R8M6GA3csEs630FFy0+oOZU9/vIKtrN0e6GzNF/ahkHZCzxIG6jNbxbvNnao9fZ54zoGhhMpUbkrwIhB6PVY0vofYzbkLU5CbIOWLUbk+33NcoLnlyZCbzj1nBOdNI/ifNb9wjAFYOlQD5crJk+e8NPhSmuEYaC7bzlcVQtjy4MRUrB9NCyqaDlNUmW8QOjKJalYVRl9QHAaWXe7s1IuT1fTf2TAz6GXc2/a8ric/mc7h4hQ0ML
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 03:33:06.2570 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67cea249-de29-4837-01dc-08df1ea38a9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002323.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6367
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
- Implement smp_rmb() ordering and non-sleeping retry in get_read_index(),
  returning the cached last_read_index on read tearing to prevent false
  timeouts.
- Update check_cmd_done() and aie4_cmd_wait() to detect asynchronous
  device disconnect and reset via check_cert_comp_linked().

Co-developed-by: Max Zhen <max.zhen@amd.com>
Signed-off-by: Max Zhen <max.zhen@amd.com>
Co-developed-by: Wendy Liang <wendy.liang@amd.com>
Signed-off-by: Wendy Liang <wendy.liang@amd.com>
Signed-off-by: David Zhang <yidong.zhang@amd.com>
---
 drivers/accel/amdxdna/aie4_ctx.c    | 89 ++++++++++++++++++++++++-----
 drivers/accel/amdxdna/amdxdna_ctx.h | 20 +++++++
 2 files changed, 95 insertions(+), 14 deletions(-)

diff --git a/drivers/accel/amdxdna/aie4_ctx.c b/drivers/accel/amdxdna/aie4_ctx.c
index 3927c9fef05f..59d37bd5c5a0 100644
--- a/drivers/accel/amdxdna/aie4_ctx.c
+++ b/drivers/accel/amdxdna/aie4_ctx.c
@@ -423,34 +423,92 @@ static inline bool valid_queue_index(u64 read, u64 write, u32 capacity)
 
 static u64 get_read_index(struct amdxdna_hwctx *hwctx)
 {
-	u64 wi = READ_ONCE(*hwctx->priv->umq_write_index);
-	u64 ri = READ_ONCE(*hwctx->priv->umq_read_index);
+	struct amdxdna_hwctx_priv *priv = hwctx->priv;
 	struct amdxdna_dev *xdna = hwctx->client->xdna;
+	u64 ri, wi;
+
+	/*
+	 * Sample read_index (written by CERT) before write_index. CERT can
+	 * never complete more than has been published, so a write_index sampled
+	 * after read_index always satisfies wi >= ri; sampling write_index
+	 * first races the submit path / CERT and yields a bogus ri > wi.
+	 *
+	 * In kernel-mode submission write_index is the driver's host-owned copy
+	 * in coherent kernel memory (always >= the value mirrored into the UMQ,
+	 * and the device never writes it).
+	 *
+	 * Security: read_index lives in the umq_bo, which the owning process can
+	 * map. Under PASID/SVA the device reaches the queue through that process's
+	 * own page tables, preventing access to other contexts' unshared memory.
+	 * A forged read_index only completes the process's own command early and
+	 * corrupts or hangs itself; however, if BOs are exported via dma-buf,
+	 * premature fence signaling can cause an importing process or device to
+	 * observe DMA completion before CERT has finished processing.
+	 */
+	ri = READ_ONCE(*priv->umq_read_index);
+	/* Order the read_index sample before the write_index sample. */
+	smp_rmb();
+	wi = READ_ONCE(priv->write_index);
 
 	/*
 	 * CERT cannot update read index as uint64 atomically. Driver may read
-	 * half-updated read index when it has bits in high 32bit. In case read
-	 * index is not valid, wait for some time and retry once. It should
-	 * allow CERT to complete the read index update.
+	 * a half-updated read index when it has bits in the high 32 bits. If it
+	 * looks invalid, re-sample once -- WITHOUT sleeping, since this can run as
+	 * a wait_event() condition. If still invalid, report not-advanced; the
+	 * waiter re-checks on the next completion wake or timeout.
 	 */
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
+			/*
+			 * Still invalid (torn 64-bit read, or a transient
+			 * accounting skew). Return the last valid read_index
+			 * instead of 0: read_index only advances, so the cached
+			 * value is a safe lower bound -- it never reports a
+			 * command complete that isn't, and never regresses the
+			 * worker into falsely timing out a finished job.
+			 */
+			XDNA_DBG(xdna, "Invalid index, ri %llu, wi %llu", ri, wi);
+			return READ_ONCE(priv->last_read_index);
 		}
 	}
 
+	WRITE_ONCE(priv->last_read_index, ri);
 	return ri;
 }
 
-static inline bool check_cmd_done(struct amdxdna_hwctx *hwctx, u64 seq)
+/*
+ * The ctx is "connected" as long as @comp is still the cert_comp linked to it.
+ * A disconnect (teardown/reset) unlinks (and may re-link a fresh) cert_comp, so
+ * a changed pointer means the caller must retry (-EAGAIN). This runs as a
+ * wait_event() condition on the completion hot path (cert_comp->waitq is shared
+ * per MSI-X), so keep it lockless: the caller pins @comp with a kref, making
+ * this a pure pointer-identity compare - never a dereference, ABA-safe - and
+ * READ_ONCE pairs with the WRITE_ONCE in aie4_hwctx_create()/
+ * aie4_hwctx_destroy().
+ */
+static bool check_cert_comp_linked(struct amdxdna_hwctx *hwctx, struct cert_comp *comp)
 {
-	u64 read_idx = get_read_index(hwctx);
+	/* READ_ONCE pairs with the link/unlink WRITE_ONCE. */
+	return comp == READ_ONCE(hwctx->priv->cert_comp);
+}
+
+static inline bool check_cmd_done(struct amdxdna_hwctx *hwctx, u64 seq, struct cert_comp *comp)
+{
+	/*
+	 * Runs as a wait_event() condition, so it must not sleep.
+	 * check_cert_comp_linked() is lockless (a READ_ONCE pointer compare); a
+	 * disconnect (teardown/reset) unlinks @comp and breaks the wait, and the
+	 * caller then confirms real completion by re-reading read_index, so a
+	 * disconnect wake is not mistaken for success.
+	 */
+	if (!check_cert_comp_linked(hwctx, comp))
+		return true;
 
-	return read_idx > seq;
+	return get_read_index(hwctx) > seq;
 }
 
 int aie4_cmd_wait(struct amdxdna_hwctx *hwctx, u64 seq, u32 timeout)
@@ -466,11 +524,14 @@ int aie4_cmd_wait(struct amdxdna_hwctx *hwctx, u64 seq, u32 timeout)
 		wait_jifs = msecs_to_jiffies(timeout);
 
 	ret = wait_event_interruptible_timeout(cert_comp->waitq,
-					       (check_cmd_done(hwctx, seq)),
+					       check_cmd_done(hwctx, seq, cert_comp),
 					       wait_jifs);
 
 	if (!ret)
 		ret = -ETIME;
+	else if (ret > 0 && get_read_index(hwctx) <= seq)
+		/* Woke on disconnect/reset, not on real completion. */
+		ret = -EAGAIN;
 
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

