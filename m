Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A0D0EFCBC7
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 04:33:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C279B10E2E4;
	Mon, 16 Mar 2026 04:33:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="SfToEGtf";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E0E410E2C7;
 Mon, 16 Mar 2026 04:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773635584; x=1805171584;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MFZYPFoQh+He7bvkR9zfQLB+IxfRno287YwHXnvwxVA=;
 b=SfToEGtfAr9G4egMjwdMiUWiF2Xx9qptQwli3zevljaa7x8c3H0WoDMT
 pJKJTPmLQCGBGk0lJb6f3dLRD8mBSgdylwOkByf5kAnwhsTwv1ZzqDNYg
 Ar8ueMK/hfoQrIVeMnnoPXAPE94ZgOj0VywDeRZJQ/7uTjk8wX5++lp8f
 KANSKIoQi2x707LHLyE1+MMKj8iWQStuRwNb+l0oxUsON3AxK8o1Kbghf
 hFkhJZURHMl5meIm9AQEgpKI7qyPz+IjGkNwjGj7/Fz8DhdTJx3fZRdWe
 v/6yZrUEVF79mt8vGnIMgXYHzV3N3l9J3+9BZV3CNyqvqkFdUiDWqO114 w==;
X-CSE-ConnectionGUID: gj5y+9/XSiGLHk0lT0VJEA==
X-CSE-MsgGUID: APevVPKQSXaMXdMYY//yWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="74683515"
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; d="scan'208";a="74683515"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2026 21:33:03 -0700
X-CSE-ConnectionGUID: yPie+y8KT9qeRnQj6JYWYQ==
X-CSE-MsgGUID: fjPwvP95SmmYyflZOy4ugA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; d="scan'208";a="221022175"
Received: from lstrano-desk.jf.intel.com ([10.54.39.91])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2026 21:33:03 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, Lizhi Hou <lizhi.hou@amd.com>,
 Min Ma <mamin506@gmail.com>, Oded Gabbay <ogabbay@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: [RFC PATCH 11/12] accel/amdxdna: Convert to drm_dep scheduler layer
Date: Sun, 15 Mar 2026 21:32:54 -0700
Message-Id: <20260316043255.226352-12-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260316043255.226352-1-matthew.brost@intel.com>
References: <20260316043255.226352-1-matthew.brost@intel.com>
MIME-Version: 1.0
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

Replace drm_gpu_scheduler/drm_sched_entity with the drm_dep layer
(struct drm_dep_queue / struct drm_dep_job).

aie2_pci.h: struct aie2_hwctx_priv drops the inline struct
drm_gpu_scheduler and struct drm_sched_entity fields in favour of a
heap-allocated struct drm_dep_queue *q.  The queue is allocated with
kzalloc_obj in aie2_ctx_init() and freed via drm_dep_queue_put() on
teardown and error paths.

amdxdna_ctx.h: struct amdxdna_sched_job drops struct drm_sched_job base
and struct kref refcnt in favour of struct drm_dep_job base.  Job
reference counting is handled by drm_dep_job_get/put() rather than a
private kref; aie2_job_put() is replaced with drm_dep_job_put().

aie2_ctx.c:
  - aie2_sched_job_run() updated to take struct drm_dep_job *; adds an
    early return of NULL when the queue is killed via
    drm_dep_queue_is_killed().
  - aie2_sched_job_free() renamed to aie2_sched_job_release() and wired
    as the .release vfunc on struct drm_dep_job_ops; the job free path
    (cleanup, counter increment, wake_up, dma_fence_put, kfree) is
    unchanged.
  - aie2_sched_job_timedout() updated to return drm_dep_timedout_stat.
    Stop/restart logic is guarded so it only runs once if the TDR fires
    multiple times.  Returns DRM_DEP_TIMEDOUT_STAT_JOB_SIGNALED if the
    job has already finished, DRM_DEP_TIMEDOUT_STAT_REQUEUE_JOB
    otherwise (replacing the previous DRM_GPU_SCHED_STAT_RESET).
  - drm_sched_stop/start replaced with drm_dep_queue_stop/start.
  - drm_sched_entity_destroy replaced with drm_dep_queue_kill +
    drm_dep_queue_put on the context destroy path.
  - drm_sched_job_init replaced with drm_dep_job_init.

