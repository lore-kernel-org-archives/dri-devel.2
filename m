Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C17F3F44845
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 11:32:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AF7310E955;
	Fri, 10 Apr 2026 11:32:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GoPmMc3j";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010000.outbound.protection.outlook.com [52.101.46.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31E2D10E944;
 Fri, 10 Apr 2026 11:32:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pLJuVKHDFyHt0y8cKK0xqF2AfmMYWMeCRQS2GumEnfXwIo1d5V5Xz9K49EqeuCsduJJ9CzXFyoWLMF24V+GlipxyOwSjutySV5SYzeAvjUEHVhNRd6QEPMLcdAZxaQmJu5y/f69Ox78k9oLCI9LJ08pofpKCROmIm4BJCKRjHggAWsMS9wVeKmqI7j0Hmh7eHPHxlq2JjeexfgeF/LOD4++J2C1Fg3TP1rLwzz4L4TiiGzdgSC4gfzumXXz5SLmLzk0fU3YJStKkGf52ixFRBQgcEcsP4fyLy9qE6uYQ0VV7sXY5ziXRY2UTphkqzN44vvCixEUI5Z5FtJbxPx2u8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ovKjInpbDJirlXOhftGXeYDGUv2H7rLgUy7OELhiAl0=;
 b=eUqwKfA6MoUcvXZ4jEV8FG09F3ZeeRpGta70Y4IWQuRB4yIyRsJTbiow8HZbvJifTytByidPMdfvB57yNX3E2Z4O8YNxTVVaWjRt78CBHfBitxpuMjONpShjdx+p89Ik5swTUEgDomF1tggYur6kSPQ02e+HEMIf61hk4/6lM10tQUFaDsO8HzKg+nZS7bzFcImVO5ocnllKZPXbeBy8cwl1VUv8f9vm/QVwmUpyxglSN5DEdiF2c0OCTx0TpAAP29k0vprbK6SSz/3lVeNoo3QoYdjaUK1lN7oz183+xRtIljs3EYQF2PsvowNZwMLPDILf3rIbYPXgyPML9EgCQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovKjInpbDJirlXOhftGXeYDGUv2H7rLgUy7OELhiAl0=;
 b=GoPmMc3jlmV+Y19Or9VreZ6X950EyvgUzuOOmZ9sL/MSAO6Ybt4Eq/Zg8yPavmBfBnHa/wo+UbpLaQIc842lNATjvzfDg1ArJ3JnclooxBCSaI0V0163ULkAEnv6b4qIT5etmrnlZgsFCjHFT0Fw1mFpeCOhegTuqpkWGcrzAyQ=
