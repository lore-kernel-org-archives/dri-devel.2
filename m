Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB18CD6E49
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 05:49:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9BCB10F8F4;
	Fri, 29 May 2026 05:49:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nOpaU9dl";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012061.outbound.protection.outlook.com [40.107.209.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D28D710F8EA;
 Fri, 29 May 2026 05:49:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gzk81UCIA2EWdFQELDk/tpFInhXGDeZjcLgbxI30i5mZluWv11urTS2q7FogBSXPO4zcicNR0aVUzP36wmdG8GkQnncuuB32rCkFZBbrGzTtwEKvSSjwckbI5x7WYxxzFF4MX4b4faO56DTgzhlDy+Bq9gQ+8xWnOH717ym11VRWokHe444I8wKOrMgajWrhTyV/ej+FVSMwyGNM7HmZUaGe68fiZ6wYhrTK8M20cB3re59TaOIKBBHSm848XYPj/vUpRvOotZnDDzdNM9vKWXgQSNdnmJFM17bsfvBFKqsj8Z/QRlq8j5lvdBFevnl0EpBGj1NEpFZx4gsPEWKA9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6xmkviCeHLHWwuXW92QtrcXKKarn6MWg0cF/tymhv84=;
 b=ETIxilLyxw8XZ+43JI0+x1om64Fyp2IGF+bG+Y9THKGgUFpNWyaYxJ2dAysWp7T+QHp9lrBXbwypGHgrwR4d34ovp5r9FWHbm2wLdPMgRHsWlTNEi8NJqD8tEbDMgkiyRI5JuyaqsSH4aOn2NEKrOHmA8DzHGTqEgX8Fk/xct0RKyDMJSpX3n3goGGYGpGXYBuGDQyFveuZy1vjBWkbHWWIT8tgjIYRnvLpgoMpkSfvITiA8vuX6JqSmDBk1F+bESz4nQr67NCLt5CnIhYI8AyOHYTfbM4ZX+Zufko76vHFLjJ/RTjSg7T2rCjl7pnVdBcvKIueCU3wTRuUOzcIyCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6xmkviCeHLHWwuXW92QtrcXKKarn6MWg0cF/tymhv84=;
 b=nOpaU9dlnTIB9AdnixQqUhGqL7ix5W6rIC9CKFjKKES7yHpxGFMEiCK1UjFUE98iD2JEhMqFDS8/04ypEpY7QsqydaKq926L1tn7LaLGBDJ/XlpuPgs1ua9S3/QBP0L2Wa7xnRJM++1VX2875IlJ7FwvcNpQ8vhbYDPA4HoMT0A=
Received: from CH0P221CA0028.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::10)
 by SN7PR12MB6840.namprd12.prod.outlook.com (2603:10b6:806:264::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Fri, 29 May
 2026 05:48:59 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:610:11d:cafe::80) by CH0P221CA0028.outlook.office365.com
 (2603:10b6:610:11d::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Fri, 29
 May 2026 05:48:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 29 May 2026 05:48:59 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 29 May
 2026 00:48:54 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>,
 <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC V7 08/12] drm/amdgpu: implement SVM range notifier and GC helpers
