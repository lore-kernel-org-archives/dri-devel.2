Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 087E8CD342F
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 07:52:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52EDE10F3AE;
	Fri,  8 May 2026 07:52:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S0v0QpgJ";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012054.outbound.protection.outlook.com
 [40.93.195.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBB6A10F3AB;
 Fri,  8 May 2026 07:52:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sHwTnv3ut2/9/pG0CJe9CJdtI/9Uk3hMYodUIhjxMbD2BbRHuPHUpg2no+phjA8UkK4Ovf08Ew8e7Cyvp4fU6wUFfT5D40re1FW7W453tVFHVRaC69EX4FQ7qyK1BuC2js3Mc4tFgn8w1nWXiW+Z8O5nDgcIqGLQWBCcM9k6BYF4LzjXHjrBrNr/13hIMJ8FFV20Y9k8gHvRGUTcjMoNz5wAdpOKJdc8TOZsc07SEXAOmw95ek9Mt/a6IvDqsK9hpLAUJz44GsQ4TxfADOi3p6niPm3HR6sjVjm3svRxCtWsjWgXj+h0Jyour8E2k530nSoc5coNf1qVpIII769k5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8bKSiQ9l3+mZOkGyvHzvNOSGdKDPIAY2PGt7C/ACqzg=;
 b=epx/Iz1z0R0cfeMJ35neeM94t02lmY3o5qyau3uphnlSAedkATH+qxvAgd9ridh0dmXqc9Y3wl5sEcExMy57dEAYIw1OM+XfBbDX5V0CbR9oFejtUKfhASuWOID0fekPsWAQ5491p45lyEIRMBvenGv8DpTkDiwy2z/IPwCVujqkXZpY95y1jsauJE24700HFIkAGhLAmCsRP6k4svcBhxqDEXYpGhbyxr3cJ63Er0XlJ2cRahJ9Cw5RkWsrR6W37qW+ysCfLN9glnUX0kfc97ipR4WPiW0vHl2UBxv2omjH2K2TSWE4Be+s6UN3K5AujDZTCkEBNZ4VgfaRGgWfYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8bKSiQ9l3+mZOkGyvHzvNOSGdKDPIAY2PGt7C/ACqzg=;
 b=S0v0QpgJeMf5UDUiK3kKPEwJAXaA0jGueilnL6zbDFFayleSHRLPOyoZojUHutV6MyJXDwqi71FNk+t4ZPnm37OBNOfEwBYMs+mBNwT+XkruvGY+JOX10gRl4ufC5Mmg9fl/czp+tiEXsbBb6sCgC3TN5/Jt/BfT7Ht3uaakDgk=
Received: from MN2PR13CA0035.namprd13.prod.outlook.com (2603:10b6:208:160::48)
 by IA0PR12MB7697.namprd12.prod.outlook.com (2603:10b6:208:433::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.18; Fri, 8 May
 2026 07:52:24 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:208:160:cafe::53) by MN2PR13CA0035.outlook.office365.com
 (2603:10b6:208:160::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.11 via Frontend Transport; Fri, 8
 May 2026 07:52:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 8 May 2026 07:52:24 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 8 May
 2026 02:52:19 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>,
 <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC V5 08/12] drm/amdgpu: implement SVM range notifier and GC helpers
Date: Fri, 8 May 2026 15:51:25 +0800
Message-ID: <20260508075129.1161157-9-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260508075129.1161157-1-honglei1.huang@amd.com>
References: <20260508075129.1161157-1-honglei1.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|IA0PR12MB7697:EE_
X-MS-Office365-Filtering-Correlation-Id: f05e98b0-8679-4304-95e6-08deacd6bdf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: aGowyCmYMKHRzRLnXsUC/TOmCkZ/3S5Lap9OHO6jxq4+QUTXIypOHFnvM1Mx4gaxcUOTK4edE+FCz5rhuxI8x+W0ZgWtME4kU+QUxublPd1nijXP8roUNumtGl0MKvsDs30b2qj5ALQywHZYWkvqcO56O74u4YUpyoXyQ30t70px9PYmGE3PeR1gL9Qi0zUMl2mZNl3U+ISdLCwo9P56ErmE8RayGLH8iVD9nWFvehXeIL3oGSlhPJojsjlz2aCwnY99/Smj2ns6tNouyquPG9MpJZMKokLEZYcC75dkJdUsD96qNhF6H5djyHmhgoDGcvZKXT2dX0M0uTndaEhubgyKdIWHh0+VeRmziuuL2fYTWTeOLCEklpu+kS739fJeyxvommyOyuMQwHbXXJMHk9QaVG0mG/j3/5Stxkso2zyoYCBtZQHBRsgg5Fhu5C9JRIMqm3ovYmat+H+nkzwYr2XZPIwdWYsemJ4DhsDnbw6quig1OYrJZ3p7Rc/bHbn4CHSxb3+eCt3eZ002XOPGBLXzciVFIssSIzBJZI45OcMlwP3dFfX/0TSa1p9I/Q5w+kNgEwPSLHVSUrSfY+n65+5NUIvt1oRg2FUGxT7eGCLppRhaaxhX3LmlRQaSy+NJPsdN6ztcbF6H9DeQ6nnDymIQXiSHxjfzA+wIXId5x8r3WOTwJlPmD4HYDzU/EFmPiXUiMj5iw4B27xO2ZScPMwwwyieQuh1/alvCfq3lElCD23wcy2fem18tM/rYffjJS/jHQNqPqupsumg+sIhgEA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(921020)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RRDX5lRat1xrVBIS2jKuF69Br+fcBfZOQcy3vOOxK/hdCEwtgie/TDGAEU/jyRy81l8D8XvwkTB4xhbDUKVAnkdFLcZDrxQulLYL6WHPM/ussfSDdphVy2BUMRPOHuSN3brZofnwwRaka91euiHqSPpwewTHPnLLa2f1iPCuPTlEzTRNb6nZjysVdM5CAI8RABtr807Rwh7p6XHFMGADa3uSsvXagqsuclwQ87wo/amt5y7OOL4wSFhWhhX9kE9o5G/tD3tzJsteol2PU9U5KNOlm+b77ZdTG5BWaxSWAzI2WDmmpizBegKkzPpiUqzbYLowBXAJUugIg3YIL8U/sySY8hZRgTvMHT5jXK9wW2PRJVxWsyrYWuoxRbL5Wo3OJ6EF53DIN29vVPinLxyaQiTCeLO7UqOYwB73h6nCG1RqwL/GuYb1YvnP0n4buq2h
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 07:52:24.2542 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f05e98b0-8679-4304-95e6-08deacd6bdf2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7697
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
- amdgpu_svm_range_notifier_event_begin: zap PTEs on notifier events
- amdgpu_svm_gc_enqueue: queue range for deferred removal with
  pending page bounds tracking
- amdgpu_svm_gc_add_range: mark range unmapped and enqueue for GC
- amdgpu_svm_range_notifier_event_end: DMA unmap and GC on MMU_UNMAP
- amdgpu_svm_range_invalidate_interval: cursor-based PTE clearing
  across notifiers/ranges with boundary-crossing range removal
- amdgpu_svm_range_dequeue_locked: dequeue work item with atomic
  pending state transfer
- range_try_dequeue: conditional dequeue for reference release
- amdgpu_svm_range_put_if_dequeued: release range ref after dequeue

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c | 228 ++++++++++++++++++
 1 file changed, 228 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
index c733d611d..49240c704 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
@@ -486,3 +486,231 @@ amdgpu_svm_range_map_interval(struct amdgpu_svm *svm,
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
+	struct dma_fence *fence = NULL;
+	bool needs_flush = false;
+	unsigned int flags;
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
+static bool
+range_try_dequeue(struct amdgpu_svm_range *range)
+{
+	if (!range->in_queue)
+		return false;
+
+	if (range->pending_ops != AMDGPU_SVM_RANGE_OP_NONE)
+		return false;
+
+	range->in_queue = false;
+	return true;
+}
+
+void
+amdgpu_svm_range_put_if_dequeued(struct amdgpu_svm *svm,
+				     struct amdgpu_svm_range *range)
+{
+	bool dequeue;
+
+	spin_lock(&svm->work_lock);
+	dequeue = range_try_dequeue(range);
+	spin_unlock(&svm->work_lock);
+
+	if (dequeue)
+		drm_gpusvm_range_put(&range->base);
+}
-- 
2.34.1

