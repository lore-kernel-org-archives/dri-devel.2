Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D962A606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 10:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MTFvGE94
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3480610EC9B;
	Mon,  2 Nov 2026 10:14:05 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70C1010EC7B;
 Mon,  2 Nov 2026 10:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793614439; x=1825150439;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0NTrsm7I7ghAOJMVFr4UFDmy5rrY006Ruj9auTIWaOw=;
 b=MTFvGE94+s6TwaWYCAvuzeOOCXydSpvGhvqW4/RCIYJ6CUCcaa9AAG84
 wdrNT6CL9pf9iXhDcaqFEDh+2MarWx0TqbyyxdGJBCbSO9aBwhZOHCZ/k
 yuDtw2N7Rvx3jM+DwFg5tNs8tls+h+i6h7jbm9wjc+6n+yFeWK+6sY+De
 elyeKqMofSSfPFaY6SC8MONgBHIH4+SG38ooGTFZ582yjALn6xWQPKXSc
 xRE4kjEjd86molUP+B+USGqtAJSNHoEifCax9WWgu3gqbYcdzimcDxbHm
 lCRB9BiSFv+MdFFuqblxwCaYQ+U+tSVwN1yU7uv1ry5mN+h/7yJmia5LF g==;
X-CSE-ConnectionGUID: GVVigiLsT6aJQz83dkKo2g==
X-CSE-MsgGUID: WpmrP5ijQna+QH/9YqqYJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2200798"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2200798"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 02:13:59 -0800
X-CSE-ConnectionGUID: Wo9OyLXlQKeCIRxAz1huKQ==
X-CSE-MsgGUID: H4VWz/5TT0K0TEm4iMxLRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6002762"
Received: from hghimira.iind.intel.com ([10.190.239.34])
 by orviesa004.jf.intel.com with ESMTP; 02 Nov 2026 02:13:56 -0800
From: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Huang Rui <ray.huang@amd.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org,
 Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Subject: [RFC 2/7] drm/ttm: Add NUMA node aware restore helpers
Date: Mon,  2 Nov 2026 15:48:06 +0530
Message-ID: <20261102101803.455921-11-himal.prasad.ghimiray@intel.com>
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

Restore after shrinker backup always allocates on the pool's default
node, so a placement chosen with ttm_pool_alloc_node() is lost. The
internal restore path already uses __ttm_pool_alloc(), which takes a
nid; add ttm_tt_restore_node() to pass it through.

ttm_tt_restore() passes NUMA_NO_NODE, keeping current behaviour.

Signed-off-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
---
 drivers/gpu/drm/ttm/ttm_pool.c          | 32 ++++++++++++++++++++++++-
 drivers/gpu/drm/ttm/ttm_pool_internal.h |  4 ++++
 drivers/gpu/drm/ttm/ttm_tt.c            | 20 ++++++++++++++--
 include/drm/ttm/ttm_tt.h                |  2 ++
 4 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 54d2f6b5c229..2107dc6c69b3 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -962,6 +962,30 @@ EXPORT_SYMBOL(ttm_pool_alloc_node);
  */
 int ttm_pool_restore_and_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 			       const struct ttm_operation_ctx *ctx)
+{
+	return ttm_pool_restore_and_alloc_node(pool, tt, ctx, NUMA_NO_NODE);
+}
+EXPORT_SYMBOL(ttm_pool_restore_and_alloc);
+
+/**
+ * ttm_pool_restore_and_alloc_node - Fill a ttm_tt, restoring previously
+ * backed-up content, placing pages on a given node.
+ *
+ * @pool: ttm_pool to use
+ * @tt: ttm_tt object to fill
+ * @ctx: operation context
+ * @nid: NUMA node id to allocate the backing system pages from, or
+ * NUMA_NO_NODE to use the pool's default node (@ttm_pool.nid)
+ *
+ * Like ttm_pool_restore_and_alloc(), but allows the caller to keep the NUMA
+ * placement requested at ttm_pool_alloc_node() time across backup / restore.
+ *
+ * Returns: 0 on success, -EOPNOTSUPP if @nid is specified on a coherent/dma
+ * pool, negative error code otherwise.
+ */
+int ttm_pool_restore_and_alloc_node(struct ttm_pool *pool, struct ttm_tt *tt,
+				    const struct ttm_operation_ctx *ctx,
+				    int nid)
 {
 	struct ttm_pool_tt_restore *restore = tt->restore;
 	struct ttm_pool_alloc_state alloc;
@@ -970,6 +994,12 @@ int ttm_pool_restore_and_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 	if (WARN_ON(!ttm_tt_is_backed_up(tt)))
 		return -EINVAL;
 
+	if (nid != NUMA_NO_NODE && ttm_pool_uses_dma_alloc(pool))
+		return -EOPNOTSUPP;
+
+	if (nid == NUMA_NO_NODE)
+		nid = ttm_pool_nid(pool);
+
 	if (!restore) {
 		gfp_t gfp = GFP_KERNEL | __GFP_NOWARN;
 
@@ -1007,7 +1037,7 @@ int ttm_pool_restore_and_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 		}
 	}
 
