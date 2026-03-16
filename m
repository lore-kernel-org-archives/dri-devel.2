Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E8FD58B09
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 04:33:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FDE010E2E3;
	Mon, 16 Mar 2026 04:33:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Gabxdkds";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58F2710E2C3;
 Mon, 16 Mar 2026 04:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773635584; x=1805171584;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=z++PGC/FXktqPvVjVRff7TZcuOaJP8YgWFc1s8BhUEk=;
 b=GabxdkdsZqggbIrhSz8AaX4uQvOlppM765E0KDcTYzjQFq6V196S9xPK
 Nh76cOQv6rVVNlZuN6RHUiLvZYGu2jKbPLo2kp9lQFWdiC+/wcxbzYmpy
 GeIStz3bMPzv/19//afRPMq6k9n4k7COZe7jewiUEY+5Mao4VstTl6Ht0
 vwnBl4IZJqvAKpIDKhn3x9JolQUDYsj333Q1xUFnFmidB0fHwtooUL8cK
 5nwIbrHhueG4mhCixb9LE4jTPKPBMp0QUEFit1VIq5jLfpgR65sdsqSwH
 A4atVYfn/MzoY/J3DYz04tiTzQaGJvc5ruXlHZMdmXJ2YkSnplKxJQB6u A==;
X-CSE-ConnectionGUID: y4h9yL4+Rg6IJVbqDqVSSw==
X-CSE-MsgGUID: QwQV6r7gRPOphz3zUVZcqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="74683514"
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; d="scan'208";a="74683514"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2026 21:33:03 -0700
X-CSE-ConnectionGUID: UEjOGl5KQrCqdUJqVNqM3g==
X-CSE-MsgGUID: Wq3b9PKwQASEijtKs3ikdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; d="scan'208";a="221022174"
Received: from lstrano-desk.jf.intel.com ([10.54.39.91])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2026 21:33:03 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Subject: [RFC PATCH 10/12] drm/xe: Use DRM dep queue kill semantics
Date: Sun, 15 Mar 2026 21:32:53 -0700
Message-Id: <20260316043255.226352-11-matthew.brost@intel.com>
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

Once the GuC context has its scheduling disabled by TDR or kill work
item, the queue is taken off the hardware and can no longer touch memory
without risking corruption. Invoke drm_dep_queue_kill, which bypasses
any remaining job dependencies in the queue and calls run_job
immediately for each remaining job. In run_job, if the queue returns
drm_dep_queue_is_killed, immediately signal the hardware fence, as the
queue can no longer access any memory associated with the fence being
signaled.

Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/xe/xe_guc_exec_queue_types.h |   2 +
 drivers/gpu/drm/xe/xe_guc_submit.c           | 139 +++++++++++++------
 2 files changed, 97 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_exec_queue_types.h b/drivers/gpu/drm/xe/xe_guc_exec_queue_types.h
index cb15e86823d2..72de6d0a754a 100644
--- a/drivers/gpu/drm/xe/xe_guc_exec_queue_types.h
+++ b/drivers/gpu/drm/xe/xe_guc_exec_queue_types.h
@@ -29,6 +29,8 @@ struct xe_guc_exec_queue {
 	 */
 #define MAX_STATIC_MSG_TYPE	3
 	struct xe_sched_msg static_msgs[MAX_STATIC_MSG_TYPE];
+	/** @kill_work: Kill work item */
+	struct delayed_work kill_work;
 	/** @resume_time: time of last resume */
 	u64 resume_time;
 	/** @state: GuC specific state for this xe_exec_queue */
diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
index 064cf15166b9..58569969b4c7 100644
--- a/drivers/gpu/drm/xe/xe_guc_submit.c
+++ b/drivers/gpu/drm/xe/xe_guc_submit.c
@@ -1216,6 +1216,8 @@ guc_exec_queue_run_job(struct drm_dep_job *drm_job)
 	trace_xe_sched_job_run(job);
 
 	if (!killed_or_banned_or_wedged && !xe_sched_job_is_error(job)) {
+		xe_gt_assert(guc_to_gt(guc), !drm_dep_queue_is_killed(&q->dep_q));
+
 		if (xe_exec_queue_is_multi_queue_secondary(q)) {
 			struct xe_exec_queue *primary = xe_exec_queue_multi_queue_primary(q);
 
@@ -1234,6 +1236,15 @@ guc_exec_queue_run_job(struct drm_dep_job *drm_job)
 			q->ring_ops->emit_job(job);
 		submit_exec_queue(q, job);
 		job->restore_replay = false;
+	} else if (drm_dep_queue_is_killed(&q->dep_q)) {
+		xe_sched_job_set_error(job, -ECANCELED); /* fence signal */
+		dma_fence_put(job->fence); /* drop the DRM dep reference */
+
+		/*
+		 * Our queue is off hardware, so fences can be signalled
+		 * immediately with an error.
+		 */
+		return ERR_PTR(-ECANCELED);
 	}
 
 run_job_out:
@@ -1479,29 +1490,21 @@ static void disable_scheduling(struct xe_exec_queue *q, bool immediate)
 }
 
 static enum drm_dep_timedout_stat
-guc_exec_queue_timedout_job(struct drm_dep_job *drm_job)
+__guc_exec_queue_timedout_job(struct xe_guc *guc, struct xe_exec_queue *q,
+			      struct xe_sched_job *job)
 {
-	struct xe_sched_job *job = to_xe_sched_job(drm_job);
 	struct drm_dep_job *tmp_job;
-	struct xe_exec_queue *q = job->q, *primary;
+	struct xe_exec_queue *primary = xe_exec_queue_multi_queue_primary(q);
 	struct xe_gpu_scheduler *sched = &q->guc->sched;
-	struct xe_guc *guc = exec_queue_to_guc(q);
 	const char *process_name = "no process";
 	struct xe_device *xe = guc_to_xe(guc);
 	int err = -ETIME;
 	pid_t pid = -1;
 	bool wedged = false, skip_timeout_check;
 
-	xe_gt_assert(guc_to_gt(guc), !exec_queue_destroyed(q));
-
-	if (drm_dep_job_is_finished(&job->drm))
-		return DRM_DEP_TIMEDOUT_STAT_JOB_SIGNALED;
-
 	if (vf_recovery(guc))
 		return DRM_DEP_TIMEDOUT_STAT_REQUEUE_JOB;
 
-	primary = xe_exec_queue_multi_queue_primary(q);
-
 	/* Kill the run_job entry point */
 	if (xe_exec_queue_is_multi_queue(q))
 		xe_guc_exec_queue_group_stop(q);
@@ -1509,7 +1512,7 @@ guc_exec_queue_timedout_job(struct drm_dep_job *drm_job)
 		xe_sched_submission_stop(sched);
 
 	/* Must check all state after stopping scheduler */
-	skip_timeout_check = exec_queue_reset(q) ||
+	skip_timeout_check = !job || exec_queue_reset(q) ||
 		exec_queue_killed_or_banned_or_wedged(q);
 
 	/* Skip timeout check if multi-queue group is banned */
@@ -1603,43 +1606,45 @@ guc_exec_queue_timedout_job(struct drm_dep_job *drm_job)
 		}
 	}
 