trace/amdxdna.h: trace event updated to accept struct drm_dep_job *
instead of struct drm_sched_job *.

Cc: dri-devel@lists.freedesktop.org
Cc: Lizhi Hou <lizhi.hou@amd.com>
Cc: Min Ma <mamin506@gmail.com>
Cc: Oded Gabbay <ogabbay@kernel.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Assisted-by: GitHub Copilot:claude-sonnet-4.6
---
 drivers/accel/amdxdna/Kconfig       |   2 +-
 drivers/accel/amdxdna/aie2_ctx.c    | 144 +++++++++++++++-------------
 drivers/accel/amdxdna/aie2_pci.h    |   4 +-
 drivers/accel/amdxdna/amdxdna_ctx.c |   5 +-
 drivers/accel/amdxdna/amdxdna_ctx.h |   4 +-
 include/trace/events/amdxdna.h      |  12 ++-
 6 files changed, 88 insertions(+), 83 deletions(-)

diff --git a/drivers/accel/amdxdna/Kconfig b/drivers/accel/amdxdna/Kconfig
index f39d7a87296c..fdce1ef57cc0 100644
--- a/drivers/accel/amdxdna/Kconfig
+++ b/drivers/accel/amdxdna/Kconfig
@@ -6,7 +6,7 @@ config DRM_ACCEL_AMDXDNA
 	depends on DRM_ACCEL
 	depends on PCI && HAS_IOMEM
 	depends on X86_64
-	select DRM_SCHED
+	select DRM_DEP
 	select DRM_GEM_SHMEM_HELPER
 	select FW_LOADER
 	select HMM_MIRROR
diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
index 202c7a3eef24..89d3d30a5ad0 100644
--- a/drivers/accel/amdxdna/aie2_ctx.c
+++ b/drivers/accel/amdxdna/aie2_ctx.c
@@ -4,6 +4,7 @@
  */
 
 #include <drm/amdxdna_accel.h>
+#include <drm/drm_dep.h>
 #include <drm/drm_device.h>
 #include <drm/drm_gem.h>
 #include <drm/drm_gem_shmem_helper.h>
@@ -29,31 +30,18 @@ MODULE_PARM_DESC(force_cmdlist, "Force use command list (Default true)");
 
 #define HWCTX_MAX_TIMEOUT	60000 /* milliseconds */
 
-static void aie2_job_release(struct kref *ref)
-{
-	struct amdxdna_sched_job *job;
-
-	job = container_of(ref, struct amdxdna_sched_job, refcnt);
-	amdxdna_sched_job_cleanup(job);
-	atomic64_inc(&job->hwctx->job_free_cnt);
-	wake_up(&job->hwctx->priv->job_free_wq);
-	if (job->out_fence)
-		dma_fence_put(job->out_fence);
-	kfree(job);
-}
-
 static void aie2_job_put(struct amdxdna_sched_job *job)
 {
-	kref_put(&job->refcnt, aie2_job_release);
+	drm_dep_job_put(&job->base);
 }
 
 /* The bad_job is used in aie2_sched_job_timedout, otherwise, set it to NULL */
 static void aie2_hwctx_stop(struct amdxdna_dev *xdna, struct amdxdna_hwctx *hwctx,
-			    struct drm_sched_job *bad_job)
+			    struct drm_dep_job *bad_job)
 {
-	drm_sched_stop(&hwctx->priv->sched, bad_job);
+	drm_dep_queue_stop(hwctx->priv->q);
 	aie2_destroy_context(xdna->dev_handle, hwctx);
-	drm_sched_start(&hwctx->priv->sched, 0);
+	drm_dep_queue_start(hwctx->priv->q);
 }
 
 static int aie2_hwctx_restart(struct amdxdna_dev *xdna, struct amdxdna_hwctx *hwctx)
@@ -282,21 +270,24 @@ aie2_sched_cmdlist_resp_handler(void *handle, void __iomem *data, size_t size)
 }
 
 static struct dma_fence *
