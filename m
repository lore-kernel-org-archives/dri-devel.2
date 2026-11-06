Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5983606A32C
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 14:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=X8t3gog6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A588710EA70;
	Fri,  6 Nov 2026 14:57:20 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 604AD10EA63;
 Fri,  6 Nov 2026 14:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=25iTOg2aFag9RR3Nc5GJ+uu/3H2sWz06N145kgL8uAI=; t=1793977031; x=2109337031; 
 b=X8t3gog6egaj2FeFbO+0fVs1otNll3vIBUkE+i7f0QVqDyBBuvaI8PcfDsrJjwxzJWEkoHywm0f
 QYnctIqACBai5dKY44WyJOe2AfK1b1eiwJZfND0SR3x0nqaW51ZiSaEiVccyX0r1bjiJJsrnB4IFT
 K4JkIr+XyqvqYlKFa3K/oEVK6krzfpXD1fKALqitXMoSb4jRsbiuaahiw5fUHML5ObFbiG6Ng79WC
 B21o3sqhnJxbusxOB1G6Tje7kBpXXDVPp6KTuMDE/x6CJrlTIkvPn56ln8txjkVfVCddDKwIhh8FC
 vZ+V1KBHPrmAs0rJ+ec3CuBaUpwjjVdNs6yQ==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xPLNN-004Vna-Ak; Fri, 06 Nov 2026 15:57:09 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>
Subject: [PATCH 7/7] drm/sched: Address the fence_seq fixme
Date: Fri,  6 Nov 2026 14:57:02 +0000
Message-ID: <20261106145702.61640-8-tvrtko.ursulin@igalia.com>
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Address a FIXME against struct drm_sched_entity->fence_seq which
documented this field does not need to be atomic_t.

Indeed now that most of the flow is guarded with entity->lock we can pull
out the lock a step up, to drm_sched_job_arm(), which also simplifies
drm_sched_entity_select_rq() and convert the field to a standard unsigned
long.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 13 ++++---------
 drivers/gpu/drm/scheduler/sched_fence.c  |  6 ++++--
 drivers/gpu/drm/scheduler/sched_main.c   |  7 ++++++-
 include/drm/gpu_scheduler.h              |  7 ++-----
 4 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 9fb5affaab87..63f52d1a8c74 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -168,8 +168,6 @@ int drm_sched_entity_init(struct drm_sched_entity *entity,
 
 	spin_lock_init(&entity->lock);
 	INIT_LIST_HEAD(&entity->job_queue);
-
-	atomic_set(&entity->fence_seq, 0);
 	entity->fence_context = dma_fence_context_alloc(2);
 
 	return 0;
@@ -620,21 +618,21 @@ void drm_sched_entity_select_rq(struct drm_sched_entity *entity)
 	struct drm_gpu_scheduler *sched;
 	struct drm_sched_rq *rq;
 
-	spin_lock(&entity->lock);
+	lockdep_assert_held(&entity->lock);
 
 	/* queue non-empty, stay on the same engine */
 	if (entity->job_credits)
-		goto out;
+		return;
 
 	/* Cannot submit to stopped entity anyway so bail out early. */
 	if (entity->stopped)
-		goto out;
+		return;
 
 	fence = entity->last_scheduled;
 
 	/* stay on the same engine if the previous job hasn't finished */
 	if (fence && !dma_fence_is_signaled(fence))
-		goto out;
+		return;
 
 	if (entity->num_sched_list == 1)
 		sched = entity->sched;
@@ -646,9 +644,6 @@ void drm_sched_entity_select_rq(struct drm_sched_entity *entity)
 		drm_sched_rq_remove_entity(entity->rq, entity);
 		entity->rq = rq;
 	}
-
-out:
-	spin_unlock(&entity->lock);
 }
 
 /**
diff --git a/drivers/gpu/drm/scheduler/sched_fence.c b/drivers/gpu/drm/scheduler/sched_fence.c
index b7a4cb921234..b4c336ff0179 100644
--- a/drivers/gpu/drm/scheduler/sched_fence.c
+++ b/drivers/gpu/drm/scheduler/sched_fence.c
@@ -224,10 +224,12 @@ struct drm_sched_fence *drm_sched_fence_alloc(void *owner,
 void drm_sched_fence_init(struct drm_sched_fence *fence,
 			  struct drm_sched_entity *entity)
 {
-	unsigned seq;
+	unsigned long seq;
+
+	lockdep_assert_held(&entity->lock);
 
 	fence->sched = entity->rq->sched;
-	seq = atomic_inc_return(&entity->fence_seq);
+	seq = ++entity->fence_seq;
 	dma_fence_init(&fence->scheduled, &drm_sched_fence_ops_scheduled,
 		       &fence->lock, entity->fence_context, seq);
 	dma_fence_init(&fence->finished, &drm_sched_fence_ops_finished,
diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 85dc570a4816..61f3f1e8520d 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -607,6 +607,9 @@ void drm_sched_job_arm(struct drm_sched_job *job)
 	struct drm_sched_entity *entity = job->entity;
 
 	BUG_ON(!entity);
+
+	spin_lock(&entity->lock);
+
 	drm_sched_entity_select_rq(entity);
 	sched = entity->rq->sched;
 
@@ -614,7 +617,9 @@ void drm_sched_job_arm(struct drm_sched_job *job)
 	job->s_priority = entity->priority;
 	job->entity_stats = drm_sched_entity_stats_get(entity->stats);
 
-	drm_sched_fence_init(job->s_fence, job->entity);
+	drm_sched_fence_init(job->s_fence, entity);
+
+	spin_unlock(&entity->lock);
 }
 EXPORT_SYMBOL(drm_sched_job_arm);
 
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 0cffb47f151b..6a98eb9f0b4b 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -99,7 +99,7 @@ struct drm_sched_entity {
 	 *
 	 * Lock protecting the @job_queue, run-queue (@rq) to which this entity
 	 * belongs, @priority, @last_scheduled and the list of schedulers
-	 * (@sched_list, @num_sched_list), @rr_ts and @stopped.
+	 * (@sched_list, @num_sched_list), @rr_ts, @stopped and @fence_seq.
 	 */
 	spinlock_t			lock;
 
@@ -200,11 +200,8 @@ struct drm_sched_entity {
 	 *
 	 * A linearly increasing seqno incremented with each new
 	 * &drm_sched_fence which is part of the entity.
-	 *
-	 * FIXME: Callers of drm_sched_job_arm() need to ensure correct locking,
-	 * this doesn't need to be atomic.
 	 */
-	atomic_t			fence_seq;
+	unsigned long			fence_seq;
 
 	/**
 	 * @fence_context:
-- 
2.56.0

