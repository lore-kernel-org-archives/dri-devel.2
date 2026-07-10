Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06C58C44501
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 11:47:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 541A510F84B;
	Fri, 10 Jul 2026 11:47:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="CKGPh46a";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F112E10F84B
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 11:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=bp0ueuUI1znZnwxYbQuSV8jc9AXJFuzatZdYJGDCSGQ=; b=CKGPh46aWPabeFhTngj04OwHPt
 gzjqqdDRocZbOhpT5xSXhOOZaonQNJUoCGGa6+mT55G3SIk9uUdQECMGSsosvPgbtglNTp31rDg2B
 K495k+eY11TAq4dTH+mAg3OBysEjFiFoQu5zBQKTwLl860/K9jqfl1OkI5CYxcHS5vQNlDrl+Lp0e
 n378ZeU0urTOWg/lyJf388wK+3mTmB/MTONrt9P+8W8udUn/9nHxoZtktPPhwLLkhP9Nbcnbx8TCI
 po332wyJEsl+/O4xHSo0bUVYWtVEhqmKPb0aa17r0qritpsGlHn7k4mDYNhgtvN2lDTNGsM7nH6HP
 C5UvE8GA==;
Received: from [189.7.87.67] (helo=prince) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wi9hk-00CfHU-RF; Fri, 10 Jul 2026 13:47:41 +0200
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Subject: [PATCH v4] drm/v3d: Associate BOs with every job that accesses them
Date: Fri, 10 Jul 2026 08:43:27 -0300
Message-ID: <20260710114734.2731000-1-mcanal@igalia.com>
X-Mailer: git-send-email 2.54.0
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

A submission can expand into a chain of jobs (e.g. bin + render + cache
clean). Implicit synchronization in v3d_submit_lock_reservations() is gated
on each job's bo[], but the BO list was only ever attached to the last job
of the chain. When that last job is a trailing CACHE_CLEAN job, the job
that actually consumes the BOs (that is, a RENDER or CSD job) was left with
bo_count == 0 and picked up no implicit dependencies. It could therefore
be dispatched to the hardware and read a BO while another context was still
writing it, leading to data corruption.

Attach the BOs to the job that consumes them, so (1) it acquires the
correct implicit dependencies during reservation locking and (2) they are
kept mapped until the end of the submission. Give it references to all
consuming job's BOs through v3d_job_reference_bos() instead of looking the
handles up a second time; that avoids a redundant lookup and guarantees
both jobs reference the exact same objects.

As the CACHE_CLEAN job now carries a BO array as well, add a per-job
`has_implicit_dep` flag so that only the consuming jobs take implicit
dependencies. The CACHE_CLEAN job (a global flush) and the BIN job (binning
waiting on another context is not a realistic scenario) are excluded.

Fixes: dffa9b7a78c4 ("drm/v3d: Add missing implicit synchronization.")
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_drv.h    |  5 ++
 drivers/gpu/drm/v3d/v3d_submit.c | 92 +++++++++++++++++++++++---------
 2 files changed, 72 insertions(+), 25 deletions(-)

Changelog
=========

v1 -> v2: https://lore.kernel.org/r/20260610-v3d-cpu-job-fixes-v1-0-0d9c88989edc@igalia.com

- Don't attach implicit dependencies to BIN jobs (Iago Toral)

v2 -> v3: https://lore.kernel.org/r/20260618-v3d-cpu-job-fixes-v2-0-fec132484fc4@igalia.com

- Add a comment clarifing why we don't attach BOs to BIN jobs (Iago Toral)
- Add Iago's R-b (Iago Toral)

v3 -> v4: https://lore.kernel.org/r/20260703-v3d-cpu-job-fixes-v3-0-bc51b1f3eeb5@igalia.com

- Remove Iago's R-b
- Add a flag to indicate which jobs have implicit dependencies and only
	add implicit dependencies to jobs that actually need.
- Make sure that the last job also has a reference to the BOs.
	Otherwise, V3D_CACHE_CLEAN jobs execute after their associated buffer
	objects (BOs) are freed.

diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
index 1b88b3dff757..8c46ed09f5c4 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.h
+++ b/drivers/gpu/drm/v3d/v3d_drv.h
@@ -375,6 +375,11 @@ struct v3d_job {
 	void (*free)(struct kref *ref);
 
 	bool has_pm_ref;
+
+	/* Whether the job needs implicit dependencies, i.e. must wait for
+	 * other contexts still writing its BOs.
+	 */
+	bool has_implicit_dep;
 };
 
 struct v3d_bin_job {
diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index 5c05f1ea24bc..623df9d5bbee 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -46,6 +46,9 @@ v3d_submit_lock_reservations(struct v3d_submit *submit)
 	for (i = 0; i < submit->job_count; i++) {
 		struct v3d_job *job = submit->jobs[i];
 
+		if (!job->has_implicit_dep)
+			continue;
+
 		for (j = 0; j < job->bo_count; j++) {
 			ret = drm_sched_job_add_implicit_dependencies(&job->base,
 								      job->bo[j],
@@ -71,7 +74,6 @@ v3d_submit_unlock_reservations(struct v3d_submit *submit)
 /**
  * v3d_lookup_bos() - Sets up job->bo[] with the GEM objects
  * referenced by the job.
- * @dev: DRM device
  * @file_priv: DRM file for this fd
  * @job: V3D job being set up
  * @bo_handles: GEM handles
@@ -85,23 +87,44 @@ v3d_submit_unlock_reservations(struct v3d_submit *submit)
  * failure, because that will happen at `v3d_job_free()`.
  */
 static int
-v3d_lookup_bos(struct v3d_submit *submit, u64 bo_handles, u32 bo_count)
+v3d_lookup_bos(struct drm_file *file_priv, struct v3d_job *job,
+	       u64 bo_handles, u32 bo_count)
 {
-	struct v3d_job *last_job = submit->jobs[submit->job_count - 1];
-
-	last_job->bo_count = bo_count;
-
-	if (!last_job->bo_count) {
-		/* See comment on bo_index for why we have to check
-		 * this.
-		 */
-		drm_warn(&submit->v3d->drm, "Rendering requires BOs\n");
+	if (!bo_count) {
+		drm_warn(&job->v3d->drm, "Rendering requires BOs\n");
 		return -EINVAL;
 	}
 
-	return drm_gem_objects_lookup(submit->file_priv,
+	job->bo_count = bo_count;
+
+	return drm_gem_objects_lookup(file_priv,
 				      (void __user *)(uintptr_t)bo_handles,
-				      last_job->bo_count, &last_job->bo);
+				      job->bo_count, &job->bo);
+}
+
+/**
+ * v3d_job_reference_bos() - Share another job's BOs with @dst
+ * @dst: job that acquires references to the BOs
+ * @src: job whose already-resolved BO list is shared
+ *
+ * For submissions with multiple jobs that use the same BOs, a trailing job
+ * shouldn't look the handles up again, as it could cause inconsistencies.
+ * Instead, it should reference the previous job's BOs.
+ */
+static int
+v3d_job_reference_bos(struct v3d_job *dst, struct v3d_job *src)
+{
+	dst->bo = kvmalloc_objs(*dst->bo, src->bo_count);
+	if (!dst->bo)
+		return -ENOMEM;
+
+	dst->bo_count = src->bo_count;
+	for (int i = 0; i < dst->bo_count; i++) {
+		dst->bo[i] = src->bo[i];
+		drm_gem_object_get(dst->bo[i]);
+	}
+
+	return 0;
 }
 
 static void
@@ -223,13 +246,14 @@ v3d_job_add_syncobjs(struct v3d_job *job, struct drm_file *file_priv,
 static const struct {
 	size_t size;
 	void (*free)(struct kref *ref);
+	bool has_implicit_dep;
 } v3d_job_types[] = {
-	[V3D_BIN]		= { sizeof(struct v3d_bin_job), v3d_job_free },
-	[V3D_RENDER]		= { sizeof(struct v3d_render_job), v3d_render_job_free },
-	[V3D_TFU]		= { sizeof(struct v3d_tfu_job), v3d_job_free },
-	[V3D_CSD]		= { sizeof(struct v3d_csd_job), v3d_job_free },
-	[V3D_CACHE_CLEAN]	= { sizeof(struct v3d_job), v3d_job_free },
-	[V3D_CPU]		= { sizeof(struct v3d_cpu_job), v3d_cpu_job_free },
+	[V3D_BIN]		= { sizeof(struct v3d_bin_job), v3d_job_free, false },
+	[V3D_RENDER]		= { sizeof(struct v3d_render_job), v3d_render_job_free, true },
+	[V3D_TFU]		= { sizeof(struct v3d_tfu_job), v3d_job_free, true },
+	[V3D_CSD]		= { sizeof(struct v3d_csd_job), v3d_job_free, true },
+	[V3D_CACHE_CLEAN]	= { sizeof(struct v3d_job), v3d_job_free, false },
+	[V3D_CPU]		= { sizeof(struct v3d_cpu_job), v3d_cpu_job_free, true },
 };
 
 static struct v3d_job *
@@ -251,6 +275,7 @@ v3d_submit_add_job(struct v3d_submit *submit, enum v3d_queue queue)
 	job->queue = queue;
 	job->file_priv = v3d_priv;
 	job->free = v3d_job_types[queue].free;
+	job->has_implicit_dep = v3d_job_types[queue].has_implicit_dep;
 
 	ret = drm_sched_job_init(&job->base, &v3d_priv->sched_entity[queue],
 				 1, v3d_priv, submit->file_priv->client_id);
@@ -518,13 +543,18 @@ v3d_setup_csd_jobs_and_bos(struct v3d_submit *submit,
 	if (ret)
 		return ret;
 
+	ret = v3d_lookup_bos(submit->file_priv, &job->base, args->bo_handles,
+			     args->bo_handle_count);
+	if (ret)
+		return ret;
+
 	job->args = *args;
 
 	clean_job = v3d_submit_add_job(submit, V3D_CACHE_CLEAN);
 	if (IS_ERR(clean_job))
 		return PTR_ERR(clean_job);
 
-	return v3d_lookup_bos(submit, args->bo_handles, args->bo_handle_count);
+	return v3d_job_reference_bos(clean_job, &job->base);
 }
 
 static void
@@ -1163,22 +1193,33 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
 	if (ret)
 		goto fail;
 
+	/*
+	 * We don't associate the BOs with the BIN job. Fences are only
+	 * attached to the last job in the submission chain, and BIN jobs
+	 * don't need implicit dependencies since depending on results from
+	 * another context is not a realistic scenario for binning.
+	 */
+	ret = v3d_lookup_bos(submit.file_priv, &render->base,
+			     args->bo_handles, args->bo_handle_count);
+	if (ret)
+		goto fail;
+
 	if (args->flags & DRM_V3D_SUBMIT_CL_FLUSH_CACHE) {
 		clean_job = v3d_submit_add_job(&submit, V3D_CACHE_CLEAN);
 		if (IS_ERR(clean_job)) {
 			ret = PTR_ERR(clean_job);
 			goto fail;
 		}
+
+		ret = v3d_job_reference_bos(clean_job, &render->base);
+		if (ret)
+			goto fail;
 	}
 
 	ret = v3d_attach_perfmon_to_jobs(&submit, args->perfmon_id);
 	if (ret)
 		goto fail;
 
-	ret = v3d_lookup_bos(&submit, args->bo_handles, args->bo_handle_count);
-	if (ret)
-		goto fail;
-
 	ret = v3d_submit_lock_reservations(&submit);
 	if (ret)
 		goto fail;
@@ -1557,7 +1598,8 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
 	 * the CSD and clean jobs in the case of indirect CSD job.
 	 */
 	if (args->bo_handle_count) {
-		ret = v3d_lookup_bos(&submit, args->bo_handles, args->bo_handle_count);
+		ret = v3d_lookup_bos(submit.file_priv, &cpu_job->base,
+				     args->bo_handles, args->bo_handle_count);
 		if (ret)
 			goto fail;
 
-- 
2.54.0

