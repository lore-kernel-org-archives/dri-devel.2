Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E32A4C43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:55:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AB4610F950;
	Fri, 10 Jul 2026 21:54:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="X9p6fNof";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7806D10E24B;
 Fri, 10 Jul 2026 21:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783720490; x=1815256490;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Odhs0XpH2hboPNq8HebymE4JTXsyPYrd8DJkpE373kA=;
 b=X9p6fNofQzIJFUBo9DvwnhzAuhS08p4vqy4wuPPpdD60cqVrPp+m2eb4
 VMc9ZjJ7WdNoorGMMFaabI7TN5nNGbzyvdq8MGufQlWxXldKoUvHBJnzy
 /8IML6ShQp9xPDGDwDHQG/Yvppu6F3merCfRQUQ6yB2iKpQ720ERQv57j
 OVzbibHW4wA6NGEG7czyd4KBZJDa80ai88UfKBfSZORJNWMMwrDmHDKAe
 N27qN0tb9GbUk3I0hSAudTqDO3yQocP270O1EMc/YJxPl9o/0WfH8tHQP
 vHKV8GdYfno8gGCo3uPveoqxMJw9W0lFdHNxr9jhIl9xDOmk2yFs/gr/K A==;
X-CSE-ConnectionGUID: g0268pqORD2QyYz5eLCcMA==
X-CSE-MsgGUID: hWxlaPlZSmCw2+Roirb2hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="83543103"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="83543103"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 14:54:50 -0700
X-CSE-ConnectionGUID: AwQpWS8CQVSutUGJEZUSHg==
X-CSE-MsgGUID: BHMtIUWkRJ6CZLlNZ+I8JQ==
X-ExtLoop1: 1
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 14:54:50 -0700
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
Subject: [PATCH v2 08/33] drm/ttm: Bound page (re)allocation per
 defragmentation move
Date: Fri, 10 Jul 2026 14:54:17 -0700
Message-Id: <20260710215442.2444235-9-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260710215442.2444235-1-matthew.brost@intel.com>
References: <20260710215442.2444235-1-matthew.brost@intel.com>
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

A defragmentation move reallocates an object's backing at the device's
beneficial order and harvests whatever the allocator cannot upgrade from
the old tt. For a very large object this can reallocate (and have the
driver re-copy) the entire backing in one move, which is expensive and
can stall concurrent work for an unbounded stretch.

Add an optional per-move byte budget so a large object can be upgraded in
slices across successive moves. Plumb a new
ttm_operation_ctx::defrag_bytes_remaining through to the pool allocator:
only pages actually (re)allocated at the beneficial order are charged
against it; pages harvested (borrowed) from defrag_old_tt are free and do
not count. Once the budget is exhausted the allocator stops upgrading and
completes the new tt by harvesting the remainder of the old tt as-is,
marking the tt sub-optimal (TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED) so the
driver re-queues it and a later move resumes the upgrade. The slices
already upgraded come back as free already-beneficial harvests on the
next pass, so each move spends budget only on new forward progress.

