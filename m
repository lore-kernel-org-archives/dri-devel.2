Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC029C4453C
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 04:42:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69D3410EC1C;
	Wed, 22 Jul 2026 04:42:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="AjYCYA7o";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3B4510E4C4;
 Wed, 22 Jul 2026 04:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784695348; x=1816231348;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8r1Uq1zdtpAGJu8GavaMBdCBQ8DhrDpmk6GT3M4wn6s=;
 b=AjYCYA7oOVmZ7rO+Bu5W9KLM7xAptqFy5TnPVlfZ1K5cHj8FWuUCp3o9
 DF1m59K4yMpGwr08nmFpMTCsamuKBdevGAyqrd5lByDAm9JcIchzfYlQE
 44ihGuXdwJHfmAe0tzETT2qWA19Lt2EX1bjo3C+uIyDBFChCp+s0cHcvg
 uQk39waq59RrTsA7Pg14OEcZ2FHbAVFXzlic0BGbt29BrsDc3yX7dN59O
 7DtnseFteeTnyASpC5Ks67ug4vioyZvep3fxg0eOwr7Sqen1JL1tXujpt
 6pJcMog0cHGtQmwwCQ/XE18AoaI4JPxVk1gBRWXBjYpVBZmlRXb55OZsH w==;
X-CSE-ConnectionGUID: qjv6NIKES1aUaLKvCfRnOQ==
X-CSE-MsgGUID: AMiu0Vl8SxKjJqk0bTqQdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="102865818"
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; d="scan'208";a="102865818"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 21:42:27 -0700
X-CSE-ConnectionGUID: ttMGdGQCR4qWX40DU9YdWg==
X-CSE-MsgGUID: 4McOWbVNSJOBmCVv1kMXLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; d="scan'208";a="254063563"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 21:42:27 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Dave Airlie <airlied@redhat.com>, Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 3/3] drm/ttm: allocate pool pages as compound (__GFP_COMP)
Date: Tue, 21 Jul 2026 21:42:20 -0700
Message-Id: <20260722044220.1110278-3-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260722044220.1110278-1-matthew.brost@intel.com>
References: <20260722044220.1110278-1-matthew.brost@intel.com>
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

Historically ttm_pool_alloc_page() deliberately avoided __GFP_COMP for
higher-order allocations and instead stashed the allocation order in
page->private. The stated reason was that mapping a TTM page into a
userspace process and having that process call put_page() on it would be
illegal on a compound page, because the stray reference would fold into
the compound head and could free the whole block behind TTM's back.

That hazard no longer applies to the non-DMA path. TTM faults its pages
into userspace via VM_PFNMAP (see ttm_bo_vm_fault_reserved() /
vmf_insert_pfn_prot()), so the core mm never takes a struct page
reference on them and GUP rejects the range; a stray userspace put_page()
cannot reach these pages at all.

Convert the !ttm_pool_uses_dma_alloc() path to allocate compound pages
with __GFP_COMP and recover the order via folio_order() instead of
page->private:

  - ttm_pool_alloc_page(): add __GFP_COMP, drop the page->private write.
  - ttm_pool_page_order() / ttm_pool_unmap_and_free(): read the order
    from folio_order() for the non-DMA case.
  - ttm_pool_split_for_swap(): for compound folios, split via the new
    folio_split_driver_managed() helper rather than split_page(), which
    rejects compound pages. Each resulting order-0 folio is then freed
    individually as it is backed up.
  - Drop the now-dead page->private = 0 clears on the purge and
    full-backup free paths.

The DMA path is intentionally left unchanged: dma_alloc_attrs() does not
produce compound pages, so it keeps split_page() and the page->private
order stash.

