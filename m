Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EBA5C9833A
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 01:36:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FD3A10FD10;
	Sat, 26 Sep 2026 01:36:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X+1daKTY";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010032.outbound.protection.outlook.com [52.101.85.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CAFE10FD07
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 01:35:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QhejMpplepE5gJ8g4mlaF9gBoQpIWuqmdChECYWYGfSs01CH4h6mc270QFU86t9qxdDJgPOKprkD5IUdIDe3GWolu8s0q+jUNchPRhzqKNBxWeWJsuGr7B3AROxd+ow9sy76NF8PQb/67y2k+7/y9eXXZu5B/KpHVSdImie1UJunRvt2p0/PaDEm4fZYpkHw28GRUPPOKOZKXBEwwdd+afNX5DKooBeQ7AVahrN6+LyH8i56xRZgkHtJOZcD1Awv07IkeYytEPQnpd+6nvstiWHXWL58FIEVBhnAYi+/ErjjehZDu5kNLyYJ6o2abCAk+yj1weuUUwanluknVoqA5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7EdQiGlfSqYpWj0mqKzHQh+Wjk1vSGn6H1yFE3iTs8c=;
 b=FZRBaCTFbX2AUaMgB3XMDakTnPRpM5Z5lUco55d9BfKN+yRRSJPi2PrJUhkcaaogE/YNpD/ydIPnf676amkbEs287a57fCjPSbSeoduSNuXmilNF9LG0E3a9sojpqIfTdHbK5vpr0fKLVbfdVlhGpWPOGjsyx8OWr3CTdcxHFKQYlvf8zTCwZlKPN9gEUx8cddmXITGZrpVj/aCXF/8gFwVsf5owv4nMdcDctPmAM0j9K0AjhiDARhypJfhU+kXGgpVJLp4p0njAm+7zIz4MgKaGzP/xkS7ZpoQMXMaTBTDgFzLlqNOKgn03ptg6po7yM+ICGJynpvk8KA9oVALmPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7EdQiGlfSqYpWj0mqKzHQh+Wjk1vSGn6H1yFE3iTs8c=;
 b=X+1daKTYxvhEc9sFoMwNL3gOrk9vRexf0shSKj8q/ZTxoMNBuks6hvli6TjUZd/3yugs3SNx0YSTJLNMNrnXfA9P+hvb8VbowaDguESa3Y41//xW2gY6igbDDrmy+7bVN+hAUBRqjvNi8OhVUppAl30og7jFicw1K6yU1QHKowE=
