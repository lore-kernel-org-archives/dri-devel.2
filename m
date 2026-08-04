Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17068C55184
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 09:43:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6554910E946;
	Tue,  4 Aug 2026 09:43:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DXgsP4PJ";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011071.outbound.protection.outlook.com [52.101.62.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8907E10E861;
 Tue,  4 Aug 2026 09:43:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hoz4rtCRxn1jZ1OUZMV3n45PDUSC34PAl7tmEcRxnCmYybAAHVfl2Xq3yUYvYb3W64W5jcTPUnZ160xIwQSrtXy/TL4iQrare8mvad1/DS1WUDgFVmIrqvMf5FC1vxkOhGX9dVYeguZdlYo14MF6oE/kS7wk+/Pssj2y3ZIU2sJRQgsDDpHLEBt73wiAyswBt68MBRBJjDpiFz4hv5/0YP4Yjl72ozZNxMrA0wz/uEAFMSJpGJ0dFCARNrGBrfIfzTVXeofHZ0o0nwNhSzz0ogC7lcsO9iBZ7KDes2/lBX0YkAtT+xUG7rPyM4c9IhEY/kpKAdrP8e8gefp40xP6vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7njZ1unV7VrSuDypiEGwlke94ZF6nhY+zEIunO2RO6I=;
 b=ajuqb4qM63ga2iWU4tIR/o7YomwB93WgIT9OPurBFGV8y20f83+WPlv81y3AZmoC3FPmevUB7IgwSRXMyEmP7bUlF2gYvdBp/zEbjkDCrI2dNNjecmPoIB+Dq91+gp6iemLP/gxs4LxNfRbIDYPBsoCQaYGrr1MB7YpHWVovY5tXpvL2mk4KpgzxVdV+VYJtVjQ9lhtE+mOeMIOJwKF2SsY4WpTUTMnXYlYmXGYBD3mgmMB6vVJ8qLSOmROWVKfcSMyb6xJJHVrLoPHIPK+vVa276fPR1GN/o54rwZ+NKD7uHZRhAKG1akVo9IHWqVXZHthm7k18AkEuHbRsMyX1pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7njZ1unV7VrSuDypiEGwlke94ZF6nhY+zEIunO2RO6I=;
 b=DXgsP4PJmN/38x//MJ7whT58jj3/sDa5gFJCqueu04rOzjdP+prmRpJ9lG5LSXXhHVvlPiv4c2zD65X0e8Ej70djng5jlGS6h/WuNKYEu8RBm/zHnM3NiFo+yfEVQFOV3Zcot+24KGh42g+XLAdeUb91LWdVDwTgRNLrEulX/Z0=
