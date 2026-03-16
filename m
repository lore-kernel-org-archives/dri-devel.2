Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35FC4EFCBBD
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 04:33:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6111310E2E2;
	Mon, 16 Mar 2026 04:33:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="D1H8UkY5";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8725510E2C9;
 Mon, 16 Mar 2026 04:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773635584; x=1805171584;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KkaNyHpQY5hfizsCDAGy6+7caJdagrR38y8raw/dbKs=;
 b=D1H8UkY53fUYia7fIyjm4brzlPGS9DYmqmoDkyrZ6UUTh04ABEdlfPBB
 tmFSE1mdiw3TeD0ImNMpsQuB+2ngvZ/Bx/P/Bae3BcZhbhLXp0RlsBCY8
 Jp3aY9UbfAmPCZc2MhOATCNfcJSJQZdQP85vqUtS5PJfOl+LM690liNP/
 tu57dq0ieswxEP1eQn2RTWmZ369O7gaXI1QgyfwtmQMd0PGqAKlfd2CaH
 n1Z12TTUu3/DmhMJXEdj/q++q/33llswOjxMsAOV45T3QF9i9qwfRlde3
 KQ2chR88l/bgrWxLNiOqrnVGJA9Xtzz4whWtru/nACCTM14YImIoJiuew w==;
X-CSE-ConnectionGUID: 2gourg8YRVafiGTjsSo/TQ==
X-CSE-MsgGUID: hjw8nbwWRKinaStLL7zzzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="74683516"
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; d="scan'208";a="74683516"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2026 21:33:03 -0700
X-CSE-ConnectionGUID: JioJQ+XRTEWioiHC+Na2gg==
X-CSE-MsgGUID: vMO0m24FRpiBuC5q1t9KGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; d="scan'208";a="221022176"
Received: from lstrano-desk.jf.intel.com ([10.54.39.91])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2026 21:33:03 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
 Boris Brezillon <boris.brezillon@collabora.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 Steven Price <steven.price@arm.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 12/12] drm/panthor: Convert to drm_dep scheduler layer
Date: Sun, 15 Mar 2026 21:32:55 -0700
Message-Id: <20260316043255.226352-13-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260316043255.226352-1-matthew.brost@intel.com>
References: <20260316043255.226352-1-matthew.brost@intel.com>
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

Replace drm_gpu_scheduler/drm_sched_entity with the drm_dep layer
(struct drm_dep_queue / struct drm_dep_job) across all Panthor
submission paths: the CSF queue scheduler and the VM_BIND scheduler.

panthor_sched.c — CSF queue scheduler:
  struct panthor_queue drops the inline struct drm_gpu_scheduler and
  struct drm_sched_entity, replacing them with an embedded struct
  drm_dep_queue q.  The 1:1 scheduler:entity pairing that drm_sched
  required collapses into the single queue object.  queue_run_job() and
  queue_timedout_job() updated to drm_dep signatures and return types.
  queue_timedout_job() guards the reset path so it only fires once;
  returns DRM_DEP_TIMEDOUT_STAT_JOB_SIGNALED.  Stop/start on reset
  updated to drm_dep_queue_stop/start.  The timeout workqueue is
  accessed via drm_dep_queue_timeout_wq() for mod_delayed_work() calls.
  Queue teardown simplified from a multi-step disable_delayed_work_sync
  / entity_destroy / sched_fini sequence to drm_dep_queue_put().

  struct panthor_job drops struct drm_sched_job base and struct kref
  refcount in favour of struct drm_dep_job base.  panthor_job_get/put()
  updated to drm_dep_job_get/put().  job_release() becomes the .release
  vfunc on struct drm_dep_job_ops; job_release() body moves to
  job_cleanup() which is called from both the release vfunc and the
  init error path.  drm_sched_job_init replaced with drm_dep_job_init.
  panthor_job_update_resvs() updated to use drm_dep_job_finished_fence()
  instead of sched_job->s_fence->finished.

panthor_mmu.c — VM_BIND scheduler:
  struct panthor_vm drops the inline struct drm_gpu_scheduler and struct
  drm_sched_entity in favour of a heap-allocated struct drm_dep_queue *q.
  The queue is allocated with kzalloc_obj and freed via
  drm_dep_queue_put().  Queue init gains
  DRM_DEP_QUEUE_FLAGS_JOB_PUT_IRQ_SAFE and
  DRM_DEP_QUEUE_FLAGS_BYPASS_SUPPORTED flags appropriate for the VM_BIND
  path.  panthor_vm_bind_run_job() and panthor_vm_bind_timedout_job()
  updated to drm_dep signatures; timedout returns
  DRM_DEP_TIMEDOUT_STAT_JOB_SIGNALED.  panthor_vm_bind_job_release()
  becomes the .release vfunc; the old panthor_vm_bind_job_put() wrapper
  is replaced with drm_dep_job_put().  VM stop/start on reset path and
  destroy path updated to drm_dep_queue_stop/start/put.
  drm_dep_job_finished_fence() used in place of s_fence->finished.

Cc: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Steven Price <steven.price@arm.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Assisted-by: GitHub Copilot:claude-sonnet-4.6
---
 drivers/gpu/drm/panthor/Kconfig          |   2 +-
 drivers/gpu/drm/panthor/panthor_device.c |   5 +-
 drivers/gpu/drm/panthor/panthor_device.h |   2 +-
 drivers/gpu/drm/panthor/panthor_drv.c    |  35 ++--
 drivers/gpu/drm/panthor/panthor_mmu.c    | 160 +++++++--------
 drivers/gpu/drm/panthor/panthor_mmu.h    |  14 +-
 drivers/gpu/drm/panthor/panthor_sched.c  | 242 +++++++++++------------
 drivers/gpu/drm/panthor/panthor_sched.h  |  12 +-
 8 files changed, 223 insertions(+), 249 deletions(-)

diff --git a/drivers/gpu/drm/panthor/Kconfig b/drivers/gpu/drm/panthor/Kconfig
index 55b40ad07f3b..e22f7dc33dff 100644
--- a/drivers/gpu/drm/panthor/Kconfig
+++ b/drivers/gpu/drm/panthor/Kconfig
@@ -10,7 +10,7 @@ config DRM_PANTHOR
 	select DRM_EXEC
 	select DRM_GEM_SHMEM_HELPER
 	select DRM_GPUVM
-	select DRM_SCHED
+	select DRM_DEP
 	select IOMMU_IO_PGTABLE_LPAE
 	select IOMMU_SUPPORT
 	select PM_DEVFREQ
diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
index 54fbb1aa07c5..66a01f26a52b 100644
--- a/drivers/gpu/drm/panthor/panthor_device.c
+++ b/drivers/gpu/drm/panthor/panthor_device.c
@@ -11,6 +11,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 
+#include <drm/drm_dep.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_managed.h>
 #include <drm/drm_print.h>
