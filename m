Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E197DC5CFE7
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 13:48:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32EC610EC05;
	Tue, 11 Aug 2026 13:48:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="rECSj4+o";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20DF710EBFB;
 Tue, 11 Aug 2026 13:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=jEqJd21jXzseJhZqlUEavCTCmSvtlgazaRgWRINXv7w=; b=
 rECSj4+o4kzojSD8mQfsdENtarVnwm6hMTMQQOOYmjvIHnOoMWIuy0KVEEGUUbmEW3hNCclvQPlj5
 8y34UTwgL32w850i6nbtCGXyL8tZ5aQIVcd4Cz4cWUgznvHCr2qIlVoHyeh6qEMogcOeBaOhUXvdc
 MIdQoOkiPoEE/137MOkOE6J3j/DdyTr950DhFIBF75+qrFNLAeUKZRzD2yiuuyTX0gC4iOVe+Y+CL
 eSony3R1/djFh11l0FzAOELwJEKN/l8+nbwzwbkdsIj8xtkZpt6int7T6d3dlZDsCSVkL+CKeTDt8
 bS05Y4M+PlMwicJXwksmQcRoDx5/JydSHQ==;
Received: from [90.249.211.112] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wtmpy-00H9qz-8i; Tue, 11 Aug 2026 15:48:14 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH 17/20] Revert "drm/sched: Embed run queue singleton into the
 scheduler"
Date: Tue, 11 Aug 2026 14:47:55 +0100
Message-ID: <20260811134758.96339-18-tvrtko.ursulin@igalia.com>
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

