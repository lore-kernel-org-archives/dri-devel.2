Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B1FEC55184
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 09:44:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95EE210E976;
	Tue,  4 Aug 2026 09:44:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tCJ3zeUN";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010042.outbound.protection.outlook.com [52.101.61.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73C0D10E973;
 Tue,  4 Aug 2026 09:43:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AWZaj7H+LOSZIUvmFioErOb+FIbQliB56/wpvsZhhHRad9rzFzZz/WRxz93mK2Qiozh1/wbqax84vY78mcqaHWaJ9K0uDKs9VjskJBDklJA0BdjoahROLe/BxZ/d5dimsk+mlO3ssKjuspFAYtf8sHTFZMJb/FyYd9rN1OBoblzRh6U6YyUNIkZ9hNI224OO5mUpLLfoLjngusvFzV4Va5h6orJTsAfNWGB8xsKFYCccQJIMz8enzQp6O2OZKxGVsU/vA0/c4MNepBI9DRY6F6dLSN/974rxHFe8zcTDFp29s1Qe4ugP0sTvfpk5Zk0Oq/fneEQe8SjeVtbkYnYNXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sX1YvTejaR+mUTdggGLmNls8B9g/HLhqsiKTh1tDN/U=;
 b=hP0uueCCy3ySRqAQp/F5nr/OqXNQUsfLjiIChmbWCK22l6ZXTMrstHoI26A1gFI6c3hzAxiRNuC60yKB0vDVxqRnuhFfx7rtmaFm7DSzZsVZhtrJlzNQh3bevYYXOvYBP0satq9Heo3N1aoHPLK+XCmQ29hMPk2wAQmNKSsLFbB0aMUiOJN2FsjNpHYjO1toetJRFXoCBGp5n6ANkmJe9U7eKMcY2gruvdeo2ztc+Sc/kB24cQLNuiTKPEt/n8xogh+aDBcQmM9Haj3+4v2NCSrITT/LQZVFkfTyCi4L+wUj7cgsBTjzGuB9ScY6UW5VB4JmdFcDEWJ6/Xn5rix3xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sX1YvTejaR+mUTdggGLmNls8B9g/HLhqsiKTh1tDN/U=;
 b=tCJ3zeUNIjpA0gQBaFvQ2ukqOuBnFu2cy70cgDT2yjMVwi+bz9vzW4Bi/Z1EfX6EK08XU3GfxvZ2dalxpF0UpF6jXyX3ABwCAFH60oIdvSVn8yQhVw2VDchl+5aGewSj24sOMxOWCk3tnoMlUvXXMBV0H6aPBdH/dhPTpKTpA6Y=
