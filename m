Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4760606A320
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 11:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=fjb24vh1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E0FF10E0FF;
	Sat, 21 Nov 2026 11:56:15 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A255410E0FF
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 11:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=n8/Vb/XjckbKXB2odMnnB86k9b8ux82tUUL8D68XyLQ=; t=1795262168; x=2110622168; 
 b=fjb24vh1+xWQZpeJjTSGyNuqZVgzOvptBTrZL98vPPTxy8VbZKkHaz+ioiDO0ns59E+CJ11IQvA
 Wj70HtuuAKPzrE1iHnzC5KYCQu/2bb/dQe2j6Fpb93MbraDOzTuJLJLxDmCLCSYO8iRO4oz28210R
 8wtF8eynxqAx4Rqq3vFOryYXkSVNE6VgHtEq1tRZDr8v9JP1v149eqHnyzNfcz8+uJZtm71VF53Yd
 YUPPCoO0n9+vDDICZEeNP/CZFVZMx2+uQBIPXry1jfHzLsXd1S36MmRQuUl4uWHx7SEx/OUuX7EXB
 DykrsToFShWOePTouMV3YRTMg7qei+er3IuQ==;
Received: from [179.105.94.163] (helo=[192.168.0.4])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xUjhO-00000002BLM-2vzP; Sat, 21 Nov 2026 12:56:06 +0100
Message-ID: <87e3bc58-280e-414e-a043-1c07ae9a6e2f@igalia.com>
Date: Sat, 21 Nov 2026 08:56:02 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/v3d: Propagate a failed job's error to dependent jobs
To: Tarel Ethridge <tarelerulz@gmail.com>, mwen@igalia.com
Cc: dri-devel@lists.freedesktop.org
References: <20261121035551.8048-1-tarelerulz@gmail.com>
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Content-Language: en-US
Autocrypt: addr=mcanal@igalia.com; keydata=
 xsBNBGcCwywBCADgTji02Sv9zjHo26LXKdCaumcSWglfnJ93rwOCNkHfPIBll85LL9G0J7H8
 /PmEL9y0LPo9/B3fhIpbD8VhSy9Sqz8qVl1oeqSe/rh3M+GceZbFUPpMSk5pNY9wr5raZ63d
 gJc1cs8XBhuj1EzeE8qbP6JAmsL+NMEmtkkNPfjhX14yqzHDVSqmAFEsh4Vmw6oaTMXvwQ40
 SkFjtl3sr20y07cJMDe++tFet2fsfKqQNxwiGBZJsjEMO2T+mW7DuV2pKHr9aifWjABY5EPw
 G7qbrh+hXgfT+njAVg5+BcLz7w9Ju/7iwDMiIY1hx64Ogrpwykj9bXav35GKobicCAwHABEB
 AAHNIE1hw61yYSBDYW5hbCA8bWNhbmFsQGlnYWxpYS5jb20+wsCRBBMBCAA7FiEE+ORdfQEW
 dwcppnfRP/MOinaI+qoFAmcCwywCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQ
 P/MOinaI+qoUBQgAqz2gzUP7K3EBI24+a5FwFlruQGtim85GAJZXToBtzsfGLLVUSCL3aF/5
 O335Bh6ViSBgxmowIwVJlS/e+L95CkTGzIIMHgyUZfNefR2L3aZA6cgc9z8cfow62Wu8eXnq
 GM/+WWvrFQb/dBKKuohfBlpThqDWXxhozazCcJYYHradIuOM8zyMtCLDYwPW7Vqmewa+w994
 7Lo4CgOhUXVI2jJSBq3sgHEPxiUBOGxvOt1YBg7H9C37BeZYZxFmU8vh7fbOsvhx7Aqu5xV7
 FG+1ZMfDkv+PixCuGtR5yPPaqU2XdjDC/9mlRWWQTPzg74RLEw5sz/tIHQPPm6ROCACFls7A
 TQRnAsMsAQgAxTU8dnqzK6vgODTCW2A6SAzcvKztxae4YjRwN1SuGhJR2isJgQHoOH6oCItW
 Xc1CGAWnci6doh1DJvbbB7uvkQlbeNxeIz0OzHSiB+pb1ssuT31Hz6QZFbX4q+crregPIhr+
 0xeDi6Mtu+paYprI7USGFFjDUvJUf36kK0yuF2XUOBlF0beCQ7Jhc+UoI9Akmvl4sHUrZJzX
 LMeajARnSBXTcig6h6/NFVkr1mi1uuZfIRNCkxCE8QRYebZLSWxBVr3h7dtOUkq2CzL2kRCK
 T2rKkmYrvBJTqSvfK3Ba7QrDg3szEe+fENpL3gHtH6h/XQF92EOulm5S5o0I+ceREwARAQAB
 wsB2BBgBCAAgFiEE+ORdfQEWdwcppnfRP/MOinaI+qoFAmcCwywCGwwACgkQP/MOinaI+qpI
 zQf+NAcNDBXWHGA3lgvYvOU31+ik9bb30xZ7IqK9MIi6TpZqL7cxNwZ+FAK2GbUWhy+/gPkX
 it2gCAJsjo/QEKJi7Zh8IgHN+jfim942QZOkU+p/YEcvqBvXa0zqW0sYfyAxkrf/OZfTnNNE
 Tr+uBKNaQGO2vkn5AX5l8zMl9LCH3/Ieaboni35qEhoD/aM0Kpf93PhCvJGbD4n1DnRhrxm1
 uEdQ6HUjWghEjC+Jh9xUvJco2tUTepw4OwuPxOvtuPTUa1kgixYyG1Jck/67reJzMigeuYFt
 raV3P8t/6cmtawVjurhnCDuURyhUrjpRhgFp+lW8OGr6pepHol/WFIOQEg==
