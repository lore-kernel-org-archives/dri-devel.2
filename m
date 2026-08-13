Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99060C5CFDB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 09:25:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B44EC10F206;
	Thu, 13 Aug 2026 09:25:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SXXTFa+p";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6965F10F206
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 09:25:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2CD45600E2;
 Thu, 13 Aug 2026 09:25:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C6D1F000E9;
 Thu, 13 Aug 2026 09:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786613155;
 bh=hkq+Q+EL7xwWR6jehZUXvFrAB32hgQ60kVEf3GbqWBs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=SXXTFa+pqU9dW1RGNF5wXqc9brt4Gdyt579tmPLho3dX9XA4zaKDom/ehvlryCS0Z
 Ayhe3XcHbkll17QtaI7/1oOIxDJmKpztaR6tvAx9YSgdsOy1Z/pbMUlFkbt4Uytk2C
 0iMq69m5+qBtJJZv4btjWExNtA7lTTZFTOtBdc7EZO0u2vgwKUCwHrSM/HeP/P6G3c
 9F1E8bVHlO18U9bi829xTwX7BlShtRBi7ksv79/JVFNoDAE6qmM/sEKdln0JgN0DrM
 vPODseBGSqN5QUn8fUuTDFyg/UfKRCae2YwdeW+e3bEq+yBUdl37i4i1Mv/Y6LO7NQ
 yXupwCRY+m4cQ==
From: Philipp Stanner <phasta@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org
Subject: [PATCH v2 2/2] drm/sched: Protect entity->last_scheduled with spinlock
Date: Thu, 13 Aug 2026 11:25:13 +0200
Message-ID: <20260813092510.2385962-6-phasta@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813092510.2385962-4-phasta@kernel.org>
References: <20260813092510.2385962-4-phasta@kernel.org>
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

The entity->last_scheduled field has always been set and read with
special RCU functions in addition to memory barriers.

This was added in

commit 70102d77ff22 ("drm/scheduler: add drm_sched_entity_error and use rcu for last_scheduled")

however, no proper justification for that mechanism was provided. There
seems to be no obvious reason, since the entity lock is available and
taken at all places that evaluate the last_scheduled field. The only
exception is drm_sched_entity_error(), which is not performance critical
in any way.

Improve robustness, readability and maintainability by replacing RCU and
barriers with the lock.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 54 ++++++++++--------------
 include/drm/gpu_scheduler.h              | 10 ++---
 2 files changed, 26 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 7fe47fc86c0e..2c903feca230 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -137,7 +137,6 @@ int drm_sched_entity_init(struct drm_sched_entity *entity,
 			      DRM_SCHED_PRIORITY_KERNEL : priority;
 	entity->num_sched_list = num_sched_list;
 	entity->sched_list = num_sched_list > 1 ? sched_list : NULL;
-	RCU_INIT_POINTER(entity->last_scheduled, NULL);
 	RB_CLEAR_NODE(&entity->rb_tree_node);
 
 	if (!sched_list[0]->sched_rq) {
@@ -230,10 +229,10 @@ int drm_sched_entity_error(struct drm_sched_entity *entity)
 	struct dma_fence *fence;
 	int r;
 
-	rcu_read_lock();
-	fence = rcu_dereference(entity->last_scheduled);
+	spin_lock(&entity->lock);
+	fence = entity->last_scheduled;
 	r = fence ? fence->error : 0;
-	rcu_read_unlock();
+	spin_unlock(&entity->lock);
 
 	return r;
 }
@@ -319,9 +318,10 @@ void drm_sched_entity_kill(struct drm_sched_entity *entity)
 	/* Make sure this entity is not used by the scheduler at the moment */
 	wait_for_completion(&entity->entity_idle);
 
-	/* The entity is guaranteed to not be used by the scheduler */
-	prev = rcu_dereference_check(entity->last_scheduled, true);
+	spin_lock(&entity->lock);
+	prev = entity->last_scheduled;
 	dma_fence_get(prev);
+	spin_unlock(&entity->lock);
 	while ((job = drm_sched_entity_queue_pop(entity))) {
 		struct drm_sched_fence *s_fence = job->s_fence;
 
@@ -416,8 +416,7 @@ void drm_sched_entity_fini(struct drm_sched_entity *entity)
 		entity->dependency = NULL;
 	}
 
-	dma_fence_put(rcu_dereference_check(entity->last_scheduled, true));
-	RCU_INIT_POINTER(entity->last_scheduled, NULL);
+	dma_fence_put(entity->last_scheduled);
 	drm_sched_entity_stats_put(entity->stats);
 }
 EXPORT_SYMBOL(drm_sched_entity_fini);
