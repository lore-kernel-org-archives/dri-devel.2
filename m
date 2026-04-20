Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D07F36C5F
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 12:08:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 546D310E53F;
	Mon, 20 Apr 2026 12:08:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q84l+1Re";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010062.outbound.protection.outlook.com [52.101.56.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 324C210E545;
 Mon, 20 Apr 2026 12:08:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uM4NqHdjHOC9UiSw/CNNWro7xQ9iYH68ga43KHqnCwU/2L7V6rMzq1sPl8qcPXrSwePUFKrUqA4LjETX8sLHMskMz6Ob5nggwNsb7A2h3eiqn5PSYwdU54lL3MfnAa2hd40+NRrMEEi7LpCpem3Tqetk7SPuEQ5lo/JIdEQgFQeezwCM8wDk+qRpU0nL+qgbpcMBO5z3icB3lXPXVdY/q00oMVpiCuxqfDmEmV+RcbtFlpjHTWJuRW2JPQGJ9L8Omudrqnog6NpPw4CvZWFQwlR+PN+eXuFpq/9zjdyrIZT1QLKyv7ofT2O0DtuxE3UDjuY1fV5E7lO7ShzJcQCnKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=494+aPBcH6p53QlGXAXgLQqq1+JKD/3cGv15hoOBnOE=;
 b=kYwn+K828FNC/6NjT3/xfTWzUyoQEp5uBvscY2va0NE0DPlo7lWJ7bZiNFeZAW5bLMgK2+ZiW8nrVpm2TIfd6eh6YCI0xOFqgk4W2xATbAzUwaceZFKNKafRj+Bsp7IMVkM3hfmNkUpvCiEAKLrvmw7Amito56Ln2V3J2Ofsdg9zwUKNwEc6XjzguzSXMmRIEb8OnIII8Zy1CgJq0Hxw63v+tsDMr46EXwH7MH+yWD6hHtFDp3x0NZb/bxS+LBf2Nr66pWnBFnzyHSLX3jKOeHt/M5QvQntK0bGoglIyPAhOGiRxyMFV+S/QX8Mv1yb8ZO9jClBXRC8Oh2AMoMT0Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=494+aPBcH6p53QlGXAXgLQqq1+JKD/3cGv15hoOBnOE=;
 b=Q84l+1Re+wEUgyRXjAgz1b2IKCYvn0sxjICzoDoPOjlkRnMe40NwvvMzB1aT6ePcWVXtQyg19dFrX5+Bdk0m94oHEN6skKy5H/mXEaMo7gA4DeXufBD9n3OdrbGczwETE08mSZFmjNbUxWNx3J00OMtVOaD9gt+xfhp3jMPtmSA=
Received: from SJ0PR13CA0185.namprd13.prod.outlook.com (2603:10b6:a03:2c3::10)
 by LV9PR12MB9784.namprd12.prod.outlook.com (2603:10b6:408:2ed::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.12; Mon, 20 Apr
 2026 12:08:31 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::da) by SJ0PR13CA0185.outlook.office365.com
 (2603:10b6:a03:2c3::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Mon,
 20 Apr 2026 12:08:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Mon, 20 Apr 2026 12:08:30 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Apr
 2026 07:08:26 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <matthew.brost@intel.com>,
 <rodrigo.vivi@intel.com>, <thomas.hellstrom@linux.intel.com>,
 <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC/POC PATCH 07/12] drm/amdgpu: implement SVM range PTE flags and
 GPU mapping
Date: Mon, 20 Apr 2026 20:07:34 +0800
Message-ID: <20260420120739.1811731-8-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260420120739.1811731-1-honglei1.huang@amd.com>
References: <20260420120739.1811731-1-honglei1.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb08.amd.com
 (10.181.42.217)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|LV9PR12MB9784:EE_
