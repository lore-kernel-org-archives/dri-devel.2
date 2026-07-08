Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE41C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 16:47:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7D0610E631;
	Wed,  8 Jul 2026 16:47:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="N7XKXI86";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DD0710E631
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 16:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=D0h2n4D+R8Mj0sCHWAIvr6Fzz49F+rXp8A6dywFm770=; b=N7XKXI86G12Cx9pdlqs3FQd7JW
 gQlBGVPcuHJg+HxDWZQ4qVCvDJ/093c00nft732kMzspqpCHQfseCGgTNPn6tGilymswJ2nJXw6H/
 VBMSoTCg8q0gu421cNyCYLKl1z5nYOW8a4H91F5WPG+kaa/lGnD10CRXAaxPHb78+zqUEhN/BoPvX
 vLIXEqx8PgponpQE+xiji2m3eIMgynhIJMfIYmNYh9OlZkMiV6o3/QhuGmKeMlKAAcA2x1iP7cBCt
 Sx5KKHSwc0bEgSOgB7EY4WjMnnz86UKqX4nm0cUAzfPKQvSCkI7nM58EIjscxxreYDOfb4pTShbbO
 hXVmwZ0Q==;
Received: from [90.240.106.137] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1whVQv-00Bp2W-D7; Wed, 08 Jul 2026 18:47:37 +0200
Message-ID: <bd262d12-65d0-4c59-a314-b42b540acd99@igalia.com>
Date: Wed, 8 Jul 2026 17:47:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/8] drm/panthor: Use separate workqueue for DRM scheduler
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: dri-devel@lists.freedesktop.org, Steven Price <steven.price@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, Chia-I Wu <olvaffe@gmail.com>,
 Danilo Krummrich <dakr@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>, kernel-dev@igalia.com
References: <20260702143745.79293-1-tvrtko.ursulin@igalia.com>
 <20260702143745.79293-3-tvrtko.ursulin@igalia.com>
 <20260702173127.3103af30@fedora-2.home>
 <8aa9ffad-ece3-428b-b307-1d5f4136db73@igalia.com>
 <20260706161812.07ee7500@fedora-2.home>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260706161812.07ee7500@fedora-2.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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


On 06/07/2026 15:18, Boris Brezillon wrote:
> On Mon, 6 Jul 2026 13:03:33 +0100
> Tvrtko Ursulin <tvrtko.ursulin@igalia.com> wrote:
> 
>> On 02/07/2026 16:31, Boris Brezillon wrote:
>>> On Thu,  2 Jul 2026 15:37:39 +0100
>>> Tvrtko Ursulin <tvrtko.ursulin@igalia.com> wrote:
>>>    
>>>> Currently an unordered workqueue is used for the DRM scheduler which means
>>>> its concurrency is externally managed, and given there is one scheduler
>>>> instance per userspace queue, that means workqueue management logic is
>>>> within its rights to spawn many kernel threads to submit their respective
>>>> jobs.
>>>>
>>>> Problem there is that all run job callbacks are serialized on the device
>>>> global mutex,
>>>
>>> I think we should address that instead, and either shorten the scope of
>>> the locked section, or make it so we don't make it a contention point
>>> for concurrent job submission from different contexts (with a rwsem
>>> instead of a lock, for instance).
>>>    
>>>> making the potential thread storm just causing lock
>>>> contention.
>>>>
>>>> If we add a separate ordered workqueue for the DRM scheduler integration
>>>> we can avoid this problem, since the ordered property directly expresses
>>>> the nature of the submission backend implementation.
>>>
>>> Yep, except that's not how it was meant to work. The goal was to allow
>>> contexts to submit their jobs concurrently to the FW. The only reason we
>>> take the lock is to:
>>>
>>> 1. make sure the context is still allowed to take jobs
>>> 2. kick the group scheduler if the context is not resident
>>>
>>> For #1, I believe we can come up with either a lockless solution, or a
>>> solution where the lock protecting the state belongs to the group
>>> instead of being externally protected by the device-wide scheduler lock.
>>>
>>> For #2, the rwsem approach, and narrowing down the locked section to
>>> just this part of the code should do the trick.
>>
>> Out of curiosity how much CPU side parallelism you think is required to
>> keep these GPUs fed? Both today (with the greater lock contention) and
>> in the future (with the reduced contention) I guess would be interesting
>> data points.
> 
> The maximum is known: it's the amount of FW CSG slot we have available.
> I think the theoretical limit is 16, but IIRC, we never had more than 8
> exposed by the FW.

