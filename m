Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB25CD37B2
	for <dri-devel@archiver.kernel.org>; Sun, 10 May 2026 22:13:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BC4D10E43F;
	Sun, 10 May 2026 22:13:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="grdeLceF";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A4C610E43F
 for <dri-devel@lists.freedesktop.org>; Sun, 10 May 2026 22:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sjmZV/41KD/v13lt7nygw93s6Z3QXCTeLNyN1HjvRAI=; b=grdeLceFkh5Eaislpq5Ul4IVKk
 ejA9RX0Ja2bxwggbh6g5lb9LrzpMerW/UVR5MN1mg5+hxFSnNx8U1YAgYeji8yubyrjbilW40zCMR
 TH1AYGsK1MzSeVELLLSatc5O7O+u6qo1NRgB/K5EFyklum9f+zPRMpkjBO+gCst+Ct68K9OKhSYw3
 SncFr7rTgT051e2NsB3PtCfqxS16N02lB2ra18slx0K4GWKD29IvsBe89UpeQWzdSj5PJ5iuzY0qy
 snM0VPZU2iDm/pcL2ZP1da+6qvVztPSPYZMPADyAKp2sou0mH4JexN8PNL+Ko630ggCvpaUHefHxz
 hhZ4noJg==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wMCOO-008k1J-9a; Mon, 11 May 2026 00:12:55 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Sun, 10 May 2026 19:12:07 -0300
Subject: [PATCH v2 10/14] drm/v3d: Convert submit helpers to operate on
 struct v3d_submit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260510-v3d-sched-misc-fixes-v2-10-ca4aba343ef6@igalia.com>
References: <20260510-v3d-sched-misc-fixes-v2-0-ca4aba343ef6@igalia.com>
In-Reply-To: <20260510-v3d-sched-misc-fixes-v2-0-ca4aba343ef6@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=17486; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=xLCcQ0fu3BBAUcDZp0Yx8PtVW/99j822qBdkjxcVTwM=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqAQK0m/+RH7SdyPLSowkvmeGcVIkLNk8AUOy4T
 zLtLcEa+taJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCagECtAAKCRA/8w6Kdoj6
 qjJjCACCtFuUrh10DX4j2DAWmmhqz/hdt6hSWesXLcnS/7pkbSF3n+Xka+LJMxTYml5Ql8ZjEAM
 DdODGe8rjwRI7KTtAmN2wyey2CBnLo80i5/iSf/iRULVPWSINt0stwSS1mfgqEeTDr6jr4Tcg2l
 0fhomIXei6EdBdHh0zhA/8chuiHYxZphCpll5jm4ChDBa2ZeJpC4n4OGk6Fg6ueAhms5qnIKRgo
 dV5nL8lcKprdSazRe9yUN54SEIJk+plxNLdnMaGMqYoIjfrIq33sHnOkV3fDGJ8P6JLGINrUFe1
 HQlEThKJVuGugq42Q7Xhwi2h4H3EyO75aNBxOjQ5nbgvq9hx
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

Generalize v3d_lookup_bos(), v3d_lock_bo_reservations() (renamed to
v3d_submit_lock_reservations()), v3d_attach_fences_and_unlock_reservation()
and v3d_setup_csd_jobs_and_bos() so they all take a struct v3d_submit
and operate on every job in the chain.

Now, the locking helper now iterates over all jobs and locks the union of
their BOs under one DRM exec, using DRM_EXEC_IGNORE_DUPLICATES to tolerate
shared BO references. The fence-attach helper similarly walks every job
and attaches the chain's last fence to all touched BOs.

Update CL/TFU/CSD/CPU ioctls to use the new helper signatures. The CPU
ioctl still uses two struct v3d_submit instances (one for the CPU job,
one for the indirect CSD jobs) and keeps its manual mutex/push/two-pass
fence-attach flow. Converting the indirect CSD path into the unified
chain is done in the next commit.

No functional change.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_submit.c | 295 ++++++++++++++-------------------------
 1 file changed, 108 insertions(+), 187 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index ef003ca6b42a..899128fc2bd5 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -20,32 +20,51 @@
  * to v3d, so we don't attach dma-buf fences to them.
  */
 static int
