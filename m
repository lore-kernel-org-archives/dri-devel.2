Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CD8606A32C
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 14:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=JxzsWmmG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8652310EA7E;
	Fri,  6 Nov 2026 14:57:21 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 753A910EA7E;
 Fri,  6 Nov 2026 14:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=kke7mX9E+sbBJZCpeJEimA7sW8qvrrhtDygsM+pOJpE=; t=1793977030; x=2109337030; 
 b=JxzsWmmGnSMRqt4FFYYZB4LHbZnTclX0wWXLoWuMdEOxjqMJIienG4GgGyjJC2t5CKhbCxSC8vA
 6fyjVDCBeBS0QMUYKySMTkN3QDnEYFJRyiCRjPkCWrq7E6cS5JjFMptsEqYvIJQzppKNDqD/jHdUg
 WdV8RBlGFUjV4E9MQyV2P2g5lyB47a/ZcQPzbUfxJMWUD5y7t6Z9Xp+eh/JFxGaoUTsVDDbYa1uV/
 97JgYjQGF5kyzg9J0857c3l9gTJQMo2g28Kb1deXLYu6iNtH0Tx5AAs9kFLp2jUJ0t0sCYIXkhgp6
 Ps4WB2p/i1yhVJRur9kKr6cSZ2zPilSLtDAg==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xPLNL-004Vmq-0Q; Fri, 06 Nov 2026 15:57:07 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Luben Tuikov <ltuikov89@gmail.com>,
 Matthew Brost <matthew.brost@intel.com>, Simona Vetter <simona@ffwll.ch>,
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 "Cc: Tomeu Vizoso" <tomeu@tomeuvizoso.net>,
 Sidong Yang <sidong.yang@furiosa.ai>
Subject: [PATCH 4/7] drm/sched: Remove the single scheduler special case
Date: Fri,  6 Nov 2026 14:56:59 +0000
Message-ID: <20261106145702.61640-5-tvrtko.ursulin@igalia.com>
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

Long time ago in commit
b3ac17667f11 ("drm/scheduler: rework entity creation")
a change was made which prevented priority changes for entities with only
one assigned scheduler.

That commit reduced drm_sched_entity_set_priority() to simply update the
entities priority, but the run queue selection logic in
drm_sched_entity_select_rq() was never able to actually change the
originally assigned run queue.

In practice that only affected amdgpu, being the only driver which can do
dynamic priority changes, and it appears it was attempted to rectify this
in commit
2316a86bde49 ("drm/amdgpu: change hw sched list on ctx priority override")
.

A few unresolved problems however remained:

The above only fixed drm_sched_entity_set_priority()
if drm_sched_entity_modify_sched() was called first which was not
documented anywhere.

Secondly, that only worked if drm_sched_entity_modify_sched() is actually
called, which in amdgpu's case is true only for gfx and compute. Priority
changes for other engines, which have only one scheduler assigned such as
jpeg and video decode still did not work.