Date: Fri, 29 May 2026 13:48:00 +0800
Message-ID: <20260529054804.596214-9-honglei1.huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|SN7PR12MB6840:EE_
X-MS-Office365-Filtering-Correlation-Id: 69f6a190-e855-4194-aa6e-08debd45fac6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|56012099006|11063799006|22082099003|6133799003|18002099003|3023799007|921020;
X-Microsoft-Antispam-Message-Info: s2zP6zlK+ZLTdkcpDH7DXLwbdoYWknw6JgFv552H8lTef8Y51as2yeZ2PL6WguMBiqEhEOJz3qCikZxga9bDClGdIzl61yZ4nkTBmuXyvui/tPzQKdHjZgvcHaykv/1M8DNFp3JNbg5Wm5jRy13Di8dJCOZrVZNVeHLTp4rGMO2iZUWRiARFBC8DjkRBOkngaZEgQCb7G2sY2Xx4VZupJNytcB6wpnfDLQhuJ3VN/oWwmvhDJFVqLnLshTU6QAYHjQud0kSvp2BWWVfTnmcI7v/gKfQpdtgq0tF2/PffeyRsY4jWIsUg4KiqVCCoJsUprQ+TmZ9X8vvIQj4so27eHFu/BlZljG+t5OC5qaMFrQiuGi/bhC/xaRRGJHTkZVzVYzlLSWWBb1OUowB10waJ8De4ovK/2c4U7U9zgq0bwip3Q0g6mXrV4v6Fhcn8QAXLkFNPMRsJnrV/kbBkNpcSxEfDVtSgiEMmtV2PpVqP1yDmveKRR14LRGWwuhuQHDx6gD5ewzQAMNDDFOlmOrM+gfR4cENLQzyyVNYNThwYH3HOT1IDB2EBY49eoSob95w/tM3NVTA18YZsQbjl/ijJ7JcvO0AHCkwoCbzeLzHcd3wyVLdCFvFTWoSWn0sYUJ0eusPCRTFlliRNSvYSln6f6wmqkYsmbAZfku4lQxdVDLM4RYGflrBKkzf9dCFRXFG7V+Hy+Hrkd11NtdTWlrxszKd6Av5VpvESNZxBzkVK3gCF31cO8RnABoi/uo0ZjW9ymitoamGKoM8zdNe+8D/J9A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(56012099006)(11063799006)(22082099003)(6133799003)(18002099003)(3023799007)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pYdWO7xWcGrJyl9CatcbOiFZo4Dw5alySebkQ6y7jxmW9Svkl/H1w0PYMrYwf+vsim4RryX4LdBhC9bOkBriq71RmmW/SC5wYWzL8jtlKv3pxHSZjwoiDi8/QEClh5Lao9sygHAIil7Z+sX12ju7nJhw3aDfrsql4Cn2g2o6yHsrgXaN0ebNdWcmegArbvPs1sN4QmOIKOCInbx9BVEqm5SWJ9UKKqUKRzKNZ31mSC+48oYelcwb1z0isRhRjH3iLBd6bhgTxzWpK2eGnnDMqiErvYVBHj+y5xHLiKLjJtNhMxo5Jz4Y9CY9OK9W/T+bgtOvacqohTgqoeL96UzcEzqYYY734UChcltiz1s12r/tK3s/0elX8okEsoOeDIBFiQf++7Cvx0V1EF8VsxuZjPYQRQV1ld/pED4HDPFwLnqmhacrHD21t2iVO84kGA06
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 05:48:59.0361 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69f6a190-e855-4194-aa6e-08debd45fac6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6840
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

Add MMU notifier event handling and garbage collection infrastructure:
- amdgpu_svm_range_remove: unmap pages and remove from gpusvm
- amdgpu_svm_range_notifier_event_begin: compute the [start_page,
  last_page] window from the notifier range and the gpusvm range,
  then zap PTEs via amdgpu_svm_range_zap_ptes and invalidate the
  GPU mapping
- amdgpu_svm_gc_enqueue: queue range for deferred removal with
  pending page bounds tracking and queue_state management
- amdgpu_svm_gc_add_range: mark range unmapped and enqueue for GC
- amdgpu_svm_range_notifier_event_end: DMA unmap and GC on MMU_UNMAP
- amdgpu_svm_range_invalidate_interval: cursor-based PTE clearing
  across notifiers/ranges; clears PTEs through
  amdgpu_svm_range_zap_ptes (which encapsulates the
  amdgpu_vm_update_range + fence wait dance), and on the
  crosses_boundary path evicts devmem-backed pages back to sysmem
  via amdgpu_svm_range_evict before removing the range, so VRAM
  data is preserved when the range is destroyed
- amdgpu_svm_range_dequeue_locked: dequeue work item with atomic
  pending state transfer
- amdgpu_svm_range_put_if_dequeued: release range ref after dequeue,
  re-dispatch if new work was enqueued during processing

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c | 235 ++++++++++++++++++
 1 file changed, 235 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
index 61ef92c45..17c0a9941 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
@@ -488,3 +488,238 @@ amdgpu_svm_range_map_attrs(struct amdgpu_svm *svm,
 	return 0;
 }
 
