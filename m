Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83753C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 17:23:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF66410EE6A;
	Tue,  7 Jul 2026 17:23:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DwWFUEhq";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011044.outbound.protection.outlook.com [40.107.208.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F1BF10EE6A
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 17:23:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x5BiG2K8JGHXsTNIMk9Ey13v2P5NN89GgmUVtnpdIuo5BWjLH+IH8TSCB2EbSRp/gndS+pFgct+y2s8Xc+kwz3lRT+2ffm1rhAdjmwujxVwlrGE9p1S3XQs08p2/Ci/7laTmfFwp/T48FOqQDCA0cDYBXIAVAZB9d1enNCSg+Y0I5rg4utz2Rr3DSKiVa9YLFwr9n6L/uAic3FONDKtcH3PjVK+49konCLJhPTWNb2pcrrG7ZXFsFs7Jbc9Ol6FgzhZnJMKP8jxVh5by7W+KGEcLq8MTwfdO8OJZBlQkPGRhaRq0IXzotNSDzkVfgmRAjPeBvzQCWdLflspBnJhn1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dTzgYKSTgMRxo67nzsRNUcnVdR7voicuKu1LOb510E4=;
 b=JsC2EinD7544A2HVqfna17RNvFPSg6AlTEZ90AtL989RyL8wCTDmmqjFWR6XZDQV0u5r9ENRuy/vMIN2jVzOrT7KQS5BnaeVl+2brx5hYQV2s4xDAz0IfDVHIr8Gdbzg92/jvd8boUZnKliG1WcdWH2Is11B81fI5g4T65jBbtSZEBjRH+EqIDsmN0KrrRawVs4Kuw1P177Hon+gHKFJz9+YgZCHDu6kE0B2LZ/s8xoFO2OYEU67Y6aJqkywpBMKkG2ysX8NKL/6K2ZhKV1vcPFvbmYSWY7Nul4Zx62pLLrEc2xSaclQeGT5hNwrr5pdQ370Kchq6yENz5g2ISclOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTzgYKSTgMRxo67nzsRNUcnVdR7voicuKu1LOb510E4=;
 b=DwWFUEhqySvi9yL0UsVyM7R0llfrh5hE6xt8+IstHQCVgBmFq556EGb0rSDe3HcEM1m+3V7Y8spYzQLd14z3434/9bSM9dJ9QQWAMdGCd+knxEF7PT0TLYFCG7b6Qa0A3p9yJmT7/8cSQ/hxVKu6ZLt4Pqqc4mVhDOx6av1oOPc=
