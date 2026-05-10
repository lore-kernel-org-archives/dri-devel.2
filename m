Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D0D8CD37B2
	for <dri-devel@archiver.kernel.org>; Sun, 10 May 2026 22:12:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76CE510E43C;
	Sun, 10 May 2026 22:12:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="g8EPN5lo";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C49B10E43C
 for <dri-devel@lists.freedesktop.org>; Sun, 10 May 2026 22:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Xr8U1b4dBkY1FsGtOT6q+R2k3CGfSxthxnJtHlDEgmQ=; b=g8EPN5lo5uzaqx02XpaUiUKss2
 bKo70kOOVIjhshyov2kERR2a4aBaJsap1gRhE30a5HwqVhl2pim0xYKHYkD2BOIgJanAihc0nm8T3
 d9uOOKIRdHWMxsvDdh7ie2W63329AB3xtBjfjSbwemTjO6ClTIvPz+eC5yFdm8DjwdHZe58ofkBAu
 F0edJBHj4i00yWSpl4WGQR967Ca1zf6B7qOD+d996yz6Ipb29qDuUJTFL5RGc9qQgo1cYeXFJ+KuD
 CHPgAxbdxO5zDpKKiAef8TG3VrdvVDSxR10No0ALl6FbpwAeJ+vrQ/lMAiV2mUumSfeZOHxra13/a
 j+a6/m+g==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wMCOA-008k1J-26; Mon, 11 May 2026 00:12:41 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Sun, 10 May 2026 19:12:04 -0300
Subject: [PATCH v2 07/14] drm/v3d: Migrate BO reservation locking to DRM exec
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260510-v3d-sched-misc-fixes-v2-7-ca4aba343ef6@igalia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9191; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=NfRgFlYZAoWCHCpqwc2NFVCSt9HMNF4AyDS0zfK7fRk=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqAQK0CpY3pp5qtBXq9nCcKKuV3hvPodYfVr8Ah
 rKXnnFyh7eJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCagECtAAKCRA/8w6Kdoj6
 qu1/B/9B5Zc0Zdn1I24hdBlyN8pxtc/JPFhjqj81TKjLYhYgujlA6EERbJzLKlqi9XW0+wd5Pe/
 Bb4sK6gkxzDsAiRTJRT8BJwpfK12LAcOkkSjzOx19v2XuM20jx5K2chruEkKhLQpWhojlPGzdQZ
 l62CuZmfLGfqLsuM1EhhmkfZqhSoNpQBimqpQbrDzOaue13blgVWAEmoMsMPHc4EgtNkKlizgoN
 aytKgnaDC4cQOM+X8nLcR5VE+hBeTRUBA1PykD2qpsNzy0que/qtJKR9UenWKfLB55B/27w5RXn
 KTw5v9ET8b758yU0kZdRbwXew3WnntOv0YXUPdAkwVi7EOPY
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

Replace the drm_gem_(un)lock_reservations() + ww_acquire_ctx pattern with
DRM exec across all submit ioctls. Just a straightforward conversion; no
functional change.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/Kconfig      |  1 +
 drivers/gpu/drm/v3d/v3d_drv.h    |  3 +-
 drivers/gpu/drm/v3d/v3d_submit.c | 69 +++++++++++++++++-----------------------
 3 files changed, 33 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/v3d/Kconfig b/drivers/gpu/drm/v3d/Kconfig
index ce62c5908e1d..6a33e0ab30de 100644
--- a/drivers/gpu/drm/v3d/Kconfig
+++ b/drivers/gpu/drm/v3d/Kconfig
@@ -5,6 +5,7 @@ config DRM_V3D
 	depends on DRM
 	depends on COMMON_CLK
 	depends on MMU
+	select DRM_EXEC
 	select DRM_SCHED
 	select DRM_GEM_SHMEM_HELPER
 	help
diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
index 5a0b9da2c3aa..788a45c60290 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.h
+++ b/drivers/gpu/drm/v3d/v3d_drv.h
@@ -7,6 +7,7 @@
 #include <linux/spinlock_types.h>
 #include <linux/workqueue.h>
 
+#include <drm/drm_exec.h>
 #include <drm/drm_gem.h>
 #include <drm/drm_gem_shmem_helper.h>
 #include <drm/gpu_scheduler.h>
