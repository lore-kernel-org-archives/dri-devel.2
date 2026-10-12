Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD9F6CA9ED2
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 11:16:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36F1D10F004;
	Mon, 12 Oct 2026 11:16:46 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D806410E556;
 Mon, 12 Oct 2026 11:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791803800; x=1823339800;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nC7w8ycdrL5mYwsmDYAxaGkjCP5cQJZBMJfUsfUVp00=;
 b=d2ExX83KgPOCd8L2rHcawYnlO1Od/tfHhq+5wfiK9Idn0QsDeloLSwUr
 y7IwlU3BgiNTz4/DKnellR3tnkQb8olw/aZBo57dhTuIFvv1ENKTWh3RS
 qc7yoyGaYQrw96W6J69Q/mc55waz7qcAGcnxF34wa+s3BU18nsZ9HG+ge
 WcurvZDs4quir1+3yxSAkp4QCxE46UF65ofZ4SNHH9OHSooBkXc+eBQ2b
 BwdV8iA//Dxi0DLhe+rdrnFxC7g4azc7RxK/qaMa5CvK4jG+G1zvV7HCR
 K9y3wOKGL/oF+2+/FRRubSSGgUPJz4MZ5so016jUUfnh08hR9uDg4JXnb A==;
X-CSE-ConnectionGUID: csjWHW4YQt+Ism+gRg2dRA==
X-CSE-MsgGUID: xHj72k5USi6XJzLA9qdD2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="408264"
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="408264"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 04:16:40 -0700
X-CSE-ConnectionGUID: 3aTPJo99TO6uYM6xugCPdw==
X-CSE-MsgGUID: UAnDahYmRY6V3dN9xIfRAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="975566"
Received: from yadavs-z690i-a-ultra-plus.iind.intel.com ([10.190.216.90])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 04:16:38 -0700
From: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org, Matthew Auld <matthew.auld@intel.com>,
 Arun Pravin <arunpravin.paneerselvam@amd.com>,
 Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH 2/2] gpu/tests/buddy: Add range-bias pruning and free-order
 tracking tests
Date: Mon, 12 Oct 2026 16:40:47 +0530
Message-ID: <20298d0d2eb7f62ed5f75c460710c4e13fc94aee.1791802549.git.sanjay.kumar.yadav@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1791802549.git.sanjay.kumar.yadav@intel.com>
References: <cover.1791802549.git.sanjay.kumar.yadav@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

gpu_test_buddy_range_bias_pruning fills a 128 MiB range of a 512 MiB
manager with 4K range allocations. It checks top-down placement, that
the exhausted range advertises GPU_BUDDY_NO_FREE_ORDER, -ENOSPC inside
the range while space outside stays usable, and that freed holes are
found again. To check pruning itself, it hides the only free block
behind an ancestor that advertises no free space and expects -ENOSPC;
without pruning the search would return that block. Allocation time is
reported but not asserted.

gpu_test_buddy_free_order_tracking covers root creation, split,
allocation, partial and full coalescing (4K vs 64K), rollback of a
partially satisfied request, gpu_buddy_block_trim() with and without an
explicit start, exact-range, clear and top-down allocations, and
teardown.

Both use a helper that checks every block's subtree_max_free_order
against its state and its children.

Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Arun Pravin <arunpravin.paneerselvam@amd.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>
Assisted-by: LLM
Signed-off-by: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
---
 drivers/gpu/tests/gpu_buddy_test.c | 307 +++++++++++++++++++++++++++++
 1 file changed, 307 insertions(+)

diff --git a/drivers/gpu/tests/gpu_buddy_test.c b/drivers/gpu/tests/gpu_buddy_test.c
index b75d32ca6ca0..4c7e823d5789 100644
--- a/drivers/gpu/tests/gpu_buddy_test.c
+++ b/drivers/gpu/tests/gpu_buddy_test.c
@@ -1586,6 +1586,311 @@ static void gpu_test_buddy_addr_to_block(struct kunit *test)
 	gpu_buddy_fini(&mm);
 }
 
