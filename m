Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59672CD3436
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 07:52:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EAFD10F3B4;
	Fri,  8 May 2026 07:52:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EHD7SucU";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012031.outbound.protection.outlook.com
 [40.93.195.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2655D10F3B3;
 Fri,  8 May 2026 07:52:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mu8GlVN9MUxZ6P8ns4/kcoOCCuY+5qGKixpwq66MDCifDDZxAP2pL7NHXkwaGyVf75eEYbBMzxpYv0zQSJHxSdmDDecrCPtrKStO1QElnynchPN7K1tjY3fLzH1QpaMvVUbpC9Lbg9US9PqBW3T1N/BRo1DHssVoot6ih8U/Zd7fhKIao0UqqVcR6/3Fe/T4Ftxn3mYQDX6I2NCLod5qK6i409LjCfb0Lu8KLTlIlrGIt2XurCAmqD3XbbKXQF6rl7gXQHLmoiMk9m8CYuPqltknq2qBDPNqTQOD+iPzzl2WsyycLJxayAcMZMrxpbL1OatXdMjs6/R19iXhMoSEiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=guv60kp080vxM1mCMc8982iQsFMCx6ArOz3PFtVCkHE=;
 b=BTK89K+Uk4EI2oYnEButYv0LGD7/i60n6nkQpfN7+0UrRT62x98hGnDC6ncHXSzLT5wAYDtPJ9e43nTqJNqCY689B6n5NZrEBRCntxeji9ROz6G5TM8FbDmBYUUlKl20eBu+4i3ftZXAr5AzHggHDJgpa9LTAchyc62uBn+j+eZ0d/IbWYL1rQZhChsTgF/HkXQyJjebZQ6GbhUrUiRb6YMkbhyNB55WQBYUtLo0WPkkNJxKnaeNoIU6lFbgtXNOH5P2XO8/kvUIlXEqayyHpAoO7KaUEteZe7xjS7/ufkeWI/uwI8b+X1y3XT3IO/KbsNwfOdBpEX7nv5cZYhuF4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=guv60kp080vxM1mCMc8982iQsFMCx6ArOz3PFtVCkHE=;
 b=EHD7SucU59QWuRrVPO3IR9wTsm1bLhUZlasb4dRGLUzCSXV/8rB2N3XO7kmnNCiykuLJQ1vEZt7UC22fcjGEg+Y80UIKNSqfcG+zTGwBCfcPadz7madtGxUf1x9NMn7aQqjUcAr/eeHvB1Fn8WDl7zTDZ2M3AYwkg3een6nsSDE=
Received: from MN0P222CA0018.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::19)
 by DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 07:52:33 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:208:531:cafe::88) by MN0P222CA0018.outlook.office365.com
 (2603:10b6:208:531::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.19 via Frontend Transport; Fri,
 8 May 2026 07:52:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 8 May 2026 07:52:33 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 8 May
 2026 02:52:28 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>,
 <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC V5 10/12] drm/amdgpu: implement SVM initialization and lifecycle