-v3d_lock_bo_reservations(struct v3d_job *job, struct drm_exec *exec)
+v3d_submit_lock_reservations(struct v3d_submit *submit)
 {
-	int i, ret;
+	int i, j, ret;
 
-	drm_exec_init(exec, DRM_EXEC_INTERRUPTIBLE_WAIT, job->bo_count);
-	drm_exec_until_all_locked(exec) {
-		ret = drm_exec_prepare_array(exec, job->bo, job->bo_count, 1);
-	}
+	drm_exec_init(&submit->exec,
+		      DRM_EXEC_INTERRUPTIBLE_WAIT | DRM_EXEC_IGNORE_DUPLICATES, 0);
+	drm_exec_until_all_locked(&submit->exec) {
+		for (i = 0; i < submit->job_count; i++) {
+			struct v3d_job *job = submit->jobs[i];
 
-	if (ret)
-		goto fail;
-
-	for (i = 0; i < job->bo_count; i++) {
-		ret = drm_sched_job_add_implicit_dependencies(&job->base,
-							      job->bo[i], true);
+			ret = drm_exec_prepare_array(&submit->exec, job->bo,
+						     job->bo_count, 1);
+			if (ret)
+				break;
+		}
+		drm_exec_retry_on_contention(&submit->exec);
 		if (ret)
 			goto fail;
 	}
 
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
+	}
+
 	return 0;
 
 fail:
-	drm_exec_fini(exec);
+	drm_exec_fini(&submit->exec);
 	return ret;
 }
 
+static void
+v3d_submit_unlock_reservations(struct v3d_submit *submit)
+{
+	drm_exec_fini(&submit->exec);
+}
+
 /**
  * v3d_lookup_bos() - Sets up job->bo[] with the GEM objects
  * referenced by the job.
@@ -63,25 +82,23 @@ v3d_lock_bo_reservations(struct v3d_job *job, struct drm_exec *exec)
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
@@ -142,25 +159,6 @@ void v3d_job_put(struct v3d_job *job)
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
@@ -201,47 +199,6 @@ v3d_job_add_syncobjs(struct v3d_job *job, struct drm_file *file_priv,
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
@@ -370,31 +327,34 @@ v3d_submit_cleanup_jobs(struct v3d_submit *submit)
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
 
-	for (i = 0; i < job->bo_count; i++) {
-		/* XXX: Use shared fences for read-only objects. */
-		dma_resv_add_fence(job->bo[i]->resv, job->done_fence,
-				   DMA_RESV_USAGE_WRITE);
+	/* The submission's last fence covers the entire submission. Attach it
+	 * to every BO touched by any job in the submission.
+	 */
+	for (int i = 0; i < submit->job_count; i++) {
+		struct v3d_job *job = submit->jobs[i];
+
+		for (int j = 0; j < job->bo_count; j++) {
+			/* XXX: Use shared fences for read-only objects. */
+			dma_resv_add_fence(job->bo[j]->resv, last_job->done_fence,
+					   DMA_RESV_USAGE_WRITE);
+		}
 	}
 
