Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91631CD6E75
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 20:33:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F150E10F89F;
	Thu,  4 Jun 2026 20:33:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="qVobLGn7";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CCCE10F89F
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 20:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=C5MFbOnlOEx3UDRh8Fze0wjJrZY+m8pVRvrkWJUrIAI=; b=qVobLGn7FqDSpLhzUtbQJ3Ub9i
 WU2PSOzOspZ102178e+bXQ3+3RgqjqRf1W7oyaZ+D4AtsiEt9FsTXabiYA1q7KVqLm0VJh14LiHSI
 7ScotZ3Z6pxyi83WlUooSVK1F0PJyFY8/u+1Wl0YmWyFZpFY87CO78Y+mq2k2iPWYg1x6n1r7Wkam
 hN64CeTWquz20WmQkWV5Evd+qI10MOgVwICNJh7PPQP+rQY6Yt06llG5nQizL54hSRR4s0Eq98A/x
 mpvYJz2nss2a6GKgsNynMfcoW35fBHoS3XbLDnqt2gyAf3pcoWA3B+4F8FKSkLkDUmvP4aJBPO6NP
 nr5jONig==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wVEkf-00CoGD-4f; Thu, 04 Jun 2026 22:33:17 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Thu, 04 Jun 2026 17:32:25 -0300
Subject: [PATCH v4 12/12] drm/v3d: Ensure atomic submissions in
 v3d_submit_jobs()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260604-v3d-sched-misc-fixes-v4-12-c068f5bf5ccf@igalia.com>
References: <20260604-v3d-sched-misc-fixes-v4-0-c068f5bf5ccf@igalia.com>
In-Reply-To: <20260604-v3d-sched-misc-fixes-v4-0-c068f5bf5ccf@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6032; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=9NN94mP8H1l6ifsMpcT8b4HSet2oxea/e078fqNxFy0=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqIeDUyr2ZJ5Jxj88sXOHJVo6EKFVv8TJlc5CCh
 kzpnwWDWeeJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCaiHg1AAKCRA/8w6Kdoj6
 qvWSB/92LllYMyFI/SITmpLhttfmab6u4hpGu/BM+zOCv7XsgV8Kpr1haLtPSJICeOOpeKtZMCN
 0wjV1cMQUtKuoLpK5YAObkWPTPE+tFld3h8V/F8iT/WGt2yYOlZ2twbua+BnYLv4NahrgmPYmST
 F7Zairdx0tz+N+9GNjbsqwPVvGfEZlKrYigvUsilQQ1rpCKjWnjcHypxU5SqYtV2+Qj3GSH+H5B
 2rqBCZsnzh1Xup7WgMflwU9m1aSoHYHsG7RFnyI7X8mRVkpvkRJwq8sE6TXabdaPxhKEYf72J2t
 b8hWYfRhSBAoQkTtV2O2dVCa8O7vewzk2gM4UHbUaWr4zBAz
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
Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_sched.c  |  6 ++++
 drivers/gpu/drm/v3d/v3d_submit.c | 65 ++++++++++++++++++++--------------------
 2 files changed, 39 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
index 7f9a71022e5e..53deae1a2eda 100644
--- a/drivers/gpu/drm/v3d/v3d_sched.c
+++ b/drivers/gpu/drm/v3d/v3d_sched.c
@@ -657,6 +657,9 @@ v3d_cpu_job_run(struct drm_sched_job *sched_job)
 	struct v3d_cpu_job *job = to_cpu_job(sched_job);
 	struct v3d_dev *v3d = job->base.v3d;
 
+	if (unlikely(job->base.base.s_fence->finished.error))
+		return NULL;
+
 	if (job->job_type >= ARRAY_SIZE(cpu_job_function)) {
 		drm_dbg(&v3d->drm, "Unknown CPU job: %d\n", job->job_type);
 		return NULL;
@@ -680,6 +683,9 @@ v3d_cache_clean_job_run(struct drm_sched_job *sched_job)
 	struct v3d_job *job = to_v3d_job(sched_job);
 	struct v3d_dev *v3d = job->v3d;
 
+	if (unlikely(job->base.s_fence->finished.error))
+		return NULL;
+
 	v3d_job_start_stats(job);
 
 	v3d_clean_caches(v3d);
diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index 294fc4e327f6..4f6fc2d94ccb 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -368,19 +368,6 @@ v3d_submit_process_post_deps(struct v3d_submit *submit, struct drm_syncobj *sync
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
 v3d_submit_jobs(struct v3d_submit *submit, struct drm_syncobj *sync_out,
 		struct v3d_submit_ext *se)
@@ -393,16 +380,23 @@ v3d_submit_jobs(struct v3d_submit *submit, struct drm_syncobj *sync_out,
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
 
+	for (int i = 1; i < submit->job_count; i++) {
+		ret = drm_sched_job_add_dependency(&submit->jobs[i]->base,
+						   dma_fence_get(submit->jobs[i - 1]->done_fence));
+		if (ret)
+			goto err;
+	}
+
+	for (int i = 0; i < submit->job_count; i++)
+		drm_sched_entity_push_job(&submit->jobs[i]->base);
+
 	mutex_unlock(&v3d->sched_lock);
 
 	v3d_submit_attach_object_fences(submit);
@@ -414,7 +408,18 @@ v3d_submit_jobs(struct v3d_submit *submit, struct drm_syncobj *sync_out,
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
+	v3d_submit_put_jobs(submit);
+
 	return ret;
 }
 
@@ -1102,14 +1107,13 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
 
 	ret = v3d_submit_jobs(&submit, sync_out, &se);
 	if (ret)
-		goto fail_unreserve;
+		goto fail_submit;
 
 	return 0;
 
-fail_unreserve:
-	v3d_submit_unlock_reservations(&submit);
 fail:
 	v3d_submit_cleanup_jobs(&submit);
+fail_submit:
 	v3d_submit_put_post_deps(sync_out, &se);
 
 	return ret;
@@ -1200,14 +1204,13 @@ v3d_submit_tfu_ioctl(struct drm_device *dev, void *data,
 
 	ret = v3d_submit_jobs(&submit, sync_out, &se);
 	if (ret)
-		goto fail_unreserve;
+		goto fail_submit;
 
 	return 0;
 
-fail_unreserve:
-	v3d_submit_unlock_reservations(&submit);
 fail:
 	v3d_submit_cleanup_jobs(&submit);
+fail_submit:
 	v3d_submit_put_post_deps(sync_out, &se);
 
 	return ret;
@@ -1276,14 +1279,13 @@ v3d_submit_csd_ioctl(struct drm_device *dev, void *data,
 
 	ret = v3d_submit_jobs(&submit, sync_out, &se);
 	if (ret)
-		goto fail_unreserve;
+		goto fail_submit;
 
 	return 0;
 
-fail_unreserve:
-	v3d_submit_unlock_reservations(&submit);
 fail:
 	v3d_submit_cleanup_jobs(&submit);
+fail_submit:
 	v3d_submit_put_post_deps(sync_out, &se);
 
 	return ret;
@@ -1384,14 +1386,13 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
 
 	ret = v3d_submit_jobs(&submit, NULL, &se);
 	if (ret)
-		goto fail_unreserve;
+		goto fail_submit;
 
 	return 0;
 
-fail_unreserve:
-	v3d_submit_unlock_reservations(&submit);
 fail:
 	v3d_submit_cleanup_jobs(&submit);
+fail_submit:
 	v3d_submit_put_post_deps(NULL, &se);
 
 	return ret;

-- 
2.54.0