Date: Fri, 8 May 2026 15:51:27 +0800
Message-ID: <20260508075129.1161157-11-honglei1.huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|DM6PR12MB4250:EE_
X-MS-Office365-Filtering-Correlation-Id: 05249ae9-929a-4631-711d-08deacd6c369
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|921020|18002099003|22082099003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info: pSZR1OT/5EUCviS44yrb8f1dECpyQCrATAo5uGdZStoPQpR/EZ5OKYgKFlUiox+YA+nU5uylspPO/eYg1hpiQw61k5D1vawxU5xzorZ4DSPMMaMMlnVSZGy0obxgXl9TfH+TI7wkiUIh+F2Q6r1MOo08nJOzPjfo5NqESMwwNBi1Wlj1aiEXHOXKzESjBkdBvc2A63hCka4H4DA8nJ70bceNTOl0dpuupVaLt/5GgVeQwvl7FPZv51xVU+bPacGdH3zxGTeYZmXwE1CN0/wCqssZaSB7TEt1fshSFtNwwSmr2ef7BefyevId6ORMK1ROsB1oRprsjfAMXYvZ/cpUdEhcBg93CQnwxe3o+UcCJzQbbyxGAtzymYmqWKa0Jv5lcmEtK9qyw8yUaFab3xEdjdOkwmqHd0m0+fnJ+SEr17gKZ4CzVwKYaLm9z85uCbLc/ZjPs1gZTkwthns+Lzxcf9Bfo3QoCD811fyn34Tr97xnM+YnvB17fPbO89RHho0ua0PxUHZu9ReJgLf1QEhtLMiKneerEK/9Cg91i9LatxMLqeJY/whBHFE37qztvU0sKyHOAr+3G/GT9Fh9Sd1JmWgiaN+c52fXfMbLgUu6BY27pGcBUGeVTTxwwCPZEk+uJN4xusG52yCHr1BNjBr4VllOCvObzTU/23W+QRjhqxZnm0j+H7JDgvzz/wiEc1Ls1kVCh+9otPoOaqs4FeKM161rHQgq6HKy0g5mBUpVChSgpDeQ9gBnVkmRddXfJQqzQ+kSLTt4ivl4L7V/Zph2Zw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(921020)(18002099003)(22082099003)(56012099003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 65pBR9Zehh2uTK6D2Hj3GS3f3X9AjF8NEhiqiIUGj2+610PsCLS8lt+gsxSHOemhmA5dUO6erLVuiwcT7G7NJUnnN3F3cQfHFxhsmOr4Iy5IDskBN7oieAL4ol3V4nT5sbTrm6etE+JtG0NgveBcNkAebEGxcCYGnndxxH9ElLztYaD7serRwKRzxclVCC6YEiHY5TnD5wz0c8mPVVlB6sv/+DAE5MF1BAoXBRpHFZMk9dtIe9TSIOnqjHl8F8f7YoEBEgMi7ESJdgXKPjWGpLlrwry+hAXzZo59ivGEpT2T20xqCJG7AYq4tQPMNVGTQ4HZYxnsvqEffh2ewl33luT/tuOP3fRlmRK2EUe+9raNdbYanrF9Mc3Nn7sGvkAAEMIawpL1koY31LXkQ8KIYrYtv58yZKGAAQoYhgc7Tc8eKeUY5kIuoMLiwRhtU8PS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 07:52:33.4220 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05249ae9-929a-4631-711d-08deacd6c369
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4250
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

Implement amdgpu_svm.c core module:
- drm_gpusvm_ops callbacks: range_alloc (kmem_cache), range_free,
  invalidate (dispatches to range notifier)
- kref-based lifecycle: amdgpu_svm_release, amdgpu_svm_put
- PASID lookup: amdgpu_svm_lookup_by_pasid (irq-safe xa_load)
- Slab cache management: amdgpu_svm_cache_init/fini
- Ioctl operation wrappers: op_set_attr, op_get_attr, op_reset_attr
- Attribute change detection and application:
  attr_change_trigger classifies changes into trigger types,
  amdgpu_svm_apply_attr_change dispatches invalidate or remap
  based on trigger flags and xnack state
- Hardware detection: amdgpu_svm_default_xnack_enabled per GC IP
- TLB flush: amdgpu_svm_flush_tlb_compute
- Initialization: amdgpu_svm_init_with_ops (drm_gpusvm_init with
  2M/64K/4K chunk sizes, attr tree, GC workqueue)
- Teardown: amdgpu_svm_close (mark exiting, flush GC),
  amdgpu_svm_fini (gpusvm_fini, destroy attr tree, release ref)
- amdgpu_svm_is_enabled predicate

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c | 437 ++++++++++++++++++++++++
 1 file changed, 437 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
new file mode 100644
index 000000000..f88bad1d6
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
@@ -0,0 +1,437 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
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
+#include <linux/sched/mm.h>
+#include <linux/uaccess.h>
+#include <linux/xarray.h>
+
+#include <drm/drm_file.h>
+
+#include "amdgpu.h"
+#include "amdgpu_svm.h"
+#include "amdgpu_svm_attr.h"
+#include "amdgpu_svm_fault.h"
+#include "amdgpu_svm_range.h"
+#include "amdgpu_vm.h"
+
+#if IS_ENABLED(CONFIG_DRM_AMDGPU_SVM)
+
+#define AMDGPU_SVM_MAX_ATTRS 64
+#define AMDGPU_SVM_DEFAULT_SVM_NOTIFIER_SIZE 512
+
+static const unsigned long amdgpu_svm_chunk_sizes[] = {
+	SZ_2M,
+	SZ_64K,
+	SZ_4K,
+};
+
+#define AMDGPU_SVM_GC_WQ_NAME "amdgpu_svm_gc"
+
+static struct kmem_cache *amdgpu_svm_range_cache;
+
+static void amdgpu_svm_invalidate(struct drm_gpusvm *gpusvm,
+				  struct drm_gpusvm_notifier *notifier,
+				  const struct mmu_notifier_range *mmu_range)
+{
+	amdgpu_svm_range_invalidate(to_amdgpu_svm(gpusvm), notifier, mmu_range);
+}
+
+static struct drm_gpusvm_range *amdgpu_svm_range_alloc(struct drm_gpusvm *gpusvm)
+{
+	struct amdgpu_svm_range *range;
+
+	range = kmem_cache_zalloc(amdgpu_svm_range_cache, GFP_KERNEL);
+	if (!range)
+		return NULL;
+
+	INIT_LIST_HEAD(&range->work_node);
+	range->pending_start_page = ULONG_MAX;
+	return &range->base;
+}
+
+static void amdgpu_svm_range_free(struct drm_gpusvm_range *range)
+{
+	kmem_cache_free(amdgpu_svm_range_cache, to_amdgpu_svm_range(range));
+}
+
+static const struct drm_gpusvm_ops amdgpu_gpusvm_ops = {
+	.range_alloc = amdgpu_svm_range_alloc,
+	.range_free = amdgpu_svm_range_free,
+	.invalidate = amdgpu_svm_invalidate,
+};
+
+static void amdgpu_svm_release(struct kref *ref)
+{
+	kfree(container_of(ref, struct amdgpu_svm, refcount));
+}
+
+void amdgpu_svm_put(struct amdgpu_svm *svm)
+{
+	if (svm)
+		kref_put(&svm->refcount, amdgpu_svm_release);
+}
+
+struct amdgpu_svm *
+amdgpu_svm_lookup_by_pasid(struct amdgpu_device *adev, uint32_t pasid)
+{
+	struct amdgpu_svm *svm = NULL;
+	struct amdgpu_vm *vm;
+	unsigned long irqflags;
+
+	xa_lock_irqsave(&adev->vm_manager.pasids, irqflags);
+	vm = xa_load(&adev->vm_manager.pasids, pasid);
+	if (vm && vm->svm) {
+		svm = vm->svm;
+		kref_get(&svm->refcount);
+	}
+	xa_unlock_irqrestore(&adev->vm_manager.pasids, irqflags);
+
+	return svm;
+}
+
+int amdgpu_svm_cache_init(void)
+{
+	int ret = 0;
+
+	if (amdgpu_svm_range_cache)
+		return 0;
+
+	amdgpu_svm_range_cache = AMDGPU_SVM_KMEM_CACHE_CREATE("amdgpu_svm_range_cache",
+								 struct amdgpu_svm_range);
+	if (!amdgpu_svm_range_cache)
+		return -ENOMEM;
+
+	ret = amdgpu_svm_attr_cache_init();
+	if (ret)
+		goto free_out;
+
+	return 0;
+free_out:
+	amdgpu_svm_attr_cache_fini();
+	AMDGPU_SVM_KMEM_CACHE_DESTROY(amdgpu_svm_range_cache);
+	return ret;
+}
+
+void amdgpu_svm_cache_fini(void)
+{
+	if (!amdgpu_svm_range_cache)
+		return;
+
+	amdgpu_svm_attr_cache_fini();
+	AMDGPU_SVM_KMEM_CACHE_DESTROY(amdgpu_svm_range_cache);
+}
+
+static int amdgpu_svm_op_set_attr(struct amdgpu_vm *vm,
+				  uint64_t start,
+				  uint64_t size,
+				  uint32_t nattr,
+				  const struct drm_amdgpu_svm_attribute *attrs)
+{
+	struct amdgpu_svm *svm = vm->svm;
+
+	amdgpu_svm_gc_flush(svm);
+
+	return amdgpu_svm_attr_set(svm->attr_tree, start, size, nattr,
+				   attrs);
+}
+
+static int amdgpu_svm_op_get_attr(struct amdgpu_vm *vm,
+				  uint64_t start,
+				  uint64_t size,
+				  uint32_t nattr,
+				  struct drm_amdgpu_svm_attribute *attrs)
+{
+	amdgpu_svm_gc_flush(vm->svm);
+
+	return amdgpu_svm_attr_get(vm->svm->attr_tree, start, size, nattr, attrs);
+}
+
+static int amdgpu_svm_op_reset_attr(struct amdgpu_vm *vm,
+				    uint64_t start, uint64_t size)
+{
+	struct amdgpu_svm *svm = vm->svm;
+	unsigned long start_page = start >> PAGE_SHIFT;
+	unsigned long last_page = (start + size - 1) >> PAGE_SHIFT;
+
+	amdgpu_svm_gc_flush(svm);
+
+	return amdgpu_svm_attr_reset(svm->attr_tree,
+				     start_page, last_page);
+}
+
+static uint32_t
+attr_change_trigger(const struct amdgpu_svm_attrs *old_attrs,
+		    const struct amdgpu_svm_attrs *new_attrs)
+{
+	uint32_t trigger = 0;
+	uint32_t changed_flags = old_attrs->flags ^ new_attrs->flags;
+
+	if (old_attrs->access != new_attrs->access)
+		trigger |= AMDGPU_SVM_ATTR_TRIGGER_ACCESS_CHANGE;
+	if (changed_flags & AMDGPU_SVM_PTE_FLAG_MASK)
+		trigger |= AMDGPU_SVM_ATTR_TRIGGER_PTE_FLAG_CHANGE;
+	if (changed_flags & AMDGPU_SVM_MAPPING_FLAG_MASK)
+		trigger |= AMDGPU_SVM_ATTR_TRIGGER_MAPPING_FLAG_CHANGE;
+	if (old_attrs->preferred_loc != new_attrs->preferred_loc ||
+	    old_attrs->prefetch_loc != new_attrs->prefetch_loc)
+		trigger |= AMDGPU_SVM_ATTR_TRIGGER_LOCATION_CHANGE;
+	if (old_attrs->granularity != new_attrs->granularity)
+		trigger |= AMDGPU_SVM_ATTR_TRIGGER_GRANULARITY_CHANGE;
+	if (new_attrs->prefetch_loc != AMDGPU_SVM_LOCATION_UNDEFINED &&
+	    new_attrs->prefetch_loc != AMDGPU_SVM_LOCATION_SYSMEM)
+		trigger |= AMDGPU_SVM_ATTR_TRIGGER_PREFETCH;
+
+	return trigger;
+}
+
+int amdgpu_svm_apply_attr_change(struct amdgpu_svm *svm,
+				 const struct amdgpu_svm_attrs *old_attrs,
+				 const struct amdgpu_svm_attrs *new_attrs,
+				 unsigned long start_page,
+				 unsigned long last_page)
+{
+	bool old_access, new_access;
+	bool update_mapping = false;
+	uint32_t trigger;
+	int ret;
+
+	amdgpu_svm_assert_locked(svm);
+
+	if (!start_page && !last_page)
+		return 0;
+
+	trigger = attr_change_trigger(old_attrs, new_attrs);
+
+	/*
+	 * When attrs are unchanged but the range is accessible
+	 * and xnack is off, force a mapping update to ensure the GPU mapping
+	 * is established.
+	 */
+	if (!trigger && XNACK_OFF(svm) &&
+	    amdgpu_svm_attr_has_access(new_attrs->access))
+		trigger = AMDGPU_SVM_ATTR_TRIGGER_ACCESS_CHANGE;
+
+	if (!trigger)
+		return 0;
+
+	old_access = amdgpu_svm_attr_has_access(old_attrs->access);
+	new_access = amdgpu_svm_attr_has_access(new_attrs->access);
+
+	AMDGPU_SVM_TRACE("attr change trigger=0x%x old_access=%d new_access=%d [0x%lx-0x%lx]-0x%lx, xnack=%d\n",
+			 trigger, old_access, new_access, start_page, last_page, last_page - start_page + 1,
+			 svm->xnack_enabled ? 1 : 0);
+
+	if (trigger & AMDGPU_SVM_ATTR_TRIGGER_ACCESS_CHANGE) {
+		if (new_access) {
+			if (XNACK_OFF(svm))
+				update_mapping = true;
+		}
+	}
+
+	if ((trigger & (AMDGPU_SVM_ATTR_TRIGGER_PTE_FLAG_CHANGE |
+			AMDGPU_SVM_ATTR_TRIGGER_MAPPING_FLAG_CHANGE)) &&
+	    new_access && XNACK_OFF(svm))
+		/* only do mapping update when xnack off */
+		update_mapping = true;
+
+	if (trigger & AMDGPU_SVM_ATTR_TRIGGER_PREFETCH) {
+		/* only do prefetch when xnack on */
+		update_mapping = true;
+	}
+
+	if (XNACK_ON(svm) &&
+	    (trigger & AMDGPU_SVM_ATTR_TRIGGER_NEED_INVALIDATE)) {
+		AMDGPU_SVM_TRACE("attr change invalidate [0x%lx-0x%lx]-0x%lx trigger=0x%x\n",
+				 start_page, last_page,
+				 last_page - start_page + 1, trigger);
+		ret = amdgpu_svm_range_invalidate_interval(svm, start_page,
+							   last_page);
+		if (ret) {
+			AMDGPU_SVM_ERR("failed to invalidate range for attr change: [0x%lx-0x%lx], ret=%d\n",
+				start_page, last_page, ret);
+			return ret;
+		}
+	}
+
+	if (!update_mapping)
+		return 0;
+
+	return amdgpu_svm_range_map_attrs(svm, new_attrs,
+					  start_page << PAGE_SHIFT,
+					  (last_page + 1) << PAGE_SHIFT);
+}
+
+static bool amdgpu_svm_default_xnack_enabled(struct amdgpu_device *adev)
+{
+	uint32_t gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
+
+	if (gc_ver < IP_VERSION(9, 0, 1))
+		return false;
+	if (!amdgpu_sriov_xnack_support(adev))
+		return false;
+
+	switch (gc_ver) {
+	case IP_VERSION(9, 4, 2):
+	case IP_VERSION(9, 4, 3):
+	case IP_VERSION(9, 4, 4):
+	case IP_VERSION(9, 5, 0):
+		return true;
+	default:
+		break;
+	}
+	if (gc_ver >= IP_VERSION(10, 1, 1))
+		return false;
+	return !adev->gmc.noretry;
+}
+
+static void amdgpu_svm_flush_tlb_compute(struct amdgpu_svm *svm)
+{
+	amdgpu_vm_flush_compute_tlb(svm->adev, svm->vm, TLB_FLUSH_HEAVYWEIGHT,
+				    svm->adev->gfx.xcc_mask);
+}
+
+static int amdgpu_svm_init_with_ops(struct amdgpu_device *adev,
+				    struct amdgpu_vm *vm,
+				    void (*flush_tlb)(struct amdgpu_svm *))
+{
+	struct amdgpu_svm *svm;
+	int ret;
+
+	if (vm->svm)
+		return 0;
+
+	ret = amdgpu_svm_cache_init();
+	if (ret)
+		return ret;
+
+	svm = kzalloc(sizeof(*svm), GFP_KERNEL);
+	if (!svm)
+		return -ENOMEM;
+
+	kref_init(&svm->refcount);
+	svm->adev = adev;
+	svm->vm = vm;
+
+	svm->default_granularity = min_t(u8, amdgpu_svm_default_granularity, 0x1B);
+	svm->xnack_enabled = amdgpu_svm_default_xnack_enabled(adev);
+	svm->flush_tlb = flush_tlb;
+	atomic_set(&svm->exiting, 0);
+
+	if (!svm->xnack_enabled) {
+		/* only support xnack on currently */
+		AMDGPU_SVM_ERR("amdgpu SVM is not supported with xnack off mode temporarily\n");
+		ret = -EOPNOTSUPP;
+		goto err_free;
+	}
+
+	ret = amdgpu_svm_gc_init(svm);
+	if (ret)
+		goto err_free;
+
+	init_rwsem(&svm->svm_lock);
+	spin_lock_init(&svm->work_lock);
+
+	svm->attr_tree = amdgpu_svm_attr_tree_create(svm);
+	if (!svm->attr_tree) {
+		ret = -ENOMEM;
+		goto err_gc_fini;
+	}
+
+	ret = drm_gpusvm_init(&svm->gpusvm, "AMDGPU SVM",
+						adev_to_drm(adev), current->mm, 0,
+						adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT,
+						AMDGPU_SVM_DEFAULT_SVM_NOTIFIER_SIZE * SZ_1M,
+						&amdgpu_gpusvm_ops,
+						amdgpu_svm_chunk_sizes,
+						ARRAY_SIZE(amdgpu_svm_chunk_sizes));
+
+	if (ret)
+		goto err_attr_tree_destroy;
+
+	AMDGPU_SVM_TRACE("AMDGPU SVM initialized with default granularity: 0x%lx bytes, xnack: %s\n",
+	       1UL << (svm->default_granularity + PAGE_SHIFT),
+	       svm->xnack_enabled ? "enabled" : "disabled");
+
+	/* TODO: Replace svm_lock with the amdgpu VM lock to unify locking */
+	drm_gpusvm_driver_set_lock(&svm->gpusvm, &svm->svm_lock);
+	vm->svm = svm;
+	return 0;
+
+err_attr_tree_destroy:
+	amdgpu_svm_attr_tree_destroy(svm->attr_tree);
+err_gc_fini:
+	amdgpu_svm_gc_fini(svm);
+err_free:
+	kfree(svm);
+	return ret;
+}
+
+static int amdgpu_svm_init_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
+{
+	return amdgpu_svm_init_with_ops(adev, vm,
+					amdgpu_svm_flush_tlb_compute);
+}
+
+int amdgpu_svm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm)
+{
+	/* graphics svm init maybe different */
+
+	return amdgpu_svm_init_compute(adev, vm);
+}
+
+void amdgpu_svm_close(struct amdgpu_vm *vm)
+{
+	if (!vm->svm)
+		return;
+
+	if (atomic_xchg(&vm->svm->exiting, 1))
+		return;
+
+	amdgpu_svm_gc_flush(vm->svm);
+}
+
+void amdgpu_svm_fini(struct amdgpu_vm *vm)
+{
+	struct amdgpu_svm *svm = vm->svm;
+
+	if (!svm)
+		return;
+
+	amdgpu_svm_close(vm);
+	amdgpu_svm_lock(svm);
+	drm_gpusvm_fini(&svm->gpusvm);
+	amdgpu_svm_unlock(svm);
+
+	amdgpu_svm_gc_fini(svm);
+	amdgpu_svm_attr_tree_destroy(svm->attr_tree);
+	vm->svm = NULL;
+	amdgpu_svm_put(svm);
+}
+
+bool amdgpu_svm_is_enabled(struct amdgpu_vm *vm)
+{
+	return vm->svm != NULL;
+}
+
+#endif /* CONFIG_DRM_AMDGPU_SVM */
-- 
2.34.1

