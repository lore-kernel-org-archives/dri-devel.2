Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 056B5C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 12:11:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CEC810E8D8;
	Mon, 20 Jul 2026 12:11:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2+8uUCoe";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012054.outbound.protection.outlook.com [40.107.209.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D743510E8D7;
 Mon, 20 Jul 2026 12:11:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cH8mRwbJwZepmu0Lb9FR8nGx1/jpaTYaIrDZq8/SjruGFgLrri08MOwWvm48lxYWm8c/Y+e6m4BXPqb3pAAZJuNKw6c6g+6UWst6XJlvl43qt6jLUepr5NJi63ctNTnAek98B2PFpc1hghezpDrxCUb4Iw+awSnVqIkACWDfZWyyH8M3Xpb1v1PcQs2xw+ZZMITU+nALt5g23GBkxyO5oIZ8R/mGQdfwgFdOJP75ijefkC6YFaq0OeiCCLPEuFBpH6yPFoQ43743cRE+KM9EJQP6mXHWwtekrWL7R7qQ6yTmuuaLXeLt2xJfshwIh+BHstuB0Z4+w0DKJ9Hy3NJtTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3UrivU1va+7whzpFC7QtF6hcJpW7zHlVraBH0Z94YIQ=;
 b=pI5vzMATgV+/Y1WH2f0O/vCzVarCO1pntcIx5ZoJpKn/v1X+Qo2AlNM+S34okE8jvH7BqZOWbbQUgnqyxaijiPyYBSD8/lR6wgvFrT/20d9msAWaTFnj+KpjGuNvkZzbcc+YUPRlOjuro3/JelmxuET4PD/sCfSompT3WRkQPdL/8+1xNjXOr80fzeaQb6bGtU91TDf7V75KLdJnIINJMUgwYEXb+Ln0XwhRH15fd8NjaErOmABtRVKI2S8TYogyaVrBrT4+5+vSpeXI2TR06FPw5S48NiixE57L9A6MkIeTM2knFNOvoKW9fsT4+e2Gawx4vfeNLOadMrmgQDbFhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3UrivU1va+7whzpFC7QtF6hcJpW7zHlVraBH0Z94YIQ=;
 b=2+8uUCoevyxWhkp46fy2xC3m9A63NpW7Deek9TNIH0v/Wll1aQyFATHpfTKwwzNgMjZePD6We2ProO5ym5Sb9jkc3Hl1VU8A0LPkPhBR67dEqQUmgUDySDOkNMLWRsVPdXFR16T/lH7ksJ5bNHgl9YsO9/vVk7RtzV0Q3Z5WVHw=
Received: from PH7P220CA0069.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::18)
 by DM4PR12MB5986.namprd12.prod.outlook.com (2603:10b6:8:69::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Mon, 20 Jul
 2026 12:11:03 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:510:32c:cafe::82) by PH7P220CA0069.outlook.office365.com
 (2603:10b6:510:32c::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.18 via Frontend Transport; Mon,
 20 Jul 2026 12:11:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Mon, 20 Jul 2026 12:11:03 +0000
Received: from arun-nv33.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 20 Jul
 2026 07:10:58 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <matthew.auld@intel.com>, <christian.koenig@amd.com>,
 <dri-devel@lists.freedesktop.org>, <intel-gfx@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, Arunpravin Paneer Selvam
 <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v6 1/2] gpu/buddy: replace dual-tree/force_merge with
 decoupled dirty tracker
