Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82558CD98D6
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 12:34:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 998DD10EEE1;
	Thu, 11 Jun 2026 12:34:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="n6JxLFng";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3D4F10EED7;
 Thu, 11 Jun 2026 12:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=QF2O2BWB5BMzt5cqqJSLCmJHjU/PRJ9tFQfGKB6JtlY=; b=n6JxLFngVMGYa76MmtFMGnfITa
 iC/+joIz2B6CITS8Yk61//fEk3bbBIa9zSiQqMoiVUgFAk1/4tg1iw58gkP1ZnPVRHyqX/yrbxrke
 4hBckoCui6uagQiTqPsf4fn3IHGKV9MBW9SuweS7Aqso9yuLz857JKiP/wGJ6e02d5cVuV6tGRhoa
 9pkxtDKybLe+vkSAC4QMWAQwYdgubyyfQNwxqN0TIco5k9CdyBhmmNk65S0AU2eUPi9GCdDOZCSMv
 s7XmmMsKBsl76XKjPVywXcjvm/icFfRdmIv6quEwTmvfdilDtYE59wGaCVbn/W+1D1bQ4A7A0C5+s
 oqelVHDA==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wXecO-00G6gH-FH; Thu, 11 Jun 2026 14:34:44 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>, amd-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
Subject: [RFC] drm/sched: Replace completion with a flush
Date: Thu, 11 Jun 2026 13:34:23 +0100
Message-ID: <20260611123423.39819-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.54.0
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

Due the scheduler locking design, and the inability to always lock both
the entity and the run-queue in the consistent order, a completion exists
which effectively marks the entity as in use from a call path which is not
able to lock it.

When entity is selected from the run job worker, its completion is marked
as non-idle all until the code is sure it will not be dereferencing it any
more, at which point it signals it as idle, releasing the potential
parallel cleanup path.

We can remove the need for this completion by implementing the identical
guarantee by simply flushing the run job work from the cleanup path, after
having removed the entity from the run queue.

We then know that the entity is no longer reachable by the run queue
selection logic, so as soon as any pending work is done the cleanup can
safely proceed. And because we have marked the entity as stopped, we also
know that the entity cannot re-enter the run queue.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: amd-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org
---
"Perfection is achieved, not when there is nothing more to add, but when
 there is nothing left to take away." - Antoine de Saint-Exupéry

