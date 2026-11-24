Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220A9606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 06:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DP0AJC6M
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04DC910E671;
	Tue, 24 Nov 2026 06:17:02 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5096E10E110;
 Tue, 24 Nov 2026 06:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795501011; x=1827037011;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hCdCu0C4UBtcyrubR0P36o5HJA7J8/6/HDzg/ijZEiE=;
 b=DP0AJC6MTHmaD4SfnuROH4oV1YhY8nqLHLZPGqMKsTTJmOssTkoElNgZ
 FVoyN/x5SBA5krnmz2w+/rRJ9fFun8A7tV5F0RyCwg2yUE+KfsaC/u+vq
 OLvrEOI/zvP+47vcwi5qH0TOsnb0JGdAArDwNg/RzDZ+5vEQldj2DrP+g
 BG/oStgrIWKACgH4KPPSOavrz+SIVeP1OSOn9PalaLLiZr7LZ4H3qoSMw
 qbLKnE8nmgaZSP0on5bHUgX+DAG7wCxRhXKsAEbwtWJ1uw7GxTI/zLyX1
 hU4KRiu7kI4n7zIX3MGnQlse/xMWqWu7BL0UKvJUvZimXvRQuGCv0wn7y Q==;
X-CSE-ConnectionGUID: +iWOvAaeRUaPatZeaoKcmw==
X-CSE-MsgGUID: iX/hLBVXQY++WVbmyytM8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4220029"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4220029"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 22:16:50 -0800
X-CSE-ConnectionGUID: gxl7ZwRcQtOAZzHGfA0jXg==
X-CSE-MsgGUID: tx6uFRUiTGCgYjRd3e6mdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; d="scan'208";a="11264100"
Received: from hghimira.iind.intel.com ([10.190.239.34])
 by orviesa008.jf.intel.com with ESMTP; 23 Nov 2026 22:16:47 -0800
From: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
To: Natalie Vock <natalie.vock@gmx.de>,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 Huang Rui <ray.huang@amd.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Subject: [RFC v2 01/11] drm/ttm: Add NUMA placement policy to ttm_operation_ctx
Date: Tue, 24 Nov 2026 11:51:25 +0530
Message-ID: <20261124062123.2431244-14-himal.prasad.ghimiray@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124062123.2431244-13-himal.prasad.ghimiray@intel.com>
References: <20261124062123.2431244-13-himal.prasad.ghimiray@intel.com>
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

The TTM pool already keeps its page caches, accounting and shrinker per
NUMA node, but always allocates on the pool's default node. Add a
numa_info member to struct ttm_operation_ctx with a policy and a nodemask,
and honor it in __ttm_pool_alloc(), so both ttm_pool_alloc() and restore
of backed-up content can place pages according to the policy.

Add enum ttm_numa_policy with TTM_NUMA_POLICY_PREFERRED, which allocates
from the single node in the mask and may fall back to other nodes.
TTM_NUMA_POLICY_NONE is zero, so zero-initialized users keep the existing
behaviour.

dma-alloc pools can't honor a policy and return -EOPNOTSUPP. An empty
mask returns -EINVAL, and PREFERRED with a mask that is not exactly one
node returns -EINVAL.

v2:
- Replace ttm_pool_alloc_node(), ttm_tt_restore_node() and
  ttm_pool_restore_and_alloc_node() with a node in struct
  ttm_operation_ctx, instead of adding a second NUMA aware path
  (Christian)
- Keep NUMA_NO_NODE unresolved for alloc_pages_node() so memoryless
  nodes still fall back to numa_mem_id() (sashiko)
- Fix commit message claiming the pool helpers already take a nid
  (sashiko)
- Group the NUMA fields in a numa_info sub-struct
- Replace the single node field with a policy and a nodemask, so other
  mempolicy modes can be added (Thomas)

Signed-off-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
---
 drivers/gpu/drm/ttm/ttm_pool.c | 56 +++++++++++++++++++++++++++++-----
 include/drm/ttm/ttm_bo.h       | 30 ++++++++++++++++++
 2 files changed, 79 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 1bf37023fed6..e17bd5c0eab3 100644
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
@@ -780,11 +780,34 @@ static unsigned int ttm_pool_alloc_find_order(unsigned int highest,
 	return min_t(unsigned int, highest, __fls(alloc->remaining_pages));
 }
 
