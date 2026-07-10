Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D069AC43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:55:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 117F610F99E;
	Fri, 10 Jul 2026 21:54:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="CuTOoGZh";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABC9010F98C;
 Fri, 10 Jul 2026 21:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783720496; x=1815256496;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=V6LdYmrjK8Dp751Pmwfoljt9LqgFCd/zuL2biM+omUU=;
 b=CuTOoGZhTWxa7C6m1R3uR6DaFwB5qhveJojM88Ktbj42V8JIsaF1y1BQ
 NrMzJLOqnsavF+JybY4JLD0ZLBN9YN6vooHxVu0jM8SWRUDCgmJ0VTuOX
 ydtTWrHT6AZIGEJJjQjIXIbiOKMo3MiETZcf5bqvxKoGlcJfd8sGwQNCK
 wvUa3BT9wzfqYZt9vqDnZB76OysAQB9UCn1lIYi+xCGVGGl9eybybQ7gU
 QtfZ0RG+FyaC+kQ6CHXizJkSVMIjxk09hFZC/jQTCIPJSUY4B4Q56zBhk
 IVmr7qmlufe6LZHpSYlAQC/DY/4oGIf+EiqCFoW8tiKx5saddA4iTiI1M w==;
X-CSE-ConnectionGUID: 981PwtPOR+aJ47Qxban/Vg==
X-CSE-MsgGUID: w7RLkY0gRIabZEWccjy5SA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="83543222"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="83543222"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 14:54:55 -0700
X-CSE-ConnectionGUID: dO6nl+1nTfmcasrwBPIMag==
X-CSE-MsgGUID: yYYevovrR6a9rzSvOCnYqQ==
X-ExtLoop1: 1
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 14:54:55 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: Carlos Santa <carlos.santa@intel.com>, Ryan Neph <ryanneph@google.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Subject: [PATCH v2 25/33] drm/xe: Preallocate system BO backing outside the
 dma-resv lock
Date: Fri, 10 Jul 2026 14:54:34 -0700
Message-Id: <20260710215442.2444235-26-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260710215442.2444235-1-matthew.brost@intel.com>
References: <20260710215442.2444235-1-matthew.brost@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

xe_gem_create_ioctl() populates a buffer object's backing store inside
xe_validation_guard(), i.e. under the dma-resv lock.  For a system-memory
buffer that means the whole page allocation - potentially stalling in
reclaim or compaction - happens in the critical section, holding the
reservation and blocking anything that contends on it.

Use the TTM full-preallocation mechanism to move that work out of the
lock.  For a system-only, non-deferred user BO, allocate the entire tt
backing up front, before entering the validation guard, and hand the bag
down to the populate so it merely installs the pages:

  - Thread an optional struct ttm_pool_prealloc through xe_bo_create_user()
    -> __xe_bo_create_locked() -> xe_bo_init_locked(), which stashes it in
    ttm_operation_ctx::prealloc.  All other callers pass NULL.

  - In xe_gem_create_ioctl(), for XE_BO_FLAG_SYSTEM BOs that are not VRAM,
    stolen or deferred-backing, call ttm_pool_prealloc_fill_full() before
    the guard and ttm_pool_prealloc_fini() after it.  The bag size covers
    both the data pages and the appended CCS backup pages, matching the tt
    layout in xe_ttm_tt_create(), and the caching mirrors the same path.

The fill is best-effort: on a short fill (or if it is skipped) the pool
allocates the remainder in-line as before, so this is purely an
optimisation with no behavioural change to the created BO.  fini() only
releases the unconsumed tail, so it is safe on every success, error and
OOM-retry path (consumed pages are owned by the tt).

The fill requests reclaim backoff for higher-order chunks
(@beneficial_reclaim_backoff): Xe runs a background defragmenter that
upgrades suboptimal pages to beneficial order in place, so there is no
need to stall this user context reclaiming/compacting for contiguity.

To size the preallocation before the xe_bo exists, factor the CCS-pages
decision in xe_bo_needs_ccs_pages() into a parameterised helper,
__xe_bo_needs_ccs_pages(), and query it directly from the ioctl.

