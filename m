Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA86FC55184
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 09:43:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CD4C10E952;
	Tue,  4 Aug 2026 09:43:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2MU/SKK9";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010039.outbound.protection.outlook.com [52.101.61.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99F8210E952;
 Tue,  4 Aug 2026 09:43:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hqmej/dvedaz81r1IoaTeetTB7EXzlH4cDuXN0QBtxD01D7Esxw5OICGjdIJYtW7EGs3umzcCutyEHocPjeELc1VFNvzHjB0/7a4uk17S5GSzryGmBp4pM7F1Ep30OpU8/Fy8I4pgSaKu/M6wOzxBaZVNJOKNKkXAB3i6QLYPVnqr/PNuzfBcsaP21/jwU4uq985a9/jocp6FRL1lQPdtZ0VFvHaewzLlmts/WxkWyFGlY87fnlXM4A/BNoWgfn6YePH5h1Ct7GjdqNybwJ0s0IvZGdLKXVAdveLcm8P8CIxloprEs01FCcjy4wa/kFkmenzNCRrrm4l/yqrxv9x5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5PJx9zLVnC1g74296kG4FQXPp02uHuqkyOG81uRCPtw=;
 b=Tl0b2Q5r3KkTvJGeqDDeqAlSOKdNKxMhkVMYXvVJbGyJnS84IsLBb/jIKPU/0WvsGSSyAmoQWkGPu/3FRsHVyRzxIP/zlNAupzPZUUrISQyqhPhkLVtxRWwgJscH/mGUbW+9Q0XPZoZGZnrzYv+1YFZAbLld+jQ/oDgZ5psGIuuegfTlE/7KgPs0Vcr6HBniRHR6gYaDpH+DlYWKg9q8pCXPWdf86OQb86H2Cq307gIURUsOOP6VmwHOmVUBYcbUW7ppDtl312udPz2x7r9askkLzLn8OJy6ZW7poSP0yqdtla8SdYclAXC8AGP69SUAHHKScYHeC+S+biOiWVBTtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5PJx9zLVnC1g74296kG4FQXPp02uHuqkyOG81uRCPtw=;
 b=2MU/SKK9n9jTPK+8EQfxCH9XnYtgR6s5JIkuzEpaox/WD1+JzXiZoYtSZjYDhx4oYqNgjDibMnh9gcizCxU6u4OChAP2Lgl9qkSGIOGgoaqlpLASooXNrpjTUgpTs7cNO06XScooGOjz8S2JaLQgKui8PkQbDHwZcshafmpSCgk=
