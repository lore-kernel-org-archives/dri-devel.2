Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2859F606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 22:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EnYraP+i
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76F5010E712;
	Mon,  2 Nov 2026 22:32:38 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C98D810E67E;
 Mon,  2 Nov 2026 22:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793658751; x=1825194751;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mK38Qv0+NhSwzGP2UTEbjHGrvKw9sA6EMzkxrPxMxK8=;
 b=EnYraP+iceTh58oZtSwHoC/ELPxXd2blXh9DWMz+3jQLkSXNJ9+FSh0X
 5OxVriA1ovDMKh56/Vl52cDeG8N1LWsLZsbNsMW2WWNO5Z+pdtnZG6gAR
 vB3U5hZ+ZmQ/XdORAZ5fw/OMuQ6V3GD4IvfRgp6wOmR7jq37ltJeowv32
 MfogWaF6sA7C8WhuQAFJ+BCbm16EeQMO8mFEPxUstChXVrs8HogNl4xV4
 GLBDI5jDLydI+W+C86JhPmWkoMNBM1uFKslB7lFvBz4wR42bC+3FzhgK9
 3IkClxE7WpGdLY+fSYqbtW4COC3b9oKEy4iBc9OGFOdbsqkJtjO6TDHBZ w==;
X-CSE-ConnectionGUID: tFFNnlYtQ3GpaoKMqIXXOQ==
X-CSE-MsgGUID: 0Z76usOrSQ63/2K8yeyrBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2268430"
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="2268430"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 14:32:26 -0800
X-CSE-ConnectionGUID: Kk9Edi9gRWCNrrZ9b5atYA==
X-CSE-MsgGUID: UTmy6dEuRDy2LV/5mP93JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="6628961"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 14:32:26 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: Matthew Auld <matthew.auld@intel.com>
Subject: [PATCH v7 1/3] drm/xe: Bump the LRU on a successful page fault
Date: Mon,  2 Nov 2026 14:32:18 -0800
Message-Id: <20261102223220.1411858-2-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261102223220.1411858-1-matthew.brost@intel.com>
References: <20261102223220.1411858-1-matthew.brost@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Servicing a page fault validates the VMA's backing store and binds it,
making the BO part of the VM's active working set, but unlike exec it
never moves anything on the TTM LRU. In fault mode, where a VM may run
for a long time without a single exec, the BOs the GPU actually touches
therefore drift towards the LRU head and are picked by eviction and by
the shrinker ahead of genuinely cold BOs.

Bump the BO's LRU on a successful page fault.

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
---
 drivers/gpu/drm/xe/xe_pagefault.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_pagefault.c b/drivers/gpu/drm/xe/xe_pagefault.c
index 5247321c805e..dfaba621aac7 100644
--- a/drivers/gpu/drm/xe/xe_pagefault.c
+++ b/drivers/gpu/drm/xe/xe_pagefault.c
@@ -201,6 +201,8 @@ static int xe_pagefault_handle_vma(struct xe_gt *gt, struct xe_vma *vma,
 		xe_validation_ctx_init(&ctx, &vm->xe->val, &exec,
 				       (struct xe_val_flags) {});
 		drm_exec_until_all_locked(&exec) {
+			struct xe_bo *bo = xe_vma_bo(vma);
+
 			err = xe_pagefault_begin(&exec, vma, tile->mem.vram,
 						 needs_vram == 1);
 			drm_exec_retry_on_contention(&exec);
@@ -221,6 +223,10 @@ static int xe_pagefault_handle_vma(struct xe_gt *gt, struct xe_vma *vma,
 				xe_pagefault_set_error(pf, XE_PAGEFAULT_ERROR_VMA_REBIND);
 				break;
 			}
+
+			if (bo) {
+				ttm_bo_move_to_lru_tail_unlocked(&bo->ttm);
+			}
 		}
 		xe_validation_ctx_fini(&ctx);
 	} while (err == -EAGAIN);
-- 
2.34.1

