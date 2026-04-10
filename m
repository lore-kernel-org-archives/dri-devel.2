Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8771F45A0D
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 20:59:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1D8810E9D0;
	Fri, 10 Apr 2026 20:59:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="MXpFys8B";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E0B810E1C3;
 Fri, 10 Apr 2026 20:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775854776; x=1807390776;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=m4AR4senMkak4li70yfaEiEU2i/bLgS4vrfaDg8+/2Y=;
 b=MXpFys8Bnn1zXSr2azhiC1JIy1U5iv66CbbQLBUH0okUDdNSB/yfOVmQ
 0x1HIFKOvFyIR0aJxODq1+Q3myqTXJB9YkTjDftRKNY1N8VUpsEbHOCgz
 ppIloYwlefic6ALu2e7LHOQp4Caj/5gC1HVr/czYtcgBNvkWnx0QZKKtW
 lolNmOWsEi0ZqBBnP/geJhy7kO0ZSidaycftxJJKrI+vPTwSFU5jTXT9M
 VPfcSXgdZfbugMP38l9I9bOOJXp5bbZ6UaaEi/S4UkxotXPVMHksmq8/M
 I6QBMOvjStRlIwKsNL8IqKRJGW44MeDPfwUkwqhrGxbh53Ewf53msD57b g==;
X-CSE-ConnectionGUID: jGXgZS9ASnKETiSfWjVncg==
X-CSE-MsgGUID: 9lBrrW4/SQOv9SdQJTYKNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11755"; a="76842852"
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; d="scan'208";a="76842852"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2026 13:59:35 -0700
X-CSE-ConnectionGUID: xFhNUUelTSyJfka0YOotBg==
X-CSE-MsgGUID: oG+fWenbST2w2+Ssl3XS6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; d="scan'208";a="228343051"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2026 13:59:35 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: Francois Dugast <francois.dugast@intel.com>
Subject: [PATCH v7 2/5] drm/pagemap: Drop source_peer_migrates flag and assume
 true
Date: Fri, 10 Apr 2026 13:59:26 -0700
Message-Id: <20260410205929.3914474-3-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260410205929.3914474-1-matthew.brost@intel.com>
References: <20260410205929.3914474-1-matthew.brost@intel.com>
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
index ba67355f64cb..e1651e70c8f0 100644
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