In-Reply-To: <20261121035551.8048-1-tarelerulz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tarel,

This patch doesn't make any sense.

On 21/11/26 00:55, Tarel Ethridge wrote:
> A job that hangs is dropped after the GPU reset and its finished fence
> gets an error. drm_sched does not carry that error over to a job that
> depends on it, and the run_job() callbacks only look at their own
> finished fence. A dependent job therefore runs and signals success, so
> the syncobj userspace waits on reports success although the work was
> never completed.
> 

DRM sched not propagating dependency errors is intentional. A fence
error reports the failure of that job, not of every job waiting on it.
If this behavior were desired, it would belong in drm_sched, not the
driver.

> This affects two kinds of dependency: the previous job of the same
> submission (for example the cache clean job after a compute job, whose
> done fence is the one attached to the out syncobj), and syncobjs the job
> waits on, which is how userspace such as Mesa v3dv chains the no-op job
> that signals a VkFence to an earlier submission.
> 
> Remember the done fence of the previous job of the submission and the
> fences of the syncobjs the job waits on. In run_job(), copy an error from
> any of them to the job's own finished fence. The job is then skipped by
> the existing error check and its fence reports the failure.
> 
> Tested on a Raspberry Pi 400 (V3D 4.2) with a compute shader that never
> finishes: before the change vkWaitForFences returns success after the
> reset, with the change it returns VK_ERROR_DEVICE_LOST (with a Mesa

If you really want this feature in Mesa, you should implement the
vk_device::check_status hook using DRM_V3D_PARAM_CONTEXT_RESET_COUNTER.

> change that reads the fence status). That test used an equivalent change
> on a 6.12 kernel; this version is only compile-tested.

Upstream development must happen in an upstream branch.

Best regards,
- Maíra

