Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB9ECDB471
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 07:19:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3609810E994;
	Tue, 23 Jun 2026 07:19:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="rj4Gq6m3";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3C7010E982;
 Tue, 23 Jun 2026 07:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ET7OgFlHrJ+3KEdV0J1uiTWDRciWlbKIl2vMbcrMF8I=; b=rj4Gq6m3d1xd3Jrd2o573sU7gn
 5flzufiBtzjvqCVo2cgPTTJzKDyOP0qwxshdlvPIUeUn2QcO0c8l+5tWoUwgbjn6Ft+TdpTgtJunK
 c1uXsIHnGMMhMBTzIzAK4N9k5dt5iXp3xrtScjqwMViTp/kzm2tmUuc05knmnNuUB+kqg5PyEzAxR
 QkvYStbI4B0dGqOQK0mSu8d5XZq/rK1jnb5+Ns5LjaZhTjO3Ci9mDH53eoLQrGcbGCUzmHfGQCvjY
 WXZxbFkF1V5G8/ZlksBPaFSheBAD7gWv1dtuKuBzP+keZ4BfUMLAUy4joriA8/cDDzXJZhPVsVx/5
 6FFmex9w==;
Received: from [90.240.106.137] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wbvQ8-0044WG-2V; Tue, 23 Jun 2026 09:19:44 +0200
Message-ID: <fd5e55f6-c6be-48b4-8b87-c3d6d6d0a6ff@igalia.com>
Date: Tue, 23 Jun 2026 08:19:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] drm/sched: Replace completion with a flush
To: phasta@kernel.org, dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, amd-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
References: <20260611123423.39819-1-tvrtko.ursulin@igalia.com>
 <ba8ea856526d54753da68deefe7b77f15c908fa3.camel@mailbox.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <ba8ea856526d54753da68deefe7b77f15c908fa3.camel@mailbox.org>
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


