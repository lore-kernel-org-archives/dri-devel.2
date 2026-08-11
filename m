Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB890C5B572
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 13:48:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDA8510EC02;
	Tue, 11 Aug 2026 13:48:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="EGjj2Db6";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F22EA10EBFB;
 Tue, 11 Aug 2026 13:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=uqTn+eEBnzWeXYB2tX+BzNC/py0fiNYcmrQDheipbY8=; b=
 EGjj2Db6K5/8HZkw4Cdp/wNfQ+mTvgePQBiC+PRWzmX4uxMLfdkl7or/AoTElVJrBIQJtCiKz0ZF3
 TLFV7HPpTeS6885Hesyrdop4ozjDDWPKqANcL4W2W24KmxGfbl4KqK7aztwPV1chnk6Zb7xvhPQjZ
 yaEEo2Ql9/JSkFLZfEo2hAZz25Sywv6w//dYyQHRc0ujLdglRCuj5ptyuphICKhNbnHNZ72rVFMW7
 XcrSpnoTJNTr3KAhZHfplab0n37dsXL5MdOi36aaqESOZadu10iJS+4UvuQLgf4p/ScGAZ+EW6Qvs
 W836zEwzOXWqKKX1yXq/IihYo1cDCJgk3A==;
Received: from [90.249.211.112] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wtmpz-00H9rE-1m; Tue, 11 Aug 2026 15:48:15 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH 18/20] Revert "drm/sched: Remove FIFO and RR and simplify to a
 single run queue"
Date: Tue, 11 Aug 2026 14:47:56 +0100
Message-ID: <20260811134758.96339-19-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260811134758.96339-1-tvrtko.ursulin@igalia.com>
References: <20260811134758.96339-1-tvrtko.ursulin@igalia.com>
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

