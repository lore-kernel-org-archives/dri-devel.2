Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B5CC55ABF
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 23:10:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73DA310E267;
	Wed,  5 Aug 2026 23:10:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="h4iQ/HXn";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC6C810E1CB;
 Wed,  5 Aug 2026 23:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785971450; x=1817507450;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dNJ/oi0EebM2qITDTJ9UJ0BoOZBi/aCxva+AfF14at8=;
 b=h4iQ/HXnzbq+E7mid6CFfpt+BtLj39uQZlTyNHtC9Vac0wGVUW2vbp6w
 y1RKOP8B2Ds0Fud3Su6fuJ6LeW1vHzRCmeWiEMmfQ2LcNR1pF4ByLzRA+
 vLzv2JMLlG1DQoQgNSNCAvrFXvPuIfIIw7X6JFtNr2jtPtKcz37b3N2B+
 b950YM+7Jqwuo9eXX/gAFKzlodfiYvGuBunNAvRK0rFS68Vr2o+JGlvW5
 qGpeO5b8h0EC3BJhcqDcpuLNXcGt4mF7OegTvqA+98Xdu5pSVgf4v42J8
 zXNL+fOn/SUpN2aQD65oIsKBnIuPrEYXF73XXgFle4d/kIUzCc3aB64No Q==;
X-CSE-ConnectionGUID: CcoUeZDKQTycTQDJvm+iAQ==
X-CSE-MsgGUID: O1k4wV4LT3ChodyfKEudpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="90376834"
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; d="scan'208";a="90376834"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 16:10:49 -0700
X-CSE-ConnectionGUID: gdzBu8tUSsWVVT+WYsw11w==
X-CSE-MsgGUID: Douz6uonSw2oqZmSx0TiGg==
X-ExtLoop1: 1
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 16:10:48 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Arvind Yadav <arvind.yadav@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>, Zi Yan <ziy@nvidia.com>,
 Balbir Singh <balbirs@nvidia.com>
Subject: [PATCH v3 1/6] mm/migrate_device: Clear stale mapping after freeing
 swapcache
Date: Wed,  5 Aug 2026 16:10:36 -0700
Message-Id: <20260805231041.3791771-2-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260805231041.3791771-1-matthew.brost@intel.com>
References: <20260805231041.3791771-1-matthew.brost@intel.com>
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

From: Arvind Yadav <arvind.yadav@intel.com>

__migrate_device_pages() reads the folio mapping before calling
folio_free_swap(). When folio_free_swap() succeeds, the folio is removed
from the swap cache, but the saved mapping still points to swap_space.

Passing the stale mapping to folio_migrate_mapping() makes it use the
mapped-folio path for a folio that is no longer in swapcache. It can
then operate on swap_space.i_pages with invalid reference accounting,
eventually triggering a folio reference count BUG.

After a successful split, nr still contains the number of pages in the
original large folio, although each resulting page is now a separate
order-0 folio. Reset nr to 1 so each split folio is processed separately,
including its own swapcache removal and mapping lookup.

Refresh the saved mapping after folio_free_swap() so the current folio
state is used during migration.

v2:
- Refresh the mapping using folio_mapping(), as suggested by Zi Yan.

v3:
- Reset nr to 1 after a successful split so each resulting folio is
  processed independently, as suggested by Zi Yan.

v4:
- Re-read each source folio's mapping immediately before
  folio_migrate_mapping(), as suggested by Balbir Singh.
- Add a warning to validate the post-split order-0 invariant,
  as suggested by Balbir Singh.

Fixes: df263d9a7dff ("mm/migrate_device: try to handle swapcache pages")
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Rakie Kim <rakie.kim@sk.com>
Cc: Byungchul Park <byungchul@sk.com>
Cc: Gregory Price <gourry@gourry.net>
Cc: Ying Huang <ying.huang@linux.alibaba.com>
Cc: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Balbir Singh <balbirs@nvidia.com>
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
---
 mm/migrate_device.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 908d2d4ec43a..162d29b2807a 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -1183,6 +1183,13 @@ static void __migrate_device_pages(unsigned long *src_pfns,
 							 MIGRATE_PFN_COMPOUND);
 					goto next;
 				}
+
+				/*
+				 * reset nr so that only first after-split folio
+				 * is processed below
+				 */
+				VM_WARN_ON_ONCE(folio_test_large(folio));
+				nr = 1;
 			} else if ((src_pfns[i] & MIGRATE_PFN_MIGRATE) &&
 				(dst_pfns[i] & MIGRATE_PFN_COMPOUND) &&
 				!(src_pfns[i] & MIGRATE_PFN_COMPOUND)) {
@@ -1222,6 +1229,12 @@ static void __migrate_device_pages(unsigned long *src_pfns,
 			folio = page_folio(migrate_pfn_to_page(src_pfns[i+j]));
 			newfolio = page_folio(migrate_pfn_to_page(dst_pfns[i+j]));
 
+			/*
+			 * folio_free_swap() removed the folio from the swap
+			 * cache. Refresh the saved mapping before migration.
+			 */
+			mapping = folio_mapping(folio);
+
 			r = folio_migrate_mapping(mapping, newfolio, folio, extra_cnt);
 			if (r)
 				src_pfns[i+j] &= ~MIGRATE_PFN_MIGRATE;
-- 
2.34.1

