Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB71EFCBC3
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 04:33:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D9BC10E2E1;
	Mon, 16 Mar 2026 04:33:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="RHKV67+Z";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31F4F10E2C7;
 Mon, 16 Mar 2026 04:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773635584; x=1805171584;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yck4WS97DtCVbzlzRyRratepZr/Vsa02lxfFaf6W7wA=;
 b=RHKV67+Z9exKzMItxvOno3t0qSEhVLW3Qwc9pI2mAT0gAWylhOh3P0Iv
 PlxpcD5B1BEi598zIVl1XVmQHdD3bxAiAZ161yolcfBDX5XuE1Nnl/2U1
 xi8rf7i6zbYir9/cnABvYG+hdtiBtRQi8YwEtxJVuSTqr4pTce1gTLh1h
 ABdYIagaxgrMBeMMvjniIsIkAi1H0P8wQqPp6LVj9hlLxN9lCgONyK7kX
 da4T7PKm/S2XPMH7A9XYSWKMpcE8qXlTKc0DiD69TwZLulih4y+r5XqNk
 Wk4PmLPoL1Z2kPSjS5GRykWlrdcRTBWl7Na93VyVR3AuI6z8X1Cj2ubTU A==;
X-CSE-ConnectionGUID: 4VGk6+w0QwCUDBs8s/XCtA==
X-CSE-MsgGUID: zIhK1enPTdmSHmhZVufrmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="74683509"
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; d="scan'208";a="74683509"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2026 21:33:03 -0700
X-CSE-ConnectionGUID: giYYxL5XQAy3kjU+koxIiA==
X-CSE-MsgGUID: Htx4J2UxSBOEsXdSALzPQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; d="scan'208";a="221022169"
Received: from lstrano-desk.jf.intel.com ([10.54.39.91])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2026 21:33:03 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Subject: [RFC PATCH 06/12] drm/xe: Convert to DRM dep queue scheduler layer
Date: Sun, 15 Mar 2026 21:32:49 -0700
Message-Id: <20260316043255.226352-7-matthew.brost@intel.com>
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

Replace the drm_gpu_scheduler/drm_sched_entity pair used throughout Xe
with the new drm_dep layer (struct drm_dep_queue / struct drm_dep_job).

The conversion spans three submission backends — GuC, execlist, and the
generic dependency scheduler (xe_dep_scheduler) — as well as the job
lifecycle, TDR callbacks, and device teardown sequencing.

xe_gpu_scheduler: struct drm_gpu_scheduler base replaced with struct
drm_dep_queue.  xe_sched_init() updated to drm_dep_queue_init() args.
The xe_sched_entity alias now maps to drm_dep_queue (the N:1
entity-to-scheduler distinction disappears entirely since each queue
is its own entity).  drm_sched_for_each_pending_job replaced with
drm_dep_queue_for_each_pending_job.  drm_sched_tdr_queue_imm replaced
with drm_dep_queue_trigger_timeout.

GuC backend: guc_exec_queue_free_job() removed; job lifetime is now
managed by drm_dep_job refcounting rather than a free_job vfunc.
guc_exec_queue_timedout_job() updated to return drm_dep_timedout_stat
values; the already-signaled check is replaced with
drm_dep_job_is_finished(); vf_recovery paths now return
DRM_DEP_TIMEDOUT_STAT_REQUEUE_JOB. guc_dep_queue_release() added as
the .release vfunc performing kfree_rcu on the embedded
xe_guc_exec_queue.

xe_dep_scheduler: struct drm_gpu_scheduler + struct drm_sched_entity +
struct rcu_head collapsed into a single struct drm_dep_queue (which
carries its own rcu_head).  drm_sched_entity_init/fini removed.
xe_dep_scheduler_fini() simplified to drm_dep_queue_put().
xe_dep_scheduler_entity() renamed to xe_dep_scheduler_dep_q() to match
the new naming.

GuC teardown sequencing: the previous wait_event_timeout-based drain is
replaced by the drm_dep module's built-in unload protection. Each
drm_dep_queue holds a drm_dev_get() reference on its owning
struct drm_device; drm_dev_put() is called as the final step of queue
teardown. This ensures the driver module cannot be unloaded while any
queue is still alive without requiring a separate drain API or per-device
hash table. guc_submit_fini() is simplified accordingly.

xe_sched_job: to_xe_sched_job() and drm_job accessors updated for
struct drm_dep_job.  Job dependency calls updated throughout
(drm_dep_job_add_dependency, drm_dep_job_arm, drm_dep_job_push).

exec_queue: q->entity renamed to q->dep_q throughout.

Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Assisted-by: GitHub Copilot:claude-sonnet-4.6

Me: WIP
---
 drivers/gpu/drm/xe/Kconfig                   |   2 +-
 drivers/gpu/drm/xe/xe_dep_job_types.h        |   8 +-
 drivers/gpu/drm/xe/xe_dep_scheduler.c        |  81 ++++----
 drivers/gpu/drm/xe/xe_dep_scheduler.h        |   7 +-
 drivers/gpu/drm/xe/xe_exec_queue_types.h     |   6 +-
 drivers/gpu/drm/xe/xe_execlist.c             |  43 ++---
 drivers/gpu/drm/xe/xe_execlist_types.h       |   4 +-
 drivers/gpu/drm/xe/xe_gpu_scheduler.c        |  38 ++--
 drivers/gpu/drm/xe/xe_gpu_scheduler.h        |  50 ++---
 drivers/gpu/drm/xe/xe_gpu_scheduler_types.h  |   9 +-
 drivers/gpu/drm/xe/xe_guc_exec_queue_types.h |   8 +-
 drivers/gpu/drm/xe/xe_guc_submit.c           | 184 ++++++++-----------
 drivers/gpu/drm/xe/xe_migrate.c              |   2 +-
 drivers/gpu/drm/xe/xe_pt.c                   |   2 +-
 drivers/gpu/drm/xe/xe_sched_job.c            |  52 +++---
 drivers/gpu/drm/xe/xe_sched_job.h            |   7 +-
 drivers/gpu/drm/xe/xe_sched_job_types.h      |   8 +-
 drivers/gpu/drm/xe/xe_sync.c                 |   2 +-
 drivers/gpu/drm/xe/xe_tlb_inval_job.c        |  86 ++++-----
 19 files changed, 255 insertions(+), 344 deletions(-)

diff --git a/drivers/gpu/drm/xe/Kconfig b/drivers/gpu/drm/xe/Kconfig
index 4d7dcaff2b91..9430877d6294 100644
--- a/drivers/gpu/drm/xe/Kconfig
+++ b/drivers/gpu/drm/xe/Kconfig
@@ -41,7 +41,7 @@ config DRM_XE
 	select DRM_EXEC
 	select DRM_GPUSVM if !UML
 	select DRM_GPUVM
-	select DRM_SCHED
+	select DRM_DEP
 	select MMU_NOTIFIER
 	select WANT_DEV_COREDUMP
 	select AUXILIARY_BUS
diff --git a/drivers/gpu/drm/xe/xe_dep_job_types.h b/drivers/gpu/drm/xe/xe_dep_job_types.h
index c6a484f24c8c..891fe5cfcf89 100644
--- a/drivers/gpu/drm/xe/xe_dep_job_types.h
+++ b/drivers/gpu/drm/xe/xe_dep_job_types.h
@@ -6,7 +6,7 @@
 #ifndef _XE_DEP_JOB_TYPES_H_
 #define _XE_DEP_JOB_TYPES_H_
 
-#include <drm/gpu_scheduler.h>
+#include <drm/drm_dep.h>
 
 struct xe_dep_job;
 
@@ -14,14 +14,12 @@ struct xe_dep_job;
 struct xe_dep_job_ops {
 	/** @run_job: Run generic Xe dependency job */
 	struct dma_fence *(*run_job)(struct xe_dep_job *job);
-	/** @free_job: Free generic Xe dependency job */
-	void (*free_job)(struct xe_dep_job *job);
 };
 
 /** struct xe_dep_job - Generic dependency Xe job */
 struct xe_dep_job {
-	/** @drm: base DRM scheduler job */
-	struct drm_sched_job drm;
+	/** @drm: base DRM dependency job */
+	struct drm_dep_job drm;
 	/** @ops: dependency job operations */
 	const struct xe_dep_job_ops *ops;
 };
diff --git a/drivers/gpu/drm/xe/xe_dep_scheduler.c b/drivers/gpu/drm/xe/xe_dep_scheduler.c
index 51d99fee9aa5..d3fec14d7073 100644
--- a/drivers/gpu/drm/xe/xe_dep_scheduler.c
+++ b/drivers/gpu/drm/xe/xe_dep_scheduler.c
@@ -5,11 +5,12 @@
 
 #include <linux/slab.h>
 
-#include <drm/gpu_scheduler.h>
+#include <drm/drm_dep.h>
 
 #include "xe_dep_job_types.h"
 #include "xe_dep_scheduler.h"
