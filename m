Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD8BCC54F52
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 12:45:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45A9B10E8C7;
	Tue, 28 Jul 2026 12:45:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="YvmLjE8E";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB49210E8CB;
 Tue, 28 Jul 2026 12:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785242697; x=1816778697;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=oJEWluF3qV0Q4ZiRpqwYVGAcF3GxkC7JAotv3fSsfbI=;
 b=YvmLjE8EIt8oHrl4dQW2GP3bkvBn7BpFvMiINIcH9AqiPNhvP6ZmOzYB
 7MDX1PlEz90DHr2PZmRabXYHkbWMMY3glYR+qoSACo1OZT+JViXUZ9DDz
 BW2sdmh01pbiSPnA0ZKvTUdgPsyiYRSubYQf8iX69ysdIOaJuGKdgrXE5
 AoR4sKnrxCiUdcjnz5N01GqYS2eNZh1tpeQL3D2b0B+2BecJSwFeyiEkz
 JrU9E8DbeK3TxGTS9X8abBXv6d7PFNDE5hnl+wJQZYmgmxnWf58ZRWZb+
 mwItPunRX0/Z5taUg04KuB5XdVRQxeJOSZvY6TGzyDjdsZa0wsg1h1tgk A==;
X-CSE-ConnectionGUID: UJMMkqvZTByEPSUBrz4YIA==
X-CSE-MsgGUID: DJ8RkCSfRhuyppaOghZG0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="85838501"
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; d="scan'208";a="85838501"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2026 05:44:57 -0700
X-CSE-ConnectionGUID: 49lljwgvSnKAM6kF+whyGQ==
X-CSE-MsgGUID: qRN8/rx2QheL7T1WhlkY6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; d="scan'208";a="284234890"
Received: from tejasupa-desk.iind.intel.com (HELO tejasupa-desk)
 ([10.190.239.37])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2026 05:44:54 -0700
From: Tejas Upadhyay <tejas.upadhyay@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: matthew.auld@intel.com, arunpravin.paneerselvam@amd.com,
 Tejas Upadhyay <tejas.upadhyay@intel.com>
Subject: [PATCH V3 2/2] gpu/tests/gpu_buddy: Add KUnit test for
 gpu_buddy_allocated_addr_to_block
Date: Tue, 28 Jul 2026 18:14:41 +0530
Message-ID: <20260728124438.2679542-6-tejas.upadhyay@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260728124438.2679542-4-tejas.upadhyay@intel.com>
References: <20260728124438.2679542-4-tejas.upadhyay@intel.com>
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

v3(Sashiko):
- remove unused target_addr variable
v2(Sashiko):
- Drop the mutex and lockdep annotation; standalone KUnit tests do
  not register a driver lock.

Signed-off-by: Tejas Upadhyay <tejas.upadhyay@intel.com>
---
 drivers/gpu/tests/gpu_buddy_test.c | 41 ++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/gpu/tests/gpu_buddy_test.c b/drivers/gpu/tests/gpu_buddy_test.c
index 89698563c61b..21c90e96ac13 100644
--- a/drivers/gpu/tests/gpu_buddy_test.c
+++ b/drivers/gpu/tests/gpu_buddy_test.c
@@ -1422,6 +1422,46 @@ static void gpu_test_buddy_alloc_exceeds_max_order(struct kunit *test)
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
@@ -1446,6 +1486,7 @@ static struct kunit_case gpu_buddy_tests[] = {
 	KUNIT_CASE(gpu_test_buddy_alloc_exceeds_max_order),
 	KUNIT_CASE(gpu_test_buddy_offset_aligned_allocation),
 	KUNIT_CASE(gpu_test_buddy_subtree_offset_alignment_stress),
+	KUNIT_CASE(gpu_test_buddy_addr_to_block),
 	{}
 };
 
-- 
2.52.0

