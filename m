Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C4FDF45A12
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 20:59:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B90410E1F8;
	Fri, 10 Apr 2026 20:59:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="TZCJ3+zH";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60B4410E1C3;
 Fri, 10 Apr 2026 20:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775854775; x=1807390775;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=BJx2ww/Aj4GuZdPK7Ki8QnRoqXUF/NdOaSwp1EYdGrE=;
 b=TZCJ3+zHMyDcIBnMIB1Xz3RQ8b8Fi4QIfVfHvTDrrhmUs7NWiLw5omqI
 LuzP8ejTrr+mCuVsk5X+QrXov9Ilw8+3I22A7bBZrJ5yxD6Nhzl5IXJ5h
 OZJs6Lc9qL6/aeqHiAJfB3KHq76REE3nqH/4tB45in9ZWpXFScZbpuHtq
 CFkVCmMmfo02BlR5CZXf54mMpwzPGQlxF/gqKZwy5J0Aqj2XXMy7sSx0Q
 qCTzC/5ivMaalZTWZaWiQHYRR/1/Td9F8fzuZWwSsvT56PIHxUhF64b3h
 w+4Sco1sdBiS7Q0vi2qEIquKZWogvpGVZTLFYbdyYKbDD2nDGGjRrAox3 A==;
X-CSE-ConnectionGUID: ZPuBTDuJSgKcDfdqHhunag==
X-CSE-MsgGUID: ICZlfD7dT1OPlFPhDKc9Mw==
X-IronPort-AV: E=McAfee;i="6800,10657,11755"; a="76842850"
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; d="scan'208";a="76842850"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2026 13:59:35 -0700
X-CSE-ConnectionGUID: 3Hg9bKFjQn+XCmnfVESkhw==
X-CSE-MsgGUID: AE9ZQLxpRkiUjB2ILQyG2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; d="scan'208";a="228343047"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2026 13:59:35 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v7 0/5] Use new dma-map IOVA alloc, link,
 and sync API in GPU SVM and DRM pagemap
Date: Fri, 10 Apr 2026 13:59:24 -0700
Message-Id: <20260410205929.3914474-1-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
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

The dma-map IOVA alloc, link, and sync APIs perform significantly better
than dma-map / dma-unmap, as they avoid costly IOMMU synchronizations.
This difference is especially noticeable when mapping a 2MB region in
4KB pages.

Use dma-map IOVA alloc, link, and sync APIs for GPU SVM and DRM page,
which mappings between the CPU and GPU.

Initial results are promising.

Baseline CPU time during 2M / 64K fault with a migration (device THP disabled):
Average migrate 2M cpu time (us, percentage): 333.99665178571428571429, .61102853199282922865
Average migrate 64K cpu time (us, percentage): 18.62723214285714285714, .30127985269960467173

After this series CPU time during 2M / 64K fault with a migration (device THP disabled):
Average migrate 2M cpu time (us, percentage): 224.81808035714285714286, .51412827364772602557
Average migrate 64K cpu time (us, percentage): 14.65625000000000000000, .25659463050529524405

Matt

v2:
 - Include missing basline patch for CI
v3:
 - Fix memory corruption
 - PoC IOVA alloc for multi-GPU
v4:
 - Pack IOVA / drop dummy pages
 - Drop multi-GPU IOVA alloc
v5:
 - Address Thomas's comments
v6:
 - Address Francois's comments
v7:
 - Address sashiko's comments

Matthew Brost (5):
  drm/gpusvm: Use dma-map IOVA alloc, link, and sync API in GPU SVM
  drm/pagemap: Drop source_peer_migrates flag and assume true
  drm/pagemap: Split drm_pagemap_migrate_map_pages into device / system
  drm/pagemap: Use dma-map IOVA alloc, link, and sync API for DRM
    pagemap
  drm/pagemap: Fix drm_pagemap_migrate_unmap_pages kerneldoc

 drivers/gpu/drm/drm_gpusvm.c  |  53 ++++++--
 drivers/gpu/drm/drm_pagemap.c | 229 ++++++++++++++++++++++++----------
 drivers/gpu/drm/xe/xe_svm.c   |   1 -
 include/drm/drm_gpusvm.h      |   5 +
 include/drm/drm_pagemap.h     |   9 +-
 5 files changed, 218 insertions(+), 79 deletions(-)

-- 
2.34.1

