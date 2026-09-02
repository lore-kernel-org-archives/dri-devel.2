Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37B43C624D4
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 06:35:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5876810EFF0;
	Wed,  2 Sep 2026 06:35:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="P4NgAHI1";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31F9D10E6EF;
 Wed,  2 Sep 2026 06:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788330915; x=1819866915;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=rugyb0FeHHFAfemsKEQ2mifMGRYzJT3W+MXDRTWCM0M=;
 b=P4NgAHI1gQHVGkVv4tBWuf5JYBfGyZresgVety9LIe6ivloGTlxmMKwD
 C62L4a0r5S3HRL7yuSIFzFvClhqViNic6uo5JdYrT9Wa/2cdE7vUyIxTD
 DYwolHYeQ2/NwV0lazCQr4eTLEsxfAueKiwHnN0b7CKC3hkqMAEo2FEqY
 CgxG6FloZqXeopqHDw6ZlnvmUFoSLUYKqv9UTQz1HHvHW0+mzlerTsgZR
 Ka+GXWpaIfLLmLePA7gES8OMNIFbPsaUPmIPmMSo1nL9TTjTGeqU8KwK4
 EfcMBkGsn+JGnq1LPT32QX5DkGognZDPRJAyKIFzNNACOLLhBBJcLUs9H A==;
X-CSE-ConnectionGUID: BlOF/w4VTU66M+xHGziM4g==
X-CSE-MsgGUID: HOPh53HnTQ6ODgXy5lTgkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="92598982"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="92598982"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 23:35:11 -0700
X-CSE-ConnectionGUID: LjWbliKeS6+kkm4a9njZFg==
X-CSE-MsgGUID: q4sVWaH0T8OyHG3IqV0VGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="268775528"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 23:35:10 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org,
 Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Subject: [PATCH v4 1/2] drm/pagemap: dma-unmap pages before handling migration
 errors
Date: Tue,  1 Sep 2026 23:35:03 -0700
Message-Id: <20260902063504.3024362-1-matthew.brost@intel.com>
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

drm_pagemap_migrate_unmap_pages() relies on the pages array to determine
which pages require DMA unmapping. However,
drm_pagemap_migration_unlock_put_pages() clears the array as part of its
cleanup, leaving drm_pagemap_migrate_unmap_pages() with no valid page
information if it is called afterward.

Call drm_pagemap_migrate_unmap_pages() before
drm_pagemap_migration_unlock_put_pages() so the pages array remains
valid during DMA unmapping.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: f86ad0ed620c ("drm/gpusvm, drm/pagemap: Move migration functionality to drm_pagemap")
Cc: stable@vger.kernel.org
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
---
 drivers/gpu/drm/drm_pagemap.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
index 097a900cf55d..6aa745682270 100644
--- a/drivers/gpu/drm/drm_pagemap.c
+++ b/drivers/gpu/drm/drm_pagemap.c
@@ -1283,13 +1283,13 @@ int drm_pagemap_evict_to_ram(struct drm_pagemap_devmem *devmem_allocation)
 		goto err_finalize;
 
 err_finalize:
+	drm_pagemap_migrate_unmap_pages(devmem_allocation->dev, pagemap_addr, dst, npages,
+					DMA_FROM_DEVICE, &state);
 	if (err)
 		drm_pagemap_migration_unlock_put_pages(npages, dst);
 	migrate_device_pages(src, dst, npages);
 	drm_pagemap_retire_migrated_pages(src, npages);
 	migrate_device_finalize(src, dst, npages);
-	drm_pagemap_migrate_unmap_pages(devmem_allocation->dev, pagemap_addr, dst, npages,
-					DMA_FROM_DEVICE, &state);
 
 err_free:
 	kvfree(buf);
@@ -1416,15 +1416,15 @@ static int __drm_pagemap_migrate_to_ram(struct vm_area_struct *vas,
 		goto err_finalize;
 
 err_finalize:
+	if (dev)
+		drm_pagemap_migrate_unmap_pages(dev, pagemap_addr, migrate.dst,
+						npages, DMA_FROM_DEVICE,
+						&state);
 	if (err)
 		drm_pagemap_migration_unlock_put_pages(npages, migrate.dst);
 	migrate_vma_pages(&migrate);
 	drm_pagemap_retire_migrated_pages(migrate.src, npages);
 	migrate_vma_finalize(&migrate);
-	if (dev)
-		drm_pagemap_migrate_unmap_pages(dev, pagemap_addr, migrate.dst,
-						npages, DMA_FROM_DEVICE,
-						&state);
 err_free:
 	kvfree(buf);
 err_out:
-- 
2.34.1

