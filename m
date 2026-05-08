Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D028CD3436
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 07:52:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BB3710F393;
	Fri,  8 May 2026 07:52:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uQPYqBxg";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012021.outbound.protection.outlook.com [40.107.209.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34E4110F393;
 Fri,  8 May 2026 07:52:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s/eVI4GHOHQhBCBNOCT/vKPYKCCa0XRbrtgfJlrzBaVg/odiGWYvIg8ELFrEnt0RS9vbCgOaXtXSX3MMD7CvhMkAm5oc1TlQePJOyLsloyY1yPvultSo9asSnr4mzRMjbWm3SY300JkUygMBB3r+dP0hdWrx6GVYrHz2GNoPodkg8j8oaa3D+IozFIv3qagCRaZzMH9G+N9skbpqTHZpYk55aINlWYKMKle68PZP2MAYXaS0dctgMrhlKZugOzs26vDTJfWAT821QSohpcro1PLIiAJ0hwl6QnamM6t+WA4JQ6n5TGgBGIqyFOR/eNFDUYYdUgQghgnawUDdLfuvKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sV31hQwGsKeKL9kl5rqRcK6zJhSurDNpIcsVuysKt8w=;
 b=vfSj+Cyp5It5U+H3yADNfF/iKlErB5LB+D+zqXCgJ5dPwsJIuX0LxWzrlakdiaaz+01HBNX/NEKc85VcK3wWfJqvqUiN4gkevJq5B7XUBYQFj+Z70YTsJXNECQ4AagBqaO1umIDAnRQfCPGmqOZAb02hN67+6gH1dJ4d0wPE6Fw2fphg+4WAHELnkXVjQmOhA/VJVbfG5X0QHpU+XiEg26at4k0/99tAVev3cF7jvGtr5pgIoMsJOsXqlm1t7cIE8BqN126TQ2zbS/fbf+Kb9Is8HN9eeNBGKBKBv4qOzsDshzHGExEhEzt9KSfSoX6FJ1wbjFFimsKVSkdGI+bGlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sV31hQwGsKeKL9kl5rqRcK6zJhSurDNpIcsVuysKt8w=;
 b=uQPYqBxgZ3A+5KOJCbuCrqxg0htDbWuH93D7LTxjopGPB0bWpGA4yHVzfvIoYdn3T+wDWkC6mU3VHzkX4FI+pslAVNeAui13ZA2aDNp3Dh24OvkWQCJBystwZc+dFHvT4KfHafu70FtOS4FnFIEIKPFoChHE3BQ6gL9y2VNLues=
Received: from BLAPR03CA0068.namprd03.prod.outlook.com (2603:10b6:208:329::13)
 by DM6PR12MB4331.namprd12.prod.outlook.com (2603:10b6:5:21a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 07:51:56 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:208:329:cafe::71) by BLAPR03CA0068.outlook.office365.com
 (2603:10b6:208:329::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.18 via Frontend Transport; Fri,
 8 May 2026 07:51:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 8 May 2026 07:51:56 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 8 May
 2026 02:51:51 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>,
 <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC V5 02/12] drm/amdgpu: add SVM core header and VM integration
