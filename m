Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC873606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=J4ZinkZX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56B1C10EEB3;
	Mon, 16 Nov 2026 10:20:38 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A513F10EEB3;
 Mon, 16 Nov 2026 10:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794824433; x=1826360433;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=nDZ1eEHAMb7Fb5hF/P5TUhGUmhjF/aRmBIAsSvg07Ew=;
 b=J4ZinkZXou2RnZcIGQ+2JV/TW7BxrkA86XE03sFiRW8YhpS6MlMbZPQf
 lM2TklXCXxWXDxwN1DnZvktidDKykBNTytmoHhHQzr1OjWJt1D0GsuPjk
 Gl99hKecyLTGOSPyar0j4+bQKZrNsi/A/yVE6YHmXF3fmJaQ/6q8nPoa7
 C86i12PcK73NWcjE3WnvCvqihLwEQApJzwmq8m3ZmxjbzreNGvq7tNeTc
 foiSbs+4OyifppxlNepl3XbIBsGLszh4ZtYuDVaFaNPiBWEgX6IJGG5Hq
 5gFhGK/9uFNVN+pRYqrpsbXJMhM1grnBnwm1G2M9pQ/HjDjr5BSynfFNw Q==;
X-CSE-ConnectionGUID: 2PFAI/ktQy2u1DTF5/zkLg==
X-CSE-MsgGUID: nqN1cYdTRci19HQPgutXWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3587789"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3587789"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 02:20:33 -0800
X-CSE-ConnectionGUID: 38TXyGK4R+yEsj+ShkSl8g==
X-CSE-MsgGUID: 9i0fN/JWRrK9F1F5GKz+cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; d="scan'208";a="11407830"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 02:20:30 -0800
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: rodrigo.vivi@intel.com, matthew.brost@intel.com,
 himal.prasad.ghimiray@intel.com, thomas.hellstrom@linux.intel.com,
 tejas.upadhyay@intel.com
Subject: [PATCH] drm/xe/guc: Do not trigger TDR from the memory CAT error
 handler
Date: Mon, 16 Nov 2026 15:50:20 +0530
Message-ID: <20261116102020.1567127-1-arvind.yadav@intel.com>
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The memory CAT error handler uses the same cleanup path as the
context-reset handler. This immediately triggers the TDR, which can
send a scheduling-disable request before the context-reset notification
arrives.

On a BMG dGPU, an early disable after a CCS memory CAT error is
associated with subsequent contexts being enabled but never starting
work. Recovery occurs later when a scheduling-disable timeout triggers
a GT reset.

Separate waking user-fence waiters from triggering the TDR. On a memory
CAT notification, mark the queue reset and wake waiters without starting
the TDR. Keep the existing cleanup triggered by the context-reset
notification.

Leave the uncorrectable-error and CGP context-error paths unchanged.

Tested on a BMG dGPU using a standalone SYCL reproducer with two
separate processes.

The first process submits a kernel that reads an unmapped GPU address,
causing a page fault followed by a memory CAT error. It then calls
abort() without waiting for the kernel to finish.

After that process exits, a second process, called "victim", starts.
It submits a simple kernel that writes 7 to a device allocation,
copies the value back to the CPU and checks the result.

Without the patch, the victim can hang and reach its 60-second
userspace timeout. With the patch, the victim completed and returned
the expected value in all tested rounds where the first process triggered
the fault.

Recovery without a context-reset notification still needs confirmation,
particularly for LR queues, which have no normal finite job timeout.
Independent queue-kill and cleanup paths are unchanged.

Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>
Assisted-by: LLM
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
---
 drivers/gpu/drm/xe/xe_guc_submit.c | 50 ++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
index d76f125f9c3a..aa382634a235 100644
--- a/drivers/gpu/drm/xe/xe_guc_submit.c
+++ b/drivers/gpu/drm/xe/xe_guc_submit.c
@@ -557,17 +557,39 @@ static bool vf_recovery(struct xe_guc *guc)
 	return xe_gt_recovery_pending(guc_to_gt(guc));
 }
 
-static void xe_guc_exec_queue_trigger_cleanup(struct xe_exec_queue *q)
+static void xe_guc_exec_queue_wake_ufence(struct xe_exec_queue *q)
 {
 	struct xe_guc *guc = exec_queue_to_guc(q);
 	struct xe_device *xe = guc_to_xe(guc);
 
 	/** to wakeup xe_wait_user_fence ioctl if exec queue is reset */
 	wake_up_all(&xe->ufence_wq);
+}
+
+static void xe_guc_exec_queue_trigger_cleanup(struct xe_exec_queue *q)
+{
+	xe_guc_exec_queue_wake_ufence(q);
 
 	xe_sched_tdr_queue_imm(&q->guc->sched);
 }
 
