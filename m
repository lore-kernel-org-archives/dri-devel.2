Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D549C624D4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:33:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 765BF10F3DA;
	Thu,  3 Sep 2026 07:33:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="io4HP+Ib";
	dkim-atps=neutral
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9E3610F22C
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 14:42:14 +0000 (UTC)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-84830c774a0so1165925b3a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 07:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788360134; x=1788964934; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XQkUbpUylGU8m2JtfSkc6IhjmvgpBJhBApcP3k7Aq8I=;
 b=io4HP+IbiYEDaUKRaXPWghp9WkScrMcErU5HEx3z4N3o/vAM60o+xGQev+pfietpLH
 qc67bVst/IgcQAWrSFCzNttL08tPxnsLQTd+eYPj2dW6pRnT+bIqglTIuPWnjMdMySpO
 Bmjl7UwxAgV/q6D6QrKf7UqBAIPepvVixjDHdEhwuKn1H9myq4j+9BkIwZoteTvsFt6C
 Dc8CpKN8Nz+FmMJYaPwYQslAIXHWMrKDh4HEMZDBFm9OAbBjEBrSsmW60v/w46+r0Jra
 VzvzS7Fw+HplHVh+RW1M6iBNGWMwPByjy7pKQr+NxcYRN1zjQN32OXafTa8bs9ki4bOp
 VOyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788360134; x=1788964934;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XQkUbpUylGU8m2JtfSkc6IhjmvgpBJhBApcP3k7Aq8I=;
 b=DxZor06R8rh0kQWo/E6EsuiXr2JUjsUssauJvqNf6u5DlypHXPnahWADnpYBpEynFc
 26wDPcveQnRxY/Jfof42Mx2QogNsjCfUYpLMP2iaW5RFMtb2GWf/xl0Kd3g05ERfkLAu
 Tf6OzPXkHR1hjh2pQMxpOUIhHGydKOM1aiO682iXg0zijorlhQoSLv9KPEfGEgCUcyYO
 hiThCdCxPRP3NoQ0lsFc/hL8mPhrMgJuulOtQP4biCeFzt8TfNcV6mUgMvus0HNeGKda
 8qj03ERmCUDN924hoNrkxUWhDDRJT8LNj12B9MGVK1vlBNDpCPtIxsIZrEUbLU/G0wCW
 ffAg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw8WTz1yRZeFUnEHY9xTUi1nax3SsAQRHk26/py9iwszIYlfZ/W4eqaOASPafW2p/KRM14AGVmfkXs=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nLFVj3bUl+mCuX1lgMV2f2zWfEFPThQWrhN45rT2pAOQBjNumG
 /zLbFK4MK7cgarUg2F3QkExqg1LFKR2PvfbQiePzQn02TCOjVuyyANc=
X-Gm-Gg: AYBFou0lLiIKQotJcrwJtymFI8ezpmILTLxG0et1nRl6TUr96WnFcxH3ANjqPyobPVa
 Kc82MUVH86qbumN5gG4klUR8tDL86LIA7RONLPuy6waK4DZAbutVGjWN0rtODUWjDJd3MxErkGk
 6tWhx0nZ6ksbO3MDPEJxe+dIeIYDKDgsAnfXCMz2CMFncIa+FnCa/slIx+GefVGV/jzc20wJ44g
 ax4107sYs5ruldVKEpHDKhGdcflo+iZS/3eIkEuzXvZKljzeHeZHUavDL2OWZpCIUx8TGXoTUlp
 eIw/mwQ0TcqghkvGE4yzvVt7cVUCWDPoheLDP+Ql3H8R7FPvHRUr1tfmUsu9dg08hlQTnGO4Aso
 okVU7DrGVv8d2c06zjUniFkjqSImCAoQE74c34fl+o4nOD3/zKLgmtEqMCIHmlWJNevPMBxfrdn
 gfRpBqjgBHCIHHWcoFUnGyp0n61HFdDTvM/FvyTt8FJovoJCxystXEfUXY0TcrlproUGU54Yp0S
 n+Y1xPaQ8a1laOOP2b6U0urPdV/1SrhHXCZWA==
