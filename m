Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A18E60A2629
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 12:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=CV/HL4/R
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF8AD10FDC7;
	Wed, 21 Oct 2026 12:18:40 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010031.outbound.protection.outlook.com
 [52.101.193.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D794A10FA81;
 Wed, 21 Oct 2026 12:18:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RUnHYbmKgNujMSqxWTVR1NgKWnYwbmRZIfG00qDbeTmVa+BnXoDl2BY+kHR8YQAcMBKKk+hM5QFFWn/oTXKtAo/i3WgXnyu2OqLt6jFPjY4JUX5tBVQ2oEugAjf43xv5PnD5UjB3kRV2HlQt502S2P5wZBPj5MI0uj0LmIGRUwcUur8jjl3YXvjn1I4nhRGk7gqCb7GYyV/7hk9EaadnNU1Gy9u9qUsyUnekR2r41SzGi/lOW8NBERqULT4KuvKH4Vv6m/S0u2mxHkYFfWAIeaZW+Rzyjstp/zRpHKUlneIrMQkvzVKyG3CsUh0rV0IWQjN3EerI7ju0+DPQCqBabA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6agj6RtN9RPwDLZEPhejJIHUb/f0r7UciL/gDBWKsio=;
 b=HbQTB4IVxkzYOzq6i7dsrCutfPBw0mv+SisBx+5SdvJH5kv6gQKiJwZcreflesOkozRVeey5zgObkX+gX8XFF6s0Kmo9HBgU65T831HcK+kpKJhN6Wtx9ZMRO6B939iX8bSOnR+cK2hUVpIxlTDItKrUb1yr37A8z8heDFzLzG1Fn0Q1Tou1giKl+4IlgFCeNe21NyUFbvEhzNow8jtp3GiMUU5ZimQNQmQC/9Pfbd6GvDqcJbWiH/VliqDgVy5NjP2WAevJFjkdZy0xe3myGPQLgdJauvJf+FHn2U+NGLDfj0FCdJYjsLISxZ8hQ1o8ZPit9UsANeXMMAX9D2nXjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6agj6RtN9RPwDLZEPhejJIHUb/f0r7UciL/gDBWKsio=;
 b=CV/HL4/RfbQ0Pppgn03xxdnq7Y6XqVZ2yKoVaFaha/btlwbQJAJ+Z/+d0kpcBz8WtfeMujryqeAaNPohRSUD9wNs4JUc1mJiFz6sckt5muMiwOUHmiELZhA8+0c2oPxDksyV5kdfpYwCBEdW1PYevNzoY3XHurcyzGGnfZQOB2o=
Received: from PH7PR17CA0049.namprd17.prod.outlook.com (2603:10b6:510:325::26)
 by SA3PR12MB324197.namprd12.prod.outlook.com (2603:10b6:806:536::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 12:18:32 +0000
Received: from PH2PEPF00048919.namprd05.prod.outlook.com
 (2603:10b6:510:325:cafe::99) by PH7PR17CA0049.outlook.office365.com
 (2603:10b6:510:325::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Wed,
 21 Oct 2026 12:18:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH2PEPF00048919.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 12:18:31 +0000
Received: from rtg-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Wed, 21 Oct 2026 07:18:28 -0500
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
To: <matthew.auld@intel.com>, <dri-devel@lists.freedesktop.org>,
 <intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <Anand.Raghavendra@amd.com>, Arunpravin Paneer Selvam
 <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v6 1/2] gpu/buddy: restore two-pass clear/dirty guard for
 range-biased allocation
Date: Wed, 21 Oct 2026 17:48:12 +0530
Message-ID: <20261021121813.1820345-1-arunpravin.paneerselvam@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH2PEPF00048919:EE_|SA3PR12MB324197:EE_
X-MS-Office365-Filtering-Correlation-Id: a1994310-ffb8-4532-97f5-08df2f6d6bf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|56012099006|5023799004|11063799006|261009223027099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: dE3buH9l8Ul6i5pq7e+ThGGoK0aIspvrd5Muacuqnnc4dlCKVKgcqML1IYFMQKRDDQHz/mwoYhiW/FuY2rFdpmrjSvBjRD9UWvdXHrpNoIF9JxnXzFtZXx1KD1LJ5JgV/mCU3uSoatKAYK/PBuPaMeqKWK0o3G9sGJ/B4R25A1s5wuA4IkvYbWpjjE8p9A5QnWO9g0FFWSjpdOoZd/i8Q8CmA119WIRvcbDxnUPWd1ESEEQ93l2iiF4z+jzEHGrpWo2DX4OBvD3joc7eamEbaxnPrjuoyxFFyaXC2PwUIqvo/qcWpMqM68G8LqmUV+eCgfgSzFzIEOByVjPnBb0w1duu5dtMGMLPFl8oACkxhc8hqbC9bXG7WzNdGDflwGnrL28XHGEBWzq8vo/ARhKyOcz6zDLySIXbGybV8rthltGymAjRobzfX9Yj8osXwzeVSHxna3th3f6P38Aq+92SNvngkAGoevLTmWQ39+WC/Ni2p//6kRz+SjX4u0hnd+Gw17b4OniQ6lr24J5XVIf/U8M7H4G3AbFP6HOxZNQS1g0xgX8q1lGp6T6qyyA3kZHWjsEpxw2ZWaCDV1CNcXneZ8Pfj7zpBN02Pg7cegofTnMGewf4+82eaUVMXa+DT57aC62rT1VkGSxwRVp1efc2EsdznwYgCJlT2zOpSpxHoNuzJVWRIQuegMlNf2YI3LUhMkVqqcQz7enfTg/bY58kOw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(56012099006)(5023799004)(11063799006)(261009223027099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pdoqPqlqhsiizqRkb5bsayHAaHPGRi7hWp35RBz8ib6Qo8NK8u5QsDQfOXESYQOCMkCZnnCryrxrFyUUR1K3u4E0h0MqPYYj00aXogPJbcBoNBkabF3Y/nFWFsuYqvnI8epPcKmLBWZASfv7pcFT/9c1nRpZbNpzCEY+UKhbH/XQ6x69ipDgvnI2H0shLjUaxtKGlJdxkVY0Lj1DoCX2L+4KnRbP/jNPueH5Qy8BnKqup7W8PNGbdvlxB/PDmCmkpY424nfaTolOvUBfSkSQDrVWZHLrXMPe3wovmXsWIvjAVeYSAAQFcw/0FBotSNNCF/BCcags1xbNv856zHHRSR5zNqggi6Aq75fqtKt7jaHXwMHikyWsfHIY3Sh3bqeqzavb+AI8v2LVuMk1S2vZ/f4gCkTBxV9wmVeqA8ki49drguBTHhAUaJphHTBB0/k8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 12:18:31.7992 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1994310-ffb8-4532-97f5-08df2f6d6bf5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH2PEPF00048919.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB324197
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

Fixes: 1ad5e807f716 ("gpu/buddy: replace dual-tree/force_merge with decoupled dirty tracker")
Assisted-by: LLM
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/buddy.c                | 112 ++++++++++++++++++----------
 drivers/gpu/tests/gpu_buddy_test.c | 114 +++++++++++++++++++++++++++++
 2 files changed, 189 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
index 503f7d5934e4..8eb5835d6944 100644
--- a/drivers/gpu/buddy.c
+++ b/drivers/gpu/buddy.c
@@ -1240,11 +1240,46 @@ static void __gpu_buddy_undo_splits(struct gpu_buddy *mm,
 	}
 }
 
+static void unsplit_block(struct gpu_buddy *mm,
+			  struct gpu_buddy_block *block)
+{
+	unsigned int child_order = gpu_buddy_block_order(block) - 1;
+
+	rbtree_remove(mm, block->left);
+	rbtree_remove(mm, block->right);
+	mm->free_scoreboard[child_order] -= 2;
+
+	gpu_block_free(mm, block->left);
+	gpu_block_free(mm, block->right);
+	block->left = NULL;
+	block->right = NULL;
+
+	__mark_free(mm, block, gpu_block_cached_state(block));
+}
+
+static bool block_incompatible(struct gpu_buddy_block *block,
+			       unsigned int order,
+			       unsigned long flags)
+{
+	bool needs_clear = flags & GPU_BUDDY_CLEAR_ALLOCATION;
+
+	if (!gpu_buddy_block_is_free(block))
+		return false;
+
+	if (gpu_buddy_block_order(block) == order)
+		return needs_clear ? !gpu_buddy_block_is_clear(block) :
+				     block->has_clear;
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
@@ -1258,9 +1293,7 @@ __alloc_range_bias(struct gpu_buddy *mm,
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
@@ -1277,6 +1310,17 @@ __alloc_range_bias(struct gpu_buddy *mm,
 
 		list_del(&block->tmp_link);
 
+		/*
+		 * We split this block earlier and found nothing compatible in
+		 * either child; merge it back before moving on.
+		 */
+		if (gpu_buddy_block_is_split(block) &&
+		    gpu_buddy_block_is_free(block->left) &&
+		    gpu_buddy_block_is_free(block->right)) {
+			unsplit_block(mm, block);
+			continue;
+		}
+
 		if (gpu_buddy_block_order(block) < order)
 			continue;
 
@@ -1298,6 +1342,9 @@ __alloc_range_bias(struct gpu_buddy *mm,
 				continue;
 		}
 
+		if (!fallback && block_incompatible(block, order, flags))
+			continue;
+
 		if (contains(start, end, block_start, block_end) &&
 		    order == gpu_buddy_block_order(block)) {
 			/*
@@ -1313,40 +1360,13 @@ __alloc_range_bias(struct gpu_buddy *mm,
 			err = split_block(mm, block);
 			if (unlikely(err))
 				goto err_undo;
-		}
-
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
+			/* Revisit after the children so the split can be undone. */
+			list_add(&block->tmp_link, &dfs);
 		}
+
+		list_add(&block->left->tmp_link, &dfs);
+		list_add(&block->right->tmp_link, &dfs);
 	} while (1);
 
 	return ERR_PTR(-ENOSPC);
@@ -1361,6 +1381,24 @@ __alloc_range_bias(struct gpu_buddy *mm,
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
@@ -1924,7 +1962,7 @@ __gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
 
 	if (flags & GPU_BUDDY_RANGE_ALLOCATION) {
 		/* Allocate traversing within the range */
-		block = __alloc_range_bias(mm, start, end, order, flags);
+		block = __gpu_buddy_alloc_range_bias(mm, start, end, order, flags);
 		if (!IS_ERR(block) || !steered)
 			return block;
 
diff --git a/drivers/gpu/tests/gpu_buddy_test.c b/drivers/gpu/tests/gpu_buddy_test.c
index b75d32ca6ca0..b78e3307958b 100644
--- a/drivers/gpu/tests/gpu_buddy_test.c
+++ b/drivers/gpu/tests/gpu_buddy_test.c
@@ -1597,6 +1597,119 @@ static int gpu_buddy_suite_init(struct kunit_suite *suite)
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
+	KUNIT_EXPECT_EQ(test, gpu_buddy_block_offset(block), 0ULL);
+
+	/*
+	 * Coalesced GPU_BLOCK_MIXED subtree:
+	 *
+	 *   [0,  1M)   allocated (result)
+	 *   [1M, 2M)   dirty free
+	 *   [2M, 3M)   clear free  } coalesced into [2M, 4M) GPU_BLOCK_MIXED
+	 *   [3M, 4M)   dirty free  }
+	 *
+	 * A dirty range alloc restricted to [1M, 3M) visits [2M, 4M) first,
+	 * splits it, rejects the clear [2M, 3M) half and must unsplit
+	 * [2M, 4M) before taking [1M, 2M). Otherwise the split leaks.
+	 */
+	KUNIT_ASSERT_FALSE_MSG(test,
+			       gpu_buddy_alloc_blocks(&mm, 2 * chunk, 3 * chunk, chunk, chunk,
+						      &high_clear_a, GPU_BUDDY_RANGE_ALLOCATION),
+			       "alloc [2M, 3M) failed\n");
+	KUNIT_ASSERT_FALSE_MSG(test,
+			       gpu_buddy_alloc_blocks(&mm, 3 * chunk, 4 * chunk, chunk, chunk,
+						      &high_clear_b, GPU_BUDDY_RANGE_ALLOCATION),
+			       "alloc [3M, 4M) failed\n");
+	gpu_buddy_free_list(&mm, &barrier, 0);
+	gpu_buddy_free_list(&mm, &high_clear_a, GPU_BUDDY_CLEARED);
+	gpu_buddy_free_list(&mm, &high_clear_b, 0);
+
+	KUNIT_ASSERT_FALSE_MSG(test,
+			       gpu_buddy_alloc_blocks(&mm, chunk, 3 * chunk, chunk, chunk,
+						      &low_dirty, GPU_BUDDY_RANGE_ALLOCATION),
+			       "dirty range alloc [1M, 3M) failed\n");
+	block = list_first_entry(&low_dirty, struct gpu_buddy_block, link);
+	KUNIT_EXPECT_FALSE(test, gpu_buddy_block_is_clear(block));
+	KUNIT_EXPECT_EQ(test, gpu_buddy_block_offset(block), (u64)chunk);
+
+	/* The rejected split of [2M, 4M) must have been merged back. */
+	KUNIT_EXPECT_EQ(test, mm.free_scoreboard[0], 0ULL);
+	KUNIT_EXPECT_EQ(test, mm.free_scoreboard[1], 1ULL);
+
+	/* A clear alloc must descend into the mixed [2M, 4M) block. */
+	KUNIT_ASSERT_FALSE_MSG(test,
+			       gpu_buddy_alloc_blocks(&mm, 0, mm_size, chunk, chunk,
+						      &high_clear_a,
+						      GPU_BUDDY_RANGE_ALLOCATION |
+						      GPU_BUDDY_CLEAR_ALLOCATION),
+			       "clear range alloc failed\n");
+	block = list_first_entry(&high_clear_a, struct gpu_buddy_block, link);
+	KUNIT_EXPECT_TRUE(test, gpu_buddy_block_is_clear(block));
+	KUNIT_EXPECT_EQ(test, gpu_buddy_block_offset(block), (u64)(2 * chunk));
+
+	gpu_buddy_free_list(&mm, &high_clear_a, GPU_BUDDY_CLEARED);
+	gpu_buddy_free_list(&mm, &low_dirty, 0);
+	gpu_buddy_free_list(&mm, &result, 0);
+	gpu_buddy_fini(&mm);
+}
+
 static struct kunit_case gpu_buddy_tests[] = {
 	KUNIT_CASE(gpu_test_buddy_alloc_limit),
 	KUNIT_CASE(gpu_test_buddy_alloc_optimistic),
@@ -1606,6 +1719,7 @@ static struct kunit_case gpu_buddy_tests[] = {
 	KUNIT_CASE(gpu_test_buddy_alloc_clear),
 	KUNIT_CASE(gpu_test_buddy_alloc_range),
 	KUNIT_CASE(gpu_test_buddy_alloc_range_bias),
+	KUNIT_CASE(gpu_test_buddy_alloc_range_clear_guard),
 	KUNIT_CASE_SLOW(gpu_test_buddy_fragmentation_performance),
 	KUNIT_CASE_SLOW(gpu_test_buddy_dirty_tracker_performance),
 	KUNIT_CASE(gpu_test_buddy_alloc_exceeds_max_order),

base-commit: b3de601e57d983e4a42e27d499516041c11c2bde
-- 
2.43.0