Received: from CY5PR18CA0013.namprd18.prod.outlook.com (2603:10b6:930:5::23)
 by SA1PR12MB999109.namprd12.prod.outlook.com (2603:10b6:806:4a1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 17:23:35 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:930:5:cafe::82) by CY5PR18CA0013.outlook.office365.com
 (2603:10b6:930:5::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Tue, 7
 Jul 2026 17:23:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 17:23:34 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 12:23:25 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 7 Jul 2026 12:23:25 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <max.zhen@amd.com>, <sonal.santan@amd.com>
Subject: [PATCH V1] accel/amdxdna: Check init_srcu_struct() return value
Date: Tue, 7 Jul 2026 10:23:23 -0700
Message-ID: <20260707172323.539721-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|SA1PR12MB999109:EE_
X-MS-Office365-Filtering-Correlation-Id: 95c14ce2-a8dc-4d05-cbdf-08dedc4c7984
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: 0iUaWEE8TpjKD1SNoyPYf67U83pPzNwHCKuKrnhfzGUg+8ohZOKA9Gq43cSm6/ewx3MlUphiUoZ56mFMI55jzGS3UwXDHu5fPv9ukvrFR+hXlVOiDcW1VbBrV5BJRPCPhWPwW9LAY14NVTWE6grzMZ3JOBCNF31QauRmMqIcwymO45FoBSbAZlFGeUL2FGB5PQJuMNXK66AzASIhFsTFcxEfQ0kN4LpZPfywi+LLpVSejpxa1VAEapNxE2JmS2mSDl9RK52D3JhU0IlQOKUQSK5UybdNmy4YcthjPC0gQZ7wSZlew/0q6Vn4Dkg1npVYahOENVd9US9d0H6PYroCUPe1Di/XITeFbz4HOzVjC9HN64hAEsLs1VWZneVlxvid846CAbthZMvkOIzS+nGpIq0OujmhnITxvlG97ZQS/rcdP8P5d8V95cleLEpv4EYmIveFEPLXWtuofnxPIOxItPD+allh4TV9+7kMNtoMjl2i632Rl1nNirrk+4ky+nYy3qbGBiRBYzAjSJpt6og9fsaM6GW4sZ4P9+sYmm5oKknhSnbo5BsMsxPSaTxP6FaCOW8E5yGpri5GR4r/LwXanMHXFjBWukvmLgH1ipay23UOgEWjpGPgEpaGaprF0135UCCOAD+P9EvPKjUB5Z0x4iWh1WihcZJ7cwJs+uORygrtDUwZBbxvAsZPzfpeDHkcNikPtGq3N94RLIpmktLocA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(18002099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hJR34VnOb/ajGLwg35qYM/B0dO5QX9ddkx3d/PoFOKe9M0nlRoP7L0ZDsI9PE0KqdePr1/OvHtReshw+/2IlWe4ewvZOtVUJzbhrWWhvcqVAACl9MYGQHFPb7z8j7oLkDZEv4ZQEtC+ZErC/jh4VTOD/Qs/gqv/RWWI1SWeswrsGeYc1PEA+goWNeEMmq+VfUbsZT8OIEU+CHiQebbu+3o9pBrh4XhNJSWI3KFS/uSXWbNcePcndqfj5e+67/BxWFmK7+SpfRs88E9AUNX8pXnNY9EryPFoSO3oaCtj1FssBcLqmUdu61o/Wnh0xYDMrx0zoMKme2e9SJgFceuu65GZs/bb8uRlQPJ30VFXTnzAVubQgFEFI1IoyDZAR0Lo2WoHSfRqRpX/EhO7XnHuSjNmvspBYBRIufSp2PtDWxnPm+u271k4vDbUdDkJYx8E/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 17:23:34.6980 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95c14ce2-a8dc-4d05-cbdf-08dedc4c7984
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999109
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

The return value of init_srcu_struct() is currently ignored. If
initialization fails, subsequent use of hwctx_srcu may result in invalid
memory accesses.

Check the return value of init_srcu_struct() and propagate the error to
the caller.

Fixes: aac243092b70 ("accel/amdxdna: Add command execution")
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/amdxdna_pci_drv.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdxdna/amdxdna_pci_drv.c
index 86e9c230875a..bb339e641416 100644
--- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
+++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
@@ -109,11 +109,16 @@ static int amdxdna_drm_open(struct drm_device *ddev, struct drm_file *filp)
 {
 	struct amdxdna_dev *xdna = to_xdna_dev(ddev);
 	struct amdxdna_client *client;
+	int ret;
 
 	client = kzalloc_obj(*client);
 	if (!client)
 		return -ENOMEM;
 
+	ret = init_srcu_struct(&client->hwctx_srcu);
+	if (ret)
+		goto free_client;
+
 	client->pid = pid_nr(rcu_access_pointer(filp->pid));
 	client->xdna = xdna;
 	client->pasid = IOMMU_PASID_INVALID;
@@ -125,13 +130,12 @@ static int amdxdna_drm_open(struct drm_device *ddev, struct drm_file *filp)
 			XDNA_WARN(xdna, "PASID not available for pid %d", client->pid);
 			if (!amdxdna_use_carveout(xdna)) {
 				XDNA_ERR(xdna, "PASID unavailable and carveout not configured");
-				kfree(client);
-				return -EINVAL;
+				ret = -EINVAL;
+				goto cleanup_srcu;
 			}
 		}
 	}
 	mmgrab(client->mm);
-	init_srcu_struct(&client->hwctx_srcu);
 	xa_init_flags(&client->hwctx_xa, XA_FLAGS_ALLOC);
 	xa_init_flags(&client->dev_heap_xa, XA_FLAGS_ALLOC);
 	drm_mm_init(&client->dev_heap_mm, xdna->dev_info->dev_mem_base,
@@ -149,6 +153,12 @@ static int amdxdna_drm_open(struct drm_device *ddev, struct drm_file *filp)
 
 	XDNA_DBG(xdna, "pid %d opened", client->pid);
 	return 0;
+
+cleanup_srcu:
+	cleanup_srcu_struct(&client->hwctx_srcu);
+free_client:
+	kfree(client);
+	return ret;
 }
 
 static void amdxdna_client_cleanup(struct amdxdna_client *client)
-- 
2.34.1