Date: Fri, 8 May 2026 15:51:19 +0800
Message-ID: <20260508075129.1161157-3-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260508075129.1161157-1-honglei1.huang@amd.com>
References: <20260508075129.1161157-1-honglei1.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|DM6PR12MB4331:EE_
X-MS-Office365-Filtering-Correlation-Id: d6b5dce1-b91f-4b55-80f7-08deacd6ad6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|921020|22082099003|56012099003|18002099003|3023799003;
X-Microsoft-Antispam-Message-Info: sVkiTf00ldjB94s7aYadHLBygzmz6A7dxKN0Hraen2CyRsH+VkMYryW3pVxmS2Sjb+IaqOZpVQkvgwR9/Dnfba6jkGDrYqMjdn7XRlfYQrHl+31TonM+W3KzxD/R0MeLAyJHiEx/iNga3nv2LmNqG5aVwj6WoPQu1QsHaStTO4iW4shuzB2rqD59PoGf2MgAwZH5B+jDqa3fxxcwP8LNGq2vzlwxYRYINnV1aSjBQSgsdu6J/TFZaALyhCUbj3ZEIN5QUrRB5C+X311YZ5wzu92T1+sGswj4n8LBvmAU18wCcM1dQm21nfvYrGd4if7xeFqYvm1tWZUmOE3ZxppivfwzXduNFyZNuMlf0MGjZ7WZ2bXdesBbyq+E50KBL3bcUelTDKBqn5M6vKeGdCtb7/WdL+0DRZ3fCK0GrdGUn63adjkBirYVskIml/S6IS6nPQCbVi36aQrUD2g4FJOVpR7xVRkUNx2up1W298GzGg895RYDsAGE3uP+sU8RJBucEzJyoBz/7fMsjYldGc9QdhdbZkkXrnjLMOWxGtkap02sA6u/RobQqE/1CRjkni5vmhFWPEsxh4sPkQCfmIGIWnPL/mXbwRkAvmjYbEiXLBIB0aJhlNkCtTlX4Z+y4QlqpasojVJ6IQ9vOrC2vPDfw31Pune3NxRrS1mlRBC1KFQzUw6DGzwK1LbxnF/vdnHjBjygpeDxbqaZV5lGNhAyf/42Ik39NRxq1kls9AxIDYlGcZQGFMHES8E2/L4cBOw/smuML9NYzvYFUp4ZqSPzuQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(921020)(22082099003)(56012099003)(18002099003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ORb+KKzh8zt1DgQdUZVH7y7JqlUjWNDwWWXi8iE4Mzu6UvMbE+W737ogjcRzOcT7wy5HRt5Eax5UiUcmPUtj7AKGLUgGPdPciyEyQam/PUiwr1Vxo1B9/FMWmKBE7LFv5hiW9WeAhtjU003xSL0i3D34K8nxXtsheJwyk6+lFLZG4N9uIWkfUt0o3jI6Twvjf/NtDPwyLN1IU+2dTXt0oAcaEY2Fx9Xvo+0eGzr1PEJ6BuDDQRGwb5UE7PO4S5XvYpZ82hME9sCpb9UtiSbXeYv/+PhZ5A41g17o+3vOyZrgLUSfRqsVFvJ6WgcB9wW87vOhcWzyXwNMXlbVXz1ZtTSzYfiBQU6Txpa/iHH8TcQr5lYfwR5jiH82MXEkWVQyL8eFUe7nWogbbsLnlLAXGcTiXiyeklLPLVDBDMzdzI53Z3eINRkvXpVQ74BC/U6v
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 07:51:56.5246 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b5dce1-b91f-4b55-80f7-08deacd6ad6b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4331
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

Add amdgpu_svm.h with SVM data structures and public API:
- struct amdgpu_svm: core context with drm_gpusvm, kref lifecycle,
  attribute tree, rw_semaphore, GC workqueue, xnack state
- struct amdgpu_svm_gc: garbage collector with workqueue and work_struct
- Debug/trace macros: AMDGPU_SVM_TRACE, AMDGPU_SVM_ERR
- Kmem cache helpers: AMDGPU_SVM_KMEM_CACHE_CREATE/DESTROY
- Locking helpers: amdgpu_svm_lock/unlock/assert_locked
- Public API declarations with static inline stubs when
  CONFIG_DRM_AMDGPU_SVM is disabled

Add struct amdgpu_svm forward declaration and svm pointer to amdgpu_vm.

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h | 183 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |   4 +
 2 files changed, 187 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
new file mode 100644
index 000000000..2334a9f22
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
@@ -0,0 +1,183 @@
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
+struct amdgpu_svm_attrs;
+struct drm_device;
+struct drm_file;
+
+#define AMDGPU_SVM_TRACE(fmt, ...) \
+	pr_debug("%s: " fmt, __func__, ##__VA_ARGS__)
+
+#define AMDGPU_SVM_ERR(fmt, ...) \
+	pr_err("%s: " fmt, __func__, ##__VA_ARGS__)
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
+static inline void amdgpu_svm_lock(struct amdgpu_svm *svm)
+{
+	down_write(&svm->svm_lock);
+}
+
+static inline void amdgpu_svm_unlock(struct amdgpu_svm *svm)
+{
+	up_write(&svm->svm_lock);
+}
+
+static inline void amdgpu_svm_assert_locked(struct amdgpu_svm *svm)
+{
+	lockdep_assert_held_write(&svm->svm_lock);
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
+int amdgpu_svm_apply_attr_change(struct amdgpu_svm *svm,
+				 const struct amdgpu_svm_attrs *old_attrs,
+				 const struct amdgpu_svm_attrs *new_attrs,
+				 unsigned long start_page,
+				 unsigned long last_page);
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

