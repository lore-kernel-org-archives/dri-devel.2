Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 388F5C55175
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 09:26:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 882B410E4CE;
	Mon,  3 Aug 2026 09:26:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="DHubBIfb";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D52A610E4CE;
 Mon,  3 Aug 2026 09:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785749170; x=1817285170;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=7ApJxpghE5189vMhIV1uwj6o4/orNLiT5hOsQOpnWf0=;
 b=DHubBIfbuhL6KLP8VjnehYck54bVPOL2943mQhmYLkh/JxTgr7Y5PPGY
 1/5YVj50navUr/yI/9ekZKd/Do+UEhdxtbbsZtYyTLsgWh+Oth7i5d+Vn
 EYtMvdQifVtUAJdKFwQJTzi0KjnEP7nqt3rg4LqMV2jD55ktSCQo0dPpd
 flW4BgwYPrLTT9NRXbe3qzDN7l/uxaKSaxy+LEnlIe087fqFhfKCVYLt1
 SmPa42VW2fYuSafUrqAHzczr6xN4iLKajC4YPjXWCdbTpETo6zlzkUb8V
 ZpsKEqQMbPSiy3RhI2yJki/6g7xJTtRIVYVB3AS4RU+1RQLW5CKDqpgdQ w==;
X-CSE-ConnectionGUID: GufuLy9yS5iDeOMDhzctTA==
X-CSE-MsgGUID: OQLf5b6iQ0uvHblGJCgtkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11863"; a="97654358"
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; d="scan'208";a="97654358"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2026 02:26:09 -0700
X-CSE-ConnectionGUID: HUWD9Lj+T3iFoJQt2ZQctA==
X-CSE-MsgGUID: zaY7xjpYRqqSqqiIdc86lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; d="scan'208";a="261223906"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2026 02:26:06 -0700
From: Arvind Yadav <arvind.yadav@intel.com>
To: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: matthew.brost@intel.com, thomas.hellstrom@linux.intel.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, himal.prasad.ghimiray@intel.com
Subject: [PATCH] drm/pagemap: Prevent double migration of device pages
Date: Mon,  3 Aug 2026 14:55:53 +0530
Message-ID: <20260803092553.4117408-1-arvind.yadav@intel.com>
X-Mailer: git-send-email 2.43.0
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

A device page migrated to system memory by a CPU fault can remain
referenced for a short time after migration completes. During this
window, the raw-PFN eviction path can select the same device PFN and
migrate it again.

The first migration has already moved the memcg charge away from the
source folio. Migrating that source again can create an uncharged system
folio. Adding such a folio to the LRU can spin indefinitely in
folio_lruvec_lock_irqsave(), resulting in a soft lockup and an RCU stall.

Track successfully migrated device PFNs in drm_pagemap_zdd for the
lifetime of the device-mapping generation.

Record successful migrations in both the CPU-fault and raw-PFN eviction
paths.

Make raw-PFN eviction skip retired PFNs, preventing an already migrated
device page from being handed to the migration path a second time.

Fixes: 99624bdff867 ("drm/gpusvm: Add support for GPU Shared Virtual Memory")
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
---
 drivers/gpu/drm/drm_pagemap.c | 188 +++++++++++++++++++++++++++++++++-
 1 file changed, 186 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
index 7a056592ac66..f7040fc0dea6 100644
--- a/drivers/gpu/drm/drm_pagemap.c
+++ b/drivers/gpu/drm/drm_pagemap.c
@@ -7,6 +7,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/migrate.h>
 #include <linux/pagemap.h>
+#include <linux/xarray.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_pagemap.h>
 #include <drm/drm_pagemap_util.h>
@@ -66,6 +67,8 @@
  * @refcount: Reference count for the zdd
  * @devmem_allocation: device memory allocation
  * @dpagemap: Refcounted pointer to the underlying struct drm_pagemap.
+ * @retired: Device PFNs already migrated to RAM. Entries remain until this
+ * mapping generation is destroyed.
  *
  * This structure serves as a generic wrapper installed in
  * page->zone_device_data. It provides infrastructure for looking up a device