Received: from DS7PR03CA0158.namprd03.prod.outlook.com (2603:10b6:5:3b2::13)
 by CY1PR12MB9652.namprd12.prod.outlook.com (2603:10b6:930:106::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Fri, 10 Apr
 2026 11:32:30 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:5:3b2:cafe::b0) by DS7PR03CA0158.outlook.office365.com
 (2603:10b6:5:3b2::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.37 via Frontend Transport; Fri,
 10 Apr 2026 11:32:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 10 Apr 2026 11:32:30 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 10 Apr
 2026 06:32:04 -0500
Received: from junhua-PC.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 10 Apr 2026 06:32:01 -0500
From: Junhua Shen <Junhua.Shen@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <honglei1.huang@amd.com>, <Lingshan.Zhu@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <junhshen@amd.com>, Junhua Shen <Junhua.Shen@amd.com>
Subject: [PATCH RFC 4/6] drm/amdgpu: add SVM eviction fences for VRAM
 overcommit
Date: Fri, 10 Apr 2026 19:31:44 +0800
Message-ID: <20260410113146.146212-5-Junhua.Shen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260410113146.146212-1-Junhua.Shen@amd.com>
References: <20260410113146.146212-1-Junhua.Shen@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|CY1PR12MB9652:EE_
X-MS-Office365-Filtering-Correlation-Id: c922e183-8f39-45e1-f76d-08de96f4d9b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: YzVM3QAaJ4UVjH3vt+H8cKeufwk7EkNqagGbPoSCHOrLDcyn1NAcr7EAnVrICWlxH3H2C9frKYHLVao+dIZgT94NE2/3bBIDLfQV0ixVSVwGdRJKAobB5QCZHtuizpPTcjzhBtC7nVADOWiOPO/NJ9VgsMXnRhWA8sEVcgNjeZMucME9etKmIf7qQ/VNf36kl72iCp0XQ9igJkJcSCVVFjGNQaIs6qdoBMCjsc4d+hAVlXctpOrLNrX20ldYmfF0UFQ8hXGqyd+y6Kkga+JNqOrjTXJeywnKKWImEzMbtNQhjxeFL/NYD2ELJrYLqCREKYlm63Gn+CTaY0DhC86kM/bx5JxSB53zLma5GaeIrG5yHPJY/1Awq8o1ebp8dy1nebamvnQsU3oxkseZ1jnb+VYPbccsN6kdKLsHqMP2iid9B+BoLNQcu8Rnc7xxaQRg3cswi6m/biz3/hhbwfOUejZx9ee++NBFgmOWD9GBd5/D6kBX/sVcEacSUMGtZQlGr1fwFtinA59WJ08/r2zFRoNDU4wULLhKJmEYAoi2avJuDOBQ7kGhZr8Y4kdfjMBw4LqJLRzN5nfZrcvdBFEFtGNGEAs1E1PPo27UHir461+Hmk2HQCAgjC7eFTG6HyuT04E/GOjrSHHvPEMi5Zp8StOjy6S+mKPOjMYj7vwkariPhbjy1+npqVQ2Z0cqbjn0ZKPAZRjUHW9KtlXPnKPLD/9/ASs81vPcPZORe9OD/P+rhgdGRHUlcKICB6xLSp2CnaD2npyee1myml8Lr+OoSlLiwnxc78iilSkAsYBAsl1LdAmJdxM8Y9vDTywN+DTQ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(921020)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OHRzyuk/iLPva/rWQRKkJ3jIZdVcHov5/12GkxfpCuOVr6ZaO980TCvvQZjEF7uH1nWBq4QX+5SpUoVB12qOS9b3GGuinS7vuM/EczGX6jK1/TYrlt/PWcfQr0uqhHQF4wSMqI1FUzeZVlQaKud7CgmjCPwJOgjAWvoOBx9f95322Om3FZdrfZfK2wJFSRfeehC/1wjHJmm1XlnEZZMaDneu416/QFqGXtgI2zdT9KNiu0LercUeSSK33SmaYpn9m0Oc4lnYc5GNXaMsPnueq3TCGvGOuiIEWapyAsD4EJw2vGJC1RRQf6qt9FiiVTh9wBv3dyPq+W0+Pkfh1M8Q2Qxu6OhClfRNxKX9m5Wf7seXhibCB0E0DZR85E8n7sX2nd9lwAhAfUvh5pc5mtenIFKJNPZvOw6xdB2Ch19g1nrhvRkuxVjU3XU7ELnpS/NC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 11:32:30.1285 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c922e183-8f39-45e1-f76d-08de96f4d9b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9652
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

Add eviction fence support so that TTM can reclaim SVM VRAM
when the system is under memory pressure.

When TTM needs to evict a DISCARDABLE SVM BO, the fence's
enable_signaling callback schedules a work item that calls
hmm_range_fault(dev_private_owner=NULL) to trigger
migrate_to_ram for all device-private pages in the BO's
virtual address range. After SDMA copies the data back to
system RAM, the fence is signaled and TTM discards the
now-empty VRAM resource.

The implementation adds:
  - struct amdgpu_svm_evict_fence with dma_fence_ops
  - amdgpu_svm_evict_bo_worker using mmu_interval_notifier
  - amdgpu_svm_evict_fence_create called from bo_alloc
  - AMDGPU_GEM_CREATE_DISCARDABLE flag on SVM BOs
  - fence attached as DMA_RESV_USAGE_BOOKKEEP

Signed-off-by: Junhua Shen <Junhua.Shen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c | 267 +++++++++++++++++++-
 1 file changed, 264 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c
index 115df0cf0f94..0724416f5aa8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c
@@ -61,8 +61,11 @@
  */
 
 #include <drm/drm_pagemap.h>
+#include <linux/dma-fence.h>
+#include <linux/hmm.h>
 #include <linux/memremap.h>
 #include <linux/migrate.h>
+#include <linux/mmu_notifier.h>
 
 #include "amdgpu_migrate.h"
 #include "amdgpu.h"
@@ -76,6 +79,10 @@
 #define FROM_RAM_TO_VRAM	0
 #define FROM_VRAM_TO_RAM	1
 
+/* Fence context for SVM eviction fences (shared by all instances) */
+static u64 amdgpu_svm_evict_fence_context;
+static atomic_t amdgpu_svm_evict_fence_seq = ATOMIC_INIT(0);
+
 static inline struct amdgpu_pagemap *
 dpagemap_to_apagemap(struct drm_pagemap *dpagemap)
 {
@@ -102,6 +109,214 @@ amdgpu_svm_page_to_apagemap(struct page *page)
 	return container_of(pgmap, struct amdgpu_pagemap, pgmap);
 }
 
+/*
+ * Eviction fence — prevents TTM from discarding BO before pages migrate back
+ */
+
+/**
+ * struct amdgpu_svm_evict_fence - Fence that gates TTM eviction of SVM BOs
+ *
+ * @base: dma_fence base (attached to BO's dma_resv as BOOKKEEP fence)
+ * @lock: Spinlock for fence signaling
+ * @eviction_work: Work item that migrates ZONE_DEVICE pages back to RAM
+ * @mm: The owning process's mm_struct (mmgrab'd)
+ * @start: Virtual address range start (inclusive)
+ * @end: Virtual address range end (exclusive)
+ *
+ * When TTM needs to evict an SVM BO (DISCARDABLE) to reclaim VRAM,
+ * it waits on this fence. The enable_signaling callback schedules
+ * the eviction worker, which uses hmm_range_fault(owner=NULL) to
+ * trigger migrate_to_ram for all device-private pages in [start, end).
+ * After migration completes the fence is signaled, allowing TTM to
+ * discard the now-empty VRAM resource.
+ */
+struct amdgpu_svm_evict_fence {
+	struct dma_fence base;
+	spinlock_t lock;
+	struct work_struct eviction_work;
+	struct mm_struct *mm;
+	unsigned long start;
+	unsigned long end;
+};
+
+static inline struct amdgpu_svm_evict_fence *
+to_amdgpu_svm_evict_fence(struct dma_fence *f)
+{
+	return container_of(f, struct amdgpu_svm_evict_fence, base);
+}
+
+/* Temporary MMU interval notifier ops for eviction worker's hmm_range_fault */
+static bool
+amdgpu_svm_evict_notifier_invalidate(struct mmu_interval_notifier *mni,
+				     const struct mmu_notifier_range *range,
+				     unsigned long cur_seq)
+{
+	return true;	/* no-op: we don't need invalidation tracking */
+}
+
+static const struct mmu_interval_notifier_ops amdgpu_svm_evict_mni_ops = {
+	.invalidate = amdgpu_svm_evict_notifier_invalidate,
+};
+
+/**
+ * amdgpu_svm_evict_bo_worker - Work item to migrate device pages back to RAM
+ * @work: Embedded work_struct in amdgpu_svm_evict_fence
+ *
+ * Registers a temporary mmu_interval_notifier and calls hmm_range_fault()
+ * with dev_private_owner=NULL, which triggers the dev_pagemap migrate_to_ram
+ * callback for each device-private page.  This copies VRAM data to system
+ * memory via SDMA.
+ *
+ * After migration (or on error), signals the fence so TTM can proceed.
+ */
+static void amdgpu_svm_evict_bo_worker(struct work_struct *work)
+{
+	struct amdgpu_svm_evict_fence *fence =
+		container_of(work, struct amdgpu_svm_evict_fence, eviction_work);
+	struct mm_struct *mm = fence->mm;
+	unsigned long start = fence->start;
+	unsigned long end = fence->end;
+	unsigned long npages = (end - start) >> PAGE_SHIFT;
+	struct mmu_interval_notifier notifier;
+	unsigned long timeout;
+	unsigned long *pfns;
+	int retries = 3;
+	int err = 0;
+
+	if (!mmget_not_zero(mm))
+		goto signal;
+
+	err = mmu_interval_notifier_insert(&notifier, mm, start, end - start,
+					   &amdgpu_svm_evict_mni_ops);
+	if (err) {
+		pr_warn("amdgpu: SVM eviction notifier insert failed: %d\n", err);
+		goto put_mm;
+	}
+
+	pfns = kvmalloc_array(npages, sizeof(*pfns), GFP_KERNEL);
+	if (!pfns)
+		goto remove_notifier;
+
+	timeout = jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
+	do {
+		struct hmm_range hmm_range = {
+			.notifier = &notifier,
+			.start = start,
+			.end = end,
+			.hmm_pfns = pfns,
+			.default_flags = HMM_PFN_REQ_FAULT,
+			.dev_private_owner = NULL,
+		};
+
+		hmm_range.notifier_seq = mmu_interval_read_begin(&notifier);
+		if (time_after(jiffies, timeout)) {
+			err = -ETIME;
+			break;
+		}
+
+		mmap_read_lock(mm);
+		err = hmm_range_fault(&hmm_range);
+		mmap_read_unlock(mm);
+	} while (err == -EBUSY && --retries);
+
+	if (err)
+		pr_warn("amdgpu: SVM eviction migration failed: %d [0x%lx-0x%lx]\n",
+			err, start, end);
+
+	kvfree(pfns);
+remove_notifier:
+	mmu_interval_notifier_remove(&notifier);
+put_mm:
+	mmput(mm);
+signal:
+	dma_fence_signal(&fence->base);
+	dma_fence_put(&fence->base);	/* drop worker's reference */
+}
+
+static const char *amdgpu_svm_fence_get_driver_name(struct dma_fence *f)
+{
+	return "amdgpu_svm";
+}
+
+static const char *amdgpu_svm_fence_get_timeline_name(struct dma_fence *f)
+{
+	return "svm_eviction";
+}
+
+/**
+ * amdgpu_svm_fence_enable_signaling - Called by TTM when it wants to evict
+ *
+ * Takes a fence reference for the worker and schedules the eviction work.
+ * The worker will migrate device pages back to RAM and signal the fence.
+ */
+static bool amdgpu_svm_fence_enable_signaling(struct dma_fence *f)
+{
+	struct amdgpu_svm_evict_fence *fence = to_amdgpu_svm_evict_fence(f);
+
+	if (dma_fence_is_signaled(f))
+		return true;
+
+	AMDGPU_MIGRATE_TRACE("evict fence enable_signaling: [0x%lx-0x%lx]\n",
+			  fence->start, fence->end);
+
+	dma_fence_get(f);	/* reference for the worker */
+	schedule_work(&fence->eviction_work);
+	return true;
+}
+
+static void amdgpu_svm_fence_release(struct dma_fence *f)
+{
+	struct amdgpu_svm_evict_fence *fence = to_amdgpu_svm_evict_fence(f);
+
+	mmdrop(fence->mm);
+	kfree_rcu(f, rcu);
+}
+
+/**
+ * amdgpu_svm_evict_fence_check_mm - Allow cross-process eviction
+ *
+ * TTM calls check_mm to see if an eviction should be skipped for the
+ * calling process.  For SVM overcommit, we always allow eviction
+ * (return false = "do not skip"), matching KFD SVM behavior.
+ */
+static const struct dma_fence_ops amdgpu_svm_evict_fence_ops = {
+	.get_driver_name = amdgpu_svm_fence_get_driver_name,
+	.get_timeline_name = amdgpu_svm_fence_get_timeline_name,
+	.enable_signaling = amdgpu_svm_fence_enable_signaling,
+	.release = amdgpu_svm_fence_release,
+};
+
+/**
+ * amdgpu_svm_evict_fence_create - Create an eviction fence for an SVM BO
+ * @mm: The owning process's mm_struct
+ * @start: VA range start
+ * @end: VA range end (exclusive)
+ *
+ * Return: Pointer to fence, or NULL on allocation failure
+ */
+static struct amdgpu_svm_evict_fence *
+amdgpu_svm_evict_fence_create(struct mm_struct *mm,
+			      unsigned long start, unsigned long end)
+{
+	struct amdgpu_svm_evict_fence *fence;
+
+	fence = kzalloc(sizeof(*fence), GFP_KERNEL);
+	if (!fence)
+		return NULL;
+
+	mmgrab(mm);
+	fence->mm = mm;
+	fence->start = start;
+	fence->end = end;
+	spin_lock_init(&fence->lock);
+	INIT_WORK(&fence->eviction_work, amdgpu_svm_evict_bo_worker);
+	dma_fence_init(&fence->base, &amdgpu_svm_evict_fence_ops, &fence->lock,
+		       amdgpu_svm_evict_fence_context,
+		       atomic_inc_return(&amdgpu_svm_evict_fence_seq));
+
+	return fence;
+}
+
 /*
  * drm_pagemap_devmem_ops — per-BO migration mechanics
  */
@@ -111,6 +326,8 @@ amdgpu_svm_page_to_apagemap(struct page *page)
  *
  * @devmem: drm_pagemap device memory allocation (passed to framework)
  * @bo: The backing VRAM amdgpu_bo
+ * @eviction_fence: Fence that gates TTM eviction — worker migrates pages
+ *                  back to RAM before signaling, so BO can be discarded
  *
  * It is allocated per-migration in populate_mm() and freed by
  * devmem_release() when all device-private pages have migrated
@@ -124,6 +341,7 @@ amdgpu_svm_page_to_apagemap(struct page *page)
 struct amdgpu_svm_bo {
 	struct amdgpu_bo *bo;
 	struct drm_pagemap_devmem devmem;
+	struct amdgpu_svm_evict_fence *eviction_fence;
 };
 
 static inline struct amdgpu_svm_bo *
@@ -149,6 +367,12 @@ amdgpu_svm_devmem_release(struct drm_pagemap_devmem *devmem_allocation)
 	AMDGPU_MIGRATE_TRACE("release svm_bo=%px bo=%px\n",
 			  svm_bo, svm_bo->bo);
 
+	if (svm_bo->eviction_fence) {
+		/* Ensure fence is signaled (e.g., process exit path) */
+		dma_fence_signal(&svm_bo->eviction_fence->base);
+		dma_fence_put(&svm_bo->eviction_fence->base);
+	}
+
 	amdgpu_bo_unref(&svm_bo->bo);
 	kfree(svm_bo);
 }
