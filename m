Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D54CCD6E55
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 22:26:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7333A112430;
	Wed,  3 Jun 2026 22:26:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="nJf8kBY0";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54385112430
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 22:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xcQsy2Un+cHQTsC0dn6a/Ku9lmMrZZhipSQ13EbmWEI=; b=nJf8kBY0kOvTyNwVOw32OGJ/YE
 kNkcsafQJYuegjHHMk1JInC5Lyy030WN1HuLhSOPQfpiFI/kDYRT6a4bmIvFiPSpPcJ6FchA3EFnL
 jw8DTUCSxjxCRTe4zu4slvIgRJUdE/ngbpwxSV0QM80e8lK/I2D7r8k+e+AlmvxwNpSS5dRNbkuWI
 eCeA0/xpxue2+kSA0+yJo2bh9TbYm3D7ZbK7zjTPsx+AwT4qtNEJqrUD7GmuKH/1X/Z5fBKHlyBvP
 jY8TnBuOnsbZZv7Y8jk6MbUFREYfy4y08hh35G27DZs3sMqFD53RXDUj2ePl73qnT7CfzuCTMZOxN
 U/SQRZMA==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wUu2D-00CNgx-RY; Thu, 04 Jun 2026 00:26:02 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Wed, 03 Jun 2026 19:25:13 -0300
Subject: [PATCH v3 11/14] drm/v3d: Refactor CPU ioctl into unified
 submission chain
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260603-v3d-sched-misc-fixes-v3-11-d7114bba55a0@igalia.com>
References: <20260603-v3d-sched-misc-fixes-v3-0-d7114bba55a0@igalia.com>
In-Reply-To: <20260603-v3d-sched-misc-fixes-v3-0-d7114bba55a0@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5608; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=cdNiqYMmzt0ccEeXv1Yyyb0I4VTRgdOKhb5ncnz8GKc=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqIKnGijVWZ5wwrZeySXuAZxG88TidoDaCtTrAy
 tVKwyktVcOJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCaiCpxgAKCRA/8w6Kdoj6
 qtyZB/4uGdm3kHE2KVL8VZ/v+f9YtBHjN2hzD61l0SGQLnRCmUxwpAHOR8X8LvIeK0ybiK+Y1aE
 2EGyO6a9vVFOZ12gclAdI0MINGmALKBYAg0xS8YdmJExiRbLOHFOEqwKSfrsg+WVDwluDajh0g9
 sBaz70PDOFJeujCm3qJa1O1whqyJXAfa38/880Q4hAwwxtM4uwjO4eCfgmmiYppnxTN9+M+fTxu
 m6vdfuf8tawnAicEJRN5zekWC+rwQqbTUQHAqpSjPHoK3UmV7PI1yPoAyHKSA0aqc7iM0HQeOSp
 /I5fxle7VMIFBQZcSiGJ/VhEbz11icAWjqq+Y0sB55EQq/Op
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

Now that v3d_get_cpu_indirect_csd_params() is a pure parser and the
submit helpers operate on struct v3d_submit, fold the indirect CSD path
into the standard flow by appending the CSD and CLEAN_CACHE jobs to the
same struct v3d_submit as the CPU job and locking the union of all jobs'
BOs under one drm_exec. This eliminates the second drm_exec, the nested
submission, and the conditional two-pass fence attachment that the CPU
ioctl previously required for the indirect CSD path.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_drv.h    |  6 ---
 drivers/gpu/drm/v3d/v3d_submit.c | 90 ++++++++++------------------------------
 2 files changed, 23 insertions(+), 73 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
