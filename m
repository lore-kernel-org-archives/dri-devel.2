Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9487A606A329
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 14:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=mnp68C1Q
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C41E10EA7C;
	Fri,  6 Nov 2026 14:57:18 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AE6C10F72E;
 Fri,  6 Nov 2026 14:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=7GldghYLjICYbFwLR3jDIWeODJK2G+Y8s2eWx5vECB0=; t=1793977030; x=2109337030; 
 b=mnp68C1Q0Ghz1vou4Lr/u6oHFQ0z/YmklSMbj7M0QIEfkCbsKUTK5YcYKmo6c5Q6ek1D4LuJEGL
 +tdiiiqzDsdnnm4/oVjprh8heK39ReK8BiAMuKyuVi3u7YhEwZoxOX+DUYWPLlB/G7ys/pKXUSdWQ
 gKCli6U5Ia+7iC2ckykId3BTBeb3bEL3cxqBiiKL2a46c1tgRtjHcTDdcc/QlH+AZXox8BZ4WqcUq
 EWyw5kNBWAwQleJLsPp5lSAZb9WvB6F2rvuBF4AoVEv02yhrzxSJi80BjaBB5nAk3PZo5ICTDjm5k
 9qbKOO/Dj7CqWYzURiobmsPXedLPzIKaedrQ==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xPLNM-004VnH-I5; Fri, 06 Nov 2026 15:57:08 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>
Subject: [PATCH 6/7] drm/sched: Replace the SPSC queue with a list and a
 spinlock
Date: Fri,  6 Nov 2026 14:57:01 +0000
Message-ID: <20261106145702.61640-7-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106145702.61640-1-tvrtko.ursulin@igalia.com>
References: <20261106145702.61640-1-tvrtko.ursulin@igalia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Migrate the entity job queue from the single user SPSC queue (single
producer, single consumer) to the standard list_head plus a spinlock in
order to make it easier to argue about correctnes and bring the code base
close to the usual kernel patterns.

The main thing which needs to be mentioned is the seeming usage of RCU,
which isn't really so, but only for two trivial reasons:

1.
We need to use the list operations which are safe for unlocked access to
the list head, while parallel (locked) threads can be appending other
jobs.

This so the run job worker is able to process the job dependencies which
includes it calling a potentially sleeping prepare_job() callback. Hence
it is not possible to hold the entity->lock during that stage.

2.
We need to work around the infamous entity<->rq locking inversion which
would now trigger slightly earlier in the run job worker, from the entity
selection stage, where there was previosuly the other "spsc queue peek"
call site.

Both are completely safe since we are guaranteed the head of the queue
cannot disapper until the run job work dequeues it itself later in its
flow.

All the list_*_rcu usage stem from those two requirements and there are no
actual RCU requirements.

Second thing to point out are the simplifications around
drm_sched_entity_is_ready() and drm_sched_can_queue(). In this design we
start tracking the number of job credits of the first job in the queue per
entity.

That allows for both removing one job peek site and the requirement to
access the number of queued jobs (or the queue non empty status).

In the functional respect replacing spsc_queue_count() (atomic_read) in
drm_sched_entity_is_ready() with READ_ONCE(entity->job_credits) are
equivalent but the new flow in drm_sched_rq_select_entity() is more
streamlined and easier to reason about.

The actual number of queued jobs is tracked only when tracing or unit
tests are compiled in and is not used from the regular scheduler logic.