> 
> Signed-off-by: Tarel Ethridge <tarelerulz@gmail.com>
> ---
>   drivers/gpu/drm/v3d/v3d_drv.h    |  7 ++++++
>   drivers/gpu/drm/v3d/v3d_sched.c  | 38 ++++++++++++++++++++++++-----
>   drivers/gpu/drm/v3d/v3d_submit.c | 42 +++++++++++++++++++++++++++++---
>   3 files changed, 77 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
> index 3bccb35ed..d5502b895 100644
> --- a/drivers/gpu/drm/v3d/v3d_drv.h
> +++ b/drivers/gpu/drm/v3d/v3d_drv.h
> @@ -367,6 +367,13 @@ struct v3d_job {
>   	 */
>   	struct dma_fence *done_fence;
>   
> +	/* Done fence of the previous job of the submission, if any. */
> +	struct dma_fence *prev_fence;
> +
> +	/* Fences of the syncobjs this job waits on, as found at submit. */
> +	struct dma_fence **dep_fences;
> +	u32 dep_count;
> +
>   	/* Pointer to a performance monitor object if the user requested it,
>   	 * NULL otherwise.
>   	 */
> diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
> index f29d79b15..62b7b8987 100644
> --- a/drivers/gpu/drm/v3d/v3d_sched.c
> +++ b/drivers/gpu/drm/v3d/v3d_sched.c
> @@ -165,6 +165,32 @@ v3d_job_update_stats(struct v3d_job *job)
>   	preempt_enable();
>   }
>   
> +/*
> + * drm_sched does not propagate a failed dependency to the job that waits on
> + * it, and the jobs of a submission run on different queues. Take the error of
> + * the previous job of the submission, or of a syncobj it waited on, so that
> + * this job is skipped and the fence userspace waits for reports the failure.
> + */
> +static bool v3d_job_failed(struct v3d_job *job)
> +{
> +	struct dma_fence *finished = &job->base.s_fence->finished;
> +	int err, i;
> +
> +	for (i = 0; i < job->dep_count && !finished->error; i++) {
> +		err = dma_fence_get_status(job->dep_fences[i]);
> +		if (err < 0)
> +			dma_fence_set_error(finished, err);
> +	}
> +
> +	if (job->prev_fence) {
> +		err = dma_fence_get_status(job->prev_fence);
> +		if (err < 0)
> +			dma_fence_set_error(finished, err);
> +	}
> +
> +	return finished->error;
> +}
> +
>   static struct dma_fence *v3d_bin_job_run(struct drm_sched_job *sched_job)
>   {
>   	struct v3d_bin_job *job = to_bin_job(sched_job);
> @@ -174,7 +200,7 @@ static struct dma_fence *v3d_bin_job_run(struct drm_sched_job *sched_job)
>   	struct dma_fence *fence = NULL;
>   	unsigned long irqflags;
>   
> -	if (unlikely(job->base.base.s_fence->finished.error))
> +	if (unlikely(v3d_job_failed(&job->base)))
>   		goto out_clean_job;
>   
>   	/* Lock required around bin_job update vs
> @@ -235,7 +261,7 @@ static struct dma_fence *v3d_render_job_run(struct drm_sched_job *sched_job)
>   	struct drm_device *dev = &v3d->drm;
>   	struct dma_fence *fence = NULL;
>   
> -	if (unlikely(job->base.base.s_fence->finished.error))
> +	if (unlikely(v3d_job_failed(&job->base)))
>   		goto out_clean_job;
>   
>   	v3d->queue[V3D_RENDER].active_job = &job->base;
> @@ -285,7 +311,7 @@ v3d_tfu_job_run(struct drm_sched_job *sched_job)
>   	struct drm_device *dev = &v3d->drm;
>   	struct dma_fence *fence = NULL;
>   
> -	if (unlikely(job->base.base.s_fence->finished.error))
> +	if (unlikely(v3d_job_failed(&job->base)))
>   		goto out_clean_job;
>   
>   	v3d->queue[V3D_TFU].active_job = &job->base;
> @@ -351,7 +377,7 @@ v3d_csd_job_run(struct drm_sched_job *sched_job)
>   	struct dma_fence *fence = NULL;
>   	int i, csd_cfg0_reg;
>   
> -	if (unlikely(job->base.base.s_fence->finished.error))
> +	if (unlikely(v3d_job_failed(&job->base)))
>   		goto out_clean_job;
>   
>   	/* The HW interprets a workgroup size of 0 as 65536; however, the
> @@ -662,7 +688,7 @@ v3d_cpu_job_run(struct drm_sched_job *sched_job)
>   	struct v3d_cpu_job *job = to_cpu_job(sched_job);
>   	struct v3d_dev *v3d = job->base.v3d;
>   
> -	if (unlikely(job->base.base.s_fence->finished.error))
> +	if (unlikely(v3d_job_failed(&job->base)))
>   		return NULL;
>   
>   	if (job->job_type >= ARRAY_SIZE(cpu_job_function)) {
> @@ -688,7 +714,7 @@ v3d_cache_clean_job_run(struct drm_sched_job *sched_job)
>   	struct v3d_job *job = to_v3d_job(sched_job);
>   	struct v3d_dev *v3d = job->v3d;
>   
> -	if (unlikely(job->base.s_fence->finished.error))
> +	if (unlikely(v3d_job_failed(job)))
>   		return NULL;
>   
>   	v3d_job_start_stats(job);
> diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
> index eada30a31..3f464128c 100644
> --- a/drivers/gpu/drm/v3d/v3d_submit.c
> +++ b/drivers/gpu/drm/v3d/v3d_submit.c
> @@ -141,6 +141,10 @@ v3d_job_free(struct kref *ref)
>   
>   	dma_fence_put(job->irq_fence);
>   	dma_fence_put(job->done_fence);
> +	dma_fence_put(job->prev_fence);
> +	for (i = 0; i < job->dep_count; i++)
> +		dma_fence_put(job->dep_fences[i]);
> +	kfree(job->dep_fences);
>   
>   	if (job->perfmon)
>   		v3d_perfmon_put(job->perfmon);
> @@ -203,6 +207,34 @@ void v3d_job_put(struct v3d_job *job)
>   	kref_put(&job->refcount, job->free);
>   }
>   
> +/* Remember the fence a syncobj dependency waits on, so that run_job() can
> + * tell whether the work this job depends on failed.
> + */
> +static int
> +v3d_job_add_syncobj_dep(struct v3d_job *job, struct drm_file *file_priv,
> +			u32 handle, u32 max_deps)
> +{
> +	struct dma_fence *fence = NULL;
> +	int ret;
> +
> +	ret = drm_sched_job_add_syncobj_dependency(&job->base, file_priv, handle, 0);
> +	if (ret)
> +		return ret;
> +
> +	if (!job->dep_fences) {
> +		job->dep_fences = kcalloc(max_deps, sizeof(*job->dep_fences),
> +					  GFP_KERNEL);
> +		if (!job->dep_fences)
> +			return -ENOMEM;
> +	}
> +
> +	if (job->dep_count < max_deps &&
> +	    !drm_syncobj_find_fence(file_priv, handle, 0, 0, &fence) && fence)
> +		job->dep_fences[job->dep_count++] = fence;
> +
> +	return 0;
> +}
> +
>   static int
>   v3d_job_add_syncobjs(struct v3d_job *job, struct drm_file *file_priv,
>   		     u32 in_sync, struct v3d_submit_ext *se)
> @@ -214,8 +246,7 @@ v3d_job_add_syncobjs(struct v3d_job *job, struct drm_file *file_priv,
>   	if (!has_multisync) {
>   		/* Ignore syncobj if its handle is zero */
>   		if (in_sync)
> -			ret = drm_sched_job_add_syncobj_dependency(&job->base, file_priv,
> -								   in_sync, 0);
> +			ret = v3d_job_add_syncobj_dep(job, file_priv, in_sync, 1);
>   		return ret;
>   	}
>   
> @@ -232,8 +263,8 @@ v3d_job_add_syncobjs(struct v3d_job *job, struct drm_file *file_priv,
>   
>   			/* Ignore syncobj if its handle is zero */
>   			if (in.handle) {
> -				ret = drm_sched_job_add_syncobj_dependency(&job->base,
> -									   file_priv, in.handle, 0);
> +				ret = v3d_job_add_syncobj_dep(job, file_priv, in.handle,
> +							      se->in_sync_count);
>   				if (ret)
>   					return ret;
>   			}
> @@ -494,6 +525,9 @@ v3d_submit_jobs(struct v3d_submit *submit, struct drm_syncobj *sync_out,
>   						   dma_fence_get(submit->jobs[i - 1]->done_fence));
>   		if (ret)
>   			goto err;
> +
> +		submit->jobs[i]->prev_fence =
> +			dma_fence_get(submit->jobs[i - 1]->done_fence);
>   	}
>   
>   	for (int i = 0; i < submit->job_count; i++) {

