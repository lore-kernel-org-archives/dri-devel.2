Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E63FF588C4
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 13:14:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C58CE10E5D4;
	Mon, 20 Apr 2026 13:14:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0ld3gO3d";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011066.outbound.protection.outlook.com [40.107.208.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00E1010E5D5;
 Mon, 20 Apr 2026 13:14:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KSUxnEiLYPrEfnaBcrNsHa3rKJrR+X0qKWzbPh4toDzluLzEJItF8Yf2ZAfaVAvUNw4RXsuCZQ6AMij67d24K+5VVhkh2/iq34u5vLnTEr263SdSYb7dKGeB+FNbFx+LeO/2GYxobDf1AErHgrthfTkRTqWj7g40FGUIz7NqfTpD+lJYR1bTfu6nSXh3IEp/HuhKFsaF1I2EHZueFRd5cSlzXveg/MrREnskTGPbhy0cbQb+agTO+BfY5bfmHnXea5EDcAdMdz1oKRb+5kIIRMZgbDNbCH//I4auUrk4cWiWJpMGdF15Dc597i1Fo37RSYpZUnWUBPNQikTJvF8Elg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XR0ZJPuBT/U6jP8MZAqrgyjB2+JrwzenYK/XYcf9ld0=;
 b=niBhkts7+E/G251/309n+KklQ7y01Bl46RawX1JssdJl0v3c+C1bxRMrxvAGBOxSSd8iryO/GznStkVp4qnjkgjVvRizx42enPOJgsNBKKGQdZCo6EoQEn3tzww01ecsNzfRJMYddJZYEVvuKmPOdAQe3k/7p/M4B3oocuG8vsvEAtX1mWrTCEvINUBNv28r5w0FePeGpmXFeyJkdBFZAHLBWrB4jTZSXQwsuOWhBt7xMoefcJC51gczk0e3M7cK04l7qmAKxuotGdFo5ZX2HsF5r1B9OHaI/Mj9iU50xGiMRUfl78/R6Eoe+iRtJs/hAytrfzrUnPmMt/3TVgvolQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XR0ZJPuBT/U6jP8MZAqrgyjB2+JrwzenYK/XYcf9ld0=;
 b=0ld3gO3d0saSZ14jk+w4slZfPwPJ2hOnTOIy83XZvR5AtQwCFLcjGy824scdBNWShHdHUQUPYzfh//Ku1G7MOlcZpcLtFZ+Wdf51xFSqtWUTaOdA6vzVmwbR89PJsSPL6nZaWsy5DveaQnoALz7P6Oolz+CCvNeceyu/Z2u2sQ0=