folio_split_driver_managed() lives in the THP split machinery
(mm/huge_memory.c), which only builds when CONFIG_TRANSPARENT_HUGEPAGE
is enabled. Drivers that drive the TTM shrinker and therefore reach the
split path must select TRANSPARENT_HUGEPAGE.

Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: "Liam R. Howlett" <liam@infradead.org>
Cc: Nico Pache <npache@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Lance Yang <lance.yang@linux.dev>
Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Dave Airlie <airlied@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Assisted-by: GitHub-Copilot:claude-opus-4.8
---
 drivers/gpu/drm/ttm/tests/ttm_pool_test.c | 23 +++++++++---
 drivers/gpu/drm/ttm/ttm_backup.c          |  8 ++--
 drivers/gpu/drm/ttm/ttm_pool.c            | 46 +++++++++++++++--------
 3 files changed, 53 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/ttm/tests/ttm_pool_test.c b/drivers/gpu/drm/ttm/tests/ttm_pool_test.c
index be75c8abf388..771ed257778c 100644
--- a/drivers/gpu/drm/ttm/tests/ttm_pool_test.c
+++ b/drivers/gpu/drm/ttm/tests/ttm_pool_test.c
@@ -169,7 +169,14 @@ static void ttm_pool_alloc_basic(struct kunit *test)
 			KUNIT_ASSERT_NOT_NULL(test, (void *)fst_page->private);
 			KUNIT_ASSERT_NOT_NULL(test, (void *)last_page->private);
 		} else {
-			KUNIT_ASSERT_EQ(test, fst_page->private, params->order);
+			/*
+			 * The non-DMA path allocates compound pages, so the
+			 * order is recovered from the folio rather than from
+			 * page->private.
+			 */
+			KUNIT_ASSERT_EQ(test,
+					folio_order(page_folio(fst_page)),
+					params->order);
 		}
 	} else {
 		if (ttm_pool_uses_dma_alloc(pool)) {
@@ -177,13 +184,19 @@ static void ttm_pool_alloc_basic(struct kunit *test)
 			KUNIT_ASSERT_NULL(test, (void *)last_page->private);
 		} else {
 			/*
-			 * We expect to alloc one big block, followed by
-			 * order 0 blocks
+			 * We expect to alloc one or more max-order compound
+			 * blocks. page_folio() on any subpage resolves to the
+			 * compound head, so both the first and last pages
+			 * report the max block order.
 			 */
-			KUNIT_ASSERT_EQ(test, fst_page->private,
+			KUNIT_ASSERT_EQ(test,
+					folio_order(page_folio(fst_page)),
+					min_t(unsigned int, MAX_PAGE_ORDER,
+					      params->order));
+			KUNIT_ASSERT_EQ(test,
+					folio_order(page_folio(last_page)),
 					min_t(unsigned int, MAX_PAGE_ORDER,
 					      params->order));
-			KUNIT_ASSERT_EQ(test, last_page->private, 0);
 		}
 	}
 
diff --git a/drivers/gpu/drm/ttm/ttm_backup.c b/drivers/gpu/drm/ttm/ttm_backup.c
index 3c067aadc52d..9194747a1dff 100644
--- a/drivers/gpu/drm/ttm/ttm_backup.c
+++ b/drivers/gpu/drm/ttm/ttm_backup.c
@@ -72,9 +72,11 @@ int ttm_backup_copy_page(struct file *backup, struct page *dst,
  * ttm_backup_backup_folio() - Backup a folio
  * @backup: The struct backup pointer to use.
  * @folio: The folio to back up.
- * @order: The allocation order of @folio.  Since TTM allocates higher-order
- *         pages without __GFP_COMP, folio_nr_pages(@folio) would always
- *         return 1; the caller must pass the true order explicitly.
+ * @order: The allocation order of @folio, passed explicitly. For the DMA
+ *         path TTM allocates higher-order pages without __GFP_COMP, so
+ *         folio_order(@folio) would return 0 rather than the true order;
+ *         the caller therefore passes the order explicitly. (The non-DMA
+ *         path allocates compound pages, for which the two agree.)
  * @writeback: Whether to perform immediate writeback of the folio's pages.
  * This may have performance implications.
  * @idx: A unique integer for the first page of the folio and each struct backup.
diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 1bf37023fed6..364cc7ec7469 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -168,9 +168,11 @@ static struct page *ttm_pool_alloc_page(struct ttm_pool *pool, gfp_t gfp_flags,
 	struct page *p;
 	void *vaddr;
 
-	/* Don't set the __GFP_COMP flag for higher order allocations.
-	 * Mapping pages directly into an userspace process and calling
-	 * put_page() on a TTM allocated page is illegal.
+	/*
+	 * For higher-order allocations be a good citizen: don't dip into
+	 * memory reserves, don't retry hard, don't warn on failure and stay
+	 * on the local node. The non-DMA path additionally sets __GFP_COMP
+	 * below; the DMA path allocates via dma_alloc_attrs().
 	 */
 	if (order)
 		gfp_flags |= __GFP_NOMEMALLOC | __GFP_NORETRY | __GFP_NOWARN |
@@ -189,11 +191,9 @@ static struct page *ttm_pool_alloc_page(struct ttm_pool *pool, gfp_t gfp_flags,
 	}
 
 	if (!ttm_pool_uses_dma_alloc(pool)) {
-		p = alloc_pages_node(pool->nid, gfp_flags, order);
-		if (p) {
-			p->private = order;
+		p = alloc_pages_node(pool->nid, gfp_flags | __GFP_COMP, order);
+		if (p)
 			mod_lruvec_page_state(p, NR_GPU_ACTIVE, 1 << order);
-		}
 		return p;
 	}
 
@@ -482,7 +482,7 @@ static unsigned int ttm_pool_page_order(struct ttm_pool *pool, struct page *p)
 		return dma->vaddr & ~PAGE_MASK;
 	}
 
-	return p->private;
+	return folio_order(page_folio(p));
 }
 
 /*
@@ -493,15 +493,31 @@ static unsigned int ttm_pool_page_order(struct ttm_pool *pool, struct page *p)
 static void ttm_pool_split_for_swap(struct ttm_pool *pool, struct page *p)
 {
 	unsigned int order = ttm_pool_page_order(pool, p);
-	pgoff_t nr;
 
 	if (!order)
 		return;
 
-	split_page(p, order);
-	nr = 1UL << order;
-	while (nr--)
-		(p++)->private = 0;
+	if (ttm_pool_uses_dma_alloc(pool)) {
+		pgoff_t nr;
+
+		/*
+		 * DMA-alloc pages are not compound; split the plain
+		 * higher-order allocation and clear the per-page private
+		 * (which held the order for the non-compound case).
+		 */
+		split_page(p, order);
+		nr = 1UL << order;
+		while (nr--)
+			(p++)->private = 0;
+		return;
+	}
+
+	/*
+	 * The non-DMA path allocates compound folios (__GFP_COMP). Split the
+	 * driver-owned, off-LRU, unmapped folio into order-0 folios so each
+	 * page can be freed as soon as it has been backed up.
+	 */
+	folio_split_driver_managed(page_folio(p), 0);
 }
 
 /**
@@ -548,7 +564,7 @@ static pgoff_t ttm_pool_unmap_and_free(struct ttm_pool *pool, struct page *page,
 
 		pt = ttm_pool_select_type(pool, caching, order);
 	} else {
-		order = page->private;
+		order = folio_order(page_folio(page));
 		nr = (1UL << order);
 	}
 
@@ -1124,7 +1140,6 @@ long ttm_pool_backup(struct ttm_pool *pool, struct ttm_tt *tt,
 					       num_pages);
 			if (flags->purge) {
 				shrunken += num_pages;
-				page->private = 0;
 				__free_pages_gpu_account(page, order, false);
 				memset(tt->pages + i, 0,
 				       num_pages * sizeof(*tt->pages));
@@ -1214,7 +1229,6 @@ long ttm_pool_backup(struct ttm_pool *pool, struct ttm_tt *tt,
 		}
 
 		/* Fully backed up: free at native order. */
-		page->private = 0;
 		__free_pages_gpu_account(page, order, false);
 	}
 
-- 
2.34.1

