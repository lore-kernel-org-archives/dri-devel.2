Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F4C606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 05:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZcVAg2u4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5376110E583;
	Mon,  2 Nov 2026 05:23:55 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8B2010E52E;
 Mon,  2 Nov 2026 05:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793597029; x=1825133029;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tQ1227hCoEVGRsZeiX44ugcLnTCnPO15T3fO5/L7fUs=;
 b=ZcVAg2u4k2DCS6xYQoS34CPH+a/sqb3EpkRNM2MquN6kw41SOdK/m3LG
 d5uHEjZH54nNWgEPDZKEA9Bn8C1lfeEO9WRd4uCYcOgr1ULbSOOS+8k0K
 JlDDqk4jX4FT90PK3Os4cB14sIE+k0wWu6M+eQlIoq/rK5z9L0MnvxMVt
 hOPHW3o5neECwIeOK8ZvSdpKaOahNrrLdonx8JYxAeEtkCRJTXnPwPtxb
 Miq4Yt8OAZgU2Asozw61q/xpHxM6rZMgJfh/LnhOr5+fAWk0gw1PSgHw/
 7PFUgXBuygn8QXubY5+bdGunT5XJmlS6NHppPAvCjX7uWS2Rhwww+rKPE A==;
X-CSE-ConnectionGUID: JEpG+mnnRm2ysEkqisJnsw==
X-CSE-MsgGUID: 89n/zh4FSdG/55MEZEhpjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2289082"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2289082"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Nov 2026 21:23:49 -0800
X-CSE-ConnectionGUID: 51c+QrM+RAOwx+tPfvGJkA==
X-CSE-MsgGUID: S1LhRnOuTjWOkHdmmTC5Ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6068014"
Received: from yadavs-z690i-a-ultra-plus.iind.intel.com ([10.190.216.90])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Nov 2026 21:23:47 -0800
From: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org, Matthew Auld <matthew.auld@intel.com>,
 Arun Pravin <arunpravin.paneerselvam@amd.com>,
 Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH v4 1/1] gpu/buddy: Prune exhausted subtrees in range-biased
 allocation
Date: Mon,  2 Nov 2026 10:46:35 +0530
Message-ID: <20261102051633.2035348-4-sanjay.kumar.yadav@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261102051633.2035348-3-sanjay.kumar.yadav@intel.com>
References: <20261102051633.2035348-3-sanjay.kumar.yadav@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

__alloc_range_bias() walks the buddy tree depth-first, higher address
first, and descends every SPLIT block even when nothing below it is
free. Range allocations are placed top-down, so they pack below the
range end and each new one walks every block already allocated there:
O(N) per allocation and O(N^2) for N allocations, under the allocator
lock.

Track in each block the largest order of any FREE block in its subtree
(GPU_BUDDY_NO_FREE_ORDER if none), update it when a block is allocated
or freed, and skip subtrees that cannot satisfy the requested order.
Splitting needs no update of its own, as both children are marked free
right after and that propagates the new value up.
gpu_buddy_block_trim() detaches the block before freeing it, so updates
stop there while re-allocating inside it; recompute from the parent
once it is reattached.

Skipped subtrees contain no FREE block of the requested order or
larger, so the old walk could neither split nor return anything there.
The remaining blocks are visited in the same order, so the selected
block and placement are unchanged.

v4: (Matt A)
- Drop the update in mark_split(), the children being marked free
  updates the parent
- Detach the block before __mark_free() in gpu_buddy_block_trim(), so
  only the final update from the parent propagates up
- Drop the order, is_allocated() and is_free() checks in
  __alloc_range_bias() that the pruning check now covers

Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Arun Pravin <arunpravin.paneerselvam@amd.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>
Assisted-by: LLM
Signed-off-by: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
---
 drivers/gpu/buddy.c       | 56 +++++++++++++++++++++++++++------------
 include/linux/gpu_buddy.h |  7 +++++
 2 files changed, 46 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
