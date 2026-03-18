Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A689910706ED
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 10:47:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06C8610E0C0;
	Wed, 18 Mar 2026 10:47:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bd2ETAmO";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AA5110E0C0
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 10:47:37 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 52AE44472D;
 Wed, 18 Mar 2026 10:47:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A9DC19421;
 Wed, 18 Mar 2026 10:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773830852;
 bh=dRszLAd6DXvZtZhPtd5ecMsXOYNS/5U7Q8vYrgBZxhY=;
 h=From:To:Cc:Subject:Date:From;
 b=bd2ETAmO9OJ+/PxxALsld43KNUSrLfW0e3cjXRDh73QzjBv0ykDF/dJnxbNoE36Gn
 oGCdyqW+JXte4kqU0Ga6re2iUQQU4LeyeKUGGN0wuMurtrk0Ura31uASu4v3uVp21k
 TAQWU12cwTGxPY80ffZyfCj4ARvcGArTQEDjM49OexGHYRQrlNR8erXzcuwhxleb+Z
 7WY/RcbtQ2trCqmKwuPWnAi7P46hHJv672kbBT5Ki/5HRFR1PpxIPwaajmxqrCXyat
 X6QwqJc48++C1i6edRE0BD3nT1cOuqwYzz+Ezr8nY/M7qEeIZ7A8SfF3qYM15cMRnw
 l5C0fzK0Lg2BA==
From: Arnd Bergmann <arnd@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Matthew Brost <matthew.brost@intel.com>,
 Francois Dugast <francois.dugast@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Balbir Singh <balbirs@nvidia.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/pagemap: avoid referencing HPAGE_PMD_ORDER for
 non-hugepage builds
Date: Wed, 18 Mar 2026 11:46:20 +0100
Message-Id: <20260318104637.1794243-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
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

From: Arnd Bergmann <arnd@arndb.de>

HPAGE_PMD_SHIFT/HPAGE_PMD_ORDER can only be used in configurations
that allow hugepages, but forces a build error otherwise:

drivers/gpu/drm/drm_pagemap.c:671:48: error: call to '__compiletime_assert_608' declared with 'error' attribute: BUILD_BUG failed
  671 |                                       folio_order(page_folio(src_page)) != HPAGE_PMD_ORDER,
      |                                                                            ^
include/linux/huge_mm.h:117:26: note: expanded from macro 'HPAGE_PMD_ORDER'
  117 | #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
      |                          ^
include/linux/huge_mm.h:113:28: note: expanded from macro 'HPAGE_PMD_SHIFT'
  113 | #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
      |                            ^
include/linux/build_bug.h:60:21: note: expanded from macro 'BUILD_BUG'
   60 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
      |                     ^
note: (skipping 2 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
include/linux/compiler_types.h:697:2: note: expanded from macro '_compiletime_assert'
  697 |         __compiletime_assert(condition, msg, prefix, suffix)
      |         ^

Hide this inside of a check for CONFIG_PGTABLE_HAS_HUGE_LEAVES.

Fixes: 192cb1f5cb16 ("drm/pagemap: Enable THP support for GPU memory migration")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Not sure if this is the best approach, as the BUILD_BUG_ON() and
drm_WARN_ONCE() check for similar failures, and this would bypass
both checks.
---
 drivers/gpu/drm/drm_pagemap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
index 6ac980bd8f3d..7463aec0db82 100644
--- a/drivers/gpu/drm/drm_pagemap.c
+++ b/drivers/gpu/drm/drm_pagemap.c
@@ -479,7 +479,8 @@ static int drm_pagemap_cpages(unsigned long *migrate_pfn, unsigned long npages)
 			folio = page_folio(page);
 			order = folio_order(folio);
 			cpages += NR_PAGES(order);
-		} else if (migrate_pfn[i] & MIGRATE_PFN_COMPOUND) {
+		} else if (IS_ENABLED(CONFIG_PGTABLE_HAS_HUGE_LEAVES) &&
+			   migrate_pfn[i] & MIGRATE_PFN_COMPOUND) {
 			order = HPAGE_PMD_ORDER;
 			cpages += NR_PAGES(order);
 		}
@@ -666,7 +667,8 @@ int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem *devmem_allocation,
 		}
 		migrate.dst[i] = migrate_pfn(migrate.dst[i]);
 
-		if (migrate.src[i] & MIGRATE_PFN_COMPOUND) {
+		if (IS_ENABLED(CONFIG_PGTABLE_HAS_HUGE_LEAVES) &&
+		    migrate.src[i] & MIGRATE_PFN_COMPOUND) {
 			drm_WARN_ONCE(dpagemap->drm, src_page &&
 				      folio_order(page_folio(src_page)) != HPAGE_PMD_ORDER,
 				      "Unexpected folio order\n");
-- 
2.39.5

