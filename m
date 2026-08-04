Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 747DCC55172
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 09:44:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA28210E969;
	Tue,  4 Aug 2026 09:44:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OBQ63aJ+";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012011.outbound.protection.outlook.com [52.101.53.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5242810E965;
 Tue,  4 Aug 2026 09:44:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fFcrFmdKcgoiwxYHybIPzwNDfZc4zryfSH2iobd2h9t/cD+sMjL/KdBfl6kf2CaY6f7haZdztPcmFRJDYtS8neioB+ROOoU7F4m+abIotblshLkH8OnpzauJ9PtIDcMK6hHkkjDmiD7yJHoads8/+fNROkBFpWGt4mRcOPf4yQqITnNSlxS78fs4M2QaaI4X1rTH05bqnstcWCIsRV0YZIMIqiD9dOdHNNhN2iylycW3jscjrBu3f0SHnQsicTyPLJfU1k9BsUbpUSigO73utbD/3uOXVwqH8C/J90PVTnZfcPisvcyUryIvnvqRRUf2t1m+bgly4IWg3RVNgwaoLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=//nAGHWklxrqStsOnhwhHYEecYrUvJCmoliOWsDvz6c=;
 b=RzsKBIILD7KYqcXSc/uPNW58yoRTRwDOj7VDRGs0deoue1Usk9+03pxdqapnise9AbEs0k0Jy69TCzuIddTEVV1r3lQbmo4ZyVGWv3v81S418H+HrjDJdgOcze30RmwfcHlLu6mO8hqWeA9CEQsvhGG0nEWN+fctL4vZzU1Q22rjNOwxZUWikY+W29+TtHC9wW5Myow5JWLRjtTvXeiJfOpwTy04fWY4+faCIJqXCka3aNKyHY0ojYOsXoe+QEHDiZpXT1EEGmZof97fV33fhBsukDg1jaaRHD5L2R5AAfdtgqI2KsAsxxgZowaRNidgfEy1mfkRd0juIqxExmQwvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//nAGHWklxrqStsOnhwhHYEecYrUvJCmoliOWsDvz6c=;
 b=OBQ63aJ+hJEn9h7nYMa8JcEh3FsSMT15JpIahZeWaMG8gNcwIeffjFZPPwuUy0dIdiP++osuwY5zWZdXoB0yl9WaUVkcum8AIlTGX9jcAJl0gRz7f08i151k76op+v8X8DPQW46YnlWbTpQwJs/R3NC3//P/1GvqacgUs7P4KdA=
