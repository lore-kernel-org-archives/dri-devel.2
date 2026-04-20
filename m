Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4842BF588C3
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 13:13:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A36DA10E5C4;
	Mon, 20 Apr 2026 13:13:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jgsTr9sU";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010000.outbound.protection.outlook.com
 [52.101.193.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DBDB10E5C4;
 Mon, 20 Apr 2026 13:13:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lnnqmwRlz1El5yNqBk0GC3SNJ58duhTMWH2YmdIVlqcqFYibexQNy15ZoSCry/U8vhHnAGDXxJs8X0rUNYZg1CTi7sCOEDpAk7EOOaJcNfNkw7gCwp2ROIYZW0McKpnwJVLNYDeFcHKEGQXGSJ1mwaaNrksv/xMYRNirzDi5++Lm18I99h0TeTg2rR8TcXyddJzyB3m5ahflfhpxrqCU0sp/yka/GLjlyvI20M5qqk6/+LCEYo9f9oTmatps2j8gYJjZqL0pl0ih4kC8L43es7O/TBDFWGZH9147OJgO6nHmo1D8kx3QfBlcgGLPvON3YpTrxwbaiGwI2bs7z+UMvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fq3P6fHwaC+duN0DvlypIIWpZO4/ROey22/5N8UXtAA=;
 b=Y+kdsiwPfKt2IzKf0h95hEccn/JMnhJ3jM4dSkNMF9wN05DhzryZKCbJa1EwgJSVrc/xhfZ2fbS1+PTUTXhbdtMOfZrs7OZTH1ugqWMIay6Gvc/ixhED5tuXjrU+Q7dzxMu6zkSaYx6ou6G3dnyyDmxW0Q9soEyD292iOK7EUEZ1hFhIxxx/++z3y/qfuV1bdmhZ4/ljBxXu4o/uRYASInNSkutWyi/qKdq+9Uyt+aFeDNG5vkbpciXaBPMFKcPaeg9PU/vDiuN8xbp3KNH163dzHSc1OC+QRWfQwcmndOfZi9VxQCWuRD5zKx0Yo4Wu8fnuBOweIN4qc1zSly/BiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fq3P6fHwaC+duN0DvlypIIWpZO4/ROey22/5N8UXtAA=;
 b=jgsTr9sUS/g78AH6G9bLLafOvcL7q6otUR+AY7yFtA7ICWBzX+LxavM382QD6LjtILbXL7NQ5UbbOlHXZpX+Z6lU6SraRuwIIxJSnjKQY99AaIt4yUvsXiuDi7Xso5B+3FvPAUxKzt7lKDsYUvRNuQlztOFYDKpO+JoxzORD6uY=
Received: from CH0PR03CA0319.namprd03.prod.outlook.com (2603:10b6:610:118::32)
 by PH7PR12MB5618.namprd12.prod.outlook.com (2603:10b6:510:134::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.14; Mon, 20 Apr
 2026 13:13:45 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:118:cafe::c2) by CH0PR03CA0319.outlook.office365.com
 (2603:10b6:610:118::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Mon,
 20 Apr 2026 13:13:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Mon, 20 Apr 2026 13:13:44 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Apr
 2026 08:13:39 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <matthew.brost@intel.com>,
 <rodrigo.vivi@intel.com>, <thomas.hellstrom@linux.intel.com>,
 <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>, Honghuan He <honghuan.he@amd.com>
Subject: [RFC V3 02/12] drm/amdgpu: introduce SVM core header and VM
 integration
Date: Mon, 20 Apr 2026 21:12:57 +0800
Message-ID: <20260420131307.1816671-3-honglei1.huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|PH7PR12MB5618:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e4b60a8-ebc8-4e9a-12a1-08de9edea660
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|921020|18096099003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: dvqyrnwPyKnlFY/ggu7dj4U7EyNbfPA8+E/8cg348OAOo5whoHZ/tkpaq5udpWkvGrxZIH57OnKsDHteK+cCFHY5v8TFq9p8BFi9Y4AZ0PiU1LS4Eg4c41BWFqs7oh0/mBiX6HGx++yM9DrkVHHu5A2OY41Aeqn6FGDfbbYAEKxCZedC+ohMRMgVyAx9jiuSCYszMHS8FHg/lPdOTO0b/J4nl7IJFL5Nicr6bEfAikQaFH8WOUdrqsE5QSJ8AVuP+lviCt9pIUSsNNkOSy9fT/1VIbgs9uctpBpyYXP80EdVeZgDWJ/UN9Zlgb7LdA1ncTaZpdGlPqJO8t0m4SeAOK2vtJ/g3mOgLrfDe0fPomyOAF9+WBQCQk9AtJWyo6VIkFpk5G/NO/agboSFNG1sSEyPi1uHnQ0iEWHmRWGOmdwoylL2nl2e5FmfLAahu+rzZunAk2JVtDLzM1pUPKwrSDEzt4KAeoswvrmrzpMdj6vGbZ59vVa7znJp69P+zo+FzR8cM8uiYgwIUvcUJ6fWE2rKAEQdG6LhwUb3vAdBu9sdMr+UDvwVaPNzzW+HBJ3cFtA//WgAAd0ajMWjo7GFrAuZz542ZNas2+ZiLI6kcDoXvMX8zN5B0a/WZm2RB5lsrdhNRg3UPHYZE4tsIBp6uAQHLlD17LI87F+O3OJlquD6uRyi17n21ZnRKg5V6l24C+kfGHJx+ZAnnuEOHIEO3EzotTxWUX6CUX4jcQgO+jpQ1Q2pjQIr0sZyu+BkKuTxacKtoLmnQ0T9MJREizZqruhIJ88Eys3MnfCtsIfBgrkzx2ghvaJRoIYj4/9Q/iBH
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(921020)(18096099003)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zwlAIWV5fBpWknWJG9P32FYN47bT1lV/2YYD5dGaIL9D7NpPp//TdR2gcO/cW6Tw8l8YPS4JAxICUVRxLz8jQvmm30meHEC1Vxtr04kpvMwMgqeghDjyaUXgIGrtIMBkiEYSQYsiAavVx6vnOC1ZcPc9TZkg6teRpzBS1BCGLIP5kmFKJtisvX4Ul7wIGi9zvGHkCpXnYS9FQY6tbvKc+fVLszIw976bvhu+CybTnXuA9ORLW25gbSzTFBBXSxk5TIjlXVTq4MeAdtf2xTzctx7lm8kV2aiO6AXJAvyLkOpFy3G1FQA21dw8yOnWw9gdi5JubW+TxSEymfwWoivKyM1YFmBoCnNkmtPljRFgetH9h13tJJ4tUhAcV9FEC6iW1xrr0Kdto5ke6JpvT3IgzPRqbbNNDYkzh8FqFBmDq08Tg4eAY4SuposM7itc0uKp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 13:13:44.3883 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e4b60a8-ebc8-4e9a-12a1-08de9edea660
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5618
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

Add amdgpu_svm.h with the SVM data structures, debug macros,
and public API declarations. Update amdgpu_vm.h to hold the
SVM context pointer.

amdgpu_svm.h provides:
- AMDGPU_SVM_TRACE / AMDGPU_SVM_ERR: debug output macros
- AMDGPU_SVM_KMEM_CACHE_CREATE / DESTROY: slab cache helpers
- amdgpu_svm_assert_in_notifier(): lockdep assertion for notifier
  lock
- struct amdgpu_svm_gc: garbage collector state with workqueue,
  list head, and work_struct for deferred range cleanup
- struct amdgpu_svm: per-VM SVM context embedding drm_gpusvm,
  kref reference count, amdgpu_device back-pointer, attribute
  tree, work queue, svm_lock mutex, garbage collector, xnack
  state, atomic checkpoint timestamp, and TLB flush callback
- to_amdgpu_svm() container_of helper

Public API declarations:
  amdgpu_svm_cache_init/fini, amdgpu_svm_init/close/fini,
  amdgpu_svm_put, amdgpu_svm_lookup_by_pasid,
  amdgpu_svm_handle_fault, amdgpu_gem_svm_ioctl,
  amdgpu_svm_gc_init/fini/flush, amdgpu_svm_garbage_collector,
  amdgpu_svm_range_clean_queue, amdgpu_svm_is_enabled

Static inline stubs when CONFIG_DRM_AMDGPU_SVM is disabled.

amdgpu_vm.h: forward-declare struct amdgpu_svm and add an svm
pointer to struct amdgpu_vm.

Signed-off-by: Honghuan He <honghuan.he@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h | 162 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |   4 +
 2 files changed, 166 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
new file mode 100644
index 000000000..e298f415b
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
@@ -0,0 +1,162 @@
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
+	printk("%s: " fmt, __func__, ##__VA_ARGS__)
+
+#define AMDGPU_SVM_ERR(fmt, ...) \
+	printk("%s: " fmt, __func__, ##__VA_ARGS__)
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
+#define amdgpu_svm_assert_in_notifier(svm__) \
+	lockdep_assert_held_write(&(svm__)->gpusvm.notifier_lock)
+
+struct amdgpu_svm_gc {
+	struct workqueue_struct *wq;
+	struct list_head list;
+	struct work_struct work;
+};
+
+struct amdgpu_svm {
+	struct drm_gpusvm gpusvm;
+	struct kref refcount;
+	struct amdgpu_device *adev;
+	struct amdgpu_vm *vm;
+	struct amdgpu_svm_attr_tree *attr_tree;
+	struct rw_semaphore svm_lock;
+	spinlock_t work_lock;
+	struct amdgpu_svm_gc gc;
+	atomic_t exiting;
+	uint64_t checkpoint_ts;
+	u8 default_granularity;
+	bool xnack_enabled;
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
+void amdgpu_svm_put(struct amdgpu_svm *svm);
+struct amdgpu_svm *amdgpu_svm_lookup_by_pasid(struct amdgpu_device *adev,
+					       uint32_t pasid);
+int amdgpu_svm_handle_fault(struct amdgpu_device *adev, uint32_t pasid,
+			    uint64_t fault_addr, uint64_t ts,
+			    bool write_fault);
+bool amdgpu_svm_is_enabled(struct amdgpu_vm *vm);
+
+int amdgpu_gem_svm_ioctl(struct drm_device *dev, void *data,
+			 struct drm_file *filp);
+int amdgpu_svm_gc_init(struct amdgpu_svm *svm);
+void amdgpu_svm_gc_fini(struct amdgpu_svm *svm);
+void amdgpu_svm_gc_flush(struct amdgpu_svm *svm);
+int amdgpu_svm_garbage_collector(struct amdgpu_svm *svm);
+void amdgpu_svm_range_clean_queue(struct amdgpu_svm *svm,
+				  struct list_head *work_list);
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
+					  uint64_t ts,
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
index 602deb8a7..9931cc0bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -43,6 +43,7 @@ struct amdgpu_bo_va;
 struct amdgpu_job;
 struct amdgpu_bo_list_entry;
 struct amdgpu_bo_vm;
+struct amdgpu_svm;
 
 /*
  * GPUVM handling
@@ -449,6 +450,9 @@ struct amdgpu_vm {
 
 	/* cached fault info */
 	struct amdgpu_vm_fault_info fault_info;
+
+	/* SVM experimental implementation */
+	struct amdgpu_svm *svm;
 };
 
 struct amdgpu_vm_manager {
-- 
2.34.1

