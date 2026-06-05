Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73792CD8C81
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 16:07:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1799610E685;
	Fri,  5 Jun 2026 16:07:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="sAREeuvG";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB1FD10E677
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 16:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JrxL+2aKJYir/J6y65xj7tEIMnmeWQBuCT5So6PAZjY=; b=sAREeuvGs7pKqrhzBaM1+fhwyt
 ZcgetMKCdU+bAu39O7jS1PJWhcX2njUTqrw2JKjvwemqX1k2/WsVpYT5RDUpShTAHy0JCFZGVRUlR
 KEh5sj6U4wRJhqXA6fzeDiDvozFA6ALqRdqfeEiVEZZnWmLofECaIHEQpa9kmv6rgbA+4BZo8FRst
 fheHQn9tLdcc/OShmgHxYYNe21vfUfOIgGgKPY4fPCeAvkePLvrPe5b4MsiFVi4Kzuo+RM1axHshm
 lL6nEeDTMpq75MWEBgN7HtQHAu3/bu8CWSZXdWWhQedfpWUO2ElMh8uswWuRU+zFrsno9SH+L4yNX
 Rd3uQUBw==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wVX4p-00DGUE-3B; Fri, 05 Jun 2026 18:07:19 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Fri, 05 Jun 2026 13:06:59 -0300
Subject: [PATCH 2/3] drm/rocket: Submit one drm_sched_job per task
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260605-rocket-per-task-jobs-v1-2-e3319adf3c49@igalia.com>
References: <20260605-rocket-per-task-jobs-v1-0-e3319adf3c49@igalia.com>
In-Reply-To: <20260605-rocket-per-task-jobs-v1-0-e3319adf3c49@igalia.com>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, 
 Rob Herring <robh@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=18559; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=KjaU3f/wWTDFtNpf23rODYU8cryVDSDqOFMkeK6Lv84=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqIvQpH7oFgACgMkANIiSr4icrl/OM8bbhjytM3
 zoqniJRRGaJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCaiL0KQAKCRA/8w6Kdoj6
 qgdeCADY/kSZkBNuKe4NBCNC5ZHP6SPI2LM1AWQuDY6tKVKtFzb+M27XrKa5mDRZR49PgPX3em+
 0WB6s4GJUe8C14/DSNnM51H/HZgllx6d5KeyD1IQeAmL52j3s4kz6803yTIlusr2annPKBJIwt4
 Sl0qfr4eN+55WvCINShI556AU9NjEeXCA39ifxCOSqoiTDp+rO3llPYQxVfc6AFYZXBdGDxLjwG
 hS5e5AjrAP/gJ/HJykjMrgnoObiONfG2mcAScSm5FWKlNPm4mBSyut8u1d7/CbwEtldn17pE41L
 WuvH3s0+ndqjxIkvx3a8CO5cIE4YJodrB3nZoyg+pbnH9r++
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
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

The current submission model breaks the DRM scheduler's design in two
ways.

First, a job spawns further hardware work from outside the scheduler.
rocket_job_run() submits only the first task of an inference; every
subsequent task is submitted by the threaded IRQ handler, which calls
rocket_job_hw_submit() directly. The scheduler expects all of a job's
hardware submission to happen in run_job(). Driving it from the IRQ
handler instead is invisible to the scheduler, and drm_sched_stop() only
synchronizes the scheduler's workqueue, not the threaded IRQ, so the
reset path races these IRQ-driven submissions. The job_lock mutex and the
reset.pending flag exist only as a workaround that self-inflicted race.

Second, the submission path returns after arming a job. rocket_job_push()
calls drm_sched_job_arm() and only then acquires the BO fences, bailing
out and cleaning the job up if that fails. But arming is a point of no
return: per its documentation, "Once this function was called, you *must*
submit @job with drm_sched_entity_push_job()", because it publishes the
job's fences.

Redesign the submission so each task is its own drm_sched_job, which is
what the scheduler's model actually expects:

  - Every submission to the NPU flows through run_job(), and the IRQ
    handler only signals the task's fence. Nothing is started without the
    knowledge of the scheduler, so it can serialize submission against
    reset.

  - The BO reservations and implicit dependencies are acquired before any
    task is armed, so the only fallible step precedes the point of no
    return.

