Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492FF606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 14:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=itLuiafw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BABA10F57E;
	Fri,  6 Nov 2026 14:57:24 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 185EF10F76C;
 Fri,  6 Nov 2026 14:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=MHR78M3S8W2zWkL8jOA+2W8vCx4JOlRYc/ASvlDShK4=; t=1793977030; x=2109337030; 
 b=itLuiafw3agejS7EQfk6mmc6x0wB+ztVjd3U7iIc/4ArxKNkmeEVeF4bgWxNc89zt9CnWRk33yO
 uI0Z5Xs0TnaYLAN60o1uou5YRItrySB0gmhLzf8OmM/ipyc8QUAszCrJX5aODD/iYkz16jxgxOyoS
 v/7fgSFKbEtKBsfTulVsQ5p0wU0ZoVaMp3mdcuqtraeGov0TgxGD9ZvqeudWJU8TezJpWCb1IR+7A
 9nUoDNFfGlFcNCaoMB+/VizVVtNxb5U3LXJYSfkwBPT+5zbSU+EgCvnZ1cZeqWXJNVbtsD5xUvU/Y
 9vZuT0Drd+WUwOuicb05v6dUePm1mMqmjhFg==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xPLNL-004Vmw-PT; Fri, 06 Nov 2026 15:57:07 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>,
 Matthew Brost <matthew.brost@intel.com>, Simona Vetter <simona@ffwll.ch>,
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>
Subject: [PATCH 5/7] drm/amdgpu: Rework the
 amdgpu_job_stop_all_jobs_on_sched() hack
Date: Fri,  6 Nov 2026 14:57:00 +0000
Message-ID: <20261106145702.61640-6-tvrtko.ursulin@igalia.com>
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

amdgpu_job_stop_all_jobs_on_sched is a semi broken hack used on only one
platform which suffers from several problems as mentioned in
https://lore.kernel.org/amd-gfx/44edde63-7181-44fb-a4f7-94e50514f539@amd.com/.

Until it can be fully removed, given that it directly acceses DRM scheduler
internals which want to be changed, we need to rework it to allow for
replacing the SPSC queue with a standard spin locked list.

Problem at hand is the lock inversion between the run-queue and entity
lock which becomes apparent once locking is added to the job queue
amdgpu_job_stop_all_jobs_on_sched().

To work around it we change the approach of how queued jobs are drained by
using trylock and restarting on locked entities until all queued jobs from
all active entities are removed.

This slightly widens the existing scope for a live lock in case of
userspace actively submitting new jobs. Whereas the current code can keep
processing the single busy entity, this new implementation can retry on the
entities which it previously processed.

Since userspace submitting jobs so rapidly the GPU reset cannot finish and
the problem already exists, plus the plan is to remove this code
altogether, we can say this is acceptable in order to unblock the DRM
scheduler rework.

While at it we add the assert scheduler workqueue has been stopped by the
caller and also correct the wrong order of signalling already submitted
and queued fences.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
References: https://lore.kernel.org/amd-gfx/44edde63-7181-44fb-a4f7-94e50514f539@amd.com/
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 86 ++++++++++++++++++++-----
 1 file changed, 69 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 8689a3c933b2..1f4a4a5a978d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -457,13 +457,6 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
 	return fence;
 }
 
-/*
- * This is a duplicate function from DRM scheduler sched_internal.h.
- * Plan is to remove it when amdgpu_job_stop_all_jobs_on_sched is removed, due
- * latter being incorrect and racy.
- *
- * See https://lore.kernel.org/amd-gfx/44edde63-7181-44fb-a4f7-94e50514f539@amd.com/
- */
 static struct drm_sched_job *
 drm_sched_entity_queue_pop(struct drm_sched_entity *entity)
 {
@@ -476,28 +469,66 @@ drm_sched_entity_queue_pop(struct drm_sched_entity *entity)
 	return container_of(node, struct drm_sched_job, queue_node);
 }
 
