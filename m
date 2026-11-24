Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2649E606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 06:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bPrpQjHH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D61110EA96;
	Tue, 24 Nov 2026 06:17:22 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 878AF10E110;
 Tue, 24 Nov 2026 06:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795501034; x=1827037034;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=411/hOWuyMmsU9pl7BrNJyEiVvdO8rPpIPlvVJqMtkg=;
 b=bPrpQjHHMjv0boJN1p+MGkiNWN1baNYv0R0H7ZJUq8FqMVvFnV3La+GB
 iAJ1IRO775POY6QaooCgDjv/aETy1Y9oaBo9lIvApeI0LAhgeTQcXVCEF
 m52R80Y4I3tgSdVt65o1F0zUvkXHd/pbCm1wrIyjRxQU0dlIZiIlG2yCk
 GqTwrqQC3p87wGkC1NOjJNvHQiQeammYR3xF0rAzA8TeTZ4w406zXLEjS
 nKOEtna2i+ECMq1xkjRDZXBqKgu41r4q6z0ObYiErVS2HeXIBw+TGAfP2
 VVIDMeDfuCkwvFRiDE1OFDdedOJcpnAXLIuAz3ZzNzB3yIJDPWeoO0gem A==;
X-CSE-ConnectionGUID: +rlTQbw+SDOrw8aZDlfjhQ==
X-CSE-MsgGUID: oKMLytHYQeW8+N8celx0Og==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4220089"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4220089"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 22:17:14 -0800
X-CSE-ConnectionGUID: 58Q9eR1HSC2bjLSUDuP0QQ==
X-CSE-MsgGUID: 4qElOGR2Td6xfpmlF4gGFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; d="scan'208";a="11264168"
Received: from hghimira.iind.intel.com ([10.190.239.34])
 by orviesa008.jf.intel.com with ESMTP; 23 Nov 2026 22:17:10 -0800
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
Subject: [RFC v2 08/11] drm/xe/bo: Carry a per-BO host NUMA mempolicy
Date: Tue, 24 Nov 2026 11:51:32 +0530
Message-ID: <20261124062123.2431244-21-himal.prasad.ghimiray@intel.com>
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

Store a host NUMA memory policy in the BO and apply it when the TT
populates its backing pages. Populate can run from another task, such
as eviction or shrinker restore, so the BO owns a copy of the policy
and the TT holds a const pointer to it. The copy is freed with the BO.

xe_bo_init_locked(), __xe_bo_create_locked() and xe_bo_create_novm()
take the policy as an argument, and xe_bo_create_user() takes it too.
The GEM_CREATE ioctl and the other callers pass NULL for now, so there
is no functional change. The ioctl starts using the policy in the next
commit.

Signed-off-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
---
 drivers/gpu/drm/xe/tests/xe_bo.c      | 12 ++---
 drivers/gpu/drm/xe/tests/xe_dma_buf.c |  4 +-
 drivers/gpu/drm/xe/tests/xe_migrate.c |  8 ++--
 drivers/gpu/drm/xe/xe_bo.c            | 69 ++++++++++++++++++++-------
 drivers/gpu/drm/xe/xe_bo.h            |  5 +-
 drivers/gpu/drm/xe/xe_bo_types.h      | 24 ++++++++++
 drivers/gpu/drm/xe/xe_dma_buf.c       |  3 +-
 7 files changed, 94 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/xe/tests/xe_bo.c b/drivers/gpu/drm/xe/tests/xe_bo.c
