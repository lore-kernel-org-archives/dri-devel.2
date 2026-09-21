Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D999C982DE
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 06:27:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E15710E036;
	Mon, 21 Sep 2026 06:27:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="n6upNVUF";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2695A10E1E0;
 Mon, 21 Sep 2026 06:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789972019; x=1821508019;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=BJTnmC4Gd1e7Sw+tnQjF3fv620BOspyBN81V6ldZZk0=;
 b=n6upNVUFdyRGcth2ZKiMBbBNG+c382Qe/wrVmPRNcnqT2Cws+QxSiEZ5
 s0OF8WZ6Qyz4uBTrkhB9gpIBCfvLNzVoO0vA0Emkg4Ab3LGq0sfeGOXVE
 yO8Wd/DAHUVJopj3oH/Gze/j5jmE6v95YY9djs8LtBIqhcSdqkNTL0a1Y
 yPZOSw7ijkeCp+C3mxTssZGsotH6YL4P6zjycywSdV0QTWtxZz1BJlKwZ
 jDr79ZqpqUknToU/4AV7/dDoR3+rcM8sBabAlRnhTATXfFh6RJimhA4Vb
 361M2QLEnTyQyCE0Us9YUJ+6/BLGQCCxbXBiPA5UINLXJqu1LPmRR/gK1 g==;
X-CSE-ConnectionGUID: pV3/hmFZQ0y1IMpplrd6tQ==
X-CSE-MsgGUID: roMpaI3hQCiOl+HnvS+eeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11911"; a="90590101"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; d="scan'208";a="90590101"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2026 23:26:59 -0700
X-CSE-ConnectionGUID: IPE2FfKSSp2yQzKpZMubzA==
X-CSE-MsgGUID: zwaGsapkQiyPIk+PPyJgvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="3823095"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2026 23:26:56 -0700
From: Varun Gupta <varun.gupta@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org, matthew.brost@intel.com,
 thomas.hellstrom@linux.intel.com, arvind.yadav@intel.com,
 himal.prasad.ghimiray@intel.com
Subject: [PATCH] drm/pagemap: Drop ratelimiting from dev_unhold_work debug
 trace
Date: Mon, 21 Sep 2026 11:56:49 +0530
Message-ID: <20260921062648.1166903-2-varun.gupta@intel.com>
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

Reference-drop trace in drm_pagemap_dev_unhold_work() was changed
from drm_dbg() to drm_dbg_ratelimited() to reduce serial console
bottlenecks.
However, when the ratelimit kicks in, the kernel's ratelimiting subsystem
logs a "callbacks suppressed" notification at the KERN_WARNING level.
Revert the trace macro back to drm_dbg()

Fixes: b66b036c959f ("drm/pagemap: Prevent CPU stalls during unbounded pagemap teardown")
Signed-off-by: Varun Gupta <varun.gupta@intel.com>
---
 drivers/gpu/drm/drm_pagemap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
index 0867bfbde5c5..ba97daedcd49 100644
--- a/drivers/gpu/drm/drm_pagemap.c
+++ b/drivers/gpu/drm/drm_pagemap.c
@@ -1009,7 +1009,7 @@ static void drm_pagemap_dev_unhold_work(struct work_struct *work)
 		struct drm_device *drm = dev_hold->drm;
 		struct module *module = drm->driver->fops->owner;
 
-		drm_dbg_ratelimited(drm, "Releasing reference on provider device and module.\n");
+		drm_dbg(drm, "Releasing reference on provider device and module.\n");
 		drm_dev_put(drm);
 		module_put(module);
 		kfree(dev_hold);
-- 
2.43.0

