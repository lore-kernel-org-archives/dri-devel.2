Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E26C5CFDB
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 13:33:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E90D10E555;
	Fri, 14 Aug 2026 13:33:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="G3ZpjrOU";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9412810E142;
 Fri, 14 Aug 2026 13:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786714385; x=1818250385;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=VZltXhv2FQanNINB4fxYHbDp8TpCh5V8SLq6J3y4Rf8=;
 b=G3ZpjrOUIHoi4/U4FVhZ/ZNNsrsvzYUATKfJA0zrjmc3kFXIuAmpi50K
 aQVmg88tIBWuiIj7mrEPHOFnwYUVMa3kLkgG/Ne3kHpQJ1Q/ObHq1QRFt
 glYdj1C8yTsct9xo+YXPHkIUBboCU4e5Lt8VoU4Zlr/BhXlSlSsYbSIq9
 3UQWiEvutQblzF+WgX8wpy74voia+D3V6KbSjJ7sWRxNROsqJtxke6aLh
 mq0u6ctTw8TQ8vKL101mhjMTTiyTtd9zfYv2E3dxT7j4lpfm4bgdbipjd
 Qth/ZAQscrzLENRI4sr5W6cce91tLeMjTC0SIKk91gZjltt+Kp6FgHXVq w==;
X-CSE-ConnectionGUID: oRNySQ1PRrm6lWdKflt6iQ==
X-CSE-MsgGUID: UIDCZTHjTxiQVSiYD+zPgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="98650165"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; d="scan'208";a="98650165"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2026 06:33:04 -0700
X-CSE-ConnectionGUID: OPP+AOj1T6OSfaxaLK83xA==
X-CSE-MsgGUID: Lwrz1msiScKWTcMWMmRRNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; d="scan'208";a="258007248"
Received: from rvuia-mobl.ger.corp.intel.com (HELO fedora) ([10.245.244.164])
 by fmviesa009-auth.fm.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 06:33:02 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/ttm: Represent LRU bulk moves as nested sublists
Date: Fri, 14 Aug 2026 15:32:31 +0200
Message-ID: <20260814133231.3193-1-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The LRU bulk move mechanism tracked each (domain, priority) group as a
{first, last} range of resources threaded directly on the manager LRU
list. Group membership was implicit, derived from per-buffer-object
back-pointers, and moving a group required first evacuating every cursor
that pointed into the range. This range representation was fragile: the
first/last endpoints could get out of sync with the actual list contents,
for example on an empty range, or when a member was pinned, swapped out
and later repopulated. That corrupted the manager LRU lists and caused
crashes, notably during hibernation.

Represent each bulk move group as a real nested sublist instead. Each
(domain, priority) group owns a persistent anchor node, a new
TTM_LRU_BULK item, linked on the manager LRU list, plus a sublist holding
its member resources. Adding, removing and reordering members become
unconditional list_move_tail()/list_del_init() operations that cannot
leave stale endpoints behind, and moving a whole group is a single
list_move_tail() of the anchor. The LRU walk descends into a group's
sublist when it reaches the anchor and resumes the manager list
afterwards.

The cursor carries two hitches. The main hitch stays parked on the
manager LRU list while the cursor descends, so that a concurrent bulk
move of the anchor cannot make the walk skip entries, and a second hitch
walks the sublist. Re-encountering a moved anchor simply re-walks its
sublist, which is harmless.

This removes the per-object back-pointer dereference during traversal and
simplifies the cursor tracking and adjustment machinery, eliminating the
class of range-corruption bugs by construction.

v2: Detach descended cursors on bulk LRU bump.
- Keep cursor detach on bulk finalize as a separate helper function.
- Documentation update.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/5387
Assisted-by: GitHub_Copilot:claude-opus-4.8
Assisted-by: GitHub_Copilot:claude-sonnet-5
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org
---
 drivers/gpu/drm/ttm/tests/ttm_bo_test.c |  26 +-
 drivers/gpu/drm/ttm/ttm_bo.c            |   9 +-
 drivers/gpu/drm/ttm/ttm_resource.c      | 335 ++++++++++++++----------
 include/drm/ttm/ttm_resource.h          |  57 ++--
 4 files changed, 244 insertions(+), 183 deletions(-)