-void amdgpu_job_stop_all_jobs_on_sched(struct drm_gpu_scheduler *sched)
+static struct drm_sched_entity *
+get_entity_with_jobs(struct drm_gpu_scheduler *sched) __acquires(&entity->lock)
 {
-	struct drm_sched_job *s_job;
-	struct drm_sched_entity *s_entity = NULL;
+	struct drm_sched_entity *entity;
 	int i;
 
-	/* Signal all jobs not yet scheduled */
+retry:
 	for (i = DRM_SCHED_PRIORITY_KERNEL; i < sched->num_rqs; i++) {
 		struct drm_sched_rq *rq = sched->sched_rq[i];
+
 		spin_lock(&rq->lock);
-		list_for_each_entry(s_entity, &rq->entities, list) {
-			while ((s_job = drm_sched_entity_queue_pop(s_entity))) {
-				struct drm_sched_fence *s_fence = s_job->s_fence;
+		list_for_each_entry(entity, &rq->entities, list) {
+			/*
+			 * This can false negative, but so could the previous
+			 * approach of scanning the run-queues once when
+			 * nothing prevents userspace to queue more jobs.
+			 */
+			if (!spsc_queue_count(&entity->job_queue))
+				continue;
 
-				dma_fence_signal(&s_fence->scheduled);
-				dma_fence_set_error(&s_fence->finished, -EHWPOISON);
-				dma_fence_signal(&s_fence->finished);
+			/*
+			 * We must trylock because normal locking order is
+			 * entity then rq and here we already have rq locked
+			 * in order to be able to walk the entities.
+			 */
+			if (spin_trylock(&entity->lock)) {
+				/* Returns with a locked entity. */
+				spin_unlock(&rq->lock);
+				return entity;
+			} else {
+				/*
+				 * Busy entity - we will try again looking for a
+				 * window where trylock will succeed.
+				 */
+				spin_unlock(&rq->lock);
+				goto retry;
 			}
 		}
 		spin_unlock(&rq->lock);
 	}
 
+	return NULL;
+}
+
+/*
+ * amdgpu_job_stop_all_jobs_on_sched has a single purpose which is an
+ * unreliable and racy, as described in:
+ *  https://lore.kernel.org/amd-gfx/44edde63-7181-44fb-a4f7-94e50514f539@amd.com/.
+ *
+ * Plan is to remove it, together with the above open coded DRM scheduler
+ * helpers, and replace with a proper solution.
+ */
+void amdgpu_job_stop_all_jobs_on_sched(struct drm_gpu_scheduler *sched)
+{
+	struct drm_sched_job *s_job, *next;
+	struct drm_sched_entity *s_entity;
+	LIST_HEAD(queued);
+
+	WARN_ON_ONCE(!sched->pause_submit);
+
 	/* Signal all jobs already scheduled to HW */
 	list_for_each_entry(s_job, &sched->pending_list, list) {
 		struct drm_sched_fence *s_fence = s_job->s_fence;
@@ -505,6 +536,27 @@ void amdgpu_job_stop_all_jobs_on_sched(struct drm_gpu_scheduler *sched)
 		dma_fence_set_error(&s_fence->finished, -EHWPOISON);
 		dma_fence_signal(&s_fence->finished);
 	}
+
+	/*
+	 * Signal all jobs not yet scheduled - note that the entity trylock loop
+	 * can in theory livelock if userspace keeps submitting new jobs more
+	 * rapidly than the loop can do a full pass over all run-queues and
+	 * entities.
+	 */
+	while ((s_entity = get_entity_with_jobs(sched)) != NULL) {
+		while ((s_job = drm_sched_entity_queue_pop(s_entity)))
+			list_add_tail(&s_job->list, &queued);
+		spin_unlock(&s_entity->lock);
+	}
+
+	list_for_each_entry_safe(s_job, next, &queued, list) {
+		struct drm_sched_fence *s_fence = s_job->s_fence;
+
+		list_del(&s_job->list);
+		dma_fence_signal(&s_fence->scheduled);
+		dma_fence_set_error(&s_fence->finished, -EHWPOISON);
+		dma_fence_signal(&s_fence->finished);
+	}
 }
 
 const struct drm_sched_backend_ops amdgpu_sched_ops = {
-- 
2.56.0

