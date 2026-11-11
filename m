Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3465606A320
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 04:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=tzbNCkFU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D2D910E16A;
	Wed, 11 Nov 2026 04:50:03 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011046.outbound.protection.outlook.com [52.101.57.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB66010E05F;
 Wed, 11 Nov 2026 04:49:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PCFtlOAdGVT2GBNzkgLo18HNOQDpq8PhOyNI5bFzlq1J/Ptcr4/8vr+nLOxs3q54dJr4SKPGOFsk13O/WchUZq/h+MrPrWYEB4zuaDKALK1lClMYEqnwLpON8proShsQF1b1e9LbnwC1BCONUYmS/mcvnQ9SV74jQsRANxHRXbYtvXMEmUQh7/ApHUJe1l8rbj945CUpsQD8NjBoqffIRkYzWKulXmrqoYp6xlmWPRCg0ibwmv+iQ8HWRPRUiX4fffBFujOtAWIF4dzOq97S54IZ62306294QwyHkoVzunfGw8kZKIJ/3F2xzhSeI1Mch/10vI/Ynch7z4+Qc5DlVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VEY9DVcFamJN5iBoLeCuLgDkIwALHkOgZ1VMcGYMD6o=;
 b=I8409MyDyBJoKuobBb+L4ZukaAj68gGxIQeUNFJiDbaCYH6+tpPN1J2jjf71/64bU8htzNUNbAPj+W/1lkBEziYefO1m8Kg2u3avXPhIzkaigpmefcY2prkJCecJkzuf2O8vYrRB4YKdizrWU9/C3BJdRxXvQwZs8CRCX+5oTm2uACpQk9hsyp27Tr+zgh24VLUMkp0yMyFY61rKRmvQRLRqb/vtV6d2L4Jjqpmt3/3DD2DUddW6dm6D5alppAFU+ci4qg/IJNudHcHyzFw8w5faeQZ8lDX8hbZnOZ580pKx4GVRhQWWlVGsVnPNeIOVAXFwm5efO2YyG/0Y6P7JJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VEY9DVcFamJN5iBoLeCuLgDkIwALHkOgZ1VMcGYMD6o=;
 b=tzbNCkFUdrWZcl+ChgK4IyYgmvksj+gc3FQZKFl9H5M7lNXZXqqWtds1x1nkfQ9MfaQumdk1FzuT5spT7UesG8nsKnXI2Oj3t5UNAivU0VvUMGAlvv0sr5EiIa04MY2ilEohgPCMFGhe/r0lYw32kXzGJyofI82N9qTsJ2ZoJO0=
Received: from CH3P221CA0016.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::8)
 by DM4PR12MB6159.namprd12.prod.outlook.com (2603:10b6:8:a8::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.13; Wed, 11 Nov 2026 04:49:49 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:610:1e7:cafe::a5) by CH3P221CA0016.outlook.office365.com
 (2603:10b6:610:1e7::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 11
 Nov 2026 04:49:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.0 via Frontend Transport; Wed, 11 Nov 2026 04:49:48 +0000
Received: from rtg-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Tue, 10 Nov 2026 22:49:45 -0600
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
To: <matthew.auld@intel.com>, <dri-devel@lists.freedesktop.org>,
 <intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <Anand.Raghavendra@amd.com>, Arunpravin Paneer Selvam
 <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v5] gpu/buddy: restore two-pass clear/dirty guard for
 range-biased allocation
