Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACAA7F8A16B
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 12:25:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E963210E1BA;
	Thu, 16 Apr 2026 12:25:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="SUupJRxR";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4997C10E1BA
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 12:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ds6T1smO5dEAIFHLgX7RvUj0Vl2NT2PQo1V/JBW6zcI=; b=SUupJRxRWSPmZgc9owKSCkS+Vb
 37+K/aszsD39SCIgrertBH07HfQapPVw7oqoRZKLTKnzaNt4fbWbbSV6U7q5X/aQuWDELVCoX19j/
 Htm01o/tx6Y6dfeRbzsHmsCP1TVSzFm8AtMIPF25qXneZs0cQVkjqwBKSXLOOm7udgiMaEh6yJn3y
 MpoI358z8FOuv3lhbab0AyjpmjmP5/SPhLTuzEAVlZo7yTJDRicprrTRiu4xWBhotI6eGx0B7gCpV
 Zy/Y8TdfxoHpIcqBmSqpc6qZumeJKtPas2JwgIuM25YaeP4vdkccM/ULNEBVAAYs63WYpXhIHwX/H
 5RkOPSTg==;
Received: from [90.240.106.137] (helo=[192.168.0.101])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wDLmC-00GyLv-0V; Thu, 16 Apr 2026 14:24:56 +0200
Message-ID: <565e767e-25c4-47f7-8e85-80d309d05758@igalia.com>
Date: Thu, 16 Apr 2026 13:24:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] drm/v3d: Migrate BO reservation locking to DRM exec
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
References: <20260413-v3d-sched-misc-fixes-v1-0-bac63a8ceb6c@igalia.com>
 <20260413-v3d-sched-misc-fixes-v1-7-bac63a8ceb6c@igalia.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260413-v3d-sched-misc-fixes-v1-7-bac63a8ceb6c@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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


