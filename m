Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8609CD6E49
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 05:48:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E555F10F8F0;
	Fri, 29 May 2026 05:48:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C0WQLnf0";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010002.outbound.protection.outlook.com
 [40.93.198.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B67710F8EA;
 Fri, 29 May 2026 05:48:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NyOnwKOZT8+SVrv3mPbrfeiDNh1bT4BRIMvo9f56IVJOf7FfTqjQH9vnbcfi9j4wWQOM1EZnwTRsMoTj1buu9z9JQCAbi809J+65r6ylcy5vUR9keKBvzn9WebRu8RlWDu9uizqMQlwnoR71qwR+wdVRqvzgLXV5PIn4XHAHkMVhftkuXqPc+Z2TKsjECJhgap7W5lRBc1k49vZrsLHONHe9XJd/EV892SrrUStty2UH4tyTEdu1W1MxKBY8tD/o06Df+97Uwwc2lVxNVmvz5Xsm7OzeIoJdYHEX8L7xkEWTk1PhCeXGPJLrG1opKBGmV6rAwO2bt7O8Sn/qWe60Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2mHQA5pFmhSPv1li6zid3ZrnTpOubpppjckAw+r+0rU=;
 b=F/pn487ddzWfit3VElqLeOfJ8PVhvORL8G+P3d2bd34hXhm6fItzf9zc63jTUUQTEMqBgXLFG4QqMuIEwmBFd/LvdQJCzPm2t7xgHMUfQlEHO4m+WRigwRKErzKOC2vsts2FLc127oJYIp9n4wEKcC1e/+l7CGwCtIjciP5gjGdBcik1pujaZjdBsPrVrleQ9N8Z9Yr8boCiKanr4aE6XRpOXMaGkUn9vr+Njnc2ic0dISLttrkZ43dbWjJsSivyvptZ51CH6PGW88B/ICcokZh3eA0dK3vQ34I3DLYJcc94IpRnleAr3hZtU5vsPDINv2S8MtmMlls01yCiD7T3FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mHQA5pFmhSPv1li6zid3ZrnTpOubpppjckAw+r+0rU=;
 b=C0WQLnf0bduutubFgt3oXjI5KW8B1oAUy6cgz5KMnm7+eC/dyGL7Xjue9stYW60MR3SUrmWCs5Ju7oTyabwr5jNUlxFKP09aiM1DI8qjuGnhYD14nOc2Zgx7RXuwa7SdgsUpvnAuojZ8+XGdR+eeQBDxWf9USz168kwko5JDlz0=
Received: from CH0P221CA0026.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::6)
 by LV3PR12MB9438.namprd12.prod.outlook.com (2603:10b6:408:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Fri, 29 May
 2026 05:48:51 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:11d:cafe::21) by CH0P221CA0026.outlook.office365.com
 (2603:10b6:610:11d::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Fri, 29
 May 2026 05:48:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 29 May 2026 05:48:50 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 29 May
 2026 00:48:45 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>,
 <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC V7 06/12] drm/amdgpu: add SVM range types and work queue
 interface
