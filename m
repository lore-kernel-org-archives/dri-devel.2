Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0033C4452D
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 22:32:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F16E110E249;
	Tue, 21 Jul 2026 22:32:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="donYVceI";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81CA310E249;
 Tue, 21 Jul 2026 22:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784673170; x=1816209170;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=wBW8/xWz5cZP3mB4Ua+X/jgwLVYSyDNCUMD6EfqGOFg=;
 b=donYVceI+rTWJQy2eJElnsU4RkhpL36izItQV3t3OS6buc1YiNMPP108
 Tk2z6XtWIK08IqAAI3d0Flypjunu4c3/jbXHjnbyPVtTSpr5+1dRFkkBi
 CE9AeDp/gMNxet5qO86k9zRhi7ixzlVb2+dEcd6OYNp9MBqQY5TkHkIZH
 2lHzSlJv2EvtQcf27tzwFOsp3KqAr6A1H0LcL1ht20u0HeZ+IF+FcgTij
 OWxIiU5/AY4XwRFy1HqSVU3HBrEOrQmgKCDDKUmcY/sPSrYCstfNuobX6
 y+sflK9zjC63TozDFyWR+fMCAiWV1hV1XzLkMoaijbdTlOozNuGa822y2 w==;
X-CSE-ConnectionGUID: /2Yb+1agQ3WWLVI4qzxAtA==
X-CSE-MsgGUID: efmJp/x/QGa9/40ykb0rew==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="87825837"
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; d="scan'208";a="87825837"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 15:32:50 -0700
X-CSE-ConnectionGUID: qCE4QiNUR0OnHLZzQ+QIDA==
X-CSE-MsgGUID: 6tmxdz9FSfWt0YGy2NHQEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; d="scan'208";a="257358806"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 15:32:50 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel test robot <lkp@intel.com>,
	Jan Stancek <jstancek@redhat.com>
Subject: [PATCH] drm/pagemap: Guard HPAGE_PMD_ORDER use with
 CONFIG_ARCH_ENABLE_THP_MIGRATION
Date: Tue, 21 Jul 2026 15:32:44 -0700
Message-Id: <20260721223244.1102276-1-matthew.brost@intel.com>
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

HPAGE_PMD_SHIFT expands to BUILD_BUG() when CONFIG_PGTABLE_HAS_HUGE_LEAVES
is not set, causing a compile error when both CONFIG_TRANSPARENT_HUGEPAGE
and CONFIG_HUGETLB_PAGE are disabled:

 drivers/gpu/drm/drm_pagemap.c:480:12: error: call to '__compiletime_assert_458'
 declared with 'error' attribute: BUILD_BUG failed
   480 |                         order = HPAGE_PMD_ORDER;
       |                                 ^
 include/linux/huge_mm.h:117:26: note: expanded from macro 'HPAGE_PMD_ORDER'
   117 | #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
       |                          ^
 include/linux/huge_mm.h:113:28: note: expanded from macro 'HPAGE_PMD_SHIFT'
   113 | #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })

Define DRM_PAGEMAP_PMD_ORDER, which maps to HPAGE_PMD_ORDER when
CONFIG_ARCH_ENABLE_THP_MIGRATION is enabled and to -1 otherwise.

This is safe because all code paths that use DRM_PAGEMAP_PMD_ORDER are
reachable only when CONFIG_ARCH_ENABLE_THP_MIGRATION is enabled.

Fixes: 139ab31aea8a ("drm/pagemap: Correct cpages calculation for migrate_vma_setup")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202607201914.LpAGsbXs-lkp@intel.com/
Cc: Jan Stancek <jstancek@redhat.com>
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/drm_pagemap.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
index 15c78eca180b..951cd92c930c 100644
--- a/drivers/gpu/drm/drm_pagemap.c
+++ b/drivers/gpu/drm/drm_pagemap.c
@@ -12,6 +12,12 @@
 #include <drm/drm_pagemap_util.h>
 #include <drm/drm_print.h>
 
+#if IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION)
+#define DRM_PAGEMAP_PMD_ORDER	HPAGE_PMD_ORDER
+#else
+#define DRM_PAGEMAP_PMD_ORDER	(-1)
+#endif
+
 /**
  * DOC: Overview
  *
@@ -579,7 +585,7 @@ static int drm_pagemap_cpages(unsigned long *migrate_pfn, unsigned long npages)
 			order = folio_order(folio);
 			cpages += NR_PAGES(order);
 		} else if (migrate_pfn[i] & MIGRATE_PFN_COMPOUND) {
-			order = HPAGE_PMD_ORDER;
+			order = DRM_PAGEMAP_PMD_ORDER;
 			cpages += NR_PAGES(order);
 		}
 
@@ -765,10 +771,11 @@ int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem *devmem_allocation,
 
 		if (migrate.src[i] & MIGRATE_PFN_COMPOUND) {
 			drm_WARN_ONCE(dpagemap->drm, src_page &&
-				      folio_order(page_folio(src_page)) != HPAGE_PMD_ORDER,
+				      folio_order(page_folio(src_page)) !=
+				      DRM_PAGEMAP_PMD_ORDER,
 				      "Unexpected folio order\n");
 
-			order = HPAGE_PMD_ORDER;
+			order = DRM_PAGEMAP_PMD_ORDER;
 			migrate.dst[i] |= MIGRATE_PFN_COMPOUND;
 
 			for (j = 1; j < NR_PAGES(order) && i + j < npages; j++)
-- 
2.34.1

