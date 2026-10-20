Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F13C606A327
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 15:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=dVQpxt0J
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2432910E281;
	Tue, 20 Oct 2026 15:41:50 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B375910F6A5;
 Tue, 20 Oct 2026 15:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=o6GtBR8JNOo3TD7Lq5Bsq9QvuZOKxNyeNSkz/lgkvXA=; b=dVQpxt0JCN1AO93EIrI156zVmE
 FVqkl5NZeSn19iS9ws/K0dNZoE/uo+LaExRt0rMTQEpOmUaWVhvVYslFX5Kn5dS0W7cf4jPkeqcYf
 DXfFHZzVFM5ug5ne8aqco+GEvMywlRhUr362INl0rWUtBIX+KNJ87LTGNUyYI2E6cyOrOB5jAeXPZ
 P1WaLHryRnVmcBN1DoC1bSIM+xW7fmm+QDRMdxxvgfyrdb+CL0y5+L7oRr0faYTkxQQ1guwlCKa/Y
 UD9BVoNMW1bgJQuyjqsZQDscn1WhwHpNQVNINxb7WOryFUd1Oh0OrY1XNZhhKyEVYfaned6RSLgjB
 A3Z+dPog==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xJBxz-004ier-Cs; Tue, 20 Oct 2026 17:41:31 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Luben Tuikov <ltuikov89@gmail.com>,
 Matthew Brost <matthew.brost@intel.com>, Simona Vetter <simona@ffwll.ch>,
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>
Subject: [PATCH v2 8/8] drm/sched: Untangle the scheduler list mess
Date: Tue, 20 Oct 2026 16:41:23 +0100
Message-ID: <20261020154123.33631-9-tvrtko.ursulin@igalia.com>
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
multiple schedulers on the other hand, amdgpu is the only such caller, and
there the container is not on the stack. Keeping a stack backed list in
the entity would obviously be undefined behaviour if the list was kept.

Amdgpu however did only stop passing in stack backed container for the
more than one scheduler case in commit
977f7e1068be ("drm/amdgpu: allocate entities on demand")
. Until then dereferencing freed stack from drm_sched_entity_select_rq()
was a possibility.

In order to untangle all this lets make this area behave consistently and
sensibly and document who owns what. We make the entity own its own copy
of the scheduler list, which allows removal of the special cases which
needed to artificially clear entity->sched_list for a single scheduler
case. Individual scheduler pointers are still owned by the driver with
unchanged lifetime rules.

To avoid growing the entity structure and also avoid runtime allocation of
the list, where the latter would be a significant challenge due the
current API is to not expect drm_sched_entity_modify_sched() to fail, we
do this by only having a single built in scheduler slot in the entity,
while the drivers (amdgpu and rocket only, former only in some cases),
have the responsibility to allocate their entities with enough trailing
storage to accomodate as large a scheduler list thy need for the trailing
flex array member.

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
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: amd-gfx@lists.freedesktop.org
---
Rocket only compile tested!

In a previous version I had the scheduler allocate the list storage but
that was problematic in the way how it made
drm_sched_entity_modify_sched() having to start returning a return code,
and how that percolated through amdgpu. Both from the error unwind and
allocating under locks perspective.

So in this version I took a different approach by mandating callers
provide enough storage for the drm_sched_entity flex
array storage.

It is also not the prettiest but at least it addresses the problems
enumerated in the commit message.
---
 drivers/accel/rocket/rocket_drv.h        |  2 +-
 drivers/accel/rocket/rocket_job.c        | 20 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c  |  5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c  |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h  |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c   | 15 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h   |  4 +-
 drivers/gpu/drm/scheduler/sched_entity.c | 48 ++++++++-----
 include/drm/gpu_scheduler.h              | 91 +++++++++++++++++++-----
 10 files changed, 136 insertions(+), 58 deletions(-)

