Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F44C43458
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 02:56:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D14AE10E668;
	Sat, 11 Jul 2026 02:56:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="EQuuBZcP";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FA0E10E2B3;
 Sat, 11 Jul 2026 02:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783738588; x=1815274588;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=84SW4uI3+3bSrznqgS0H94wyptYIKGC2JI+0Xwv53yI=;
 b=EQuuBZcPtKdBFZxXBqCRY1q7wR9wzpm5FKNgVvH14tuFhD53E0POAIFy
 oBfb1idEnWZt9E8Eh75bCNPcXSsmEaocxSxIT1464yPTWCNF284J5n9/3
 hxg7tzXM3QmJkoHSFq/g/zcxGHwy4C44PCRvHkNuONeXhiLnLWHc8/NQR
 aP7KOscLITPuZuNvnxY0Yhf2eEuJ1Q3WSktuQzo+jVoozyPSa26oNIXP8
 5dSurE3JIZY9gHKgnFGgZJadqM5/7pcOuDuJhkjSVBkIiHipoHInF/MjD
 MQlMXyYoLccjo8Rai3Jxk+255VBIXw7M+Kvkzl9Ka7uunN3KXJhtoQx9h A==;
X-CSE-ConnectionGUID: qsjF+gl1SHK0a8gVyS9DtQ==
X-CSE-MsgGUID: 4lDO8/RiQQS5IWawW5jsbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="101986255"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="101986255"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 19:56:28 -0700
X-CSE-ConnectionGUID: TA0TysiyQ/+zzYkE/ZmqVQ==
X-CSE-MsgGUID: nELz19w4Rh6uBy82uXjj0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="256987709"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 19:56:27 -0700
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
Subject: [PATCH v3 10/33] drm/ttm: Add full out-of-lock preallocation for
 ttm_pool_alloc()
Date: Fri, 10 Jul 2026 19:55:56 -0700
Message-Id: <20260711025619.2540575-11-matthew.brost@intel.com>
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

ttm_pool_prealloc_fill() lets a driver preallocate beneficial-order pages
outside the dma-resv lock for a defragmentation move, so the high-order
allocations that may stall in reclaim/compaction happen off the critical
section.  That bag is deliberately partial: it holds only interchangeable
beneficial-order chunks and the allocator consumes it opportunistically,
falling back to in-line allocation for everything else.

An ordinary populate of a system-memory buffer object has the same
problem - the whole backing is allocated under the dma-resv lock - but no
way to move it out of the critical section, because the existing bag does
not cover sub-beneficial orders and does not describe a full tt.

Add a "full" flavour of the same preallocation mechanism:

  - struct ttm_pool_prealloc gains a @full flag.  In full mode the bag is
    an ordered tiling of an entire tt at mixed orders (pool pages
    included), rather than a set of interchangeable beneficial-order
    chunks.  The per-chunk order is recorded on the page itself and read
    back at consume time, so no parallel order array is needed.

  - ttm_pool_prealloc_fill_full() allocates the whole backing for a tt of
    @num_pages pages up front, mirroring the in-line allocator's order
    walk (highest order first, capped by the remaining page count).  It
    reuses the existing unlocked helpers (ttm_pool_prealloc_gfp(),
    ttm_pool_set_caching()) via a new ttm_pool_take_page() helper that
    tries a same-order pool page before a fresh system allocation.

  - ttm_pool_prealloc_fini() frees any unconsumed tail at each chunk's own
    order when @full.

  - ttm_pool_prealloc_fill_full() takes a @beneficial_reclaim_backoff
    argument, plumbed to ttm_pool_alloc_page(), that lets the caller
    allocate higher-order chunks without aggressive reclaim/compaction.
    This suits a driver that upgrades suboptimal pages to beneficial order
    in place later (e.g. via a background defragmenter) and so has no need
    to stall the user context reclaiming for contiguity up front.

  - __ttm_pool_alloc() consumes a full bag with a single early branch in
    ttm_pool_iter_acquire_page(): install the next chunk as-is (order
    taken from the page) and return; once the best-effort bag is drained
    the loop falls through to normal in-line allocation.  The defrag
    harvest and reuse-old phases are inert here as there is no
    defrag_old_tt.

