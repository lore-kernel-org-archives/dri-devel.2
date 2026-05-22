Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B572CD5BAC
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 09:26:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DEE710E23E;
	Fri, 22 May 2026 09:26:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="deYPP+2a";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0847710F51F;
 Fri, 22 May 2026 09:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779441992; x=1810977992;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rYypFbQVJvmHSlSU8CP5qkxQUVDCghsPe0zhk8ouh5s=;
 b=deYPP+2aDqZCY0Aj604ZGPgxlBm7BW4p6/KwgzXvix/lwzk/zi8g9e7Q
 Pp8LfTCLGGt7QUFLyxtfNhibibarBMMovu0cB/74Blu5aiHpQYnCXlMYb
 GdBu6TLxLG0ONicb6XIvUYDEyW9W0ayBNEPu03yOneTgkcGBTVptOwVn0
 Jg+YydxKfrbo+fZWYVPEZNd1XbtH+7rYZD69rUBDgNQ8gmrhH9bcSTTUW
 jA4LBa6/0gqz0QA1JPtHNtFEfe3uVXd4YuecAM2Ab0rYFARpF90hvBy8G
 8PKFfKnJKqg/G3/P6yswDA+DS2i+JJAefslqEMzQPRXcNOhImF2PZQjo7 A==;
X-CSE-ConnectionGUID: LKsV7lInTZCDCXR8ivx6bQ==
X-CSE-MsgGUID: tVEVgTsGQnKgbteDXy/Q/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="67895310"
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="67895310"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 02:26:32 -0700
X-CSE-ConnectionGUID: tRfFre1nTxa808VSaJMKnQ==
X-CSE-MsgGUID: 8uyGVexzRiGU/licayh7tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="237830327"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO fdugast-desk.home)
 ([10.245.244.230])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 02:26:30 -0700
From: Francois Dugast <francois.dugast@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, matthew.auld@intel.com,
 Arunpravin.PaneerSelvam@amd.com,
 Francois Dugast <francois.dugast@intel.com>
Subject: [PATCH v4 5/5] gpu/buddy: Track per-order used blocks with a
 scoreboard
Date: Fri, 22 May 2026 11:25:32 +0200
Message-ID: <20260522092600.32818-6-francois.dugast@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522092600.32818-1-francois.dugast@intel.com>
References: <20260522092600.32818-1-francois.dugast@intel.com>
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

v3:
- Assert scoreboard is empty at fini(), as sanity check (Matthew Auld)

v2:
- Update after fix for use-after-free in split_block() call sites
- Change goto label to out_free_used_scoreboard for clarity
- Make drm_buddy_print() and gpu_buddy_print() symmetric for used and
  free

Signed-off-by: Francois Dugast <francois.dugast@intel.com>
Assisted-by: GitHub Copilot:claude-sonnet-4.6
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
---
 drivers/gpu/buddy.c         | 42 ++++++++++++++++++++++++++++---------
 drivers/gpu/drm/drm_buddy.c | 18 ++++++++++------
 include/linux/gpu_buddy.h   |  8 +++++++
 3 files changed, 52 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
index de18b63fef0a..dc81fe0301ce 100644
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
 
@@ -398,11 +405,17 @@ int gpu_buddy_init(struct gpu_buddy *mm, u64 size, u64 chunk_size)
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
 	if (!mm->free_trees)
-		goto out_free_scoreboard;
+		goto out_free_used_scoreboard;
 
 	for_each_free_tree(i) {
 		mm->free_trees[i] = kmalloc_array(mm->max_order + 1,
@@ -464,7 +477,9 @@ int gpu_buddy_init(struct gpu_buddy *mm, u64 size, u64 chunk_size)
 	while (i--)
 		kfree(mm->free_trees[i]);
 	kfree(mm->free_trees);
-out_free_scoreboard:
+out_free_used_scoreboard:
+	kfree(mm->used_scoreboard);
+out_free_free_scoreboard:
 	kfree(mm->free_scoreboard);
 	return -ENOMEM;
 }
@@ -500,11 +515,15 @@ void gpu_buddy_fini(struct gpu_buddy *mm)
 
 	gpu_buddy_assert(mm->avail == mm->size);
 
+	for (i = 0; i <= mm->max_order; ++i)
+		gpu_buddy_assert(!mm->used_scoreboard[i]);
+
 	for_each_free_tree(i)
 		kfree(mm->free_trees[i]);
 	kfree(mm->free_trees);
 	kfree(mm->roots);
 	kfree(mm->free_scoreboard);
+	kfree(mm->used_scoreboard);
 }
 EXPORT_SYMBOL(gpu_buddy_fini);
 
