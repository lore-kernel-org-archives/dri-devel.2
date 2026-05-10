Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8C12CD37B2
	for <dri-devel@archiver.kernel.org>; Sun, 10 May 2026 22:13:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4235C10E449;
	Sun, 10 May 2026 22:13:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="GtKJBeY4";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9871C10E449
 for <dri-devel@lists.freedesktop.org>; Sun, 10 May 2026 22:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DngzamtjuG2UdnUUhgu5fLJkV2pL6yX7PD6FxATkay8=; b=GtKJBeY4v8cHNsk+Tg53D03E3A
 V/rhodXou5MhFx7YTD6BS6hKYxEIU+rKkpuGLvFcnvMYP/VoZKQe2oQ90wi6RA/eBm1CUGlbEtwyM
 HKxEQZDs9UB2bRROEmGDipFUdhLqxtU5XvU4V1ELHNlWTGu9wFf752mZskRuHj/WOtp7bZS4IPXP3
 zZB9gChHN+zYDsHS8ywS1u5E4Lsw1V2wnRCHnuIXCmUvc3SNusgAxj+zJ3DYVyPOqu3QXtCBaJFDt
 jPSAmpf6Kro8B+XYc6i8ln14BGPOuWQNpSdd6g3wdNYXcN6WagXQsdPwuAsRLWN7Ns4QdKKB7qTUE
 924x6oaQ==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wMCOf-008k1J-TX; Mon, 11 May 2026 00:13:13 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Sun, 10 May 2026 19:12:11 -0300
Subject: [PATCH v2 14/14] drm/v3d: Ensure atomic submissions in
 v3d_submit_jobs()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260510-v3d-sched-misc-fixes-v2-14-ca4aba343ef6@igalia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6080; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=1Q2AogcBIenq09ihFX2u8ErPMsnNL9p+9sj//V3dnHw=;
 b=kA0DAAoBP/MOinaI+qoByyZiAGoBArWhimZYFIM2nsKsVTBSHjS+uZEqLLaMxPu1LW67LmB6Z
 okBMwQAAQoAHRYhBPjkXX0BFncHKaZ30T/zDop2iPqqBQJqAQK1AAoJED/zDop2iPqqXtsIAJ1P
 TqblBaMDbdmvrHFh6Wlo8W7Kc+IL3EhP82UnbI86gUyxyc6ZdWKqAd2UQx04Re2eoegIFPdLOGg
 vwjyqaafSTL7vMRoTMpVxSCKPTbSn0G8o5xJBuvn2zAaanTbn03L9XjBuvhWwyyU5fC727xCXoH
 f8o8MCck+zAPJJ+Mct1X8BLI3v/eMKv/Vf2c/w5KW4lpA+W+W9eUoYMeyDxP40L3VdA40LXDJdW
 pOlRg6m409RSkBOL6YESguWQPYPgHjKfwsaEfHx5acsUvYeJpqzwhTxXs2cfmHCvHT/07IHzY4w
 jL0+RtKRGi8YrpIURK/EnLlMG62/No5hY4YLYPw=
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

Currently, v3d_submit_jobs() arms and pushes each job one at a time,
wiring dependencies between consecutive jobs after each push. If
drm_sched_job_add_dependency() fails midway, the already-pushed jobs are
scheduler-owned and will be submitted to the GPU for execution, even though
the subsequent jobs won't be submitted.

This breaks the atomicity of the submissions, as only some of the jobs
from a submission would be submitted to the hardware, while the other part
fails.

Restructure v3d_submit_jobs() into three phases: (1) arm all jobs belonging
to a given submission, (2) wire inter-job dependencies, and (3) push all
jobs to the scheduler unconditionally. Phase (2) can fail; on failure,
it marks every armed job finished fence with an error, so that run_job()
callbacks skip hardware execution.

This guarantees that every armed job is always pushed, either to run
or to be skipped, and it also ensures the atomicity of a submission.

Suggested-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_sched.c  |  6 ++++
 drivers/gpu/drm/v3d/v3d_submit.c | 76 +++++++++++++++++++++++-----------------
 2 files changed, 50 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
index cc3212e2cb5d..6e890b8547e5 100644
--- a/drivers/gpu/drm/v3d/v3d_sched.c
+++ b/drivers/gpu/drm/v3d/v3d_sched.c
@@ -670,6 +670,9 @@ v3d_cpu_job_run(struct drm_sched_job *sched_job)
 	struct v3d_cpu_job *job = to_cpu_job(sched_job);
 	struct v3d_dev *v3d = job->base.v3d;
 
+	if (unlikely(job->base.base.s_fence->finished.error))
+		return NULL;
+
 	if (job->job_type >= ARRAY_SIZE(cpu_job_function)) {
 		drm_dbg(&v3d->drm, "Unknown CPU job: %d\n", job->job_type);
 		return NULL;
@@ -693,6 +696,9 @@ v3d_cache_clean_job_run(struct drm_sched_job *sched_job)
 	struct v3d_job *job = to_v3d_job(sched_job);
 	struct v3d_dev *v3d = job->v3d;
 
+	if (unlikely(job->base.s_fence->finished.error))
+		return NULL;
+
 	v3d_job_start_stats(job);
 
 	v3d_clean_caches(v3d);
diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index afe54e73a461..11ba3c977e2d 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -292,19 +292,6 @@ v3d_submit_attach_object_fences(struct v3d_submit *submit)
 	}
 }
 
