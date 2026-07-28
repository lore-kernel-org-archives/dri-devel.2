Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C22F4C54F4C
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 05:48:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1E1010E420;
	Tue, 28 Jul 2026 05:48:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="FQA9Dn1Q";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92F0410E420;
 Tue, 28 Jul 2026 05:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785217707; x=1816753707;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0CXYQa4J0fNoURZr8iDmQ2I1q3gSqH3iFzOiHpnzi4o=;
 b=FQA9Dn1QP2AGKaxED87WzWihO955weX/eJoEouZoCWzJc82Le9TSQ7Ce
 s5XfOpCG03GfYWLC/4cHzbI2LcowAkgjgOm1Cr98zOPxUWZRlDtTRyYEE
 6RXg+yEk6gec3XS6akyjTtm22mOl/d7gJvSpJ6KLkTj4Y3mnMZqdBYHvW
 bWkVTloJ67oV8ajPs04lxfB8Ba9C6hTL5UhBlOZeDNPD+KbKSCb7Fad3r
 Kr3DlEXcnWo7t9/IzrA7Wi/ldPB4UwvaTPHEK8N3PfbVJMdIO7ZY5qRVB
 a6HEIE+9mEtHe7EkpvvH1VIRLWSkZ2R5IcJ+XSy5Nqsv2tUUUIxPrUrHQ g==;
X-CSE-ConnectionGUID: ng+Vc2kJS3uUVl9LvvoFOA==
X-CSE-MsgGUID: O/747ORPTJio5m2c0ufTpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="108592360"
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; d="scan'208";a="108592360"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jul 2026 22:48:26 -0700
X-CSE-ConnectionGUID: 1vSnUBapT9+qyLgRQmoG2Q==
X-CSE-MsgGUID: 6R/iuvB/R6uPsn1FSiVp7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; d="scan'208";a="256263140"
Received: from tejasupa-desk.iind.intel.com (HELO tejasupa-desk)
 ([10.190.239.37])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jul 2026 22:48:24 -0700
From: Tejas Upadhyay <tejas.upadhyay@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: matthew.auld@intel.com, arunpravin.paneerselvam@amd.com,
 Tejas Upadhyay <tejas.upadhyay@intel.com>
Subject: [PATCH 2/2] gpu/tests/gpu_buddy: Add KUnit test for
 gpu_buddy_allocated_addr_to_block
Date: Tue, 28 Jul 2026 11:18:11 +0530
Message-ID: <20260728054808.2664272-6-tejas.upadhyay@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260728054808.2664272-4-tejas.upadhyay@intel.com>
References: <20260728054808.2664272-4-tejas.upadhyay@intel.com>
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

Add a new KUnit test gpu_test_buddy_addr_to_block() that validates the
gpu_buddy_allocated_addr_to_block() helper which traces a physical
address back to its allocated buddy block.

The test covers:
- Exact address matching returns the correct allocated block
- Internal offset query within an allocated block
- Query of the free companion block returns NULL
- Out-of-bounds address returns ERR_PTR(-ENXIO)

Signed-off-by: Tejas Upadhyay <tejas.upadhyay@intel.com>
---
 drivers/gpu/tests/gpu_buddy_test.c | 98 ++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/drivers/gpu/tests/gpu_buddy_test.c b/drivers/gpu/tests/gpu_buddy_test.c
index 89698563c61b..1f4048d7c823 100644
--- a/drivers/gpu/tests/gpu_buddy_test.c
+++ b/drivers/gpu/tests/gpu_buddy_test.c
@@ -1422,6 +1422,103 @@ static void gpu_test_buddy_alloc_exceeds_max_order(struct kunit *test)
 	gpu_buddy_fini(&mm);
 }
 