Received: from SA0PR11CA0052.namprd11.prod.outlook.com (2603:10b6:806:d0::27)
 by IA1PR12MB6041.namprd12.prod.outlook.com (2603:10b6:208:3d7::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 09:43:37 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:806:d0:cafe::79) by SA0PR11CA0052.outlook.office365.com
 (2603:10b6:806:d0::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.18 via Frontend Transport; Tue, 4
 Aug 2026 09:43:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 09:43:36 +0000
Received: from hr-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 4 Aug
 2026 04:43:32 -0500
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
 <yiru.ma@amd.com>, Huang Rui <ray.huang@amd.com>, Honglei Huang
 <honghuan@amd.com>
Subject: [PATCH v9 07/18] drm/amdgpu: implement SVM range GPU mapping core
Date: Tue, 4 Aug 2026 17:42:33 +0800
Message-ID: <20260804094246.1719318-8-ray.huang@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260804094246.1719318-1-ray.huang@amd.com>
References: <20260804094246.1719318-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|IA1PR12MB6041:EE_
X-MS-Office365-Filtering-Correlation-Id: 7554a922-fe62-4b55-bf85-08def20cdb8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|921020|6133799003|56012099006|11063799006|10067099003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Ev7cZ7PLhOLqH2ST84kyF4jzeJfFZ0VGs9XRhvFXZHNHQ5YNSDqtjomwmDmlVgvNlJ3HS74fDraDmB0ue6Nm8ywqXQDx7GaJxmFTqUqvTz+5yezseBJPVmAqY021EakfrcuB0vNBjRYeAHSPTHBuXPEnwZpnsa5ZQgPE9A3RBHWkeUDeemNFymfA2O5TcT9YD9OyOXSVJ8QX7kFxXi01Vqw2CEXoH8s62ZDNaEMXHdsCZ03X5YRdcGJDBEJHJ6m+U3gzLWDfcWhU9SAVpRIa4c+mRkHXVAZpyBywspvfxoc5HHFQ4Li0naoXRt9MBqLUXx3NTaGURwXwP1DYSgLzK4NSxBjDktCh16jtk2dwiS/DJAjhVFrOVwM+SuN7PrK3d+3QeU42ztPgQR4Pru6aWf54lPgNVxVfxq73O7kUR1G9SDXbAnP9inYYUcCORjc/wNIJz6wxy8f0nN1lOYPiCSAHkm40o/se6TgyYGBzRhUu1LAN1swXHSindAzKlTE14RFcOU1LcR27bOnjexDhSp+M4v0gHhyk8R5zFsQt2HTin4VDZY21uKY1BbSj4DVXoXsIOS/Z5ozfwUmWkGqc3efogTg1ZwD6D/a9DfvQ/rCCLLD3X5t+Rn0xJ7kEO1IG/1Yr07DurWh8iWI0/0ubw/6McPcAiAY5bis6r0Iz109zUrdnGDudKv1JJCOr5Or8W5oHntVOYbzfCLj4hc2srdc01y80NGq3g4fYrMPkkdAuqbKslDp8vhrCMmTi2qms
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(921020)(6133799003)(56012099006)(11063799006)(10067099003)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iZ0RlNAcDVPhfSvPVHnf0srzag5W49w+ajQpBhVaqv4EqwdHu5O+AH5vWPWwTlvWY5hHciBBeKWvZ6J8gW3G7vdYzxUPzv8zdhFhUD+ILgtRVhEqUolTl71sUAkrsGfSUjmFhAfZIv3oDCSccugBNqb1qmlMZf6DjrWmTZNfC0dK2PdHlbKWNjMj8Zoszw+rDi4FYo/msb5N6ZlA5+gZIXsmIhHumOOe139QexF7MtNxnq4UuXwdtGbhlNtW+9EJ7gksA1o/URvseCZXK/PDd/K6UFxys25FIfolI/c4E9Wm/Hi0jLyMb8ni1/8CYqFSbx8kg1hoX5BqFZGApEBaPfkSb4O/A0BlkVv3JEZux8OWirE1D/VZOa3bvOuYCqeD/yL5Pl6Ltk70AYzpiX0F2Q/wK3ZCF6B7yEVwofkfdJxW2aNEU1aUqgqzwhnBiGe5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 09:43:36.9688 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7554a922-fe62-4b55-bf85-08def20cdb8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6041
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
  against the requested attribute set, under MMU notifier lock.
- amdgpu_svm_range_zap_ptes: clear GPU PTEs via amdgpu_vm_update_range
- amdgpu_svm_range_attr_pte_flags: compute PTE flags per GC IP version
- amdgpu_svm_range_lock_vm_pd: acquire VM page directory by drm_exec
- amdgpu_svm_range_update_gpu_range: DMA segment coalescing; recomputes
  PTE flags per segment from entry->proto via attr_pte_flags, then
  programs PTEs under notifier lock
- amdgpu_svm_range_find_or_insert: wrapper of drm gpu SVM find or insert
  API.
- amdgpu_svm_range_get_pages: wrapper of drm gpu SVM get pages.
- amdgpu_svm_range_evict: thin wrapper of drm_gpusvm_range_evict
- amdgpu_svm_range_update_mapping: full pipeline (lock PD, validate
  pages, program PTEs, update PDEs, flush TLB, record attr_flags
  and mapped state); takes attrs + read_only and forwards them to
  update_gpu_range
- amdgpu_svm_range_map_attrs: cursor based iteration across attr tree,
  creating/mapping ranges

- Add to amdgpu_svm.h driver private interconnect tags used in
drm_pagemap_addr.proto:
  AMDGPU_INTERCONNECT_VRAM = DRM_INTERCONNECT_DRIVER
  AMDGPU_INTERCONNECT_P2P  = AMDGPU_INTERCONNECT_VRAM + 1

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h       |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c | 419 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h |  40 ++
 3 files changed, 463 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
index f3b4f228405c2..c67f01b3b5d3b 100644
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
index 0000000000000..335fe5a551f0f
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
@@ -0,0 +1,419 @@
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
+#include "amdgpu_trace.h"
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
+bool amdgpu_svm_range_is_valid(struct amdgpu_svm_range *range,
+			       const struct amdgpu_svm_attrs *attrs)
+{
+	return READ_ONCE(range->gpu_mapped) &&
+	       READ_ONCE(range->attr_flags) == attrs->flags;
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
+	ret = amdgpu_vm_unmap_range(svm->adev, svm->vm, NULL,
+				    start_page, last_page, 0, &fence);
+	memalloc_noreclaim_restore(flags);
+
+	if (fence) {
+		dma_fence_wait(fence, false);
+		dma_fence_put(fence);
+	}
+
+	return ret;
+}
+
+uint64_t
+amdgpu_svm_range_attr_pte_flags(struct amdgpu_svm *svm,
+			    const struct amdgpu_svm_attrs *attrs,
+			    bool read_only,
+			    enum drm_interconnect_protocol proto)
+{
+	struct amdgpu_device *adev = svm->adev;
+	uint32_t flags = attrs->flags;
+	bool is_local = (proto == AMDGPU_INTERCONNECT_VRAM);
+	struct amdgpu_svm_pte_flags_params params = {
+		.coherent = flags & (AMDGPU_SVM_ATTR_BIT_COHERENT |
+				     AMDGPU_SVM_ATTR_BIT_EXT_COHERENT),
+		.ext_coherent = flags & AMDGPU_SVM_ATTR_BIT_EXT_COHERENT,
+		.gpu_ro = flags & AMDGPU_SVM_ATTR_BIT_GPU_RO,
+		.gpu_exec = flags & AMDGPU_SVM_ATTR_BIT_GPU_EXEC,
+		.is_local = is_local,
+		.is_vram = is_local || (proto == AMDGPU_INTERCONNECT_P2P),
+		/* TODO: add hive check. */
+		.same_hive = false,
+	};
+	uint32_t gc_ip_version;
+	uint32_t mapping_flags = 0;
+	uint64_t pte_flags;
+	bool snoop;
+
+	/*
+	 * The per-IP MTYPE / PTE flag selection lives in the HW IP specific
+	 * gmc_vX_0.c files mirroring amdgpu_gmc_get_vm_pte for BO mappings.
+	 */
+	if (adev->gmc.gmc_funcs->get_svm_pte_flags) {
+		pte_flags = amdgpu_gmc_get_svm_pte_flags(adev, svm->vm, &params);
+	} else {
+		gc_ip_version = amdgpu_ip_version(adev, GC_HWIP, 0);
+		snoop = !is_local;
+		mapping_flags |= params.coherent ?
+			AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
+
+		if (params.gpu_exec)
+			mapping_flags |= AMDGPU_VM_PAGE_EXECUTABLE;
+
+		pte_flags = AMDGPU_PTE_VALID;
+		pte_flags |= is_local ? 0 : AMDGPU_PTE_SYSTEM;
+		pte_flags |= snoop ? AMDGPU_PTE_SNOOPED : 0;
+		if (gc_ip_version >= IP_VERSION(12, 0, 0))
+			pte_flags |= AMDGPU_PTE_IS_PTE;
+
+		amdgpu_gmc_get_vm_pte(adev, svm->vm, NULL, mapping_flags,
+				      &pte_flags);
+		pte_flags |= AMDGPU_PTE_READABLE;
+		if (!params.gpu_ro)
+			pte_flags |= AMDGPU_PTE_WRITEABLE;
+	}
+
+	if (read_only)
+		pte_flags &= ~AMDGPU_PTE_WRITEABLE;
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
+		/*
+		 * The struct hmm_range hmm_range field inside amdgpu_hmm_range
+		 * is drm_gpusvm internal state. It is not exposed to the
+		 * implementing driver and is managed entirely by the framework
+		 * as part of the framework logic. This amdgpu_vm_map_range call
+		 * always runs inside the drm_gpusvm notifier, so omitting
+		 * hmm_range here is safe.
+		 */
+		ret = amdgpu_vm_map_range(svm->adev, svm->vm,
+					  flush_tlb && is_last_seg, true, NULL,
+					  start_page, last_page, pte_flags,
+					  0, entry->addr, NULL, NULL, NULL,
+					  wait_fence && is_last_seg ? fence : NULL);
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
+	/*
+	 * UMD doesn't set RO for some RO VMAs, but the drm gpu svm framework
+	 * denies no RO flag range insert for RO VMAs, so treat
+	 * -EPERM as an indication of RO and retry if not set.
+	 */
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
+retry:
+	ret = drm_gpusvm_range_get_pages(&svm->gpusvm, range, ctx);
+	/*
+	 * HMM returns -EPERM when write access is requested for a read-only
+	 * VMA. Retry as read-only so the eventual GPU mapping follows the CPU
+	 * VMA permissions.
+	 */
+	if (ret == -EPERM && !ctx->read_only) {
+		ctx->read_only = true;
+		goto retry;
+	}
+
+	if (ret == -EOPNOTSUPP) {
+		AMDGPU_SVM_ERR(
+			"range get pages -EOPNOTSUPP, evict and retry: gpuva=[0x%lx-0x%lx) ret=%d\n",
+			drm_gpusvm_range_start(range),
+			drm_gpusvm_range_end(range), ret);
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
+			amdgpu_svm_flush_tlb(svm);
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
+	bool devmem_possible = amdgpu_svm_devmem_possible(svm);
+	bool need_vram_migration = devmem_possible &&
+				   amdgpu_svm_attr_prefer_vram(attrs);
+	struct drm_gpusvm_ctx map_ctx = {
+		.devmem_possible = devmem_possible,
+		.devmem_only = need_vram_migration,
+		.check_pages_threshold = devmem_possible ? SZ_64K : 0,
+	};
+
+	while (addr < end) {
+		struct amdgpu_svm_range *range;
+		unsigned long next_addr;
+		/* reset read_only every iteration, amdgpu_svm_range_find_or_insert may change it */
+		map_ctx.read_only = !!(attrs->flags & AMDGPU_SVM_ATTR_BIT_GPU_RO);
+
+		range = amdgpu_svm_range_find_or_insert(svm, addr,
+							addr, end,
+							&map_ctx);
+		if (IS_ERR(range)) {
+			AMDGPU_SVM_ERR(
+				"failed to find/insert range for gpuva 0x%lx [0x%lx-0x%lx), ret=%ld\n",
+				addr, start, end, PTR_ERR(range));
+			return PTR_ERR(range);
+		}
+
+		next_addr = drm_gpusvm_range_end(&range->base);
+		if (next_addr <= addr)
+			return -EINVAL;
+
+		if (amdgpu_svm_range_is_valid(range, attrs)) {
+			addr = next_addr;
+			continue;
+		}
+
+		/* TODO: add migration */
+
+		AMDGPU_SVM_RANGE_TRACE(range, "GET PAGES");
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
+		AMDGPU_SVM_RANGE_TRACE(range, "UPDATE MAPPING");
+
+		ret = amdgpu_svm_range_update_mapping(svm, range, attrs,
+						      map_ctx.read_only,
+						      true, true,
+						      true);
+		if (ret) {
+			AMDGPU_SVM_ERR("failed to update gpu map for range [0x%lx-0x%lx), ret=%d\n",
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
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
index 39db3a18b5f2f..e5a5f52166576 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
@@ -126,4 +126,44 @@ struct amdgpu_svm_range_op_ctx {
 	uint8_t pending_ops;
 };
 
+uint64_t amdgpu_svm_range_attr_pte_flags(struct amdgpu_svm *svm,
+					 const struct amdgpu_svm_attrs *attrs,
+					 bool read_only,
+					 enum drm_interconnect_protocol proto);
+int amdgpu_svm_range_lock_vm_pd(struct amdgpu_svm *svm,
+				struct drm_exec *exec,
+				bool intr);
+bool amdgpu_svm_range_pages_valid(struct amdgpu_svm *svm,
+				  struct amdgpu_svm_range *range);
+bool amdgpu_svm_range_is_valid(struct amdgpu_svm_range *range,
+			       const struct amdgpu_svm_attrs *attrs);
+int amdgpu_svm_range_update_gpu_range(struct amdgpu_svm *svm,
+				      struct amdgpu_svm_range *range,
+				      const struct amdgpu_svm_attrs *attrs,
+				      bool read_only,
+				      bool flush_tlb, bool wait,
+				      struct dma_fence **fence);
+int amdgpu_svm_range_update_mapping(struct amdgpu_svm *svm,
+				    struct amdgpu_svm_range *range,
+				    const struct amdgpu_svm_attrs *attrs,
+				    bool read_only,
+				    bool intr, bool wait,
+				    bool flush_tlb);
+int amdgpu_svm_range_map_attrs(struct amdgpu_svm *svm,
+			       const struct amdgpu_svm_attrs *attrs,
+			       unsigned long start, unsigned long end);
+int amdgpu_svm_range_zap_ptes(struct amdgpu_svm *svm,
+			      struct amdgpu_svm_range *range,
+			      unsigned long start_page,
+			      unsigned long last_page);
+void amdgpu_svm_range_evict(struct amdgpu_svm *svm,
+			    struct drm_gpusvm_range *range);
+struct amdgpu_svm_range *
+amdgpu_svm_range_find_or_insert(struct amdgpu_svm *svm, unsigned long addr,
+				unsigned long gpuva_start, unsigned long gpuva_end,
+				struct drm_gpusvm_ctx *ctx);
+int amdgpu_svm_range_get_pages(struct amdgpu_svm *svm,
+			       struct drm_gpusvm_range *range,
+			       struct drm_gpusvm_ctx *ctx);
+
 #endif /* __AMDGPU_SVM_RANGE_H__ */
-- 
2.53.0

