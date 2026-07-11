Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75372C43458
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 02:56:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A88B410E2AD;
	Sat, 11 Jul 2026 02:56:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="RGTvpJmC";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1216E10E2A6;
 Sat, 11 Jul 2026 02:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783738586; x=1815274586;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3eIwdS6xp8qzU8TCYrUmLeUYt1+4OY83VYleRh0z1iE=;
 b=RGTvpJmC2z3Pf3sONQUPxt2R4wPeFfOCC5TYU0GIpThPsEKfes2fDImh
 kZtHumx9yNbUa8KiNm35GRf8Tc6IPMa141kzelJZrQy9Q7NvlimAetL5N
 Gnn0rQDyRbvqhXM52U3C7BZSBGGprbp5Sn/X2gCtiG4o1SyReq+5MKkbR
 030AyOTT2QlbvZLmco9pWIa02HB5Scm6WlFXz1PCTsFnz+14zSKJQJex5
 9kkpQxpmeqO2qG+FvTNNECo/4cFG/NSti5CQJqFzxaZsgHiR1+qjfHcHL
 HnJnpKMUDfGttXtnbZIIR+y/Mnue3n5+K828bl+bnXm5Z2V+bm+9AZSIn w==;
X-CSE-ConnectionGUID: QfrQf29YTDOEIZMy9lBLLw==
X-CSE-MsgGUID: 0St5++VDQBWghalVgi3PBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="101986206"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="101986206"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 19:56:26 -0700
X-CSE-ConnectionGUID: pM4/8/dWS5G6DAr/2NQEqQ==
X-CSE-MsgGUID: I2ShmNqLQ8SdktZwVIKHHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="256987685"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 19:56:25 -0700
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
Subject: [PATCH v3 04/33] drm/ttm: Introduce ttm_pool_alloc_iter for
 __ttm_pool_alloc()
Date: Fri, 10 Jul 2026 19:55:50 -0700
Message-Id: <20260711025619.2540575-5-matthew.brost@intel.com>
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

__ttm_pool_alloc() walks the page orders in a single loop whose body is
about to grow several defragmentation phases (reusing old pages, a move
budget, out-of-lock preallocation and fault injection). Left inline these
interleave into one deeply nested block of gotos and combinatorial
conditionals that is hard to follow and extend.

Factor the loop's working state into a struct ttm_pool_alloc_iter and
pull the per-order page acquisition and order-fallback into small phase
helpers, so the main loop reads as a short sequence of named steps. This
is a pure refactor with no functional change; subsequent patches extend
the iterator with their defrag phases rather than nesting more logic into
the loop.

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
 drivers/gpu/drm/ttm/ttm_pool.c | 159 ++++++++++++++++++++++-----------
 1 file changed, 106 insertions(+), 53 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index e9175c0290d7..0ca63f5ce73c 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -791,18 +791,102 @@ static unsigned int ttm_pool_alloc_find_order(unsigned int highest,
 	return min_t(unsigned int, highest, __fls(alloc->remaining_pages));
 }
 