diff --git a/drivers/accel/rocket/rocket_drv.h b/drivers/accel/rocket/rocket_drv.h
index 2c673bb99ccc..1dbade2850ee 100644
--- a/drivers/accel/rocket/rocket_drv.h
+++ b/drivers/accel/rocket/rocket_drv.h
@@ -23,7 +23,7 @@ struct rocket_file_priv {
 	struct drm_mm mm;
 	struct mutex mm_lock;
 
-	struct drm_sched_entity sched_entity;
+	DECLARE_DRM_SCHED_ENTITY_WITH_STORAGE(sched_entity, sched_list, 3);
 };
 
 struct rocket_iommu_domain *rocket_iommu_domain_get(struct rocket_file_priv *rocket_priv);
diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index c3edb94355a3..87fd77b838c2 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -533,18 +533,21 @@ void rocket_job_fini(struct rocket_core *core)
 int rocket_job_open(struct rocket_file_priv *rocket_priv)
 {
 	struct rocket_device *rdev = rocket_priv->rdev;
-	struct drm_gpu_scheduler **scheds = kmalloc_objs(*scheds,
-							 rdev->num_cores);
+	unsigned int num_cores = rdev->num_cores;
 	unsigned int core;
 	int ret;
 
-	for (core = 0; core < rdev->num_cores; core++)
-		scheds[core] = &rdev->cores[core].sched;
+	if (WARN_ON_ONCE(num_cores > ARRAY_SIZE(rocket_priv->sched_list)))
+		return -EINVAL;
 
-	ret = drm_sched_entity_init(&rocket_priv->sched_entity,
-				    DRM_SCHED_PRIORITY_NORMAL,
-				    scheds,
-				    rdev->num_cores, NULL);
+	for (core = 0; core < num_cores; core++)
+		rocket_priv->sched_list[core] = &rdev->cores[core].sched;
+
+	ret = __drm_sched_entity_init(&rocket_priv->sched_entity,
+				      DRM_SCHED_PRIORITY_NORMAL,
+				      rocket_priv->sched_list,
+				      ARRAY_SIZE(rocket_priv->sched_list),
+				      num_cores, NULL);
 	if (WARN_ON(ret))
 		return ret;
 
@@ -555,7 +558,6 @@ void rocket_job_close(struct rocket_file_priv *rocket_priv)
 {
 	struct drm_sched_entity *entity = &rocket_priv->sched_entity;
 
-	kfree(entity->sched_list);
 	drm_sched_entity_destroy(entity);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 2f0349233695..a746c57ec384 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -255,8 +255,9 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
 		num_scheds = 1;
 	}
 
-	r = drm_sched_entity_init(&entity->entity, drm_prio, scheds, num_scheds,
-				  NULL);
+	r = __drm_sched_entity_init(&entity->entity, drm_prio, scheds,
+				    ARRAY_SIZE(entity->sched_list), num_scheds,
+				    NULL);
 	if (r)
 		goto error_free_entity;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
index a4b89eca4169..ba395406f37a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
@@ -39,7 +39,7 @@ struct amdgpu_ctx_mgr;
 struct amdgpu_ctx_entity {
 	uint32_t		hw_ip;
 	uint64_t		sequence;
-	struct drm_sched_entity	entity;
+	DECLARE_DRM_SCHED_ENTITY_WITH_STORAGE(entity, sched_list, AMDGPU_MAX_HWIP_RINGS);
 	struct dma_fence	*fences[];
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 8f0720a77520..42371a5ef596 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2087,7 +2087,9 @@ static int amdgpu_ttm_buffer_entity_init(struct amdgpu_gtt_mgr *mgr,
 	if (ARRAY_SIZE(entity->gart_window_offs) < num_gart_windows)
 		return -EINVAL;
 
-	r = drm_sched_entity_init(&entity->base, prio, scheds, num_schedulers, NULL);
+	r = __drm_sched_entity_init(&entity->base, prio, scheds,
+				    ARRAY_SIZE(entity->sched_list),
+				    num_schedulers, NULL);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 34b4b35a20f1..9a677bf2fcc9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -30,6 +30,7 @@
 #include "amdgpu_vram_mgr.h"
 #include "amdgpu_hmm.h"
 #include "amdgpu_gmc.h"
+#include "amdgpu_sdma_types.h"
 
 #define AMDGPU_PL_GDS		(TTM_PL_PRIV + 0)
 #define AMDGPU_PL_GWS		(TTM_PL_PRIV + 1)
@@ -55,7 +56,7 @@ struct amdgpu_gtt_mgr {
 };
 
 struct amdgpu_ttm_buffer_entity {
-	struct drm_sched_entity base;
+	DECLARE_DRM_SCHED_ENTITY_WITH_STORAGE(base, sched_list, AMDGPU_MAX_SDMA_INSTANCES);
 	struct mutex		lock;
 	struct drm_mm_node	gart_node;
 	u64			gart_window_offs[2];
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 467ba16bd603..21536227c576 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -522,15 +522,18 @@ static int amdgpu_vm_init_entities(struct amdgpu_device *adev,
 {
 	int r;
 
-	r = drm_sched_entity_init(&vm->immediate, DRM_SCHED_PRIORITY_NORMAL,
-				  adev->vm_manager.vm_pte_scheds,
-				  adev->vm_manager.vm_pte_num_scheds, NULL);
+	r = __drm_sched_entity_init(&vm->immediate, DRM_SCHED_PRIORITY_NORMAL,
+				    adev->vm_manager.vm_pte_scheds,
+				    ARRAY_SIZE(vm->immediate_sched_list),
+				    adev->vm_manager.vm_pte_num_scheds, NULL);
 	if (r)
 		goto error;
 
-	return drm_sched_entity_init(&vm->delayed, DRM_SCHED_PRIORITY_NORMAL,
-				     adev->vm_manager.vm_pte_scheds,
-				     adev->vm_manager.vm_pte_num_scheds, NULL);
+	return __drm_sched_entity_init(&vm->delayed, DRM_SCHED_PRIORITY_NORMAL,
+				       adev->vm_manager.vm_pte_scheds,
+				       ARRAY_SIZE(vm->delayed_sched_list),
+				       adev->vm_manager.vm_pte_num_scheds,
+				       NULL);
 
 error:
 	drm_sched_entity_destroy(&vm->immediate);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 98c48c45ce61..1dec90be622c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -325,8 +325,8 @@ struct amdgpu_vm {
 	struct dma_fence	*last_update;
 
 	/* Scheduler entities for page table updates */
-	struct drm_sched_entity	immediate;
-	struct drm_sched_entity	delayed;
+	DECLARE_DRM_SCHED_ENTITY_WITH_STORAGE(immediate, immediate_sched_list, AMDGPU_MAX_SDMA_INSTANCES);
+	DECLARE_DRM_SCHED_ENTITY_WITH_STORAGE(delayed, delayed_sched_list, AMDGPU_MAX_SDMA_INSTANCES);
 
 	/* Last finished delayed update */
 	atomic64_t		tlb_seq;
diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 79ea20838328..d4956c6de6ed 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -91,18 +91,24 @@ ktime_t drm_sched_entity_stats_job_add_gpu_time(struct drm_sched_job *job)
 }
 
 /**
- * drm_sched_entity_init - Init a context entity used by scheduler when
+ * __drm_sched_entity_init - Init a context entity used by scheduler when
  * submit to HW ring.
  *
  * @entity: scheduler entity to init
  * @priority: priority of the entity
  * @sched_list: the list of drm scheds on which jobs from this
  *           entity can be submitted
+ * @max_sched_list: the number of driver provided @sched_list slots
  * @num_sched_list: number of drm sched in sched_list
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
@@ -113,15 +119,17 @@ ktime_t drm_sched_entity_stats_job_add_gpu_time(struct drm_sched_job *job)
  *
  * Returns 0 on success or a negative error code on failure.
  */
-int drm_sched_entity_init(struct drm_sched_entity *entity,
+int __drm_sched_entity_init(struct drm_sched_entity *entity,
 			  enum drm_sched_priority priority,
 			  struct drm_gpu_scheduler **sched_list,
+			  unsigned int max_sched_list,
 			  unsigned int num_sched_list,
 			  atomic_t *guilty)
 {
 	unsigned int i;
 
-	if (!entity || !sched_list || !num_sched_list)
+	if (!entity || !sched_list || !num_sched_list ||
+	    num_sched_list > max_sched_list)
 		return -EINVAL;
 
 	for (i = 0; i < num_sched_list; i++) {
@@ -138,8 +146,6 @@ int drm_sched_entity_init(struct drm_sched_entity *entity,
 	INIT_LIST_HEAD(&entity->list);
 	entity->guilty = guilty;
 	entity->last_user = current->group_leader;
-	entity->num_sched_list = num_sched_list;
-	entity->sched_list = num_sched_list > 1 ? sched_list : NULL;
 	RB_CLEAR_NODE(&entity->rb_tree_node);
 
 	if (priority >= sched_list[0]->num_user_rqs) {
@@ -159,17 +165,20 @@ int drm_sched_entity_init(struct drm_sched_entity *entity,
 	entity->priority = priority;
 	entity->rq_priority = drm_sched_policy == DRM_SCHED_POLICY_FAIR ?
 			      DRM_SCHED_PRIORITY_KERNEL : priority;
-	entity->rq = sched_list[0]->sched_rq[entity->rq_priority];
 
 	spin_lock_init(&entity->lock);
 	spsc_queue_init(&entity->job_queue);
 
+	entity->max_sched_list = max_sched_list;
+	drm_sched_entity_modify_sched(entity, sched_list, num_sched_list);
+	drm_sched_entity_select_rq(entity);
+
 	atomic_set(&entity->fence_seq, 0);
 	entity->fence_context = dma_fence_context_alloc(2);
 
 	return 0;
 }
-EXPORT_SYMBOL(drm_sched_entity_init);
+EXPORT_SYMBOL(__drm_sched_entity_init);
 
 /**
  * drm_sched_entity_modify_sched - Modify sched of an entity
@@ -178,20 +187,28 @@ EXPORT_SYMBOL(drm_sched_entity_init);
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
  */
 void drm_sched_entity_modify_sched(struct drm_sched_entity *entity,
-				    struct drm_gpu_scheduler **sched_list,
-				    unsigned int num_sched_list)
+				   struct drm_gpu_scheduler **sched_list,
+				   unsigned int num_sched_list)
 {
-	WARN_ON(!num_sched_list || !sched_list);
+	WARN_ON_ONCE(!num_sched_list || !sched_list);
+
+	if (WARN_ON_ONCE(num_sched_list > entity->max_sched_list))
+		num_sched_list = entity->max_sched_list;
 
 	spin_lock(&entity->lock);
-	entity->sched_list = sched_list;
 	entity->num_sched_list = num_sched_list;
+	memmove(entity->sched_list, sched_list,
+		sizeof(*sched_list) * num_sched_list);
 	spin_unlock(&entity->lock);
 }
 EXPORT_SYMBOL(drm_sched_entity_modify_sched);
@@ -577,10 +594,6 @@ void drm_sched_entity_select_rq(struct drm_sched_entity *entity)
 	struct drm_gpu_scheduler *sched;
 	struct drm_sched_rq *rq;
 
-	/* single possible engine and already selected */
-	if (!entity->sched_list)
-		return;
-
 	/* queue non-empty, stay on the same engine */
 	if (spsc_queue_count(&entity->job_queue))
 		return;
@@ -604,9 +617,6 @@ void drm_sched_entity_select_rq(struct drm_sched_entity *entity)
 		entity->rq = rq;
 	}
 
-	if (entity->num_sched_list == 1)
-		entity->sched_list = NULL;
-
 out:
 	spin_unlock(&entity->lock);
 }
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index c89a581f54bf..051a7af47aeb 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -121,22 +121,11 @@ struct drm_sched_entity {
 	struct drm_sched_entity_stats	*stats;
 
 	/**
-	 * @sched_list:
+	 * @max_sched_list:
 	 *
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
+	 * Maximum number of drm_gpu_schedulers in the @sched_list.
 	 */
-	struct drm_gpu_scheduler        **sched_list;
+	unsigned int                    max_sched_list;
 
 	/**
 	 * @num_sched_list:
@@ -245,8 +234,38 @@ struct drm_sched_entity {
 	 */
 	struct rb_node			rb_tree_node;
 
+	union {
+		/**
+		 * @__sched__:
+		 *
+		 * Built-in storage for callers who only need a single slot.
+		 *
+		 * MUST NOT be accessed.
+		 */
+		struct drm_gpu_scheduler 	*__sched__;
+
+		/**
+		 * @sched_list:
+		 *
+		 * Flexible array of schedulers this entity can pick from, with
+		 * the driver reponsibility to size the array correctly at
+		 * declaration and initialization time, and populate the array
+		 * via drm_sched_entity_init() and/or
+		 * drm_sched_entity_modify_sched().
+		 *
+		 * It can be modified by calling
+		 * drm_sched_entity_modify_sched().
+		 */
+		DECLARE_FLEX_ARRAY(struct drm_gpu_scheduler *, sched_list);
+	};
 };
 
+#define DECLARE_DRM_SCHED_ENTITY_WITH_STORAGE(name, listname, max_scheds) \
+struct { \
+	struct drm_sched_entity (name); \
+	struct drm_gpu_scheduler *(listname)[(max_scheds)]; \
+}
+
 /**
  * struct drm_sched_rq - queue of entities to be scheduled.
  *
@@ -708,12 +727,52 @@ static inline bool drm_sched_invalidate_job(struct drm_sched_job *s_job,
 }
 
 /* Entities */
-
-int drm_sched_entity_init(struct drm_sched_entity *entity,
+int __drm_sched_entity_init(struct drm_sched_entity *entity,
 			  enum drm_sched_priority priority,
 			  struct drm_gpu_scheduler **sched_list,
+			  unsigned int max_sched_list,
 			  unsigned int num_sched_list,
 			  atomic_t *guilty);
+
+/**
+ * drm_sched_entity_init - Init a context entity used by scheduler when
+ * submit to HW ring.
+ *
+ * @entity: scheduler entity to init
+ * @priority: priority of the entity
+ * @sched_list: the list of drm scheds on which jobs from this
+ *           entity can be submitted
+ * @num_sched_list: number of drm sched in sched_list
+ * @guilty: atomic_t set to 1 when a job on this queue
+ *          is found to be guilty causing a timeout
+ *
+ * Note that the &sched_list must have exactly one element to schedule the
+ * entity.
+ *
+ * The individual drm_gpu_scheduler pointers have borrow semantics, ie.
+ * they must remain valid during entities lifetime, while the containing
+ * array can be freed after this call returns.
+ *
+ * For changing @priority later on at runtime see
+ * drm_sched_entity_set_priority(). For changing the set of schedulers
+ * @sched_list at runtime see drm_sched_entity_modify_sched().
+ *
+ * An entity is cleaned up by calling drm_sched_entity_fini(). See also
+ * drm_sched_entity_destroy().
+ *
+ * Returns 0 on success or a negative error code on failure.
+ */
+static inline int
+drm_sched_entity_init(struct drm_sched_entity *entity,
+		      enum drm_sched_priority priority,
+		      struct drm_gpu_scheduler **sched_list,
+		      unsigned int num_sched_list,
+		      atomic_t *guilty)
+{
+	return __drm_sched_entity_init(entity, priority, sched_list, 1,
+				       num_sched_list, guilty);
+}
+
 long drm_sched_entity_flush(struct drm_sched_entity *entity, long timeout);
 void drm_sched_entity_kill(struct drm_sched_entity *entity);
 void drm_sched_entity_fini(struct drm_sched_entity *entity);
-- 
2.56.0

