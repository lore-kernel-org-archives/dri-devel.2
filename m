Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ACB0F43694
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 10:38:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A24A710E9F1;
	Fri, 17 Apr 2026 10:37:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Tf2VNiZz";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8013710E9E3;
 Fri, 17 Apr 2026 10:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=x+zI5IjUqVkKCbj8MHjsrTs5Eqei5dUYF++X/yaywmQ=; b=Tf2VNiZzimqGMNf2oU03xnFTB3
 OYuTNeGoR/aYzSrndZN6BeixtIaWadNDPm8y7+eCxAwYpiih7oGWjdWCPm0GgiMC1r75f8cJ34c7N
 MG1c5vOWevHmrgbgHTCZMSGLVIXSzPOUR/+DkW5j7zdq5H5ciTXBey/YB6qEQ66HSYoCdmuURe02c
 iFnTB2dO4ezyVKbWXg8Gag4uIp1v/Dmyaz+WA0xHCEIcDgzKGKq3k0gOnOB51yibPSHPiyhdKCT6N
 52wiuS5KdKgXB5LG0CBAoPplVDEVAnU9m5ifxup09z03jUUDfORhC6xzkEzVpIG5UEj7edSSREo0I
 V7iVTJUw==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wDga9-00HPQ7-OF; Fri, 17 Apr 2026 12:37:53 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org, kernel-dev@igalia.com,
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Matthew Brost <matthew.brost@intel.com>
Subject: [PATCH v8 06/29] drm/sched: Implement RR via FIFO
Date: Fri, 17 Apr 2026 11:37:21 +0100
Message-ID: <20260417103744.76020-7-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260417103744.76020-1-tvrtko.ursulin@igalia.com>
References: <20260417103744.76020-1-tvrtko.ursulin@igalia.com>
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

Round-robin being the non-default policy and unclear how much it is used,
we can notice that it can be implemented using the FIFO data structures if
we only invent a fake submit timestamp which is monotonically increasing
inside drm_sched_rq instances.

So instead of remembering which was the last entity the scheduler worker
picked we can simply bump the picked one to the bottom of the tree, which
ensures round-robin behaviour between all active queued jobs.

If the picked job was the last from a given entity, we remember the
assigned fake timestamp and use it to re-insert the job once it re-joins
the queue. This ensures the job neither overtakes all already queued jobs,
neither it goes last. Instead it keeps the position after the currently
queued jobs and before the ones which haven't yet been queued at the point
the entity left the queue.

Advantage is that we can consolidate to a single code path and remove a
bunch of code. Downside is round-robin mode now needs to lock on the job
pop path but that should not have a measurable performance impact.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Philipp Stanner <phasta@kernel.org>
Acked-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_internal.h |   7 +-
 drivers/gpu/drm/scheduler/sched_main.c     |   6 +-
 drivers/gpu/drm/scheduler/sched_rq.c       | 124 +++++++--------------
 include/drm/gpu_scheduler.h                |  16 ++-
 4 files changed, 57 insertions(+), 96 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_internal.h b/drivers/gpu/drm/scheduler/sched_internal.h
