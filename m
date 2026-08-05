Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24FAFC561E6
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 23:10:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D827C10F010;
	Wed,  5 Aug 2026 23:10:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="eCI0xsDr";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F0F210E042;
 Wed,  5 Aug 2026 23:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785971450; x=1817507450;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/Jjq0f7O0WvJkLs4JYtXmw67Rzu5MIrXEQREZTu1NqM=;
 b=eCI0xsDr3XbYAZPXr9BgVitOFfMPxSdQhSnqx3zFB6mbUQHPrfTHwnLZ
 USziWKIVhfANaAZx3BqTU8s/iW3hyESe9szsFzRZHf0S/q1aDmXvnpjLx
 bp9NcgK41g8cqtM3YZ7kKXxDBmCfJQT7rV+PWfRuc/yOcSETGHGApmc1+
 S7eODP/LTca/wYI2GIC4ersDIV9bd5t8kMO6B6EP3yIcfCGOuo+wi9l6n
 6b7Nzh+AXIw3i7v8m1bfkPCnBvj+9JLVZg1xo9P0yf0x/HYqPMO9eVy4S
 nPZPDMMTgNkpaiWhoGOZZAN10KpmeMm10F2PQLE0+6ifeNesoOBDHpHcd Q==;
X-CSE-ConnectionGUID: MnfSCjwYTomOxu6UBMYi9w==
X-CSE-MsgGUID: /oJNZQCmTaevUOyZHwWo3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="90376846"
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; d="scan'208";a="90376846"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 16:10:49 -0700
X-CSE-ConnectionGUID: dbZ5mZZVTkeTIfdkt0zbgA==
X-CSE-MsgGUID: 9Pr+QSRTQgSOCeG8Ps6dLQ==
X-ExtLoop1: 1
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 16:10:49 -0700
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
Subject: [PATCH v3 2/6] mm/migrate_device: Do not write past the end of the
 src_pfns array
Date: Wed,  5 Aug 2026 16:10:37 -0700
Message-Id: <20260805231041.3791771-3-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260805231041.3791771-1-matthew.brost@intel.com>
References: <20260805231041.3791771-1-matthew.brost@intel.com>
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

migrate_device_range() and migrate_device_pfns() zero the tail entries
of a large folio without checking them against @npages:

	for (j = 1; j < nr; j++)
		src_pfns[i+j] = 0;

@nr comes from the folio, not from the array, so a folio that extends
past the end of the range being migrated writes beyond src_pfns[].
Callers size that array for @npages entries, so this corrupts whatever
follows it.

Bound the loop by @npages. The subsequent "i += j - 1" still terminates
the outer loop correctly: on a bounded exit j is @npages - i, leaving i
at @npages after the increment.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: a30b48bf1b24 ("mm/migrate_device: implement THP migration of zone device pages")
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
 mm/migrate_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 162d29b2807a..ae9027421b80 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -1415,7 +1415,7 @@ int migrate_device_range(unsigned long *src_pfns, unsigned long start,
 		nr = folio_nr_pages(folio);
 		if (nr > 1) {
 			src_pfns[i] |= MIGRATE_PFN_COMPOUND;
-			for (j = 1; j < nr; j++)
+			for (j = 1; j < nr && (i + j) < npages; j++)
 				src_pfns[i+j] = 0;
 			i += j - 1;
 			pfn += j - 1;
@@ -1449,7 +1449,7 @@ int migrate_device_pfns(unsigned long *src_pfns, unsigned long npages)
 		nr = folio_nr_pages(folio);
 		if (nr > 1) {
 			src_pfns[i] |= MIGRATE_PFN_COMPOUND;
-			for (j = 1; j < nr; j++)
+			for (j = 1; j < nr && (i + j) < npages; j++)
 				src_pfns[i+j] = 0;
 			i += j - 1;
 		}
-- 
2.34.1

