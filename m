Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14461D58B21
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 04:33:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED69810E2E5;
	Mon, 16 Mar 2026 04:33:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Efx9ACEv";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3281310E2C9;
 Mon, 16 Mar 2026 04:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773635584; x=1805171584;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TQPFk+XEr00ha4gOt4DmZEuY/4glcJvIImKcMRCFwkI=;
 b=Efx9ACEvFwCWO96t8IyBOE/4hynDHDQz1uW2cCzphHWgyBoHZRbzxqeL
 ARN8A4AOtaeni7aMeddJxky8ZUb230It4VjHLverXrftr9St7CHeOzBcw
 MaQuTL1F6q6IbGiuuiYZnUKEDsLttkpzkSi+zAgvIoAGxbFp7BnR4IuOE
 QD7iSbxifWvkyCnJkrQS1Fidn82JIIdhJcUm56cvixKza+M9TkL7t2nle
 nnXBDEFMBW8Ek/NcabJZHKAHl6DshJmhK9XHsOuEszYj5Maih3llBVynN
 Ek/O1vbxq05cCperSPHx23xbO2Trui/a2YBD+/WAqz0otUZQ3wkEUJdx3 g==;
X-CSE-ConnectionGUID: Y4p/V5DxTrKR0jHqnJridg==
X-CSE-MsgGUID: eR3YT6INTBaC56DR6wWmQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="74683511"
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; d="scan'208";a="74683511"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2026 21:33:03 -0700
X-CSE-ConnectionGUID: ig76+7YxTACHPulbBexbWw==
X-CSE-MsgGUID: Q3OBA+ulQ8akCgJAHmmQjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; d="scan'208";a="221022170"
Received: from lstrano-desk.jf.intel.com ([10.54.39.91])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2026 21:33:03 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Subject: [RFC PATCH 07/12] drm/xe: Make scheduler message lock IRQ-safe
Date: Sun, 15 Mar 2026 21:32:50 -0700
Message-Id: <20260316043255.226352-8-matthew.brost@intel.com>
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

Make message enqueuing safe in IRQ context by converting the scheduler
message lock to an IRQ-safe guard.

Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/xe/xe_gpu_scheduler.c | 28 +++++++++++++--------------
 drivers/gpu/drm/xe/xe_gpu_scheduler.h | 17 ++++++++--------
 drivers/gpu/drm/xe/xe_guc_submit.c    | 23 ++++++++++------------
 3 files changed, 32 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_gpu_scheduler.c b/drivers/gpu/drm/xe/xe_gpu_scheduler.c
index a8e6384dffe8..14c1b8df439f 100644
--- a/drivers/gpu/drm/xe/xe_gpu_scheduler.c
+++ b/drivers/gpu/drm/xe/xe_gpu_scheduler.c
@@ -14,11 +14,12 @@ static void xe_sched_process_msg_queue_if_ready(struct xe_gpu_scheduler *sched)
 {
 	struct xe_sched_msg *msg;
 
-	xe_sched_msg_lock(sched);
-	msg = list_first_entry_or_null(&sched->msgs, struct xe_sched_msg, link);
-	if (msg)
-		xe_sched_process_msg_queue(sched);
-	xe_sched_msg_unlock(sched);
+	xe_sched_msg_scoped_guard(sched) {
+		msg = list_first_entry_or_null(&sched->msgs,
+					       struct xe_sched_msg, link);
+		if (msg)
+			xe_sched_process_msg_queue(sched);
+	}
 }
 
 static struct xe_sched_msg *
@@ -26,12 +27,12 @@ xe_sched_get_msg(struct xe_gpu_scheduler *sched)
 {
 	struct xe_sched_msg *msg;
 
-	xe_sched_msg_lock(sched);
-	msg = list_first_entry_or_null(&sched->msgs,
-				       struct xe_sched_msg, link);
-	if (msg)
-		list_del_init(&msg->link);
-	xe_sched_msg_unlock(sched);
+	xe_sched_msg_scoped_guard(sched) {
+		msg = list_first_entry_or_null(&sched->msgs,
+					       struct xe_sched_msg, link);
+		if (msg)
+			list_del_init(&msg->link);
+	}
 
 	return msg;
 }