struct rocket_job becomes the refcounted inference shared by its tasks;
struct rocket_task becomes the per-task scheduled unit, and each task
holds a reference to the inference, so the last task to be freed marks it
done. Ordering between tasks comes from the per-file entity's FIFO and
arming all tasks up front pins the inference to one core. The implicit
BO dependencies and the completion fence are anchored on the last task.

The IOMMU domain is attached once by the first task to run and detached
when the last task drops its reference. On timeout the inference is marked
cancelled before the scheduler restarts; the remaining tasks observe the
flag in run_job() and fail with -ECANCELED without touching hardware, so
only the affected inference is abandoned.

With this, the Rocket driver can comply to the DRM scheduler's
expectations.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/accel/rocket/rocket_core.h |   5 +-
 drivers/accel/rocket/rocket_job.c  | 257 ++++++++++++++++++++-----------------
 drivers/accel/rocket/rocket_job.h  |  26 +++-
 3 files changed, 158 insertions(+), 130 deletions(-)

diff --git a/drivers/accel/rocket/rocket_core.h b/drivers/accel/rocket/rocket_core.h
index 4d163a6ac653..f74dc99d07bb 100644
--- a/drivers/accel/rocket/rocket_core.h
+++ b/drivers/accel/rocket/rocket_core.h
@@ -41,14 +41,13 @@ struct rocket_core {
 
 	struct iommu_group *iommu_group;
 
-	struct mutex job_lock;
-	struct rocket_job *in_flight_job;
+	/* Task currently running on the hardware. */
+	struct rocket_task *in_flight_task;
 
 	spinlock_t fence_lock;
 
 	struct {
 		struct workqueue_struct *wq;
-		atomic_t pending;
 	} reset;
 
 	struct drm_gpu_scheduler sched;
diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index 8a26139a44f4..871041eb7a1d 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -20,10 +20,10 @@
 
 #define JOB_TIMEOUT_MS 500
 
-static struct rocket_job *
-to_rocket_job(struct drm_sched_job *sched_job)
+static struct rocket_task *
+to_rocket_task(struct drm_sched_job *sched_job)
 {
-	return container_of(sched_job, struct rocket_job, base);
+	return container_of(sched_job, struct rocket_task, base);
 }
 
 static const char *rocket_fence_get_driver_name(struct dma_fence *fence)
@@ -61,8 +61,6 @@ rocket_copy_tasks(struct drm_device *dev,
 		  struct drm_rocket_job *job,
 		  struct rocket_job *rjob)
 {
-	int ret = 0;
-
 	if (job->task_struct_size < sizeof(struct drm_rocket_task))
 		return -EINVAL;
 
@@ -71,7 +69,7 @@ rocket_copy_tasks(struct drm_device *dev,
 	if (!rjob->task_count)
 		return 0;
 
-	rjob->tasks = kvmalloc_objs(*rjob->tasks, job->task_count);
+	rjob->tasks = kvzalloc_objs(*rjob->tasks, job->task_count);
 	if (!rjob->tasks) {
 		drm_dbg(dev, "Failed to allocate task array\n");
 		return -ENOMEM;
@@ -84,14 +82,12 @@ rocket_copy_tasks(struct drm_device *dev,
 				   u64_to_user_ptr(job->tasks) + i * job->task_struct_size,
 				   sizeof(task))) {
 			drm_dbg(dev, "Failed to copy incoming tasks\n");
-			ret = -EFAULT;
-			goto fail;
+			return -EFAULT;
 		}
 
 		if (task.regcmd_count == 0) {
 			drm_dbg(dev, "regcmd_count field in drm_rocket_task should be > 0.\n");
-			ret = -EINVAL;
-			goto fail;
+			return -EINVAL;
 		}
 
 		rjob->tasks[i].regcmd = task.regcmd;
@@ -99,26 +95,14 @@ rocket_copy_tasks(struct drm_device *dev,
 	}
 
 	return 0;
-
-fail:
-	kvfree(rjob->tasks);
-	return ret;
 }
 
-static void rocket_job_hw_submit(struct rocket_core *core, struct rocket_job *job)
+static void rocket_job_hw_submit(struct rocket_core *core, struct rocket_task *task)
 {
-	struct rocket_task *task;
 	unsigned int extra_bit;
 
-	/* Don't queue the job if a reset is in progress */
-	if (atomic_read(&core->reset.pending))
-		return;
-
 	/* GO ! */
 
-	task = &job->tasks[job->next_task_idx];
-	job->next_task_idx++;
-
 	rocket_pc_writel(core, BASE_ADDRESS, 0x1);
 
 	 /* From rknpu, in the TRM this bit is marked as reserved */
@@ -186,43 +170,68 @@ static void rocket_attach_object_fences(struct drm_gem_object **bos,
 static int rocket_job_push(struct rocket_job *job)
 {
 	struct rocket_device *rdev = job->rdev;
+	unsigned int bo_count = job->in_bo_count + job->out_bo_count;
+	struct rocket_task *last = &job->tasks[job->task_count - 1];
 	struct drm_gem_object **bos;
 	struct ww_acquire_ctx acquire_ctx;
-	int ret = 0;
+	int ret, i;
 
-	bos = kvmalloc_array(job->in_bo_count + job->out_bo_count, sizeof(void *),
-			     GFP_KERNEL);
+	bos = kvmalloc_array(bo_count, sizeof(void *), GFP_KERNEL);
+	if (!bos) {
+		ret = -ENOMEM;
+		goto err_cleanup_tasks;
+	}
 	memcpy(bos, job->in_bos, job->in_bo_count * sizeof(void *));
 	memcpy(&bos[job->in_bo_count], job->out_bos, job->out_bo_count * sizeof(void *));
 
-	ret = drm_gem_lock_reservations(bos, job->in_bo_count + job->out_bo_count, &acquire_ctx);
+	ret = drm_gem_lock_reservations(bos, bo_count, &acquire_ctx);
 	if (ret)
-		goto err;
+		goto err_free_bos;
 
-	scoped_guard(mutex, &rdev->sched_lock) {
-		drm_sched_job_arm(&job->base);
+	/* Anchor the BO synchronization on the last task: its finished fence is
+	 * the inference's completion fence.
+	 */
+	ret = rocket_acquire_object_fences(job->in_bos, job->in_bo_count,
+					   &last->base, false);
+	if (ret)
+		goto err_unlock;
 
-		job->inference_done_fence = dma_fence_get(&job->base.s_fence->finished);
+	ret = rocket_acquire_object_fences(job->out_bos, job->out_bo_count,
+					   &last->base, true);
+	if (ret)
+		goto err_unlock;
 
-		ret = rocket_acquire_object_fences(job->in_bos, job->in_bo_count, &job->base, false);
-		if (ret)
-			goto err_unlock;
+	mutex_lock(&rdev->sched_lock);
 
-		ret = rocket_acquire_object_fences(job->out_bos, job->out_bo_count, &job->base, true);
-		if (ret)
-			goto err_unlock;
+	for (i = 0; i < job->task_count; i++) {
+		drm_sched_job_arm(&job->tasks[i].base);
 
-		kref_get(&job->refcount); /* put by scheduler job completion */
+		if (i == job->task_count - 1)
+			job->inference_done_fence = dma_fence_get(&last->base.s_fence->finished);
 
-		drm_sched_entity_push_job(&job->base);
+		/* put by scheduler job completion */
+		kref_get(&job->refcount);
+
+		drm_sched_entity_push_job(&job->tasks[i].base);
 	}
 
-	rocket_attach_object_fences(job->out_bos, job->out_bo_count, job->inference_done_fence);
+	mutex_unlock(&rdev->sched_lock);
+
+	rocket_attach_object_fences(job->out_bos, job->out_bo_count,
+				    job->inference_done_fence);
+
+	drm_gem_unlock_reservations(bos, bo_count, &acquire_ctx);
+	kvfree(bos);
+
+	return 0;
 
 err_unlock:
-	drm_gem_unlock_reservations(bos, job->in_bo_count + job->out_bo_count, &acquire_ctx);
-err:
+	drm_gem_unlock_reservations(bos, bo_count, &acquire_ctx);
+err_free_bos:
 	kvfree(bos);
+err_cleanup_tasks:
+	for (i = 0; i < job->task_count; i++)
+		drm_sched_job_cleanup(&job->tasks[i].base);
 
 	return ret;
 }
@@ -233,10 +242,22 @@ static void rocket_job_cleanup(struct kref *ref)
 						refcount);
 	unsigned int i;
 
+	/*
+	 * The last task holding a reference is gone, so the inference is over.
+	 * The ordered scheduler workqueue runs this (from free_job()) before
+	 * the next inference's run_job(), so the core's IOMMU group is free
+	 * in time for it.
+	 */
+	if (job->core)
+		iommu_detach_group(NULL, job->core->iommu_group);
+
 	rocket_iommu_domain_put(job->domain);
 
-	dma_fence_put(job->done_fence);
-	dma_fence_put(job->inference_done_fence);
+	if (job->tasks) {
+		for (i = 0; i < job->task_count; i++)
+			dma_fence_put(job->tasks[i].done_fence);
+		dma_fence_put(job->inference_done_fence);
+	}
 
 	if (job->in_bos) {
 		for (i = 0; i < job->in_bo_count; i++)
@@ -264,11 +285,11 @@ static void rocket_job_put(struct rocket_job *job)
 
 static void rocket_job_free(struct drm_sched_job *sched_job)
 {
-	struct rocket_job *job = to_rocket_job(sched_job);
+	struct rocket_task *task = to_rocket_task(sched_job);
 
 	drm_sched_job_cleanup(sched_job);
 
-	rocket_job_put(job);
+	rocket_job_put(task->job);
 }
 
 static struct rocket_core *sched_to_core(struct rocket_device *rdev,
@@ -286,108 +307,102 @@ static struct rocket_core *sched_to_core(struct rocket_device *rdev,
 
 static struct dma_fence *rocket_job_run(struct drm_sched_job *sched_job)
 {
-	struct rocket_job *job = to_rocket_job(sched_job);
-	struct rocket_device *rdev = job->rdev;
-	struct rocket_core *core = sched_to_core(rdev, sched_job->sched);
+	struct rocket_task *task = to_rocket_task(sched_job);
+	struct rocket_job *job = task->job;
+	struct rocket_core *core = sched_to_core(job->rdev, sched_job->sched);
 	struct dma_fence *fence = NULL;
 	int ret;
 
-	if (unlikely(job->base.s_fence->finished.error))
+	if (unlikely(sched_job->s_fence->finished.error))
 		return NULL;
 
-	/*
-	 * Nothing to execute: can happen if the job has finished while
-	 * we were resetting the NPU.
-	 */
-	if (job->next_task_idx == job->task_count)
+	/* An earlier task of this inference timed out, abandon the inference. */
+	if (atomic_read(&job->cancelled)) {
+		dma_fence_set_error(&sched_job->s_fence->finished, -ECANCELED);
 		return NULL;
+	}
 
 	fence = rocket_fence_create(core);
 	if (IS_ERR(fence))
 		return fence;
 
-	if (job->done_fence)
-		dma_fence_put(job->done_fence);
-	job->done_fence = dma_fence_get(fence);
+	if (task->done_fence)
+		dma_fence_put(task->done_fence);
+	task->done_fence = dma_fence_get(fence);
 
-	ret = pm_runtime_get_sync(core->dev);
-	if (ret < 0)
-		return fence;
-
-	ret = iommu_attach_group(job->domain->domain, core->iommu_group);
-	if (ret < 0)
-		return fence;
-
-	scoped_guard(mutex, &core->job_lock) {
-		core->in_flight_job = job;
-		rocket_job_hw_submit(core, job);
+	ret = pm_runtime_resume_and_get(core->dev);
+	if (ret < 0) {
+		dma_fence_put(fence);
+		return ERR_PTR(ret);
 	}
 
+	/* Attach the domain once for the whole inference. */
+	if (!job->core) {
+		ret = iommu_attach_group(job->domain->domain, core->iommu_group);
+		if (ret < 0) {
+			pm_runtime_put_autosuspend(core->dev);
+			dma_fence_put(fence);
+			return ERR_PTR(ret);
+		}
+		job->core = core;
+	}
+
+	WRITE_ONCE(core->in_flight_task, task);
+	rocket_job_hw_submit(core, task);
+
 	return fence;
 }
 
 static void rocket_job_handle_irq(struct rocket_core *core)
 {
+	struct rocket_task *task;
+
 	pm_runtime_mark_last_busy(core->dev);
 
 	rocket_pc_writel(core, OPERATION_ENABLE, 0x0);
 	rocket_pc_writel(core, INTERRUPT_CLEAR, 0x1ffff);
 
-	scoped_guard(mutex, &core->job_lock)
-		if (core->in_flight_job) {
-			if (core->in_flight_job->next_task_idx < core->in_flight_job->task_count) {
-				rocket_job_hw_submit(core, core->in_flight_job);
-				return;
-			}
-
-			iommu_detach_group(NULL, iommu_group_get(core->dev));
-			dma_fence_signal(core->in_flight_job->done_fence);
-			pm_runtime_put_autosuspend(core->dev);
-			core->in_flight_job = NULL;
-		}
+	/*
+	 * Claim the in-flight task: the reset path may run concurrently, so
+	 * whichever of us wins owns the PM put.
+	 */
+	task = xchg(&core->in_flight_task, NULL);
+	if (task) {
+		pm_runtime_put_autosuspend(core->dev);
+		dma_fence_signal(task->done_fence);
+	}
 }
 
 static void
 rocket_reset(struct rocket_core *core, struct drm_sched_job *bad)
 {
-	if (!atomic_read(&core->reset.pending))
-		return;
+	struct rocket_task *task;
 
 	drm_sched_stop(&core->sched, bad);
 
-	/*
-	 * Remaining interrupts have been handled, but we might still have
-	 * stuck jobs. Let's make sure the PM counters stay balanced by
-	 * manually calling pm_runtime_put_noidle().
-	 */
-	scoped_guard(mutex, &core->job_lock) {
-		if (core->in_flight_job)
-			pm_runtime_put_noidle(core->dev);
-
-		iommu_detach_group(NULL, core->iommu_group);
-
-		core->in_flight_job = NULL;
-	}
+	/* Claim the in-flight task (see rocket_job_handle_irq()). */
+	task = xchg(&core->in_flight_task, NULL);
+	if (task)
+		pm_runtime_put_noidle(core->dev);
 
 	/* Proceed with reset now. */
 	rocket_core_reset(core);
 
-	/* NPU has been reset, we can clear the reset pending bit. */
-	atomic_set(&core->reset.pending, 0);
-
 	/* Restart the scheduler */
 	drm_sched_start(&core->sched, 0);
 }
 
 static enum drm_gpu_sched_stat rocket_job_timedout(struct drm_sched_job *sched_job)
 {
-	struct rocket_job *job = to_rocket_job(sched_job);
-	struct rocket_device *rdev = job->rdev;
-	struct rocket_core *core = sched_to_core(rdev, sched_job->sched);
+	struct rocket_task *task = to_rocket_task(sched_job);
+	struct rocket_job *job = task->job;
+	struct rocket_core *core = sched_to_core(job->rdev, sched_job->sched);
 
 	dev_err(core->dev, "NPU job timed out");
 
-	atomic_set(&core->reset.pending, 1);
+	/* Abandon the rest of the inference before the scheduler is restarted. */
+	atomic_set(&job->cancelled, 1);
+
 	rocket_reset(core, sched_job);
 
 	return DRM_GPU_SCHED_STAT_RESET;
@@ -437,7 +452,6 @@ int rocket_job_init(struct rocket_core *core)
 	int ret;
 
 	spin_lock_init(&core->fence_lock);
-	mutex_init(&core->job_lock);
 
 	core->irq = platform_get_irq(to_platform_device(core->dev), 0);
 	if (core->irq < 0)
@@ -526,7 +540,7 @@ static int rocket_ioctl_submit_job(struct drm_device *dev, struct drm_file *file
 	struct rocket_device *rdev = to_rocket_device(dev);
 	struct rocket_file_priv *file_priv = file->driver_priv;
 	struct rocket_job *rjob = NULL;
-	int ret = 0;
+	int i, ret = 0;
 
 	if (job->task_count == 0)
 		return -EINVAL;
@@ -536,42 +550,45 @@ static int rocket_ioctl_submit_job(struct drm_device *dev, struct drm_file *file
 		return -ENOMEM;
 
 	kref_init(&rjob->refcount);
-
+	atomic_set(&rjob->cancelled, 0);
 	rjob->rdev = rdev;
 
-	ret = drm_sched_job_init(&rjob->base,
-				 &file_priv->sched_entity,
-				 1, NULL, file->client_id);
-	if (ret)
-		goto out_put_job;
-
 	ret = rocket_copy_tasks(dev, file, job, rjob);
 	if (ret)
-		goto out_cleanup_job;
+		goto out_put_job;
+
+	for (i = 0; i < rjob->task_count; i++) {
+		ret = drm_sched_job_init(&rjob->tasks[i].base, &file_priv->sched_entity,
+					 1, NULL, file->client_id);
+		if (ret)
+			goto out_cleanup_tasks;
+
+		rjob->tasks[i].job = rjob;
+	}
 
 	ret = drm_gem_objects_lookup(file, u64_to_user_ptr(job->in_bo_handles),
 				     job->in_bo_handle_count, &rjob->in_bos);
 	if (ret)
-		goto out_cleanup_job;
+		goto out_cleanup_tasks;
 
 	rjob->in_bo_count = job->in_bo_handle_count;
 
 	ret = drm_gem_objects_lookup(file, u64_to_user_ptr(job->out_bo_handles),
 				     job->out_bo_handle_count, &rjob->out_bos);
 	if (ret)
-		goto out_cleanup_job;
+		goto out_cleanup_tasks;
 
 	rjob->out_bo_count = job->out_bo_handle_count;
 
 	rjob->domain = rocket_iommu_domain_get(file_priv);
 
 	ret = rocket_job_push(rjob);
-	if (ret)
-		goto out_cleanup_job;
 
-out_cleanup_job:
-	if (ret)
-		drm_sched_job_cleanup(&rjob->base);
+	goto out_put_job;
+
+out_cleanup_tasks:
+	for (i--; i >= 0; i--)
+		drm_sched_job_cleanup(&rjob->tasks[i].base);
 out_put_job:
 	rocket_job_put(rjob);
 
diff --git a/drivers/accel/rocket/rocket_job.h b/drivers/accel/rocket/rocket_job.h
index 4ae00feec3b9..50e2e9664911 100644
--- a/drivers/accel/rocket/rocket_job.h
+++ b/drivers/accel/rocket/rocket_job.h
@@ -10,13 +10,29 @@
 #include "rocket_core.h"
 #include "rocket_drv.h"
 
+/*
+ * A task is one hardware submission. Each task is its own drm_sched_job,
+ * so every submission to the NPU flows through run_job().
+ */
 struct rocket_task {
+	struct drm_sched_job base;
+
+	/* Inference this task belongs to. */
+	struct rocket_job *job;
+
 	u64 regcmd;
 	u32 regcmd_count;
+
+	/* Fence signaled by the IRQ handler once the hardware completes it. */
+	struct dma_fence *done_fence;
 };
 
+/* An inference: the whole userspace submission, made of one or more tasks. */
 struct rocket_job {
-	struct drm_sched_job base;
+	struct kref refcount;
+
+	/* Set when the inference must be abandoned (a task timed out). */
+	atomic_t cancelled;
 
 	struct rocket_device *rdev;
 
@@ -28,17 +44,13 @@ struct rocket_job {
 
 	struct rocket_task *tasks;
 	u32 task_count;
-	u32 next_task_idx;
 
-	/* Fence to be signaled by drm-sched once its done with the job */
 	struct dma_fence *inference_done_fence;
 
-	/* Fence to be signaled by IRQ handler when the job is complete. */
-	struct dma_fence *done_fence;
-
 	struct rocket_iommu_domain *domain;
 
-	struct kref refcount;
+	/* Core the domain is attached to. */
+	struct rocket_core *core;
 };
 
 int rocket_ioctl_submit(struct drm_device *dev, void *data, struct drm_file *file);

-- 
2.54.0

