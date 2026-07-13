Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B23C44508
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 22:36:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DF8510EB52;
	Mon, 13 Jul 2026 22:36:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=picoheart.com header.i=@picoheart.com header.b="IVDIch5s";
	dkim-atps=neutral
Received: from va-2-52.ptr.blmpb.com (va-2-52.ptr.blmpb.com [209.127.231.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2566F10E9AF
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 13:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604151535; d=picoheart.com; t=1783948639; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=HQryPrQFSPbWa2anbiX1aauRwBJAIVsu6Hx1hZ3u8hA=;
 b=IVDIch5sqQBnkCivGu4rn3gRCg8Y/+45QTggMK5xKt0e1yb/rSuDNS+6ed4+d2Lfhekl98
 2LGxbaae+EDrv/Uir0+PrXPFsY+pcBfpoKzEdwGiHBJCWhpltGeCnn0qP92JMKXOiHLcGy
 K6MnQfn7AtZP3c8JSeBXQPZ1c8Q/aEsp+BWAuVHdbDm5owGuGKDhpGOY19XrYVE3KjL6ty
 g4ubf7Br9IhvOcDznPjJttP90hVTVbFTCqKzfpBALL87ix+HTQJykmioUXmITCvIhoQOIq
 HLWGrhbjSkefHWJlAdPjbRMEtnz1AG0M9dJMLZcKP/1iRk2YE/LiEwBORZ3WYQ==
Cc: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26a54e55e+523be2+lists.freedesktop.org+liuzhaoyu.zackary@picoheart.com>
To: <matthew.auld@intel.com>, <arunpravin.paneerselvam@amd.com>, 
 <joelagnelf@nvidia.com>, <airlied@gmail.com>, <simona@ffwll.ch>, 
 <francois.dugast@intel.com>
Message-Id: <alTlW8TmTXLocWKP@hostpc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [PATCH v2] gpu: buddy: avoid repeated builds of root dfs when alloc
 range
Content-Disposition: inline
X-Original-From: Zhaoyu Liu <liuzhaoyu.zackary@picoheart.com>
From: "Zhaoyu Liu" <liuzhaoyu.zackary@picoheart.com>
Date: Mon, 13 Jul 2026 21:17:15 +0800
Received: from hostpc ([183.129.139.234]) by smtp.feishu.cn with ESMTPS;
 Mon, 13 Jul 2026 21:17:17 +0800
X-Mailman-Approved-At: Mon, 13 Jul 2026 22:35:59 +0000
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

The buddy allocator previously pre-built a DFS list by inserting all
root blocks via list_add_tail() before every allocation call in
__alloc_range_bias() and __gpu_buddy_alloc_range(). This is wasteful
when the allocation can be satisfied by the first root or by sub-blocks
produced from splits, as the remaining roots are never consumed.

Introduce __get_candidate_block() which unifies the block acquisition
logic for both __alloc_range_bias() and __alloc_range(): it first
checks the DFS list (populated by splits during allocation or
pre-filled by the caller for trim), and only when the list is exhausted
does it lazily fetch the next root block through a cursor.

When the caller pre-fills the DFS list (trim scenario), the cursor is
initialized to mm->n_roots to disable root iteration entirely,
preserving the original behavior.

Signed-off-by: Zhaoyu Liu <liuzhaoyu.zackary@picoheart.com>
Suggested-by: Arun Pravin <arunpravin.paneerselvam@amd.com>
---

v2:
- Change __get_candidate_block to inline
- Link to v1: https://lore.kernel.org/all/ak+ECwsuSljmvyKd@hostpc/

---
 drivers/gpu/buddy.c | 61 ++++++++++++++++++++++++++++++---------------
 1 file changed, 41 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
index dc81fe0301ce..63b3959973fa 100644
--- a/drivers/gpu/buddy.c
+++ b/drivers/gpu/buddy.c
@@ -700,6 +700,41 @@ static void __gpu_buddy_undo_splits(struct gpu_buddy *mm,
 	}
 }
 
+/**
+ * __get_candidate_block - Get a candidate block for allocation.
+ * @mm: GPU buddy manager
+ * @dfs: List of candidate blocks. Populated in two ways: (1) pre-filled by
+ *       the caller before allocation with blocks available for allocation,
+ *       and (2) extended during allocation by block splits, which add the
+ *       resulting sub-blocks for subsequent finer-grained allocation.
+ * @cursor: Pointer to current root index, advanced when iterating roots.
+ *          Pass in a value >= mm->n_roots to disable root iteration entirely,
+ *          restricting block acquisition to @dfs only; this is used in the
+ *          trim scenario where only pre-split sub-blocks should be considered.
+ *
+ * Return: Pointer to the acquired block on success, ERR_PTR(-ENOSPC) when no
+ * more blocks are available.
+ */
+static inline struct gpu_buddy_block*
+__get_candidate_block(struct gpu_buddy *mm, struct list_head *dfs,
+		uint32_t *cursor)
+{
+	struct gpu_buddy_block *block;
+
+	block = list_first_entry_or_null(dfs,
+					struct gpu_buddy_block,
+					tmp_link);
+	if (block) {
+		list_del(&block->tmp_link);
+		return block;
+	}
+
+	if (*cursor >= mm->n_roots)
+		return ERR_PTR(-ENOSPC);
+
+	return mm->roots[(*cursor)++];
+}
+
 static struct gpu_buddy_block *
 __alloc_range_bias(struct gpu_buddy *mm,
 		   u64 start, u64 end,
@@ -711,25 +746,18 @@ __alloc_range_bias(struct gpu_buddy *mm,
 	struct gpu_buddy_block *block;
 	LIST_HEAD(dfs);
 	int err;
-	int i;
+	uint32_t cursor = 0;
 
 	end = end - 1;
 
-	for (i = 0; i < mm->n_roots; ++i)
-		list_add_tail(&mm->roots[i]->tmp_link, &dfs);
-
 	do {
 		u64 block_start;
 		u64 block_end;
 
-		block = list_first_entry_or_null(&dfs,
-						 struct gpu_buddy_block,
-						 tmp_link);
-		if (!block)
+		block = __get_candidate_block(mm, &dfs, &cursor);
+		if (IS_ERR(block))
 			break;
 
-		list_del(&block->tmp_link);
-
 		if (gpu_buddy_block_order(block) < order)
 			continue;
 
@@ -1023,6 +1051,7 @@ static int __alloc_range(struct gpu_buddy *mm,
 	LIST_HEAD(allocated);
 	u64 end;
 	int err;
+	uint32_t cursor = list_empty(dfs) ? 0 : mm->n_roots;
 
 	end = start + size - 1;
 
@@ -1030,14 +1059,10 @@ static int __alloc_range(struct gpu_buddy *mm,
 		u64 block_start;
 		u64 block_end;
 
-		block = list_first_entry_or_null(dfs,
-						 struct gpu_buddy_block,
-						 tmp_link);
-		if (!block)
+		block = __get_candidate_block(mm, dfs, &cursor);
+		if (IS_ERR(block))
 			break;
 
-		list_del(&block->tmp_link);
-
 		block_start = gpu_buddy_block_offset(block);
 		block_end = block_start + gpu_buddy_block_size(mm, block) - 1;
 
@@ -1109,10 +1134,6 @@ static int __gpu_buddy_alloc_range(struct gpu_buddy *mm,
 				   struct list_head *blocks)
 {
 	LIST_HEAD(dfs);
-	int i;
-
-	for (i = 0; i < mm->n_roots; ++i)
-		list_add_tail(&mm->roots[i]->tmp_link, &dfs);
 
 	return __alloc_range(mm, &dfs, start, size,
 			     blocks, total_allocated_on_err);
-- 
2.34.1
