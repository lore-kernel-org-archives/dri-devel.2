Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEBB2C5CFCF
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 13:42:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D60C10E306;
	Tue, 11 Aug 2026 13:42:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="omcxi/U6";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC5AD898A4;
 Tue, 11 Aug 2026 13:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=RPzjNVF8C7EFpLfYXl4D4kougSt4PbADi4TbQ2ecIR8=; b=omcxi/U63ckTO8Qe5/WXc3HACL
 CVVA1e0hPSOqwY1q1Y631edOysf1StxhPQWepu3AjCO7OCiD8bes3s2UYxNfMEnYTAgGp7XcpB6rv
 WNNzVrrP6o8R6qSpsyDydHjgcvUUc1C5tXXAiu3/Cmcr1/ndzzB8boAgo9gq0XzW1gN2IAJM1UiKS
 VhkQVCPcOlfu5jyfT9k8W6wNzoBINJ0nJFkocgGWpchZfRoF4aEqGIJvjS6fZgCctL64iAlb4jDJS
 2k1xULvKve5uqzgs5BRirFa/WQ7vyrAUrQfbqjnxTUygDOV3+vOrrIluIl8UIznfxGefKNouxE68g
 Nz803n/A==;
Received: from [90.249.211.112] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wtmkN-00H9Kx-3C; Tue, 11 Aug 2026 15:42:27 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Luke.Wildhardt@proton.me,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>
Subject: [PATCH] drm/sched: Ensure monotonic min_vruntime
Date: Tue, 11 Aug 2026 14:42:23 +0100
Message-ID: <20260811134223.96203-1-tvrtko.ursulin@igalia.com>
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
Cc: Luke.Wildhardt@proton.me
Cc: Christian König <christian.koenig@amd.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: Vitaly Prosyak <vitaly.prosyak@amd.com>
---
This reportedly fixes the user reported regression a bit but possibly not
fully. Awaiting further debug since I am not able to locally reproduce it.
---
 drivers/gpu/drm/scheduler/sched_rq.c | 43 +++++++---------------------
 include/drm/gpu_scheduler.h          |  2 ++
 2 files changed, 13 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_rq.c b/drivers/gpu/drm/scheduler/sched_rq.c
index 044546bcb5f8..6b40f0c44fe5 100644
--- a/drivers/gpu/drm/scheduler/sched_rq.c
+++ b/drivers/gpu/drm/scheduler/sched_rq.c
@@ -95,6 +95,7 @@ void drm_sched_rq_init(struct drm_sched_rq *rq)
 	INIT_LIST_HEAD(&rq->entities);
 	rq->rb_tree_root = RB_ROOT_CACHED;
 	rq->head_prio = DRM_SCHED_PRIORITY_INVALID;
+	rq->min_vruntime = 0;
 }
 
 /*
@@ -117,28 +118,6 @@ static const unsigned int vruntime_shift[] = {
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
@@ -148,7 +127,7 @@ drm_sched_entity_save_vruntime(struct drm_sched_entity *entity,
 
 	spin_lock(&stats->lock);
 	vruntime = stats->vruntime;
-	if (min_vruntime && vruntime > min_vruntime)
+	if (ktime_after(vruntime, min_vruntime))
 		vruntime = ktime_sub(vruntime, min_vruntime);
 	else
 		vruntime = 0;
@@ -271,8 +250,8 @@ drm_sched_rq_add_entity(struct drm_sched_entity *entity)
 		list_add_tail(&entity->list, &rq->entities);
 	}
 
-	ts = drm_sched_rq_get_min_vruntime(rq);
-	ts = drm_sched_entity_restore_vruntime(entity, ts, rq->head_prio);
+	ts = drm_sched_entity_restore_vruntime(entity, rq->min_vruntime,
+					       rq->head_prio);
 	drm_sched_rq_update_tree_locked(entity, rq, ts);
 
 	spin_unlock(&rq->lock);
@@ -318,6 +297,7 @@ void drm_sched_rq_pop_entity(struct drm_sched_entity *entity)
 {
 	struct drm_sched_job *next_job;
 	struct drm_sched_rq *rq;
+	ktime_t ts;
 
 	/*
 	 * Update the entity's location in the min heap according to
@@ -326,18 +306,17 @@ void drm_sched_rq_pop_entity(struct drm_sched_entity *entity)
 	spin_lock(&entity->lock);
 	rq = entity->rq;
 	spin_lock(&rq->lock);
+
+	ts = drm_sched_entity_update_vruntime(entity);
+	if (ktime_after(ts, rq->min_vruntime))
+		rq->min_vruntime = ts;
+
 	next_job = drm_sched_entity_queue_peek(entity);
 	if (next_job) {
-		ktime_t ts;
-
-		ts = drm_sched_entity_update_vruntime(entity);
 		drm_sched_rq_update_tree_locked(entity, rq, ts);
 	} else {
-		ktime_t min_vruntime;
-
 		drm_sched_rq_remove_tree_locked(entity, rq);
-		min_vruntime = drm_sched_rq_get_min_vruntime(rq);
-		drm_sched_entity_save_vruntime(entity, min_vruntime);
+		drm_sched_entity_save_vruntime(entity, rq->min_vruntime);
 	}
 	spin_unlock(&rq->lock);
 	spin_unlock(&entity->lock);
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 363d13fc929f..892ef474c5c1 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -252,6 +252,7 @@ struct drm_sched_entity {
  * @entities: list of the entities to be scheduled.
  * @rb_tree_root: root of time based priority queue of entities for FIFO scheduling
  * @head_prio: priority of the top tree element.
+ * @min_vruntime: Minimum virtual runtime for the run-queue.
  *
  * Run queue is a set of entities scheduling command submissions for
  * one specific ring. It implements the scheduling policy that selects
@@ -263,6 +264,7 @@ struct drm_sched_rq {
 	struct list_head		entities;
 	struct rb_root_cached		rb_tree_root;
 	enum drm_sched_priority		head_prio;
+	ktime_t				min_vruntime;
 };
 
 /**
-- 
2.54.0

