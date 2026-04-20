Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93AFBF36C58
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 12:08:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5E9F10E54F;
	Mon, 20 Apr 2026 12:08:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dxzMGqf+";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010043.outbound.protection.outlook.com [52.101.61.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FF0C10E545;
 Mon, 20 Apr 2026 12:08:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kVrkr0KbXC5ypXNZw57J8JHFeSKPbH9e6nlb2kRsPAeRuz7qbVfGW+olTctmrJxGMcRUcG8jXh/851Tq0mV9Nvk84noE5A65qZLgUWi2K6R9ptxon2y1UVXziMwpTLtfrp3n9IakzaVSQE+OlrmRR06ZxXeny/dhzRluQLpbYSxGbk3gUQGvIxibaPPrC05uTdlLQn6XtI5FP9wIV8ajBusmwfOY3K3tqmcmEuIBlNft5hAzpQLsd1wojI1KizFTrb8tJvbmuCrNI8abqbGpYFdtE2Ncr1ssfAqL1np6Gm3mTD5BcDY8vhP4NGuZVJYK9IQzk0mpd2jWBXRdELtqJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WvDlJdPdiM8dJ1V+L7FZEcvOmjuLBtjwR9PwWPecbzc=;
 b=JGxliI4RaRCI5dTV0H1hEiosI4/nUlNmLsIvRjZfsQDxF9BHJ+dAUC3y1N1+vOuo88JxNH7G/tDeJCztgvbWQfsIe28wVw/1Fbbh+LAaG7UmezrTOZjusf0H9XZKgp1Mn0rfgNHK+JeS3IXU7/NCpUoyn9oQGK5nEDroIBh1oa2AwLD7tf2ttXJvKqjAL+NagPqfEX1CdIAXwgIDz/s5I2vHmoUjLbK+R38RlOkSlHo4gCm/XfczhBtM+IGMCBzBbLi/Mfk1xgyW3HBmmRF4AYDAXVIwKB6ud0dmFV2+2yovXaK+uN4lMq+ataw5tByLiuW7ezb+609z7YIrCXG3EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WvDlJdPdiM8dJ1V+L7FZEcvOmjuLBtjwR9PwWPecbzc=;
 b=dxzMGqf+BHwFDl9nbqLCRIFMhG+rPKLbOZ/aDCGCjaZzBWI8R1NjjX2Q/jSK0OPSPBqv5FmlEFTdxIXOOVqT/d1LE9UqFkQBWeLFVlNOYSNmXKFV9gFOEeJnySIzejyyig/ciMu1w2RizkXtJIyj5jLbL4JlgvjXrPNeDj/0sR4=
Received: from BY1P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::17)
 by IA1PR12MB6556.namprd12.prod.outlook.com (2603:10b6:208:3a0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Mon, 20 Apr
 2026 12:08:35 +0000
Received: from CO1PEPF000066EA.namprd05.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::2c) by BY1P220CA0026.outlook.office365.com
 (2603:10b6:a03:5c3::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Mon,
 20 Apr 2026 12:08:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000066EA.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Mon, 20 Apr 2026 12:08:34 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Apr
 2026 07:08:30 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <matthew.brost@intel.com>,
 <rodrigo.vivi@intel.com>, <thomas.hellstrom@linux.intel.com>,
 <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC/POC PATCH 08/12] drm/amdgpu: implement SVM range notifier and
 invalidation
