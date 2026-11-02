Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB886606A327
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 10:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=I7b0niny
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28B6510E5FC;
	Mon,  2 Nov 2026 10:14:02 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5BAE10E5FC;
 Mon,  2 Nov 2026 10:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793614436; x=1825150436;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gYkY16qJWs/WeWk2MTD7NidEig7oBfSaX3I3f3B2UoA=;
 b=I7b0ninyrA6SFaXLr+AeAFGZDG9pFrnCCZwJIhPbUt/78pv3rk3jZiIp
 urazBUgklza7h7KtrAhFVoOd7Po1Qac6k7aQF2/68eatn2vNpyd1rEZNv
 I1m3GN3fn4G97ma87wpsQS3sRjsq0VwsY6bpif5qGycqqg334OaNwXdu+
 aeno2JZGvRhECeayHC3tRpgbWgf/AJ9NS8hZ6B1BWJ79+rk7DBjOaKJC3
 SE7/4Mp861/yYVe63MGNvYRcnkDW/Y2jF5bWqCWebwyUcUs1tE03igX4E
 nvCz3+GVlWcLsVlgdVyMG8L45afIfZ56+HC+ihNZcC3mL31HdD0TsP4Rh g==;
X-CSE-ConnectionGUID: 4yiSkeNZT8m+COLy8B40og==
X-CSE-MsgGUID: Ue/e8vmiRpyQT07SOb7tTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2200792"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2200792"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 02:13:56 -0800
X-CSE-ConnectionGUID: TLXTsnfqTiaPxJme0OzgwA==
X-CSE-MsgGUID: gM//CNhvRq+7k9zEQCDylQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6002756"
Received: from hghimira.iind.intel.com ([10.190.239.34])
 by orviesa004.jf.intel.com with ESMTP; 02 Nov 2026 02:13:53 -0800
From: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Huang Rui <ray.huang@amd.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org,
 Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Subject: [RFC 1/7] drm/ttm/pool: Add ttm_pool_alloc_node() for caller-selected
 NUMA node
Date: Mon,  2 Nov 2026 15:48:05 +0530
Message-ID: <20261102101803.455921-10-himal.prasad.ghimiray@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102101803.455921-9-himal.prasad.ghimiray@intel.com>
References: <20261102101803.455921-9-himal.prasad.ghimiray@intel.com>
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

ttm_pool_alloc() always allocates on the pool's default node, although
the internal TTM helpers (__ttm_pool_alloc(), ttm_pool_alloc_page(),
ttm_pool_type_take()) already take a nid. Add ttm_pool_alloc_node() to
let a driver pass that nid for a specific tt.

ttm_pool_alloc() passes NUMA_NO_NODE, keeping current behaviour. An
explicit node on a dma_alloc pool returns -EOPNOTSUPP, as
dma_alloc_attrs() can't honor it.

Signed-off-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
---
 drivers/gpu/drm/ttm/ttm_pool.c | 59 +++++++++++++++++++++++++++++-----
 include/drm/ttm/ttm_pool.h     |  2 ++
 2 files changed, 53 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 1bf37023fed6..54d2f6b5c229 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -158,9 +158,9 @@ static int ttm_pool_nid(struct ttm_pool *pool)
 	return nid;
 }
 
