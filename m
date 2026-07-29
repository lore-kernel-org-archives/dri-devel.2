Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1CF8C54F51
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 13:00:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FCBD10EC03;
	Wed, 29 Jul 2026 13:00:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VQ9b5kuB";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0D7F10E43A
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 13:00:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1A21443AFE;
 Wed, 29 Jul 2026 13:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72AAD1F00A3A;
 Wed, 29 Jul 2026 13:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1785330024;
 bh=uhz+J/YxxTD8IcItdB4CggtV+vA3SxdDFa9uBHDaSis=;
 h=Subject:To:Cc:From:Date;
 b=VQ9b5kuBzQRjtdd3yO1M8gVNbh46W3g2xSIyon8qtsoIiR0MZm3g7w3Q5Pj01GRPR
 lPW+aQv9gQZbuEAshax2L/9ZZlVE/RwcEYuX+ut4yqMg0y5uL20LlR5XvRbmu5inY3
 9YrEvJoqS6RBtlsrcss0oh936oxMmeLJ4H8LLPFU=
Subject: Patch "drm/ttm/pool: back up at native page order" has been added to
 the 7.1-stable tree
To: airlied@gmail.com, christian.koenig@amd.com,
 dri-devel@lists.freedesktop.org, gregkh@linuxfoundation.org,
 maarten.lankhorst@linux.intel.com, matthew.auld@intel.com,
 matthew.brost@intel.com, mripard@kernel.org, ray.huang@amd.com,
 simona@ffwll.ch, thomas.hellstrom@linux.intel.com, tzimmermann@suse.de
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 14:56:08 +0200
Message-ID: <2026072908-huddle-rewrite-c35c@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 
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


This is a note to let you know that I've just added the patch titled

    drm/ttm/pool: back up at native page order

to the 7.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     drm-ttm-pool-back-up-at-native-page-order.patch
and it can be found in the queue-7.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From a3fdf74ffa5966e5b4a17f1e9c5687f73bb0d536 Mon Sep 17 00:00:00 2001
From: Matthew Brost <matthew.brost@intel.com>
Date: Thu, 16 Jul 2026 13:13:58 -0700
Subject: drm/ttm/pool: back up at native page order
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Matthew Brost <matthew.brost@intel.com>

commit a3fdf74ffa5966e5b4a17f1e9c5687f73bb0d536 upstream.

ttm_pool_split_for_swap() unconditionally splits high-order pool pages
into order-0 pages before backup, so every compound the shrinker
touches is shattered even when the rest of the system would prefer it
stay intact. Under sustained kswapd pressure this fragments memory
enough to drive other parts of MM into recovery loops.

Back up each compound at its native order instead. In
ttm_pool_backup(), hand the full compound to the new
ttm_backup_backup_folio(), which backs up subpages to a contiguous
range of shmem indices and returns the base handle plus the number of
subpages actually backed up (@nr_backed). On full success, free the
compound once at its native order -- no split_page(), no per-4K
refcount juggling.

A per-folio backup can't be made fully atomic under memory pressure:
ttm_backup_backup_folio() must allocate shmem folios before source
subpages can be released, so under true OOM any subpage may fail
while the rest of the compound is still live. Two mechanisms handle
this without regressing reclaim behaviour:

  - alloc_gfp gets __GFP_NOMEMALLOC whenever order > 0 (cleared again
    for order-0), so a high-order backup fails fast with -ENOMEM
    instead of draining kernel reserves, leaving them for other
    allocations under the same pressure.

  - If ttm_backup_backup_folio() still returns a short @nr_backed with
    a valid handle for the successfully-backed prefix, split the
    source compound with ttm_pool_split_for_swap(), free the prefix as
    order-0 pages (already safely in shmem), and retry the remaining
    subpages at order 0, where __GFP_NOMEMALLOC is cleared and
    reserves may be used as a last resort.

This preserves the original split-on-OOM fallback while keeping the
common case fragmentation-free, and preserves the "partial backup is
allowed" contract (shrunken is incremented per subpage backed up).

The restore-side leftover-page split in ttm_pool_restore_commit() is
left as-is: it's unreachable in practice and not worth complicating
the restore state machine to avoid.

Testing: the existing backup_fault_inject point only truncated
tt->num_pages, which never exercised the reactive split path above
since it never left a compound partially backed up. Wire fault
injection into ttm_backup_backup_folio() itself: past the first
subpage of a compound, synthesize a -ENOMEM in place of
shmem_read_folio_gfp() when should_fail() trips, producing the same
short @nr_pages_backed a real failure would and forcing
ttm_pool_backup() through the split-and-retry path. The fault_attr
stays private to ttm_pool.c; ttm_backup.c reaches it through
ttm_backup_fault_inject_folio(), declared in ttm_pool_internal.h.

