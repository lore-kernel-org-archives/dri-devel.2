Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EED606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 05:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=pHLGKsmN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FB1B10F215;
	Tue, 20 Oct 2026 05:56:08 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012027.outbound.protection.outlook.com [52.101.43.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77A5410E21D;
 Tue, 20 Oct 2026 05:56:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tNmWLG3WpZwL2nsVZ3zvhY53hjqkYIbC09EPa0K2AvYJ8TA5DbkTU0yYFVR8oVxLkro3uk4/Wy621tUMLWAvjH/1rjcxIvqsvSHkuS6hWSLejGkgWdz34tMMxFTYuowXZnZ2hWuBLcWfiIviVXYPe7xkWFSjfEqG7lnAaZz52KvPip0Z2+l7+OYguHV3bcz1Ugg3FIrJoY9sQPGMoO9Zg5fPvvio+GBETPIoq6gPWpV9geuGanGL7QQ3P2ja1cphRZCSJWelvHoOSh9Hg5BJ0QmTT271Ccs5timAY2A/5b1vT1mLlg1qNl0pl+vAEb9yhgQSui+mNovXBYmMXmZRdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+dTEkvYxQoUPsoELoA5p/0PD9Ul1/Nn4+CfGLTbV3k=;
 b=sT3msqwUF4m5VYS7XNgDhDI1/fEvSNjgTJckOnaYJol8p/ljVXgvaliFZFzZBdS/B7CkRNouVtAB62ypjESvlkV4q/jkz/jTpXL9qcio9H7QsxWXwyERvmEnOL0rV8P1X26+G1u3mmkiSZ4wmjJ1gV7LqwWwYpN7mEMNqFUF+RT3xzRSTuUTu9Q1RpBGZ4huXjZgbGToMzYMCzIKP3/KR4WFT7CGkb358yePqiEStuO7MeOpBszIAHwuEQU3FxO89PvRVDTNvkd9HAbyPs7MYFYathOP1kD1/LXIpC/blIAl4a+P57hWZieAqtJ904vu+woRpBIKacGF/boxXOgy7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+dTEkvYxQoUPsoELoA5p/0PD9Ul1/Nn4+CfGLTbV3k=;
 b=pHLGKsmNmpbNX9wSFZFbZJXNPcXVM1z4172wv/Xu1LgwOibNxfQMcZ3tulEi8syI0f4aWFnnU8aoW+/XZUJIrsOWVav0dqakP13b/6tz8E8mkUYXq4sPvXAyyTZJ6YR144Zz3Mt8B7jBq+wNbupJcNpC7xyzPgwmbNUKlV4LW84=
Received: from CH0PR03CA0403.namprd03.prod.outlook.com (2603:10b6:610:11b::13)
 by SJ5PPFD5E8DE351.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9a4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Tue, 20 Oct
 2026 05:55:55 +0000
Received: from DS8PEPF000000E1.namprd05.prod.outlook.com
 (2603:10b6:610:11b:cafe::a4) by CH0PR03CA0403.outlook.office365.com
 (2603:10b6:610:11b::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Tue,
 20 Oct 2026 05:55:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS8PEPF000000E1.mail.protection.outlook.com (10.167.23.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 20 Oct 2026 05:55:54 +0000
Received: from rtg-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Tue, 20 Oct 2026 00:55:51 -0500
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
To: <matthew.auld@intel.com>, <dri-devel@lists.freedesktop.org>,
 <intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <Anand.Raghavendra@amd.com>, Arunpravin Paneer Selvam
 <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v5 1/2] gpu/buddy: restore two-pass clear/dirty guard for
 range-biased allocation
Date: Tue, 20 Oct 2026 11:25:36 +0530
Message-ID: <20261020055537.1640552-1-arunpravin.paneerselvam@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS8PEPF000000E1:EE_|SJ5PPFD5E8DE351:EE_
X-MS-Office365-Filtering-Correlation-Id: ea3ae078-98f6-4134-a7e8-08df2e6ecde7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|376014|82310400026|56012099006|260925021911599003|260925021311599003|11063799006|260925022911599003|261009223027099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: zFn8kUI07rLZH4wVeAihyCTWDye+Ppy5uAOQN3zAiAoPTJdXNDNHmQUxQzxOfqEkTO5HBup+wKShlnG0kjz9b5Jesef+cst3hCaP6rTbe2vXZ2Ys8wZIiImCRIYEd7odcmArz7JnL4o23g1MT5Ybx1NomfPZ0A6vBMiB12T3gP5EIN2koNS//Z5p9B6bFVSjQqXxKTPHbGmVZGd8HuBytVZIvksyFx/rmii9kixLEdMW8nEeVDsnyzpmtiP8TBbF5Vmblw0RjISUsdHy3aHFajGwAZgPc+1V0iOeEOZngrigyi4rxdPgs+rakjZfe24lZgPqCqL9lfa6uWaun2zsHyS8ZMMTuDQXgLyD/CuVNw+kTSACQ6fZNE8Im4Wcq2m2ZX/l60QjzJ3m0cCJd1lR4g78RylOIhIj8M8P2pwpFprS7IyXrRAGHKFflv/nuWqcq+CaD0YPKln+GWq3x9rqRNU9X5Udb6VVDUQUZgwAGSXWkbSFXCRfBLikocHnZ0OaNYkHD+7aR6Ae0Qme2/94t/5AMFu25BDeD8W82d29fE0f3Ip1knl4RIrra5lOH0lijw5RPLshyF14g/zKe1WYMN6/dlE2MBskUCg6miiym2KhZ2HFmlpwVVhl9QkEgy92NLopP43Fw/wR7Bw8i1iEKHnBl0Yy5PgiWVpmUcMIyQFGlNN63rU1c/DWqatMjIj8G5dXk/lDSTHySVnyzZEBBA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(376014)(82310400026)(56012099006)(260925021911599003)(260925021311599003)(11063799006)(260925022911599003)(261009223027099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: t8gloe20QITyv8aEeK7yYQn2Zf7Rx0gu8CX+IxtUMtBAY8Jm3Phyew9rkuGYZS4HZ3eI9bpWd6eJoPKWPk51whpP+HAb5y+A3Nw1l3m2jd76NOLRPomf4qiHSYdIx8lDFv6/rGKD6n6rlXh81aUX4YzrVCTVx21YgwTBboYhEwI42GS70l9fZeF802yLWS1Ldh7Cm2imFk1YG0cKzu+Q7yApIlFIp/JIbZNmI7P0HXjL64ikZxbDv+cLQzNxww+nJkhe7C9SxiSSmWSnR/76ScypjY8MJiO8E7o9W1b/0hPpTgolpapfVsHOFGmlzvK2RDyG3RFXKDkTLSWPn2IxsT3t7/RBOEnyowAV4wu7qaDWTdOIqh1g1C9IL7xZOaQLriCIKCWp8ZZ3zxQ6ht7NEIcvQKPUL/gHwFoc0UpA1lfQY9pi8m+BxX3ORXqx1TKg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 05:55:54.4908 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea3ae078-98f6-4134-a7e8-08df2e6ecde7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS8PEPF000000E1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFD5E8DE351
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Fixes: 1ad5e807f716 ("gpu/buddy: replace dual-tree/force_merge with decoupled dirty tracker")
Assisted-by: LLM
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/buddy.c                | 71 ++++++++++++++----------------
 drivers/gpu/tests/gpu_buddy_test.c | 65 +++++++++++++++++++++++++++
 2 files changed, 99 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
index 503f7d5934e4..91935c71c525 100644
--- a/drivers/gpu/buddy.c
+++ b/drivers/gpu/buddy.c
@@ -1240,11 +1240,19 @@ static void __gpu_buddy_undo_splits(struct gpu_buddy *mm,
 	}
 }
 
+static bool block_incompatible(struct gpu_buddy_block *block, unsigned int flags)
+{
+	bool needs_clear = flags & GPU_BUDDY_CLEAR_ALLOCATION;
+
+	return needs_clear != gpu_buddy_block_is_clear(block);
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
@@ -1258,9 +1266,7 @@ __alloc_range_bias(struct gpu_buddy *mm,
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
@@ -1298,6 +1304,9 @@ __alloc_range_bias(struct gpu_buddy *mm,
 				continue;
 		}
 
+		if (!fallback && block_incompatible(block, flags))
+			continue;
+
 		if (contains(start, end, block_start, block_end) &&
 		    order == gpu_buddy_block_order(block)) {
 			/*
@@ -1315,38 +1324,8 @@ __alloc_range_bias(struct gpu_buddy *mm,
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
@@ -1361,6 +1340,24 @@ __alloc_range_bias(struct gpu_buddy *mm,
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
@@ -1924,7 +1921,7 @@ __gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
 
 	if (flags & GPU_BUDDY_RANGE_ALLOCATION) {
 		/* Allocate traversing within the range */
-		block = __alloc_range_bias(mm, start, end, order, flags);
+		block = __gpu_buddy_alloc_range_bias(mm, start, end, order, flags);
 		if (!IS_ERR(block) || !steered)
 			return block;
 
diff --git a/drivers/gpu/tests/gpu_buddy_test.c b/drivers/gpu/tests/gpu_buddy_test.c
index b75d32ca6ca0..3eaa261571bf 100644
--- a/drivers/gpu/tests/gpu_buddy_test.c
+++ b/drivers/gpu/tests/gpu_buddy_test.c
@@ -1597,6 +1597,70 @@ static int gpu_buddy_suite_init(struct kunit_suite *suite)
 	return 0;
 }
 
+static void gpu_test_buddy_alloc_range_clear_guard(struct kunit *test)
+{
+	const unsigned long chunk = SZ_1M, mm_size = SZ_4M;
+	struct gpu_buddy_block *block;
+	LIST_HEAD(high_clear_a);
+	LIST_HEAD(high_clear_b);
+	LIST_HEAD(low_dirty);
+	struct gpu_buddy mm;
+	LIST_HEAD(barrier);
+	LIST_HEAD(result);
+
+	KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_init(&mm, mm_size, chunk),
+			       "buddy_init failed\n");
+
+	/*
+	 * Lay out a 4 MiB aperture as three regions:
+	 *
+	 *   [0,  1M)   dirty free
+	 *   [1M, 2M)   allocated  (barrier, keeps the two halves un-mergeable)
+	 *   [2M, 4M)   clear free (one naturally aligned 2 MiB extent)
+	 *
+	 * A dirty (non-clear) range allocation must take the low dirty block
+	 * and leave the large clear extent intact. Without the guard the
+	 * top-down search cuts the higher clear extent instead and returns a
+	 * clear block -- the interleaving that fragments the aperture and
+	 * ultimately fails a large same-class scanout allocation.
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
+						      &high_clear_a, GPU_BUDDY_RANGE_ALLOCATION),
+			       "alloc [2M, 3M) failed\n");
+	KUNIT_ASSERT_FALSE_MSG(test,
+			       gpu_buddy_alloc_blocks(&mm, 3 * chunk, 4 * chunk, chunk, chunk,
+						      &high_clear_b, GPU_BUDDY_RANGE_ALLOCATION),
+			       "alloc [3M, 4M) failed\n");
+
+	/* [2M, 4M) coalesces into one aligned clear extent; [0, 1M) stays dirty. */
+	gpu_buddy_free_list(&mm, &low_dirty, 0);
+	gpu_buddy_free_list(&mm, &high_clear_a, GPU_BUDDY_CLEARED);
+	gpu_buddy_free_list(&mm, &high_clear_b, GPU_BUDDY_CLEARED);
+
+	KUNIT_ASSERT_FALSE_MSG(test,
+			       gpu_buddy_alloc_blocks(&mm, 0, mm_size, chunk, chunk,
+						      &result, GPU_BUDDY_RANGE_ALLOCATION),
+			       "dirty range alloc failed\n");
+
+	block = list_first_entry(&result, struct gpu_buddy_block, link);
+	KUNIT_EXPECT_FALSE_MSG(test, gpu_buddy_block_is_clear(block),
+			       "dirty range alloc cut the clear extent (offset=%llx)\n",
+			       gpu_buddy_block_offset(block));
+
+	gpu_buddy_free_list(&mm, &result, 0);
+	gpu_buddy_free_list(&mm, &barrier, 0);
+	gpu_buddy_fini(&mm);
+}
+
 static struct kunit_case gpu_buddy_tests[] = {
 	KUNIT_CASE(gpu_test_buddy_alloc_limit),
 	KUNIT_CASE(gpu_test_buddy_alloc_optimistic),
@@ -1606,6 +1670,7 @@ static struct kunit_case gpu_buddy_tests[] = {
 	KUNIT_CASE(gpu_test_buddy_alloc_clear),
 	KUNIT_CASE(gpu_test_buddy_alloc_range),
 	KUNIT_CASE(gpu_test_buddy_alloc_range_bias),
+	KUNIT_CASE(gpu_test_buddy_alloc_range_clear_guard),
 	KUNIT_CASE_SLOW(gpu_test_buddy_fragmentation_performance),
 	KUNIT_CASE_SLOW(gpu_test_buddy_dirty_tracker_performance),
 	KUNIT_CASE(gpu_test_buddy_alloc_exceeds_max_order),

base-commit: 2313367894b1f0b9713622c96a36e4098c4bd549
-- 
2.43.0

