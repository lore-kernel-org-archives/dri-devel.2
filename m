Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64145106ACDD
	for <dri-devel@archiver.kernel.org>; Thu, 12 Mar 2026 19:21:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC9CE10EAA5;
	Thu, 12 Mar 2026 19:21:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="d7tEBWl4";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 733E710EAA0;
 Thu, 12 Mar 2026 19:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773343298; x=1804879298;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Y1XP/fr9Y6FVfU1EObHHiOPEmtBsvKUAt002X3KkqSs=;
 b=d7tEBWl4gi8AFA8lzayyoTFoKi6wwN1zTupjUuck4iK1IfbxURmzqPvW
 M44UVBvZCTXdBpf6DVu2y/kWtE+T8kEnKRatTE/mke9pxQ8E/FlrsUtRU
 BxeMIbhQ4VdFWGsanAsJcXUXUXXy0toAEUMBhZJPTvnhvYDJiE0BOxPVg
 m6rWI21r2rdR6vbrwpVPntYOWbbAfJtkMcStL6d9+Ky71tPE4gxG+h5fH
 Qcjp4t5HVXjhdubcvmVp+A+62KKtlArSicilmwFm9VtZlRsFrIbJMtfXG
 ndLLh8hJjnfJ6wBvEbavYdzIrNFNfNgO5ULPnxQM3gjRD1us8uQeSKqeb w==;
X-CSE-ConnectionGUID: LPyt2SYbQpiYxrxdgGcuRQ==
X-CSE-MsgGUID: fpIy2xHUQoSu2K/VL21daA==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="78052717"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; d="scan'208";a="78052717"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2026 12:21:38 -0700
X-CSE-ConnectionGUID: G0BpUppLRn6H6S2lPnyYSg==
X-CSE-MsgGUID: SxIFrtoJRIiWHPhE2ta1CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; d="scan'208";a="221105098"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO fdugast-desk.home)
 ([10.245.245.89])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2026 12:21:38 -0700
From: Francois Dugast <francois.dugast@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Subject: [PATCH v9 4/4] drm/pagemap: Enable THP support for GPU memory
 migration
Date: Thu, 12 Mar 2026 20:20:14 +0100
Message-ID: <20260312192126.2024853-5-francois.dugast@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260312192126.2024853-1-francois.dugast@intel.com>
References: <20260312192126.2024853-1-francois.dugast@intel.com>
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

This enables support for Transparent Huge Pages (THP) for device pages by
using MIGRATE_VMA_SELECT_COMPOUND during migration. It removes the need to
split folios and loop multiple times over all pages to perform required
operations at page level. Instead, we rely on newly introduced support for
higher orders in drm_pagemap and folio-level API.

In Xe, this drastically improves performance when using SVM. The GT stats
below collected after a 2MB page fault show overall servicing is more than
7 times faster, and thanks to reduced CPU overhead the time spent on the
actual copy goes from 23% without THP to 80% with THP:

Without THP:

    svm_2M_pagefault_us: 966
    svm_2M_migrate_us: 942
    svm_2M_device_copy_us: 223
    svm_2M_get_pages_us: 9
    svm_2M_bind_us: 10

With THP:

    svm_2M_pagefault_us: 132
    svm_2M_migrate_us: 128
    svm_2M_device_copy_us: 106
    svm_2M_get_pages_us: 1
    svm_2M_bind_us: 2

v2:
- Fix one occurrence of drm_pagemap_get_devmem_page() (Matthew Brost)

v3:
- Remove migrate_device_split_page() and folio_split_lock, instead rely on
  free_zone_device_folio() to split folios before freeing (Matthew Brost)
- Assert folio order is HPAGE_PMD_ORDER (Matthew Brost)
- Always use folio_set_zone_device_data() in split (Matthew Brost)

v4:
- Warn on compound device page, s/continue/goto next/ (Matthew Brost)

