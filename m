Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B0BD58B22
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 04:33:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F71810E2E7;
	Mon, 16 Mar 2026 04:33:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="KC1hR09m";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB54410E2B9;
 Mon, 16 Mar 2026 04:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773635584; x=1805171584;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gDkdGUZ6RlrFHvsFWZe4X1kXYZUbOuTJfiqjvtkWCtw=;
 b=KC1hR09mAzJif54vBsGbiefjXGj76okp09wcICsD7A9B7j6WbiohazdN
 s3/98627Z4SbBIGY71ozD2edUw3h5klK0Y2UJrNFgUaAUZyI85TeVOFjN
 4lPVnJV5YZ9LKHwSGFRF7S3dtkQqZRk48eNh23sDpoJqZPclRh6OmtifV
 bR2RTL5hqrWh81cHkNYPbDbiglUGacBaZfCdFs+ui8HYOF8iKlY+MnScu
 NBwQEJg3Y/BDnepaT7V7J6+VCcFmwa8TdHaTatUBKBm14HIGwh77KlGKi
 oPyV0LilfvJRT7tWL6MH4W3iQ9cD8vZlRi1xkX1Eus5itznXdhlQe70na Q==;
X-CSE-ConnectionGUID: nGp32uNNQ36dxhym4Bfzfg==
X-CSE-MsgGUID: WtHNCMaMT1ylC0oOXxLWkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="74683497"
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; d="scan'208";a="74683497"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2026 21:33:02 -0700
X-CSE-ConnectionGUID: AxLkY2AATv6DGOQiCy/sMQ==
X-CSE-MsgGUID: +zQxOa5KQBWK6WqsLSQ4Gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; d="scan'208";a="221022168"
Received: from lstrano-desk.jf.intel.com ([10.54.39.91])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2026 21:33:03 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Subject: [RFC PATCH 05/12] drm/xe: Return fence from xe_sched_job_arm and
 adjust job references
Date: Sun, 15 Mar 2026 21:32:48 -0700
Message-Id: <20260316043255.226352-6-matthew.brost@intel.com>
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

Update xe_sched_job_arm to return a fence that the caller can use to
install dma-resv fences, signal syncobjs, or wait for job completion.
The caller is responsible for dropping the fence reference when it is
finished with it.

Update xe_sched_job_push to take a reference to the job owned by the
scheduler. The caller is now responsible for dropping the initial job
creation reference.

These semantics better align with DRM dep semantics.

Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/xe/tests/xe_migrate.c | 10 ++++++----
 drivers/gpu/drm/xe/xe_exec.c          | 12 ++++++------
 drivers/gpu/drm/xe/xe_gsc.c           |  5 +++--
 drivers/gpu/drm/xe/xe_gsc_submit.c    |  5 +++--
 drivers/gpu/drm/xe/xe_gt.c            |  5 +++--
 drivers/gpu/drm/xe/xe_migrate.c       | 25 +++++++++++++++----------
 drivers/gpu/drm/xe/xe_oa.c            |  5 +++--
 drivers/gpu/drm/xe/xe_pxp_submit.c    | 10 ++++++----
 drivers/gpu/drm/xe/xe_sched_job.c     |  5 +++--
 drivers/gpu/drm/xe/xe_sched_job.h     |  2 +-
 10 files changed, 49 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/xe/tests/xe_migrate.c b/drivers/gpu/drm/xe/tests/xe_migrate.c
index 34e2f0f4631f..257b373fcaec 100644
--- a/drivers/gpu/drm/xe/tests/xe_migrate.c
+++ b/drivers/gpu/drm/xe/tests/xe_migrate.c
@@ -50,9 +50,10 @@ static int run_sanity_job(struct xe_migrate *m, struct xe_device *xe,
 		return PTR_ERR(job);
 	}
 
-	xe_sched_job_arm(job);
-	fence = dma_fence_get(&job->drm.s_fence->finished);
+	fence = xe_sched_job_arm(job);
+	dma_fence_get(fence);
 	xe_sched_job_push(job);
+	xe_sched_job_put(job);
 
 	if (sanity_fence_failed(xe, fence, str, test))
 		return -ETIMEDOUT;
