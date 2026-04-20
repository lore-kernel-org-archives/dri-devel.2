Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D46F36C5C
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 12:08:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D4B110E533;
	Mon, 20 Apr 2026 12:08:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3COAu7En";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010029.outbound.protection.outlook.com [52.101.201.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C996B10E52F;
 Mon, 20 Apr 2026 12:08:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d+yyFwU09HgzkrYSDxBXgMNVHWAao8yWmkbiimfu4tVX5OjKePxq1ywQKDauozImv9ME31uLsTw+eVUNpOAQ8H66YOtNoXHD9Ql9LVkD3KBajyy0iFduzizDv008+goqyeSGx2W3jO3Rowd+D/db3h7t3jJzCbbTq8vnAjpwAnekoUt1PWfuNzl/OON1JNN4c4KdrLYTQz+BVCOlT00JCcdtPDTn8vbRLOJvHKi41aHx5R9T9OLmov77ZXoHtkVizGjU6Ruy35Or5pTAZ9ZojwdkpEPuhJwSpr+np5+tu+TTs1cusPD2MUHiXYZ3ZbHakvTWqprtkbUsEhfP9txBpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8OS+/fYaRCL11vp6LQ0rt/mJYjtYGq9kFs+OTK5WB0=;
 b=vh+yGyYXqEQ4CDVC8N5dhrnblLioZcz4nCbEGUXqKJguXlh4Cva4u2vdxujVqEhBOz3O1DgauF5xi6iCtEzL6vt0FMiR5SO3Sj0lCMb9wTdmJBOi/pn8P727MtuatlTvFFHsb1eyPwMO1m+uukXU2rQoEWlRKzzDh/YDyMuT2RrPMxG+THC8lcgyBsBCsyufWQHYdmYI62+xqzQJJy49oWIge272ovbDA9Vus03Xi+CARUDotq7w0sSgneUAfhjxs+GMjlYS7O4naAePPPv4RB+rmgETYkEP8FQtj5V5XC62zT2tUi7tOxReszdtN2ffa/BsPlKqh9a9w8aauq7ljw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8OS+/fYaRCL11vp6LQ0rt/mJYjtYGq9kFs+OTK5WB0=;
 b=3COAu7EnZR5UQcL5U4xHBfcv6BHNz8HLECwZmk+MZOLWlxfETeJbjlOvzNInJQWYp/6KZ8x/8KAUjTEQcKgxAaVTewNyYpadOFYogd7M8/i7jKIOQGhs4CVpgGsfldfh/xCDEPG8E+OAwKozpRf3QSi8mZgNdluBaara34ATDEY=
Received: from SJ2PR07CA0011.namprd07.prod.outlook.com (2603:10b6:a03:505::20)
 by IA1PR12MB9063.namprd12.prod.outlook.com (2603:10b6:208:3a9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.12; Mon, 20 Apr
 2026 12:08:10 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:a03:505:cafe::b1) by SJ2PR07CA0011.outlook.office365.com
 (2603:10b6:a03:505::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Mon,
 20 Apr 2026 12:08:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Mon, 20 Apr 2026 12:08:09 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Apr
 2026 07:08:05 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <matthew.brost@intel.com>,
 <rodrigo.vivi@intel.com>, <thomas.hellstrom@linux.intel.com>,
 <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC/POC PATCH 02/12] drm/amdgpu: add SVM data structures and header