In drm_sched_entity_push_job() because the job now cannot disappear
until we unlock the entity we can drop the respective comment and the
submit_ts caching.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c       |  26 +++-
 .../gpu/drm/scheduler/gpu_scheduler_trace.h   |   2 +-
 drivers/gpu/drm/scheduler/sched_entity.c      |  68 ++++++----
 drivers/gpu/drm/scheduler/sched_internal.h    |  56 +++-----
 drivers/gpu/drm/scheduler/sched_main.c        |  47 +------
 drivers/gpu/drm/scheduler/sched_rq.c          |  58 +++++++-
 .../gpu/drm/scheduler/tests/tests_scheduler.c |   2 +-
 include/drm/gpu_scheduler.h                   |  29 +++-
 include/drm/spsc_queue.h                      | 124 ------------------
 9 files changed, 169 insertions(+), 243 deletions(-)
 delete mode 100644 include/drm/spsc_queue.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 1f4a4a5a978d..dd814b5ef367 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -460,13 +460,29 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
 static struct drm_sched_job *
 drm_sched_entity_queue_pop(struct drm_sched_entity *entity)
 {
-	struct spsc_node *node;
+	struct drm_sched_job *next_job, *sched_job;
 
-	node = spsc_queue_pop(&entity->job_queue);
-	if (!node)
+	lockdep_assert_held(&entity->lock);
+
+	sched_job = list_first_entry_or_null(&entity->job_queue,
+					     typeof(*sched_job), queue_link);
+	if (!sched_job)
 		return NULL;
 
-	return container_of(node, struct drm_sched_job, queue_node);
+	list_del_rcu(&sched_job->queue_link);
+
+#if IS_ENABLED(CONFIG_TRACEPOINTS) || IS_ENABLED(CONFIG_DRM_SCHED_KUNIT_TEST)
+	WRITE_ONCE(entity->job_count, entity->job_count - 1);
+#endif
+
+	next_job = list_first_entry_or_null(&entity->job_queue,
+					    typeof(*next_job), queue_link);
+	if (next_job)
+		WRITE_ONCE(entity->job_credits, next_job->credits);
+	else
+		WRITE_ONCE(entity->job_credits, 0);
+
+	return sched_job;
 }
 
 static struct drm_sched_entity *
@@ -486,7 +502,7 @@ get_entity_with_jobs(struct drm_gpu_scheduler *sched) __acquires(&entity->lock)
 			 * approach of scanning the run-queues once when
 			 * nothing prevents userspace to queue more jobs.
 			 */
-			if (!spsc_queue_count(&entity->job_queue))
+			if (!READ_ONCE(entity->job_credits))
 				continue;
 
 			/*
diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h b/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
index 261713dd7d5a..6a6f7af00089 100644
--- a/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
+++ b/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
@@ -69,7 +69,7 @@ DECLARE_EVENT_CLASS(drm_sched_job,
 
 	    TP_fast_assign(
 			   __assign_str(name);
-			   __entry->job_count = spsc_queue_count(&entity->job_queue);
+			   __entry->job_count = READ_ONCE(entity->job_count);
 			   __entry->hw_job_count = atomic_read(
 				   &sched_job->sched->credit_count);
 			   __assign_str(dev);
diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 3495153ad4e5..9fb5affaab87 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -167,7 +167,7 @@ int drm_sched_entity_init(struct drm_sched_entity *entity,
 	entity->rq = sched_list[0]->sched_rq[entity->rq_priority];
 
 	spin_lock_init(&entity->lock);
-	spsc_queue_init(&entity->job_queue);
+	INIT_LIST_HEAD(&entity->job_queue);
 
 	atomic_set(&entity->fence_seq, 0);
 	entity->fence_context = dma_fence_context_alloc(2);
@@ -221,8 +221,7 @@ static bool drm_sched_entity_is_idle(struct drm_sched_entity *entity)
 
 	spin_lock(&entity->lock);
 
-	if (list_empty(&entity->list) ||
-	    spsc_queue_count(&entity->job_queue) == 0 ||
+	if (list_empty(&entity->list) || !READ_ONCE(entity->job_credits) ||
 	    entity->stopped)
 		idle = true;
 
@@ -338,7 +337,6 @@ void drm_sched_entity_kill(struct drm_sched_entity *entity)
 
 	spin_lock(&entity->lock);
 	prev = dma_fence_get(entity->last_scheduled);
-	spin_unlock(&entity->lock);
 	while ((job = drm_sched_entity_queue_pop(entity))) {
 		struct drm_sched_fence *s_fence = job->s_fence;
 
@@ -356,6 +354,7 @@ void drm_sched_entity_kill(struct drm_sched_entity *entity)
 
 		prev = &s_fence->finished;
 	}
+	spin_unlock(&entity->lock);
 	dma_fence_put(prev);
 }
 EXPORT_SYMBOL(drm_sched_entity_kill);
@@ -557,10 +556,20 @@ struct drm_sched_job *drm_sched_entity_pop_job(struct drm_sched_entity *entity)
 	/* Helper to avoid dropping the reference while the entity lock is held,
 	 * just to have some more robustness.
 	 */
