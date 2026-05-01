Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4AB5FF885A
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 22:30:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11D5710E21E;
	Fri,  1 May 2026 22:30:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="UtYKX7lC";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E57710E21E;
 Fri,  1 May 2026 22:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777674608; x=1809210608;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=rEucf/piCjzDV4SUfkYdbsPme71jTAOOdWMnv/VvYfw=;
 b=UtYKX7lCABIkoctXK7YfUekLjt3i3TxcO2NBk3jtPUQSAHmxd1GSrgnt
 sCy7MyKCmYOwV0bgSf3EqVbpOVz3UOo3gE1MXX4l4z90gRmyqarNP6Jux
 HCwq8jlcrdDBsHaw0iyUT+PJxKWVLsTXARkUymxoRgt7eF85w4gdUF2wp
 IqJWHcn+dekOxuA+uAmA385yIqK8aJNwP6vRXqlPAiQyNP+Fxpagf/3AT
 TULvIdrq6nlO9+9qmdiHNaznMV7pCNIqj8fpLJv3KnMeCag5iDQEsBtvM
 PJh4J/MTbEHwTRJLgeA8ZO5xWGaKFBqIOKqX2Oa2RZKP11PkRz525roXs Q==;
X-CSE-ConnectionGUID: y5xIAL96RFukOVQwBDh8og==
X-CSE-MsgGUID: auYyStQ0RzKYHUtc3fTr4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11773"; a="90096799"
X-IronPort-AV: E=Sophos;i="6.23,210,1770624000"; d="scan'208";a="90096799"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 May 2026 15:30:07 -0700
X-CSE-ConnectionGUID: /jLbNPlBQJ+JpEjcZ5i/Gg==
X-CSE-MsgGUID: s+czy5eTSUGvj7l0U7Mj1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,210,1770624000"; d="scan'208";a="234113188"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 May 2026 15:30:08 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: Kenneth Crudup <kenny@panix.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>, David Airlie <airlied@gmail.com>
Subject: [PATCH] drm/ttm: Fix GPU MM stats during pool shrinking
Date: Fri,  1 May 2026 15:30:03 -0700
Message-Id: <20260501223003.2648450-1-matthew.brost@intel.com>
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

TTM pool shrinking frees pages by calling __free_pages() directly,
which bypasses updates to NR_GPU_ACTIVE and leaves GPU MM accounting
out of sync.

Introduce a helper, __free_pages_gpu_account(), and use it for all page
frees in ttm_pool.c so GPU MM statistics are updated consistently.

Reported-by: Kenneth Crudup <kenny@panix.com>
Fixes: ae80122f3896 ("drm/ttm: use gpu mm stats to track gpu memory allocations. (v4)")
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: David Airlie <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/ttm/ttm_pool.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 26a3689e5fd9..95bbd9328072 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -206,6 +206,14 @@ static struct page *ttm_pool_alloc_page(struct ttm_pool *pool, gfp_t gfp_flags,
 	return NULL;
 }
 
+static void __free_pages_gpu_account(struct page *p, unsigned int order,
+				     bool reclaim)
+{
+	mod_lruvec_page_state(p, reclaim ? NR_GPU_RECLAIM : NR_GPU_ACTIVE,
+			      -(1 << order));
+	__free_pages(p, order);
+}
+
 /* Reset the caching and pages of size 1 << order */
 static void ttm_pool_free_page(struct ttm_pool *pool, enum ttm_caching caching,
 			       unsigned int order, struct page *p, bool reclaim)
@@ -223,9 +231,7 @@ static void ttm_pool_free_page(struct ttm_pool *pool, enum ttm_caching caching,
 #endif
 
 	if (!pool || !ttm_pool_uses_dma_alloc(pool)) {
-		mod_lruvec_page_state(p, reclaim ? NR_GPU_RECLAIM : NR_GPU_ACTIVE,
-				      -(1 << order));
-		__free_pages(p, order);
+		__free_pages_gpu_account(p, order, reclaim);
 		return;
 	}
 
@@ -606,7 +612,7 @@ static int ttm_pool_restore_commit(struct ttm_pool_tt_restore *restore,
 			 */
 			ttm_pool_split_for_swap(restore->pool, p);
 			copy_highpage(restore->alloced_page + i, p);
-			__free_pages(p, 0);
+			__free_pages_gpu_account(p, 0, false);
 		}
 
 		restore->restored_pages++;
@@ -1068,7 +1074,7 @@ long ttm_pool_backup(struct ttm_pool *pool, struct ttm_tt *tt,
 			if (flags->purge) {
 				shrunken += num_pages;
 				page->private = 0;
-				__free_pages(page, order);
+				__free_pages_gpu_account(page, order, false);
 				memset(tt->pages + i, 0,
 				       num_pages * sizeof(*tt->pages));
 			}
-- 
2.34.1

