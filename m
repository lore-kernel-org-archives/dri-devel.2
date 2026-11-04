Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4817606A328
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 07:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=5PmACzuA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 497C310E84B;
	Wed,  4 Nov 2026 07:30:00 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011061.outbound.protection.outlook.com [52.101.62.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B7AC10E222;
 Wed,  4 Nov 2026 07:29:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hvev/j6+QDSL8BzsKu1qyJnfiLt9qi2bgL154D9MHYOQNExyAgYdyn9MY/RL30vzCxw8yuDbrsp5YWjSbfbdxwG2ZfiyWkI9OABQ6QGmREW/JoiLJWSgW7jrzDiRa5a3RKO91DPVw39MfZfBthc7VefruhxPK42W4Ehwx7IJ1BuqEkwofo8g+KkEadbmhnc+EQKyk7qw9VLyzVu/8dQn6VhDMPh0ifT/YFZbJsg4HSCgT1InbYEw11z23yig0cvYDPE6jU04/EflgBmVoUOnGIVGIpMUnnX8pYHYOVqLXeM2GBYNowPV21sQfodGff98h9L7SGAUXb22E9PcCmFT6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2zhtvLUf/KbN1TousZAGaqAggEkOP60H4MtQUZz4D1g=;
 b=dvGhuokHlvAUNhsVUhm3a351w0xuP5MO83fS3GGDuFTIdHqqS75WI2Zqt1NxJWJd5RIILOeGQcNhXqEGHWsWwCNj3wNv7Kz4PvMIFr8tjsFFxgSz1TwPDZ1HSzVRwMOZ0U5TAkJr1KcMMuFKYYjcNlY+MIUMA2HpeaVeG782fNhJM+IesMipvfS+F9Cfom0B+wGKgE+kJSn6m+qekADNYPUiCTJBTibDf5t8jQJJrc726GfmeX5DMhe1nMFpc6U/tbImQw5j/40NKMWpzYovMhm4RPqZD8Wt2puYAcJVAmewvQsrEQ3RF8HSqL+sIrC+Dvd3F+KUzT8FjVu85kBPoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zhtvLUf/KbN1TousZAGaqAggEkOP60H4MtQUZz4D1g=;
 b=5PmACzuA3aVb/MPDOPccwaacr/ufdTCEexiNZvCiLQxaxxMNVt6WREwpH23YDEdLBh2owt4OBOwRr3+SZSTgNSrBTbMKQCUagNmFYhXndL9FOxNTjXPlnMiSdsGKOEAc2ZFMqbu6E7QzpW3SI0NXypnA+ATSGtO/6R4/4bFdhJM=
Received: from MN2PR14CA0006.namprd14.prod.outlook.com (2603:10b6:208:23e::11)
 by CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 07:29:05 +0000
Received: from IA0PEPF0000003D.namprd03.prod.outlook.com
 (2603:10b6:208:23e:cafe::99) by MN2PR14CA0006.outlook.office365.com
 (2603:10b6:208:23e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Wed, 4
 Nov 2026 07:29:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 IA0PEPF0000003D.mail.protection.outlook.com (10.167.249.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 07:29:05 +0000
Received: from rtg-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Wed, 4 Nov 2026 01:29:02 -0600
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
To: <matthew.auld@intel.com>, <dri-devel@lists.freedesktop.org>,
 <intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <Anand.Raghavendra@amd.com>, Arunpravin Paneer Selvam
 <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v4] gpu/buddy: restore two-pass clear/dirty guard for
 range-biased allocation
Date: Wed, 4 Nov 2026 12:58:47 +0530
Message-ID: <20261104072847.2617886-1-arunpravin.paneerselvam@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF0000003D:EE_|CY8PR12MB7705:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fb0dbe5-8a85-4acb-453b-08df3a454eab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|10067099003|18002099003|56012099006|11063799006|261022075727099003|261022105027099003|261102123227099003|261026121527099003|261028144727099003|261026140227099003|261021123027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: sJQOwnDvuISB9OWDbDwuMeUvkvZuTzwAGjLePYs/1n4vB4WI8lv4B+EjUVodQvoZcMndCeq2ABJms2E+7HQjOBCNGni5LSMmLTV0ZlLrpyJH/ylTEH6MnIPQrkOvymGGzQs76C3t480D4FalTubdP9s786bTQZu8NJbyvqDtoERzHyPS0Qupfo2hwAgYCByK4Mwm/DrNgczHepOV3WzSBl96kKpBxjaZlYzHSHCB8yk0GbfsB5jdDzHLohhD2ByOChT6UfOSlMg2rlxHClywTev8T5a3qhcWjUCHDDFdVdroTuxij15uCq9DBUpdjvgu3SIAkUsx5wHyKjurhnDqeKR9JYPofShJ5hEdTal+5uMYCqv4Q1XVdQne0v3tQaX33ATHbFcciI82wMUqINch6SJ9cKYEBcrdN34rvMkw3rUNNL2uHH/VzLKFas9UlOTH5+Dt6gsR/CQir8lxZwebF2u//hHgUH4TWEzFiw0VJNjE25B4C06YLe0DwwryRin8YFUkGFACC3SOF9nPgUi936TJI0E+dSUhZVpjc0CfsWY0OlVc51NhmAcu0oB7RLVha33L4iSqD8Cg/wIUTDRLDya5zWVGScXETnzJRjDOAZgSCs/CFSJvQi9Da6L+lH9UfetJsaxKhMkqzqyphuIKwsGCFOvcSQonfI5/GZjo2TqJ6Gb7sOKrXWIHz/1cx0tsAFvUNZ3ZDSMXdBuIRox4Sg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(10067099003)(18002099003)(56012099006)(11063799006)(261022075727099003)(261022105027099003)(261102123227099003)(261026121527099003)(261028144727099003)(261026140227099003)(261021123027099003)(261021121427099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vHYxaLKUbiWAS+4tjhQK5wA9TNmnxqGC0hf/iSCRvYPWXEzmubNYW2xJ5lij6cufocCOlkg58NXV4zHI7cB322l4UnQW1KsK8GLjpHKwKUcol8wj2viTsXflVJ6Bo+yTIxSEU3W0WS8o1SIXITlq4dFtp/9Y7sOWTHUdYhKB3MrXuQDkwH64E+iyCzVopWCpNG8DJq/OM6Cpx4LbASkcvBKaQU2sZIadMzb34clf0cPmS9oKClUK6Xd9tQzsPmZou7ba7OwqIPNAorKN1irg3y+hXaiTPURCLRbTb1RJbHR71Q/W415RUTzf26Y04HRSKM14L3sPYNMyw0jIskSadzgXT37vVQMXZ1pQ7aiEscarb3XufjbkEIem0n4diRdQNh3kG9zlS3FvvIl2J8ah3IunA0tDSzJbteS6KvGzwFNL3bx4x69C4kziLJV3FVH1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 07:29:05.6463 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fb0dbe5-8a85-4acb-453b-08df3a454eab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: IA0PEPF0000003D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7705
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

Range-restricted allocations (the visible-VRAM aperture) skip
dirty_steer_window() and reach __alloc_range_bias() with no clear/dirty
eligibility guard, so a dirty allocation freely splits clear extents (and
vice versa), interleaving the two classes until no large same-class run
survives and a 4K scanout pin fails with -ENOSPC. Use a two-pass range
search instead: block_incompatible() rejects opposite-class blocks in the
strict pass and relaxes only when the strict pass returns -ENOSPC, so a
request still succeeds when only opposite-class space remains. A KUnit
regression test covers the interleaving pattern and fails without the
guard.

v2: the strict pass can split a block and then reject both children, so
    a split no longer implies a compatible block exists. Sashiko reported
    the resulting leaked splits; fix as suggested by Matthew:
 - Push the parent back on the DFS stack after each split and merge it
   back with unsplit_block() if both children are still free.
 - Make block_incompatible() judge free blocks only (split nodes keep a
   stale clear bit) and take the requested order, so mixed blocks that
   can hold a compatible block are descended instead of skipped.
 - Extend the KUnit test with a coalesced mixed block and a check that
   a rejected split is merged back.

v3: igt@kms_plane@plane-panning-bottom-right failed on Radeon RX 9070 XT
    with -ENOSPC: the range allocator's strict pass split mixed blocks to
    look for a wholly-clear (or wholly-dirty) leaf, discarded the mixed
    leaves it found, and ran unsplit_block to merge the splits back, whose
    per-allocation cost and residual fragmentation starved the large
    pipe-A scanout. Fix: accept a mixed block at the requested order as-is
    (caller re-clears), so the first pass no longer splits and discards
    mixed blocks. This clear/dirty compatibility relaxation applies only
    to range-biased allocation, where keeping blocks intact reduces
    fragmentation and preserves large contiguous spaces. The now-unneeded
    unsplit_block helper is dropped.

v4: a higher-order free mixed block straddling the range edge was split in
    the strict pass then abandoned, leaving both children free under a split
    parent that never coalesces, tripping gpu_buddy_fini()'s free-root assert
    and leaking the children (reported by Sashiko). Fix: in the strict pass
    don't split a free block that only partially overlaps the range; the
    fallback pass consumes it (either class accepted).

Fixes: 1ad5e807f716 ("gpu/buddy: replace dual-tree/force_merge with decoupled dirty tracker")
Assisted-by: LLM
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/buddy.c                | 83 ++++++++++++++++-------------
 drivers/gpu/tests/gpu_buddy_test.c | 84 ++++++++++++++++++++++++++++++
 2 files changed, 130 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
index 28cff97d57dc..d9749cbaf05d 100644
--- a/drivers/gpu/buddy.c
+++ b/drivers/gpu/buddy.c
@@ -1240,11 +1240,23 @@ static void __gpu_buddy_undo_splits(struct gpu_buddy *mm,
 	}
 }
 
+static bool block_incompatible(struct gpu_buddy_block *block, unsigned int flags)
+{
+	bool needs_clear = flags & GPU_BUDDY_CLEAR_ALLOCATION;
+
+	if (!gpu_buddy_block_is_free(block))
+		return false;
+
+	return needs_clear ? !block->has_clear :
+			     gpu_buddy_block_is_clear(block);
+}
+
 static struct gpu_buddy_block *
 __alloc_range_bias(struct gpu_buddy *mm,
 		   u64 start, u64 end,
 		   unsigned int order,
-		   unsigned long flags)
+		   unsigned long flags,
+		   bool fallback)
 {
 	u64 req_size = mm->chunk_size << order;
 	struct gpu_buddy_block *block;
@@ -1258,9 +1270,7 @@ __alloc_range_bias(struct gpu_buddy *mm,
 	 * This range-constrained search hands back the highest/right-most
 	 * address that satisfies the request: the roots are seeded high-to-low
 	 * and the right (higher-address) child is descended first, making
-	 * top-down the default placement here. A non-top-down clear request is
-	 * the only exception, where the descent is biased towards clear or
-	 * clear-containing subtrees to satisfy the clear preference.
+	 * top-down the default placement here.
 	 */
 	for (i = mm->n_roots - 1; i >= 0; --i)
 		list_add_tail(&mm->roots[i]->tmp_link, &dfs);
@@ -1296,8 +1306,19 @@ __alloc_range_bias(struct gpu_buddy *mm,
 			if (round_down(adjusted_end + 1, req_size) <=
 			    round_up(adjusted_start, req_size))
 				continue;
+
+			/*
+			 * Strict pass: don't split a partially-overlapping free
+			 * block; rejecting its child would strand the split. Let
+			 * the fallback pass consume it (either class accepted).
+			 */
+			if (!fallback && gpu_buddy_block_is_free(block))
+				continue;
 		}
 
+		if (!fallback && block_incompatible(block, flags))
+			continue;
+
 		if (contains(start, end, block_start, block_end) &&
 		    order == gpu_buddy_block_order(block)) {
 			/*
@@ -1315,38 +1336,8 @@ __alloc_range_bias(struct gpu_buddy *mm,
 				goto err_undo;
 		}
 
-		/*
-		 * Top-down is a strict address-placement policy, so when it is
-		 * requested we ignore clear steering and simply descend the
-		 * right (higher-address) child first. Only a non-top-down clear
-		 * request biases the descent towards clear/has_clear subtrees.
-		 */
-		if ((flags & GPU_BUDDY_CLEAR_ALLOCATION) &&
-		    !(flags & GPU_BUDDY_TOPDOWN_ALLOCATION)) {
-			struct gpu_buddy_block *prefer;
-
-			if (gpu_buddy_block_is_clear(block->right))
-				prefer = block->right;
-			else if (gpu_buddy_block_is_clear(block->left))
-				prefer = block->left;
-			else if (block->right->has_clear)
-				prefer = block->right;
-			else if (block->left->has_clear)
-				prefer = block->left;
-			else
-				prefer = block->right;
-
-			if (prefer == block->right) {
-				list_add(&block->left->tmp_link, &dfs);
-				list_add(&block->right->tmp_link, &dfs);
-			} else {
-				list_add(&block->right->tmp_link, &dfs);
-				list_add(&block->left->tmp_link, &dfs);
-			}
-		} else {
-			list_add(&block->left->tmp_link, &dfs);
-			list_add(&block->right->tmp_link, &dfs);
-		}
+		list_add(&block->left->tmp_link, &dfs);
+		list_add(&block->right->tmp_link, &dfs);
 	} while (1);
 
 	return ERR_PTR(-ENOSPC);
@@ -1361,6 +1352,24 @@ __alloc_range_bias(struct gpu_buddy *mm,
 	return ERR_PTR(err);
 }
 
+static struct gpu_buddy_block *
+__gpu_buddy_alloc_range_bias(struct gpu_buddy *mm,
+			     u64 start, u64 end,
+			     unsigned int order,
+			     unsigned long flags)
+{
+	struct gpu_buddy_block *block;
+	bool fallback = false;
+
+	block = __alloc_range_bias(mm, start, end, order,
+				   flags, fallback);
+	if (IS_ERR(block))
+		return __alloc_range_bias(mm, start, end, order,
+					  flags, !fallback);
+
+	return block;
+}
+
 /* Return the highest-address free block of at least @order. */
 static struct gpu_buddy_block *
 get_maxblock(struct gpu_buddy *mm,
@@ -1924,7 +1933,7 @@ __gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
 
 	if (flags & GPU_BUDDY_RANGE_ALLOCATION) {
 		/* Allocate traversing within the range */
-		block = __alloc_range_bias(mm, start, end, order, flags);
+		block = __gpu_buddy_alloc_range_bias(mm, start, end, order, flags);
 		if (!IS_ERR(block) || !steered)
 			return block;
 
diff --git a/drivers/gpu/tests/gpu_buddy_test.c b/drivers/gpu/tests/gpu_buddy_test.c
index 2c6f1da1a6d1..9aaca2fc6a02 100644
--- a/drivers/gpu/tests/gpu_buddy_test.c
+++ b/drivers/gpu/tests/gpu_buddy_test.c
@@ -1606,6 +1606,89 @@ static int gpu_buddy_suite_init(struct kunit_suite *suite)
 	return 0;
 }
 
+static void gpu_test_buddy_alloc_range_clear_guard(struct kunit *test)
+{
+	const unsigned long chunk = SZ_1M, mm_size = SZ_4M;
+	struct gpu_buddy_block *block;
+	LIST_HEAD(low_dirty);
+	LIST_HEAD(high_a);
+	LIST_HEAD(high_b);
+	LIST_HEAD(barrier);
+	LIST_HEAD(dirty_res);
+	LIST_HEAD(clear_res);
+	struct gpu_buddy mm;
+
+	KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_init(&mm, mm_size, chunk),
+			       "buddy_init failed\n");
+
+	/*
+	 * Idea is to lay out a range allocation as a low dirty block, an
+	 * allocated barrier, and a high naturally-aligned clear extent, then
+	 * issue a dirty range allocation. It must take the low dirty block and
+	 * leave the clear extent intact; if it instead cuts the clear extent,
+	 * a following same-class clear allocation can no longer find a
+	 * contiguous clear run and fails with -ENOSPC.
+	 *
+	 *   [0,  1M)   dirty free
+	 *   [1M, 2M)   allocated  (barrier, keeps the halves un-mergeable)
+	 *   [2M, 4M)   clear free (one naturally aligned 2 MiB extent)
+	 */
+	KUNIT_ASSERT_FALSE_MSG(test,
+			       gpu_buddy_alloc_blocks(&mm, 0, chunk, chunk, chunk,
+						      &low_dirty, GPU_BUDDY_RANGE_ALLOCATION),
+			       "alloc [0, 1M) failed\n");
+	KUNIT_ASSERT_FALSE_MSG(test,
+			       gpu_buddy_alloc_blocks(&mm, chunk, 2 * chunk, chunk, chunk,
+						      &barrier, GPU_BUDDY_RANGE_ALLOCATION),
+			       "alloc [1M, 2M) failed\n");
+	KUNIT_ASSERT_FALSE_MSG(test,
+			       gpu_buddy_alloc_blocks(&mm, 2 * chunk, 3 * chunk, chunk, chunk,
+						      &high_a, GPU_BUDDY_RANGE_ALLOCATION),
+			       "alloc [2M, 3M) failed\n");
+	KUNIT_ASSERT_FALSE_MSG(test,
+			       gpu_buddy_alloc_blocks(&mm, 3 * chunk, 4 * chunk, chunk, chunk,
+						      &high_b, GPU_BUDDY_RANGE_ALLOCATION),
+			       "alloc [3M, 4M) failed\n");
+
+	/* [2M, 4M) coalesces into one aligned clear extent; [0, 1M) stays dirty. */
+	gpu_buddy_free_list(&mm, &low_dirty, 0);
+	gpu_buddy_free_list(&mm, &high_a, GPU_BUDDY_CLEARED);
+	gpu_buddy_free_list(&mm, &high_b, GPU_BUDDY_CLEARED);
+
+	/* Dirty 1 MiB range alloc: must land at [0, 1M), not cut the clear extent. */
+	KUNIT_ASSERT_FALSE_MSG(test,
+			       gpu_buddy_alloc_blocks(&mm, 0, mm_size, chunk, chunk,
+						      &dirty_res, GPU_BUDDY_RANGE_ALLOCATION),
+			       "dirty range alloc failed\n");
+	block = list_first_entry(&dirty_res, struct gpu_buddy_block, link);
+	KUNIT_EXPECT_FALSE_MSG(test, gpu_buddy_block_is_clear(block),
+			       "dirty range alloc cut the clear extent (offset=%llx)\n",
+			       gpu_buddy_block_offset(block));
+	KUNIT_EXPECT_EQ(test, gpu_buddy_block_offset(block), 0ULL);
+
+	/*
+	 * The 2 MiB clear extent must still be intact: a clear order-1 range
+	 * allocation has to succeed. Without the guard the extent was cut
+	 * above and this returns -ENOSPC.
+	 */
+	KUNIT_EXPECT_FALSE_MSG(test,
+			       gpu_buddy_alloc_blocks(&mm, 0, mm_size, 2 * chunk, 2 * chunk,
+						      &clear_res,
+						      GPU_BUDDY_RANGE_ALLOCATION |
+						      GPU_BUDDY_CLEAR_ALLOCATION),
+			       "clear 2M range alloc failed: clear extent was fragmented (-ENOSPC)\n");
+	if (!list_empty(&clear_res)) {
+		block = list_first_entry(&clear_res, struct gpu_buddy_block, link);
+		KUNIT_EXPECT_TRUE(test, gpu_buddy_block_is_clear(block));
+		KUNIT_EXPECT_EQ(test, gpu_buddy_block_offset(block), (u64)(2 * chunk));
+	}
+
+	gpu_buddy_free_list(&mm, &clear_res, GPU_BUDDY_CLEARED);
+	gpu_buddy_free_list(&mm, &dirty_res, 0);
+	gpu_buddy_free_list(&mm, &barrier, 0);
+	gpu_buddy_fini(&mm);
+}
+
 static struct kunit_case gpu_buddy_tests[] = {
 	KUNIT_CASE(gpu_test_buddy_alloc_limit),
 	KUNIT_CASE(gpu_test_buddy_alloc_optimistic),
@@ -1615,6 +1698,7 @@ static struct kunit_case gpu_buddy_tests[] = {
 	KUNIT_CASE(gpu_test_buddy_alloc_clear),
 	KUNIT_CASE(gpu_test_buddy_alloc_range),
 	KUNIT_CASE(gpu_test_buddy_alloc_range_bias),
+	KUNIT_CASE(gpu_test_buddy_alloc_range_clear_guard),
 	KUNIT_CASE_SLOW(gpu_test_buddy_fragmentation_performance),
 	KUNIT_CASE_SLOW(gpu_test_buddy_dirty_tracker_performance),
 	KUNIT_CASE(gpu_test_buddy_alloc_exceeds_max_order),

base-commit: 49f40f15d20f5b4073d517da7efbcea079f1b9e3
-- 
2.43.0

