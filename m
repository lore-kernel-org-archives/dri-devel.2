Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE0FC9830E
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 01:35:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4907010FD0D;
	Sat, 26 Sep 2026 01:35:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bkSNvXpa";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013039.outbound.protection.outlook.com
 [40.93.196.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACE4410FD00
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 01:35:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WVJ2xgTpoSJbHpyGcX0APcnbWuLTdPPB6sLdqnhSe06niFZczYhqRyNfLnBVB5SPNGgEua1uvDm+zo78dVFZMHSAjSgeEzXGsoL5ZfDcD/punQ2dQ64TxLvx1fp5JrgzebUkByyV3vvM/5wEFsnxBfk+dQV0gunvG1obHeXH62k65BnaitAGoF7/t42w8pRNWgx7+SDcWkdwstYlYJgeUQ03NdU0dUb2XsXeJNHGFuD5mXfUv5lWmYv6lisXdTmiS5+xXmcZoHwMT7+5WPyhcuSFDc37qCKM7UFMVv6GEeq6EPio1vS7wulVxGPwQy1PixeZWKzRLO921zMyx6YI9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nfyihi2ZXzbpa81Z4bcekk27XyIgb3bkavNSdXS/xxs=;
 b=EbWvy0EUz08j4AOojPKuehhXsaSLdcKPjqyG/gAUSOzfWQQA4PfYweajJGPx4h6SaBkQv80r6n2ukYV5EX5OAgc/VQA/j0JGwKpGQYjm9wnFrdWmhDGGqBlUDMKYdVygnyW8JsKSYQrUNc9IsUUgE2j4aGRenH414eIRS8SGs8ArXgiFEdXDWAqtLaLvAisoIFGrOrP7bUo9r8TB5ajSxTM134r6dbHuTT+R1N/SMhH+QDOOZow02fRV8UrruFq61ZEAIhymWpTlyTPYeQYvSBuq0ajNfF5DDYmHTimY/zGCASHYAGsuWX6oOu5hQdkM27WsShnehw1ipR2AnTCcRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nfyihi2ZXzbpa81Z4bcekk27XyIgb3bkavNSdXS/xxs=;
 b=bkSNvXpaARIdB42+QCFVzAJz1PRXS4Y3dUtyUuiPexNhMljuWwSJDp+3StNeFtSWpJIryl8gJuQO4Gn+90opyshIWLw2JEfz7akuxgPesdREaJFl13aLpKy5e2c4Gc1SZScugy0Hs0eeow0K4fLHWGPTI3YFDeNlGzOkUygxcls=
Received: from CH0PR13CA0028.namprd13.prod.outlook.com (2603:10b6:610:b1::33)
 by DM4PR12MB6304.namprd12.prod.outlook.com (2603:10b6:8:a2::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.22; Sat, 26 Sep 2026 01:35:30 +0000
Received: from BN5PEPF00046989.namprd02.prod.outlook.com
 (2603:10b6:610:b1:cafe::7) by CH0PR13CA0028.outlook.office365.com
 (2603:10b6:610:b1::33) with Microsoft SMTP Server (version=TLS1_3,
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
 15.21.451.8 via Frontend Transport; Sat, 26 Sep 2026 01:35:29 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 25 Sep
 2026 20:35:28 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 25 Sep
 2026 20:35:28 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Fri, 25 Sep 2026 20:35:27 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>, Wendy Liang <wendy.liang@amd.com>
Subject: [PATCH V0 13/21] accel/amdxdna: Implement AIE4 kernel queue lifecycle
 and memory layout
Date: Fri, 25 Sep 2026 18:34:40 -0700
Message-ID: <20260926013448.3840921-14-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260926013448.3840921-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20260926013448.3840921-1-yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PEPF00046989:EE_|DM4PR12MB6304:EE_
X-MS-Office365-Filtering-Correlation-Id: 91a1990c-f26e-4a5c-400a-08df1b6e7304
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|10067099003|4143699003|11063799006|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: qE7DhsUrBmyDAtEYAy2Uizg4Vzt2jONvinwt2ESh1xGvtmH8g1561QANxieQ4PoAN8ujdKWCm6kgDHHWKwcZsdorq7vRCzEUABzqDvos8FyXBWM4ogC02V/OIv+9V7XY5qqQRAoNq+Bm3deVJR2S+r50W0J7WTgRwaPaLQ5Uv4cdoQEPlaGbPpUTsMDZ4DFdZba9vd+PvR9m0Qn8OWV+9W2oWEO8dQe4UMNpdsG7PNKuLr35WaXY2K1HyMxxu94pjia5xkDnZPKe4oIWNszY/qii3FWSl5YLukmIk0G+1JZ/eivLOotvCI+bdO5TmBcKx5E5plXrgdOHVLLu5GR2vkVRoabvVZwpWxiBbTU7pevA1bi9h617y2auCMugsyUgsoN9b1CwhKXHNnOVrEY5NmS3lqGpxcnM3iqo5tnsSrNrbJQOwvQ+o7585GKiXmvA75PzTxbm7RQPOXzPeFqoDXZj0S92cQXhC22GKutmmKy21BmBhuItJdxNCw+8TpifeFHIjYSeI7dmKuIBbzdUB4LOLYhu8CK7SmWkm3NoIcnxs2Avqqx5jW7RsjjBRAyoCADVZjcTlzLZrqFjnCcRTNpq9faQjISGBhqCosNEWSPuIaCynxcPGOJpai7r8b+rhSRmlh245vsnoRHbrL8src8NqophCqVVrnrCeDhthtVKF+T3dZ1CUbjTMW+mV15oRpuD6lw7fRj4W0UwKZPcLg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(10067099003)(4143699003)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jfIGSoCgB6JJgx9TtCfm432FGVekoZy8ZiDbinHPtZWYQNBS1oirO3lRCe2ssPk0O3YVphabgSKTmKTCENmEDk3j3zUULEjEVOLX1x3BWOWEMOUkCyoRtv6VnerPqqlITnbdpNDcGnweCPBAagNp4csZlCOBhoLBkNbyTwcZ8UuO5loS1uN3+uN7KuAWXhz1LPct+kWNlo8UyYK9OMQsKuKyQBLcmuIqVZSKDV2SNxfUIsYl9w1Cfa2PpV1YsgYqASP4RlX0qBpt5yGop+0xKc+T7XPbP7CbzVncJL5km1VKm9DRvCX/qWVDnTt1kVdQdmfSZLWY2ZEP6tV0GTpObqOuEeJsLD7oWlE4NnKSfAD8cvRZVIkVPd7xVquS7nuslPG1bnmHwYUjUmu7VNSTdZQqIuVgojrdYQ1SQIn3LgQOEgbn3oBmlb6xkApxau4P
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2026 01:35:29.9485 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91a1990c-f26e-4a5c-400a-08df1b6e7304
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN5PEPF00046989.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6304
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

Initialize kernel-mode submission required buffers, workqueue, and
hardware contexts:
- Update queue definition that is being used to send requests.
- Add job workqueue for pending and running jobs.
- Add mutex protection for each io.
- Initialize queue with direct and indirect packet, format queue header.
- Add kernel-mode submission required steps in hwctx create/destroy.
- Add aie4_get_cert_comp() to safely acquire a reference to the
  per-hwctx completion tracker under io_lock in aie4_cmd_wait() before
  waiting on the queue, preventing race conditions with
  aie4_hwctx_destroy().

Also change aie4_lookup_cert_comp() to return ERR_PTR() instead of NULL
on failure so callers can distinguish error causes, drop the now-stale
drm_WARN_ON() lock assertion in cert_comp_release() (cert_comp_release()
no longer requires cert_comp_lock to be held by all callers), and add
enum aie4_hwctx_flags, a currently-unused flags parameter threaded
through aie4_hwctx_destroy() for use by later patches.

Co-developed-by: Max Zhen <max.zhen@amd.com>
Signed-off-by: Max Zhen <max.zhen@amd.com>
Co-developed-by: Wendy Liang <wendy.liang@amd.com>
Signed-off-by: Wendy Liang <wendy.liang@amd.com>
Signed-off-by: David Zhang <yidong.zhang@amd.com>
---
 drivers/accel/amdxdna/aie4_ctx.c        | 225 ++++++++++++++++++++----
 drivers/accel/amdxdna/aie4_host_queue.h |  65 +++++++
 drivers/accel/amdxdna/aie4_pci.h        |  54 ++++++
 3 files changed, 311 insertions(+), 33 deletions(-)

diff --git a/drivers/accel/amdxdna/aie4_ctx.c b/drivers/accel/amdxdna/aie4_ctx.c
index fba4ef25ffbe..af52a1ea45e8 100644
--- a/drivers/accel/amdxdna/aie4_ctx.c
+++ b/drivers/accel/amdxdna/aie4_ctx.c
@@ -21,6 +21,13 @@
 #include "amdxdna_mailbox_helper.h"
 #include "amdxdna_pci_drv.h"
 
+#define CTX_INVALID_ID			(~0U)
+#define CTX_INVALID_DOORBELL		AMDXDNA_INVALID_DOORBELL_OFFSET
+
+static void job_worker(struct work_struct *work)
+{
+}
+
 static struct cert_comp *aie4_lookup_cert_comp(struct amdxdna_dev_hdl *ndev, u32 msix_idx)
 {
 	struct amdxdna_dev *xdna = ndev->aie.xdna;
@@ -37,7 +44,7 @@ static struct cert_comp *aie4_lookup_cert_comp(struct amdxdna_dev_hdl *ndev, u32
 
 	cert_comp = kzalloc_obj(*cert_comp);
 	if (!cert_comp)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	cert_comp->ndev = ndev;
 	cert_comp->msix_idx = msix_idx;
@@ -64,7 +71,7 @@ static struct cert_comp *aie4_lookup_cert_comp(struct amdxdna_dev_hdl *ndev, u32
 	aie4_free_notification(cert_comp);
 free_cert_comp:
 	kfree(cert_comp);
-	return NULL;
+	return ERR_PTR(ret);
 }
 
 static void cert_comp_release(struct kref *kref)
@@ -72,8 +79,6 @@ static void cert_comp_release(struct kref *kref)
 	struct cert_comp *cert_comp = container_of(kref, struct cert_comp, kref);
 	struct amdxdna_dev_hdl *ndev = cert_comp->ndev;
 
-	drm_WARN_ON(&ndev->aie.xdna->ddev, !mutex_is_locked(&ndev->cert_comp_lock));
-
 	xa_erase(&ndev->cert_comp_xa, cert_comp->msix_idx);
 	aie4_free_notification(cert_comp);
 	kfree(cert_comp);
@@ -81,20 +86,42 @@ static void cert_comp_release(struct kref *kref)
 
 static void aie4_put_cert_comp(struct cert_comp *cert_comp)
 {
-	struct amdxdna_dev_hdl *ndev;
+	struct amdxdna_dev_hdl *ndev = cert_comp->ndev;
 
-	ndev = cert_comp->ndev;
 	guard(mutex)(&ndev->cert_comp_lock);
 
 	kref_put(&cert_comp->kref, cert_comp_release);
 }
 
-static int aie4_msg_destroy_context(struct amdxdna_dev_hdl *ndev, u32 hw_context_id)
+static struct cert_comp *aie4_get_cert_comp(struct amdxdna_hwctx *hwctx)
+{
+	struct amdxdna_hwctx_priv *priv = hwctx->priv;
+	struct cert_comp *cert_comp;
+
+	/*
+	 * priv->cert_comp is the per-hwctx field, guarded by io_lock. A non-NULL
+	 * value means this ctx still holds its link-ref, so the object is alive and
+	 * the kref_get here cannot race the free.
+	 */
+	guard(mutex)(&priv->io_lock);
+
+	cert_comp = READ_ONCE(priv->cert_comp);
+	if (cert_comp)
+		kref_get(&cert_comp->kref);
+
+	return cert_comp;
+}
+
+static void aie4_msg_destroy_context(struct amdxdna_dev_hdl *ndev, u32 hw_context_id)
 {
 	DECLARE_AIE_MSG(aie4_msg_destroy_hw_context, AIE4_MSG_OP_DESTROY_HW_CONTEXT);
+	struct amdxdna_dev *xdna = ndev->aie.xdna;
+	int ret;
 
 	req.hw_context_id = hw_context_id;
-	return aie_send_mgmt_msg_wait(&ndev->aie, &msg);
+	ret = aie_send_mgmt_msg_wait(&ndev->aie, &msg);
+	if (ret)
+		XDNA_WARN(xdna, "destroy ctx id %d failed %d", hw_context_id, ret);
 }
 
 static u8 aie4_parse_priority_to_dev(u32 priority)
@@ -113,19 +140,20 @@ static u8 aie4_parse_priority_to_dev(u32 priority)
 	}
 }
 
-static int aie4_hwctx_create(struct amdxdna_hwctx *hwctx)
+int aie4_hwctx_create(struct amdxdna_hwctx *hwctx)
 {
 	DECLARE_AIE_MSG(aie4_msg_create_hw_context, AIE4_MSG_OP_CREATE_HW_CONTEXT);
 	struct amdxdna_client *client = hwctx->client;
 	struct amdxdna_hwctx_priv *priv = hwctx->priv;
-	struct amdxdna_dev *xdna = hwctx->client->xdna;
+	struct amdxdna_dev *xdna = client->xdna;
 	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
+	struct cert_comp *cert_comp;
 	int ret;
 
 	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
 
 	if (!ndev->partition_id || !hwctx->num_tiles) {
-		XDNA_ERR(xdna, "invalid request partition_id %d, num_tiles %d",
+		XDNA_ERR(xdna, "invalid request partition_id %u, num_tiles %d",
 			 ndev->partition_id, hwctx->num_tiles);
 		return -EINVAL;
 	}
@@ -134,7 +162,6 @@ static int aie4_hwctx_create(struct amdxdna_hwctx *hwctx)
 	req.request_num_tiles = hwctx->num_tiles;
 	req.pasid = aie4_msg_pasid(client);
 	req.priority_band = aie4_parse_priority_to_dev(hwctx->qos.priority);
-
 	req.hsa_addr_high = upper_32_bits(amdxdna_gem_dev_addr(priv->umq_bo));
 	req.hsa_addr_low = lower_32_bits(amdxdna_gem_dev_addr(priv->umq_bo));
 
@@ -148,72 +175,166 @@ static int aie4_hwctx_create(struct amdxdna_hwctx *hwctx)
 	}
 
 	XDNA_DBG(xdna, "resp msix: %d, ctx id: %d, doorbell: %d",
-		 resp.job_complete_msix_idx,
-		 resp.hw_context_id,
+		 resp.job_complete_msix_idx, resp.hw_context_id,
 		 resp.doorbell_offset);
 
 	/* setup interrupt completion per msix index */
-	priv->cert_comp = aie4_lookup_cert_comp(ndev, resp.job_complete_msix_idx);
-	if (!priv->cert_comp) {
+	cert_comp = aie4_lookup_cert_comp(ndev, resp.job_complete_msix_idx);
+	if (IS_ERR(cert_comp)) {
 		aie4_msg_destroy_context(ndev, resp.hw_context_id);
-		return -EINVAL;
+		return PTR_ERR(cert_comp);
 	}
 
 	priv->hw_ctx_id = resp.hw_context_id;
-	hwctx->doorbell_offset = AMDXDNA_INVALID_DOORBELL_OFFSET;
+
+	hwctx->fw_ctx_id = resp.hw_context_id;
+	hwctx->start_col = 0;
+	hwctx->num_col = ndev->total_col;
+
+	/*
+	 * Kernel-mode submission: set up this context's doorbell kick target
+	 * (transport-specific, via aie4_doorbell_setup) so the driver can ring
+	 * it, and keep it out of user space (hand back an invalid offset so the
+	 * doorbell cannot be mmap'd/rung by the user).
+	 */
+	mutex_lock(&priv->io_lock);
+	ret = aie4_doorbell_setup(hwctx, &resp);
+	if (ret) {
+		mutex_unlock(&priv->io_lock);
+		aie4_put_cert_comp(cert_comp);
+		aie4_msg_destroy_context(ndev, resp.hw_context_id);
+		priv->hw_ctx_id = CTX_INVALID_ID;
+		hwctx->fw_ctx_id = -1;
+		return ret;
+	}
+	WRITE_ONCE(priv->cert_comp, cert_comp);
+	mutex_unlock(&priv->io_lock);
+	hwctx->doorbell_offset = CTX_INVALID_DOORBELL;
+	wake_up_all(&priv->job_list_wq);
 
 	return 0;
 }
 
-static void aie4_hwctx_destroy(struct amdxdna_hwctx *hwctx)
+void aie4_hwctx_destroy(struct amdxdna_hwctx *hwctx, enum aie4_hwctx_flags flags)
 {
 	struct amdxdna_client *client = hwctx->client;
 	struct amdxdna_hwctx_priv *priv = hwctx->priv;
 	struct amdxdna_dev *xdna = client->xdna;
 	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
+	struct cert_comp *cert_comp;
 
 	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
 
-	aie4_msg_destroy_context(ndev, priv->hw_ctx_id);
-	aie4_put_cert_comp(priv->cert_comp);
+	mutex_lock(&priv->io_lock);
+	cert_comp = priv->cert_comp;
+	WRITE_ONCE(priv->cert_comp, NULL);
+	mutex_unlock(&priv->io_lock);
+
+	if (cert_comp) {
+		wake_up_all(&cert_comp->waitq);
+		aie4_put_cert_comp(cert_comp);
+	}
+
+	if (flags != AIE4_HWCTX_DISCONNECT)
+		aie4_msg_destroy_context(ndev, priv->hw_ctx_id);
+
+	priv->hw_ctx_id = CTX_INVALID_ID;
+	hwctx->fw_ctx_id = -1;
+	hwctx->doorbell_offset = CTX_INVALID_DOORBELL;
+
+	cancel_work_sync(&priv->job_work);
 }
 
 static void aie4_hwctx_umq_fini(struct amdxdna_hwctx *hwctx)
 {
 	if (hwctx->priv && hwctx->priv->umq_bo)
-		amdxdna_gem_put_obj(hwctx->priv->umq_bo);
+		drm_gem_object_put(to_gobj(hwctx->priv->umq_bo));
 }
 
 static int aie4_hwctx_umq_init(struct amdxdna_hwctx *hwctx)
 {
+	const size_t indir_pkts_sz = CTX_MAX_CMDS * HSA_MAX_LEVEL1_INDIRECT_ENTRIES *
+				     sizeof(struct host_indirect_packet_data);
+	const size_t pkts_sz = CTX_MAX_CMDS * sizeof(struct host_queue_packet);
 	struct amdxdna_hwctx_priv *priv = hwctx->priv;
 	struct amdxdna_dev *xdna = hwctx->client->xdna;
 	struct amdxdna_gem_obj *umq_bo;
 	struct host_queue_header *qhdr;
+	u64 data_dev_addr;
+	void *umq_va;
 	int ret;
+	int i;
 
+	/*
+	 * The HSA queue lives in a user-allocated BO (umq_bo_hdl) in both user- and
+	 * kernel-mode submission; the driver does not allocate it privately. Under
+	 * PASID/SVA the device reaches the queue through the submitting process's
+	 * own page tables, so it must have a user virtual address - a kernel-private
+	 * buffer would be unreachable by the device.
+	 */
 	umq_bo = amdxdna_gem_get_obj(hwctx->client, hwctx->umq_bo_hdl, AMDXDNA_BO_SHARE);
 	if (!umq_bo) {
 		XDNA_ERR(xdna, "cannot find umq_bo handle %d", hwctx->umq_bo_hdl);
 		return -ENOENT;
 	}
-	if (umq_bo->mem.size < sizeof(*qhdr)) {
-		XDNA_ERR(xdna, "umq_bo size is too small");
+
+	/*
+	 * Kernel-mode submission: the driver fills the host queue and rings the
+	 * doorbell, so the user umq_bo must hold the header plus the direct and
+	 * level-1 indirect packet arrays.
+	 */
+	if (umq_bo->mem.size < sizeof(*qhdr) ||
+	    (umq_bo->mem.size < sizeof(*qhdr) + pkts_sz + indir_pkts_sz)) {
+		XDNA_ERR(xdna, "umq_bo size %zu is too small",
+			 (size_t)umq_bo->mem.size);
 		ret = -EINVAL;
 		goto put_umq_bo;
 	}
 
-	/* get kva address for host queue read index and write index */
-	qhdr = amdxdna_gem_vmap(umq_bo);
-	if (!qhdr) {
+	umq_va = amdxdna_gem_vmap(umq_bo);
+	if (!umq_va) {
 		ret = -ENOMEM;
 		goto put_umq_bo;
 	}
+	qhdr = umq_va;
 
 	priv->umq_bo = umq_bo;
 	priv->umq_read_index = &qhdr->read_index;
 	priv->umq_write_index = &qhdr->write_index;
 
+	/*
+	 * The queue content is driver-owned and never trusted from user space
+	 * (only read_index is read back to detect completion). Lay out the
+	 * direct packets right after the header and the indirect packets after
+	 * them, and publish the same base via data_address for CERT.
+	 */
+	data_dev_addr = amdxdna_gem_dev_addr(umq_bo) + sizeof(*qhdr);
+	priv->umq_pkts = umq_va + sizeof(*qhdr);
+	priv->umq_indirect_pkts = umq_va + sizeof(*qhdr) + pkts_sz;
+	priv->umq_indirect_pkts_dev_addr = data_dev_addr + pkts_sz;
+
+	/*
+	 * Only the header + direct/indirect packet regions are driver-owned and
+	 * used for kernel submission; the size check above guarantees they fit.
+	 * Clear just that range, not the whole user-sized BO, so an oversized
+	 * umq_bo cannot force a huge memset (and page faults) under dev_lock.
+	 */
+	memset(umq_va, 0, sizeof(*qhdr) + pkts_sz + indir_pkts_sz);
+	priv->write_index = QUEUE_INDEX_START;
+	qhdr->read_index = QUEUE_INDEX_START;
+	qhdr->write_index = QUEUE_INDEX_START;
+	qhdr->version.major = HOST_QUEUE_MAJOR_VERSION;
+	qhdr->version.minor = HOST_QUEUE_MINOR_VERSION;
+	qhdr->capacity = CTX_MAX_CMDS;
+	qhdr->data_address = data_dev_addr;
+	for (i = 0; i < CTX_MAX_CMDS; i++)
+		priv->umq_pkts[i].pkt_header.common_header.opcode = OPCODE_EXEC_BUF;
+	for (i = 0; i < CTX_MAX_CMDS * HSA_MAX_LEVEL1_INDIRECT_ENTRIES; i++) {
+		priv->umq_indirect_pkts[i].header.opcode = OPCODE_EXEC_BUF;
+		priv->umq_indirect_pkts[i].header.count = sizeof(struct exec_buf);
+		priv->umq_indirect_pkts[i].header.distribute = 1;
+	}
+
 	return 0;
 
 put_umq_bo:
@@ -225,28 +346,56 @@ int aie4_hwctx_init(struct amdxdna_hwctx *hwctx)
 {
 	struct amdxdna_client *client = hwctx->client;
 	struct amdxdna_dev *xdna = client->xdna;
+	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
 	struct amdxdna_hwctx_priv *priv;
 	int ret;
 
+	if (!AIE_FEATURE_ON(&ndev->aie, AIE4_HSA_COMMAND))
+		return -EOPNOTSUPP;
+
 	priv = kzalloc_obj(*priv);
 	if (!priv)
 		return -ENOMEM;
 	hwctx->priv = priv;
+	priv->hwctx = hwctx;
+
+	/*
+	 * io_lock guards the per-hwctx cert_comp binding (the connected sentinel)
+	 * for every ctx, so initialize it unconditionally.  kzalloc left cert_comp
+	 * NULL: disconnected until create links it.
+	 */
+	mutex_init(&priv->io_lock);
+
+	INIT_LIST_HEAD(&priv->pending_job_list);
+	INIT_LIST_HEAD(&priv->running_job_list);
+	init_waitqueue_head(&priv->job_list_wq);
+	INIT_WORK(&priv->job_work, job_worker);
 
 	ret = aie4_hwctx_umq_init(hwctx);
 	if (ret)
-		goto free_priv;
+		goto destroy_lock;
 
 	ret = aie4_hwctx_create(hwctx);
 	if (ret)
 		goto umq_fini;
 
-	XDNA_DBG(xdna, "hwctx %s init completed", hwctx->name);
+	priv->job_work_q = alloc_ordered_workqueue("aie4_job_%d_%d", 0,
+						   client->pid, hwctx->fw_ctx_id);
+	if (!priv->job_work_q) {
+		XDNA_ERR(xdna, "Create job_work_q failed");
+		ret = -ENOMEM;
+		goto destroy_ctx;
+	}
+
+	XDNA_DBG(xdna, "hwctx %d.%d init completed", client->pid, hwctx->fw_ctx_id);
 	return 0;
 
+destroy_ctx:
+	aie4_hwctx_destroy(hwctx, AIE4_HWCTX_NORMAL);
 umq_fini:
 	aie4_hwctx_umq_fini(hwctx);
-free_priv:
+destroy_lock:
+	mutex_destroy(&priv->io_lock);
 	kfree(priv);
 	hwctx->priv = NULL;
 	return ret;
@@ -254,8 +403,14 @@ int aie4_hwctx_init(struct amdxdna_hwctx *hwctx)
 
 void aie4_hwctx_fini(struct amdxdna_hwctx *hwctx)
 {
-	aie4_hwctx_destroy(hwctx);
+	struct amdxdna_hwctx_priv *priv = hwctx->priv;
+
+	aie4_hwctx_destroy(hwctx, AIE4_HWCTX_ERROR);
+	cancel_work_sync(&priv->job_work);
+	if (priv->job_work_q)
+		destroy_workqueue(priv->job_work_q);
 	aie4_hwctx_umq_fini(hwctx);
+	mutex_destroy(&priv->io_lock);
 	kfree(hwctx->priv);
 }
 
@@ -299,10 +454,12 @@ static inline bool check_cmd_done(struct amdxdna_hwctx *hwctx, u64 seq)
 int aie4_cmd_wait(struct amdxdna_hwctx *hwctx, u64 seq, u32 timeout)
 {
 	unsigned long wait_jifs = MAX_SCHEDULE_TIMEOUT;
-	struct amdxdna_hwctx_priv *priv = hwctx->priv;
-	struct cert_comp *cert_comp = priv->cert_comp;
+	struct cert_comp *cert_comp = aie4_get_cert_comp(hwctx);
 	long ret;
 
+	if (!cert_comp)
+		return -EAGAIN;
+
 	if (timeout)
 		wait_jifs = msecs_to_jiffies(timeout);
 
@@ -313,5 +470,7 @@ int aie4_cmd_wait(struct amdxdna_hwctx *hwctx, u64 seq, u32 timeout)
 	if (!ret)
 		ret = -ETIME;
 
+	aie4_put_cert_comp(cert_comp);
+
 	return ret <= 0 ? ret : 0;
 }
diff --git a/drivers/accel/amdxdna/aie4_host_queue.h b/drivers/accel/amdxdna/aie4_host_queue.h
index 97e535939b32..6876811b05f2 100644
--- a/drivers/accel/amdxdna/aie4_host_queue.h
+++ b/drivers/accel/amdxdna/aie4_host_queue.h
@@ -6,9 +6,14 @@
 #ifndef _AIE4_HOST_QUEUE_H_
 #define _AIE4_HOST_QUEUE_H_
 
+#include <linux/bits.h>
 #include <linux/types.h>
 
 #define CTX_MAX_CMDS                    32
+#define HSA_MAX_LEVEL1_INDIRECT_ENTRIES	6
+#define QUEUE_INDEX_START		0
+#define HOST_QUEUE_MAJOR_VERSION	1
+#define HOST_QUEUE_MINOR_VERSION	0
 
 /*
  * Host queue header layout.
@@ -31,4 +36,64 @@ struct host_queue_header {
 	__u64 data_address; /* The xdna dev addr for payload. */
 } __packed;
 
+/* Payload for an OPCODE_EXEC_BUF host-queue packet (single command). */
+struct exec_buf {
+	u32 dtrace_buf_host_addr_low;
+	u32 dpu_control_code_host_addr_low;
+	u32 dpu_control_code_host_addr_high;
+	u16 args_len;
+	u16 dtrace_buf_host_addr_high;
+	u32 args_host_addr_low;
+	u32 args_host_addr_high;
+} __packed;
+
+#define OPCODE_EXEC_BUF		1
+#define CHAIN_FLG_LAST_CMD	0
+#define CHAIN_FLG_NOT_LAST_CMD	1
+struct common_header {
+	u16 reserved; /* MBZ. */
+	u8 opcode;
+	u8 chain_flag;
+	u16 count;
+	u8 distribute;
+	u8 indirect;
+} __packed;
+
+struct host_queue_packet_header {
+	struct common_header common_header;
+	u64 completion_signal;
+} __packed;
+
+struct host_queue_packet {
+	struct host_queue_packet_header pkt_header;
+	u32 data[12]; /* total 64-byte packet */
+} __packed;
+
+struct host_indirect_packet_entry {
+	u32 host_addr_low;
+	u32 host_addr_high_uc_index;
+} __packed;
+
+#define HIPE_HOST_ADDR_HIGH_SHIFT	0
+#define HIPE_HOST_ADDR_HIGH_MASK	GENMASK(24, 0)
+#define HIPE_UC_INDEX_SHIFT		25
+#define HIPE_UC_INDEX_MASK		GENMASK(31, 25)
+
+static inline void hipe_set_host_addr_high(u32 *val, u32 addr_hi)
+{
+	*val &= ~HIPE_HOST_ADDR_HIGH_MASK;
+	*val |= (addr_hi << HIPE_HOST_ADDR_HIGH_SHIFT) & HIPE_HOST_ADDR_HIGH_MASK;
+}
+
+static inline void hipe_set_uc_index(u32 *val, u32 uc_idx)
+{
+	*val &= ~HIPE_UC_INDEX_MASK;
+	*val |= (uc_idx << HIPE_UC_INDEX_SHIFT) & HIPE_UC_INDEX_MASK;
+}
+
+struct host_indirect_packet_data {
+	struct common_header header;
+	struct exec_buf payload;
+} __packed;
+
 #endif /* _AIE4_HOST_QUEUE_H_ */
diff --git a/drivers/accel/amdxdna/aie4_pci.h b/drivers/accel/amdxdna/aie4_pci.h
index c6e7f6a80f69..f549d9e69d41 100644
--- a/drivers/accel/amdxdna/aie4_pci.h
+++ b/drivers/accel/amdxdna/aie4_pci.h
@@ -8,7 +8,10 @@
 
 #include <linux/device.h>
 #include <linux/iopoll.h>
+#include <linux/list.h>
 #include <linux/pci.h>
+#include <linux/wait.h>
+#include <linux/workqueue.h>
 
 #include "aie.h"
 #include "aie4_msg_priv.h"
@@ -25,15 +28,57 @@ struct cert_comp {
 	wait_queue_head_t               waitq;
 };
 
+/*
+ * aie4 kernel-submission job states (stored in amdxdna_sched_job priv.aie4.state).
+ * Anonymous enum - the aie4_job_state identifier is already a field-access macro.
+ */
+enum {
+	AIE4_JOB_STATE_INIT,
+	AIE4_JOB_STATE_PENDING,
+	AIE4_JOB_STATE_SUBMITTING,
+	AIE4_JOB_STATE_SUBMITTED,
+	AIE4_JOB_STATE_DONE,
+};
+
 struct amdxdna_hwctx_priv {
+	struct amdxdna_hwctx		*hwctx;
 	struct amdxdna_gem_obj          *umq_bo;
 	u64                             *umq_read_index;
 	u64                             *umq_write_index;
+	/* Last valid read_index, returned when a sampled index looks invalid. */
+	u64                             last_read_index;
 
 	struct cert_comp                *cert_comp;
 	u32                             hw_ctx_id;
 
+	/* Kernel-mode submission: driver fills the user HSA queue and rings
+	 * the doorbell.  umq_pkts/umq_indirect_pkts alias the user umq_bo;
+	 * their content is driver-owned, only read_index is trusted from the
+	 * shared queue.
+	 */
+	u64                             write_index;
+	struct host_queue_packet        *umq_pkts;
+	struct host_indirect_packet_data *umq_indirect_pkts;
+	u64                             umq_indirect_pkts_dev_addr;
+	/*
+	 * Transport-private doorbell kick target.  On PCI this is doorbell_base +
+	 * doorbell_off + firmware offset, set by aie4_doorbell_setup() and
+	 * dereferenced only by aie4_doorbell_ring() in aie4_pci.c.  Never touched
+	 * by aie4_ctx.c (unused on the platform build).  Gated by the cert_comp
+	 * connected sentinel, so it needs no INVALID poison.
+	 */
 	void                    __iomem *doorbell_addr;
+
+	struct mutex                    io_lock; /* serialize submit, protect job lists */
+	struct list_head                pending_job_list;
+	/* Head of pending_job_list, updated under io_lock; read locklessly by the
+	 * submit wait condition so it never takes a lock inside wait_event().
+	 */
+	struct amdxdna_sched_job        *pending_head;
+	struct list_head                running_job_list;
+	wait_queue_head_t               job_list_wq;
+	struct work_struct              job_work;
+	struct workqueue_struct         *job_work_q;
 };
 
 struct amdxdna_dev_priv {
@@ -110,9 +155,18 @@ int aie4_set_ctx_hysteresis(struct amdxdna_dev_hdl *ndev, u32 timeout_us);
 u32 aie4_msg_pasid(struct amdxdna_client *client);
 
 /* aie4_ctx.c */
+enum aie4_hwctx_flags {
+	AIE4_HWCTX_NORMAL = 0,
+	AIE4_HWCTX_GRACEFUL,
+	AIE4_HWCTX_DISCONNECT, /* sets has_reset, do not destroy context */
+	AIE4_HWCTX_ERROR, /* sets has_reset, destroy context */
+};
+
 int aie4_hwctx_init(struct amdxdna_hwctx *hwctx);
 void aie4_hwctx_fini(struct amdxdna_hwctx *hwctx);
 int aie4_cmd_wait(struct amdxdna_hwctx *hwctx, u64 seq, u32 timeout);
+int aie4_hwctx_create(struct amdxdna_hwctx *hwctx);
+void aie4_hwctx_destroy(struct amdxdna_hwctx *hwctx, enum aie4_hwctx_flags);
 
 /* aie4_pci.c */
 int aie4_restore_power_mode(struct amdxdna_dev_hdl *ndev);
-- 
2.34.1