On 13/04/2026 16:03, Maíra Canal wrote:
> Replace the drm_gem_(un)lock_reservations() + ww_acquire_ctx pattern with
> DRM exec across all submit ioctls. Just a straightforward conversion; no
> functional change.
> 
> Signed-off-by: Maíra Canal <mcanal@igalia.com>
> ---
>   drivers/gpu/drm/v3d/Kconfig      |  1 +
>   drivers/gpu/drm/v3d/v3d_drv.h    |  3 +-
>   drivers/gpu/drm/v3d/v3d_submit.c | 68 +++++++++++++++++-----------------------
>   3 files changed, 32 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/gpu/drm/v3d/Kconfig b/drivers/gpu/drm/v3d/Kconfig
> index ce62c5908e1d..6a33e0ab30de 100644
> --- a/drivers/gpu/drm/v3d/Kconfig
> +++ b/drivers/gpu/drm/v3d/Kconfig
> @@ -5,6 +5,7 @@ config DRM_V3D
>   	depends on DRM
>   	depends on COMMON_CLK
>   	depends on MMU
> +	select DRM_EXEC
>   	select DRM_SCHED
>   	select DRM_GEM_SHMEM_HELPER
>   	help
> diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
> index 5a0b9da2c3aa..788a45c60290 100644
> --- a/drivers/gpu/drm/v3d/v3d_drv.h
> +++ b/drivers/gpu/drm/v3d/v3d_drv.h
> @@ -7,6 +7,7 @@
>   #include <linux/spinlock_types.h>
>   #include <linux/workqueue.h>
>   
> +#include <drm/drm_exec.h>
>   #include <drm/drm_gem.h>
>   #include <drm/drm_gem_shmem_helper.h>
>   #include <drm/gpu_scheduler.h>
> @@ -418,7 +419,7 @@ struct v3d_indirect_csd_info {
>   	struct drm_gem_object *indirect;
>   
>   	/* Context of the Indirect CSD job */
> -	struct ww_acquire_ctx acquire_ctx;
> +	struct drm_exec exec;
>   };
>   
>   struct v3d_timestamp_query_info {
> diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
> index fe8b5757c3e8..6aa8c65e873c 100644
> --- a/drivers/gpu/drm/v3d/v3d_submit.c
> +++ b/drivers/gpu/drm/v3d/v3d_submit.c
> @@ -20,20 +20,18 @@
>    * to v3d, so we don't attach dma-buf fences to them.
>    */
>   static int
> -v3d_lock_bo_reservations(struct v3d_job *job,
> -			 struct ww_acquire_ctx *acquire_ctx)
> +v3d_lock_bo_reservations(struct v3d_job *job, struct drm_exec *exec)
>   {
>   	int i, ret;
>   
> -	ret = drm_gem_lock_reservations(job->bo, job->bo_count, acquire_ctx);
> -	if (ret)
> -		return ret;
> -
> -	for (i = 0; i < job->bo_count; i++) {
> -		ret = dma_resv_reserve_fences(job->bo[i]->resv, 1);
> +	drm_exec_init(exec, DRM_EXEC_INTERRUPTIBLE_WAIT, job->bo_count);
> +	drm_exec_until_all_locked(exec) {
> +		ret = drm_exec_prepare_array(exec, job->bo, job->bo_count, 1);
>   		if (ret)
>   			goto fail;
> +	}
>   
> +	for (i = 0; i < job->bo_count; i++) {
>   		ret = drm_sched_job_add_implicit_dependencies(&job->base,
>   							      job->bo[i], true);
>   		if (ret)
> @@ -43,7 +41,7 @@ v3d_lock_bo_reservations(struct v3d_job *job,
>   	return 0;
>   
>   fail:
> -	drm_gem_unlock_reservations(job->bo, job->bo_count, acquire_ctx);
> +	drm_exec_fini(exec);
>   	return ret;
>   }
>   
> @@ -259,7 +257,7 @@ v3d_push_job(struct v3d_job *job)
>   static void
>   v3d_attach_fences_and_unlock_reservation(struct drm_file *file_priv,
>   					 struct v3d_job *job,
> -					 struct ww_acquire_ctx *acquire_ctx,
> +					 struct drm_exec *exec,
>   					 u32 out_sync,
>   					 struct v3d_submit_ext *se,
>   					 struct dma_fence *done_fence)
> @@ -274,7 +272,7 @@ v3d_attach_fences_and_unlock_reservation(struct drm_file *file_priv,
>   				   DMA_RESV_USAGE_WRITE);
>   	}
>   
> -	drm_gem_unlock_reservations(job->bo, job->bo_count, acquire_ctx);
> +	drm_exec_fini(exec);
>   
>   	/* Update the return sync object for the job */
>   	/* If it only supports a single signal semaphore*/
> @@ -305,7 +303,7 @@ v3d_setup_csd_jobs_and_bos(struct drm_file *file_priv,
>   			   struct v3d_csd_job **job,
>   			   struct v3d_job **clean_job,
>   			   struct v3d_submit_ext *se,
> -			   struct ww_acquire_ctx *acquire_ctx)
> +			   struct drm_exec *exec)
>   {
>   	int ret;
>   
> @@ -338,7 +336,7 @@ v3d_setup_csd_jobs_and_bos(struct drm_file *file_priv,
>   	if (ret)
>   		return ret;
>   
> -	return v3d_lock_bo_reservations(*clean_job, acquire_ctx);
> +	return v3d_lock_bo_reservations(*clean_job, exec);
>   }
>   
>   static void
> @@ -491,7 +489,7 @@ v3d_get_cpu_indirect_csd_params(struct drm_file *file_priv,
>   
>   	return v3d_setup_csd_jobs_and_bos(file_priv, v3d, &indirect_csd.submit,
>   					  &info->job, &info->clean_job,
> -					  NULL, &info->acquire_ctx);
> +					  NULL, &info->exec);
>   }
>   
>   /* Get data for the query timestamp job submission. */
> @@ -906,7 +904,7 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
>   	struct v3d_render_job *render = NULL;
>   	struct v3d_job *clean_job = NULL;
>   	struct v3d_job *last_job;
> -	struct ww_acquire_ctx acquire_ctx;
> +	struct drm_exec exec;
>   	int ret = 0;
>   
>   	trace_v3d_submit_cl_ioctl(&v3d->drm, args->rcl_start, args->rcl_end);
> @@ -986,7 +984,7 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
>   	if (ret)
>   		goto fail;
>   
> -	ret = v3d_lock_bo_reservations(last_job, &acquire_ctx);
> +	ret = v3d_lock_bo_reservations(last_job, &exec);
>   	if (ret)
>   		goto fail;
>   
> @@ -1035,7 +1033,7 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
>   
>   	v3d_attach_fences_and_unlock_reservation(file_priv,
>   						 last_job,
> -						 &acquire_ctx,
> +						 &exec,
>   						 args->out_sync,
>   						 &se,
>   						 last_job->done_fence);
> @@ -1049,8 +1047,7 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
>   fail_unreserve:
>   	mutex_unlock(&v3d->sched_lock);
>   fail_perfmon:
> -	drm_gem_unlock_reservations(last_job->bo,
> -				    last_job->bo_count, &acquire_ctx);
> +	drm_exec_fini(&exec);
>   fail:
>   	v3d_job_cleanup((void *)bin);
>   	v3d_job_cleanup((void *)render);
> @@ -1077,7 +1074,7 @@ v3d_submit_tfu_ioctl(struct drm_device *dev, void *data,
>   	struct drm_v3d_submit_tfu *args = data;
>   	struct v3d_submit_ext se = {0};
>   	struct v3d_tfu_job *job = NULL;
> -	struct ww_acquire_ctx acquire_ctx;
> +	struct drm_exec exec;
>   	int ret = 0;
>   
>   	trace_v3d_submit_tfu_ioctl(&v3d->drm, args->iia);
> @@ -1133,7 +1130,7 @@ v3d_submit_tfu_ioctl(struct drm_device *dev, void *data,
>   		job->base.bo[job->base.bo_count] = bo;
>   	}
>   
> -	ret = v3d_lock_bo_reservations(&job->base, &acquire_ctx);
> +	ret = v3d_lock_bo_reservations(&job->base, &exec);
>   	if (ret)
>   		goto fail;
>   
> @@ -1142,7 +1139,7 @@ v3d_submit_tfu_ioctl(struct drm_device *dev, void *data,
>   	mutex_unlock(&v3d->sched_lock);
>   
>   	v3d_attach_fences_and_unlock_reservation(file_priv,
> -						 &job->base, &acquire_ctx,
> +						 &job->base, &exec,
>   						 args->out_sync,
>   						 &se,
>   						 job->base.done_fence);
> @@ -1177,7 +1174,7 @@ v3d_submit_csd_ioctl(struct drm_device *dev, void *data,
>   	struct v3d_submit_ext se = {0};
>   	struct v3d_csd_job *job = NULL;
>   	struct v3d_job *clean_job = NULL;
> -	struct ww_acquire_ctx acquire_ctx;
> +	struct drm_exec exec;
>   	int ret;
>   
>   	trace_v3d_submit_csd_ioctl(&v3d->drm, args->cfg[5], args->cfg[6]);
> @@ -1204,8 +1201,7 @@ v3d_submit_csd_ioctl(struct drm_device *dev, void *data,
>   	}
>   
>   	ret = v3d_setup_csd_jobs_and_bos(file_priv, v3d, args,
> -					 &job, &clean_job, &se,
> -					 &acquire_ctx);
> +					 &job, &clean_job, &se, &exec);
>   	if (ret)
>   		goto fail;
>   
> @@ -1236,7 +1232,7 @@ v3d_submit_csd_ioctl(struct drm_device *dev, void *data,
>   
>   	v3d_attach_fences_and_unlock_reservation(file_priv,
>   						 clean_job,
> -						 &acquire_ctx,
> +						 &exec,
>   						 args->out_sync,
>   						 &se,
>   						 clean_job->done_fence);
> @@ -1249,8 +1245,7 @@ v3d_submit_csd_ioctl(struct drm_device *dev, void *data,
>   fail_unreserve:
>   	mutex_unlock(&v3d->sched_lock);
>   fail_perfmon:
> -	drm_gem_unlock_reservations(clean_job->bo, clean_job->bo_count,
> -				    &acquire_ctx);
> +	drm_exec_fini(&exec);
>   fail:
>   	v3d_job_cleanup((void *)job);
>   	v3d_job_cleanup(clean_job);
> @@ -1288,7 +1283,7 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
>   	struct v3d_cpu_job *cpu_job = NULL;
>   	struct v3d_csd_job *csd_job = NULL;
>   	struct v3d_job *clean_job = NULL;
> -	struct ww_acquire_ctx acquire_ctx;
> +	struct drm_exec exec;
>   	int ret;
>   
>   	if (args->flags && !(args->flags & DRM_V3D_SUBMIT_EXTENSION)) {
> @@ -1339,7 +1334,7 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
>   		if (ret)
>   			goto fail;
>   
> -		ret = v3d_lock_bo_reservations(&cpu_job->base, &acquire_ctx);
> +		ret = v3d_lock_bo_reservations(&cpu_job->base, &exec);
>   		if (ret)
>   			goto fail;
>   	}
> @@ -1373,14 +1368,14 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
>   
>   	v3d_attach_fences_and_unlock_reservation(file_priv,
>   						 &cpu_job->base,
> -						 &acquire_ctx, 0,
> +						 &exec, 0,
>   						 out_se, cpu_job->base.done_fence);
>   
>   	switch (cpu_job->job_type) {
>   	case V3D_CPU_JOB_TYPE_INDIRECT_CSD:
>   		v3d_attach_fences_and_unlock_reservation(file_priv,
>   							 clean_job,
> -							 &cpu_job->indirect_csd.acquire_ctx,
> +							 &cpu_job->indirect_csd.exec,
>   							 0, &se, clean_job->done_fence);
>   		break;
>   	default:
> @@ -1395,13 +1390,8 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
>   
>   fail_unreserve:
>   	mutex_unlock(&v3d->sched_lock);
> -
> -	drm_gem_unlock_reservations(cpu_job->base.bo, cpu_job->base.bo_count,
> -				    &acquire_ctx);
> -
> -	drm_gem_unlock_reservations(clean_job->bo, clean_job->bo_count,
> -				    &cpu_job->indirect_csd.acquire_ctx);
> -
> +	drm_exec_fini(&exec);
> +	drm_exec_fini(&cpu_job->indirect_csd.exec);

I am not familiar with the whole indirect_csd setup but I have a 
question. Could you in this ioctl not share the same drm_exec context 
(or ww_acquire_ctx before)?

It would need to be passed down from v3d_submit_cl_ioctl to extension 
chain processing as an external paramenter (not in a job), possibly 
more, but could that remove the need to have 2x drm_exec_fini in here?

I did not yet manage to follow the whole flow but intuitively thinking 
is one ioctl, one acquire/drm_exec context should be enough.

Regards,

Tvrtko


>   fail:
>   	v3d_job_cleanup((void *)cpu_job);
>   	v3d_job_cleanup((void *)csd_job);
> 

