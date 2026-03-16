Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E218CD58B36
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 04:33:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CB4E10E2EA;
	Mon, 16 Mar 2026 04:33:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="K8nc9RI4";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57C4410E2B9;
 Mon, 16 Mar 2026 04:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773635584; x=1805171584;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OMcz0XOC+XH7eTvVe8ohp0e+d9uP2/DqWhnoeW8G4TA=;
 b=K8nc9RI4hix2sIoJtsxf9pTVD+q2xHi5HoDjaSGq0e/I3AA6ywZfWdIy
 hqLj5GMLNBx+OWYbGq6cIxyscrYhRo3s6PuqOpWZZlSmeR31NdIdlatw7
 bvb3Ly+2Rq8ZJcF/vVyI2JMBaxIQ5jy+Sk+ykh7SXMSvY4lB4P9iu7bc4
 u8MZ2EXY5l20VRQRH7LzUahQGRlNQlprS1V0y+G3GvoltoupCtkyDi60z
 g6e41uMbx9DYKyzKj/sccnz1A95VUpX2InlxbUny4ORTu88MQUPeE6Ko7
 Gro/kuBHFP9Rtq6NR3qwwl/Xc4650MBq4hqM99liWgs/0MSFaig87w+6N g==;
X-CSE-ConnectionGUID: pMk/o5akRXaDMkRwYBLryQ==
X-CSE-MsgGUID: r4y6h+uISayfCnEhNhxGCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="74683513"
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; d="scan'208";a="74683513"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2026 21:33:03 -0700
X-CSE-ConnectionGUID: mqX5rPc8Rd6xkoeUobhw4w==
X-CSE-MsgGUID: ahjb3cKcRQOGfoCx8XnLAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; d="scan'208";a="221022173"
Received: from lstrano-desk.jf.intel.com ([10.54.39.91])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2026 21:33:03 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Subject: [RFC PATCH 09/12] drm/xe: Enable IRQ job put in DRM dep
Date: Sun, 15 Mar 2026 21:32:52 -0700
Message-Id: <20260316043255.226352-10-matthew.brost@intel.com>
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

Enable IRQ-context job puts in DRM dep now that all required support is
in place. Set this flag unconditionally on all drm_dep_queue instances
and update the kernel-doc for functions that can now be called from IRQ
context.

Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/xe/xe_exec_queue.c | 2 ++
 drivers/gpu/drm/xe/xe_guc_submit.c | 3 ++-
 drivers/gpu/drm/xe/xe_sched_job.c  | 2 ++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_exec_queue.c b/drivers/gpu/drm/xe/xe_exec_queue.c
index b34af4594512..3aeba2fd7963 100644
--- a/drivers/gpu/drm/xe/xe_exec_queue.c
+++ b/drivers/gpu/drm/xe/xe_exec_queue.c
@@ -575,6 +575,8 @@ ALLOW_ERROR_INJECTION(xe_exec_queue_create_bind, ERRNO);
  *
  * Called when the last reference to the exec queue is dropped.
  * Starts the cleanup process for an exec queue.
+ *
+ * Context: Any context.
  */
 void xe_exec_queue_destroy(struct xe_exec_queue *q)
 {
diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
index af54ac9d5607..064cf15166b9 100644
--- a/drivers/gpu/drm/xe/xe_guc_submit.c
+++ b/drivers/gpu/drm/xe/xe_guc_submit.c
@@ -1935,7 +1935,8 @@ static int guc_exec_queue_init(struct xe_exec_queue *q)
 	struct xe_guc *guc = exec_queue_to_guc(q);
 	struct workqueue_struct *submit_wq = NULL;
 	struct xe_guc_exec_queue *ge;
-	enum drm_dep_queue_flags flags = DRM_DEP_QUEUE_FLAGS_BYPASS_SUPPORTED;
+	enum drm_dep_queue_flags flags = DRM_DEP_QUEUE_FLAGS_BYPASS_SUPPORTED |
+		DRM_DEP_QUEUE_FLAGS_JOB_PUT_IRQ_SAFE;
 	long timeout;
 	int err, i;
 
diff --git a/drivers/gpu/drm/xe/xe_sched_job.c b/drivers/gpu/drm/xe/xe_sched_job.c
index d83f0f9ea4ab..e3f7251b35b5 100644
--- a/drivers/gpu/drm/xe/xe_sched_job.c
+++ b/drivers/gpu/drm/xe/xe_sched_job.c
@@ -175,6 +175,8 @@ struct xe_sched_job *xe_sched_job_create(struct xe_exec_queue *q,
  *
  * Called when ref == 0, drop a reference to job's xe_engine + fence, cleanup
  * and free memory for Xe schedule job.
+ *
+ * Context: Any context.
  */
 static void xe_sched_job_release(struct drm_dep_job *dep_job)
 {
-- 
2.34.1

