Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F69CCD6E7C
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 07:54:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1049411A53C;
	Fri,  5 Jun 2026 07:53:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LjVZ/0TU";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010058.outbound.protection.outlook.com [52.101.85.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A833711A539;
 Fri,  5 Jun 2026 07:53:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k6jI5pj+b4pBR4AeOrqQYFIl7Fu0O30v60+lRub1dkm2VmhyexDaplbnX7vPW6D62NP38azush2VpxL3RU+yMv89SzyPdRvfbsE2UQbKSXAfR8x0Ia4gDMqbLEOGLXjxt0RuTVFGgst8Ea6nStSu3uvWtzDWiaC1AOM+m+iNhiwzjKhf3zjIZ7bJ/uL+21lpGnlbGztlFpNfo6LTkYOYan6LAEChCsz6wS8lMUiubuv5AL+rQPXtq5DmkS66yMSa/KokBZD3nK4rInTf9xu0ox+FmeRbV78AJFdiQOPj9g1K2JgdMwCvxM6bHvzRil6DQ9CBUKr8mIROQPzjBGfguw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CBFjHzQTxzQayR77aRjoXu92yIcvKDgnGSno2+TKOSY=;
 b=guXpJ4l+tGwTQgquBB5/xn+NKbaFpQ/lR+XNsXFajutEkb+WU+EFqoOp58oObfEHInYgPYEVABKNGWGFpnhRagpIdQBFry58hXRWRPdj0eWxUWWpqHlnVPVABbrMY6WUTj+GAy909CSCiAzCEZCFn06CdW4bLl4dmJweq50WeRuTGh3Wo/kwk0Rqci4xy7CMvLKMxdlOP5yEF2bkg2E+iQ6qOAYdmA2LyuCzP+q0Qd8LjfTmTdvKgbJohG0xK4x/42biKXsBMOpFAtq8t7cEuxLAxqxSLt6k/ML5qhEGyo1xKQFi8dcRxKd/IMfkwkQ76k7/BJEWUVXsVeAFZqJ5rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBFjHzQTxzQayR77aRjoXu92yIcvKDgnGSno2+TKOSY=;
 b=LjVZ/0TUbyMxhvFuaqHtVuHdacglefcMTtgd70nm3zjjo+CvjvCjE1kEfkYmp9kxbYd2YpJGo9SaLxo3/wIm9bW0h1zeQ6uvViCodYOUfKUnKGjWedwv5FfHtBWsXlsmAwcsl5nTp1qUR527jcSaRct+Gns2nL+AuytsEiy4tiY=
