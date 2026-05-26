Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD13ECD5BB1
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 17:30:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C4CE10E1D2;
	Tue, 26 May 2026 17:30:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mjnU024l";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013016.outbound.protection.outlook.com
 [40.107.201.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 458B310E1D2
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 17:30:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z6RlkPK/MohhyrTMynXYf4/OABVzjWChG5IzLzK7WUy03wgdZ0/9cgZQxzDAqSwbzmX6PTRiOmfuV5OSbhJY7VaMmuxXRw4XUo51jW6gGGhBLLRsJtCnk6xhrVFzJij0EKaQtqxoBxTDBzoBoFHb6OHvPHI19tG9eaWLOObbOYpvo0FJ/qfX1fhR1gtWXl04WHr7meIVgCG7mUKi4gHTWa/iolRCBr5rLKT2525N07dxU3O8fzJa+ltrG68ffPvwx5MruG7XbAdiGEUCTxHfkykjUSTHo1b2sMmvp2+RXMDSW5acmg9ixwVZFcrdK1LLVqJUDAIqSBNEMUIegyuUrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6xJQmInS9WDz6kwlKb/R0xiJvzEJv5/A6mmlaBRk8r0=;
 b=JXtgfrGDYRpVrJLEtErKeUttb8ePKDFJf8Z0aUh0CBxq6nXr02iqID+vZJFb4JTSAAtj+DmzsHTE45tnGpRY9CyBMSvRrYVvjrHvltXClikvk/dQ3YUP91zvczialqEnF9WXqGZOlqbRMxTTpLnvYRhEfRXEf8nwhE/8QauUL2878teOLpwcQiZvwogjKaQr/po3Yj6shlcMvcmnKvd2bkpZG8sf8MD2j1KX405n63mArxEyETFcWlA0wthyxxtw7JbAk+Wk4+Bp8SVX7IIQEFIaubTQ9ir2FMkA6q6nnp88EBLnyiLobN4HxVyxoaKPV/LVgOQskVsTl0n6EBx30Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6xJQmInS9WDz6kwlKb/R0xiJvzEJv5/A6mmlaBRk8r0=;
 b=mjnU024l9SP9SZj7Btn8BQ3mBqwZwrAZcb/KErKBSvmTKvCKe4J7/WjKDzkP9B/3T0vXDnvjuGxYRIKV+zLCIii8rJS2Jim3JmZJFolMwyYfDtIpCyDqnXVtLipMn7HG6iM84YHgvjE2NUpEPhTMPGczj8gu5NJmaWXX/dmuTZY=
Received: from MN2PR11CA0013.namprd11.prod.outlook.com (2603:10b6:208:23b::18)
 by PH0PR12MB7094.namprd12.prod.outlook.com (2603:10b6:510:21d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 17:30:07 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:208:23b:cafe::af) by MN2PR11CA0013.outlook.office365.com
 (2603:10b6:208:23b::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.12 via Frontend Transport; Tue, 26
 May 2026 17:30:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 17:30:07 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 12:30:06 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 26 May 2026 12:30:06 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>
CC: Nishad Saraf <nishads@amd.com>, <linux-kernel@vger.kernel.org>,
 <max.zhen@amd.com>, <sonal.santan@amd.com>, Lizhi Hou <lizhi.hou@amd.com>
Subject: [PATCH V1] accel/amdxdna: add AIE coredump support
Date: Tue, 26 May 2026 10:29:43 -0700
Message-ID: <20260526172943.1776017-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|PH0PR12MB7094:EE_
X-MS-Office365-Filtering-Correlation-Id: d93a5f92-cd2f-42de-7085-08debb4c6e45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|3023799007|5023799004|11063799006|6133799003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: HOIFuXmVKiYiI5zWz9id1frx9xs/5bLXOcIkrG7xikaIciBK2L5T6ROjFqPth49x5F+IqoMPcWf1ZYqvvjqDVmUycW4Yhfe3hBxbym8PqcVC58I2bMWLd4oE1NT6kMCi0D6wCL/jgfPBIZL39pxYgMctoSx7iKOh2qBCTf0oZduubW9zqjiAARRXj1M0N0TP+QJ9h7E6fZfu9EpfmBY5/1BJsqOmpei2cnigIJd+wVYv/+c5TQjRLTai9gRjRz4gkg3cK9HD7TacNKj+8hk2mHZ+ekH4dkgtzZyJ4Y2K4yfrVBs57uGS77uPSkF2ogw1IYDvfOIxeK0B8IQL1vgWaCjUeL8e8UDjv5oW6quO+H+p8bYPzVypbcbTDBeUwhaFaPLDYuvDYg8ilZi3h8e9w5BNzrDt5QujQatJUvCYz/LQ4rwLKsnNJNKyvtBf9799nOH4VPQsJ/JBYVhwoWETeN/GqHu/0lZYqn2WSo+ZZ0YMn+TCYwWhyfzG0OY4WGEhCYfhwjhjNqDl8orEz9dP8py3zOxCzlexaKMqJTjtQWxygnr4XVn1ajSvvpcR6/2Vp1nnXe4jpmraurYiuKDUzR+eHxfGx0Snmunul5Ry0QJ/Ro1KBdKDMUWinieBr0tzhlxLGaBbFMVLKwko5tuGT8eoTnALlrV5VIBIA6tMFnqbkd16M5e0qf584E9zR1hTH3/9orfv2Iej+6OCU17vq2W9L5kXZJDeKw+j7hJLylw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(3023799007)(5023799004)(11063799006)(6133799003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Vf6iOMuorOa6rNPIwXrR2MrgjMpXnQyxX3ezjB3bdyDBGgPk8/UFdWQrYjfRIJNN558Ylo8geIQroWOIEvnoqwZ4PUNTBg76CCKJxBC6QhQN2EkwyFmhOGHBMWuy0GGeWH+zXhDMmDPQhfi3Jqz8T1flcx0MswoVfkPv0JtKBFeEkyafNmeCNPao9Wri3Y6/ovX0rrYf+R0cX0BwG4GWDJFy4iI6imrF101AzU20wBEXZKXO8zTQyTbPeTM1PMcJp12HvDd6At1YQ0JKxSriMIbkk8buDPfLT3EW5G3R2h1x+O7kxNtu3IAeoQczs/cgvlSpWcsoleWimSDtVDZ4/OrlIIyzyNcs+1W5Y3EidM9CIyXPRyyTXHImzPm85pKYcn8Vy1VvGymtCvyTEVcxI3UbSTPaaPkQduT5vg3IV7xVDPEY+GaNKvuXwa7SiZvE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 17:30:07.4724 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d93a5f92-cd2f-42de-7085-08debb4c6e45
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7094
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

Implement AIE coredump to capture per-context tile memory snapshots
for post-mortem hardware debugging. The new DRM_AMDXDNA_AIE_COREDUMP
parameter in the GET_ARRAY ioctl returns coredump data for a given
hardware context. Access is restricted so that users may only coredump
their own contexts; admin users may coredump any context.

Signed-off-by: Nishad Saraf <nishads@amd.com>
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/aie.c             | 214 +++++++++++++++++++++---
 drivers/accel/amdxdna/aie.h             |  31 +++-
 drivers/accel/amdxdna/aie2_error.c      |  22 +--
 drivers/accel/amdxdna/aie2_message.c    | 104 +++++++-----
 drivers/accel/amdxdna/aie2_msg_priv.h   |  15 ++
 drivers/accel/amdxdna/aie2_pci.c        |   5 +
 drivers/accel/amdxdna/aie2_pci.h        |   4 +
 drivers/accel/amdxdna/aie4_message.c    |  33 +++-
 drivers/accel/amdxdna/aie4_msg_priv.h   |  13 ++
 drivers/accel/amdxdna/aie4_pci.c        |  57 +++++--
 drivers/accel/amdxdna/aie4_pci.h        |  13 +-
 drivers/accel/amdxdna/amdxdna_ctx.h     |   1 +
 drivers/accel/amdxdna/amdxdna_pci_drv.c |   3 +-
 drivers/accel/amdxdna/amdxdna_pci_drv.h |   4 +
 drivers/accel/amdxdna/npu3_regs.c       |   1 +
 include/uapi/drm/amdxdna_accel.h        |  26 +++
 16 files changed, 451 insertions(+), 95 deletions(-)

diff --git a/drivers/accel/amdxdna/aie.c b/drivers/accel/amdxdna/aie.c
index dd6f36f222c7..bf1243285920 100644
--- a/drivers/accel/amdxdna/aie.c
+++ b/drivers/accel/amdxdna/aie.c
@@ -3,9 +3,12 @@
  * Copyright (C) 2026, Advanced Micro Devices, Inc.
  */
 
+#include <drm/drm_cache.h>
+#include <linux/cred.h>
 #include <linux/errno.h>
 
 #include "aie.h"
+#include "amdxdna_ctx.h"
 #include "amdxdna_mailbox_helper.h"
 #include "amdxdna_mailbox.h"
 #include "amdxdna_pci_drv.h"
@@ -132,36 +135,209 @@ int amdxdna_get_metadata(struct aie_device *aie,
 	return ret;
 }
 
-void *amdxdna_alloc_msg_buffer(struct amdxdna_dev *xdna, u32 *size,
-			       dma_addr_t *dma_addr)
+struct amdxdna_msg_buf_hdl *amdxdna_alloc_msg_buffer(struct amdxdna_dev *xdna, u32 size)
 {
-	void *vaddr;
+	struct amdxdna_msg_buf_hdl *hdl;
 	int order;
 
-	*size = max_t(u32, *size, SZ_8K);
-	order = get_order(*size);
+	hdl = kzalloc_obj(*hdl);
+	if (!hdl)
+		return ERR_PTR(-ENOMEM);
+
+	hdl->xdna = xdna;
+	hdl->size = max_t(u32, size, SZ_8K);
+	order = get_order(hdl->size);
 	if (order > MAX_PAGE_ORDER)
-		return ERR_PTR(-EINVAL);
-	*size = PAGE_SIZE << order;
+		goto free_hdl;
+	hdl->size = PAGE_SIZE << order;
 
-	if (amdxdna_iova_on(xdna))
-		return amdxdna_iommu_alloc(xdna, *size, dma_addr);
+	if (amdxdna_iova_on(xdna)) {
+		hdl->vaddr = amdxdna_iommu_alloc(xdna, hdl->size, &hdl->dma_addr);
+		if (IS_ERR(hdl->vaddr))
+			goto free_hdl;
+	} else {
+		hdl->vaddr = dma_alloc_noncoherent(xdna->ddev.dev, hdl->size,
+						   &hdl->dma_addr,
+						   DMA_FROM_DEVICE, GFP_KERNEL);
+		if (!hdl->vaddr)
+			goto free_hdl;
+	}
 
-	vaddr = dma_alloc_noncoherent(xdna->ddev.dev, *size, dma_addr,
-				      DMA_FROM_DEVICE, GFP_KERNEL);
-	if (!vaddr)
-		return ERR_PTR(-ENOMEM);
+	return hdl;
 
-	return vaddr;
+free_hdl:
+	kfree(hdl);
+	return ERR_PTR(-ENOMEM);
 }
 
-void amdxdna_free_msg_buffer(struct amdxdna_dev *xdna, size_t size,
-			     void *cpu_addr, dma_addr_t dma_addr)
+void amdxdna_free_msg_buffer(struct amdxdna_msg_buf_hdl *hdl)
 {
-	if (amdxdna_iova_on(xdna)) {
-		amdxdna_iommu_free(xdna, size, cpu_addr, dma_addr);
+	if (!hdl)
 		return;
+
+	if (amdxdna_iova_on(hdl->xdna)) {
+		amdxdna_iommu_free(hdl->xdna, hdl->size, hdl->vaddr,
+				   hdl->dma_addr);
+	} else {
+		dma_free_noncoherent(hdl->xdna->ddev.dev, hdl->size,
+				     hdl->vaddr, hdl->dma_addr,
+				     DMA_FROM_DEVICE);
+	}
+
+	kfree(hdl);
+}
+
+struct amdxdna_coredump_walk_arg {
+	u64				pid;
+	u32				ctx_id;
+
+	struct aie_device		*aie;
+	struct amdxdna_drm_get_array	*array_args;
+};
+
+static int amdxdna_get_coredump_cb(struct amdxdna_hwctx *hwctx, void *arg)
+{
+	struct amdxdna_dev *xdna = hwctx->client->xdna;
+	struct amdxdna_coredump_buf_entry *buf_list;
+	struct amdxdna_coredump_walk_arg *wa = arg;
+	struct amdxdna_msg_buf_hdl **data_hdls;
+	struct amdxdna_msg_buf_hdl *list_hdl;
+	struct aie_device *aie = wa->aie;
+	size_t data_buf_size = SZ_1M;
+	size_t total_size;
+	u8 __user *buf;
+	u32 num_bufs;
+	int ret, i;
+
+	if (hwctx->client->pid != wa->pid || hwctx->id != wa->ctx_id)
+		return 0;
+
+	if (!capable(CAP_SYS_ADMIN) &&
+	    !uid_eq(current_euid(), hwctx->client->filp->filp->f_cred->euid)) {
+		XDNA_ERR(xdna, "Permission denied for context %u", wa->ctx_id);
+		return -EPERM;
+	}
+
+	num_bufs = (hwctx->num_col - hwctx->num_unused_col) * aie->metadata.rows;
+	total_size = data_buf_size * num_bufs;
+
+	if (wa->array_args->element_size < total_size) {
+		XDNA_DBG(xdna, "Insufficient buffer size %u, need %zu",
+			 wa->array_args->element_size, total_size);
+		wa->array_args->element_size = total_size;
+		return -ENOSPC;
+	}
+
+	list_hdl = amdxdna_alloc_msg_buffer(xdna, num_bufs * sizeof(*buf_list));
+	if (IS_ERR(list_hdl)) {
+		XDNA_ERR(xdna, "Failed to allocate buffer list");
+		return PTR_ERR(list_hdl);
+	}
+
+	buf_list = to_cpu_addr(list_hdl, 0);
+	memset(buf_list, 0, to_buf_size(list_hdl));
+
+	data_hdls = kzalloc_objs(*data_hdls, num_bufs);
+	if (!data_hdls) {
+		ret = -ENOMEM;
+		goto free_list_hdl;
+	}
+
+	for (i = 0; i < num_bufs; i++) {
+		data_hdls[i] = amdxdna_alloc_msg_buffer(xdna, data_buf_size);
+		if (IS_ERR(data_hdls[i])) {
+			XDNA_ERR(xdna, "Failed to allocate data buffer %d", i);
+			ret = PTR_ERR(data_hdls[i]);
+			data_hdls[i] = NULL;
+			goto free_data_hdls;
+		}
+
+		memset(to_cpu_addr(data_hdls[i], 0), 0, data_buf_size);
+		drm_clflush_virt_range(to_cpu_addr(data_hdls[i], 0), data_buf_size);
+
+		buf_list[i].buf_addr = to_dma_addr(data_hdls[i], 0);
+		buf_list[i].buf_size = data_buf_size;
+	}
+
+	drm_clflush_virt_range(buf_list, to_buf_size(list_hdl));
+
+	ret = aie->msg_ops.get_coredump(hwctx, list_hdl, num_bufs);
+	if (ret) {
+		XDNA_ERR(xdna, "Failed to get coredump from firmware, ret=%d",
+			 ret);
+		goto free_data_hdls;
+	}
+
+	buf = u64_to_user_ptr(wa->array_args->buffer);
+	for (i = 0; i < num_bufs; i++) {
+		if (copy_to_user(buf, to_cpu_addr(data_hdls[i], 0),
+				 data_buf_size)) {
+			ret = -EFAULT;
+			goto free_data_hdls;
+		}
+		buf += data_buf_size;
+	}
+
+free_data_hdls:
+	for (i = 0; i < num_bufs; i++)
+		amdxdna_free_msg_buffer(data_hdls[i]);
+	kfree(data_hdls);
+free_list_hdl:
+	amdxdna_free_msg_buffer(list_hdl);
+	return ret ? ret : 1;
+}
+
+int amdxdna_get_coredump(struct aie_device *aie,
+			 struct amdxdna_drm_get_array *args)
+{
+	struct amdxdna_client *ctx_client = NULL;
+	struct amdxdna_drm_aie_coredump config;
+	struct amdxdna_dev *xdna = aie->xdna;
+	struct amdxdna_coredump_walk_arg wa;
+	int ret;
+
+	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
+
+	if (!aie->msg_ops.get_coredump) {
+		XDNA_DBG(xdna, "Get coredump unsupported");
+		return -EOPNOTSUPP;
+	}
+	if (args->num_element != 1) {
+		XDNA_ERR(xdna, "Invalid num_element %u, expected 1",
+			 args->num_element);
+		return -EINVAL;
+	}
+
+	if (args->element_size < sizeof(config)) {
+		XDNA_ERR(xdna, "Invalid buffer size: %d", args->element_size);
+		return -EINVAL;
+	}
+
+	if (copy_from_user(&config, u64_to_user_ptr(args->buffer), sizeof(config))) {
+		XDNA_ERR(xdna, "Failed to copy coredump config from user");
+		return -EFAULT;
+	}
+
+	if (XDNA_MBZ_DBG(xdna, &config.pad, sizeof(config.pad)))
+		return -EINVAL;
+
+	XDNA_DBG(xdna, "AIE Coredump request for context_id=%u pid=%llu",
+		 config.context_id, config.pid);
+
+	wa.aie = aie;
+	wa.pid = config.pid;
+	wa.ctx_id = config.context_id;
+	wa.array_args = args;
+	amdxdna_for_each_client(xdna, ctx_client) {
+		ret = amdxdna_hwctx_walk(ctx_client, &wa, amdxdna_get_coredump_cb);
+		if (ret)
+			break;
+	}
+
+	if (!ret) {
+		XDNA_DBG(xdna, "Context not found");
+		return -EINVAL;
 	}
 
-	dma_free_noncoherent(xdna->ddev.dev, size, cpu_addr, dma_addr, DMA_FROM_DEVICE);
+	return (ret > 0) ? 0 : ret;
 }
diff --git a/drivers/accel/amdxdna/aie.h b/drivers/accel/amdxdna/aie.h
index 0483d582b7f8..d088030a2f31 100644
--- a/drivers/accel/amdxdna/aie.h
+++ b/drivers/accel/amdxdna/aie.h
@@ -15,6 +15,12 @@
 struct psp_device;
 struct smu_device;
 
+struct aie_msg_ops {
+	int (*get_coredump)(struct amdxdna_hwctx *hwctx,
+			    struct amdxdna_msg_buf_hdl *list_hdl,
+			    u32 num_bufs);
+};
+
 struct aie_device {
 	struct amdxdna_dev *xdna;
 	struct mailbox_channel *mgmt_chann;
@@ -29,6 +35,7 @@ struct aie_device {
 	struct smu_device *smu_hdl;
 
 	struct amdxdna_drm_query_aie_metadata metadata;
+	struct aie_msg_ops msg_ops;
 };
 
 #define DECLARE_AIE_MSG(name, op) \
@@ -91,6 +98,23 @@ struct amdxdna_rev_vbnv {
 	const char	*vbnv;
 };
 
+struct amdxdna_coredump_buf_entry {
+	__u64			buf_addr;
+	__u32			buf_size;
+	__u32			reserved;
+} __packed;
+
+struct amdxdna_msg_buf_hdl {
+	struct amdxdna_dev	*xdna;
+	void			*vaddr;
+	dma_addr_t		dma_addr;
+	u32			size;
+};
+
+#define to_cpu_addr(hdl, offset)  ((hdl)->vaddr + (offset))
+#define to_dma_addr(hdl, offset)  ((hdl)->dma_addr + (offset))
+#define to_buf_size(hdl)          ((hdl)->size)
+
 /* aie.c */
 void aie_dump_mgmt_chann_debug(struct aie_device *aie);
 void aie_destroy_chann(struct aie_device *aie, struct mailbox_channel **chann);
@@ -99,10 +123,9 @@ int aie_check_protocol(struct aie_device *aie, u32 fw_major, u32 fw_minor);
 void amdxdna_vbnv_init(struct amdxdna_dev *xdna);
 int amdxdna_get_metadata(struct aie_device *aie, struct amdxdna_client *client,
 			 struct amdxdna_drm_get_info *args);
-void *amdxdna_alloc_msg_buffer(struct amdxdna_dev *xdna, u32 *size,
-			       dma_addr_t *dma_addr);
-void amdxdna_free_msg_buffer(struct amdxdna_dev *xdna, size_t size,
-			     void *cpu_addr, dma_addr_t dma_addr);
+struct amdxdna_msg_buf_hdl *amdxdna_alloc_msg_buffer(struct amdxdna_dev *xdna, u32 size);
+void amdxdna_free_msg_buffer(struct amdxdna_msg_buf_hdl *hdl);
+int amdxdna_get_coredump(struct aie_device *aie, struct amdxdna_drm_get_array *args);
 
 /* aie_psp.c */
 struct psp_device *aiem_psp_create(struct drm_device *ddev, struct psp_config *conf);
diff --git a/drivers/accel/amdxdna/aie2_error.c b/drivers/accel/amdxdna/aie2_error.c
index babdac0157ab..8030a3293e5d 100644
--- a/drivers/accel/amdxdna/aie2_error.c
+++ b/drivers/accel/amdxdna/aie2_error.c
@@ -30,9 +30,7 @@ struct async_event {
 
 struct async_events {
 	struct workqueue_struct		*wq;
-	u8				*buf;
-	dma_addr_t			addr;
-	u32				size;
+	struct amdxdna_msg_buf_hdl	*hdl;
 	u32				event_cnt;
 	struct async_event		event[] __counted_by(event_cnt);
 };
@@ -339,7 +337,7 @@ void aie2_error_async_events_free(struct amdxdna_dev_hdl *ndev)
 	destroy_workqueue(events->wq);
 	mutex_lock(&xdna->dev_lock);
 
-	amdxdna_free_msg_buffer(xdna, events->size, events->buf, events->addr);
+	amdxdna_free_msg_buffer(events->hdl);
 	kfree(events);
 }
 
@@ -347,7 +345,6 @@ int aie2_error_async_events_alloc(struct amdxdna_dev_hdl *ndev)
 {
 	struct amdxdna_dev *xdna = ndev->aie.xdna;
 	u32 total_col = ndev->total_col;
-	u32 total_size = ASYNC_BUF_SIZE * total_col;
 	struct async_events *events;
 	int i, ret;
 
@@ -355,12 +352,11 @@ int aie2_error_async_events_alloc(struct amdxdna_dev_hdl *ndev)
 	if (!events)
 		return -ENOMEM;
 
-	events->buf = amdxdna_alloc_msg_buffer(xdna, &total_size, &events->addr);
-	if (IS_ERR(events->buf)) {
-		ret = PTR_ERR(events->buf);
+	events->hdl = amdxdna_alloc_msg_buffer(xdna, ASYNC_BUF_SIZE * total_col);
+	if (IS_ERR(events->hdl)) {
+		ret = PTR_ERR(events->hdl);
 		goto free_events;
 	}
-	events->size = total_size;
 	events->event_cnt = total_col;
 
 	events->wq = alloc_ordered_workqueue("async_wq", 0);
@@ -375,8 +371,8 @@ int aie2_error_async_events_alloc(struct amdxdna_dev_hdl *ndev)
 
 		e->ndev = ndev;
 		e->wq = events->wq;
-		e->buf = &events->buf[offset];
-		e->addr = events->addr + offset;
+		e->buf = to_cpu_addr(events->hdl, offset);
+		e->addr = to_dma_addr(events->hdl, offset);
 		e->size = ASYNC_BUF_SIZE;
 		e->resp.status = MAX_AIE2_STATUS_CODE;
 		INIT_WORK(&e->work, aie2_error_worker);
@@ -389,13 +385,13 @@ int aie2_error_async_events_alloc(struct amdxdna_dev_hdl *ndev)
 	ndev->async_events = events;
 
 	XDNA_DBG(xdna, "Async event count %d, buf total size 0x%x",
-		 events->event_cnt, events->size);
+		 events->event_cnt, to_buf_size(events->hdl));
 	return 0;
 
 free_wq:
 	destroy_workqueue(events->wq);
 free_buf:
-	amdxdna_free_msg_buffer(xdna, events->size, events->buf, events->addr);
+	amdxdna_free_msg_buffer(events->hdl);
 free_events:
 	kfree(events);
 	return ret;
diff --git a/drivers/accel/amdxdna/aie2_message.c b/drivers/accel/amdxdna/aie2_message.c
index c4b364801cc0..6d9f00742c22 100644
--- a/drivers/accel/amdxdna/aie2_message.c
+++ b/drivers/accel/amdxdna/aie2_message.c
@@ -368,28 +368,27 @@ int aie2_query_status(struct amdxdna_dev_hdl *ndev, char __user *buf,
 {
 	DECLARE_AIE_MSG(aie_column_info, MSG_OP_QUERY_COL_STATUS);
 	struct amdxdna_dev *xdna = ndev->aie.xdna;
-	u32 buf_sz, aie_bitmap = 0;
+	struct amdxdna_msg_buf_hdl *buf_hdl;
 	struct amdxdna_client *client;
-	dma_addr_t dma_addr;
-	u8 *buff_addr;
+	u32 aie_bitmap = 0;
 	int ret;
 
-	buf_sz = ndev->aie.metadata.cols * ndev->aie.metadata.col_size;
-	buff_addr = amdxdna_alloc_msg_buffer(xdna, &buf_sz, &dma_addr);
-	if (IS_ERR(buff_addr))
-		return PTR_ERR(buff_addr);
+	buf_hdl = amdxdna_alloc_msg_buffer(xdna, ndev->aie.metadata.cols *
+					   ndev->aie.metadata.col_size);
+	if (IS_ERR(buf_hdl))
+		return PTR_ERR(buf_hdl);
 
 	/* Go through each hardware context and mark the AIE columns that are active */
 	list_for_each_entry(client, &xdna->client_list, node)
 		amdxdna_hwctx_walk(client, &aie_bitmap, amdxdna_hwctx_col_map);
 
 	*cols_filled = 0;
-	req.dump_buff_addr = dma_addr;
-	req.dump_buff_size = buf_sz;
+	req.dump_buff_addr = to_dma_addr(buf_hdl, 0);
+	req.dump_buff_size = to_buf_size(buf_hdl);
 	req.num_cols = hweight32(aie_bitmap);
 	req.aie_bitmap = aie_bitmap;
 
-	drm_clflush_virt_range(buff_addr, req.dump_buff_size); /* device can access */
+	drm_clflush_virt_range(to_cpu_addr(buf_hdl, 0), req.dump_buff_size);
 	ret = aie_send_mgmt_msg_wait(&ndev->aie, &msg);
 	if (ret) {
 		XDNA_ERR(xdna, "Error during NPU query, status %d", ret);
@@ -398,14 +397,15 @@ int aie2_query_status(struct amdxdna_dev_hdl *ndev, char __user *buf,
 
 	XDNA_DBG(xdna, "Query NPU status completed");
 
-	if (buf_sz < resp.size) {
+	if (to_buf_size(buf_hdl) < resp.size) {
 		ret = -EINVAL;
-		XDNA_ERR(xdna, "Bad buffer size. Available: %u. Needs: %u", buf_sz, resp.size);
+		XDNA_ERR(xdna, "Bad buffer size. Available: %u. Needs: %u",
+			 to_buf_size(buf_hdl), resp.size);
 		goto fail;
 	}
 
 	size = min(size, resp.size);
-	if (copy_to_user(buf, buff_addr, size)) {
+	if (copy_to_user(buf, to_cpu_addr(buf_hdl, 0), size)) {
 		ret = -EFAULT;
 		XDNA_ERR(xdna, "Failed to copy NPU status to user space");
 		goto fail;
@@ -414,7 +414,7 @@ int aie2_query_status(struct amdxdna_dev_hdl *ndev, char __user *buf,
 	*cols_filled = aie_bitmap;
 
 fail:
-	amdxdna_free_msg_buffer(xdna, buf_sz, buff_addr, dma_addr);
+	amdxdna_free_msg_buffer(buf_hdl);
 	return ret;
 }
 
@@ -424,38 +424,36 @@ int aie2_query_telemetry(struct amdxdna_dev_hdl *ndev,
 {
 	DECLARE_AIE_MSG(get_telemetry, MSG_OP_GET_TELEMETRY);
 	struct amdxdna_dev *xdna = ndev->aie.xdna;
-	dma_addr_t dma_addr;
-	u32 buf_sz;
-	u8 *addr;
+	struct amdxdna_msg_buf_hdl *buf_hdl;
 	int ret;
 
 	if (header->type >= MAX_TELEMETRY_TYPE)
 		return -EINVAL;
 
-	buf_sz = min(size, SZ_4M);
-	addr = amdxdna_alloc_msg_buffer(xdna, &buf_sz, &dma_addr);
-	if (IS_ERR(addr))
-		return PTR_ERR(addr);
+	buf_hdl = amdxdna_alloc_msg_buffer(xdna, min(size, SZ_4M));
+	if (IS_ERR(buf_hdl))
+		return PTR_ERR(buf_hdl);
 
-	req.buf_addr = dma_addr;
-	req.buf_size = buf_sz;
+	req.buf_addr = to_dma_addr(buf_hdl, 0);
+	req.buf_size = to_buf_size(buf_hdl);
 	req.type = header->type;
 
-	drm_clflush_virt_range(addr, req.buf_size); /* device can access */
+	drm_clflush_virt_range(to_cpu_addr(buf_hdl, 0), req.buf_size);
 	ret = aie_send_mgmt_msg_wait(&ndev->aie, &msg);
 	if (ret) {
 		XDNA_ERR(xdna, "Query telemetry failed, status %d", ret);
 		goto free_buf;
 	}
 
-	if (buf_sz < resp.size) {
+	if (to_buf_size(buf_hdl) < resp.size) {
 		ret = -EINVAL;
-		XDNA_ERR(xdna, "Bad buffer size. Available: %u. Needs: %u", buf_sz, resp.size);
+		XDNA_ERR(xdna, "Bad buffer size. Available: %u. Needs: %u",
+			 to_buf_size(buf_hdl), resp.size);
 		goto free_buf;
 	}
 
 	size = min(size, resp.size);
-	if (copy_to_user(buf, addr, size)) {
+	if (copy_to_user(buf, to_cpu_addr(buf_hdl, 0), size)) {
 		ret = -EFAULT;
 		XDNA_ERR(xdna, "Failed to copy telemetry to user space");
 		goto free_buf;
@@ -465,7 +463,7 @@ int aie2_query_telemetry(struct amdxdna_dev_hdl *ndev,
 	header->minor = resp.minor;
 
 free_buf:
-	amdxdna_free_msg_buffer(xdna, buf_sz, addr, dma_addr);
+	amdxdna_free_msg_buffer(buf_hdl);
 	return ret;
 }
 
@@ -916,6 +914,9 @@ void aie2_msg_init(struct amdxdna_dev_hdl *ndev)
 		ndev->exec_msg_ops = &npu_exec_message_ops;
 	else
 		ndev->exec_msg_ops = &legacy_exec_message_ops;
+
+	if (AIE_FEATURE_ON(&ndev->aie, AIE2_GET_COREDUMP))
+		ndev->aie.msg_ops.get_coredump = aie2_get_aie_coredump;
 }
 
 static inline struct amdxdna_gem_obj *
@@ -1164,9 +1165,7 @@ int aie2_query_app_health(struct amdxdna_dev_hdl *ndev, u32 context_id,
 {
 	DECLARE_AIE_MSG(get_app_health, MSG_OP_GET_APP_HEALTH);
 	struct amdxdna_dev *xdna = ndev->aie.xdna;
-	struct app_health_report *buf;
-	dma_addr_t dma_addr;
-	u32 buf_size;
+	struct amdxdna_msg_buf_hdl *buf_hdl;
 	int ret;
 
 	if (!AIE_FEATURE_ON(&ndev->aie, AIE2_APP_HEALTH)) {
@@ -1174,18 +1173,17 @@ int aie2_query_app_health(struct amdxdna_dev_hdl *ndev, u32 context_id,
 		return -EOPNOTSUPP;
 	}
 
-	buf_size = sizeof(*report);
-	buf = amdxdna_alloc_msg_buffer(xdna, &buf_size, &dma_addr);
-	if (IS_ERR(buf)) {
+	buf_hdl = amdxdna_alloc_msg_buffer(xdna, sizeof(*report));
+	if (IS_ERR(buf_hdl)) {
 		XDNA_ERR(xdna, "Failed to allocate buffer for app health");
-		return PTR_ERR(buf);
+		return PTR_ERR(buf_hdl);
 	}
 
-	req.buf_addr = dma_addr;
+	req.buf_addr = to_dma_addr(buf_hdl, 0);
 	req.context_id = context_id;
-	req.buf_size = buf_size;
+	req.buf_size = to_buf_size(buf_hdl);
 
-	drm_clflush_virt_range(buf, req.buf_size);
+	drm_clflush_virt_range(to_cpu_addr(buf_hdl, 0), req.buf_size);
 	ret = aie_send_mgmt_msg_wait(&ndev->aie, &msg);
 	if (ret) {
 		XDNA_ERR(xdna, "Get app health failed, ret %d status 0x%x", ret, resp.status);
@@ -1193,10 +1191,10 @@ int aie2_query_app_health(struct amdxdna_dev_hdl *ndev, u32 context_id,
 	}
 
 	/* Copy the report to caller's buffer */
-	memcpy(report, buf, sizeof(*report));
+	memcpy(report, to_cpu_addr(buf_hdl, 0), sizeof(*report));
 
 free_buf:
-	amdxdna_free_msg_buffer(xdna, buf_size, buf, dma_addr);
+	amdxdna_free_msg_buffer(buf_hdl);
 	return ret;
 }
 
@@ -1268,3 +1266,29 @@ int aie2_get_dev_revision(struct amdxdna_dev_hdl *ndev, enum aie2_dev_revision *
 	XDNA_DBG(xdna, "Device revision: %d (raw fuse: 0x%x)", *rev, resp.raw_fuse_data);
 	return 0;
 }
+
+int aie2_get_aie_coredump(struct amdxdna_hwctx *hwctx,
+			  struct amdxdna_msg_buf_hdl *list_hdl,
+			  u32 num_bufs)
+{
+	DECLARE_AIE_MSG(get_coredump, MSG_OP_GET_COREDUMP);
+	struct amdxdna_dev *xdna = hwctx->client->xdna;
+	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
+	int ret;
+
+	req.context_id = hwctx->fw_ctx_id;
+	req.num_bufs = num_bufs;
+	req.list_addr = to_dma_addr(list_hdl, 0);
+	req.list_size = to_buf_size(list_hdl);
+
+	ret = aie_send_mgmt_msg_wait(&ndev->aie, &msg);
+	if (ret) {
+		if (resp.status == AIE2_STATUS_MGMT_ERT_DRAM_BUFFER_SIZE_INVALID)
+			XDNA_ERR(xdna, "Invalid buffer size(required 0x%x) for get coredump",
+				 resp.required_buffer_size);
+		else
+			XDNA_ERR(xdna, "Get coredump got status 0x%x", resp.status);
+	}
+
+	return ret;
+}
diff --git a/drivers/accel/amdxdna/aie2_msg_priv.h b/drivers/accel/amdxdna/aie2_msg_priv.h
index fd65a4236d49..4d8f9ebd7fa2 100644
--- a/drivers/accel/amdxdna/aie2_msg_priv.h
+++ b/drivers/accel/amdxdna/aie2_msg_priv.h
@@ -35,6 +35,7 @@ enum aie2_msg_opcode {
 	MSG_OP_GET_APP_HEALTH              = 0x114,
 	MSG_OP_ADD_HOST_BUFFER             = 0x115,
 	MSG_OP_GET_DEV_REVISION            = 0x117,
+	MSG_OP_GET_COREDUMP                = 0x119,
 	MSG_OP_MAX_DRV_OPCODE,
 	MSG_OP_GET_PROTOCOL_VERSION        = 0x301,
 	MSG_OP_MAX_OPCODE
@@ -64,6 +65,7 @@ enum aie2_msg_status {
 	AIE2_STATUS_MGMT_ERT_ENTER_SUSPEND_FAILURE,
 	AIE2_STATUS_MGMT_ERT_BUSY,
 	AIE2_STATUS_MGMT_ERT_APPLICATION_ACTIVE,
+	AIE2_STATUS_MGMT_ERT_DRAM_BUFFER_SIZE_INVALID,
 	MAX_MGMT_ERT_STATUS_CODE,
 	/* APP ERT Error codes */
 	AIE2_STATUS_APP_ERT_FIRST_ERROR			= 0x3000001,
@@ -543,4 +545,17 @@ struct get_dev_revision_resp {
 	__u32			raw_fuse_data;
 } __packed;
 
+struct get_coredump_req {
+	__u32		context_id;
+	__u32		num_bufs;
+	__u64		list_addr;
+	__u32		list_size;
+} __packed;
+
+struct get_coredump_resp {
+	enum aie2_msg_status	status;
+	__u32			required_buffer_size;
+	__u32			reserved[7];
+} __packed;
+
 #endif /* _AIE2_MSG_PRIV_H_ */
diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
index c4d345d4c76b..7dea21a9e915 100644
--- a/drivers/accel/amdxdna/aie2_pci.c
+++ b/drivers/accel/amdxdna/aie2_pci.c
@@ -20,6 +20,7 @@
 #include <linux/xarray.h>
 #include <asm/hypervisor.h>
 
+#include "aie.h"
 #include "aie2_msg_priv.h"
 #include "aie2_pci.h"
 #include "aie2_solver.h"
@@ -1088,6 +1089,7 @@ static int aie2_query_ctx_status_array(struct amdxdna_client *client,
 static int aie2_get_array(struct amdxdna_client *client,
 			  struct amdxdna_drm_get_array *args)
 {
+	struct amdxdna_dev_hdl *ndev = client->xdna->dev_handle;
 	struct amdxdna_dev *xdna = client->xdna;
 	int ret, idx;
 
@@ -1105,6 +1107,9 @@ static int aie2_get_array(struct amdxdna_client *client,
 	case DRM_AMDXDNA_HW_LAST_ASYNC_ERR:
 		ret = aie2_get_array_async_error(xdna->dev_handle, args);
 		break;
+	case DRM_AMDXDNA_AIE_COREDUMP:
+		ret = amdxdna_get_coredump(&ndev->aie, args);
+		break;
 	case DRM_AMDXDNA_BO_USAGE:
 		ret = amdxdna_drm_get_bo_usage(&xdna->ddev, args);
 		break;
diff --git a/drivers/accel/amdxdna/aie2_pci.h b/drivers/accel/amdxdna/aie2_pci.h
index 77648cc548b6..c3291882538c 100644
--- a/drivers/accel/amdxdna/aie2_pci.h
+++ b/drivers/accel/amdxdna/aie2_pci.h
@@ -202,6 +202,7 @@ enum aie2_fw_feature {
 	AIE2_ADD_HOST_BUFFER,
 	AIE2_UPDATE_PROPERTY,
 	AIE2_GET_DEV_REVISION,
+	AIE2_GET_COREDUMP,
 	AIE2_FEATURE_MAX
 };
 
@@ -270,6 +271,9 @@ int aie2_query_firmware_version(struct amdxdna_dev_hdl *ndev,
 int aie2_query_app_health(struct amdxdna_dev_hdl *ndev, u32 context_id,
 			  struct app_health_report *report);
 int aie2_get_dev_revision(struct amdxdna_dev_hdl *ndev, enum aie2_dev_revision *rev);
+int aie2_get_aie_coredump(struct amdxdna_hwctx *hwctx,
+			  struct amdxdna_msg_buf_hdl *list_hdl,
+			  u32 num_bufs);
 int aie2_create_context(struct amdxdna_dev_hdl *ndev, struct amdxdna_hwctx *hwctx);
 int aie2_destroy_context(struct amdxdna_dev_hdl *ndev, struct amdxdna_hwctx *hwctx);
 int aie2_map_host_buf(struct amdxdna_dev_hdl *ndev, u32 context_id, u64 addr, u64 size);
diff --git a/drivers/accel/amdxdna/aie4_message.c b/drivers/accel/amdxdna/aie4_message.c
index 88037edbb02a..795b65ee9e0e 100644
--- a/drivers/accel/amdxdna/aie4_message.c
+++ b/drivers/accel/amdxdna/aie4_message.c
@@ -5,14 +5,17 @@
 
 #include <drm/amdxdna_accel.h>
 #include <drm/drm_print.h>
+#include <linux/bitfield.h>
 #include <linux/mutex.h>
 
 #include "aie.h"
 #include "aie4_msg_priv.h"
 #include "aie4_pci.h"
+#include "amdxdna_ctx.h"
 #include "amdxdna_mailbox.h"
 #include "amdxdna_mailbox_helper.h"
 #include "amdxdna_pci_drv.h"
+#include "amdxdna_pm.h"
 
 int aie4_suspend_fw(struct amdxdna_dev_hdl *ndev)
 {
@@ -70,7 +73,7 @@ int aie4_attach_work_buffer(struct amdxdna_dev_hdl *ndev)
 	struct amdxdna_dev *xdna = ndev->aie.xdna;
 	int ret;
 
-	req.buff_addr = ndev->work_buf_addr;
+	req.buff_addr = to_dma_addr(ndev->work_buf_hdl, 0);
 	req.buff_size = AIE4_WORK_BUFFER_MIN_SIZE;
 
 	ret = aie_send_mgmt_msg_wait(&ndev->aie, &msg);
@@ -81,3 +84,31 @@ int aie4_attach_work_buffer(struct amdxdna_dev_hdl *ndev)
 
 	return ret;
 }
+
+int aie4_get_aie_coredump(struct amdxdna_hwctx *hwctx,
+			  struct amdxdna_msg_buf_hdl *list_hdl,
+			  u32 num_bufs)
+{
+	DECLARE_AIE_MSG(aie4_msg_aie_coredump, AIE4_MSG_OP_AIE_COREDUMP);
+	struct amdxdna_dev *xdna = hwctx->client->xdna;
+	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
+	int ret;
+
+	req.context_id = hwctx->fw_ctx_id;
+	req.pasid = FIELD_PREP(AIE4_MSG_PASID, hwctx->client->pasid) |
+		    FIELD_PREP(AIE4_MSG_PASID_VLD, 1);
+	req.num_buffers = num_bufs;
+	req.buffer_list_addr = to_dma_addr(list_hdl, 0);
+
+	ret = aie_send_mgmt_msg_wait(&ndev->aie, &msg);
+	if (ret)
+		XDNA_ERR(xdna, "Get coredump got status 0x%x", resp.status);
+
+	return ret;
+}
+
+void aie4_msg_init(struct amdxdna_dev_hdl *ndev)
+{
+	if (AIE_FEATURE_ON(&ndev->aie, AIE4_GET_COREDUMP))
+		ndev->aie.msg_ops.get_coredump = aie4_get_aie_coredump;
+}
diff --git a/drivers/accel/amdxdna/aie4_msg_priv.h b/drivers/accel/amdxdna/aie4_msg_priv.h
index af0866045b91..d01b2889af1d 100644
--- a/drivers/accel/amdxdna/aie4_msg_priv.h
+++ b/drivers/accel/amdxdna/aie4_msg_priv.h
@@ -12,6 +12,7 @@
 enum aie4_msg_opcode {
 	AIE4_MSG_OP_SUSPEND                          = 0x10003,
 	AIE4_MSG_OP_ATTACH_WORK_BUFFER               = 0x1000D,
+	AIE4_MSG_OP_AIE_COREDUMP                     = 0x30010,
 
 	AIE4_MSG_OP_CREATE_VFS                       = 0x20001,
 	AIE4_MSG_OP_DESTROY_VFS                      = 0x20002,
@@ -144,4 +145,16 @@ struct aie4_msg_attach_work_buffer_resp {
 	enum aie4_msg_status status;
 } __packed;
 
+struct aie4_msg_aie_coredump_req {
+	__u32 context_id;
+	__u32 pasid;
+	__u32 num_buffers;
+	__u32 resvd;
+	__u64 buffer_list_addr;
+} __packed;
+
+struct aie4_msg_aie_coredump_resp {
+	enum aie4_msg_status status;
+} __packed;
+
 #endif /* _AIE4_MSG_PRIV_H_ */
diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
index a58a83af42a4..1b5584d6e539 100644
--- a/drivers/accel/amdxdna/aie4_pci.c
+++ b/drivers/accel/amdxdna/aie4_pci.c
@@ -4,6 +4,7 @@
  */
 
 #include <drm/amdxdna_accel.h>
+#include <drm/drm_drv.h>
 #include <drm/drm_managed.h>
 #include <drm/drm_print.h>
 #include <linux/firmware.h>
@@ -15,6 +16,7 @@
 #include "amdxdna_mailbox.h"
 #include "amdxdna_mailbox_helper.h"
 #include "amdxdna_pci_drv.h"
+#include "amdxdna_pm.h"
 
 #define NO_IOHUB		0
 #define PSP_NOTIFY_INTR		0xD007BE11
@@ -512,6 +514,7 @@ static int aie4m_pcidev_init(struct amdxdna_dev *xdna)
 	if (ret)
 		return ret;
 
+	aie4_msg_init(ndev);
 	amdxdna_vbnv_init(xdna);
 	XDNA_DBG(xdna, "init finished");
 
@@ -573,35 +576,60 @@ static int aie4_get_info(struct amdxdna_client *client, struct amdxdna_drm_get_i
 static int aie4_alloc_work_buffer(struct amdxdna_dev_hdl *ndev)
 {
 	struct amdxdna_dev *xdna = ndev->aie.xdna;
-	u32 buf_size = AIE4_WORK_BUFFER_MIN_SIZE;
 
-	ndev->work_buf = amdxdna_alloc_msg_buffer(xdna, &buf_size,
-						  &ndev->work_buf_addr);
-	if (IS_ERR(ndev->work_buf)) {
-		int ret = PTR_ERR(ndev->work_buf);
+	ndev->work_buf_hdl = amdxdna_alloc_msg_buffer(xdna, AIE4_WORK_BUFFER_MIN_SIZE);
+	if (IS_ERR(ndev->work_buf_hdl)) {
+		int ret = PTR_ERR(ndev->work_buf_hdl);
 
 		XDNA_ERR(xdna, "Failed to alloc work buffer, size 0x%x",
 			 AIE4_WORK_BUFFER_MIN_SIZE);
-		ndev->work_buf = NULL;
+		ndev->work_buf_hdl = NULL;
 		return ret;
 	}
 
-	ndev->work_buf_size = buf_size;
-	XDNA_DBG(xdna, "Work buffer allocated: size 0x%x", buf_size);
+	XDNA_DBG(xdna, "Work buffer allocated: size 0x%x",
+		 to_buf_size(ndev->work_buf_hdl));
 
 	return 0;
 }
 
 static void aie4_free_work_buffer(struct amdxdna_dev_hdl *ndev)
 {
-	struct amdxdna_dev *xdna = ndev->aie.xdna;
-
-	if (!ndev->work_buf)
+	if (!ndev->work_buf_hdl)
 		return;
 
-	amdxdna_free_msg_buffer(xdna, ndev->work_buf_size, ndev->work_buf,
-				ndev->work_buf_addr);
-	ndev->work_buf = NULL;
+	amdxdna_free_msg_buffer(ndev->work_buf_hdl);
+	ndev->work_buf_hdl = NULL;
+}
+
+static int aie4_get_array(struct amdxdna_client *client,
+			  struct amdxdna_drm_get_array *args)
+{
+	struct amdxdna_dev_hdl *ndev = client->xdna->dev_handle;
+	struct amdxdna_dev *xdna = client->xdna;
+	int ret, idx;
+
+	if (!drm_dev_enter(&xdna->ddev, &idx))
+		return -ENODEV;
+
+	ret = amdxdna_pm_resume_get_locked(xdna);
+	if (ret)
+		goto dev_exit;
+
+	switch (args->param) {
+	case DRM_AMDXDNA_AIE_COREDUMP:
+		ret = amdxdna_get_coredump(&ndev->aie, args);
+		break;
+	default:
+		ret = -EOPNOTSUPP;
+		break;
+	}
+
+	amdxdna_pm_suspend_put(xdna);
+
+dev_exit:
+	drm_dev_exit(idx);
+	return ret;
 }
 
 static int aie4_pf_init(struct amdxdna_dev *xdna)
@@ -664,4 +692,5 @@ const struct amdxdna_dev_ops aie4_vf_ops = {
 	.mmap			= aie4_doorbell_mmap,
 	.cmd_wait		= aie4_cmd_wait,
 	.get_aie_info		= aie4_get_info,
+	.get_array		= aie4_get_array,
 };
diff --git a/drivers/accel/amdxdna/aie4_pci.h b/drivers/accel/amdxdna/aie4_pci.h
index 3fd5eace3ed7..f5efeaf1de38 100644
--- a/drivers/accel/amdxdna/aie4_pci.h
+++ b/drivers/accel/amdxdna/aie4_pci.h
@@ -54,16 +54,23 @@ struct amdxdna_dev_hdl {
 	struct xarray                   cert_comp_xa; /* device level indexed by msix id */
 	struct mutex                    cert_comp_lock; /* protects cert_comp operations*/
 
-	void				*work_buf;
-	dma_addr_t			work_buf_addr;
-	u32				work_buf_size;
+	struct amdxdna_msg_buf_hdl	*work_buf_hdl;
+};
+
+enum aie4_fw_feature {
+	AIE4_GET_COREDUMP,
+	AIE4_FEATURE_MAX
 };
 
 /* aie4_message.c */
+void aie4_msg_init(struct amdxdna_dev_hdl *ndev);
 int aie4_query_aie_metadata(struct amdxdna_dev_hdl *ndev,
 			    struct amdxdna_drm_query_aie_metadata *metadata);
 int aie4_suspend_fw(struct amdxdna_dev_hdl *ndev);
 int aie4_attach_work_buffer(struct amdxdna_dev_hdl *ndev);
+int aie4_get_aie_coredump(struct amdxdna_hwctx *hwctx,
+			  struct amdxdna_msg_buf_hdl *list_hdl,
+			  u32 num_bufs);
 
 /* aie4_ctx.c */
 int aie4_hwctx_init(struct amdxdna_hwctx *hwctx);
diff --git a/drivers/accel/amdxdna/amdxdna_ctx.h b/drivers/accel/amdxdna/amdxdna_ctx.h
index aaae16430466..4b8f54a3e35f 100644
--- a/drivers/accel/amdxdna/amdxdna_ctx.h
+++ b/drivers/accel/amdxdna/amdxdna_ctx.h
@@ -6,6 +6,7 @@
 #ifndef _AMDXDNA_CTX_H_
 #define _AMDXDNA_CTX_H_
 
+#include <drm/gpu_scheduler.h>
 #include <linux/bitfield.h>
 
 #include "amdxdna_gem.h"
diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdxdna/amdxdna_pci_drv.c
index c677293c1ae7..d4e320518a37 100644
--- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
+++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
@@ -41,9 +41,10 @@ MODULE_FIRMWARE("amdnpu/17f0_11/npu_7.sbin");
  * 0.8: Support BO usage query
  * 0.9: Add new device type AMDXDNA_DEV_TYPE_PF
  * 0.10: Support AIE4 UMQ
+ * 0.11: Support AIE coredump
  */
 #define AMDXDNA_DRIVER_MAJOR		0
-#define AMDXDNA_DRIVER_MINOR		10
+#define AMDXDNA_DRIVER_MINOR		11
 
 /*
  * Bind the driver base on (vendor_id, device_id) pair and later use the
diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.h b/drivers/accel/amdxdna/amdxdna_pci_drv.h
index 34271c14d359..b6a6578e8404 100644
--- a/drivers/accel/amdxdna/amdxdna_pci_drv.h
+++ b/drivers/accel/amdxdna/amdxdna_pci_drv.h
@@ -47,6 +47,7 @@ struct amdxdna_drm_set_state;
 struct amdxdna_gem_obj;
 struct amdxdna_hwctx;
 struct amdxdna_sched_job;
+struct amdxdna_msg_buf_hdl;
 
 /*
  * struct amdxdna_dev_ops - Device hardware operation callbacks
@@ -173,6 +174,9 @@ struct amdxdna_client {
 #define amdxdna_for_each_hwctx(client, hwctx_id, entry)		\
 	xa_for_each(&(client)->hwctx_xa, hwctx_id, entry)
 
+#define amdxdna_for_each_client(xdna, client)			\
+	list_for_each_entry(client, &(xdna)->client_list, node)
+
 /* Add device info below */
 extern const struct amdxdna_dev_info dev_npu1_info;
 extern const struct amdxdna_dev_info dev_npu3_pf_info;
diff --git a/drivers/accel/amdxdna/npu3_regs.c b/drivers/accel/amdxdna/npu3_regs.c
index d76b2e99c308..e487960e3ccf 100644
--- a/drivers/accel/amdxdna/npu3_regs.c
+++ b/drivers/accel/amdxdna/npu3_regs.c
@@ -39,6 +39,7 @@
 
 static const struct amdxdna_fw_feature_tbl npu3_fw_feature_table[] = {
 	{ .major = 5, .min_minor = 10 },
+	{ .features = BIT_U64(AIE4_GET_COREDUMP), .major = 5, .min_minor = 24 },
 	{ 0 }
 };
 
diff --git a/include/uapi/drm/amdxdna_accel.h b/include/uapi/drm/amdxdna_accel.h
index 51a507561df6..db583de58ebb 100644
--- a/include/uapi/drm/amdxdna_accel.h
+++ b/include/uapi/drm/amdxdna_accel.h
@@ -635,11 +635,24 @@ struct amdxdna_drm_bo_usage {
 	__u64 heap_usage;
 };
 
+/**
+ * struct amdxdna_drm_aie_coredump - The data for AIE coredump
+ */
+struct amdxdna_drm_aie_coredump {
+	/** @pid: The Process ID of the process that created this context.*/
+	__u64 pid;
+	/** @context_id: Context ID. */
+	__u32 context_id;
+	/** @pad: MBZ. */
+	__u32 pad;
+};
+
 /*
  * Supported params in struct amdxdna_drm_get_array
  */
 #define DRM_AMDXDNA_HW_CONTEXT_ALL	0
 #define DRM_AMDXDNA_HW_LAST_ASYNC_ERR	2
+#define DRM_AMDXDNA_AIE_COREDUMP	5
 #define DRM_AMDXDNA_BO_USAGE		6
 
 /**
@@ -657,6 +670,19 @@ struct amdxdna_drm_get_array {
 	 * %DRM_AMDXDNA_HW_LAST_ASYNC_ERR:
 	 * Returns last async error.
 	 *
+	 * %DRM_AMDXDNA_AIE_COREDUMP:
+	 * Returns AIE tile memory dump for a hardware context.
+	 *
+	 * Input: num_element must be 1. buffer points to a user buffer whose
+	 * size is element_size bytes. The first sizeof(struct
+	 * amdxdna_drm_aie_coredump) bytes of buffer carry the request
+	 * (pid + context_id). On success the driver writes rows * cols * 1 MB
+	 * of tile dump data into buffer. If the buffer is too small the
+	 * driver sets element_size to the required size and returns -ENOSPC.
+	 *
+	 * Access: context owners may coredump their own contexts;
+	 * CAP_SYS_ADMIN may coredump any context.
+	 *
 	 * %DRM_AMDXDNA_BO_USAGE:
 	 * Returns usage of heap/internal/external BOs.
 	 */
-- 
2.34.1

