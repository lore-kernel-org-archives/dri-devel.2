Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21E6606A321
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 06:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LqvBwfCB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0514010E54F;
	Tue, 24 Nov 2026 06:17:00 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FD7D10E768;
 Tue, 24 Nov 2026 06:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795501014; x=1827037014;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=sGTeDUin/8yWRgO7mIPWobficktdrebqbDsncuuBS1Q=;
 b=LqvBwfCB7bfMLs6XBPxXDiyMFFs865rFz/MGJImZ0/ZtDizAYlEc3xXF
 WEVzDFYnoWLQ9D6eE251clPLO9EBTSIwwrJ29nylXtr7TyQGU1/EUEVd4
 B9FOweQoTjIEqNk+sjqYAl+c9IWCf/eaNCVUxpm7Xpay6f98Qna5g0hUh
 Awxz8oEPWKSLNJbZJXQEukMVLSDYm39IyaMNhc1ZSkgdtaU06VNZ4hcsj
 mXfE3aweng+NBVU34tpaSM9EmWFKo7vltAyRmy1OFl5u1HYdCeEmqvtip
 RhSOlpGbvwEfJb/FxUkb2tCtry6NlIkgu3JmoQ6ID1P9eWLWoXZmYRf8u w==;
X-CSE-ConnectionGUID: B/E+H7oTTKKMMDkTmYNThA==
X-CSE-MsgGUID: KDmSqdD7SgOPu7OrfHT90g==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4220037"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4220037"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 22:16:53 -0800
X-CSE-ConnectionGUID: AnAL3XxiQNqNzU/mIETl/g==
X-CSE-MsgGUID: Co63hIcBTCiiqc3gW3ufYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; d="scan'208";a="11264109"
Received: from hghimira.iind.intel.com ([10.190.239.34])
 by orviesa008.jf.intel.com with ESMTP; 23 Nov 2026 22:16:50 -0800
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
Subject: [RFC v2 02/11] drm/ttm: Add TTM_NUMA_POLICY_BIND
Date: Tue, 24 Nov 2026 11:51:26 +0530
Message-ID: <20261124062123.2431244-15-himal.prasad.ghimiray@intel.com>
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

Add TTM_NUMA_POLICY_BIND to enum ttm_numa_policy. With this policy,
system pages are allocated only from the nodes in
ttm_operation_ctx.numa_info.nodes, tried nearest first from the local
node (ttm_pool_nid()) by node_distance(), with ties broken by lower
node id.

__GFP_THISNODE is added for each node so the allocator never falls back
to nodes outside the policy, including for order 0 allocations. Failures
on all policy nodes use the existing order fallback and error path.

Signed-off-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
---
 drivers/gpu/drm/ttm/ttm_pool.c | 58 ++++++++++++++++++++++++++++++++--
 include/drm/ttm/ttm_bo.h       |  4 +++
 2 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index e17bd5c0eab3..4a7775bfd0fb 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -780,6 +780,56 @@ static unsigned int ttm_pool_alloc_find_order(unsigned int highest,
 	return min_t(unsigned int, highest, __fls(alloc->remaining_pages));
 }
 
+/*
+ * Try the nodes in @nodes once each, nearest first from the local node.
+ * __GFP_THISNODE prevents fallback to nodes outside the policy.
+ */
+static struct page *ttm_pool_alloc_bind_pass(struct ttm_pool *pool,
+					     gfp_t gfp_flags, unsigned int order,
+					     const nodemask_t *nodes)
+{
+	int local = ttm_pool_nid(pool);
+	nodemask_t todo = *nodes;
+	struct page *p = NULL;
+
+	while (!nodes_empty(todo)) {
+		int nid = first_node(todo), n;
+
+		for_each_node_mask(n, todo) {
+			if (node_distance(local, n) < node_distance(local, nid))
+				nid = n;
+		}
+		node_clear(nid, todo);
+
+		p = ttm_pool_alloc_page(pool, gfp_flags | __GFP_THISNODE, order,
+					nid);
+		if (p)
+			break;
+	}
+
+	return p;
+}
+
+/*
+ * Allocate pages of size 1 << order for TTM_NUMA_POLICY_BIND. Nodes with free
+ * memory are tried without reclaim first, then with the caller's gfp flags.
+ */
+static struct page *ttm_pool_alloc_bind(struct ttm_pool *pool, gfp_t gfp_flags,
+					unsigned int order,
+					const nodemask_t *nodes)
+{
+	const unsigned int beneficial_order = ttm_pool_beneficial_order(pool);
+	gfp_t nowait = (gfp_flags & ~__GFP_RECLAIM) | __GFP_NOWARN;
+	struct page *p;
+
+	p = ttm_pool_alloc_bind_pass(pool, nowait, order, nodes);
+	/* Orders without reclaim would repeat the first pass */
+	if (!p && (!order || !beneficial_order || order == beneficial_order))
+		p = ttm_pool_alloc_bind_pass(pool, gfp_flags, order, nodes);
+
+	return p;
+}
+
 /* Validate the NUMA request in @ctx against @pool */
 static int ttm_pool_check_numa(struct ttm_pool *pool,
 			       const struct ttm_operation_ctx *ctx)
@@ -858,8 +908,12 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 		if (!p) {
 			page_caching = ttm_cached;
 			allow_pools = false;
-			p = ttm_pool_alloc_page(pool, gfp_flags, order,
-						alloc_nid);
+			if (policy == TTM_NUMA_POLICY_BIND)
+				p = ttm_pool_alloc_bind(pool, gfp_flags, order,
+							ctx->numa_info.nodes);
+			else
+				p = ttm_pool_alloc_page(pool, gfp_flags, order,
+							alloc_nid);
 		}
 		/* If that fails, lower the order if possible and retry. */
 		if (!p) {
diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
index 5289c17cd449..e7605e7e97ec 100644
--- a/include/drm/ttm/ttm_bo.h
+++ b/include/drm/ttm/ttm_bo.h
@@ -58,10 +58,14 @@ struct ttm_tt;
  * @TTM_NUMA_POLICY_NONE: No policy. Use the pool default node.
  * @TTM_NUMA_POLICY_PREFERRED: Prefer the single node in
  *	ttm_operation_ctx.numa_info.nodes. Falls back to other nodes.
+ * @TTM_NUMA_POLICY_BIND: Allocate only from the nodes in
+ *	ttm_operation_ctx.numa_info.nodes, in ascending node order. Never falls
+ *	back to other nodes.
  */
 enum ttm_numa_policy {
 	TTM_NUMA_POLICY_NONE = 0,
 	TTM_NUMA_POLICY_PREFERRED,
+	TTM_NUMA_POLICY_BIND,
 };
 
 /**
-- 
2.43.0