@@ -1505,15 +1524,18 @@ void gpu_buddy_print(struct gpu_buddy *mm)
 		mm->chunk_size >> 10, mm->size >> 20, mm->avail >> 20, mm->clear_avail >> 20);
 
 	for (order = mm->max_order; order >= 0; order--) {
-		u64 count = mm->free_scoreboard[order];
-		u64 free = count * (mm->chunk_size << order);
-
-		if (free < SZ_1M)
-			pr_info("order-%2d free: %8llu KiB, blocks: %llu\n",
-				order, free >> 10, count);
+		u64 free_count = mm->free_scoreboard[order];
+		u64 used_count = mm->used_scoreboard[order];
+		u64 block_size = mm->chunk_size << order;
+		u64 free = free_count * block_size;
+		u64 used = used_count * block_size;
+
+		if (block_size < SZ_1M)
+			pr_info("order-%2d free: %8llu KiB, used: %8llu KiB, free_blocks: %llu, used_blocks: %llu\n",
+				order, free >> 10, used >> 10, free_count, used_count);
 		else
-			pr_info("order-%2d free: %8llu MiB, blocks: %llu\n",
-				order, free >> 20, count);
+			pr_info("order-%2d free: %8llu MiB, used: %8llu MiB, free_blocks: %llu, used_blocks: %llu\n",
+				order, free >> 20, used >> 20, free_count, used_count);
 	}
 }
 EXPORT_SYMBOL(gpu_buddy_print);
diff --git a/drivers/gpu/drm/drm_buddy.c b/drivers/gpu/drm/drm_buddy.c
index eef995e08a37..1536e59c6fe7 100644
--- a/drivers/gpu/drm/drm_buddy.c
+++ b/drivers/gpu/drm/drm_buddy.c
@@ -47,17 +47,23 @@ void drm_buddy_print(struct gpu_buddy *mm, struct drm_printer *p)
 		   mm->chunk_size >> 10, mm->size >> 20, mm->avail >> 20, mm->clear_avail >> 20);
 
 	for (order = mm->max_order; order >= 0; order--) {
-		u64 count = mm->free_scoreboard[order];
-		u64 free = count * (mm->chunk_size << order);
+		u64 free_count = mm->free_scoreboard[order];
+		u64 used_count = mm->used_scoreboard[order];
+		u64 block_size = mm->chunk_size << order;
+		u64 free = free_count * block_size;
+		u64 used = used_count * block_size;
 
 		drm_printf(p, "order-%2d ", order);
 
-		if (free < SZ_1M)
-			drm_printf(p, "free: %8llu KiB", free >> 10);
+		if (block_size < SZ_1M)
+			drm_printf(p, "free: %8llu KiB, used: %8llu KiB",
+				   free >> 10, used >> 10);
 		else
-			drm_printf(p, "free: %8llu MiB", free >> 20);
+			drm_printf(p, "free: %8llu MiB, used: %8llu MiB",
+				   free >> 20, used >> 20);
 
-		drm_printf(p, ", blocks: %llu\n", count);
+		drm_printf(p, ", free_blocks: %llu, used_blocks: %llu\n",
+			   free_count, used_count);
 	}
 }
 EXPORT_SYMBOL(drm_buddy_print);
diff --git a/include/linux/gpu_buddy.h b/include/linux/gpu_buddy.h
index a28f7d7637ca..e037714563d8 100644
--- a/include/linux/gpu_buddy.h
+++ b/include/linux/gpu_buddy.h
@@ -180,6 +180,14 @@ struct gpu_buddy {
 	 * called on a free block.
 	 */
 	u64 *free_scoreboard;
+	/*
+	 * Per-order used block scoreboard: used_scoreboard[order] holds the
+	 * number of blocks of that order currently in the allocated state.
+	 * Incremented in mark_allocated(), decremented in mark_free() (guarded
+	 * by gpu_buddy_block_is_allocated()) and in __gpu_buddy_free() when an
+	 * allocated block is consumed directly during buddy coalescing.
+	 */
+	u64 *used_scoreboard;
 /* public: */
 	unsigned int n_roots;
 	unsigned int max_order;
-- 
2.43.0

