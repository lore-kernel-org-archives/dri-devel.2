Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDEA4CD98C6
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:52:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F29910ECCD;
	Thu, 11 Jun 2026 05:52:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IEteDQjk";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011037.outbound.protection.outlook.com
 [40.93.194.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 428BF10ECC8
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 05:52:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=llnSVt5tvxZfauN0ajSOLlS3hHEC7HEjgBv/2HJ+Wo8WCvODvM80gcik+iFCVKLjeA6JymvHWEMcZtn3AmQlw0qCPk4pinmZYmo4FOvLpdRVMG0F6LImDHXCJCzCl71NoTwJH7BFicnNWhTBoxIMC2zFjUUvIlB/7sH1qtw7kIB374zRtIHfkbDKi8luvbNLRgmnSNi+B9UgGb5//H1fKPsIN+1sOlDuYp9dW5FWUmNioOLJj9WW+uqq/99U2xEVFReSSYwxIhJZMFn2Xn9Y55MXTD/hnwGzZUGDfewJmZ45z0/fFQzl9yr48uGf0QE13+OrYd6CkA1rIZdntDThjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TDBqU4jtOQkRjKvXjiOHnbZ35pWw8OjepWJE4hmYzp8=;
 b=K24ULBoZKo+S1fMyFvAUawWgWu1ltkKOB9rfKngryjalx+w6/bKdG3ryDuNZLzNQZmu8D5giQxWjBwjWsNoOFftKEJZgpYgO85tzvdH0XpOtde87cV/eTYiG02W4wB2oTe+p6hMR/p5z1kwVGP5xBi8pjz3dru2lDtlXNHkeP+zruazN4wggN53vZ+UIdj3bUuG6LCd7SKGpQ3SVsyhcZfTxYfHnF9NyM9cOYJZnpbfBWYAIOTvAQiu45l3D6sfTJD0HU+dyrv53wPLorXLzNRM2VWph11ka2LpdDbzJGJZ+8QPsTY1Q1FMjTrb3zNJnBBRsbCXlahrMzkTs3s2zLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TDBqU4jtOQkRjKvXjiOHnbZ35pWw8OjepWJE4hmYzp8=;
 b=IEteDQjkqQLd5n/S6jfE0QnBeO5DUptYPCwOrDVCPrwYuRBNaM9g+dX3B+f1WhjudBjf5/rZ7ls2Wv20KOtiXChPIAEthldPi4dN718ydZpXkrCJQHbDfV8InZe3SHnesaEm0xNQXF2fpJMtd04ASxz6KSUgCtTM9kECNzRks5A=
Received: from SJ0PR03CA0126.namprd03.prod.outlook.com (2603:10b6:a03:33c::11)
 by PH7PR12MB6694.namprd12.prod.outlook.com (2603:10b6:510:1b1::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Thu, 11 Jun
 2026 05:52:06 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::3d) by SJ0PR03CA0126.outlook.office365.com
 (2603:10b6:a03:33c::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.12 via Frontend Transport; Thu,
 11 Jun 2026 05:52:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Thu, 11 Jun 2026 05:52:06 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 11 Jun
 2026 00:52:05 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 22:52:04 -0700
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 11 Jun 2026 00:52:04 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <max.zhen@amd.com>, <sonal.santan@amd.com>
Subject: [PATCH V3 1/3] accel/amdxdna: Fix amdxdna_client lifetime race during
 device removal
Date: Wed, 10 Jun 2026 22:51:48 -0700
Message-ID: <20260611055150.3070216-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|PH7PR12MB6694:EE_
X-MS-Office365-Filtering-Correlation-Id: 54d1a77e-ad12-4a46-1b42-08dec77d91e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|3023799007|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: WuXIEzAdYQVQQ58Z+ZVyss2QdG/gcaGIQtPd/AZgrI8sC2krnup7tT2HwPKuIhSSCp9MqO4qHES9n4Ovjc/Ybrvdx4TXV2OvTIHjaIjulE8eJFG6mNFaz3IP5FkjYX0mCdELkfRe7baXEsofVmSOXWvsTGkh25ZhNqr/DBvtL0MX1BVhVX1hXHWQteMaFknR/E6mw6cXOmEIV3/BBlRn0BFjc/zVC0jcr48AmbJuu7Jzo4PpPIQNNBlQ5of1Sa2ByRVtIMbKSsdSsmP1U9Yrv/VfvaoWqVrIrRCO6yTkmioysaya3H5pVX6UZnEAWQEY98DkDppVGICBoD+il4qmQMuNkbcEdrmtIzBzKAeiRztHgyZ+CO5EaDTJz1vrnL9W5t8/9TkJlya71s8gZfTaqLdTL9/zumSNDhr3CcHLWpGuSZIaVYAeKykhEcRMZteHx1S2wWCYg9UAPJhKIPUka2LwwMm/bscoKIqd0SQNrAUn246IC3jDhpBkPfoLZrgVV+3ae3ZxamUtFHw8G9hJ0YxU938h3w5cexL7NnL7NSZOS1EsbViMNnSbB5AU0bVtEA7z68d9ORzAwCNDJpPFFwTHly0PXN7GWV1tJUFGm9m8GYV89QRNk6eIkXDzIl3Jm7o9VVxs0hYeSMEJN3ziOqAB31DAAhkc0Jgj+SYnUjNAb2bclsgBDQIxWttFg6PgSYOwdxqtYTX6Mh4fgrl1dFowcDSuaARz9IiBzWFysfk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(3023799007)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xXPycxdIhBwy4dPJF9Kk+NakFU2c4zqWtpSkMZC/O/OtHua+/SdzAzX0TfnQfczzvKdyuOz4Av42K4VRNNRyJygwdylPKxkekIEaoiVeo06G+TjrnstQ4I2VKj37mnMPZyVMNXYemNE9ABezrJpbcHNm3AcVpifTFwF3gK2iAiQL+KUSQpHyovNX4Gr6w9t+naEQRC9xUR4X8Oj0fMT3bNd1AN9yxjjaJJ2BGGK0TfY8OGI9OcnP5hhKZQSEEBh4I6aEHEsXYs8Hh/cwmoCTr+i99Zm9Gvh5xnJzN/Z3SYAjduusKn1/kB4fcQcJngxQk+XQlLLxqsHG9HoU6P72/ppMphGA7bFvBUVafbMbCfZxmDMNPeTZR71tV07GIi3NsX2y09oMhY8Xqe6PusaF+d2UC8LSYxFkARVMlPDFpzMFmLk9AQUFi/bjBPIITual
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 05:52:06.4590 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54d1a77e-ad12-4a46-1b42-08dec77d91e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6694
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

In amdxdna_remove(), all amdxdna_client structures are freed after
calling drm_dev_unplug(). However, drm_dev_unplug() does not force
existing file descriptors to be closed, so amdxdna_drm_close() may be
called after amdxdna_remove() has completed.

As a result, accessing client->pid for debug output in
amdxdna_drm_close() can lead to a use-after-free, since the access is
not protected by drm_dev_enter().

Fix this by decoupling hardware teardown from client cleanup.
amdxdna_remove() only performs hardware-related cleanup, while
per-client resources are released from amdxdna_drm_close() when the
corresponding file is closed.

Fixes: be462c97b7df ("accel/amdxdna: Add hardware context")
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/amdxdna_pci_drv.c | 23 ++++++++++-------------
 drivers/accel/amdxdna/amdxdna_pci_drv.h |  1 +
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdxdna/amdxdna_pci_drv.c
index 65489bb3f2b0..470bf4fc744b 100644
--- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
+++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
@@ -138,9 +138,11 @@ static int amdxdna_drm_open(struct drm_device *ddev, struct drm_file *filp)
 		    xdna->dev_info->dev_heap_max_size);
 	mutex_init(&client->mm_lock);
 
+	mutex_lock(&xdna->client_lock);
 	mutex_lock(&xdna->dev_lock);
 	list_add_tail(&client->node, &xdna->client_list);
 	mutex_unlock(&xdna->dev_lock);
+	mutex_unlock(&xdna->client_lock);
 
 	filp->driver_priv = client;
 	client->filp = filp;
@@ -174,18 +176,14 @@ static void amdxdna_drm_close(struct drm_device *ddev, struct drm_file *filp)
 {
 	struct amdxdna_client *client = filp->driver_priv;
 	struct amdxdna_dev *xdna = to_xdna_dev(ddev);
-	int idx;
 
 	XDNA_DBG(xdna, "closing pid %d", client->pid);
 
-	if (!drm_dev_enter(&xdna->ddev, &idx))
-		return;
-
+	mutex_lock(&xdna->client_lock);
 	mutex_lock(&xdna->dev_lock);
 	amdxdna_client_cleanup(client);
 	mutex_unlock(&xdna->dev_lock);
-
-	drm_dev_exit(idx);
+	mutex_unlock(&xdna->client_lock);
 }
 
 static int amdxdna_drm_get_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
@@ -372,6 +370,7 @@ static int amdxdna_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return -ENODEV;
 
 	drmm_mutex_init(ddev, &xdna->dev_lock);
+	drmm_mutex_init(ddev, &xdna->client_lock);
 	init_rwsem(&xdna->notifier_lock);
 	INIT_LIST_HEAD(&xdna->client_list);
 	pci_set_drvdata(pdev, xdna);
@@ -442,18 +441,16 @@ static void amdxdna_remove(struct pci_dev *pdev)
 	drm_dev_unplug(&xdna->ddev);
 	amdxdna_sysfs_fini(xdna);
 
+	mutex_lock(&xdna->client_lock);
 	mutex_lock(&xdna->dev_lock);
-	client = list_first_entry_or_null(&xdna->client_list,
-					  struct amdxdna_client, node);
-	while (client) {
-		amdxdna_client_cleanup(client);
-
-		client = list_first_entry_or_null(&xdna->client_list,
-						  struct amdxdna_client, node);
+	list_for_each_entry(client, &xdna->client_list, node) {
+		amdxdna_hwctx_remove_all(client);
+		amdxdna_sva_fini(client);
 	}
 
 	xdna->dev_info->ops->fini(xdna);
 	mutex_unlock(&xdna->dev_lock);
+	mutex_unlock(&xdna->client_lock);
 
 	amdxdna_iommu_fini(xdna);
 }
diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.h b/drivers/accel/amdxdna/amdxdna_pci_drv.h
index 34271c14d359..a997d27a504d 100644
--- a/drivers/accel/amdxdna/amdxdna_pci_drv.h
+++ b/drivers/accel/amdxdna/amdxdna_pci_drv.h
@@ -120,6 +120,7 @@ struct amdxdna_dev {
 
 	struct mutex			dev_lock; /* per device lock */
 	struct list_head		client_list;
+	struct mutex			client_lock; /* client_list */
 	struct amdxdna_fw_ver		fw_ver;
 	struct rw_semaphore		notifier_lock; /* for mmu notifier*/
 	struct workqueue_struct		*notifier_wq;
-- 
2.34.1