X-MS-Office365-Filtering-Correlation-Id: 36a00a35-b37f-411a-da87-08de9ed5899c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|921020|18096099003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: cE4X0cYMatlQ4YWbAGNhGPvHr7wQTEJIVvyJb0UrI7Ney+gorszy3AFg1mxSfDc8vP82Wpxv5JOuGgjDNxqMNWX74RSjs17oLEO2jpvrcAGNRmSdLQGxmbKbBIeI4avn34NoMcKS2jG4X+MqHPBtlPJ7neJ6Q8GsXf+FQG+nrNT9JXgEiMIfaEa7aepWf9ZlxTuBEiruiUwhElZ7A6QKF26HbyXNJt2rG7Dxr3RXmQYX3/GxNJ91+WuCHAkbM6O2/K2v9+Q72vwMHGoe86LoY1TV9kHFJfR3Y4cYcy056zDD+vGrVUoohAThsn5mhzt+pXxh4y0vFamadj1YgMenCrNiKaUvzXKTava6tykZSCqAKpZrIKRuVZyDAKn93242oS6YRV1u1d5QUhsNe7LLWuB0qo66p1IFkcX9PlYSlPjYtLu4UF0si8ZHfdLP78NS/f26xCeQCX1ss/99TyJcKXpHdzQobGECtHTNyJYO2BGf5jhNnJKO5Q23e00mdvWeW5Dfl82AoSqfDh3rhGuMu1SWRQfQBqjTJvFMUQbzBefEGV2a3GJhJzUe1QEQIxn0Ay5EY6EU/+JBiDB9Ratv0BNLb36WxADl28p7ril6whgC6qN4VuKpCl1CCkLZbocMvFsUjC15XgytVBYFO/iO2w9KjW0u4fbDKDKo9822RSnRcLx69H+KUD3YKC1qRtCWGL49kHpzPfrAKSsA9vM4/nODQPdI83VTu0aGhTSJScSGNjRbgDBij+UeTTd77BTuigOYBcDs4qQV3t1PqmOCHoK9eoUtb005bnkpPDXQscADE+FE84juq9L9W7dCeEJf
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(921020)(18096099003)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xlh4mU8u1n2di+OvNJaPFe1B8Iap0D8KC72wUQyjsUl+LrBxGRucb/gQuoKc5cSMmvssG4IZ+o8L2HB1UTOg6pc2SWHlvhlRIrKESdO9AEkHfJOIATwlJ9GKbTp/gUl0NX2bCM1yhItkM734R8ew/yAbSVYdKPgKm/fFbu7Q2UfvjXwcw9YLNPU/KhWJt4r0Fl/dpNxROxFIkgpk+rXnhsBXz0gjx2MTL8nB/iXWU9wBRehoyx8H/Y5LfDWRv2PumZerUE8XkRHViy9bRxZjm3MXtADq2glG+tU4DDZAzkVCkFf1Zf6JLd7Q7MBu7Hn1MehZX+M/3eROGNbt2plADkY6u6ApaE1FA8hY2fZ8cR+9KnTNGhk0jGKwaW4bxevx8u/0q8EQZsG/lrK4R4k3bv0kCgir+9CAf1EluvFszy8nndmR4bEygYZYoIe6vBA+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 12:08:30.5853 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36a00a35-b37f-411a-da87-08de9ed5899c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9784
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

Implement the GPU page table mapping core for SVM ranges:

- PTE flag computation per GC IP version (9.4.x, 11.x, 12.x) with
  coherency mode selection (UC/NC/CC/RW) based on SVM flags
- GPU PTE update helpers using amdgpu_vm_update_range with DMA
  address coalescing across contiguous pagemap entries
- Range mapping loop: find_or_insert via drm_gpusvm, get_pages,
  validate under notifier lock, update GPU PTEs, flush TLB
- Attribute-aware mapping: walk the attr tree to map only accessible
  ranges with correct PTE flags
- Attribute change handler: detect trigger types and remap intervals
  when PTE flags, mapping flags, or access state changes

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c | 539 ++++++++++++++++++
 1 file changed, 539 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
