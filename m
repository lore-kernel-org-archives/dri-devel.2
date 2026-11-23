Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C0C606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 07:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=B/OyJAJr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2245510E52B;
	Mon, 23 Nov 2026 07:24:08 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E60D710E52B;
 Mon, 23 Nov 2026 07:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795418642; x=1826954642;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=1QJtHObXldPjdUsP3ZiCr6UzWH+6wMrC+omcVBPgEOk=;
 b=B/OyJAJrzE3pUwKR5MJd/6IBpZjHmQV0ipWHnRs9Gx+EpERxk8q7MPmj
 Pg6VXE28iG1EbaoNeH64uWgYymtA3g7R34HYZDgXpdgA2rP9A+RTtONMt
 7Z02u3QEArwxVUvSl3ogHElhUcxJfuwB5XQXleOgO3xKUJhcJ8xlLTEGj
 Nk2My8S9tUorKTjSlTot6E74S1w4PMMCRj/aUPgIIgelEiZx1ALPr43xI
 Q11RRY3XH6MakFDMnIx1gl5JU/IOph/dnZ7dyjj8fdHJZMzYHvx9SXJXz
 H+pL8bXW+MFE4wHR7CmxFe6qBSDLulRUb6Jf5devTYr75uf0L6a5ic0fp A==;
X-CSE-ConnectionGUID: y3CGbWwRReOujChS05LbOQ==
X-CSE-MsgGUID: IgSwu1eAQ/uY9R4vzQzBQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4113475"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4113475"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Nov 2026 23:24:01 -0800
X-CSE-ConnectionGUID: qLsPVETTQBqHfuK0wPrneg==
X-CSE-MsgGUID: 9bS6KkOVRE6z1eR0DXeTyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; d="scan'208";a="11531464"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Nov 2026 23:23:59 -0800
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: rodrigo.vivi@intel.com, matthew.brost@intel.com,
 himal.prasad.ghimiray@intel.com, thomas.hellstrom@linux.intel.com,
 tejas.upadhyay@intel.com
Subject: [PATCH v2] drm/xe: Reset the GT if a CAT error is still pending after
 queue disable
Date: Mon, 23 Nov 2026 12:53:52 +0530
Message-ID: <20261123072352.234965-1-arvind.yadav@intel.com>
X-Mailer: git-send-email 2.43.0
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On BMG, GuC can acknowledge a queue disable after a memory CAT error
on CCS0 without Xe receiving a context-reset notification. The next
queue is enabled, but its job never starts. In the failing run, Xe
resets the GT about 65 seconds later when that queue's disable times
out.

Track the CAT error on native single-context queues and clear it on a
context-reset notification. After pending G2H work finishes, have TDR
request a GT reset if the queue is disabled and the CAT bit is still
set. This also covers a queue that suspend already disabled.

v2:
- Track CAT errors only on single-context queues. Exclude parallel queues,
  multi-queues and SR-IOV VFs.
- Check for a pending CAT even if suspend already disabled the queue.
  Skip the second disable in that case.
- Flush pending G2H work before checking the CAT bit. Skip the check
  if GuC submission has stopped.
- Capture the faulting job before requesting a GT reset, unless the queue
  was killed. Update the warning to report that the CAT is still pending.

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
---
 drivers/gpu/drm/xe/xe_guc_submit.c | 62 +++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
index d76f125f9c3a..a1f18a2e58ff 100644
--- a/drivers/gpu/drm/xe/xe_guc_submit.c
+++ b/drivers/gpu/drm/xe/xe_guc_submit.c
@@ -78,6 +78,7 @@ exec_queue_to_guc(struct xe_exec_queue *q)
 #define EXEC_QUEUE_STATE_WEDGED			(1 << 8)
 #define EXEC_QUEUE_STATE_BANNED			(1 << 9)
 #define EXEC_QUEUE_STATE_PENDING_RESUME		(1 << 10)
+#define EXEC_QUEUE_STATE_CAT_ERROR		(1 << 11)
 
 static bool exec_queue_registered(struct xe_exec_queue *q)
 {
@@ -229,6 +230,31 @@ static void clear_exec_queue_pending_resume(struct xe_exec_queue *q)
 	atomic_and(~EXEC_QUEUE_STATE_PENDING_RESUME, &q->guc->state);
 }
 
