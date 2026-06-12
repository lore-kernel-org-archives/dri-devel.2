Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA753CD8CA8
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 09:10:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D29710F36D;
	Fri, 12 Jun 2026 09:10:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HfmmEdb3";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011031.outbound.protection.outlook.com [40.107.208.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47B0E10E9B4;
 Fri, 12 Jun 2026 09:10:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MgadEtF4TRXkjUVZLiaKYDMtEk45YlGSCjOayXvWLkFDhOyQ2HMF6/DeFQFDHAP+UcwHV+9Rp+fTgAOL8vPcUjuo3PNvyuKaVgD4/dFrXrrof6NBNt8lMF3IZ3zgvvolgE78kZXDL3vcQxGaAfl/hEa8OEl9+g+kadDASuAnrAxl+V/bVOKJylemndON6JKEO+bVPzutvZ6LGS6zkFqsQeIGC1MZFGF3b+Hmb3e15uytMYgeN4meD0OIhFT/qBhxdmu++V3/C1zeXh+PETuPhn/SMNLUvJVRGoxgiz0T16yiRIbEWu7YIUbXERn2xH2VMOZ26L8jPC/3ygAVh8EOLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FtD9uxU/ltk28rQn5IQ4n/xmapdAoDV1MTwtl9l7gBw=;
 b=IgJcM9UcjwIoMG3DVSAjiENBEZgxgiVJPhL6P87VZqr4pkCwAk6CKEbZsTaYOk6TvwBxzqgTSD8BZ64KU47ejeB+KveJutnase/TI65fsRcv8rbZzjhdLZv1HS+A7dxQWkmowzc8Ae8/7bhZ4pSNa4HNCS5K9bhSt7YqU2Zw8QohFEYgq7fAB8tR/tLlPUZfaTW1z0/Kwr7MC4n489K/tHsfB7F7dVGviMb37blFVCopp8THIIfIkwc0+8CexnSao6WxTVSbuvqhWkijsfsjkqgV/aojV91sWSOZWEdoFV6YcJTrL1CW3+yv9E5/R72YuxzK+HWo0EDSbvEAVzmqNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FtD9uxU/ltk28rQn5IQ4n/xmapdAoDV1MTwtl9l7gBw=;
 b=HfmmEdb33/eUDLDpZ1yE/+SElWAdwFD8Tcc28KsZIJU7ddJpijOTA3UxbU/dThUty+6l5emeU2y/cJXXDtFIdExs5ZUGdOL8drw5Uji0fFVelzRM+7aexObhn6NafZhzk98uMaWaWGoJ4+zDeDlqsUmuNqXBGPA6YFEvUMvYo6Q=
Received: from CH0P223CA0021.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::9)
 by SN7PR12MB7347.namprd12.prod.outlook.com (2603:10b6:806:29a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 09:10:12 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::86) by CH0P223CA0021.outlook.office365.com
 (2603:10b6:610:116::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.15 via Frontend Transport; Fri,
 12 Jun 2026 09:10:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Fri, 12 Jun 2026 09:10:11 +0000
Received: from hr-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 12 Jun
 2026 04:10:07 -0500
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
Subject: [PATCH v8 02/18] drm/amdgpu: add SVM core header and VM integration
Date: Fri, 12 Jun 2026 17:09:04 +0800
Message-ID: <20260612090928.29682-3-ray.huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|SN7PR12MB7347:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ed6fc8c-1e0c-4032-80d9-08dec862687f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|22082099003|18002099003|921020|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 7QcuNQxsxrViULJNFxzdP+EPq18u/RGuamnXw2hJ30e/cfWxblIN+DHehg+VY2qeOlKqsmuEpzP8hjKB2QyUKfK3U8NvyBqnf+zpHwRLdC/n5k/hedVP5yqcSsNdRjYSmR2pbxLbEsGIATvLfah/zGW91OtJLmlXzzgkfiLkEbLqf4rREesMErU1k7om69XNzeVTsF4+HfiGsZBMsTO/+dj2p2LryR/RWDR+++R/dfmkXx4jSIl517ZWaMZ0pkoSzvAgIj2asznuafdb2c13A4W2q4CJQcWh+AjzhlB2drcTFIyrxVXa8a5FVOq8aR+FSFshlZdG61W7Pm+Fs5OmEWfJ8/E8vmvPjXGmM+fQq7YnpwCLvdG9RwTm67vPSYwPi2RZnrCSSPewG5HFXGyWETPuSNV7cudktZr5yBzefbye/ulorXKyF+/xaqqlOLlltxTDIRm9YocVss/+f5cwbY5ofaehiSeja9YwJNEyJzyCD0vGuX5+/9Afv1UHflhzRbtIETp1sBPfVcWtDOlha5jE+88W++nrx5gNuIXGFW+AWduOoY/1EThgXwurnocvB9B4yrTqqomTkoXXTpSBpf9U7T1sYtawE/CZVQ0PrXCp72cI8/Cl5hu0DqCD7BAI1EpaSZMYFoAN5ik81H5IhDmUCe5moFnQbl8mqrsETct69PF6iJTn0nOWrUDbDx56FnZbcQy3CYdbd85WL8u3MfR69cIFqpaa4nAlikTDeB/1meZzd2ZygMOEw9bvvDtk3TgAeU4cvVSuuWvmDU/mkw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(22082099003)(18002099003)(921020)(3023799007)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Xz0QvGgCDbs6t2bxLUIJcIkcQTaf7923nVC06yTntO6yBd2urQRiOj9dUU70bbA3+G+YtCu44Ouuu5uX1SPsKoKp3TBtv3p7RhUggeApNjUtAsJde2MuVMtAcvAWFadib+iiDfEivg2sWsUyJ3+4VGYFPuBLr5Xca7heshw7A9NUDm/arpQP5jtGkA7XrIIwv+1kmwqwCA0QZF3tsf/ZLdOz/tCkzl6n+uiaBUHcR13XzBLHa1x5iMzxTzNyWtkgXQeQev6ZmSQTsQ26fAnHpvHJYRMr7aV0hQgP8ntdJns+VQaze9zD+b5oBmL2neGTr/xSEmIyk/jPiCzmqkIfNOpjqoNNPHVJ/ygkMrulk/2saKWZID6pXo1uBHeUQQ4EyORTia+b7jcsjxsVvjjCfYvLRNAAhQQ0R94cv0GR9UUz4Qw9iJoTg6JoFDWYMSoH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 09:10:11.8174 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ed6fc8c-1e0c-4032-80d9-08dec862687f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7347
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h | 196 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |   4 +
 2 files changed, 200 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
new file mode 100644
index 0000000000000..9884a1f834d67
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
@@ -0,0 +1,196 @@
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
+#define AMDGPU_SVM_TRACE(fmt, ...) \
+	pr_debug("%s: " fmt, __func__, ##__VA_ARGS__)
+
+#define AMDGPU_SVM_WARN(fmt, ...) \
+	pr_warn("%s: " fmt, __func__, ##__VA_ARGS__)
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
index cc096c005e348..9e6a668e8567e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -43,6 +43,7 @@ struct amdgpu_bo_va;
 struct amdgpu_job;
 struct amdgpu_bo_list_entry;
 struct amdgpu_bo_vm;
+struct amdgpu_svm;
 
 /*
  * GPUVM handling
@@ -448,6 +449,9 @@ struct amdgpu_vm {
 
 	/* cached fault info */
 	struct amdgpu_vm_fault_info fault_info;
+
+	/* SVM experimental implementation */
+	struct amdgpu_svm *svm;
 };
 
 struct amdgpu_vm_manager {
-- 
2.53.0

