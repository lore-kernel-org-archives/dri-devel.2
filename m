Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6CD9CD6E45
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 05:49:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11EAF10F8FA;
	Fri, 29 May 2026 05:49:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oiz8zjt0";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013051.outbound.protection.outlook.com
 [40.93.201.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C93F10F8F3;
 Fri, 29 May 2026 05:49:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H5cJIR2LclJ8f9MC2Yhuz4gH+zO7lGcIHhYo0poYOb4rP83PFc4Hom2zTS7NfoxXwg3ebjUEOFU0BeY+cIauI35qtXki1e8B4kszr1UHzx8eeEm1j2ilm0QtQN4XMVp10gOiUh3pGluuJF5gDNY/dCwQ2/JjOObwWd/7rgXdcY6lCLoggamzQ0Tgj99k5R5ZDp6Lp3erukV8x2TSoJv5J3KbfOFcAXT3V+16t90Qu5vQUcz1mL2SO0NaeSFH/vWKg/Xcbg9VvyFk6IqqUdAI9d0xBcackrbdymlKXivxbywX5bAI3CcQUnbDB7ZFz8tdlN5NZQyF7kiCI6rfKiHXuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2NY8Lhj7Whu6l/2bhIfoQasmDRrJq6jvS1nJ7k+KgA=;
 b=hhewbqd1r4FiqJv/8N5dYViwMT7ZiS0To3kCv551FFdHoCQP4Wa0cOee84dghNiLFi7weab1fusJNXUT9uJcxjrB0/VrqdNi2tqc7gcWKHdHkF4dnvWRZo5fRvw8PutAZlcFySWOO/wRCdtQSK02BCoT28HtfYnmfGHHw8gRFuGsGm9//npQun8X3U3iG8qZ4XfTXPOGNRSJNFGyqTv9dpSJINpllhaGUPYmlqaZEvp7zQrnFmg2dl5RTtcfciZsm6gM7jX2otBy+MxojyuejaQ+NEtu4GlxeoxmFVKUlwUo810k19ptOkyvXhNfaQByysn+BP+fzjPkWJesQiQ3Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2NY8Lhj7Whu6l/2bhIfoQasmDRrJq6jvS1nJ7k+KgA=;
 b=oiz8zjt0q02mvlu6DslFsfsZUFpJxgLdJN2bIOiSZuHMcS0rbh7bJyo77gGabZhhdm9q05lvzLP7tdRzLoH1rWaX0bAM2B/MQODeeCC4JdO5Dba1tq3p0M6gP0A/D4dpcieXpwhysUyJZ4BsJgIux3/vp+xMb3xlS8IUe/U74Z8=
Received: from CH2PR11CA0027.namprd11.prod.outlook.com (2603:10b6:610:54::37)
 by SA3PR12MB7952.namprd12.prod.outlook.com (2603:10b6:806:316::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Fri, 29 May
 2026 05:49:08 +0000
Received: from CH2PEPF0000013B.namprd02.prod.outlook.com
 (2603:10b6:610:54:cafe::7b) by CH2PR11CA0027.outlook.office365.com
 (2603:10b6:610:54::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Fri, 29
 May 2026 05:49:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013B.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 29 May 2026 05:49:08 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 29 May
 2026 00:49:03 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>,
 <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC V7 10/12] drm/amdgpu: implement SVM initialization and lifecycle
Date: Fri, 29 May 2026 13:48:02 +0800
Message-ID: <20260529054804.596214-11-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529054804.596214-1-honglei1.huang@amd.com>
References: <20260529054804.596214-1-honglei1.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013B:EE_|SA3PR12MB7952:EE_
X-MS-Office365-Filtering-Correlation-Id: fadfd29a-426c-4789-2409-08debd460052
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|921020|22082099003|18002099003|56012099006|6133799003|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info: mNmJfLk3UDsAflDP3EIsxpLoHeJdC/pDP9Rjx11uVbXgkkAvZfqwzMn2kmfq1OAwrbq3C4r5ghcQgHexlIt3XhX6ehs5wV0r+jsYN7VjVBTx0o9iWW6cPN8dTvXqqwrzu0do1jvM8dBvinwQQAmbLA8VN/L0wT0hS2cOa3Nn3GN8vDOoIbZD8D+pu6u4fHxcvwvn4lTSe3WCXV1k3MVptLAWXNnCbPbCX4vC0Kohu2vbmsLv/nxHy8R6oB+tSIPprUPmIF4jVrKL8SgpVrj0FLqVRqljJRrpW2Uy/hNw5RXG34G0Hl059k4ZfVbskMqIVoPE0UWbi2tVTldi09HnMTqO9ppMXgqDC2EIkD2K6qwIyQ2yyOjKJclF+Ply/8ddurdjvMT2TUvCCF9GAhlHFZ3D7H0L1uaDKgH5m5gd0Xg7MGohfDPfOmuuUsK0OFYVNayTOygmHq63utKDYFOdk8IdDm8GM7foETeTcebas2w0gvm4KvY+HNiFP1ofbaw91c76Qhgd4/YiKNiFADVObrjZT+K7k7GMUwCq1Dt69APBZYaTZnLFxCrkEzxYmRCP8C0ZcbwcJt7Ff4qCfP9txKFB4qozGugBU0CCwnOF8FtHQboOsSYvFwr+j7/OQaf8DZyi8V461AFJMbg9NzXQMSK2hpl1AEw7CAOQonlIGImrBmFzYuylyR5DfC2CetHcfzhTWx42vomj7mhDiTboYYThJjvH6bcEhVl3Fucbj8p/zaxCk/GjQ9FukQ5gSVyRVt1NbKn8oLD2SXNcZac+aQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(921020)(22082099003)(18002099003)(56012099006)(6133799003)(3023799007)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /o5xZQo7yb6fT32PKaBB8bPnLJk5158wgFYSLiLIAalwRFTMj3CuTxdjJev0vgYJQM9k5OThCBOlUpJVfBl1fz95EXL94zNFfOTgb0MHMz+WAcMot1Tka9NK735w7Gmoj+eNTfjNid+rswKF8kwamnnOXQbe1lRJGovn5z5lD+6tYnE+0czfr39UD3Fn2oXQa6yGYOXGZDU2PtA5rbRbdcQjWfHDpf8QuE1SzQ4zklzdzBiLeG2yRhOaXtE/jqXPZNsZkTue/6aqET49SzZIwnTIMD+WxknL3P3/Ur8kBM4cajqLu/eS5PSqGKTDEYgL0wpBEFthHuWv0ovCOk2ZBPH2jnK8UnX9TaKROCqDxGHaGBW2xh6HvL3hxsbHZt7yRVQDGvZXViQNnYnsiRsz7yQtLtW0myZ2kpjwvaBRZA/g1Ewub4dGx6hoXrLjVVzc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 05:49:08.3400 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fadfd29a-426c-4789-2409-08debd460052
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7952
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
- PASID lookup: amdgpu_svm_lookup_by_pasid (irq-safe xa_load)
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
- Work init/fini forward declarations for init_with_ops
- Teardown: amdgpu_svm_close (mark exiting, sync work),
  amdgpu_svm_fini (gpusvm_fini, destroy attr tree, release ref)
- amdgpu_svm_is_enabled predicate

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c | 510 ++++++++++++++++++++++++
 1 file changed, 510 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
new file mode 100644
index 000000000..70e2d173b
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
@@ -0,0 +1,510 @@
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
+#define XNACK_OFF(svm)	((svm)->xnack_enabled == false)
+#define XNACK_ON(svm)	((svm)->xnack_enabled == true)
+
+static struct kmem_cache *amdgpu_svm_range_cache;
+static DEFINE_MUTEX(amdgpu_svm_cache_lock);
+
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
+	AMDGPU_SVM_TRACE(
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
+	mutex_lock(&amdgpu_svm_cache_lock);
+
+	if (amdgpu_svm_range_cache) {
+		mutex_unlock(&amdgpu_svm_cache_lock);
+		return 0;
+	}
+
+	amdgpu_svm_range_cache = AMDGPU_SVM_KMEM_CACHE_CREATE("amdgpu_svm_range_cache",
+								 struct amdgpu_svm_range);
+	if (!amdgpu_svm_range_cache) {
+		ret = -ENOMEM;
+		goto out_unlock;
+	}
+
+	ret = amdgpu_svm_attr_cache_init();
+	if (ret)
+		goto free_out;
+
+	mutex_unlock(&amdgpu_svm_cache_lock);
+	return 0;
+
+free_out:
+	amdgpu_svm_attr_cache_fini();
+	AMDGPU_SVM_KMEM_CACHE_DESTROY(amdgpu_svm_range_cache);
+out_unlock:
+	mutex_unlock(&amdgpu_svm_cache_lock);
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
+	AMDGPU_SVM_TRACE("attr change trigger=0x%x old=%d new=%d [0x%lx-0x%lx]-0x%lx, xnack=%d\n",
+			 trigger, old_access, new_access, start_page, last_page,
+			 last_page - start_page + 1,
+			 svm->xnack_enabled ? 1 : 0);
+
+	if (needs_invalidate) {
+		AMDGPU_SVM_TRACE("attr change invalidate [0x%lx-0x%lx]-0x%lx trigger=0x%x\n",
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
+static int amdgpu_svm_work_init(struct amdgpu_svm *svm,
+				void (*gc_work_func)(struct work_struct *));
+static void amdgpu_svm_work_fini(struct amdgpu_svm *svm);
+
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
+static int amdgpu_svm_init_with_ops(struct amdgpu_svm *svm,
+				    void (*invalidate_ranges)(struct amdgpu_svm *,
+						struct drm_gpusvm_notifier *,
+						const struct mmu_notifier_range *,
+						struct drm_gpusvm_range *,
+						uint64_t, uint64_t),
+				    void (*gc_work_func)(struct work_struct *),
+				    void (*flush_tlb)(struct amdgpu_svm *))
+{
+	struct amdgpu_device *adev = svm->adev;
+	int ret;
+
+	svm->flush_tlb = flush_tlb;
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
+					       amdgpu_svm_gc_work_func,
+					       amdgpu_svm_flush_tlb_compute);
+	} else {
+		AMDGPU_SVM_ERR("xnack off is not supported yet\n");
+		ret = -EOPNOTSUPP;
+	}
+
+	if (ret)
+		goto err_free;
+
+	AMDGPU_SVM_TRACE("AMDGPU SVM initialized: default granularity 0x%lx bytes, xnack: %s\n",
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
+int amdgpu_svm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm)
+{
+	/* graphics svm init maybe different */
+
+	return amdgpu_svm_init_compute(adev, vm, AMDGPU_SVM_XNACK_DEFAULT);
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
+	amdgpu_svm_sync_work(vm->svm);
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
2.34.1

