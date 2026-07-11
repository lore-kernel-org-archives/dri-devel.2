Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D75C43458
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 02:56:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E85E710E2BF;
	Sat, 11 Jul 2026 02:56:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="J68PVtol";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A13A10E2AA;
 Sat, 11 Jul 2026 02:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783738588; x=1815274588;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7dTegBA0umnkQ7uQ0UHxBoAyFyr/YHp+oMqNMt2QO2E=;
 b=J68PVtol7USSmjcFvBfR9PJU9fZV9ANgCYRAjVOhk0Kgs9xrO05FIm+m
 xphRhoBTC63X3ks8WLsq1YBKVJBb4jAVptTC0xSxpSoeT4J/J1xRY9hzT
 Hoh2+GyrrL9+YgD3ZtL8wtomjT0hlUPuqmXulX+PAoaVnJ0ocQtL0yyXV
 wHgDt7cpNLyLGbZXJjza4a31QlhX1IoqrsbZoXOYpwxUYxG9vmz7fYIva
 qxHHFdP0jRY/oFHUwk6ngUq282/joTolv5PaxQJlA0anO2teecETXFH1I
 RDLSuDbDIn5u2hIrsZWUyqd/qp+wM2DbKtmab/jyabwcjxCpfx0fcwjo9 g==;
X-CSE-ConnectionGUID: /WjpSv7YTR21E5uKqFNMUA==
X-CSE-MsgGUID: xirnv9lVTxS5jL6lhGaSBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="101986231"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="101986231"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 19:56:27 -0700
X-CSE-ConnectionGUID: 8qn2G49QSpKnA20byidsgQ==
X-CSE-MsgGUID: Yl9WxgLnQhSVCg8K7Bxh8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="256987695"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 19:56:26 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: Carlos Santa <carlos.santa@intel.com>, Ryan Neph <ryanneph@google.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Subject: [PATCH v3 07/33] drm/ttm: Harvest beneficial-order pages on
 defragmentation moves
Date: Fri, 10 Jul 2026 19:55:53 -0700
Message-Id: <20260711025619.2540575-8-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260711025619.2540575-1-matthew.brost@intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
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

A defragmentation move relocates a populated tt into a freshly allocated
one so that sub-beneficial-order chunks can be upgraded to the device's
beneficial order. Previously, if allocation could not complete entirely
at beneficial order, the move failed and all progress was discarded.

Instead, once allocation has successfully upgraded part of the object,
the remainder of the old tt is harvested to complete the new tt. Thread
the BO's old, still-populated tt into the page allocator via a new
ttm_operation_ctx::defrag_old_tt. While allocation is still proceeding,
any existing chunk already at (or above) the beneficial order is reused
directly instead of being reallocated. If allocation later has to fall
back below beneficial_order after making partial progress, the remainder
of the old tt is harvested instead of failing the move. This preserves
the beneficial-order upgrades already made while leaving the rest of the
object unchanged, allowing subsequent defragmentation attempts to make
additional forward progress.

Harvesting only borrows the pages; they remain owned by the old tt until
the move commits. This keeps every unwind path non-destructive: if the
(re)allocation or the move later fails, the new tt is torn down without
freeing the borrowed pages and the old tt is restored fully intact.
Ownership of the shared pages is transferred to the new tt only once the
move has committed. ttm_tt_defrag_disown_borrowed() implements both
directions of the transfer by clearing a tt's slots for every page it
shares with the other tt (same struct page at the same index), so that
tt's teardown leaves the shared pages alone and each page is freed
exactly once by its owner:

- on the alloc unwind and the failed-move paths, the new tt disowns the
  borrowed pages, leaving the old tt as the sole owner;
- on the successful-move paths (synchronous teardown and the pipelined
  ghost-object teardown), the old tt disowns the now-transferred pages,
  leaving the new tt as the sole owner.

Detecting shared pages by same-index struct page identity needs no extra
per-tt bookkeeping, since two distinct allocations never alias. This is
safe with drivers, such as Xe, that build their own per-tt sg table and
DMA-map it independently: each tt maps and unmaps its own sg, so sharing
the underlying pages between tts is DMA-clean.

This is a no-op unless ctx->defrag_old_tt is set, which only happens on a
defragmentation move.

Cc: Carlos Santa <carlos.santa@intel.com>
Cc: Ryan Neph <ryanneph@google.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Assisted-by: GitHub_Copilot:claude-opus-4.8
Signed-off-by: Matthew Brost <matthew.brost@intel.com>