v5:
- Revert warn on compound device page
- s/zone_device_page_init()/zone_device_folio_init() (Matthew Brost)

Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Michal Mrozek <michal.mrozek@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Balbir Singh <balbirs@nvidia.com>
Cc: linux-mm@kvack.org
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Francois Dugast <francois.dugast@intel.com>
---
 drivers/gpu/drm/drm_pagemap.c | 72 ++++++++++++++++++++++++++++++-----
 1 file changed, 62 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
index 837b881883f9..5002049e0198 100644
--- a/drivers/gpu/drm/drm_pagemap.c
+++ b/drivers/gpu/drm/drm_pagemap.c
@@ -200,16 +200,19 @@ static void drm_pagemap_migration_unlock_put_pages(unsigned long npages,
 /**
  * drm_pagemap_get_devmem_page() - Get a reference to a device memory page
  * @page: Pointer to the page
+ * @order: Order
  * @zdd: Pointer to the GPU SVM zone device data
  *
  * This function associates the given page with the specified GPU SVM zone
  * device data and initializes it for zone device usage.
  */
 static void drm_pagemap_get_devmem_page(struct page *page,
+					unsigned int order,
 					struct drm_pagemap_zdd *zdd)
 {
-	page->zone_device_data = drm_pagemap_zdd_get(zdd);
-	zone_device_page_init(page, page_pgmap(page), 0);
+	zone_device_folio_init((struct folio *)page, zdd->dpagemap->pagemap,
+			       order);
+	folio_set_zone_device_data(page_folio(page), drm_pagemap_zdd_get(zdd));
 }
 
 /**
@@ -524,7 +527,7 @@ int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem *devmem_allocation,
 		.end		= end,
 		.pgmap_owner	= pagemap->owner,
 		.flags		= MIGRATE_VMA_SELECT_SYSTEM | MIGRATE_VMA_SELECT_DEVICE_COHERENT |
-		MIGRATE_VMA_SELECT_DEVICE_PRIVATE,
+		MIGRATE_VMA_SELECT_DEVICE_PRIVATE | MIGRATE_VMA_SELECT_COMPOUND,
 	};
 	unsigned long i, npages = npages_in_range(start, end);
 	unsigned long own_pages = 0, migrated_pages = 0;
@@ -630,11 +633,13 @@ int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem *devmem_allocation,
 
 	own_pages = 0;
 
-	for (i = 0; i < npages; ++i) {
+	for (i = 0; i < npages;) {
+		unsigned long j;
 		struct page *page = pfn_to_page(migrate.dst[i]);
 		struct page *src_page = migrate_pfn_to_page(migrate.src[i]);
-		cur.start = i;
+		unsigned int order = 0;
 
+		cur.start = i;
 		pages[i] = NULL;
 		if (src_page && is_device_private_page(src_page)) {
 			struct drm_pagemap_zdd *src_zdd =
@@ -644,7 +649,7 @@ int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem *devmem_allocation,
 			    !mdetails->can_migrate_same_pagemap) {
 				migrate.dst[i] = 0;
 				own_pages++;
-				continue;
+				goto next;
 			}
 			if (mdetails->source_peer_migrates) {
 				cur.dpagemap = src_zdd->dpagemap;
@@ -660,7 +665,20 @@ int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem *devmem_allocation,
 			pages[i] = page;
 		}
 		migrate.dst[i] = migrate_pfn(migrate.dst[i]);
-		drm_pagemap_get_devmem_page(page, zdd);
+
+		if (migrate.src[i] & MIGRATE_PFN_COMPOUND) {
+			drm_WARN_ONCE(dpagemap->drm, src_page &&
+				      folio_order(page_folio(src_page)) != HPAGE_PMD_ORDER,
+				      "Unexpected folio order\n");
+
+			order = HPAGE_PMD_ORDER;
+			migrate.dst[i] |= MIGRATE_PFN_COMPOUND;
+
+			for (j = 1; j < NR_PAGES(order) && i + j < npages; j++)
+				migrate.dst[i + j] = 0;
+		}
+
+		drm_pagemap_get_devmem_page(page, order, zdd);
 
 		/* If we switched the migrating drm_pagemap, migrate previous pages now */
 		err = drm_pagemap_migrate_range(devmem_allocation, migrate.src, migrate.dst,
@@ -670,7 +688,11 @@ int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem *devmem_allocation,
 			npages = i + 1;
 			goto err_finalize;
 		}
+
+next:
+		i += NR_PAGES(order);
 	}