+/**
+ * struct ttm_pool_alloc_iter - Working state for the __ttm_pool_alloc() loop
+ *
+ * Bundles the immutable inputs and the mutable per-order state that the
+ * allocation phase helpers share, so the main loop reads as a short sequence
+ * of named phases rather than one deeply nested block.
+ */
+struct ttm_pool_alloc_iter {
+	/* Immutable for the duration of the allocation. */
+	struct ttm_pool *pool;
+	struct ttm_tt *tt;
+	const struct ttm_operation_ctx *ctx;
+	struct ttm_pool_alloc_state *alloc;
+	struct ttm_pool_tt_restore *restore;
+	unsigned int beneficial_order;
+	gfp_t gfp_flags;
+
+	/* Mutated as the loop walks the orders. */
+	unsigned int order;
+	enum ttm_caching page_caching;
+	bool allow_pools;
+	struct page *p;
+};
+
+/*
+ * Acquire a single page for the current order, leaving it in @it->p (NULL on
+ * failure). Tries a same-order pool page, then a fresh system allocation.
+ */
+static void ttm_pool_iter_acquire_page(struct ttm_pool_alloc_iter *it)
+{
+	struct ttm_pool_type *pt;
+
+	/* First, try to allocate a page from a pool if one exists. */
+	it->p = NULL;
+	pt = ttm_pool_select_type(it->pool, it->page_caching, it->order);
+	if (!it->p && pt && it->allow_pools)
+		it->p = ttm_pool_type_take(pt, ttm_pool_nid(it->pool));
+
+	/*
+	 * If that fails or previously failed, allocate from system. Note that
+	 * this also disallows additional pool allocations using write-back
+	 * cached pools of the same order.
+	 */
+	if (!it->p) {
+		it->page_caching = ttm_cached;
+		it->allow_pools = false;
+		it->p = ttm_pool_alloc_page(it->pool, it->gfp_flags, it->order,
+					    it->ctx->beneficial_reclaim_backoff);
+	}
+}
+
+/*
+ * The current order could not be satisfied. Lower it and retry, recording a
+ * sub-optimal backing (so the driver can later re-defrag) when we drop below
+ * the beneficial order.
+ *
+ * Returns 0 to retry the (lowered) order, or a negative errno.
+ */
+static int ttm_pool_iter_lower_order(struct ttm_pool_alloc_iter *it)
+{
+	if (!it->order)
+		return -ENOMEM;
+
+	/*
+	 * Failing to allocate at the device's beneficial order means we are
+	 * about to back this object with a sub-optimal (smaller order) set of
+	 * pages. Record it so the driver can later try to defragment the object
+	 * back to beneficial order.
+	 */
+	if (it->beneficial_order && it->order == it->beneficial_order)
+		it->tt->page_flags |= TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED;
+
+	it->order--;
+	it->page_caching = it->tt->caching;
+	it->allow_pools = true;
+
+	return 0;
+}
+
 static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 			    const struct ttm_operation_ctx *ctx,
 			    struct ttm_pool_alloc_state *alloc,
 			    struct ttm_pool_tt_restore *restore)
 {
-	const unsigned int beneficial_order = ttm_pool_beneficial_order(pool);
-	enum ttm_caching page_caching;
+	struct ttm_pool_alloc_iter it = {
+		.pool = pool,
+		.tt = tt,
+		.ctx = ctx,
+		.alloc = alloc,
+		.restore = restore,
+		.beneficial_order = ttm_pool_beneficial_order(pool),
+		.page_caching = tt->caching,
+		.allow_pools = true,
+	};
 	gfp_t gfp_flags = GFP_USER;
 	pgoff_t caching_divide;
-	unsigned int order;
-	bool allow_pools;
-	struct page *p;
 	int r;
 
 	WARN_ON(!alloc->remaining_pages || ttm_tt_is_populated(tt));
@@ -819,59 +903,28 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 	else
 		gfp_flags |= GFP_HIGHUSER;
 
-	page_caching = tt->caching;
-	allow_pools = true;
-	for (order = ttm_pool_alloc_find_order(MAX_PAGE_ORDER, alloc);
+	it.gfp_flags = gfp_flags;
+
+	for (it.order = ttm_pool_alloc_find_order(MAX_PAGE_ORDER, alloc);
 	     alloc->remaining_pages;
-	     order = ttm_pool_alloc_find_order(order, alloc)) {
-		struct ttm_pool_type *pt;
-
-		/* First, try to allocate a page from a pool if one exists. */
-		p = NULL;
-		pt = ttm_pool_select_type(pool, page_caching, order);
-		if (pt && allow_pools)
-			p = ttm_pool_type_take(pt, ttm_pool_nid(pool));
-
-		/*
-		 * If that fails or previously failed, allocate from system.
-		 * Note that this also disallows additional pool allocations using
-		 * write-back cached pools of the same order. Consider removing
-		 * that behaviour.
-		 */
-		if (!p) {
-			page_caching = ttm_cached;
-			allow_pools = false;
-			p = ttm_pool_alloc_page(pool, gfp_flags, order,
-						ctx->beneficial_reclaim_backoff);
-		}
-		/* If that fails, lower the order if possible and retry. */
-		if (!p) {
-			if (order) {
-				/*
-				 * Failing to allocate at the device's beneficial
-				 * order means we are about to back this object
-				 * with a sub-optimal (smaller order) set of
-				 * pages. Record it so the driver can later try to
-				 * defragment the object back to beneficial order.
-				 */
-				if (beneficial_order && order == beneficial_order)
-					tt->page_flags |=
-						TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED;
-				--order;
-				page_caching = tt->caching;
-				allow_pools = true;
-				continue;
-			}
-			r = -ENOMEM;
-			goto error_free_all;
+	     it.order = ttm_pool_alloc_find_order(it.order, alloc)) {
+		/* Acquire a page (pool / system) for this order. */
+		ttm_pool_iter_acquire_page(&it);
+		if (!it.p) {
+			r = ttm_pool_iter_lower_order(&it);
+			if (r)
+				goto error_free_all;
+			continue;
 		}
-		r = ttm_pool_page_allocated(pool, order, p, page_caching, alloc,
-					    restore);
+
+		r = ttm_pool_page_allocated(pool, it.order, it.p,
+					    it.page_caching, alloc, restore);
 		if (r)
 			goto error_free_page;
 
 		if (ttm_pool_restore_valid(restore)) {
-			r = ttm_pool_restore_commit(restore, tt->backup, ctx, alloc);
+			r = ttm_pool_restore_commit(restore, tt->backup, ctx,
+						    alloc);
 			if (r)
 				goto error_free_all;
 		}
@@ -887,7 +940,7 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 	return 0;
 
 error_free_page:
-	ttm_pool_free_page(pool, page_caching, order, p, false);
+	ttm_pool_free_page(pool, it.page_caching, it.order, it.p, false);
 
 error_free_all:
 	if (tt->restore)
-- 
2.34.1

