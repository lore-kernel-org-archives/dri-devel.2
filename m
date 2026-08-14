Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D87C5B572
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 10:34:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E93E10E549;
	Fri, 14 Aug 2026 10:34:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Mul0DBDE";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC56010E549
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 10:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=YkQjnFDCo1dB5BDFIb8WGuaEHaukQCwRTziICDH/SuA=; b=Mul0DBDEEj9W4CaPnW6yRmTnpz
 nEufwi/PEidJzP5z7wHwbGe9j0EdGE88Z6AOeikUM5cLpX2IqyTEwaDIg6iikmYKAQ4I3U+SQPaF8
 o1VVWwyNQeEcSV0b4bTB/c+BdLCDQk27wtOV4fP/mtGJcwC2sexv0hAXNPFaWIVHpZ8VwO8tiR+ih
 OxzMbIByp+XHoFhEtjgJcP513h5eHnfDqUW1Le98j7gqC9Vp0Sl1+GJq+ygJqxiupM7xwpI6olYof
 bYiYURfN6VCH4Rz+SMp2/mpRkzObmR5ta9ov6urvOU1P+e6IUYdXVZRyfUgQXRy7ycFC1K5HsXhKr
 54hFtmzg==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wupEz-001hAO-1O; Fri, 14 Aug 2026 12:34:21 +0200
Message-ID: <7657d2ea-30c7-4655-be90-04e86fb2212a@igalia.com>
Date: Fri, 14 Aug 2026 11:34:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/sched: Ensure monotonic min_vruntime
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
References: <20260814075739.32481-1-tvrtko.ursulin@igalia.com>
 <20260814075739.32481-3-tvrtko.ursulin@igalia.com>
 <20260814080942.58E071F000E9@smtp.kernel.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260814080942.58E071F000E9@smtp.kernel.org>
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


