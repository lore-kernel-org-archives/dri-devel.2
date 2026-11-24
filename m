Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756A8606A321
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 06:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=A1j3vKw5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D82010E770;
	Tue, 24 Nov 2026 06:17:10 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8A7A10E21F;
 Tue, 24 Nov 2026 06:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795501024; x=1827037024;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/zoaSk+xZZK0aQYXQi38lotONbPXwMuncUWusQb4kE0=;
 b=A1j3vKw5qzBq35ZaDkVYUeMmGDXYU0GfW3Qg4oppz/NmGlJo1aDOO8oM
 7+YtfnGHnXPtjAhAut8EYxqudA3Xv4Xfz5y7bAXl+C+Nq+HQUzzAWYp3X
 qkdjnkLM7JicSRBvKjfwJZtQCfY1UCeyjWqv/KttmpC/gXwCOIWBqGXVp
 jTQhy+2we762YzySSxP/eHrrdtAriRE3vKvbG0EoK8zaDRCZiynAH3wVy
 q/ERY1Xj/xwkgfcNVLcu5YHPyGMXj1ckorb2y4N7HcVpVWcJ9RkeAMPj4
 XQDoEvBfGMQV4WZmLKhRUjl6C3AXeYjHT0llrBZH6TXCWC95Fla/MLXUh Q==;
X-CSE-ConnectionGUID: GYkYbDY7Qb2egtmSrZXTEA==
X-CSE-MsgGUID: OhQUF9HvQ5SmsM6DLaSVDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4220055"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4220055"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 22:17:04 -0800
X-CSE-ConnectionGUID: yN6RJdRdTeat7JdPn7amTw==
X-CSE-MsgGUID: RYdJ5muNTwGop8KpsH81Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; d="scan'208";a="11264137"
Received: from hghimira.iind.intel.com ([10.190.239.34])
 by orviesa008.jf.intel.com with ESMTP; 23 Nov 2026 22:17:01 -0800
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
Subject: [RFC v2 05/11] drm/amdgpu: Use ttm_operation_ctx numa_info instead of
 per-partition pools
Date: Tue, 24 Nov 2026 11:51:29 +0530
Message-ID: <20261124062123.2431244-18-himal.prasad.ghimiray@intel.com>
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

On APUs with memory partitions amdgpu creates one TTM pool per
partition, only to get pages from the partition's NUMA node. With the
node now selectable per allocation through ttm_operation_ctx, drop the
extra pools and allocate from the device pool, setting numa_info to
TTM_NUMA_POLICY_PREFERRED with the partition's node on a local ctx copy.

The device pool keeps per-node page caches and per-node limits, so
pages are still cached and trimmed per node. No functional change
intended.

Signed-off-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 78 ++++++-------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h |  1 -
 2 files changed, 19 insertions(+), 60 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 0f86777250fc..fe10409e1d5b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -743,7 +743,7 @@ struct amdgpu_ttm_tt {
 	struct task_struct	*usertask;
 	uint32_t		userflags;
 	bool			bound;
-	int32_t			pool_id;
+	int			numa_node;
 };
 
 #define ttm_to_amdgpu_ttm_tt(ptr)	container_of(ptr, struct amdgpu_ttm_tt, ttm)
