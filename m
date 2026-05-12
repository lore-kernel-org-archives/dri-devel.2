Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81CBCCD4851
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 11:04:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF78410EA2E;
	Tue, 12 May 2026 11:04:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="E5+G1AQK";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B26EA10EA2E;
 Tue, 12 May 2026 11:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778583852; x=1810119852;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0/h+ElM/jcg5vY60EU0F+b8mrK8INiKreVM7Lv+pmWY=;
 b=E5+G1AQKmdraoZ4ONWQfjblN3CUGCtNy4crjYfs5CZKzWsNXem/PCakk
 Dmat+m+eEn2rutzgcIQEaCOqrNDk0lUz3vrKkHOo0e6vDUfTG/P2Jjiz6
 xQ4HJMDy4Abq1e/1Fp0n2jWaAzS4GQ6fbEkPO65jF8JAseLKrbTazqgEG
 WzNyH5JgwmEgchNC3BFj8hd6QyiwJ9T42tDD5leHeJdKGQL0uD4A+yL5l
 IxZsVtJP0Zlr0Q0jVi/R+33lDcdPyxumYw5+XYmB9FpHevO3F8lfNdFm7
 s3svaOgUDqF9yjn7zt5h5MRpfzQaggmnNFG/xw/JAAt/w/3ZHzVdBGiL+ g==;
X-CSE-ConnectionGUID: v921f8mXSMyiluQ/PUnsqQ==
X-CSE-MsgGUID: 84768Sk/Q6ytU1ssZ/dD/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="104944467"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; d="scan'208";a="104944467"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2026 04:04:11 -0700
X-CSE-ConnectionGUID: JvmgcqrwRb+j0gZOdoRRXw==
X-CSE-MsgGUID: 1Z5CXpMuSzO6E8CS8mSylg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; d="scan'208";a="231339484"
Received: from vpanait-mobl.ger.corp.intel.com (HELO fedora) ([10.245.245.172])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2026 04:04:05 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Hugh Dickins <hughd@google.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Brendan Jackman <jackmanb@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mm/shmem: add shmem_insert_folio()
Date: Tue, 12 May 2026 13:03:38 +0200
Message-ID: <20260512110339.6244-2-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512110339.6244-1-thomas.hellstrom@linux.intel.com>
References: <20260512110339.6244-1-thomas.hellstrom@linux.intel.com>
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

Introduce shmem_insert_folio(), which transfers an isolated folio
zero-copy into a shmem file's page cache.  The folio is charged to
memcg, inserted into the address space, and placed on the anon LRU
for normal reclaim.  An optional writeback parameter requests
immediate swap writeback.

Higher-order folios are promoted to compound before insertion,
enabling THP-sized swap entries with CONFIG_THP_SWAP=y.  On failure
the folio is returned to its original state and the caller retains
ownership.

Assisted-by: GitHub_Copilot:claude-sonnet-4.6
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 include/linux/mm.h       |   1 +
 include/linux/shmem_fs.h |   2 +
 mm/page_alloc.c          |  21 ++++++++
 mm/shmem.c               | 105 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 129 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index af23453e9dbd..e2e7b0c0998b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1676,6 +1676,7 @@ struct mmu_gather;
 struct inode;
 
 extern void prep_compound_page(struct page *page, unsigned int order);
+extern void undo_compound_page(struct page *page);
 
 static inline unsigned int folio_large_order(const struct folio *folio)
 {
diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 93a0ba872ebe..2dc9355757fd 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -175,6 +175,8 @@ int shmem_get_folio(struct inode *inode, pgoff_t index, loff_t write_end,
 		struct folio **foliop, enum sgp_type sgp);
 struct folio *shmem_read_folio_gfp(struct address_space *mapping,
 		pgoff_t index, gfp_t gfp);
+int shmem_insert_folio(struct file *file, struct folio *folio, unsigned int order,
+		       pgoff_t index, bool writeback, gfp_t folio_gfp);
 
 static inline struct folio *shmem_read_folio(struct address_space *mapping,
 		pgoff_t index)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 227d58dc3de6..db82825a3348 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -705,6 +705,27 @@ void prep_compound_page(struct page *page, unsigned int order)
 	prep_compound_head(page, order);
 }
 