Received: from MW4PR03CA0235.namprd03.prod.outlook.com (2603:10b6:303:b9::30)
 by IA0PR12MB8086.namprd12.prod.outlook.com (2603:10b6:208:403::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 09:44:11 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:303:b9:cafe::2b) by MW4PR03CA0235.outlook.office365.com
 (2603:10b6:303:b9::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.18 via Frontend Transport; Tue, 4
 Aug 2026 09:44:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 09:44:10 +0000
Received: from hr-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 4 Aug
 2026 04:44:05 -0500
From: Huang Rui <ray.huang@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, Alex Deucher <alexander.deucher@amd.com>, "Felix
 Kuehling" <felix.kuehling@amd.com>, Simona Vetter <simona@ffwll.ch>, "Matthew
 Brost" <matthew.brost@intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: Xiaogang Chen <xiaogang.chen@amd.com>, Oak Zeng <Oak.Zeng@amd.com>, "Jenny
 Liu" <Jenny-Jing.Liu@amd.com>, Zhu Lingshan <lingshan.zhu@amd.com>,
 "Honglei
 Huang" <honglei1.huang@amd.com>, Junhua Shen <Junhua.Shen@amd.com>, Yiru Ma
 <yiru.ma@amd.com>, Huang Rui <ray.huang@amd.com>
Subject: [PATCH v9 14/18] drm/amdgpu: implement drm_pagemap SDMA migration
 callbacks
Date: Tue, 4 Aug 2026 17:42:40 +0800
Message-ID: <20260804094246.1719318-15-ray.huang@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260804094246.1719318-1-ray.huang@amd.com>
References: <20260804094246.1719318-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|IA0PR12MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: ac2c764a-1adb-4bf0-022a-08def20cef6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|921020|6133799003|56012099006|11063799006|10067099003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 3GxLEQhf/GhDVLlAwC4zdFFpcxDqVZ80WmWsnx9An1OR2i8GuQNoKzIPMbV6a0CD1uYyTzeghdKLgJcvPL8b/zi78Xdy3muofpUbEdmuXm70m9B1z5Bscp+qTjdi71FXMI3pOpDO6edNhOA/uOgzaFRsvgeH5Gv55QLx0isCn106AwzbnzVwRECGh8q8jFciahQfYci+YI9Tx9LPvXfLX0FYpZYAyHjlmVmAfsThyexuq8Y3+WuBXGbJW3n0fTcv9JxL44TMjIp/k1rigxRlWDeEse3q/CbBRcvPY2URL5Fb3AWHRfDpnrL73LJO1foV+HRLEwG5p8N9wni1s3lR65du5REOc7WqA4g+C1ZYWzjVqpPg6YJB4G3qcvRWX3PS+tLaQpGlFOPJMd1n/hPqnz2qaS32WqhXaJEcv+X3ILeCN0+b5ZTWzRMcO0cReJj9XrL2NdAoWaO9FfjdtUBsN5P0LaNV016JND60dMIWgrlrqcx+SbTmDLacnoac68AdTsBrRvC0Le26KsAqrDngo/BVUwSIrhXDupjFqoCJCRATVWbG4Q0JhCsT6eAtjScDay/+2SRol+8wNa5zYph/tkLvXFOdeAwhHekl/NtBvzR2Y0DMDLm8BzgOS03fusPMCEZaVMv852RIFKIU3wK8hRSieo8b4gcMw5BJTL7BD6eJuT2BCE6Fn2Cr/QOX2mMf3LjENKgmTZ6VPNomUOesZdjPCaFdWm/EDEzQj4HOA0hQ+QSy0OrnSXd20kp1YofL
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(921020)(6133799003)(56012099006)(11063799006)(10067099003)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jI87EnBSt3rdmo6Zin4HXMeQPfuvjEZe04ZjWV2CL67ZrxWCUWp2XuP7dtzoW4EZvgk4cbNhM58sUE2pjhFXqbl5sMLP8qfnIO9VKjtSyshduINzBVCU4Z1wd6R1S7BilL4UDHfLsGayM/jIKd+z1u1gEGprK1nrGdkNBmUZJoIHcaB2Kq0fz7J8rptYZjr8A1yed4AB24djMeW+BsdJY7LEeiB3gOUrrtdBG3uzjfpEjs42ztppT2eY+q3YLb2KquNeGsDKxT+pKjRQDULXmSseRfQTICA1R1ss6jaAj+MNMscYp8U0YQJMYCjTO21ydnZZZMlKNfFk7/DgS4b47kF1Ek/EzVQW/hYPnWqBm8Ufr2hSvgGTbY3N6EA/9T1rK5j6WkvSIDFdU8WKcxg4QkOaSd8ZTReGpAeKx/fDWCWDtZXC0R3RVhBQetPU7moO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 09:44:10.2576 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac2c764a-1adb-4bf0-022a-08def20cef6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8086
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

From: Junhua Shen <Junhua.Shen@amd.com>

Implement the drm_pagemap_devmem_ops and drm_pagemap_ops callbacks
that the DRM GPUSVM migration framework requires.

Introduce struct amdgpu_bo_svm as a BO subtype (following the
amdgpu_bo_user/amdgpu_bo_vm pattern) that embeds struct amdgpu_bo
and carries a drm_pagemap_devmem allocation.

drm_pagemap_ops (top-level entry points):
  - device_map:   convert ZONE_DEVICE page to GPU PTE address
  - populate_mm:  allocate amdgpu_bo_svm and trigger migration

drm_pagemap_devmem_ops (per-BO migration mechanics):
  - populate_devmem_pfn: walk BO buddy blocks to build PFN array
  - copy_to_devmem:      SDMA copy system RAM -> VRAM via GART window
  - copy_to_ram:         SDMA copy VRAM -> system RAM via GART window
  - devmem_release:      drop BO ref (triggers destroy to free amdgpu_bo_svm)

Signed-off-by: Junhua Shen <Junhua.Shen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c | 652 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.h |   3 +
 2 files changed, 655 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c
index 054520d3ff1f7..6aeba9220ac41 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c
@@ -67,6 +67,17 @@
 
 #include "amdgpu_migrate.h"
 #include "amdgpu.h"
+#include "amdgpu_ttm.h"
+#include "amdgpu_res_cursor.h"
+
+#define AMDGPU_MIGRATE_TRACE(fmt, ...) \
+	pr_debug("%s: " fmt, __func__, ##__VA_ARGS__)
+
+/* SDMA copy direction */
+#define FROM_RAM_TO_VRAM	0
+#define FROM_VRAM_TO_RAM	1
+
+static const struct drm_pagemap_devmem_ops amdgpu_pagemap_ops;
 
 static inline struct amdgpu_pagemap *
 dpagemap_to_apagemap(struct drm_pagemap *dpagemap)
@@ -94,6 +105,645 @@ amdgpu_svm_page_to_apagemap(struct page *page)
 	return container_of(pgmap, struct amdgpu_pagemap, pgmap);
 }
 
+/**
+ * struct amdgpu_bo_svm - SVM BO subtype with drm_pagemap devmem allocation
+ *
+ * @bo: Embedded base amdgpu_bo
+ * @devmem: drm_pagemap device memory allocation (passed to framework)
+ *
+ * Lifecycle is managed by the drm_pagemap framework's internal zdd refcount:
+ *   - zdd->devmem_allocation points to &svm_bo->devmem
+ *   - When zdd refcount drops to zero, framework calls devmem_release()
+ *   - devmem_release() drops the BO reference (triggering destroy callback)
+ */
+struct amdgpu_bo_svm {
+	struct amdgpu_bo bo;
+	struct drm_pagemap_devmem devmem;
+};
+
+#define to_amdgpu_bo_svm(abo) container_of((abo), struct amdgpu_bo_svm, bo)
+
+static inline struct amdgpu_bo_svm *
+devmem_to_amdgpu_bo_svm(struct drm_pagemap_devmem *devmem_allocation)
+{
+	return container_of(devmem_allocation, struct amdgpu_bo_svm, devmem);
+}
+
+/**
+ * amdgpu_bo_svm_destroy - TTM destroy callback for SVM BO
+ *
+ * Called when the last reference to the BO is dropped.
+ * Follows amdgpu_bo_user_destroy pattern: delegates to amdgpu_bo_base_destroy.
+ */
+static void amdgpu_bo_svm_destroy(struct ttm_buffer_object *tbo)
+{
+	struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
+	struct amdgpu_bo_svm *svm_bo = to_amdgpu_bo_svm(bo);
+
+	amdgpu_bo_kunmap(bo);
+	drm_gem_object_release(&bo->tbo.base);
+	amdgpu_bo_unref(&bo->parent);
+	kvfree(svm_bo);
+}
+
+/**
+ * amdgpu_bo_svm_alloc - Allocate an amdgpu_bo_svm with VRAM backing
+ * @adev: AMDGPU device
+ * @dpagemap: The drm_pagemap for this device
+ * @mm: mm_struct of the owning process
+ * @size: Allocation size in bytes
+ *
+ * Uses bp->bo_ptr_size = sizeof(struct amdgpu_bo_svm) so that
+ * amdgpu_bo_create() allocates the full amdgpu_bo_svm structure,
+ * with the embedded amdgpu_bo as the base.
+ *
+ * Return: Pointer to allocated amdgpu_bo_svm on success, ERR_PTR on failure
+ */
+static struct amdgpu_bo_svm *
+amdgpu_bo_svm_alloc(struct amdgpu_device *adev,
+		     struct drm_pagemap *dpagemap,
+		     struct mm_struct *mm, unsigned long size)
+{
+	struct dma_fence *pre_migrate_fence = NULL;
+	struct amdgpu_bo_param bp = {};
+	struct amdgpu_bo_svm *svm_bo;
+	struct amdgpu_bo *bo;
+	int ret;
+
+	bp.size = size;
+	bp.bo_ptr_size = sizeof(struct amdgpu_bo_svm);
+	bp.destroy = &amdgpu_bo_svm_destroy;
+	bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
+	bp.type = ttm_bo_type_device;
+	bp.flags = AMDGPU_GEM_CREATE_NO_CPU_ACCESS |
+		   AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
+		   AMDGPU_GEM_CREATE_VRAM_CLEARED;
+
+	ret = amdgpu_bo_create(adev, &bp, &bo);
+	if (ret) {
+		AMDGPU_MIGRATE_TRACE("Failed to create SVM BO\n");
+		return ERR_PTR(ret);
+	}
+
+	svm_bo = to_amdgpu_bo_svm(bo);
+
+	/* Ensure any async VRAM operations complete before migration copy */
+	if (!dma_resv_test_signaled(bo->tbo.base.resv,
+					 DMA_RESV_USAGE_KERNEL)) {
+		ret = dma_resv_get_singleton(bo->tbo.base.resv,
+					      DMA_RESV_USAGE_KERNEL,
+					      &pre_migrate_fence);
+		if (ret) {
+			amdgpu_bo_unref(&bo);
+			return ERR_PTR(ret);
+		}
+	}
+	drm_pagemap_devmem_init(&svm_bo->devmem, adev->dev, mm,
+				&amdgpu_pagemap_ops, dpagemap, size,
+				pre_migrate_fence);
+
+	return svm_bo;
+}
+
+/**
+ * amdgpu_svm_devmem_release - Release BO when all device pages migrate back
+ *
+ * Called by the drm_pagemap framework (via drm_pagemap_zdd_destroy) when the
+ * last device-private page backed by this allocation has been migrated back
+ * to system memory (or the owning process exits).
+ *
+ * Drops the BO reference, which triggers the destroy callback to free
+ * the amdgpu_bo_svm structure.
+ */
+static void
+amdgpu_svm_devmem_release(struct drm_pagemap_devmem *devmem_allocation)
+{
+	struct amdgpu_bo_svm *svm_bo = devmem_to_amdgpu_bo_svm(devmem_allocation);
+	struct amdgpu_bo *bo = &svm_bo->bo;
+
+	AMDGPU_MIGRATE_TRACE("Release svm_bo=%px bo=%px\n", svm_bo, bo);
+	dma_fence_put(devmem_allocation->pre_migrate_fence);
+	devmem_allocation->pre_migrate_fence = NULL;
+	amdgpu_bo_unref(&bo);
+}
+
+/**
+ * amdgpu_svm_populate_devmem_pfn - Convert BO VRAM allocation to PFN array
+ * @devmem_allocation: The devmem allocation in the amdgpu_bo_svm wrapper
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
+	struct amdgpu_pagemap *svm_dm = dpagemap_to_apagemap(devmem_allocation->dpagemap);
+	struct amdgpu_bo_svm *svm_bo = devmem_to_amdgpu_bo_svm(devmem_allocation);
+	struct amdgpu_bo *bo = &svm_bo->bo;
+	struct amdgpu_res_cursor cursor;
+	unsigned long i = 0;
+
+	dma_resv_assert_held(bo->tbo.base.resv);
+
+	amdgpu_res_first(bo->tbo.resource, 0, npages << PAGE_SHIFT, &cursor);
+	while (cursor.remaining && i < npages) {
+		u64 pfn_base = PHYS_PFN(cursor.start + svm_dm->hpa_base);
+		u64 pages = cursor.size >> PAGE_SHIFT;
+		unsigned long j;
+
+		for (j = 0; j < pages && i < npages; j++, i++)
+			pfn[i] = pfn_base + j;
+
+		amdgpu_res_next(&cursor, cursor.size);
+	}
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
+				     AMDGPU_KERNEL_JOB_ID_KFD_GART_MAP,
+				     &job);
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
+	if (flags & AMDGPU_PTE_WRITEABLE)
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
+	struct amdgpu_ring *ring = to_amdgpu_ring(adev->mman.buffer_funcs_scheds[0]);
+	struct amdgpu_ttm_buffer_entity *entity = &adev->mman.move_entities[0];
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
+			r = amdgpu_svm_gart_map(ring, entity, size, sys,
+						&gart_d, AMDGPU_PTE_WRITEABLE);
+		} else {
+			r = amdgpu_svm_gart_map(ring, entity, size, sys,
+						&gart_s, 0);
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
+	/* Wait for async VRAM operations to complete before overwriting with data */
+	if (pre_migrate_fence)
+		dma_fence_wait(pre_migrate_fence, false);
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
+		if (pagemap_addr[i].addr && pages[i]) {
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
+	/* Wait for async VRAM operations to complete before reading data */
+	if (pre_migrate_fence)
+		dma_fence_wait(pre_migrate_fence, false);
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
+ * amdgpu_svm_populate_mm - Allocate VRAM BO and migrate pages
+ * @dpagemap: The drm_pagemap for this device
+ * @start: Start virtual address of the range to migrate
+ * @end: End virtual address (exclusive)
+ * @mm: mm_struct of the owning process
+ * @timeslice_ms: Maximum time to spend migrating (for fairness)
+ *
+ * Core migration entry point called by drm_pagemap_populate_mm().
+ * Allocates an amdgpu_bo_svm via amdgpu_bo_svm_alloc(), then calls
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
+	struct amdgpu_bo_svm *svm_bo;
+	int ret;
+
+	svm_bo = amdgpu_bo_svm_alloc(adev, dpagemap, mm, end - start);
+	if (IS_ERR(svm_bo))
+		return PTR_ERR(svm_bo);
+
+	AMDGPU_MIGRATE_TRACE("populate_mm: [0x%lx-0x%lx] size=%lu\n",
+			  start, end, end - start);
+
+	ret = amdgpu_bo_reserve(&svm_bo->bo, true);
+	if (ret) {
+		struct amdgpu_bo *bo = &svm_bo->bo;
+
+		amdgpu_bo_unref(&bo);
+		return ret;
+	}
+
+	ret = drm_pagemap_migrate_to_devmem(&svm_bo->devmem,
+					     mm, start, end,
+					     &mdetails);
+
+	amdgpu_bo_unreserve(&svm_bo->bo);
+
+	return ret;
+}
+
 /**
  * amdgpu_pagemap_destroy_work - Deferred destruction of amdgpu_pagemap
  * @work: work_struct embedded in amdgpu_pagemap
@@ -148,6 +798,8 @@ static void amdgpu_pagemap_destroy(struct drm_pagemap *dpagemap,
 
 const struct drm_pagemap_ops amdgpu_svm_drm_pagemap_ops = {
 	.destroy = amdgpu_pagemap_destroy,
+	.device_map = amdgpu_svm_device_map,
+	.populate_mm = amdgpu_svm_populate_mm,
 };
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.h
index f5f726a740469..56c66851f0a47 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.h
@@ -31,6 +31,9 @@
 
 struct amdgpu_device;
 
+#define AMDGPU_INTERCONNECT_VRAM	DRM_INTERCONNECT_DRIVER
+#define AMDGPU_INTERCONNECT_P2P		(AMDGPU_INTERCONNECT_VRAM + 1)
+
 /*
  * AMDGPU_PGMAP_OWNER - Unique owner token for dev_pagemap registration.
  *
-- 
2.53.0

