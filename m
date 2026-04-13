Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F265F34C5E
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 15:06:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9ECA710E4C1;
	Mon, 13 Apr 2026 15:06:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="gLnXugWK";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5859210E4C4
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 15:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WS7/2AWxtzdzyJt6Dd9HWvXtaFS5FMnfzOAwjt/1iPM=; b=gLnXugWKNpJCysiPT4nbXECFGy
 qpL8hiI41JYIzegMxePEgKJ/CBnOHXqwujrxaSuIaMlqAzdjeklJoJp0Jdz3uHmNZUX03okeub2yV
 s0WR1hzE7RHAN7vW9jWhsODWoojLtsBZDgSE1ktha/2VSm79XqYu0BCiFVUszjnz3i7IWnf7K/p5q
 A/EX3Odd8v+qqjkcK5YZASz5RszccJ4qYH5VF7ogzc84Knr8iimI5hYd40B945cTHEFGisvgdYFCU
 xJbBoFoJoC3FxV2It458xSTW3+4JP0jzqzu1SwO3w2BbtlmODx1+QADf7jP7Y0VQFGloDhR/uwyis
 P++nZaqQ==;
Received: from [189.7.87.169] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wCIrY-00FSq1-0F; Mon, 13 Apr 2026 17:06:08 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Mon, 13 Apr 2026 12:03:25 -0300
Subject: [PATCH 10/10] drm/v3d: Ensure atomic submissions in v3d_submit_jobs()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260413-v3d-sched-misc-fixes-v1-10-bac63a8ceb6c@igalia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5916; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=O1diIKmly8N03xXeIWTk376SYCZEOwVl7XFHZ/GHgAU=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBp3QYuPDS3CKQ41wZ83vSvcLqCTlG1Y/fKlYK8a
 34EHxZTxMGJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCad0GLgAKCRA/8w6Kdoj6
 qlnPB/9JONpNMOWIHG/D3kuISyfuBTtk5nxXlCpi2BNZC+ErgRolPPFfg4uUqnRiEaxI92BxnT+
 pJmHOAu2OXbMET55IpipUteWbfVVauDLkVJaTZyZ4q9xzS2jcDZBajHFN1T71tnJ6TAStoWFhji
 kAR8zTc95QAYqaGHN/q1nE9W34reWhgoJrN432Na3YjAbtfkkaItk30c+S2shmeezYvcmi+3hF1
 rOvBi7gWp1QIrWR+Wv9v8doeX9bF/JrmATTQh+O2cnheqGgIL1x9f8Qk9hDcwS0hzJhSTWV+cii
 IdGnlxMll3n4oTZXCJFWlbQz7sKm0XupH6/mvBT9auwNKAFs
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

Adapt all submit ioctls to proceed unconditionally to fence attachment,
even if v3d_submit_jobs() fails, and return the error code to userspace.

Suggested-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_sched.c  |  6 ++++
 drivers/gpu/drm/v3d/v3d_submit.c | 63 ++++++++++++++++------------------------
 2 files changed, 31 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
index f3999678e5da..cf1be78e4d27 100644
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
index 36402fc25c10..46d8bedce97c 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -268,41 +268,40 @@ v3d_attach_perfmon_to_jobs(struct v3d_submit *submit, u32 perfmon_id)
 	return 0;
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
 	struct v3d_dev *v3d = submit->v3d;
-	int ret;
+	int i, j, ret = 0;
 
 	guard(mutex)(&v3d->sched_lock);
 
-	for (int i = 0; i < submit->job_count; i++) {
+	for (i = 0; i < submit->job_count; i++) {
 		struct v3d_job *job = submit->jobs[i];
 
-		v3d_push_job(job);
+		drm_sched_job_arm(&job->base);
+		job->done_fence = dma_fence_get(&job->base.s_fence->finished);
 
-		if (i + 1 < submit->job_count) {
-			ret = drm_sched_job_add_dependency(&submit->jobs[i + 1]->base,
-							   dma_fence_get(job->done_fence));
-			if (ret)
-				return ret;
+		/* put by scheduler job completion */
+		kref_get(&job->refcount);
+	}
+
+	for (i = 0; i + 1 < submit->job_count; i++) {
+		ret = drm_sched_job_add_dependency(&submit->jobs[i + 1]->base,
+						   dma_fence_get(submit->jobs[i]->done_fence));
+		if (ret) {
+			/* Mark every armed job as failed so run_job() skips execution */
+			for (j = 0; j < submit->job_count; j++)
+				dma_fence_set_error(&submit->jobs[j]->base.s_fence->finished,
+						    ret);
+			break;
 		}
 	}
 
-	return 0;
+	for (i = 0; i < submit->job_count; i++)
+		drm_sched_entity_push_job(&submit->jobs[i]->base);
+
+	return ret;
 }
 
 static void
@@ -1028,15 +1027,13 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
 		goto fail_perfmon;
 
 	ret = v3d_submit_jobs(&submit);
-	if (ret)
-		goto fail_perfmon;
 
 	v3d_attach_fences_and_unlock_reservation(&submit, args->out_sync, &se);
 
 	for (int i = 0; i < submit.job_count; i++)
 		v3d_job_put(submit.jobs[i]);
 
-	return 0;
+	return ret;
 
 fail_perfmon:
 	drm_exec_fini(&submit.exec);
@@ -1127,17 +1124,13 @@ v3d_submit_tfu_ioctl(struct drm_device *dev, void *data,
 		goto fail;
 
 	ret = v3d_submit_jobs(&submit);
-	if (ret)
-		goto fail_submit;
 
 	v3d_attach_fences_and_unlock_reservation(&submit, args->out_sync, &se);
 
 	v3d_job_put(&job->base);
 
-	return 0;
+	return ret;
 
-fail_submit:
-	drm_exec_fini(&submit.exec);
 fail:
 	v3d_job_cleanup((void *)job);
 	v3d_put_multisync_post_deps(&se);
@@ -1199,15 +1192,13 @@ v3d_submit_csd_ioctl(struct drm_device *dev, void *data,
 		goto fail_perfmon;
 
 	ret = v3d_submit_jobs(&submit);
-	if (ret)
-		goto fail_perfmon;
 
 	v3d_attach_fences_and_unlock_reservation(&submit, args->out_sync, &se);
 
 	for (int i = 0; i < submit.job_count; i++)
 		v3d_job_put(submit.jobs[i]);
 
-	return 0;
+	return ret;
 
 fail_perfmon:
 	drm_exec_fini(&submit.exec);
@@ -1314,18 +1305,14 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
 	}
 
 	ret = v3d_submit_jobs(&submit);
-	if (ret)
-		goto fail_unlock;
 
 	v3d_attach_fences_and_unlock_reservation(&submit, 0, &se);
 
 	for (int i = 0; i < submit.job_count; i++)
 		v3d_job_put(submit.jobs[i]);
 
-	return 0;
+	return ret;
 
-fail_unlock:
-	drm_exec_fini(&submit.exec);
 fail:
 	for (int i = 0; i < submit.job_count; i++)
 		v3d_job_cleanup(submit.jobs[i]);

-- 
2.53.0