-	if (q->vm && q->vm->xef) {
-		process_name = q->vm->xef->process_name;
-		pid = q->vm->xef->pid;
-	}
+	if (job) {
+		if (q->vm && q->vm->xef) {
+			process_name = q->vm->xef->process_name;
+			pid = q->vm->xef->pid;
+		}
 
-	if (!exec_queue_killed(q))
-		xe_gt_notice(guc_to_gt(guc),
-			     "Timedout job: seqno=%u, lrc_seqno=%u, guc_id=%d, flags=0x%lx in %s [%d]",
-			     xe_sched_job_seqno(job), xe_sched_job_lrc_seqno(job),
-			     q->guc->id, q->flags, process_name, pid);
+		if (!exec_queue_killed(q))
+			xe_gt_notice(guc_to_gt(guc),
+				     "Timedout job: seqno=%u, lrc_seqno=%u, guc_id=%d, flags=0x%lx in %s [%d]",
+				     xe_sched_job_seqno(job), xe_sched_job_lrc_seqno(job),
+				     q->guc->id, q->flags, process_name, pid);
 
-	trace_xe_sched_job_timedout(job);
+		trace_xe_sched_job_timedout(job);
 
-	if (!exec_queue_killed(q))
-		xe_devcoredump(q, job,
-			       "Timedout job - seqno=%u, lrc_seqno=%u, guc_id=%d, flags=0x%lx",
-			       xe_sched_job_seqno(job), xe_sched_job_lrc_seqno(job),
-			       q->guc->id, q->flags);
+		if (!exec_queue_killed(q))
+			xe_devcoredump(q, job,
+				       "Timedout job - seqno=%u, lrc_seqno=%u, guc_id=%d, flags=0x%lx",
+				       xe_sched_job_seqno(job), xe_sched_job_lrc_seqno(job),
+				       q->guc->id, q->flags);
 
-	/*
-	 * Kernel jobs should never fail, nor should VM jobs if they do
-	 * somethings has gone wrong and the GT needs a reset
-	 */
-	xe_gt_WARN(q->gt, q->flags & EXEC_QUEUE_FLAG_KERNEL,
-		   "Kernel-submitted job timed out\n");
-	xe_gt_WARN(q->gt, q->flags & EXEC_QUEUE_FLAG_VM && !exec_queue_killed(q),
-		   "VM job timed out on non-killed execqueue\n");
-	if (!wedged && (q->flags & EXEC_QUEUE_FLAG_KERNEL ||
-			(q->flags & EXEC_QUEUE_FLAG_VM && !exec_queue_killed(q)))) {
-		if (!xe_sched_invalidate_job(job, 2))
-			xe_gt_reset_async(q->gt);
-	}
+		/*
+		 * Kernel jobs should never fail, nor should VM jobs if they do
+		 * somethings has gone wrong and the GT needs a reset
+		 */
+		xe_gt_WARN(q->gt, q->flags & EXEC_QUEUE_FLAG_KERNEL,
+			   "Kernel-submitted job timed out\n");
+		xe_gt_WARN(q->gt, q->flags & EXEC_QUEUE_FLAG_VM && !exec_queue_killed(q),
+			   "VM job timed out on non-killed execqueue\n");
+		if (!wedged && (q->flags & EXEC_QUEUE_FLAG_KERNEL ||
+				(q->flags & EXEC_QUEUE_FLAG_VM && !exec_queue_killed(q)))) {
+			if (!xe_sched_invalidate_job(job, 2))
+				xe_gt_reset_async(q->gt);
+		}
 
-	/* Mark all outstanding jobs as bad, thus completing them */
-	xe_sched_job_set_error(job, err);
-	drm_dep_queue_for_each_pending_job(tmp_job, sched->dep_q)
-		xe_sched_job_set_error(to_xe_sched_job(tmp_job), -ECANCELED);
+		/* Mark all outstanding jobs as bad, thus completing them */
+		xe_sched_job_set_error(job, err);
+		drm_dep_queue_for_each_pending_job(tmp_job, sched->dep_q)
+			xe_sched_job_set_error(to_xe_sched_job(tmp_job), -ECANCELED);
+	}
 
 	if (xe_exec_queue_is_multi_queue(q)) {
 		xe_guc_exec_queue_group_start(q);
@@ -1649,6 +1654,10 @@ guc_exec_queue_timedout_job(struct drm_dep_job *drm_job)
 		xe_guc_exec_queue_trigger_cleanup(q);
 	}
 
