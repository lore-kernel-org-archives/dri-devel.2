Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA034F588C3
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 13:14:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B22810E5DC;
	Mon, 20 Apr 2026 13:14:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lGZ1UULR";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010040.outbound.protection.outlook.com [52.101.61.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CF1010E5C9;
 Mon, 20 Apr 2026 13:14:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tGy6Y7wYVdjvy9+gOlYYr9Blk9iGRTgdFGBdXC8nzmq+gTDSjOc/J+4y8jKxsYNzVKdRH9LBjJFFagrr5yxdV7IxOk6TkK2bWCKQq+n9qVPIrd7QbpxKucr85zX3rseJhOl61gHqtqO3Ngo7ScRY8nCbNpj88vKFKJjKQMtDD797QQjmMKmCTFb9heiAMvuUAqmQgKJLht7v8P913UI3htvp41EfwyCV72PCZjZyADWC6bUETKAwohCVhm7QnG6jZo0emADT8OXCrj4m6Q/qfjHr/KzkAQ7XbtkXZKUSuwcmTnaV80Iz6TEGSDn3TyNj/3W95i676w7UvUJX8iJnIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0xoV9Qj8P09Np0Hpxt5zvBhQmSzuhglYH4uz3+KqbeU=;
 b=sqaWAg7cbAYwDfNRfTQRFDhofW4hkglSuwvR4fHR7xa+vOwPJ2cDCbYYbiVJitbder6GkS2yPr42ksEbdbkqQkBOavenCZ/Lzcmv6kWY9tsPm++JWWk1h5RjVwBYUd0i8wG+ZzVYtZPuz2YhfKl6FKeCqT5VEWid3B8mWpzqyh3+7KoMk3ROjUD75s3fL5mTKjdnJ4FMunRnt14TOyt45FslwE0/yeVKe1OwQ8tlqYH+elWbFAijBV3RGc8r2aspL6PBa4dSNkwadYUszjOA0uQrGNCTp9ccQQxpUyLR4uuaPkvNOqQK/MxJYXdJARn0qqbPe8VGrrcFfb1wcKNVTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xoV9Qj8P09Np0Hpxt5zvBhQmSzuhglYH4uz3+KqbeU=;
 b=lGZ1UULRX5HrTEdBEKzUasZS+1T1RRO8lQ49rVTn+vNtdZw8XCN6xPhAV4GoNX+aZTq4bKSjaIzE9KreQaiOHVfl1h55AFoRQtMvFBK6/+HeLCXy84BReihZSZi9HwajNomJksHJ2lkltbo3LWWlDiH47FTji29xQ8LM0WpCjyY=