Received: from CH0PR13CA0029.namprd13.prod.outlook.com (2603:10b6:610:b1::34)
 by SA1PR12MB7444.namprd12.prod.outlook.com (2603:10b6:806:2b3::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.22; Sat, 26 Sep
 2026 01:35:32 +0000
Received: from BN5PEPF00046989.namprd02.prod.outlook.com
 (2603:10b6:610:b1:cafe::19) by CH0PR13CA0029.outlook.office365.com
 (2603:10b6:610:b1::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.19 via Frontend Transport; Sat,
 26 Sep 2026 01:35:31 +0000
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
 15.21.451.8 via Frontend Transport; Sat, 26 Sep 2026 01:35:31 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 25 Sep
 2026 20:35:31 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Fri, 25 Sep 2026 20:35:30 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>, Wendy Liang <wendy.liang@amd.com>
Subject: [PATCH V0 16/21] accel/amdxdna: Implement AIE4 command packet
 building and submission
Date: Fri, 25 Sep 2026 18:34:43 -0700
Message-ID: <20260926013448.3840921-17-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260926013448.3840921-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20260926013448.3840921-1-yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PEPF00046989:EE_|SA1PR12MB7444:EE_
X-MS-Office365-Filtering-Correlation-Id: c8e1e4bd-b6f3-427d-3770-08df1b6e7416
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|10067099003|5023799004|11063799006|3023799007|6133799003|18002099003|22082099003|260925022911599003|56012099006|4143699003|260925021311599003|260925021911599003;
X-Microsoft-Antispam-Message-Info: E3wYIX6hAPpPNZ+GIrbIx1yFATqvNwVWZxjUzrIavuJpIdkTidOh+okSHnVelQvoBgDOHUAPlMxE3xGvKbiQce9AyUGQDORH8WTsto0nqAVip61FW0QfwEmwpchWh6ui2dVoxaMUUwK0ZqQhfLDxALtBRSHcfpo54jREcMcvPI+j7D266Ky2vIEYDN/Cacqv9Ls1+qFqNaUASTjKDs7GturJVBqUu3pzwlXVI+jqsiYJ/h0YsPbxzjkqan6aospT0adPOTxqX9WSC1ZyDh5md9b5n2Tb5pGl3gBtoJMBsNSJBPvdMVlg8dOiyMIh75QEsscO4KSXfuImCPGZtiibmvK1yKvFCOBwNcJ4nnYsnmDF0oXTtc+8OVfAWkWF5nbnjmTLS8GyNBspY9lr+TPBWRYoiHQMCmkA56tJFNQG5/ijky8yX77S80W9zan2w+MYecq0SPwnvoRPEVN6F8BVjc4CKsVFPm2xoIOx1yX0fp27i1hleDATLiBAuKvvwMEPsjv9JXNTWGgVbTVxG1NkF/D1M46ZKDbun9HNcLHhQCh640A8ks8SuTXz4cN0dZ+K+lSX7IdzFxCvL0mTJE6O1sKwM9ejhcHtrn5g6GHa8cq/lpYg+E+1KFqRykMsUMEBbza8y2298SmS9c3XGX2qPGYsTAv4eRNHZMPcBreGBPb/0CEiDbEMzYnvJcR1vTExPQ/AHqgR5omhX752tl48aA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(10067099003)(5023799004)(11063799006)(3023799007)(6133799003)(18002099003)(22082099003)(260925022911599003)(56012099006)(4143699003)(260925021311599003)(260925021911599003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iERdz0WrZMEVVlXZAYA4/eGRTagQBoFQkumdFVs3+85AuPLi7dU7XV/P7/Yjvubdj+3szpjiFzD5Ny60f7spByDepKCqM6QCYC8WqZy8EOx1ORmlzhfH0kYUn5PD+7BCp01P1dsZRUPptp+OxLvDmTKBojoOMqqmMhgpkf9IAzSysSAGNSNzCcUgHq+BwBWqJJLv2FCuzrdb6BU1bagHTEWYK4S4z6ttHTY1JKfSz/j0MdsKG7L0GCYYXqXSQ7kSKDtnjECGX/7FBhNH163W21c9t6KAN3Ykya8gWKQIkYZ4Nduo24XmeEReh4u5kUhEJvY2fbHiqYO3alKSIrtLJCO3QRV3Dms98j5joUEVtDAw8oDi3pzQ6OkFIT8lMjMy7RUaxAcRDZUUgpr0Yulqe3IYarYl+DjHdAmtSuni6QcvCs++SPzzcYcqKtf7JzlM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2026 01:35:31.7480 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8e1e4bd-b6f3-427d-3770-08df1b6e7416
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN5PEPF00046989.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7444
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

Implement kernel-mode command submission and hardware queue packet
assembly for AIE4:
- Add aie4_cmd_submit() to validate incoming command buffers, reserve
  GEM fences, serialize submissions via the context pending list, and
  dispatch to the hardware queue.
- Lock all job BOs and attach fence to their reservation objects to
  align with aie2, completing the fence and BO reservation management
  fix started in commit ("accel/amdxdna: Fix fence timeline name and
  context allocation"). Signal job fence on completion and propagate
  error status on abort or submission failure.
- Implement packet encoders: fill_direct_pkt() for single-CU execution
  and fill_indirect_pkt() for chained/multi-CU execution via level-1
  indirect packets.
- Implement wait_till_connected_hsa_not_full() to gate command publication
  on both HSA queue slot availability and hardware context connectivity:
  - If the queue is full, wait on completion of older sequences.
  - If the context is disconnected or resets during the wait, sleep on
    priv->job_list_wq via wait_event_freezable() rather than busy-spinning
    with dropped and retaken io_lock.
  - Respect wait_through_reset: the initial sub-command in a chain (or
    single command) waits through a reset and executes on the recreated
    context, while subsequent sub-commands return -ECONNRESET so the
    published prefix is not split across contexts.
- Track context reset state in priv->has_reset, waking parked submitters
  on disconnect/error and letting the job worker drain running jobs as
  aborted during reset.
- Pass validated opcode into submit_job_cmds() to prevent TOCTOU races.
- Advance the hardware write index, ring the doorbell, and register
  in-flight jobs on the running list for completion tracking.
- Add aie4_hwctx_wait_for_running() with timeout to safely quiesce worker
  threads and wait for pending or running jobs before destroying the
  context workqueue.

Co-developed-by: Max Zhen <max.zhen@amd.com>
Signed-off-by: Max Zhen <max.zhen@amd.com>
Co-developed-by: Wendy Liang <wendy.liang@amd.com>
Signed-off-by: Wendy Liang <wendy.liang@amd.com>
Signed-off-by: David Zhang <yidong.zhang@amd.com>
---
 drivers/accel/amdxdna/aie4_ctx.c | 718 ++++++++++++++++++++++++++++++-
 drivers/accel/amdxdna/aie4_pci.c |   2 +
 drivers/accel/amdxdna/aie4_pci.h |   3 +
 3 files changed, 717 insertions(+), 6 deletions(-)

diff --git a/drivers/accel/amdxdna/aie4_ctx.c b/drivers/accel/amdxdna/aie4_ctx.c
index ad124b6d4a02..ec00ea0bbc55 100644
--- a/drivers/accel/amdxdna/aie4_ctx.c
+++ b/drivers/accel/amdxdna/aie4_ctx.c
@@ -24,9 +24,7 @@
 #define CTX_INVALID_ID			(~0U)
 #define CTX_INVALID_DOORBELL		AMDXDNA_INVALID_DOORBELL_OFFSET
 
-static void job_worker(struct work_struct *work)
-{
-}
+static void job_worker(struct work_struct *work);
 
 static struct cert_comp *aie4_lookup_cert_comp(struct amdxdna_dev_hdl *ndev, u32 msix_idx)
 {
@@ -207,6 +205,7 @@ int aie4_hwctx_create(struct amdxdna_hwctx *hwctx)
 		hwctx->fw_ctx_id = -1;
 		return ret;
 	}
+	WRITE_ONCE(priv->has_reset, false);
 	WRITE_ONCE(priv->cert_comp, cert_comp);
 	mutex_unlock(&priv->io_lock);
 	hwctx->doorbell_offset = CTX_INVALID_DOORBELL;
@@ -215,6 +214,23 @@ int aie4_hwctx_create(struct amdxdna_hwctx *hwctx)
 	return 0;
 }
 
+/*
+ * The connected sentinel for the submit wait gate: a linked cert_comp means the
+ * ctx is created and (for kernel submission) its doorbell is set up. Read
+ * locklessly (a pointer null-check, never a dereference); create publishes it as
+ * the last store under io_lock and destroy clears it first, so "connected"
+ * implies a valid doorbell.
+ */
+static bool aie4_hwctx_connected(struct amdxdna_hwctx *hwctx)
+{
+	return !!READ_ONCE(hwctx->priv->cert_comp);
+}
+
+static bool aie4_hwctx_has_reset(struct amdxdna_hwctx *hwctx)
+{
+	return READ_ONCE(hwctx->priv->has_reset);
+}
+
 void aie4_hwctx_destroy(struct amdxdna_hwctx *hwctx, enum aie4_hwctx_flags flags)
 {
 	struct amdxdna_client *client = hwctx->client;
@@ -222,10 +238,16 @@ void aie4_hwctx_destroy(struct amdxdna_hwctx *hwctx, enum aie4_hwctx_flags flags
 	struct amdxdna_dev *xdna = client->xdna;
 	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
 	struct cert_comp *cert_comp;
+	bool has_reset = false;
 
 	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
 
+	if (flags == AIE4_HWCTX_DISCONNECT || flags == AIE4_HWCTX_ERROR)
+		has_reset = true;
+
 	mutex_lock(&priv->io_lock);
+	if (has_reset)
+		WRITE_ONCE(priv->has_reset, true);
 	cert_comp = priv->cert_comp;
 	WRITE_ONCE(priv->cert_comp, NULL);
 	mutex_unlock(&priv->io_lock);
@@ -235,6 +257,9 @@ void aie4_hwctx_destroy(struct amdxdna_hwctx *hwctx, enum aie4_hwctx_flags flags
 		aie4_put_cert_comp(cert_comp);
 	}
 
+	if (has_reset)
+		wake_up_all(&priv->job_list_wq);
+
 	if (flags != AIE4_HWCTX_DISCONNECT)
 		aie4_msg_destroy_context(ndev, priv->hw_ctx_id);
 
@@ -242,7 +267,15 @@ void aie4_hwctx_destroy(struct amdxdna_hwctx *hwctx, enum aie4_hwctx_flags flags
 	hwctx->fw_ctx_id = -1;
 	hwctx->doorbell_offset = CTX_INVALID_DOORBELL;
 
-	cancel_work_sync(&priv->job_work);
+	/*
+	 * When has_reset is true (AIE4_HWCTX_DISCONNECT or ERROR), cancel_work_sync()
+	 * is skipped so the worker can wake up and abort in-flight jobs. Callers
+	 * that re-create the context after DISCONNECT (e.g. reset recovery) must
+	 * synchronize the worker (via aie4_hwctx_wait_for_running()) before calling
+	 * aie4_hwctx_create().
+	 */
+	if (!has_reset)
+		cancel_work_sync(&priv->job_work);
 }
 
 static void aie4_hwctx_umq_fini(struct amdxdna_hwctx *hwctx)
@@ -405,10 +438,18 @@ void aie4_hwctx_fini(struct amdxdna_hwctx *hwctx)
 {
 	struct amdxdna_hwctx_priv *priv = hwctx->priv;
 
+	/*
+	 * ERROR sets has_reset (like a TDR reset) so the worker drains the running
+	 * list - the ctx is gone, so in-flight jobs are reaped - and stays live
+	 * for aie4_hwctx_wait_for_running() to wait on. Submitters are already gone
+	 * (amdxdna_hwctx_destroy_rcu() synchronize_srcu'd them out), then the
+	 * queue is torn down.
+	 */
 	aie4_hwctx_destroy(hwctx, AIE4_HWCTX_ERROR);
-	cancel_work_sync(&priv->job_work);
-	if (priv->job_work_q)
+	if (priv->job_work_q) {
+		aie4_hwctx_wait_for_running(hwctx);
 		destroy_workqueue(priv->job_work_q);
+	}
 	aie4_hwctx_umq_fini(hwctx);
 	mutex_destroy(&priv->io_lock);
 	kfree(hwctx->priv);
@@ -535,3 +576,668 @@ int aie4_cmd_wait(struct amdxdna_hwctx *hwctx, u64 seq, u32 timeout)
 
 	return ret <= 0 ? ret : 0;
 }
+
+/* ---- kernel-mode submission (driver fills the queue and rings doorbell) ---- */
+
+/* Publish a command to CERT and return the assigned command sequence (slot). */
+static u64 publish_cmd(struct amdxdna_hwctx *hwctx)
+{
+	struct amdxdna_hwctx_priv *priv = hwctx->priv;
+	u64 wi = priv->write_index;
+
+	/* Paired with the lockless READ_ONCE() readers of write_index. */
+	WRITE_ONCE(priv->write_index, wi + 1);
+	/* Order the packet-slot writes before CERT sees the new write_index. */
+	wmb();
+	WRITE_ONCE(*priv->umq_write_index, wi + 1);
+	return wi;
+}
+
+static int wait_till_seq_completed(struct amdxdna_hwctx *hwctx, u64 seq)
+{
+	struct cert_comp *cert_comp;
+	int ret;
+
+	/*
+	 * Freezable + interruptible: the submit path (wait_till_connected_hsa_not_full)
+	 * reaches here while holding hwctx_srcu, and ctx teardown blocks on
+	 * synchronize_srcu(), so a signal (e.g. the app being killed) must be
+	 * able to unwind the wait - otherwise a full queue with a silent CERT
+	 * would hang the submitter in D state and stall teardown forever.
+	 * TASK_FREEZABLE lets the freezer suspend this wait in place during
+	 * S3/S4 instead of aborting the suspend. Harmless for the job worker
+	 * kthread (never gets a signal; simply freezes/thaws around it).
+	 */
+	cert_comp = aie4_get_cert_comp(hwctx);
+	if (!cert_comp)
+		return -EAGAIN;
+
+	ret = wait_event_freezable(cert_comp->waitq,
+				   check_cmd_done(hwctx, seq, cert_comp));
+	if (ret) {
+		aie4_put_cert_comp(cert_comp);
+		return ret;	/* -ERESTARTSYS: signal on the submit path */
+	}
+
+	if (check_cert_comp_linked(hwctx, cert_comp))
+		ret = 0;			/* real completion */
+	else
+		ret = -EAGAIN;			/* disconnect (suspend or TDR) */
+
+	aie4_put_cert_comp(cert_comp);
+	return ret;
+}
+
+static int wait_till_connected_hsa_not_full(struct amdxdna_hwctx *hwctx,
+					    bool wait_through_reset)
+{
+	struct amdxdna_dev *xdna = hwctx->client->xdna;
+	struct amdxdna_hwctx_priv *priv = hwctx->priv;
+	u64 wi = READ_ONCE(priv->write_index);
+	bool hsa_not_full = !!(wi < CTX_MAX_CMDS);
+	int ret;
+
+	do {
+		mutex_unlock(&priv->io_lock);
+		if (!hsa_not_full) {
+			ret = wait_till_seq_completed(hwctx, wi - CTX_MAX_CMDS);
+			if (ret && ret != -EAGAIN) {
+				mutex_lock(&priv->io_lock);
+				return ret;
+			}
+			if (!ret)
+				hsa_not_full = true;
+		}
+		ret = wait_event_freezable(priv->job_list_wq,
+					   aie4_hwctx_connected(hwctx) ||
+					   (!wait_through_reset &&
+					    aie4_hwctx_has_reset(hwctx)));
+		mutex_lock(&priv->io_lock);
+		if (ret)
+			return ret;
+		if (!wait_through_reset && aie4_hwctx_has_reset(hwctx)) {
+			XDNA_DBG(xdna, "ctx %s reset while submitting; unwinding -ECONNRESET",
+				 hwctx->name);
+			return -ECONNRESET;
+		}
+	} while (!hsa_not_full || !aie4_hwctx_connected(hwctx));
+
+	return 0;
+}
+
+static int fill_indirect_pkt(struct amdxdna_hwctx_priv *priv, u64 slot_idx,
+			     u32 total_slots, struct amdxdna_cmd_start_dpu *dpu,
+			     u16 entries)
+{
+	struct host_queue_packet *pkt = &priv->umq_pkts[slot_idx];
+	struct host_indirect_packet_entry *hipe =
+		(struct host_indirect_packet_entry *)(pkt->data);
+	u16 i;
+
+	for (i = 0; i < entries; i++, dpu++, hipe++) {
+		struct host_indirect_packet_data *hipd;
+		u64 indirect_pkt_dev_addr;
+		u32 uci = dpu->uc_index;
+		u32 idx;
+
+		/*
+		 * dpu is the user-shared cmd_abo payload, so uc_index is read at
+		 * use time here and indexes priv->umq_indirect_pkts[]. Reject an
+		 * out-of-range value: the slot is reused, so skipping the entry
+		 * would leave a stale one that count still advertises to CERT.
+		 * Abort before the packet is published.
+		 */
+		if (uci >= HSA_MAX_LEVEL1_INDIRECT_ENTRIES) {
+			XDNA_ERR(priv->hwctx->client->xdna, "Invalid uc index %d", uci);
+			return -EINVAL;
+		}
+		idx = uci * total_slots + slot_idx;
+		hipd = &priv->umq_indirect_pkts[idx];
+		indirect_pkt_dev_addr = priv->umq_indirect_pkts_dev_addr +
+			sizeof(struct host_indirect_packet_data) * idx;
+
+		/* Point the indirect entry at the indirect packet. */
+		hipe->host_addr_low = lower_32_bits(indirect_pkt_dev_addr);
+		hipe_set_host_addr_high(&hipe->host_addr_high_uc_index,
+					upper_32_bits(indirect_pkt_dev_addr));
+		hipe_set_uc_index(&hipe->host_addr_high_uc_index, uci);
+
+		/* Fill in the indirect packet. */
+		hipd->payload.dpu_control_code_host_addr_low =
+			lower_32_bits(dpu->instruction_buffer);
+		hipd->payload.dpu_control_code_host_addr_high =
+			upper_32_bits(dpu->instruction_buffer);
+		hipd->payload.dtrace_buf_host_addr_low =
+			lower_32_bits(dpu->dtrace_buffer);
+		hipd->payload.dtrace_buf_host_addr_high =
+			lower_16_bits(upper_32_bits(dpu->dtrace_buffer));
+	}
+	pkt->pkt_header.common_header.distribute = 1;
+	pkt->pkt_header.common_header.indirect = 1;
+	pkt->pkt_header.common_header.count = entries * sizeof(*hipe);
+	return 0;
+}
+
+static void fill_direct_pkt(struct amdxdna_hwctx_priv *priv, u64 slot_idx,
+			    struct amdxdna_cmd_start_dpu *dpu)
+{
+	struct host_queue_packet *pkt = &priv->umq_pkts[slot_idx];
+	struct exec_buf *ebuf = (struct exec_buf *)(pkt->data);
+
+	memset(pkt->data, 0, sizeof(pkt->data));
+	ebuf->dpu_control_code_host_addr_low = lower_32_bits(dpu->instruction_buffer);
+	ebuf->dpu_control_code_host_addr_high = upper_32_bits(dpu->instruction_buffer);
+	ebuf->dtrace_buf_host_addr_low = lower_32_bits(dpu->dtrace_buffer);
+	ebuf->dtrace_buf_host_addr_high = lower_16_bits(upper_32_bits(dpu->dtrace_buffer));
+	pkt->pkt_header.common_header.distribute = 0;
+	pkt->pkt_header.common_header.indirect = 0;
+	pkt->pkt_header.common_header.count = sizeof(*ebuf);
+}
+
+/*
+ * Build and submit one HSA command for @cmd_abo into the user host queue and
+ * ring the doorbell. Called with io_lock held.
+ *
+ * Security: cmd_abo is shared with user space; cache and validate its fields
+ * before use and never trust the queue content (only read_index is read back).
+ */
+static int submit_one_cmd(struct amdxdna_hwctx *hwctx,
+			  struct amdxdna_gem_obj *cmd_abo, bool last_of_chain,
+			  bool first_cmd, u64 *seq)
+{
+	struct amdxdna_hwctx_priv *priv = hwctx->priv;
+	struct amdxdna_dev *xdna = hwctx->client->xdna;
+	struct amdxdna_cmd_start_dpu *dpu;
+	struct host_queue_packet *pkt;
+	u32 payload_size;
+	u64 slot_idx;
+	u16 chained;
+	int ret;
+	u32 op;
+
+	op = amdxdna_cmd_get_op(cmd_abo);
+	if (op != ERT_START_DPU) {
+		XDNA_ERR(xdna, "Invalid exec buf op, %d", op);
+		return -EINVAL;
+	}
+
+	dpu = amdxdna_cmd_get_payload(cmd_abo, &payload_size);
+	if (!dpu) {
+		XDNA_ERR(xdna, "Invalid DPU payload");
+		return -EINVAL;
+	}
+	/*
+	 * cmd_abo is shared with user space; validate the cached chained count
+	 * against the actual payload size before dereferencing chained+1 DPU
+	 * entries, so a bogus count cannot drive an out-of-bounds read.
+	 */
+	chained = dpu->chained;
+	if (chained >= HSA_MAX_LEVEL1_INDIRECT_ENTRIES) {
+		XDNA_ERR(xdna, "Invalid DPU data");
+		return -EINVAL;
+	}
+	if (payload_size < (u32)(chained + 1) * sizeof(*dpu)) {
+		XDNA_ERR(xdna, "DPU payload %u too small for %u entries",
+			 payload_size, chained + 1);
+		return -EINVAL;
+	}
+
+	/*
+	 * Block until a queue slot is free and the ctx is connected (io_lock is
+	 * dropped across the sleeps inside and re-acquired). The only failure is a
+	 * signal interrupting the wait (-ERESTARTSYS), e.g. the app being killed.
+	 */
+	ret = wait_till_connected_hsa_not_full(hwctx, first_cmd);
+	if (ret) {
+		XDNA_DBG(xdna, "Wait for queue slot / ctx reconnect interrupted, ret %d", ret);
+		return ret;
+	}
+
+	slot_idx = priv->write_index & (CTX_MAX_CMDS - 1);
+	if (chained) {
+		ret = fill_indirect_pkt(priv, slot_idx, CTX_MAX_CMDS, dpu, chained + 1);
+		if (ret)
+			return ret;
+	} else {
+		fill_direct_pkt(priv, slot_idx, dpu);
+	}
+
+	pkt = &priv->umq_pkts[slot_idx];
+	pkt->pkt_header.common_header.opcode = OPCODE_EXEC_BUF;
+	pkt->pkt_header.common_header.chain_flag =
+		last_of_chain ? CHAIN_FLG_LAST_CMD : CHAIN_FLG_NOT_LAST_CMD;
+	pkt->pkt_header.common_header.reserved = 0x0;
+	pkt->pkt_header.completion_signal = amdxdna_gem_dev_addr(cmd_abo) +
+					    offsetof(struct amdxdna_cmd, header);
+	*seq = publish_cmd(hwctx);
+	aie4_doorbell_ring(hwctx);
+	XDNA_DBG(xdna, "Submitted one cmd, %s seq %lld", hwctx->name, *seq);
+	return 0;
+}
+
+/*
+ * Return the head running job without removing it. The job worker keeps the
+ * in-flight job on the list while it waits so that a disconnect (suspend) can
+ * just leave it there for resume - no dequeue/requeue - and running_job_list is
+ * never transiently empty while a job is in flight.
+ */
+static struct amdxdna_sched_job *peek_running_job(struct amdxdna_hwctx *hwctx)
+{
+	struct amdxdna_hwctx_priv *priv = hwctx->priv;
+	struct amdxdna_sched_job *job;
+
+	mutex_lock(&priv->io_lock);
+	job = list_first_entry_or_null(&priv->running_job_list,
+				       struct amdxdna_sched_job, aie4_job_list);
+	mutex_unlock(&priv->io_lock);
+	return job;
+}
+
+/* Remove a job from the running list once it is completed or reaped. */
+static void dequeue_running_job(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *job)
+{
+	struct amdxdna_hwctx_priv *priv = hwctx->priv;
+
+	mutex_lock(&priv->io_lock);
+	list_del(&job->aie4_job_list);
+	mutex_unlock(&priv->io_lock);
+}
+
+static void aie4_job_release(struct kref *ref)
+{
+	struct amdxdna_sched_job *job =
+		container_of(ref, struct amdxdna_sched_job, refcnt);
+
+	amdxdna_sched_job_cleanup(job);
+	if (job->out_fence)
+		dma_fence_put(job->out_fence);
+	kfree(job);
+}
+
+static void job_done(struct amdxdna_sched_job *job)
+{
+	job->aie4_job_state = AIE4_JOB_STATE_DONE;
+	dma_fence_signal(job->fence);
+	/*
+	 * Release the address-space reference taken at submit. On SVA/IOMMU
+	 * platforms the device walks the submitter's page tables while the job
+	 * runs, so its mm must stay alive until completion.
+	 */
+	mmput_async(job->mm);
+	kref_put(&job->refcnt, aie4_job_release);
+}
+
+static void job_complete(struct amdxdna_sched_job *job)
+{
+	job_done(job);
+}
+
+/*
+ * When CERT cannot complete a command (context teardown), the driver advances
+ * read_index so any waiter observes the command as finished. Only valid while
+ * the context is disconnected -- never race CERT's own read_index updates.
+ */
+static void update_read_index(struct amdxdna_hwctx *hwctx, u64 idx)
+{
+	struct amdxdna_hwctx_priv *priv = hwctx->priv;
+
+	/* Order cmd-bo state write before the waiter observes completion. */
+	wmb();
+	WRITE_ONCE(*priv->umq_read_index, idx);
+}
+
+static void job_abort(struct amdxdna_sched_job *job)
+{
+	struct amdxdna_hwctx *hwctx = job->hwctx;
+
+	XDNA_WARN(hwctx->client->xdna, "aborting %s job %lld", hwctx->name, job->seq);
+	amdxdna_cmd_set_state(job->cmd_bo, ERT_CMD_STATE_ABORT);
+	dma_fence_set_error(job->fence, -ECANCELED);
+	/*
+	 * Only force read_index forward when CERT has not already moved it past this
+	 * job. On the reset drain read_index is still <= job->seq (CERT stopped), so
+	 * advance it here to release waiters. For a partial chain closed by a later
+	 * command's LAST_CMD, CERT has already advanced read_index past this job -
+	 * do not clobber it.
+	 */
+	if (get_read_index(hwctx) <= job->seq)
+		update_read_index(hwctx, job->seq + 1);
+	job_done(job);
+}
+
+static void job_worker(struct work_struct *work)
+{
+	struct amdxdna_hwctx_priv *priv =
+		container_of(work, struct amdxdna_hwctx_priv, job_work);
+	struct amdxdna_hwctx *hwctx = priv->hwctx;
+	struct amdxdna_sched_job *job;
+
+	while ((job = peek_running_job(hwctx))) {
+		wait_till_seq_completed(hwctx, job->seq);
+		if (get_read_index(hwctx) > job->seq) {
+			dequeue_running_job(hwctx, job);
+			/*
+			 * read_index advanced past this job. A fully published
+			 * job (SUBMITTED) ran to completion. A partial chain
+			 * (SUBMITTING: a later sub-command failed to publish, so
+			 * the chain never got CHAIN_FLG_LAST_CMD) only reaches
+			 * here once a *later* command's LAST_CMD closes the
+			 * dangling runlist and advances read_index past it - so
+			 * report it ABORT, not a false completion. If no such
+			 * command follows, read_index never advances and we stay
+			 * parked in wait_till_seq_completed() above until the
+			 * user's wait_command() times out and breaks the wait
+			 * (or ctx teardown reaps it).
+			 */
+			if (job->aie4_job_state != AIE4_JOB_STATE_SUBMITTED)
+				job_abort(job);
+			else
+				job_complete(job);
+		} else if (aie4_hwctx_has_reset(hwctx)) {
+			dequeue_running_job(hwctx, job);
+			job_abort(job);
+		} else {
+			/* suspend/resume */
+			break;
+		}
+	}
+}
+
+int aie4_hwctx_wait_for_running(struct amdxdna_hwctx *hwctx)
+{
+	struct amdxdna_hwctx_priv *priv = hwctx->priv;
+	struct amdxdna_dev *xdna = hwctx->client->xdna;
+	struct amdxdna_sched_job *job;
+	long error;
+	int ret = 0;
+
+	mutex_lock(&priv->io_lock);
+	job = READ_ONCE(priv->pending_head);
+	if (job && job->aie4_job_state == AIE4_JOB_STATE_SUBMITTING) {
+		mutex_unlock(&priv->io_lock);
+		error = wait_event_timeout(priv->job_list_wq,
+					   READ_ONCE(priv->pending_head) != job,
+					   msecs_to_jiffies(2000));
+		if (!error) {
+			XDNA_WARN(xdna, "hwctx %s wait for submitting job timed out",
+				  hwctx->name);
+			ret = -ETIMEDOUT;
+		}
+	} else {
+		mutex_unlock(&priv->io_lock);
+	}
+
+	queue_work(priv->job_work_q, &priv->job_work);
+	flush_work(&priv->job_work);
+	return ret;
+}
+
+/*
+ * Submit the command(s) carried by @job into the host queue. Called with
+ * io_lock held. A single ERT_START_DPU maps to one queue entry; an
+ * ERT_CMD_CHAIN expands to one entry per sub-command, only the last of which
+ * carries CHAIN_FLG_LAST_CMD so CERT runs the whole chain back to back.
+ *
+ * job->seq tracks the last published sequence; the worker waits on it to reap
+ * the entire chain. job->aie4_job_state advances past PENDING as soon as any
+ * sub-command is published, so the caller knows whether in-flight commands must
+ * still be reaped even when a later sub-command fails to enqueue.
+ *
+ * Security: the chain payload and its BO handles come from user space; cache
+ * command_count and validate it against the payload size before walking the
+ * handle array so a bogus count cannot drive an out-of-bounds read.
+ */
+static int submit_job_cmds(struct amdxdna_hwctx *hwctx,
+			   struct amdxdna_sched_job *job, u32 op)
+{
+	struct amdxdna_gem_obj *cmd_abo = job->cmd_bo;
+	struct amdxdna_dev *xdna = hwctx->client->xdna;
+	struct amdxdna_cmd_chain *payload;
+	u32 payload_len, ccnt;
+	int ret;
+	u32 i;
+
+	/* Single cmd. */
+	if (op == ERT_START_DPU) {
+		ret = submit_one_cmd(hwctx, cmd_abo, true, true, &job->seq);
+		if (!ret)
+			job->aie4_job_state = AIE4_JOB_STATE_SUBMITTED;
+		return ret;
+	}
+
+	/* Cmd chain. */
+	payload = amdxdna_cmd_get_payload(cmd_abo, &payload_len);
+	if (!payload) {
+		XDNA_ERR(xdna, "Invalid cmd payload for chained cmd");
+		return -EINVAL;
+	}
+	ccnt = payload->command_count;
+	/*
+	 * A chain (runlist) must fit within the queue. CERT advances the host-visible
+	 * read_index only once per runlist - at the last sub-command (CHAIN_FLG_LAST_CMD),
+	 * not per sub-command - so a chain's own entries never free a queue slot until
+	 * the whole chain has been published and run. A chain longer than the queue
+	 * could therefore never publish its tail: it would block forever in
+	 * wait_till_connected_hsa_not_full() waiting for a slot that only frees at chain end.
+	 * Reject ccnt > CTX_MAX_CMDS. Also validate against the payload size before
+	 * walking the handle array so a bogus count cannot drive an out-of-bounds read.
+	 */
+	if (!ccnt || ccnt > CTX_MAX_CMDS ||
+	    payload_len < struct_size(payload, data, ccnt)) {
+		XDNA_ERR(xdna, "Invalid command count %u", ccnt);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < ccnt; i++) {
+		u32 boh = (u32)(payload->data[i]);
+		struct amdxdna_gem_obj *abo;
+
+		abo = amdxdna_gem_get_obj(hwctx->client, boh, AMDXDNA_BO_SHARE);
+		if (!abo) {
+			XDNA_ERR(xdna, "Failed to find cmd BO %u", boh);
+			ret = -ENOENT;
+			break;
+		}
+
+		/*
+		 * submit_one_cmd() blocks in wait_till_connected_hsa_not_full() until the
+		 * ctx is connected and a slot is free, so a concurrent suspend/disconnect
+		 * is waited out inline rather than returned here. The first sub-command
+		 * (i == 0, nothing published yet) waits through a TDR reset and runs on
+		 * the recreated ctx; a later sub-command returns -ECONNRESET if a reset
+		 * landed while waiting for a slot, so the published prefix is not split
+		 * across the reset. It also returns -ERESTARTSYS on a signal, or a
+		 * validation error. Break on any; a published prefix is then reaped by
+		 * the job worker's reset drain (see below).
+		 */
+		ret = submit_one_cmd(hwctx, abo, i + 1 == ccnt, i == 0, &job->seq);
+		amdxdna_gem_put_obj(abo);
+		if (ret)
+			break;
+		job->aie4_job_state = AIE4_JOB_STATE_SUBMITTING;
+	}
+	if (i == ccnt)
+		job->aie4_job_state = AIE4_JOB_STATE_SUBMITTED;
+
+	/*
+	 * As long as at least one sub-command was published, return success so the
+	 * caller enqueues the job on the running list; the job worker then reaps the
+	 * published prefix and reports the partial chain as failed (ABORT). Only when
+	 * nothing was published (i == 0) is the error returned to the caller.
+	 */
+	if (i > 0)
+		return 0;
+
+	return ret;
+}
+
+/*
+ * Whole-job submission is serialized across submitters that share a ctx via the
+ * pending list: a job is appended on entry and only the head of the list is
+ * allowed to publish its command(s). Because the head stays on the list for the
+ * entire duration of submit_job_cmds() -- which may drop io_lock to wait for
+ * free queue slots -- no other submitter can interleave its commands into the
+ * middle of the head job's command chain. io_lock protects the lists; the
+ * job_list_wq waitqueue notifies parked submitters when the head changes.
+ */
+/* Publish the current pending-list head for the lockless submit wait condition.
+ * Caller holds io_lock.
+ */
+static void update_pending_head(struct amdxdna_hwctx_priv *priv)
+{
+	WRITE_ONCE(priv->pending_head,
+		   list_first_entry_or_null(&priv->pending_job_list,
+					    struct amdxdna_sched_job, aie4_job_list));
+}
+
+static void enqueue_pending_job(struct amdxdna_hwctx *hwctx,
+				struct amdxdna_sched_job *job)
+{
+	struct amdxdna_hwctx_priv *priv = hwctx->priv;
+
+	mutex_lock(&priv->io_lock);
+	list_add_tail(&job->aie4_job_list, &priv->pending_job_list);
+	job->aie4_job_state = AIE4_JOB_STATE_PENDING;
+	update_pending_head(priv);
+	mutex_unlock(&priv->io_lock);
+
+	/* Let the next pending submitter re-check whether it is now first. */
+	wake_up_all(&priv->job_list_wq);
+}
+
+static void cancel_pending_job(struct amdxdna_hwctx *hwctx,
+			       struct amdxdna_sched_job *job)
+{
+	struct amdxdna_hwctx_priv *priv = hwctx->priv;
+
+	mutex_lock(&priv->io_lock);
+	list_del(&job->aie4_job_list);
+	job->aie4_job_state = AIE4_JOB_STATE_INIT;
+	update_pending_head(priv);
+	mutex_unlock(&priv->io_lock);
+	/* Let the next pending submitter re-check whether it is now first. */
+	wake_up_all(&priv->job_list_wq);
+}
+
+int aie4_cmd_submit(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *job, u64 *seq)
+{
+	struct amdxdna_hwctx_priv *priv = hwctx->priv;
+	struct amdxdna_dev *xdna = hwctx->client->xdna;
+	struct ww_acquire_ctx acquire_ctx;
+	struct amdxdna_gem_obj *abo;
+	u32 op;
+	int i;
+	int ret;
+
+	XDNA_DBG(xdna, "ctx %s job %p received", hwctx->name, job);
+
+	if (!job->cmd_bo) {
+		XDNA_ERR(xdna, "No command BO in job");
+		return -EINVAL;
+	}
+
+	op = amdxdna_cmd_get_op(job->cmd_bo);
+	if (op != ERT_START_DPU && op != ERT_CMD_CHAIN) {
+		XDNA_ERR(xdna, "Invalid cmd opcode %d", op);
+		return -EINVAL;
+	}
+
+	INIT_LIST_HEAD(&job->aie4_job_list);
+
+	/*
+	 * Hold a reference on the submitter's address space until the job
+	 * completes (job_done): on SVA/IOMMU platforms the device walks the
+	 * submitter's page tables while the command runs. Balanced with the
+	 * mmput_async() in job_done() and the mmput() on the failure paths below.
+	 */
+	if (!mmget_not_zero(job->mm)) {
+		XDNA_ERR(xdna, "Failed to get mm reference");
+		return -ESRCH;
+	}
+
+	/*
+	 * Lock all job BOs and reserve fences to match what aie2 does.
+	 * This attaches job->out_fence to each BO's reservation object,
+	 * ensuring concurrent invalidation waits for the job to complete.
+	 */
+	ret = drm_gem_lock_reservations(job->bos, job->bo_cnt, &acquire_ctx);
+	if (ret) {
+		XDNA_WARN(xdna, "Failed to lock BOs, ret %d", ret);
+		goto put_mm;
+	}
+
+	for (i = 0; i < job->bo_cnt; i++) {
+		ret = dma_resv_reserve_fences(job->bos[i]->resv, 1);
+		if (ret) {
+			XDNA_WARN(xdna, "Failed to reserve fences %d", ret);
+			drm_gem_unlock_reservations(job->bos, job->bo_cnt, &acquire_ctx);
+			goto put_mm;
+		}
+	}
+
+	down_read(&xdna->notifier_lock);
+	for (i = 0; i < job->bo_cnt; i++) {
+		abo = to_xdna_obj(job->bos[i]);
+		if (abo->mem.map_invalid) {
+			up_read(&xdna->notifier_lock);
+			drm_gem_unlock_reservations(job->bos, job->bo_cnt, &acquire_ctx);
+			ret = -EINVAL;
+			goto put_mm;
+		}
+	}
+
+	job->out_fence = dma_fence_get(job->fence);
+	for (i = 0; i < job->bo_cnt; i++)
+		dma_resv_add_fence(job->bos[i]->resv, job->out_fence, DMA_RESV_USAGE_WRITE);
+
+	up_read(&xdna->notifier_lock);
+	drm_gem_unlock_reservations(job->bos, job->bo_cnt, &acquire_ctx);
+
+	/*
+	 * Wait until this job is at the head of the pending list before touching
+	 * the queue (see enqueue_pending_job). Freezable so the freezer can
+	 * suspend a parked submitter in place across S3/S4 rather than aborting
+	 * the suspend; still interruptible so a signal (app exit/kill/^C) unwinds
+	 * it and does not keep ctx teardown (synchronize_srcu) blocked.
+	 */
+	enqueue_pending_job(hwctx, job);
+	ret = wait_event_freezable(priv->job_list_wq,
+				   READ_ONCE(priv->pending_head) == job);
+	if (ret) {
+		cancel_pending_job(hwctx, job);
+		goto signal_fence;
+	}
+
+	mutex_lock(&priv->io_lock);
+	ret = submit_job_cmds(hwctx, job, op);
+	if (ret) {
+		mutex_unlock(&priv->io_lock);
+		cancel_pending_job(hwctx, job);
+		goto signal_fence;
+	}
+
+	list_move_tail(&job->aie4_job_list, &priv->running_job_list);
+	update_pending_head(priv);
+	*seq = job->seq;
+	mutex_unlock(&priv->io_lock);
+
+	/* Release the next pending submitter and kick the reaper. */
+	wake_up_all(&priv->job_list_wq);
+	atomic64_inc(&hwctx->job_submit_cnt);
+	queue_work(priv->job_work_q, &priv->job_work);
+	return 0;
+
+signal_fence:
+	/*
+	 * Map internal -ERESTARTSYS to -ECANCELED for the fence so downstream
+	 * consumers (e.g. sync_file, dma-buf importers) do not observe internal
+	 * signal restart codes, while preserving ret for the syscall return.
+	 */
+	dma_fence_set_error(job->fence, ret == -ERESTARTSYS ? -ECANCELED : ret);
+	dma_fence_signal(job->fence);
+	dma_fence_put(job->out_fence);
+	job->out_fence = NULL;
+put_mm:
+	mmput(job->mm);
+	return ret;
+}
diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
index 7b36bd001b64..e5266237977c 100644
--- a/drivers/accel/amdxdna/aie4_pci.c
+++ b/drivers/accel/amdxdna/aie4_pci.c
@@ -1108,6 +1108,7 @@ const struct amdxdna_dev_ops aie4_vf_ops = {
 	.debugfs_init		= aie4_debugfs_init,
 	.hwctx_init		= aie4_hwctx_init,
 	.hwctx_fini		= aie4_hwctx_fini,
+	.cmd_submit		= aie4_cmd_submit,
 	.cmd_wait		= aie4_cmd_wait,
 	.get_aie_info		= aie4_get_info,
 	.set_aie_state		= aie4_set_state,
@@ -1119,6 +1120,7 @@ const struct amdxdna_dev_ops aie4_classic_ops = {
 	.debugfs_init		= aie4_debugfs_init,
 	.hwctx_init		= aie4_hwctx_init,
 	.hwctx_fini		= aie4_hwctx_fini,
+	.cmd_submit		= aie4_cmd_submit,
 	.cmd_wait		= aie4_cmd_wait,
 	.get_aie_info		= aie4_get_info,
 	.set_aie_state		= aie4_set_state,
diff --git a/drivers/accel/amdxdna/aie4_pci.h b/drivers/accel/amdxdna/aie4_pci.h
index f549d9e69d41..6b67c9da560e 100644
--- a/drivers/accel/amdxdna/aie4_pci.h
+++ b/drivers/accel/amdxdna/aie4_pci.h
@@ -50,6 +50,7 @@ struct amdxdna_hwctx_priv {
 
 	struct cert_comp                *cert_comp;
 	u32                             hw_ctx_id;
+	bool                            has_reset;
 
 	/* Kernel-mode submission: driver fills the user HSA queue and rings
 	 * the doorbell.  umq_pkts/umq_indirect_pkts alias the user umq_bo;
@@ -165,8 +166,10 @@ enum aie4_hwctx_flags {
 int aie4_hwctx_init(struct amdxdna_hwctx *hwctx);
 void aie4_hwctx_fini(struct amdxdna_hwctx *hwctx);
 int aie4_cmd_wait(struct amdxdna_hwctx *hwctx, u64 seq, u32 timeout);
+int aie4_cmd_submit(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *job, u64 *seq);
 int aie4_hwctx_create(struct amdxdna_hwctx *hwctx);
 void aie4_hwctx_destroy(struct amdxdna_hwctx *hwctx, enum aie4_hwctx_flags);
+int aie4_hwctx_wait_for_running(struct amdxdna_hwctx *hwctx);
 
 /* aie4_pci.c */
 int aie4_restore_power_mode(struct amdxdna_dev_hdl *ndev);
-- 
2.34.1

