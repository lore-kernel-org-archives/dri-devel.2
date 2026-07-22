Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89057C44536
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 04:42:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B6D710EC13;
	Wed, 22 Jul 2026 04:42:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="hM6a1C1Q";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3730E10E4C4;
 Wed, 22 Jul 2026 04:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784695347; x=1816231347;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=egqyx0xIHYO6pVjtq79Q7C2oe7YYIs3Mzn5MdOs14pI=;
 b=hM6a1C1Q8wtbZLfExHMUP45zRDupmYrBErRat7lbPgX1do+6fPgoJ7vj
 K6SLpaOc4/PjFfF1J3/DRwHcSCd/0uU/fwMMpgk8caIcyZffgV/I9VlnW
 hNwZY4zaP7lf4AUONbkSY/JlyZqXgtaiiTpSGxxbgGnywrfwkgKWrPNjM
 /wRajZPxzI8+WweKP7ENRr8ZHyhZlWnwRk6Sp7NHh1R8DPSbnXcVmXHKb
 9mkkzGi8iyJrgi1qY1/lHqI5BWu2YD5u9fvi+3IdqNS+ODNVZxv2amImH
 n4+O69wQ+i0u+LoX2NccjbBd+tPsGSjGsUlCC0IUJ2iPW6KvQxVhwYvUf A==;
X-CSE-ConnectionGUID: Z1mwctPZSXGY1+1hIbuv8Q==
X-CSE-MsgGUID: CBZDV5XbTKWFe8uOXwMUSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="102865785"
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; d="scan'208";a="102865785"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 21:42:26 -0700
X-CSE-ConnectionGUID: f5jNSLotR9G+hsgBQa+nlQ==
X-CSE-MsgGUID: NNhGkjL0QKOHHVPYPaELjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; d="scan'208";a="254063555"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 21:42:26 -0700
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
Subject: [PATCH 1/3] mm/huge_memory: add folio_split_driver_managed()
Date: Tue, 21 Jul 2026 21:42:18 -0700
Message-Id: <20260722044220.1110278-1-matthew.brost@intel.com>
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

Add a lightweight structural split primitive for large (compound) folios
that a driver allocated with __GFP_COMP and manages entirely by itself,
outside of the core mm's view.

The existing split paths - split_folio() and folio_split_unmapped() -
are built for folios that the mm owns: they perform a refcount freeze,
walk and remap the rmap, and take the anon_vma / i_mmap locks, and
folio_split_unmapped() further assumes an anon, pagecache-style refcount
model (nr_pages + 1). None of that applies to a folio that is:

  - singly referenced (the caller holds the only reference),
  - not mapped through the rmap (folio_mapped() == 0),
  - not in the page cache or swap cache (folio->mapping == NULL),
  - not on any LRU or the deferred-split list.

For such a folio the split is purely structural: because nothing else in
the kernel can reach it, there is no need to freeze the refcount or touch
any mapping. folio_split_driver_managed() therefore performs only the
compound and split-accounting teardown via __split_unmapped_folio() and
then hands each resulting order-@new_order folio its own reference,
mirroring split_page() for compound folios. The caller keeps the original
reference on the first resulting folio and is responsible for freeing all
of them individually.

The immediate user is TTM's GPU page pool, which allocates higher-order
compound pages, maps them into userspace via VM_PFNMAP (never through the
rmap), and needs to split them into order-0 folios under memory pressure
so pages can be backed up to shmem and freed one at a time.

A CONFIG_TRANSPARENT_HUGEPAGE=n stub is provided so callers can build
without the split machinery; it warns and returns -EINVAL.

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

The patch is based on drm-tip rather than the core MM branches to
facilitate Intel CI testing and initial review. It can be rebased onto
the core MM branches in a subsequent revision.
---
 include/linux/huge_mm.h |  8 ++++++
 mm/huge_memory.c        | 63 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index ad20f7f8c179..35661d82d54a 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -402,6 +402,7 @@ enum split_type {
 int __split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 		unsigned int new_order);
 int folio_split_unmapped(struct folio *folio, unsigned int new_order);
