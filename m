Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981DB606A321
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 14:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uULtK6Kd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87A9C10E07C;
	Mon,  9 Nov 2026 14:54:26 +0000 (UTC)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com
 [209.85.222.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8A6310E07C
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 14:54:19 +0000 (UTC)
Received: by mail-qk1-f181.google.com with SMTP id
 af79cd13be357-93e7ad9f78dso110769185a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 06:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794236059; x=1794840859; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=tuL9LFe+O74d4FgTqP6A3o2VKesHrJf5tidJluC7W+0=;
 b=uULtK6Kd5DJ6Tlm2oLc+lP93ZZfTO5UEpzF3IRGYd5bU7C37An8wJ1TKhOL7nHncRv
 dFV765yhm8vOcWP0kRXmFtCWJN+/rPRVxiDFuO46SWi3Oded9Ah7vqAq0qqCavyZK909
 VlBqCcMgmGIJh/XuDkScrBVqgkJpZrU9QfF3SmR5MBvut/p6aTef/gjsteo4G8Rql0gF
 uMyjHt1y4mygQlo7/anK8Jqp9GXle3VzKTYMfTqef5YdGFORv2fLzKd+3DBHozmY4AHw
 Cwq2piRHC+P0ZOHtVvL9FicHc4uN0dUgHw/MpY+Qj3zn1eGmmdjqRhzJKgUChXEsLavP
 yP3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794236059; x=1794840859;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tuL9LFe+O74d4FgTqP6A3o2VKesHrJf5tidJluC7W+0=;
 b=YjXj9W14xKRnXZRfA57SUxETX6wzJD73dXSvjd+tw5VOcQvlqbemqcfXAiCpNOt0bc
 68Hj7qRNUYlUBOM4Oy60JjtjCeWQvugsNFiR2hWR8ZFZJIRVFt5Ayc6YvrEZNVrwNk0E
 5IhuN460KEPfcyrWGLOwjWyK7jMyjRlUgT7gb15ZE4Bn00ZLzYvbamw7tPmgIFMhAFeL
 YULw7zjlTHUbCt+cLjchAmguhjvrlAKQFn9zBLN6rCFqECTTy7fVZOIYymz4G77cbDeW
 wfwkzAWIK0sJ0CdHlSZq83T2gofvwJEXCSu4JEg7kn+oE7qVovQ9j2IwsbA3jROmSbJ8
 P7QQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEHVghHXM105qyO3NbP8ykj2uhPaHWEjpZIDagNFm8YTHLoaBp6DS4mmWZ4kVwuntZgbJpN0o4QOQw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9wGAMjbMmc1M1NFoIfhtYTo6letDK3abnG+Y6HPkQkVqbYE85A
 N7IIGl8XDgMssof4Vk6gIHopGEjejFbMnTgS6XQA7FlxQYpsljWvS6yf
X-Gm-Gg: AYBFou2WRIU4HywttCUp9XTZifikYzHGDTtqhbTHrEFhLHqN9YJZabHuyz3axzG/us/
 B8Azq6dH3t31Nzcqit60Pjbddp969+bWZgJ9J1SQAa9BZ4zzXwmI/KaxFK2zKeNFq9FmeN85LFK
 9hP3lLjM/bWyN9XlUtYt53cGdT2rHQ7zgP+2cOwnKybefowBqsFOVnQJpqXgkr+UMJbUEAjHpGx
 d4hF2CEEsxz5B7QORR3gB1YB2MdFwpigQnX65NNGBjRNvsHK+s5BLV7B4KEF/juTGWl5+KbCuF0
 +KAQENpHvWwtuLzNIzAMRYA7+uWcTIXVaTNVTNqc7lgAbyXQgp++pltqREYmpKJMTHscBzcfzK6
 nsdnztFFOtks2uqZgwBqf/kMHDk0wSHR8mNB0iRtUFQrl3BZKiJzrA9FCLBDA80+Xzctkw70mRY
 SR3CxUA7ZZbSbIN7CeBJu54QJrHzHLvrxq+2S4So5nBwSsPGFHDV2lU3h3zEBLvRAHRcToNM5QE
 q/Sy1yRNLg4M1N9DLLPILMps41dYJdRl4N4VkTvTd/0V3QQw6Mwjbdf1OzEbiXuMD31ER7Tvtee
 vfDjzdQ8mVE2JfRSAuTuG6cs5v1yVJJxflt0h1CynIAIy8c6x98JIF9y
X-Received: by 2002:a05:620a:4507:b0:93e:942f:b8a5 with SMTP id
 af79cd13be357-947841ea2f8mr676769685a.14.1794236058922; 
 Mon, 09 Nov 2026 06:54:18 -0800 (PST)
Received: from [10.254.154.43] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-94782da5b6asm486801985a.25.2026.11.09.06.54.16
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 09 Nov 2026 06:54:18 -0800 (PST)
Message-ID: <52d41d99-90f0-40d1-828e-0456dad433b6@gmail.com>
Date: Mon, 9 Nov 2026 15:54:15 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] drm/amdgpu: Rework the
 amdgpu_job_stop_all_jobs_on_sched() hack
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Hawking Zhang <Hawking.Zhang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: kernel-dev@igalia.com, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Matthew Brost <matthew.brost@intel.com>,
 Simona Vetter <simona@ffwll.ch>, Danilo Krummrich <dakr@kernel.org>,
 Philipp Stanner <phasta@kernel.org>