Date: Fri, 29 May 2026 13:47:58 +0800
Message-ID: <20260529054804.596214-7-honglei1.huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|LV3PR12MB9438:EE_
X-MS-Office365-Filtering-Correlation-Id: 26bee0a7-d60e-430e-ab04-08debd45f5e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|921020|22082099003|18002099003|56012099006|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info: XFN56+PKUkW98KbGa8PqRoAQ1WV+pJ+nKHjs8+XNY56m+sCoTuh0bL2XZn22U9SuhpDGEsDk+t0jrWnHoKyBfOR8YDi7OerSVRITC6tNileJWTTJ93oqwD5T9O1ilsSXTNCgXTajy1k6MafuwpdNEGRXJf07o+KZVorHu2/bPcnsYbQCkbJ+4+XGj5426h9BILYRqsZEkzrpwQy1JgXpCsYnUCnXnVoR3C3GWrOp3gzrYNTlCFgo47lBEE2FBF/W8yJpll/dxfXz6qPmZwpNJ3dvzCl+Szv6Zv0yV7riZns4Yq8pwKbGPqGN/jEsVvGS9qA4JPai9wov38J6WoypEsxrOHvRy16s/NNq00QUv7Vko7suVYyzjtaWdz96JuMDEPvEIZ0QVWtCKBcOzc0Lgf5V/6jbpEg1OWW95Ge3eaYiYbNTMOjwRuBRBIw9VU+1wfRcYhKbiUOlYSd06mvdBpw5P/ieGx1b961/HYXKGUVcXHZcsJCGItO/40UZoY0yyMbEsJ3KtB9dy9Om7qfyc/uMvaFl5l7F7bNNsn1ENRNYXlLBJTHIZHFNViPbnGjAfn2IS2NCGCnbjgxdt4hayQUO3jRY6gtxbpw8J2gRQvAgzIQWMZGgPP0HlicGAp+nZKfsUPmjPGk9PJ4kNDA5rgnaN5M14WRnq7nvQJUJwLN7+r/9FzGr6mJi5FrNRZ6X4HzQ0UCyhruWm3Mawx0i42fJsliiYAM9qi/zcU2zxwP1GebUUe76CPB5DUP/Ln4RT1HVf6L02gUBVhtu8ExGAg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(921020)(22082099003)(18002099003)(56012099006)(3023799007)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Uf2gYdK1xsINIeiWcexVN70RcYieBZLZ01T+6q+Qn4B6DNicgRJHutvamOusJ62MFXjW0qruHfcV7DkB4yfBaJsGZbPTbqMrU6xDk5+87kRUF2q5/TxvS5GVBC8Ekf4CnH40rVDv/L+8l4cxHoHiRq3OmX7MZvxvvVZ1q300dBpDJ/ebxW99e2RKNyyBC5ppAC0Cy7YD8kI+kbijrISrLtEt688U6Ijn1DlC0URSbnJJdSoxYuY7IdqCQXF6wHTRwz64ej9v/tXTXCx4rXrSNuw9trk4aLnyYMN165hi+Fm6MfL8gsB/9cl1PdQkoSUwZ5uxcadZNn01IYSBSCydrg/0L/3k4Ev7ndCo/t9exft8rsQww6zTeELzlAecF7D73SgaqxpdDADvgs5pj+ReQa3rQ4yquL6zL2gyEb6KWOaQ1S+NnLkK6RF6HcyiQXYb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 05:48:50.8587 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26bee0a7-d60e-430e-ab04-08debd45f5e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9438
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

Add amdgpu_svm_range.h with GPU-mapped range types and interfaces:
- enum amdgpu_svm_range_queue_state: NOT_QUEUED, IN_GC, IN_RESTORE,
  PROCESSING states for work queue management
- struct amdgpu_svm_range: extends drm_gpusvm_range with gpu_mapped
  state, queue_state, attribute flags, work queue node, pending
  ops/pages, and validation timestamp.  PTE flags are not cached on
  the range; they are recomputed per DMA segment from the segment's
  drm_pagemap protocol when the mapping is programmed.
- enum amdgpu_svm_range_op: NONE, UNMAP operation types
- struct amdgpu_svm_range_op_ctx: dequeue context for GC processing
- Helper macro: UNMAP_WORK
- Inline helper: amdgpu_svm_range_invalidate_gpu_mapping
- AMDGPU_SVM_RANGE_DEBUG trace macro with range details
- Full range API declarations: find_or_insert, get_pages,
  update_mapping, update_gpu_range, lock_vm_pd, invalidate,
  map_attrs, notifier_event_begin, dequeue/put helpers,
  zap_ptes (page-range based), and evict (devmem-aware wrapper).
  attr_pte_flags takes an enum drm_interconnect_protocol; is_valid,
  update_gpu_range and update_mapping take the attribute set plus a
  read_only flag instead of a pre-computed pte_flags value.

Include <drm/drm_pagemap.h> for enum drm_interconnect_protocol.

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h | 166 ++++++++++++++++++
 1 file changed, 166 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