Like the defrag bag, this is best-effort: a short fill is fine (the pool
allocates the shortfall in-line) and DMA-alloc pools are unsupported
(caching is applied on the kernel mapping).  No functional change for
existing users; the new fill routine has no in-tree caller yet.

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
 drivers/gpu/drm/ttm/ttm_pool.c | 232 ++++++++++++++++++++++++++++++++-
 include/drm/ttm/ttm_bo.h       |  19 +--
 include/drm/ttm/ttm_pool.h     |  27 +++-
 3 files changed, 258 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index da7d132c8297..4746f5d8cd7e 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -1046,6 +1046,7 @@ int ttm_pool_prealloc_fill(struct ttm_pool *pool, enum ttm_caching tt_caching,
 	pp->caching = tt_caching;
 	pp->count = 0;
 	pp->used = 0;
+	pp->full = false;
 
 	/* Nothing to gain without a beneficial order or for DMA-alloc pools. */
 	if (!order || !count || ttm_pool_uses_dma_alloc(pool))
@@ -1102,6 +1103,187 @@ int ttm_pool_prealloc_fill(struct ttm_pool *pool, enum ttm_caching tt_caching,
 }
 EXPORT_SYMBOL(ttm_pool_prealloc_fill);
 
+/*
+ * Acquire a single *@order chunk, trying a same-order pool page first (already
+ * carries @caching) then a fresh system allocation (write-back). Runs unlocked.
+ * When @beneficial_reclaim_backoff is set, higher-order system allocations skip
+ * aggressive reclaim/compaction (see ttm_pool_alloc_page()).
+ *
+ * A fresh system page is write-back and needs the tt's caching applied later in
+ * bulk; *@need_caching is set true for it and false for a (pre-cached) pool
+ * page.
+ *
+ * On a genuine failure *@order is left untouched (the caller lowers it by one
+ * and retries). Fault injection instead pretends allocation at (or above) the
+ * beneficial order failed and lowers *@order to the beneficial order, so the
+ * caller's next attempt lands below it - mirroring the in-line acquire path's
+ * fail_beneficial jump and exercising the beneficial_order_failed tracking
+ * without driving the system into real fragmentation.
+ *
+ * Returns NULL if no page of *@order could be obtained.
+ */
+static struct page *ttm_pool_take_page(struct ttm_pool *pool,
+				       enum ttm_caching caching,
+				       unsigned int *order, gfp_t gfp,
+				       bool *need_caching,
+				       bool beneficial_reclaim_backoff)
+{
+	unsigned int beneficial = ttm_pool_beneficial_order(pool);
+	struct ttm_pool_type *pt;
+	struct page *p;
+
+	*need_caching = false;
+
+	if (IS_ENABLED(CONFIG_FAULT_INJECTION) && beneficial &&
+	    *order >= beneficial &&
+	    should_fail(&beneficial_order_fault_inject, 1)) {
+		*order = beneficial;
+		return NULL;
+	}
+
+	pt = ttm_pool_select_type(pool, caching, *order);
+	if (pt) {
+		p = ttm_pool_type_take(pt, ttm_pool_nid(pool));
+		if (p)
+			return p;	/* pool page already carries @caching */
+	}
+
+	p = ttm_pool_alloc_page(pool, gfp, *order, beneficial_reclaim_backoff);
+	if (!p)
+		return NULL;
+
+	/* Fresh system page is write-back; caller applies @caching in bulk. */
+	*need_caching = true;
+	return p;
+}
+
+/**
+ * ttm_pool_prealloc_fill_full() - Preallocate a whole tt's backing outside any
+ * lock
+ * @pool: The pool to allocate from.
+ * @tt_caching: The requested cpu-caching for the pages allocated.
+ * @pp: Prealloc bag to fill; marked @full and tiled with mixed-order chunks.
+ * @num_pages: Number of 4K pages the tt needs backed.
+ *
+ * Unlike ttm_pool_prealloc_fill() (which parks a bag of interchangeable
+ * beneficial-order defrag chunks), this allocates the ENTIRE backing for a tt
+ * of @num_pages pages up front, at whatever mix of orders is available (pool
+ * pages included), so that the subsequent __ttm_pool_alloc() under the dma-resv
+ * lock merely installs the pages without stalling in reclaim/compaction. The
+ * chunk orders mirror the in-line allocator's order walk; each chunk's order is
+ * recorded on the page itself and read back at consume time.
+ *
+ * May sleep/reclaim freely as it runs unlocked. When
+ * @beneficial_reclaim_backoff is set, higher-order chunks are taken without
+ * aggressive reclaim/compaction: the caller relies on a background
+ * defragmenter to upgrade to beneficial-order pages in place later, so there
+ * is no need to stall the user context reclaiming for contiguity here. A short
+ * fill is fine: the pool falls back to in-line allocation for the shortfall.
+ * DMA-alloc pools are not supported (the bag stays empty). Returns 0 (release
+ * with ttm_pool_prealloc_fini()).
+ */
+int ttm_pool_prealloc_fill_full(struct ttm_pool *pool,
+				enum ttm_caching tt_caching,
+				struct ttm_pool_prealloc *pp,
+				unsigned int num_pages,
+				bool beneficial_reclaim_backoff)
+{
+	gfp_t gfp = ttm_pool_prealloc_gfp(pool) | __GFP_ZERO |
+		__GFP_RETRY_MAYFAIL | __GFP_NOWARN;
+	unsigned int highest = MAX_PAGE_ORDER;
+	unsigned int remaining = num_pages;
+	struct page **cpages = NULL;
+	unsigned int ncpages = 0;
+	int r;
+
+	pp->pages = NULL;
+	pp->order = 0;
+	pp->caching = tt_caching;
+	pp->count = 0;
+	pp->used = 0;
+	pp->full = true;
+
+	/* Caching is applied on the kernel mapping, so DMA-alloc is unsupported. */
+	if (!num_pages || ttm_pool_uses_dma_alloc(pool))
+		return 0;
+
+	/* Worst case is one order-0 chunk per page. */
+	pp->pages = kvzalloc_objs(*pp->pages, num_pages);
+	if (!pp->pages)
+		return 0;
+
+	/*
+	 * Fresh write-back chunks get their caching changed in a single
+	 * set_pages_array_*() after the fill; collect their constituent pages
+	 * into an unpacked scratch array (one entry per 4K page) since the
+	 * packed bag holds mixed-order chunks. Cached tts and pool pages need
+	 * no change (and non-x86 handles caching at map time).
+	 */
+	if (IS_ENABLED(CONFIG_X86) && tt_caching != ttm_cached) {
+		cpages = kvzalloc_objs(*cpages, num_pages);
+		if (!cpages) {
+			kvfree(pp->pages);
+			pp->pages = NULL;
+			return 0;
+		}
+	}
+
+	while (remaining) {
+		unsigned int order = min_t(unsigned int, highest,
+					   __fls(remaining));
+		bool need_caching;
+		struct page *p;
+
+		for (;;) {
+			p = ttm_pool_take_page(pool, tt_caching, &order, gfp,
+					       &need_caching,
+					       beneficial_reclaim_backoff);
+			if (p)
+				break;
+			if (!order)
+				goto apply_caching;	/* short fill */
+			/*
+			 * Genuine failure: retry one order down. A fault
+			 * injection lowered @order to the beneficial order
+			 * above, so this drops it below - landing on a
+			 * sub-optimal (defrag-worthy) chunk.
+			 */
+			order--;
+		}
+
+		pp->pages[pp->count++] = p;
+		if (cpages && need_caching)
+			ttm_pool_prealloc_stage_caching(cpages, &ncpages, p,
+							order);
+		remaining -= 1u << order;
+		highest = order;
+	}
+
+apply_caching:
+	/*
+	 * Apply the requested caching to every collected page in one shot. On
+	 * failure the pages' caching is indeterminate, so drop the whole bag
+	 * (freeing restores write-back) and let the consumer allocate in-line.
+	 */
+	r = ttm_pool_prealloc_apply_caching(tt_caching, cpages, ncpages);
+	kvfree(cpages);
+	if (r) {
+		unsigned int i;
+
+		for (i = 0; i < pp->count; i++) {
+			struct page *p = pp->pages[i];
+
+			ttm_pool_free_page(pool, tt_caching,
+					   ttm_pool_page_order_nodma(p), p,
+					   false);
+		}
+		pp->count = 0;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(ttm_pool_prealloc_fill_full);
+
 /**
  * ttm_pool_prealloc_fini() - Release unconsumed preallocated pages
  * @pool: The pool the pages came from.
@@ -1111,9 +1293,13 @@ void ttm_pool_prealloc_fini(struct ttm_pool *pool, struct ttm_pool_prealloc *pp)
 {
 	unsigned int i;
 
-	for (i = pp->used; i < pp->count; ++i)
-		ttm_pool_free_page(pool, pp->caching, pp->order, pp->pages[i],
-				   false);
+	for (i = pp->used; i < pp->count; ++i) {
+		struct page *p = pp->pages[i];
+		unsigned int order = pp->full ?
+			ttm_pool_page_order_nodma(p) : pp->order;
+
+		ttm_pool_free_page(pool, pp->caching, order, p, false);
+	}
 	kvfree(pp->pages);
 	pp->pages = NULL;
 	pp->count = 0;
@@ -1251,9 +1437,10 @@ static int ttm_pool_iter_reuse_old(struct ttm_pool_alloc_iter *it)
 
 /*
  * Acquire a single page for the current order, leaving it in @it->p (NULL on
- * failure). Tries, in order: a beneficial-order page preallocated outside the
- * dma-resv lock (defrag), a same-order pool page, then a fresh system
- * allocation. Fault injection can force the beneficial-order paths to "fail".
+ * failure). Tries, in order: a chunk from a full out-of-lock prealloc (populate
+ * of the whole tt), a beneficial-order page preallocated outside the dma-resv
+ * lock (defrag), a same-order pool page, then a fresh system allocation. Fault
+ * injection can force the beneficial-order paths to "fail".
  */
 static void ttm_pool_iter_acquire_page(struct ttm_pool_alloc_iter *it)
 {
@@ -1262,6 +1449,39 @@ static void ttm_pool_iter_acquire_page(struct ttm_pool_alloc_iter *it)
 
 	it->p = NULL;
 
+	/*
+	 * Full prealloc: the entire backing was allocated (pool + system, at
+	 * mixed orders) outside the dma-resv lock. Install the next chunk as-is,
+	 * taking its order from the page. Falls through to in-line allocation
+	 * once the best-effort bag is drained.
+	 */
+	if (pp && pp->full && pp->used < pp->count) {
+		it->fail_beneficial = false;
+		it->p = pp->pages[pp->used++];
+		it->order = ttm_pool_page_order_nodma(it->p);
+		it->page_caching = it->tt->caching;
+
+		/*
+		 * The full prealloc tiles at whatever orders were available
+		 * without stalling in reclaim. A sub-beneficial chunk only
+		 * means a sub-optimal backing (defrag-worthy) when it sits in a
+		 * beneficial-order aligned region that fully fits in the tt -
+		 * that region could have been a beneficial-order page. A low
+		 * order in the unaligned trailing tail is expected and must not
+		 * flag the tt (mirrors ttm_pool_harvest_remaining()).
+		 */
+		if (it->beneficial_order && it->order < it->beneficial_order) {
+			pgoff_t bnr = 1UL << it->beneficial_order;
+			pgoff_t off = it->tt->num_pages -
+				      it->alloc->remaining_pages;
+
+			if (round_down(off, bnr) + bnr <= it->tt->num_pages)
+				it->tt->page_flags |=
+					TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED;
+		}
+		return;
+	}
+
 	/*
 	 * Fault injection: pretend allocation at (or above) the device's
 	 * beneficial order failed, forcing a sub-optimal backing. Exercises the
diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
index a80304f179ba..52ec7e5c0d2d 100644
--- a/include/drm/ttm/ttm_bo.h
+++ b/include/drm/ttm/ttm_bo.h
@@ -238,14 +238,17 @@ struct ttm_operation_ctx {
 	 */
 	s64 defrag_bytes_remaining;
 	/**
-	 * @prealloc: Pages preallocated outside the dma-resv lock for a defrag
-	 * move. The pool allocator consumes these instead of allocating fresh
-	 * beneficial-order pages under the lock, moving the (potentially
-	 * reclaim/compaction stalling) high-order allocations out of the
-	 * critical section. NULL means allocate in-line as usual. The pool
-	 * silently falls back to in-line allocation for any shortfall. The
-	 * allocator consumes it for beneficial-order chunks of any populate;
-	 * drivers only set it for a defrag move.
+	 * @prealloc: Pages preallocated outside the dma-resv lock. The pool
+	 * allocator consumes these instead of allocating under the lock, moving
+	 * the (potentially reclaim/compaction stalling) allocations out of the
+	 * critical section. NULL means allocate in-line as usual. Two flavours,
+	 * distinguished by ttm_pool_prealloc::full:
+	 *   - defrag bag (full=false): a bag of interchangeable beneficial-order
+	 *     chunks consumed only for beneficial-order chunks of a defrag move.
+	 *   - full tiling (full=true): the entire backing of the tt, at mixed
+	 *     orders, consumed for every chunk of an ordinary populate.
+	 * The allocator silently falls back to in-line allocation for any
+	 * shortfall.
 	 */
 	struct ttm_pool_prealloc *prealloc;
 	/**
diff --git a/include/drm/ttm/ttm_pool.h b/include/drm/ttm/ttm_pool.h
index 71670350eb15..777d5aa08f6a 100644
--- a/include/drm/ttm/ttm_pool.h
+++ b/include/drm/ttm/ttm_pool.h
@@ -83,18 +83,27 @@ void ttm_pool_free(struct ttm_pool *pool, struct ttm_tt *tt);
 
 /**
  * struct ttm_pool_prealloc - Pages preallocated outside the dma-resv lock
- * @pages: Array of @count beneficial-order pages (or fewer if a fill fell
- *         short); each entry is the head page of a 1 << @order chunk.
- * @order: Page order of every preallocated chunk.
+ * @pages: Array of @count preallocated chunks; each entry is the head page of a
+ *         chunk. In defrag mode every chunk is @order pages; in @full mode the
+ *         chunks tile a whole tt at mixed orders and the per-chunk order is read
+ *         back from the page itself.
+ * @order: Page order of every preallocated chunk (defrag mode only; 0 in @full
+ *         mode where each chunk carries its own order).
  * @caching: CPU caching applied to the pages, so leftovers can be restored
  *           to write-back before being freed.
  * @count: Number of valid entries in @pages.
  * @used: Number of entries already consumed by the pool allocator.
+ * @full: When set the bag holds a full, mixed-order tiling of an entire tt
+ *        (produced by ttm_pool_prealloc_fill_full()) rather than a bag of
+ *        interchangeable beneficial-order defrag chunks. The pool allocator
+ *        then drains the bag in order for every populate, taking each chunk's
+ *        order from the page, and falls back to in-line allocation only for any
+ *        shortfall.
  *
  * Defrag pages are interchangeable, so only a count of beneficial-order chunks
- * is needed. ttm_pool_prealloc_fill() populates this outside the lock and
- * __ttm_pool_alloc() drains it; any unused tail is released by
- * ttm_pool_prealloc_fini().
+ * is needed. ttm_pool_prealloc_fill() / ttm_pool_prealloc_fill_full() populate
+ * this outside the lock and __ttm_pool_alloc() drains it; any unused tail is
+ * released by ttm_pool_prealloc_fini().
  */
 struct ttm_pool_prealloc {
 	struct page **pages;
@@ -102,10 +111,16 @@ struct ttm_pool_prealloc {
 	enum ttm_caching caching;
 	unsigned int count;
 	unsigned int used;
+	bool full;
 };
 
 int ttm_pool_prealloc_fill(struct ttm_pool *pool, enum ttm_caching tt_caching,
 			   struct ttm_pool_prealloc *pp, unsigned int count);
+int ttm_pool_prealloc_fill_full(struct ttm_pool *pool,
+				enum ttm_caching tt_caching,
+				struct ttm_pool_prealloc *pp,
+				unsigned int num_pages,
+				bool beneficial_reclaim_backoff);
 void ttm_pool_prealloc_fini(struct ttm_pool *pool,
 			    struct ttm_pool_prealloc *pp);
 unsigned int ttm_pool_prealloc_order(struct ttm_pool *pool);
-- 
2.34.1