Date: Wed, 11 Nov 2026 10:19:10 +0530
Message-ID: <20261111044910.333192-1-arunpravin.paneerselvam@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|DM4PR12MB6159:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d4c522c-6bf7-4858-1317-08df3faf3742
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|376014|36860700016|18002099003|10067099003|261021123027099003|261102123227099003|11063799006|56012099006|261021121427099003|261009223027099003|261022075727099003|261026121527099003|261022105027099003|261026140227099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: /6+l3q/LEAO6SdD3zMpXeCrs/HoWbGlMwLIeGbFbTGvfhoLf5nYBUnk9qGGXQQrhdKHKRFX9ejgCKhTbo1EcvKC6/xj4AC80YqK+PSaX2KN7QV4PI0nB5r0L/B+hwQUA5F16buMvPPQtSYzwx88KfXDi6uGM1tCTwk4dEqnvP1+E8UsZfa17HkoaSGBr9eR3hM42k8IhCIDD6CzjHkI0FzlwXMGZLbDxN8aSKXXSL5EhF9ePWawtmIvWo71TW8zOhJ4L7/fGAbm2fNcP0NS5+W10/8ar5Z7dQ76qamHDLPpI4Rypr4NNSLQEpz89WWExvU7q/MFbRELOI1WDu70e2dqQFszYNR11Sfulnjduaiv2Mze2WFCCpv8x3IUuz7yVFRHZ3IyY0BEmNYMUkUdytgsSwxXJVY4Gfz6SQwpQ3bUNpJqLfI4CIrXDPpAw6EEy8+8lciz+yhY+SZMlOwwVkRP4fuUEMkLEdcr1MA5SSA9Bd0AP6KdtCPSi7WJ7XAUWdDxmsaUvVH/4UqO+vwcHZJ3W/HT/cnbQUq2FV9A85K5oTUyEhjMI5/NqEUmby2ltHG3j2TMk8usmijS2jsqZy159pHQ3Bs4oPRm6ubnHvUP7B8tyqj3SpQ/L391JmaGwFu60pUZz/7ax2kshQePveOKeuctXLy4/F4BcTVsJ+PYasp/yL8gLN82cCFOU6wB5/pp/bcDi0B9MaGI/XOKcMA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(376014)(36860700016)(18002099003)(10067099003)(261021123027099003)(261102123227099003)(11063799006)(56012099006)(261021121427099003)(261009223027099003)(261022075727099003)(261026121527099003)(261022105027099003)(261026140227099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XJGkHTOrv1zq0pzkK2CX1yWNbuOZ2iXV6TOkkgUaR2gQCWJ2M6MskDULQl+vOb0SUv+b81Ak6hPqzut1WSjbmAiyeu1FNBQV5e3XhfQUjC+TXknIeNXJZVHPmjlKr20JTmFCNsOtI20hGx3eD7wh+qrMECHb/hudhENp9czruZG7lkB2l3n+2LYiR8dsHFgyc8Z7ft1bwIKExNzmUVPkl9FTKKQDIZMbI47FnLqrua/wB1VLnrYYyDL7TnpthJe4GpMbdKvfAHK75KZ7a383R6HSOnx0IdhglCHwMOdEwfCpfzyJ+mI/QFkxJIiTgR/1HK7TUy1AZcCwYJaDuoBNWKbUdRluKKTVqKee8fdnB3aVhnsYN8O4JJu/8AUvDmDLk1qdoat5OZ5lf1ze9ThaH8i0T1zziDe+dEC2nTVulmvCLE/uykoLKT6EmyU4+xPa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 04:49:48.8376 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d4c522c-6bf7-4858-1317-08df3faf3742
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6159
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

v5: skip the strict pass when free space is all one class (no clear space
    or no dirty space), since a second pass cannot find anything new, e.g.
    drivers like xe that do not use clear tracking (Matthew).

Fixes: 1ad5e807f716 ("gpu/buddy: replace dual-tree/force_merge with decoupled dirty tracker")
Assisted-by: LLM
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
---
 drivers/gpu/buddy.c                | 85 +++++++++++++++++-------------
 drivers/gpu/tests/gpu_buddy_test.c | 84 +++++++++++++++++++++++++++++
 2 files changed, 132 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
index 2888dc0c2f2d..e7d2212bcec9 100644
--- a/drivers/gpu/buddy.c
+++ b/drivers/gpu/buddy.c
@@ -1236,11 +1236,23 @@ static void __gpu_buddy_undo_splits(struct gpu_buddy *mm,
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
@@ -1254,9 +1266,7 @@ __alloc_range_bias(struct gpu_buddy *mm,
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
@@ -1292,8 +1302,19 @@ __alloc_range_bias(struct gpu_buddy *mm,
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
@@ -1311,38 +1332,8 @@ __alloc_range_bias(struct gpu_buddy *mm,
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
@@ -1357,6 +1348,26 @@ __alloc_range_bias(struct gpu_buddy *mm,
 	return ERR_PTR(err);
 }
 
+static struct gpu_buddy_block *
+__gpu_buddy_alloc_range_bias(struct gpu_buddy *mm,
+			     u64 start, u64 end,
+			     unsigned int order,
+			     unsigned long flags)
+{
+	struct gpu_buddy_block *block;
+	bool fallback;
+
+	fallback = !(gpu_buddy_clear_avail(mm) && mm->dirty.total_dirty);
+
+	block = __alloc_range_bias(mm, start, end, order,
+				   flags, fallback);
+	if (IS_ERR(block) && !fallback)
+		return __alloc_range_bias(mm, start, end, order,
+					  flags, true);
+
+	return block;
+}
+
 /* Return the highest-address free block of at least @order. */
 static struct gpu_buddy_block *
 get_maxblock(struct gpu_buddy *mm,
@@ -1920,7 +1931,7 @@ __gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
 
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

base-commit: 1116f4aee916ca13d3e40ce87e67835f51576fcb
-- 
2.43.0

