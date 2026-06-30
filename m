Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46FCDC43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 10:46:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9875610E1C3;
	Tue, 30 Jun 2026 10:46:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="hwcrkug8";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CECDC10E1C3
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 10:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WlXJBQz5A57M4/4cjKu8vy0BBzeoLO2eU2Om2U0YMyM=; b=hwcrkug8oh0EUiDVVqjcDu7x7D
 5JhQwINAKPlqverfRZKXSNF8CULxDyho/O/RumOvyrZmjp2H/+BgfCQiw83Rxc4Wx8N+7llqe1Tbp
 oL8o9/bbgKVdoYCiVn6ERb/PYm9Rg82AXl8olNLG0qcEurYKMxK5skpZ7vTK4M+fym6ojcifw51b4
 LwnuFGNzAaQtwQoMws6FrPtcqX4vfWqaW41KKBGTbDIWiTjX6y2vSDloToNV2vFVAAs0LhtLSm6Bf
 bZsGXoRWtoROnNH8AfdYwO+KUbB72a2w/0yUeh9cMxN6PsBX0KHXtMlYc/AdNbfDdL/ebdfHJGVGi
 IS/ECYPg==;
Received: from [90.240.106.137] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1weVyv-0073Dd-5P; Tue, 30 Jun 2026 12:46:21 +0200
Message-ID: <d317b769-0f7c-47a2-a049-ea51c87fcfb7@igalia.com>
Date: Tue, 30 Jun 2026 11:46:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/sched: Protect entity->last_scheduled with spinlock
To: phasta@kernel.org, Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
References: <20260626081942.2122144-2-phasta@kernel.org>
 <1941b3c5-2ef1-4da9-aa20-a11d771274f1@igalia.com>
 <9f7fa57610d3d94324e09dc936f5f7f3c3d390d3.camel@mailbox.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <9f7fa57610d3d94324e09dc936f5f7f3c3d390d3.camel@mailbox.org>
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


On 30/06/2026 11:06, Philipp Stanner wrote:
> On Tue, 2026-06-30 at 10:23 +0100, Tvrtko Ursulin wrote:
>>
>> On 26/06/2026 09:19, Philipp Stanner wrote:
>>> The entity->last_scheduled field has always been set and read with
>>> special RCU functions in addition to memory barriers. There is no
>>> obvious reason for that, since the entity lock is available and taken at
>>> all places that evaluate the last_scheduled field. The only exception is
>>> drm_sched_entity_error(), which is not performance critical in any way.
>>
>> I agree this looks odd since all call sites apart from
>> drm_sched_entity_error() use
>> "rcu_dereference_check(entity->last_scheduled, true);" ie. "ignore" the RCU.
>>
>> Btw this was added in:
>>
>> commit 70102d77ff22dd88a0111b1c3bac5099ac5d0425
>> Author: Christian König <christian.koenig@amd.com>
>> Date:   Mon Apr 17 17:32:11 2023 +0200
>>
>>       drm/scheduler: add drm_sched_entity_error and use rcu for
>> last_scheduled
>>
>> You may want to add this as a reference in the commit message.
> 
> I did git-blame for that commit. It looks like this:
> 
>      drm/scheduler: add drm_sched_entity_error and use rcu for last_scheduled
>      
>      Switch to using RCU handling for the last scheduled job and add a
>      function to return the error code of it.
> 
> It's a good example of why I think it's so vital to write verbose
> commit messages. The only way to find out why this was added is to ask
> the author, if he's still around [which is the case in this case].
> 
> I can't see the value of adding a link? That commit says "add foo" and
> my commit says "remove foo because it achieves nothing".

It achieves something, there is a little bit more detail to it. You 
could write:

Commit xxx added RCU without documenting that it needed it for lockless 
access to blah blah, while all other call sites needed to explicitly and 
forcefully silence the RCU checker, etc...

Anyway, I don't intend to write the commit text but my point is value 
can be added while being accurate. If you add a patch which says "there 
is no obvious reason", well, lets leave historical breadcrumbs to make 
it less non-obvious, now that we know what it was.

