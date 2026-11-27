Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43042606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=5GUvnpDV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A60EF11285A;
	Fri, 27 Nov 2026 08:42:29 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010032.outbound.protection.outlook.com
 [52.101.193.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEC1311285A;
 Fri, 27 Nov 2026 08:42:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C/ismSBTmF7ekaBl/tPxR3d1rrJEanXxgCEiTnQI+I9vJ0dhm1ULVQFJQKqDbpalf4uUIACayf0oqKqK801lx/mCm6yJrd3/iHf8hqXvnwj5A5sR+rpe6jsn6ndNwGTiu42K7Mo766k+B6/LkQB73NMOZgOIpgnvD/2ItI19a35g+uqHRHkEQjEhGb+gQTh4VlMAd1U+283qs+4UY9sD40WuufDwBkkbTbAkR7QpA4+30VvGrLubR2F4EiNPD5DnMHDbiCzAbv6BnedQBXZ7aNESiFKMrGPLcQ8MlxEXfP38gyJefTya6jMFK2vwdpkkCWK9KKLxPt5Yzjdn5ESh+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KDrSKV66yh6VEqo72i/82MbC+ABlavhANbMppIAn2kM=;
 b=q+f8PH6xF+tntDgRux4HY8Q1zI22A0b4l0q43Vkj57iFi33+7DeuFycT43QOYz0NAv4h2tjAKDZNRsfAqJ/hsDrbtX7bbNm01zJIbtHJoBOzT2H0lulUJYd8Y3rH8IZdZq7lxevstN7/uNVmZXngj8yv6QrMZ2DoUyFc4EXqzTv2qqi/6jg+8qsK4wVK3KWAIkbxn0mT+A2v7Ra5y6KXpc8yGt/aSa8TnlYP4QqOwVy6d8nf54PFFIAep2apBIk1V6H1JqfV/epKnuXNtmR5plWm2Yd549vVoxD8eJjYFdgpJYo3ZAuFzXC46fGu9QigkiXZXS4mboUiZwX8w60aGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KDrSKV66yh6VEqo72i/82MbC+ABlavhANbMppIAn2kM=;
 b=5GUvnpDVDdu/ac8fO8TXnplF41kMg9eFaflRjVHH+q1yFG+RkDILhBxK1OAZ4tqmF9f0cBs2JpacFG7CMxUNGWm9UtaeSLRby2ma/opppvjNlBwOkA0Q4HqC0ZXdh6bQ7mqDxGcm5npmo2xiW06EH3MUJrJcw7a7d97/yzC3xwA=
Received: from CH2PR04CA0027.namprd04.prod.outlook.com (2603:10b6:610:52::37)
 by DS0PR12MB7945.namprd12.prod.outlook.com (2603:10b6:8:153::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 08:42:11 +0000
Received: from CH2PEPF000166C0.namprd04.prod.outlook.com
 (2603:10b6:610:52:cafe::2) by CH2PR04CA0027.outlook.office365.com
 (2603:10b6:610:52::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.11 via Frontend Transport; Fri,
 27 Nov 2026 08:42:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF000166C0.mail.protection.outlook.com (10.167.252.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 08:42:10 +0000
Received: from hr-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 02:42:05 -0600
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
Subject: [PATCH v11 04/22] drm/amdgpu: implement SVM attribute tree and helper
 functions
Date: Fri, 27 Nov 2026 16:41:27 +0800
Message-ID: <20261127084149.925625-5-ray.huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF000166C0:EE_|DS0PR12MB7945:EE_
X-MS-Office365-Filtering-Correlation-Id: 62643e61-5505-4c38-2ae3-08df4c6253f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|11063799006|6133799003|261009223027099003|18002099003|22082099003|3023799007|921020|10067099003|56012099006|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261021121427099003|261021123027099003|261022115727099003|261022113327099003|261022105027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: 84BhTuA8tOEKn6A/0x2/FnxhdPHrGUrEkx2pGPkLW4p1JvEzjVuSUAGt/ei2kzCTPRDurLvHVY1gdPch6n5GHahAK7YLOIdLwA/hvgwf4jAGvenXYDTkZLkQE5vnNtMViylea3E6+wkYCwuI8+H7PQZg2tv0bEt0YuwKpuIhmbMwuiuTnQGewmyvpBkjRML4xm/dGdL9t5PIbbRRB4m2iJ4Cj9ExePRM7LqQoT7T7ZyNO4MxriB8wXnrBb5XToGPq+HMrDL/60H+Seh6LkP/m60yOn+ELklSPvhFS54vm1W1luHeU8u+6/jNTDvL6S4XzZ1DImsafB2vgiPwNKVG0iJ3Fq0oUxm6fjO3TZLcjCXCddkNIzS//ZOqJ2IQ4BOdZ5eL//4xz+/E5hTWbN3RjldNkDD6OJZfZfeqvHyHJ7/r5SW9S814EDSSAnC+6lpl/LpLOjgKedoYDLOYvGoGhA2j6zApgWr0KE0Cd0h4CXVUDYuYyWfpXjtI9KRlk6wO2YZIT1IRr1LSJ7uuL9z5zmV5CHFEAtMjScVVeUZsoS1Xqur9Z8AGJxXXxqHbojqud7xd76wn6evq7z+/hOJSxPxbIUrEf0sJXiKk6pknZCN04wiE60ClaeCreZQoKZYDHBD2YMmbxpcWUIRyifC0GrZpMW08Gw2R1UCkz4cpZAsUhUMG2W4ONovhl5e1bqqB8cOu9JlttvVfal0L9pjOx5kRHSkQRZKMvmk7XAiNRY1dUTBB6pgPAsr+bBD0/rL9
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(11063799006)(6133799003)(261009223027099003)(18002099003)(22082099003)(3023799007)(921020)(10067099003)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021121427099003)(261021123027099003)(261022115727099003)(261022113327099003)(261022105027099003)(261022075727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8vA4fEWpG54fpkvDBERtXCWALzOyVnd3kt6rrKy4DUwi9sDrUK7+Pmmf4TyArao7GtpAwKJ0v9s8ErRu0avqEslMkTdyllL7nUwM3SK1dQRCJhdZhnbgJJqkoz2ubm0tkDckHtb3GNDPUExrL5bRRhjP7WmijRNtyJRWRfKueDza8TXaxVWa3xZhVxO61G9/P2LbOLPzOGjgppsfQp2PEOEp37EXX1Mo0xDbeOwocY0+fCJ09qq7rFeUUFq4FlYpA2v/XKxF+VhYb9uwSOyU+3Yx1F2L2HujrUeTDl8PB90s1L+jEELIiW2Yz4V3AWM2fgH/qPFAqXzWNNygYd3NyUA4OinPxf1cIMVYcvUvI2ZZeT/b3Op/jCwq10/tGVlkhvFRZHD9ufGZPfRZe/qcRto36nnGUDAty5Sg6w/ULNa3ayfEl/fA76Ygd3mx5Igl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 08:42:10.8575 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62643e61-5505-4c38-2ae3-08df4c6253f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000166C0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7945
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Honglei Huang <honghuan@amd.com>

Implement the per-SVM interval tree that stores attributes independently
of CPU VMA lifetime. Provide default attributes, interval lookup and
update helpers, and the attribute types shared with mapping and fault
handling. Runtime VMA lookup validates the backing memory when needed.

Recognize explicit SYSMEM prefetch separately from a preferred location.
Only ALLOW_MIGRATE permits active eviction to system memory; IN_PLACE
retains its existing access policy.

Suggested-by: Christian König <christian.koenig@amd.com>
Suggested-by: Huang Rui <ray.huang@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c | 262 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h | 172 ++++++++++++
 2 files changed, 434 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
new file mode 100644
index 0000000000000..5b083aad24c01
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
@@ -0,0 +1,262 @@
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
+
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/gfp.h>
+#include <linux/lockdep.h>
+#include <linux/minmax.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+
+struct attr_set_ctx {
+	struct amdgpu_svm_attrs old_attrs;
+	struct amdgpu_svm_attrs new_attrs;
+	unsigned long start_page;
+	unsigned long last_page;
+};
+
+struct attr_get_ctx {
+	s32 preferred_loc;
+	s32 prefetch_loc;
+	enum amdgpu_ioctl_svm_access access;
+	u32 granularity;
+	u32 flags_and;
+	bool has_range;
+};
+
+/**
+ * amdgpu_svm_attr_prefer_vram() - Check a stable attribute snapshot for VRAM
+ * @attrs: Attribute snapshot supplied by the caller.
+ *
+ * Return: True if either location requests device memory.
+ */
+bool amdgpu_svm_attr_prefer_vram(const struct amdgpu_svm_attrs *attrs)
+{
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
+/**
+ * amdgpu_svm_check_vma() - Look up supported CPU backing for a fault
+ * @mm: Address space to inspect.
+ * @addr: Faulting byte address.
+ *
+ * Context: Caller holds mmap_lock; the returned VMA requires that lock.
+ * Return: The VMA, or an error pointer for missing or unsupported backing.
+ */
+struct vm_area_struct *amdgpu_svm_check_vma(struct mm_struct *mm, unsigned long addr)
+{
+	const unsigned long unsupported_vm_flags = VM_IO | VM_PFNMAP | VM_MIXEDMAP;
+	struct vm_area_struct *vma = vma_lookup(mm, addr);
+
+	if (!vma)
+		return ERR_PTR(-EFAULT);
+
+	if (vma->vm_flags & unsupported_vm_flags)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	return vma;
+}
+
+static void attr_set_interval(struct amdgpu_svm_attr_range *range, unsigned long start_page,
+			      unsigned long last_page)
+{
+	range->it_node.start = start_page;
+	range->it_node.last = last_page;
+}
+
+/**
+ * amdgpu_svm_attr_set_default() - Fill the default attributes
+ * @svm: Initialized SVM context with immutable default policy.
+ * @attrs: Caller-owned output snapshot.
+ */
+void amdgpu_svm_attr_set_default(struct amdgpu_svm *svm, struct amdgpu_svm_attrs *attrs)
+{
+	attrs->preferred_loc = AMDGPU_SVM_LOCATION_UNDEFINED;
+	attrs->prefetch_loc = AMDGPU_SVM_LOCATION_UNDEFINED;
+	attrs->granularity = svm->default_granularity;
+	attrs->flags = AMDGPU_SVM_ATTR_BIT_HOST_ACCESS | AMDGPU_SVM_ATTR_BIT_COHERENT;
+	attrs->access = svm->xnack_enabled ? AMDGPU_SVM_ACCESS_ALLOW_MIGRATE :
+					     AMDGPU_SVM_ACCESS_INACCESSIBLE;
+}
+
+static struct amdgpu_svm_attr_range *
+amdgpu_svm_attr_find_locked(struct amdgpu_svm_attr_tree *attr_tree, unsigned long page)
+{
+	struct interval_tree_node *node;
+
+	lockdep_assert_held(&attr_tree->lock);
+
+	node = interval_tree_iter_first(&attr_tree->tree, page, page);
+	if (node)
+		return container_of(node, struct amdgpu_svm_attr_range, it_node);
+
+	return NULL;
+}
+
+/**
+ * amdgpu_svm_attr_get_bounds_locked() - Find attributes  or surrounding bounds
+ * @attr_tree: attribute tree to search.
+ * @page: page index to look up.
+ * @start_page: out, first page of the returned range or gap.
+ * @last_page: out, last page of the returned range or gap.
+ *
+ * If @page is covered by an attribute range, return that range and report its
+ * bounds. Otherwise return NULL and fill @start_page/@last_page with the bounds
+ * of the default attribute gap around @page, clamped by neighboring explicit
+ * ranges or [0, ULONG_MAX] when none.
+ *
+ * Context: Caller holds attr_tree->lock; the returned range requires that lock.
+ * Return: the covering range, or NULL if @page falls in a gap.
+ */
+struct amdgpu_svm_attr_range *
+amdgpu_svm_attr_get_bounds_locked(struct amdgpu_svm_attr_tree *attr_tree, unsigned long page,
+				  unsigned long *start_page, unsigned long *last_page)
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
+static bool attr_equal(const struct amdgpu_svm_attrs *a, const struct amdgpu_svm_attrs *b)
+{
+	return a->flags == b->flags && a->preferred_loc == b->preferred_loc &&
+	       a->prefetch_loc == b->prefetch_loc && a->granularity == b->granularity &&
+	       a->access == b->access;
+}
+
+/**
+ * amdgpu_svm_attr_range_alloc() - Allocate an unlinked attribute range
+ * @start_page: First CPU page, inclusive.
+ * @last_page: Last CPU page, inclusive.
+ * @attrs: Stable attributes to copy into the allocation.
+ *
+ * The caller owns the range until insertion into the tree.
+ *
+ * Return: An allocated range, or NULL on allocation failure.
+ */
+struct amdgpu_svm_attr_range *
+amdgpu_svm_attr_range_alloc(unsigned long start_page, unsigned long last_page,
+			    const struct amdgpu_svm_attrs *attrs)
+{
+	struct amdgpu_svm_attr_range *range;
+
+	range = kzalloc_obj(*range, GFP_KERNEL);
+	if (!range)
+		return NULL;
+
+	INIT_LIST_HEAD(&range->list);
+	attr_set_interval(range, start_page, last_page);
+	range->attrs = *attrs;
+	return range;
+}
+
+/**
+ * amdgpu_svm_attr_range_insert_locked() - Transfer a range to the attribute tree
+ * @attr_tree: Destination tree.
+ * @range: Unlinked range that does not overlap existing entries.
+ *
+ * Context: Caller holds attr_tree->lock and serializes SVM attribute updates.
+ */
+void amdgpu_svm_attr_range_insert_locked(struct amdgpu_svm_attr_tree *attr_tree,
+					 struct amdgpu_svm_attr_range *range)
+{
+	struct interval_tree_node *node;
+	struct amdgpu_svm_attr_range *next;
+
+	lockdep_assert_held(&attr_tree->lock);
+
+	/*
+	 * Keep @range_list ordered by start page: insert before the first range
+	 * starting at or after @range, then add to the interval tree.
+	 */
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
+				     struct amdgpu_svm_attr_range *range, bool free_range)
+{
+	lockdep_assert_held(&attr_tree->lock);
+
+	interval_tree_remove(&range->it_node, &attr_tree->tree);
+	list_del_init(&range->list);
+	if (free_range)
+		kfree(range);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h
new file mode 100644
index 0000000000000..3880ffaf46ffb
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h
@@ -0,0 +1,172 @@
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
+#ifndef __AMDGPU_SVM_ATTR_H__
+#define __AMDGPU_SVM_ATTR_H__
+
+#include <drm/amdgpu_drm.h>
+#include <linux/bits.h>
+#include <linux/interval_tree.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/rbtree.h>
+#include <linux/types.h>
+
+/* Internal SVM attribute bitmask flags mapped from UAPI ioctl definitions */
+#define AMDGPU_SVM_ATTR_BIT_HOST_ACCESS BIT(0)
+#define AMDGPU_SVM_ATTR_BIT_COHERENT BIT(1)
+#define AMDGPU_SVM_ATTR_BIT_EXT_COHERENT BIT(2)
+#define AMDGPU_SVM_ATTR_BIT_GPU_RO BIT(3)
+#define AMDGPU_SVM_ATTR_BIT_GPU_EXEC BIT(4)
+#define AMDGPU_SVM_ATTR_BIT_GPU_READ_MOSTLY BIT(5)
+
+#define AMDGPU_SVM_PTE_FLAG_MASK                                           \
+	(AMDGPU_SVM_ATTR_BIT_COHERENT | AMDGPU_SVM_ATTR_BIT_EXT_COHERENT | \
+	 AMDGPU_SVM_ATTR_BIT_GPU_RO | AMDGPU_SVM_ATTR_BIT_GPU_EXEC)
+
+#define AMDGPU_SVM_MAPPING_FLAG_MASK \
+	(AMDGPU_SVM_ATTR_BIT_HOST_ACCESS | AMDGPU_SVM_ATTR_BIT_GPU_READ_MOSTLY)
+
+/**
+ * struct amdgpu_svm_attrs - SVM attributes for an address range
+ * @preferred_loc: Preferred backing location, using AMDGPU_SVM_LOCATION_*.
+ * @prefetch_loc: Target location for prefetch requests, using
+ *                AMDGPU_SVM_LOCATION_*.
+ * @flags: Internal AMDGPU_SVM_ATTR_BIT_* flags mapped from the UAPI.
+ * @granularity: Mapping granularity encoded as a page order.
+ * @access: CPU/GPU access policy from the SVM UAPI.
+ */
+struct amdgpu_svm_attrs {
+	s32 preferred_loc;
+	s32 prefetch_loc;
+	u32 flags;
+	u32 granularity;
+	enum amdgpu_ioctl_svm_access access;
+};
+
+/**
+ * struct amdgpu_svm_attr_range - a range of user attributes
+ * @it_node: interval tree node keyed by [start, last] page index.
+ * @list: links the range into amdgpu_svm_attr_tree.range_list in address order.
+ * @attrs: the attributes applied to this range.
+ */
+struct amdgpu_svm_attr_range {
+	struct interval_tree_node it_node;
+	struct list_head list;
+	struct amdgpu_svm_attrs attrs;
+};
+
+static inline unsigned long amdgpu_svm_attr_start_page(const struct amdgpu_svm_attr_range *range)
+{
+	return range->it_node.start;
+}
+
+static inline unsigned long amdgpu_svm_attr_last_page(const struct amdgpu_svm_attr_range *range)
+{
+	return range->it_node.last;
+}
+
+static inline unsigned long amdgpu_svm_attr_start(const struct amdgpu_svm_attr_range *range)
+{
+	return range->it_node.start << PAGE_SHIFT;
+}
+
+static inline unsigned long amdgpu_svm_attr_end(const struct amdgpu_svm_attr_range *range)
+{
+	return (range->it_node.last + 1) << PAGE_SHIFT;
+}
+
+struct amdgpu_svm;
+struct mm_struct;
+struct vm_area_struct;
+
+static inline bool amdgpu_svm_attr_has_access(enum amdgpu_ioctl_svm_access access)
+{
+	return access == AMDGPU_SVM_ACCESS_ALLOW_MIGRATE || access == AMDGPU_SVM_ACCESS_IN_PLACE;
+}
+
+static inline bool amdgpu_svm_attr_prefetch_sysmem(const struct amdgpu_svm_attrs *attrs)
+{
+	return attrs->access == AMDGPU_SVM_ACCESS_ALLOW_MIGRATE &&
+	       attrs->prefetch_loc == AMDGPU_SVM_LOCATION_SYSMEM;
+}
+
+/**
+ * struct amdgpu_svm_attr_tree - per-SVM store of user attribute ranges
+ * @lock: protects @tree and @range_list.
+ * @tree: interval tree of struct amdgpu_svm_attr_range for fast lookup.
+ * @range_list: address-ordered list of the same ranges, kept in sync with
+ *              @tree to allow ordered traversal during modification.
+ * @svm: back pointer to the owning SVM instance.
+ */
+struct amdgpu_svm_attr_tree {
+	struct mutex lock; /* Protects the attribute tree and range list. */
+	struct rb_root_cached tree;
+	struct list_head range_list;
+	struct amdgpu_svm *svm;
+};
+
+/**
+ * enum amdgpu_svm_attr_change_trigger - effects caused by an attribute change
+ * @AMDGPU_SVM_ATTR_TRIGGER_ACCESS_CHANGE: Access policy changed.
+ * @AMDGPU_SVM_ATTR_TRIGGER_PTE_FLAG_CHANGE: GPU PTE permission/cache bits changed.
+ * @AMDGPU_SVM_ATTR_TRIGGER_MAPPING_FLAG_CHANGE: Mapping policy bits changed.
+ * @AMDGPU_SVM_ATTR_TRIGGER_LOCATION_CHANGE: Preferred or prefetch location changed.
+ * @AMDGPU_SVM_ATTR_TRIGGER_GRANULARITY_CHANGE: Range granularity changed.
+ * @AMDGPU_SVM_ATTR_TRIGGER_PREFETCH: New attributes request a prefetch.
+ *
+ * Bitmask describing what an attribute update touched. It drives whether the
+ * existing GPU mappings must be invalidated and/or remapped.
+ */
+enum amdgpu_svm_attr_change_trigger {
+	AMDGPU_SVM_ATTR_TRIGGER_ACCESS_CHANGE = BIT(0),
+	AMDGPU_SVM_ATTR_TRIGGER_PTE_FLAG_CHANGE = BIT(1),
+	AMDGPU_SVM_ATTR_TRIGGER_MAPPING_FLAG_CHANGE = BIT(2),
+	AMDGPU_SVM_ATTR_TRIGGER_LOCATION_CHANGE = BIT(3),
+	AMDGPU_SVM_ATTR_TRIGGER_GRANULARITY_CHANGE = BIT(4),
+	AMDGPU_SVM_ATTR_TRIGGER_PREFETCH = BIT(5),
+};
+
+/*
+ * Attribute changes that require invalidating existing GPU mappings.
+ * A granularity-only change does not, so it is intentionally excluded.
+ */
+#define AMDGPU_SVM_ATTR_TRIGGER_NEED_INVALIDATE                                            \
+	(AMDGPU_SVM_ATTR_TRIGGER_ACCESS_CHANGE | AMDGPU_SVM_ATTR_TRIGGER_PTE_FLAG_CHANGE | \
+	 AMDGPU_SVM_ATTR_TRIGGER_MAPPING_FLAG_CHANGE | AMDGPU_SVM_ATTR_TRIGGER_LOCATION_CHANGE)
+
+struct amdgpu_svm_attr_range *
+amdgpu_svm_attr_get_bounds_locked(struct amdgpu_svm_attr_tree *attr_tree, unsigned long page,
+				  unsigned long *start_page, unsigned long *last_page);
+void amdgpu_svm_attr_set_default(struct amdgpu_svm *svm, struct amdgpu_svm_attrs *attrs);
+
+struct amdgpu_svm_attr_range *
+amdgpu_svm_attr_range_alloc(unsigned long start_page, unsigned long last_page,
+			    const struct amdgpu_svm_attrs *attrs);
+void amdgpu_svm_attr_range_insert_locked(struct amdgpu_svm_attr_tree *attr_tree,
+					 struct amdgpu_svm_attr_range *range);
+bool amdgpu_svm_attr_prefer_vram(const struct amdgpu_svm_attrs *attrs);
+struct vm_area_struct *amdgpu_svm_check_vma(struct mm_struct *mm, unsigned long addr);
+
+#endif /* __AMDGPU_SVM_ATTR_H__ */
-- 
2.53.0

