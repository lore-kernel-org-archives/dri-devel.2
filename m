Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F4F1C43458
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 11:15:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C9D810E5C0;
	Sun, 28 Jun 2026 11:15:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H7uRxwdm";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011004.outbound.protection.outlook.com [52.101.62.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D488410E5C0;
 Sun, 28 Jun 2026 11:15:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mFMRrHI09PS0Ja1HLDuw/0NAtiqIQsq0MQRiK9yUuRBWFC7TfEEXHe84800kgVpfRlR1nsl1FgH8wdLzn7NB4hjuYSNbmSjAeBuoJJWkFb63aLC1shjOE6OTNct4dSlef66DGkzv23BnWJUrH1lhJ7SIJmmZvJclilhTsi13RAUm73ixeGrPibSgputnnm5PHapAHocsvzbaLyPH67ahlXVeZfeD3wivRjYVaiXY4sp1fBy+cltor7kUmalITD0rMtp/SNr646eQupkMBzjmxgU+2kw8TM6/0FnqibNkSaVwqRV16wuJYfhyB2A7kTKPasXRSIoK56++b5ECuOQbjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FRBSL5LKYywVO1J9510bQzW9Y8XIj/a6CPMZcvzkY9M=;
 b=RzmAmLNw8JUCAwsTylwY2/HUSZNlGdRDXiCrsT5gjAw1TbzcIuntkrzDg3wRCdMe+YGcUVvJ4CWHswk0EcqK3CgHewo0SRNhbz28rzixKc94UnMNus3WzeSxhJyM9r/SsjdhIlEImEkRrBcQ4g46oR353zODxK60EcYiogLdzmblYlI25N9+QD9zX2LRA1P9xET+3TkuK/NFLglWzLjhka0064mWcIRPwtxPuvIi6v+5klrc1Fktj7F+EzbUquvJQS2MaBSbo9ZmaEl6087jRW0bX8PI7ybkW7wqO77iuF72a74ZpO5VxSssj8f3hZ7fPcUhHFJoWSO6IAG8yut1SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRBSL5LKYywVO1J9510bQzW9Y8XIj/a6CPMZcvzkY9M=;
 b=H7uRxwdmIZDI2e8Jq66q3UXTOiBZPYt911QDL1ZRHTbCYrM2fIhL2gk6NdWNruVegMBkvu6DBJhpevCMXFFAu+VCuomod0RQnEKmqBOjJaYL/Kr5vYgfDlQxJhKfXO7PDNFLpZA1kzjNkSQmNsdA1qHLMgW9+G9pfdxhCQTdjac=
Received: from IA4P221CA0004.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:559::12)
 by CY8PR12MB7433.namprd12.prod.outlook.com (2603:10b6:930:53::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Sun, 28 Jun
 2026 11:15:21 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:559:cafe::1c) by IA4P221CA0004.outlook.office365.com
 (2603:10b6:208:559::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Sun,
 28 Jun 2026 11:15:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Sun, 28 Jun 2026 11:15:21 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 28 Jun
 2026 06:15:17 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>,
 <intel-xe@lists.freedesktop.org>
CC: <aliceryhl@google.com>, <Alexander.Deucher@amd.com>,
 <Felix.Kuehling@amd.com>, <Christian.Koenig@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [PATCH v7 1/5] drm/gpusvm: split MM state flags out of
 drm_gpusvm_pages_flags
Date: Sun, 28 Jun 2026 19:14:51 +0800
Message-ID: <20260628111455.9831-2-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260628111455.9831-1-honglei1.huang@amd.com>
References: <20260628111455.9831-1-honglei1.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|CY8PR12MB7433:EE_
X-MS-Office365-Filtering-Correlation-Id: 30ccc6a6-9339-4975-828b-08ded5068b38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|22082099003|56012099006|18002099003|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info: io+ksU3QqxUrxnTECp/Q5AItfmkOrgW+eARrvA+UgcPqYzaCB5wy+DDSloY+9sNMCeyzPsZYA8w+bulp00OHijsJ74z5H4GbZMH86+NUZIouAaOZGYRNNVothrPO5vJIC3ARxkF5UQwUC6uZHw0DZlH6oUPqwzVvRX47jPs5JVm6e8qq7aZvEV5ULzXUfi6E2v9ZA2OvWWNBXCBrjjfY2JckNMPxW/t6EbTwTZlCFis969JXDhQbjzpXMSZA+hSW/m5MdQsh7meSVmZb9jZn4oZaeVRAP6pLPDZ0aAbNNviKKUyA5y9kPiXIvJCWLJv1k3f7iurEqt89nliIr9rCjt7JG5WIQEcTO0Wjo7veYflHxHjQtdduFzlMJ2dIUZqNYZ/hSLWo9jVzwzwabU60nk/Nb0WvUZrU1oPBFFNwJ6pA0Im9yNI6kUNTvohFwHJOjz1luFzcgBwoC4vEkqUiwmeIhvGLehdgWnV7TzxDc/bQxS42b0KKNiokys/5jVx2mlDev2ROS1nHHup2Lc1ywAglinY6nczH7LGBqG/pPf+IFV2xXEmtinI9YjRFLHlL7YbDUV0Liqb8+JlWYo8ENKpQIf+mnURQ300Ay4lzX4PyWgNBZhehoAl/YlentrKU58r2NeMgXpBPeQ7B6gSwPw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(22082099003)(56012099006)(18002099003)(6133799003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: u3xPaV/3dDZJrqcaCdTX68qigKGsUJUY3mYNix96jN5WbQmnoC8GI6Td2AOp9TQpjQIyG83oXBi3yq5QfkjNsZ0EWktqykGRJ9GJxylroIn1FtAsjzCFf/naIjXBeypwN4QcY6ZyMd2uhAabhooMwxO2d+qglnVcQufbT5QI58TKKnNWeadkGLZEA7D2ke5NolzhXXPHVaMulktBiEkW1cD8MTHHFEnRXuWnmQ1OILV/1eGfoRjW2OSt128Tu0VA/x+Jz43I47CuKjZN/fTS56aDJJiytunZgYxkK9iKbhrd2c5/drLs3EnzaLGb6ClYfNBZoGI5Xm41OrxpFHKF//jsHCiEnt05XUO1396c6/XcIJq8Q7Dt58XNcww4yl3tSwE1FAuq1SYruRMNRK/LxDMmxvFzgp1PASIOjFqeP0DuSMygDjmVmRzS1LnNO7Rz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2026 11:15:21.5008 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30ccc6a6-9339-4975-828b-08ded5068b38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7433
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

