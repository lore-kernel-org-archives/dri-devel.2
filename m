Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B570DCA601E
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 10:06:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11953112011;
	Fri,  9 Oct 2026 10:06:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NFQAe/Q+";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013070.outbound.protection.outlook.com
 [40.107.201.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF35710E64D;
 Fri,  9 Oct 2026 10:06:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mKrMPp7q+aAlGjV++o+ayqiu8y+KWqBzwJCwdDo5qDUcosPFTI6tZUd7Sdey4mX0r6p+nIrkrqijaLUerhM/Qlx12HBzF9PhZKV2sH3uiENbnh1JWXBGlkkc+JRvfTjBchdlBn289h3V+BVp4aMLonJCNZxh6dzs+PQxDxWWLoLcPPqK6Lhsc8MYK5GogVI05nDb3beNQePU13qTFbqaPKfQ5nCtH7vu+A8AlbJWCgz0WwzbSOK95a2bA2FQUwJzy4CVdUiln29bk9+o1fYAyddChwEAAHsXAZ5l4GGH9oQnOiBKZu5w6Hug68mQ7HWvH/IfB+dwEvGFWZPBVQrPKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8H1RgCNvu8L83g361yS8M4lT5DixtdxleYKHsTptmRg=;
 b=KpkxnglkPD+1ImfXNYKZim9w4V2OkFnyytI9OrN0vn36kD6djZcVoNp97waM8sOuM00/X8kytfmfh4O6zH24dUCktwCpMgpMp8q50vpLSBQG1qxhuywoPdOGZGnmi45k8Z95l8gwTdTQybB/aUq7wl85+AkthjP7q5H2U4108VQrTQhNe36dpSESR1lAn9+E/idnlRmmcF7qWjeTSi4OB6BwhjpssOD7CPyQ0JfM4yU5YP8xj5nA1uk4cB1st5of0EpTlc6KBwWoa5pif1jZHmX2geH3GKSZVA35dFiBLvnrN2uc0OcN1yH+wryG5JHT+h2XVW4HwhK0RO//hEX/IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8H1RgCNvu8L83g361yS8M4lT5DixtdxleYKHsTptmRg=;
 b=NFQAe/Q+JjpOJJKXnDOH8qOBsQlLGpJnauDwmwTo6uOpshRW0j57QxiQcV45RnOdZBAjAXy+G6wZODpZLnN3d6CAa5F60NfQca4VsUZ0l6wp5OtKtrHmzNgVsanQKTD3FQhO8zlZ0cx2/a/3E0P45a4cbUNxOx59tuTM6RrUSS8=
Received: from PH7P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:326::22)
 by PH8PR12MB999296.namprd12.prod.outlook.com (2603:10b6:510:40e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 10:06:02 +0000
Received: from SA2PEPF00003F67.namprd04.prod.outlook.com
 (2603:10b6:510:326:cafe::44) by PH7P220CA0005.outlook.office365.com
 (2603:10b6:510:326::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Fri, 9
 Oct 2026 10:06:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F67.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 9 Oct 2026 10:06:02 +0000
Received: from rtg-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 05:05:54 -0500
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
To: <matthew.auld@intel.com>, <dri-devel@lists.freedesktop.org>,
 <intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <Anand.Raghavendra@amd.com>, Arunpravin Paneer Selvam
 <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v4 1/3] gpu/buddy: restore two-pass clear/dirty guard for
 range-biased allocation
Date: Fri, 9 Oct 2026 15:35:44 +0530
Message-ID: <20261009100546.1103622-1-arunpravin.paneerselvam@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F67:EE_|PH8PR12MB999296:EE_
X-MS-Office365-Filtering-Correlation-Id: 6505c4dc-82e2-4437-c7b2-08df25ecec90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|56012099006|11063799006|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: W3ownb6no7wSM7vu2Sx0Il05933I2NcDZh7VFVCXkcLdkYkSq8GHIS/7Igrd9v7z/m5U6nPFRosGlrUdXvwBhvx3owkD808Bm1ImVQZbEoXy8PPh+lTOfWqrJUNhoUMSMJ56CqL6atEWMdLbHWCCiuQFKN1ffj9r0jsbUuTNjhZQ65r/67x5OFHvgTAtemoyklI9aMKWtK2Ku1Utd+LWsG0+lrRupz37zYhKc/E2a0kZIOhXZlJZ+xpNXWtgGPp20W2btIab8QqEeF6EURtgm2IfAzYvhfly66Cr4SBYCsFGHjHaw9T19mJ2hHySJeaY2SiW/hqymPsRoiS81UwLT0zytJ5NJC5JditDXwl73McusLHXJETWLhngaKpiZ/xqMdGJjtdL416+QTEn1cJgZJjuEub5nuTDuppbW2u7zxmS6JLL5+SPkxb/RVKbUMA1vzRj+0OyGeYbzF5qdF/mOF1Oe6QxbKtKocKvnlmERc+1lJRBclBk1tdWmovNhnzUmcsgrt+wcoplJTWoXh+phxkoI37qSZTbwikT27ImN1dgwTo4d1WJfEJuuxG4fe7yze8LLJ0WXi2eIrpsPIa+FES9OBONLT9Ul+5PgR/9PElJZDRRtqnwyzp/kHJl4eFSPS8BvqGRJMUrBJFdJHwkVGIWJGWBArIc25v151CpHLJ6RQv5WnVIbDYyi/rTXU0Y+0j26MgihWXg7Ue4oR1wlw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(56012099006)(11063799006)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: il3fcBw3RD/s2Q1oexcW77Aajrkvgkc3OLUawJVkExfTUuDuGr77yIXQBcp63QQecSrVZWJkdkpN3R43bn+11e0L28g3qsYDjKvgoCcFuBPaA81Yi5dA+6dHIWEn3EXYJSl8UWtk3nhwvkYvtGPia3EaNaZ+0Dmt+E++nXFreJf5BLgO3tLetxnbPEQUQDCFZApbTGb9oX1jwVsGaAfqGMreAANPmWZR1sc6Hrds2RaHXfXHWKdNXGw0IrMiNcLGyDeiYZKGvq2qD8qVcsw6jZMHVb6E01P5pF7fiZc5YzYf787o2Th4JiLRahwzBX+OlNlExBKS7HDmwbefVmjdYuPpfu84B64Zxh/X2pRpmaIY3uzX5UDI7Nb3WtUzjaWB9IYolX5qVTJZqStpSJB/NmlLQXTGE76sUpe0JglleUTbkScc4jthpdJ6sCqpzKBP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 10:06:02.0663 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6505c4dc-82e2-4437-c7b2-08df25ecec90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F67.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB999296
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
index 2f2aaadafe35..6566bad4fef1 100644
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

base-commit: f146c6086b792cb2c6b3ce5106f0cce62e408df8
-- 
2.43.0

