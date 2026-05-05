Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B24CD3427
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 16:12:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B111B10EB72;
	Tue,  5 May 2026 16:12:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WOjszoxd";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010060.outbound.protection.outlook.com
 [40.93.198.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8733310EB72
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 16:12:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B+C/D1FMb2VM9ZLB72gpS8w00ZxJNp1ymlmGhopUpaUgXNV1nTVhVQafd1znZnUeAFJLE07aLP3HUhh0Qf7dYSjaus5WL4aAek27zj/EmiDxjA81MdjGjPFXjveHs2uoXOv43sApP+ACNXAT2+dj4eymKSWnE/QbFaHUkSHOEOaGp6lCq6Gir935Q2PKKQvH8KuED3Ng8EgMvAhW5gG6VqELKpcVOQHDhrFOdo0O8OCZAcDbW/egRIiNPu9F9AvBduOf/dMTu5tUpSukpyAlFoTminrDJSGrwFzG9J/lMQj+3JdP8zQOEtpdOWW54T03khqGyc9EVBqlqBkU+NTpXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K9N8ZPxzt5MCaiRT/P7lxB5nwSTPzoDYON/bmW4Dcag=;
 b=nVpCN2Esr26jNf2OsBk7JJQSM0kl3cPQVKVkeFXUMsxDpLvFjRXTX7IL7ejW3bqETHCdvTnZJu8Udf1zOrcA64SngzGG/HQoZR2iCuedde8AIFNLColhrgMDRLTnAoUSkW1nUsSgip1R+ZmkZJ4ubdE6MiQukHpZQyHm1SEI3wqbFex/J3XhWx0avTJAPoAMyHUldoK4XbND2DSpGakf8rqOFu4CZFaLP1jzWSvEI79jHjy7IAMKS/AoN8RxoD5MyIg7tumagZc05SJubCsZzU0G85KcYqMA0c4y2E9BVQSuDk2Nob5sW4nzcQQZ0H9TyfAFZjDAZy/I8EwLQEPMwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9N8ZPxzt5MCaiRT/P7lxB5nwSTPzoDYON/bmW4Dcag=;
 b=WOjszoxdeVuUHRcPO5hEpurq6MuaqA105AVkmy1rQAmhOmASXCPLBgLzrZSsKhxE0zjDjJM3x4wzRs57/p1aXkIHt2ceWiBuj5KRtA9XozBlmqNo2Ldr/mGN7eAvkvISBlsMhuy6OEI8srV7idT2ioRgeaaTwxYRG8F2W3od61w=
Received: from PH8PR05CA0023.namprd05.prod.outlook.com (2603:10b6:510:2cc::8)
 by LV9PR12MB9830.namprd12.prod.outlook.com (2603:10b6:408:2ec::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 16:12:01 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:510:2cc:cafe::39) by PH8PR05CA0023.outlook.office365.com
 (2603:10b6:510:2cc::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.15 via Frontend Transport; Tue,
 5 May 2026 16:11:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 16:11:58 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 5 May
 2026 11:11:08 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 5 May
 2026 09:09:49 -0700
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 5 May 2026 11:09:48 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>
CC: Nishad Saraf <nishads@amd.com>, <linux-kernel@vger.kernel.org>,
 <max.zhen@amd.com>, <sonal.santan@amd.com>, Lizhi Hou <lizhi.hou@amd.com>
Subject: [PATCH V1 6/6] accel/amdxdna: Add AIE4 work buffer initialization
Date: Tue, 5 May 2026 09:09:36 -0700
Message-ID: <20260505160936.3917732-7-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260505160936.3917732-1-lizhi.hou@amd.com>
References: <20260505160936.3917732-1-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|LV9PR12MB9830:EE_
X-MS-Office365-Filtering-Correlation-Id: b656e6f4-9bfc-48e8-7973-08deaac108a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: I5+g05S00EC2TNyKYPaSAH+WL1Ujcw4Ve8jMAALVh8SQ06hdPpZ4gYeb+5yNw7B/hCbydp0tNjDebgrdBZ3e+rhcRGhA8h40CSjZhjS1E7clFQ2TJkdnEdB1oupARo38m+V+OWhBLO4Z1Gu406M/gTmvNJ8SCcefV6ilWDRVVaPzTJQLZN0uNptki8I/LeZBC7FSMqiEXxcu8V7ViFJLZj9ZuKHQw0VwRUCJ940EPATJCYlKVf/sCc99WWMfSAganmQUGCet6Bq5RQUfCDMBInsbsh0zXW9NfCesiBBmhoH8NlSjn55BNtZ4D0FUNND7FEEufydyQqgdWC00znJtQGrTp6qTaszGgjvd17yF3jeebixH/27Z1vUTXvYDOK6kr66MypNu9/ObLT3sgt/MxBtzsUzDkGLY6lOpH1iDw9h53n//sIg2i0loHpwMWHWRg90hLYq5MU1aHzQdF+9C0C7prwfD7K+1SsGepXdcnIcsbOZXqBhOzXElnEM/R3drKDvQV7A5ANSBA8IWWcxRFK35gm3mwFl6Xwdd/RO7Y8+wK0ammXia+WZj/cIjfXLlWJhbbPQOEsJxi1VubZyY1PM1efx94Zpx2l2qcTN9T/Dqc9fLt5ZC4dbyvnVs/DdudPrlKiRmcFKbMKOP0HRNzxBm8A+zN6I7HDghy9BmlMR9BwAcHMInPQ+fT/J2jKZqlm9jYJgfeOqdKLTdqIJ0yOHRo5PzBpCL6nbowX5oTA4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kSbJWmFMVZvtG7sW5yrZr/Qe/uHQj2l9ZeW2I3Efpz5p6m5q0Ji+g7gulJAjAPJCU/anSmbX7Wsd2lDHuzIDt+deFq00/VAsVNdScJoIJ1730lUd1B6s1V8anHZd45E/R75QyDZSaYWhyxuRlhL6Ax/WIn2t4pWNEZMnlAEIFligvmT8WVAcrPskInuZWlfHo+LRsR0f1BpGEtwzqChnBGBuXNClplRbxzegTQgRY+D8TRr57fuOrTkQmXLODbgvyAKhj2qhe+XGlD2LLlx6Pnp88+dUkPpqXvOT9LNeXCVKG3DCTU86EkZ44I0D4oE6RffKfBOGBAShvjoktkHBUQCOOPCh57u5RBL+tTb25Dr4o9DZ46tl4/kUXV9HrmL+X9ln2LF3shMr3BBbIjsBQV4ga2dfdXqEkOxqRF3hk45j8r2ci8CZm1XKl18AMGYt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 16:11:58.3047 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b656e6f4-9bfc-48e8-7973-08deaac108a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9830
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

From: Nishad Saraf <nishads@amd.com>

NPU firmware requires a host-allocated work buffer for hardware contexts.
Allocate a 4 MB host buffer and attach it to device during device init.

Refactor aie2_alloc_msg_buffer() and aie2_free_msg_buffer() into common
helpers by moving them to aie.c and renaming them to
amdxdna_alloc_msg_buffer() and amdxdna_free_msg_buffer(), allowing both
AIE2 and AIE4 to reuse the implementation.

Signed-off-by: Nishad Saraf <nishads@amd.com>
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/aie.c             | 34 +++++++++++++++
 drivers/accel/amdxdna/aie.h             |  4 ++
 drivers/accel/amdxdna/aie2_error.c      |  7 ++--
 drivers/accel/amdxdna/aie2_message.c    | 49 +++-------------------
 drivers/accel/amdxdna/aie2_pci.h        |  4 --
 drivers/accel/amdxdna/aie4_message.c    | 18 ++++++++
 drivers/accel/amdxdna/aie4_msg_priv.h   | 14 +++++++
 drivers/accel/amdxdna/aie4_pci.c        | 55 ++++++++++++++++++++++++-
 drivers/accel/amdxdna/aie4_pci.h        |  5 +++
 drivers/accel/amdxdna/amdxdna_pci_drv.c |  3 +-
 10 files changed, 141 insertions(+), 52 deletions(-)

diff --git a/drivers/accel/amdxdna/aie.c b/drivers/accel/amdxdna/aie.c
index a31051cc1ec8..4db2fd80a032 100644
--- a/drivers/accel/amdxdna/aie.c
+++ b/drivers/accel/amdxdna/aie.c
@@ -162,3 +162,37 @@ int amdxdna_get_metadata(struct aie_device *aie,
 	kfree(meta);
 	return ret;
 }
+
+void *amdxdna_alloc_msg_buffer(struct amdxdna_dev *xdna, u32 *size,
+			       dma_addr_t *dma_addr)
+{
+	void *vaddr;
+	int order;
+
+	*size = max_t(u32, *size, SZ_8K);
+	order = get_order(*size);
+	if (order > MAX_PAGE_ORDER)
+		return ERR_PTR(-EINVAL);
+	*size = PAGE_SIZE << order;
+
+	if (amdxdna_iova_on(xdna))
+		return amdxdna_iommu_alloc(xdna, *size, dma_addr);
+
+	vaddr = dma_alloc_noncoherent(xdna->ddev.dev, *size, dma_addr,
+				      DMA_FROM_DEVICE, GFP_KERNEL);
+	if (!vaddr)
+		return ERR_PTR(-ENOMEM);
+
+	return vaddr;
+}
+
+void amdxdna_free_msg_buffer(struct amdxdna_dev *xdna, size_t size,
+			     void *cpu_addr, dma_addr_t dma_addr)
+{
+	if (amdxdna_iova_on(xdna)) {
+		amdxdna_iommu_free(xdna, size, cpu_addr, dma_addr);
+		return;
+	}
+
+	dma_free_noncoherent(xdna->ddev.dev, size, cpu_addr, dma_addr, DMA_FROM_DEVICE);
+}
diff --git a/drivers/accel/amdxdna/aie.h b/drivers/accel/amdxdna/aie.h
index 4bb3719ee0c0..70618204c0ab 100644
--- a/drivers/accel/amdxdna/aie.h
+++ b/drivers/accel/amdxdna/aie.h
@@ -121,6 +121,10 @@ int aie_check_protocol(struct aie_device *aie, u32 fw_major, u32 fw_minor);
 void amdxdna_vbnv_init(struct amdxdna_dev *xdna);
 int amdxdna_get_metadata(struct aie_device *aie, struct amdxdna_client *client,
 			 struct amdxdna_drm_get_info *args);
+void *amdxdna_alloc_msg_buffer(struct amdxdna_dev *xdna, u32 *size,
+			       dma_addr_t *dma_addr);
+void amdxdna_free_msg_buffer(struct amdxdna_dev *xdna, size_t size,
+			     void *cpu_addr, dma_addr_t dma_addr);
 
 /* aie_psp.c */
 struct psp_device *aiem_psp_create(struct drm_device *ddev, struct psp_config *conf);
diff --git a/drivers/accel/amdxdna/aie2_error.c b/drivers/accel/amdxdna/aie2_error.c
index 70007b4363cd..babdac0157ab 100644
--- a/drivers/accel/amdxdna/aie2_error.c
+++ b/drivers/accel/amdxdna/aie2_error.c
@@ -11,6 +11,7 @@
 #include <linux/kthread.h>
 #include <linux/kernel.h>
 
+#include "aie.h"
 #include "aie2_msg_priv.h"
 #include "aie2_pci.h"
 #include "amdxdna_error.h"
@@ -338,7 +339,7 @@ void aie2_error_async_events_free(struct amdxdna_dev_hdl *ndev)
 	destroy_workqueue(events->wq);
 	mutex_lock(&xdna->dev_lock);
 
-	aie2_free_msg_buffer(ndev, events->size, events->buf, events->addr);
+	amdxdna_free_msg_buffer(xdna, events->size, events->buf, events->addr);
 	kfree(events);
 }
 
@@ -354,7 +355,7 @@ int aie2_error_async_events_alloc(struct amdxdna_dev_hdl *ndev)
 	if (!events)
 		return -ENOMEM;
 
-	events->buf = aie2_alloc_msg_buffer(ndev, &total_size, &events->addr);
+	events->buf = amdxdna_alloc_msg_buffer(xdna, &total_size, &events->addr);
 	if (IS_ERR(events->buf)) {
 		ret = PTR_ERR(events->buf);
 		goto free_events;
@@ -394,7 +395,7 @@ int aie2_error_async_events_alloc(struct amdxdna_dev_hdl *ndev)
 free_wq:
 	destroy_workqueue(events->wq);
 free_buf:
-	aie2_free_msg_buffer(ndev, events->size, events->buf, events->addr);
+	amdxdna_free_msg_buffer(xdna, events->size, events->buf, events->addr);
 free_events:
 	kfree(events);
 	return ret;
diff --git a/drivers/accel/amdxdna/aie2_message.c b/drivers/accel/amdxdna/aie2_message.c
index f555ffecea6f..0417c6a4c80a 100644
--- a/drivers/accel/amdxdna/aie2_message.c
+++ b/drivers/accel/amdxdna/aie2_message.c
@@ -27,43 +27,6 @@
 
 #define EXEC_MSG_OPS(xdna)	((xdna)->dev_handle->exec_msg_ops)
 
-void *aie2_alloc_msg_buffer(struct amdxdna_dev_hdl *ndev, u32 *size,
-			    dma_addr_t *dma_addr)
-{
-	struct amdxdna_dev *xdna = ndev->aie.xdna;
-	void *vaddr;
-	int order;
-
-	*size = max(*size, SZ_8K);
-	order = get_order(*size);
-	if (order > MAX_PAGE_ORDER)
-		return ERR_PTR(-EINVAL);
-	*size = PAGE_SIZE << order;
-
-	if (amdxdna_iova_on(xdna))
-		return amdxdna_iommu_alloc(xdna, *size, dma_addr);
-
-	vaddr = dma_alloc_noncoherent(xdna->ddev.dev, *size, dma_addr,
-				      DMA_FROM_DEVICE, GFP_KERNEL);
-	if (!vaddr)
-		return ERR_PTR(-ENOMEM);
-
-	return vaddr;
-}
-
-void aie2_free_msg_buffer(struct amdxdna_dev_hdl *ndev, size_t size,
-			  void *cpu_addr, dma_addr_t dma_addr)
-{
-	struct amdxdna_dev *xdna = ndev->aie.xdna;
-
-	if (amdxdna_iova_on(xdna)) {
-		amdxdna_iommu_free(xdna, size, cpu_addr, dma_addr);
-		return;
-	}
-
-	dma_free_noncoherent(xdna->ddev.dev, size, cpu_addr, dma_addr, DMA_FROM_DEVICE);
-}
-
 int aie2_suspend_fw(struct amdxdna_dev_hdl *ndev)
 {
 	DECLARE_AIE_MSG(suspend, MSG_OP_SUSPEND);
@@ -376,7 +339,7 @@ int aie2_query_status(struct amdxdna_dev_hdl *ndev, char __user *buf,
 	int ret;
 
 	buf_sz = ndev->aie.metadata.cols * ndev->aie.metadata.size;
-	buff_addr = aie2_alloc_msg_buffer(ndev, &buf_sz, &dma_addr);
+	buff_addr = amdxdna_alloc_msg_buffer(xdna, &buf_sz, &dma_addr);
 	if (IS_ERR(buff_addr))
 		return PTR_ERR(buff_addr);
 
@@ -415,7 +378,7 @@ int aie2_query_status(struct amdxdna_dev_hdl *ndev, char __user *buf,
 	*cols_filled = aie_bitmap;
 
 fail:
-	aie2_free_msg_buffer(ndev, buf_sz, buff_addr, dma_addr);
+	amdxdna_free_msg_buffer(xdna, buf_sz, buff_addr, dma_addr);
 	return ret;
 }
 
@@ -434,7 +397,7 @@ int aie2_query_telemetry(struct amdxdna_dev_hdl *ndev,
 		return -EINVAL;
 
 	buf_sz = min(size, SZ_4M);
-	addr = aie2_alloc_msg_buffer(ndev, &buf_sz, &dma_addr);
+	addr = amdxdna_alloc_msg_buffer(xdna, &buf_sz, &dma_addr);
 	if (IS_ERR(addr))
 		return PTR_ERR(addr);
 
@@ -466,7 +429,7 @@ int aie2_query_telemetry(struct amdxdna_dev_hdl *ndev,
 	header->minor = resp.minor;
 
 free_buf:
-	aie2_free_msg_buffer(ndev, buf_sz, addr, dma_addr);
+	amdxdna_free_msg_buffer(xdna, buf_sz, addr, dma_addr);
 	return ret;
 }
 
@@ -1176,7 +1139,7 @@ int aie2_query_app_health(struct amdxdna_dev_hdl *ndev, u32 context_id,
 	}
 
 	buf_size = sizeof(*report);
-	buf = aie2_alloc_msg_buffer(ndev, &buf_size, &dma_addr);
+	buf = amdxdna_alloc_msg_buffer(xdna, &buf_size, &dma_addr);
 	if (IS_ERR(buf)) {
 		XDNA_ERR(xdna, "Failed to allocate buffer for app health");
 		return PTR_ERR(buf);
@@ -1197,7 +1160,7 @@ int aie2_query_app_health(struct amdxdna_dev_hdl *ndev, u32 context_id,
 	memcpy(report, buf, sizeof(*report));
 
 free_buf:
-	aie2_free_msg_buffer(ndev, buf_size, buf, dma_addr);
+	amdxdna_free_msg_buffer(xdna, buf_size, buf, dma_addr);
 	return ret;
 }
 
diff --git a/drivers/accel/amdxdna/aie2_pci.h b/drivers/accel/amdxdna/aie2_pci.h
index c884fed610f9..33b6c84e8b6e 100644
--- a/drivers/accel/amdxdna/aie2_pci.h
+++ b/drivers/accel/amdxdna/aie2_pci.h
@@ -290,10 +290,6 @@ int aie2_sync_bo(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *job,
 int aie2_config_debug_bo(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *job,
 			 int (*notify_cb)(void *, void __iomem *, size_t));
 int aie2_update_prop_time_quota(struct amdxdna_dev_hdl *ndev, u32 us);
-void *aie2_alloc_msg_buffer(struct amdxdna_dev_hdl *ndev, u32 *size,
-			    dma_addr_t *dma_addr);
-void aie2_free_msg_buffer(struct amdxdna_dev_hdl *ndev, size_t size,
-			  void *cpu_addr, dma_addr_t dma_addr);
 
 /* aie2_hwctx.c */
 int aie2_hwctx_init(struct amdxdna_hwctx *hwctx);
diff --git a/drivers/accel/amdxdna/aie4_message.c b/drivers/accel/amdxdna/aie4_message.c
index ac89a9a842b2..d85df04c5f6b 100644
--- a/drivers/accel/amdxdna/aie4_message.c
+++ b/drivers/accel/amdxdna/aie4_message.c
@@ -62,3 +62,21 @@ int aie4_query_aie_metadata(struct amdxdna_dev_hdl *ndev, struct aie_metadata *m
 
 	return 0;
 }
+
+int aie4_attach_work_buffer(struct amdxdna_dev_hdl *ndev)
+{
+	DECLARE_AIE_MSG(aie4_msg_attach_work_buffer, AIE4_MSG_OP_ATTACH_WORK_BUFFER);
+	struct amdxdna_dev *xdna = ndev->aie.xdna;
+	int ret;
+
+	req.buff_addr = ndev->work_buf_addr;
+	req.buff_size = AIE4_WORK_BUFFER_MIN_SIZE;
+
+	ret = aie_send_mgmt_msg_wait(&ndev->aie, &msg);
+	if (ret)
+		XDNA_ERR(xdna, "Failed to attach work buffer, ret %d", ret);
+	else
+		XDNA_DBG(xdna, "Attached work buffer");
+
+	return ret;
+}
diff --git a/drivers/accel/amdxdna/aie4_msg_priv.h b/drivers/accel/amdxdna/aie4_msg_priv.h
index 69e220e40900..af0866045b91 100644
--- a/drivers/accel/amdxdna/aie4_msg_priv.h
+++ b/drivers/accel/amdxdna/aie4_msg_priv.h
@@ -6,10 +6,12 @@
 #ifndef _AIE4_MSG_PRIV_H_
 #define _AIE4_MSG_PRIV_H_
 
+#include <linux/sizes.h>
 #include <linux/types.h>
 
 enum aie4_msg_opcode {
 	AIE4_MSG_OP_SUSPEND                          = 0x10003,
+	AIE4_MSG_OP_ATTACH_WORK_BUFFER               = 0x1000D,
 
 	AIE4_MSG_OP_CREATE_VFS                       = 0x20001,
 	AIE4_MSG_OP_DESTROY_VFS                      = 0x20002,
@@ -130,4 +132,16 @@ struct aie4_msg_aie4_tile_info_resp {
 	struct aie4_tile_info info;
 } __packed;
 
+#define AIE4_WORK_BUFFER_MIN_SIZE      SZ_4M
+
+struct aie4_msg_attach_work_buffer_req {
+	__u64 buff_addr;
+	__u32 reserved;
+	__u32 buff_size;
+} __packed;
+
+struct aie4_msg_attach_work_buffer_resp {
+	enum aie4_msg_status status;
+} __packed;
+
 #endif /* _AIE4_MSG_PRIV_H_ */
diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
index 8b5eff0e45c1..a58a83af42a4 100644
--- a/drivers/accel/amdxdna/aie4_pci.c
+++ b/drivers/accel/amdxdna/aie4_pci.c
@@ -286,8 +286,14 @@ static int aie4_pf_hw_start(struct amdxdna_dev_hdl *ndev)
 	if (ret)
 		goto stop_fw;
 
+	ret = aie4_attach_work_buffer(ndev);
+	if (ret)
+		goto mbox_fini;
+
 	return 0;
 
+mbox_fini:
+	aie4_mailbox_fini(ndev);
 stop_fw:
 	aie4_fw_stop(ndev);
 
@@ -564,6 +570,40 @@ static int aie4_get_info(struct amdxdna_client *client, struct amdxdna_drm_get_i
 	return ret;
 }
 
+static int aie4_alloc_work_buffer(struct amdxdna_dev_hdl *ndev)
+{
+	struct amdxdna_dev *xdna = ndev->aie.xdna;
+	u32 buf_size = AIE4_WORK_BUFFER_MIN_SIZE;
+
+	ndev->work_buf = amdxdna_alloc_msg_buffer(xdna, &buf_size,
+						  &ndev->work_buf_addr);
+	if (IS_ERR(ndev->work_buf)) {
+		int ret = PTR_ERR(ndev->work_buf);
+
+		XDNA_ERR(xdna, "Failed to alloc work buffer, size 0x%x",
+			 AIE4_WORK_BUFFER_MIN_SIZE);
+		ndev->work_buf = NULL;
+		return ret;
+	}
+
+	ndev->work_buf_size = buf_size;
+	XDNA_DBG(xdna, "Work buffer allocated: size 0x%x", buf_size);
+
+	return 0;
+}
+
+static void aie4_free_work_buffer(struct amdxdna_dev_hdl *ndev)
+{
+	struct amdxdna_dev *xdna = ndev->aie.xdna;
+
+	if (!ndev->work_buf)
+		return;
+
+	amdxdna_free_msg_buffer(xdna, ndev->work_buf_size, ndev->work_buf,
+				ndev->work_buf_addr);
+	ndev->work_buf = NULL;
+}
+
 static int aie4_pf_init(struct amdxdna_dev *xdna)
 {
 	int ret;
@@ -572,7 +612,19 @@ static int aie4_pf_init(struct amdxdna_dev *xdna)
 	if (ret)
 		return ret;
 
-	return aie4_pf_hw_start(xdna->dev_handle);
+	ret = aie4_alloc_work_buffer(xdna->dev_handle);
+	if (ret)
+		return ret;
+
+	ret = aie4_pf_hw_start(xdna->dev_handle);
+	if (ret)
+		goto free_work_buf;
+
+	return 0;
+
+free_work_buf:
+	aie4_free_work_buffer(xdna->dev_handle);
+	return ret;
 }
 
 static int aie4_vf_init(struct amdxdna_dev *xdna)
@@ -590,6 +642,7 @@ static void aie4_pf_fini(struct amdxdna_dev *xdna)
 {
 	aie4_sriov_stop(xdna->dev_handle);
 	aie4_pf_hw_stop(xdna->dev_handle);
+	aie4_free_work_buffer(xdna->dev_handle);
 }
 
 static void aie4_vf_fini(struct amdxdna_dev *xdna)
diff --git a/drivers/accel/amdxdna/aie4_pci.h b/drivers/accel/amdxdna/aie4_pci.h
index 1886cffc62db..390864876ca5 100644
--- a/drivers/accel/amdxdna/aie4_pci.h
+++ b/drivers/accel/amdxdna/aie4_pci.h
@@ -53,11 +53,16 @@ struct amdxdna_dev_hdl {
 
 	struct xarray                   cert_comp_xa; /* device level indexed by msix id */
 	struct mutex                    cert_comp_lock; /* protects cert_comp operations*/
+
+	void				*work_buf;
+	dma_addr_t			work_buf_addr;
+	u32				work_buf_size;
 };
 
 /* aie4_message.c */
 int aie4_query_aie_metadata(struct amdxdna_dev_hdl *ndev, struct aie_metadata *metadata);
 int aie4_suspend_fw(struct amdxdna_dev_hdl *ndev);
+int aie4_attach_work_buffer(struct amdxdna_dev_hdl *ndev);
 
 /* aie4_ctx.c */
 int aie4_hwctx_init(struct amdxdna_hwctx *hwctx);
diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdxdna/amdxdna_pci_drv.c
index c0d00db25cde..a6e9be7960c2 100644
--- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
+++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
@@ -40,9 +40,10 @@ MODULE_FIRMWARE("amdnpu/17f0_11/npu_7.sbin");
  * 0.7: Support getting power and utilization data
  * 0.8: Support BO usage query
  * 0.9: Add new device type AMDXDNA_DEV_TYPE_PF
+ * 0.10: Support AIE4 UMQ
  */
 #define AMDXDNA_DRIVER_MAJOR		0
-#define AMDXDNA_DRIVER_MINOR		9
+#define AMDXDNA_DRIVER_MINOR		10
 
 /*
  * Bind the driver base on (vendor_id, device_id) pair and later use the
-- 
2.34.1

