Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 372EEEA3C59
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 12:15:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96D4910E7DE;
	Thu,  9 Apr 2026 12:15:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="iAvsPrvy";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D36BB10E7DD;
 Thu,  9 Apr 2026 12:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775736936; x=1807272936;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=24niVZ7Xd78vE92XO/bVscsqaibWjgXP+ZAACmc4G5w=;
 b=iAvsPrvyz0D/hODGB9TJwVeOFXJ036NQ7Oz9HRBnGyesrH7pjStioRir
 Syh8Xilc+pwrx+NxFiAOsLx1y6Zmrfe99JBfbL+LTBLiu7nFbXXzgfpAL
 2gNbW/2D7FjRsjsUXVRzGF9PoInvecVdDG4lsf5nkog4cLZqz0rCj0S2Z
 GHQG5c1MsTFalK8715+wgImB29QdsMSmpop/NUkMN5p4Sn6700cTG3F2q
 z72LczM9P7uXuIg1zfJvFgZL07NV3tq8zXehNLPpLI2Rab3nrAdcSQ+sl
 Ks6VZCHGq5ORRmg7i+871kAuL0XSQVF30hqwF6iEYbFqKMBAF+baFW0T5 Q==;
X-CSE-ConnectionGUID: yoC2m3vtTI2YlFqQxyS2DA==
X-CSE-MsgGUID: 4AcCSNOiQDi2iN1EraAl3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="64277925"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; d="scan'208";a="64277925"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2026 05:15:35 -0700
X-CSE-ConnectionGUID: SJJlBut5RSKLBeB094yKWQ==
X-CSE-MsgGUID: h0KLcpR0TYaSnh11r0ZVZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; d="scan'208";a="228648556"
Received: from abityuts-desk.ger.corp.intel.com (HELO mwauld-desk.intel.com)
 ([10.245.245.222])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2026 05:15:34 -0700
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, Matthew Brost <matthew.brost@intel.com>,
 Christian Koenig <christian.koenig@amd.com>,
 Dave Airlie <airlied@redhat.com>, Ryszard Knop <ryszard.knop@intel.com>
Subject: [PATCH 1/2] drm/ttm/tests: fix lru_count ASSERT
Date: Thu,  9 Apr 2026 13:15:09 +0100
Message-ID: <20260409121512.81298-3-matthew.auld@intel.com>
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
Reviewed-by: Ryszard Knop <ryszard.knop@intel.com>
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

