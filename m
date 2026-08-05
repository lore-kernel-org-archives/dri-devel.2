Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F1DFC56203
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 11:33:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 321C310EE08;
	Wed,  5 Aug 2026 11:33:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="HzsXHKGV";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBA3810EDFE;
 Wed,  5 Aug 2026 11:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785929626; x=1817465626;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ZxPU7quEySN5Hl4qRC5WeOO+MTXBZUcrGg6kx4/kNtY=;
 b=HzsXHKGVVE66jmwwKlkP+56gBeVECnObgEulVQe6aL1+9DE07nic8+04
 3DLkE61T9tnHGZ9qg93T0wcWmTLqRAELdhjdgaTU6PwQbjkd6LZQx+wDX
 eZKn7Z+HLfb3C3k9o6/A2ihWy41/PcSr3LzG5nbCaXki53V1x/9Njf6pU
 6XmfPYGxnTc7utZbz4Dq2oy/K4DaOkQc/iujFfZPgPSrMTX8pPt8pXNih
 YPPnVR13IPQDpUguDLocMNBYTpLR33gr/TYGjVwf9HyMfhz+2r5UXkWN2
 W4NgChfuwoH9Q1a63OMRVabYN1T1cOhqKDDrqxSUgg+EPgXBlqgfUonz+ g==;
X-CSE-ConnectionGUID: Eb9QOtsvQ6mb96ja1BTD8Q==
X-CSE-MsgGUID: JdiaT49LRneUc0ux8rlcuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="86358191"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; d="scan'208";a="86358191"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 04:33:45 -0700
X-CSE-ConnectionGUID: TlTSTTbZQ92hntgr1WOfMQ==
X-CSE-MsgGUID: X+D8wfZAS76OZrI13c7G0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; d="scan'208";a="265289747"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 04:33:45 -0700
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
Subject: [PATCH 2/4] mm/migrate_device: Apply the fault reference to the
 correct folio
Date: Wed,  5 Aug 2026 04:33:36 -0700
Message-Id: <20260805113338.3742178-3-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260805113338.3742178-1-matthew.brost@intel.com>
References: <20260805113338.3742178-1-matthew.brost@intel.com>
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
Assisted-by: GitHub Copilot:claude-opus-5
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 mm/migrate_device.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index d1d81bbbf795..65a6a15dba4d 100644
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
@@ -1296,13 +1296,25 @@ static void __migrate_device_pages(unsigned long *src_pfns,
 
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

