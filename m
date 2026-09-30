Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEADDCA5FAB
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 06:21:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6830E10F1D5;
	Wed, 30 Sep 2026 06:21:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A6AozZlF";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013018.outbound.protection.outlook.com
 [40.93.201.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A97010F1C7;
 Wed, 30 Sep 2026 06:21:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EWblOq9zFhoJVro+VJ8hiuJVZYAFKIcNi2XymgHg1bCyMiyLXZAWunDWAR7uO7HmXaToWrf1HVBgCWhVh/86NfhFvcirUyfB8V/lspe6RLHh+SfH121aEE+Mm306GzfFefDXlHRZpU0cnXKoVDfJ7EF626WRhF3jpBfDWPDKtJi4D6XHw8+PGwKULVqWRoM7RcRV/I9j6XeiVsuuLf0BPd8hLAdAJ8HnfRvbIZ7PAkVlyQ0hecp5fxk+d6zbEV9hh3NentP4M/sgs14kS3TX8SCguU/LFcdbh6Qz1tjeHIBteeNqOrQpKD37+a+RBspxaCOAOoZ29+RE8ZzZFEcb3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fK9VUZwJFQy9vyClJZhrQF4PHZxboZm6X8Hypra2NQc=;
 b=R9KEEJLmJG/X5Co5aJOX5+UI89R+XADQCiKbluyG3+gmdPWLhVumgPDhfIRcxPI+SnmzCfmMMOwLEdXV50A4pvopKWmTs2xzB6o5PYlwdumJhDMLZ7Rnw5lDHxq8q6anPRaonS/kN6AZrcJBpQXL3XCEB7RdQwspn7kaqBiHZn2lbQy0cFttk0OIAQdIvzUm7iJOxKP3y99AzbQbip513eZig/UeIP2TgeRjsPN8+pel2JhJvIPLO6bxkhqs124Fun7K5tp4FBmdSrbppDx4UIqUT6ugkDkecrIl5MGFnOOHKJSLedDDpEaP/jjAhUcIWTpcn8aZE+HYYqRpeJHE3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fK9VUZwJFQy9vyClJZhrQF4PHZxboZm6X8Hypra2NQc=;
 b=A6AozZlFCK8P7oT1DB7fht+fVgwFbjA+1EbND0p51+aPxObf0a0OevFE1qhVw59HBj49bJh6nV3dNoWzUAL4dbE6CPpru1K046kPVxW4w1JkUZxbdROGv6UZcKyOZboRs9LrVePezoQSQxzsTdXcXVi37QHvVua8JjJ1+L+pdas=
Received: from CH0PR04CA0058.namprd04.prod.outlook.com (2603:10b6:610:77::33)
 by SA1PR12MB8643.namprd12.prod.outlook.com (2603:10b6:806:387::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Wed, 30 Sep
 2026 06:21:42 +0000
Received: from LV8PEPF00000060.namprd02.prod.outlook.com
 (2603:10b6:610:77:cafe::23) by CH0PR04CA0058.outlook.office365.com
 (2603:10b6:610:77::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14 via Frontend Transport; Wed,
 30 Sep 2026 06:21:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 LV8PEPF00000060.mail.protection.outlook.com (10.167.245.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 06:21:42 +0000
Received: from rtg-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 01:21:38 -0500
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
To: <matthew.auld@intel.com>, <dri-devel@lists.freedesktop.org>,
 <intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <Anand.Raghavendra@amd.com>, Arunpravin Paneer Selvam
 <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v2] gpu/buddy: add range-restricted contiguous allocation
 fallback
Date: Wed, 30 Sep 2026 11:51:17 +0530
Message-ID: <20260930062117.585089-1-arunpravin.paneerselvam@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF00000060:EE_|SA1PR12MB8643:EE_
X-MS-Office365-Filtering-Correlation-Id: c1e522ba-f907-4d92-4fd6-08df1ebb1815
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|10067099003|11063799006|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: CTLnzl7HlJsWKcC9IMW2/jtVVE2P1i7vGv8IcJ9f4+WqGw9ZSLseTtWxg8Wk64C/UszhhXOwMy2L4JStJvThERf/wSmoE7oa6HGlNFnNTCXoRYw/xlJMfV8J/58b/b6iV9oz98AtcKBrFkDq/4EwFP3rA5R9jShxYaGDpA65xiAI6x6iKcCMcNxgF+EpjpaBruXrQDhk8EXgLV17cKpZBRDG4aLubQbQvzy0+MkCLXpst4ztYJqM2ucL7q/dwmq/Y/tZ8hOstrK/QfGJtxaT7scv0AQUsA1UpqXxOBHYIhSaGfMu0hL2M8rOgFeuPYHqA6XvRhmB+sVsIIrvx6PQwdkzs/50TcYHHIfdpxn7M31lh5QNsJ3lhSDBhUzG4tkLJM/nbhKD34hvR4Yi1pGopxpKayJkewGRpElEkZ25GziVj8Wre1mYIogsU7mql+0MM9znhuiC7KT6WJqGjbBW1Mdd3jmcL7RwqAcPpy7+YXbR5ojtgIV/N5NxeGwsTJaZPVbQZkicp7o5BI2HpSz8Nfmi4RJRBl68NWtSaI4G+aL28SC0e7TOJuLgGwAIJyTioJPZ8Vej/qLN95xhfi/XhptfZ+aBpuDd314v8A0ONW26vYnxkXcmPsqbnCMv7txaYnCZ8yu19rDOlAE1Jo3EeBkBIJzQqUWfKC+TfFSQvbtTb0D+YwjCQeMDGTPkFepeXQmPfvfy8OH2XTOy+FESIw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(10067099003)(11063799006)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GKNWo4CdwljDqEhcL8kCxbSOIr1aSyS03vA7r/M6LXokd1n9Lc1syMudSBz1IWIT9C7fzbnppKWMJP7IFDQ8dd+B6/vyfcViR5HFq0BbQUAA9w2gbpdpXeo1pvOt5KA0yDiKVjHbu9nI1LO8Jl4U334vseOh9AX+f/xgjPMvwhvvItZibvl48WunFXcan2VfCL3UPe9TXVEj+UHeHY797ytRfO+yc3mMeSiOb3DuZeoQGWAJ8NNvPuKXG75HfmpEhkG+NzHpAijzyndE3yPmLNMOyuRK+wL7gLBWEfLMCoh6TDwyqdPOg0X6aDaX7WM0M9XeR12rAHaAVguED1Q6YY9g297kiR6txHqwNvZwy27mG5kF9xE6Si+jNzt3UXpxFU70mn3h82m1ZI3bU6L74Gk5OVQ7ek9EYWwVApy9ZL7S5dI5BPN48ETDMhWT0m12
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 06:21:42.1237 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1e522ba-f907-4d92-4fd6-08df1ebb1815
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: LV8PEPF00000060.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8643
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

From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

A range + contiguous allocation (e.g. a scanout FB confined to the
CPU-visible VRAM aperture) rounds its size up to a power of two and
requires a naturally aligned free block of that size; on a fragmented
aperture no such aligned block may exist even though enough contiguous
space is free, so the allocation fails with -ENOSPC.

The non-range contiguous path already recovers from this via
__alloc_contig_try_harder(), which stitches an exact-size span from
smaller adjacent blocks, but that fallback was unreachable once
GPU_BUDDY_RANGE_ALLOCATION was set. Give __alloc_contig_try_harder()
a [range_start, range_end) window and route the range + contiguous
case through it: each candidate placement is confined to the window
and aligned to min_block_size. Non-range callers pass [0, mm->size),
where the guards are no-ops, so the existing behaviour is unchanged.
A KUnit regression test covers the fragmentation pattern.

Resolves the igt@kms_plane@plane-panning-bottom-right@pipe-a/pipe-b
regression.

v2:
 - Drop the split-undo patch; the range-bias search always descends to
   an exact-order block or fails the split (already handled), so the
   extra undo was redundant. (Matthew)
 - Verified this fallback alone fixes the kms_plane regression.

Fixes: 1ad5e807f716 ("gpu/buddy: replace dual-tree/force_merge with decoupled dirty tracker")
Assisted-by: Claude:claude-opus-4-8
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/buddy.c                | 88 ++++++++++++++++--------------
 drivers/gpu/tests/gpu_buddy_test.c | 83 ++++++++++++++++++++++++++--
 2 files changed, 126 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
index 2f2aaadafe35..5265e1f6a318 100644
--- a/drivers/gpu/buddy.c
+++ b/drivers/gpu/buddy.c
@@ -1685,26 +1685,14 @@ static int __gpu_buddy_alloc_range(struct gpu_buddy *mm,
 			     blocks, total_allocated_on_err);
 }
 
-static int __alloc_contig_aligned_retry(struct gpu_buddy *mm,
-					u64 unaligned_offset,
-					u64 size,
-					u64 min_block_size,
-					unsigned long flags,
-					struct list_head *blocks)
-{
-	u64 aligned_offset = round_down(unaligned_offset, min_block_size);
-
-	return __gpu_buddy_alloc_range(mm, aligned_offset, size, flags,
-				       NULL, blocks);
-}
-
 static int __alloc_contig_try_harder(struct gpu_buddy *mm,
+				     u64 range_start, u64 range_end,
 				     u64 size,
 				     u64 min_block_size,
 				     unsigned long flags,
 				     struct list_head *blocks)
 {
-	u64 rhs_offset, lhs_offset, filled;
+	u64 rhs_offset, lhs_offset, filled, aligned;
 	struct gpu_buddy_block *block;
 	struct rb_root *root;
 	struct rb_node *iter;
@@ -1734,20 +1722,24 @@ static int __alloc_contig_try_harder(struct gpu_buddy *mm,
 					       flags, &filled, blocks);
 		if (err && err != -ENOSPC)
 			return err;
-		if (!err && IS_ALIGNED(rhs_offset, min_block_size))
+		if (!err && IS_ALIGNED(rhs_offset, min_block_size) &&
+		    rhs_offset >= range_start && rhs_offset + size <= range_end)
 			return 0;
 		if (!err) {
 			/* Allocate the unaligned RHS offset using round_down */
 			gpu_buddy_free_list_internal(mm, blocks);
-			err = __alloc_contig_aligned_retry(mm, rhs_offset,
-							   size,
-							   min_block_size,
-							   flags, blocks);
-			if (!err)
-				return 0;
-			if (err != -ENOSPC) {
-				gpu_buddy_free_list_internal(mm, blocks);
-				return err;
+
+			aligned = round_down(rhs_offset, min_block_size);
+			if (aligned >= range_start &&
+			    aligned + size <= range_end) {
+				err = __gpu_buddy_alloc_range(mm, aligned, size,
+							      flags, NULL, blocks);
+				if (!err)
+					return 0;
+				if (err != -ENOSPC) {
+					gpu_buddy_free_list_internal(mm, blocks);
+					return err;
+				}
 			}
 			goto next;
 		}
@@ -1759,15 +1751,17 @@ static int __alloc_contig_try_harder(struct gpu_buddy *mm,
 
 		/* Allocate the unaligned LHS offset using round_down */
 		gpu_buddy_free_list_internal(mm, blocks);
-		err = __alloc_contig_aligned_retry(mm, lhs_offset,
-						   size,
-						   min_block_size,
-						   flags, blocks);
-		if (!err)
-			return 0;
-		if (err != -ENOSPC) {
-			gpu_buddy_free_list_internal(mm, blocks);
-			return err;
+
+		aligned = round_down(lhs_offset, min_block_size);
+		if (aligned >= range_start && aligned + size <= range_end) {
+			err = __gpu_buddy_alloc_range(mm, aligned, size,
+						      flags, NULL, blocks);
+			if (!err)
+				return 0;
+			if (err != -ENOSPC) {
+				gpu_buddy_free_list_internal(mm, blocks);
+				return err;
+			}
 		}
 next:
 		gpu_buddy_free_list_internal(mm, blocks);
@@ -2021,11 +2015,18 @@ int gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
 	min_order = ilog2(min_block_size) - ilog2(mm->chunk_size);
 
 	if (order > mm->max_order || size > mm->size) {
-		if ((flags & GPU_BUDDY_CONTIGUOUS_ALLOCATION) &&
-		    !(flags & GPU_BUDDY_RANGE_ALLOCATION))
-			return __alloc_contig_try_harder(mm, original_size,
+		if (flags & GPU_BUDDY_CONTIGUOUS_ALLOCATION) {
+			u64 range_start, range_end;
+
+			range_start = (flags & GPU_BUDDY_RANGE_ALLOCATION) ? start : 0;
+			range_end = (flags & GPU_BUDDY_RANGE_ALLOCATION) ? end : mm->size;
+
+			return __alloc_contig_try_harder(mm, range_start,
+							 range_end,
+							 original_size,
 							 original_min_size,
 							 flags, blocks);
+		}
 
 		return -EINVAL;
 	}
@@ -2058,9 +2059,14 @@ int gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
 			 * Try contiguous block allocation through
 			 * try harder method.
 			 */
-			if (flags & GPU_BUDDY_CONTIGUOUS_ALLOCATION &&
-			    !(flags & GPU_BUDDY_RANGE_ALLOCATION)) {
-				err = __alloc_contig_try_harder(mm,
+			if (flags & GPU_BUDDY_CONTIGUOUS_ALLOCATION) {
+				u64 range_start, range_end;
+
+				range_start = (flags & GPU_BUDDY_RANGE_ALLOCATION) ? start : 0;
+				range_end = (flags & GPU_BUDDY_RANGE_ALLOCATION) ? end : mm->size;
+
+				err = __alloc_contig_try_harder(mm, range_start,
+								range_end,
 								original_size,
 								original_min_size,
 								flags,
@@ -2068,9 +2074,9 @@ int gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
 				if (!err)
 					return 0;
 				if (err != -ENOSPC)
-					return err;
-				goto err_free;
+					goto err_free;
 			}
+
 			err = -ENOSPC;
 			goto err_free;
 		} while (1);
diff --git a/drivers/gpu/tests/gpu_buddy_test.c b/drivers/gpu/tests/gpu_buddy_test.c
index b75d32ca6ca0..2c445870b808 100644
--- a/drivers/gpu/tests/gpu_buddy_test.c
+++ b/drivers/gpu/tests/gpu_buddy_test.c
@@ -1251,6 +1251,77 @@ static void gpu_test_buddy_alloc_contiguous(struct kunit *test)
 	gpu_buddy_fini(&mm);
 }
 
+static void gpu_test_buddy_alloc_range_contiguous(struct kunit *test)
+{
+	const unsigned long ps = SZ_4K, mm_size = 16 * ps;
+	const unsigned long range_end = 8 * ps;
+	struct gpu_buddy_block *block, *prev;
+	LIST_HEAD(allocated);
+	struct gpu_buddy mm;
+	LIST_HEAD(pin_lo);
+	LIST_HEAD(pin_hi);
+	u64 total;
+
+	KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_init(&mm, mm_size, ps),
+			       "buddy_init failed\n");
+
+	/*
+	 * Idea is to confine the test to the sub-range [0, 32K), which a 12K
+	 * contiguous request (rounded up to 16K) splits into two naturally
+	 * aligned 16K slots: [0, 16K) and [16K, 32K). We pin the first 4K page
+	 * of each slot ([0, 4K) and [16K, 20K)) so that neither aligned slot
+	 * can satisfy the rounded-up 16K allocation, yet the freed remainder
+	 * still leaves a contiguous 12K hole at offset 4K, which is page-aligned
+	 * but not 16K-aligned. A 12K contiguous+range allocation must therefore
+	 * fall back to stitching that span instead of returning -ENOSPC.
+	 */
+	KUNIT_ASSERT_FALSE_MSG(test,
+			       gpu_buddy_alloc_blocks(&mm, 0, ps, ps, ps,
+						      &pin_lo, 0),
+			       "failed to pin low page\n");
+	KUNIT_ASSERT_FALSE_MSG(test,
+			       gpu_buddy_alloc_blocks(&mm, 4 * ps, 5 * ps, ps,
+						      ps, &pin_hi, 0),
+			       "failed to pin high page\n");
+
+	/* No aligned 16K block is free; the range-aware fallback must stitch
+	 * the unaligned [ps, 4*ps) hole instead of returning -ENOSPC.
+	 */
+	KUNIT_ASSERT_FALSE_MSG(test,
+			       gpu_buddy_alloc_blocks(&mm, 0, range_end, 3 * ps,
+						      ps, &allocated,
+						      GPU_BUDDY_CONTIGUOUS_ALLOCATION |
+						      GPU_BUDDY_RANGE_ALLOCATION),
+			       "range-restricted contiguous alloc failed\n");
+
+	/* The result must be exactly 3*ps, contiguous, and inside the range. */
+	total = 0;
+	prev = NULL;
+	list_for_each_entry(block, &allocated, link) {
+		u64 offset = gpu_buddy_block_offset(block);
+		u64 bsize = gpu_buddy_block_size(&mm, block);
+
+		KUNIT_EXPECT_TRUE_MSG(test, offset + bsize <= range_end,
+				      "block [%llx, %llx) outside range\n",
+				      offset, offset + bsize);
+		if (prev)
+			KUNIT_EXPECT_EQ_MSG(test,
+					    gpu_buddy_block_offset(prev) +
+					    gpu_buddy_block_size(&mm, prev),
+					    offset,
+					    "block at %llx not contiguous\n",
+					    offset);
+		prev = block;
+		total += bsize;
+	}
+	KUNIT_EXPECT_EQ(test, total, 3 * ps);
+
+	gpu_buddy_free_list(&mm, &allocated, 0);
+	gpu_buddy_free_list(&mm, &pin_lo, 0);
+	gpu_buddy_free_list(&mm, &pin_hi, 0);
+	gpu_buddy_fini(&mm);
+}
+
 static void gpu_test_buddy_alloc_pathological(struct kunit *test)
 {
 	u64 mm_size, size, start = 0;
@@ -1534,10 +1605,13 @@ static void gpu_test_buddy_alloc_exceeds_max_order(struct kunit *test)
 				     GPU_BUDDY_RANGE_ALLOCATION);
 	KUNIT_EXPECT_EQ(test, err, -EINVAL);
 
-	/* CONTIGUOUS + RANGE should return -EINVAL (no try_harder for RANGE) */
-	err = gpu_buddy_alloc_blocks(&mm, 0, mm_size, size, SZ_4K, &blocks,
-				     GPU_BUDDY_CONTIGUOUS_ALLOCATION | GPU_BUDDY_RANGE_ALLOCATION);
-	KUNIT_EXPECT_EQ(test, err, -EINVAL);
+	/* CONTIGUOUS + RANGE should succeed via the range-aware try_harder */
+	KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_alloc_blocks(&mm, 0, mm_size, size,
+							    SZ_4K, &blocks,
+							    GPU_BUDDY_CONTIGUOUS_ALLOCATION |
+							    GPU_BUDDY_RANGE_ALLOCATION),
+			       "range contiguous alloc hit an error size=%llu\n", size);
+	gpu_buddy_free_list(&mm, &blocks, 0);
 
 	gpu_buddy_fini(&mm);
 }
@@ -1603,6 +1677,7 @@ static struct kunit_case gpu_buddy_tests[] = {
 	KUNIT_CASE(gpu_test_buddy_alloc_pessimistic),
 	KUNIT_CASE(gpu_test_buddy_alloc_pathological),
 	KUNIT_CASE(gpu_test_buddy_alloc_contiguous),
+	KUNIT_CASE(gpu_test_buddy_alloc_range_contiguous),
 	KUNIT_CASE(gpu_test_buddy_alloc_clear),
 	KUNIT_CASE(gpu_test_buddy_alloc_range),
 	KUNIT_CASE(gpu_test_buddy_alloc_range_bias),

base-commit: 744f262401cc2e1f3827496c72a47e072d31a852
-- 
2.43.0

