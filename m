Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C859F34C5E
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 15:06:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95E5C10E4C0;
	Mon, 13 Apr 2026 15:06:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="hFjSMMe1";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 400D710E4C0
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 15:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wLKbSvXXuxztxZnHbIr0M+3ufjW9d5N1QFteRgeuvJM=; b=hFjSMMe1pQQEuapQkmb9rEMuix
 rBWLL7dfQvqiWgSxATIdbJWEa7bybw4NDAde4cGbKEIPR3iTH6CxVdp6lur9aNAlEzy0t0Ur/WBGg
 xviwKVelxTDWHGFV5nyFW0JoO68jJvdBrG9z8jFUxZ1KA0Y0W/A08tgwxPSag+CSoMVn7BsUiiinR
 8Rk0yJD6c2ncQ4CF8sQkUjKPa8KGdvmF7jviZPpXzg77JtAI4u4/3xXWbQ6lIpurgRQkymNrDhAF0
 fUv+aHah6Dz1qdGKozoINnhpArKDmnm1Z7dZaj53fO3MwamUZWVEGt/JLhPMCJrbJpIuO9CV0HKQl
 HTAgESjg==;
Received: from [189.7.87.169] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wCIrT-00FSq1-9s; Mon, 13 Apr 2026 17:06:03 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Mon, 13 Apr 2026 12:03:24 -0300
Subject: [PATCH 09/10] drm/v3d: Refactor CPU ioctl into unified submission
 chain
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260413-v3d-sched-misc-fixes-v1-9-bac63a8ceb6c@igalia.com>
References: <20260413-v3d-sched-misc-fixes-v1-0-bac63a8ceb6c@igalia.com>
In-Reply-To: <20260413-v3d-sched-misc-fixes-v1-0-bac63a8ceb6c@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=19268; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=TVFVgdNy4AwPB77wdMeTEjmqcN7MICg1wW2P1GrPpLA=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBp3QYuMBr+JW13wKUzMbtViJof83mVI0jUoTguJ
 pC8Kv9S+LGJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCad0GLgAKCRA/8w6Kdoj6
 qip3B/wP0akkP97oY1JppRcJhBmr2kJ0QendyYbZiOQVWx0Buu+Y8YBdYL/o+OUb70nxief4bPX
 bW7h2cLxECbl/a+ygJmXxZdmv8IODxCFin3qBXTUNwBSyZjxsggfFjWlVe/O1LzBT6zsP8G18/P
 8H2qwPYuOuvUxYNQQNcI5bIkGfNrfJgs3cPsD/PKY5RGmzR+crMkmoXIeht1wODKWefvFogjEfA
 WhiQTUwRbRz2Smy6bg2VEGbHPBOm5l+qGsko/sFGWdhu64m4///j68ixE1kaDxxqSAYmYilJORe
 BoIJBz4zQKmTe/CGlYsUYXz4tliFUPpoJZX9XX3Jupwjknpq
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
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

Restructure the CPU ioctl so that all job types, including indirect CSD,
use a single struct v3d_submit chain and a single DRM exec context.

Currently, v3d_get_cpu_indirect_csd_params(), which is the indirect CSD
parser, not only parses the ioctl arguments, but also creates the jobs and
locks the BOs during extension parsing. This breaks the default submission
flow and creates a nested job submission.

This refactoring turns v3d_get_cpu_indirect_csd_params() into a pure
parser. Now, job creation and BO locking happen in the ioctl function,
which appends the indirect CSD and CLEAN_CACHE jobs to the same struct
v3d_submit and locks the union of all jobs' BOs under one drm_exec. This
eliminates the second drm_exec, the nested submission, and the conditional
two-pass fence attachment that the CPU ioctl previously required for the
indirect CSD path.