-	return __ttm_pool_alloc(pool, tt, ctx, &alloc, restore, ttm_pool_nid(pool));
+	return __ttm_pool_alloc(pool, tt, ctx, &alloc, restore, nid);
 }
 
 /**
diff --git a/drivers/gpu/drm/ttm/ttm_pool_internal.h b/drivers/gpu/drm/ttm/ttm_pool_internal.h
index cbb17a2129fe..66ee0e57cdeb 100644
--- a/drivers/gpu/drm/ttm/ttm_pool_internal.h
+++ b/drivers/gpu/drm/ttm/ttm_pool_internal.h
@@ -22,6 +22,10 @@ static inline unsigned int ttm_pool_beneficial_order(struct ttm_pool *pool)
 	return pool->alloc_flags & 0xff;
 }
 
+int ttm_pool_restore_and_alloc_node(struct ttm_pool *pool, struct ttm_tt *tt,
+				    const struct ttm_operation_ctx *ctx,
+				    int nid);
+
 /*
  * Implemented in ttm_pool.c, used by ttm_backup.c. Returns true if a fault
  * should be injected mid-compound to test the reactive split-and-retry
diff --git a/drivers/gpu/drm/ttm/ttm_tt.c b/drivers/gpu/drm/ttm/ttm_tt.c
index b645a1818184..775219ae5367 100644
--- a/drivers/gpu/drm/ttm/ttm_tt.c
+++ b/drivers/gpu/drm/ttm/ttm_tt.c
@@ -298,7 +298,23 @@ long ttm_tt_backup(struct ttm_device *bdev, struct ttm_tt *tt,
 int ttm_tt_restore(struct ttm_device *bdev, struct ttm_tt *tt,
 		   const struct ttm_operation_ctx *ctx)
 {
-	int ret = ttm_pool_restore_and_alloc(&bdev->pool, tt, ctx);
+	return ttm_tt_restore_node(bdev, tt, ctx, NUMA_NO_NODE);
+}
+EXPORT_SYMBOL(ttm_tt_restore);
+
+/**
+ * ttm_tt_restore_node - Restore a backed-up tt, placing pages on a given node
+ * @bdev: The TTM device.
+ * @tt: The struct ttm_tt to restore.
+ * @ctx: The operation context.
+ * @nid: NUMA node for the restored pages, or NUMA_NO_NODE for the pool default.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int ttm_tt_restore_node(struct ttm_device *bdev, struct ttm_tt *tt,
+			const struct ttm_operation_ctx *ctx, int nid)
+{
+	int ret = ttm_pool_restore_and_alloc_node(&bdev->pool, tt, ctx, nid);
 
 	if (ret)
 		return ret;
@@ -307,7 +323,7 @@ int ttm_tt_restore(struct ttm_device *bdev, struct ttm_tt *tt,
 
 	return 0;
 }
-EXPORT_SYMBOL(ttm_tt_restore);
+EXPORT_SYMBOL(ttm_tt_restore_node);
 
 /**
  * ttm_tt_swapout - swap out tt object
diff --git a/include/drm/ttm/ttm_tt.h b/include/drm/ttm/ttm_tt.h
index 406437ad674b..7a75e22a7f70 100644
--- a/include/drm/ttm/ttm_tt.h
+++ b/include/drm/ttm/ttm_tt.h
@@ -297,6 +297,8 @@ long ttm_tt_backup(struct ttm_device *bdev, struct ttm_tt *tt,
 
 int ttm_tt_restore(struct ttm_device *bdev, struct ttm_tt *tt,
 		   const struct ttm_operation_ctx *ctx);
+int ttm_tt_restore_node(struct ttm_device *bdev, struct ttm_tt *tt,
+			const struct ttm_operation_ctx *ctx, int nid);
 
 int ttm_tt_setup_backup(struct ttm_tt *tt);
 
-- 
2.43.0