+static bool exec_queue_cat_error(struct xe_exec_queue *q)
+{
+	return atomic_read(&q->guc->state) & EXEC_QUEUE_STATE_CAT_ERROR;
+}
+
+static void set_exec_queue_cat_error(struct xe_exec_queue *q)
+{
+	atomic_or(EXEC_QUEUE_STATE_CAT_ERROR, &q->guc->state);
+}
+
+static void clear_exec_queue_cat_error(struct xe_exec_queue *q)
+{
+	atomic_and(~EXEC_QUEUE_STATE_CAT_ERROR, &q->guc->state);
+}
+
+/*
+ * Track one GuC ID so the CAT and reset refer to the same context.
+ * VF recovery can replay a queue with stale CAT state.
+ */
+static bool exec_queue_tracks_cat_error(struct xe_exec_queue *q)
+{
+	return !xe_exec_queue_is_parallel(q) && !xe_exec_queue_is_multi_queue(q) &&
+	       !IS_SRIOV_VF(gt_to_xe(q->gt));
+}
+
 static bool exec_queue_killed_or_banned_or_wedged(struct xe_exec_queue *q)
 {
 	return (atomic_read(&q->guc->state) &
@@ -1605,6 +1631,7 @@ guc_exec_queue_timedout_job(struct drm_sched_job *drm_job)
 	int err = -ETIME;
 	pid_t pid = -1;
 	bool wedged = false, wedge_device = false, skip_timeout_check;
+	u32 state;
 	int idx;
 
 	xe_gt_assert(guc_to_gt(guc), !exec_queue_destroyed(q));
@@ -1705,7 +1732,9 @@ guc_exec_queue_timedout_job(struct drm_sched_job *drm_job)
 			if (!ret || xe_guc_read_stopped(guc))
 				goto trigger_reset;
 
-			disable_scheduling(primary, skip_timeout_check);
+			/* Suspend may have already disabled the faulting queue. */
+			if (exec_queue_enabled(primary) || !exec_queue_cat_error(primary))
+				disable_scheduling(primary, skip_timeout_check);
 		}
 
 		/*
@@ -1739,6 +1768,32 @@ guc_exec_queue_timedout_job(struct drm_sched_job *drm_job)
 		}
 	}
 
+	if (exec_queue_tracks_cat_error(primary) &&
+	    !xe_device_is_in_reset(xe) && !wedged &&
+	    xe_uc_fw_is_running(&guc->fw) && !xe_guc_read_stopped(guc)) {
+		/*
+		 * Check even if suspend disabled the queue before TDR ran.
+		 * Let pending G2H work finish before reading the CAT state.
+		 */
+		flush_work(&guc->ct.g2h_worker);
+
+		/* Leave CAT_ERROR set since the reset request can be skipped. */
+		state = atomic_read(&primary->guc->state);
+		if ((state & EXEC_QUEUE_STATE_CAT_ERROR) &&
+		    !(state & (EXEC_QUEUE_STATE_ENABLED | EXEC_QUEUE_STATE_PENDING_DISABLE))) {
+			xe_gt_warn(guc_to_gt(guc),
+				   "Memory CAT still pending on disabled queue, guc_id=%d",
+				   primary->guc->id);
+			if (!exec_queue_killed(q))
+				xe_devcoredump(primary, job,
+					       "Memory CAT still pending on disabled queue, guc_id=%d",
+					       primary->guc->id);
+			xe_gt_reset_async(primary->gt);
+			xe_sched_tdr_queue_imm(sched);
+			goto rearm;
+		}
+	}
+
 	if (q->vm && q->vm->xef) {
 		process_name = q->vm->xef->process_name;
 		pid = q->vm->xef->pid;
@@ -3517,6 +3572,8 @@ int xe_guc_exec_queue_reset_handler(struct xe_guc *guc, u32 *msg, u32 len)
 
 	trace_xe_exec_queue_reset(q);
 
+	clear_exec_queue_cat_error(q);
+
 	/*
 	 * A banned engine is a NOP at this point (came from
 	 * guc_exec_queue_timedout_job). Otherwise, kick drm scheduler to cancel
@@ -3601,6 +3658,9 @@ int xe_guc_exec_queue_memory_cat_error_handler(struct xe_guc *guc, u32 *msg,
 
 	trace_xe_exec_queue_memory_cat_error(q);
 
+	if (exec_queue_tracks_cat_error(q))
+		set_exec_queue_cat_error(q);
+
 	/* Treat the same as engine reset */
 	xe_guc_exec_queue_reset_trigger_cleanup(q);
 
-- 
2.43.0

