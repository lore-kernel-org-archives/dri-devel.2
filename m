Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B4ECCD4F2C
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 09:10:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7127110F373;
	Fri, 12 Jun 2026 09:10:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DAzkjnVX";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012003.outbound.protection.outlook.com [52.101.53.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF1CF10F372;
 Fri, 12 Jun 2026 09:10:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KvhCmYaIfXuBmC00qFFIWDEoNGN/YWq/MRC1n/Z3P3Yvik8jSu5MUDqyMf90fqcZy9bkQMRkEUdQQvp4oZWAGyKL9RZo/hRfTjeC/uCvbPC6TKsXyEqZRHy8oiFyNqfLNeUZwfOMNlDzwiT4zzMkRMEaJ7riE8Qr0/fT8pXg4Y4jw1iaEadPZ/cupQ1poXlZWVqmj/Sz4YEQhJcE/ZkXZ1ikmRjyz5EdJaFDDqrUAsDtPVeN2f5kyb7yIL6h6fXm/hze60ZTQxjHuAdncOHVRfrIS5mMqoracG0JKqkwtrhs4VxcAXUABR33hdgZ05Xus8OHfniceaW7EkUqq1/RLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vNrwlhnhurG86MMtANIFSqwFUor1IbpFuH8CBHDPyd8=;
 b=DkZazR2mQKl54yZk9JRLmkd1RibEQpNxm4tWAoVc0xOSfpZ05813fUOHx1v1ekcWZOikMkP7BI+iss1h4cl5RPGrflQqIGuMvNfoqlhFICGy3Sy2bDlzpPXldqaKpwHuuBPZcHu8Vr6vK8wHOoNkE9sS0lDOsUZDEG3pMi7tiNcpWk2XKqo+i7cH6SOavwq5bkDGa3PDYQoRwgH1I8NGIqMW8G/MQgtjTTcoG5H4w1LyXMdKzqDRmjjdZkoGXr9kTudScqke8nBjvmEhQwXdaDk0xrhkG9hnwvAIHRRs7AlnRiM8Q/pkcMZLeURLm2TfXvO1lDAfkbRq2/HVU+YZaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNrwlhnhurG86MMtANIFSqwFUor1IbpFuH8CBHDPyd8=;
 b=DAzkjnVXmx0YsoJFfb41V1aZlTS2ZrpXCzG4zYwK4K9b8O5HYseU1dkx4Dbhqol0frH263sYcbA5MPnLNHW4ihrHRSTWFLbgBQ8WKeT2sOjwfmetz5iWRbkRyQT9QQ/idqm/CfTi6hW7kngH94pBtLm6J1sC26+tNDCjf2VVVwI=