Received: from CH0PR04CA0039.namprd04.prod.outlook.com (2603:10b6:610:77::14)
 by IA1PR12MB6603.namprd12.prod.outlook.com (2603:10b6:208:3a1::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.14; Mon, 20 Apr
 2026 13:14:21 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:77:cafe::50) by CH0PR04CA0039.outlook.office365.com
 (2603:10b6:610:77::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Mon,
 20 Apr 2026 13:14:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Mon, 20 Apr 2026 13:14:21 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Apr
 2026 08:14:15 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <matthew.brost@intel.com>,
 <rodrigo.vivi@intel.com>, <thomas.hellstrom@linux.intel.com>,
 <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>, Honghuan He <honghuan.he@amd.com>
Subject: [RFC V3 10/12] drm/amdgpu: implement SVM initialization and lifecycle
Date: Mon, 20 Apr 2026 21:13:05 +0800
Message-ID: <20260420131307.1816671-11-honglei1.huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|IA1PR12MB6603:EE_
X-MS-Office365-Filtering-Correlation-Id: fb843f67-7857-4db9-e6f4-08de9edebc3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|921020|18096099003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 6Fzygq5bKcw2VF0DYe7+irt3Oi/d7SZAN0GFhO5vU2sFGrRnUcUxZMwNB2yASMGVSO8vQW4lV1HlG1memD23cWODz0Z61WJl6KTQJQxa9ZRAImWF57UjPRENNcAHVYESapB8G61+OzfVJCOCwBJ4RYF1CPlwwC56Y108eQHQPTHr1A0/tmLfBKocRGz/k9sqpJ+44ujl0+Lx5hw4txIzexQld8cAaNpC9dCpKERbcBI1Kt6RW9BC6CD0TZTmiSV3OfcdafvzM+JqY9x+orsw/J/OxCR8cEAaowZ06vkzkcoq4/axcxBtLxFV9FXYtu7a840i6vB1an5FTfaS3vRdwy2t4GGXob3cIVeyAkPi6qFVml0JbjIQxMyqDcODp+4p43LuiR3pfG76z23qz+Bs4l6U6+YuYJuqqYmN3vw3uk4Oofiqr4oPZjFPOSTgmRqHOYXmmES1rY4NS4ZTJoTeSnLYWlS5QWv8vW4v8BKht3vXoaIY2KQhJnc+1kJyxE0NCSgSsxNjzdVdKmdz4nooSgfglclFyIs70aZExC0AHaqVaivVN5Pe9GLl2KkigpS/9ZmaE+7xXxTceDGD25zjfWYNFQXRgTpe5hzm1S4yGjafII8rlM2anUMnMZjYL3zzY9o5Lutv4ND931ffPrv1b89K/bGPUNCIsHEKXjBCYgnwhztKoOUozjC6lUXdyQzsinQJkGombSrRQEUpCFx6QahWbtb3kSp5uuaDWWUw6IdksFeZUqDFBGGtw0giIJKHVKqpqjQGD9rPxpVoaLeCKXY1FUYtE2TXadGbF6ZA8wQGjbKDNKT3N+TY7fb6YdjA
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(921020)(18096099003)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PDXSYa2ajUIv7W0iSgBVHbw/P0uMAsLArzARMT1ZQKANywj0pXA1fnebTKJ73N9MrOdwKLhl6Ar3VbBA8cjwhMtdKdfcvkJ2GILHaxjAKV4I0+C6nAiiK8YSzZpxnD3iDtEvIyPMuq8gj1/Nm0MDO1ffMu6RjPD15W/VdVOAed+doIVRX0u8n3MFngSn0UM2D36U4ZuZQLixxNTNdiC7Mp4tGYBypFqGe+Q8RW7XdZnjAxqGA4MveZQ2HLzoqmCagJ/uVSEB+DgkB0qVUrW4n6iBAQAfTXySjhiX4QBv52fxr6NRRuGI1oYwN/aztTZtA7Soyz4dyG1iNsxrdEzd+Zlx9NpVJAIapdEiWGIpdZUW9UKRaTYKOto0lmX50T1+KeqxlIY7HQug08Sa8wDq76yNWR+c/c9sK+osgXj3b2Eg9vFwMjoCG3eJYdwF8YZp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 13:14:21.0888 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb843f67-7857-4db9-e6f4-08de9edebc3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6603
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

Implement the SVM core module in amdgpu_svm.c providing
initialization, teardown, and drm_gpusvm integration.

Constants:
- AMDGPU_SVM_MAX_ATTRS (64): maximum per-ioctl attribute count
- AMDGPU_SVM_DEFAULT_SVM_NOTIFIER_SIZE (512 MB)
- AMDGPU_SVM_GC_WQ_NAME: garbage collector workqueue name

drm_gpusvm callbacks (struct drm_gpusvm_ops):
- amdgpu_svm_invalidate(): forward to range invalidation handler
- amdgpu_svm_range_alloc(): kmem_cache alloc with INIT_LIST_HEAD
- amdgpu_svm_range_free(): kmem_cache free

Reference counting:
- amdgpu_svm_release(): kref release callback, kfrees amdgpu_svm
- amdgpu_svm_put(): decrement refcount via kref_put

PASID lookup:
- amdgpu_svm_lookup_by_pasid(): find amdgpu_svm by PASID from
  the VM manager xarray, take kref reference for async safety

Module cache:
- amdgpu_svm_cache_init/fini(): create/destroy kmem_caches for
  amdgpu_svm_range

Internal helpers:
- amdgpu_svm_set_attr/get_attr(): dispatch to attribute tree
  set/get operations
- amdgpu_svm_default_xnack_enabled(): detect xnack support by
  GC IP version (9.4.x+ enables xnack)
- amdgpu_svm_flush_tlb_compute(): TLB flush for compute VMs

Initialization:
- amdgpu_svm_init_with_ops(): allocate amdgpu_svm, create
  attribute tree, init drm_gpusvm with fault chunk sizes
  (2M/64K/4K), set up garbage collector, work queue, xnack
  state, and TLB flush callback
- amdgpu_svm_init_compute/amdgpu_svm_init(): public entry points

Teardown:
- amdgpu_svm_close(): flush pending work, clean remaining ranges,
  finalize drm_gpusvm, destroy attribute tree, release kref
- amdgpu_svm_fini(): final cleanup
- amdgpu_svm_is_enabled(): check if SVM is active on a VM

Signed-off-by: Honghuan He <honghuan.he@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c | 318 ++++++++++++++++++++++++
 1 file changed, 318 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
new file mode 100644
index 000000000..5fbed9b9f
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
@@ -0,0 +1,318 @@
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
+static int amdgpu_svm_set_attr(struct amdgpu_vm *vm,
+			      uint64_t start,
+			      uint64_t size,
+			      uint32_t nattr,
+			      const struct drm_amdgpu_svm_attribute *attrs)
+{
+	struct amdgpu_svm *svm = vm->svm;
+
+	amdgpu_svm_gc_flush(svm);
+
+	return amdgpu_svm_attr_set(svm->attr_tree, start, size, nattr,
+				   attrs);
+}
+
+static int amdgpu_svm_get_attr(struct amdgpu_vm *vm,
+			      uint64_t start,
+			      uint64_t size,
+			      uint32_t nattr,
+			      struct drm_amdgpu_svm_attribute *attrs)
+{
+	return amdgpu_svm_attr_get(vm->svm->attr_tree, start, size, nattr, attrs);
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
+	down_write(&svm->svm_lock);
+	drm_gpusvm_fini(&svm->gpusvm);
+	up_write(&svm->svm_lock);
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
-- 
2.34.1

