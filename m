Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC6BECD6E60
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 15:37:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3907010F30A;
	Tue,  2 Jun 2026 15:37:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="egxdB9Hd";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8329D10F30E;
 Tue,  2 Jun 2026 15:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=VRswJGJ8yg61yQfcejQ1JtTQNATW5kG9uagybI5jEJI=; b=egxdB9HdwdPtraMT6J6MDsMkzX
 VDMsEz+ZJelteddUylLFipQOW2Np/5MZbfqYlML5uapSf7xc/vnc80LB1GECvDgNGCMrLreBbO7qk
 snATQDs0wFMWjI6PJXIYb+QKwCiGb9m2N4nsGtFZvP0+XqGoufN489nWflitBWAzz3XlISxfVilAN
 YrM2fWHGSog3fNN0ETfL4qfzRALyy30Xst8BGqZQMb68tLiIbaKqNHeBy8gcLhiqJp+tlWv72nNq4
 ywYScFhkikrAqyQN8Ec3EpmnAbZXiEj/mWc39xWwISNCPd3ZC8HzdpNFp3bLRBikeEKtaifojmiJh
 ntWa9GMg==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wURBX-00BlsD-SJ; Tue, 02 Jun 2026 17:37:44 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Luben Tuikov <ltuikov89@gmail.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, Danilo Krummrich <dakr@kernel.org>,
 Philipp Stanner <phasta@kernel.org>, amd-gfx@lists.freedesktop.org
Subject: [RFC] drm/sched: Untangle the scheduler list mess
Date: Tue,  2 Jun 2026 16:37:37 +0100
Message-ID: <20260602153737.43528-1-tvrtko.ursulin@igalia.com>
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

A few unresolved problems remained - this only fixed
drm_sched_entity_set_priority() if drm_sched_entity_modify_sched() was
called first, which was not documented anywhere.

Secondly, that only worked if drm_sched_entity_modify_sched() is actually
called, which in amdgpu's case is true only for gfx and compute. Priority
changes for other engines, which have only one scheduler assigned such as
jpeg and video decode still did not work.

