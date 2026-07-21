Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1529C44529
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 10:40:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B56610E31E;
	Tue, 21 Jul 2026 10:40:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="HYx84yfQ";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C63DB10E31E
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 10:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784630450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lMBB8NPzJutyAd91w3CTHR/uxMV10C3bA9Lmy4Lky7c=;
 b=HYx84yfQPqPZZJ/wBsgu4bXQuwLHawC1WWQGCJMxRMjd5fgr4Yv/zg3NXvd0svSNGXuLOK
 sd46l/SNXNU2bS86qjLPIcO5vnNYRVRsd3qEfEfioJR8hcXu8LgH427B05CZLgcAuKhpDF
 26dhyPsPT1NARlrNe854E36JqCyxE+8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-282-JSa_CxNsNau24kR86n4Jdw-1; Tue,
 21 Jul 2026 06:40:47 -0400
X-MC-Unique: JSa_CxNsNau24kR86n4Jdw-1
X-Mimecast-MFC-AGG-ID: JSa_CxNsNau24kR86n4Jdw_1784630446
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B04F91935334; Tue, 21 Jul 2026 10:40:45 +0000 (UTC)
Received: from t14ultra.redhat.com (unknown [10.44.32.110])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 739921597; Tue, 21 Jul 2026 10:40:42 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, matthew.brost@intel.com, jstancek@redhat.com
Subject: [PATCH] drm/pagemap: Guard HPAGE_PMD_ORDER use with
 CONFIG_ARCH_ENABLE_THP_MIGRATION
Date: Tue, 21 Jul 2026 12:40:38 +0200
Message-ID: <84a35e16f72330d6e7b2d6e969040f36959e2dad.1784630290.git.jstancek@redhat.com>
In-Reply-To: <202607201914.LpAGsbXs-lkp@intel.com>
References: <202607201914.LpAGsbXs-lkp@intel.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: aZu0LL4HUAoZtYPKRQZ2BbZ7W3G0G_y6qUdNWASZ8YI_1784630446
X-Mimecast-Originator: redhat.com
Content-type: text/plain
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

Guard the two HPAGE_PMD_ORDER uses with CONFIG_ARCH_ENABLE_THP_MIGRATION,
matching the pattern used in migrate_device.c.

Fixes: 139ab31aea8a ("drm/pagemap: Correct cpages calculation for migrate_vma_setup")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202607201914.LpAGsbXs-lkp@intel.com/
Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 drivers/gpu/drm/drm_pagemap.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
index 15c78eca180b..53a78752c8be 100644
--- a/drivers/gpu/drm/drm_pagemap.c
+++ b/drivers/gpu/drm/drm_pagemap.c
@@ -578,10 +578,13 @@ static int drm_pagemap_cpages(unsigned long *migrate_pfn, unsigned long npages)
 			folio = page_folio(page);
 			order = folio_order(folio);
 			cpages += NR_PAGES(order);
-		} else if (migrate_pfn[i] & MIGRATE_PFN_COMPOUND) {
+		}
+#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
+		else if (migrate_pfn[i] & MIGRATE_PFN_COMPOUND) {
 			order = HPAGE_PMD_ORDER;
 			cpages += NR_PAGES(order);
 		}
+#endif
 
 		i += NR_PAGES(order);
 	}
@@ -733,7 +736,6 @@ int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem *devmem_allocation,
 	own_pages = 0;
 
 	for (i = 0; i < npages;) {
-		unsigned long j;
 		struct page *page = pfn_to_page(migrate.dst[i]);
 		struct page *src_page = migrate_pfn_to_page(migrate.src[i]);
 		unsigned int order = 0;
@@ -763,7 +765,10 @@ int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem *devmem_allocation,
 		}
 		migrate.dst[i] = migrate_pfn(migrate.dst[i]);
 
+#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
 		if (migrate.src[i] & MIGRATE_PFN_COMPOUND) {
+			unsigned long j;
+
 			drm_WARN_ONCE(dpagemap->drm, src_page &&
 				      folio_order(page_folio(src_page)) != HPAGE_PMD_ORDER,
 				      "Unexpected folio order\n");
@@ -774,6 +779,7 @@ int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem *devmem_allocation,
 			for (j = 1; j < NR_PAGES(order) && i + j < npages; j++)
 				migrate.dst[i + j] = 0;
 		}
+#endif
 
 		drm_pagemap_get_devmem_page(page, order, zdd);
 
-- 
2.52.0