Date: Mon, 20 Apr 2026 20:07:29 +0800
Message-ID: <20260420120739.1811731-3-honglei1.huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|IA1PR12MB9063:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fe1d9c6-3f73-4c95-c376-08de9ed57d0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|921020|56012099003|18096099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: EmIvLWp5JzcStPbUhfMNIf8a71MhQgH8KAk01Mlwv98IZb/Oa9peZ8zQSbQuAJTbV3U+ypFVUGLo/H8DFLCBJjqWBf36xjwAwsFAzHsjXZpnZnpK5yKKzyNPzo6MokF8zslJqS+Yx4+nfI0Fz+ZA+Qrz510/ZQFcmAGbptRLwFdDNuD2BiSxuK/Kqez96VG3CigsDnJY8FE3Av6aC3ebWLne9gW9MaUsD5fq6b2OMC/XeqDBnYD1jVjRQcEDzX5q5PI1tTbJmxi0j9GedV86uNsdGTJlTFwwRxNjfn/3TtUKPy9eH3qLcPE3XAiFmDqavNzmExR9p820qqr71YnW6u/ov3VIB4koo61pAbBnZ7iESUQiy+8lkTSwFqResh7g3EEZ/6XuTGJZr7wNVL6Pgk6iAS24WZkYs3hygyhHPQgBTW/bj5wyJRBrbZvCa23JyxmAYNbs5SxilC48iASk9NbwmKO+ukTpPH6Fnn+EHZor2SYVuZlzKZkPsJ+fUcqBIe1PiySvA6V4ywvaasdBtIc8zO+Fimw/uYbxdFNxHpi7ZwKMx1FMvlaYuH5AZi/Y59+vMVEHVL/GSf0ZqqzOaI6e8o6nPPik2NDPKwVjI/VOtEthi4yJVajg6qaObXFDL+EJJuBak/JSW2Dw8PxgvnZvSPmAoW6hx00lmZeCsWCYEw9ldf8smjlEUg04Yzs4dbeuC9DkGBoYntXQt51famNzGIt+OVoz3iRbkvT7Iidg/lVA0X7MgC7pNK62l+9fvedv/nRBaU6TRpFymAwq4a3n4ZHEwHesFUla5ROnmh0RnC+6q0SOMjJWUEf4Ma6p
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(921020)(56012099003)(18096099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zFO8fb3Hz2wBO5Ogj7bVqI2HVMKR8/TQwXLo2tzhLkq9d3OGrczqR7SyoFEz2VepmVqdJhwMapVG4ReaOlF8ULJPdWKl/GjTudObhOBC42LHXahLgTzg2nePf2wugrEMRFuGNucnepYyhUj3juJygZyzVBai52gGzM6QwnRtXLx1fuCEghYfQ+RX+c3aWaauJrYqD4ExKI9wIeUW83RtkWSNxjTtEVTrk+eKtWJ29AMR3IXvEEofTcHBI7QU5Lm14T42+DLTAop5PfImXWOyjxeeWNiPqjo/Ak0yRnjfQcZkCiG8f8qkOUXpnDIOxF4k/yX+ELDWLupz1Pz5wS3NsQeH6fK4omKzEc+r9R4Q+WpwN1CrwepOvclGlv3TmGsaQ5IFCYVEIzIaXmk8xZzLCFPsi2zUCLULD4xAQM6FwcknEDvXkQ0mDuXIgv3+avsM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 12:08:09.5322 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fe1d9c6-3f73-4c95-c376-08de9ed57d0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9063
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

This includes:
- struct amdgpu_svm contains drm_gpusvm, refcount,
  attr_tree, workqueues, locks, atomics, and per-mode callbacks
- Helper macros and functions
- Function declarations with CONFIG_DRM_AMDGPU_SVM guards and inline
  stubs

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h | 147 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |   4 +
 2 files changed, 151 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
new file mode 100644
index 000000000..a1bfe8b47
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
@@ -0,0 +1,147 @@
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
+#ifndef __AMDGPU_SVM_H__
+#define __AMDGPU_SVM_H__
+
+#include <drm/amdgpu_drm.h>
+#include <drm/drm_gpusvm.h>
+#include <linux/atomic.h>
+#include <linux/kref.h>
+#include <linux/list.h>
+#include <linux/printk.h>
+#include <linux/rwsem.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+#include <linux/workqueue.h>
+
+struct amdgpu_device;
+struct amdgpu_vm;
+struct amdgpu_svm_attr_tree;
+struct drm_device;
+struct drm_file;
+
+#define AMDGPU_SVM_TRACE(fmt, ...) \
+	pr_debug("%s: " fmt, __func__, ##__VA_ARGS__)
+
+#define AMDGPU_SVM_KMEM_CACHE_CREATE(name, type) \
+	kmem_cache_create((name), sizeof(type), 0, 0, NULL)
+
+#define AMDGPU_SVM_KMEM_CACHE_DESTROY(cache) \
+	do { \
+		if ((cache) != NULL) { \
+			kmem_cache_destroy((cache)); \
+			(cache) = NULL; \
+		} \
+	} while (0)
+
+struct amdgpu_svm {
+	struct drm_gpusvm gpusvm;
+	struct kref refcount;
+	struct amdgpu_device *adev;
+	struct amdgpu_vm *vm;
+	struct amdgpu_svm_attr_tree *attr_tree;
+	struct workqueue_struct *gc_wq;
+	struct workqueue_struct *restore_wq;
+	struct rw_semaphore svm_lock;
+	spinlock_t gc_lock;
+	struct list_head gc_list;
+	struct work_struct gc_work;
+	struct list_head restore_work_list;
+	struct delayed_work restore_work;
+	atomic_t kfd_queues_quiesced;
+	atomic_t evicted_ranges;
+	atomic_t exiting;
+	u8 default_granularity;
+	bool xnack_enabled;
+	void (*begin_restore)(struct amdgpu_svm *svm);
+	void (*end_restore)(struct amdgpu_svm *svm);
+	void (*flush_tlb)(struct amdgpu_svm *svm);
+};
+
+static inline struct amdgpu_svm *to_amdgpu_svm(struct drm_gpusvm *gpusvm)
+{
+	return container_of(gpusvm, struct amdgpu_svm, gpusvm);
+}
+
+#if IS_ENABLED(CONFIG_DRM_AMDGPU_SVM)
+int amdgpu_svm_cache_init(void);
+void amdgpu_svm_cache_fini(void);
+
+int amdgpu_svm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm);
+void amdgpu_svm_close(struct amdgpu_vm *vm);
+void amdgpu_svm_fini(struct amdgpu_vm *vm);
+
+int amdgpu_svm_handle_fault(struct amdgpu_device *adev, uint32_t pasid,
+			    uint64_t fault_addr, bool write_fault);
+bool amdgpu_svm_is_enabled(struct amdgpu_vm *vm);
+
+int amdgpu_gem_svm_ioctl(struct drm_device *dev, void *data,
+			 struct drm_file *filp);
+#else
+static inline int amdgpu_svm_init(struct amdgpu_device *adev,
+				  struct amdgpu_vm *vm)
+{
+	return 0;
+}
+
+static inline int amdgpu_svm_cache_init(void)
+{
+	return 0;
+}
+
+static inline void amdgpu_svm_cache_fini(void)
+{
+}
+
+static inline void amdgpu_svm_close(struct amdgpu_vm *vm)
+{
+}
+
+static inline void amdgpu_svm_fini(struct amdgpu_vm *vm)
+{
+}
+
+static inline int amdgpu_svm_handle_fault(struct amdgpu_device *adev,
+					  uint32_t pasid,
+					  uint64_t fault_addr,
+					  bool write_fault)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline bool amdgpu_svm_is_enabled(struct amdgpu_vm *vm)
+{
+	return false;
+}
+
+static inline int amdgpu_gem_svm_ioctl(struct drm_device *dev, void *data,
+				       struct drm_file *filp)
+{
+	return -EOPNOTSUPP;
+}
+#endif /* CONFIG_DRM_AMDGPU_SVM */
+
+#endif /* __AMDGPU_SVM_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index cf0ec94e8..7a5aeefdf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -43,6 +43,7 @@ struct amdgpu_bo_va;
 struct amdgpu_job;
 struct amdgpu_bo_list_entry;
 struct amdgpu_bo_vm;
+struct amdgpu_svm;
 
 /*
  * GPUVM handling
@@ -445,6 +446,9 @@ struct amdgpu_vm {
 
 	/* cached fault info */
 	struct amdgpu_vm_fault_info fault_info;
+
+	/* SVM experimental implementation */
+	struct amdgpu_svm *svm;
 };
 
 struct amdgpu_vm_manager {
-- 
2.34.1