@@ -418,7 +419,7 @@ struct v3d_indirect_csd_info {
 	struct drm_gem_object *indirect;
 
 	/* Context of the Indirect CSD job */
-	struct ww_acquire_ctx acquire_ctx;
+	struct drm_exec exec;
 };
 
 struct v3d_timestamp_query_info {
diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index 30cb94ee1a2a..0ac88e5763b5 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -20,20 +20,19 @@
  * to v3d, so we don't attach dma-buf fences to them.
  */
 static int
-v3d_lock_bo_reservations(struct v3d_job *job,
-			 struct ww_acquire_ctx *acquire_ctx)
+v3d_lock_bo_reservations(struct v3d_job *job, struct drm_exec *exec)
 {
 	int i, ret;
 
-	ret = drm_gem_lock_reservations(job->bo, job->bo_count, acquire_ctx);
+	drm_exec_init(exec, DRM_EXEC_INTERRUPTIBLE_WAIT, job->bo_count);
+	drm_exec_until_all_locked(exec) {
+		ret = drm_exec_prepare_array(exec, job->bo, job->bo_count, 1);
+	}
+
 	if (ret)
-		return ret;
+		goto fail;
 
 	for (i = 0; i < job->bo_count; i++) {
-		ret = dma_resv_reserve_fences(job->bo[i]->resv, 1);
-		if (ret)
-			goto fail;
-
 		ret = drm_sched_job_add_implicit_dependencies(&job->base,
 							      job->bo[i], true);
 		if (ret)
@@ -43,7 +42,7 @@ v3d_lock_bo_reservations(struct v3d_job *job,
 	return 0;
 
 fail:
-	drm_gem_unlock_reservations(job->bo, job->bo_count, acquire_ctx);
+	drm_exec_fini(exec);
 	return ret;
 }
 
@@ -259,7 +258,7 @@ v3d_push_job(struct v3d_job *job)
 static void
 v3d_attach_fences_and_unlock_reservation(struct drm_file *file_priv,
 					 struct v3d_job *job,
-					 struct ww_acquire_ctx *acquire_ctx,
+					 struct drm_exec *exec,
 					 u32 out_sync,
 					 struct v3d_submit_ext *se,
 					 struct dma_fence *done_fence)
@@ -274,7 +273,7 @@ v3d_attach_fences_and_unlock_reservation(struct drm_file *file_priv,
 				   DMA_RESV_USAGE_WRITE);
 	}
 
-	drm_gem_unlock_reservations(job->bo, job->bo_count, acquire_ctx);
+	drm_exec_fini(exec);
 
 	/* Update the return sync object for the job */
 	/* If it only supports a single signal semaphore*/
@@ -305,7 +304,7 @@ v3d_setup_csd_jobs_and_bos(struct drm_file *file_priv,
 			   struct v3d_csd_job **job,
 			   struct v3d_job **clean_job,
 			   struct v3d_submit_ext *se,
-			   struct ww_acquire_ctx *acquire_ctx)
+			   struct drm_exec *exec)
 {
 	int ret;
 
@@ -338,7 +337,7 @@ v3d_setup_csd_jobs_and_bos(struct drm_file *file_priv,
 	if (ret)
 		return ret;
 
-	return v3d_lock_bo_reservations(*clean_job, acquire_ctx);
+	return v3d_lock_bo_reservations(*clean_job, exec);
 }
 
 static void
@@ -496,7 +495,7 @@ v3d_get_cpu_indirect_csd_params(struct drm_file *file_priv,
 
 	return v3d_setup_csd_jobs_and_bos(file_priv, v3d, &indirect_csd.submit,
 					  &info->job, &info->clean_job,
-					  NULL, &info->acquire_ctx);
+					  NULL, &info->exec);
 }
 
 /* Get data for the query timestamp job submission. */
@@ -911,7 +910,7 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
 	struct v3d_render_job *render = NULL;
 	struct v3d_job *clean_job = NULL;
 	struct v3d_job *last_job;
-	struct ww_acquire_ctx acquire_ctx;
+	struct drm_exec exec;
 	int ret = 0;
 
 	trace_v3d_submit_cl_ioctl(&v3d->drm, args->rcl_start, args->rcl_end);
@@ -991,7 +990,7 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
 	if (ret)
 		goto fail;
 
-	ret = v3d_lock_bo_reservations(last_job, &acquire_ctx);
+	ret = v3d_lock_bo_reservations(last_job, &exec);
 	if (ret)
 		goto fail;
 
@@ -1040,7 +1039,7 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
 
 	v3d_attach_fences_and_unlock_reservation(file_priv,
 						 last_job,
-						 &acquire_ctx,
+						 &exec,
 						 args->out_sync,
 						 &se,
 						 last_job->done_fence);
@@ -1054,8 +1053,7 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
 fail_unreserve:
 	mutex_unlock(&v3d->sched_lock);
 fail_perfmon:
-	drm_gem_unlock_reservations(last_job->bo,
-				    last_job->bo_count, &acquire_ctx);
+	drm_exec_fini(&exec);
 fail:
 	v3d_job_cleanup((void *)bin);
 	v3d_job_cleanup((void *)render);
@@ -1082,7 +1080,7 @@ v3d_submit_tfu_ioctl(struct drm_device *dev, void *data,
 	struct drm_v3d_submit_tfu *args = data;
 	struct v3d_submit_ext se = {0};
 	struct v3d_tfu_job *job = NULL;
-	struct ww_acquire_ctx acquire_ctx;
+	struct drm_exec exec;
 	int ret = 0;
 
 	trace_v3d_submit_tfu_ioctl(&v3d->drm, args->iia);
@@ -1138,7 +1136,7 @@ v3d_submit_tfu_ioctl(struct drm_device *dev, void *data,
 		job->base.bo[job->base.bo_count] = bo;
 	}
 
-	ret = v3d_lock_bo_reservations(&job->base, &acquire_ctx);
+	ret = v3d_lock_bo_reservations(&job->base, &exec);
 	if (ret)
 		goto fail;
 
@@ -1147,7 +1145,7 @@ v3d_submit_tfu_ioctl(struct drm_device *dev, void *data,
 	mutex_unlock(&v3d->sched_lock);
 
 	v3d_attach_fences_and_unlock_reservation(file_priv,
-						 &job->base, &acquire_ctx,
+						 &job->base, &exec,
 						 args->out_sync,
 						 &se,
 						 job->base.done_fence);
@@ -1182,7 +1180,7 @@ v3d_submit_csd_ioctl(struct drm_device *dev, void *data,
 	struct v3d_submit_ext se = {0};
 	struct v3d_csd_job *job = NULL;
 	struct v3d_job *clean_job = NULL;
-	struct ww_acquire_ctx acquire_ctx;
+	struct drm_exec exec;
 	int ret;
 
 	trace_v3d_submit_csd_ioctl(&v3d->drm, args->cfg[5], args->cfg[6]);
@@ -1209,8 +1207,7 @@ v3d_submit_csd_ioctl(struct drm_device *dev, void *data,
 	}
 
 	ret = v3d_setup_csd_jobs_and_bos(file_priv, v3d, args,
-					 &job, &clean_job, &se,
-					 &acquire_ctx);
+					 &job, &clean_job, &se, &exec);
 	if (ret)
 		goto fail;
 
@@ -1241,7 +1238,7 @@ v3d_submit_csd_ioctl(struct drm_device *dev, void *data,
 
 	v3d_attach_fences_and_unlock_reservation(file_priv,
 						 clean_job,
-						 &acquire_ctx,
+						 &exec,
 						 args->out_sync,
 						 &se,
 						 clean_job->done_fence);
@@ -1254,8 +1251,7 @@ v3d_submit_csd_ioctl(struct drm_device *dev, void *data,
 fail_unreserve:
 	mutex_unlock(&v3d->sched_lock);
 fail_perfmon:
-	drm_gem_unlock_reservations(clean_job->bo, clean_job->bo_count,
-				    &acquire_ctx);
+	drm_exec_fini(&exec);
 fail:
 	v3d_job_cleanup((void *)job);
 	v3d_job_cleanup(clean_job);
@@ -1293,7 +1289,7 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
 	struct v3d_cpu_job *cpu_job = NULL;
 	struct v3d_csd_job *csd_job = NULL;
 	struct v3d_job *clean_job = NULL;
-	struct ww_acquire_ctx acquire_ctx;
+	struct drm_exec exec;
 	int ret;
 
 	if (args->flags && !(args->flags & DRM_V3D_SUBMIT_EXTENSION)) {
@@ -1344,7 +1340,7 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
 		if (ret)
 			goto fail;
 
-		ret = v3d_lock_bo_reservations(&cpu_job->base, &acquire_ctx);
+		ret = v3d_lock_bo_reservations(&cpu_job->base, &exec);
 		if (ret)
 			goto fail;
 	}
@@ -1378,14 +1374,14 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
 
 	v3d_attach_fences_and_unlock_reservation(file_priv,
 						 &cpu_job->base,
-						 &acquire_ctx, 0,
+						 &exec, 0,
 						 out_se, cpu_job->base.done_fence);
 
 	switch (cpu_job->job_type) {
 	case V3D_CPU_JOB_TYPE_INDIRECT_CSD:
 		v3d_attach_fences_and_unlock_reservation(file_priv,
 							 clean_job,
-							 &cpu_job->indirect_csd.acquire_ctx,
+							 &cpu_job->indirect_csd.exec,
 							 0, &se, clean_job->done_fence);
 		break;
 	default:
@@ -1400,13 +1396,8 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
 
 fail_unreserve:
 	mutex_unlock(&v3d->sched_lock);
-
-	drm_gem_unlock_reservations(cpu_job->base.bo, cpu_job->base.bo_count,
-				    &acquire_ctx);
-
-	drm_gem_unlock_reservations(clean_job->bo, clean_job->bo_count,
-				    &cpu_job->indirect_csd.acquire_ctx);
-
+	drm_exec_fini(&exec);
+	drm_exec_fini(&cpu_job->indirect_csd.exec);
 fail:
 	v3d_job_cleanup((void *)cpu_job);
 	v3d_job_cleanup((void *)csd_job);

-- 
2.54.0

