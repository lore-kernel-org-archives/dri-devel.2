Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 600A4F36C58
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 12:08:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB47910E53D;
	Mon, 20 Apr 2026 12:08:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0q3PwXBn";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012039.outbound.protection.outlook.com [52.101.43.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 731F710E536;
 Mon, 20 Apr 2026 12:08:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nLIt5LXjPrvtyUNqypNruBBm0RkZhfHeHrcBwLpt5ByYpfonId+gALTAoeLGAh43vUCS906vZHqGFahydZjcQ9VvRZJd/H38sGpCdKBOqXT4zImuW3ybiGNXz18uzEfx4YGr8nT1p+SlC4HaUXtlLyiDK7mqFuLxhyDEjqwK5PGxrzTdJk1PbGlxzz65VFFUWU1hNRa1XRKLMGHKRwNpPht/WpdtMM3NlHY/0nrsJo1qdcBfCmaDhoVEmfjGAZEbdAalcBnymKmGp9sK5PSy3bgy4fE8jOVOhNKIquZxvLxWnstQtrMTVgLX7FpHoHnfV659q3N4P405euxCVCyHDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LvjuHU5Q7zpKXH93iTqz2cZbjaWcfEyCLlAuzCK4VI4=;
 b=ft4KT/8FxMXePtOoHgYEnvl1S0LXLqh5Ew2gLoXFJPZAC7ATukBrjbHzgs9/DmxS5CiB4tb6J49sVo/5tNvhrhy8OS31WZPLrTKYfEIIdD13IHoSj/A8chbW7zVRz5iOQ7Fl2lD5JSzHDPK0ZIrE0x6PHgIFdWWjCo4ccjP4A2w4YjiLmVrNBgqsshR2QWvEiu1rB/PgQ8Xa24sBcOzl3xezfZgiJ0ByaRqkgt1m8SK/js59qyscalIQvVfM0SbcpSLjfFCcsp+Rbi31wj0WTalszeu5ZdeDerThIWjkUYgXtWTBRM0XNmRzIsWjDal+DoSJvJ4KykVAFz2j4TFZAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LvjuHU5Q7zpKXH93iTqz2cZbjaWcfEyCLlAuzCK4VI4=;
 b=0q3PwXBn+eygU2KWkQEUCIq2p8jYUYRX/SEMZRiI2OlVowA7saCn9B1nqYkJKS2LDZxUh2s5B+uKHKzdDwfwfztC/Jt8+RlaZKDtH8rDsvzpOixBiuXS3Z6HRTQq1NwAkLX3+LFKtXzaKEs4oObf11RaSWPDH1d1qJr6+xCWhIA=
Received: from SJ2PR07CA0019.namprd07.prod.outlook.com (2603:10b6:a03:505::21)
 by PH7PR12MB9175.namprd12.prod.outlook.com (2603:10b6:510:2e6::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Mon, 20 Apr
 2026 12:08:14 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:a03:505:cafe::82) by SJ2PR07CA0019.outlook.office365.com
 (2603:10b6:a03:505::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Mon,
 20 Apr 2026 12:08:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Mon, 20 Apr 2026 12:08:13 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Apr
 2026 07:08:09 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <matthew.brost@intel.com>,
 <rodrigo.vivi@intel.com>, <thomas.hellstrom@linux.intel.com>,
 <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC/POC PATCH 03/12] drm/amdgpu: add SVM attribute data structures
