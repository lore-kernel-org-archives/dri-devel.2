Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3414C9830E
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 01:36:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F05110FD19;
	Sat, 26 Sep 2026 01:36:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4/tCsWEv";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010022.outbound.protection.outlook.com
 [52.101.193.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 360D410FD17
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 01:36:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cdn8A33AgMMJQjMWOXpHzVu/l11b+a58Whsl/fU07wPj9elcavKfUvWsJkGOkjnG1WC4/7vfLM0HyDll7Wax6THQl27mo273mFW8c4xbTcqToqURp7ITOiDklMY0q63ZjzaWjTIyZRnoxNXrRK0+vOUY8iZSgJnmRdsKz/NpvE2Pra0UkauyXzvehrBuMzh+nLDzpeJXSxyDFfqxs6JlwkQrF8CfyB6hvw+bORyFfIZ6nY9SkVcWsbL+XhoxFEX8fZICQ9P9wgWmJtBd/LTU+g17qBdvd188D+hPR6xBOMHGQxxu63XG9+DOqUEKF8C04Leck86JkBNTHAI+shxDRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8PpYupdvrXber723YFhcLaFmO68iSuWg+PzBRJH03A=;
 b=JR13fD5kXiRm8Xmwo6fjx2s7BA2rJ4+b9A8HvF51iNXeSYwY+wBc9XlOHprgVzgSgFaqKVo1M8B00dp0eRI3ECENs+zn4Aajtx4Mv2H1F1yCExUgy+TDCFC9kbzZ6YcGQVjmEG1hoMpLXVK9U68SYYKa8UCc98W4jGWHmBMctkcTbRHbOQIJ9E9pSV8/JuV/60tGAsOtlnbKTvegsCne6qKC+06jqR3agwQZ23a+q5+kpwpETaiurWIrbtWZjXUkskplDkvT4i3AV7E2YNccyeTBBvObTKzxRTVC/Kt0Iic98btcSXa6c/IbF/8JcjL1Khmxw5vENfDUHpS8nNXMlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8PpYupdvrXber723YFhcLaFmO68iSuWg+PzBRJH03A=;
 b=4/tCsWEv6y0blC1MtgaOXFhq/AGqiAkkS0+thK3mmq5DGSzES3vt3+wXQHx7Gq+yOEyou0IdE9Up7f7NXe5V26Th7ZWaZ4pOwohWGUpMHXeVzNzRKtUV2U6Q7Oj8h1Vdud/VmFbRwPpLnRVOPqNEfZIMWSg3zYdzXRSgiGkUb2I=
Received: from CH0PR13CA0012.namprd13.prod.outlook.com (2603:10b6:610:b1::17)
 by PH7PR12MB7916.namprd12.prod.outlook.com (2603:10b6:510:26a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Sat, 26 Sep
 2026 01:35:31 +0000
Received: from BN5PEPF00046989.namprd02.prod.outlook.com
 (2603:10b6:610:b1:cafe::8c) by CH0PR13CA0012.outlook.office365.com
 (2603:10b6:610:b1::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Sat,
 26 Sep 2026 01:35:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN5PEPF00046989.mail.protection.outlook.com (10.167.245.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Sat, 26 Sep 2026 01:35:30 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 25 Sep
 2026 20:35:30 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 25 Sep
 2026 20:35:30 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Fri, 25 Sep 2026 20:35:29 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>, Wendy Liang <wendy.liang@amd.com>
Subject: [PATCH V0 15/21] accel/amdxdna: Prepare for AIE4 command submission
Date: Fri, 25 Sep 2026 18:34:42 -0700
Message-ID: <20260926013448.3840921-16-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260926013448.3840921-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20260926013448.3840921-1-yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PEPF00046989:EE_|PH7PR12MB7916:EE_
X-MS-Office365-Filtering-Correlation-Id: 3db98b63-8934-435c-499b-08df1b6e738c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|36860700016|376014|82310400026|10067099003|3023799007|6133799003|11063799006|5023799004|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: PYqX+h2FmxOhSdZlQAAuVDfPIzs66A1Ip2zbD0ckWXqgdDKxVD0o8e/TbNqOP5bfOlhO8GDVSuXWfWpvuQV4W+rZQ0VaDL4E50r3176PD9aMDcPtOTVFfLFVUfA9nHQzMtBq3z6McVqkU+pzUHmdOLrQirTH2SmdKaUi44n60ZP6YDyytrDtvx2OV27R8hNZEz3cZypEIhfqSBG+Nm4/5tbr3oyCwnOpIa4sfgzDyTYa+O3751RyXyFtEOLf84MzR5Mxt10aogwXRIcHyW6j7H6rdzubN4DmXSIrePdpPIRB+k60or/9KLYzx4ClYuK0nZnFUdf59xcuLkBtaNgJyLvsRmQ0n4liETZHyvrxrekgGJSEjsBV4wHxZZxkVn30BgfXjiuJNv3VNCT6aws5VV1Ry03FdK1eVjALKekX0Tyuux0U/43UBrmPse2H0How1EzRjaDhtXvYOQTTyFZls/o0pLMXeyhv+IJdwuFgJ5thK4TISPp1NDD8cr/aWIBfdlCJXMZflnCRnYRCfvW5XmJGW3Tb/EYVX6RoubANMXmdqu9rQj48WGCkORFzvB9kzFmQ/RhlFW6Ck1JG7Zgl8JWXkdUKvy6A5vDoK+cY6q6sSfLA5RPbHhSoES+EKajtO11U84yJj3aX0TzpQSVJaI68r96zCaKR1NSFz6IZMT8gyCb8WXXxaIWlxrefcDoxZExYKmKQ1oqbIBXCFJVwyw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(36860700016)(376014)(82310400026)(10067099003)(3023799007)(6133799003)(11063799006)(5023799004)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DCEr2xIPKjT7pwx9Ib0kT9GGzuUW0taWpsEAzPcEokDEyFjEGSBAs9teE4PPDfJcDvdjkOwWBAo47Q5WPmqyBEEQCv8EXl1cJ4VPtPneUEFhOxG4M/i8qsUBCLOrkfTi0Y0WKHzoEsrzPIdKll2lDVcg84RezwSQ5M4uMS6i2hT325poPGY0hlknWsbYaXM2I9Lcd1WfT0BOuGtjQAqf8O7Llm06YAVXMEC86WoOfF0j4ybHQIq8MXAip8pt60/kNMR04QVihBUxXUudIlAjEUNzXwcnu4aCqybz2A4QD6t8JMUF6mH/tJV+bylpqSo55E+dkIVzuhmbivujg5x+4ZaLqMKXop758/cl2f33L4KrbHZEI1UmWCfsUDLT0gJ+JlyXW0IwZbRz9a62SdQKfii0Bv6ByC/Y7OYUKoBWz9TkYZY5v05l+od5f2UFmBPB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2026 01:35:30.8450 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db98b63-8934-435c-499b-08df1b6e738c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN5PEPF00046989.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7916
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
index af52a1ea45e8..ad124b6d4a02 100644
--- a/drivers/accel/amdxdna/aie4_ctx.c
+++ b/drivers/accel/amdxdna/aie4_ctx.c
@@ -421,34 +421,92 @@ static inline bool valid_queue_index(u64 read, u64 write, u32 capacity)
 
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
@@ -464,11 +522,14 @@ int aie4_cmd_wait(struct amdxdna_hwctx *hwctx, u64 seq, u32 timeout)
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
index 1529e7507fed..7ff806297f8c 100644
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

