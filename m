Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 668F4C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 08:46:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBD4C10E30E;
	Mon,  6 Jul 2026 08:46:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="M+Gs7SKK";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC5E610E30E
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 08:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jknh75JH1P0CBTsivHhJoCFnbVm0gTLli2CnNEauNK8=; b=M+Gs7SKKHMqEtDOlgnQEd1iVQU
 HQvocK2D4tkQtvgMbMxs0c54ABt4LqrYEXu1b3DKAY98TgBFzwQVrVIzeR19iwhOVYDKSRDDMERzL
 ONlPhxXwIPOUhA10uBYE7fv2aAF/tXFCAgnene87JfjTVa3EupzKqZnywxNHjyf75mjvQAvma6hkb
 H+t0FRPFebqyf+9Xi+enJLXYf3WtcnxW8OYUIzlaVuUvUWc0d1WQjVKUXoM8I92u5ZjDtnXmtlj/K
 LK9O2QkHq3Mv9kAbGiuu3AxK9ai9KrcN8BphTHm4yjaDWAYqCEz1t4EzsE8sKvA06vjJZo/vpB5Gs
 IyeMqucQ==;
Received: from [90.240.106.137] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wgexk-009e5C-3f; Mon, 06 Jul 2026 10:46:00 +0200
Message-ID: <ce33edbb-11dd-4722-bb87-d16155f35a75@igalia.com>
Date: Mon, 6 Jul 2026 09:45:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] drm/sched: Protect entity->last_scheduled with
 spinlock
To: phasta@kernel.org, Tvrtko Ursulin <tursulin@ursulin.net>,
 Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>, Marco Pagani
 <marco.pagani@linux.dev>, Boris Brezillon <boris.brezillon@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
References: <20260701085920.3253248-2-phasta@kernel.org>
 <20260701085920.3253248-3-phasta@kernel.org>
 <a4091099-1931-4ca2-a81a-9c3321b123a8@ursulin.net>
 <51fbde808bd059510d667d130afae179626303be.camel@mailbox.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <51fbde808bd059510d667d130afae179626303be.camel@mailbox.org>
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


On 03/07/2026 15:47, Philipp Stanner wrote:
> On Fri, 2026-07-03 at 12:27 +0100, Tvrtko Ursulin wrote:
>>
>> On 01/07/2026 09:59, Philipp Stanner wrote:
>>> The entity->last_scheduled field has always been set and read with
>>> special RCU functions in addition to memory barriers.
>>>
>>> This was added in
>>>
>>> commit 70102d77ff22 ("drm/scheduler: add drm_sched_entity_error and use rcu for last_scheduled")
>>>
>>> however, no proper justification for that mechanism was provided. There
>>> seems to be no obvious reason, since the entity lock is available and
>>> taken at all places that evaluate the last_scheduled field. The only
>>> exception is drm_sched_entity_error(), which is not performance critical
>>> in any way.
>>>
>>> Improve robustness, readability and maintainability by replacing RCU and
>>> barriers with the lock.
>>
>> First thing, and regardless of other strands of discussion, I think it
>> should be squashed with 3/5 instead of that one undoing the introduction
>> of lock-unlock-lock-unlock.
> 
> I agree that there should not be a do-undo pattern, but I don't want to
> squash that, it's quite a distinctive action. One patch adds locks, the
> other moves them.

Hm, maybe it is a semantic discussion whether there is any real adding 
of the locks, when the effective end result is just widening of it's 
scope by pulling it out of the helper to caller. But okay, prep patch to 
move the lock out sounds like it could look acceptable.

> But what I can do is move that patch before №1 here so that it becomes
> understandable as a preparational commit.
> 
>>
>> For what the main topic is concerned, I really like the removal of all
>> the rcu_dereference_check(, true) lines and the memory barriers.
>>
>> But I also think the commit message should explain better what code
>> paths are now taking an extra lock - under which circumstances is the
>> lock now taken for all scheduler users, and which amdgpu paths use
>> drm_sched_entity_error() a lot so could be affected. I doubt it creates
>> a measurable performance impact but it needs to be explained.
> 
> I think it can detail which functions will now be locked; but
> mentioning the users would be overkill and is uncommon for API reworks.

