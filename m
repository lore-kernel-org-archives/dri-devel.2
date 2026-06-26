Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2242ECDE008
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 08:20:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 794E810E32F;
	Fri, 26 Jun 2026 08:19:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="B3UKCLZU";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17F8610E32F
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 08:19:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5216C60098;
 Fri, 26 Jun 2026 08:19:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45BA91F000E9;
 Fri, 26 Jun 2026 08:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782461997;
 bh=kEdeUSPXy5rJNpK1fxsrh40FY6vBxzMx9z5QFxqNe4I=;
 h=From:To:Cc:Subject:Date;
 b=B3UKCLZUFcmhelGJT4krdyefLuhIVINztM/dydshI64zWR90fM//IGuqgXGpjMtlo
 bUdE4R8L+eUHrIZKK3YYFx+x2Cl0v4fiRYV5T/bptFEhrgUjbrmMDm/C7VHcfvnTQa
 5nNb+L5o3suOIEE40agTxkD1+MsBhfM66WRhEMX/5PtDwDF/9Ux+k9l+imzsrmeWNX
 31k9seI8pDvZaRu5tCllI8/8YwSzqfF6VF34G0nezUK2Y/RwWbvYvdh/hQTkdpAdK6
 xXU54MED80/zrRnvN0pPYHF1boKeL3BklkZvzNAk2MGDUqs6eqPDOsk8PC3j72Iufu
 tCjsOPMUtJm/A==
From: Philipp Stanner <phasta@kernel.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: [PATCH v2] drm/sched: Protect entity->last_scheduled with spinlock
Date: Fri, 26 Jun 2026 10:19:43 +0200
Message-ID: <20260626081942.2122144-2-phasta@kernel.org>
X-Mailer: git-send-email 2.54.0
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
special RCU functions in addition to memory barriers. There is no
obvious reason for that, since the entity lock is available and taken at
all places that evaluate the last_scheduled field. The only exception is
drm_sched_entity_error(), which is not performance critical in any way.

Improve robustness, readability and maintainability by replacing RCU and
barriers with the lock.

As a preparational step, while at it, also guard spsc_queue_pop() with
the lock, since spsc_queue is deprecated and supposed to be replaced
with a locked list.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
Changes since v1:
  - Add a helper variable to drop the last_scheduled reference without
    the entity lock being held; just to be more robust.
  - Write additional comment to detail the WRITE_ONCE().
---
 drivers/gpu/drm/scheduler/sched_entity.c | 58 +++++++++++++-----------
 include/drm/gpu_scheduler.h              |  9 ++--
 2 files changed, 35 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index c51101ec70c1..12fd695c6d46 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -135,7 +135,6 @@ int drm_sched_entity_init(struct drm_sched_entity *entity,
 	entity->num_sched_list = num_sched_list;
 	entity->sched_list = num_sched_list > 1 ? sched_list : NULL;
 	entity->rq = &sched_list[0]->rq;
-	RCU_INIT_POINTER(entity->last_scheduled, NULL);
 	RB_CLEAR_NODE(&entity->rb_tree_node);
 	init_completion(&entity->entity_idle);
 
@@ -201,10 +200,10 @@ int drm_sched_entity_error(struct drm_sched_entity *entity)
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
@@ -288,8 +287,10 @@ void drm_sched_entity_kill(struct drm_sched_entity *entity)
 	wait_for_completion(&entity->entity_idle);
 
 	/* The entity is guaranteed to not be used by the scheduler */
-	prev = rcu_dereference_check(entity->last_scheduled, true);
+	spin_lock(&entity->lock);
+	prev = entity->last_scheduled;
 	dma_fence_get(prev);
+	spin_unlock(&entity->lock);
 	while ((job = drm_sched_entity_queue_pop(entity))) {
 		struct drm_sched_fence *s_fence = job->s_fence;
 
@@ -381,8 +382,12 @@ void drm_sched_entity_fini(struct drm_sched_entity *entity)
 		entity->dependency = NULL;
 	}
 
-	dma_fence_put(rcu_dereference_check(entity->last_scheduled, true));
-	RCU_INIT_POINTER(entity->last_scheduled, NULL);
+	dma_fence_put(entity->last_scheduled);
+	/*
+	 * Normally all users should be gone now, but since drm_sched has
+	 * experienced many layering violations in the past, better be safe.
+	 */
+	WRITE_ONCE(entity->last_scheduled, NULL);
 	drm_sched_entity_stats_put(entity->stats);
 }
 EXPORT_SYMBOL(drm_sched_entity_fini);
@@ -507,6 +512,10 @@ drm_sched_job_dependency(struct drm_sched_job *job,
 
 struct drm_sched_job *drm_sched_entity_pop_job(struct drm_sched_entity *entity)
 {
+	/* Helper to avoid dropping the reference while the entity lock is held,
+	 * just to have some more robustness.
+	 */
+	struct dma_fence *prev_last_scheduled;
 	struct drm_sched_job *sched_job;
 
 	sched_job = drm_sched_entity_queue_peek(entity);
@@ -523,19 +532,20 @@ struct drm_sched_job *drm_sched_entity_pop_job(struct drm_sched_entity *entity)
 	if (entity->guilty && atomic_read(entity->guilty))
 		dma_fence_set_error(&sched_job->s_fence->finished, -ECANCELED);
 
-	dma_fence_put(rcu_dereference_check(entity->last_scheduled, true));
-	rcu_assign_pointer(entity->last_scheduled,
-			   dma_fence_get(&sched_job->s_fence->finished));
+	spin_lock(&entity->lock);
+	prev_last_scheduled = entity->last_scheduled;
+	entity->last_scheduled = dma_fence_get(&sched_job->s_fence->finished);
 
-	/*
-	 * If the queue is empty we allow drm_sched_entity_select_rq() to
-	 * locklessly access ->last_scheduled. This only works if we set the
-	 * pointer before we dequeue and if we a write barrier here.
+	/* A recent rework required taking the spinlock above. Since spsc_queue
+	 * is scheduled for removal as per the DRM-TODO-list, we access it here
+	 * locked already to prepare for that cleanup.
+	 *
+	 * TODO: Fully replace spsc_queue with a locked (h)list.
 	 */
-	smp_wmb();
-
 	spsc_queue_pop(&entity->job_queue);
+	spin_unlock(&entity->lock);
 
+	dma_fence_put(prev_last_scheduled);
 	drm_sched_rq_pop_entity(entity);
 
 	/* Jobs and entities might have different lifecycles. Since we're
@@ -561,21 +571,15 @@ void drm_sched_entity_select_rq(struct drm_sched_entity *entity)
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
 	rq = sched ? &sched->rq : NULL;
 	if (rq != entity->rq) {
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index d61c19e78182..176ff1f936cd 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -100,7 +100,8 @@ struct drm_sched_entity {
 	 * @lock:
 	 *
 	 * Lock protecting the run-queue (@rq) to which this entity belongs,
-	 * @priority and the list of schedulers (@sched_list, @num_sched_list).
+	 * @priority, @last_scheduled and the list of schedulers (@sched_list,
+	 * @num_sched_list).
 	 */
 	spinlock_t			lock;
 
@@ -202,11 +203,9 @@ struct drm_sched_entity {
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
2.54.0

