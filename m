Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BDF606A323
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=gk7V2Ix/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8429511286A;
	Fri, 27 Nov 2026 08:42:46 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010066.outbound.protection.outlook.com [52.101.61.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EF6F10E522;
 Fri, 27 Nov 2026 08:42:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=easDNC31YdM2BAAZ498mtomSPIE7w2pBfY/Ggh2WAEVFDFOPKmBrap9qRu5Jo8WCerRN4BohzQ1+rEnzT9y19o3HdfFu3K7YvBjXgNe4Dn7IFtKJ7njguvtokg5WQhfU4tjfDK5zGS3Wv7Gkd9AmW1DlZ7IFa4J+MLAYyncCNBnDpODwvYiuPDHarBsaHOM2CK3bOuNVfsr6PpaFueMVmfY0tCYVNGOgwfJN9fdJsUke2Wvs6Ly3CtG4auq0BszOOfdWbo4izMIJHP3wM+qf8hXouEiPdFBIrlrtYFSFXwSGnfj+0eSWt4aOXpS2b/8v63egxW2xXb8icFnGLZSooA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GrxOQoDKg0uH4KV4FELhChOGMJzn7kfRBquFQWJ2U2Q=;
 b=SaSDLYGT1nU9t40Tr2Y7KytRnl2B6NQoyH42igLnOyBKMdvh+6OeTZH7J9741E8tIE2/FXRQUSBzxaoQ+NyOiAcmvt3NQsLIee5OIq621so6sSDBdjYDJOR79WpWdjuJymOjGu7TeAhxe7sPg9gzoSl+Lr19n9B3Q5FbPtjCtM5GdtEtHsyMg7tRTRLzT8vprRBkGcvwRR4QQAZ9j9ZMteWDtbqKZZgPYIs02b2GSMbBJK4UGYyeiE1XrWFk16hPMQtQXsRUdqTnqagHs88NWCRQRpduoQNCvCK7JYVR3dJzVI5Yf18eVxqzABI7x4CILz40OrdigL8to4k5Go56KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GrxOQoDKg0uH4KV4FELhChOGMJzn7kfRBquFQWJ2U2Q=;
 b=gk7V2Ix/67tZhaYOpsUN4+J/h8Imr6DIzh/ttS82pXgMS9102PRUA1BLQwqc+4ci/bwrS1kLvLu6PG1avcepTPSFqY82zSS7rdbR/YR2GOygAfbi4ecsJhqhWkdNEyMRPHmufC4g4grJNi1RA16V4QM4wCzrOPV/aLwCVym94es=
Received: from CH0PR03CA0448.namprd03.prod.outlook.com (2603:10b6:610:10e::11)
 by SA1PR12MB8162.namprd12.prod.outlook.com (2603:10b6:806:33a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.10; Fri, 27 Nov
 2026 08:42:21 +0000
Received: from CH2PEPF000166BA.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::94) by CH0PR03CA0448.outlook.office365.com
 (2603:10b6:610:10e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.9 via Frontend Transport; Fri, 27
 Nov 2026 08:42:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF000166BA.mail.protection.outlook.com (10.167.252.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 08:42:20 +0000
Received: from hr-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 02:42:15 -0600
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
Subject: [PATCH v11 06/22] drm/amdgpu: add SVM range types and work queue
 interface
Date: Fri, 27 Nov 2026 16:41:29 +0800
Message-ID: <20261127084149.925625-7-ray.huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF000166BA:EE_|SA1PR12MB8162:EE_
X-MS-Office365-Filtering-Correlation-Id: 418ec0ac-0b16-4c73-cb7d-08df4c6259e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|23010399003|82310400026|921020|261022115727099003|10067099003|56012099006|261026121527099003|261026140227099003|261028144727099003|261022113327099003|261022105027099003|261022075727099003|261021121427099003|261102123227099003|261009223027099003|22082099003|18002099003|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info: 8BG2kklIAt2m2+gNrDL9x9x8RnZr9ugl0kRmHdZw9oau1RW+XtkbfBc3IUb1mAO0u6oB4IBwOAX9hUEwBXTUK2Y/+OlrZ+7fp5Ey99QO97M/0aY2MZOLvgGJ53iT6gFYyg4lfXYm6s0szlUxgZcDqU42HSXn32e9FhiE2zf0RI6KeUkcKO0Sqr1NkJksb7nPJMwfGBzaYdW2gm4QTGsg0fJWVMmpww1QLIDZE3/ZUWOYeScHbI4xsiT4sF6dPBTFrVUoPalxDWSIOkDYEL+vuz+pjRGdjc46Xcuy6Uf0khtMu7vfi21Cjx6Z9Qe4uB+j6UNNbwfKwSojTddKPiItQWDIxJ+NOhv/A53sMUN6t8qpkJI6ZP9c5vTJTwbDgKnyRfMveTG6HtgEs/Mq0vW8qjLjeuW5lZPI8fiiYzWOPPcKUQXvG/YxMcT/mxyihf5PtN3MnEf20uEKO1RkboBsEeWDaPHMRUqUBhXzwmv2Dbmtc7ZDizNGCWG0H6KJ9+q/fUGczyfEGN+SFjos0tNTI8qUBbq3vZgtysbbkPK7s102iK4kEVpW0IthiY0ntox+7qB4qeuPbt23Ht7loE1QCveXXdO0sm5hGnzp1FWPfdgJ39LBCTGyyGwae2u/D4+MmGdG0XGbfM5dRaE9VWqSqeqDO9Web2/nSz1Eimt3mxFIaQathsfeAsBJxeGveIlvv0SDff3auai88zYvQ5O2/0ywk9VqFBCzoN7DDtxSJJ8/6nr7xamzipRgVc1YHO3t
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(23010399003)(82310400026)(921020)(261022115727099003)(10067099003)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261022113327099003)(261022105027099003)(261022075727099003)(261021121427099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(11063799006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pROVHQxfiNSDPWJ9Gd5NthUJBINYlQTlBN0PckAGrIpgoG6LQtFe5F56y6ZPjYyTeRc/kO45nAM4O48ZbRvG7OIZPhYXNufvK7IdN1Hly6EbUIfDhsZxWG3i3P8um6aNHrJjXVWO28jNT4plYDQXgq+MWZEyy9iis9uh01HjJtGm9+yoGV9ADgRZcq64zDjfdsMuXU5Ljw+QuyQb9fYTMleeHe+s+wC2sK+c+BySgfEp+1O3jgTXy2JSjTjGuoXwv6AcqWiG+cIvPMfsB6YAsiIpYieosv00NnUa388SINqTEYDBIEoIv/fxwfL0AjrgsyVChrDIsdger5cyLSfFUTzBbAsYokerBO9cO/c3g2dQynXuSlXCy0I5ZSqNfmxYNu/fISFM7eLQe7bACiPhC75qfTsunWs9+Z3HjoY2KeGCDfP9P/fvtDcpYoHySBqE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 08:42:20.8027 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 418ec0ac-0b16-4c73-cb7d-08df4c6259e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000166BA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8162
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Honglei Huang <honghuan@amd.com>

Add amdgpu_svm_range.h with GPU mapped range types and interfaces:
- enum amdgpu_svm_range_queue_state: NOT_QUEUED, IN_GC, PROCESSING
  states for queue work
- struct amdgpu_svm_range: extends drm_gpusvm_range with gpu_mapped
  state, queue_state, attribute flags, work queue node, pending
  ops/pages, and validation timestamp
- enum amdgpu_svm_range_op: NONE, UNMAP operation types
- struct amdgpu_svm_range_op_ctx: dequeue context for GC processing
- Inline helper: amdgpu_svm_range_invalidate_gpu_mapping
- Range operations API declarations: find_or_insert, get_pages,
  update_mapping, update_gpu_range, invalidate

Embed the device-owned drm_gpusvm_pages cache in each AMDGPU range
and use its notifier sequence for range tracing.

Suggested-by: Christian König <christian.koenig@amd.com>
Suggested-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h | 133 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h     |  28 ++++
 2 files changed, 161 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
new file mode 100644
index 0000000000000..ad2df5924ebc8
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
@@ -0,0 +1,133 @@
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
+#include <drm/drm_pagemap.h>
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
+/**
+ * enum amdgpu_svm_range_queue_state - Work queue state of an SVM range
+ * @AMDGPU_SVM_RANGE_NOT_QUEUED: Not on any work list.
+ * @AMDGPU_SVM_RANGE_IN_GC: Queued on the GC list.
+ * @AMDGPU_SVM_RANGE_PROCESSING: Being processed in workqueue.
+ */
+enum amdgpu_svm_range_queue_state {
+	AMDGPU_SVM_RANGE_NOT_QUEUED = 0,
+	AMDGPU_SVM_RANGE_IN_GC,
+	AMDGPU_SVM_RANGE_PROCESSING,
+};
+
+/**
+ * struct amdgpu_svm_range - amdgpu GPU mapped SVM range
+ * @base: Embedded drm_gpusvm_range base.
+ * @pages: Device-owned page and DMA mapping cache.
+ * @work_node: Links the range into the work list. Protected by amdgpu_svm.work_lock.
+ * @gpu_mapped: True while the range has a live GPU mapping. Accessed with
+ *              READ_ONCE/WRITE_ONCE.
+ * @queue_state: Current work queue state @amdgpu_svm_range_queue_state.
+ *               Protected by amdgpu_svm.work_lock.
+ * @pending_ops: Pending amdgpu_svm_range_op bitmask. Protected by work_lock.
+ * @pending_start_page: First page of the accumulated pending interval.
+ * @pending_last_page: Last page of the accumulated pending interval.
+ * @attr_flags: Attribute flags last applied to the GPU mapping.
+ * @validate_timestamp: Time of the last successful mapping validation.
+ */
+struct amdgpu_svm_range {
+	struct drm_gpusvm_range base;
+	struct drm_gpusvm_pages pages;
+	struct list_head work_node;
+	bool gpu_mapped;
+	u8 queue_state;
+	u8 pending_ops;
+	unsigned long pending_start_page;
+	unsigned long pending_last_page;
+	u32 attr_flags;
+	ktime_t validate_timestamp;
+};
+
+static inline struct amdgpu_svm_range *to_amdgpu_svm_range(struct drm_gpusvm_range *range)
+{
+	return container_of(range, struct amdgpu_svm_range, base);
+}
+
+static inline void amdgpu_svm_range_invalidate_gpu_mapping(struct amdgpu_svm_range *range)
+{
+	WRITE_ONCE(range->gpu_mapped, false);
+}
+
+#define AMDGPU_SVM_RANGE_TRACE(r__, op__)                                                          \
+	do {                                                                                       \
+		struct amdgpu_svm_range *trace_range = (r__);                                      \
+	\
+		trace_amdgpu_svm_range((op__), to_amdgpu_svm(trace_range->base.gpusvm)->vm->pasid, \
+				       trace_range->base.gpusvm,                                   \
+				       READ_ONCE(trace_range->gpu_mapped),                         \
+				       trace_range->pages.notifier_seq,                            \
+				       drm_gpusvm_range_start(&trace_range->base) >> PAGE_SHIFT,   \
+				       drm_gpusvm_range_end(&trace_range->base) >> PAGE_SHIFT);    \
+	} while (0)
+
+/**
+ * enum amdgpu_svm_range_op - Pending operation bits for an SVM range
+ * @AMDGPU_SVM_RANGE_OP_NONE: No pending operation.
+ * @AMDGPU_SVM_RANGE_OP_UNMAP: Range needs to be unmapped/removed by the GC.
+ */
+enum amdgpu_svm_range_op {
+	AMDGPU_SVM_RANGE_OP_NONE = 0,
+	AMDGPU_SVM_RANGE_OP_UNMAP = BIT(0),
+};
+
+/**
+ * struct amdgpu_svm_range_op_ctx - context of a range workqueue operation
+ * @range: The dequeued range to process.
+ * @start_page: First page for workqueue operation.
+ * @last_page: Last page for workqueue operation.
+ * @pending_ops: amdgpu_svm_range_op bitmask.
+ */
+struct amdgpu_svm_range_op_ctx {
+	struct amdgpu_svm_range *range;
+	unsigned long start_page;
+	unsigned long last_page;
+	u8 pending_ops;
+};
+
+#endif /* __AMDGPU_SVM_RANGE_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
index 1373a11f50d86..d5c7c983c04d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
@@ -116,6 +116,34 @@ TRACE_EVENT(amdgpu_iv,
 		      __entry->src_data[2], __entry->src_data[3])
 );
 
+TRACE_EVENT(amdgpu_svm_range,
+	    TP_PROTO(const char *op, u32 pasid, void *gpusvm, bool mapped,
+		     unsigned long seqno, unsigned long start_page,
+		     unsigned long end_page),
+	    TP_ARGS(op, pasid, gpusvm, mapped, seqno, start_page, end_page),
+	    TP_STRUCT__entry(__string(op, op)
+			     __field(u32, pasid)
+			     __field(void *, gpusvm)
+			     __field(bool, mapped)
+			     __field(unsigned long, seqno)
+			     __field(unsigned long, start_page)
+			     __field(unsigned long, end_page)
+			    ),
+	    TP_fast_assign(__assign_str(op);
+			   __entry->pasid = pasid;
+			   __entry->gpusvm = gpusvm;
+			   __entry->mapped = mapped;
+			   __entry->seqno = seqno;
+			   __entry->start_page = start_page;
+			   __entry->end_page = end_page;
+			   ),
+	    TP_printk("%s: pasid=%u gpusvm=%p mapped=%d seqno=%lu range=[0x%lx-0x%lx]-0x%lx",
+		      __get_str(op), __entry->pasid, __entry->gpusvm,
+		      __entry->mapped, __entry->seqno,
+		      __entry->start_page, __entry->end_page,
+		      __entry->end_page - __entry->start_page)
+);
+
 
 TRACE_EVENT(amdgpu_bo_create,
 	    TP_PROTO(struct amdgpu_bo *bo),
-- 
2.53.0

