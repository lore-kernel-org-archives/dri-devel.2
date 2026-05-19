Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D11CD4F52
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 08:32:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9FAF10EB56;
	Tue, 19 May 2026 08:32:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O1MPdhzl";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013002.outbound.protection.outlook.com
 [40.107.201.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8DD610EB48;
 Tue, 19 May 2026 08:32:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DKjqeePw9oNEK8LsieE0lg4NzYuz69HSY+yZIwMuu0sXIHEQ1eBmqqYXPjX0LmsY61awa1NdJLpvnDXiFaumP04wFSroqNUSm25Ax9YIoWx0hKGCajEhaiKdsUavNOltCO1ZrcGCVrIo2TS8wasN2Fa4IjFMaYH2atelZUZ0yXKlbvyWwbmFpyPBpWIOQdjWXw3hpf87uNo7QFQSe3X8JrDKPWrHHc66gWva/jQqZm2uOlKto/JPms7Rf+DobV37nF8EuKfUQlqThlGfoneCshrG88NHGOUElUMZOA6Y7R1hZZ1GJ5bREEDUF8c+ZDezX/KiwQgfWF44ZeZ90GiCoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kQf6jVfnV++rd598BbusfCG7qJt5naPRAqEwuzB5M14=;
 b=gML53LoP3OrTgcix9e3e04Mt5iCsrZpDcruzt/4auu3lfpOVN8mXXWZANAJBk3aCAUTlEyDF+/B/3MblPN24Y8/JObZWSGEbdyP6lpVIEEe5yUtTbEMHBU9zl/qKcxIED3fitAvBBYw6Ji/6MJXyJS3OnnWv0IhUOmIQmQ9Sr2Wv54Ip2GQlIjgPIIt/7eFKbPrJQ8B+FU0pKCmKO22fegzKZjvInokzF7Y/LxwSZmKOL/jFvTwV6dY3a6ajjPIeW7rkdWXPOqPKaG7aWlfuCsaIczizYMS6LtV3tA5SY/jT2FvcYhYGUouBru9G2H+8N7TzkgsKNhi5YJuZRDYgKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQf6jVfnV++rd598BbusfCG7qJt5naPRAqEwuzB5M14=;
 b=O1MPdhzlC+oH2OkMCEu71SNaJskd/FKG3ykZDeWZ0EGXPNm0wXvGKafoszS5HAS99N5eWdORelhnJ0Je+L6nF88WdvTqTr3nyQl5cujX3eHsFIjNyhbWXm6m9xFE44xyFOasQi9yCXpsedStbVd0XHz2sXnHmB4BLhtVLZ6VSE4=
Received: from DSZP220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:280::15) by
 PH7PR12MB6718.namprd12.prod.outlook.com (2603:10b6:510:1b1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.22; Tue, 19 May
 2026 08:32:16 +0000
Received: from DS2PEPF000061C6.namprd02.prod.outlook.com
 (2603:10b6:5:280:cafe::35) by DSZP220CA0001.outlook.office365.com
 (2603:10b6:5:280::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.25 via Frontend Transport; Tue, 19
 May 2026 08:32:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF000061C6.mail.protection.outlook.com (10.167.23.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 08:32:16 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 19 May
 2026 03:32:11 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>,
 <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC V6 07/12] drm/amdgpu: implement SVM range GPU mapping core
Date: Tue, 19 May 2026 16:30:52 +0800
Message-ID: <20260519083057.3108087-8-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260519083057.3108087-1-honglei1.huang@amd.com>
References: <20260519083057.3108087-1-honglei1.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C6:EE_|PH7PR12MB6718:EE_
X-MS-Office365-Filtering-Correlation-Id: e6a4988a-a38a-4737-ee11-08deb5812244
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|56012099003|18002099003|22082099003|921020|11063799005|3023799003;
X-Microsoft-Antispam-Message-Info: 98x86/AEJF3Y7dFrDHG6wUUQItoPwCwKrjR+PSOhm1RUWqBG5q36Rgy/BnLMpDqbl8LHdgpq6UCf/4myVaY9EveDvViIhPp3qjlcfxGuCt4xnpQrhwpxpEyjqB8W8Lji6Sik9BsbhbDzx9ePeaX+XBz6JH3oeU01YTSzT3n+LLEHzQX5ShOvkhX6D0SzJ/bPYHEzZkUryavRd7jJwATMi+qDmMekh3ahiRwbUZ0j8h/151tvT8miq9ro9HrnC9Yl7ts+lNryl0l7zD7B0Sn8uSq/2RJffyfj0RgEDQfCHOdGwWQtrGBhmC5rvJ17LFBIvswZ/FOBSOs2yzXw4Oa97qFAQIQYftdGSE4TJr3eeAGaMUKxT7Hu7OVdnsN+n/s2XBKAyjc+wT09pj8wpA8SLac++o5DkLA54c2Izwr+EOFUvS6WtSF9hvUjCt+eGAokO1O2YPu5Z4VFPoAa+Z9e5ojBkIy6yaG0f0GDyu4ybRFR77O5z7LDaSI8YViJsa3fuenqgCYcdD8ZGXrpm+I6Sqm+w2YCM38GFXsxHVzdmHJq74llWtDCGzQHbsnx9eL0vV97rm9/K+3RlCWRXcIgwtwK7ojCyvJVvp26kIBXjS0Dwfl6OcyAjS0zfzUyV8GJvIQ4mNpBTGlap/V4AHRz4Wi4NmGNAM0dcMUB3O+dBfkWijOLUUKcS4qfkv/PK76RnKjgSfoRSddqXJOI4BgI5xdS0mpgaR4xMTcFHwIGLyhy8jfWL5vK9MvnfY5ZY3CXDOtla7++nP7uFV+Kuuidgg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099003)(18002099003)(22082099003)(921020)(11063799005)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: em2RJW/0M+NyCaukry4GvxPpHsQKCVRmlzU8xnZE/sLwwPAnZR1fFODGGw+JJzIeuc2J6h44XTrnCFPuKmp3tyCv6Thd5sT7w0rDxydUSZm4l67os0cHZV8iYrkR3xPxoXgvliPMEW0ey99enAJZ7LI9Qmlirns6wCf3hTeLh0ISLDiWR9T4X4R/P8MA3azDCqOB1dNoX1ptx8NZhd0wu7OK268ple5QZFLKoJisYl/5wtGmLWxgve95ffmG47r4RuCY8fnSSKGS4/fKc95eSHsihN+FudZPmBTNshELQJSZSXv3MN5UagjZNLxzmVvOvVZ28QO/ta4nRYnYR8tW1wWWK+KXKg7EdOQcZOxwptojh7torzVLEYEpf0HiAnbV78/dDM5i3UkXKzOgTVVq5QK5DCXxUC8+FQMwrlYN0yHRo4JJJUFNag1t9uwsJC5k
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 08:32:16.2789 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6a4988a-a38a-4737-ee11-08deb5812244
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6718
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

From: Honglei Huang <honghuan@amd.com>

Implement GPU page table mapping in amdgpu_svm_range.c:
- amdgpu_svm_range_pages_valid: check notifier sequence validity
- amdgpu_svm_range_is_valid: validate gpu_mapped and attr_flags
  against the requested attribute set; PTE flags are no longer
  cached on the range (recomputed per DMA segment), so they are
  not part of the validity check
- amdgpu_svm_range_zap_ptes: clear GPU PTEs via amdgpu_vm_update_range
  for an explicit [start_page, last_page] window (exposed for use by
  notifier and attribute-invalidation paths in later commits)
- amdgpu_svm_range_attr_pte_flags: compute PTE flags per GC IP version
  from the attribute set plus the per-segment drm_pagemap protocol.
  Branches model kfd_svm semantics:
    * 9.4.1/9.4.2: local VRAM uses CC/RW (XGMI-to-CPU keeps snoop on
      9.4.2); remote/sysmem keeps UC/NC
    * 9.4.3/9.4.4/9.5.0: snoop on; is_vram tree picks mtype_local,
      NC or UC based on ext_coherent and same-hive; sysmem splits
      APU (NUMA-aware) vs dGPU
    * 12.0.0/12.0.1: NC
    * 12.1.0: AID A1 aware mtype_local/mtype_remote; ext_coherent UC;
      sets AMDGPU_PTE_BUS_ATOMICS when the device supports it
  AMDGPU_PTE_SYSTEM is set only when the segment is not local VRAM
  (is_local derived from proto == AMDGPU_INTERCONNECT_VRAM).
- amdgpu_svm_range_lock_vm_pd: acquire VM page directory via drm_exec
- amdgpu_svm_range_update_gpu_range: DMA segment coalescing; recomputes
  PTE flags per segment from entry->proto via attr_pte_flags, then
  programs PTEs under notifier lock
- amdgpu_svm_range_find_or_insert: wrapper with read-only fallback
- amdgpu_svm_range_get_pages: pages acquisition; on -EOPNOTSUPP from
  the mixed-residency path evicts via amdgpu_svm_range_evict
- amdgpu_svm_range_evict: thin wrapper around drm_gpusvm_range_evict
  that short-circuits when the range has no devmem-backed pages
- amdgpu_svm_range_update_mapping: full pipeline (lock PD, validate
  pages, program PTEs, update PDEs, flush TLB, record attr_flags
  and mapped state); takes attrs + read_only and forwards them to
  update_gpu_range
- amdgpu_svm_range_map_attrs: cursor-based iteration across attr tree,
  creating/mapping ranges; no longer pre-computes pte_flags (computed
  per segment inside update_gpu_range)

Also add to amdgpu_svm.h driver-private interconnect tags used in
drm_pagemap_addr.proto (mirrors xe's XE_INTERCONNECT_VRAM/_P2P):
  AMDGPU_INTERCONNECT_VRAM = DRM_INTERCONNECT_DRIVER
  AMDGPU_INTERCONNECT_P2P  = AMDGPU_INTERCONNECT_VRAM + 1
and include <drm/drm_pagemap.h>.

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h       |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c | 469 ++++++++++++++++++
 2 files changed, 473 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
index 49f8b8f06..b04ef1617 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
@@ -27,6 +27,7 @@
 
 #include <drm/amdgpu_drm.h>
 #include <drm/drm_gpusvm.h>
+#include <drm/drm_pagemap.h>
 #include <linux/atomic.h>
 #include <linux/kref.h>
 #include <linux/list.h>
@@ -44,6 +45,9 @@ struct amdgpu_svm_attrs;
 struct drm_device;
 struct drm_file;
 
+#define AMDGPU_INTERCONNECT_VRAM	DRM_INTERCONNECT_DRIVER
+#define AMDGPU_INTERCONNECT_P2P		(AMDGPU_INTERCONNECT_VRAM + 1)
+
 enum amdgpu_svm_xnack_mode {
 	AMDGPU_SVM_XNACK_OFF,
 	AMDGPU_SVM_XNACK_ON,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
new file mode 100644
index 000000000..eda3ebaf5
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
@@ -0,0 +1,469 @@
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
+#include "amdgpu_svm.h"
+#include "amdgpu_svm_attr.h"
+#include "amdgpu_svm_range.h"
+#include "amdgpu_svm_fault.h"
+#include "amdgpu.h"
+#include "amdgpu_vm.h"
+
+#include <drm/drm_exec.h>
+#include <drm/drm_pagemap.h>
+
+#include <linux/mmu_notifier.h>
+#include <uapi/linux/kfd_ioctl.h>
+
+bool
+amdgpu_svm_range_pages_valid(struct amdgpu_svm *svm,
+		  struct amdgpu_svm_range *range)
+{
+	struct drm_gpusvm_range *base = &range->base;
+
+	lockdep_assert_held(&svm->gpusvm.notifier_lock);
+
+	if (base->pages.flags.unmapped || base->pages.flags.partial_unmap)
+		return false;
+
+	return drm_gpusvm_range_pages_valid(&svm->gpusvm, base);
+}
+
+bool amdgpu_svm_range_is_valid(struct amdgpu_svm *svm,
+			       struct amdgpu_svm_range *range,
+			       const struct amdgpu_svm_attrs *attrs)
+{
+	unsigned int flags;
+	bool valid;
+
+	flags = memalloc_noreclaim_save();
+	drm_gpusvm_notifier_lock(&svm->gpusvm);
+	valid = range->gpu_mapped &&
+		range->attr_flags == attrs->flags &&
+		amdgpu_svm_range_pages_valid(svm, range);
+	drm_gpusvm_notifier_unlock(&svm->gpusvm);
+	memalloc_noreclaim_restore(flags);
+
+	return valid;
+}
+
+
+int
+amdgpu_svm_range_zap_ptes(struct amdgpu_svm *svm,
+			  struct amdgpu_svm_range *range,
+			  unsigned long start_page,
+			  unsigned long last_page)
+{
+	struct dma_fence *fence = NULL;
+	unsigned int flags;
+	int ret;
+
+	if (last_page < start_page)
+		return 0;
+
+	flags = memalloc_noreclaim_save();
+	ret = amdgpu_vm_update_range(svm->adev, svm->vm, false, true, true, false,
+				     NULL, start_page, last_page, 0, 0, 0, NULL,
+				     NULL, &fence);
+	memalloc_noreclaim_restore(flags);
+
+	if (!ret && fence) {
+		ret = dma_fence_wait(fence, false);
+		if (ret < 0)
+			AMDGPU_SVM_TRACE("notifier unmap fence wait failed: ret=%d [0x%lx-0x%lx]-0x%lx\n",
+					 ret, start_page, last_page,
+					 last_page - start_page + 1);
+	}
+
+	dma_fence_put(fence);
+	return ret;
+}
+
+uint64_t
+amdgpu_svm_range_attr_pte_flags(struct amdgpu_svm *svm,
+			    const struct amdgpu_svm_attrs *attrs,
+			    bool read_only,
+			    enum drm_interconnect_protocol proto)
+{
+	uint32_t flags = attrs->flags;
+	uint32_t mapping_flags = 0;
+	uint32_t gc_ip_version = amdgpu_ip_version(svm->adev, GC_HWIP, 0);
+	uint64_t pte_flags;
+	bool snoop = proto != AMDGPU_INTERCONNECT_VRAM;
+	bool coherent = flags & (AMDGPU_SVM_ATTR_BIT_COHERENT |
+				 AMDGPU_SVM_ATTR_BIT_EXT_COHERENT);
+	bool ext_coherent = flags & AMDGPU_SVM_ATTR_BIT_EXT_COHERENT;
+	unsigned int mtype_local, mtype_remote;
+	bool is_aid_a1;
+	bool is_local = (proto == AMDGPU_INTERCONNECT_VRAM);
+	bool is_vram = is_local || (proto == AMDGPU_INTERCONNECT_P2P);
+
+	switch (gc_ip_version) {
+	case IP_VERSION(9, 4, 1):
+	case IP_VERSION(9, 4, 2):
+		if (is_local) {
+			mapping_flags |= coherent ?
+				AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_RW;
+			/* 9.4.2 local VRAM with XGMI keeps snoop */
+			if (gc_ip_version == IP_VERSION(9, 4, 2) &&
+			    svm->adev->gmc.xgmi.connected_to_cpu)
+				snoop = true;
+		} else {
+			mapping_flags |= coherent ?
+				AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
+			/* TODO: migration: re enable snoop for same hive */
+		}
+		break;
+	case IP_VERSION(9, 4, 3):
+	case IP_VERSION(9, 4, 4):
+	case IP_VERSION(9, 5, 0):
+		if (ext_coherent)
+			mtype_local = AMDGPU_VM_MTYPE_CC;
+		else
+			mtype_local = amdgpu_mtype_local == 1 ? AMDGPU_VM_MTYPE_NC :
+				amdgpu_mtype_local == 2 ? AMDGPU_VM_MTYPE_CC :
+				AMDGPU_VM_MTYPE_RW;
+		snoop = true;
+		if (is_vram) {
+			if (is_local) {
+				/* local HBM region close to partition */
+				mapping_flags |= mtype_local;
+			} else if (!ext_coherent) {
+				/* TODO: add same hive check */
+				mapping_flags |= AMDGPU_VM_MTYPE_NC;
+			} else if (gc_ip_version < IP_VERSION(9, 5, 0)) {
+				/* TODO: add same hive check */
+				mapping_flags |= AMDGPU_VM_MTYPE_UC;
+			} else {
+				mapping_flags |= ext_coherent ? AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
+			}
+		} else if (svm->adev->flags & AMD_IS_APU) {
+			/* On NUMA systems, locality is determined per-page
+			 * in amdgpu_gmc_override_vm_pte_flags.
+			 */
+			if (num_possible_nodes() <= 1)
+				mapping_flags |= mtype_local;
+			else
+				mapping_flags |= ext_coherent ? AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
+		} else {
+			if (gc_ip_version < IP_VERSION(9, 5, 0) || ext_coherent)
+				mapping_flags |= AMDGPU_VM_MTYPE_UC;
+			else
+				mapping_flags |= AMDGPU_VM_MTYPE_NC;
+		}
+		break;
+	case IP_VERSION(12, 0, 0):
+	case IP_VERSION(12, 0, 1):
+		mapping_flags |= AMDGPU_VM_MTYPE_NC;
+		break;
+	case IP_VERSION(12, 1, 0):
+		is_aid_a1 = (svm->adev->rev_id & 0x10);
+		mtype_local = amdgpu_mtype_local == 0 ? AMDGPU_VM_MTYPE_RW :
+				amdgpu_mtype_local == 1 ? AMDGPU_VM_MTYPE_NC :
+				is_aid_a1 ? AMDGPU_VM_MTYPE_RW : AMDGPU_VM_MTYPE_NC;
+		mtype_remote = is_aid_a1 ? AMDGPU_VM_MTYPE_NC : AMDGPU_VM_MTYPE_UC;
+		snoop = true;
+
+		if (is_local) {
+			mapping_flags |= mtype_local;
+		} else if (ext_coherent) {
+			mapping_flags |= AMDGPU_VM_MTYPE_UC;
+		} else {
+			/* system memory or remote VRAM */
+			mapping_flags |= mtype_remote;
+		}
+		break;
+	default:
+		mapping_flags |= coherent ?
+			AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
+		break;
+	}
+
+	if (flags & AMDGPU_SVM_ATTR_BIT_GPU_EXEC)
+		mapping_flags |= AMDGPU_VM_PAGE_EXECUTABLE;
+
+	pte_flags = AMDGPU_PTE_VALID;
+	pte_flags |= is_local ? 0 : AMDGPU_PTE_SYSTEM;
+	pte_flags |= snoop ? AMDGPU_PTE_SNOOPED : 0;
+	if (gc_ip_version >= IP_VERSION(12, 0, 0))
+		pte_flags |= AMDGPU_PTE_IS_PTE;
+
+	amdgpu_gmc_get_vm_pte(svm->adev, svm->vm, NULL, mapping_flags, &pte_flags);
+	pte_flags |= AMDGPU_PTE_READABLE;
+	if (!(flags & AMDGPU_SVM_ATTR_BIT_GPU_RO) && !read_only)
+		pte_flags |= AMDGPU_PTE_WRITEABLE;
+
+	if (gc_ip_version == IP_VERSION(12, 1, 0) &&
+	    svm->adev->have_atomics_support)
+		pte_flags |= AMDGPU_PTE_BUS_ATOMICS;
+
+	return pte_flags;
+}
+
+
+
+int amdgpu_svm_range_lock_vm_pd(struct amdgpu_svm *svm, struct drm_exec *exec,
+				bool intr)
+{
+	unsigned int exec_flags = DRM_EXEC_IGNORE_DUPLICATES;
+	int ret;
+
+	if (intr)
+		exec_flags |= DRM_EXEC_INTERRUPTIBLE_WAIT;
+
+	drm_exec_init(exec, exec_flags, 0);
+	drm_exec_until_all_locked(exec) {
+		ret = amdgpu_vm_lock_pd(svm->vm, exec, 1);
+		drm_exec_retry_on_contention(exec);
+		if (ret) {
+			drm_exec_fini(exec);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+int
+amdgpu_svm_range_update_gpu_range(struct amdgpu_svm *svm,
+				  struct amdgpu_svm_range *range,
+				  const struct amdgpu_svm_attrs *attrs,
+				  bool read_only,
+				  bool flush_tlb,
+				  bool wait_fence,
+				  struct dma_fence **fence)
+{
+	struct drm_gpusvm_range *base = &range->base;
+
+	lockdep_assert_held(&svm->gpusvm.notifier_lock);
+
+	const unsigned long range_start_page = drm_gpusvm_range_start(base) >> PAGE_SHIFT;
+	const unsigned long range_end_page = drm_gpusvm_range_end(base) >> PAGE_SHIFT;
+	const unsigned long npages = range_end_page - range_start_page;
+	unsigned long mapped_pages = 0;
+	unsigned long dma_idx = 0;
+	int ret;
+
+	if (!base->pages.dma_addr || !npages)
+		return -EINVAL;
+
+	while (mapped_pages < npages) {
+		const struct drm_pagemap_addr *entry = &base->pages.dma_addr[dma_idx++];
+		unsigned long seg_pages = min_t(unsigned long, 1UL << entry->order,
+						npages - mapped_pages);
+		uint64_t pte_flags;
+		unsigned long start_page, last_page;
+		bool is_last_seg;
+
+		if (entry->proto != DRM_INTERCONNECT_SYSTEM)
+			return -EOPNOTSUPP;
+
+		pte_flags = amdgpu_svm_range_attr_pte_flags(svm, attrs,
+							    read_only,
+							    entry->proto);
+
+		start_page = range_start_page + mapped_pages;
+		last_page = start_page + seg_pages - 1;
+		mapped_pages += seg_pages;
+		is_last_seg = mapped_pages == npages;
+
+		ret = amdgpu_vm_update_range(svm->adev, svm->vm, false, false,
+					     flush_tlb && is_last_seg, true, NULL,
+					     start_page, last_page, pte_flags,
+					     0, entry->addr, NULL, NULL,
+					     wait_fence && is_last_seg ? fence : NULL);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+struct amdgpu_svm_range *
+amdgpu_svm_range_find_or_insert(struct amdgpu_svm *svm, unsigned long addr,
+				unsigned long gpuva_start, unsigned long gpuva_end,
+				struct drm_gpusvm_ctx *ctx)
+{
+	struct drm_gpusvm_range *r;
+
+retry:
+	r = drm_gpusvm_range_find_or_insert(&svm->gpusvm, addr,
+					    gpuva_start, gpuva_end, ctx);
+
+	if (PTR_ERR_OR_ZERO(r) == -EPERM && !ctx->read_only) {
+		ctx->read_only = true;
+		goto retry;
+	}
+
+	if (IS_ERR(r))
+		return ERR_CAST(r);
+
+	return to_amdgpu_svm_range(r);
+}
+
+int amdgpu_svm_range_get_pages(struct amdgpu_svm *svm,
+			       struct drm_gpusvm_range *range,
+			       struct drm_gpusvm_ctx *ctx)
+{
+	int ret;
+
+	ret = drm_gpusvm_range_get_pages(&svm->gpusvm, range, ctx);
+	if (ret == -EOPNOTSUPP) {
+		AMDGPU_SVM_ERR("range get pages failed with -EOPNOTSUPP, evicting range and retrying: gpuva=[0x%lx-0x%lx) ret=%d\n",
+				drm_gpusvm_range_start(range),
+				drm_gpusvm_range_end(range), ret);
+		amdgpu_svm_range_evict(svm, range);
+	}
+
+	return ret;
+}
+
+void amdgpu_svm_range_evict(struct amdgpu_svm *svm,
+			    struct drm_gpusvm_range *range)
+{
+	if (!range->pages.flags.has_devmem_pages)
+		return;
+
+	drm_gpusvm_range_evict(&svm->gpusvm, range);
+}
+
+int amdgpu_svm_range_update_mapping(struct amdgpu_svm *svm,
+				    struct amdgpu_svm_range *range,
+				    const struct amdgpu_svm_attrs *attrs,
+				    bool read_only,
+				    bool intr, bool wait,
+				    bool flush_tlb)
+{
+	struct drm_exec exec;
+	struct dma_fence *fence = NULL;
+	unsigned int flags;
+	int ret;
+
+	ret = amdgpu_svm_range_lock_vm_pd(svm, &exec, intr);
+	if (ret)
+		return ret;
+
+	flags = memalloc_noreclaim_save();
+	drm_gpusvm_notifier_lock(&svm->gpusvm);
+
+	if (!amdgpu_svm_range_pages_valid(svm, range)) {
+		amdgpu_svm_range_invalidate_gpu_mapping(range);
+		ret = -EAGAIN;
+	} else {
+		ret = amdgpu_svm_range_update_gpu_range(svm, range, attrs,
+							read_only, flush_tlb,
+							wait, wait ? &fence : NULL);
+	}
+
+	drm_gpusvm_notifier_unlock(&svm->gpusvm);
+	memalloc_noreclaim_restore(flags);
+
+	if (!ret && fence)
+		dma_fence_wait(fence, intr);
+	dma_fence_put(fence);
+
+	if (!ret)
+		ret = amdgpu_vm_update_pdes(svm->adev, svm->vm, false);
+
+	if (!ret) {
+		if (flush_tlb)
+			svm->flush_tlb(svm);
+		WRITE_ONCE(range->attr_flags, attrs->flags);
+		WRITE_ONCE(range->gpu_mapped, true);
+		range->validate_timestamp = ktime_get_boottime();
+	}
+
+	drm_exec_fini(&exec);
+	return ret;
+}
+
+int
+amdgpu_svm_range_map_attrs(struct amdgpu_svm *svm,
+		       const struct amdgpu_svm_attrs *attrs,
+		       unsigned long start, unsigned long end)
+{
+	unsigned long addr = start;
+	int ret;
+	bool devmem_possible = false; /* TODO: add migration */
+	bool need_vram_migration = amdgpu_svm_attr_prefer_vram(svm, attrs);
+	struct drm_gpusvm_ctx map_ctx = {
+		.read_only = !!(attrs->flags & AMDGPU_SVM_ATTR_BIT_GPU_RO),
+		.devmem_possible = devmem_possible,
+		.devmem_only = need_vram_migration && devmem_possible,
+		.check_pages_threshold = devmem_possible ? SZ_64K : 0,
+	};
+
+	while (addr < end) {
+		struct amdgpu_svm_range *range;
+		unsigned long next_addr;
+
+		range = amdgpu_svm_range_find_or_insert(svm, addr,
+							addr, end,
+							&map_ctx);
+		if (IS_ERR(range)) {
+			AMDGPU_SVM_ERR("failed to find or insert range for gpuva 0x%lx [0x%lx-0x%lx), ret=%ld\n",
+					addr, start, end, PTR_ERR(range));
+			return PTR_ERR(range);
+		}
+
+		next_addr = drm_gpusvm_range_end(&range->base);
+		if (next_addr <= addr)
+			return -EINVAL;
+
+		if (amdgpu_svm_range_is_valid(svm, range, attrs)) {
+			addr = next_addr;
+			continue;
+		}
+
+		/* TODO: add migration */
+
+		AMDGPU_SVM_RANGE_DEBUG(range, "PREFETCH - GET PAGES");
+
+		ret = amdgpu_svm_range_get_pages(svm, &range->base,
+						 &map_ctx);
+		if (ret) {
+			AMDGPU_SVM_ERR("failed to get pages for range [0x%lx-0x%lx), ret=%d\n",
+					drm_gpusvm_range_start(&range->base),
+					drm_gpusvm_range_end(&range->base), ret);
+			return ret;
+		}
+
+		AMDGPU_SVM_RANGE_DEBUG(range, "PREFETCH - UPDATE MAPPING");
+
+		ret = amdgpu_svm_range_update_mapping(svm, range, attrs,
+						      map_ctx.read_only,
+						      true, true,
+						      true);
+		if (ret) {
+			AMDGPU_SVM_ERR("failed to update gpu mapping for range [0x%lx-0x%lx), ret=%d\n",
+					drm_gpusvm_range_start(&range->base),
+					drm_gpusvm_range_end(&range->base), ret);
+			return ret;
+		}
+
+		addr = next_addr;
+	}
+
+	return 0;
+}
+
-- 
2.34.1

