Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D556EFF8873
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 04:10:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1814810EB7D;
	Wed, 29 Apr 2026 04:10:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Gwt2eWGX";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011018.outbound.protection.outlook.com
 [40.93.194.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C092210EB87;
 Wed, 29 Apr 2026 04:10:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lu0WdNYJL71neX2UvcGqwasI6KkS9US/Mr/UBzaHH2ZJUF2MxOkCK0hNva+Twk/6B7+PL47oC0+7s8JL7OGNYy40kozkORMUYa/qCZcJv94OpUSRJyz293IgkP5js9ERpyXWUNKiHRNnIXEqaEdH3aMRP0ii+GHXQz1dWFja09Od3MwN7HteB+sav4Lz6TAcShAQgkrh8dVCYDl7D25knCQqk+sRBm6++tmA4YbneBtLByMmyitPFKLgNUV72HKGgX8xKBpQpHj8E89FckIciXig0UIkWzVXipX9WlSEHpY33hrC47L1/0WB3vRHzhKW/Z9xkn2NUstW0ODm1t2cBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wTwq7uAC3KUefeJpw6wXE4ZyIoD/7fA8dkLVmMZJ/Ek=;
 b=v7+NfjOkN9GbCrRqnufjDbbXW6r+PufdVOiTOif3CAzvyy8j7TnxV21IBX9gB5DRhTWI6n91sEPIsNLhfW91FAZYB6gNR/2u0xjowhNDPGhk/ZI/78l2Ecf0qCNY0aC/MpkLarPK2TitwNCXi5Qz+pO+phfv3VZIwTgw2hbApJKBBrnEZeBU3xPNt78EYU7CUxHb6fdeEsas7N6xdt9s6jQOdvomV6rWk8OIZxrKbn6dFs3iT1VHYjI6N6mp7MS99v7qVcOW0uUw7jIzGAXQubT9fxqcHF3WG4gz4wQf+qZ5Kg2VIQGt5ZErN7W79+rhg0y65o1oCgNd9BHb6XctSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTwq7uAC3KUefeJpw6wXE4ZyIoD/7fA8dkLVmMZJ/Ek=;
 b=Gwt2eWGXpBGwPydbg/eqoBv+p88JPIdEqStJI19e4iqDjk0zTu2lO+D/cwC2rkRvKZq1SsiQMVwjZta0GMvx4xvd+kgOVRg7DycKwqIYx7yYqMZox9IpoDbS8sZPUlLtgHF9f2asyo0ZyyZOPs4R5M9kgmQMoHX910nueppzV7I=
Received: from SA9PR13CA0028.namprd13.prod.outlook.com (2603:10b6:806:21::33)
 by BY5PR12MB4196.namprd12.prod.outlook.com (2603:10b6:a03:205::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Wed, 29 Apr
 2026 04:10:41 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:21:cafe::93) by SA9PR13CA0028.outlook.office365.com
 (2603:10b6:806:21::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Wed,
 29 Apr 2026 04:10:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 04:10:41 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Apr
 2026 23:10:35 -0500
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Apr
 2026 21:06:55 -0700
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <sima@ffwll.ch>,
 <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC V4 02/12] drm/amdgpu: introduce SVM core header and VM
 integration
Date: Wed, 29 Apr 2026 12:06:18 +0800
Message-ID: <20260429040628.853079-3-honglei1.huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|BY5PR12MB4196:EE_
X-MS-Office365-Filtering-Correlation-Id: a1fc3bb5-02af-46ee-8f1f-08dea5a5474c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: xr2bvTN+EYQIRvi3RzT+Y6/3KUsJNWAQ0nujZanlgXiT09ahQAnsIEFXHcsvKJkEwdHI1ok8NeT3jr6ft7G7N3Fsg6dvtJt2xxNsMrCIu0qooyrhkX6XapAiWAHswFoNoCtJt9MbleFvFHn4rj/vpqg9yVb7qaAitX64cKjgvRioGuJmOkThPLB7UFbVkw4LhqqLhXZSs7HFeVwTGVuBchJ7UD/WKjIQeOTiSj/nhrmy0GmIRiA5BdMwXjXFQ1zklO4wqF5np1gT/S1V0/JZ5z6jZjyYMlugF6K57pOPn78Y3rfENh4TFcRcvWUPCAjnAHqUF48bkMq/tM1wMBr1YVQAJRujHD8KFJ/W1IkqIPSOQi2VG48jlLY12lKR197oUlV6i+75P8Tzf2h34aYDjqu5cu43qxouEQgMztq6HMbW9HPigA3gJ9V7oY49rlbELENCDaBxPVTyKuv/YNiDc9QGfI5Khl1ySYZhLrhBcBZ3Xm2UJOH68juOxbcmPAxSogvsFuwl6T3/MKC/mj9AIaK7FlTIFTRv3/YQv5b7IkJrvAPfeF9Ic1yWF4UhKMR5bfpTyQ/EtNH/JtY3/37T+OykK+h1VzqhInImrogcTTJAgDzJAoAoisJ2FoVNgou1vVBtYApTYAeA2KYWy58aAkOYl3f0pVeS4kw1XHH0sXfTNnBrvngp5NphkTGu6AEJLxQN8D0Fy5hjjWoGeSUnCinkzy8y21wrX0PyGAAhA36rO63DmJxdVygSojG+BTR2EuNzdoCjojWORnkGsKZPmKWlJJwr94GN1j52fPSvHF8KSslQAh/CEP8ogRQ8/T5j
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(56012099003)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: t3yFAOKiNgv6YSKxyo6O4SZ78XBRUkoZrx9Xo5lt/nW+wYJsb5kAe9J3p+oSe7naaefJOjgvR7vQyTa/tGmBVHmiLiYjW0M2SrMUXr/4xVbTLNawOHM5TvXo6fsqrzB5C0DFom9VUBBHyCebV7uVfxM92m/f96GpJq9fiMCJHwhQOzskasHcfClvPJzhAbHlvQxvQMhb7b9PVMeJXRNGT36zn/x9znJJANnZfgMVcBgygl0kefgnyf6dvyfKySSH+OsXo6Y7qejcIkx3rlcMAtfWQd8qqssJhejBIKBSEEIFtPgv9dqL+UWxkpMfPx5LDEafgZMvtKoYXZdaFu+MTpihno5qxT0KDgXJIoAwXlim6gWFcAApGKmGkeDPu1VNLJ/laZ9DyVyV7NRsFlJ8fCHq/zXFLrOGdBzZIIGIvYQ3BzbjdsNjq8ez2lPb0OKZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 04:10:41.6959 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1fc3bb5-02af-46ee-8f1f-08dea5a5474c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4196
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

Add amdgpu_svm.h with SVM data structures (amdgpu_svm, amdgpu_svm_gc),
debug macros, public API declarations, and static inline stubs when
CONFIG_DRM_AMDGPU_SVM is disabled. Add svm pointer to amdgpu_vm.

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h | 162 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |   4 +
 2 files changed, 166 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
new file mode 100644
index 000000000..5bacaeb43
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

