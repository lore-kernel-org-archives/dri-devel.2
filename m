Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 154D2C5CFDB
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 09:58:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB00F10E145;
	Fri, 14 Aug 2026 09:58:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="I9RVmSi5";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1AC910E10B;
 Fri, 14 Aug 2026 09:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=x22IGKY9oz2JwILhMxrsKHEmklxVIjnqaXeJXedAhGc=; b=I9RVmSi5MKrX3jtjZiLBKWg6ug
 xwjwRCP/XwHfEVCMSvx2M4ZgloSq2VMVwcnDAiniAbYmVx25m+5s9jlQ/zgMVM0u9YsnH7wu+swIX
 rROrT8aZoGZJy7KNg/lU8g3tXCzvGj8HSH4eeCVWAcuuACRX7cI8ZwVJBhLaxAtIVqVPPT1J87xKm
 LKHo55yV60cRF+25cmlspkWVsRrczFqWjaOdFxA6/9VPtFjpz1p0EFNKE3ZpyQR7idt0cTW631Kfv
 CC4KnjxxWtYHf67XYiun+iAaj1CqPatjkhCO7TVrDkbEoxhywO83UudCK6eog3D1nwJNVD41UUFmV
 aS08oXSQ==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wuogC-001gI6-EN; Fri, 14 Aug 2026 11:58:24 +0200
Message-ID: <a8d7c386-bfa7-4b46-8fef-b4ff6ec063d0@igalia.com>
Date: Fri, 14 Aug 2026 10:58:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/sched: Do not restore unsaved virtual runtime
To: Matthew Brost <matthew.brost@intel.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 kernel-dev@igalia.com, Luke.Wildhardt@proton.me,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>
References: <20260814075739.32481-1-tvrtko.ursulin@igalia.com>
 <20260814075739.32481-2-tvrtko.ursulin@igalia.com>
 <an7Xl8fpejcUQfvH@gsse-cloud1.jf.intel.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <an7Xl8fpejcUQfvH@gsse-cloud1.jf.intel.com>
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


On 14/08/2026 09:53, Matthew Brost wrote:
> On Fri, Aug 14, 2026 at 08:57:38AM +0100, Tvrtko Ursulin wrote:
>> Prevent pushing a new job to an entity seeing it being the first in the
>> queue, and hence entering the drm_sched_rq_add_entity() path, if the pop
>> side in drm_sched_entity_pop_job() has de-queued the job but not yet
>> updated the saved virtual time.
>>
>> We do this by pulling the locked sections out to encompass both the queue
>> push/pop and corresponding rbtree management.
>>
>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> Fixes: 2fa4d8e2c109 ("drm/sched: Add fair scheduling policy")
>> Suggested-by: Luke.Wildhardt@proton.me # via Claude Opus
>> Tested-by: Luke.Wildhardt@proton.me
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Danilo Krummrich <dakr@kernel.org>
>> Cc: Philipp Stanner <phasta@kernel.org>
>> Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>> Cc: Matthew Brost <matthew.brost@intel.com>
> 
> Ugh. Idiom:
> 
> "How much longer are we going to keep polishing this turd?"
> 
> The revert of FAIR IMO shows it basically time for a rewrite, cough -
> DRM dep.

To give any external readers clarity - hypothetical new DRM dep and fair 
policy for the current scheduler address separate and distinct kernel 
drivers.

Or to put it differently, the regression which warranted a revert does 
not apply at all to any of the drivers DRM dep would be the new solution 
for. Better scheduler for drivers not covered by the DRM dep proposal is 
still required should DRM dep happen or not.

Having clarified that...

> If we can agree, I'll prioritize, if not we'll be here seemingly
> forever.

...for me that's fine albeit unfortunate. I proposed refactoring the 
existing scheduler to split it at the backend submission level by sched 
ops and rq ops, with a future route to split the data structures as 
well, but that was rejected as a direction. So it seems some flavour of 
two schedulers will happen, but will it be DRM dep, or jobq in Rust it's 
up to the (more) interested parties to agree upon.

Regards,

Tvrtko

