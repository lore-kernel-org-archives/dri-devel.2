Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCFB606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 03:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=oZVxAXiF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7894D10F88C;
	Wed, 21 Oct 2026 03:00:16 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010037.outbound.protection.outlook.com [52.101.85.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51D1310F893;
 Wed, 21 Oct 2026 03:00:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uqX9/aphN3QJBF2T/c0XWVRm0vAfpSvok7X6fdFGx7XvKkR9yuQwGazRms5LD1jB7jreTvCPjOcNKOIeUGhThLn2g0JTyufC2Ckh+4A1uUIdLCytkhPdiuu/9Rh7omlNWN3mqMtcdridAk9jzyAnmqrwPyg+LbvEX/RV8nm1sIYlHWllDTWRlj6kIkwsj/aah+FNXzDRGI6gM7saJIOUYcbAWmMwTAvQF3eySbVgD1BK/QprDjO7FD3jOE1Fy+xbaduehKMm4w4joBrEp7vY73IhaPCLkrUBsIgfsGL6aqDCYUrAMWugznMC2McMnrNA02ieKxbrZL4WwUGQG/XYcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ca3OAXq5goJs/kCU2QAkSfQJImeKoxW6TRfjp5/cPFQ=;
 b=SGwH3VJLGyNhCXmGdHbOjQIHQkixs/AZGYVoxYZuG99YRvHM+QohOejQXczM8Ss4xgpM+AsSGRWjT4yMM+fgaZnvIyiLusXXPr4FH2nYJJg4JbaW2QkNh4Gt3r0X2EqI1FnmNBw2xF/plCDHlyAyBi12/bFbfniRuhiguGvAxihU99rU2NPV3AOZ7Kf/jxHB6VbBHw2ysMbxLQ5H5WI5KNmNjyccrUJbFRDLz4KMzdrfk4QB95BeJUbHhstdYo4Oc4IUHJwKHCo9Ff3VcdAnYWe0ejx5nPVtvP1qMUz3s3sihekxE85Z4Fh6p5zX2mRbU4HgObmft/loc73irtuR6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ca3OAXq5goJs/kCU2QAkSfQJImeKoxW6TRfjp5/cPFQ=;
 b=oZVxAXiF0Q5WhWXS4LI090Ufvx7qkS10y/ed91kcWOr+JaBH4rhrI34NWmwZmgBmgA71nMCd5Nh/Hn+LQduA97BNzqwlX76kF17bF4jqC5JeDbcnCGjV8jN26lI/OD20JVZPRiJESmKx99iSVjsLIUbBYl4D/CkEE8hHjqZOBNA=
Received: from PH0PR07CA0029.namprd07.prod.outlook.com (2603:10b6:510:5::34)
 by SJ2PR12MB8184.namprd12.prod.outlook.com (2603:10b6:a03:4f2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 03:00:03 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:510:5:cafe::15) by PH0PR07CA0029.outlook.office365.com
 (2603:10b6:510:5::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Wed,
 21 Oct 2026 03:00:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 03:00:02 +0000
Received: from hr-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 21:59:57 -0500
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
Subject: [PATCH v10 07/22] drm/amdgpu: implement SVM range GPU mapping core
Date: Wed, 21 Oct 2026 10:58:46 +0800
Message-ID: <20261021025915.2433837-8-ray.huang@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021025915.2433837-1-ray.huang@amd.com>
References: <20261021025915.2433837-1-ray.huang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|SJ2PR12MB8184:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b384a8a-09e2-4baf-4901-08df2f1f6707
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|921020|56012099006|261009223327099003|261009220027099003|11063799006|261009221227099003|261009221727099003|261009223027099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: /ecO6yX7IIrWH0LDpbO76lh59KWdZ5pDqXJ/+tZgIbItGfxCs3JzIZdOQvzO+iw1efVq1RCwjMNR9MwJ0BSjEdyA/mYohvhYkCeZBncPYxZ2mFCXgbll/+tJSZf+Kt1P9GOAODqQOMMa5BPeYixTg2SG7azuuuaIA1vL5v80E0wl8/+Geihb89rxz3ecxZ77oj41+nDHrypn8+t9gQaxc6X/3junFMynpmYNkIsXgXMuGVb3f6L2d+BMXu5B+WFJznWMDhQlYvkFEiVPFDcPepJDFHhtMNBhYvDX0+8XIMd3VrSO8Z2VJoqCdonGNt4bSkwrf0PnkUhMRI+lZyH/ddmUBK/E6EbvDHmZ/PBUqVpmEpO3Prcrj2g/KgVOY3EvfYAV4pHjn93gxCD/ZDzaH8yvovabSNy8zUNIK/RupxdwtAcmnAgCnOBC7SCQZeZcoLzMsq1sD4FY1rcWCc/hQWX9WL9J6pHmpvtrQaT0Q0mvVz8H05PxE9IczPMRspJ5tmf5UrdP3GnY3HUgmRbHU5u4ETLuIiNAp8tWrkVUkRFDuZacw86ufNYJgoJIy04D0f8PrYbj0ym4UethjlF1+RBUuB0beFM/09ru8ezGOjeZnPhTgrtsEhLoP+QJ1q0Rp77YF5RWT560q+N7+bFKgEillU+fMlMiOYpMPpfa8mxIinNQ4WyNapvKKsRxBvIoTnO2S5k5FZfL/36bkZFq66dcsVCYy4yYvCbQ0pOavWmdSqo/HPol+mUZL3tvML9K
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(921020)(56012099006)(261009223327099003)(261009220027099003)(11063799006)(261009221227099003)(261009221727099003)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6h6G1zOC99KV2d+SolWM5RrZSnUvE5T7NYglRyOj3q1BvrjkRCkNLKmqwUDnitynSzxU5RUOz+Vu+IKpsCchYzpwP1tK4bXozfEGL70gYHe9g9u3EU2KPE+NuuEcbMNioHogIy5XZRnrm3avPAmTjWPwfZdzXOC04m5eUFF5Y/pXXnqm/cGeRuZ8ApvvGRF0ZhoYzpUDn/8BA8n8PHYIkZ9xHqb4eeS3KqGPYo90I+eQAklPI6C5/+fEeoq4VpKOL26VyRhpbx6Nw4qOiEyaJ+VhdbcgeY//ilxbs9nGXabJctlRk0E4AFlp0SkAatCgcGSp+azbDi5DdvPjwSAX88duiyOIuzUu9AwEaxB5zD+DYUVF+5vcDwxDyofI4hMKUwGeM1rNDdwIDT/k6Bsg/zPsxsvUz8ZoODoq1PLOh/9MQXqezpms1QbXIaGtqEfk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 03:00:02.8252 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b384a8a-09e2-4baf-4901-08df2f1f6707
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8184
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

Suggested-by: Christian König <christian.koenig@amd.com>
Suggested-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h       |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c | 417 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h |  40 ++
 3 files changed, 461 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
index 72f954d2df39e..cfdc4e6d045b7 100644
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
index 0000000000000..d4830e53f3d8e
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
@@ -0,0 +1,417 @@
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
+		pr_err_ratelimited("range get pages -EOPNOTSUPP, evict and retry: gpuva=[0x%lx-0x%lx) ret=%d\n",
+				   drm_gpusvm_range_start(range),
+				   drm_gpusvm_range_end(range), ret);
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
+			pr_err_ratelimited("failed to find/insert range for gpuva 0x%lx [0x%lx-0x%lx), ret=%ld\n",
+					   addr, start, end, PTR_ERR(range));
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
+			pr_err_ratelimited("failed to get pages for range [0x%lx-0x%lx), ret=%d\n",
+					   drm_gpusvm_range_start(&range->base),
+					   drm_gpusvm_range_end(&range->base), ret);
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
+			pr_err_ratelimited("failed to update gpu map for range [0x%lx-0x%lx), ret=%d\n",
+					   drm_gpusvm_range_start(&range->base),
+					   drm_gpusvm_range_end(&range->base), ret);
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