-	drm_exec_fini(exec);
+	v3d_submit_unlock_reservations(submit);
 
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
@@ -402,9 +362,9 @@ v3d_attach_fences_and_unlock_reservation(struct drm_file *file_priv,
 
 	/* If multiple semaphores extension is supported */
 	if (se->out_sync_count) {
-		for (i = 0; i < se->out_sync_count; i++) {
+		for (int i = 0; i < se->out_sync_count; i++) {
 			drm_syncobj_replace_fence(se->out_syncs[i].syncobj,
-						  done_fence);
+						  last_job->done_fence);
 			drm_syncobj_put(se->out_syncs[i].syncobj);
 		}
 		kvfree(se->out_syncs);
@@ -412,46 +372,36 @@ v3d_attach_fences_and_unlock_reservation(struct drm_file *file_priv,
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
+	return v3d_submit_lock_reservations(submit);
 }
 
 static void
@@ -1086,14 +1036,11 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
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
+	ret = v3d_submit_lock_reservations(&submit);
 	if (ret)
 		goto fail;
 
@@ -1105,18 +1052,14 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
 	if (ret)
 		goto fail_unreserve;
 
-	v3d_attach_fences_and_unlock_reservation(file_priv,
-						 submit.jobs[submit.job_count - 1],
-						 &submit.exec,
-						 args->out_sync, &se,
-						 submit.jobs[submit.job_count - 1]->done_fence);
+	v3d_attach_fences_and_unlock_reservation(&submit, args->out_sync, &se);
 
 	v3d_submit_put_jobs(&submit);
 
 	return 0;
 
 fail_unreserve:
-	drm_exec_fini(&submit.exec);
+	v3d_submit_unlock_reservations(&submit);
 fail:
 	v3d_submit_cleanup_jobs(&submit);
 	v3d_put_multisync_post_deps(&se);
@@ -1194,7 +1137,7 @@ v3d_submit_tfu_ioctl(struct drm_device *dev, void *data,
 		job->base.bo[job->base.bo_count] = bo;
 	}
 
-	ret = v3d_lock_bo_reservations(&job->base, &submit.exec);
+	ret = v3d_submit_lock_reservations(&submit);
 	if (ret)
 		goto fail;
 
@@ -1202,17 +1145,14 @@ v3d_submit_tfu_ioctl(struct drm_device *dev, void *data,
 	if (ret)
 		goto fail_unreserve;
 
-	v3d_attach_fences_and_unlock_reservation(file_priv,
-						 &job->base, &submit.exec,
-						 args->out_sync, &se,
-						 job->base.done_fence);
+	v3d_attach_fences_and_unlock_reservation(&submit, args->out_sync, &se);
 
 	v3d_submit_put_jobs(&submit);
 
 	return 0;
 
 fail_unreserve:
-	drm_exec_fini(&submit.exec);
+	v3d_submit_unlock_reservations(&submit);
 fail:
 	v3d_submit_cleanup_jobs(&submit);
 	v3d_put_multisync_post_deps(&se);
@@ -1236,8 +1176,6 @@ v3d_submit_csd_ioctl(struct drm_device *dev, void *data,
 	struct v3d_submit submit = { .v3d = to_v3d_dev(dev), .file_priv = file_priv };
 	struct drm_v3d_submit_csd *args = data;
 	struct v3d_submit_ext se = {0};
-	struct v3d_csd_job *job = NULL;
-	struct v3d_job *clean_job = NULL;
 	int ret;
 
 	trace_v3d_submit_csd_ioctl(dev, args->cfg[5], args->cfg[6]);
@@ -1263,14 +1201,10 @@ v3d_submit_csd_ioctl(struct drm_device *dev, void *data,
 		}
 	}
 
-	ret = v3d_setup_csd_jobs_and_bos(file_priv, submit.v3d, args,
-					 &job, &clean_job, &se, &submit.exec);
+	ret = v3d_setup_csd_jobs_and_bos(&submit, args, &se);
 	if (ret)
 		goto fail;
 
-	submit.jobs[submit.job_count++] = &job->base;
-	submit.jobs[submit.job_count++] = clean_job;
-
 	ret = v3d_attach_perfmon_to_jobs(&submit, args->perfmon_id);
 	if (ret)
 		goto fail_unreserve;
@@ -1279,18 +1213,14 @@ v3d_submit_csd_ioctl(struct drm_device *dev, void *data,
 	if (ret)
 		goto fail_unreserve;
 
-	v3d_attach_fences_and_unlock_reservation(file_priv,
-						 clean_job,
-						 &submit.exec,
-						 args->out_sync, &se,
-						 clean_job->done_fence);
+	v3d_attach_fences_and_unlock_reservation(&submit, args->out_sync, &se);
 
 	v3d_submit_put_jobs(&submit);
 
 	return 0;
 
 fail_unreserve:
-	drm_exec_fini(&submit.exec);
+	v3d_submit_unlock_reservations(&submit);
 fail:
 	v3d_submit_cleanup_jobs(&submit);
 	v3d_put_multisync_post_deps(&se);
@@ -1321,13 +1251,14 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
 		     struct drm_file *file_priv)
 {
 	struct v3d_dev *v3d = to_v3d_dev(dev);
+	struct v3d_submit submit = { .v3d = to_v3d_dev(dev), .file_priv = file_priv };
+	struct v3d_submit indirect_submit = { .v3d = to_v3d_dev(dev), .file_priv = file_priv };
 	struct drm_v3d_submit_cpu *args = data;
 	struct v3d_submit_ext se = {0};
 	struct v3d_submit_ext *out_se = NULL;
 	struct v3d_cpu_job *cpu_job = NULL;
 	struct v3d_csd_job *csd_job = NULL;
 	struct v3d_job *clean_job = NULL;
-	struct drm_exec exec;
 	int ret;
 
 	if (args->flags && !(args->flags & DRM_V3D_SUBMIT_EXTENSION)) {
@@ -1335,7 +1266,8 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
 		return -EINVAL;
 	}
 
-	ret = v3d_job_allocate(v3d, (void *)&cpu_job, sizeof(*cpu_job));
+	ret = v3d_submit_add_job(&submit, (void **)&cpu_job, sizeof(*cpu_job),
+				 v3d_job_free, V3D_CPU);
 	if (ret)
 		return ret;
 
@@ -1362,34 +1294,31 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
 
 	trace_v3d_submit_cpu_ioctl(&v3d->drm, cpu_job->job_type);
 
-	ret = v3d_job_init(v3d, file_priv, &cpu_job->base,
-			   v3d_job_free, 0, &se, V3D_CPU);
-	if (ret) {
-		v3d_job_deallocate((void *)&cpu_job);
+	ret = v3d_job_add_syncobjs(&cpu_job->base, file_priv, 0, &se, V3D_CPU);
+	if (ret)
 		goto fail;
-	}
 
 	if (cpu_job->job_type == V3D_CPU_JOB_TYPE_INDIRECT_CSD) {
-		ret = v3d_setup_csd_jobs_and_bos(file_priv, v3d,
+		ret = v3d_setup_csd_jobs_and_bos(&indirect_submit,
 						 &cpu_job->indirect_csd.args,
-						 &cpu_job->indirect_csd.job,
-						 &cpu_job->indirect_csd.clean_job,
-						 NULL,
-						 &cpu_job->indirect_csd.exec);
+						 NULL);
 		if (ret)
 			goto fail;
+
+		cpu_job->indirect_csd.job = container_of(indirect_submit.jobs[0],
+							 struct v3d_csd_job, base);
+		cpu_job->indirect_csd.clean_job = indirect_submit.jobs[1];
 	}
 
 	clean_job = cpu_job->indirect_csd.clean_job;
 	csd_job = cpu_job->indirect_csd.job;
 
 	if (args->bo_handle_count) {
-		ret = v3d_lookup_bos(dev, file_priv, &cpu_job->base,
-				     args->bo_handles, args->bo_handle_count);
+		ret = v3d_lookup_bos(&submit, args->bo_handles, args->bo_handle_count);
 		if (ret)
 			goto fail;
 
-		ret = v3d_lock_bo_reservations(&cpu_job->base, &exec);
+		ret = v3d_submit_lock_reservations(&submit);
 		if (ret)
 			goto fail;
 	}
@@ -1421,36 +1350,28 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
 
 	out_se = (cpu_job->job_type == V3D_CPU_JOB_TYPE_INDIRECT_CSD) ? NULL : &se;
 
-	v3d_attach_fences_and_unlock_reservation(file_priv,
-						 &cpu_job->base,
-						 &exec, 0,
-						 out_se, cpu_job->base.done_fence);
+	v3d_attach_fences_and_unlock_reservation(&submit, 0, out_se);
 
 	switch (cpu_job->job_type) {
 	case V3D_CPU_JOB_TYPE_INDIRECT_CSD:
-		v3d_attach_fences_and_unlock_reservation(file_priv,
-							 clean_job,
-							 &cpu_job->indirect_csd.exec,
-							 0, &se, clean_job->done_fence);
+		v3d_attach_fences_and_unlock_reservation(&indirect_submit, 0, &se);
 		break;
 	default:
 		break;
 	}
 
-	v3d_job_put(&cpu_job->base);
-	v3d_job_put(&csd_job->base);
-	v3d_job_put(clean_job);
+	v3d_submit_put_jobs(&submit);
+	v3d_submit_put_jobs(&indirect_submit);
 
 	return 0;
 
 fail_unreserve:
 	mutex_unlock(&v3d->sched_lock);
-	drm_exec_fini(&exec);
-	drm_exec_fini(&cpu_job->indirect_csd.exec);
+	v3d_submit_unlock_reservations(&submit);
+	v3d_submit_unlock_reservations(&indirect_submit);
 fail:
-	v3d_job_cleanup((void *)cpu_job);
-	v3d_job_cleanup((void *)csd_job);
-	v3d_job_cleanup(clean_job);
+	v3d_submit_cleanup_jobs(&submit);
+	v3d_submit_cleanup_jobs(&indirect_submit);
 	v3d_put_multisync_post_deps(&se);
 	kvfree(cpu_job->timestamp_query.queries);
 	kvfree(cpu_job->performance_query.queries);

-- 
2.54.0