+	/* Queue is off hardware; start flushing jobs bypassing dependencies. */
+	drm_dep_queue_kill(&q->dep_q);
+	cancel_delayed_work(&q->guc->kill_work);
+
 	return DRM_DEP_TIMEDOUT_STAT_REQUEUE_JOB;
 
 rearm:
@@ -1665,6 +1674,43 @@ guc_exec_queue_timedout_job(struct drm_dep_job *drm_job)
 	return DRM_DEP_TIMEDOUT_STAT_REQUEUE_JOB;
 }
 
+static enum drm_dep_timedout_stat
+guc_exec_queue_timedout_job(struct drm_dep_job *drm_job)
+{
+	struct xe_sched_job *job = to_xe_sched_job(drm_job);
+	struct xe_exec_queue *q = job->q;
+	struct xe_guc *guc = exec_queue_to_guc(q);
+
+	xe_gt_assert(guc_to_gt(guc), !exec_queue_destroyed(q));
+
+	if (drm_dep_job_is_finished(&job->drm))
+		return DRM_DEP_TIMEDOUT_STAT_JOB_SIGNALED;
+
+	return __guc_exec_queue_timedout_job(guc, q, job);
+}
+
+static void guc_exec_queue_kill_work_func(struct work_struct *w)
+{
+	struct xe_guc_exec_queue *ge =
+		container_of(w, typeof(*ge), kill_work.work);
+	struct xe_exec_queue *q = ge->q;
+	struct xe_exec_queue *primary = xe_exec_queue_multi_queue_primary(q);
+	struct xe_guc *guc = exec_queue_to_guc(q);
+
+	xe_gt_assert(guc_to_gt(guc), exec_queue_killed(q));
+
+	if (drm_dep_queue_is_killed(&q->dep_q))
+		return;
+
+	if (!(exec_queue_enabled(primary) ||
+	      exec_queue_pending_disable(primary))) {
+		drm_dep_queue_kill(&q->dep_q);
+		return;
+	}
+
+	__guc_exec_queue_timedout_job(guc, q, NULL);
+}
+
 static void guc_exec_queue_fini(struct xe_exec_queue *q)
 {
 	struct xe_guc_exec_queue *ge = q->guc;
@@ -1915,6 +1961,7 @@ static void guc_dep_queue_fini(struct drm_dep_queue *dep_q)
 {
 	struct xe_exec_queue *q = container_of(dep_q, typeof(*q), dep_q);
 
+	cancel_delayed_work(&q->guc->kill_work);
 	xe_exec_queue_destroy(q);
 }
 
@@ -1949,6 +1996,7 @@ static int guc_exec_queue_init(struct xe_exec_queue *q)
 	q->guc = ge;
 	ge->q = q;
 	init_waitqueue_head(&ge->suspend_wait);
+	INIT_DELAYED_WORK(&ge->kill_work, guc_exec_queue_kill_work_func);
 
 	for (i = 0; i < MAX_STATIC_MSG_TYPE; ++i)
 		INIT_LIST_HEAD(&ge->static_msgs[i].link);
@@ -2028,6 +2076,9 @@ static void guc_exec_queue_kill(struct xe_exec_queue *q)
 	set_exec_queue_killed(q);
 	__suspend_fence_signal(q);
 	xe_guc_exec_queue_trigger_cleanup(q);
+
+	mod_delayed_work(drm_dep_queue_timeout_wq(&q->dep_q),
+			 &q->guc->kill_work, 2);
 }
 
 static void guc_exec_queue_add_msg(struct xe_exec_queue *q, struct xe_sched_msg *msg,
-- 
2.34.1