Date: Mon, 20 Jul 2026 17:40:40 +0530
Message-ID: <20260720121041.339981-1-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|DM4PR12MB5986:EE_
X-MS-Office365-Filtering-Correlation-Id: f62671fa-2d6d-4e2c-7c5e-08dee657f82b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|1800799024|36860700016|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: oCvS6tvshCIxWN0kdLvBUiZljfuHOnoFr5UBpauhMq79G8362AHsSRdXGiKisEC+KVUJkNOhsjzgnciVtepLMRLsOqMU68Xxs5JS1xw06rCIk+6E9Kw/YZnRn/OqVrLHwBoNqo+f5E6IKmJFEfn80hs40ORWZxJ1fx5kWevahr+J1sMNB0hEGY75j9x8RGABhLMw0DiSeRdNiY7szTagHWlBKzSvFg5MHMExNxRPr5VIuRhBSkN6uUIkzSHtDKO8RLv3V3dOaTInOSPLUniK0jIWGRJ894G9a0h/KZLMr4FCGPFB+iObhoPOFlTyme6YcYGw0VOOXl0AxKewukz/TJaddjFaHCQgURxsIxScxntRCGH4uK6cFcPP3spjtVu4f5kAEddYi1sIeGNqItJHKZtpthjT40QnwC82kAsz9m+HKVxqsEOK4htqXaMZTdKOMa5Q/vpBcbYd97uBVQYvPnLWNYLK2wfDC3q2oT7Izy9n9RcEOp9VeKTEtCQMx18tFTNDigE3el2TZ6+RfSsTVilTZkrhtRBGEB3o4itFmrwt3sOb0aO42Y7OCFyvkJGHnDCjwyqU67J3nCy4eTanjI59ey5mYrEzexEx6xOfcKuDNBv8o/fFcPKi+e3/mxdw/qoa8E786VtbrtJiv0OCjxMgVqM8ziurFjX5Wpd29yfWS3wHWjnk4eklhnANKg3vTy4TmMKrPfX0ISfbMOt+9A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(56012099006)(11063799006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XWAZr8Jf2BAPL8uMgNnkcbynPvxHdF8nqNpwaWDc+WJLQSCrEZKYRZREdIrsU38W0jmEeu7Bc754u1hzgpkDQ7g7F8SaYe36hFpiW1DRWSoOxgVVbviDA6mpeptwOsI3bL9PwEI1dNzwnZfSRO/zeWgcgarNLvXnR9ANpZXfs4986IiO0ppYCe1TCJODei4NLNG5UL4Xuf8fK4EBClv5x8xvBPEBVHOdpUgHoGVU7zQpxe5Yem6r4eb07rSt7qNTgCc95fWO3iKdiDmbmbuYXnsvWMbuzlGQ9utb9q93GHA3TEmt7ZFJZVRM0UguRssE9J8ZADJ8V5VovQyuw27OoB2XgfTFc+ZmkWmR2YIMaVi11zXZNJdvRzbqpm/nC8uk/7xDsVWTWnXyaCSkPf61Z1Cf852toumOzzMjLXE5MpAcXzsj61ILjuUKfz7oErLd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 12:11:03.2460 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f62671fa-2d6d-4e2c-7c5e-08dee657f82b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5986
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

The current buddy allocator maintains separate clear_tree[] and
dirty_tree[] rbtrees per order, preventing coalescing between cleared
and dirty buddies. Under mixed workloads, this creates a merge barrier:
adjacent buddies frequently end up split across trees, forcing reliance
on __force_merge() during allocation.

__force_merge() performs an O(N x max_order) scan under the VRAM manager
lock, leading to allocation stalls and failures for large contiguous
requests even when sufficient total free memory is available.

Solution

Replace the dual-tree design with:
- A single free_tree[order] rbtree for dirty and mixed free blocks
  (fully cleared free blocks float outside this tree)
- A lightweight out-of-band dirty tracker (gpu_dirty_tracker)

Fully cleared free blocks are tracked outside the buddy trees using an
augmented interval rbtree, enabling O(log E) lookup of the largest
cleared extents.

Buddy coalescing is now unconditional in __gpu_buddy_free(), regardless
of clear/dirty state. This removes the merge barrier and eliminates the
need for __force_merge().

Benefits

- Correct high-order allocations after mixed clear/dirty workloads
- Elimination of O(N x max_order) merge cost from the allocation path
- O(log E) cleared-extent lookup replacing O(N) scans
- Predictable allocation latency under fragmentation
- Reduced complexity with a single tree per order

Test:
dEQP-VK.memory.allocation.basic.size_8KiB.reverse.count_4000

Below data is from /sys/kernel/debug/dri/1/amdgpu_vram_mm:

Base (dual-tree), before VKCTS test:
  order- 6 free:   6 MiB,  blocks: 26
  order- 5 free:   1 MiB,  blocks: 15
  order- 4 free: 960 KiB,  blocks: 15
  order- 3 free:   5 MiB,  blocks: 171
  order- 2 free:   2 MiB,  blocks: 176
  order- 1 free:   1 MiB,  blocks: 165
  order- 0 free:  16 KiB,  blocks: 4

Base (dual-tree), after VKCTS test:
  order- 6 free: 768 KiB,  blocks: 3
  order- 5 free: 499 MiB,  blocks: 3999
  order- 4 free: 250 MiB,  blocks: 4001
  order- 3 free: 129 MiB,  blocks: 4157
  order- 2 free:  65 MiB,  blocks: 4161
  order- 1 free:  63 MiB,  blocks: 8138
  order- 0 free:  20 KiB,  blocks: 5

Dirty tracker, before VKCTS test:
  order- 6 free:   4 MiB,  blocks: 19
  order- 5 free:   2 MiB,  blocks: 18
  order- 4 free: 704 KiB,  blocks: 11
  order- 3 free:   5 MiB,  blocks: 168
  order- 2 free:   2 MiB,  blocks: 174
  order- 1 free:   1 MiB,  blocks: 167
  order- 0 free:  32 KiB,  blocks: 8

Dirty tracker, after VKCTS test:
  order- 6 free:   4 MiB,  blocks: 19
  order- 5 free:   2 MiB,  blocks: 18
  order- 4 free: 704 KiB,  blocks: 11
  order- 3 free:   5 MiB,  blocks: 168
  order- 2 free:   2 MiB,  blocks: 174
  order- 1 free:   1 MiB,  blocks: 167
  order- 0 free:  28 KiB,  blocks: 7

v2:
 - Code-style cleanup and minor refactoring
 - Renamed locals for clarity

v3:
 - Keep cleared blocks inside free_tree[] instead of floating them.
 - Add subtree_has_dirty rbtree augment for O(log N) dirty-first walk.

v4:
 - Fixed checkpatch warnings.
 - Optimized gpu_buddy_reset_clear() to a single post-order walk that
   flips block headers and recomputes the rbtree augment in one pass.
 - Propagate subtree_max_size top-down in insert_extent() so ancestors
   are not left with stale values on no-rotation inserts. (sashiko)
 - Drop the whole extent in gpu_dirty_tracker_mark_dirty() when the
   inside-split allocation fails, avoiding a stale clear claim. (sashiko)
 - Make gpu_dirty_tracker_find() alignment-aware and fall back to the
   dirty tree on steered failure to avoid spurious -ENOSPC. (sashiko)

v5:
 - Track dirty extents instead of cleared ones: steer dirty allocs onto
   tracked dirty windows and pick clear allocs via a free-tree augment,
   avoiding clear-memory wastage by keeping cleared free blocks untouched
   during dirty allocation.

v6:
 - Make __alloc_range_bias() return the highest/right-most address by
   default, establishing top-down as the intended placement for
   range-biased allocations.
 - Honour GPU_BUDDY_CLEAR_ALLOCATION in __alloc_range_bias() by steering
   the descent towards clear subtrees for non-top-down clear
   requests. (sashiko)
 - Skip dirty-tracker steering for offset-aligned requests so they keep
   their min_block_size alignment. (sashiko)
 - sashiko reported that the __GFP_NOFAIL dirty-extent allocations on
   the free path could deadlock during memory reclaim, since that is a
   GFP_KERNEL allocation on the free path; move to a per-tracker
   mempool so extent nodes are guaranteed without __GFP_NOFAIL.
   (sashiko)
 - Derive each free block's clear/dirty class from the blocks already
   in hand on split, free, alloc, trim and init instead of querying the
   dirty tracker, removing the tracker lookups from the hot paths.

Assisted-by: Claude:claude-opus-4-8
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/buddy.c                | 1282 ++++++++++++++++++++--------
 drivers/gpu/tests/gpu_buddy_test.c |   32 +-
 include/linux/gpu_buddy.h          |   83 +-
 3 files changed, 985 insertions(+), 412 deletions(-)

diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
index dc81fe0301ce..755a0b9e4745 100644
--- a/drivers/gpu/buddy.c
+++ b/drivers/gpu/buddy.c
@@ -8,6 +8,7 @@
 #include <linux/kmemleak.h>
 #include <linux/module.h>
 #include <linux/sizes.h>
+#include <linux/slab.h>
 
 #include <linux/gpu_buddy.h>
 
@@ -34,6 +35,418 @@
 #endif
 
 static struct kmem_cache *slab_blocks;
+static struct kmem_cache *slab_extents;
+
+#define GPU_DIRTY_EXTENT_POOL_MIN 1
+
+enum gpu_block_state {
+	GPU_BLOCK_CLEAR,
+	GPU_BLOCK_MIXED,
+	GPU_BLOCK_DIRTY,
+};
+
+/*
+ * Dirty tracker
+ * -------------
+ *
+ * The dirty tracker maintains an augmented interval rbtree of contiguous
+ * dirty address ranges, decoupled from the buddy free trees.
+ * Each node covers a maximal coalesced run; adjacent extents are merged
+ * on insertion so the tree always holds the smallest possible number of
+ * extents.  The augmentation field @subtree_max_size lets the allocator
+ * locate the largest dirty extent in O(log E).
+ *
+ * Free trees (mm->free_tree[])
+ * ----------------------------
+ *
+ * Per-order augmented rbtrees of FREE buddy blocks, keyed by offset.
+ * Every node carries:
+ *   - subtree_max_alignment: largest natural alignment in the subtree,
+ *     used by aligned/range allocations to skip unsuitable subtrees in
+ *     O(log N).
+ *   - subtree_has_clear: a clear or mixed block exists in the
+ *     subtree.
+ *
+ * Block classes
+ * -------------
+ *
+ * Each FREE block falls into one of three classes, determined in
+ * mark_free() by querying the dirty tracker for the block's range:
+ *
+ *   clear   -- HEADER_CLEAR set; no dirty extent overlaps the range.
+ *   mixed   -- HEADER_CLEAR unset; range has both dirty and clear bytes.
+ *   dirty   -- HEADER_CLEAR unset; range is fully dirty.
+ *
+ * Clear allocation fallback order
+ * -------------------------------
+ *
+ * For a clear (CLEAR_ALLOCATION) request, the allocator walks the free
+ * trees in this order:
+ *
+ *     clear -> mixed -> dirty
+ *
+ * A single augment bit subtree_has_clear (set for any block that is not
+ * fully dirty) drives rbtree_last_clear_free_block() in O(log N).
+ */
+
+static u64 extent_size(struct gpu_dirty_extent *dirty_extent)
+{
+	return dirty_extent->end - dirty_extent->start;
+}
+
+RB_DECLARE_CALLBACKS_MAX(static, gpu_dirty_augment_cb,
+			 struct gpu_dirty_extent, rb,
+			 u64, subtree_max_size,
+			 extent_size)
+
+static struct gpu_dirty_extent *extent_alloc(struct gpu_dirty_tracker *dirty_tracker)
+{
+	struct gpu_dirty_extent *dirty_extent;
+
+	dirty_extent = mempool_alloc(dirty_tracker->extent_pool, GFP_KERNEL);
+
+	return dirty_extent;
+}
+
+static void extent_free(struct gpu_dirty_tracker *dirty_tracker,
+			struct gpu_dirty_extent *dirty_extent)
+{
+	mempool_free(dirty_extent, dirty_tracker->extent_pool);
+}
+
+/* Return the rightmost extent whose start is strictly below @offset. */
+static struct gpu_dirty_extent *
+prev_extent(struct gpu_dirty_tracker *dirty_tracker, u64 offset)
+{
+	struct rb_node *rb = dirty_tracker->root.rb_node;
+	struct gpu_dirty_extent *dirty_extent = NULL;
+
+	while (rb) {
+		struct gpu_dirty_extent *tmp_extent =
+			rb_entry(rb, struct gpu_dirty_extent, rb);
+
+		if (tmp_extent->start < offset) {
+			dirty_extent = tmp_extent;
+			rb = rb->rb_right;
+		} else {
+			rb = rb->rb_left;
+		}
+	}
+
+	return dirty_extent;
+}
+
+/* Return the leftmost extent whose start is at or above @offset. */
+static struct gpu_dirty_extent *
+next_extent(struct gpu_dirty_tracker *dirty_tracker, u64 offset)
+{
+	struct rb_node *rb = dirty_tracker->root.rb_node;
+	struct gpu_dirty_extent *dirty_extent = NULL;
+
+	while (rb) {
+		struct gpu_dirty_extent *tmp_extent =
+			rb_entry(rb, struct gpu_dirty_extent, rb);
+
+		if (tmp_extent->start >= offset) {
+			dirty_extent = tmp_extent;
+			rb = rb->rb_left;
+		} else {
+			rb = rb->rb_right;
+		}
+	}
+
+	return dirty_extent;
+}
+
+static void insert_extent(struct gpu_dirty_tracker *dirty_tracker,
+			  struct gpu_dirty_extent *dirty_extent)
+{
+	struct rb_node **link = &dirty_tracker->root.rb_node;
+	struct rb_node *parent = NULL;
+	u64 size = extent_size(dirty_extent);
+
+	while (*link) {
+		struct gpu_dirty_extent *tmp_extent;
+
+		parent = *link;
+		tmp_extent = rb_entry(parent, struct gpu_dirty_extent, rb);
+
+		if (tmp_extent->subtree_max_size < size)
+			tmp_extent->subtree_max_size = size;
+
+		if (dirty_extent->start < tmp_extent->start)
+			link = &parent->rb_left;
+		else
+			link = &parent->rb_right;
+	}
+
+	dirty_extent->subtree_max_size = size;
+	rb_link_node(&dirty_extent->rb, parent, link);
+	rb_insert_augmented(&dirty_extent->rb, &dirty_tracker->root, &gpu_dirty_augment_cb);
+}
+
+static void remove_extent(struct gpu_dirty_tracker *dirty_tracker,
+			  struct gpu_dirty_extent *dirty_extent)
+{
+	rb_erase_augmented(&dirty_extent->rb, &dirty_tracker->root, &gpu_dirty_augment_cb);
+	RB_CLEAR_NODE(&dirty_extent->rb);
+}
+
+static int gpu_dirty_tracker_init(struct gpu_dirty_tracker *dirty_tracker)
+{
+	dirty_tracker->root = RB_ROOT;
+	dirty_tracker->total_dirty = 0;
+
+	dirty_tracker->extent_pool =
+		mempool_create_slab_pool(GPU_DIRTY_EXTENT_POOL_MIN, slab_extents);
+	if (!dirty_tracker->extent_pool)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void gpu_dirty_tracker_empty(struct gpu_dirty_tracker *dirty_tracker)
+{
+	struct rb_node *rb;
+
+	while ((rb = rb_first(&dirty_tracker->root))) {
+		struct gpu_dirty_extent *dirty_extent =
+			rb_entry(rb, struct gpu_dirty_extent, rb);
+
+		remove_extent(dirty_tracker, dirty_extent);
+		extent_free(dirty_tracker, dirty_extent);
+	}
+
+	dirty_tracker->total_dirty = 0;
+}
+
+static void gpu_dirty_tracker_fini(struct gpu_dirty_tracker *dirty_tracker)
+{
+	gpu_dirty_tracker_empty(dirty_tracker);
+	mempool_destroy(dirty_tracker->extent_pool);
+	dirty_tracker->extent_pool = NULL;
+}
+
+/*
+ * Mark the range [start, start + size] as dirty. Merge with the neighbour on
+ * each side if they are contiguous, so the tree never holds two adjacent ranges.
+ */
+static void gpu_dirty_tracker_mark_dirty(struct gpu_dirty_tracker *dirty_tracker,
+					 u64 start, u64 size)
+{
+	struct gpu_dirty_extent *left, *right, *dirty_extent;
+	u64 end = start + size;
+
+	if (!size)
+		return;
+
+	/* Find contiguous neighbours, if any. */
+	left = prev_extent(dirty_tracker, start);
+	if (left && left->end != start)
+		left = NULL;
+
+	right = next_extent(dirty_tracker, end);
+	if (right && right->start != end)
+		right = NULL;
+
+	if (left && right) {
+		/* Merge left + new + right into a single extent. */
+		remove_extent(dirty_tracker, left);
+		remove_extent(dirty_tracker, right);
+		left->end = right->end;
+		extent_free(dirty_tracker, right);
+		insert_extent(dirty_tracker, left);
+	} else if (left) {
+		/* Extend left neighbour rightwards. */
+		remove_extent(dirty_tracker, left);
+		left->end = end;
+		insert_extent(dirty_tracker, left);
+	} else if (right) {
+		/* Extend right neighbour leftwards. */
+		remove_extent(dirty_tracker, right);
+		right->start = start;
+		insert_extent(dirty_tracker, right);
+	} else {
+		/* Standalone extent. */
+		dirty_extent = extent_alloc(dirty_tracker);
+		dirty_extent->start = start;
+		dirty_extent->end   = end;
+		insert_extent(dirty_tracker, dirty_extent);
+	}
+
+	dirty_tracker->total_dirty += size;
+}
+
+/*
+ * Remove the range [start, start + size] from the dirty tracker. Punch the
+ * range out of every overlapping dirty extent, splitting one extent in two if
+ * the removed range falls strictly inside it.
+ */
+static void gpu_dirty_tracker_remove_range(struct gpu_dirty_tracker *dirty_tracker,
+					   u64 start, u64 size)
+{
+	struct gpu_dirty_extent *dirty_extent, *next;
+	u64 end = start + size;
+
+	if (!size)
+		return;
+
+	dirty_extent = prev_extent(dirty_tracker, start + 1);
+	if (!dirty_extent)
+		dirty_extent = next_extent(dirty_tracker, start);
+
+	while (dirty_extent && dirty_extent->start < end) {
+		struct rb_node *next_node = rb_next(&dirty_extent->rb);
+		u64 extent_start = dirty_extent->start;
+		u64 extent_end = dirty_extent->end;
+
+		if (next_node)
+			next = rb_entry(next_node, struct gpu_dirty_extent, rb);
+		else
+			next = NULL;
+
+		/* Skip a non-overlapping neighbour returned by prev_extent(). */
+		if (extent_end <= start) {
+			dirty_extent = next;
+			continue;
+		}
+
+		if (extent_start < start && extent_end > end) {
+			/*
+			 * Removed range lies strictly inside this dirty extent:
+			 * split it into the dirty left and right halves.
+			 */
+			struct gpu_dirty_extent *right = extent_alloc(dirty_tracker);
+
+			remove_extent(dirty_tracker, dirty_extent);
+
+			dirty_extent->end = start;
+			right->start = end;
+			right->end   = extent_end;
+
+			insert_extent(dirty_tracker, dirty_extent);
+			insert_extent(dirty_tracker, right);
+
+			dirty_tracker->total_dirty -= size;
+		} else if (extent_start >= start && extent_end <= end) {
+			/* Extent fully covered: drop it. */
+			remove_extent(dirty_tracker, dirty_extent);
+			extent_free(dirty_tracker, dirty_extent);
+
+			dirty_tracker->total_dirty -= (extent_end - extent_start);
+		} else if (extent_start < start) {
+			/* Extent overlaps from the left: trim its right end. */
+			remove_extent(dirty_tracker, dirty_extent);
+			dirty_extent->end = start;
+			insert_extent(dirty_tracker, dirty_extent);
+
+			dirty_tracker->total_dirty -= (extent_end - start);
+		} else {
+			/* Extent overlaps from the right: trim its left end. */
+			remove_extent(dirty_tracker, dirty_extent);
+			dirty_extent->start = end;
+			insert_extent(dirty_tracker, dirty_extent);
+
+			dirty_tracker->total_dirty -= (end - extent_start);
+		}
+
+		dirty_extent = next;
+	}
+}
+
+static enum gpu_block_state
+gpu_query_block_state(struct gpu_dirty_tracker *dirty_tracker,
+		      u64 start, u64 size)
+{
+	struct gpu_dirty_extent *dirty_extent;
+	u64 end = start + size;
+
+	dirty_extent = prev_extent(dirty_tracker, start + 1);
+	if (dirty_extent) {
+		if (dirty_extent->start <= start && dirty_extent->end >= end)
+			return GPU_BLOCK_DIRTY;
+		if (dirty_extent->start < end && dirty_extent->end > start)
+			return GPU_BLOCK_MIXED;
+	}
+
+	dirty_extent = next_extent(dirty_tracker, start);
+	if (dirty_extent && dirty_extent->start < end)
+		return GPU_BLOCK_MIXED;
+
+	return GPU_BLOCK_CLEAR;
+}
+
+static struct rb_node *
+dirty_tracker_descend_right(struct rb_node *node, u64 min_size)
+{
+	while (node->rb_right) {
+		struct gpu_dirty_extent *tmp_extent;
+
+		tmp_extent = rb_entry(node->rb_right, struct gpu_dirty_extent, rb);
+
+		if (tmp_extent->subtree_max_size < min_size)
+			break;
+		node = node->rb_right;
+	}
+
+	return node;
+}
+
+static struct gpu_dirty_extent *
+gpu_dirty_tracker_find(struct gpu_dirty_tracker *dirty_tracker,
+		       u64 min_size, u64 *aligned_start_out)
+{
+	struct rb_node *rb = dirty_tracker->root.rb_node;
+	struct gpu_dirty_extent *root_extent;
+	struct rb_node *parent;
+
+	if (!min_size || !is_power_of_2(min_size))
+		return NULL;
+
+	if (!rb)
+		return NULL;
+
+	root_extent = rb_entry(rb, struct gpu_dirty_extent, rb);
+	if (root_extent->subtree_max_size < min_size)
+		return NULL;
+
+	rb = dirty_tracker_descend_right(rb, min_size);
+
+	while (rb) {
+		struct gpu_dirty_extent *dirty_extent;
+		u64 aligned_start;
+
+		dirty_extent = rb_entry(rb, struct gpu_dirty_extent, rb);
+		aligned_start = ALIGN(dirty_extent->start, min_size);
+
+		/* Check if a min_size block fits after the alignment skip. */
+		if (aligned_start <= dirty_extent->end &&
+		    dirty_extent->end - aligned_start >= min_size) {
+			*aligned_start_out = aligned_start;
+			return dirty_extent;
+		}
+
+		if (rb->rb_left) {
+			struct gpu_dirty_extent *tmp_extent;
+
+			tmp_extent = rb_entry(rb->rb_left, struct gpu_dirty_extent, rb);
+			if (tmp_extent->subtree_max_size >= min_size) {
+				rb = dirty_tracker_descend_right(rb->rb_left, min_size);
+				continue;
+			}
+		}
+
+		/* Walk up until we exit a node via its right child. */
+		parent = rb_parent(rb);
+		while (parent && parent->rb_right != rb) {
+			rb = parent;
+			parent = rb_parent(rb);
+		}
+		rb = parent;
+	}
+
+	return NULL;
+}
 
 static unsigned int
 gpu_buddy_block_state(struct gpu_buddy_block *block)
@@ -67,10 +480,87 @@ static unsigned int gpu_buddy_block_offset_alignment(struct gpu_buddy_block *blo
 	return __ffs64(offset);
 }
 
-RB_DECLARE_CALLBACKS_MAX(static, gpu_buddy_augment_cb,
-			 struct gpu_buddy_block, rb,
-			 unsigned int, subtree_max_alignment,
-			 gpu_buddy_block_offset_alignment);
+static inline void gpu_buddy_augment_compute(struct gpu_buddy_block *block)
+{
+	struct gpu_buddy_block *right;
+	struct gpu_buddy_block *left;
+	unsigned int max_align;
+	bool has_clear;
+
+	max_align = gpu_buddy_block_offset_alignment(block);
+	has_clear = block->has_clear;
+
+	left = rb_entry_safe(block->rb.rb_left, struct gpu_buddy_block, rb);
+	if (left) {
+		if (left->subtree_max_alignment > max_align)
+			max_align = left->subtree_max_alignment;
+
+		has_clear |= left->subtree_has_clear;
+	}
+
+	right = rb_entry_safe(block->rb.rb_right, struct gpu_buddy_block, rb);
+	if (right) {
+		if (right->subtree_max_alignment > max_align)
+			max_align = right->subtree_max_alignment;
+
+		has_clear |= right->subtree_has_clear;
+	}
+
+	block->subtree_max_alignment = max_align;
+	block->subtree_has_clear = has_clear;
+}
+
+static void gpu_buddy_augment_propagate(struct rb_node *rb, struct rb_node *stop)
+{
+	while (rb != stop) {
+		struct gpu_buddy_block *block;
+		unsigned int old_align;
+		bool old_has_clear;
+
+		block = rb_entry(rb, struct gpu_buddy_block, rb);
+		old_align = block->subtree_max_alignment;
+		old_has_clear = block->subtree_has_clear;
+
+		gpu_buddy_augment_compute(block);
+		if (block->subtree_max_alignment == old_align &&
+		    block->subtree_has_clear == old_has_clear)
+			break;
+
+		rb = rb_parent(&block->rb);
+	}
+}
+
+static void gpu_buddy_augment_copy(struct rb_node *rb_old, struct rb_node *rb_new)
+{
+	struct gpu_buddy_block *old;
+	struct gpu_buddy_block *new;
+
+	old = rb_entry(rb_old, struct gpu_buddy_block, rb);
+	new = rb_entry(rb_new, struct gpu_buddy_block, rb);
+
+	new->subtree_max_alignment = old->subtree_max_alignment;
+	new->subtree_has_clear = old->subtree_has_clear;
+}
+
+static void gpu_buddy_augment_rotate(struct rb_node *rb_old, struct rb_node *rb_new)
+{
+	struct gpu_buddy_block *old;
+	struct gpu_buddy_block *new;
+
+	old = rb_entry(rb_old, struct gpu_buddy_block, rb);
+	new = rb_entry(rb_new, struct gpu_buddy_block, rb);
+
+	new->subtree_max_alignment = old->subtree_max_alignment;
+	new->subtree_has_clear = old->subtree_has_clear;
+
+	gpu_buddy_augment_compute(old);
+}
+
+static const struct rb_augment_callbacks gpu_buddy_augment_cb = {
+	.propagate = gpu_buddy_augment_propagate,
+	.copy      = gpu_buddy_augment_copy,
+	.rotate    = gpu_buddy_augment_rotate,
+};
 
 static struct gpu_buddy_block *gpu_block_alloc(struct gpu_buddy *mm,
 					       struct gpu_buddy_block *parent,
@@ -101,13 +591,6 @@ static void gpu_block_free(struct gpu_buddy *mm,
 	kmem_cache_free(slab_blocks, block);
 }
 
-static enum gpu_buddy_free_tree
-get_block_tree(struct gpu_buddy_block *block)
-{
-	return gpu_buddy_block_is_clear(block) ?
-	       GPU_BUDDY_CLEAR_TREE : GPU_BUDDY_DIRTY_TREE;
-}
-
 static struct gpu_buddy_block *
 rbtree_get_free_block(const struct rb_node *node)
 {
@@ -120,24 +603,55 @@ rbtree_last_free_block(struct rb_root *root)
 	return rbtree_get_free_block(rb_last(root));
 }
 
-static bool rbtree_is_empty(struct rb_root *root)
+static struct gpu_buddy_block *
+rbtree_last_clear_free_block(struct rb_root *root)
+{
+	struct gpu_buddy_block *block = NULL;
+	struct rb_node *node = root->rb_node;
+
+	while (node) {
+		struct gpu_buddy_block *right_block;
+		struct gpu_buddy_block *node_block;
+
+		node_block = rbtree_get_free_block(node);
+		right_block = rbtree_get_free_block(node->rb_right);
+
+		if (right_block && right_block->subtree_has_clear) {
+			node = node->rb_right;
+			continue;
+		}
+
+		if (node_block->has_clear) {
+			block = node_block;
+			break;
+		}
+
+		node = node->rb_left;
+	}
+
+	return block;
+}
+
+static inline void gpu_buddy_sync_clear_avail(struct gpu_buddy *mm)
 {
-	return RB_EMPTY_ROOT(root);
+	mm->clear_avail = mm->avail - mm->dirty.total_dirty;
 }
 
 static void rbtree_insert(struct gpu_buddy *mm,
-			  struct gpu_buddy_block *block,
-			  enum gpu_buddy_free_tree tree)
+			  struct gpu_buddy_block *block)
 {
 	struct rb_node **link, *parent = NULL;
-	unsigned int block_alignment, order;
 	struct gpu_buddy_block *node;
+	unsigned int block_alignment;
 	struct rb_root *root;
+	bool block_has_clear;
+	unsigned int order;
 
 	order = gpu_buddy_block_order(block);
 	block_alignment = gpu_buddy_block_offset_alignment(block);
+	block_has_clear = block->has_clear;
 
-	root = &mm->free_trees[tree][order];
+	root = &mm->free_tree[order];
 	link = &root->rb_node;
 
 	while (*link) {
@@ -147,10 +661,12 @@ static void rbtree_insert(struct gpu_buddy *mm,
 		 * Manual augmentation update during insertion traversal. Required
 		 * because rb_insert_augmented() only calls rotate callback during
 		 * rotations. This ensures all ancestors on the insertion path have
-		 * correct subtree_max_alignment values.
+		 * correct subtree_max_alignment / subtree_has_clear values.
 		 */
 		if (node->subtree_max_alignment < block_alignment)
 			node->subtree_max_alignment = block_alignment;
+		if (block_has_clear)
+			node->subtree_has_clear = true;
 
 		if (gpu_buddy_block_offset(block) < gpu_buddy_block_offset(node))
 			link = &parent->rb_left;
@@ -159,6 +675,7 @@ static void rbtree_insert(struct gpu_buddy *mm,
 	}
 
 	block->subtree_max_alignment = block_alignment;
+	block->subtree_has_clear = block_has_clear;
 	rb_link_node(&block->rb, parent, link);
 	rb_insert_augmented(&block->rb, root, &gpu_buddy_augment_cb);
 }
@@ -167,26 +684,11 @@ static void rbtree_remove(struct gpu_buddy *mm,
 			  struct gpu_buddy_block *block)
 {
 	unsigned int order = gpu_buddy_block_order(block);
-	enum gpu_buddy_free_tree tree;
-	struct rb_root *root;
 
-	tree = get_block_tree(block);
-	root = &mm->free_trees[tree][order];
-
-	rb_erase_augmented(&block->rb, root, &gpu_buddy_augment_cb);
+	rb_erase_augmented(&block->rb, &mm->free_tree[order], &gpu_buddy_augment_cb);
 	RB_CLEAR_NODE(&block->rb);
 }
 
-static void clear_reset(struct gpu_buddy_block *block)
-{
-	block->header &= ~GPU_BUDDY_HEADER_CLEAR;
-}
-
-static void mark_cleared(struct gpu_buddy_block *block)
-{
-	block->header |= GPU_BUDDY_HEADER_CLEAR;
-}
-
 static void mark_allocated(struct gpu_buddy *mm,
 			   struct gpu_buddy_block *block)
 {
@@ -199,21 +701,36 @@ static void mark_allocated(struct gpu_buddy *mm,
 	rbtree_remove(mm, block);
 }
 
-static void mark_free(struct gpu_buddy *mm,
-		      struct gpu_buddy_block *block)
+static void __mark_free(struct gpu_buddy *mm,
+			struct gpu_buddy_block *block,
+			enum gpu_block_state block_state)
 {
-	enum gpu_buddy_free_tree tree;
-
 	if (gpu_buddy_block_is_allocated(block))
 		mm->used_scoreboard[gpu_buddy_block_order(block)]--;
 
 	block->header &= ~GPU_BUDDY_HEADER_STATE;
 	block->header |= GPU_BUDDY_FREE;
 
+	block->header &= ~GPU_BUDDY_HEADER_CLEAR;
+
+	block->has_clear = (block_state != GPU_BLOCK_DIRTY);
+	if (block_state == GPU_BLOCK_CLEAR)
+		block->header |= GPU_BUDDY_HEADER_CLEAR;
+
 	mm->free_scoreboard[gpu_buddy_block_order(block)]++;
 
-	tree = get_block_tree(block);
-	rbtree_insert(mm, block, tree);
+	rbtree_insert(mm, block);
+}
+
+static void mark_free(struct gpu_buddy *mm,
+		      struct gpu_buddy_block *block)
+{
+	enum gpu_block_state block_state;
+
+	block_state = gpu_query_block_state(&mm->dirty,
+					    gpu_buddy_block_offset(block),
+					    gpu_buddy_block_size(mm, block));
+	__mark_free(mm, block, block_state);
 }
 
 static void mark_split(struct gpu_buddy *mm,
@@ -253,37 +770,37 @@ __get_buddy(struct gpu_buddy_block *block)
 }
 
 static unsigned int __gpu_buddy_free(struct gpu_buddy *mm,
-				     struct gpu_buddy_block *block,
-				     bool force_merge)
+				     struct gpu_buddy_block *block)
 {
+	enum gpu_block_state block_state;
 	struct gpu_buddy_block *parent;
 	unsigned int order;
 
-	while ((parent = block->parent)) {
-		struct gpu_buddy_block *buddy;
+	block_state = gpu_buddy_block_is_clear(block) ? GPU_BLOCK_CLEAR :
+							GPU_BLOCK_DIRTY;
 
-		buddy = __get_buddy(block);
+	while ((parent = block->parent)) {
+		struct gpu_buddy_block *buddy = __get_buddy(block);
 
 		if (!gpu_buddy_block_is_free(buddy))
 			break;
 
-		if (!force_merge) {
-			/*
-			 * Check the block and its buddy clear state and exit
-			 * the loop if they both have the dissimilar state.
-			 */
-			if (gpu_buddy_block_is_clear(block) !=
-			    gpu_buddy_block_is_clear(buddy))
-				break;
+		if (block_state != GPU_BLOCK_MIXED) {
+			enum gpu_block_state buddy_state;
 
-			if (gpu_buddy_block_is_clear(block))
-				mark_cleared(parent);
+			if (gpu_buddy_block_is_clear(buddy))
+				buddy_state = GPU_BLOCK_CLEAR;
+			else if (!buddy->has_clear)
+				buddy_state = GPU_BLOCK_DIRTY;
+			else
+				buddy_state = GPU_BLOCK_MIXED;
+
+			if (buddy_state != block_state)
+				block_state = GPU_BLOCK_MIXED;
 		}
 
 		rbtree_remove(mm, buddy);
 		mm->free_scoreboard[gpu_buddy_block_order(buddy)]--;
-		if (force_merge && gpu_buddy_block_is_clear(buddy))
-			mm->clear_avail -= gpu_buddy_block_size(mm, buddy);
 
 		if (gpu_buddy_block_is_allocated(block))
 			mm->used_scoreboard[gpu_buddy_block_order(block)]--;
@@ -295,74 +812,11 @@ static unsigned int __gpu_buddy_free(struct gpu_buddy *mm,
 	}
 
 	order = gpu_buddy_block_order(block);
-	mark_free(mm, block);
+	__mark_free(mm, block, block_state);
 
 	return order;
 }
 
-static int __force_merge(struct gpu_buddy *mm,
-			 u64 start,
-			 u64 end,
-			 unsigned int min_order)
-{
-	unsigned int tree, order;
-	int i;
-
-	if (!min_order)
-		return -ENOMEM;
-
-	if (min_order > mm->max_order)
-		return -EINVAL;
-
-	for_each_free_tree(tree) {
-		for (i = min_order - 1; i >= 0; i--) {
-			struct rb_node *iter = rb_last(&mm->free_trees[tree][i]);
-
-			while (iter) {
-				struct gpu_buddy_block *block, *buddy;
-				u64 block_start, block_end;
-
-				block = rbtree_get_free_block(iter);
-				iter = rb_prev(iter);
-
-				if (!block || !block->parent)
-					continue;
-
-				block_start = gpu_buddy_block_offset(block);
-				block_end = block_start + gpu_buddy_block_size(mm, block) - 1;
-
-				if (!contains(start, end, block_start, block_end))
-					continue;
-
-				buddy = __get_buddy(block);
-				if (!gpu_buddy_block_is_free(buddy))
-					continue;
-
-				gpu_buddy_assert(gpu_buddy_block_is_clear(block) !=
-						 gpu_buddy_block_is_clear(buddy));
-
-				/*
-				 * Advance to the next node when the current node is the buddy,
-				 * as freeing the block will also remove its buddy from the tree.
-				 */
-				if (iter == &buddy->rb)
-					iter = rb_prev(iter);
-
-				rbtree_remove(mm, block);
-				mm->free_scoreboard[gpu_buddy_block_order(block)]--;
-				if (gpu_buddy_block_is_clear(block))
-					mm->clear_avail -= gpu_buddy_block_size(mm, block);
-
-				order = __gpu_buddy_free(mm, block, true);
-				if (order >= min_order)
-					return 0;
-			}
-		}
-	}
-
-	return -ENOMEM;
-}
-
 /**
  * gpu_buddy_init - init memory manager
  *
@@ -377,7 +831,7 @@ static int __force_merge(struct gpu_buddy *mm,
  */
 int gpu_buddy_init(struct gpu_buddy *mm, u64 size, u64 chunk_size)
 {
-	unsigned int i, j, root_count = 0;
+	unsigned int root_count = 0;
 	u64 offset = 0;
 
 	if (size < chunk_size)
@@ -411,22 +865,14 @@ int gpu_buddy_init(struct gpu_buddy *mm, u64 size, u64 chunk_size)
 	if (!mm->used_scoreboard)
 		goto out_free_free_scoreboard;
 
-	mm->free_trees = kmalloc_array(GPU_BUDDY_MAX_FREE_TREES,
-				       sizeof(*mm->free_trees),
-				       GFP_KERNEL);
-	if (!mm->free_trees)
+	mm->free_tree = kcalloc(mm->max_order + 1,
+				sizeof(struct rb_root),
+				GFP_KERNEL);
+	if (!mm->free_tree)
 		goto out_free_used_scoreboard;
 
-	for_each_free_tree(i) {
-		mm->free_trees[i] = kmalloc_array(mm->max_order + 1,
-						  sizeof(struct rb_root),
-						  GFP_KERNEL);
-		if (!mm->free_trees[i])
-			goto out_free_tree;
-
-		for (j = 0; j <= mm->max_order; ++j)
-			mm->free_trees[i][j] = RB_ROOT;
-	}
+	if (gpu_dirty_tracker_init(&mm->dirty))
+		goto out_free_tree;
 
 	mm->n_roots = hweight64(size);
 
@@ -452,7 +898,8 @@ int gpu_buddy_init(struct gpu_buddy *mm, u64 size, u64 chunk_size)
 		if (!root)
 			goto out_free_roots;
 
-		mark_free(mm, root);
+		gpu_dirty_tracker_mark_dirty(&mm->dirty, offset, root_size);
+		__mark_free(mm, root, GPU_BLOCK_DIRTY);
 
 		BUG_ON(root_count > mm->max_order);
 		BUG_ON(gpu_buddy_block_size(mm, root) < chunk_size);
@@ -474,9 +921,8 @@ int gpu_buddy_init(struct gpu_buddy *mm, u64 size, u64 chunk_size)
 		gpu_block_free(mm, mm->roots[root_count]);
 	kfree(mm->roots);
 out_free_tree:
-	while (i--)
-		kfree(mm->free_trees[i]);
-	kfree(mm->free_trees);
+	gpu_dirty_tracker_fini(&mm->dirty);
+	kfree(mm->free_tree);
 out_free_used_scoreboard:
 	kfree(mm->used_scoreboard);
 out_free_free_scoreboard:
@@ -494,7 +940,7 @@ EXPORT_SYMBOL(gpu_buddy_init);
  */
 void gpu_buddy_fini(struct gpu_buddy *mm)
 {
-	u64 root_size, size, start;
+	u64 root_size, size;
 	unsigned int order;
 	int i;
 
@@ -502,14 +948,10 @@ void gpu_buddy_fini(struct gpu_buddy *mm)
 
 	for (i = 0; i < mm->n_roots; ++i) {
 		order = ilog2(size) - ilog2(mm->chunk_size);
-		start = gpu_buddy_block_offset(mm->roots[i]);
-		__force_merge(mm, start, start + size, order);
+		root_size = mm->chunk_size << order;
 
 		gpu_buddy_assert(gpu_buddy_block_is_free(mm->roots[i]));
-
 		gpu_block_free(mm, mm->roots[i]);
-
-		root_size = mm->chunk_size << order;
 		size -= root_size;
 	}
 
@@ -518,9 +960,8 @@ void gpu_buddy_fini(struct gpu_buddy *mm)
 	for (i = 0; i <= mm->max_order; ++i)
 		gpu_buddy_assert(!mm->used_scoreboard[i]);
 
-	for_each_free_tree(i)
-		kfree(mm->free_trees[i]);
-	kfree(mm->free_trees);
+	gpu_dirty_tracker_fini(&mm->dirty);
+	kfree(mm->free_tree);
 	kfree(mm->roots);
 	kfree(mm->free_scoreboard);
 	kfree(mm->used_scoreboard);
@@ -532,6 +973,7 @@ static int split_block(struct gpu_buddy *mm,
 {
 	unsigned int block_order = gpu_buddy_block_order(block) - 1;
 	u64 offset = gpu_buddy_block_offset(block);
+	enum gpu_block_state parent_state;
 
 	BUG_ON(!gpu_buddy_block_is_free(block));
 	BUG_ON(!gpu_buddy_block_order(block));
@@ -547,17 +989,23 @@ static int split_block(struct gpu_buddy *mm,
 		return -ENOMEM;
 	}
 
+	if (gpu_buddy_block_is_clear(block))
+		parent_state = GPU_BLOCK_CLEAR;
+	else if (!block->has_clear)
+		parent_state = GPU_BLOCK_DIRTY;
+	else
+		parent_state = GPU_BLOCK_MIXED;
+
 	mark_split(mm, block);
 
-	if (gpu_buddy_block_is_clear(block)) {
-		mark_cleared(block->left);
-		mark_cleared(block->right);
-		clear_reset(block);
+	if (parent_state == GPU_BLOCK_MIXED) {
+		mark_free(mm, block->left);
+		mark_free(mm, block->right);
+	} else {
+		__mark_free(mm, block->left, parent_state);
+		__mark_free(mm, block->right, parent_state);
 	}
 
-	mark_free(mm, block->left);
-	mark_free(mm, block->right);
-
 	return 0;
 }
 
@@ -572,42 +1020,39 @@ static int split_block(struct gpu_buddy *mm,
  */
 void gpu_buddy_reset_clear(struct gpu_buddy *mm, bool is_clear)
 {
-	enum gpu_buddy_free_tree src_tree, dst_tree;
-	u64 root_size, size, start;
-	unsigned int order;
-	int i;
+	unsigned int i;
 
 	gpu_buddy_driver_lock_held(mm);
-	size = mm->size;
-	for (i = 0; i < mm->n_roots; ++i) {
-		order = ilog2(size) - ilog2(mm->chunk_size);
-		start = gpu_buddy_block_offset(mm->roots[i]);
-		__force_merge(mm, start, start + size, order);
-
-		root_size = mm->chunk_size << order;
-		size -= root_size;
-	}
 
-	src_tree = is_clear ? GPU_BUDDY_DIRTY_TREE : GPU_BUDDY_CLEAR_TREE;
-	dst_tree = is_clear ? GPU_BUDDY_CLEAR_TREE : GPU_BUDDY_DIRTY_TREE;
+	gpu_dirty_tracker_empty(&mm->dirty);
 
 	for (i = 0; i <= mm->max_order; ++i) {
-		struct rb_root *root = &mm->free_trees[src_tree][i];
 		struct gpu_buddy_block *block, *tmp;
 
-		rbtree_postorder_for_each_entry_safe(block, tmp, root, rb) {
-			rbtree_remove(mm, block);
+		rbtree_postorder_for_each_entry_safe(block, tmp,
+						     &mm->free_tree[i], rb) {
 			if (is_clear) {
-				mark_cleared(block);
-				mm->clear_avail += gpu_buddy_block_size(mm, block);
+				if (!gpu_buddy_block_is_clear(block))
+					block->header |= GPU_BUDDY_HEADER_CLEAR;
+				block->has_clear = true;
+			} else if (gpu_buddy_block_is_clear(block)) {
+				block->header &= ~GPU_BUDDY_HEADER_CLEAR;
+				block->has_clear = false;
+				gpu_dirty_tracker_mark_dirty(&mm->dirty,
+							     gpu_buddy_block_offset(block),
+							     gpu_buddy_block_size(mm, block));
 			} else {
-				clear_reset(block);
-				mm->clear_avail -= gpu_buddy_block_size(mm, block);
+				block->has_clear = false;
+				gpu_dirty_tracker_mark_dirty(&mm->dirty,
+							     gpu_buddy_block_offset(block),
+							     gpu_buddy_block_size(mm, block));
 			}
 
-			rbtree_insert(mm, block, dst_tree);
+			gpu_buddy_augment_compute(block);
 		}
 	}
+
+	gpu_buddy_sync_clear_avail(mm);
 }
 EXPORT_SYMBOL(gpu_buddy_reset_clear);
 
@@ -620,13 +1065,18 @@ EXPORT_SYMBOL(gpu_buddy_reset_clear);
 void gpu_buddy_free_block(struct gpu_buddy *mm,
 			  struct gpu_buddy_block *block)
 {
+	u64 size = gpu_buddy_block_size(mm, block);
+	u64 offset = gpu_buddy_block_offset(block);
+
 	gpu_buddy_driver_lock_held(mm);
 	BUG_ON(!gpu_buddy_block_is_allocated(block));
-	mm->avail += gpu_buddy_block_size(mm, block);
-	if (gpu_buddy_block_is_clear(block))
-		mm->clear_avail += gpu_buddy_block_size(mm, block);
 
-	__gpu_buddy_free(mm, block, false);
+	mm->avail += size;
+	if (!gpu_buddy_block_is_clear(block))
+		gpu_dirty_tracker_mark_dirty(&mm->dirty, offset, size);
+
+	gpu_buddy_sync_clear_avail(mm);
+	__gpu_buddy_free(mm, block);
 }
 EXPORT_SYMBOL(gpu_buddy_free_block);
 
@@ -641,9 +1091,9 @@ static void __gpu_buddy_free_list(struct gpu_buddy *mm,
 
 	list_for_each_entry_safe(block, on, objects, link) {
 		if (mark_clear)
-			mark_cleared(block);
+			block->header |= GPU_BUDDY_HEADER_CLEAR;
 		else if (mark_dirty)
-			clear_reset(block);
+			block->header &= ~GPU_BUDDY_HEADER_CLEAR;
 		gpu_buddy_free_block(mm, block);
 		cond_resched();
 	}
@@ -679,13 +1129,6 @@ void gpu_buddy_free_list(struct gpu_buddy *mm,
 }
 EXPORT_SYMBOL(gpu_buddy_free_list);
 
-static bool block_incompatible(struct gpu_buddy_block *block, unsigned int flags)
-{
-	bool needs_clear = flags & GPU_BUDDY_CLEAR_ALLOCATION;
-
-	return needs_clear != gpu_buddy_block_is_clear(block);
-}
-
 static void __gpu_buddy_undo_splits(struct gpu_buddy *mm,
 				    struct gpu_buddy_block *block)
 {
@@ -696,7 +1139,7 @@ static void __gpu_buddy_undo_splits(struct gpu_buddy *mm,
 	     gpu_buddy_block_is_free(buddy))) {
 		rbtree_remove(mm, block);
 		mm->free_scoreboard[gpu_buddy_block_order(block)]--;
-		__gpu_buddy_free(mm, block, false);
+		__gpu_buddy_free(mm, block);
 	}
 }
 
@@ -704,8 +1147,7 @@ static struct gpu_buddy_block *
 __alloc_range_bias(struct gpu_buddy *mm,
 		   u64 start, u64 end,
 		   unsigned int order,
-		   unsigned long flags,
-		   bool fallback)
+		   unsigned long flags)
 {
 	u64 req_size = mm->chunk_size << order;
 	struct gpu_buddy_block *block;
@@ -715,7 +1157,15 @@ __alloc_range_bias(struct gpu_buddy *mm,
 
 	end = end - 1;
 
-	for (i = 0; i < mm->n_roots; ++i)
+	/*
+	 * This range-constrained search hands back the highest/right-most
+	 * address that satisfies the request: the roots are seeded high-to-low
+	 * and the right (higher-address) child is descended first, making
+	 * top-down the default placement here. A non-top-down clear request is
+	 * the only exception, where the descent is biased towards clear or
+	 * clear-containing subtrees to satisfy the clear preference.
+	 */
+	for (i = mm->n_roots - 1; i >= 0; --i)
 		list_add_tail(&mm->roots[i]->tmp_link, &dfs);
 
 	do {
@@ -751,9 +1201,6 @@ __alloc_range_bias(struct gpu_buddy *mm,
 				continue;
 		}
 
-		if (!fallback && block_incompatible(block, flags))
-			continue;
-
 		if (contains(start, end, block_start, block_end) &&
 		    order == gpu_buddy_block_order(block)) {
 			/*
@@ -771,8 +1218,38 @@ __alloc_range_bias(struct gpu_buddy *mm,
 				goto err_undo;
 		}
 
-		list_add(&block->right->tmp_link, &dfs);
-		list_add(&block->left->tmp_link, &dfs);
+		/*
+		 * Top-down is a strict address-placement policy, so when it is
+		 * requested we ignore clear steering and simply descend the
+		 * right (higher-address) child first. Only a non-top-down clear
+		 * request biases the descent towards clear/has_clear subtrees.
+		 */
+		if ((flags & GPU_BUDDY_CLEAR_ALLOCATION) &&
+		    !(flags & GPU_BUDDY_TOPDOWN_ALLOCATION)) {
+			struct gpu_buddy_block *prefer;
+
+			if (gpu_buddy_block_is_clear(block->right))
+				prefer = block->right;
+			else if (gpu_buddy_block_is_clear(block->left))
+				prefer = block->left;
+			else if (block->right->has_clear)
+				prefer = block->right;
+			else if (block->left->has_clear)
+				prefer = block->left;
+			else
+				prefer = block->right;
+
+			if (prefer == block->right) {
+				list_add(&block->left->tmp_link, &dfs);
+				list_add(&block->right->tmp_link, &dfs);
+			} else {
+				list_add(&block->right->tmp_link, &dfs);
+				list_add(&block->left->tmp_link, &dfs);
+			}
+		} else {
+			list_add(&block->left->tmp_link, &dfs);
+			list_add(&block->right->tmp_link, &dfs);
+		}
 	} while (1);
 
 	return ERR_PTR(-ENOSPC);
@@ -787,48 +1264,32 @@ __alloc_range_bias(struct gpu_buddy *mm,
 	return ERR_PTR(err);
 }
 
-static struct gpu_buddy_block *
-__gpu_buddy_alloc_range_bias(struct gpu_buddy *mm,
-			     u64 start, u64 end,
-			     unsigned int order,
-			     unsigned long flags)
-{
-	struct gpu_buddy_block *block;
-	bool fallback = false;
-
-	block = __alloc_range_bias(mm, start, end, order,
-				   flags, fallback);
-	if (IS_ERR(block))
-		return __alloc_range_bias(mm, start, end, order,
-					  flags, !fallback);
-
-	return block;
-}
-
+/* Return the highest-address free block of at least @order. */
 static struct gpu_buddy_block *
 get_maxblock(struct gpu_buddy *mm,
-	     unsigned int order,
-	     enum gpu_buddy_free_tree tree)
+	     unsigned int order)
 {
-	struct gpu_buddy_block *max_block = NULL, *block = NULL;
-	struct rb_root *root;
+	struct gpu_buddy_block *max_block;
+	struct gpu_buddy_block *block;
 	unsigned int i;
 
+	/*
+	 * Top-down allocation is a strict address-placement policy: the block
+	 * is chosen purely by offset, regardless of its clear/dirty state.
+	 * Clear state is re-derived from the dirty tracker once the allocation
+	 * completes, and the driver is responsible for issuing the clear pass
+	 * if a clear region is required.
+	 */
+	max_block = NULL;
+
 	for (i = order; i <= mm->max_order; ++i) {
-		root = &mm->free_trees[tree][i];
-		block = rbtree_last_free_block(root);
+		block = rbtree_last_free_block(&mm->free_tree[i]);
 		if (!block)
 			continue;
 
-		if (!max_block) {
-			max_block = block;
-			continue;
-		}
-
-		if (gpu_buddy_block_offset(block) >
-		    gpu_buddy_block_offset(max_block)) {
+		if (!max_block ||
+		    gpu_buddy_block_offset(block) > gpu_buddy_block_offset(max_block))
 			max_block = block;
-		}
 	}
 
 	return max_block;
@@ -840,45 +1301,33 @@ alloc_from_freetree(struct gpu_buddy *mm,
 		    unsigned long flags)
 {
 	struct gpu_buddy_block *block = NULL;
-	struct rb_root *root;
-	enum gpu_buddy_free_tree tree;
 	unsigned int tmp;
 	int err;
 
-	tree = (flags & GPU_BUDDY_CLEAR_ALLOCATION) ?
-		GPU_BUDDY_CLEAR_TREE : GPU_BUDDY_DIRTY_TREE;
-
 	if (flags & GPU_BUDDY_TOPDOWN_ALLOCATION) {
-		block = get_maxblock(mm, order, tree);
+		block = get_maxblock(mm, order);
 		if (block)
-			/* Store the obtained block order */
 			tmp = gpu_buddy_block_order(block);
 	} else {
-		for (tmp = order; tmp <= mm->max_order; ++tmp) {
-			/* Get RB tree root for this order and tree */
-			root = &mm->free_trees[tree][tmp];
-			block = rbtree_last_free_block(root);
-			if (block)
-				break;
+		if (flags & GPU_BUDDY_CLEAR_ALLOCATION) {
+			for (tmp = order; tmp <= mm->max_order; ++tmp) {
+				block = rbtree_last_clear_free_block(&mm->free_tree[tmp]);
+				if (block)
+					break;
+			}
 		}
-	}
-
-	if (!block) {
-		/* Try allocating from the other tree */
-		tree = (tree == GPU_BUDDY_CLEAR_TREE) ?
-			GPU_BUDDY_DIRTY_TREE : GPU_BUDDY_CLEAR_TREE;
-
-		for (tmp = order; tmp <= mm->max_order; ++tmp) {
-			root = &mm->free_trees[tree][tmp];
-			block = rbtree_last_free_block(root);
-			if (block)
-				break;
+		if (!block) {
+			for (tmp = order; tmp <= mm->max_order; ++tmp) {
+				block = rbtree_last_free_block(&mm->free_tree[tmp]);
+				if (block)
+					break;
+			}
 		}
-
-		if (!block)
-			return ERR_PTR(-ENOSPC);
 	}
 
+	if (!block)
+		return ERR_PTR(-ENOSPC);
+
 	BUG_ON(!gpu_buddy_block_is_free(block));
 
 	while (tmp != order) {
@@ -886,7 +1335,26 @@ alloc_from_freetree(struct gpu_buddy *mm,
 		if (unlikely(err))
 			goto err_undo;
 
-		block = block->right;
+		if ((flags & GPU_BUDDY_CLEAR_ALLOCATION) &&
+		    !(flags & GPU_BUDDY_TOPDOWN_ALLOCATION)) {
+			bool right_clear, left_clear;
+
+			right_clear = gpu_buddy_block_is_clear(block->right);
+			left_clear = gpu_buddy_block_is_clear(block->left);
+
+			if (right_clear)
+				block = block->right;
+			else if (left_clear)
+				block = block->left;
+			else if (block->right->has_clear)
+				block = block->right;
+			else if (block->left->has_clear)
+				block = block->left;
+			else
+				block = block->right;
+		} else {
+			block = block->right;
+		}
 		tmp--;
 	}
 	return block;
@@ -913,12 +1381,10 @@ static bool gpu_buddy_subtree_can_satisfy(struct rb_node *node,
 
 static struct gpu_buddy_block *
 gpu_buddy_find_block_aligned(struct gpu_buddy *mm,
-			     enum gpu_buddy_free_tree tree,
 			     unsigned int order,
-			     unsigned int alignment,
-			     unsigned long flags)
+			     unsigned int alignment)
 {
-	struct rb_root *root = &mm->free_trees[tree][order];
+	struct rb_root *root = &mm->free_tree[order];
 	struct rb_node *rb = root->rb_node;
 
 	while (rb) {
@@ -951,12 +1417,10 @@ gpu_buddy_find_block_aligned(struct gpu_buddy *mm,
 static struct gpu_buddy_block *
 gpu_buddy_offset_aligned_allocation(struct gpu_buddy *mm,
 				    u64 size,
-				    u64 min_block_size,
-				    unsigned long flags)
+				    u64 min_block_size)
 {
 	struct gpu_buddy_block *block = NULL;
 	unsigned int order, tmp, alignment;
-	enum gpu_buddy_free_tree tree;
 	unsigned long pages;
 	int err;
 
@@ -964,19 +1428,15 @@ gpu_buddy_offset_aligned_allocation(struct gpu_buddy *mm,
 	pages = size >> ilog2(mm->chunk_size);
 	order = fls(pages) - 1;
 
-	tree = (flags & GPU_BUDDY_CLEAR_ALLOCATION) ?
-		GPU_BUDDY_CLEAR_TREE : GPU_BUDDY_DIRTY_TREE;
-
+	/*
+	 * Offset-aligned allocation is a strict address-placement policy: the
+	 * block is chosen purely by its offset alignment, regardless of its
+	 * clear/dirty state. Clear state is re-derived from the dirty tracker
+	 * once the allocation completes, and the driver is responsible for
+	 * issuing the clear pass if a clear region is required.
+	 */
 	for (tmp = order; tmp <= mm->max_order; ++tmp) {
-		block = gpu_buddy_find_block_aligned(mm, tree, tmp,
-						     alignment, flags);
-		if (!block) {
-			tree = (tree == GPU_BUDDY_CLEAR_TREE) ?
-				GPU_BUDDY_DIRTY_TREE : GPU_BUDDY_CLEAR_TREE;
-			block = gpu_buddy_find_block_aligned(mm, tree, tmp,
-							     alignment, flags);
-		}
-
+		block = gpu_buddy_find_block_aligned(mm, tmp, alignment);
 		if (block)
 			break;
 	}
@@ -1015,6 +1475,7 @@ gpu_buddy_offset_aligned_allocation(struct gpu_buddy *mm,
 static int __alloc_range(struct gpu_buddy *mm,
 			 struct list_head *dfs,
 			 u64 start, u64 size,
+			 unsigned long flags,
 			 struct list_head *blocks,
 			 u64 *total_allocated_on_err)
 {
@@ -1051,16 +1512,33 @@ static int __alloc_range(struct gpu_buddy *mm,
 
 		if (contains(start, end, block_start, block_end)) {
 			if (gpu_buddy_block_is_free(block)) {
+				bool block_clear = false;
+				u64 block_offset;
+				u64 block_size;
+
+				block_size = gpu_buddy_block_size(mm, block);
+				block_offset = gpu_buddy_block_offset(block);
+
+				if (flags & GPU_BUDDY_CLEAR_ALLOCATION)
+					block_clear = gpu_buddy_block_is_clear(block);
+
+				if (!gpu_buddy_block_is_clear(block))
+					gpu_dirty_tracker_remove_range(&mm->dirty,
+								       block_offset,
+								       block_size);
+
 				mark_allocated(mm, block);
-				total_allocated += gpu_buddy_block_size(mm, block);
-				mm->avail -= gpu_buddy_block_size(mm, block);
-				if (gpu_buddy_block_is_clear(block))
-					mm->clear_avail -= gpu_buddy_block_size(mm, block);
+				total_allocated += block_size;
+				mm->avail -= block_size;
+
+				block->header &= ~GPU_BUDDY_HEADER_CLEAR;
+				if (block_clear)
+					block->header |= GPU_BUDDY_HEADER_CLEAR;
+
+				gpu_buddy_sync_clear_avail(mm);
+
 				list_add_tail(&block->link, &allocated);
 				continue;
-			} else if (!mm->clear_avail) {
-				err = -ENOSPC;
-				goto err_free;
 			}
 		}
 
@@ -1105,6 +1583,7 @@ static int __alloc_range(struct gpu_buddy *mm,
 static int __gpu_buddy_alloc_range(struct gpu_buddy *mm,
 				   u64 start,
 				   u64 size,
+				   unsigned long flags,
 				   u64 *total_allocated_on_err,
 				   struct list_head *blocks)
 {
@@ -1114,20 +1593,23 @@ static int __gpu_buddy_alloc_range(struct gpu_buddy *mm,
 	for (i = 0; i < mm->n_roots; ++i)
 		list_add_tail(&mm->roots[i]->tmp_link, &dfs);
 
-	return __alloc_range(mm, &dfs, start, size,
+	return __alloc_range(mm, &dfs, start, size, flags,
 			     blocks, total_allocated_on_err);
 }
 
 static int __alloc_contig_try_harder(struct gpu_buddy *mm,
 				     u64 size,
 				     u64 min_block_size,
+				     unsigned long flags,
 				     struct list_head *blocks)
 {
 	u64 rhs_offset, lhs_offset, lhs_size, filled;
 	struct gpu_buddy_block *block;
-	unsigned int tree, order;
 	LIST_HEAD(blocks_lhs);
+	struct rb_root *root;
+	struct rb_node *iter;
 	unsigned long pages;
+	unsigned int order;
 	u64 modify_size;
 	int err;
 
@@ -1137,45 +1619,40 @@ static int __alloc_contig_try_harder(struct gpu_buddy *mm,
 	if (order == 0)
 		return -ENOSPC;
 
-	for_each_free_tree(tree) {
-		struct rb_root *root;
-		struct rb_node *iter;
-
-		root = &mm->free_trees[tree][order];
-		if (rbtree_is_empty(root))
-			continue;
+	root = &mm->free_tree[order];
+	if (RB_EMPTY_ROOT(root))
+		return -ENOSPC;
 
-		iter = rb_last(root);
-		while (iter) {
-			block = rbtree_get_free_block(iter);
-
-			/* Allocate blocks traversing RHS */
-			rhs_offset = gpu_buddy_block_offset(block);
-			err =  __gpu_buddy_alloc_range(mm, rhs_offset, size,
-						       &filled, blocks);
-			if (!err || err != -ENOSPC)
-				return err;
-
-			lhs_size = max((size - filled), min_block_size);
-			if (!IS_ALIGNED(lhs_size, min_block_size))
-				lhs_size = round_up(lhs_size, min_block_size);
-
-			/* Allocate blocks traversing LHS */
-			lhs_offset = gpu_buddy_block_offset(block) - lhs_size;
-			err =  __gpu_buddy_alloc_range(mm, lhs_offset, lhs_size,
-						       NULL, &blocks_lhs);
-			if (!err) {
-				list_splice(&blocks_lhs, blocks);
-				return 0;
-			} else if (err != -ENOSPC) {
-				gpu_buddy_free_list_internal(mm, blocks);
-				return err;
-			}
-			/* Free blocks for the next iteration */
+	iter = rb_last(root);
+	while (iter) {
+		block = rbtree_get_free_block(iter);
+
+		/* Allocate blocks traversing RHS */
+		rhs_offset = gpu_buddy_block_offset(block);
+		err =  __gpu_buddy_alloc_range(mm, rhs_offset, size,
+					       flags, &filled, blocks);
+		if (!err || err != -ENOSPC)
+			return err;
+
+		lhs_size = max((size - filled), min_block_size);
+		if (!IS_ALIGNED(lhs_size, min_block_size))
+			lhs_size = round_up(lhs_size, min_block_size);
+
+		/* Allocate blocks traversing LHS */
+		lhs_offset = gpu_buddy_block_offset(block) - lhs_size;
+		err =  __gpu_buddy_alloc_range(mm, lhs_offset, lhs_size,
+					       flags, NULL, &blocks_lhs);
+		if (!err) {
+			list_splice(&blocks_lhs, blocks);
+			return 0;
+		} else if (err != -ENOSPC) {
 			gpu_buddy_free_list_internal(mm, blocks);
-
-			iter = rb_prev(iter);
+			return err;
 		}
+		/* Free blocks for the next iteration */
+		gpu_buddy_free_list_internal(mm, blocks);
+
+		iter = rb_prev(iter);
 	}
 
 	return -ENOSPC;
@@ -1209,6 +1686,7 @@ int gpu_buddy_block_trim(struct gpu_buddy *mm,
 	struct gpu_buddy_block *block;
 	u64 block_start, block_end;
 	LIST_HEAD(dfs);
+	bool was_clear;
 	u64 new_start;
 	int err;
 
@@ -1251,22 +1729,38 @@ int gpu_buddy_block_trim(struct gpu_buddy *mm,
 	}
 
 	list_del(&block->link);
-	mark_free(mm, block);
+
+	was_clear = gpu_buddy_block_is_clear(block);
+	block->header &= ~GPU_BUDDY_HEADER_CLEAR;
+
+	if (!was_clear)
+		gpu_dirty_tracker_mark_dirty(&mm->dirty,
+					     gpu_buddy_block_offset(block),
+					     gpu_buddy_block_size(mm, block));
+
+	__mark_free(mm, block, was_clear ? GPU_BLOCK_CLEAR : GPU_BLOCK_DIRTY);
 	mm->avail += gpu_buddy_block_size(mm, block);
-	if (gpu_buddy_block_is_clear(block))
-		mm->clear_avail += gpu_buddy_block_size(mm, block);
+	gpu_buddy_sync_clear_avail(mm);
 
 	/* Prevent recursively freeing this node */
 	parent = block->parent;
 	block->parent = NULL;
 
 	list_add(&block->tmp_link, &dfs);
-	err =  __alloc_range(mm, &dfs, new_start, new_size, blocks, NULL);
+	err =  __alloc_range(mm, &dfs, new_start, new_size,
+			     was_clear ? GPU_BUDDY_CLEAR_ALLOCATION : 0,
+			     blocks, NULL);
 	if (err) {
 		mark_allocated(mm, block);
 		mm->avail -= gpu_buddy_block_size(mm, block);
-		if (gpu_buddy_block_is_clear(block))
-			mm->clear_avail -= gpu_buddy_block_size(mm, block);
+		if (!was_clear) {
+			gpu_dirty_tracker_remove_range(&mm->dirty,
+						       gpu_buddy_block_offset(block),
+						       gpu_buddy_block_size(mm, block));
+		}
+		if (was_clear)
+			block->header |= GPU_BUDDY_HEADER_CLEAR;
+		gpu_buddy_sync_clear_avail(mm);
 		list_add(&block->link, blocks);
 	}
 
@@ -1275,6 +1769,22 @@ int gpu_buddy_block_trim(struct gpu_buddy *mm,
 }
 EXPORT_SYMBOL(gpu_buddy_block_trim);
 
+static bool dirty_steer_window(struct gpu_buddy *mm, u64 req_size,
+			       u64 *start, u64 *end, unsigned long *flags)
+{
+	u64 aligned_start;
+	struct gpu_dirty_extent *ext =
+		gpu_dirty_tracker_find(&mm->dirty, req_size, &aligned_start);
+
+	if (!ext)
+		return false;
+
+	*start  = aligned_start;
+	*end    = ext->end;
+	*flags |= GPU_BUDDY_RANGE_ALLOCATION;
+	return true;
+}
+
 static struct gpu_buddy_block *
 __gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
 			 u64 start, u64 end,
@@ -1282,18 +1792,36 @@ __gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
 			 unsigned int order,
 			 unsigned long flags)
 {
-	if (flags & GPU_BUDDY_RANGE_ALLOCATION)
+	struct gpu_buddy_block *block;
+	bool steered = false;
+
+	/* Allocate from dirty tracker */
+	if (!(flags & GPU_BUDDY_RANGE_ALLOCATION) &&
+	    !(flags & GPU_BUDDY_CLEAR_ALLOCATION) &&
+	    size >= min_block_size &&
+	    mm->clear_avail && mm->dirty.total_dirty) {
+		u64 block_size = mm->chunk_size << order;
+
+		steered = dirty_steer_window(mm, block_size,
+					     &start, &end, &flags);
+	}
+
+	if (flags & GPU_BUDDY_RANGE_ALLOCATION) {
 		/* Allocate traversing within the range */
-		return  __gpu_buddy_alloc_range_bias(mm, start, end,
-						     order, flags);
-	else if (size < min_block_size)
+		block = __alloc_range_bias(mm, start, end, order, flags);
+		if (!IS_ERR(block) || !steered)
+			return block;
+
+		flags &= ~GPU_BUDDY_RANGE_ALLOCATION;
+	}
+
+	if (size < min_block_size)
 		/* Allocate from an offset-aligned region without size rounding */
 		return gpu_buddy_offset_aligned_allocation(mm, size,
-							   min_block_size,
-							   flags);
-	else
-		/* Allocate from freetree */
-		return alloc_from_freetree(mm, order, flags);
+							   min_block_size);
+
+	/* Allocate from freetree */
+	return alloc_from_freetree(mm, order, flags);
 }
 
 /**
@@ -1354,7 +1882,7 @@ int gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
 		if (!IS_ALIGNED(start | end, min_block_size))
 			return -EINVAL;
 
-		return __gpu_buddy_alloc_range(mm, start, size, NULL, blocks);
+		return __gpu_buddy_alloc_range(mm, start, size, flags, NULL, blocks);
 	}
 
 	original_size = size;
@@ -1380,12 +1908,15 @@ int gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
 		if ((flags & GPU_BUDDY_CONTIGUOUS_ALLOCATION) &&
 		    !(flags & GPU_BUDDY_RANGE_ALLOCATION))
 			return __alloc_contig_try_harder(mm, original_size,
-							 original_min_size, blocks);
+							 original_min_size,
+							 flags, blocks);
 
 		return -EINVAL;
 	}
 
 	do {
+		bool block_clear = false;
+
 		order = min(order, (unsigned int)fls(pages) - 1);
 		BUG_ON(order > mm->max_order);
 		/*
@@ -1395,8 +1926,6 @@ int gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
 		BUG_ON(size >= min_block_size && order < min_order);
 
 		do {
-			unsigned int fallback_order;
-
 			block = __gpu_buddy_alloc_blocks(mm, start,
 							 end,
 							 size,
@@ -1406,48 +1935,48 @@ int gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
 			if (!IS_ERR(block))
 				break;
 
-			if (size < min_block_size) {
-				fallback_order = order;
-			} else if (order == min_order) {
-				fallback_order = min_order;
-			} else {
+			if (size >= min_block_size && order > min_order) {
 				order--;
 				continue;
 			}
 
-			/* Try allocation through force merge method */
-			if (mm->clear_avail &&
-			    !__force_merge(mm, start, end, fallback_order)) {
-				block = __gpu_buddy_alloc_blocks(mm, start,
-								 end,
-								 size,
-								 min_block_size,
-								 fallback_order,
-								 flags);
-				if (!IS_ERR(block)) {
-					order = fallback_order;
-					break;
-				}
-			}
-
 			/*
 			 * Try contiguous block allocation through
 			 * try harder method.
 			 */
 			if (flags & GPU_BUDDY_CONTIGUOUS_ALLOCATION &&
-			    !(flags & GPU_BUDDY_RANGE_ALLOCATION))
-				return __alloc_contig_try_harder(mm,
-								 original_size,
-								 original_min_size,
-								 blocks);
+			    !(flags & GPU_BUDDY_RANGE_ALLOCATION)) {
+				err = __alloc_contig_try_harder(mm,
+								original_size,
+								original_min_size,
+								flags,
+								blocks);
+				if (!err)
+					return 0;
+				if (err != -ENOSPC)
+					return err;
+				goto err_free;
+			}
 			err = -ENOSPC;
 			goto err_free;
 		} while (1);
 
+		if (flags & GPU_BUDDY_CLEAR_ALLOCATION)
+			block_clear = gpu_buddy_block_is_clear(block);
+
+		if (!gpu_buddy_block_is_clear(block))
+			gpu_dirty_tracker_remove_range(&mm->dirty,
+						       gpu_buddy_block_offset(block),
+						       gpu_buddy_block_size(mm, block));
+
 		mark_allocated(mm, block);
 		mm->avail -= gpu_buddy_block_size(mm, block);
-		if (gpu_buddy_block_is_clear(block))
-			mm->clear_avail -= gpu_buddy_block_size(mm, block);
+
+		block->header &= ~GPU_BUDDY_HEADER_CLEAR;
+		if (block_clear)
+			block->header |= GPU_BUDDY_HEADER_CLEAR;
+
+		gpu_buddy_sync_clear_avail(mm);
 		kmemleak_update_trace(block);
 		list_add_tail(&block->link, &allocated);
 
@@ -1542,6 +2071,7 @@ EXPORT_SYMBOL(gpu_buddy_print);
 
 static void gpu_buddy_module_exit(void)
 {
+	kmem_cache_destroy(slab_extents);
 	kmem_cache_destroy(slab_blocks);
 }
 
@@ -1551,7 +2081,15 @@ static int __init gpu_buddy_module_init(void)
 	if (!slab_blocks)
 		return -ENOMEM;
 
+	slab_extents = KMEM_CACHE(gpu_dirty_extent, 0);
+	if (!slab_extents)
+		goto err_destroy_blocks;
+
 	return 0;
+
+err_destroy_blocks:
+	kmem_cache_destroy(slab_blocks);
+	return -ENOMEM;
 }
 
 module_init(gpu_buddy_module_init);
diff --git a/drivers/gpu/tests/gpu_buddy_test.c b/drivers/gpu/tests/gpu_buddy_test.c
index 7df5c2ae83bb..e31f368ada95 100644
--- a/drivers/gpu/tests/gpu_buddy_test.c
+++ b/drivers/gpu/tests/gpu_buddy_test.c
@@ -38,7 +38,7 @@ static void gpu_test_buddy_subtree_offset_alignment_stress(struct kunit *test)
 	};
 	struct list_head allocated[ARRAY_SIZE(alignments)];
 	unsigned int i, max_subtree_align = 0;
-	int ret, tree, order;
+	int ret, order;
 	struct gpu_buddy mm;
 
 	KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_init(&mm, mm_size, SZ_4K),
@@ -78,15 +78,11 @@ static void gpu_test_buddy_subtree_offset_alignment_stress(struct kunit *test)
 		}
 
 		for (order = mm.max_order; order >= 0 && !root; order--) {
-			for (tree = 0; tree < 2; tree++) {
-				node = mm.free_trees[tree][order].rb_node;
-				if (node) {
-					root = container_of(node,
-							    struct gpu_buddy_block,
-							    rb);
-					break;
-				}
-			}
+			node = mm.free_tree[order].rb_node;
+			if (node)
+				root = container_of(node,
+						    struct gpu_buddy_block,
+						    rb);
 		}
 
 		KUNIT_ASSERT_NOT_NULL(test, root);
@@ -97,15 +93,13 @@ static void gpu_test_buddy_subtree_offset_alignment_stress(struct kunit *test)
 		gpu_buddy_free_list(&mm, &allocated[i], 0);
 
 		for (order = 0; order <= mm.max_order; order++) {
-			for (tree = 0; tree < 2; tree++) {
-				node = mm.free_trees[tree][order].rb_node;
-				if (!node)
-					continue;
-
-				block = container_of(node, struct gpu_buddy_block, rb);
-				max_subtree_align = max(max_subtree_align,
-							block->subtree_max_alignment);
-			}
+			node = mm.free_tree[order].rb_node;
+			if (!node)
+				continue;
+
+			block = container_of(node, struct gpu_buddy_block, rb);
+			max_subtree_align = max(max_subtree_align,
+						block->subtree_max_alignment);
 		}
 
 		KUNIT_EXPECT_GE(test, max_subtree_align, ilog2(alignments[i]));
diff --git a/include/linux/gpu_buddy.h b/include/linux/gpu_buddy.h
index e037714563d8..0fde5c33ccbd 100644
--- a/include/linux/gpu_buddy.h
+++ b/include/linux/gpu_buddy.h
@@ -8,6 +8,7 @@
 
 #include <linux/bitops.h>
 #include <linux/list.h>
+#include <linux/mempool.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
 #include <linux/rbtree.h>
@@ -43,8 +44,8 @@
 /**
  * GPU_BUDDY_CLEAR_ALLOCATION - Prefer pre-cleared (zeroed) memory
  *
- * Attempt to allocate from the clear tree first. If insufficient clear
- * memory is available, falls back to dirty memory. Useful when the
+ * Attempt to allocate outside dirty-tracked ranges first. If insufficient
+ * clear memory is available, falls back to dirty memory. Useful when the
  * caller needs zeroed memory and wants to avoid GPU clear operations.
  */
 #define GPU_BUDDY_CLEAR_ALLOCATION		BIT(3)
@@ -53,8 +54,8 @@
  * GPU_BUDDY_CLEARED - Mark returned blocks as cleared
  *
  * Used with gpu_buddy_free_list() to indicate that the memory being
- * freed has been cleared (zeroed). The blocks will be placed in the
- * clear tree for future GPU_BUDDY_CLEAR_ALLOCATION requests.
+ * freed has been cleared (zeroed). The blocks will be removed from the
+ * dirty tracker for future GPU_BUDDY_CLEAR_ALLOCATION requests.
  */
 #define GPU_BUDDY_CLEARED			BIT(4)
 
@@ -67,15 +68,6 @@
  */
 #define GPU_BUDDY_TRIM_DISABLE			BIT(5)
 
-enum gpu_buddy_free_tree {
-	GPU_BUDDY_CLEAR_TREE = 0,
-	GPU_BUDDY_DIRTY_TREE,
-	GPU_BUDDY_MAX_FREE_TREES,
-};
-
-#define for_each_free_tree(tree) \
-	for ((tree) = 0; (tree) < GPU_BUDDY_MAX_FREE_TREES; (tree)++)
-
 /**
  * struct gpu_buddy_block - Block within a buddy allocator
  *
@@ -103,6 +95,13 @@ struct gpu_buddy_block {
 #define   GPU_BUDDY_ALLOCATED	   (1 << 10)
 #define   GPU_BUDDY_FREE	   (2 << 10)
 #define   GPU_BUDDY_SPLIT	   (3 << 10)
+/*
+ * GPU_BUDDY_HEADER_CLEAR has two roles:
+ *  - FREE state:      set when the block's full range is cleared (dirty
+ *                     tracker confirmed no overlap).
+ *  - ALLOCATED state: set when the block was served from cleared memory,
+ *                     informing the caller that no GPU clear pass is needed.
+ */
 #define GPU_BUDDY_HEADER_CLEAR  GENMASK_ULL(9, 9)
 /* Free to be used, if needed in the future */
 #define GPU_BUDDY_HEADER_UNUSED GENMASK_ULL(8, 6)
@@ -130,11 +129,49 @@ struct gpu_buddy_block {
 /* private: */
 	struct list_head tmp_link;
 	unsigned int subtree_max_alignment;
+	bool has_clear;
+	bool subtree_has_clear;
 };
 
 /* Order-zero must be at least SZ_4K */
 #define GPU_BUDDY_MAX_ORDER (63 - 12)
 
+/**
+ * struct gpu_dirty_extent - a contiguous dirty address range
+ *
+ * Tracks a single contiguous address range whose memory content is known
+ * to be dirty.  Extents are non-overlapping and stored in an augmented
+ * red-black tree sorted by @start.  The augmented value @subtree_max_size
+ * allows O(log N) search for an extent of at least a given size.
+ */
+struct gpu_dirty_extent {
+/* private: */
+	struct rb_node	rb;
+	u64		start;
+	u64		end;
+	u64		subtree_max_size;
+};
+
+/**
+ * struct gpu_dirty_tracker - tracks dirty address intervals
+ *
+ * Maintains a set of non-overlapping dirty extents as an augmented
+ * red-black tree.
+ *
+ * @total_dirty: Total bytes of dirty memory currently tracked.
+ * @extent_pool: Mempool backing extent node allocations. sashiko reported
+ *		 that a __GFP_NOFAIL allocation on the free path could
+ *		 deadlock during memory reclaim, so a per-tracker mempool is
+ *		 used to guarantee extent nodes without __GFP_NOFAIL.
+ */
+struct gpu_dirty_tracker {
+/* private: */
+	struct rb_root	root;
+	mempool_t	*extent_pool;
+/* public: */
+	u64		total_dirty;
+};
+
 /**
  * struct gpu_buddy - GPU binary buddy allocator
  *
@@ -152,20 +189,24 @@ struct gpu_buddy_block {
  * @chunk_size: Minimum allocation granularity in bytes. Must be at least SZ_4K.
  * @size: Total size of the address space managed by this allocator in bytes.
  * @avail: Total free space currently available for allocation in bytes.
- * @clear_avail: Free space available in the clear tree (zeroed memory) in bytes.
- *               This is a subset of @avail.
+ * @clear_avail: Free space that is clear (zeroed) in bytes. A subset of @avail.
+ *               Maintained as @avail - dirty.total_dirty, since the tracker
+ *               records the dirty extents. Zero at init, as a fresh pool is
+ *               fully dirty.
  * @lock_dep_map: Annotates gpu_buddy API with a driver provided lock.
  */
 struct gpu_buddy {
 /* private: */
+	/* Tracker of dirty address ranges (decoupled from free_tree). */
+	struct gpu_dirty_tracker dirty;
 	/*
-	 * Array of red-black trees for free block management.
-	 * Indexed as free_trees[clear/dirty][order] where:
-	 * - Index 0 (GPU_BUDDY_CLEAR_TREE): blocks with zeroed content
-	 * - Index 1 (GPU_BUDDY_DIRTY_TREE): blocks with unknown content
-	 * Each tree holds free blocks of the corresponding order.
+	 * One RB-tree per order containing all free blocks (clear and
+	 * dirty alike).  The augment field subtree_has_clear lets clear
+	 * allocations find subtrees with clear inventory in O(log N).
+	 * Dirty free blocks coexist here but are also indexed by the
+	 * @dirty tracker for fast dirty allocation lookups.
 	 */
-	struct rb_root **free_trees;
+	struct rb_root *free_tree;
 	/*
 	 * Array of root blocks representing the top-level blocks of the
 	 * binary tree(s). Multiple roots exist when the total size is not

base-commit: 7a4b7122a623e3d57fc15cf843a9d45fbd72c6ab
-- 
2.34.1

