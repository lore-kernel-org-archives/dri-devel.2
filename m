Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03289C5518F
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 09:44:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30BDA10E972;
	Tue,  4 Aug 2026 09:44:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qxEJS/yA";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010023.outbound.protection.outlook.com [52.101.201.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5831410E969;
 Tue,  4 Aug 2026 09:44:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m1xz/60xancHo97hqcqTvPUvpuH1MQoHvU1zoQfMCcUU0gMN6FreWdy6YuyR73N43ab8mlYbiKbCzkmvF7d5dr3ltle7/Znqdx9dSw0JT8ivvgbkiOcaDyXfAjtKVLkFxpXwl4w9C4j45yzRaDyityuzJHcWxzuqaBhXZL79LDZaZbtFx+XxmkGJhXc5X5fOnnGIfjfHCgDOa2ih1Krp0gP349T0dTVsRiHDktTvI5lczEo4Lo/jisbSHoS/atz37zit4nmNDz31LscmuM77oC2a8Wct1TeV/Funh0ysRAh4JY+mGoIewFpZDojSo+bywq1aUz3aFbsCTJw75TuPBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7IvaSwRgLGfMC7KhwOZkVYS9IrlQU9W7B4fF8u558Q=;
 b=AhOfzsdVlWa9s2zs4frytGbu1uqUD2wbwxXCQSZurbDlEO6tMSF2KJjBqgWaEZ4IjDYHbaoGCCycbJDHm/2O3YAXyWoW9Y8WV6P1Q2fNwO8JhosM5VuCmEeMryNifB0L+nFsJcC7RedmvyHq0JIPfc9dJnJV9X5EKFwS5PyDiM5+zVXlHiwWIiBSu6cCkgbJUKZnoC0z0XPKrtLF1WsMGLXHX4IEiUtGhoPnExU6b+68wAiEfD4Y9F6CEoGtlWdWB2+GM0SGqzd5zIIc8J6y9P+5SwKhuAIEH0pxlfrMK+6FT121Vn9ZTIWm7oS61UkY5OBKLtJnVZEgyYErqrbOFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7IvaSwRgLGfMC7KhwOZkVYS9IrlQU9W7B4fF8u558Q=;
 b=qxEJS/yAvxeAC3Sify9qFr4ZhdlUDCmh0klYYgi0t4sTjfpbHTfRDRXH58+6NHSZ2gEvp2ho8tKvnUrOIUpCXYoyObffzMXrD7ZY7Q8OFm0YB61mFz4eLvIug2AqM5u/wHUaGM6R3XxPZBKF9Cdsv6kBP5Ri2RV6gUCSSKDq8DM=
