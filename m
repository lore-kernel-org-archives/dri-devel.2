Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA36CD6E57
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 10:49:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FC2110EEF6;
	Tue,  2 Jun 2026 10:49:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="lS6pPPUE";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 243A510EEF6
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 10:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZhW43AK+oVim0AI5uSTOuikU5d8E/WwES5I7sSKdMBM=; b=lS6pPPUENYFIINrq6/oVLFqNMC
 1xg9cYRwkcv3l+8paHoDUR/1T4+UwdSFAwTDvcaL6I2xoau9dgfceJx8pAJ7ggzo2pb0bpeG95TGH
 6z8TR8ZSBlBhksL/uBNgwV6dr7CyLeS5q4UMjIUMRtqJd3gsk+vpKOjMqsxVgVCLoHw2OWvOopgVO
 1rihMYV8ANbBoiY4SUyye8flbrDmq5hE/opX6XT2zBwYV8gynL98xqffz2Y2XLownQwX0Lf6aIdCx
 ZD0O3fu3Oy+tpwSmqGf9iFy71A0zNQPp3mWECos0sHlpbUI/YM9UdHwGUIondNSfdKQs2Osj4c1AK
 DENW+x2A==;
Received: from [189.7.87.67] (helo=[192.168.0.2])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wUMgP-00Bf0I-S2; Tue, 02 Jun 2026 12:49:18 +0200
Message-ID: <44cbf6ec-3134-44d5-b37c-0c99ac55f678@igalia.com>
Date: Tue, 2 Jun 2026 07:49:12 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] drm/v3d: Serialize jobs across queues when a
 perfmon is attached
To: Iago Toral <itoral@igalia.com>, Melissa Wen <mwen@igalia.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
References: <20260531-v3d-perfmon-lifetime-v2-0-60ed4485a203@igalia.com>
 <20260531-v3d-perfmon-lifetime-v2-3-60ed4485a203@igalia.com>
 <7a9d503de81b403585962f1c25dd0b506a6eb3f2.camel@igalia.com>
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
In-Reply-To: <7a9d503de81b403585962f1c25dd0b506a6eb3f2.camel@igalia.com>
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

Hi Iago,

On 02/06/26 04:35, Iago Toral wrote:
> Hi Maíra, this pactch looks good to me but I am wondering if we should
> do anything to clean up the perfmon state when a gpu reset happens:
> i.e. what would happen if a perfmon job resets? Would we continue to
> schedule after-reset jobs to wait on the fence of the reset job?

If the job resets, the design around the DRM scheduler will protect us.

The DRM scheduler guarantees that a finished fence is always signaled
eventually. On a reset, drm_sched_start() signals the pending jobs'
finished fences (with -ECANCELED for the guilty job). So if a
perfmon-carrying job is the one that times out, the done_fence we
stored for serialization still gets signaled when resubmitted (check the
first if-clause in the run_job() callbacks).

drm_sched_job_add_dependency() releases the dependent job as soon as the
fence signals, regardless of error, so any job submitted behind the
reset perfmon job is released and runs. The serialization window simply
closes when the job dies.

Best regards,
- Maíra

