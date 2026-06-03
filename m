Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 988D0CD6E4A
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 06:50:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A80710F8F8;
	Wed,  3 Jun 2026 06:50:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xuRd4DWq";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010037.outbound.protection.outlook.com [52.101.46.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 707DC10F8F8;
 Wed,  3 Jun 2026 06:50:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JUX3dXtyjlMmDnJ1mC37AYJm63IzNsYdadnruFNSGX54C1TSYeM8Rkd6ISz4yQactYXe8c3QUWBaqVKrG+I9L3L7k73WpsLp04NN2paTxChh7s0U6nTNk94P7Tli2wYBBoUsy/mUTgx8iM65BhzvQ5WrzKWfVjtCXkesEGNFe9tRDuRgrnLmCc2x+MyCTKHTMATmsDvkORDarvfIUvzyrtdYMzXpB//Nu+7+2h0eiepgDFjyeQlWgRAjDffn4sswlU/EIzvFgbOgrM/Z2AzSKB0TfgqZFObQn566GY7TqoT8soTwjB+MZd0m5AhXXGzs71O3lA/dP+t9EsoL7Fx+9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CDtyIUZ83ldEGmMe8Ukr+0goP4uzduxR/ZbSKAYCNJY=;
 b=TRMvplxbYZVpTnbdSnho6QE1sru1YbAv4u8MhZTOwtKETwI0T3FYkZUv/4BMJs+FCiUOC1xPLSFlLONStQwFo7ubb/Pp44zJBalXUP6BDOQ3aARURoMK8VzfpGYMOZr0N03mmFbojZ+Um5Sw7G5Rby7a8cKUD+Lx2ldA7d4767obkNVNS87bL/DLQF/A1nxysUkuzSay2z8T5zR2PNt+Z5R3oyoRdDq/fvVzS7yVjtAjhvlEmbjUJn/NFP4hgY4jTPrEcsGVKAOrVsvq1iFQvqEu5hfDXV0dPDWbnrjofSjVt+PmvbDn3kol6sX49OAMX1WpgQMEkc0dA/Z/6D08cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDtyIUZ83ldEGmMe8Ukr+0goP4uzduxR/ZbSKAYCNJY=;
 b=xuRd4DWqjuB0eQiFN2att8QD/QCC55p7T7qLp8EG2yclu4BA0DlNUtU8cnV7Ys8m7R9ZlK2QFFKpyvdQHGyguzCol1OTBhh/PLt8VdienZQZ7o2nybyvVsRM9HFWfESrv4l1RFHelKlfUy5MWvJFOqTavXUDm6nUcM13w2VIJ6k=