While converting the writeback branch to operate on the whole folio,
the unlock condition after shmem_writeout() also changed from `if
(ret)` to `if (ret == AOP_WRITEPAGE_ACTIVATE)`, matching the actual
contract: shmem_writeout()/swap_writeout() only leave the folio locked
when returning AOP_WRITEPAGE_ACTIVATE; any other return (including a
hard error from arch_prepare_to_swap()) means the folio was already
unlocked internally. The old `if (ret)` check would have double-
unlocked in that hard-error case.

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
Cc: stable@vger.kernel.org
Fixes: b63d715b8090 ("drm/ttm/pool, drm/ttm/tt: Provide a helper to shrink pages")
Suggested-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Link: https://patch.msgid.link/20260716201358.4086085-1-matthew.brost@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/ttm/ttm_backup.c        |  127 +++++++++++++++++++++-----------
 drivers/gpu/drm/ttm/ttm_pool.c          |   89 ++++++++++++++++++----
 drivers/gpu/drm/ttm/ttm_pool_internal.h |    8 ++
 include/drm/ttm/ttm_backup.h            |   12 +--
 4 files changed, 172 insertions(+), 64 deletions(-)

--- a/drivers/gpu/drm/ttm/ttm_backup.c
+++ b/drivers/gpu/drm/ttm/ttm_backup.c
@@ -6,9 +6,10 @@
 #include <drm/ttm/ttm_backup.h>
 
 #include <linux/export.h>
-#include <linux/page-flags.h>
 #include <linux/swap.h>
 
+#include "ttm_pool_internal.h"
+
 /*
  * Need to map shmem indices to handle since a handle value
  * of 0 means error, following the swp_entry_t convention.
@@ -68,17 +69,23 @@ int ttm_backup_copy_page(struct file *ba
 }
 
 /**
- * ttm_backup_backup_page() - Backup a page
+ * ttm_backup_backup_folio() - Backup a folio
  * @backup: The struct backup pointer to use.
- * @page: The page to back up.
- * @writeback: Whether to perform immediate writeback of the page.
+ * @folio: The folio to back up.
+ * @order: The allocation order of @folio.  Since TTM allocates higher-order
+ *         pages without __GFP_COMP, folio_nr_pages(@folio) would always
+ *         return 1; the caller must pass the true order explicitly.
+ * @writeback: Whether to perform immediate writeback of the folio's pages.
  * This may have performance implications.
- * @idx: A unique integer for each page and each struct backup.
+ * @idx: A unique integer for the first page of the folio and each struct backup.
  * This allows the backup implementation to avoid managing
  * its address space separately.
- * @page_gfp: The gfp value used when the page was allocated.
- * This is used for accounting purposes.
+ * @folio_gfp: The gfp value used when the folio was allocated.
+ * Currently unused.
  * @alloc_gfp: The gfp to be used when allocating memory.
+ * @nr_pages_backed: Output. On a successful return, set to the number of
+ * pages actually backed up, which may be less than (1 << @order)
+ * if an -ENOMEM was encountered mid-folio.
  *
  * Context: If called from reclaim context, the caller needs to
  * assert that the shrinker gfp has __GFP_FS set, to avoid
@@ -87,53 +94,87 @@ int ttm_backup_copy_page(struct file *ba
  * that the shrinker gfp has __GFP_IO set, since without it,
  * we're not allowed to start backup IO.
  *
- * Return: A handle on success. Negative error code on failure.
- *
- * Note: This function could be extended to back up a folio and
- * implementations would then split the folio internally if needed.
- * Drawback is that the caller would then have to keep track of
- * the folio size- and usage.
+ * Return: A handle for the first backed-up page on success (handles for
+ * subsequent pages follow sequentially). -ENOMEM if no pages could be backed
+ * up. Any other negative error code if a non-ENOMEM failure occurred; in that
+ * case any pages backed up so far are truncated before returning.
  */
 s64
