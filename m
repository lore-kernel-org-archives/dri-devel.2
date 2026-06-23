Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD6FBCDE009
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 22:27:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED6D310ED02;
	Tue, 23 Jun 2026 22:27:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="EIedFSfF";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63FF810E197;
 Tue, 23 Jun 2026 22:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782253660; x=1813789660;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=N8TVG0VrSo5Jy9kkiwYCAtPT9+B05bnKNhuKpI/rlMg=;
 b=EIedFSfFAkP31O+g7WrWjcpkzYS/46/1eYAgUOJ+dLd7Zu9FKOp1FaDR
 mdbS8MJHd+OL7RapQwje+LH4OZ3Ns68BlTM6KBVOfrZcdX/9ZOwVCA2s8
 anUhRbgMYbVsFeO2YLy2R92ZTagDkjnqAF04HgLYQqzMsGf6SikhEXULt
 ZPAbHYTskDRtx/+9FNB8l96LTJwgGjvi4D9kKpW9KfpVfdcXsYruKt4It
 ljTMjbqBbCbOffNnGPSZ5ASbOdo9JbMdSa+ReJ1Yu6GJUvL8n4BUbthPT
 Ul7oAB3iiiILYd8NCNor7R8w+tRdq0QOyjmnfMFtnJeAHpN/SeCMhVz5i A==;
X-CSE-ConnectionGUID: fvOKtMguSx+7mdu1aDzLNw==
X-CSE-MsgGUID: w/U4Rth+Rc6az6LDcuBQng==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="83048829"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="83048829"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 15:27:39 -0700
X-CSE-ConnectionGUID: QqBFiRXDQB2WJUw8WwGqZA==
X-CSE-MsgGUID: d5mNlt5QTN+pYnI2tcmX4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="273335810"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 15:27:39 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [RFC PATCH 09/12] drm/xe: Add a page defragmentation worker
Date: Tue, 23 Jun 2026 15:27:29 -0700
Message-Id: <20260623222732.360872-10-matthew.brost@intel.com>
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

BOs whose backing TT pages were allocated below the device's beneficial
order (tracked via ttm_tt::beneficial_order_failed) are added to a
per-device defrag list. Add a delayed worker that periodically walks
this list and attempts to re-back each BO with beneficial-order pages,
improving TLB efficiency for long-lived objects that were initially
allocated under memory pressure.

The worker is kicked when the list first transitions to non-empty and
reschedules itself while work remains. On a failed pass it backs off
exponentially (XE_BO_DEFRAG_INTERVAL_MS up to
XE_BO_DEFRAG_INTERVAL_MAX_MS) and retries the whole list later; the
interval is reset to the default on the next fresh enqueue. The worker
stops scheduling once the list drains.

A defrag move synchronously reallocates and re-copies a BO's backing
store, which is not free. To avoid stalling concurrent active work when
many BOs become eligible at once (e.g. after a burst of memory pressure,
which would otherwise manifest as a large FPS drop while the worker
churns through the whole list), cap the number of BOs processed per run
to XE_BO_DEFRAG_NUM_BO_LIMIT_PER_WORK and reschedule. This spreads the
defrag effort over time, keeping it in the background and yielding to
userspace progress.

Defragmenting a BO forces a TTM move (ctx.defrag) that reallocates the
backing at the beneficial order and relocates the contents on the GPU
(see xe_bo_move()). When beneficial-order pages cannot be obtained the
new allocation is discharged during populate and the BO keeps its
original backing, staying on the list for a later retry.

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
 drivers/gpu/drm/xe/xe_bo.c           | 203 ++++++++++++++++++++++++++-
 drivers/gpu/drm/xe/xe_device_types.h |  11 ++
 2 files changed, 207 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 04709343518c..097cd2ad7c1a 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -31,6 +31,7 @@
 #include "xe_pat.h"
 #include "xe_pm.h"
 #include "xe_preempt_fence.h"
+#include "xe_printk.h"
 #include "xe_pxp.h"
 #include "xe_res_cursor.h"
 #include "xe_shrinker.h"
@@ -49,6 +50,32 @@
  */
 #define XE_BO_DEFRAG_RECLAIM_BACKOFF_THRESHOLD	2
 
