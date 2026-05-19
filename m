Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC65CD4851
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 09:23:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6A4810EBB6;
	Tue, 19 May 2026 09:23:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ymeG+HX8";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011035.outbound.protection.outlook.com [40.107.208.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E877C10EBB6;
 Tue, 19 May 2026 09:23:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e4xEcwzOYNtX+jlEY5PkpaBSNmCqzyte9nZcFY/uPiE10EXIPjTHxLlX04eGlj3QcMScw1Xte0LVvu19/Oeu2fLer8l8MZFxEwh7uqLx1A6PtqzxPH1n2Ok0zXsnNOE9svdMVgF7+mF2ur0mhvPmHcLyLbg0NGbIP9BKRm5qj8bOZzlgdKO3g+/dzH2qvH7JjAxfgFKldjhO03I/ufVa5wosjjAbAfgcVseDrLZPe9k2OjYcosq27o1nXwdw3nEr1v+dh/YcFY014WDdFV3UquE6+WXHkbQr3XULj2MHko6nNov0yzRSaii+OZQMsmWE9nx9gkpoDZVbjnkJYATQjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZR+qZ6cl1sCed8BTHYppEhOis9A0MSte7Q/y2eXZdY=;
 b=bIryUvqjPTQVRNVT0r6DZErtipv+HJfxcHMLJcTWn5JA0clecVNIdjJcXaJzBVN7WjUYJDMESXjr0RFQz8rjiiOEjaZcrQJazDKO/sckDxN3YxIi5ExLxSUNt1Ace+dlNRERbwOqgz2Ed0/8fYeigksXTlf8i6vSE7VYTOMJqpWeuYjwBKXgQrGLuwrFQQsLbusIYF/XkmOPc8mplaT40fs+Yccukb2UBkJjfyZEkP/X4HaiEoICgQi7ElwJkkYrPMFGEa0jtNPVrS62bjXryYFwF7i4a5AXVxw/beC3ZWt8Z8h8zIG7fJeeADsjPR8oljF3gtovl3a/MyjfwxcBOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZR+qZ6cl1sCed8BTHYppEhOis9A0MSte7Q/y2eXZdY=;
 b=ymeG+HX84MgD24WWiAr28r6mbX1F45JikssNZ0dq4pIuwpppJCBBIKYeCy8e+AYTan+aIxlewNMrR5gQ+Mw6bN49F/jHr6SaUjWO1/sgoldwIXGk5XR8ZQPCPDpI5oHc0nt8zYIUv0UZbeo70sbvfpFQNhIAyITT/R8UMwoNZtU=
Received: from DSZP220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:280::7) by
 DS0PR12MB8477.namprd12.prod.outlook.com (2603:10b6:8:15b::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.24; Tue, 19 May 2026 09:23:46 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:5:280:cafe::88) by DSZP220CA0004.outlook.office365.com
 (2603:10b6:5:280::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 09:23:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 09:23:45 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 19 May
 2026 04:23:40 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>,
 <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC 3/8] drm/amdgpu: implement xnack-off restore core and invalidate
 callback