@@ -231,7 +232,9 @@ int panthor_device_init(struct panthor_device *ptdev)
 	*dummy_page_virt = 1;
 
 	INIT_WORK(&ptdev->reset.work, panthor_device_reset_work);
-	ptdev->reset.wq = alloc_ordered_workqueue("panthor-reset-wq", 0);
+	ptdev->reset.wq = alloc_ordered_workqueue("panthor-reset-wq",
+						  WQ_MEM_RECLAIM |
+						  WQ_MEM_WARN_ON_RECLAIM);
 	if (!ptdev->reset.wq)
 		return -ENOMEM;
 
diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index b6696f73a536..d2c05c1ee513 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -15,7 +15,7 @@
 
 #include <drm/drm_device.h>
 #include <drm/drm_mm.h>
-#include <drm/gpu_scheduler.h>
+#include <drm/drm_dep.h>
 #include <drm/panthor_drm.h>
 
 struct panthor_csf;
diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index 1bcec6a2e3e0..086f9f28c6be 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -23,7 +23,7 @@
 #include <drm/drm_print.h>
 #include <drm/drm_syncobj.h>
 #include <drm/drm_utils.h>
-#include <drm/gpu_scheduler.h>
+#include <drm/drm_dep.h>
 #include <drm/panthor_drm.h>
 
 #include "panthor_devfreq.h"