Received: from PH8P223CA0012.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::17)
 by PH0PR12MB7981.namprd12.prod.outlook.com (2603:10b6:510:26c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 09:43:13 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:510:2db:cafe::61) by PH8P223CA0012.outlook.office365.com
 (2603:10b6:510:2db::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.15 via Frontend Transport; Tue, 4
 Aug 2026 09:43:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 09:43:12 +0000
Received: from hr-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 4 Aug
 2026 04:43:07 -0500
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
 <yiru.ma@amd.com>, Huang Rui <ray.huang@amd.com>, Honglei Huang
 <honghuan@amd.com>
Subject: [PATCH v9 02/18] drm/amdgpu: add SVM core header and VM integration
Date: Tue, 4 Aug 2026 17:42:28 +0800
Message-ID: <20260804094246.1719318-3-ray.huang@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260804094246.1719318-1-ray.huang@amd.com>
References: <20260804094246.1719318-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|PH0PR12MB7981:EE_
X-MS-Office365-Filtering-Correlation-Id: 957578c7-edce-4e55-6094-08def20ccd3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|921020|10067099003|11063799006|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: pm4SG1XYAv/MIniHnCAoDCkR3z/FtCRsJUkJ1TpRgQrjxM4ofvJvuMlGkYKhDNy+rePKq8lduaupausxW0z89lfTyFj2p/AN04YznaOi6dWqkotfOtNEmWqsoqQStGhzRf5sbZRDax7QLh2TEtcbRAUF/fggQtl5XQchm0DKN+1rCTIr4qGOUXtV9qq/qlt8a4M7v+h1793AqyL1X1tMbN0SM2BFVRnN90VhJT9nt5EBD+4mAd70zlR3RMwxd+EuPEWsj8DFY0w694mBnhsBCGK/D17ypJK2gU+/yu28EcbVGqy8WJ8hoWIDFSgZM5JLsR6na0RuQ9YPmhz0EBZiUo8Xg6ahdvMUAwhyPButiaRCdv96Y/53+oApdb+jgzn5UMXikLg7bko5XGGOnxjuP7D9TfTeqy7ADKMZjjQYjhMN9R8ZQ3bNovTcjmXIyBBWqZbHECP2zd0G3+GUtSDOlE9qUfERuWEKzHFy/05Y9cMeCZhQ3tcQ+ZZ0q+dnLLATbanFIdHLbOyzpvDQoIq7b9p/J8WBbFLjcHuGFlDMUTYLBcp1gcH1rdisuR6yPNONAIFseYIkvXU7DXidxaT0nknmU6+qyE1znzTF0uG1Yjff7NjWephUXz0/BfMVUyW7E8o/VmX46JE6teRHZ0kTmDar1+cbXS+s6m2ldKeq+KgdshlhwEfgu13r33rhYrJ76zOtq5OTcw8AMh+daH58DeMUXI3+2O1TA5JaDcRk2qKTHc7CDKbTQ9Llb3XOfQlm
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(921020)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8C56ShnMTZhqdSTTsk202L15uKCs3JObWE89DtlISdKcjXH81hIO8kRP4OrSWf0j/4GWuh1eyw+2CQZjzMmoT9ojWl1hh8ToWRJhguXm5S/6mIyS/YSyIOCYwmTTFK6E8bRb4tMAyhCL5cu4ipTDpN1JhjvCeXKEj2QaY4601p3E9wSlHXsj7ELKRicZBLkz3OBgQN3qPWyCo1YpsWVTr07isqvTLhktQF4Wy67SFook4JoZm+UojFG5dYOQYIsfuE0W2eCSy3Ag1HESnhiYGmcvikpMCma1w9FC+XeIKi+ebnDY35nIzOx1mgF9S2Hs1Zi+fPuQOxA02GVbX9+w4Aw7a6tebzymo2SRxWZHFdKltBeqBJv1ZfpmiP8EiOinF2ZBLqLSfmFhQKN4+SeJjQKjH0IIqlrqNka3LuAFTGY6MCUi/zk82yc6MeucjasO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 09:43:12.9604 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 957578c7-edce-4e55-6094-08def20ccd3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7981
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
- enum amdgpu_svm_xnack_mode: OFF, ON and DEFAULT mode
- struct amdgpu_svm: core context with drm_gpusvm, kref lifecycle,
  attribute tree, rw_semaphore, GC workqueue, xnack state.
- struct amdgpu_svm_gc: garbage collector with workqueue and work_struct
- Debug/trace macros: AMDGPU_SVM_TRACE, AMDGPU_SVM_WARN, AMDGPU_SVM_ERR
- Kmem cache helpers: AMDGPU_SVM_KMEM_CACHE_CREATE/DESTROY
- Locking helpers: amdgpu_svm_lock/unlock/assert_locked
- Public API declarations (including clean_queue, sync_work)

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h | 204 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |   4 +
 2 files changed, 208 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
new file mode 100644
index 0000000000000..f3b4f228405c2
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
@@ -0,0 +1,204 @@
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
+enum amdgpu_svm_xnack_mode {
+	AMDGPU_SVM_XNACK_OFF,
+	AMDGPU_SVM_XNACK_ON,
+	AMDGPU_SVM_XNACK_DEFAULT,
+};
+
+#define AMDGPU_SVM_DBG(fmt, ...) \
+	pr_debug("%s: " fmt, __func__, ##__VA_ARGS__)
+
+#define AMDGPU_SVM_WARN(fmt, ...) \
+	pr_warn("%s: " fmt, __func__, ##__VA_ARGS__)
+
+#define AMDGPU_SVM_ERR(fmt, ...) \
+	pr_err("%s: " fmt, __func__, ##__VA_ARGS__)
+
+#define amdgpu_svm_assert_in_notifier(svm__) \
+	lockdep_assert_held_write(&(svm__)->gpusvm.notifier_lock)
+
+/**
+ * struct amdgpu_svm_gc - SVM range garbage collector used for unmapping
+ * SVM ranges in response to mmu_notifier events.
+ * @wq: Workqueue where @work runs on.
+ * @list: Ranges list in garbage collector. Protected by amdgpu_svm.work_lock.
+ * @work: Drains @list under amdgpu_svm.svm_lock.
+ */
+struct amdgpu_svm_gc {
+	struct workqueue_struct *wq;
+	struct list_head list;
+	struct work_struct work;
+};
+
+/**
+ * struct amdgpu_svm - shared virtual memory context
+ * @gpusvm: Embedded drm_gpusvm base, manages the range/notifier trees.
+ * @refcount: Reference count guarding the lifetime of this instance.
+ * @adev: The amdgpu device this SVM context belongs to.
+ * @vm: Back pointer to the owning amdgpu_vm.
+ * @attr_tree: Interval tree of SVM attributes.
+ * @svm_lock: The driver_svm_lock described in the GPU SVM locking section.
+ *            registered by drm_gpusvm_driver_set_lock().
+ * @work_lock: Protects the deferred work queues such as @gc.list.
+ * @gc: garbage collector for ranges queued for destruction.
+ * @exiting: Set once when the context starts tearing down.
+ * @checkpoint_ts: IH ring timestamp captured on unmap, used to drop stale
+ *                 faults.
+ * @default_granularity: Default range granularity.
+ * @xnack_enabled: Whether retry (XNACK) faults are enabled.
+ * @invalidate_ranges: Callback of the MMU notifier invalidate event.
+ */
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
+	void (*invalidate_ranges)(struct amdgpu_svm *svm,
+				  struct drm_gpusvm_notifier *notifier,
+				  const struct mmu_notifier_range *mmu_range,
+				  struct drm_gpusvm_range *first,
+				  uint64_t adj_start, uint64_t adj_end);
+};
+
+static inline struct amdgpu_svm *to_amdgpu_svm(struct drm_gpusvm *gpusvm)
+{
+	return container_of(gpusvm, struct amdgpu_svm, gpusvm);
+}
+
+/*
+ * Helpers for amdgpu_svm.svm_lock, the driver_svm_lock registered with GPU SVM.
+ * Hold it in write mode around structural GPU SVM updates, including
+ * drm_gpusvm_range_find_or_insert() and drm_gpusvm_range_remove().
+ */
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
+void amdgpu_svm_flush_tlb(struct amdgpu_svm *svm);
+
+int amdgpu_svm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm);
+void amdgpu_svm_close(struct amdgpu_vm *vm);
+void amdgpu_svm_fini(struct amdgpu_vm *vm);
+
+void amdgpu_svm_put(struct amdgpu_svm *svm);
+struct amdgpu_svm *amdgpu_svm_lookup_by_pasid(struct amdgpu_device *adev,
+					       uint32_t pasid);
+int amdgpu_svm_handle_fault(struct amdgpu_device *adev, uint32_t pasid,
+			    uint64_t fault_page, uint64_t ts,
+			    bool write_fault);
+bool amdgpu_svm_is_enabled(struct amdgpu_vm *vm);
+
+int amdgpu_gem_svm_ioctl(struct drm_device *dev, void *data,
+			 struct drm_file *filp);
+void amdgpu_svm_clean_queue(struct amdgpu_svm *svm,
+			    struct list_head *work_list);
+void amdgpu_svm_sync_work(struct amdgpu_svm *svm);
+int amdgpu_svm_garbage_collector(struct amdgpu_svm *svm);
+int amdgpu_svm_apply_attr_change(struct amdgpu_svm *svm,
+				 const struct amdgpu_svm_attrs *old_attrs,
+				 const struct amdgpu_svm_attrs *new_attrs,
+				 unsigned long start_page,
+				 unsigned long last_page);
+bool amdgpu_svm_devmem_possible(struct amdgpu_svm *svm);
+#else
+static inline int amdgpu_svm_init(struct amdgpu_device *adev,
+				  struct amdgpu_vm *vm)
+{
+	return 0;
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
+					  uint64_t fault_page,
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
index ec1196d390bb7..30463a83e2e60 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -43,6 +43,7 @@ struct amdgpu_bo_va;
 struct amdgpu_job;
 struct amdgpu_bo_list_entry;
 struct amdgpu_bo_vm;
+struct amdgpu_svm;
 
 /*
  * GPUVM handling
@@ -373,6 +374,9 @@ struct amdgpu_vm {
 
 	/* cached fault info */
 	struct amdgpu_vm_fault_info fault_info;
+
+	/* SVM experimental implementation */
+	struct amdgpu_svm *svm;
 };
 
 struct amdgpu_vm_manager {
-- 
2.53.0

