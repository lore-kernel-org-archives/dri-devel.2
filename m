Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 451F6F36C58
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 12:08:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AD2510E550;
	Mon, 20 Apr 2026 12:08:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JmK+i6vy";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012037.outbound.protection.outlook.com
 [40.107.200.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25B3910E552;
 Mon, 20 Apr 2026 12:08:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WzK+OwfK1nIIoZN0+Gn4FybkL+CpqTr4nicpywI2HqqDpwVEnyvUledcFGIqb3oUPzlwUgN3XzeE9YuW2HcfJ3P8Y2WTXgpjIuenimDwHqUYpJ5/DH4ALyQ3MPSrAIUggf3pAw5PwaT/6nGus2jmQxFQRZNL8W2jmqsLkNS05ZZfnqyPRyANOYuonEzr2Kr2VyO9/px7kU1LO/RFkBRgs9uyZfZHaCNTdeXbiPTskjxlVbVzaTE4DxyHlhfrR94MZLOa7XbMobuoT289Epiu0JcCFsqv20KpnKyNS7E+L3Q00r1PMZTjAahNJdVEUHTv9OIRJ3sjJ8l5l2X21s3v3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XykBZ+5q5XaB61Jqe7yo0NfMQdTS9SFKjUHjcdd9Yyo=;
 b=NmEXugPxYiwEXg0aeNIEmLvdQTFYSbwWS4ZUJjNGvOHXUZzuUdgtNc7Djhlyo5P6WbtL0qimyMb2+3Ck2r63ZMzNHuNNVxktdPzCRpG/bADBw+P4WDQktpleqryalYBNI1NuG5IWDI1wgYoF28wDn8COxLL4bpfub1A8s6v92HtI++k4WrLIZ7bhu6AjlXt+hwI11NTngMzxwO73c3jV8qzfeAtHC56dJr2BhsSwMCi1e5nXYxcmySFzqbXsN9VEVv29hC01O8M7MMnZbsvkGucOa7FZhjI/oSk9JTtDNXsod6K1kZeTniUKaA21xGguE8C9TZB8iZ2tePUmdnq2dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XykBZ+5q5XaB61Jqe7yo0NfMQdTS9SFKjUHjcdd9Yyo=;
 b=JmK+i6vyfF5zFCv7rQ2DU4ZsDlybZ5xMUpkctMu7FVsoRm4NC1cfqgBs7F1vfnh+/mIBB3839gefg2Px6WzvdvgrC+oLE9TRLZixD8I83TwZ7VTfHYamX7MBKd2gOphJ4M6lX68ZxvQXMzSYl2syvydLHYVUpC9Ak0I/B+7irpo=
Received: from SJ0PR05CA0084.namprd05.prod.outlook.com (2603:10b6:a03:332::29)
 by IA0PR12MB8695.namprd12.prod.outlook.com (2603:10b6:208:485::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Mon, 20 Apr
 2026 12:08:43 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::9f) by SJ0PR05CA0084.outlook.office365.com
 (2603:10b6:a03:332::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Mon,
 20 Apr 2026 12:08:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Mon, 20 Apr 2026 12:08:43 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Apr
 2026 07:08:38 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <matthew.brost@intel.com>,
 <rodrigo.vivi@intel.com>, <thomas.hellstrom@linux.intel.com>,
 <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC/POC PATCH 10/12] drm/amdgpu: implement SVM core initialization
 and fini
Date: Mon, 20 Apr 2026 20:07:37 +0800
Message-ID: <20260420120739.1811731-11-honglei1.huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|IA0PR12MB8695:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c7cddea-e5b6-4ebc-8d11-08de9ed5911b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|921020|18096099003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: biC8BaYChdPnmT14g9L3G8vY3sfQLTcO1wXdqku/uwbIlvs+a/45su4E8CdvjjvtH2MyQLs8JKpZeFS+gEVQ7+NkphTE4+bltpz0wl9GOUeHMLj+4lbzUa8aiaDg4KDujFdnscVoKW85UHBouq1L9Ku9aAG2pZ3un/8BDz/bAjx153ivivtVk/gVXwYblbkO2R+ZQfMeMlUpF2gXUsWJQzMAYxyjutSHggJGJ2zDzcq2YUBO2+yuQciP49AyY7+oX2LFxfZLhuR8MQmp/wMJ+Z6hPYHwjFfFO/KsvoQUCtBsrZSFG9R7a5U5pZc0jDUAg7iFwyM11hX3TcJ0fIZLg8yLAEdgVjma2GSCnUqw+pYKzvPnFRLYPrSm2RWHkZFfXhgbDoFycrOMRUJdfYH9dKxeKnISvwxek8ozDv0+z0obuIhVqFK+XVxZK0SNTUirmbCZGNQupnMCMXTKQ2sA1g8jdn+81EbJUcsjpwMB26zyREAePDjBPI0wxIzFG5GGv01gE8owmuFDpgirg6WWGZtWN+5q+TjdRkY1Rjikaori/7LaumyhLOa0iTUYd0n8vAs/mGn9sQNRA5sT7aeQI1w+XhvfNdVk2Ek7+y2hqHRWwDy2pCGpInOaXiDdWL44Rb86LpgVXSaNHh/17kN8J0hyu32/EVXFInhTCdjtEKHCrhBjNes7ENorBqzITr8SsxoXfdrfKTmyGhzyYtfXTZ2x754j+ALboMBdVbHKyPGXvAPlBGZFXNnIQ6NVqbvfEYIGeM6f+eFXpOWBCgWPIfFGrLx7Gakv69LP6xjPJ5XWfwKmsFBFcNI+PvuZLHxU
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(921020)(18096099003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mHgNKWuEKt3GwOzFnbKLIkTSWj7tPp/+j6Wurmy9NyEo4YmOfFNwlu5NDdoK5Y/QqMNvL5d7/uymwR/J3nP0iAldWY18E+cb7Rvc6swp+Tf07OjG/7BKIekdtBJvyPHYrTdqdTXuJKvjJQkufaEefuapouFzPoY1A7nlI744Dqbc38A6JE3EH3cVfvRpxr6NjnAhedMpNYYeNcEa8GHJXn42sLVSg9YPqZHJX1CM8PGld5shiztvNLqLUdW5EiNycM8DHOMHzetI9HI0FArkwIFI9HUFfgySBYX8rZ8GXiyotnLf1sLRfkPc1EzMEj3+v8OLPn7hQIMJXb+WfycIOm7rLVj39kok8kuE6RBsSNyA9Oh599cEXin9nWHT5+/FngGJ2AnB8qAHzqdjwVt6J0aGYePs6SrYyh/Q5LLw36g6y+ZUviN06N27VRqGneag
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 12:08:43.2152 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c7cddea-e5b6-4ebc-8d11-08de9ed5911b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8695
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

- kmem_cache management for amdgpu_svm_range
- Reference counting: kref-based release for async safety
- XNACK helper.
- TLB flush helper for compute mode
- amdgpu_svm_init_with_ops: allocate SVM context, initialize
  attr tree, work queues, and drm_gpusvm with configurable
  chunk sizes and notifier size
- amdgpu_svm_init/close/fini: public lifecycle API

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c | 270 ++++++++++++++++++++++++
 1 file changed, 270 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
new file mode 100644
index 000000000..aa40e1126
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
@@ -0,0 +1,270 @@
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
+	INIT_LIST_HEAD(&range->gc_node);
+	range->pending_start = ULONG_MAX;
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
+static void amdgpu_svm_put(struct amdgpu_svm *svm)
+{
+	if (svm)
+		kref_put(&svm->refcount, amdgpu_svm_release);
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
+				    void (*begin_restore)(struct amdgpu_svm *),
+				    void (*end_restore)(struct amdgpu_svm *),
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
+	svm->default_granularity = min_t(u8, amdgpu_svm_default_granularity, 0x3f);
+	svm->xnack_enabled = amdgpu_svm_default_xnack_enabled(adev);
+	svm->xnack_enabled = false; // WA/POC: force to disable xnack
+	svm->begin_restore = begin_restore;
+	svm->end_restore = end_restore;
+	svm->flush_tlb = flush_tlb;
+	atomic_set(&svm->kfd_queues_quiesced, 0);
+	atomic_set(&svm->evicted_ranges, 0);
+	atomic_set(&svm->exiting, 0);
+
+	ret = amdgpu_svm_range_work_init(svm);
+	if (ret)
+		goto err_free;
+
+	svm->attr_tree = amdgpu_svm_attr_tree_create(svm);
+	if (!svm->attr_tree) {
+		ret = -ENOMEM;
+		goto err_range_work_fini;
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
+	drm_gpusvm_driver_set_lock(&svm->gpusvm, &svm->svm_lock);
+	vm->svm = svm;
+	return 0;
+
+err_attr_tree_destroy:
+	amdgpu_svm_attr_tree_destroy(svm->attr_tree);
+err_range_work_fini:
+	amdgpu_svm_range_work_fini(svm);
+err_free:
+	kfree(svm);
+	return ret;
+}
+
+static int amdgpu_svm_init_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
+{
+	return amdgpu_svm_init_with_ops(adev, vm,
+					amdgpu_svm_range_restore_begin_compute,
+					amdgpu_svm_range_restore_end_compute,
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
+	amdgpu_svm_range_sync_work(vm->svm);
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
+	amdgpu_svm_range_work_fini(svm);
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