Date: Mon, 20 Apr 2026 20:07:35 +0800
Message-ID: <20260420120739.1811731-9-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260420120739.1811731-1-honglei1.huang@amd.com>
References: <20260420120739.1811731-1-honglei1.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb08.amd.com
 (10.181.42.217)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EA:EE_|IA1PR12MB6556:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ba0a0f1-8a1f-48b6-bccd-08de9ed58c17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: kdUvVajXS3xhduGBPhlqpZDyHJWywB/S2Tj8f6muDN7usS5jiubcdBz++larQYiuqRxqBZMJ7m4M6BSMTp+7S0lyX2dHzemdoyDPUnaFJ3Ez32yeXL7XMx/jMqiCazGDkMdcI2Cv5Uf0swGaZ2VLQsbz4iXPUWy6DpMtQ9aqSjbUff83Wo9lpGMGD+LkU0YYa7SVFROpKvLbzo7LEJexlpSanLH+hX15M8sS8ZWI9giCHTrA0PmOW09JrskfqqWAxVwEXW1i3GYcFBNslD1WqwY+8/d7KJ8Y0Pz9SU36+h11gm5LNocnKZtnrSnjJLweozgCnWc0HmmsAFKfvaPW6SN5hhqH381nKT1UaHSNd/4eWvUtRoWmpuKCtWvflt7VsuaIGQsNtXqjXQc2Pr3dgk3qAic9CTI5EwCVsdw6wwvGUTO/h5NBKDcKnLAuzcH4gVetBgkgLlBuSJs84dRzVu36V0IurtyLkqrTu2iWVwtoDjZNqkB8QjCS6MiHEjMuehMPzKVhgdMRk4Aa6A4O+cEqHRPehqrc2+9GRHzMnZWCFG7cwY33+kTUouFyqfIXG3zL/DRcYLm1gW9ZVBQleNFVK1ZmS1r1gR+Aes2dM5y+ba5bqPuzzEMDxWKVP6XPaAIZ1HATh+MHgaONEGI8731b0tcGRJPuRlL4B90sDDsyvb6xkrePZ05EfhqFCxzICaf0yqWPnil1rf3nchJddE4eC3Lueci+gyFvG7zCnWcr8pNfk7aqjwtUyv9RjY2Rywzb9M+xsn3wiwypn4cQmgYIjPUfAk4i4b3mK5pOrXhuuLSnxAStHJT0HJ+SLwJf
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(921020)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lficIateFfXlJG8kqYwb066u6Z9NtC2sFyt0o91joR6JAXPGZBXvKRg21krsBLNI5xQ2tOszNVNUUg7UJntXqZjIhTXKBEB90H4dg61ZJzgawB09VfQcr8Pi7ZO8vpLwXG1podpWtJ6zRAHmtVlM8BOoCdZUfy9cc38LEdt9/7jLLHbLZ9uiFDHzqKIBVgQRCwmBY3jy4ZJk0o8wkJaAtJttXpsCRS9Pj3sLQjjrDi7QiUBlRn4+EuLBs4vDeuR96PA43v1BnpWDWITn0EJ1ujqL6yAIe7jZ4yppcigcTOun6h6XPbMyPGJsShuE3V6/QdqhMotNXpZFvCeGouScZo5oIWxjaYqfdVCcZuR1ZnJfBaJBcj/eO7dnZObXGlOCvfDyoGFKKPAjaTeMoFZfYI7wh7ED5OEQNsMpkyTcj+CPfMvWCbgyALVI30pbphkW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 12:08:34.8069 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ba0a0f1-8a1f-48b6-bccd-08de9ed58c17
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6556
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

Implement MMU notifier handling and range lifecycle management:

- GPU unmap in notifier context: synchronous PTE clear with
  memalloc_noreclaim protection and fence wait
- Range removal: unmap pages via drm_gpusvm, invalidate GPU mapping,
  remove from gpusvm
- Overlap removal: iterate notifiers and ranges in an interval,
  remove all overlapping ranges, track rebuild bounds
- Rebuild: remove overlapping ranges then remap via attr tree or
  clear GPU PTEs with TLB flush
- Notifier range processing: walk ranges in a notifier for an MMU
  event, clear PTEs and/or queue work depending on event type
- MMU invalidation dispatcher: classify events (unmap vs other),
  determine operation (clear PTE, queue interval), trigger restore
  for non-xnack mode

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c | 253 ++++++++++++++++++
 1 file changed, 253 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
index b3bd4e2e6..eba0a52be 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
@@ -114,6 +114,57 @@ range_pages_valid(struct amdgpu_svm *svm,
 	return drm_gpusvm_range_pages_valid(&svm->gpusvm, range);
 }
 
+static int
+amdgpu_svm_range_gpu_unmap_in_notifier(struct amdgpu_svm *svm,
+				      struct drm_gpusvm_range *range,
+				      const struct mmu_notifier_range *mmu_range)
+{
+	struct dma_fence *fence = NULL;
+	unsigned long start = max(drm_gpusvm_range_start(range), mmu_range->start);
+	unsigned long end = min(drm_gpusvm_range_end(range), mmu_range->end);
+	unsigned int flags;
+	int ret;
+
+	if (end <= start)
+		return 0;
+
+	start >>= PAGE_SHIFT;
+	end = (end - 1) >> PAGE_SHIFT;
+
+	flags = memalloc_noreclaim_save();
+	ret = amdgpu_vm_update_range(svm->adev, svm->vm, false, true, true, false,
+				     NULL, start, end, 0, 0, 0, NULL,
+				     NULL, &fence);
+	memalloc_noreclaim_restore(flags);
+
+	if (!ret && fence) {
+		ret = dma_fence_wait(fence, false);
+		if (ret < 0)
+			AMDGPU_SVM_TRACE("notifier unmap fence wait failed: ret=%d [0x%lx-0x%lx]-0x%lx\n",
+					 ret, start, end,
+					 end - start + 1);
+	}
+
+	dma_fence_put(fence);
+	return ret;
+}
+
+static bool
+has_always_mapped_range(
+			struct drm_gpusvm_notifier *notifier,
+			const struct mmu_notifier_range *mmu_range)
+{
+	struct drm_gpusvm_range *range = NULL;
+
+	drm_gpusvm_for_each_range(range, notifier, mmu_range->start, mmu_range->end) {
+		if (READ_ONCE(to_amdgpu_svm_range(range)->attr_flags) &
+		    AMDGPU_SVM_FLAG_GPU_ALWAYS_MAPPED)
+			return true;
+	}
+
+	return false;
+}
+
 static uint64_t
 amdgpu_svm_range_attr_pte_flags(struct amdgpu_svm *svm,
 			    const struct amdgpu_svm_attrs *attrs)
