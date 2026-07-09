Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02CA2C44501
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 14:33:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A0CD10E608;
	Thu,  9 Jul 2026 14:33:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="FjjLL5Ec";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F35A210E608
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 14:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3KBUt6eVJ/1GD2XEUireFvhOgN/1+EzOI/JpLDJQpFY=; b=FjjLL5Ec78bBL6qobVKTVJieiJ
 xeEX/b86ne8pPa7YA6NYenV/9OeCO928uqtwEd9yiALY2e9xld5PXWWXanpatAhBrC1jLRwhxGq1B
 Cw7QGArBhGaCnT76uHdC5u31Pv6nG0qmAiQpB31ojPwk7ob9Krr9v5iDd1UmGNUKfNvCYwVOCAUGe
 Lildt/yHtZVf6ITxg3iPzLFLpPhgWabd4R7DV+JOzZhK8oRAhQVoguezQjsUgkiuVXLargXJdhSY3
 Ja0xq2ELSH99FaMGXjgW3XDSnIqofHmYKhrJDwPdaPD5vKtj2z2Q5KsAo5CVrCqmIl06tt/k4zgwK
 SJc5qQdg==;
Received: from [90.240.106.137] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1whpoE-00CGii-59; Thu, 09 Jul 2026 16:33:02 +0200
Message-ID: <ffc05a67-66ff-4e0a-98f3-a9e4e87af6b0@igalia.com>
Date: Thu, 9 Jul 2026 15:33:01 +0100
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
 <bd262d12-65d0-4c59-a314-b42b540acd99@igalia.com>
 <20260709084520.16d32cb7@fedora-2.home>
 <8e079d0b-427f-42cd-8013-7b8af005cd6d@igalia.com>
 <20260709141957.7f7664d0@fedora-2.home>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260709141957.7f7664d0@fedora-2.home>
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


