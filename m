Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30B76EBFD3A
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 10:30:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D26A610E400;
	Mon, 13 Apr 2026 10:30:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="swJPdPAR";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010068.outbound.protection.outlook.com [52.101.61.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EDBF10E402;
 Mon, 13 Apr 2026 10:30:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cRr1k4zRGN9X3Q5Pz7biQAEUqCHcTl8lg/FQDlTlgqBOncYYUrSCxTP5kZ2XTFk+qDb9djIn3n030p12JSDdmhU1JK8iObcJwXVpUyqW3PtYdOr1MQ/XigPqlWqeDAvXQR+y97zcD3sjpK/U0hWVqdRwh3cri7hZW+tbWhUPl5D0E5Qqlho6jM2J2Oc7n2ahIfeKKgoHmogQuKNvrLAAWSZlI3O18pxI07+YsWhVqjhm417hBJ9h5L8750hVB35aQ3zeidPAMpl5uJCAnxjOEITZnSA2og09aI8cFWTmcIdLafbTyfJB+8Fst5TBI9cix0zlS9CmbjFcXGdq+ShlXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SGwTtMHrBWO66ACqewZhXSbdBqBJXhlke5wtTJz3k7o=;
 b=umeMsKcVPGUToJsvFyU2XzIaOD2x07nbjRJ/Ya/+kUDgNVzSuMyUGePBhcDwnqsyT4zjiLrXg2OcLU0/PttFuD8UXM+9yyrihVdpjlp1XtmY0A1Cu/J1jKs20VGB32/fScMp6O+YUUqIunSwlFCakQsYVSMLpMI36JVo9T1INdFig6H6aOhgX7WBUSTSX3UNzKBChwkz6jhtrTPFepejNlvXLCRtv44qv3dkUN9PAJlN0xyD+DPZGJMpxJtS4j+xev9gV4q9gyRBJRLi6O3Lop9Gs2unQZFTUAgSM60Z1DJ9dvslL6M7E//eTs/FqPnc7nlRraCQ/NHxVAnZtGoPLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SGwTtMHrBWO66ACqewZhXSbdBqBJXhlke5wtTJz3k7o=;
 b=swJPdPAR9HNQ5aH9ZC55m+yVG1d8sZLf2q4nAUZf/yr/AaDmg6/UHR7xiUI3GKXzqyAL7sUvHLnamsA0B3kMLo7Cz/llhJhfA28Tt56ZlkW/PcxHcKx4n+0/MlcHBEZKi4xkNG0JfmNHclZUJtnsPgyra9GAoGel9ZwZQVvLhBY=
Received: from BY5PR20CA0034.namprd20.prod.outlook.com (2603:10b6:a03:1f4::47)
 by DS7PR12MB8369.namprd12.prod.outlook.com (2603:10b6:8:eb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Mon, 13 Apr
 2026 10:30:47 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::63) by BY5PR20CA0034.outlook.office365.com
 (2603:10b6:a03:1f4::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Mon,
 13 Apr 2026 10:30:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Mon, 13 Apr 2026 10:30:46 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Apr
 2026 05:30:45 -0500
Received: from junhua-PC.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 13 Apr 2026 05:30:42 -0500
From: Junhua Shen <Junhua.Shen@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <honglei1.huang@amd.com>, <Lingshan.Zhu@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <junhshen@amd.com>, Junhua Shen <Junhua.Shen@amd.com>
Subject: [PATCH v2 3/5] drm/amdgpu: implement drm_pagemap SDMA migration
 callbacks
Date: Mon, 13 Apr 2026 18:30:29 +0800
Message-ID: <20260413103031.181953-4-Junhua.Shen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260413103031.181953-1-Junhua.Shen@amd.com>
References: <20260413103031.181953-1-Junhua.Shen@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|DS7PR12MB8369:EE_
X-MS-Office365-Filtering-Correlation-Id: 9638d8ee-2fce-4de9-7fd9-08de9947b9a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: I7IDtFXiU1rw2pmVtPP8iilQZLPafoMRMBbM7f73aTpM2pfOogdnsu6p0XcUsQE/ThwAAd3keuqOfF0aXLacoFcOobo+vCV7cezxgP5AHgtatZMAAkolMeYR1FyPYksOmIJGqPikFkZORy4+Zn8Oa1OqZzIZ5z7JfiJRb7DfKWNh4TaQk+leF+n8wsRAEg62tGIRTKhR30/PNWqa9pdAG1olsyT6s3jk3oFvaN8oDe46AZqZ1UOq2ePPMMAiiAJ8P8h6dSydGYqUh6GOvE3MfssoMIuk2eEHaLyjb4Egmw0HjNjQHKYvLeGYvvxYaubDiKmqXejZj4R1yvnAkDZIH6wK+pv28KX6E4n0EQjBnCMsmbH8+HxNeCt06BuK0JlnkjNt34+290WG1x+aMccdI9624lLA9vGVd2TR3CQJZU94LUEmBb2+8m5s8PMq7zit3i9PEtQ7efkCMhw8b/7ROlgFRc6JTFdqgjcsK1un8A5VYKowGH7q62t5wSfvjFsEVVojCkw1KJCTRwrUjvnZCuxEDbcYIcwzEHFdvZzzOBmaDpa8LrN27rxxtTj87AtY9OSmUhY88RiYa+t57QYK1n9ToV2wXgx4Gj+dk5tO4gW1NPyOBX5cASVYOmlMsCnSVcNxC2DC1IV9P73fvX9f8u8yzj81emd3US/hVwxImaCYYNF1BopNgFRVwOevbmFG8OZviYYgUr7LOcpFlWd8xgcDGhx6UNFeYjkCs4Yhr3+f/AfV73BFF3Fzibn3L6QJi7VnlFDwQuyEr0iLmTgXILQgcjE7bmXY0Nt6e+Ulbs56Yp58rTq+hDh1KF8YF/8B
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: irrKUhvjxyhNn65e8H4reXc9DDsWqp4+pnv7sqSolAuBwZchq75gcZHe2PhAtjMQU9+1qK4Q0dlseOK0nWvlpAfEk/rFTjyde+Uwpg1bKaiUl8CUJvS9M858wsMaB04UktirY/mK4MJzuZ9icbQKs/fnBk/b4WbhUiTJTTPKm2rjZSRmp9TSBu26cA8hqPnLGyQyFEvvU4wXjfavSN3XU3fM7ifTYayUudy9VHCpIxc6dfP0IoAAHNoI2RVvPk9GvIbumIYcvaqeYrZQFQsul8+nWwi2ZLaXyuXZEWoxlt4F+6be+PPeSR5rpNpkXSjhTRCxVPYvWWrAaa4LSAIZ48TTZ5gs847PknyQwXraZT7trX5q5uxyTWW+rkiTE80rXFQH5Nnc8RiQu4FQnLKenNaA9RMHS/6dppK9U2G9K2p3DncH3xpovEf+45q5XqIx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 10:30:46.8337 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9638d8ee-2fce-4de9-7fd9-08de9947b9a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8369
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

Implement the drm_pagemap_devmem_ops and drm_pagemap_ops callbacks
that the DRM GPUSVM migration framework requires:

drm_pagemap_ops (top-level entry points):
  - device_map:   convert ZONE_DEVICE page to GPU PTE address
  - populate_mm:  allocate VRAM BO and trigger migration

drm_pagemap_devmem_ops (per-BO migration mechanics):
  - populate_devmem_pfn: walk BO buddy blocks to build PFN array
  - copy_to_devmem:      SDMA copy system RAM -> VRAM via GART window
  - copy_to_ram:         SDMA copy VRAM -> system RAM via GART window
  - devmem_release:      free BO when all pages migrate back

Signed-off-by: Junhua Shen <Junhua.Shen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c | 617 +++++++++++++++++++-
 1 file changed, 615 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c
index 58447d0d34bd..5d2ef3b28260 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c
@@ -64,9 +64,17 @@
 #include <linux/memremap.h>
 #include <linux/migrate.h>
 
-#include "amdgpu_amdkfd.h"
 #include "amdgpu_migrate.h"
 #include "amdgpu.h"
+#include "amdgpu_amdkfd.h"
+#include "amdgpu_ttm.h"
+
+#define AMDGPU_MIGRATE_TRACE(fmt, ...) \
+	pr_debug("%s: " fmt, __func__, ##__VA_ARGS__)
+
+/* SDMA copy direction */
+#define FROM_RAM_TO_VRAM	0
+#define FROM_VRAM_TO_RAM	1
 
 static inline struct amdgpu_pagemap *
 dpagemap_to_apagemap(struct drm_pagemap *dpagemap)
@@ -94,8 +102,613 @@ amdgpu_svm_page_to_apagemap(struct page *page)
 	return container_of(pgmap, struct amdgpu_pagemap, pgmap);
 }
 
+/* drm_pagemap_devmem_ops — per-BO migration mechanics */
+
+/**
+ * struct amdgpu_svm_bo - Wrapper linking drm_pagemap_devmem to amdgpu_bo
+ *
+ * @devmem: drm_pagemap device memory allocation (passed to framework)
+ * @bo: The backing VRAM amdgpu_bo
+ *
+ * It is allocated per-migration in populate_mm() and freed by
+ * devmem_release() when all device-private pages have migrated
+ * back to system memory.
+ *
+ * Lifecycle is managed by the drm_pagemap framework's internal zdd refcount:
+ *   - zdd->devmem_allocation points to &svm_bo->devmem
+ *   - When zdd refcount drops to zero, framework calls devmem_release()
+ *   - devmem_release() frees both the BO reference and the svm_bo itself
+ */
+struct amdgpu_svm_bo {
+	struct amdgpu_bo *bo;
+	struct drm_pagemap_devmem devmem;
+};
+
+static inline struct amdgpu_svm_bo *
+to_amdgpu_svm_bo(struct drm_pagemap_devmem *devmem_allocation)
+{
+	return container_of(devmem_allocation, struct amdgpu_svm_bo, devmem);
+}
+
+/**
+ * amdgpu_svm_devmem_release - Release BO when all device pages migrate back
+ *
+ * Called by the drm_pagemap framework (via drm_pagemap_zdd_destroy) when the
+ * last device-private page backed by this allocation has been migrated back
+ * to system memory (or the owning process exits).
+ *
+ * Frees both the amdgpu_bo reference and the wrapper amdgpu_svm_bo itself.
+ */
+static void
+amdgpu_svm_devmem_release(struct drm_pagemap_devmem *devmem_allocation)
+{
+	struct amdgpu_svm_bo *svm_bo = to_amdgpu_svm_bo(devmem_allocation);
+
+	AMDGPU_MIGRATE_TRACE("Release svm_bo=%px bo=%px\n", svm_bo, svm_bo->bo);
+	amdgpu_bo_unref(&svm_bo->bo);
+	kfree(svm_bo);
+}
+
+/**
+ * amdgpu_svm_populate_devmem_pfn - Convert BO VRAM allocation to PFN array
+ * @devmem_allocation: The devmem allocation in the amdgpu_svm_bo wrapper
+ * @npages: Number of PFN entries to fill
+ * @pfn: Output PFN array
+ *
+ * Iterates over the BO's TTM vram_mgr buddy blocks and converts each
+ * block's VRAM offset to ZONE_DEVICE PFNs:
+ *
+ *   PFN = PHYS_PFN(block_offset + apagemap.hpa_base) + page_index
+ *
+ * This is called by drm_pagemap_migrate_to_devmem() to build the
+ * destination PFN array for migrate_vma_pages().
+ *
+ * Return: 0 on success
+ */
+static int
+amdgpu_svm_populate_devmem_pfn(struct drm_pagemap_devmem *devmem_allocation,
+				unsigned long npages, unsigned long *pfn)
+{
+	struct amdgpu_svm_bo *svm_bo = to_amdgpu_svm_bo(devmem_allocation);
+	struct amdgpu_bo *bo = svm_bo->bo;
+	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
+	struct amdgpu_pagemap *svm_dm = &adev->kfd.apagemap;
+	struct amdgpu_vram_mgr_resource *ares;
+	struct drm_buddy_block *block;
+	struct ttm_resource *res;
+	unsigned long j = 0;
+	int ret;
+
+	ret = amdgpu_bo_reserve(bo, false);
+	if (ret)
+		return ret;
+
+	res = bo->tbo.resource;
+	ares = to_amdgpu_vram_mgr_resource(res);
+
+	list_for_each_entry(block, &ares->blocks, link) {
+		u64 block_offset = amdgpu_vram_mgr_block_start(block);
+		u64 block_pfn = PHYS_PFN(block_offset + svm_dm->hpa_base);
+		u64 block_pages = amdgpu_vram_mgr_block_size(block) >> PAGE_SHIFT;
+		unsigned long i;
+
+		for (i = 0; i < block_pages && j < npages; i++, j++)
+			pfn[j] = block_pfn + i;
+	}
+
+	amdgpu_bo_unreserve(bo);
+
+	AMDGPU_MIGRATE_TRACE("populate_devmem_pfn: npages=%lu first_pfn=0x%lx\n",
+			  npages, npages > 0 ? pfn[0] : 0);
+
+	return 0;
+}
+
+/* SDMA copy helpers — GART window based data transfer */
+
+/**
+ * amdgpu_svm_direct_mapping_addr - Convert VRAM offset to MC address
+ * @adev: AMDGPU device
+ * @vram_offset: Byte offset within VRAM
+ *
+ * Return: MC address suitable for SDMA src/dst
+ */
+static u64
+amdgpu_svm_direct_mapping_addr(struct amdgpu_device *adev, u64 vram_offset)
+{
+	return vram_offset + amdgpu_ttm_domain_start(adev, TTM_PL_VRAM);
+}
+
+/**
+ * amdgpu_svm_gart_map - Map system DMA addresses into GART window
+ * @ring: SDMA ring for the GART update job
+ * @npages: Number of pages to map
+ * @addr: Array of system memory DMA addresses
+ * @gart_addr: Output — GART base address to use in SDMA copy
+ * @flags: PTE flags (e.g. writeable for RAM-to-VRAM src)
+ *
+ * Builds GART PTEs pointing at the given DMA addresses, submits an
+ * SDMA job to update the GART entries, and returns the GART address
+ * that can be used as src or dst in a subsequent amdgpu_copy_buffer().
+ *
+ * Uses GART window 0, protected by gtt_window_lock.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int
+amdgpu_svm_gart_map(struct amdgpu_ring *ring,
+		     struct amdgpu_ttm_buffer_entity *entity,
+		     u64 npages,
+		     dma_addr_t *addr, u64 *gart_addr, u64 flags)
+{
+	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_job *job;
+	unsigned int num_dw, num_bytes;
+	struct dma_fence *fence;
+	u64 src_addr, dst_addr;
+	u64 pte_flags;
+	void *cpu_addr;
+	int r;
+
+	/* Use entity's GART window 0 */
+	*gart_addr = amdgpu_compute_gart_address(&adev->gmc, entity, 0);
+
+	num_dw = ALIGN(adev->mman.buffer_funcs->copy_num_dw, 8);
+	num_bytes = npages * 8 * AMDGPU_GPU_PAGES_IN_CPU_PAGE;
+
+	r = amdgpu_job_alloc_with_ib(adev, &entity->base,
+				     AMDGPU_FENCE_OWNER_UNDEFINED,
+				     num_dw * 4 + num_bytes,
+				     AMDGPU_IB_POOL_DELAYED,
+				     &job,
+				     AMDGPU_KERNEL_JOB_ID_KFD_GART_MAP);
+	if (r)
+		return r;
+
+	src_addr = num_dw * 4;
+	src_addr += job->ibs[0].gpu_addr;
+
+	dst_addr = amdgpu_bo_gpu_offset(adev->gart.bo);
+	dst_addr += (entity->gart_window_offs[0] >> AMDGPU_GPU_PAGE_SHIFT) * 8;
+	amdgpu_emit_copy_buffer(adev, &job->ibs[0], src_addr,
+				dst_addr, num_bytes, 0);
+
+	amdgpu_ring_pad_ib(ring, &job->ibs[0]);
+	WARN_ON(job->ibs[0].length_dw > num_dw);
+
+	pte_flags = AMDGPU_PTE_VALID | AMDGPU_PTE_READABLE;
+	pte_flags |= AMDGPU_PTE_SYSTEM | AMDGPU_PTE_SNOOPED;
+	if (!(flags & AMDGPU_PTE_WRITEABLE))
+		pte_flags |= AMDGPU_PTE_WRITEABLE;
+	pte_flags |= adev->gart.gart_pte_flags;
+
+	cpu_addr = &job->ibs[0].ptr[num_dw];
+
+	amdgpu_gart_map(adev, 0, npages, addr, pte_flags, cpu_addr);
+	fence = amdgpu_job_submit(job);
+	dma_fence_put(fence);
+
+	return 0;
+}
+
+/**
+ * amdgpu_svm_copy_memory_gart - SDMA copy between system RAM and VRAM
+ * @adev: AMDGPU device
+ * @sys: Array of DMA addresses for system memory pages
+ * @vram: Array of VRAM byte offsets (relative to start of VRAM)
+ * @npages: Number of pages to copy
+ * @direction: FROM_RAM_TO_VRAM or FROM_VRAM_TO_RAM
+ * @mfence: In/out — carries the last SDMA fence for serialization
+ *
+ * Maps system memory pages into the GART window and uses SDMA to copy
+ * data to/from VRAM. Handles splitting into AMDGPU_GTT_MAX_TRANSFER_SIZE
+ * chunks. Acquires entity->lock internally to protect the GART window,
+ * matching the KFD svm_migrate_copy_memory_gart() pattern.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int
+amdgpu_svm_copy_memory_gart(struct amdgpu_device *adev, dma_addr_t *sys,
+			    u64 *vram, u64 npages, int direction,
+			    struct dma_fence **mfence)
+{
+	const u64 max_pages = AMDGPU_GTT_MAX_TRANSFER_SIZE;
+	struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
+	struct amdgpu_ttm_buffer_entity *entity = &adev->mman.move_entity;
+	u64 gart_s, gart_d;
+	struct dma_fence *next;
+	u64 size;
+	int r;
+
+	mutex_lock(&entity->lock);
+
+	while (npages) {
+		size = min(max_pages, npages);
+
+		if (direction == FROM_VRAM_TO_RAM) {
+			gart_s = amdgpu_svm_direct_mapping_addr(adev, *vram);
+			r = amdgpu_svm_gart_map(ring, entity, size, sys, &gart_d, 0);
+		} else {
+			r = amdgpu_svm_gart_map(ring, entity, size, sys, &gart_s,
+						AMDGPU_PTE_WRITEABLE);
+			gart_d = amdgpu_svm_direct_mapping_addr(adev, *vram);
+		}
+		if (r) {
+			dev_err(adev->dev, "failed %d to map GART for SDMA\n", r);
+			goto out_unlock;
+		}
+
+		AMDGPU_MIGRATE_TRACE("SDMA_COPY: %s npages=%llu vram_off=0x%llx\n",
+				  direction == FROM_RAM_TO_VRAM ? "RAM->VRAM" : "VRAM->RAM",
+				  size, (u64)*vram);
+
+		r = amdgpu_copy_buffer(adev, entity, gart_s, gart_d,
+				       size * PAGE_SIZE,
+				       NULL, &next, true, 0);
+		if (r) {
+			dev_err(adev->dev, "failed %d to copy buffer\n", r);
+			goto out_unlock;
+		}
+
+		dma_fence_put(*mfence);
+		*mfence = next;
+		npages -= size;
+		if (npages) {
+			sys += size;
+			vram += size;
+		}
+	}
+
+out_unlock:
+	mutex_unlock(&entity->lock);
+
+	return r;
+}
+
+/**
+ * amdgpu_svm_copy_to_devmem - SDMA copy system memory -> VRAM
+ * @pages: Array of destination ZONE_DEVICE pages (VRAM-backed)
+ * @pagemap_addr: Array of source DMA addresses (system memory, already mapped)
+ * @npages: Number of pages to copy
+ *
+ * Builds parallel sys[] and vram[] arrays from the framework-provided
+ * pagemap_addr and device pages, then submits batched SDMA copies via
+ * the GART window.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int
+amdgpu_svm_copy_to_devmem(struct page **pages,
+			   struct drm_pagemap_addr *pagemap_addr,
+			   unsigned long npages,
+			   struct dma_fence *pre_migrate_fence)
+{
+	struct amdgpu_device *adev;
+	struct amdgpu_pagemap *svm_dm;
+	struct dma_fence *mfence = NULL;
+	dma_addr_t *sys;
+	u64 *vram;
+	unsigned long i, j;
+	int ret = 0;
+
+	if (!npages)
+		return 0;
+
+	/*
+	 * Find the first non-NULL page to derive the device.
+	 * The pages array may contain NULL entries for positions where
+	 * no valid device page exists.
+	 */
+	for (i = 0; i < npages; i++) {
+		if (pages[i])
+			break;
+	}
+	if (i == npages)
+		return 0;
+
+	svm_dm = amdgpu_svm_page_to_apagemap(pages[i]);
+	adev = svm_dm->adev;
+
+	sys = kvcalloc(npages, sizeof(*sys), GFP_KERNEL);
+	vram = kvcalloc(npages, sizeof(*vram), GFP_KERNEL);
+	if (!sys || !vram) {
+		ret = -ENOMEM;
+		goto out_free;
+	}
+
+	for (i = 0, j = 0; i < npages; i++) {
+		if (!pagemap_addr[i].addr)
+			goto flush;
+
+		sys[j] = pagemap_addr[i].addr;
+		vram[j] = ((u64)page_to_pfn(pages[i]) << PAGE_SHIFT) -
+			  svm_dm->hpa_base;
+
+		/* Check if next vram page is contiguous with current */
+		if (j > 0 && vram[j] != vram[j - 1] + PAGE_SIZE)
+			goto flush;
+
+		j++;
+		continue;
+flush:
+		if (j) {
+			ret = amdgpu_svm_copy_memory_gart(adev, sys, vram, j,
+							  FROM_RAM_TO_VRAM,
+							  &mfence);
+			if (ret)
+				goto out_fence;
+			j = 0;
+		}
+		/* Re-process current page if it was valid but broke contiguity */
+		if (pagemap_addr[i].addr) {
+			sys[0] = pagemap_addr[i].addr;
+			vram[0] = ((u64)page_to_pfn(pages[i]) << PAGE_SHIFT) -
+				  svm_dm->hpa_base;
+			j = 1;
+		}
+	}
+
+	/* Flush remaining batch */
+	if (j)
+		ret = amdgpu_svm_copy_memory_gart(adev, sys, vram, j,
+						  FROM_RAM_TO_VRAM, &mfence);
+
+out_fence:
+	if (mfence) {
+		dma_fence_wait(mfence, false);
+		dma_fence_put(mfence);
+	}
+
+	AMDGPU_MIGRATE_TRACE("copy_to_devmem done: npages=%ld ret=%d\n",
+			  npages, ret);
+
+out_free:
+	kvfree(vram);
+	kvfree(sys);
+	return ret;
+}
+
+/**
+ * amdgpu_svm_copy_to_ram - SDMA copy VRAM -> system memory
+ * @pages: Array of source ZONE_DEVICE pages (VRAM-backed)
+ * @pagemap_addr: Array of destination DMA addresses (system memory, already mapped)
+ * @npages: Number of pages to copy
+ *
+ * Mirror of copy_to_devmem with src/dst swapped.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int
+amdgpu_svm_copy_to_ram(struct page **pages,
+			struct drm_pagemap_addr *pagemap_addr,
+			unsigned long npages,
+			struct dma_fence *pre_migrate_fence)
+{
+	struct amdgpu_device *adev;
+	struct amdgpu_pagemap *svm_dm;
+	struct dma_fence *mfence = NULL;
+	dma_addr_t *sys;
+	u64 *vram;
+	unsigned long i, j;
+	int ret = 0;
+
+	if (!npages)
+		return 0;
+
+	for (i = 0; i < npages; i++) {
+		if (pages[i])
+			break;
+	}
+	if (i == npages)
+		return 0;
+
+	svm_dm = amdgpu_svm_page_to_apagemap(pages[i]);
+	adev = svm_dm->adev;
+
+	sys = kvcalloc(npages, sizeof(*sys), GFP_KERNEL);
+	vram = kvcalloc(npages, sizeof(*vram), GFP_KERNEL);
+	if (!sys || !vram) {
+		ret = -ENOMEM;
+		goto out_free;
+	}
+
+	for (i = 0, j = 0; i < npages; i++) {
+		if (!pagemap_addr[i].addr || !pages[i])
+			goto flush;
+
+		vram[j] = ((u64)page_to_pfn(pages[i]) << PAGE_SHIFT) -
+			  svm_dm->hpa_base;
+		sys[j] = pagemap_addr[i].addr;
+
+		/* Check if next vram page is contiguous with current */
+		if (j > 0 && vram[j] != vram[j - 1] + PAGE_SIZE)
+			goto flush;
+
+		j++;
+		continue;
+flush:
+		if (j) {
+			ret = amdgpu_svm_copy_memory_gart(adev, sys, vram, j,
+							  FROM_VRAM_TO_RAM,
+							  &mfence);
+			if (ret)
+				goto out_fence;
+			j = 0;
+		}
+		/* Re-process current page if it was valid but broke contiguity */
+		if (pagemap_addr[i].addr && pages[i]) {
+			vram[0] = ((u64)page_to_pfn(pages[i]) << PAGE_SHIFT) -
+				  svm_dm->hpa_base;
+			sys[0] = pagemap_addr[i].addr;
+			j = 1;
+		}
+	}
+
+	/* Flush remaining batch */
+	if (j)
+		ret = amdgpu_svm_copy_memory_gart(adev, sys, vram, j,
+						  FROM_VRAM_TO_RAM, &mfence);
+
+out_fence:
+	if (mfence) {
+		dma_fence_wait(mfence, false);
+		dma_fence_put(mfence);
+	}
+
+	AMDGPU_MIGRATE_TRACE("copy_to_ram done: npages=%ld ret=%d\n", npages, ret);
+
+out_free:
+	kvfree(vram);
+	kvfree(sys);
+	return ret;
+}
+
+static const struct drm_pagemap_devmem_ops amdgpu_pagemap_ops = {
+	.devmem_release      = amdgpu_svm_devmem_release,
+	.populate_devmem_pfn = amdgpu_svm_populate_devmem_pfn,
+	.copy_to_devmem      = amdgpu_svm_copy_to_devmem,
+	.copy_to_ram         = amdgpu_svm_copy_to_ram,
+};
+
+/* drm_pagemap_ops — top-level migration entry points */
+
+/**
+ * amdgpu_svm_device_map - Convert ZONE_DEVICE page to GPU PTE address
+ * @dpagemap: The drm_pagemap for this device
+ * @dev: Requesting device (for P2P check)
+ * @page: ZONE_DEVICE page backed by VRAM
+ * @order: Page order (0 = 4K, 9 = 2M, etc.)
+ * @dir: DMA direction (unused for local VRAM)
+ *
+ * Address conversion chain:
+ *   page -> PFN -> HPA -> VRAM offset -> PTE address
+ *
+ *   HPA = page_to_pfn(page) << PAGE_SHIFT
+ *   VRAM offset = HPA - apagemap.hpa_base
+ *   PTE address = VRAM offset + adev->vm_manager.vram_base_offset
+ *
+ * Return: drm_pagemap_addr with PTE address and AMDGPU_INTERCONNECT_VRAM protocol
+ */
+static struct drm_pagemap_addr
+amdgpu_svm_device_map(struct drm_pagemap *dpagemap,
+		       struct device *dev,
+		       struct page *page,
+		       unsigned int order,
+		       enum dma_data_direction dir)
+{
+	struct amdgpu_pagemap *svm_dm = dpagemap_to_apagemap(dpagemap);
+	struct amdgpu_device *adev = dpagemap_to_adev(dpagemap);
+	dma_addr_t addr;
+
+	if (dpagemap->drm->dev == dev) {
+		/* Same device: return VRAM PTE address */
+		u64 hpa = (u64)page_to_pfn(page) << PAGE_SHIFT;
+		u64 vram_offset = hpa - svm_dm->hpa_base;
+
+		addr = vram_offset + adev->vm_manager.vram_base_offset;
+	} else {
+		/* Cross-device P2P: not yet supported */
+		addr = DMA_MAPPING_ERROR;
+	}
+
+	return drm_pagemap_addr_encode(addr,
+				AMDGPU_INTERCONNECT_VRAM, order, dir);
+}
+
+/**
+ * amdgpu_svm_bo_alloc - Allocate an amdgpu_svm_bo wrapper with VRAM backing
+ * @adev: AMDGPU device
+ * @dpagemap: The drm_pagemap for this device
+ * @mm: mm_struct of the owning process
+ * @size: Allocation size in bytes
+ *
+ * Return: Pointer to allocated amdgpu_svm_bo on success, ERR_PTR on failure
+ */
+static struct amdgpu_svm_bo *
+amdgpu_svm_bo_alloc(struct amdgpu_device *adev,
+		     struct drm_pagemap *dpagemap,
+		     struct mm_struct *mm, unsigned long size)
+{
+	struct amdgpu_svm_bo *svm_bo;
+	struct amdgpu_bo_param bp = {};
+	struct amdgpu_bo *bo;
+	int ret;
+
+	svm_bo = kzalloc(sizeof(*svm_bo), GFP_KERNEL);
+	if (!svm_bo)
+		return ERR_PTR(-ENOMEM);
+
+	bp.size = size;
+	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
+	bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
+	bp.type = ttm_bo_type_device;
+	bp.flags = AMDGPU_GEM_CREATE_NO_CPU_ACCESS |
+		   AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
+		   AMDGPU_GEM_CREATE_VRAM_CLEARED;
+
+	ret = amdgpu_bo_create(adev, &bp, &bo);
+	if (ret) {
+		AMDGPU_MIGRATE_TRACE("Failed to create SVM BO\n");
+		kfree(svm_bo);
+		return ERR_PTR(ret);
+	}
+
+	amdgpu_bo_unreserve(bo);
+	svm_bo->bo = bo;
+
+	drm_pagemap_devmem_init(&svm_bo->devmem,
+				adev->dev, mm,
+				&amdgpu_pagemap_ops,
+				dpagemap, size, NULL);
+
+	return svm_bo;
+}
+
+/**
+ * amdgpu_svm_populate_mm - Allocate VRAM BO and migrate pages
+ * @dpagemap: The drm_pagemap for this device
+ * @start: Start virtual address of the range to migrate
+ * @end: End virtual address (exclusive)
+ * @mm: mm_struct of the owning process
+ * @timeslice_ms: Maximum time to spend migrating (for fairness)
+ *
+ * Core migration entry point called by drm_pagemap_populate_mm().
+ * Allocates an amdgpu_svm_bo via amdgpu_svm_bo_alloc(), then calls
+ * drm_pagemap_migrate_to_devmem() to execute the actual migration.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int
+amdgpu_svm_populate_mm(struct drm_pagemap *dpagemap,
+			unsigned long start, unsigned long end,
+			struct mm_struct *mm,
+			unsigned long timeslice_ms)
+{
+	struct amdgpu_device *adev = dpagemap_to_adev(dpagemap);
+	struct drm_pagemap_migrate_details mdetails = {
+		.timeslice_ms = timeslice_ms,
+	};
+	struct amdgpu_svm_bo *svm_bo;
+	int ret;
+
+	svm_bo = amdgpu_svm_bo_alloc(adev, dpagemap, mm, end - start);
+	if (IS_ERR(svm_bo))
+		return PTR_ERR(svm_bo);
+
+	AMDGPU_MIGRATE_TRACE("populate_mm: [0x%lx-0x%lx] size=%lu\n",
+			  start, end, end - start);
+
+	ret = drm_pagemap_migrate_to_devmem(&svm_bo->devmem,
+					     mm, start, end,
+					     &mdetails);
+
+	return ret;
+}
 
-const struct drm_pagemap_ops amdgpu_svm_drm_pagemap_ops = { };
+const struct drm_pagemap_ops amdgpu_svm_drm_pagemap_ops = {
+	.device_map = amdgpu_svm_device_map,
+	.populate_mm = amdgpu_svm_populate_mm,
+};
 
 /**
  * amdgpu_svm_migration_init - Register ZONE_DEVICE and initialize drm_pagemap
-- 
2.34.1

