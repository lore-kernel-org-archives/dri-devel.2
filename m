Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF94AC982D2
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 08:13:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5972810E85D;
	Fri, 18 Sep 2026 08:13:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="aQuS5bqH";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84E1A10E85D
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 08:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789719211; x=1821255211;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=6SBkur9nK+KX0eGvB8DbSU6XqHu5s0MO/wC/ZWOK8uU=;
 b=aQuS5bqHPKskEfs3DGxxrndgQOrHrmSHekMVTlIVbtBCLjFJ/iQii0dn
 Zq3o6ftukFAP4y7viwg7fiIhya/iMkTucu2tC4V0Lzvf0AF3iOGt8/esV
 CDSxW2zUrZ7PP5+EUP01ZOnTsJLeqwefgCXqXqB+qT/6xPmjwYBjvjcZ2
 rKcH9aekCDMMt4DJLq+KPoNK1pVXFtOSMDg6z71GlvCJkQFjUfYLxsTYa
 n2tscM7u/1N8YZrfDBOoX274hPHHr4NkduF1COjlNCK9ZvnVnC+zECAF/
 hjXD83NMqlH3LDRU0AmErapas9WQGWSAdByreJqvyrGD9jT22q9JiHXfV Q==;
X-CSE-ConnectionGUID: x1C55RHeS5a7QRZ8WGfetA==
X-CSE-MsgGUID: f2RvixnYS1y+KaZvkmL+aA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100806029"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="100806029"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 01:13:30 -0700
X-CSE-ConnectionGUID: 5qOHTaSKRf+lokIOr2EF6A==
X-CSE-MsgGUID: /c5l1KtaTzCY8YdB4uoJvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="2508592"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 01:13:29 -0700
From: Varun Gupta <varun.gupta@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: matthew.brost@intel.com, thomas.hellstrom@linux.intel.com,
 arvind.yadav@intel.com, himal.prasad.ghimiray@intel.com
Subject: [PATCH v2] drm/pagemap: Prevent CPU stalls during unbounded pagemap
 teardown
Date: Fri, 18 Sep 2026 13:43:21 +0530
Message-ID: <20260918081320.30389-2-varun.gupta@intel.com>
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

v2:
  - Changed workqueue from deprecated system_unbound_wq to system_dfl_wq.
    (Arvind Yadav)

Fixes: a26084328ac4 ("drm/pagemap, drm/xe: Manage drm_pagemap provider lifetimes")
Reviewed-by: Arvind Yadav <arvind.yadav@intel.com>
Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Signed-off-by: Varun Gupta <varun.gupta@intel.com>
---
 drivers/gpu/drm/drm_pagemap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
index 892b325fa99b..0867bfbde5c5 100644
--- a/drivers/gpu/drm/drm_pagemap.c
+++ b/drivers/gpu/drm/drm_pagemap.c
@@ -986,7 +986,7 @@ static void drm_pagemap_release(struct kref *ref)
 	dpagemap->dev_hold = NULL;
 	drm_pagemap_shrinker_add(dpagemap);
 	llist_add(&dev_hold->link, &drm_pagemap_unhold_list);
-	schedule_work(&drm_pagemap_work);
+	queue_work(system_dfl_wq, &drm_pagemap_work);
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

