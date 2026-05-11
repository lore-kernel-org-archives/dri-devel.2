Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF27CD484C
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 16:42:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AF7A10E556;
	Mon, 11 May 2026 16:42:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ihe4ArhB";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1F4D10E556;
 Mon, 11 May 2026 16:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778517752; x=1810053752;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4EvNw1wDXPsNky1eHTbr2/ETInl09PNUQKfyZJqxj1w=;
 b=ihe4ArhBCD6XGFTFifFyJtx7J/PprmFHa3eUAjyP6moz0XVMpFg6dNXC
 2HqXpVf2B8R8zsqtp3DhSxqsy70oWS+doykez2MSc+dSIHBUQFIHy9fzB
 bG18Azr6FbZQiw+o7AyWxh8uWxuttxpracFLW0qC64IpCa99LM+HRfjmb
 ejeV0kpoetA7YkBhBvveBbl7GwK34KQ1rTSmL1dlDVBeVyFUj2Qs5ooE5
 6/Sw+WhN7Sctz3qRdeyjwEtSriBINmuCJHjfuSdGwBUzUDNC4B1z2heNt
 Vw9fPBTrhTUlU7WnAsCKi4IHULp++6RsThPGc6qvy9Ik61RDzOxnNRZKE Q==;
X-CSE-ConnectionGUID: 0K+d+5ULS3q/enNfXm5PzQ==
X-CSE-MsgGUID: XNz/8yd+TJqgapbWE5d/iA==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79593717"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; d="scan'208";a="79593717"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2026 09:42:32 -0700
X-CSE-ConnectionGUID: 5ofOSJ5+Tiys09gST459LQ==
X-CSE-MsgGUID: 8zxdL8pdQHmY75VfVbRBaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; d="scan'208";a="231111060"
Received: from slindbla-desk.ger.corp.intel.com (HELO fdugast-desk.home)
 ([10.245.245.34])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2026 09:42:30 -0700
From: Francois Dugast <francois.dugast@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, matthew.auld@intel.com,
 Francois Dugast <francois.dugast@intel.com>,
 Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v2 1/3] gpu/buddy: Fix use-after-free in split_block() call
 sites
Date: Mon, 11 May 2026 18:41:04 +0200
Message-ID: <20260511164217.150237-2-francois.dugast@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260511164217.150237-1-francois.dugast@intel.com>
References: <20260511164217.150237-1-francois.dugast@intel.com>
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

When split_block() fails it returns before calling mark_split(), leaving
the block in the FREE state and still linked in the rbtree.  The four
err_undo paths then call __gpu_buddy_free() without first removing the
block from the tree, which leads to two distinct bugs:

 - If the buddy is also free, __gpu_buddy_free() merges the two siblings
   by calling gpu_block_free(mm, block) while block->rb is still linked
   in the tree.  Any subsequent rbtree traversal will follow the now-
   dangling pointer, causing a use-after-free.

 - In alloc_from_freetree(), where there is no buddy guard,
   __gpu_buddy_free() always reaches mark_free() -> rbtree_insert() with
   block still in the tree, corrupting the rbtree.

The same pattern is already used correctly in __force_merge(): call
rbtree_remove() to unlink the block before handing it to
__gpu_buddy_free().  Apply the same fix to all four err_undo sites.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Francois Dugast <francois.dugast@intel.com>
Assisted-by: GitHub Copilot:claude-sonnet-4.6
---
 drivers/gpu/buddy.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
index eb1457376307..dac2027bb64a 100644
--- a/drivers/gpu/buddy.c
+++ b/drivers/gpu/buddy.c
@@ -737,8 +737,10 @@ __alloc_range_bias(struct gpu_buddy *mm,
 	buddy = __get_buddy(block);
 	if (buddy &&
 	    (gpu_buddy_block_is_free(block) &&
-	     gpu_buddy_block_is_free(buddy)))
+	     gpu_buddy_block_is_free(buddy))) {
+		rbtree_remove(mm, block);
 		__gpu_buddy_free(mm, block, false);
+	}
 	return ERR_PTR(err);
 }
 
@@ -847,8 +849,10 @@ alloc_from_freetree(struct gpu_buddy *mm,
 	return block;
 
 err_undo:
-	if (tmp != order)
+	if (tmp != order) {
+		rbtree_remove(mm, block);
 		__gpu_buddy_free(mm, block, false);
+	}
 	return ERR_PTR(err);
 }
 
@@ -968,8 +972,10 @@ gpu_buddy_offset_aligned_allocation(struct gpu_buddy *mm,
 	buddy = __get_buddy(block);
 	if (buddy &&
 	    (gpu_buddy_block_is_free(block) &&
-	     gpu_buddy_block_is_free(buddy)))
+	     gpu_buddy_block_is_free(buddy))) {
+		rbtree_remove(mm, block);
 		__gpu_buddy_free(mm, block, false);
+	}
 	return ERR_PTR(err);
 }
 
@@ -1054,8 +1060,10 @@ static int __alloc_range(struct gpu_buddy *mm,
 	buddy = __get_buddy(block);
 	if (buddy &&
 	    (gpu_buddy_block_is_free(block) &&
-	     gpu_buddy_block_is_free(buddy)))
+	     gpu_buddy_block_is_free(buddy))) {
+		rbtree_remove(mm, block);
 		__gpu_buddy_free(mm, block, false);
+	}
 
 err_free:
 	if (err == -ENOSPC && total_allocated_on_err) {
-- 
2.43.0