Date: Tue, 19 May 2026 17:23:08 +0800
Message-ID: <20260519092313.3115848-4-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260519092313.3115848-1-honglei1.huang@amd.com>
References: <20260519092313.3115848-1-honglei1.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|DS0PR12MB8477:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ad10daf-c637-4650-583b-08deb58853bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|22082099003|18002099003|56012099003|11063799006|921020|3023799003;
X-Microsoft-Antispam-Message-Info: ltmkbnIdiuEv3JW/Iaoeh0eYVyY3i+Fed63BcWGiSypJbHecQ058/rFRXcThiGwTCT9NGDaPR/9S/bv2hQDQwzPHQV/pUWOZynIzelBt6S6IMQFcS4mYl7YdMNRo0z3Z7hTMhcIVGjFQYSc4nGfLHE2OgbkeDgI6Wr7WsqM/z1UgPnyfhT5hMQeke6XWtp8r2jYVwcheBd+z83Ay5xMk4e/DsX0ZMPP3/yBvpsw3L/3DdoM+k7TG3caRt4NWd7zM1Pm4LXzUeDK1vGuFtu/LYgH8QmpMc5pXY/xtmCk4dDA/oVulqzaXzLVV1X2pWkltzOxXIA9lieqo61og5wUGSXwvQx2VHQXJa5I2EPA+aoUQjATQrqsUOjhxU9lmXCm8brhBPQTxcZRfKpy49G+9dZ4v05ZoZz5Ux5TrSClNwX7rQW8u8PMF5pDjWiYZwBRGfroWAswgO9UZgjGqB6XHlFcJWBhb48gzFQySZj/xauk7AW4sYoQC9kvNOFz9ZzVxtLhqP0fYUKcIqdLcFXiAZzRx83ILdOhudSWmzRgzvAZflmjuaH+ywiRwrrsn4gIIgirTY04tWimJ+dmNGOjCCfmiTX6r/Ro8TiPupUkMaBIdZKJtLOpKtfQMb0ysMptpPVe+ev8fRQjkQmBdBO144XZw57906WYjKqCsD3Mq/wRrWVNgz5/NbLH3cYdIkDBeWVqA7BFPPWu3yNs89axQeWpJsTVVpE6HrdGVdIJunMwi17I8ArFKNJcmCxOeS92ksv59aMvaF27/VGrL/798SA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(22082099003)(18002099003)(56012099003)(11063799006)(921020)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MOg03Dgeh5gl185K9akSBoVM04wFHNFvVRUOgTc93kCjtWMPpJgzMCN+/d8Ai6p/kyc1mV0RZ4pevAKW2xrFgyMQJjJzzEhUYKpxanmBfmKZa9WDtlkXqrJNh4HMObVf7z1nB7NhdjKT50x9sgf8L9j0ony/3Y3SlXK4dAtjz1nV6gWQ75TrI20cVC2vcbqEQ7hBoQkt8EcuI2GU2claWrsaT7HHBxQDLwqz7S7P4zA7LRTu0pjveaYzdY7awuy51blzEtRsYdqlsFvygaNMXnloCoaPsib7IyySjjXOqQ7zIEfTQSFTHvkbfWl+VpKgBn2tywFdXPgZR+9igVTMhlIicPjF55bLs3R3YZ9ec4gkJIx6FrgdE+uMTB4GebB7TvWYkhQy7lCjXO2A2iMl26ybeyXfms1jDyXvsm75Uxy6U76vhBJFwAeibE9ktiOk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 09:23:45.7539 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ad10daf-c637-4650-583b-08deb58853bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8477
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

Implement the core restore infrastructure and invalidation callback for
xnack-off SVM. The invalidate callback handles MMU notifier events by
quiescing compute queues when needed and scheduling restore work.

For MMU_NOTIFY_UNMAP events, avoid unconditionally quiescing compute
queues -- only quiesce when a range is partially unmapped and has active
GPU mappings (i.e. the GC worker will need a rebuild window). Full-range
unmaps and ranges without GPU mappings skip the quiesce entirely, which
reduces unnecessary queue preemption traffic.

