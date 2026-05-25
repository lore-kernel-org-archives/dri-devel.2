Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C24C5CD5BD0
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 12:30:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39BD810E154;
	Mon, 25 May 2026 12:30:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="csMkfptR";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFB8310E2FC
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 12:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5yWRvB+jUHSb/e9p+bCTyjHxr782RdwiaRtq/lh8oKE=; b=csMkfptRLO8VlLlWrz1SQbG0n3
 4OhwZh158mihcUawkHbQNJec6ZkOa2iLIt8O390ZP5U/BTMUgX/SCcjbm5YMVVK6aYBnaZMjYzpqQ
 xJtzzKBuJstglsyXfof9YW0ljrS9WOE2pULB2bq79mf9+i/6e7WuTswwftpiifAl88E1tqkbyUmxP
 KF8WxTsgeyfxr0p8/FkG7J/sGzjSl4+FTSYheG2EUhVAkHcF+9wv4yL7Z2cu9EMfOqUrHgN8TnBma
 DOUaXbNfkjN37mAuuNOpRtHmMkJJ0j9VNo4xkHyyherc2A4yHvuI/3YYWiRk3/LVwHX2zaBcCPI3s
 K0jvX7jQ==;
Received: from [90.240.106.137] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wRURN-0080rS-KR; Mon, 25 May 2026 14:29:53 +0200
Message-ID: <060b3060-6f6a-462e-9956-78fa5dfb6dc7@igalia.com>
Date: Mon, 25 May 2026 13:29:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/14] drm/v3d: Introduce struct v3d_submit and convert
 CL/TFU/CSD ioctls
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
References: <20260510-v3d-sched-misc-fixes-v2-0-ca4aba343ef6@igalia.com>
 <20260510-v3d-sched-misc-fixes-v2-8-ca4aba343ef6@igalia.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260510-v3d-sched-misc-fixes-v2-8-ca4aba343ef6@igalia.com>
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