@@ -108,9 +109,8 @@ void xe_sched_submission_resume_tdr(struct xe_gpu_scheduler *sched)
 void xe_sched_add_msg(struct xe_gpu_scheduler *sched,
 		      struct xe_sched_msg *msg)
 {
-	xe_sched_msg_lock(sched);
-	xe_sched_add_msg_locked(sched, msg);
-	xe_sched_msg_unlock(sched);
+	xe_sched_msg_scoped_guard(sched)
+		xe_sched_add_msg_locked(sched, msg);
 }
 
 void xe_sched_add_msg_locked(struct xe_gpu_scheduler *sched,
diff --git a/drivers/gpu/drm/xe/xe_gpu_scheduler.h b/drivers/gpu/drm/xe/xe_gpu_scheduler.h
index 4086aafb0a9a..71c060398be6 100644
--- a/drivers/gpu/drm/xe/xe_gpu_scheduler.h
+++ b/drivers/gpu/drm/xe/xe_gpu_scheduler.h
@@ -31,15 +31,14 @@ void xe_sched_add_msg_locked(struct xe_gpu_scheduler *sched,
 void xe_sched_add_msg_head(struct xe_gpu_scheduler *sched,
 			   struct xe_sched_msg *msg);
 
-static inline void xe_sched_msg_lock(struct xe_gpu_scheduler *sched)
-{
-	spin_lock(&sched->msg_lock);
-}
-
-static inline void xe_sched_msg_unlock(struct xe_gpu_scheduler *sched)
-{
-	spin_unlock(&sched->msg_lock);
-}
+/**
+ * xe_sched_msg_scoped_guard() - Scoped guard for scheduler message lock
+ * @__sched: xe_gpu_scheduler object
+ *
+ * IRQ-safe scoped guard for scheduler message lock
+ */
+#define xe_sched_msg_scoped_guard(__sched)	\
+	scoped_guard(spinlock_irqsave, &(__sched)->msg_lock)
 
 static inline void xe_sched_tdr_queue_imm(struct xe_gpu_scheduler *sched)
 {
diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
index fc9704fad177..2f91902bd2cb 100644
--- a/drivers/gpu/drm/xe/xe_guc_submit.c
+++ b/drivers/gpu/drm/xe/xe_guc_submit.c
@@ -2183,10 +2183,10 @@ static int guc_exec_queue_suspend(struct xe_exec_queue *q)
 	if (exec_queue_killed_or_banned_or_wedged(q))
 		return -EINVAL;
 
-	xe_sched_msg_lock(sched);
-	if (guc_exec_queue_try_add_msg(q, msg, SUSPEND))
-		q->guc->suspend_pending = true;
-	xe_sched_msg_unlock(sched);
+	xe_sched_msg_scoped_guard(sched) {
+		if (guc_exec_queue_try_add_msg(q, msg, SUSPEND))
+			q->guc->suspend_pending = true;
+	}
 
 	return 0;
 }
@@ -2242,9 +2242,8 @@ static void guc_exec_queue_resume(struct xe_exec_queue *q)
 
 	xe_gt_assert(guc_to_gt(guc), !q->guc->suspend_pending);
 
-	xe_sched_msg_lock(sched);
-	guc_exec_queue_try_add_msg(q, msg, RESUME);
-	xe_sched_msg_unlock(sched);
+	xe_sched_msg_scoped_guard(sched)
+		guc_exec_queue_try_add_msg(q, msg, RESUME);
 }
 
 static bool guc_exec_queue_reset_status(struct xe_exec_queue *q)
@@ -2666,9 +2665,8 @@ static void guc_exec_queue_replay_pending_state_change(struct xe_exec_queue *q)
 	if (q->guc->needs_suspend) {
 		msg = q->guc->static_msgs + STATIC_MSG_SUSPEND;
 
-		xe_sched_msg_lock(sched);
-		guc_exec_queue_try_add_msg_head(q, msg, SUSPEND);
-		xe_sched_msg_unlock(sched);
+		xe_sched_msg_scoped_guard(sched)
+			guc_exec_queue_try_add_msg_head(q, msg, SUSPEND);
 
 		q->guc->needs_suspend = false;
 	}
@@ -2681,9 +2679,8 @@ static void guc_exec_queue_replay_pending_state_change(struct xe_exec_queue *q)
 	if (q->guc->needs_resume) {
 		msg = q->guc->static_msgs + STATIC_MSG_RESUME;
 
-		xe_sched_msg_lock(sched);
-		guc_exec_queue_try_add_msg_head(q, msg, RESUME);
-		xe_sched_msg_unlock(sched);
+		xe_sched_msg_scoped_guard(sched)
+			guc_exec_queue_try_add_msg_head(q, msg, RESUME);
 
 		q->guc->needs_resume = false;
 	}
-- 
2.34.1

