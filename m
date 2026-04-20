Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E77F588C4
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 13:14:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95CD910E5D8;
	Mon, 20 Apr 2026 13:14:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jO9UWHyS";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013030.outbound.protection.outlook.com
 [40.93.201.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2FCB10E5D8;
 Mon, 20 Apr 2026 13:14:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kQ0QgopOOz7HUXjT4vHLY+yybHAc4kCl2JrgWxwD35b5kVNIJ3n3yMaGRASGVEqH1kAuf62Wjha5RBBd79evyo0QYk8XELDXm6tXrKAJHzc0UuV8xBktD7uqZj5D55dpm01XIj1QNgyygGc7q8CwE+dRjtB6eg1iCqSSBx803y1l6sqmf9+uUdJTRogMIbqdt9WR6q/tOvzHm5Tva0xTywC3jwmuDWAUZsKkoG6v9lXdeIegFXSemLpeNJ561uWfNa3UHdl04I/tj2dt0uHme4saZLfNe/wmN+h5q8zkX+SgAcp6nXhfDssEtuuO/ib6BivzTMDlw2Yqe7J9H8C9yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Wj5BTuEIBEBLaqtwM7EQhKyDE/9AoMj/gTJETT3kZs=;
 b=kn9k+OrOZtis9tGVBuEz1ie/9E7nnVGkJh9kJi6Hwuucaf6Zjb2q9jzwIjFcJG+OTxk7pePFUbMg5RzBgd2odYUHpUyRd7NcekFdGMaRoF+6Q6khNxnJ1pcCvemP/PQJkQCbVd/ohjnzYTUEpuxXmQu3TlbQbr7X3Lj39jDsG6xAwyPs4yZXvxMr9BgGP0E2EZw8fah17N/ilen6YC55Q40m0Um5cyUr10OVxpFyWyBXvMApcEpWyHLm2EMn3FtIcEIPKXGqhFja/OtFcLhfZKrKWzlMIi7rWUk3eL+bMzGbxdATdVXXPiAhv4oMCFiRqLsMsFIoBl95chmEA4OBzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Wj5BTuEIBEBLaqtwM7EQhKyDE/9AoMj/gTJETT3kZs=;
 b=jO9UWHySfuVsQmIH/ybvInZ75QZH61iCGfHCGEanPm39ql2SoPwUxixWd6MUy+L6wqY9Zmakdxd55JhE2uOhFTJN43Hn1XK5I9HxnZ/Ml4ZvXVOFy9J2NnmB6YjD7WsrLSDxh1c134AqrQJmFgNzABotvual5hj6LxlI2Osm3Gc=
Received: from CH3P220CA0015.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::8)
 by DM4PR12MB6350.namprd12.prod.outlook.com (2603:10b6:8:a3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.12; Mon, 20 Apr
 2026 13:14:02 +0000
Received: from CH1PEPF0000AD79.namprd04.prod.outlook.com
 (2603:10b6:610:1e8:cafe::b3) by CH3P220CA0015.outlook.office365.com
 (2603:10b6:610:1e8::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Mon,
 20 Apr 2026 13:14:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD79.mail.protection.outlook.com (10.167.244.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Mon, 20 Apr 2026 13:14:02 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Apr
 2026 08:13:57 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <matthew.brost@intel.com>,
 <rodrigo.vivi@intel.com>, <thomas.hellstrom@linux.intel.com>,
 <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>, Honghuan He <honghuan.he@amd.com>
Subject: [RFC V3 06/12] drm/amdgpu: define SVM range types and work queue
 interface
Date: Mon, 20 Apr 2026 21:13:01 +0800
Message-ID: <20260420131307.1816671-7-honglei1.huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD79:EE_|DM4PR12MB6350:EE_
X-MS-Office365-Filtering-Correlation-Id: d10a91c7-948e-4290-f24f-08de9edeb0f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|921020|18096099003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: n5YP/xgW5S9dOx2qdpwnFqSll444mkAxQpQAkVaUgTZ6H+y9OrE+Vfp8zkHhEyReGZwceuIUY9y3zZsWLuoeuq4d/NbvlrlziB96R1FKhpPgHdTasOxBDjbqJzqNrVaKRhtyBVO4Cg/31E9wAG8KuOcjDe1JDnKzeWurwWFCRLORDqNmeUCnib13kH1N9CPsimYTNlyY4OM8z+ON7/BxCmQy7zJt88EC1LOE655y7EO7OxKwz70OC42j5XaVwR9z0d81y1So9roQetjtQ+rXOSizGspXnoxzM3V7UAm6fd+A7GymYAFqQaOp5HDaW7+1simm+eDFM5uycUF91TMyVrm1u2wZiHKExIAelwvmqVcpTWPibt4++w1j2/FRBYllbrTjhvkeJbz/N7H5fI/i2/L3LqaQy2mtFC2btNcPh4kyb3gIyKQ7H5N8tViUINo+vTLRjiFCtveXWrnPPZq1I4rfIH4tXoGsp1siCV8ZzQ27dYGH12tutJi0AZFSyZGisN1KDuXHDKNGwliUR0rf0FgcvxeVEDqtvm7B0l3hkxRN1ijpj88BwPob2z41gjMrjmVIh/mFEXKPbCNY4rKici7VBbkD3Lm0zOhDFlZe3b9jLDHezR71EYcZOvSqZ2O2gC1bmIboHNLplcW4uXC2GP1PUoePn75PwDQVYZIszrd0rKENrurmkPi19/Gw7MbW085T88SuuGua4XgiQu8nYcoReZtq2AyYpGcmasz6AgFt/ZRffkM28KUPyvAdf1WFToZ6GriVtKBdhsMPPCdZ6jkoc4Hk2TxRdWZh4lmnilxDR9dZSCcxayCtmBKtqQr2
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(921020)(18096099003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nN/jMJO8L4Ico7ARoCCluTTmzUDYlu8zSviYzynUDAxAwStjPvXggxNOituR7W+TbOaSi0oaABYF2LQLnIBzyOh5YEJWfAuLXBUAa5MCcQUxQPO0KQgiLk5gG9evvRUiaCzQQ/jFdCmUgayuilAFirejEVG6XIy5bB9lkM2xLcrdJLd8g+SGph5SejPvRe97fFBxhDZ80DjhcAxeYzVRd/vL3NQLvLs/FpteOexD545vok3DNTtswnMUSimfaHyQRON0meK5eh6yM7IIdO6IY4F4/7cjmw73RRdK7L/kTU4eWOSzCdw/QuEnGRH0JhN8qUxOt36ZOyWQYsE7BbZ/t8BQjKRwMY6b1FQgF32Kn6uR5Yq1HGV6qiQ0k8cHumcG2wAW7Jk6VSSz7Pv51eJ8CIRbiP5ONwRaS60SvfAJ4AwdF3KCGwceyQ8zBkzt2gIU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 13:14:02.1680 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d10a91c7-948e-4290-f24f-08de9edeb0f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD79.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6350
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

Add amdgpu_svm_range.h defining the GPU-mapped range types and
deferred work interface for the SVM subsystem.

struct amdgpu_svm_range extends drm_gpusvm_range with:
- work_node: list linkage for deferred work processing
- gpu_mapped: active GPU mapping state flag
- gc_queued / in_queue: garbage collection and work queue state
- pending_ops / pending_start_page / pending_last_page: batched
  deferred operation tracking with address bounds
- pte_flags: cached GPU PTE flags for the current mapping
- attr_flags: cached attribute flags
- validate_timestamp: last successful mapping time

AMDGPU_SVM_RANGE_DEBUG macro for formatted debug output including
PASID, GPU virtual address range, and mapping state.

enum amdgpu_svm_range_op / struct amdgpu_svm_range_op_ctx:
define deferred operation types (AMDGPU_SVM_RANGE_OP_UNMAP) and
their parameters.

Helper macros: UNMAP_WORK(), XNACK_OFF(), NEED_REBUILD().

Declare the range API: amdgpu_svm_range_attr_pte_flags(),
amdgpu_svm_range_lock_vm_pd(), amdgpu_svm_range_pages_valid(),
amdgpu_svm_range_is_valid(), amdgpu_svm_range_update_gpu_range(),
amdgpu_svm_range_update_mapping(), amdgpu_svm_range_find_or_insert(),
amdgpu_svm_range_get_pages(), amdgpu_svm_range_remove(),
amdgpu_svm_range_map_interval(),
amdgpu_svm_range_apply_attr_change(),
amdgpu_svm_range_invalidate(),
amdgpu_svm_range_dequeue_locked(),
amdgpu_svm_range_put_if_dequeued(),
amdgpu_svm_capture_checkpoint_ts().

Signed-off-by: Honghuan He <honghuan.he@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h | 148 ++++++++++++++++++
 1 file changed, 148 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
new file mode 100644
index 000000000..a32b806a7
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
@@ -0,0 +1,148 @@
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
+#ifndef __AMDGPU_SVM_RANGE_H__
+#define __AMDGPU_SVM_RANGE_H__
+
+#include <drm/drm_gpusvm.h>
+
+#include "amdgpu_svm.h"
+#include "amdgpu_vm.h"
+
+#include <linux/ktime.h>
+#include <linux/list.h>
+#include <linux/types.h>
+
+struct amdgpu_svm;
+struct amdgpu_svm_attr_range;
+struct amdgpu_svm_attrs;
+struct dma_fence;
+struct drm_exec;
+struct drm_gpusvm_notifier;
+struct drm_gpusvm_range;
+struct mmu_notifier_range;
+
+struct amdgpu_svm_range {
+	struct drm_gpusvm_range base;
+	struct list_head work_node;
+	bool gpu_mapped;
+	bool gc_queued;
+	bool in_queue;
+	u8 pending_ops;
+	unsigned long pending_start_page;
+	unsigned long pending_last_page;
+	uint64_t pte_flags;
+	uint32_t attr_flags;
+	ktime_t validate_timestamp;
+};
+
+static inline struct amdgpu_svm_range *
+to_amdgpu_svm_range(struct drm_gpusvm_range *range)
+{
+	return container_of(range, struct amdgpu_svm_range, base);
+}
+
+#define AMDGPU_SVM_RANGE_DEBUG(r__, op__)						\
+	AMDGPU_SVM_TRACE("%s: pasid=%u, gpusvm=%p, mapped=%d, "	\
+			 "seqno=%lu, range: [0x%lx-0x%lx)-"		\
+			 "%lu\n",					\
+			 (op__),					\
+			 to_amdgpu_svm((r__)->base.gpusvm)->vm->pasid,	\
+			 (r__)->base.gpusvm,				\
+			 READ_ONCE((r__)->gpu_mapped),			\
+			 (r__)->base.pages.notifier_seq,		\
+			 drm_gpusvm_range_start(&(r__)->base),		\
+			 drm_gpusvm_range_end(&(r__)->base),		\
+			 drm_gpusvm_range_end(&(r__)->base) -		\
+			 drm_gpusvm_range_start(&(r__)->base))
+
+enum amdgpu_svm_range_op {
+	AMDGPU_SVM_RANGE_OP_NONE    = 0,
+	AMDGPU_SVM_RANGE_OP_UNMAP   = BIT(0),
+};
+
+struct amdgpu_svm_range_op_ctx {
+	struct amdgpu_svm_range *range;
+	unsigned long start_page;
+	unsigned long last_page;
+	uint8_t pending_ops;
+};
+
+#define UNMAP_WORK(ops)		((ops) & AMDGPU_SVM_RANGE_OP_UNMAP)
+#define XNACK_OFF(svm)		((svm)->xnack_enabled == false)
+#define NEED_REBUILD(svm)	(XNACK_OFF(svm))
+
+void amdgpu_svm_capture_checkpoint_ts(struct amdgpu_svm *svm);
+
+uint64_t amdgpu_svm_range_attr_pte_flags(struct amdgpu_svm *svm,
+					 const struct amdgpu_svm_attrs *attrs,
+					 bool read_only);
+int amdgpu_svm_range_lock_vm_pd(struct amdgpu_svm *svm,
+				struct drm_exec *exec,
+				bool intr);
+bool amdgpu_svm_range_pages_valid(struct amdgpu_svm *svm,
+				  struct amdgpu_svm_range *range);
+bool amdgpu_svm_range_is_valid(struct amdgpu_svm *svm,
+			       struct amdgpu_svm_range *range,
+			       const struct amdgpu_svm_attrs *attrs,
+			       uint64_t pte_flags);
+int amdgpu_svm_range_update_gpu_range(struct amdgpu_svm *svm,
+				      struct amdgpu_svm_range *range,
+				      uint64_t pte_flags,
+				      bool flush_tlb, bool wait,
+				      struct dma_fence **fence);
+int amdgpu_svm_range_update_mapping(struct amdgpu_svm *svm,
+				    struct amdgpu_svm_range *range,
+				    uint64_t pte_flags,
+				    uint32_t attrs_flags,
+				    bool intr, bool wait,
+				    bool flush_tlb);
+bool amdgpu_svm_range_dequeue_locked(struct amdgpu_svm *svm,
+				     struct list_head *work_list,
+				     struct amdgpu_svm_range_op_ctx *op_ctx);
+void amdgpu_svm_range_put_if_dequeued(struct amdgpu_svm *svm,
+				      struct amdgpu_svm_range *range);
+void amdgpu_svm_range_remove(struct amdgpu_svm *svm,
+			     struct amdgpu_svm_range *range,
+			     struct drm_gpusvm_ctx *ctx);
+
+int amdgpu_svm_range_map_interval(struct amdgpu_svm *svm,
+				     unsigned long start_page,
+				     unsigned long last_page);
+int amdgpu_svm_range_apply_attr_change(
+	struct amdgpu_svm *svm, uint32_t trigger,
+	const struct amdgpu_svm_attrs *prev_attrs,
+	struct amdgpu_svm_attr_range *attr_range);
+void amdgpu_svm_range_invalidate(struct amdgpu_svm *svm,
+				 struct drm_gpusvm_notifier *notifier,
+				 const struct mmu_notifier_range *mmu_range);
+struct amdgpu_svm_range *
+amdgpu_svm_range_find_or_insert(struct amdgpu_svm *svm, unsigned long addr,
+				const struct amdgpu_svm_attr_range *attr_range,
+				struct drm_gpusvm_ctx *ctx);
+int amdgpu_svm_range_get_pages(struct amdgpu_svm *svm,
+			       struct drm_gpusvm_range *range,
+			       struct drm_gpusvm_ctx *ctx);
+
+#endif /* __AMDGPU_SVM_RANGE_H__ */
-- 
2.34.1