This reverts commit 77a6809f1dc39376116f8d769a0d2630dc95ad79.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    |  23 +++--
 drivers/gpu/drm/scheduler/sched_entity.c   |  29 +++++-
 drivers/gpu/drm/scheduler/sched_internal.h |  12 ++-
 drivers/gpu/drm/scheduler/sched_main.c     | 108 +++++++++++++++++----
 drivers/gpu/drm/scheduler/sched_rq.c       |  73 ++++++++++----
 include/drm/gpu_scheduler.h                |  36 ++++++-
 6 files changed, 224 insertions(+), 57 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index ece7a98ca4f4..1dedaf1698dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -493,22 +493,25 @@ drm_sched_entity_queue_pop(struct drm_sched_entity *entity)
 
 void amdgpu_job_stop_all_jobs_on_sched(struct drm_gpu_scheduler *sched)
 {
-	struct drm_sched_rq *rq = sched->rq;
-	struct drm_sched_entity *s_entity;
 	struct drm_sched_job *s_job;
+	struct drm_sched_entity *s_entity = NULL;
+	int i;
 
 	/* Signal all jobs not yet scheduled */
-	spin_lock(&rq->lock);
-	list_for_each_entry(s_entity, &rq->entities, list) {
-		while ((s_job = drm_sched_entity_queue_pop(s_entity))) {
-			struct drm_sched_fence *s_fence = s_job->s_fence;
+	for (i = DRM_SCHED_PRIORITY_KERNEL; i < sched->num_rqs; i++) {
+		struct drm_sched_rq *rq = sched->sched_rq[i];
+		spin_lock(&rq->lock);
+		list_for_each_entry(s_entity, &rq->entities, list) {
+			while ((s_job = drm_sched_entity_queue_pop(s_entity))) {
+				struct drm_sched_fence *s_fence = s_job->s_fence;
 
-			dma_fence_signal(&s_fence->scheduled);
-			dma_fence_set_error(&s_fence->finished, -EHWPOISON);
-			dma_fence_signal(&s_fence->finished);
+				dma_fence_signal(&s_fence->scheduled);
+				dma_fence_set_error(&s_fence->finished, -EHWPOISON);
+				dma_fence_signal(&s_fence->finished);
+			}
 		}
+		spin_unlock(&rq->lock);
 	}
-	spin_unlock(&rq->lock);
 
 	/* Signal all jobs already scheduled to HW */
 	list_for_each_entry(s_job, &sched->pending_list, list) {
diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index c61c12078629..672b5c57ed8e 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -133,19 +133,37 @@ int drm_sched_entity_init(struct drm_sched_entity *entity,
 	entity->guilty = guilty;
 	entity->priority = priority;
 	entity->last_user = current->group_leader;
+	entity->rq_priority = drm_sched_policy == DRM_SCHED_POLICY_FAIR ?
+			      DRM_SCHED_PRIORITY_KERNEL : priority;
 	entity->num_sched_list = num_sched_list;
 	entity->sched_list = num_sched_list > 1 ? sched_list : NULL;
 	RCU_INIT_POINTER(entity->last_scheduled, NULL);
 	RB_CLEAR_NODE(&entity->rb_tree_node);
 
-	if (!sched_list[0]->rq) {
+	if (!sched_list[0]->sched_rq) {
 		/* Since every entry covered by num_sched_list
 		 * should be non-NULL and therefore we warn drivers
 		 * not to do this and to fix their DRM calling order.
 		 */
 		pr_warn("%s: called with uninitialized scheduler\n", __func__);
 	} else {
-		entity->rq = sched_list[0]->rq;
+		enum drm_sched_priority p = entity->priority;
+
+		/*
+		 * The "priority" of an entity cannot exceed the number of
+		 * run-queues of a scheduler. Protect against num_rqs being 0,
+		 * by converting to signed. Choose the lowest priority
+		 * available.
+		 */
+		if (p >= sched_list[0]->num_user_rqs) {
+			dev_err(sched_list[0]->dev, "entity with out-of-bounds priority:%u num_user_rqs:%u\n",
+				p, sched_list[0]->num_user_rqs);
+			p = max_t(s32,
+				  (s32)sched_list[0]->num_user_rqs - 1,
+				  (s32)DRM_SCHED_PRIORITY_KERNEL);
+			entity->priority = p;
+		}
+		entity->rq = sched_list[0]->sched_rq[entity->rq_priority];
 	}
 
 	init_completion(&entity->entity_idle);
@@ -591,7 +609,7 @@ void drm_sched_entity_select_rq(struct drm_sched_entity *entity)
 
 	spin_lock(&entity->lock);
 	sched = drm_sched_pick_best(entity->sched_list, entity->num_sched_list);
-	rq = sched ? sched->rq : NULL;
+	rq = sched ? sched->sched_rq[entity->rq_priority] : NULL;
 	if (rq != entity->rq) {
 		drm_sched_rq_remove_entity(entity->rq, entity);
 		entity->rq = rq;
@@ -616,6 +634,7 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
 {
 	struct drm_sched_entity *entity = sched_job->entity;
 	bool first;
+	ktime_t submit_ts;
 
 	trace_drm_sched_job_queue(sched_job, entity);
 
@@ -632,14 +651,16 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
 	/*
 	 * After the sched_job is pushed into the entity queue, it may be
 	 * completed and freed up at any time. We can no longer access it.
+	 * Make sure to set the submit_ts first, to avoid a race.
 	 */
+	sched_job->submit_ts = submit_ts = ktime_get();
 	first = spsc_queue_push(&entity->job_queue, &sched_job->queue_node);
 
 	/* first job wakes up scheduler */
 	if (first) {
 		struct drm_gpu_scheduler *sched;
 
-		sched = drm_sched_rq_add_entity(entity);
+		sched = drm_sched_rq_add_entity(entity, submit_ts);
 		if (sched)
 			drm_sched_wakeup(sched);
 	}
diff --git a/drivers/gpu/drm/scheduler/sched_internal.h b/drivers/gpu/drm/scheduler/sched_internal.h
index 28c3f3df4f3a..a901801fce85 100644
--- a/drivers/gpu/drm/scheduler/sched_internal.h
+++ b/drivers/gpu/drm/scheduler/sched_internal.h
@@ -31,6 +31,13 @@ struct drm_sched_entity_stats {
 	struct ewma_drm_sched_avgtime   avg_job_us;
 };
 
+/* Used to choose between FIFO and RR job-scheduling */
+extern int drm_sched_policy;
+
+#define DRM_SCHED_POLICY_RR    0
+#define DRM_SCHED_POLICY_FIFO  1
+#define DRM_SCHED_POLICY_FAIR  2
+
 bool drm_sched_can_queue(struct drm_gpu_scheduler *sched,
 			 struct drm_sched_entity *entity);
 void drm_sched_wakeup(struct drm_gpu_scheduler *sched);
@@ -39,13 +46,14 @@ void drm_sched_rq_init(struct drm_gpu_scheduler *sched,
 		       struct drm_sched_rq *rq);
 
 struct drm_gpu_scheduler *
-drm_sched_rq_add_entity(struct drm_sched_entity *entity);
+drm_sched_rq_add_entity(struct drm_sched_entity *entity, ktime_t ts);
 void drm_sched_rq_remove_entity(struct drm_sched_rq *rq,
 				struct drm_sched_entity *entity);
 void drm_sched_rq_pop_entity(struct drm_sched_entity *entity);
 
 struct drm_sched_entity *
-drm_sched_select_entity(struct drm_gpu_scheduler *sched);
+drm_sched_rq_select_entity(struct drm_gpu_scheduler *sched,
+			   struct drm_sched_rq *rq);
 
 void drm_sched_entity_select_rq(struct drm_sched_entity *entity);
 struct drm_sched_job *drm_sched_entity_pop_job(struct drm_sched_entity *entity);
diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 79e44ccefdc9..8127c93a1718 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -84,6 +84,15 @@
 #define CREATE_TRACE_POINTS
 #include "gpu_scheduler_trace.h"
 
+int drm_sched_policy = DRM_SCHED_POLICY_FAIR;
+
+/**
+ * DOC: sched_policy (int)
+ * Used to override default entities scheduling policy in a run queue.
+ */
+MODULE_PARM_DESC(sched_policy, "Specify the scheduling policy for entities on a run-queue, " __stringify(DRM_SCHED_POLICY_RR) " = Round Robin, " __stringify(DRM_SCHED_POLICY_FIFO) " = FIFO, " __stringify(DRM_SCHED_POLICY_FAIR) " = Fair (default).");
+module_param_named(sched_policy, drm_sched_policy, int, 0444);
+
 static u32 drm_sched_available_credits(struct drm_gpu_scheduler *sched)
 {
 	u32 credits;
@@ -871,6 +880,34 @@ void drm_sched_wakeup(struct drm_gpu_scheduler *sched)
 	drm_sched_run_job_queue(sched);
 }
 
+/**
+ * drm_sched_select_entity - Select next entity to process
+ *
+ * @sched: scheduler instance
+ *
+ * Return an entity to process or NULL if none are found.
+ *
+ * Note, that we break out of the for-loop when "entity" is non-null, which can
+ * also be an error-pointer--this assures we don't process lower priority
+ * run-queues. See comments in the respectively called functions.
+ */
+static struct drm_sched_entity *
+drm_sched_select_entity(struct drm_gpu_scheduler *sched)
+{
+	struct drm_sched_entity *entity = NULL;
+	int i;
+
+	/* Start with the highest priority.
+	 */
+	for (i = DRM_SCHED_PRIORITY_KERNEL; i < sched->num_rqs; i++) {
+		entity = drm_sched_rq_select_entity(sched, sched->sched_rq[i]);
+		if (entity)
+			break;
+	}
+
+	return IS_ERR(entity) ? NULL : entity;
+}
+
 /**
  * drm_sched_get_finished_job - fetch the next finished job to be destroyed
  *
@@ -996,7 +1033,7 @@ static void drm_sched_run_job_work(struct work_struct *w)
 
 	/* Find entity with a ready job */
 	entity = drm_sched_select_entity(sched);
-	if (IS_ERR_OR_NULL(entity)) {
+	if (!entity) {
 		/*
 		 * Either no more work to do, or the next ready job needs more
 		 * credits than the scheduler has currently available.
@@ -1072,6 +1109,8 @@ static struct workqueue_struct *drm_sched_alloc_wq(const char *name)
  */
 int drm_sched_init(struct drm_gpu_scheduler *sched, const struct drm_sched_init_args *args)
 {
+	int i;
+
 	sched->ops = args->ops;
 	sched->credit_limit = args->credit_limit;
 	sched->name = args->name;
@@ -1081,7 +1120,13 @@ int drm_sched_init(struct drm_gpu_scheduler *sched, const struct drm_sched_init_
 	sched->score = args->score ? args->score : &sched->_score;
 	sched->dev = args->dev;
 
-	if (sched->rq) {
+	if (args->num_rqs > DRM_SCHED_PRIORITY_COUNT) {
+		/* This is a gross violation--tell drivers what the  problem is.
+		 */
+		dev_err(sched->dev, "%s: num_rqs cannot be greater than DRM_SCHED_PRIORITY_COUNT\n",
+			__func__);
+		return -EINVAL;
+	} else if (sched->sched_rq) {
 		/* Not an error, but warn anyway so drivers can
 		 * fine-tune their DRM calling order, and return all
 		 * is good.
@@ -1101,11 +1146,19 @@ int drm_sched_init(struct drm_gpu_scheduler *sched, const struct drm_sched_init_
 		sched->own_submit_wq = true;
 	}
 
-	sched->rq = kzalloc_obj(*sched->rq);
-	if (!sched->rq)
+	sched->num_user_rqs = args->num_rqs;
+	sched->num_rqs = drm_sched_policy != DRM_SCHED_POLICY_FAIR ?
+			 args->num_rqs : 1;
+	sched->sched_rq = kzalloc_objs(*sched->sched_rq, args->num_rqs);
+	if (!sched->sched_rq)
 		goto Out_check_own;
 
-	drm_sched_rq_init(sched, sched->rq);
+	for (i = DRM_SCHED_PRIORITY_KERNEL; i < sched->num_rqs; i++) {
+		sched->sched_rq[i] = kzalloc_obj(*sched->sched_rq[i]);
+		if (!sched->sched_rq[i])
+			goto Out_unroll;
+		drm_sched_rq_init(sched, sched->sched_rq[i]);
+	}
 
 	init_waitqueue_head(&sched->job_scheduled);
 	INIT_LIST_HEAD(&sched->pending_list);
@@ -1121,7 +1174,12 @@ int drm_sched_init(struct drm_gpu_scheduler *sched, const struct drm_sched_init_
 
 	sched->ready = true;
 	return 0;
+Out_unroll:
+	for (--i ; i >= DRM_SCHED_PRIORITY_KERNEL; i--)
+		kfree(sched->sched_rq[i]);
 
+	kfree(sched->sched_rq);
+	sched->sched_rq = NULL;
 Out_check_own:
 	if (sched->own_submit_wq)
 		destroy_workqueue(sched->submit_wq);
@@ -1157,8 +1215,13 @@ static void drm_sched_cancel_remaining_jobs(struct drm_gpu_scheduler *sched)
  */
 void drm_sched_fini(struct drm_gpu_scheduler *sched)
 {
+	int i;
+
 	drm_sched_wqueue_stop(sched);
 
+	for (i = DRM_SCHED_PRIORITY_KERNEL; i < sched->num_rqs; i++)
+		kfree(sched->sched_rq[i]);
+
 	/* Wakeup everyone stuck in drm_sched_entity_flush for this scheduler */
 	wake_up_all(&sched->job_scheduled);
 
@@ -1172,8 +1235,8 @@ void drm_sched_fini(struct drm_gpu_scheduler *sched)
 	if (sched->own_submit_wq)
 		destroy_workqueue(sched->submit_wq);
 	sched->ready = false;
-	kfree(sched->rq);
-	sched->rq = NULL;
+	kfree(sched->sched_rq);
+	sched->sched_rq = NULL;
 
 	if (!list_empty(&sched->pending_list))
 		dev_warn(sched->dev, "Tearing down scheduler while jobs are pending!\n");
@@ -1191,28 +1254,35 @@ EXPORT_SYMBOL(drm_sched_fini);
  */
 void drm_sched_increase_karma(struct drm_sched_job *bad)
 {
+	int i;
+	struct drm_sched_entity *tmp;
+	struct drm_sched_entity *entity;
 	struct drm_gpu_scheduler *sched = bad->sched;
-	struct drm_sched_entity *entity, *tmp;
-	struct drm_sched_rq *rq = sched->rq;
 
 	/* don't change @bad's karma if it's from KERNEL RQ,
 	 * because sometimes GPU hang would cause kernel jobs (like VM updating jobs)
 	 * corrupt but keep in mind that kernel jobs always considered good.
 	 */
-	if (bad->s_priority == DRM_SCHED_PRIORITY_KERNEL)
-		return;
+	if (bad->s_priority != DRM_SCHED_PRIORITY_KERNEL) {
+		atomic_inc(&bad->karma);
 
-	atomic_inc(&bad->karma);
+		for (i = DRM_SCHED_PRIORITY_KERNEL; i < sched->num_rqs; i++) {
+			struct drm_sched_rq *rq = sched->sched_rq[i];
 
-	spin_lock(&rq->lock);
-	list_for_each_entry_safe(entity, tmp, &rq->entities, list) {
-		if (bad->s_fence->scheduled.context == entity->fence_context) {
-			if (entity->guilty)
-				atomic_set(entity->guilty, 1);
-			break;
+			spin_lock(&rq->lock);
+			list_for_each_entry_safe(entity, tmp, &rq->entities, list) {
+				if (bad->s_fence->scheduled.context ==
+				    entity->fence_context) {
+					if (entity->guilty)
+						atomic_set(entity->guilty, 1);
+					break;
+				}
+			}
+			spin_unlock(&rq->lock);
+			if (&entity->list != &rq->entities)
+				break;
 		}
 	}
-	spin_unlock(&rq->lock);
 }
 EXPORT_SYMBOL(drm_sched_increase_karma);
 
diff --git a/drivers/gpu/drm/scheduler/sched_rq.c b/drivers/gpu/drm/scheduler/sched_rq.c
index aeeed6f3901d..0464d324d98d 100644
--- a/drivers/gpu/drm/scheduler/sched_rq.c
+++ b/drivers/gpu/drm/scheduler/sched_rq.c
@@ -49,7 +49,7 @@ static void drm_sched_rq_update_prio(struct drm_sched_rq *rq)
 	rq->head_prio = prio;
 }
 
-static void drm_sched_rq_remove_tree_locked(struct drm_sched_entity *entity,
+static void drm_sched_rq_remove_fifo_locked(struct drm_sched_entity *entity,
 					    struct drm_sched_rq *rq)
 {
 	lockdep_assert_held(&entity->lock);
@@ -62,7 +62,7 @@ static void drm_sched_rq_remove_tree_locked(struct drm_sched_entity *entity,
 	}
 }
 
-static void drm_sched_rq_update_tree_locked(struct drm_sched_entity *entity,
+static void drm_sched_rq_update_fifo_locked(struct drm_sched_entity *entity,
 					    struct drm_sched_rq *rq,
 					    ktime_t ts)
 {
@@ -74,7 +74,7 @@ static void drm_sched_rq_update_tree_locked(struct drm_sched_entity *entity,
 	lockdep_assert_held(&entity->lock);
 	lockdep_assert_held(&rq->lock);
 
-	drm_sched_rq_remove_tree_locked(entity, rq);
+	drm_sched_rq_remove_fifo_locked(entity, rq);
 
 	entity->oldest_job_waiting = ts;
 
@@ -239,9 +239,15 @@ static ktime_t drm_sched_entity_update_vruntime(struct drm_sched_entity *entity)
 	return runtime;
 }
 
+static ktime_t drm_sched_entity_get_job_ts(struct drm_sched_entity *entity)
+{
+	return drm_sched_entity_update_vruntime(entity);
+}
+
 /**
  * drm_sched_rq_add_entity - add an entity
  * @entity: scheduler entity
+ * @ts: submission timestamp
  *
  * Adds a scheduler entity to the run queue.
  *
@@ -249,11 +255,10 @@ static ktime_t drm_sched_entity_update_vruntime(struct drm_sched_entity *entity)
  * been stopped and cannot be submitted to.
  */
 struct drm_gpu_scheduler *
-drm_sched_rq_add_entity(struct drm_sched_entity *entity)
+drm_sched_rq_add_entity(struct drm_sched_entity *entity, ktime_t ts)
 {
 	struct drm_gpu_scheduler *sched;
 	struct drm_sched_rq *rq;
-	ktime_t ts;
 
 	/* Add the entity to the run queue */
 	spin_lock(&entity->lock);
@@ -273,9 +278,15 @@ drm_sched_rq_add_entity(struct drm_sched_entity *entity)
 		list_add_tail(&entity->list, &rq->entities);
 	}
 
-	ts = drm_sched_rq_get_min_vruntime(rq);
-	ts = drm_sched_entity_restore_vruntime(entity, ts, rq->head_prio);
-	drm_sched_rq_update_tree_locked(entity, rq, ts);
+	if (drm_sched_policy == DRM_SCHED_POLICY_FAIR) {
+		ts = drm_sched_rq_get_min_vruntime(rq);
+		ts = drm_sched_entity_restore_vruntime(entity, ts,
+						       rq->head_prio);
+	} else if (drm_sched_policy == DRM_SCHED_POLICY_RR) {
+		ts = entity->rr_ts;
+	}
+
+	drm_sched_rq_update_fifo_locked(entity, rq, ts);
 
 	spin_unlock(&rq->lock);
 	spin_unlock(&entity->lock);
@@ -303,11 +314,27 @@ void drm_sched_rq_remove_entity(struct drm_sched_rq *rq,
 	atomic_dec(rq->sched->score);
 	list_del_init(&entity->list);
 
-	drm_sched_rq_remove_tree_locked(entity, rq);
+	drm_sched_rq_remove_fifo_locked(entity, rq);
 
 	spin_unlock(&rq->lock);
 }
 
+static ktime_t
+drm_sched_rq_next_rr_ts(struct drm_sched_rq *rq,
+			struct drm_sched_entity *entity)
+{
+	ktime_t ts;
+
+	lockdep_assert_held(&entity->lock);
+	lockdep_assert_held(&rq->lock);
+
+	ts = ktime_add_ns(rq->rr_ts, 1);
+	entity->rr_ts = ts;
+	rq->rr_ts = ts;
+
+	return ts;
+}
+
 /**
  * drm_sched_rq_pop_entity - pops an entity
  * @entity: scheduler entity
@@ -330,22 +357,32 @@ void drm_sched_rq_pop_entity(struct drm_sched_entity *entity)
 	if (next_job) {
 		ktime_t ts;
 
-		ts = drm_sched_entity_update_vruntime(entity);
-		drm_sched_rq_update_tree_locked(entity, rq, ts);
+		if (drm_sched_policy == DRM_SCHED_POLICY_FAIR)
+			ts = drm_sched_entity_get_job_ts(entity);
+		else if (drm_sched_policy == DRM_SCHED_POLICY_FIFO)
+			ts = next_job->submit_ts;
+		else
+			ts = drm_sched_rq_next_rr_ts(rq, entity);
+
+		drm_sched_rq_update_fifo_locked(entity, rq, ts);
 	} else {
-		ktime_t min_vruntime;
+		drm_sched_rq_remove_fifo_locked(entity, rq);
 
-		drm_sched_rq_remove_tree_locked(entity, rq);
-		min_vruntime = drm_sched_rq_get_min_vruntime(rq);
-		drm_sched_entity_save_vruntime(entity, min_vruntime);
+		if (drm_sched_policy == DRM_SCHED_POLICY_FAIR) {
+			ktime_t min_vruntime;
+
+			min_vruntime = drm_sched_rq_get_min_vruntime(rq);
+			drm_sched_entity_save_vruntime(entity, min_vruntime);
+		}
 	}
 	spin_unlock(&rq->lock);
 	spin_unlock(&entity->lock);
 }
 
 /**
- * drm_sched_select_entity - Select an entity which provides a job to run
+ * drm_sched_rq_select_entity - Select an entity which provides a job to run
  * @sched: the gpu scheduler
+ * @rq: scheduler run queue to check.
  *
  * Find oldest waiting ready entity.
  *
@@ -354,9 +391,9 @@ void drm_sched_rq_pop_entity(struct drm_sched_entity *entity)
  * its job; return NULL, if no ready entity was found.
  */
 struct drm_sched_entity *
-drm_sched_select_entity(struct drm_gpu_scheduler *sched)
+drm_sched_rq_select_entity(struct drm_gpu_scheduler *sched,
+			   struct drm_sched_rq *rq)
 {
-	struct drm_sched_rq *rq = sched->rq;
 	struct rb_node *rb;
 
 	spin_lock(&rq->lock);
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index dcda25f6f4eb..7a64cc11de08 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -100,7 +100,8 @@ struct drm_sched_entity {
 	 * @lock:
 	 *
 	 * Lock protecting the run-queue (@rq) to which this entity belongs,
-	 * @priority and the list of schedulers (@sched_list, @num_sched_list).
+	 * @priority, the list of schedulers (@sched_list, @num_sched_list) and
+	 * the @rr_ts field.
 	 */
 	spinlock_t			lock;
 
@@ -153,6 +154,18 @@ struct drm_sched_entity {
 	 */
 	enum drm_sched_priority         priority;
 
+	/**
+	 * @rq_priority: Run-queue priority
+	 */
+	enum drm_sched_priority         rq_priority;
+
+	/**
+	 * @rr_ts:
+	 *
+	 * Fake timestamp of the last popped job from the entity.
+	 */
+	ktime_t				rr_ts;
+
 	/**
 	 * @job_queue: the list of jobs of this entity.
 	 */
@@ -249,7 +262,8 @@ struct drm_sched_entity {
  * struct drm_sched_rq - queue of entities to be scheduled.
  *
  * @sched: the scheduler to which this rq belongs to.
- * @lock: protects @entities, @rb_tree_root and @head_prio.
+ * @lock: protects @entities, @rb_tree_root, @rr_ts and @head_prio.
+ * @rr_ts: monotonically incrementing fake timestamp for RR mode.
  * @entities: list of the entities to be scheduled.
  * @rb_tree_root: root of time based priority queue of entities for FIFO scheduling
  * @head_prio: priority of the top tree element.
@@ -263,6 +277,7 @@ struct drm_sched_rq {
 
 	spinlock_t			lock;
 	/* Following members are protected by the @lock: */
+	ktime_t				rr_ts;
 	struct list_head		entities;
 	struct rb_root_cached		rb_tree_root;
 	enum drm_sched_priority		head_prio;
@@ -348,6 +363,13 @@ struct drm_sched_fence *to_drm_sched_fence(struct dma_fence *f);
  * to schedule the job.
  */
 struct drm_sched_job {
+	/**
+	 * @submit_ts:
+	 *
+	 * When the job was pushed into the entity queue.
+	 */
+	ktime_t                         submit_ts;
+
 	/**
 	 * @sched:
 	 *
@@ -551,7 +573,11 @@ struct drm_sched_backend_ops {
  * @credit_count: the current credit count of this scheduler
  * @timeout: the time after which a job is removed from the scheduler.
  * @name: name of the ring for which this scheduler is being used.
- * @rq: Scheduler run queue.
+ * @num_user_rqs: Number of run-queues. This is at most
+ *                DRM_SCHED_PRIORITY_COUNT, as there's usually one run-queue per
+ *                priority, but could be less.
+ * @num_rqs: Equal to @num_user_rqs for FIFO and RR and 1 for the FAIR policy.
+ * @sched_rq: An allocated array of run-queues of size @num_rqs;
  * @job_scheduled: once drm_sched_entity_flush() is called the scheduler
  *                 waits on this wait queue until all the scheduled jobs are
  *                 finished.
@@ -583,7 +609,9 @@ struct drm_gpu_scheduler {
 	atomic_t			credit_count;
 	long				timeout;
 	const char			*name;
-	struct drm_sched_rq             *rq;
+	u32                             num_rqs;
+	u32                             num_user_rqs;
+	struct drm_sched_rq             **sched_rq;
 	wait_queue_head_t		job_scheduled;
 	atomic64_t			job_id_count;
 	struct workqueue_struct		*submit_wq;
-- 
2.54.0