Non-UNMAP events (CLEAR/MIGRATE) always quiesce because PTEs are cleared
synchronously and the restore is asynchronous.

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.c | 257 ++++++++++++++++++++
 1 file changed, 257 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.c

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.c
new file mode 100644
index 000000000..b231c7d44
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.c
@@ -0,0 +1,257 @@
+// SPDX-License-Identifier: MIT
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
+#include "amdgpu_svm.h"
+#include "amdgpu_userptr.h"
+#include "amdgpu_svm_range.h"
+#include "amdgpu_svm_attr.h"
+#include "amdgpu.h"
+#include "amdgpu_amdkfd.h"
+
+#include <drm/drm_gpusvm.h>
+
+#include <uapi/linux/kfd_ioctl.h>
+
+#define AMDGPU_SVM_RESTORE_WQ_NAME "amdgpu_svm_restore"
+
+static void svm_restore_enqueue_work(struct amdgpu_svm *svm,
+				     struct amdgpu_svm_range *range,
+				     unsigned long start_page,
+				     unsigned long last_page,
+				     uint8_t pending_ops);
+
+static void amdgpu_svm_restore_worker(struct work_struct *w);
+
+static void
+svm_restore_notifier_event_end(struct amdgpu_svm *svm,
+		   struct drm_gpusvm_range *range,
+		   const struct mmu_notifier_range *mmu_range)
+{
+	struct drm_gpusvm_ctx ctx = { .in_notifier = true, };
+	struct amdgpu_svm_range *svm_range = to_amdgpu_svm_range(range);
+	unsigned long start_page = max(drm_gpusvm_range_start(&svm_range->base),
+				       mmu_range->start) >> PAGE_SHIFT;
+	unsigned long last_page = (min(drm_gpusvm_range_end(&svm_range->base),
+				       mmu_range->end) >> PAGE_SHIFT) - 1;
+
+	amdgpu_svm_assert_in_notifier(svm);
+
+	drm_gpusvm_range_unmap_pages(&svm->gpusvm, range, &ctx);
+	if (mmu_range->event == MMU_NOTIFY_UNMAP) {
+		AMDGPU_SVM_RANGE_DEBUG(svm_range, "GARBAGE COLLECTOR ADD");
+		drm_gpusvm_range_set_unmapped(&svm_range->base, mmu_range);
+		svm_restore_enqueue_work(svm, svm_range, start_page, last_page,
+			     AMDGPU_SVM_RANGE_OP_UNMAP);
+	} else {
+		AMDGPU_SVM_RANGE_DEBUG(svm_range, "RESTORE WORKER ADD");
+		svm_restore_enqueue_work(svm, svm_range, start_page, last_page,
+			     AMDGPU_SVM_RANGE_OP_RESTORE);
+	}
+}
+
+static void svm_restore_eviction_begin(struct amdgpu_svm *svm)
+{
+	if (atomic_inc_return(&svm->restore.evicted_ranges) != 1)
+		return;
+
+	svm->restore.begin(svm);
+}
+
+static bool
+svm_restore_unmap_needs_quiesce(struct drm_gpusvm_range *range,
+				const struct mmu_notifier_range *mmu_range)
+{
+	struct amdgpu_svm_range *svm_range = to_amdgpu_svm_range(range);
+
+	if (!READ_ONCE(svm_range->gpu_mapped))
+		return false;
+
+	return drm_gpusvm_range_start(range) < mmu_range->start ||
+	       drm_gpusvm_range_end(range) > mmu_range->end;
+}
+
+void
+amdgpu_svm_restore_invalidate(struct amdgpu_svm *svm,
+			      struct drm_gpusvm_notifier *notifier,
+			      const struct mmu_notifier_range *mmu_range,
+			      struct drm_gpusvm_range *first,
+			      uint64_t adj_start, uint64_t adj_end)
+{
+	struct drm_gpusvm_range *r;
+	bool is_unmap = mmu_range->event == MMU_NOTIFY_UNMAP;
+	bool needs_flush = false;
+
+	if (is_unmap) {
+		bool quiesced = false;
+
+		amdgpu_svm_capture_checkpoint_ts(svm);
+
+		r = first;
+		drm_gpusvm_for_each_range(r, notifier, adj_start, adj_end) {
+			if (!quiesced &&
+			    svm_restore_unmap_needs_quiesce(r, mmu_range)) {
+				svm_restore_eviction_begin(svm);
+				quiesced = true;
+			}
+
+			needs_flush |= amdgpu_svm_range_notifier_event_begin(
+							svm, r, mmu_range);
+		}
+
+		if (needs_flush)
+			svm->flush_tlb(svm);
+	} else {
+		svm_restore_eviction_begin(svm);
+
+		r = first;
+		drm_gpusvm_for_each_range(r, notifier, adj_start, adj_end)
+			amdgpu_svm_range_invalidate_gpu_mapping(
+							to_amdgpu_svm_range(r));
+	}
+
+	r = first;
+	drm_gpusvm_for_each_range(r, notifier, adj_start, adj_end)
+		svm_restore_notifier_event_end(svm, r, mmu_range);
+}
+
+static void
+svm_restore_enqueue_work(struct amdgpu_svm *svm,
+			 struct amdgpu_svm_range *range,
+			 unsigned long start_page,
+			 unsigned long last_page,
+			 uint8_t pending_ops)
+{
+	bool queue_gc_work = false;
+	bool queue_restore_work = false;
+
+	if (atomic_read(&svm->exiting))
+		return;
+
+	spin_lock(&svm->work_lock);
+
+	/* Deny any work if range is unmapped */
+	if (UNMAP_WORK(range->pending_ops)) {
+		spin_unlock(&svm->work_lock);
+		return;
+	}
+
+	range->pending_start_page = min(range->pending_start_page, start_page);
+	range->pending_last_page = max(range->pending_last_page, last_page);
+
+	if (UNMAP_WORK(pending_ops)) {
+		range->pending_ops = AMDGPU_SVM_RANGE_OP_UNMAP;
+
+		switch (range->queue_state) {
+		case AMDGPU_SVM_RANGE_NOT_QUEUED:
+			drm_gpusvm_range_get(&range->base);
+			list_add_tail(&range->work_node, &svm->gc.list);
+			range->queue_state = AMDGPU_SVM_RANGE_IN_GC;
+			queue_gc_work = true;
+			break;
+		case AMDGPU_SVM_RANGE_IN_RESTORE:
+			/* Not in processing so move to gc is safe. */
+			list_move_tail(&range->work_node, &svm->gc.list);
+			range->queue_state = AMDGPU_SVM_RANGE_IN_GC;
+			queue_gc_work = true;
+			break;
+		case AMDGPU_SVM_RANGE_PROCESSING:
+			/* Do not move range into gc, because if the range is being
+			 * processed by the restore worker, moving it to GC may cause
+			 * use-after-free: the GC worker would remove the range while
+			 * the restore worker is still using it.
+			 * Owner worker will see UNMAP in pending_ops by
+			 * put_if_dequeued() and move to gc after processing the
+			 * restore work.
+			 */
+			break;
+		case AMDGPU_SVM_RANGE_IN_GC:
+			break;
+		}
+	} else {
+		switch (range->queue_state) {
+		case AMDGPU_SVM_RANGE_NOT_QUEUED:
+			range->pending_ops |= AMDGPU_SVM_RANGE_OP_RESTORE;
+			drm_gpusvm_range_get(&range->base);
+			list_add_tail(&range->work_node, &svm->restore.list);
+			range->queue_state = AMDGPU_SVM_RANGE_IN_RESTORE;
+			queue_restore_work = true;
+			break;
+		case AMDGPU_SVM_RANGE_IN_RESTORE:
+			range->pending_ops |= AMDGPU_SVM_RANGE_OP_RESTORE;
+			break;
+		case AMDGPU_SVM_RANGE_PROCESSING:
+			/*
+			 * Owner worker will see RESTORE in pending_ops
+			 * via put_if_dequeued() and queue into restore worker.
+			 */
+			range->pending_ops |= AMDGPU_SVM_RANGE_OP_RESTORE;
+			break;
+		case AMDGPU_SVM_RANGE_IN_GC:
+			/* Should not goto here cause UNMAP denies all the work. */
+			break;
+		}
+	}
+
+	spin_unlock(&svm->work_lock);
+
+	if (queue_gc_work)
+		queue_work(svm->gc.wq, &svm->gc.work);
+	if (queue_restore_work)
+		queue_delayed_work(svm->restore.wq, &svm->restore.work,
+				   msecs_to_jiffies(AMDGPU_SVM_RANGE_RESTORE_DELAY_MS));
+}
+
+int amdgpu_svm_restore_init(struct amdgpu_svm *svm,
+			    void (*begin)(struct amdgpu_svm *),
+			    void (*end)(struct amdgpu_svm *))
+{
+	svm->restore.wq = alloc_ordered_workqueue(AMDGPU_SVM_RESTORE_WQ_NAME,
+						  WQ_HIGHPRI | WQ_MEM_RECLAIM);
+	if (!svm->restore.wq)
+		return -ENOMEM;
+
+	svm->restore.begin = begin;
+	svm->restore.end = end;
+	atomic_set(&svm->restore.quiesced, 0);
+	atomic_set(&svm->restore.evicted_ranges, 0);
+	INIT_LIST_HEAD(&svm->restore.list);
+	INIT_DELAYED_WORK(&svm->restore.work, amdgpu_svm_restore_worker);
+	return 0;
+}
+
+void amdgpu_svm_restore_fini(struct amdgpu_svm *svm)
+{
+	cancel_delayed_work_sync(&svm->restore.work);
+	amdgpu_svm_clean_queue(svm, &svm->restore.list);
+	atomic_set(&svm->restore.evicted_ranges, 0);
+	if (atomic_read(&svm->restore.quiesced))
+		svm->restore.end(svm);
+	destroy_workqueue(svm->restore.wq);
+	svm->restore.wq = NULL;
+}
+
+void amdgpu_svm_restore_flush(struct amdgpu_svm *svm)
+{
+	flush_delayed_work(&svm->restore.work);
+}
-- 
2.34.1

