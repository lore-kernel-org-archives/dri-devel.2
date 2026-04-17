Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE62F99C68
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 21:10:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A35DA10EAA5;
	Fri, 17 Apr 2026 21:10:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VVRH3QdH";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012022.outbound.protection.outlook.com [52.101.43.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4C3E10EAA1
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 21:10:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zK4RRCqNIvZbRZTPN/EbtDLfvw1Q8iv3hlLiyGgt78keMY+HdBGSOgN7WaNCLxsSDDoilSCAndp0jWv9ao+O7URZF/bX7O+o0WyJwVAw2yhgubK62fysYbHgdjzn7OxKH1dmcTWcktwSiLBgvNk95B+x+jPrGd71fCAF/HKDzV9k4Qbn9cAm0N+XFDu5P6IPg3xupMrP88LTe/gNxzzkoGcoS0Z7WoPmS2D77dluvM39MVwfTAabWhUIs0lFjDVN9fHhTl+Tn7BVMbGMuXKwE0/PDIj3hXEBcMTSBf/gD1GL4wuztL+764PDV7rtwvJluAl3zLkda5Id3OVtfdgDQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xjt3Eij3MfvHkaxRmzKnmP+ao6zlaew6AN83DbhBnss=;
 b=tBR3Qyaqoi7iN0PtC6dccne4lgKYnz7pAVLc4SajwVswJp5CyF8Wp3mWk+Xr4MT/TOXJUAnAOqngXi3quCF1f76UN6HhSPdhwi3qfU74vifDRz7mLKaDB0GHQrVhFYQrDJ4QnrnQz05zBVTkVG7If8xX77SsyzSobhTxL0sC6zAcv3DrTV8g8Qi3AB3ItsPMmNoyw/pkAsZkIAV4Uj0H0L+e+VhyU0+X+mqvu570ZGMoX2/pIgFVMk0kjPKps/s+Xb3f0zC320i0XOG2cvt2NFBnn3/vqs0nA2wCCNQ+JItd3+kNihV1V7pBn6jvnH773CNEUf9BS0xGj72AOPHqOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xjt3Eij3MfvHkaxRmzKnmP+ao6zlaew6AN83DbhBnss=;
 b=VVRH3QdHXdEsJmXqJlVj7e6jr3kdQjnftw2bXmh1Iub44ZG9I0YPUME/49vOur9Xac1QykohmXFyr/+g6KGgq5xJUi6RpKfFAik1KLvZCjDjfzif4HXShbr+beK5yqtVI7z7MO+GnzAmKDR1IKcYRg3Otl+xZ0H4hFfLN10gK0Y=