@@ -539,6 +538,10 @@ drm_sched_job_dependency(struct drm_sched_job *job,
 
 struct drm_sched_job *drm_sched_entity_pop_job(struct drm_sched_entity *entity)
 {
+	/* Helper to avoid dropping the reference while the entity lock is held,
+	 * just to have some more robustness.
+	 */
+	struct dma_fence *prev_last_scheduled;
 	struct drm_sched_job *sched_job;
 
 	sched_job = drm_sched_entity_queue_peek(entity);
@@ -555,22 +558,15 @@ struct drm_sched_job *drm_sched_entity_pop_job(struct drm_sched_entity *entity)
 	if (entity->guilty && atomic_read(entity->guilty))
 		dma_fence_set_error(&sched_job->s_fence->finished, -ECANCELED);
 
-	dma_fence_put(rcu_dereference_check(entity->last_scheduled, true));
-	rcu_assign_pointer(entity->last_scheduled,
-			   dma_fence_get(&sched_job->s_fence->finished));
-
-	/*
-	 * If the queue is empty we allow drm_sched_entity_select_rq() to
-	 * locklessly access ->last_scheduled. This only works if we set the
-	 * pointer before we dequeue and if we a write barrier here.
-	 */
-	smp_wmb();
+	spin_lock(&entity->lock);
+	prev_last_scheduled = entity->last_scheduled;
+	entity->last_scheduled = dma_fence_get(&sched_job->s_fence->finished);
+	drm_sched_rq_pop_entity(entity);
+	spin_unlock(&entity->lock);
 
 	spsc_queue_pop(&entity->job_queue);
 
-	spin_lock(&entity->lock);
-	drm_sched_rq_pop_entity(entity);
-	spin_unlock(&entity->lock);
+	dma_fence_put(prev_last_scheduled);
 
 	/* Jobs and entities might have different lifecycles. Since we're
 	 * removing the job from the entities queue, set the jobs entity pointer
@@ -595,21 +591,15 @@ void drm_sched_entity_select_rq(struct drm_sched_entity *entity)
 	if (spsc_queue_count(&entity->job_queue))
 		return;
 
-	/*
-	 * Only when the queue is empty are we guaranteed that
-	 * drm_sched_run_job_work() cannot change entity->last_scheduled. To
-	 * enforce ordering we need a read barrier here. See
-	 * drm_sched_entity_pop_job() for the other side.
-	 */
-	smp_rmb();
-
-	fence = rcu_dereference_check(entity->last_scheduled, true);
+	spin_lock(&entity->lock);
+	fence = entity->last_scheduled;
 
 	/* stay on the same engine if the previous job hasn't finished */
-	if (fence && !dma_fence_is_signaled(fence))
+	if (fence && !dma_fence_is_signaled(fence)) {
+		spin_unlock(&entity->lock);
 		return;
+	}
 
-	spin_lock(&entity->lock);
 	sched = drm_sched_pick_best(entity->sched_list, entity->num_sched_list);
 	rq = sched ? sched->sched_rq[entity->rq_priority] : NULL;
 	if (rq != entity->rq) {
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 790f7ecb6b85..b638065a11cb 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -100,8 +100,8 @@ struct drm_sched_entity {
 	 * @lock:
 	 *
 	 * Lock protecting the run-queue (@rq) to which this entity belongs,
-	 * @priority, the list of schedulers (@sched_list, @num_sched_list) and
-	 * the @rr_ts field.
+	 * @priority, @last_scheduled and the list of schedulers (@sched_list,
+	 * @num_sched_list).
 	 */
 	spinlock_t			lock;
 
@@ -215,11 +215,9 @@ struct drm_sched_entity {
 	/**
 	 * @last_scheduled:
 	 *
-	 * Points to the finished fence of the last scheduled job. Only written
-	 * by drm_sched_entity_pop_job(). Can be accessed locklessly from
-	 * drm_sched_job_arm() if the queue is empty.
+	 * Points to the finished fence of the last scheduled job.
 	 */
-	struct dma_fence __rcu		*last_scheduled;
+	struct dma_fence		*last_scheduled;
 
 	/**
 	 * @last_user: last group leader pushing a job into the entity.
-- 
2.55.0