On 10/05/2026 23:12, Maíra Canal wrote:
> As the V3D driver grew with time, different types of submission were added
> and the submission code grew more complex, but the driver stuck with the
> same abstractions.
> 
> Nowadays, the submission ioctls don't submit a single job, but a
> chain of jobs:
> 
> 1. v3d_submit_cl_ioctl() submits a BIN job (optional), RENDER job
>     (mandatory), and a CLEAN_CACHE job (optional).
> 2. v3d_submit_csd_ioctl() submits a CSD, and a CLEAN_CACHE job.
> 3. v3d_submit_tfu_ioctl() submits a TFU job.
> 
> Therefore, each ioctl submits a chain of jobs in which each job depends on
> the previous one. However, this concept is not well represented in software
> at the moment.
> 
> To address this, introduce a new concept: the struct v3d_submit, which
> groups the submission state and represents the submission chain formed by
> an ordered array of jobs.
> 
> Add new helpers to allocate, add jobs to the chain and submit jobs to
> the scheduler, all based on the new struct. Convert v3d_submit_cl_ioctl(),
> v3d_submit_tfu_ioctl() and v3d_submit_csd_ioctl() to the new pattern. Each
> ioctl now follows the same flow: add jobs -> lookup BOs -> lock
> reservations -> attach perfmon -> submit chain -> attach fences -> put
> jobs.
> 
> The CPU ioctl is left on the old helpers for now; its indirect CSD path
> requires some restructuring that will be addressed in the next few
> commits.
> 
> Signed-off-by: Maíra Canal <mcanal@igalia.com>
> ---
>   drivers/gpu/drm/v3d/v3d_drv.h    |  21 +++
>   drivers/gpu/drm/v3d/v3d_submit.c | 355 ++++++++++++++++++++++-----------------
>   2 files changed, 218 insertions(+), 158 deletions(-)
> 
> diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
> index 788a45c60290..fc12e5215fb0 100644
> --- a/drivers/gpu/drm/v3d/v3d_drv.h
> +++ b/drivers/gpu/drm/v3d/v3d_drv.h
> @@ -288,6 +288,27 @@ to_v3d_fence(struct dma_fence *fence)
>   #define V3D_CORE_READ(core, offset) readl(v3d->core_regs[core] + offset)
>   #define V3D_CORE_WRITE(core, offset, val) writel(val, v3d->core_regs[core] + offset)
>   
> +#define V3D_MAX_JOBS_PER_SUBMISSION 3
> +
> +/* Per-ioctl submission context */
> +struct v3d_submit {
> +	struct v3d_dev *v3d;
> +
> +	struct drm_file *file_priv;
> +
> +	/* DRM exec context for this submission. */
> +	struct drm_exec exec;
> +
> +	/* Ordered array of jobs forming the submission chain. Jobs are
> +	 * appended via v3d_submit_add_job(), then chained and pushed to
> +	 * the scheduler by v3d_submit_jobs().
> +	 */
> +	struct v3d_job *jobs[V3D_MAX_JOBS_PER_SUBMISSION];
> +
> +	/* Number of jobs currently in @jobs. */
> +	u32 job_count;
> +};
> +
>   struct v3d_job {
>   	struct drm_sched_job base;
>   
> diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
> index 0ac88e5763b5..c51474403d2d 100644
> --- a/drivers/gpu/drm/v3d/v3d_submit.c
> +++ b/drivers/gpu/drm/v3d/v3d_submit.c
> @@ -242,6 +242,80 @@ v3d_job_init(struct v3d_dev *v3d, struct drm_file *file_priv,
>   	return ret;
>   }
>   
> +static int
> +v3d_submit_add_job(struct v3d_submit *submit, void **container, size_t size,
> +		   void (*free)(struct kref *ref), enum v3d_queue queue)
> +{
> +	struct v3d_file_priv *v3d_priv = submit->file_priv->driver_priv;
> +	struct v3d_dev *v3d = submit->v3d;
> +	struct v3d_job *job;
> +	int ret;
> +

Would it work to pass struct v3d_job **job instead of the void 
**container? And add like:

BUILD_BUG_ON(offsetof(struct v3d_bin_job, base));
... for all job types ...

Callers can then pass in like:

..., &bin->base, sizeof(*bin), ...

Slightly nicer and safer I think but up to you.

> +	*container = kzalloc(size, GFP_KERNEL);
> +	if (!*container)
> +		return -ENOMEM;
> +
> +	job = *container;
> +	job->v3d = v3d;
> +	job->free = free;
> +	job->file_priv = v3d_priv;
> +
> +	ret = drm_sched_job_init(&job->base, &v3d_priv->sched_entity[queue],
> +				 1, v3d_priv, submit->file_priv->client_id);
> +	if (ret)
> +		goto fail_free;
> +
> +	/* CPU jobs don't require hardware resources */
> +	if (queue != V3D_CPU) {
> +		ret = v3d_pm_runtime_get(v3d);
> +		if (ret)
> +			goto fail_sched_job;
> +		job->has_pm_ref = true;
> +	}
> +
> +	kref_init(&job->refcount);
> +
> +	job->client_stats = v3d_stats_get(v3d_priv->stats[queue]);
> +	job->global_stats = v3d_stats_get(v3d->queue[queue].stats);
> +
> +	submit->jobs[submit->job_count++] = job;
> +
> +	return 0;
> +
> +fail_sched_job:
> +	drm_sched_job_cleanup(&job->base);
> +fail_free:
> +	kfree(*container);
> +	*container = NULL;
> +	return ret;
> +}
> +
> +static int
> +v3d_attach_perfmon_to_jobs(struct v3d_submit *submit, u32 perfmon_id)
> +{
> +	struct v3d_file_priv *v3d_priv = submit->file_priv->driver_priv;
> +	struct v3d_dev *v3d = submit->v3d;
> +	struct v3d_perfmon *perfmon;
> +
> +	if (!perfmon_id)
> +		return 0;
> +
> +	if (v3d->global_perfmon)
> +		return -EAGAIN;

This check ends up quite deep in the submission chain so I wonder if it 
makes sense to pull it out and have it earlier? It appears racy in any 
case since AFAIU userspace can mess with it from a separate thread. Or 
perhaps can keep in simple just as well.

But it possibly warrants a READ_ONCE too to document it is elsewhere 
managed by (cmp)xchg.

> +
> +	perfmon = v3d_perfmon_find(v3d_priv, perfmon_id);
> +	if (!perfmon)
> +		return -ENOENT;
> +
> +	for (int i = 0; i < submit->job_count; i++) {
> +		submit->jobs[i]->perfmon = perfmon;
> +		if (i != 0)
> +			v3d_perfmon_get(perfmon);
> +	}
> +
> +	return 0;
> +}
> +
>   static void
>   v3d_push_job(struct v3d_job *job)
>   {
> @@ -255,6 +329,46 @@ v3d_push_job(struct v3d_job *job)
>   	drm_sched_entity_push_job(&job->base);
>   }
>   
> +static int
> +v3d_submit_jobs(struct v3d_submit *submit)
> +{
> +	struct v3d_dev *v3d = submit->v3d;
> +	int ret = 0;
> +
> +	mutex_lock(&v3d->sched_lock);
> +
> +	for (int i = 0; i < submit->job_count; i++) {
> +		struct v3d_job *job = submit->jobs[i];
> +
> +		v3d_push_job(job);
> +
> +		if (i + 1 < submit->job_count) {
> +			ret = drm_sched_job_add_dependency(&submit->jobs[i + 1]->base,
> +							   dma_fence_get(job->done_fence));
> +			if (ret)
> +				goto err;
> +		}
> +	}
> +
> +err:
> +	mutex_unlock(&v3d->sched_lock);
> +	return ret;
> +}
> +
> +static void
> +v3d_submit_put_jobs(struct v3d_submit *submit)
> +{
> +	for (int i = 0; i < submit->job_count; i++)
> +		v3d_job_put(submit->jobs[i]);
> +}
> +
> +static void
> +v3d_submit_cleanup_jobs(struct v3d_submit *submit)
> +{
> +	for (int i = 0; i < submit->job_count; i++)
> +		v3d_job_cleanup(submit->jobs[i]);
> +}
> +
>   static void
>   v3d_attach_fences_and_unlock_reservation(struct drm_file *file_priv,
>   					 struct v3d_job *job,
> @@ -902,18 +1016,15 @@ int
>   v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
>   		    struct drm_file *file_priv)
>   {
> -	struct v3d_dev *v3d = to_v3d_dev(dev);
> -	struct v3d_file_priv *v3d_priv = file_priv->driver_priv;
> +	struct v3d_submit submit = { .v3d = to_v3d_dev(dev), .file_priv = file_priv };
>   	struct drm_v3d_submit_cl *args = data;
>   	struct v3d_submit_ext se = {0};
>   	struct v3d_bin_job *bin = NULL;
>   	struct v3d_render_job *render = NULL;
>   	struct v3d_job *clean_job = NULL;
> -	struct v3d_job *last_job;
> -	struct drm_exec exec;
> -	int ret = 0;
> +	int ret;
>   
> -	trace_v3d_submit_cl_ioctl(&v3d->drm, args->rcl_start, args->rcl_end);
> +	trace_v3d_submit_cl_ioctl(dev, args->rcl_start, args->rcl_end);
>   
>   	if (args->pad)
>   		return -EINVAL;
> @@ -933,131 +1044,82 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
>   		}
>   	}
>   
> -	ret = v3d_job_allocate(v3d, (void *)&render, sizeof(*render));
> -	if (ret)
> -		return ret;
> -
> -	ret = v3d_job_init(v3d, file_priv, &render->base,
> -			   v3d_render_job_free, args->in_sync_rcl, &se, V3D_RENDER);
> -	if (ret) {
> -		v3d_job_deallocate((void *)&render);
> -		goto fail;
> -	}
> -
> -	render->start = args->rcl_start;
> -	render->end = args->rcl_end;
> -	INIT_LIST_HEAD(&render->unref_list);
> -
>   	if (args->bcl_start != args->bcl_end) {
> -		ret = v3d_job_allocate(v3d, (void *)&bin, sizeof(*bin));
> +		ret = v3d_submit_add_job(&submit, (void **)&bin, sizeof(*bin),
> +					 v3d_job_free, V3D_BIN);
>   		if (ret)
>   			goto fail;
>   
> -		ret = v3d_job_init(v3d, file_priv, &bin->base,
> -				   v3d_job_free, args->in_sync_bcl, &se, V3D_BIN);
> -		if (ret) {
> -			v3d_job_deallocate((void *)&bin);
> -			goto fail;
> -		}
> -
>   		bin->start = args->bcl_start;
>   		bin->end = args->bcl_end;
>   		bin->qma = args->qma;
>   		bin->qms = args->qms;
>   		bin->qts = args->qts;
> -		bin->render = render;
> -	}

