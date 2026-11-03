Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0352606A327
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 12:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=RtsLkgGE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4EC710E36D;
	Tue,  3 Nov 2026 12:56:55 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012022.outbound.protection.outlook.com [52.101.48.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 655D210E153;
 Tue,  3 Nov 2026 12:56:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wBShtWc1hau1NUCXZyBOJsRFIdGBoEcs+z9RYRcxtSaTIEtlNdFbrsa8eTWkVTI5e7lzjR7d06QagtHTuZxSphV4uBr+SdMfyQ45eROomB6mSbLztmnGtkMG24NWct3/X9p5vhJx4m3YqyBuCZFfHmcUd53rA/clmHWdwjphROOEQvC+v+OYsj5C89JGHuXb9ZxWAkOZMYPing2ivdW5Kzrc4140oaYY/hb0I3uYE5kBwGnnLZhzdeV/7PZk78bU2GywWDZ2AoHDxoowVc4//gBYXRq07rBqasL1Dx36PPfiSwOItvpb51cU0hJNKJ5wjEbCzBqu3jOJ2tn0lmufOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1N7Ajixe5dTJ5KD0RLgFpkfzM1LR6I/jARTKRhkPgms=;
 b=cJyPO/mEjHccIoZFCiNaE3RcsOHy94OB/YU8DCVDAWqej+XxddOTNPAmxb3fC03gLbc+GRilmhhpXfiI4iADerrMLY/VOlzj7qjDO0c8NNQhKvFUbuCz2Wpu2HyoMxC9nEUGR8clgJsPE0qL5gs+EsHNHnW5yhCTTBnRojcgYERx0BgzcAICw638jehFyzj4HcEyyV0nHnz2fnHXA3GiGvhDFAL1HBsOjuCFQZVwIQ1XFXV1xP9IDEUJPRIXtBXJnfFG7nC1YgINDp+8jB6ZuP6ur348KiXHWY2JBjQDQRbi/EpW5oat/Qhfr5DPelWleMjTPTbglgrt7QiomtxVHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1N7Ajixe5dTJ5KD0RLgFpkfzM1LR6I/jARTKRhkPgms=;
 b=RtsLkgGEachbkW/iisyd+XJ43Qmmj7VFZEqSJuxYeBakh0G9oTiLEXEW2a1c0g0cHsf3+Uld/oMN+Q/35CbiPZ5LjEwBkysAcNrUTYj78WyA+IhHQ0M1sjhb377RJfVyvT+3xO+SzGEFpXiL044R3CAwTXEA1wPoQUV3IYIc9ks=
Received: from PH7P221CA0034.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::11)
 by SN7PR12MB6713.namprd12.prod.outlook.com (2603:10b6:806:273::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 12:56:44 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:510:33c:cafe::3c) by PH7P221CA0034.outlook.office365.com
 (2603:10b6:510:33c::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 12:56:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 12:56:43 +0000
Received: from rtg-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Tue, 3 Nov 2026 06:56:39 -0600
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
To: <matthew.auld@intel.com>, <dri-devel@lists.freedesktop.org>,
 <intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <Anand.Raghavendra@amd.com>, Arunpravin Paneer Selvam
 <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v3] gpu/buddy: restore two-pass clear/dirty guard for
 range-biased allocation
