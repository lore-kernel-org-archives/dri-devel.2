Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAEF4CD4F49
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 14:15:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C037E10E888;
	Mon, 18 May 2026 14:15:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="PZjfzC4o";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3617510E887;
 Mon, 18 May 2026 14:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779113702; x=1810649702;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wYD8yzhnaidhPpjefKwbmdgugwQQItpqAUuErSUcIq4=;
 b=PZjfzC4ojz0m8uq1WDwLjxOLhF0iKljOHbhUOVA+khuEkZFgoGxJOrTV
 vqO3+cZQOt7bsV8CevwdTWyuzGqdlwblvB7LCdJdRyzPbclOmF4EmylQI
 febvOUIOE7sUwqI5+is4XvVvK9Kf5aICuNzRWcSOghgskao2oPKCSN1H/
 TDISCGPY/VjKRUGHg4fA0hJOLZ7vgl4O2XVG0olAjyKSCNBFs6Dkcka8W
 yuVAr9MltxLkltokeSu8XdMuv2O+wtwqhFO+5y/QCNTiVuCEXawsn1y7W
 iJkIPXzc2yTafZklAxsTYY1BjWPIiM0msK22A9A9GCmO/J6vJ8JhWEjum Q==;
X-CSE-ConnectionGUID: 3ANxMdhTQ8yU/rEetEY39w==
X-CSE-MsgGUID: OUZdxVWlStqZBIbxxPKAHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="79105901"
X-IronPort-AV: E=Sophos;i="6.23,242,1770624000"; d="scan'208";a="79105901"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2026 07:15:02 -0700
X-CSE-ConnectionGUID: FhJOvId1ToSlc/zjnqVFnQ==
X-CSE-MsgGUID: 0Z8U9fd6T7G2fJT7+LhkbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,242,1770624000"; d="scan'208";a="244417263"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO fdugast-desk.intel.com)
 ([10.245.244.73])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2026 07:15:00 -0700
From: Francois Dugast <francois.dugast@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, matthew.auld@intel.com,
 Francois Dugast <francois.dugast@intel.com>
Subject: [PATCH v3 3/5] gpu/buddy: Introduce __gpu_buddy_undo_splits() helper
Date: Mon, 18 May 2026 16:14:28 +0200
Message-ID: <20260518141446.124508-4-francois.dugast@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518141446.124508-1-francois.dugast@intel.com>
References: <20260518141446.124508-1-francois.dugast@intel.com>
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

