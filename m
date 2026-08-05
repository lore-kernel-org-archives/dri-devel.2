Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A20C56207
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 19:35:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF27410EFA7;
	Wed,  5 Aug 2026 19:35:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="c4xhq9kk";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 453F210E0FB;
 Wed,  5 Aug 2026 19:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785958544; x=1817494544;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DwXjrp0YOMKqBIa0CyQY66LJvCKzj79JzvSlROjOOxA=;
 b=c4xhq9kkjFjzbnuCgiK9xudiX7k3PGRahsUiZeTYFoLxqVwOWQ7c7uSN
 2cTkGMMRW23UYcT+wXe5u3Wa6W0sMsGCz5agbyfz59brvecH4NKA+beRA
 /mtNtn0eCbBWQeZzxB3UxywM4F7o0w0yStqvRJUikfboD7kc7ymbaTJAk
 +EKJm7QZsMY8nkuKImCckleaMZTYnkoX8cXDamCoYAOJXWnBI1A3qOmWC
 wYaoqMZDz5RwlLxzzsyw3OQ5HIXZzRXvrGhuK0IJrGoZmts5o2InslBeK
 CFIPGg7q/lI9t7ERT19m3RUgB+yVOzF/nDoITkbPEul4tsthYohodFTh2 Q==;
X-CSE-ConnectionGUID: d6ro364NRLSuA7FccJzeOg==
X-CSE-MsgGUID: fcKVpC24QYW5YDLR3rCrLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="109332957"
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; d="scan'208";a="109332957"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 12:35:44 -0700
X-CSE-ConnectionGUID: CujDtT0BQmaBotcPTuJkwA==
X-CSE-MsgGUID: sX6rfqqERo6FgsdinoenMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; d="scan'208";a="285263527"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 12:35:43 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Usama Arif <usama.arif@linux.dev>, Joshua Hahn <joshua.hahnjy@gmail.com>,
 Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>,
 Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>, Balbir Singh <balbirs@nvidia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Francois Dugast <francois.dugast@intel.com>, stable@vger.kernel.org
Subject: [PATCH v2 3/5] mm/migrate_device: Apply the fault reference to the
 correct folio
Date: Wed,  5 Aug 2026 12:35:34 -0700
Message-Id: <20260805193536.3756457-4-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260805193536.3756457-1-matthew.brost@intel.com>
References: <20260805193536.3756457-1-matthew.brost@intel.com>
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

__migrate_device_pages() computed extra_cnt once, from the head page of
the source folio, and then passed the same value to
folio_migrate_mapping() for every one of the @nr sub-folios produced by
migrate_vma_split_unmapped_folio().

The extra reference the CPU fault holds only exists on the single folio
that ends up containing the fault page. Claiming it for all of them
makes folio_migrate_mapping() expect one reference too many on every
other sub-folio, so it returns -EAGAIN and MIGRATE_PFN_MIGRATE is
cleared for them. Only the fault page would migrate; the remaining
HPAGE_PMD_NR - 1 pages would be restored to device memory, and the
faulting access would immediately fault again.

Compute extra_cnt per sub-folio instead, comparing against the source
page for that entry.

While at it, use the sub-folio's own mapping rather than the mapping
that was read from the pre-split folio.

This has been latent so far because the split it depends on could never
succeed while the fault reference was held.

Fixes: 4265d67e405a ("mm/migrate_device: add THP splitting during migration")
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Nico Pache <nico.pache@linux.dev>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Lance Yang <lance.yang@linux.dev>
Cc: Usama Arif <usama.arif@linux.dev>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Rakie Kim <rakie.kim@sk.com>
Cc: Byungchul Park <byungchul@sk.com>
Cc: Gregory Price <gourry@gourry.net>
Cc: Ying Huang <ying.huang@linux.alibaba.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Balbir Singh <balbirs@nvidia.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Francois Dugast <francois.dugast@intel.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Assisted-by: GitHub_Copilot:claude-opus-5
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 mm/migrate_device.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 142920a464d8..4ee09801efe6 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -1191,7 +1191,7 @@ static void __migrate_device_pages(unsigned long *src_pfns,
 		struct page *page = migrate_pfn_to_page(src_pfns[i]);
 		struct address_space *mapping;
 		struct folio *newfolio, *folio;
-		int r, extra_cnt = 0;
+		int r;
 		unsigned long nr = 1;
 
 		if (!newpage) {
@@ -1301,13 +1301,25 @@ static void __migrate_device_pages(unsigned long *src_pfns,
 
 		BUG_ON(folio_test_writeback(folio));
 
-		if (migrate && migrate->fault_page == page)
-			extra_cnt = 1;
 		for (j = 0; j < nr && i + j < npages; j++) {
-			folio = page_folio(migrate_pfn_to_page(src_pfns[i+j]));
+			struct page *src_page = migrate_pfn_to_page(src_pfns[i+j]);
+			int extra_cnt = 0;
+
+			folio = page_folio(src_page);
 			newfolio = page_folio(migrate_pfn_to_page(dst_pfns[i+j]));
 
-			r = folio_migrate_mapping(mapping, newfolio, folio, extra_cnt);
+			/*
+			 * The CPU fault holds an extra reference on the folio
+			 * containing the fault page. @folio may have been
+			 * split above, so the fault page only accounts for an
+			 * extra reference on the folio it actually ended up
+			 * in, not on every folio of the original THP.
+			 */
+			if (migrate && migrate->fault_page == src_page)
+				extra_cnt = 1;
+
+			r = folio_migrate_mapping(folio_mapping(folio), newfolio,
+						  folio, extra_cnt);
 			if (r)
 				src_pfns[i+j] &= ~MIGRATE_PFN_MIGRATE;
 			else
-- 
2.34.1

