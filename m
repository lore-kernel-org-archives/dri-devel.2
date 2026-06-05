Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8958CD6E7B
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 07:53:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D429611A53A;
	Fri,  5 Jun 2026 07:53:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fELVYy3x";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010020.outbound.protection.outlook.com [52.101.85.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 647A311A539;
 Fri,  5 Jun 2026 07:53:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i5Mk+w8PSGetBEq7yek4jANIcGPGeKTjdMKjI3WkFFF36BbE0EMbSXuFF552FNPlGFSv8kFgcJdmnrGcZ1j8I75B6Za/DXcEdY0eosz7unD+YKhQkIujtwo8dgDdVl91JrEXC+BHjUtFtr7fv5uC7ADfgEEuvKM2u6r5sAOKzL+rvBqDa0rbeUYML8Hv0GP4pRO71iHhLm1/K8hJON6xuNTognnxHQfg/nIjYrgZ2aCnhwDw2YAlhANFb7tVDZ+Kj/wRlWMdP7zDLZspWYQs/tit5RqLRs2KP4yqESHjKsx+/WZrD1I/iy6refZdgrCz/ujPRQsI0QQyZCs0BDZvnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9dsQfcZWsiGmYLevt3vZDOUuKrb35x+dbBAn3kT/3g4=;
 b=kn75ssc9NLeB/xqM4dRjdR62SPJCOt/NIdFJsA89N9m5j+3P8r1iFr4RTm22M3qch48qxM4fFAyehRDhR4F8/ilat2H/8Auv+9kPJnPapR9XJxy0kYg5aLts2QLWSnijkvEGFaK/HmkCrvz/RBf8j7Mefbv/eI2dLlVH7FGTXIA3U2MNt7x3vgIT6AYp5ZHtzGY17evzFi9n3/QmUS2/0NbYDnldhRG1/c1uPBB1PkCQ20zmh5wE2yTJx+WWlT9vjjQJDj4if909mphR0JtWpt+7s4nxUHkSMv8lnLqiSTSuutcc+TY7FxmFV/cpa6sN5gmhGWh8mna4HJSiXtb+aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9dsQfcZWsiGmYLevt3vZDOUuKrb35x+dbBAn3kT/3g4=;
 b=fELVYy3xY9ASO5YYjloGrIIzn4gNzpOF4pKADt/rJXoT4BddQRQb9t31814KZNd5B4mc2jYgGcRidnJxxzWqo+CV+rf+IK4WkZAUHan6oLUQ/SwRF21a+Xi8sK2oe5I9kfOpb0L0uHf54tRHzSi5XBAOoNDJYve2aEzqMBUIk7I=
