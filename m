Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D866D58B37
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 04:33:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE04310E2CE;
	Mon, 16 Mar 2026 04:33:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="eHRbIulc";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED2CB10E2B9;
 Mon, 16 Mar 2026 04:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773635584; x=1805171584;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Cjd1VtxKKAilin26daUupnu7azewzrc1r0k15q98034=;
 b=eHRbIulcbQZDONcLrnuVerX3eDg8uBa5K/Co+si6dPJiHsLXWOQ39+8m
 99JvQ51WXX/jmI0xbyzbH1vwokkyfoEmf1yqBH33VWzvO6YUJZbWu6mAu
 wNTCdwSyOXgCFZoNI2hZgo2WE/gnymH7212gmOAK4yqjDhvvS68Bo8WwV
 WwnHTPsPTKhizRDQVH+80dnVzOilK5fmF9WgmFbCUgZaQgZfHhuIBx3in
 eXQHOOUSAEMHzUdsMZ4P/im+9oOpG/4MsOZ4gxafECU6BXGlrYC8H8nfM
 zFTkiQN62CRZ2EY/SIx3ycr95IUY9TeKJ0lpdKhIjxLWxLn+DLY6Xaqga Q==;
X-CSE-ConnectionGUID: BnE0SODhRIi5MlkfSJdFDw==
X-CSE-MsgGUID: ljJ9tAzxSxWuQuuyaa03Fw==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="74683512"
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; d="scan'208";a="74683512"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2026 21:33:03 -0700
X-CSE-ConnectionGUID: lKd/Q3m2Scq36qzHFYeC0A==
X-CSE-MsgGUID: haClJNecR4K3fV4eF6ehOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; d="scan'208";a="221022171"
Received: from lstrano-desk.jf.intel.com ([10.54.39.91])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2026 21:33:03 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Subject: [RFC PATCH 08/12] drm/xe: Rework exec queue object on top of DRM dep
Date: Sun, 15 Mar 2026 21:32:51 -0700
Message-Id: <20260316043255.226352-9-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260316043255.226352-1-matthew.brost@intel.com>
References: <20260316043255.226352-1-matthew.brost@intel.com>
MIME-Version: 1.0
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

Move drm_dep_queue from the backend scheduler object into the
xe_exec_queue object. This allows reference counting to shift from
xe_exec_queue to drm_dep_queue and enables use of the drm_dep_queue fini
vfunc to initiate asynchronous queue teardown with the GuC firmware.

Rework and shuffle code so that xe_exec_queue_destroy and
xe_exec_queue_fini become IRQ-safe. Once this rework is complete, the
GuC submission backend async-destroy worker can be dropped in favor of
using dep_free_wq for asynchronous exec-queue destruction.

Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/xe/xe_exec_queue.c           |  94 ++++++++-------
 drivers/gpu/drm/xe/xe_exec_queue.h           |   9 +-
 drivers/gpu/drm/xe/xe_exec_queue_types.h     |   6 +-
 drivers/gpu/drm/xe/xe_execlist.c             |  18 +--
 drivers/gpu/drm/xe/xe_execlist_types.h       |   2 -
 drivers/gpu/drm/xe/xe_gpu_scheduler.c        |  18 +--
 drivers/gpu/drm/xe/xe_gpu_scheduler.h        |   8 +-
 drivers/gpu/drm/xe/xe_gpu_scheduler_types.h  |   6 +-
 drivers/gpu/drm/xe/xe_guc_exec_queue_types.h |   4 +-
 drivers/gpu/drm/xe/xe_guc_submit.c           | 119 ++++++++++---------
 drivers/gpu/drm/xe/xe_sched_job.c            |   4 +-
 11 files changed, 143 insertions(+), 145 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_exec_queue.c b/drivers/gpu/drm/xe/xe_exec_queue.c
index b287d0e0e60a..b34af4594512 100644
--- a/drivers/gpu/drm/xe/xe_exec_queue.c
+++ b/drivers/gpu/drm/xe/xe_exec_queue.c
@@ -142,6 +142,12 @@ static void __xe_exec_queue_free(struct xe_exec_queue *q)
 {
 	int i;
 
+	if (q->ufence_syncobj)
+		drm_syncobj_put(q->ufence_syncobj);
+
+	for (i = 0; i < q->width; ++i)
+		xe_lrc_put(q->lrc[i]);
+
 	for (i = 0; i < XE_EXEC_QUEUE_TLB_INVAL_COUNT; ++i)
 		if (q->tlb_inval[i].dep_scheduler)
 			xe_dep_scheduler_fini(q->tlb_inval[i].dep_scheduler);
@@ -157,11 +163,19 @@ static void __xe_exec_queue_free(struct xe_exec_queue *q)
 		xe_vm_put(q->vm);
 	}
 
+	if (q->user_vm)
+		xe_vm_put(q->user_vm);
+
 	if (q->xef)
 		xe_file_put(q->xef);
 
 	kvfree(q->replay_state);