+
 	cur.start = npages;
 	cur.ops = NULL; /* Force migration */
 	err = drm_pagemap_migrate_range(devmem_allocation, migrate.src, migrate.dst,
@@ -779,6 +801,8 @@ static int drm_pagemap_migrate_populate_ram_pfn(struct vm_area_struct *vas,
 		page = folio_page(folio, 0);
 		mpfn[i] = migrate_pfn(page_to_pfn(page));
 
+		if (order)
+			mpfn[i] |= MIGRATE_PFN_COMPOUND;
 next:
 		if (page)
 			addr += page_size(page);
@@ -1034,8 +1058,15 @@ int drm_pagemap_evict_to_ram(struct drm_pagemap_devmem *devmem_allocation)
 	if (err)
 		goto err_finalize;
 
-	for (i = 0; i < npages; ++i)
+	for (i = 0; i < npages;) {
+		unsigned int order = 0;
+
 		pages[i] = migrate_pfn_to_page(src[i]);
+		if (pages[i])
+			order = folio_order(page_folio(pages[i]));
+
+		i += NR_PAGES(order);
+	}
 
 	err = ops->copy_to_ram(pages, pagemap_addr, npages, NULL);
 	if (err)
@@ -1088,7 +1119,8 @@ static int __drm_pagemap_migrate_to_ram(struct vm_area_struct *vas,
 		.vma		= vas,
 		.pgmap_owner	= page_pgmap(page)->owner,
 		.flags		= MIGRATE_VMA_SELECT_DEVICE_PRIVATE |
-		MIGRATE_VMA_SELECT_DEVICE_COHERENT,
+				  MIGRATE_VMA_SELECT_DEVICE_COHERENT |
+				  MIGRATE_VMA_SELECT_COMPOUND,
 		.fault_page	= page,
 	};
 	struct drm_pagemap_migrate_details mdetails = {};
@@ -1154,8 +1186,15 @@ static int __drm_pagemap_migrate_to_ram(struct vm_area_struct *vas,
 	if (err)
 		goto err_finalize;
 
-	for (i = 0; i < npages; ++i)
+	for (i = 0; i < npages;) {
+		unsigned int order = 0;
+
 		pages[i] = migrate_pfn_to_page(migrate.src[i]);
+		if (pages[i])
+			order = folio_order(page_folio(pages[i]));
+
+		i += NR_PAGES(order);
+	}
 
 	err = ops->copy_to_ram(pages, pagemap_addr, npages, NULL);
 	if (err)
@@ -1213,9 +1252,22 @@ static vm_fault_t drm_pagemap_migrate_to_ram(struct vm_fault *vmf)
 	return err ? VM_FAULT_SIGBUS : 0;
 }
 
+static void drm_pagemap_folio_split(struct folio *orig_folio, struct folio *new_folio)
+{
+	struct drm_pagemap_zdd *zdd;
+
+	if (!new_folio)
+		return;
+
+	new_folio->pgmap = orig_folio->pgmap;
+	zdd = folio_zone_device_data(orig_folio);
+	folio_set_zone_device_data(new_folio, drm_pagemap_zdd_get(zdd));
+}
+
 static const struct dev_pagemap_ops drm_pagemap_pagemap_ops = {
 	.folio_free = drm_pagemap_folio_free,
 	.migrate_to_ram = drm_pagemap_migrate_to_ram,
+	.folio_split = drm_pagemap_folio_split,
 };
 
 /**
-- 
2.43.0

