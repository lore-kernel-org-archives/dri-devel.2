Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D75C2C4450F
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:55:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7383B10F994;
	Fri, 10 Jul 2026 21:54:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="lM9tqUhW";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 419B010E5A8;
 Fri, 10 Jul 2026 21:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783720492; x=1815256492;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CWle6N3DLTBxZTj3ZoUbJZQgiNYYa9W80Lq9Lk7SqN8=;
 b=lM9tqUhWv3WaKsYkJ9QYVfsF89ld/a1cgT4hqJAzDPxs3MP5rp4KRZVI
 JOypxRLOfMafm/pZyTY6lPxhUl7kYTT3P5u+9HSy4X1KDzhbT97Iuh0Gz
 j1vI/ZF6/NbGxsuVcp1EaA0fx5x9Zf60XqqK5UYTY4/NW8wlSN0iqI3EA
 IBKOCadg9OZE29Qj80UzGY1WnODt4NFXNDH+XpBHJfwzcrY289JHcyvuz
 WDVhLkyRi7lotZqMaMxcD/7wqjtQ7g05sB1Mtg9T/E9Vzk8zdnEAIh0xF
 8f2hHX8/smNPQ3nD/2yqdwP4xuQRwk2+jJk/fkut5DSc8YJ7aXOqvrp+E g==;
X-CSE-ConnectionGUID: mZw1ZmryTCSegnztID7xrA==
X-CSE-MsgGUID: wao5CmEeSiSnhGgKBHdXFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="83543137"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="83543137"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 14:54:52 -0700
X-CSE-ConnectionGUID: /7iAQ+0zTdqsgKgLDTqRow==
X-CSE-MsgGUID: 2tfynRFuS4y4OPEiRpPLyA==
X-ExtLoop1: 1
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 14:54:51 -0700
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
Subject: [PATCH v2 15/33] drm/xe: Track BOs backed at a sub-optimal page order
Date: Fri, 10 Jul 2026 14:54:24 -0700
Message-Id: <20260710215442.2444235-16-matthew.brost@intel.com>
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

Add per-device tracking of BOs whose backing TT pages were allocated
below the pool's beneficial order, as reported by the
TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED tt page flag (read via
ttm_tt_is_beneficial_order_failed()). These BOs are future candidates for
a defragmentation pass that reallocates their pages at the beneficial
order.

Add a mem.defrag sub-struct (lock, list, atomic count) to struct
xe_device and a defrag_link to struct xe_bo, initialised at BO create
and device init. Membership is updated from xe_bo_move() via
xe_bo_defrag_update(): a BO is added when it is a populated, needed,
non-pinned ttm_bo_type_device object flagged
TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED, and removed otherwise. BOs are also
removed on pin, on purge, moved to dontneed, and at destroy.

Only ttm_bo_type_device BOs are tracked.

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
 drivers/gpu/drm/xe/xe_bo.c           | 115 +++++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_bo.h           |   1 +
 drivers/gpu/drm/xe/xe_bo_types.h     |   6 ++
 drivers/gpu/drm/xe/xe_device.c       |   2 +
 drivers/gpu/drm/xe/xe_device_types.h |  19 +++++
 5 files changed, 143 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index cca617cf34d1..d7b0536564ab 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -920,6 +920,9 @@ static void xe_bo_set_purgeable_shrinker(struct xe_bo *bo,
 	}
 }
 
+static void xe_bo_defrag_update(struct xe_bo *bo);
+static void xe_bo_defrag_remove(struct xe_bo *bo);
+
 /**
  * xe_bo_set_purgeable_state() - Set BO purgeable state with validation
  * @bo: Buffer object
@@ -948,6 +951,7 @@ void xe_bo_set_purgeable_state(struct xe_bo *bo,
 
 	bo->purgeable.state = new_state;
 	xe_bo_set_purgeable_shrinker(bo, new_state);
+	xe_bo_defrag_update(bo);
 }
 
 /**
@@ -997,9 +1001,100 @@ static int xe_ttm_bo_purge(struct ttm_buffer_object *ttm_bo, struct ttm_operatio
 	/* Commit the state transition only once invalidation was queued */
 	xe_bo_set_purgeable_state(bo, XE_MADV_PURGEABLE_PURGED);
 
+	/*
+	 * The backing store is gone, so the BO no longer needs defrag. Drop it
+	 * from the defrag list here so the count stays accurate even for purge
+	 * paths that don't pass through xe_bo_move() (e.g. swap_notify).
+	 */
+	xe_bo_defrag_remove(bo);
+
 	return 0;
 }
 