+int folio_split_driver_managed(struct folio *folio, unsigned int new_order);
 unsigned int min_order_for_split(struct folio *folio);
 int split_folio_to_list(struct folio *folio, struct list_head *list);
 int folio_check_splittable(struct folio *folio, unsigned int new_order,
@@ -656,6 +657,13 @@ static inline int split_folio_to_list(struct folio *folio, struct list_head *lis
 	return -EINVAL;
 }
 
+static inline int folio_split_driver_managed(struct folio *folio,
+					     unsigned int new_order)
+{
+	VM_WARN_ON_ONCE_FOLIO(1, folio);
+	return -EINVAL;
+}
+
 static inline int folio_split(struct folio *folio, unsigned int new_order,
 		struct page *page, struct list_head *list)
 {
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2bccb0a53a0a..06f9a5f35df8 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -4185,6 +4185,69 @@ int folio_split_unmapped(struct folio *folio, unsigned int new_order)
 	return ret;
 }
 
+/**
+ * folio_split_driver_managed() - split an exclusively-owned, off-LRU folio
+ * @folio: folio to split. Must be a large (compound) folio that is owned
+ *         exclusively by the caller and is invisible to the core mm.
+ * @new_order: the order of the folios after the split.
+ *
+ * This is a lightweight structural split for folios that a driver allocated
+ * and manages itself (for example TTM's GPU page pool, which allocates
+ * higher-order compound pages with __GFP_COMP and maps them into userspace
+ * via VM_PFNMAP rather than through the rmap). Such folios are:
+ *
+ *   - singly referenced (the caller holds the only reference),
+ *   - not mapped through the rmap (folio_mapcount() == 0),
+ *   - not in the page cache or swap cache (folio->mapping == NULL),
+ *   - not on any LRU or the deferred-split list.
+ *
+ * Because nothing else in the kernel can reach the folio, this helper does
+ * not perform the refcount freeze / remap / anon_vma & i_mmap locking dance
+ * that split_folio() and folio_split_unmapped() require. It performs only
+ * the compound and split-accounting teardown and then hands each resulting
+ * folio its own reference, mirroring split_page() for compound folios.
+ *
+ * The caller is responsible for freeing the resulting folios individually.
+ *
+ * Context: caller holds the only reference and excludes concurrent access.
+ * Does not sleep.
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int folio_split_driver_managed(struct folio *folio, unsigned int new_order)
+{
+	unsigned int old_order = folio_order(folio);
+	unsigned int split_nr = 1U << new_order;
+	unsigned int nr = 1U << old_order;
+	unsigned int i;
+
+	if (new_order >= old_order)
+		return -EINVAL;
+
+	VM_WARN_ON_ONCE_FOLIO(folio_ref_count(folio) != 1, folio);
+	VM_WARN_ON_ONCE_FOLIO(folio_mapped(folio), folio);
+	VM_WARN_ON_ONCE_FOLIO(folio->mapping, folio);
+	VM_WARN_ON_ONCE_FOLIO(folio_test_swapcache(folio), folio);
+	VM_WARN_ON_ONCE_FOLIO(folio_test_lru(folio), folio);
+
+	/*
+	 * Structural + split-accounting teardown only. No mapping/xarray, no
+	 * refcount freeze: the folio is frozen-by-ownership already.
+	 */
+	__split_unmapped_folio(folio, new_order, &folio->page, NULL, NULL,
+			       SPLIT_TYPE_UNIFORM);
+
+	/*
+	 * Give every resulting head folio its own reference. The original
+	 * reference stays on the first one, exactly like split_page().
+	 */
+	for (i = split_nr; i < nr; i += split_nr)
+		set_page_refcounted(folio_page(folio, i));
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(folio_split_driver_managed);
+
 /*
  * This function splits a large folio into smaller folios of order @new_order.
  * @page can point to any page of the large folio to split. The split operation
-- 
2.34.1

