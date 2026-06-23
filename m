Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCACECDB471
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 22:27:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88EDE10ECEC;
	Tue, 23 Jun 2026 22:27:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Za8CaOnp";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CB2910E197;
 Tue, 23 Jun 2026 22:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782253660; x=1813789660;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=eA7UcwS/tPXEi4g17NjqAuXREaK17Rz6qCntQABdNyw=;
 b=Za8CaOnpE6Hkv7qczmOQCEvCg56kDXbvAjTCqoNNGKlr3Cjw12fhN3hf
 cT2kDG/qB619VJqn3fHozhEfx9D4JL7VltMU2Y01Uw6PoN3ZpIae+3jIB
 pdwV2iICpwc+fIEcFm9LJ7muop1CS9lc/5iMv7el/MO96Mo5CKNhkVDRG
 25laDyzXT4KB+O94KckznmG4ui4tFR/VoWVxC8UBjyvtrkkSEnL+DjmBm
 f9QPdz7M2f9DjX9xtEF+9UexNoJcKTDL2YDWxymOFF90FqA4n/NZqAXDJ
 qp7Z6xjDlS2Eq7EF0eN6DwmXURfHoUZGRwX99as4QZnAE7gYAUDLfNRRW A==;
X-CSE-ConnectionGUID: /EUvsohrRICZbnB7xrcahQ==
X-CSE-MsgGUID: zVztEST9TEOFU/IkEMtGIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="83048825"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="83048825"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 15:27:39 -0700
X-CSE-ConnectionGUID: 96D1kBTeRWSUAFp9LzSFVA==
X-CSE-MsgGUID: IPk1t5EBSSOzvWcESTWn4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="273335805"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 15:27:39 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [RFC PATCH 05/12] drm/xe: Track BOs backed at a sub-optimal page order
Date: Tue, 23 Jun 2026 15:27:25 -0700
Message-Id: <20260623222732.360872-6-matthew.brost@intel.com>
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

Add per-device tracking of BOs whose backing TT pages were allocated
below the pool's beneficial order, as reported by
ttm_tt::beneficial_order_failed. These BOs are future candidates for a
defragmentation pass that reallocates their pages at the beneficial
order.

Add a mem.defrag sub-struct (lock, list, atomic count) to struct
xe_device and a defrag_link to struct xe_bo, initialised at BO create
and device init. Membership is updated from xe_bo_move() via
xe_bo_defrag_update(): a BO is added when it is a populated, non-pinned
ttm_bo_type_device object flagged beneficial_order_failed, and removed
otherwise. BOs are also removed on pin, on purge, and at destroy.

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
 drivers/gpu/drm/xe/xe_bo.c           | 77 ++++++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_bo.h           |  2 +
 drivers/gpu/drm/xe/xe_bo_types.h     |  6 +++
 drivers/gpu/drm/xe/xe_device.c       |  2 +
 drivers/gpu/drm/xe/xe_device_types.h | 19 +++++++
 5 files changed, 106 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 4c80bac67622..4acacc50a28f 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -947,6 +947,72 @@ static int xe_ttm_bo_purge(struct ttm_buffer_object *ttm_bo, struct ttm_operatio
 	return 0;
 }
 
+/**
+ * xe_bo_defrag_init() - Initialize the device defrag BO tracking
+ * @xe: The xe device
+ *
+ * Initialize the list, lock and count used to track BOs whose backing TT
+ * pages were allocated at a sub-optimal order.
+ */
+void xe_bo_defrag_init(struct xe_device *xe)
+{
+	spin_lock_init(&xe->mem.defrag.lock);
+	INIT_LIST_HEAD(&xe->mem.defrag.list);
+	atomic_set(&xe->mem.defrag.count, 0);
+}
+
+static void xe_bo_defrag_add(struct xe_bo *bo)
+{
+	struct xe_device *xe = xe_bo_device(bo);
+
+	scoped_guard(spinlock, &xe->mem.defrag.lock) {
+		if (list_empty(&bo->defrag_link)) {
+			list_add_tail(&bo->defrag_link, &xe->mem.defrag.list);
+			atomic_inc(&xe->mem.defrag.count);
+		}
+	}
+}
+
+/**
+ * xe_bo_defrag_remove() - Remove a BO from the device defrag list
+ * @bo: The buffer object
+ *
+ * Remove @bo from the defrag list if present. Safe to call on a BO that is
+ * not currently on the list.
+ */
+void xe_bo_defrag_remove(struct xe_bo *bo)
+{
+	struct xe_device *xe = xe_bo_device(bo);
+
+	guard(spinlock)(&xe->mem.defrag.lock);
+
+	if (!list_empty(&bo->defrag_link)) {
+		list_del_init(&bo->defrag_link);
+		atomic_dec(&xe->mem.defrag.count);
+	}
+}
+
+/**
+ * xe_bo_defrag_update() - Update defrag list membership for a BO
+ * @bo: The buffer object
+ *
+ * Add @bo to the device defrag list when it has a populated, non-pinned TT of
+ * type ttm_bo_type_device whose pages were allocated at a sub-optimal order
+ * (tt->beneficial_order_failed). Otherwise ensure it is removed from the list.
+ */
+static void xe_bo_defrag_update(struct xe_bo *bo)
+{
+	struct ttm_buffer_object *ttm_bo = &bo->ttm;
+	struct ttm_tt *tt = ttm_bo->ttm;
+
+	if (ttm_bo->type == ttm_bo_type_device && tt &&
+	    ttm_tt_is_populated(tt) && tt->beneficial_order_failed &&
+	    !xe_bo_is_pinned(bo))
+		xe_bo_defrag_add(bo);
+	else
+		xe_bo_defrag_remove(bo);
+}
+
 static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
 		      struct ttm_operation_ctx *ctx,
 		      struct ttm_resource *new_mem,
