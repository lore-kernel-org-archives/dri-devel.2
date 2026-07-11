Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41D57C44506
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 02:56:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 505CC10E6E6;
	Sat, 11 Jul 2026 02:56:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="S4vrAlQJ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8AF010E2E6;
 Sat, 11 Jul 2026 02:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783738591; x=1815274591;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XHYCO/KAYMIt7E13+Seji9q8hbrXk5C2lLvhm0qp/uU=;
 b=S4vrAlQJRNdOsx7Hnz3mY6pHb1KegXMQ0wdXusdMuykTaPAlKL1eZZJh
 jLRAMYCO0a4IWpkQuwyxqPRQ4t1GI9IYOmTPm32BPPZX/ewZ5kU1CPCfc
 0OghbLiPDAjHHJKzg72PWEahmap4BGmuPuexMnpmZRRpT5DAjE054l3pa
 y3XmRWxSaE3m9b4yJiLFacPx3CLdcVVvykBMd01xG+IV8aTm7ovWGY0gb
 vLZDfsaTTz+me6zcjpxa+7yasM4QSgEF2T6z3NLzgM0nN3gSo1Llo0C8o
 2nQHbZlO2WzTgWKEkCsfUrYbecP95qCz2eufhLWOCDXpqM7VfAdEPWD1Y w==;
X-CSE-ConnectionGUID: Ob1V74nKTpCh8OZZSLtwJg==
X-CSE-MsgGUID: S9waEBsPTJiEy3XbpYM77A==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="101986307"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="101986307"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 19:56:31 -0700
X-CSE-ConnectionGUID: tKAXHlLwSPGWCtn2pg4lHw==
X-CSE-MsgGUID: rwfRChb/RkK9yHNTTBJVYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="256987761"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 19:56:30 -0700
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
Subject: [PATCH v3 20/33] drm/xe: Add a page defragmentation worker
Date: Fri, 10 Jul 2026 19:56:06 -0700
Message-Id: <20260711025619.2540575-21-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260711025619.2540575-1-matthew.brost@intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
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
order (tracked via the TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED tt page flag)
are added to a per-device defrag list. Add a delayed worker that
periodically walks this list and attempts to re-back each BO with
beneficial-order pages, improving TLB efficiency for long-lived objects
that were initially allocated under memory pressure.

The worker is kicked when the list first transitions to non-empty and
reschedules itself while work remains. On a failed pass it backs off
exponentially (XE_BO_DEFRAG_INTERVAL_MS up to
XE_BO_DEFRAG_INTERVAL_MAX_MS) and retries the whole list later; the
interval is reset to the default on the next fresh enqueue. The worker
stops scheduling once the list drains.

A defrag move synchronously reallocates and re-copies a BO's backing
store, which is not free. To avoid stalling concurrent active work when
many BOs (or one very large BO) become eligible at once (e.g. after a
burst of memory pressure, which would otherwise manifest as a large FPS
drop while the worker churns through the whole list), cap the number of
newly (re)allocated bytes processed per run to XE_BO_DEFRAG_SIZE_LIMIT
and reschedule. Only the pages a move actually reallocates are charged -
pages harvested (borrowed) from the old backing are free and do not count
- so the budget tracks real defrag work and an object larger than the
budget is upgraded in budget-sized slices across runs. This spreads the
defrag effort over time, keeping it in the background and yielding to
userspace progress.

Defragmenting a BO forces a TTM move (ctx.defrag) that reallocates the
backing at the beneficial order and relocates the contents on the GPU
(see xe_bo_move()). The per-BO move is bounded by the run's remaining
byte budget via ctx.defrag_bytes_remaining; the pool allocator reports
how much it spent so the worker can charge it accurately. When
beneficial-order pages cannot be obtained the new allocation is
discharged during populate and the BO keeps its original backing, staying
on the list for a later retry.

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

v3:
 - Compute the needs-more state under the BO lock via an out-param
   instead of re-reading bo->ttm.ttm after unlock (Sashiko)
---
 drivers/gpu/drm/xe/xe_bo.c           | 296 ++++++++++++++++++++++++++-
 drivers/gpu/drm/xe/xe_bo.h           |   1 +
 drivers/gpu/drm/xe/xe_device.c       |   9 +
 drivers/gpu/drm/xe/xe_device_types.h |  11 +
 4 files changed, 313 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 7f6ee9b8d12e..907cfa57481f 100644
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
@@ -49,6 +50,35 @@
  */
 #define XE_BO_DEFRAG_RECLAIM_BACKOFF_THRESHOLD	2
 
