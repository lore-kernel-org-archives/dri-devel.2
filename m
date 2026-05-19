Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28216CD4F52
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 08:32:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8938710EB5A;
	Tue, 19 May 2026 08:32:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IwYrMuTn";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013010.outbound.protection.outlook.com
 [40.107.201.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E05810EB5C;
 Tue, 19 May 2026 08:32:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CY+qqx2aGpOst1eA/na/wUmThbyq5AV259v7oJXzfBqctPkeR5Ws8YzIh49qldfeGfgOXXw8XE/Q0R8Gvnlf6Jso9y/FNQVxKE2517QyUByDpXN6Ndk0WWZDdqeUUoaUw89z6mf7ksgrLjO98UU0zWdWeJTbM2iJqRBtIRfz6FHMraATtGDBWsxjuXLL7qZ04+GE5v58XplfMqvtLjzOs1oG/Pwp/TCgglIAjPot08ZEPY7w/wHNDqLd27yfwvv/0LSd2cSH1GettNKw2yhbSGfWwlCtjycJdfQPdDQDQHOtwyG4/ccuOAz/wmJ81h+7+rSCFPGZ9tesT+/HlGKkog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HBXp4nkh6t5SfwICOlGfaB4xuvy4xIUVFgxzvI2S/2Y=;
 b=d+s8qOaygUYmB6JHmSfZZyjMY2nHDn57McO1n/E6QQQGwpn9tnt2VnDR6YFETj87zFU6y0M2MbptaHFHqRsUxbqPt+Px7T/SNvPTYpMTpwLvWldG4QeuVC1RGd0W3H4UYfdkydy5HZxarmr+nVEcqz0Tc0a2+rCpbcq4zvxmYYVw25miTfnVDMTBmpW15JeR3A3x3MnaTHUus0kQbJ6aW8dsUbVBndKzlbjWj2Ar/IeHQd2tkTxdp845BTsg5SE68gPNJUiftv+rl2NFlUiiEhMAe3owIxLHv4tnaqxRTiNcUk5yLjIHWS4aO6kzBzjIfIJj46fjplEM1cSQkR+tsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBXp4nkh6t5SfwICOlGfaB4xuvy4xIUVFgxzvI2S/2Y=;
 b=IwYrMuTn7brBD3jNwZVdPYh8tkGDyNqFMPJszjRH/dJiyFHeev+CQAEWakG2pLPiHAqrxPU/IDOMtVrIgmzTjJ7GK4wRgBCw78SRQaAxOarotOudAof4VBMQjPhBXE4XR1Ve2+EwxGSqbM7FQr+cebHz4lCGpIkh0xgrdZ898RI=
Received: from CH0PR03CA0043.namprd03.prod.outlook.com (2603:10b6:610:b3::18)
 by CH2PR12MB4263.namprd12.prod.outlook.com (2603:10b6:610:a6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 08:32:21 +0000
Received: from DS2PEPF000061C5.namprd02.prod.outlook.com
 (2603:10b6:610:b3:cafe::75) by CH0PR03CA0043.outlook.office365.com
 (2603:10b6:610:b3::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 08:32:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF000061C5.mail.protection.outlook.com (10.167.23.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 08:32:20 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 19 May
 2026 03:32:16 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>,
 <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC V6 08/12] drm/amdgpu: implement SVM range notifier and GC helpers
Date: Tue, 19 May 2026 16:30:53 +0800
Message-ID: <20260519083057.3108087-9-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260519083057.3108087-1-honglei1.huang@amd.com>
References: <20260519083057.3108087-1-honglei1.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C5:EE_|CH2PR12MB4263:EE_
X-MS-Office365-Filtering-Correlation-Id: 35450145-2705-47a0-0fc6-08deb58124ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|921020|22082099003|18002099003|56012099003|11063799005|3023799003;
X-Microsoft-Antispam-Message-Info: 7CDr+vo2nttLQ03HYLoy44hRXSvgWCW7mknGtKyhKzKU4mY8V56p94ohOR7wcwtsVR5aNfRJPlPNQDTt5etXU+7J40kbjB79y6dpoTEg9sVg5WRMwy/lZqR9Ug6TBDP2kUvF6q+zcCFKKk4PEFSQuuxsThKLkXPafRS0//OYWspYOtH72v62IScr0sc5jO4fT12zOnMFz3PJ6XqpaVBkz5Rgy8o78u8iN1XslsRA1yU0zKQrqFyevfBKsrOyvapzAhJW3qyhvwx3LhSil7XMolOg155hlDQbe8uG+hbwr3QHywBGBybw/Pr9uHAr/CXGjqPZTUy30VQq+u5/rNNwnmOYkNC9l4pHtJ0zdiLC0iA4gR7AAYaY+xi8kdjcBt/wrq0t+vjCj5vwRjPQbQd9ZUIi7rvvqR9O/VJkwvqiztHqGh4QOcf9NHjMq0nXhZY2/rsFvfBt2oGIjdb14Lr/qZDqlZJqANAAwpR/02Mc0wy5a94CpXcXkebRCfbN+bYpoUvtgLrnVl7DwbE1T19gMGFeOuI1WD2duzoRjH7YW0mW31tsIKxDaN61uwHXX0zEHNjOOfLlrlpYHLIkztchmvEkdEbxpaX/4Y/dwYRvB1k885Pum0i7ms3LKqbg0LEn9UnmTm7nOHo23OK8sAxRU4Hx5q7kfBsn5hN2vYmb/jpEbXDiCZKZdTm8m7jR1ubX4WtXwlAqVVvDNv7/D6T9tYzzycxa9yXUmHIciSfV5KPVWii1rRF+m6E8iJT14gW0vtQ9l/aBuOOlKdwAWVowgw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(921020)(22082099003)(18002099003)(56012099003)(11063799005)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0vMe/QEOsH0iEs349My0LFRIwgfPCu3Msypr0Wv2BITZQqEUOj6Iu82BotMsowfqg+91KlEwC3RgiUU8zacdGLqDCYtmMWZ2B3PDFB+UN3SXYH6EPuJ2NkNQGrj7hv/gnmd5gPnO2YhZXgoaXvNIknZherDRuSYjbKwL70iHWI2HTfP21puPRVbMgH+i0EKLY4c/aHI5wcQZSpZh0Fbva2NMZ2Aqi+oPhvGZ1n0CSTv83d5WQq/k71ylK+SlTQhplNxmNClm+KT8T1wABWjDEgnppOe2QJFURQOd5DGX5wg/YtBtJiMglx+JNL8UzAwkBB/Ghda5gasgTQlgjC2AXsVhwHI2zEHJbJSTrNWHWtSIrcVlTv8fc+7E5t9x9l86XYC4ts1R8Rukgu2yvwrcqUw1FCzJ1ovRL8V7rXo4ifM4dOW3+KnTc52GD98VEYPu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 08:32:20.7554 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35450145-2705-47a0-0fc6-08deb58124ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4263
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c | 231 ++++++++++++++++++
 1 file changed, 231 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
index eda3ebaf5..a5ce4c488 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
@@ -467,3 +467,234 @@ amdgpu_svm_range_map_attrs(struct amdgpu_svm *svm,
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
+			bool crosses_boundary = start > range_start || end < range_end;
+
+			if (svm_range->gpu_mapped) {
+				AMDGPU_SVM_RANGE_DEBUG(svm_range, crosses_boundary ? "ATTR DESTROY" :
+										"ATTR ZAP PTE");
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
+				/* remove the ranges crosses boundary to let GPU fault create new ranges
+				 * bounded by the updated attr_range boundaries.
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

