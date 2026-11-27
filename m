Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F891606A323
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 11:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=DAzva6SO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6D0D10E3A0;
	Fri, 27 Nov 2026 11:28:28 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1240610E347;
 Fri, 27 Nov 2026 11:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=QqHO4VQEjLc00qmFlKNOOA214zXUdigoRHhHJ/tGHck=; t=1795778902; x=2111138902; 
 b=DAzva6SOptyFyqZiwP2Rio6+N+V1XO/1FtQF7juXl9dLw3EIAHyts1kA25vnvwskI8nxWayMkN0
 9VOMqcjtKOtzS/DnofBiLNjl2Zbt1QdH8TpBCj38dgMKC2jICXtIeyitULXFPPDK7r1wX5bFu3iMa
 g/lW2oF5U4QzxQtuvMD0Hm0Pz1/L+xW4L3w0j1JoiC1THSggHSo931W7VcPKTh88TG/MzwNfvZoxZ
 NSno101XFgKClc/ZZxKvh8wdskHC18tdsiEh7QqIjBJiwbMy9gH/ltvDugd6GuXNoSKEHeKauYB9h
 4iipLD1OwvTPzPEMumm7PyCD9OV5wU9hwdPg==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xWu7p-00000004lqV-05TR; Fri, 27 Nov 2026 12:28:21 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>, amd-gfx@lists.freedesktop.org
Subject: [RFC v2] drm/sched: Track sched fence scheduled and finished time
 directly
Date: Fri, 27 Nov 2026 11:28:18 +0000
Message-ID: <20261127112818.79237-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261126154200.71180-1-tvrtko.ursulin@igalia.com>
References: <20261126154200.71180-1-tvrtko.ursulin@igalia.com>
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

Philipp reports the current usage of overwriting the dma-fence timestamp
from the free_job worker is racy and unsafe due missing memory ordering
and especially with drivers which use own unordered submit workqueue for
the scheduler. Consider also that the timestamp field is the union in the
dma-fence object.

On top of these serious issue there is also a smaller problem where the
said race can cause GPU time overaccounting.

Lets try and solve all issues in one swoop by stopping messing with
dma-fence internals and just track what we want in our own derived fence
object.

We care about fence submit and finish times and by adding a dedicated
lock to manage them we can safely access both and adjust the former
without any races.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
References: https://lore.kernel.org/dri-devel/20261119131830.2535266-2-phasta@kernel.org/
References: https://lore.kernel.org/dri-devel/20261117094324.8256-1-tvrtko.ursulin@igalia.com/
Cc: Christian König <christian.koenig@amd.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: amd-gfx@lists.freedesktop.org
---
v2:
 * Fix kerneldoc copy and paste.
 * Grab timestamps after obtaing locks.
 * Prevent negative job durations on canceled/timedout jobs.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c    | 15 ++++-----
 drivers/gpu/drm/scheduler/sched_entity.c   |  6 ++--
 drivers/gpu/drm/scheduler/sched_fence.c    | 22 ++++++++++--
 drivers/gpu/drm/scheduler/sched_internal.h | 39 ++++++++++++++++++++++
 drivers/gpu/drm/scheduler/sched_main.c     |  8 ++---
 include/drm/gpu_scheduler.h                | 39 ++++++++++++++++++++++
 6 files changed, 113 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 2f0349233695..1a6985283acc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -171,21 +171,20 @@ static unsigned int amdgpu_ctx_get_hw_prio(struct amdgpu_ctx *ctx, u32 hw_ip)
 static ktime_t amdgpu_ctx_fence_time(struct dma_fence *fence)
 {
 	struct drm_sched_fence *s_fence;
+	ktime_t start, end;
 
 	if (!fence)
 		return ns_to_ktime(0);
 
-	/* When the fence is not even scheduled it can't have spend time */
 	s_fence = to_drm_sched_fence(fence);
-	if (!test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &s_fence->scheduled.flags))
-		return ns_to_ktime(0);
+	drm_sched_fence_get_times(s_fence, &start, &end);
+
+	/* When the fence is not even scheduled it can't have spend time */
+	if (!start)
+		return start;
 
 	/* When it is still running account how much already spend */
