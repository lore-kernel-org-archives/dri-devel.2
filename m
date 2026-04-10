Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86174F44840
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 11:32:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D419210E942;
	Fri, 10 Apr 2026 11:32:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W28WfCmQ";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012041.outbound.protection.outlook.com
 [40.93.195.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AB6C10E940;
 Fri, 10 Apr 2026 11:32:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RzDj76Sp5Fpe3ekfmTqissZb3hYeZWat93CdCsZIPbP6BJcNmv33hSEmiVBAYyAMarkams0QzpBJlSEs9FO87+h1LcKM+zNM5Za5G8b2EiYBaWllBfqhyyuOyCZ87o8GbEsJ2/5zP3Ukgv0t/slulHD5MlGPm5Jgxztn16H3QaBZkOB1VftPc1pnlW841O104OysEtwJ2oTUjRSiXGSkquRf+Ymqg682hFIvPiMIlNzXnUX58dHGKuRs0YrrZBH91auetjPnmFOQ61lW7FoXA578be7svBsEr8A1PDEZfGJ1Dr9xhFdAv09F7B/8tPswX9JktSCfyLGBzSplc+s72Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tx2kB8BOo5SPT8yYrs4VrJGc590ksL3FTYHhNpqUE6c=;
 b=aASsKZcRpSqveUx6Gr7IVopOxE2qb6v9kKDnI+vReR5a1600WiNk0H1crsvJmW/ZkVZHHDq3IsHXqX0ir+NAjRzcx9+oJ37PJui3amQlRd2iifQewjzaK2niS6g1jlhPbOagZk8RvSBqKpCfQWJO3K8pf4CkbZNP7zIdFrYYI4U867Xc3NHdBF+xjkRaKbHAXTPpUcKNSuIzxvm9LtvragqidnZQQO2ue1C6QaBQgwtYNe3cT4wlPFu1x+lhltf7qdks2RbE0Xol3BEm3fGOijQrHZrNv0AC/T7HOAjahCzlFDZ5U4E78AegG0AFOMFxDOh0gtCQ7z63kYyfK0YHeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tx2kB8BOo5SPT8yYrs4VrJGc590ksL3FTYHhNpqUE6c=;
 b=W28WfCmQsoMEmY4H20PL3bqsqzkXGOUmsaO03sRZHYSqiGhT3LJjFEvkkX7yvAZbhyBLBZ1VHylvGUuB/V+GNSOyaxNQOM8FXCnfcYhEy6YfMS/NuJPHUC+fNrS/trc2ULEfJnykxRx9MOToYBA4TSn/Iwf92IpSEhtPaW1ySuM=
Received: from PH5P222CA0004.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:34b::7)
 by IA0PPF64A94D5DF.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Fri, 10 Apr
 2026 11:32:26 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:510:34b:cafe::96) by PH5P222CA0004.outlook.office365.com
 (2603:10b6:510:34b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.43 via Frontend Transport; Fri,
 10 Apr 2026 11:32:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 10 Apr 2026 11:32:24 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 10 Apr
 2026 06:31:57 -0500
Received: from junhua-PC.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 10 Apr 2026 06:31:54 -0500
From: Junhua Shen <Junhua.Shen@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <honglei1.huang@amd.com>, <Lingshan.Zhu@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <junhshen@amd.com>, Junhua Shen <Junhua.Shen@amd.com>
Subject: [PATCH RFC 2/6] drm/amdgpu: register ZONE_DEVICE for drm_pagemap SVM
 migration
Date: Fri, 10 Apr 2026 19:31:42 +0800
Message-ID: <20260410113146.146212-3-Junhua.Shen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260410113146.146212-1-Junhua.Shen@amd.com>
References: <20260410113146.146212-1-Junhua.Shen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|IA0PPF64A94D5DF:EE_
X-MS-Office365-Filtering-Correlation-Id: 056753da-d293-45dc-7671-08de96f4d69c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 4Q6wQnith9uOcHfdCQa7wFfD7bUULIcwdrVSByRgugnCLqNA0f4J358MP56ptdVqPqhpIGttlu52SBbEWi3KNEwiml4P5z61XXtIU/n3sJowxIxfPn0ZtVGe4odJLDv7wwNk38wJT7nHcLywZxYqLvuC5FkkSfxWgnGPwwK7cekITj6kQJ3QM7dEIc0BQMu17+Nwti9ZRePuShuwvFQ7cU2Niqr9GyCmk4pzGcM+udPo2ND4AfrVmIOW4A8d1k5QOS8sKkdnj2v7Rn2koZLpw1uNzvDkJJsEn0YrsOotMli+TF6OU+ctiMTkvwNvxzE0m//jalqNDDe9iifx6+67DT+I9VHaxutn1iAQ7pP3EFxdYXY+WJ3Gou3wgDarTetlpDWalwxVWkgroJB3RsyDDydaGzFn66Pv66pyH2cxjc13lw/CxS8vInRL3xotkVAhoibKudN1nPyYTomGCfS9nAvu7sCRcB0k/ywmhnhillGApLvDsDOhazrlqHMWHMLsIOsJtAno3iv9A29jqleE/SI73XrX8xKSrmyHwUS+wrSeG9oeYFAffA5XNKFZCWpw42yDYYhWZte8YRhbcKIk+BQRmRy8fOeR5D4G4Ry2oUmalqQl7A5Wl1xYgUNPlbcOTRKZx9xKSBDvYnJ6F0bDEKne8yNDBtgTXDoqZ0X7rH6VXN+Wj0i1eFJHWNvzz7425JRGs7SHfJ18j7Fmm3qAI2PDmJmBVdh3oQ9cbbej4S25TEgO/xfQieXd1R0HYDZTKqvzhhgA50gWrEbV1s6PUl0CVhxIou0VLAC+3GNQAhQ7iXQ6ZOZP+KtLtiW0tLPF
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(921020)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lNghGr+Es+qkENCpNnfSS7kTmDQmeS5NV4x2OsDtwskHkqydUZRpVrM/Yusss/BfhzsPIP9X88NiGE0Bo7wlJ/xwBXYLPv7BbH9xW5qab4NSFX1kWO1sHGr8mJWDf5SMCW9spOtpRi2Ab3O1KzTatOfhMtV7OPOOf6UjMeWSBYgTnPbB0HH/+MRWTNxA2XULIkHFO24WTd61tAnX4N/81Rho7NmlgQ5poFIBAPeDvILFEc2jR06lr3Aq/kaoW3H3rYKDPGbu+82cFOLVCZchvJPEhC9TtSX3YRuMzQULydEp1W0/z7var/WaFH9rrNCHfRKCMJToI5h6QjsweXEmBc4baDuHixNV32kAqHOcpYIPA9WMYysNE5jUeWMFQXxOAaQu1fz9jKLIr4o74MTAWk/SZSXoqNLztyTV3vgK+QNQoTFh0S9AjPE9gizBbsZK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 11:32:24.9291 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 056753da-d293-45dc-7671-08de96f4d69c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF64A94D5DF
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

Register the GPU's VRAM as a ZONE_DEVICE region via devm_memremap_pages()
and initialize the drm_pagemap (dpagemap) wrapper used by the DRM GPUSVM
migration framework.

Signed-off-by: Junhua Shen <Junhua.Shen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile         |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h  |  10 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |   9 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c | 171 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.h |  67 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c   |   4 +
 6 files changed, 265 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 7700f81a246e..e64abb5c8ab8 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -323,12 +323,14 @@ amdgpu-$(CONFIG_HMM_MIRROR) += amdgpu_hmm.o
 
 # svm support
 amdgpu-$(CONFIG_DRM_AMDGPU_SVM) += amdgpu_svm.o amdgpu_svm_attr.o \
-	amdgpu_svm_range.o
+	amdgpu_svm_range.o amdgpu_migrate.o
 
 .PHONY: clean-svm
 clean-svm:
 	rm -f $(obj)/amdgpu_svm.o $(obj)/amdgpu_svm_attr.o $(obj)/amdgpu_svm_range.o \
-	      $(obj)/.amdgpu_svm.o.cmd $(obj)/.amdgpu_svm_attr.o.cmd $(obj)/.amdgpu_svm_range.o.cmd
+	      $(obj)/amdgpu_migrate.o \
+	      $(obj)/.amdgpu_svm.o.cmd $(obj)/.amdgpu_svm_attr.o.cmd $(obj)/.amdgpu_svm_range.o.cmd \
+	      $(obj)/.amdgpu_migrate.o.cmd
 
 include $(FULL_AMD_PATH)/pm/Makefile
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 844f622f55b0..c6d75d997cc7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -444,6 +444,16 @@ int kgd2kfd_init_zone_device(struct amdgpu_device *adev)
 }
 #endif
 
