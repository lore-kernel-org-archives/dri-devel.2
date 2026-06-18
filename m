Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76486CD98ED
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 08:09:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC36010ECBF;
	Thu, 18 Jun 2026 08:09:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WwhHfBmK";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012003.outbound.protection.outlook.com [40.107.209.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BDD010ECBE;
 Thu, 18 Jun 2026 08:09:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kpQ4PfRuInZd+ldtF8cyerjjkEu6c7175upvmxuOoNIphDmypEyOYe2F/Usia2El/swjGL/kUTlPiS0T09it9+Yt9hr+am6d0Mr9mp1tQs9ZH2wHnL6JZv0pMly+GXBqsZ/AVvLHlID4ohaDgYj3IwxPAqAfqKAr7tpZfNi6RdljIAinpr448RZo5t8Tt1ucfXnwaxR2NURV2+7A5GtRUaacGKqsoZyGTYQAvo/CzBcLWITgKow1zZPRirp4XXzfV+7QTcauf8+8B9qe5KKpW5TdmC7FaKpcgIEI2quIgeHzNDA2rizrUo0ZPUezCigjM1yLY8yNmXf6+NPSRdmGog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eaj7oWhckMheemSspp6cUaU0AtDNK6jTfGHYa1dybMw=;
 b=PoqcW/5G+3QCrPAW6SataZxAuToSyMDELYz8MpF1qVIuH3dJ52O65HzKPp1LyHX+15TDkAMIiKDbrzJ0OHK5VkzBKTS8P3GDxDesBXsVGzjgXPUZr0iCGpWPwAPmPpU0JQfQCSo32+Hl1vggJbX7IPOoAby/3KNlIUzZpIwzL711QC+bcQuai5kAo5mB2Qg1Ki01kcNrTSNsGlQcxaneQ16KDR29XsKAV0zdCDPmq88Y0yOCA2t/lQ5IoU+wuE6euNNFJVc6CNslCgRV2pBKOi3EjZf+ErU7/adSQj3KafVdIwpTtXZoIn7cyibvhSwhnFtpBuv2Eb1GS0ddXW7diQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eaj7oWhckMheemSspp6cUaU0AtDNK6jTfGHYa1dybMw=;
 b=WwhHfBmKU81E0rMvuMs1MjxBF8icNCYRayGKC8yxCKdsmRElp1wy3Sl8gGTQw4hPFR7pb+S03I0y3eiuV6t3lHDCh8ld8VHWA49nOIhmnAkXWUe7mT89kEtarl4D249yD7r6gSjFT7QHdhO8MNkKEzgMaDOvlB47lZUTC7laQ/4=
