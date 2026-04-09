Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D37F0EA3C4E
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 12:15:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFD1E10E7E2;
	Thu,  9 Apr 2026 12:15:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="a+hXgd0S";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35D1410E7DE;
 Thu,  9 Apr 2026 12:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775736937; x=1807272937;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MNi0ESn0wetHAP6FJ6X1AHQPl6EnqxU9XBIRr0LRAgg=;
 b=a+hXgd0SIBSwNe6n3CxC9K7mGWzE5McWSVnHsJnIQLxRp+TLLdAbOU4O
 Hj8dUbwqB3nkeWpnlItIwQFSZjfWT8EQ/FTbHO8gjPprr4aS7brHwOYwj
 VVGmEw2bVccsa3Jvmo4HWHwUTC5wZjc03EGaQ+q6t6wYQE6BK9v4jqHny
 sKhtulzsYxe2orUBA0hsQTvD1UvmjA6zyI5/w7Nje0+bfofzwIJFZC2Eg
 JuW5JZ0qYDcNoCm91O7qN0soon+u+N+QCcyyV3vqvGmGq41HapAIZrffl
 rx88lVBqtLMPSV5GlW5fHhd4+crAL3FtPjnJz/AbcCKoHcVc3cSbVmDzV w==;
X-CSE-ConnectionGUID: +3Fc9ERmQ+yvgGrHUMxmgg==
X-CSE-MsgGUID: NHHEC1FeS/+w/joiAdEBWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="64277932"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; d="scan'208";a="64277932"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2026 05:15:37 -0700
X-CSE-ConnectionGUID: IWYGSgU0QAOqVd3435OXEQ==
X-CSE-MsgGUID: 6COcucQKR8S0sjVfJrc0KA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; d="scan'208";a="228648560"
Received: from abityuts-desk.ger.corp.intel.com (HELO mwauld-desk.intel.com)
 ([10.245.245.222])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2026 05:15:36 -0700
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, Ryszard Knop <ryszard.knop@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Christian Koenig <christian.koenig@amd.com>,
 Dave Airlie <airlied@redhat.com>
Subject: [PATCH 2/2] drm/ttm/tests: make no_dma_alloc conditional on x86
Date: Thu,  9 Apr 2026 13:15:10 +0100
Message-ID: <20260409121512.81298-4-matthew.auld@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260409121512.81298-3-matthew.auld@intel.com>
References: <20260409121512.81298-3-matthew.auld@intel.com>
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

If you run this on UML, this goes down in flames with:

[10:23:33] Pid: 75, comm: kunit_try_catch Tainted: G        W        N  7.0.0-rc7-g221d0418dcfd
[10:23:33] RIP: 0033:list_lru_count_node+0xe/0x20
[10:23:33] RSP: 00000000a88cbed8  EFLAGS: 00010246
[10:23:33] RAX: 0000000000000000 RBX: 00000000a8803c90 RCX: 0000000068e4c7d8
[10:23:33] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000068c86880
[10:23:33] RBP: 0000000068c86800 R08: 00000000a7658c28 R09: 0000000068c50c80
[10:23:33] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000068c50c80

On UML (with no special dma pool flag) there are no special page pools
it seems, so directly accessing the pool state is currently invalid,
since the lru stuff is not initialised.

With that make no_dma_alloc conditional on x86, where there should
always be some kind of special pool, if we don't supply the special dma
pool flag.

Fixes: 444e2a19d7fd ("ttm/pool: port to list_lru. (v2)")
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Ryszard Knop <ryszard.knop@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Dave Airlie <airlied@redhat.com>
---
 drivers/gpu/drm/ttm/tests/ttm_pool_test.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/ttm/tests/ttm_pool_test.c b/drivers/gpu/drm/ttm/tests/ttm_pool_test.c
index 01197014b83f..926615f63ffd 100644
--- a/drivers/gpu/drm/ttm/tests/ttm_pool_test.c
+++ b/drivers/gpu/drm/ttm/tests/ttm_pool_test.c
@@ -2,6 +2,7 @@
 /*
  * Copyright © 2023 Intel Corporation
  */
+#include "linux/kconfig.h"
 #include <linux/mm.h>
 
 #include <drm/ttm/ttm_tt.h>
@@ -373,6 +374,11 @@ static void ttm_pool_free_no_dma_alloc(struct kunit *test)
 	unsigned int order = 2;
 	size_t size = (1 << order) * PAGE_SIZE;
 
+	if (!IS_ENABLED(CONFIG_X86)) {
+		kunit_skip(test, "Needs to be run on x86. Skipping.\n");
+		return;
+	}
+
 	tt = ttm_tt_kunit_init(test, 0, caching, size);
 	KUNIT_ASSERT_NOT_NULL(test, tt);
 
-- 
2.53.0

