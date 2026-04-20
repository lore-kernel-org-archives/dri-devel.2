Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 762EBF36C5F
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 12:08:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BF0C10E53E;
	Mon, 20 Apr 2026 12:08:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ENg4qhEP";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012009.outbound.protection.outlook.com
 [40.107.200.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CB4210E544;
 Mon, 20 Apr 2026 12:08:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RFNVH71JAVRCBRA7NJae/5s/lHwdlelrmXgLmr2fCDRvV2dg/mMyhT2WI4PZhvhmvNWh4sKXNxmI1ZV0Omt1C8lc48nrei2v1iYPh9KTSO48eDun0L6dNAsqF66b1/EsSVJp+uTw9pAh/+6ZG+Zuhf6Wk92G8Dvx7UR4ZkpIzM279ovhlI8fDKjNNRmP9SumwfQ0RFb5jFRZvb4nhmSZogoscmuDR9u6PwfnnuNzd+DRxZhiQxA1f8EMFuKOtc4ha01zNdfbz4KoPBcGTB7XzWxq7k1a/DDW6BU5jWXSTSWAI90UFuFaCxpUf8xgsSDwKWujfrL8vjZcmCeLvJTmNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Os31XEdDdEO4USTcnVvpQ2PQYOYnysqD7sqYErlcn8s=;
 b=hZJu+WkBRjLzEwBREe9LpZaJmQFZB3NZIMutDpzeVIsjeLFio/ydgfbRu6P5e/XfundvtwEn2Er3n93xFBN9Ot2A6VY3AO9E9uxTRR/Q1iJO9R3D0jpIdK+1aywQHFCWD0QdttmPOw6+iWGpvX7qpzMa/ojGqw5fkcO10uULwDWZZwl3F2JGu3iozdsGU1TliCwMy9EAnELXD9sKodXZMvbLZXaBajv8POTZkKrVcMOvss5ufbHZAzeI1LcMZNtDbuD8TRI4Wf5KlhSlENazLEATfzDkM0zSP47rc1mEnrgiFt1Z/o68oqX4Vwimcvl3Nxk1SlvtuMxTlzOQq6chnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Os31XEdDdEO4USTcnVvpQ2PQYOYnysqD7sqYErlcn8s=;
 b=ENg4qhEPCzWORCWI9Mrku3MZqQgwrHdMnF2Na+5RdDHVyTU0gnevjb4v2is0KA/A4bHYXuqmMyB/5IeiZl5LZxJZWGeJS0GGplGotbQRJz9Uka3AUiqiBvRuSa0l/kn2X/ZyvAIVh/YJxBBzLx7z/BfP3RH5k0viSZz5qHj8+UY=
Received: from SJ0PR03CA0176.namprd03.prod.outlook.com (2603:10b6:a03:338::31)
 by DSVPR12MB999148.namprd12.prod.outlook.com (2603:10b6:8:38a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.8; Mon, 20 Apr
 2026 12:08:18 +0000
Received: from CO1PEPF000066E8.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::7d) by SJ0PR03CA0176.outlook.office365.com
 (2603:10b6:a03:338::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Mon,
 20 Apr 2026 12:08:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000066E8.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Mon, 20 Apr 2026 12:08:18 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Apr
 2026 07:08:13 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <matthew.brost@intel.com>,
 <rodrigo.vivi@intel.com>, <thomas.hellstrom@linux.intel.com>,
 <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC/POC PATCH 04/12] drm/amdgpu: implement SVM attribute tree
 operations
Date: Mon, 20 Apr 2026 20:07:31 +0800
Message-ID: <20260420120739.1811731-5-honglei1.huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E8:EE_|DSVPR12MB999148:EE_
X-MS-Office365-Filtering-Correlation-Id: e7ff306b-1f94-4d7e-560d-08de9ed58229
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|921020|18096099003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: X4NkL/SUClLYnsn9RwXGq8Faa6Zasxp8Hl/BlKmSoQ9oWWbI858f7Qszqu31c/LXtiv61KQP3tGSmoFFd9qy099h1q2Ld1mOe85h8IMnrvb80BJLs4pg+2Y7Q+wuvwsg7WWsttBFsEAjwuop0A57IB2+jadbpuIYeAbMvrtvCDQf8Fmkgzj2gizICY93Mg9kIKE/tLES7JN0bwV0sCC+RyvyLNhDL2qItqEhEjytl9X+9XsM1o6G0ZD4UoRpwX0I9149pHqv2lJSkt9T5ZvOjROspQ3dvEDcTFEpSR+yXlzCoxUiwYuZhOabMgbkGzFMVGnznHSBOSN7eAFtUSuo9i9cSGrDMUWk+GxPLPknxgQc+HKJki6w78SAacTIAsuPpFRjiHAx2S4jrtRkFfrp5cx5r6W2DFGoRp9+jlR5bydZ2o7KnTi6czrGvrtDpzwoaUWLEn7I8qGtKA8XQvnjhIKmTPyFIlQn4w1/u3KwC4m1m4VAnUX3zgNIAo3NiDw+kGQg5HmWqYvtLUSjTZKtYrQQVb+po8ezvs63DiwVBcrVLL++pSv9PlPFy1T2C1ywk5FxC6iumzMf8zVQVgpys0I8pnUn+LbBsS15DgJV1lE2hjNPvMYWFHbdC4O/xJzKGM8DpJo2VlOhXgpof01PIS0Cft2ubQvcBME+pIti2jFtuHMx3o+Lik65KsqESt/9jBbbuB0++76a8nMM01UVU46WO3C14T41cl5PO2zEoG74aSGfG+kXwzRHOypx4GE4on1Hkc9jF1UCTx9ZVguRyEQDDf5MwER/Gut1XFq2gKHhlJEa+MyVEP2ksEWv9G9w
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(921020)(18096099003)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lZ2zZsnEpLr+mqs9bC4guqAAfWQMmoFLQ7eK3G8B4hbHpzI8dyW2TLmTpQJVApf0mKHxjfVa+KMocMuQXtzdXoeTFo+D7adGela3gxJNmEk7atVxoaZO4YfGd/qfULSCDOnsA7IakW4p5ovqfJp49ytBH2T5hvQCAAzS+/BR5CQ5SeDhDAsgnaQG6T81DAKmhRj42iJR2lrKYP0GmL8lXtmSCUJZM0Sf7j83EBAS9dimVf8NxQOlAInDDPcUkpLut12ux7sVLN6hIUfBzryvU7IQVNKbE3nadEkdWxj5pdv5uju4GxiAVhYnB7yBZWfZgqDKkDXmKWJURwzhJ+lZC2reeLcZ1DFiVwVmBRI30wo8SYQ8FQsyqubJZ/B+kCsIslGjFxDoYwrhUKTBPnZhdhltH2E9P95iQ/mcSEoM2CJfM3/ItVaYwdu9Mf2M0fJU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 12:08:18.1414 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7ff306b-1f94-4d7e-560d-08de9ed58229
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999148
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

Implement the attribyte tree operations.

- Attribute tree operations
- amdgpu_svm_attr_tree_create/destroy for lifecycle management

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c | 346 +++++++++++++++++++
 1 file changed, 346 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
new file mode 100644
index 000000000..137dfcb58
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
@@ -0,0 +1,346 @@
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
+
+#include <linux/errno.h>
+#include <linux/gfp.h>
+#include <linux/lockdep.h>
+#include <linux/minmax.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+
+static struct kmem_cache *amdgpu_svm_attr_range_cache;
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
+static unsigned long attr_start_page(const struct amdgpu_svm_attr_range *range)
+{
+	return range->it_node.start;
+}
+
+static unsigned long attr_last_page(const struct amdgpu_svm_attr_range *range)
+{
+	return range->it_node.last;
+}
+
+static void attr_set_default(struct amdgpu_svm *svm,
+			     struct amdgpu_svm_attrs *attrs)
+{
+	attrs->preferred_loc = AMDGPU_SVM_LOCATION_UNDEFINED;
+	attrs->prefetch_loc = AMDGPU_SVM_LOCATION_UNDEFINED;
+	attrs->granularity = svm->default_granularity;
+	attrs->flags = AMDGPU_SVM_FLAG_HOST_ACCESS | AMDGPU_SVM_FLAG_COHERENT;
+	attrs->access = svm->xnack_enabled ?
+		AMDGPU_SVM_ACCESS_ENABLE : AMDGPU_SVM_ACCESS_NONE;
+}
+
+void amdgpu_svm_attr_lookup_page_locked(struct amdgpu_svm_attr_tree *attr_tree,
+					  unsigned long page,
+					  struct amdgpu_svm_attrs *attrs,
+					  unsigned long *range_last)
+{
+	struct interval_tree_node *node;
+	struct amdgpu_svm_attr_range *range;
+
+	node = interval_tree_iter_first(&attr_tree->tree, page, page);
+	if (node) {
+		range = container_of(node, struct amdgpu_svm_attr_range, it_node);
+		*attrs = range->attrs;
+		*range_last = range->it_node.last;
+		return;
+	}
+
+	attr_set_default(attr_tree->svm, attrs);
+	*range_last = ULONG_MAX;
+
+	if (page == ULONG_MAX)
+		return;
+
+	node = interval_tree_iter_first(&attr_tree->tree, page + 1, ULONG_MAX);
+	if (!node)
+		return;
+
+	range = container_of(node, struct amdgpu_svm_attr_range, it_node);
+	if (range->it_node.start > page)
+		*range_last = range->it_node.start - 1;
+}
+
+static bool amdgpu_svm_attr_equal(const struct amdgpu_svm_attrs *a,
+				 const struct amdgpu_svm_attrs *b)
+{
+	return a->flags == b->flags &&
+	       a->preferred_loc == b->preferred_loc &&
+	       a->prefetch_loc == b->prefetch_loc &&
+		       a->granularity == b->granularity &&
+		       a->access == b->access;
+}
+
+static struct amdgpu_svm_attr_range *
+attr_alloc_range(unsigned long start,
+			   unsigned long last,
+		   const struct amdgpu_svm_attrs *attrs)
+{
+	struct amdgpu_svm_attr_range *range;
+
+	range = kmem_cache_zalloc(amdgpu_svm_attr_range_cache, GFP_KERNEL);
+	if (!range)
+		return NULL;
+
+	INIT_LIST_HEAD(&range->list);
+	attr_set_interval(range, start, last);
+	range->attrs = *attrs;
+	return range;
+}
+
+static void attr_insert_range_locked(struct amdgpu_svm_attr_tree *attr_tree,
+					  struct amdgpu_svm_attr_range *range)
+{
+	struct interval_tree_node *node;
+	struct amdgpu_svm_attr_range *next;
+
+	lockdep_assert_held(&attr_tree->lock);
+
+	node = interval_tree_iter_first(&attr_tree->tree, attr_start_page(range),
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
+struct amdgpu_svm_attr_tree *
+amdgpu_svm_attr_tree_create(struct amdgpu_svm *svm)
+{
+	struct amdgpu_svm_attr_tree *attr_tree;
+
+	attr_tree = kzalloc(sizeof(*attr_tree), GFP_KERNEL);
+	if (!attr_tree)
+		return NULL;
+
+	mutex_init(&attr_tree->lock);
+	attr_tree->tree = RB_ROOT_CACHED;
+	INIT_LIST_HEAD(&attr_tree->range_list);
+	attr_tree->svm = svm;
+	return attr_tree;
+}
+
+void amdgpu_svm_attr_tree_destroy(struct amdgpu_svm_attr_tree *attr_tree)
+{
+	struct amdgpu_svm_attr_range *range, *tmp;
+
+	if (!attr_tree)
+		return;
+
+	mutex_lock(&attr_tree->lock);
+	list_for_each_entry_safe(range, tmp, &attr_tree->range_list, list) {
+		interval_tree_remove(&range->it_node, &attr_tree->tree);
+		list_del_init(&range->list);
+		kmem_cache_free(amdgpu_svm_attr_range_cache, range);
+	}
+	mutex_unlock(&attr_tree->lock);
+
+	mutex_destroy(&attr_tree->lock);
+	kfree(attr_tree);
+}
+
+static void attr_get_ctx_add(struct attr_get_ctx *ctx,
+			       const struct amdgpu_svm_attrs *attrs)
+{
+	if (!ctx->has_range) {
+		ctx->preferred_loc = attrs->preferred_loc;
+		ctx->prefetch_loc = attrs->prefetch_loc;
+		ctx->granularity = attrs->granularity;
+		ctx->access = attrs->access;
+		ctx->flags_and = attrs->flags;
+		ctx->flags_or = attrs->flags;
+		ctx->has_range = true;
+		return;
+	}
+
+	if (ctx->preferred_loc != attrs->preferred_loc)
+		ctx->preferred_loc = AMDGPU_SVM_LOCATION_UNDEFINED;
+	if (ctx->prefetch_loc != attrs->prefetch_loc)
+		ctx->prefetch_loc = AMDGPU_SVM_LOCATION_UNDEFINED;
+	if (attrs->granularity < ctx->granularity)
+		ctx->granularity = attrs->granularity;
+	if (ctx->access != attrs->access)
+		ctx->access = AMDGPU_SVM_ACCESS_NONE;
+	ctx->flags_and &= attrs->flags;
+	ctx->flags_or |= attrs->flags;
+}
+
+static int attr_get_ctx_to_result(const struct attr_get_ctx *ctx,
+				uint32_t nattr,
+				struct drm_amdgpu_svm_attribute *attrs)
+{
+	uint32_t i;
+
+	for (i = 0; i < nattr; i++) {
+		switch (attrs[i].type) {
+		case AMDGPU_SVM_ATTR_PREFERRED_LOC:
+			attrs[i].value = ctx->preferred_loc;
+			break;
+		case AMDGPU_SVM_ATTR_PREFETCH_LOC:
+			attrs[i].value = ctx->prefetch_loc;
+			break;
+		case AMDGPU_SVM_ATTR_ACCESS:
+			if (ctx->access == AMDGPU_SVM_ACCESS_ENABLE)
+				attrs[i].type = AMDGPU_SVM_ATTR_ACCESS;
+			else if (ctx->access == AMDGPU_SVM_ACCESS_IN_PLACE)
+				attrs[i].type = AMDGPU_SVM_ATTR_ACCESS_IN_PLACE;
+			else
+				attrs[i].type = AMDGPU_SVM_ATTR_NO_ACCESS;
+			break;
+		case AMDGPU_SVM_ATTR_SET_FLAGS:
+			attrs[i].value = ctx->flags_and;
+			break;
+		case AMDGPU_SVM_ATTR_CLR_FLAGS:
+			attrs[i].value = ~ctx->flags_or;
+			break;
+		case AMDGPU_SVM_ATTR_GRANULARITY:
+			attrs[i].value = ctx->granularity;
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+int amdgpu_svm_attr_get(struct amdgpu_svm_attr_tree *attr_tree,
+			uint64_t start, uint64_t size,
+			uint32_t nattr,
+			struct drm_amdgpu_svm_attribute *attrs)
+{
+	struct amdgpu_svm_attrs default_attrs;
+	struct attr_get_ctx ctx = { 0 };
+	struct interval_tree_node *node;
+	unsigned long start_page, last_page, cursor;
+	int r;
+
+	start_page = start >> PAGE_SHIFT;
+	last_page = (start + size - 1) >> PAGE_SHIFT;
+
+	mutex_lock(&attr_tree->lock);
+	attr_set_default(attr_tree->svm, &default_attrs);
+	node = interval_tree_iter_first(&attr_tree->tree, start_page, last_page);
+
+	cursor = start_page;
+	while (cursor <= last_page) {
+		const struct amdgpu_svm_attrs *range_attrs;
+		unsigned long range_last = last_page;
+		struct amdgpu_svm_attr_range *range = NULL;
+		unsigned long next;
+
+		if (node) {
+			range = container_of(node, struct amdgpu_svm_attr_range,
+					     it_node);
+
+			if (attr_last_page(range) < cursor) {
+				node = interval_tree_iter_next(node, start_page,
+							      last_page);
+				continue;
+			}
+
+			if (attr_start_page(range) <= cursor) {
+				range_last = min(last_page, attr_last_page(range));
+				node = interval_tree_iter_next(node, start_page,
+							      last_page);
+			} else {
+				range_last = min(last_page,
+						 attr_start_page(range) - 1);
+				range = NULL;
+			}
+		}
+
+		range_attrs = range ? &range->attrs : &default_attrs;
+		attr_get_ctx_add(&ctx, range_attrs);
+
+		if (range_last == ULONG_MAX)
+			break;
+
+		next = range_last + 1;
+		if (next <= cursor)
+			break;
+		cursor = next;
+	}
+
+	if (!ctx.has_range)
+		attr_get_ctx_add(&ctx, &default_attrs);
+
+	r = attr_get_ctx_to_result(&ctx, nattr, attrs);
+	mutex_unlock(&attr_tree->lock);
+	return r;
+}
-- 
2.34.1