-aie2_sched_job_run(struct drm_sched_job *sched_job)
+aie2_sched_job_run(struct drm_dep_job *dep_job)
 {
-	struct amdxdna_sched_job *job = drm_job_to_xdna_job(sched_job);
+	struct amdxdna_sched_job *job = drm_job_to_xdna_job(dep_job);
 	struct amdxdna_gem_obj *cmd_abo = job->cmd_bo;
 	struct amdxdna_hwctx *hwctx = job->hwctx;
 	struct dma_fence *fence;
 	int ret;
 
+	if (drm_dep_queue_is_killed(job->hwctx->priv->q))
+		return NULL;
+
 	if (!hwctx->priv->mbox_chann)
 		return NULL;
 
 	if (!mmget_not_zero(job->mm))
 		return ERR_PTR(-ESRCH);
 
-	kref_get(&job->refcnt);
+	drm_dep_job_get(&job->base);
 	fence = dma_fence_get(job->fence);
 
 	if (job->drv_cmd) {
@@ -330,46 +321,58 @@ aie2_sched_job_run(struct drm_sched_job *sched_job)
 		mmput(job->mm);
 		fence = ERR_PTR(ret);
 	}
-	trace_xdna_job(sched_job, hwctx->name, "sent to device", job->seq);
+	trace_xdna_job(dep_job, hwctx->name, "sent to device", job->seq);
 
 	return fence;
 }
 
-static void aie2_sched_job_free(struct drm_sched_job *sched_job)
+static void aie2_sched_job_release(struct drm_dep_job *dep_job)
 {
-	struct amdxdna_sched_job *job = drm_job_to_xdna_job(sched_job);
+	struct amdxdna_sched_job *job = drm_job_to_xdna_job(dep_job);
 	struct amdxdna_hwctx *hwctx = job->hwctx;
 
-	trace_xdna_job(sched_job, hwctx->name, "job free", job->seq);
+	trace_xdna_job(dep_job, hwctx->name, "job free", job->seq);
 	if (!job->job_done)
 		up(&hwctx->priv->job_sem);
 
-	drm_sched_job_cleanup(sched_job);
-	aie2_job_put(job);
+	amdxdna_sched_job_cleanup(job);
+	atomic64_inc(&job->hwctx->job_free_cnt);
+	wake_up(&job->hwctx->priv->job_free_wq);
+	if (job->out_fence)
+		dma_fence_put(job->out_fence);
+	kfree(job);
 }
 
-static enum drm_gpu_sched_stat
-aie2_sched_job_timedout(struct drm_sched_job *sched_job)
+static const struct drm_dep_job_ops job_ops = {
+	.release = aie2_sched_job_release,
+};
+
+static enum drm_dep_timedout_stat
+aie2_sched_job_timedout(struct drm_dep_job *dep_job)
 {
-	struct amdxdna_sched_job *job = drm_job_to_xdna_job(sched_job);
+	struct amdxdna_sched_job *job = drm_job_to_xdna_job(dep_job);
 	struct amdxdna_hwctx *hwctx = job->hwctx;
 	struct amdxdna_dev *xdna;
 
-	xdna = hwctx->client->xdna;
-	trace_xdna_job(sched_job, hwctx->name, "job timedout", job->seq);
-	job->job_timeout = true;
-	mutex_lock(&xdna->dev_lock);
-	aie2_hwctx_stop(xdna, hwctx, sched_job);
+	if (!job->job_timeout) {
+		xdna = hwctx->client->xdna;
+		trace_xdna_job(dep_job, hwctx->name, "job timedout", job->seq);
+		job->job_timeout = true;
+		mutex_lock(&xdna->dev_lock);
+		aie2_hwctx_stop(xdna, hwctx, dep_job);
 
-	aie2_hwctx_restart(xdna, hwctx);
-	mutex_unlock(&xdna->dev_lock);
+		aie2_hwctx_restart(xdna, hwctx);
+		mutex_unlock(&xdna->dev_lock);
+	}
 
-	return DRM_GPU_SCHED_STAT_RESET;
+	if (drm_dep_job_is_finished(dep_job))
+		return DRM_DEP_TIMEDOUT_STAT_JOB_SIGNALED;
+	else
+		return DRM_DEP_TIMEDOUT_STAT_REQUEUE_JOB;
 }
 
