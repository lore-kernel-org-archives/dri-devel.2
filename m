Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C52606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 06:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iya9hBvV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A15510E5F9;
	Tue, 24 Nov 2026 06:17:12 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82CB810E21F;
 Tue, 24 Nov 2026 06:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795501018; x=1827037018;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ul4azt9FF1emwERYdKos2rpuqMO4Ws+3SU0NDITaihg=;
 b=iya9hBvVoG+/KNuWfHrtveFdYNhhcW6VW2PW3jd7KPWQ0OB9xl7LaPlD
 RzNuaNPOxzatiDVFPLlgJJqtgX81sQPQQOqLDK8mhDHJxKKUH2yV7lbUI
 qcddV2fkEoX6Opd6w7FXx6u76yReNy2HF4PIg3b5yxyqRzo6UDL+RXe2V
 avk+kExdOw8fWrkm57fvqQnbpP71GLVX4xKP8ZAjH2m67vKmNAIVwh97d
 6N1HIAjKxJDt/079pP2rMAwsa/D2q+SjmBgaAET9ZLYK0173ucUH8HV2x
 qxv1tSSCWhoxc4GTQcbcmfXAujJ7GaR3csiT0n60kPNGoXJSbmqJEu3jI w==;
X-CSE-ConnectionGUID: v+u7WXWTR52lgmz2r3m8Vg==
X-CSE-MsgGUID: 1ocmPdo8QnqxsxTaxsVd7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4220045"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4220045"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 22:16:58 -0800
X-CSE-ConnectionGUID: fcgmhKtLRCWOZZWsa5CNdg==
X-CSE-MsgGUID: UuDau3vATEOj51+z2jwTug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; d="scan'208";a="11264117"
Received: from hghimira.iind.intel.com ([10.190.239.34])
 by orviesa008.jf.intel.com with ESMTP; 23 Nov 2026 22:16:53 -0800
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
Subject: [RFC v2 03/11] drm/ttm: Add TTM_NUMA_POLICY_INTERLEAVE
Date: Tue, 24 Nov 2026 11:51:27 +0530
Message-ID: <20261124062123.2431244-16-himal.prasad.ghimiray@intel.com>
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add TTM_NUMA_POLICY_INTERLEAVE to enum ttm_numa_policy. With this policy,
each page allocation is rotated across the nodes in
ttm_operation_ctx.numa_info.nodes, so consecutive allocations are spread
over the policy nodes. The rotation index wraps around the node weight.

If the rotated node cannot provide a page of the requested order, the
other policy nodes are tried before the order is lowered. This keeps
high order pages when one node is short on memory, as core mm does for
interleaved THP.

The pool take and the allocation for an order use the same node, so
cached pages come from the node the allocation would have used.

Signed-off-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
---
 drivers/gpu/drm/ttm/ttm_pool.c | 91 ++++++++++++++++++++++++++++++++--
 include/drm/ttm/ttm_bo.h       |  3 ++
 2 files changed, 91 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 4a7775bfd0fb..f140cc95e965 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -373,6 +373,38 @@ static struct page *ttm_pool_type_take(struct ttm_pool_type *pt, int nid)
 	return p;
 }
 
+/* Return the node in @nodes nearest to @from, lowest node id on ties */
+static int ttm_pool_nearest_node(int from, const nodemask_t *nodes)
+{
+	int n, nid = first_node(*nodes);
+
+	for_each_node_mask(n, *nodes) {
+		if (node_distance(from, n) < node_distance(from, nid))
+			nid = n;
+	}
+
+	return nid;
+}
+
+/* Take from @nid first, then from the other nodes nearest to @nid first */
+static struct page *ttm_pool_type_take_interleave(struct ttm_pool_type *pt,
+						  int nid, const nodemask_t *nodes)
+{
+	nodemask_t todo = *nodes;
+	struct page *p;
+
+	p = ttm_pool_type_take(pt, nid);
+	node_clear(nid, todo);
+	while (!p && !nodes_empty(todo)) {
+		int n = ttm_pool_nearest_node(nid, &todo);
+
+		node_clear(n, todo);
+		p = ttm_pool_type_take(pt, n);
+	}
+
+	return p;
+}
+
 /* Initialize and add a pool type to the global shrinker list */
 static void ttm_pool_type_init(struct ttm_pool_type *pt, struct ttm_pool *pool,
 			       enum ttm_caching caching, unsigned int order)
@@ -780,6 +812,17 @@ static unsigned int ttm_pool_alloc_find_order(unsigned int highest,
 	return min_t(unsigned int, highest, __fls(alloc->remaining_pages));
 }
 
