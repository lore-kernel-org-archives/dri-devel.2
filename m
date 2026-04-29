Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B930FCCFA13
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 04:11:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0146910EE4F;
	Wed, 29 Apr 2026 04:11:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JHaRqmkm";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011012.outbound.protection.outlook.com [52.101.57.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE46C10EE42;
 Wed, 29 Apr 2026 04:10:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e5Yn+km+ZgTyAddD+29vmdMjlM6s86W+cl6ghTygrp8ZeUPcqetcGy5tIQMuLY/Q0lKihAK14mToAep7P3VmNRQREJAkzpZFZzZWU0EKcgaiipfyA/tWF7OaE3fpZYbQAxuuyZLMOWmu9aZ0Ps16jZjHbWdpB041a63R2Lpns161iJAAd9QH5jbbDfVq0z5fvfLKnRbv6CTBN/2sYwFLaDi5/PoJtzYJ/vCnNvaYsH2SrJ2kQ5qCQqHqWt/48U22n1h47X/P8ml6rpmhd/jtzQE/f8HLA9j9rsmmAAYiFGkFnvz87rEWFsCZAll+dOxnRrxrX2hmYHw+vyKmsHjz1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJ2BNa9NfZHyJEN5h25px8dw1qN33GflIPXXEQDI5NY=;
 b=qOhChcesWJ22ADhi3BFdMJdZHs/Ti0256egO3oF/8LcuQ8hEjzROJhidrqv8J3kTh1Wq756W70sWWUGf7iQgXB7D9j7UCdm4svs+UEriRkwOTL8BeRTK7/L3jX3W3lMSHfPnvINJhq2relIY5R/49z4i9yt9Jc7tJ2rLC9KjkF7L7Y651Z37fm/BWR63LaW2CD1ZnrzbChjyDs9X3GqB3uR6Prj1ozIAYUqgLYSL/Z+IADc+xXQUg1IG3dcQpQP8naXFzwGXJakC+MA0QkbJOlJ4OVUeWHxBEs+5HweoZ0Bt6pdXyBvN90/AEVELznAKXEQZwToA5moPH8GZtUGdKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJ2BNa9NfZHyJEN5h25px8dw1qN33GflIPXXEQDI5NY=;
 b=JHaRqmkmtaBqomF/Ct1wLAzY4FnU1wgsS5H/vqljpsB144JXA7uJJtvU96gKRQ660hdvEe3TIk6REeZBVR5zTw4Go+QNsjWSKnW0wkYdM8ORye4igx9hq3dtTdveEDVsssvtNM/7IDR2Z5+Gx5qncdOrh5w/HsnTRbtFnhLJUtw=
Received: from SA9PR13CA0012.namprd13.prod.outlook.com (2603:10b6:806:21::17)
 by DS4PR12MB9586.namprd12.prod.outlook.com (2603:10b6:8:27e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Wed, 29 Apr
 2026 04:10:43 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:21:cafe::50) by SA9PR13CA0012.outlook.office365.com
 (2603:10b6:806:21::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Wed,
 29 Apr 2026 04:10:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 04:10:43 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Apr
 2026 23:10:36 -0500
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Apr
 2026 21:07:21 -0700
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <sima@ffwll.ch>,
 <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC V4 08/12] drm/amdgpu: implement SVM range notifier and GC helpers
