Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B0F2CD3430
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 13:54:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEDED10E702;
	Mon,  4 May 2026 13:54:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="nrvZpu7b";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E892C10E704;
 Mon,  4 May 2026 13:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777902841; x=1809438841;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=l7+p05efzEj89fw653zOutfnz+ee8LTDeMIGjx70NKM=;
 b=nrvZpu7bg40tvVtGVzIdKEiTBcyPAB8ZnFHEnk44P+xwJhe54chkuDnS
 0cjg9fHhhwplCt7zIaOLDkflWQS5M7pbdg3QZXeNrYuype2q2uVReaLIx
 bFjtlm3EVoSnsaynpggxVA20Zkzwu0Zm+N30S0zlUM8it2sM866N+2v4P
 E5ftgg62fbV0D8Q6sbp5cRNYgDhcZNaQFlVdvFaon3Ha+CBACeFvga2cA
 sK0G89I0TVqKwbRWBrKkAFJwMcNp1BN99pdV3PCcQIVQSwUSUbkAamgda
 jcaPVz2EU3yuX5TrXlpcgGT6+yvnWDyMzjQCAQJLGvzYLTyxiJB8pVmEU A==;
X-CSE-ConnectionGUID: qBamf+jmR5Gki2efuSpkuA==
X-CSE-MsgGUID: rY9NynG5QYWyj3E4VCgagA==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="89065438"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; d="scan'208";a="89065438"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 May 2026 06:54:01 -0700
X-CSE-ConnectionGUID: e6yEvcWYQE6VJUd87vN+HA==
X-CSE-MsgGUID: C3NAtYXeQpOj0Z7l40O4MA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; d="scan'208";a="230930218"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO fdugast-desk.intel.com)
 ([10.245.245.110])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 May 2026 06:53:59 -0700
From: Francois Dugast <francois.dugast@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org, matthew.auld@intel.com,
 Francois Dugast <francois.dugast@intel.com>
Subject: [PATCH 1/2] gpu/buddy: Track per-order free blocks with a scoreboard
Date: Mon,  4 May 2026 15:52:41 +0200
Message-ID: <20260504135343.1797869-2-francois.dugast@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260504135343.1797869-1-francois.dugast@intel.com>
References: <20260504135343.1797869-1-francois.dugast@intel.com>
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

Reporting per-order free block counts in drm_buddy_print() currently
requires walking all rbtrees, which is O(n) over the total number of
free blocks and holds the allocator lock for the duration. This becomes
expensive on large VRAM heaps with many small free fragments.

Maintain a free_scoreboard[] array indexed by order instead, so that
the count for any order is always available in O(1). The scoreboard is
kept accurate by hooking into the four places where a block's free state
changes: mark_free(), mark_allocated(), mark_split(), and the two sites
in __gpu_buddy_free() and __force_merge() that call rbtree_remove()
directly on free blocks without going through mark_*().

The print functions are simplified as a result: the rbtree traversal
is replaced by a direct array lookup.

Signed-off-by: Francois Dugast <francois.dugast@intel.com>
Assisted-by: GitHub Copilot:claude-sonnet-4.6
---
 drivers/gpu/buddy.c         | 35 ++++++++++++++++++++---------------
 drivers/gpu/drm/drm_buddy.c | 16 ++--------------
 include/linux/gpu_buddy.h   |  7 +++++++
 3 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
index 52686672e99f..d831165e87ea 100644
--- a/drivers/gpu/buddy.c
+++ b/drivers/gpu/buddy.c
@@ -193,6 +193,8 @@ static void mark_allocated(struct gpu_buddy *mm,
 	block->header &= ~GPU_BUDDY_HEADER_STATE;
 	block->header |= GPU_BUDDY_ALLOCATED;
 
+	mm->free_scoreboard[gpu_buddy_block_order(block)]--;
+
 	rbtree_remove(mm, block);
 }
 
@@ -204,6 +206,8 @@ static void mark_free(struct gpu_buddy *mm,
 	block->header &= ~GPU_BUDDY_HEADER_STATE;
 	block->header |= GPU_BUDDY_FREE;
 
+	mm->free_scoreboard[gpu_buddy_block_order(block)]++;
+
 	tree = get_block_tree(block);
 	rbtree_insert(mm, block, tree);
 }
@@ -214,6 +218,8 @@ static void mark_split(struct gpu_buddy *mm,
 	block->header &= ~GPU_BUDDY_HEADER_STATE;
 	block->header |= GPU_BUDDY_SPLIT;
 
+	mm->free_scoreboard[gpu_buddy_block_order(block)]--;
+
 	rbtree_remove(mm, block);
 }
 
@@ -271,6 +277,7 @@ static unsigned int __gpu_buddy_free(struct gpu_buddy *mm,
 		}
 
 		rbtree_remove(mm, buddy);
+		mm->free_scoreboard[gpu_buddy_block_order(buddy)]--;
 		if (force_merge && gpu_buddy_block_is_clear(buddy))
 			mm->clear_avail -= gpu_buddy_block_size(mm, buddy);
 
