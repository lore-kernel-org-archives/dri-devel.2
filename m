Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E731CCD6E57
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 10:25:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52E4F113EED;
	Thu,  4 Jun 2026 10:25:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="aGevSR4Z";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50A74113EED
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 10:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cxAmuAiJ2KkCElOEk4UU6eVVIaXVSchFOVgPRf/uIMA=; b=aGevSR4Z01W7dGdV0MdSQ09/OA
 TI49r7B+XnTUxu+Bn28imLUtVMJhHhzxAIhqkD3eHcFr/KA9wGOG7XFG/vMh6WnfxUWqJdoTUmEaJ
 9FRFFDi17tP0m9zKHHbOZ7fehkvmTKNbI9ThzTYm43UhGVSLDVX4VGDUm+9Q8I86EQwPIcI8/ULZ1
 JpKZNR8jF2zvNDY/6XG6cBQCC/Cta7NFRmyLcdONFnmRXWbiy7VZDsdvYXsmFYJFWEiiyyqeUrFpm
 2ijQ+cOMBhxT4Hk13H1BGc/UzDBmTPfDf9cdGV6zWct0I87teshX4BCHzcQi11hVys3lH7QWm1zN8
 hSD36crA==;
Received: from [90.240.106.137] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wV5GA-00Cagv-WF; Thu, 04 Jun 2026 12:25:11 +0200
Message-ID: <adb445ae-ca7d-4396-ad12-61f2a7133713@igalia.com>
Date: Thu, 4 Jun 2026 11:25:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/14] drm/v3d: Ensure atomic submissions in
 v3d_submit_jobs()
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
References: <20260603-v3d-sched-misc-fixes-v3-0-d7114bba55a0@igalia.com>
 <20260603-v3d-sched-misc-fixes-v3-14-d7114bba55a0@igalia.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260603-v3d-sched-misc-fixes-v3-14-d7114bba55a0@igalia.com>
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


