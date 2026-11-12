Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33109606A897
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 13:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=F0a/wLBZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6081811210D;
	Thu, 12 Nov 2026 13:00:00 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6541211210D;
 Thu, 12 Nov 2026 12:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=AWXOHB4eq07srq9BA8SlrXqaufF/LfzAKHpn7R5j6K4=; t=1794488394; x=2109848394; 
 b=F0a/wLBZklfnSbAXtgR7stklIjueVqTeMwB6kYk9kmrweSQLC0yZHPofGu9tkHVJd+r1tiQrffB
 A7uuVtYEQF8MAqJEwP8BYRRPIUe+UlKJV2eZC+GaIalpHbKqFQcaWt1cSAteYtZ42jlCe+4gkpnjQ
 GXTHCNAN91hXESoE9A+QZ3PaLrBHg8/fOlUPkShaLu8p9A0xgMSGNRH7aWmxMHsxlD4eJc9YQtN8c
 al0tkAuzvi3MxWXeFxF1roNXiSON4rhXrv/AoDW3qV7EoyfEpi5qzD1B4UA7iSzxvQl4Y5jJkqsDI
 ziW1MbHMRqo7hJlHPz3j8WcodAhIMRshsKNQ==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xRUPA-009Y5y-19; Thu, 12 Nov 2026 13:59:52 +0100
Message-ID: <f5e91cef-a9af-4839-b7b7-45351d59d881@igalia.com>
Date: Thu, 12 Nov 2026 12:59:51 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] drm/sched: Replace the SPSC queue with a list and a
 spinlock
