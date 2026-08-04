Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D29DC5518F
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 09:43:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C09C10E962;
	Tue,  4 Aug 2026 09:43:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TLajVC0r";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011041.outbound.protection.outlook.com [40.107.208.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 098FB10E962;
 Tue,  4 Aug 2026 09:43:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ucEVPgXyHQQ8UNqzFeLUqmw0sAdjMyythhVxCXh9rF/AT4KjnY4cy6ONJqUdtHVfVwhdSXEkLLhdczjqvtNeKYPZr3UotXbc/dS7qcgICRnhS10Hc7v7EPNW86A+rVssOn0Z19Ph3BNTpU6x3p5zxxBMepRk8dne1KD59FkVKgPepWHOhHA4s0GBd2g1a5hzq/SqP8EhyPNCmOwMxj2vgYG+qEBRAMhsyiBfG3NxS/wgZZykWC0GCM5iGRMOPGDp/A+OpmskRreT0punOMIefwxrl0p0R39vYBx5+cUB6QtYp7t7cTibw1K4RTx7tB8U5/S+WLL7fRn5mFNkAgpxfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WfcPNlgUK29uAG/6xgSc2crBQniyRnsJwEuxEpMYyPM=;
 b=XmgXOkt3b09bRfAg1+3Z4KwXB2R2JkjFP/unXFUSwIxtkgt0E84wy2hEyl/4xoHnqxlpI9vBU/zudqVcJQT7sriQp+9mpuFlhy489YglaJgM3opHOIa69BUVn+XaUy2Mlvjfxa0EAOwH/LKr8iBbagq3UvhxIeKl1p2+0VYhu6XCvjPIfmXKqWCxRO53N8qywoRuENc4nIsAKcTC/Pb+AMAIeqQ/2e2kuffI+TaOt2Xk+xliUnSWpXa8nVBo9t53tWXLiK9uFAFyD9Z6Gu2R1wX6iZwp+nWkcJfEJkl6FF6YFXhD3q2GHfF1ReIzjfMS7pwe0aQhPnM63xFucL96dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WfcPNlgUK29uAG/6xgSc2crBQniyRnsJwEuxEpMYyPM=;
 b=TLajVC0r4ATfjRUfLnWOF+nx64Bndt/oizKR3ialoCv0zOia3tra13lXOd6nb1CmJWln6j3MbBjoHVGgnwehiu3s6HJIGc/edMgJKHcIL9xI2zbaHzaEgktbYbl4oj0sL5OLHpCGjaQJ6+D4xPjN2mRgzFusH7fLKN8ERGbgiCs=
