Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB33ACD5BD2
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 05:48:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A50810F8EC;
	Fri, 29 May 2026 05:48:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Gl0aOl7y";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010014.outbound.protection.outlook.com
 [40.93.198.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D6BB10F8EB;
 Fri, 29 May 2026 05:48:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iIXuvmyr0yAwqyxhnsINA3dpvRuwPpkykpHgQUwi/M7cui3/DB/Wym54EFaSCbYRyxGJSo4isjVpDP3FuCoUx1gGeMfq53whChZW7LIP2aIK59DgraJKDNdXR5XXIxrwvGyKuPxMBUxXxOIZstlBjaURCHD7oVpJh9BwIqVkuPgsTCiVJ7Tdogeyt96JNTiovhlMzwsJ97u2d8/uJBI3+pWZq9SeP8Vp8FeGoh3upjYLEA612dga7tGfS0SbUIezL58Mj37WIzZT4ZW6lvJeMTovwNO5DB1BOvWFXhambnC9TJJwN1RHyu5LrvbkqZfL4MiOXBGsMcoS8Tku80qLWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6lQXMQXTQapKZrzYqfaIfGwAYlsku7xsbUIt8uVxzlU=;
 b=TUaVNT41gi6VZwzCP5zsbdP5OCbizpZXlDaW3h58KJDSHTg5q5mFteLo4rCrd+/FHuu4QTfNflxdVtIxuhS2KLlpyvcmroxyQbY4nU5bXSa6dRCHv5xQmOho4UIDoQviTVJ+8fgZ8Nvei3ie+fy9dcxNbCqxFkvWVNDkbkOyaDXwIn5vGGb3kdgOZXuc223vbRUTzMMU3cRU0Ca+oc24X0HRNGzI5ZjpLpwrbUrUsDqK9qHevtXKNeKf1ndnCUmKg7gE7wW/ekZwu4Uobl75+hbIAS06z/8Qk3vNOF2I78//cXrlCZBdaMW7fWac/Bcwa5OCltJUaQOEBs/4l3S6bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6lQXMQXTQapKZrzYqfaIfGwAYlsku7xsbUIt8uVxzlU=;
 b=Gl0aOl7ygZfwQ+jS1dLRtE9MrD39611UKyMKPmmPazrZApdogngKg4rdMzf39oRZOOS34rHl2uSQ7L5IjQ8hRk8zGFZWpN2ZUOcOAL+6U8/YipVXhtdYcDmRWsjcefxJBT7iuY/KX9XlbbCbh0J+yLAvCJLUoVk/wr+nNe9ncgQ=
Received: from SJ0PR03CA0215.namprd03.prod.outlook.com (2603:10b6:a03:39f::10)
 by CH1PPF16C2BD7B0.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::607) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Fri, 29 May
 2026 05:48:36 +0000
Received: from BY1PEPF0001AE19.namprd04.prod.outlook.com
 (2603:10b6:a03:39f:cafe::93) by SJ0PR03CA0215.outlook.office365.com
 (2603:10b6:a03:39f::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Fri, 29
 May 2026 05:48:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE19.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 29 May 2026 05:48:35 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 29 May
 2026 00:48:31 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>,
 <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC V7 03/12] drm/amdgpu: add SVM attribute subsystem types
