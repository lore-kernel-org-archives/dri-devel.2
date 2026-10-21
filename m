Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D8C606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 03:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=BMHzH+Cz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3158B10F88D;
	Wed, 21 Oct 2026 03:00:07 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011025.outbound.protection.outlook.com [40.107.208.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BD6C10F88C;
 Wed, 21 Oct 2026 02:59:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NpTfWVhqP6C0fzQF5SWTfU4QpT/OXefsL8BRRMoxtukk33D9I3NCeD6tZPGiWkpot8MtywGwREscGR0tIs2Ynv8zVNjjS6cESA++tudhfv6mEW2vVn3Wdez99Bgw1wE546VJBpfNQYNfxtR+ep/LjvqP8YTkeQryYSjjG/YDA/udNVrgM33kPdhtYEkroN9oxyBoImKJGtjX7eTpz5XlTuFfKLAE1Xb8LJTxmm5cBQFR0qa89IsbRs+Myqzp5K5kjgzuM966FPPRfEBRtwl+8UmgsBdZpne34kDBSoNRbLp5ttsQ+aB4p4CDzDklP49hCKGVuogi6WdQizh8OBvFtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2mALYHa9pYj7wfAVvkdZNunLVw/Z7cFkxND5LbYr2M=;
 b=aMZn8zvL5wWNAck3i0CGesSA1p0ALzfPozi/xsQRIOCejOacATntyTmT5a/yQ7TfNt8144r9B/Jfw1QvN5TPRNHwTzUfMrUupNwwQkGQaZWq46XCF/rDCO8lLj+YnU2xwvCCLC+sCp87gtl7aR08AcXqx5flCfZg+SFmk7N+EH6OeQ7U/NqGMB9a7Ac8yG8zbYkWo1R8Ca9l8gYIvyo2ZZ53EPr8Ciuagwnzb8hV0MJ6sOAMzPTv/NJYa0xPjhxhy90AkyHykckF2XG6M0Len2grFNSYHOuzD6xdSEZAjHGgzB5at52MfFMNDz3hPNwqk55oxJ2OaQO7qMU26YvnyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2mALYHa9pYj7wfAVvkdZNunLVw/Z7cFkxND5LbYr2M=;
 b=BMHzH+Cz5JT6Zr8ywFR/rHUJvOGKau1Yo77rkJHgOzRo6bE+Gl/1D1uLXKvS+l8YK+sjLU6oop8lRLcCEQ3iYO3sX5O4CtZ9FRz+K1y7Kla/IbQbqJbTsxiaiOGhhqIVA1z3F3Kj6182Clk9sxWs9OIpU+aTh9Uci2g9E5nuXqY=
Received: from SJ0PR03CA0339.namprd03.prod.outlook.com (2603:10b6:a03:39c::14)
 by CY8PR12MB7514.namprd12.prod.outlook.com (2603:10b6:930:92::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 02:59:53 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::22) by SJ0PR03CA0339.outlook.office365.com
 (2603:10b6:a03:39c::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Wed,
 21 Oct 2026 02:59:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 02:59:52 +0000
Received: from hr-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 21:59:47 -0500
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
Subject: [PATCH v10 05/22] drm/amdgpu: add SVM range types and work queue
 interface
Date: Wed, 21 Oct 2026 10:58:44 +0800
Message-ID: <20261021025915.2433837-6-ray.huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|CY8PR12MB7514:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bc1ec75-b5a6-47a0-d966-08df2f1f6104
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|921020|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: RYwP6VdOI0xRHyCphFmqxf6OYBm0MudugpYKinFPSR9KU7MFOrGO+K8zOOjfr1WMydPRjmQvtRaiPv0R1/NO+WJdBqITgsFD9JrTDzE0q/4gEFGbty1j4x8m/l/PfXx11/dH//C1SuZAcYzHaZ2MGH2joq1MXrQfHi/xtcwcK06IvU/SLyOQ0HDx8PEMIi+QgxsABttkypMhes9wF/c3IF9DTYPIM37vUBGSUDCPMTrFxr5N5Jb9R0nwUDsFeEO+13+RHwyLnzMU3HnbR/bMf169/TEADRy2FOgZb1jvwnhm0c7GPEFfDBR9SSxZD7I7PAfXZZsDsftLIvcNNnrpvglN5dXdIg8EK3Z9/6qW7zs4odwqAuDQZU/wbyydyWtc66pc7xW3uxAdQR8iVbYSrtggxL9JfFTGUMqQHc3pwKdEcnPzsM7mGHLSTFOnEyH8hvkQ7jhWmNuKriDTmsQtnJAgOalmGQDkAQBVcqE+u8+ARr4LGznb4XssIrmm659dZheNYPTBe3t4sUswJQvHkjArw+fb4mr1JzmOOsAOPtzj3pIo7tX9uKZtNzWpGZy6/PwR1DbsRvPWgf5+jCv85wIIcwlNtS0zsCmuQZFH87e85pUfxwV17bxcMA7VsjG6ztHb6gqU0NmpDbMlvydp5K5TmVxTfmvNMHFgllLiInB7Z/yohUMonSzj7Nc5eGvr2GKrBpiZ1t2aL9cE11lO6RK8iHLAoHRtjLGdjFGzDqrNlZJiarGHSHbaPvfRcll1
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(921020)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 028PmumaOTw5C4EDs6+IN8WGP7kzFG6UCuh+k0pd/5kmnl5XpFTArAfeByqOQK8/6iSTWOxfi+q0uWHmL/sYZgJnHnEDJP8+x9jTAIVRQT/8M8EnBSowjsVNBvE3ocTFaGmz8cxz0BuOTWXmoAg4pEZruFduXXKvBGsZL3SNhXP3a5IGhN/0Yr7lPtkph+FmwRHPYVI787iY1ufh+9Asxk/FRnjZGWYSxInYz3QrcHOqn3QC9N8gaxc1zEGMWU2LOtBvIHixyR2OrHJt0bbIlhDnU+lRkuFza9iN7hhcfdad8U8bHdxFWAty68xFcqvkidDd1YfSh5E60nwxBt4QjVRNY4TjU4uKbdQba/ldQLXHqtdP0CBOKDm1RW9k27vP970mzv3ijUc5DtTs6BOhxvCOuRPWjmUBb5QEfJ/sWnOfayUCW1sxMR75bS+C0koM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 02:59:52.6840 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bc1ec75-b5a6-47a0-d966-08df2f1f6104
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7514
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

Suggested-by: Christian König <christian.koenig@amd.com>
Suggested-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h | 129 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h     |  30 ++++
 2 files changed, 159 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
new file mode 100644
index 0000000000000..39db3a18b5f2f
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
@@ -0,0 +1,129 @@
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
+	struct list_head work_node;
+	bool gpu_mapped;
+	u8 queue_state;
+	u8 pending_ops;
+	unsigned long pending_start_page;
+	unsigned long pending_last_page;
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
+static inline void
+amdgpu_svm_range_invalidate_gpu_mapping(struct amdgpu_svm_range *range)
+{
+	WRITE_ONCE(range->gpu_mapped, false);
+}
+
+#define AMDGPU_SVM_RANGE_TRACE(r__, op__)				    \
+	trace_amdgpu_svm_range((op__),					    \
+		to_amdgpu_svm((r__)->base.gpusvm)->vm->pasid,		    \
+		(r__)->base.gpusvm, READ_ONCE((r__)->gpu_mapped),	    \
+		(r__)->base.pages.notifier_seq,				    \
+		drm_gpusvm_range_start(&(r__)->base) >> PAGE_SHIFT,	    \
+		drm_gpusvm_range_end(&(r__)->base) >> PAGE_SHIFT)
+
+/**
+ * enum amdgpu_svm_range_op - Pending operation bits for an SVM range
+ * @AMDGPU_SVM_RANGE_OP_NONE: No pending operation.
+ * @AMDGPU_SVM_RANGE_OP_UNMAP: Range needs to be unmapped/removed by the GC.
+ */
+enum amdgpu_svm_range_op {
+	AMDGPU_SVM_RANGE_OP_NONE    = 0,
+	AMDGPU_SVM_RANGE_OP_UNMAP   = BIT(0),
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
+	uint8_t pending_ops;
+};
+
+#endif /* __AMDGPU_SVM_RANGE_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
index 599c1d0e512b5..86ba09cba34c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
@@ -116,6 +116,36 @@ TRACE_EVENT(amdgpu_iv,
 		      __entry->src_data[2], __entry->src_data[3])
 );
 
+TRACE_EVENT(amdgpu_svm_range,
+	    TP_PROTO(const char *op, u32 pasid, void *gpusvm, bool mapped,
+		     unsigned long seqno, unsigned long start_page,
+		     unsigned long end_page),
+	    TP_ARGS(op, pasid, gpusvm, mapped, seqno, start_page, end_page),
+	    TP_STRUCT__entry(
+			     __string(op, op)
+			     __field(u32, pasid)
+			     __field(void *, gpusvm)
+			     __field(bool, mapped)
+			     __field(unsigned long, seqno)
+			     __field(unsigned long, start_page)
+			     __field(unsigned long, end_page)
+			    ),
+	    TP_fast_assign(
+			   __assign_str(op);
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

