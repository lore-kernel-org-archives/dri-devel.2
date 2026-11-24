Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71198606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 06:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lTJs0Nkg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 026E410E836;
	Tue, 24 Nov 2026 06:17:13 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E527910E5F9;
 Tue, 24 Nov 2026 06:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795501027; x=1827037027;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mcVjhEqQhKm+eYNVdPQe9OBXhlX9dqJ8Sjj7+luDrvA=;
 b=lTJs0NkgGJY55W7vntJLdmYmKvLXt/HOSuu24Oa5CJSjT1VPWWQEWOUf
 nR5sgtMUxKnkXueyxQUI8uC/Qg9JqkvQzMQHZcJ7x0NCYTgtlG7jx6XgN
 jPSE2V7PlVT7i+WcfNcUjVs1E0B05hbIZ4o3L8Ig9XgqkE/WMYrcqpBpl
 zCwOMeLwtq2+wz9rEGgYDv5k43R8iXncH3/gW3LxF8MsL0zPl4rUS+Huf
 u3tOyX4G6t3FgHQaFMO0+jlS7qVrtE2b4ziW5yr5YDyYZfSbzzxXPtXVB
 8GPsNdTTqbZ54rkHY6frPG8pwSt2/X0VzRHlLpmkQ78WnQA+Nzg/jSCB/ A==;
X-CSE-ConnectionGUID: Jgb75XhlR9ufpQPglHE0+Q==
X-CSE-MsgGUID: AuXs1VYrTky/q1LzxskMUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4220064"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4220064"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 22:17:07 -0800
X-CSE-ConnectionGUID: 2ohkL0eiRNSyZ+9cE82lGA==
X-CSE-MsgGUID: vs08pZb4TCyBQEjVMN0KpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; d="scan'208";a="11264147"
Received: from hghimira.iind.intel.com ([10.190.239.34])
 by orviesa008.jf.intel.com with ESMTP; 23 Nov 2026 22:17:04 -0800
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
Subject: [RFC v2 06/11] drm/ttm/pool: Drop the nid argument from
 ttm_pool_init()
Date: Tue, 24 Nov 2026 11:51:30 +0530
Message-ID: <20261124062123.2431244-19-himal.prasad.ghimiray@intel.com>
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

With the node selectable per allocation through ttm_operation_ctx and
amdgpu converted, no caller picks a node per pool anymore. Remove the
nid argument and derive the pool's default node from the device, as
ttm_device_init() already did, so there is a single way to choose a
node.

Signed-off-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
---
 drivers/gpu/drm/ttm/tests/ttm_pool_test.c | 10 +++++-----
 drivers/gpu/drm/ttm/ttm_device.c          |  9 ++-------
 drivers/gpu/drm/ttm/ttm_pool.c            |  9 +++++----
 include/drm/ttm/ttm_pool.h                |  4 ++--
 4 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/ttm/tests/ttm_pool_test.c b/drivers/gpu/drm/ttm/tests/ttm_pool_test.c
