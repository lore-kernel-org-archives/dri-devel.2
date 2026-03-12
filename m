Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5002106ACE1
	for <dri-devel@archiver.kernel.org>; Thu, 12 Mar 2026 19:21:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BE4510EAA1;
	Thu, 12 Mar 2026 19:21:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="DiJCWL6M";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4870210EA9A;
 Thu, 12 Mar 2026 19:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773343296; x=1804879296;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zP8jeYaKjQ3sXF0DctC9NkJug8q1xk4kr40CbW8MTSc=;
 b=DiJCWL6Mzg0uHNg3LeK8lN69Zpnmxorwz7hZnvPapXqriuWvIDe9vFI5
 J0Cxj/zSUC8nUUQn0mozXOOGwV69M6prqrFQNxYV160FVvyxEtpVwdvsS
 FUrmzGYbHnaXLZ1GJrR1KfCITvWbQDt3c3wcJdNkRiVSCTzCa1ZrKOnME
 n1JnVvUNLir6UwlzGDq8OsVzqWgFwsDp3GHVCmaT3GXs+9qZpnDDlrOl1
 yYxcW02z591qr/6qM6vy3a/+pgpjwwJAJ/Zw5ECGbyxJqlV56tyqnuzIE
 YXrRsQCeFTEE4hkZR/saBrdAoRUerT31uNaKjaD1G9Xhftz+Kzoyoa1w3 A==;
X-CSE-ConnectionGUID: 0Do4jiewTcyD1rxb2fdOGA==
X-CSE-MsgGUID: HQxR5vGTRzO0l+LGQHJKsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="78052712"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; d="scan'208";a="78052712"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2026 12:21:36 -0700
X-CSE-ConnectionGUID: XPRtzSEmTZ6sZdgepIMNQg==
X-CSE-MsgGUID: +sXstWD2RjOR3RfJy8aw1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; d="scan'208";a="221105073"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO fdugast-desk.home)
 ([10.245.245.89])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2026 12:21:35 -0700
From: Francois Dugast <francois.dugast@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Subject: [PATCH v9 2/4] drm/pagemap: Add helper to access zone_device_data
Date: Thu, 12 Mar 2026 20:20:12 +0100
Message-ID: <20260312192126.2024853-3-francois.dugast@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260312192126.2024853-1-francois.dugast@intel.com>
References: <20260312192126.2024853-1-francois.dugast@intel.com>
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

This new helper helps ensure all accesses to zone_device_data use the
correct API whether the page is part of a folio or not.

v2:
- Move to drm_pagemap.h, stick to folio_zone_device_data (Matthew Brost)
- Return struct drm_pagemap_zdd * (Matthew Brost)

v3:
- Add stub for !CONFIG_ZONE_DEVICE (CI)

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
Suggested-by: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Francois Dugast <francois.dugast@intel.com>
---
 drivers/gpu/drm/drm_gpusvm.c  |  7 +++++--
 drivers/gpu/drm/drm_pagemap.c | 21 ++++++++++++---------
 include/drm/drm_pagemap.h     | 21 +++++++++++++++++++++
 3 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
