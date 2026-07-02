Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B82F3C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 14:38:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D5DA10F3EE;
	Thu,  2 Jul 2026 14:38:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="iYlzuCfz";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25E1210E4F0
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 14:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=nSMcdWizrLLr6mdwhnCNJ6KX/2ECdxlXA5si7GJb6Qw=; b=iYlzuCfzKSJ4idDhN0t6e+i9sB
 gcDLzO630ml6WNR0OZyWSz38K8q9Mph2WXczfhyhgJsVxaxhEJFftGCxHqfH0wLtHTiEXijNDFD6V
 hHkPKLuc/hXMPTx7HLixZ4O4cnY8jnCVTZCAsCZOut6sXBNXFrPNmmC8NK1FcuwO5F6b6BgKAsnoJ
 HdjmDKJah3MR1P+EvpW3cZ7hDXRLoPucMiM/5e0G9rEXEIXgKNTm/gTlclUJOd7I0BWXdnDjuihya
 TriG5scTS6dOvIDnNHCcPeQItFmKpVVPJXx965xBxofpslgc86ggnO8bS5/pakxSY2De1h45zOk4a
 Ot1dyLeQ==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wfIYD-0084Xg-74; Thu, 02 Jul 2026 16:38:01 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Chia-I Wu <olvaffe@gmail.com>, Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>, kernel-dev@igalia.com,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [RFC 5/8] drm: Wrap DRM scheduler worker in own abstraction
Date: Thu,  2 Jul 2026 15:37:42 +0100
Message-ID: <20260702143745.79293-6-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260702143745.79293-1-tvrtko.ursulin@igalia.com>
References: <20260702143745.79293-1-tvrtko.ursulin@igalia.com>
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

We are about to move to kthread_work based solution so lets add a
drm_sched_work(er) abstraction and convert the users.

No functional change is intended at this point.

*** WIP ***
 Only xe and panthor have been converted. Not all drivers will build.
*** WIP ***

TODO:
 * kerneldoc
 * nouveau
 * pvr

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/panthor/panthor_mmu.c       | 20 ++++---
 drivers/gpu/drm/panthor/panthor_sched.c     | 20 +++----
 drivers/gpu/drm/scheduler/sched_main.c      | 64 +++++++++------------
 drivers/gpu/drm/xe/xe_dep_scheduler.c       |  6 +-
 drivers/gpu/drm/xe/xe_dep_scheduler.h       |  6 +-
 drivers/gpu/drm/xe/xe_exec_queue.c          |  6 +-
 drivers/gpu/drm/xe/xe_gpu_scheduler.c       | 17 +++---
 drivers/gpu/drm/xe/xe_gpu_scheduler.h       |  2 +-
 drivers/gpu/drm/xe/xe_gpu_scheduler_types.h |  2 +-
 drivers/gpu/drm/xe/xe_gt.c                  | 10 ++--
 drivers/gpu/drm/xe/xe_gt_types.h            |  4 +-
 drivers/gpu/drm/xe/xe_guc_submit.c          | 13 +++--
 drivers/gpu/drm/xe/xe_tlb_inval.c           | 14 +++--
 drivers/gpu/drm/xe/xe_tlb_inval_types.h     |  5 +-
 include/drm/gpu_scheduler.h                 | 56 ++++++++++++++++--
 15 files changed, 144 insertions(+), 101 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 31cc57029c12..22625d4c2e46 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -105,8 +105,8 @@ struct panthor_mmu {
 		/** @vm.reset_in_progress: True if a reset is in progress. */
 		bool reset_in_progress;
 
-		/** @vm.wq: Workqueue used for the VM_BIND queues. */
-		struct workqueue_struct *wq;
+		/** @vm.sched_worker: DRM scheduler worker used for the VM_BIND queues. */
+		struct drm_sched_worker *sched_worker;
 	} vm;
 };
 
