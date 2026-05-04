Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE04CD343A
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 13:54:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF25910E70A;
	Mon,  4 May 2026 13:54:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="IQClsuGe";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FDB210E702;
 Mon,  4 May 2026 13:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777902843; x=1809438843;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=y9BcqeJRlOrtT37Mi7W2c2HgjHxCAfV+XO0kW4PusnY=;
 b=IQClsuGeaxZYx6TtLCzQhXNW8MccRFh1jh4Hv33297+Wq9mjj0iBp0Nu
 V9LFZQ52YWZBw68AxdQM4urYys/hq6y3nYtdIp4P7WpFjdTJDGdw67e7/
 Qc08yUV2tIYyRa85IBIsDQokxJxDxuoVMeZB32YLy4ACQ5VzxbB6hzsdn
 IfT4JVcth9o/zP0iXsG9MyFiOqXFdQjmIsVuhe1P5XgKmZT3WN6Eu7Qy4
 6KG2h+40RrJNZ5NEzE96YjkrjSKNyo3Lzz1GTqVg5mpTRj91ggDxuTLWf
 K+4zN5J3QGz0sFWYDnkeq58Ltc9VEql9AkT4UhT/TEIfMBPNx0zsAG54T A==;
X-CSE-ConnectionGUID: yD/RcUuLQ3Cb0eCUoQcVPA==
X-CSE-MsgGUID: pa/b8DKmT2WJ4BYR3TrH9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="89065440"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; d="scan'208";a="89065440"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 May 2026 06:54:03 -0700
X-CSE-ConnectionGUID: tQ31e3QzRcq5GxuMkrL4tg==
X-CSE-MsgGUID: iCCz1WzXQDmEaSA03A2fCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; d="scan'208";a="230930222"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO fdugast-desk.intel.com)
 ([10.245.245.110])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 May 2026 06:54:01 -0700
From: Francois Dugast <francois.dugast@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org, matthew.auld@intel.com,
 Francois Dugast <francois.dugast@intel.com>
Subject: [PATCH 2/2] gpu/buddy: Track per-order used blocks with a scoreboard
Date: Mon,  4 May 2026 15:52:42 +0200
Message-ID: <20260504135343.1797869-3-francois.dugast@intel.com>
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

Extend the scoreboard approach from the previous commit to used blocks,
so drm_buddy_print() can report per-order allocation pressure in O(1).

Unlike free blocks, an allocated block can leave the allocated state
through mark_free() (normal free and gpu_buddy_block_trim()) or be
consumed directly by gpu_block_free() during coalescing. Both sites are
guarded by gpu_buddy_block_is_allocated() and paired with the increment
in mark_allocated().

Signed-off-by: Francois Dugast <francois.dugast@intel.com>
Assisted-by: GitHub Copilot:claude-sonnet-4.6
---
 drivers/gpu/buddy.c         | 29 +++++++++++++++++++++++------
 drivers/gpu/drm/drm_buddy.c |  8 +++++---
 include/linux/gpu_buddy.h   |  8 ++++++++
 3 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
index d831165e87ea..ebef03613b3f 100644
--- a/drivers/gpu/buddy.c
+++ b/drivers/gpu/buddy.c
@@ -194,6 +194,7 @@ static void mark_allocated(struct gpu_buddy *mm,
 	block->header |= GPU_BUDDY_ALLOCATED;
 
 	mm->free_scoreboard[gpu_buddy_block_order(block)]--;
+	mm->used_scoreboard[gpu_buddy_block_order(block)]++;
 
 	rbtree_remove(mm, block);
 }
