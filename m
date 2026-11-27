Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21C4606A326
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=GC6Tveyg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 219F3112863;
	Fri, 27 Nov 2026 08:42:46 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010014.outbound.protection.outlook.com [52.101.201.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43DDA11285E;
 Fri, 27 Nov 2026 08:42:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fedeYvH3a/kGRHUxrJZzDMdueba3DG9b8G1fFbBko5P2mJr4OE9ae8W7N7wlKc1Wse8khdAA3+CCO+MAg91xphTcczx6h8T8MxKjFnXuH+0s8HMrWn/ULOAcaXFsBNDJ+Kn0EexcK5thngIaz0KnXE1abqQADOyEHWCgOgenNOfgENGzLEyFZoTHLvNmvRTtUiLAfysfLmtP6VbwgM+brYQCDf1PcjoVcpyGsG3uQBc2Ue0LhjQn/E758+9OV9SweXx7XeY3eAcSc2SiSFdziYVAyo277w3BgoUBkjH47l+j51cCb7e243ebt3KzBFxMDNLauqtGUEaQ+DnXPlenZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HEOKExcdTEadGYk/44PuGfHdXgMaGfGtbmOF6EOLv6I=;
 b=YhL4cy1V/uukAAS5XxgyCR8a+WmtnVBWn05h/hCfhjJdoK12FhwmzXhG4M+a7wREQNi1dBfxJkMDvVK1NLcHE8B5Fa7c/VKZJAG60feNyOQVtmKZOltsATRduArHEbMofcSZGMq1rbXp0/Nh0tzKmYWMZh22NUzcfhAY2nnNpba66yJbsK/pfwxWR4rjCtVaTOMyL7kG0aNLu9fc3aHFG4zLZZHPwJduQnhr7nVFBgtMhCEqsXdDvihFUc4Ew3MysfsJ7Y0M/IsGrIZmbWWKUnJrv/KNd0aV5RLf0/3HLfdxu0lOTFBDzLe8Y4d6PVFUStZRhMSX9O8xwCFTCFlcSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEOKExcdTEadGYk/44PuGfHdXgMaGfGtbmOF6EOLv6I=;
 b=GC6Tveyg01GEWXmt/OvyIKyJMvedmP+uFnUra/9sq+zP9auoqCbBUCAjo3SkgBBh/IqtxYD629KakI8ahD+Zj/0QZ5xyJMPOUZPlplZ9WCICtYlV6jHxgpv4fIbXkHTczYCRCNw6WDUw25oI0FO5K4yOmMtpYBwpk7bHGn/6I/Q=
Received: from CH0PR03CA0057.namprd03.prod.outlook.com (2603:10b6:610:b3::32)
 by IA4PR12MB205676.namprd12.prod.outlook.com (2603:10b6:207:112::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.10; Fri, 27 Nov
 2026 08:42:26 +0000
Received: from CH2PEPF000166BF.namprd04.prod.outlook.com
 (2603:10b6:610:b3:cafe::a8) by CH0PR03CA0057.outlook.office365.com
 (2603:10b6:610:b3::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.10 via Frontend Transport; Fri,
 27 Nov 2026 08:42:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF000166BF.mail.protection.outlook.com (10.167.252.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 08:42:26 +0000
Received: from hr-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 02:42:20 -0600
From: Huang Rui <ray.huang@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, Alex Deucher <alexander.deucher@amd.com>, "Felix
 Kuehling" <felix.kuehling@amd.com>, Simona Vetter <simona@ffwll.ch>, "Matthew
 Brost" <matthew.brost@intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Aveline Noir <jm5905938@gmail.com>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>
CC: Xiaogang Chen <xiaogang.chen@amd.com>, Oak Zeng <Oak.Zeng@amd.com>, "Jenny
 Liu" <Jenny-Jing.Liu@amd.com>, Zhu Lingshan <lingshan.zhu@amd.com>,
 "Honglei
 Huang" <honglei1.huang@amd.com>, Junhua Shen <Junhua.Shen@amd.com>, Yiru Ma
 <yiru.ma@amd.com>, Huang Rui <ray.huang@amd.com>, Honglei Huang
 <honghuan@amd.com>
Subject: [PATCH v11 07/22] drm/amdgpu: implement SVM range GPU mapping core
Date: Fri, 27 Nov 2026 16:41:30 +0800
Message-ID: <20261127084149.925625-8-ray.huang@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261127084149.925625-1-ray.huang@amd.com>
References: <20261127084149.925625-1-ray.huang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000166BF:EE_|IA4PR12MB205676:EE_
X-MS-Office365-Filtering-Correlation-Id: ff7c79a8-4d5a-4166-772e-08df4c625d1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|23010399003|82310400026|921020|261022115727099003|10067099003|56012099006|261026121527099003|261026130827099003|261026140227099003|261028144727099003|261022113327099003|261022105027099003|261022075727099003|261021135927099003|261021123027099003|261021121427099003|261021130227099003|261102123227099003|261009223027099003|22082099003|18002099003|11063799006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: UCxgjV6ZPYageGlnFL5e5iUtjhPMo0wTBCdnWrEUYhST/KX0Ibzh/FbpL6nkH9Z/zXDpVV4lGyf4TJNKjg+MR3ChPKjq8XXuEg05Gjc4FMWmnHKEGXxePC32So9H4/r/G/5bMqoe5xQ0k+wOfffnEQ57R4bnvruwIjWHF5e2Kt24IeuVolEOJU3shf9g9Y62xe4SsjuHwf2m2dxV7wm6qnSiMqQr3dZBHZYyrhfNtLhdNQPUUtgNn5PjPsx43zVAJCH6qBVP3hQq1ml7KJNFaRhfJ9JXDzq6FJsml6genh7ky9/Hqp8N42QsuVN3N9Dwe+kf9zR3mNX6CKSE9I+a13Gffpg9iBrkKnNO5aSBBWHSKPjZ7PNVo1JDFDOSrIDSq0jZb9HySQZmdS+kDY+lddxIQqV2HCrlD20zleNan7LNghSm6XUCLqZtMYRGGK+jfiXJd6tyO5n0Md3TP2qgX2SB1UDkTuRVarhxTfAzjYiR6Rup7D4WQ7hfJBpQzrXQP3huEMeE4IQq7F3ubhq8l51EysPlVYFdLV6vhjpE03E/GOAkGx9EdU+VbkFkf8Kt95NoeXjaqQQkbAq2i8v4/cVCDwR0ISHEz+vGVc2vgLR8jSJPnouRxsNsKNtRj7jfNr3OxKY7KXMbPBA9xTxWOqTZJBSGUH9CfYf6s6rrb8RC832RKQy5AmJ1dydKhrrUa5g4vqqqU+blXHr0/GOP4ib9JHaECMGqBSaAf3pQIWAjoDja0sE7BmtLvJiKs8Ob
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(23010399003)(82310400026)(921020)(261022115727099003)(10067099003)(56012099006)(261026121527099003)(261026130827099003)(261026140227099003)(261028144727099003)(261022113327099003)(261022105027099003)(261022075727099003)(261021135927099003)(261021123027099003)(261021121427099003)(261021130227099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(11063799006)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iHRnr9OWEs9fhuRceFz+ZLZ2qmsoiMHVqIfeUYwwosUJH7uewrUT1CWHuxs3IMPkZd9QkzcsbqXBej4qDsQzwjjqcEsKo5ILKJ4OPAK9VmsNEELB/Z0BbZ7e61jlh+RYNIwcP6ofJFw2z9S49IKxxVTTq7dJE47f7Iow3WcNjD1Oy/yKaVBQLrUwgp6I5BWL3mLevvmLYh5J4RqlkbK+TJZ1UBnCDVMzIfyqpuKnIGhMERY+IfE2IDLAb1IMWLtyEhJD0BS8I8jWYf/259NSM5279qcHMHGY83dFeH/9LCbn1PzlVYbAnLJZCZcenCBEMeotv9P4ENHLmuXhsuB0JFUN2VHt2P1oQ1whaI3qdbczZWREPGdOdNJyhqxi13saJRZQZYlosxUj1cTrYzajgxdcP/dtklate4nEbMcEVgKHGun1NzucK0WMZvt6DOdX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 08:42:26.2134 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff7c79a8-4d5a-4166-772e-08df4c625d1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000166BF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB205676
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Honglei Huang <honghuan@amd.com>

Map system-memory SVM ranges through the common get_vm_pte interface.
Describe backing pages as TTM_PL_TT, translate coherence attributes to
GEM flags and set base permissions before hardware encoding. Preserve
system DMA/IOVA addresses and reject unsupported interconnect types.

Provide range lookup, page collection, mapping validity and attribute
mapping helpers. Keep drm_exec reservation loops at their call sites
and enforce SVM access and write-fault permissions. VRAM migration is
not part of this implementation.

Collect and validate pages through the generic drm_gpusvm pages APIs.
Use the AMDGPU-owned DMA cache and reject ranges with unmapped or
partially unmapped state before validating the page sequence.

Return reported compute TLB flush errors to prefetch callers instead
of reporting a successful mapping update when the flush fails.

Execute explicit SYSMEM prefetch through the existing GPUSVM eviction
helper before collecting pages and updating GPU mappings. Do not skip
the request for an already valid mapping or let a LOCAL preference
override its target. Return eviction errors without continuing to map.
This does not enable the AMDGPU VRAM migration backend.

Suggested-by: Christian König <christian.koenig@amd.com>
Suggested-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h       |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c | 338 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h |  21 ++
 3 files changed, 363 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
index c21690c2d2117..e8a9df974988e 100644
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
 
+#define AMDGPU_INTERCONNECT_VRAM DRM_INTERCONNECT_DRIVER
+#define AMDGPU_INTERCONNECT_P2P (AMDGPU_INTERCONNECT_VRAM + 1)
+
 enum amdgpu_svm_xnack_mode {
 	AMDGPU_SVM_XNACK_OFF,
 	AMDGPU_SVM_XNACK_ON,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
new file mode 100644
index 0000000000000..405284f80734c
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
@@ -0,0 +1,338 @@
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
+bool amdgpu_svm_range_pages_valid(struct amdgpu_svm *svm, struct amdgpu_svm_range *range)
+{
+	struct drm_gpusvm_range *base = &range->base;
+
+	lockdep_assert_held(&svm->gpusvm.notifier_lock);
+
+	if (base->flags.unmapped || base->flags.partial_unmap)
+		return false;
+
+	return drm_gpusvm_pages_valid(&svm->gpusvm, &range->pages);
+}
+
+bool amdgpu_svm_range_is_valid(struct amdgpu_svm_range *range, const struct amdgpu_svm_attrs *attrs)
+{
+	return READ_ONCE(range->gpu_mapped) && READ_ONCE(range->attr_flags) == attrs->flags;
+}
+
+int amdgpu_svm_range_zap_ptes(struct amdgpu_svm *svm, struct amdgpu_svm_range *range,
+			      unsigned long start_page, unsigned long last_page)
+{
+	struct dma_fence *fence = NULL;
+	unsigned int flags;
+	int ret;
+
+	if (last_page < start_page)
+		return 0;
+
+	flags = memalloc_noreclaim_save();
+	ret = amdgpu_vm_unmap_range(svm->adev, svm->vm, true, NULL, start_page, last_page, &fence);
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
+int amdgpu_svm_range_update_gpu_range(struct amdgpu_svm *svm, struct amdgpu_svm_range *range,
+				      const struct amdgpu_svm_attrs *attrs, bool read_only,
+				      bool flush_tlb, bool wait_fence, struct dma_fence **fence)
+{
+	struct drm_gpusvm_range *base = &range->base;
+
+	lockdep_assert_held(&svm->gpusvm.notifier_lock);
+
+	const unsigned long range_start_page = drm_gpusvm_range_start(base) >> PAGE_SHIFT;
+	const unsigned long range_end_page = drm_gpusvm_range_end(base) >> PAGE_SHIFT;
+	const unsigned long npages = range_end_page - range_start_page;
+	struct amdgpu_gmc_pte_mem pte_mem = {
+		.adev = svm->adev,
+		.mem_type = TTM_PL_TT,
+		.mem_id = svm->vm->mem_id,
+	};
+	u64 base_flags = AMDGPU_PTE_VALID | AMDGPU_PTE_READABLE | svm->adev->gmc.init_pte_flags;
+	u32 vm_flags = 0;
+	unsigned long mapped_pages = 0;
+	unsigned long dma_idx = 0;
+	int ret;
+
+	if (!range->pages.dma_addr || !npages)
+		return -EINVAL;
+
+	if (!read_only && !(attrs->flags & AMDGPU_SVM_ATTR_BIT_GPU_RO))
+		base_flags |= AMDGPU_PTE_WRITEABLE;
+	if (attrs->flags & AMDGPU_SVM_ATTR_BIT_COHERENT)
+		pte_mem.flags |= AMDGPU_GEM_CREATE_COHERENT;
+	if (attrs->flags & AMDGPU_SVM_ATTR_BIT_EXT_COHERENT)
+		pte_mem.flags |= AMDGPU_GEM_CREATE_EXT_COHERENT;
+	if (attrs->flags & AMDGPU_SVM_ATTR_BIT_GPU_EXEC)
+		vm_flags |= AMDGPU_VM_PAGE_EXECUTABLE;
+
+	while (mapped_pages < npages) {
+		const struct drm_pagemap_addr *entry = &range->pages.dma_addr[dma_idx++];
+		unsigned long seg_pages =
+			min_t(unsigned long, 1UL << entry->order, npages - mapped_pages);
+		u64 pte_flags = base_flags;
+		u64 dst = entry->addr;
+		unsigned long start_page, last_page;
+		bool is_last_seg;
+
+		if (entry->proto != DRM_INTERCONNECT_SYSTEM)
+			return -EOPNOTSUPP;
+		pte_flags |= AMDGPU_PTE_SYSTEM | AMDGPU_PTE_SNOOPED;
+
+		amdgpu_gmc_get_vm_pte(svm->adev, svm->vm, &pte_mem, vm_flags, &dst, &pte_flags);
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
+		ret = amdgpu_vm_map_range(svm->adev, svm->vm, flush_tlb && is_last_seg, true, NULL,
+					  start_page, last_page, pte_flags, 0, dst, NULL, NULL,
+					  NULL, wait_fence && is_last_seg ? fence : NULL);
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
+	r = drm_gpusvm_range_find_or_insert(&svm->gpusvm, addr, gpuva_start, gpuva_end, ctx);
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
+int amdgpu_svm_range_get_pages(struct amdgpu_svm *svm, struct drm_gpusvm_range *range,
+			       struct drm_gpusvm_ctx *ctx)
+{
+	int ret;
+
+retry:
+	ret = drm_gpusvm_get_pages(&svm->gpusvm, &to_amdgpu_svm_range(range)->pages, svm->gpusvm.mm,
+				   &range->notifier->notifier, drm_gpusvm_range_start(range),
+				   drm_gpusvm_range_end(range), ctx);
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
+				   drm_gpusvm_range_start(range), drm_gpusvm_range_end(range), ret);
+		amdgpu_svm_range_evict(svm, range);
+	}
+
+	return ret;
+}
+
+void amdgpu_svm_range_evict(struct amdgpu_svm *svm, struct drm_gpusvm_range *range)
+{
+	if (!to_amdgpu_svm_range(range)->pages.flags.has_devmem_pages)
+		return;
+
+	drm_gpusvm_range_evict(&svm->gpusvm, range);
+}
+
+int amdgpu_svm_range_update_mapping(struct amdgpu_svm *svm, struct amdgpu_svm_range *range,
+				    const struct amdgpu_svm_attrs *attrs, bool read_only, bool intr,
+				    bool wait, bool flush_tlb)
+{
+	struct drm_exec exec;
+	struct dma_fence *fence = NULL;
+	unsigned int exec_flags = DRM_EXEC_IGNORE_DUPLICATES;
+	unsigned int flags;
+	int ret;
+
+	if (intr)
+		exec_flags |= DRM_EXEC_INTERRUPTIBLE_WAIT;
+	drm_exec_init(&exec, exec_flags, 0);
+	drm_exec_until_all_locked(&exec) {
+		ret = amdgpu_vm_lock_pd(svm->vm, &exec, 1);
+		drm_exec_retry_on_contention(&exec);
+		if (ret) {
+			drm_exec_fini(&exec);
+			return ret;
+		}
+	}
+
+	flags = memalloc_noreclaim_save();
+	drm_gpusvm_notifier_lock(&svm->gpusvm);
+
+	if (!amdgpu_svm_range_pages_valid(svm, range)) {
+		amdgpu_svm_range_invalidate_gpu_mapping(range);
+		ret = -EAGAIN;
+	} else {
+		ret = amdgpu_svm_range_update_gpu_range(svm, range, attrs, read_only, flush_tlb,
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
+		ret = amdgpu_vm_update_pdes(svm->adev, svm->vm);
+
+	if (!ret) {
+		if (flush_tlb)
+			ret = amdgpu_svm_flush_tlb(svm);
+		WRITE_ONCE(range->attr_flags, attrs->flags);
+		WRITE_ONCE(range->gpu_mapped, true);
+		range->validate_timestamp = ktime_get_boottime();
+	}
+
+	drm_exec_fini(&exec);
+	return ret;
+}
+
+int amdgpu_svm_range_map_attrs(struct amdgpu_svm *svm, const struct amdgpu_svm_attrs *attrs,
+			       unsigned long start, unsigned long end)
+{
+	unsigned long addr = start;
+	int ret;
+	bool devmem_possible = amdgpu_svm_devmem_possible(svm);
+	bool prefetch_sysmem = amdgpu_svm_attr_prefetch_sysmem(attrs);
+	bool need_vram_migration = attrs->access == AMDGPU_SVM_ACCESS_ALLOW_MIGRATE &&
+				   devmem_possible && !prefetch_sysmem &&
+				   amdgpu_svm_attr_prefer_vram(attrs);
+	struct drm_gpusvm_ctx map_ctx = {
+		.devmem_possible = devmem_possible,
+		.devmem_only = need_vram_migration,
+		.check_pages_threshold = devmem_possible ? SZ_64K : 0,
+	};
+
+	if (!amdgpu_svm_attr_has_access(attrs->access))
+		return -EPERM;
+
+	while (addr < end) {
+		struct amdgpu_svm_range *range;
+		unsigned long next_addr;
+		/* reset read_only every iteration, amdgpu_svm_range_find_or_insert may change it */
+		map_ctx.read_only = !!(attrs->flags & AMDGPU_SVM_ATTR_BIT_GPU_RO);
+
+		range = amdgpu_svm_range_find_or_insert(svm, addr, addr, end, &map_ctx);
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
+		if (amdgpu_svm_range_is_valid(range, attrs) && !prefetch_sysmem) {
+			addr = next_addr;
+			continue;
+		}
+
+		if (prefetch_sysmem) {
+			ret = drm_gpusvm_range_evict(&svm->gpusvm, &range->base);
+			if (ret)
+				return ret;
+		}
+
+		AMDGPU_SVM_RANGE_TRACE(range, "GET PAGES");
+
+		ret = amdgpu_svm_range_get_pages(svm, &range->base, &map_ctx);
+		if (ret) {
+			pr_err_ratelimited("failed to get pages for range [0x%lx-0x%lx), ret=%d\n",
+					   drm_gpusvm_range_start(&range->base),
+					   drm_gpusvm_range_end(&range->base), ret);
+			return ret;
+		}
+
+		AMDGPU_SVM_RANGE_TRACE(range, "UPDATE MAPPING");
+
+		ret = amdgpu_svm_range_update_mapping(svm, range, attrs, map_ctx.read_only, true,
+						      true, true);
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
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
index ad2df5924ebc8..641e1dee9e500 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
@@ -130,4 +130,25 @@ struct amdgpu_svm_range_op_ctx {
 	u8 pending_ops;
 };
 
+bool amdgpu_svm_range_pages_valid(struct amdgpu_svm *svm, struct amdgpu_svm_range *range);
+bool amdgpu_svm_range_is_valid(struct amdgpu_svm_range *range,
+			       const struct amdgpu_svm_attrs *attrs);
+int amdgpu_svm_range_update_gpu_range(struct amdgpu_svm *svm, struct amdgpu_svm_range *range,
+				      const struct amdgpu_svm_attrs *attrs, bool read_only,
+				      bool flush_tlb, bool wait, struct dma_fence **fence);
+int amdgpu_svm_range_update_mapping(struct amdgpu_svm *svm, struct amdgpu_svm_range *range,
+				    const struct amdgpu_svm_attrs *attrs, bool read_only, bool intr,
+				    bool wait, bool flush_tlb);
+int amdgpu_svm_range_map_attrs(struct amdgpu_svm *svm, const struct amdgpu_svm_attrs *attrs,
+			       unsigned long start, unsigned long end);
+int amdgpu_svm_range_zap_ptes(struct amdgpu_svm *svm, struct amdgpu_svm_range *range,
+			      unsigned long start_page, unsigned long last_page);
+void amdgpu_svm_range_evict(struct amdgpu_svm *svm, struct drm_gpusvm_range *range);
+struct amdgpu_svm_range *
+amdgpu_svm_range_find_or_insert(struct amdgpu_svm *svm, unsigned long addr,
+				unsigned long gpuva_start, unsigned long gpuva_end,
+				struct drm_gpusvm_ctx *ctx);
+int amdgpu_svm_range_get_pages(struct amdgpu_svm *svm, struct drm_gpusvm_range *range,
+			       struct drm_gpusvm_ctx *ctx);
+
 #endif /* __AMDGPU_SVM_RANGE_H__ */
-- 
2.53.0

