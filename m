Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B905AF4369A
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 10:38:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B85710EA11;
	Fri, 17 Apr 2026 10:38:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Em6cfYfA";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3588310E9F1;
 Fri, 17 Apr 2026 10:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=or7zGA9oOW3ttwJuv0u+7lWCQG6TVsUZFSuBRV9lyP4=; b=Em6cfYfAacRBSZiyXBvLwwvSBj
 LCEzD5I/kCCkTVPc4niUpne1pZAZPYjwswdKIomXoxhICoUWpu4ZWpj0389dndTciNdD/CZ5igPIY
 cBdOAkOWndKCH7FITy0IVE39NMG52OjoieIo4QWsXwqiNNK5j/XDuOOucyRNX+atOu6nircM00ew3
 Knj0uHJwA6BCTk173AxwJezM++wH3YYww2t3d1waHrmqHhhzat5sdW+wXxeet2AvcrekUlk6knRCs
 P8TMWgM2yr5072cz6oXrFe4GJQ4RZf1qWsLdlC6wT2fFjXA82KQVcA8T02Eq06zAhGgd6taHDx1GW
 msxHF9UA==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wDgaD-00HPR8-Ev; Fri, 17 Apr 2026 12:37:57 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org, kernel-dev@igalia.com,
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH v8 11/29] drm/sched: Favour interactive clients slightly
Date: Fri, 17 Apr 2026 11:37:26 +0100
Message-ID: <20260417103744.76020-12-tvrtko.ursulin@igalia.com>
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

GPUs do not always implement preemption and DRM scheduler definitely
does not support it at the front end scheduling level. This means
execution quanta can be quite long and is controlled by userspace,
consequence of which is picking the "wrong" entity to run can have a
larger negative effect than it would have with a virtual runtime based CPU
scheduler.

Another important consideration is that rendering clients often have
shallow submission queues, meaning they will be entering and exiting the
scheduler's runnable queue often.

Relevant scenario here is what happens when an entity re-joins the
runnable queue with other entities already present. One cornerstone of the
virtual runtime algorithm is to let it re-join at the head and rely on the
virtual runtime accounting and timeslicing to sort it out.

However, as explained above, this may not work perfectly in the GPU world.
Entity could always get to overtake the existing entities, or not,
depending on the submission order and rbtree equal key insertion
behaviour.

Allow interactive jobs to overtake entities already queued up for the
limited case when interactive entity is re-joining the queue after
being idle.

This gives more opportunity for the compositors to have their rendering
executed before the GPU hogs even if they have been configured with the
same scheduling priority.

To classify a client as interactive we look at its average job duration
versus the average for the whole scheduler. We can track this easily by
plugging into the existing job runtime tracking and applying the
exponential moving average window on the past submissions. Then, all other
things being equal, we let the more interactive jobs go first.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Acked-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_entity.c   | 13 ++++++++++---
 drivers/gpu/drm/scheduler/sched_internal.h |  5 ++++-
 drivers/gpu/drm/scheduler/sched_main.c     |  8 +++++++-
 drivers/gpu/drm/scheduler/sched_rq.c       | 22 ++++++++++++++++++++--
 include/drm/gpu_scheduler.h                |  5 +++++
 5 files changed, 46 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index b57bafc42feb..672b5c57ed8e 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -59,6 +59,7 @@ static struct drm_sched_entity_stats *drm_sched_entity_stats_new(void)
 
 	kref_init(&stats->kref);
 	spin_lock_init(&stats->lock);
+	ewma_drm_sched_avgtime_init(&stats->avg_job_us);
 
 	return stats;
 }
@@ -68,19 +69,25 @@ static struct drm_sched_entity_stats *drm_sched_entity_stats_new(void)
  * @job: Scheduler job to account.
  *
  * Accounts the execution time of @job to its respective entity stats object.
+ *
+ * Return: Job's real duration in micro seconds.
  */
-void drm_sched_entity_stats_job_add_gpu_time(struct drm_sched_job *job)
+ktime_t drm_sched_entity_stats_job_add_gpu_time(struct drm_sched_job *job)
 {
 	struct drm_sched_entity_stats *stats = job->entity_stats;
 	struct drm_sched_fence *s_fence = job->s_fence;
-	ktime_t start, end;
+	ktime_t start, end, duration;
 
 	start = dma_fence_timestamp(&s_fence->scheduled);
 	end = dma_fence_timestamp(&s_fence->finished);
+	duration = ktime_sub(end, start);
 
 	spin_lock(&stats->lock);
-	stats->runtime = ktime_add(stats->runtime, ktime_sub(end, start));
+	stats->runtime = ktime_add(stats->runtime, duration);
+	ewma_drm_sched_avgtime_add(&stats->avg_job_us, ktime_to_us(duration));
 	spin_unlock(&stats->lock);
+
+	return duration;
 }
 
 /**
diff --git a/drivers/gpu/drm/scheduler/sched_internal.h b/drivers/gpu/drm/scheduler/sched_internal.h
index 64acd4b7a918..a901801fce85 100644
--- a/drivers/gpu/drm/scheduler/sched_internal.h
+++ b/drivers/gpu/drm/scheduler/sched_internal.h
@@ -14,6 +14,7 @@
  * @runtime: time entity spent on the GPU.
  * @prev_runtime: previous @runtime used to get the runtime delta.
  * @vruntime: virtual runtime as accumulated by the fair algorithm.
+ * @avg_job_us: average job duration.
  *
  * Because jobs and entities have decoupled lifetimes, ie. we cannot access the
  * entity once the job has been de-queued, and we do need know how much GPU time
@@ -26,6 +27,8 @@ struct drm_sched_entity_stats {
 	ktime_t		runtime;
 	ktime_t		prev_runtime;
 	ktime_t		vruntime;
+
+	struct ewma_drm_sched_avgtime   avg_job_us;
 };
 
 /* Used to choose between FIFO and RR job-scheduling */