+/**
+ * undo_compound_page() - Reverse the effect of prep_compound_page().
+ * @page: The head page of a compound page to demote.
+ *
+ * Returns the pages to non-compound state as if prep_compound_page()
+ * had never been called.  split_page() must NOT have been called on
+ * the compound page; tail refcounts must be 0.  The caller must ensure
+ * no other users hold references to the compound page.
+ */
+void undo_compound_page(struct page *page)
+{
+	unsigned int i, nr = 1U << compound_order(page);
+
+	page[1].flags.f &= ~PAGE_FLAGS_SECOND;
+	for (i = 1; i < nr; i++) {
+		page[i].mapping = NULL;
+		clear_compound_head(&page[i]);
+	}
+	ClearPageHead(page);
+}
+
 static inline void set_buddy_order(struct page *page, unsigned int order)
 {
 	set_page_private(page, order);
diff --git a/mm/shmem.c b/mm/shmem.c
index 3b5dc21b323c..45e80a74f77c 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -937,6 +937,111 @@ int shmem_add_to_page_cache(struct folio *folio,
 	return 0;
 }
 
+/**
+ * shmem_insert_folio() - Insert an isolated folio into a shmem file.
+ * @file: The shmem file created with shmem_file_setup().
+ * @folio: The folio to insert. Must be isolated (not on LRU), unlocked,
+ *         have exactly one reference (the caller's), have no page-table
+ *         mappings, and have folio->mapping == NULL.
+ * @order: The allocation order of @folio.  If @order > 0 and @folio is
+ *         not already a large (compound) folio, it will be promoted to a
+ *         compound folio of this order inside this function.  This requires
+ *         the standard post-alloc state: head refcount == 1, tail
+ *         refcounts == 0 (i.e. split_page() must NOT have been called).
+ *         On failure the promotion is reversed and the folio is returned
+ *         to its original non-compound state.
+ * @index: Page-cache index at which to insert. Must be aligned to
+ *         (1 << @order) and within the file's size.
+ * @writeback: If true, attempt immediate writeback to swap after insertion.
+ *             Best-effort; failure is silently ignored.
+ * @folio_gfp: The GFP flags to use for memory-cgroup charging.
+ *
+ * The folio is inserted zero-copy into the shmem page cache and placed on
+ * the anon LRU, where it participates in normal kernel reclaim (written to
+ * swap under memory pressure).  Any previous content at @index is discarded.
+ * On success the caller should release their reference with folio_put() and
+ * track the (@file, @index) pair for later recovery via shmem_read_folio()
+ * and release via shmem_truncate_range().
+ *
+ * Return: 0 on success.  On failure the folio is returned to its original
+ * state and the caller retains ownership.
+ */
+int shmem_insert_folio(struct file *file, struct folio *folio, unsigned int order,
+		       pgoff_t index, bool writeback, gfp_t folio_gfp)
+{
+	struct address_space *mapping = file->f_mapping;
+	struct inode *inode = mapping->host;
+	bool promoted;
+	long nr_pages;
+	int ret;
+
+	promoted = order > 0 && !folio_test_large(folio);
+	if (promoted)
+		prep_compound_page(&folio->page, order);
+	nr_pages = folio_nr_pages(folio);
+
+	VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
+	VM_BUG_ON_FOLIO(folio_mapped(folio), folio);
+	VM_BUG_ON_FOLIO(folio_test_swapcache(folio), folio);
+	VM_BUG_ON_FOLIO(folio->mapping, folio);
+	VM_BUG_ON(index != round_down(index, nr_pages));
+
+	folio_lock(folio);
+	__folio_set_swapbacked(folio);
+	folio_mark_uptodate(folio);
+
+	folio_gfp &= GFP_RECLAIM_MASK;
+	ret = mem_cgroup_charge(folio, NULL, folio_gfp);
+	if (ret)
+		goto err_unlock;
+
+	ret = shmem_add_to_page_cache(folio, mapping, index, NULL, folio_gfp);
+	if (ret == -EEXIST) {
+		shmem_truncate_range(inode,
+				     (loff_t)index << PAGE_SHIFT,
+				     ((loff_t)(index + nr_pages) << PAGE_SHIFT) - 1);
+		ret = shmem_add_to_page_cache(folio, mapping, index, NULL,
+					      folio_gfp);
+	}
+	if (ret)
+		goto err_uncharge;
+
+	folio_mark_dirty(folio);
+
+	ret = shmem_inode_acct_blocks(inode, nr_pages);
+	if (ret) {
+		filemap_remove_folio(folio);
+		goto err_uncharge;
+	}
+
+	shmem_recalc_inode(inode, nr_pages, 0);
+
+	if (writeback) {
+		ret = shmem_writeout(folio, NULL, NULL);
+		if (ret == AOP_WRITEPAGE_ACTIVATE) {
+			/* No swap slot available; reclaim will retry. */
+			folio_add_lru(folio);
+			folio_unlock(folio);
+		}
+		/* ret == 0 or ret < 0: folio unlocked by shmem_writeout */
+	} else {
+		folio_add_lru(folio);
+		folio_unlock(folio);
+	}
+
+	return 0;
+
+err_uncharge:
+	mem_cgroup_uncharge(folio);
+err_unlock:
+	__folio_clear_swapbacked(folio);
+	folio_unlock(folio);
+	if (promoted)
+		undo_compound_page(&folio->page);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(shmem_insert_folio);
+
 /*
  * Somewhat like filemap_remove_folio, but substitutes swap for @folio.
  */
-- 
2.54.0

