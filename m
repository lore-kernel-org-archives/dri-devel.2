Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2AC5C88E72
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 17:04:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B010F89CE3;
	Thu, 17 Sep 2026 17:04:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="K25+kssY";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A4C889CE3
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 17:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789664648; x=1821200648;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=cSWrsDbr7DgFcnxcOcMZb0uSYrbpMHWzvWyZrvQOoGM=;
 b=K25+kssYMsjZo2werMGhXqyvf3VKl/c2uhNV4kpV415Tst9Cs8xg+cr3
 35cyiNyindPkHIlkNEtmJ9DEc1vYkA1zc/JAHEphxOM1oXPEE5YnHilaR
 qpTc7v8IFJn67kXDAmpMYtJHx9jBQtVJM/V8q1DEiRb1rgq+UdWeBD6Db
 AYnBskIh+u1rNuA66YktwJLzR2BW1SYcmzu4J8S/Eyr2JQcYykMfKgV7M
 pr8dg/QZy11RJGzejpEU2fPO8OgUyDAzMzoWdLcsIKJlUZXoKkIb7xKTJ
 7cQxzHJUeVuDOc5plbqXFGHKCE33kRBAJ9ovarE5B4co3D8Qb7AS0hHPb g==;
X-CSE-ConnectionGUID: 6wYJZS/aTeaj0Qstm5eyaw==
X-CSE-MsgGUID: TJkNygEnRauiRhuaZaMXsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89043737"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89043737"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2026 10:04:08 -0700
X-CSE-ConnectionGUID: pSOdP43eQhCTdOeFhE2gww==
X-CSE-MsgGUID: WYvva1lxQbKQMKYlEXuxiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="2343988"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2026 10:04:07 -0700
From: Varun Gupta <varun.gupta@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: matthew.brost@intel.com,
	thomas.hellstrom@linux.intel.com
Subject: [PATCH] drm/pagemap: Prevent CPU stalls during unbounded pagemap
 teardown
Date: Thu, 17 Sep 2026 22:33:57 +0530
Message-ID: <20260917170357.3926213-2-varun.gupta@intel.com>
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

drm_pagemap_dev_unhold_work() processes an unbatched llist of pagemaps
on the system workqueue. This creates potential latency traps during
heavy teardown cycles due to two compounding factors:

1. The loop contains a per-item drm_dbg() trace. If dynamic debug is
enabled on a slow serial console, synchronous print latency scales
linearly with the batch size and can block worker execution.
2. The llist can accumulate large batches during intensive unmap
operations, monopolizing worker resources without yielding.

This causes below log warning:
"workqueue: drm_pagemap_dev_unhold_work [drm_gpusvm_helper] hogged CPU
for >10000us 19 times, consider switching to WQ_UNBOUND"

Fix this by implementing a latency mitigation strategy:
- Move the teardown work to system_unbound_wq to avoid tying up
  per-CPU bound worker pools.
- Add cond_resched() inside the teardown loop to yield the CPU during
  large batch teardowns, ensuring system responsiveness.
- Convert the drm_dbg() trace to drm_dbg_ratelimited() to mitigate
  serial console bottlenecks while preserving debuggability.

Fixes: a26084328ac4 ("drm/pagemap, drm/xe: Manage drm_pagemap provider lifetimes")
Signed-off-by: Varun Gupta <varun.gupta@intel.com>
---
 drivers/gpu/drm/drm_pagemap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
index 892b325fa99b..f8d5428f1750 100644
--- a/drivers/gpu/drm/drm_pagemap.c
+++ b/drivers/gpu/drm/drm_pagemap.c
@@ -986,7 +986,7 @@ static void drm_pagemap_release(struct kref *ref)
 	dpagemap->dev_hold = NULL;
 	drm_pagemap_shrinker_add(dpagemap);
 	llist_add(&dev_hold->link, &drm_pagemap_unhold_list);
-	schedule_work(&drm_pagemap_work);
+	queue_work(system_unbound_wq, &drm_pagemap_work);
 	/*
 	 * Here, either the provider device is still alive, since if called from
 	 * page_free(), the caller is holding a reference on the dev_pagemap,
@@ -1009,10 +1009,11 @@ static void drm_pagemap_dev_unhold_work(struct work_struct *work)
 		struct drm_device *drm = dev_hold->drm;
 		struct module *module = drm->driver->fops->owner;
 
-		drm_dbg(drm, "Releasing reference on provider device and module.\n");
+		drm_dbg_ratelimited(drm, "Releasing reference on provider device and module.\n");
 		drm_dev_put(drm);
 		module_put(module);
 		kfree(dev_hold);
+		cond_resched();
 	}
 }
 
-- 
2.43.0