This reverts commit 16e7698bc04d3dd19d95a688e4b0297a0e28a93b.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c      |  6 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  6 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     |  5 +---
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h   |  8 ++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c |  8 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c     |  4 +--
 drivers/gpu/drm/scheduler/sched_entity.c    | 29 +++++++++++++--------
 drivers/gpu/drm/scheduler/sched_fence.c     |  2 +-
 drivers/gpu/drm/scheduler/sched_internal.h  |  3 ++-
 drivers/gpu/drm/scheduler/sched_main.c      | 27 ++++++++++++++++---
 drivers/gpu/drm/scheduler/sched_rq.c        | 16 ++++++------
 include/drm/gpu_scheduler.h                 |  5 +++-
 12 files changed, 70 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 47a45d0451fd..3e90a40f3a6a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1116,8 +1116,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 	if (p->gang_size > 1 && !adev->vm_manager.concurrent_flush) {
 		for (i = 0; i < p->gang_size; ++i) {
 			struct drm_sched_entity *entity = p->entities[i];
-			struct drm_gpu_scheduler *sched =
-				container_of(entity->rq, typeof(*sched), rq);
+			struct drm_gpu_scheduler *sched = entity->rq->sched;
 			struct amdgpu_ring *ring = to_amdgpu_ring(sched);
 
 			if (amdgpu_vmid_uses_reserved(vm, ring->vm_hub))
@@ -1235,8 +1234,7 @@ static int amdgpu_cs_sync_rings(struct amdgpu_cs_parser *p)
 			return r;
 	}
 
-	sched = container_of(p->gang_leader->base.entity->rq, typeof(*sched),
-			     rq);
+	sched = p->gang_leader->base.entity->rq->sched;
 	while ((fence = amdgpu_sync_get_fence(&p->sync))) {
 		struct drm_sched_fence *s_fence = to_drm_sched_fence(fence);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index d97cf1212e0f..ece7a98ca4f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -400,9 +400,7 @@ static struct dma_fence *
 amdgpu_job_prepare_job(struct drm_sched_job *sched_job,
 		      struct drm_sched_entity *s_entity)
 {
-	struct drm_gpu_scheduler *sched =
-		container_of(s_entity->rq, typeof(*sched), rq);
-	struct amdgpu_ring *ring = to_amdgpu_ring(sched);
+	struct amdgpu_ring *ring = to_amdgpu_ring(s_entity->rq->sched);
 	struct amdgpu_job *job = to_amdgpu_job(sched_job);
 	struct dma_fence *fence;
 	int r;
@@ -495,7 +493,7 @@ drm_sched_entity_queue_pop(struct drm_sched_entity *entity)
 
 void amdgpu_job_stop_all_jobs_on_sched(struct drm_gpu_scheduler *sched)
 {
-	struct drm_sched_rq *rq = &sched->rq;
+	struct drm_sched_rq *rq = sched->rq;
 	struct drm_sched_entity *s_entity;
 	struct drm_sched_job *s_job;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
index 7e03bd2ff639..44fe40f9e8df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -107,10 +107,7 @@ struct amdgpu_job {
 
 static inline struct amdgpu_ring *amdgpu_job_ring(struct amdgpu_job *job)
 {
-	struct drm_gpu_scheduler *sched =
-		container_of(job->base.entity->rq, typeof(*sched), rq);
-
-	return to_amdgpu_ring(sched);
+	return to_amdgpu_ring(job->base.entity->rq->sched);
 }
 
 int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
index 5324030a13f5..fcd4cf2f4cd8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
@@ -147,7 +147,6 @@ TRACE_EVENT(amdgpu_cs,
 		     struct amdgpu_ib *ib),
 	    TP_ARGS(p, job, ib),
 	    TP_STRUCT__entry(
-			     __field(struct drm_gpu_scheduler *, sched)
 			     __field(struct amdgpu_bo_list *, bo_list)
 			     __field(u32, ring)
 			     __field(u32, dw)
@@ -155,14 +154,11 @@ TRACE_EVENT(amdgpu_cs,
 			     ),
 
 	    TP_fast_assign(
-			   __entry->sched = container_of(job->base.entity->rq,
-							 typeof(*__entry->sched),
-							 rq);
 			   __entry->bo_list = p->bo_list;
-			   __entry->ring = to_amdgpu_ring(__entry->sched)->idx;
+			   __entry->ring = to_amdgpu_ring(job->base.entity->rq->sched)->idx;
 			   __entry->dw = ib->length_dw;
 			   __entry->fences = amdgpu_fence_count_emitted(
-				to_amdgpu_ring(__entry->sched));
+				to_amdgpu_ring(job->base.entity->rq->sched));
 			   ),
 	    TP_printk("bo_list=%p, ring=%u, dw=%u, fences=%u",
 		      __entry->bo_list, __entry->ring, __entry->dw,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
index 430274237689..50cc0779c340 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
@@ -106,13 +106,13 @@ static int amdgpu_vm_sdma_prepare(struct amdgpu_vm_update_params *p,
 static int amdgpu_vm_sdma_commit(struct amdgpu_vm_update_params *p,
 				 struct dma_fence **fence)
 {
-	struct drm_gpu_scheduler *sched =
-		container_of(p->vm->delayed.rq, typeof(*sched), rq);
-	struct amdgpu_ring *ring =
-		container_of(sched, struct amdgpu_ring, sched);
 	struct amdgpu_ib *ib = p->job->ibs;
+	struct amdgpu_ring *ring;
 	struct dma_fence *f;
 
+	ring = container_of(p->vm->delayed.rq->sched, struct amdgpu_ring,
+			    sched);
+
 	WARN_ON(ib->length_dw == 0);
 	amdgpu_ring_pad_ib(ring, ib);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index 35faea0ff17f..b15af318784b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -467,13 +467,13 @@ int amdgpu_xcp_open_device(struct amdgpu_device *adev,
 void amdgpu_xcp_release_sched(struct amdgpu_device *adev,
 				  struct amdgpu_ctx_entity *entity)
 {
-	struct drm_gpu_scheduler *sched =
-		container_of(entity->entity.rq, typeof(*sched), rq);
 	struct amdgpu_xcp_mgr *xcp_mgr = adev->xcp_mgr;
+	struct drm_gpu_scheduler *sched;
 
 	if (!xcp_mgr)
 		return;
 
+	sched = entity->entity.rq->sched;
 	if (drm_sched_wqueue_ready(sched)) {
 		struct amdgpu_ring *ring = to_amdgpu_ring(sched);
 
diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 4ebb513255ed..c61c12078629 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -135,9 +135,19 @@ int drm_sched_entity_init(struct drm_sched_entity *entity,
 	entity->last_user = current->group_leader;
 	entity->num_sched_list = num_sched_list;
 	entity->sched_list = num_sched_list > 1 ? sched_list : NULL;
-	entity->rq = &sched_list[0]->rq;
 	RCU_INIT_POINTER(entity->last_scheduled, NULL);
 	RB_CLEAR_NODE(&entity->rb_tree_node);
+
+	if (!sched_list[0]->rq) {
+		/* Since every entry covered by num_sched_list
+		 * should be non-NULL and therefore we warn drivers
+		 * not to do this and to fix their DRM calling order.
+		 */
+		pr_warn("%s: called with uninitialized scheduler\n", __func__);
+	} else {
+		entity->rq = sched_list[0]->rq;
+	}
+
 	init_completion(&entity->entity_idle);
 
 	/* We start in an idle state. */
@@ -336,7 +346,7 @@ long drm_sched_entity_flush(struct drm_sched_entity *entity, long timeout)
 	if (!entity->rq)
 		return 0;
 
-	sched = container_of(entity->rq, typeof(*sched), rq);
+	sched = entity->rq->sched;
 	/*
 	 * The client will not queue more jobs during this fini - consume
 	 * existing queued ones, or discard them on SIGKILL.
@@ -417,12 +427,10 @@ static void drm_sched_entity_wakeup(struct dma_fence *f,
 {
 	struct drm_sched_entity *entity =
 		container_of(cb, struct drm_sched_entity, cb);
-	struct drm_gpu_scheduler *sched =
-		container_of(entity->rq, typeof(*sched), rq);
 
 	entity->dependency = NULL;
 	dma_fence_put(f);
-	drm_sched_wakeup(sched);
+	drm_sched_wakeup(entity->rq->sched);
 }
 
 /**
@@ -449,8 +457,7 @@ EXPORT_SYMBOL(drm_sched_entity_set_priority);
 static bool drm_sched_entity_add_dependency_cb(struct drm_sched_entity *entity,
 					       struct drm_sched_job *sched_job)
 {
-	struct drm_gpu_scheduler *sched =
-		container_of(entity->rq, typeof(*sched), rq);
+	struct drm_gpu_scheduler *sched = entity->rq->sched;
 	struct dma_fence *fence = entity->dependency;
 	struct drm_sched_fence *s_fence;
 
@@ -584,7 +591,7 @@ void drm_sched_entity_select_rq(struct drm_sched_entity *entity)
 
 	spin_lock(&entity->lock);
 	sched = drm_sched_pick_best(entity->sched_list, entity->num_sched_list);
-	rq = sched ? &sched->rq : NULL;
+	rq = sched ? sched->rq : NULL;
 	if (rq != entity->rq) {
 		drm_sched_rq_remove_entity(entity->rq, entity);
 		entity->rq = rq;
@@ -608,8 +615,6 @@ void drm_sched_entity_select_rq(struct drm_sched_entity *entity)
 void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
 {
 	struct drm_sched_entity *entity = sched_job->entity;
-	struct drm_gpu_scheduler *sched =
-		container_of(entity->rq, typeof(*sched), rq);
 	bool first;
 
 	trace_drm_sched_job_queue(sched_job, entity);
@@ -621,7 +626,7 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
 		xa_for_each(&sched_job->dependencies, index, entry)
 			trace_drm_sched_job_add_dep(sched_job, entry);
 	}
-	atomic_inc(sched->score);
+	atomic_inc(entity->rq->sched->score);
 	WRITE_ONCE(entity->last_user, current->group_leader);
 
 	/*
@@ -632,6 +637,8 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
 
 	/* first job wakes up scheduler */
 	if (first) {
+		struct drm_gpu_scheduler *sched;
+
 		sched = drm_sched_rq_add_entity(entity);
 		if (sched)
 			drm_sched_wakeup(sched);
diff --git a/drivers/gpu/drm/scheduler/sched_fence.c b/drivers/gpu/drm/scheduler/sched_fence.c
index 85ee3d694dc9..096fe28aa9c9 100644
--- a/drivers/gpu/drm/scheduler/sched_fence.c
+++ b/drivers/gpu/drm/scheduler/sched_fence.c
@@ -227,7 +227,7 @@ void drm_sched_fence_init(struct drm_sched_fence *fence,
 {
 	unsigned seq;
 
-	fence->sched = container_of(entity->rq, typeof(*fence->sched), rq);
+	fence->sched = entity->rq->sched;
 	seq = atomic_inc_return(&entity->fence_seq);
 	dma_fence_init(&fence->scheduled, &drm_sched_fence_ops_scheduled,
 		       &fence->lock, entity->fence_context, seq);
diff --git a/drivers/gpu/drm/scheduler/sched_internal.h b/drivers/gpu/drm/scheduler/sched_internal.h
index 13ecb771d7a2..28c3f3df4f3a 100644
--- a/drivers/gpu/drm/scheduler/sched_internal.h
+++ b/drivers/gpu/drm/scheduler/sched_internal.h
@@ -35,7 +35,8 @@ bool drm_sched_can_queue(struct drm_gpu_scheduler *sched,
 			 struct drm_sched_entity *entity);
 void drm_sched_wakeup(struct drm_gpu_scheduler *sched);
 
-void drm_sched_rq_init(struct drm_sched_rq *rq);
+void drm_sched_rq_init(struct drm_gpu_scheduler *sched,
+		       struct drm_sched_rq *rq);
 
 struct drm_gpu_scheduler *
 drm_sched_rq_add_entity(struct drm_sched_entity *entity);
diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 818d3d4434b5..79e44ccefdc9 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -648,7 +648,7 @@ void drm_sched_job_arm(struct drm_sched_job *job)
 
 	BUG_ON(!entity);
 	drm_sched_entity_select_rq(entity);
-	sched = container_of(entity->rq, typeof(*sched), rq);
+	sched = entity->rq->sched;
 
 	job->sched = sched;
 	job->s_priority = entity->priority;
@@ -1081,6 +1081,15 @@ int drm_sched_init(struct drm_gpu_scheduler *sched, const struct drm_sched_init_
 	sched->score = args->score ? args->score : &sched->_score;
 	sched->dev = args->dev;
 
+	if (sched->rq) {
+		/* Not an error, but warn anyway so drivers can
+		 * fine-tune their DRM calling order, and return all
+		 * is good.
+		 */
+		dev_warn(sched->dev, "%s: scheduler already initialized!\n", __func__);
+		return 0;
+	}
+
 	if (args->submit_wq) {
 		sched->submit_wq = args->submit_wq;
 		sched->own_submit_wq = false;
@@ -1092,7 +1101,11 @@ int drm_sched_init(struct drm_gpu_scheduler *sched, const struct drm_sched_init_
 		sched->own_submit_wq = true;
 	}
 
-	drm_sched_rq_init(&sched->rq);
+	sched->rq = kzalloc_obj(*sched->rq);
+	if (!sched->rq)
+		goto Out_check_own;
+
+	drm_sched_rq_init(sched, sched->rq);
 
 	init_waitqueue_head(&sched->job_scheduled);
 	INIT_LIST_HEAD(&sched->pending_list);
@@ -1108,6 +1121,12 @@ int drm_sched_init(struct drm_gpu_scheduler *sched, const struct drm_sched_init_
 
 	sched->ready = true;
 	return 0;
+
+Out_check_own:
+	if (sched->own_submit_wq)
+		destroy_workqueue(sched->submit_wq);
+	dev_err(sched->dev, "%s: Failed to setup GPU scheduler--out of memory\n", __func__);
+	return -ENOMEM;
 }
 EXPORT_SYMBOL(drm_sched_init);
 
@@ -1153,6 +1172,8 @@ void drm_sched_fini(struct drm_gpu_scheduler *sched)
 	if (sched->own_submit_wq)
 		destroy_workqueue(sched->submit_wq);
 	sched->ready = false;
+	kfree(sched->rq);
+	sched->rq = NULL;
 
 	if (!list_empty(&sched->pending_list))
 		dev_warn(sched->dev, "Tearing down scheduler while jobs are pending!\n");
@@ -1172,7 +1193,7 @@ void drm_sched_increase_karma(struct drm_sched_job *bad)
 {
 	struct drm_gpu_scheduler *sched = bad->sched;
 	struct drm_sched_entity *entity, *tmp;
-	struct drm_sched_rq *rq = &sched->rq;
+	struct drm_sched_rq *rq = sched->rq;
 
 	/* don't change @bad's karma if it's from KERNEL RQ,
 	 * because sometimes GPU hang would cause kernel jobs (like VM updating jobs)
diff --git a/drivers/gpu/drm/scheduler/sched_rq.c b/drivers/gpu/drm/scheduler/sched_rq.c
index 044546bcb5f8..aeeed6f3901d 100644
--- a/drivers/gpu/drm/scheduler/sched_rq.c
+++ b/drivers/gpu/drm/scheduler/sched_rq.c
@@ -85,15 +85,18 @@ static void drm_sched_rq_update_tree_locked(struct drm_sched_entity *entity,
 
 /**
  * drm_sched_rq_init - initialize a given run queue struct
+ * @sched: scheduler instance to associate with this run queue
  * @rq: scheduler run queue
  *
  * Initializes a scheduler runqueue.
  */
-void drm_sched_rq_init(struct drm_sched_rq *rq)
+void drm_sched_rq_init(struct drm_gpu_scheduler *sched,
+		       struct drm_sched_rq *rq)
 {
 	spin_lock_init(&rq->lock);
 	INIT_LIST_HEAD(&rq->entities);
 	rq->rb_tree_root = RB_ROOT_CACHED;
+	rq->sched = sched;
 	rq->head_prio = DRM_SCHED_PRIORITY_INVALID;
 }
 
@@ -162,8 +165,7 @@ drm_sched_entity_restore_vruntime(struct drm_sched_entity *entity,
 				  enum drm_sched_priority rq_prio)
 {
 	struct drm_sched_entity_stats *stats = entity->stats;
-	struct drm_gpu_scheduler *sched =
-			container_of(entity->rq, typeof(*sched), rq);
+	struct drm_gpu_scheduler *sched = entity->rq->sched;
 	enum drm_sched_priority prio = entity->priority;
 	unsigned long avg_us, sched_avg_us;
 	ktime_t vruntime;
@@ -263,8 +265,8 @@ drm_sched_rq_add_entity(struct drm_sched_entity *entity)
 	}
 
 	rq = entity->rq;
-	sched = container_of(rq, typeof(*sched), rq);
 	spin_lock(&rq->lock);
+	sched = rq->sched;
 
 	if (list_empty(&entity->list)) {
 		atomic_inc(sched->score);
@@ -291,8 +293,6 @@ drm_sched_rq_add_entity(struct drm_sched_entity *entity)
 void drm_sched_rq_remove_entity(struct drm_sched_rq *rq,
 				struct drm_sched_entity *entity)
 {
-	struct drm_gpu_scheduler *sched = container_of(rq, typeof(*sched), rq);
-
 	lockdep_assert_held(&entity->lock);
 
 	if (list_empty(&entity->list))
@@ -300,7 +300,7 @@ void drm_sched_rq_remove_entity(struct drm_sched_rq *rq,
 
 	spin_lock(&rq->lock);
 
-	atomic_dec(sched->score);
+	atomic_dec(rq->sched->score);
 	list_del_init(&entity->list);
 
 	drm_sched_rq_remove_tree_locked(entity, rq);
@@ -356,7 +356,7 @@ void drm_sched_rq_pop_entity(struct drm_sched_entity *entity)
 struct drm_sched_entity *
 drm_sched_select_entity(struct drm_gpu_scheduler *sched)
 {
-	struct drm_sched_rq *rq = &sched->rq;
+	struct drm_sched_rq *rq = sched->rq;
 	struct rb_node *rb;
 
 	spin_lock(&rq->lock);
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index da5d142506f2..dcda25f6f4eb 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -248,6 +248,7 @@ struct drm_sched_entity {
 /**
  * struct drm_sched_rq - queue of entities to be scheduled.
  *
+ * @sched: the scheduler to which this rq belongs to.
  * @lock: protects @entities, @rb_tree_root and @head_prio.
  * @entities: list of the entities to be scheduled.
  * @rb_tree_root: root of time based priority queue of entities for FIFO scheduling
@@ -258,6 +259,8 @@ struct drm_sched_entity {
  * the next entity to emit commands from.
  */
 struct drm_sched_rq {
+	struct drm_gpu_scheduler	*sched;
+
 	spinlock_t			lock;
 	/* Following members are protected by the @lock: */
 	struct list_head		entities;
@@ -580,7 +583,7 @@ struct drm_gpu_scheduler {
 	atomic_t			credit_count;
 	long				timeout;
 	const char			*name;
-	struct drm_sched_rq             rq;
+	struct drm_sched_rq             *rq;
 	wait_queue_head_t		job_scheduled;
 	atomic64_t			job_id_count;
 	struct workqueue_struct		*submit_wq;
-- 
2.54.0

