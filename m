Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 782E4C4452D
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 17:47:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DCBE10EAD2;
	Tue, 21 Jul 2026 17:47:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="e52zLwWV";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EED3D10E380;
 Tue, 21 Jul 2026 17:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784656050; x=1816192050;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=v4Vt/yYRyCrs5YArEXYOsSp60kX8kyBYsb9DQf+l+6E=;
 b=e52zLwWVOsVGAtC9MYaFK14XCYtTQ4+yeFSGvZ1S0eRxE0PB6DTTlBig
 S1udJ66d883vjGM/wO6f8TQ0cVmmDs+hxNJ3ilTTnAHk4gNwG4ulPnqgO
 GSX9Acvj6LkWJh8B3ie99YGeOsw4AHvAKMCJ+1OBbu52pCG871xagMMPi
 ob/jdpzVSsO1XZ3oz01RHbkIhCa8IIjut+oQrpJ7IKQh7Ne2snmU/dnoQ
 5Yv4B5TWP6Rcs7l+gtny1qoBLPwuOvHM/Z51JUy0tmyVC0hcHS8ddqGfB
 hn+Psi1xJNwcoSFoxVec6ehxkZo+MTyLnKHfwZQ98nh3tu6GW5ksoyT+4 Q==;
X-CSE-ConnectionGUID: +mmi3zQvQQC4oT+plmFQxA==
X-CSE-MsgGUID: kUWt59stSEu4j3fbQu+/rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="95920592"
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; d="scan'208";a="95920592"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 10:47:29 -0700
X-CSE-ConnectionGUID: 8Or/jpK3RNG3krwaVmCSCA==
X-CSE-MsgGUID: 4u2s0VJuSpqQqnSnB2iVKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; d="scan'208";a="254418012"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 10:47:29 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Hugh Dickins <hughd@google.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/2] mm/shmem: add shmem_backup_folio() helper
Date: Tue, 21 Jul 2026 10:47:22 -0700
Message-Id: <20260721174723.1039395-1-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
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

Add a new generic helper, shmem_backup_folio(), that copies the pages
of an arbitrary source folio into a range of a shmem-backed file,
optionally issuing writeback for each destination folio. It is
extracted from drivers/gpu/drm/ttm's existing shmem-backup loop so
that other subsystems (starting with TTM in a follow-up patch) can
share the same implementation.

Semantics:

  - On full success, 0 is returned and *nr_pages_backed is set to
    (1 << order).
  - On a mid-range -ENOMEM after at least one destination folio has
    been populated, the partial backup is retained: *nr_pages_backed
    holds the successfully backed-up prefix and -ENOMEM is returned so
    the caller can commit that prefix and decide how to proceed
    (e.g. via a reactive split-and-retry path).
  - On any other error, or -ENOMEM with no progress, the pages already
    written are truncated from the backup file via
    shmem_truncate_range(), *nr_pages_backed is reset to 0, and the
    original error is returned.

@order is passed explicitly rather than derived from
folio_order(@folio). Some callers (e.g. TTM) allocate high-order
pages without __GFP_COMP, so folio_order() on such a "folio-shaped"
range would report 0.

folio_mark_dirty() runs after the copy loop, matching the kernel
write-path convention of lock -> modify -> mark_dirty.

Cc: Hugh Dickins <hughd@google.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Assisted-by: GitHub-Copilot:claude-sonnet-5

---

The patch is based on drm-tip rather than the core MM branches to
facilitate Intel CI testing and initial review. It can be rebased onto
the core MM branches in a subsequent revision.
---
 include/linux/shmem_fs.h |   3 +
 mm/shmem.c               | 125 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 128 insertions(+)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index e729b9b0e38d..541f1ab675b7 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -127,6 +127,9 @@ int shmem_writeout(struct folio *folio, struct swap_iocb **plug,
 		struct list_head *folio_list);
 void shmem_truncate_range(struct inode *inode, loff_t start, uoff_t end);
 int shmem_unuse(unsigned int type);
+int shmem_backup_folio(struct folio *folio, struct file *backup, pgoff_t index,
+		       gfp_t gfp, unsigned int order, pgoff_t *nr_pages_backed,
+		       bool writeback);
 
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) && defined(CONFIG_SHMEM)
 unsigned long shmem_allowable_huge_orders(struct inode *inode,
diff --git a/mm/shmem.c b/mm/shmem.c
index b51f83c970bb..bc11c4039b7b 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -5961,3 +5961,128 @@ struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
 	return page;
 }
 EXPORT_SYMBOL_GPL(shmem_read_mapping_page_gfp);
