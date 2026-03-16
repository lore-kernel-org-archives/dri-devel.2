Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F33F53D69
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 15:15:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BADC410E1F9;
	Mon, 16 Mar 2026 15:15:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="f/n8KJTa";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D823210E1F9
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 15:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773674157; x=1805210157;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=CmaBGKz4dFu3gsMI8IIqYg54XVgimQIPeePQRK+nNKc=;
 b=f/n8KJTaawqadipAt5TsKc3IDQeWuWuiIpRT1oTJ6zudLYFM8ONFWEbv
 PbMSQmmOXLRC6Y14LyVkrXEc7+KKAF2ILfmxfv41AFn7jrlIpcKwYTNPr
 slHcghEfuAfS0/p2lafIVE/4T25q87ZXKhGUW2oT8qw643QQCKvprJx52
 i2/436NFYqsJ+xHc84N7BI804OyQWl/5mJyJOsm3d84Xmik4SlLJqKfDJ
 wTrYXl+EZVGHVSQXGQ3Gkqwi6OL+JUJTz40tO9HLshqRWpWzlJUufLR+b
 v+apH/SrwscL/tIWsrte4WpDgfxOE8bZ3UEaKckcC5w9117mzwXzXtDNC A==;
X-CSE-ConnectionGUID: BVflCJg6R9yhZvX2Go/jlw==
X-CSE-MsgGUID: 84z0gAdARgWROhlZ3tRcEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="85774144"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="85774144"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 08:15:56 -0700
X-CSE-ConnectionGUID: 1k7QkGTfRjKFxSKfmTIEhA==
X-CSE-MsgGUID: pkOmldgcTeau9/bZSCCfPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="244972075"
Received: from live-gta-imageloader.fm.intel.com (HELO
 DUT4086LNL.fm.intel.com) ([10.105.10.52])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 08:15:56 -0700
From: Jonathan Cavitt <jonathan.cavitt@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: saurabhg.gupta@intel.com, alex.zuo@intel.com, jonathan.cavitt@intel.com,
 thomas.hellstrom@linux.intel.com, maarten.lankhorst@linux.intel.com,
 matthew.brost@intel.com
Subject: [PATCH v4] drm/pagemap_util: Ensure proper cache lock management on
 free
Date: Mon, 16 Mar 2026 15:15:56 +0000
Message-ID: <20260316151555.7553-2-jonathan.cavitt@intel.com>
X-Mailer: git-send-email 2.43.0
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

For the sake of consistency, ensure that the cache lock is always
unlocked after drm_pagemap_cache_fini. Spinlocks typically disable
preemption and if the code-path missing the unlock is hit, preemption
will remain disabled even if the lock is subsequently freed.

Fixes static analysis issue.

v2:
- Use requested code flow (Maarten)

v3:
- Clear cache->dpagemap (Matt Brost, Maarten)

v4:
- Reword commit message (Thomas)

Fixes: 77f14f2f2d73f ("drm/pagemap: Add a drm_pagemap cache and shrinker")
Signed-off-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Thomas Hellstrom <thomas.hellstrom@linux.intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
---
 drivers/gpu/drm/drm_pagemap_util.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/drm_pagemap_util.c b/drivers/gpu/drm/drm_pagemap_util.c
index 14ddb948a32e..6111d90a38e2 100644
--- a/drivers/gpu/drm/drm_pagemap_util.c
+++ b/drivers/gpu/drm/drm_pagemap_util.c
@@ -65,18 +65,14 @@ static void drm_pagemap_cache_fini(void *arg)
 	drm_dbg(cache->shrinker->drm, "Destroying dpagemap cache.\n");
 	spin_lock(&cache->lock);
 	dpagemap = cache->dpagemap;
-	if (!dpagemap) {
-		spin_unlock(&cache->lock);
-		goto out;
-	}
+	cache->dpagemap = NULL;
+	if (dpagemap && !drm_pagemap_shrinker_cancel(dpagemap))
+		dpagemap = NULL;
+	spin_unlock(&cache->lock);
 
-	if (drm_pagemap_shrinker_cancel(dpagemap)) {
-		cache->dpagemap = NULL;
-		spin_unlock(&cache->lock);
+	if (dpagemap)
 		drm_pagemap_destroy(dpagemap, false);
-	}
 
-out:
 	mutex_destroy(&cache->lookup_mutex);
 	kfree(cache);
 }
-- 
2.43.0

