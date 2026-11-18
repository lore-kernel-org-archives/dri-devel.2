Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7403D606A325
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 21:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=oIYRiooi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB00811205F;
	Wed, 18 Nov 2026 21:46:53 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 938C411204D;
 Wed, 18 Nov 2026 21:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795038399; x=1826574399;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wHNshQzII2/OtMfL3lK+KZLUybaokaed7U5BZoiay4c=;
 b=oIYRiooiKKgmL3DWZ+gafZyyVD60zk63Xw2vy+T4ynvOla7n+RuDOsPL
 fO8eGMffArf8fqf3GSTx5HGnpW1LsHVUBkLtyYZLeelswNyppNXtfBAWo
 XDJTKOcAxQATv5+DBjubLv7zH9sOW+c7yGt4E71IvQDr8GTLN/K5RNkM9
 J8Pqhb0ETq1HQK+cE0nsfM54GjCFSrqRf0u8H1FhupIz5e7RpJR52YnSR
 bYkWmPAsYHJY20Za3dqiJJ93DL0NiP+Pt2QOxSXcnyHArASfWD0N07Ipm
 YCDGdW7vhrImtTxz230wLyIp9o8KzV4B0lbWFYNxAwVFK6LjNh5RakdW6 w==;
X-CSE-ConnectionGUID: yjx7ZIysSiigSLY1q9zCLg==
X-CSE-MsgGUID: bmFjo5t7S8G+MV3o/r2zeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3788561"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3788561"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 13:46:38 -0800
X-CSE-ConnectionGUID: E+s4TflUSk+q5Qi21yewmw==
X-CSE-MsgGUID: mbUXjM8QSHi9QBa9cendxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="10258548"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.16])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 13:46:37 -0800
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: Alessio Belle <alessio.belle@imgtec.com>,
 Luigi Santivetti <luigi.santivetti@imgtec.com>,
 imagination@lists.freedesktop.org
Subject: [PATCH v4 14/20] drm/imagination: Use rcu_access_pointer() for
 dma_fence::ops
Date: Wed, 18 Nov 2026 23:45:11 +0200
Message-ID: <20261118214518.29317-15-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118214518.29317-1-ville.syrjala@linux.intel.com>
References: <20261118214518.29317-1-ville.syrjala@linux.intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

dma_fence::ops is annotated __rcu, but the driver compares and
tests it directly. That makes sparse complain about comparing
pointers from different address spaces. The driver only uses the
pointer to identify the kind of fence and never dereferences it,
so use rcu_access_pointer() for those checks, as dma-fence.h does
for its own identity checks.

No functional change.

Cc: Alessio Belle <alessio.belle@imgtec.com>
Cc: Luigi Santivetti <luigi.santivetti@imgtec.com>
Cc: imagination@lists.freedesktop.org
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/imagination/pvr_ccb.c   |  5 +++--
 drivers/gpu/drm/imagination/pvr_queue.c | 17 +++++++++--------
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_ccb.c b/drivers/gpu/drm/imagination/pvr_ccb.c
index e408df74853d..92f041b4208a 100644
--- a/drivers/gpu/drm/imagination/pvr_ccb.c
+++ b/drivers/gpu/drm/imagination/pvr_ccb.c
@@ -18,6 +18,7 @@
 #include <linux/kernel.h>
 #include <linux/mutex.h>
 #include <linux/overflow.h>
+#include <linux/rcupdate.h>
 #include <linux/types.h>
 #include <linux/workqueue.h>
 
@@ -608,10 +609,10 @@ void pvr_kccb_fence_put(struct dma_fence *fence)
 	if (!fence)
 		return;
 
-	if (!fence->ops) {
+	if (!rcu_access_pointer(fence->ops)) {
 		dma_fence_free(fence);
 	} else {
-		WARN_ON(fence->ops != &pvr_kccb_fence_ops);
+		WARN_ON(rcu_access_pointer(fence->ops) != &pvr_kccb_fence_ops);
 		dma_fence_put(fence);
 	}
 }
diff --git a/drivers/gpu/drm/imagination/pvr_queue.c b/drivers/gpu/drm/imagination/pvr_queue.c
index 24a8645aa913..f86e39fcb57f 100644
--- a/drivers/gpu/drm/imagination/pvr_queue.c
+++ b/drivers/gpu/drm/imagination/pvr_queue.c
@@ -4,6 +4,7 @@
 #include <drm/drm_managed.h>
 #include <drm/gpu_scheduler.h>
 #include <linux/overflow.h>
+#include <linux/rcupdate.h>
 
 #include "pvr_cccb.h"
 #include "pvr_context.h"
@@ -193,7 +194,7 @@ pvr_queue_fence_is_ufo_backed(struct dma_fence *f)
 	 * Currently the only dma_fence backed by a UFO object is the job fence,
 	 * e.g. pvr_job::done_fence, wrapped by a pvr_queue_fence object.
 	 */
-	return f && f->ops == &pvr_queue_job_fence_ops;
+	return f && rcu_access_pointer(f->ops) == &pvr_queue_job_fence_ops;
 }
 
 /**
@@ -246,13 +247,13 @@ static void pvr_queue_fence_put(struct dma_fence *f)
 	if (!f)
 		return;
 
-	if (WARN_ON(f->ops &&
-		    f->ops != &pvr_queue_cccb_fence_ops &&
-		    f->ops != &pvr_queue_job_fence_ops))
+	if (WARN_ON(rcu_access_pointer(f->ops) &&
+		    rcu_access_pointer(f->ops) != &pvr_queue_cccb_fence_ops &&
+		    rcu_access_pointer(f->ops) != &pvr_queue_job_fence_ops))
 		return;
 
 	/* If the fence hasn't been initialized yet, free the object directly. */
-	if (f->ops)
+	if (rcu_access_pointer(f->ops))
 		dma_fence_put(f);
 	else
 		dma_fence_free(f);
@@ -339,7 +340,7 @@ pvr_queue_cccb_fence_init(struct dma_fence *fence, struct pvr_queue *queue)
 static void
 pvr_queue_job_fence_init(struct dma_fence *fence, struct pvr_queue *queue)
 {
-	if (!fence->ops)
+	if (!rcu_access_pointer(fence->ops))
 		pvr_queue_fence_init(fence, queue, &pvr_queue_job_fence_ops,
 				     &queue->job_fence_ctx);
 }
@@ -508,7 +509,7 @@ pvr_queue_get_job_kccb_fence(struct pvr_queue *queue, struct pvr_job *job)
 	if (!job->kccb_fence)
 		return NULL;
 
-	if (!WARN_ON(job->kccb_fence->ops)) {
+	if (!WARN_ON(rcu_access_pointer(job->kccb_fence->ops))) {
 		kccb_fence = pvr_kccb_reserve_slot(pvr_dev, job->kccb_fence);
 		job->kccb_fence = NULL;
 	}
@@ -755,7 +756,7 @@ static struct dma_fence *pvr_queue_run_job(struct drm_sched_job *sched_job)
 	 * done_fence that's been initialized earlier.
 	 */
 	if (job->paired_job && job->type == DRM_PVR_JOB_TYPE_FRAGMENT &&
-	    job->done_fence->ops) {
+	    rcu_access_pointer(job->done_fence->ops)) {
 		return dma_fence_get(job->done_fence);
 	}
 
-- 
2.56.0