-ttm_backup_backup_page(struct file *backup, struct page *page,
-		       bool writeback, pgoff_t idx, gfp_t page_gfp,
-		       gfp_t alloc_gfp)
+ttm_backup_backup_folio(struct file *backup, struct folio *folio,
+			unsigned int order, bool writeback, pgoff_t idx,
+			gfp_t folio_gfp, gfp_t alloc_gfp,
+			pgoff_t *nr_pages_backed)
 {
 	struct address_space *mapping = backup->f_mapping;
-	unsigned long handle = 0;
+	int nr_pages = 1 << order;
 	struct folio *to_folio;
-	int ret;
+	int ret, i;
+
+	*nr_pages_backed = 0;
+
+	for (i = 0; i < nr_pages; ) {
+		int to_nr, j;
 
-	to_folio = shmem_read_folio_gfp(mapping, idx, alloc_gfp);
-	if (IS_ERR(to_folio))
-		return PTR_ERR(to_folio);
-
-	folio_mark_accessed(to_folio);
-	folio_lock(to_folio);
-	folio_mark_dirty(to_folio);
-	copy_highpage(folio_file_page(to_folio, idx), page);
-	handle = ttm_backup_shmem_idx_to_handle(idx);
-
-	if (writeback && !folio_mapped(to_folio) &&
-	    folio_clear_dirty_for_io(to_folio)) {
-		folio_set_reclaim(to_folio);
-		ret = shmem_writeout(to_folio, NULL, NULL);
-		if (!folio_test_writeback(to_folio))
-			folio_clear_reclaim(to_folio);
 		/*
-		 * If writeout succeeds, it unlocks the folio.	errors
-		 * are otherwise dropped, since writeout is only best
-		 * effort here.
+		 * Only inject past the first subpage so *nr_pages_backed is
+		 * always > 0 here, matching a genuine mid-compound -ENOMEM
+		 * and driving the caller's reactive split fallback instead
+		 * of an early, no-progress failure.
 		 */
-		if (ret)
+		if (IS_ENABLED(CONFIG_FAULT_INJECTION) && i &&
+		    ttm_backup_fault_inject_folio())
+			to_folio = ERR_PTR(-ENOMEM);
+		else
+			to_folio = shmem_read_folio_gfp(mapping, idx + i, alloc_gfp);
+		if (IS_ERR(to_folio)) {
+			int err = PTR_ERR(to_folio);
+
+			if (err == -ENOMEM && *nr_pages_backed)
+				return ttm_backup_shmem_idx_to_handle(idx);
+
+			if (*nr_pages_backed) {
+				shmem_truncate_range(file_inode(backup),
+						     (loff_t)idx << PAGE_SHIFT,
+						     ((loff_t)(idx + i) << PAGE_SHIFT) - 1);
+				/*
+				 * The pages just truncated are no longer
+				 * backed up; don't let the caller mistake
+				 * them for valid handles.
+				 */
+				*nr_pages_backed = 0;
+			}
+			return err;
+		}
+
+		to_nr = min_t(int, nr_pages - i,
+			      folio_next_index(to_folio) - (idx + i));
+
+		folio_mark_accessed(to_folio);
+		folio_lock(to_folio);
+		folio_mark_dirty(to_folio);
+
+		for (j = 0; j < to_nr; j++)
+			copy_highpage(folio_file_page(to_folio, idx + i + j),
+				      folio_page(folio, i + j));
+
+		if (writeback && !folio_mapped(to_folio) &&
+		    folio_clear_dirty_for_io(to_folio)) {
+			folio_set_reclaim(to_folio);
+			ret = shmem_writeout(to_folio, NULL, NULL);
+			if (!folio_test_writeback(to_folio))
+				folio_clear_reclaim(to_folio);
+			if (ret == AOP_WRITEPAGE_ACTIVATE)
+				folio_unlock(to_folio);
+		} else {
 			folio_unlock(to_folio);
-	} else {
-		folio_unlock(to_folio);
-	}
+		}
 
-	folio_put(to_folio);
+		folio_put(to_folio);
+		i += to_nr;
+		*nr_pages_backed = i;
+	}
 
-	return handle;
+	return ttm_backup_shmem_idx_to_handle(idx);
 }
 
 /**
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -53,8 +53,23 @@
 #ifdef CONFIG_FAULT_INJECTION
 #include <linux/fault-inject.h>
 static DECLARE_FAULT_ATTR(backup_fault_inject);
+
+/*
+ * Exposed to ttm_backup.c so a mid-compound subpage can be made to fail
+ * with -ENOMEM, exercising the reactive split-and-retry fallback in
+ * ttm_pool_backup() for high-order backups.
+ */
+bool ttm_backup_fault_inject_folio(void)
+{
+	return should_fail(&backup_fault_inject, 1);
+}
 #else
 #define should_fail(...) false