index be75c8abf388..5497672173a2 100644
--- a/drivers/gpu/drm/ttm/tests/ttm_pool_test.c
+++ b/drivers/gpu/drm/ttm/tests/ttm_pool_test.c
@@ -87,7 +87,7 @@ static struct ttm_pool *ttm_pool_pre_populated(struct kunit *test,
 	pool = kunit_kzalloc(test, sizeof(*pool), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, pool);
 
-	ttm_pool_init(pool, devs->dev, NUMA_NO_NODE, TTM_ALLOCATION_POOL_USE_DMA_ALLOC);
+	ttm_pool_init(pool, devs->dev, TTM_ALLOCATION_POOL_USE_DMA_ALLOC);
 
 	err = ttm_pool_alloc(pool, tt, &simple_ctx);
 	KUNIT_ASSERT_EQ(test, err, 0);
@@ -151,7 +151,7 @@ static void ttm_pool_alloc_basic(struct kunit *test)
 	pool = kunit_kzalloc(test, sizeof(*pool), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, pool);
 
-	ttm_pool_init(pool, devs->dev, NUMA_NO_NODE, params->alloc_flags);
+	ttm_pool_init(pool, devs->dev, params->alloc_flags);
 
 	KUNIT_ASSERT_PTR_EQ(test, pool->dev, devs->dev);
 	KUNIT_ASSERT_EQ(test, pool->nid, NUMA_NO_NODE);
@@ -218,7 +218,7 @@ static void ttm_pool_alloc_basic_dma_addr(struct kunit *test)
 	pool = kunit_kzalloc(test, sizeof(*pool), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, pool);
 
-	ttm_pool_init(pool, devs->dev, NUMA_NO_NODE, TTM_ALLOCATION_POOL_USE_DMA_ALLOC);
+	ttm_pool_init(pool, devs->dev, TTM_ALLOCATION_POOL_USE_DMA_ALLOC);
 
 	err = ttm_pool_alloc(pool, tt, &simple_ctx);
 	KUNIT_ASSERT_EQ(test, err, 0);
@@ -348,7 +348,7 @@ static void ttm_pool_free_dma_alloc(struct kunit *test)
 	pool = kunit_kzalloc(test, sizeof(*pool), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, pool);
 
-	ttm_pool_init(pool, devs->dev, NUMA_NO_NODE, TTM_ALLOCATION_POOL_USE_DMA_ALLOC);
+	ttm_pool_init(pool, devs->dev, TTM_ALLOCATION_POOL_USE_DMA_ALLOC);
 	ttm_pool_alloc(pool, tt, &simple_ctx);
 
 	pt = &pool->caching[caching].orders[order];
@@ -378,7 +378,7 @@ static void ttm_pool_free_no_dma_alloc(struct kunit *test)
 	pool = kunit_kzalloc(test, sizeof(*pool), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, pool);
 
-	ttm_pool_init(pool, devs->dev, NUMA_NO_NODE, 0);
+	ttm_pool_init(pool, devs->dev, 0);
 	ttm_pool_alloc(pool, tt, &simple_ctx);
 
 	ttm_pool_free(pool, tt);
diff --git a/drivers/gpu/drm/ttm/ttm_device.c b/drivers/gpu/drm/ttm/ttm_device.c
index d3bfb9a696a7..4ba07254f5fd 100644
--- a/drivers/gpu/drm/ttm/ttm_device.c
+++ b/drivers/gpu/drm/ttm/ttm_device.c
@@ -208,7 +208,7 @@ int ttm_device_init(struct ttm_device *bdev, const struct ttm_device_funcs *func
 		    unsigned int alloc_flags)
 {
 	struct ttm_global *glob = &ttm_glob;
-	int ret, nid;
+	int ret;
 
 	if (WARN_ON(vma_manager == NULL))
 		return -EINVAL;
@@ -229,12 +229,7 @@ int ttm_device_init(struct ttm_device *bdev, const struct ttm_device_funcs *func
 
 	ttm_sys_man_init(bdev);
 
-	if (dev)
-		nid = dev_to_node(dev);
-	else
-		nid = NUMA_NO_NODE;
-
-	ttm_pool_init(&bdev->pool, dev, nid, alloc_flags);
+	ttm_pool_init(&bdev->pool, dev, alloc_flags);
 
 	bdev->vma_manager = vma_manager;
 	spin_lock_init(&bdev->lru_lock);
diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 4ab37af0f1ba..4262e4b6fb64 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -1414,20 +1414,21 @@ long ttm_pool_backup(struct ttm_pool *pool, struct ttm_tt *tt,
  *
  * @pool: the pool to initialize
  * @dev: device for DMA allocations and mappings
- * @nid: NUMA node to use for allocations
  * @alloc_flags: TTM_ALLOCATION_POOL_* flags
  *
- * Initialize the pool and its pool types.
+ * Initialize the pool and its pool types. The pool allocates on @dev's NUMA
+ * node unless the caller selects one per allocation through
+ * &ttm_operation_ctx.numa_info.
  */
 void ttm_pool_init(struct ttm_pool *pool, struct device *dev,
-		   int nid, unsigned int alloc_flags)
+		   unsigned int alloc_flags)
 {
 	unsigned int i, j;
 
 	WARN_ON(!dev && ttm_pool_uses_dma_alloc(pool));
 
 	pool->dev = dev;
-	pool->nid = nid;
+	pool->nid = dev ? dev_to_node(dev) : NUMA_NO_NODE;
 	pool->alloc_flags = alloc_flags;
 
 	for (i = 0; i < TTM_NUM_CACHING_TYPES; ++i) {
diff --git a/include/drm/ttm/ttm_pool.h b/include/drm/ttm/ttm_pool.h
index 26ee592e1994..863e8f7af948 100644
--- a/include/drm/ttm/ttm_pool.h
+++ b/include/drm/ttm/ttm_pool.h
@@ -62,7 +62,7 @@ struct ttm_pool_type {
  * struct ttm_pool - Pool for all caching and orders
  *
  * @dev: the device we allocate pages for
- * @nid: which numa node to use
+ * @nid: default NUMA node, derived from @dev
  * @alloc_flags: TTM_ALLOCATION_POOL_* flags
  * @caching: pools for each caching/order
  */
@@ -82,7 +82,7 @@ int ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 void ttm_pool_free(struct ttm_pool *pool, struct ttm_tt *tt);
 
 void ttm_pool_init(struct ttm_pool *pool, struct device *dev,
-		   int nid, unsigned int alloc_flags);
+		   unsigned int alloc_flags);
 void ttm_pool_fini(struct ttm_pool *pool);
 
 int ttm_pool_debugfs(struct ttm_pool *pool, struct seq_file *m);
-- 
2.43.0