new file mode 100644
index 000000000..82d4b353b
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
@@ -0,0 +1,166 @@
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
+enum amdgpu_svm_range_queue_state {
+	AMDGPU_SVM_RANGE_NOT_QUEUED = 0,
+	AMDGPU_SVM_RANGE_IN_GC,
+	AMDGPU_SVM_RANGE_IN_RESTORE,
+	AMDGPU_SVM_RANGE_PROCESSING,
+};
+
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
+#define AMDGPU_SVM_RANGE_DEBUG(r__, op__)                                      \
+	AMDGPU_SVM_TRACE("%s: pasid=%u, gpusvm=%p, mapped=%d, "                \
+			 "seqno=%lu, range: [0x%lx-0x%lx]-"                    \
+			 "0x%lx\n",                                            \
+			 (op__), to_amdgpu_svm((r__)->base.gpusvm)->vm->pasid, \
+			 (r__)->base.gpusvm, READ_ONCE((r__)->gpu_mapped),     \
+			 (r__)->base.pages.notifier_seq,                       \
+			 drm_gpusvm_range_start(&(r__)->base) >> PAGE_SHIFT,   \
+			 drm_gpusvm_range_end(&(r__)->base) >> PAGE_SHIFT,     \
+			 (drm_gpusvm_range_end(&(r__)->base) -                 \
+			  drm_gpusvm_range_start(&(r__)->base)) >> PAGE_SHIFT)
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
+
+void amdgpu_svm_capture_checkpoint_ts(struct amdgpu_svm *svm);
+
+uint64_t amdgpu_svm_range_attr_pte_flags(struct amdgpu_svm *svm,
+					 const struct amdgpu_svm_attrs *attrs,
+					 bool read_only,
+					 enum drm_interconnect_protocol proto);
+int amdgpu_svm_range_lock_vm_pd(struct amdgpu_svm *svm,
+				struct drm_exec *exec,
+				bool intr);
+bool amdgpu_svm_range_pages_valid(struct amdgpu_svm *svm,
+				  struct amdgpu_svm_range *range);
+bool amdgpu_svm_range_is_valid(struct amdgpu_svm *svm,
+			       struct amdgpu_svm_range *range,
+			       const struct amdgpu_svm_attrs *attrs);
+int amdgpu_svm_range_update_gpu_range(struct amdgpu_svm *svm,
+				      struct amdgpu_svm_range *range,
+				      const struct amdgpu_svm_attrs *attrs,
+				      bool read_only,
+				      bool flush_tlb, bool wait,
+				      struct dma_fence **fence);
+int amdgpu_svm_range_update_mapping(struct amdgpu_svm *svm,
+				    struct amdgpu_svm_range *range,
+				    const struct amdgpu_svm_attrs *attrs,
+				    bool read_only,
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
+int amdgpu_svm_range_map_attrs(struct amdgpu_svm *svm,
+			       const struct amdgpu_svm_attrs *attrs,
+			       unsigned long start, unsigned long end);
+int amdgpu_svm_range_invalidate_interval(struct amdgpu_svm *svm,
+					 unsigned long start_page,
+					 unsigned long last_page);
+int amdgpu_svm_range_zap_ptes(struct amdgpu_svm *svm,
+			      struct amdgpu_svm_range *range,
+			      unsigned long start_page,
+			      unsigned long last_page);
+void amdgpu_svm_range_evict(struct amdgpu_svm *svm,
+			    struct drm_gpusvm_range *range);
+void amdgpu_svm_range_invalidate(struct amdgpu_svm *svm,
+				 struct drm_gpusvm_notifier *notifier,
+				 const struct mmu_notifier_range *mmu_range,
+				 struct drm_gpusvm_range *first,
+				 uint64_t adj_start, uint64_t adj_end);
+bool amdgpu_svm_range_notifier_event_begin(struct amdgpu_svm *svm,
+					   struct drm_gpusvm_range *range,
+					   const struct mmu_notifier_range *mmu_range);
+struct amdgpu_svm_range *
+amdgpu_svm_range_find_or_insert(struct amdgpu_svm *svm, unsigned long addr,
+				unsigned long gpuva_start, unsigned long gpuva_end,
+				struct drm_gpusvm_ctx *ctx);
+int amdgpu_svm_range_get_pages(struct amdgpu_svm *svm,
+			       struct drm_gpusvm_range *range,
+			       struct drm_gpusvm_ctx *ctx);
+
+#endif /* __AMDGPU_SVM_RANGE_H__ */
-- 
2.34.1