-#include "xe_device_types.h"
+#include "xe_device.h"
+#include "xe_gt_types.h"
 
 /**
  * DOC: Xe Dependency Scheduler
@@ -27,15 +28,11 @@
 
 /** struct xe_dep_scheduler - Generic Xe dependency scheduler */
 struct xe_dep_scheduler {
-	/** @sched: DRM GPU scheduler */
-	struct drm_gpu_scheduler sched;
-	/** @entity: DRM scheduler entity  */
-	struct drm_sched_entity entity;
-	/** @rcu: For safe freeing of exported dma fences */
-	struct rcu_head rcu;
+	/** @queue: DRM dependency queue */
+	struct drm_dep_queue queue;
 };
 
-static struct dma_fence *xe_dep_scheduler_run_job(struct drm_sched_job *drm_job)
+static struct dma_fence *xe_dep_scheduler_run_job(struct drm_dep_job *drm_job)
 {
 	struct xe_dep_job *dep_job =
 		container_of(drm_job, typeof(*dep_job), drm);
@@ -43,17 +40,21 @@ static struct dma_fence *xe_dep_scheduler_run_job(struct drm_sched_job *drm_job)
 	return dep_job->ops->run_job(dep_job);
 }
 
-static void xe_dep_scheduler_free_job(struct drm_sched_job *drm_job)
+static void xe_dep_scheduler_release(struct drm_dep_queue *drm_q)
 {
-	struct xe_dep_job *dep_job =
-		container_of(drm_job, typeof(*dep_job), drm);
+	struct xe_dep_scheduler *dep_scheduler =
+		container_of(drm_q, typeof(*dep_scheduler), queue);
 
-	dep_job->ops->free_job(dep_job);
+	/*
+	 * RCU free due sched being exported via DRM scheduler fences
+	 * (timeline name).
+	 */
+	kfree_rcu(dep_scheduler, queue.rcu);
 }
 