-	kfree(q);
+	if (drm_dep_queue_is_initialized(&q->dep_q)) {
+		xe_assert(gt_to_xe(q->gt), !drm_dep_queue_refcount(&q->dep_q));
+		kfree_rcu(q, dep_q.rcu);
+	} else {
+		kfree(q);
+	}
 }
 
 static int alloc_dep_schedulers(struct xe_device *xe, struct xe_exec_queue *q)
@@ -214,7 +228,6 @@ static struct xe_exec_queue *__xe_exec_queue_alloc(struct xe_device *xe,
 	if (!q)
 		return ERR_PTR(-ENOMEM);
 
-	kref_init(&q->refcount);
 	q->flags = flags;
 	q->hwe = hwe;
 	q->gt = gt;
@@ -321,16 +334,6 @@ struct xe_lrc *xe_exec_queue_lrc(struct xe_exec_queue *q)
 	return q->lrc[0];
 }
 
-static void __xe_exec_queue_fini(struct xe_exec_queue *q)
-{
-	int i;
-
-	q->ops->fini(q);
-
-	for (i = 0; i < q->width; ++i)
-		xe_lrc_put(q->lrc[i]);
-}
-
 static int __xe_exec_queue_init(struct xe_exec_queue *q, u32 exec_queue_flags)
 {
 	int i, err;
@@ -357,8 +360,13 @@ static int __xe_exec_queue_init(struct xe_exec_queue *q, u32 exec_queue_flags)
 		flags |= XE_LRC_DISABLE_STATE_CACHE_PERF_FIX;
 
 	err = q->ops->init(q);
-	if (err)
+	if (err) {
+		if (drm_dep_queue_is_initialized(&q->dep_q))
+			xe_exec_queue_put(q);
+		else
+			__xe_exec_queue_free(q);
 		return err;
+	}
 
 	/*
 	 * This must occur after q->ops->init to avoid race conditions during VF
@@ -398,7 +406,7 @@ static int __xe_exec_queue_init(struct xe_exec_queue *q, u32 exec_queue_flags)
 	return 0;
 
 err_lrc:
-	__xe_exec_queue_fini(q);
+	xe_exec_queue_put(q);
 	return err;
 }
 
@@ -434,7 +442,7 @@ struct xe_exec_queue *xe_exec_queue_create(struct xe_device *xe, struct xe_vm *v
 
 	err = __xe_exec_queue_init(q, flags);
 	if (err)
-		goto err_post_alloc;
+		return ERR_PTR(err);
 
 	/*
 	 * We can only add the queue to the PXP list after the init is complete,
@@ -446,15 +454,13 @@ struct xe_exec_queue *xe_exec_queue_create(struct xe_device *xe, struct xe_vm *v
 	if (xe_exec_queue_uses_pxp(q)) {
 		err = xe_pxp_exec_queue_add(xe->pxp, q);
 		if (err)
-			goto err_post_init;
+			goto err_put;
 	}
 
 	return q;
 
-err_post_init:
-	__xe_exec_queue_fini(q);
-err_post_alloc:
-	__xe_exec_queue_free(q);
+err_put:
+	xe_exec_queue_put(q);
 	return ERR_PTR(err);
 }
 ALLOW_ERROR_INJECTION(xe_exec_queue_create, ERRNO);
@@ -565,26 +571,18 @@ ALLOW_ERROR_INJECTION(xe_exec_queue_create_bind, ERRNO);
 
 /**
  * xe_exec_queue_destroy() - Destroy an exec queue
- * @ref: Reference count of the exec queue
+ * @q: The exec queue
  *
  * Called when the last reference to the exec queue is dropped.
- * Cleans up all resources associated with the exec queue.
- * This function should not be called directly; use xe_exec_queue_put() instead.
+ * Starts the cleanup process for an exec queue.
  */
-void xe_exec_queue_destroy(struct kref *ref)
+void xe_exec_queue_destroy(struct xe_exec_queue *q)
 {
-	struct xe_exec_queue *q = container_of(ref, struct xe_exec_queue, refcount);
 	struct xe_exec_queue *eq, *next;
 	int i;
 
 	xe_assert(gt_to_xe(q->gt), atomic_read(&q->job_cnt) == 0);
 
-	if (q->ufence_syncobj)
-		drm_syncobj_put(q->ufence_syncobj);
-
-	if (xe_exec_queue_uses_pxp(q))
-		xe_pxp_exec_queue_remove(gt_to_xe(q->gt)->pxp, q);
-
 	xe_exec_queue_last_fence_put_unlocked(q);
 	for_each_tlb_inval(i)
 		xe_exec_queue_tlb_inval_last_fence_put_unlocked(q, i);
@@ -595,24 +593,25 @@ void xe_exec_queue_destroy(struct kref *ref)
 			xe_exec_queue_put(eq);
 	}
 
-	if (q->user_vm) {
-		xe_vm_put(q->user_vm);
-		q->user_vm = NULL;
-	}
-
 	q->ops->destroy(q);
 }
 
 /**
- * xe_exec_queue_fini() - Finalize an exec queue
+ * xe_exec_queue_fini() - Free an exec queue
  * @q: The exec queue
  *
- * Finalizes the exec queue by updating run ticks, releasing LRC references,
- * and freeing the queue structure. This is called after the queue has been
- * destroyed and all references have been dropped.
+ * Free an exec queues resources.
+ *
+ * Context: Process context, not in path of reclaim.
  */