+#if IS_ENABLED(CONFIG_DRM_AMDGPU_SVM)
+int amdgpu_svm_migration_init(struct amdgpu_device *adev);
+#else
+static inline
+int amdgpu_svm_migration_init(struct amdgpu_device *adev)
+{
+	return 0;
+}
+#endif
+
 /* KGD2KFD callbacks */
 int kgd2kfd_quiesce_mm(struct mm_struct *mm, uint32_t trigger);
 int kgd2kfd_resume_mm(struct mm_struct *mm);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index fbe553c38583..14dd112a7298 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2467,6 +2467,11 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 
 	/* Don't init kfd if whole hive need to be reset during init */
 	if (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI) {
+#if IS_ENABLED(CONFIG_DRM_AMDGPU_SVM)
+		amdgpu_svm_migration_init(adev);
+#else
+		kgd2kfd_init_zone_device(adev);
+#endif
 		amdgpu_amdkfd_device_init(adev);
 	}
 
@@ -4076,7 +4081,11 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	/* Don't init kfd if whole hive need to be reset during init */
 	if (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI) {
+#if IS_ENABLED(CONFIG_DRM_AMDGPU_SVM)
+		amdgpu_svm_migration_init(adev);
+#else
 		kgd2kfd_init_zone_device(adev);
+#endif
 		kfd_update_svm_support_properties(adev);
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c
new file mode 100644
index 000000000000..32632e544d33
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c
@@ -0,0 +1,171 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+/**
+ * DOC: AMDGPU SVM Migration
+ *
+ * This file implements the drm_pagemap-based migration infrastructure for
+ * AMDGPU SVM. It provides the callbacks that the DRM GPUSVM / drm_pagemap
+ * framework needs to:
+ *
+ * 1. Map ZONE_DEVICE pages to GPU-visible VRAM MC addresses (device_map)
+ * 2. Allocate VRAM and migrate pages from system memory (populate_mm)
+ * 3. Copy data between RAM and VRAM using SDMA (copy_to_devmem / copy_to_ram)
+ * 4. Release VRAM backing when pages migrate back to system memory (devmem_release)
+ *
+ * Architecture overview::
+ *
+ *   adev->kfd.apagemap.dpagemap   (struct drm_pagemap)
+ *       .ops = &amdgpu_svm_drm_pagemap_ops
+ *           |
+ *       +---+-------------------+
+ *       |                       |
+ *  .populate_mm            .device_map
+ *  (alloc BO + migrate)    (page -> VRAM MC addr)
+ *       |
+ *       v
+ *   drm_pagemap_devmem_ops  (per-BO migration mechanics)
+ *       .populate_devmem_pfn  -> BO buddy blocks -> PFN array
+ *       .copy_to_devmem       -> SDMA copy RAM -> VRAM
+ *       .copy_to_ram          -> SDMA copy VRAM -> RAM
+ *       .devmem_release       -> release BO reference
+ *
+ * The three address spaces involved:
+ *
+ *   VRAM offset  [0, real_vram_size)     - buddy allocator managed
+ *       + hpa_base
+ *   HPA / PFN    [hpa_base, hpa_base+..) - ZONE_DEVICE struct page management
+ *       + vm_manager.vram_base_offset
+ *   PTE address  [vram_base_offset, ..]  - GPU page table entries (from MMHUB FB_OFFSET)
+ */
+
+#include <drm/drm_pagemap.h>
+#include <linux/memremap.h>
+#include <linux/migrate.h>
+
+#include "amdgpu_amdkfd.h"
+#include "amdgpu_migrate.h"
+#include "amdgpu.h"
+
+static inline struct amdgpu_pagemap *
+dpagemap_to_apagemap(struct drm_pagemap *dpagemap)
+{
+	return container_of(dpagemap, struct amdgpu_pagemap, dpagemap);
+}
+
+static inline struct amdgpu_device *
+dpagemap_to_adev(struct drm_pagemap *dpagemap)
+{
+	return drm_to_adev(dpagemap->drm);
+}
+
+/**
+ * amdgpu_svm_page_to_apagemap - Get amdgpu_pagemap from a ZONE_DEVICE page
+ * @page: A ZONE_DEVICE page backed by VRAM
+ *
+ * Follows: page -> pgmap -> container_of(apagemap)
+ */
+static inline struct amdgpu_pagemap *
+amdgpu_svm_page_to_apagemap(struct page *page)
+{
+	struct dev_pagemap *pgmap = page_pgmap(page);
+
+	return container_of(pgmap, struct amdgpu_pagemap, pgmap);
+}
+
+
+const struct drm_pagemap_ops amdgpu_svm_drm_pagemap_ops = { };
+
+/**
+ * amdgpu_svm_migration_init - Register ZONE_DEVICE and initialize drm_pagemap
+ * @adev: AMDGPU device to set up VRAM migration for
+ *
+ * Allocates a ZONE_DEVICE region covering the GPU's VRAM, registers it
+ * via devm_memremap_pages() with drm_pagemap's generic dev_pagemap_ops,
+ * and then initializes the drm_pagemap (dpagemap) that provides the
+ * device_map / populate_mm callbacks for the DRM GPUSVM migration path.
+ *
+ * For XGMI-connected CPUs, uses the device's aperture directly
+ * (MEMORY_DEVICE_COHERENT).  For discrete GPUs, requests a free
+ * iomem region for MEMORY_DEVICE_PRIVATE pages.
+ *
+ * Return: 0 on success, -EINVAL if GPU IP too old, negative error on failure
+ */
+int amdgpu_svm_migration_init(struct amdgpu_device *adev)
+{
+	struct amdgpu_pagemap *svm_dm = &adev->kfd.apagemap;
+	struct dev_pagemap *pgmap = &svm_dm->pgmap;
+	struct resource *res = NULL;
+	unsigned long size;
+	void *r;
+
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(9, 0, 1))
+		return -EINVAL;
+
+	if (adev->apu_prefer_gtt)
+		return 0;
+
+	memset(pgmap, 0, sizeof(*pgmap));
+
+	size = ALIGN(adev->gmc.real_vram_size, 2ULL << 20);
+	if (adev->gmc.xgmi.connected_to_cpu) {
+		pgmap->range.start = adev->gmc.aper_base;
+		pgmap->range.end = adev->gmc.aper_base + adev->gmc.aper_size - 1;
+		pgmap->type = MEMORY_DEVICE_COHERENT;
+	} else {
+		res = devm_request_free_mem_region(adev->dev, &iomem_resource, size);
+		if (IS_ERR(res))
+			return PTR_ERR(res);
+		pgmap->range.start = res->start;
+		pgmap->range.end = res->end;
+		pgmap->type = MEMORY_DEVICE_PRIVATE;
+	}
+
+	pgmap->nr_range = 1;
+	pgmap->flags = 0;
+	pgmap->ops = drm_pagemap_pagemap_ops_get();
+	pgmap->owner = AMDGPU_SVM_PGMAP_OWNER(adev);
+
+	r = devm_memremap_pages(adev->dev, pgmap);
+	if (IS_ERR(r)) {
+		dev_err(adev->dev, "SVM: failed to register HMM device memory\n");
+		if (pgmap->type == MEMORY_DEVICE_PRIVATE && res)
+			devm_release_mem_region(adev->dev, res->start, resource_size(res));
+		pgmap->type = 0;
+		return PTR_ERR(r);
+	}
+
+	if (drm_pagemap_init(&svm_dm->dpagemap, pgmap, adev_to_drm(adev),
+							&amdgpu_svm_drm_pagemap_ops)) {
+		dev_err(adev->dev, "SVM: failed to init drm_pagemap\n");
+		return -EINVAL;
+	}
+	svm_dm->adev = adev;
+	svm_dm->hpa_base = pgmap->range.start;
+	svm_dm->initialized = true;
+
+	dev_info(adev->dev, "SVM: registered %ldMB device memory, hpa_base=0x%llx\n",
+			size >> 20, svm_dm->hpa_base);
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.h
new file mode 100644
index 000000000000..8cf177106163
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#ifndef __AMDGPU_MIGRATE_H__
+#define __AMDGPU_MIGRATE_H__
+
+#include <drm/drm_pagemap.h>
+
+struct amdgpu_device;
+
+/*
+ * AMDGPU_INTERCONNECT_VRAM - Protocol identifier for local VRAM access.
+ *
+ * Used in drm_pagemap_addr to distinguish device-local VRAM addresses from
+ * DMA-mapped system memory addresses.  drm_gpusvm_get_pages() uses this to
+ * identify pages that are already in device memory and need no DMA mapping.
+ *
+ * Value must be non-zero (0 == DRM_INTERCONNECT_SYSTEM).
+ */
+#define AMDGPU_INTERCONNECT_VRAM	1
+
+/*
+ * AMDGPU_SVM_PGMAP_OWNER - Unique owner token for dev_pagemap registration.
+ *
+ * migrate_vma_setup() uses pgmap->owner to distinguish "own" device pages
+ * from "foreign" device pages (e.g., another GPU in an XGMI hive).
+ * Pages whose page->pgmap->owner matches the migration source are skipped
+ * (they're already in the right place).
+ *
+ * For XGMI hive: all GPUs in the hive share the same owner (the hive pointer)
+ * so intra-hive pages are treated as local.
+ * For standalone GPU: use the apagemap address as a unique per-device token.
+ */
+#define AMDGPU_SVM_PGMAP_OWNER(adev) \
+	((adev)->hive ? (void *)(adev)->hive : (void *)&(adev)->kfd.apagemap)
+
+/**
+ * amdgpu_svm_drm_pagemap_ops - drm_pagemap_ops for AMDGPU VRAM migration
+ *
+ * Provides:
+ *   .device_map  - Convert ZONE_DEVICE page to VRAM address
+ *   .populate_mm - Allocate VRAM BO and migrate pages from system memory
+ */
+extern const struct drm_pagemap_ops amdgpu_svm_drm_pagemap_ops;
+
+#endif /* __AMDGPU_MIGRATE_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index 28c4ad62f50e..2dfe0cb1c631 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -87,7 +87,11 @@ static int amdgpu_reset_xgmi_reset_on_init_restore_hwctxt(
 		return r;
 	list_for_each_entry(tmp_adev, reset_device_list, reset_list) {
 		if (!tmp_adev->kfd.init_complete) {
+		#if IS_ENABLED(CONFIG_DRM_AMDGPU_SVM)
+			amdgpu_svm_migration_init(tmp_adev);
+		#else
 			kgd2kfd_init_zone_device(tmp_adev);
+		#endif
 			amdgpu_amdkfd_device_init(tmp_adev);
 			amdgpu_amdkfd_drm_client_create(tmp_adev);
 		}
-- 
2.34.1