+struct test_mgr {
+	struct gpu_buddy mm; /* Buddy memory manager */
+	struct mutex lock; /* Lock to protect vram access */
+	struct list_head allocated_list; /* Safe context tracking; lives as long as mgr */
+};
+
+/* Action 1: Safely destroys the tracking mutex structure */
+static void kunit_action_mutex_destroy(void *lock)
+{
+	mutex_destroy((struct mutex *)lock);
+}
+
+/* Action 2: Safely tears down the initialized buddy allocator instance */
+static void kunit_action_buddy_fini(void *mm)
+{
+	gpu_buddy_fini((struct gpu_buddy *)mm);
+}
+
+/* Action 3: Safely unlocks the tracking mutex if it is currently held */
+static void kunit_action_mutex_unlock(void *lock)
+{
+	struct mutex *m = lock;
+
+	mutex_unlock(m);
+}
+
+/* Action 4: Safely frees allocated blocks using the persistent mgr context frame */
+static void kunit_action_free_blocks(void *mgr_ctx)
+{
+	struct test_mgr *mgr = mgr_ctx;
+
+	if (!list_empty(&mgr->allocated_list))
+		gpu_buddy_free_list(&mgr->mm, &mgr->allocated_list, 0);
+}
+
+static void gpu_test_buddy_addr_to_block(struct kunit *test)
+{
+	struct test_mgr *mgr;
+	struct gpu_buddy_block *allocated_block, *found_block;
+	u64 test_size = SZ_4M;
+	u64 chunk_size = SZ_4K;
+	u64 alloc_size = SZ_2M;
+	u64 target_addr;
+
+	mgr = kunit_kzalloc(test, sizeof(*mgr), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, mgr);
+	INIT_LIST_HEAD(&mgr->allocated_list);
+
+	/* 1. Register Mutex Structure Destruction */
+	mutex_init(&mgr->lock);
+	KUNIT_ASSERT_EQ(test, kunit_add_action(test, kunit_action_mutex_destroy, &mgr->lock), 0);
+
+	/* 2. Register Buddy Manager Infrastructure Teardown */
+	KUNIT_ASSERT_EQ(test, gpu_buddy_init(&mgr->mm, test_size, chunk_size), 0);
+	KUNIT_ASSERT_EQ(test, kunit_add_action(test, kunit_action_buddy_fini, &mgr->mm), 0);
+
+	/* Set up driver lock tracking structure hooks */
+	gpu_buddy_driver_set_lock(&mgr->mm, &mgr->lock);
+
+	/*
+	 * Cleanup runs in LIFO order:
+	 *   4. free_blocks  (lock held)
+	 *   3. mutex_unlock
+	 *   2. buddy_fini
+	 *   1. mutex_destroy
+	 */
+	mutex_lock(&mgr->lock);
+	KUNIT_ASSERT_EQ(test, kunit_add_action(test, kunit_action_mutex_unlock, &mgr->lock), 0);
+
+	/* 3. Allocate blocks and register block cleanup action inside the lock context */
+	KUNIT_ASSERT_EQ(test, gpu_buddy_alloc_blocks(&mgr->mm, 0, test_size, alloc_size,
+						     chunk_size, &mgr->allocated_list, 0), 0);
+	KUNIT_ASSERT_EQ(test, kunit_add_action(test, kunit_action_free_blocks, mgr), 0);
+
+	allocated_block = list_first_entry(&mgr->allocated_list, struct gpu_buddy_block, link);
+	KUNIT_ASSERT_EQ(test, gpu_buddy_block_size(&mgr->mm, allocated_block), alloc_size);
+	target_addr = gpu_buddy_block_offset(allocated_block);
+
+	/* ---------------- RUN TRACKING VALIDATIONS ---------------- */
+
+	/* Test Case 1: Exact Address Matching */
+	found_block = gpu_buddy_allocated_addr_to_block(&mgr->mm, target_addr);
+	KUNIT_EXPECT_PTR_EQ(test, found_block, allocated_block);
+
+	/* Test Case 2: Internal Footprint Offset Queries */
+	found_block = gpu_buddy_allocated_addr_to_block(&mgr->mm, target_addr + SZ_1M);
+	KUNIT_EXPECT_PTR_EQ(test, found_block, allocated_block);
+
+	/* Test Case 3: Free Companion Memory Queries */
+	found_block = gpu_buddy_allocated_addr_to_block(&mgr->mm, target_addr ? 0 : alloc_size);
+	KUNIT_EXPECT_PTR_EQ(test, found_block, NULL);
+
+	/* Test Case 4: Out-of-Bounds Queries (Returns ERR_PTR(-ENXIO)) */
+	found_block = gpu_buddy_allocated_addr_to_block(&mgr->mm, test_size + SZ_1M);
+	KUNIT_EXPECT_PTR_EQ(test, found_block, ERR_PTR(-ENXIO));
+}
+
 static int gpu_buddy_suite_init(struct kunit_suite *suite)
 {
 	while (!random_seed)
@@ -1446,6 +1543,7 @@ static struct kunit_case gpu_buddy_tests[] = {
 	KUNIT_CASE(gpu_test_buddy_alloc_exceeds_max_order),
 	KUNIT_CASE(gpu_test_buddy_offset_aligned_allocation),
 	KUNIT_CASE(gpu_test_buddy_subtree_offset_alignment_stress),
+	KUNIT_CASE(gpu_test_buddy_addr_to_block),
 	{}
 };
 
-- 
2.52.0

