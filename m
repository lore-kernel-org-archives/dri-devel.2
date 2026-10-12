Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B85DECA9EDE
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 11:16:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D7F310E556;
	Mon, 12 Oct 2026 11:16:46 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0FFF10E553;
 Mon, 12 Oct 2026 11:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791803798; x=1823339798;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wMiIsaSQ/4yfTIpx6trEhS3WdmlCi92z9TS9mMhwRI0=;
 b=EwHz2lY46fYGLtsCCBmr5KBa/IRn+pog2l1uIzmGGd7SQdmndY9HANL9
 BQ3Q0d3lojTiYBtfPNEQd7srC0+r3iwBozpXaQHB9UdLVZq6GkKlbiAHZ
 RqerkEoiuULQiQsjJCIMsKaBP5l2Sy7IqHrVMRjq+8hITIV0O8+m+9Oby
 /0aXL2afO01bUnZ7gKVr/y6toUBUDTv4RTn+bmBYoYR97NE/bsZjSWDWo
 nGn/LtP2AGNS8MX71liHco76epkr7JRXYLbMj4cq4vy2cg/Z/L0/sAlQA
 8RQiGUtowoO+c/xF2AWJziltz1RLem0B4MhxCmdbRo1wMlQ96wOvUjNPy A==;
X-CSE-ConnectionGUID: mtDcg0WoSPCXhITjDXd5lA==
X-CSE-MsgGUID: EuMC9pktQme/UhtSAi8eTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="408256"
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="408256"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 04:16:38 -0700
X-CSE-ConnectionGUID: bnW/0DuGRM6q2eqt4I0/MA==
X-CSE-MsgGUID: OlkMddQSRsuu+xpYfi54CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="975560"
Received: from yadavs-z690i-a-ultra-plus.iind.intel.com ([10.190.216.90])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 04:16:36 -0700
From: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org, Matthew Auld <matthew.auld@intel.com>,
 Arun Pravin <arunpravin.paneerselvam@amd.com>,
 Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH 1/2] gpu/buddy: Prune exhausted subtrees in range-biased
 allocation
Date: Mon, 12 Oct 2026 16:40:46 +0530
Message-ID: <ef9c4d0b6368b736ce639cfe6258f43b0ab6ca10.1791802549.git.sanjay.kumar.yadav@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1791802549.git.sanjay.kumar.yadav@intel.com>
References: <cover.1791802549.git.sanjay.kumar.yadav@intel.com>
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

__alloc_range_bias() walks the buddy tree depth-first, higher address
first, and descends every SPLIT block even when nothing below it is
free. Range allocations are placed top-down, so they pack below the
range end and each new one walks every block already allocated there:
O(N) per allocation and O(N^2) for N allocations, under the allocator
lock.

Track in each block the largest order of any FREE block in its subtree
(GPU_BUDDY_NO_FREE_ORDER if none), update it whenever a block changes
state, and skip subtrees that cannot satisfy the requested order.
gpu_buddy_block_trim() detaches the block while re-allocating inside
it, so recompute from the parent once it is reattached.

Skipped subtrees contain no FREE block of the requested order or
larger, so the old walk could neither split nor return anything there.
The remaining blocks are visited in the same order, so the selected
block and placement are unchanged.

Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Arun Pravin <arunpravin.paneerselvam@amd.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>
Assisted-by: LLM
Signed-off-by: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
---
 drivers/gpu/buddy.c       | 31 +++++++++++++++++++++++++++++++
 include/linux/gpu_buddy.h |  7 +++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
index 2f2aaadafe35..7a975873238f 100644
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
@@ -772,6 +796,7 @@ static void mark_split(struct gpu_buddy *mm,
 	mm->free_scoreboard[gpu_buddy_block_order(block)]--;
 
 	rbtree_remove(mm, block);
+	update_subtree_max_free_order(block);
 }
 
 static inline bool overlaps(u64 s1, u64 e1, u64 s2, u64 e2)
@@ -869,6 +894,8 @@ int gpu_buddy_init(struct gpu_buddy *mm, u64 size, u64 chunk_size)
 
 	size = round_down(size, chunk_size);
 
+	BUILD_BUG_ON(GPU_BUDDY_MAX_ORDER > S8_MAX);
+
 	mm->size = size;
 	mm->avail = size;
 	mm->chunk_size = chunk_size;
@@ -1280,6 +1307,9 @@ __alloc_range_bias(struct gpu_buddy *mm,
 		if (gpu_buddy_block_order(block) < order)
 			continue;
 
+		if (block->subtree_max_free_order < (int)order)
+			continue;
+
 		block_start = gpu_buddy_block_offset(block);
 		block_end = block_start + gpu_buddy_block_size(mm, block) - 1;
 
@@ -1881,6 +1911,7 @@ int gpu_buddy_block_trim(struct gpu_buddy *mm,
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

