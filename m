Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5E50CCF9E3
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 04:11:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDABC10EE47;
	Wed, 29 Apr 2026 04:10:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e+g0qQUD";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011013.outbound.protection.outlook.com [52.101.52.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA35B10EE42;
 Wed, 29 Apr 2026 04:10:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fzfir/VSU/vLXhNe07fELpvGgWpK9kHio8ZLrWZblCiyrjgy6sYnvGH4Wm0DNyYo9PqgyXJJRO4I3tHQxB7M+i2xUMmWjwkOtVESwcUvIjaAs0gpurbusqQxK+b30J5G8mTIckt3Z1AKtzicR7OdN38+d96XPM1p6i+f2vHIlQ6Axjr+u6eGt9sJsjNAouK8w8+y0cepbmZ13T9mV+NLdLrRrldsh5CCOU/z1k8XJyCsKFb7JIuoWGqqJnfftLKlWFC3ZHKDLpHnpaXDXNV7ZE3Ud3cfHxkBtEL6n9Cw3vyIG86S6VYzrEo/RNx9bZdaGVVwEKrFmmcBNdXl7R2lrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BQk3oggVw8maIxGOU2kvbiFa3cbZjNDgdBGQlyQCW3A=;
 b=EBwiPySl0z7fw6uGIcWpjfUcrrDg4TL+z+G8SwctQJlqOpKTf6tIXyElMLEMDkqcyxpQEfhNZdLrtub+1TT3crdfbDmKa+w6Bawpn9cLM8C6iVO5KXjKf79PYv0MHcG43DMG+LfnzYkovjCJ9isR7a8ue8cQ2HPYqipHqzFLEinuE7GkUHSNJAO3LEaOWLCfOyxPbH5RYc9jQAwwmCMVl7zbJ4Jwr+cm8sE4HcB1T1ulBDZVv75zRXZcQVR1qeannOY6SlQWFGKQlMQsKEuhIJ6YcW+tZuTn52gzd6+L5ByE5MsZxnZAxJHhXXGiE+c8Vjp+Nt/tfFYub0g31gc34A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQk3oggVw8maIxGOU2kvbiFa3cbZjNDgdBGQlyQCW3A=;
 b=e+g0qQUDkt+1De24UeSeKUySVci2jIxkaPSE8VTrr0feU9+q9XuBTO8R5ll93RAatjl6aIs9yozrJOr+vEcu/wdbw4sN8Urtod60jHvUwKYkLAJejyS5qKTpoZL9FFAr7ZnfVY2ctsUiy5P12YRdtycGtIXPVF5mdcGhubkbKdQ=
Received: from SA9P223CA0021.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::26)
 by SJ2PR12MB8135.namprd12.prod.outlook.com (2603:10b6:a03:4f3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Wed, 29 Apr
 2026 04:10:42 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:26:cafe::5a) by SA9P223CA0021.outlook.office365.com
 (2603:10b6:806:26::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Wed,
 29 Apr 2026 04:10:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 04:10:42 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Apr
 2026 23:10:36 -0500
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Apr
 2026 21:07:04 -0700
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <sima@ffwll.ch>,
 <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC V4 04/12] drm/amdgpu: implement SVM attribute tree and helper
 functions