-static const struct drm_sched_backend_ops sched_ops = {
+static const struct drm_dep_queue_ops sched_ops = {
 	.run_job = aie2_sched_job_run,
-	.free_job = aie2_sched_job_free,
 	.timedout_job = aie2_sched_job_timedout,
 };
 
@@ -534,15 +537,13 @@ int aie2_hwctx_init(struct amdxdna_hwctx *hwctx)
 {
 	struct amdxdna_client *client = hwctx->client;
 	struct amdxdna_dev *xdna = client->xdna;
-	const struct drm_sched_init_args args = {
+	const struct drm_dep_queue_init_args args = {
 		.ops = &sched_ops,
-		.num_rqs = DRM_SCHED_PRIORITY_COUNT,
 		.credit_limit = HWCTX_MAX_CMDS,
 		.timeout = msecs_to_jiffies(HWCTX_MAX_TIMEOUT),
 		.name = "amdxdna_js",
-		.dev = xdna->ddev.dev,
+		.drm = &xdna->ddev,
 	};
-	struct drm_gpu_scheduler *sched;
 	struct amdxdna_hwctx_priv *priv;
 	struct amdxdna_gem_obj *heap;
 	int i, ret;
@@ -591,30 +592,29 @@ int aie2_hwctx_init(struct amdxdna_hwctx *hwctx)
 		priv->cmd_buf[i] = abo;
 	}
 
-	sched = &priv->sched;
 	mutex_init(&priv->io_lock);
 
 	fs_reclaim_acquire(GFP_KERNEL);
 	might_lock(&priv->io_lock);
 	fs_reclaim_release(GFP_KERNEL);
 
-	ret = drm_sched_init(sched, &args);
-	if (ret) {
-		XDNA_ERR(xdna, "Failed to init DRM scheduler. ret %d", ret);
+	priv->q = kzalloc_obj(*priv->q);
+	if (!priv->q) {
+		ret = -ENOMEM;
 		goto free_cmd_bufs;
 	}
 
-	ret = drm_sched_entity_init(&priv->entity, DRM_SCHED_PRIORITY_NORMAL,
-				    &sched, 1, NULL);
+	ret = drm_dep_queue_init(priv->q, &args);
 	if (ret) {
-		XDNA_ERR(xdna, "Failed to initial sched entiry. ret %d", ret);
-		goto free_sched;
+		XDNA_ERR(xdna, "Failed to init dep queue. ret %d", ret);
+		kfree(priv->q);
+		goto free_cmd_bufs;
 	}
 
 	ret = aie2_hwctx_col_list(hwctx);
 	if (ret) {
 		XDNA_ERR(xdna, "Create col list failed, ret %d", ret);
-		goto free_entity;
+		goto free_queue;
 	}
 
 	ret = amdxdna_pm_resume_get_locked(xdna);
@@ -654,10 +654,8 @@ int aie2_hwctx_init(struct amdxdna_hwctx *hwctx)
 	amdxdna_pm_suspend_put(xdna);
 free_col_list:
 	kfree(hwctx->col_list);
-free_entity:
-	drm_sched_entity_destroy(&priv->entity);
-free_sched:
-	drm_sched_fini(&priv->sched);
+free_queue:
+	drm_dep_queue_put(priv->q);
 free_cmd_bufs:
 	for (i = 0; i < ARRAY_SIZE(priv->cmd_buf); i++) {
 		if (!priv->cmd_buf[i])
@@ -683,12 +681,13 @@ void aie2_hwctx_fini(struct amdxdna_hwctx *hwctx)
 	aie2_hwctx_wait_for_idle(hwctx);
 
 	/* Request fw to destroy hwctx and cancel the rest pending requests */
-	drm_sched_stop(&hwctx->priv->sched, NULL);
+	drm_dep_queue_stop(hwctx->priv->q);
 	aie2_release_resource(hwctx);
-	drm_sched_start(&hwctx->priv->sched, 0);
+	drm_dep_queue_start(hwctx->priv->q);
 
 	mutex_unlock(&xdna->dev_lock);
-	drm_sched_entity_destroy(&hwctx->priv->entity);
+	drm_dep_queue_kill(hwctx->priv->q);
+	drm_dep_queue_put(hwctx->priv->q);
 
 	/* Wait for all submitted jobs to be completed or canceled */
 	wait_event(hwctx->priv->job_free_wq,
@@ -696,7 +695,6 @@ void aie2_hwctx_fini(struct amdxdna_hwctx *hwctx)
 		   atomic64_read(&hwctx->job_free_cnt));
 	mutex_lock(&xdna->dev_lock);
 
-	drm_sched_fini(&hwctx->priv->sched);
 	aie2_ctx_syncobj_destroy(hwctx);
 
 	for (idx = 0; idx < ARRAY_SIZE(hwctx->priv->cmd_buf); idx++)
@@ -965,6 +963,7 @@ int aie2_cmd_submit(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *job,
 	ret = down_interruptible(&hwctx->priv->job_sem);
 	if (ret) {
 		XDNA_ERR(xdna, "Grab job sem failed, ret %d", ret);
+		goto err_sem;
 		return ret;
 	}
 
@@ -975,10 +974,13 @@ int aie2_cmd_submit(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *job,
 		goto up_sem;
 	}
 
-	ret = drm_sched_job_init(&job->base, &hwctx->priv->entity, 1, hwctx,
-				 hwctx->client->filp->client_id);
+	ret = drm_dep_job_init(&job->base, &(struct drm_dep_job_init_args){
+				.ops = &job_ops,
+				.q = hwctx->priv->q,
+				.credits = 1,
+			       });
 	if (ret) {
-		XDNA_ERR(xdna, "DRM job init failed, ret %d", ret);
+		XDNA_ERR(xdna, "DRM dep job init failed, ret %d", ret);
 		goto free_chain;
 	}
 
@@ -1020,13 +1022,12 @@ int aie2_cmd_submit(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *job,
 	}
 
 	mutex_lock(&hwctx->priv->io_lock);
-	drm_sched_job_arm(&job->base);
-	job->out_fence = dma_fence_get(&job->base.s_fence->finished);
+	drm_dep_job_arm(&job->base);
+	job->out_fence = dma_fence_get(drm_dep_job_finished_fence(&job->base));
 	for (i = 0; i < job->bo_cnt; i++)
 		dma_resv_add_fence(job->bos[i]->resv, job->out_fence, DMA_RESV_USAGE_WRITE);
 	job->seq = hwctx->priv->seq++;
-	kref_get(&job->refcnt);
-	drm_sched_entity_push_job(&job->base);
+	drm_dep_job_push(&job->base);
 
 	*seq = job->seq;
 	drm_syncobj_add_point(hwctx->priv->syncobj, chain, job->out_fence, *seq);
@@ -1035,18 +1036,23 @@ int aie2_cmd_submit(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *job,
 	up_read(&xdna->notifier_lock);
 	drm_gem_unlock_reservations(job->bos, job->bo_cnt, &acquire_ctx);
 
-	aie2_job_put(job);
 	atomic64_inc(&hwctx->job_submit_cnt);
+	aie2_job_put(job);
 
 	return 0;
 
 cleanup_job:
-	drm_sched_job_cleanup(&job->base);
+	aie2_job_put(job);
+	return ret;
+
 free_chain:
 	dma_fence_chain_free(chain);
 up_sem:
 	up(&hwctx->priv->job_sem);
 	job->job_done = true;
+err_sem:
+	amdxdna_sched_job_cleanup(job);
+	kfree(job);
 	return ret;
 }
 
diff --git a/drivers/accel/amdxdna/aie2_pci.h b/drivers/accel/amdxdna/aie2_pci.h
index 885ae7e6bfc7..63edcd7fb631 100644
--- a/drivers/accel/amdxdna/aie2_pci.h
+++ b/drivers/accel/amdxdna/aie2_pci.h
@@ -7,6 +7,7 @@
 #define _AIE2_PCI_H_
 
 #include <drm/amdxdna_accel.h>
+#include <drm/drm_dep.h>
 #include <linux/limits.h>
 #include <linux/semaphore.h>
 
@@ -165,8 +166,7 @@ struct amdxdna_hwctx_priv {
 	struct amdxdna_gem_obj		*heap;
 	void				*mbox_chann;
 
-	struct drm_gpu_scheduler	sched;
-	struct drm_sched_entity		entity;
+	struct drm_dep_queue		*q;
 
 	struct mutex			io_lock; /* protect seq and cmd order */
 	struct wait_queue_head		job_free_wq;
diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/amdxdna_ctx.c
index 838430903a3e..a9dc1677db47 100644
--- a/drivers/accel/amdxdna/amdxdna_ctx.c
+++ b/drivers/accel/amdxdna/amdxdna_ctx.c
@@ -509,11 +509,10 @@ int amdxdna_cmd_submit(struct amdxdna_client *client,
 		ret = -ENOMEM;
 		goto unlock_srcu;
 	}
-	kref_init(&job->refcnt);
 
 	ret = xdna->dev_info->ops->cmd_submit(hwctx, job, seq);
 	if (ret)
-		goto put_fence;
+		return ret;
 
 	/*
 	 * The amdxdna_hwctx_destroy_rcu() will release hwctx and associated
@@ -526,8 +525,6 @@ int amdxdna_cmd_submit(struct amdxdna_client *client,
 
 	return 0;
 
-put_fence:
-	dma_fence_put(job->fence);
 unlock_srcu:
 	srcu_read_unlock(&client->hwctx_srcu, idx);
 	amdxdna_pm_suspend_put(xdna);
diff --git a/drivers/accel/amdxdna/amdxdna_ctx.h b/drivers/accel/amdxdna/amdxdna_ctx.h
index fbdf9d000871..a92bd4d6f817 100644
--- a/drivers/accel/amdxdna/amdxdna_ctx.h
+++ b/drivers/accel/amdxdna/amdxdna_ctx.h
@@ -7,6 +7,7 @@
 #define _AMDXDNA_CTX_H_
 
 #include <linux/bitfield.h>
+#include <drm/drm_dep.h>
 
 #include "amdxdna_gem.h"
 
@@ -123,8 +124,7 @@ struct amdxdna_drv_cmd {
 };
 
 struct amdxdna_sched_job {
-	struct drm_sched_job	base;
-	struct kref		refcnt;
+	struct drm_dep_job	base;
 	struct amdxdna_hwctx	*hwctx;
 	struct mm_struct	*mm;
 	/* The fence to notice DRM scheduler that job is done by hardware */
diff --git a/include/trace/events/amdxdna.h b/include/trace/events/amdxdna.h
index c6cb2da7b706..798958edeb60 100644
--- a/include/trace/events/amdxdna.h
+++ b/include/trace/events/amdxdna.h
@@ -9,7 +9,7 @@
 #if !defined(_TRACE_AMDXDNA_H) || defined(TRACE_HEADER_MULTI_READ)
 #define _TRACE_AMDXDNA_H
 
-#include <drm/gpu_scheduler.h>
+#include <drm/drm_dep.h>
 #include <linux/tracepoint.h>
 
 TRACE_EVENT(amdxdna_debug_point,
@@ -30,9 +30,9 @@ TRACE_EVENT(amdxdna_debug_point,
 );
 
 TRACE_EVENT(xdna_job,
-	    TP_PROTO(struct drm_sched_job *sched_job, const char *name, const char *str, u64 seq),
+	    TP_PROTO(struct drm_dep_job *dep_job, const char *name, const char *str, u64 seq),
 
-	    TP_ARGS(sched_job, name, str, seq),
+	    TP_ARGS(dep_job, name, str, seq),
 
 	    TP_STRUCT__entry(__string(name, name)
 			     __string(str, str)
@@ -42,8 +42,10 @@ TRACE_EVENT(xdna_job,
 
 	    TP_fast_assign(__assign_str(name);
 			   __assign_str(str);
-			   __entry->fence_context = sched_job->s_fence->finished.context;
-			   __entry->fence_seqno = sched_job->s_fence->finished.seqno;
+			   __entry->fence_context =
+			   drm_dep_job_finished_fence(dep_job)->context;
+			   __entry->fence_seqno =
+			   drm_dep_job_finished_fence(dep_job)->seqno;
 			   __entry->seq = seq;),
 
 	    TP_printk("fence=(context:%llu, seqno:%lld), %s seq#:%lld %s",
-- 
2.34.1

