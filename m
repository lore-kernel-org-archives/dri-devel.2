Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1DCECA600C
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 03:24:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFEA110FA78;
	Thu,  8 Oct 2026 03:24:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="etqgqAQp";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010046.outbound.protection.outlook.com [52.101.201.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6841310FA78
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 03:24:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BrkkxXpqlxboQIDpPCzyVOhCyQBSjsyN7QJvWupxuaQhrtnHxWUA4wmTQi+Ma/6THVeKTF1HygkfEBDvRKmzaNNj2ccOe11oBdw9aM3Hk6S7vyA76Eik3By969zeXEyVf91hNHOX6cqOhSEeo6J2tmeA30MXxCUegayTp9hjiJPa8MwIpDStNXjTZpTRcKvRtWx6hFh62J4P+4GjKTuqu48lNzZqSQkk6dNUyNqeY/ayyfKF+ZSER4KAFv5S1qCAt/zLYb+YuwpIQqL0QYBl5sx9tteKy15dvTCshvkdSDSDqujdr4wDgU4pjW5yvo1DKHfBhGFRBoHRsC+kLHPnwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lruPHpMnSAqQ7+KylmrsQGgabK4zWyabJ4xhzT6ny8M=;
 b=V+cea0Y/xOnOvoiHZ7SGcHl0E8qZYwmFX95ZSLCb3rViFTHjPViptpVPQDXoLF0+RHjBXTZ27tuMdxesQvEW5775DgufWJCv/i6p+JhbfL+pWfgU6mnmDKAA8lS2CdOZKE4VgqKsC4uXr9gmtRTlV2boswba7KiRouNQqxpzsQ7WvWzdLsLE72LbiPXfdi0/F3gXQjEeFCKHAkXRa+eYrnj44dqp4bJ9HzDVBuAZZ4S7TiM5jV7dydehWtdoUyzLdqhH8ySmlkW4g9nkgG0EngWPsBRK3trPKHj6SM/vEzyTJ0X21qGz9cT8uU72F+uzzwTzT+iVgBQmTtlNQkVbfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lruPHpMnSAqQ7+KylmrsQGgabK4zWyabJ4xhzT6ny8M=;
 b=etqgqAQpVch4DehkvHPDv1RmjJ6dUg+KT3QXwdvbV3I4yWV39uefjtvgjpbxRTMhp4huyJVIGUbUjh4OZI8xR5DIZ/+dvH2QPp/t/5mFd0NYWV5HPCcNuZEDvETT9feQdXO+khfR4JhzOH2BLFTkZguVxELm37sxUsvqBXlaOvY=
Received: from SJ0PR05CA0027.namprd05.prod.outlook.com (2603:10b6:a03:33b::32)
 by CY8PR12MB7754.namprd12.prod.outlook.com (2603:10b6:930:86::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 8 Oct
 2026 03:24:15 +0000
Received: from SJ1PEPF000037AC.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::95) by SJ0PR05CA0027.outlook.office365.com
 (2603:10b6:a03:33b::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.19 via Frontend Transport; Thu, 8
 Oct 2026 03:24:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037AC.mail.protection.outlook.com (10.167.244.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Thu, 8 Oct 2026 03:24:15 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 22:24:06 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Wed, 7 Oct 2026 22:24:06 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>, Wendy Liang <wendy.liang@amd.com>
Subject: [PATCH V3 13/19] accel/amdxdna: Prepare for AIE4 command submission
Date: Wed, 7 Oct 2026 20:23:42 -0700
Message-ID: <20261008032348.2044667-14-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261008032348.2044667-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20261008032348.2044667-1-yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AC:EE_|CY8PR12MB7754:EE_
X-MS-Office365-Filtering-Correlation-Id: e5619669-7320-4a95-9d92-08df24eba165
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|5023799004|10067099003|56012099006|4143699003|3023799007|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: BKcSuPqZNvyUBmXdC7G8Ab4enNMbYH5FRHIU5rRLS8LPvFcJsHv4d0uNqHiz1SuhTR9NzyByBcM56DivdGZOKfgpy/aLpaVA9A9l7IebwQet4S9yh+6yGg+wwwMHiGoZizwKHLOAs3gY5sPxqJi7ITsD/RP+yHRUFrNj+pmUMI0zuV6/Q+csgoyFQx9giMqsRbW9/N/La9q2iZZnvvYe4ngzdW7kQoZCnTCetU05KvYcXsemYFmqPL4OXyiOmg5YiVFnuGsZrTeBr6N/qK0Ndjn5dD/TNB+oF+tayoytW57UujqWoCYKd517hodNaBYDbztvY91r6FRxAmm1GoR8g4rihblP38TIKEgXwqoKWBI4TsVkSwN6oHVxShfxYnyT/mY4nVL0D+hrxMLlNpYhLQa4bUPL5NuJFbOWpWvItWva2RFDDbRoS8or2tdC3lWVOHMZNMHRSBxZ0yyCen1V14JdNWb23L0dPlu+xmG0ISf2Uw+maDzvq5E7x0zm7BodpDPBHiw58kItukE0RndhIgVijlTu1Uixp23zTwPVnCgjte+4FWudW3YYQ/mDS2wpts/6a9GNBmolHcUwPIbqIZ5SBlpqHomrU277UprBkCYw3KsJXq6gmNHA7C7LuzMJY41BkKEBthgzNcVRzUptF/nrJ0vX9can2F6SjhGMlPOq4MUw8aqKqtnLHb5dS+U2JSz1c3Vi3W2zCnLj4978Sw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(5023799004)(10067099003)(56012099006)(4143699003)(3023799007)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HbDdIOkkNhUwTPfOjnYaa72xta/RkMX75euUb8lw9k+Q/dlqs3oh0sY9AsRgOHcFJv5BR1Xq1e1OvNGQ1/PYFTE2VrNjXv9OCDbIvMWCVcT0N31otiCkEPa7BNRK5th88w1IP0LerYeJwgTF/S2p0rGPcTjjlXVjN/AWdXERMioBOjzTy3QPUJjFhX3zGf1ybGAaD3mpU6RSwAmRaU/r7YCBmmSwkJPb63SHxsaqBG24tZKdgAwDfNzy5pbVXy/QM7SIqZA+dhDs7PmOcFWHSXal903AmnfspLYYzbjNPY9yFAgedZNOgzZ7Qclb1iCug9OErodcWWP/B64e8lTUU9l17YmGqKXbQB8NqonoNO+8aHtAU+IJmHDvk4iqNKSA2HVvCYZ/6o5EejqG9WE0NV+U26tTWlX0Cn/eQcqZ43V4dEET7USnYPFIg5Y5UXrM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 03:24:15.2335 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5619669-7320-4a95-9d92-08df24eba165
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7754
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
- Update check_cmd_done() and aie4_cmd_wait() to detect asynchronous
  device disconnect and reset via check_cert_comp_linked().

get_read_index() returns 0 for an invalid sample. Since 0 <= any
sequence number, callers never treat it as a completion. If this
happens while the context is disconnected, aie4_cmd_wait() returns
-EAGAIN so the caller retries the wait until a valid read_index is
observed; the command state and fence are not affected.

Co-developed-by: Max Zhen <max.zhen@amd.com>
Signed-off-by: Max Zhen <max.zhen@amd.com>
Co-developed-by: Wendy Liang <wendy.liang@amd.com>
Signed-off-by: Wendy Liang <wendy.liang@amd.com>
Signed-off-by: David Zhang <yidong.zhang@amd.com>
---
 drivers/accel/amdxdna/aie4_ctx.c    | 58 ++++++++++++++++++++---------
 drivers/accel/amdxdna/amdxdna_ctx.h | 20 ++++++++++
 2 files changed, 60 insertions(+), 18 deletions(-)

diff --git a/drivers/accel/amdxdna/aie4_ctx.c b/drivers/accel/amdxdna/aie4_ctx.c
index 226570367f71..09c92b1b5134 100644
--- a/drivers/accel/amdxdna/aie4_ctx.c
+++ b/drivers/accel/amdxdna/aie4_ctx.c
@@ -394,34 +394,46 @@ static inline bool valid_queue_index(u64 read, u64 write, u32 capacity)
 
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
+{
+	/* READ_ONCE pairs with the link/unlink WRITE_ONCE. */
+	return comp == READ_ONCE(hwctx->priv->cert_comp);
+}
+
+static inline bool check_cmd_done(struct amdxdna_hwctx *hwctx, u64 seq, struct cert_comp *comp)
 {
-	u64 read_idx = get_read_index(hwctx);
+	/* Lockless check for wait_event condition; detects completion or disconnect. */
+	if (!check_cert_comp_linked(hwctx, comp))
+		return true;
 
-	return read_idx > seq;
+	return get_read_index(hwctx) > seq;
 }
 
 int aie4_cmd_wait(struct amdxdna_hwctx *hwctx, u64 seq, u32 timeout)
@@ -437,11 +449,21 @@ int aie4_cmd_wait(struct amdxdna_hwctx *hwctx, u64 seq, u32 timeout)
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
+		/*
+		 * Disconnected, or read_index invalid (0), before completion was
+		 * seen. -EAGAIN is by design: the caller retries the wait until a
+		 * valid read_index is observed. Command state and fence are not
+		 * affected.
+		 */
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