---

v3:
 - Document the chunk-head invariant read by
   ttm_pool_harvest_remaining() (Sashiko)
---
 drivers/gpu/drm/ttm/ttm_bo.c      |  20 ++-
 drivers/gpu/drm/ttm/ttm_bo_util.c |   5 +
 drivers/gpu/drm/ttm/ttm_pool.c    | 235 ++++++++++++++++++++++++++++--
 drivers/gpu/drm/ttm/ttm_tt.c      |  67 +++++++++
 include/drm/ttm/ttm_bo.h          |  12 ++
 include/drm/ttm/ttm_tt.h          |   2 +
 6 files changed, 328 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index c1629b4c4f0f..ab2e637a017f 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -182,7 +182,14 @@ static int ttm_bo_handle_move_mem(struct ttm_buffer_object *bo,
 		}
 
 		if (defrag_old_tt || mem->mem_type != TTM_PL_SYSTEM) {
+			/*
+			 * Let the page allocator harvest already
+			 * beneficial-order chunks out of the old tt to back
+			 * the new one, rather than reallocating them.
+			 */
+			ctx->defrag_old_tt = defrag_old_tt;
 			ret = ttm_bo_populate(bo, ctx);
+			ctx->defrag_old_tt = NULL;
 			if (ret) {
 				/*
 				 * Discharge the freshly allocated backing and
@@ -235,6 +242,12 @@ static int ttm_bo_handle_move_mem(struct ttm_buffer_object *bo,
 	}
 
 	if (bo->defrag_old_tt) {
+		/*
+		 * Successful defrag move: any pages the new tt borrowed from the
+		 * old tt are now owned by the new tt. Disown them from the old
+		 * tt before it is torn down so they are not freed.
+		 */
+		ttm_tt_defrag_disown_borrowed(bo->defrag_old_tt, bo->ttm);
 		ttm_tt_unpopulate(bo->bdev, bo->defrag_old_tt);
 		ttm_tt_destroy(bo->bdev, bo->defrag_old_tt);
 		bo->defrag_old_tt = NULL;
@@ -245,7 +258,12 @@ static int ttm_bo_handle_move_mem(struct ttm_buffer_object *bo,
 
 out_err:
 	if (bo->defrag_old_tt) {
-		/* Failed defrag move: restore the original backing. */
+		/*
+		 * Failed defrag move: drop any pages the new tt borrowed from
+		 * the old tt (still owned by the old tt) before destroying the
+		 * new tt, then restore the original backing.
+		 */
+		ttm_tt_defrag_disown_borrowed(bo->ttm, bo->defrag_old_tt);
 		ttm_bo_tt_destroy(bo);
 		bo->ttm = bo->defrag_old_tt;
 		bo->defrag_old_tt = NULL;
diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
index 771313162c8d..7cb718fc97c0 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_util.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
@@ -633,7 +633,12 @@ static int ttm_bo_move_to_ghost(struct ttm_buffer_object *bo,
 		 * tt (the move's source) to the ghost so it is kept populated
 		 * until @fence signals and then unbound and destroyed, instead
 		 * of being torn down synchronously. @bo keeps its new tt.
+		 *
+		 * Any pages the new tt borrowed from the old tt are now owned by
+		 * the new tt; disown them from the old tt so the ghost teardown
+		 * leaves them alone.
 		 */
+		ttm_tt_defrag_disown_borrowed(bo->defrag_old_tt, bo->ttm);
 		ghost_obj->ttm = bo->defrag_old_tt;
 		ghost_obj->defrag_old_tt = NULL;
 		bo->defrag_old_tt = NULL;
diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 2598d2f33767..52f5e64f05dd 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -792,6 +792,148 @@ static unsigned int ttm_pool_alloc_find_order(unsigned int highest,
 	return min_t(unsigned int, highest, __fls(alloc->remaining_pages));
 }
 
+/*
+ * Defragmentation page harvesting.
+ *
+ * A defrag move relocates a populated tt into a freshly allocated one in order
+ * to upgrade sub-beneficial-order chunks to the device's beneficial order.
+ * Chunks in the old tt (ctx->defrag_old_tt) that are ALREADY at the beneficial
+ * order do not need to be reallocated: their physical pages can simply be
+ * transferred ("harvested") into the new tt at the same offset, avoiding the
+ * alloc/free churn that is significant for large buffers.
+ *
+ * Harvesting only borrows the pages: the new tt simply references the old tt's
+ * pages, which remain owned by the old tt. This keeps the unwind paths simple -
+ * if the (re)allocation or the move later fails, the new tt is torn down without
+ * freeing the borrowed pages and the old tt is restored fully intact. Ownership
+ * of the shared pages is transferred to the new tt only once the move has
+ * committed, via ttm_tt_defrag_disown_borrowed() (see ttm_tt.c).
+ */
+
+/*
+ * Return the allocation order of the old tt chunk whose head sits at @off, or 0
+ * if @off is not an old chunk head (it falls inside a chunk, or the slot is
+ * empty / backed up). @cursor monotonically tracks the old chunk boundary and
+ * must be advanced past every offset that has already been queried; a page
+ * order may only be read from a chunk head page, hence the lazy walk.
+ */
+static unsigned int ttm_pool_defrag_old_order(struct ttm_pool *pool,
+					      struct ttm_tt *old_tt,
+					      pgoff_t off, pgoff_t *cursor)
+{
+	struct page *p;
+
+	while (*cursor < off) {
+		p = old_tt->pages[*cursor];
+		if (!p || ttm_backup_page_ptr_is_handle(p))
+			return 0;
+		*cursor += 1UL << ttm_pool_page_order(pool, p);
+	}
+
+	if (*cursor != off)
+		return 0;
+
+	p = old_tt->pages[off];
+	if (!p || ttm_backup_page_ptr_is_handle(p))
+		return 0;
+
+	return ttm_pool_page_order(pool, p);
+}
+
+/*
+ * Borrow an already beneficial-order chunk from the old tt into @alloc. The
+ * pages stay owned by the old tt until the move commits.
+ */
+static int ttm_pool_harvest_page(struct ttm_tt *old_tt, unsigned int order,
+				 pgoff_t off, struct ttm_pool_alloc_state *alloc)
+{
+	pgoff_t nr = 1UL << order;
+	int r;
+
+	/*
+	 * A harvested chunk keeps the (same) bo's caching, so the deferred
+	 * caching range is consistent here; flush it before committing, exactly
+	 * like the caching-consistent path in ttm_pool_page_allocated().
+	 */
+	r = ttm_pool_apply_caching(alloc);
+	if (r)
+		return r;
+
+	/*
+	 * The borrowed chunk's page pointers (consecutive struct pages of one
+	 * compound allocation) and dma addresses already sit contiguously in
+	 * the old tt at @off. Copy the whole run with memcpy() instead of the
+	 * per-page increment loop in ttm_pool_allocated_page_commit(): for a
+	 * large defrag the borrowed pages dominate the new tt, so this turns
+	 * the populate fill from O(num_pages) individual stores into a handful
+	 * of bulk copies.
+	 */
+	memcpy(alloc->pages, &old_tt->pages[off], nr * sizeof(*alloc->pages));
+	alloc->pages += nr;
+	alloc->remaining_pages -= nr;
+
+	if (alloc->dma_addr) {
+		memcpy(alloc->dma_addr, &old_tt->dma_address[off],
+		       nr * sizeof(*alloc->dma_addr));
+		alloc->dma_addr += nr;
+	}
+
+	alloc->caching_divide = alloc->pages;
+
+	return 0;
+}
+
+static int ttm_pool_harvest_remaining(struct ttm_pool *pool,
+				      struct ttm_tt *old_tt, pgoff_t off,
+				      struct ttm_pool_alloc_state *alloc)
+{
+	/*
+	 * @off is always an old-tt chunk head here, never a tail page, so
+	 * reading the per-chunk order below is safe. This holds because:
+	 *  - Old chunks are self-aligned: greedy largest-power-of-two fill
+	 *    places an order-k chunk at a 2^k-aligned offset, so any
+	 *    beneficial-order-aligned offset is a chunk boundary.
+	 *  - Fresh defrag allocations are capped at the beneficial order (see
+	 *    ttm_pool_iter_acquire_page()), so they advance @off in beneficial
+	 *    steps and never overshoot into the middle of a larger old chunk;
+	 *    super-beneficial old chunks are always harvested whole by
+	 *    ttm_pool_iter_reuse_old().
+	 *  - We are only reached once the defrag budget/prealloc is exhausted,
+	 *    which in the capped/prealloc config leaves @off beneficial-aligned
+	 *    (or, in the sub-beneficial tail, already walking old boundaries).
+	 */
+	while (alloc->remaining_pages) {
+		struct page *p = old_tt->pages[off];
+		unsigned int order = ttm_pool_page_order(pool, p);
+		pgoff_t nr = 1UL << order;
+		int r;
+
+		r = ttm_pool_harvest_page(old_tt, order, off, alloc);
+		if (r)
+			return r;
+
+		off += nr;
+	}
+
+	return 0;
+}
+
+/**
+ * enum ttm_pool_iter_action - Outcome of a per-order allocation phase
+ * @TTM_POOL_ITER_FILL: A page (@it->p) was acquired; proceed to fill it in.
+ * @TTM_POOL_ITER_RETRY: Loop state was adjusted (e.g. order lowered or a chunk
+ *	harvested); re-enter the loop body for the next order.
+ * @TTM_POOL_ITER_STOP: The allocation is complete; stop the loop.
+ *
+ * Phase helpers return one of these (>= 0) on success, or a negative errno on
+ * failure (the caller then unwinds via error_free_all).
+ */
+enum ttm_pool_iter_action {
+	TTM_POOL_ITER_FILL,
+	TTM_POOL_ITER_RETRY,
+	TTM_POOL_ITER_STOP,
+};
+
 /**
  * struct ttm_pool_alloc_iter - Working state for the __ttm_pool_alloc() loop
  *
@@ -806,6 +948,7 @@ struct ttm_pool_alloc_iter {
 	const struct ttm_operation_ctx *ctx;
 	struct ttm_pool_alloc_state *alloc;
 	struct ttm_pool_tt_restore *restore;
+	struct ttm_tt *defrag_old_tt;
 	unsigned int beneficial_order;
 	gfp_t gfp_flags;
 
@@ -814,9 +957,50 @@ struct ttm_pool_alloc_iter {
 	enum ttm_caching page_caching;
 	bool allow_pools;
 	bool fail_beneficial;
+	unsigned int alloc_count;
+	pgoff_t old_cursor;
 	struct page *p;
 };
 
+/*
+ * Defrag move: reuse an already beneficial-order chunk from the old tt at this
+ * offset rather than reallocating it. Harvest whatever order the old chunk has
+ * (>= beneficial order), which may exceed the order the new tt would otherwise
+ * pick. An order below beneficial_order is only reused for the unaligned tail
+ * (where there is no benefit to reallocating). Only borrows the pages; the alloc
+ * unwind path can drop them again.
+ *
+ * Returns TTM_POOL_ITER_RETRY when a chunk was harvested, TTM_POOL_ITER_FILL to
+ * fall through to a fresh allocation, or a negative errno.
+ */
+static int ttm_pool_iter_reuse_old(struct ttm_pool_alloc_iter *it)
+{
+	unsigned int harvest_order;
+	pgoff_t off;
+	int r;
+
+	if (!it->defrag_old_tt || !it->beneficial_order)
+		return TTM_POOL_ITER_FILL;
+
+	off = it->tt->num_pages - it->alloc->remaining_pages;
+	harvest_order = ttm_pool_defrag_old_order(it->pool, it->defrag_old_tt,
+						  off, &it->old_cursor);
+
+	if (harvest_order < it->beneficial_order &&
+	    it->order >= it->beneficial_order)
+		return TTM_POOL_ITER_FILL;
+
+	it->order = harvest_order;
+	r = ttm_pool_harvest_page(it->defrag_old_tt, it->order, off, it->alloc);
+	if (r)
+		return r;
+
+	it->page_caching = it->tt->caching;
+	it->allow_pools = true;
+
+	return TTM_POOL_ITER_RETRY;
+}
+
 /*
  * Acquire a single page for the current order, leaving it in @it->p (NULL on
  * failure). Tries a same-order pool page, then a fresh system allocation. Fault
@@ -859,9 +1043,10 @@ static void ttm_pool_iter_acquire_page(struct ttm_pool_alloc_iter *it)
 /*
  * The current order could not be satisfied. Lower it and retry, recording a
  * sub-optimal backing (so the driver can later re-defrag) when we drop below
- * the beneficial order.
+ * the beneficial order. For a defrag move that has already made partial
+ * progress, harvest the remaining old pages and stop instead.
  *
- * Returns 0 to retry the (lowered) order, or a negative errno.
+ * Returns TTM_POOL_ITER_RETRY, TTM_POOL_ITER_STOP, or a negative errno.
  */
 static int ttm_pool_iter_lower_order(struct ttm_pool_alloc_iter *it)
 {
@@ -871,16 +1056,24 @@ static int ttm_pool_iter_lower_order(struct ttm_pool_alloc_iter *it)
 	if (!it->order)
 		return -ENOMEM;
 
-	/*
-	 * Failing to allocate at the device's beneficial order means we are
-	 * about to back this object with a sub-optimal (smaller order) set of
-	 * pages. Record it so the driver can later try to defragment the object
-	 * back to beneficial order.
-	 */
 	if (it->fail_beneficial || at_beneficial) {
 		it->tt->page_flags |= TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED;
-		if (it->ctx->defrag)
+
+		if (it->alloc_count && it->defrag_old_tt) {
+			pgoff_t off = it->tt->num_pages -
+				      it->alloc->remaining_pages;
+			int r;
+
+			r = ttm_pool_harvest_remaining(it->pool,
+						       it->defrag_old_tt, off,
+						       it->alloc);
+			if (r)
+				return r;
+
+			return TTM_POOL_ITER_STOP;
+		} else if (it->defrag_old_tt) {
 			return -ENOMEM;
+		}
 	}
 
 	if (it->fail_beneficial)
@@ -890,7 +1083,7 @@ static int ttm_pool_iter_lower_order(struct ttm_pool_alloc_iter *it)
 	it->page_caching = it->tt->caching;
 	it->allow_pools = true;
 
-	return 0;
+	return TTM_POOL_ITER_RETRY;
 }
 
 static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
@@ -904,6 +1097,7 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 		.ctx = ctx,
 		.alloc = alloc,
 		.restore = restore,
+		.defrag_old_tt = restore ? NULL : ctx->defrag_old_tt,
 		.beneficial_order = ttm_pool_beneficial_order(pool),
 		.page_caching = tt->caching,
 		.allow_pools = true,
@@ -931,13 +1125,22 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 	for (it.order = ttm_pool_alloc_find_order(MAX_PAGE_ORDER, alloc);
 	     alloc->remaining_pages;
 	     it.order = ttm_pool_alloc_find_order(it.order, alloc)) {
+		/* Reuse an already beneficial-order chunk from the old tt. */
+		r = ttm_pool_iter_reuse_old(&it);
+		if (r < 0)
+			goto error_free_all;
+		if (r == TTM_POOL_ITER_RETRY)
+			continue;
+
 		/* Acquire a page (pool / system) for this order. */
 		ttm_pool_iter_acquire_page(&it);
 		if (!it.p) {
 			r = ttm_pool_iter_lower_order(&it);
-			if (r)
+			if (r < 0)
 				goto error_free_all;
-			continue;
+			if (r == TTM_POOL_ITER_RETRY)
+				continue;
+			break;	/* TTM_POOL_ITER_STOP */
 		}
 
 		r = ttm_pool_page_allocated(pool, it.order, it.p,
@@ -951,6 +1154,8 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 			if (r)
 				goto error_free_all;
 		}
+
+		it.alloc_count++;
 	}
 
 	r = ttm_pool_apply_caching(alloc);
@@ -969,6 +1174,12 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 	if (tt->restore)
 		return r;
 
+	/*
+	 * Drop any pages borrowed from the old tt during a defrag move: they are
+	 * still owned by the old tt and must not be freed here.
+	 */
+	ttm_tt_defrag_disown_borrowed(tt, it.defrag_old_tt);
+
 	caching_divide = alloc->caching_divide - tt->pages;
 	ttm_pool_free_range(pool, tt, tt->caching, 0, caching_divide);
 	ttm_pool_free_range(pool, tt, ttm_cached, caching_divide,
diff --git a/drivers/gpu/drm/ttm/ttm_tt.c b/drivers/gpu/drm/ttm/ttm_tt.c
index b645a1818184..2388ff794a59 100644
--- a/drivers/gpu/drm/ttm/ttm_tt.c
+++ b/drivers/gpu/drm/ttm/ttm_tt.c
@@ -450,6 +450,73 @@ void ttm_tt_unpopulate(struct ttm_device *bdev, struct ttm_tt *ttm)
 }
 EXPORT_SYMBOL_FOR_TESTS_ONLY(ttm_tt_unpopulate);
 
+/**
+ * ttm_tt_defrag_disown_borrowed() - Drop borrowed defrag pages from a tt
+ * @tt: The tt to drop the borrowed page references from.
+ * @src: The tt the pages may have been harvested from, or NULL.
+ *
+ * During a defragmentation move the freshly (re)allocated tt may harvest
+ * already beneficial-order chunks from the BO's old tt, sharing the underlying
+ * pages instead of reallocating them. Until the move commits these pages stay
+ * owned by the old tt. Clearing a tt's slots for every page it shares with
+ * @src (the same struct page at the same index) makes that tt's teardown leave
+ * the shared pages alone, so they are freed exactly once by their owner.
+ *
+ * This is used both to unwind a failed defrag move (disown the borrowed pages
+ * from the new tt, leaving the old tt intact) and to commit a successful one
+ * (disown the now-transferred pages from the old tt, leaving them owned by the
+ * new tt).
+ */
+void ttm_tt_defrag_disown_borrowed(struct ttm_tt *tt, const struct ttm_tt *src)
+{
+	pgoff_t i = 0, run_start = 0;
+	bool in_run = false;
+
+	if (!tt || !src)
+		return;
+
+	/*
+	 * Borrowing happens at chunk granularity: a borrowed chunk shares the
+	 * same struct page on both tts across its whole allocation order, while
+	 * a non-borrowed chunk differs across its whole order. Stride by @src's
+	 * chunk order instead of walking every page, coalescing the borrowed
+	 * (matching) chunks into runs and clearing each run with a single
+	 * memset rather than a per-page store. @src is a fully populated,
+	 * non-dma_alloc tt (the defrag path), so its page order is recorded in
+	 * page->private and read via ttm_pool_page_order_nodma().
+	 */
+	while (i < tt->num_pages) {
+		struct page *sp = src->pages[i];
+		unsigned int order = sp ? ttm_pool_page_order_nodma(sp) : 0;
+		pgoff_t nr = 1UL << order;
+
+		if (sp && tt->pages[i] == sp) {
+			if (!in_run) {
+				run_start = i;
+				in_run = true;
+			}
+		} else if (in_run) {
+			memset(&tt->pages[run_start], 0,
+			       (i - run_start) * sizeof(*tt->pages));
+			if (tt->dma_address)
+				memset(&tt->dma_address[run_start], 0,
+				       (i - run_start) *
+				       sizeof(*tt->dma_address));
+			in_run = false;
+		}
+
+		i += nr;
+	}
+
+	if (in_run) {
+		memset(&tt->pages[run_start], 0,
+		       (i - run_start) * sizeof(*tt->pages));
+		if (tt->dma_address)
+			memset(&tt->dma_address[run_start], 0,
+			       (i - run_start) * sizeof(*tt->dma_address));
+	}
+}
+
 #ifdef CONFIG_DEBUG_FS
 
 /* Test the shrinker functions and dump the result */
diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
index f4f8a8c29f04..fcaba5fb8bf7 100644
--- a/include/drm/ttm/ttm_bo.h
+++ b/include/drm/ttm/ttm_bo.h
@@ -211,6 +211,18 @@ struct ttm_operation_ctx {
 	 * order.
 	 */
 	bool defrag;
+	/**
+	 * @defrag_old_tt: During a defragmentation move, the bo's existing
+	 * (populated) tt that is being relocated. The page allocator may
+	 * harvest already beneficial-order chunks from this tt to back the new
+	 * tt instead of reallocating them, avoiding alloc/free churn for large
+	 * buffers. Harvested pages are only borrowed: they stay owned by
+	 * @defrag_old_tt until the move commits, at which point
+	 * ttm_tt_defrag_disown_borrowed() clears the old tt's slots for the
+	 * transferred pages so they are not freed when the old tt is torn down.
+	 * NULL for non-defrag operations.
+	 */
+	struct ttm_tt *defrag_old_tt;
 	/**
 	 * @resv: Reservation object to be used together with
 	 * @allow_res_evict.
diff --git a/include/drm/ttm/ttm_tt.h b/include/drm/ttm/ttm_tt.h
index ce7533677d77..55c35bcf134d 100644
--- a/include/drm/ttm/ttm_tt.h
+++ b/include/drm/ttm/ttm_tt.h
@@ -284,6 +284,8 @@ int ttm_tt_populate(struct ttm_device *bdev, struct ttm_tt *ttm,
  */
 void ttm_tt_unpopulate(struct ttm_device *bdev, struct ttm_tt *ttm);
 
+void ttm_tt_defrag_disown_borrowed(struct ttm_tt *tt, const struct ttm_tt *src);
+
 /**
  * ttm_tt_mark_for_clear - Mark pages for clearing on populate.
  *
-- 
2.34.1

