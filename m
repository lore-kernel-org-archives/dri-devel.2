Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07940EA3C23
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 11:11:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6450910E7BC;
	Thu,  9 Apr 2026 11:11:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Ww1YcAmP";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CFCB10E7BC;
 Thu,  9 Apr 2026 11:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775733059; x=1807269059;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=LQZgc40djv49y3lHPMHabcAyVaeGswnqlflmqb4JCnA=;
 b=Ww1YcAmPaKUFOeasOy85eh94RkyjvFhlQ/Ll5z1nXJAUDda0/KL4IfHR
 TKe1BXSOOlqydaVSeH7Of/UGMKbXYzG9KH8+vmTY8/yXZfifWT3WAf2zZ
 nZnaDs6gJLHmU+6GM24aEj7/8ae/EixZfkSOGbaau4rWZ3AhIQ9NX49F+
 OAENmjz+snfFFZ0vOIUO4T4hcuKoeWrKU+jw3guJRhP5FNEgZTOiBeNzf
 6kfkVvZzUcLx4rHS6PiHdVmfVi29PjTbvSY7wFAM4ax3+LGJyJYSPpMHP
 eGawDNP4Up6bu6zQkpPMlMs6szoMdoCPoRzgwVBrbEjHbF7cA1mlbExFX A==;
X-CSE-ConnectionGUID: xBBvmfbbRLuFZM4Q6m0NxQ==
X-CSE-MsgGUID: 2R+Q48q/T3a+xBIAzBskUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="99362336"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; d="scan'208";a="99362336"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2026 04:10:59 -0700
X-CSE-ConnectionGUID: 14XOEJhgQkik2TYYFaQNOw==
X-CSE-MsgGUID: uw4VfQ7+QQmSJ6WcNLRCbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; d="scan'208";a="266716340"
Received: from abityuts-desk.ger.corp.intel.com (HELO mwauld-desk.intel.com)
 ([10.245.245.222])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2026 04:10:58 -0700
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, Matthew Brost <matthew.brost@intel.com>,
 Christian Koenig <christian.koenig@amd.com>,
 Dave Airlie <airlied@redhat.com>
Subject: [PATCH] drm/ttm/tests: fix lru_count ASSERT
Date: Thu,  9 Apr 2026 12:10:33 +0100
Message-ID: <20260409111032.72141-2-matthew.auld@intel.com>
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

On pool init we should expect the lru_count for each node to be zeroed
as per __list_lru_init -> init_one_lru, but here we are asserting the
opposite.

Currently our CI is blowing up with:

10:23:33] # ttm_device_init_pools: ASSERTION FAILED at drivers/gpu/drm/ttm/tests/ttm_device_test.c:178
[10:23:33] Expected !list_lru_count(&pt.pages) to be false, but is true
[10:23:33] [FAILED] DMA allocations, DMA32 required
[10:23:33] [PASSED] No DMA allocations, DMA32 required
[10:23:33]     # ttm_device_init_pools: ASSERTION FAILED at drivers/gpu/drm/ttm/tests/ttm_device_test.c:178
[10:23:33]     Expected !list_lru_count(&pt.pages) to be false, but is true

Fixes: 444e2a19d7fd ("ttm/pool: port to list_lru. (v2)")
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Dave Airlie <airlied@redhat.com>
---
 drivers/gpu/drm/ttm/tests/ttm_device_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/tests/ttm_device_test.c b/drivers/gpu/drm/ttm/tests/ttm_device_test.c
index db4b4a09a73f..8bcac84e9846 100644
--- a/drivers/gpu/drm/ttm/tests/ttm_device_test.c
+++ b/drivers/gpu/drm/ttm/tests/ttm_device_test.c
@@ -176,7 +176,7 @@ static void ttm_device_init_pools(struct kunit *test)
 
 				if (ttm_pool_uses_dma_alloc(pool))
 					KUNIT_ASSERT_FALSE(test,
-							   !list_lru_count(&pt.pages));
+							   list_lru_count(&pt.pages));
 			}
 		}
 	}
-- 
2.53.0

