Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B58606A32D
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=iQmoTSSR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEF94112879;
	Fri, 27 Nov 2026 08:43:02 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010034.outbound.protection.outlook.com [52.101.85.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8D14112864;
 Fri, 27 Nov 2026 08:42:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FepM4dByoe2isQCdr7aIdJuvOAZyc2OHELsKF5TRj/RamMTTQ3BgVg4tTml1uWsmXJEqFfgNBhYrYFJlbzEvEGNOiwTlg2dVrDzZMi3bxz3YgeqBi4rkgVPTFzxNV5RMrJuTWLcPQBR7bqItqfeiNmkYWTtRy6JUz6lR19nygfGs6lgpI6xyhV5p2XDDfDb/SLaOqFuNkHnovvQz/H/KR+wvMrbN75MVUmRDt8lPuzBMpLbfK5gevlGY/oikG1HYQwoc+1qRnD4Rst3b4sTRLyJBwXPHtLHcAMYDkUqwEk3RimZELSGsSkfhE2oO6BllU2rUyqK2W0k9OHC1uRWxTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pAuQVbuazBYsuTxWsCM8lLYl2Yv72Khn9VS5acqX1q8=;
 b=nM/IavVzKpJajVuQubU3QanHbHlOeKBxqE4bM9XIJtXOVM4V0KPA4mhxp8A3QxMeU3aT1aBi7C3AYBYs7Nd4+CDGS2UqmLz4PZ6Iy4FYYT4OFhWSqu/pzam7sG+JTxQ7unde/EQRIXWQlqXnS1h9XVesgfDqvL+c97ptYiG5l6AsgA95931P8h4KQ9P+RyYURwmlPkkvr2x3tuvZVSBOlsLaY9rfu1vjaMo8fchpxTDlLxxSr96kDzok61KeNNJVbLxb+3AScq5+2T9gcwWeW8x5xOiArBwkwZ748CiTNutSfBlPMF14fNgNtiN4JR5CJ0pS3+B1l8HOqwJxk15jNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pAuQVbuazBYsuTxWsCM8lLYl2Yv72Khn9VS5acqX1q8=;
 b=iQmoTSSRaNWupd0BBseJrKaD+0iEcJdpxljW4LA5TUpc6kth5j/uUveE4nnKEU1yZx6jxwCwz4SztOEY3rP+soy/6oTFAnT+SiQGmbmJgDxLhgx52KMb7tTPDjkwRtx53QCX+JC5yWLDGjE5Ccwp94JsVFgKHoEpDi1Umo3Lasg=
Received: from CH0PR13CA0003.namprd13.prod.outlook.com (2603:10b6:610:b1::8)
 by DS4PR12MB999077.namprd12.prod.outlook.com (2603:10b6:8:2f9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 08:42:40 +0000
Received: from CH2PEPF000166C1.namprd04.prod.outlook.com
 (2603:10b6:610:b1:cafe::2a) by CH0PR13CA0003.outlook.office365.com
 (2603:10b6:610:b1::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.688.4 via Frontend Transport; Fri, 27
 Nov 2026 08:42:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF000166C1.mail.protection.outlook.com (10.167.252.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 08:42:40 +0000
Received: from hr-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 02:42:35 -0600
From: Huang Rui <ray.huang@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, Alex Deucher <alexander.deucher@amd.com>, "Felix
 Kuehling" <felix.kuehling@amd.com>, Simona Vetter <simona@ffwll.ch>, "Matthew
 Brost" <matthew.brost@intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Aveline Noir <jm5905938@gmail.com>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>
CC: Xiaogang Chen <xiaogang.chen@amd.com>, Oak Zeng <Oak.Zeng@amd.com>, "Jenny
 Liu" <Jenny-Jing.Liu@amd.com>, Zhu Lingshan <lingshan.zhu@amd.com>,
 "Honglei
 Huang" <honglei1.huang@amd.com>, Junhua Shen <Junhua.Shen@amd.com>, Yiru Ma
 <yiru.ma@amd.com>, Huang Rui <ray.huang@amd.com>, Honglei Huang
 <honghuan@amd.com>
Subject: [PATCH v11 10/22] drm/amdgpu: implement SVM initialization and
 lifecycle
Date: Fri, 27 Nov 2026 16:41:33 +0800
Message-ID: <20261127084149.925625-11-ray.huang@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261127084149.925625-1-ray.huang@amd.com>
References: <20261127084149.925625-1-ray.huang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000166C1:EE_|DS4PR12MB999077:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d186083-5d9d-4651-9074-08df4c6265ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|82310400026|376014|921020|56012099006|10067099003|261026140227099003|261026121527099003|261022105027099003|261022113327099003|261022115727099003|261022075727099003|261021121427099003|261021123027099003|261028144727099003|261102123227099003|261009223327099003|261009223027099003|261009220027099003|261009221227099003|261009221727099003|5023799004|7136999003|11062099010|18002099003|22082099003|11063799006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: xQ55AkVvruOgZAv6LKTaC9cthz+oyJzal7rbIUrFWKWwZQ2xq1OMb3vPM0ADX9KqqpsmBBIfF3aWnXx15pT14uFVZOPtBSjKEp88rM3KtmrcPRsKZ7U3siqXvsy/f4zYfm9MqX+ME9bBVn4GLKfQGSgqIVi07PJYZwXKvPtb4x/P1kGClzKSdL+TgXpagtCJl/OF8UPpnEUM7qe5BjacKMQXCDU5l5j7lZEkvPxkDKgT7wYhogPL6WyIKEbxiP5xWrpiWJV8n6gGHNZSdIQC+gyf3aPUcTPLVyx7Sv7JJutr4RbYxWnyrKNLLIyLpculecnEsbO1JVuY9GJabIQCPKI7cF/D6TpXrN5h6ZWFSLP8XWWB9CWYHb2vuSPRZRI+MMQEjRAMIBuQQpPSlTuQx/XQTlKJnOoR+rv5iRo3hoWtXWP/84yZXcgmLjnjcPtsY5oe+nfrqxyREZG3og7++YGxukkZa+4JVphweojkZuOvEEl7O2sVsF/ybOVJqs0RRIkaSwr/AhuIj/VpTIQ+XUETQQ7BVNtlXc4q5b1tM1z8ad8oJZ4QUKemwQOOCdYoudmESViaozMuzKJ7D0THRq9I0tZmgdVKVa7Wessj1gJYKWNbNQ2Nh4PKjKIL82YMynGK8DWN29YpAQLbDHKLDmEVQptTWYi43ZI9jZtyMbHMrmfT6e7ufBSVzRlrsAwGjQZJwo2jOyNAI+m+47rTfjLAwt4Afmx+kOAFfsqEUd/xQqq7YaWX1kzVIk8sIWFA
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(82310400026)(376014)(921020)(56012099006)(10067099003)(261026140227099003)(261026121527099003)(261022105027099003)(261022113327099003)(261022115727099003)(261022075727099003)(261021121427099003)(261021123027099003)(261028144727099003)(261102123227099003)(261009223327099003)(261009223027099003)(261009220027099003)(261009221227099003)(261009221727099003)(5023799004)(7136999003)(11062099010)(18002099003)(22082099003)(11063799006)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FHKhedWMfybe28GBg96nhXXmK02fmVhujzdCzJP+MpTrqtkV5aSFiVCLC7Ef5BF9hzGU2um0BIjAD65TaXc03kO07HJVxJgdcb/qeMnLie2tojP/qbwQgGsd6zQGarfTv/8h3/wP3JpArJquti8xMVsm7x4zGXaVMCOrwFagQtsvqvmzLKrxg7ZUkFS4dHA32qZz0iHX0/NAMSW6u7iI9mfWNP2KSUxsE/qnSVGJ8TnwBC9DDCxJM8xdoiAtEazONrkwtMxsXp1VJVWVb0NEfzBML1K3k4YgRHVna3u1RkufFYM/I2XtwWeBIzsImrRWA7thN49QxoOrfB9PuUGICuBilHwHeuR+xyrWQqNcjBSOMJDucdy5H2i2CROXzq1TPbDTWZ9X9l6jYO6kyTfy+vz4PvYUNiTc9ewynYF/Qa2aFKg3ahLAKG+l9Uwbjyaq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 08:42:40.6594 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d186083-5d9d-4651-9074-08df4c6265ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000166C1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB999077
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Honglei Huang <honghuan@amd.com>

Initialize the SVM context, attribute tree, work queues and embedded
GPUSVM state. Register the driver's structural lock and range/notifier
operations, and manage the context lifetime with kref references.

Initialize each range's device-owned pages cache and release it from
the range destructor. Select the XNACK mode from device capabilities
and reject unsupported modes. Closing the context marks it exiting,
flushes GC work and drains retry faults before final teardown.

Dispatch attribute changes to invalidation or mapping, preserving
access checks and returning compute TLB flush errors. Treat SYSMEM
as an active prefetch target, including repeated requests with
unchanged attributes. Revoking access must not restore a mapping
because a prefetch attribute remains set.

Suggested-by: Christian König <christian.koenig@amd.com>
Suggested-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c | 600 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  |   2 +-
 2 files changed, 601 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
new file mode 100644
index 0000000000000..24d9f90941f06
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
@@ -0,0 +1,600 @@
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
+#define XNACK_OFF(svm) (!(svm)->xnack_enabled)
+#define XNACK_ON(svm) ((svm)->xnack_enabled)
+
+/**
+ * amdgpu_svm_invalidate() - drm_gpusvm invalidate callback
+ * @gpusvm: The drm_gpusvm instance.
+ * @notifier: The GPU SVM notifier reporting the event.
+ * @mmu_range: The MMU notifier range describing the invalidation.
+ *
+ * Clamp the event to the notifier window, find the first affected range and
+ * invalidate the affected GPU mappings.
+ */
+static void amdgpu_svm_invalidate(struct drm_gpusvm *gpusvm, struct drm_gpusvm_notifier *notifier,
+				  const struct mmu_notifier_range *mmu_range)
+{
+	struct amdgpu_svm *svm = to_amdgpu_svm(gpusvm);
+	struct drm_gpusvm_range *first;
+	u64 adj_start = mmu_range->start, adj_end = mmu_range->end;
+
+	amdgpu_svm_assert_in_notifier(svm);
+
+	pr_debug("INVALIDATE: pasid=%u, gpusvm=%p, seqno=%lu, [0x%016lx-0x%016lx]-0x%lx, ev=%d\n",
+		 svm->vm->pasid, &svm->gpusvm, notifier->notifier.invalidate_seq, mmu_range->start,
+		 mmu_range->end, mmu_range->end - mmu_range->start, mmu_range->event);
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
+	amdgpu_svm_range_invalidate(svm, notifier, mmu_range, first, adj_start, adj_end);
+}
+
+static struct drm_gpusvm_range *amdgpu_svm_range_alloc(struct drm_gpusvm *gpusvm)
+{
+	struct amdgpu_svm_range *range;
+
+	range = kzalloc_obj(*range, GFP_KERNEL);
+	if (!range)
+		return NULL;
+
+	drm_gpusvm_init_pages(&range->pages, adev_to_drm(to_amdgpu_svm(gpusvm)->adev));
+	INIT_LIST_HEAD(&range->work_node);
+	range->pending_start_page = ULONG_MAX;
+	return &range->base;
+}
+
+static void amdgpu_svm_range_free(struct drm_gpusvm_range *range)
+{
+	struct amdgpu_svm_range *svm_range = to_amdgpu_svm_range(range);
+	unsigned long npages = (drm_gpusvm_range_end(range) - drm_gpusvm_range_start(range)) >>
+			       PAGE_SHIFT;
+
+	drm_gpusvm_free_pages(range->gpusvm, &svm_range->pages, npages);
+	kfree(svm_range);
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
+struct amdgpu_svm *amdgpu_svm_lookup_by_pasid(struct amdgpu_device *adev, u32 pasid)
+{
+	struct amdgpu_svm *svm = NULL;
+	struct amdgpu_fpriv *fpriv;
+	struct amdgpu_vm *vm;
+	unsigned long irqflags;
+
+	amdgpu_pasid_lock(&irqflags);
+	fpriv = amdgpu_pasid_get_fpriv_locked(pasid);
+	vm = fpriv ? &fpriv->vm : NULL;
+	if (vm && vm->svm) {
+		svm = vm->svm;
+		kref_get(&svm->refcount);
+	}
+	amdgpu_pasid_unlock(irqflags);
+
+	return svm;
+}
+
+static int amdgpu_svm_op_set_attr(struct amdgpu_vm *vm, u64 start, u64 size, u32 nattr,
+				  const struct drm_amdgpu_svm_attribute *attrs)
+{
+	struct amdgpu_svm *svm = vm->svm;
+
+	amdgpu_svm_sync_work(svm);
+
+	return amdgpu_svm_attr_set(svm->attr_tree, start, size, nattr, attrs);
+}
+
+static int amdgpu_svm_op_get_attr(struct amdgpu_vm *vm, u64 start, u64 size, u32 nattr,
+				  struct drm_amdgpu_svm_attribute *attrs, u64 *out_size)
+{
+	amdgpu_svm_sync_work(vm->svm);
+
+	return amdgpu_svm_attr_get(vm->svm->attr_tree, start, size, nattr, attrs, out_size);
+}
+
+static int amdgpu_svm_op_reset_attr(struct amdgpu_vm *vm, u64 start, u64 size)
+{
+	struct amdgpu_svm *svm = vm->svm;
+	unsigned long start_page = start >> PAGE_SHIFT;
+	unsigned long last_page = (start + size - 1) >> PAGE_SHIFT;
+
+	amdgpu_svm_sync_work(svm);
+
+	return amdgpu_svm_attr_reset(svm->attr_tree, start_page, last_page);
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
+static u32 attr_change_trigger(const struct amdgpu_svm_attrs *old_attrs,
+			       const struct amdgpu_svm_attrs *new_attrs)
+{
+	u32 trigger = 0;
+	u32 changed_flags = old_attrs->flags ^ new_attrs->flags;
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
+	if (new_attrs->prefetch_loc != AMDGPU_SVM_LOCATION_UNDEFINED)
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
+int amdgpu_svm_apply_attr_change(struct amdgpu_svm *svm, const struct amdgpu_svm_attrs *old_attrs,
+				 const struct amdgpu_svm_attrs *new_attrs, unsigned long start_page,
+				 unsigned long last_page)
+{
+	bool old_access, new_access;
+	bool needs_invalidate = false;
+	bool needs_mapping = false;
+	u32 trigger;
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
+	if (XNACK_ON(svm) && (trigger & AMDGPU_SVM_ATTR_TRIGGER_NEED_INVALIDATE))
+		needs_invalidate = true;
+
+	if (trigger & AMDGPU_SVM_ATTR_TRIGGER_PREFETCH)
+		needs_mapping = true;
+
+	if (!trigger && !needs_mapping)
+		return 0;
+
+	pr_debug("attr change trigger=0x%x old=%d new=%d [0x%lx-0x%lx]-0x%lx, xnack=%d\n", trigger,
+		 old_access, new_access, start_page, last_page, last_page - start_page + 1,
+		 svm->xnack_enabled ? 1 : 0);
+
+	if (needs_invalidate) {
+		pr_debug("attr change invalidate [0x%lx-0x%lx]-0x%lx trigger=0x%x\n", start_page,
+			 last_page, last_page - start_page + 1, trigger);
+		ret = amdgpu_svm_range_invalidate_interval(svm, start_page, last_page);
+		if (ret) {
+			pr_err_ratelimited("failed to invalidate range for attr change: [0x%lx-0x%lx], ret=%d\n",
+					   start_page, last_page, ret);
+			return ret;
+		}
+	}
+
+	if (!new_access || !needs_mapping)
+		return 0;
+
+	return amdgpu_svm_range_map_attrs(svm, new_attrs, start_page << PAGE_SHIFT,
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
+	u32 gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
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
+int amdgpu_svm_flush_tlb(struct amdgpu_svm *svm)
+{
+	struct amdgpu_fpriv *fpriv = container_of(svm->vm, struct amdgpu_fpriv, vm);
+	struct amdgpu_device *adev = svm->adev;
+	struct amdgpu_xcp_mgr *xcp_mgr = adev->xcp_mgr;
+	u32 xcc_mask;
+	int r;
+
+	if (!xcp_mgr || fpriv->xcp_id >= xcp_mgr->num_xcps ||
+	    amdgpu_xcp_get_inst_details(&xcp_mgr->xcp[fpriv->xcp_id], AMDGPU_XCP_GFX, &xcc_mask))
+		xcc_mask = (1U << NUM_XCC(adev->gfx.xcc_mask)) - 1;
+
+	r = amdgpu_vm_flush_compute_tlb(adev, svm->vm, TLB_FLUSH_HEAVYWEIGHT, xcc_mask);
+	if (r)
+		dev_err(adev->dev, "SVM TLB flush failed (%d), GPU may use stale translations\n",
+			r);
+	return r;
+}
+
+static int amdgpu_svm_work_init(struct amdgpu_svm *svm, void (*gc_work_func)(struct work_struct *));
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
+static int amdgpu_svm_init_xnack_mode(struct amdgpu_device *adev, enum amdgpu_svm_xnack_mode mode,
+				      bool *xnack_enabled)
+{
+	bool xnack_default = amdgpu_svm_default_xnack_enabled(adev);
+
+	switch (mode) {
+	case AMDGPU_SVM_XNACK_DEFAULT:
+		*xnack_enabled = xnack_default;
+		break;
+	case AMDGPU_SVM_XNACK_ON:
+		if (!xnack_default) {
+			pr_err("xnack on not available (mode=%d)\n", mode);
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
+ * @gc_work_func: Work function draining the garbage collector.
+ *
+ * Set up the work queues, attribute tree and the embedded drm_gpusvm (with
+ * the 2M/64K/4K chunk sizes and the driver lock), wiring the supplied
+ * callbacks.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+static int
+amdgpu_svm_init_with_ops(struct amdgpu_svm *svm, void (*gc_work_func)(struct work_struct *))
+{
+	struct amdgpu_device *adev = svm->adev;
+	int ret;
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
+	ret = drm_gpusvm_init(&svm->gpusvm, "AMDGPU SVM", current->mm, 0,
+			      adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT,
+			      AMDGPU_SVM_DEFAULT_SVM_NOTIFIER_SIZE * SZ_1M, &amdgpu_gpusvm_ops,
+			      amdgpu_svm_chunk_sizes, ARRAY_SIZE(amdgpu_svm_chunk_sizes));
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
+static int amdgpu_svm_init_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+				   enum amdgpu_svm_xnack_mode xnack_mode)
+{
+	struct amdgpu_svm *svm;
+	int ret;
+
+	if (vm->svm)
+		return 0;
+
+	svm = kzalloc_obj(*svm, GFP_KERNEL);
+	if (!svm)
+		return -ENOMEM;
+
+	kref_init(&svm->refcount);
+	svm->adev = adev;
+	svm->vm = vm;
+	svm->default_granularity = min_t(u8, amdgpu_svm_default_granularity, 0x1B);
+	atomic_set(&svm->exiting, 0);
+
+	ret = amdgpu_svm_init_xnack_mode(adev, xnack_mode, &svm->xnack_enabled);
+	if (ret)
+		goto err_free;
+
+	if (svm->xnack_enabled) {
+		ret = amdgpu_svm_init_with_ops(svm, amdgpu_svm_gc_work_func);
+	} else {
+		pr_err("xnack off is not supported yet\n");
+		ret = -EOPNOTSUPP;
+	}
+
+	if (ret)
+		goto err_free;
+
+	pr_debug("AMDGPU SVM initialized: default granularity 0x%lx bytes, xnack: %s\n",
+		 1UL << (svm->default_granularity + PAGE_SHIFT),
+		 svm->xnack_enabled ? "enabled" : "disabled");
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
+	amdgpu_ih_wait_on_checkpoint_process_ts(adev, adev->irq.retry_cam_enabled ? &adev->irq.ih :
+										    &adev->irq.ih1);
+	if (adev->irq.retry_cam_enabled)
+		amdgpu_ih_wait_on_checkpoint_process_ts(adev, &adev->irq.ih_soft);
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
+	return vm->svm;
+}
+
+#endif /* CONFIG_DRM_AMDGPU_SVM */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 9fcafed0b598c..7b77577aa5621 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1821,7 +1821,7 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
  * @adev: amdgpu_device pointer
  * @vm: requested vm
  * @flush_type: flush type
- * @xcc_mask: mask of XCCs that belong to the compute partition in need of a TLB flush.
+ * @xcc_mask: mask of logical XCC indices to flush
  *
  * Flush TLB if needed for a compute VM.
  *
-- 
2.53.0