>> I guess it relied on dma-fence RCU destruction to enable lockless
>> lookups from the AMD submit path. Given how many other locks we have in
>> those paths it is probably noise to have one more so maybe it is a win
>> to remove some barriers and those rcu_dereference_check-true lines. I
>> think Christian will need to comment.
> 
> My argument is more that locks are the right tool to use unless there
> is proof to the contrary.
> 
>>
>>> Improve robustness, readability and maintainability by replacing RCU and
>>> barriers with the lock.
>>>
>>> As a preparational step, while at it, also guard spsc_queue_pop() with
>>> the lock, since spsc_queue is deprecated and supposed to be replaced
>>> with a locked list.
>>
>> You would have said to split the logical changes into separate patches.
> 
> Me? :D
> 
> In this case, a lock that did not exist is added from nowhere. But I
> tend to think that you are right. We could leave spsc_queue lockless
> for now. That's cleaner.
> 
>>
>>>
> 
> […]
> 
>>>
>>>    struct drm_sched_job *drm_sched_entity_pop_job(struct drm_sched_entity *entity)
>>>    {
>>> +	/* Helper to avoid dropping the reference while the entity lock is held,
>>> +	 * just to have some more robustness.
>>> +	 */
>>> +	struct dma_fence *prev_last_scheduled;
>>>    	struct drm_sched_job *sched_job;
>>>    
>>>    	sched_job = drm_sched_entity_queue_peek(entity);
>>> @@ -523,19 +532,20 @@ struct drm_sched_job *drm_sched_entity_pop_job(struct drm_sched_entity *entity)
>>>    	if (entity->guilty && atomic_read(entity->guilty))
>>>    		dma_fence_set_error(&sched_job->s_fence->finished, -ECANCELED);
>>>    
>>> -	dma_fence_put(rcu_dereference_check(entity->last_scheduled, true));
>>> -	rcu_assign_pointer(entity->last_scheduled,
>>> -			   dma_fence_get(&sched_job->s_fence->finished));
>>> +	spin_lock(&entity->lock);
>>> +	prev_last_scheduled = entity->last_scheduled;
>>> +	entity->last_scheduled = dma_fence_get(&sched_job->s_fence->finished);
>>>    
>>> -	/*
>>> -	 * If the queue is empty we allow drm_sched_entity_select_rq() to
>>> -	 * locklessly access ->last_scheduled. This only works if we set the
>>> -	 * pointer before we dequeue and if we a write barrier here.
>>> +	/* A recent rework required taking the spinlock above. Since spsc_queue
>>> +	 * is scheduled for removal as per the DRM-TODO-list, we access it here
>>> +	 * locked already to prepare for that cleanup.
>>> +	 *
>>> +	 * TODO: Fully replace spsc_queue with a locked (h)list.
>>>    	 */
>>> -	smp_wmb();
>>> -
>>>    	spsc_queue_pop(&entity->job_queue);
>>> +	spin_unlock(&entity->lock);
>>>    
>>> +	dma_fence_put(prev_last_scheduled);
>>>    	drm_sched_rq_pop_entity(entity);
>>
>> Notice the entity->lock ends up cycled twice for no good reason (second
> 
> Getting rid of hard to understand barriers + RCU *is* a _very_ good
> reason.

I will re-phrase - there is no reason to cycle the lock twice while 
proposing the removal of barriers and RCU. They are completely orthogonal.

>> is in drm_sched_rq_pop_entity()). So I would suggest you somehow reduce
>> that to once. Probably just pull out entity->lock out of the
>> drm_sched_rq_pop_entity() to drm_sched_entity_pop_job()?
> 
> Can you see danger in sense of a significant performance regression
> because of that?

It's just unsightly. Last year or so I removed the very same lazy 
pattern from the scheduler so lets not re-add it.

d42a254633c7 ("drm/sched: Optimise drm_sched_entity_push_job")
36caa026b28a ("drm/sched: Avoid double re-lock on the job free path")

>> I guess if you do that then the "while at it" part of the commit message
>> can be "upgraded" to "spsc_queue_pop() being under the lock as a
>> consequence of the rework" and then no need to split it.
> 
> I agree with you that it should be *downgraded* instead.

Dropping that part of change? Works for me.

>>>    
>>>    	/* Jobs and entities might have different lifecycles. Since we're
>>> @@ -561,21 +571,15 @@ void drm_sched_entity_select_rq(struct drm_sched_entity *entity)
>>>    	if (spsc_queue_count(&entity->job_queue))
>>>    		return;
>>>    
>>> -	/*
>>> -	 * Only when the queue is empty are we guaranteed that
>>> -	 * drm_sched_run_job_work() cannot change entity->last_scheduled. To
>>> -	 * enforce ordering we need a read barrier here. See
>>> -	 * drm_sched_entity_pop_job() for the other side.
>>> -	 */
>>> -	smp_rmb();
>>> -
>>> -	fence = rcu_dereference_check(entity->last_scheduled, true);
>>> +	spin_lock(&entity->lock);
>>> +	fence = entity->last_scheduled;
>>>    
>>>    	/* stay on the same engine if the previous job hasn't finished */
>>> -	if (fence && !dma_fence_is_signaled(fence))
>>> +	if (fence && !dma_fence_is_signaled(fence)) {
>>> +		spin_unlock(&entity->lock);
>>
>> Have you tried with lockdep to see if there are any hidden lock
>> inversions with this?
> 
> As far as I could grep really no one touches the entity lock (which is
> not surprising, since the entire drm_sched design resolves around the
> central philosophy: "NEVER use a spinlock unless you absolutely have
> to". When you look at the old code and documentation, you see that
> locks were really only ever used to protect lists.
> 
> Anyways. This is the scheduler's fence. It can never implement any
> callback to someone who might interfere with the entity lock, can it?

Right, just my trauma from past encounters with opportunistic signalling.

Regards,

Tvrtko

>> I also wonder if we could demote this to a flag check only and remove
>> any doubt. I don't think opportunistic signalling matter in this code path.
> 
> With the new fence API, where we can bypass the ops, that would
> probably be the more canonical code. But that's then indeed something
> for a separate patch.
> 
> 
> P.