+
+bool ttm_backup_fault_inject_folio(void)
+{
+	return false;
+}
 #endif
 
 /**
@@ -487,7 +502,7 @@ static void ttm_pool_split_for_swap(stru
 /**
  * DOC: Partial backup and restoration of a struct ttm_tt.
  *
- * Swapout using ttm_backup_backup_page() and swapin using
+ * Swapout using ttm_backup_backup_folio() and swapin using
  * ttm_backup_copy_page() may fail.
  * The former most likely due to lack of swap-space or memory, the latter due
  * to lack of memory or because of signal interruption during waits.
@@ -1036,12 +1051,12 @@ long ttm_pool_backup(struct ttm_pool *po
 {
 	struct file *backup = tt->backup;
 	struct page *page;
-	unsigned long handle;
 	gfp_t alloc_gfp;
 	gfp_t gfp;
 	int ret = 0;
 	pgoff_t shrunken = 0;
-	pgoff_t i, num_pages;
+	pgoff_t i, j, num_pages, npages;
+	pgoff_t nr_backed;
 
 	if (WARN_ON(ttm_tt_is_backed_up(tt)))
 		return -EINVAL;
@@ -1119,9 +1134,11 @@ long ttm_pool_backup(struct ttm_pool *po
 	if (IS_ENABLED(CONFIG_FAULT_INJECTION) && should_fail(&backup_fault_inject, 1))
 		num_pages = DIV_ROUND_UP(num_pages, 2);
 
-	for (i = 0; i < num_pages; ++i) {
-		s64 shandle;
+	for (i = 0; i < num_pages; i += npages) {
+		unsigned int order;
+		s64 handle;
 
+		npages = 1;
 		page = tt->pages[i];
 		if (unlikely(!page))
 			continue;
@@ -1130,19 +1147,61 @@ long ttm_pool_backup(struct ttm_pool *po
 		if (unlikely(ttm_backup_page_ptr_is_handle(page)))
 			continue;
 
-		ttm_pool_split_for_swap(pool, page);
+		order = ttm_pool_page_order(pool, page);
+		npages = 1UL << order;
+
+		/*
+		 * We don't allow dipping kernel reserves for high order backup
+		 */
+		if (order)
+			alloc_gfp |= __GFP_NOMEMALLOC;
+		else
+			alloc_gfp &= ~__GFP_NOMEMALLOC;
+
+		/*
+		 * Back up the compound atomically at its native order. If
+		 * fault injection truncated num_pages mid-compound, skip
+		 * the partial tail rather than splitting.
+		 */
+		if (unlikely(i + npages > num_pages))
+			break;
 
-		shandle = ttm_backup_backup_page(backup, page, flags->writeback, i,
-						 gfp, alloc_gfp);
-		if (shandle < 0) {
-			/* We allow partially shrunken tts */
-			ret = shandle;
+		handle = ttm_backup_backup_folio(backup, page_folio(page),
+						 order, flags->writeback, i,
+						 gfp, alloc_gfp,
+						 &nr_backed);
+		/*
+		 * Zero progress on this compound (whether order 0 or a
+		 * high-order compound that failed before backing up even
+		 * its first subpage) is unrecoverable: bail out rather than
+		 * looping forever with npages == nr_backed == 0 below.
+		 */
+		if (unlikely(handle < 0 && !nr_backed)) {
+			ret = handle;
 			break;
 		}
-		handle = shandle;
-		tt->pages[i] = ttm_backup_handle_to_page_ptr(handle);
-		__free_pages_gpu_account(page, 0, false);
-		shrunken++;
+
+		for (j = 0; j < nr_backed; j++)
+			tt->pages[i + j] = ttm_backup_handle_to_page_ptr(handle + j);
+
+		shrunken += nr_backed;
+
+		if (unlikely(nr_backed < npages)) {
+			/*
+			 * Partial OOM backup: split the compound and free the
+			 * subpages whose content is now in shmem. Continue the
+			 * loop from the first un-backed order-0 page.
+			 */
+			ttm_pool_split_for_swap(pool, page);
+			for (j = 0; j < nr_backed; j++)
+				__free_pages_gpu_account(page + j, 0, false);
+			npages = nr_backed;
+			continue;
+		}
+
+		/* Fully backed up: free at native order. */
+		page->private = 0;
+		__free_pages_gpu_account(page, order, false);
 	}
 
 	return shrunken ? shrunken : ret;