X-Received: by 2002:a05:6a00:3696:b0:845:e8b5:8c49 with SMTP id
 d2e1a72fcca58-85ed24e33ebmr8758834b3a.10.1788360134120; 
 Wed, 02 Sep 2026 07:42:14 -0700 (PDT)
Received: from MalHyuk.localdomain ([211.201.32.99])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-85db23f8d8asm1655776b3a.12.2026.09.02.07.42.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 07:42:13 -0700 (PDT)
From: "Jonghyuk Kim(MalHyuk)" <malhyuk97@gmail.com>
To: tursulin@ursulin.net, phasta@kernel.org, matthew.brost@intel.com,
 dakr@kernel.org
Cc: christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, "Jonghyuk Kim(MalHyuk)" <malhyuk97@gmail.com>
Subject: [PATCH v3 1/2] drm/sched: fix use-after-free of the fence timeline
 name
Date: Wed,  2 Sep 2026 23:42:03 +0900
Message-ID: <20260902144204.1843670-2-malhyuk97@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902144204.1843670-1-malhyuk97@gmail.com>
References: <20260902144204.1843670-1-malhyuk97@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 03 Sep 2026 07:33:13 +0000
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

drm_sched_fence_get_timeline_name() returns fence->sched->name. A driver
that allocates a drm_gpu_scheduler per context, queue or VM frees that
scheduler when the context is destroyed, but the finished fence can
outlive it: unprivileged userspace can hold the exported fence through a
sync_file or drm_syncobj and query its timeline name afterwards (e.g. via
SYNC_IOC_FILE_INFO), dereferencing the freed scheduler. This is a
slab-use-after-free read; once the slab is re-sprayed it becomes an info
leak. It is the same class as CVE-2025-38703 (drm/xe) and CVE-2025-71302
(drm/panthor), which were fixed per driver. amdxdna, nouveau and msm
(VM_BIND) allocate per-context schedulers and are still affected.

The dma-fence contract already forbids touching driver-provided data -
the memory reachable through &dma_fence.ops - once a fence is signalled,
and dma_fence_timeline_name() enforces it: after the ops are detached it
returns a static string instead of calling get_timeline_name().
dma_fence detaches the ops on signalling, but only for fences that carry
neither a .release nor a .wait callback (see
dma_fence_signal_timestamp_locked()).

The finished fence carried a .release callback solely to drop the
scheduled fence's reference. That callback kept the ops attached, leaving
get_timeline_name() reachable on a signalled finished fence with a
dangling ->sched. Drop the callback and move the reference handling
instead:

 - The scheduled fence now holds a reference on the finished fence, so
   the finished fence, and with it the shared allocation, is released
   last. Its release drops the parent fence and that finished-fence
   reference; the finished fence is then freed from dma_fence_free().
   This requires @finished to sit at offset 0 of struct drm_sched_fence,
   since dma_fence_free() ultimately kfree()s the fence pointer.
 - drm_sched_job_cleanup() drops the scheduled fence's initial reference,
   which the removed .release used to cascade.

With the finished fence no longer carrying .release its ops are detached
on signalling, so get_timeline_name() can no longer run against a freed
scheduler. Unlike caching the name string, this also covers drivers whose
timeline name is dynamically allocated (drm/panthor, drm/xe).

Detaching the ops on signalling also makes to_drm_sched_fence() return
NULL for a signalled finished fence. Callers already handle a NULL return
- it is the normal result for a foreign fence - and a signalled fence is
an already-satisfied dependency, so the scheduler's dependency-collapsing
optimisation is unaffected. It additionally avoids the container_of() on
a possibly-freed foreign scheduler that amdgpu_sync_same_dev() and
pvr_queue_fence_is_native() would otherwise perform.

