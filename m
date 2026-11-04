Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8139060A3838
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 20:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cCp9PKgR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA57110FEDA;
	Wed,  4 Nov 2026 20:14:21 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0D9010FEDB;
 Wed,  4 Nov 2026 20:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793823250; x=1825359250;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=F2Uj2LSbH13jweObL0pjBv8mzbOzaX82T2S2b8scX8A=;
 b=cCp9PKgRWRejo1FBzagsUSzFs6DMRnY6iH1P8jg6lT/MafbhQFaqDErM
 BXH3fOhBau58q+xV/Z2uZQcFpRY47lKtuVLmznfQ066oo/pyijNgwkaAh
 Ii6HEHZ+Jy0eFRyGHKFdt2Bkub82eXoY1gG0/d+N0JL498jnpOXhYKLPM
 L9lHWAiOPq9zC0uY4fiHLx5WYLRd1p9oFpEq57h9XGklYaB+XLhlmOsAg
 waUTnP/coY5QxOFLhow+3P/kCMYwec8Noku9+Dr9RazMhmg54TCn2uShT
 Oewz927tRhwtpDCarl97cuFftW7Hq6WHhHaKH1tEly6q4WXJ60gKJjkpI Q==;
X-CSE-ConnectionGUID: BD9Ynd16R520v3jDDbdMQQ==
X-CSE-MsgGUID: aJGj63w7SaWhAGL7TevhBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2589102"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2589102"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 12:14:10 -0800
X-CSE-ConnectionGUID: fvnjpsZwQkO+GtuFPvzv+g==
X-CSE-MsgGUID: Ymq/JOm+TTqZEl2foRAt8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6868494"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO fedora)
 ([10.245.244.20])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 12:14:07 -0800
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Natalie Vock <nat@pixelcluster.dev>,
 Arun Pravin <arunpravin.paneerselvam@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
 dri-devel@lists.freedesktop.org
Subject: [PATCH 4/4] drm/ttm,
 drm/xe: Gate reserve-dipping backup retries on may_writeback
Date: Wed,  4 Nov 2026 21:13:31 +0100
Message-ID: <20261104201331.2462-5-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104201331.2462-1-thomas.hellstrom@linux.intel.com>
References: <20261104201331.2462-1-thomas.hellstrom@linux.intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Backup of a page allocates the shmem destination folio with
__GFP_NOMEMALLOC for high-order pages, to avoid dipping into kernel
memory reserves, but order-0 pages were always backed up without it.
When a high-order allocation fails mid-compound, the compound is split
and the remaining subpages are individually retried at order 0 without
__GFP_NOMEMALLOC.

That retry happened unconditionally, regardless of whether the caller
wanted writeback or could tolerate blocking. Retrying without
writeback only grows dirty shmem rather than relieving the memory
pressure that caused the original failure, and the retry itself may
need to reclaim or block.

Back up all pages with __GFP_NOMEMALLOC first, and add two flags,
may_writeback and force_writeback, to struct ttm_backup_flags,
replacing the single writeback flag:
- may_writeback governs whether a failed backup allocation is retried
  without __GFP_NOMEMALLOC, splitting a high-order page if needed.
  When clear, the backup stops at the failure, keeping whatever
  progress was already made and leaving the remainder resident for a
  later retry.
- force_writeback replaces the old writeback flag and is honoured both
  for the regular backup and for any retry, so a caller that allows the
  retry can also choose to force it to actually complete and relieve
  memory pressure instead of just relocating it.

Thread the two new flags all the way from the xe shrinker down through
xe_bo_shrink_flags and ttm_bo_shrink_flags to ttm_backup_flags.
xe_shrinker_walk() now takes an explicit allow_writeback
parameter (computed once from __GFP_IO and no_wait_gpu in
xe_shrinker_scan()) rather than carrying that gfp-context permission
inside the per-call flags, and uses it to decide, pass by pass, whether
the retry is allowed (may_writeback) and whether it should be
forced to completion (force_writeback).

Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/ttm/ttm_bo_util.c |  3 +-
 drivers/gpu/drm/ttm/ttm_pool.c    | 47 +++++++++++++++++++++----------
 drivers/gpu/drm/xe/xe_bo.c        |  6 ++--
 drivers/gpu/drm/xe/xe_bo.h        |  9 ++++--
 drivers/gpu/drm/xe/xe_shrinker.c  | 39 ++++++++++++++++++++-----
 include/drm/ttm/ttm_bo.h          |  9 ++++--
 include/drm/ttm/ttm_tt.h          | 13 +++++++--
 7 files changed, 93 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