Date: Tue, 3 Nov 2026 18:26:17 +0530
Message-ID: <20261103125617.2480786-1-arunpravin.paneerselvam@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|SN7PR12MB6713:EE_
X-MS-Office365-Filtering-Correlation-Id: ee0d8490-ab92-452d-0af0-08df39a9e949
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|18002099003|56012099006|261009223027099003|261102123227099003|261022105027099003|261022075727099003|261021121427099003|261021123027099003|11063799006|10067099003|261026121527099003|261028144727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: J5LQbbc6OAZGn7RnJ0p4SeWw49v4iLfJ1sKWSdg8zeckH/t2+IKjCnoP3f2zgLP1jPh+35QJ7SIHLn3m2vzppGAW+/rSa+Qyas31BwCykGQROQVgFD315WyiyeYtG2RdIoI9QTBwXwPeRorlRVQP83g1sL7AZ2EeqxmVOzexrBwLLdd36ESuYNhCDuOQ6sEnGz/w25PuikRdF6CBDhrK9mVjMJM1eh93WOeDwzA4FzMJW/1RVx9Bfe9SKCx7/JjQA42yJndB07lJ6bmtVOB84TXtfO1Rt907W6jfzJuqUXvDu57757R5yOaHX+RnndiPPFIBSF0Y55SBqKuW1OFuufFg9pqi72/0poIInjokt+CTt+5602+hLGIShbeBgBiFfLQmjd6ovwGM3KR9ny2Mslp9D9/YV0CNjULYtjXo9DCH5MupGLECUWKemyLO+srqtQgszMHg+rfpL95ljLMN3eqpt63BqrSvQVrIGVWYhGcZlj2t0cTxfPQ8T+dRvxcLh4USr13jErMB+UItKnpd788oGEJ7EaXyMbmvw65YkXjmRAxBYOB3QHnlb2GI56SQe22pCKY03euAscNCy9m11bAdGXGB0XzOE3CETteD7kItNryXW2XtelLUjYcQUdt6rI6k9SRHcGEYz1nOaSjdJpOm1kg1R6jjgfscDAtx2nxsPi5x9xVYmND2X6oaXckS/RPHG0kgvSgeUOkyX7LXAg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(18002099003)(56012099006)(261009223027099003)(261102123227099003)(261022105027099003)(261022075727099003)(261021121427099003)(261021123027099003)(11063799006)(10067099003)(261026121527099003)(261028144727099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: W+fTIbhHPZKFsWclYiVPnTXGM3QBNbDokISS4kUOvImOO/HjDOIMK0vTPGAAMMAHt7kQv0qVHOyKuIx1iQK+IVQceHHXW+SGi9bPWTi80GU/Lk+48D2xYQJ2EGcEzUpRbY5oQSi2jKQgDucOcDEsBHgenCq2bCjBStRRW9ReV5sfhNTpLUSMyDSlM1T6p8IBvC8Ysjm80uJ3WGpBXVCXC+P2lK4dGgGeAieah68R5qDPLZkfvIh0dy0UZgbynxMlXPkwYdXfJfG+M9hmjojKXx+/C//Oks7nAAMicVP0eiKNtd3H3SSOpu08DYxUP0ONShTwgMIAvO1GIy5JSds794RnBOc1tdYEZ1RG+wpZGNpGXa/z2/C1Ud03ZR6h1XJeOaRXBcgi0Zk+yyMJlncvsO3hao4UTxlUT6vFw0FyUCP/C65ba05dNlH1T2FYaCas
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 12:56:43.4745 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee0d8490-ab92-452d-0af0-08df39a9e949
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6713
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

Fixes: 1ad5e807f716 ("gpu/buddy: replace dual-tree/force_merge with decoupled dirty tracker")
Assisted-by: LLM
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/buddy.c                | 75 +++++++++++++-------------
 drivers/gpu/tests/gpu_buddy_test.c | 84 ++++++++++++++++++++++++++++++
 2 files changed, 122 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
index 28cff97d57dc..f2914f919b04 100644
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
@@ -1298,6 +1308,9 @@ __alloc_range_bias(struct gpu_buddy *mm,
 				continue;
 		}
 
+		if (!fallback && block_incompatible(block, flags))
+			continue;
+
 		if (contains(start, end, block_start, block_end) &&
 		    order == gpu_buddy_block_order(block)) {
 			/*
@@ -1315,38 +1328,8 @@ __alloc_range_bias(struct gpu_buddy *mm,
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
@@ -1361,6 +1344,24 @@ __alloc_range_bias(struct gpu_buddy *mm,
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
@@ -1924,7 +1925,7 @@ __gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
 
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

base-commit: 6f7098738fff3ec7393f924343188cb8e6ebc5d2
-- 
2.43.0

