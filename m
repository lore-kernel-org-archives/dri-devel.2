Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7CD1FF8864
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 04:11:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 741EF10ED27;
	Wed, 29 Apr 2026 04:11:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q1yO1bQM";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010011.outbound.protection.outlook.com
 [40.93.198.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE71A10EE30;
 Wed, 29 Apr 2026 04:10:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=es/pwAbVHznQrKsMZZOK1nIE4SF0gv2NOxCdmFfTn4pi2MAzfadK5+WwX+y4SPVGN1CCtEV7NWgQQSnwFwYacxb/X1AjIjkq8PMJRw6MCXzzIczRAM/cIcIiQWnelRwW7HQ0QwIj0B/uerzUuNravAAjYL30cwWaIZg3Un2ZvCvdsBSwcrtQ/15U3x60FdvTKUaUbefMcUtqsGo3p1iTWjYeRqbP5FPE5OB7AQoQ8bqCA7jQisjtjakXeV3TsNVgvVxOIbIz+2sdGgJsQGFEXMuvMnUYugjr1Ql6ls1lI6S+bFQ1oIQintP/OJbpfk5VHVRMbOvJtfn2gwVbsTKKcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zUoOkIcYzwaOL/4sexK6/lkIjBgiUhTtzmRqGMR9zuU=;
 b=uy2Du2MSYL9areyqWXY/AJDV5/PxT5LMD9ib9vk6GNat+uzwPG9DQ4zpitPa6iWcsLev4R+3fuutZ2+aasG0tbkiQWeCA1vCx7UNT610bKoOLd1/l2YWuaJs/68n7yTMrHCzS5b7WS8q1YvacvJ2VN/mo/rY4SGlNYNy72aQDbycN20gcOaerMK5ODxXkau3g8PhGAn93WBytvAk1faVfE6eQVyg/5L0set0gbtCYx6EW3bmZjeW9KJyo5XXPP17JsntH7PgUmXLGW5C9uuRwydsL9kd14f0cDmlsqR4zsyoJunu/kgU/wgbL9TKor6JYpFhvGFR+U8XZl5amkwDSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zUoOkIcYzwaOL/4sexK6/lkIjBgiUhTtzmRqGMR9zuU=;
 b=Q1yO1bQMLAr9xAvFe4zMOloeeIG+dOhh2SDVqH0AFQS5KrmHmrDz+h1/UKVDzD8XgyEzbRy8uXVB/amCtcYnfnntJBNVQWPZmr5iIo9kMhGlde6tMrWqWGjmAJicqdA5mIm6+We8WnRbLcwP2kqZ21foSKdcdX+rGX7b2wY+NFw=
Received: from SA9PR13CA0023.namprd13.prod.outlook.com (2603:10b6:806:21::28)
 by DS7PR12MB6119.namprd12.prod.outlook.com (2603:10b6:8:99::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.17; Wed, 29 Apr 2026 04:10:43 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:21:cafe::b5) by SA9PR13CA0023.outlook.office365.com
 (2603:10b6:806:21::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Wed,
 29 Apr 2026 04:10:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 04:10:43 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Apr
 2026 23:10:36 -0500
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Apr
 2026 21:07:30 -0700
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <sima@ffwll.ch>,
 <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC V4 10/12] drm/amdgpu: implement SVM initialization and lifecycle
Date: Wed, 29 Apr 2026 12:06:26 +0800
Message-ID: <20260429040628.853079-11-honglei1.huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|DS7PR12MB6119:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f353d3f-efe7-40ca-4b0a-08dea5a54826
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: CAFyKMqLjDaSn03aTp+5D5V0U2MrtMK08NCRdri0JlXHfmYc0fKh+RIN0JKmXKN9sRAjNv7y7MCXDh0CkuXZ4MWBZ1TSvhtN1FrnsB2kexTSMRRq/27Be1qtiRkMojHGB2SdmM2mDjaSkAal4jbYinYxcz4gS8ub9BuLuyiX0xdXaug6Roqr54XE3ZUJTQY2BKJiqNOI7vNVZEivE9oizpDqwrO5e22JAHgEur5jXcZsTO//w1ltHzxTpHcL/JJRkRa3V3NFfWUee5XVTPS8UjwXBy+FRd0vuySE3M2cQP+9iN/UXzgM/VszHh8UUVe97Y/TbZx0Ngcou6akOyws3FW6t6PqnG1fvahY72sFXiwhQE3BIyVvj4XCnlK7HxxkQB4nI87RRH+IZOdRdKAgY0fUmMkUAIKIJpdFSCz+DUtqf9tVe4vaLouxXbwo8kpNy4WQaegl+sHZllUyVzHiScZktP/soXciMwwda0YooKbXMUxrwLiQmR5S0ITzl4L8sICwBQy6UVtotXgEB2Csn1sIDHpapIlLDSkwPwr4RzV40oKNxfhAD225qccHSMZIDeoPTUXF3fWcq8pRcj3oZ4HUk5L8gJpwdWHbuJOjqQvE/7wAgUt49AHViyeElXbhhGy3mPPDZkV9PmcI0GogoCR81E4H1CyMuB+aQwVFrIXYMWc5jkk/JXn2eYfO37gHkuP1vgWcmzu9unti1c4XLyKy84K+opGla2xpLldyDC9lMT//fSZF//kTtfZsamcNQqxbbVEMH1Zfrf6UjnyA4Skdi7Taa1THE1vHl0D/zGSQg5LuGT4cH5v1W0NEJXCu
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YocrnohWfQaZJoqywQHH5EvSFPXcALTu0iFW5xltLlvg9f+wb6vIvwtZ+E5i1aZCads9di3RUHPLTNdjNzoCXc/HhIPWv9tv1JkNFxvXrKfrhfIHTgh/EPV0NhkPwVulGJro0rCOrvgwWuIzP6smRZd9dit0TI8YpcoDeToPbNm8+0o6AM/hFqXij5LsXm/Z3x1LyEhkWZQRFt+j7t/AbL4CZY4B65kj8zb8ZIyBbsiPCKaaQRDdiTrgquoi2suVzb0KQi4ZQkg9yL7nfHeS+hzRHfzXikZdTQY/3iYArKli02lvkZ/Pdhp7y8rXaP7ODEfFaeix+KQcITOM5C4/Ca9+RIrdI6svp0ssVhSdhRHR86AtaP5eRPjGWIQ0b0XSHf/2hoPjpd2J9D9tMJWf5zJxi8Pzehz7kRq1lXH32jvNamwKcMa7uYuUaPXo36Km
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 04:10:43.1233 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f353d3f-efe7-40ca-4b0a-08dea5a54826
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6119
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

Implement amdgpu_svm.c core: drm_gpusvm callbacks, kref lifecycle,
PASID lookup, kmem_cache management, xnack detection, TLB flush,
init with chunk sizes (2M/64K/4K), and teardown paths.

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c | 318 ++++++++++++++++++++++++
 1 file changed, 318 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
new file mode 100644
index 000000000..e21b562ad
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
@@ -0,0 +1,318 @@
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