Yeah but is it _really_ required to have 8 CPU threads feed these slots? 
GPU will still take one at a time and preemption is not that fast, no?

Back in the day, on Intel hardware, one hw generation jumped from 2 to 8 
submit ports. Funny thing is we found no benchmark where 8 was a win. 
AMD today defaults to 2 as well, Steam Deck bumps to 4 because it was 
measured to bring some tiny gain some time ago. And in both these cases 
it is different in that there is one CPU thread feeding those ports. 
It's just pipelining so GPU can move to next context without a 
kernel/CPU round-trip. I would be surprised if Mali really needs 8 or 
more slots to keep the GPU busy. And if it doesn't then spawning more 
CPU threads is not optimal even with the improved locking.

> Also, adjusting the priority of the thread used for job submission is
> not enough (at least not for panthor), because the processing of FW
> events is still going through this single-prio workqueue (signaling is
> about to be moved to the threaded IRQ handler, but we still defer the
> processing of some events to work items, and those can block progress
> on a queue until they are processed). If we're processing events coming
> from low prio queues before those coming from high prio queues, we're
> back to the same problem. Not to mention that now, high prio submission
> threads can completely starve FW event processing.
> 
> This is just my 2-cts, but I think we need both side of the equation
> addressed at the same time, which is why I believe we should convert
> panthor_scheduler::wq to the same kthread_worker mechanism.

I agree this needs to be handled together. And I am aware you are 
working on the irq processing side of things. Hence this is just an RFC 
to show the weak point on the submit side.

I haven't looked into the tick based software state machine in panthor 
yet TBH so I cannot comment on the possibilities of starvation and such. 
I will have a look.

>>>> And considering the other user of this workqueue, the free job callback,
>>>> which is not globally serialized in this manner so could be thought to
>>>> potentially regress with this change, it should not be the case since
>>>> commit
>>>> a58f317c1ca0 ("drm/sched: Free all finished jobs at once")
>>>> made the DRM scheduler handle the cleanup of finished jobs more promptly.
>>>
>>> I don't know if this change is a hard dep for what's coming next, but
>>> if it's not, I'd drop it. If it is, and the new kthread_work solution
>>> relies on this serialization, I guess I need to read more to understand
>>> why.
>>
>> You mean this patch, "drm/panthor: Use separate workqueue for DRM
>> scheduler"?
>>
>> It is not strictly required. I could for example use the concurrent
>> flavour of the drm_sched_worker I add later in the series. That would
>> align with WQ_UNBOUND which is currently used, but then there is the
>> question of how much parallelism is required and the fact dumb worker
>> pool implementation from this RFC makes no attempt to spawn/retire
>> threads on demand. It just picks four out of thin air kind of. Priority
>> inheritance would still work but if picking a fix number of threads
>> based on some criteria wouldn't be feasible I would need to work on a
>> smarter worker pool implementation.
> 
> If that's easier, we can let the driver define the max number of
> threads to spawn.

Yeah I can do that if we conclude that is acceptable. Hence I am looking 
for inputs from panthor and xe as to how many threads these drivers 
really really need. I need to look at the other drivers too, plus, from 
Tejun's feedback it sounds the option of RT workqueues might be an 
option if we can agree on a bounded number of them.

>> I could drop it, although the question would be when do you expect
>> locking rework could realistically happen and,
> 
> If that's a blocker for this series, I can try to prioritize this
> change.

I think for now lets see how the discussion develops and decide later.

>> if not quick, what is the
>> advantage of keeping the false parallelism.
> 
> The advantage is that we don't start relying on the artificial
> serialization provided by single-threaded workqueues, because the more
> we rely on that, the harder it gets to go back to a solution where GPU
> contexts can submit jobs concurrently.

:) Fair enough. Lets see how the discussion develops.

Regards,

Tvrtko

