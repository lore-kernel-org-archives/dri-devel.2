Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22DE0CD4F24
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 09:57:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B06610EDA4;
	Wed, 13 May 2026 09:57:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="skfbFs5B";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012005.outbound.protection.outlook.com [52.101.48.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 552AB10E4B9;
 Wed, 13 May 2026 09:57:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qg+/P9wxPyuWHjYp5J3m7a+BSL2SKQ5DEXuEosw+CEKIxM4sycF3hno+z7qRgxfZ2aN2N9COCkDHyxhP7VqJNasJJIKxwnY3JvPw5Y5cfj+S9pGxgmlwrpQfuc+ki6S6yGumP/Ld9LbTjeRqplX/Z6dv+hTYSrSePR2K6mMQ8Z0nfn4tVe72HidrMAmkggJcwJq48Ma0d/MrWW3mEWCVT4GC2VeZFGuLcjhylv7p4ZnsFaBjPgExAmzp8fuLRxSW0eCovn1+RGVEMuCnOjqwbkSPG2KtQOFMdPBcXmyxJkeE3FdXL4FkgWdxrzHwE5ABu+FjzxbdgGOwQY/fAYfTtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9H0CcyXvCmEmBjvEsX3ZEaBjGrfQX3RXTemi7jZoui4=;
 b=jLzxJPQ3qAALb9k5U+Mu7L5Bfs4AihNWlqyjrLcE7USOpzDM1WecTcW6DEwkFw/BJfE65BEpLeH/9V4XBXd3OjNUxP2B8HVL8OKYqHSIzB+FncB8Hp86N7IpGju9asg+kvKf6dwkaf9LgE4pvcidj48UY2uhPgV0FisbWV4iZVa2h4aizmhF4WBOuo419mUzEdlAbHr8mQAe0/MdPO15EEJ7fJbuGYZygzZNHQg8l8YHcIJdsf2eF2jW4ZfcNjziDs8RYucAUzPYb/xE8K+BhsyVIye56PwoEruSR882AYxL3eoONLx+i9w0yM6n/IWSp5JvQ41qLdv8dYMCJrps9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9H0CcyXvCmEmBjvEsX3ZEaBjGrfQX3RXTemi7jZoui4=;
 b=skfbFs5ByRZ5pn4NdVS28YVlz4VtPpQGogXw1cxYSUAwAqD1f4wZYLl1PBeHI1pBVMRxTdX1v3pcTH4qb/YC6vZK2BhVVci+yNxBf2upRAshbnsRTWMyiHKVp8Noju97DumzEymevGxTa6fkQ1rqvlTGMxxBxtemnt0UAUefZWY=
Received: from DS7P220CA0079.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:259::11) by
 PH8PR12MB6820.namprd12.prod.outlook.com (2603:10b6:510:1cb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Wed, 13 May
 2026 09:57:43 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:8:259:cafe::42) by DS7P220CA0079.outlook.office365.com
 (2603:10b6:8:259::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Wed,
 13 May 2026 09:57:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 09:57:42 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 13 May
 2026 04:57:41 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 13 May
 2026 02:57:41 -0700
Received: from junhua-PC.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 13 May 2026 04:57:38 -0500
From: Junhua Shen <Junhua.Shen@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <honglei1.huang@amd.com>, <Lingshan.Zhu@amd.com>, <simona@ffwll.ch>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <Junhua.Shen@amd.com>
Subject: [PATCH v4 1/6] drm/amdgpu: add VRAM migration infrastructure for
 drm_pagemap
Date: Wed, 13 May 2026 17:57:29 +0800
Message-ID: <20260513095734.69598-2-Junhua.Shen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260513095734.69598-1-Junhua.Shen@amd.com>
References: <20260513095734.69598-1-Junhua.Shen@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|PH8PR12MB6820:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fe18d16-7f9b-4f50-748e-08deb0d612ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|921020|11063799003|3023799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: rGXTv7eYtlTMuuMndlFQi8YXPuwoytYGKFb/iXO49fC8ZG5Xjw0yqb9O0ght4IpbpjNPPBFgoDjm5Mc5FY++hBhwJBYWf3SIEFVGCmJvJZDz96+mwKPxwvVwBm4xqReDwbVE2ZHmsPcylmfAoZGg3/agCrz54vtFd5iVm552xU/ny/L86cXRKTbwo2znWLUmXfdZCk1XY3509fgahlB3k6yyH8aaAfCDdKx0ZK8KYKYA7gzx0Ir4+iuua8/60cWGY/f8howZ/2sLCW1mcHU3uvNvDO4pKa1HPS7gm/U7RJhr1v+Bt+/mZLuNSCXs2d6c/rKnr6vSb1AaxUoSaumQIwAUpCm5zJlh1ZHN+qJwW3q/wr6xVfOmdcFRKJ1VBT0u0bH1TY+UZnmmp7PvuT5n7PrcX9tnsBW/Klp9iywaIaoydmpoJPZ1I4Cj2cy7+tq6o+kd51rHCVkxRyKw3rDe4e4lrlN7ofolYIsDfoAAbJxAgOfRbWsF2bxIXxQeNHl+rEvXI+PAFnvE3WWx+u/xsbeyCk9QU39BqDIXGCy0hTSRi6bZyxat6iWi2u15sKtsvoe7vckof0R01F8Gl+fMxo2ph5pT0mEdeXg2AVM4/D4/lGyzXx47pZ3ytyXI6tn9K5/d+AP6e4BbaSe4kb0GDBqV5QgJo8VuQzEfNJzyCh56BkgRyEfwTvsXOZ3HBelY9uJ4IwblYo/IQqVYous4S+nd7yTWyASDTse0qM9oLOJv7JALcgWh0BSACpYrBMGbSNmBQIts6Bv/Rm+CpdOmKQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(921020)(11063799003)(3023799003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MJVwNAIvX/E+8Fz1ZnHDAF5GsYJkuk1C846+XSZS6YEunJivF3JFPFhwhiIL8ZA+C3MFFWst1639TAofXrz8lQucyePKrXf3fiVtYzbuA1IX7Mf1SkepAqbg4X6usOIzu0XitEmiObmaJs4faulNl7BGacdaIMVuBtygItk8XaQvDNuB+q8vntOBhkhiWziYqwa/9f1LOQnsgeOHJvcI46D2jhaxSyXDwYlyKRiKSIgoDGWtZPNcxhiWYAiI5rjvTc1KBv84R6k6xz60Vk6ZvO+EjKNlP4vL4j0DqzoqcnJrrCYY7nwzRIld3WwKGz+pC29EpWr4iPZrNr6Jz3G4vJ+UA7LQtcw6u+AgLHH0aByaeU8s/5ZgfR/3yxhRabk3IZzOgqJFtlDIOi0Ip6x8Dspc4Klz8U+XCGpA6+Ma5LNjChN0QGucXk/I8NPnW3bx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 09:57:42.0793 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fe18d16-7f9b-4f50-748e-08deb0d612ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6820
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

Add the drm_pagemap-based VRAM migration infrastructure:

- Define struct amdgpu_pagemap wrapping dev_pagemap + drm_pagemap
- Define AMDGPU_PGMAP_OWNER() and AMDGPU_INTERCONNECT_VRAM macros
- Implement amdgpu_svm_migration_init() to register ZONE_DEVICE via
  devm_memremap_pages() and initialize the drm_pagemap
- Add amdgpu_pagemap pointer (apagemap) to struct amdgpu_device

Signed-off-by: Junhua Shen <Junhua.Shen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile         |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |   8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c | 179 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.h |  98 +++++++++++
 4 files changed, 289 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index a40a42995b9a..3905a97795aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -323,12 +323,14 @@ amdgpu-$(CONFIG_HMM_MIRROR) += amdgpu_hmm.o
 
 # svm support
 amdgpu-$(CONFIG_DRM_AMDGPU_SVM) += amdgpu_svm.o amdgpu_svm_attr.o \
-	amdgpu_svm_fault.o amdgpu_svm_range.o
+	amdgpu_svm_fault.o amdgpu_svm_range.o amdgpu_migrate.o
 
 .PHONY: clean-svm
 clean-svm:
 	rm -f $(obj)/amdgpu_svm.o $(obj)/amdgpu_svm_attr.o $(obj)/amdgpu_svm_fault.o $(obj)/amdgpu_svm_range.o \
-	      $(obj)/.amdgpu_svm.o.cmd $(obj)/.amdgpu_svm_attr.o.cmd $(obj)/.amdgpu_svm_fault.o.cmd $(obj)/.amdgpu_svm_range.o.cmd
+	      $(obj)/amdgpu_migrate.o \
+	      $(obj)/.amdgpu_svm.o.cmd $(obj)/.amdgpu_svm_attr.o.cmd $(obj)/.amdgpu_svm_fault.o.cmd $(obj)/.amdgpu_svm_range.o.cmd \
+	      $(obj)/.amdgpu_migrate.o.cmd
 
 include $(FULL_AMD_PATH)/pm/Makefile
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 49e7881750fa..fe6ba9911d9f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -325,6 +325,7 @@ struct amdgpu_fpriv;
 struct amdgpu_bo_va_mapping;
 struct kfd_vm_fault_info;
 struct amdgpu_hive_info;
+struct amdgpu_pagemap;
 struct amdgpu_reset_context;
 struct amdgpu_reset_control;
 struct amdgpu_coredump_info;
@@ -1200,6 +1201,13 @@ struct amdgpu_device {
 
 	struct amdgpu_uma_carveout_info uma_info;
 
+#if IS_ENABLED(CONFIG_DRM_AMDGPU_SVM)
+	/* SVM VRAM migration via drm_pagemap (drm_gpusvm path).
+	 * Allocated in amdgpu_svm_migration_init(), NULL if SVM disabled.
+	 */
+	struct amdgpu_pagemap		*apagemap;
+#endif
+
 	/* KFD
 	 * Must be last --ends in a flexible-array member.
 	 */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c
new file mode 100644
index 000000000000..a8b067831b99
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c
@@ -0,0 +1,179 @@
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
+ *   adev->apagemap->dpagemap   (struct drm_pagemap)
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
+	struct amdgpu_pagemap *svm_dm;
+	struct dev_pagemap *pgmap;
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
+	if (adev->apagemap && adev->apagemap->initialized)
+		return 0;
+
+	svm_dm = devm_kzalloc(adev->dev, sizeof(*svm_dm), GFP_KERNEL);
+	if (!svm_dm)
+		return -ENOMEM;
+
+	pgmap = &svm_dm->pgmap;
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
+	pgmap->owner = AMDGPU_PGMAP_OWNER(adev);
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
+	adev->apagemap = svm_dm;
+
+	dev_info(adev->dev, "SVM: registered %ldMB device memory, hpa_base=0x%llx\n",
+			size >> 20, svm_dm->hpa_base);
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.h
new file mode 100644
index 000000000000..75796983f6a5
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.h
@@ -0,0 +1,98 @@
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
+#include <linux/memremap.h>
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
+ * AMDGPU_PGMAP_OWNER - Unique owner token for dev_pagemap registration.
+ *
+ * migrate_vma_setup() uses pgmap->owner to distinguish "own" device pages
+ * from "foreign" device pages (e.g., another GPU in an XGMI hive).
+ * Pages whose page->pgmap->owner matches the migration source are skipped
+ * (they're already in the right place).
+ *
+ * For XGMI hive: all GPUs in the hive share the same owner (the hive pointer)
+ * so intra-hive pages are treated as local.
+ * For standalone GPU: use the adev pointer itself as a unique per-device token.
+ */
+#define AMDGPU_PGMAP_OWNER(adev) \
+	((adev)->hive ? (void *)(adev)->hive : (void *)(adev))
+
+/**
+ * struct amdgpu_pagemap - VRAM migration infrastructure for drm_pagemap
+ * @dpagemap: DRM pagemap wrapper providing device_map/populate_mm callbacks
+ * @adev: back-pointer to the owning amdgpu_device
+ * @hpa_base: host physical address base of the ZONE_DEVICE region
+ * @initialized: set to true after successful registration
+ * @pgmap: the dev_pagemap registered with devm_memremap_pages();
+ *         must be last — contains a flexible-array member (ranges[])
+ *
+ * Allocated with devm_kzalloc() in amdgpu_svm_migration_init() and stored
+ * as adev->apagemap.  Lifetime is tied to the device via devres.
+ */
+struct amdgpu_pagemap {
+	struct drm_pagemap	dpagemap;
+	struct amdgpu_device	*adev;
+	resource_size_t		hpa_base;
+	bool			initialized;
+	struct dev_pagemap	pgmap;	/* must be last — flex-array */
+};
+
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
-- 
2.34.1