index 35dd07297dd0..4b928fda5b12 100644
--- a/drivers/gpu/drm/drm_gpusvm.c
+++ b/drivers/gpu/drm/drm_gpusvm.c
@@ -1488,12 +1488,15 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 		order = drm_gpusvm_hmm_pfn_to_order(pfns[i], i, npages);
 		if (is_device_private_page(page) ||
 		    is_device_coherent_page(page)) {
+			struct drm_pagemap_zdd *__zdd =
+				drm_pagemap_page_zone_device_data(page);
+
 			if (!ctx->allow_mixed &&
-			    zdd != page->zone_device_data && i > 0) {
+			    zdd != __zdd && i > 0) {
 				err = -EOPNOTSUPP;
 				goto err_unmap;
 			}
-			zdd = page->zone_device_data;
+			zdd = __zdd;
 			if (pagemap != page_pgmap(page)) {
 				if (pagemap) {
 					err = -EOPNOTSUPP;
diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
index f453a12b6a8e..733a3857947c 100644
--- a/drivers/gpu/drm/drm_pagemap.c
+++ b/drivers/gpu/drm/drm_pagemap.c
@@ -252,7 +252,7 @@ static int drm_pagemap_migrate_map_pages(struct device *dev,
 		order = folio_order(folio);
 
 		if (is_device_private_page(page)) {
-			struct drm_pagemap_zdd *zdd = page->zone_device_data;
+			struct drm_pagemap_zdd *zdd = drm_pagemap_page_zone_device_data(page);
 			struct drm_pagemap *dpagemap = zdd->dpagemap;
 			struct drm_pagemap_addr addr;
 
@@ -323,7 +323,7 @@ static void drm_pagemap_migrate_unmap_pages(struct device *dev,
 			goto next;
 
 		if (is_zone_device_page(page)) {
-			struct drm_pagemap_zdd *zdd = page->zone_device_data;
+			struct drm_pagemap_zdd *zdd = drm_pagemap_page_zone_device_data(page);
 			struct drm_pagemap *dpagemap = zdd->dpagemap;
 
 			dpagemap->ops->device_unmap(dpagemap, dev, &pagemap_addr[i]);
@@ -601,7 +601,8 @@ int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem *devmem_allocation,
 
 		pages[i] = NULL;
 		if (src_page && is_device_private_page(src_page)) {
-			struct drm_pagemap_zdd *src_zdd = src_page->zone_device_data;
+			struct drm_pagemap_zdd *src_zdd =
+				drm_pagemap_page_zone_device_data(src_page);
 
 			if (page_pgmap(src_page) == pagemap &&
 			    !mdetails->can_migrate_same_pagemap) {
@@ -723,8 +724,8 @@ static int drm_pagemap_migrate_populate_ram_pfn(struct vm_area_struct *vas,
 			goto next;
 
 		if (fault_page) {
-			if (src_page->zone_device_data !=
-			    fault_page->zone_device_data)
+			if (drm_pagemap_page_zone_device_data(src_page) !=
+			    drm_pagemap_page_zone_device_data(fault_page))
 				goto next;
 		}
 
@@ -1065,7 +1066,7 @@ static int __drm_pagemap_migrate_to_ram(struct vm_area_struct *vas,
 	void *buf;
 	int i, err = 0;
 
-	zdd = page->zone_device_data;
+	zdd = drm_pagemap_page_zone_device_data(page);
 	if (time_before64(get_jiffies_64(), zdd->devmem_allocation->timeslice_expiration))
 		return 0;
 
@@ -1148,7 +1149,9 @@ static int __drm_pagemap_migrate_to_ram(struct vm_area_struct *vas,
  */
 static void drm_pagemap_folio_free(struct folio *folio)
 {
-	drm_pagemap_zdd_put(folio->page.zone_device_data);
+	struct page *page = folio_page(folio, 0);
+
+	drm_pagemap_zdd_put(drm_pagemap_page_zone_device_data(page));
 }
 
 /**
@@ -1164,7 +1167,7 @@ static void drm_pagemap_folio_free(struct folio *folio)
  */
 static vm_fault_t drm_pagemap_migrate_to_ram(struct vm_fault *vmf)
 {
-	struct drm_pagemap_zdd *zdd = vmf->page->zone_device_data;
+	struct drm_pagemap_zdd *zdd = drm_pagemap_page_zone_device_data(vmf->page);
 	int err;
 
 	err = __drm_pagemap_migrate_to_ram(vmf->vma,
@@ -1230,7 +1233,7 @@ EXPORT_SYMBOL_GPL(drm_pagemap_devmem_init);
  */
 struct drm_pagemap *drm_pagemap_page_to_dpagemap(struct page *page)
 {
-	struct drm_pagemap_zdd *zdd = page->zone_device_data;
+	struct drm_pagemap_zdd *zdd = drm_pagemap_page_zone_device_data(page);
 
 	return zdd->devmem_allocation->dpagemap;
 }
diff --git a/include/drm/drm_pagemap.h b/include/drm/drm_pagemap.h
index c848f578e3da..75e6ca58922d 100644
--- a/include/drm/drm_pagemap.h
+++ b/include/drm/drm_pagemap.h
@@ -4,6 +4,7 @@
 
 #include <linux/dma-direction.h>
 #include <linux/hmm.h>
+#include <linux/memremap.h>
 #include <linux/types.h>
 
 #define NR_PAGES(order) (1U << (order))
@@ -367,6 +368,26 @@ void drm_pagemap_destroy(struct drm_pagemap *dpagemap, bool is_atomic_or_reclaim
 
 int drm_pagemap_reinit(struct drm_pagemap *dpagemap);
 
+/**
+ * drm_pagemap_page_zone_device_data() - Page to zone_device_data
+ * @page: Pointer to the page
+ *
+ * Return: Page's zone_device_data
+ */
+static inline struct drm_pagemap_zdd *drm_pagemap_page_zone_device_data(struct page *page)
+{
+	struct folio *folio = page_folio(page);
+
+	return folio_zone_device_data(folio);
+}
+
+#else
+
+static inline struct drm_pagemap_zdd *drm_pagemap_page_zone_device_data(struct page *page)
+{
+	return NULL;
+}
+
 #endif /* IS_ENABLED(CONFIG_ZONE_DEVICE) */
 
 #endif
-- 
2.43.0

