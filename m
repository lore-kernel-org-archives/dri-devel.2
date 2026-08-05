Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A4B5C55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 04:43:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AC8010E14E;
	Wed,  5 Aug 2026 04:43:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="oIQ5WElP";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C43410E14D;
 Wed,  5 Aug 2026 04:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785905036; x=1817441036;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=iZUryQ1JGcwGzfLzR/LhB0prUQc9/c0XSXjY04aj37w=;
 b=oIQ5WElPYirllnqaXQhE8tAAewgIumxPko5QgfVwJ6EzjqUPw8Zbprg3
 dB4GSlU1o46y9y1LTaScuPwsatzPCh47Z+5nLTa4nFu7nmK78cepaRFDE
 5ZXtHVmpUpj/PhTXaI/RzOpP6imsflb9vKBZtJr/ezGg3rGMVmkkjl9jQ
 cKb9Wt5mfU3z4JemOL3ShobN6v6PcQzwSX5tGn3UkCGJw+pGmOekO1K/3
 1qXTfTK+p+t3jElrJ/M0N5LyMDA+qCCKGD7t4MMsCuiP/adcO/ID5Q4bc
 FpsrS7ZFVhDTDo01oqZ5jABXcbtQgYBSyrDzh5aHOGIxb4DnFzv+l0ZOo A==;
X-CSE-ConnectionGUID: qscDZGo1RDO4e3T2pohTsA==
X-CSE-MsgGUID: z0Fq1pfeQ9KhMdVKeEzv5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="86669077"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; d="scan'208";a="86669077"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2026 21:43:56 -0700
X-CSE-ConnectionGUID: 85Yomf12RCCQoqACo/OBDg==
X-CSE-MsgGUID: d8iqGzXYQACwsoQWRpew1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; d="scan'208";a="259057014"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2026 21:43:55 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org
Subject: [PATCH] drm/pagemap: Fix folio allocation fallback and use-after-put
Date: Tue,  4 Aug 2026 21:43:49 -0700
Message-Id: <20260805044349.3474498-1-matthew.brost@intel.com>
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

drm_pagemap_migrate_populate_ram_pfn() had two issues when populating
RAM PFNs with higher-order folios:

1. The higher-order vma_alloc_folio()/folio_alloc() calls did not pass
   __GFP_NOWARN, so a THP allocation failure under memory pressure
   would spam the kernel log, and there was no fallback path despite a
   TODO comment stating one was needed. Add __GFP_NOWARN to the
   higher-order allocation and, on failure, fall back to order-0
   allocations for the entire range originally covered by the failed
   higher-order allocation, leaving MIGRATE_PFN_COMPOUND unset for
   those PFNs.

2. In the free_pages error path, order was computed via
   folio_order(page_folio(page)) *after* put_page(page) had already
   dropped the reference, resulting in a use-after-free/put when that
   was the last reference on the page. Compute order before releasing
   the page.

Fixes: ddeda6136038 ("drm/pagemap: Allocate folios when possible")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-sonnet-5
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/drm_pagemap.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
index 892b325fa99b..fb939fda80e8 100644
--- a/drivers/gpu/drm/drm_pagemap.c
+++ b/drivers/gpu/drm/drm_pagemap.c
@@ -891,11 +891,34 @@ static int drm_pagemap_migrate_populate_ram_pfn(struct vm_area_struct *vas,
 
 		order = folio_order(page_folio(src_page));
 
-		/* TODO: Support fallback to single pages if THP allocation fails */
 		if (vas)
-			folio = vma_alloc_folio(GFP_HIGHUSER, order, vas, addr);
+			folio = vma_alloc_folio(GFP_HIGHUSER | __GFP_NOWARN, order, vas, addr);
 		else
-			folio = folio_alloc(GFP_HIGHUSER, order);
+			folio = folio_alloc(GFP_HIGHUSER | __GFP_NOWARN, order);
+
+		if (!folio && order) {
+			/*
+			 * Higher-order allocation failed, fall back to
+			 * order-0 allocations for the entire range covered
+			 * by the original higher-order allocation, without
+			 * setting MIGRATE_PFN_COMPOUND, until we move past
+			 * that range.
+			 */
+			unsigned long nr = NR_PAGES(order);
+			unsigned long j;
+
+			for (j = 0; j < nr; j++, i++, addr += PAGE_SIZE) {
+				folio = vas ?
+					vma_alloc_folio(GFP_HIGHUSER, 0, vas, addr) :
+					folio_alloc(GFP_HIGHUSER, 0);
+				if (!folio)
+					goto free_pages;
+
+				page = folio_page(folio, 0);
+				mpfn[i] = migrate_pfn(page_to_pfn(page));
+			}
+			continue;
+		}
 
 		if (!folio)
 			goto free_pages;
@@ -940,11 +963,11 @@ static int drm_pagemap_migrate_populate_ram_pfn(struct vm_area_struct *vas,
 		if (!page)
 			goto next_put;
 
+		order = folio_order(page_folio(page));
+
 		put_page(page);
 		mpfn[i] = 0;
 
-		order = folio_order(page_folio(page));
-
 next_put:
 		i += NR_PAGES(order);
 	}
-- 
2.34.1