Received: from PH0PR07CA0025.namprd07.prod.outlook.com (2603:10b6:510:5::30)
 by CH3PR12MB8283.namprd12.prod.outlook.com (2603:10b6:610:12a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.16; Tue, 4 Aug
 2026 09:43:42 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:510:5:cafe::a7) by PH0PR07CA0025.outlook.office365.com
 (2603:10b6:510:5::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.17 via Frontend Transport; Tue, 4
 Aug 2026 09:43:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 09:43:41 +0000
Received: from hr-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 4 Aug
 2026 04:43:36 -0500
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
Subject: [PATCH v9 08/18] drm/amdgpu: implement SVM range notifier and GC
 helpers
Date: Tue, 4 Aug 2026 17:42:34 +0800
Message-ID: <20260804094246.1719318-9-ray.huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|CH3PR12MB8283:EE_
X-MS-Office365-Filtering-Correlation-Id: c5d9da2c-c97b-4083-ea73-08def20cde69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|10067099003|921020|11063799006|56012099006|18002099003|22082099003|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info: x5/7cDoNkSerCwIbK2Z9B56/5+kAr7iamWllsJSXFrtpPxvZGI3rwnNoQhnjTJ0ziYEdKZeN7yRAFqpBJ09RCo4/Z+XN3fOmforoBnHRlht0QMP6OFxYNLf5kxqJ2EG6maZ8e5SxXsmNTXD/KYFD0EAJKGxX+9wvKeB/3CmWycx8vbT+wrwZQjWeOqCULgGGKA0YV+9XGJ96nzBSD31IlsT1TpUCi08rIsoxRoZ3MtTFIhU05DesRdur4aKh+erbG8BMcAZ4HErN3StWLIO2rB7ZHqQ0+Ix/87jywoENErmt3oa66HumTYkSbMgMqlUNFXz3I18Xw292aTSr+GpVEslHyUC8+S7Y0CIjq7UhSECEfO48W08WF910RLxrFcLhEYpfV0zhWZDeBJvNBpJ5leSMWVW5quAd7ATNmAM4sfXrpPlvx4rFxclq2dTZidZhnZF0NdnCI7pwzH5PCzC37EnY088pFrrBa8vau36dtd3yTO+YGZDZGkQBzkr7ErUH2Esv683L3bC5SB2NMgItBWKKaEQ+JMydRQBs9zDoVo9zi+ldPj/bx8HJCyJRRq5Zbn/S8a3xniOn5FdiDPz/R22vjXQCBcHvw3thAtDj8yohG93x68flNBHGQGmAgIyFj8G+rFYneHBDx53xouW1AxsQKCXBk3vhaOuJfRq663wopROwxwdw9twOVHIzSzkyQTzGShDj0x4ESNQ6GSadjUmQLoKMGjiNu5rx15fAcFeUCXyWvTMMctTx30+eIfD8
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(10067099003)(921020)(11063799006)(56012099006)(18002099003)(22082099003)(3023799007)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4EgXpj6Ww02GHUfNIT7/hhDweuSdjIKvjFBxETPL9YygttZp2GuY7zqDP40wTMunzrAmyV7sMzX2MGzeuiouBtqydEi7spdnR2kpNyPu8dGqfF1FNYGsosCnVELRnoGlY6crA4DRTDQdrAFMO6wqpL5Nuw3vu/QxsCYwKTxiiF2ImhdkgC03ZDf/LndjLNZ9WPcHxGmBb17aagjqWmxak4D0QVbvMOre9hHVymDvj/4nd9k5vgencyPOLaLkK58JrX/vS0LoXdGN6NboXh/OC6SHL+70u5vbkUCjVFXFlWSAxoSDpvKiStXzcgVDDaSNewdJqPwXbl0vqvSJBWPnTMyQDV5U4Emm2q5v5tuEsRW9p9o0GqdHUOoLnklFo6Odwf4Sfsrilv3JNQMyWLMWaZ2x9KN8RGODCBbNnjbm59H+54KThFLK+4EzWsMkXk4V
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 09:43:41.7552 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5d9da2c-c97b-4083-ea73-08def20cde69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8283
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
- amdgpu_svm_gc_enqueue: queue range for GC worker and set queue state
- amdgpu_svm_gc_add_range: mark range unmapped and enqueue for GC
- amdgpu_svm_range_notifier_event_end: DMA unmap and GC on MMU_UNMAP
- amdgpu_svm_range_invalidate_interval: cursor based PTE clearing
  across notifiers/ranges; clears PTEs through
  amdgpu_svm_range_zap_ptes
- amdgpu_svm_range_dequeue_locked: dequeue work item with atomic
  pending state transfer
- amdgpu_svm_range_put_if_dequeued: release range ref after dequeue,
  re-dispatch if new work was enqueued during processing
- amdgpu_svm_range_unqueue: locked context helper that pulls a range
  off the GC list

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c | 311 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h |  16 +
 2 files changed, 327 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
index 335fe5a551f0f..9e348390795a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
@@ -417,3 +417,314 @@ amdgpu_svm_range_map_attrs(struct amdgpu_svm *svm,
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
+/**
+ * amdgpu_svm_range_notifier_event_begin() - First MMU notifier phase
+ * @svm: The SVM context.
+ * @range: The GPU SVM range covered by the notifier event.
+ * @mmu_range: The MMU notifier range describing the invalidation window.
+ *
+ * Invalidate the GPU view of @range over the notifier window: zap the
+ * affected PTEs and clear the gpu_mapped flag. The range is not removed
+ * here; structural removal if needed happens in the event-end phase.
+ *
+ * Return: true if PTEs were zapped, false otherwise.
+ */
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
+	AMDGPU_SVM_RANGE_TRACE(svm_range, "NOTIFIER");
+
+	if (range->pages.flags.unmapped || !svm_range->gpu_mapped)
+		return false;
+
+	AMDGPU_SVM_RANGE_TRACE(svm_range, "NOTIFIER - EXECUTE");
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
+/**
+ * amdgpu_svm_gc_enqueue() - Queue a range for work queue processing
+ * @svm: The SVM context.
+ * @range: The SVM range to queue.
+ * @start_page: First page of the pending invalidation interval.
+ * @last_page: Last page of the pending invalidation interval.
+ *
+ * Queue @range on the GC list and kick the GC worker. A range reference
+ * is taken when it first enters IN_GC and dropped only when it returns
+ * to NOT_QUEUED, so the range stays alive while on the GC list or being
+ * processed. All transitions are serialized by svm->work_lock.
+ */
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
+	AMDGPU_SVM_RANGE_TRACE(svm_range, "GARBAGE COLLECTOR ADD");
+
+	drm_gpusvm_range_set_unmapped(&svm_range->base, mmu_range);
+	amdgpu_svm_gc_enqueue(svm, svm_range, start_page, last_page);
+}
+
+/**
+ * amdgpu_svm_range_notifier_event_end() - Second MMU notifier phase
+ * @svm: The SVM context.
+ * @range: The GPU SVM range covered by the notifier event.
+ * @mmu_range: The MMU notifier range describing the event.
+ *
+ * DMA-unmap the pages for @range. On an actual unmap event, also queue the
+ * range to the GC so it gets structurally removed from the gpusvm trees.
+ */
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
+			bool crosses_boundary = start > drm_gpusvm_range_start(range) ||
+						end < drm_gpusvm_range_end(range);
+
+			if (svm_range->gpu_mapped) {
+				AMDGPU_SVM_RANGE_TRACE(svm_range,
+					crosses_boundary ? "ATTR DESTROY" :
+							   "ATTR ZAP PTE");
+
+				ret = amdgpu_svm_range_zap_ptes(svm, svm_range,
+						drm_gpusvm_range_start(range) >> PAGE_SHIFT,
+						(drm_gpusvm_range_end(range) >> PAGE_SHIFT) - 1);
+				if (ret < 0) {
+					drm_exec_fini(&exec);
+					return ret;
+				}
+
+				amdgpu_svm_range_invalidate_gpu_mapping(svm_range);
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
+				drm_gpusvm_range_get(range);
+
+				amdgpu_svm_range_evict(svm, range);
+				amdgpu_svm_range_remove(svm, svm_range, &ctx);
+
+				amdgpu_svm_range_unqueue(svm, svm_range);
+
+				drm_gpusvm_range_put(range);
+			}
+		}
+	}
+
+	drm_exec_fini(&exec);
+
+	if (needs_flush)
+		amdgpu_svm_flush_tlb(svm);
+
+	AMDGPU_SVM_DBG("attr invalidate done [0x%lx-0x%lx]-0x%lx needs_flush=%d\n",
+			 start_page, last_page, last_page - start_page + 1,
+			 needs_flush ? 1 : 0);
+
+	return 0;
+}
+
+/**
+ * amdgpu_svm_range_dequeue_locked() - Pull the next range off a work list
+ * @svm: The SVM context.
+ * @work_list: The work list to dequeue from.
+ * @op_ctx: Output context filled with the dequeued range's pending state.
+ *
+ * Move the first range on @work_list to PROCESSING and atomically snapshot
+ * its pending op/interval into @op_ctx while resetting them on the range, so
+ * invalidations that arrive during processing accumulate afresh. Caller must
+ * hold svm->work_lock.
+ *
+ * Return: true if a range was dequeued, false if @work_list was empty.
+ */
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
+/**
+ * amdgpu_svm_range_put_if_dequeued() - Finish processing a dequeued range
+ * @svm: The SVM context.
+ * @range: The range previously moved to PROCESSING.
+ *
+ * Called after a PROCESSING range has been handled. If new UNMAP work was
+ * enqueued while it was being processed, re-queue it on the GC list and kick
+ * the worker again; otherwise return it to NOT_QUEUED and drop the reference
+ * taken at enqueue time.
+ */
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
+	if (range->pending_ops & AMDGPU_SVM_RANGE_OP_UNMAP) {
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
+
+void amdgpu_svm_range_unqueue(struct amdgpu_svm *svm,
+					struct amdgpu_svm_range *range)
+{
+	bool put = false;
+
+	amdgpu_svm_assert_locked(svm);
+
+	spin_lock(&svm->work_lock);
+	if (range->queue_state == AMDGPU_SVM_RANGE_IN_GC) {
+		list_del_init(&range->work_node);
+		range->queue_state = AMDGPU_SVM_RANGE_NOT_QUEUED;
+		range->pending_ops = AMDGPU_SVM_RANGE_OP_NONE;
+		put = true;
+	}
+	spin_unlock(&svm->work_lock);
+
+	if (put)
+		drm_gpusvm_range_put(&range->base);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
index e5a5f52166576..f423be277a85a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
@@ -149,6 +149,16 @@ int amdgpu_svm_range_update_mapping(struct amdgpu_svm *svm,
 				    bool read_only,
 				    bool intr, bool wait,
 				    bool flush_tlb);
+bool amdgpu_svm_range_dequeue_locked(struct amdgpu_svm *svm,
+				     struct list_head *work_list,
+				     struct amdgpu_svm_range_op_ctx *op_ctx);
+void amdgpu_svm_range_put_if_dequeued(struct amdgpu_svm *svm,
+				      struct amdgpu_svm_range *range);
+void amdgpu_svm_range_unqueue(struct amdgpu_svm *svm,
+					struct amdgpu_svm_range *range);
+void amdgpu_svm_range_remove(struct amdgpu_svm *svm,
+			     struct amdgpu_svm_range *range,
+			     struct drm_gpusvm_ctx *ctx);
 int amdgpu_svm_range_map_attrs(struct amdgpu_svm *svm,
 			       const struct amdgpu_svm_attrs *attrs,
 			       unsigned long start, unsigned long end);
@@ -165,5 +175,11 @@ amdgpu_svm_range_find_or_insert(struct amdgpu_svm *svm, unsigned long addr,
 int amdgpu_svm_range_get_pages(struct amdgpu_svm *svm,
 			       struct drm_gpusvm_range *range,
 			       struct drm_gpusvm_ctx *ctx);
+bool amdgpu_svm_range_notifier_event_begin(struct amdgpu_svm *svm,
+					   struct drm_gpusvm_range *range,
+					   const struct mmu_notifier_range *mmu_range);
+int amdgpu_svm_range_invalidate_interval(struct amdgpu_svm *svm,
+					 unsigned long start_page,
+					 unsigned long last_page);
 
 #endif /* __AMDGPU_SVM_RANGE_H__ */
-- 
2.53.0