@@ -629,14 +853,27 @@ amdgpu_svm_device_map(struct drm_pagemap *dpagemap,
  * @dpagemap: The drm_pagemap for this device
  * @mm: mm_struct of the owning process
  * @size: Allocation size in bytes
+ * @start: Virtual address range start (for eviction fence)
+ * @end: Virtual address range end (for eviction fence)
+ *
+ * Allocates an amdgpu_svm_bo wrapper, creates a VRAM-only amdgpu_bo
+ * with the DISCARDABLE flag, and attaches an eviction fence.
+ *
+ * When TTM later needs to reclaim VRAM, the eviction fence's
+ * enable_signaling schedules a work item that migrates all
+ * ZONE_DEVICE pages in [start, end) back to system RAM via
+ * hmm_range_fault(owner=NULL).  After migration, the fence is
+ * signaled and TTM discards the now-empty VRAM resource.
  *
  * Return: Pointer to allocated amdgpu_svm_bo on success, ERR_PTR on failure
  */
 static struct amdgpu_svm_bo *
 amdgpu_svm_bo_alloc(struct amdgpu_device *adev,
 		     struct drm_pagemap *dpagemap,
-		     struct mm_struct *mm, unsigned long size)
+		     struct mm_struct *mm, unsigned long size,
+		     unsigned long start, unsigned long end)
 {
+	struct amdgpu_svm_evict_fence *evict_fence;
 	struct amdgpu_svm_bo *svm_bo;
 	struct amdgpu_bo_param bp = {};
 	struct amdgpu_bo *bo;
@@ -646,13 +883,20 @@ amdgpu_svm_bo_alloc(struct amdgpu_device *adev,
 	if (!svm_bo)
 		return ERR_PTR(-ENOMEM);
 
+	evict_fence = amdgpu_svm_evict_fence_create(mm, start, end);
+	if (!evict_fence) {
+		kfree(svm_bo);
+		return ERR_PTR(-ENOMEM);
+	}
+
 	bp.size = size;
 	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
 	bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
 	bp.type = ttm_bo_type_device;
 	bp.flags = AMDGPU_GEM_CREATE_NO_CPU_ACCESS |
 		   AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
-		   AMDGPU_GEM_CREATE_VRAM_CLEARED;
+		   AMDGPU_GEM_CREATE_VRAM_CLEARED |
+		   AMDGPU_GEM_CREATE_DISCARDABLE;
 
 	ret = amdgpu_bo_create(adev, &bp, &bo);
 	if (ret) {
@@ -671,8 +915,20 @@ amdgpu_svm_bo_alloc(struct amdgpu_device *adev,
 		return ERR_PTR(ret);
 	}
 
+	/* Attach eviction fence to BO reservation (BO is born reserved) */
+	ret = dma_resv_reserve_fences(bo->tbo.base.resv, 1);
+	if (ret) {
+		dma_fence_put(&evict_fence->base);
+		amdgpu_bo_unref(&bo);
+		kfree(svm_bo);
+		return ERR_PTR(ret);
+	}
+	dma_resv_add_fence(bo->tbo.base.resv, &evict_fence->base,
+			   DMA_RESV_USAGE_BOOKKEEP);
 	amdgpu_bo_unreserve(bo);
+
 	svm_bo->bo = bo;
+	svm_bo->eviction_fence = evict_fence;
 
 	drm_pagemap_devmem_init(&svm_bo->devmem,
 				adev->dev, mm,
@@ -709,7 +965,8 @@ amdgpu_svm_populate_mm(struct drm_pagemap *dpagemap,
 	struct amdgpu_svm_bo *svm_bo;
 	int ret;
 
-	svm_bo = amdgpu_svm_bo_alloc(adev, dpagemap, mm, end - start);
+	svm_bo = amdgpu_svm_bo_alloc(adev, dpagemap, mm, end - start,
+				     start, end);
 	if (IS_ERR(svm_bo))
 		return PTR_ERR(svm_bo);
 
@@ -796,6 +1053,10 @@ int amdgpu_svm_migration_init(struct amdgpu_device *adev)
 	svm_dm->hpa_base = pgmap->range.start;
 	svm_dm->initialized = true;
 
+	/* One-time init of the shared fence context for SVM eviction fences */
+	if (!amdgpu_svm_evict_fence_context)
+		amdgpu_svm_evict_fence_context = dma_fence_context_alloc(1);
+
 	dev_info(adev->dev, "SVM: registered %ldMB device memory, hpa_base=0x%llx\n",
 			size >> 20, svm_dm->hpa_base);
 	return 0;
-- 
2.34.1