@@ -335,6 +342,7 @@ static int __force_merge(struct gpu_buddy *mm,
 					iter = rb_prev(iter);
 
 				rbtree_remove(mm, block);
+				mm->free_scoreboard[gpu_buddy_block_order(block)]--;
 				if (gpu_buddy_block_is_clear(block))
 					mm->clear_avail -= gpu_buddy_block_size(mm, block);
 
@@ -384,11 +392,17 @@ int gpu_buddy_init(struct gpu_buddy *mm, u64 size, u64 chunk_size)
 
 	BUG_ON(mm->max_order > GPU_BUDDY_MAX_ORDER);
 
+	mm->free_scoreboard = kcalloc(mm->max_order + 1,
+				      sizeof(*mm->free_scoreboard),
+				      GFP_KERNEL);
+	if (!mm->free_scoreboard)
+		return -ENOMEM;
+
 	mm->free_trees = kmalloc_array(GPU_BUDDY_MAX_FREE_TREES,
 				       sizeof(*mm->free_trees),
 				       GFP_KERNEL);
 	if (!mm->free_trees)
-		return -ENOMEM;
+		goto out_free_scoreboard;
 
 	for_each_free_tree(i) {
 		mm->free_trees[i] = kmalloc_array(mm->max_order + 1,
@@ -447,6 +461,8 @@ int gpu_buddy_init(struct gpu_buddy *mm, u64 size, u64 chunk_size)
 	while (i--)
 		kfree(mm->free_trees[i]);
 	kfree(mm->free_trees);
+out_free_scoreboard:
+	kfree(mm->free_scoreboard);
 	return -ENOMEM;
 }
 EXPORT_SYMBOL(gpu_buddy_init);
@@ -485,6 +501,7 @@ void gpu_buddy_fini(struct gpu_buddy *mm)
 		kfree(mm->free_trees[i]);
 	kfree(mm->free_trees);
 	kfree(mm->roots);
+	kfree(mm->free_scoreboard);
 }
 EXPORT_SYMBOL(gpu_buddy_fini);
 
@@ -1479,21 +1496,9 @@ void gpu_buddy_print(struct gpu_buddy *mm)
 		mm->chunk_size >> 10, mm->size >> 20, mm->avail >> 20, mm->clear_avail >> 20);
 
 	for (order = mm->max_order; order >= 0; order--) {
-		struct gpu_buddy_block *block, *tmp;
-		struct rb_root *root;
-		u64 count = 0, free;
-		unsigned int tree;
-
-		for_each_free_tree(tree) {
-			root = &mm->free_trees[tree][order];
-
-			rbtree_postorder_for_each_entry_safe(block, tmp, root, rb) {
-				BUG_ON(!gpu_buddy_block_is_free(block));
-				count++;
-			}
-		}
+		u64 count = mm->free_scoreboard[order];
+		u64 free = count * (mm->chunk_size << order);
 
-		free = count * (mm->chunk_size << order);
 		if (free < SZ_1M)
 			pr_info("order-%2d free: %8llu KiB, blocks: %llu\n",
 				order, free >> 10, count);
diff --git a/drivers/gpu/drm/drm_buddy.c b/drivers/gpu/drm/drm_buddy.c
index 841f3de5f307..7839b54d3da7 100644
--- a/drivers/gpu/drm/drm_buddy.c
+++ b/drivers/gpu/drm/drm_buddy.c
@@ -46,23 +46,11 @@ void drm_buddy_print(struct gpu_buddy *mm, struct drm_printer *p)
 		   mm->chunk_size >> 10, mm->size >> 20, mm->avail >> 20, mm->clear_avail >> 20);
 
 	for (order = mm->max_order; order >= 0; order--) {
-		struct gpu_buddy_block *block, *tmp;
-		struct rb_root *root;
-		u64 count = 0, free;
-		unsigned int tree;
-
-		for_each_free_tree(tree) {
-			root = &mm->free_trees[tree][order];
-
-			rbtree_postorder_for_each_entry_safe(block, tmp, root, rb) {
-				BUG_ON(!gpu_buddy_block_is_free(block));
-				count++;
-			}
-		}
+		u64 count = mm->free_scoreboard[order];
+		u64 free = count * (mm->chunk_size << order);
 
 		drm_printf(p, "order-%2d ", order);
 
-		free = count * (mm->chunk_size << order);
 		if (free < SZ_1M)
 			drm_printf(p, "free: %8llu KiB", free >> 10);
 		else
diff --git a/include/linux/gpu_buddy.h b/include/linux/gpu_buddy.h
index 5fa917ba5450..250841ca4bcf 100644
--- a/include/linux/gpu_buddy.h
+++ b/include/linux/gpu_buddy.h
@@ -172,6 +172,13 @@ struct gpu_buddy {
 	 * that fits in the remaining space.
 	 */
 	struct gpu_buddy_block **roots;
+	/*
+	 * Per-order free block scoreboard: free_scoreboard[order] holds the
+	 * number of blocks of that order currently in the free state.
+	 * Incremented in mark_free(), decremented in mark_allocated() and
+	 * mark_split() when a block leaves the free state.
+	 */
+	u64 *free_scoreboard;
 /* public: */
 	unsigned int n_roots;
 	unsigned int max_order;
-- 
2.43.0

