Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA857C53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 11:49:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4310310E8A2;
	Tue, 28 Jul 2026 11:49:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="MsmdDhi3";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D991710E8AB;
 Tue, 28 Jul 2026 11:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785239382; x=1816775382;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=77Svl/pjuWYE1WzB0fV7TT0yl6iiggVcot3oTc4Z9Ww=;
 b=MsmdDhi3yhYcICPJwASzeFFBItln6zq8BeD/aYAzkLjqNBfPbKOMJQbx
 15yPepqz5PFC2Dn1DkNlhGxq3bjs/UNM2weXxXIVg4+84H3tKv1PC3G6F
 O63AXkKP+immcWvXUICbeVMs0iPrpH9lYS4CpC87ImEKzW/fw80rd9cyA
 +ZaoOnoR9TQy+Fk7bARddv4oQVqxtPIExzefiNRFWX7+eDKlKdyqVwv38
 mT7TFHubMcdAvhJxbgFklpoj9VX/oEWubClDsBEV8tQy3SfpaO9tB5lRR
 HE4E12tKCllgU4k8li7M4H7oknGh7v48KbuYCwT6aJkkt0dYJeadWlCaX w==;
X-CSE-ConnectionGUID: wEiKTejKQcG92bnebFOOaw==
X-CSE-MsgGUID: CFbLBZlPQ/O1F5XWNcFjSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="84798313"
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; d="scan'208";a="84798313"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2026 04:49:41 -0700
X-CSE-ConnectionGUID: f2ph5I2yQ7uqWH0luoGQ/w==
X-CSE-MsgGUID: qMv8/us0TdKGojruL0XURQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; d="scan'208";a="257875885"
Received: from tejasupa-desk.iind.intel.com (HELO tejasupa-desk)
 ([10.190.239.37])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2026 04:49:40 -0700
From: Tejas Upadhyay <tejas.upadhyay@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: matthew.auld@intel.com, arunpravin.paneerselvam@amd.com,
 Tejas Upadhyay <tejas.upadhyay@intel.com>
Subject: [PATCH V2 2/2] gpu/tests/gpu_buddy: Add KUnit test for
 gpu_buddy_allocated_addr_to_block
Date: Tue, 28 Jul 2026 17:19:26 +0530
Message-ID: <20260728114923.2675866-6-tejas.upadhyay@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260728114923.2675866-4-tejas.upadhyay@intel.com>
References: <20260728114923.2675866-4-tejas.upadhyay@intel.com>
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

v2(Sashiko):
- Drop the mutex and lockdep annotation; standalone KUnit tests do
  not register a driver lock.

Signed-off-by: Tejas Upadhyay <tejas.upadhyay@intel.com>
---
 drivers/gpu/tests/gpu_buddy_test.c | 43 ++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/gpu/tests/gpu_buddy_test.c b/drivers/gpu/tests/gpu_buddy_test.c
index 89698563c61b..826a309697ed 100644
--- a/drivers/gpu/tests/gpu_buddy_test.c
+++ b/drivers/gpu/tests/gpu_buddy_test.c
@@ -1422,6 +1422,48 @@ static void gpu_test_buddy_alloc_exceeds_max_order(struct kunit *test)
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
+	u64 target_addr;
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
+	target_addr = gpu_buddy_block_offset(allocated_block);
+
+	found_block = gpu_buddy_allocated_addr_to_block(&mm, alloc_start);
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
@@ -1446,6 +1488,7 @@ static struct kunit_case gpu_buddy_tests[] = {
 	KUNIT_CASE(gpu_test_buddy_alloc_exceeds_max_order),
 	KUNIT_CASE(gpu_test_buddy_offset_aligned_allocation),
 	KUNIT_CASE(gpu_test_buddy_subtree_offset_alignment_stress),
+	KUNIT_CASE(gpu_test_buddy_addr_to_block),
 	{}
 };
 
-- 
2.52.0

