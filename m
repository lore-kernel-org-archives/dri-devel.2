Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7921C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 08:34:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35D5610E9D1;
	Tue, 30 Jun 2026 08:34:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="olZFd3YM";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012005.outbound.protection.outlook.com [52.101.43.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FEAB10EB51;
 Tue, 30 Jun 2026 08:34:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hpcRRULPJAYJVq7X4u+xIm2/v9k7rl9/CfGWowAn9lwuqm4xNhVppycX2EMLqyd9YtC4j4b6CEURtHVexyVHKQGG63Rl8bDG2Ym0utgSjKvr3mkU+tDi1oBKDlWcu8u94pv2RX9Q1UK6eonssVO2qeCh8CprjbxuXMqbcWvR8mssDp64bO2v4xiuwUt3IgCuKTumOPW5FQyaVoYGQd/hTAuJOvS6aDKRWAseDJU9bZesfJQp41gj0/eNWR4rFyOsYtM8unko0Dsb0ppa3wih9oA29I2XhafcYFS9nXFuk0KpQ+siavHRIHQf15rlNzkG1BtfgfC3sZ+Zop7pxZInsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVeYNXHEI/HhLk99IcJKXrGaDhBBm8lPk7O+B33lnWw=;
 b=GJ8vviTv2sxwTN9VnluHj4DkyG4jI9shTAtUNQxFnmKOUK9kqPlhBjsJUWziXZZiCVlbzMZTtZbjblHyIxmUDPkRnPkelDco6Cma4G/MvhKAIWsE8h1M1oKyCm7Qnii14Mlzs5fk6GDL6X38/c8S/JzhuHDzdbmJ+PLHGafnM2l+15oShSl0n1JKnl8uEOP4SqfFEc4IEzdnFi0F66x4CrCiXhvPEZzzvh0+uWTWC+3ZaKp4fqrtmkA1xs7FRg2N/fm2IsK1PgpDayAjSIB/6gPcDl3odxL4g3v3LBZsTDOTeCtCBBDCA5d3nbFPAVdea2BUETyyMkvsg4fGpokRag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVeYNXHEI/HhLk99IcJKXrGaDhBBm8lPk7O+B33lnWw=;
 b=olZFd3YM28e5wzQza65wCVMwSL4Zk0rM8DdyFCkXMlaT3ZTqogaTmYVaajUsUi8QaWDZR9fbkLJL4DC/05OB2J6iBlSyVnvs6aEdfTSE/rvS8YLjgcSViFdcjWBTh3wOV6M+mZJBGng962SPYZur4l2oxzTgsEXQZgNLgWqYbL8=
Received: from DM6PR03CA0099.namprd03.prod.outlook.com (2603:10b6:5:333::32)
 by SA1PR12MB999086.namprd12.prod.outlook.com (2603:10b6:806:49f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Tue, 30 Jun
 2026 08:33:56 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:5:333:cafe::a2) by DM6PR03CA0099.outlook.office365.com
 (2603:10b6:5:333::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 30
 Jun 2026 08:33:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 08:33:55 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 30 Jun
 2026 03:33:46 -0500
From: Honglei Huang <honghuan@amd.com>
To: <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>,
 <intel-xe@lists.freedesktop.org>
CC: <aliceryhl@google.com>, <Alexander.Deucher@amd.com>,
 <Felix.Kuehling@amd.com>, <Christian.Koenig@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [PATCH v9 1/5] drm/gpusvm: split MM state flags out of
 drm_gpusvm_pages_flags
Date: Tue, 30 Jun 2026 16:33:03 +0800
Message-ID: <20260630083307.381909-2-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260630083307.381909-1-honghuan@amd.com>
References: <20260630083307.381909-1-honghuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|SA1PR12MB999086:EE_
X-MS-Office365-Filtering-Correlation-Id: def12146-7ffa-46c1-f201-08ded68252f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|18002099003|22082099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: F/pO4BGdO1H/1Wa/KYE2VEJp9tMQx3Mpb+1/mG79XUu95A5FqnKDUtTCqsWBeyKf1ecA3T0H7HG2QZRgfo7nB0GeBRTroamXVLH0WqHaxIVeQgQDl0g+fEjKFWdztW86gL5HV+NheCU3feF3/mVd+FYH9Pf/wq7k2kTHoBUtlGgKfmxDO9OLwAviNvU6NL+IC/pG5N3NNcdSWMY4Vr9vP70+58/SOsasc5+PxSRYB7JPXaBw4hfPNsdtpe9Q0L4offV2xHXMWKeQkqH+2Ns+Ff5HnIXxAKpq1n5nr56mgllEhvJp9gn1XT3f64YRjtQYTCGTp32tlXPe3dD9LKg2+0OwCLUdW6nIaxPHl2xTRbFEt8v8g50a3r5Ac1ZEVWdhOWsFwbhKq7BZ8tXYNDf9IygpiqCUi5XfqTTWu0Qt6wiVmK74cLHONYZ2WxlUkc2n1jsIz8yeKihtO07unHO80Z+K2y8Wgc1evX3+z9uAGgJLI5Di1TqCirEg2+eZFAqQyw843ViyWvDVxsGdQEwt5c4/DB+okYKjjG7ZAEl9GKWka0QzCsBIEt/fEb0orZY56rnF+VCrLR/8XvmYxgP0Vy1VfkeqQsm+Cfq86FJS6CYT6Aexw9ZfTgIOxyxjdYRfaPZ4Xy52/0UCO6bJpQTA9Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(18002099003)(22082099003)(6133799003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AVYn3cJa2Btk1JDzo10XI3rxYVmcziPNKho+SZvd/BVx23G5/BRqIGDDXjFWcrGQgtze95SAGmc81PCU9SfdOsepaO8SZgxonX62eLgdTNbUE0HRrkF+2bCtZs3ZndPRcnSwcf/GvLPcwIptLViqMDTmvkLyB9vIKjA2xGK6E/Z7Adt/TghvvZH5qzms4ixR7++T/DOwOnFkbZrqTQBCPhVz1HnBOLQ095Zt8e3faFH5LO7e01Sqf1nKK8ZdwRZnc1BpJjvKJT6+IC/ro3BHG5pEHHydajQPoCitl5qfpLvNzUxoXurcRUIthyC4oP7Ji+MfmPeyLbpl7JDOgwEVqKqyj+wkQ47wPMB5DlDYl4O5TDUj81Wj5dNx2yqkoNS2F53St8xFILNy30Crq7PAVwYalrl0+AbrR0npCOiq2E7Z/2FPs4ybTkbWwtQ3KbRg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 08:33:55.8782 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: def12146-7ffa-46c1-f201-08ded68252f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999086
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

Like drm_gpusvm_pages_flags, drm_gpusvm_range_flags unions its bits with
a u16 __flags member. Build the new value in a local copy and publish it
with a single WRITE_ONCE() on __flags, and have the lockless readers use
READ_ONCE(), so concurrent bitfield access stays data-race free and KCSAN
quiet.

Suggested-by: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Link: https://gitlab.freedesktop.org/mbrost/xe-kernel-driver-svn-perf-6-15-2025/-/commit/623f6a50c037d9e44f6c9fbe6859a0ba7ad50177
Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/drm_gpusvm.c | 26 +++++++++++++++++++++++---
 drivers/gpu/drm/xe/xe_svm.c  | 18 +++++++++++++-----
 include/drm/drm_gpusvm.h     | 30 +++++++++++++++++++++++++-----
 3 files changed, 61 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
index 958cb605aed..abdfdaaf5e2 100644
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
@@ -1784,20 +1784,40 @@ EXPORT_SYMBOL_GPL(drm_gpusvm_has_mapping);
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
+	struct drm_gpusvm_range_flags range_flags = {
+		.__flags = range->flags.__flags,
+	};
+	unsigned int i;
+
 	lockdep_assert_held_write(&range->gpusvm->notifier_lock);
 
-	range->pages.flags.unmapped = true;
+	range_flags.unmapped = true;
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
+		range_flags.partial_unmap = true;
+	/* WRITE_ONCE pairs with READ_ONCE for opportunistic checks */
+	WRITE_ONCE(range->flags.__flags, range_flags.__flags);
 }
 EXPORT_SYMBOL_GPL(drm_gpusvm_range_set_unmapped);
 
diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
index b1e1ac26c66..e8b7a51e67f 100644
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
@@ -1135,8 +1136,12 @@ bool xe_svm_range_needs_migrate_to_vram(struct xe_svm_range *range, struct xe_vm
 {
 	struct xe_vm *vm = range_to_vm(&range->base);
 	u64 range_size = xe_svm_range_size(range);
+	struct drm_gpusvm_range_flags flags = {
+		/* READ_ONCE pairs with WRITE_ONCE in drm_gpusvm_range_set_unmapped() */
+		.__flags = READ_ONCE(range->base.flags.__flags),
+	};
 
-	if (!range->base.pages.flags.migrate_devmem || !dpagemap)
+	if (!flags.migrate_devmem || !dpagemap)
 		return false;
 
 	xe_assert(vm->xe, IS_DGFX(vm->xe));
@@ -1220,6 +1225,7 @@ static int __xe_svm_handle_pagefault(struct xe_vm *vm, struct xe_vma *vma,
 	struct xe_validation_ctx vctx;
 	struct drm_exec exec;
 	struct xe_svm_range *range;
+	struct drm_gpusvm_range_flags range_flags;
 	struct dma_fence *fence;
 	struct drm_pagemap *dpagemap;
 	struct xe_tile *tile = gt_to_tile(gt);
@@ -1248,7 +1254,9 @@ static int __xe_svm_handle_pagefault(struct xe_vm *vm, struct xe_vma *vma,
 
 	xe_svm_range_fault_count_stats_incr(gt, range);
 
-	if (ctx.devmem_only && !range->base.pages.flags.migrate_devmem)
+	/* READ_ONCE pairs with WRITE_ONCE in drm_gpusvm_range_set_unmapped() */
+	range_flags.__flags = READ_ONCE(range->base.flags.__flags);
+	if (ctx.devmem_only && !range_flags.migrate_devmem)
 		return -EACCES;
 
 	if (xe_svm_range_is_valid(range, tile, ctx.devmem_only, dpagemap)) {
@@ -1621,7 +1629,7 @@ int xe_svm_alloc_vram(struct xe_svm_range *range, const struct drm_gpusvm_ctx *c
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

