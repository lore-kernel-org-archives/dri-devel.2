Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4F160A3803
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 20:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=M7fU+zka
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEB8810FEE0;
	Wed,  4 Nov 2026 20:14:13 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69D5410FED9;
 Wed,  4 Nov 2026 20:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793823248; x=1825359248;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Chm8M7EyNpBglLIylQEFRUX99dRMcRUwO9MDs1CnJtc=;
 b=M7fU+zkahUT9CztPHbhfeVtkqbNzJQ/9mctwPrLDy/pKDgogBHmYVQNw
 na4UO1SP+KOwzvbHbLp3qhzjm8pTSjJ3qzssxiAqcwp7FSJJLsN8nuk0l
 W1R5GLy5SWhvdf1F5ohpaLq4cm8jtl5K4t75Xp5QSwuujF/xb0jI47Ndf
 Sla9FN3oGyIpMk053ijdOYQ5s8+WmGUIM+bkBsv9NNcfF/bUBzgAdGYK5
 Au0eFlOHvdgI673SEyHJ7phYqWRtyAbVwUB/szPBJ+n7sgu4eqfv6BN5O
 bZluHUl+5NJs+xA29FAu3qoReKLNEifmUU9tLnfjuUrnyJXfQIqdlJDqb w==;
X-CSE-ConnectionGUID: VlEF0SoLQAC+VIoEjCWkaQ==
X-CSE-MsgGUID: ZQNog0quQL2751STJLroXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2589086"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2589086"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 12:14:08 -0800
X-CSE-ConnectionGUID: SFDVHd0bRh2fLLn46JZi8A==
X-CSE-MsgGUID: z4K77MgGRMWnSnUBq7F64w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6868490"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO fedora)
 ([10.245.244.20])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 12:14:05 -0800
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Natalie Vock <nat@pixelcluster.dev>,
 Arun Pravin <arunpravin.paneerselvam@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
 dri-devel@lists.freedesktop.org
Subject: [PATCH 3/4] drm/ttm,
 drm/xe: Introduce TTM_TT_FLAG_PARTIAL for partially backed-up tts
Date: Wed,  4 Nov 2026 21:13:30 +0100
Message-ID: <20261104201331.2462-4-thomas.hellstrom@linux.intel.com>
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Backup failures can leave a ttm_tt partially backed up: some pages
swapped to shmem while others remain resident. Previously,
ttm_tt_backup() would set TTM_TT_FLAG_BACKED_UP regardless, which
made the resource unevictable and prevented the shrinker from
targeting it for continued backup.