+/*
+ * Allow callers to wake user-fence waiters without triggering the TDR.
+ * The memory CAT handler uses this to avoid starting cleanup before
+ * the context-reset notification arrives.
+ */
+static void xe_queue_trigger_cleanup_for_reset(struct xe_exec_queue *q,
+					       bool trigger_tdr)
+{
+	if (exec_queue_banned(q))
+		return;
+
+	if (trigger_tdr)
+		xe_guc_exec_queue_trigger_cleanup(q);
+	else
+		xe_guc_exec_queue_wake_ufence(q);
+}
+
 static void xe_guc_exec_queue_group_stop(struct xe_exec_queue *q)
 {
 	struct xe_exec_queue *primary = xe_exec_queue_multi_queue_primary(q);
@@ -653,7 +675,8 @@ static void xe_guc_exec_queue_group_trigger_cleanup(struct xe_exec_queue *q)
 	mutex_unlock(&group->list_lock);
 }
 
-static void xe_guc_exec_queue_reset_trigger_cleanup(struct xe_exec_queue *q)
+static void xe_guc_exec_queue_reset_trigger_cleanup(struct xe_exec_queue *q,
+						    bool trigger_tdr)
 {
 	if (xe_exec_queue_is_multi_queue(q)) {
 		struct xe_exec_queue *primary = xe_exec_queue_multi_queue_primary(q);
@@ -664,20 +687,17 @@ static void xe_guc_exec_queue_reset_trigger_cleanup(struct xe_exec_queue *q)
 		WRITE_ONCE(group->banned, true);
 
 		set_exec_queue_reset(primary);
-		if (!exec_queue_banned(primary))
-			xe_guc_exec_queue_trigger_cleanup(primary);
+		xe_queue_trigger_cleanup_for_reset(primary, trigger_tdr);
 
 		mutex_lock(&group->list_lock);
 		list_for_each_entry(eq, &group->list, multi_queue.link) {
 			set_exec_queue_reset(eq);
-			if (!exec_queue_banned(eq))
-				xe_guc_exec_queue_trigger_cleanup(eq);
+			xe_queue_trigger_cleanup_for_reset(eq, trigger_tdr);
 		}
 		mutex_unlock(&group->list_lock);
 	} else {
 		set_exec_queue_reset(q);
-		if (!exec_queue_banned(q))
-			xe_guc_exec_queue_trigger_cleanup(q);
+		xe_queue_trigger_cleanup_for_reset(q, trigger_tdr);
 	}
 }
 
@@ -3523,7 +3543,7 @@ int xe_guc_exec_queue_reset_handler(struct xe_guc *guc, u32 *msg, u32 len)
 	 * jobs by setting timeout of the job to the minimum value kicking
 	 * guc_exec_queue_timedout_job.
 	 */
-	xe_guc_exec_queue_reset_trigger_cleanup(q);
+	xe_guc_exec_queue_reset_trigger_cleanup(q, true);
 
 	return 0;
 }
@@ -3601,8 +3621,12 @@ int xe_guc_exec_queue_memory_cat_error_handler(struct xe_guc *guc, u32 *msg,
 
 	trace_xe_exec_queue_memory_cat_error(q);
 
-	/* Treat the same as engine reset */
-	xe_guc_exec_queue_reset_trigger_cleanup(q);
+	/*
+	 * Starting the TDR here can send a scheduling-disable request before
+	 * the context-reset notification arrives. Mark the queue reset and
+	 * wake user-fence waiters, leaving that notification to trigger cleanup.
+	 */
+	xe_guc_exec_queue_reset_trigger_cleanup(q, false);
 
 	return 0;
 }
@@ -3644,7 +3668,7 @@ int xe_guc_uncorrectable_error_handler(struct xe_guc *guc, u32 *msg, u32 len)
 	trace_xe_guc_uncorrectable_error(q);
 
 	/* Treat the same as engine reset */
-	xe_guc_exec_queue_reset_trigger_cleanup(q);
+	xe_guc_exec_queue_reset_trigger_cleanup(q, true);
 
 	return 0;
 }
@@ -3696,7 +3720,7 @@ int xe_guc_exec_queue_cgp_context_error_handler(struct xe_guc *guc, u32 *msg,
 	trace_xe_exec_queue_cgp_context_error(q);
 
 	/* Treat the same as engine reset */
-	xe_guc_exec_queue_reset_trigger_cleanup(q);
+	xe_guc_exec_queue_reset_trigger_cleanup(q, true);
 
 	return 0;
 }
-- 
2.43.0

