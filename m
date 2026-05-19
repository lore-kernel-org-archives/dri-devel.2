Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC353CD4F52
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 08:32:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E838710EB4D;
	Tue, 19 May 2026 08:32:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ofHEUu8p";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012015.outbound.protection.outlook.com [52.101.43.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BB5110EB4C;
 Tue, 19 May 2026 08:32:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HQ8/eS40ezvn2+7/resaf+oPSA7jCP6qxBuGcUIvcfCRzDvth8p+8Phb7lNJ26siDXjcWHESUSqy3V5TNHBJKzPaBFYoZj17JMz5tXxZHfa4qsrofHQxZKhV9TDAM5rkIZyHZDp+5wijw4WEZbaJm84QZvMYNnbjayXhzDiVy8lsWB4w8ULsl/Au2ErZ3bKP1EeOIER8rEav/CGslRarK6x9pk8cIuWtx6Z/ItHi4LJSIso7Ym1Bb+gHP37xDAU/GqdKYTgHNyUri72tFksj8jbUkTBeVZzeSD3YFqc8OEgLWPk09XRtJR/zSwP8+yWBLZDn++7f+mrgEyh8gjXBEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mfy1jl5NLTfTBX0DHRjUuSf8PhI90GpYX+NzeLMUip0=;
 b=ndtQuVyH8ncCP11TpaqJxFGPxUy31rcDa367mW7a2kMnwgd+QinCDNnN+bmkcp2fpiS0VL3D3tPXWDd3lM+EJqNchkmOeQ1NuRhT4+lQx69lN+iHdqAzLCz9X5qLe/XZmYJj8mv7/Kfe5dpwVnCv3oB1lr2HYD9/z7ZtlF9pGp3PC1S8zMLDLtR1tlTvUZijK723lLUglRjZcKHmUQeUeN6uRa+L3fobJ8JRGqwzw7B2IihZUNY4BJcMpSBTI1rCNu75MYyaugyILSga4d150UZnxsZeTNe5eWj/w8j/4SoducXU/GRRT0sNrctpm4zqO9i6sbEkL+bYxvcWFhoTYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mfy1jl5NLTfTBX0DHRjUuSf8PhI90GpYX+NzeLMUip0=;
 b=ofHEUu8pBGWPmAydO/2gwG8Bl02ykusImZVEUrYPVobAxhZeHbIxQhoHLq8kSpybLbZZJngF++Sm+pYFZbrd+WYP/pVkIOciSwfuplXyHj38cFF/YTx0k1YGLtYi83wLdMgrRm0kwWAfR5LD4VYpRAi80pPg4sesQpEsTbX9YNY=
Received: from BY5PR20CA0008.namprd20.prod.outlook.com (2603:10b6:a03:1f4::21)
 by CY8PR12MB7658.namprd12.prod.outlook.com (2603:10b6:930:9e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 08:32:03 +0000
Received: from SJ5PEPF000001F4.namprd05.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::19) by BY5PR20CA0008.outlook.office365.com
 (2603:10b6:a03:1f4::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.24 via Frontend Transport; Tue, 19
 May 2026 08:32:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F4.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 08:32:03 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 19 May
 2026 03:31:57 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>,
 <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC V6 04/12] drm/amdgpu: implement SVM attribute tree and helper
 functions