@@ -78,6 +81,7 @@ struct drm_pagemap_zdd {
 	struct kref refcount;
 	struct drm_pagemap_devmem *devmem_allocation;
 	struct drm_pagemap *dpagemap;
+	struct xarray retired;
 };
 
 /**
@@ -101,6 +105,7 @@ drm_pagemap_zdd_alloc(struct drm_pagemap *dpagemap)
 	kref_init(&zdd->refcount);
 	zdd->devmem_allocation = NULL;
 	zdd->dpagemap = drm_pagemap_get(dpagemap);
+	xa_init(&zdd->retired);
 
 	return zdd;
 }
@@ -137,6 +142,7 @@ static void drm_pagemap_zdd_destroy(struct kref *ref)
 		if (devmem->ops->devmem_release)
 			devmem->ops->devmem_release(devmem);
 	}
+	xa_destroy(&zdd->retired);
 	kfree(zdd);
 	drm_pagemap_put(dpagemap);
 }
@@ -1102,12 +1108,169 @@ void drm_pagemap_put(struct drm_pagemap *dpagemap)
 }
 EXPORT_SYMBOL(drm_pagemap_put);
 
+/**
+ * drm_pagemap_is_devmem_page() - Is @page a drm_pagemap device page
+ * @page: The page to test
+ *
+ * Return: true for device-private or device-coherent pages, which carry a
+ * struct drm_pagemap_zdd in their zone_device_data.
+ */
+static bool drm_pagemap_is_devmem_page(const struct page *page)
+{
+	return is_device_private_page(page) || is_device_coherent_page(page);
+}
+
+static void
+drm_pagemap_release_retired_reservations(unsigned long *src_pfns,
+					 unsigned long npages)
+{
+	unsigned long i = 0;
+
+	while (i < npages) {
+		struct page *page = migrate_pfn_to_page(src_pfns[i]);
+		struct drm_pagemap_zdd *zdd;
+		struct folio *folio;
+		unsigned long pfn, nr, j;
+
+		if (!page || !(src_pfns[i] & MIGRATE_PFN_MIGRATE) ||
+		    !drm_pagemap_is_devmem_page(page)) {
+			i++;
+			continue;
+		}
+
+		folio = page_folio(page);
+		zdd = drm_pagemap_page_zone_device_data(page);
+		pfn = folio_pfn(folio);
+		nr = folio_nr_pages(folio);
+
+		for (j = 0; j < nr; j++)
+			xa_release(&zdd->retired, pfn + j);
+
+		i += nr;
+	}
+}
+
+/**
+ * drm_pagemap_reserve_retired_pages() - Pre-reserve retirement slots
+ * @src_pfns: migrate_vma source array after migrate_vma_setup()
+ * @npages: number of entries in @src_pfns
+ *
+ * Reserve every base PFN because migration may split a large source
+ * folio. Recording the result must not allocate.
+ */
+static int drm_pagemap_reserve_retired_pages(unsigned long *src_pfns,
+					     unsigned long npages)
+{
+	unsigned long i = 0;
+	int err;
+
+	while (i < npages) {
+		struct page *page = migrate_pfn_to_page(src_pfns[i]);
+		struct drm_pagemap_zdd *zdd;
+		unsigned long pfn, nr, k;
+
+		if (!page || !(src_pfns[i] & MIGRATE_PFN_MIGRATE) ||
+		    !drm_pagemap_is_devmem_page(page)) {
+			i++;
+			continue;
+		}
+
+		zdd = drm_pagemap_page_zone_device_data(page);
+		pfn = folio_pfn(page_folio(page));
+		nr = folio_nr_pages(page_folio(page));
+
+		for (k = 0; k < nr; k++) {
+			err = xa_reserve(&zdd->retired, pfn + k, GFP_KERNEL);
+			if (err) {
+				drm_pagemap_release_retired_reservations(src_pfns,
+									 npages);
+				return err;
+			}
+		}
+
+		i += nr;
+	}
+
+	return 0;
+}
+
+/**
+ * drm_pagemap_retire_migrated_pages() - Retire CPU-migrated device PFNs
+ * @src_pfns: migrate_vma source array, valid after migrate_vma_pages()
+ * @npages: number of entries in @src_pfns
+ *
+ * Record successful migrations before finalize unlocks the sources.
+ * Release reservations for pages that were not migrated.
+ */
+static void drm_pagemap_retire_migrated_pages(unsigned long *src_pfns,
+					      unsigned long npages)
+{
+	unsigned long i = 0;
+
+	while (i < npages) {
+		struct page *page = migrate_pfn_to_page(src_pfns[i]);
+		struct drm_pagemap_zdd *zdd;
+		unsigned long pfn, nr, k;
+		bool migrated;
+
+		if (!page || !drm_pagemap_is_devmem_page(page)) {
+			i++;
+			continue;
+		}
+
+		zdd = drm_pagemap_page_zone_device_data(page);
+		pfn = folio_pfn(page_folio(page));
+		nr = folio_nr_pages(page_folio(page));
+		migrated = src_pfns[i] & MIGRATE_PFN_MIGRATE;
+
+		/* Keep later folio splits covered. */
+		for (k = 0; k < nr; k++) {
+			if (migrated)
+				WARN_ON_ONCE(xa_err(xa_store(&zdd->retired,
+							     pfn + k,
+							     xa_mk_value(1),
+							     GFP_NOWAIT)));
+			else
+				xa_release(&zdd->retired, pfn + k);
+		}
+
+		i += nr;
+	}
+}
+
+/**
+ * drm_pagemap_skip_retired_pages() - Drop retired PFNs from a raw-PFN eviction
+ * @src_pfns: source array after migrate_device_pfns() (MIGRATE_PFN encoded)
+ * @npages: number of entries in @src_pfns
+ *
+ * Skip source PFNs already migrated to RAM by either migration path.
+ */
+static void drm_pagemap_skip_retired_pages(unsigned long *src_pfns,
+					   unsigned long npages)
+{
+	unsigned long i;
+
+	for (i = 0; i < npages; i++) {
+		struct page *page = migrate_pfn_to_page(src_pfns[i]);
+		struct drm_pagemap_zdd *zdd;
+
+		if (!page || !(src_pfns[i] & MIGRATE_PFN_MIGRATE) ||
+		    !drm_pagemap_is_devmem_page(page))
+			continue;
+
+		zdd = drm_pagemap_page_zone_device_data(page);
+		if (xa_load(&zdd->retired, folio_pfn(page_folio(page))))
+			src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
+	}
+}
+
 /**
  * drm_pagemap_evict_to_ram() - Evict GPU SVM range to RAM
  * @devmem_allocation: Pointer to the device memory allocation
  *
- * Similar to __drm_pagemap_migrate_to_ram but does not require mmap lock and
- * migration done via migrate_device_* functions.
+ * Similar to __drm_pagemap_migrate_to_ram(), but uses the
+ * migrate_device_* helpers and does not require the mmap lock. Device
+ * PFNs already migrated by a CPU fault are skipped.
  *
  * Return: 0 on success, negative error code on failure.
  */