Date: Mon, 20 Apr 2026 20:07:30 +0800
Message-ID: <20260420120739.1811731-4-honglei1.huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|PH7PR12MB9175:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ee32f60-6591-427d-08d5-08de9ed57f8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|921020|18096099003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 8Z2FcSchOMT2zBpjQnNU8HMkcQux7VbloOGJKIYFvTr8LyhzOhdno3NUTcaFX7TU1T1ep/9rmpPADxliC8i/pBYb9U6kNZhtf32QdUSsOalODaFAg8VabTgn0qc+rIUYXqC5QpR/iU4MiQ+DpEqLKL3++jFOvPaN9NFGmzzJY7XzX0gDgDmlXECu1dkNYb8mVKUplrXSwOkpsTs10x2ikeSOsGR2HuD0el7rWqMqsEAVQ94xe7WMdcCaqlOA+VUKpdJUu6h7SDfmrVpz+XtuWNKYUfjD6A6ea2bMZWmsMtrL3+1ie7q6sYAZOq8VxzMJM/RXzNbJlsz5gDOzRsMbI67R/9os9ngD/JSgU6u2D7get2JfA4H4h9UE+xIWfVQsk1ucRlKLiqHzR98H/ip2yft0i0EWsScDlZ4riUwWHSOZ4VE530k9NkpLRUQXnaYJQ7y6eOqUKxu5ZMZdCvWow2Os8dB8IkOml4KnZ/nhH1E2OukQSpMi/SXY73o1oGhgBHqumLnxMgDAsq1EbRjZ9FhhK7iWrsjQncnlLk+zYgSwhOIw2K7kM+X0ca1gP2u/hU2JF23KxGhafdk9W4IgcprKDTNzspsAG6SIi+FIajgeNKLjWcTIjk3lIdrv40kqauqn4Sm8f7ix3EHokWmO+MSEUkKtWKy/IMv7sqx8BamkIvdiC0DwspzObYLDuuSGMJH2F2TM5ZqpquFk/AITqFBn4JaOUl8/QNxlkbIAZaOyHpb+CIHFj8s6K+a8mwljP3ufnZClJfydHfr65qkM9fulyAyq5Une0j95khY5K5LXt2DC98h3lJYMmI7dek4y
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(921020)(18096099003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SSHw3iKZM7jfo0WP2bBchli66hLPNxxA7on3JAjFE6IrsxeHDzMmMteMFq0uyOtx3aWaX3aKRoA1HI9J6FA53Ge+JmPBBWpRB6fL7N84RlJdVBGDqbl9wLhE4uOS5iN/uNVWPxMDArzZgoXF1QBLEOJAbb1GyDfZLppDt4A4hKsghTCODZJkFChsuhhRa0veF3sLpVNXEZcRA1NOSyTRDsdRwuHNVBLa0Q5uKHLr87zAw0+mLkmoRLUR0enTbzdG1FtbPwlICGykIBNvkjiCOvWSZxazDorm7cPIwsJY07pXObjQ6n4cWq4yLvTXDojbteyAK7wTeUmfidFWx9ch0jhwWW64rVRB7FDhBRNTLT88T9AJi5/GRPTyzP+Ic5TF4JYBjoyr96nXwDapZr8qgYKDUPH1CghhsgN64K9SvD4ADmro6cO92DmZeC3aMn0S
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 12:08:13.7273 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ee32f60-6591-427d-08d5-08de9ed57f8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9175
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

Add the SVM attribute subsystem header defining:
- enum amdgpu_svm_attr_access
- flag masks for change
- struct amdgpu_svm_attrs spereate with drm svm range
- struct amdgpu_svm_attr_range: interval-tree node
- struct amdgpu_svm_attr_tree
- enum amdgpu_svm_attr_change_trigger

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h | 110 +++++++++++++++++++
 1 file changed, 110 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h
new file mode 100644
index 000000000..d49f6bb72
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h
@@ -0,0 +1,110 @@
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
+struct amdgpu_svm;
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
+	AMDGPU_SVM_ATTR_TRIGGER_ATTR_ONLY = (1U << 5), 				/* no changes */
+};
+
+struct amdgpu_svm_attr_tree *
+amdgpu_svm_attr_tree_create(struct amdgpu_svm *svm);
+void amdgpu_svm_attr_tree_destroy(struct amdgpu_svm_attr_tree *attr_tree);
+int amdgpu_svm_attr_cache_init(void);
+void amdgpu_svm_attr_cache_fini(void);
+void amdgpu_svm_attr_lookup_page_locked(struct amdgpu_svm_attr_tree *attr_tree,
+						  unsigned long page,
+						  struct amdgpu_svm_attrs *attrs,
+						  unsigned long *seg_last);
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
+
+#endif /* __AMDGPU_SVM_ATTR_H__ */
-- 
2.34.1