index 28cff97d57dc..93f70c98b235 100644
--- a/drivers/gpu/buddy.c
+++ b/drivers/gpu/buddy.c
@@ -602,6 +602,7 @@ static struct gpu_buddy_block *gpu_block_alloc(struct gpu_buddy *mm,
 	block->header = offset;
 	block->header |= order;
 	block->parent = parent;
+	block->subtree_max_free_order = GPU_BUDDY_NO_FREE_ORDER;
 
 	RB_CLEAR_NODE(&block->rb);
 
@@ -717,6 +718,27 @@ static void rbtree_remove(struct gpu_buddy *mm,
 	RB_CLEAR_NODE(&block->rb);
 }
 
+static void update_subtree_max_free_order(struct gpu_buddy_block *block)
+{
+	while (block) {
+		s8 max_free;
+
+		if (gpu_buddy_block_is_free(block))
+			max_free = gpu_buddy_block_order(block);
+		else if (gpu_buddy_block_is_split(block))
+			max_free = max(block->left->subtree_max_free_order,
+				       block->right->subtree_max_free_order);
+		else
+			max_free = GPU_BUDDY_NO_FREE_ORDER;
+
+		if (block->subtree_max_free_order == max_free)
+			break;
+
+		block->subtree_max_free_order = max_free;
+		block = block->parent;
+	}
+}
+
 static void mark_allocated(struct gpu_buddy *mm,
 			   struct gpu_buddy_block *block)
 {
@@ -729,6 +751,7 @@ static void mark_allocated(struct gpu_buddy *mm,
 	mm->used_scoreboard[gpu_buddy_block_order(block)]++;
 
 	rbtree_remove(mm, block);
+	update_subtree_max_free_order(block);
 }
 
 static void __mark_free(struct gpu_buddy *mm,
@@ -750,6 +773,7 @@ static void __mark_free(struct gpu_buddy *mm,
 	mm->free_scoreboard[gpu_buddy_block_order(block)]++;
 
 	rbtree_insert(mm, block);
+	update_subtree_max_free_order(block);
 }
 
 static void mark_free(struct gpu_buddy *mm,
@@ -869,6 +893,8 @@ int gpu_buddy_init(struct gpu_buddy *mm, u64 size, u64 chunk_size)
 
 	size = round_down(size, chunk_size);
 
+	BUILD_BUG_ON(GPU_BUDDY_MAX_ORDER > S8_MAX);
+
 	mm->size = size;
 	mm->avail = size;
 	mm->chunk_size = chunk_size;
@@ -1277,7 +1303,7 @@ __alloc_range_bias(struct gpu_buddy *mm,
 
 		list_del(&block->tmp_link);
 
-		if (gpu_buddy_block_order(block) < order)
+		if (block->subtree_max_free_order < (int)order)
 			continue;
 
 		block_start = gpu_buddy_block_offset(block);
@@ -1286,9 +1312,6 @@ __alloc_range_bias(struct gpu_buddy *mm,
 		if (!overlaps(start, end, block_start, block_end))
 			continue;
 
-		if (gpu_buddy_block_is_allocated(block))
-			continue;
-
 		if (block_start < start || block_end > end) {
 			u64 adjusted_start = max(block_start, start);
 			u64 adjusted_end = min(block_end, end);
@@ -1298,16 +1321,10 @@ __alloc_range_bias(struct gpu_buddy *mm,
 				continue;
 		}
 
+		/* Not pruned at @order, so this block itself is FREE */
 		if (contains(start, end, block_start, block_end) &&
-		    order == gpu_buddy_block_order(block)) {
-			/*
-			 * Find the free block within the range.
-			 */
-			if (gpu_buddy_block_is_free(block))
-				return block;
-
-			continue;
-		}
+		    order == gpu_buddy_block_order(block))
+			return block;
 
 		if (!gpu_buddy_block_is_split(block)) {
 			err = split_block(mm, block);
@@ -1856,13 +1873,17 @@ int gpu_buddy_block_trim(struct gpu_buddy *mm,
 					     gpu_buddy_block_offset(block),
 					     gpu_buddy_block_size(mm, block));
 
-	__mark_free(mm, block, was_clear ? GPU_BLOCK_CLEAR : GPU_BLOCK_DIRTY);
-	mm->avail += gpu_buddy_block_size(mm, block);
-
-	/* Prevent recursively freeing this node */
+	/*
+	 * Detach the block to prevent recursively freeing this node, and to
+	 * keep free-order updates from propagating above it until the trim
+	 * is done.
+	 */
 	parent = block->parent;
 	block->parent = NULL;
 
+	__mark_free(mm, block, was_clear ? GPU_BLOCK_CLEAR : GPU_BLOCK_DIRTY);
+	mm->avail += gpu_buddy_block_size(mm, block);
+
 	list_add(&block->tmp_link, &dfs);
 	err =  __alloc_range(mm, &dfs, new_start, new_size,
 			     was_clear ? GPU_BUDDY_CLEAR_ALLOCATION : 0,
@@ -1881,6 +1902,7 @@ int gpu_buddy_block_trim(struct gpu_buddy *mm,
 	}
 
 	block->parent = parent;
+	update_subtree_max_free_order(parent);
 	return err;
 }
 EXPORT_SYMBOL(gpu_buddy_block_trim);
diff --git a/include/linux/gpu_buddy.h b/include/linux/gpu_buddy.h
index ddc4eca84175..8037f5a0feb1 100644
--- a/include/linux/gpu_buddy.h
+++ b/include/linux/gpu_buddy.h
@@ -141,8 +141,15 @@ struct gpu_buddy_block {
 	unsigned int subtree_max_alignment;
 	struct list_head tmp_link;
 	bool has_clear;
+	/*
+	 * Largest order of any FREE block in this block's buddy subtree, or
+	 * GPU_BUDDY_NO_FREE_ORDER if none. Protected by the driver lock.
+	 */
+	s8 subtree_max_free_order;
 };
 
+#define GPU_BUDDY_NO_FREE_ORDER (-1)
+
 /* Order-zero must be at least SZ_4K */
 #define GPU_BUDDY_MAX_ORDER (63 - 12)
 
-- 
2.52.0