Date: Tue, 19 May 2026 16:30:49 +0800
Message-ID: <20260519083057.3108087-5-honglei1.huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F4:EE_|CY8PR12MB7658:EE_
X-MS-Office365-Filtering-Correlation-Id: f5b59f72-339b-4dd9-f9e9-08deb5811aa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|22082099003|56012099003|3023799003|11063799005|921020;
X-Microsoft-Antispam-Message-Info: FcfAhEnZb+bqNxKK+MiqsPBtRRDUhI07oBgAz4yIIWDimH0k1a0t01mVK53gsO7UWPkbrjdi6yFjFOMR+iQD72MPWti14HZmdro+qBcOghpE0X97mKzhA0Kf2tRy7oCaTH4wNaXzkOxKzWV/2DCV9RbyHkqbem+toYKLJMpNv4iaGaeLjF+QiLYQEU2kWJsjeMOHyQze0D3n4Ma9SGqderQEmaoVTawb4i4RS5MzclpdKt2Rxu7bLc5FH9eO2F3ccHMFUf4mvf79rYHEKzXmJl6yPqY0G+aua5ijld5Yf8x2PzsgpvjF7GoyoaBSFtYkcaO6+7seFV/NGGQ4/n4Bnzx0eWqNfUS/lNzci7XpEfPmYopdVOmLoHq++zuueVFD85FLgxZvpp0wXVNZIaVIAhXq2q3HjxcjG9AZEynYLWQVXIDSxmZhnmkwcDX4SeyHP3vydeft9y0MOP3+IbdaoJL1GUecL6utWshhXdujW2FaCMGTSW+5P9SyNUqEKAaoABoUVLCWGeTkZuRom7eqk1q3of7iTsKkJzwgcj2UKUjSe3KbfSXpNOXBOnGwUrLPOT8LnTPzK8SuIqAS0b4X8oFSRhO5TNcXjWSxBYlHBcZebJddwSWoGKfIaSZobMwgvFlVNfOqk2hwn6WQHFRrBmwxRi8FKeByN/6HozxrF7u9KT121EQsSOdmSzDWpTH55NmcvTL0ldEeo1cNld54yQxILpLHbkwyVFLz8L739Cu0OQ7y3sjF5pEyJqbc+gbn292QPrIqiM6WnIKYsRBcXw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(22082099003)(56012099003)(3023799003)(11063799005)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: j+am+LAcKYbvcpkSTcAn2SkaMf5Ge8Hy/8UQpg1hvJxGqdH60QZ3WSMD4c95I3IW6+6WPoHt9ewpMndRlg+pdoF8jp4lkMa03hwnXYs925B7P6eSo61sCx4EPfGR/LDnPWpTHY+ys3ghzutZcQ2LPnDyenCfxfjnJoiaMs4Qj3BK3zERjwv8tH2Bor0at3mLa2PZXaFt263dvQJXrmLhW4Rs4oMWy9+97+QDmri9V+/vp/Tm+dWmEnKdzb6FcDtKEGHdefIqDlmYk6yXazTRRQfurC7YQhfYApaKpFED+UAUxJkg64tVC+amRT2+GHfUPr8q4RPclXBbj1kDFLAD96hPTo9jWxLkEEcnEl2HJxzHmyka41F7NNlXla1upSPI0FjoAJUOFk7DUcE/i0oeQV9M93uW5nyujRp9nf19a3h1spVMU7NUa0R/1GnlIKOK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 08:32:03.4390 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5b59f72-339b-4dd9-f9e9-08deb5811aa2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7658
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

Implement attribute tree foundations in amdgpu_svm_attr.c:
- Slab cache management (amdgpu_svm_attr_cache_init/fini)
- Default attribute initialization (amdgpu_svm_attr_set_default)
- Device memory and VRAM preference helpers
- VMA validity checks (amdgpu_svm_check_vma)
- Attribute equality comparison (attr_equal)
- Interval tree CRUD operations: find, get_bounds (with gap detection),
  alloc, insert (ordered by start address), and remove
- attr_set_interval helper for range boundary updates

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c | 250 +++++++++++++++++++
 1 file changed, 250 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
new file mode 100644
index 000000000..10e4de4dc
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
@@ -0,0 +1,250 @@
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
+	struct amdgpu_svm_attrs old_attrs;
+	struct amdgpu_svm_attrs new_attrs;
+	unsigned long start_page;
+	unsigned long last_page;
+};
+
+struct attr_get_ctx {
+	int32_t preferred_loc;
+	int32_t prefetch_loc;
+	enum amdgpu_ioctl_svm_access access;
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
+	const unsigned long flags = VM_IO | VM_PFNMAP | VM_MIXEDMAP;
+	struct vm_area_struct *vma = vma_lookup(mm, addr);
+
+	if (!vma)
+		return ERR_PTR(-EFAULT);
+
+	if (vma->vm_flags & flags)
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
-- 
2.34.1