@@ -1149,6 +1312,17 @@ int drm_pagemap_evict_to_ram(struct drm_pagemap_devmem *devmem_allocation)
 	if (err)
 		goto err_free;
 
+	drm_pagemap_skip_retired_pages(src, npages);
+
+	/*
+	 * Reserve retirement entries before migration so recording successful
+	 * PFNs cannot fail. Otherwise, a retry could select and migrate the same
+	 * PFN again.
+	 */
+	err = drm_pagemap_reserve_retired_pages(src, npages);
+	if (err)
+		goto err_finalize;
+
 	err = drm_pagemap_migrate_populate_ram_pfn(NULL, NULL, npages, &mpages,
 						   src, dst, 0);
 	if (err || !mpages)
@@ -1179,6 +1353,7 @@ int drm_pagemap_evict_to_ram(struct drm_pagemap_devmem *devmem_allocation)
 	if (err)
 		drm_pagemap_migration_unlock_put_pages(npages, dst);
 	migrate_device_pages(src, dst, npages);
+	drm_pagemap_retire_migrated_pages(src, npages);
 	migrate_device_finalize(src, dst, npages);
 	drm_pagemap_migrate_unmap_pages(devmem_allocation->dev, pagemap_addr, dst, npages,
 					DMA_FROM_DEVICE, &state);
@@ -1276,6 +1451,14 @@ static int __drm_pagemap_migrate_to_ram(struct vm_area_struct *vas,
 	if (!migrate.cpages)
 		goto err_free;
 
+	/*
+	 * Reserve retirement entries before migration so recording successful
+	 * PFNs cannot fail. On failure, finalize can still restore the sources.
+	 */
+	err = drm_pagemap_reserve_retired_pages(migrate.src, npages);
+	if (err)
+		goto err_finalize;
+
 	ops = zdd->devmem_allocation->ops;
 	dev = zdd->devmem_allocation->dev;
 
@@ -1309,6 +1492,7 @@ static int __drm_pagemap_migrate_to_ram(struct vm_area_struct *vas,
 	if (err)
 		drm_pagemap_migration_unlock_put_pages(npages, migrate.dst);
 	migrate_vma_pages(&migrate);
+	drm_pagemap_retire_migrated_pages(migrate.src, npages);
 	migrate_vma_finalize(&migrate);
 	if (dev)
 		drm_pagemap_migrate_unmap_pages(dev, pagemap_addr, migrate.dst,
-- 
2.43.0