index 52ed0af67f5e..e91b1b83dc23 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.h
+++ b/drivers/gpu/drm/v3d/v3d_drv.h
@@ -425,9 +425,6 @@ struct v3d_indirect_csd_info {
 	/* Indirect CSD */
 	struct v3d_csd_job *job;
 
-	/* Clean cache job associated to the Indirect CSD job */
-	struct v3d_job *clean_job;
-
 	/* Indirect CSD args, stashed by the extension parser and later used
 	 * to create the CSD job from them.
 	 */
@@ -446,9 +443,6 @@ struct v3d_indirect_csd_info {
 
 	/* Indirect BO */
 	struct drm_gem_object *indirect;
-
-	/* Context of the Indirect CSD job */
-	struct drm_exec exec;
 };
 
 struct v3d_timestamp_query_info {
diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index 62c23feb8fbb..1df7ab528422 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -1276,15 +1276,10 @@ int
 v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
 		     struct drm_file *file_priv)
 {
-	struct v3d_dev *v3d = to_v3d_dev(dev);
 	struct v3d_submit submit = { .v3d = to_v3d_dev(dev), .file_priv = file_priv };
-	struct v3d_submit indirect_submit = { .v3d = to_v3d_dev(dev), .file_priv = file_priv };
 	struct drm_v3d_submit_cpu *args = data;
 	struct v3d_submit_ext se = {0};
-	struct v3d_submit_ext *out_se = NULL;
 	struct v3d_cpu_job *cpu_job = NULL;
-	struct v3d_csd_job *csd_job = NULL;
-	struct v3d_job *clean_job = NULL;
 	int ret;
 
 	if (args->flags && !(args->flags & DRM_V3D_SUBMIT_EXTENSION)) {
@@ -1317,90 +1312,51 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
 		goto fail;
 	}
 
-	trace_v3d_submit_cpu_ioctl(&v3d->drm, cpu_job->job_type);
+	trace_v3d_submit_cpu_ioctl(dev, cpu_job->job_type);
 
 	ret = v3d_job_add_syncobjs(&cpu_job->base, file_priv, 0, &se);
 	if (ret)
 		goto fail;
 
-	if (cpu_job->job_type == V3D_CPU_JOB_TYPE_INDIRECT_CSD) {
-		ret = v3d_setup_csd_jobs_and_bos(&indirect_submit,
-						 &cpu_job->indirect_csd.args,
-						 NULL);
-		if (ret)
-			goto fail;
-
-		ret = v3d_submit_lock_reservations(&indirect_submit);
-		if (ret)
-			goto fail;
-
-		cpu_job->indirect_csd.job = container_of(indirect_submit.jobs[0],
-							 struct v3d_csd_job, base);
-		cpu_job->indirect_csd.clean_job = indirect_submit.jobs[1];
-
-		clean_job = cpu_job->indirect_csd.clean_job;
-		csd_job = cpu_job->indirect_csd.job;
-	}
-
+	/* Look up the CPU jobs' BOs before v3d_setup_csd_jobs_and_bos() appends
+	 * the CSD and clean jobs in the case of indirect CSD job.
+	 */
 	if (args->bo_handle_count) {
 		ret = v3d_lookup_bos(&submit, args->bo_handles, args->bo_handle_count);
 		if (ret)
 			goto fail;
+	}
 
-		ret = v3d_submit_lock_reservations(&submit);
+	if (cpu_job->job_type == V3D_CPU_JOB_TYPE_INDIRECT_CSD) {
+		ret = v3d_setup_csd_jobs_and_bos(&submit, &cpu_job->indirect_csd.args,
+						 NULL);
 		if (ret)
 			goto fail;
+
+		/* The CSD job was appended at jobs[1] */
+		if (WARN_ON(submit.jobs[1]->queue != V3D_CSD)) {
+			ret = -EINVAL;
+			goto fail;
+		}
+
+		cpu_job->indirect_csd.job = container_of(submit.jobs[1], struct v3d_csd_job,
+							 base);
 	}
 
-	mutex_lock(&v3d->sched_lock);
-	v3d_push_job(&cpu_job->base);
+	ret = v3d_submit_lock_reservations(&submit);
+	if (ret)
+		goto fail;
 
-	switch (cpu_job->job_type) {
-	case V3D_CPU_JOB_TYPE_INDIRECT_CSD:
-		ret = drm_sched_job_add_dependency(&csd_job->base.base,
-						   dma_fence_get(cpu_job->base.done_fence));
-		if (ret)
-			goto fail_unreserve;
-
-		v3d_push_job(&csd_job->base);
-
-		ret = drm_sched_job_add_dependency(&clean_job->base,
-						   dma_fence_get(csd_job->base.done_fence));
-		if (ret)
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
-	v3d_attach_fences_and_unlock_reservation(&submit, 0, out_se);
-
-	switch (cpu_job->job_type) {
-	case V3D_CPU_JOB_TYPE_INDIRECT_CSD:
-		v3d_attach_fences_and_unlock_reservation(&indirect_submit, 0, &se);
-		break;
-	default:
-		break;
-	}
-
-	v3d_submit_put_jobs(&submit);
-	v3d_submit_put_jobs(&indirect_submit);
+	ret = v3d_submit_jobs(&submit, 0, &se);
+	if (ret)
+		goto fail_unreserve;
 
 	return 0;
 
 fail_unreserve:
-	mutex_unlock(&v3d->sched_lock);
 	v3d_submit_unlock_reservations(&submit);
-	v3d_submit_unlock_reservations(&indirect_submit);
 fail:
 	v3d_submit_cleanup_jobs(&submit);
-	v3d_submit_cleanup_jobs(&indirect_submit);
 	v3d_put_multisync_post_deps(&se);
 
 	return ret;

-- 
2.54.0