Suggested-by: Philipp Stanner <phasta@kernel.org>
Signed-off-by: Jonghyuk Kim(MalHyuk) <malhyuk97@gmail.com>
---
 drivers/gpu/drm/scheduler/sched_fence.c | 46 ++++++++--------
 drivers/gpu/drm/scheduler/sched_main.c  |  9 ++++
 include/drm/gpu_scheduler.h             | 72 ++++++++++++++-----------
 3 files changed, 71 insertions(+), 56 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_fence.c b/drivers/gpu/drm/scheduler/sched_fence.c
index 096fe28aa9c9..f463afa0ee4e 100644
--- a/drivers/gpu/drm/scheduler/sched_fence.c
+++ b/drivers/gpu/drm/scheduler/sched_fence.c
@@ -95,15 +95,6 @@ static const char *drm_sched_fence_get_timeline_name(struct dma_fence *f)
 	return (const char *)fence->sched->name;
 }
 
-static void drm_sched_fence_free_rcu(struct rcu_head *rcu)
-{
-	struct dma_fence *f = container_of(rcu, struct dma_fence, rcu);
-	struct drm_sched_fence *fence = to_drm_sched_fence(f);
-
-	if (!WARN_ON_ONCE(!fence))
-		kmem_cache_free(sched_fence_slab, fence);
-}
-
 /**
  * drm_sched_fence_free - free up an uninitialized fence
  *
@@ -132,21 +123,12 @@ static void drm_sched_fence_release_scheduled(struct dma_fence *f)
 	struct drm_sched_fence *fence = to_drm_sched_fence(f);
 
 	dma_fence_put(fence->parent);
-	call_rcu(&fence->finished.rcu, drm_sched_fence_free_rcu);
-}
-
-/**
- * drm_sched_fence_release_finished - drop extra reference
- *
- * @f: fence
- *
- * Drop the extra reference from the scheduled fence to the base fence.
- */
-static void drm_sched_fence_release_finished(struct dma_fence *f)
-{
-	struct drm_sched_fence *fence = to_drm_sched_fence(f);
-
-	dma_fence_put(&fence->scheduled);
+	/*
+	 * Drop the reference the scheduled fence holds on the finished fence.
+	 * The finished fence is released last and frees the shared allocation
+	 * from its dma_fence_free() (see drm_sched_fence_init()).
+	 */
+	dma_fence_put(&fence->finished);
 }
 
 static void drm_sched_fence_set_deadline_finished(struct dma_fence *f,
@@ -189,7 +171,13 @@ static const struct dma_fence_ops drm_sched_fence_ops_scheduled = {
 static const struct dma_fence_ops drm_sched_fence_ops_finished = {
 	.get_driver_name = drm_sched_fence_get_driver_name,
 	.get_timeline_name = drm_sched_fence_get_timeline_name,
-	.release = drm_sched_fence_release_finished,
+	/*
+	 * No .release callback: dma_fence detaches ->ops on signalling for
+	 * fences without .release/.wait, so get_timeline_name() is never called
+	 * on a signalled finished fence and cannot dereference a freed
+	 * scheduler. The shared allocation is freed from dma_fence_free() once
+	 * this fence's refcount drops - it is released last, after @scheduled.
+	 */
 	.set_deadline = drm_sched_fence_set_deadline_finished,
 };
 
@@ -233,6 +221,14 @@ void drm_sched_fence_init(struct drm_sched_fence *fence,
 		       &fence->lock, entity->fence_context, seq);
 	dma_fence_init(&fence->finished, &drm_sched_fence_ops_finished,
 		       &fence->lock, entity->fence_context + 1, seq);
+
+	/*
+	 * Hold a reference on the finished fence from the scheduled fence, so
+	 * the finished fence (and the shared allocation) outlives @scheduled.
+	 * drm_sched_fence_release_scheduled() drops it; the finished fence is
+	 * therefore released last and frees the allocation via dma_fence_free().
+	 */
+	dma_fence_get(&fence->finished);
 }
 
 module_init(drm_sched_fence_slab_init);
diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 6cb6f9546493..fb238f51c0ed 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -842,6 +842,15 @@ void drm_sched_job_cleanup(struct drm_sched_job *job)
 		 * been called.
 		 */
 		dma_fence_put(&job->s_fence->finished);
+		/*
+		 * Drop the initial reference on the scheduled fence. It no
+		 * longer has a .release callback dropping it (the finished
+		 * fence's .release was removed to allow ops-detach on signal),
+		 * so the last put here lets drm_sched_fence_release_scheduled()
+		 * run, which drops @parent and the scheduled fence's reference
+		 * on @finished. @finished is freed last, from dma_fence_free().
+		 */
+		dma_fence_put(&job->s_fence->scheduled);
 		drm_sched_entity_stats_put(job->entity_stats);
 	} else {
 		/* The job was aborted before it has been committed to be run;
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 7a64cc11de08..686c3687944f 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -287,48 +287,58 @@ struct drm_sched_rq {
  * struct drm_sched_fence - fences corresponding to the scheduling of a job.
  */
 struct drm_sched_fence {
-        /**
-         * @scheduled: this fence is what will be signaled by the scheduler
-         * when the job is scheduled.
-         */
-	struct dma_fence		scheduled;
-
-        /**
-         * @finished: this fence is what will be signaled by the scheduler
-         * when the job is completed.
-         *
-         * When setting up an out fence for the job, you should use
-         * this, since it's available immediately upon
-         * drm_sched_job_init(), and the fence returned by the driver
-         * from run_job() won't be created until the dependencies have
-         * resolved.
-         */
+	/**
+	 * @finished: this fence is what will be signaled by the scheduler
+	 * when the job is completed.
+	 *
+	 * When setting up an out fence for the job, you should use
+	 * this, since it's available immediately upon
+	 * drm_sched_job_init(), and the fence returned by the driver
+	 * from run_job() won't be created until the dependencies have
+	 * resolved.
+	 *
+	 * @finished is kept first in the struct: it is the fence exported to
+	 * userspace and therefore the one whose &dma_fence_ops.release is
+	 * dropped so that dma_fence detaches its ops on signalling. It is
+	 * released last (see &drm_sched_fence.scheduled) and frees the whole
+	 * object via dma_fence_free(), which requires it to sit at offset 0.
+	 */
 	struct dma_fence		finished;
 
+	/**
+	 * @scheduled: this fence is what will be signaled by the scheduler
+	 * when the job is scheduled.
+	 *
+	 * It holds a reference on @finished so that the shared allocation is
+	 * released only after @scheduled itself is done; its release drops
+	 * that reference and the @parent one.
+	 */
+	struct dma_fence		scheduled;
+
 	/**
 	 * @deadline: deadline set on &drm_sched_fence.finished which
 	 * potentially needs to be propagated to &drm_sched_fence.parent
 	 */
 	ktime_t				deadline;
 
-        /**
-         * @parent: the fence returned by &drm_sched_backend_ops.run_job
-         * when scheduling the job on hardware. We signal the
-         * &drm_sched_fence.finished fence once parent is signalled.
-         */
+	/**
+	 * @parent: the fence returned by &drm_sched_backend_ops.run_job
+	 * when scheduling the job on hardware. We signal the
+	 * &drm_sched_fence.finished fence once parent is signalled.
+	 */
 	struct dma_fence		*parent;
-        /**
-         * @sched: the scheduler instance to which the job having this struct
-         * belongs to.
-         */
+	/**
+	 * @sched: the scheduler instance to which the job having this struct
+	 * belongs to.
+	 */
 	struct drm_gpu_scheduler	*sched;
-        /**
-         * @lock: the lock used by the scheduled and the finished fences.
-         */
+	/**
+	 * @lock: the lock used by the scheduled and the finished fences.
+	 */
 	spinlock_t			lock;
-        /**
-         * @owner: job owner for debugging
-         */
+	/**
+	 * @owner: job owner for debugging
+	 */
 	void				*owner;
 
 	/**
-- 
2.43.0

