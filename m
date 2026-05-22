Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC2F0CD5BB1
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 09:26:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F0C110F513;
	Fri, 22 May 2026 09:26:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="gVbdqoHm";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 141E110E64F;
 Fri, 22 May 2026 09:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779441989; x=1810977989;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YS1/9MHpYZLleb52+YI+eV9Tsi8puDczwB94PW/RMH4=;
 b=gVbdqoHmOZO2nO7y5JBvea0ZuoBe2cdp6cHckEkRWkdkfQub7P7qYFr1
 OlQfmd1v7p7XzhXG2Wbu3dG+9bjTFPCatYr8hIsWzYCNmsz7EsWZ5b0JO
 wEVGSMpxeIlyDNL1eWOGaglo23ZA8PeQ6kPdwXFk24EbL8s491couPtjE
 nRjqxz6o1dlNEEWsXCBU5CwsfpbUtV6LzQuQPAE4yMKSy089+sR9MnBY3
 Y179zV7wXg9lfip+cW21Mr7NvqmR0ewt9F4n9ZFVaobUa4W3KyzyD4D/Q
 u6duk6zgJZejdagcdWdkE70f+zHtRTLpEhYNMwMZqLycnQukYvKYyhNg+ g==;
X-CSE-ConnectionGUID: IhfTjeTeQdOzZn1ljtm+Bg==
X-CSE-MsgGUID: cW8AE8qmRUm6+xTl4TxQkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="67895305"
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="67895305"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 02:26:29 -0700
X-CSE-ConnectionGUID: v3kv/0YLSByleGeqgFnv2Q==
X-CSE-MsgGUID: wt7FTlm3TjKJd3hRPwO3Ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="237830305"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO fdugast-desk.home)
 ([10.245.244.230])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 02:26:27 -0700
From: Francois Dugast <francois.dugast@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, matthew.auld@intel.com,
 Arunpravin.PaneerSelvam@amd.com,
 Francois Dugast <francois.dugast@intel.com>
Subject: [PATCH v4 3/5] gpu/buddy: Introduce __gpu_buddy_undo_splits() helper
Date: Fri, 22 May 2026 11:25:30 +0200
Message-ID: <20260522092600.32818-4-francois.dugast@intel.com>
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

The pattern of merging a block back with its buddy on error paths is
duplicated across multiple locations. Extract it into a
__gpu_buddy_undo_splits() helper to avoid repetition and prepare for
future changes.

Signed-off-by: Francois Dugast <francois.dugast@intel.com>
Suggested-by: Matthew Auld <matthew.auld@intel.com>
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
---
 drivers/gpu/buddy.c | 43 +++++++++++++++++--------------------------
 1 file changed, 17 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
index 9f6696f47f89..8654604b87a4 100644
--- a/drivers/gpu/buddy.c
+++ b/drivers/gpu/buddy.c
@@ -650,6 +650,19 @@ static bool block_incompatible(struct gpu_buddy_block *block, unsigned int flags
 	return needs_clear != gpu_buddy_block_is_clear(block);
 }
 
+static void __gpu_buddy_undo_splits(struct gpu_buddy *mm,
+				    struct gpu_buddy_block *block)
+{
+	struct gpu_buddy_block *buddy = __get_buddy(block);
+
+	if (buddy &&
+	    (gpu_buddy_block_is_free(block) &&
+	     gpu_buddy_block_is_free(buddy))) {
+		rbtree_remove(mm, block);
+		__gpu_buddy_free(mm, block, false);
+	}
+}
+
 static struct gpu_buddy_block *
 __alloc_range_bias(struct gpu_buddy *mm,
 		   u64 start, u64 end,
@@ -659,7 +672,6 @@ __alloc_range_bias(struct gpu_buddy *mm,
 {
 	u64 req_size = mm->chunk_size << order;
 	struct gpu_buddy_block *block;
-	struct gpu_buddy_block *buddy;
 	LIST_HEAD(dfs);
 	int err;
 	int i;
@@ -734,13 +746,7 @@ __alloc_range_bias(struct gpu_buddy *mm,
 	 * bigger is better, so make sure we merge everything back before we
 	 * free the allocated blocks.
 	 */
-	buddy = __get_buddy(block);
-	if (buddy &&
-	    (gpu_buddy_block_is_free(block) &&
-	     gpu_buddy_block_is_free(buddy))) {
-		rbtree_remove(mm, block);
-		__gpu_buddy_free(mm, block, false);
-	}
+	__gpu_buddy_undo_splits(mm, block);
 	return ERR_PTR(err);
 }
 
@@ -849,8 +855,7 @@ alloc_from_freetree(struct gpu_buddy *mm,
 	return block;
 
 err_undo:
-	rbtree_remove(mm, block);
-	__gpu_buddy_free(mm, block, false);
+	__gpu_buddy_undo_splits(mm, block);
 	return ERR_PTR(err);
 }
 
@@ -914,7 +919,6 @@ gpu_buddy_offset_aligned_allocation(struct gpu_buddy *mm,
 {
 	struct gpu_buddy_block *block = NULL;
 	unsigned int order, tmp, alignment;
-	struct gpu_buddy_block *buddy;
 	enum gpu_buddy_free_tree tree;
 	unsigned long pages;
 	int err;
@@ -967,13 +971,7 @@ gpu_buddy_offset_aligned_allocation(struct gpu_buddy *mm,
 	 * bigger is better, so make sure we merge everything back before we
 	 * free the allocated blocks.
 	 */
-	buddy = __get_buddy(block);
-	if (buddy &&
-	    (gpu_buddy_block_is_free(block) &&
-	     gpu_buddy_block_is_free(buddy))) {
-		rbtree_remove(mm, block);
-		__gpu_buddy_free(mm, block, false);
-	}
+	__gpu_buddy_undo_splits(mm, block);
 	return ERR_PTR(err);
 }
 
@@ -984,7 +982,6 @@ static int __alloc_range(struct gpu_buddy *mm,
 			 u64 *total_allocated_on_err)
 {
 	struct gpu_buddy_block *block;
-	struct gpu_buddy_block *buddy;
 	u64 total_allocated = 0;
 	LIST_HEAD(allocated);
 	u64 end;
@@ -1055,13 +1052,7 @@ static int __alloc_range(struct gpu_buddy *mm,
 	 * bigger is better, so make sure we merge everything back before we
 	 * free the allocated blocks.
 	 */
-	buddy = __get_buddy(block);
-	if (buddy &&
-	    (gpu_buddy_block_is_free(block) &&
-	     gpu_buddy_block_is_free(buddy))) {
-		rbtree_remove(mm, block);
-		__gpu_buddy_free(mm, block, false);
-	}
+	__gpu_buddy_undo_splits(mm, block);
 
 err_free:
 	if (err == -ENOSPC && total_allocated_on_err) {
-- 
2.43.0