new file mode 100644
index 000000000..b3bd4e2e6
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
@@ -0,0 +1,539 @@
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
+#include "amdgpu_svm.h"
+#include "amdgpu_svm_attr.h"
+#include "amdgpu_svm_range.h"
+#include "amdgpu.h"
+#include "amdgpu_amdkfd.h"
+#include "amdgpu_vm.h"
+
+#include <drm/drm_exec.h>
+#include <drm/drm_pagemap.h>
+
+#include <linux/mmu_notifier.h>
+#include <uapi/linux/kfd_ioctl.h>
+
+enum amdgpu_svm_range_queue_op {
+	AMDGPU_SVM_RANGE_OP_RESTORE = 0,
+	AMDGPU_SVM_RANGE_OP_UNMAP = 1,
+};
+
+enum amdgpu_svm_range_pending_op {
+	AMDGPU_SVM_RANGE_PENDING_OP_NONE    = 0,
+	AMDGPU_SVM_RANGE_PENDING_OP_UNMAP   = BIT(0),
+	AMDGPU_SVM_RANGE_PENDING_OP_RESTORE = BIT(1),
+};
+
+#define UNMAP_WORK(ops) ((ops) & AMDGPU_SVM_RANGE_PENDING_OP_UNMAP)
+
+#define RESTORE_WORK(ops) ((ops) & AMDGPU_SVM_RANGE_PENDING_OP_RESTORE)
+
+#define NEED_REBUILD(svm) (!(svm)->xnack_enabled)
+
+enum amdgpu_svm_range_notifier_op {
+	AMDGPU_SVM_RANGE_NOTIFIER_CLEAR_PTE = BIT(0),
+	AMDGPU_SVM_RANGE_NOTIFIER_QUEUE_INTERVAL = BIT(1),
+};
+
+struct range_pending_op_ctx {
+	struct amdgpu_svm_range *range;
+	unsigned long start;
+	unsigned long last;
+	uint8_t pending_ops;
+};
+
+#define AMDGPU_SVM_RANGE_RESTORE_DELAY_MS 1
+#define AMDGPU_SVM_RANGE_WQ_NAME "amdgpu_svm_range"
+#define AMDGPU_SVM_RESTORE_WQ_NAME "amdgpu_svm_restore"
+
+static void
+amdgpu_svm_range_enqueue(struct amdgpu_svm *svm,
+			 struct amdgpu_svm_range *range,
+			 unsigned long start,
+			 unsigned long last,
+			 enum amdgpu_svm_range_queue_op op);
+
+static inline bool
+range_has_access(enum amdgpu_svm_attr_access access)
+{
+	return access == AMDGPU_SVM_ACCESS_ENABLE ||
+	       access == AMDGPU_SVM_ACCESS_IN_PLACE;
+}
+
+static void
+range_invalidate_gpu_mapping(struct drm_gpusvm_range *range)
+{
+	WRITE_ONCE(to_amdgpu_svm_range(range)->gpu_mapped, false);
+}
+
+static bool
+range_attr_match(struct drm_gpusvm_range *range,
+		 const struct amdgpu_svm_attrs *attrs,
+		 uint64_t pte_flags)
+{
+	struct amdgpu_svm_range *r = to_amdgpu_svm_range(range);
+
+	if (!READ_ONCE(r->gpu_mapped))
+		return false;
+
+	return READ_ONCE(r->pte_flags) == pte_flags &&
+	       READ_ONCE(r->attr_flags) == attrs->flags;
+}
+
+static bool
+range_pages_valid(struct amdgpu_svm *svm,
+		  struct drm_gpusvm_range *range)
+{
+	lockdep_assert_held(&svm->gpusvm.notifier_lock);
+
+	if (range->pages.flags.unmapped || range->pages.flags.partial_unmap)
+		return false;
+
+	return drm_gpusvm_range_pages_valid(&svm->gpusvm, range);
+}
+
+static uint64_t
+amdgpu_svm_range_attr_pte_flags(struct amdgpu_svm *svm,
+			    const struct amdgpu_svm_attrs *attrs)
+{
+	/* WA/POC: a simple pte flags func */
+	uint32_t gc_ip_version = amdgpu_ip_version(svm->adev, GC_HWIP, 0);
+	uint32_t flags = attrs->flags;
+	uint32_t mapping_flags = 0;
+	uint64_t pte_flags;
+	bool coherent = flags & (AMDGPU_SVM_FLAG_COHERENT |
+				 AMDGPU_SVM_FLAG_EXT_COHERENT);
+	bool ext_coherent = flags & AMDGPU_SVM_FLAG_EXT_COHERENT;
+	bool snoop = true;
+	unsigned int mtype_local;
+
+	switch (gc_ip_version) {
+	case IP_VERSION(9, 4, 1):
+	case IP_VERSION(9, 4, 2):
+		mapping_flags |= coherent ?
+			AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
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
+		if (svm->adev->flags & AMD_IS_APU) {
+			if (num_possible_nodes() <= 1)
+				mapping_flags |= mtype_local;
+			else
+				mapping_flags |= ext_coherent ?
+					AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
+		} else {
+			if (gc_ip_version < IP_VERSION(9, 5, 0) || ext_coherent)
+				mapping_flags |= AMDGPU_VM_MTYPE_UC;
+			else
+				mapping_flags |= AMDGPU_VM_MTYPE_NC;
+		}
+		break;
+	case IP_VERSION(11, 0, 0):
+	case IP_VERSION(11, 0, 1):
+	case IP_VERSION(11, 0, 2):
+	case IP_VERSION(11, 0, 3):
+	case IP_VERSION(11, 0, 4):
+	case IP_VERSION(11, 5, 0):
+	case IP_VERSION(11, 5, 1):
+	case IP_VERSION(11, 5, 2):
+	case IP_VERSION(11, 5, 3):
+		mapping_flags |= coherent ?
+			AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
+		break;
+	case IP_VERSION(12, 0, 0):
+	case IP_VERSION(12, 0, 1):
+		mapping_flags |= AMDGPU_VM_MTYPE_NC;
+		break;
+	default:
+		mapping_flags |= coherent ?
+			AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
+		break;
+	}
+
+	if (flags & AMDGPU_SVM_FLAG_GPU_EXEC)
+		mapping_flags |= AMDGPU_VM_PAGE_EXECUTABLE;
+
+	pte_flags = AMDGPU_PTE_VALID | AMDGPU_PTE_SYSTEM;
+	pte_flags |= snoop ? AMDGPU_PTE_SNOOPED : 0;
+	if (gc_ip_version >= IP_VERSION(12, 0, 0))
+		pte_flags |= AMDGPU_PTE_IS_PTE;
+
+	amdgpu_gmc_get_vm_pte(svm->adev, svm->vm, NULL, mapping_flags, &pte_flags);
+	pte_flags |= AMDGPU_PTE_READABLE;
+	if (!(flags & AMDGPU_SVM_FLAG_GPU_RO))
+		pte_flags |= AMDGPU_PTE_WRITEABLE;
+
+	return pte_flags;
+}
+
+static int amdgpu_svm_range_lock_vm_pd(struct amdgpu_svm *svm, struct drm_exec *exec)
+{
+	int ret;
+
+	drm_exec_init(exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
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
+static int
+amdgpu_svm_range_update_gpu(struct amdgpu_svm *svm, unsigned long start_page,
+			   unsigned long last_page, uint64_t pte_flags,
+			   dma_addr_t *pages_addr, bool flush_tlb,
+			   bool update_pdes, bool wait_fence)
+{
+	struct drm_exec exec;
+	struct dma_fence *fence = NULL;
+	int ret;
+
+	ret = amdgpu_svm_range_lock_vm_pd(svm, &exec);
+	if (ret)
+		return ret;
+
+	ret = amdgpu_vm_update_range(svm->adev, svm->vm, false, false,
+				     flush_tlb, true,
+				     NULL, start_page, last_page, pte_flags, 0, 0,
+				     NULL, pages_addr, wait_fence ? &fence : NULL);
+	if (!ret && wait_fence && fence) {
+		ret = dma_fence_wait(fence, false);
+		if (ret < 0)
+			AMDGPU_SVM_TRACE("wait unmap fence failed: ret=%d [0x%lx-0x%lx]-0x%lx\n",
+					 ret, start_page, last_page,
+					 last_page - start_page + 1);
+	}
+	if (!ret && update_pdes)
+		ret = amdgpu_vm_update_pdes(svm->adev, svm->vm, false);
+
+	dma_fence_put(fence);
+	drm_exec_fini(&exec);
+	return ret;
+}
+
+static int
+amdgpu_svm_range_update_gpu_range(struct amdgpu_svm *svm,
+				  struct drm_gpusvm_range *range,
+				  uint64_t pte_flags,
+				  bool flush_tlb,
+				  bool wait_fence,
+				  struct dma_fence **fence)
+{
+	lockdep_assert_held(&svm->gpusvm.notifier_lock);
+
+	const unsigned long range_start_page = drm_gpusvm_range_start(range) >> PAGE_SHIFT;
+	const unsigned long range_end_page = drm_gpusvm_range_end(range) >> PAGE_SHIFT;
+	const unsigned long npages = range_end_page - range_start_page;
+	unsigned long mapped_pages = 0;
+	unsigned long dma_idx = 0;
+	int ret;
+
+	if (!range->pages.dma_addr || !npages)
+		return -EINVAL;
+
+	while (mapped_pages < npages) {
+		const struct drm_pagemap_addr *entry = &range->pages.dma_addr[dma_idx++];
+		unsigned long seg_pages = min_t(unsigned long, 1UL << entry->order,
+						npages - mapped_pages);
+		dma_addr_t seg_addr = entry->addr;
+		unsigned long start_page, last_page;
+		bool is_last_seg;
+
+		if (entry->proto != DRM_INTERCONNECT_SYSTEM)
+			return -EOPNOTSUPP;
+
+		while (mapped_pages + seg_pages < npages) {
+			const struct drm_pagemap_addr *next = &range->pages.dma_addr[dma_idx];
+			unsigned long next_pages = min_t(unsigned long,
+							 1UL << next->order,
+							 npages - (mapped_pages + seg_pages));
+
+			if (next->proto != entry->proto ||
+			    next->addr != seg_addr + ((dma_addr_t)seg_pages << PAGE_SHIFT))
+				break;
+
+			seg_pages += next_pages;
+			dma_idx++;
+		}
+
+		start_page = range_start_page + mapped_pages;
+		last_page = start_page + seg_pages - 1;
+		is_last_seg = mapped_pages + seg_pages == npages;
+
+		ret = amdgpu_vm_update_range(svm->adev, svm->vm, false, false,
+					     flush_tlb && is_last_seg, true, NULL,
+					     start_page, last_page, pte_flags,
+					     0, seg_addr, NULL, NULL,
+					     wait_fence && is_last_seg ? fence : NULL);
+		if (ret)
+			return ret;
+
+		mapped_pages += seg_pages;
+	}
+
+	return 0;
+}
+
+static int
+amdgpu_svm_range_map(struct amdgpu_svm *svm,
+		       unsigned long start,
+		       unsigned long end,
+		       const struct amdgpu_svm_attrs *attrs,
+		       const struct drm_gpusvm_ctx *gpusvm_ctx,
+		       uint64_t pte_flags)
+{
+	unsigned long addr = start;
+	int ret;
+
+	while (addr < end) {
+		struct drm_exec exec;
+		struct drm_gpusvm_ctx map_ctx;
+		struct drm_gpusvm_range *range;
+		struct dma_fence *fence = NULL;
+		unsigned long vma_start;
+		unsigned long next_addr;
+		uint64_t range_pte_flags;
+		unsigned int flags;
+		bool skip_map;
+
+		vma_start = drm_gpusvm_find_vma_start(&svm->gpusvm, addr, end);
+		if (vma_start > addr)
+			return -EFAULT;
+
+		map_ctx = *gpusvm_ctx;
+retry:
+		range = drm_gpusvm_range_find_or_insert(&svm->gpusvm, addr,
+							vma_start, end,
+							&map_ctx);
+		if (IS_ERR(range)) {
+			ret = PTR_ERR(range);
+			/*
+			 * drm gpu svm deny RO when VMA is writeable
+			 * but some UMD test does not set RO in readonly MM VMA
+			 * so set read only when ret == -EPERM and retry
+			 */
+			if (ret == -EPERM && !map_ctx.read_only) {
+				map_ctx.read_only = true;
+				goto retry;
+			}
+			return ret;
+		}
+
+		next_addr = drm_gpusvm_range_end(range);
+		if (next_addr <= addr)
+			return -EINVAL;
+
+		range_pte_flags = map_ctx.read_only ?
+			(pte_flags & ~AMDGPU_PTE_WRITEABLE) : pte_flags;
+
+		skip_map = range_attr_match(range, attrs, range_pte_flags);
+
+		AMDGPU_SVM_TRACE("range_map: [0x%lx-0x%lx] skip=%d pte=0x%llx\n",
+				 addr, next_addr, skip_map ? 1 : 0, range_pte_flags);
+
+		if (!skip_map) {
+			ret = drm_gpusvm_range_get_pages(&svm->gpusvm, range, &map_ctx);
+			if (ret)
+				return ret;
+		}
+
+		ret = amdgpu_svm_range_lock_vm_pd(svm, &exec);
+		if (ret)
+			return ret;
+
+		flags = memalloc_noreclaim_save();
+		drm_gpusvm_notifier_lock(&svm->gpusvm);
+		if (skip_map) {
+			/* slow path must validate under notifier lock */
+			if (!range_attr_match(range, attrs, range_pte_flags) ||
+			    !range_pages_valid(svm, range)) {
+				range_invalidate_gpu_mapping(range);
+				ret = -EAGAIN;
+			} else {
+				ret = 0;
+			}
+		} else if (!range_pages_valid(svm, range)) {
+			/* not protected by mmap lock, maybe changed by mmu notifier */
+			ret = -EAGAIN;
+		} else {
+			ret = amdgpu_svm_range_update_gpu_range(svm, range,
+								range_pte_flags,
+								true, true, &fence);
+		}
+		drm_gpusvm_notifier_unlock(&svm->gpusvm);
+		memalloc_noreclaim_restore(flags);
+
+		if (!ret && fence)
+			dma_fence_wait(fence, false);
+
+		dma_fence_put(fence);
+
+		if (!ret)
+			ret = amdgpu_vm_update_pdes(svm->adev, svm->vm, false);
+		if (!ret) {
+			svm->flush_tlb(svm);
+			WRITE_ONCE(to_amdgpu_svm_range(range)->pte_flags, range_pte_flags);
+			WRITE_ONCE(to_amdgpu_svm_range(range)->attr_flags, attrs->flags);
+			WRITE_ONCE(to_amdgpu_svm_range(range)->gpu_mapped, true);
+		}
+		drm_exec_fini(&exec);
+
+		if (ret)
+			return ret;
+
+		addr = next_addr;
+	}
+
+	return 0;
+}
+
+static int
+amdgpu_svm_range_map_interval(struct amdgpu_svm *svm, unsigned long start_page,
+				unsigned long last_page,
+				const struct amdgpu_svm_attrs *attrs)
+{
+	struct drm_gpusvm_ctx gpusvm_ctx = {
+		.read_only = !!(attrs->flags & AMDGPU_SVM_FLAG_GPU_RO),
+	};
+	unsigned long start = start_page << PAGE_SHIFT;
+	unsigned long end = (last_page + 1) << PAGE_SHIFT;
+	uint64_t pte_flags;
+	int ret;
+
+	pte_flags = amdgpu_svm_range_attr_pte_flags(svm, attrs);
+
+	ret = amdgpu_svm_range_map(svm, start, end, attrs, &gpusvm_ctx,
+				   pte_flags);
+	if (ret)
+		AMDGPU_SVM_TRACE("map_interval failed: ret=%d [0x%lx-0x%lx)-0x%lx\n",
+				 ret, start, end, end - start);
+
+	return ret;
+}
+
+int
+amdgpu_svm_range_map_attr_ranges(struct amdgpu_svm *svm,
+				 unsigned long start_page,
+				 unsigned long last_page)
+{
+	lockdep_assert_held_write(&svm->svm_lock);
+
+	struct amdgpu_svm_attr_tree *attr_tree = svm->attr_tree;
+	unsigned long cursor = start_page;
+
+	while (cursor <= last_page) {
+		struct amdgpu_svm_attrs attrs;
+		unsigned long seg_last;
+		unsigned long next;
+		int ret;
+
+		mutex_lock(&attr_tree->lock);
+		amdgpu_svm_attr_lookup_page_locked(attr_tree, cursor, &attrs,
+						   &seg_last);
+		mutex_unlock(&attr_tree->lock);
+
+		seg_last = min(seg_last, last_page);
+		if (range_has_access(attrs.access)) {
+			/* map may fail here cause no vma or access deny */
+			ret = amdgpu_svm_range_map_interval(svm, cursor, seg_last,
+							    &attrs);
+			if (ret)
+				return ret;
+		}
+
+		if (seg_last == ULONG_MAX || seg_last == last_page)
+			break;
+
+		next = seg_last + 1;
+		if (next <= cursor)
+			break;
+		cursor = next;
+	}
+
+	return 0;
+}
+
+int amdgpu_svm_range_apply_attr_change(struct amdgpu_svm *svm,
+				       unsigned long start,
+				       unsigned long last,
+				       uint32_t trigger,
+				       const struct amdgpu_svm_attrs *prev_attrs,
+				       const struct amdgpu_svm_attrs *new_attrs)
+{
+	lockdep_assert_held_write(&svm->svm_lock);
+
+	bool old_access, new_access;
+	bool update_mapping = false;
+
+	old_access = range_has_access(prev_attrs->access);
+	new_access = range_has_access(new_attrs->access);
+
+	AMDGPU_SVM_TRACE("attr change trigger=0x%x old_access=%d new_access=%d [0x%lx-0x%lx]-0x%lx, xnack=%d\n",
+			 trigger, old_access, new_access, start, last, last - start + 1,
+			 svm->xnack_enabled ? 1 : 0);
+
+	if (trigger & AMDGPU_SVM_ATTR_TRIGGER_ACCESS_CHANGE) {
+		if (!new_access && old_access) {
+			/*
+			 * Do nothing align with kfd svm
+			 * TODO: unmap ranges from GPU that lost access
+			 */
+			AMDGPU_SVM_TRACE("skip unmap ioctl operation [0x%lx-0x%lx]-0x%lx\n",
+					 start, last, last - start + 1);
+		} else if (new_access) {
+			if (NEED_REBUILD(svm) ||
+			    (new_attrs->flags & AMDGPU_SVM_FLAG_GPU_ALWAYS_MAPPED))
+				update_mapping = true;
+		}
+	}
+
+	if ((trigger & (AMDGPU_SVM_ATTR_TRIGGER_PTE_FLAG_CHANGE |
+			AMDGPU_SVM_ATTR_TRIGGER_MAPPING_FLAG_CHANGE)) &&
+	    new_access)
+		update_mapping = true;
+
+	if (trigger & AMDGPU_SVM_ATTR_TRIGGER_LOCATION_CHANGE) {
+		/* TODO: add migration */
+	}
+
+	if (!update_mapping)
+		return 0;
+
+	AMDGPU_SVM_TRACE("mapping update: remap interval [0x%lx-0x%lx]-0x%lx\n",
+			 start, last, last - start + 1);
+	return amdgpu_svm_range_map_interval(svm, start, last, new_attrs);
+}
-- 
2.34.1

