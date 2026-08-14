Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6DEAC5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 07:57:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D4CD10F3EF;
	Fri, 14 Aug 2026 07:57:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Ean71xlV";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ED0C10F3F5;
 Fri, 14 Aug 2026 07:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=FlsaeBieZrbIa/BOohisaNfrc5gra+pstA/KS7KfUO4=; b=Ean71xlVThDCm01v1Ofx7JGBFG
 ChpcCSeqU0ulQcTMMxMmNmL/GcigLW+UpMMSqzM92l1AQ9EKh9Y2rBgWT4bdpwMgDmFUdVSoxVQi6
 v1jLlUZD+EN2w9zqvXz3pvgZqQUzrFm0dwvgsfqSRe1QMMg0Nm/e4jAnH68Q8YzgXuGqfA/JQnaJX
 fPJY81X7TwpchEas494QMmol3hBTiwyzmTUZAYfZ5trXBU/nLIttaJAf0NTR7DX9o1GaO3E8qvu96
 QKkdYUDR47sTmzJvkT6+grBcfC4HXy1dmf9QtIBCY8k4MJyj4laOpmT6V6sSHSRp4jqwQiJdpEFRq
 fFTJ6MzA==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wumnX-001ds6-HY; Fri, 14 Aug 2026 09:57:51 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Luke.Wildhardt@proton.me,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>
Subject: [PATCH 2/2] drm/sched: Ensure monotonic min_vruntime
Date: Fri, 14 Aug 2026 08:57:39 +0100
Message-ID: <20260814075739.32481-3-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260814075739.32481-1-tvrtko.ursulin@igalia.com>
References: <20260814075739.32481-1-tvrtko.ursulin@igalia.com>
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

min_vruntime handling had a bug where if an entity never exited the run-
queue it could get penalised by its virtual runtime only ever growing,
while the periodically exiting and re-joining entities could repeatedly
get pulled ahead of it.

Fix it by making the min_vruntime strictly monotonic by tracking it
separately (an keeping it always up to date) instead of fetching what
happens to be the top of the tree sorted by virtual runtime.

While at it replace open coded ktime_t comparison with the correct
ktime_after() helper.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Fixes: 2fa4d8e2c109 ("drm/sched: Add fair scheduling policy")
Tested-by: Luke.Wildhardt@proton.me
Cc: Christian König <christian.koenig@amd.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Luke.Wildhardt@proton.me
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: Vitaly Prosyak <vitaly.prosyak@amd.com>
---
 drivers/gpu/drm/scheduler/sched_rq.c | 65 ++++++++--------------------
 include/drm/gpu_scheduler.h          |  2 +
 2 files changed, 21 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_rq.c b/drivers/gpu/drm/scheduler/sched_rq.c