-void xe_exec_queue_fini(struct xe_exec_queue *q)
+void xe_exec_queue_free(struct xe_exec_queue *q)
 {
+	/*
+	 * We may take dma-resv on final VM put, which is reclaim-unsafe.
+	 * Teach lockdep that this function is also reclaim-unsafe.
+	 */
+	might_alloc(GFP_KERNEL);
+
 	/*
 	 * Before releasing our ref to lrc and xef, accumulate our run ticks
 	 * and wakeup any waiters.
@@ -621,10 +620,21 @@ void xe_exec_queue_fini(struct xe_exec_queue *q)
 	if (q->xef && atomic_dec_and_test(&q->xef->exec_queue.pending_removal))
 		wake_up_var(&q->xef->exec_queue.pending_removal);
 
-	__xe_exec_queue_fini(q);
 	__xe_exec_queue_free(q);
 }
 
+/**
+ * xe_exec_queue_fini() - Finalize an exec queue
+ * @q: The exec queue
+ *
+ * This is called after the queue has been destroyed and all references in the
+ * firmware / hardware have been dropped.
+ */
+void xe_exec_queue_fini(struct xe_exec_queue *q)
+{
+	q->ops->fini(q);
+}
+
 /**
  * xe_exec_queue_assign_name() - Assign a name to an exec queue
  * @q: The exec queue
diff --git a/drivers/gpu/drm/xe/xe_exec_queue.h b/drivers/gpu/drm/xe/xe_exec_queue.h
index a82d99bd77bc..694beae7f11b 100644
--- a/drivers/gpu/drm/xe/xe_exec_queue.h
+++ b/drivers/gpu/drm/xe/xe_exec_queue.h
@@ -31,14 +31,15 @@ struct xe_exec_queue *xe_exec_queue_create_bind(struct xe_device *xe,
 						struct xe_vm *user_vm,
 						u32 flags, u64 extensions);
 
+void xe_exec_queue_destroy(struct xe_exec_queue *q);
 void xe_exec_queue_fini(struct xe_exec_queue *q);
-void xe_exec_queue_destroy(struct kref *ref);
+void xe_exec_queue_free(struct xe_exec_queue *q);
 void xe_exec_queue_assign_name(struct xe_exec_queue *q, u32 instance);
 
 static inline struct xe_exec_queue *
 xe_exec_queue_get_unless_zero(struct xe_exec_queue *q)
 {
-	if (kref_get_unless_zero(&q->refcount))
+	if (drm_dep_queue_get_unless_zero(&q->dep_q))
 		return q;
 
 	return NULL;
@@ -48,13 +49,13 @@ struct xe_exec_queue *xe_exec_queue_lookup(struct xe_file *xef, u32 id);
 
 static inline struct xe_exec_queue *xe_exec_queue_get(struct xe_exec_queue *q)
 {
-	kref_get(&q->refcount);
+	drm_dep_queue_get(&q->dep_q);
 	return q;
 }
 
 static inline void xe_exec_queue_put(struct xe_exec_queue *q)
 {
-	kref_put(&q->refcount, xe_exec_queue_destroy);
+	drm_dep_queue_put(&q->dep_q);
 }
 
 static inline bool xe_exec_queue_is_parallel(struct xe_exec_queue *q)
diff --git a/drivers/gpu/drm/xe/xe_exec_queue_types.h b/drivers/gpu/drm/xe/xe_exec_queue_types.h
index 35c7625a2df5..adb82c9064af 100644
--- a/drivers/gpu/drm/xe/xe_exec_queue_types.h
+++ b/drivers/gpu/drm/xe/xe_exec_queue_types.h
@@ -6,8 +6,6 @@
 #ifndef _XE_EXEC_QUEUE_TYPES_H_
 #define _XE_EXEC_QUEUE_TYPES_H_
 
-#include <linux/kref.h>
-
 #include <drm/drm_dep.h>
 
 #include "xe_gpu_scheduler_types.h"
@@ -88,8 +86,6 @@ struct xe_exec_queue {
 	 * really be used for submissions.
 	 */
 	struct xe_hw_engine *hwe;
-	/** @refcount: ref count of this exec queue */
-	struct kref refcount;
 	/** @vm: VM (address space) for this exec queue */
 	struct xe_vm *vm;
 	/**
@@ -246,7 +242,7 @@ struct xe_exec_queue {
 	/** @ring_ops: ring operations for this exec queue */
 	const struct xe_ring_ops *ring_ops;
 	/** @dep_q: dep queue for this exec queue (1 to 1 relationship) */
-	struct drm_dep_queue *dep_q;
+	struct drm_dep_queue dep_q;
 
 #define XE_MAX_JOB_COUNT_PER_EXEC_QUEUE	1000
 	/** @job_cnt: number of drm jobs in this exec queue */
diff --git a/drivers/gpu/drm/xe/xe_execlist.c b/drivers/gpu/drm/xe/xe_execlist.c
index fb948b2c617c..771039b0f4fa 100644
--- a/drivers/gpu/drm/xe/xe_execlist.c
+++ b/drivers/gpu/drm/xe/xe_execlist.c
@@ -319,16 +319,12 @@ execlist_run_job(struct drm_dep_job *drm_job)
 	return job->fence;
 }
 