Date: Wed, 29 Apr 2026 12:06:20 +0800
Message-ID: <20260429040628.853079-5-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260429040628.853079-1-honglei1.huang@amd.com>
References: <20260429040628.853079-1-honglei1.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|SJ2PR12MB8135:EE_
X-MS-Office365-Filtering-Correlation-Id: 733b4d6b-7825-4a73-9e19-08dea5a54791
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|56012099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: ueTbDyGBf8T/cThOAtGiEN8CzokWqRpKoSEMELAb6/P6kAR57L5Haq/O53Xvz5vQtxsJ6ZohPvjRJdm/A3GQbIivsVhvTAC2AHBvNBgl/AaI1IRZpYbbi+qJoYoSIJ1mP5iAn7/cyQi7OfZ54mQXlf8bHFIOg1w358hcluxo6O3d8sdFR04qpCSu7Jeo5+clIWeRpfsuO5hrAoUxfeBaNWAIQ4blNUq8S2S7B0wnyua9B5xJaPbL+kzTpVUK7mM62fLcE/5ift2lI1FO+SfyJs4jjbwJtmE+bIYa9OW+DTgcsWOzVfTf1p1XqKLE3qz6QxeANkD8GCM25YoRkNSWXRr1dU/fW5+TxSOrOHsWoPBdOGAZkXRkvZRQghekOrUQ6k/J2i62v+qZ7CXoZCOb7Pjmc0cwJF1AxIqRCLXMCThIdXwNebQEERzxqGLLMpEYUyexRTxnYWQ51g/z/Suf14mGO956WKgTy4G717fRAasr77evloShltLUBL8s4HUygFKlnKJ+MUSDN53igmk7p7xyn1AILhpHeiIALjEl+xMzEHu0qGdLPM3enTvbPawJyjAZIR8HkZXMCjJA7pMrCjoobdA5l+n6BjOkNTOwcH2ZH5U3PzJYFaSqnXZGVA3eY/PlMrz2Vto8gIH/CKS3W7x8XbSxWASLVAZ0A6Sa8YW8pV7TIc/tXUjVL/YiQVeyCB91jFYgCpk4TnMXBl/u41NGpXdRsVD9qg7DRYkuQqpP7W8csJhxHYO8eEPlzaRZv0CWDqViNjZbnj8UntkVBqADVQxcfqjGTIkKHRwa2aAphOYHXiP+BCv0C/ZH1pz4
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(56012099003)(18002099003)(22082099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wPc8kQrAoiUJhLlbEaqvKuI96JlOg8WAJBTMgWfuoiVRhhy5ooALHptu0m5Tx3Y75QW9ckpGLM4Rj1nExIaHu4d1SPbcQxoKZQyzWOQJXEviV2Asp35hc3oukWuncDTE8q3LZ9hwfYD4ILiEAkHNyTb9Dj7yFA/chN7reFZR6EdsMMLxk6SoqwwRJy3BeBEeYEc57nzoO5fkLOJRjnKTbhsGEs90n97xFLTnmqCKjY15Sr1pa8LeNQCrNA5WVxPPxMtb0an4NC66Ll/HN9Cr3pNUZZQQeS1pHJotGZLKsUtlZfae9zixUlImrFIFP1GXxfSz721K4wwniS+uCV3BRX2wZaF9AKwc9Xcu7nuq9I+kSXKFJBOZPKhhE5LLBCFvdImcXRoxl8+loOFE+RSrwdKmQlXOvQFmpVGiT6S4HyxRJ1Jv5flgeMGHXE0S10IQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 04:10:42.1447 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 733b4d6b-7825-4a73-9e19-08dea5a54791
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8135
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

Implement attribute tree foundations in amdgpu_svm_attr.c: slab cache
management, default attribute init, equality/change detection helpers,
and interval tree CRUD (find, get_bounds, alloc, insert, remove).

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c | 291 +++++++++++++++++++
 1 file changed, 291 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
new file mode 100644
index 000000000..addc23d63
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
@@ -0,0 +1,291 @@
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
+	uint32_t granularity;
+	uint32_t flags_and;
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
+	attrs->flags = AMDGPU_SVM_ATTR_BIT_HOST_ACCESS | AMDGPU_SVM_ATTR_BIT_COHERENT;
+	attrs->access = svm->xnack_enabled ?
+		AMDGPU_SVM_ACCESS_ALLOW_MIGRATE : AMDGPU_SVM_ACCESS_INACCESSIBLE;
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
+			return attrs[i].value != AMDGPU_SVM_ACCESS_INACCESSIBLE;
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

