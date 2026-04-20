Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B10BF588C4
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 13:14:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD11010E5D9;
	Mon, 20 Apr 2026 13:14:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="icZYNBjx";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010019.outbound.protection.outlook.com [52.101.56.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3E3810E5DA;
 Mon, 20 Apr 2026 13:14:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x0ewYNRu0PHKdJhlqUbJ4Qn/cwLweMoJJcln1PlzZnO9NEvdeMe7qDaOre8yzUV9gKprLcd5KyZQZCPZzvXDg05sb56+CLfoGJJKTSTZWyVYFjkTa6eqfkq9VWub84ydt/zNaqtRDuy5RAF7gv+JT8wDFkiqt0qmbIpxMNV3nebX465F0qlRqtuQqV6rBGBktVJn6j2albd4/NxHgvZVlNmeaxq6F4Aim/3h+12EGGnOBiurHf3rYe6A182QecLWB4hpOX61kWRt1XcmE4xGhvfX6jp1msXVA8z4zkrskKbYPpspnhY77UHeYpjPkheqLDcckjP85voKwj3CfHFHOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ziOWKCeRGIzxygkdKwzdt9alfSkuKG9caOPpzC127mI=;
 b=bsUXT2ZwiPWzOssVhPbNFgz7EWC6IINvrgqTZ8eJjUtXnj1cM5BeVhOLHlg0PoINkMRTH4YxiGK09q8IvJ52bNgbAcV7uHsmrfxlAOwGOnLTedr/LdbHLSVRYmmWAFPjtdG/0PU1DbrYxDz+9bZ6TSJTOh5hhuNg9rOIKbRKoNu2vzUv53xVO+NlIhKo+hS0oQIZttcFk6tAnK8YJXXfRy4KhQJDbjciSbjtIk102pWUuUdu46mHI14pH4+SPE0nvhkH9PqXH9yccGwS5snOZOMLjiknm+zaYDzYVx/sGd6BvlOq5+kY6C0JC33ng2Ot/sFvM/bAWj1AhhcWgzIwKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ziOWKCeRGIzxygkdKwzdt9alfSkuKG9caOPpzC127mI=;
 b=icZYNBjxOBQarrPpdVmPL118B6UTtlkc2lwjbgLInIu32zwKg1BJqWlFS2UEqcEN/IDNCpZ1/LY5jb5hGBYoZrDx0zxbjsBJsra2dRh1r5SE92jJmi+eE6YUk3fAsxVG3Q3Uy/dUyMRpMndu0GW/dXToszhJe2YS//c+brMgcUc=
Received: from CH3P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::33)
 by MN2PR12MB4318.namprd12.prod.outlook.com (2603:10b6:208:1d8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Mon, 20 Apr
 2026 13:14:12 +0000
Received: from CH1PEPF0000AD79.namprd04.prod.outlook.com
 (2603:10b6:610:1e8:cafe::c2) by CH3P220CA0026.outlook.office365.com
 (2603:10b6:610:1e8::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Mon,
 20 Apr 2026 13:14:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD79.mail.protection.outlook.com (10.167.244.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Mon, 20 Apr 2026 13:14:12 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Apr
 2026 08:14:06 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <matthew.brost@intel.com>,
 <rodrigo.vivi@intel.com>, <thomas.hellstrom@linux.intel.com>,
 <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>, Honghuan He <honghuan.he@amd.com>
Subject: [RFC V3 08/12] drm/amdgpu: implement SVM range notifier and GC helpers
Date: Mon, 20 Apr 2026 21:13:03 +0800
Message-ID: <20260420131307.1816671-9-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260420131307.1816671-1-honglei1.huang@amd.com>
References: <20260420131307.1816671-1-honglei1.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD79:EE_|MN2PR12MB4318:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e9c9af5-c8e6-47a9-6873-08de9edeb6ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: gVuJuj6u5HKke20BHO4gh9AC2mILyOoBz//daqzEKB46dKV9zfZEKvY9kKXlvsc5jAy1z1yZCXI00i9O5+GXOcFkgnucAE9jBzjeXjfKA+uda3jAubZewGe0lqoXWhm7T036Dhuj753d+vDODYmY4ZhFs9eM+Fqs8wpju9NKZ3fUiPAyvpo/YhJ5xzh46FsFJlKifoILCgC8FpzEC5+cTbTvdGvfw/hPtFoB0phaa80Qc+SPA0x/XctyCdRJWdr1UqFbzv53I4T3eW4EfKBbqT5vhJiADt+XXQzL1+SpGnc3N8AN/URM3Wy1jDTy3sDi4krkeh8PtWaaCSQeHQpLowNAd1OEEos9fYH+mG/Ni51GGeFKWy1niup9ODXFDDZItl+mZaxSsVaFOXRDR+z7JkaorOxRXv84+A4P/Qkh1WGeLkcyWooK+tIci2zAOz6ZMqhwlO8CrRHwx4/gqjCB9riP7Zw8XQVhWRAZzqYicfca2hqb79nRj/U15/TDe2StsUK2hSWOn0//M1iM/GNlmppDOUo83CV8Nm04JGIKT6yWnR5ms7g64aqou2JF800IeOqMaszJS+zW/Krv982/aD+pgKIjr6LAdQCwQ8n4bspGRtCWXs449+EKknAAMRrw9jj78hsnBrfsl6PG7c5E7cp6MGkGyhoREi7wSsIaa3qtZqR/UwSVSDhIqY4z/QY+xLNvYmen/ebtUp1iTziUs1LgJm4dfCoO/mglE89Bp51p8hYZYSoTGSB7PLwqKQDeH3+veiMXswOzydYlIEK0KycTzJmUzVCErQWd0rsPO6VmNwnl1yGkrWLBQ+/K6rHT
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(921020)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: k9u1T/9em7K35zqcVU4H9cmQSdFNoZN2TDtlJzJnij9ii+99J+d15zS8bNaI5dkWiDUUNbkcfPnlhoYRMx2yYOrgboSTobLH7XYzkf/zsRsuGLr5lM6XpI9PXMq0/WYbOyr1iY0yYl0J1dcgu88GuslSUDlshb21mbVl9fYET2wJuIdbarFBWiKKTZwmKHY34/rh9prT7APdMPLpaieIy2qN6FL5JUQOQrC3mM31GlDAryALJ9oKE478WM9r+f7uEYsSprrIQGIDk1mAOfvdTtI8iKGqsyxYmYNEK8dNeTrMv7xAEluWUTYAUQjZ738Nlans7K4fqW9vQ/NTJ59BxXY0kppyBhymSinKgyXEOo8uykXGRhPzQzS+BmXHURjUnrMop5SR7iRjM+Okg8BlQ+WTYCMWgkx1VY1IShzFaChFYWBqFUhDSK5qLMyNZftQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 13:14:12.1714 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e9c9af5-c8e6-47a9-6873-08de9edeb6ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD79.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4318
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

Implement MMU notifier event handling, range removal, and garbage
collection helpers in amdgpu_svm_range.c.

Range lifecycle:
- amdgpu_svm_range_remove(): unmap DMA pages via drm_gpusvm,
  invalidate GPU mapping, and remove the range from drm_gpusvm

MMU notifier events:
- amdgpu_svm_range_notifier_event_begin(): zap GPU PTEs for an
  affected range under memalloc_noreclaim context, wait for
  pending fences, and flush TLB
- amdgpu_svm_range_notifier_event_end(): unmap DMA pages; for
  UNMAP events, queue the range for garbage collection

Garbage collection helpers:
- amdgpu_svm_gc_enqueue(): set pending UNMAP operation and
  address bounds on a range
- amdgpu_svm_gc_add_range(): add range to GC list under spinlock,
  mark gc_queued, schedule GC work

Invalidation:
- amdgpu_svm_range_invalidate_interval(): walk all gpusvm ranges
  in a notifier interval, dispatch begin/end notifier events,
  queue rebuild operations for non-UNMAP events when running in
  xnack-off mode

Signed-off-by: Honghuan He <honghuan.he@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c | 179 ++++++++++++++++++
 1 file changed, 179 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
index 790935914..2e53b786c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
@@ -487,3 +487,182 @@ amdgpu_svm_range_map_interval(struct amdgpu_svm *svm,
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
+					  start, end)
+	{
+		struct drm_gpusvm_range *range, *next_range;
+
+		drm_gpusvm_for_each_range_safe(range, next_range, notifier,
+					       start, end)
+		{
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