Date: Fri, 29 May 2026 13:47:55 +0800
Message-ID: <20260529054804.596214-4-honglei1.huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE19:EE_|CH1PPF16C2BD7B0:EE_
X-MS-Office365-Filtering-Correlation-Id: c8fecbd3-16b4-4cc0-6191-08debd45ecff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|11063799006|6133799003|18002099003|3023799007|921020|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: HkEXl94WLWvLdMLExKsOD6JtW5zNDFjiIuPT98FLLnOeezXLd2b4YgqNTNGuBktyCB3q3g1e6aat+uCmhtYsb3pXSLwu22ls7xanstp1PXsvba16Mv9GiathhH23+D8gFrlweYJsBUhYRVwZpPDZkNnQ43qmYWDpWpthzP9+19q6PtzshpBTZpMK/2HmKUeQs0HqjWbujAL78UmnYCNJDAKbO1FkKnIHEFLTQteg7A1jyrpMwO7ZwjKJFxv61P1nSYzwSlOAQRZ299Cr9tgCnhMx1DOmfQ4YkBJoW64XgsnYcaA34EUWIyHu3VRXFk+BdSrN/ipnlAo4m4S5N9+JJbYOSZcPuNmX2HxW3X2DEijDSL6LrPkW9PnWtIsGP0k6/cBWB3p4PfUfSFZwVKDWXQHKKWtvb4sHIroFHBv/FEqVtwu5KhlRbtbQCsb7ErN4TtFzRpeUxb1w8B3jbQTbgf8KfeT/+KjPFAMNEF8UZnSEdOevOrKUQSBxoxaXxMKoEtY9Lr5Ah0kNzh8TXEs16dn1gZ7rNr33FY90EF4HulbsClwwfiX8vU29opM8DgKIgMoqOyVIcdq8sPXLqlAWNhVr1r9ck61vfL3o6w3Vr6t30dQxvxNP0IUWT9y/c1pRsN5tcB+dW0x8k09/1oYS51OBThTNcCHAMIspN4JMQLTlvCQA9FY02uxfoxqEznOoPptwE+KKo/ndvdngMEImI/jKRWoJXsAIGZchKLzzoNMWnGGYlGasRMtdWjsdRLQkqWzRsYDnRyCSd27thE0g8Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(11063799006)(6133799003)(18002099003)(3023799007)(921020)(56012099006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fMILLdmR68khNxjim4UH/stiiq4tT2nLH663+GnEGF0hmGoEvmiGLKPjn2n1twnE1Wzmu31YGTc9wLn0gcHXrVnpKil0kk6W1baQ02EZAUpgHe+To4n/gZ+kLKYDLrzrfwvHD2MgyQlkfaKXXL2FcF8WX/hCgDzlq0n5LxMKOinQYhsAE0qZpYRuu2o84raT9NNONwEIFN44CcYbPOStv7eOKGtB7IZllWbT4+V8WDNTFM7LWWq/dxQkSuqfpwHmKBO4FowF0k2+iQYdTyN8H8v9i9jS/QP0r2b54zs7fcFT4nsS8n1wJDDRTOPz4teuo62uXl/auCVk901x6PqBWYslUXvxPc3Uqy6sBp2JK36BsZrOWCQUrixvHkqpZsN/Hw7ujo+4aWkTlDffwJ+4jJ9W744xmyYtvty0ouETBx/NhiEPBJ/2ohCeGy3M7lz3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 05:48:35.8480 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8fecbd3-16b4-4cc0-6191-08debd45ecff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE19.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF16C2BD7B0
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
- struct amdgpu_svm_attrs: per-range attribute bundle (preferred_loc,
  prefetch_loc, flags, granularity, access)
- struct amdgpu_svm_attr_range: interval tree node with attrs
- struct amdgpu_svm_attr_tree: mutex-protected RB tree container
- enum amdgpu_svm_attr_change_trigger: change classification flags
- Inline helpers for range start/end/access queries
- Full attribute API declarations

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h | 174 +++++++++++++++++++
 1 file changed, 174 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h
new file mode 100644
index 000000000..d8eedf578
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h
@@ -0,0 +1,174 @@
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
+bool amdgpu_svm_attr_devmem_possible(struct amdgpu_svm *svm,
+				     const struct amdgpu_svm_attrs *attrs);
+bool amdgpu_svm_attr_prefer_vram(struct amdgpu_svm *svm,
+				 const struct amdgpu_svm_attrs *attrs);
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
2.34.1