+/**
+ * xe_bo_defrag_init_early() - Initialize the device defrag BO tracking
+ * @xe: The xe device
+ *
+ * Initialize the list, lock and count used to track BOs whose backing TT
+ * pages were allocated at a sub-optimal order.
+ */
+void xe_bo_defrag_init_early(struct xe_device *xe)
+{
+	spin_lock_init(&xe->mem.defrag.lock);
+	INIT_LIST_HEAD(&xe->mem.defrag.list);
+	atomic_set(&xe->mem.defrag.count, 0);
+}
+
+static bool xe_bo_needs_defrag(struct xe_bo *bo)
+{
+	struct ttm_buffer_object *ttm_bo = &bo->ttm;
+	struct ttm_tt *tt = ttm_bo->ttm;
+
+	xe_bo_assert_held(bo);
+
+	return ttm_bo->type == ttm_bo_type_device && tt &&
+		!xe_bo_madv_is_dontneed(bo) &&
+		ttm_tt_is_populated(tt) &&
+		ttm_tt_is_beneficial_order_failed(tt) &&
+		ttm_bo->resource && ttm_bo->resource->mem_type == XE_PL_TT &&
+		!xe_bo_is_pinned(bo);
+}
+
+static void xe_bo_defrag_add(struct xe_bo *bo)
+{
+	struct xe_device *xe = xe_bo_device(bo);
+
+	xe_bo_assert_held(bo);
+	xe_assert(xe, xe_bo_needs_defrag(bo));
+
+	scoped_guard(spinlock, &xe->mem.defrag.lock) {
+		if (list_empty(&bo->defrag_link)) {
+			list_add_tail(&bo->defrag_link, &xe->mem.defrag.list);
+			atomic_inc(&xe->mem.defrag.count);
+		}
+	}
+}
+
+static void __xe_bo_defrag_remove(struct xe_bo *bo)
+{
+	struct xe_device *xe = xe_bo_device(bo);
+
+	guard(spinlock)(&xe->mem.defrag.lock);
+	if (!list_empty(&bo->defrag_link)) {
+		list_del_init(&bo->defrag_link);
+		atomic_dec(&xe->mem.defrag.count);
+	}
+}
+
+static void xe_bo_defrag_remove(struct xe_bo *bo)
+{
+	xe_bo_assert_held(bo);
+
+	if (list_empty(&bo->defrag_link))
+		return;
+
+	__xe_bo_defrag_remove(bo);
+}
+
+/**
+ * xe_bo_defrag_update() - Update defrag list membership for a BO
+ * @bo: The buffer object
+ *
+ * Add @bo to the device defrag list when it is a ttm_bo_type_device BO resident
+ * in XE_PL_TT with a populated TT whose pages were allocated at a sub-optimal
+ * order (ttm_tt_is_beneficial_order_failed()) and it isn't pinned. Otherwise
+ * ensure it is removed from the list.
+ */
+static void xe_bo_defrag_update(struct xe_bo *bo)
+{
+	xe_bo_assert_held(bo);
+
+	if (xe_bo_needs_defrag(bo))
+		xe_bo_defrag_add(bo);
+	else
+		xe_bo_defrag_remove(bo);
+}
+
 static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
 		      struct ttm_operation_ctx *ctx,
 		      struct ttm_resource *new_mem,
@@ -1225,6 +1320,8 @@ static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
 		xe_tt_unmap_sg(xe, ttm_bo->ttm);
 	}
 
+	xe_bo_defrag_update(bo);
+
 	return ret;
 }
 
@@ -1261,6 +1358,15 @@ static long xe_bo_shrink_purge(struct ttm_operation_ctx *ctx,
 	if (lret > 0) {
 		xe_ttm_tt_account_subtract(xe, bo->ttm);
 		update_global_total_pages(bo->bdev, -(long)tt->num_pages);
+
+		/*
+		 * The pages are gone, so a tracked BO no longer needs defrag.
+		 * This shrinker purge path frees pages without going through
+		 * xe_bo_move(), so drop any stale defrag list entry here. Ghost
+		 * bos are never tracked, so guard for real xe bos.
+		 */
+		if (xe_bo_is_xe_bo(bo))
+			xe_bo_defrag_remove(ttm_to_xe_bo(bo));
 	}
 
 	return lret;
@@ -1903,6 +2009,8 @@ static void xe_ttm_bo_destroy(struct ttm_buffer_object *ttm_bo)
 		list_del(&bo->vram_userfault_link);
 	mutex_unlock(&xe->mem_access.vram_userfault.lock);
 
+	__xe_bo_defrag_remove(bo);
+
 	kfree(bo);
 }
 