@@ -2856,7 +2856,7 @@ panthor_vm_create(struct panthor_device *ptdev, bool for_mcu,
 	struct drm_gpu_scheduler *sched;
 	const struct drm_sched_init_args sched_args = {
 		.ops = &panthor_vm_bind_ops,
-		.submit_wq = ptdev->mmu->vm.wq,
+		.submit_worker = ptdev->mmu->vm.sched_worker,
 		.credit_limit = 1,
 		/* Bind operations are synchronous for now, no timeout needed. */
 		.timeout = MAX_SCHEDULE_TIMEOUT,
@@ -3359,9 +3359,9 @@ void panthor_mmu_unplug(struct panthor_device *ptdev)
 	mutex_unlock(&ptdev->mmu->as.slots_lock);
 }
 
-static void panthor_mmu_release_wq(struct drm_device *ddev, void *res)
+static void panthor_mmu_release_worker(struct drm_device *ddev, void *res)
 {
-	destroy_workqueue(res);
+	drm_sched_destroy_worker(res);
 }
 
 static void panthor_mmu_info_init(struct panthor_device *ptdev)
@@ -3411,9 +3411,9 @@ int panthor_mmu_init(struct panthor_device *ptdev)
 	if (ret)
 		return ret;
 
-	mmu->vm.wq = alloc_workqueue("panthor-vm-bind", WQ_UNBOUND, 0);
-	if (!mmu->vm.wq)
-		return -ENOMEM;
+	mmu->vm.sched_worker = drm_sched_create_concurrent_worker("panthor-vm-bind");
+	if (IS_ERR(mmu->vm.sched_worker))
+		return PTR_ERR(mmu->vm.sched_worker);
 
 	/* On 32-bit kernels, the VA space is limited by the io_pgtable_ops abstraction,
 	 * which passes iova as an unsigned long. Patch the mmu_features to reflect this
@@ -3424,7 +3424,9 @@ int panthor_mmu_init(struct panthor_device *ptdev)
 		ptdev->gpu_info.mmu_features |= BITS_PER_LONG;
 	}
 
-	return drmm_add_action_or_reset(&ptdev->base, panthor_mmu_release_wq, mmu->vm.wq);
+	return drmm_add_action_or_reset(&ptdev->base,
+					panthor_mmu_release_worker,
+					mmu->vm.sched_worker);
 }
 
 #ifdef CONFIG_DEBUG_FS
diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index f4dfd82ad8a8..dab4b59ff8a1 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -165,12 +165,12 @@ struct panthor_scheduler {
 	struct workqueue_struct *heap_alloc_wq;
 
 	/**
-	 * @sched_wq: Workqueue used for the DRM scheduler.
+	 * @sched_worker: DRM scheduler worker.
 	 *
-	 * Workqueue used for drm_gpu_scheduler instances embedded in
+	 * Worker used for drm_gpu_scheduler instances embedded in
 	 * panthor_queue.
 	 */
-	struct workqueue_struct *sched_wq;
+	struct drm_sched_worker *sched_worker;
 
 	/** @tick_work: Work executed on a scheduling tick. */
 	struct delayed_work tick_work;
@@ -3494,7 +3494,7 @@ group_create_queue(struct panthor_group *group,
 {
 	struct drm_sched_init_args sched_args = {
 		.ops = &panthor_queue_sched_ops,
-		.submit_wq = group->ptdev->scheduler->sched_wq,
+		.submit_worker = group->ptdev->scheduler->sched_worker,
 		/*
 		 * The credit limit argument tells us the total number of
 		 * instructions across all CS slots in the ringbuffer, with
@@ -4084,8 +4084,8 @@ static void panthor_sched_fini(struct drm_device *ddev, void *res)
 	if (sched->heap_alloc_wq)
 		destroy_workqueue(sched->heap_alloc_wq);
 
-	if (sched->sched_wq)
-		destroy_workqueue(sched->sched_wq);
+	if (sched->sched_worker)
+		drm_sched_destroy_worker(sched->sched_worker);
 
 	for (prio = PANTHOR_CSG_PRIORITY_COUNT - 1; prio >= 0; prio--) {
 		drm_WARN_ON(ddev, !list_empty(&sched->groups.runnable[prio]));
@@ -4177,13 +4177,13 @@ int panthor_sched_init(struct panthor_device *ptdev)
 	 * allocate memory, and fail the tiling job if none of these
 	 * countermeasures worked.
 	 *
-	 * Set WQ_MEM_RECLAIM on sched->wq and wq->sched_wq to unblock the
-	 * situation when the system is running out of memory.
+	 * Set WQ_MEM_RECLAIM on sched->wq to unblock the situation when the
+	 * system is running out of memory.
 	 */
 	sched->heap_alloc_wq = alloc_workqueue("panthor-heap-alloc", WQ_UNBOUND, 0);
 	sched->wq = alloc_workqueue("panthor-csf-sched", WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
-	sched->sched_wq = alloc_ordered_workqueue("panthor-drm-sched", WQ_MEM_RECLAIM);
-	if (!sched->wq || !sched->heap_alloc_wq || !sched->sched_wq) {
+	sched->sched_worker =  drm_sched_create_ordered_worker("panthor-drm-sched");
+	if (!sched->wq || !sched->heap_alloc_wq || IS_ERR(sched->sched_worker)) {
 		panthor_sched_fini(&ptdev->base, sched);
 		drm_err(&ptdev->base, "Failed to allocate the workqueues");
 		return -ENOMEM;
diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 4e180f21b946..1e728838a4a2 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -131,7 +131,7 @@ bool drm_sched_can_queue(struct drm_gpu_scheduler *sched,
 static void drm_sched_run_job_queue(struct drm_gpu_scheduler *sched)
 {
 	if (!drm_sched_is_stopped(sched))
-		queue_work(sched->submit_wq, &sched->work_run_job);
+		drm_sched_queue_work(sched->submit_worker, &sched->work_run_job);
 }
 
 /**
@@ -141,7 +141,7 @@ static void drm_sched_run_job_queue(struct drm_gpu_scheduler *sched)
 static void drm_sched_run_free_queue(struct drm_gpu_scheduler *sched)
 {
 	if (!drm_sched_is_stopped(sched))
-		queue_work(sched->submit_wq, &sched->work_free_job);
+		drm_sched_queue_work(sched->submit_worker, &sched->work_free_job);
 }
 
 /**
@@ -951,7 +951,7 @@ EXPORT_SYMBOL(drm_sched_pick_best);
  *
  * @w: free job work
  */
-static void drm_sched_free_job_work(struct work_struct *w)
+static void drm_sched_free_job_work(struct drm_sched_work *w)
 {
 	struct drm_gpu_scheduler *sched =
 		container_of(w, struct drm_gpu_scheduler, work_free_job);
@@ -975,7 +975,7 @@ static void drm_sched_free_job_work(struct work_struct *w)
  *
  * @w: run job work
  */
-static void drm_sched_run_job_work(struct work_struct *w)
+static void drm_sched_run_job_work(struct drm_sched_work *w)
 {
 	struct drm_gpu_scheduler *sched =
 		container_of(w, struct drm_gpu_scheduler, work_run_job);
@@ -1034,25 +1034,6 @@ static void drm_sched_run_job_work(struct work_struct *w)
 	drm_sched_run_job_queue(sched);
 }
 
-static struct workqueue_struct *drm_sched_alloc_wq(const char *name)
-{
-#if (IS_ENABLED(CONFIG_LOCKDEP))
-	static struct lockdep_map map = {
-		.name = "drm_sched_lockdep_map"
-	};
-
-	/*
-	 * Avoid leaking a lockdep map on each drm sched creation and
-	 * destruction by using a single lockdep map for all drm sched
-	 * allocated submit_wq.
-	 */
-
-	return alloc_ordered_workqueue_lockdep_map(name, WQ_MEM_RECLAIM, &map);
-#else
-	return alloc_ordered_workqueue(name, WQ_MEM_RECLAIM);
-#endif
-}
-
 /**
  * drm_sched_init - Init a gpu scheduler instance
  *
@@ -1072,15 +1053,15 @@ int drm_sched_init(struct drm_gpu_scheduler *sched, const struct drm_sched_init_
 	sched->score = args->score ? args->score : &sched->_score;
 	sched->dev = args->dev;
 
-	if (args->submit_wq) {
-		sched->submit_wq = args->submit_wq;
-		sched->own_submit_wq = false;
+	if (args->submit_worker) {
+		sched->submit_worker = args->submit_worker;
+		sched->own_submit_worker = false;
 	} else {
-		sched->submit_wq = drm_sched_alloc_wq(args->name);
-		if (!sched->submit_wq)
-			return -ENOMEM;
+		sched->submit_worker = drm_sched_create_ordered_worker(args->name);
+		if (IS_ERR(sched->submit_worker))
+			return PTR_ERR(sched->submit_worker);
 
-		sched->own_submit_wq = true;
+		sched->own_submit_worker = true;
 	}
 
 	drm_sched_rq_init(&sched->rq);
@@ -1090,8 +1071,8 @@ int drm_sched_init(struct drm_gpu_scheduler *sched, const struct drm_sched_init_
 	spin_lock_init(&sched->job_list_lock);
 	atomic_set(&sched->credit_count, 0);
 	INIT_DELAYED_WORK(&sched->work_tdr, drm_sched_job_timedout);
-	INIT_WORK(&sched->work_run_job, drm_sched_run_job_work);
-	INIT_WORK(&sched->work_free_job, drm_sched_free_job_work);
+	drm_sched_init_work(&sched->work_run_job, drm_sched_run_job_work);
+	drm_sched_init_work(&sched->work_free_job, drm_sched_free_job_work);
 	atomic_set(&sched->_score, 0);
 	atomic64_set(&sched->job_id_count, 0);
 	sched->pause_submit = false;
@@ -1141,8 +1122,8 @@ void drm_sched_fini(struct drm_gpu_scheduler *sched)
 	if (sched->ops->cancel_job)
 		drm_sched_cancel_remaining_jobs(sched);
 
-	if (sched->own_submit_wq)
-		destroy_workqueue(sched->submit_wq);
+	if (sched->own_submit_worker)
+		drm_sched_destroy_worker(sched->submit_worker);
 	sched->ready = false;
 
 	if (!list_empty(&sched->pending_list))
@@ -1209,8 +1190,8 @@ EXPORT_SYMBOL(drm_sched_submission_ready);
 void drm_sched_submission_stop(struct drm_gpu_scheduler *sched)
 {
 	WRITE_ONCE(sched->pause_submit, true);
-	cancel_work_sync(&sched->work_run_job);
-	cancel_work_sync(&sched->work_free_job);
+	drm_sched_cancel_work_sync(&sched->work_run_job);
+	drm_sched_cancel_work_sync(&sched->work_free_job);
 }
 EXPORT_SYMBOL(drm_sched_submission_stop);
 
@@ -1226,8 +1207,8 @@ EXPORT_SYMBOL(drm_sched_submission_stop);
 void drm_sched_submission_start(struct drm_gpu_scheduler *sched)
 {
 	WRITE_ONCE(sched->pause_submit, false);
-	queue_work(sched->submit_wq, &sched->work_run_job);
-	queue_work(sched->submit_wq, &sched->work_free_job);
+	drm_sched_queue_work(sched->submit_worker, &sched->work_run_job);
+	drm_sched_queue_work(sched->submit_worker, &sched->work_free_job);
 }
 EXPORT_SYMBOL(drm_sched_submission_start);
 
@@ -1262,3 +1243,10 @@ bool drm_sched_job_is_signaled(struct drm_sched_job *job)
 		dma_fence_is_signaled(&s_fence->finished);
 }
 EXPORT_SYMBOL(drm_sched_job_is_signaled);
+
+void drm_sched_destroy_worker(struct drm_sched_worker *worker)
+{
+	destroy_workqueue(worker->worker);
+	kfree(worker);
+}
+EXPORT_SYMBOL(drm_sched_destroy_worker);
diff --git a/drivers/gpu/drm/xe/xe_dep_scheduler.c b/drivers/gpu/drm/xe/xe_dep_scheduler.c
index 004aac8b89e6..adf80ed3a080 100644
--- a/drivers/gpu/drm/xe/xe_dep_scheduler.c
+++ b/drivers/gpu/drm/xe/xe_dep_scheduler.c
@@ -59,7 +59,7 @@ static const struct drm_sched_backend_ops sched_ops = {
 /**
  * xe_dep_scheduler_create() - Generic Xe dependency scheduler create
  * @xe: Xe device
- * @submit_wq: Submit workqueue struct (can be NULL)
+ * @submit_worker: Scheduler submit worker (can be NULL)
  * @name: Name of dependency scheduler
  * @job_limit: Max dependency jobs that can be scheduled
  *
@@ -70,14 +70,14 @@ static const struct drm_sched_backend_ops sched_ops = {
  */
 struct xe_dep_scheduler *
 xe_dep_scheduler_create(struct xe_device *xe,
-			struct workqueue_struct *submit_wq,
+			struct drm_sched_worker *submit_worker,
 			const char *name, u32 job_limit)
 {
 	struct xe_dep_scheduler *dep_scheduler;
 	struct drm_gpu_scheduler *sched;
 	const struct drm_sched_init_args args = {
 		.ops = &sched_ops,
-		.submit_wq = submit_wq,
+		.submit_worker = submit_worker,
 		.credit_limit = job_limit,
 		.timeout = MAX_SCHEDULE_TIMEOUT,
 		.name = name,
diff --git a/drivers/gpu/drm/xe/xe_dep_scheduler.h b/drivers/gpu/drm/xe/xe_dep_scheduler.h
index f314fb5d80f5..fa7773245302 100644
--- a/drivers/gpu/drm/xe/xe_dep_scheduler.h
+++ b/drivers/gpu/drm/xe/xe_dep_scheduler.h
@@ -9,13 +9,13 @@
 #include <linux/types.h>
 
 struct drm_sched_entity;
-struct workqueue_struct;
-struct xe_dep_scheduler;
+struct kthread_worker;
+struct drm_sched_worker;
 struct xe_device;
 
 struct xe_dep_scheduler *
 xe_dep_scheduler_create(struct xe_device *xe,
-			struct workqueue_struct *submit_wq,
+			struct drm_sched_worker *submit_worker,
 			const char *name, u32 job_limit);
 
 void xe_dep_scheduler_fini(struct xe_dep_scheduler *dep_scheduler);
diff --git a/drivers/gpu/drm/xe/xe_exec_queue.c b/drivers/gpu/drm/xe/xe_exec_queue.c
index 1b5ca3ce578a..8c37f30fea11 100644
--- a/drivers/gpu/drm/xe/xe_exec_queue.c
+++ b/drivers/gpu/drm/xe/xe_exec_queue.c
@@ -171,8 +171,8 @@ static int alloc_dep_schedulers(struct xe_device *xe, struct xe_exec_queue *q)
 
 	for (i = 0; i < XE_EXEC_QUEUE_TLB_INVAL_COUNT; ++i) {
 		struct xe_dep_scheduler *dep_scheduler;
+		struct drm_sched_worker *worker;
 		struct xe_gt *gt;
-		struct workqueue_struct *wq;
 
 		if (i == XE_EXEC_QUEUE_TLB_INVAL_PRIMARY_GT)
 			gt = tile->primary_gt;
@@ -182,10 +182,10 @@ static int alloc_dep_schedulers(struct xe_device *xe, struct xe_exec_queue *q)
 		if (!gt)
 			continue;
 
-		wq = gt->tlb_inval.job_wq;
+		worker = gt->tlb_inval.job_worker;
 
 #define MAX_TLB_INVAL_JOBS	16	/* Picking a reasonable value */
-		dep_scheduler = xe_dep_scheduler_create(xe, wq, q->name,
+		dep_scheduler = xe_dep_scheduler_create(xe, worker, q->name,
 							MAX_TLB_INVAL_JOBS);
 		if (IS_ERR(dep_scheduler))
 			return PTR_ERR(dep_scheduler);
diff --git a/drivers/gpu/drm/xe/xe_gpu_scheduler.c b/drivers/gpu/drm/xe/xe_gpu_scheduler.c
index ed7f4f52b3c8..787cdfc0bc06 100644
--- a/drivers/gpu/drm/xe/xe_gpu_scheduler.c
+++ b/drivers/gpu/drm/xe/xe_gpu_scheduler.c
@@ -8,7 +8,8 @@
 static void xe_sched_process_msg_queue(struct xe_gpu_scheduler *sched)
 {
 	if (!drm_sched_is_stopped(&sched->base))
-		queue_work(sched->base.submit_wq, &sched->work_process_msg);
+		drm_sched_queue_work(sched->base.submit_worker,
+				     &sched->work_process_msg);
 }
 
 static void xe_sched_process_msg_queue_if_ready(struct xe_gpu_scheduler *sched)
@@ -37,7 +38,7 @@ xe_sched_get_msg(struct xe_gpu_scheduler *sched)
 	return msg;
 }
 
-static void xe_sched_process_msg_work(struct work_struct *w)
+static void xe_sched_process_msg_work(struct drm_sched_work *w)
 {
 	struct xe_gpu_scheduler *sched =
 		container_of(w, struct xe_gpu_scheduler, work_process_msg);
@@ -57,7 +58,7 @@ static void xe_sched_process_msg_work(struct work_struct *w)
 int xe_sched_init(struct xe_gpu_scheduler *sched,
 		  const struct drm_sched_backend_ops *ops,
 		  const struct xe_sched_backend_ops *xe_ops,
-		  struct workqueue_struct *submit_wq,
+		  struct drm_sched_worker *submit_worker,
 		  uint32_t hw_submission, unsigned hang_limit,
 		  long timeout, struct workqueue_struct *timeout_wq,
 		  atomic_t *score, const char *name,
@@ -65,7 +66,7 @@ int xe_sched_init(struct xe_gpu_scheduler *sched,
 {
 	const struct drm_sched_init_args args = {
 		.ops = ops,
-		.submit_wq = submit_wq,
+		.submit_worker = submit_worker,
 		.credit_limit = hw_submission,
 		.hang_limit = hang_limit,
 		.timeout = timeout,
@@ -78,7 +79,8 @@ int xe_sched_init(struct xe_gpu_scheduler *sched,
 	sched->ops = xe_ops;
 	spin_lock_init(&sched->msg_lock);
 	INIT_LIST_HEAD(&sched->msgs);
-	INIT_WORK(&sched->work_process_msg, xe_sched_process_msg_work);
+	drm_sched_init_work(&sched->work_process_msg,
+			    xe_sched_process_msg_work);
 
 	return drm_sched_init(&sched->base, &args);
 }
@@ -92,13 +94,14 @@ void xe_sched_fini(struct xe_gpu_scheduler *sched)
 void xe_sched_submission_start(struct xe_gpu_scheduler *sched)
 {
 	drm_sched_submission_start(&sched->base);
-	queue_work(sched->base.submit_wq, &sched->work_process_msg);
+	drm_sched_queue_work(sched->base.submit_worker,
+			     &sched->work_process_msg);
 }
 
 void xe_sched_submission_stop(struct xe_gpu_scheduler *sched)
 {
 	drm_sched_submission_stop(&sched->base);
-	cancel_work_sync(&sched->work_process_msg);
+	drm_sched_cancel_work_sync(&sched->work_process_msg);
 }
 
 void xe_sched_submission_resume_tdr(struct xe_gpu_scheduler *sched)
diff --git a/drivers/gpu/drm/xe/xe_gpu_scheduler.h b/drivers/gpu/drm/xe/xe_gpu_scheduler.h
index 664c2db56af3..0c957d0eb152 100644
--- a/drivers/gpu/drm/xe/xe_gpu_scheduler.h
+++ b/drivers/gpu/drm/xe/xe_gpu_scheduler.h
@@ -12,7 +12,7 @@
 int xe_sched_init(struct xe_gpu_scheduler *sched,
 		  const struct drm_sched_backend_ops *ops,
 		  const struct xe_sched_backend_ops *xe_ops,
-		  struct workqueue_struct *submit_wq,
+		  struct drm_sched_worker *submit_work,
 		  uint32_t hw_submission, unsigned hang_limit,
 		  long timeout, struct workqueue_struct *timeout_wq,
 		  atomic_t *score, const char *name,
diff --git a/drivers/gpu/drm/xe/xe_gpu_scheduler_types.h b/drivers/gpu/drm/xe/xe_gpu_scheduler_types.h
index 63d9bf92583c..44f727b7c1a8 100644
--- a/drivers/gpu/drm/xe/xe_gpu_scheduler_types.h
+++ b/drivers/gpu/drm/xe/xe_gpu_scheduler_types.h
@@ -50,7 +50,7 @@ struct xe_gpu_scheduler {
 	/** @msg_lock: Message lock */
 	spinlock_t				msg_lock;
 	/** @work_process_msg: processes messages */
-	struct work_struct		work_process_msg;
+	struct drm_sched_work			work_process_msg;
 };
 
 #define xe_sched_entity		drm_sched_entity
diff --git a/drivers/gpu/drm/xe/xe_gt.c b/drivers/gpu/drm/xe/xe_gt.c
index fb2db9eff341..3c6634237509 100644
--- a/drivers/gpu/drm/xe/xe_gt.c
+++ b/drivers/gpu/drm/xe/xe_gt.c
@@ -706,7 +706,7 @@ static void xe_gt_fini(void *arg)
 	for (i = 0; i < XE_ENGINE_CLASS_MAX; ++i)
 		xe_hw_fence_irq_finish(&gt->fence_irq[i]);
 
-	destroy_workqueue(gt->submit_wq);
+	drm_sched_destroy_worker(gt->submit_worker);
 
 	xe_gt_disable_host_l2_vram(gt);
 }
@@ -718,10 +718,10 @@ int xe_gt_init(struct xe_gt *gt)
 
 	INIT_WORK(&gt->reset.worker, gt_reset_worker);
 
-	gt->submit_wq = alloc_ordered_workqueue("xe-submit-gt%u",
-						WQ_MEM_RECLAIM, gt->info.id);
-	if (IS_ERR(gt->submit_wq))
-		return PTR_ERR(gt->submit_wq);
+	gt->submit_worker = drm_sched_create_ordered_worker("xe-submit-gt%u",
+							    gt->info.id);
+	if (IS_ERR(gt->submit_worker))
+		return PTR_ERR(gt->submit_worker);
 
 	for (i = 0; i < XE_ENGINE_CLASS_MAX; ++i) {
 		gt->ring_ops[i] = xe_ring_ops_get(gt, i);
diff --git a/drivers/gpu/drm/xe/xe_gt_types.h b/drivers/gpu/drm/xe/xe_gt_types.h
index 175c42672546..ecf6dfe6f791 100644
--- a/drivers/gpu/drm/xe/xe_gt_types.h
+++ b/drivers/gpu/drm/xe/xe_gt_types.h
@@ -248,8 +248,8 @@ struct xe_gt {
 	/** @exec_queue_ops: submission backend exec queue operations */
 	const struct xe_exec_queue_ops *exec_queue_ops;
 
-	/** @submit_wq: ... */
-	struct workqueue_struct *submit_wq;
+	/** @submit_worker: ... */
+	struct drm_sched_worker *submit_worker;
 
 	/**
 	 * @ring_ops: ring operations for this hw engine (1 per engine class)
diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
index 858f84dc8fed..a5b79486c398 100644
--- a/drivers/gpu/drm/xe/xe_guc_submit.c
+++ b/drivers/gpu/drm/xe/xe_guc_submit.c
@@ -1927,7 +1927,7 @@ static int guc_exec_queue_init(struct xe_exec_queue *q)
 {
 	struct xe_gpu_scheduler *sched;
 	struct xe_guc *guc = exec_queue_to_guc(q);
-	struct workqueue_struct *submit_wq = NULL;
+	struct drm_sched_worker *submit_worker = NULL;
 	struct xe_gt *gt = guc_to_gt(guc);
 	struct xe_guc_exec_queue *ge;
 	long timeout;
@@ -1957,21 +1957,22 @@ static int guc_exec_queue_init(struct xe_exec_queue *q)
 	xe_exec_queue_assign_name(q, q->guc->id);
 
 	/*
-	 * Use primary queue's submit_wq for all secondary queues of a
+	 * Use primary queue's submit worker for all secondary queues of a
 	 * multi queue group. This serialization avoids any locking around
 	 * CGP synchronization with GuC.
 	 */
 	if (xe_exec_queue_is_multi_queue_secondary(q)) {
 		struct xe_exec_queue *primary = xe_exec_queue_multi_queue_primary(q);
 
-		submit_wq = primary->guc->sched.base.submit_wq;
+		submit_worker = primary->guc->sched.base.submit_worker;
 	} else {
-		submit_wq = gt->submit_wq;
+		submit_worker = gt->submit_worker;
 	}
 
 	err = xe_sched_init(&ge->sched, &drm_sched_ops, &xe_sched_ops,
-			    submit_wq, xe_lrc_ring_size() / MAX_JOB_SIZE_BYTES,
-			    64, timeout, gt->ordered_wq, NULL, q->name,
+			    submit_worker,
+			    xe_lrc_ring_size() / MAX_JOB_SIZE_BYTES, 64,
+			    timeout, gt->ordered_wq, NULL, q->name,
 			    gt_to_xe(gt)->drm.dev);
 	if (err)
 		goto err_release_id;
diff --git a/drivers/gpu/drm/xe/xe_tlb_inval.c b/drivers/gpu/drm/xe/xe_tlb_inval.c
index bbd21d393062..bb64f0c1d466 100644
--- a/drivers/gpu/drm/xe/xe_tlb_inval.c
+++ b/drivers/gpu/drm/xe/xe_tlb_inval.c
@@ -112,6 +112,7 @@ static void tlb_inval_fini(struct drm_device *drm, void *arg)
 	struct xe_tlb_inval *tlb_inval = arg;
 
 	xe_tlb_inval_reset(tlb_inval);
+	drm_sched_destroy_worker(tlb_inval->job_worker);
 }
 
 static void primelockdep(struct xe_tlb_inval *tlb_inval)
@@ -152,15 +153,16 @@ int xe_gt_tlb_inval_init_early(struct xe_gt *gt)
 
 	primelockdep(tlb_inval);
 
-	tlb_inval->job_wq = drmm_alloc_ordered_workqueue(&xe->drm,
-							 "gt-tbl-inval-job-wq",
-							 WQ_MEM_RECLAIM);
-	if (IS_ERR(tlb_inval->job_wq))
-		return PTR_ERR(tlb_inval->job_wq);
+	tlb_inval->job_worker = drm_sched_create_ordered_worker("xe-gt%u-tbl-inval",
+								gt->info.id);
+	if (IS_ERR(tlb_inval->job_worker))
+		return PTR_ERR(tlb_inval->job_worker);
 
 	tlb_inval->timeout_wq = gt->ordered_wq;
-	if (IS_ERR(tlb_inval->timeout_wq))
+	if (IS_ERR(tlb_inval->timeout_wq)) {
+		drm_sched_destroy_worker(tlb_inval->job_worker);
 		return PTR_ERR(tlb_inval->timeout_wq);
+	}
 
 	/* XXX: Blindly setting up backend to GuC */
 	xe_guc_tlb_inval_init_early(&gt->uc.guc, tlb_inval);
diff --git a/drivers/gpu/drm/xe/xe_tlb_inval_types.h b/drivers/gpu/drm/xe/xe_tlb_inval_types.h
index 3d1797d186fd..5b8610a1886e 100644
--- a/drivers/gpu/drm/xe/xe_tlb_inval_types.h
+++ b/drivers/gpu/drm/xe/xe_tlb_inval_types.h
@@ -6,6 +6,7 @@
 #ifndef _XE_TLB_INVAL_TYPES_H_
 #define _XE_TLB_INVAL_TYPES_H_
 
+#include <linux/kthread.h>
 #include <linux/workqueue.h>
 #include <linux/dma-fence.h>
 
@@ -107,8 +108,8 @@ struct xe_tlb_inval {
 	 * the timeout interval is over.
 	 */
 	struct delayed_work fence_tdr;
-	/** @job_wq: schedules TLB invalidation jobs */
-	struct workqueue_struct *job_wq;
+	/** @job_worker: schedules TLB invalidation jobs */
+	struct drm_sched_worker *job_worker;
 	/** @tlb_inval.lock: protects TLB invalidation fences */
 	spinlock_t lock;
 	/** @timeout_wq: schedules TLB invalidation fence timeouts */
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 342e28611509..391663360426 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -77,6 +77,52 @@ enum drm_sched_priority {
 
 struct drm_sched_entity_stats;
 
+struct drm_sched_worker {
+	struct workqueue_struct	*worker;
+};
+
+#define drm_sched_work work_struct
+
+#define drm_sched_create_ordered_worker(fmt, ...) \
+({ \
+	struct drm_sched_worker *worker_; \
+	worker_ = kmalloc_obj(typeof(*worker_)); \
+	if (worker_) { \
+		worker_->worker = alloc_ordered_workqueue((fmt), WQ_MEM_RECLAIM, ## __VA_ARGS__); \
+		if (IS_ERR(worker_->worker)) { \
+			kfree(worker_); \
+			worker_ = ERR_CAST(worker_->worker); \
+		} \
+	} else { \
+		worker_ = ERR_PTR(-ENOMEM); \
+	} \
+	worker_; \
+})
+
+#define drm_sched_create_concurrent_worker(fmt, ...) \
+({ \
+	struct drm_sched_worker *worker_; \
+	worker_ = kmalloc_obj(typeof(*worker_)); \
+	if (worker_) { \
+		worker_->worker = alloc_workqueue((fmt), WQ_UNBOUND, 0, ## __VA_ARGS__); \
+		if (IS_ERR(worker_->worker)) { \
+			kfree(worker_); \
+			worker_ = ERR_CAST(worker_->worker); \
+		} \
+	} else { \
+		worker_ = ERR_PTR(-ENOMEM); \
+	} \
+	worker_; \
+})
+
+void drm_sched_destroy_worker(struct drm_sched_worker *worker);
+
+#define drm_sched_init_work		INIT_WORK
+#define drm_sched_queue_work(worker_, work_) \
+	queue_work((struct workqueue_struct *)(worker_), (work_))
+#define drm_sched_flush_work		flush_work
+#define drm_sched_cancel_work_sync	cancel_work_sync
+
 /**
  * struct drm_sched_entity - A wrapper around a job queue (typically
  * attached to the DRM file_priv).
@@ -584,11 +630,11 @@ struct drm_gpu_scheduler {
 	struct drm_sched_rq             rq;
 	wait_queue_head_t		job_scheduled;
 	atomic64_t			job_id_count;
-	struct workqueue_struct		*submit_wq;
+	struct drm_sched_worker		*submit_worker;
 	struct workqueue_struct		*timeout_wq;
 	struct ewma_drm_sched_avgtime   avg_job_us;
-	struct work_struct		work_run_job;
-	struct work_struct		work_free_job;
+	struct drm_sched_work		work_run_job;
+	struct drm_sched_work		work_free_job;
 	struct delayed_work		work_tdr;
 	struct list_head		pending_list;
 	spinlock_t			job_list_lock;
@@ -598,7 +644,7 @@ struct drm_gpu_scheduler {
 	bool				ready;
 	bool				free_guilty;
 	bool				pause_submit;
-	bool				own_submit_wq;
+	bool				own_submit_worker;
 	struct device			*dev;
 };
 
@@ -619,7 +665,7 @@ struct drm_gpu_scheduler {
  */
 struct drm_sched_init_args {
 	const struct drm_sched_backend_ops *ops;
-	struct workqueue_struct *submit_wq;
+	struct drm_sched_worker *submit_worker;
 	struct workqueue_struct *timeout_wq;
 	u32 credit_limit;
 	unsigned int hang_limit;
-- 
2.54.0