-static const struct drm_sched_backend_ops sched_ops = {
+static const struct drm_dep_queue_ops sched_ops = {
 	.run_job = xe_dep_scheduler_run_job,
-	.free_job = xe_dep_scheduler_free_job,
+	.release = xe_dep_scheduler_release,
 };
 
 /**
@@ -74,37 +75,28 @@ xe_dep_scheduler_create(struct xe_device *xe,
 			const char *name, u32 job_limit)
 {
 	struct xe_dep_scheduler *dep_scheduler;
-	struct drm_gpu_scheduler *sched;
-	const struct drm_sched_init_args args = {
-		.ops = &sched_ops,
-		.submit_wq = submit_wq,
-		.num_rqs = 1,
-		.credit_limit = job_limit,
-		.timeout = MAX_SCHEDULE_TIMEOUT,
-		.name = name,
-		.dev = xe->drm.dev,
-	};
+	struct xe_gt *gt = xe_device_get_root_tile(xe)->primary_gt;
 	int err;
 
 	dep_scheduler = kzalloc_obj(*dep_scheduler);
 	if (!dep_scheduler)
 		return ERR_PTR(-ENOMEM);
 
-	err = drm_sched_init(&dep_scheduler->sched, &args);
+	err = drm_dep_queue_init(&dep_scheduler->queue,
+				 &(const struct drm_dep_queue_init_args){
+					 .ops = &sched_ops,
+					 .submit_wq = submit_wq,
+					 .timeout_wq = gt->ordered_wq,
+					 .credit_limit = job_limit,
+					 .timeout = MAX_SCHEDULE_TIMEOUT,
+					 .name = name,
+					 .drm = &xe->drm,
+				 });
 	if (err)
 		goto err_free;
 
-	sched = &dep_scheduler->sched;
-	err = drm_sched_entity_init(&dep_scheduler->entity, 0, &sched, 1, NULL);
-	if (err)
-		goto err_sched;
-
-	init_rcu_head(&dep_scheduler->rcu);
-
 	return dep_scheduler;
 
-err_sched:
-	drm_sched_fini(&dep_scheduler->sched);
 err_free:
 	kfree(dep_scheduler);
 
@@ -120,24 +112,17 @@ xe_dep_scheduler_create(struct xe_device *xe,
  */
 void xe_dep_scheduler_fini(struct xe_dep_scheduler *dep_scheduler)
 {
-	drm_sched_entity_fini(&dep_scheduler->entity);
-	drm_sched_fini(&dep_scheduler->sched);
-	/*
-	 * RCU free due sched being exported via DRM scheduler fences
-	 * (timeline name).
-	 */
-	kfree_rcu(dep_scheduler, rcu);
+	drm_dep_queue_put(&dep_scheduler->queue);
 }
 
 /**
- * xe_dep_scheduler_entity() - Retrieve a generic Xe dependency scheduler
- *                             DRM scheduler entity
+ * xe_dep_scheduler_dep_q() - Retrieve the dep queue for a generic Xe dependency scheduler
  * @dep_scheduler: Generic Xe dependency scheduler object
  *
- * Return: The generic Xe dependency scheduler's DRM scheduler entity
+ * Return: The &drm_dep_queue owned by @dep_scheduler.
  */
-struct drm_sched_entity *
-xe_dep_scheduler_entity(struct xe_dep_scheduler *dep_scheduler)
+struct drm_dep_queue *
+xe_dep_scheduler_dep_q(struct xe_dep_scheduler *dep_scheduler)
 {
-	return &dep_scheduler->entity;
+	return &dep_scheduler->queue;
 }
diff --git a/drivers/gpu/drm/xe/xe_dep_scheduler.h b/drivers/gpu/drm/xe/xe_dep_scheduler.h
index 853961eec64b..c32b6f4f8c04 100644
--- a/drivers/gpu/drm/xe/xe_dep_scheduler.h
+++ b/drivers/gpu/drm/xe/xe_dep_scheduler.h
@@ -5,8 +5,9 @@
 
 #include <linux/types.h>
 
-struct drm_sched_entity;
+struct drm_dep_queue;
 struct workqueue_struct;
+struct xe_dep_job;
 struct xe_dep_scheduler;
 struct xe_device;
 
@@ -17,5 +18,5 @@ xe_dep_scheduler_create(struct xe_device *xe,
 
 void xe_dep_scheduler_fini(struct xe_dep_scheduler *dep_scheduler);
 
-struct drm_sched_entity *
-xe_dep_scheduler_entity(struct xe_dep_scheduler *dep_scheduler);
+struct drm_dep_queue *
+xe_dep_scheduler_dep_q(struct xe_dep_scheduler *dep_scheduler);
diff --git a/drivers/gpu/drm/xe/xe_exec_queue_types.h b/drivers/gpu/drm/xe/xe_exec_queue_types.h
index 8ce78e0b1d50..35c7625a2df5 100644
--- a/drivers/gpu/drm/xe/xe_exec_queue_types.h
+++ b/drivers/gpu/drm/xe/xe_exec_queue_types.h
@@ -8,7 +8,7 @@
 
 #include <linux/kref.h>
 
-#include <drm/gpu_scheduler.h>
+#include <drm/drm_dep.h>
 
 #include "xe_gpu_scheduler_types.h"
 #include "xe_hw_engine_types.h"
@@ -245,8 +245,8 @@ struct xe_exec_queue {
 
 	/** @ring_ops: ring operations for this exec queue */
 	const struct xe_ring_ops *ring_ops;
-	/** @entity: DRM sched entity for this exec queue (1 to 1 relationship) */
-	struct drm_sched_entity *entity;
+	/** @dep_q: dep queue for this exec queue (1 to 1 relationship) */
+	struct drm_dep_queue *dep_q;
 
 #define XE_MAX_JOB_COUNT_PER_EXEC_QUEUE	1000
 	/** @job_cnt: number of drm jobs in this exec queue */
diff --git a/drivers/gpu/drm/xe/xe_execlist.c b/drivers/gpu/drm/xe/xe_execlist.c
index 755a2bff5d7b..fb948b2c617c 100644
--- a/drivers/gpu/drm/xe/xe_execlist.c
+++ b/drivers/gpu/drm/xe/xe_execlist.c
@@ -307,7 +307,7 @@ void xe_execlist_port_destroy(struct xe_execlist_port *port)
 }
 
 static struct dma_fence *
-execlist_run_job(struct drm_sched_job *drm_job)
+execlist_run_job(struct drm_dep_job *drm_job)
 {
 	struct xe_sched_job *job = to_xe_sched_job(drm_job);
 	struct xe_exec_queue *q = job->q;
@@ -319,30 +319,31 @@ execlist_run_job(struct drm_sched_job *drm_job)
 	return job->fence;
 }
 
-static void execlist_job_free(struct drm_sched_job *drm_job)
+static void execlist_dep_queue_release(struct drm_dep_queue *q)
 {
-	struct xe_sched_job *job = to_xe_sched_job(drm_job);
+	struct xe_execlist_exec_queue *exl =
+		container_of(q, typeof(*exl), queue);
 
-	xe_exec_queue_update_run_ticks(job->q);
-	xe_sched_job_put(job);
+	/*
+	 * RCU free: the dep queue's name may be referenced by exported dma
+	 * fences (timeline name). Defer freeing until after any RCU readers.
+	 */
+	kfree_rcu(exl, queue.rcu);
 }
 
-static const struct drm_sched_backend_ops drm_sched_ops = {
+static const struct drm_dep_queue_ops execlist_dep_queue_ops = {
 	.run_job = execlist_run_job,
-	.free_job = execlist_job_free,
+	.release = execlist_dep_queue_release,
 };
 
 static int execlist_exec_queue_init(struct xe_exec_queue *q)
 {
-	struct drm_gpu_scheduler *sched;
-	const struct drm_sched_init_args args = {
-		.ops = &drm_sched_ops,
-		.num_rqs = 1,
+	const struct drm_dep_queue_init_args args = {
+		.ops = &execlist_dep_queue_ops,
 		.credit_limit = xe_lrc_ring_size() / MAX_JOB_SIZE_BYTES,
-		.hang_limit = XE_SCHED_HANG_LIMIT,
 		.timeout = XE_SCHED_JOB_TIMEOUT,
 		.name = q->hwe->name,
-		.dev = gt_to_xe(q->gt)->drm.dev,
+		.drm = &gt_to_xe(q->gt)->drm,
 	};
 	struct xe_execlist_exec_queue *exl;
 	struct xe_device *xe = gt_to_xe(q->gt);
@@ -358,27 +359,20 @@ static int execlist_exec_queue_init(struct xe_exec_queue *q)
 
 	exl->q = q;
 
-	err = drm_sched_init(&exl->sched, &args);
+	err = drm_dep_queue_init(&exl->queue, &args);
 	if (err)
 		goto err_free;
 
-	sched = &exl->sched;
-	err = drm_sched_entity_init(&exl->entity, 0, &sched, 1, NULL);
-	if (err)
-		goto err_sched;
-
 	exl->port = q->hwe->exl_port;
 	exl->has_run = false;
 	exl->active_priority = XE_EXEC_QUEUE_PRIORITY_UNSET;
 	q->execlist = exl;
-	q->entity = &exl->entity;
+	q->dep_q = &exl->queue;
 
 	xe_exec_queue_assign_name(q, ffs(q->logical_mask) - 1);
 
 	return 0;
 
-err_sched:
-	drm_sched_fini(&exl->sched);
 err_free:
 	kfree(exl);
 	return err;
@@ -388,10 +382,7 @@ static void execlist_exec_queue_fini(struct xe_exec_queue *q)
 {
 	struct xe_execlist_exec_queue *exl = q->execlist;
 
-	drm_sched_entity_fini(&exl->entity);
-	drm_sched_fini(&exl->sched);
-
-	kfree(exl);
+	drm_dep_queue_put(&exl->queue);
 }
 
 static void execlist_exec_queue_destroy_async(struct work_struct *w)
diff --git a/drivers/gpu/drm/xe/xe_execlist_types.h b/drivers/gpu/drm/xe/xe_execlist_types.h
index 92c4ba52db0c..c2c8218db350 100644
--- a/drivers/gpu/drm/xe/xe_execlist_types.h
+++ b/drivers/gpu/drm/xe/xe_execlist_types.h
@@ -34,9 +34,7 @@ struct xe_execlist_port {
 struct xe_execlist_exec_queue {
 	struct xe_exec_queue *q;
 
-	struct drm_gpu_scheduler sched;
-
-	struct drm_sched_entity entity;
+	struct drm_dep_queue queue;
 
 	struct xe_execlist_port *port;
 
diff --git a/drivers/gpu/drm/xe/xe_gpu_scheduler.c b/drivers/gpu/drm/xe/xe_gpu_scheduler.c
index 9c8004d5dd91..a8e6384dffe8 100644
--- a/drivers/gpu/drm/xe/xe_gpu_scheduler.c
+++ b/drivers/gpu/drm/xe/xe_gpu_scheduler.c
@@ -7,8 +7,7 @@
 
 static void xe_sched_process_msg_queue(struct xe_gpu_scheduler *sched)
 {
-	if (!drm_sched_is_stopped(&sched->base))
-		queue_work(sched->base.submit_wq, &sched->work_process_msg);
+	drm_dep_queue_work_enqueue(&sched->base, &sched->work_process_msg);
 }
 
 static void xe_sched_process_msg_queue_if_ready(struct xe_gpu_scheduler *sched)
@@ -43,7 +42,9 @@ static void xe_sched_process_msg_work(struct work_struct *w)
 		container_of(w, struct xe_gpu_scheduler, work_process_msg);
 	struct xe_sched_msg *msg;
 
-	if (drm_sched_is_stopped(&sched->base))
+	drm_dep_queue_sched_guard(&sched->base);
+
+	if (drm_dep_queue_is_stopped(&sched->base))
 		return;
 
 	msg = xe_sched_get_msg(sched);
@@ -55,25 +56,23 @@ static void xe_sched_process_msg_work(struct work_struct *w)
 }
 
 int xe_sched_init(struct xe_gpu_scheduler *sched,
-		  const struct drm_sched_backend_ops *ops,
+		  const struct drm_dep_queue_ops *ops,
 		  const struct xe_sched_backend_ops *xe_ops,
 		  struct workqueue_struct *submit_wq,
-		  uint32_t hw_submission, unsigned hang_limit,
-		  long timeout, struct workqueue_struct *timeout_wq,
-		  atomic_t *score, const char *name,
-		  struct device *dev)
+		  uint32_t hw_submission, long timeout,
+		  struct workqueue_struct *timeout_wq,
+		  enum drm_dep_queue_flags flags,
+		  const char *name, struct drm_device *drm)
 {
-	const struct drm_sched_init_args args = {
+	const struct drm_dep_queue_init_args args = {
 		.ops = ops,
 		.submit_wq = submit_wq,
-		.num_rqs = 1,
 		.credit_limit = hw_submission,
-		.hang_limit = hang_limit,
 		.timeout = timeout,
 		.timeout_wq = timeout_wq,
-		.score = score,
 		.name = name,
-		.dev = dev,
+		.drm = drm,
+		.flags = flags,
 	};
 
 	sched->ops = xe_ops;
@@ -81,30 +80,29 @@ int xe_sched_init(struct xe_gpu_scheduler *sched,
 	INIT_LIST_HEAD(&sched->msgs);
 	INIT_WORK(&sched->work_process_msg, xe_sched_process_msg_work);
 
-	return drm_sched_init(&sched->base, &args);
+	return drm_dep_queue_init(&sched->base, &args);
 }
 
 void xe_sched_fini(struct xe_gpu_scheduler *sched)
 {
-	xe_sched_submission_stop(sched);
-	drm_sched_fini(&sched->base);
+	drm_dep_queue_put(&sched->base);
 }
 
 void xe_sched_submission_start(struct xe_gpu_scheduler *sched)
 {
-	drm_sched_wqueue_start(&sched->base);
-	queue_work(sched->base.submit_wq, &sched->work_process_msg);
+	drm_dep_queue_start(&sched->base);
+	drm_dep_queue_work_enqueue(&sched->base, &sched->work_process_msg);
 }
 
 void xe_sched_submission_stop(struct xe_gpu_scheduler *sched)
 {
-	drm_sched_wqueue_stop(&sched->base);
+	drm_dep_queue_stop(&sched->base);
 	cancel_work_sync(&sched->work_process_msg);
 }
 
 void xe_sched_submission_resume_tdr(struct xe_gpu_scheduler *sched)
 {
-	drm_sched_resume_timeout(&sched->base, sched->base.timeout);
+	drm_dep_queue_resume_timeout(&sched->base);
 }
 
 void xe_sched_add_msg(struct xe_gpu_scheduler *sched,
diff --git a/drivers/gpu/drm/xe/xe_gpu_scheduler.h b/drivers/gpu/drm/xe/xe_gpu_scheduler.h
index 664c2db56af3..4086aafb0a9a 100644
--- a/drivers/gpu/drm/xe/xe_gpu_scheduler.h
+++ b/drivers/gpu/drm/xe/xe_gpu_scheduler.h
@@ -10,13 +10,13 @@
 #include "xe_sched_job.h"
 
 int xe_sched_init(struct xe_gpu_scheduler *sched,
-		  const struct drm_sched_backend_ops *ops,
+		  const struct drm_dep_queue_ops *ops,
 		  const struct xe_sched_backend_ops *xe_ops,
 		  struct workqueue_struct *submit_wq,
-		  uint32_t hw_submission, unsigned hang_limit,
-		  long timeout, struct workqueue_struct *timeout_wq,
-		  atomic_t *score, const char *name,
-		  struct device *dev);
+		  uint32_t hw_submission, long timeout,
+		  struct workqueue_struct *timeout_wq,
+		  enum drm_dep_queue_flags flags,
+		  const char *name, struct drm_device *drm);
 void xe_sched_fini(struct xe_gpu_scheduler *sched);
 
 void xe_sched_submission_start(struct xe_gpu_scheduler *sched);
@@ -41,32 +41,29 @@ static inline void xe_sched_msg_unlock(struct xe_gpu_scheduler *sched)
 	spin_unlock(&sched->msg_lock);
 }
 
-static inline void xe_sched_stop(struct xe_gpu_scheduler *sched)
-{
-	drm_sched_stop(&sched->base, NULL);
-}
-
 static inline void xe_sched_tdr_queue_imm(struct xe_gpu_scheduler *sched)
 {
-	drm_sched_tdr_queue_imm(&sched->base);
+	drm_dep_queue_trigger_timeout(&sched->base);
 }
 
 static inline void xe_sched_resubmit_jobs(struct xe_gpu_scheduler *sched)
 {
-	struct drm_sched_job *s_job;
+	struct drm_dep_job *drm_job;
+	struct xe_sched_job *job;
 	bool restore_replay = false;
 
-	drm_sched_for_each_pending_job(s_job, &sched->base, NULL) {
-		restore_replay |= to_xe_sched_job(s_job)->restore_replay;
-		if (restore_replay || !drm_sched_job_is_signaled(s_job))
-			sched->base.ops->run_job(s_job);
+	drm_dep_queue_for_each_pending_job(drm_job, &sched->base) {
+		job = to_xe_sched_job(drm_job);
+		restore_replay |= job->restore_replay;
+		if (restore_replay || !drm_dep_job_is_signaled(drm_job))
+			sched->base.ops->run_job(drm_job);
 	}
 }
 
 static inline bool
 xe_sched_invalidate_job(struct xe_sched_job *job, int threshold)
 {
-	return drm_sched_invalidate_job(&job->drm, threshold);
+	return drm_dep_job_invalidate_job(&job->drm, threshold);
 }
 
 /**
@@ -78,24 +75,13 @@ xe_sched_invalidate_job(struct xe_sched_job *job, int threshold)
 static inline
 struct xe_sched_job *xe_sched_first_pending_job(struct xe_gpu_scheduler *sched)
 {
-	struct drm_sched_job *job;
+	struct drm_dep_job *drm_job;
 
-	drm_sched_for_each_pending_job(job, &sched->base, NULL)
-		if (!drm_sched_job_is_signaled(job))
-			return to_xe_sched_job(job);
+	drm_dep_queue_for_each_pending_job(drm_job, &sched->base)
+		if (!drm_dep_job_is_signaled(drm_job))
+			return to_xe_sched_job(drm_job);
 
 	return NULL;
 }
 
-static inline int
-xe_sched_entity_init(struct xe_sched_entity *entity,
-		     struct xe_gpu_scheduler *sched)
-{
-	return drm_sched_entity_init(entity, 0,
-				     (struct drm_gpu_scheduler **)&sched,
-				     1, NULL);
-}
-
-#define xe_sched_entity_fini drm_sched_entity_fini
-
 #endif
diff --git a/drivers/gpu/drm/xe/xe_gpu_scheduler_types.h b/drivers/gpu/drm/xe/xe_gpu_scheduler_types.h
index 63d9bf92583c..ff89d36d3b2a 100644
--- a/drivers/gpu/drm/xe/xe_gpu_scheduler_types.h
+++ b/drivers/gpu/drm/xe/xe_gpu_scheduler_types.h
@@ -6,7 +6,7 @@
 #ifndef _XE_GPU_SCHEDULER_TYPES_H_
 #define _XE_GPU_SCHEDULER_TYPES_H_
 
-#include <drm/gpu_scheduler.h>
+#include <drm/drm_dep.h>
 
 /**
  * struct xe_sched_msg - an in-band (relative to GPU scheduler run queue)
@@ -41,8 +41,8 @@ struct xe_sched_backend_ops {
  * struct xe_gpu_scheduler - Xe GPU scheduler
  */
 struct xe_gpu_scheduler {
-	/** @base: DRM GPU scheduler */
-	struct drm_gpu_scheduler		base;
+	/** @base: DRM dependency queue */
+	struct drm_dep_queue			base;
 	/** @ops: Xe scheduler ops */
 	const struct xe_sched_backend_ops	*ops;
 	/** @msgs: list of messages to be processed in @work_process_msg */
@@ -53,7 +53,6 @@ struct xe_gpu_scheduler {
 	struct work_struct		work_process_msg;
 };
 
-#define xe_sched_entity		drm_sched_entity
-#define xe_sched_policy		drm_sched_policy
+#define xe_sched_entity		drm_dep_queue
 
 #endif
diff --git a/drivers/gpu/drm/xe/xe_guc_exec_queue_types.h b/drivers/gpu/drm/xe/xe_guc_exec_queue_types.h
index fd0915ed8eb1..42ba4892ff71 100644
--- a/drivers/gpu/drm/xe/xe_guc_exec_queue_types.h
+++ b/drivers/gpu/drm/xe/xe_guc_exec_queue_types.h
@@ -18,14 +18,10 @@ struct xe_exec_queue;
  * struct xe_guc_exec_queue - GuC specific state for an xe_exec_queue
  */
 struct xe_guc_exec_queue {
-	/** @q: Backpointer to parent xe_exec_queue */
-	struct xe_exec_queue *q;
-	/** @rcu: For safe freeing of exported dma fences */
-	struct rcu_head rcu;
 	/** @sched: GPU scheduler for this xe_exec_queue */
 	struct xe_gpu_scheduler sched;
-	/** @entity: Scheduler entity for this xe_exec_queue */
-	struct xe_sched_entity entity;
+	/** @q: Backpointer to parent xe_exec_queue */
+	struct xe_exec_queue *q;
 	/**
 	 * @static_msgs: Static messages for this xe_exec_queue, used when
 	 * a message needs to sent through the GPU scheduler but memory
diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
index a145234f662b..fc9704fad177 100644
--- a/drivers/gpu/drm/xe/xe_guc_submit.c
+++ b/drivers/gpu/drm/xe/xe_guc_submit.c
@@ -244,17 +244,8 @@ static void guc_submit_sw_fini(struct drm_device *drm, void *arg)
 {
 	struct xe_guc *guc = arg;
 	struct xe_device *xe = guc_to_xe(guc);
-	struct xe_gt *gt = guc_to_gt(guc);
-	int ret;
-
-	ret = wait_event_timeout(guc->submission_state.fini_wq,
-				 xa_empty(&guc->submission_state.exec_queue_lookup),
-				 HZ * 5);
 
 	drain_workqueue(xe->destroy_wq);
-
-	xe_gt_assert(gt, ret);
-
 	xa_destroy(&guc->submission_state.exec_queue_lookup);
 }
 
@@ -1203,7 +1194,7 @@ static void submit_exec_queue(struct xe_exec_queue *q, struct xe_sched_job *job)
 }
 
 static struct dma_fence *
-guc_exec_queue_run_job(struct drm_sched_job *drm_job)
+guc_exec_queue_run_job(struct drm_dep_job *drm_job)
 {
 	struct xe_sched_job *job = to_xe_sched_job(drm_job);
 	struct xe_exec_queue *q = job->q;
@@ -1242,13 +1233,6 @@ guc_exec_queue_run_job(struct drm_sched_job *drm_job)
 	return job->fence;
 }
 
-static void guc_exec_queue_free_job(struct drm_sched_job *drm_job)
-{
-	struct xe_sched_job *job = to_xe_sched_job(drm_job);
-
-	trace_xe_sched_job_free(job);
-	xe_sched_job_put(job);
-}
 
 int xe_guc_read_stopped(struct xe_guc *guc)
 {
@@ -1486,11 +1470,11 @@ static void disable_scheduling(struct xe_exec_queue *q, bool immediate)
 			       G2H_LEN_DW_SCHED_CONTEXT_MODE_SET, 1);
 }
 
-static enum drm_gpu_sched_stat
-guc_exec_queue_timedout_job(struct drm_sched_job *drm_job)
+static enum drm_dep_timedout_stat
+guc_exec_queue_timedout_job(struct drm_dep_job *drm_job)
 {
 	struct xe_sched_job *job = to_xe_sched_job(drm_job);
-	struct drm_sched_job *tmp_job;
+	struct drm_dep_job *tmp_job;
 	struct xe_exec_queue *q = job->q, *primary;
 	struct xe_gpu_scheduler *sched = &q->guc->sched;
 	struct xe_guc *guc = exec_queue_to_guc(q);
@@ -1502,17 +1486,13 @@ guc_exec_queue_timedout_job(struct drm_sched_job *drm_job)
 
 	xe_gt_assert(guc_to_gt(guc), !exec_queue_destroyed(q));
 
-	primary = xe_exec_queue_multi_queue_primary(q);
+	if (drm_dep_job_is_finished(&job->drm))
+		return DRM_DEP_TIMEDOUT_STAT_JOB_SIGNALED;
 
-	/*
-	 * TDR has fired before free job worker. Common if exec queue
-	 * immediately closed after last fence signaled. Add back to pending
-	 * list so job can be freed and kick scheduler ensuring free job is not
-	 * lost.
-	 */
-	if (test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &job->fence->flags) ||
-	    vf_recovery(guc))
-		return DRM_GPU_SCHED_STAT_NO_HANG;
+	if (vf_recovery(guc))
+		return DRM_DEP_TIMEDOUT_STAT_REQUEUE_JOB;
+
+	primary = xe_exec_queue_multi_queue_primary(q);
 
 	/* Kill the run_job entry point */
 	if (xe_exec_queue_is_multi_queue(q))
@@ -1577,7 +1557,7 @@ guc_exec_queue_timedout_job(struct drm_sched_job *drm_job)
 						 xe_guc_read_stopped(guc) ||
 						 vf_recovery(guc), HZ * 5);
 			if (vf_recovery(guc))
-				goto handle_vf_resume;
+				return DRM_DEP_TIMEDOUT_STAT_REQUEUE_JOB;
 			if (!ret || xe_guc_read_stopped(guc))
 				goto trigger_reset;
 
@@ -1599,7 +1579,7 @@ guc_exec_queue_timedout_job(struct drm_sched_job *drm_job)
 					 xe_guc_read_stopped(guc) ||
 					 vf_recovery(guc), HZ * 5);
 		if (vf_recovery(guc))
-			goto handle_vf_resume;
+			return DRM_DEP_TIMEDOUT_STAT_REQUEUE_JOB;
 		if (!ret || xe_guc_read_stopped(guc)) {
 trigger_reset:
 			if (!ret)
@@ -1644,15 +1624,13 @@ guc_exec_queue_timedout_job(struct drm_sched_job *drm_job)
 		   "VM job timed out on non-killed execqueue\n");
 	if (!wedged && (q->flags & EXEC_QUEUE_FLAG_KERNEL ||
 			(q->flags & EXEC_QUEUE_FLAG_VM && !exec_queue_killed(q)))) {
-		if (!xe_sched_invalidate_job(job, 2)) {
+		if (!xe_sched_invalidate_job(job, 2))
 			xe_gt_reset_async(q->gt);
-			goto rearm;
-		}
 	}
 
 	/* Mark all outstanding jobs as bad, thus completing them */
 	xe_sched_job_set_error(job, err);
-	drm_sched_for_each_pending_job(tmp_job, &sched->base, NULL)
+	drm_dep_queue_for_each_pending_job(tmp_job, &sched->base)
 		xe_sched_job_set_error(to_xe_sched_job(tmp_job), -ECANCELED);
 
 	if (xe_exec_queue_is_multi_queue(q)) {
@@ -1663,11 +1641,7 @@ guc_exec_queue_timedout_job(struct drm_sched_job *drm_job)
 		xe_guc_exec_queue_trigger_cleanup(q);
 	}
 
-	/*
-	 * We want the job added back to the pending list so it gets freed; this
-	 * is what DRM_GPU_SCHED_STAT_NO_HANG does.
-	 */
-	return DRM_GPU_SCHED_STAT_NO_HANG;
+	return DRM_DEP_TIMEDOUT_STAT_REQUEUE_JOB;
 
 rearm:
 	/*
@@ -1679,8 +1653,8 @@ guc_exec_queue_timedout_job(struct drm_sched_job *drm_job)
 		xe_guc_exec_queue_group_start(q);
 	else
 		xe_sched_submission_start(sched);
-handle_vf_resume:
-	return DRM_GPU_SCHED_STAT_NO_HANG;
+
+	return DRM_DEP_TIMEDOUT_STAT_REQUEUE_JOB;
 }
 
 static void guc_exec_queue_fini(struct xe_exec_queue *q)
@@ -1689,24 +1663,11 @@ static void guc_exec_queue_fini(struct xe_exec_queue *q)
 	struct xe_guc *guc = exec_queue_to_guc(q);
 
 	release_guc_id(guc, q);
-	xe_sched_entity_fini(&ge->entity);
 	xe_sched_fini(&ge->sched);
-
-	/*
-	 * RCU free due sched being exported via DRM scheduler fences
-	 * (timeline name).
-	 */
-	kfree_rcu(ge, rcu);
 }
 
-static void __guc_exec_queue_destroy_async(struct work_struct *w)
+static void __guc_exec_queue_destroy(struct xe_exec_queue *q)
 {
-	struct xe_guc_exec_queue *ge =
-		container_of(w, struct xe_guc_exec_queue, destroy_async);
-	struct xe_exec_queue *q = ge->q;
-	struct xe_guc *guc = exec_queue_to_guc(q);
-
-	guard(xe_pm_runtime)(guc_to_xe(guc));
 	trace_xe_exec_queue_destroy(q);
 
 	if (xe_exec_queue_is_multi_queue_secondary(q)) {
@@ -1717,36 +1678,25 @@ static void __guc_exec_queue_destroy_async(struct work_struct *w)
 		mutex_unlock(&group->list_lock);
 	}
 
-	/* Confirm no work left behind accessing device structures */
-	cancel_delayed_work_sync(&ge->sched.base.work_tdr);
-
 	xe_exec_queue_fini(q);
 }
 
+static void __guc_exec_queue_destroy_async(struct work_struct *w)
+{
+	struct xe_guc_exec_queue *ge =
+		container_of(w, struct xe_guc_exec_queue, destroy_async);
+	struct xe_exec_queue *q = ge->q;
+
+	__guc_exec_queue_destroy(q);
+}
+
 static void guc_exec_queue_destroy_async(struct xe_exec_queue *q)
 {
 	struct xe_guc *guc = exec_queue_to_guc(q);
 	struct xe_device *xe = guc_to_xe(guc);
 
 	INIT_WORK(&q->guc->destroy_async, __guc_exec_queue_destroy_async);
-
-	/* We must block on kernel engines so slabs are empty on driver unload */
-	if (q->flags & EXEC_QUEUE_FLAG_PERMANENT || exec_queue_wedged(q))
-		__guc_exec_queue_destroy_async(&q->guc->destroy_async);
-	else
-		queue_work(xe->destroy_wq, &q->guc->destroy_async);
-}
-
-static void __guc_exec_queue_destroy(struct xe_guc *guc, struct xe_exec_queue *q)
-{
-	/*
-	 * Might be done from within the GPU scheduler, need to do async as we
-	 * fini the scheduler when the engine is fini'd, the scheduler can't
-	 * complete fini within itself (circular dependency). Async resolves
-	 * this we and don't really care when everything is fini'd, just that it
-	 * is.
-	 */
-	guc_exec_queue_destroy_async(q);
+	queue_work(xe->destroy_wq, &q->guc->destroy_async);
 }
 
 static void __guc_exec_queue_process_msg_cleanup(struct xe_sched_msg *msg)
@@ -1770,7 +1720,7 @@ static void __guc_exec_queue_process_msg_cleanup(struct xe_sched_msg *msg)
 	if (exec_queue_registered(q) && xe_uc_fw_is_running(&guc->fw))
 		disable_scheduling_deregister(guc, q);
 	else
-		__guc_exec_queue_destroy(guc, q);
+		guc_exec_queue_destroy_async(q);
 }
 
 static bool guc_exec_queue_allowed_to_change_state(struct xe_exec_queue *q)
@@ -1961,10 +1911,24 @@ static void guc_exec_queue_process_msg(struct xe_sched_msg *msg)
 	xe_pm_runtime_put(xe);
 }
 
-static const struct drm_sched_backend_ops drm_sched_ops = {
+static void guc_dep_queue_release(struct drm_dep_queue *q)
+{
+	struct xe_gpu_scheduler *sched =
+		container_of(q, typeof(*sched), base);
+	struct xe_guc_exec_queue *ge =
+		container_of(sched, typeof(*ge), sched);
+
+	/*
+	 * RCU free: the dep queue's name may be referenced by exported dma
+	 * fences (timeline name). Defer freeing until after any RCU readers.
+	 */
+	kfree_rcu(ge, sched.base.rcu);
+}
+
+static const struct drm_dep_queue_ops guc_dep_queue_ops = {
 	.run_job = guc_exec_queue_run_job,
-	.free_job = guc_exec_queue_free_job,
 	.timedout_job = guc_exec_queue_timedout_job,
+	.release = guc_dep_queue_release,
 };
 
 static const struct xe_sched_backend_ops xe_sched_ops = {
@@ -1977,6 +1941,7 @@ static int guc_exec_queue_init(struct xe_exec_queue *q)
 	struct xe_guc *guc = exec_queue_to_guc(q);
 	struct workqueue_struct *submit_wq = NULL;
 	struct xe_guc_exec_queue *ge;
+	enum drm_dep_queue_flags flags = DRM_DEP_QUEUE_FLAGS_BYPASS_SUPPORTED;
 	long timeout;
 	int err, i;
 
@@ -1988,7 +1953,6 @@ static int guc_exec_queue_init(struct xe_exec_queue *q)
 
 	q->guc = ge;
 	ge->q = q;
-	init_rcu_head(&ge->rcu);
 	init_waitqueue_head(&ge->suspend_wait);
 
 	for (i = 0; i < MAX_STATIC_MSG_TYPE; ++i)
@@ -2005,35 +1969,29 @@ static int guc_exec_queue_init(struct xe_exec_queue *q)
 	if (xe_exec_queue_is_multi_queue_secondary(q)) {
 		struct xe_exec_queue *primary = xe_exec_queue_multi_queue_primary(q);
 
-		submit_wq = primary->guc->sched.base.submit_wq;
+		submit_wq = drm_dep_queue_submit_wq(&primary->guc->sched.base);
 	}
 
-	err = xe_sched_init(&ge->sched, &drm_sched_ops, &xe_sched_ops,
-			    submit_wq, xe_lrc_ring_size() / MAX_JOB_SIZE_BYTES, 64,
-			    timeout, guc_to_gt(guc)->ordered_wq, NULL,
-			    q->name, gt_to_xe(q->gt)->drm.dev);
+	err = xe_sched_init(&ge->sched, &guc_dep_queue_ops, &xe_sched_ops,
+			    submit_wq, xe_lrc_ring_size() / MAX_JOB_SIZE_BYTES,
+			    timeout, guc_to_gt(guc)->ordered_wq, flags,
+			    q->name, &gt_to_xe(q->gt)->drm);
 	if (err)
 		goto err_free;
 
 	sched = &ge->sched;
-	err = xe_sched_entity_init(&ge->entity, sched);
-	if (err)
-		goto err_sched;
 
 	mutex_lock(&guc->submission_state.lock);
 
 	err = alloc_guc_id(guc, q);
 	if (err)
-		goto err_entity;
+		goto err_sched;
 
-	q->entity = &ge->entity;
+	/* dep_q IS the queue: ge->sched.base is the drm_dep_queue */
+	q->dep_q = &ge->sched.base;
 
 	if (xe_guc_read_stopped(guc) || vf_recovery(guc))
-		xe_sched_stop(sched);
-
-	mutex_unlock(&guc->submission_state.lock);
-
-	xe_exec_queue_assign_name(q, q->guc->id);
+		xe_sched_submission_stop(sched);
 
 	/*
 	 * Maintain secondary queues of the multi queue group in a list
@@ -2045,11 +2003,15 @@ static int guc_exec_queue_init(struct xe_exec_queue *q)
 		INIT_LIST_HEAD(&q->multi_queue.link);
 		mutex_lock(&group->list_lock);
 		if (group->stopped)
-			WRITE_ONCE(q->guc->sched.base.pause_submit, true);
+			drm_dep_queue_set_stopped(&q->guc->sched.base);
 		list_add_tail(&q->multi_queue.link, &group->list);
 		mutex_unlock(&group->list_lock);
 	}
 
+	mutex_unlock(&guc->submission_state.lock);
+
+	xe_exec_queue_assign_name(q, q->guc->id);
+
 	if (xe_exec_queue_is_multi_queue(q))
 		trace_xe_exec_queue_create_multi_queue(q);
 	else
@@ -2057,11 +2019,11 @@ static int guc_exec_queue_init(struct xe_exec_queue *q)
 
 	return 0;
 
-err_entity:
-	mutex_unlock(&guc->submission_state.lock);
-	xe_sched_entity_fini(&ge->entity);
 err_sched:
+	mutex_unlock(&guc->submission_state.lock);
 	xe_sched_fini(&ge->sched);
+
+	return err;
 err_free:
 	kfree(ge);
 
@@ -2126,7 +2088,7 @@ static void guc_exec_queue_destroy(struct xe_exec_queue *q)
 	if (!(q->flags & EXEC_QUEUE_FLAG_PERMANENT) && !exec_queue_wedged(q))
 		guc_exec_queue_add_msg(q, msg, CLEANUP);
 	else
-		__guc_exec_queue_destroy(exec_queue_to_guc(q), q);
+		__guc_exec_queue_destroy(q);
 }
 
 static int guc_exec_queue_set_priority(struct xe_exec_queue *q,
@@ -2373,7 +2335,7 @@ static void guc_exec_queue_stop(struct xe_guc *guc, struct xe_exec_queue *q)
 	}
 
 	if (do_destroy)
-		__guc_exec_queue_destroy(guc, q);
+		guc_exec_queue_destroy_async(q);
 }
 
 static int guc_submit_reset_prepare(struct xe_guc *guc)
@@ -2519,7 +2481,7 @@ static void guc_exec_queue_pause(struct xe_guc *guc, struct xe_exec_queue *q)
 
 	/* Stop scheduling + flush any DRM scheduler operations */
 	xe_sched_submission_stop(sched);
-	cancel_delayed_work_sync(&sched->base.work_tdr);
+	drm_dep_queue_cancel_tdr_sync(&sched->base);
 
 	guc_exec_queue_revert_pending_state_change(guc, q);
 
@@ -2647,11 +2609,11 @@ static void guc_exec_queue_unpause_prepare(struct xe_guc *guc,
 {
 	struct xe_gpu_scheduler *sched = &q->guc->sched;
 	struct xe_sched_job *job = NULL;
-	struct drm_sched_job *s_job;
+	struct drm_dep_job *dep_job;
 	bool restore_replay = false;
 
-	drm_sched_for_each_pending_job(s_job, &sched->base, NULL) {
-		job = to_xe_sched_job(s_job);
+	drm_dep_queue_for_each_pending_job(dep_job, &sched->base) {
+		job = to_xe_sched_job(dep_job);
 		restore_replay |= job->restore_replay;
 		if (restore_replay) {
 			xe_gt_dbg(guc_to_gt(guc), "Replay JOB - guc_id=%d, seqno=%d",
@@ -2775,7 +2737,7 @@ void xe_guc_submit_unpause_vf(struct xe_guc *guc)
 		 * created after resfix done.
 		 */
 		if (q->guc->id != index ||
-		    !drm_sched_is_stopped(&q->guc->sched.base))
+		    !drm_dep_queue_is_stopped(&q->guc->sched.base))
 			continue;
 
 		guc_exec_queue_unpause(guc, q);
@@ -2938,7 +2900,7 @@ static void handle_deregister_done(struct xe_guc *guc, struct xe_exec_queue *q)
 	trace_xe_exec_queue_deregister_done(q);
 
 	clear_exec_queue_registered(q);
-	__guc_exec_queue_destroy(guc, q);
+	guc_exec_queue_destroy_async(q);
 }
 
 int xe_guc_deregister_done_handler(struct xe_guc *guc, u32 *msg, u32 len)
@@ -3243,8 +3205,8 @@ xe_guc_exec_queue_snapshot_capture(struct xe_exec_queue *q)
 	snapshot->class = q->class;
 	snapshot->logical_mask = q->logical_mask;
 	snapshot->width = q->width;
-	snapshot->refcount = kref_read(&q->refcount);
-	snapshot->sched_timeout = sched->base.timeout;
+	snapshot->refcount = drm_dep_queue_refcount(&sched->base);
+	snapshot->sched_timeout = drm_dep_queue_timeout(&sched->base);
 	snapshot->sched_props.timeslice_us = q->sched_props.timeslice_us;
 	snapshot->sched_props.preempt_timeout_us =
 		q->sched_props.preempt_timeout_us;
diff --git a/drivers/gpu/drm/xe/xe_migrate.c b/drivers/gpu/drm/xe/xe_migrate.c
index 519f7c70abfb..565054ba0c34 100644
--- a/drivers/gpu/drm/xe/xe_migrate.c
+++ b/drivers/gpu/drm/xe/xe_migrate.c
@@ -2279,7 +2279,7 @@ static struct dma_fence *xe_migrate_vram(struct xe_migrate *m,
 
 	if (deps && !dma_fence_is_signaled(deps)) {
 		dma_fence_get(deps);
-		err = drm_sched_job_add_dependency(&job->drm, deps);
+		err = drm_dep_job_add_dependency(&job->drm, deps);
 		if (err)
 			dma_fence_wait(deps, false);
 		err = 0;
diff --git a/drivers/gpu/drm/xe/xe_pt.c b/drivers/gpu/drm/xe/xe_pt.c
index 13b355fadd58..24374a3459c2 100644
--- a/drivers/gpu/drm/xe/xe_pt.c
+++ b/drivers/gpu/drm/xe/xe_pt.c
@@ -1322,7 +1322,7 @@ static int xe_pt_vm_dependencies(struct xe_sched_job *job,
 				return -ETIME;
 
 			dma_fence_get(fence);
-			err = drm_sched_job_add_dependency(&job->drm, fence);
+			err = drm_dep_job_add_dependency(&job->drm, fence);
 			if (err)
 				return err;
 		}
diff --git a/drivers/gpu/drm/xe/xe_sched_job.c b/drivers/gpu/drm/xe/xe_sched_job.c
index 99f11bb4d2b9..6b83618e82aa 100644
--- a/drivers/gpu/drm/xe/xe_sched_job.c
+++ b/drivers/gpu/drm/xe/xe_sched_job.c
@@ -21,6 +21,12 @@
 #include "xe_trace.h"
 #include "xe_vm.h"
 
+static void xe_sched_job_release(struct drm_dep_job *dep_job);
+
+static const struct drm_dep_job_ops xe_sched_job_dep_ops = {
+	.release = xe_sched_job_release,
+};
+
 static struct kmem_cache *xe_sched_job_slab;
 static struct kmem_cache *xe_sched_job_parallel_slab;
 
@@ -109,15 +115,20 @@ struct xe_sched_job *xe_sched_job_create(struct xe_exec_queue *q,
 	if (!job)
 		return ERR_PTR(-ENOMEM);
 
+	err = drm_dep_job_init(&job->drm,
+			       &(const struct drm_dep_job_init_args){
+					.ops = &xe_sched_job_dep_ops,
+					.q = q->dep_q,
+					.credits = 1,
+			       });
+	if (err)
+		goto err_free;
+
 	job->q = q;
 	job->sample_timestamp = U64_MAX;
-	kref_init(&job->refcount);
 	xe_exec_queue_get(job->q);
-
-	err = drm_sched_job_init(&job->drm, q->entity, 1, NULL,
-				 q->xef ? q->xef->drm->client_id : 0);
-	if (err)
-		goto err_free;
+	atomic_inc(&q->job_cnt);
+	xe_pm_runtime_get_noresume(job_to_xe(job));
 
 	for (i = 0; i < q->width; ++i) {
 		struct dma_fence *fence = xe_lrc_alloc_seqno_fence();
@@ -147,37 +158,34 @@ struct xe_sched_job *xe_sched_job_create(struct xe_exec_queue *q,
 	for (i = 0; i < width; ++i)
 		job->ptrs[i].batch_addr = batch_addr[i];
 
-	atomic_inc(&q->job_cnt);
-	xe_pm_runtime_get_noresume(job_to_xe(job));
 	trace_xe_sched_job_create(job);
 	return job;
 
 err_sched_job:
-	xe_sched_job_free_fences(job);
-	drm_sched_job_cleanup(&job->drm);
+	drm_dep_job_put(&job->drm);
+	return ERR_PTR(err);
+
 err_free:
-	xe_exec_queue_put(q);
 	job_free(job);
 	return ERR_PTR(err);
 }
 
 /**
- * xe_sched_job_destroy - Destroy Xe schedule job
- * @ref: reference to Xe schedule job
+ * xe_sched_job_release - Release Xe schedule job
+ * @dep_job: base DRM dependency job
  *
  * Called when ref == 0, drop a reference to job's xe_engine + fence, cleanup
- * base DRM schedule job, and free memory for Xe schedule job.
+ * and free memory for Xe schedule job.
  */
-void xe_sched_job_destroy(struct kref *ref)
+static void xe_sched_job_release(struct drm_dep_job *dep_job)
 {
 	struct xe_sched_job *job =
-		container_of(ref, struct xe_sched_job, refcount);
+		container_of(dep_job, struct xe_sched_job, drm);
 	struct xe_device *xe = job_to_xe(job);
 	struct xe_exec_queue *q = job->q;
 
 	xe_sched_job_free_fences(job);
 	dma_fence_put(job->fence);
-	drm_sched_job_cleanup(&job->drm);
 	job_free(job);
 	atomic_dec(&q->job_cnt);
 	xe_exec_queue_put(q);
@@ -214,7 +222,6 @@ void xe_sched_job_set_error(struct xe_sched_job *job, int error)
 
 	trace_xe_sched_job_set_error(job);
 
-	dma_fence_enable_sw_signaling(job->fence);
 	xe_hw_fence_irq_run(job->q->fence_irq);
 }
 
@@ -287,16 +294,15 @@ struct dma_fence *xe_sched_job_arm(struct xe_sched_job *job)
 	}
 
 	job->fence = dma_fence_get(fence);	/* Pairs with put in scheduler */
-	drm_sched_job_arm(&job->drm);
+	drm_dep_job_arm(&job->drm);
 
-	return &job->drm.s_fence->finished;
+	return drm_dep_job_finished_fence(&job->drm);
 }
 
 void xe_sched_job_push(struct xe_sched_job *job)
 {
-	xe_sched_job_get(job);
 	trace_xe_sched_job_exec(job);
-	drm_sched_entity_push_job(&job->drm);
+	drm_dep_job_push(&job->drm);
 }
 
 /**
@@ -357,5 +363,5 @@ xe_sched_job_snapshot_print(struct xe_sched_job_snapshot *snapshot,
 int xe_sched_job_add_deps(struct xe_sched_job *job, struct dma_resv *resv,
 			  enum dma_resv_usage usage)
 {
-	return drm_sched_job_add_resv_dependencies(&job->drm, resv, usage);
+	return drm_dep_job_add_resv_dependencies(&job->drm, resv, usage);
 }
diff --git a/drivers/gpu/drm/xe/xe_sched_job.h b/drivers/gpu/drm/xe/xe_sched_job.h
index a39cc4ab980b..bdd0305970b0 100644
--- a/drivers/gpu/drm/xe/xe_sched_job.h
+++ b/drivers/gpu/drm/xe/xe_sched_job.h
@@ -20,7 +20,6 @@ void xe_sched_job_module_exit(void);
 
 struct xe_sched_job *xe_sched_job_create(struct xe_exec_queue *q,
 					 u64 *batch_addr);
-void xe_sched_job_destroy(struct kref *ref);
 
 /**
  * xe_sched_job_get - get reference to Xe schedule job
@@ -30,7 +29,7 @@ void xe_sched_job_destroy(struct kref *ref);
  */
 static inline struct xe_sched_job *xe_sched_job_get(struct xe_sched_job *job)
 {
-	kref_get(&job->refcount);
+	drm_dep_job_get(&job->drm);
 	return job;
 }
 
@@ -43,7 +42,7 @@ static inline struct xe_sched_job *xe_sched_job_get(struct xe_sched_job *job)
  */
 static inline void xe_sched_job_put(struct xe_sched_job *job)
 {
-	kref_put(&job->refcount, xe_sched_job_destroy);
+	drm_dep_job_put(&job->drm);
 }
 
 void xe_sched_job_set_error(struct xe_sched_job *job, int error);
@@ -62,7 +61,7 @@ void xe_sched_job_init_user_fence(struct xe_sched_job *job,
 				  struct xe_sync_entry *sync);
 
 static inline struct xe_sched_job *
-to_xe_sched_job(struct drm_sched_job *drm)
+to_xe_sched_job(struct drm_dep_job *drm)
 {
 	return container_of(drm, struct xe_sched_job, drm);
 }
diff --git a/drivers/gpu/drm/xe/xe_sched_job_types.h b/drivers/gpu/drm/xe/xe_sched_job_types.h
index 13c2970e81a8..6b6189f58fd2 100644
--- a/drivers/gpu/drm/xe/xe_sched_job_types.h
+++ b/drivers/gpu/drm/xe/xe_sched_job_types.h
@@ -8,7 +8,7 @@
 
 #include <linux/kref.h>
 
-#include <drm/gpu_scheduler.h>
+#include <drm/drm_dep.h>
 
 struct xe_exec_queue;
 struct dma_fence;
@@ -35,12 +35,10 @@ struct xe_job_ptrs {
  * struct xe_sched_job - Xe schedule job (batch buffer tracking)
  */
 struct xe_sched_job {
-	/** @drm: base DRM scheduler job */
-	struct drm_sched_job drm;
+	/** @drm: base DRM dependency job */
+	struct drm_dep_job drm;
 	/** @q: Exec queue */
 	struct xe_exec_queue *q;
-	/** @refcount: ref count of this job */
-	struct kref refcount;
 	/**
 	 * @fence: dma fence to indicate completion. 1 way relationship - job
 	 * can safely reference fence, fence cannot safely reference job.
diff --git a/drivers/gpu/drm/xe/xe_sync.c b/drivers/gpu/drm/xe/xe_sync.c
index 24d6d9af20d6..cbe9c0adc9a2 100644
--- a/drivers/gpu/drm/xe/xe_sync.c
+++ b/drivers/gpu/drm/xe/xe_sync.c
@@ -234,7 +234,7 @@ ALLOW_ERROR_INJECTION(xe_sync_entry_parse, ERRNO);
 int xe_sync_entry_add_deps(struct xe_sync_entry *sync, struct xe_sched_job *job)
 {
 	if (sync->fence)
-		return  drm_sched_job_add_dependency(&job->drm,
+		return  drm_dep_job_add_dependency(&job->drm,
 						     dma_fence_get(sync->fence));
 
 	return 0;
diff --git a/drivers/gpu/drm/xe/xe_tlb_inval_job.c b/drivers/gpu/drm/xe/xe_tlb_inval_job.c
index 04d21015cd5d..71cf8fcd99ba 100644
--- a/drivers/gpu/drm/xe/xe_tlb_inval_job.c
+++ b/drivers/gpu/drm/xe/xe_tlb_inval_job.c
@@ -65,18 +65,14 @@ static struct dma_fence *xe_tlb_inval_job_run(struct xe_dep_job *dep_job)
 	return job->fence;
 }
 
-static void xe_tlb_inval_job_free(struct xe_dep_job *dep_job)
-{
-	struct xe_tlb_inval_job *job =
-		container_of(dep_job, typeof(*job), dep);
-
-	/* Pairs with get in xe_tlb_inval_job_push */
-	xe_tlb_inval_job_put(job);
-}
-
 static const struct xe_dep_job_ops dep_job_ops = {
 	.run_job = xe_tlb_inval_job_run,
-	.free_job = xe_tlb_inval_job_free,
+};
+
+static void xe_tlb_inval_job_destroy(struct drm_dep_job *drm_job);
+
+static const struct drm_dep_job_ops xe_tlb_inval_job_dep_ops = {
+	.release = xe_tlb_inval_job_destroy,
 };
 
 /**
@@ -100,8 +96,8 @@ xe_tlb_inval_job_create(struct xe_exec_queue *q, struct xe_tlb_inval *tlb_inval,
 			struct xe_vm *vm, u64 start, u64 end, int type)
 {
 	struct xe_tlb_inval_job *job;
-	struct drm_sched_entity *entity =
-		xe_dep_scheduler_entity(dep_scheduler);
+	struct drm_dep_queue *dep_q =
+		xe_dep_scheduler_dep_q(dep_scheduler);
 	struct xe_tlb_inval_fence *ifence;
 	int err;
 
@@ -121,7 +117,6 @@ xe_tlb_inval_job_create(struct xe_exec_queue *q, struct xe_tlb_inval *tlb_inval,
 	xe_page_reclaim_list_init(&job->prl);
 	job->dep.ops = &dep_job_ops;
 	job->type = type;
-	kref_init(&job->refcount);
 	xe_exec_queue_get(q);	/* Pairs with put in xe_tlb_inval_job_destroy */
 	xe_vm_get(vm);		/* Pairs with put in xe_tlb_inval_job_destroy */
 
@@ -132,8 +127,12 @@ xe_tlb_inval_job_create(struct xe_exec_queue *q, struct xe_tlb_inval *tlb_inval,
 	}
 	job->fence = &ifence->base;
 
-	err = drm_sched_job_init(&job->dep.drm, entity, 1, NULL,
-				 q->xef ? q->xef->drm->client_id : 0);
+	err = drm_dep_job_init(&job->dep.drm,
+			       &(const struct drm_dep_job_init_args){
+					.ops = &xe_tlb_inval_job_dep_ops,
+					.q = dep_q,
+					.credits = 1,
+			       });
 	if (err)
 		goto err_fence;
 
@@ -171,10 +170,10 @@ void xe_tlb_inval_job_add_page_reclaim(struct xe_tlb_inval_job *job,
 	xe_page_reclaim_entries_get(job->prl.entries);
 }
 
-static void xe_tlb_inval_job_destroy(struct kref *ref)
+static void xe_tlb_inval_job_destroy(struct drm_dep_job *drm_job)
 {
-	struct xe_tlb_inval_job *job = container_of(ref, typeof(*job),
-						    refcount);
+	struct xe_tlb_inval_job *job = container_of(drm_job, typeof(*job),
+						    dep.drm);
 	struct xe_tlb_inval_fence *ifence =
 		container_of(job->fence, typeof(*ifence), base);
 	struct xe_exec_queue *q = job->q;
@@ -190,7 +189,6 @@ static void xe_tlb_inval_job_destroy(struct kref *ref)
 		/* Ref from xe_tlb_inval_fence_init */
 		dma_fence_put(job->fence);
 
-	drm_sched_job_cleanup(&job->dep.drm);
 	kfree(job);
 	xe_vm_put(vm);		/* Pairs with get from xe_tlb_inval_job_create */
 	xe_exec_queue_put(q);	/* Pairs with get from xe_tlb_inval_job_create */
@@ -209,11 +207,19 @@ static void xe_tlb_inval_job_destroy(struct kref *ref)
  */
 int xe_tlb_inval_job_alloc_dep(struct xe_tlb_inval_job *job)
 {
-	xe_assert(gt_to_xe(job->q->gt), !xa_load(&job->dep.drm.dependencies, 0));
+	int ret;
+
 	might_alloc(GFP_KERNEL);
 
-	return drm_sched_job_add_dependency(&job->dep.drm,
-					    dma_fence_get_stub());
+	ret = drm_dep_job_add_dependency(&job->dep.drm,
+					 DRM_DEP_JOB_FENCE_PREALLOC);
+	if (ret < 0)
+		return ret;
+
+	/* Assert allocation slot is zero */
+	xe_assert(gt_to_xe(job->q->gt), !ret);
+
+	return 0;
 }
 
 /**
@@ -236,26 +242,14 @@ struct dma_fence *xe_tlb_inval_job_push(struct xe_tlb_inval_job *job,
 {
 	struct xe_tlb_inval_fence *ifence =
 		container_of(job->fence, typeof(*ifence), base);
+	struct dma_fence *stub = dma_fence_get_stub();
 
-	if (!dma_fence_is_signaled(fence)) {
-		void *ptr;
-
-		/*
-		 * Can be in path of reclaim, hence the preallocation of fence
-		 * storage in xe_tlb_inval_job_alloc_dep. Verify caller did
-		 * this correctly.
-		 */
-		xe_assert(gt_to_xe(job->q->gt),
-			  xa_load(&job->dep.drm.dependencies, 0) ==
-			  dma_fence_get_stub());
-
+	if (fence != stub) {
 		dma_fence_get(fence);	/* ref released once dependency processed by scheduler */
-		ptr = xa_store(&job->dep.drm.dependencies, 0, fence,
-			       GFP_ATOMIC);
-		xe_assert(gt_to_xe(job->q->gt), !xa_is_err(ptr));
+		drm_dep_job_replace_dependency(&job->dep.drm, 0, fence);
 	}
+	dma_fence_put(stub);
 
-	xe_tlb_inval_job_get(job);	/* Pairs with put in free_job */
 	job->fence_armed = true;
 
 	/*
@@ -269,17 +263,17 @@ struct dma_fence *xe_tlb_inval_job_push(struct xe_tlb_inval_job *job,
 	xe_tlb_inval_fence_init(job->tlb_inval, ifence, false);
 	dma_fence_get(job->fence);	/* Pairs with put in DRM scheduler */
 
-	drm_sched_job_arm(&job->dep.drm);
+	drm_dep_job_arm(&job->dep.drm);
+	fence = drm_dep_job_finished_fence(&job->dep.drm);
 	/*
 	 * caller ref, get must be done before job push as it could immediately
 	 * signal and free.
 	 */
-	dma_fence_get(&job->dep.drm.s_fence->finished);
-	drm_sched_entity_push_job(&job->dep.drm);
+	dma_fence_get(fence);
+	drm_dep_job_push(&job->dep.drm);
 
 	/* Let the upper layers fish this out */
-	xe_exec_queue_tlb_inval_last_fence_set(job->q, job->vm,
-					       &job->dep.drm.s_fence->finished,
+	xe_exec_queue_tlb_inval_last_fence_set(job->q, job->vm, fence,
 					       job->type);
 
 	xe_migrate_job_unlock(m, job->q);
@@ -290,7 +284,7 @@ struct dma_fence *xe_tlb_inval_job_push(struct xe_tlb_inval_job *job,
 	 * be squashed in dma-resv/DRM scheduler. Instead, we use the DRM scheduler
 	 * context and job's finished fence, which enables squashing.
 	 */
-	return &job->dep.drm.s_fence->finished;
+	return fence;
 }
 
 /**
@@ -301,7 +295,7 @@ struct dma_fence *xe_tlb_inval_job_push(struct xe_tlb_inval_job *job,
  */
 void xe_tlb_inval_job_get(struct xe_tlb_inval_job *job)
 {
-	kref_get(&job->refcount);
+	drm_dep_job_get(&job->dep.drm);
 }
 
 /**
@@ -315,5 +309,5 @@ void xe_tlb_inval_job_get(struct xe_tlb_inval_job *job)
 void xe_tlb_inval_job_put(struct xe_tlb_inval_job *job)
 {
 	if (!IS_ERR_OR_NULL(job))
-		kref_put(&job->refcount, xe_tlb_inval_job_destroy);
+		drm_dep_job_put(&job->dep.drm);
 }
-- 
2.34.1