@@ -463,10 +464,11 @@ static struct dma_fence *blt_copy(struct xe_tile *tile,
 		xe_sched_job_add_migrate_flush(job, flush_flags);
 
 		mutex_lock(&m->job_mutex);
-		xe_sched_job_arm(job);
 		dma_fence_put(fence);
-		fence = dma_fence_get(&job->drm.s_fence->finished);
+		fence = xe_sched_job_arm(job);
+		dma_fence_get(fence);
 		xe_sched_job_push(job);
+		xe_sched_job_put(job);
 
 		dma_fence_put(m->fence);
 		m->fence = dma_fence_get(fence);
diff --git a/drivers/gpu/drm/xe/xe_exec.c b/drivers/gpu/drm/xe/xe_exec.c
index e05dabfcd43c..0c0ddf500981 100644
--- a/drivers/gpu/drm/xe/xe_exec.c
+++ b/drivers/gpu/drm/xe/xe_exec.c
@@ -124,6 +124,7 @@ int xe_exec_ioctl(struct drm_device *dev, void *data, struct drm_file *file)
 	struct xe_validation_ctx ctx;
 	struct xe_sched_job *job;
 	struct xe_vm *vm;
+	struct dma_fence *fence;
 	bool write_locked;
 	int err = 0;
 	struct xe_hw_engine_group *group;
@@ -320,19 +321,19 @@ int xe_exec_ioctl(struct drm_device *dev, void *data, struct drm_file *file)
 	 * Point of no return, if we error after this point just set an error on
 	 * the job and let the DRM scheduler / backend clean up the job.
 	 */
-	xe_sched_job_arm(job);
+	fence = xe_sched_job_arm(job);
 	if (!xe_vm_in_lr_mode(vm))
-		drm_gpuvm_resv_add_fence(&vm->gpuvm, exec, &job->drm.s_fence->finished,
+		drm_gpuvm_resv_add_fence(&vm->gpuvm, exec, fence,
 					 DMA_RESV_USAGE_BOOKKEEP,
 					 DMA_RESV_USAGE_BOOKKEEP);
 
 	for (i = 0; i < num_syncs; i++) {
-		xe_sync_entry_signal(&syncs[i], &job->drm.s_fence->finished);
+		xe_sync_entry_signal(&syncs[i], fence);
 		xe_sched_job_init_user_fence(job, &syncs[i]);
 	}
 
 	if (!xe_vm_in_lr_mode(vm))
-		xe_exec_queue_last_fence_set(q, vm, &job->drm.s_fence->finished);
+		xe_exec_queue_last_fence_set(q, vm, fence);
 	xe_sched_job_push(job);
 	xe_vm_reactivate_rebind(vm);
 
@@ -349,8 +350,7 @@ int xe_exec_ioctl(struct drm_device *dev, void *data, struct drm_file *file)
 	if (!xe_vm_in_lr_mode(vm))
 		xe_svm_notifier_unlock(vm);
 err_put_job:
-	if (err)
-		xe_sched_job_put(job);
+	xe_sched_job_put(job);
 err_exec:
 	if (!xe_vm_in_lr_mode(vm))
 		xe_validation_ctx_fini(&ctx);
diff --git a/drivers/gpu/drm/xe/xe_gsc.c b/drivers/gpu/drm/xe/xe_gsc.c
index e5c234f3d795..10168c27fc22 100644
--- a/drivers/gpu/drm/xe/xe_gsc.c
+++ b/drivers/gpu/drm/xe/xe_gsc.c
@@ -92,9 +92,10 @@ static int emit_gsc_upload(struct xe_gsc *gsc)
 		return PTR_ERR(job);
 	}
 
-	xe_sched_job_arm(job);
-	fence = dma_fence_get(&job->drm.s_fence->finished);
+	fence = xe_sched_job_arm(job);
+	dma_fence_get(fence);
 	xe_sched_job_push(job);
+	xe_sched_job_put(job);
 
 	timeout = dma_fence_wait_timeout(fence, false, HZ);
 	dma_fence_put(fence);
diff --git a/drivers/gpu/drm/xe/xe_gsc_submit.c b/drivers/gpu/drm/xe/xe_gsc_submit.c
index 08082b596501..2d506fb66017 100644
--- a/drivers/gpu/drm/xe/xe_gsc_submit.c
+++ b/drivers/gpu/drm/xe/xe_gsc_submit.c
@@ -202,9 +202,10 @@ int xe_gsc_pkt_submit_kernel(struct xe_gsc *gsc, u64 addr_in, u32 size_in,
 		return PTR_ERR(job);
 	}
 
-	xe_sched_job_arm(job);
-	fence = dma_fence_get(&job->drm.s_fence->finished);
+	fence = xe_sched_job_arm(job);
+	dma_fence_get(fence);
 	xe_sched_job_push(job);
+	xe_sched_job_put(job);
 
 	timeout = dma_fence_wait_timeout(fence, false, HZ);
 	dma_fence_put(fence);
diff --git a/drivers/gpu/drm/xe/xe_gt.c b/drivers/gpu/drm/xe/xe_gt.c
index 79f4128fe325..10885ba7c2d2 100644
--- a/drivers/gpu/drm/xe/xe_gt.c
+++ b/drivers/gpu/drm/xe/xe_gt.c
@@ -182,9 +182,10 @@ static int emit_job_sync(struct xe_exec_queue *q, struct xe_bb *bb,
 	if (IS_ERR(job))
 		return PTR_ERR(job);
 
-	xe_sched_job_arm(job);
-	fence = dma_fence_get(&job->drm.s_fence->finished);
+	fence = xe_sched_job_arm(job);
+	dma_fence_get(fence);
 	xe_sched_job_push(job);
+	xe_sched_job_put(job);
 
 	timeout = dma_fence_wait_timeout(fence, false, timeout_jiffies);
 	dma_fence_put(fence);
diff --git a/drivers/gpu/drm/xe/xe_migrate.c b/drivers/gpu/drm/xe/xe_migrate.c
index fc918b4fba54..519f7c70abfb 100644
--- a/drivers/gpu/drm/xe/xe_migrate.c
+++ b/drivers/gpu/drm/xe/xe_migrate.c
@@ -1022,10 +1022,11 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
 		}
 
 		mutex_lock(&m->job_mutex);
-		xe_sched_job_arm(job);
 		dma_fence_put(fence);
-		fence = dma_fence_get(&job->drm.s_fence->finished);
+		fence = xe_sched_job_arm(job);
+		dma_fence_get(fence);
 		xe_sched_job_push(job);
+		xe_sched_job_put(job);
 
 		dma_fence_put(m->fence);
 		m->fence = dma_fence_get(fence);
@@ -1438,10 +1439,11 @@ struct dma_fence *xe_migrate_vram_copy_chunk(struct xe_bo *vram_bo, u64 vram_off
 						     DMA_RESV_USAGE_BOOKKEEP));
 
 		scoped_guard(mutex, &m->job_mutex) {
-			xe_sched_job_arm(job);
 			dma_fence_put(fence);
-			fence = dma_fence_get(&job->drm.s_fence->finished);
+			fence = xe_sched_job_arm(job);
+			dma_fence_get(fence);
 			xe_sched_job_push(job);
+			xe_sched_job_put(job);
 
 			dma_fence_put(m->fence);
 			m->fence = dma_fence_get(fence);
@@ -1676,10 +1678,11 @@ struct dma_fence *xe_migrate_clear(struct xe_migrate *m,
 		}
 
 		mutex_lock(&m->job_mutex);
-		xe_sched_job_arm(job);
 		dma_fence_put(fence);
-		fence = dma_fence_get(&job->drm.s_fence->finished);
+		fence = xe_sched_job_arm(job);
+		dma_fence_get(fence);
 		xe_sched_job_push(job);
+		xe_sched_job_put(job);
 
 		dma_fence_put(m->fence);
 		m->fence = dma_fence_get(fence);
@@ -1996,9 +1999,10 @@ __xe_migrate_update_pgtables(struct xe_migrate *m,
 	if (is_migrate)
 		mutex_lock(&m->job_mutex);
 
-	xe_sched_job_arm(job);
-	fence = dma_fence_get(&job->drm.s_fence->finished);
+	fence = xe_sched_job_arm(job);
+	dma_fence_get(fence);
 	xe_sched_job_push(job);
+	xe_sched_job_put(job);
 
 	if (is_migrate)
 		mutex_unlock(&m->job_mutex);
@@ -2282,9 +2286,10 @@ static struct dma_fence *xe_migrate_vram(struct xe_migrate *m,
 	}
 
 	mutex_lock(&m->job_mutex);
-	xe_sched_job_arm(job);
-	fence = dma_fence_get(&job->drm.s_fence->finished);
+	fence = xe_sched_job_arm(job);
+	dma_fence_get(fence);
 	xe_sched_job_push(job);
+	xe_sched_job_put(job);
 
 	dma_fence_put(m->fence);
 	m->fence = dma_fence_get(fence);
diff --git a/drivers/gpu/drm/xe/xe_oa.c b/drivers/gpu/drm/xe/xe_oa.c
index c176a61febb2..8de8952a2ca7 100644
--- a/drivers/gpu/drm/xe/xe_oa.c
+++ b/drivers/gpu/drm/xe/xe_oa.c
@@ -653,9 +653,10 @@ static struct dma_fence *xe_oa_submit_bb(struct xe_oa_stream *stream, enum xe_oa
 		}
 	}
 
-	xe_sched_job_arm(job);
-	fence = dma_fence_get(&job->drm.s_fence->finished);
+	fence = xe_sched_job_arm(job);
+	dma_fence_get(fence);
 	xe_sched_job_push(job);
+	xe_sched_job_put(job);
 
 	xe_oa_unlock_vma(q);
 
diff --git a/drivers/gpu/drm/xe/xe_pxp_submit.c b/drivers/gpu/drm/xe/xe_pxp_submit.c
index e60526e30030..5af384acae82 100644
--- a/drivers/gpu/drm/xe/xe_pxp_submit.c
+++ b/drivers/gpu/drm/xe/xe_pxp_submit.c
@@ -315,9 +315,10 @@ int xe_pxp_submit_session_termination(struct xe_pxp *pxp, u32 id)
 	if (IS_ERR(job))
 		return PTR_ERR(job);
 
-	xe_sched_job_arm(job);
-	fence = dma_fence_get(&job->drm.s_fence->finished);
+	fence = xe_sched_job_arm(job);
+	dma_fence_get(fence);
 	xe_sched_job_push(job);
+	xe_sched_job_put(job);
 
 	timeout = dma_fence_wait_timeout(fence, false, HZ);
 
@@ -378,9 +379,10 @@ static int pxp_pkt_submit(struct xe_exec_queue *q, u64 batch_addr)
 	if (IS_ERR(job))
 		return PTR_ERR(job);
 
-	xe_sched_job_arm(job);
-	fence = dma_fence_get(&job->drm.s_fence->finished);
+	fence = xe_sched_job_arm(job);
+	dma_fence_get(fence);
 	xe_sched_job_push(job);
+	xe_sched_job_put(job);
 
 	timeout = dma_fence_wait_timeout(fence, false, HZ);
 	dma_fence_put(fence);
diff --git a/drivers/gpu/drm/xe/xe_sched_job.c b/drivers/gpu/drm/xe/xe_sched_job.c
index ae5b38b2a884..99f11bb4d2b9 100644
--- a/drivers/gpu/drm/xe/xe_sched_job.c
+++ b/drivers/gpu/drm/xe/xe_sched_job.c
@@ -243,7 +243,7 @@ bool xe_sched_job_completed(struct xe_sched_job *job)
 				     xe_lrc_seqno(lrc));
 }
 