The allocator decrements the budget as it allocates and writes the unused
remainder back on success, letting the caller compute how many bytes were
actually spent. A value of 0 means unlimited (upgrade the whole object in
one move), preserving the previous behaviour. This is only consulted on a
defragmentation move, i.e. when defrag_old_tt is set.

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
 drivers/gpu/drm/ttm/ttm_pool.c | 101 ++++++++++++++++++++++++++++++++-
 include/drm/ttm/ttm_bo.h       |  14 +++++
 2 files changed, 112 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 5d2bbcce4eb8..a6847a16c47f 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -77,6 +77,11 @@ struct ttm_pool_dma {
  * @dma_addr: Pointer to the next tt dma_address entry to populate if any.
  * @remaining_pages: Remaining pages to populate.
  * @tt_caching: The requested cpu-caching for the pages allocated.
+ * @defrag_bytes_remaining: Byte budget for newly (re)allocated pages on a
+ * defragmentation move, seeded from ttm_operation_ctx::defrag_bytes_remaining.
+ * Pages harvested (borrowed) from the old tt are free and do not count; once
+ * this drops to zero the allocator stops upgrading and harvests the remainder.
+ * On completion it holds the unused budget. 0 means unlimited (no defrag cap).
  */
 struct ttm_pool_alloc_state {
 	struct page **pages;
@@ -84,6 +89,7 @@ struct ttm_pool_alloc_state {
 	dma_addr_t *dma_addr;
 	pgoff_t remaining_pages;
 	enum ttm_caching tt_caching;
+	s64 defrag_bytes_remaining;
 };
 
 /**
@@ -780,6 +786,7 @@ static void ttm_pool_alloc_state_init(const struct ttm_tt *tt,
 	alloc->dma_addr = tt->dma_address;
 	alloc->remaining_pages = tt->num_pages;
 	alloc->tt_caching = tt->caching;
+	alloc->defrag_bytes_remaining = 0;
 }
 
 /*
@@ -885,14 +892,33 @@ static int ttm_pool_harvest_page(struct ttm_tt *old_tt, unsigned int order,
 
 static int ttm_pool_harvest_remaining(struct ttm_pool *pool,
 				      struct ttm_tt *old_tt, pgoff_t off,
-				      struct ttm_pool_alloc_state *alloc)
+				      struct ttm_pool_alloc_state *alloc,
+				      bool *suboptimal)
 {
+	unsigned int beneficial = ttm_pool_beneficial_order(pool);
+	pgoff_t bnr = 1UL << beneficial;
+
 	while (alloc->remaining_pages) {
 		struct page *p = old_tt->pages[off];
 		unsigned int order = ttm_pool_page_order(pool, p);
 		pgoff_t nr = 1UL << order;
+		pgoff_t num_pages = off + alloc->remaining_pages;
 		int r;
 
+		/*
+		 * Only report a sub-optimal backing when a chunk we cannot
+		 * upgrade (out of budget/prealloc) sits in a beneficial-order
+		 * aligned region that fully fits in the tt: that region could
+		 * have been upgraded with more budget. A chunk below the
+		 * beneficial order is expected for the unaligned tail (the last
+		 * partial beneficial-order region) and for already beneficial-
+		 * order harvests - neither leaves real defrag work, so they must
+		 * not flag the tt for re-queue.
+		 */
+		if (beneficial && order < beneficial &&
+		    round_down(off, bnr) + bnr <= num_pages)
+			*suboptimal = true;
+
 		r = ttm_pool_harvest_page(old_tt, order, off, alloc);
 		if (r)
 			return r;
@@ -936,6 +962,7 @@ struct ttm_pool_alloc_iter {
 	struct ttm_tt *defrag_old_tt;
 	unsigned int beneficial_order;
 	gfp_t gfp_flags;
+	bool defrag_capped;
 
 	/* Mutated as the loop walks the orders. */
 	unsigned int order;
@@ -947,6 +974,44 @@ struct ttm_pool_alloc_iter {
 	struct page *p;
 };
 
+/*
+ * Defrag move budget exhausted: the upgrade can make no further progress this
+ * pass. Snapshot @defrag_capped is set only when a byte budget was in force at
+ * entry.
+ */
+static bool ttm_pool_iter_defrag_exhausted(const struct ttm_pool_alloc_iter *it)
+{
+	if (!it->defrag_old_tt)
+		return false;
+
+	return it->defrag_capped && it->alloc->defrag_bytes_remaining <= 0;
+}
+
+/*
+ * Complete the new tt by harvesting the rest of the old tt as-is (borrowing its
+ * pages, including any still below beneficial order). Never fall back to in-lock
+ * reclaim for the shortfall - that would reintroduce the stall we preallocated
+ * to avoid. Only re-queue (flag) the tt when the harvested remainder is
+ * genuinely sub-optimal; if every remaining old chunk was already at beneficial
+ * order the move fully upgraded the object.
+ */
+static int ttm_pool_iter_harvest_rest(struct ttm_pool_alloc_iter *it)
+{
+	pgoff_t off = it->tt->num_pages - it->alloc->remaining_pages;
+	bool suboptimal = false;
+	int r;
+
+	r = ttm_pool_harvest_remaining(it->pool, it->defrag_old_tt, off,
+				       it->alloc, &suboptimal);
+	if (r)
+		return r;
+
+	if (suboptimal)
+		it->tt->page_flags |= TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED;
+
+	return 0;
+}
+
 /*
  * Defrag move: reuse an already beneficial-order chunk from the old tt at this
  * offset rather than reallocating it. Harvest whatever order the old chunk has
@@ -1047,11 +1112,12 @@ static int ttm_pool_iter_lower_order(struct ttm_pool_alloc_iter *it)
 		if (it->alloc_count && it->defrag_old_tt) {
 			pgoff_t off = it->tt->num_pages -
 				      it->alloc->remaining_pages;
+			bool suboptimal = false;
 			int r;
 
 			r = ttm_pool_harvest_remaining(it->pool,
 						       it->defrag_old_tt, off,
-						       it->alloc);
+						       it->alloc, &suboptimal);
 			if (r)
 				return r;
 
@@ -1106,10 +1172,23 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 		gfp_flags |= GFP_HIGHUSER;
 
 	it.gfp_flags = gfp_flags;
+	it.defrag_capped = it.defrag_old_tt && alloc->defrag_bytes_remaining > 0;
 
 	for (it.order = ttm_pool_alloc_find_order(MAX_PAGE_ORDER, alloc);
 	     alloc->remaining_pages;
 	     it.order = ttm_pool_alloc_find_order(it.order, alloc)) {
+		/*
+		 * Out of defrag budget: harvest the rest of the old tt as-is and
+		 * stop (the tt is re-queued if the remainder is still
+		 * sub-optimal).
+		 */
+		if (ttm_pool_iter_defrag_exhausted(&it)) {
+			r = ttm_pool_iter_harvest_rest(&it);
+			if (r)
+				goto error_free_all;
+			break;
+		}
+
 		/* Reuse an already beneficial-order chunk from the old tt. */
 		r = ttm_pool_iter_reuse_old(&it);
 		if (r < 0)
@@ -1140,6 +1219,15 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 				goto error_free_all;
 		}
 
+		/*
+		 * Charge a newly (re)allocated chunk against the defrag move
+		 * budget. Harvested chunks borrow the old tt's pages for free
+		 * and never reach here.
+		 */
+		if (it.defrag_capped)
+			alloc->defrag_bytes_remaining -=
+				(s64)(1UL << it.order) << PAGE_SHIFT;
+
 		it.alloc_count++;
 	}
 
@@ -1189,14 +1277,21 @@ int ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 		   struct ttm_operation_ctx *ctx)
 {
 	struct ttm_pool_alloc_state alloc;
+	int ret;
 
 	if (WARN_ON(ttm_tt_is_backed_up(tt)))
 		return -EINVAL;
 
 	tt->page_flags &= ~TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED;
 	ttm_pool_alloc_state_init(tt, &alloc);
+	alloc.defrag_bytes_remaining = ctx->defrag_bytes_remaining;
+
+	ret = __ttm_pool_alloc(pool, tt, ctx, &alloc, NULL);
+
+	/* Report the unused defrag budget back to the caller. */
+	ctx->defrag_bytes_remaining = alloc.defrag_bytes_remaining;
 
-	return __ttm_pool_alloc(pool, tt, ctx, &alloc, NULL);
+	return ret;
 }
 EXPORT_SYMBOL(ttm_pool_alloc);
 
diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
index fcaba5fb8bf7..6124d2627b47 100644
--- a/include/drm/ttm/ttm_bo.h
+++ b/include/drm/ttm/ttm_bo.h
@@ -223,6 +223,20 @@ struct ttm_operation_ctx {
 	 * NULL for non-defrag operations.
 	 */
 	struct ttm_tt *defrag_old_tt;
+	/**
+	 * @defrag_bytes_remaining: Byte budget for newly allocated pages during
+	 * a defragmentation move. Only pages that are actually (re)allocated at
+	 * the beneficial order count against it; pages harvested (borrowed) from
+	 * @defrag_old_tt are free and do not. When the budget is exhausted the
+	 * pool allocator stops upgrading and completes the new tt by harvesting
+	 * the remainder of @defrag_old_tt, marking the tt sub-optimal so the
+	 * driver can resume on a later pass. The allocator decrements this as it
+	 * allocates, so on return it holds the unused budget (which the caller
+	 * can use to compute how many bytes were spent). A value of 0 means
+	 * unlimited (upgrade the whole object). Only consulted when
+	 * @defrag_old_tt is set.
+	 */
+	s64 defrag_bytes_remaining;
 	/**
 	 * @resv: Reservation object to be used together with
 	 * @allow_res_evict.
-- 
2.34.1

