Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8827ACD98CF
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 22:58:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 823E010E5D1;
	Fri, 12 Jun 2026 22:58:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="bYlgS3zc";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 135BD10E5D1;
 Fri, 12 Jun 2026 22:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781305083; x=1812841083;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=JeagueDeW/R+PZT7hLMq2z6ytILq97Pg3wgOo7Fu8Q8=;
 b=bYlgS3zc8dQTkTgcl4xEXsG9WusGRXm2SWD0qHkpBIrx3ruwX8BKnDZA
 Sjc+6qhs/CXBf6G7hkuyEJSGziU3tlRAuIWO1xaN1uAjys4EphNhhS3WB
 +4myIQszVEhEXROf4AFxgDt2hdZRLNP9fVMKysqJYdsTofXMVJXRz+Rhy
 +4mU6Jw9hSXzBCxKrbc4JG9bdijZvRSkLydSy4GCKPTKg6SOfZsu8h2w1
 FWeCm3k3gxGJmez0yuXu+KPQ1z078WF2rPH1/b0/fuioWBLt6nw1chnZO
 QwTPFUHqLMTzR/pvC+2K4DNWFJ0PakG+PTfUSvT68x0KuMquNO3YKepen A==;
X-CSE-ConnectionGUID: 6+Eu7eJOSMyoqMYgEucU+A==
X-CSE-MsgGUID: 0UAvH0P8Taa0V4lx5a+veg==
X-IronPort-AV: E=McAfee;i="6800,10657,11815"; a="99723728"
X-IronPort-AV: E=Sophos;i="6.24,201,1774335600"; d="scan'208";a="99723728"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2026 15:58:02 -0700
X-CSE-ConnectionGUID: nStl3iyfTyWO/ZKf+eu7iw==
X-CSE-MsgGUID: SisF9q4mTcKzmo4MHOTegA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,201,1774335600"; d="scan'208";a="250855342"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2026 15:58:02 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [CI] drm/ttm: Issue direct reclaim at beneficial_order
Date: Fri, 12 Jun 2026 15:57:57 -0700
Message-Id: <20260612225757.3844350-1-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
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

Triggering kswap at an order higher than beneficial_order makes little
sense, as the driver has already indicated the optimal order at which
reclaim is effective. Similarly, issuing direct reclaim or triggering
kswap at a lower order than beneficial_order is ineffective, since the
driver does not benefit from reclaiming lower-order pages.

As a result, direct reclaim should only be issued with __GFP_NORETRY at
exactly beneficial_order, or as a fallback, direct reclaim without
__GFP_NORETRY at order 0 when failure is not an option.

Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Christian Koenig <christian.koenig@amd.com>
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

---

This was part of a larger shrinker series in Xe and is unlikely to be
merged soon, as it is stuck in review. Send this reviewed, low-hanging
TTM patch on its own, as it slightly helps address Xe's shrinker issues.
---
 drivers/gpu/drm/ttm/ttm_pool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 278bbe7a11ad..e76c3a5c67bd 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -165,8 +165,8 @@ static struct page *ttm_pool_alloc_page(struct ttm_pool *pool, gfp_t gfp_flags,
 	 * Do not add latency to the allocation path for allocations orders
 	 * device tolds us do not bring them additional performance gains.
 	 */
-	if (beneficial_order && order > beneficial_order)
-		gfp_flags &= ~__GFP_DIRECT_RECLAIM;
+	if (order && beneficial_order && order != beneficial_order)
+		gfp_flags &= ~__GFP_RECLAIM;
 
 	if (!ttm_pool_uses_dma_alloc(pool)) {
 		p = alloc_pages_node(pool->nid, gfp_flags, order);
-- 
2.34.1

