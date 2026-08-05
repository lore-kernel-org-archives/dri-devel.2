Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60FBFC561E6
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 19:35:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9632610EFCA;
	Wed,  5 Aug 2026 19:35:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="aFXJ7nl8";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F1EE10E0FB;
 Wed,  5 Aug 2026 19:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785958543; x=1817494543;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0YG7iyYcbF3G1EFKh9ioNjadG3W1OhFnqKUemvuHbQY=;
 b=aFXJ7nl8Xmg/f4pCVnXKOv7sXt4lReF8lalt/qP/NJB1GLFaD1E/Ee0M
 77FxEdEW6ED11ZWvmeW9/N3jCf/pnzfvNqMX6YUkeh5TLHM6e129WVbAT
 JLWdrx2lt6QzKT7t7KefTmqQBmdcGTJ2oW4gpXEamLPgRdIAbTbhAcUYG
 LXX2Bbe9Q7XXL4ML91YIhM7MFPYJqsBGNCUV2+q1aU3GnCfgqEppplu4j
 KddoZM1nS95jjSXqm96W+GEadsKDLGRT+jALzSsHMujNU4ISrHe5Q5x3o
 iEl2OPBjvoqW19ec5H7zvVpE4h6uBL1sM22bLC3shLOXLfPZ0jdQfJNhs g==;
X-CSE-ConnectionGUID: 9Vxu77AJQIKmzxOyR45zOw==
X-CSE-MsgGUID: ga2vXmbKSJaLLooI7GYldw==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="109332919"
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; d="scan'208";a="109332919"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 12:35:42 -0700
X-CSE-ConnectionGUID: +IlgXOyXTU+bAoeSzcnfsg==
X-CSE-MsgGUID: aH+F8fM8RHmiW/7pNd/qeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; d="scan'208";a="285263519"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 12:35:42 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Sashiko <sashiko-bot@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
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
Subject: [PATCH v2 1/5] mm/migrate_device: Clear MIGRATE_PFN_MIGRATE on all
 sub-folios of a split THP
Date: Wed,  5 Aug 2026 12:35:32 -0700
Message-Id: <20260805193536.3756457-2-matthew.brost@intel.com>
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

migrate_vma_split_unmapped_folio() propagates MIGRATE_PFN_MIGRATE from
the head entry to all HPAGE_PMD_NR entries of src_pfns[]. The two
bailouts below it in __migrate_device_pages() only cleared the head, and
the "next" label then advances by @nr, so the tails keep the flag and a
valid destination without ever going through folio_migrate_mapping().
migrate_vma_finalize() then maps unpopulated destination folios into
userspace.

Clear the flag across the whole @nr range at both bailouts.

Reported-by: Sashiko <sashiko-bot@kernel.org>
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
 mm/migrate_device.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 908d2d4ec43a..d37a96cc6335 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -1199,10 +1199,14 @@ static void __migrate_device_pages(unsigned long *src_pfns,
 				 * device private or coherent memory.
 				 *
 				 * Try to get rid of swap cache if possible.
+				 *
+				 * @folio may have been split into @nr folios
+				 * above, so clear all of them.
 				 */
 				if (!folio_test_anon(folio) ||
 				    !folio_free_swap(folio)) {
-					src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
+					for (j = 0; j < nr && i + j < npages; j++)
+						src_pfns[i+j] &= ~MIGRATE_PFN_MIGRATE;
 					goto next;
 				}
 			}
@@ -1210,7 +1214,8 @@ static void __migrate_device_pages(unsigned long *src_pfns,
 			/*
 			 * Other types of ZONE_DEVICE page are not supported.
 			 */
-			src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
+			for (j = 0; j < nr && i + j < npages; j++)
+				src_pfns[i+j] &= ~MIGRATE_PFN_MIGRATE;
 			goto next;
 		}
 
-- 
2.34.1

