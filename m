Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18FC6C4451C
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 20:20:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 629A010E195;
	Tue, 21 Jul 2026 20:20:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="dpA6oWjJ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E661F10E195;
 Tue, 21 Jul 2026 20:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784665204; x=1816201204;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=PNIej+pFL396EvUVvZLG/dYSWwiLpVcQZci6t7vie/A=;
 b=dpA6oWjJ1ECpHkMnyxgzdspsBPWPhVPOh/2DnTtQvneeq+jfpjKH5sS9
 lQ0HZYb5yJEQHEqVY4dhgNyhNZvWQCzpVLYoZipfW2120swBi6qK6jbPz
 TeY7Hq9oavlFtOO00tGMbBi1ukl1NsK/awhW4ofOu5u29y9PRtHrpX13+
 YEgwSdnAqo2MMfyjTO6VcHsZ+eA2swP9GYo+TDx1h6Bl6wCCb75un2r0v
 /9ZQoZXqf+inDVTztoVA7xBRFKmmL2KxBb4HSiVVR6s1sdhX38qobQ9pE
 eztx8AE28HFv8ZT68DfpFI+zc+Ni1DUPumKDNfFhgXdOHQ1+N+7050nhU g==;
X-CSE-ConnectionGUID: aV0rZW03S/u286DN41z4eA==
X-CSE-MsgGUID: 5j1+a1qHTsWzTW4+nfOssg==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="85319679"
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; d="scan'208";a="85319679"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 13:20:03 -0700
X-CSE-ConnectionGUID: owA6kmc1RcSAN6EXHsa4Fg==
X-CSE-MsgGUID: s8A4Ql16TtaMB1dssZIJjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; d="scan'208";a="253505829"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 13:20:03 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] drm/pagemap: Clear driver-provided PFNs from migration PFN
 array
Date: Tue, 21 Jul 2026 13:19:59 -0700
Message-Id: <20260721201959.1082266-1-matthew.brost@intel.com>
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
avoid confusing the migrate_vma_*() functions.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: 3902846af36b ("drm/pagemap Fix error paths in drm_pagemap_migrate_to_devmem")
Fixes: ec265e1f1cfc ("drm/pagemap: Support source migration over interconnect")
Cc: stable@vger.kernel.org
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/drm_pagemap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
index 15c78eca180b..f991b296c8e1 100644
--- a/drivers/gpu/drm/drm_pagemap.c
+++ b/drivers/gpu/drm/drm_pagemap.c
@@ -807,8 +807,11 @@ int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem *devmem_allocation,
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