index 23f46ec610e7..bc8363974a27 100644
--- a/drivers/gpu/drm/scheduler/sched_rq.c
+++ b/drivers/gpu/drm/scheduler/sched_rq.c
@@ -98,6 +98,7 @@ void drm_sched_rq_init(struct drm_gpu_scheduler *sched,
 	rq->rb_tree_root = RB_ROOT_CACHED;
 	rq->sched = sched;
 	rq->head_prio = DRM_SCHED_PRIORITY_INVALID;
+	rq->min_vruntime = 0;
 }
 
 /*
@@ -120,28 +121,6 @@ static const unsigned int vruntime_shift[] = {
 	[DRM_SCHED_PRIORITY_LOW]    = 7,
 };
 
-static ktime_t
-drm_sched_rq_get_min_vruntime(struct drm_sched_rq *rq)
-{
-	ktime_t vruntime = 0;
-	struct rb_node *rb;
-
-	lockdep_assert_held(&rq->lock);
-
-	rb = rb_first_cached(&rq->rb_tree_root);
-	if (rb) {
-		struct drm_sched_entity *entity =
-			rb_entry(rb, typeof(*entity), rb_tree_node);
-		struct drm_sched_entity_stats *stats = entity->stats;
-
-		spin_lock(&stats->lock);
-		vruntime = stats->vruntime;
-		spin_unlock(&stats->lock);
-	}
-
-	return vruntime;
-}
-
 static void
 drm_sched_entity_save_vruntime(struct drm_sched_entity *entity,
 			       ktime_t min_vruntime)
@@ -151,7 +130,7 @@ drm_sched_entity_save_vruntime(struct drm_sched_entity *entity,
 
 	spin_lock(&stats->lock);
 	vruntime = stats->vruntime;
-	if (min_vruntime && vruntime > min_vruntime)
+	if (ktime_after(vruntime, min_vruntime))
 		vruntime = ktime_sub(vruntime, min_vruntime);
 	else
 		vruntime = 0;
@@ -239,11 +218,6 @@ static ktime_t drm_sched_entity_update_vruntime(struct drm_sched_entity *entity)
 	return runtime;
 }
 
-static ktime_t drm_sched_entity_get_job_ts(struct drm_sched_entity *entity)
-{
-	return drm_sched_entity_update_vruntime(entity);
-}
-
 /**
  * drm_sched_rq_add_entity - add an entity
  * @entity: scheduler entity
@@ -276,13 +250,11 @@ drm_sched_rq_add_entity(struct drm_sched_entity *entity, ktime_t ts)
 		list_add_tail(&entity->list, &rq->entities);
 	}
 
-	if (drm_sched_policy == DRM_SCHED_POLICY_FAIR) {
-		ts = drm_sched_rq_get_min_vruntime(rq);
-		ts = drm_sched_entity_restore_vruntime(entity, ts,
+	if (drm_sched_policy == DRM_SCHED_POLICY_FAIR)
+		ts = drm_sched_entity_restore_vruntime(entity, rq->min_vruntime,
 						       rq->head_prio);
-	} else if (drm_sched_policy == DRM_SCHED_POLICY_RR) {
+	else if (drm_sched_policy == DRM_SCHED_POLICY_RR)
 		ts = entity->rr_ts;
-	}
 
 	drm_sched_rq_update_fifo_locked(entity, rq, ts);
 
@@ -342,6 +314,7 @@ void drm_sched_rq_pop_entity(struct drm_sched_entity *entity)
 {
 	struct drm_sched_rq *rq = entity->rq;
 	struct drm_sched_job *next_job;
+	ktime_t ts;
 
 	lockdep_assert_held(&entity->lock);
 
@@ -351,27 +324,27 @@ void drm_sched_rq_pop_entity(struct drm_sched_entity *entity)
 	 * Update the entity's location in the min heap according to
 	 * the timestamp of the next job, if any.
 	 */
+
+	if (drm_sched_policy == DRM_SCHED_POLICY_FAIR) {
+		ts = drm_sched_entity_update_vruntime(entity);
+		if (ktime_after(ts, rq->min_vruntime))
+			rq->min_vruntime = ts;
+	}
+
 	next_job = drm_sched_entity_queue_peek(entity);
 	if (next_job) {
-		ktime_t ts;
-
-		if (drm_sched_policy == DRM_SCHED_POLICY_FAIR)
-			ts = drm_sched_entity_get_job_ts(entity);
-		else if (drm_sched_policy == DRM_SCHED_POLICY_FIFO)
+		if (drm_sched_policy == DRM_SCHED_POLICY_FIFO)
 			ts = next_job->submit_ts;
-		else
+		else if (drm_sched_policy == DRM_SCHED_POLICY_RR)
 			ts = drm_sched_rq_next_rr_ts(rq, entity);
 
 		drm_sched_rq_update_fifo_locked(entity, rq, ts);
 	} else {
+		if (drm_sched_policy == DRM_SCHED_POLICY_FAIR)
+			drm_sched_entity_save_vruntime(entity,
+						       rq->min_vruntime);
+
 		drm_sched_rq_remove_fifo_locked(entity, rq);
-
-		if (drm_sched_policy == DRM_SCHED_POLICY_FAIR) {
-			ktime_t min_vruntime;
-
-			min_vruntime = drm_sched_rq_get_min_vruntime(rq);
-			drm_sched_entity_save_vruntime(entity, min_vruntime);
-		}
 	}
 
 	spin_unlock(&rq->lock);
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 7a64cc11de08..92d1a6ff9ac0 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -267,6 +267,7 @@ struct drm_sched_entity {
  * @entities: list of the entities to be scheduled.
  * @rb_tree_root: root of time based priority queue of entities for FIFO scheduling
  * @head_prio: priority of the top tree element.
+ * @min_vruntime: Minimum virtual runtime for the run-queue.
  *
  * Run queue is a set of entities scheduling command submissions for
  * one specific ring. It implements the scheduling policy that selects
@@ -281,6 +282,7 @@ struct drm_sched_rq {
 	struct list_head		entities;
 	struct rb_root_cached		rb_tree_root;
 	enum drm_sched_priority		head_prio;
+	ktime_t				min_vruntime;
 };
 
 /**
-- 
2.54.0

