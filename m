Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 801D7C5518F
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 09:43:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DCB310E964;
	Tue,  4 Aug 2026 09:43:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lxzWDWh4";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012057.outbound.protection.outlook.com
 [40.107.200.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B234E10E966;
 Tue,  4 Aug 2026 09:43:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gxttgPmFOM3OK/stNK1/q/r5ZsvedkA48GbOPZNnt6vzSYtdzPuZVatUl3H4eQLEioF1atWqYMWM618gL6CpOQCLFK70+dHA+Z6K6MKRVYmNp7qua3p7BIOPf1qcCuFTsgK9geLZnQk2bpE4H+O0mWIZUDYfXAJ29arDyjV5/B8o0gKiN0AWN/Z9+/n8ReKX3a6vXqac+mU2QQ44jDV7r8PsNl7Cawz6BGjxy3d/5HKWkuEyrFtFRa1XYAmkpDiNo6TC9PmaWZNYRh8aueY5Kq8qFQVi7f7LsUan81+GAaug8yG4UaXEpxEqS245+tU+vhxE0cyeiYYGiu4m/ClXpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8o6nLARyqS44xBEvaqoV92fPAqqku8FxW/MNtsGOu8Q=;
 b=uzDDqn6+S4jKchpeJ0geh5MHJfje53ZEbvCTNl2GrELAwv9c5ITMq/X5SyeRm0qmEnWpi1JJUu7M7wRyFqolhQo9ZfBJxtv+uskUy6xzqrdD/0e4Zmne5J8+p3w/HUUO7VpQTP8U3ptYn23NXp6gqgubv4Avx/XEhcFm1Gb5DECSlCPd81EHgf2rU6JHiqpPRX7iMBANHt5LFS0A+PmfOOTzJnUMFpM7oU0j2Pz3+Bhnjmhr3fZfJfHiAGRoE4o8uGZdgMYtWFZTfIgJlirh9gJnPGuhTZ4DFNL/LlfyLL11chmYzJdtS5oW8jywUtbohWlDwdgFPtn3GTGZOJ3C4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8o6nLARyqS44xBEvaqoV92fPAqqku8FxW/MNtsGOu8Q=;
 b=lxzWDWh4aLLyWPJITL/6u5NmqYzMeYW+2rBqWNglJ3Gqo9gt/ZVI3Cfm+cQoK6UcoJmDsrrYp0kU+0GewIL9ZUVPI0pYwSWHcZSzKB6ei7vQGZKYVUxFJotgGojqHHOL+1T+gNUfZGZSqqRvgidqHcIx7zh4SpkItTOLaLpsWMU=
Received: from SA9PR13CA0056.namprd13.prod.outlook.com (2603:10b6:806:22::31)
 by SA0PR12MB4367.namprd12.prod.outlook.com (2603:10b6:806:94::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 09:43:27 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:806:22:cafe::7) by SA9PR13CA0056.outlook.office365.com
 (2603:10b6:806:22::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.9 via Frontend Transport; Tue, 4
 Aug 2026 09:43:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 09:43:27 +0000
Received: from hr-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 4 Aug
 2026 04:43:22 -0500
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
Subject: [PATCH v9 05/18] drm/amdgpu: add SVM range types and work queue
 interface
Date: Tue, 4 Aug 2026 17:42:31 +0800
Message-ID: <20260804094246.1719318-6-ray.huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|SA0PR12MB4367:EE_
X-MS-Office365-Filtering-Correlation-Id: 267f5eeb-521c-4874-7c2e-08def20cd5de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|22082099003|18002099003|56012099006|11063799006|3023799007|10067099003|921020;
X-Microsoft-Antispam-Message-Info: /2xW/kahxNPvxHCtZJXoYKmmGsLx+sWg/vs+P+fpH0CmtdFsyoz5qAPesU+Z82cVqaC1Bsaiu+euuRIOxU2Q7wHk15xpIYjHLHjuRuLFw44CNBXBCTjqn9tqmhXR8g5lkPD8waz88t/CNP4xu8lZEBn0zJgkoO+6XeHcN0xkKOP0AlZ/M96pDmnJaKpWQYwdkWwLlbxvml56BN/fw+SznZbd1ZFlfao/XVwnEJTYHFyVMnzzknLN3JbQvk/hRLFaotJ1MD8AghxhaUJwQgyo5+/4RmoPUEnr1GFw+Es2TJspEO6HoaPJatuIni/Whj/BPs+lJVX3NSTLd+6Kwy6Cyfb4J/7WSZxas51zlMtttaMm4W4MEolUKHUgIkNF4/1+r8CBSrKZVvGvZzQZ8NwLbMJo3g6VP0vb6GlE7FRLSWirFrgLlO1sM7+HTJawYi74LFtloeuvOWqmGdl+raaky0hrCbbcL5ta+W4cs2vgmZ81wWDIttTsgYNZD6m/Nveps8SYmvjn3lYOXhGGT9yZJ7Wdqj+UnTn5OvmbFQbTny+8n5V0XAEKVKJVFD04Hic5FrXmvC1gn7hlnh6vsa67FrLNAV06pj363opMoyqDrBqwpu3JI+CgShh79TTvGaGrGEgdBX/U5O5F45IofvpP08wBD0ktItTEIGRq+o508w7o2reD/onJq3V/HWxwxU35JzT8eWLQcZaBXhNXmInskbUkklakKtmB7oiPGWy9B5yEn8k1Zi2BgJIcnMt/pO68
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(3023799007)(10067099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EQYk6fzaqYrk++QnpTBVAUn/JvO2fHrOdN/pHrvPqOEHsCIKDydZhYggVYtbME69N1cL0/9bLKDHydpmsiHZlE1bw0LvVuhu0r4pefoodIMm2cjVB5u5Nv2DvzsdpF3DktQbyScN4HyNDmHSBXqUXgXpZcP2AjXe9Ds1cWBQ4/5j+mi6r6wmUP6DHhIRZYk0TvyiH14MtlsKZhYLfRN6wqtN1smgpwr+OjvVHh98/EbWlEGZd0H+LxzLPN/EpaCJqrpkl56k11fzKgfbeAcX7FyNHJ+nQ5bQa7ndr8Uqau9Z+dXjEnrHzgrOQcf+FOTA8p17hfO/qG5cmRCypH2vCi7QPdZzckDA4UvCJIZHhLcofyVsZezAgKMsjdK+6trrx7NrvaqE8KtFGZELil6UxWiLnXJFu3QAz8VE+K/6cdS9bapgBKTsvYXAj+Sj+QPL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 09:43:27.4186 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 267f5eeb-521c-4874-7c2e-08def20cd5de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4367
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
index 4580ab533ca98..88c160c55f1fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
@@ -114,6 +114,36 @@ TRACE_EVENT(amdgpu_iv,
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

