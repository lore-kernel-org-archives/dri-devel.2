Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A30C4450A
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 02:56:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63B2510E2C2;
	Sat, 11 Jul 2026 02:56:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="FQPemYPD";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E23510E2AD;
 Sat, 11 Jul 2026 02:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783738588; x=1815274588;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=n9L7LyuOFNrBp008Xuyy6n4ypjn4lWJyG9j3rKrRQg4=;
 b=FQPemYPD/3dwa6svFBZLMNNCzgieG5c03eH5ZVIC9K+Ek+GXMiAxFoDy
 DPKMTKTmj0BwUery63UtrcKxS8QQfPr1ZSgHAtFvJJ6FIWYl6c7+qNO9n
 jaHKsPYQxK7+hDEOxajbsxkII8tx2DeGcaUupBImP08+cnvxQDAsFL3Ih
 aHu6RDYp72eshkp9Z9PH8ddwlPJRj9xiJfRrzheo+7xT6QrL1WBXZz6gY
 Vhke9zo35bptAyWnpa0duN9kKFMgX4i8RcMHG7GArVJmVe7O6zPDh6iCq
 f16fy9DVJgTWes3VfPIA01DhFxgZZxEy0j1tk6RhqoW1a4A6TtrlLPRxc w==;
X-CSE-ConnectionGUID: VVOblF4aQtG+VGc1TbEUjQ==
X-CSE-MsgGUID: luZnFFRIQuq/FgFBFNuNIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="101986247"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="101986247"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 19:56:28 -0700
X-CSE-ConnectionGUID: rufMN/fnTkunNgeFLDGofA==
X-CSE-MsgGUID: 4hqxdHSqQp2dy3hl6N45dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="256987706"
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
Subject: [PATCH v3 09/33] drm/ttm: Preallocate beneficial-order defrag pages
 outside the lock
Date: Fri, 10 Jul 2026 19:55:55 -0700
Message-Id: <20260711025619.2540575-10-matthew.brost@intel.com>
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

Defragmentation moves reallocate a BO's backing at the pool's beneficial
order. On a fragmented system those high-order allocations frequently
stall in direct reclaim/compaction, and they run under the BO dma-resv
lock, holding up concurrent rendering. The defrag worker does not care
how long the work takes; it only cares about minimizing locked time.

Add a preallocation bag so the expensive allocations can be hoisted out
of the lock:

 - struct ttm_pool_prealloc carries beneficial-order pages preallocated
   outside the lock; ttm_pool_prealloc_fill()/_fini() allocate and
   release them. __ttm_pool_alloc() consumes them via ctx->prealloc.
 - Apply the requested cpu-caching to the bag pages during fill, so the
   set_memory_*() cost is paid outside the lock too; consumed pages are
   already cache-consistent and leftovers are restored to write-back on
   free. Bag pages are never highmem so the kernel mapping is always
   valid for set_memory_*().
 - Record the exact number of sub-optimal pages on the tt
   (nr_suboptimal_pages) at populate time so a defrag pass can size its
   prealloc precisely instead of guessing.
 - Once a defrag move exhausts the prealloc bag, harvest the remainder
   of the old tt rather than entering reclaim under the lock, and flag
   the tt sub-optimal so the driver re-queues it for a later pass.