diff --git a/drivers/gpu/drm/ttm/tests/ttm_bo_test.c b/drivers/gpu/drm/ttm/tests/ttm_bo_test.c
index f3103307b5df..b40d93632491 100644
--- a/drivers/gpu/drm/ttm/tests/ttm_bo_test.c
+++ b/drivers/gpu/drm/ttm/tests/ttm_bo_test.c
@@ -30,6 +30,19 @@ struct ttm_bo_test_case {
 	bool no_wait;
 };
 
+/* Return the last resource in a bulk move sublist, or NULL if empty. */
+static struct ttm_resource *
+ttm_bo_test_pos_last_res(struct ttm_lru_bulk_move_pos *pos)
+{
+	struct ttm_lru_item *lru;
+
+	list_for_each_entry_reverse(lru, &pos->sublist, link)
+		if (ttm_lru_item_is_res(lru))
+			return ttm_lru_item_to_res(lru);
+
+	return NULL;
+}
+
 static const struct ttm_bo_test_case ttm_bo_reserved_cases[] = {
 	{
 		.description = "Cannot be interrupted and sleeps",
@@ -371,7 +384,7 @@ static void ttm_bo_unreserve_bulk(struct kunit *test)
 	ttm_bo_unreserve(bo1);
 
 	pos = &lru_bulk_move.pos[mem_type][bo_priority];
-	KUNIT_ASSERT_PTR_EQ(test, res1, pos->last);
+	KUNIT_ASSERT_PTR_EQ(test, res1, ttm_bo_test_pos_last_res(pos));
 
 	ttm_resource_free(bo1, &res1);
 	ttm_resource_free(bo2, &res2);
@@ -530,14 +543,13 @@ static void ttm_bo_pin_unpin_resource(struct kunit *test)
 	pos = &lru_bulk_move.pos[mem_type][bo_priority];
 
 	KUNIT_ASSERT_EQ(test, bo->pin_count, 1);
-	KUNIT_ASSERT_NULL(test, pos->first);
-	KUNIT_ASSERT_NULL(test, pos->last);
+	KUNIT_ASSERT_NULL(test, ttm_lru_first_res_or_null(&pos->sublist));
 
 	dma_resv_lock(bo->base.resv, NULL);
 	ttm_bo_unpin(bo);
 	dma_resv_unlock(bo->base.resv);
 
-	KUNIT_ASSERT_PTR_EQ(test, res, pos->last);
+	KUNIT_ASSERT_PTR_EQ(test, res, ttm_bo_test_pos_last_res(pos));
 	KUNIT_ASSERT_EQ(test, bo->pin_count, 0);
 
 	ttm_resource_free(bo, &res);
@@ -585,16 +597,14 @@ static void ttm_bo_multiple_pin_one_unpin(struct kunit *test)
 	pos = &lru_bulk_move.pos[mem_type][bo_priority];
 
 	KUNIT_ASSERT_EQ(test, bo->pin_count, 2);
-	KUNIT_ASSERT_NULL(test, pos->first);
-	KUNIT_ASSERT_NULL(test, pos->last);
+	KUNIT_ASSERT_NULL(test, ttm_lru_first_res_or_null(&pos->sublist));
 
 	dma_resv_lock(bo->base.resv, NULL);
 	ttm_bo_unpin(bo);
 	dma_resv_unlock(bo->base.resv);
 
 	KUNIT_ASSERT_EQ(test, bo->pin_count, 1);
-	KUNIT_ASSERT_NULL(test, pos->first);
-	KUNIT_ASSERT_NULL(test, pos->last);
+	KUNIT_ASSERT_NULL(test, ttm_lru_first_res_or_null(&pos->sublist));
 
 	dma_resv_lock(bo->base.resv, NULL);
 	ttm_bo_unpin(bo);
diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index ef56c18ded1b..c24f957a5fae 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -109,11 +109,14 @@ void ttm_bo_set_bulk_move(struct ttm_buffer_object *bo,
 		return;
 
 	spin_lock(&bo->bdev->lru_lock);
-	if (bo->resource)
+	if (bo->resource) {
 		ttm_resource_del_bulk_move(bo->resource, bo);
-	bo->bulk_move = bulk;
-	if (bo->resource)
+		bo->bulk_move = bulk;
 		ttm_resource_add_bulk_move(bo->resource, bo);
+		ttm_resource_move_to_lru_tail(bo->resource);
+	} else {
+		bo->bulk_move = bulk;
+	}
 	spin_unlock(&bo->bdev->lru_lock);
 }
 EXPORT_SYMBOL(ttm_bo_set_bulk_move);
diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ttm/ttm_resource.c
index 4e6d3d658d85..195f960b2d73 100644
--- a/drivers/gpu/drm/ttm/ttm_resource.c
+++ b/drivers/gpu/drm/ttm/ttm_resource.c
@@ -37,53 +37,6 @@
 #include <drm/drm_print.h>
 #include <drm/drm_util.h>
 
-/* Detach the cursor from the bulk move list */
-static void
-ttm_resource_cursor_clear_bulk(struct ttm_resource_cursor *cursor)
-{
-	lockdep_assert_held(&cursor->man->bdev->lru_lock);
-
-	cursor->bulk = NULL;
-	list_del_init(&cursor->bulk_link);
-}
-
-/* Move the cursor to the end of the bulk move list it's in */
-static void ttm_resource_cursor_move_bulk_tail(struct ttm_lru_bulk_move *bulk,
-					       struct ttm_resource_cursor *cursor)
-{
-	struct ttm_lru_bulk_move_pos *pos;
-
-	lockdep_assert_held(&cursor->man->bdev->lru_lock);
-
-	if (WARN_ON_ONCE(bulk != cursor->bulk)) {
-		list_del_init(&cursor->bulk_link);
-		return;
-	}
-
-	pos = &bulk->pos[cursor->mem_type][cursor->priority];
-	if (pos->last)
-		list_move(&cursor->hitch.link, &pos->last->lru.link);
-	ttm_resource_cursor_clear_bulk(cursor);
-}
-
-/* Move all cursors attached to a bulk move to its end */
-static void ttm_bulk_move_adjust_cursors(struct ttm_lru_bulk_move *bulk)
-{
-	struct ttm_resource_cursor *cursor, *next;
-
-	list_for_each_entry_safe(cursor, next, &bulk->cursor_list, bulk_link)
-		ttm_resource_cursor_move_bulk_tail(bulk, cursor);
-}
-
-/* Remove a cursor from an empty bulk move list */
-static void ttm_bulk_move_drop_cursors(struct ttm_lru_bulk_move *bulk)
-{
-	struct ttm_resource_cursor *cursor, *next;
-
-	list_for_each_entry_safe(cursor, next, &bulk->cursor_list, bulk_link)
-		ttm_resource_cursor_clear_bulk(cursor);
-}
-
 /**
  * ttm_resource_cursor_init() - Initialize a struct ttm_resource_cursor
  * @cursor: The cursor to initialize.
@@ -96,9 +49,11 @@ void ttm_resource_cursor_init(struct ttm_resource_cursor *cursor,
 {
 	cursor->priority = 0;
 	cursor->man = man;
+	cursor->cur_list = NULL;
 	ttm_lru_item_init(&cursor->hitch, TTM_LRU_HITCH);
-	INIT_LIST_HEAD(&cursor->bulk_link);
+	ttm_lru_item_init(&cursor->sublist_hitch, TTM_LRU_HITCH);
 	INIT_LIST_HEAD(&cursor->hitch.link);
+	INIT_LIST_HEAD(&cursor->sublist_hitch.link);
 }
 
 /**
@@ -113,39 +68,127 @@ void ttm_resource_cursor_fini(struct ttm_resource_cursor *cursor)
 {
 	lockdep_assert_held(&cursor->man->bdev->lru_lock);
 	list_del_init(&cursor->hitch.link);
-	ttm_resource_cursor_clear_bulk(cursor);
+	list_del_init(&cursor->sublist_hitch.link);
+	cursor->cur_list = NULL;
 }
 
 /**
  * ttm_lru_bulk_move_init - initialize a bulk move structure
  * @bulk: the structure to init
  *
- * For now just memset the structure to zero.
+ * Initialize the resource sublists and their LRU anchors.
  */
 void ttm_lru_bulk_move_init(struct ttm_lru_bulk_move *bulk)
 {
+	unsigned int i, j;
+
 	memset(bulk, 0, sizeof(*bulk));
-	INIT_LIST_HEAD(&bulk->cursor_list);
+	for (i = 0; i < TTM_NUM_MEM_TYPES; ++i) {
+		for (j = 0; j < TTM_MAX_BO_PRIORITY; ++j) {
+			struct ttm_lru_bulk_move_pos *pos = &bulk->pos[i][j];
+
+			ttm_lru_item_init(&pos->marker, TTM_LRU_BULK);
+			INIT_LIST_HEAD(&pos->sublist);
+		}
+	}
 }
 EXPORT_SYMBOL(ttm_lru_bulk_move_init);
 
+/*
+ * Detach the bulk move from the manager LRU lists so that it can be
+ * freed. Any cursor still traversing a sublist is repointed at the
+ * manager LRU list, and it is verified that the bulk move holds no
+ * resources.
+ */
+static void ttm_bulk_move_drop_cursors(struct ttm_device *bdev,
+					struct ttm_lru_bulk_move *bulk)
+{
+	unsigned int i, j;
+
+	for (i = 0; i < TTM_NUM_MEM_TYPES; ++i) {
+		struct ttm_resource_manager *man = ttm_manager_type(bdev, i);
+
+		for (j = 0; j < TTM_MAX_BO_PRIORITY; ++j) {
+			struct ttm_lru_bulk_move_pos *pos = &bulk->pos[i][j];
+			struct ttm_lru_item *lru, *next;
+
+			list_for_each_entry_safe(lru, next, &pos->sublist, link) {
+				struct ttm_resource_cursor *cursor;
+
+				if (ttm_lru_item_is_res(lru)) {
+					WARN_ON_ONCE(1);
+					continue;
+				}
+				/*
+				 * This cursor descended here; its main hitch
+				 * already sits on the manager list, so just
+				 * detach it from this sublist.
+				 */
+				cursor = container_of(lru, typeof(*cursor),
+						      sublist_hitch);
+				cursor->cur_list = &man->lru[j];
+				list_del_init(&lru->link);
+			}
+			list_splice_tail_init(&pos->sublist, &man->lru[j]);
+			list_del_init(&pos->marker.link);
+		}
+	}
+}
+
 /**
  * ttm_lru_bulk_move_fini - finalize a bulk move structure
  * @bdev: The struct ttm_device
  * @bulk: the structure to finalize
  *
- * Sanity checks that bulk moves don't have any
- * resources left and hence no cursors attached.
+ * Detaches the bulk move from the manager LRU lists so that it can be
+ * freed. Any cursor still traversing the bulk move is repointed at the
+ * manager LRU list, and it is verified that the bulk move holds no
+ * resources.
  */
 void ttm_lru_bulk_move_fini(struct ttm_device *bdev,
 			    struct ttm_lru_bulk_move *bulk)
 {
 	spin_lock(&bdev->lru_lock);
-	ttm_bulk_move_drop_cursors(bulk);
+	ttm_bulk_move_drop_cursors(bdev, bulk);
 	spin_unlock(&bdev->lru_lock);
 }
 EXPORT_SYMBOL(ttm_lru_bulk_move_fini);
 
+/*
+ * Detach any cursor that has descended into pos's sublist so it
+ * resumes walking the manager LRU list, without walking the
+ * (potentially large) sublist itself, which would defeat the point of
+ * a bulk tail move. It suffices to look at the run of cursor hitches
+ * parked immediately after pos's anchor in the manager list, since
+ * that's exactly where a descended cursor's main hitch sits (see
+ * ttm_resource_manager_next()). A hitch whose cursor has since exited
+ * the sublist on its own is skipped rather than ending the run; only
+ * one still parked in a different, still-live sublist marks the
+ * actual end.
+ */
+static void ttm_lru_bulk_move_pos_adjust_cursors(struct ttm_resource_manager *man,
+						 struct ttm_lru_bulk_move_pos *pos,
+						 unsigned int priority)
+{
+	struct ttm_lru_item *lru = &pos->marker;
+
+	list_for_each_entry_continue(lru, &man->lru[priority], link) {
+		struct ttm_resource_cursor *cursor;
+
+		if (lru->type != TTM_LRU_HITCH)
+			break;
+
+		cursor = container_of(lru, typeof(*cursor), hitch);
+		if (cursor->cur_list == &man->lru[priority])
+			continue;
+		if (cursor->cur_list != &pos->sublist)
+			break;
+
+		list_del_init(&cursor->sublist_hitch.link);
+		cursor->cur_list = &man->lru[priority];
+	}
+}
+
 /**
  * ttm_lru_bulk_move_tail - bulk move range of resources to the LRU tail.
  *
@@ -156,24 +199,24 @@ EXPORT_SYMBOL(ttm_lru_bulk_move_fini);
  */
 void ttm_lru_bulk_move_tail(struct ttm_lru_bulk_move *bulk)
 {
-	unsigned i, j;
+	unsigned int i, j;
 
-	ttm_bulk_move_adjust_cursors(bulk);
 	for (i = 0; i < TTM_NUM_MEM_TYPES; ++i) {
 		for (j = 0; j < TTM_MAX_BO_PRIORITY; ++j) {
 			struct ttm_lru_bulk_move_pos *pos = &bulk->pos[i][j];
 			struct ttm_resource_manager *man;
+			struct ttm_resource *first;
 
-			if (!pos->first)
+			first = ttm_lru_first_res_or_null(&pos->sublist);
+			if (!first)
 				continue;
 
-			lockdep_assert_held(&pos->first->bo->bdev->lru_lock);
-			dma_resv_assert_held(pos->first->bo->base.resv);
-			dma_resv_assert_held(pos->last->bo->base.resv);
+			lockdep_assert_held(&first->bo->bdev->lru_lock);
+			dma_resv_assert_held(first->bo->base.resv);
 
-			man = ttm_manager_type(pos->first->bo->bdev, i);
-			list_bulk_move_tail(&man->lru[j], &pos->first->lru.link,
-					    &pos->last->lru.link);
+			man = ttm_manager_type(first->bo->bdev, i);
+			ttm_lru_bulk_move_pos_adjust_cursors(man, pos, j);
+			list_move_tail(&pos->marker.link, &man->lru[j]);
 		}
 	}
 }
@@ -186,74 +229,59 @@ ttm_lru_bulk_move_pos(struct ttm_lru_bulk_move *bulk, struct ttm_resource *res)
 	return &bulk->pos[res->mem_type][res->bo->priority];
 }
 
-/* Return the previous resource on the list (skip over non-resource list items) */
-static struct ttm_resource *ttm_lru_prev_res(struct ttm_resource *cur)
+/* Make sure the bulk move anchor is linked into the manager LRU list */
+static void ttm_lru_bulk_move_link_marker(struct ttm_lru_bulk_move_pos *pos,
+					  struct ttm_resource *res)
 {
-	struct ttm_lru_item *lru = &cur->lru;
-
-	do {
-		lru = list_prev_entry(lru, link);
-	} while (!ttm_lru_item_is_res(lru));
-
-	return ttm_lru_item_to_res(lru);
-}
-
-/* Return the next resource on the list (skip over non-resource list items) */
-static struct ttm_resource *ttm_lru_next_res(struct ttm_resource *cur)
-{
-	struct ttm_lru_item *lru = &cur->lru;
-
-	do {
-		lru = list_next_entry(lru, link);
-	} while (!ttm_lru_item_is_res(lru));
-
-	return ttm_lru_item_to_res(lru);
-}
+	struct ttm_buffer_object *bo = res->bo;
+	struct ttm_resource_manager *man =
+		ttm_manager_type(bo->bdev, res->mem_type);
 
-/* Move the resource to the tail of the bulk move range */
-static void ttm_lru_bulk_move_pos_tail(struct ttm_lru_bulk_move_pos *pos,
-				       struct ttm_resource *res)
-{
-	if (pos->last != res) {
-		if (pos->first == res)
-			pos->first = ttm_lru_next_res(res);
-		list_move(&res->lru.link, &pos->last->lru.link);
-		pos->last = res;
-	}
+	if (list_empty(&pos->marker.link))
+		list_add_tail(&pos->marker.link, &man->lru[bo->priority]);
 }
 
-/* Add the resource to a bulk_move cursor */
+/* Add the resource to a bulk_move sublist */
 static void ttm_lru_bulk_move_add(struct ttm_lru_bulk_move *bulk,
 				  struct ttm_resource *res)
 {
 	struct ttm_lru_bulk_move_pos *pos = ttm_lru_bulk_move_pos(bulk, res);
+	struct ttm_resource *first = ttm_lru_first_res_or_null(&pos->sublist);
+	struct ttm_buffer_object *bo = res->bo;
+	struct ttm_resource_manager *man =
+		ttm_manager_type(bo->bdev, res->mem_type);
 
-	if (!pos->first) {
-		pos->first = res;
-		pos->last = res;
+	if (first) {
+		WARN_ON(first->bo->base.resv != res->bo->base.resv);
 	} else {
-		WARN_ON(pos->first->bo->base.resv != res->bo->base.resv);
-		ttm_lru_bulk_move_pos_tail(pos, res);
+		/*
+		 * Group empty (first activation, or all members were pinned
+		 * or swapped out); re-seed the anchor at the tail so it
+		 * counts as recently used.
+		 */
+		list_move_tail(&pos->marker.link, &man->lru[bo->priority]);
 	}
+	/*
+	 * The resource may still be on another list (manager LRU or
+	 * bdev->unevictable); move it unconditionally to keep group
+	 * membership consistent.
+	 */
+	list_move_tail(&res->lru.link, &pos->sublist);
 }
 
-/* Remove the resource from a bulk_move range */
+/* Remove the resource from its bulk_move sublist */
 static void ttm_lru_bulk_move_del(struct ttm_lru_bulk_move *bulk,
 				  struct ttm_resource *res)
 {
-	struct ttm_lru_bulk_move_pos *pos = ttm_lru_bulk_move_pos(bulk, res);
+	list_del_init(&res->lru.link);
+}
 
-	if (unlikely(WARN_ON(!pos->first || !pos->last) ||
-		     (pos->first == res && pos->last == res))) {
-		pos->first = NULL;
-		pos->last = NULL;
-	} else if (pos->first == res) {
-		pos->first = ttm_lru_next_res(res);
-	} else if (pos->last == res) {
-		pos->last = ttm_lru_prev_res(res);
-	} else {
-		list_move(&res->lru.link, &pos->last->lru.link);
-	}
+/* Move the resource to the tail of its bulk_move sublist */
+static void ttm_lru_bulk_move_pos_tail(struct ttm_lru_bulk_move_pos *pos,
+				       struct ttm_resource *res)
+{
+	ttm_lru_bulk_move_link_marker(pos, res);
+	list_move_tail(&res->lru.link, &pos->sublist);
 }
 
 static bool ttm_resource_is_swapped(struct ttm_resource *res, struct ttm_buffer_object *bo)
@@ -652,28 +680,6 @@ void ttm_resource_manager_debug(struct ttm_resource_manager *man,
 }
 EXPORT_SYMBOL(ttm_resource_manager_debug);
 
-static void
-ttm_resource_cursor_check_bulk(struct ttm_resource_cursor *cursor,
-			       struct ttm_lru_item *next_lru)
-{
-	struct ttm_resource *next = ttm_lru_item_to_res(next_lru);
-	struct ttm_lru_bulk_move *bulk;
-
-	lockdep_assert_held(&cursor->man->bdev->lru_lock);
-
-	bulk = next->bo->bulk_move;
-
-	if (cursor->bulk != bulk) {
-		if (bulk) {
-			list_move_tail(&cursor->bulk_link, &bulk->cursor_list);
-			cursor->mem_type = next->mem_type;
-		} else {
-			list_del_init(&cursor->bulk_link);
-		}
-		cursor->bulk = bulk;
-	}
-}
-
 /**
  * ttm_resource_manager_first() - Start iterating over the resources
  * of a resource manager
@@ -694,7 +700,9 @@ ttm_resource_manager_first(struct ttm_resource_cursor *cursor)
 
 	lockdep_assert_held(&man->bdev->lru_lock);
 
-	list_move(&cursor->hitch.link, &man->lru[cursor->priority]);
+	cursor->priority = 0;
+	cursor->cur_list = &man->lru[cursor->priority];
+	list_move(&cursor->hitch.link, cursor->cur_list);
 	return ttm_resource_manager_next(cursor);
 }
 
@@ -714,20 +722,50 @@ ttm_resource_manager_next(struct ttm_resource_cursor *cursor)
 	lockdep_assert_held(&man->bdev->lru_lock);
 
 	for (;;) {
-		lru = &cursor->hitch;
-		list_for_each_entry_continue(lru, &man->lru[cursor->priority], link) {
+		struct list_head *list = cursor->cur_list;
+		struct ttm_lru_item *hitch;
+		bool in_sublist;
+
+		/* The main hitch stays on the manager list while descended. */
+		in_sublist = list != &man->lru[cursor->priority];
+		hitch = in_sublist ? &cursor->sublist_hitch : &cursor->hitch;
+
+		lru = hitch;
+		list_for_each_entry_continue(lru, list, link) {
 			if (ttm_lru_item_is_res(lru)) {
-				ttm_resource_cursor_check_bulk(cursor, lru);
-				list_move(&cursor->hitch.link, &lru->link);
+				list_move(&hitch->link, &lru->link);
 				return ttm_lru_item_to_res(lru);
 			}
+			if (lru->type == TTM_LRU_BULK) {
+				struct ttm_lru_bulk_move_pos *pos =
+					container_of(lru, typeof(*pos), marker);
+
+				/*
+				 * Keep the main hitch parked right after the
+				 * anchor so a concurrent bulk move of the
+				 * anchor cannot make the walk skip entries.
+				 */
+				list_move(&cursor->hitch.link, &lru->link);
+				list_add(&cursor->sublist_hitch.link,
+					 &pos->sublist);
+				cursor->cur_list = &pos->sublist;
+				goto next_list;
+			}
+		}
+
+		if (in_sublist) {
+			list_del_init(&cursor->sublist_hitch.link);
+			cursor->cur_list = &man->lru[cursor->priority];
+			continue;
 		}
 
 		if (++cursor->priority >= TTM_MAX_BO_PRIORITY)
 			break;
 
-		list_move(&cursor->hitch.link, &man->lru[cursor->priority]);
-		ttm_resource_cursor_clear_bulk(cursor);
+		cursor->cur_list = &man->lru[cursor->priority];
+		list_move(&cursor->hitch.link, cursor->cur_list);
+next_list:
+		;
 	}
 
 	return NULL;
@@ -737,6 +775,8 @@ ttm_resource_manager_next(struct ttm_resource_cursor *cursor)
  * ttm_lru_first_res_or_null() - Return the first resource on an lru list
  * @head: The list head of the lru list.
  *
+ * Resources that are members of a bulk move on the list are also considered.
+ *
  * Return: Pointer to the first resource on the lru list or NULL if
  * there is none.
  */
@@ -747,6 +787,15 @@ struct ttm_resource *ttm_lru_first_res_or_null(struct list_head *head)
 	list_for_each_entry(lru, head, link) {
 		if (ttm_lru_item_is_res(lru))
 			return ttm_lru_item_to_res(lru);
+		if (lru->type == TTM_LRU_BULK) {
+			struct ttm_lru_bulk_move_pos *pos =
+				container_of(lru, typeof(*pos), marker);
+			struct ttm_resource *res =
+				ttm_lru_first_res_or_null(&pos->sublist);
+
+			if (res)
+				return res;
+		}
 	}
 
 	return NULL;
diff --git a/include/drm/ttm/ttm_resource.h b/include/drm/ttm/ttm_resource.h
index 3f2812743a7e..7c7fc94b2d39 100644
--- a/include/drm/ttm/ttm_resource.h
+++ b/include/drm/ttm/ttm_resource.h
@@ -68,7 +68,9 @@ enum ttm_lru_item_type {
 	/** @TTM_LRU_RESOURCE: The resource subclass */
 	TTM_LRU_RESOURCE,
 	/** @TTM_LRU_HITCH: The iterator hitch subclass */
-	TTM_LRU_HITCH
+	TTM_LRU_HITCH,
+	/** @TTM_LRU_BULK: The bulk move sublist anchor subclass */
+	TTM_LRU_BULK
 };
 
 /**
@@ -290,23 +292,23 @@ ttm_lru_item_to_res(struct ttm_lru_item *item)
 }
 
 /**
- * struct ttm_lru_bulk_move_pos
+ * struct ttm_lru_bulk_move_pos - bulk move sublist for a domain/priority
  *
- * @first: first res in the bulk move range
- * @last: last res in the bulk move range
- *
- * Range of resources for a lru bulk move.
+ * @marker: LRU list node linked into the manager's LRU list for the
+ * domain/priority of this range. Acts as an anchor from which the LRU
+ * traversal descends into @sublist.
+ * @sublist: List of resources belonging to this bulk move for the
+ * domain/priority. Resources are threaded here via &ttm_resource.lru,
+ * instead of directly on the manager LRU list.
  */
 struct ttm_lru_bulk_move_pos {
-	struct ttm_resource *first;
-	struct ttm_resource *last;
+	struct ttm_lru_item marker;
+	struct list_head sublist;
 };
 
 /**
- * struct ttm_lru_bulk_move
- * @pos: first/last lru entry for resources in the each domain/priority
- * @cursor_list: The list of cursors currently traversing any of
- * the sublists of @pos. Protected by the ttm device's lru_lock.
+ * struct ttm_lru_bulk_move - bulk move state for a set of resources
+ * @pos: sublist anchor and resources for each domain/priority
  *
  * Container for the current bulk move state. Should be used with
  * ttm_lru_bulk_move_init() and ttm_bo_set_bulk_move().
@@ -316,32 +318,29 @@ struct ttm_lru_bulk_move_pos {
  */
 struct ttm_lru_bulk_move {
 	struct ttm_lru_bulk_move_pos pos[TTM_NUM_MEM_TYPES][TTM_MAX_BO_PRIORITY];
-	struct list_head cursor_list;
 };
 
 /**
- * struct ttm_resource_cursor
+ * struct ttm_resource_cursor - iterator over a resource manager's resources
  * @man: The resource manager currently being iterated over
- * @hitch: A hitch list node inserted before the next resource
- * to iterate over.
- * @bulk_link: A list link for the list of cursors traversing the
- * bulk sublist of @bulk. Protected by the ttm device's lru_lock.
- * @bulk: Pointer to struct ttm_lru_bulk_move whose subrange @hitch is
- * inserted to. NULL if none. Never dereference this pointer since
- * the struct ttm_lru_bulk_move object pointed to might have been
- * freed. The pointer is only for comparison.
- * @mem_type: The memory type of the LRU list being traversed.
- * This field is valid iff @bulk != NULL.
+ * @hitch: A hitch list node marking the position in the manager's LRU
+ * list for @priority. While the cursor has descended into a bulk move
+ * sublist, this node stays parked right after the bulk move anchor so
+ * that traversal of the manager LRU list resumes from the correct place
+ * even if the anchor is concurrently moved by a bulk move.
+ * @sublist_hitch: A hitch list node marking the position within a bulk
+ * move sublist that the cursor has descended into. Only threaded into a
+ * list while @cur_list points at a sublist.
+ * @cur_list: The list currently being traversed. Either the manager's
+ * LRU list for @priority, or a bulk move sublist that the cursor has
+ * descended into.
  * @priority: the current priority
- *
- * Cursor to iterate over the resources in a manager.
  */
 struct ttm_resource_cursor {
 	struct ttm_resource_manager *man;
 	struct ttm_lru_item hitch;
-	struct list_head bulk_link;
-	struct ttm_lru_bulk_move *bulk;
-	unsigned int mem_type;
+	struct ttm_lru_item sublist_hitch;
+	struct list_head *cur_list;
 	unsigned int priority;
 };
 
-- 
2.55.0