Introduce TTM_TT_FLAG_PARTIAL to distinguish this state. A partial tt:
- Does NOT have PRIV_POPULATED set (it's not fully populated)
- Does NOT have BACKED_UP set (it's not fully backed up)
- Stays on the normal LRU (not unevictable)
- Can be targeted by the shrinker for continued backup
- Must be restored (not plain-allocated) when repopulating

On re-entry, ttm_pool_backup() skips already-backed-up handles and
the caching/DMA setup that was done on the first pass.

Track the number of still-resident pages in ttm_tt::remaining_pages.
ttm_pool_restore_abort() recounts them, since an aborted restore may
leave more pages resident than before. xe accounts shrinker pages of
a partial tt by remaining_pages: shrinking subtracts the change in
remaining_pages rather than tt->num_pages, repopulating adds back only
the pages that were subtracted, and destroying a partial tt subtracts
the pages still resident. A tt stays counted as populated by the
shrinker while it has accounted pages.

If restoring a fully backed-up tt fails after making pages resident,
mark it partial and return the bo to the evictable LRU, so that the
shrinker can reclaim those pages.

xe must treat a partial tt as holding data when moving the bo, so that
moves out of system memory restore it rather than discarding it.

Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/ttm/ttm_bo.c            |   5 +-
 drivers/gpu/drm/ttm/ttm_bo_util.c       |   6 +-
 drivers/gpu/drm/ttm/ttm_pool.c          | 128 ++++++++++++++++++++++--
 drivers/gpu/drm/ttm/ttm_pool_internal.h |   2 +
 drivers/gpu/drm/ttm/ttm_tt.c            |  36 ++++++-
 drivers/gpu/drm/xe/xe_bo.c              |  82 +++++++++++----
 include/drm/ttm/ttm_tt.h                |  45 +++++++--
 7 files changed, 261 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index 53c68e29ebc2..3c2f4297e20a 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -1524,9 +1524,8 @@ int ttm_bo_populate(struct ttm_buffer_object *bo,
 
 	swapped = ttm_tt_is_swapped(tt);
 	ret = ttm_tt_populate(bdev, tt, ctx);
-	if (ret)
-		return ret;
 
+	/* A failed restore may leave the tt partial, hence evictable. */
 	if (swapped && !ttm_tt_is_swapped(tt) && !bo->pin_count &&
 	    bo->resource) {
 		spin_lock(&bdev->lru_lock);
@@ -1535,7 +1534,7 @@ int ttm_bo_populate(struct ttm_buffer_object *bo,
 		spin_unlock(&bdev->lru_lock);
 	}
 
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL(ttm_bo_populate);
 
diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
index f9458a4d5a09..975dea33075f 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_util.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
@@ -1124,7 +1124,7 @@ long ttm_bo_shrink(struct ttm_operation_ctx *ctx, struct ttm_buffer_object *bo,
 			     {.purge = flags.purge,
 			      .writeback = flags.writeback});
 
-	if (lret > 0) {
+	if (lret > 0 && !ttm_tt_is_partial(bo->ttm)) {
 		spin_lock(&bdev->lru_lock);
 		ttm_resource_del_bulk_move_unevictable(bo->resource, bo);
 		ttm_resource_move_to_lru_tail(bo->resource);
@@ -1151,7 +1151,9 @@ EXPORT_SYMBOL(ttm_bo_shrink);
  */
 bool ttm_bo_shrink_suitable(struct ttm_buffer_object *bo, struct ttm_operation_ctx *ctx)
 {
-	return bo->ttm && ttm_tt_is_populated(bo->ttm) && !bo->pin_count &&
+	return bo->ttm &&
+		(ttm_tt_is_populated(bo->ttm) || ttm_tt_is_partial(bo->ttm)) &&
+		!bo->pin_count &&
 		(!ctx->no_wait_gpu ||
 		 dma_resv_test_signaled(bo->base.resv, DMA_RESV_USAGE_BOOKKEEP));
 }
diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 1bf37023fed6..8f05257e4f54 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -628,7 +628,8 @@ static int ttm_pool_restore_commit(struct ttm_pool_tt_restore *restore,
 			 * using clever logic, but ATM we don't care, as
 			 * we prioritize releasing memory ASAP. Note that
 			 * here, the old retained page is always write-back
-			 * cached.
+			 * cached and not DMA-mapped. The commit below
+			 * installs the new page and its DMA address.
 			 */
 			ttm_pool_split_for_swap(restore->pool, p);
 			copy_highpage(restore->alloced_page + i, p);
@@ -895,7 +896,7 @@ int ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 {
 	struct ttm_pool_alloc_state alloc;
 
-	if (WARN_ON(ttm_tt_is_backed_up(tt)))
+	if (WARN_ON(ttm_tt_is_backed_up(tt) || ttm_tt_is_partial(tt)))
 		return -EINVAL;
 
 	ttm_pool_alloc_state_init(tt, &alloc);
@@ -924,7 +925,7 @@ int ttm_pool_restore_and_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 	struct ttm_pool_alloc_state alloc;
 	int ret;
 
-	if (WARN_ON(!ttm_tt_is_backed_up(tt)))
+	if (WARN_ON(!ttm_tt_is_backed_up(tt) && !ttm_tt_is_partial(tt)))
 		return -EINVAL;
 
 	if (!restore) {
@@ -967,6 +968,23 @@ int ttm_pool_restore_and_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 	return __ttm_pool_alloc(pool, tt, ctx, &alloc, restore);
 }
 
+/**
+ * ttm_pool_restore_has_resident() - Whether an interrupted restore has
+ * made pages resident
+ * @tt: The struct ttm_tt.
+ *
+ * Return: true if an interrupted restore of @tt has committed or
+ * restored pages that would be kept on ttm_pool_restore_abort().
+ */
+bool ttm_pool_restore_has_resident(const struct ttm_tt *tt)
+{
+	const struct ttm_pool_tt_restore *restore = tt->restore;
+
+	return restore && (restore->alloced_pages ||
+			   (ttm_pool_restore_valid(restore) &&
+			    restore->restored_pages));
+}
+
 /**
  * ttm_pool_free - Free the backing pages from a ttm_tt object
  *
@@ -1000,7 +1018,7 @@ void ttm_pool_drop_backed_up(struct ttm_tt *tt)
 	struct ttm_pool_tt_restore *restore;
 	pgoff_t start_page = 0;
 
-	WARN_ON(!ttm_tt_is_backed_up(tt));
+	WARN_ON(!ttm_tt_is_backed_up(tt) && !ttm_tt_is_partial(tt));
 
 	restore = tt->restore;
 
@@ -1039,6 +1057,91 @@ void ttm_pool_drop_backed_up(struct ttm_tt *tt)
 	ttm_pool_free_range(NULL, tt, ttm_cached, start_page, tt->num_pages);
 }
 
+/**
+ * ttm_pool_restore_abort() - Abort an ongoing restore of a partial tt
+ * @tt: The struct ttm_tt with an active restore.
+ *
+ * Abort a partially completed restore, leaving the tt in a consistent
+ * state for a subsequent backup. The uncommitted in-flight page is
+ * DMA-unmapped and split; restored sub-pages are kept, unused ones freed.
+ * Non-cached committed pages are converted to write-back so the
+ * partial-backup invariant (all resident pages are cached) is maintained.
+ * Committed pages are left DMA-mapped for the backup path to handle.
+ * Since restored pages are now resident, &ttm_tt.remaining_pages is
+ * updated to reflect the number of resident pages.
+ */
+static void ttm_pool_restore_abort(struct ttm_tt *tt)
+{
+	struct ttm_pool_tt_restore *restore = tt->restore;
+	pgoff_t i, nr, mid;
+
+	if (!restore)
+		return;
+
+	/* Handle the uncommitted in-flight page. */
+	if (ttm_pool_restore_valid(restore)) {
+		struct page *page = restore->alloced_page;
+
+		nr = 1UL << restore->order;
+
+		if (tt->dma_address)
+			ttm_pool_unmap(restore->pool, restore->first_dma, nr);
+
+#ifdef CONFIG_X86
+		if (restore->page_caching != ttm_cached && !PageHighMem(page))
+			set_pages_wb(page, nr);
+#endif
+		ttm_pool_split_for_swap(restore->pool, page);
+
+		for (i = 0; i < restore->restored_pages; i++)
+			restore->snapshot_alloc.pages[i] = page + i;
+
+		/*
+		 * Clear stale DMA addresses for the in-flight sub-pages.
+		 * These pages were never committed via
+		 * ttm_pool_allocated_page_commit(), so tt->dma_address[]
+		 * contains stale values that the backup path would
+		 * incorrectly try to unmap. All @nr entries are stale,
+		 * including restored ones: commit is all-or-nothing per
+		 * compound, and the whole compound was unmapped above.
+		 */
+		if (tt->dma_address) {
+			pgoff_t off = restore->snapshot_alloc.pages -
+				      tt->pages;
+
+			memset(&tt->dma_address[off], 0,
+			       nr * sizeof(*tt->dma_address));
+		}
+
+		for (i = restore->restored_pages; i < nr; i++)
+			__free_pages_gpu_account(page + i, 0, false);
+	}
+
+	/*
+	 * Don't DMA-unmap committed restored pages here; their DMA
+	 * addresses are in tt->dma_address[] and the backup path
+	 * will unmap them.
+	 */
+
+	/* Convert non-cached committed pages to write-back. */
+	mid = restore->snapshot_alloc.caching_divide - tt->pages;
+#ifdef CONFIG_X86
+	if (mid > 0 && tt->caching != ttm_cached)
+		set_pages_array_wb(tt->pages, mid);
+#endif
+
+	kfree(restore);
+	tt->restore = NULL;
+
+	for (i = 0, nr = 0; i < tt->num_pages; i++) {
+		struct page *p = tt->pages[i];
+
+		if (p && !ttm_backup_page_ptr_is_handle(p))
+			nr++;
+	}
+	tt->remaining_pages = nr;
+}
+
 /**
  * ttm_pool_backup() - Back up or purge a struct ttm_tt
  * @pool: The pool used when allocating the struct ttm_tt.
@@ -1071,10 +1174,13 @@ long ttm_pool_backup(struct ttm_pool *pool, struct ttm_tt *tt,
 	pgoff_t shrunken = 0;
 	pgoff_t i, j, num_pages, npages;
 	pgoff_t nr_backed;
+	bool partial = ttm_tt_is_partial(tt);
 
 	if (WARN_ON(ttm_tt_is_backed_up(tt)))
 		return -EINVAL;
 
+	ttm_pool_restore_abort(tt);
+
 	if ((!ttm_backup_bytes_avail() && !flags->purge) ||
 	    ttm_pool_uses_dma_alloc(pool) || ttm_tt_is_backed_up(tt))
 		return -EBUSY;
@@ -1082,8 +1188,9 @@ long ttm_pool_backup(struct ttm_pool *pool, struct ttm_tt *tt,
 #ifdef CONFIG_X86
 	/* Anything returned to the system needs to be cached. Walk allocations
 	 * skipping NULL pages and issue set_pages_array_wb() per contiguous run.
+	 * Resident pages of a partial tt are already cached.
 	 */
-	if (tt->caching != ttm_cached) {
+	if (!partial && tt->caching != ttm_cached) {
 		pgoff_t run_start = 0, run_count = 0;
 
 		for (i = 0; i < tt->num_pages; i += num_pages) {
@@ -1119,9 +1226,18 @@ long ttm_pool_backup(struct ttm_pool *pool, struct ttm_tt *tt,
 
 			order = ttm_pool_page_order(pool, page);
 			num_pages = 1UL << order;
-			if (tt->dma_address)
+			if (tt->dma_address && tt->dma_address[i]) {
 				ttm_pool_unmap(pool, tt->dma_address[i],
 					       num_pages);
+				/*
+				 * Don't unmap again on partial re-entry.
+				 * Pages left resident are never re-mapped;
+				 * restore copies them into newly mapped
+				 * pages.
+				 */
+				memset(&tt->dma_address[i], 0,
+				       num_pages * sizeof(*tt->dma_address));
+			}
 			if (flags->purge) {
 				shrunken += num_pages;
 				page->private = 0;
diff --git a/drivers/gpu/drm/ttm/ttm_pool_internal.h b/drivers/gpu/drm/ttm/ttm_pool_internal.h
index cbb17a2129fe..3f4f70037c39 100644
--- a/drivers/gpu/drm/ttm/ttm_pool_internal.h
+++ b/drivers/gpu/drm/ttm/ttm_pool_internal.h
@@ -30,4 +30,6 @@ static inline unsigned int ttm_pool_beneficial_order(struct ttm_pool *pool)
  */
 bool ttm_backup_fault_inject_folio(void);
 
+bool ttm_pool_restore_has_resident(const struct ttm_tt *tt);
+
 #endif
diff --git a/drivers/gpu/drm/ttm/ttm_tt.c b/drivers/gpu/drm/ttm/ttm_tt.c
index b645a1818184..2b441bf41d92 100644
--- a/drivers/gpu/drm/ttm/ttm_tt.c
+++ b/drivers/gpu/drm/ttm/ttm_tt.c
@@ -188,7 +188,7 @@ void ttm_tt_fini(struct ttm_tt *ttm)
 		fput(ttm->swap_storage);
 	ttm->swap_storage = NULL;
 
-	if (ttm_tt_is_backed_up(ttm))
+	if (ttm_tt_is_backed_up(ttm) || ttm_tt_is_partial(ttm))
 		ttm_pool_drop_backed_up(ttm);
 	if (ttm->backup) {
 		ttm_backup_fini(ttm->backup);
@@ -289,7 +289,18 @@ long ttm_tt_backup(struct ttm_device *bdev, struct ttm_tt *tt,
 	ret = ttm_pool_backup(&bdev->pool, tt, &flags);
 	if (ret > 0) {
 		tt->page_flags &= ~TTM_TT_FLAG_PRIV_POPULATED;
-		tt->page_flags |= TTM_TT_FLAG_BACKED_UP;
+		if (ret >= tt->remaining_pages)
+			tt->remaining_pages = 0;
+		else
+			tt->remaining_pages -= ret;
+
+		if (tt->remaining_pages) {
+			tt->page_flags &= ~TTM_TT_FLAG_BACKED_UP;
+			tt->page_flags |= TTM_TT_FLAG_PARTIAL;
+		} else {
+			tt->page_flags &= ~TTM_TT_FLAG_PARTIAL;
+			tt->page_flags |= TTM_TT_FLAG_BACKED_UP;
+		}
 	}
 
 	return ret;
@@ -300,10 +311,20 @@ int ttm_tt_restore(struct ttm_device *bdev, struct ttm_tt *tt,
 {
 	int ret = ttm_pool_restore_and_alloc(&bdev->pool, tt, ctx);
 
-	if (ret)
+	if (ret) {
+		/*
+		 * Let the shrinker reclaim pages made resident by the
+		 * failed restore. remaining_pages is recounted on backup.
+		 */
+		if (ttm_tt_is_backed_up(tt) &&
+		    ttm_pool_restore_has_resident(tt)) {
+			tt->page_flags &= ~TTM_TT_FLAG_BACKED_UP;
+			tt->page_flags |= TTM_TT_FLAG_PARTIAL;
+		}
 		return ret;
+	}
 
-	tt->page_flags &= ~TTM_TT_FLAG_BACKED_UP;
+	tt->page_flags &= ~(TTM_TT_FLAG_BACKED_UP | TTM_TT_FLAG_PARTIAL);
 
 	return 0;
 }
@@ -404,7 +425,12 @@ int ttm_tt_populate(struct ttm_device *bdev,
 		goto error;
 
 	ttm->page_flags |= TTM_TT_FLAG_PRIV_POPULATED;
-	ttm->page_flags &= ~TTM_TT_FLAG_BACKED_UP;
+	ttm->page_flags &= ~(TTM_TT_FLAG_BACKED_UP | TTM_TT_FLAG_PARTIAL);
+	/*
+	 * Only updated on success. If a restore fails, remaining_pages
+	 * goes stale until ttm_pool_restore_abort() recounts it.
+	 */
+	ttm->remaining_pages = ttm->num_pages;
 	if (unlikely(ttm->page_flags & TTM_TT_FLAG_SWAPPED)) {
 		ret = ttm_tt_swapin(ttm);
 		if (unlikely(ret != 0)) {
diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 2afee1a6de66..6907b683dee0 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -583,6 +583,26 @@ static void update_global_total_pages(struct ttm_device *ttm_dev,
 #endif
 }
 
+/*
+ * Account for the change in resident pages of @tt after a shrink or purge
+ * attempt. Note that the resident page count may also increase if a
+ * previously interrupted restore was aborted.
+ */
+static void xe_ttm_tt_account_shrunk(struct ttm_device *ttm_dev,
+				     struct ttm_tt *tt, pgoff_t old_remaining)
+{
+	pgoff_t new_remaining = ttm_tt_remaining_pages(tt);
+	long shrunk = (long)old_remaining - (long)new_remaining;
+
+	if (!shrunk)
+		return;
+
+	/* A tt is counted in populated_tts while it has accounted pages. */
+	xe_ttm_tt_account_subtract(ttm_to_xe_device(ttm_dev), tt, shrunk,
+				   !!old_remaining - !!new_remaining);
+	update_global_total_pages(ttm_dev, -shrunk);
+}
+
 static struct ttm_tt *xe_ttm_tt_create(struct ttm_buffer_object *ttm_bo,
 				       u32 page_flags)
 {
@@ -676,20 +696,35 @@ static int xe_ttm_tt_populate(struct ttm_device *ttm_dev, struct ttm_tt *tt,
 	    !(tt->page_flags & TTM_TT_FLAG_EXTERNAL_MAPPABLE))
 		return 0;
 
-	if (ttm_tt_is_backed_up(tt) && !xe_tt->purgeable) {
+	/*
+	 * A purgeable backed-up tt was purged and holds neither pages nor
+	 * handles. Partial tts are never purgeable: madvise only marks
+	 * populated tts purgeable, and the shrinker purges those fully.
+	 */
+	if ((ttm_tt_is_backed_up(tt) || ttm_tt_is_partial(tt)) &&
+	    !xe_tt->purgeable) {
+		pgoff_t remaining = ttm_tt_remaining_pages(tt);
+		long backed_up_pages = tt->num_pages - remaining;
+
 		err = ttm_tt_restore(ttm_dev, tt, ctx);
+		if (!err) {
+			xe_tt->purgeable = false;
+			xe_ttm_tt_account_add(ttm_to_xe_device(ttm_dev), tt,
+					      backed_up_pages, !remaining);
+			update_global_total_pages(ttm_dev, backed_up_pages);
+		}
 	} else {
 		ttm_tt_clear_backed_up(tt);
 		err = ttm_pool_alloc(&ttm_dev->pool, tt, ctx);
+		if (!err) {
+			xe_tt->purgeable = false;
+			xe_ttm_tt_account_add(ttm_to_xe_device(ttm_dev), tt,
+					      tt->num_pages, 1);
+			update_global_total_pages(ttm_dev, tt->num_pages);
+		}
 	}
-	if (err)
-		return err;
 
-	xe_tt->purgeable = false;
-	xe_ttm_tt_account_add(ttm_to_xe_device(ttm_dev), tt, tt->num_pages, 1);
-	update_global_total_pages(ttm_dev, tt->num_pages);
-
-	return 0;
+	return err;
 }
 
 static void xe_ttm_tt_unpopulate(struct ttm_device *ttm_dev, struct ttm_tt *tt)
@@ -709,6 +744,15 @@ static void xe_ttm_tt_unpopulate(struct ttm_device *ttm_dev, struct ttm_tt *tt)
 
 static void xe_ttm_tt_destroy(struct ttm_device *ttm_dev, struct ttm_tt *tt)
 {
+	/* Resident pages of a partially backed-up tt are still accounted. */
+	if (ttm_tt_is_partial(tt)) {
+		long remaining = ttm_tt_remaining_pages(tt);
+
+		xe_ttm_tt_account_subtract(ttm_to_xe_device(ttm_dev), tt,
+					   remaining, !!remaining);
+		update_global_total_pages(ttm_dev, -remaining);
+	}
+
 	ttm_tt_fini(tt);
 	kfree(tt);
 }
@@ -1167,7 +1211,8 @@ static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
 		return ret;
 	}
 
-	tt_has_data = ttm && (ttm_tt_is_populated(ttm) || ttm_tt_is_swapped(ttm));
+	tt_has_data = ttm && (ttm_tt_is_populated(ttm) || ttm_tt_is_swapped(ttm) ||
+			      ttm_tt_is_partial(ttm));
 
 	move_lacks_source = !old_mem || (handle_system_ccs ? (!bo->ccs_cleared) :
 					 (!mem_type_is_vram(old_mem_type) && !tt_has_data));
@@ -1369,7 +1414,7 @@ static long xe_bo_shrink_purge(struct ttm_operation_ctx *ctx,
 			       unsigned long *scanned)
 {
 	struct xe_device *xe = ttm_to_xe_device(bo->bdev);
-	struct ttm_tt *tt = bo->ttm;
+	pgoff_t old_remaining;
 	long lret;
 
 	/* Fake move to system, without copying data. */
@@ -1388,16 +1433,14 @@ static long xe_bo_shrink_purge(struct ttm_operation_ctx *ctx,
 		ttm_bo_move_null(bo, new_resource);
 	}
 
-	*scanned += bo->ttm->num_pages;
+	old_remaining = ttm_tt_remaining_pages(bo->ttm);
+	*scanned += old_remaining;
 	lret = ttm_bo_shrink(ctx, bo, (struct ttm_bo_shrink_flags)
 			     {.purge = true,
 			      .writeback = false,
 			      .allow_move = false});
 
-	if (lret > 0) {
-		xe_ttm_tt_account_subtract(xe, bo->ttm, bo->ttm->num_pages, 1);
-		update_global_total_pages(bo->bdev, -(long)tt->num_pages);
-	}
+	xe_ttm_tt_account_shrunk(bo->bdev, bo->ttm, old_remaining);
 
 	return lret;
 }
@@ -1448,6 +1491,7 @@ long xe_bo_shrink(struct ttm_operation_ctx *ctx, struct ttm_buffer_object *bo,
 	struct ttm_place place = {.mem_type = bo->resource->mem_type};
 	struct xe_bo *xe_bo = ttm_to_xe_bo(bo);
 	struct xe_device *xe = ttm_to_xe_device(bo->bdev);
+	pgoff_t old_remaining;
 	bool needs_rpm;
 	long lret = 0L;
 
@@ -1478,7 +1522,8 @@ long xe_bo_shrink(struct ttm_operation_ctx *ctx, struct ttm_buffer_object *bo,
 	if (needs_rpm && !xe_pm_runtime_get_if_active(xe))
 		goto out_unref;
 
-	*scanned += tt->num_pages;
+	old_remaining = ttm_tt_remaining_pages(tt);
+	*scanned += old_remaining;
 	lret = ttm_bo_shrink(ctx, bo, (struct ttm_bo_shrink_flags)
 			     {.purge = false,
 			      .writeback = flags.writeback,
@@ -1486,10 +1531,7 @@ long xe_bo_shrink(struct ttm_operation_ctx *ctx, struct ttm_buffer_object *bo,
 	if (needs_rpm)
 		xe_pm_runtime_put(xe);
 
-	if (lret > 0) {
-		xe_ttm_tt_account_subtract(xe, tt, tt->num_pages, 1);
-		update_global_total_pages(bo->bdev, -(long)tt->num_pages);
-	}
+	xe_ttm_tt_account_shrunk(bo->bdev, tt, old_remaining);
 
 out_unref:
 	xe_bo_put(xe_bo);
diff --git a/include/drm/ttm/ttm_tt.h b/include/drm/ttm/ttm_tt.h
index 406437ad674b..c292a8f0583f 100644
--- a/include/drm/ttm/ttm_tt.h
+++ b/include/drm/ttm/ttm_tt.h
@@ -88,7 +88,13 @@ struct ttm_tt {
 	 * used to assure pgprot always matches.
 	 *
 	 * TTM_TT_FLAG_BACKED_UP: TTM internal only. This is set if the
-	 * struct ttm_tt has been (possibly partially) backed up.
+	 * struct ttm_tt has been fully backed up.
+	 *
+	 * TTM_TT_FLAG_PARTIAL: TTM internal only. This is set if the
+	 * struct ttm_tt has been partially backed up, meaning some pages
+	 * have been swapped to the backup but some real pages remain.
+	 * Unlike BACKED_UP, a partial tt stays on the normal LRU and
+	 * can be targeted for continued backup.
 	 *
 	 * TTM_TT_FLAG_PRIV_POPULATED: TTM internal only. DO NOT USE. This is
 	 * set by TTM after ttm_tt_populate() has successfully returned, and is
@@ -101,11 +107,14 @@ struct ttm_tt {
 #define TTM_TT_FLAG_EXTERNAL_MAPPABLE	BIT(3)
 #define TTM_TT_FLAG_DECRYPTED		BIT(4)
 #define TTM_TT_FLAG_BACKED_UP	        BIT(5)
+#define TTM_TT_FLAG_PARTIAL		BIT(6)
 
-#define TTM_TT_FLAG_PRIV_POPULATED	BIT(6)
+#define TTM_TT_FLAG_PRIV_POPULATED	BIT(7)
 	uint32_t page_flags;
 	/** @num_pages: Number of pages in the page array. */
 	uint32_t num_pages;
+	/** @remaining_pages: Number of resident (non-backed-up) pages. */
+	pgoff_t remaining_pages;
 	/** @sg: for SG objects via dma-buf. */
 	struct sg_table *sg;
 	/** @dma_address: The DMA (bus) addresses of the pages. */
@@ -157,10 +166,10 @@ static inline bool ttm_tt_is_swapped(const struct ttm_tt *tt)
 }
 
 /**
- * ttm_tt_is_backed_up() - Whether the ttm_tt backed up
+ * ttm_tt_is_backed_up() - Whether the ttm_tt is fully backed up
  * @tt: The struct ttm_tt.
  *
- * Return: true if swapped or backed up, false otherwise.
+ * Return: true if fully backed up, false otherwise.
  */
 static inline bool ttm_tt_is_backed_up(const struct ttm_tt *tt)
 {
@@ -168,15 +177,37 @@ static inline bool ttm_tt_is_backed_up(const struct ttm_tt *tt)
 }
 
 /**
- * ttm_tt_clear_backed_up() - Clear the ttm_tt backed-up status
+ * ttm_tt_is_partial() - Whether the ttm_tt is partially backed up
+ * @tt: The struct ttm_tt.
+ *
+ * Return: true if partially backed up, false otherwise.
+ */
+static inline bool ttm_tt_is_partial(const struct ttm_tt *tt)
+{
+	return tt->page_flags & TTM_TT_FLAG_PARTIAL;
+}
+
+/**
+ * ttm_tt_remaining_pages() - Remaining non-backed-up pages
+ * @tt: The struct ttm_tt.
+ *
+ * Return: The number of pages that are still resident and not backed up.
+ */
+static inline pgoff_t ttm_tt_remaining_pages(const struct ttm_tt *tt)
+{
+	return tt->remaining_pages;
+}
+
+/**
+ * ttm_tt_clear_backed_up() - Clear the ttm_tt backed-up and partial status
  * @tt: The struct ttm_tt.
  *
- * Drivers can use this functionto clear the backed-up status,
+ * Drivers can use this function to clear the backed-up status,
  * for example before destroying or re-validating a purged tt.
  */
 static inline void ttm_tt_clear_backed_up(struct ttm_tt *tt)
 {
-	tt->page_flags &= ~TTM_TT_FLAG_BACKED_UP;
+	tt->page_flags &= ~(TTM_TT_FLAG_BACKED_UP | TTM_TT_FLAG_PARTIAL);
 }
 
 /**
-- 
2.56.0

