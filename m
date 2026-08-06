Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11EE4C55838
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 05:36:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BAA110F0B7;
	Thu,  6 Aug 2026 05:36:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="UBH8ySc8";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B9CF10F0B3;
 Thu,  6 Aug 2026 05:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785994599; x=1817530599;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DebJIVFPQ++wQbikBq/LpySYMPuWtvVQSJnHrG+gfXY=;
 b=UBH8ySc8TbKBGeKcPNKArHg3WcRBNQEnN4KyjJuaBdfU6ic7YjEQZa6Y
 yOvm08crah5ZFkLedE9ylpjTVgFc30zRKZTIJ/vKX4DXX4sYcnGeyeF/H
 gA9SERgo7ISY1gyP+huPGkVJQD/w82t7VPhuRNF/1L+nqXVD5SPwKXQ2Z
 xAc6h616q2dCk6OC/Db5dQZyGiMl8cCDS5H039P7KmjlGs5fYHkW4WP90
 Bp9fWFFiu+3QXFJXoVNUd6jGkApr+QrFa2zo6MTGYDxQfAYsvuNis8MTI
 x+70XcxRush8EyCOP45PcIbgM0ZLdojGJWmLXxjhdD9qlDhz5jPI55Stq A==;
X-CSE-ConnectionGUID: I6/4ZBT4QmqbkvAzrgxFgg==
X-CSE-MsgGUID: jbrtnXMwRsmqiVGYPemnBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="96928703"
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; d="scan'208";a="96928703"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 22:36:39 -0700
X-CSE-ConnectionGUID: Nhy70gvbQZ6eTLzAeCsPcA==
X-CSE-MsgGUID: iookokBLRxeIDSMJcq7jcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; d="scan'208";a="265487074"
Received: from tejasupa-desk.iind.intel.com (HELO tejasupa-desk)
 ([10.190.239.37])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 22:36:38 -0700
From: Tejas Upadhyay <tejas.upadhyay@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: matthew.auld@intel.com, arunpravin.paneerselvam@amd.com,
 Tejas Upadhyay <tejas.upadhyay@intel.com>
Subject: [PATCH V4 2/2] gpu/tests/gpu_buddy: Add KUnit test for
 gpu_buddy_allocated_addr_to_block
Date: Thu,  6 Aug 2026 11:06:26 +0530
Message-ID: <20260806053624.3215216-6-tejas.upadhyay@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260806053624.3215216-4-tejas.upadhyay@intel.com>
References: <20260806053624.3215216-4-tejas.upadhyay@intel.com>
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
gpu_buddy_allocated_addr_to_block() helper which traces a address back
to its allocated buddy block.

The test covers:
- Exact address matching returns the correct allocated block
- An unallocated address inside the manager should return NULL
- An address outside the manager should return -ENXIO

v4(MattA):
- Add test for unaligned address
v3(Sashiko):
- remove unused target_addr variable
v2(Sashiko):
- Drop the mutex and lockdep annotation; standalone KUnit tests do
  not register a driver lock.

Signed-off-by: Tejas Upadhyay <tejas.upadhyay@intel.com>
---
 drivers/gpu/tests/gpu_buddy_test.c | 45 ++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/gpu/tests/gpu_buddy_test.c b/drivers/gpu/tests/gpu_buddy_test.c
index 7df5c2ae83bb..04e425eb8bdd 100644
--- a/drivers/gpu/tests/gpu_buddy_test.c
+++ b/drivers/gpu/tests/gpu_buddy_test.c
@@ -1381,6 +1381,50 @@ static void gpu_test_buddy_alloc_exceeds_max_order(struct kunit *test)
 	gpu_buddy_fini(&mm);
 }
 
+static void gpu_test_buddy_addr_to_block(struct kunit *test)
+{
+	struct gpu_buddy_block *allocated_block, *found_block;
+	LIST_HEAD(allocated_list);
+	const u64 test_size = SZ_4M + SZ_2M;
+	const u64 alloc_start = SZ_4M;
+	const u64 alloc_size = SZ_4K;
+	const u64 chunk_size = SZ_4K;
+	struct gpu_buddy mm;
+
+	KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_init(&mm, test_size, chunk_size),
+			       "buddy_init failed\n");
+
+	KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_alloc_blocks(&mm, alloc_start,
+							    alloc_start + alloc_size,
+							    alloc_size, chunk_size,
+							    &allocated_list, 0),
+			       "buddy_alloc failed\n");
+
+	allocated_block = list_first_entry(&allocated_list, struct gpu_buddy_block, link);
+	KUNIT_EXPECT_EQ(test, gpu_buddy_block_offset(allocated_block), alloc_start);
+	KUNIT_EXPECT_EQ(test, gpu_buddy_block_size(&mm, allocated_block), alloc_size);
+
+	found_block = gpu_buddy_allocated_addr_to_block(&mm, alloc_start);
+	KUNIT_EXPECT_PTR_EQ(test, found_block, allocated_block);
+
+	/* Unaligned address inside the allocated block (should resolve to the same block) */
+	found_block = gpu_buddy_allocated_addr_to_block(&mm, alloc_start + 16);
+	KUNIT_EXPECT_PTR_EQ(test, found_block, allocated_block);
+
+	/* An unallocated address inside the manager should return NULL. */
+	found_block = gpu_buddy_allocated_addr_to_block(&mm,
+							alloc_start - chunk_size);
+	KUNIT_EXPECT_NULL(test, found_block);
+
+	/* An address outside the manager should return -ENXIO. */
+	found_block = gpu_buddy_allocated_addr_to_block(&mm, test_size);
+	KUNIT_EXPECT_EQ(test, PTR_ERR(found_block), -ENXIO);
+
+	/* 3. Standard inline cleanup flow */
+	gpu_buddy_free_list(&mm, &allocated_list, 0);
+	gpu_buddy_fini(&mm);
+}
+
 static int gpu_buddy_suite_init(struct kunit_suite *suite)
 {
 	while (!random_seed)
@@ -1405,6 +1449,7 @@ static struct kunit_case gpu_buddy_tests[] = {
 	KUNIT_CASE(gpu_test_buddy_alloc_exceeds_max_order),
 	KUNIT_CASE(gpu_test_buddy_offset_aligned_allocation),
 	KUNIT_CASE(gpu_test_buddy_subtree_offset_alignment_stress),
+	KUNIT_CASE(gpu_test_buddy_addr_to_block),
 	{}
 };
 
-- 
2.52.0