index 6a17e13d58cf..0bc7d4572549 100644
--- a/drivers/gpu/drm/xe/tests/xe_bo.c
+++ b/drivers/gpu/drm/xe/tests/xe_bo.c
@@ -89,7 +89,7 @@ static void run_only_leaf(struct kunit *test,
 
 	bo = xe_bo_create_user(xe, NULL, li->alloc_size,
 			       DRM_XE_GEM_CPU_CACHING_WC,
-			       XE_BO_FLAG_VRAM0, NULL);
+			       XE_BO_FLAG_VRAM0, NULL, NULL);
 	if (IS_ERR(bo)) {
 		page_size_alloc_restore(xe, &saved);
 		if (PTR_ERR(bo) == -ENOSPC) {
@@ -183,7 +183,7 @@ static void xe_bo_page_size_alloc_mixed_bos(struct kunit *test)
 		 */
 		bo = xe_bo_create_user(xe, NULL, SZ_1G,
 				       DRM_XE_GEM_CPU_CACHING_WC,
-				       XE_BO_FLAG_VRAM0, NULL);
+				       XE_BO_FLAG_VRAM0, NULL, NULL);
 		if (IS_ERR(bo)) {
 			int err = PTR_ERR(bo);
 
@@ -366,7 +366,7 @@ static void ccs_test_run_tile(struct xe_device *xe, struct xe_tile *tile,
 		kunit_info(test, "Testing system memory\n");
 
 	bo = xe_bo_create_user(xe, NULL, SZ_1M, DRM_XE_GEM_CPU_CACHING_WC,
-			       bo_flags, exec);
+			       bo_flags, NULL, exec);
 	if (IS_ERR(bo)) {
 		KUNIT_FAIL(test, "Failed to create bo.\n");
 		return;
@@ -445,7 +445,7 @@ static int evict_test_run_tile(struct xe_device *xe, struct xe_tile *tile, struc
 		xe_vm_lock(vm, false);
 		bo = xe_bo_create_user(xe, vm, 0x10000,
 				       DRM_XE_GEM_CPU_CACHING_WC,
-				       bo_flags, exec);
+				       bo_flags, NULL, exec);
 		xe_vm_unlock(vm);
 		if (IS_ERR(bo)) {
 			KUNIT_FAIL(test, "bo create err=%pe\n", bo);
@@ -454,7 +454,7 @@ static int evict_test_run_tile(struct xe_device *xe, struct xe_tile *tile, struc
 
 		external = xe_bo_create_user(xe, NULL, 0x10000,
 					     DRM_XE_GEM_CPU_CACHING_WC,
-					     bo_flags, NULL);
+					     bo_flags, NULL, NULL);
 		if (IS_ERR(external)) {
 			KUNIT_FAIL(test, "external bo create err=%pe\n", external);
 			goto cleanup_bo;
@@ -719,7 +719,7 @@ static int shrink_test_run_device(struct xe_device *xe)
 		/* We can create bos using WC caching here. But it is slower. */
 		bo = xe_bo_create_user(xe, NULL, XE_BO_SHRINK_SIZE,
 				       DRM_XE_GEM_CPU_CACHING_WB,
-				       XE_BO_FLAG_SYSTEM, NULL);
+				       XE_BO_FLAG_SYSTEM, NULL, NULL);
 		if (IS_ERR(bo)) {
 			if (bo != ERR_PTR(-ENOMEM) && bo != ERR_PTR(-ENOSPC) &&
 			    bo != ERR_PTR(-EINTR) && bo != ERR_PTR(-ERESTARTSYS))
diff --git a/drivers/gpu/drm/xe/tests/xe_dma_buf.c b/drivers/gpu/drm/xe/tests/xe_dma_buf.c
index 792376e965f1..dae03a4f6af1 100644
--- a/drivers/gpu/drm/xe/tests/xe_dma_buf.c
+++ b/drivers/gpu/drm/xe/tests/xe_dma_buf.c
@@ -127,7 +127,7 @@ static void xe_test_dmabuf_import_same_driver(struct xe_device *xe)
 
 	kunit_info(test, "running %s\n", __func__);
 	bo = xe_bo_create_user(xe, NULL, size, DRM_XE_GEM_CPU_CACHING_WC,
-			       params->mem_mask, NULL);
+			       params->mem_mask, NULL, NULL);
 	if (IS_ERR(bo)) {
 		KUNIT_FAIL(test, "xe_bo_create() failed with err=%ld\n",
 			   PTR_ERR(bo));
@@ -215,7 +215,7 @@ static void xe_test_dmabuf_move_notify_no_resource(struct xe_device *xe)
 
 	kunit_info(test, "running %s\n", __func__);
 	bo = xe_bo_create_user(xe, NULL, PAGE_SIZE, DRM_XE_GEM_CPU_CACHING_WC,
-			       params->mem_mask, NULL);
+			       params->mem_mask, NULL, NULL);
 	if (IS_ERR(bo)) {
 		KUNIT_FAIL(test, "xe_bo_create() failed with err=%ld\n",
 			   PTR_ERR(bo));
diff --git a/drivers/gpu/drm/xe/tests/xe_migrate.c b/drivers/gpu/drm/xe/tests/xe_migrate.c
index 56c49d8507d7..4fb3f512d502 100644
--- a/drivers/gpu/drm/xe/tests/xe_migrate.c
+++ b/drivers/gpu/drm/xe/tests/xe_migrate.c
@@ -649,7 +649,7 @@ static void validate_ccs_test_run_tile(struct xe_device *xe, struct xe_tile *til
 				   DRM_XE_GEM_CPU_CACHING_WC,
 				   XE_BO_FLAG_SYSTEM |
 				   XE_BO_FLAG_NEEDS_CPU_ACCESS |
-				   XE_BO_FLAG_PINNED, NULL);
+				   XE_BO_FLAG_PINNED, NULL, NULL);
 
 	if (IS_ERR(sys_bo)) {
 		KUNIT_FAIL(test, "xe_bo_create() failed with err=%ld\n",
@@ -675,7 +675,7 @@ static void validate_ccs_test_run_tile(struct xe_device *xe, struct xe_tile *til
 	ccs_bo = xe_bo_create_user(xe, NULL, SZ_4M,
 				   DRM_XE_GEM_CPU_CACHING_WC,
 				   bo_flags | XE_BO_FLAG_NEEDS_CPU_ACCESS |
-				   XE_BO_FLAG_PINNED, NULL);
+				   XE_BO_FLAG_PINNED, NULL, NULL);
 
 	if (IS_ERR(ccs_bo)) {
 		KUNIT_FAIL(test, "xe_bo_create() failed with err=%ld\n",
@@ -700,7 +700,7 @@ static void validate_ccs_test_run_tile(struct xe_device *xe, struct xe_tile *til
 	vram_bo = xe_bo_create_user(xe, NULL, SZ_4M,
 				    DRM_XE_GEM_CPU_CACHING_WC,
 				    bo_flags | XE_BO_FLAG_NEEDS_CPU_ACCESS |
-				    XE_BO_FLAG_PINNED, NULL);
+				    XE_BO_FLAG_PINNED, NULL, NULL);
 	if (IS_ERR(vram_bo)) {
 		KUNIT_FAIL(test, "xe_bo_create() failed with err=%ld\n",
 			   PTR_ERR(vram_bo));
@@ -979,7 +979,7 @@ static void access_memory_test_run_tile(struct xe_device *xe,
 
 	bo = xe_bo_create_user(xe, NULL, ACCESS_MEM_BO_SIZE,
 			       DRM_XE_GEM_CPU_CACHING_WC,
-			       bo_flags | XE_BO_FLAG_NEEDS_CPU_ACCESS, NULL);
+			       bo_flags | XE_BO_FLAG_NEEDS_CPU_ACCESS, NULL, NULL);
 	if (IS_ERR(bo)) {
 		KUNIT_FAIL(test, "Failed to create bo: %pe\n", bo);
 		goto free_buf;
diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 353ac1e9a9d6..29fbcc1cbbed 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -396,6 +396,11 @@ struct xe_ttm_tt {
 	struct sg_table *sg;
 	/** @purgeable: Whether the content of the pages of @ttm is purgeable. */
 	bool purgeable;
+	/**
+	 * @mempolicy: Host NUMA policy for backing pages, owned by the BO and
+	 * valid for the lifetime of the tt. NULL if no policy was requested.
+	 */
+	const struct xe_host_mempolicy *mempolicy;
 };
 
 static int xe_tt_map_sg(struct xe_device *xe, struct ttm_tt *tt)
@@ -597,6 +602,7 @@ static struct ttm_tt *xe_ttm_tt_create(struct ttm_buffer_object *ttm_bo,
 		return NULL;
 
 	tt = &xe_tt->ttm;
+	xe_tt->mempolicy = bo->mempolicy;
 
 	extra_pages = 0;
 	if (xe_bo_needs_ccs_pages(bo))
@@ -664,6 +670,8 @@ static int xe_ttm_tt_populate(struct ttm_device *ttm_dev, struct ttm_tt *tt,
 			      struct ttm_operation_ctx *ctx)
 {
 	struct xe_ttm_tt *xe_tt = container_of(tt, struct xe_ttm_tt, ttm);
+	/* ctx is shared by every BO of the operation; set the node locally */
+	struct ttm_operation_ctx node_ctx = *ctx;
 	int err;
 
 	/*
@@ -674,11 +682,16 @@ static int xe_ttm_tt_populate(struct ttm_device *ttm_dev, struct ttm_tt *tt,
 	    !(tt->page_flags & TTM_TT_FLAG_EXTERNAL_MAPPABLE))
 		return 0;
 
+	if (xe_tt->mempolicy) {
+		node_ctx.numa_info.policy = xe_tt->mempolicy->mode;
+		node_ctx.numa_info.nodes = &xe_tt->mempolicy->nodes;
+	}
+
 	if (ttm_tt_is_backed_up(tt) && !xe_tt->purgeable) {
-		err = ttm_tt_restore(ttm_dev, tt, ctx);
+		err = ttm_tt_restore(ttm_dev, tt, &node_ctx);
 	} else {
 		ttm_tt_clear_backed_up(tt);
-		err = ttm_pool_alloc(&ttm_dev->pool, tt, ctx);
+		err = ttm_pool_alloc(&ttm_dev->pool, tt, &node_ctx);
 	}
 	if (err)
 		return err;
@@ -1536,7 +1549,7 @@ int xe_bo_notifier_prepare_pinned(struct xe_bo *bo)
 		backup = xe_bo_init_locked(xe, NULL, NULL, bo->ttm.base.resv, NULL, xe_bo_size(bo),
 					   DRM_XE_GEM_CPU_CACHING_WB, ttm_bo_type_kernel,
 					   XE_BO_FLAG_SYSTEM | XE_BO_FLAG_NEEDS_CPU_ACCESS |
-					   XE_BO_FLAG_PINNED, NULL, &exec);
+					   XE_BO_FLAG_PINNED, NULL, NULL, &exec);
 		if (IS_ERR(backup)) {
 			drm_exec_retry_on_contention(&exec);
 			ret = PTR_ERR(backup);
@@ -1678,7 +1691,8 @@ int xe_bo_evict_pinned(struct xe_bo *bo)
 						   xe_bo_size(bo),
 						   DRM_XE_GEM_CPU_CACHING_WB, ttm_bo_type_kernel,
 						   XE_BO_FLAG_SYSTEM | XE_BO_FLAG_NEEDS_CPU_ACCESS |
-						   XE_BO_FLAG_PINNED, NULL, &exec);
+						   XE_BO_FLAG_PINNED, NULL, NULL,
+						   &exec);
 			if (IS_ERR(backup)) {
 				drm_exec_retry_on_contention(&exec);
 				ret = PTR_ERR(backup);
@@ -2040,6 +2054,7 @@ static void xe_ttm_bo_destroy(struct ttm_buffer_object *ttm_bo)
 		list_del(&bo->vram_userfault_link);
 	mutex_unlock(&xe->mem_access.vram_userfault.lock);
 
+	kfree(bo->mempolicy);
 	kfree(bo);
 }
 
@@ -2447,6 +2462,8 @@ struct xe_bo *xe_bo_alloc(void)
  */
 void xe_bo_free(struct xe_bo *bo)
 {
+	if (bo)
+		kfree(bo->mempolicy);
 	kfree(bo);
 }
 
@@ -2466,6 +2483,7 @@ void xe_bo_free(struct xe_bo *bo)
  * @flags: XE_BO_FLAG_ flags.
  * @dma_buf: The dma-buf to reference for the BO lifetime (imported BOs),
  * or NULL.
+ * @mpol: Host NUMA memory policy to copy into the BO, or NULL for none.
  * @exec: The drm_exec transaction to use for exhaustive eviction.
  *
  * Initialize or create an xe buffer object. On failure, any allocated buffer
@@ -2478,6 +2496,7 @@ struct xe_bo *xe_bo_init_locked(struct xe_device *xe, struct xe_bo *bo,
 				struct ttm_lru_bulk_move *bulk, size_t size,
 				u16 cpu_caching, enum ttm_bo_type type,
 				u32 flags, struct dma_buf *dma_buf,
+				const struct xe_host_mempolicy *mpol,
 				struct drm_exec *exec)
 {
 	struct ttm_operation_ctx ctx = {
@@ -2544,6 +2563,13 @@ struct xe_bo *xe_bo_init_locked(struct xe_device *xe, struct xe_bo *bo,
 	bo->tile = tile;
 	bo->flags = flags;
 	bo->cpu_caching = cpu_caching;
+	if (mpol) {
+		bo->mempolicy = kmemdup(mpol, sizeof(*mpol), GFP_KERNEL);
+		if (!bo->mempolicy) {
+			xe_bo_free(bo);
+			return ERR_PTR(-ENOMEM);
+		}
+	}
 	bo->ttm.base.funcs = &xe_gem_object_funcs;
 	bo->ttm.priority = XE_BO_PRIORITY_NORMAL;
 	INIT_LIST_HEAD(&bo->pinned_link);
@@ -2678,7 +2704,9 @@ __xe_bo_create_locked(struct xe_device *xe,
 		      struct xe_tile *tile, struct xe_vm *vm,
 		      size_t size, u64 start, u64 end,
 		      u16 cpu_caching, enum ttm_bo_type type, u32 flags,
-		      u64 alignment, struct drm_exec *exec)
+		      u64 alignment,
+		      const struct xe_host_mempolicy *mpol,
+		      struct drm_exec *exec)
 {
 	struct xe_bo *bo = NULL;
 	int err;
@@ -2703,7 +2731,7 @@ __xe_bo_create_locked(struct xe_device *xe,
 			       vm && !xe_vm_in_fault_mode(vm) &&
 			       flags & XE_BO_FLAG_USER ?
 			       &vm->lru_bulk_move : NULL, size,
-			       cpu_caching, type, flags, NULL, exec);
+			       cpu_caching, type, flags, NULL, mpol, exec);
 	if (IS_ERR(bo))
 		return bo;
 
@@ -2778,13 +2806,14 @@ struct xe_bo *xe_bo_create_locked(struct xe_device *xe, struct xe_tile *tile,
 				  struct drm_exec *exec)
 {
 	return __xe_bo_create_locked(xe, tile, vm, size, 0, ~0ULL, 0, type,
-				     flags, 0, exec);
+				     flags, 0, NULL, exec);
 }
 
 static struct xe_bo *xe_bo_create_novm(struct xe_device *xe, struct xe_tile *tile,
 				       size_t size, u16 cpu_caching,
 				       enum ttm_bo_type type, u32 flags,
-				       u64 alignment, bool intr)
+				       u64 alignment,
+				       const struct xe_host_mempolicy *mpol, bool intr)
 {
 	struct xe_validation_ctx ctx;
 	struct drm_exec exec;
@@ -2794,7 +2823,8 @@ static struct xe_bo *xe_bo_create_novm(struct xe_device *xe, struct xe_tile *til
 	xe_validation_guard(&ctx, &xe->val, &exec, (struct xe_val_flags) {.interruptible = intr},
 			    ret) {
 		bo = __xe_bo_create_locked(xe, tile, NULL, size, 0, ~0ULL,
-					   cpu_caching, type, flags, alignment, &exec);
+					   cpu_caching, type, flags, alignment,
+					   mpol, &exec);
 		drm_exec_retry_on_contention(&exec);
 		if (IS_ERR(bo)) {
 			ret = PTR_ERR(bo);
@@ -2953,17 +2983,21 @@ static void xe_bo_debug_mixed_mode_cur_index_advance(struct xe_device *xe,
  * @size: The storage size to use for the bo.
  * @cpu_caching: The caching mode to be used for system backing store.
  * @flags: XE_BO_FLAG_ flags.
+ * @mpol: The host NUMA memory policy to copy into the bo, or NULL.
  * @exec: The drm_exec transaction to use for exhaustive eviction, or NULL
  * if such a transaction should be initiated by the call.
  *
- * Create a bo on behalf of user-space.
+ * Create a bo on behalf of user-space, with backing pages placed according
+ * to @mpol.
  *
  * Return: The buffer object on success. Negative error pointer on failure.
  */
 struct xe_bo *xe_bo_create_user(struct xe_device *xe,
 				struct xe_vm *vm, size_t size,
 				u16 cpu_caching,
-				u32 flags, struct drm_exec *exec)
+				u32 flags,
+				const struct xe_host_mempolicy *mpol,
+				struct drm_exec *exec)
 {
 	struct xe_bo *bo;
 	int err = 0;
@@ -2980,12 +3014,13 @@ struct xe_bo *xe_bo_create_user(struct xe_device *xe,
 		xe_assert(xe, exec);
 		bo = __xe_bo_create_locked(xe, NULL, vm, size, 0, ~0ULL,
 					   cpu_caching, ttm_bo_type_device,
-					   flags, 0, exec);
+					   flags, 0, mpol, exec);
 		if (!IS_ERR(bo))
 			xe_bo_unlock_vm_held(bo);
 	} else {
 		bo = xe_bo_create_novm(xe, NULL, size, cpu_caching,
-				       ttm_bo_type_device, flags, 0, true);
+				       ttm_bo_type_device, flags, 0,
+				       mpol, true);
 	}
 
 	return bo;
@@ -3019,7 +3054,7 @@ struct xe_bo *xe_bo_create_pin_range_novm(struct xe_device *xe, struct xe_tile *
 
 	xe_validation_guard(&ctx, &xe->val, &exec, (struct xe_val_flags) {}, err) {
 		bo = __xe_bo_create_locked(xe, tile, NULL, size, start, end,
-					   0, type, flags, 0, &exec);
+					   0, type, flags, 0, NULL, &exec);
 		if (IS_ERR(bo)) {
 			drm_exec_retry_on_contention(&exec);
 			err = PTR_ERR(bo);
@@ -3058,7 +3093,7 @@ static struct xe_bo *xe_bo_create_pin_map_at_aligned(struct xe_device *xe,
 
 	bo = __xe_bo_create_locked(xe, tile, vm, size, start, end, 0, type,
 				   flags | XE_BO_FLAG_NEEDS_CPU_ACCESS | XE_BO_FLAG_PINNED,
-				   alignment, exec);
+				   alignment, NULL, exec);
 	if (IS_ERR(bo))
 		return bo;
 
@@ -3757,7 +3792,7 @@ int xe_gem_create_ioctl(struct drm_device *dev, void *data,
 				break;
 		}
 		bo = xe_bo_create_user(xe, vm, args->size, args->cpu_caching,
-				       bo_flags, &exec);
+				       bo_flags, NULL, &exec);
 		drm_exec_retry_on_contention(&exec);
 		if (IS_ERR(bo)) {
 			err = PTR_ERR(bo);
@@ -4228,7 +4263,7 @@ int xe_bo_dumb_create(struct drm_file *file_priv,
 			       DRM_XE_GEM_CPU_CACHING_WC,
 			       XE_BO_FLAG_VRAM_IF_DGFX(xe_device_get_root_tile(xe)) |
 			       XE_BO_FLAG_FORCE_WC |
-			       XE_BO_FLAG_NEEDS_CPU_ACCESS, NULL);
+			       XE_BO_FLAG_NEEDS_CPU_ACCESS, NULL, NULL);
 	if (IS_ERR(bo))
 		return PTR_ERR(bo);
 
diff --git a/drivers/gpu/drm/xe/xe_bo.h b/drivers/gpu/drm/xe/xe_bo.h
index 13197e4e0358..4b2c17bb0f9c 100644
--- a/drivers/gpu/drm/xe/xe_bo.h
+++ b/drivers/gpu/drm/xe/xe_bo.h
@@ -123,13 +123,16 @@ struct xe_bo *xe_bo_init_locked(struct xe_device *xe, struct xe_bo *bo,
 				struct ttm_lru_bulk_move *bulk, size_t size,
 				u16 cpu_caching, enum ttm_bo_type type,
 				u32 flags, struct dma_buf *dma_buf,
+				const struct xe_host_mempolicy *mpol,
 				struct drm_exec *exec);
 struct xe_bo *xe_bo_create_locked(struct xe_device *xe, struct xe_tile *tile,
 				  struct xe_vm *vm, size_t size,
 				  enum ttm_bo_type type, u32 flags,
 				  struct drm_exec *exec);
 struct xe_bo *xe_bo_create_user(struct xe_device *xe, struct xe_vm *vm, size_t size,
-				u16 cpu_caching, u32 flags, struct drm_exec *exec);
+				u16 cpu_caching, u32 flags,
+				const struct xe_host_mempolicy *mpol,
+				struct drm_exec *exec);
 struct xe_bo *xe_bo_create_pin_map(struct xe_device *xe, struct xe_tile *tile,
 				   struct xe_vm *vm, size_t size,
 				   enum ttm_bo_type type, u32 flags,
diff --git a/drivers/gpu/drm/xe/xe_bo_types.h b/drivers/gpu/drm/xe/xe_bo_types.h
index 0265fb314c77..ace84235fb13 100644
--- a/drivers/gpu/drm/xe/xe_bo_types.h
+++ b/drivers/gpu/drm/xe/xe_bo_types.h
@@ -33,6 +33,23 @@ struct xe_exec_queue;
 #define	XE_BO_PRIORITY_LOW	0
 #define	XE_BO_PRIORITY_NORMAL	1
 
+/**
+ * struct xe_host_mempolicy - Host NUMA memory policy for system-memory pages
+ *
+ * Captured from the GEM_CREATE NUMA node property at creation time.
+ * Stored by value so that it stays valid when the pages are populated from a
+ * different task, for example during eviction or shrinker restore.
+ */
+struct xe_host_mempolicy {
+	/**
+	 * @mode: %TTM_NUMA_POLICY_PREFERRED, %TTM_NUMA_POLICY_BIND or
+	 * %TTM_NUMA_POLICY_INTERLEAVE
+	 */
+	enum ttm_numa_policy mode;
+	/** @nodes: Host NUMA nodes the policy applies to, non-empty */
+	nodemask_t nodes;
+};
+
 /**
  * struct xe_bo - Xe buffer object
  */
@@ -112,6 +129,13 @@ struct xe_bo {
 	 */
 	u16 cpu_caching;
 
+	/**
+	 * @mempolicy: Host NUMA memory policy for system-memory backing
+	 * pages, or NULL for the device-local default. Owned by the BO and
+	 * freed with it.
+	 */
+	struct xe_host_mempolicy *mempolicy;
+
 	/** @devmem_allocation: SVM device memory allocation */
 	struct drm_pagemap_devmem devmem_allocation;
 
diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c b/drivers/gpu/drm/xe/xe_dma_buf.c
index 90c9b90de552..f860221c7e53 100644
--- a/drivers/gpu/drm/xe/xe_dma_buf.c
+++ b/drivers/gpu/drm/xe/xe_dma_buf.c
@@ -345,7 +345,8 @@ xe_dma_buf_create_obj(struct drm_device *dev, struct dma_buf *dma_buf)
 
 		bo = xe_bo_init_locked(xe, NULL, NULL, resv, NULL, dma_buf->size,
 				       0, /* Will require 1way or 2way for vm_bind */
-				       ttm_bo_type_sg, XE_BO_FLAG_SYSTEM, dma_buf, &exec);
+				       ttm_bo_type_sg, XE_BO_FLAG_SYSTEM, dma_buf,
+				       NULL, &exec);
 		drm_exec_retry_on_contention(&exec);
 		if (IS_ERR(bo)) {
 			ret = PTR_ERR(bo);
-- 
2.43.0

