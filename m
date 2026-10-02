Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B441CCA5FE5
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 15:47:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D70110F8FD;
	Fri,  2 Oct 2026 15:47:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="SxwwxI4v";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8F7510F8F5;
 Fri,  2 Oct 2026 15:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=U00gWZ2uvpUUdNUu9BilcMR0+qhUo3DcNjrMFCuhCpk=; b=SxwwxI4vw6Ofbvw2hxZ09bYNv2
 4qBz9gQwiTICpJMekOwk4DkzptNpCtZPLznDUMZe9ZB/ozEgx2Ohi8Re7KVTg/He8THz3cfdJ/3T/
 oa71t00eKEATAs3FGfyN8iLsZXYNdnYwfaMUIvBpzhhRzDBu6B8mFLjLvMfS8h/3sL9K7wg3cSUh2
 A7oQL5BfyoSQo1/mXPINHs3Q8hHEO24e/GiCGBjKTQ7XXvIJ9m8Ng4nJiIdMyWaMge7IwJlV4wJH8
 eNO/rvCZSp/0fUvXsYAx4rFmuX6UO/932ZEqsI7xpmac/pHPg4UDKXW/04/MS5nxqceiWwK1Vjwqj
 UAhkyfYg==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xCfTl-00AfmK-Sc; Fri, 02 Oct 2026 17:47:21 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>, intel-xe@lists.freedesktop.org
Subject: [PATCH 8/9] drm/sched: Replace completion with a flush
Date: Fri,  2 Oct 2026 16:47:12 +0100
Message-ID: <20261002154713.77591-9-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002154713.77591-1-tvrtko.ursulin@igalia.com>
References: <20261002154713.77591-1-tvrtko.ursulin@igalia.com>
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
 drivers/gpu/drm/scheduler/sched_entity.c   | 18 ++++++++++--------
 drivers/gpu/drm/scheduler/sched_internal.h | 14 ++++++++++++--
 drivers/gpu/drm/scheduler/sched_main.c     |  2 --
 drivers/gpu/drm/scheduler/sched_rq.c       | 19 +++++++++++++------
 include/drm/gpu_scheduler.h                |  9 ---------
 5 files changed, 35 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 3ca671af02ed..79ea20838328 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -161,11 +161,6 @@ int drm_sched_entity_init(struct drm_sched_entity *entity,
 			      DRM_SCHED_PRIORITY_KERNEL : priority;
 	entity->rq = sched_list[0]->sched_rq[entity->rq_priority];
 
-	init_completion(&entity->entity_idle);
-
-	/* We start in an idle state. */
-	complete_all(&entity->entity_idle);
-
 	spin_lock_init(&entity->lock);
 	spsc_queue_init(&entity->job_queue);
 
@@ -304,16 +299,23 @@ static void drm_sched_entity_kill_jobs_cb(struct dma_fence *f,
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
 
 	spin_lock(&entity->lock);
 	prev = dma_fence_get(entity->last_scheduled);
diff --git a/drivers/gpu/drm/scheduler/sched_internal.h b/drivers/gpu/drm/scheduler/sched_internal.h
index 32d3ddb820be..ca724a8a4433 100644
--- a/drivers/gpu/drm/scheduler/sched_internal.h
+++ b/drivers/gpu/drm/scheduler/sched_internal.h
@@ -42,13 +42,23 @@ bool drm_sched_can_queue(struct drm_gpu_scheduler *sched,
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
 void drm_sched_rq_init(struct drm_gpu_scheduler *sched,
 		       struct drm_sched_rq *rq);
 
 struct drm_gpu_scheduler *
 drm_sched_rq_add_entity(struct drm_sched_entity *entity, ktime_t ts);
-void drm_sched_rq_remove_entity(struct drm_sched_rq *rq,
-				struct drm_sched_entity *entity);
+struct drm_gpu_scheduler *
+drm_sched_rq_remove_entity(struct drm_sched_rq *rq,
+			   struct drm_sched_entity *entity);
 void drm_sched_rq_pop_entity(struct drm_sched_entity *entity);
 
 struct drm_sched_entity *
diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 00eb017fbcec..182d4546ac9c 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -1034,7 +1034,6 @@ static void drm_sched_run_job_work(struct work_struct *w)
 
 	sched_job = drm_sched_entity_pop_job(entity);
 	if (!sched_job) {
-		complete_all(&entity->entity_idle);
 		drm_sched_run_job_queue(sched);
 		return;
 	}
@@ -1050,7 +1049,6 @@ static void drm_sched_run_job_work(struct work_struct *w)
 	 * refcount has been incremented for the scheduler already.
 	 */
 	fence = sched->ops->run_job(sched_job);
-	complete_all(&entity->entity_idle);
 	drm_sched_fence_scheduled(s_fence, fence);
 
 	if (!IS_ERR_OR_NULL(fence)) {
diff --git a/drivers/gpu/drm/scheduler/sched_rq.c b/drivers/gpu/drm/scheduler/sched_rq.c
index 23f46ec610e7..79f7bdb5b3f0 100644
--- a/drivers/gpu/drm/scheduler/sched_rq.c
+++ b/drivers/gpu/drm/scheduler/sched_rq.c
@@ -297,23 +297,32 @@ drm_sched_rq_add_entity(struct drm_sched_entity *entity, ktime_t ts)
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
+	struct drm_gpu_scheduler *sched;
+
 	lockdep_assert_held(&entity->lock);
 
 	if (list_empty(&entity->list))
-		return;
+		return NULL;
 
 	spin_lock(&rq->lock);
 
-	atomic_dec(rq->sched->score);
+	sched = rq->sched;
+	atomic_dec(sched->score);
 	list_del_init(&entity->list);
 
 	drm_sched_rq_remove_fifo_locked(entity, rq);
 
 	spin_unlock(&rq->lock);
+
+	return sched;
 }
 
 static ktime_t
@@ -407,8 +416,6 @@ drm_sched_rq_select_entity(struct drm_gpu_scheduler *sched,
 				spin_unlock(&rq->lock);
 				return ERR_PTR(-ENOSPC);
 			}
-
-			reinit_completion(&entity->entity_idle);
 			break;
 		}
 	}
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 3b0978fa8cf0..c89a581f54bf 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -27,7 +27,6 @@
 #include <drm/spsc_queue.h>
 #include <linux/average.h>
 #include <linux/dma-fence.h>
-#include <linux/completion.h>
 #include <linux/xarray.h>
 #include <linux/workqueue.h>
 
@@ -232,14 +231,6 @@ struct drm_sched_entity {
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
2.55.0

