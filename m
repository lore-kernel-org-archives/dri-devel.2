Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B3B2C4452D
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 20:44:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 842A510E3CA;
	Tue, 21 Jul 2026 20:43:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="cfGRvioJ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6321810E3CA;
 Tue, 21 Jul 2026 20:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784666639; x=1816202639;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ujuuPtTMhapUF03co5hOJM+7cFnNCSg9KOpLT2PeRvE=;
 b=cfGRvioJs4Wwt9NGmhiCa2g2GVA5cW/jXZXw7++mAqgUBNsqi+OEbJVo
 xZH1CLnbDk/W1+pSW+FIoBUcaRhC4RMfAWxZDXCldmjkonEHgIcUUUS69
 fIwU3WwDP+Qwr6VDITp2+7UbtyDfoyTvZgcZ7V36w7zWt0wwUyu9r10sJ
 Cly72uJ0bSlwnhs94MKhRCEI64TTbsOBeQxqvpYDKPeN+tnXpQkcb5pxJ
 1WoQJne5vkCPPxDDa4w8Yg9bum8C2DyF11bIVL6f3FtE0+aEhCDmPf27B
 IUxCO45vMkOMiu9QIuXAeqI8cG4pCY/Ujvocu7F2GmQe8mQMO3pWogJD9 g==;
X-CSE-ConnectionGUID: CithAMW0QsaiXMlMdtHjgA==
X-CSE-MsgGUID: 2clUL7jpTMGxbFCOyf2nQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="96798333"
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; d="scan'208";a="96798333"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 13:43:59 -0700
X-CSE-ConnectionGUID: t7Ju8d6FQyCGP7337Vr8jg==
X-CSE-MsgGUID: XFFRVyMSRfmFNmwf9n5K0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; d="scan'208";a="258538139"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 13:43:58 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2] drm/pagemap: Clear driver-provided PFNs from migration PFN
 array
Date: Tue, 21 Jul 2026 13:43:53 -0700
Message-Id: <20260721204353.1082632-1-matthew.brost@intel.com>
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

DRM pagemap overloads the migration PFN array to store driver-provided
PFNs before calling migrate_vma_*() to finalize the migration. If an
error occurs during the incremental copy phase, the migration PFN
entries are reverted to their original state. After reverting the
device-folio mutations, clear any remaining driver-provided PFNs to
avoid confusing the migrate_vma_*() helpers.

Also clear any driver-provided PFNs if populate_devmem_pfn() fails, as
a precaution against stale entries being interpreted as migration PFNs.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: 3902846af36b ("drm/pagemap Fix error paths in drm_pagemap_migrate_to_devmem")
Fixes: ec265e1f1cfc ("drm/pagemap: Support source migration over interconnect")
Cc: stable@vger.kernel.org
Signed-off-by: Matthew Brost <matthew.brost@intel.com>

---
v2:
 - Be paranoid and also clear driver-provided on populate_devmem_pfn()
   failure (Sashiko)
---
 drivers/gpu/drm/drm_pagemap.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
index 15c78eca180b..892b325fa99b 100644
--- a/drivers/gpu/drm/drm_pagemap.c
+++ b/drivers/gpu/drm/drm_pagemap.c
@@ -727,8 +727,10 @@ int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem *devmem_allocation,
 	}
 
 	err = ops->populate_devmem_pfn(devmem_allocation, npages, migrate.dst);
-	if (err)
-		goto err_aborted_migration;
+	if (err) {
+		npages = 0;
+		goto err_finalize;
+	}
 
 	own_pages = 0;
 
@@ -807,8 +809,11 @@ int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem *devmem_allocation,
 		msecs_to_jiffies(mdetails->timeslice_ms);
 
 err_finalize:
-	if (err)
+	if (err) {
 		drm_pagemap_migration_unlock_put_pages(npages, migrate.dst);
+		for (i = npages; i < npages_in_range(start, end); ++i)
+			migrate.dst[i] = 0;
+	}
 err_aborted_migration:
 	migrate_vma_pages(&migrate);
 
-- 
2.34.1

