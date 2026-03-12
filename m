Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 035C1106ACDD
	for <dri-devel@archiver.kernel.org>; Thu, 12 Mar 2026 19:21:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EA3C10EA9F;
	Thu, 12 Mar 2026 19:21:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="PJUJXlRm";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EFE910EA91;
 Thu, 12 Mar 2026 19:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773343295; x=1804879295;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9wlp+jrtDpxq4glZ8+eKbGQvQDzLZWbncMGoqU85Tfk=;
 b=PJUJXlRm7S2hp05Uku/Tl3u1F5XCGAkN2KD2AMP19aFv20BV1+W8ca9H
 gW6vSmhx0u/44LyJWO39xOPOAyXkFT82y+QQtuxlW1e98j9bBPWBm4bUE
 7xHDcOyZ2Ij3g0fsg1zgaWkbS6G35Xnak2/jG47N6WtJcB+BfrP+YoRZL
 kj7oeYUUB07rFVcrhvmDV5iGq/t3v9mcQezJPrHE+uAjyw20MHETC9KaN
 oIYKbycp6SalFKC+iVTNeHGkoz9k6jkpbkKEcImi8gH0hboTRfrx0sqy2
 bzF+Re9QPy32ybwFezZ9dOmprmeKVGViPKpUEW8ck5yFkXiDcbJ1Cbe5Y g==;
X-CSE-ConnectionGUID: 01EKMwWuQV6XB4alvV+R4Q==
X-CSE-MsgGUID: jUMPgaykQ3uyWhJFk0fHkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="78052710"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; d="scan'208";a="78052710"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2026 12:21:35 -0700
X-CSE-ConnectionGUID: TwwJfPOnQOO5i/aGW2JQqA==
X-CSE-MsgGUID: AQ/sviqKR06J9GZJ6uuW3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; d="scan'208";a="221105057"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO fdugast-desk.home)
 ([10.245.245.89])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2026 12:21:34 -0700
From: Francois Dugast <francois.dugast@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Subject: [PATCH v9 1/4] drm/pagemap: Unlock and put folios when possible
Date: Thu, 12 Mar 2026 20:20:11 +0100
Message-ID: <20260312192126.2024853-2-francois.dugast@intel.com>
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

If the page is part of a folio, unlock and put the whole folio at once
instead of individual pages one after the other. This will reduce the
amount of operations once device THP are in use.

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
Reviewed-by: Balbir Singh <balbirs@nvidia.com>
---
 drivers/gpu/drm/drm_pagemap.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
index 862675ac5bb2..f453a12b6a8e 100644
--- a/drivers/gpu/drm/drm_pagemap.c
+++ b/drivers/gpu/drm/drm_pagemap.c
@@ -154,15 +154,15 @@ static void drm_pagemap_zdd_put(struct drm_pagemap_zdd *zdd)
 }
 
 /**
- * drm_pagemap_migration_unlock_put_page() - Put a migration page
- * @page: Pointer to the page to put
+ * drm_pagemap_migration_unlock_put_folio() - Put a migration folio
+ * @folio: Pointer to the folio to put
  *
- * This function unlocks and puts a page.
+ * This function unlocks and puts a folio.
  */
-static void drm_pagemap_migration_unlock_put_page(struct page *page)
+static void drm_pagemap_migration_unlock_put_folio(struct folio *folio)
 {
-	unlock_page(page);
-	put_page(page);
+	folio_unlock(folio);
+	folio_put(folio);
 }
 
 /**
@@ -177,15 +177,23 @@ static void drm_pagemap_migration_unlock_put_pages(unsigned long npages,
 {
 	unsigned long i;
 
-	for (i = 0; i < npages; ++i) {
+	for (i = 0; i < npages;) {
 		struct page *page;
+		struct folio *folio;
+		unsigned int order = 0;
 
 		if (!migrate_pfn[i])
-			continue;
+			goto next;
 
 		page = migrate_pfn_to_page(migrate_pfn[i]);
-		drm_pagemap_migration_unlock_put_page(page);
+		folio = page_folio(page);
+		order = folio_order(folio);
+
+		drm_pagemap_migration_unlock_put_folio(folio);
 		migrate_pfn[i] = 0;
+
+next:
+		i += NR_PAGES(order);
 	}
 }
 
-- 
2.43.0

