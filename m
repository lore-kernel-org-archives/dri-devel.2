Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E67A7FF8864
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 04:10:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0053610E543;
	Wed, 29 Apr 2026 04:10:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uBBAPcT5";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012060.outbound.protection.outlook.com
 [40.93.195.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 840BC10E183;
 Wed, 29 Apr 2026 04:10:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AsW7HSf/RoMQvpVVb4IxJC5S1/8pZDQn76VDyBrVNgatOg0WW+8FpKv/ESSilr+xam+FUInGzxSPYqXEae/Vd+39xT6Miqrgosyk9qLp2oVvQOMpxnzCwd6U29cB/FU6YMxoWzexk4EKAhsQ0Haza/VIVAl6scjYGmNe6lCjbbi9+Tnn33cmtxuLyczaPNRrTub3vx/ZRaXRBcoj9ylhuNCFNmFrGYObcTgUDaCN2pdhI58rQHADPfOWBpfWvo4f8TbSgVCRz4mSu7gic8SRm//acRs2/0Oo+8yuf4PBf23PuLLB94SkfFy7ZLlEfIzT0kkbsuV1XEghhnH5plK5iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCIDU2y580iCEeA0OUmmqS/prgKRJQ/cklFzzR7bFsM=;
 b=afNTpIkJq0gDveWMnK/0ngN2Jucs6h1/90gWEQRpcxz1lyhwJQGBT4X7lunVEa0c5yWXqaf+lwf3dW2L/ddgXPyZ7oQS+U7J4AZ0EehZ7DLYL/BXueQ6fEBH3jDY+nFMVUCYz8NyGqy08eFYooAmAUMIwCFS5X9gK/+erQnnDanuULq+49IXDM/n8vdSqAqfMSAhB3GvhCwXIaLBYGoljwr36MJDnF8mt8dh5hPHLLdkWKHkiqg3qXvQY8R0F4GC8sswCpQGY+tz5wpKAdQ1+8cNFc6pvymb24zibB4kiJpkks+wTTIzRxK3XCXIn5zeV8tJaHlRmZSRCtBCYXOupw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCIDU2y580iCEeA0OUmmqS/prgKRJQ/cklFzzR7bFsM=;
 b=uBBAPcT5gu+uJn/UO0ztJucywK7p6V1y/Bi8cMn33v4rtX89J9tgVvGXYV4UwOoWn8kk6Tq5YQRp+Vki46Ol9zjZ5nTTs9bhVBlCMgb1ci/VTni5ln/5AIdMxDiDsjzSO4esUvQqAexUDqFtjOFr+ntGyTzfu7EbzC6Is0LAEN4=
Received: from SA0PR11CA0071.namprd11.prod.outlook.com (2603:10b6:806:d2::16)
 by IA0PR12MB8984.namprd12.prod.outlook.com (2603:10b6:208:492::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Wed, 29 Apr
 2026 04:10:41 +0000
Received: from SA2PEPF00003F64.namprd04.prod.outlook.com
 (2603:10b6:806:d2:cafe::a9) by SA0PR11CA0071.outlook.office365.com
 (2603:10b6:806:d2::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.28 via Frontend Transport; Wed,
 29 Apr 2026 04:10:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F64.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 04:10:40 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Apr
 2026 23:10:35 -0500
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Apr
 2026 21:06:59 -0700
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <sima@ffwll.ch>,
 <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC V4 03/12] drm/amdgpu: define SVM attribute subsystem types
Date: Wed, 29 Apr 2026 12:06:19 +0800
Message-ID: <20260429040628.853079-4-honglei1.huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F64:EE_|IA0PR12MB8984:EE_
X-MS-Office365-Filtering-Correlation-Id: 274102dd-0c54-410d-4219-08dea5a546c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|22082099003|18002099003|921020|56012099003;
X-Microsoft-Antispam-Message-Info: wZuDDWDJHYqwYiz4QgMgvk0KcDrqJwK2hYs1/71BrR5bBvAjbIGIi/JEaG6rlc/JBoNfzo/aiWiEY4QJbzSLv/nLti8H9PAzHG0fs3Dgv3OgXCYNiZZLCGMHBArlzioTgDM7trKSSzXbL5d8hIpnmPzRFeCDRRRzr0TfmcZ/Bt3P7Hge+PhCnniZj+kil776c/JGm6ylv621Cdn45YC56HiFfZqz6M0pDcT9W5DEudPgiKi5O1ZxOOZ8qeuXHD7kBpfYcodOZt6uzAJRYTEyhgyZR5rpfS8DhvAykTtrS3WiS//1ysc/ew3DW70f8jFPr+dAYsFMJFkOpSsP1/NvcBvcWYycyhNbwWdAHZNbwO2UgrlH7nCr/1YeNaYCBwGPpFmBeV+Wmw0IS6sfM5cDze88j2FDpHwlBdmz+ERjOJXTR0jQ/JcEBBi1VM76sB9xhuAiOfS9l9hHPRgPCjypECsgmWknooiV4QBzeDNWiRWDMmNkSk6z7GFoJXJaIECnw5nGvNw3ZtaLqpAqvX0souvW4UtRVsnqeSFmlOzO1T7vSnKz+fHkXViFq1yG4PSAyEDejP2z+0f9Gu5028j19JfBcAjWL2aEyMpP5L1hZucet0eeXFQomzNNRZEkckJFpzkk4AKiQkwewEAPYyQdvHtS8rNyunay46Kngbgmwgd/sZaESXAeG7TBzybccRHI5uc6QOEEd0kTup2T43jNViJNsiDT73t9IYwIuYtcVF2h4RJjMVNo4ydwnWAtKUDtvOVlxbIBW9AAgrFcXDJBVJibTBSNr3nYXjRKP2gKfYQukDfpuRZkqtFvP5ITu7/B
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(22082099003)(18002099003)(921020)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: y8e+uKUEI0wcBFRIzSY4omV+qyV0pICsEJTKY1+Vvr1u90Qi5OCHxFRlZveebysV9mUJ93l7TzmKXIQ/QX6cXrsDjVXPRc24iFhPrNWy/txRFUnl8rk+T5a1PY87edYBguHs2l78H178ulgMYLRSSJvAi6wVrKbVwynIvAq3wFMDLjxFZavf07Do/o1e4ec8apE23uonKOHuUpL29k9sD3hVaGqITnIWBFbtLoHdIVUx0pLr1QLa8hcxasAfHLCaMr4gGqTC0cBS51bcrfSE9VSsdHAQW4mlgJkyQ7mZY1Z13J8IMjQQNrOaR7NqRb4YT7Kt0c2xvZ928qf60fg8yYuznNB/5Y1sSKg0L/5CttBnzGUl9WD7cHPW8lkboTG+kyWqIy9jcVO//NKpE790IAxWv/M/dsThknlnFV4p9/+I8oCfUj9X56Sii/KOjKQ+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 04:10:40.7859 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 274102dd-0c54-410d-4219-08dea5a546c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8984
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

Add amdgpu_svm_attr.h with attribute types: access modes, PTE/mapping
flag masks, per-range attrs, interval tree node, attribute tree
container, and change trigger enum. Declare the full attribute API.

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h | 144 +++++++++++++++++++
 1 file changed, 144 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h
new file mode 100644
index 000000000..026cb8a63
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
+/* Internal SVM attribute bitmask flags mapped from UAPI ioctl definitions */
+#define AMDGPU_SVM_ATTR_BIT_HOST_ACCESS			(1u << 0)	/* AMDGPU_SVM_ATTR_HOST_ACCESS = 4 */
+#define AMDGPU_SVM_ATTR_BIT_COHERENT			(1u << 1)	/* AMDGPU_SVM_ATTR_COHERENT = 5 */
+#define AMDGPU_SVM_ATTR_BIT_EXT_COHERENT		(1u << 2)	/* AMDGPU_SVM_ATTR_EXT_COHERENT = 6 */
+#define AMDGPU_SVM_ATTR_BIT_HIVE_LOCAL			(1u << 3)	/* AMDGPU_SVM_ATTR_HIVE_LOCAL = 7 */
+#define AMDGPU_SVM_ATTR_BIT_GPU_RO				(1u << 4)	/* AMDGPU_SVM_ATTR_GPU_RO = 8 */
+#define AMDGPU_SVM_ATTR_BIT_GPU_EXEC			(1u << 5)	/* AMDGPU_SVM_ATTR_GPU_EXEC = 9 */
+#define AMDGPU_SVM_ATTR_BIT_GPU_READ_MOSTLY		(1u << 6)	/* AMDGPU_SVM_ATTR_GPU_READ_MOSTLY = 10 */
+#define AMDGPU_SVM_ATTR_BIT_GPU_ALWAYS_MAPPED	(1u << 7)	/* AMDGPU_SVM_ATTR_GPU_ALWAYS_MAPPED = 11 */
+
+#define AMDGPU_SVM_PTE_FLAG_MASK \
+	(AMDGPU_SVM_ATTR_BIT_COHERENT | AMDGPU_SVM_ATTR_BIT_EXT_COHERENT | \
+	 AMDGPU_SVM_ATTR_BIT_GPU_RO | AMDGPU_SVM_ATTR_BIT_GPU_EXEC)
+
+#define AMDGPU_SVM_MAPPING_FLAG_MASK \
+	(AMDGPU_SVM_ATTR_BIT_HOST_ACCESS | AMDGPU_SVM_ATTR_BIT_HIVE_LOCAL | \
+	 AMDGPU_SVM_ATTR_BIT_GPU_READ_MOSTLY | AMDGPU_SVM_ATTR_BIT_GPU_ALWAYS_MAPPED)
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