(Note that this was also noticed in 981b04d96856 ("drm/sched: improve docs
around drm_sched_entity").)

The last problem was ultimately indirectly fixed by the removal of multiple
run-queues in commit
77a6809f1dc3 ("drm/sched: Remove FIFO and RR and simplify to a single run queue")
. After that commit all drivers and all engines (queue types) can now do
dynamic priority changes if they so wish.

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
of schedulers when there is only one scheduler is given. This was in fact
due many of the callers passing in a stack container for this case. For
the multiple schedulers on the other hand, amdgpu is the only such caller,
and there the container is not on the stack. Keeping a stack backed list
in the entity would obviously be undefined behaviour if the list was kept.

Amdgpu however did only stop passing in stack backed container for the more
than one scheduler case in commit
977f7e1068be ("drm/amdgpu: allocate entities on demand")
. Until then dereferencing freed stack from drm_sched_entity_select_rq()
was a possibility.

In order to untangle all this, document how the scheduler behaves, and
make it behave consistently and sensibly, lets make the entity own its own
copy of the scheduler list. This allows removal of the special cases which
needed to artificially clear entity->sched_list for a single scheduler
case. Individual scheduler pointers are still owned by the driver with
unchanged lifetime rules.

To enable maintaining its own container some API calls needed to grow a
capability for returning success/failure, which is a change which
percolates mostly through amdgpu.

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
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: amd-gfx@lists.freedesktop.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c   | 31 ++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c | 13 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c     |  3 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c     |  3 +-
 drivers/gpu/drm/scheduler/sched_entity.c  | 75 +++++++++++++++++------
 include/drm/gpu_scheduler.h               | 48 +++++++++------
 7 files changed, 114 insertions(+), 61 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 7af86a32c0c5..94c59464dd01 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -817,15 +817,15 @@ struct dma_fence *amdgpu_ctx_get_fence(struct amdgpu_ctx *ctx,
 	return fence;
 }
 
-static void amdgpu_ctx_set_entity_priority(struct amdgpu_ctx *ctx,
-					   struct amdgpu_ctx_entity *aentity,
-					   int hw_ip,
-					   int32_t priority)
+static int amdgpu_ctx_set_entity_priority(struct amdgpu_ctx *ctx,
+					  struct amdgpu_ctx_entity *aentity,
+					  int hw_ip,
+					  int32_t priority)
 {
 	struct amdgpu_device *adev = ctx->mgr->adev;
-	unsigned int hw_prio;
 	struct drm_gpu_scheduler **scheds = NULL;
-	unsigned num_scheds;
+	unsigned int hw_prio, num_scheds;
+	int ret = 0;
 
 	/* set sw priority */
 	drm_sched_entity_set_priority(&aentity->entity,
@@ -837,16 +837,18 @@ static void amdgpu_ctx_set_entity_priority(struct amdgpu_ctx *ctx,
 		hw_prio = array_index_nospec(hw_prio, AMDGPU_RING_PRIO_MAX);
 		scheds = adev->gpu_sched[hw_ip][hw_prio].sched;
 		num_scheds = adev->gpu_sched[hw_ip][hw_prio].num_scheds;
-		drm_sched_entity_modify_sched(&aentity->entity, scheds,
-					      num_scheds);
+		ret = drm_sched_entity_modify_sched(&aentity->entity, scheds,
+						    num_scheds);
 	}
+
+	return ret;
 }
 
-void amdgpu_ctx_priority_override(struct amdgpu_ctx *ctx,
-				  int32_t priority)
+int amdgpu_ctx_priority_override(struct amdgpu_ctx *ctx, int32_t priority)
 {
 	int32_t ctx_prio;
 	unsigned i, j;
+	int ret;
 
 	ctx->override_priority = priority;
 
@@ -857,10 +859,15 @@ void amdgpu_ctx_priority_override(struct amdgpu_ctx *ctx,
 			if (!ctx->entities[i][j])
 				continue;
 
-			amdgpu_ctx_set_entity_priority(ctx, ctx->entities[i][j],
-						       i, ctx_prio);
+			ret = amdgpu_ctx_set_entity_priority(ctx,
+							     ctx->entities[i][j],
+							     i, ctx_prio);
+			if (ret)
+				return ret;
 		}
 	}
+
+	return 0;
 }
 
 int amdgpu_ctx_wait_prev_fence(struct amdgpu_ctx *ctx,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
index cf8d700a22fe..1a7cd4b65829 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
@@ -81,7 +81,7 @@ struct dma_fence *amdgpu_ctx_get_fence(struct amdgpu_ctx *ctx,
 				       struct drm_sched_entity *entity,
 				       uint64_t seq);
 bool amdgpu_ctx_priority_is_valid(int32_t ctx_prio);
-void amdgpu_ctx_priority_override(struct amdgpu_ctx *ctx, int32_t ctx_prio);
+int amdgpu_ctx_priority_override(struct amdgpu_ctx *ctx, int32_t ctx_prio);
 
 int amdgpu_ctx_ioctl(struct drm_device *dev, void *data,
 		     struct drm_file *filp);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
index 0eecfaa3a94c..54145da326ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
@@ -51,11 +51,14 @@ static int amdgpu_sched_process_priority_override(struct amdgpu_device *adev,
 
 	mgr = &fpriv->ctx_mgr;
 	mutex_lock(&mgr->lock);
-	idr_for_each_entry(&mgr->ctx_handles, ctx, id)
-		amdgpu_ctx_priority_override(ctx, priority);
+	idr_for_each_entry(&mgr->ctx_handles, ctx, id) {
+		r = amdgpu_ctx_priority_override(ctx, priority);
+		if (r)
+			break;
+	}
 	mutex_unlock(&mgr->lock);
 
-	return 0;
+	return r;
 }
 
 static int amdgpu_sched_context_priority_override(struct amdgpu_device *adev,
@@ -80,9 +83,9 @@ static int amdgpu_sched_context_priority_override(struct amdgpu_device *adev,
 	if (!ctx)
 		return -EINVAL;
 
-	amdgpu_ctx_priority_override(ctx, priority);
+	r = amdgpu_ctx_priority_override(ctx, priority);
 	amdgpu_ctx_put(ctx);
-	return 0;
+	return r;
 }
 
 int amdgpu_sched_ioctl(struct drm_device *dev, void *data,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 81bba3ec2a93..81be6fb0f2f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1900,8 +1900,7 @@ static int vcn_v3_0_limit_sched(struct amdgpu_cs_parser *p,
 
 	scheds = p->adev->gpu_sched[AMDGPU_HW_IP_VCN_DEC]
 		[AMDGPU_RING_PRIO_DEFAULT].sched;
-	drm_sched_entity_modify_sched(job->base.entity, scheds, 1);
-	return 0;
+	return drm_sched_entity_modify_sched(job->base.entity, scheds, 1);
 }
 
 static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index ff7269bafae8..a0d6ec16d0ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1816,8 +1816,7 @@ static int vcn_v4_0_limit_sched(struct amdgpu_cs_parser *p,
 
 	scheds = p->adev->gpu_sched[AMDGPU_HW_IP_VCN_ENC]
 		[AMDGPU_RING_PRIO_0].sched;
-	drm_sched_entity_modify_sched(job->base.entity, scheds, 1);
-	return 0;
+	return drm_sched_entity_modify_sched(job->base.entity, scheds, 1);
 }
 
 static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index c51101ec70c1..fc7bf15d3881 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -102,7 +102,12 @@ ktime_t drm_sched_entity_stats_job_add_gpu_time(struct drm_sched_job *job)
  * @guilty: atomic_t set to 1 when a job on this queue
  *          is found to be guilty causing a timeout
  *
- * Note that the &sched_list must have at least one element to schedule the entity.
+ * Note that the &sched_list must have at least one element to schedule the
+ * entity.
+ *
+ * The individual drm_gpu_scheduler pointers have borrow semantics, ie.
+ * they must remain valid during entities lifetime, while the containing
+ * array can be freed after this call returns.
  *
  * For changing @priority later on at runtime see
  * drm_sched_entity_set_priority(). For changing the set of schedulers
@@ -119,7 +124,9 @@ int drm_sched_entity_init(struct drm_sched_entity *entity,
 			  unsigned int num_sched_list,
 			  atomic_t *guilty)
 {
-	if (!entity || !sched_list || !num_sched_list || !sched_list[0])
+	int ret;
+
+	if (!entity)
 		return -EINVAL;
 
 	memset(entity, 0, sizeof(struct drm_sched_entity));
@@ -132,9 +139,6 @@ int drm_sched_entity_init(struct drm_sched_entity *entity,
 	entity->guilty = guilty;
 	entity->priority = priority;
 	entity->last_user = current->group_leader;
-	entity->num_sched_list = num_sched_list;
-	entity->sched_list = num_sched_list > 1 ? sched_list : NULL;
-	entity->rq = &sched_list[0]->rq;
 	RCU_INIT_POINTER(entity->last_scheduled, NULL);
 	RB_CLEAR_NODE(&entity->rb_tree_node);
 	init_completion(&entity->entity_idle);
@@ -145,6 +149,14 @@ int drm_sched_entity_init(struct drm_sched_entity *entity,
 	spin_lock_init(&entity->lock);
 	spsc_queue_init(&entity->job_queue);
 
+	ret = drm_sched_entity_modify_sched(entity, sched_list, num_sched_list);
+	if (ret) {
+		drm_sched_entity_stats_put(entity->stats);
+		return ret;
+	}
+
+	drm_sched_entity_select_rq(entity);
+
 	atomic_set(&entity->fence_seq, 0);
 	entity->fence_context = dma_fence_context_alloc(2);
 
@@ -159,21 +171,47 @@ EXPORT_SYMBOL(drm_sched_entity_init);
  *		 existing entity->sched_list
  * @num_sched_list: number of drm sched in sched_list
  *
+ * The individual drm_gpu_scheduler pointers have borrow semantics, ie.
+ * they must remain valid during entities lifetime, while the containing
+ * array can be freed after this call returns.
+ *
  * Note that this must be called under the same common lock for @entity as
  * drm_sched_job_arm() and drm_sched_entity_push_job(), or the driver needs to
  * guarantee through some other means that this is never called while new jobs
  * can be pushed to @entity.
+ *
+ * Returns zero on success and a negative error code on failure.
  */
-void drm_sched_entity_modify_sched(struct drm_sched_entity *entity,
-				    struct drm_gpu_scheduler **sched_list,
-				    unsigned int num_sched_list)
+int drm_sched_entity_modify_sched(struct drm_sched_entity *entity,
+				  struct drm_gpu_scheduler **sched_list,
+				  unsigned int num_sched_list)
 {
-	WARN_ON(!num_sched_list || !sched_list);
+	struct drm_gpu_scheduler **newscheds, **oldscheds;
+
+	if (!sched_list || !num_sched_list || !sched_list[0])
+		return -EINVAL;
+
+	if (num_sched_list > 1) {
+		newscheds = kmemdup_array(sched_list, num_sched_list,
+					  sizeof(*sched_list), GFP_KERNEL);
+		if (!newscheds)
+			return -ENOMEM;
+	}
 
 	spin_lock(&entity->lock);
-	entity->sched_list = sched_list;
+	if (num_sched_list == 1) {
+		entity->sched = sched_list[0];
+		oldscheds = NULL;
+	} else {
+		oldscheds = entity->sched_list;
+		entity->sched_list = newscheds;
+	}
 	entity->num_sched_list = num_sched_list;
 	spin_unlock(&entity->lock);
+
+	kfree(oldscheds);
+
+	return 0;
 }
 EXPORT_SYMBOL(drm_sched_entity_modify_sched);
 
@@ -384,6 +422,9 @@ void drm_sched_entity_fini(struct drm_sched_entity *entity)
 	dma_fence_put(rcu_dereference_check(entity->last_scheduled, true));
 	RCU_INIT_POINTER(entity->last_scheduled, NULL);
 	drm_sched_entity_stats_put(entity->stats);
+
+	if (entity->num_sched_list > 1)
+		kfree(entity->sched_list);
 }
 EXPORT_SYMBOL(drm_sched_entity_fini);
 
@@ -553,10 +594,6 @@ void drm_sched_entity_select_rq(struct drm_sched_entity *entity)
 	struct drm_gpu_scheduler *sched;
 	struct drm_sched_rq *rq;
 
-	/* single possible engine and already selected */
-	if (!entity->sched_list)
-		return;
-
 	/* queue non-empty, stay on the same engine */
 	if (spsc_queue_count(&entity->job_queue))
 		return;
@@ -576,16 +613,16 @@ void drm_sched_entity_select_rq(struct drm_sched_entity *entity)
 		return;
 
 	spin_lock(&entity->lock);
-	sched = drm_sched_pick_best(entity->sched_list, entity->num_sched_list);
+	if (entity->num_sched_list == 1)
+		sched = entity->sched;
+	else
+		sched = drm_sched_pick_best(entity->sched_list,
+					    entity->num_sched_list);
 	rq = sched ? &sched->rq : NULL;
 	if (rq != entity->rq) {
 		drm_sched_rq_remove_entity(entity->rq, entity);
 		entity->rq = rq;
 	}
-
-	if (entity->num_sched_list == 1)
-		entity->sched_list = NULL;
-
 	spin_unlock(&entity->lock);
 }
 
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index d61c19e78182..a11243583420 100644
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
@@ -699,9 +707,9 @@ void drm_sched_entity_destroy(struct drm_sched_entity *entity);
 void drm_sched_entity_set_priority(struct drm_sched_entity *entity,
 				   enum drm_sched_priority priority);
 int drm_sched_entity_error(struct drm_sched_entity *entity);
-void drm_sched_entity_modify_sched(struct drm_sched_entity *entity,
-				   struct drm_gpu_scheduler **sched_list,
-				   unsigned int num_sched_list);
+int drm_sched_entity_modify_sched(struct drm_sched_entity *entity,
+				  struct drm_gpu_scheduler **sched_list,
+				  unsigned int num_sched_list);
 
 /**
  * struct drm_sched_pending_job_iter - DRM scheduler pending job iterator state
-- 
2.54.0

