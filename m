Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD012CA6007
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 03:24:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 249FF10FBFA;
	Thu,  8 Oct 2026 03:24:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oJUN00zq";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010067.outbound.protection.outlook.com
 [52.101.193.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9759810FA75
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 03:24:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dSbAV0q7iUBea2QmjLxGP5jPXSFK0JSgO4cAGcr9/pUfp7B7T+5Q+6jyd+ycUMXD7EdySLovzj2cJaamC6KSuRCOYVOX1D4ict5tp8jWuBq53EYUajdt6XrtmIekMGRxUkhcqV8Fckj1tsQAT5jFvL8UC4PYoimu7SNsd8nzDdjC4fPTX/d+2TSJMLF7IqO9oYURzlAbPZZE5I9d3iCZScev4fn8ELz7SmipUESbcBUDqSnsKpTVul/GJWpCU0nXWJ1+tVWptsCC/wSJrrpnQ7d0g/VWouMhrNWRNiOnIfYQXOvD4IUBsE1xkcvgc/M1GRFB5nB1icJGC4yqpa3nzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GOplivYPhoVRUWfAJQASy3gqpRAP5r2VUXNTX+ZVwDo=;
 b=gdqta+DNYrn+sYRngRdhLv6j+vnSfUiKJQItNHIIJU+QxEe57EkuVAugGLp5KNIzr+FAhGSw8pB9kKnKfLdaDvU87rN8cvkf5ajiJRJXnXrkIxz7rah2sIB5rB+LueFpFfunYkHHeLGpEzsr6uTudp5zMLkmTvxn+bTTx4Wz1A+8fZfCMumc1o0HdGpMiVTBpOZMUWu8BLyCC7KAtb4PZanyE1zSmhz9/zneK9UIdm6wpMbBfLGUIr+IY2QeYjZ7+yyDv1sfMwKJAT1qcQns3ggYL4fgWTWF5cu50jixkKWzG5ToBFUNe0nGkpNAqozzzOsLqLzQym1p14s3nrKXig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOplivYPhoVRUWfAJQASy3gqpRAP5r2VUXNTX+ZVwDo=;
 b=oJUN00zqPCgUw8AI8zIo+pQebq91ng32TR/nTNokm3MVYPX/QyaCqrjkD/x+KuJ9By6Tgr0lU4e7UKqbCqUIrTbTdubaMiZmcm/PuwQxfuwaOBlLZeRIcaNApNaQNEJtn2LKGGNFjqetBvbZcVS90Ax0xNh5794OdzThJUvLEew=
Received: from SJ0PR05CA0014.namprd05.prod.outlook.com (2603:10b6:a03:33b::19)
 by CH3PR12MB9454.namprd12.prod.outlook.com (2603:10b6:610:1c7::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Thu, 8 Oct
 2026 03:24:18 +0000
Received: from SJ1PEPF000037AC.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::77) by SJ0PR05CA0014.outlook.office365.com
 (2603:10b6:a03:33b::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Thu, 8
 Oct 2026 03:24:17 +0000
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
 15.21.496.14 via Frontend Transport; Thu, 8 Oct 2026 03:24:17 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 22:24:09 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Wed, 7 Oct 2026 22:24:09 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>, Wendy Liang <wendy.liang@amd.com>
Subject: [PATCH V3 16/19] accel/amdxdna: Implement AIE4 command packet
 building and submission
Date: Wed, 7 Oct 2026 20:23:45 -0700
Message-ID: <20261008032348.2044667-17-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261008032348.2044667-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20261008032348.2044667-1-yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AC:EE_|CH3PR12MB9454:EE_
X-MS-Office365-Filtering-Correlation-Id: 9de4988f-c889-4b05-876b-08df24eba2e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|23010399003|36860700016|1800799024|6133799003|22082099003|18002099003|10067099003|3023799007|4143699003|11063799006|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info: M7HNSpQISM2sBr4VI+w32Z1qj/2DSHzQTep0xcoyS1dwXSLGsSEDZmYecCyaVXVTprXaiKEeVHs946TauetoS72ScUOFbodAUpgv3d+bs6gvFatCb6XthZUV5GzhjJI1w2wKxyQzMZf/MZISYXaEuh0PRysaPEfre9hU5J9gpMAwDQOw6kTK/8wFxbU6NAf3sJT7aSaDZMMWkwhnRSw5jDPW5Iwj63VjKvV0+rb2NmsAZCkO3orIH4cQxC9OEJbLn7z+uXVXKOw1CSDggcGZIGc4mNqh8OsgC5vFxGNVAdDvIWkc45tc3NKLjXzhaNccDd0U4HQuqAhzJntWORWBGDc6YaxIaK4BcgTP1ZmZsdZZb1N/1BN3AqT4QHUCorLsBO/YgUq/oAQKBryylsEACrC/KKnexQ3G+lDmf4dsHUdb9OmoCETuSgBPPD39rrXjIsjpikofmAiHh0ipnTLayAXapn+BYp9RJkz4AXq6NIyGO1A9xY3rjjuE53O4QF8AtXMDY0L6QrmUC2KKNFbNRCAzk4N0SAs+tDH3zP11WYcR4pFirCyjPdbFTCAj+1oG6w+i++XS6VmaUQtOd8lMxkxCLnnql9k8hBL3qqZbFNtpkMJ96vhn9Y+XFeN6JftXz+ZUMFh0C5X9Na598SpMt0fdHlWFcCkvnq+lsPYr+hmB3QYO4ZLUwJ1sXuAFJvNymLGAeOE1t+CzoJcTRxnphw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(23010399003)(36860700016)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(3023799007)(4143699003)(11063799006)(56012099006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: E/DiZUVH6kwNAkLEEDtwx8iocnbM1T6qUPEENbswZLnS0jo/Xp59mAoiKdja5pWmOvpjhj0LAfzky8cuqJeaqhh1+uMeQngL7xvjJB3XO9JUodgJcLVnqzaaTsYFGfqQ8QdIqgqH9El0M6Eq7UmWVodJPchB8AqfjsfJdWLcrIZE6YO1wRtZW1jXJehPT/jiiZOCyvLCrO41ZIZBonstJMhbIFspAgWJjpc3aAexaDoGkpTANIORy6/ltXJLg3aGNI8SsyRBFTuBljmEDZc9orWAF3GslImt+f8VY/8zsWCh/row78gOY4Vmnhd3OGt1hPWyxkN8awkdIQz9XQh/gMi/DoA1Cof8PaOSJzTj0Y73lW63dBF0x7d1ZsMPTQpswVOhayi89rad0LJb+sO/J/oi4aN7rHUQJryfAF5S1yTefqatx0bNtbxzRvwPLoMT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 03:24:17.7498 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9de4988f-c889-4b05-876b-08df24eba2e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9454
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
- Build direct and indirect packets with fill_direct_pkt() and
  fill_indirect_pkt().
- Allocate a unique fence timeline context per job, and return
  KBUILD_MODNAME as the fence timeline name.
- Add .hwctx_stop callback to struct amdxdna_dev_ops and invoke it,
  with dev_lock held, before synchronize_srcu() in
  amdxdna_hwctx_destroy_rcu() and amdxdna_hwctx_remove_all().
- Hold references to sub-command BOs in chained submissions until job
  release to prevent use-after-free and DMA writeback to freed memory.
- Pre-validate all sub-command BOs and payloads before dispatching
  packets to the hardware queue.
- Lock and fence command BOs, including chained sub-command BOs,
  together with the argument BOs.
- Repopulate BOs with invalidated user mappings with
  amdxdna_populate_range() before attaching the job fence, retrying
  until all mappings are valid.

Job completion is not yet bounded by a timeout. A job that never
completes keeps its fence unsignaled until the hardware context is
stopped, destroyed or suspended, which aborts it with -ECANCELED.
Job timeout detection and recovery (TDR) will be added in a follow-up
change to guarantee the fence signaling in finite time.

Co-developed-by: Max Zhen <max.zhen@amd.com>
Signed-off-by: Max Zhen <max.zhen@amd.com>
Co-developed-by: Wendy Liang <wendy.liang@amd.com>
Signed-off-by: Wendy Liang <wendy.liang@amd.com>
Signed-off-by: David Zhang <yidong.zhang@amd.com>
---
 drivers/accel/amdxdna/aie4_ctx.c        | 761 +++++++++++++++++++++++-
 drivers/accel/amdxdna/aie4_pci.c        |   4 +
 drivers/accel/amdxdna/aie4_pci.h        |   4 +
 drivers/accel/amdxdna/amdxdna_ctx.c     |  25 +-
 drivers/accel/amdxdna/amdxdna_ctx.h     |   6 +-
 drivers/accel/amdxdna/amdxdna_pci_drv.h |   1 +
 6 files changed, 784 insertions(+), 17 deletions(-)

diff --git a/drivers/accel/amdxdna/aie4_ctx.c b/drivers/accel/amdxdna/aie4_ctx.c
index 09c92b1b5134..31bf30b9dc86 100644
--- a/drivers/accel/amdxdna/aie4_ctx.c
+++ b/drivers/accel/amdxdna/aie4_ctx.c
@@ -9,6 +9,7 @@
 #include <drm/drm_gem_shmem_helper.h>
 #include <drm/drm_print.h>
 #include <drm/gpu_scheduler.h>
+#include <linux/hmm.h>
 #include <linux/iommu.h>
 #include <linux/types.h>
 
@@ -25,9 +26,7 @@
 #define CTX_INVALID_ID			(~0U)
 #define CTX_INVALID_DOORBELL		AMDXDNA_INVALID_DOORBELL_OFFSET
 
-static void job_worker(struct work_struct *work)
-{
-}
+static void job_worker(struct work_struct *work);
 
 static struct cert_comp *aie4_lookup_cert_comp(struct amdxdna_dev_hdl *ndev, u32 msix_idx)
 {
@@ -203,6 +202,7 @@ int aie4_hwctx_create(struct amdxdna_hwctx *hwctx)
 		hwctx->fw_ctx_id = -1;
 		return ret;
 	}
+	WRITE_ONCE(priv->has_error, false);
 	WRITE_ONCE(priv->cert_comp, cert_comp);
 	mutex_unlock(&priv->io_lock);
 	hwctx->doorbell_offset = CTX_INVALID_DOORBELL;
@@ -211,6 +211,17 @@ int aie4_hwctx_create(struct amdxdna_hwctx *hwctx)
 	return 0;
 }
 
+/* Linked cert_comp acts as connected sentinel for submit waiters. */
+static bool aie4_hwctx_connected(struct amdxdna_hwctx *hwctx)
+{
+	return !!READ_ONCE(hwctx->priv->cert_comp);
+}
+
+static bool aie4_hwctx_has_error(struct amdxdna_hwctx *hwctx)
+{
+	return READ_ONCE(hwctx->priv->has_error);
+}
+
 void aie4_hwctx_destroy(struct amdxdna_hwctx *hwctx, enum aie4_hwctx_flags flags)
 {
 	struct amdxdna_client *client = hwctx->client;
@@ -218,10 +229,16 @@ void aie4_hwctx_destroy(struct amdxdna_hwctx *hwctx, enum aie4_hwctx_flags flags
 	struct amdxdna_dev *xdna = client->xdna;
 	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
 	struct cert_comp *cert_comp;
+	bool has_error = false;
 
 	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
 
+	if (flags == AIE4_HWCTX_DISCONNECT || flags == AIE4_HWCTX_ERROR)
+		has_error = true;
+
 	mutex_lock(&priv->io_lock);
+	if (has_error)
+		WRITE_ONCE(priv->has_error, true);
 	cert_comp = priv->cert_comp;
 	WRITE_ONCE(priv->cert_comp, NULL);
 	mutex_unlock(&priv->io_lock);
@@ -229,6 +246,9 @@ void aie4_hwctx_destroy(struct amdxdna_hwctx *hwctx, enum aie4_hwctx_flags flags
 	if (cert_comp)
 		wake_up_all(&cert_comp->waitq);
 
+	if (has_error)
+		wake_up_all(&priv->job_list_wq);
+
 	if (flags != AIE4_HWCTX_DISCONNECT)
 		aie4_msg_destroy_context(ndev, priv->hw_ctx_id);
 
@@ -239,7 +259,9 @@ void aie4_hwctx_destroy(struct amdxdna_hwctx *hwctx, enum aie4_hwctx_flags flags
 	hwctx->fw_ctx_id = -1;
 	hwctx->doorbell_offset = CTX_INVALID_DOORBELL;
 
-	cancel_work_sync(&priv->job_work);
+	/* Skip cancel_work_sync on error so worker can abort in-flight jobs. */
+	if (!has_error)
+		cancel_work_sync(&priv->job_work);
 }
 
 static void aie4_hwctx_umq_fini(struct amdxdna_hwctx *hwctx)
@@ -374,14 +396,25 @@ int aie4_hwctx_init(struct amdxdna_hwctx *hwctx)
 	return ret;
 }
 
-void aie4_hwctx_fini(struct amdxdna_hwctx *hwctx)
+void aie4_hwctx_stop(struct amdxdna_hwctx *hwctx)
 {
 	struct amdxdna_hwctx_priv *priv = hwctx->priv;
 
+	if (priv->hw_ctx_id == CTX_INVALID_ID)
+		return;
+
+	/* Mark error to drain running jobs and unlink cert_comp to wake waiters. */
 	aie4_hwctx_destroy(hwctx, AIE4_HWCTX_ERROR);
-	cancel_work_sync(&priv->job_work);
-	if (priv->job_work_q)
+}
+
+void aie4_hwctx_fini(struct amdxdna_hwctx *hwctx)
+{
+	struct amdxdna_hwctx_priv *priv = hwctx->priv;
+
+	if (priv->job_work_q) {
+		aie4_hwctx_wait_for_running(hwctx);
 		destroy_workqueue(priv->job_work_q);
+	}
 	aie4_hwctx_umq_fini(hwctx);
 	mutex_destroy(&priv->io_lock);
 	kfree(hwctx->priv);
@@ -469,3 +502,717 @@ int aie4_cmd_wait(struct amdxdna_hwctx *hwctx, u64 seq, u32 timeout)
 
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
+	/* Wait for queue slot; freezable for suspend, interruptible for signals. */
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
+static int wait_till_connected_hsa_not_full(struct amdxdna_hwctx *hwctx)
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
+					   aie4_hwctx_has_error(hwctx));
+		mutex_lock(&priv->io_lock);
+		if (ret)
+			return ret;
+		if (aie4_hwctx_has_error(hwctx)) {
+			XDNA_DBG(xdna, "ctx %s in error; unwinding -ENODEV",
+				 hwctx->name);
+			return -ENODEV;
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
+	if (!entries || entries > HSA_MAX_LEVEL1_INDIRECT_ENTRIES) {
+		XDNA_ERR(priv->hwctx->client->xdna, "Invalid indirect entries %u", entries);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < entries; i++, dpu++, hipe++) {
+		struct host_indirect_packet_data *hipd;
+		u64 indirect_pkt_dev_addr;
+		u32 uci = READ_ONCE(dpu->uc_index);
+		u64 dtrace_buf = READ_ONCE(dpu->dtrace_buffer);
+		u64 inst_buf = READ_ONCE(dpu->instruction_buffer);
+		u32 idx;
+
+		/* Validate uc_index against indirect packet bounds before publication. */
+		if (uci >= HSA_MAX_LEVEL1_INDIRECT_ENTRIES) {
+			XDNA_ERR(priv->hwctx->client->xdna, "Invalid uc index %d", uci);
+			return -EINVAL;
+		}
+		if (upper_32_bits(dtrace_buf) > U16_MAX) {
+			XDNA_ERR(priv->hwctx->client->xdna,
+				 "Invalid dtrace buffer address 0x%llx", dtrace_buf);
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
+			lower_32_bits(inst_buf);
+		hipd->payload.dpu_control_code_host_addr_high =
+			upper_32_bits(inst_buf);
+		hipd->payload.dtrace_buf_host_addr_low =
+			lower_32_bits(dtrace_buf);
+		hipd->payload.dtrace_buf_host_addr_high =
+			lower_16_bits(upper_32_bits(dtrace_buf));
+	}
+	pkt->pkt_header.common_header.distribute = 1;
+	pkt->pkt_header.common_header.indirect = 1;
+	pkt->pkt_header.common_header.count = entries * sizeof(*hipe);
+	return 0;
+}
+
+static int fill_direct_pkt(struct amdxdna_hwctx_priv *priv, u64 slot_idx,
+			   struct amdxdna_cmd_start_dpu *dpu)
+{
+	struct host_queue_packet *pkt = &priv->umq_pkts[slot_idx];
+	struct exec_buf *ebuf = (struct exec_buf *)(pkt->data);
+	u64 dtrace_buf = READ_ONCE(dpu->dtrace_buffer);
+	u64 inst_buf = READ_ONCE(dpu->instruction_buffer);
+
+	if (upper_32_bits(dtrace_buf) > U16_MAX) {
+		XDNA_ERR(priv->hwctx->client->xdna,
+			 "Invalid dtrace buffer address 0x%llx", dtrace_buf);
+		return -EINVAL;
+	}
+
+	memset(pkt->data, 0, sizeof(pkt->data));
+	ebuf->dpu_control_code_host_addr_low = lower_32_bits(inst_buf);
+	ebuf->dpu_control_code_host_addr_high = upper_32_bits(inst_buf);
+	ebuf->dtrace_buf_host_addr_low = lower_32_bits(dtrace_buf);
+	ebuf->dtrace_buf_host_addr_high = lower_16_bits(upper_32_bits(dtrace_buf));
+	pkt->pkt_header.common_header.distribute = 0;
+	pkt->pkt_header.common_header.indirect = 0;
+	pkt->pkt_header.common_header.count = sizeof(*ebuf);
+	return 0;
+}
+
+static int validate_cmd_abo(struct amdxdna_dev *xdna, struct amdxdna_gem_obj *cmd_abo,
+			    struct amdxdna_cmd_start_dpu **dpu_out, u16 *chained_cnt)
+{
+	struct amdxdna_cmd_start_dpu *dpu;
+	u32 payload_size;
+	u16 chained;
+	u32 op;
+	u16 i;
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
+	chained = READ_ONCE(dpu->chained);
+	if (chained >= HSA_MAX_LEVEL1_INDIRECT_ENTRIES ||
+	    payload_size < (u32)(chained + 1) * sizeof(*dpu)) {
+		XDNA_ERR(xdna, "Invalid DPU chained entries %u, payload %u",
+			 chained, payload_size);
+		return -EINVAL;
+	}
+
+	if (!chained) {
+		u64 dtrace_buf = READ_ONCE(dpu->dtrace_buffer);
+
+		if (upper_32_bits(dtrace_buf) > U16_MAX) {
+			XDNA_ERR(xdna, "Invalid dtrace buffer address 0x%llx", dtrace_buf);
+			return -EINVAL;
+		}
+	} else {
+		for (i = 0; i <= chained; i++) {
+			u32 uci = READ_ONCE(dpu[i].uc_index);
+			u64 dtrace_buf = READ_ONCE(dpu[i].dtrace_buffer);
+
+			if (uci >= HSA_MAX_LEVEL1_INDIRECT_ENTRIES) {
+				XDNA_ERR(xdna, "Invalid uc index %u", uci);
+				return -EINVAL;
+			}
+			if (upper_32_bits(dtrace_buf) > U16_MAX) {
+				XDNA_ERR(xdna, "Invalid dtrace buffer address 0x%llx", dtrace_buf);
+				return -EINVAL;
+			}
+		}
+	}
+
+	if (dpu_out)
+		*dpu_out = dpu;
+	if (chained_cnt)
+		*chained_cnt = chained;
+
+	return 0;
+}
+
+/* Build and submit one HSA command into the user host queue. Holds io_lock. */
+static int submit_one_cmd(struct amdxdna_hwctx *hwctx,
+			  struct amdxdna_gem_obj *cmd_abo, bool last_of_chain,
+			  u64 *seq)
+{
+	struct amdxdna_hwctx_priv *priv = hwctx->priv;
+	struct amdxdna_dev *xdna = hwctx->client->xdna;
+	struct amdxdna_cmd_start_dpu *dpu;
+	struct host_queue_packet *pkt;
+	u64 slot_idx;
+	u16 chained;
+	int ret;
+
+	/* Use the validated payload pointer; the header is user-writable. */
+	ret = validate_cmd_abo(xdna, cmd_abo, &dpu, &chained);
+	if (ret)
+		return ret;
+
+	/* Wait for queue slot and connected state. Drops and re-acquires io_lock. */
+	ret = wait_till_connected_hsa_not_full(hwctx);
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
+		ret = fill_direct_pkt(priv, slot_idx, dpu);
+		if (ret)
+			return ret;
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
+/* Peek head job without removing it from running list. */
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
+	u32 i;
+
+	for (i = 0; i < job->aie4_cmd_bo_cnt; i++)
+		amdxdna_gem_put_obj(job->aie4_cmd_bos[i]);
+	kfree(job->aie4_cmd_bos);
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
+	/* Release submitter mm reference taken at submit. */
+	mmput_async(job->mm);
+	kref_put(&job->refcnt, aie4_job_release);
+}
+
+static void job_complete(struct amdxdna_sched_job *job)
+{
+	job_done(job);
+}
+
+/* Advance read_index when disconnected to unblock waiters. */
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
+	u32 i;
+
+	XDNA_WARN(hwctx->client->xdna, "aborting %s job %lld", hwctx->name, job->seq);
+	amdxdna_cmd_set_state(job->cmd_bo, ERT_CMD_STATE_ABORT);
+	for (i = 0; i < job->aie4_cmd_bo_cnt; i++)
+		amdxdna_cmd_set_state(job->aie4_cmd_bos[i], ERT_CMD_STATE_ABORT);
+	dma_fence_set_error(job->fence, -ECANCELED);
+	/* Advance read_index only if CERT has not already moved past this job. */
+	if (get_read_index(hwctx) <= job->seq)
+		update_read_index(hwctx, job->seq + 1);
+	job_done(job);
+}
+
+/* Job timeout detection (TDR) will guarantee the fence signalling */
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
+			/* Abort partially submitted jobs; complete fully submitted ones. */
+			if (job->aie4_job_state != AIE4_JOB_STATE_SUBMITTED)
+				job_abort(job);
+			else
+				job_complete(job);
+		} else if (aie4_hwctx_has_error(hwctx)) {
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
+static void put_cmd_bos(struct amdxdna_sched_job *job)
+{
+	u32 i;
+
+	for (i = 0; i < job->aie4_cmd_bo_cnt; i++)
+		amdxdna_gem_put_obj(job->aie4_cmd_bos[i]);
+	kfree(job->aie4_cmd_bos);
+	job->aie4_cmd_bos = NULL;
+	job->aie4_cmd_bo_cnt = 0;
+}
+
+/* Look up and validate all sub-command BOs of a command chain. */
+static int get_cmd_bos(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *job)
+{
+	struct amdxdna_dev *xdna = hwctx->client->xdna;
+	struct amdxdna_cmd_chain *payload;
+	struct amdxdna_gem_obj *abo;
+	u32 payload_len, ccnt;
+	int ret;
+	u32 i;
+
+	payload = amdxdna_cmd_get_payload(job->cmd_bo, &payload_len);
+	if (!payload) {
+		XDNA_ERR(xdna, "Invalid cmd payload for chained cmd");
+		return -EINVAL;
+	}
+	ccnt = READ_ONCE(payload->command_count);
+	/* A command chain cannot exceed queue capacity. */
+	if (!ccnt || ccnt > CTX_MAX_CMDS ||
+	    payload_len < struct_size(payload, data, ccnt)) {
+		XDNA_ERR(xdna, "Invalid command count %u", ccnt);
+		return -EINVAL;
+	}
+
+	job->aie4_cmd_bos = kcalloc(ccnt, sizeof(*job->aie4_cmd_bos), GFP_KERNEL);
+	if (!job->aie4_cmd_bos)
+		return -ENOMEM;
+
+	for (i = 0; i < ccnt; i++) {
+		u32 boh = (u32)(payload->data[i]);
+
+		abo = amdxdna_gem_get_obj(hwctx->client, boh, AMDXDNA_BO_SHARE);
+		if (!abo) {
+			XDNA_ERR(xdna, "Failed to find cmd BO %u at index %u", boh, i);
+			ret = -ENOENT;
+			goto put_bos;
+		}
+		job->aie4_cmd_bos[job->aie4_cmd_bo_cnt++] = abo;
+
+		ret = validate_cmd_abo(xdna, abo, NULL, NULL);
+		if (ret)
+			goto put_bos;
+	}
+
+	return 0;
+
+put_bos:
+	put_cmd_bos(job);
+	return ret;
+}
+
+/* Append a GEM object to the lock list unless it is already there. */
+static void add_lock_obj(struct drm_gem_object **objs, u32 *cnt,
+			 struct drm_gem_object *obj)
+{
+	u32 i;
+
+	for (i = 0; i < *cnt; i++) {
+		if (objs[i] == obj)
+			return;
+	}
+	objs[(*cnt)++] = obj;
+}
+
+/*
+ * Lock arg and command BOs, repopulate invalidated mappings and attach
+ * the job fence. The NPU writes completion to command BO headers, so
+ * they are fenced too. Duplicates are skipped as
+ * drm_gem_lock_reservations() fails on them.
+ */
+static int fence_job_bos(struct amdxdna_dev *xdna, struct amdxdna_sched_job *job)
+{
+	struct ww_acquire_ctx acquire_ctx;
+	struct drm_gem_object **objs;
+	struct amdxdna_gem_obj *abo;
+	unsigned long timeout = 0;
+	u32 cnt = 0;
+	int ret;
+	u32 i;
+
+	objs = kmalloc_array(job->bo_cnt + 1 + job->aie4_cmd_bo_cnt,
+			     sizeof(*objs), GFP_KERNEL);
+	if (!objs)
+		return -ENOMEM;
+
+	for (i = 0; i < job->bo_cnt; i++)
+		add_lock_obj(objs, &cnt, job->bos[i]);
+	add_lock_obj(objs, &cnt, to_gobj(job->cmd_bo));
+	for (i = 0; i < job->aie4_cmd_bo_cnt; i++)
+		add_lock_obj(objs, &cnt, to_gobj(job->aie4_cmd_bos[i]));
+
+retry:
+	ret = drm_gem_lock_reservations(objs, cnt, &acquire_ctx);
+	if (ret) {
+		XDNA_WARN(xdna, "Failed to lock BOs, ret %d", ret);
+		goto free_objs;
+	}
+
+	for (i = 0; i < cnt; i++) {
+		ret = dma_resv_reserve_fences(objs[i]->resv, 1);
+		if (ret) {
+			XDNA_WARN(xdna, "Failed to reserve fences %d", ret);
+			goto unlock;
+		}
+	}
+
+	down_read(&xdna->notifier_lock);
+	for (i = 0; i < cnt; i++) {
+		abo = to_xdna_obj(objs[i]);
+		if (abo->mem.map_invalid) {
+			up_read(&xdna->notifier_lock);
+			drm_gem_unlock_reservations(objs, cnt, &acquire_ctx);
+			if (!timeout) {
+				timeout = jiffies +
+					msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
+			} else if (time_after(jiffies, timeout)) {
+				ret = -ETIME;
+				goto free_objs;
+			}
+
+			ret = amdxdna_populate_range(abo);
+			if (ret)
+				goto free_objs;
+			goto retry;
+		}
+	}
+
+	job->out_fence = dma_fence_get(job->fence);
+	for (i = 0; i < cnt; i++)
+		dma_resv_add_fence(objs[i]->resv, job->out_fence, DMA_RESV_USAGE_WRITE);
+	up_read(&xdna->notifier_lock);
+
+unlock:
+	drm_gem_unlock_reservations(objs, cnt, &acquire_ctx);
+free_objs:
+	kfree(objs);
+	return ret;
+}
+
+/*
+ * Submit job command(s) to host queue. Called with io_lock held.
+ * Returns 0 on success or if partial chain is queued for worker abort.
+ */
+static int submit_job_cmds(struct amdxdna_hwctx *hwctx,
+			   struct amdxdna_sched_job *job, u32 op)
+{
+	int ret = 0;
+	u32 i;
+
+	/* Single cmd. */
+	if (op == ERT_START_DPU) {
+		ret = submit_one_cmd(hwctx, job->cmd_bo, true, &job->seq);
+		if (!ret)
+			job->aie4_job_state = AIE4_JOB_STATE_SUBMITTED;
+		return ret;
+	}
+
+	/* Cmd chain. Sub-command BOs were looked up and validated at submit. */
+	for (i = 0; i < job->aie4_cmd_bo_cnt; i++) {
+		ret = submit_one_cmd(hwctx, job->aie4_cmd_bos[i],
+				     i + 1 == job->aie4_cmd_bo_cnt, &job->seq);
+		if (ret)
+			break;
+		job->aie4_job_state = AIE4_JOB_STATE_SUBMITTING;
+	}
+
+	if (!ret) {
+		job->aie4_job_state = AIE4_JOB_STATE_SUBMITTED;
+		return 0;
+	}
+
+	/*
+	 * If partial submission occurred, return 0 so the job is queued to
+	 * running_job_list. The worker will wait for hardware to finish the
+	 * published packets (up to job->seq), then abort the job safely.
+	 */
+	if (job->aie4_job_state == AIE4_JOB_STATE_SUBMITTING)
+		return 0;
+
+	return ret;
+}
+
+/* Pending list serializes job submissions on the hardware queue. */
+/* Publish current pending-list head for lockless submit wait condition. */
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
+	u32 op;
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
+	/* Pin submitter's address space until job completion. */
+	if (!mmget_not_zero(job->mm)) {
+		XDNA_ERR(xdna, "Failed to get mm reference");
+		return -ESRCH;
+	}
+
+	if (op == ERT_CMD_CHAIN) {
+		ret = get_cmd_bos(hwctx, job);
+		if (ret)
+			goto put_mm;
+	}
+
+	ret = fence_job_bos(xdna, job);
+	if (ret)
+		goto put_mm;
+
+	/* Wait until this job reaches head of pending list. */
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
+		/* No command was published; cancel pending job and signal fence error. */
+		mutex_unlock(&priv->io_lock);
+		cancel_pending_job(hwctx, job);
+		goto signal_fence;
+	}
+
+	/* Move in-flight or partial job to running list for worker completion. */
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
+	/* Map -ERESTARTSYS to -ECANCELED for exported fence error status. */
+	dma_fence_set_error(job->fence, ret == -ERESTARTSYS ? -ECANCELED : ret);
+	dma_fence_signal(job->fence);
+	dma_fence_put(job->out_fence);
+	job->out_fence = NULL;
+put_mm:
+	put_cmd_bos(job);
+	mmput(job->mm);
+	return ret;
+}
diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
index 0d59d036a06c..aa383b3c5228 100644
--- a/drivers/accel/amdxdna/aie4_pci.c
+++ b/drivers/accel/amdxdna/aie4_pci.c
@@ -1084,7 +1084,9 @@ const struct amdxdna_dev_ops aie4_vf_ops = {
 	.fini			= aie4_vf_fini,
 	.debugfs_init		= aie4_debugfs_init,
 	.hwctx_init		= aie4_hwctx_init,
+	.hwctx_stop		= aie4_hwctx_stop,
 	.hwctx_fini		= aie4_hwctx_fini,
+	.cmd_submit		= aie4_cmd_submit,
 	.cmd_wait		= aie4_cmd_wait,
 	.get_aie_info		= aie4_get_info,
 	.set_aie_state		= aie4_set_state,
@@ -1095,7 +1097,9 @@ const struct amdxdna_dev_ops aie4_classic_ops = {
 	.fini			= aie4_classic_fini,
 	.debugfs_init		= aie4_debugfs_init,
 	.hwctx_init		= aie4_hwctx_init,
+	.hwctx_stop		= aie4_hwctx_stop,
 	.hwctx_fini		= aie4_hwctx_fini,
+	.cmd_submit		= aie4_cmd_submit,
 	.cmd_wait		= aie4_cmd_wait,
 	.get_aie_info		= aie4_get_info,
 	.set_aie_state		= aie4_set_state,
diff --git a/drivers/accel/amdxdna/aie4_pci.h b/drivers/accel/amdxdna/aie4_pci.h
index 3d3301ce11ae..da5aa57bc43f 100644
--- a/drivers/accel/amdxdna/aie4_pci.h
+++ b/drivers/accel/amdxdna/aie4_pci.h
@@ -48,6 +48,7 @@ struct amdxdna_hwctx_priv {
 
 	struct cert_comp                *cert_comp;
 	u32                             hw_ctx_id;
+	bool                            has_error;
 
 	/* Direct and indirect packet storage aliasing umq_bo. */
 	u64                             write_index;
@@ -146,10 +147,13 @@ enum aie4_hwctx_flags {
 };
 
 int aie4_hwctx_init(struct amdxdna_hwctx *hwctx);
+void aie4_hwctx_stop(struct amdxdna_hwctx *hwctx);
 void aie4_hwctx_fini(struct amdxdna_hwctx *hwctx);
 int aie4_cmd_wait(struct amdxdna_hwctx *hwctx, u64 seq, u32 timeout);
+int aie4_cmd_submit(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *job, u64 *seq);
 int aie4_hwctx_create(struct amdxdna_hwctx *hwctx);
 void aie4_hwctx_destroy(struct amdxdna_hwctx *hwctx, enum aie4_hwctx_flags);
+int aie4_hwctx_wait_for_running(struct amdxdna_hwctx *hwctx);
 
 /* aie4_pci.c */
 int aie4_restore_power_mode(struct amdxdna_dev_hdl *ndev);
diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/amdxdna_ctx.c
index 888e857ec558..608b86fe8f6b 100644
--- a/drivers/accel/amdxdna/amdxdna_ctx.c
+++ b/drivers/accel/amdxdna/amdxdna_ctx.c
@@ -25,7 +25,6 @@
 struct amdxdna_fence {
 	struct dma_fence	base;
 	spinlock_t		lock; /* for base */
-	struct amdxdna_hwctx	*hwctx;
 };
 
 static const char *amdxdna_fence_get_driver_name(struct dma_fence *fence)
@@ -35,11 +34,8 @@ static const char *amdxdna_fence_get_driver_name(struct dma_fence *fence)
 
 static const char *amdxdna_fence_get_timeline_name(struct dma_fence *fence)
 {
-	struct amdxdna_fence *xdna_fence;
-
-	xdna_fence = container_of(fence, struct amdxdna_fence, base);
-
-	return xdna_fence->hwctx->name;
+	/* Constant string ensures name remains valid if fence outlives device. */
+	return KBUILD_MODNAME;
 }
 
 static const struct dma_fence_ops fence_ops = {
@@ -55,9 +51,9 @@ static struct dma_fence *amdxdna_fence_create(struct amdxdna_hwctx *hwctx)
 	if (!fence)
 		return NULL;
 
-	fence->hwctx = hwctx;
 	spin_lock_init(&fence->lock);
-	dma_fence_init(&fence->base, &fence_ops, &fence->lock, hwctx->id, 0);
+	/* Unique timeline context prevents eviction from shared BO reservation. */
+	dma_fence_init(&fence->base, &fence_ops, &fence->lock, dma_fence_context_alloc(1), 0);
 	return &fence->base;
 }
 
@@ -84,6 +80,9 @@ static void amdxdna_hwctx_destroy_rcu(struct amdxdna_hwctx *hwctx,
 	struct amdxdna_client *client = hwctx->client;
 	struct amdxdna_dev *xdna = client->xdna;
 
+	if (xdna->dev_info->ops->hwctx_stop)
+		xdna->dev_info->ops->hwctx_stop(hwctx);
+
 	synchronize_srcu(ss);
 
 	/* At this point, user is not able to submit new commands */
@@ -206,11 +205,17 @@ int amdxdna_cmd_set_error(struct amdxdna_gem_obj *abo,
  */
 void amdxdna_hwctx_remove_all(struct amdxdna_client *client)
 {
+	struct amdxdna_dev *xdna = client->xdna;
 	struct amdxdna_hwctx *hwctx;
 	unsigned long hwctx_id;
 
+	if (xdna->dev_info->ops->hwctx_stop) {
+		amdxdna_for_each_hwctx(client, hwctx_id, hwctx)
+			xdna->dev_info->ops->hwctx_stop(hwctx);
+	}
+
 	amdxdna_for_each_hwctx(client, hwctx_id, hwctx) {
-		XDNA_DBG(client->xdna, "PID %d close HW context %d",
+		XDNA_DBG(xdna, "PID %d close HW context %d",
 			 client->pid, hwctx->id);
 		xa_erase(&client->hwctx_xa, hwctx->id);
 		amdxdna_hwctx_destroy_rcu(hwctx, &client->hwctx_srcu);
@@ -289,6 +294,8 @@ int amdxdna_drm_create_hwctx_ioctl(struct drm_device *dev, void *data, struct dr
 free_name:
 	kfree(hwctx->name);
 fini_hwctx:
+	if (xdna->dev_info->ops->hwctx_stop)
+		xdna->dev_info->ops->hwctx_stop(hwctx);
 	xdna->dev_info->ops->hwctx_fini(hwctx);
 release_expanded_heap:
 	amdxdna_hwctx_release_expanded_heap(hwctx);
diff --git a/drivers/accel/amdxdna/amdxdna_ctx.h b/drivers/accel/amdxdna/amdxdna_ctx.h
index b3677851d1c5..2e6b300d652f 100644
--- a/drivers/accel/amdxdna/amdxdna_ctx.h
+++ b/drivers/accel/amdxdna/amdxdna_ctx.h
@@ -157,6 +157,8 @@ union amdxdna_job_priv {
 	struct {
 		struct list_head	list;
 		u32			state;
+		u32			cmd_bo_cnt;
+		struct amdxdna_gem_obj	**cmd_bos;
 	} aie4;
 };
 
@@ -179,9 +181,11 @@ struct amdxdna_sched_job {
 	struct drm_gem_object	*bos[] __counted_by(bo_cnt);
 };
 
-#define aie2_job_health priv.aie2_health
+#define aie2_job_health	priv.aie2_health
 #define aie4_job_list	priv.aie4.list
 #define aie4_job_state	priv.aie4.state
+#define aie4_cmd_bo_cnt	priv.aie4.cmd_bo_cnt
+#define aie4_cmd_bos	priv.aie4.cmd_bos
 
 static inline u32
 amdxdna_cmd_get_op(struct amdxdna_gem_obj *abo)
diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.h b/drivers/accel/amdxdna/amdxdna_pci_drv.h
index 2a1d6b33363c..eccb461d32bc 100644
--- a/drivers/accel/amdxdna/amdxdna_pci_drv.h
+++ b/drivers/accel/amdxdna/amdxdna_pci_drv.h
@@ -59,6 +59,7 @@ struct amdxdna_dev_ops {
 	int (*suspend)(struct amdxdna_dev *xdna);
 	int (*sriov_configure)(struct amdxdna_dev *xdna, int num_vfs);
 	int (*hwctx_init)(struct amdxdna_hwctx *hwctx);
+	void (*hwctx_stop)(struct amdxdna_hwctx *hwctx);
 	void (*hwctx_fini)(struct amdxdna_hwctx *hwctx);
 	int (*hwctx_config)(struct amdxdna_hwctx *hwctx, u32 type, u64 value, void *buf, u32 size);
 	int (*hwctx_sync_debug_bo)(struct amdxdna_hwctx *hwctx, u32 debug_bo_hdl);
-- 
2.34.1