+/*
+ * Maximum number of BOs the defrag worker will process in a single run before
+ * yielding and rescheduling itself.
+ *
+ * A defrag move synchronously reallocates and re-copies a BO's backing store,
+ * which is not free. If a large number of BOs become eligible at once (e.g.
+ * after a burst of memory pressure), processing them all in one worker run
+ * would hold things up for a long, unbounded stretch and can visibly starve
+ * concurrent active work (e.g. a large FPS drop). Instead, cap the work done
+ * per run and requeue, spreading the defrag effort out over time so it stays
+ * in the background and yields to userspace progress.
+ */
+#define XE_BO_DEFRAG_NUM_BO_LIMIT_PER_WORK	2
+
+/* Default delay before (re)running the defrag worker, in milliseconds. */
+#define XE_BO_DEFRAG_INTERVAL_MS		50
+
+/*
+ * Upper bound for the (exponentially backed off) defrag worker interval, in
+ * milliseconds, so repeated failures don't push the retry arbitrarily far out.
+ */
+#define XE_BO_DEFRAG_INTERVAL_MAX_MS		15000	/* 15 seconds */
+
+static void xe_bo_defrag_worker(struct work_struct *w);
+static void xe_place_from_ttm_type(u32 mem_type, struct ttm_place *place);
+
 const char *const xe_mem_type_to_name[TTM_NUM_MEM_TYPES]  = {
 	[XE_PL_SYSTEM] = "system",
 	[XE_PL_TT] = "gtt",
@@ -562,12 +589,23 @@ static int xe_ttm_tt_populate(struct ttm_device *ttm_dev, struct ttm_tt *tt,
 	} else {
 		struct xe_device *xe = ttm_to_xe_device(ttm_dev);
 
-		if (atomic_read(&xe->mem.defrag.count) >=
-		    XE_BO_DEFRAG_RECLAIM_BACKOFF_THRESHOLD)
+		if (ctx->defrag)
+			ctx->beneficial_reclaim_backoff = false;
+		else if (atomic_read(&xe->mem.defrag.count) >=
+			 XE_BO_DEFRAG_RECLAIM_BACKOFF_THRESHOLD)
 			ctx->beneficial_reclaim_backoff = true;
 
 		ttm_tt_clear_backed_up(tt);
 		err = ttm_pool_alloc(&ttm_dev->pool, tt, ctx);
+		if (!err && ctx->defrag && tt->beneficial_order_failed) {
+			/*
+			 * Defrag could not obtain beneficial-order pages.
+			 * Discharge the new allocation; the caller keeps the
+			 * BO on its original backing.
+			 */
+			ttm_pool_free(&ttm_dev->pool, tt);
+			return -ENOMEM;
+		}
 	}
 	if (err)
 		return err;
@@ -961,30 +999,54 @@ static int xe_ttm_bo_purge(struct ttm_buffer_object *ttm_bo, struct ttm_operatio
 	return 0;
 }
 
+static void xe_bo_defrag_fini(void *arg)
+{
+	struct xe_device *xe = arg;
+
+	disable_delayed_work_sync(&xe->mem.defrag.worker);
+}
+
 /**
  * xe_bo_defrag_init() - Initialize the device defrag BO tracking
  * @xe: The xe device
  *
- * Initialize the list, lock and count used to track BOs whose backing TT
- * pages were allocated at a sub-optimal order.
+ * Initialize the list, lock, count and delayed worker used to track and
+ * defragment BOs whose backing TT pages were allocated at a sub-optimal order.
  */
 void xe_bo_defrag_init(struct xe_device *xe)
 {
 	spin_lock_init(&xe->mem.defrag.lock);
 	INIT_LIST_HEAD(&xe->mem.defrag.list);
 	atomic_set(&xe->mem.defrag.count, 0);
+	xe->mem.defrag.interval_ms = XE_BO_DEFRAG_INTERVAL_MS;
+	INIT_DELAYED_WORK(&xe->mem.defrag.worker, xe_bo_defrag_worker);
+	devm_add_action_or_reset(xe->drm.dev, xe_bo_defrag_fini, xe);
+}
+
+static void xe_bo_defrag_schedule(struct xe_device *xe)
+{
+	schedule_delayed_work(&xe->mem.defrag.worker,
+			      msecs_to_jiffies(xe->mem.defrag.interval_ms));
 }
 
 static void xe_bo_defrag_add(struct xe_bo *bo)
 {
 	struct xe_device *xe = xe_bo_device(bo);
+	bool kick = false;
 
 	scoped_guard(spinlock, &xe->mem.defrag.lock) {
 		if (list_empty(&bo->defrag_link)) {
+			/* Kick the worker when the list transitions to non-empty. */
+			kick = list_empty(&xe->mem.defrag.list);
+			if (kick)
+				xe->mem.defrag.interval_ms = XE_BO_DEFRAG_INTERVAL_MS;
 			list_add_tail(&bo->defrag_link, &xe->mem.defrag.list);
 			atomic_inc(&xe->mem.defrag.count);
 		}
 	}
+
+	if (kick)
+		xe_bo_defrag_schedule(xe);
 }
 
 /**
@@ -1010,9 +1072,10 @@ void xe_bo_defrag_remove(struct xe_bo *bo)
  * xe_bo_defrag_update() - Update defrag list membership for a BO
  * @bo: The buffer object
  *
- * Add @bo to the device defrag list when it has a populated, non-pinned TT of
- * type ttm_bo_type_device whose pages were allocated at a sub-optimal order
- * (tt->beneficial_order_failed). Otherwise ensure it is removed from the list.
+ * Add @bo to the device defrag list when it is a ttm_bo_type_device BO resident
+ * in XE_PL_TT with a populated TT whose pages were allocated at a sub-optimal
+ * order (tt->beneficial_order_failed) and it isn't pinned. Otherwise ensure it
+ * is removed from the list.
  */
 static void xe_bo_defrag_update(struct xe_bo *bo)
 {
@@ -1021,12 +1084,138 @@ static void xe_bo_defrag_update(struct xe_bo *bo)
 
 	if (ttm_bo->type == ttm_bo_type_device && tt &&
 	    ttm_tt_is_populated(tt) && tt->beneficial_order_failed &&
+	    ttm_bo->resource && ttm_bo->resource->mem_type == XE_PL_TT &&
 	    !xe_bo_is_pinned(bo))
 		xe_bo_defrag_add(bo);
 	else
 		xe_bo_defrag_remove(bo);
 }
 
+/*
+ * Attempt to defragment a single BO by forcing a move that reallocates its
+ * backing at the device's beneficial order. Returns 0 if the BO no longer
+ * needs to be tracked (either defragmented or no longer eligible), or a
+ * negative error code if the attempt should be retried later.
+ */
+static int xe_bo_defrag_one(struct xe_device *xe, struct xe_bo *bo)
+{
+	struct ttm_operation_ctx ctx = {
+		.interruptible = false,
+		.no_wait_gpu = false,
+		.gfp_retry_mayfail = true,
+		.defrag = true,
+	};
+	struct ttm_buffer_object *ttm_bo = &bo->ttm;
+	struct ttm_placement placement;
+	struct ttm_place place;
+	int ret;
+
+	xe_bo_lock(bo, false);
+
+	/* Re-check eligibility under the BO lock. */
+	if (xe_bo_is_pinned(bo) || ttm_bo->type != ttm_bo_type_device ||
+	    !ttm_bo->resource || ttm_bo->resource->mem_type != XE_PL_TT ||
+	    !ttm_bo->ttm || !ttm_tt_is_populated(ttm_bo->ttm) ||
+	    !ttm_bo->ttm->beneficial_order_failed) {
+		xe_bo_defrag_remove(bo);
+		ret = 0;
+		goto unlock;
+	}
+
+	xe_place_from_ttm_type(ttm_bo->resource->mem_type, &place);
+	placement.num_placement = 1;
+	placement.placement = &place;
+
+	/*
+	 * On success the move reallocates the backing at beneficial order and
+	 * drops the BO from the defrag list. On failure the BO keeps its
+	 * original backing and stays on the list for a later retry.
+	 */
+	ret = ttm_bo_validate(ttm_bo, &placement, &ctx);
+
+	xe_dbg(xe, "Defrag attempt on BO size=%lu: ret=%pe\n", xe_bo_size(bo),
+	       ERR_PTR(ret));
+
+unlock:
+	xe_bo_unlock(bo);
+	return ret;
+}
+
+static void xe_bo_defrag_worker(struct work_struct *w)
+{
+	struct delayed_work *dwork = to_delayed_work(w);
+	struct xe_device *xe =
+		container_of(dwork, struct xe_device, mem.defrag.worker);
+	bool requeue = false;
+	int i;
+
+	/*
+	 * Process at most XE_BO_DEFRAG_NUM_BO_LIMIT_PER_WORK BOs per run rather
+	 * than draining the whole list in one go. Each defrag is synchronous and
+	 * relatively expensive, so bounding the work per run keeps the worker
+	 * from monopolising resources and lets concurrent active work make
+	 * progress; any remaining BOs are handled by a follow-up run scheduled
+	 * below.
+	 */
+	for (i = 0; i < XE_BO_DEFRAG_NUM_BO_LIMIT_PER_WORK; ++i) {
+		struct xe_bo *bo;
+		int ret;
+
+		scoped_guard(spinlock, &xe->mem.defrag.lock) {
+			bo = list_first_entry_or_null(&xe->mem.defrag.list,
+						      struct xe_bo, defrag_link);
+			bo = bo ? xe_bo_get_unless_zero(bo) : NULL;
+		}
+
+		if (!bo)
+			break;
+
+		ret = xe_bo_defrag_one(xe, bo);
+		xe_bo_put(bo);
+
+		if (ret) {
+			/*
+			 * Abort the pass and retry the whole list later, backing
+			 * off exponentially on every failure.
+			 */
+			scoped_guard(spinlock, &xe->mem.defrag.lock)
+				xe->mem.defrag.interval_ms =
+					min(xe->mem.defrag.interval_ms * 2,
+					    (unsigned int)XE_BO_DEFRAG_INTERVAL_MAX_MS);
+			requeue = true;
+			break;
+		}
+	}
+
+	/*
+	 * Decide whether to reschedule:
+	 *
+	 *  - The loop hit its per-run limit (i == LIMIT): we stopped early to
+	 *    spread the work out, so requeue at the default interval (reset here
+	 *    since this run made progress) whenever the list still has entries.
+	 *
+	 *  - The loop aborted on a failed defrag (requeue): retry later at the
+	 *    backed-off interval computed above.
+	 *
+	 *  - The loop drained the list (broke on the empty list): nothing left to
+	 *    do, so stop scheduling. A fresh enqueue will kick the worker again.
+	 */
+	if (i == XE_BO_DEFRAG_NUM_BO_LIMIT_PER_WORK) {
+		struct xe_bo *bo;
+
+		scoped_guard(spinlock, &xe->mem.defrag.lock) {
+			bo = list_first_entry_or_null(&xe->mem.defrag.list,
+						      struct xe_bo, defrag_link);
+			xe->mem.defrag.interval_ms = XE_BO_DEFRAG_INTERVAL_MS;
+		}
+
+		if (bo)
+			xe_bo_defrag_schedule(xe);
+	} else if (requeue) {
+		xe_bo_defrag_schedule(xe);
+	}
+}
+
 static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
 		      struct ttm_operation_ctx *ctx,
 		      struct ttm_resource *new_mem,
diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index fe67b0ad938c..4bc2011d5c32 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -299,6 +299,17 @@ struct xe_device {
 			 * @mem.defrag.list.
 			 */
 			atomic_t count;
+			/**
+			 * @mem.defrag.worker: Delayed worker that walks
+			 * @mem.defrag.list trying to reallocate BO backing
+			 * store at the device's beneficial order.
+			 */
+			struct delayed_work worker;
+			/**
+			 * @mem.defrag.interval_ms: Reschedule interval for
+			 * @mem.defrag.worker, in milliseconds.
+			 */
+			unsigned int interval_ms;
 		} defrag;
 	} mem;
 
-- 
2.34.1

