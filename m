Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D8A8FD8744
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 11:30:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D00B610E605;
	Tue, 17 Mar 2026 11:30:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k2WvHzy1";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012038.outbound.protection.outlook.com
 [40.93.195.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79A5B10E607;
 Tue, 17 Mar 2026 11:30:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pmkTDbiv5BmGgT409cmsRH4GpyvU+087e+LtElBcbKd8hKAVxkYbXKDLhtYtSaTzUHZnsLrZHxrVfqy2DVbYaxKXkdnsBl9fLE/0yplNbVXB2auRB7xjQt54cS/M1IxvgTgeqVi/iexW5GboT1cSmtN/CwD80SdJHfg8wEMohVajOOftOAiUtcgh6RElsTcEhp9HrkjlX/fz/RLIgss7VUceR903sJa1YIeDwtRb3sb0mlRMWNx/jwrnn2hnbshwe1GpTOqeXExT87Fru/UtuABgn+m+H7lX4ceHbrxIw7Z0BVPwLDpSnyhYd3XvnS5s8kA+ChZVFzdrTbTfO38Ung==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LvjuHU5Q7zpKXH93iTqz2cZbjaWcfEyCLlAuzCK4VI4=;
 b=Jc6DPU0EHuOaTKp+kWv3Zc/pK/iU/UGzFHHrDnaOFGYk/V8fLiLg6WlErX6OLDs+voxzDm+VVeb2aiUUC41IDFVtkee01ec3BxMml59+ti+WkIu49jU4iMeExUcmH27kNoaQu1+WGOt0yxCoGaN/IgD/CizcWjpltQVQhyJco8Nry+v7oRHqTClIdwIVycAcOpqLYDQ+B82s9vE7LYcbaxQpiOHyK3vDPnqvvCXBvuKj8YDgYABpLzTj/xk8jHynNJYxHUQAf6nOlRMP9iMXZRFde6Vpb+Y9H9dLlzqxNODKR4GqPCrKkog8nvcYG4erht88kOY7fUziv5VClFUKmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LvjuHU5Q7zpKXH93iTqz2cZbjaWcfEyCLlAuzCK4VI4=;
 b=k2WvHzy1BV8SFAmRlQ2oc+p0TDCmKmQVrYUwH9qnVUqgos3h1YXQiMJWfDLcRTXJB38OKyKbpJcVUGwSPPqsmUnymTKO80/RhZn7F5IHaZgw9D+MuiLQ76dg2PwJHFTr6c9n4qSiETNC672OP1jVZngIObMvOGMoztrFi9i84S4=
Received: from SJ0PR03CA0282.namprd03.prod.outlook.com (2603:10b6:a03:39e::17)
 by PH7PR12MB9222.namprd12.prod.outlook.com (2603:10b6:510:2ef::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Tue, 17 Mar
 2026 11:30:25 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::9b) by SJ0PR03CA0282.outlook.office365.com
 (2603:10b6:a03:39e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Tue,
 17 Mar 2026 11:30:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 11:30:24 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 06:30:21 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC/POC PATCH 03/12] drm/amdgpu: add SVM attribute data structures
Date: Tue, 17 Mar 2026 19:29:49 +0800
Message-ID: <20260317112958.2925370-4-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260317112958.2925370-1-honglei1.huang@amd.com>
References: <20260317112958.2925370-1-honglei1.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|PH7PR12MB9222:EE_
X-MS-Office365-Filtering-Correlation-Id: bb69d020-4468-4b37-92d8-08de84189513
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: sP/3QGyj2jnQ3AyLiBoGY9OdvXN/lSjfaDzb+xxf08yFMZt4Y6M7A7uKn9FH4EUnjEDkvc9x6LBCnlOG/aBYJouyQYIe6Yt8bb7LoIHBvipY9ilt5ZqyUEIQXv9sdeo863mdIrm3aJYtFtFcZFbVkIQE/YKkVVBwe6OmTXgyi4xVJk5NVMonMWUtD5nIyP6p8PHmAHaQg9xw4/sfuwIdPrKliyJzYeCQzDQ+4rO+7POv2y5eanOMTlaZl+t3btvsIkhv4J8x64dRQsk5cA6HBwkLFcx6Uw8HGQRrc59jSuSNxU9ifcJXZ9Z7TQiAQGsnfpCSRPIWBfvvcGQ5fR4LlXPVYCW9VyMQXnHQ2n8FkFi/9Gkw0CMlJsMRBSpZqh9f7UCfYD7ynHyNZmpoF2SNom+U/lm/ZRmJEpFJ3s0S8AYjNQCyFVA93ea8Fki1mH6jWg6NDgXoSz6xiIwYgHP0ckOHin16xWXHAIVAGeB8+07jEMYSq3VxpW8MRhwreQhcLs3KBtHdUDxkTMJsi8WABYr8W1r+d9XSgcm1d15uBMLnzhyFisR+X66zZn7T8aSOTCNjBYOw7diEHRBXAxyx9AsU09jxJVJHtL3DgSvHdOQn58zNnQoJOVDHxf+t6L7Hr+3G3tNb2Fu0r4NocZLsjMnVAmq/nvzWJVjmyhADc7db/6b1jukGWpVLsyfHDXjQBrqf2EEqDPxXQlwsGb/8Dhh7TEAPFOt9pbCdo96HteYtzkL+bw6zQBA4vh1SwL65bLun7/TsKkzX3y+Vn69a4HnP+BRvVkyoTRD6qFVWqSZczKRZH3l1p8NitgB35yQQ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(921020)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XzeE0ikNYKCADHt82erzU0oU0YmQZCHh+GQk4kmPKMyraY65U/Rr6PoXkMALPtJYlFJ4ZIgf+JbH7jO8hX/rb6XAEUXsDuOy4Z6tHAxYjt7s6acMUTaCbnyx+A+sm5O/0EE4fyvoaHQm6mbHjv2eiW8Ow/DEp141Y/I0Z9boZFB5HGy3PEZ2wq0Mru6spAg27hVj2k68u+/lvduquhIS5Fjs3OKPgPrQXr9q027isURCA/DL0Y9jlweXVa6fJ6S2HHbWG1A06dR647eWzv7/x6lMIGg+mgEFfd0bmdaE/B2QlIIRLho9Ap44pIqBR9YE/kLBHBAuJUqvSUxXMRr7EehnedzQqaG3JSoydptvUfJiyttwxAjxM2SlGy7fnp5oMb7dPnXBruhsXcw3XDeWU+mkt5vpHu3KCEMRkQovdmpEsJsDi7+ho1OMb9Xk0xFd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 11:30:24.7576 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb69d020-4468-4b37-92d8-08de84189513
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9222
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

