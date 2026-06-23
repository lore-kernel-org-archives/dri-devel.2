Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F7A2CDB47F
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 22:27:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50D4310E197;
	Tue, 23 Jun 2026 22:27:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Ojywt3dh";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2A8D10E392;
 Tue, 23 Jun 2026 22:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782253660; x=1813789660;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=V/L5Bt1xtjxFnd/1n7BcDp/gxuXKK0EtQUQ9MlJ8EKI=;
 b=Ojywt3dhD/e61WRW8j2RGL0UOxIrivfxX19QBrixraf4FcuGeWPwj9wK
 /XyrmG+lOxWgksYkDyYV5n5phcX97VKdThs4K8gEhZgfjAveFEUeqc8Lf
 Qgng8cIljhQtREGyds/xN1d/ca5JadCffryyHxrZ4YUFN8Lz98pN28AQU
 I3qasRBmoGybmpb44DXwC2OWKNLilPsWwLT7aS8fO82y3AT98iFEQiSD6
 sXJsn/dYjdsjeNWuEJEcTJ6JgsXrTrT8eq9tGvrZiPG8h9Xo9ybCYMPgd
 7NPOoQ2dTcKcL0P4RzmNB4vlhqi9tzarEsB80jG4ZtrvkmaRcaMjp+SwS A==;
X-CSE-ConnectionGUID: 8uAksapKR4GidiirUTBgDw==
X-CSE-MsgGUID: avysto4aRHqe/tlcUo7DCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="83048823"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="83048823"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 15:27:39 -0700
X-CSE-ConnectionGUID: VSz+cuAcStOvFOzWsLO/Iw==
X-CSE-MsgGUID: 2l2PqabfR6ea3C93yx18Lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="273335802"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 15:27:39 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [RFC PATCH 03/12] drm/ttm: Support defragmentation moves
Date: Tue, 23 Jun 2026 15:27:23 -0700
Message-Id: <20260623222732.360872-4-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260623222732.360872-1-matthew.brost@intel.com>
References: <20260623222732.360872-1-matthew.brost@intel.com>
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

Add infrastructure to let a driver re-back an already-resident BO with
fresh pages (e.g. at a more beneficial order) by reusing the normal move
machinery.

Add ctx->defrag, which makes ttm_bo_validate() skip the "current
resource already compatible" short-circuit so a move is forced even when
placement is unchanged. In ttm_bo_handle_move_mem(), when defragging a
populated BO, stash the old tt, create and populate a fresh one
(allocating new backing), and hand the old tt to the driver move
callback via bo->defrag_old_tt for copying. On success the old tt is
unpopulated and freed; if populate or the move fails, the freshly
allocated backing is discharged and the BO is restored to its original
tt and placement.

The old tt is handed off through bo->defrag_old_tt (reservation-lock
protected) rather than the operation context. The pointer describes BO
state for the duration of the move, so keeping it on the buffer object
is better layering and lets ttm_bo_move_accel_cleanup() pick it up.

Because a defrag move commonly fails (beneficial-order pages are often
unavailable) and then leaves the BO untouched on its original backing,
defer ttm_bo_unmap_virtual() for the defrag case until the new backing
has been populated and the move is about to commit. Ordinary moves still
unmap up front. This avoids needlessly zapping and refaulting every
userspace mapping on the common failure path where nothing moved.

Teach ttm_bo_move_accel_cleanup()'s ghost path about defrag: instead of
tearing the move's source tt down synchronously, hand bo->defrag_old_tt
to the ghost object so it is kept populated until the copy fence signals
and then unbound and destroyed asynchronously, while the BO keeps its
new tt. This lets a driver pipeline defrag teardown behind the GPU copy
rather than blocking on it.