index 975dea33075f..21317c212c27 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_util.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
@@ -1122,7 +1122,8 @@ long ttm_bo_shrink(struct ttm_operation_ctx *ctx, struct ttm_buffer_object *bo,
 
 	lret = ttm_tt_backup(bdev, bo->ttm, (struct ttm_backup_flags)
 			     {.purge = flags.purge,
-			      .writeback = flags.writeback});
+			      .may_writeback = flags.may_writeback,
+			      .force_writeback = flags.force_writeback});
 
 	if (lret > 0 && !ttm_tt_is_partial(bo->ttm)) {
 		spin_lock(&bdev->lru_lock);
diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 8f05257e4f54..87c1ac39af94 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -1158,7 +1158,10 @@ static void ttm_pool_restore_abort(struct ttm_tt *tt)
  * If backup of a page fails for whatever reason, @ttm will still be
  * partially backed up, retaining those pages for which backup fails.
  * In that case, this function can be retried, possibly after freeing up
- * memory resources.
+ * memory resources. In particular, if allocating backup memory fails
+ * without dipping into kernel reserves, and @flags->may_writeback is not
+ * set, the backup stops at that point, also leaving @ttm partially backed
+ * up.
  *
  * Return: Number of pages actually backed up or freed, or negative
  * error code on error.
@@ -1174,6 +1177,7 @@ long ttm_pool_backup(struct ttm_pool *pool, struct ttm_tt *tt,
 	pgoff_t shrunken = 0;
 	pgoff_t i, j, num_pages, npages;
 	pgoff_t nr_backed;
+	bool dip_reserves;
 	bool partial = ttm_tt_is_partial(tt);
 
 	if (WARN_ON(ttm_tt_is_backed_up(tt)))
@@ -1256,7 +1260,9 @@ long ttm_pool_backup(struct ttm_pool *pool, struct ttm_tt *tt,
 	else
 		gfp = GFP_HIGHUSER;
 
-	alloc_gfp = GFP_KERNEL | __GFP_HIGH | __GFP_NOWARN | __GFP_RETRY_MAYFAIL;
+	/* Don't dip into kernel reserves unless @flags->may_writeback is set. */
+	alloc_gfp = GFP_KERNEL | __GFP_HIGH | __GFP_NOWARN |
+		    __GFP_RETRY_MAYFAIL | __GFP_NOMEMALLOC;
 
 	num_pages = tt->num_pages;
 
@@ -1280,14 +1286,7 @@ long ttm_pool_backup(struct ttm_pool *pool, struct ttm_tt *tt,
 		order = ttm_pool_page_order(pool, page);
 		npages = 1UL << order;
 
-		/*
-		 * We don't allow dipping kernel reserves for high order backup
-		 */
-		if (order)
-			alloc_gfp |= __GFP_NOMEMALLOC;
-		else
-			alloc_gfp &= ~__GFP_NOMEMALLOC;
-
+		dip_reserves = false;
 		/*
 		 * Back up the compound atomically at its native order. If
 		 * fault injection truncated num_pages mid-compound, skip
@@ -1296,10 +1295,18 @@ long ttm_pool_backup(struct ttm_pool *pool, struct ttm_tt *tt,
 		if (unlikely(i + npages > num_pages))
 			break;
 
+retry:
 		handle = ttm_backup_backup_folio(backup, page_folio(page),
-						 order, flags->writeback, i,
-						 gfp, alloc_gfp,
-						 &nr_backed);
+						 order, flags->force_writeback, i,
+						 gfp, dip_reserves ?
+						 alloc_gfp & ~__GFP_NOMEMALLOC :
+						 alloc_gfp, &nr_backed);
+		if (unlikely(handle == -ENOMEM && !nr_backed &&
+			     flags->may_writeback && !dip_reserves)) {
+			dip_reserves = true;
+			goto retry;
+		}
+
 		/*
 		 * Zero progress on this compound (whether order 0 or a
 		 * high-order compound that failed before backing up even
@@ -1319,12 +1326,22 @@ long ttm_pool_backup(struct ttm_pool *pool, struct ttm_tt *tt,
 		if (unlikely(nr_backed < npages)) {
 			/*
 			 * Partial OOM backup: split the compound and free the
-			 * subpages whose content is now in shmem. Continue the
-			 * loop from the first un-backed order-0 page.
+			 * subpages whose content is now in shmem.
 			 */
 			ttm_pool_split_for_swap(pool, page);
 			for (j = 0; j < nr_backed; j++)
 				__free_pages_gpu_account(page + j, 0, false);
+
+			if (!flags->may_writeback) {
+				/*
+				 * Leave the remaining subpages as still
+				 * unbacked order-0 pages; the caller may
+				 * retry later.
+				 */
+				break;
+			}
+
+			/* Continue the loop from the first un-backed order-0 page. */
 			npages = nr_backed;
 			continue;
 		}
diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 6907b683dee0..614766eb4b8f 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -1437,7 +1437,6 @@ static long xe_bo_shrink_purge(struct ttm_operation_ctx *ctx,
 	*scanned += old_remaining;
 	lret = ttm_bo_shrink(ctx, bo, (struct ttm_bo_shrink_flags)
 			     {.purge = true,
-			      .writeback = false,
 			      .allow_move = false});
 
 	xe_ttm_tt_account_shrunk(bo->bdev, bo->ttm, old_remaining);
@@ -1526,8 +1525,9 @@ long xe_bo_shrink(struct ttm_operation_ctx *ctx, struct ttm_buffer_object *bo,
 	*scanned += old_remaining;
 	lret = ttm_bo_shrink(ctx, bo, (struct ttm_bo_shrink_flags)
 			     {.purge = false,
-			      .writeback = flags.writeback,
-			      .allow_move = true});
+			      .allow_move = true,
+			      .may_writeback = flags.may_writeback,
+			      .force_writeback = flags.force_writeback});
 	if (needs_rpm)
 		xe_pm_runtime_put(xe);
 
diff --git a/drivers/gpu/drm/xe/xe_bo.h b/drivers/gpu/drm/xe/xe_bo.h
index 77b3a02e9b8e..82cbb1f2d61d 100644
--- a/drivers/gpu/drm/xe/xe_bo.h
+++ b/drivers/gpu/drm/xe/xe_bo.h
@@ -616,11 +616,16 @@ static inline unsigned int xe_sg_segment_size(struct device *dev)
 /**
  * struct xe_bo_shrink_flags - flags governing the shrink behaviour.
  * @purge: Only purging allowed. Don't shrink if bo not purgeable.
- * @writeback: Attempt to immediately move content to swap.
+ * @may_writeback: Allow retrying a failed backup allocation using kernel
+ * reserves. See struct ttm_backup_flags.
+ * @force_writeback: Attempt to immediately move content to swap, both
+ * for the regular backup and for any retry allowed by @may_writeback.
+ * See struct ttm_backup_flags.
  */
 struct xe_bo_shrink_flags {
 	u32 purge : 1;
-	u32 writeback : 1;
+	u32 may_writeback : 1;
+	u32 force_writeback : 1;
 };
 
 long xe_bo_shrink(struct ttm_operation_ctx *ctx, struct ttm_buffer_object *bo,
diff --git a/drivers/gpu/drm/xe/xe_shrinker.c b/drivers/gpu/drm/xe/xe_shrinker.c
index c86455ea08d1..c24f35cbc235 100644
--- a/drivers/gpu/drm/xe/xe_shrinker.c
+++ b/drivers/gpu/drm/xe/xe_shrinker.c
@@ -171,6 +171,7 @@ static int __xe_shrinker_walk(struct xe_shrinker *shrinker,
 static int xe_shrinker_walk(struct xe_shrinker *shrinker,
 			    struct ttm_operation_ctx *ctx,
 			    const struct xe_bo_shrink_flags flags,
+			    bool allow_writeback,
 			    unsigned long to_scan, unsigned long *scanned,
 			    unsigned long *freed)
 {
@@ -179,7 +180,8 @@ static int xe_shrinker_walk(struct xe_shrinker *shrinker,
 	int ret;
 
 	swap(no_wait_gpu, ctx->no_wait_gpu);
-	save_flags.writeback = false;
+	save_flags.may_writeback = false;
+	save_flags.force_writeback = false;
 	ret = __xe_shrinker_walk(shrinker, ctx, save_flags, to_scan, scanned,
 				 freed);
 	swap(no_wait_gpu, ctx->no_wait_gpu);
@@ -187,15 +189,32 @@ static int xe_shrinker_walk(struct xe_shrinker *shrinker,
 		return ret;
 
 	if (!ctx->no_wait_gpu) {
+		/*
+		 * Blocking is now tolerated: allow retrying a failed backup
+		 * allocation using kernel reserves, but only if writeback is
+		 * permitted at all in this gfp context (i.e. __GFP_IO is
+		 * set); see @allow_writeback in xe_shrinker_scan().
+		 */
+		save_flags.may_writeback = allow_writeback;
 		ret = __xe_shrinker_walk(shrinker, ctx, save_flags, to_scan, scanned,
 					 freed);
 		if (ret || *scanned >= to_scan)
 			return ret;
 	}
 
-	if (flags.writeback)
-		ret = __xe_shrinker_walk(shrinker, ctx, flags, to_scan, scanned,
+	if (allow_writeback) {
+		struct xe_bo_shrink_flags wb_flags = flags;
+
+		/*
+		 * Writeback explicitly allowed: also force writeback on any
+		 * retry so it actually relieves memory pressure instead of
+		 * just growing dirty shmem.
+		 */
+		wb_flags.may_writeback = true;
+		wb_flags.force_writeback = true;
+		ret = __xe_shrinker_walk(shrinker, ctx, wb_flags, to_scan, scanned,
 					 freed);
+	}
 
 	return ret;
 }
@@ -297,7 +316,12 @@ static unsigned long xe_shrinker_scan_purgeable(struct shrinker *shrink,
 		.purge = true,
 	};
 
-	xe_shrinker_walk(shrinker, &ctx, shrink_flags, nr_to_scan, &nr_scanned, &freed);
+	/*
+	 * Purging never does backup/writeback, so there's nothing to
+	 * force or gate on __GFP_IO here.
+	 */
+	xe_shrinker_walk(shrinker, &ctx, shrink_flags, false,
+			 nr_to_scan, &nr_scanned, &freed);
 
 	sc->nr_scanned = nr_scanned;
 
@@ -314,15 +338,16 @@ static unsigned long xe_shrinker_scan(struct shrinker *shrink, struct shrink_con
 	unsigned long nr_to_scan = sc->nr_to_scan, nr_scanned = 0, freed = 0;
 	struct xe_bo_shrink_flags shrink_flags = {
 		.purge = false,
-		/* Don't request writeback without __GFP_IO. */
-		.writeback = !ctx.no_wait_gpu && (sc->gfp_mask & __GFP_IO),
 	};
+	/* Don't allow writeback without __GFP_IO. */
+	bool allow_writeback = !ctx.no_wait_gpu && (sc->gfp_mask & __GFP_IO);
 	bool runtime_pm;
 
 	/* Might need runtime PM to access backed-up or CCS-compressed data. */
 	runtime_pm = xe_shrinker_runtime_pm_get(shrinker);
 
-	xe_shrinker_walk(shrinker, &ctx, shrink_flags, nr_to_scan, &nr_scanned, &freed);
+	xe_shrinker_walk(shrinker, &ctx, shrink_flags, allow_writeback,
+			 nr_to_scan, &nr_scanned, &freed);
 
 	sc->nr_scanned = nr_scanned;
 	xe_shrinker_runtime_pm_put(shrinker, runtime_pm);
diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
index 32791c4db2a9..90b4a8aafac3 100644
--- a/include/drm/ttm/ttm_bo.h
+++ b/include/drm/ttm/ttm_bo.h
@@ -249,15 +249,20 @@ s64 ttm_lru_walk_for_evict(struct ttm_lru_walk *walk, struct ttm_device *bdev,
 /**
  * struct ttm_bo_shrink_flags - flags to govern the bo shrinking behaviour
  * @purge: Purge the content rather than backing it up.
- * @writeback: Attempt to immediately write content to swap space.
  * @allow_move: Allow moving to system before shrinking. This is typically
  * not desired for zombie- or ghost objects (with zombie object meaning
  * objects with a zero gem object refcount)
+ * @may_writeback: Allow retrying a failed backup allocation using kernel
+ * reserves. See struct ttm_backup_flags.
+ * @force_writeback: Attempt to immediately write content to swap space,
+ * both for the regular backup and for any retry allowed by
+ * @may_writeback. See struct ttm_backup_flags.
  */
 struct ttm_bo_shrink_flags {
 	u32 purge : 1;
-	u32 writeback : 1;
 	u32 allow_move : 1;
+	u32 may_writeback : 1;
+	u32 force_writeback : 1;
 };
 
 long ttm_bo_shrink(struct ttm_operation_ctx *ctx, struct ttm_buffer_object *bo,
diff --git a/include/drm/ttm/ttm_tt.h b/include/drm/ttm/ttm_tt.h
index c292a8f0583f..811b90f14d54 100644
--- a/include/drm/ttm/ttm_tt.h
+++ b/include/drm/ttm/ttm_tt.h
@@ -315,12 +315,19 @@ unsigned long ttm_tt_pages_limit(void);
 /**
  * struct ttm_backup_flags - Flags to govern backup behaviour.
  * @purge: Free pages without backing up. Bypass pools.
- * @writeback: Attempt to copy contents directly to swap space, even
- * if that means blocking on writes to external memory.
+ * @may_writeback: If allocating backup memory fails without dipping into
+ * kernel reserves, allow retrying with reserves, splitting high-order
+ * pages if needed. If not set, stop the backup at that point, leaving
+ * the remainder resident, since the retry may need to block.
+ * @force_writeback: Attempt to copy contents directly to swap space,
+ * even if that means blocking on writes to external memory. This
+ * applies both to the regular backup and to any retry allowed by
+ * @may_writeback.
  */
 struct ttm_backup_flags {
 	u32 purge : 1;
-	u32 writeback : 1;
+	u32 may_writeback : 1;
+	u32 force_writeback : 1;
 };
 
 long ttm_tt_backup(struct ttm_device *bdev, struct ttm_tt *tt,
-- 
2.56.0

