Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D94CC98312
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 20:05:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C76510E99D;
	Wed, 23 Sep 2026 20:05:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lW7RYjZS";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013052.outbound.protection.outlook.com
 [40.93.201.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0568610E99D
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 20:05:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OD3jYXerS2209BAdm/3cvbdSznHV/fjFbXkzhLSqyc/auhqNrHlbDUQ7juK7ikvY2CfLcBCx4YvNVPNqr9KW3+U7syBdmhco+IMaixXGRny1o6Pb6vjZLh0ost4ezbQpM3nTwMSZ++MOaf9QmMFHmOgA/1CrZ/Oy26Ma0/3VkOuSHgICQoF7iZVvtkYf6pXWIB5GTurrK9K7z27D7lVx+TrCCmd3S9eOAUhCZgOmY0Uyj+/alGQ/g3jKQRLYMM0B+PW62h0QKXRbwGR6H0YdListZka7owsnu3KUezlDafReiL52PEkfvwBywagQCnnzHNA2KIvJFGILZTvZEByZxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+pCl3tFKxoWh73jWSCDk0U/TyXpWH72QGSRj49w9svs=;
 b=XngmcAYZZKnJEsl3siIRzdPIie4PgBx34tioqrtDBLmdtZrrHbjibxIE5Xlt5EEK6yiRBUeWuvv+U9PPUnTttqY6dJAOuC4atY9X8W9OR0kzWQVe5O3gl4Wh6Wp3FOGrwrO0u5hNDmM6M3oQAomqO8sTwrgF9HdWpbnTt5FfymNettrKpZOdUKcxBo5cNiRymHs4bF0J9NAf2lVEsNP+YASD/c94lFTZUWidVK9m2szemvTVwLCZj/+GTuHxX5+b1CqRuTogxsuGJXuzK0UAOT2Hfcqm1P0jxIqpyOEgp59WGDKusXEFQ307VsjoJWSbpewycbudeuhHfchSsbHAHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+pCl3tFKxoWh73jWSCDk0U/TyXpWH72QGSRj49w9svs=;
 b=lW7RYjZS/gVZPSURTv4t0mqPW3W9ruFVII6tHFvvXfsI//2pOIIHO9d1H6wSBt1GssUoYtBEIxTQyyMNcPKABbgCkbK3v45Ujv/XxZtD35FkkyoaLKcvlmOPmsyuCBNzuhkAwwhmVhwpUF/SvcoBx9DIrpJidMAgVBxJOGxiHtY=
Received: from SJ0PR03CA0141.namprd03.prod.outlook.com (2603:10b6:a03:33c::26)
 by MN0PR12MB6053.namprd12.prod.outlook.com (2603:10b6:208:3cf::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 20:05:13 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::1e) by SJ0PR03CA0141.outlook.office365.com
 (2603:10b6:a03:33c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Wed, 23
 Sep 2026 20:05:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 20:05:13 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 15:05:12 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 23 Sep 2026 15:05:12 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>, <max.zhen@amd.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <sonal.santan@amd.com>, Jonghyuk Kim <malhyuk97@gmail.com>
Subject: [PATCH V1] accel/amdxdna: Preallocate hardware context schedulers
Date: Wed, 23 Sep 2026 13:05:01 -0700
Message-ID: <20260923200501.281208-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|MN0PR12MB6053:EE_
X-MS-Office365-Filtering-Correlation-Id: 34b2ca8d-d88f-4421-c752-08df19adfa9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|13003099007|6133799003|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: zPjz7Prp4SvWFe2SHaVXdMa63SmTotnguxROBeeNJuRjGqRWf8vMvX1xHAI41iX/dazMqHseFy5EvtZIJsQ7lXnvydR9+beHCbMj8wTtO8NDxG3h/8WAPB4XZWiAKTKf6q0S8i5WH66X4L4p56N3TOUdM1XZ/zPZ1QYyLWqwEWQSrd2bLXlDzVNJbyJgZrrkC99/mO39C/ngcAqw17ESEbhlJzyazmgQOyA4NB9U3upGxkATc4pM1vwmzywBOu+Q1lUnazBes049OY1xk7AiQsW7hVYybw886yFEfmJIu7ubyFGHvBwp+n4Jf1J2CoM2PDQbjMHHneAN0rglpfdJx9SWHlSxSKcdHiGf357QC5TRgvSQ2SvSzXi3VvxDjy9JjHxwAQnhDdiNLusDRf4vxrVkxCDNh0cNTZbs620LiXCcJ+t4JnVe8qB6Ccve7XagujYE10hskgbFx5mSbjRho0WCOWh2+6fOojBVsg1Vs1H2wrjbkpWZ6abz00y4lA4j4pL0DSKAf3Iro9vxL1b4KuzS94gDNwJ39aHxPvJNm3MF6laBs6inwY+M3WoESW1jgheVCdiqDC4ON5xDfDQhBsNN9bQfajug2PczWv38Nvr/hfmhRXxy0wvpSCX0v4WPVlpSEvh5WwWfbfXz8O208SXoKo/ASgXnja8xGeQuhOg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(13003099007)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hs2ufjbW1Oky+KDXxlsixiMI36TTb55LUa10kJNd1FjJZdmeGNU5X4pShabdFjDzRVY1zjYKwlNBI7U04Id8RRczvMj4fXt/ovTYuddab3YF4sGakF0YjYGmi2NgzVJugbaCY2txmV6wYboBdO76MGhoHFlYx+geeja3ozKKSa9OQKpOzpoy4Gi2nPh8JA58Evlg/OYRmhin681zHQEGtjAMFR8GuLMXyzIL3GXc6KekV3GNA4nNkg3tq8pL8qpRZ9Uuk/v6rHhxpAvx0XtrVnq5T2Z99kF1NqrJq4HLV3eetBdwEdbfNNC2e1mhEAH3YgTHD3RsU0MO96K/3VH0Cko65K54VuXwJm8pdRTmPbZmt4Q660YdCLRFTDyh+sOCsRPb6CAZf7LdQ4EoI1PswyY4+duSTzyyBg1pyAHvHIOSCrPvhjzR6t6cLGwEyexW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 20:05:13.3765 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34b2ca8d-d88f-4421-c752-08df19adfa9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6053
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

The hardware context scheduler fence is exposed through
drm_syncobj_add_point(). After a hardware context is destroyed,
userspace can still call drm_sched_fence_get_timeline_name() on the
fence through SYNC_IOC_FILE_INFO. This results in a use-after-free
when accessing fence->sched->name.

Preallocate hardware context schedulers and free them during device
teardown instead. A destroyed hardware context no longer frees its
scheduler, ensuring that the scheduler remains valid while its fences
are still accessible.

Fixes: aac243092b70 ("accel/amdxdna: Add command execution")
Reported-by: Jonghyuk Kim(MalHyuk) <malhyuk97@gmail.com>
Link: https://lore.kernel.org/dri-devel/20260902012712.880520-1-malhyuk97@gmail.com/
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/aie2_ctx.c | 117 +++++++++++++++++++++++--------
 drivers/accel/amdxdna/aie2_pci.c |  15 +++-
 drivers/accel/amdxdna/aie2_pci.h |   6 +-
 3 files changed, 105 insertions(+), 33 deletions(-)

diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
index 164441e43940..d927c8c9d557 100644
--- a/drivers/accel/amdxdna/aie2_ctx.c
+++ b/drivers/accel/amdxdna/aie2_ctx.c
@@ -7,6 +7,7 @@
 #include <drm/drm_device.h>
 #include <drm/drm_gem.h>
 #include <drm/drm_gem_shmem_helper.h>
+#include <drm/drm_managed.h>
 #include <drm/drm_print.h>
 #include <drm/drm_syncobj.h>
 #include <linux/hmm.h>
@@ -99,9 +100,9 @@ static void aie2_job_put(struct amdxdna_sched_job *job)
 static void aie2_hwctx_stop(struct amdxdna_dev *xdna, struct amdxdna_hwctx *hwctx,
 			    struct drm_sched_job *bad_job)
 {
-	drm_sched_stop(&hwctx->priv->sched, bad_job);
+	drm_sched_stop(hwctx->priv->sched, bad_job);
 	aie2_destroy_context(xdna->dev_handle, hwctx);
-	drm_sched_start(&hwctx->priv->sched, 0);
+	drm_sched_start(hwctx->priv->sched, 0);
 }
 
 static int aie2_hwctx_restart(struct amdxdna_dev *xdna, struct amdxdna_hwctx *hwctx)
@@ -659,10 +660,19 @@ static void aie2_ctx_syncobj_destroy(struct amdxdna_hwctx *hwctx)
 	drm_syncobj_put(hwctx->priv->syncobj);
 }
 
-int aie2_hwctx_init(struct amdxdna_hwctx *hwctx)
+void aie2_hwctx_sched_fini(struct amdxdna_dev_hdl *ndev)
 {
-	struct amdxdna_client *client = hwctx->client;
-	struct amdxdna_dev *xdna = client->xdna;
+	int i;
+
+	for (i = 0; i < ndev->priv->hwctx_limit; i++)
+		drm_sched_fini(&ndev->hwctx_sched[i]);
+
+	ida_destroy(&ndev->hwctx_sched_ida);
+}
+
+int aie2_hwctx_sched_init(struct amdxdna_dev_hdl *ndev)
+{
+	struct amdxdna_dev *xdna = ndev->aie.xdna;
 	const struct drm_sched_init_args args = {
 		.ops = &sched_ops,
 		.num_rqs = DRM_SCHED_PRIORITY_COUNT,
@@ -673,7 +683,55 @@ int aie2_hwctx_init(struct amdxdna_hwctx *hwctx)
 		.name = "amdxdna_js",
 		.dev = xdna->ddev.dev,
 	};
-	struct drm_gpu_scheduler *sched;
+	int i, ret;
+
+	ndev->hwctx_sched = drmm_kcalloc(&xdna->ddev, ndev->priv->hwctx_limit,
+					 sizeof(*ndev->hwctx_sched), GFP_KERNEL);
+	if (!ndev->hwctx_sched)
+		return -ENOMEM;
+
+	for (i = 0; i < ndev->priv->hwctx_limit; i++) {
+		ret = drm_sched_init(&ndev->hwctx_sched[i], &args);
+		if (ret) {
+			XDNA_ERR(xdna, "Failed to init DRM scheduler. ret %d", ret);
+			goto fini_sched;
+		}
+	}
+
+	ida_init(&ndev->hwctx_sched_ida);
+
+	return 0;
+
+fini_sched:
+	while (--i >= 0)
+		drm_sched_fini(&ndev->hwctx_sched[i]);
+
+	return ret;
+}
+
+static struct drm_gpu_scheduler *aie2_hwctx_sched_alloc(struct amdxdna_dev_hdl *ndev)
+{
+	int ret;
+
+	ret = ida_alloc_range(&ndev->hwctx_sched_ida, 0,
+			      ndev->priv->hwctx_limit - 1, GFP_KERNEL);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	return &ndev->hwctx_sched[ret];
+}
+
+static void aie2_hwctx_sched_free(struct amdxdna_dev_hdl *ndev,
+				  struct drm_gpu_scheduler *sched)
+{
+	ida_free(&ndev->hwctx_sched_ida, sched - ndev->hwctx_sched);
+}
+
+int aie2_hwctx_init(struct amdxdna_hwctx *hwctx)
+{
+	struct amdxdna_client *client = hwctx->client;
+	struct amdxdna_dev *xdna = client->xdna;
+	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
 	struct amdxdna_hwctx_priv *priv;
 	struct amdxdna_gem_obj *heap;
 	int i, ret;
@@ -683,13 +741,26 @@ int aie2_hwctx_init(struct amdxdna_hwctx *hwctx)
 		return -ENOMEM;
 	hwctx->priv = priv;
 
+	priv->sched = aie2_hwctx_sched_alloc(ndev);
+	if (IS_ERR(priv->sched)) {
+		ret = PTR_ERR(priv->sched);
+		goto free_priv;
+	}
+
+	ret = drm_sched_entity_init(&priv->entity, DRM_SCHED_PRIORITY_NORMAL,
+				    &priv->sched, 1, NULL);
+	if (ret) {
+		XDNA_ERR(xdna, "Failed to initial sched entity. ret %d", ret);
+		goto free_sched;
+	}
+
 	mutex_lock(&client->mm_lock);
 	heap = xa_load(&client->dev_heap_xa, 0);
 	if (!heap) {
 		XDNA_ERR(xdna, "The client dev heap object not exist");
 		mutex_unlock(&client->mm_lock);
 		ret = -ENOENT;
-		goto free_priv;
+		goto free_entity;
 	}
 	drm_gem_object_get(to_gobj(heap));
 	mutex_unlock(&client->mm_lock);
@@ -722,30 +793,16 @@ int aie2_hwctx_init(struct amdxdna_hwctx *hwctx)
 		priv->cmd_buf[i] = abo;
 	}
 
-	sched = &priv->sched;
 	mutex_init(&priv->io_lock);
 
 	fs_reclaim_acquire(GFP_KERNEL);
 	might_lock(&priv->io_lock);
 	fs_reclaim_release(GFP_KERNEL);
 
-	ret = drm_sched_init(sched, &args);
-	if (ret) {
-		XDNA_ERR(xdna, "Failed to init DRM scheduler. ret %d", ret);
-		goto free_cmd_bufs;
-	}
-
-	ret = drm_sched_entity_init(&priv->entity, DRM_SCHED_PRIORITY_NORMAL,
-				    &sched, 1, NULL);
-	if (ret) {
-		XDNA_ERR(xdna, "Failed to initial sched entiry. ret %d", ret);
-		goto free_sched;
-	}
-
 	ret = aie2_hwctx_col_list(hwctx);
 	if (ret) {
 		XDNA_ERR(xdna, "Create col list failed, ret %d", ret);
-		goto free_entity;
+		goto free_cmd_bufs;
 	}
 
 	ret = amdxdna_pm_resume_get_locked(xdna);
@@ -791,10 +848,6 @@ int aie2_hwctx_init(struct amdxdna_hwctx *hwctx)
 	amdxdna_pm_suspend_put(xdna);
 free_col_list:
 	kfree(hwctx->col_list);
-free_entity:
-	drm_sched_entity_destroy(&priv->entity);
-free_sched:
-	drm_sched_fini(&priv->sched);
 free_cmd_bufs:
 	for (i = 0; i < ARRAY_SIZE(priv->cmd_buf); i++) {
 		if (!priv->cmd_buf[i])
@@ -805,6 +858,10 @@ int aie2_hwctx_init(struct amdxdna_hwctx *hwctx)
 	amdxdna_gem_unpin(heap);
 put_heap:
 	drm_gem_object_put(to_gobj(heap));
+free_entity:
+	drm_sched_entity_destroy(&priv->entity);
+free_sched:
+	aie2_hwctx_sched_free(ndev, priv->sched);
 free_priv:
 	kfree(priv);
 	return ret;
@@ -812,18 +869,20 @@ int aie2_hwctx_init(struct amdxdna_hwctx *hwctx)
 
 void aie2_hwctx_fini(struct amdxdna_hwctx *hwctx)
 {
+	struct amdxdna_dev_hdl *ndev;
 	struct amdxdna_dev *xdna;
 	int idx;
 
 	xdna = hwctx->client->xdna;
+	ndev = xdna->dev_handle;
 
 	XDNA_DBG(xdna, "%s sequence number %lld", hwctx->name, hwctx->priv->seq);
 	aie2_hwctx_wait_for_idle(hwctx);
 
 	/* Request fw to destroy hwctx and cancel the rest pending requests */
-	drm_sched_stop(&hwctx->priv->sched, NULL);
+	drm_sched_stop(hwctx->priv->sched, NULL);
 	aie2_release_resource(hwctx);
-	drm_sched_start(&hwctx->priv->sched, 0);
+	drm_sched_start(hwctx->priv->sched, 0);
 
 	mutex_unlock(&xdna->dev_lock);
 	drm_sched_entity_destroy(&hwctx->priv->entity);
@@ -834,7 +893,7 @@ void aie2_hwctx_fini(struct amdxdna_hwctx *hwctx)
 		   atomic64_read(&hwctx->job_free_cnt));
 	mutex_lock(&xdna->dev_lock);
 
-	drm_sched_fini(&hwctx->priv->sched);
+	aie2_hwctx_sched_free(ndev, hwctx->priv->sched);
 	aie2_ctx_syncobj_destroy(hwctx);
 
 	for (idx = 0; idx < ARRAY_SIZE(hwctx->priv->cmd_buf); idx++) {
diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
index daec1f6b4907..7a4314ca843b 100644
--- a/drivers/accel/amdxdna/aie2_pci.c
+++ b/drivers/accel/amdxdna/aie2_pci.c
@@ -503,10 +503,16 @@ static int aie2_init(struct amdxdna_dev *xdna)
 	ndev->priv = xdna->dev_info->dev_priv;
 	ndev->aie.xdna = xdna;
 
+	ret = aie2_hwctx_sched_init(ndev);
+	if (ret)
+		return ret;
+
 	for (i = 0; i < ARRAY_SIZE(npu_fw); i++) {
 		fw_full_path = kasprintf(GFP_KERNEL, "%s%s", ndev->priv->fw_path, npu_fw[i]);
-		if (!fw_full_path)
-			return -ENOMEM;
+		if (!fw_full_path) {
+			ret = -ENOMEM;
+			goto free_hwctx_sched;
+		}
 
 		ret = firmware_request_nowarn(&fw, fw_full_path, &pdev->dev);
 		kfree(fw_full_path);
@@ -519,7 +525,7 @@ static int aie2_init(struct amdxdna_dev *xdna)
 	if (ret) {
 		XDNA_ERR(xdna, "failed to request_firmware %s, ret %d",
 			 ndev->priv->fw_path, ret);
-		return ret;
+		goto free_hwctx_sched;
 	}
 
 	ret = pcim_enable_device(pdev);
@@ -623,6 +629,8 @@ static int aie2_init(struct amdxdna_dev *xdna)
 	aie2_hw_stop(xdna);
 release_fw:
 	release_firmware(fw);
+free_hwctx_sched:
+	aie2_hwctx_sched_fini(ndev);
 
 	return ret;
 }
@@ -631,6 +639,7 @@ static void aie2_fini(struct amdxdna_dev *xdna)
 {
 	amdxdna_pm_fini(xdna);
 	aie2_hw_stop(xdna);
+	aie2_hwctx_sched_fini(xdna->dev_handle);
 }
 
 static int aie2_get_aie_status(struct amdxdna_client *client,
diff --git a/drivers/accel/amdxdna/aie2_pci.h b/drivers/accel/amdxdna/aie2_pci.h
index ea1dac106400..2c7019bd26b5 100644
--- a/drivers/accel/amdxdna/aie2_pci.h
+++ b/drivers/accel/amdxdna/aie2_pci.h
@@ -107,7 +107,7 @@ struct amdxdna_hwctx_priv {
 	struct amdxdna_gem_obj		*heap;
 	void				*mbox_chann;
 
-	struct drm_gpu_scheduler	sched;
+	struct drm_gpu_scheduler	*sched;
 	struct drm_sched_entity		entity;
 
 	struct mutex			io_lock; /* protect seq and cmd order */
@@ -152,6 +152,8 @@ struct amdxdna_dev_hdl {
 	u32				total_col;
 	struct amdxdna_drm_query_aie_version version;
 	struct aie2_exec_msg_ops	*exec_msg_ops;
+	struct drm_gpu_scheduler	*hwctx_sched;
+	struct ida			hwctx_sched_ida;
 
 	/* power management and clock*/
 	enum amdxdna_power_mode_type	pw_mode;
@@ -294,6 +296,8 @@ int aie2_update_prop_time_quota(struct amdxdna_dev_hdl *ndev, u32 us);
 /* aie2_hwctx.c */
 int aie2_hwctx_init(struct amdxdna_hwctx *hwctx);
 void aie2_hwctx_fini(struct amdxdna_hwctx *hwctx);
+int aie2_hwctx_sched_init(struct amdxdna_dev_hdl *ndev);
+void aie2_hwctx_sched_fini(struct amdxdna_dev_hdl *ndev);
 int aie2_hwctx_config(struct amdxdna_hwctx *hwctx, u32 type, u64 value, void *buf, u32 size);
 int aie2_hwctx_sync_debug_bo(struct amdxdna_hwctx *hwctx, u32 debug_bo_hdl);
 void aie2_hwctx_suspend(struct amdxdna_client *client);
-- 
2.34.1