Here I disagree quite strongly. Given the patch is making strong claims 
that the lockless access was added for no obvious reason, and that we 
have now established the lockless helper is in fact used on the 
submission paths, it is really required that those strong claims are 
backed by a concrete analysis instead of just saying "not performance 
critical in any way".

>> I am also happy to give it a spin on the Steam Deck to see if I can
>> observe anything.
> 
> Could be interesting.

Okay I'll try to do it in reasonable time. You can either respin or wait 
for it, I don't mind either way.

>>> Signed-off-by: Philipp Stanner <phasta@kernel.org>
>>> ---
>>>    drivers/gpu/drm/scheduler/sched_entity.c | 50 ++++++++++--------------
>>>    include/drm/gpu_scheduler.h              |  9 ++---
>>>    2 files changed, 25 insertions(+), 34 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
>>> index c51101ec70c1..91aec20611ad 100644
>>> --- a/drivers/gpu/drm/scheduler/sched_entity.c
>>> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
>>> @@ -135,7 +135,6 @@ int drm_sched_entity_init(struct drm_sched_entity *entity,
>>>    	entity->num_sched_list = num_sched_list;
>>>    	entity->sched_list = num_sched_list > 1 ? sched_list : NULL;
>>>    	entity->rq = &sched_list[0]->rq;
>>> -	RCU_INIT_POINTER(entity->last_scheduled, NULL);
>>>    	RB_CLEAR_NODE(&entity->rb_tree_node);
>>>    	init_completion(&entity->entity_idle);
>>>    
>>> @@ -201,10 +200,10 @@ int drm_sched_entity_error(struct drm_sched_entity *entity)
>>>    	struct dma_fence *fence;
>>>    	int r;
>>>    
>>> -	rcu_read_lock();
>>> -	fence = rcu_dereference(entity->last_scheduled);
>>> +	spin_lock(&entity->lock);
>>> +	fence = entity->last_scheduled;
>>>    	r = fence ? fence->error : 0;
>>> -	rcu_read_unlock();
>>> +	spin_unlock(&entity->lock);
>>>    
>>>    	return r;
>>>    }
>>> @@ -287,9 +286,10 @@ void drm_sched_entity_kill(struct drm_sched_entity *entity)
>>>    	/* Make sure this entity is not used by the scheduler at the moment */
>>>    	wait_for_completion(&entity->entity_idle);
>>>    
>>> -	/* The entity is guaranteed to not be used by the scheduler */
>>> -	prev = rcu_dereference_check(entity->last_scheduled, true);
>>> +	spin_lock(&entity->lock);
>>> +	prev = entity->last_scheduled;
>>>    	dma_fence_get(prev);
>>> +	spin_unlock(&entity->lock);
>>>    	while ((job = drm_sched_entity_queue_pop(entity))) {
>>>    		struct drm_sched_fence *s_fence = job->s_fence;
>>>    
>>> @@ -381,8 +381,7 @@ void drm_sched_entity_fini(struct drm_sched_entity *entity)
>>>    		entity->dependency = NULL;
>>>    	}
>>>    
>>> -	dma_fence_put(rcu_dereference_check(entity->last_scheduled, true));
>>> -	RCU_INIT_POINTER(entity->last_scheduled, NULL);
>>> +	dma_fence_put(entity->last_scheduled);
>>>    	drm_sched_entity_stats_put(entity->stats);
>>>    }
>>>    EXPORT_SYMBOL(drm_sched_entity_fini);
>>> @@ -507,6 +506,10 @@ drm_sched_job_dependency(struct drm_sched_job *job,
>>>    
>>>    struct drm_sched_job *drm_sched_entity_pop_job(struct drm_sched_entity *entity)
>>>    {
>>> +	/* Helper to avoid dropping the reference while the entity lock is held,
>>> +	 * just to have some more robustness.
>>> +	 */
>>
>> I don't get this comment. Neither the placement or the content.
> 
> It explains the purpose of the variable 'prev_last_scheduled', which
> exists so that a reference does not drop under lock protection.

Ah a helper _variable_, right, I was thrown off by the comment just 
below the function and did not even spot you added a new local.

Regards,

Tvrtko

> 
> 
> P.