+static bool gpu_test_block_is_split(struct gpu_buddy_block *block)
+{
+	return (block->header & GPU_BUDDY_HEADER_STATE) == GPU_BUDDY_SPLIT;
+}
+
+static void gpu_test_check_free_order(struct kunit *test, struct gpu_buddy *mm)
+{
+	struct gpu_buddy_block *block, *bad = NULL;
+	unsigned int nr_bad = 0;
+	s8 expected, bad_expected = 0;
+	LIST_HEAD(dfs);
+	unsigned int i;
+
+	for (i = 0; i < mm->n_roots; i++)
+		list_add_tail(&mm->roots[i]->tmp_link, &dfs);
+
+	while ((block = list_first_entry_or_null(&dfs, struct gpu_buddy_block,
+						 tmp_link))) {
+		list_del(&block->tmp_link);
+
+		if (gpu_buddy_block_is_free(block)) {
+			expected = gpu_buddy_block_order(block);
+		} else if (gpu_test_block_is_split(block)) {
+			expected = max(block->left->subtree_max_free_order,
+				       block->right->subtree_max_free_order);
+			list_add(&block->right->tmp_link, &dfs);
+			list_add(&block->left->tmp_link, &dfs);
+		} else {
+			expected = GPU_BUDDY_NO_FREE_ORDER;
+		}
+
+		if (block->subtree_max_free_order != expected && !nr_bad++) {
+			bad = block;
+			bad_expected = expected;
+		}
+	}
+
+	KUNIT_EXPECT_EQ_MSG(test, nr_bad, 0U,
+			    "first stale block: offset=%#llx order=%u stored=%d expected=%d",
+			    bad ? gpu_buddy_block_offset(bad) : 0,
+			    bad ? gpu_buddy_block_order(bad) : 0,
+			    bad ? bad->subtree_max_free_order : 0, bad_expected);
+}
+
+static struct gpu_buddy_block *
+gpu_test_find_block(struct gpu_buddy *mm, u64 offset, unsigned int order)
+{
+	struct gpu_buddy_block *block;
+	unsigned int i;
+
+	for (i = 0; i < mm->n_roots; i++) {
+		u64 start;
+
+		block = mm->roots[i];
+		start = gpu_buddy_block_offset(block);
+		if (offset < start || offset >= start + gpu_buddy_block_size(mm, block))
+			continue;
+
+		while (gpu_buddy_block_order(block) > order) {
+			if (!gpu_test_block_is_split(block))
+				return NULL;
+			block = offset < gpu_buddy_block_offset(block->right) ?
+				block->left : block->right;
+		}
+		return block;
+	}
+
+	return NULL;
+}
+
+static struct gpu_buddy_block *
+gpu_test_take_block(struct list_head *blocks, u64 offset)
+{
+	struct gpu_buddy_block *block;
+
+	list_for_each_entry(block, blocks, link) {
+		if (gpu_buddy_block_offset(block) == offset) {
+			list_del(&block->link);
+			return block;
+		}
+	}
+
+	return NULL;
+}
+
+static void gpu_test_buddy_range_bias_pruning(struct kunit *test)
+{
+	const u64 mm_size = SZ_512M, range_end = SZ_128M, chunk = SZ_4K;
+	const unsigned int nr = range_end / chunk, window = 1024;
+	const u64 holes[] = { 0, range_end / 2 + 3 * chunk };
+	struct gpu_buddy_block *block, *hidden;
+	u64 first_ns = 0, last_ns = 0;
+	unsigned int i, misplaced = 0;
+	LIST_HEAD(allocated);
+	struct gpu_buddy mm;
+	LIST_HEAD(tmp);
+	int err;
+
+	KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_init(&mm, mm_size, chunk),
+			       "buddy_init failed\n");
+	KUNIT_ASSERT_EQ(test, mm.n_roots, 1U);
+
+	/*
+	 * Small-BAR pattern: order-0 allocations confined to a low prefix of a
+	 * larger manager. Top-down placement packs them right below range_end,
+	 * so without pruning every allocation walks all previously allocated
+	 * blocks and the total cost is quadratic.
+	 */
+	for (i = 0; i < nr; i++) {
+		ktime_t start = ktime_get();
+		u64 elapsed;
+
+		err = gpu_buddy_alloc_blocks(&mm, 0, range_end, chunk, chunk,
+					     &allocated, GPU_BUDDY_RANGE_ALLOCATION);
+		elapsed = ktime_to_ns(ktime_sub(ktime_get(), start));
+		KUNIT_ASSERT_EQ_MSG(test, err, 0, "range alloc %u failed\n", i);
+
+		if (i < window)
+			first_ns += elapsed;
+		else if (i >= nr - window)
+			last_ns += elapsed;
+
+		block = list_last_entry(&allocated, struct gpu_buddy_block, link);
+		if (gpu_buddy_block_offset(block) != range_end - (u64)(i + 1) * chunk)
+			misplaced++;
+	}
+
+	kunit_info(test, "first %u range allocs: %llu us, last %u: %llu us\n",
+		   window, first_ns / NSEC_PER_USEC, window, last_ns / NSEC_PER_USEC);
+
+	/* Top-down placement inside the range is unchanged */
+	KUNIT_EXPECT_EQ(test, misplaced, 0U);
+
+	/* The exhausted range advertises no free space, so it is pruned */
+	block = gpu_test_find_block(&mm, 0, ilog2(range_end / chunk));
+	KUNIT_ASSERT_NOT_NULL(test, block);
+	KUNIT_EXPECT_EQ(test, block->subtree_max_free_order, GPU_BUDDY_NO_FREE_ORDER);
+	gpu_test_check_free_order(test, &mm);
+
+	KUNIT_EXPECT_EQ(test, gpu_buddy_alloc_blocks(&mm, 0, range_end, chunk, chunk,
+						     &tmp, GPU_BUDDY_RANGE_ALLOCATION),
+			-ENOSPC);
+
+	KUNIT_ASSERT_FALSE(test, gpu_buddy_alloc_blocks(&mm, 0, mm_size, chunk, chunk,
+							&tmp, 0));
+	block = list_first_entry(&tmp, struct gpu_buddy_block, link);
+	KUNIT_EXPECT_GE(test, gpu_buddy_block_offset(block), range_end);
+	gpu_buddy_free_list(&mm, &tmp, 0);
+
+	/* A single hole, including the very last one in walk order, is found */
+	for (i = 0; i < ARRAY_SIZE(holes); i++) {
+		block = gpu_test_take_block(&allocated, holes[i]);
+		KUNIT_ASSERT_NOT_NULL(test, block);
+		gpu_buddy_free_block(&mm, block);
+		gpu_test_check_free_order(test, &mm);
+
+		KUNIT_ASSERT_FALSE(test, gpu_buddy_alloc_blocks(&mm, 0, range_end,
+								chunk, chunk, &allocated,
+								GPU_BUDDY_RANGE_ALLOCATION));
+		block = list_last_entry(&allocated, struct gpu_buddy_block, link);
+		KUNIT_EXPECT_EQ(test, gpu_buddy_block_offset(block), holes[i]);
+	}
+
+	/*
+	 * Deterministic pruning check: hide the only free block in the range
+	 * behind an ancestor that advertises no free space. Without pruning the
+	 * search would walk into that subtree and return the block.
+	 */
+	block = gpu_test_take_block(&allocated, holes[1]);
+	KUNIT_ASSERT_NOT_NULL(test, block);
+	gpu_buddy_free_block(&mm, block);
+	hidden = gpu_test_find_block(&mm, holes[1], 4);
+	KUNIT_ASSERT_NOT_NULL(test, hidden);
+	KUNIT_ASSERT_EQ(test, hidden->subtree_max_free_order, (s8)0);
+
+	hidden->subtree_max_free_order = GPU_BUDDY_NO_FREE_ORDER;
+	err = gpu_buddy_alloc_blocks(&mm, 0, range_end, chunk, chunk, &tmp,
+				     GPU_BUDDY_RANGE_ALLOCATION);
+	hidden->subtree_max_free_order = 0;
+	KUNIT_EXPECT_EQ(test, err, -ENOSPC);
+	gpu_buddy_free_list(&mm, &tmp, 0);
+	gpu_test_check_free_order(test, &mm);
+
+	gpu_buddy_free_list(&mm, &allocated, 0);
+	gpu_test_check_free_order(test, &mm);
+	KUNIT_EXPECT_EQ(test, mm.roots[0]->subtree_max_free_order, (s8)mm.max_order);
+
+	gpu_buddy_fini(&mm);
+}
+
+static void gpu_test_buddy_free_order_tracking(struct kunit *test)
+{
+	const u64 chunk = SZ_4K;
+	struct gpu_buddy_block *block;
+	LIST_HEAD(allocated);
+	struct gpu_buddy mm;
+	u64 start, avail;
+	LIST_HEAD(big);
+	unsigned int i;
+
+	KUNIT_ASSERT_FALSE(test, gpu_buddy_init(&mm, SZ_8M + SZ_2M + SZ_64K, chunk));
+	KUNIT_EXPECT_EQ(test, mm.n_roots, 3U);
+	for (i = 0; i < mm.n_roots; i++)
+		KUNIT_EXPECT_EQ(test, mm.roots[i]->subtree_max_free_order,
+				(s8)gpu_buddy_block_order(mm.roots[i]));
+	gpu_test_check_free_order(test, &mm);
+	gpu_buddy_fini(&mm);
+
+	KUNIT_ASSERT_FALSE(test, gpu_buddy_init(&mm, SZ_16M, chunk));
+	KUNIT_ASSERT_EQ(test, mm.n_roots, 1U);
+	for (i = 0; i < SZ_4M / chunk; i++)
+		KUNIT_ASSERT_FALSE(test, gpu_buddy_alloc_blocks(&mm, 0, SZ_4M, chunk, chunk,
+								&allocated,
+								GPU_BUDDY_RANGE_ALLOCATION));
+	gpu_test_check_free_order(test, &mm);
+
+	/* Partial coalescing up to order 3 must not satisfy a 64K request */
+	for (i = 0; i < SZ_64K / chunk - 1; i++) {
+		block = gpu_test_take_block(&allocated, SZ_1M + i * chunk);
+		KUNIT_ASSERT_NOT_NULL(test, block);
+		gpu_buddy_free_block(&mm, block);
+	}
+	gpu_test_check_free_order(test, &mm);
+
+	/* A partially satisfied request is rolled back on -ENOSPC */
+	avail = mm.avail;
+	KUNIT_EXPECT_EQ(test, gpu_buddy_alloc_blocks(&mm, 0, SZ_4M, SZ_128K, chunk, &big,
+						     GPU_BUDDY_RANGE_ALLOCATION),
+			-ENOSPC);
+	KUNIT_EXPECT_EQ(test, mm.avail, avail);
+	KUNIT_EXPECT_TRUE(test, list_empty(&big));
+	gpu_test_check_free_order(test, &mm);
+
+	KUNIT_EXPECT_EQ(test, gpu_buddy_alloc_blocks(&mm, 0, SZ_4M, SZ_64K, SZ_64K, &big,
+						     GPU_BUDDY_RANGE_ALLOCATION),
+			-ENOSPC);
+	gpu_test_check_free_order(test, &mm);
+
+	/* SPLIT -> FREE: the last buddy coalesces the window into a 64K block */
+	block = gpu_test_take_block(&allocated, SZ_1M + SZ_64K - chunk);
+	KUNIT_ASSERT_NOT_NULL(test, block);
+	gpu_buddy_free_block(&mm, block);
+	gpu_test_check_free_order(test, &mm);
+	KUNIT_ASSERT_FALSE(test, gpu_buddy_alloc_blocks(&mm, 0, SZ_4M, SZ_64K, SZ_64K, &big,
+							GPU_BUDDY_RANGE_ALLOCATION));
+	block = list_last_entry(&big, struct gpu_buddy_block, link);
+	KUNIT_EXPECT_EQ(test, gpu_buddy_block_offset(block), (u64)SZ_1M);
+	KUNIT_EXPECT_EQ(test, gpu_buddy_block_size(&mm, block), (u64)SZ_64K);
+	gpu_test_check_free_order(test, &mm);
+
+	/* Trim with an explicit start re-allocates inside the detached block */
+	start = SZ_1M + SZ_16K;
+	KUNIT_ASSERT_FALSE(test, gpu_buddy_block_trim(&mm, &start, SZ_16K, &big));
+	KUNIT_ASSERT_TRUE(test, list_is_singular(&big));
+	block = list_first_entry(&big, struct gpu_buddy_block, link);
+	KUNIT_EXPECT_EQ(test, gpu_buddy_block_offset(block), start);
+	KUNIT_EXPECT_EQ(test, gpu_buddy_block_size(&mm, block), (u64)SZ_16K);
+	gpu_test_check_free_order(test, &mm);
+
+	/* Exact-range allocation */
+	KUNIT_ASSERT_FALSE(test, gpu_buddy_alloc_blocks(&mm, SZ_8M, SZ_8M + SZ_256K,
+							SZ_256K, chunk, &big, 0));
+	gpu_test_check_free_order(test, &mm);
+
+	/* Cleared frees, clear range allocation and top-down allocation */
+	gpu_buddy_free_list(&mm, &big, GPU_BUDDY_CLEARED);
+	gpu_test_check_free_order(test, &mm);
+	KUNIT_ASSERT_FALSE(test, gpu_buddy_alloc_blocks(&mm, SZ_4M, SZ_16M, SZ_128K, chunk,
+							&big,
+							GPU_BUDDY_RANGE_ALLOCATION |
+							GPU_BUDDY_CLEAR_ALLOCATION));
+	gpu_test_check_free_order(test, &mm);
+	KUNIT_ASSERT_FALSE(test, gpu_buddy_alloc_blocks(&mm, 0, SZ_16M, SZ_1M, chunk, &big,
+							GPU_BUDDY_TOPDOWN_ALLOCATION));
+	gpu_test_check_free_order(test, &mm);
+
+	gpu_buddy_free_list(&mm, &big, 0);
+	gpu_buddy_free_list(&mm, &allocated, 0);
+	gpu_test_check_free_order(test, &mm);
+	KUNIT_EXPECT_EQ(test, mm.roots[0]->subtree_max_free_order, (s8)mm.max_order);
+	gpu_buddy_fini(&mm);
+
+	/*
+	 * Contiguous non-power-of-two allocations are trimmed, which re-allocates
+	 * inside a temporarily detached block. Ancestors must still be updated.
+	 */
+	KUNIT_ASSERT_FALSE(test, gpu_buddy_init(&mm, SZ_32K, chunk));
+	KUNIT_ASSERT_EQ(test, mm.n_roots, 1U);
+	for (i = 0; i < 2; i++) {
+		KUNIT_ASSERT_FALSE(test, gpu_buddy_alloc_blocks(&mm, 0, SZ_32K,
+								SZ_8K + SZ_4K, chunk,
+								&allocated,
+								GPU_BUDDY_CONTIGUOUS_ALLOCATION));
+		gpu_test_check_free_order(test, &mm);
+	}
+	KUNIT_EXPECT_EQ(test, mm.roots[0]->subtree_max_free_order, (s8)0);
+	KUNIT_EXPECT_EQ(test, gpu_buddy_alloc_blocks(&mm, 0, SZ_32K, SZ_8K, SZ_8K, &big,
+						     GPU_BUDDY_RANGE_ALLOCATION),
+			-ENOSPC);
+
+	gpu_buddy_free_list(&mm, &allocated, 0);
+	gpu_test_check_free_order(test, &mm);
+	gpu_buddy_fini(&mm);
+}
+
 static int gpu_buddy_suite_init(struct kunit_suite *suite)
 {
 	while (!random_seed)
@@ -1612,6 +1917,8 @@ static struct kunit_case gpu_buddy_tests[] = {
 	KUNIT_CASE(gpu_test_buddy_offset_aligned_allocation),
 	KUNIT_CASE(gpu_test_buddy_subtree_offset_alignment_stress),
 	KUNIT_CASE(gpu_test_buddy_addr_to_block),
+	KUNIT_CASE(gpu_test_buddy_range_bias_pruning),
+	KUNIT_CASE(gpu_test_buddy_free_order_tracking),
 	{}
 };
 
-- 
2.52.0