@@ -487,6 +538,163 @@ amdgpu_svm_range_map_attr_ranges(struct amdgpu_svm *svm,
 	return 0;
 }
 
+static void amdgpu_svm_range_remove(struct amdgpu_svm *svm,
+						   struct drm_gpusvm_range *range,
+						   struct drm_gpusvm_ctx *ctx)
+{
+	lockdep_assert_held_write(&svm->svm_lock);
+
+	if (!range->pages.flags.unmapped && !range->pages.flags.partial_unmap)
+		drm_gpusvm_range_unmap_pages(&svm->gpusvm, range, ctx);
+
+	range_invalidate_gpu_mapping(range);
+	drm_gpusvm_range_remove(&svm->gpusvm, range);
+}
+
+static bool
+amdgpu_svm_range_remove_overlaps(struct amdgpu_svm *svm, unsigned long start_page,
+				      unsigned long last_page,
+				      unsigned long *rebuild_start,
+				      unsigned long *rebuild_last)
+{
+	lockdep_assert_held_write(&svm->svm_lock);
+
+	struct drm_gpusvm_ctx ctx = {
+		.in_notifier = false,
+	};
+	unsigned long start = start_page << PAGE_SHIFT;
+	unsigned long end = (last_page + 1) << PAGE_SHIFT;
+	struct drm_gpusvm_notifier *notifier, *next_notifier;
+	bool removed = false;
+
+	if (rebuild_start && rebuild_last) {
+		*rebuild_start = ULONG_MAX;
+		*rebuild_last = 0;
+	}
+
+	/* remove overlap ranges, need to remove entire range */
+	drm_gpusvm_for_each_notifier_safe(notifier, next_notifier, &svm->gpusvm,
+					  start, end) {
+		struct drm_gpusvm_range *range, *next_range;
+
+		drm_gpusvm_for_each_range_safe(range, next_range, notifier, start,
+					       end) {
+			unsigned long rs = drm_gpusvm_range_start(range) >> PAGE_SHIFT;
+			unsigned long rl = (drm_gpusvm_range_end(range) >> PAGE_SHIFT) - 1;
+
+			removed = true;
+			/* record rebuild start end, first range start and last range end */
+			if (rebuild_start && rebuild_last) {
+				*rebuild_start = min(*rebuild_start, rs);
+				*rebuild_last = max(*rebuild_last, rl);
+			}
+			amdgpu_svm_range_remove(svm, range, &ctx);
+		}
+	}
+
+	return removed;
+}
+
+static int amdgpu_svm_range_rebuild_locked(struct amdgpu_svm *svm,
+				  unsigned long start_page,
+				  unsigned long last_page,
+				  bool rebuild)
+{
+	unsigned long rebuild_start = start_page;
+	unsigned long rebuild_last = last_page;
+	bool removed;
+	int ret;
+
+	lockdep_assert_held_write(&svm->svm_lock);
+
+	AMDGPU_SVM_TRACE("remove and rebuild: [0x%lx-0x%lx] rebuild=%d\n",
+			 start_page, last_page, rebuild ? 1 : 0);
+
+	removed = amdgpu_svm_range_remove_overlaps(svm, start_page, last_page,
+						   &rebuild_start,
+						   &rebuild_last);
+	if (!removed)
+		return 0;
+
+	/* scan rebuild start end to build the extra removed ranges */
+	if (rebuild)
+		return amdgpu_svm_range_map_attr_ranges(svm, rebuild_start,
+							rebuild_last);
+
+	ret = amdgpu_svm_range_update_gpu(svm, rebuild_start, rebuild_last,
+					  0, NULL, true, true, true);
+	if (!ret)
+		svm->flush_tlb(svm);
+
+	return ret;
+}
+
+static void
+amdgpu_svm_range_process_notifier_ranges(struct amdgpu_svm *svm,
+					 struct drm_gpusvm_notifier *notifier,
+					 const struct mmu_notifier_range *mmu_range,
+					 uint32_t notifier_op,
+					 enum amdgpu_svm_range_queue_op queue_op)
+{
+	struct drm_gpusvm_ctx ctx = {
+		.in_notifier = true,
+	};
+	struct drm_gpusvm_range *range = NULL;
+	bool queue_ranges = notifier_op & AMDGPU_SVM_RANGE_NOTIFIER_QUEUE_INTERVAL;
+	bool clear_pte = notifier_op & AMDGPU_SVM_RANGE_NOTIFIER_CLEAR_PTE;
+	bool is_unmap = mmu_range->event == MMU_NOTIFY_UNMAP;
+	bool has_range = false;
+
+	lockdep_assert_held(&svm->gpusvm.notifier_lock);
+
+	drm_gpusvm_for_each_range(range, notifier, mmu_range->start, mmu_range->end) {
+		has_range = true;
+		if (clear_pte) {
+			amdgpu_svm_range_gpu_unmap_in_notifier(svm, range,
+									   mmu_range);
+			range_invalidate_gpu_mapping(range);
+		}
+
+		drm_gpusvm_range_unmap_pages(&svm->gpusvm, range, &ctx);
+		if (is_unmap)
+			drm_gpusvm_range_set_unmapped(range, mmu_range);
+
+		if (queue_ranges) {
+			unsigned long start = max(drm_gpusvm_range_start(range),
+						  mmu_range->start) >> PAGE_SHIFT;
+			unsigned long last = (min(drm_gpusvm_range_end(range),
+						  mmu_range->end) - 1) >> PAGE_SHIFT;
+
+			amdgpu_svm_range_enqueue(svm, to_amdgpu_svm_range(range),
+						 start, last, queue_op);
+		}
+	}
+
+	if (has_range && clear_pte)
+		svm->flush_tlb(svm);
+}
+
+static bool
+amdgpu_svm_range_interval_has_range(struct amdgpu_svm *svm,
+					     unsigned long start_page,
+					     unsigned long last_page)
+{
+	lockdep_assert_held(&svm->svm_lock);
+
+	unsigned long start = start_page << PAGE_SHIFT;
+	unsigned long end = (last_page + 1) << PAGE_SHIFT;
+	struct drm_gpusvm_notifier *notifier;
+
+	drm_gpusvm_for_each_notifier(notifier, &svm->gpusvm, start, end) {
+		struct drm_gpusvm_range *range = NULL;
+
+		drm_gpusvm_for_each_range(range, notifier, start, end)
+			return true;
+	}
+
+	return false;
+}
+
 int amdgpu_svm_range_apply_attr_change(struct amdgpu_svm *svm,
 				       unsigned long start,
 				       unsigned long last,
@@ -537,3 +745,48 @@ int amdgpu_svm_range_apply_attr_change(struct amdgpu_svm *svm,
 			 start, last, last - start + 1);
 	return amdgpu_svm_range_map_interval(svm, start, last, new_attrs);
 }