>> Cc: Vitaly Prosyak <vitaly.prosyak@amd.com>
>> ---
>>   drivers/gpu/drm/scheduler/sched_entity.c |  8 +++++++-
>>   drivers/gpu/drm/scheduler/sched_rq.c     | 20 +++++++++-----------
>>   2 files changed, 16 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
>> index a4a7efdbf229..673ca9cbf362 100644
>> --- a/drivers/gpu/drm/scheduler/sched_entity.c
>> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
>> @@ -559,9 +559,10 @@ struct drm_sched_job *drm_sched_entity_pop_job(struct drm_sched_entity *entity)
>>   	 */
>>   	smp_wmb();
>>   
>> +	spin_lock(&entity->lock);
>>   	spsc_queue_pop(&entity->job_queue);
>> -
>>   	drm_sched_rq_pop_entity(entity);
>> +	spin_unlock(&entity->lock);
>>   
>>   	/* Jobs and entities might have different lifecycles. Since we're
>>   	 * removing the job from the entities queue, set the jobs entity pointer
>> @@ -647,6 +648,9 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
>>   	 * Make sure to set the submit_ts first, to avoid a race.
>>   	 */
>>   	sched_job->submit_ts = submit_ts = ktime_get();
>> +
>> +	spin_lock(&entity->lock);
>> +
>>   	first = spsc_queue_push(&entity->job_queue, &sched_job->queue_node);
>>   
>>   	/* first job wakes up scheduler */
>> @@ -657,5 +661,7 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
>>   		if (sched)
>>   			drm_sched_wakeup(sched);
>>   	}
>> +
>> +	spin_unlock(&entity->lock);
>>   }
>>   EXPORT_SYMBOL(drm_sched_entity_push_job);
>> diff --git a/drivers/gpu/drm/scheduler/sched_rq.c b/drivers/gpu/drm/scheduler/sched_rq.c
>> index 0464d324d98d..23f46ec610e7 100644
>> --- a/drivers/gpu/drm/scheduler/sched_rq.c
>> +++ b/drivers/gpu/drm/scheduler/sched_rq.c
>> @@ -257,19 +257,17 @@ static ktime_t drm_sched_entity_get_job_ts(struct drm_sched_entity *entity)
>>   struct drm_gpu_scheduler *
>>   drm_sched_rq_add_entity(struct drm_sched_entity *entity, ktime_t ts)
>>   {
>> +	struct drm_sched_rq *rq = entity->rq;
>>   	struct drm_gpu_scheduler *sched;
>> -	struct drm_sched_rq *rq;
>>   
>>   	/* Add the entity to the run queue */
>> -	spin_lock(&entity->lock);
>> +	lockdep_assert_held(&entity->lock);
>> +
>>   	if (entity->stopped) {
>> -		spin_unlock(&entity->lock);
>> -
>>   		DRM_ERROR("Trying to push to a killed entity\n");
>>   		return NULL;
>>   	}
>>   
>> -	rq = entity->rq;
>>   	spin_lock(&rq->lock);
>>   	sched = rq->sched;
>>   
>> @@ -289,7 +287,6 @@ drm_sched_rq_add_entity(struct drm_sched_entity *entity, ktime_t ts)
>>   	drm_sched_rq_update_fifo_locked(entity, rq, ts);
>>   
>>   	spin_unlock(&rq->lock);
>> -	spin_unlock(&entity->lock);
>>   
>>   	return sched;
>>   }
>> @@ -343,16 +340,17 @@ drm_sched_rq_next_rr_ts(struct drm_sched_rq *rq,
>>    */
>>   void drm_sched_rq_pop_entity(struct drm_sched_entity *entity)
>>   {
>> +	struct drm_sched_rq *rq = entity->rq;
>>   	struct drm_sched_job *next_job;
>> -	struct drm_sched_rq *rq;
>> +
>> +	lockdep_assert_held(&entity->lock);
>> +
>> +	spin_lock(&rq->lock);
>>   
>>   	/*
>>   	 * Update the entity's location in the min heap according to
>>   	 * the timestamp of the next job, if any.
>>   	 */
>> -	spin_lock(&entity->lock);
>> -	rq = entity->rq;
>> -	spin_lock(&rq->lock);
>>   	next_job = drm_sched_entity_queue_peek(entity);
>>   	if (next_job) {
>>   		ktime_t ts;
>> @@ -375,8 +373,8 @@ void drm_sched_rq_pop_entity(struct drm_sched_entity *entity)
>>   			drm_sched_entity_save_vruntime(entity, min_vruntime);
>>   		}
>>   	}
>> +
>>   	spin_unlock(&rq->lock);
>> -	spin_unlock(&entity->lock);
>>   }
>>   
>>   /**
>> -- 
>> 2.54.0
>>

