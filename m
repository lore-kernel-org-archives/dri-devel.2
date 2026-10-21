Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09497606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 03:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ZmZr0RPb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5ED8910F8A3;
	Wed, 21 Oct 2026 03:00:36 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010066.outbound.protection.outlook.com [52.101.46.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D78FB10F892;
 Wed, 21 Oct 2026 03:00:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lpv7axJIl2uYPvmcAwKlMTksGkqjax/AMheWBT3aRAeRl1baFGW96jsG3hiCBgqOPm0GPfuL2pKyWRfAo28V/6K5a64D0D0oebZsslXHAIKXm2X2RzU7LthNVZBoHAFlLKF/pkbiG1IZ/MKby2a+HJRh6RJSBSGbhrQasfct1/VzHOF7NHgd9jFL6N3ml/mJJzBaoPd+EccLbwxPULre0FLVc8leXmhNKHmyPszXrKNmziewKR3bfF670QTSSj7VYv4LuMMoZb0p/4L/dloWKHc63US/77pPHSxTpZvjttahNxfRftsvnoRzLG9aMYoGzLu4V0ofbOpcqNtuGNgxsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Gs88MmTOoAkhdrRZ3CxA63scweYRc9+bZvJSyBaawA=;
 b=rKos5gvKBJlfqmBSI8wYOW21joX8Ay+z4IzgqXYtm47Oa2rZviAg8Qj7L9zp24/kRyTkDotwgKrSYEDpeFIC1BarJWIOJ7m3/8wB1Dpws28v7V+HCaclckr7ZpTEpFQ+BbctRjuq1l57lbGVY2dBlPahX6Rw+16NJYiF8sNiLNhk/qGDFf6abTTOdba/F5K7vRYi/AQVBWCrFAsmbnxU4q0yDb3iW1BAmijxEPqrThOKkkywEYYzhfPHg5pjhwLygq+gVV5dbADBr1292XOkSyQhU5g3MPBrxB3aqH0Z3FSQZGVbtWrZtuVxInmSDuZNZDs1UTU19azSsZqRJ1HhIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Gs88MmTOoAkhdrRZ3CxA63scweYRc9+bZvJSyBaawA=;
 b=ZmZr0RPbbgkk7h+vELXv0ltLgLLfsNezSNrbc13Z/LOLCt1J4MQtNYlNvz1fczRB1HH13/iJ5S+0YducsCe7VRo934fdIfRiSwASxK7KrSaLWbYbpWkMsCovxzwrEdJ6CZVbGZYFBWSn+KoCwU4YfwTc1FlduT8dSXnvDkRAA9A=
Received: from SJ0PR03CA0275.namprd03.prod.outlook.com (2603:10b6:a03:39e::10)
 by DM4PR12MB6304.namprd12.prod.outlook.com (2603:10b6:8:a2::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.19; Wed, 21 Oct 2026 03:00:17 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::47) by SJ0PR03CA0275.outlook.office365.com
 (2603:10b6:a03:39e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Wed,
 21 Oct 2026 03:00:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 03:00:16 +0000
Received: from hr-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 22:00:11 -0500
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
Subject: [PATCH v10 10/22] drm/amdgpu: implement SVM initialization and
 lifecycle
Date: Wed, 21 Oct 2026 10:58:49 +0800
Message-ID: <20261021025915.2433837-11-ray.huang@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021025915.2433837-1-ray.huang@amd.com>
References: <20261021025915.2433837-1-ray.huang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|DM4PR12MB6304:EE_
X-MS-Office365-Filtering-Correlation-Id: d45266d9-8949-4e06-81ef-08df2f1f6f5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|23010399003|1800799024|36860700016|6133799003|7136999003|18002099003|22082099003|10067099003|11062099010|3023799007|11063799006|261009221227099003|261009223327099003|261009223027099003|261009220027099003|261009221727099003|5023799004|56012099006|921020;
X-Microsoft-Antispam-Message-Info: 65Sdr04DSnXoDB//iNhJOrbpKFj+tZ0UGw7DHPaWkaEEzRP3eJCiB6pvAPbQjDx2riLue1m9gbTMHssJVr6KQCPhC3U1KH55Yu/a8at9njxGaQJqf675ztUBLfo6T3hEwIP07fDZwCdDGyw63piwPMRs+90Vv+D8OiNPyfIXmVNXETurUa44BbYdlgl3E53Fo0NteqA435BYd3KraQhMYMvtfGQa9n4fri7p62+jvqikocBA6hM5atHTplyQ+J1ub6CzYPER3FNVDYTVGkHQVWc/WtjTeI1bgB354Y7lsWYwf4Otck8doAyiTvxn4FQYic2BgcHkF9M0AbGCcRBq4vcDqFvLiqc2/tSDOBBSLp9kwX0QGYIbCYtyecFRrQmcyy0F3aS9YI7f2IwhaF0nHdRKcNXArv/QyI9TSIt1yhVfAmMwLsGjN493Kk9CEjC4zt5NVhtP6O3tbhAlAt+Cni0w3k96fO5i4qfbAa0SZ+P3KNJjTfS32dci7H8LNkWFQdke1GKL7397zu95hKtZw64E6Vezl8GXZAxJzfNZ02FjT8LJ4g5bOkAchmKPrmT75vJkpxeSEUpqTGLfnZb6HnKXvqA9Jxb55DRTdAkM+s1WaOQ1mbxM3ffBAeDlXcQOnobXqaWK0OcUMlS61UtU77XTAozP5Ahy0uJ6hhLadwxExWTuyQAR9mM1opUpFRFl57JVnlqHgvARROgsAz1XZTrf59+pdY9cXZlpvyxOD+mQRH0RFu/pwxb01rajpWxT
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(23010399003)(1800799024)(36860700016)(6133799003)(7136999003)(18002099003)(22082099003)(10067099003)(11062099010)(3023799007)(11063799006)(261009221227099003)(261009223327099003)(261009223027099003)(261009220027099003)(261009221727099003)(5023799004)(56012099006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SALFNlD77XYvpgWpWviY34YsyKGzwDxhy4odIT13VPyozqCwl16VPoi1MX11MVIClU4KHlaUAsFs3ZPiawGN2N30ubDYqW2vuI0NDZVyQQecAmuHxIkxcVMxaUS7XFQDO88oGuvgGyrCwTa+YZAu0COxBLUJHvdsQ+GeEj1MpjJ5k3qZTmBJKrYUbhoTARjpfkkUhrf8EiUOcSjebQ1913SL0R3Vs5y7f4rft0haWu4gyK8GkZ+Hw0pXvpMfEX0UxflabEnuIZUitoaB4RAMLLOaOLdbTehQR2bLUXL+8sPAUHG0m0mLyxCV+Fzk0RFZdH0Zl4/OXXkkHwaPT50yjUSb9YgVQSOLQv8gHxDQldZeAlClPRKouj1YFk05H/wdCb8B9LKXViCeF4jBz4GG8RTlsnzh7MZu2gl69t8EJVYiulkEqHRtx+IidOz0/IyG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 03:00:16.7835 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d45266d9-8949-4e06-81ef-08df2f1f6f5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6304
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
- TLB flushing with logical, partition-scoped XCC masks
- xnack mode: amdgpu_svm_init_xnack_mode validates requested mode
- Initialization: amdgpu_svm_init_with_ops (drm_gpusvm_init with
  2M/64K/4K chunk sizes, attr tree, invalidate_ranges/flush_tlb
  callbacks), amdgpu_svm_init_compute with xnack_mode parameter
- Teardown: amdgpu_svm_close (mark exiting, sync work),
  amdgpu_svm_fini (gpusvm_fini, destroy attr tree, release ref)

Suggested-by: Christian König <christian.koenig@amd.com>
Suggested-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c | 641 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  |   2 +-
 2 files changed, 642 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
new file mode 100644
index 0000000000000..f5ed917329944
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
@@ -0,0 +1,641 @@
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
+	pr_debug(
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
+	range = kzalloc_obj(*range, GFP_KERNEL);
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
+				  struct drm_amdgpu_svm_attribute *attrs,
+				  uint64_t *out_size)
+{
+	amdgpu_svm_sync_work(vm->svm);
+
+	return amdgpu_svm_attr_get(vm->svm->attr_tree, start, size, nattr,
+				   attrs, out_size);
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
+	pr_debug("attr change trigger=0x%x old=%d new=%d [0x%lx-0x%lx]-0x%lx, xnack=%d\n",
+			 trigger, old_access, new_access, start_page, last_page,
+			 last_page - start_page + 1,
+			 svm->xnack_enabled ? 1 : 0);
+
+	if (needs_invalidate) {
+		pr_debug("attr change invalidate [0x%lx-0x%lx]-0x%lx trigger=0x%x\n",
+				 start_page, last_page,
+				 last_page - start_page + 1, trigger);
+		ret = amdgpu_svm_range_invalidate_interval(svm, start_page,
+							   last_page);
+		if (ret) {
+			pr_err_ratelimited("failed to invalidate range for attr change: [0x%lx-0x%lx], ret=%d\n",
+					   start_page, last_page, ret);
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
+	struct amdgpu_fpriv *fpriv = container_of(svm->vm, struct amdgpu_fpriv, vm);
+	struct amdgpu_device *adev = svm->adev;
+	struct amdgpu_xcp_mgr *xcp_mgr = adev->xcp_mgr;
+	u32 xcc_mask;
+	int r;
+
+	if (!xcp_mgr || fpriv->xcp_id >= xcp_mgr->num_xcps ||
+	    amdgpu_xcp_get_inst_details(&xcp_mgr->xcp[fpriv->xcp_id],
+					AMDGPU_XCP_GFX, &xcc_mask))
+		xcc_mask = (1U << NUM_XCC(adev->gfx.xcc_mask)) - 1;
+
+	r = amdgpu_vm_flush_compute_tlb(adev, svm->vm, TLB_FLUSH_HEAVYWEIGHT,
+					xcc_mask);
+	if (r)
+		dev_err(adev->dev, "SVM TLB flush failed (%d), GPU may use stale translations\n",
+			r);
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
+			pr_err("xnack on not available (mode=%d)\n",
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
+		pr_err("xnack off is not supported yet\n");
+		ret = -EOPNOTSUPP;
+	}
+
+	if (ret)
+		goto err_free;
+
+	pr_debug("AMDGPU SVM initialized: default granularity 0x%lx bytes, xnack: %s\n",
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
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index c22c804f7d716..4fb22195607a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1780,7 +1780,7 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
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