Date: Wed, 29 Apr 2026 12:06:24 +0800
Message-ID: <20260429040628.853079-9-honglei1.huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|DS4PR12MB9586:EE_
X-MS-Office365-Filtering-Correlation-Id: c5c781bd-810f-463e-554e-08dea5a54820
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: Rl9kxZCVH2Qp4pFq+8zOyei9Az7qbH9yASnlDmnlRusaBo+/r/Taz6g7a1tdPBOlNKPVV6CKo/00N7xBCczPX6/eC6WV3FyHaLWTUN0dOSWisWUDAWXbi9WvX4SjoM08esL2SRMiyarElod/L+HsZwCCLYEUEdCH09sorLwHyRqX8pRL2l6l+WerdxKLgik2S15yTV3gxqRMSYtyuf1zns5pRIJqJdMV3LkJ3JB2pjQ3WevixDQz11/eNkzXN8RnB7iQfVSKwzfUH/Gvhqql/q8HQw8gsQJ6hn2YM8WMpZFrThn2yyz8X1qD2TJe7000OUeMg6gMqy3FAkCsU6Fvx/1a8wIZ+eGzDjFDjvwxCFjYX6yVt5gjeRlzw3YmY14ojZ7dWfNyhIaJSMPKfVeqpNQMC9DxOUWvT8KHAjmTXPL1YrkBJRQ7LZr/uQ5WJIfG0cuorvJqhEgQRsqsg3CttNJrM/aFyVqgVtDRKUVceeDY3uojqzvEO7w+q8a5tMh4A1C6TKgWkYZf7L8CpBtX42c4r1Bux3ZB1OJ97pXIqIofX86xRK4Q6eWxSpmz2kyJCU0qVmRAR7XHsAVWDpGz52rGkbsLhi0indJ4mkwVV7vXclZVnO9MqwGCz0gISusvXBm7IDykNnaWC5CJy+J3xFGLwnBn13Qk0syHTfjOMADhqEuedsK/oY6m8c4N5lfsjpQehlz12OiYTTgnMJ7lI2sKX+Omnf9EPq99JCTQDoV8LDN6SosA7pFjtQXQNAaBMewW+6S+BQG+i6uFTTuhnXxuaQK7eLq0VgPe5/lvU1LmVNu3SrbKXD7HVYuy92SY
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JTT0PUNN8PoIxAwc0dIdVBgdjdh0ETHgDhoe+5P7IW4v5M6NLRGKp8rkkT64f0r//GF8H/BPV+ADimutpElHhApl0Z1r4rK6pqv/wtThwWYZPujTUJMD5E+qX2lW/fJzfwxA3cWavzarya8eUGw7BEZ7o12Bf2eaiizy2Ef5jrj2cBOd0QDt2VKR4Y4FHXxbAs3vZgo65B0Yp7of/uUdzFzURdJz8RyeVV1iz/MxVjHwc3ClygQ8BKc6IUiOn9c0Z08ifZz2meYIu41N77L8kP16ZoXtSlQ/PWxylIFg/ZQXHDRGGHs0eQAV6aYlzw8Cotjwt8O/0u/5dJNjfQyZ6mbon+ZzQfnJEv15aRUap+4r/twSvkVxnWy553xVzyJ311YFtF3rF2TTh6UNqMMhsFO4AIEUSTz6b/rhRUpaEKgjzeDKZKC9e6HF7hQYCnfd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 04:10:43.0805 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5c781bd-810f-463e-554e-08dea5a54820
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9586
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

Add MMU notifier event handling (PTE zap, DMA unmap, GC queueing),
range removal, garbage collection helpers, and interval-based
invalidation dispatch for xnack-off rebuild.

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c | 177 ++++++++++++++++++
 1 file changed, 177 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
index d02a90b83..6c6552f31 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
@@ -487,3 +487,180 @@ amdgpu_svm_range_map_interval(struct amdgpu_svm *svm,
 	return 0;
 }
 
