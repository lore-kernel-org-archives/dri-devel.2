Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7429FCA5FED
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 11:07:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C090710E314;
	Tue,  6 Oct 2026 11:07:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="aoYAVIWy";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E372410E314;
 Tue,  6 Oct 2026 11:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791284873; x=1822820873;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=bXb1SeEeu3JPvryt9a24XFMIMldKqAekjGxkpo0iRL4=;
 b=aoYAVIWyLFW7331FPdPEFwGYVz8iJevRHHHuhX/bR75RKixNYDA9/wuM
 YZcEfT3EGa7dzNs0INZ6U8LXSszBIHAZSrWZIiemYmw5I5fBtCkKxYbhZ
 Mu2FJztddBOHOC0GZWpC2QDzQ+wyFU2EYEt4Vz7VtcfnmZnpx19Z2ZJpe
 QHxsGrMevq/7wMqjE3+iKao20ZwVg6r0swe8VMs8o7nBVSZaVfjCWIklR
 DBh77G9dvK27GoMlU9DeUeC20/IrJx/G0KJPk9dIS96IoLlG3I7I1HUJA
 JTPBM6m5PdvlbF4ff7Rme6FNl5GEcXl8eKDN06syDw9Lt1en6U4QKsupl A==;
X-CSE-ConnectionGUID: xC+SFZd9Td2zx4tNP5cwJg==
X-CSE-MsgGUID: KYKSakzoT1+FbwV0jVfgaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="120247"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="120247"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 04:07:53 -0700
X-CSE-ConnectionGUID: 8g0ERyDAS7OPYPeVVawlYg==
X-CSE-MsgGUID: LzBYpXU0RN+umuPiuWOTSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="275778612"
Received: from abityuts-desk1.ger.corp.intel.com (HELO mwauld-desk.intel.com)
 ([10.245.244.81])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 04:07:51 -0700
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, Shashiko <sashiko-bot@kernel.org>,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, stable@vger.kernel.org
Subject: [PATCH] gpu/buddy: do not pass caller list to
 __alloc_contig_try_harder()
Date: Tue,  6 Oct 2026 12:07:07 +0100
Message-ID: <20261006110706.1636971-2-matthew.auld@intel.com>
X-Mailer: git-send-email 2.55.0
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

If the caller passes a non-empty blocks list, __alloc_contig_try_harder()
unconditionally frees it on failure or during retry.

Pass the local allocated list instead and only splice it onto the caller's
list upon success.

Assisted-by: LLM
Reported-by: Shashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-fa721daf-7333-48b5-a26b-624c7f5791d7
Fixes: 0a1844bf0b53 ("drm/buddy: Improve contiguous memory allocation")
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>
Cc: <stable@vger.kernel.org>
---
 drivers/gpu/buddy.c                | 20 ++++++++++++++------
 drivers/gpu/tests/gpu_buddy_test.c |  9 +++++++++
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
index 2f2aaadafe35..a86f454fbb40 100644
--- a/drivers/gpu/buddy.c
+++ b/drivers/gpu/buddy.c
@@ -2022,10 +2022,16 @@ int gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
 
 	if (order > mm->max_order || size > mm->size) {
 		if ((flags & GPU_BUDDY_CONTIGUOUS_ALLOCATION) &&
-		    !(flags & GPU_BUDDY_RANGE_ALLOCATION))
-			return __alloc_contig_try_harder(mm, original_size,
-							 original_min_size,
-							 flags, blocks);
+		    !(flags & GPU_BUDDY_RANGE_ALLOCATION)) {
+			err = __alloc_contig_try_harder(mm, original_size,
+							original_min_size,
+							flags, &allocated);
+			if (err)
+				return err;
+
+			list_splice_tail(&allocated, blocks);
+			return 0;
+		}
 
 		return -EINVAL;
 	}
@@ -2064,9 +2070,11 @@ int gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
 								original_size,
 								original_min_size,
 								flags,
-								blocks);
-				if (!err)
+								&allocated);
+				if (!err) {
+					list_splice_tail(&allocated, blocks);
 					return 0;
+				}
 				if (err != -ENOSPC)
 					return err;
 				goto err_free;
diff --git a/drivers/gpu/tests/gpu_buddy_test.c b/drivers/gpu/tests/gpu_buddy_test.c
index b75d32ca6ca0..2c6f1da1a6d1 100644
--- a/drivers/gpu/tests/gpu_buddy_test.c
+++ b/drivers/gpu/tests/gpu_buddy_test.c
@@ -1235,6 +1235,15 @@ static void gpu_test_buddy_alloc_contiguous(struct kunit *test)
 							    GPU_BUDDY_CONTIGUOUS_ALLOCATION),
 			       "buddy_alloc hit an error size=%lu\n", 2 * ps);
 
+	/*
+	 * A failed contiguous allocation with a non-empty blocks list
+	 * must NOT corrupt or free pre-existing blocks.
+	 */
+	KUNIT_EXPECT_TRUE(test, gpu_buddy_alloc_blocks(&mm, 0, mm_size,
+						       3 * ps, ps, &allocated,
+						       GPU_BUDDY_CONTIGUOUS_ALLOCATION));
+	KUNIT_EXPECT_FALSE(test, list_empty(&allocated));
+
 	gpu_buddy_free_list(&mm, &left, 0);
 	KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_alloc_blocks(&mm, 0, mm_size,
 							    3 * ps, ps, &allocated,
-- 
2.55.0