To: phasta@kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>
References: <20261106145702.61640-1-tvrtko.ursulin@igalia.com>
 <20261106145702.61640-7-tvrtko.ursulin@igalia.com>
 <c3e0decc799da64c09689b85c3db49b0b0a437b4.camel@mailbox.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <c3e0decc799da64c09689b85c3db49b0b0a437b4.camel@mailbox.org>
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
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 10/11/2026 15:49, Philipp Stanner wrote:
> Just taking a closer look now since I assumed this is some sort of RFC
> for AMD to look first.
> 
> On Fri, 2026-11-06 at 14:57 +0000, Tvrtko Ursulin wrote:
>> Migrate the entity job queue from the single user SPSC queue (single
>> producer, single consumer) to the standard list_head plus a spinlock in
>> order to make it easier to argue about correctnes and bring the code base
>> close to the usual kernel patterns.
>>
>> The main thing which needs to be mentioned is the seeming usage of RCU,
>> which isn't really so, but only for two trivial reasons:
> 
> If that were really the only way then we would, unfortunately, not at
> all end up with "usual kernel patterns" :(
> 
>>
>> 1.
>> We need to use the list operations which are safe for unlocked access to
>> the list head, while parallel (locked) threads can be appending other
>> jobs.
>>
>> This so the run job worker is able to process the job dependencies which
>> includes it calling a potentially sleeping prepare_job() callback. Hence
>> it is not possible to hold the entity->lock during that stage.
> 
> Why can't it pull a job from the list, release the lock and then do
> that? There is only ever 1 worker at a time.
> 
>> 2.
>> We need to work around the infamous entity<->rq locking inversion which
>> would now trigger slightly earlier in the run job worker, from the entity
>> selection stage, where there was previosuly the other "spsc queue peek"
>> call site.
> 
> Is spsc_queue_peek() the only place where an inversion would occur?

Ignoring amdgpu yes.

Regarding spsc_queue_peek(), the current code has three of those:

1. drm_sched_rq_pop_entity()

This call site is not a lock inversion site.

Instead of the peek, the next job now gets passed in by the caller, 
drm_sched_entity_pop_job(), which is correctly holding entity->lock.

2. drm_sched_can_queue()

This is a lock inversion site since it runs under the rq->lock during 
entity selection phase of drm_sched_run_job_work().

The purpose of the peek is to answer "does the first queued job for this 
entity required less or equal to credits than this scheduler instance 
can queue".

Since this is a lock inversion site we cannot lock but truly have to 
have an unlocked solution. In this patch I removed the requirement to 
look at the job queue by tracking the credits requirement of the first 
job in the entity itself (entity->job_credits).

This is effectively replacing one unlocked read (spsc_queue_peek) with a 
different one (READ_ONCE(entity->job_credits)). Something unlocked is 
unavoidable here and I think this is more elegant and simple.

And because it is an unlocked read it has to be annotated with 
READ_ONCE(). Which means the write side, even though it is done under 
the lock, is paired up and marked with WRITE_ONCE().

2. drm_sched_entity_pop_job()

This is not a lock inversion site but needs to call sleepable things 
while considering the head of the job queue (->prepare_job()).

This one is the only remaining reason I used list_add_tail_rcu and 
list_del_rcu, just so from here we can safely touch the first entry 
while elsewhere more are being added.

It is possible to do it, as you suggest, by dropping and re-acquiring 
the lock. Note however that too would need a big fat comment why it is 
safe. At which point, since both cases have a big fat comment explaining 
the same thing apart from the implementation details, I do not see the 
advantage of pointless lock cycling. READ_ONCE and WRITE_ONCE you 
dislike would still remain.

As a side note it would be really good to eliminate the prepare_job 
callback but I haven't look how feasible that would be troughout the 
tree in around two years. Back then I tried to call it earlier, and put 
the fence in the normal dependency array, but that did not work at least 
for amdgpu.

>> All the list_*_rcu usage stem from those two requirements and there are no
>> actual RCU requirements.
> 
> IDK, having RCU functions (and all those ACCESS_ONCEs!) in the code
> base that is now supposed to be a simple lock + list does not sound
> like a good idea for maintainability at all, especially if it's RCU
> that is no actual RCU.

For this and the following questions, I've tried to explain everything 
in the consolidated paragraph just above.

Regards,

Tvrtko

> 
> […]
> 
> 
>>   static struct drm_sched_job *
>>   drm_sched_entity_queue_pop(struct drm_sched_entity *entity)
>>   {
>> -	struct spsc_node *node;
>> +	struct drm_sched_job *next_job, *sched_job;
>>   
>> -	node = spsc_queue_pop(&entity->job_queue);
>> -	if (!node)
>> +	lockdep_assert_held(&entity->lock);
>> +
>> +	sched_job = list_first_entry_or_null(&entity->job_queue,
>> +					     typeof(*sched_job), queue_link);
>> +	if (!sched_job)
>>   		return NULL;
>>   
>> -	return container_of(node, struct drm_sched_job, queue_node);
>> +	list_del_rcu(&sched_job->queue_link);
>> +
>> +#if IS_ENABLED(CONFIG_TRACEPOINTS) || IS_ENABLED(CONFIG_DRM_SCHED_KUNIT_TEST)
>> +	WRITE_ONCE(entity->job_count, entity->job_count - 1);
> 
> You're literally holding the entity->lock, what do you need read once
> for?
> 
>> +#endif
>> +
>> +	next_job = list_first_entry_or_null(&entity->job_queue,
>> +					    typeof(*next_job), queue_link);
>> +	if (next_job)
>> +		WRITE_ONCE(entity->job_credits, next_job->credits);
>> +	else
>> +		WRITE_ONCE(entity->job_credits, 0);
> 
> Same.
> 
>> +
>> +	return sched_job;
>>   }
>>   
>>
> 
> […]
> 
> 
>>   EXPORT_SYMBOL(drm_sched_entity_kill);
>> @@ -557,10 +556,20 @@ struct drm_sched_job *drm_sched_entity_pop_job(struct drm_sched_entity *entity)
>>   	/* Helper to avoid dropping the reference while the entity lock is held,
>>   	 * just to have some more robustness.
>>   	 */
>> +	struct drm_sched_job *sched_job, *next_job;
>>   	struct dma_fence *prev_last_scheduled;
>> -	struct drm_sched_job *sched_job;
>>   
>> -	sched_job = drm_sched_entity_queue_peek(entity);
>> +	/*
>> +	 * We cannot lock the entity at this point since processing dependencies
>> +	 * needs to be able to call a sleeping ops->prepare_job(). Note that RCU
>> +	 * lock is not stricly required since single workqueue is the only
>> +	 * caller and that guarantees a single consumer. Ie. the job cannot
>> +	 * disappear on us.
>> +	 */
>> +	rcu_read_lock();
>> +	sched_job = list_first_or_null_rcu(&entity->job_queue,
>> +					   typeof(*sched_job), queue_link);
>> +	rcu_read_unlock();
> 
> You can take the lock, take the job, release the lock, do your sleeping
> actions, and then take the lock again, can't you?
> 
> 
> P.