Lets see what Intel's CI says about this, not to mention our new AI
overlords...
---
 drivers/gpu/drm/scheduler/sched_entity.c   | 25 +++++++++++++++-------
 drivers/gpu/drm/scheduler/sched_internal.h | 14 ++++++++++--
 drivers/gpu/drm/scheduler/sched_main.c     |  2 --
 drivers/gpu/drm/scheduler/sched_rq.c       | 14 +++++++-----
 include/drm/gpu_scheduler.h                |  9 --------
 5 files changed, 38 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index c51101ec70c1..e6f7c2fbefce 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -137,10 +137,6 @@ int drm_sched_entity_init(struct drm_sched_entity *entity,
 	entity->rq = &sched_list[0]->rq;
 	RCU_INIT_POINTER(entity->last_scheduled, NULL);
 	RB_CLEAR_NODE(&entity->rb_tree_node);
-	init_completion(&entity->entity_idle);
-
-	/* We start in an idle state. */
-	complete_all(&entity->entity_idle);
 
 	spin_lock_init(&entity->lock);
 	spsc_queue_init(&entity->job_queue);
@@ -276,18 +272,24 @@ static void drm_sched_entity_kill_jobs_cb(struct dma_fence *f,
  */
 void drm_sched_entity_kill(struct drm_sched_entity *entity)
 {
+	struct drm_gpu_scheduler *sched;
 	struct drm_sched_job *job;
 	struct dma_fence *prev;
 
 	spin_lock(&entity->lock);
 	entity->stopped = true;
-	drm_sched_rq_remove_entity(entity->rq, entity);
+	sched = drm_sched_rq_remove_entity(entity->rq, entity);
 	spin_unlock(&entity->lock);
 
-	/* Make sure this entity is not used by the scheduler at the moment */
-	wait_for_completion(&entity->entity_idle);
+	/*
+	 * Make sure this entity is not used by the scheduler at the moment.
+	 *
+	 * Scheduler is guaranteed to be stable after the entity was stopped and
+	 * removed from the run-queue.
+	 */
+	if (sched)
+		drm_sched_flush_run_work(sched);
 
-	/* The entity is guaranteed to not be used by the scheduler */
 	prev = rcu_dereference_check(entity->last_scheduled, true);
 	dma_fence_get(prev);
 	while ((job = drm_sched_entity_queue_pop(entity))) {
@@ -576,6 +578,13 @@ void drm_sched_entity_select_rq(struct drm_sched_entity *entity)
 		return;
 
 	spin_lock(&entity->lock);
+
+	if (entity->stopped) {
+		spin_unlock(&entity->lock);
+		return;
+
+	}
+
 	sched = drm_sched_pick_best(entity->sched_list, entity->num_sched_list);
 	rq = sched ? &sched->rq : NULL;
 	if (rq != entity->rq) {
diff --git a/drivers/gpu/drm/scheduler/sched_internal.h b/drivers/gpu/drm/scheduler/sched_internal.h
index 13ecb771d7a2..80dece3be415 100644
--- a/drivers/gpu/drm/scheduler/sched_internal.h
+++ b/drivers/gpu/drm/scheduler/sched_internal.h
@@ -35,12 +35,22 @@ bool drm_sched_can_queue(struct drm_gpu_scheduler *sched,
 			 struct drm_sched_entity *entity);
 void drm_sched_wakeup(struct drm_gpu_scheduler *sched);
 
+/**
+ * drm_sched_flush_run_work - flush the run-job work
+ * @sched: scheduler instance
+ */
+static inline void drm_sched_flush_run_work(struct drm_gpu_scheduler *sched)
+{
+	flush_work(&sched->work_run_job);
+}
+
 void drm_sched_rq_init(struct drm_sched_rq *rq);
 
 struct drm_gpu_scheduler *
 drm_sched_rq_add_entity(struct drm_sched_entity *entity);
-void drm_sched_rq_remove_entity(struct drm_sched_rq *rq,
-				struct drm_sched_entity *entity);
+struct drm_gpu_scheduler *
+drm_sched_rq_remove_entity(struct drm_sched_rq *rq,
+			   struct drm_sched_entity *entity);
 void drm_sched_rq_pop_entity(struct drm_sched_entity *entity);
 
 struct drm_sched_entity *
diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index d2ca01b31ee4..b90220794a14 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -997,7 +997,6 @@ static void drm_sched_run_job_work(struct work_struct *w)
 
 	sched_job = drm_sched_entity_pop_job(entity);
 	if (!sched_job) {
-		complete_all(&entity->entity_idle);
 		drm_sched_run_job_queue(sched);
 		return;
 	}
@@ -1013,7 +1012,6 @@ static void drm_sched_run_job_work(struct work_struct *w)
 	 * refcount has been incremented for the scheduler already.
 	 */
 	fence = sched->ops->run_job(sched_job);
-	complete_all(&entity->entity_idle);
 	drm_sched_fence_scheduled(s_fence, fence);
 
 	if (!IS_ERR_OR_NULL(fence)) {
diff --git a/drivers/gpu/drm/scheduler/sched_rq.c b/drivers/gpu/drm/scheduler/sched_rq.c
index 044546bcb5f8..3b9175e23bf2 100644
--- a/drivers/gpu/drm/scheduler/sched_rq.c
+++ b/drivers/gpu/drm/scheduler/sched_rq.c
@@ -287,16 +287,20 @@ drm_sched_rq_add_entity(struct drm_sched_entity *entity)
  * @entity: scheduler entity
  *
  * Removes a scheduler entity from the run queue.
+ *
+ * Return: DRM scheduler selected to handle this entity or NULL if entity has
+ * already been removed.
  */
-void drm_sched_rq_remove_entity(struct drm_sched_rq *rq,
-				struct drm_sched_entity *entity)
+struct drm_gpu_scheduler *
+drm_sched_rq_remove_entity(struct drm_sched_rq *rq,
+			   struct drm_sched_entity *entity)
 {
 	struct drm_gpu_scheduler *sched = container_of(rq, typeof(*sched), rq);
 
 	lockdep_assert_held(&entity->lock);
 
 	if (list_empty(&entity->list))
-		return;
+		return NULL;
 
 	spin_lock(&rq->lock);
 
@@ -306,6 +310,8 @@ void drm_sched_rq_remove_entity(struct drm_sched_rq *rq,
 	drm_sched_rq_remove_tree_locked(entity, rq);
 
 	spin_unlock(&rq->lock);
+
+	return sched;
 }
 
 /**
@@ -372,8 +378,6 @@ drm_sched_select_entity(struct drm_gpu_scheduler *sched)
 				spin_unlock(&rq->lock);
 				return ERR_PTR(-ENOSPC);
 			}
-
-			reinit_completion(&entity->entity_idle);
 			break;
 		}
 	}
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index d61c19e78182..bde790dd7cc0 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -27,7 +27,6 @@
 #include <drm/spsc_queue.h>
 #include <linux/average.h>
 #include <linux/dma-fence.h>
-#include <linux/completion.h>
 #include <linux/xarray.h>
 #include <linux/workqueue.h>
 
@@ -222,14 +221,6 @@ struct drm_sched_entity {
 	 */
 	bool 				stopped;
 
-	/**
-	 * @entity_idle:
-	 *
-	 * Signals when entity is not in use, used to sequence entity cleanup in
-	 * drm_sched_entity_fini().
-	 */
-	struct completion		entity_idle;
-
 	/**
 	 * @oldest_job_waiting:
 	 *
-- 
2.54.0