On 09/07/2026 13:19, Boris Brezillon wrote:
> On Thu, 9 Jul 2026 11:56:48 +0100
> Tvrtko Ursulin <tvrtko.ursulin@igalia.com> wrote:
> 
>> On 09/07/2026 07:45, Boris Brezillon wrote:
>>> On Wed, 8 Jul 2026 17:47:36 +0100
>>> Tvrtko Ursulin <tvrtko.ursulin@igalia.com> wrote:
>>>    
>>>> On 06/07/2026 15:18, Boris Brezillon wrote:
>>>>> On Mon, 6 Jul 2026 13:03:33 +0100
>>>>> Tvrtko Ursulin <tvrtko.ursulin@igalia.com> wrote:
>>>>>       
>>>>>> On 02/07/2026 16:31, Boris Brezillon wrote:
>>>>>>> On Thu,  2 Jul 2026 15:37:39 +0100
>>>>>>> Tvrtko Ursulin <tvrtko.ursulin@igalia.com> wrote:
>>>>>>>          
>>>>>>>> Currently an unordered workqueue is used for the DRM scheduler which means
>>>>>>>> its concurrency is externally managed, and given there is one scheduler
>>>>>>>> instance per userspace queue, that means workqueue management logic is
>>>>>>>> within its rights to spawn many kernel threads to submit their respective
>>>>>>>> jobs.
>>>>>>>>
>>>>>>>> Problem there is that all run job callbacks are serialized on the device
>>>>>>>> global mutex,
>>>>>>>
>>>>>>> I think we should address that instead, and either shorten the scope of
>>>>>>> the locked section, or make it so we don't make it a contention point
>>>>>>> for concurrent job submission from different contexts (with a rwsem
>>>>>>> instead of a lock, for instance).
>>>>>>>          
>>>>>>>> making the potential thread storm just causing lock
>>>>>>>> contention.
>>>>>>>>
>>>>>>>> If we add a separate ordered workqueue for the DRM scheduler integration
>>>>>>>> we can avoid this problem, since the ordered property directly expresses
>>>>>>>> the nature of the submission backend implementation.
>>>>>>>
>>>>>>> Yep, except that's not how it was meant to work. The goal was to allow
>>>>>>> contexts to submit their jobs concurrently to the FW. The only reason we
>>>>>>> take the lock is to:
>>>>>>>
>>>>>>> 1. make sure the context is still allowed to take jobs
>>>>>>> 2. kick the group scheduler if the context is not resident
>>>>>>>
>>>>>>> For #1, I believe we can come up with either a lockless solution, or a
>>>>>>> solution where the lock protecting the state belongs to the group
>>>>>>> instead of being externally protected by the device-wide scheduler lock.
>>>>>>>
>>>>>>> For #2, the rwsem approach, and narrowing down the locked section to
>>>>>>> just this part of the code should do the trick.
>>>>>>
>>>>>> Out of curiosity how much CPU side parallelism you think is required to
>>>>>> keep these GPUs fed? Both today (with the greater lock contention) and
>>>>>> in the future (with the reduced contention) I guess would be interesting
>>>>>> data points.
>>>>>
>>>>> The maximum is known: it's the amount of FW CSG slot we have available.
>>>>> I think the theoretical limit is 16, but IIRC, we never had more than 8
>>>>> exposed by the FW.
>>>>
>>>> Yeah but is it _really_ required to have 8 CPU threads feed these slots?
>>>
>>> 8 is indeed the number of SW slots, but there are multiple HW queues
>>> under the hood (and multiple cores to dispatch jobs to), making it so
>>> multiple GPU context can effectively be scheduled in parallel. This
>>> number is lower than the number of FW slots though (I need to check if
>>> it's exposed through some RO regs).
>>
>> Got it, thanks!
>>
>> So it is desirable to keep the FW slots filled with up to N jobs of each
>> queue type, where N is the HW parallelism of that queue type.
> 
> Jobs are one level below that. Each FW slot is attached a group
> (that's Arm's naming), which is basically backing a VkQueue. The group
> contains 1 to 8 queues (1 for fragment processing, 1 for geometry
> processing, 1 for compute, 1 for transfers, ...) which can run
> concurrently, and each of these queues has a ring buffer to push jobs
> to. The ring buffer size is customizable and determines the maximum
> number of jobs you can have queued before you have to wait for a ringbuf
> slot to become available again. I know I use the term "slot" a lot and
> it gets confusing, but FW slot (a way to make a group/VkQueue resident)
> must not be confused with a ringbuf slot (a slot where you store you job
> targeting a specific queue under this group). You can fill up your
> ringbuf slots while the group is not resident (when that happens, we
> kick the second-stage scheduler to make sure the group is going to
> become resident at some point). And equally, you can have a group that's
> resident, but has all its queue ringbufs empty (in that case, it should
> sooner or later be evicted and replaced by another group that wants to
> execute things).

Thank you for this explanation - I am marking it with my "reference 
material" tag.

> So, back to your initial statement, it is desirable to keep the queues
> under a resident group (one that's attached to a FW slot) filled with
> jobs to maximize utilization. And ideally, we want the group with the
> highest priority to be refilled faster than the other resident groups.
> 
>>
>> At least assuming that the MCU is not significantly slower than the main
>> CPU in dequeing the FW slots into HW queues.
> 
> So, FW is scheduling queues under the resident groups, but the ring
> buffers are consumed by a HW component (CSHWIF in Arm's naming), which I
> expect to run faster than the MCU itself, even though, the MCU being
> dedicated to just that scheduling task with very little to no OS
> overhead, I'd expect the turnaround time to be quite fast compared to
> the APU, even if the MCU is clocked at a way lower freq.

Makes sense.

>> What would that number be in practice? I am going back to what Tejun
>> mentioned, that if we can provide some bound number of how many RT
>> workers we may need, then he may be able to provide the RT facility.
> 
> As I say below, I think we can start with just a single-worker
> wq per priority, and take it from there if we see the resident queues
> are not filled fast enough compared to the non-resident ones. What's
> really important for us is for jobs targeting high-prio queues to hit
> their ringbuf before those targeting lower prio queues.
> 
>>
>>>> GPU will still take one at a time and preemption is not that fast, no?
>>>
>>> Preemption on the FW side is pretty simple: each slot gets a unique
>>> prio, and lower prio slots only get HW queues and GPU resources if
>>> higher prio ones are idle and accept to give up their resources for a
>>> bit. We then have a 10ms tick in panthor to rotate the FW slot
>>> priorities. So yes, preemption is not very granular, but that's not
>>> really the problem I'm worried about. What I'm worried about is having
>>> just one thread for everything, with the first-queued/first-served
>>> model that the kthread_worker infrastructure provides. If we're talking
>>> about one thread per-priority level, that's already better, and then I
>>> agree that the contention on GPU contexts with the same priority is less
>>> of an issue, especially since the run_job work has to run before being
>>> rescheduled, which gives you this natural FIFO behavior, thus leaving
>>> other contexts a chance to queue their run_job in the meantime.
>>>
>>> But this WQ_UNBOUND -> WQ_SINGLE_THREAD transition, where the wq is
>>> shared among the entire device is not that. It's actually serializing
>>> work submission for all GPU contexts regardless of their priority.
>>>
>>> TLDR; I'd be happy if we start with just one kthread per-prio + the
>>> narrowing of the locked section in the run_job() implementation, so
>>> that context submission actually happens concurrently, and low prio
>>> context don't starve high-prio/RT ones in the submission path.
>>
>> I don't think this is actually priority starvation but plain FIFO
>> starvation.
> 
> The FIFO is per group-queue, not global to the device though (we have
> one sched_entity and one scheduler per group-queue, not one for the
> entire system). The starvation, if any, would come from the
> serialization in the run_job() implementation, as we try to acquire the
> device-wide panthor_scheduler::lock. And that's not by design, but
> rather a flaw in the original implementation.
> 
>> It can happen even today with WQ_UNBOUND, which does nothing
>> about breaking the FIFO order based on priorities, just that some
>> parallelism alleviates it.
> 
> Well, it's indeed not providing a guarantee that things will be
> pushed in the proper prio order, but the fact threads can be
> spawned makes it less likely for low-prio queues to block high-prio
> ones, at least.
> 
>>
>> But in principle I am fine with going with N workers. It's just a matter
>> of what is N derived from and how big it is. It could be even be passed
>> to alloc_workqueue in the today's code base but I accept there is not
>> much value to that since I don't think there are SoC's with a Mali GPU
>> and server level number of CPU cores.
> 
> I think we can start with one ordered-wq per prio level. So basically
> what you intended to do in this patch, but instead of having a single
> ordered-wq, we have four of them (one per prio). It doesn't address the
> fact run_job() on non-resident groups might hit their ringbuf before
> resident ones, but that's probably good enough as a first step, and as
> you pointed out, the current locking forces this serialization with no
> more guarantee regarding who's going to be served first anyway, so it
> can't be worse than it already is.

Lets for a moment assume the kthread_worker idea will not fly due to xe, 
or any other reason really. Also since the option for RT workqueues is 
unexpectedly on the table. In that case, and assuming RT workqueues will 
happen, could a feasible plan for panthor be to create three workqueues:

  1. One unbound with max_active = 2 for low and medium group priority.
  2. Another unbound + WQ_HIGHPRI, also with max_active = 2 for high.
  3. And one unbound + WQ_REALTIME, again max_active = 2 for realtime.

For high and realtime max_active either 2 or 1 on dual core, if there 
are such SoCs. Two threads ensure same priority clients are able to keep 
the GPU fed.

One issue is that you mentioned you would like dynamic priority changes 
and with this it may be tricky. But ignoring that for the moment, and 
the discussion on how to handle other panthor workers which take part in 
the execution flow post submit, this should pretty much address the 
submit latency from userspace to ->run_job(). What do you think, is it 
worth entertaining this alternative?

Regards,

Tvrtko

> Note that this is probably not enough to make a difference, we also
> need panthor-specific work items to go to the per-prio wqs based on
> where the event comes from (we have per-FW-slot interrupts), and the
> priority of the group attached to the FW slot. Or we just consider any
> event from the FW as high-prio regardless of the slot its pointing to,
> dunno.