@@ -2408,6 +2516,7 @@ struct xe_bo *xe_bo_init_locked(struct xe_device *xe, struct xe_bo *bo,
 	bo->ttm.base.funcs = &xe_gem_object_funcs;
 	bo->ttm.priority = XE_BO_PRIORITY_NORMAL;
 	INIT_LIST_HEAD(&bo->pinned_link);
+	INIT_LIST_HEAD(&bo->defrag_link);
 #ifdef CONFIG_PROC_FS
 	INIT_LIST_HEAD(&bo->client_link);
 #endif
@@ -3014,6 +3123,8 @@ int xe_bo_pin_external(struct xe_bo *bo, bool in_place, struct drm_exec *exec)
 	if (bo->ttm.ttm && ttm_tt_is_populated(bo->ttm.ttm))
 		xe_ttm_tt_account_subtract(xe, bo->ttm.ttm);
 
+	xe_bo_defrag_remove(bo);
+
 	/*
 	 * FIXME: If we always use the reserve / unreserve functions for locking
 	 * we do not need this.
@@ -3072,6 +3183,8 @@ int xe_bo_pin(struct xe_bo *bo, struct drm_exec *exec)
 	if (bo->ttm.ttm && ttm_tt_is_populated(bo->ttm.ttm))
 		xe_ttm_tt_account_subtract(xe, bo->ttm.ttm);
 
+	xe_bo_defrag_remove(bo);
+
 	/*
 	 * FIXME: If we always use the reserve / unreserve functions for locking
 	 * we do not need this.
@@ -3107,6 +3220,7 @@ void xe_bo_unpin_external(struct xe_bo *bo)
 	ttm_bo_unpin(&bo->ttm);
 	if (bo->ttm.ttm && ttm_tt_is_populated(bo->ttm.ttm))
 		xe_ttm_tt_account_add(xe, bo->ttm.ttm);
+	xe_bo_defrag_update(bo);
 
 	/*
 	 * FIXME: If we always use the reserve / unreserve functions for locking
@@ -3139,6 +3253,7 @@ void xe_bo_unpin(struct xe_bo *bo)
 	ttm_bo_unpin(&bo->ttm);
 	if (bo->ttm.ttm && ttm_tt_is_populated(bo->ttm.ttm))
 		xe_ttm_tt_account_add(xe, bo->ttm.ttm);
+	xe_bo_defrag_update(bo);
 }
 
 /**
diff --git a/drivers/gpu/drm/xe/xe_bo.h b/drivers/gpu/drm/xe/xe_bo.h
index 6340317f7d2e..4186cb51af87 100644
--- a/drivers/gpu/drm/xe/xe_bo.h
+++ b/drivers/gpu/drm/xe/xe_bo.h
@@ -224,6 +224,7 @@ int xe_bo_pin_external(struct xe_bo *bo, bool in_place, struct drm_exec *exec);
 int xe_bo_pin(struct xe_bo *bo, struct drm_exec *exec);
 void xe_bo_unpin_external(struct xe_bo *bo);
 void xe_bo_unpin(struct xe_bo *bo);
+void xe_bo_defrag_init_early(struct xe_device *xe);
 int xe_bo_validate(struct xe_bo *bo, struct xe_vm *vm, bool allow_res_evict,
 		   struct drm_exec *exec);
 
diff --git a/drivers/gpu/drm/xe/xe_bo_types.h b/drivers/gpu/drm/xe/xe_bo_types.h
index fcc63ae3f455..9eea9ab380e5 100644
--- a/drivers/gpu/drm/xe/xe_bo_types.h
+++ b/drivers/gpu/drm/xe/xe_bo_types.h
@@ -54,6 +54,12 @@ struct xe_bo {
 	struct ttm_bo_kmap_obj kmap;
 	/** @pinned_link: link to present / evicted list of pinned BO */
 	struct list_head pinned_link;
+	/**
+	 * @defrag_link: link into @xe_device.mem.defrag.list for BOs whose
+	 * backing TT pages were allocated at a sub-optimal order. Protected by
+	 * @xe_device.mem.defrag.lock.
+	 */
+	struct list_head defrag_link;
 #ifdef CONFIG_PROC_FS
 	/**
 	 * @client: @xe_drm_client which created the bo
diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index 0c4ee874a56d..d4321419ee35 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -601,6 +601,8 @@ int xe_device_init_early(struct xe_device *xe)
 	if (err)
 		return err;
 
+	xe_bo_defrag_init_early(xe);
+
 	xe->preempt_fence_wq = alloc_ordered_workqueue("xe-preempt-fence-wq",
 						       WQ_MEM_RECLAIM);
 	xe->ordered_wq = alloc_ordered_workqueue("xe-ordered-wq", 0);
diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index 95e7cea91cbf..9e6244d8f41b 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -296,6 +296,25 @@ struct xe_device {
 		 */
 		atomic_long_t dma_mapped_pages_svm[NR_PAGE_ORDERS];
 #endif
+		/**
+		 * @mem.defrag: Tracking of BOs whose backing TT pages were
+		 * allocated at a sub-optimal (smaller than beneficial) order.
+		 *
+		 * Such BOs are candidates for a future defragmentation pass that
+		 * tries to reallocate their pages at the device's beneficial
+		 * order. Only ttm_bo_type_device BOs are tracked.
+		 */
+		struct {
+			/** @mem.defrag.lock: Protects @mem.defrag.list. */
+			spinlock_t lock;
+			/** @mem.defrag.list: List of struct xe_bo defrag_link. */
+			struct list_head list;
+			/**
+			 * @mem.defrag.count: Number of BOs currently on
+			 * @mem.defrag.list.
+			 */
+			atomic_t count;
+		} defrag;
 	} mem;
 
 	/** @sriov: device level virtualization data */
-- 
2.34.1