For the refactoring, change the functions v3d_lock_bo_reservations(),
v3d_lookup_bos(), v3d_setup_csd_jobs_and_bos() and
v3d_attach_fences_and_unlock_reservation() to take struct v3d_submit
instead of individual arguments. The BO locking helper now iterates over
all jobs in the submission and locks the union, instead of only handling
the last job of the chain.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_drv.h    |   9 +-
 drivers/gpu/drm/v3d/v3d_submit.c | 341 ++++++++++++++-------------------------
 2 files changed, 121 insertions(+), 229 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
index fc12e5215fb0..071d919fe860 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.h
+++ b/drivers/gpu/drm/v3d/v3d_drv.h
@@ -422,8 +422,10 @@ struct v3d_indirect_csd_info {
 	/* Indirect CSD */
 	struct v3d_csd_job *job;
 
-	/* Clean cache job associated to the Indirect CSD job */
-	struct v3d_job *clean_job;
+	/* Indirect CSD args, stashed by the extension parser and later used
+	 * to create the CSD job from them.
+	 */
+	struct drm_v3d_submit_csd args;
 
 	/* Offset within the BO where the workgroup counts are stored */
 	u32 offset;
@@ -438,9 +440,6 @@ struct v3d_indirect_csd_info {
 
 	/* Indirect BO */
 	struct drm_gem_object *indirect;
-
-	/* Context of the Indirect CSD job */
-	struct drm_exec exec;
 };
 
 struct v3d_timestamp_query_info {
diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index 5b519a892985..36402fc25c10 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -20,28 +20,42 @@
  * to v3d, so we don't attach dma-buf fences to them.
  */
 static int
-v3d_lock_bo_reservations(struct v3d_job *job, struct drm_exec *exec)
+v3d_lock_bo_reservations(struct v3d_submit *submit)
 {
-	int i, ret;
+	int i, j, ret;
 
-	drm_exec_init(exec, DRM_EXEC_INTERRUPTIBLE_WAIT, job->bo_count);
-	drm_exec_until_all_locked(exec) {
-		ret = drm_exec_prepare_array(exec, job->bo, job->bo_count, 1);
+	drm_exec_init(&submit->exec,
+		      DRM_EXEC_INTERRUPTIBLE_WAIT | DRM_EXEC_IGNORE_DUPLICATES, 0);
+	drm_exec_until_all_locked(&submit->exec) {
+		for (i = 0; i < submit->job_count; i++) {
+			struct v3d_job *job = submit->jobs[i];
+
+			ret = drm_exec_prepare_array(&submit->exec, job->bo,
+						     job->bo_count, 1);
+			if (ret)
+				break;
+		}
+		drm_exec_retry_on_contention(&submit->exec);
 		if (ret)
 			goto fail;
 	}
 
-	for (i = 0; i < job->bo_count; i++) {
-		ret = drm_sched_job_add_implicit_dependencies(&job->base,
-							      job->bo[i], true);
-		if (ret)
-			goto fail;
+	for (i = 0; i < submit->job_count; i++) {
+		struct v3d_job *job = submit->jobs[i];
+
+		for (j = 0; j < job->bo_count; j++) {
+			ret = drm_sched_job_add_implicit_dependencies(&job->base,
+								      job->bo[j],
+								      true);
+			if (ret)
+				goto fail;
+		}
 	}
 
 	return 0;
 
 fail:
-	drm_exec_fini(exec);
+	drm_exec_fini(&submit->exec);
 	return ret;
 }
 
@@ -62,25 +76,23 @@ v3d_lock_bo_reservations(struct v3d_job *job, struct drm_exec *exec)
  * failure, because that will happen at `v3d_job_free()`.
  */
 static int
-v3d_lookup_bos(struct drm_device *dev,
-	       struct drm_file *file_priv,
-	       struct v3d_job *job,
-	       u64 bo_handles,
-	       u32 bo_count)
+v3d_lookup_bos(struct v3d_submit *submit, u64 bo_handles, u32 bo_count)
 {
-	job->bo_count = bo_count;
+	struct v3d_job *last_job = submit->jobs[submit->job_count - 1];
 
-	if (!job->bo_count) {
+	last_job->bo_count = bo_count;
+
+	if (!last_job->bo_count) {
 		/* See comment on bo_index for why we have to check
 		 * this.
 		 */
-		drm_warn(dev, "Rendering requires BOs\n");
+		drm_warn(&submit->v3d->drm, "Rendering requires BOs\n");
 		return -EINVAL;
 	}
 
-	return drm_gem_objects_lookup(file_priv,
+	return drm_gem_objects_lookup(submit->file_priv,
 				      (void __user *)(uintptr_t)bo_handles,
-				      job->bo_count, &job->bo);
+				      last_job->bo_count, &last_job->bo);
 }
 
 static void
@@ -141,25 +153,6 @@ void v3d_job_put(struct v3d_job *job)
 	kref_put(&job->refcount, job->free);
 }
 
-static int
-v3d_job_allocate(struct v3d_dev *v3d, void **container, size_t size)
-{
-	*container = kcalloc(1, size, GFP_KERNEL);
-	if (!*container) {
-		drm_err(&v3d->drm, "Cannot allocate memory for V3D job.\n");
-		return -ENOMEM;
-	}
-
-	return 0;
-}
-
-static void
-v3d_job_deallocate(void **container)
-{
-	kfree(*container);
-	*container = NULL;
-}
-
 static int
 v3d_job_add_syncobjs(struct v3d_job *job, struct drm_file *file_priv,
 		     u32 in_sync, struct v3d_submit_ext *se, enum v3d_queue queue)
@@ -200,47 +193,6 @@ v3d_job_add_syncobjs(struct v3d_job *job, struct drm_file *file_priv,
 	return 0;
 }
 
-static int
-v3d_job_init(struct v3d_dev *v3d, struct drm_file *file_priv,
-	     struct v3d_job *job, void (*free)(struct kref *ref),
-	     u32 in_sync, struct v3d_submit_ext *se, enum v3d_queue queue)
-{
-	struct v3d_file_priv *v3d_priv = file_priv->driver_priv;
-	int ret;
-
-	job->v3d = v3d;
-	job->free = free;
-	job->file_priv = v3d_priv;
-
-	ret = drm_sched_job_init(&job->base, &v3d_priv->sched_entity[queue],
-				 1, v3d_priv, file_priv->client_id);
-	if (ret)
-		return ret;
-
-	ret = v3d_job_add_syncobjs(job, file_priv, in_sync, se, queue);
-	if (ret)
-		goto fail_job_init;
-
-	/* CPU jobs don't require hardware resources */
-	if (queue != V3D_CPU) {
-		ret = v3d_pm_runtime_get(v3d);
-		if (ret)
-			goto fail_job_init;
-		job->has_pm_ref = true;
-	}
-
-	kref_init(&job->refcount);
-
-	job->client_stats = v3d_stats_get(v3d_priv->stats[queue]);
-	job->global_stats = v3d_stats_get(v3d->queue[queue].stats);
-
-	return 0;
-
-fail_job_init:
-	drm_sched_job_cleanup(&job->base);
-	return ret;
-}
-
 static int
 v3d_submit_add_job(struct v3d_submit *submit, void **container, size_t size,
 		   void (*free)(struct kref *ref), enum v3d_queue queue)
@@ -354,31 +306,35 @@ v3d_submit_jobs(struct v3d_submit *submit)
 }
 
 static void
-v3d_attach_fences_and_unlock_reservation(struct drm_file *file_priv,
-					 struct v3d_job *job,
-					 struct drm_exec *exec,
-					 u32 out_sync,
-					 struct v3d_submit_ext *se,
-					 struct dma_fence *done_fence)
+v3d_attach_fences_and_unlock_reservation(struct v3d_submit *submit,
+					 u32 out_sync, struct v3d_submit_ext *se)
 {
-	struct drm_syncobj *sync_out;
 	bool has_multisync = se && (se->flags & DRM_V3D_EXT_ID_MULTI_SYNC);
-	int i;
+	struct v3d_job *last_job = submit->jobs[submit->job_count - 1];
+	struct drm_syncobj *sync_out;
+	int i, j;
 
-	for (i = 0; i < job->bo_count; i++) {
-		/* XXX: Use shared fences for read-only objects. */
-		dma_resv_add_fence(job->bo[i]->resv, job->done_fence,
-				   DMA_RESV_USAGE_WRITE);
+	/* The submission's last fence covers the entire submission. Attach it
+	 * to every BO touched by any job in the submission.
+	 */
+	for (i = 0; i < submit->job_count; i++) {
+		struct v3d_job *job = submit->jobs[i];
+
+		for (j = 0; j < job->bo_count; j++) {
+			/* XXX: Use shared fences for read-only objects. */
+			dma_resv_add_fence(job->bo[j]->resv, last_job->done_fence,
+					   DMA_RESV_USAGE_WRITE);
+		}
 	}
 
-	drm_exec_fini(exec);
+	drm_exec_fini(&submit->exec);
 
 	/* Update the return sync object for the job */
 	/* If it only supports a single signal semaphore*/
 	if (!has_multisync) {
-		sync_out = drm_syncobj_find(file_priv, out_sync);
+		sync_out = drm_syncobj_find(submit->file_priv, out_sync);
 		if (sync_out) {
-			drm_syncobj_replace_fence(sync_out, done_fence);
+			drm_syncobj_replace_fence(sync_out, last_job->done_fence);
 			drm_syncobj_put(sync_out);
 		}
 		return;
@@ -388,7 +344,7 @@ v3d_attach_fences_and_unlock_reservation(struct drm_file *file_priv,
 	if (se->out_sync_count) {
 		for (i = 0; i < se->out_sync_count; i++) {
 			drm_syncobj_replace_fence(se->out_syncs[i].syncobj,
-						  done_fence);
+						  last_job->done_fence);
 			drm_syncobj_put(se->out_syncs[i].syncobj);
 		}
 		kvfree(se->out_syncs);
@@ -396,46 +352,36 @@ v3d_attach_fences_and_unlock_reservation(struct drm_file *file_priv,
 }
 
 static int
-v3d_setup_csd_jobs_and_bos(struct drm_file *file_priv,
-			   struct v3d_dev *v3d,
+v3d_setup_csd_jobs_and_bos(struct v3d_submit *submit,
 			   struct drm_v3d_submit_csd *args,
-			   struct v3d_csd_job **job,
-			   struct v3d_job **clean_job,
-			   struct v3d_submit_ext *se,
-			   struct drm_exec *exec)
+			   struct v3d_submit_ext *se)
 {
+	struct v3d_csd_job *job = NULL;
+	struct v3d_job *clean_job = NULL;
 	int ret;
 
-	ret = v3d_job_allocate(v3d, (void *)job, sizeof(**job));
+	ret = v3d_submit_add_job(submit, (void **)&job, sizeof(*job),
+				 v3d_job_free, V3D_CSD);
 	if (ret)
 		return ret;
 
-	ret = v3d_job_init(v3d, file_priv, &(*job)->base,
-			   v3d_job_free, args->in_sync, se, V3D_CSD);
-	if (ret) {
-		v3d_job_deallocate((void *)job);
-		return ret;
-	}
-
-	ret = v3d_job_allocate(v3d, (void *)clean_job, sizeof(**clean_job));
+	ret = v3d_job_add_syncobjs(&job->base, submit->file_priv, args->in_sync,
+				   se, V3D_CSD);
 	if (ret)
 		return ret;
 
-	ret = v3d_job_init(v3d, file_priv, *clean_job,
-			   v3d_job_free, 0, NULL, V3D_CACHE_CLEAN);
-	if (ret) {
-		v3d_job_deallocate((void *)clean_job);
-		return ret;
-	}
+	job->args = *args;
 
-	(*job)->args = *args;
-
-	ret = v3d_lookup_bos(&v3d->drm, file_priv, *clean_job,
-			     args->bo_handles, args->bo_handle_count);
+	ret = v3d_submit_add_job(submit, (void **)&clean_job, sizeof(*clean_job),
+				 v3d_job_free, V3D_CACHE_CLEAN);
 	if (ret)
 		return ret;
 
-	return v3d_lock_bo_reservations(*clean_job, exec);
+	ret = v3d_lookup_bos(submit, args->bo_handles, args->bo_handle_count);
+	if (ret)
+		return ret;
+
+	return v3d_lock_bo_reservations(submit);
 }
 
 static void
@@ -579,6 +525,7 @@ v3d_get_cpu_indirect_csd_params(struct drm_file *file_priv,
 	}
 
 	job->job_type = V3D_CPU_JOB_TYPE_INDIRECT_CSD;
+	info->args = indirect_csd.submit;
 	info->offset = indirect_csd.offset;
 	info->wg_size = indirect_csd.wg_size;
 	memcpy(&info->wg_uniform_offsets, &indirect_csd.wg_uniform_offsets,
@@ -586,9 +533,7 @@ v3d_get_cpu_indirect_csd_params(struct drm_file *file_priv,
 
 	info->indirect = drm_gem_object_lookup(file_priv, indirect_csd.indirect);
 
-	return v3d_setup_csd_jobs_and_bos(file_priv, v3d, &indirect_csd.submit,
-					  &info->job, &info->clean_job,
-					  NULL, &info->exec);
+	return 0;
 }
 
 /* Get data for the query timestamp job submission. */
@@ -1070,14 +1015,11 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
 			goto fail;
 	}
 
-	ret = v3d_lookup_bos(dev, file_priv,
-			     submit.jobs[submit.job_count - 1],
-			     args->bo_handles, args->bo_handle_count);
+	ret = v3d_lookup_bos(&submit, args->bo_handles, args->bo_handle_count);
 	if (ret)
 		goto fail;
 
-	ret = v3d_lock_bo_reservations(submit.jobs[submit.job_count - 1],
-				       &submit.exec);
+	ret = v3d_lock_bo_reservations(&submit);
 	if (ret)
 		goto fail;
 
@@ -1089,11 +1031,7 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
 	if (ret)
 		goto fail_perfmon;
 
-	v3d_attach_fences_and_unlock_reservation(file_priv,
-						 submit.jobs[submit.job_count - 1],
-						 &submit.exec,
-						 args->out_sync, &se,
-						 submit.jobs[submit.job_count - 1]->done_fence);
+	v3d_attach_fences_and_unlock_reservation(&submit, args->out_sync, &se);
 
 	for (int i = 0; i < submit.job_count; i++)
 		v3d_job_put(submit.jobs[i]);
@@ -1184,7 +1122,7 @@ v3d_submit_tfu_ioctl(struct drm_device *dev, void *data,
 		job->base.bo[job->base.bo_count] = bo;
 	}
 
-	ret = v3d_lock_bo_reservations(&job->base, &submit.exec);
+	ret = v3d_lock_bo_reservations(&submit);
 	if (ret)
 		goto fail;
 
@@ -1192,10 +1130,7 @@ v3d_submit_tfu_ioctl(struct drm_device *dev, void *data,
 	if (ret)
 		goto fail_submit;
 
-	v3d_attach_fences_and_unlock_reservation(file_priv,
-						 &job->base, &submit.exec,
-						 args->out_sync, &se,
-						 job->base.done_fence);
+	v3d_attach_fences_and_unlock_reservation(&submit, args->out_sync, &se);
 
 	v3d_job_put(&job->base);
 
@@ -1230,8 +1165,6 @@ v3d_submit_csd_ioctl(struct drm_device *dev, void *data,
 	};
 	struct drm_v3d_submit_csd *args = data;
 	struct v3d_submit_ext se = {0};
-	struct v3d_csd_job *job = NULL;
-	struct v3d_job *clean_job = NULL;
 	int ret;
 
 	trace_v3d_submit_csd_ioctl(dev, args->cfg[5], args->cfg[6]);
@@ -1257,14 +1190,10 @@ v3d_submit_csd_ioctl(struct drm_device *dev, void *data,
 		}
 	}
 
-	ret = v3d_setup_csd_jobs_and_bos(file_priv, v3d, args,
-					 &job, &clean_job, &se, &submit.exec);
+	ret = v3d_setup_csd_jobs_and_bos(&submit, args, &se);
 	if (ret)
 		goto fail;
 
-	submit.jobs[submit.job_count++] = &job->base;
-	submit.jobs[submit.job_count++] = clean_job;
-
 	ret = v3d_attach_perfmon_to_jobs(&submit, args->perfmon_id);
 	if (ret)
 		goto fail_perfmon;
@@ -1273,11 +1202,7 @@ v3d_submit_csd_ioctl(struct drm_device *dev, void *data,
 	if (ret)
 		goto fail_perfmon;
 
-	v3d_attach_fences_and_unlock_reservation(file_priv,
-						 clean_job,
-						 &submit.exec,
-						 args->out_sync, &se,
-						 clean_job->done_fence);
+	v3d_attach_fences_and_unlock_reservation(&submit, args->out_sync, &se);
 
 	for (int i = 0; i < submit.job_count; i++)
 		v3d_job_put(submit.jobs[i]);
@@ -1287,8 +1212,8 @@ v3d_submit_csd_ioctl(struct drm_device *dev, void *data,
 fail_perfmon:
 	drm_exec_fini(&submit.exec);
 fail:
-	v3d_job_cleanup((void *)job);
-	v3d_job_cleanup(clean_job);
+	for (int i = 0; i < submit.job_count; i++)
+		v3d_job_cleanup(submit.jobs[i]);
 	v3d_put_multisync_post_deps(&se);
 
 	return ret;
@@ -1316,14 +1241,14 @@ int
 v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
 		     struct drm_file *file_priv)
 {
-	struct v3d_dev *v3d = to_v3d_dev(dev);
+	struct v3d_submit submit = {
+		.v3d = to_v3d_dev(dev),
+		.file_priv = file_priv,
+		.job_count = 0
+	};
 	struct drm_v3d_submit_cpu *args = data;
 	struct v3d_submit_ext se = {0};
-	struct v3d_submit_ext *out_se = NULL;
 	struct v3d_cpu_job *cpu_job = NULL;
-	struct v3d_csd_job *csd_job = NULL;
-	struct v3d_job *clean_job = NULL;
-	struct drm_exec exec;
 	int ret;
 
 	if (args->flags && !(args->flags & DRM_V3D_SUBMIT_EXTENSION)) {
@@ -1331,7 +1256,8 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
 		return -EINVAL;
 	}
 
-	ret = v3d_job_allocate(v3d, (void *)&cpu_job, sizeof(*cpu_job));
+	ret = v3d_submit_add_job(&submit, (void **)&cpu_job, sizeof(*cpu_job),
+				 v3d_job_free, V3D_CPU);
 	if (ret)
 		return ret;
 
@@ -1356,86 +1282,53 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
 		goto fail;
 	}
 
-	trace_v3d_submit_cpu_ioctl(&v3d->drm, cpu_job->job_type);
+	trace_v3d_submit_cpu_ioctl(dev, cpu_job->job_type);
 
-	ret = v3d_job_init(v3d, file_priv, &cpu_job->base,
-			   v3d_job_free, 0, &se, V3D_CPU);
-	if (ret) {
-		v3d_job_deallocate((void *)&cpu_job);
+	ret = v3d_job_add_syncobjs(&cpu_job->base, file_priv, 0, &se, V3D_CPU);
+	if (ret)
 		goto fail;
-	}
-
-	clean_job = cpu_job->indirect_csd.clean_job;
-	csd_job = cpu_job->indirect_csd.job;
 
+	/* Look up the CPU jobs' BOs first, so v3d_setup_csd_jobs_and_bos(), which
+	 * locks all jobs' BOs at its end, picks them up too in the case of indirect
+	 * CSD.
+	 */
 	if (args->bo_handle_count) {
-		ret = v3d_lookup_bos(dev, file_priv, &cpu_job->base,
-				     args->bo_handles, args->bo_handle_count);
-		if (ret)
-			goto fail;
-
-		ret = v3d_lock_bo_reservations(&cpu_job->base, &exec);
+		ret = v3d_lookup_bos(&submit, args->bo_handles, args->bo_handle_count);
 		if (ret)
 			goto fail;
 	}
 
-	mutex_lock(&v3d->sched_lock);
-	v3d_push_job(&cpu_job->base);
-
-	switch (cpu_job->job_type) {
-	case V3D_CPU_JOB_TYPE_INDIRECT_CSD:
-		ret = drm_sched_job_add_dependency(&csd_job->base.base,
-						   dma_fence_get(cpu_job->base.done_fence));
+	if (cpu_job->job_type == V3D_CPU_JOB_TYPE_INDIRECT_CSD) {
+		ret = v3d_setup_csd_jobs_and_bos(&submit, &cpu_job->indirect_csd.args,
+						 NULL);
 		if (ret)
-			goto fail_unreserve;
+			goto fail;
 
-		v3d_push_job(&csd_job->base);
-
-		ret = drm_sched_job_add_dependency(&clean_job->base,
-						   dma_fence_get(csd_job->base.done_fence));
+		/* The CSD job was appended at jobs[1] */
+		cpu_job->indirect_csd.job = container_of(submit.jobs[1], struct v3d_csd_job,
+							 base);
+	} else {
+		ret = v3d_lock_bo_reservations(&submit);
 		if (ret)
-			goto fail_unreserve;
-
-		v3d_push_job(clean_job);
-
-		break;
-	default:
-		break;
-	}
-	mutex_unlock(&v3d->sched_lock);
-
-	out_se = (cpu_job->job_type == V3D_CPU_JOB_TYPE_INDIRECT_CSD) ? NULL : &se;
-
-	v3d_attach_fences_and_unlock_reservation(file_priv,
-						 &cpu_job->base,
-						 &exec, 0,
-						 out_se, cpu_job->base.done_fence);
-
-	switch (cpu_job->job_type) {
-	case V3D_CPU_JOB_TYPE_INDIRECT_CSD:
-		v3d_attach_fences_and_unlock_reservation(file_priv,
-							 clean_job,
-							 &cpu_job->indirect_csd.exec,
-							 0, &se, clean_job->done_fence);
-		break;
-	default:
-		break;
+			goto fail;
 	}
 
-	v3d_job_put(&cpu_job->base);
-	v3d_job_put(&csd_job->base);
-	v3d_job_put(clean_job);
+	ret = v3d_submit_jobs(&submit);
+	if (ret)
+		goto fail_unlock;
+
+	v3d_attach_fences_and_unlock_reservation(&submit, 0, &se);
+
+	for (int i = 0; i < submit.job_count; i++)
+		v3d_job_put(submit.jobs[i]);
 
 	return 0;
 
-fail_unreserve:
-	mutex_unlock(&v3d->sched_lock);
-	drm_exec_fini(&exec);
-	drm_exec_fini(&cpu_job->indirect_csd.exec);
+fail_unlock:
+	drm_exec_fini(&submit.exec);
 fail:
-	v3d_job_cleanup((void *)cpu_job);
-	v3d_job_cleanup((void *)csd_job);
-	v3d_job_cleanup(clean_job);
+	for (int i = 0; i < submit.job_count; i++)
+		v3d_job_cleanup(submit.jobs[i]);
 	v3d_put_multisync_post_deps(&se);
 	kvfree(cpu_job->timestamp_query.queries);
 	kvfree(cpu_job->performance_query.queries);

-- 
2.53.0

