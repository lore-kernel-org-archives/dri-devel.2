Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 234E7106ACE1
	for <dri-devel@archiver.kernel.org>; Thu, 12 Mar 2026 19:21:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87D5C10EA91;
	Thu, 12 Mar 2026 19:21:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Am8zHsoJ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DD2710EA91;
 Thu, 12 Mar 2026 19:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773343294; x=1804879294;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Zhb0XbVbSkgWBxiVuSG+gDE7nzQfwhSjuCf+rcLIxCs=;
 b=Am8zHsoJBaFeRg77WUThGkO+M8LeEnsx3WTmzew0gsxkfoLgZZ9Qd29n
 MINCwVh6QZpxVHVrOQR3bbvL6DOimnz7qB+7cJA86bQ0bV8UcHK8ieIWW
 SPDPHujQpoVBxC/2/uhIuCMnQ8ndjS42hu4HkEXK0NQAGkwuTW3JRA64J
 /6qM08BogA+Xv4dFlLfljpmbvdf43qQzTtpH2YmO9ar+KxZAurKynI4vt
 5erUKOlv64Q18KvZl+lMeY2QSazp6ypw5CDf5BWtkZr4UXhKsauPsSryO
 YL8za+2D86bqo/tDK60k0HBxlSeOsHqPubL4Peb1FrtR4AGzdXxNwAIf3 g==;
X-CSE-ConnectionGUID: 8dhupD/FTMSohzQpLUyAoQ==
X-CSE-MsgGUID: mCJe/bfVRaKk0/xqxxc9SA==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="78052707"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; d="scan'208";a="78052707"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2026 12:21:34 -0700
X-CSE-ConnectionGUID: 3m9xK1+kSeSdouq2HQeyhA==
X-CSE-MsgGUID: VuMHCvQ6QzuNsmfzNXz9iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; d="scan'208";a="221105054"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO fdugast-desk.home)
 ([10.245.245.89])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2026 12:21:33 -0700
From: Francois Dugast <francois.dugast@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Subject: [PATCH v9 0/4] Enable THP support in drm_pagemap
Date: Thu, 12 Mar 2026 20:20:10 +0100
Message-ID: <20260312192126.2024853-1-francois.dugast@intel.com>
X-Mailer: git-send-email 2.43.0
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

Use Balbir Singh's series for device-private THP support [1] and previous
preparation work in drm_pagemap [2] to add 2MB/THP support in xe. This leads
to significant performance improvements when using SVM with 2MB pages.

[1] https://lore.kernel.org/linux-mm/20251001065707.920170-1-balbirs@nvidia.com/
[2] https://patchwork.freedesktop.org/series/151754/

v2:
- rebase on top of multi-device SVM
- add drm_pagemap_cpages() with temporary patch
- address other feedback from Matt Brost on v1

v3:
The major change is to remove the dependency to the mm/huge_memory
helper migrate_device_split_page() that was called explicitely when
a 2M buddy allocation backed by a large folio would be later reused
for a smaller allocation (4K or 64K). Instead, the first 3 patches
provided by Matthew Brost ensure large folios are split at the time
of freeing.

v4:
- add order argument to folio_free callback
- send complete series to linux-mm and MM folks as requested (Zi Yan
  and Andrew Morton) and cover letter to anyone receiving at least
  one of the patches (Liam R. Howlett)

v5:
- update zone_device_page_init() in patch #1 to reinitialize large
  zone device private folios

v6:
- fix drm_pagemap change in patch #1 to allow applying to 6.19 and
  add some comments

v7:
- now that patch #1 is merged, rebase and resend for CI

v8:
- rebase on 7.0.0-rc3

v9:
- fix build when CONFIG_ZONE_DEVICE is disabled

Francois Dugast (3):
  drm/pagemap: Unlock and put folios when possible
  drm/pagemap: Add helper to access zone_device_data
  drm/pagemap: Enable THP support for GPU memory migration

Matthew Brost (1):
  drm/pagemap: Correct cpages calculation for migrate_vma_setup

 drivers/gpu/drm/drm_gpusvm.c  |   7 +-
 drivers/gpu/drm/drm_pagemap.c | 157 +++++++++++++++++++++++++++-------
 include/drm/drm_pagemap.h     |  21 +++++
 3 files changed, 154 insertions(+), 31 deletions(-)

-- 
2.43.0