On 03/06/2026 23:25, Maíra Canal wrote:
> Currently, v3d_submit_jobs() arms and pushes each job one at a time,
> wiring dependencies between consecutive jobs after each push. If
> drm_sched_job_add_dependency() fails midway, the already-pushed jobs are
> scheduler-owned and will be submitted to the GPU for execution, even though
> the subsequent jobs won't be submitted.
> 
> This breaks the atomicity of the submissions, as only some of the jobs
> from a submission would be submitted to the hardware, while the other part
> fails.
> 
> Restructure v3d_submit_jobs() into three phases: (1) arm all jobs belonging
> to a given submission, (2) wire inter-job dependencies, and (3) push all
> jobs to the scheduler unconditionally. Phase (2) can fail; on failure,
> it marks every armed job finished fence with an error, so that run_job()
> callbacks skip hardware execution.
> 
> This guarantees that every armed job is always pushed, either to run
> or to be skipped, and it also ensures the atomicity of a submission.
> 
> Suggested-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Signed-off-by: Maíra Canal <mcanal@igalia.com>
> ---
>   drivers/gpu/drm/v3d/v3d_sched.c  |  6 ++++
>   drivers/gpu/drm/v3d/v3d_submit.c | 65 ++++++++++++++++++++--------------------
>   2 files changed, 39 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
> index 04fd1a365576..c16a9d4d41e6 100644
> --- a/drivers/gpu/drm/v3d/v3d_sched.c
> +++ b/drivers/gpu/drm/v3d/v3d_sched.c
> @@ -656,6 +656,9 @@ v3d_cpu_job_run(struct drm_sched_job *sched_job)
>   	struct v3d_cpu_job *job = to_cpu_job(sched_job);
>   	struct v3d_dev *v3d = job->base.v3d;
>   
> +	if (unlikely(job->base.base.s_fence->finished.error))
> +		return NULL;
> +
>   	if (job->job_type >= ARRAY_SIZE(cpu_job_function)) {
>   		drm_dbg(&v3d->drm, "Unknown CPU job: %d\n", job->job_type);
>   		return NULL;
> @@ -679,6 +682,9 @@ v3d_cache_clean_job_run(struct drm_sched_job *sched_job)
>   	struct v3d_job *job = to_v3d_job(sched_job);
>   	struct v3d_dev *v3d = job->v3d;
>   
> +	if (unlikely(job->base.s_fence->finished.error))
> +		return NULL;
> +
>   	v3d_job_start_stats(job);
>   
>   	v3d_clean_caches(v3d);
> diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
> index dc27770d85fd..e118ba69e308 100644
> --- a/drivers/gpu/drm/v3d/v3d_submit.c
> +++ b/drivers/gpu/drm/v3d/v3d_submit.c
> @@ -365,19 +365,6 @@ v3d_submit_process_post_deps(struct v3d_submit *submit, struct drm_syncobj *sync
>   	}
>   }
>   
> -static void
> -v3d_push_job(struct v3d_job *job)
> -{
> -	drm_sched_job_arm(&job->base);
> -
> -	job->done_fence = dma_fence_get(&job->base.s_fence->finished);
> -
> -	/* put by scheduler job completion */
> -	kref_get(&job->refcount);
> -
> -	drm_sched_entity_push_job(&job->base);
> -}
> -
>   static int
>   v3d_submit_jobs(struct v3d_submit *submit, struct drm_syncobj *sync_out,
>   		struct v3d_submit_ext *se)
> @@ -390,16 +377,23 @@ v3d_submit_jobs(struct v3d_submit *submit, struct drm_syncobj *sync_out,
>   	for (int i = 0; i < submit->job_count; i++) {
>   		struct v3d_job *job = submit->jobs[i];
>   
> -		v3d_push_job(job);
> +		drm_sched_job_arm(&job->base);
> +		job->done_fence = dma_fence_get(&job->base.s_fence->finished);
>   
> -		if (i + 1 < submit->job_count) {
> -			ret = drm_sched_job_add_dependency(&submit->jobs[i + 1]->base,
> -							   dma_fence_get(job->done_fence));
> -			if (ret)
> -				goto err;
> -		}
> +		/* put by scheduler job completion */
> +		kref_get(&job->refcount);
>   	}
>   
> +	for (int i = 0; i + 1 < submit->job_count; i++) {

i + 1 < count is a pattern I dont' remember seeing but maybe it is just 
me. Normally I would expect something like:

for (i = 1; i < count; i++)
    add_dep(job[i], job[i - 1]);

Anyway, it looks functionally correct to me as is:

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

> +		ret = drm_sched_job_add_dependency(&submit->jobs[i + 1]->base,
> +						   dma_fence_get(submit->jobs[i]->done_fence));
> +		if (ret)
> +			goto err;
> +	}
> +
> +	for (int i = 0; i < submit->job_count; i++)
> +		drm_sched_entity_push_job(&submit->jobs[i]->base);
> +
>   	mutex_unlock(&v3d->sched_lock);
>   
>   	v3d_submit_attach_object_fences(submit);
> @@ -411,7 +405,18 @@ v3d_submit_jobs(struct v3d_submit *submit, struct drm_syncobj *sync_out,
>   	return 0;
>   
>   err:
> +	/* Mark every armed job as failed so run_job() skips execution */
> +	for (int i = 0; i < submit->job_count; i++)
> +		dma_fence_set_error(&submit->jobs[i]->base.s_fence->finished, ret);
> +
> +	for (int i = 0; i < submit->job_count; i++)
> +		drm_sched_entity_push_job(&submit->jobs[i]->base);
> +
>   	mutex_unlock(&v3d->sched_lock);
> +
> +	v3d_submit_unlock_reservations(submit);
> +	v3d_submit_put_jobs(submit);
> +
>   	return ret;
>   }
>   
> @@ -1098,14 +1103,13 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
>   
>   	ret = v3d_submit_jobs(&submit, sync_out, &se);
>   	if (ret)
> -		goto fail_unreserve;
> +		goto fail_submit;
>   
>   	return 0;
>   
> -fail_unreserve:
> -	v3d_submit_unlock_reservations(&submit);
>   fail:
>   	v3d_submit_cleanup_jobs(&submit);
> +fail_submit:
>   	v3d_submit_put_post_deps(sync_out, &se);
>   
>   	return ret;
> @@ -1195,14 +1199,13 @@ v3d_submit_tfu_ioctl(struct drm_device *dev, void *data,
>   
>   	ret = v3d_submit_jobs(&submit, sync_out, &se);
>   	if (ret)
> -		goto fail_unreserve;
> +		goto fail_submit;
>   
>   	return 0;
>   
> -fail_unreserve:
> -	v3d_submit_unlock_reservations(&submit);
>   fail:
>   	v3d_submit_cleanup_jobs(&submit);
> +fail_submit:
>   	v3d_submit_put_post_deps(sync_out, &se);
>   
>   	return ret;
> @@ -1270,14 +1273,13 @@ v3d_submit_csd_ioctl(struct drm_device *dev, void *data,
>   
>   	ret = v3d_submit_jobs(&submit, sync_out, &se);
>   	if (ret)
> -		goto fail_unreserve;
> +		goto fail_submit;
>   
>   	return 0;
>   
> -fail_unreserve:
> -	v3d_submit_unlock_reservations(&submit);
>   fail:
>   	v3d_submit_cleanup_jobs(&submit);
> +fail_submit:
>   	v3d_submit_put_post_deps(sync_out, &se);
>   
>   	return ret;
> @@ -1378,14 +1380,13 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
>   
>   	ret = v3d_submit_jobs(&submit, NULL, &se);
>   	if (ret)
> -		goto fail_unreserve;
> +		goto fail_submit;
>   
>   	return 0;
>   
> -fail_unreserve:
> -	v3d_submit_unlock_reservations(&submit);
>   fail:
>   	v3d_submit_cleanup_jobs(&submit);
> +fail_submit:
>   	v3d_submit_put_post_deps(NULL, &se);
>   
>   	return ret;
> 