+void amdgpu_svm_range_remove(struct amdgpu_svm *svm,
+			     struct amdgpu_svm_range *range,
+			     struct drm_gpusvm_ctx *ctx)
+{
+	struct drm_gpusvm_range *base = &range->base;
+
+	amdgpu_svm_assert_locked(svm);
+
+	if (!base->pages.flags.unmapped && !base->pages.flags.partial_unmap)
+		drm_gpusvm_range_unmap_pages(&svm->gpusvm, base, ctx);
+
+	amdgpu_svm_range_invalidate_gpu_mapping(range);
+	drm_gpusvm_range_remove(&svm->gpusvm, base);
+}
+
+bool
+amdgpu_svm_range_notifier_event_begin(struct amdgpu_svm *svm,
+				      struct drm_gpusvm_range *range,
+				      const struct mmu_notifier_range *mmu_range)
+{
+	struct amdgpu_svm_range *svm_range = to_amdgpu_svm_range(range);
+	unsigned long start_page, last_page;
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
+	start_page = max(drm_gpusvm_range_start(range),
+			 mmu_range->start) >> PAGE_SHIFT;
+	last_page = (min(drm_gpusvm_range_end(range),
+			 mmu_range->end) >> PAGE_SHIFT) - 1;
+
+	amdgpu_svm_range_zap_ptes(svm, svm_range, start_page, last_page);
+	amdgpu_svm_range_invalidate_gpu_mapping(svm_range);
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
+	if (range->queue_state == AMDGPU_SVM_RANGE_NOT_QUEUED) {
+		drm_gpusvm_range_get(&range->base);
+		range->queue_state = AMDGPU_SVM_RANGE_IN_GC;
+	}
+
+	range->pending_start_page = min(range->pending_start_page, start_page);
+	range->pending_last_page = max(range->pending_last_page, last_page);
+	if (range->pending_ops == AMDGPU_SVM_RANGE_OP_NONE)
+		list_add_tail(&range->work_node, &svm->gc.list);
+	range->pending_ops |= AMDGPU_SVM_RANGE_OP_UNMAP;
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
+int
+amdgpu_svm_range_invalidate_interval(struct amdgpu_svm *svm,
+				     unsigned long start_page,
+				     unsigned long last_page)
+{
+	unsigned long start = start_page << PAGE_SHIFT;
+	unsigned long end = (last_page + 1) << PAGE_SHIFT;
+	struct drm_gpusvm_notifier *notifier, *next_notifier;
+	struct drm_gpusvm_ctx ctx = { .in_notifier = false };
+	struct drm_exec exec;
+	bool needs_flush = false;
+	int ret;
+
+	amdgpu_svm_assert_locked(svm);
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
+			bool crosses_boundary;
+
+			crosses_boundary = start > range_start || end < range_end;
+
+			if (svm_range->gpu_mapped) {
+				AMDGPU_SVM_RANGE_DEBUG(svm_range,
+					crosses_boundary ? "ATTR DESTROY" :
+							   "ATTR ZAP PTE");
+
+				ret = amdgpu_svm_range_zap_ptes(svm, svm_range, rs, rl);
+				if (ret < 0) {
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
+				/* remove ranges crossing the boundary so GPU fault
+				 * creates new ranges bounded by the updated
+				 * attr_range boundaries.
+				 * Evict devmem-backed pages back to sysmem first
+				 * so VRAM-resident data is not lost when the range
+				 * is destroyed. No-op for sysmem-only ranges.
+				 */
+				amdgpu_svm_range_evict(svm, range);
+				amdgpu_svm_range_remove(svm, svm_range, &ctx);
+			} else {
+				amdgpu_svm_range_invalidate_gpu_mapping(svm_range);
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
+bool
+amdgpu_svm_range_dequeue_locked(struct amdgpu_svm *svm,
+					struct list_head *work_list,
+					struct amdgpu_svm_range_op_ctx *op_ctx)
+{
+	struct amdgpu_svm_range *range;
+
+	lockdep_assert_held(&svm->work_lock);
+
+	range = list_first_entry_or_null(work_list, struct amdgpu_svm_range,
+					work_node);
+	if (!range)
+		return false;
+
+	list_del_init(&range->work_node);
+	range->queue_state = AMDGPU_SVM_RANGE_PROCESSING;
+
+	op_ctx->range = range;
+	op_ctx->start_page = range->pending_start_page;
+	op_ctx->last_page = range->pending_last_page;
+	op_ctx->pending_ops = range->pending_ops;
+
+	range->pending_start_page = ULONG_MAX;
+	range->pending_last_page = 0;
+	range->pending_ops = AMDGPU_SVM_RANGE_OP_NONE;
+
+	return true;
+}
+
+void
+amdgpu_svm_range_put_if_dequeued(struct amdgpu_svm *svm,
+				     struct amdgpu_svm_range *range)
+{
+	bool release_kref = false;
+	bool queue_gc = false;
+
+	spin_lock(&svm->work_lock);
+
+	if (range->queue_state != AMDGPU_SVM_RANGE_PROCESSING) {
+		spin_unlock(&svm->work_lock);
+		return;
+	}
+
+	if (UNMAP_WORK(range->pending_ops)) {
+		list_add_tail(&range->work_node, &svm->gc.list);
+		range->queue_state = AMDGPU_SVM_RANGE_IN_GC;
+		queue_gc = true;
+	} else {
+		range->queue_state = AMDGPU_SVM_RANGE_NOT_QUEUED;
+		release_kref = true;
+	}
+
+	spin_unlock(&svm->work_lock);
+
+	if (queue_gc)
+		queue_work(svm->gc.wq, &svm->gc.work);
+	if (release_kref)
+		drm_gpusvm_range_put(&range->base);
+}
-- 
2.34.1

