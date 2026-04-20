Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DEADF588C4
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 13:13:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEA3610E5CD;
	Mon, 20 Apr 2026 13:13:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yDv5OWA/";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013054.outbound.protection.outlook.com
 [40.93.201.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35EDA10E5C6;
 Mon, 20 Apr 2026 13:13:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U9Xn9SEqG6VOnpCdmJ05KAX+qJU/6mRTBhXA11yIwu6y4vRa6gOVT/V3XDyFh0IW5zTzlVYPZnISWApiOAgMJII1020esP2JmbbNWqUto/C+pD7yNCtA3NqLw3zzeSJZ9w2eqXIUYuaJsDNFdUJcP7ksUAUXamm6fgBH76U6nhe47jsZ1YyQdG5KiwNzaMQc5vayvfMcuh2SzafqOKeH0xE4IWPjVX10WQ9unPPzAoxsqp5Q4Mv5OLvJwAklRRr5lDvzgUWuZxUqfd6e5dAb+M2sjFk0B/J2U6TVt1GNSIQJFCY6zwYda6pxCXB1F8aqrJjtDcsR1B1/+FV3+9navg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVPCVL8pnuv7rS2PMwe6hs/fxI48R1SeXUIcVDP8kMc=;
 b=mCXdAHlwpEqGCTgcXAX3zYuz1TSSkMsv/dRe/s81Wh5y9HzRIvvH66Sv6hqxbgZSvYHOSIxBrBXgEg+uLi4M/YGgn0R2Ok25B2zw7WgLgvOt4986qs8HTCc7wLVcE3N7A8CvGit9ffGj0xs8utLm1Wz0JYuwbQGcH/55WBs6rr7u1eBnbp5iz8SHQd3gnD7YThA3QuFTFshfftLabaLep309urentF2p15q+gxqw/UZZPfcbtlmFFSyQLfHTtlRIE/f4QPHvIbmD6k6V8InWuaqK+VNFh6lIUIpRAcYvl3OP5HnA7ZsfZYgswxatqHAAlu5/6gDfKbPv+kbverqAPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVPCVL8pnuv7rS2PMwe6hs/fxI48R1SeXUIcVDP8kMc=;
 b=yDv5OWA/ToctCbpnYZW6N4zrX2JXUZUys/xajBHU+V9ncTOzkdnjvjRroJeWEp/g+Bs4sgbiPgaNUkqaqxI7cr+Lm2BspMQ2MCiUwxcD9AZ7imp396/FrpYQQrA1hllHBVfiHoO8FgHhHuZMZ9I6Wy0aymEMT3jLPAkB37tCqLs=
Received: from CH0PR03CA0327.namprd03.prod.outlook.com (2603:10b6:610:118::20)
 by DS7PR12MB9551.namprd12.prod.outlook.com (2603:10b6:8:24f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Mon, 20 Apr
 2026 13:13:49 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:118::4) by CH0PR03CA0327.outlook.office365.com
 (2603:10b6:610:118::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Mon,
 20 Apr 2026 13:13:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Mon, 20 Apr 2026 13:13:49 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Apr
 2026 08:13:44 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <matthew.brost@intel.com>,
 <rodrigo.vivi@intel.com>, <thomas.hellstrom@linux.intel.com>,
 <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>, Honghuan He <honghuan.he@amd.com>
Subject: [RFC V3 03/12] drm/amdgpu: define SVM attribute subsystem types
Date: Mon, 20 Apr 2026 21:12:58 +0800
Message-ID: <20260420131307.1816671-4-honglei1.huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|DS7PR12MB9551:EE_
X-MS-Office365-Filtering-Correlation-Id: 50d1901d-5c0d-44f9-22d3-08de9edea941
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|921020|56012099003|18096099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: RnHNCFqF7aTwYU9QF0Q5IYO/x1sSai/3RM80j4drRa6N/rX9QQCLzIo9hJtqMy0GA/RQ/unU6PMAilYBOa6tMSMLJOmDnlaq1SmNdy/xXoRRITDSyX5tF6ZjXTqIc6WG/LOjL2ea0frTalniIJ2QNb/Pyj/EzEocKHQ7fhFN4Lru70kFXqK6V9Z8fK15BHJ9+dazW0M+gHBRq5NxyH6dXqF7tHZVQwqwvzuaRYHmJ2IcYli08QD6jjbfT+m6dU8k/e9PNApSgpO1kjrQbXznui931KURRVvTm3bg40D1ogFPce+pjPjZe2evh8NFWdhNuwCm05jpAd/wt5MzxK2v4/ymZJxuSrYwldR+hObgT+sFPge1Uedxmeie9sQXAb3zz8AWBioRazlydOtpUaXzu59uUvxeYa0QaAa/P6OB3PmkojxzoINLEh7B8m2pOlY9aJLJGgd4s58NNI5PxdFuiPcNFlhR3YdyYAARgS+mSrONLPDJJf+7gMNbfrRSDUX7+FQXinFUutyKrV+2uxTI1IFqfpd6mCYRpfFJn81lz6qLUqoRnT8pB+nXuhHiX8GZmRLbTTL88O7wpMe2M71YQkKp8CrVtdHyKE2DgAwxtWGDLdU9BuJ7BkhQu6osyLb6+IeSYrZTSlWU2PjHgdsOoAWbLj8fGP+aSneadxCZM8hVdWhrecJAIHS+NMmtwX8UW7SxJilobj0CyjrpVxrFymkWz5PmUgdMAOGrtO5Rc4h/c5WTs51vJUT9arTh3Y5YQRBW9wS74lah1Mcf+2sSOcb4/zzbnGeqPZXvTp184iW67Tvrak/36ORHF2Ks8OfT
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(921020)(56012099003)(18096099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SEsMnNb8wwA/llN4pZBOP7+XOJA7XKQaPk4LtFwxWx/MwAIeWrT7E2QJGdRiXb6tTsQNLCc8CLTb0D727zZjSN9/jxhZVvbjgrxfUQ2h0SnyUeDYsXN53a5S7qku5I3xXFRQmtq9BmrJ0j13KHTdeYlh/9Xh9zJtRjgK4NpDaMs5NuYIpq5g/nDT9JXrR5pDysMQVUxTw/5cN5UdbgBBGWfesHymsSg8QlMHrWs0+utDwfMbpla9eIbFLm8GieoCbkcpT/HAHa2lJOzupC0Q3XxoHGy1Vx1LemasTV+2/HovRGkaU3ocOVlpEaGTXpGr98BUe+kwsTcl5/tpoKjN6i9SU1N1jqwdzcdJ9E3TD7hrejc0CLpP85OusIHpWUrbxIjYiF2+Zo2SFiMEThag1JFny92yUP4youN3ZA6ikU2iAWs0J0Ol4UU6PTMc8SG3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 13:13:49.2194 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50d1901d-5c0d-44f9-22d3-08de9edea941
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9551
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

Add amdgpu_svm_attr.h defining the attribute management types
used by the SVM subsystem to track per-range memory policies.

Types:
- enum amdgpu_svm_attr_access: NONE, ENABLE, IN_PLACE access modes
- AMDGPU_SVM_PTE_FLAG_MASK / AMDGPU_SVM_MAPPING_FLAG_MASK:
  bitmasks partitioning UAPI flags into PTE-affecting vs
  mapping-affecting groups
- struct amdgpu_svm_attrs: preferred/prefetch location, flags,
  granularity, access mode per range
- struct amdgpu_svm_attr_range: interval tree node binding a page
  range [start_page, last_page] to its amdgpu_svm_attrs
- struct amdgpu_svm_attr_tree: mutex-protected interval tree
  container with linked list for iteration

- enum amdgpu_svm_attr_change_trigger: bitmask flags for
  ACCESS_CHANGE, PTE_FLAG_CHANGE, MAPPING_FLAG_CHANGE,
  LOCATION_CHANGE, GRANULARITY_CHANGE, ATTR_ONLY, RANGE_SPLIT,
  PREFETCH

Declare the full attribute API: tree create/destroy, cache
init/fini, find/get_bounds, set/get/clear, range alloc/insert,
default setting, VMA validation, and devmem/VRAM preference
helpers.

Signed-off-by: Honghuan He <honghuan.he@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h | 144 +++++++++++++++++++
 1 file changed, 144 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h
new file mode 100644
index 000000000..34afafdf7
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h
@@ -0,0 +1,144 @@
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
+#include <linux/interval_tree.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/rbtree.h>
+#include <linux/types.h>
+
+
+/* one fd one svm one GPU so no bit map
+ * only three status for this pattren.
+ */
+enum amdgpu_svm_attr_access {
+	AMDGPU_SVM_ACCESS_NONE = 0,
+	AMDGPU_SVM_ACCESS_ENABLE = 1,
+	AMDGPU_SVM_ACCESS_IN_PLACE = 2,
+};
+
+#define AMDGPU_SVM_PTE_FLAG_MASK \
+	(AMDGPU_SVM_FLAG_COHERENT | AMDGPU_SVM_FLAG_EXT_COHERENT | \
+	 AMDGPU_SVM_FLAG_GPU_RO | AMDGPU_SVM_FLAG_GPU_EXEC)
+
+#define AMDGPU_SVM_MAPPING_FLAG_MASK \
+	(AMDGPU_SVM_FLAG_HOST_ACCESS | AMDGPU_SVM_FLAG_HIVE_LOCAL | \
+	 AMDGPU_SVM_FLAG_GPU_READ_MOSTLY | AMDGPU_SVM_FLAG_GPU_ALWAYS_MAPPED)
+
+struct amdgpu_svm_attrs {
+	/* keep preferred_loc to adapt to kfd API */
+	int32_t preferred_loc;
+	int32_t prefetch_loc;
+	uint32_t flags;
+	uint32_t granularity;
+	enum amdgpu_svm_attr_access access;
+};
+
+struct amdgpu_svm_attr_range {
+	struct interval_tree_node it_node;
+	struct list_head list;
+	struct amdgpu_svm_attrs attrs;
+};
+
+static inline unsigned long
+amdgpu_svm_attr_start_page(const struct amdgpu_svm_attr_range *range)
+{
+	return range->it_node.start;
+}
+
+static inline unsigned long
+amdgpu_svm_attr_last_page(const struct amdgpu_svm_attr_range *range)
+{
+	return range->it_node.last;
+}
+
+struct amdgpu_svm;
+struct mm_struct;
+struct vm_area_struct;
+
+struct amdgpu_svm_attr_tree {
+	struct mutex lock;
+	struct rb_root_cached tree;
+	struct list_head range_list;
+	struct amdgpu_svm *svm;
+};
+
+enum amdgpu_svm_attr_change_trigger {
+	AMDGPU_SVM_ATTR_TRIGGER_ACCESS_CHANGE = (1U << 0),
+	AMDGPU_SVM_ATTR_TRIGGER_PTE_FLAG_CHANGE = (1U << 1),
+	AMDGPU_SVM_ATTR_TRIGGER_MAPPING_FLAG_CHANGE = (1U << 2),
+	AMDGPU_SVM_ATTR_TRIGGER_LOCATION_CHANGE = (1U << 3),
+	AMDGPU_SVM_ATTR_TRIGGER_GRANULARITY_CHANGE = (1U << 4),
+	AMDGPU_SVM_ATTR_TRIGGER_ATTR_ONLY = (1U << 5),
+	AMDGPU_SVM_ATTR_TRIGGER_RANGE_SPLIT = (1U << 6),
+	AMDGPU_SVM_ATTR_TRIGGER_PREFETCH = (1U << 7),
+};
+
+struct amdgpu_svm_attr_tree *
+amdgpu_svm_attr_tree_create(struct amdgpu_svm *svm);
+void amdgpu_svm_attr_tree_destroy(struct amdgpu_svm_attr_tree *attr_tree);
+int amdgpu_svm_attr_cache_init(void);
+void amdgpu_svm_attr_cache_fini(void);
+struct amdgpu_svm_attr_range *
+amdgpu_svm_attr_find_locked(struct amdgpu_svm_attr_tree *attr_tree,
+			   unsigned long page);
+struct amdgpu_svm_attr_range *
+amdgpu_svm_attr_get_bounds_locked(struct amdgpu_svm_attr_tree *attr_tree,
+				  unsigned long page,
+				  unsigned long *start_page,
+				  unsigned long *last_page);
+void amdgpu_svm_attr_set_default(struct amdgpu_svm *svm,
+				 struct amdgpu_svm_attrs *attrs);
+
+int amdgpu_svm_attr_set(struct amdgpu_svm_attr_tree *attr_tree,
+			   uint64_t start,
+			   uint64_t size,
+			   uint32_t nattr,
+			   const struct drm_amdgpu_svm_attribute *attrs);
+int amdgpu_svm_attr_get(struct amdgpu_svm_attr_tree *attr_tree,
+				       uint64_t start,
+				       uint64_t size,
+				       uint32_t nattr,
+				       struct drm_amdgpu_svm_attribute *attrs);
+int amdgpu_svm_attr_clear_pages(struct amdgpu_svm_attr_tree *attr_tree,
+				unsigned long start_page,
+				unsigned long last_page);
+struct amdgpu_svm_attr_range *
+amdgpu_svm_attr_range_alloc(unsigned long start_page,
+			   unsigned long last_page,
+			   const struct amdgpu_svm_attrs *attrs);
+void amdgpu_svm_attr_range_insert_locked(struct amdgpu_svm_attr_tree *attr_tree,
+					 struct amdgpu_svm_attr_range *range);
+bool amdgpu_svm_attr_devmem_possible(struct amdgpu_svm *svm,
+				     const struct amdgpu_svm_attrs *attrs);
+bool amdgpu_svm_attr_prefer_vram(struct amdgpu_svm *svm,
+				 const struct amdgpu_svm_attrs *attrs);
+struct vm_area_struct *amdgpu_svm_check_vma(struct mm_struct *mm,
+					unsigned long addr);
+
+#endif /* __AMDGPU_SVM_ATTR_H__ */
-- 
2.34.1