This keeps all reclaim/compaction stalls and cache mode changes out of
the dma-resv critical section: lock-held time then tracks only the bytes
actually copied.

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
 drivers/gpu/drm/ttm/ttm_pool.c | 244 +++++++++++++++++++++++++++++++--
 include/drm/ttm/ttm_bo.h       |  11 ++
 include/drm/ttm/ttm_pool.h     |  29 ++++
 include/drm/ttm/ttm_tt.h       |  17 +++
 4 files changed, 287 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 1673e81b8df8..da7d132c8297 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -82,6 +82,9 @@ struct ttm_pool_dma {
  * Pages harvested (borrowed) from the old tt are free and do not count; once
  * this drops to zero the allocator stops upgrading and harvests the remainder.
  * On completion it holds the unused budget. 0 means unlimited (no defrag cap).
+ * @nr_suboptimal_pages: Number of pages backed below the pool's beneficial
+ * order. Recorded by the pool allocator after populate; a defrag pass reads it
+ * to size its out-of-lock preallocation exactly.
  */
 struct ttm_pool_alloc_state {
 	struct page **pages;
@@ -90,6 +93,7 @@ struct ttm_pool_alloc_state {
 	pgoff_t remaining_pages;
 	enum ttm_caching tt_caching;
 	s64 defrag_bytes_remaining;
+	u32 nr_suboptimal_pages;
 };
 
 /**
@@ -787,6 +791,7 @@ static void ttm_pool_alloc_state_init(const struct ttm_tt *tt,
 	alloc->remaining_pages = tt->num_pages;
 	alloc->tt_caching = tt->caching;
 	alloc->defrag_bytes_remaining = 0;
+	alloc->nr_suboptimal_pages = 0;
 }
 
 /*
@@ -852,7 +857,8 @@ static unsigned int ttm_pool_defrag_old_order(struct ttm_pool *pool,
  * pages stay owned by the old tt until the move commits.
  */
 static int ttm_pool_harvest_page(struct ttm_tt *old_tt, unsigned int order,
-				 pgoff_t off, struct ttm_pool_alloc_state *alloc)
+				 unsigned int beneficial_order, pgoff_t off,
+				 struct ttm_pool_alloc_state *alloc)
 {
 	pgoff_t nr = 1UL << order;
 	int r;
@@ -887,6 +893,9 @@ static int ttm_pool_harvest_page(struct ttm_tt *old_tt, unsigned int order,
 
 	alloc->caching_divide = alloc->pages;
 
+	if (order < beneficial_order)
+		alloc->nr_suboptimal_pages += 0x1 << order;
+
 	return 0;
 }
 
@@ -934,7 +943,8 @@ static int ttm_pool_harvest_remaining(struct ttm_pool *pool,
 		    round_down(off, bnr) + bnr <= num_pages)
 			*suboptimal = true;
 
-		r = ttm_pool_harvest_page(old_tt, order, off, alloc);
+		r = ttm_pool_harvest_page(old_tt, order, beneficial, off,
+					  alloc);
 		if (r)
 			return r;
 
@@ -944,6 +954,173 @@ static int ttm_pool_harvest_remaining(struct ttm_pool *pool,
 	return 0;
 }
 
+unsigned int ttm_pool_prealloc_order(struct ttm_pool *pool)
+{
+	return ttm_pool_beneficial_order(pool);
+}
+EXPORT_SYMBOL(ttm_pool_prealloc_order);
+
+/*
+ * Build the gfp flags used for the high-order, possibly reclaiming, beneficial
+ * order page allocations, matching the in-line defrag alloc path.
+ */
+static gfp_t ttm_pool_prealloc_gfp(struct ttm_pool *pool)
+{
+	gfp_t gfp = GFP_USER;
+
+	/*
+	 * No highmem: prealloc applies caching in bulk via set_pages_array_*()
+	 * on the kernel mapping, so the pages must be permanently mapped.
+	 */
+	if (ttm_pool_uses_dma32(pool))
+		gfp |= GFP_DMA32;
+
+	return gfp;
+}
+
+/*
+ * Apply a tt's cpu-caching to a batch of freshly system-allocated (write-back)
+ * prealloc pages in one shot. @cpages is an unpacked array of @ncpages
+ * individual 4K pages (the constituent pages of the mixed-order chunks, expanded
+ * so set_pages_array_*() sees one entry per page), since the packed prealloc bag
+ * holds multi-order chunks. Prealloc pages are never highmem (see
+ * ttm_pool_prealloc_gfp), so their kernel mapping is valid. No-op for cached
+ * pages and on non-x86. Returns non-zero if the caching change failed (the
+ * caller drops the whole bag and falls back to in-line allocation).
+ */
+static int ttm_pool_prealloc_apply_caching(enum ttm_caching caching,
+					   struct page **cpages,
+					   unsigned int ncpages)
+{
+#ifdef CONFIG_X86
+	if (!ncpages)
+		return 0;
+
+	switch (caching) {
+	case ttm_cached:
+		break;
+	case ttm_write_combined:
+		return set_pages_array_wc(cpages, ncpages);
+	case ttm_uncached:
+		return set_pages_array_uc(cpages, ncpages);
+	}
+#endif
+	return 0;
+}
+
+/* Expand an @order chunk into its constituent 4K pages for bulk caching. */
+static void ttm_pool_prealloc_stage_caching(struct page **cpages,
+					    unsigned int *ncpages,
+					    struct page *p, unsigned int order)
+{
+	unsigned int i, nr = 1u << order;
+
+	for (i = 0; i < nr; i++)
+		cpages[(*ncpages)++] = p + i;
+}
+
+/**
+ * ttm_pool_prealloc_fill() - Preallocate beneficial-order pages outside any lock
+ * @pool: The pool to allocate from.
+ * @tt_caching: The requested cpu-caching for the pages allocated.
+ * @pp: Prealloc bag to fill; @pp->order is set to the beneficial order.
+ * @count: Number of beneficial-order chunks to attempt.
+ *
+ * Allocate up to @count beneficial-order chunks, parking them in @pp for a
+ * later __ttm_pool_alloc() defrag move to consume under the dma-resv lock. May
+ * sleep/reclaim freely as it runs unlocked. A short fill is fine: the pool
+ * falls back to in-line allocation for the shortfall. DMA-alloc pools are not
+ * supported (count stays 0). Returns 0 (release with ttm_pool_prealloc_fini()).
+ */
+int ttm_pool_prealloc_fill(struct ttm_pool *pool, enum ttm_caching tt_caching,
+			   struct ttm_pool_prealloc *pp, unsigned int count)
+{
+	unsigned int order = ttm_pool_beneficial_order(pool);
+	gfp_t gfp = ttm_pool_prealloc_gfp(pool);
+	struct page **cpages = NULL;
+	unsigned int ncpages = 0;
+	int r;
+
+	pp->pages = NULL;
+	pp->order = order;
+	pp->caching = tt_caching;
+	pp->count = 0;
+	pp->used = 0;
+
+	/* Nothing to gain without a beneficial order or for DMA-alloc pools. */
+	if (!order || !count || ttm_pool_uses_dma_alloc(pool))
+		return 0;
+
+	pp->pages = kvzalloc_objs(*pp->pages, count);
+	if (!pp->pages)
+		return 0;
+
+	/*
+	 * Every chunk is a fresh write-back system page of @order that needs a
+	 * caching change; collect their constituent pages into an unpacked
+	 * scratch array and issue a single set_pages_array_*() after the fill.
+	 * Cached tts need no change (and non-x86 handles caching at map time).
+	 */
+	if (IS_ENABLED(CONFIG_X86) && tt_caching != ttm_cached) {
+		cpages = kvzalloc_objs(*cpages, (size_t)count << order);
+		if (!cpages) {
+			kvfree(pp->pages);
+			pp->pages = NULL;
+			return 0;
+		}
+	}
+
+	while (pp->count < count) {
+		struct page *p = ttm_pool_alloc_page(pool, gfp, order, false);
+
+		if (!p)
+			break;
+
+		pp->pages[pp->count++] = p;
+		if (cpages)
+			ttm_pool_prealloc_stage_caching(cpages, &ncpages, p,
+							order);
+	}
+
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
+		for (i = 0; i < pp->count; i++)
+			ttm_pool_free_page(pool, tt_caching, order,
+					   pp->pages[i], false);
+		pp->count = 0;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(ttm_pool_prealloc_fill);
+
+/**
+ * ttm_pool_prealloc_fini() - Release unconsumed preallocated pages
+ * @pool: The pool the pages came from.
+ * @pp: Prealloc bag to drain. Consumed pages (< @used) are now owned by the tt.
+ */
+void ttm_pool_prealloc_fini(struct ttm_pool *pool, struct ttm_pool_prealloc *pp)
+{
+	unsigned int i;
+
+	for (i = pp->used; i < pp->count; ++i)
+		ttm_pool_free_page(pool, pp->caching, pp->order, pp->pages[i],
+				   false);
+	kvfree(pp->pages);
+	pp->pages = NULL;
+	pp->count = 0;
+	pp->used = 0;
+}
+EXPORT_SYMBOL(ttm_pool_prealloc_fini);
+
 /**
  * enum ttm_pool_iter_action - Outcome of a per-order allocation phase
  * @TTM_POOL_ITER_FILL: A page (@it->p) was acquired; proceed to fill it in.
@@ -975,6 +1152,7 @@ struct ttm_pool_alloc_iter {
 	struct ttm_pool_alloc_state *alloc;
 	struct ttm_pool_tt_restore *restore;
 	struct ttm_tt *defrag_old_tt;
+	struct ttm_pool_prealloc *prealloc;
 	unsigned int beneficial_order;
 	gfp_t gfp_flags;
 	bool defrag_capped;
@@ -990,16 +1168,20 @@ struct ttm_pool_alloc_iter {
 };
 
 /*
- * Defrag move budget exhausted: the upgrade can make no further progress this
- * pass. Snapshot @defrag_capped is set only when a byte budget was in force at
- * entry.
+ * Defrag move budget exhausted, or the out-of-lock prealloc bag ran dry: the
+ * upgrade can make no further progress this pass. Snapshot @defrag_capped is
+ * set only when a byte budget was in force at entry.
  */
 static bool ttm_pool_iter_defrag_exhausted(const struct ttm_pool_alloc_iter *it)
 {
+	const struct ttm_pool_prealloc *pp = it->prealloc;
+
 	if (!it->defrag_old_tt)
 		return false;
+	if (it->defrag_capped && it->alloc->defrag_bytes_remaining <= 0)
+		return true;
 
-	return it->defrag_capped && it->alloc->defrag_bytes_remaining <= 0;
+	return pp && pp->count && pp->used >= pp->count;
 }
 
 /*
@@ -1056,7 +1238,8 @@ static int ttm_pool_iter_reuse_old(struct ttm_pool_alloc_iter *it)
 		return TTM_POOL_ITER_FILL;
 
 	it->order = harvest_order;
-	r = ttm_pool_harvest_page(it->defrag_old_tt, it->order, off, it->alloc);
+	r = ttm_pool_harvest_page(it->defrag_old_tt, it->order,
+				  it->beneficial_order, off, it->alloc);
 	if (r)
 		return r;
 
@@ -1068,11 +1251,13 @@ static int ttm_pool_iter_reuse_old(struct ttm_pool_alloc_iter *it)
 
 /*
  * Acquire a single page for the current order, leaving it in @it->p (NULL on
- * failure). Tries a same-order pool page, then a fresh system allocation. Fault
- * injection can force the beneficial-order paths to "fail".
+ * failure). Tries, in order: a beneficial-order page preallocated outside the
+ * dma-resv lock (defrag), a same-order pool page, then a fresh system
+ * allocation. Fault injection can force the beneficial-order paths to "fail".
  */
 static void ttm_pool_iter_acquire_page(struct ttm_pool_alloc_iter *it)
 {
+	struct ttm_pool_prealloc *pp = it->prealloc;
 	struct ttm_pool_type *pt;
 
 	it->p = NULL;
@@ -1087,7 +1272,18 @@ static void ttm_pool_iter_acquire_page(struct ttm_pool_alloc_iter *it)
 		it->beneficial_order && it->order >= it->beneficial_order &&
 		should_fail(&beneficial_order_fault_inject, 1);
 
-	/* First, try to allocate a page from a pool if one exists. */
+	/*
+	 * Defrag move: consume a beneficial-order page preallocated outside the
+	 * dma-resv lock instead of allocating one in-line (which may stall in
+	 * reclaim/compaction). Falls through once the bag is empty.
+	 */
+	if (pp && !it->fail_beneficial && it->order >= it->beneficial_order &&
+	    pp->used < pp->count) {
+		it->order = it->beneficial_order;
+		it->p = pp->pages[pp->used++];
+		it->page_caching = it->tt->caching;
+	}
+
 	pt = ttm_pool_select_type(it->pool, it->page_caching, it->order);
 	if (!it->p && pt && it->allow_pools && !it->fail_beneficial)
 		it->p = ttm_pool_type_take(pt, ttm_pool_nid(it->pool));
@@ -1164,6 +1360,7 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 		.alloc = alloc,
 		.restore = restore,
 		.defrag_old_tt = restore ? NULL : ctx->defrag_old_tt,
+		.prealloc = restore ? NULL : ctx->prealloc,
 		.beneficial_order = ttm_pool_beneficial_order(pool),
 		.page_caching = tt->caching,
 		.allow_pools = true,
@@ -1193,8 +1390,8 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 	     alloc->remaining_pages;
 	     it.order = ttm_pool_alloc_find_order(it.order, alloc)) {
 		/*
-		 * Out of defrag budget: harvest the rest of the old tt as-is and
-		 * stop (the tt is re-queued if the remainder is still
+		 * Out of defrag budget/prealloc: harvest the rest of the old tt
+		 * as-is and stop (the tt is re-queued if the remainder is still
 		 * sub-optimal).
 		 */
 		if (ttm_pool_iter_defrag_exhausted(&it)) {
@@ -1211,7 +1408,7 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 		if (r == TTM_POOL_ITER_RETRY)
 			continue;
 
-		/* Acquire a page (pool / system) for this order. */
+		/* Acquire a page (prealloc / pool / system) for this order. */
 		ttm_pool_iter_acquire_page(&it);
 		if (!it.p) {
 			r = ttm_pool_iter_lower_order(&it);
@@ -1243,6 +1440,8 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 			alloc->defrag_bytes_remaining -=
 				(s64)(1UL << it.order) << PAGE_SHIFT;
 
+		if (it.order < it.beneficial_order)
+			alloc->nr_suboptimal_pages += 0x1 << it.order;
 		it.alloc_count++;
 	}
 
@@ -1306,6 +1505,9 @@ int ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 	/* Report the unused defrag budget back to the caller. */
 	ctx->defrag_bytes_remaining = alloc.defrag_bytes_remaining;
 
+	if (!ret)
+		tt->nr_suboptimal_pages = alloc.nr_suboptimal_pages;
+
 	return ret;
 }
 EXPORT_SYMBOL(ttm_pool_alloc);
@@ -1358,6 +1560,15 @@ int ttm_pool_restore_and_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 
 			if (ret)
 				return ret;
+
+			/*
+			 * __ttm_pool_alloc() counts each freshly (re)allocated
+			 * chunk against nr_suboptimal_pages, but a chunk whose
+			 * backup copy was interrupted and is finished here
+			 * resumes past that loop, so account for it directly.
+			 */
+			if (restore->order < ttm_pool_beneficial_order(pool))
+				alloc.nr_suboptimal_pages += 1U << restore->order;
 		}
 		if (!alloc.remaining_pages) {
 			ret = ttm_pool_apply_caching(&alloc);
@@ -1367,11 +1578,16 @@ int ttm_pool_restore_and_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 			kfree(tt->restore);
 			tt->restore = NULL;
 
+			tt->nr_suboptimal_pages = alloc.nr_suboptimal_pages;
 			return 0;
 		}
 	}
 
-	return __ttm_pool_alloc(pool, tt, ctx, &alloc, restore);
+	ret = __ttm_pool_alloc(pool, tt, ctx, &alloc, restore);
+	if (!ret)
+		tt->nr_suboptimal_pages = alloc.nr_suboptimal_pages;
+
+	return ret;
 }
 
 /**
diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
index 6124d2627b47..a80304f179ba 100644
--- a/include/drm/ttm/ttm_bo.h
+++ b/include/drm/ttm/ttm_bo.h
@@ -237,6 +237,17 @@ struct ttm_operation_ctx {
 	 * @defrag_old_tt is set.
 	 */
 	s64 defrag_bytes_remaining;
+	/**
+	 * @prealloc: Pages preallocated outside the dma-resv lock for a defrag
+	 * move. The pool allocator consumes these instead of allocating fresh
+	 * beneficial-order pages under the lock, moving the (potentially
+	 * reclaim/compaction stalling) high-order allocations out of the
+	 * critical section. NULL means allocate in-line as usual. The pool
+	 * silently falls back to in-line allocation for any shortfall. The
+	 * allocator consumes it for beneficial-order chunks of any populate;
+	 * drivers only set it for a defrag move.
+	 */
+	struct ttm_pool_prealloc *prealloc;
 	/**
 	 * @resv: Reservation object to be used together with
 	 * @allow_res_evict.
diff --git a/include/drm/ttm/ttm_pool.h b/include/drm/ttm/ttm_pool.h
index 753203980e2c..71670350eb15 100644
--- a/include/drm/ttm/ttm_pool.h
+++ b/include/drm/ttm/ttm_pool.h
@@ -81,6 +81,35 @@ int ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 		   struct ttm_operation_ctx *ctx);
 void ttm_pool_free(struct ttm_pool *pool, struct ttm_tt *tt);
 
+/**
+ * struct ttm_pool_prealloc - Pages preallocated outside the dma-resv lock
+ * @pages: Array of @count beneficial-order pages (or fewer if a fill fell
+ *         short); each entry is the head page of a 1 << @order chunk.
+ * @order: Page order of every preallocated chunk.
+ * @caching: CPU caching applied to the pages, so leftovers can be restored
+ *           to write-back before being freed.
+ * @count: Number of valid entries in @pages.
+ * @used: Number of entries already consumed by the pool allocator.
+ *
+ * Defrag pages are interchangeable, so only a count of beneficial-order chunks
+ * is needed. ttm_pool_prealloc_fill() populates this outside the lock and
+ * __ttm_pool_alloc() drains it; any unused tail is released by
+ * ttm_pool_prealloc_fini().
+ */
+struct ttm_pool_prealloc {
+	struct page **pages;
+	unsigned int order;
+	enum ttm_caching caching;
+	unsigned int count;
+	unsigned int used;
+};
+
+int ttm_pool_prealloc_fill(struct ttm_pool *pool, enum ttm_caching tt_caching,
+			   struct ttm_pool_prealloc *pp, unsigned int count);
+void ttm_pool_prealloc_fini(struct ttm_pool *pool,
+			    struct ttm_pool_prealloc *pp);
+unsigned int ttm_pool_prealloc_order(struct ttm_pool *pool);
+
 void ttm_pool_init(struct ttm_pool *pool, struct device *dev,
 		   int nid, unsigned int alloc_flags);
 void ttm_pool_fini(struct ttm_pool *pool);
diff --git a/include/drm/ttm/ttm_tt.h b/include/drm/ttm/ttm_tt.h
index 55c35bcf134d..81a5446ca693 100644
--- a/include/drm/ttm/ttm_tt.h
+++ b/include/drm/ttm/ttm_tt.h
@@ -135,6 +135,12 @@ struct ttm_tt {
 	enum ttm_caching caching;
 	/** @restore: Partial restoration from backup state. TTM private */
 	struct ttm_pool_tt_restore *restore;
+	/**
+	 * @nr_suboptimal_pages: Number of pages backed below the pool's
+	 * beneficial order. Recorded by the pool allocator after populate; a
+	 * defrag pass reads it to size its out-of-lock preallocation exactly.
+	 */
+	u32 nr_suboptimal_pages;
 };
 
 /**
@@ -201,6 +207,17 @@ static inline bool ttm_tt_is_beneficial_order_failed(const struct ttm_tt *tt)
 	return tt->page_flags & TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED;
 }
 
+/**
+ * ttm_tt_suboptimal_pages() - Pages backed below the pool's beneficial order
+ * @tt: The struct ttm_tt.
+ *
+ * Return: Number of pages a defrag move would (re)allocate at beneficial order.
+ */
+static inline u32 ttm_tt_suboptimal_pages(const struct ttm_tt *tt)
+{
+	return tt->nr_suboptimal_pages;
+}
+
 /**
  * ttm_tt_create
  *
-- 
2.34.1