-	if (!test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &s_fence->finished.flags))
-		return ktime_sub(ktime_get(), s_fence->scheduled.timestamp);
-
-	return ktime_sub(s_fence->finished.timestamp,
-			 s_fence->scheduled.timestamp);
+	return ktime_sub(end ?: ktime_get(), start);
 }
 
 static ktime_t amdgpu_ctx_entity_time(struct amdgpu_ctx *ctx,
diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index af6cb79c8a53..80bc7c9fb9ba 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -78,8 +78,10 @@ ktime_t drm_sched_entity_stats_job_add_gpu_time(struct drm_sched_job *job)
 	struct drm_sched_fence *s_fence = job->s_fence;
 	ktime_t start, end, duration;
 
-	start = dma_fence_timestamp(&s_fence->scheduled);
-	end = dma_fence_timestamp(&s_fence->finished);
+	drm_sched_fence_get_times(s_fence, &start, &end);
+	if (WARN_ON_ONCE(!start || !end || ktime_after(start, end)))
+		return ns_to_ktime(0);
+
 	duration = ktime_sub(end, start);
 
 	spin_lock(&stats->lock);
diff --git a/drivers/gpu/drm/scheduler/sched_fence.c b/drivers/gpu/drm/scheduler/sched_fence.c
index 9f938f5a7e55..a1d16b357057 100644
--- a/drivers/gpu/drm/scheduler/sched_fence.c
+++ b/drivers/gpu/drm/scheduler/sched_fence.c
@@ -65,6 +65,9 @@ static void drm_sched_fence_set_parent(struct drm_sched_fence *s_fence,
 void drm_sched_fence_scheduled(struct drm_sched_fence *fence,
 			       struct dma_fence *parent)
 {
+	unsigned long flags;
+	ktime_t now;
+
 	/* Set the parent before signaling the scheduled fence, such that,
 	 * any waiter expecting the parent to be filled after the job has
 	 * been scheduled (which is the case for drivers delegating waits
@@ -74,14 +77,28 @@ void drm_sched_fence_scheduled(struct drm_sched_fence *fence,
 	if (!IS_ERR_OR_NULL(parent))
 		drm_sched_fence_set_parent(fence, parent);
 
-	dma_fence_signal(&fence->scheduled);
+	spin_lock_irqsave(&fence->ts_lock, flags);
+	now = ktime_get();
+	fence->start_ts = now;
+	spin_unlock_irqrestore(&fence->ts_lock, flags);
+
+	dma_fence_signal_timestamp(&fence->scheduled, now);
 }
 
 void drm_sched_fence_finished(struct drm_sched_fence *fence, int result)
 {
+	unsigned long flags;
+	ktime_t now;
+
 	if (result)
 		dma_fence_set_error(&fence->finished, result);
-	dma_fence_signal(&fence->finished);
+
+	spin_lock_irqsave(&fence->ts_lock, flags);
+	now = ktime_get();
+	fence->finished_ts = now;
+	spin_unlock_irqrestore(&fence->ts_lock, flags);
+
+	dma_fence_signal_timestamp(&fence->finished, now);
 }
 
 static const char *drm_sched_fence_get_driver_name(struct dma_fence *fence)
@@ -217,6 +234,7 @@ struct drm_sched_fence *drm_sched_fence_alloc(void *owner,
 	fence->owner = owner;
 	fence->drm_client_id = drm_client_id;
 	spin_lock_init(&fence->lock);
+	spin_lock_init(&fence->ts_lock);
 
 	return fence;
 }
diff --git a/drivers/gpu/drm/scheduler/sched_internal.h b/drivers/gpu/drm/scheduler/sched_internal.h
index 32d3ddb820be..b24bb1d7d489 100644
--- a/drivers/gpu/drm/scheduler/sched_internal.h
+++ b/drivers/gpu/drm/scheduler/sched_internal.h
@@ -67,6 +67,45 @@ void drm_sched_fence_scheduled(struct drm_sched_fence *fence,
 			       struct dma_fence *parent);
 void drm_sched_fence_finished(struct drm_sched_fence *fence, int result);
 
+/**
+ * drm_sched_fence_advance_start_time - Advance scheduler fence scheduled timestamp
+ * @fence: scheduler fence
+ * @t: time to advance to
+ *
+ * Advances the scheduler fence scheduled time to @t if the fence has already
+ * been scheduled with an older timestamp.
+ */
+static inline void
+drm_sched_fence_advance_start_time(struct drm_sched_fence *fence, ktime_t t)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&fence->ts_lock, flags);
+	if (fence->start_ts && !fence->finished_ts &&
+	    ktime_after(t, fence->start_ts))
+		fence->start_ts = t;
+	spin_unlock_irqrestore(&fence->ts_lock, flags);
+}
+
+/**
+ * drm_sched_fence_finished_time - Queries the scheduler fence finished timestamp
+ * @fence: scheduler fence
+ *
+ * Returns: Scheduler fence finished timestamp.
+ */
+static inline ktime_t
+drm_sched_fence_finished_time(struct drm_sched_fence *fence)
+{
+	unsigned long flags;
+	ktime_t end;
+
+	spin_lock_irqsave(&fence->ts_lock, flags);
+	end = fence->finished_ts;
+	spin_unlock_irqrestore(&fence->ts_lock, flags);
+
+	return end;
+}
+
 /**
  * drm_sched_entity_queue_pop - Low level helper for popping queued jobs
  *
diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 027c1c436caa..ba2a06e22707 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -933,11 +933,11 @@ drm_sched_get_finished_job(struct drm_gpu_scheduler *sched)
 		next = list_first_entry_or_null(&sched->pending_list,
 						typeof(*next), list);
 		if (next) {
+			ktime_t ts;
+
 			/* make the scheduled timestamp more accurate */
-			if (test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT,
-				     &next->s_fence->scheduled.flags))
-				next->s_fence->scheduled.timestamp =
-					dma_fence_timestamp(&job->s_fence->finished);
+			ts = drm_sched_fence_finished_time(job->s_fence);
+			drm_sched_fence_advance_start_time(next->s_fence, ts);
 
 			/* start TO timer for next job */
 			drm_sched_start_timeout(sched);
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 81604b082259..3408674e9406 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -308,6 +308,25 @@ struct drm_sched_fence {
          */
 	struct dma_fence		finished;
 
+	/**
+	 * @ts_lock: Lock used for @start_ts and @finished_ts.
+	 */
+	spinlock_t			ts_lock;
+
+	/**
+	 * @start_ts: ktime of fence GPU execution start or 0 is not started.
+	 *
+	 * Must be accessed via helpers.
+	 */
+	ktime_t				start_ts;
+
+	/**
+	 * @finished_ts: ktime of fence GPU execution end or 0 if not finished.
+	 *
+	 * Must be accessed via helpers.
+	 */
+	ktime_t				finished_ts;
+
 	/**
 	 * @deadline: deadline set on &drm_sched_fence.finished which
 	 * potentially needs to be propagated to &drm_sched_fence.parent
@@ -344,6 +363,26 @@ struct drm_sched_fence {
 
 struct drm_sched_fence *to_drm_sched_fence(struct dma_fence *f);
 
+/**
+ * drm_sched_fence_get_times() - Get scheduler fence start and finished times
+ * @fence: Scheduler fence
+ * @scheduled: Pointer to scheduled time storage
+ * @finished: Pointer to finished time storage
+ *
+ * Obtains scheduler fence scheduled and finished times.
+ */
+static inline void
+drm_sched_fence_get_times(struct drm_sched_fence *fence,
+			  ktime_t *scheduled, ktime_t *finished)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&fence->ts_lock, flags);
+	*scheduled = fence->start_ts;
+	*finished = fence->finished_ts;
+	spin_unlock_irqrestore(&fence->ts_lock, flags);
+}
+
 /**
  * struct drm_sched_job - A job to be run by an entity.
  *
-- 
2.56.0

