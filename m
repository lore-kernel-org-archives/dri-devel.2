Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BABB2C43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 07:07:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDE1310F7C7;
	Fri, 10 Jul 2026 07:07:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=picoheart.com header.i=@picoheart.com header.b="X/F+HME9";
	dkim-atps=neutral
X-Greylist: delayed 915 seconds by postgrey-1.36 at gabe;
 Thu, 09 Jul 2026 11:36:08 UTC
Received: from va-2-26.ptr.blmpb.com (va-2-26.ptr.blmpb.com [209.127.231.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69A3410F509
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 11:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604151535; d=picoheart.com; t=1783596048; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=D2i8ZuHJ2F1jxfLrB94uIt8iw3y4WkoHGS9SYRro9x8=;
 b=X/F+HME9r0iL7fojyFPEE4q9Gcwz429CZiWGD5Knc5sDA6jX0GWz99jCuvw0CSKei84rs9
 25k0xK0wUfjkwQPL2EziGH3qHBXFbOQnZbE26OT9PSOnMGeSQ4401pFOl/BGWFsR0TMKMI
 vOg9ERjdyzpZvSg4GZ4PU17cNrYOu+MrbY4j1Q+IVOM7sJMqid95vcM2lRZ5h9fBeOGXCe
 uBaXJClTCPNiYwnfKL0UrXI+/+btjaqUizFKk8NQ3NRMgxXVHWV+cgPP64YAIUTIj5w0Qu
 2uPybnh5Indp+HCpKEvjo6RdqpozFyUKcaJsCobGh01/oWdmcEf+RSN+LsN+fg==
Content-Type: text/plain; charset=UTF-8
X-Original-From: Zhaoyu Liu <liuzhaoyu.zackary@picoheart.com>
From: "Zhaoyu Liu" <liuzhaoyu.zackary@picoheart.com>
Received: from hostpc ([183.129.139.234]) by smtp.feishu.cn with ESMTPS;
 Thu, 09 Jul 2026 19:20:45 +0800
Content-Disposition: inline
To: <matthew.auld@intel.com>, <arunpravin.paneerselvam@amd.com>, 
 <joelagnelf@nvidia.com>, <airlied@gmail.com>, <simona@ffwll.ch>
Subject: [PATCH] gpu: buddy: avoid repeated builds of root dfs when alloc range
Date: Thu, 9 Jul 2026 19:20:43 +0800
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26a4f840e+3b14b9+lists.freedesktop.org+liuzhaoyu.zackary@picoheart.com>
Cc: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Message-Id: <ak+ECwsuSljmvyKd@hostpc>
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 10 Jul 2026 07:06:09 +0000
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
---
 drivers/gpu/buddy.c | 61 ++++++++++++++++++++++++++++++---------------
 1 file changed, 41 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
index dc81fe0301ce..2cebb87020c7 100644
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
+static struct gpu_buddy_block*
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