On 14/08/2026 09:09, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] drm_sched_entity_save_vruntime() always saves a virtual runtime lag of 0 due to an impossible condition, permanently destroying the entity's relative lag state.
> - [Medium] rq->min_vruntime incorrectly tracks the maximum updated vruntime of the executing entity rather than the true minimum of the runqueue, penalizing newly enqueued entities.
> --
> 
> --- Patch [2]: [PATCH 2/2] drm/sched: Ensure monotonic min_vruntime ---
> commit 840e24cc75ac9a836c633b23cb95dda0e0dc3b75
> Author: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> 
> drm/sched: Ensure monotonic min_vruntime
> 
> min_vruntime handling had a bug where if an entity never exited the run-
> queue it could get penalised by its virtual runtime only ever growing,
> while the periodically exiting and re-joining entities could repeatedly
> get pulled ahead of it.
> 
> Fix it by making the min_vruntime strictly monotonic by tracking it
> separately (an keeping it always up to date) instead of fetching what
> happens to be the top of the tree sorted by virtual runtime.
> 
> While at it replace open coded ktime_t comparison with the correct
> ktime_after() helper.
> 
> Fixes: 2fa4d8e2c109 ("drm/sched: Add fair scheduling policy")
> Tested-by: Luke.Wildhardt@proton.me
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Luke.Wildhardt@proton.me
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Philipp Stanner <phasta@kernel.org>
> Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Cc: Vitaly Prosyak <vitaly.prosyak@amd.com>
> 
>> diff --git a/drivers/gpu/drm/scheduler/sched_rq.c b/drivers/gpu/drm/scheduler/sched_rq.c
>> index 23f46ec610e78..bc8363974a276 100644
>> --- a/drivers/gpu/drm/scheduler/sched_rq.c
>> +++ b/drivers/gpu/drm/scheduler/sched_rq.c
> 
> [ ... ]
> 
>> @@ -151,7 +130,7 @@ drm_sched_entity_save_vruntime(struct drm_sched_entity *entity,
>>   
>>   	spin_lock(&stats->lock);
>>   	vruntime = stats->vruntime;
>> -	if (min_vruntime && vruntime > min_vruntime)
>> +	if (ktime_after(vruntime, min_vruntime))
> 
> [Severity: High]
> Will this condition always evaluate to false and unconditionally reset the
> saved lag to 0?
> 
> In drm_sched_rq_pop_entity(), the runqueue's min_vruntime is updated to be
> at least the entity's current vruntime:
> 
> drm_sched_rq_pop_entity() {
>      ...
>      ts = drm_sched_entity_update_vruntime(entity);
>      if (ktime_after(ts, rq->min_vruntime))
>          rq->min_vruntime = ts;
> 
> Later in the same function, if the queue is empty, we call:
> 
>      drm_sched_entity_save_vruntime(entity, rq->min_vruntime);
> 
> Since min_vruntime is guaranteed to be greater than or equal to the entity's
> vruntime at this point, the ktime_after(vruntime, min_vruntime) check here
> seems mathematically impossible to satisfy.
> 
> Does this mean entities that empty their runqueue will permanently lose
> their accumulated vruntime penalty?

Okay, it's not a quick fix so I'll drop 2/2 for now and come back to it 
later. 1/2 stands on it's own anyway.

Regards,

Tvrtko

> 
>>   		vruntime = ktime_sub(vruntime, min_vruntime);
>>   	else
>>   		vruntime = 0;
> 
> [ ... ]
> 
>> @@ -351,27 +324,27 @@ void drm_sched_rq_pop_entity(struct drm_sched_entity *entity)
>>   	 * Update the entity's location in the min heap according to
>>   	 * the timestamp of the next job, if any.
>>   	 */
>> +
>> +	if (drm_sched_policy == DRM_SCHED_POLICY_FAIR) {
>> +		ts = drm_sched_entity_update_vruntime(entity);
>> +		if (ktime_after(ts, rq->min_vruntime))
>> +			rq->min_vruntime = ts;
>> +	}
>> +
> 
> [Severity: Medium]
> Does this unintentionally advance the runqueue's min_vruntime past other
> entities still waiting in the RB tree?
> 
> By setting rq->min_vruntime to the newly updated vruntime of the currently
> executing entity, it seems we might ignore the vruntimes of other entities
> that are still queued.
> 
> When new entities join the runqueue, won't their initial vruntime be based
> on this artificially inflated min_vruntime, penalizing them relative to the
> existing waiting entities?
> 
>>   	next_job = drm_sched_entity_queue_peek(entity);
>>   	if (next_job) {
>> -		ktime_t ts;
>> -
>> -		if (drm_sched_policy == DRM_SCHED_POLICY_FAIR)
>> -			ts = drm_sched_entity_get_job_ts(entity);
>> -		else if (drm_sched_policy == DRM_SCHED_POLICY_FIFO)
>> +		if (drm_sched_policy == DRM_SCHED_POLICY_FIFO)
>>   			ts = next_job->submit_ts;
>> -		else
>> +		else if (drm_sched_policy == DRM_SCHED_POLICY_RR)
>>   			ts = drm_sched_rq_next_rr_ts(rq, entity);
>>   
>>   		drm_sched_rq_update_fifo_locked(entity, rq, ts);
>>   	} else {
>> -		drm_sched_rq_remove_fifo_locked(entity, rq);
>> -
>> -		if (drm_sched_policy == DRM_SCHED_POLICY_FAIR) {
>> -			ktime_t min_vruntime;
>> +		if (drm_sched_policy == DRM_SCHED_POLICY_FAIR)
>> +			drm_sched_entity_save_vruntime(entity,
>> +						       rq->min_vruntime);
>>   
>> -			min_vruntime = drm_sched_rq_get_min_vruntime(rq);
>> -			drm_sched_entity_save_vruntime(entity, min_vruntime);
>> -		}
>> +		drm_sched_rq_remove_fifo_locked(entity, rq);
>>   	}
>>   
>>   	spin_unlock(&rq->lock);
> 