+/*
+ * Maximum number of bytes of newly (re)allocated backing the defrag worker will
+ * produce in a single run before yielding and rescheduling itself.
+ *
+ * A defrag move synchronously reallocates and re-copies a BO's backing store,
+ * which is not free. If a large number of BOs (or one very large BO) become
+ * eligible at once (e.g. after a burst of memory pressure), processing them all
+ * in one worker run would hold things up for a long, unbounded stretch and can
+ * visibly starve concurrent active work (e.g. a large FPS drop). Instead, cap
+ * the bytes actually upgraded per run and requeue, spreading the defrag effort
+ * out over time so it stays in the background and yields to userspace progress.
+ * Only pages a move truly reallocates are charged; pages harvested from the old
+ * backing are free, so an object larger than the budget is upgraded in
+ * budget-sized slices across runs.
+ */
+#define XE_BO_DEFRAG_SIZE_LIMIT			SZ_32M
+
+/* Default delay before (re)running the defrag worker, in milliseconds. */
+#define XE_BO_DEFRAG_INTERVAL_MS		25
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
@@ -624,8 +654,10 @@ static int xe_ttm_tt_populate(struct ttm_device *ttm_dev, struct ttm_tt *tt,
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
@@ -1047,18 +1079,54 @@ static int xe_ttm_bo_purge(struct ttm_buffer_object *ttm_bo, struct ttm_operatio
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
  * xe_bo_defrag_init_early() - Initialize the device defrag BO tracking
  * @xe: The xe device
  *
- * Initialize the list, lock and count used to track BOs whose backing TT
- * pages were allocated at a sub-optimal order.
+ * Initialize the list, lock, count and delayed worker used to track and
+ * defragment BOs whose backing TT pages were allocated at a sub-optimal order.
+ *
+ * The devm action that cancels the worker on teardown is registered separately
+ * by xe_bo_defrag_init(), which must run after the migrate contexts the
+ * worker depends on have been initialized.
  */
 void xe_bo_defrag_init_early(struct xe_device *xe)
 {
 	spin_lock_init(&xe->mem.defrag.lock);
 	INIT_LIST_HEAD(&xe->mem.defrag.list);
 	atomic_set(&xe->mem.defrag.count, 0);
+	xe->mem.defrag.interval_ms = XE_BO_DEFRAG_INTERVAL_MS;
+	INIT_DELAYED_WORK(&xe->mem.defrag.worker, xe_bo_defrag_worker);
+}
+
+/**
+ * xe_bo_defrag_init() - Register defrag worker teardown
+ * @xe: The xe device
+ *
+ * Register the devm action that disables and drains the defrag worker on
+ * device teardown. This must be called after xe_migrate_init() so that, with
+ * devm's reverse-order cleanup, the worker is stopped before the migrate
+ * contexts it relies on (via xe_bo_defrag_one() -> ttm_bo_validate() ->
+ * xe_bo_move() -> xe_migrate_copy_defrag()) are torn down.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int xe_bo_defrag_init(struct xe_device *xe)
+{
+	return devm_add_action_or_reset(xe->drm.dev, xe_bo_defrag_fini, xe);
+}
+
+static void xe_bo_defrag_schedule(struct xe_device *xe)
+{
+	schedule_delayed_work(&xe->mem.defrag.worker,
+			      msecs_to_jiffies(xe->mem.defrag.interval_ms));
 }
 
 static bool xe_bo_needs_defrag(struct xe_bo *bo)
@@ -1079,16 +1147,24 @@ static bool xe_bo_needs_defrag(struct xe_bo *bo)
 static void xe_bo_defrag_add(struct xe_bo *bo)
 {
 	struct xe_device *xe = xe_bo_device(bo);
+	bool kick = false;
 
 	xe_bo_assert_held(bo);
 	xe_assert(xe, xe_bo_needs_defrag(bo));
 
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
 
 static void __xe_bo_defrag_remove(struct xe_bo *bo)
@@ -1131,6 +1207,218 @@ static void xe_bo_defrag_update(struct xe_bo *bo)
 		xe_bo_defrag_remove(bo);
 }
 
+/*
+ * Attempt to defragment a single BO by forcing a move that reallocates its
+ * backing at the device's beneficial order. @budget bounds how many bytes of
+ * new pages the move may (re)allocate; the remainder of the object is completed
+ * by harvesting the old backing, and the BO stays flagged for a later pass. On
+ * return *@consumed holds the bytes actually (re)allocated (0 on failure or
+ * when nothing needed reallocating). *@needs_more is set to true when the move
+ * succeeded but the BO still has sub-beneficial backing (partial upgrade) and
+ * should be revisited; it is computed under the BO lock so the caller does not
+ * need to re-inspect bo->ttm.ttm after the lock is dropped. Returns 0 if the BO
+ * no longer needs to be tracked (either defragmented or no longer eligible), or
+ * a negative error code if the attempt should be retried later.
+ */
+static int xe_bo_defrag_one(struct xe_device *xe, struct xe_bo *bo,
+			    u64 budget, u64 *consumed, bool *needs_more)
+{
+	struct ttm_operation_ctx ctx = {
+		.gfp_retry_mayfail = true,
+		.defrag = true,
+		.defrag_bytes_remaining = budget,
+	};
+	struct ttm_buffer_object *ttm_bo = &bo->ttm;
+	struct ttm_placement placement;
+	struct ttm_place place;
+	int ret = 0;
+
+	*consumed = 0;
+	*needs_more = false;
+
+	xe_bo_lock(bo, false);
+
+	/* Re-check eligibility under the BO lock. */
+	if (!xe_bo_needs_defrag(bo)) {
+		xe_bo_defrag_remove(bo);
+		goto unlock;
+	}
+
+	xe_place_from_ttm_type(ttm_bo->resource->mem_type, &place);
+	place.flags |= TTM_PL_FLAG_TEMPORARY;
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
+	/*
+	 * The pool allocator decremented defrag_bytes_remaining as it
+	 * (re)allocated pages, so the unused budget tells us how much was spent.
+	 * Only meaningful when the move succeeded. A successful move may spend
+	 * nothing - e.g. when the object was already fully upgraded and every
+	 * chunk is harvested (borrowed) from the old backing for free - so a
+	 * zero spend is legitimate and must be charged as zero, not the whole
+	 * budget.
+	 */
+	if (!ret) {
+		s64 spent = (s64)budget - ctx.defrag_bytes_remaining;
+
+		*consumed = spent > 0 ? spent : 0;
+	}
+
+	xe_dbg(xe, "Defrag attempt on BO size=%zu: ret=%pe consumed=%llu\n",
+	       xe_bo_size(bo), ERR_PTR(ret), *consumed);
+
+	if (!ret && ttm_tt_is_beneficial_order_failed(bo->ttm.ttm))
+		*needs_more = true;
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
+	u64 defrag_bytes = 0;
+	bool requeue = false;
+	int idx;
+
+	if (!drm_dev_enter(&xe->drm, &idx))
+		return;
+
+	if (!xe_pm_runtime_get_if_in_use(xe)) {
+		/*
+		 * The device is (runtime) suspending/suspended. Reschedule so
+		 * the pass retries once it is active again: the enqueue-time
+		 * kick in xe_bo_defrag_add() only fires on an empty->non-empty
+		 * transition, so it will not re-arm the worker while the list
+		 * is still non-empty. Requeue here to avoid stranding tracked
+		 * BOs. The get attempt does not resume the device, so this is
+		 * just a lightweight CPU-side timer while suspended.
+		 */
+		if (atomic_read(&xe->mem.defrag.count))
+			xe_bo_defrag_schedule(xe);
+		drm_dev_exit(idx);
+		return;
+	}
+
+	/*
+	 * Process at most XE_BO_DEFRAG_SIZE_LIMIT bytes of newly (re)allocated
+	 * backing per run rather than draining the whole list in one go. Only
+	 * the pages a move actually reallocates are charged - pages harvested
+	 * (borrowed) from the old backing are free and do not count - so the
+	 * budget tracks real defrag work. A single object larger than the
+	 * budget is upgraded in slices across successive runs. Each defrag is
+	 * synchronous and relatively expensive, so bounding the work per run
+	 * keeps the worker from monopolising resources and lets concurrent
+	 * active work make progress; any remaining work is handled by a
+	 * follow-up run scheduled below.
+	 */
+	while (defrag_bytes < XE_BO_DEFRAG_SIZE_LIMIT) {
+		struct xe_bo *first, *bo;
+		u64 consumed = 0;
+		bool needs_more = false;
+		int ret;
+
+		scoped_guard(spinlock, &xe->mem.defrag.lock) {
+			bool again;
+
+			/* Progress, reset interval */
+			if (defrag_bytes)
+				xe->mem.defrag.interval_ms = XE_BO_DEFRAG_INTERVAL_MS;
+
+			do {
+				first = list_first_entry_or_null(&xe->mem.defrag.list,
+								 struct xe_bo,
+								 defrag_link);
+				bo = first ? xe_bo_get_unless_zero(first) : NULL;
+				again = first && !bo;
+				if (again) {
+					list_del_init(&first->defrag_link);
+					atomic_dec(&xe->mem.defrag.count);
+				}
+			} while (again);
+		}
+
+		if (!bo)
+			break;
+
+		/*
+		 * Bound the per-BO move to the run's remaining byte budget. A
+		 * large object is upgraded in budget-sized slices across runs;
+		 * the slices already upgraded come back as free already-
+		 * beneficial harvests, so each run only spends budget on new
+		 * forward progress.
+		 */
+		ret = xe_bo_defrag_one(xe, bo, XE_BO_DEFRAG_SIZE_LIMIT - defrag_bytes,
+				       &consumed, &needs_more);
+		defrag_bytes += consumed;
+
+		if (ret || needs_more) {
+			scoped_guard(spinlock, &xe->mem.defrag.lock) {
+				if (ret)
+					/*
+					 * Abort the pass and retry the whole
+					 * list later, backing off exponentially
+					 * on every failure.
+					 */
+					xe->mem.defrag.interval_ms =
+						min(xe->mem.defrag.interval_ms * 2,
+						    (unsigned int)XE_BO_DEFRAG_INTERVAL_MAX_MS);
+				else
+					/* Progress, reset interval */
+					xe->mem.defrag.interval_ms = XE_BO_DEFRAG_INTERVAL_MS;
+			}
+
+			xe_bo_put(bo);
+			requeue = true;
+			break;
+		}
+
+		xe_bo_put(bo);
+	}
+
+	/*
+	 * Decide whether to reschedule:
+	 *
+	 *  - The loop hit its per-run limit (defrag_bytes >=
+	 *    XE_BO_DEFRAG_SIZE_LIMIT): we stopped early to spread the work out,
+	 *    so requeue at the default interval (reset here since this run made
+	 *    progress) whenever the list still has entries.
+	 *
+	 *  - The loop aborted on a failed defrag (requeue): retry later at the
+	 *    backed-off interval computed above.
+	 *
+	 *  - The loop drained the list (broke on the empty list): nothing left to
+	 *    do, so stop scheduling. A fresh enqueue will kick the worker again.
+	 */
+	if (defrag_bytes >= XE_BO_DEFRAG_SIZE_LIMIT) {
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
+
+	xe_pm_runtime_put(xe);
+	drm_dev_exit(idx);
+}
+
 static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
 		      struct ttm_operation_ctx *ctx,
 		      struct ttm_resource *new_mem,
diff --git a/drivers/gpu/drm/xe/xe_bo.h b/drivers/gpu/drm/xe/xe_bo.h
index 32211016a722..38d50f8122cb 100644
--- a/drivers/gpu/drm/xe/xe_bo.h
+++ b/drivers/gpu/drm/xe/xe_bo.h
@@ -226,6 +226,7 @@ int xe_bo_pin(struct xe_bo *bo, struct drm_exec *exec);
 void xe_bo_unpin_external(struct xe_bo *bo);
 void xe_bo_unpin(struct xe_bo *bo);
 void xe_bo_defrag_init_early(struct xe_device *xe);
+int xe_bo_defrag_init(struct xe_device *xe);
 int xe_bo_validate(struct xe_bo *bo, struct xe_vm *vm, bool allow_res_evict,
 		   struct drm_exec *exec);
 
diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index bb93425a5c70..19d38e14c910 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -1069,6 +1069,15 @@ int xe_device_probe(struct xe_device *xe)
 			return err;
 	}
 
+	/*
+	 * Register the defrag worker teardown now that the migrate contexts it
+	 * depends on are initialized, so devm's reverse-order cleanup stops the
+	 * worker before those contexts are torn down.
+	 */
+	err = xe_bo_defrag_init(xe);
+	if (err)
+		return err;
+
 	err = xe_pagefault_init(xe);
 	if (err)
 		return err;
diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index 9e6244d8f41b..6e68add4d652 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -314,6 +314,17 @@ struct xe_device {
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

