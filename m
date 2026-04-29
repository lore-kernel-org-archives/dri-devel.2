Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC08FF8867
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 04:10:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0402810EB87;
	Wed, 29 Apr 2026 04:10:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vNRB7S5r";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013052.outbound.protection.outlook.com
 [40.93.201.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73D9B10EB87;
 Wed, 29 Apr 2026 04:10:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TFtKUUNT8SH/lgKtOx/49yFCDg3Ngm0IkQ6XV6tc3EpE//NVfWYjz1DwneWOdrRy+taI2uPm0FlN2Ir7nJ8jY2wNDCoS3yQMgXkNq+P2E6ydpdEAuDDTByqyq7BWjEsV0pRiFMeHdDCcWvTrtumCiwHCYczoHCqTIL9qPkdumZ8KYNWaPyutD7puiXX1S3rg4f0cSj5+/0ZemzBOis+BMNIhTJS5oKPkJGQQnFFcFtyCHrbwVvEXoaaB6WrxLOglPJA7yH3WerIMJ6hASC5sstWdYWjTTJ0egceDzCpn1ZfvuOn0654UKKP1b8SiucJgNtghmuv4lGqzziJzJwXNOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z94hSh0fR7eGVaqAT77d1Ve+5h2Xe3Fw+LOA4zseYQY=;
 b=xiRyEeoGjxHVQ8YKcaMUOBEbWJHM4WE03qPndiCGRINF0QQmqKXcjJLZnPsVH8CwBKHEjMV1H+OHp5UvQcVLtQwS7GY3R/GyYZ4T9tLxIzJC57go/k/U2NItCR0d8QyrcpKU4MCCVzK2BnPykVIgYtFU8VHrY95fSgg9D/VM088GuBcmeYmHIwQUt5JjfW57t/JegZJJp+v76ZUGPeMJZUqfEKAZZL0RfbggDeJHP6aE1xCCUzvHldMLLVJ1oVQi7236u9PQ+Du2jIzWE/Msoe0KQL/kGKJ8WdjbbKdHdPLdG/CZjlOg1dr8blqkP9RWvYW1Ocx2zXwT/5KzjCvy8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z94hSh0fR7eGVaqAT77d1Ve+5h2Xe3Fw+LOA4zseYQY=;
 b=vNRB7S5rBcdva7k+HV0/faS4pbQFpzvqa+0ypH6sPWaeUNSnJt1G6fH2BbSZkCe7mL9CiliNaUU3JcVz+WhvsHfKYfmKN4Dm3ZRmPGXFN4ML4MbzCBCsK17+Jmf8MfT+wdu3N5eRdZcPlKM3AloDAOO9V3yIUnZWqq4bZY3j61U=
Received: from SA9PR13CA0011.namprd13.prod.outlook.com (2603:10b6:806:21::16)
 by SN7PR12MB8103.namprd12.prod.outlook.com (2603:10b6:806:355::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Wed, 29 Apr
 2026 04:10:42 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:21:cafe::ff) by SA9PR13CA0011.outlook.office365.com
 (2603:10b6:806:21::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Wed,
 29 Apr 2026 04:10:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 04:10:42 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Apr
 2026 23:10:36 -0500
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Apr
 2026 21:07:13 -0700
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <sima@ffwll.ch>,
 <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC V4 06/12] drm/amdgpu: define SVM range types and work queue
 interface
Date: Wed, 29 Apr 2026 12:06:22 +0800
Message-ID: <20260429040628.853079-7-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260429040628.853079-1-honglei1.huang@amd.com>
References: <20260429040628.853079-1-honglei1.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|SN7PR12MB8103:EE_
X-MS-Office365-Filtering-Correlation-Id: f7a6ead0-8751-4938-368c-08dea5a547d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: /iTpm2D2wcbQXoadv0sAEcELBZNArSX01JJh954UyTZiI+1gmiUi6Ftxp6dnQ84psca7CEpjGFKigX80GVdQ9CpwXD2qm+yDJ0WrlxlTuBMKLqGoGC+MwbDfh8+PYexi3NFAp/RTqBhznn7zoEhB5IFiN0IjlNqfE5QIuZvcXQyFlfTwGdWBVY17JDxnl5yzbA6lDAT+yiJEpHTKt9KiFWMb8ktLoiT1YIEBPk49A8CttaFIqlJ+FbGP+E20CD3wIb1D+sS4YSxWjDyT8U9gNYQIzpW04jdrtAF+zE/troSeiK+zdDM6mJ8IIYHieeVmG5gRFJrwpLstjikepl3ojzVsjG5BACCeoxl3/yzO4DaaCU0gMdqyYzkXH8qBRythL+6HvO2GJUXYgj6ZWtr0zecev1Ylg0yQjdFdHDtx3zAAR5PV9UPa/QycGJfh5KuDF6ZUvuv7UDLYrCkLXiW9Rg/0oF0r9whA67AqVHIe+C+zCBOGSfNFKLPBIENAOMWsZPomHPDRmoBjy6Q09ypIHL6rKGE1yxZeSP6ZOh5uyz9KxpvnOrAFC3kULgVA5y89PbrtsELOZZ5QwNvD6haKM4gxoP798KUSrcDvOqdlMgbLdP/vKI1+wFn1zGcbCZIGTiY1UtDRR4bBZHn9TyT7aV7WZBzpXjx3dS4+0oUDcsoNSuomwWFaCeXh08UwwdOxLo+tx4IGS1szJ575U8GiCCvzZ9DtfTo+beHCG8pYfb4HvCEGnBni4zFrIpbcnUfmeEqrLoT1FCWWsPJNnZCFwrEfzmUo0rmaLWHsnHy5wHbBmmrYIylzrZcZDFWpRjem
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(56012099003)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xglGynN/qdQzcB67h7rHYFsV9wFsI+S7Vw4RAMIuoNJu9bzq9utesLG53s0Xbsp0LY5FuGUz1yEYBpGXWgS1klvX0qW4HRR9Z6ISyn492XpQKWn4YGRnI7HHwwUkzSMMLvSltBvcAFg9NS4tRjva/S2tqgw1lq/4iCsnx0MKxR/9o3zjA8gcyYeMIThOND9M2jeJJRyvtta2LHltu5lMCX6Ir1tYFFD50NsZsiKBstKAl7Ap2e2FiuNzHMOs62/ae6Q3/uYMVIwJAJS/jsGMKKX58WH6oLHNNib1+ajwqwnIC7JUBd+Uy55X0KoSgPvxKRSO0cb3haFdoKRnXU05JWCFhwEpuZGXq0y9TWm9PNBC3r8S45CwO/qbSJ0Roz38N7IZlIL68hcHCuWrnkM0NGtVpJFKFVq1lZKbQH6uGaSn1nYE9FEVayhNXfgZf7Ye
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 04:10:42.6139 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7a6ead0-8751-4938-368c-08dea5a547d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8103
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

Add amdgpu_svm_range.h with GPU-mapped range type extending
drm_gpusvm_range, deferred work queue interface, operation types,
helper macros, and range API declarations.

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h | 146 ++++++++++++++++++
 1 file changed, 146 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
new file mode 100644
index 000000000..5e9236918
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
@@ -0,0 +1,146 @@
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