--- a/drivers/gpu/drm/ttm/ttm_pool_internal.h
+++ b/drivers/gpu/drm/ttm/ttm_pool_internal.h
@@ -22,4 +22,12 @@ static inline unsigned int ttm_pool_bene
 	return pool->alloc_flags & 0xff;
 }
 
+/*
+ * Implemented in ttm_pool.c, used by ttm_backup.c. Returns true if a fault
+ * should be injected mid-compound to test the reactive split-and-retry
+ * fallback in ttm_pool_backup(). Always returns false when
+ * CONFIG_FAULT_INJECTION is disabled.
+ */
+bool ttm_backup_fault_inject_folio(void);
+
 #endif
--- a/include/drm/ttm/ttm_backup.h
+++ b/include/drm/ttm/ttm_backup.h
@@ -13,9 +13,8 @@
  * ttm_backup_handle_to_page_ptr() - Convert handle to struct page pointer
  * @handle: The handle to convert.
  *
- * Converts an opaque handle received from the
- * ttm_backup_backup_page() function to an (invalid)
- * struct page pointer suitable for a struct page array.
+ * Converts an opaque handle received from a ttm_backup_backup_*()
+ * function to an (invalid) struct page pointer suitable for a struct page array.
  *
  * Return: An (invalid) struct page pointer.
  */
@@ -59,9 +58,10 @@ int ttm_backup_copy_page(struct file *ba
 			 pgoff_t handle, bool intr, gfp_t additional_gfp);
 
 s64
-ttm_backup_backup_page(struct file *backup, struct page *page,
-		       bool writeback, pgoff_t idx, gfp_t page_gfp,
-		       gfp_t alloc_gfp);
+ttm_backup_backup_folio(struct file *backup, struct folio *folio,
+			unsigned int order, bool writeback, pgoff_t idx,
+			gfp_t folio_gfp, gfp_t alloc_gfp,
+			pgoff_t *nr_pages_backed);
 
 void ttm_backup_fini(struct file *backup);
 


Patches currently in stable-queue which might be from matthew.brost@intel.com are

queue-7.1/drm-xe-guc-fix-buffer-overflow-in-steered-register-list-allocation.patch
queue-7.1/drm-ttm-pool-back-up-at-native-page-order.patch
queue-7.1/drm-i915-gem-add-missing-nospec-on-parallel-submit-slot.patch
queue-7.1/drm-xe-vf-add-drm_dev-guards-when-detaching-ccs-read.patch
queue-7.1/drm-xe-vm-fix-bo-prefetch-with-consult_mem_advise_pref_loc.patch
queue-7.1/drm-xe-display-skip-force_wc-and-vm_bound-check-for-external-dma-bufs.patch
queue-7.1/drm-pagemap-guard-hpage_pmd_order-use-with-config_arch_enable_thp_migration.patch
queue-7.1/drm-ttm-account-for-null-and-handle-pages-in-ttm_pool_backup.patch
queue-7.1/drm-xe-pt-reset-current_op-in-xe_pt_update_ops_init.patch
queue-7.1/drm-gpusvm-fix-mm-reference-leak-in-drm_gpusvm_range_evict.patch
queue-7.1/drm-xe-return-error-on-non-migratable-faults-requiring-devmem.patch
queue-7.1/drm-xe-vm-fix-svm-leak-on-resv-obj-alloc-failure-in-.patch
queue-7.1/drm-pagemap-clear-driver-provided-pfns-from-migration-pfn-array.patch
queue-7.1/drm-xe-fix-pte-index-in-xe_vm_populate_pgtable-for-chunked-binds.patch
queue-7.1/drm-xe-assign-queue-name-in-time-for-drm_sched_init.patch
queue-7.1/drm-xe-madvise-skip-invalidation-for-purgeable-state-updates.patch
queue-7.1/drm-xe-vf-fix-vf-ccs-attach-detach-race-with-in-flig.patch
queue-7.1/drm-gpusvm-publish-dpagemap-early-to-avoid-device-mapping-leak-on-error.patch
queue-7.1/drm-xe-guc-hold-device-ref-until-queue-teardown-comp.patch
queue-7.1/drm-xe-guc-keep-scheduler-timeline-name-alive.patch
queue-7.1/drm-i915-gt-fix-null-deref-on-sched_engine-alloc-failure.patch
queue-7.1/drm-xe-add-compact-pt-and-addr-mask-handling-for-page-reclaim.patch
queue-7.1/drm-gpusvm-zero-hmm-pfns-before-scanning-ranges.patch