Received: from BN9PR03CA0346.namprd03.prod.outlook.com (2603:10b6:408:f6::21)
 by SA1PR12MB8842.namprd12.prod.outlook.com (2603:10b6:806:378::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 07:53:51 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:f6:cafe::7c) by BN9PR03CA0346.outlook.office365.com
 (2603:10b6:408:f6::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Fri, 5
 Jun 2026 07:53:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 5 Jun 2026 07:53:51 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 02:53:50 -0500
Received: from junhua-PC.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 5 Jun 2026 02:53:47 -0500
From: Junhua Shen <Junhua.Shen@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <honglei1.huang@amd.com>, <Lingshan.Zhu@amd.com>, <simona@ffwll.ch>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <Junhua.Shen@amd.com>
Subject: [PATCH v5 2/8] drm/amdgpu: implement drm_pagemap SDMA migration
 callbacks
Date: Fri, 5 Jun 2026 15:53:34 +0800
Message-ID: <20260605075340.20199-3-Junhua.Shen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605075340.20199-1-Junhua.Shen@amd.com>
References: <20260605075340.20199-1-Junhua.Shen@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|SA1PR12MB8842:EE_
X-MS-Office365-Filtering-Correlation-Id: b05c4869-b366-4b68-7f64-08dec2d79572
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|921020|18002099003|22082099003|6133799003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: oD3x3TNaIo6EZWScMW+TEQcT6lFdHdJTJQZDcRCh9fKzlxRC4RQIqzFYJ4xpOqok7o6p7qKMELHZVaWMnVB3upWNpUUONwPQIuhMyOhSms83FGyaj7LPw/2uPho1Zmef01b6BjLOpPDbnEZT9T+0NqNarR7yX1IcZ8YSfIQUVeH9S7gE9wVCt7D21QpcDy91p6+SP/YJg+YY97PEIdc/GIzg3QdbBh7QT+6lQWaUXc5DuGCYN9BcJVgdgrEw/AqghVkUWfl4Ywa9Wxviy7K66AGrNA2n7V99E1y25R66dRJahXLsVWsm8yqx6AV1Ny78Ma1BrHCuIDVoVyeJqDhWs0KZBd+dt19j3hrtdCyHcpByaacf6ZVHJa+/b+t7B+bmKkHA0oQlQH0N4iPngq4pscuJM9CJYTONAH/aJI0gdqB5yW+dsD3+pntPIbHxPwC91/wszXPiu4HRNFDEn1UVsC04+Yjbj4PhZF4XDI1rCb/0Mpue37wEY6luo7AErBSDnplxLlcYSLCPZBKCwWaEvQL7x7TX36kPc7FMQeKBEPy+zp+PxdxxgfCOqZ0IqVHA2p5KutXRrVPWlsErB1olh81pP35oDmodcx6J3AmPmSBYGm8wc8mgjDyjPNuGt0P2J+MJ+0kRsJd0tkAz7+C5DnZ6+gNLgjy+iflBomOTpgYoCpSwl+o+zMJUj9IrCFFTgVyPwFnkgrK46Ra/0aNkrI8m+EGM3YLVbdnBtILdKjcJC6aXYvk/KlrI+BEEy2pSFQelh7Ljvg5DOTu2jonYAA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(921020)(18002099003)(22082099003)(6133799003)(3023799007)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: x+SrHkKBCSGhwTHl0XJlaf12Ti+aSwld7Z+ajnzDLIf3Z41dw4XaoX7swfv+TVf/NOQzL08CKmoHQhW4cAJZnTj8ls9Fx7jaq7rlkADUkApeGaY9ei1NzBf/YeZlYNmdD2DL9jXvH6CMIHk/ucxdqKoWx5ycN8I6SK44JNXwfA9ukf9SIC16C2EelAfNMWq2EAYhTln8HkIPIWrfJWBNxBUOfHd0DkfRwZjfDn3mnofYsQCLdkzpDzXzlj2JO51/7vskcsTExNCyyt3omlcIY3s5P//tstACio0wBi5y22tS8dRpWhCTcjb4XY0SJKlcSbkjo/gxl5QOFN4MXNIcgIjYN51oV+NwNJtcKNmoWjA9/8NUXUmLur4g9JXNtLMDVt8W0Zh03h7l4B5tHeWkQVeje5eWX/jdhntxXdueRXQk/Khmaoi7jAmHGzKQos01
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 07:53:51.3818 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b05c4869-b366-4b68-7f64-08dec2d79572
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8842
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c | 628 +++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.h |   3 +
 2 files changed, 629 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c
index 6b40f7477793..4d6ec19c4887 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c
@@ -64,9 +64,19 @@
 #include <linux/memremap.h>
 #include <linux/migrate.h>
 
-#include "amdgpu_amdkfd.h"
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
@@ -94,8 +104,622 @@ amdgpu_svm_page_to_apagemap(struct page *page)
 	return container_of(pgmap, struct amdgpu_pagemap, pgmap);
 }
 
+/* drm_pagemap_devmem_ops — per-BO migration mechanics */
+
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
+	drm_pagemap_devmem_init(&svm_bo->devmem,
+				adev->dev, mm,
+				&amdgpu_pagemap_ops,
+				dpagemap, size, NULL);
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
+	ret = drm_pagemap_migrate_to_devmem(&svm_bo->devmem,
+					     mm, start, end,
+					     &mdetails);
+
+	amdgpu_bo_unreserve(&svm_bo->bo);
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
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.h
index af42bd997d49..a196a11ff802 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.h
@@ -30,6 +30,9 @@
 
 struct amdgpu_device;
 
+#define AMDGPU_INTERCONNECT_VRAM	DRM_INTERCONNECT_DRIVER
+#define AMDGPU_INTERCONNECT_P2P		(AMDGPU_INTERCONNECT_VRAM + 1)
+
 /*
  * AMDGPU_PGMAP_OWNER - Unique owner token for dev_pagemap registration.
  *
-- 
2.34.1

