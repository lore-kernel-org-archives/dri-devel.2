Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F33D110F997B
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 20:15:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C221010E0B1;
	Wed,  8 Apr 2026 20:15:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="M9QFJB84";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C211D10E092;
 Wed,  8 Apr 2026 20:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775679345; x=1807215345;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=nF2aoq4zVnsNhOEzbxzczuJ9B3XgZvJw8YsN+tjBDHE=;
 b=M9QFJB84WRArCAaf5d12DSTmTF160VJYFP7QuJtlt0AlSUWd0hNkTExS
 tj60K9rw4dRzJhLscn0DF2s2FxW8azH1Joiw+AYyjmH2fLUMtuOM8eRU2
 NUOTA6JZr8DSGkIrFP3krgY4Dqc0kpKCMrXJcUQ3rtjKcCRM0MOARQkH/
 Mj9sCIrybLvqs39D7GamSdd/TJhYzJIS6Wa4mKr87vg3qPQE7r0nK4FZu
 UlUgs2gkLCQcIKfr0s3jhsOwIIBJwNOZ4kRV5MjAuIHVDUzVSyJYYGDMl
 gfth5eH+3tjurHc9QRmxF7oDzLBPnP/GiM2kKsgW76TAuSARU4Dwd4VnU g==;
X-CSE-ConnectionGUID: ZCWtAzrTTDKFR3OMnkphKg==
X-CSE-MsgGUID: fGNUTcn6RruvbZG6Mhh7Rg==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="94063725"
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; d="scan'208";a="94063725"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 13:15:44 -0700
X-CSE-ConnectionGUID: V94/8A3yQgalHGJPNPr/pQ==
X-CSE-MsgGUID: j5UILza+TDCN38156TD/Xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; d="scan'208";a="228451016"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 13:15:44 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 francois.dugast@intel.com
Subject: [PATCH v6 2/5] drm/pagemap: Drop source_peer_migrates flag and assume
 true
Date: Wed,  8 Apr 2026 13:15:34 -0700
Message-Id: <20260408201537.3580549-3-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260408201537.3580549-1-matthew.brost@intel.com>
References: <20260408201537.3580549-1-matthew.brost@intel.com>
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

All current users of DRM pagemap set source_peer_migrates to true during
migration, and it is unclear whether any user would ever want to disable
this for performance reasons or for features such as compression. It is
also questionable whether this flag could be made to work with
high-speed fabric mapping APIs.

Drop the flag and make DRM pagemap unconditionally assume that
source_peer_migrates is true.

Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Francois Dugast <francois.dugast@intel.com>
---
 drivers/gpu/drm/drm_pagemap.c | 10 ++++------
 drivers/gpu/drm/xe/xe_svm.c   |  1 -
 include/drm/drm_pagemap.h     |  9 ++-------
 3 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
index 5002049e0198..63f32cf6e1a7 100644
--- a/drivers/gpu/drm/drm_pagemap.c
+++ b/drivers/gpu/drm/drm_pagemap.c
@@ -651,12 +651,10 @@ int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem *devmem_allocation,
 				own_pages++;
 				goto next;
 			}
-			if (mdetails->source_peer_migrates) {
-				cur.dpagemap = src_zdd->dpagemap;
-				cur.ops = src_zdd->devmem_allocation->ops;
-				cur.device = cur.dpagemap->drm->dev;
-				pages[i] = src_page;
-			}
+			cur.dpagemap = src_zdd->dpagemap;
+			cur.ops = src_zdd->devmem_allocation->ops;
+			cur.device = cur.dpagemap->drm->dev;
+			pages[i] = src_page;
 		}
 		if (!pages[i]) {
 			cur.dpagemap = NULL;
diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
index 5933b2b6392b..b54587b77b2f 100644
--- a/drivers/gpu/drm/xe/xe_svm.c
+++ b/drivers/gpu/drm/xe/xe_svm.c
@@ -1055,7 +1055,6 @@ static int xe_drm_pagemap_populate_mm(struct drm_pagemap *dpagemap,
 	struct xe_pagemap *xpagemap = container_of(dpagemap, typeof(*xpagemap), dpagemap);
 	struct drm_pagemap_migrate_details mdetails = {
 		.timeslice_ms = timeslice_ms,
-		.source_peer_migrates = 1,
 	};
 	struct xe_vram_region *vr = xe_pagemap_to_vr(xpagemap);
 	struct dma_fence *pre_migrate_fence = NULL;
diff --git a/include/drm/drm_pagemap.h b/include/drm/drm_pagemap.h
index 75e6ca58922d..95eb4b66b057 100644
--- a/include/drm/drm_pagemap.h
+++ b/include/drm/drm_pagemap.h
@@ -329,17 +329,12 @@ struct drm_pagemap_devmem {
  * struct drm_pagemap_migrate_details - Details to govern migration.
  * @timeslice_ms: The time requested for the migrated pagemap pages to
  * be present in @mm before being allowed to be migrated back.
- * @can_migrate_same_pagemap: Whether the copy function as indicated by
- * the @source_peer_migrates flag, can migrate device pages within a
- * single drm_pagemap.
- * @source_peer_migrates: Whether on p2p migration, The source drm_pagemap
- * should use the copy_to_ram() callback rather than the destination
- * drm_pagemap should use the copy_to_devmem() callback.
+ * @can_migrate_same_pagemap: Whether the copy function can migrate
+ * device pages within a single drm_pagemap.
  */
 struct drm_pagemap_migrate_details {
 	unsigned long timeslice_ms;
 	u32 can_migrate_same_pagemap : 1;
-	u32 source_peer_migrates : 1;
 };
 
 #if IS_ENABLED(CONFIG_ZONE_DEVICE)
-- 
2.34.1

