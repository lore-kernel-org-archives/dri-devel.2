Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E7BFD8740
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 11:30:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3C3210E601;
	Tue, 17 Mar 2026 11:30:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H4c5aZvB";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011005.outbound.protection.outlook.com [40.107.208.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28A6610E601;
 Tue, 17 Mar 2026 11:30:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=okP+QTmlDgiRwzRqwGvoy66nbvkRAopf1OrZDrN7WwHd7SMfaQ/Z7OI6Ntm/ue4ct76dcjxzLbVKv5Q2UWTrCCWGI/ZR1kkePcNCrLhuw3usa0K0C0ldRx7TQC1AeI30+5yN9KnlSDnlC+i4RyaaBvyiUekF5I5SASKCXn4gEA1W7bKDNmQw/B6mJnZ/ftWZT5V6cagqez0rJR58PLYyHKDCkK2Upr2t2tKzZXO7g0M5nkt//44ZVoT36pTAhiE9rmfhZlj7IMrmxqzLnmXfG1mpqOVtXGS8HMqKPAqqTi8eyLEgeSm1eip9OVV7lNL3VMCdaA+Mu/5M9me6W58Dww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8OS+/fYaRCL11vp6LQ0rt/mJYjtYGq9kFs+OTK5WB0=;
 b=T2qhpdI+coBPTS5UrH7qSab89R6ntekiFv1iCewktJHDDjfz59k7w5qe9pN4RrU8N2uzBoF9miPvK2zLxlJjXVVNcBoNJNHomK8+uBadII71wBFY8NibHsUmUUBWJYHaudmVVbrcXN9/VFIYdso7sINhwSeh8qZmRmEa5WFmCoi9frc8re1nAI8ye+l8ijc8tQ+pTEhRhDtfvdhEpP4bMBMrDSy/3DH7FfLfPbiWLlSBgpiiyNeSEi8D+GVLeIujOWOpGERAOiRkBOvmFSimgQhL1eOwVDRv20VZRaQacWWrZzQE0uskAmRlb9y/p4G3IWuFLoHr7jHte9X1yWgyFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8OS+/fYaRCL11vp6LQ0rt/mJYjtYGq9kFs+OTK5WB0=;
 b=H4c5aZvBy65XEjGE/v2Ev5MSTl67GQwdIyqUXgFxZiKwD0sTjFAK/gsYUg+ikL4xfB1gNrYpQ8uuy736Ax2x/9cWOpEzhrzZGmO/A/liS6J3bs9aSl8I1H4g/EbYpKo+VT6rGbiovilBGzhr/HU6Y8G/8GTRZ3tUTAwB+I6KNnY=
Received: from SJ0PR13CA0146.namprd13.prod.outlook.com (2603:10b6:a03:2c6::31)
 by SA3PR12MB8762.namprd12.prod.outlook.com (2603:10b6:806:31f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Tue, 17 Mar
 2026 11:30:22 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::a3) by SJ0PR13CA0146.outlook.office365.com
 (2603:10b6:a03:2c6::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Tue,
 17 Mar 2026 11:30:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 11:30:21 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 06:30:18 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC/POC PATCH 02/12] drm/amdgpu: add SVM data structures and header
Date: Tue, 17 Mar 2026 19:29:48 +0800
Message-ID: <20260317112958.2925370-3-honglei1.huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|SA3PR12MB8762:EE_
X-MS-Office365-Filtering-Correlation-Id: 7042896f-72a4-4476-9a1f-08de8418931f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: xBlEvpHGiJL6XAd+a5AufB/QOUVpd3VP6RsVArLX+1DPmvCTfBomSy8f5bPX+zkpfN391kN3oAF8m0vYt/ElThsaEol/d4QA9DNpnGL+5ZfRr31zpkuLfBJ9taUn6OIxDFOYdzP7XEjoN9iCe37H20IrxtqvhMCxnDGXaZH17P6lYN0TxLG/JaBSCdKFW9pKtyoo2yxeKBo1mEwDhizEfLuBGPkGOZ54QAeIlIzmnX2GyzjzvfZEC+gn23+x1TQ93uutogoQzNLKdkJyVg8Ugh3uKq+HvQffkY5fKAbrLv7hOKxHCyEfGe+tyu/8DivQrx/cLjZy5ujDjGeh8lzsJi4MfC1wV4KTMpYOIs9Ec3ipi8f7tvusXnyeFDKdnAVP/RiOmegAZVKuskXiOE6V1huGMjybGshihyXtGjSQk6TGw5b2iPowrSYO1wyhEkc8U1i++7K6ADsKObKazLMncEH1fc7amAuaHog8lwLuyckRY2swh+vkPFiPnG/epXIspxE1JlR54dhptxgum9iZk/ZVNDnpltBy+07woO+V1Ms1c6f0n94jcV6QRrrTa/RxtLz3wl17I1KjqtSKxpM0foIMBfidZXB8kLY4RtTVT0ARN5AuQNhR+3/ltXryJicgzANeWfrzMd80Zk8+qY/VRHV9IQ8LUbP7VdSeLitxdhHHXYRFNMS1YB8qPcqDsUBLfLJwbZGae8SHMpH6lC6YF/t4tqwO4xTaoCYydvB7cQJs2BTuq31Ro+mRdRx/MOIzl6zdPvYVcF8UQIgZM5aIj66TnaSeY/I0XcobotSJ4VFf/TLcyCV6LO0JqilQvjAF
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(921020)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aBoMQj6blvyKQVCpNACRK4Bpu9ckbMcOB8EaYkx+7X/iBfXNwwAMXcYWHCFSMVSTK9LpV+ACvGtVSJtOlNYv5w3xeBx8bwPHWARnWnBO3v8pv0+J67wJhAbi/k4KvUPhqphUDyc0nx5tfZn0QuROfrTrzOiBEgasCBtKpux1lxw2xQIgBespiLKZHZBE/ySO7eXgY4OLds4vtXyKMuxdEUDnruRiJJx5ZEm/IxM7UaMReTA+TxLKoFezNbRQJr2YZ7wM2LS7DxT3bFyMuSjAgCC51hS/Uv8IB4SvOIDHcy8Y+1aFh20RJvZR6bZN202el2eeNWOYFwLiOgCOTGAuC3iDOKinn2gpZHh8Jb6vhjYapCTT10HGbrbl/CW5ue1vJP+2SjaQc/8cRnvCiSJuphGOLLuAuf/IxqQ1AJaiA88MvCtY0xxZlFN4UgeCAcwd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 11:30:21.4783 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7042896f-72a4-4476-9a1f-08de8418931f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8762
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