Received: from DM6PR03CA0097.namprd03.prod.outlook.com (2603:10b6:5:333::30)
 by DS7PR12MB5840.namprd12.prod.outlook.com (2603:10b6:8:7b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 21:10:35 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:5:333:cafe::79) by DM6PR03CA0097.outlook.office365.com
 (2603:10b6:5:333::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.52 via Frontend Transport; Fri,
 17 Apr 2026 21:10:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 17 Apr 2026 21:10:34 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 17 Apr
 2026 16:10:33 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 17 Apr
 2026 14:06:23 -0700
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 17 Apr 2026 16:06:22 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <maciej.falkowski@linux.intel.com>
CC: Max Zhen <max.zhen@amd.com>, <linux-kernel@vger.kernel.org>,
 <sonal.santan@amd.com>, Lizhi Hou <lizhi.hou@amd.com>
Subject: [PATCH V1] accel/amdxdna: Add carveout memory support for non-IOMMU
 systems
Date: Fri, 17 Apr 2026 14:06:21 -0700
Message-ID: <20260417210621.1173841-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|DS7PR12MB5840:EE_
X-MS-Office365-Filtering-Correlation-Id: 39c03108-6262-40bd-7c52-08de9cc5c45b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: cmIQsEaoU+2AfW3IobrzSuiqduo7Ijr0YbPJc4MLuySlqOdHVh5nvV6qQncHYyDQj48JYXa2GA1Rj3hUPfVBfihnJuBI3F9Jm2tXqrTGZyqHKSfEhtYAE09rCzAWZ9bYEVKGNQrGfSgbAtOvKvnO6CkrTh9ELOucaLy9cTLUYlaPExjgFg9yTqqXk7KTxEtly4BwmcTvrgEFq4VfAEtquVkl4QOx98IXMaQYb7ltjHG3U9KPIP38HF8dalMHDrJzJJrucILRzdBkTLRaiTe+oSnFyx0y3WBYlJ/BLC1DZVNobW+Yx0yeMvscVDEA4DBNqQg7xGQrDOFfbOiBCPqbBIuCmm+hXdZBcQAL9xzF2S3OqV6nOPMeF6LBKZUDeCEkLshLegbMFT4G35/911+bRAsdcdEUWk6mbiZp+hiCSTlPUkTkEXSwI65Q0IDWNKpPPv2+51kCk3cBcIcJLpjMgXKzlQ9N+CuatjmLoru2mBsvvOUW+8nueDTX7AJwrSKeZrLLY5lkbOseJwwChWQM6qCXQS9xXGXkV+J3rE6GwnC2cqfGMLGcTYA9Tz11IUal+Giw3mFQ8uNQqNo3pzXvAk52/j3DL2akAW77Fs+E2ZUEbBLezz59X+JKRUaiuWYp0xGro6E/QjYYBwE8lId/VbOjHiOtD6ofS67NBtGXLLXFW9Q6x9XIezp1fI7XXc6IVsgB1G68GhZ5pZ40IZba8NuaqcRFC7Lvu7VkghgYS+KLiJFTziScfWHbFJhgxL6WyShgjt9ZlI16oOdQbTEFNw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +q5aa4Sndlcq4p6QM7/kNXqZY5zaIXzNUxDfsciRmg8z2Vs5Q6L60k7ZifVCogsXsNBcVIKMsfXTfM+efsIDnfr0U2sGQepb2zM3iOiCHww8m4ofJo5QOeWq8I5ksgkqn3HAsocLVy4ABeqptI6kkOabtwUPCe8JimJE7HlXvJBnTaoUnvxFsUUwOB0oNFpB89QmJTaIESB0+n6+Zh38/qatQtV4d3o0gFwfe3tmFgV5o7hbj2nkCSucc55LUhvlpwGhj88D3YO94Ew3yWvSL8sNH76OUTk8KIa+zvDmrBul3HYW7kQEyTfHhneE5X9NwPRYUQ1Xc6V3kXAVG149kwygCt9OsTRhN2xfLY/haH5B/JV/Rxrlz5DIsMpkrO5SdFwYyBtThaGW2pXj2bU4uFky+amkdIPZn6KwwsnuDKntsKvts0Q8I3ssHuk5Saqn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 21:10:34.9448 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c03108-6262-40bd-7c52-08de9cc5c45b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5840
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

From: Max Zhen <max.zhen@amd.com>

Add support for allocating buffers from reserved carveout memory when
IOMMU is not available. This is useful during debugging or bring-up.

In this configuration, the device uses physical addresses and does
not support scatter-gather lists, requiring physically contiguous
buffers.

Implement carveout-backed allocation and integrate it into buffer
management to support operation in physical address mode.

Signed-off-by: Max Zhen <max.zhen@amd.com>
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/Makefile          |   1 +
 drivers/accel/amdxdna/amdxdna_cbuf.c    | 249 ++++++++++++++++++++++++
 drivers/accel/amdxdna/amdxdna_cbuf.h    |  16 ++
 drivers/accel/amdxdna/amdxdna_gem.c     |  95 +++++++--
 drivers/accel/amdxdna/amdxdna_iommu.c   |  77 +++++---
 drivers/accel/amdxdna/amdxdna_pci_drv.c |  91 ++++++---
 drivers/accel/amdxdna/amdxdna_pci_drv.h |   4 +-
 7 files changed, 454 insertions(+), 79 deletions(-)
 create mode 100644 drivers/accel/amdxdna/amdxdna_cbuf.c
 create mode 100644 drivers/accel/amdxdna/amdxdna_cbuf.h

diff --git a/drivers/accel/amdxdna/Makefile b/drivers/accel/amdxdna/Makefile
index 79369e497540..a055aea36971 100644
--- a/drivers/accel/amdxdna/Makefile
+++ b/drivers/accel/amdxdna/Makefile
@@ -12,6 +12,7 @@ amdxdna-y := \
 	aie2_solver.o \
 	aie4_message.o \
 	aie4_pci.o \
+	amdxdna_cbuf.o \
 	amdxdna_ctx.o \
 	amdxdna_gem.o \
 	amdxdna_iommu.o \
diff --git a/drivers/accel/amdxdna/amdxdna_cbuf.c b/drivers/accel/amdxdna/amdxdna_cbuf.c
new file mode 100644
index 000000000000..4a556199a461
--- /dev/null
+++ b/drivers/accel/amdxdna/amdxdna_cbuf.c
@@ -0,0 +1,249 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026, Advanced Micro Devices, Inc.
+ */
+
+#include <drm/drm_mm.h>
+#include <drm/drm_prime.h>
+
+#include "amdxdna_cbuf.h"
+#include "amdxdna_pci_drv.h"
+
+/*
+ * This is a platform debug/bringup feature.
+ *
+ * Carveout memory is a chunk of memory which is physically contiguous and
+ * is reserved during early boot time. There is only one chunk of such memory
+ * per system. Once available, all BOs accessible from device should be
+ * allocated from this memory.
+ */
+u64 carveout_addr;
+module_param(carveout_addr, ullong, 0400);
+MODULE_PARM_DESC(carveout_addr, "Physical memory address for reserved memory chunk");
+
+u64 carveout_size;
+module_param(carveout_size, ullong, 0400);
+MODULE_PARM_DESC(carveout_size, "Physical memory size for reserved memory chunk");
+
+struct amdxdna_carveout {
+	struct drm_mm	mm;
+	struct mutex	lock; /* protect mm */
+} carveout;
+
+bool amdxdna_use_carveout(void)
+{
+	return !!carveout_size;
+}
+
+void amdxdna_carveout_init(void)
+{
+	if (!amdxdna_use_carveout())
+		return;
+	mutex_init(&carveout.lock);
+	drm_mm_init(&carveout.mm, carveout_addr, carveout_size);
+	pr_info("Use carveout mem, addr=0x%llx, size=0x%llx\n", carveout_addr, carveout_size);
+}
+
+void amdxdna_carveout_fini(void)
+{
+	if (!amdxdna_use_carveout())
+		return;
+	drm_mm_takedown(&carveout.mm);
+	mutex_destroy(&carveout.lock);
+}
+
+struct amdxdna_cbuf_priv {
+	struct drm_mm_node node;
+};
+
+static struct sg_table *amdxdna_cbuf_map(struct dma_buf_attachment *attach,
+					 enum dma_data_direction direction)
+{
+	struct amdxdna_cbuf_priv *cbuf = attach->dmabuf->priv;
+	struct device *dev = attach->dev;
+	struct scatterlist *sgl, *sg;
+	int ret, n_entries, i;
+	struct sg_table *sgt;
+	dma_addr_t dma_addr;
+	size_t dma_size;
+	size_t max_seg;
+
+	sgt = kzalloc_obj(*sgt);
+	if (!sgt)
+		return ERR_PTR(-ENOMEM);
+
+	max_seg = min_t(size_t, UINT_MAX, dma_max_mapping_size(dev));
+	n_entries = (cbuf->node.size + max_seg - 1) / max_seg;
+	sgl = kzalloc_objs(*sg, n_entries);
+	if (!sgl) {
+		ret = -ENOMEM;
+		goto free_sgt;
+	}
+	sg_init_table(sgl, n_entries);
+	sgt->orig_nents = n_entries;
+	sgt->nents = n_entries;
+	sgt->sgl = sgl;
+
+	dma_size = cbuf->node.size;
+	dma_addr = dma_map_resource(dev, cbuf->node.start, dma_size,
+				    direction, DMA_ATTR_SKIP_CPU_SYNC);
+	ret = dma_mapping_error(dev, dma_addr);
+	if (ret) {
+		pr_err("Failed to dma_map_resource carveout dma buf, ret %d\n", ret);
+		goto free_sgl;
+	}
+
+	for_each_sgtable_dma_sg(sgt, sg, i) {
+		size_t len = min_t(size_t, max_seg, dma_size);
+
+		sg_dma_address(sg) = dma_addr;
+		sg_dma_len(sg) = len;
+		dma_addr += len;
+		dma_size -= len;
+	}
+
+	return sgt;
+
+free_sgl:
+	kfree(sgl);
+free_sgt:
+	kfree(sgt);
+	return ERR_PTR(ret);
+}
+
+static void amdxdna_cbuf_unmap(struct dma_buf_attachment *attach,
+			       struct sg_table *sgt,
+			       enum dma_data_direction direction)
+{
+	dma_unmap_resource(attach->dev, sg_dma_address(sgt->sgl),
+			   drm_prime_get_contiguous_size(sgt), direction,
+			   DMA_ATTR_SKIP_CPU_SYNC);
+	sg_free_table(sgt);
+	kfree(sgt);
+}
+
+static void amdxdna_cbuf_release(struct dma_buf *dbuf)
+{
+	struct amdxdna_cbuf_priv *cbuf = dbuf->priv;
+
+	mutex_lock(&carveout.lock);
+	drm_mm_remove_node(&cbuf->node);
+	mutex_unlock(&carveout.lock);
+
+	kfree(cbuf);
+}
+
+static vm_fault_t amdxdna_cbuf_vm_fault(struct vm_fault *vmf)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	struct amdxdna_cbuf_priv *cbuf;
+	unsigned long pfn;
+	pgoff_t pgoff;
+
+	cbuf = vma->vm_private_data;
+	pgoff = (vmf->address - vma->vm_start) >> PAGE_SHIFT;
+	pfn = (cbuf->node.start >> PAGE_SHIFT) + pgoff;
+
+	return vmf_insert_pfn(vma, vmf->address, pfn);
+}
+
+static const struct vm_operations_struct amdxdna_cbuf_vm_ops = {
+	.fault = amdxdna_cbuf_vm_fault,
+};
+
+static int amdxdna_cbuf_mmap(struct dma_buf *dbuf, struct vm_area_struct *vma)
+{
+	struct amdxdna_cbuf_priv *cbuf = dbuf->priv;
+
+	vma->vm_ops = &amdxdna_cbuf_vm_ops;
+	vma->vm_private_data = cbuf;
+	vm_flags_set(vma, VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP);
+
+	return 0;
+}
+
+static int amdxdna_cbuf_vmap(struct dma_buf *dbuf, struct iosys_map *map)
+{
+	struct amdxdna_cbuf_priv *cbuf = dbuf->priv;
+	void *kva;
+
+	kva = memremap(cbuf->node.start, cbuf->node.size, MEMREMAP_WB);
+	if (!kva) {
+		pr_err("Failed to vmap carveout dma buf\n");
+		return -ENOMEM;
+	}
+
+	iosys_map_set_vaddr(map, kva);
+	return 0;
+}
+
+static void amdxdna_cbuf_vunmap(struct dma_buf *dbuf, struct iosys_map *map)
+{
+	memunmap(map->vaddr);
+}
+
+static const struct dma_buf_ops amdxdna_cbuf_dmabuf_ops = {
+	.map_dma_buf = amdxdna_cbuf_map,
+	.unmap_dma_buf = amdxdna_cbuf_unmap,
+	.release = amdxdna_cbuf_release,
+	.mmap = amdxdna_cbuf_mmap,
+	.vmap = amdxdna_cbuf_vmap,
+	.vunmap = amdxdna_cbuf_vunmap,
+};
+
+static int amdxdna_cbuf_clear(struct dma_buf *dbuf)
+{
+	struct iosys_map vmap = IOSYS_MAP_INIT_VADDR(NULL);
+
+	dma_buf_vmap(dbuf, &vmap);
+	if (!vmap.vaddr)
+		return -EFAULT;
+
+	memset(vmap.vaddr, 0, dbuf->size);
+	dma_buf_vunmap(dbuf, &vmap);
+
+	return 0;
+}
+
+struct dma_buf *amdxdna_get_cbuf(struct drm_device *dev, size_t size, u64 alignment)
+{
+	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
+	struct amdxdna_cbuf_priv *cbuf;
+	struct dma_buf *dbuf;
+	int ret;
+
+	cbuf = kzalloc_obj(*cbuf);
+	if (!cbuf)
+		return ERR_PTR(-ENOMEM);
+
+	mutex_lock(&carveout.lock);
+	ret = drm_mm_insert_node_generic(&carveout.mm, &cbuf->node, size,
+					 alignment, 0, DRM_MM_INSERT_BEST);
+	mutex_unlock(&carveout.lock);
+	if (ret)
+		goto free_cbuf;
+
+	exp_info.size = size;
+	exp_info.ops = &amdxdna_cbuf_dmabuf_ops;
+	exp_info.priv = cbuf;
+	exp_info.flags = O_RDWR;
+	dbuf = dma_buf_export(&exp_info);
+	if (IS_ERR(dbuf)) {
+		ret = PTR_ERR(dbuf);
+		goto remove_node;
+	}
+
+	ret = amdxdna_cbuf_clear(dbuf);
+	if (ret) {
+		dma_buf_put(dbuf);
+		goto out;
+	}
+	return dbuf;
+
+remove_node:
+	drm_mm_remove_node(&cbuf->node);
+free_cbuf:
+	kfree(cbuf);
+out:
+	return ERR_PTR(ret);
+}
diff --git a/drivers/accel/amdxdna/amdxdna_cbuf.h b/drivers/accel/amdxdna/amdxdna_cbuf.h
new file mode 100644
index 000000000000..15e189ce779e
--- /dev/null
+++ b/drivers/accel/amdxdna/amdxdna_cbuf.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2026, Advanced Micro Devices, Inc.
+ */
+#ifndef _AMDXDNA_CBUF_H_
+#define _AMDXDNA_CBUF_H_
+
+#include <drm/drm_device.h>
+#include <linux/dma-buf.h>
+
+bool amdxdna_use_carveout(void);
+void amdxdna_carveout_init(void);
+void amdxdna_carveout_fini(void);
+struct dma_buf *amdxdna_get_cbuf(struct drm_device *dev, size_t size, u64 alignment);
+
+#endif
diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
index 238ee244d4a6..905514ec183c 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.c
+++ b/drivers/accel/amdxdna/amdxdna_gem.c
@@ -16,6 +16,7 @@
 #include <linux/pagemap.h>
 #include <linux/vmalloc.h>
 