Received: from SJ0PR03CA0263.namprd03.prod.outlook.com (2603:10b6:a03:3a0::28)
 by SJ0PR12MB6807.namprd12.prod.outlook.com (2603:10b6:a03:479::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Wed, 3 Jun 2026
 06:50:49 +0000
Received: from SJ1PEPF00002322.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::5f) by SJ0PR03CA0263.outlook.office365.com
 (2603:10b6:a03:3a0::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 06:50:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002322.mail.protection.outlook.com (10.167.242.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 06:50:48 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 3 Jun
 2026 01:50:43 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>,
 <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC] drm/amdgpu: adapt SVM to drm_gpusvm pages/range/drm decoupling
Date: Wed, 3 Jun 2026 14:50:30 +0800
Message-ID: <20260603065030.2554403-1-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002322:EE_|SJ0PR12MB6807:EE_
X-MS-Office365-Filtering-Correlation-Id: d497b694-97d9-4df5-7a89-08dec13c7216
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|6133799003|18002099003|3023799007|11063799006|56012099006|921020|13003099007;
X-Microsoft-Antispam-Message-Info: bJFADXkVruykEMOiHqHmfgBBu1ixoT6NaYe9pNhtjHA2REenHdp4OKLlvL2l3SlwH38pgyjGk9T6lADupv4OoYhsoB6BNnb7sUOiQwaZF9aPSMQGEGo7uEQBzMpVpBanzk2FhKLbOpS5Dsb/w2hthwqbnrEFsXCVJdn4ZWXmh/PbmAH1mE9QSdZDxn+RbLspN755SBx9UlY+fCIy+gDtlUU0/3ZOmyXF4PGCUeK0uHg1LEU8yhUBwDiGnsHC4tZOFJXyydPJ6JL36K560eocj89NTrqSZgtFUNPyQrrfCYPmepPAwjJ10lc1BxDT8RsJTcs39F5lRKntfjVSBs+ysungIcdtg0wuLZ5zTKCOmPzaiTHBMZSfT6cp9at7FFu4GVZgbXbShgZUXGr4a8Kg7E6/pPlFcXOWCQQBNiJo2FhIkW6c0VDocFz2tpS5MXCCnpAZFcwVsX3sWkgAzcJyjGTP+h8nNTdeZPn5VeOxNJR7xighwkq/nLlSgrE+0owP29sVrNoLE7waiycaF+Hevpny9LRXA/VPD9NVztK8SuzNWOhf/qeznLs/cKRhHj5oOM2mSRMvuVe+ISqRHq1W3YT210ibh+kwBSwBKekx6tLGIRISp5u1DlEhYhu/899nx8MP0oj5n0mXEiW4oNGajF7lHzjZbG6sGBRECYZA1Ntmih+Y9rAocJzd8GFjWMoTGy1LI5VU5joBdcQg0yRxz57qbDbJLmCG1+U3JFiaFb9oFsezasIq9BJYATe1h4Pj6R9uuLGp+/UrHnULsfojxw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(6133799003)(18002099003)(3023799007)(11063799006)(56012099006)(921020)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7XvcHCS/0DSB1dUYP/qZoleTz/bAt7KZNj08dp3kgREEAdfajzMNslWx4gkQEomqH17wkMbfRpRYyaiQRb8UN0bzbcaUJ73u6gHTguNqOX1ij13d2/oUWrXdi/pYkYxLiFRP5d9nGH2VHFg+cTqBG3MmSDtQkz6EDh5siE3UkWj7TBpjgO8AGaHRkL7xZEaDIxZvu08WGeCMPIKwr9fqTvDKzfoW4Uqve+EKCpkvN1eDXFuZ7gXWtoIGkCjXdyNWvVxYHe7ZwLphqr5KjQlbq3cnUwMKk4CQDuwSPzentvhbDTjtndMJYUkhQ9+MeczRDG6jYV8orUccFPHFdVyoxNvuKdUan5Lf4weVaXzWPuxSMWxli6XmIgR3Z11MNFmrQcuIxecPv2xfEmi03Bhfyd21UnKy3S3VdIDscLsKdeaUKxllUdi7lBAgoRz050tD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 06:50:48.8448 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d497b694-97d9-4df5-7a89-08dec13c7216
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002322.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6807
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

The drm_gpusvm framework has been refactored [1] so that:

  - drm_gpusvm_range carries only MM/VA-range state.
  - drm_gpusvm_pages owns physical/DMA state and embeds drm_device.
  - drm_gpusvm itself is now a pure MM-level object.

Adapt amdgpu SVM to the new shape, mirroring the xe conversion:

  - Embed struct drm_gpusvm_pages in amdgpu_svm_range; amdgpu is
    1 svm : 1 drm_device, so a single instance is enough.
  - amdgpu_svm_range_alloc() seeds pages.notifier_seq;
    amdgpu_svm_range_free() calls drm_gpusvm_free_pages() before
    kmem_cache_free().
  - Replace drm_gpusvm_range_{get,unmap}_pages() and
    drm_gpusvm_range_pages_valid() with the drm_gpusvm_pages
    helpers, passing &adev->drm and &svm_range->pages explicitly.
  - Drop adev_to_drm(adev) from drm_gpusvm_init().
  - Move unmapped/partial_unmap reads from base->pages.flags to
    base->flags.
  - Add a small driver-local amdgpu_svm_range_unmap_pages() inline
    helper since the call site count justifies it.

No functional change intended.

tests:
  Tested on gfx943 (MI300X) and gfx906 (MI60) with XNACK on:
  - KFD test: 95%+ passed.
  - ROCR test: all passed.
  - HIP catch test: gfx943 (MI300X): 96% passed.
                    gfx906 (MI60): 99% passed.

Depends on:
[1] [RFC 0/5] drm/gpusvm: split MM and device state across
    gpusvm/range/pages

Base amdgpu SVM series this sits on top of:
[2] https://lore.kernel.org/amd-gfx/20260529054804.596214-1-honglei1.huang@amd.com/
[3] https://lore.kernel.org/amd-gfx/20260529054928.596825-1-honglei1.huang@amd.com/

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c       |  5 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c | 30 +++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h | 18 ++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.c   |  4 +--
 4 files changed, 41 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
index 626c5790e4d..57668f1e06b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
@@ -96,11 +96,14 @@ static struct drm_gpusvm_range *amdgpu_svm_range_alloc(struct drm_gpusvm *gpusvm
 
 	INIT_LIST_HEAD(&range->work_node);
 	range->pending_start_page = ULONG_MAX;
+	range->pages.notifier_seq = LONG_MAX;
 	return &range->base;
 }
 
 static void amdgpu_svm_range_free(struct drm_gpusvm_range *range)
 {
+	drm_gpusvm_free_pages(range->gpusvm, &(to_amdgpu_svm_range(range)->pages),
+			      drm_gpusvm_range_size(range) >> PAGE_SHIFT);
 	kmem_cache_free(amdgpu_svm_range_cache, to_amdgpu_svm_range(range));
 }
 
@@ -411,7 +414,7 @@ static int amdgpu_svm_init_with_ops(struct amdgpu_svm *svm,
 	}
 
 	ret = drm_gpusvm_init(&svm->gpusvm, "AMDGPU SVM",
-						adev_to_drm(adev), current->mm, 0,
+						current->mm, 0,
 						adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT,
 						AMDGPU_SVM_DEFAULT_SVM_NOTIFIER_SIZE * SZ_1M,
 						&amdgpu_gpusvm_ops,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
index ef913a2363e..27756256105 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
@@ -43,10 +43,10 @@ amdgpu_svm_range_pages_valid(struct amdgpu_svm *svm,
 
 	lockdep_assert_held(&svm->gpusvm.notifier_lock);
 
-	if (base->pages.flags.unmapped || base->pages.flags.partial_unmap)
+	if (base->flags.unmapped || base->flags.partial_unmap)
 		return false;
 
-	return drm_gpusvm_range_pages_valid(&svm->gpusvm, base);
+	return drm_gpusvm_pages_valid(&svm->gpusvm, &range->pages);
 }
 
 bool amdgpu_svm_range_is_valid(struct amdgpu_svm *svm,
@@ -267,11 +267,11 @@ amdgpu_svm_range_update_gpu_range(struct amdgpu_svm *svm,
 	unsigned long dma_idx = 0;
 	int ret;
 
-	if (!base->pages.dma_addr || !npages)
+	if (!range->pages.dma_addr || !npages)
 		return -EINVAL;
 
 	while (mapped_pages < npages) {
-		const struct drm_pagemap_addr *entry = &base->pages.dma_addr[dma_idx++];
+		const struct drm_pagemap_addr *entry = &range->pages.dma_addr[dma_idx++];
 		unsigned long seg_pages = min_t(unsigned long, 1UL << entry->order,
 						npages - mapped_pages);
 		uint64_t pte_flags;
@@ -332,10 +332,15 @@ int amdgpu_svm_range_get_pages(struct amdgpu_svm *svm,
 			       struct drm_gpusvm_range *range,
 			       struct drm_gpusvm_ctx *ctx)
 {
+	struct amdgpu_svm_range *svm_range = to_amdgpu_svm_range(range);
 	int ret;
 
 retry:
-	ret = drm_gpusvm_range_get_pages(&svm->gpusvm, range, ctx);
+	ret = drm_gpusvm_get_pages(&svm->gpusvm, &svm_range->pages,
+				   adev_to_drm(svm->adev), svm->gpusvm.mm,
+				   &range->notifier->notifier,
+				   drm_gpusvm_range_start(range),
+				   drm_gpusvm_range_end(range), ctx);
 	/*
 	 * HMM returns -EPERM when write access is requested for a read-only
 	 * VMA. Retry as read-only so the eventual GPU mapping follows the CPU
@@ -360,7 +365,9 @@ int amdgpu_svm_range_get_pages(struct amdgpu_svm *svm,
 void amdgpu_svm_range_evict(struct amdgpu_svm *svm,
 			    struct drm_gpusvm_range *range)
 {
-	if (!range->pages.flags.has_devmem_pages)
+	struct amdgpu_svm_range *svm_range = to_amdgpu_svm_range(range);
+
+	if (!svm_range->pages.flags.has_devmem_pages)
 		return;
 
 	drm_gpusvm_range_evict(&svm->gpusvm, range);
@@ -496,8 +503,8 @@ void amdgpu_svm_range_remove(struct amdgpu_svm *svm,
 
 	amdgpu_svm_assert_locked(svm);
 
-	if (!base->pages.flags.unmapped && !base->pages.flags.partial_unmap)
-		drm_gpusvm_range_unmap_pages(&svm->gpusvm, base, ctx);
+	if (!base->flags.unmapped && !base->flags.partial_unmap)
+		amdgpu_svm_range_unmap_pages(svm, base, ctx);
 
 	amdgpu_svm_range_invalidate_gpu_mapping(range);
 	drm_gpusvm_range_remove(&svm->gpusvm, base);
@@ -515,7 +522,7 @@ amdgpu_svm_range_notifier_event_begin(struct amdgpu_svm *svm,
 
 	AMDGPU_SVM_RANGE_DEBUG(svm_range, "NOTIFIER");
 
-	if (range->pages.flags.unmapped || !svm_range->gpu_mapped)
+	if (range->flags.unmapped || !svm_range->gpu_mapped)
 		return false;
 
 	AMDGPU_SVM_RANGE_DEBUG(svm_range, "NOTIFIER - EXECUTE");
@@ -580,10 +587,9 @@ amdgpu_svm_range_notifier_event_end(struct amdgpu_svm *svm,
 
 	amdgpu_svm_assert_in_notifier(svm);
 
-	drm_gpusvm_range_unmap_pages(&svm->gpusvm, range, &ctx);
+	amdgpu_svm_range_unmap_pages(svm, range, &ctx);
 	if (mmu_range->event == MMU_NOTIFY_UNMAP)
-		amdgpu_svm_gc_add_range(svm, to_amdgpu_svm_range(range),
-					mmu_range);
+		amdgpu_svm_gc_add_range(svm, to_amdgpu_svm_range(range), mmu_range);
 }
 
 int
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
index 2d677f0965b..90ad1c55438 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
@@ -53,6 +53,11 @@ enum amdgpu_svm_range_queue_state {
 
 struct amdgpu_svm_range {
 	struct drm_gpusvm_range base;
+	/*
+	 * Per-device DMA mapping state; single instance since amdgpu svm
+	 * is 1 svm : 1 drm_device.
+	 */
+	struct drm_gpusvm_pages pages;
 	struct list_head work_node;
 	bool gpu_mapped;
 	u8 queue_state;
@@ -75,13 +80,24 @@ amdgpu_svm_range_invalidate_gpu_mapping(struct amdgpu_svm_range *range)
 	WRITE_ONCE(range->gpu_mapped, false);
 }
 
+static inline void
+amdgpu_svm_range_unmap_pages(struct amdgpu_svm *svm,
+			     struct drm_gpusvm_range *range,
+			     struct drm_gpusvm_ctx *ctx)
+{
+	struct amdgpu_svm_range *svm_range = to_amdgpu_svm_range(range);
+
+	drm_gpusvm_unmap_pages(&svm->gpusvm, &svm_range->pages,
+			       drm_gpusvm_range_size(range) >> PAGE_SHIFT, ctx);
+}
+
 #define AMDGPU_SVM_RANGE_DEBUG(r__, op__)                                      \
 	AMDGPU_SVM_TRACE("%s: pasid=%u, gpusvm=%p, mapped=%d, "                \
 			 "seqno=%lu, range: [0x%lx-0x%lx]-"                    \
 			 "0x%lx\n",                                            \
 			 (op__), to_amdgpu_svm((r__)->base.gpusvm)->vm->pasid, \
 			 (r__)->base.gpusvm, READ_ONCE((r__)->gpu_mapped),     \
-			 (r__)->base.pages.notifier_seq,                       \
+			 (r__)->pages.notifier_seq,                            \
 			 drm_gpusvm_range_start(&(r__)->base) >> PAGE_SHIFT,   \
 			 drm_gpusvm_range_end(&(r__)->base) >> PAGE_SHIFT,     \
 			 (drm_gpusvm_range_end(&(r__)->base) -                 \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.c
index 4582fb9453b..77ef6f41ab9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.c
@@ -58,7 +58,7 @@ svm_restore_notifier_event_end(struct amdgpu_svm *svm,
 
 	amdgpu_svm_assert_in_notifier(svm);
 
-	drm_gpusvm_range_unmap_pages(&svm->gpusvm, range, &ctx);
+	amdgpu_svm_range_unmap_pages(svm, range, &ctx);
 	if (mmu_range->event == MMU_NOTIFY_UNMAP) {
 		AMDGPU_SVM_RANGE_DEBUG(svm_range, "GARBAGE COLLECTOR ADD");
 		drm_gpusvm_range_set_unmapped(&svm_range->base, mmu_range);
@@ -623,7 +623,7 @@ void amdgpu_svm_restore_gc_work_func(struct work_struct *w)
 		spin_unlock(&svm->work_lock);
 		range_start_page = drm_gpusvm_range_start(&op_ctx.range->base) >> PAGE_SHIFT;
 		range_last_page = (drm_gpusvm_range_end(&op_ctx.range->base) >> PAGE_SHIFT) - 1;
-		partial = op_ctx.range->base.pages.flags.partial_unmap;
+		partial = op_ctx.range->base.flags.partial_unmap;
 		ret = 0;
 
 		WARN_ON(!UNMAP_WORK(op_ctx.pending_ops));
-- 
2.34.1