Is there a particular reason why you changed the order of render and bin 
job creation? I don't think it makes a difference to be clear, but just 
checking in case there is some subtlety I missed.

>   
> -	if (args->flags & DRM_V3D_SUBMIT_CL_FLUSH_CACHE) {
> -		ret = v3d_job_allocate(v3d, (void *)&clean_job, sizeof(*clean_job));
> +		ret = v3d_job_add_syncobjs(&bin->base, file_priv,
> +					   args->in_sync_bcl, &se, V3D_BIN);
>   		if (ret)
>   			goto fail;
> -
> -		ret = v3d_job_init(v3d, file_priv, clean_job,
> -				   v3d_job_free, 0, NULL, V3D_CACHE_CLEAN);
> -		if (ret) {
> -			v3d_job_deallocate((void *)&clean_job);
> -			goto fail;
> -		}
> -
> -		last_job = clean_job;
> -	} else {
> -		last_job = &render->base;
>   	}
>   
> -	ret = v3d_lookup_bos(dev, file_priv, last_job,
> +	ret = v3d_submit_add_job(&submit, (void **)&render, sizeof(*render),
> +				 v3d_render_job_free, V3D_RENDER);
> +	if (ret)
> +		goto fail;
> +
> +	INIT_LIST_HEAD(&render->unref_list);
> +	render->start = args->rcl_start;
> +	render->end = args->rcl_end;
> +
> +	if (bin)
> +		bin->render = render;
> +
> +	ret = v3d_job_add_syncobjs(&render->base, file_priv, args->in_sync_rcl,
> +				   &se, V3D_RENDER);
> +	if (ret)
> +		goto fail;
> +
> +	if (args->flags & DRM_V3D_SUBMIT_CL_FLUSH_CACHE) {
> +		ret = v3d_submit_add_job(&submit, (void **)&clean_job,
> +					 sizeof(*clean_job), v3d_job_free,
> +					 V3D_CACHE_CLEAN);
> +		if (ret)
> +			goto fail;
> +	}
> +
> +	ret = v3d_lookup_bos(dev, file_priv,
> +			     submit.jobs[submit.job_count - 1],
>   			     args->bo_handles, args->bo_handle_count);
>   	if (ret)
>   		goto fail;
>   
> -	ret = v3d_lock_bo_reservations(last_job, &exec);
> +	ret = v3d_lock_bo_reservations(submit.jobs[submit.job_count - 1],
> +				       &submit.exec);
>   	if (ret)
>   		goto fail;
>   
> -	if (args->perfmon_id) {
> -		if (v3d->global_perfmon) {
> -			ret = -EAGAIN;
> -			goto fail_perfmon;
> -		}
> +	ret = v3d_attach_perfmon_to_jobs(&submit, args->perfmon_id);
> +	if (ret)
> +		goto fail_unreserve;
>   
> -		render->base.perfmon = v3d_perfmon_find(v3d_priv,
> -							args->perfmon_id);
> -
> -		if (!render->base.perfmon) {
> -			ret = -ENOENT;
> -			goto fail_perfmon;
> -		}
> -	}
> -
> -	mutex_lock(&v3d->sched_lock);
> -	if (bin) {
> -		bin->base.perfmon = render->base.perfmon;
> -		v3d_perfmon_get(bin->base.perfmon);
> -		v3d_push_job(&bin->base);
> -
> -		ret = drm_sched_job_add_dependency(&render->base.base,
> -						   dma_fence_get(bin->base.done_fence));
> -		if (ret)
> -			goto fail_unreserve;
> -	}
> -
> -	v3d_push_job(&render->base);
> -
> -	if (clean_job) {
> -		struct dma_fence *render_fence =
> -			dma_fence_get(render->base.done_fence);
> -		ret = drm_sched_job_add_dependency(&clean_job->base,
> -						   render_fence);
> -		if (ret)
> -			goto fail_unreserve;
> -		clean_job->perfmon = render->base.perfmon;
> -		v3d_perfmon_get(clean_job->perfmon);
> -		v3d_push_job(clean_job);
> -	}
> -
> -	mutex_unlock(&v3d->sched_lock);
> +	ret = v3d_submit_jobs(&submit);
> +	if (ret)
> +		goto fail_unreserve;
>   
>   	v3d_attach_fences_and_unlock_reservation(file_priv,
> -						 last_job,
> -						 &exec,
> -						 args->out_sync,
> -						 &se,
> -						 last_job->done_fence);
> +						 submit.jobs[submit.job_count - 1],
> +						 &submit.exec,
> +						 args->out_sync, &se,
> +						 submit.jobs[submit.job_count - 1]->done_fence);
>   
> -	v3d_job_put(&bin->base);
> -	v3d_job_put(&render->base);
> -	v3d_job_put(clean_job);
> +	v3d_submit_put_jobs(&submit);
>   
>   	return 0;
>   
>   fail_unreserve:
> -	mutex_unlock(&v3d->sched_lock);
> -fail_perfmon:
> -	drm_exec_fini(&exec);
> +	drm_exec_fini(&submit.exec);
>   fail:
> -	v3d_job_cleanup((void *)bin);
> -	v3d_job_cleanup((void *)render);
> -	v3d_job_cleanup(clean_job);
> +	v3d_submit_cleanup_jobs(&submit);
>   	v3d_put_multisync_post_deps(&se);
>   
>   	return ret;
> @@ -1076,14 +1138,13 @@ int
>   v3d_submit_tfu_ioctl(struct drm_device *dev, void *data,
>   		     struct drm_file *file_priv)
>   {
> -	struct v3d_dev *v3d = to_v3d_dev(dev);
> +	struct v3d_submit submit = { .v3d = to_v3d_dev(dev), .file_priv = file_priv };
>   	struct drm_v3d_submit_tfu *args = data;
>   	struct v3d_submit_ext se = {0};
>   	struct v3d_tfu_job *job = NULL;
> -	struct drm_exec exec;
>   	int ret = 0;
>   
> -	trace_v3d_submit_tfu_ioctl(&v3d->drm, args->iia);
> +	trace_v3d_submit_tfu_ioctl(dev, args->iia);
>   
>   	if (args->flags && !(args->flags & DRM_V3D_SUBMIT_EXTENSION)) {
>   		drm_dbg(dev, "invalid flags: %d\n", args->flags);
> @@ -1098,16 +1159,14 @@ v3d_submit_tfu_ioctl(struct drm_device *dev, void *data,
>   		}
>   	}
>   
> -	ret = v3d_job_allocate(v3d, (void *)&job, sizeof(*job));
> +	ret = v3d_submit_add_job(&submit, (void **)&job, sizeof(*job),
> +				 v3d_job_free, V3D_TFU);
> +	if (ret)
> +		goto fail;
> +
> +	ret = v3d_job_add_syncobjs(&job->base, file_priv, args->in_sync, &se, V3D_TFU);
>   	if (ret)
> -		return ret;
> -
> -	ret = v3d_job_init(v3d, file_priv, &job->base,
> -			   v3d_job_free, args->in_sync, &se, V3D_TFU);
> -	if (ret) {
> -		v3d_job_deallocate((void *)&job);
>   		goto fail;
> -	}
>   
>   	job->base.bo = kzalloc_objs(*job->base.bo, ARRAY_SIZE(args->bo_handles));
>   	if (!job->base.bo) {
> @@ -1136,26 +1195,27 @@ v3d_submit_tfu_ioctl(struct drm_device *dev, void *data,
>   		job->base.bo[job->base.bo_count] = bo;
>   	}
>   
> -	ret = v3d_lock_bo_reservations(&job->base, &exec);
> +	ret = v3d_lock_bo_reservations(&job->base, &submit.exec);
>   	if (ret)
>   		goto fail;
>   
> -	mutex_lock(&v3d->sched_lock);
> -	v3d_push_job(&job->base);
> -	mutex_unlock(&v3d->sched_lock);
> +	ret = v3d_submit_jobs(&submit);
> +	if (ret)
> +		goto fail_unreserve;
>   
>   	v3d_attach_fences_and_unlock_reservation(file_priv,
> -						 &job->base, &exec,
> -						 args->out_sync,
> -						 &se,
> +						 &job->base, &submit.exec,
> +						 args->out_sync, &se,
>   						 job->base.done_fence);
>   
> -	v3d_job_put(&job->base);
> +	v3d_submit_put_jobs(&submit);
>   
>   	return 0;
>   
> +fail_unreserve:
> +	drm_exec_fini(&submit.exec);
>   fail:
> -	v3d_job_cleanup((void *)job);
> +	v3d_submit_cleanup_jobs(&submit);
>   	v3d_put_multisync_post_deps(&se);
>   
>   	return ret;
> @@ -1174,21 +1234,19 @@ int
>   v3d_submit_csd_ioctl(struct drm_device *dev, void *data,
>   		     struct drm_file *file_priv)
>   {
> -	struct v3d_dev *v3d = to_v3d_dev(dev);
> -	struct v3d_file_priv *v3d_priv = file_priv->driver_priv;
> +	struct v3d_submit submit = { .v3d = to_v3d_dev(dev), .file_priv = file_priv };
>   	struct drm_v3d_submit_csd *args = data;
>   	struct v3d_submit_ext se = {0};
>   	struct v3d_csd_job *job = NULL;
>   	struct v3d_job *clean_job = NULL;
> -	struct drm_exec exec;
>   	int ret;
>   
> -	trace_v3d_submit_csd_ioctl(&v3d->drm, args->cfg[5], args->cfg[6]);
> +	trace_v3d_submit_csd_ioctl(dev, args->cfg[5], args->cfg[6]);
>   
>   	if (args->pad)
>   		return -EINVAL;
>   
> -	if (!v3d_has_csd(v3d)) {
> +	if (!v3d_has_csd(submit.v3d)) {
>   		drm_warn(dev, "Attempting CSD submit on non-CSD hardware\n");
>   		return -EINVAL;
>   	}
> @@ -1206,55 +1264,36 @@ v3d_submit_csd_ioctl(struct drm_device *dev, void *data,
>   		}
>   	}
>   
> -	ret = v3d_setup_csd_jobs_and_bos(file_priv, v3d, args,
> -					 &job, &clean_job, &se, &exec);
> +	ret = v3d_setup_csd_jobs_and_bos(file_priv, submit.v3d, args,
> +					 &job, &clean_job, &se, &submit.exec);
>   	if (ret)
>   		goto fail;
>   
> -	if (args->perfmon_id) {
> -		if (v3d->global_perfmon) {
> -			ret = -EAGAIN;
> -			goto fail_perfmon;
> -		}
> +	submit.jobs[submit.job_count++] = &job->base;
> +	submit.jobs[submit.job_count++] = clean_job;
>   
> -		job->base.perfmon = v3d_perfmon_find(v3d_priv,
> -						     args->perfmon_id);
> -		if (!job->base.perfmon) {
> -			ret = -ENOENT;
> -			goto fail_perfmon;
> -		}
> -	}
> -
> -	mutex_lock(&v3d->sched_lock);
> -	v3d_push_job(&job->base);
> -
> -	ret = drm_sched_job_add_dependency(&clean_job->base,
> -					   dma_fence_get(job->base.done_fence));
> +	ret = v3d_attach_perfmon_to_jobs(&submit, args->perfmon_id);
>   	if (ret)
>   		goto fail_unreserve;
>   
> -	v3d_push_job(clean_job);
> -	mutex_unlock(&v3d->sched_lock);
> +	ret = v3d_submit_jobs(&submit);
> +	if (ret)
> +		goto fail_unreserve;
>   
>   	v3d_attach_fences_and_unlock_reservation(file_priv,
>   						 clean_job,
> -						 &exec,
> -						 args->out_sync,
> -						 &se,
> +						 &submit.exec,
> +						 args->out_sync, &se,
>   						 clean_job->done_fence);
>   
> -	v3d_job_put(&job->base);
> -	v3d_job_put(clean_job);
> +	v3d_submit_put_jobs(&submit);
>   
>   	return 0;
>   
>   fail_unreserve:
> -	mutex_unlock(&v3d->sched_lock);
> -fail_perfmon:
> -	drm_exec_fini(&exec);
> +	drm_exec_fini(&submit.exec);
>   fail:
> -	v3d_job_cleanup((void *)job);
> -	v3d_job_cleanup(clean_job);
> +	v3d_submit_cleanup_jobs(&submit);
>   	v3d_put_multisync_post_deps(&se);
>   
>   	return ret;
> 

Looks good. I would probably only add that READ_ONCE and the rest is up 
to you.

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