@@ -146,6 +149,6 @@ drm_sched_entity_stats_put(struct drm_sched_entity_stats *stats)
 	kref_put(&stats->kref, drm_sched_entity_stats_release);
 }
 
-void drm_sched_entity_stats_job_add_gpu_time(struct drm_sched_job *job);
+ktime_t drm_sched_entity_stats_job_add_gpu_time(struct drm_sched_job *job);
 
 #endif
diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 0aca41b4e334..337db7b1e688 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -1004,7 +1004,12 @@ static void drm_sched_free_job_work(struct work_struct *w)
 	struct drm_sched_job *job;
 
 	while ((job = drm_sched_get_finished_job(sched))) {
-		drm_sched_entity_stats_job_add_gpu_time(job);
+		ktime_t duration = drm_sched_entity_stats_job_add_gpu_time(job);
+
+		/* Serialized by the worker. */
+		ewma_drm_sched_avgtime_add(&sched->avg_job_us,
+					   ktime_to_us(duration));
+
 		sched->ops->free_job(job);
 	}
 
@@ -1165,6 +1170,7 @@ int drm_sched_init(struct drm_gpu_scheduler *sched, const struct drm_sched_init_
 	atomic_set(&sched->_score, 0);
 	atomic64_set(&sched->job_id_count, 0);
 	sched->pause_submit = false;
+	ewma_drm_sched_avgtime_init(&sched->avg_job_us);
 
 	sched->ready = true;
 	return 0;
diff --git a/drivers/gpu/drm/scheduler/sched_rq.c b/drivers/gpu/drm/scheduler/sched_rq.c
index 8fec2d0c5a43..0464d324d98d 100644
--- a/drivers/gpu/drm/scheduler/sched_rq.c
+++ b/drivers/gpu/drm/scheduler/sched_rq.c
@@ -165,13 +165,21 @@ drm_sched_entity_restore_vruntime(struct drm_sched_entity *entity,
 				  enum drm_sched_priority rq_prio)
 {
 	struct drm_sched_entity_stats *stats = entity->stats;
+	struct drm_gpu_scheduler *sched = entity->rq->sched;
 	enum drm_sched_priority prio = entity->priority;
+	unsigned long avg_us, sched_avg_us;
 	ktime_t vruntime;
 
 	BUILD_BUG_ON(DRM_SCHED_PRIORITY_NORMAL < DRM_SCHED_PRIORITY_HIGH);
 
 	spin_lock(&stats->lock);
 	vruntime = stats->vruntime;
+	avg_us = ewma_drm_sched_avgtime_read(&stats->avg_job_us);
+	/*
+	 * Unlocked read of the scheduler average is fine since it is just
+	 * heuristics and data type is a natural word size.
+	 */
+	sched_avg_us = ewma_drm_sched_avgtime_read(&sched->avg_job_us);
 
 	/*
 	 * Special handling for entities which were picked from the top of the
@@ -181,14 +189,24 @@ drm_sched_entity_restore_vruntime(struct drm_sched_entity *entity,
 		if (prio > rq_prio) {
 			/*
 			 * Lower priority should not overtake higher when re-
-			 * joining at the top of the queue.
+			 * joining at the top of the queue so push it back
+			 * somewhere behind the "middle" of the run-queue,
+			 * proportional to the scheduler and entity average job
+			 * durations.
 			 */
-			vruntime = ns_to_ktime(prio - rq_prio);
+			vruntime = us_to_ktime((1 + avg_us + sched_avg_us) <<
+					       vruntime_shift[prio]);
 		} else if (prio < rq_prio) {
 			/*
 			 * Higher priority can go first.
 			 */
 			vruntime = -ns_to_ktime(rq_prio - prio);
+		} else {
+			/* Favour entity with shorter jobs (interactivity). */
+			if (avg_us <= sched_avg_us)
+				vruntime = -ns_to_ktime(1);
+			else
+				vruntime = ns_to_ktime(1);
 		}
 	}
 
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 69c2097664fd..790f7ecb6b85 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -25,11 +25,14 @@
 #define _DRM_GPU_SCHEDULER_H_
 
 #include <drm/spsc_queue.h>
+#include <linux/average.h>
 #include <linux/dma-fence.h>
 #include <linux/completion.h>
 #include <linux/xarray.h>
 #include <linux/workqueue.h>
 
+DECLARE_EWMA(drm_sched_avgtime, 6, 4);
+
 #define MAX_WAIT_SCHED_ENTITY_Q_EMPTY msecs_to_jiffies(1000)
 
 /**
@@ -582,6 +585,7 @@ struct drm_sched_backend_ops {
  * @job_id_count: used to assign unique id to the each job.
  * @submit_wq: workqueue used to queue @work_run_job and @work_free_job
  * @timeout_wq: workqueue used to queue @work_tdr
+ * @avg_job_us: Average job duration.
  * @work_run_job: work which calls run_job op of each scheduler.
  * @work_free_job: work which calls free_job op of each scheduler.
  * @work_tdr: schedules a delayed call to @drm_sched_job_timedout after the
@@ -613,6 +617,7 @@ struct drm_gpu_scheduler {
 	atomic64_t			job_id_count;
 	struct workqueue_struct		*submit_wq;
 	struct workqueue_struct		*timeout_wq;
+	struct ewma_drm_sched_avgtime   avg_job_us;
 	struct work_struct		work_run_job;
 	struct work_struct		work_free_job;
 	struct delayed_work		work_tdr;
-- 
2.52.0