+
+static void amdgpu_svm_range_begin_restore(struct amdgpu_svm *svm)
+{
+	if (atomic_inc_return(&svm->evicted_ranges) != 1)
+		return;
+
+	svm->begin_restore(svm);
+}
+
+void amdgpu_svm_range_invalidate(struct amdgpu_svm *svm,
+				 struct drm_gpusvm_notifier *notifier,
+				 const struct mmu_notifier_range *mmu_range)
+{
+	bool is_unmap = mmu_range->event == MMU_NOTIFY_UNMAP;
+	uint32_t op;
+	enum amdgpu_svm_range_queue_op queue_op;
+
+	if (mmu_range->event == MMU_NOTIFY_RELEASE)
+		return;
+	if (atomic_read(&svm->exiting))
+		return;
+
+	if (!drm_gpusvm_range_find(notifier, mmu_range->start,
+				    mmu_range->end))
+		return;
+
+	if (is_unmap) {
+		op = AMDGPU_SVM_RANGE_NOTIFIER_CLEAR_PTE |
+			 AMDGPU_SVM_RANGE_NOTIFIER_QUEUE_INTERVAL;
+		queue_op = AMDGPU_SVM_RANGE_OP_UNMAP;
+		if (NEED_REBUILD(svm))
+			amdgpu_svm_range_begin_restore(svm);
+	} else if (NEED_REBUILD(svm) ||
+		   has_always_mapped_range(notifier, mmu_range)) {
+		op = AMDGPU_SVM_RANGE_NOTIFIER_QUEUE_INTERVAL;
+		queue_op = AMDGPU_SVM_RANGE_OP_RESTORE;
+		amdgpu_svm_range_begin_restore(svm);
+	} else {
+		op = AMDGPU_SVM_RANGE_NOTIFIER_CLEAR_PTE;
+		queue_op = AMDGPU_SVM_RANGE_OP_RESTORE;
+	}
+
+	amdgpu_svm_range_process_notifier_ranges(svm, notifier, mmu_range,
+						 op, queue_op);
+}
-- 
2.34.1