> 
> Iago
> 
> El dom, 31-05-2026 a las 17:18 -0300, Maíra Canal escribió:
>> A non-global perfmon is meant to count events generated by a specific
>> submission, but the scheduler can run jobs from different queues
>> concurrently on the same V3D core. Without explicit serialization, an
>> unrelated job running in parallel with a perfmon-carrying job
>> pollutes
>> the counters and generates unusable results.
>>
>> To address such issue, we must enforce cross-queue serialization when
>> we
>> detect a perfmon-carrying submission. It's possible to implement
>> serialization by enforcing two rules:
>>
>>    1. A job that carries a non-global perfmon must wait for every job
>>      currently in-flight across all HW queues to finish.
>>
>>    2. While a perfmon-carrying job is still in-flight, all
>> subsequently
>>      submitted jobs must wait for it.
>>
>> Note that serialization is not needed in the global perfmon case, as
>> the
>> global perfmon tracks activity from all jobs, so concurrency is
>> desirable.
>>
>> Therefore, check if serialization is needed during job submission and
>> if
>> so, attach fence dependences to enforce cross-queue serialization.
>>
>> Signed-off-by: Maíra Canal <mcanal@igalia.com>
>> ---
>>   drivers/gpu/drm/v3d/v3d_drv.h     | 35 ++++++++++++++++++----
>>   drivers/gpu/drm/v3d/v3d_gem.c     |  3 ++
>>   drivers/gpu/drm/v3d/v3d_perfmon.c |  6 ++++
>>   drivers/gpu/drm/v3d/v3d_submit.c  | 63
>> +++++++++++++++++++++++++++++++++++++++
>>   4 files changed, 101 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/v3d/v3d_drv.h
>> b/drivers/gpu/drm/v3d/v3d_drv.h
>> index 51486af68cf4..cdf4926d51f2 100644
>> --- a/drivers/gpu/drm/v3d/v3d_drv.h
>> +++ b/drivers/gpu/drm/v3d/v3d_drv.h
>> @@ -74,11 +74,13 @@ struct v3d_queue_state {
>>   	spinlock_t queue_lock;
>>   };
>>   
>> -/* Performance monitor object. The perform lifetime is controlled by
>> userspace
>> - * using perfmon related ioctls. A perfmon can be attached to a
>> submit_cl
>> - * request, and when this is the case, HW perf counters will be
>> activated just
>> - * before the submit_cl is submitted to the GPU and disabled when
>> the job is
>> - * done. This way, only events related to a specific job will be
>> counted.
>> +/* Performance monitor object
>> + *
>> + * The performance monitor (perfmon) lifetime is controlled by
>> userspace using
>> + * perfmon related ioctls. A perfmon can be attached to a CL or CSD
>> submission
>> + * request, and when it is, HW performance counters will be
>> activated just
>> + * before the job is submitted to the GPU and disabled when the job
>> is done.
>> + * This way, only events related to a specific submission will be
>> counted.
>>    */
>>   struct v3d_perfmon {
>>   	/* Tracks the number of users of the perfmon, when this
>> counter reaches
>> @@ -167,13 +169,31 @@ struct v3d_dev {
>>   
>>   	struct v3d_queue_state queue[V3D_MAX_QUEUES];
>>   
>> -	/* Tracks the performance monitor state. */
>> +	/*
>> +	 * Tracks the performance monitor state and consistency.
>> +	 *
>> +	 * When a non-global perfmon is attached to a job, the
>> scheduler must
>> +	 * not run any other job on the HW concurrently (otherwise,
>> the
>> +	 * counters would be polluted by unrelated work).
>> +	 */
>>   	struct {
>>   		/* Protects @active. */
>>   		spinlock_t lock;
>>   
>>   		/* Perfmon currently programmed in HW (or NULL if
>> none). */
>>   		struct v3d_perfmon *active;
>> +
>> +		/* Finished fence of the most recently submitted job
>> that
>> +		 * opened a serialization window (i.e. a job with a
>> non-global
>> +		 * perfmon attached).
>> +		 */
>> +		struct dma_fence *fence;
>> +
>> +		/* Finished fence of the most recently submitted job
>> on each HW
>> +		 * queue. Used so that a new perfmon-carrying job
>> can depend on
>> +		 * every job currently in-flight across all queues.
>> +		 */
>> +		struct dma_fence *last_hw_fence[V3D_MAX_QUEUES];
>>   	} perfmon_state;
>>   
>>   	/* Protects bo_stats */
>> @@ -319,6 +339,9 @@ struct v3d_job {
>>   
>>   	struct v3d_dev *v3d;
>>   
>> +	/* The queue that the job was submitted on. */
>> +	enum v3d_queue queue;
>> +
>>   	/* This is the array of BOs that were looked up at the start
>>   	 * of submission.
>>   	 */
>> diff --git a/drivers/gpu/drm/v3d/v3d_gem.c
>> b/drivers/gpu/drm/v3d/v3d_gem.c
>> index 9487ab7acd03..0b415486f5b4 100644
>> --- a/drivers/gpu/drm/v3d/v3d_gem.c
>> +++ b/drivers/gpu/drm/v3d/v3d_gem.c
>> @@ -363,8 +363,11 @@ v3d_gem_destroy(struct drm_device *dev)
>>   	for (q = 0; q < V3D_MAX_QUEUES; q++) {
>>   		WARN_ON(v3d->queue[q].active_job);
>>   		v3d_stats_put(v3d->queue[q].stats);
>> +		dma_fence_put(v3d->perfmon_state.last_hw_fence[q]);
>>   	}
>>   
>> +	dma_fence_put(v3d->perfmon_state.fence);
>> +
>>   	drm_mm_takedown(&v3d->mm);
>>   
>>   	dma_free_coherent(v3d->drm.dev, 4096 * 1024, (void *)v3d-
>>> pt,
>> diff --git a/drivers/gpu/drm/v3d/v3d_perfmon.c
>> b/drivers/gpu/drm/v3d/v3d_perfmon.c
>> index 3ad0f022753c..07dab7fb3060 100644
>> --- a/drivers/gpu/drm/v3d/v3d_perfmon.c
>> +++ b/drivers/gpu/drm/v3d/v3d_perfmon.c
>> @@ -275,6 +275,12 @@ void v3d_perfmon_start(struct v3d_dev *v3d,
>> struct v3d_perfmon *perfmon)
>>   	if (!perfmon || v3d->global_perfmon)
>>   		return;
>>   
>> +	/* Cross-queue serialization should have drained any
>> previous perfmon
>> +	 * job before this one runs.
>> +	 */
>> +	if (WARN_ON_ONCE(v3d->perfmon_state.active))
>> +		return;
>> +
>>   	if (!pm_runtime_get_if_active(v3d->drm.dev))
>>   		return;
>>   
>> diff --git a/drivers/gpu/drm/v3d/v3d_submit.c
>> b/drivers/gpu/drm/v3d/v3d_submit.c
>> index 4c526aafc4e0..46fc88bacc95 100644
>> --- a/drivers/gpu/drm/v3d/v3d_submit.c
>> +++ b/drivers/gpu/drm/v3d/v3d_submit.c
>> @@ -234,6 +234,7 @@ v3d_submit_add_job(struct v3d_submit *submit,
>> void **container, size_t size,
>>   	job->v3d = v3d;
>>   	job->free = free;
>>   	job->file_priv = v3d_priv;
>> +	job->queue = queue;
>>   
>>   	ret = drm_sched_job_init(&job->base, &v3d_priv-
>>> sched_entity[queue],
>>   				 1, v3d_priv, submit->file_priv-
>>> client_id);
>> @@ -293,6 +294,62 @@ v3d_attach_perfmon_to_jobs(struct v3d_submit
>> *submit, u32 perfmon_id)
>>   	return 0;
>>   }
>>   
>> +/*
>> + * Prepare fences to enforce job serialization when a perfmon is
>> active. A job
>> + * that carries a non-global perfmon must wait for every job
>> currently in-flight
>> + * across all HW queues to finish, otherwise concurrent unrelated
>> work on the
>> + * same core would pollute the performance counters. Symmetrically,
>> while such a
>> + * job is still in-flight, all subsequently submitted jobs must wait
>> for it.
>> + *
>> + * We don't serialize the jobs when using a global perfmon as it's
>> expected to
>> + * track concurrent activity from all jobs.
>> + */
>> +static int
>> +v3d_serialize_for_perfmon(struct v3d_job *job)
>> +{
>> +	struct v3d_dev *v3d = job->v3d;
>> +	bool is_global_perfmon;
>> +	int ret;
>> +
>> +	lockdep_assert_held(&v3d->sched_lock);
>> +
>> +	scoped_guard(spinlock_irqsave, &v3d->perfmon_state.lock)
>> +		is_global_perfmon = !!v3d->global_perfmon;
>> +
>> +	if (is_global_perfmon)
>> +		goto publish;
>> +
>> +	if (job->perfmon) {
>> +		for (enum v3d_queue q = 0; q < V3D_MAX_QUEUES; q++)
>> {
>> +			struct dma_fence *f = v3d-
>>> perfmon_state.last_hw_fence[q];
>> +
>> +			if (!f || dma_fence_is_signaled(f))
>> +				continue;
>> +
>> +			ret = drm_sched_job_add_dependency(&job-
>>> base, dma_fence_get(f));
>> +			if (ret)
>> +				return ret;
>> +		}
>> +	} else if (v3d->perfmon_state.fence &&
>> +		   !dma_fence_is_signaled(v3d->perfmon_state.fence))
>> {
>> +		ret = drm_sched_job_add_dependency(&job->base,
>> +						
>> dma_fence_get(v3d->perfmon_state.fence));
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +publish:
>> +	dma_fence_put(v3d->perfmon_state.last_hw_fence[job->queue]);
>> +	v3d->perfmon_state.last_hw_fence[job->queue] =
>> dma_fence_get(job->done_fence);
>> +
>> +	if (job->perfmon && !is_global_perfmon) {
>> +		dma_fence_put(v3d->perfmon_state.fence);
>> +		v3d->perfmon_state.fence = dma_fence_get(job-
>>> done_fence);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   static void
>>   v3d_submit_attach_object_fences(struct v3d_submit *submit)
>>   {
>> @@ -337,6 +394,12 @@ v3d_submit_jobs(struct v3d_submit *submit)
>>   			goto err;
>>   	}
>>   
>> +	for (int i = 0; i < submit->job_count; i++) {
>> +		ret = v3d_serialize_for_perfmon(submit->jobs[i]);
>> +		if (ret)
>> +			goto err;
>> +	}
>> +
>>   	for (int i = 0; i < submit->job_count; i++)
>>   		drm_sched_entity_push_job(&submit->jobs[i]->base);
>>   
>>
> 

