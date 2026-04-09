Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ABAA10FC456
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 01:55:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0F5610E054;
	Thu,  9 Apr 2026 01:55:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="k1YWy19Q";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F58C10E054;
 Thu,  9 Apr 2026 01:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775699723; x=1807235723;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=vxbJAYaPMU7ih0grmsulTu1jSyuYGS8R/7Kh74RBTQE=;
 b=k1YWy19QIyCdBA+YMhshox7WiUPhzdiCwg5EyPJYKY89kflJowIA21vN
 WF1Cpe8gPyBu/SadCAsPoNRdayzR/AIiz/PKedG67FJ4umbBGD4H0vBdJ
 Czku9OYyqmd8KL8OcxTjF2k+RFh32+hUqsUeThJFaWzCLl91voK766qpT
 +xRrWWo94KBe78a/YjIicZrnkSk0A/SDtmcwmu1Jyr14BdaINdABf6fIh
 YrBcAp8Vn6mS8Ve912fL6xkEOh3mOK01gp/4E7+GeBRjXKUo8ssQM2O+/
 dsaX9tsc4ock915Cu+vvU/tHMJqYbo42a8MtFn1plnBxlPruS4Bs0HGiI A==;
X-CSE-ConnectionGUID: jrbYGIiER6KUe3hBHX41iw==
X-CSE-MsgGUID: 6zAgEXC2RxmPInRWomVMWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="94085797"
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; d="scan'208";a="94085797"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 18:55:22 -0700
X-CSE-ConnectionGUID: vh7VlRmlRuig1/mBF9Ai/g==
X-CSE-MsgGUID: aPaNwco2TZuIXBcsj1C4FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; d="scan'208";a="233597320"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 18:55:22 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: francois.dugast@intel.com,
	himal.prasad.ghimiray@intel.com
Subject: [PATCH] drm/gpusvm,
 pagemap: Do not assume DRM pagemap owns device pages
Date: Wed,  8 Apr 2026 18:55:12 -0700
Message-Id: <20260409015512.3670302-1-matthew.brost@intel.com>
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

Update drm_pagemap_page_zone_device_data() to derive the pgmap ops from
the page and compare them against the DRM pagemap ops. If the ops do not
match, return NULL.

Also harden two risky call sites by checking for NULL after
hmm_range_fault() or migrate_vma_setup() when migrating to device
memory, as it is possible to encounter device pages that are not owned
by DRM pagemap.

Suggested-by: sashiko.dev
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/drm_gpusvm.c  |  5 +++++
 drivers/gpu/drm/drm_pagemap.c | 14 ++++++++++----
 include/drm/drm_pagemap.h     |  5 ++++-
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
index 365a9c0b522a..b3cccd047a21 100644
--- a/drivers/gpu/drm/drm_gpusvm.c
+++ b/drivers/gpu/drm/drm_gpusvm.c
@@ -1506,6 +1506,11 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 			struct drm_pagemap_zdd *__zdd =
 				drm_pagemap_page_zone_device_data(page);
 
+			if (!__zdd) {
+				err = -EINVAL;
+				goto err_unmap;
+			}
+
 			if (!ctx->allow_mixed &&
 			    zdd != __zdd && i > 0) {
 				err = -EOPNOTSUPP;
diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
index d82ea7ccb8da..95c951c5b569 100644
--- a/drivers/gpu/drm/drm_pagemap.c
+++ b/drivers/gpu/drm/drm_pagemap.c
@@ -753,10 +753,16 @@ int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem *devmem_allocation,
 				own_pages++;
 				goto next;
 			}
-			cur.dpagemap = src_zdd->dpagemap;
-			cur.ops = src_zdd->devmem_allocation->ops;
-			cur.device = cur.dpagemap->drm->dev;
-			pages[i] = src_page;
+			if (src_zdd) {
+				cur.dpagemap = src_zdd->dpagemap;
+				cur.ops = src_zdd->devmem_allocation->ops;
+				cur.device = cur.dpagemap->drm->dev;
+				pages[i] = src_page;
+			} else {
+				npages = i;
+				err = -EINVAL;
+				goto err_finalize;
+			}
 		}
 		if (!pages[i]) {
 			cur.dpagemap = NULL;
diff --git a/include/drm/drm_pagemap.h b/include/drm/drm_pagemap.h
index 95eb4b66b057..9b7c50932db5 100644
--- a/include/drm/drm_pagemap.h
+++ b/include/drm/drm_pagemap.h
@@ -367,12 +367,15 @@ int drm_pagemap_reinit(struct drm_pagemap *dpagemap);
  * drm_pagemap_page_zone_device_data() - Page to zone_device_data
  * @page: Pointer to the page
  *
- * Return: Page's zone_device_data
+ * Return: Page's zone_device_data if owned by DRM pagemap, NULL otherwise
  */
 static inline struct drm_pagemap_zdd *drm_pagemap_page_zone_device_data(struct page *page)
 {
 	struct folio *folio = page_folio(page);
 
+	if (WARN_ON_ONCE(page_pgmap(page)->ops != drm_pagemap_pagemap_ops_get()))
+		return NULL;
+
 	return folio_zone_device_data(folio);
 }
 
-- 
2.34.1