References: <20261106145702.61640-1-tvrtko.ursulin@igalia.com>
 <20261106145702.61640-6-tvrtko.ursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20261106145702.61640-6-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/6/26 15:57, Tvrtko Ursulin wrote:
> amdgpu_job_stop_all_jobs_on_sched is a semi broken hack used on only one
> platform which suffers from several problems as mentioned in
> https://lore.kernel.org/amd-gfx/44edde63-7181-44fb-a4f7-94e50514f539@amd.com/.
> 
> Until it can be fully removed, given that it directly acceses DRM scheduler
> internals which want to be changed, we need to rework it to allow for
> replacing the SPSC queue with a standard spin locked list.
> 
> Problem at hand is the lock inversion between the run-queue and entity
> lock which becomes apparent once locking is added to the job queue
> amdgpu_job_stop_all_jobs_on_sched().
> 
> To work around it we change the approach of how queued jobs are drained by
> using trylock and restarting on locked entities until all queued jobs from
> all active entities are removed.
> 
> This slightly widens the existing scope for a live lock in case of
> userspace actively submitting new jobs. Whereas the current code can keep
> processing the single busy entity, this new implementation can retry on the
> entities which it previously processed.
> 
> Since userspace submitting jobs so rapidly the GPU reset cannot finish and
> the problem already exists, plus the plan is to remove this code
> altogether, we can say this is acceptable in order to unblock the DRM
> scheduler rework.
> 
> While at it we add the assert scheduler workqueue has been stopped by the
> caller and also correct the wrong order of signalling already submitted
> and queued fences.

I think that is generally the wrong approach.

See function amdgpu_ras_need_emergency_restart() who triggers the behavior when returning true:

        if (adev->asic_type == CHIP_VEGA20 &&
            adev->pm.fw_version <= 0x283400) {
                return !(amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) &&
                                amdgpu_ras_intr_triggered();
        }
        return false;

So only on Vega 20 with an outdated power management FW version we use this hack to clean up the DRM scheduler jobs.

My educated guess is the code wasn't used in at least the last 5-6 years :)

I think we should rather completely remove the amdgpu_job_stop_all_jobs_on_sched() hack and just print a big warning in the system log when we detect an outdated firmware.

Hawking and Alex any objections to that?

Regards,
Christian.

> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> References: https://lore.kernel.org/amd-gfx/44edde63-7181-44fb-a4f7-94e50514f539@amd.com/
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Philipp Stanner <phasta@kernel.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 86 ++++++++++++++++++++-----
>  1 file changed, 69 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 8689a3c933b2..1f4a4a5a978d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -457,13 +457,6 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
>  	return fence;
>  }
>  
> -/*
> - * This is a duplicate function from DRM scheduler sched_internal.h.
> - * Plan is to remove it when amdgpu_job_stop_all_jobs_on_sched is removed, due
> - * latter being incorrect and racy.
> - *
> - * See https://lore.kernel.org/amd-gfx/44edde63-7181-44fb-a4f7-94e50514f539@amd.com/
> - */
>  static struct drm_sched_job *
>  drm_sched_entity_queue_pop(struct drm_sched_entity *entity)
>  {
> @@ -476,28 +469,66 @@ drm_sched_entity_queue_pop(struct drm_sched_entity *entity)
>  	return container_of(node, struct drm_sched_job, queue_node);
>  }
>  
> -void amdgpu_job_stop_all_jobs_on_sched(struct drm_gpu_scheduler *sched)
> +static struct drm_sched_entity *
> +get_entity_with_jobs(struct drm_gpu_scheduler *sched) __acquires(&entity->lock)
>  {
> -	struct drm_sched_job *s_job;
> -	struct drm_sched_entity *s_entity = NULL;
> +	struct drm_sched_entity *entity;
>  	int i;
>  
> -	/* Signal all jobs not yet scheduled */
> +retry:
>  	for (i = DRM_SCHED_PRIORITY_KERNEL; i < sched->num_rqs; i++) {
>  		struct drm_sched_rq *rq = sched->sched_rq[i];
> +
>  		spin_lock(&rq->lock);
> -		list_for_each_entry(s_entity, &rq->entities, list) {
> -			while ((s_job = drm_sched_entity_queue_pop(s_entity))) {
> -				struct drm_sched_fence *s_fence = s_job->s_fence;
> +		list_for_each_entry(entity, &rq->entities, list) {
> +			/*
> +			 * This can false negative, but so could the previous
> +			 * approach of scanning the run-queues once when
> +			 * nothing prevents userspace to queue more jobs.
> +			 */
> +			if (!spsc_queue_count(&entity->job_queue))
> +				continue;
>  
> -				dma_fence_signal(&s_fence->scheduled);
> -				dma_fence_set_error(&s_fence->finished, -EHWPOISON);
> -				dma_fence_signal(&s_fence->finished);
> +			/*
> +			 * We must trylock because normal locking order is
> +			 * entity then rq and here we already have rq locked
> +			 * in order to be able to walk the entities.
> +			 */
> +			if (spin_trylock(&entity->lock)) {
> +				/* Returns with a locked entity. */
> +				spin_unlock(&rq->lock);
> +				return entity;
> +			} else {
> +				/*
> +				 * Busy entity - we will try again looking for a
> +				 * window where trylock will succeed.
> +				 */
> +				spin_unlock(&rq->lock);
> +				goto retry;
>  			}
>  		}
>  		spin_unlock(&rq->lock);
>  	}
>  
> +	return NULL;
> +}
> +
> +/*
> + * amdgpu_job_stop_all_jobs_on_sched has a single purpose which is an
> + * unreliable and racy, as described in:
> + *  https://lore.kernel.org/amd-gfx/44edde63-7181-44fb-a4f7-94e50514f539@amd.com/.
> + *
> + * Plan is to remove it, together with the above open coded DRM scheduler
> + * helpers, and replace with a proper solution.
> + */
> +void amdgpu_job_stop_all_jobs_on_sched(struct drm_gpu_scheduler *sched)
> +{
> +	struct drm_sched_job *s_job, *next;
> +	struct drm_sched_entity *s_entity;
> +	LIST_HEAD(queued);
> +
> +	WARN_ON_ONCE(!sched->pause_submit);
> +
>  	/* Signal all jobs already scheduled to HW */
>  	list_for_each_entry(s_job, &sched->pending_list, list) {
>  		struct drm_sched_fence *s_fence = s_job->s_fence;
> @@ -505,6 +536,27 @@ void amdgpu_job_stop_all_jobs_on_sched(struct drm_gpu_scheduler *sched)
>  		dma_fence_set_error(&s_fence->finished, -EHWPOISON);
>  		dma_fence_signal(&s_fence->finished);
>  	}
> +
> +	/*
> +	 * Signal all jobs not yet scheduled - note that the entity trylock loop
> +	 * can in theory livelock if userspace keeps submitting new jobs more
> +	 * rapidly than the loop can do a full pass over all run-queues and
> +	 * entities.
> +	 */
> +	while ((s_entity = get_entity_with_jobs(sched)) != NULL) {
> +		while ((s_job = drm_sched_entity_queue_pop(s_entity)))
> +			list_add_tail(&s_job->list, &queued);
> +		spin_unlock(&s_entity->lock);
> +	}
> +
> +	list_for_each_entry_safe(s_job, next, &queued, list) {
> +		struct drm_sched_fence *s_fence = s_job->s_fence;
> +
> +		list_del(&s_job->list);
> +		dma_fence_signal(&s_fence->scheduled);
> +		dma_fence_set_error(&s_fence->finished, -EHWPOISON);
> +		dma_fence_signal(&s_fence->finished);
> +	}
>  }
>  
>  const struct drm_sched_backend_ops amdgpu_sched_ops = {