-static void execlist_dep_queue_release(struct drm_dep_queue *q)
+static void execlist_dep_queue_release(struct drm_dep_queue *dep_q)
 {
-	struct xe_execlist_exec_queue *exl =
-		container_of(q, typeof(*exl), queue);
+	struct xe_exec_queue *q = container_of(dep_q, typeof(*q), dep_q);
 
-	/*
-	 * RCU free: the dep queue's name may be referenced by exported dma
-	 * fences (timeline name). Defer freeing until after any RCU readers.
-	 */
-	kfree_rcu(exl, queue.rcu);
+	kfree(q->execlist);
+	xe_exec_queue_free(q);
 }
 
 static const struct drm_dep_queue_ops execlist_dep_queue_ops = {
@@ -359,7 +355,7 @@ static int execlist_exec_queue_init(struct xe_exec_queue *q)
 
 	exl->q = q;
 
-	err = drm_dep_queue_init(&exl->queue, &args);
+	err = drm_dep_queue_init(&q->dep_q, &args);
 	if (err)
 		goto err_free;
 
@@ -367,7 +363,6 @@ static int execlist_exec_queue_init(struct xe_exec_queue *q)
 	exl->has_run = false;
 	exl->active_priority = XE_EXEC_QUEUE_PRIORITY_UNSET;
 	q->execlist = exl;
-	q->dep_q = &exl->queue;
 
 	xe_exec_queue_assign_name(q, ffs(q->logical_mask) - 1);
 
@@ -380,9 +375,6 @@ static int execlist_exec_queue_init(struct xe_exec_queue *q)
 
 static void execlist_exec_queue_fini(struct xe_exec_queue *q)
 {
-	struct xe_execlist_exec_queue *exl = q->execlist;
-
-	drm_dep_queue_put(&exl->queue);
 }
 
 static void execlist_exec_queue_destroy_async(struct work_struct *w)
diff --git a/drivers/gpu/drm/xe/xe_execlist_types.h b/drivers/gpu/drm/xe/xe_execlist_types.h
index c2c8218db350..9711f1813287 100644
--- a/drivers/gpu/drm/xe/xe_execlist_types.h
+++ b/drivers/gpu/drm/xe/xe_execlist_types.h
@@ -34,8 +34,6 @@ struct xe_execlist_port {
 struct xe_execlist_exec_queue {
 	struct xe_exec_queue *q;
 
-	struct drm_dep_queue queue;
-
 	struct xe_execlist_port *port;
 
 	bool has_run;
diff --git a/drivers/gpu/drm/xe/xe_gpu_scheduler.c b/drivers/gpu/drm/xe/xe_gpu_scheduler.c
index 14c1b8df439f..cae1c6428409 100644
--- a/drivers/gpu/drm/xe/xe_gpu_scheduler.c
+++ b/drivers/gpu/drm/xe/xe_gpu_scheduler.c
@@ -7,7 +7,7 @@
 
 static void xe_sched_process_msg_queue(struct xe_gpu_scheduler *sched)
 {
-	drm_dep_queue_work_enqueue(&sched->base, &sched->work_process_msg);
+	drm_dep_queue_work_enqueue(sched->dep_q, &sched->work_process_msg);
 }
 
 static void xe_sched_process_msg_queue_if_ready(struct xe_gpu_scheduler *sched)
@@ -43,9 +43,9 @@ static void xe_sched_process_msg_work(struct work_struct *w)
 		container_of(w, struct xe_gpu_scheduler, work_process_msg);
 	struct xe_sched_msg *msg;
 
-	drm_dep_queue_sched_guard(&sched->base);
+	drm_dep_queue_sched_guard(sched->dep_q);
 
-	if (drm_dep_queue_is_stopped(&sched->base))
+	if (drm_dep_queue_is_stopped(sched->dep_q))
 		return;
 
 	msg = xe_sched_get_msg(sched);
@@ -81,29 +81,29 @@ int xe_sched_init(struct xe_gpu_scheduler *sched,
 	INIT_LIST_HEAD(&sched->msgs);
 	INIT_WORK(&sched->work_process_msg, xe_sched_process_msg_work);
 
-	return drm_dep_queue_init(&sched->base, &args);
+	return drm_dep_queue_init(sched->dep_q, &args);
 }
 
 void xe_sched_fini(struct xe_gpu_scheduler *sched)
 {
-	drm_dep_queue_put(&sched->base);
+	drm_dep_queue_fini(sched->dep_q);
 }
 
 void xe_sched_submission_start(struct xe_gpu_scheduler *sched)
 {
-	drm_dep_queue_start(&sched->base);
-	drm_dep_queue_work_enqueue(&sched->base, &sched->work_process_msg);
+	drm_dep_queue_start(sched->dep_q);
+	drm_dep_queue_work_enqueue(sched->dep_q, &sched->work_process_msg);
 }
 
 void xe_sched_submission_stop(struct xe_gpu_scheduler *sched)
 {
-	drm_dep_queue_stop(&sched->base);
+	drm_dep_queue_stop(sched->dep_q);
 	cancel_work_sync(&sched->work_process_msg);
 }
 
 void xe_sched_submission_resume_tdr(struct xe_gpu_scheduler *sched)
 {
-	drm_dep_queue_resume_timeout(&sched->base);
+	drm_dep_queue_resume_timeout(sched->dep_q);
 }
 
 void xe_sched_add_msg(struct xe_gpu_scheduler *sched,
diff --git a/drivers/gpu/drm/xe/xe_gpu_scheduler.h b/drivers/gpu/drm/xe/xe_gpu_scheduler.h
index 71c060398be6..7b7bfb2d63e0 100644
--- a/drivers/gpu/drm/xe/xe_gpu_scheduler.h
+++ b/drivers/gpu/drm/xe/xe_gpu_scheduler.h
@@ -42,7 +42,7 @@ void xe_sched_add_msg_head(struct xe_gpu_scheduler *sched,
 
 static inline void xe_sched_tdr_queue_imm(struct xe_gpu_scheduler *sched)
 {
-	drm_dep_queue_trigger_timeout(&sched->base);
+	drm_dep_queue_trigger_timeout(sched->dep_q);
 }
 
 static inline void xe_sched_resubmit_jobs(struct xe_gpu_scheduler *sched)
@@ -51,11 +51,11 @@ static inline void xe_sched_resubmit_jobs(struct xe_gpu_scheduler *sched)
 	struct xe_sched_job *job;
 	bool restore_replay = false;
 
-	drm_dep_queue_for_each_pending_job(drm_job, &sched->base) {
+	drm_dep_queue_for_each_pending_job(drm_job, sched->dep_q) {
 		job = to_xe_sched_job(drm_job);
 		restore_replay |= job->restore_replay;
 		if (restore_replay || !drm_dep_job_is_signaled(drm_job))
-			sched->base.ops->run_job(drm_job);
+			sched->dep_q->ops->run_job(drm_job);
 	}
 }
 
@@ -76,7 +76,7 @@ struct xe_sched_job *xe_sched_first_pending_job(struct xe_gpu_scheduler *sched)
 {
 	struct drm_dep_job *drm_job;
 
-	drm_dep_queue_for_each_pending_job(drm_job, &sched->base)
+	drm_dep_queue_for_each_pending_job(drm_job, sched->dep_q)
 		if (!drm_dep_job_is_signaled(drm_job))
 			return to_xe_sched_job(drm_job);
 
diff --git a/drivers/gpu/drm/xe/xe_gpu_scheduler_types.h b/drivers/gpu/drm/xe/xe_gpu_scheduler_types.h
index ff89d36d3b2a..b059cb75fca8 100644
--- a/drivers/gpu/drm/xe/xe_gpu_scheduler_types.h
+++ b/drivers/gpu/drm/xe/xe_gpu_scheduler_types.h
@@ -41,8 +41,8 @@ struct xe_sched_backend_ops {
  * struct xe_gpu_scheduler - Xe GPU scheduler
  */
 struct xe_gpu_scheduler {
-	/** @base: DRM dependency queue */
-	struct drm_dep_queue			base;
+	/** @dep_q: DRM dependency queue */
+	struct drm_dep_queue			*dep_q;
 	/** @ops: Xe scheduler ops */
 	const struct xe_sched_backend_ops	*ops;
 	/** @msgs: list of messages to be processed in @work_process_msg */
@@ -53,6 +53,4 @@ struct xe_gpu_scheduler {
 	struct work_struct		work_process_msg;
 };
 
-#define xe_sched_entity		drm_dep_queue
-
 #endif
diff --git a/drivers/gpu/drm/xe/xe_guc_exec_queue_types.h b/drivers/gpu/drm/xe/xe_guc_exec_queue_types.h
index 42ba4892ff71..cb15e86823d2 100644
--- a/drivers/gpu/drm/xe/xe_guc_exec_queue_types.h
+++ b/drivers/gpu/drm/xe/xe_guc_exec_queue_types.h
@@ -29,8 +29,6 @@ struct xe_guc_exec_queue {
 	 */
 #define MAX_STATIC_MSG_TYPE	3
 	struct xe_sched_msg static_msgs[MAX_STATIC_MSG_TYPE];
-	/** @destroy_async: do final destroy async from this worker */
-	struct work_struct destroy_async;
 	/** @resume_time: time of last resume */
 	u64 resume_time;
 	/** @state: GuC specific state for this xe_exec_queue */
@@ -40,7 +38,7 @@ struct xe_guc_exec_queue {
 	/** @wqi_tail: work queue item tail */
 	u32 wqi_tail;
 	/** @id: GuC id for this exec_queue */
-	u16 id;
+	u32 id;
 	/** @suspend_wait: wait queue used to wait on pending suspends */
 	wait_queue_head_t suspend_wait;
 	/** @suspend_pending: a suspend of the exec_queue is pending */
diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
index 2f91902bd2cb..af54ac9d5607 100644
--- a/drivers/gpu/drm/xe/xe_guc_submit.c
+++ b/drivers/gpu/drm/xe/xe_guc_submit.c
@@ -403,12 +403,17 @@ void xe_guc_submit_disable(struct xe_guc *guc)
 	guc->submission_state.enabled = false;
 }
 
+#define GUC_ID_INVALID	BIT(31)
+
 static void __release_guc_id(struct xe_guc *guc, struct xe_exec_queue *q, u32 xa_count)
 {
 	int i;
 
 	lockdep_assert_held(&guc->submission_state.lock);
 
+	if (q->guc->id == GUC_ID_INVALID)
+		return;
+
 	for (i = 0; i < xa_count; ++i)
 		xa_erase(&guc->submission_state.exec_queue_lookup, q->guc->id + i);
 
@@ -424,6 +429,8 @@ static int alloc_guc_id(struct xe_guc *guc, struct xe_exec_queue *q)
 	int ret;
 	int i;
 
+	q->guc->id = GUC_ID_INVALID;
+
 	/*
 	 * Must use GFP_NOWAIT as this lock is in the dma fence signalling path,
 	 * worse case user gets -ENOMEM on engine create and has to try again.
@@ -451,6 +458,7 @@ static int alloc_guc_id(struct xe_guc *guc, struct xe_exec_queue *q)
 
 err_release:
 	__release_guc_id(guc, q, i);
+	q->guc->id = GUC_ID_INVALID;
 
 	return ret;
 }
@@ -1630,7 +1638,7 @@ guc_exec_queue_timedout_job(struct drm_dep_job *drm_job)
 
 	/* Mark all outstanding jobs as bad, thus completing them */
 	xe_sched_job_set_error(job, err);
-	drm_dep_queue_for_each_pending_job(tmp_job, &sched->base)
+	drm_dep_queue_for_each_pending_job(tmp_job, sched->dep_q)
 		xe_sched_job_set_error(to_xe_sched_job(tmp_job), -ECANCELED);
 
 	if (xe_exec_queue_is_multi_queue(q)) {
@@ -1660,45 +1668,16 @@ guc_exec_queue_timedout_job(struct drm_dep_job *drm_job)
 static void guc_exec_queue_fini(struct xe_exec_queue *q)
 {
 	struct xe_guc_exec_queue *ge = q->guc;
-	struct xe_guc *guc = exec_queue_to_guc(q);
 
-	release_guc_id(guc, q);
 	xe_sched_fini(&ge->sched);
 }
 
 static void __guc_exec_queue_destroy(struct xe_exec_queue *q)
 {
 	trace_xe_exec_queue_destroy(q);
-
-	if (xe_exec_queue_is_multi_queue_secondary(q)) {
-		struct xe_exec_queue_group *group = q->multi_queue.group;
-
-		mutex_lock(&group->list_lock);
-		list_del(&q->multi_queue.link);
-		mutex_unlock(&group->list_lock);
-	}
-
 	xe_exec_queue_fini(q);
 }
 
-static void __guc_exec_queue_destroy_async(struct work_struct *w)
-{
-	struct xe_guc_exec_queue *ge =
-		container_of(w, struct xe_guc_exec_queue, destroy_async);
-	struct xe_exec_queue *q = ge->q;
-
-	__guc_exec_queue_destroy(q);
-}
-
-static void guc_exec_queue_destroy_async(struct xe_exec_queue *q)
-{
-	struct xe_guc *guc = exec_queue_to_guc(q);
-	struct xe_device *xe = guc_to_xe(guc);
-
-	INIT_WORK(&q->guc->destroy_async, __guc_exec_queue_destroy_async);
-	queue_work(xe->destroy_wq, &q->guc->destroy_async);
-}
-
 static void __guc_exec_queue_process_msg_cleanup(struct xe_sched_msg *msg)
 {
 	struct xe_exec_queue *q = msg->private_data;
@@ -1720,7 +1699,7 @@ static void __guc_exec_queue_process_msg_cleanup(struct xe_sched_msg *msg)
 	if (exec_queue_registered(q) && xe_uc_fw_is_running(&guc->fw))
 		disable_scheduling_deregister(guc, q);
 	else
-		guc_exec_queue_destroy_async(q);
+		__guc_exec_queue_destroy(q);
 }
 
 static bool guc_exec_queue_allowed_to_change_state(struct xe_exec_queue *q)
@@ -1911,24 +1890,39 @@ static void guc_exec_queue_process_msg(struct xe_sched_msg *msg)
 	xe_pm_runtime_put(xe);
 }
 
-static void guc_dep_queue_release(struct drm_dep_queue *q)
+static void guc_dep_queue_release(struct drm_dep_queue *dep_q)
 {
-	struct xe_gpu_scheduler *sched =
-		container_of(q, typeof(*sched), base);
-	struct xe_guc_exec_queue *ge =
-		container_of(sched, typeof(*ge), sched);
+	struct xe_exec_queue *q =
+		container_of(dep_q, typeof(*q), dep_q);
+	struct xe_guc *guc = exec_queue_to_guc(q);
 
-	/*
-	 * RCU free: the dep queue's name may be referenced by exported dma
-	 * fences (timeline name). Defer freeing until after any RCU readers.
-	 */
-	kfree_rcu(ge, sched.base.rcu);
+	if (xe_exec_queue_is_multi_queue_secondary(q)) {
+		struct xe_exec_queue_group *group = q->multi_queue.group;
+
+		mutex_lock(&group->list_lock);
+		if (!list_empty(&q->multi_queue.link))
+			list_del(&q->multi_queue.link);
+		mutex_unlock(&group->list_lock);
+	}
+
+	release_guc_id(guc, q);
+	drm_dep_queue_release(dep_q);
+	kfree(q->guc);
+	xe_exec_queue_free(q);
+}
+
+static void guc_dep_queue_fini(struct drm_dep_queue *dep_q)
+{
+	struct xe_exec_queue *q = container_of(dep_q, typeof(*q), dep_q);
+
+	xe_exec_queue_destroy(q);
 }
 
 static const struct drm_dep_queue_ops guc_dep_queue_ops = {
 	.run_job = guc_exec_queue_run_job,
 	.timedout_job = guc_exec_queue_timedout_job,
 	.release = guc_dep_queue_release,
+	.fini = guc_dep_queue_fini,
 };
 
 static const struct xe_sched_backend_ops xe_sched_ops = {
@@ -1969,9 +1963,10 @@ static int guc_exec_queue_init(struct xe_exec_queue *q)
 	if (xe_exec_queue_is_multi_queue_secondary(q)) {
 		struct xe_exec_queue *primary = xe_exec_queue_multi_queue_primary(q);
 
-		submit_wq = drm_dep_queue_submit_wq(&primary->guc->sched.base);
+		submit_wq = drm_dep_queue_submit_wq(&primary->dep_q);
 	}
 
+	ge->sched.dep_q = &q->dep_q;
 	err = xe_sched_init(&ge->sched, &guc_dep_queue_ops, &xe_sched_ops,
 			    submit_wq, xe_lrc_ring_size() / MAX_JOB_SIZE_BYTES,
 			    timeout, guc_to_gt(guc)->ordered_wq, flags,
@@ -1987,9 +1982,6 @@ static int guc_exec_queue_init(struct xe_exec_queue *q)
 	if (err)
 		goto err_sched;
 
-	/* dep_q IS the queue: ge->sched.base is the drm_dep_queue */
-	q->dep_q = &ge->sched.base;
-
 	if (xe_guc_read_stopped(guc) || vf_recovery(guc))
 		xe_sched_submission_stop(sched);
 
@@ -2003,7 +1995,7 @@ static int guc_exec_queue_init(struct xe_exec_queue *q)
 		INIT_LIST_HEAD(&q->multi_queue.link);
 		mutex_lock(&group->list_lock);
 		if (group->stopped)
-			drm_dep_queue_set_stopped(&q->guc->sched.base);
+			drm_dep_queue_set_stopped(&q->dep_q);
 		list_add_tail(&q->multi_queue.link, &group->list);
 		mutex_unlock(&group->list_lock);
 	}
@@ -2021,7 +2013,6 @@ static int guc_exec_queue_init(struct xe_exec_queue *q)
 
 err_sched:
 	mutex_unlock(&guc->submission_state.lock);
-	xe_sched_fini(&ge->sched);
 
 	return err;
 err_free:
@@ -2041,7 +2032,24 @@ static void guc_exec_queue_kill(struct xe_exec_queue *q)
 static void guc_exec_queue_add_msg(struct xe_exec_queue *q, struct xe_sched_msg *msg,
 				   u32 opcode)
 {
-	xe_pm_runtime_get_noresume(guc_to_xe(exec_queue_to_guc(q)));
+	struct xe_device *xe = guc_to_xe(exec_queue_to_guc(q));
+	bool pm_ref = true;
+
+	/*
+	 * With the reworked exec queue object model on top of drm_dep, it is
+	 * possible to drop a job reference and the final PM reference, followed
+	 * immediately by dropping the last exec queue reference, which triggers
+	 * a cleanup job message.
+	 *
+	 * This sequence can only occur from an IRQ handler, so even if the PM
+	 * reference count reaches zero the device should still be awake. Assert
+	 * that this is indeed the case.
+	 */
+	if ((opcode & OPCODE_MASK) == CLEANUP)
+		pm_ref = xe_pm_runtime_get_if_active(xe);
+	else
+		xe_pm_runtime_get_noresume(xe);
+	xe_gt_assert(guc_to_gt(exec_queue_to_guc(q)), pm_ref);
 
 	INIT_LIST_HEAD(&msg->link);
 	msg->opcode = opcode & OPCODE_MASK;
@@ -2334,7 +2342,7 @@ static void guc_exec_queue_stop(struct xe_guc *guc, struct xe_exec_queue *q)
 	}
 
 	if (do_destroy)
-		guc_exec_queue_destroy_async(q);
+		__guc_exec_queue_destroy(q);
 }
 
 static int guc_submit_reset_prepare(struct xe_guc *guc)
@@ -2480,7 +2488,7 @@ static void guc_exec_queue_pause(struct xe_guc *guc, struct xe_exec_queue *q)
 
 	/* Stop scheduling + flush any DRM scheduler operations */
 	xe_sched_submission_stop(sched);
-	drm_dep_queue_cancel_tdr_sync(&sched->base);
+	drm_dep_queue_cancel_tdr_sync(sched->dep_q);
 
 	guc_exec_queue_revert_pending_state_change(guc, q);
 
@@ -2611,7 +2619,7 @@ static void guc_exec_queue_unpause_prepare(struct xe_guc *guc,
 	struct drm_dep_job *dep_job;
 	bool restore_replay = false;
 
-	drm_dep_queue_for_each_pending_job(dep_job, &sched->base) {
+	drm_dep_queue_for_each_pending_job(dep_job, sched->dep_q) {
 		job = to_xe_sched_job(dep_job);
 		restore_replay |= job->restore_replay;
 		if (restore_replay) {
@@ -2734,7 +2742,7 @@ void xe_guc_submit_unpause_vf(struct xe_guc *guc)
 		 * created after resfix done.
 		 */
 		if (q->guc->id != index ||
-		    !drm_dep_queue_is_stopped(&q->guc->sched.base))
+		    !drm_dep_queue_is_stopped(&q->dep_q))
 			continue;
 
 		guc_exec_queue_unpause(guc, q);
@@ -2897,7 +2905,7 @@ static void handle_deregister_done(struct xe_guc *guc, struct xe_exec_queue *q)
 	trace_xe_exec_queue_deregister_done(q);
 
 	clear_exec_queue_registered(q);
-	guc_exec_queue_destroy_async(q);
+	__guc_exec_queue_destroy(q);
 }
 
 int xe_guc_deregister_done_handler(struct xe_guc *guc, u32 *msg, u32 len)
@@ -3188,7 +3196,6 @@ guc_exec_queue_wq_snapshot_print(struct xe_guc_submit_exec_queue_snapshot *snaps
 struct xe_guc_submit_exec_queue_snapshot *
 xe_guc_exec_queue_snapshot_capture(struct xe_exec_queue *q)
 {
-	struct xe_gpu_scheduler *sched = &q->guc->sched;
 	struct xe_guc_submit_exec_queue_snapshot *snapshot;
 	int i;
 
@@ -3202,8 +3209,8 @@ xe_guc_exec_queue_snapshot_capture(struct xe_exec_queue *q)
 	snapshot->class = q->class;
 	snapshot->logical_mask = q->logical_mask;
 	snapshot->width = q->width;
-	snapshot->refcount = drm_dep_queue_refcount(&sched->base);
-	snapshot->sched_timeout = drm_dep_queue_timeout(&sched->base);
+	snapshot->refcount = drm_dep_queue_refcount(&q->dep_q);
+	snapshot->sched_timeout = drm_dep_queue_timeout(&q->dep_q);
 	snapshot->sched_props.timeslice_us = q->sched_props.timeslice_us;
 	snapshot->sched_props.preempt_timeout_us =
 		q->sched_props.preempt_timeout_us;
diff --git a/drivers/gpu/drm/xe/xe_sched_job.c b/drivers/gpu/drm/xe/xe_sched_job.c
index 6b83618e82aa..d83f0f9ea4ab 100644
--- a/drivers/gpu/drm/xe/xe_sched_job.c
+++ b/drivers/gpu/drm/xe/xe_sched_job.c
@@ -118,7 +118,7 @@ struct xe_sched_job *xe_sched_job_create(struct xe_exec_queue *q,
 	err = drm_dep_job_init(&job->drm,
 			       &(const struct drm_dep_job_init_args){
 					.ops = &xe_sched_job_dep_ops,
-					.q = q->dep_q,
+					.q = &q->dep_q,
 					.credits = 1,
 			       });
 	if (err)
@@ -126,7 +126,6 @@ struct xe_sched_job *xe_sched_job_create(struct xe_exec_queue *q,
 
 	job->q = q;
 	job->sample_timestamp = U64_MAX;
-	xe_exec_queue_get(job->q);
 	atomic_inc(&q->job_cnt);
 	xe_pm_runtime_get_noresume(job_to_xe(job));
 
@@ -188,7 +187,6 @@ static void xe_sched_job_release(struct drm_dep_job *dep_job)
 	dma_fence_put(job->fence);
 	job_free(job);
 	atomic_dec(&q->job_cnt);
-	xe_exec_queue_put(q);
 	xe_pm_runtime_put(xe);
 }
 
-- 
2.34.1