+/* Validate the NUMA request in @ctx against @pool */
+static int ttm_pool_check_numa(struct ttm_pool *pool,
+			       const struct ttm_operation_ctx *ctx)
+{
+	if (ctx->numa_info.policy == TTM_NUMA_POLICY_NONE)
+		return 0;
+
+	if (ttm_pool_uses_dma_alloc(pool))
+		return -EOPNOTSUPP;
+
+	if (!ctx->numa_info.nodes || nodes_empty(*ctx->numa_info.nodes))
+		return -EINVAL;
+
+	if (ctx->numa_info.policy == TTM_NUMA_POLICY_PREFERRED &&
+	    nodes_weight(*ctx->numa_info.nodes) != 1)
+		return -EINVAL;
+
+	return 0;
+}
+
 static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 			    const struct ttm_operation_ctx *ctx,
 			    struct ttm_pool_alloc_state *alloc,
 			    struct ttm_pool_tt_restore *restore)
 {
+	/* pool->nid may be NUMA_NO_NODE, letting alloc_pages_node() pick */
+	int alloc_nid = pool->nid, take_nid = ttm_pool_nid(pool);
+	enum ttm_numa_policy policy = ctx->numa_info.policy;
 	enum ttm_caching page_caching;
 	gfp_t gfp_flags = GFP_USER;
 	pgoff_t caching_divide;
@@ -796,6 +819,12 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 	WARN_ON(!alloc->remaining_pages || ttm_tt_is_populated(tt));
 	WARN_ON(alloc->dma_addr && !pool->dev);
 
+	if (policy != TTM_NUMA_POLICY_NONE) {
+		/* Start at the single node of the policy */
+		alloc_nid = first_node(*ctx->numa_info.nodes);
+		take_nid = alloc_nid;
+	}
+
 	if (tt->page_flags & TTM_TT_FLAG_ZERO_ALLOC)
 		gfp_flags |= __GFP_ZERO;
 
@@ -818,7 +847,7 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 		p = NULL;
 		pt = ttm_pool_select_type(pool, page_caching, order);
 		if (pt && allow_pools)
-			p = ttm_pool_type_take(pt, ttm_pool_nid(pool));
+			p = ttm_pool_type_take(pt, take_nid);
 
 		/*
 		 * If that fails or previously failed, allocate from system.
@@ -829,7 +858,8 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 		if (!p) {
 			page_caching = ttm_cached;
 			allow_pools = false;
-			p = ttm_pool_alloc_page(pool, gfp_flags, order);
+			p = ttm_pool_alloc_page(pool, gfp_flags, order,
+						alloc_nid);
 		}
 		/* If that fails, lower the order if possible and retry. */
 		if (!p) {
@@ -888,16 +918,22 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
  * Fill the ttm_tt object with pages and also make sure to DMA map them when
  * necessary.
  *
- * Returns: 0 on successe, negative error code otherwise.
+ * Returns: 0 on successe, -EOPNOTSUPP if @ctx requests a NUMA node on a
+ * dma-alloc pool, negative error code otherwise.
  */
 int ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 		   struct ttm_operation_ctx *ctx)
 {
 	struct ttm_pool_alloc_state alloc;
+	int ret;
 
 	if (WARN_ON(ttm_tt_is_backed_up(tt)))
 		return -EINVAL;
 
+	ret = ttm_pool_check_numa(pool, ctx);
+	if (ret)
+		return ret;
+
 	ttm_pool_alloc_state_init(tt, &alloc);
 
 	return __ttm_pool_alloc(pool, tt, ctx, &alloc, NULL);
@@ -915,7 +951,9 @@ EXPORT_SYMBOL(ttm_pool_alloc);
  * Fill the ttm_tt object with pages and also make sure to DMA map them when
  * necessary. Read in backed-up content.
  *
- * Returns: 0 on successe, negative error code otherwise.
+ * Returns: 0 on success, -EOPNOTSUPP if @ctx requests a NUMA placement on a
+ * dma-alloc pool, -EINVAL on an empty NUMA policy, negative error code
+ * otherwise.
  */
 int ttm_pool_restore_and_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 			       const struct ttm_operation_ctx *ctx)
@@ -927,6 +965,10 @@ int ttm_pool_restore_and_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 	if (WARN_ON(!ttm_tt_is_backed_up(tt)))
 		return -EINVAL;
 
+	ret = ttm_pool_check_numa(pool, ctx);
+	if (ret)
+		return ret;
+
 	if (!restore) {
 		gfp_t gfp = GFP_KERNEL | __GFP_NOWARN;
 
diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
index 32791c4db2a9..5289c17cd449 100644
--- a/include/drm/ttm/ttm_bo.h
+++ b/include/drm/ttm/ttm_bo.h
@@ -35,6 +35,7 @@
 
 #include <linux/kref.h>
 #include <linux/list.h>
+#include <linux/nodemask.h>
 
 #include "ttm_device.h"
 
@@ -51,6 +52,18 @@ struct ttm_resource;
 struct ttm_resource_manager;
 struct ttm_tt;
 
+/**
+ * enum ttm_numa_policy - NUMA placement policy for system pages
+ *
+ * @TTM_NUMA_POLICY_NONE: No policy. Use the pool default node.
+ * @TTM_NUMA_POLICY_PREFERRED: Prefer the single node in
+ *	ttm_operation_ctx.numa_info.nodes. Falls back to other nodes.
+ */
+enum ttm_numa_policy {
+	TTM_NUMA_POLICY_NONE = 0,
+	TTM_NUMA_POLICY_PREFERRED,
+};
+
 /**
  * enum ttm_bo_type
  *
@@ -187,6 +200,23 @@ struct ttm_operation_ctx {
 	 * when multiple BOs share the same reservation object @resv.
 	 */
 	bool allow_res_evict;
+	/**
+	 * @numa_info: NUMA placement of system pages. Not supported by
+	 * dma-alloc pools.
+	 */
+	struct {
+		/**
+		 * @numa_info.policy: Policy applied to the allocation, see
+		 * &enum ttm_numa_policy.
+		 */
+		enum ttm_numa_policy policy;
+		/**
+		 * @numa_info.nodes: Nodes the policy applies to. Must be set
+		 * and non-empty when @policy is not TTM_NUMA_POLICY_NONE. Must
+		 * contain exactly one node for TTM_NUMA_POLICY_PREFERRED.
+		 */
+		const nodemask_t *nodes;
+	} numa_info;
 	/**
 	 * @resv: Reservation object to be used together with
 	 * @allow_res_evict.
-- 
2.43.0