Received: from CH0PR03CA0318.namprd03.prod.outlook.com (2603:10b6:610:118::26)
 by DS7PR12MB8250.namprd12.prod.outlook.com (2603:10b6:8:db::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Mon, 20 Apr
 2026 13:13:53 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:118:cafe::35) by CH0PR03CA0318.outlook.office365.com
 (2603:10b6:610:118::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Mon,
 20 Apr 2026 13:13:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Mon, 20 Apr 2026 13:13:53 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Apr
 2026 08:13:48 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <matthew.brost@intel.com>,
 <rodrigo.vivi@intel.com>, <thomas.hellstrom@linux.intel.com>,
 <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>, Honghuan He <honghuan.he@amd.com>
Subject: [RFC V3 04/12] drm/amdgpu: implement SVM attribute tree and helper
 functions
Date: Mon, 20 Apr 2026 21:12:59 +0800
Message-ID: <20260420131307.1816671-5-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260420131307.1816671-1-honglei1.huang@amd.com>
References: <20260420131307.1816671-1-honglei1.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|DS7PR12MB8250:EE_
X-MS-Office365-Filtering-Correlation-Id: f945c160-4f9c-4582-9883-08de9edeaba3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|921020|18096099003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: TgNlS1UjzGz9eeeyqkDCs6RR/Nj4MhC5uTHeoxwPVJPtr+ESuDxEo9n6sG5ZyzYGSscP9priX6utb/8Q0MgHLHqVwasNK+9OG+UlbYcv6apoJITkVlOPQy/O7+tIrzzZcmX+/7VWxP2hF1i28cWg7kPpGH2vSZ+Weg0rXQHNvjigx0DzCQia4pKD04BzD8hqOMzJ73U/mafKuSpsHeIVvLSMb0LGMirtlrSYVPHLQQzHVmPSm69RAGy1/2jjkx3DNoxCpMLvHcvNJBo8BnvAy4+2UOdBMDTlUbattaG3tYQl678tr3oE7gE/MqRN/3oJXdr50zk7/yyZPt5n8ONopNrBcTjw56ry1mKVExWzFZ3DzrpGtaLzIIEwdxFAwLyg8c+4gaaG2n5VTQqYIWXm7uba48gcxumIHIxeYGspZPfX48R9K4prEmnajbhuwwICW5gUz4iS743Dmj1S0vOKzMxFO3aGpua4xJ2rCrBXTawBqnW6jkmPQt7+6qjf08LsqYhz5hTYsLG8UTSaiKYpln+0dmM33ZSwZw+OmR8oTRYsJwtJ8F9JqTAZYQ8n25fvKiRfiaqOcH99i3/rYHk+F137F7gWdRqQLMqsnAORppPgo33bKIk38IpSGfUt7lPbUc41XU83mh5KT9x5w2exyK3JKvj+rQ3Myj/m/vx4ZqmBuY5WTBpdgGPT2zCgFCgnjc5lmak9CCrUigcy1/PjxMf88Np9s6vheptQXr/6w6zZQxMzS14z1OwAuXlOIxpHwkVHIpvM5uDV3sbqCNbvVK/CwChNpGGG6OdqQrAl2dlUHNAoqb8C2WgLwsHV/F7r
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(921020)(18096099003)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: W7sGXDO0Piu3g7lNpKJWqhoZqAz4bR/83wD/+Rk57HZkQ82HPIy9MW2uKrUvw8jMx+wj3KVAeOyOuLNEjxIQmz29avULGjcB9iIZCBhfP8iHTixxPMtmyqcOt7oJQTkzt+FljwAWlsocHRR/vI9kexIlYVLIwSQkzAX+CWo6DK5R4tHYd6GVZtZujJfqioD2yr27/2LJ8idYSQ3Oj9Bhr3khItgld+/wRL5j7d/oJixsR+NwL2mVOAEmDyfZ2bV/9Gr6dnwViycrDD69VR+YhtwRrmgNYZ4cI5XTa3wiYuPCYk6zDK/JukuQoJtL1GmOlur4TcnQ6qfgMy/LBqHJ9w6IhcAp+Uk6lDXzmBWyovWYbTKTK/iVkZ+rNyIy+gWulrj6832qR4GEfHdg9sA/WoFVjhFArMpAwtntLCYI/fWzOvDD5QVEa6hQ/Hrn5HpC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 13:13:53.2214 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f945c160-4f9c-4582-9883-08de9edeaba3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8250
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

Implement the foundational attribute tree operations in
amdgpu_svm_attr.c providing slab cache management, helper
functions, change detection, and interval tree CRUD.

Slab cache:
- amdgpu_svm_attr_cache_init/fini(): create and destroy the
  kmem_cache for amdgpu_svm_attr_range allocation

Context structures:
- struct attr_set_ctx / struct attr_get_ctx: internal state
  for tree walk operations during attribute set and get

Helpers:
- amdgpu_svm_attr_devmem_possible(): check DEVICE_PRIVATE config
  and drm_gpusvm device memory support
- amdgpu_svm_attr_prefer_vram(): detect VRAM preference from
  preferred_loc != SYSMEM and != UNDEFINED
- amdgpu_svm_check_vma(): validate VMA existence via find_vma()
- amdgpu_svm_attr_set_default(): initialize default attributes
  (SYSMEM preferred, all-access enabled, coherent flags)
- attr_equal(): compare two amdgpu_svm_attrs for equality
- attr_change_ctx_trigger(): compute a bitmask of what changed
  between old and new attributes (access, PTE flags, mapping
  flags, location, granularity)
- attr_has_access(): check if attribute access mode allows
  GPU mapping

Interval tree operations:
- attr_set_interval(): set start_page/last_page on a range node
- amdgpu_svm_attr_find_locked(): find range containing a page
- amdgpu_svm_attr_get_bounds_locked(): find effective bounds
  for a page based on adjacent ranges with matching attributes
- amdgpu_svm_attr_range_alloc(): allocate from kmem_cache
- amdgpu_svm_attr_range_insert_locked(): insert into interval
  tree and linked list
- attr_remove_range_locked(): remove and free from the tree

Signed-off-by: Honghuan He <honghuan.he@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c | 301 +++++++++++++++++++
 1 file changed, 301 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
new file mode 100644
index 000000000..03ea2f005
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
@@ -0,0 +1,301 @@
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
+
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/gfp.h>
+#include <linux/lockdep.h>
+#include <linux/minmax.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+
+#define AMDGPU_SVM_VALID_FLAG_MASK \
+	(AMDGPU_SVM_FLAG_HOST_ACCESS | AMDGPU_SVM_FLAG_COHERENT | \
+	 AMDGPU_SVM_FLAG_HIVE_LOCAL | AMDGPU_SVM_FLAG_GPU_RO | \
+	 AMDGPU_SVM_FLAG_GPU_EXEC | AMDGPU_SVM_FLAG_GPU_READ_MOSTLY | \
+	 AMDGPU_SVM_FLAG_GPU_ALWAYS_MAPPED | AMDGPU_SVM_FLAG_EXT_COHERENT)
+
+
+static struct kmem_cache *amdgpu_svm_attr_range_cache;
+
+struct attr_set_ctx {
+	uint32_t trigger;
+	struct amdgpu_svm_attrs prev_attrs;
+	struct amdgpu_svm_attr_range *attr_range;
+};
+
+struct attr_get_ctx {
+	int32_t preferred_loc;
+	int32_t prefetch_loc;
+	enum amdgpu_svm_attr_access access;
+	uint32_t granularity;
+	uint32_t flags_and;
+	uint32_t flags_or;
+	bool has_range;
+};
+
+bool amdgpu_svm_attr_devmem_possible(struct amdgpu_svm *svm,
+				     const struct amdgpu_svm_attrs *attrs)
+{
+	if (svm->adev->apu_prefer_gtt)
+		return false;
+
+	if (attrs->preferred_loc == AMDGPU_SVM_LOCATION_SYSMEM)
+		return false;
+
+	return true;
+}
+
+bool amdgpu_svm_attr_prefer_vram(struct amdgpu_svm *svm,
+				 const struct amdgpu_svm_attrs *attrs)
+{
+	if (!amdgpu_svm_attr_devmem_possible(svm, attrs))
+		return false;
+
+	if (attrs->preferred_loc != AMDGPU_SVM_LOCATION_UNDEFINED && 
+	    attrs->preferred_loc != AMDGPU_SVM_LOCATION_SYSMEM)
+		return true;
+
+	if (attrs->prefetch_loc != AMDGPU_SVM_LOCATION_UNDEFINED && 
+	    attrs->prefetch_loc != AMDGPU_SVM_LOCATION_SYSMEM)
+		return true;
+
+	return false;
+}
+
+struct vm_area_struct *amdgpu_svm_check_vma(struct mm_struct *mm,
+					unsigned long addr)
+{
+	struct vm_area_struct *vma = vma_lookup(mm, addr);
+
+	if (!vma)
+		return ERR_PTR(-EFAULT);
+
+	if (vma->vm_flags & (VM_IO | VM_PFNMAP | VM_MIXEDMAP))
+		return ERR_PTR(-EOPNOTSUPP);
+
+	return vma;
+}
+
+int amdgpu_svm_attr_cache_init(void)
+{
+	amdgpu_svm_attr_range_cache = AMDGPU_SVM_KMEM_CACHE_CREATE(
+				"amdgpu_svm_attr_range_cache", struct amdgpu_svm_attr_range);
+	if (!amdgpu_svm_attr_range_cache)
+		return -ENOMEM;
+
+	return 0;
+}
+
+void amdgpu_svm_attr_cache_fini(void)
+{
+	AMDGPU_SVM_KMEM_CACHE_DESTROY(amdgpu_svm_attr_range_cache);
+}
+
+static void attr_set_interval(struct amdgpu_svm_attr_range *range,
+				unsigned long start_page,
+				unsigned long last_page)
+{
+	range->it_node.start = start_page;
+	range->it_node.last = last_page;
+}
+
+void amdgpu_svm_attr_set_default(struct amdgpu_svm *svm,
+				 struct amdgpu_svm_attrs *attrs)
+{
+	attrs->preferred_loc = AMDGPU_SVM_LOCATION_UNDEFINED;
+	attrs->prefetch_loc = AMDGPU_SVM_LOCATION_UNDEFINED;
+	attrs->granularity = svm->default_granularity;
+	attrs->flags = AMDGPU_SVM_FLAG_HOST_ACCESS | AMDGPU_SVM_FLAG_COHERENT;
+	attrs->access = svm->xnack_enabled ?
+		AMDGPU_SVM_ACCESS_ENABLE : AMDGPU_SVM_ACCESS_NONE;
+}
+
+struct amdgpu_svm_attr_range *
+amdgpu_svm_attr_find_locked(struct amdgpu_svm_attr_tree *attr_tree,
+			   unsigned long page)
+{
+	struct interval_tree_node *node;
+
+	node = interval_tree_iter_first(&attr_tree->tree, page, page);
+	if (node)
+		return container_of(node, struct amdgpu_svm_attr_range, it_node);
+
+	return NULL;
+}
+
+struct amdgpu_svm_attr_range *
+amdgpu_svm_attr_get_bounds_locked(struct amdgpu_svm_attr_tree *attr_tree,
+				  unsigned long page,
+				  unsigned long *start_page,
+				  unsigned long *last_page)
+{
+	struct amdgpu_svm_attr_range *attr_range;
+	struct interval_tree_node *node;
+	struct rb_node *rb;
+
+	attr_range = amdgpu_svm_attr_find_locked(attr_tree, page);
+	if (attr_range) {
+		*start_page = amdgpu_svm_attr_start_page(attr_range);
+		*last_page = amdgpu_svm_attr_last_page(attr_range);
+		return attr_range;
+	}
+
+	*start_page = 0;
+	*last_page = ULONG_MAX;
+
+	if (page == ULONG_MAX)
+		return NULL;
+
+	node = interval_tree_iter_first(&attr_tree->tree, page + 1, ULONG_MAX);
+	if (node) {
+		if (node->start > page)
+			*last_page = node->start - 1;
+
+		rb = rb_prev(&node->rb);
+		if (rb) {
+			node = container_of(rb, struct interval_tree_node, rb);
+			if (node->last < page)
+				*start_page = node->last + 1;
+		}
+	} else {
+		rb = rb_last(&attr_tree->tree.rb_root);
+
+		if (rb) {
+			node = container_of(rb, struct interval_tree_node, rb);
+			if (node->last < page)
+				*start_page = node->last + 1;
+		}
+	}
+
+	return NULL;
+}
+
+static bool attr_equal(const struct amdgpu_svm_attrs *a,
+				 const struct amdgpu_svm_attrs *b)
+{
+	return a->flags == b->flags &&
+	       a->preferred_loc == b->preferred_loc &&
+	       a->prefetch_loc == b->prefetch_loc &&
+		       a->granularity == b->granularity &&
+		       a->access == b->access;
+}
+
+static uint32_t
+attr_change_ctx_trigger(const struct amdgpu_svm_attrs *prev_attrs,
+		      const struct amdgpu_svm_attrs *new_attrs)
+{
+	uint32_t trigger = 0;
+	uint32_t changed_flags = prev_attrs->flags ^ new_attrs->flags;
+
+	if (prev_attrs->access != new_attrs->access)
+		trigger |= AMDGPU_SVM_ATTR_TRIGGER_ACCESS_CHANGE;
+	if (changed_flags & AMDGPU_SVM_PTE_FLAG_MASK)
+		trigger |= AMDGPU_SVM_ATTR_TRIGGER_PTE_FLAG_CHANGE;
+	if (changed_flags & AMDGPU_SVM_MAPPING_FLAG_MASK)
+		trigger |= AMDGPU_SVM_ATTR_TRIGGER_MAPPING_FLAG_CHANGE;
+	if (prev_attrs->preferred_loc != new_attrs->preferred_loc)
+		trigger |= AMDGPU_SVM_ATTR_TRIGGER_LOCATION_CHANGE;
+	if (prev_attrs->granularity != new_attrs->granularity)
+		trigger |= AMDGPU_SVM_ATTR_TRIGGER_GRANULARITY_CHANGE;
+	if (new_attrs->prefetch_loc != AMDGPU_SVM_LOCATION_UNDEFINED && 
+		new_attrs->prefetch_loc != AMDGPU_SVM_LOCATION_SYSMEM)
+		trigger |= AMDGPU_SVM_ATTR_TRIGGER_PREFETCH;
+
+	if (!trigger)
+		trigger = AMDGPU_SVM_ATTR_TRIGGER_ATTR_ONLY;
+
+	return trigger;
+}
+
+static bool attr_has_access(uint32_t nattr,
+					  const struct drm_amdgpu_svm_attribute *attrs)
+{
+	uint32_t i;
+
+	for (i = 0; i < nattr; i++) {
+		switch (attrs[i].type) {
+		case AMDGPU_SVM_ATTR_ACCESS:
+		case AMDGPU_SVM_ATTR_ACCESS_IN_PLACE:
+			return true;
+		}
+	}
+
+	return false;
+}
+
+struct amdgpu_svm_attr_range *
+amdgpu_svm_attr_range_alloc(unsigned long start_page,
+			   unsigned long last_page,
+			   const struct amdgpu_svm_attrs *attrs)
+{
+	struct amdgpu_svm_attr_range *range;
+
+	range = kmem_cache_zalloc(amdgpu_svm_attr_range_cache, GFP_KERNEL);
+	if (!range)
+		return NULL;
+
+	INIT_LIST_HEAD(&range->list);
+	attr_set_interval(range, start_page, last_page);
+	range->attrs = *attrs;
+	return range;
+}
+
+void amdgpu_svm_attr_range_insert_locked(struct amdgpu_svm_attr_tree *attr_tree,
+					 struct amdgpu_svm_attr_range *range)
+{
+	struct interval_tree_node *node;
+	struct amdgpu_svm_attr_range *next;
+
+	lockdep_assert_held(&attr_tree->lock);
+
+	node = interval_tree_iter_first(&attr_tree->tree, amdgpu_svm_attr_start_page(range),
+					ULONG_MAX);
+	if (node) {
+		next = container_of(node, struct amdgpu_svm_attr_range, it_node);
+		list_add_tail(&range->list, &next->list);
+	} else {
+		list_add_tail(&range->list, &attr_tree->range_list);
+	}
+
+	interval_tree_insert(&range->it_node, &attr_tree->tree);
+}
+
+static void attr_remove_range_locked(struct amdgpu_svm_attr_tree *attr_tree,
+					  struct amdgpu_svm_attr_range *range,
+					  bool free_range)
+{
+	lockdep_assert_held(&attr_tree->lock);
+
+	interval_tree_remove(&range->it_node, &attr_tree->tree);
+	list_del_init(&range->list);
+	if (free_range)
+		kmem_cache_free(amdgpu_svm_attr_range_cache, range);
+}
+
-- 
2.34.1