@@ -975,6 +1041,8 @@ static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
 		if (ret)
 			return ret;
 
+		xe_bo_defrag_remove(bo);
+
 		/* Free the unused eviction destination resource */
 		ttm_resource_free(ttm_bo, &new_mem);
 		return 0;
@@ -1172,6 +1240,8 @@ static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
 		xe_tt_unmap_sg(xe, ttm_bo->ttm);
 	}
 
+	xe_bo_defrag_update(bo);
+
 	return ret;
 }
 
@@ -1850,6 +1920,8 @@ static void xe_ttm_bo_destroy(struct ttm_buffer_object *ttm_bo)
 		list_del(&bo->vram_userfault_link);
 	mutex_unlock(&xe->mem_access.vram_userfault.lock);
 
+	xe_bo_defrag_remove(bo);
+
 	kfree(bo);
 }
 
@@ -2355,6 +2427,7 @@ struct xe_bo *xe_bo_init_locked(struct xe_device *xe, struct xe_bo *bo,
 	bo->ttm.base.funcs = &xe_gem_object_funcs;
 	bo->ttm.priority = XE_BO_PRIORITY_NORMAL;
 	INIT_LIST_HEAD(&bo->pinned_link);
+	INIT_LIST_HEAD(&bo->defrag_link);
 #ifdef CONFIG_PROC_FS
 	INIT_LIST_HEAD(&bo->client_link);
 #endif
@@ -2961,6 +3034,8 @@ int xe_bo_pin_external(struct xe_bo *bo, bool in_place, struct drm_exec *exec)
 	if (bo->ttm.ttm && ttm_tt_is_populated(bo->ttm.ttm))
 		xe_ttm_tt_account_subtract(xe, bo->ttm.ttm);
 
+	xe_bo_defrag_remove(bo);
+
 	/*
 	 * FIXME: If we always use the reserve / unreserve functions for locking
 	 * we do not need this.
@@ -3019,6 +3094,8 @@ int xe_bo_pin(struct xe_bo *bo, struct drm_exec *exec)
 	if (bo->ttm.ttm && ttm_tt_is_populated(bo->ttm.ttm))
 		xe_ttm_tt_account_subtract(xe, bo->ttm.ttm);
 
+	xe_bo_defrag_remove(bo);
+
 	/*
 	 * FIXME: If we always use the reserve / unreserve functions for locking
 	 * we do not need this.
diff --git a/drivers/gpu/drm/xe/xe_bo.h b/drivers/gpu/drm/xe/xe_bo.h
index 6340317f7d2e..6b7c2e99a1d2 100644
--- a/drivers/gpu/drm/xe/xe_bo.h
+++ b/drivers/gpu/drm/xe/xe_bo.h
@@ -224,6 +224,8 @@ int xe_bo_pin_external(struct xe_bo *bo, bool in_place, struct drm_exec *exec);
 int xe_bo_pin(struct xe_bo *bo, struct drm_exec *exec);
 void xe_bo_unpin_external(struct xe_bo *bo);
 void xe_bo_unpin(struct xe_bo *bo);
+void xe_bo_defrag_init(struct xe_device *xe);
+void xe_bo_defrag_remove(struct xe_bo *bo);
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
index b6e49309a99f..c8c90e9b1bc1 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -577,6 +577,8 @@ int xe_device_init_early(struct xe_device *xe)
 	if (err)
 		return err;
 
+	xe_bo_defrag_init(xe);
+
 	xe->preempt_fence_wq = alloc_ordered_workqueue("xe-preempt-fence-wq",
 						       WQ_MEM_RECLAIM);
 	xe->ordered_wq = alloc_ordered_workqueue("xe-ordered-wq", 0);
diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index 4e2f115f14e2..fe67b0ad938c 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -281,6 +281,25 @@ struct xe_device {
 		struct xe_shrinker *shrinker;
 		/** @mem.stolen_mgr: stolen memory manager. */
 		struct xe_ttm_stolen_mgr *stolen_mgr;
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