+/* Return the @n-th node set in @nodes, wrapping around the node weight */
+static int ttm_pool_policy_nth_node(const nodemask_t *nodes, unsigned int n)
+{
+	int nid = first_node(*nodes);
+
+	for (n %= nodes_weight(*nodes); n; n--)
+		nid = next_node(nid, *nodes);
+
+	return nid;
+}
+
 /*
  * Try the nodes in @nodes once each, nearest first from the local node.
  * __GFP_THISNODE prevents fallback to nodes outside the policy.
@@ -830,6 +873,31 @@ static struct page *ttm_pool_alloc_bind(struct ttm_pool *pool, gfp_t gfp_flags,
 	return p;
 }
 
+/*
+ * Allocate pages of size 1 << order for TTM_NUMA_POLICY_INTERLEAVE. Try the
+ * interleaved node @nid first, then the other nodes in @nodes nearest to @nid
+ * first, as the per-node zonelist fallback of core mm does, before the caller
+ * lowers the order.
+ */
+static struct page *ttm_pool_alloc_interleave(struct ttm_pool *pool,
+					      gfp_t gfp_flags, unsigned int order,
+					      int nid, const nodemask_t *nodes)
+{
+	nodemask_t todo = *nodes;
+	struct page *p;
+
+	p = ttm_pool_alloc_page(pool, gfp_flags, order, nid);
+	node_clear(nid, todo);
+	while (!p && !nodes_empty(todo)) {
+		int n = ttm_pool_nearest_node(nid, &todo);
+
+		node_clear(n, todo);
+		p = ttm_pool_alloc_page(pool, gfp_flags, order, n);
+	}
+
+	return p;
+}
+
 /* Validate the NUMA request in @ctx against @pool */
 static int ttm_pool_check_numa(struct ttm_pool *pool,
 			       const struct ttm_operation_ctx *ctx)
@@ -870,7 +938,7 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 	WARN_ON(alloc->dma_addr && !pool->dev);
 
 	if (policy != TTM_NUMA_POLICY_NONE) {
-		/* Start at the single node of the policy */
+		/* INTERLEAVE rotates below, others start at the first node */
 		alloc_nid = first_node(*ctx->numa_info.nodes);
 		take_nid = alloc_nid;
 	}
@@ -893,11 +961,24 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 	     order = ttm_pool_alloc_find_order(order, alloc)) {
 		struct ttm_pool_type *pt;
 
+		if (policy == TTM_NUMA_POLICY_INTERLEAVE) {
+			unsigned int slot = tt->num_pages - alloc->remaining_pages;
+
+			alloc_nid = ttm_pool_policy_nth_node(ctx->numa_info.nodes,
+							     slot >> order);
+			take_nid = alloc_nid;
+		}
+
 		/* First, try to allocate a page from a pool if one exists. */
 		p = NULL;
 		pt = ttm_pool_select_type(pool, page_caching, order);
-		if (pt && allow_pools)
-			p = ttm_pool_type_take(pt, take_nid);
+		if (pt && allow_pools) {
+			if (policy == TTM_NUMA_POLICY_INTERLEAVE)
+				p = ttm_pool_type_take_interleave(pt, take_nid,
+								  ctx->numa_info.nodes);
+			else
+				p = ttm_pool_type_take(pt, take_nid);
+		}
 
 		/*
 		 * If that fails or previously failed, allocate from system.
@@ -911,6 +992,10 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 			if (policy == TTM_NUMA_POLICY_BIND)
 				p = ttm_pool_alloc_bind(pool, gfp_flags, order,
 							ctx->numa_info.nodes);
+			else if (policy == TTM_NUMA_POLICY_INTERLEAVE)
+				p = ttm_pool_alloc_interleave(pool, gfp_flags,
+							      order, alloc_nid,
+							      ctx->numa_info.nodes);
 			else
 				p = ttm_pool_alloc_page(pool, gfp_flags, order,
 							alloc_nid);
diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
index e7605e7e97ec..d81b0cd6edfc 100644
--- a/include/drm/ttm/ttm_bo.h
+++ b/include/drm/ttm/ttm_bo.h
@@ -61,11 +61,14 @@ struct ttm_tt;
  * @TTM_NUMA_POLICY_BIND: Allocate only from the nodes in
  *	ttm_operation_ctx.numa_info.nodes, in ascending node order. Never falls
  *	back to other nodes.
+ * @TTM_NUMA_POLICY_INTERLEAVE: Allocate chunks round-robin across the nodes
+ *	in ttm_operation_ctx.numa_info.nodes.
  */
 enum ttm_numa_policy {
 	TTM_NUMA_POLICY_NONE = 0,
 	TTM_NUMA_POLICY_PREFERRED,
 	TTM_NUMA_POLICY_BIND,
+	TTM_NUMA_POLICY_INTERLEAVE,
 };
 
 /**
-- 
2.43.0

