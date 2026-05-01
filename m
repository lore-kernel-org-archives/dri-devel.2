Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8255CD3423
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 17:14:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0AA810E57F;
	Fri,  1 May 2026 17:14:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="XkDlT2Bk";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A526510E563;
 Fri,  1 May 2026 17:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777655664; x=1809191664;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=/SBxcMqOta1Lrd1fzPTsxQ80JOmJ3oX8nQz6F76FKHE=;
 b=XkDlT2BkBHwvSbNhCyAIXG81SRKezUPsACQfZ7Fa1TpwkAiflFSSFUWJ
 qfvJaVeJPeP4n06iOI5wGEfb5vkS2tmhoCJ7L6IpRmzNYlB0yvUwJ4vS8
 aYK9+Z0k1SzPiQYSWW4FowPzl+l9YKgYnL9PXroe+Dt+i8h1EB2yfAHua
 fhtGHqAk711zO2UaYCHJzb/ZH90jzx6oK0HVYFrVEdW1uLuSZG6lNZ1kv
 u8upc/Xk8zKNYbfnXcczgSJLSLPdmafrIL50cS3d5h3e+xeFpwwqUKsA1
 n/AdkWIJGkkS+dRIS7DZsqONK/W8ELBX/gKlr6D67NCPl0oW9YrS70pxg w==;
X-CSE-ConnectionGUID: 6I5ae37aQr6RV3/V9PxxHQ==
X-CSE-MsgGUID: RPsle5mBQM+6DgTePkgdsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11773"; a="82487359"
X-IronPort-AV: E=Sophos;i="6.23,210,1770624000"; d="scan'208";a="82487359"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 May 2026 10:14:24 -0700
X-CSE-ConnectionGUID: hskdCO8cTPS0e3jOHLWvPw==
X-CSE-MsgGUID: y3Rzrc2YT+eeWa5KADMVew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,210,1770624000"; d="scan'208";a="233885986"
Received: from osgcshtiger.sh.intel.com ([10.239.81.49])
 by orviesa006.jf.intel.com with ESMTP; 01 May 2026 10:14:23 -0700
From: Shuicheng Lin <shuicheng.lin@intel.com>
To: dri-devel@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: Shuicheng Lin <shuicheng.lin@intel.com>,
 Matthew Auld <matthew.auld@intel.com>
Subject: [PATCH] drm/gpusvm: Drop redundant @flags.* kernel-doc on struct
 drm_gpusvm_pages
Date: Fri,  1 May 2026 17:13:33 +0000
Message-Id: <20260501171333.4044699-1-shuicheng.lin@intel.com>
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

Cc: Matthew Auld <matthew.auld@intel.com>
Signed-off-by: Shuicheng Lin <shuicheng.lin@intel.com>
---
The failure is reported by the new kernel-doc check in: https://patchwork.freedesktop.org/series/164948/
---
 include/drm/drm_gpusvm.h | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h
index 2578ac92a8d4..96eaf0328b4d 100644
--- a/include/drm/drm_gpusvm.h
+++ b/include/drm/drm_gpusvm.h
@@ -137,12 +137,7 @@ struct drm_gpusvm_pages_flags {
  * @dpagemap: The struct drm_pagemap of the device pages we're dma-mapping.
  *            Note this is assuming only one drm_pagemap per range is allowed.
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