@@ -203,6 +204,9 @@ static void mark_free(struct gpu_buddy *mm,
 {
 	enum gpu_buddy_free_tree tree;
 
+	if (gpu_buddy_block_is_allocated(block))
+		mm->used_scoreboard[gpu_buddy_block_order(block)]--;
+
 	block->header &= ~GPU_BUDDY_HEADER_STATE;
 	block->header |= GPU_BUDDY_FREE;
 
@@ -281,6 +285,9 @@ static unsigned int __gpu_buddy_free(struct gpu_buddy *mm,
 		if (force_merge && gpu_buddy_block_is_clear(buddy))
 			mm->clear_avail -= gpu_buddy_block_size(mm, buddy);
 
+		if (gpu_buddy_block_is_allocated(block))
+			mm->used_scoreboard[gpu_buddy_block_order(block)]--;
+
 		gpu_block_free(mm, block);
 		gpu_block_free(mm, buddy);
 
@@ -398,6 +405,12 @@ int gpu_buddy_init(struct gpu_buddy *mm, u64 size, u64 chunk_size)
 	if (!mm->free_scoreboard)
 		return -ENOMEM;
 
+	mm->used_scoreboard = kcalloc(mm->max_order + 1,
+				      sizeof(*mm->used_scoreboard),
+				      GFP_KERNEL);
+	if (!mm->used_scoreboard)
+		goto out_free_free_scoreboard;
+
 	mm->free_trees = kmalloc_array(GPU_BUDDY_MAX_FREE_TREES,
 				       sizeof(*mm->free_trees),
 				       GFP_KERNEL);
@@ -462,6 +475,8 @@ int gpu_buddy_init(struct gpu_buddy *mm, u64 size, u64 chunk_size)
 		kfree(mm->free_trees[i]);
 	kfree(mm->free_trees);
 out_free_scoreboard:
+	kfree(mm->used_scoreboard);
+out_free_free_scoreboard:
 	kfree(mm->free_scoreboard);
 	return -ENOMEM;
 }
@@ -502,6 +517,7 @@ void gpu_buddy_fini(struct gpu_buddy *mm)
 	kfree(mm->free_trees);
 	kfree(mm->roots);
 	kfree(mm->free_scoreboard);
+	kfree(mm->used_scoreboard);
 }
 EXPORT_SYMBOL(gpu_buddy_fini);
 
@@ -1496,15 +1512,16 @@ void gpu_buddy_print(struct gpu_buddy *mm)
 		mm->chunk_size >> 10, mm->size >> 20, mm->avail >> 20, mm->clear_avail >> 20);
 
 	for (order = mm->max_order; order >= 0; order--) {
-		u64 count = mm->free_scoreboard[order];
-		u64 free = count * (mm->chunk_size << order);
+		u64 free_count = mm->free_scoreboard[order];
+		u64 used_count = mm->used_scoreboard[order];
+		u64 free = free_count * (mm->chunk_size << order);
 
 		if (free < SZ_1M)
-			pr_info("order-%2d free: %8llu KiB, blocks: %llu\n",
-				order, free >> 10, count);
+			pr_info("order-%2d free: %8llu KiB, free_blocks: %llu, used_blocks: %llu\n",
+				order, free >> 10, free_count, used_count);
 		else
-			pr_info("order-%2d free: %8llu MiB, blocks: %llu\n",
-				order, free >> 20, count);
+			pr_info("order-%2d free: %8llu MiB, free_blocks: %llu, used_blocks: %llu\n",
+				order, free >> 20, free_count, used_count);
 	}
 }
 EXPORT_SYMBOL(gpu_buddy_print);
diff --git a/drivers/gpu/drm/drm_buddy.c b/drivers/gpu/drm/drm_buddy.c
index 7839b54d3da7..3a1cb06923c6 100644
--- a/drivers/gpu/drm/drm_buddy.c
+++ b/drivers/gpu/drm/drm_buddy.c
@@ -46,8 +46,9 @@ void drm_buddy_print(struct gpu_buddy *mm, struct drm_printer *p)
 		   mm->chunk_size >> 10, mm->size >> 20, mm->avail >> 20, mm->clear_avail >> 20);
 
 	for (order = mm->max_order; order >= 0; order--) {
-		u64 count = mm->free_scoreboard[order];
-		u64 free = count * (mm->chunk_size << order);
+		u64 free_count = mm->free_scoreboard[order];
+		u64 used_count = mm->used_scoreboard[order];
+		u64 free = free_count * (mm->chunk_size << order);
 
 		drm_printf(p, "order-%2d ", order);
 
@@ -56,7 +57,8 @@ void drm_buddy_print(struct gpu_buddy *mm, struct drm_printer *p)
 		else
 			drm_printf(p, "free: %8llu MiB", free >> 20);
 
-		drm_printf(p, ", blocks: %llu\n", count);
+		drm_printf(p, ", free_blocks: %llu, used_blocks: %llu\n",
+			   free_count, used_count);
 	}
 }
 EXPORT_SYMBOL(drm_buddy_print);
diff --git a/include/linux/gpu_buddy.h b/include/linux/gpu_buddy.h
index 250841ca4bcf..b1cad7833dc1 100644
--- a/include/linux/gpu_buddy.h
+++ b/include/linux/gpu_buddy.h
@@ -179,6 +179,14 @@ struct gpu_buddy {
 	 * mark_split() when a block leaves the free state.
 	 */
 	u64 *free_scoreboard;
+	/*
+	 * Per-order used block scoreboard: used_scoreboard[order] holds the
+	 * number of blocks of that order currently in the allocated state.
+	 * Incremented in mark_allocated(), decremented in
+	 * gpu_buddy_free_block() which is the sole entry point for freeing
+	 * allocated blocks.
+	 */
+	u64 *used_scoreboard;
 /* public: */
 	unsigned int n_roots;
 	unsigned int max_order;
-- 
2.43.0