Received: from BN1PR10CA0014.namprd10.prod.outlook.com (2603:10b6:408:e0::19)
 by CY8PR12MB7123.namprd12.prod.outlook.com (2603:10b6:930:60::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Fri, 5 Jun 2026
 07:53:48 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:408:e0:cafe::5c) by BN1PR10CA0014.outlook.office365.com
 (2603:10b6:408:e0::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Fri, 5
 Jun 2026 07:53:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 5 Jun 2026 07:53:47 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 02:53:47 -0500
Received: from junhua-PC.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 5 Jun 2026 02:53:44 -0500
From: Junhua Shen <Junhua.Shen@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <honglei1.huang@amd.com>, <Lingshan.Zhu@amd.com>, <simona@ffwll.ch>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <Junhua.Shen@amd.com>
Subject: [PATCH v5 1/8] drm/amdgpu: add VRAM migration infrastructure for
 drm_pagemap
Date: Fri, 5 Jun 2026 15:53:33 +0800
Message-ID: <20260605075340.20199-2-Junhua.Shen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605075340.20199-1-Junhua.Shen@amd.com>
References: <20260605075340.20199-1-Junhua.Shen@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|CY8PR12MB7123:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c1ecabb-5d39-4b65-9369-08dec2d79343
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|921020|3023799007|56012099006|11063799006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: KYP0RF7ulQr1fd1g8dl0NmuCwhH6/1BPJ69bnht9Qp77mEikm+GCT8jLDY6hHPbGkZ+y2arxFkeIN2uE4gAM2+xECGgnNTCPJul+Rx0bmDIYH45QFQttwpcNfXYrGXBv52UO+3w3m+r9B8/iQsxeWkOFY27NLl6xMIdn+/MfRzvmtRCpadYSNslugTv0jMMBbjYjBAk3dBQwQTdeJyPizwVwJ3O+eOutQWlgPGYPCPQtPJKS0cu8GxjG5+YdlROH45QQVmAZ3V1/gIIeWYkrnkmCzG/9kCjfmB9a0SDqxo4WzMgrF6QIo3ufFZMfU5bQ2fPzfy8ySK+FaDgFzosoiGSMOQaYFl3wCcccTbg8TlkhTQKfuc+4p8JBcETLbuHjpwd2Njggw3OFHMVOqNe6WuuwSZlnfmUitZi4F6vuPlzXyYmZ+KrIQUHguyMIhIily6Z/Y+KSe35MwIYCQ0Y/kyyhAzEhlOykS7pAJbM4GlkLyZhTE59kOOkWB/zfjnLL4Im3T9QoX8Xj7WbwMh8kdiQEpy4GKpjBoyFRnMwlF/s4Zjjxfjyf3yxkJUZ2FKxoEbuyF3VEy/+QHCiruG3h7w/Bj3WUikmWRHmm3xq+VCFgPANolAc8z/kKwLD8T6thnJ0wqeMQgsLQWfqMcA1flbKCX1oFmdCAu5ASmMCsIXZHh7gAh+NlJIbE/Cv+X+fpTRk6Yp+BMCEdlkPw+7f/meASteTwqvgcS8M6ln7XL5TKxZCwZxPnZsIOSHtxC+QifGzEY3DtROF/CNyA/wSYjw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(921020)(3023799007)(56012099006)(11063799006)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: N0Yw5C33bUATqzmfNzb4RnoOpjnUwL7/JvWmzTqOlX71tO3N3SV+TrnR6NMcdt9IpvcIzODnbB9APsEhTK0B4ROnYLaXOWeUdpKkSX/5FwAix/YpZSN0BLE+iIZvS2jEnkkMiSF5TrVPjcRyfmVeENiuNHBnTdzugxRcxmiBcVYbXVVyLPKlKIDHcj4nanjL/GgI+460malm8XPvSdzBrfzFitI6waYlydds9JYujjC1bscE8XJytnze/codPQbf1BTqajDPEFJakG3q3FAlCQRJ4yYkxF+1/nrsqrj2zfgBT/mZ+9me4/DHLQxCPKSboHwl8DXI1vPxVAWKOYAQJT7E9G35vPnsNy9FAYx8EaeVF4BVWFWrYpKE1WiD8xEHoIDZFJT3jq6c2T71pEd9LTOKC5+n2YyBBS6oVkeqfkPf2ZBjQWiKlUoSZtrzaAlx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 07:53:47.7227 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c1ecabb-5d39-4b65-9369-08dec2d79343
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7123
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
 drivers/gpu/drm/amd/amdgpu/Makefile         |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |   8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c | 179 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.h |  87 ++++++++++
 4 files changed, 279 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index b15a8e23e5f3..08207cad310d 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -328,12 +328,14 @@ amdgpu-$(CONFIG_HMM_MIRROR) += amdgpu_hmm.o
 
 # svm support
 amdgpu-$(CONFIG_DRM_AMDGPU_SVM) += amdgpu_svm.o amdgpu_svm_attr.o \
-	amdgpu_svm_fault.o amdgpu_svm_range.o amdgpu_userptr.o
+	amdgpu_svm_fault.o amdgpu_svm_range.o amdgpu_userptr.o amdgpu_migrate.o
 
 .PHONY: clean-svm
 clean-svm:
-	rm -f $(obj)/amdgpu_svm.o $(obj)/amdgpu_svm_attr.o $(obj)/amdgpu_svm_fault.o $(obj)/amdgpu_svm_range.o $(obj)/amdgpu_userptr.o \
-	      $(obj)/.amdgpu_svm.o.cmd $(obj)/.amdgpu_svm_attr.o.cmd $(obj)/.amdgpu_svm_fault.o.cmd $(obj)/.amdgpu_svm_range.o.cmd $(obj)/.amdgpu_userptr.o.cmd
+	rm -f $(obj)/amdgpu_svm.o $(obj)/amdgpu_svm_attr.o $(obj)/amdgpu_svm_fault.o $(obj)/amdgpu_svm_range.o \
+	      $(obj)/amdgpu_userptr.o $(obj)/amdgpu_migrate.o \
+	      $(obj)/.amdgpu_svm.o.cmd $(obj)/.amdgpu_svm_attr.o.cmd $(obj)/.amdgpu_svm_fault.o.cmd $(obj)/.amdgpu_svm_range.o.cmd \
+	      $(obj)/.amdgpu_userptr.o.cmd $(obj)/.amdgpu_migrate.o.cmd
 
 include $(FULL_AMD_PATH)/pm/Makefile
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 5d7bfa59424a..aece773037d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -326,6 +326,7 @@ struct amdgpu_fpriv;
 struct amdgpu_bo_va_mapping;
 struct kfd_vm_fault_info;
 struct amdgpu_hive_info;
+struct amdgpu_pagemap;
 struct amdgpu_reset_context;
 struct amdgpu_reset_control;
 struct amdgpu_coredump_info;
@@ -1158,6 +1159,13 @@ struct amdgpu_device {
 
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
index 000000000000..6b40f7477793
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c
@@ -0,0 +1,179 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
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
index 000000000000..af42bd997d49
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.h
@@ -0,0 +1,87 @@
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

