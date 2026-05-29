Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E2CCD5BD2
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 05:48:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8FAC10F8E9;
	Fri, 29 May 2026 05:48:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WUWZx03y";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013022.outbound.protection.outlook.com
 [40.93.201.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 304DA10F8EB;
 Fri, 29 May 2026 05:48:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XW0+ljHWW85NxZ8gtFFQZeWWWtDaeOmbpdfYLHGGXMEZ3txA/GT4eXnVgB41HNZS9bo6sK71RlyWMWLYBgmBuKL6YiVkBKfCjzZgj8bRN7H/O9MJHdd8wUiiHRCfVZSCl13/Jq09m3ER6HCHoPK6Bx2IW++HXeteid0tZhW7wSunXhMMOvNSwP/y8BEVPN1dqeUgd63IiyVQ2GvxxunupgLh73md4PGyOa1+0I/KCDcMOGW1Tq+lVdsNKmt32WullLSq458SkrXwf2hnwazm1s56vHpanW97UtUyKuCIeYk04+0N4vMw8fyFbK1Wu48QoJMf8MBv00mXsXmJlXQ2Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mfy1jl5NLTfTBX0DHRjUuSf8PhI90GpYX+NzeLMUip0=;
 b=OtXcDuBSFaAWzJ78W5IPeWHxwiDrcnbziEeFjHYEJWw2UEUeriTsqJeSlSDJXXK6v/eSgqOqByNkIOzLjq+BAK7/JhumSUsIfPfxQ014Gc8XONKXCi3xupsukxGnb0pDAu/7WlQnepQa/AbJwc7ewRK8t97pVmJqjHG1z9gz1q2v3P76P6/YhKrJRKGjIOkUTGEw53zq7VmEVzxHeU+rrAxdxHhoCj55FwKUMpYCVn4dCMOO7PqbNzHdiBXBY1FnSpMSF/7fqM+ju1oymyVA5PAMpVCwhaLlXbgwd7MmxZI15QP+jnSCG6IPgpJ0+WjfcAorvRFNj8tOIvMUqhATmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mfy1jl5NLTfTBX0DHRjUuSf8PhI90GpYX+NzeLMUip0=;
 b=WUWZx03yOKpkYTQma0gSTU00GgtFK7RQrNedcfSoW2KuQJM35XUen+z7OSWR3WTyF4Vro7NFn+3CmY7uAaBB0txgEjZA3h1k5XG4u7pS8yRWyFCEEtOkkV11rStYaKpn8VzxBlXDnBanb/4CbmbGB3UJVfHo2fPODNldb6aAMAE=
Received: from SJ0PR05CA0148.namprd05.prod.outlook.com (2603:10b6:a03:33d::33)
 by MN2PR12MB4047.namprd12.prod.outlook.com (2603:10b6:208:1de::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Fri, 29 May
 2026 05:48:41 +0000
Received: from BY1PEPF0001AE16.namprd04.prod.outlook.com
 (2603:10b6:a03:33d:cafe::10) by SJ0PR05CA0148.outlook.office365.com
 (2603:10b6:a03:33d::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via Frontend Transport; Fri, 29
 May 2026 05:48:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE16.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 29 May 2026 05:48:40 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 29 May
 2026 00:48:35 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>,
 <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC V7 04/12] drm/amdgpu: implement SVM attribute tree and helper
 functions
Date: Fri, 29 May 2026 13:47:56 +0800
Message-ID: <20260529054804.596214-5-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529054804.596214-1-honglei1.huang@amd.com>
References: <20260529054804.596214-1-honglei1.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE16:EE_|MN2PR12MB4047:EE_
X-MS-Office365-Filtering-Correlation-Id: e1989278-3988-4587-0d9c-08debd45efc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|921020|22082099003|18002099003|56012099006|6133799003|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info: YkepyH9K6ixbS5j39AFW0by/V51X9qokvrRsrIL71n1ZptQVIbZ89hgSHQ7dzi351488bupPlxvoG40pktCW5pJeqpH4sag7Ty6nHvcH+UqxOvo/oD7EtXoyqTEzfT2FkmXu1ZQ44aRpms15gHnxu3EUBllRpn/q/9/vtuSa502GUifm/h/X+wxR+FZMymftKc9rE6zp5ZWPhwitdriu2X4ouZdrDJtLQLS26B2wDFBzqCWYdehgaTup/LasiGReQzFqqE5GX/dine6L+ExyOnZccs+WFby3+lthxJw0jS/jVBdDxpVCBQO/4IgezwtUparOQm4Kt71Vy5bvYWMKeUlmZ3t1rHAwluzh+ZIv9eKTQjDYyyqGRZe2zNsVS6m5n/eCZrGKboKHxnDqRUEr2fyW2nnLLY7vZ4hiu7vlBZj8bR4SP5R61KFzSrvMaUD8TDgEFvItEAVpflu7qWPTOdoDPLIPDYfeTG232FNIfBzNCbpBmHexFa1bBltAHLLcgjEmncgjmI9x/XYzMHemVcfZdqSqRDR3sRlwE+cXqrsS7fT52/mXyQK9jZJBM4jiZUf6Gras9KOQYzaUvOJSl4yFVYChUftIQdxLnO8Xw6IDipdMurFgBE+110lQkh3uquc7rXXsEVgBiTL7/jpXUNsAeaukMWet5PGFtIU6YjmEKVDpcqsl/29hp/M39+KK/lca/hhZY8HbhEE9XyKE8z7XqBmm1z1ixT/8dCZqCWJfwSCaKUuOWhGiz+JIIoLRExf6r3pFj1wbrveUxR+ttQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(921020)(22082099003)(18002099003)(56012099006)(6133799003)(3023799007)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: W8PIkQEVye1+QNjhgGN5f3NiBaWKOH18IBDvRUrzIKQghIwsztBeahF9Zz3z6UmSKUjobeBid2bdSJklwkt53hnsLjm++AjjQnDq+OhKgLSafg4dkUqRhzGz/azkm3n8l91hzqEy1sdIeP6MsqAVPE63c7n/B3/Yj68XQv9uyx+ElT4Sjy53lZIUXnxq6P4QlXaEbfdIke65yj/fXu5AMv3Nwz17c+zLFw0U8gNog1a1WciGyzI49nv4cHV7qS2XYQkDOOkbT9KWV0sl/HjFX0+aCKmCVh1sdQgTaT1HjVaXaGCXbAQsMf4Sy7m2jsWbA8pNAiqcNaui4Ji2+QlFJ8xcR3HxhrwCBqMXRHJNBbVl5PeMclAOjoY6OnNsaa3OTjAT3MBl9fxYV7kpla2TLHo02Pm7LpIumnDHDP7dQW99LxQFAnRHIruG7o621QX8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 05:48:40.4961 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1989278-3988-4587-0d9c-08debd45efc2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE16.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4047
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