index aab63a8721d9..b683cf813469 100644
--- a/drivers/gpu/drm/scheduler/sched_internal.h
+++ b/drivers/gpu/drm/scheduler/sched_internal.h
@@ -24,11 +24,8 @@ void drm_sched_rq_remove_entity(struct drm_sched_rq *rq,
 void drm_sched_rq_pop_entity(struct drm_sched_entity *entity);
 
 struct drm_sched_entity *
-drm_sched_rq_select_entity_rr(struct drm_gpu_scheduler *sched,
-			      struct drm_sched_rq *rq);
-struct drm_sched_entity *
-drm_sched_rq_select_entity_fifo(struct drm_gpu_scheduler *sched,
-				struct drm_sched_rq *rq);
+drm_sched_rq_select_entity(struct drm_gpu_scheduler *sched,
+			   struct drm_sched_rq *rq);
 
 void drm_sched_entity_select_rq(struct drm_sched_entity *entity);
 struct drm_sched_job *drm_sched_entity_pop_job(struct drm_sched_entity *entity);
diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 298509e40d69..097ea187d08e 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -892,15 +892,13 @@ void drm_sched_wakeup(struct drm_gpu_scheduler *sched)
 static struct drm_sched_entity *
 drm_sched_select_entity(struct drm_gpu_scheduler *sched)
 {
-	struct drm_sched_entity *entity;
+	struct drm_sched_entity *entity = NULL;
 	int i;
 
 	/* Start with the highest priority.
 	 */
 	for (i = DRM_SCHED_PRIORITY_KERNEL; i < sched->num_rqs; i++) {
-		entity = drm_sched_policy == DRM_SCHED_POLICY_FIFO ?
-			drm_sched_rq_select_entity_fifo(sched, sched->sched_rq[i]) :
-			drm_sched_rq_select_entity_rr(sched, sched->sched_rq[i]);
+		entity = drm_sched_rq_select_entity(sched, sched->sched_rq[i]);
 		if (entity)
 			break;
 	}
diff --git a/drivers/gpu/drm/scheduler/sched_rq.c b/drivers/gpu/drm/scheduler/sched_rq.c
index a525bb579c4d..6948b342d26a 100644
--- a/drivers/gpu/drm/scheduler/sched_rq.c
+++ b/drivers/gpu/drm/scheduler/sched_rq.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: MIT
 /* Copyright 2015 Advanced Micro Devices, Inc. */
+/* Copyright (c) 2025 Valve Corporation */
 
 #include <linux/rbtree.h>
 
@@ -98,8 +99,9 @@ drm_sched_rq_add_entity(struct drm_sched_entity *entity, ktime_t ts)
 		list_add_tail(&entity->list, &rq->entities);
 	}
 
-	if (drm_sched_policy == DRM_SCHED_POLICY_FIFO)
-		drm_sched_rq_update_fifo_locked(entity, rq, ts);
+	if (drm_sched_policy == DRM_SCHED_POLICY_RR)
+		ts = entity->rr_ts;
+	drm_sched_rq_update_fifo_locked(entity, rq, ts);
 
 	spin_unlock(&rq->lock);
 	spin_unlock(&entity->lock);
@@ -127,15 +129,27 @@ void drm_sched_rq_remove_entity(struct drm_sched_rq *rq,
 	atomic_dec(rq->sched->score);
 	list_del_init(&entity->list);
 
-	if (rq->current_entity == entity)
-		rq->current_entity = NULL;
-
-	if (drm_sched_policy == DRM_SCHED_POLICY_FIFO)
-		drm_sched_rq_remove_fifo_locked(entity, rq);
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
@@ -144,88 +158,32 @@ void drm_sched_rq_remove_entity(struct drm_sched_rq *rq,
  */
 void drm_sched_rq_pop_entity(struct drm_sched_entity *entity)
 {
+	struct drm_sched_job *next_job;
+
 	/*
 	 * Update the entity's location in the min heap according to
 	 * the timestamp of the next job, if any.
 	 */
-	if (drm_sched_policy == DRM_SCHED_POLICY_FIFO) {
-		struct drm_sched_job *next;
-
-		next = drm_sched_entity_queue_peek(entity);
-		if (next) {
-			struct drm_sched_rq *rq;
-
-			spin_lock(&entity->lock);
-			rq = entity->rq;
-			spin_lock(&rq->lock);
-			drm_sched_rq_update_fifo_locked(entity, rq,
-							next->submit_ts);
-			spin_unlock(&rq->lock);
-			spin_unlock(&entity->lock);
-		}
+	next_job = drm_sched_entity_queue_peek(entity);
+	if (next_job) {
+		struct drm_sched_rq *rq;
+		ktime_t ts;
+
+		spin_lock(&entity->lock);
+		rq = entity->rq;
+		spin_lock(&rq->lock);
+		if (drm_sched_policy == DRM_SCHED_POLICY_FIFO)
+			ts = next_job->submit_ts;
+		else
+			ts = drm_sched_rq_next_rr_ts(rq, entity);
+		drm_sched_rq_update_fifo_locked(entity, rq, ts);
+		spin_unlock(&rq->lock);
+		spin_unlock(&entity->lock);
 	}
 }
 
 /**
- * drm_sched_rq_select_entity_rr - Select an entity which could provide a job to run
- *
- * @sched: the gpu scheduler
- * @rq: scheduler run queue to check.
- *
- * Try to find the next ready entity.
- *
- * Return an entity if one is found; return an error-pointer (!NULL) if an
- * entity was ready, but the scheduler had insufficient credits to accommodate
- * its job; return NULL, if no ready entity was found.
- */
-struct drm_sched_entity *
-drm_sched_rq_select_entity_rr(struct drm_gpu_scheduler *sched,
-			      struct drm_sched_rq *rq)
-{
-	struct drm_sched_entity *entity;
-
-	spin_lock(&rq->lock);
-
-	entity = rq->current_entity;
-	if (entity) {
-		list_for_each_entry_continue(entity, &rq->entities, list) {
-			if (drm_sched_entity_is_ready(entity))
-				goto found;
-		}
-	}
-
-	list_for_each_entry(entity, &rq->entities, list) {
-		if (drm_sched_entity_is_ready(entity))
-			goto found;
-
-		if (entity == rq->current_entity)
-			break;
-	}
-
-	spin_unlock(&rq->lock);
-
-	return NULL;
-
-found:
-	if (!drm_sched_can_queue(sched, entity)) {
-		/*
-		 * If scheduler cannot take more jobs signal the caller to not
-		 * consider lower priority queues.
-		 */
-		entity = ERR_PTR(-ENOSPC);
-	} else {
-		rq->current_entity = entity;
-		reinit_completion(&entity->entity_idle);
-	}
-
-	spin_unlock(&rq->lock);
-
-	return entity;
-}
-
-/**
- * drm_sched_rq_select_entity_fifo - Select an entity which provides a job to run
- *
+ * drm_sched_rq_select_entity - Select an entity which provides a job to run
  * @sched: the gpu scheduler
  * @rq: scheduler run queue to check.
  *
@@ -236,8 +194,8 @@ drm_sched_rq_select_entity_rr(struct drm_gpu_scheduler *sched,
  * its job; return NULL, if no ready entity was found.
  */
 struct drm_sched_entity *
-drm_sched_rq_select_entity_fifo(struct drm_gpu_scheduler *sched,
-				struct drm_sched_rq *rq)
+drm_sched_rq_select_entity(struct drm_gpu_scheduler *sched,
+			   struct drm_sched_rq *rq)
 {
 	struct rb_node *rb;
 
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 609ebe389094..772331067cc2 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -94,7 +94,8 @@ struct drm_sched_entity {
 	 * @lock:
 	 *
 	 * Lock protecting the run-queue (@rq) to which this entity belongs,
-	 * @priority and the list of schedulers (@sched_list, @num_sched_list).
+	 * @priority, the list of schedulers (@sched_list, @num_sched_list) and
+	 * the @rr_ts field.
 	 */
 	spinlock_t			lock;
 
@@ -142,6 +143,13 @@ struct drm_sched_entity {
 	 */
 	enum drm_sched_priority         priority;
 
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
@@ -239,8 +247,8 @@ struct drm_sched_entity {
  * struct drm_sched_rq - queue of entities to be scheduled.
  *
  * @sched: the scheduler to which this rq belongs to.
- * @lock: protects @entities, @rb_tree_root and @current_entity.
- * @current_entity: the entity which is to be scheduled.
+ * @lock: protects @entities, @rb_tree_root and @rr_ts.
+ * @rr_ts: monotonically incrementing fake timestamp for RR mode.
  * @entities: list of the entities to be scheduled.
  * @rb_tree_root: root of time based priority queue of entities for FIFO scheduling
  *
@@ -253,7 +261,7 @@ struct drm_sched_rq {
 
 	spinlock_t			lock;
 	/* Following members are protected by the @lock: */
-	struct drm_sched_entity		*current_entity;
+	ktime_t				rr_ts;
 	struct list_head		entities;
 	struct rb_root_cached		rb_tree_root;
 };
-- 
2.52.0