+#include "amdxdna_cbuf.h"
 #include "amdxdna_ctx.h"
 #include "amdxdna_gem.h"
 #include "amdxdna_pci_drv.h"
@@ -516,10 +517,6 @@ static void amdxdna_imported_obj_free(struct amdxdna_gem_obj *abo)
 static inline bool
 amdxdna_gem_skip_bo_usage(struct amdxdna_gem_obj *abo)
 {
-	/* Do not count imported BOs since the buffer is not allocated by us. */
-	if (is_import_bo(abo))
-		return true;
-
 	/* Already counted as part of HEAP BO */
 	if (abo->type == AMDXDNA_BO_DEV)
 		return true;
@@ -571,9 +568,7 @@ static void amdxdna_gem_obj_free(struct drm_gem_object *gobj)
 	if (abo->type == AMDXDNA_BO_DEV_HEAP)
 		drm_mm_takedown(&abo->mm);
 
-	if (amdxdna_iova_on(xdna))
-		amdxdna_iommu_unmap_bo(xdna, abo);
-
+	amdxdna_dma_unmap_bo(xdna, abo);
 	amdxdna_gem_vunmap(abo);
 	mutex_destroy(&abo->lock);
 
@@ -591,18 +586,20 @@ static int amdxdna_gem_obj_open(struct drm_gem_object *gobj, struct drm_file *fi
 
 	guard(mutex)(&abo->lock);
 	abo->open_ref++;
+	if (abo->open_ref > 1)
+		return 0;
 
-	if (abo->open_ref == 1) {
-		/* Attached to the client when first opened by it. */
-		abo->client = filp->driver_priv;
-		amdxdna_gem_add_bo_usage(abo);
-	}
-	if (amdxdna_iova_on(xdna)) {
-		ret = amdxdna_iommu_map_bo(xdna, abo);
+	/* Attached to the client when first opened by it. */
+	abo->client = filp->driver_priv;
+
+	/* No need to set up dma addr mapping in PASID mode. */
+	if (!amdxdna_pasid_on(abo->client)) {
+		ret = amdxdna_dma_map_bo(xdna, abo);
 		if (ret)
 			return ret;
 	}
 
+	amdxdna_gem_add_bo_usage(abo);
 	return 0;
 }
 
@@ -620,6 +617,39 @@ static void amdxdna_gem_obj_close(struct drm_gem_object *gobj, struct drm_file *
 	}
 }
 
+static int amdxdna_gem_obj_vmap(struct drm_gem_object *obj, struct iosys_map *map)
+{
+	struct amdxdna_gem_obj *abo = to_xdna_obj(obj);
+	int ret;
+
+	iosys_map_clear(map);
+
+	dma_resv_assert_held(obj->resv);
+
+	if (is_import_bo(abo))
+		ret = dma_buf_vmap(abo->dma_buf, map);
+	else
+		ret = drm_gem_shmem_object_vmap(obj, map);
+	if (ret)
+		return ret;
+	if (!map->vaddr)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void amdxdna_gem_obj_vunmap(struct drm_gem_object *obj, struct iosys_map *map)
+{
+	struct amdxdna_gem_obj *abo = to_xdna_obj(obj);
+
+	dma_resv_assert_held(obj->resv);
+
+	if (is_import_bo(abo))
+		dma_buf_vunmap(abo->dma_buf, map);
+	else
+		drm_gem_shmem_object_vunmap(obj, map);
+}
+
 static int amdxdna_gem_dev_obj_vmap(struct drm_gem_object *obj, struct iosys_map *map)
 {
 	struct amdxdna_gem_obj *abo = to_xdna_obj(obj);
@@ -645,8 +675,8 @@ static const struct drm_gem_object_funcs amdxdna_gem_shmem_funcs = {
 	.pin = drm_gem_shmem_object_pin,
 	.unpin = drm_gem_shmem_object_unpin,
 	.get_sg_table = drm_gem_shmem_object_get_sg_table,
-	.vmap = drm_gem_shmem_object_vmap,
-	.vunmap = drm_gem_shmem_object_vunmap,
+	.vmap = amdxdna_gem_obj_vmap,
+	.vunmap = amdxdna_gem_obj_vunmap,
 	.mmap = amdxdna_gem_obj_mmap,
 	.vm_ops = &drm_gem_shmem_vm_ops,
 	.export = amdxdna_gem_prime_export,
@@ -714,6 +744,36 @@ amdxdna_gem_create_ubuf_object(struct drm_device *dev, struct amdxdna_drm_create
 	return to_xdna_obj(gobj);
 }
 
+static struct amdxdna_gem_obj *
+amdxdna_gem_create_cbuf_object(struct drm_device *dev, struct amdxdna_drm_create_bo *args)
+{
+	struct amdxdna_dev *xdna = to_xdna_dev(dev);
+	size_t size = PAGE_ALIGN(args->size);
+	struct drm_gem_object *gobj;
+	struct amdxdna_gem_obj *ret;
+	struct dma_buf *dma_buf;
+	u64 align;
+
+	if (!size) {
+		XDNA_ERR(xdna, "Invalid BO size 0x%llx", args->size);
+		return ERR_PTR(-EINVAL);
+	}
+
+	align = (args->type == AMDXDNA_BO_DEV_HEAP) ?  xdna->dev_info->dev_mem_size : 0;
+	dma_buf = amdxdna_get_cbuf(dev, size, align);
+	if (IS_ERR(dma_buf))
+		return ERR_CAST(dma_buf);
+
+	gobj = amdxdna_gem_prime_import(dev, dma_buf);
+	if (IS_ERR(gobj))
+		ret = ERR_CAST(gobj);
+	else
+		ret = to_xdna_obj(gobj);
+
+	dma_buf_put(dma_buf);
+	return ret;
+}
+
 struct drm_gem_object *
 amdxdna_gem_prime_import(struct drm_device *dev, struct dma_buf *dma_buf)
 {
@@ -769,6 +829,8 @@ amdxdna_drm_create_share_bo(struct drm_device *dev,
 
 	if (args->vaddr)
 		abo = amdxdna_gem_create_ubuf_object(dev, args);
+	else if (amdxdna_use_carveout())
+		abo = amdxdna_gem_create_cbuf_object(dev, args);
 	else
 		abo = amdxdna_gem_create_shmem_object(dev, args);
 	if (IS_ERR(abo))
@@ -884,7 +946,6 @@ int amdxdna_drm_create_bo_ioctl(struct drm_device *dev, void *data, struct drm_f
 		 args->type, args->vaddr, args->size, args->flags);
 	switch (args->type) {
 	case AMDXDNA_BO_CMD:
-		fallthrough;
 	case AMDXDNA_BO_SHARE:
 		abo = amdxdna_drm_create_share_bo(dev, args, filp);
 		break;
diff --git a/drivers/accel/amdxdna/amdxdna_iommu.c b/drivers/accel/amdxdna/amdxdna_iommu.c
index 5a9f06183487..eff00131d0f8 100644
--- a/drivers/accel/amdxdna/amdxdna_iommu.c
+++ b/drivers/accel/amdxdna/amdxdna_iommu.c
@@ -35,14 +35,15 @@ static struct iova *amdxdna_iommu_alloc_iova(struct amdxdna_dev *xdna,
 	return iova;
 }
 
-int amdxdna_iommu_map_bo(struct amdxdna_dev *xdna, struct amdxdna_gem_obj *abo)
+int amdxdna_dma_map_bo(struct amdxdna_dev *xdna, struct amdxdna_gem_obj *abo)
 {
+	unsigned long contig_sz;
 	struct sg_table *sgt;
 	dma_addr_t dma_addr;
 	struct iova *iova;
 	ssize_t size;
 
-	if (abo->type != AMDXDNA_BO_DEV_HEAP && abo->type != AMDXDNA_BO_SHMEM)
+	if (abo->type != AMDXDNA_BO_DEV_HEAP && abo->type != AMDXDNA_BO_SHARE)
 		return 0;
 
 	sgt = drm_gem_shmem_get_pages_sgt(&abo->base);
@@ -51,47 +52,63 @@ int amdxdna_iommu_map_bo(struct amdxdna_dev *xdna, struct amdxdna_gem_obj *abo)
 		return PTR_ERR(sgt);
 	}
 
-	if (!sgt->orig_nents || !sg_page(sgt->sgl)) {
-		XDNA_ERR(xdna, "sgl is zero length or not page backed");
+	if (!sgt->orig_nents) {
+		XDNA_ERR(xdna, "sgl is zero length");
 		return -EOPNOTSUPP;
 	}
 
-	iova = amdxdna_iommu_alloc_iova(xdna, abo->mem.size, &dma_addr,
-					(abo->type == AMDXDNA_BO_DEV_HEAP));
-	if (IS_ERR(iova)) {
-		XDNA_ERR(xdna, "Alloc iova failed, ret %ld", PTR_ERR(iova));
-		return PTR_ERR(iova);
+	if (amdxdna_iova_on(xdna)) {
+		if (!sg_page(sgt->sgl)) {
+			XDNA_ERR(xdna, "sgl is not page backed");
+			return -EOPNOTSUPP;
+		}
+
+		iova = amdxdna_iommu_alloc_iova(xdna, abo->mem.size, &dma_addr,
+						(abo->type == AMDXDNA_BO_DEV_HEAP));
+		if (IS_ERR(iova)) {
+			XDNA_ERR(xdna, "Alloc iova failed, ret %ld", PTR_ERR(iova));
+			return PTR_ERR(iova);
+		}
+
+		size = iommu_map_sgtable(xdna->domain, dma_addr, sgt,
+					 IOMMU_READ | IOMMU_WRITE);
+		if (size < 0) {
+			XDNA_ERR(xdna, "iommu_map_sgtable failed: %zd", size);
+			__free_iova(&xdna->iovad, iova);
+			return size;
+		}
+		if (size < abo->mem.size) {
+			iommu_unmap(xdna->domain, dma_addr, size);
+			__free_iova(&xdna->iovad, iova);
+			return -ENXIO;
+		}
+		abo->mem.dma_addr = dma_addr;
+	} else {
+		/* Device doesn't support scatter/gather list, fail non-contiguous mapping. */
+		contig_sz = drm_prime_get_contiguous_size(sgt);
+		if (contig_sz < abo->mem.size) {
+			XDNA_ERR(xdna,
+				 "noncontiguous dma addr, contig size:%ld, expected size:%ld",
+				 contig_sz, abo->mem.size);
+			return -EINVAL;
+		}
+		abo->mem.dma_addr = sg_dma_address(sgt->sgl);
 	}
-
-	size = iommu_map_sgtable(xdna->domain, dma_addr, sgt,
-				 IOMMU_READ | IOMMU_WRITE);
-	if (size < 0) {
-		XDNA_ERR(xdna, "iommu_map_sgtable failed: %zd", size);
-		__free_iova(&xdna->iovad, iova);
-		return size;
-	}
-
-	if (size < abo->mem.size) {
-		iommu_unmap(xdna->domain, dma_addr, size);
-		__free_iova(&xdna->iovad, iova);
-		return -ENXIO;
-	}
-
-	abo->mem.dma_addr = dma_addr;
-
 	return 0;
 }
 
-void amdxdna_iommu_unmap_bo(struct amdxdna_dev *xdna, struct amdxdna_gem_obj *abo)
+void amdxdna_dma_unmap_bo(struct amdxdna_dev *xdna, struct amdxdna_gem_obj *abo)
 {
 	size_t size;
 
 	if (abo->mem.dma_addr == AMDXDNA_INVALID_ADDR)
 		return;
 
-	size = iova_align(&xdna->iovad, abo->mem.size);
-	iommu_unmap(xdna->domain, abo->mem.dma_addr, size);
-	free_iova(&xdna->iovad, iova_pfn(&xdna->iovad, abo->mem.dma_addr));
+	if (amdxdna_iova_on(xdna)) {
+		size = iova_align(&xdna->iovad, abo->mem.size);
+		iommu_unmap(xdna->domain, abo->mem.dma_addr, size);
+		free_iova(&xdna->iovad, iova_pfn(&xdna->iovad, abo->mem.dma_addr));
+	}
 	abo->mem.dma_addr = AMDXDNA_INVALID_ADDR;
 }
 
diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdxdna/amdxdna_pci_drv.c
index 21eddfc538d0..b8c5dbc12489 100644
--- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
+++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
@@ -14,6 +14,7 @@
 #include <linux/iommu.h>
 #include <linux/pci.h>
 
+#include "amdxdna_cbuf.h"
 #include "amdxdna_ctx.h"
 #include "amdxdna_gem.h"
 #include "amdxdna_pci_drv.h"
@@ -67,11 +68,40 @@ static const struct amdxdna_device_id amdxdna_ids[] = {
 	{0}
 };
 
+static int amdxdna_sva_init(struct amdxdna_client *client)
+{
+	struct amdxdna_dev *xdna = client->xdna;
+
+	client->sva = iommu_sva_bind_device(xdna->ddev.dev, client->mm);
+	if (IS_ERR(client->sva)) {
+		XDNA_ERR(xdna, "SVA bind device failed, ret %ld", PTR_ERR(client->sva));
+		return PTR_ERR(client->sva);
+	}
+
+	client->pasid = iommu_sva_get_pasid(client->sva);
+	if (client->pasid == IOMMU_PASID_INVALID) {
+		iommu_sva_unbind_device(client->sva);
+		XDNA_ERR(xdna, "SVA get pasid failed");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static void amdxdna_sva_fini(struct amdxdna_client *client)
+{
+	if (IS_ERR_OR_NULL(client->sva))
+		return;
+
+	iommu_sva_unbind_device(client->sva);
+	client->sva = NULL;
+	client->pasid = IOMMU_PASID_INVALID;
+}
+
 static int amdxdna_drm_open(struct drm_device *ddev, struct drm_file *filp)
 {
 	struct amdxdna_dev *xdna = to_xdna_dev(ddev);
 	struct amdxdna_client *client;
-	int ret;
 
 	client = kzalloc_obj(*client);
 	if (!client)
@@ -80,22 +110,13 @@ static int amdxdna_drm_open(struct drm_device *ddev, struct drm_file *filp)
 	client->pid = pid_nr(rcu_access_pointer(filp->pid));
 	client->xdna = xdna;
 	client->pasid = IOMMU_PASID_INVALID;
+	client->mm = current->mm;
 
 	if (!amdxdna_iova_on(xdna)) {
-		client->sva = iommu_sva_bind_device(xdna->ddev.dev, current->mm);
-		if (IS_ERR(client->sva)) {
-			ret = PTR_ERR(client->sva);
-			XDNA_ERR(xdna, "SVA bind device failed, ret %d", ret);
-			goto failed;
-		}
-		client->pasid = iommu_sva_get_pasid(client->sva);
-		if (client->pasid == IOMMU_PASID_INVALID) {
-			XDNA_ERR(xdna, "SVA get pasid failed");
-			ret = -ENODEV;
-			goto unbind_sva;
-		}
+		/* No need to fail open since user may use pa + carveout later. */
+		if (amdxdna_sva_init(client))
+			XDNA_WARN(xdna, "PASID not available for pid %d", client->pid);
 	}
-	client->mm = current->mm;
 	mmgrab(client->mm);
 	init_srcu_struct(&client->hwctx_srcu);
 	xa_init_flags(&client->hwctx_xa, XA_FLAGS_ALLOC);
@@ -110,14 +131,6 @@ static int amdxdna_drm_open(struct drm_device *ddev, struct drm_file *filp)
 
 	XDNA_DBG(xdna, "pid %d opened", client->pid);
 	return 0;
-
-unbind_sva:
-	if (!IS_ERR_OR_NULL(client->sva))
-		iommu_sva_unbind_device(client->sva);
-failed:
-	kfree(client);
-
-	return ret;
 }
 
 static void amdxdna_client_cleanup(struct amdxdna_client *client)
@@ -131,11 +144,8 @@ static void amdxdna_client_cleanup(struct amdxdna_client *client)
 		drm_gem_object_put(to_gobj(client->dev_heap));
 
 	mutex_destroy(&client->mm_lock);
-
-	if (!IS_ERR_OR_NULL(client->sva))
-		iommu_sva_unbind_device(client->sva);
 	mmdrop(client->mm);
-
+	amdxdna_sva_fini(client);
 	kfree(client);
 }
 
@@ -242,15 +252,17 @@ static void amdxdna_show_fdinfo(struct drm_printer *p, struct drm_file *filp)
 
 	/*
 	 * Note for driver specific BO memory usage stat.
-	 * Total memory alloc = amdxdna-internal-alloc + amdxdna-external-alloc
+	 * Total memory in use = amdxdna-internal-alloc + amdxdna-external-alloc, which
+	 * includes both imported and created BOs. To avoid double counts, it includes
+	 * HEAP BO, but not DEV BO. DEV BO is counted by amdxdna-heap-alloc.
 	 */
 	drm_fdinfo_print_size(p, drv_name, "heap", "alloc", heap_usage);
 	drm_fdinfo_print_size(p, drv_name, "internal", "alloc", internal_usage);
 	drm_fdinfo_print_size(p, drv_name, "external", "alloc", external_usage);
 	/*
 	 * Note for DRM standard BO memory stat.
-	 * drm-total-memory counts both DEV BO and HEAP BO
-	 * drm-shared-memory counts BO imported
+	 * drm-total-memory counts both DEV BO and HEAP BO. The DEV BO size is double counted.
+	 * drm-shared-memory counts BO shared with other processes/devices.
 	 */
 	drm_show_memory_stats(p, filp);
 }
@@ -420,7 +432,26 @@ static struct pci_driver amdxdna_pci_driver = {
 	.sriov_configure = amdxdna_sriov_configure,
 };
 
-module_pci_driver(amdxdna_pci_driver);
+static int __init amdxdna_mod_init(void)
+{
+	int ret;
+
+	amdxdna_carveout_init();
+	ret = pci_register_driver(&amdxdna_pci_driver);
+	if (ret)
+		amdxdna_carveout_fini();
+
+	return ret;
+}
+
+static void __exit amdxdna_mod_exit(void)
+{
+	pci_unregister_driver(&amdxdna_pci_driver);
+	amdxdna_carveout_fini();
+}
+
+module_init(amdxdna_mod_init);
+module_exit(amdxdna_mod_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_IMPORT_NS("AMD_PMF");
diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.h b/drivers/accel/amdxdna/amdxdna_pci_drv.h
index bdd0dc83f92e..07bd38281452 100644
--- a/drivers/accel/amdxdna/amdxdna_pci_drv.h
+++ b/drivers/accel/amdxdna/amdxdna_pci_drv.h
@@ -172,11 +172,11 @@ void amdxdna_sysfs_fini(struct amdxdna_dev *xdna);
 
 int amdxdna_iommu_init(struct amdxdna_dev *xdna);
 void amdxdna_iommu_fini(struct amdxdna_dev *xdna);
-int amdxdna_iommu_map_bo(struct amdxdna_dev *xdna, struct amdxdna_gem_obj *abo);
-void amdxdna_iommu_unmap_bo(struct amdxdna_dev *xdna, struct amdxdna_gem_obj *abo);
 void *amdxdna_iommu_alloc(struct amdxdna_dev *xdna, size_t size, dma_addr_t *dma_addr);
 void amdxdna_iommu_free(struct amdxdna_dev *xdna, size_t size,
 			void *cpu_addr, dma_addr_t dma_addr);
+int amdxdna_dma_map_bo(struct amdxdna_dev *xdna, struct amdxdna_gem_obj *abo);
+void amdxdna_dma_unmap_bo(struct amdxdna_dev *xdna, struct amdxdna_gem_obj *abo);
 
 static inline bool amdxdna_iova_on(struct amdxdna_dev *xdna)
 {
-- 
2.34.1