This is driver-opt-in and a no-op unless ctx->defrag is set.

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
 drivers/gpu/drm/ttm/ttm_bo.c      | 83 ++++++++++++++++++++++++++++---
 drivers/gpu/drm/ttm/ttm_bo_util.c | 16 +++++-
 drivers/gpu/drm/ttm/ttm_pool.c    |  7 ++-
 include/drm/ttm/ttm_bo.h          | 17 +++++++
 4 files changed, 113 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index bcd76f6bb7f0..3bcdc553fd67 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -125,36 +125,93 @@ static int ttm_bo_handle_move_mem(struct ttm_buffer_object *bo,
 {
 	struct ttm_device *bdev = bo->bdev;
 	bool old_use_tt, new_use_tt;
+	bool defrag;
 	int ret;
 
 	old_use_tt = !bo->resource || ttm_manager_type(bdev, bo->resource->mem_type)->use_tt;
 	new_use_tt = ttm_manager_type(bdev, mem->mem_type)->use_tt;
 
-	ttm_bo_unmap_virtual(bo);
+	/*
+	 * Only the BO that is the actual defrag target (moved in place via
+	 * ttm_bo_validate(), evict == false) is being defragmented. The same
+	 * ctx->defrag is threaded into evictions triggered while allocating
+	 * that target's new backing (ttm_bo_evict_alloc()), so guard against
+	 * an unrelated victim BO (evict == true) being misclassified as a
+	 * defrag move and needlessly reallocating its backing.
+	 */
+	defrag = ctx->defrag && !evict && new_use_tt && bo->ttm &&
+		 ttm_tt_is_populated(bo->ttm);
+
+	/*
+	 * Tear down userspace mappings up front for ordinary moves. A defrag
+	 * move is likely to leave the BO in place (beneficial-order allocation
+	 * commonly fails), so defer the unmap until the new backing has been
+	 * populated and the move is about to commit. This avoids a needless
+	 * zap and refault of every userspace mapping on the common failure,
+	 * where the BO keeps its original, still-mapped backing.
+	 */
+	if (!defrag)
+		ttm_bo_unmap_virtual(bo);
 
 	/*
 	 * Create and bind a ttm if required.
 	 */
 
 	if (new_use_tt) {
+		struct ttm_tt *defrag_old_tt = NULL;
+
+		/*
+		 * For a defrag move, stash the current populated tt and force a
+		 * fresh one to be created and populated (at beneficial order).
+		 * The old tt is handed to the driver move callback to copy the
+		 * contents from, and freed once the move completes.
+		 */
+		if (defrag) {
+			defrag_old_tt = bo->ttm;
+			bo->ttm = NULL;
+		}
+
 		/* Zero init the new TTM structure if the old location should
 		 * have used one as well.
 		 */
-		ret = ttm_tt_create(bo, old_use_tt);
-		if (ret)
+		ret = ttm_tt_create(bo, old_use_tt && !defrag_old_tt);
+		if (ret) {
+			if (defrag_old_tt)
+				bo->ttm = defrag_old_tt;
 			goto out_err;
+		}
 
-		if (mem->mem_type != TTM_PL_SYSTEM) {
+		if (defrag_old_tt || mem->mem_type != TTM_PL_SYSTEM) {
 			ret = ttm_bo_populate(bo, ctx);
-			if (ret)
+			if (ret) {
+				/*
+				 * Discharge the freshly allocated backing and
+				 * leave the BO on its original tt/placement.
+				 */
+				if (defrag_old_tt) {
+					ttm_tt_destroy(bo->bdev, bo->ttm);
+					bo->ttm = defrag_old_tt;
+				}
 				goto out_err;
+			}
 		}
+
+		bo->defrag_old_tt = defrag_old_tt;
 	}
 
 	ret = dma_resv_reserve_fences(bo->base.resv, 1);
 	if (ret)
 		goto out_err;
 
+	/*
+	 * A defrag move deferred its virtual unmap until the new backing was
+	 * successfully populated; tear the userspace mappings down now, before
+	 * the move swaps in the new pages, so the next fault re-establishes
+	 * them against the new backing.
+	 */
+	if (defrag)
+		ttm_bo_unmap_virtual(bo);
+
 	ret = bdev->funcs->move(bo, evict, ctx, mem, hop);
 	if (ret) {
 		if (ret == -EMULTIHOP)
@@ -162,12 +219,24 @@ static int ttm_bo_handle_move_mem(struct ttm_buffer_object *bo,
 		goto out_err;
 	}
 
+	if (bo->defrag_old_tt) {
+		ttm_tt_unpopulate(bo->bdev, bo->defrag_old_tt);
+		ttm_tt_destroy(bo->bdev, bo->defrag_old_tt);
+		bo->defrag_old_tt = NULL;
+	}
+
 	ctx->bytes_moved += bo->base.size;
 	return 0;
 
 out_err:
-	if (!old_use_tt)
+	if (bo->defrag_old_tt) {
+		/* Failed defrag move: restore the original backing. */
+		ttm_bo_tt_destroy(bo);
+		bo->ttm = bo->defrag_old_tt;
+		bo->defrag_old_tt = NULL;
+	} else if (!old_use_tt) {
 		ttm_bo_tt_destroy(bo);
+	}
 
 	return ret;
 }
@@ -835,7 +904,7 @@ int ttm_bo_validate(struct ttm_buffer_object *bo,
 	force_space = false;
 	do {
 		/* Check whether we need to move buffer. */
-		if (bo->resource &&
+		if (bo->resource && !ctx->defrag &&
 		    ttm_resource_compatible(bo->resource, placement,
 					    force_space))
 			return 0;
diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
index 3e3c201a0222..771313162c8d 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_util.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
@@ -626,10 +626,22 @@ static int ttm_bo_move_to_ghost(struct ttm_buffer_object *bo,
 	 * bo to be unbound and destroyed.
 	 */
 
-	if (dst_use_tt)
+	if (bo->defrag_old_tt) {
+		/*
+		 * Defrag move: @bo already points at the freshly allocated,
+		 * beneficial-order tt that the move copied into. Hand the old
+		 * tt (the move's source) to the ghost so it is kept populated
+		 * until @fence signals and then unbound and destroyed, instead
+		 * of being torn down synchronously. @bo keeps its new tt.
+		 */
+		ghost_obj->ttm = bo->defrag_old_tt;
+		ghost_obj->defrag_old_tt = NULL;
+		bo->defrag_old_tt = NULL;
+	} else if (dst_use_tt) {
 		ghost_obj->ttm = NULL;
-	else
+	} else {
 		bo->ttm = NULL;
+	}
 
 	dma_resv_unlock(&ghost_obj->base._resv);
 	ttm_bo_put(ghost_obj);
diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index a1a74ccfcbf0..6e9a5481d876 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -831,8 +831,13 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 				 * pages. Record it so the driver can later try to
 				 * defragment the object back to beneficial order.
 				 */
-				if (beneficial_order && order == beneficial_order)
+				if (beneficial_order && order == beneficial_order) {
 					tt->beneficial_order_failed = true;
+					if (ctx->defrag) {
+						r = -ENOMEM;
+						goto error_free_all;
+					}
+				}
 				--order;
 				page_caching = tt->caching;
 				allow_pools = true;
diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
index f59c175622d4..bc9bbce8a7af 100644
--- a/include/drm/ttm/ttm_bo.h
+++ b/include/drm/ttm/ttm_bo.h
@@ -135,6 +135,16 @@ struct ttm_buffer_object {
 	 * reservation lock.
 	 */
 	struct sg_table *sg;
+
+	/**
+	 * @defrag_old_tt: Used internally during a defrag move to hand the BO's
+	 * previous, populated struct ttm_tt to the driver's move callback so
+	 * that it can copy the contents into the freshly allocated
+	 * beneficial-order backing. Set by TTM, consumed by the driver; the old
+	 * tt is freed (or restored on failure) by TTM once the move completes.
+	 * Protected by the reservation lock.
+	 */
+	struct ttm_tt *defrag_old_tt;
 };
 
 #define TTM_BO_MAP_IOMEM_MASK 0x80
@@ -193,6 +203,13 @@ struct ttm_operation_ctx {
 	 * recently failed and backoff from waiting CPU cycles.
 	 */
 	bool beneficial_reclaim_backoff;
+	/**
+	 * @defrag: Defragmentation pass. Attempt a move even when the bo's
+	 * current resource is already compatible with the requested placement,
+	 * so that the backing store can be reallocated at the pool's beneficial
+	 * order.
+	 */
+	bool defrag;
 	/**
 	 * @resv: Reservation object to be used together with
 	 * @allow_res_evict.
-- 
2.34.1

