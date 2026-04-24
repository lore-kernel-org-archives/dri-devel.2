Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B5D3FAD41C
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 04:08:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79D6B10E524;
	Fri, 24 Apr 2026 04:08:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W2o8FRa6";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010015.outbound.protection.outlook.com
 [40.93.198.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB10010E26E
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 04:08:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qLIg3xNca6aoV/XRkr9q7xXAz4LNVa8mCnQJ0oE6XKfy/cXy6hjDTGf+YujxUDGBXBxmC4SE9p3idt6bo0Tjr2vUiMb6bVUmrCSNbMd9K24GevklygWyD/AheJRsW0nmFCPWFcCyogva0xp7rSkOw+Pume1PGNYLUdAWh398YjUDFHCvhIoefYiGb61jsXDKtcSIKJ5j3J54WrG9OLsF+27Y8Xae7nvGXTTQ/HSV1qI2PtjehADeLEZA3UnhEVYqi69OblMXq8VUYI35Uy73n4tX6mJocaz2KnG+OS6h1cybMDRPHF0hxW9jQKNN/DO9hJLFJErO74ogTtf6IX9AEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NrH2m+AUTVRoF4ny442YqLJhKz27H7evTmVkbGcQRAk=;
 b=f8F22krmdJhVUD7tSwjAkVkRMzdLyUcidTYMlhAM4kEE01R0R8ckFiWFqDliO9+SZLW9sNIf2OxSWRVMX5ODbVxHDBMsjcmxcAoS/V9HlSohy414YCSsWQHkvI3szp8U5+qYNzZdLp7cILgWOMUeuzP5Ls1oOzCHJK/xXN9bKBrQVALnFMwzMsbqGQ93M8dIzldZ1aOb95iTwR7xovEzpsPqacoz/jtIl9QUt8oV+xuOk5Yq/z/AjAbdm87x9dBrDzsyTgheq/TT5TbdH/yxejh8INRZkgW5YCokwiU/GIYVw/vljT9dEk+i89nw2jVgIqrAuu/EK1qXAaQ9B7Y9MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NrH2m+AUTVRoF4ny442YqLJhKz27H7evTmVkbGcQRAk=;
 b=W2o8FRa6CvUnmJxRHL9wHitJ2ZyzYB6KCfp2m4ooEDKJb0tniY/s69i8KtizLDRNwz2UN8135OdfiUwZtiQRrjTJAYiZWtFtP/g+CPkaAfBKoxBC/ylfAzh29pb9q3+zRrjyganVuq0c88tIaaLchUrvIRwhilnTyHn+yDz+a3k=
Received: from BN9PR03CA0332.namprd03.prod.outlook.com (2603:10b6:408:f6::7)
 by CYYPR12MB8961.namprd12.prod.outlook.com (2603:10b6:930:bf::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Fri, 24 Apr
 2026 04:08:32 +0000
Received: from BN1PEPF00004682.namprd03.prod.outlook.com
 (2603:10b6:408:f6:cafe::52) by BN9PR03CA0332.outlook.office365.com
 (2603:10b6:408:f6::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Fri,
 24 Apr 2026 04:08:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00004682.mail.protection.outlook.com (10.167.243.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Fri, 24 Apr 2026 04:08:32 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 23 Apr
 2026 23:08:32 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 23 Apr
 2026 23:08:32 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 23 Apr 2026 23:08:31 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <maciej.falkowski@linux.intel.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <max.zhen@amd.com>, <sonal.santan@amd.com>
Subject: [PATCH V1 1/3] accel/amdxdna: Set default DPM level based on QoS for
 temporal-only mode
Date: Thu, 23 Apr 2026 21:08:22 -0700
Message-ID: <20260424040824.2253607-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004682:EE_|CYYPR12MB8961:EE_
X-MS-Office365-Filtering-Correlation-Id: a489258f-9d5e-42c2-d49c-08dea1b72658
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: PAX07X6WCRpIgKoaWpL4m7eMVlrxJabIkp3ac6S0r042Axmkl5b7HU7pJKcIQ7GEv0ZMxs06+ga6EpkFxpKPStQZNAXLahUbBQmzaDqMWr0wWAdJf5OK3+MNQZYHAtsYQZY7OXnKRS/mI7Xiu+U5h6Aq69K/1+zDYeMU+DJ1HzAWSBPr+TRzVlnodiW0UfjqtzMIYEa4n/gxjIXmyRx1KNH/77LyspBKwbYBnsSYYAK1KwsLRDgp2a2o8OaPGHVIuquTjTteWKX9Fc5I+IKdpUy9kXzWTPkOR5/1JRX23e1AZBa3+XuOd7+dk9E4aAcFMWA1UFWKCO6GO7ZnjGj6YVHPN+P9HnnFsz0rZ2SXyKSlF2JqVQeTwyuVo0G75IWRN02Xi5KPzd4BYKOj02R8UazJyDQ6Gl3L0rDlSamSUINwxsMMjCXSsyUPZmHL7Z4BFx7vca4HSwRM+XLGLt4OZOLgdiZjdOwCkM02K8DaCixC6318VFHXED8lSSJAXo+vJHxyEC/0/W95xbwBxz2O2kDPTF+nU0odWGgN5PUZ4D1WP01V99uB31shMDxa1paT0il6a1R8EIn8CUMnBFj8F0ZgX9MkYXwdx/CI5o2v5uRI8XvBh8NmSPCXGgxez+KXuoXjRpK9b7urxWOJP+1JALPo27EwE75PFWNFbfZgPxVi1+yb6EZfXOrEQ8aomBAfZruQr2ebnxAthP5Zx46MONRH96zj9Qjc7qq5y1AVZIbnucWHD0PgPcmk6SG4gbRzw2DR6cI5ysGYCPXPfqiY3w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cIbfa/YEUwJjgplAIXKgI5bAzfzm6jAw6bQ3gN+d2vgdlmWT1bYP17GNljWSp3nagHyFFJ/5LUbmhpRvCx/frem6Ia+K4hM81Wo/2BOArxhUKVrKTdNtKYZraBzwa+3tCe4tjNnPRLeBpnHHXJwfxFQvi2dsgsPqqPcutQAgUvR+vkYp36p90gTap8uBcSxZ9aaLA2zyHsKIOtNNCkVpIoAef0m4KFPsZ65q4y1CKdf57EhZQhZCsIOkOSbTCkHwcAMwHfY3w9unkp05oPVG1mR5NTKwU/ZZxdmHgezLjRrTNVXwbvNc+U4GsPTFOE2byLbjzjRAEsN8CIZJ4yMfwnUhAX1p9GoGTbSjlcUMp66QITMgRZDJgmXZftnc6FVWa3cIlq9u5kcS8xjEfRrELhnX6HlyVqW2DaCO2kUo5/wg7+AVbVjVViQus7sF9vSz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 04:08:32.7219 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a489258f-9d5e-42c2-d49c-08dea1b72658
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004682.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8961
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

The QoS request provided when creating a hardware context is currently
ignored when operating in temporal-only mode. Change this to use resource
allocation through xrs_allocate_resource(), which sets the default DPM
level according to the QoS request.

When multiple hardware contexts are active, track their required DPM
levels and set the default DPM level to the highest among them.

Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/aie2_ctx.c    | 34 +++++++++++++----------------
 drivers/accel/amdxdna/aie2_pci.c    |  1 +
 drivers/accel/amdxdna/aie2_pci.h    |  1 +
 drivers/accel/amdxdna/aie2_pm.c     |  2 +-
 drivers/accel/amdxdna/aie2_solver.c | 10 ++++++++-
 drivers/accel/amdxdna/npu1_regs.c   |  1 +
 drivers/accel/amdxdna/npu4_regs.c   |  1 +
 drivers/accel/amdxdna/npu5_regs.c   |  1 +
 drivers/accel/amdxdna/npu6_regs.c   |  1 +
 9 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
index d37123d925b6..0261f7f26236 100644
--- a/drivers/accel/amdxdna/aie2_ctx.c
+++ b/drivers/accel/amdxdna/aie2_ctx.c
@@ -540,22 +540,24 @@ static int aie2_alloc_resource(struct amdxdna_hwctx *hwctx)
 {
 	struct amdxdna_dev *xdna = hwctx->client->xdna;
 	struct alloc_requests *xrs_req;
+	u32 temporal_only_col = 0;
 	int ret;
 
-	if (AIE_FEATURE_ON(&xdna->dev_handle->aie, AIE2_TEMPORAL_ONLY)) {
-		hwctx->num_unused_col = xdna->dev_handle->total_col - hwctx->num_col;
-		hwctx->num_col = xdna->dev_handle->total_col;
-		return aie2_create_context(xdna->dev_handle, hwctx);
-	}
-
 	xrs_req = kzalloc_obj(*xrs_req);
 	if (!xrs_req)
 		return -ENOMEM;
 
-	xrs_req->cdo.start_cols = hwctx->col_list;
-	xrs_req->cdo.cols_len = hwctx->col_list_len;
-	xrs_req->cdo.ncols = hwctx->num_col;
-	xrs_req->cdo.qos_cap.opc = hwctx->max_opc;
+	if (AIE_FEATURE_ON(&xdna->dev_handle->aie, AIE2_TEMPORAL_ONLY)) {
+		xrs_req->cdo.start_cols = &temporal_only_col;
+		xrs_req->cdo.cols_len = 1;
+		xrs_req->cdo.ncols = xdna->dev_handle->total_col;
+	} else {
+		xrs_req->cdo.start_cols = hwctx->col_list;
+		xrs_req->cdo.cols_len = hwctx->col_list_len;
+		xrs_req->cdo.ncols = hwctx->num_col;
+	}
+	/* Use platform opc */
+	xrs_req->cdo.qos_cap.opc = xdna->dev_handle->priv->col_opc * hwctx->num_col;
 
 	xrs_req->rqos.gops = hwctx->qos.gops;
 	xrs_req->rqos.fps = hwctx->qos.fps;
@@ -579,15 +581,9 @@ static void aie2_release_resource(struct amdxdna_hwctx *hwctx)
 	struct amdxdna_dev *xdna = hwctx->client->xdna;
 	int ret;
 
-	if (AIE_FEATURE_ON(&xdna->dev_handle->aie, AIE2_TEMPORAL_ONLY)) {
-		ret = aie2_destroy_context(xdna->dev_handle, hwctx);
-		if (ret && ret != -ENODEV)
-			XDNA_ERR(xdna, "Destroy temporal only context failed, ret %d", ret);
-	} else {
-		ret = xrs_release_resource(xdna->xrs_hdl, (uintptr_t)hwctx);
-		if (ret)
-			XDNA_ERR(xdna, "Release AIE resource failed, ret %d", ret);
-	}
+	ret = xrs_release_resource(xdna->xrs_hdl, (uintptr_t)hwctx);
+	if (ret)
+		XDNA_ERR(xdna, "Release AIE resource failed, ret %d", ret);
 }
 
 static int aie2_ctx_syncobj_create(struct amdxdna_hwctx *hwctx)
diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
index 1d1fb012294a..a07e453a1721 100644
--- a/drivers/accel/amdxdna/aie2_pci.c
+++ b/drivers/accel/amdxdna/aie2_pci.c
@@ -246,6 +246,7 @@ static int aie2_xrs_load(void *cb_arg, struct xrs_action_load *action)
 	xdna = hwctx->client->xdna;
 
 	hwctx->start_col = action->part.start_col;
+	hwctx->num_unused_col = action->part.ncols - hwctx->num_col;
 	hwctx->num_col = action->part.ncols;
 	ret = aie2_create_context(xdna->dev_handle, hwctx);
 	if (ret)
diff --git a/drivers/accel/amdxdna/aie2_pci.h b/drivers/accel/amdxdna/aie2_pci.h
index c44616065058..f12073175676 100644
--- a/drivers/accel/amdxdna/aie2_pci.h
+++ b/drivers/accel/amdxdna/aie2_pci.h
@@ -237,6 +237,7 @@ struct amdxdna_dev_priv {
 #define COL_ALIGN_NONE   0
 #define COL_ALIGN_NATURE 1
 	u32				col_align;
+	u32				col_opc;
 	u32				mbox_dev_addr;
 	/* If mbox_size is 0, use BAR size. See MBOX_SIZE macro */
 	u32				mbox_size;
diff --git a/drivers/accel/amdxdna/aie2_pm.c b/drivers/accel/amdxdna/aie2_pm.c
index 786d688bd82c..d9ccd7fc8a6d 100644
--- a/drivers/accel/amdxdna/aie2_pm.c
+++ b/drivers/accel/amdxdna/aie2_pm.c
@@ -74,7 +74,7 @@ int aie2_pm_init(struct amdxdna_dev_hdl *ndev)
 		return ret;
 
 	ndev->pw_mode = POWER_MODE_DEFAULT;
-	ndev->dft_dpm_level = ndev->max_dpm_level;
+	ndev->dft_dpm_level = 0;
 
 	return 0;
 }
diff --git a/drivers/accel/amdxdna/aie2_solver.c b/drivers/accel/amdxdna/aie2_solver.c
index 3611e3268d79..6f3ee77d5264 100644
--- a/drivers/accel/amdxdna/aie2_solver.c
+++ b/drivers/accel/amdxdna/aie2_solver.c
@@ -52,7 +52,7 @@ static u32 calculate_gops(struct aie_qos *rqos)
 	u32 service_rate = 0;
 
 	if (rqos->latency)
-		service_rate = (1000 / rqos->latency);
+		service_rate = max_t(u32, 1000 / rqos->latency, 1);
 
 	if (rqos->fps > service_rate)
 		return rqos->fps * rqos->gops;
@@ -348,6 +348,7 @@ int xrs_release_resource(void *hdl, u64 rid)
 {
 	struct solver_state *xrs = hdl;
 	struct solver_node *node;
+	u32 level = 0;
 
 	node = rg_search_node(&xrs->rgp, rid);
 	if (!node) {
@@ -358,6 +359,13 @@ int xrs_release_resource(void *hdl, u64 rid)
 	xrs->cfg.actions->unload(node->cb_arg);
 	remove_solver_node(&xrs->rgp, node);
 
+	/* set the dpm level which fits all the sessions */
+	list_for_each_entry(node, &xrs->rgp.node_list, list) {
+		if (node->dpm_level > level)
+			level = node->dpm_level;
+	}
+	xrs->cfg.actions->set_dft_dpm_level(xrs->cfg.ddev, level);
+
 	return 0;
 }
 
diff --git a/drivers/accel/amdxdna/npu1_regs.c b/drivers/accel/amdxdna/npu1_regs.c
index d7e50c6b06ef..4e48c030a69f 100644
--- a/drivers/accel/amdxdna/npu1_regs.c
+++ b/drivers/accel/amdxdna/npu1_regs.c
@@ -97,6 +97,7 @@ static const struct amdxdna_dev_priv npu1_dev_priv = {
 	.rt_config	= npu1_default_rt_cfg,
 	.dpm_clk_tbl	= npu1_dpm_clk_table,
 	.col_align	= COL_ALIGN_NONE,
+	.col_opc	= 2048,
 	.mbox_dev_addr  = NPU1_MBOX_BAR_BASE,
 	.mbox_size      = 0, /* Use BAR size */
 	.sram_dev_addr  = NPU1_SRAM_BAR_BASE,
diff --git a/drivers/accel/amdxdna/npu4_regs.c b/drivers/accel/amdxdna/npu4_regs.c
index 935999ced70f..eddc31803a50 100644
--- a/drivers/accel/amdxdna/npu4_regs.c
+++ b/drivers/accel/amdxdna/npu4_regs.c
@@ -160,6 +160,7 @@ static const struct amdxdna_dev_priv npu4_dev_priv = {
 	.rt_config	= npu4_default_rt_cfg,
 	.dpm_clk_tbl	= npu4_dpm_clk_table,
 	.col_align	= COL_ALIGN_NATURE,
+	.col_opc	= 4096,
 	.mbox_dev_addr  = NPU4_MBOX_BAR_BASE,
 	.mbox_size      = 0, /* Use BAR size */
 	.sram_dev_addr  = NPU4_SRAM_BAR_BASE,
diff --git a/drivers/accel/amdxdna/npu5_regs.c b/drivers/accel/amdxdna/npu5_regs.c
index 795bd1996845..a9102978e4a8 100644
--- a/drivers/accel/amdxdna/npu5_regs.c
+++ b/drivers/accel/amdxdna/npu5_regs.c
@@ -67,6 +67,7 @@ static const struct amdxdna_dev_priv npu5_dev_priv = {
 	.rt_config	= npu4_default_rt_cfg,
 	.dpm_clk_tbl	= npu4_dpm_clk_table,
 	.col_align	= COL_ALIGN_NATURE,
+	.col_opc	= 4096,
 	.mbox_dev_addr  = NPU5_MBOX_BAR_BASE,
 	.mbox_size      = 0, /* Use BAR size */
 	.sram_dev_addr  = NPU5_SRAM_BAR_BASE,
diff --git a/drivers/accel/amdxdna/npu6_regs.c b/drivers/accel/amdxdna/npu6_regs.c
index 3125d1ce45ab..e0db3a09740b 100644
--- a/drivers/accel/amdxdna/npu6_regs.c
+++ b/drivers/accel/amdxdna/npu6_regs.c
@@ -67,6 +67,7 @@ static const struct amdxdna_dev_priv npu6_dev_priv = {
 	.rt_config	= npu4_default_rt_cfg,
 	.dpm_clk_tbl	= npu4_dpm_clk_table,
 	.col_align	= COL_ALIGN_NATURE,
+	.col_opc	= 4096,
 	.mbox_dev_addr  = NPU6_MBOX_BAR_BASE,
 	.mbox_size      = 0, /* Use BAR size */
 	.sram_dev_addr  = NPU6_SRAM_BAR_BASE,
-- 
2.34.1

