Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88554606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 17:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=dztMj/21
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF88D112622;
	Thu, 26 Nov 2026 17:06:15 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88FB8112621;
 Thu, 26 Nov 2026 17:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=jmtK+g0faZpXqjAUl3o5P09s+C6Pl8sPmpskva0JaUI=; t=1795712769; x=2111072769; 
 b=dztMj/21yxDkjySKjdsvPJeOwIOQ41ntrfXwSH/SIqN0E9OtX9TvHDzjzlgqx28wgXySpyAEswh
 3YE65K1nzjSrPKd3CuKvlSo2kh2G8Rlf3lBVbNJPTT1XkSnKdO/THoyN93kJaGYxicEGxKRAe0tlc
 MoCU4PBZ9efQjkrHZOd4c/rJ7fZ+x0jjIBT61lY+iCT1jOv/r7FJZPbJ0FTZBkhhY0vjM2UKO1Lvr
 Dsw0fu+gJNaCE8kqGyzS2+i9sO0uro24kXxSielCHONeLcN/aANeoeDopIsTZS48E3e2EQXWn4AGo
 vo4OeZ2QCFF9oUtCKVp+PoeZtqcf723EgPCg==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xWcv9-00000004UZq-3VBj; Thu, 26 Nov 2026 18:06:07 +0100
Message-ID: <1a1ef50a-8ae3-43bc-830c-c34793837f25@igalia.com>
Date: Thu, 26 Nov 2026 17:06:07 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] drm/sched: Track sched fence scheduled and finished time
 directly
To: sashiko-reviews@lists.linux.dev, dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org
References: <20261126154200.71180-1-tvrtko.ursulin@igalia.com>
 <sashiko-outbox-235869@kernel.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <sashiko-outbox-235869@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 26/11/2026 16:00, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issues to consider:
> - [Medium] drm/sched: drm_sched_fence_advance_start_time() advances
>    start_ts past end
> - [Medium] drm/sched: race in drm_sched_fence_scheduled() drops start_ts
>    advancement
> - [Low] drm/sched: wrong kernel-doc comment on
>    drm_sched_fence_finished_time()
> --
> 
> commit 410c845aad37c46edfe8c0d12fc45e44b4afc986
> Author: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> 
> drm/sched: Track sched fence scheduled and finished time directly
> 
> This commit records scheduled and finished timestamps directly in struct
> drm_sched_fence under a dedicated spinlock instead of reading and
> overwriting dma_fence.timestamp.
> 
>> diff --git a/drivers/gpu/drm/scheduler/sched_fence.c b/drivers/gpu/drm/scheduler/sched_fence.c
>> index 94ba0cf4fe027..5fecd3ebfffbb 100644
>> --- a/drivers/gpu/drm/scheduler/sched_fence.c
>> +++ b/drivers/gpu/drm/scheduler/sched_fence.c
>> @@ -65,6 +65,9 @@ static void drm_sched_fence_set_parent(struct drm_sched_fence *s_fence,
>>   void drm_sched_fence_scheduled(struct drm_sched_fence *fence,
>>   			       struct dma_fence *parent)
>>   {
>> +	ktime_t now = ktime_get();
>> +	unsigned long flags;
>> +
>>   	/* Set the parent before signaling the scheduled fence, such that,
>>   	 * any waiter expecting the parent to be filled after the job has
>>   	 * been scheduled (which is the case for drivers delegating waits
>> @@ -74,14 +77,26 @@ void drm_sched_fence_scheduled(struct drm_sched_fence *fence,
>>   	if (!IS_ERR_OR_NULL(parent))
>>   		drm_sched_fence_set_parent(fence, parent);
>>   
>> -	dma_fence_signal(&fence->scheduled);
>> +	spin_lock_irqsave(&fence->ts_lock, flags);
>> +	fence->start_ts = now;
>> +	spin_unlock_irqrestore(&fence->ts_lock, flags);
>> +
>> +	dma_fence_signal_timestamp(&fence->scheduled, now);
>>   }
> 
> [Severity: Medium]
> Can drm_sched_fence_scheduled() overwrite a start_ts advancement on an
> unordered submit_wq?
> 
> drm_sched_run_job_work() adds the job to sched->pending_list in
> drm_sched_job_begin() before calling run_job() and
> drm_sched_fence_scheduled().  If the previous head job finishes while
> this job is between drm_sched_job_begin() and acquiring fence->ts_lock:
> 
> work_run_job (next)               work_free_job (prev)
> drm_sched_job_begin(next)
>    list_add_tail(..., pending_list)
> fence = run_job(next)
> drm_sched_fence_scheduled()
>    now = ktime_get()
>                                    drm_sched_get_finished_job()
>                                      ts = ...finished_time(prev)
>                                      drm_sched_fence_advance_start_time()
>                                        /* start_ts == 0, no-op */
>    spin_lock(&fence->ts_lock)
>    fence->start_ts = now;  <-- older than prev's finished_ts
> 
> The advancement to prev's finish timestamp is lost and next->s_fence
> keeps the earlier timestamp, overaccounting GPU time.

I thought this wouldn't be a big deal since the delta amounts to the 
lock contention period and this new lock has a super tiny scope.

Nevertheless it is easy to fix by taking the current time once the lock 
is obtained.

> 
> [ ... ]
> 
>> diff --git a/drivers/gpu/drm/scheduler/sched_internal.h b/drivers/gpu/drm/scheduler/sched_internal.h
>> index 32d3ddb820be6..be90e55af9470 100644
>> --- a/drivers/gpu/drm/scheduler/sched_internal.h
>> +++ b/drivers/gpu/drm/scheduler/sched_internal.h
>> @@ -67,6 +67,47 @@ void drm_sched_fence_scheduled(struct drm_sched_fence *fence,
>>   			       struct dma_fence *parent);
>>   void drm_sched_fence_finished(struct drm_sched_fence *fence, int result);
>>   
>> +/**
>> + * drm_sched_fence_advance_start_time - Advance scheduler fence scheduled timestamp
>> + * @fence: scheduler fence
>> + * @t: time to advance to
>> + *
>> + * Advances the scheduler fence scheduled time to @t if the fence has already
>> + * been scheduled with an older timestamp.
>> + */
>> +static inline void
>> +drm_sched_fence_advance_start_time(struct drm_sched_fence *fence, ktime_t t)
>> +{
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&fence->ts_lock, flags);
>> +	if (fence->start_ts && ktime_after(t, fence->start_ts))
>> +		fence->start_ts = t;
>> +	spin_unlock_irqrestore(&fence->ts_lock, flags);
>> +}
> 
> [Severity: Medium]
> Can drm_sched_fence_advance_start_time() advance fence->start_ts past an
> already recorded fence->finished_ts?
> 
> If a later job on sched->pending_list finishes before the head job (for
> example, when run_job() returns an error or NULL for a canceled job so
> drm_sched_run_job_work() immediately calls drm_sched_job_done(), or when
> parent fences signal out of order), next->s_fence->finished_ts is set to
> T1 while next remains queued behind the head job.  When the head job
> later completes at T2 > T1, drm_sched_get_finished_job() advances
> next->s_fence->start_ts to T2 because drm_sched_fence_advance_start_time()
> does not check fence->finished_ts.

I did not consider errors from run_job() and cancelled jobs. Let me 
think about that and see if there are any pre-existing bugs in this area 
too.

> 
> ktime_sub(end, start) then yields a negative duration in
> drm_sched_entity_stats_job_add_gpu_time() and amdgpu_ctx_fence_time(),
> subtracting from accumulated runtime and passing a negative value cast to
> unsigned long into ewma_drm_sched_avgtime_add(), which wraps
> stats->avg_job_us and sched->avg_job_us near ULONG_MAX.
> 
>> +
>> +/**
>> + * drm_sched_fence_finished_time - Queries the scheduler fence finished timestamp
>> + * @fence: scheduler fence
>> + *
>> + * Advances the scheduler fence scheduled time to @t if the fence has already
>> + * been scheduled with an older timestamp.
>> + *
>> + * Returns: Scheduler fence finished timestamp.
>> + */
> 
> [Severity: Low]
> This kernel-doc body looks copy-pasted from
> drm_sched_fence_advance_start_time() and refers to @t, which
> drm_sched_fence_finished_time() does not take.

Mea culpa.

Tvrtko

