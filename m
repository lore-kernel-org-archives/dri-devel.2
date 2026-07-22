Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6084BC44533
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 07:23:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBFCC10EC9D;
	Wed, 22 Jul 2026 07:23:03 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D5C410E410;
 Wed, 22 Jul 2026 07:23:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8D2CF60A64;
 Wed, 22 Jul 2026 07:23:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B0871F000E9;
 Wed, 22 Jul 2026 07:23:00 +0000 (UTC)
From: Andi Shyti <andi.shyti@linux.intel.com>
To: dri-devel <dri-devel@lists.freedesktop.org>,
 intel-gfx <intel-gfx@lists.freedesktop.org>
Cc: Chris Wilson <chris.p.wilson@linux.intel.com>,
 Andi Shyti <andi.shyti@kernel.org>, Andi Shyti <andi.shyti@linux.intel.com>
Subject: [PATCH] drm/i915: Replace sleep with GT idle wait
Date: Wed, 22 Jul 2026 09:22:28 +0200
Message-ID: <20260722072228.1080796-1-andi.shyti@linux.intel.com>
X-Mailer: git-send-email 2.53.0
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

On VT-d systems, the driver must ensure that the GT is idle
before DMA object pages are unmapped.

Currently, the driver simply sleeps for 100-250 microseconds,
which does not guarantee that all requests have completed and no
further ones are being submitted. Replace the sleep with
intel_gt_wait_for_idle() to explicitly wait until the GT has
become idle.

An error is printed if waiting for the GT to become idle fails.

Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
Cc: Chris Wilson <chris.p.wilson@linux.intel.com>
---
 drivers/gpu/drm/i915/i915_gem_gtt.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_gem_gtt.c b/drivers/gpu/drm/i915/i915_gem_gtt.c
index 25295eb626dc..a8463854be64 100644
--- a/drivers/gpu/drm/i915/i915_gem_gtt.c
+++ b/drivers/gpu/drm/i915/i915_gem_gtt.c
@@ -16,6 +16,7 @@
 #include <asm/smp.h>
 
 #include "gt/intel_gt.h"
+#include "gt/intel_gt_print.h"
 #include "gt/intel_gt_requests.h"
 
 #include "i915_drv.h"
@@ -58,10 +59,14 @@ void i915_gem_gtt_finish_pages(struct drm_i915_gem_object *obj,
 	struct drm_i915_private *i915 = to_i915(obj->base.dev);
 	struct i915_ggtt *ggtt = to_gt(i915)->ggtt;
 
-	/* XXX This does not prevent more requests being submitted! */
-	if (unlikely(ggtt->do_idle_maps))
-		/* Wait a bit, in the hope it avoids the hang */
-		usleep_range(100, 250);
+	if (unlikely(ggtt->do_idle_maps)) {
+		struct intel_gt *gt;
+		int i;
+
+		for_each_gt(gt, i915, i)
+			if (intel_gt_wait_for_idle(gt, MAX_SCHEDULE_TIMEOUT))
+				gt_err(gt, "Failed to idle before DMA unmap\n");
+	}
 
 	dma_unmap_sg(i915->drm.dev, pages->sgl, pages->nents,
 		     DMA_BIDIRECTIONAL);
-- 
2.53.0