@@ -269,8 +269,8 @@ struct panthor_sync_signal {
  * struct panthor_job_ctx - Job context
  */
 struct panthor_job_ctx {
-	/** @job: The job that is about to be submitted to drm_sched. */
-	struct drm_sched_job *job;
+	/** @job: The job that is about to be submitted to drm_dep. */
+	struct drm_dep_job *job;
 
 	/** @syncops: Array of sync operations. */
 	struct drm_panthor_sync_op *syncops;
@@ -452,7 +452,7 @@ panthor_submit_ctx_search_sync_signal(struct panthor_submit_ctx *ctx, u32 handle
  */
 static int
 panthor_submit_ctx_add_job(struct panthor_submit_ctx *ctx, u32 idx,
-			   struct drm_sched_job *job,
+			   struct drm_dep_job *job,
 			   const struct drm_panthor_obj_array *syncs)
 {
 	int ret;
@@ -502,7 +502,7 @@ panthor_submit_ctx_update_job_sync_signal_fences(struct panthor_submit_ctx *ctx,
 	struct panthor_device *ptdev = container_of(ctx->file->minor->dev,
 						    struct panthor_device,
 						    base);
-	struct dma_fence *done_fence = &ctx->jobs[job_idx].job->s_fence->finished;
+	struct dma_fence *done_fence = drm_dep_job_finished_fence(ctx->jobs[job_idx].job);
 	const struct drm_panthor_sync_op *sync_ops = ctx->jobs[job_idx].syncops;
 	u32 sync_op_count = ctx->jobs[job_idx].syncop_count;
 
@@ -604,7 +604,7 @@ panthor_submit_ctx_add_sync_deps_to_job(struct panthor_submit_ctx *ctx,
 						    struct panthor_device,
 						    base);
 	const struct drm_panthor_sync_op *sync_ops = ctx->jobs[job_idx].syncops;
-	struct drm_sched_job *job = ctx->jobs[job_idx].job;
+	struct drm_dep_job *job = ctx->jobs[job_idx].job;
 	u32 sync_op_count = ctx->jobs[job_idx].syncop_count;
 	int ret = 0;
 
@@ -634,7 +634,7 @@ panthor_submit_ctx_add_sync_deps_to_job(struct panthor_submit_ctx *ctx,
 				return ret;
 		}
 
-		ret = drm_sched_job_add_dependency(job, fence);
+		ret = drm_dep_job_add_dependency(job, fence);
 		if (ret)
 			return ret;
 	}
@@ -681,8 +681,11 @@ panthor_submit_ctx_add_deps_and_arm_jobs(struct panthor_submit_ctx *ctx)
 		if (ret)
 			return ret;
 
-		drm_sched_job_arm(ctx->jobs[i].job);
+		drm_dep_job_arm(ctx->jobs[i].job);
 
+		/*
+		 * XXX: Failing path hazard... per DRM dep this is not allowed
+		 */
 		ret = panthor_submit_ctx_update_job_sync_signal_fences(ctx, i);
 		if (ret)
 			return ret;
@@ -699,11 +702,11 @@ panthor_submit_ctx_add_deps_and_arm_jobs(struct panthor_submit_ctx *ctx)
  */
 static void
 panthor_submit_ctx_push_jobs(struct panthor_submit_ctx *ctx,
-			     void (*upd_resvs)(struct drm_exec *, struct drm_sched_job *))
+			     void (*upd_resvs)(struct drm_exec *, struct drm_dep_job *))
 {
 	for (u32 i = 0; i < ctx->job_count; i++) {
 		upd_resvs(&ctx->exec, ctx->jobs[i].job);
-		drm_sched_entity_push_job(ctx->jobs[i].job);
+		drm_dep_job_push(ctx->jobs[i].job);
 
 		/* Job is owned by the scheduler now. */
 		ctx->jobs[i].job = NULL;
@@ -743,7 +746,7 @@ static int panthor_submit_ctx_init(struct panthor_submit_ctx *ctx,
  * @job_put: Job put callback.
  */
 static void panthor_submit_ctx_cleanup(struct panthor_submit_ctx *ctx,
-				       void (*job_put)(struct drm_sched_job *))
+				       void (*job_put)(struct drm_dep_job *))
 {
 	struct panthor_sync_signal *sig_sync, *tmp;
 	unsigned long i;
@@ -1004,7 +1007,7 @@ static int panthor_ioctl_group_submit(struct drm_device *ddev, void *data,
 	/* Create jobs and attach sync operations */
 	for (u32 i = 0; i < args->queue_submits.count; i++) {
 		const struct drm_panthor_queue_submit *qsubmit = &jobs_args[i];
-		struct drm_sched_job *job;
+		struct drm_dep_job *job;
 
 		job = panthor_job_create(pfile, args->group_handle, qsubmit,
 					 file->client_id);
@@ -1032,11 +1035,11 @@ static int panthor_ioctl_group_submit(struct drm_device *ddev, void *data,
 	 * dependency registration.
 	 *
 	 * This is solving two problems:
-	 * 1. drm_sched_job_arm() and drm_sched_entity_push_job() must be
+	 * 1. drm_dep_job_arm() and drm_dep_job_push() must be
 	 *    protected by a lock to make sure no concurrent access to the same
-	 *    entity get interleaved, which would mess up with the fence seqno
+	 *    queue gets interleaved, which would mess up with the fence seqno
 	 *    ordering. Luckily, one of the resv being acquired is the VM resv,
-	 *    and a scheduling entity is only bound to a single VM. As soon as
+	 *    and a dep queue is only bound to a single VM. As soon as
 	 *    we acquire the VM resv, we should be safe.
 	 * 2. Jobs might depend on fences that were issued by previous jobs in
 	 *    the same batch, so we can't add dependencies on all jobs before
@@ -1232,7 +1235,7 @@ static int panthor_ioctl_vm_bind_async(struct drm_device *ddev,
 
 	for (u32 i = 0; i < args->ops.count; i++) {
 		struct drm_panthor_vm_bind_op *op = &jobs_args[i];
-		struct drm_sched_job *job;
+		struct drm_dep_job *job;
 
 		job = panthor_vm_bind_job_create(file, vm, op);
 		if (IS_ERR(job)) {
diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index f8c41e36afa4..45e5f0d71594 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -8,7 +8,7 @@
 #include <drm/drm_gpuvm.h>
 #include <drm/drm_managed.h>
 #include <drm/drm_print.h>
-#include <drm/gpu_scheduler.h>
+#include <drm/drm_dep.h>
 #include <drm/panthor_drm.h>
 
 #include <linux/atomic.h>
@@ -232,19 +232,9 @@ struct panthor_vm {
 	struct drm_gpuvm base;
 
 	/**
-	 * @sched: Scheduler used for asynchronous VM_BIND request.
-	 *
-	 * We use a 1:1 scheduler here.
-	 */
-	struct drm_gpu_scheduler sched;
-
-	/**
-	 * @entity: Scheduling entity representing the VM_BIND queue.
-	 *
-	 * There's currently one bind queue per VM. It doesn't make sense to
-	 * allow more given the VM operations are serialized anyway.
+	 * @q: Dep queue used for asynchronous VM_BIND request.
 	 */
-	struct drm_sched_entity entity;
+	struct drm_dep_queue *q;
 
 	/** @ptdev: Device. */
 	struct panthor_device *ptdev;
@@ -262,7 +252,7 @@ struct panthor_vm {
 	 * @op_lock: Lock used to serialize operations on a VM.
 	 *
 	 * The serialization of jobs queued to the VM_BIND queue is already
-	 * taken care of by drm_sched, but we need to serialize synchronous
+	 * taken care of by drm_dep, but we need to serialize synchronous
 	 * and asynchronous VM_BIND request. This is what this lock is for.
 	 */
 	struct mutex op_lock;
@@ -390,11 +380,8 @@ struct panthor_vm {
  * struct panthor_vm_bind_job - VM bind job
  */
 struct panthor_vm_bind_job {
-	/** @base: Inherit from drm_sched_job. */
-	struct drm_sched_job base;
-
-	/** @refcount: Reference count. */
-	struct kref refcount;
+	/** @base: Inherit from drm_dep_job. */
+	struct drm_dep_job base;
 
 	/** @cleanup_op_ctx_work: Work used to cleanup the VM operation context. */
 	struct work_struct cleanup_op_ctx_work;
@@ -821,12 +808,12 @@ u32 panthor_vm_page_size(struct panthor_vm *vm)
 
 static void panthor_vm_stop(struct panthor_vm *vm)
 {
-	drm_sched_stop(&vm->sched, NULL);
+	drm_dep_queue_stop(vm->q);
 }
 
 static void panthor_vm_start(struct panthor_vm *vm)
 {
-	drm_sched_start(&vm->sched, 0);
+	drm_dep_queue_start(vm->q);
 }
 
 /**
@@ -1882,17 +1869,17 @@ static void panthor_vm_free(struct drm_gpuvm *gpuvm)
 
 	mutex_lock(&ptdev->mmu->vm.lock);
 	list_del(&vm->node);
-	/* Restore the scheduler state so we can call drm_sched_entity_destroy()
-	 * and drm_sched_fini(). If get there, that means we have no job left
-	 * and no new jobs can be queued, so we can start the scheduler without
+	/* Restore the queue state so we can call drm_dep_queue_put().
+	 * If we get there, that means we have no job left
+	 * and no new jobs can be queued, so we can start the queue without
 	 * risking interfering with the reset.
 	 */
 	if (ptdev->mmu->vm.reset_in_progress)
 		panthor_vm_start(vm);
 	mutex_unlock(&ptdev->mmu->vm.lock);
 
-	drm_sched_entity_destroy(&vm->entity);
-	drm_sched_fini(&vm->sched);
+	drm_dep_queue_kill(vm->q);
+	drm_dep_queue_put(vm->q);
 
 	mutex_lock(&vm->op_lock);
 	mutex_lock(&ptdev->mmu->as.slots_lock);
@@ -2319,14 +2306,14 @@ panthor_vm_exec_op(struct panthor_vm *vm, struct panthor_vm_op_ctx *op,
 }
 
 static struct dma_fence *
-panthor_vm_bind_run_job(struct drm_sched_job *sched_job)
+panthor_vm_bind_run_job(struct drm_dep_job *dep_job)
 {
-	struct panthor_vm_bind_job *job = container_of(sched_job, struct panthor_vm_bind_job, base);
+	struct panthor_vm_bind_job *job = container_of(dep_job, struct panthor_vm_bind_job, base);
 	bool cookie;
 	int ret;
 
 	/* Not only we report an error whose result is propagated to the
-	 * drm_sched finished fence, but we also flag the VM as unusable, because
+	 * drm_dep finished fence, but we also flag the VM as unusable, because
 	 * a failure in the async VM_BIND results in an inconsistent state. VM needs
 	 * to be destroyed and recreated.
 	 */
@@ -2337,38 +2324,24 @@ panthor_vm_bind_run_job(struct drm_sched_job *sched_job)
 	return ret ? ERR_PTR(ret) : NULL;
 }
 
-static void panthor_vm_bind_job_release(struct kref *kref)
+static void panthor_vm_bind_job_cleanup(struct panthor_vm_bind_job *job)
 {
-	struct panthor_vm_bind_job *job = container_of(kref, struct panthor_vm_bind_job, refcount);
-
-	if (job->base.s_fence)
-		drm_sched_job_cleanup(&job->base);
-
 	panthor_vm_cleanup_op_ctx(&job->ctx, job->vm);
 	panthor_vm_put(job->vm);
 	kfree(job);
 }
 
-/**
- * panthor_vm_bind_job_put() - Release a VM_BIND job reference
- * @sched_job: Job to release the reference on.
- */
-void panthor_vm_bind_job_put(struct drm_sched_job *sched_job)
+static void panthor_vm_bind_job_cleanup_op_ctx_work(struct work_struct *work)
 {
 	struct panthor_vm_bind_job *job =
-		container_of(sched_job, struct panthor_vm_bind_job, base);
+		container_of(work, struct panthor_vm_bind_job, cleanup_op_ctx_work);
 
-	if (sched_job)
-		kref_put(&job->refcount, panthor_vm_bind_job_release);
+	panthor_vm_bind_job_cleanup(job);
 }
 
-static void
-panthor_vm_bind_free_job(struct drm_sched_job *sched_job)
+static void panthor_vm_bind_job_release(struct drm_dep_job *dep_job)
 {
-	struct panthor_vm_bind_job *job =
-		container_of(sched_job, struct panthor_vm_bind_job, base);
-
-	drm_sched_job_cleanup(sched_job);
+	struct panthor_vm_bind_job *job = container_of(dep_job, struct panthor_vm_bind_job, base);
 
 	/* Do the heavy cleanups asynchronously, so we're out of the
 	 * dma-signaling path and can acquire dma-resv locks safely.
@@ -2376,16 +2349,29 @@ panthor_vm_bind_free_job(struct drm_sched_job *sched_job)
 	queue_work(panthor_cleanup_wq, &job->cleanup_op_ctx_work);
 }
 
-static enum drm_gpu_sched_stat
-panthor_vm_bind_timedout_job(struct drm_sched_job *sched_job)
+static const struct drm_dep_job_ops panthor_vm_bind_job_ops = {
+	.release = panthor_vm_bind_job_release,
+};
+
+/**
+ * panthor_vm_bind_job_put() - Release a VM_BIND job reference
+ * @dep_job: Job to release the reference on.
+ */
+void panthor_vm_bind_job_put(struct drm_dep_job *dep_job)
+{
+	if (dep_job)
+		drm_dep_job_put(dep_job);
+}
+
+static enum drm_dep_timedout_stat
+panthor_vm_bind_timedout_job(struct drm_dep_job *dep_job)
 {
 	WARN(1, "VM_BIND ops are synchronous for now, there should be no timeout!");
-	return DRM_GPU_SCHED_STAT_RESET;
+	return DRM_DEP_TIMEDOUT_STAT_JOB_SIGNALED;
 }
 
-static const struct drm_sched_backend_ops panthor_vm_bind_ops = {
+static const struct drm_dep_queue_ops panthor_vm_bind_ops = {
 	.run_job = panthor_vm_bind_run_job,
-	.free_job = panthor_vm_bind_free_job,
 	.timedout_job = panthor_vm_bind_timedout_job,
 };
 
@@ -2409,16 +2395,16 @@ panthor_vm_create(struct panthor_device *ptdev, bool for_mcu,
 	u32 pa_bits = GPU_MMU_FEATURES_PA_BITS(ptdev->gpu_info.mmu_features);
 	u64 full_va_range = 1ull << va_bits;
 	struct drm_gem_object *dummy_gem;
-	struct drm_gpu_scheduler *sched;
-	const struct drm_sched_init_args sched_args = {
+	const struct drm_dep_queue_init_args q_args = {
 		.ops = &panthor_vm_bind_ops,
 		.submit_wq = ptdev->mmu->vm.wq,
-		.num_rqs = 1,
 		.credit_limit = 1,
 		/* Bind operations are synchronous for now, no timeout needed. */
 		.timeout = MAX_SCHEDULE_TIMEOUT,
 		.name = "panthor-vm-bind",
-		.dev = ptdev->base.dev,
+		.drm = &ptdev->base,
+		.flags = DRM_DEP_QUEUE_FLAGS_JOB_PUT_IRQ_SAFE |
+			DRM_DEP_QUEUE_FLAGS_BYPASS_SUPPORTED,
 	};
 	struct io_pgtable_cfg pgtbl_cfg;
 	u64 mair, min_va, va_range;
@@ -2477,14 +2463,17 @@ panthor_vm_create(struct panthor_device *ptdev, bool for_mcu,
 		goto err_mm_takedown;
 	}
 
-	ret = drm_sched_init(&vm->sched, &sched_args);
-	if (ret)
+	vm->q = kzalloc_obj(*vm->q);
+	if (!vm->q) {
+		ret = -ENOMEM;
 		goto err_free_io_pgtable;
+	}
 
-	sched = &vm->sched;
-	ret = drm_sched_entity_init(&vm->entity, 0, &sched, 1, NULL);
-	if (ret)
-		goto err_sched_fini;
+	ret = drm_dep_queue_init(vm->q, &q_args);
+	if (ret) {
+		kfree(vm->q);
+		goto err_free_io_pgtable;
+	}
 
 	mair = io_pgtable_ops_to_pgtable(vm->pgtbl_ops)->cfg.arm_lpae_s1_cfg.mair;
 	vm->memattr = mair_to_memattr(mair, ptdev->coherent);
@@ -2492,7 +2481,7 @@ panthor_vm_create(struct panthor_device *ptdev, bool for_mcu,
 	mutex_lock(&ptdev->mmu->vm.lock);
 	list_add_tail(&vm->node, &ptdev->mmu->vm.list);
 
-	/* If a reset is in progress, stop the scheduler. */
+	/* If a reset is in progress, stop the queue. */
 	if (ptdev->mmu->vm.reset_in_progress)
 		panthor_vm_stop(vm);
 	mutex_unlock(&ptdev->mmu->vm.lock);
@@ -2507,9 +2496,6 @@ panthor_vm_create(struct panthor_device *ptdev, bool for_mcu,
 	drm_gem_object_put(dummy_gem);
 	return vm;
 
-err_sched_fini:
-	drm_sched_fini(&vm->sched);
-
 err_free_io_pgtable:
 	free_io_pgtable_ops(vm->pgtbl_ops);
 
@@ -2578,14 +2564,6 @@ panthor_vm_bind_prepare_op_ctx(struct drm_file *file,
 	}
 }
 
-static void panthor_vm_bind_job_cleanup_op_ctx_work(struct work_struct *work)
-{
-	struct panthor_vm_bind_job *job =
-		container_of(work, struct panthor_vm_bind_job, cleanup_op_ctx_work);
-
-	panthor_vm_bind_job_put(&job->base);
-}
-
 /**
  * panthor_vm_bind_job_create() - Create a VM_BIND job
  * @file: File.
@@ -2594,7 +2572,7 @@ static void panthor_vm_bind_job_cleanup_op_ctx_work(struct work_struct *work)
  *
  * Return: A valid pointer on success, an ERR_PTR() otherwise.
  */
-struct drm_sched_job *
+struct drm_dep_job *
 panthor_vm_bind_job_create(struct drm_file *file,
 			   struct panthor_vm *vm,
 			   const struct drm_panthor_vm_bind_op *op)
@@ -2619,17 +2597,21 @@ panthor_vm_bind_job_create(struct drm_file *file,
 	}
 
 	INIT_WORK(&job->cleanup_op_ctx_work, panthor_vm_bind_job_cleanup_op_ctx_work);
-	kref_init(&job->refcount);
 	job->vm = panthor_vm_get(vm);
 
-	ret = drm_sched_job_init(&job->base, &vm->entity, 1, vm, file->client_id);
+	ret = drm_dep_job_init(&job->base,
+			       &(struct drm_dep_job_init_args){
+					.ops = &panthor_vm_bind_job_ops,
+					.q = vm->q,
+					.credits = 1,
+			       });
 	if (ret)
-		goto err_put_job;
+		goto err_cleanup;
 
 	return &job->base;
 
-err_put_job:
-	panthor_vm_bind_job_put(&job->base);
+err_cleanup:
+	panthor_vm_bind_job_cleanup(job);
 	return ERR_PTR(ret);
 }
 
@@ -2645,9 +2627,9 @@ panthor_vm_bind_job_create(struct drm_file *file,
  * Return: 0 on success, a negative error code otherwise.
  */
 int panthor_vm_bind_job_prepare_resvs(struct drm_exec *exec,
-				      struct drm_sched_job *sched_job)
+				      struct drm_dep_job *dep_job)
 {
-	struct panthor_vm_bind_job *job = container_of(sched_job, struct panthor_vm_bind_job, base);
+	struct panthor_vm_bind_job *job = container_of(dep_job, struct panthor_vm_bind_job, base);
 	int ret;
 
 	/* Acquire the VM lock an reserve a slot for this VM bind job. */
@@ -2671,13 +2653,13 @@ int panthor_vm_bind_job_prepare_resvs(struct drm_exec *exec,
  * @sched_job: Job to update the resvs on.
  */
 void panthor_vm_bind_job_update_resvs(struct drm_exec *exec,
-				      struct drm_sched_job *sched_job)
+				      struct drm_dep_job *dep_job)
 {
-	struct panthor_vm_bind_job *job = container_of(sched_job, struct panthor_vm_bind_job, base);
+	struct panthor_vm_bind_job *job = container_of(dep_job, struct panthor_vm_bind_job, base);
 
 	/* Explicit sync => we just register our job finished fence as bookkeep. */
 	drm_gpuvm_resv_add_fence(&job->vm->base, exec,
-				 &sched_job->s_fence->finished,
+				 drm_dep_job_finished_fence(dep_job),
 				 DMA_RESV_USAGE_BOOKKEEP,
 				 DMA_RESV_USAGE_BOOKKEEP);
 }
@@ -2873,7 +2855,9 @@ int panthor_mmu_init(struct panthor_device *ptdev)
 	if (ret)
 		return ret;
 
-	mmu->vm.wq = alloc_workqueue("panthor-vm-bind", WQ_UNBOUND, 0);
+	mmu->vm.wq = alloc_workqueue("panthor-vm-bind", WQ_MEM_RECLAIM |
+				     WQ_MEM_WARN_ON_RECLAIM |
+				     WQ_UNBOUND, 0);
 	if (!mmu->vm.wq)
 		return -ENOMEM;
 
diff --git a/drivers/gpu/drm/panthor/panthor_mmu.h b/drivers/gpu/drm/panthor/panthor_mmu.h
index 0e268fdfdb2f..845f45ce7739 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.h
+++ b/drivers/gpu/drm/panthor/panthor_mmu.h
@@ -8,7 +8,7 @@
 #include <linux/dma-resv.h>
 
 struct drm_exec;
-struct drm_sched_job;
+struct drm_dep_job;
 struct drm_memory_stats;
 struct panthor_gem_object;
 struct panthor_heap_pool;
@@ -50,9 +50,9 @@ int panthor_vm_prepare_mapped_bos_resvs(struct drm_exec *exec,
 					struct panthor_vm *vm,
 					u32 slot_count);
 int panthor_vm_add_bos_resvs_deps_to_job(struct panthor_vm *vm,
-					 struct drm_sched_job *job);
+					 struct drm_dep_job *job);
 void panthor_vm_add_job_fence_to_bos_resvs(struct panthor_vm *vm,
-					   struct drm_sched_job *job);
+					   struct drm_dep_job *job);
 
 struct dma_resv *panthor_vm_resv(struct panthor_vm *vm);
 struct drm_gem_object *panthor_vm_root_gem(struct panthor_vm *vm);
@@ -82,14 +82,14 @@ int panthor_vm_bind_exec_sync_op(struct drm_file *file,
 				 struct panthor_vm *vm,
 				 struct drm_panthor_vm_bind_op *op);
 
-struct drm_sched_job *
+struct drm_dep_job *
 panthor_vm_bind_job_create(struct drm_file *file,
 			   struct panthor_vm *vm,
 			   const struct drm_panthor_vm_bind_op *op);
-void panthor_vm_bind_job_put(struct drm_sched_job *job);
+void panthor_vm_bind_job_put(struct drm_dep_job *job);
 int panthor_vm_bind_job_prepare_resvs(struct drm_exec *exec,
-				      struct drm_sched_job *job);
-void panthor_vm_bind_job_update_resvs(struct drm_exec *exec, struct drm_sched_job *job);
+				      struct drm_dep_job *job);
+void panthor_vm_bind_job_update_resvs(struct drm_exec *exec, struct drm_dep_job *job);
 
 void panthor_vm_update_resvs(struct panthor_vm *vm, struct drm_exec *exec,
 			     struct dma_fence *fence,
diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 2fe04d0f0e3a..040bea0688c3 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -6,7 +6,7 @@
 #include <drm/drm_gem_shmem_helper.h>
 #include <drm/drm_managed.h>
 #include <drm/drm_print.h>
-#include <drm/gpu_scheduler.h>
+#include <drm/drm_dep.h>
 #include <drm/panthor_drm.h>
 
 #include <linux/build_bug.h>
@@ -61,13 +61,11 @@
  * always gets consistent results (cache maintenance,
  * synchronization, ...).
  *
- * We rely on the drm_gpu_scheduler framework to deal with job
- * dependencies and submission. As any other driver dealing with a
- * FW-scheduler, we use the 1:1 entity:scheduler mode, such that each
- * entity has its own job scheduler. When a job is ready to be executed
- * (all its dependencies are met), it is pushed to the appropriate
- * queue ring-buffer, and the group is scheduled for execution if it
- * wasn't already active.
+ * We rely on the drm_dep framework to deal with job
+ * dependencies and submission. Each queue owns its own dep queue. When a job
+ * is ready to be executed (all its dependencies are met), it is pushed to the
+ * appropriate queue ring-buffer, and the group is scheduled for execution if
+ * it wasn't already active.
  *
  * Kernel-side group scheduling is timeslice-based. When we have less
  * groups than there are slots, the periodic tick is disabled and we
@@ -83,7 +81,7 @@
  * if userspace was in charge of the ring-buffer. That's also one of the
  * reason we don't do 'cooperative' scheduling (encoding FW group slot
  * reservation as dma_fence that would be returned from the
- * drm_gpu_scheduler::prepare_job() hook, and treating group rotation as
+ * drm_dep_queue_ops::prepare_job() hook, and treating group rotation as
  * a queue of waiters, ordered by job submission order). This approach
  * would work for kernel-mode queues, but would make user-mode queues a
  * lot more complicated to retrofit.
@@ -147,11 +145,11 @@ struct panthor_scheduler {
 
 	/**
 	 * @wq: Workqueue used by our internal scheduler logic and
-	 * drm_gpu_scheduler.
+	 * drm_dep queues.
 	 *
 	 * Used for the scheduler tick, group update or other kind of FW
 	 * event processing that can't be handled in the threaded interrupt
-	 * path. Also passed to the drm_gpu_scheduler instances embedded
+	 * path. Also passed to the drm_dep_queue instances embedded
 	 * in panthor_queue.
 	 */
 	struct workqueue_struct *wq;
@@ -347,13 +345,10 @@ struct panthor_syncobj_64b {
  * struct panthor_queue - Execution queue
  */
 struct panthor_queue {
-	/** @scheduler: DRM scheduler used for this queue. */
-	struct drm_gpu_scheduler scheduler;
+	/** @q: drm_dep queue used for this queue. */
+	struct drm_dep_queue q;
 
-	/** @entity: DRM scheduling entity used for this queue. */
-	struct drm_sched_entity entity;
-
-	/** @name: DRM scheduler name for this queue. */
+	/** @name: dep queue name for this queue. */
 	char *name;
 
 	/** @timeout: Queue timeout related fields. */
@@ -461,7 +456,7 @@ struct panthor_queue {
 		 *
 		 * We return this fence when we get an empty command stream.
 		 * This way, we are guaranteed that all earlier jobs have completed
-		 * when drm_sched_job::s_fence::finished without having to feed
+		 * when the drm_dep finished fence is signaled without having to feed
 		 * the CS ring buffer with a dummy job that only signals the fence.
 		 */
 		struct dma_fence *last_fence;
@@ -599,7 +594,7 @@ struct panthor_group {
 	 * @timedout: True when a timeout occurred on any of the queues owned by
 	 * this group.
 	 *
-	 * Timeouts can be reported by drm_sched or by the FW. If a reset is required,
+	 * Timeouts can be reported by drm_dep or by the FW. If a reset is required,
 	 * and the group can't be suspended, this also leads to a timeout. In any case,
 	 * any timeout situation is unrecoverable, and the group becomes useless. We
 	 * simply wait for all references to be dropped so we can release the group
@@ -791,11 +786,8 @@ struct panthor_group_pool {
  * struct panthor_job - Used to manage GPU job
  */
 struct panthor_job {
-	/** @base: Inherit from drm_sched_job. */
-	struct drm_sched_job base;
-
-	/** @refcount: Reference count. */
-	struct kref refcount;
+	/** @base: Inherit from drm_dep_job. */
+	struct drm_dep_job base;
 
 	/** @group: Group of the queue this job will be pushed to. */
 	struct panthor_group *group;
@@ -915,27 +907,8 @@ static void group_free_queue(struct panthor_group *group, struct panthor_queue *
 	if (IS_ERR_OR_NULL(queue))
 		return;
 
-	/* Disable the timeout before tearing down drm_sched components. */
-	disable_delayed_work_sync(&queue->timeout.work);
-
-	if (queue->entity.fence_context)
-		drm_sched_entity_destroy(&queue->entity);
-
-	if (queue->scheduler.ops)
-		drm_sched_fini(&queue->scheduler);
-
-	kfree(queue->name);
-
-	panthor_queue_put_syncwait_obj(queue);
-
-	panthor_kernel_bo_destroy(queue->ringbuf);
-	panthor_kernel_bo_destroy(queue->iface.mem);
-	panthor_kernel_bo_destroy(queue->profiling.slots);
-
-	/* Release the last_fence we were holding, if any. */
-	dma_fence_put(queue->fence_ctx.last_fence);
-
-	kfree(queue);
+	if (queue->q.ops)
+		drm_dep_queue_put(&queue->q);
 }
 
 static void group_release_work(struct work_struct *work)
@@ -1098,7 +1071,7 @@ queue_reset_timeout_locked(struct panthor_queue *queue)
 	lockdep_assert_held(&queue->fence_ctx.lock);
 
 	if (!queue_timeout_is_suspended(queue)) {
-		mod_delayed_work(queue->scheduler.timeout_wq,
+		mod_delayed_work(drm_dep_queue_timeout_wq(&queue->q),
 				 &queue->timeout.work,
 				 msecs_to_jiffies(JOB_TIMEOUT_MS));
 	}
@@ -1162,7 +1135,7 @@ queue_resume_timeout(struct panthor_queue *queue)
 	spin_lock(&queue->fence_ctx.lock);
 
 	if (queue_timeout_is_suspended(queue)) {
-		mod_delayed_work(queue->scheduler.timeout_wq,
+		mod_delayed_work(drm_dep_queue_timeout_wq(&queue->q),
 				 &queue->timeout.work,
 				 queue->timeout.remaining);
 
@@ -2726,19 +2699,13 @@ static void queue_stop(struct panthor_queue *queue,
 		       struct panthor_job *bad_job)
 {
 	disable_delayed_work_sync(&queue->timeout.work);
-	drm_sched_stop(&queue->scheduler, bad_job ? &bad_job->base : NULL);
+	drm_dep_queue_stop(&queue->q);
 }
 
 static void queue_start(struct panthor_queue *queue)
 {
-	struct panthor_job *job;
-
-	/* Re-assign the parent fences. */
-	list_for_each_entry(job, &queue->scheduler.pending_list, base.list)
-		job->base.s_fence->parent = dma_fence_get(job->done_fence);
-
 	enable_delayed_work(&queue->timeout.work);
-	drm_sched_start(&queue->scheduler, 0);
+	drm_dep_queue_start(&queue->q);
 }
 
 static void panthor_group_stop(struct panthor_group *group)
@@ -3293,9 +3260,9 @@ static u32 calc_job_credits(u32 profile_mask)
 }
 
 static struct dma_fence *
-queue_run_job(struct drm_sched_job *sched_job)
+queue_run_job(struct drm_dep_job *dep_job)
 {
-	struct panthor_job *job = container_of(sched_job, struct panthor_job, base);
+	struct panthor_job *job = container_of(dep_job, struct panthor_job, base);
 	struct panthor_group *group = job->group;
 	struct panthor_queue *queue = group->queues[job->queue_idx];
 	struct panthor_device *ptdev = group->ptdev;
@@ -3306,8 +3273,7 @@ queue_run_job(struct drm_sched_job *sched_job)
 	int ret;
 
 	/* Stream size is zero, nothing to do except making sure all previously
-	 * submitted jobs are done before we signal the
-	 * drm_sched_job::s_fence::finished fence.
+	 * submitted jobs are done before we signal the drm_dep finished fence.
 	 */
 	if (!job->call_info.size) {
 		job->done_fence = dma_fence_get(queue->fence_ctx.last_fence);
@@ -3394,10 +3360,10 @@ queue_run_job(struct drm_sched_job *sched_job)
 	return done_fence;
 }
 
-static enum drm_gpu_sched_stat
-queue_timedout_job(struct drm_sched_job *sched_job)
+static enum drm_dep_timedout_stat
+queue_timedout_job(struct drm_dep_job *dep_job)
 {
-	struct panthor_job *job = container_of(sched_job, struct panthor_job, base);
+	struct panthor_job *job = container_of(dep_job, struct panthor_job, base);
 	struct panthor_group *group = job->group;
 	struct panthor_device *ptdev = group->ptdev;
 	struct panthor_scheduler *sched = ptdev->scheduler;
@@ -3411,34 +3377,58 @@ queue_timedout_job(struct drm_sched_job *sched_job)
 	queue_stop(queue, job);
 
 	mutex_lock(&sched->lock);
-	group->timedout = true;
-	if (group->csg_id >= 0) {
-		sched_queue_delayed_work(ptdev->scheduler, tick, 0);
-	} else {
-		/* Remove from the run queues, so the scheduler can't
-		 * pick the group on the next tick.
-		 */
-		list_del_init(&group->run_node);
-		list_del_init(&group->wait_node);
+	if (!group->timedout) {
+		group->timedout = true;
+		if (group->csg_id >= 0) {
+			sched_queue_delayed_work(ptdev->scheduler, tick, 0);
+		} else {
+			/* Remove from the run queues, so the scheduler can't
+			 * pick the group on the next tick.
+			 */
+			list_del_init(&group->run_node);
+			list_del_init(&group->wait_node);
 
-		group_queue_work(group, term);
+			group_queue_work(group, term);
+		}
 	}
 	mutex_unlock(&sched->lock);
 
 	queue_start(queue);
-	return DRM_GPU_SCHED_STAT_RESET;
+	if (drm_dep_job_is_finished(dep_job))
+		return DRM_DEP_TIMEDOUT_STAT_JOB_SIGNALED;
+	else
+		return DRM_DEP_TIMEDOUT_STAT_REQUEUE_JOB;
 }
 
-static void queue_free_job(struct drm_sched_job *sched_job)
+static void job_release(struct drm_dep_job *dep_job);
+
+static const struct drm_dep_job_ops panthor_job_ops = {
+	.release = job_release,
+};
+
+static void panthor_queue_release(struct drm_dep_queue *q)
 {
-	drm_sched_job_cleanup(sched_job);
-	panthor_job_put(sched_job);
+	struct panthor_queue *queue = container_of(q, typeof(*queue), q);
+
+	kfree(queue->name);
+
+	panthor_queue_put_syncwait_obj(queue);
+
+	panthor_kernel_bo_destroy(queue->ringbuf);
+	panthor_kernel_bo_destroy(queue->iface.mem);
+	panthor_kernel_bo_destroy(queue->profiling.slots);
+
+	/* Release the last_fence we were holding, if any. */
+	dma_fence_put(queue->fence_ctx.last_fence);
+
+	drm_dep_queue_release(q);
+	kfree_rcu(queue, q.rcu);
 }
 
-static const struct drm_sched_backend_ops panthor_queue_sched_ops = {
+static const struct drm_dep_queue_ops panthor_queue_ops = {
 	.run_job = queue_run_job,
 	.timedout_job = queue_timedout_job,
-	.free_job = queue_free_job,
+	.release = panthor_queue_release,
 };
 
 static u32 calc_profiling_ringbuf_num_slots(struct panthor_device *ptdev,
@@ -3476,7 +3466,7 @@ static void queue_timeout_work(struct work_struct *work)
 
 	progress = queue_check_job_completion(queue);
 	if (!progress)
-		drm_sched_fault(&queue->scheduler);
+		drm_dep_queue_trigger_timeout(&queue->q);
 }
 
 static struct panthor_queue *
@@ -3484,10 +3474,9 @@ group_create_queue(struct panthor_group *group,
 		   const struct drm_panthor_queue_create *args,
 		   u64 drm_client_id, u32 gid, u32 qid)
 {
-	struct drm_sched_init_args sched_args = {
-		.ops = &panthor_queue_sched_ops,
+	struct drm_dep_queue_init_args q_args = {
+		.ops = &panthor_queue_ops,
 		.submit_wq = group->ptdev->scheduler->wq,
-		.num_rqs = 1,
 		/*
 		 * The credit limit argument tells us the total number of
 		 * instructions across all CS slots in the ringbuffer, with
@@ -3497,9 +3486,10 @@ group_create_queue(struct panthor_group *group,
 		.credit_limit = args->ringbuf_size / sizeof(u64),
 		.timeout = MAX_SCHEDULE_TIMEOUT,
 		.timeout_wq = group->ptdev->reset.wq,
-		.dev = group->ptdev->base.dev,
+		.drm = &group->ptdev->base,
+		.flags = DRM_DEP_QUEUE_FLAGS_JOB_PUT_IRQ_SAFE |
+			DRM_DEP_QUEUE_FLAGS_BYPASS_SUPPORTED,
 	};
-	struct drm_gpu_scheduler *drm_sched;
 	struct panthor_queue *queue;
 	int ret;
 
@@ -3580,14 +3570,9 @@ group_create_queue(struct panthor_group *group,
 		goto err_free_queue;
 	}
 
-	sched_args.name = queue->name;
-
-	ret = drm_sched_init(&queue->scheduler, &sched_args);
-	if (ret)
-		goto err_free_queue;
+	q_args.name = queue->name;
 
-	drm_sched = &queue->scheduler;
-	ret = drm_sched_entity_init(&queue->entity, 0, &drm_sched, 1, NULL);
+	ret = drm_dep_queue_init(&queue->q, &q_args);
 	if (ret)
 		goto err_free_queue;
 
@@ -3907,15 +3892,8 @@ panthor_fdinfo_gather_group_mem_info(struct panthor_file *pfile,
 	xa_unlock(&gpool->xa);
 }
 
-static void job_release(struct kref *ref)
+static void job_cleanup(struct panthor_job *job)
 {
-	struct panthor_job *job = container_of(ref, struct panthor_job, refcount);
-
-	drm_WARN_ON(&job->group->ptdev->base, !list_empty(&job->node));
-
-	if (job->base.s_fence)
-		drm_sched_job_cleanup(&job->base);
-
 	if (dma_fence_was_initialized(job->done_fence))
 		dma_fence_put(job->done_fence);
 	else
@@ -3926,33 +3904,36 @@ static void job_release(struct kref *ref)
 	kfree(job);
 }
 
-struct drm_sched_job *panthor_job_get(struct drm_sched_job *sched_job)
+static void job_release(struct drm_dep_job *dep_job)
 {
-	if (sched_job) {
-		struct panthor_job *job = container_of(sched_job, struct panthor_job, base);
-
-		kref_get(&job->refcount);
-	}
+	struct panthor_job *job = container_of(dep_job, struct panthor_job, base);
 
-	return sched_job;
+	drm_WARN_ON(&job->group->ptdev->base, !list_empty(&job->node));
+	job_cleanup(job);
 }
 
-void panthor_job_put(struct drm_sched_job *sched_job)
+struct drm_dep_job *panthor_job_get(struct drm_dep_job *dep_job)
 {
-	struct panthor_job *job = container_of(sched_job, struct panthor_job, base);
+	if (dep_job)
+		drm_dep_job_get(dep_job);
+
+	return dep_job;
+}
 
-	if (sched_job)
-		kref_put(&job->refcount, job_release);
+void panthor_job_put(struct drm_dep_job *dep_job)
+{
+	if (dep_job)
+		drm_dep_job_put(dep_job);
 }
 
-struct panthor_vm *panthor_job_vm(struct drm_sched_job *sched_job)
+struct panthor_vm *panthor_job_vm(struct drm_dep_job *dep_job)
 {
-	struct panthor_job *job = container_of(sched_job, struct panthor_job, base);
+	struct panthor_job *job = container_of(dep_job, struct panthor_job, base);
 
 	return job->group->vm;
 }
 
-struct drm_sched_job *
+struct drm_dep_job *
 panthor_job_create(struct panthor_file *pfile,
 		   u16 group_handle,
 		   const struct drm_panthor_queue_submit *qsubmit,
@@ -3984,7 +3965,6 @@ panthor_job_create(struct panthor_file *pfile,
 	if (!job)
 		return ERR_PTR(-ENOMEM);
 
-	kref_init(&job->refcount);
 	job->queue_idx = qsubmit->queue_index;
 	job->call_info.size = qsubmit->stream_size;
 	job->call_info.start = qsubmit->stream_addr;
@@ -3994,18 +3974,18 @@ panthor_job_create(struct panthor_file *pfile,
 	job->group = group_from_handle(gpool, group_handle);
 	if (!job->group) {
 		ret = -EINVAL;
-		goto err_put_job;
+		goto err_cleanup_job;
 	}
 
 	if (!group_can_run(job->group)) {
 		ret = -EINVAL;
-		goto err_put_job;
+		goto err_cleanup_job;
 	}
 
 	if (job->queue_idx >= job->group->queue_count ||
 	    !job->group->queues[job->queue_idx]) {
 		ret = -EINVAL;
-		goto err_put_job;
+		goto err_cleanup_job;
 	}
 
 	/* Empty command streams don't need a fence, they'll pick the one from
@@ -4015,7 +3995,7 @@ panthor_job_create(struct panthor_file *pfile,
 		job->done_fence = kzalloc_obj(*job->done_fence);
 		if (!job->done_fence) {
 			ret = -ENOMEM;
-			goto err_put_job;
+			goto err_cleanup_job;
 		}
 	}
 
@@ -4023,27 +4003,30 @@ panthor_job_create(struct panthor_file *pfile,
 	credits = calc_job_credits(job->profiling.mask);
 	if (credits == 0) {
 		ret = -EINVAL;
-		goto err_put_job;
+		goto err_cleanup_job;
 	}
 
-	ret = drm_sched_job_init(&job->base,
-				 &job->group->queues[job->queue_idx]->entity,
-				 credits, job->group, drm_client_id);
+	ret = drm_dep_job_init(&job->base,
+			       &(struct drm_dep_job_init_args){
+					.ops = &panthor_job_ops,
+					.q = &job->group->queues[job->queue_idx]->q,
+					.credits = credits,
+			       });
 	if (ret)
-		goto err_put_job;
+		goto err_cleanup_job;
 
 	return &job->base;
 
-err_put_job:
-	panthor_job_put(&job->base);
+err_cleanup_job:
+	job_cleanup(job);
 	return ERR_PTR(ret);
 }
 
-void panthor_job_update_resvs(struct drm_exec *exec, struct drm_sched_job *sched_job)
+void panthor_job_update_resvs(struct drm_exec *exec, struct drm_dep_job *dep_job)
 {
-	struct panthor_job *job = container_of(sched_job, struct panthor_job, base);
+	struct panthor_job *job = container_of(dep_job, struct panthor_job, base);
 
-	panthor_vm_update_resvs(job->group->vm, exec, &sched_job->s_fence->finished,
+	panthor_vm_update_resvs(job->group->vm, exec, drm_dep_job_finished_fence(dep_job),
 				DMA_RESV_USAGE_BOOKKEEP, DMA_RESV_USAGE_BOOKKEEP);
 }
 
@@ -4171,7 +4154,8 @@ int panthor_sched_init(struct panthor_device *ptdev)
 	 * system is running out of memory.
 	 */
 	sched->heap_alloc_wq = alloc_workqueue("panthor-heap-alloc", WQ_UNBOUND, 0);
-	sched->wq = alloc_workqueue("panthor-csf-sched", WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
+	sched->wq = alloc_workqueue("panthor-csf-sched", WQ_MEM_RECLAIM |
+				    WQ_MEM_WARN_ON_RECLAIM | WQ_UNBOUND, 0);
 	if (!sched->wq || !sched->heap_alloc_wq) {
 		panthor_sched_fini(&ptdev->base, sched);
 		drm_err(&ptdev->base, "Failed to allocate the workqueues");
diff --git a/drivers/gpu/drm/panthor/panthor_sched.h b/drivers/gpu/drm/panthor/panthor_sched.h
index 9a8692de8ade..a7b8e2851f4b 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.h
+++ b/drivers/gpu/drm/panthor/panthor_sched.h
@@ -8,7 +8,7 @@ struct drm_exec;
 struct dma_fence;
 struct drm_file;
 struct drm_gem_object;
-struct drm_sched_job;
+struct drm_dep_job;
 struct drm_memory_stats;
 struct drm_panthor_group_create;
 struct drm_panthor_queue_create;
@@ -27,15 +27,15 @@ int panthor_group_destroy(struct panthor_file *pfile, u32 group_handle);
 int panthor_group_get_state(struct panthor_file *pfile,
 			    struct drm_panthor_group_get_state *get_state);
 
-struct drm_sched_job *
+struct drm_dep_job *
 panthor_job_create(struct panthor_file *pfile,
 		   u16 group_handle,
 		   const struct drm_panthor_queue_submit *qsubmit,
 		   u64 drm_client_id);
-struct drm_sched_job *panthor_job_get(struct drm_sched_job *job);
-struct panthor_vm *panthor_job_vm(struct drm_sched_job *sched_job);
-void panthor_job_put(struct drm_sched_job *job);
-void panthor_job_update_resvs(struct drm_exec *exec, struct drm_sched_job *job);
+struct drm_dep_job *panthor_job_get(struct drm_dep_job *job);
+struct panthor_vm *panthor_job_vm(struct drm_dep_job *dep_job);
+void panthor_job_put(struct drm_dep_job *job);
+void panthor_job_update_resvs(struct drm_exec *exec, struct drm_dep_job *job);
 
 int panthor_group_pool_create(struct panthor_file *pfile);
 void panthor_group_pool_destroy(struct panthor_file *pfile);
-- 
2.34.1

