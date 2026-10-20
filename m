Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFC8606A33D
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 15:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=ZC1WWmKp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10B5110EA0C;
	Tue, 20 Oct 2026 15:41:41 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79A6210F6B9;
 Tue, 20 Oct 2026 15:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=8eqbyeceds/a6sRupT2Crs/iR/skLO/2uc7iHsNYrII=; b=ZC1WWmKpGNjyKuErxKoNOpqUIZ
 9Ciyhjw/hENuLQ26IcM7XRDjI45IZ6D66U65ANye5CG/0x9fktXQYx/kUlc4P9fUtJ2EkqFWBpK8L
 +jhJ6txpKf/KT5IF0f+bJl2UA6ImCtIS2bjMGIs41fUKlvnbelu6AjeKr3hfxUkdhNKXh32wE0mIo
 v7f7x090v+jaBaH2bTKtZbl9GGvE0oFfvcJnhEruKKB/DWzqe+3OCcqeGI4IhYvFydPbkGDva6NC9
 wM5YIvANTOAcYpNtYGK7osIupTTscbmDwL9GC9BrwNWzqkOmdIj5RWvVWmJ19juPlb5EAxSDMyhvT
 RrxmBWDA==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xJBxy-004iea-LS; Tue, 20 Oct 2026 17:41:30 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>, intel-xe@lists.freedesktop.org
Subject: [PATCH v2 7/8] drm/sched: Replace completion with a flush
Date: Tue, 20 Oct 2026 16:41:22 +0100
Message-ID: <20261020154123.33631-8-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261020154123.33631-1-tvrtko.ursulin@igalia.com>
References: <20261020154123.33631-1-tvrtko.ursulin@igalia.com>
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
index 85a49e219837..281a1e7f89a9 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -1033,7 +1033,6 @@ static void drm_sched_run_job_work(struct work_struct *w)
 
 	sched_job = drm_sched_entity_pop_job(entity);
 	if (!sched_job) {
-		complete_all(&entity->entity_idle);
 		drm_sched_run_job_queue(sched);
 		return;
 	}
@@ -1049,7 +1048,6 @@ static void drm_sched_run_job_work(struct work_struct *w)
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
2.56.0