-static void
-v3d_push_job(struct v3d_job *job)
-{
-	drm_sched_job_arm(&job->base);
-
-	job->done_fence = dma_fence_get(&job->base.s_fence->finished);
-
-	/* put by scheduler job completion */
-	kref_get(&job->refcount);
-
-	drm_sched_entity_push_job(&job->base);
-}
-
 static int
 v3d_submit_jobs(struct v3d_submit *submit)
 {
@@ -316,16 +303,23 @@ v3d_submit_jobs(struct v3d_submit *submit)
 	for (int i = 0; i < submit->job_count; i++) {
 		struct v3d_job *job = submit->jobs[i];
 
-		v3d_push_job(job);
+		drm_sched_job_arm(&job->base);
+		job->done_fence = dma_fence_get(&job->base.s_fence->finished);
 
-		if (i + 1 < submit->job_count) {
-			ret = drm_sched_job_add_dependency(&submit->jobs[i + 1]->base,
-							   dma_fence_get(job->done_fence));
-			if (ret)
-				goto err;
-		}
+		/* put by scheduler job completion */
+		kref_get(&job->refcount);
 	}
 
+	for (int i = 0; i + 1 < submit->job_count; i++) {
+		ret = drm_sched_job_add_dependency(&submit->jobs[i + 1]->base,
+						   dma_fence_get(submit->jobs[i]->done_fence));
+		if (ret)
+			goto err;
+	}
+
+	for (int i = 0; i < submit->job_count; i++)
+		drm_sched_entity_push_job(&submit->jobs[i]->base);
+
 	mutex_unlock(&v3d->sched_lock);
 
 	v3d_submit_attach_object_fences(submit);
@@ -334,7 +328,17 @@ v3d_submit_jobs(struct v3d_submit *submit)
 	return 0;
 
 err:
+	/* Mark every armed job as failed so run_job() skips execution */
+	for (int i = 0; i < submit->job_count; i++)
+		dma_fence_set_error(&submit->jobs[i]->base.s_fence->finished, ret);
+
+	for (int i = 0; i < submit->job_count; i++)
+		drm_sched_entity_push_job(&submit->jobs[i]->base);
+
 	mutex_unlock(&v3d->sched_lock);
+
+	v3d_submit_unlock_reservations(submit);
+
 	return ret;
 }
 
@@ -1068,8 +1072,11 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
 		goto fail_unreserve;
 
 	ret = v3d_submit_jobs(&submit);
-	if (ret)
-		goto fail_unreserve;
+	if (ret) {
+		v3d_submit_put_jobs(&submit);
+		v3d_submit_put_post_deps(sync_out, &se);
+		return ret;
+	}
 
 	v3d_submit_process_post_deps(&submit, sync_out, &se);
 	v3d_submit_put_jobs(&submit);
@@ -1167,16 +1174,17 @@ v3d_submit_tfu_ioctl(struct drm_device *dev, void *data,
 		goto fail;
 
 	ret = v3d_submit_jobs(&submit);
-	if (ret)
-		goto fail_unreserve;
+	if (ret) {
+		v3d_submit_put_jobs(&submit);
+		v3d_submit_put_post_deps(sync_out, &se);
+		return ret;
+	}
 
 	v3d_submit_process_post_deps(&submit, sync_out, &se);
 	v3d_submit_put_jobs(&submit);
 
 	return 0;
 
-fail_unreserve:
-	v3d_submit_unlock_reservations(&submit);
 fail:
 	v3d_submit_cleanup_jobs(&submit);
 	v3d_submit_put_post_deps(sync_out, &se);
@@ -1241,8 +1249,11 @@ v3d_submit_csd_ioctl(struct drm_device *dev, void *data,
 		goto fail_unreserve;
 
 	ret = v3d_submit_jobs(&submit);
-	if (ret)
-		goto fail_unreserve;
+	if (ret) {
+		v3d_submit_put_jobs(&submit);
+		v3d_submit_put_post_deps(sync_out, &se);
+		return ret;
+	}
 
 	v3d_submit_process_post_deps(&submit, sync_out, &se);
 	v3d_submit_put_jobs(&submit);
@@ -1349,16 +1360,17 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
 	}
 
 	ret = v3d_submit_jobs(&submit);
-	if (ret)
-		goto fail_unreserve;
+	if (ret) {
+		v3d_submit_put_jobs(&submit);
+		v3d_submit_put_post_deps(NULL, &se);
+		return ret;
+	}
 
 	v3d_submit_process_post_deps(&submit, NULL, &se);
 	v3d_submit_put_jobs(&submit);
 
 	return 0;
 
-fail_unreserve:
-	v3d_submit_unlock_reservations(&submit);
 fail:
 	v3d_submit_cleanup_jobs(&submit);
 	v3d_submit_put_post_deps(NULL, &se);

-- 
2.54.0