+	struct drm_sched_job *sched_job, *next_job;
 	struct dma_fence *prev_last_scheduled;
-	struct drm_sched_job *sched_job;
 
-	sched_job = drm_sched_entity_queue_peek(entity);
+	/*
+	 * We cannot lock the entity at this point since processing dependencies
+	 * needs to be able to call a sleeping ops->prepare_job(). Note that RCU
+	 * lock is not stricly required since single workqueue is the only
+	 * caller and that guarantees a single consumer. Ie. the job cannot
+	 * disappear on us.
+	 */
+	rcu_read_lock();
+	sched_job = list_first_or_null_rcu(&entity->job_queue,
+					   typeof(*sched_job), queue_link);
+	rcu_read_unlock();
 	if (!sched_job)
 		return NULL;
 
@@ -577,8 +586,21 @@ struct drm_sched_job *drm_sched_entity_pop_job(struct drm_sched_entity *entity)
 	spin_lock(&entity->lock);
 	prev_last_scheduled = entity->last_scheduled;
 	entity->last_scheduled = dma_fence_get(&sched_job->s_fence->finished);
-	spsc_queue_pop(&entity->job_queue);
-	drm_sched_rq_pop_entity(entity);
+
+	list_del_rcu(&sched_job->queue_link);
+#if IS_ENABLED(CONFIG_TRACEPOINTS) || IS_ENABLED(CONFIG_DRM_SCHED_KUNIT_TEST)
+	WRITE_ONCE(entity->job_count, entity->job_count - 1);
+#endif
+	next_job = list_first_entry_or_null(&entity->job_queue,
+					    typeof(*next_job), queue_link);
+	/* WRITE_ONCE just for the annotation to pair up. */
+	if (next_job)
+		WRITE_ONCE(entity->job_credits, next_job->credits);
+	else
+		WRITE_ONCE(entity->job_credits, 0);
+
+	drm_sched_rq_pop_entity(entity, next_job);
+
 	spin_unlock(&entity->lock);
 
 	dma_fence_put(prev_last_scheduled);
@@ -598,11 +620,11 @@ void drm_sched_entity_select_rq(struct drm_sched_entity *entity)
 	struct drm_gpu_scheduler *sched;
 	struct drm_sched_rq *rq;
 
+	spin_lock(&entity->lock);
+
 	/* queue non-empty, stay on the same engine */
-	if (spsc_queue_count(&entity->job_queue))
-		return;
-
-	spin_lock(&entity->lock);
+	if (entity->job_credits)
+		goto out;
 
 	/* Cannot submit to stopped entity anyway so bail out early. */
 	if (entity->stopped)