Cc: Carlos Santa <carlos.santa@intel.com>
Cc: Ryan Neph <ryanneph@google.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Assisted-by: GitHub_Copilot:claude-opus-4.8
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/xe/tests/xe_bo.c      |   8 +-
 drivers/gpu/drm/xe/tests/xe_dma_buf.c |   2 +-
 drivers/gpu/drm/xe/tests/xe_migrate.c |   6 +-
 drivers/gpu/drm/xe/xe_bo.c            | 120 ++++++++++++++++++++------
 drivers/gpu/drm/xe/xe_bo.h            |   8 +-
 drivers/gpu/drm/xe/xe_dma_buf.c       |   2 +-
 6 files changed, 109 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/xe/tests/xe_bo.c b/drivers/gpu/drm/xe/tests/xe_bo.c
index 49c95ed67d7e..78781317b420 100644
--- a/drivers/gpu/drm/xe/tests/xe_bo.c
+++ b/drivers/gpu/drm/xe/tests/xe_bo.c
@@ -141,7 +141,7 @@ static void ccs_test_run_tile(struct xe_device *xe, struct xe_tile *tile,
 		kunit_info(test, "Testing system memory\n");
 
 	bo = xe_bo_create_user(xe, NULL, SZ_1M, DRM_XE_GEM_CPU_CACHING_WC,
-			       bo_flags, exec);
+			       bo_flags, NULL, exec);
 	if (IS_ERR(bo)) {
 		KUNIT_FAIL(test, "Failed to create bo.\n");
 		return;
@@ -220,7 +220,7 @@ static int evict_test_run_tile(struct xe_device *xe, struct xe_tile *tile, struc
 		xe_vm_lock(vm, false);
 		bo = xe_bo_create_user(xe, vm, 0x10000,
 				       DRM_XE_GEM_CPU_CACHING_WC,
-				       bo_flags, exec);
+				       bo_flags, NULL, exec);
 		xe_vm_unlock(vm);
 		if (IS_ERR(bo)) {
 			KUNIT_FAIL(test, "bo create err=%pe\n", bo);
@@ -229,7 +229,7 @@ static int evict_test_run_tile(struct xe_device *xe, struct xe_tile *tile, struc
 
 		external = xe_bo_create_user(xe, NULL, 0x10000,
 					     DRM_XE_GEM_CPU_CACHING_WC,
-					     bo_flags, NULL);
+					     bo_flags, NULL, NULL);
 		if (IS_ERR(external)) {
 			KUNIT_FAIL(test, "external bo create err=%pe\n", external);
 			goto cleanup_bo;
@@ -494,7 +494,7 @@ static int shrink_test_run_device(struct xe_device *xe)
 		/* We can create bos using WC caching here. But it is slower. */
 		bo = xe_bo_create_user(xe, NULL, XE_BO_SHRINK_SIZE,
 				       DRM_XE_GEM_CPU_CACHING_WB,
-				       XE_BO_FLAG_SYSTEM, NULL);
+				       XE_BO_FLAG_SYSTEM, NULL, NULL);
 		if (IS_ERR(bo)) {
 			if (bo != ERR_PTR(-ENOMEM) && bo != ERR_PTR(-ENOSPC) &&
 			    bo != ERR_PTR(-EINTR) && bo != ERR_PTR(-ERESTARTSYS))
diff --git a/drivers/gpu/drm/xe/tests/xe_dma_buf.c b/drivers/gpu/drm/xe/tests/xe_dma_buf.c
index 0be8440b3976..e4fdc247c0c7 100644
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
diff --git a/drivers/gpu/drm/xe/tests/xe_migrate.c b/drivers/gpu/drm/xe/tests/xe_migrate.c
index 3c1be809be82..41de648b2c86 100644
--- a/drivers/gpu/drm/xe/tests/xe_migrate.c
+++ b/drivers/gpu/drm/xe/tests/xe_migrate.c
@@ -647,7 +647,7 @@ static void validate_ccs_test_run_tile(struct xe_device *xe, struct xe_tile *til
 				   DRM_XE_GEM_CPU_CACHING_WC,
 				   XE_BO_FLAG_SYSTEM |
 				   XE_BO_FLAG_NEEDS_CPU_ACCESS |
-				   XE_BO_FLAG_PINNED, NULL);
+				   XE_BO_FLAG_PINNED, NULL, NULL);
 
 	if (IS_ERR(sys_bo)) {
 		KUNIT_FAIL(test, "xe_bo_create() failed with err=%ld\n",
@@ -673,7 +673,7 @@ static void validate_ccs_test_run_tile(struct xe_device *xe, struct xe_tile *til
 	ccs_bo = xe_bo_create_user(xe, NULL, SZ_4M,
 				   DRM_XE_GEM_CPU_CACHING_WC,
 				   bo_flags | XE_BO_FLAG_NEEDS_CPU_ACCESS |
-				   XE_BO_FLAG_PINNED, NULL);
+				   XE_BO_FLAG_PINNED, NULL, NULL);
 
 	if (IS_ERR(ccs_bo)) {
 		KUNIT_FAIL(test, "xe_bo_create() failed with err=%ld\n",
@@ -698,7 +698,7 @@ static void validate_ccs_test_run_tile(struct xe_device *xe, struct xe_tile *til
 	vram_bo = xe_bo_create_user(xe, NULL, SZ_4M,
 				    DRM_XE_GEM_CPU_CACHING_WC,
 				    bo_flags | XE_BO_FLAG_NEEDS_CPU_ACCESS |
-				    XE_BO_FLAG_PINNED, NULL);
+				    XE_BO_FLAG_PINNED, NULL, NULL);
 	if (IS_ERR(vram_bo)) {
 		KUNIT_FAIL(test, "xe_bo_create() failed with err=%ld\n",
 			   PTR_ERR(vram_bo));
diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index a01004265349..d9226a3995fe 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -1924,7 +1924,7 @@ int xe_bo_notifier_prepare_pinned(struct xe_bo *bo)
 		backup = xe_bo_init_locked(xe, NULL, NULL, bo->ttm.base.resv, NULL, xe_bo_size(bo),
 					   DRM_XE_GEM_CPU_CACHING_WB, ttm_bo_type_kernel,
 					   XE_BO_FLAG_SYSTEM | XE_BO_FLAG_NEEDS_CPU_ACCESS |
-					   XE_BO_FLAG_PINNED, &exec);
+					   XE_BO_FLAG_PINNED, NULL, &exec);
 		if (IS_ERR(backup)) {
 			drm_exec_retry_on_contention(&exec);
 			ret = PTR_ERR(backup);
@@ -2065,7 +2065,7 @@ int xe_bo_evict_pinned(struct xe_bo *bo)
 						   xe_bo_size(bo),
 						   DRM_XE_GEM_CPU_CACHING_WB, ttm_bo_type_kernel,
 						   XE_BO_FLAG_SYSTEM | XE_BO_FLAG_NEEDS_CPU_ACCESS |
-						   XE_BO_FLAG_PINNED, &exec);
+						   XE_BO_FLAG_PINNED, NULL, &exec);
 			if (IS_ERR(backup)) {
 				drm_exec_retry_on_contention(&exec);
 				ret = PTR_ERR(backup);
@@ -2860,6 +2860,8 @@ void xe_bo_free(struct xe_bo *bo)
  * @cpu_caching: The cpu caching used for system memory backing store.
  * @type: The TTM buffer object type.
  * @flags: XE_BO_FLAG_ flags.
+ * @prealloc: Optional pages preallocated outside the dma-resv lock to back the
+ * bo (see ttm_operation_ctx::prealloc), or NULL.
  * @exec: The drm_exec transaction to use for exhaustive eviction.
  *
  * Initialize or create an xe buffer object. On failure, any allocated buffer
@@ -2871,12 +2873,14 @@ struct xe_bo *xe_bo_init_locked(struct xe_device *xe, struct xe_bo *bo,
 				struct xe_tile *tile, struct dma_resv *resv,
 				struct ttm_lru_bulk_move *bulk, size_t size,
 				u16 cpu_caching, enum ttm_bo_type type,
-				u32 flags, struct drm_exec *exec)
+				u32 flags, struct ttm_pool_prealloc *prealloc,
+				struct drm_exec *exec)
 {
 	struct ttm_operation_ctx ctx = {
 		.interruptible = true,
 		.no_wait_gpu = false,
 		.gfp_retry_mayfail = true,
+		.prealloc = prealloc,
 	};
 	struct ttm_placement *placement;
 	uint32_t alignment;
@@ -3053,7 +3057,8 @@ __xe_bo_create_locked(struct xe_device *xe,
 		      struct xe_tile *tile, struct xe_vm *vm,
 		      size_t size, u64 start, u64 end,
 		      u16 cpu_caching, enum ttm_bo_type type, u32 flags,
-		      u64 alignment, struct drm_exec *exec)
+		      u64 alignment, struct ttm_pool_prealloc *prealloc,
+		      struct drm_exec *exec)
 {
 	struct xe_bo *bo = NULL;
 	int err;
@@ -3078,7 +3083,7 @@ __xe_bo_create_locked(struct xe_device *xe,
 			       vm && !xe_vm_in_fault_mode(vm) &&
 			       flags & XE_BO_FLAG_USER ?
 			       &vm->lru_bulk_move : NULL, size,
-			       cpu_caching, type, flags, exec);
+			       cpu_caching, type, flags, prealloc, exec);
 	if (IS_ERR(bo))
 		return bo;
 
@@ -3153,7 +3158,7 @@ struct xe_bo *xe_bo_create_locked(struct xe_device *xe, struct xe_tile *tile,
 				  struct drm_exec *exec)
 {
 	return __xe_bo_create_locked(xe, tile, vm, size, 0, ~0ULL, 0, type,
-				     flags, 0, exec);
+				     flags, 0, NULL, exec);
 }
 
 static struct xe_bo *xe_bo_create_novm(struct xe_device *xe, struct xe_tile *tile,
@@ -3169,7 +3174,7 @@ static struct xe_bo *xe_bo_create_novm(struct xe_device *xe, struct xe_tile *til
 	xe_validation_guard(&ctx, &xe->val, &exec, (struct xe_val_flags) {.interruptible = intr},
 			    ret) {
 		bo = __xe_bo_create_locked(xe, tile, NULL, size, 0, ~0ULL,
-					   cpu_caching, type, flags, alignment, &exec);
+					   cpu_caching, type, flags, alignment, NULL, &exec);
 		drm_exec_retry_on_contention(&exec);
 		if (IS_ERR(bo)) {
 			ret = PTR_ERR(bo);
@@ -3189,6 +3194,9 @@ static struct xe_bo *xe_bo_create_novm(struct xe_device *xe, struct xe_tile *til
  * @size: The storage size to use for the bo.
  * @cpu_caching: The caching mode to be used for system backing store.
  * @flags: XE_BO_FLAG_ flags.
+ * @prealloc: Optional pages preallocated outside the dma-resv lock to back the
+ * bo (see ttm_operation_ctx::prealloc), or NULL. Only consumed on the locked
+ * (@vm or @exec) path.
  * @exec: The drm_exec transaction to use for exhaustive eviction, or NULL
  * if such a transaction should be initiated by the call.
  *
@@ -3199,7 +3207,8 @@ static struct xe_bo *xe_bo_create_novm(struct xe_device *xe, struct xe_tile *til
 struct xe_bo *xe_bo_create_user(struct xe_device *xe,
 				struct xe_vm *vm, size_t size,
 				u16 cpu_caching,
-				u32 flags, struct drm_exec *exec)
+				u32 flags, struct ttm_pool_prealloc *prealloc,
+				struct drm_exec *exec)
 {
 	struct xe_bo *bo;
 
@@ -3209,7 +3218,7 @@ struct xe_bo *xe_bo_create_user(struct xe_device *xe,
 		xe_assert(xe, exec);
 		bo = __xe_bo_create_locked(xe, NULL, vm, size, 0, ~0ULL,
 					   cpu_caching, ttm_bo_type_device,
-					   flags, 0, exec);
+					   flags, 0, prealloc, exec);
 		if (!IS_ERR(bo))
 			xe_bo_unlock_vm_held(bo);
 	} else {
@@ -3248,7 +3257,7 @@ struct xe_bo *xe_bo_create_pin_range_novm(struct xe_device *xe, struct xe_tile *
 
 	xe_validation_guard(&ctx, &xe->val, &exec, (struct xe_val_flags) {}, err) {
 		bo = __xe_bo_create_locked(xe, tile, NULL, size, start, end,
-					   0, type, flags, 0, &exec);
+					   0, type, flags, 0, NULL, &exec);
 		if (IS_ERR(bo)) {
 			drm_exec_retry_on_contention(&exec);
 			err = PTR_ERR(bo);
@@ -3287,7 +3296,7 @@ static struct xe_bo *xe_bo_create_pin_map_at_aligned(struct xe_device *xe,
 
 	bo = __xe_bo_create_locked(xe, tile, vm, size, start, end, 0, type,
 				   flags | XE_BO_FLAG_NEEDS_CPU_ACCESS | XE_BO_FLAG_PINNED,
-				   alignment, exec);
+				   alignment, NULL, exec);
 	if (IS_ERR(bo))
 		return bo;
 
@@ -3902,6 +3911,10 @@ static int gem_create_user_extensions(struct xe_device *xe, struct xe_bo *bo,
 	return 0;
 }
 
+static bool __xe_bo_needs_ccs_pages(struct xe_device *xe,
+				    enum ttm_bo_type type, u32 flags,
+				    u16 cpu_caching);
+
 int xe_gem_create_ioctl(struct drm_device *dev, void *data,
 			struct drm_file *file)
 {
@@ -3912,6 +3925,8 @@ int xe_gem_create_ioctl(struct drm_device *dev, void *data,
 	struct drm_exec exec;
 	struct xe_vm *vm = NULL;
 	struct xe_bo *bo;
+	struct ttm_pool_prealloc prealloc = {};
+	bool have_prealloc = false;
 	unsigned int bo_flags;
 	u32 handle;
 	int err;
@@ -3994,6 +4009,45 @@ int xe_gem_create_ioctl(struct drm_device *dev, void *data,
 			return -ENOENT;
 	}
 
+	/*
+	 * For system-only BOs, preallocate the whole backing outside the
+	 * dma-resv lock so the populate under the validation guard does not
+	 * stall in reclaim/compaction. The caching mirrors the system-BO path
+	 * in xe_ttm_tt_create(); the pool falls back to in-line allocation for
+	 * any shortfall, so a failed fill is harmless.
+	 */
+	if ((bo_flags & XE_BO_FLAG_SYSTEM) &&
+	    !(bo_flags & (XE_BO_FLAG_DEFER_BACKING | XE_BO_FLAG_VRAM_MASK |
+			  XE_BO_FLAG_STOLEN))) {
+		enum ttm_caching caching = ttm_cached;
+		unsigned long num_pages = args->size >> PAGE_SHIFT;
+
+		if (!IS_DGFX(xe) &&
+		    args->cpu_caching == DRM_XE_GEM_CPU_CACHING_WC)
+			caching = ttm_write_combined;
+
+		/*
+		 * Cover the CCS backup pages appended to the tt (see
+		 * xe_ttm_tt_create()) so the whole tt is preallocated.
+		 */
+		if (__xe_bo_needs_ccs_pages(xe, ttm_bo_type_device, bo_flags,
+					    args->cpu_caching))
+			num_pages += DIV_ROUND_UP(xe_device_ccs_bytes(xe,
+								      args->size),
+						  PAGE_SIZE);
+
+		/*
+		 * Back off aggressive reclaim/compaction for higher-order
+		 * chunks here: Xe runs a background defragmenter that upgrades
+		 * suboptimal pages to beneficial order in place later, so there
+		 * is no need to stall this user context reclaiming for
+		 * contiguity.
+		 */
+		ttm_pool_prealloc_fill_full(&xe->ttm.pool, caching, &prealloc,
+					    num_pages, true);
+		have_prealloc = true;
+	}
+
 	err = 0;
 	xe_validation_guard(&ctx, &xe->val, &exec, (struct xe_val_flags) {.interruptible = true},
 			    err) {
@@ -4004,7 +4058,8 @@ int xe_gem_create_ioctl(struct drm_device *dev, void *data,
 				break;
 		}
 		bo = xe_bo_create_user(xe, vm, args->size, args->cpu_caching,
-				       bo_flags, &exec);
+				       bo_flags, have_prealloc ? &prealloc : NULL,
+				       &exec);
 		drm_exec_retry_on_contention(&exec);
 		if (IS_ERR(bo)) {
 			err = PTR_ERR(bo);
@@ -4012,6 +4067,8 @@ int xe_gem_create_ioctl(struct drm_device *dev, void *data,
 			break;
 		}
 	}
+	if (have_prealloc)
+		ttm_pool_prealloc_fini(&xe->ttm.pool, &prealloc);
 	if (err)
 		goto out_vm;
 
@@ -4307,21 +4364,19 @@ int xe_bo_evict(struct xe_bo *bo, struct drm_exec *exec)
 	return 0;
 }
 
-/**
- * xe_bo_needs_ccs_pages - Whether a bo needs to back up CCS pages when
- * placed in system memory.
- * @bo: The xe_bo
- *
- * Return: true if extra pages need to be allocated, false otherwise.
+/*
+ * Whether a bo with the given attributes needs to back up CCS pages when placed
+ * in system memory. Split out so callers can query before the xe_bo exists (see
+ * xe_gem_create_ioctl() preallocation).
  */
-bool xe_bo_needs_ccs_pages(struct xe_bo *bo)
+static bool __xe_bo_needs_ccs_pages(struct xe_device *xe,
+				    enum ttm_bo_type type, u32 flags,
+				    u16 cpu_caching)
 {
-	struct xe_device *xe = xe_bo_device(bo);
-
 	if (GRAPHICS_VER(xe) >= 20 && IS_DGFX(xe))
 		return false;
 
-	if (!xe_device_has_flat_ccs(xe) || bo->ttm.type != ttm_bo_type_device)
+	if (!xe_device_has_flat_ccs(xe) || type != ttm_bo_type_device)
 		return false;
 
 	/* On discrete GPUs, if the GPU can access this buffer from
@@ -4329,24 +4384,37 @@ bool xe_bo_needs_ccs_pages(struct xe_bo *bo)
 	 * can't be used since there's no CCS storage associated with
 	 * non-VRAM addresses.
 	 */
-	if (IS_DGFX(xe) && (bo->flags & XE_BO_FLAG_SYSTEM))
+	if (IS_DGFX(xe) && (flags & XE_BO_FLAG_SYSTEM))
 		return false;
 
 	/* Check if userspace explicitly requested no compression */
-	if (bo->flags & XE_BO_FLAG_NO_COMPRESSION)
+	if (flags & XE_BO_FLAG_NO_COMPRESSION)
 		return false;
 
 	/*
 	 * For WB (Write-Back) CPU caching mode, check if the device
 	 * supports WB compression with coherency.
 	 */
-	if (bo->cpu_caching == DRM_XE_GEM_CPU_CACHING_WB &&
+	if (cpu_caching == DRM_XE_GEM_CPU_CACHING_WB &&
 	    xe->pat.idx[XE_CACHE_WB_COMPRESSION] == XE_PAT_INVALID_IDX)
 		return false;
 
 	return true;
 }
 
+/**
+ * xe_bo_needs_ccs_pages - Whether a bo needs to back up CCS pages when
+ * placed in system memory.
+ * @bo: The xe_bo
+ *
+ * Return: true if extra pages need to be allocated, false otherwise.
+ */
+bool xe_bo_needs_ccs_pages(struct xe_bo *bo)
+{
+	return __xe_bo_needs_ccs_pages(xe_bo_device(bo), bo->ttm.type,
+				       bo->flags, bo->cpu_caching);
+}
+
 /**
  * __xe_bo_release_dummy() - Dummy kref release function
  * @kref: The embedded struct kref.
@@ -4453,7 +4521,7 @@ int xe_bo_dumb_create(struct drm_file *file_priv,
 			       DRM_XE_GEM_CPU_CACHING_WC,
 			       XE_BO_FLAG_VRAM_IF_DGFX(xe_device_get_root_tile(xe)) |
 			       XE_BO_FLAG_FORCE_WC |
-			       XE_BO_FLAG_NEEDS_CPU_ACCESS, NULL);
+			       XE_BO_FLAG_NEEDS_CPU_ACCESS, NULL, NULL);
 	if (IS_ERR(bo))
 		return PTR_ERR(bo);
 
diff --git a/drivers/gpu/drm/xe/xe_bo.h b/drivers/gpu/drm/xe/xe_bo.h
index 38d50f8122cb..18fcccd082b7 100644
--- a/drivers/gpu/drm/xe/xe_bo.h
+++ b/drivers/gpu/drm/xe/xe_bo.h
@@ -111,6 +111,7 @@ enum xe_madv_purgeable_state {
 
 struct sg_table;
 struct ttm_tt;
+struct ttm_pool_prealloc;
 
 struct xe_bo *xe_bo_alloc(void);
 void xe_bo_free(struct xe_bo *bo);
@@ -119,13 +120,16 @@ struct xe_bo *xe_bo_init_locked(struct xe_device *xe, struct xe_bo *bo,
 				struct xe_tile *tile, struct dma_resv *resv,
 				struct ttm_lru_bulk_move *bulk, size_t size,
 				u16 cpu_caching, enum ttm_bo_type type,
-				u32 flags, struct drm_exec *exec);
+				u32 flags, struct ttm_pool_prealloc *prealloc,
+				struct drm_exec *exec);
 struct xe_bo *xe_bo_create_locked(struct xe_device *xe, struct xe_tile *tile,
 				  struct xe_vm *vm, size_t size,
 				  enum ttm_bo_type type, u32 flags,
 				  struct drm_exec *exec);
 struct xe_bo *xe_bo_create_user(struct xe_device *xe, struct xe_vm *vm, size_t size,
-				u16 cpu_caching, u32 flags, struct drm_exec *exec);
+				u16 cpu_caching, u32 flags,
+				struct ttm_pool_prealloc *prealloc,
+				struct drm_exec *exec);
 struct xe_bo *xe_bo_create_pin_map(struct xe_device *xe, struct xe_tile *tile,
 				   struct xe_vm *vm, size_t size,
 				   enum ttm_bo_type type, u32 flags,
diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c b/drivers/gpu/drm/xe/xe_dma_buf.c
index 8a920e58245c..ec947d86a1ce 100644
--- a/drivers/gpu/drm/xe/xe_dma_buf.c
+++ b/drivers/gpu/drm/xe/xe_dma_buf.c
@@ -302,7 +302,7 @@ xe_dma_buf_create_obj(struct drm_device *dev, struct dma_buf *dma_buf)
 
 		bo = xe_bo_init_locked(xe, NULL, NULL, resv, NULL, dma_buf->size,
 				       0, /* Will require 1way or 2way for vm_bind */
-				       ttm_bo_type_sg, XE_BO_FLAG_SYSTEM, &exec);
+				       ttm_bo_type_sg, XE_BO_FLAG_SYSTEM, NULL, &exec);
 		drm_exec_retry_on_contention(&exec);
 		if (IS_ERR(bo)) {
 			ret = PTR_ERR(bo);
-- 
2.34.1