Received: from MW4PR03CA0214.namprd03.prod.outlook.com (2603:10b6:303:b9::9)
 by BL1PR12MB5923.namprd12.prod.outlook.com (2603:10b6:208:39a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 09:43:53 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:303:b9:cafe::76) by MW4PR03CA0214.outlook.office365.com
 (2603:10b6:303:b9::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.15 via Frontend Transport; Tue, 4
 Aug 2026 09:43:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 09:43:52 +0000
Received: from hr-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 4 Aug
 2026 04:43:46 -0500
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
Subject: [PATCH v9 10/18] drm/amdgpu: implement SVM initialization and
 lifecycle
Date: Tue, 4 Aug 2026 17:42:36 +0800
Message-ID: <20260804094246.1719318-11-ray.huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|BL1PR12MB5923:EE_
X-MS-Office365-Filtering-Correlation-Id: 5be7c633-e729-42bb-833f-08def20ce4b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|921020|6133799003|7136999003|56012099006|10067099003|11063799006|5023799004|11062099010|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: fT8yYvgZfoV6DiSoqk+IDJopW4tr6no/JmbukP4igeNEAcn84dbJE4shRGeO+L7Uq4ZbH72G+LDd5x/2kTrtvaOzLkRH/IA688oT+xfY9Itu12ZkMtIYH7vuGS7RNCFC/6pvVmu8vQft3hDL6wmJVPFZfq/++/S4o/Q84TA36qM+9i3D3JQ8B0K8vs3cp2SLZFrou59th/YxUXaQd0AHs1pLlt5mEGrfZNhzuYoWV22nEXFFzWh7DWvOO9xDeTZbCfLb7BCGs/uOq+1ixQz1qnbxDyE06CNYs4hrU+HzUgbmUh+0Y2ITRh9ax7lAFfQY1DzNc7n6t6Ki31U9VitEftwCNDIN1BwcKlwcDmNrU/lgi+PyRlqPeCjD7r9iwVNdv+IBSJt6TO0Njp/libWtx8FdTWVOl5vkAI7lQJ6G5i3cpJ4EFS22/9TybdDHXy5MUbZKW37jN//17l7HbnlQETtM763TD51gDQy5aYxHI+PRghbBiohtxXoxC534WR/LldsrIQe0/yrFAD+a5HpOBQXH66YldwUZFH9RaEjJ8H1O+sC73gv0sDmF6jtTCXcSKtTnBIDfdZjRd7p1LPqlDJtNR7YFMDK/fL+56IQc+V0hIgspV2pkGRE5kcnwqf0Vxbxakpt1nbJFJtwkqt58IAPiJN3TZETO9RPmjpuhYrgvUQ6/do3Q0VPrllFcexAR7aQwpBAej45UQ/9JvgEJPy07ImSFqVk4uOSygN4aS7EGNLB0JF6eDNFDVs2ONjH1
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(921020)(6133799003)(7136999003)(56012099006)(10067099003)(11063799006)(5023799004)(11062099010)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MrcSRRRKT7uvLcCDyIT0ytBctPu8ejHT19MSUE1ZFgu5hWYZwyF5yjqlU3BNMAw0U2u1SlEmdZkDVlMeJDEgGwYlLwVmB1iQYvJ/XJZJH0Y7pzaHTVWURvmhDA2Mmvmmg42J4+4FbEqyymLKxOdOHbn4+zAZhgXFsgw+m+4cx/c85jaNIb5d9BK7sVaSAkf9yUf5zrIqSRNW4ye94/s4jb437m++UoXE9PGPDzaiSqeUEo599uk6oy+gZzELAZ5YHUaL9DzLPV6cB3Dca0a3lr5tJE3gyusFKqrKkXponmx/VJI9KjhbN30YJI/5AIoJuHXz5xN1GIr2EzY0vWP2dhm2rFv4E39aHxPo7dQrI5/Svtxz1zNnLZ8P+OHlFl+SBNqZ1NuQHxEQK7L9oeWiOvTVyk5kxdurRpf3haz4WMwCJR6h1R+E4nlVlT56piiQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 09:43:52.2613 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5be7c633-e729-42bb-833f-08def20ce4b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5923
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
- XNACK_OFF/ON helper macros for xnack state checks
- Static amdgpu_svm_cache_lock mutex for slab cache lifecycle
- drm_gpusvm_ops callbacks: range_alloc (kmem_cache), range_free,
  invalidate (dispatches via svm->invalidate_ranges callback)
- kref-based lifecycle: amdgpu_svm_release, amdgpu_svm_put
- PASID lookup: amdgpu_svm_lookup_by_pasid
- Slab cache management: amdgpu_svm_cache_init/fini
- Ioctl operation wrappers: op_set_attr, op_get_attr, op_reset_attr
- Attribute change detection and application:
  attr_change_trigger classifies changes into trigger types,
  amdgpu_svm_apply_attr_change dispatches invalidate or remap
  based on trigger flags and xnack state
- Hardware detection: amdgpu_svm_default_xnack_enabled per GC IP
- TLB flush: amdgpu_svm_flush_tlb_compute
- xnack mode: amdgpu_svm_init_xnack_mode validates requested mode
- Initialization: amdgpu_svm_init_with_ops (drm_gpusvm_init with
  2M/64K/4K chunk sizes, attr tree, invalidate_ranges/flush_tlb
  callbacks), amdgpu_svm_init_compute with xnack_mode parameter
- Teardown: amdgpu_svm_close (mark exiting, sync work),
  amdgpu_svm_fini (gpusvm_fini, destroy attr tree, release ref)

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c | 624 ++++++++++++++++++++++++
 1 file changed, 624 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
new file mode 100644
index 0000000000000..7dc43470037d2
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
@@ -0,0 +1,624 @@
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
+#include "amdgpu_ih.h"
+#include "amdgpu_reset.h"
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
+#define XNACK_OFF(svm)	((svm)->xnack_enabled == false)
+#define XNACK_ON(svm)	((svm)->xnack_enabled == true)
+
+/**
+ * amdgpu_svm_invalidate() - drm_gpusvm invalidate callback
+ * @gpusvm: The drm_gpusvm instance.
+ * @notifier: The GPU SVM notifier reporting the event.
+ * @mmu_range: The MMU notifier range describing the invalidation.
+ *
+ * Clamp the event to the notifier window, find the first affected range and
+ * dispatch to the driver's @invalidate_ranges handler.
+ */
+static void amdgpu_svm_invalidate(struct drm_gpusvm *gpusvm,
+				  struct drm_gpusvm_notifier *notifier,
+				  const struct mmu_notifier_range *mmu_range)
+{
+	struct amdgpu_svm *svm = to_amdgpu_svm(gpusvm);
+	struct drm_gpusvm_range *first;
+	uint64_t adj_start = mmu_range->start, adj_end = mmu_range->end;
+
+	amdgpu_svm_assert_in_notifier(svm);
+
+	AMDGPU_SVM_DBG(
+		"INVALIDATE: pasid=%u, gpusvm=%p, seqno=%lu, [0x%016lx-0x%016lx]-0x%lx, ev=%d\n",
+		svm->vm->pasid, &svm->gpusvm,
+		notifier->notifier.invalidate_seq,
+			 mmu_range->start, mmu_range->end,
+			 mmu_range->end - mmu_range->start, mmu_range->event);
+
+	if (mmu_range->event == MMU_NOTIFY_RELEASE)
+		return;
+	if (atomic_read(&svm->exiting))
+		return;
+
+	adj_start = max(drm_gpusvm_notifier_start(notifier), adj_start);
+	adj_end = min(drm_gpusvm_notifier_end(notifier), adj_end);
+
+	first = drm_gpusvm_range_find(notifier, adj_start, adj_end);
+	if (!first)
+		return;
+
+	svm->invalidate_ranges(svm, notifier, mmu_range, first,
+			       adj_start, adj_end);
+}
+
+static struct drm_gpusvm_range *amdgpu_svm_range_alloc(struct drm_gpusvm *gpusvm)
+{
+	struct amdgpu_svm_range *range;
+
+	range = kzalloc(sizeof(*range), GFP_KERNEL);
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
+	kfree(to_amdgpu_svm_range(range));
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
+/**
+ * amdgpu_svm_put() - Drop a reference on an SVM context
+ * @svm: The SVM context.
+ *
+ * Release a reference taken on @svm and free it once the last reference is
+ * dropped.
+ */
+void amdgpu_svm_put(struct amdgpu_svm *svm)
+{
+	if (svm)
+		kref_put(&svm->refcount, amdgpu_svm_release);
+}
+
+/**
+ * amdgpu_svm_lookup_by_pasid() - Find the SVM context for a PASID
+ * @adev: The amdgpu device.
+ * @pasid: The PASID to look up.
+ *
+ * Look up the VM bound to @pasid and return its SVM context with a reference
+ * taken. The caller must drop it with amdgpu_svm_put().
+ *
+ * Return: The referenced SVM context, or %NULL if none is bound.
+ */
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
+static int amdgpu_svm_op_set_attr(struct amdgpu_vm *vm,
+				  uint64_t start,
+				  uint64_t size,
+				  uint32_t nattr,
+				  const struct drm_amdgpu_svm_attribute *attrs)
+{
+	struct amdgpu_svm *svm = vm->svm;
+
+	amdgpu_svm_sync_work(svm);
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
+	amdgpu_svm_sync_work(vm->svm);
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
+	amdgpu_svm_sync_work(svm);
+
+	return amdgpu_svm_attr_reset(svm->attr_tree,
+				     start_page, last_page);
+}
+
+/**
+ * attr_change_trigger() - Classify what an attribute update changed
+ * @old_attrs: Attributes before the update.
+ * @new_attrs: Attributes after the update.
+ *
+ * Compare the two attribute sets and return an
+ * amdgpu_svm_attr_change_trigger bitmask describing which aspects changed:
+ * access, PTE flags, mapping flags, location, granularity, prefetch.
+ *
+ * Return: The trigger bitmask.
+ */
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
+/**
+ * amdgpu_svm_apply_attr_change() - React to an attribute change on a range
+ * @svm: The SVM context.
+ * @old_attrs: Attributes before the change.
+ * @new_attrs: Attributes after the change.
+ * @start_page: First page of the affected interval.
+ * @last_page: Last page of the affected interval.
+ *
+ * Classify the change and act on it: when XNACK is on and the change affects
+ * existing GPU mappings, invalidate the interval; when the new attributes
+ * request a prefetch, map / remap the interval with the new attributes.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int amdgpu_svm_apply_attr_change(struct amdgpu_svm *svm,
+				 const struct amdgpu_svm_attrs *old_attrs,
+				 const struct amdgpu_svm_attrs *new_attrs,
+				 unsigned long start_page,
+				 unsigned long last_page)
+{
+	bool old_access, new_access;
+	bool needs_invalidate = false;
+	bool needs_mapping = false;
+	uint32_t trigger;
+	int ret;
+
+	amdgpu_svm_assert_locked(svm);
+
+	if (!start_page && !last_page)
+		return 0;
+
+	trigger = attr_change_trigger(old_attrs, new_attrs);
+	old_access = amdgpu_svm_attr_has_access(old_attrs->access);
+	new_access = amdgpu_svm_attr_has_access(new_attrs->access);
+	if (XNACK_ON(svm) &&
+	    (trigger & AMDGPU_SVM_ATTR_TRIGGER_NEED_INVALIDATE))
+		needs_invalidate = true;
+
+	if (trigger & AMDGPU_SVM_ATTR_TRIGGER_PREFETCH)
+		needs_mapping = true;
+
+	if (!trigger && !needs_mapping)
+		return 0;
+
+	AMDGPU_SVM_DBG("attr change trigger=0x%x old=%d new=%d [0x%lx-0x%lx]-0x%lx, xnack=%d\n",
+			 trigger, old_access, new_access, start_page, last_page,
+			 last_page - start_page + 1,
+			 svm->xnack_enabled ? 1 : 0);
+
+	if (needs_invalidate) {
+		AMDGPU_SVM_DBG("attr change invalidate [0x%lx-0x%lx]-0x%lx trigger=0x%x\n",
+				 start_page, last_page,
+				 last_page - start_page + 1, trigger);
+		ret = amdgpu_svm_range_invalidate_interval(svm, start_page,
+							   last_page);
+		if (ret) {
+			AMDGPU_SVM_ERR(
+				"failed to invalidate range for attr change: [0x%lx-0x%lx], ret=%d\n",
+				start_page, last_page, ret);
+			return ret;
+		}
+	}
+
+	if (!needs_mapping)
+		return 0;
+
+	return amdgpu_svm_range_map_attrs(svm, new_attrs,
+					  start_page << PAGE_SHIFT,
+					  (last_page + 1) << PAGE_SHIFT);
+}
+
+bool amdgpu_svm_devmem_possible(struct amdgpu_svm *svm)
+{
+	if (svm->adev->apu_prefer_gtt)
+		return false;
+
+	/* TODO: add amdgpu_pagemap_capable() */
+
+	return false;
+}
+
+/**
+ * amdgpu_svm_default_xnack_enabled() - Whether XNACK defaults to on for the HW
+ * @adev: The amdgpu device.
+ *
+ * Decide the default retry fault (XNACK) policy from the GC IP version and
+ * platform constraints.
+ *
+ * Return: true if XNACK should default to enabled.
+ */
+static bool amdgpu_svm_default_xnack_enabled(struct amdgpu_device *adev)
+{
+	uint32_t gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
+
+	if (gc_ver < IP_VERSION(9, 0, 1))
+		return false;
+	if (!amdgpu_sriov_xnack_support(adev))
+		return false;
+
+	if (adev->gmc.noretry)
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
+
+	return true;
+}
+
+void amdgpu_svm_flush_tlb(struct amdgpu_svm *svm)
+{
+	amdgpu_vm_flush_compute_tlb(svm->adev, svm->vm, TLB_FLUSH_HEAVYWEIGHT,
+				    svm->adev->gfx.xcc_mask);
+}
+
+static int amdgpu_svm_work_init(struct amdgpu_svm *svm,
+				void (*gc_work_func)(struct work_struct *));
+static void amdgpu_svm_work_fini(struct amdgpu_svm *svm);
+
+/**
+ * amdgpu_svm_init_xnack_mode() - Resolve the requested XNACK mode
+ * @adev: The amdgpu device.
+ * @mode: The requested XNACK mode.
+ * @xnack_enabled: Output, set to the resolved enable state.
+ *
+ * Validate @mode against the hardware default: DEFAULT follows the HW policy,
+ * ON is rejected if the HW does not support it, OFF always disables.
+ *
+ * Return: 0 on success, -EOPNOTSUPP if ON is unavailable, -EINVAL on a bad
+ * mode.
+ */
+static int amdgpu_svm_init_xnack_mode(struct amdgpu_device *adev,
+				    enum amdgpu_svm_xnack_mode mode,
+				    bool *xnack_enabled)
+{
+	bool xnack_default = amdgpu_svm_default_xnack_enabled(adev);
+
+	switch (mode) {
+	case AMDGPU_SVM_XNACK_DEFAULT:
+		*xnack_enabled = xnack_default;
+		break;
+	case AMDGPU_SVM_XNACK_ON:
+		if (!xnack_default) {
+			AMDGPU_SVM_ERR("xnack on not available (mode=%d)\n",
+					mode);
+			*xnack_enabled = xnack_default;
+			return -EOPNOTSUPP;
+		}
+		*xnack_enabled = true;
+		break;
+	case AMDGPU_SVM_XNACK_OFF:
+		*xnack_enabled = false;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * amdgpu_svm_init_with_ops() - Initialize the SVM core with driver callbacks
+ * @svm: The SVM context to initialize.
+ * @invalidate_ranges: Callback invoked from the MMU notifier path.
+ * @gc_work_func: Work function draining the garbage collector.
+ *
+ * Set up the work queues, attribute tree and the embedded drm_gpusvm (with
+ * the 2M/64K/4K chunk sizes and the driver lock), wiring the supplied
+ * callbacks.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+static int amdgpu_svm_init_with_ops(struct amdgpu_svm *svm,
+				    void (*invalidate_ranges)(struct amdgpu_svm *,
+						struct drm_gpusvm_notifier *,
+						const struct mmu_notifier_range *,
+						struct drm_gpusvm_range *,
+						uint64_t, uint64_t),
+				    void (*gc_work_func)(struct work_struct *))
+{
+	struct amdgpu_device *adev = svm->adev;
+	int ret;
+
+	svm->invalidate_ranges = invalidate_ranges;
+
+	ret = amdgpu_svm_work_init(svm, gc_work_func);
+	if (ret)
+		return ret;
+
+	svm->attr_tree = amdgpu_svm_attr_tree_create(svm);
+	if (!svm->attr_tree) {
+		ret = -ENOMEM;
+		goto err_work_fini;
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
+
+	return 0;
+
+err_attr_tree_destroy:
+	amdgpu_svm_attr_tree_destroy(svm->attr_tree);
+err_work_fini:
+	amdgpu_svm_work_fini(svm);
+	return ret;
+}
+
+static void amdgpu_svm_gc_work_func(struct work_struct *w);
+
+/**
+ * amdgpu_svm_init_compute() - Create the SVM context for a compute VM
+ * @adev: The amdgpu device.
+ * @vm: The VM to attach the SVM context to.
+ * @xnack_mode: The requested XNACK mode.
+ *
+ * Allocate and initialize an SVM context for @vm (idempotent if one already
+ * exists), resolving the XNACK mode and wiring the compute callbacks. XNACK
+ * off is not supported yet.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+static int amdgpu_svm_init_compute(struct amdgpu_device *adev,
+				   struct amdgpu_vm *vm,
+				   enum amdgpu_svm_xnack_mode xnack_mode)
+{
+	struct amdgpu_svm *svm;
+	int ret;
+
+	if (vm->svm)
+		return 0;
+
+	svm = kzalloc(sizeof(*svm), GFP_KERNEL);
+	if (!svm)
+		return -ENOMEM;
+
+	kref_init(&svm->refcount);
+	svm->adev = adev;
+	svm->vm = vm;
+	svm->default_granularity = min_t(u8, amdgpu_svm_default_granularity, 0x1B);
+	atomic_set(&svm->exiting, 0);
+
+	ret = amdgpu_svm_init_xnack_mode(adev, xnack_mode,
+					  &svm->xnack_enabled);
+	if (ret)
+		goto err_free;
+
+	if (svm->xnack_enabled) {
+		ret = amdgpu_svm_init_with_ops(svm,
+					       amdgpu_svm_range_invalidate,
+					       amdgpu_svm_gc_work_func);
+	} else {
+		AMDGPU_SVM_ERR("xnack off is not supported yet\n");
+		ret = -EOPNOTSUPP;
+	}
+
+	if (ret)
+		goto err_free;
+
+	AMDGPU_SVM_DBG("AMDGPU SVM initialized: default granularity 0x%lx bytes, xnack: %s\n",
+	       1UL << (svm->default_granularity + PAGE_SHIFT),
+	       svm->xnack_enabled ? "enabled" : "disabled");
+
+	vm->svm = svm;
+	return 0;
+
+err_free:
+	kfree(svm);
+	return ret;
+}
+
+/**
+ * amdgpu_svm_init() - Initialize SVM for a VM
+ * @adev: The amdgpu device.
+ * @vm: The VM to enable SVM on.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int amdgpu_svm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm)
+{
+	/* graphics svm init maybe different */
+
+	return amdgpu_svm_init_compute(adev, vm, AMDGPU_SVM_XNACK_DEFAULT);
+}
+
+/**
+ * amdgpu_svm_drain_retry_fault() - Wait for retry faults to drain
+ * @adev: The amdgpu device.
+ *
+ * Wait until the interrupt handler has processed up to the current checkpoint
+ * on the relevant IH rings, so no stale retry faults remain in flight. Skips
+ * draining during a GPU reset or if the reset domain cannot be entered.
+ */
+static void amdgpu_svm_drain_retry_fault(struct amdgpu_device *adev)
+{
+	if (!adev)
+		return;
+
+	if (amdgpu_in_reset(adev))
+		return;
+
+	if (!down_read_trylock(&adev->reset_domain->sem))
+		return;
+
+	amdgpu_ih_wait_on_checkpoint_process_ts(adev,
+		adev->irq.retry_cam_enabled ?
+			&adev->irq.ih : &adev->irq.ih1);
+	if (adev->irq.retry_cam_enabled)
+		amdgpu_ih_wait_on_checkpoint_process_ts(adev,
+			&adev->irq.ih_soft);
+
+	up_read(&adev->reset_domain->sem);
+}
+
+/**
+ * amdgpu_svm_close() - Begin SVM teardown for a VM
+ * @vm: The VM whose SVM context is closing.
+ *
+ * Mark the context as exiting (once), flush pending GC work and drain
+ * in-flight retry faults. Safe to call on a VM without an SVM context.
+ */
+void amdgpu_svm_close(struct amdgpu_vm *vm)
+{
+	struct amdgpu_svm *svm = vm->svm;
+
+	if (!svm)
+		return;
+
+	if (atomic_xchg(&svm->exiting, 1))
+		return;
+
+	amdgpu_svm_sync_work(svm);
+	amdgpu_svm_drain_retry_fault(svm->adev);
+}
+
+/**
+ * amdgpu_svm_fini() - Finalize and release a VM's SVM context
+ * @vm: The VM whose SVM context is being torn down.
+ *
+ * Close the context, tear down the embedded drm_gpusvm under the SVM lock,
+ * destroy the attribute tree and work queues, and drop the context
+ * reference. Safe to call on a VM without an SVM context.
+ */
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
+	amdgpu_svm_attr_tree_destroy(svm->attr_tree);
+	amdgpu_svm_work_fini(svm);
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
2.53.0