On 17/06/2026 09:38, Philipp Stanner wrote:
> On Thu, 2026-06-11 at 13:34 +0100, Tvrtko Ursulin wrote:
>> Due the scheduler locking design, and the inability to always lock both
>> the entity and the run-queue in the consistent order, a completion exists
>> which effectively marks the entity as in use from a call path which is not
>> able to lock it.
>>
>> When entity is selected from the run job worker, its completion is marked
>> as non-idle all until the code is sure it will not be dereferencing it any
>> more, at which point it signals it as idle, releasing the potential
>> parallel cleanup path.
>>
>> We can remove the need for this completion by implementing the identical
>> guarantee by simply flushing the run job work from the cleanup path, after
>> having removed the entity from the run queue.
>>
>> We then know that the entity is no longer reachable by the run queue
>> selection logic, so as soon as any pending work is done the cleanup can
>> safely proceed. And because we have marked the entity as stopped, we also
>> know that the entity cannot re-enter the run queue.
>>
>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Danilo Krummrich <dakr@kernel.org>
>> Cc: Matthew Brost <matthew.brost@intel.com>
>> Cc: Philipp Stanner <phasta@kernel.org>
>> Cc: amd-gfx@lists.freedesktop.org
>> Cc: intel-xe@lists.freedesktop.org
>> ---
>> "Perfection is achieved, not when there is nothing more to add, but when
>>   there is nothing left to take away." - Antoine de Saint-Exupéry
> 
> 
> Hmm, alright, so the basic trick just seems to be that the workqueue
> implementation already can ensure the synchronization which we manually
> implemented so far through the completion.
> 
> 
> It's a bit more LOC, and doesn't solve a bug. However, I kind of like
> the idea because it removes a redundant mechanism. Would be cool to
> hear some other opinions, though.
> 
> A comment below
> 
>>
>> Lets see what Intel's CI says about this, not to mention our new AI
>> overlords...
>> ---
>>   drivers/gpu/drm/scheduler/sched_entity.c   | 25 +++++++++++++++-------
>>   drivers/gpu/drm/scheduler/sched_internal.h | 14 ++++++++++--
>>   drivers/gpu/drm/scheduler/sched_main.c     |  2 --
>>   drivers/gpu/drm/scheduler/sched_rq.c       | 14 +++++++-----
>>   include/drm/gpu_scheduler.h                |  9 --------
>>   5 files changed, 38 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
>> index c51101ec70c1..e6f7c2fbefce 100644
>> --- a/drivers/gpu/drm/scheduler/sched_entity.c
>> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
>> @@ -137,10 +137,6 @@ int drm_sched_entity_init(struct drm_sched_entity *entity,
>>   	entity->rq = &sched_list[0]->rq;
>>   	RCU_INIT_POINTER(entity->last_scheduled, NULL);
>>   	RB_CLEAR_NODE(&entity->rb_tree_node);
>> -	init_completion(&entity->entity_idle);
>> -
>> -	/* We start in an idle state. */
>> -	complete_all(&entity->entity_idle);
>>   
>>   	spin_lock_init(&entity->lock);
>>   	spsc_queue_init(&entity->job_queue);
>> @@ -276,18 +272,24 @@ static void drm_sched_entity_kill_jobs_cb(struct dma_fence *f,
>>    */
>>   void drm_sched_entity_kill(struct drm_sched_entity *entity)
>>   {
>> +	struct drm_gpu_scheduler *sched;
>>   	struct drm_sched_job *job;
>>   	struct dma_fence *prev;
>>   
>>   	spin_lock(&entity->lock);
>>   	entity->stopped = true;
>> -	drm_sched_rq_remove_entity(entity->rq, entity);
>> +	sched = drm_sched_rq_remove_entity(entity->rq, entity);
>>   	spin_unlock(&entity->lock);
>>   
>> -	/* Make sure this entity is not used by the scheduler at the moment */
>> -	wait_for_completion(&entity->entity_idle);
>> +	/*
>> +	 * Make sure this entity is not used by the scheduler at the moment.
>> +	 *
>> +	 * Scheduler is guaranteed to be stable after the entity was stopped and
>> +	 * removed from the run-queue.
>> +	 */
>> +	if (sched)
>> +		drm_sched_flush_run_work(sched);
>>   
>> -	/* The entity is guaranteed to not be used by the scheduler */
>>   	prev = rcu_dereference_check(entity->last_scheduled, true);
>>   	dma_fence_get(prev);
>>   	while ((job = drm_sched_entity_queue_pop(entity))) {
>> @@ -576,6 +578,13 @@ void drm_sched_entity_select_rq(struct drm_sched_entity *entity)
>>   		return;
>>   
>>   	spin_lock(&entity->lock);
>> +
>> +	if (entity->stopped) {
>> +		spin_unlock(&entity->lock);
>> +		return;
>> +
>> +	}
> 
> Seems unrelated? Why wasn't this needed semantically before?

It solidifies the guarantee drm_sched_entity_kill() expects that the 
scheduler assigned to an entity cannot change after entity has been stopped.

There we have this sequence:

   spin_lock(&entity->lock);
   entity->stopped = true;
   sched = drm_sched_rq_remove_entity(entity->rq, entity);
   spin_unlock(&entity->lock);

   if (sched)
   	drm_sched_flush_run_work(sched);

That is, without that check, in theory, an evil driver could race 
drm_sched_entity_select_rq() (via drm_sched_job_arm()) and 
drm_sched_entity_kill(). I am not sure if any driver can actually do 
that at the moment but it felt sensible to express it in code.

>> +
>>   	sched = drm_sched_pick_best(entity->sched_list, entity->num_sched_list);
>>   	rq = sched ? &sched->rq : NULL;
>>   	if (rq != entity->rq) {
>> diff --git a/drivers/gpu/drm/scheduler/sched_internal.h b/drivers/gpu/drm/scheduler/sched_internal.h
>> index 13ecb771d7a2..80dece3be415 100644
>> --- a/drivers/gpu/drm/scheduler/sched_internal.h
>> +++ b/drivers/gpu/drm/scheduler/sched_internal.h
>> @@ -35,12 +35,22 @@ bool drm_sched_can_queue(struct drm_gpu_scheduler *sched,
>>   			 struct drm_sched_entity *entity);
>>   void drm_sched_wakeup(struct drm_gpu_scheduler *sched);
>>   
>> +/**
>> + * drm_sched_flush_run_work - flush the run-job work
> 
> In v1, you'd probably want to document what this function typically
> will be used for :)

Well its in the scheduler _internal_ header and I am not sure what to 
write which will add real value.

"Only used to make sure a stopped entity is not in use by the scheduler 
workers."

Good enough?

Regards,

Tvrtko

