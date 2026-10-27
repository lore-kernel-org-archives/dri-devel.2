Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC0E606A322
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 20:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JhMFDt8v
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 101B010F825;
	Tue, 27 Oct 2026 20:31:25 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F02E410F81C;
 Tue, 27 Oct 2026 20:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793133079; x=1824669079;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=GW2kF11vWqhivxgbUlfhS/HVJlaG083+rjMFU4YGYfc=;
 b=JhMFDt8veV5OinXXuiOB/1e1Sqc8VTJP8y+p5MHFevkYGwSQ22TAW8Wk
 fDrcDb0wvaKqeqZjAQdHRquCdJS+4fIlL8AWV5Bey0sxTz9nkcAHmTEvF
 KE+Rw7Fsnepkup2iFHUHWqOGmAJcGmbB38O6LDpo1deZxFv2ZK3N+I4mc
 xU6Syo7tsn60flUPqvy/KgPN5pL24N8JYHF/P0mtYbB/WMMfZHs6ct7+i
 PMRvADExJ7a894WBxubB7eFXqNEEz/gvO/U0lGDF0yGF5QNzyyp9Fb5il
 I7e4+dLpsAHX4Fz4jHbbAJW33ev9wiRlMHrB8RLb2VzxepopYiH0TywQI g==;
X-CSE-ConnectionGUID: KCtugxAERium3F73MnUYcQ==
X-CSE-MsgGUID: uNpKoR41T/2g+wPKKwW0jg==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1832108"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1832108"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 13:31:13 -0700
X-CSE-ConnectionGUID: dxTLM5B7T7mei87/Mwe23A==
X-CSE-MsgGUID: WhLH/2IcTbGtleMiqTmoSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="5035064"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 13:31:13 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v5 1/3] drm/xe: Bump the LRU on a successful page fault
Date: Tue, 27 Oct 2026 13:31:05 -0700
Message-Id: <20261027203107.1065800-2-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027203107.1065800-1-matthew.brost@intel.com>
References: <20261027203107.1065800-1-matthew.brost@intel.com>
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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
---
 drivers/gpu/drm/xe/xe_pagefault.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_pagefault.c b/drivers/gpu/drm/xe/xe_pagefault.c
index 5247321c805e..7d363160103a 100644
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
@@ -221,6 +223,9 @@ static int xe_pagefault_handle_vma(struct xe_gt *gt, struct xe_vma *vma,
 				xe_pagefault_set_error(pf, XE_PAGEFAULT_ERROR_VMA_REBIND);
 				break;
 			}
+
+			if (bo)
+				ttm_bo_move_to_lru_tail(&bo->ttm);
 		}
 		xe_validation_ctx_fini(&ctx);
 	} while (err == -EAGAIN);
-- 
2.34.1