@@ -1211,10 +1211,13 @@ static struct ttm_tt *amdgpu_ttm_tt_create(struct ttm_buffer_object *bo,
 		return NULL;
 
 	gtt->gobj = &bo->base;
-	if (adev->gmc.mem_partitions && abo->xcp_id >= 0)
-		gtt->pool_id = KFD_XCP_MEM_ID(adev, abo->xcp_id);
-	else
-		gtt->pool_id = abo->xcp_id;
+	gtt->numa_node = NUMA_NO_NODE;
+	if (adev->gmc.is_app_apu && adev->gmc.num_mem_partitions) {
+		int mem_id = KFD_XCP_MEM_ID(adev, abo->xcp_id);
+
+		if (mem_id >= 0)
+			gtt->numa_node = adev->gmc.mem_partitions[mem_id].numa.node;
+	}
 
 	if (abo->flags & AMDGPU_GEM_CREATE_CPU_GTT_USWC)
 		caching = ttm_write_combined;
@@ -1241,7 +1244,9 @@ static int amdgpu_ttm_tt_populate(struct ttm_device *bdev,
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bdev);
 	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
-	struct ttm_pool *pool;
+	/* ctx is shared by every BO of the operation; set the node locally */
+	struct ttm_operation_ctx node_ctx = *ctx;
+	nodemask_t preferred;
 	pgoff_t i;
 	int ret;
 
@@ -1256,11 +1261,13 @@ static int amdgpu_ttm_tt_populate(struct ttm_device *bdev,
 	if (ttm->page_flags & TTM_TT_FLAG_EXTERNAL)
 		return 0;
 
-	if (adev->mman.ttm_pools && gtt->pool_id >= 0)
-		pool = &adev->mman.ttm_pools[gtt->pool_id];
-	else
-		pool = &adev->mman.bdev.pool;
-	ret = ttm_pool_alloc(pool, ttm, ctx);
+	if (gtt->numa_node != NUMA_NO_NODE) {
+		nodes_clear(preferred);
+		node_set(gtt->numa_node, preferred);
+		node_ctx.numa_info.policy = TTM_NUMA_POLICY_PREFERRED;
+		node_ctx.numa_info.nodes = &preferred;
+	}
+	ret = ttm_pool_alloc(&adev->mman.bdev.pool, ttm, &node_ctx);
 	if (ret)
 		return ret;
 
@@ -1281,7 +1288,6 @@ static void amdgpu_ttm_tt_unpopulate(struct ttm_device *bdev,
 {
 	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
 	struct amdgpu_device *adev;
-	struct ttm_pool *pool;
 	pgoff_t i;
 
 	amdgpu_ttm_backend_unbind(bdev, ttm);
@@ -1301,12 +1307,7 @@ static void amdgpu_ttm_tt_unpopulate(struct ttm_device *bdev,
 
 	adev = amdgpu_ttm_adev(bdev);
 
-	if (adev->mman.ttm_pools && gtt->pool_id >= 0)
-		pool = &adev->mman.ttm_pools[gtt->pool_id];
-	else
-		pool = &adev->mman.bdev.pool;
-
-	return ttm_pool_free(pool, ttm);
+	return ttm_pool_free(&adev->mman.bdev.pool, ttm);
 }
 
 /**
@@ -1935,40 +1936,6 @@ static void amdgpu_ttm_training_data_block_init(struct amdgpu_device *adev)
 			ctx->c2p_train_data_offset);
 }
 
-static int amdgpu_ttm_pools_init(struct amdgpu_device *adev)
-{
-	int i;
-
-	if (!adev->gmc.is_app_apu || !adev->gmc.num_mem_partitions)
-		return 0;
-
-	adev->mman.ttm_pools = kzalloc_objs(*adev->mman.ttm_pools,
-					    adev->gmc.num_mem_partitions);
-	if (!adev->mman.ttm_pools)
-		return -ENOMEM;
-
-	for (i = 0; i < adev->gmc.num_mem_partitions; i++) {
-		ttm_pool_init(&adev->mman.ttm_pools[i], adev->dev,
-			      adev->gmc.mem_partitions[i].numa.node,
-			      TTM_ALLOCATION_POOL_BENEFICIAL_ORDER(get_order(SZ_2M)));
-	}
-	return 0;
-}
-
-static void amdgpu_ttm_pools_fini(struct amdgpu_device *adev)
-{
-	int i;
-
-	if (!adev->gmc.is_app_apu || !adev->mman.ttm_pools)
-		return;
-
-	for (i = 0; i < adev->gmc.num_mem_partitions; i++)
-		ttm_pool_fini(&adev->mman.ttm_pools[i]);
-
-	kfree(adev->mman.ttm_pools);
-	adev->mman.ttm_pools = NULL;
-}
-
 /**
  * amdgpu_ttm_alloc_mmio_remap_bo - Allocate the singleton MMIO_REMAP BO
  * @adev: amdgpu device
@@ -2153,11 +2120,6 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 		return r;
 	}
 
-	r = amdgpu_ttm_pools_init(adev);
-	if (r) {
-		dev_err(adev->dev, "failed to init ttm pools(%d).\n", r);
-		return r;
-	}
 	adev->mman.initialized = true;
 
 	if (!adev->gmc.is_app_apu) {
@@ -2327,8 +2289,6 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 	if (!adev->mman.initialized)
 		return;
 
-	amdgpu_ttm_pools_fini(adev);
-
 	amdgpu_ttm_training_reserve_vram_fini(adev);
 	/* return the stolen vga memory back to VRAM */
 	if (!adev->gmc.is_app_apu) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index adb6cfae5052..8fc7fc86f19c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -83,7 +83,6 @@ struct amdgpu_vram_resv {
 
 struct amdgpu_mman {
 	struct ttm_device		bdev;
-	struct ttm_pool			*ttm_pools;
 	bool				initialized;
 	void __iomem			*aper_base_kaddr;
 
-- 
2.43.0

