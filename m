Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 333FBC982C1
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 15:06:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45C1410FC2B;
	Tue, 15 Sep 2026 15:06:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="rchspFkY";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0255B10FC28;
 Tue, 15 Sep 2026 15:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=PiSyqhvGSz2PDFqBbXkGWNO7TnAMaaznX9h6SJLmVzw=; b=rchspFkYc1pi3jD/hBSPFPlaIO
 OKp5wrTVAx4+GwEiDs/PfkEnMgE/7r5OPCGfyM3diJnkZWYEPmBcgV+X6KymATgMFasrKj2Shhj2J
 kCWE3vbnpdrr49n4L8ixKiCJEq0PRpNpB3LY4QnIt3cvzuTkRsanODXAdUyTBSpGz9icWRcszUYxx
 WmD4So2vOGOMtasqF/WkR/oxwQo9nPqQKWD59kf+4KLtDaI0AOapX/hWGK/kBg8LcBXYFb9Uuq+rd
 /1Q4Ya7v3lZKyksALKqElbCRJ5/NLkcRAirwTei9VttmKbwk7B6U52RF7Lf9DlsAD98PZmZoOms+N
 YUgqH3OQ==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1x6UjW-002VAq-He; Tue, 15 Sep 2026 17:06:06 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Luke.Wildhardt@proton.me,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>, stable@vger.kernel.org
Subject: [PATCH v2] drm/sched: Do not restore unsaved virtual runtime
Date: Tue, 15 Sep 2026 16:05:57 +0100
Message-ID: <20260915150557.62847-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.55.0
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

Prevent pushing a new job to an entity seeing it being the first in the
queue, and hence entering the drm_sched_rq_add_entity() path, if the pop
side in drm_sched_entity_pop_job() has just de-queued the job but not yet
updated the saved virtual time.

Restoring the unsaved virtual time, which is at this point not a delta but
still an absolute value, pushes the said entity to the rear of the run queue
for a potentially very long time.

We close this race by pulling the locked sections out to encompass both
the queue push/pop and corresponding rbtree management.

This is aligned with the future direction to replace the current lockless
job queue with one of the fully locked standard list primitives.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Fixes: 2fa4d8e2c109 ("drm/sched: Add fair scheduling policy")
Suggested-by: Luke.Wildhardt@proton.me # via Claude Opus
Tested-by: Luke.Wildhardt@proton.me
Cc: Christian König <christian.koenig@amd.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Vitaly Prosyak <vitaly.prosyak@amd.com>
Cc: <stable@vger.kernel.org> # v7.2+
---
v2:
  * More verbose commit text.
---
 drivers/gpu/drm/scheduler/sched_entity.c |  8 +++++++-
 drivers/gpu/drm/scheduler/sched_rq.c     | 20 +++++++++-----------
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index bf97508a45b9..e4069fcb0272 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -563,9 +563,10 @@ struct drm_sched_job *drm_sched_entity_pop_job(struct drm_sched_entity *entity)
 	 */
 	smp_wmb();
 
+	spin_lock(&entity->lock);
 	spsc_queue_pop(&entity->job_queue);
-
 	drm_sched_rq_pop_entity(entity);
+	spin_unlock(&entity->lock);
 
 	/* Jobs and entities might have different lifecycles. Since we're
 	 * removing the job from the entities queue, set the jobs entity pointer
@@ -651,6 +652,9 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
 	 * Make sure to set the submit_ts first, to avoid a race.
 	 */
 	sched_job->submit_ts = submit_ts = ktime_get();
+
+	spin_lock(&entity->lock);
+
 	first = spsc_queue_push(&entity->job_queue, &sched_job->queue_node);
 
 	/* first job wakes up scheduler */
@@ -661,5 +665,7 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
 		if (sched)
 			drm_sched_wakeup(sched);
 	}
+
+	spin_unlock(&entity->lock);
 }
 EXPORT_SYMBOL(drm_sched_entity_push_job);
diff --git a/drivers/gpu/drm/scheduler/sched_rq.c b/drivers/gpu/drm/scheduler/sched_rq.c
index 0464d324d98d..23f46ec610e7 100644
--- a/drivers/gpu/drm/scheduler/sched_rq.c
+++ b/drivers/gpu/drm/scheduler/sched_rq.c
@@ -257,19 +257,17 @@ static ktime_t drm_sched_entity_get_job_ts(struct drm_sched_entity *entity)
 struct drm_gpu_scheduler *
 drm_sched_rq_add_entity(struct drm_sched_entity *entity, ktime_t ts)
 {
+	struct drm_sched_rq *rq = entity->rq;
 	struct drm_gpu_scheduler *sched;
-	struct drm_sched_rq *rq;
 
 	/* Add the entity to the run queue */
-	spin_lock(&entity->lock);
+	lockdep_assert_held(&entity->lock);
+
 	if (entity->stopped) {
-		spin_unlock(&entity->lock);
-
 		DRM_ERROR("Trying to push to a killed entity\n");
 		return NULL;
 	}
 
-	rq = entity->rq;
 	spin_lock(&rq->lock);
 	sched = rq->sched;
 
@@ -289,7 +287,6 @@ drm_sched_rq_add_entity(struct drm_sched_entity *entity, ktime_t ts)
 	drm_sched_rq_update_fifo_locked(entity, rq, ts);
 
 	spin_unlock(&rq->lock);
-	spin_unlock(&entity->lock);
 
 	return sched;
 }
@@ -343,16 +340,17 @@ drm_sched_rq_next_rr_ts(struct drm_sched_rq *rq,
  */
 void drm_sched_rq_pop_entity(struct drm_sched_entity *entity)
 {
+	struct drm_sched_rq *rq = entity->rq;
 	struct drm_sched_job *next_job;
-	struct drm_sched_rq *rq;
+
+	lockdep_assert_held(&entity->lock);
+
+	spin_lock(&rq->lock);
 
 	/*
 	 * Update the entity's location in the min heap according to
 	 * the timestamp of the next job, if any.
 	 */
-	spin_lock(&entity->lock);
-	rq = entity->rq;
-	spin_lock(&rq->lock);
 	next_job = drm_sched_entity_queue_peek(entity);
 	if (next_job) {
 		ktime_t ts;
@@ -375,8 +373,8 @@ void drm_sched_rq_pop_entity(struct drm_sched_entity *entity)
 			drm_sched_entity_save_vruntime(entity, min_vruntime);
 		}
 	}
+
 	spin_unlock(&rq->lock);
-	spin_unlock(&entity->lock);
 }
 
 /**
-- 
2.55.0