@@ -642,9 +664,6 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
 {
 	struct drm_sched_entity *entity = sched_job->entity;
 	bool first;
-	ktime_t submit_ts;
-
-	trace_drm_sched_job_queue(sched_job, entity);
 
 	if (trace_drm_sched_job_add_dep_enabled()) {
 		struct dma_fence *entry;
@@ -656,26 +675,27 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
 	atomic_inc(entity->rq->sched->score);
 	WRITE_ONCE(entity->last_user, current->group_leader);
 
-	/*
-	 * After the sched_job is pushed into the entity queue, it may be
-	 * completed and freed up at any time. We can no longer access it.
-	 * Make sure to set the submit_ts first, to avoid a race.
-	 */
-	sched_job->submit_ts = submit_ts = ktime_get();
+	sched_job->submit_ts = ktime_get();
 
 	spin_lock(&entity->lock);
+	first = list_empty(&entity->job_queue);
+	list_add_tail_rcu(&sched_job->queue_link, &entity->job_queue);
+#if IS_ENABLED(CONFIG_TRACEPOINTS) || IS_ENABLED(CONFIG_DRM_SCHED_KUNIT_TEST)
+	WRITE_ONCE(entity->job_count, entity->job_count + 1);
+#endif
 
-	first = spsc_queue_push(&entity->job_queue, &sched_job->queue_node);
+	trace_drm_sched_job_queue(sched_job, entity);
 
 	/* first job wakes up scheduler */
 	if (first) {
 		struct drm_gpu_scheduler *sched;
 
-		sched = drm_sched_rq_add_entity(entity, submit_ts);
+		/* WRITE_ONCE just for the annotation to pair up. */
+		WRITE_ONCE(entity->job_credits, sched_job->credits);
+		sched = drm_sched_rq_add_entity(entity, sched_job->submit_ts);
 		if (sched)
 			drm_sched_wakeup(sched);
 	}
-
 	spin_unlock(&entity->lock);
 }
 EXPORT_SYMBOL(drm_sched_entity_push_job);
diff --git a/drivers/gpu/drm/scheduler/sched_internal.h b/drivers/gpu/drm/scheduler/sched_internal.h
index ca724a8a4433..7ac988d4d299 100644
--- a/drivers/gpu/drm/scheduler/sched_internal.h
+++ b/drivers/gpu/drm/scheduler/sched_internal.h
@@ -38,8 +38,6 @@ extern int drm_sched_policy;
 #define DRM_SCHED_POLICY_FIFO  1
 #define DRM_SCHED_POLICY_FAIR  2
 
-bool drm_sched_can_queue(struct drm_gpu_scheduler *sched,
-			 struct drm_sched_entity *entity);
 void drm_sched_wakeup(struct drm_gpu_scheduler *sched);
 
 /**
@@ -59,7 +57,8 @@ drm_sched_rq_add_entity(struct drm_sched_entity *entity, ktime_t ts);
 struct drm_gpu_scheduler *
 drm_sched_rq_remove_entity(struct drm_sched_rq *rq,
 			   struct drm_sched_entity *entity);
-void drm_sched_rq_pop_entity(struct drm_sched_entity *entity);
+void drm_sched_rq_pop_entity(struct drm_sched_entity *entity,
+			     struct drm_sched_job *next_job);
 
 struct drm_sched_entity *
 drm_sched_rq_select_entity(struct drm_gpu_scheduler *sched,
@@ -89,47 +88,30 @@ void drm_sched_fence_finished(struct drm_sched_fence *fence, int result);
 static inline struct drm_sched_job *
 drm_sched_entity_queue_pop(struct drm_sched_entity *entity)
 {
-	struct spsc_node *node;
+	struct drm_sched_job *next_job, *sched_job;
 
-	node = spsc_queue_pop(&entity->job_queue);
-	if (!node)
-		return NULL;
-
-	return container_of(node, struct drm_sched_job, queue_node);
-}
-
-/**
- * drm_sched_entity_queue_peek - Low level helper for peeking at the job queue
- *
- * @entity: scheduler entity
- *
- * Low level helper for peeking at the job queue
- *
- * Returns: The job at the head of the queue or NULL.
- */
-static inline struct drm_sched_job *
-drm_sched_entity_queue_peek(struct drm_sched_entity *entity)
-{
-	struct spsc_node *node;
+	lockdep_assert_held(&entity->lock);
 
-	node = spsc_queue_peek(&entity->job_queue);
-	if (!node)
+	sched_job = list_first_entry_or_null(&entity->job_queue,
+					     typeof(*sched_job), queue_link);
+	if (!sched_job)
 		return NULL;
 
-	return container_of(node, struct drm_sched_job, queue_node);
-}
+	list_del_rcu(&sched_job->queue_link);
 
-/* Return true if entity could provide a job. */
-static inline bool
-drm_sched_entity_is_ready(struct drm_sched_entity *entity)
-{
-	if (!spsc_queue_count(&entity->job_queue))
-		return false;
+#if IS_ENABLED(CONFIG_TRACEPOINTS) || IS_ENABLED(CONFIG_DRM_SCHED_KUNIT_TEST)
+	WRITE_ONCE(entity->job_count, entity->job_count - 1);
+#endif
 
-	if (READ_ONCE(entity->dependency))
-		return false;
+	next_job = list_first_entry_or_null(&entity->job_queue,
+					    typeof(*next_job), queue_link);
+	/* WRITE_ONCE just for the annotation to pair up. */
+	if (next_job)
+		WRITE_ONCE(entity->job_credits, next_job->credits);
+	else
+		WRITE_ONCE(entity->job_credits, 0);
 
-	return true;
+	return sched_job;
 }
 
 void drm_sched_entity_stats_release(struct kref *kref);
diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 338050390fc8..85dc570a4816 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -92,46 +92,6 @@ int drm_sched_policy = DRM_SCHED_POLICY_FAIR;
 MODULE_PARM_DESC(sched_policy, "Specify the scheduling policy for entities on a run-queue, " __stringify(DRM_SCHED_POLICY_RR) " = Round Robin, " __stringify(DRM_SCHED_POLICY_FIFO) " = FIFO (default), " __stringify(DRM_SCHED_POLICY_FAIR) " = Fair (experimental).");
 module_param_named(sched_policy, drm_sched_policy, int, 0444);
 
-static u32 drm_sched_available_credits(struct drm_gpu_scheduler *sched)
-{
-	u32 credits;
-
-	WARN_ON(check_sub_overflow(sched->credit_limit,
-				   atomic_read(&sched->credit_count),
-				   &credits));
-
-	return credits;
-}
-
-/**
- * drm_sched_can_queue -- Can we queue more to the hardware?
- * @sched: scheduler instance
- * @entity: the scheduler entity
- *
- * Return true if we can push at least one more job from @entity, false
- * otherwise.
- */
-bool drm_sched_can_queue(struct drm_gpu_scheduler *sched,
-			 struct drm_sched_entity *entity)
-{
-	struct drm_sched_job *s_job;
-
-	s_job = drm_sched_entity_queue_peek(entity);
-	if (!s_job)
-		return false;
-
-	/* If a job exceeds the credit limit, truncate it to the credit limit
-	 * itself to guarantee forward progress.
-	 */
-	if (s_job->credits > sched->credit_limit) {
-		dev_WARN(sched->dev,
-			 "Jobs may not exceed the credit limit, truncate.\n");
-		s_job->credits = sched->credit_limit;
-	}
-
-	return drm_sched_available_credits(sched) >= s_job->credits;
-}
-
 /**
  * drm_sched_run_job_queue - enqueue run-job work
  * @sched: scheduler instance
@@ -616,6 +576,7 @@ int drm_sched_job_init(struct drm_sched_job *job,
 		return -ENOMEM;
 
 	INIT_LIST_HEAD(&job->list);
+	INIT_LIST_HEAD(&job->queue_link);
 
 	xa_init_flags(&job->dependencies, XA_FLAGS_ALLOC);
 
@@ -1039,6 +1000,12 @@ static void drm_sched_run_job_work(struct work_struct *w)
 
 	s_fence = sched_job->s_fence;
 
+	if (sched_job->credits > sched->credit_limit) {
+		dev_WARN(sched->dev,
+			 "Jobs may not exceed the credit limit, truncating.\n");
+		sched_job->credits = sched->credit_limit;
+	}
+
 	atomic_add(sched_job->credits, &sched->credit_count);
 	drm_sched_job_begin(sched_job);
 
diff --git a/drivers/gpu/drm/scheduler/sched_rq.c b/drivers/gpu/drm/scheduler/sched_rq.c
index 79f7bdb5b3f0..b6f35fef95f8 100644
--- a/drivers/gpu/drm/scheduler/sched_rq.c
+++ b/drivers/gpu/drm/scheduler/sched_rq.c
@@ -347,10 +347,11 @@ drm_sched_rq_next_rr_ts(struct drm_sched_rq *rq,
  *
  * To be called every time after a job is popped from the entity.
  */
-void drm_sched_rq_pop_entity(struct drm_sched_entity *entity)
+void
+drm_sched_rq_pop_entity(struct drm_sched_entity *entity,
+			struct drm_sched_job *next_job)
 {
 	struct drm_sched_rq *rq = entity->rq;
-	struct drm_sched_job *next_job;
 
 	lockdep_assert_held(&entity->lock);
 
@@ -360,7 +361,6 @@ void drm_sched_rq_pop_entity(struct drm_sched_entity *entity)
 	 * Update the entity's location in the min heap according to
 	 * the timestamp of the next job, if any.
 	 */
-	next_job = drm_sched_entity_queue_peek(entity);
 	if (next_job) {
 		ktime_t ts;
 
@@ -386,6 +386,52 @@ void drm_sched_rq_pop_entity(struct drm_sched_entity *entity)
 	spin_unlock(&rq->lock);
 }
 
+
+/* Return the number of credits first queued job needs, or zero if none are ready. */
+static inline u32
+drm_sched_entity_ready_credits(struct drm_sched_entity *entity)
+{
+	if (READ_ONCE(entity->dependency))
+		return 0;
+
+	return READ_ONCE(entity->job_credits);
+}
+
+static u32 drm_sched_available_credits(struct drm_gpu_scheduler *sched)
+{
+	u32 credits;
+
+	WARN_ON(check_sub_overflow(sched->credit_limit,
+				   atomic_read(&sched->credit_count),
+				   &credits));
+
+	return credits;
+}
+
+/**
+ * drm_sched_can_queue -- Can we queue more to the hardware?
+ * @sched: scheduler instance
+ * @credits: the number of credits required
+ *
+ * Return true if we can push at least a job worth @credits, false
+ * otherwise.
+ */
+static bool
+drm_sched_can_queue(struct drm_gpu_scheduler *sched, u32 credits)
+{
+	if (!credits)
+		return false;
+
+	/*
+	 * If a job exceeds the credit limit, we will truncate it to guarantee
+	 * forward progress.
+	 */
+	if (credits > sched->credit_limit)
+		credits = sched->credit_limit;
+
+	return drm_sched_available_credits(sched) >= credits;
+}
+
 /**
  * drm_sched_rq_select_entity - Select an entity which provides a job to run
  * @sched: the gpu scheduler
@@ -406,13 +452,15 @@ drm_sched_rq_select_entity(struct drm_gpu_scheduler *sched,
 	spin_lock(&rq->lock);
 	for (rb = rb_first_cached(&rq->rb_tree_root); rb; rb = rb_next(rb)) {
 		struct drm_sched_entity *entity;
+		u32 credits;
 
 		entity = rb_entry(rb, struct drm_sched_entity, rb_tree_node);
-		if (drm_sched_entity_is_ready(entity)) {
+		credits = drm_sched_entity_ready_credits(entity);
+		if (credits) {
 			/* If we can't queue yet, preserve the current entity in
 			 * terms of fairness.
 			 */
-			if (!drm_sched_can_queue(sched, entity)) {
+			if (!drm_sched_can_queue(sched, credits)) {
 				spin_unlock(&rq->lock);
 				return ERR_PTR(-ENOSPC);
 			}
diff --git a/drivers/gpu/drm/scheduler/tests/tests_scheduler.c b/drivers/gpu/drm/scheduler/tests/tests_scheduler.c
index 285546a2218f..e68e4fa40688 100644
--- a/drivers/gpu/drm/scheduler/tests/tests_scheduler.c
+++ b/drivers/gpu/drm/scheduler/tests/tests_scheduler.c
@@ -611,7 +611,7 @@ static void drm_sched_scheduler_two_clients_test(struct kunit *test)
 		unsigned int pct[2], qd[2], cycle[2], cps[2];
 
 		for (i = 0; i < ARRAY_SIZE(client); i++) {
-			qd[i] = spsc_queue_count(&client[i].entity->base.job_queue);
+			qd[i] = READ_ONCE(client[i].entity->base.job_count);
 			cycle[i] = READ_ONCE(client[i].cycle);
 			cps[i] = DIV_ROUND_UP(100 * frequency *
 					      (cycle[i] - prev_cycle[i]),
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index dfa399ace89f..0cffb47f151b 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -24,7 +24,6 @@
 #ifndef _DRM_GPU_SCHEDULER_H_
 #define _DRM_GPU_SCHEDULER_H_
 
-#include <drm/spsc_queue.h>
 #include <linux/average.h>
 #include <linux/dma-fence.h>
 #include <linux/xarray.h>
@@ -98,9 +97,9 @@ struct drm_sched_entity {
 	/**
 	 * @lock:
 	 *
-	 * Lock protecting the run-queue (@rq) to which this entity belongs,
-	 * @priority, @last_scheduled and the list of schedulers (@sched_list,
-	 * @num_sched_list), @rr_ts and @stopped.
+	 * Lock protecting the @job_queue, run-queue (@rq) to which this entity
+	 * belongs, @priority, @last_scheduled and the list of schedulers
+	 * (@sched_list, @num_sched_list), @rr_ts and @stopped.
 	 */
 	spinlock_t			lock;
 
@@ -175,8 +174,26 @@ struct drm_sched_entity {
 
 	/**
 	 * @job_queue: the list of jobs of this entity.
+	 *
+	 * It is operated using the RCU list accessors to allow for safe
+	 * initial lockless access from drm_sched_run_job_work(). Since that is
+	 * the only caller, and it is guaranteed to be a singleton, and we
+	 * cannot lock the entity at its top due both lock inversions and the
+	 * need to call sleeping ->prepare_job.
 	 */
-	struct spsc_queue		job_queue;
+	struct list_head		job_queue;
+
+#if IS_ENABLED(CONFIG_TRACEPOINTS) || IS_ENABLED(CONFIG_DRM_SCHED_KUNIT_TEST)
+	/**
+	 * @job_count: number of jobs in the @job_queue.
+	 */
+	unsigned int			job_count;
+#endif
+
+	/**
+	 * @job_credits: credits of the first job in the queue or zero if none.
+	 */
+	u32				job_credits;
 
 	/**
 	 * @fence_seq:
@@ -390,7 +407,7 @@ struct drm_sched_job {
 	unsigned int			last_dependency;
 	atomic_t			karma;
 
-	struct spsc_node		queue_node;
+	struct list_head		queue_link;
 	struct list_head		list;
 
 	/*
diff --git a/include/drm/spsc_queue.h b/include/drm/spsc_queue.h
deleted file mode 100644
index ee9df8cc67b7..000000000000
--- a/include/drm/spsc_queue.h
+++ /dev/null
@@ -1,124 +0,0 @@
-/*
- * Copyright 2017 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
- *
- */
-
-#ifndef DRM_SCHEDULER_SPSC_QUEUE_H_
-#define DRM_SCHEDULER_SPSC_QUEUE_H_
-
-#include <linux/atomic.h>
-#include <linux/preempt.h>
-
-/** SPSC lockless queue */
-
-struct spsc_node {
-
-	/* Stores spsc_node* */
-	struct spsc_node *next;
-};
-
-struct spsc_queue {
-
-	 struct spsc_node *head;
-
-	/* atomic pointer to struct spsc_node* */
-	atomic_long_t tail;
-
-	atomic_t job_count;
-};
-
-static inline void spsc_queue_init(struct spsc_queue *queue)
-{
-	queue->head = NULL;
-	atomic_long_set(&queue->tail, (long)&queue->head);
-	atomic_set(&queue->job_count, 0);
-}
-
-static inline struct spsc_node *spsc_queue_peek(struct spsc_queue *queue)
-{
-	return queue->head;
-}
-
-static inline int spsc_queue_count(struct spsc_queue *queue)
-{
-	return atomic_read(&queue->job_count);
-}
-
-static inline bool spsc_queue_push(struct spsc_queue *queue, struct spsc_node *node)
-{
-	struct spsc_node **tail;
-
-	node->next = NULL;
-
-	preempt_disable();
-
-	atomic_inc(&queue->job_count);
-	smp_mb__after_atomic();
-
-	tail = (struct spsc_node **)atomic_long_xchg(&queue->tail, (long)&node->next);
-	WRITE_ONCE(*tail, node);
-
-	/*
-	 * In case of first element verify new node will be visible to the consumer
-	 * thread when we ping the kernel thread that there is new work to do.
-	 */
-	smp_wmb();
-
-	preempt_enable();
-
-	return tail == &queue->head;
-}
-
-
-static inline struct spsc_node *spsc_queue_pop(struct spsc_queue *queue)
-{
-	struct spsc_node *next, *node;
-
-	/* Verify reading from memory and not the cache */
-	smp_rmb();
-
-	node = READ_ONCE(queue->head);
-
-	if (!node)
-		return NULL;
-
-	next = READ_ONCE(node->next);
-	WRITE_ONCE(queue->head, next);
-
-	if (unlikely(!next)) {
-		/* slowpath for the last element in the queue */
-
-		if (atomic_long_cmpxchg(&queue->tail,
-				(long)&node->next, (long) &queue->head) != (long)&node->next) {
-			/* Updating tail failed wait for new next to appear */
-			do {
-				smp_rmb();
-			} while (unlikely(!(queue->head = READ_ONCE(node->next))));
-		}
-	}
-
-	atomic_dec(&queue->job_count);
-	return node;
-}
-
-
-
-#endif /* DRM_SCHEDULER_SPSC_QUEUE_H_ */
-- 
2.56.0