(Note that this was also noticed in 981b04d96856 ("drm/sched: improve docs
around drm_sched_entity").)

Completely different set of non-obvious confusion was that, whereas
drm_sched_entity_init() was not keeping the passed in list of schedulers
(courtesy of commit
8c23056bdc7a ("drm/scheduler: do not keep a copy of sched list")
), drm_sched_entity_modify_sched() was disagreeing with that and
would simply assign the single item list. That incosistency appears to
have been semi-silently fixed in commit
ac4eb83ab255 ("drm/sched: select new rq even if there is only one v3")
.

What was also not documented is why it was important to not keep the list
of schedulers when there is only one scheduler given. This was in fact due
many of the callers passing in a stack container for this case. For the
multiple schedulers on the other hand amdgpu and rocket are the only such
callers and there the container is not on the stack but correctly follows
the lifetime requirement. Keeping a stack backed list in the entity would
obviously be undefined behaviour if the list was kept.

Having said that, amdgpu however did only stop passing in stack backed
container for the more than one scheduler case in commit
977f7e1068be ("drm/amdgpu: allocate entities on demand")
. Until then dereferencing freed stack from drm_sched_entity_select_rq()
was a possibility.

In order to untangle all this lets make this area behave consistently and
store the single scheduler case directly in the entity. We can do that
easily by creating an union between the current pointer to a list of
schedulers, and a new pointer to the single scheduler.

This allows removal of the special cases which artificially cleared
entity->sched_list for a single scheduler case and fixes the amdgpu
dynamic priority changes for the single IP instances.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Fixes: b3ac17667f11 ("drm/scheduler: rework entity creation")
References: 8c23056bdc7a ("drm/scheduler: do not keep a copy of sched list")
References: 977f7e1068be ("drm/amdgpu: allocate entities on demand")
References: 2316a86bde49 ("drm/amdgpu: change hw sched list on ctx priority override")
References: ac4eb83ab255 ("drm/sched: select new rq even if there is only one v3")
References: 981b04d96856 ("drm/sched: improve docs around drm_sched_entity")
References: 77a6809f1dc3 ("drm/sched: Remove FIFO and RR and simplify to a single run queue")
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Luben Tuikov <ltuikov89@gmail.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: Sidong Yang <sidong.yang@furiosa.ai>
Cc: amd-gfx@lists.freedesktop.org
---
 drivers/gpu/drm/scheduler/sched_entity.c | 30 ++++++++++-------
 include/drm/gpu_scheduler.h              | 42 ++++++++++++++----------
 2 files changed, 44 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 2a827522e23f..3495153ad4e5 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -102,7 +102,9 @@ ktime_t drm_sched_entity_stats_job_add_gpu_time(struct drm_sched_job *job)
  * @guilty: atomic_t set to 1 when a job on this queue
  *          is found to be guilty causing a timeout
  *
- * Note that the &sched_list must have at least one element to schedule the entity.
+ * Note that the &sched_list must have exactly one element to schedule the
+ * entity. Callers which pass more than one scheduler on the @sched_list must
+ * ensure the list remains valid for the lifetime of the entity.
  *
  * For changing @priority later on at runtime see
  * drm_sched_entity_set_priority(). For changing the set of schedulers
@@ -139,7 +141,10 @@ int drm_sched_entity_init(struct drm_sched_entity *entity,
 	entity->guilty = guilty;
 	entity->last_user = current->group_leader;
 	entity->num_sched_list = num_sched_list;
-	entity->sched_list = num_sched_list > 1 ? sched_list : NULL;
+	if (num_sched_list == 1)
+		entity->sched = sched_list[0];
+	else
+		entity->sched_list = sched_list;
 	RB_CLEAR_NODE(&entity->rb_tree_node);
 
 	if (priority >= sched_list[0]->num_user_rqs) {
@@ -178,6 +183,9 @@ EXPORT_SYMBOL(drm_sched_entity_init);
  *		 existing entity->sched_list
  * @num_sched_list: number of drm sched in sched_list
  *
+ * Callers which pass more than one scheduler on the @sched_list must
+ * ensure the list remains valid for the lifetime of the entity.
+ *
  * Note that this must be called under the same common lock for @entity as
  * drm_sched_job_arm() and drm_sched_entity_push_job(), or the driver needs to
  * guarantee through some other means that this is never called while new jobs
@@ -198,7 +206,10 @@ void drm_sched_entity_modify_sched(struct drm_sched_entity *entity,
 	}
 
 	spin_lock(&entity->lock);
-	entity->sched_list = sched_list;
+	if (num_sched_list == 1)
+		entity->sched = sched_list[0];
+	else
+		entity->sched_list = sched_list;
 	entity->num_sched_list = num_sched_list;
 	spin_unlock(&entity->lock);
 }
@@ -587,10 +598,6 @@ void drm_sched_entity_select_rq(struct drm_sched_entity *entity)
 	struct drm_gpu_scheduler *sched;
 	struct drm_sched_rq *rq;
 
-	/* single possible engine and already selected */
-	if (!entity->sched_list)
-		return;
-
 	/* queue non-empty, stay on the same engine */
 	if (spsc_queue_count(&entity->job_queue))
 		return;
@@ -607,16 +614,17 @@ void drm_sched_entity_select_rq(struct drm_sched_entity *entity)
 	if (fence && !dma_fence_is_signaled(fence))
 		goto out;
 
-	sched = drm_sched_pick_best(entity->sched_list, entity->num_sched_list);
+	if (entity->num_sched_list == 1)
+		sched = entity->sched;
+	else
+		sched = drm_sched_pick_best(entity->sched_list,
+					    entity->num_sched_list);
 	rq = sched ? sched->sched_rq[entity->rq_priority] : NULL;
 	if (rq != entity->rq) {
 		drm_sched_rq_remove_entity(entity->rq, entity);
 		entity->rq = rq;
 	}
 
-	if (entity->num_sched_list == 1)
-		entity->sched_list = NULL;
-
 out:
 	spin_unlock(&entity->lock);
 }
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index c89a581f54bf..dfa399ace89f 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -120,23 +120,31 @@ struct drm_sched_entity {
 	 */
 	struct drm_sched_entity_stats	*stats;
 
-	/**
-	 * @sched_list:
-	 *
-	 * A list of schedulers (struct drm_gpu_scheduler).  Jobs from this entity can
-	 * be scheduled on any scheduler on this list.
-	 *
-	 * This can be modified by calling drm_sched_entity_modify_sched().
-	 * Locking is entirely up to the driver, see the above function for more
-	 * details.
-	 *
-	 * This will be set to NULL if &num_sched_list equals 1 and @rq has been
-	 * set already.
-	 *
-	 * FIXME: This means priority changes through
-	 * drm_sched_entity_set_priority() will be lost henceforth in this case.
-	 */
-	struct drm_gpu_scheduler        **sched_list;
+	union {
+		/**
+		 * @sched_list:
+		 *
+		 * A list of schedulers (struct drm_gpu_scheduler).  Jobs from
+		 * this entity can be scheduled on any scheduler on this list.
+		 *
+		 * This can be modified by calling
+		 * drm_sched_entity_modify_sched(). Locking is entirely up to
+		 * the driver, see the above function for more details.
+		 */
+		struct drm_gpu_scheduler        **sched_list;
+
+		/**
+		 * @sched:
+		 *
+		 * A single struct drm_gpu_scheduler jobs from this entity will
+		 * be scheduled on.
+		 *
+		 * This can be modified by calling
+		 * drm_sched_entity_modify_sched(). Locking is entirely up to
+		 * the driver, see the above function for more details.
+		 */
+		struct drm_gpu_scheduler        *sched;
+	};
 
 	/**
 	 * @num_sched_list:
-- 
2.56.0