+
+/**
+ * shmem_backup_folio() - Copy a folio's contents into a shmem-backed file.
+ * @folio: Source folio whose contents are to be backed up. Must remain
+ *	pinned by the caller for the duration of the call. The source folio
+ *	is not modified; on success its contents live in @backup and the
+ *	caller may release the source memory.
+ * @backup: A file previously created with shmem_file_setup() (or a wrapper
+ *	such as ttm_backup_shmem_create()). Must be shmem-backed;
+ *	non-shmem files are rejected with -EINVAL.
+ * @index: shmem page index at which to begin storing the backup. The
+ *	subpages of @folio are written to consecutive indices starting at
+ *	@index. The caller is responsible for ensuring the range
+ *	[@index, @index + nr_pages) does not collide with other in-flight
+ *	backups against the same @backup.
+ * @gfp: Allocation flags used when reading/allocating the destination
+ *	shmem folios.
+ * @order: Number of source subpages to copy, expressed as a power of two
+ *	(nr_pages = 1 << @order). Passed explicitly rather than derived
+ *	from folio_order(@folio) so that callers may back up higher-order
+ *	page ranges that were allocated without __GFP_COMP (and for which
+ *	folio_order() would therefore return 0).
+ * @nr_pages_backed: Out parameter. Reset to 0 on entry. On any return
+ *	value, holds the number of source subpages whose contents are
+ *	guaranteed to be present in @backup and reachable via consecutive
+ *	shmem indices starting at @index. A value less than (1 << @order)
+ *	with return value -ENOMEM indicates a partial backup that the
+ *	caller may keep (see below).
+ * @writeback: If true, attempt immediate writeout of each destination
+ *	shmem folio after it is populated. This trades throughput for
+ *	promptly evicting the backup from page cache. Only meaningful for
+ *	unmapped destination folios.
+ *
+ * Copy the contents of @folio into @backup starting at shmem index
+ * @index, one destination shmem folio at a time. Destination folios may
+ * themselves be higher-order; the copy loop advances by the natural
+ * order of each destination folio so a large destination folio is
+ * populated in a single iteration.
+ *
+ * The function distinguishes two failure modes:
+ *
+ *  - Mid-folio -ENOMEM after at least one destination folio has been
+ *    populated: the partial backup is *retained*. @nr_pages_backed is
+ *    left at the number of subpages successfully copied so far, and
+ *    -ENOMEM is returned. Callers that support partial backup (e.g. a
+ *    subsequent split-and-retry of the source) can commit the returned
+ *    prefix by treating handles [@index, @index + *@nr_pages_backed) as
+ *    valid.
+ *
+ *  - Any other error, or -ENOMEM with no progress: the pages already
+ *    written (if any) are truncated from @backup via
+ *    shmem_truncate_range(), @nr_pages_backed is reset to 0, and the
+ *    original error is returned. On return the caller owns no valid
+ *    handles in @backup.
+ *
+ * Context: May sleep. The caller is responsible for any locking of
+ * @backup's page range against concurrent access.
+ *
+ * Return: 0 on full success (all 1 << @order subpages backed up),
+ * -ENOMEM on partial success (see above), or another negative errno on
+ * failure (backup fully rolled back).
+ */
+int shmem_backup_folio(struct folio *folio, struct file *backup, pgoff_t index,
+		       gfp_t gfp, unsigned int order, pgoff_t *nr_pages_backed,
+		       bool writeback)
+{
+	struct address_space *mapping = backup->f_mapping;
+	int nr_pages = 1 << order;
+	int ret, i;
+
+	*nr_pages_backed = 0;
+	if (!shmem_file(backup))
+		return -EINVAL;
+
+	for (i = 0; i < nr_pages; ) {
+		struct folio *to_folio;
+		int to_nr, j;
+
+		to_folio = shmem_read_folio_gfp(mapping, index + i, gfp);
+		if (IS_ERR(to_folio)) {
+			ret = PTR_ERR(to_folio);
+
+			/* All errors aside from -ENOMEM drop partial backup */
+			if (*nr_pages_backed && ret != -ENOMEM) {
+				shmem_truncate_range(file_inode(backup),
+						     (loff_t)index << PAGE_SHIFT,
+						     ((loff_t)(index + i) << PAGE_SHIFT) - 1);
+				*nr_pages_backed = 0;
+			}
+
+			return ret;
+		}
+
+		to_nr = min_t(int, nr_pages - i,
+			      folio_next_index(to_folio) - (index + i));
+
+		folio_mark_accessed(to_folio);
+		folio_lock(to_folio);
+
+		for (j = 0; j < to_nr; j++)
+			copy_highpage(folio_file_page(to_folio, index + i + j),
+				      folio_page(folio, i + j));
+
+		folio_mark_dirty(to_folio);
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
+			folio_unlock(to_folio);
+		}
+
+		folio_put(to_folio);
+		i += to_nr;
+		*nr_pages_backed = i;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(shmem_backup_folio);
-- 
2.34.1