-void xe_sched_job_arm(struct xe_sched_job *job)
+struct dma_fence *xe_sched_job_arm(struct xe_sched_job *job)
 {
 	struct xe_exec_queue *q = job->q;
 	struct dma_fence *fence, *prev;
@@ -288,6 +288,8 @@ void xe_sched_job_arm(struct xe_sched_job *job)
 
 	job->fence = dma_fence_get(fence);	/* Pairs with put in scheduler */
 	drm_sched_job_arm(&job->drm);
+
+	return &job->drm.s_fence->finished;
 }
 
 void xe_sched_job_push(struct xe_sched_job *job)
@@ -295,7 +297,6 @@ void xe_sched_job_push(struct xe_sched_job *job)
 	xe_sched_job_get(job);
 	trace_xe_sched_job_exec(job);
 	drm_sched_entity_push_job(&job->drm);
-	xe_sched_job_put(job);
 }
 
 /**
diff --git a/drivers/gpu/drm/xe/xe_sched_job.h b/drivers/gpu/drm/xe/xe_sched_job.h
index 1c1cb44216c3..a39cc4ab980b 100644
--- a/drivers/gpu/drm/xe/xe_sched_job.h
+++ b/drivers/gpu/drm/xe/xe_sched_job.h
@@ -55,7 +55,7 @@ static inline bool xe_sched_job_is_error(struct xe_sched_job *job)
 bool xe_sched_job_started(struct xe_sched_job *job);
 bool xe_sched_job_completed(struct xe_sched_job *job);
 
-void xe_sched_job_arm(struct xe_sched_job *job);
+struct dma_fence *xe_sched_job_arm(struct xe_sched_job *job);
 void xe_sched_job_push(struct xe_sched_job *job);
 
 void xe_sched_job_init_user_fence(struct xe_sched_job *job,
-- 
2.34.1