+void amdgpu_svm_range_remove(struct amdgpu_svm *svm,
+			     struct amdgpu_svm_range *range,
+			     struct drm_gpusvm_ctx *ctx)
+{
+	struct drm_gpusvm_range *base = &range->base;
+
+	lockdep_assert_held_write(&svm->svm_lock);
+
+	if (!base->pages.flags.unmapped && !base->pages.flags.partial_unmap)
+		drm_gpusvm_range_unmap_pages(&svm->gpusvm, base, ctx);
+
+	range_invalidate_gpu_mapping(range);
+	drm_gpusvm_range_remove(&svm->gpusvm, base);
+}
+
+static bool
+amdgpu_svm_range_notifier_event_begin(struct amdgpu_svm *svm,
+				      struct drm_gpusvm_range *range,
+				      const struct mmu_notifier_range *mmu_range)
+{
+	struct amdgpu_svm_range *svm_range = to_amdgpu_svm_range(range);
+
+	amdgpu_svm_assert_in_notifier(svm);
+
+	AMDGPU_SVM_RANGE_DEBUG(svm_range, "NOTIFIER");
+
+	if (range->pages.flags.unmapped || !svm_range->gpu_mapped)
+		return false;
+
+	AMDGPU_SVM_RANGE_DEBUG(svm_range, "NOTIFIER - EXECUTE");
+
+	amdgpu_svm_range_zap_ptes(svm, svm_range, mmu_range);
+	range_invalidate_gpu_mapping(svm_range);
+
+	return true;
+}
+
+static void
+amdgpu_svm_gc_enqueue(struct amdgpu_svm *svm,
+		      struct amdgpu_svm_range *range,
+		      unsigned long start_page, unsigned long last_page)
+{
+	if (atomic_read(&svm->exiting))
+		return;
+
+	spin_lock(&svm->work_lock);
+	if (!range->in_queue) {
+		drm_gpusvm_range_get(&range->base);
+		range->in_queue = true;
+	}
+
+	range->pending_start_page = min(range->pending_start_page, start_page);
+	range->pending_last_page = max(range->pending_last_page, last_page);
+	range->pending_ops |= AMDGPU_SVM_RANGE_OP_UNMAP;
+
+	if (!range->gc_queued) {
+		list_add_tail(&range->work_node, &svm->gc.list);
+		range->gc_queued = true;
+	}
+	spin_unlock(&svm->work_lock);
+
+	queue_work(svm->gc.wq, &svm->gc.work);
+}
+
+static void
+amdgpu_svm_gc_add_range(struct amdgpu_svm *svm,
+			struct amdgpu_svm_range *svm_range,
+			const struct mmu_notifier_range *mmu_range)
+{
+	unsigned long start_page = max(drm_gpusvm_range_start(&svm_range->base),
+				       mmu_range->start) >> PAGE_SHIFT;
+	unsigned long last_page = (min(drm_gpusvm_range_end(&svm_range->base),
+				       mmu_range->end) >> PAGE_SHIFT) - 1;
+
+	AMDGPU_SVM_RANGE_DEBUG(svm_range, "GARBAGE COLLECTOR ADD");
+
+	drm_gpusvm_range_set_unmapped(&svm_range->base, mmu_range);
+	amdgpu_svm_gc_enqueue(svm, svm_range, start_page, last_page);
+}
+
+static void
+amdgpu_svm_range_notifier_event_end(struct amdgpu_svm *svm,
+				    struct drm_gpusvm_range *range,
+				    const struct mmu_notifier_range *mmu_range)
+{
+	struct drm_gpusvm_ctx ctx = { .in_notifier = true, };
+
+	amdgpu_svm_assert_in_notifier(svm);
+
+	drm_gpusvm_range_unmap_pages(&svm->gpusvm, range, &ctx);
+	if (mmu_range->event == MMU_NOTIFY_UNMAP)
+		amdgpu_svm_gc_add_range(svm, to_amdgpu_svm_range(range),
+					mmu_range);
+}
+
+static int
+amdgpu_svm_range_invalidate_interval(struct amdgpu_svm *svm,
+				     unsigned long start_page,
+				     unsigned long last_page)
+{
+	unsigned long start = start_page << PAGE_SHIFT;
+	unsigned long end = (last_page + 1) << PAGE_SHIFT;
+	struct drm_gpusvm_notifier *notifier, *next_notifier;
+	struct drm_gpusvm_ctx ctx = { .in_notifier = false };
+	struct drm_exec exec;
+	struct dma_fence *fence = NULL;
+	bool needs_flush = false;
+	unsigned int flags;
+	int ret;
+
+	lockdep_assert_held_write(&svm->svm_lock);
+
+	ret = amdgpu_svm_range_lock_vm_pd(svm, &exec, true);
+	if (ret)
+		return ret;
+
+	drm_gpusvm_for_each_notifier_safe(notifier, next_notifier, &svm->gpusvm,
+					  start, end) {
+		struct drm_gpusvm_range *range, *next_range;
+
+		drm_gpusvm_for_each_range_safe(range, next_range, notifier,
+					       start, end) {
+			struct amdgpu_svm_range *svm_range = to_amdgpu_svm_range(range);
+			unsigned long range_start = drm_gpusvm_range_start(range);
+			unsigned long range_end = drm_gpusvm_range_end(range);
+			unsigned long rs = range_start >> PAGE_SHIFT;
+			unsigned long rl = (range_end >> PAGE_SHIFT) - 1;
+			bool crosses_boundary = start > range_start || end < range_end;
+
+			if (svm_range->gpu_mapped) {
+				AMDGPU_SVM_RANGE_DEBUG(svm_range, crosses_boundary ? "ATTR DESTROY" :
+										"ATTR ZAP PTE");
+
+				flags = memalloc_noreclaim_save();
+				ret = amdgpu_vm_update_range(svm->adev, svm->vm, false, true, true,
+									false, NULL, rs, rl, 0, 0, 0, NULL, NULL, &fence);
+				memalloc_noreclaim_restore(flags);
+
+				if (!ret && fence) {
+					dma_fence_wait(fence, false);
+					dma_fence_put(fence);
+					fence = NULL;
+				}
+
+				if (ret) {
+					AMDGPU_SVM_TRACE(
+						"attr invalidate PTE clear failed: ret=%d [0x%lx-0x%lx]\n",
+						ret, rs, rl);
+					drm_exec_fini(&exec);
+					return ret;
+				}
+				needs_flush = true;
+			}
+
+			if (crosses_boundary) {
+				/* remove the ranges crosses boundary to let GPU fault create new ranges
+				 * bounded by the updated attr_range boundaries.
+				 */
+				amdgpu_svm_range_remove(svm, svm_range, &ctx);
+			} else {
+				range_invalidate_gpu_mapping(svm_range);
+			}
+		}
+	}
+
+	drm_exec_fini(&exec);
+
+	if (needs_flush)
+		svm->flush_tlb(svm);
+
+	AMDGPU_SVM_TRACE("attr invalidate done [0x%lx-0x%lx]-0x%lx needs_flush=%d\n",
+			 start_page, last_page, last_page - start_page + 1,
+			 needs_flush ? 1 : 0);
+
+	return 0;
+}
+
-- 
2.34.1

