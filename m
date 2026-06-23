Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F2CCDB47C
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 14:05:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EAEF10EB6E;
	Tue, 23 Jun 2026 14:05:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Pg6lS/V3";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 331E010EB61;
 Tue, 23 Jun 2026 14:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cPto1gQbLg7M3k+7xX6O59xbrykZd5OtITcVmMJ3Cec=; b=Pg6lS/V3IsuxSepj169GX7T98j
 1Psbyo/R3nwYpgrjQF0/MgFOfbjTt83YkWBdoHefwiMwMNF5dLA3FEftZNzXxPYbdmuVRCdUFPQl8
 I5KrwhXey37SFhmXxlyCGzYctQq3hfFW8r9bb2Frn6LSW3nY1LX8DzXsYayHKMg1TKDeQQHGOrGa+
 fkKoOE6PGDmaj4Oe4vqEfHhRIlhqFRzvhvw/JoHoT2Cdy2+CcXR0riUVIfuw9msgBzeW4xVouc41V
 7AB7Qu8nD0hbiii+f5kxf0eyiyeZS/gYtLmnN/Sz7IKYlUdFD+x/rSkoqQLChHXd/p0S/TLhVVcog
 zrpbyO8A==;
Received: from [90.240.106.137] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wc1kn-004Cxh-1E; Tue, 23 Jun 2026 16:05:29 +0200
Message-ID: <d505d14d-f62b-4f71-9990-c82411381f48@igalia.com>
Date: Tue, 23 Jun 2026 15:05:26 +0100
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
 <fd5e55f6-c6be-48b4-8b87-c3d6d6d0a6ff@igalia.com>
 <e9b876bea7a2ef33d5e4ca103721135400c875be.camel@mailbox.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <e9b876bea7a2ef33d5e4ca103721135400c875be.camel@mailbox.org>
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


On 23/06/2026 09:48, Philipp Stanner wrote:
> On Tue, 2026-06-23 at 08:19 +0100, Tvrtko Ursulin wrote:
>> On 17/06/2026 09:38, Philipp Stanner wrote:
>>>> +	/*
>>>> +	 * Make sure this entity is not used by the scheduler at the moment.
>>>> +	 *
>>>> +	 * Scheduler is guaranteed to be stable after the entity was stopped and
>>>> +	 * removed from the run-queue.
>>>> +	 */
>>>> +	if (sched)
>>>> +		drm_sched_flush_run_work(sched);
>>>>    
>>>> -	/* The entity is guaranteed to not be used by the scheduler */
>>>>    	prev = rcu_dereference_check(entity->last_scheduled, true);
>>>>    	dma_fence_get(prev);
>>>>    	while ((job = drm_sched_entity_queue_pop(entity))) {
>>>> @@ -576,6 +578,13 @@ void drm_sched_entity_select_rq(struct drm_sched_entity *entity)
>>>>    		return;
>>>>    
>>>>    	spin_lock(&entity->lock);
>>>> +
>>>> +	if (entity->stopped) {
>>>> +		spin_unlock(&entity->lock);
>>>> +		return;
>>>> +
>>>> +	}
>>>
>>> Seems unrelated? Why wasn't this needed semantically before?
>>
>> It solidifies the guarantee drm_sched_entity_kill() expects that the
>> scheduler assigned to an entity cannot change after entity has been stopped.
> 
> That in general I like a lot, of course. As you probably know my
> "dream" for drm_sched is to get rid of as much lockless magic as
> possible, shown by the entries I've added to Documentation/gpu/todo.rst
> (on drm-misc-next).
> 
>>
>> There we have this sequence:
>>
>>     spin_lock(&entity->lock);
>>     entity->stopped = true;
>>     sched = drm_sched_rq_remove_entity(entity->rq, entity);
>>     spin_unlock(&entity->lock);
>>
>>     if (sched)
>>     	drm_sched_flush_run_work(sched);
>>
>> That is, without that check, in theory, an evil driver could race
>> drm_sched_entity_select_rq() (via drm_sched_job_arm()) and
>> drm_sched_entity_kill(). I am not sure if any driver can actually do
>> that at the moment but it felt sensible to express it in code.
> 
> The devil is in the "at the moment".
> 
> AFAICS and as your explanation sounds, this is an existing problem that
> is unrelated to the Flush RFC. So I suppose that this should be a
> separate patch (independent from this one) which precisely focusses on
> this robustness work.

Catch is, and why I thought it is justified to do this it in this patch, 
is because before completion was in the entity so whats happening with 
entity->rq->sched after entity is stopped was irrelevant. With this 
patch is it relevant on paper so I considered it prudent to express that 
in the code as well as the comment.

Acceptable or unacceptable?

> A dedicated patch probably should then be concerned about the 'stopped'
> bool's synchronization in general and should investigate the lockless
> check in drm_sched_entity_is_idle(), too. The memory barrier there
> seems only concerned about the list…
> 
> 
>>
>>>> +
>>>>    	sched = drm_sched_pick_best(entity->sched_list, entity->num_sched_list);
>>>>    	rq = sched ? &sched->rq : NULL;
>>>>    	if (rq != entity->rq) {
>>>> diff --git a/drivers/gpu/drm/scheduler/sched_internal.h b/drivers/gpu/drm/scheduler/sched_internal.h
>>>> index 13ecb771d7a2..80dece3be415 100644
>>>> --- a/drivers/gpu/drm/scheduler/sched_internal.h
>>>> +++ b/drivers/gpu/drm/scheduler/sched_internal.h
>>>> @@ -35,12 +35,22 @@ bool drm_sched_can_queue(struct drm_gpu_scheduler *sched,
>>>>    			 struct drm_sched_entity *entity);
>>>>    void drm_sched_wakeup(struct drm_gpu_scheduler *sched);
>>>>    
>>>> +/**
>>>> + * drm_sched_flush_run_work - flush the run-job work
>>>
>>> In v1, you'd probably want to document what this function typically
>>> will be used for :)
>>
>> Well its in the scheduler _internal_ header and I am not sure what to
>> write which will add real value.
>>
>> "Only used to make sure a stopped entity is not in use by the scheduler
>> workers."
> 
> I think the magic word that provides value to newbies trying to get
> familiar with our complex code base is "synchronization".
> 
> "A synchronization helper used to make sure that no scheduler worker
> does access this entity anymore."

Wilco.

Regards,

Tvrtko


