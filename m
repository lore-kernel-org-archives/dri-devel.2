Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF2ACCFA13
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 17:44:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6DF810E552;
	Fri,  1 May 2026 17:44:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="NA0UZi3o";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC5F010E551;
 Fri,  1 May 2026 17:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777657494; x=1809193494;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=bzSpqsYeKHQYyJx6hY+N0gTwu5rjRK9NQNLO7qTt6sw=;
 b=NA0UZi3oNBKNhyXaXxArlLER/L1FZ3fIN935dDeJVanijBlTuXDWsLQ4
 K6AujEYK94eAe9bD0Ez7JZTz2roNmhEGurTe/rN2xXgJS3XyNcU4YeOXw
 SZWD2VONVetvrQGN9UhfqgUzyPFa6FevkvgIuTjUsq3eBjBidZOEVCXrk
 wRzMK8PhTrXibJm/WydIEnTkCO2eRR3FM0YiGK8RRhMR4GP7lHK2C+pxG
 XYQIv+AlVyLAmDACr/ia0oFYytbkuiii/OsOuYNiyvzIe+/yeKOjE7Zkm
 RkrqH0vhbW2Ybl7cUKLYOxFBi3jpXLZ7hSiG5hdFg3wuqYv4uvvAnL0NX A==;
X-CSE-ConnectionGUID: BfjdkVVrTjmH5KR/gZmtcw==
X-CSE-MsgGUID: TvIjsroHQbSIjBhdzdC0Sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11773"; a="90081615"
X-IronPort-AV: E=Sophos;i="6.23,210,1770624000"; d="scan'208";a="90081615"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 May 2026 10:44:53 -0700
X-CSE-ConnectionGUID: lepGIWRATGOhSXCNpKYIRw==
X-CSE-MsgGUID: a2N7FTaZSzmsOgUljIoc+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,210,1770624000"; d="scan'208";a="235176650"
Received: from osgcshtiger.sh.intel.com ([10.239.81.49])
 by orviesa007.jf.intel.com with ESMTP; 01 May 2026 10:44:52 -0700
From: Shuicheng Lin <shuicheng.lin@intel.com>
To: dri-devel@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: Shuicheng Lin <shuicheng.lin@intel.com>,
 GitHub Copilot <copilot@github.com>, Matthew Auld <matthew.auld@intel.com>
Subject: [PATCH v2] drm/gpusvm: Drop redundant @flags.* kernel-doc on struct
 drm_gpusvm_pages
Date: Fri,  1 May 2026 17:44:35 +0000
Message-Id: <20260501174435.4053381-1-shuicheng.lin@intel.com>
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

The kernel-doc block above struct drm_gpusvm_pages duplicates the
descriptions of the bit-flags that live in struct drm_gpusvm_pages_flags
using dotted notation (@flags.migrate_devmem, @flags.unmapped, ...).
That dotted notation is intended for nested anonymous structs/unions that
the parser flattens into the parent's parameter list.  Here, however,
flags is of a named external type, so the parser does not flatten its
members and the dotted entries do not match any member of
drm_gpusvm_pages.  They also duplicate the canonical descriptions already
present in the kernel-doc of struct drm_gpusvm_pages_flags itself.

Drop the five @flags.* lines and replace them with a single @flags entry
that cross-references the type via kernel-doc's "&struct ..." syntax.
This eliminates the redundancy and removes warnings emitted by the new
parameterdescs check in scripts/kernel-doc:

  Excess struct member 'flags.migrate_devmem' description in
   'drm_gpusvm_pages'
  Excess struct member 'flags.unmapped' description in 'drm_gpusvm_pages'
  Excess struct member 'flags.partial_unmap' description in
   'drm_gpusvm_pages'
  Excess struct member 'flags.has_devmem_pages' description in
   'drm_gpusvm_pages'
  Excess struct member 'flags.has_dma_mapping' description in
   'drm_gpusvm_pages'

No functional change.

v2: change base to drm-misc.

Assisted-by: GitHub Copilot <copilot@github.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Signed-off-by: Shuicheng Lin <shuicheng.lin@intel.com>
---                                                                             
The failure is reported by the new kernel-doc check in: https://patchwork.freedesktop.org/series/164948/
---
 include/drm/drm_gpusvm.h | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h
index cd94bb2ee6ee..8a4d7134a9a7 100644
--- a/include/drm/drm_gpusvm.h
+++ b/include/drm/drm_gpusvm.h
@@ -140,12 +140,7 @@ struct drm_gpusvm_pages_flags {
  * @state: DMA IOVA state for mapping.
  * @state_offset: DMA IOVA offset for mapping.
  * @notifier_seq: Notifier sequence number of the range's pages
- * @flags: Flags for range
- * @flags.migrate_devmem: Flag indicating whether the range can be migrated to device memory
- * @flags.unmapped: Flag indicating if the range has been unmapped
- * @flags.partial_unmap: Flag indicating if the range has been partially unmapped
- * @flags.has_devmem_pages: Flag indicating if the range has devmem pages
- * @flags.has_dma_mapping: Flag indicating if the range has a DMA mapping
+ * @flags: Flags for the range; see &struct drm_gpusvm_pages_flags
  */
 struct drm_gpusvm_pages {
 	struct drm_pagemap_addr *dma_addr;
-- 
2.43.0