Received: from CH5P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::28)
 by DM6PR12MB4219.namprd12.prod.outlook.com (2603:10b6:5:217::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 09:10:16 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::85) by CH5P220CA0022.outlook.office365.com
 (2603:10b6:610:1ef::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.15 via Frontend Transport; Fri,
 12 Jun 2026 09:10:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Fri, 12 Jun 2026 09:10:16 +0000
Received: from hr-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 12 Jun
 2026 04:10:11 -0500
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
 <yiru.ma@amd.com>, Honglei Huang <honghuan@amd.com>
Subject: [PATCH v8 03/18] drm/amdgpu: add SVM attribute subsystem types
Date: Fri, 12 Jun 2026 17:09:05 +0800
Message-ID: <20260612090928.29682-4-ray.huang@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260612090928.29682-1-ray.huang@amd.com>
References: <20260612090928.29682-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|DM6PR12MB4219:EE_
X-MS-Office365-Filtering-Correlation-Id: 99d33d7f-921e-4411-fd7b-08dec8626b33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|36860700016|376014|82310400026|18002099003|22082099003|921020|6133799003|56012099006|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info: W2IZdefUrnc0FkNcONp0hVqZ+4OnYwOhGyJytl9vptpLF5O3DAv8tPNpTX6b1NsPLrTeqgT3OMQ4Pc4D2siW1a5Whgq41PEbWN4InDtDtkajbwTYokq1ofWwsehUZ38wJQJnu2+pKt60ZH4hC8Fwkekb7UYaEY5wO7rrajlq8tjZ+QkAUYDkjQyTp70SHYoXEm5PDIASKTHWWdA/aPCaBYHv/+gAxCxyhsFW9iKkMj8AGBhFEngkeTaYhqqGHpQQDCMCYgH6Jm6Av9DOYGrOya0EpHuWF5upeZrqrma5XxNyGEVX5kg/3s9b915kICyH+UBEOItUerNC+2vj9u+zF8NcBh0Y18juYtnGI6i01+B9GyIc1QtgNMXKV3cF2M7Saxi1UIZ93Ko2nA3tw2uaa7Q8I6fM/x/p6vy38wW4B5Th454615dhS25Xiz/XWNPquJw1+iabMcjSrUDYyuiIP82WRW/WGW2lukYDoRLSiPn84aLoTKRj409MPLwmfAQ1+vjo4iWQ0rIWYcDf/etOvTcTYaV6+GNAhCa08UWlV+320ELQ6uI5fGxAZi3KlIv6K/qC3gWivSgOCmFTohGCNN351Et9IpE3ibQO6UHhj12vHwBrbqJKuCsuOpmzANBXyTnuCqtP95GVAZdROU9j4RB3KfKSobzXB1M4pimcae6xNYO1mdEabxTR7g2ukNE+Piaj8iUkS0hy8+9aYrEVolsroFT4c9ncCnLaz0z1XFcCYb/jaRtBLcU+d7QRoHGHQS1l4VK+aEJgmnzEjXS47g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(36860700016)(376014)(82310400026)(18002099003)(22082099003)(921020)(6133799003)(56012099006)(11063799006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: skZ5Gj/2ZaqXjQ6/aI0Nfom8X5+ZiLkgKVetPxQAXnuI2+q2nwFyB75y9Y3KDHnImRbGlw29Rxx6qY+ME8XQA/YwZ+y1ofucSd42EWPzGP7112JfoUTE3PjJancclDScWwR2FpylTv+N0T8KrMiSe6m5nht9VNEzNyKRTT//Lx56+XtO4fuU4nGzk4Opc+bGV4HSx6hbpLPXhNzwdcuwF0E03CfhlltFCvTseYgKW4nz6ftOC6jCKpO6PZNThN7jQDk7Lekw/ahP2QCngIBTrH6Ab6s7qnUBK58IV1P6AUdIxA4RUVYb+/sHCM7Midg2DMUmKTQ9VUshzY1P8bxl1jvBG9khfzyVm7pv3sk8aT4KMRe6131yDsOP5m+Spim349Jqcl7Ux4CbrvjaG0FeFOk79FuUQ+c31zUd9PpM5CmxAk+fVb7qiES0du4Rd7RR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 09:10:16.3533 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99d33d7f-921e-4411-fd7b-08dec8626b33
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4219
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

Add amdgpu_svm_attr.h with attribute types and tree infrastructure:
- Internal flag bitmask definitions mapping from UAPI attr types
- PTE_FLAG_MASK and MAPPING_FLAG_MASK for change detection
- struct amdgpu_svm_attrs: user set attribute range
- struct amdgpu_svm_attr_range: interval tree node with attrs
- struct amdgpu_svm_attr_tree: mutex protected RB tree for store and
  search
- enum amdgpu_svm_attr_change_trigger: change flags of user attributes
  change tirgger

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h | 171 +++++++++++++++++++
 1 file changed, 171 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h
new file mode 100644
index 0000000000000..4181ec3bdb046
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h
@@ -0,0 +1,171 @@
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
+/* Internal SVM attribute bitmask flags mapped from UAPI ioctl definitions */
+#define AMDGPU_SVM_ATTR_BIT_HOST_ACCESS		(1u << 0)
+#define AMDGPU_SVM_ATTR_BIT_COHERENT		(1u << 1)
+#define AMDGPU_SVM_ATTR_BIT_EXT_COHERENT	(1u << 2)
+#define AMDGPU_SVM_ATTR_BIT_HIVE_LOCAL		(1u << 3)
+#define AMDGPU_SVM_ATTR_BIT_GPU_RO		(1u << 4)
+#define AMDGPU_SVM_ATTR_BIT_GPU_EXEC		(1u << 5)
+#define AMDGPU_SVM_ATTR_BIT_GPU_READ_MOSTLY	(1u << 6)
+
+#define AMDGPU_SVM_PTE_FLAG_MASK \
+	(AMDGPU_SVM_ATTR_BIT_COHERENT | AMDGPU_SVM_ATTR_BIT_EXT_COHERENT | \
+	 AMDGPU_SVM_ATTR_BIT_GPU_RO | AMDGPU_SVM_ATTR_BIT_GPU_EXEC)
+
+#define AMDGPU_SVM_MAPPING_FLAG_MASK \
+	(AMDGPU_SVM_ATTR_BIT_HOST_ACCESS | AMDGPU_SVM_ATTR_BIT_HIVE_LOCAL | \
+	 AMDGPU_SVM_ATTR_BIT_GPU_READ_MOSTLY)
+
+struct amdgpu_svm_attrs {
+	/* keep preferred_loc to adapt to kfd API */
+	int32_t preferred_loc;
+	int32_t prefetch_loc;
+	uint32_t flags;
+	uint32_t granularity;
+	enum amdgpu_ioctl_svm_access access;
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
+static inline unsigned long
+amdgpu_svm_attr_start(const struct amdgpu_svm_attr_range *range)
+{
+	return range->it_node.start << PAGE_SHIFT;
+}
+
+static inline unsigned long
+amdgpu_svm_attr_end(const struct amdgpu_svm_attr_range *range)
+{
+	return (range->it_node.last + 1) << PAGE_SHIFT;
+}
+
+struct amdgpu_svm;
+struct mm_struct;
+struct vm_area_struct;
+
+static inline bool
+amdgpu_svm_attr_has_access(enum amdgpu_ioctl_svm_access access)
+{
+	return access == AMDGPU_SVM_ACCESS_ALLOW_MIGRATE ||
+	       access == AMDGPU_SVM_ACCESS_IN_PLACE;
+}
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
+	AMDGPU_SVM_ATTR_TRIGGER_PREFETCH = (1U << 5),
+};
+
+#define AMDGPU_SVM_ATTR_TRIGGER_NEED_INVALIDATE \
+	(AMDGPU_SVM_ATTR_TRIGGER_ACCESS_CHANGE | \
+	 AMDGPU_SVM_ATTR_TRIGGER_PTE_FLAG_CHANGE | \
+	 AMDGPU_SVM_ATTR_TRIGGER_MAPPING_FLAG_CHANGE | \
+	 AMDGPU_SVM_ATTR_TRIGGER_LOCATION_CHANGE)
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
+int amdgpu_svm_attr_clear(struct amdgpu_svm_attr_tree *attr_tree,
+			  unsigned long start_page,
+			  unsigned long last_page);
+int amdgpu_svm_attr_reset(struct amdgpu_svm_attr_tree *attr_tree,
+			  unsigned long start_page,
+			  unsigned long last_page);
+struct amdgpu_svm_attr_range *
+amdgpu_svm_attr_range_alloc(unsigned long start_page,
+			   unsigned long last_page,
+			   const struct amdgpu_svm_attrs *attrs);
+void amdgpu_svm_attr_range_insert_locked(struct amdgpu_svm_attr_tree *attr_tree,
+					 struct amdgpu_svm_attr_range *range);
+bool amdgpu_svm_attr_prefer_vram(const struct amdgpu_svm_attrs *attrs);
+struct vm_area_struct *amdgpu_svm_check_vma(struct mm_struct *mm,
+					unsigned long addr);
+int amdgpu_svm_attr_check_vm_bo(struct amdgpu_svm_attr_tree *attr_tree,
+				unsigned long start_page,
+				unsigned long last_page,
+				unsigned long *bo_start,
+				unsigned long *bo_last);
+
+#endif /* __AMDGPU_SVM_ATTR_H__ */
-- 
2.53.0