Received: from LV3P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::11)
 by CH3PR12MB9431.namprd12.prod.outlook.com (2603:10b6:610:1c1::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 08:09:30 +0000
Received: from BN1PEPF00004684.namprd03.prod.outlook.com
 (2603:10b6:408:234:cafe::9f) by LV3P220CA0019.outlook.office365.com
 (2603:10b6:408:234::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.13 via Frontend Transport; Thu,
 18 Jun 2026 08:09:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00004684.mail.protection.outlook.com (10.167.243.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Thu, 18 Jun 2026 08:09:29 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 18 Jun
 2026 03:09:29 -0500
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 18 Jun
 2026 01:09:24 -0700
From: Honglei Huang <honglei1.huang@amd.com>
To: <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>
CC: <aliceryhl@google.com>, <Alexander.Deucher@amd.com>,
 <Felix.Kuehling@amd.com>, <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>,
 <Jenny-Jing.Liu@amd.com>, <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>,
 <Ray.Huang@amd.com>, <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>,
 <Yiru.Ma@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [PATCH v3 1/5] drm/gpusvm: split MM state flags out of
 drm_gpusvm_pages_flags
Date: Thu, 18 Jun 2026 16:08:58 +0800
Message-ID: <20260618080902.1527255-2-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260618080902.1527255-1-honglei1.huang@amd.com>
References: <20260618080902.1527255-1-honglei1.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004684:EE_|CH3PR12MB9431:EE_
X-MS-Office365-Filtering-Correlation-Id: f2d409d1-77e8-4d92-1a13-08decd10ec33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|18002099003|22082099003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: g9k8wSq/3mH5F6Ctrg0bkY8enhjhuqpwoljBSVgMQfsdrnaHzkggXklOI83FmCjVqDCejHHw5eEfXgsOCEQxkjzO9H4m2KqBcTXpKXsmZm/Rfx5FbC0Enr44xG7PNuKQykMKq9vrwhC1XT9rx9pPHyrJENUwkOjuFKMX77SX2NTiZJkdSe8C+k73ZYorFSHVyTg6bcqYEdz5/ITT+RyLgipY4OffeTnQg1ilKyOjv6KrD+Tziri8NOvMEyIIAQDykOo3F0tWmSzfd6J224wmgtr8s+rn/3nrjRZ7rRvplKXhULmdQs8R1qbDSNcfAkSJ6uPp706mHsOEt93mH6xt564RRHEwNooAtKgX0OdAM4KM5C8FUbJnVdF8VO3L3U7jbhYD2Ys3jzHrLIDruXrR0xunHMZ+G6GAc9MAewtqKxmh5mtgmN+Ndj+RHo9GcTMEX8flGd74SdjSH6DEeDb4ND19HRIO73lCYo1ziRMe3MgllMNJFlnL9GNGmUy+W9izoi+3opJ6wuG8lQqICEuJSJMuBJwRqeKGeKd07SVg1SX3d3z1CJIv/3aWkimCIRaOoyoWRt+g+Vv/PU2L3IREhpamn1ac1Ymms+F6qnGOKC7Zoycxrxg/PLRV7yyXElL9mXmE+v5jpN+tuP0XbV1iH78S9wke8kyUMIyYdSo1YLM1RxgJOgCpQdZzr5Y2Q3Xx
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(18002099003)(22082099003)(11063799006)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uFiEtPiJtYEX4BNdVFKUu3g3g0cxh+XvvxSN4v+65ppuGV49iCOtpUD6hdfg4PsV/Pp/p8OfCwRlVCVP7hyCBEq6gCvgfJBAEbAjMANkf5i2+9aKK37Pm+n04YW96Is3Dh7VW+2KNZEIWAahnxv3He7ZrqU9QuOKV4TL0Etpq9UWIdJHSUQYpYZDjiudNjYUTnLZlfkxsaLPkRwELZHT7q8iARCyk5Sfyho/Vb+3DSO7CTmo4bhaAjHg6HoNh4tM3Z4Y9SEfuLIUks0qdEwNmHXViY5xOMvImmRZxYDt9yMDeKWU4fG9QzIYibLeWnlljAYwxU+D2Cz0g7XXjsFiI9MHzS64fRf50vxiHB1XSOzsTteMvl5DDs6Ry1HuJfDFqpG5dON2wko4IOfcWbpcXlaAs/e0240DYz/EPH29y2Sp3bFBDhE9l5hqEwZAHdsY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 08:09:29.8725 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2d409d1-77e8-4d92-1a13-08decd10ec33
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004684.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9431
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

drm_gpusvm_pages_flags currently mixes two status:
  - MM / virtual-address state: whether the range has been (partially)
    unmapped by the Linux MM, these follow the lifetime of the VMA and
    are a single per VA range fact.
  - Device mapping state: has_devmem_pages and has_dma_mapping,
    which describe the current page mapping status held by device
    itself.

Keeping both on the pages object blurs the semantics of the
abstraction of pages and VA range. So move the MM state flags onto the
range, and keep drm_gpusvm_pages_flags strictly for mapping state.

  - Introduce drm_gpusvm_range_flags { migrate_devmem, unmapped,
    partial_unmap } on drm_gpusvm_range.
  - Shrink drm_gpusvm_pages_flags to just has_devmem_pages and
    has_dma_mapping.

Side effect: drivers now need to check the unmap flags in the driver
itself to avoid handling the unmapped pages.

Mirror that bit onto drm_gpusvm_pages so the framework can
still short circuit drm_gpusvm_get_pages() under the notifier lock, and
make drm_gpusvm_range_set_unmapped() propagate it to the backing pages.
This follows Matt's review fixup for the v0 series; see the Link below.

Suggested-by: Matthew Brost <matthew.brost@intel.com>
Link: https://gitlab.freedesktop.org/mbrost/xe-kernel-driver-svn-perf-6-15-2025/-/commit/623f6a50c037d9e44f6c9fbe6859a0ba7ad50177
Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/drm_gpusvm.c | 21 ++++++++++++++++++---
 drivers/gpu/drm/xe/xe_svm.c  | 11 ++++++-----
 include/drm/drm_gpusvm.h     | 30 +++++++++++++++++++++++++-----
 3 files changed, 49 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
index 958cb605aed..df900553f21 100644
--- a/drivers/gpu/drm/drm_gpusvm.c
+++ b/drivers/gpu/drm/drm_gpusvm.c
@@ -641,7 +641,7 @@ drm_gpusvm_range_alloc(struct drm_gpusvm *gpusvm,
 	range->itree.last = ALIGN(fault_addr + 1, chunk_size) - 1;
 	INIT_LIST_HEAD(&range->entry);
 	range->pages.notifier_seq = LONG_MAX;
-	range->pages.flags.migrate_devmem = migrate_devmem ? 1 : 0;
+	range->flags.migrate_devmem = migrate_devmem ? 1 : 0;
 
 	return range;
 }
@@ -1784,20 +1784,35 @@ EXPORT_SYMBOL_GPL(drm_gpusvm_has_mapping);
 /**
  * drm_gpusvm_range_set_unmapped() - Mark a GPU SVM range as unmapped
  * @range: Pointer to the GPU SVM range structure.
+ * @pages: Pointer to the GPU SVM pages structure(s).
+ * @pages_count: Number of GPU SVM pages structure(s) passed in.
  * @mmu_range: Pointer to the MMU notifier range structure.
  *
  * This function marks a GPU SVM range as unmapped and sets the partial_unmap flag
  * if the range partially falls within the provided MMU notifier range.
  */
 void drm_gpusvm_range_set_unmapped(struct drm_gpusvm_range *range,
+				   struct drm_gpusvm_pages *pages,
+				   unsigned int pages_count,
 				   const struct mmu_notifier_range *mmu_range)
 {
+	unsigned int i;
+
 	lockdep_assert_held_write(&range->gpusvm->notifier_lock);
 
-	range->pages.flags.unmapped = true;
+	range->flags.unmapped = true;
+	for (i = 0; i < pages_count; ++i) {
+		struct drm_gpusvm_pages_flags flags = {
+			.__flags = pages[i].flags.__flags,
+		};
+
+		flags.unmapped = true;
+		/* WRITE_ONCE pairs with READ_ONCE for opportunistic checks */
+		WRITE_ONCE(pages[i].flags.__flags, flags.__flags);
+	}
 	if (drm_gpusvm_range_start(range) < mmu_range->start ||
 	    drm_gpusvm_range_end(range) > mmu_range->end)
-		range->pages.flags.partial_unmap = true;
+		range->flags.partial_unmap = true;
 }
 EXPORT_SYMBOL_GPL(drm_gpusvm_range_set_unmapped);
 
diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
index e1651e70c8f..63da149f3b7 100644
--- a/drivers/gpu/drm/xe/xe_svm.c
+++ b/drivers/gpu/drm/xe/xe_svm.c
@@ -134,7 +134,8 @@ xe_svm_garbage_collector_add_range(struct xe_vm *vm, struct xe_svm_range *range,
 
 	range_debug(range, "GARBAGE COLLECTOR ADD");
 
-	drm_gpusvm_range_set_unmapped(&range->base, mmu_range);
+	drm_gpusvm_range_set_unmapped(&range->base, &range->base.pages, 1,
+				      mmu_range);
 
 	spin_lock(&vm->svm.garbage_collector.lock);
 	if (list_empty(&range->garbage_collector_link))
@@ -166,7 +167,7 @@ xe_svm_range_notifier_event_begin(struct xe_vm *vm, struct drm_gpusvm_range *r,
 	range_debug(range, "NOTIFIER");
 
 	/* Skip if already unmapped or if no binding exist */
-	if (range->base.pages.flags.unmapped || !range->tile_present)
+	if (range->base.flags.unmapped || !range->tile_present)
 		return 0;
 
 	range_debug(range, "NOTIFIER - EXECUTE");
@@ -1136,7 +1137,7 @@ bool xe_svm_range_needs_migrate_to_vram(struct xe_svm_range *range, struct xe_vm
 	struct xe_vm *vm = range_to_vm(&range->base);
 	u64 range_size = xe_svm_range_size(range);
 
-	if (!range->base.pages.flags.migrate_devmem || !dpagemap)
+	if (!range->base.flags.migrate_devmem || !dpagemap)
 		return false;
 
 	xe_assert(vm->xe, IS_DGFX(vm->xe));
@@ -1248,7 +1249,7 @@ static int __xe_svm_handle_pagefault(struct xe_vm *vm, struct xe_vma *vma,
 
 	xe_svm_range_fault_count_stats_incr(gt, range);
 
-	if (ctx.devmem_only && !range->base.pages.flags.migrate_devmem) {
+	if (ctx.devmem_only && !range->base.flags.migrate_devmem) {
 		err = -EACCES;
 		goto out;
 	}
@@ -1623,7 +1624,7 @@ int xe_svm_alloc_vram(struct xe_svm_range *range, const struct drm_gpusvm_ctx *c
 	int err, retries = 1;
 	bool write_locked = false;
 
-	xe_assert(range_to_vm(&range->base)->xe, range->base.pages.flags.migrate_devmem);
+	xe_assert(range_to_vm(&range->base)->xe, range->base.flags.migrate_devmem);
 	range_debug(range, "ALLOCATE VRAM");
 
 	migration_state = drm_gpusvm_scan_mm(&range->base,
diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h
index 8a4d7134a9a..251a7266a73 100644
--- a/include/drm/drm_gpusvm.h
+++ b/include/drm/drm_gpusvm.h
@@ -109,9 +109,7 @@ struct drm_gpusvm_notifier {
 /**
  * struct drm_gpusvm_pages_flags - Structure representing a GPU SVM pages flags
  *
- * @migrate_devmem: Flag indicating whether the pages can be migrated to device memory
  * @unmapped: Flag indicating if the pages has been unmapped
- * @partial_unmap: Flag indicating if the pages has been partially unmapped
  * @has_devmem_pages: Flag indicating if the pages has devmem pages
  * @has_dma_mapping: Flag indicating if the pages has a DMA mapping
  * @__flags: Flags for pages in u16 form (used for READ_ONCE)
@@ -119,11 +117,8 @@ struct drm_gpusvm_notifier {
 struct drm_gpusvm_pages_flags {
 	union {
 		struct {
-			/* All flags below must be set upon creation */
-			u16 migrate_devmem : 1;
 			/* All flags below must be set / cleared under notifier lock */
 			u16 unmapped : 1;
-			u16 partial_unmap : 1;
 			u16 has_devmem_pages : 1;
 			u16 has_dma_mapping : 1;
 		};
@@ -151,6 +146,27 @@ struct drm_gpusvm_pages {
 	struct drm_gpusvm_pages_flags flags;
 };
 
+/**
+ * struct drm_gpusvm_range_flags - Range-level GPU SVM flags
+ *
+ * @migrate_devmem: Flag indicating whether the range can be migrated to device memory
+ * @unmapped: Flag indicating if the range has been unmapped
+ * @partial_unmap: Flag indicating if the range has been partially unmapped
+ * @__flags: All flags in u16 form (used for READ_ONCE)
+ */
+struct drm_gpusvm_range_flags {
+	union {
+		struct {
+			/* All flags below must be set upon creation */
+			u16 migrate_devmem	: 1;
+			/* All flags below must be set / cleared under notifier lock */
+			u16 unmapped		: 1;
+			u16 partial_unmap	: 1;
+		};
+		u16 __flags;
+	};
+};
+
 /**
  * struct drm_gpusvm_range - Structure representing a GPU SVM range
  *
@@ -160,6 +176,7 @@ struct drm_gpusvm_pages {
  * @itree: Interval tree node for the range (inserted in GPU SVM notifier)
  * @entry: List entry to fast interval tree traversal
  * @pages: The pages for this range.
+ * @flags: Flags for range see &struct drm_gpusvm_range_flags
  *
  * This structure represents a GPU SVM range used for tracking memory ranges
  * mapped in a DRM device.
@@ -171,6 +188,7 @@ struct drm_gpusvm_range {
 	struct interval_tree_node itree;
 	struct list_head entry;
 	struct drm_gpusvm_pages pages;
+	struct drm_gpusvm_range_flags flags;
 };
 
 /**
@@ -310,6 +328,8 @@ drm_gpusvm_range_find(struct drm_gpusvm_notifier *notifier, unsigned long start,
 		      unsigned long end);
 
 void drm_gpusvm_range_set_unmapped(struct drm_gpusvm_range *range,
+				   struct drm_gpusvm_pages *pages,
+				   unsigned int pages_count,
 				   const struct mmu_notifier_range *mmu_range);
 
 int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
-- 
2.34.1