-/* Allocate pages of size 1 << order with the given gfp_flags */
+/* Allocate pages of size 1 << order with the given gfp_flags on node @nid */
 static struct page *ttm_pool_alloc_page(struct ttm_pool *pool, gfp_t gfp_flags,
-					unsigned int order)
+					unsigned int order, int nid)
 {
 	const unsigned int beneficial_order = ttm_pool_beneficial_order(pool);
 	unsigned long attr = DMA_ATTR_FORCE_CONTIGUOUS;
@@ -189,7 +189,7 @@ static struct page *ttm_pool_alloc_page(struct ttm_pool *pool, gfp_t gfp_flags,
 	}
 
 	if (!ttm_pool_uses_dma_alloc(pool)) {
-		p = alloc_pages_node(pool->nid, gfp_flags, order);
+		p = alloc_pages_node(nid, gfp_flags, order);
 		if (p) {
 			p->private = order;
 			mod_lruvec_page_state(p, NR_GPU_ACTIVE, 1 << order);
@@ -783,7 +783,8 @@ static unsigned int ttm_pool_alloc_find_order(unsigned int highest,
 static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 			    const struct ttm_operation_ctx *ctx,
 			    struct ttm_pool_alloc_state *alloc,
-			    struct ttm_pool_tt_restore *restore)
+			    struct ttm_pool_tt_restore *restore,
+			    int nid)
 {
 	enum ttm_caching page_caching;
 	gfp_t gfp_flags = GFP_USER;
@@ -818,7 +819,7 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 		p = NULL;
 		pt = ttm_pool_select_type(pool, page_caching, order);
 		if (pt && allow_pools)
-			p = ttm_pool_type_take(pt, ttm_pool_nid(pool));
+			p = ttm_pool_type_take(pt, nid);
 
 		/*
 		 * If that fails or previously failed, allocate from system.
@@ -829,7 +830,7 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 		if (!p) {
 			page_caching = ttm_cached;
 			allow_pools = false;
-			p = ttm_pool_alloc_page(pool, gfp_flags, order);
+			p = ttm_pool_alloc_page(pool, gfp_flags, order, nid);
 		}
 		/* If that fails, lower the order if possible and retry. */
 		if (!p) {
@@ -900,10 +901,52 @@ int ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 
 	ttm_pool_alloc_state_init(tt, &alloc);
 
-	return __ttm_pool_alloc(pool, tt, ctx, &alloc, NULL);
+	return __ttm_pool_alloc(pool, tt, ctx, &alloc, NULL, ttm_pool_nid(pool));
 }
 EXPORT_SYMBOL(ttm_pool_alloc);
 
+/**
+ * ttm_pool_alloc_node - Fill a ttm_tt object, placing pages on a given node
+ *
+ * @pool: ttm_pool to use
+ * @tt: ttm_tt object to fill
+ * @ctx: operation context
+ * @nid: NUMA node id to allocate the backing system pages from, or
+ * NUMA_NO_NODE to use the pool's default node (@ttm_pool.nid)
+ *
+ * Like ttm_pool_alloc(), but allows the caller to override the NUMA node the
+ * backing system pages are allocated from. This only affects the
+ * non-coherent (non dma-alloc) allocation path; coherent/dma pools continue
+ * to use the device-local node. Intended for drivers that expose a
+ * user-selectable host memory NUMA placement.
+ *
+ * Returns: 0 on success, -EOPNOTSUPP if @nid is specified on a coherent/dma
+ * pool, negative error code otherwise.
+ */
+int ttm_pool_alloc_node(struct ttm_pool *pool, struct ttm_tt *tt,
+			struct ttm_operation_ctx *ctx, int nid)
+{
+	struct ttm_pool_alloc_state alloc;
+
+	if (WARN_ON(ttm_tt_is_backed_up(tt)))
+		return -EINVAL;
+
+	/*
+	 * Coherent/dma pools allocate via dma_alloc_attrs(), which places pages
+	 * per device DMA constraints and cannot honor a caller-requested node.
+	 */
+	if (nid != NUMA_NO_NODE && ttm_pool_uses_dma_alloc(pool))
+		return -EOPNOTSUPP;
+
+	if (nid == NUMA_NO_NODE)
+		nid = ttm_pool_nid(pool);
+
+	ttm_pool_alloc_state_init(tt, &alloc);
+
+	return __ttm_pool_alloc(pool, tt, ctx, &alloc, NULL, nid);
+}
+EXPORT_SYMBOL(ttm_pool_alloc_node);
+
 /**
  * ttm_pool_restore_and_alloc - Fill a ttm_tt, restoring previously backed-up
  * content.
@@ -964,7 +1007,7 @@ int ttm_pool_restore_and_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 		}
 	}
 
-	return __ttm_pool_alloc(pool, tt, ctx, &alloc, restore);
+	return __ttm_pool_alloc(pool, tt, ctx, &alloc, restore, ttm_pool_nid(pool));
 }
 
 /**
diff --git a/include/drm/ttm/ttm_pool.h b/include/drm/ttm/ttm_pool.h
index 26ee592e1994..6a0b14aca092 100644
--- a/include/drm/ttm/ttm_pool.h
+++ b/include/drm/ttm/ttm_pool.h
@@ -79,6 +79,8 @@ struct ttm_pool {
 
 int ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 		   struct ttm_operation_ctx *ctx);
+int ttm_pool_alloc_node(struct ttm_pool *pool, struct ttm_tt *tt,
+			struct ttm_operation_ctx *ctx, int nid);
 void ttm_pool_free(struct ttm_pool *pool, struct ttm_tt *tt);
 
 void ttm_pool_init(struct ttm_pool *pool, struct device *dev,
-- 
2.43.0