Received: from MW4PR03CA0228.namprd03.prod.outlook.com (2603:10b6:303:b9::23)
 by CYYPR12MB8855.namprd12.prod.outlook.com (2603:10b6:930:bb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 09:44:12 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:303:b9:cafe::2c) by MW4PR03CA0228.outlook.office365.com
 (2603:10b6:303:b9::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.15 via Frontend Transport; Tue, 4
 Aug 2026 09:44:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 09:44:11 +0000
Received: from hr-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 4 Aug
 2026 04:44:00 -0500
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
Subject: [PATCH v9 13/18] drm/amdgpu: add VRAM migration infrastructure for
 drm_pagemap
Date: Tue, 4 Aug 2026 17:42:39 +0800
Message-ID: <20260804094246.1719318-14-ray.huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|CYYPR12MB8855:EE_
X-MS-Office365-Filtering-Correlation-Id: 44c2c2de-079c-4d06-bb06-08def20cf072
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|376014|82310400026|921020|56012099006|11063799006|3023799007|6133799003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: O10pLDeqjcHvaMg9QpmLkgOgXRM+/9IcN6vVt9o+UojiVNxakgYtkYHNVlAmTbwWQUM63oo1T7wrnHO3p7EwT8zn13PWXvgtLQxVQdNZu5OQPBPwenTkFMyXazuowMV4NrOj0ur6fGAQ06WYcbydMUjImQCH5liAjyL+f4P1NXMginByqCdMU1m33EPrsJvFxp2MswnuSeGradN/y0JxGfLehh9otdS1vEHQxCnw7ls/sq3nfrvNdXA9c0lRZ39F8FUxqVgwwgo7Iz3MFh/oS6SsKKgs2BxA3EbF5YY5mXOFBSF6m2L6CFxO7Dd2Hcpr0Io11y97ebJzNeoutZc12cNmnm41RucpH1g0o+8Bf6Nsrxq+bkBLZ1WPo2p3fLapPgbu0SmNy6s4AsTH2NwdqxR9Yb/PDcvIdy3qFKxeow5fAqM4hfeaQJrhxaHJHvXLHFX3TQemD8jIFunPKu/vUsZqYhOf247cpoEW3sbNriQdQjLlBIzkJo8DNchqGri0ZGsBYIjZSAV6t0gA5HPWAWHVbx4gMGHA3Slgvmq4KHUJ/0EahE1L4de63UT33FEFgIwvZLGNf5qqSPrAWa0wk4T8/BiGM52YORckyctspNJUDOIY6QAAYljnHNUG4t0WJ082Y21xDZzVT6mCvb2yhEh6/8ZpgPtqdJjUlyvxwmd3LSW9i1M7DhGpzVdrHONbok1C8gXHtsu22bgE237X4pqNy3IDltjwwykhZZQM3/gCLIcSh++tpzB5TOz4+oxZ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(82310400026)(921020)(56012099006)(11063799006)(3023799007)(6133799003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Re1xvl/Qr85ZB3hAObXdI16JTxGT/iFpsoyy2wO/inHIIhm1zbPIri7HnzhW72G5mfURNl4CuWL65hPMtf1yqEoTYkYQioBnoVEIKypX2/XP5un7mqEJSz9sIsz1MIcoKmu+/neWimD9QsZz8Z5g0ALXdnF73nkUfUmWWRdyh/AgCtVlxl6CoMUmG9eBNcIzpkjSogPT3XOjE5RQuMvRghnGq39xXpvXS5X0Exbwm+P4k/CFt8b+S82uyZaveL4iqLSPR5Ee7hY9SV/Kbfy6Njur4ROMbM5IFIt+tg16Vw5jQOuUa/36hXpJaeh5BxmmuhD80WDZU/RGqug67k/GseBuMkLfJH9WGfCMralKrY2lTEl6b8u2IZ78/FI7WlVOXsYjns6UWFTu6vYP7FT/Gtys4KQ47bhKSnd9/11JAcPZqliGauuZvO0n0DtWW/ja
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 09:44:11.9670 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c2c2de-079c-4d06-bb06-08def20cf072
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8855
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c | 252 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.h |  92 +++++++
 4 files changed, 356 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 884cdc5c1e4af..75047adbdd57b 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -324,12 +324,14 @@ amdgpu-$(CONFIG_HMM_MIRROR) += amdgpu_hmm.o
 
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
index 8326c18e07653..c36ffa5414977 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -328,6 +328,7 @@ struct amdgpu_fpriv;
 struct amdgpu_bo_va_mapping;
 struct kfd_vm_fault_info;
 struct amdgpu_hive_info;
+struct amdgpu_pagemap;
 struct amdgpu_reset_context;
 struct amdgpu_reset_control;
 struct amdgpu_coredump_info;
@@ -1129,6 +1130,13 @@ struct amdgpu_device {
 
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
index 0000000000000..054520d3ff1f7
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c
@@ -0,0 +1,252 @@
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
+#include <drm/drm_drv.h>
+#include <drm/drm_pagemap.h>
+#include <linux/memremap.h>
+#include <linux/migrate.h>
+
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
+/**
+ * amdgpu_pagemap_destroy_work - Deferred destruction of amdgpu_pagemap
+ * @work: work_struct embedded in amdgpu_pagemap
+ *
+ * Called when drm_pagemap refcount drops to zero.  Releases the
+ * ZONE_DEVICE mapping and frees the amdgpu_pagemap structure.
+ * Uses drm_dev_enter/exit to ensure device is still valid.
+ */
+static void amdgpu_pagemap_destroy_work(struct work_struct *work)
+{
+	struct amdgpu_pagemap *apagemap =
+		container_of(work, struct amdgpu_pagemap, destroy_work);
+	struct dev_pagemap *pgmap = &apagemap->pgmap;
+	struct drm_device *drm = apagemap->dpagemap.drm;
+	int idx;
+
+	/*
+	 * Only unmap/release if devm release hasn't run yet.
+	 * Otherwise the devm callbacks have already released, or
+	 * will do shortly.
+	 */
+	if (drm_dev_enter(drm, &idx)) {
+		devm_memunmap_pages(drm->dev, pgmap);
+		if (pgmap->type == MEMORY_DEVICE_PRIVATE)
+			devm_release_mem_region(drm->dev, pgmap->range.start,
+						pgmap->range.end - pgmap->range.start + 1);
+		drm_dev_exit(idx);
+	}
+
+	kfree(apagemap);
+}
+
+/**
+ * amdgpu_pagemap_destroy - drm_pagemap_ops.destroy callback
+ * @dpagemap: the drm_pagemap being destroyed
+ * @from_atomic_or_reclaim: true if called from atomic/reclaim context
+ *
+ * Called when the drm_pagemap refcount drops to zero.  If called from
+ * atomic or reclaim context, queues the destroy work to run later.
+ * Otherwise performs cleanup synchronously.
+ */
+static void amdgpu_pagemap_destroy(struct drm_pagemap *dpagemap,
+				   bool from_atomic_or_reclaim)
+{
+	struct amdgpu_pagemap *apagemap = dpagemap_to_apagemap(dpagemap);
+
+	if (from_atomic_or_reclaim)
+		schedule_work(&apagemap->destroy_work);
+	else
+		amdgpu_pagemap_destroy_work(&apagemap->destroy_work);
+}
+
+const struct drm_pagemap_ops amdgpu_svm_drm_pagemap_ops = {
+	.destroy = amdgpu_pagemap_destroy,
+};
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
+	struct amdgpu_pagemap *apagemap;
+	struct drm_pagemap *dpagemap;
+	struct dev_pagemap *pgmap;
+	struct resource *res = NULL;
+	unsigned long size;
+	void *r;
+	int err;
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
+	apagemap = kzalloc(sizeof(*apagemap), GFP_KERNEL);
+	if (!apagemap)
+		return -ENOMEM;
+
+	pgmap = &apagemap->pgmap;
+	dpagemap = &apagemap->dpagemap;
+	INIT_WORK(&apagemap->destroy_work, amdgpu_pagemap_destroy_work);
+	apagemap->adev = adev;
+
+	/* Initialize drm_pagemap first — takes refs on drm_device and module */
+	err = drm_pagemap_init(dpagemap, pgmap, adev_to_drm(adev),
+			       &amdgpu_svm_drm_pagemap_ops);
+	if (err) {
+		dev_err(adev->dev, "SVM: failed to init drm_pagemap\n");
+		goto err_free;
+	}
+
+	/* Now allocate ZONE_DEVICE resources */
+	size = ALIGN(adev->gmc.real_vram_size, 2ULL << 20);
+	if (adev->gmc.xgmi.connected_to_cpu) {
+		pgmap->range.start = adev->gmc.aper_base;
+		pgmap->range.end = adev->gmc.aper_base + adev->gmc.aper_size - 1;
+		pgmap->type = MEMORY_DEVICE_COHERENT;
+	} else {
+		res = devm_request_free_mem_region(adev->dev, &iomem_resource, size);
+		if (IS_ERR(res)) {
+			err = PTR_ERR(res);
+			goto err_pagemap;
+		}
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
+		err = PTR_ERR(r);
+		goto err_mem_region;
+	}
+
+	apagemap->hpa_base = pgmap->range.start;
+	apagemap->initialized = true;
+	adev->apagemap = apagemap;
+
+	dev_info(adev->dev, "SVM: registered %ldMB device memory, hpa_base=0x%llx\n",
+		 size >> 20, apagemap->hpa_base);
+	return 0;
+
+err_mem_region:
+	if (pgmap->type == MEMORY_DEVICE_PRIVATE && res)
+		devm_release_mem_region(adev->dev, res->start, resource_size(res));
+	pgmap->type = 0;
+err_pagemap:
+	drm_pagemap_put(dpagemap);
+	return err;
+
+err_free:
+	kfree(apagemap);
+	return err;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.h
new file mode 100644
index 0000000000000..f5f726a740469
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.h
@@ -0,0 +1,92 @@
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
+#include <linux/workqueue.h>
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
+ * @destroy_work: work struct for deferred destruction when called from
+ *                atomic/reclaim context
+ * @pgmap: the dev_pagemap registered with devm_memremap_pages();
+ *         must be last — contains a flexible-array member (ranges[])
+ *
+ * Allocated with kzalloc() in amdgpu_svm_migration_init() and stored
+ * as adev->apagemap.  Freed via drm_pagemap_ops.destroy callback when
+ * dpagemap refcount drops to zero.
+ */
+struct amdgpu_pagemap {
+	struct drm_pagemap	dpagemap;
+	struct amdgpu_device	*adev;
+	resource_size_t		hpa_base;
+	bool			initialized;
+	struct work_struct	destroy_work;
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
2.53.0

