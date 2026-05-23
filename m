Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C13EDCD5BAC
	for <dri-devel@archiver.kernel.org>; Sat, 23 May 2026 13:13:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF76310E039;
	Sat, 23 May 2026 13:13:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="FqMzrMAy";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 486FF10E039
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 13:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sO+vZIyHn6/V6al59N6x9zrRKwjy9wUL38DEFYbOvUo=; b=FqMzrMAywVXcvGeWon03sgwZyE
 he51dyR8pkDfiiBnvzPbFuiRWkNqJa2WRwJYQj+piXtkrPJZ5EA/dG5r7PcFlU6HeKtseRWz05lN6
 1Wdke/gOl3uK5nVdQ4i/BMzj1q2PPtPAmK3G6X0prExdtJJvkGAYQZ259dTaqtuTvqh12eKCUGQxC
 82DROQxMm7LWNmwx9nRxHecIrdWsrIXBx4D/csRMMKva87BmrYmcZQKJKp2g9R7fjrwLTW13wPG/+
 OFxHMd9lpVidjp3pl22zHW/J5R7MdBwmTxqeymLDum061VhwLk1huvuQHerD6m6Za2/3xAeXzrB2q
 jzS4TfWQ==;
Received: from [90.240.106.137] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wQm9t-005ppb-Hp; Sat, 23 May 2026 15:12:53 +0200
Message-ID: <ee686e99-6e80-4f0b-97db-8a3419e1314d@igalia.com>
Date: Sat, 23 May 2026 14:12:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/2] drm/panthor: Use separate workqueue for DRM scheduler
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
 Liviu Dudau <liviu.dudau@arm.com>, Steven Price <steven.price@arm.com>
References: <20260522113817.11745-1-tvrtko.ursulin@igalia.com>
 <20260522113817.11745-3-tvrtko.ursulin@igalia.com>
 <20260522174831.34983d27@fedora>
 <7839ed28-77a8-42ff-8c9b-ac160e0f3a8f@igalia.com>
 <20260523080629.1ce22098@fedora>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260523080629.1ce22098@fedora>
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


On 23/05/2026 07:06, Boris Brezillon wrote:
> On Fri, 22 May 2026 17:25:18 +0100
> Tvrtko Ursulin <tvrtko.ursulin@igalia.com> wrote:
> 
>> On 22/05/2026 17:08, Boris Brezillon wrote:
>>> On Fri, 22 May 2026 12:38:17 +0100
>>> Tvrtko Ursulin <tvrtko.ursulin@igalia.com> wrote:
>>>    
>>>> Currently an unordered workqueue is used for the DRM scheduler which means
>>>> its concurrency is externally managed, and given there is one scheduler
>>>> instance per userspace queue, that means workqueue management logic is
>>>> within its rights to spawn many kernel threads to submit their respective
>>>> jobs.
>>>>
>>>> Problem there is that all run job callbacks are serialized on the device
>>>> global mutex, making the potential thread storm just causing lock
>>>> contention.
>>>
>>> Yeah, so initially we were not supposed to take the lock over the whole
>>> run_job() function. We should normally be able to queue things to the
>>> ring buffer, and only briefly take the lock to check if the context is
>>> still resident and kick the group scheduler if it's not. I agree that
>>> in practice it turned in a huge synchronization point. I guess we should
>>> consider turning that mutex into a rwsem that's taken in write mode in
>>> the tick path, and read-mode elsewhere.
>>
>> There is some software state modified too, so I am not sure how easy or
>> hard it would be to make run job only hold the read lock?
> 
> Yeah, it's probably not as easy as it sounds.
> 
>>
>>>> If we add a separate ordered workqueue for the DRM scheduler integration
>>>> we can avoid this problem, since the ordered property directly expresses
>>>> the nature of the submission backend implementation.
>>>
>>> I don't see alloc_ordered_workqueue() being used for the sched_wq
>>> workqueue, is that intended (according to this comment, you seem to
>>> want an ordered wq).
>>
>> Yeah, it seems I mistyped the wq allocation below.
>>
>>>> And considering the other user of this workqueue, the free job callback,
>>>> which is not globally serialized in this manner so could be thought to
>>>> potentially regress with this change, it should not be the case since
>>>> commit
>>>> a58f317c1ca0 ("drm/sched: Free all finished jobs at once")
>>>> made the DRM scheduler handle the cleanup of finished jobs more promptly.
>>>>
>>>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>>> Cc: Boris Brezillon <boris.brezillon@collabora.com>
>>>> Cc: Liviu Dudau <liviu.dudau@arm.com>
>>>> Cc: Steven Price <steven.price@arm.com>
>>>> ---
>>>>    drivers/gpu/drm/panthor/panthor_sched.c | 27 ++++++++++++++++---------
>>>>    1 file changed, 17 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
>>>> index 2bee1c92fb9e..cc6b3e2b015a 100644
>>>> --- a/drivers/gpu/drm/panthor/panthor_sched.c
>>>> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
>>>> @@ -147,13 +147,11 @@ struct panthor_scheduler {
>>>>    	struct panthor_device *ptdev;
>>>>    
>>>>    	/**
>>>> -	 * @wq: Workqueue used by our internal scheduler logic and
>>>> -	 * drm_gpu_scheduler.
>>>> +	 * @wq: Workqueue used by our internal scheduler logic.
>>>>    	 *
>>>>    	 * Used for the scheduler tick, group update or other kind of FW
>>>>    	 * event processing that can't be handled in the threaded interrupt
>>>> -	 * path. Also passed to the drm_gpu_scheduler instances embedded
>>>> -	 * in panthor_queue.
>>>> +	 * path.
>>>>    	 */
>>>>    	struct workqueue_struct *wq;
>>>>    
>>>> @@ -166,6 +164,14 @@ struct panthor_scheduler {
>>>>    	 */
>>>>    	struct workqueue_struct *heap_alloc_wq;
>>>>    
>>>> +	/**
>>>> +	 * @sched_wq: Workqueue used for the DRM scheduler.
>>>> +	 *
>>>> +	 * Workqueue used for drm_gpu_scheduler instances embedded in
>>>> +	 * panthor_queue.
>>>> +	 */
>>>> +	struct workqueue_struct *sched_wq;
>>>> +
>>>>    	/** @tick_work: Work executed on a scheduling tick. */
>>>>    	struct delayed_work tick_work;
>>>>    
>>>> @@ -3488,7 +3494,7 @@ group_create_queue(struct panthor_group *group,
>>>>    {
>>>>    	struct drm_sched_init_args sched_args = {
>>>>    		.ops = &panthor_queue_sched_ops,
>>>> -		.submit_wq = group->ptdev->scheduler->wq,
>>>> +		.submit_wq = group->ptdev->scheduler->sched_wq,
>>>>    		/*
>>>>    		 * The credit limit argument tells us the total number of
>>>>    		 * instructions across all CS slots in the ringbuffer, with
>>>> @@ -4078,6 +4084,9 @@ static void panthor_sched_fini(struct drm_device *ddev, void *res)
>>>>    	if (sched->heap_alloc_wq)
>>>>    		destroy_workqueue(sched->heap_alloc_wq);
>>>>    
>>>> +	if (sched->sched_wq)
>>>> +		destroy_workqueue(sched->sched_wq);
>>>> +
>>>>    	for (prio = PANTHOR_CSG_PRIORITY_COUNT - 1; prio >= 0; prio--) {
>>>>    		drm_WARN_ON(ddev, !list_empty(&sched->groups.runnable[prio]));
>>>>    		drm_WARN_ON(ddev, !list_empty(&sched->groups.idle[prio]));
>>>> @@ -4167,13 +4176,11 @@ int panthor_sched_init(struct panthor_device *ptdev)
>>>>    	 * FW is smart enough to fall back on other methods if the kernel can't
>>>>    	 * allocate memory, and fail the tiling job if none of these
>>>>    	 * countermeasures worked.
>>>> -	 *
>>>> -	 * Set WQ_MEM_RECLAIM on sched->wq to unblock the situation when the
>>>> -	 * system is running out of memory.
>>>>    	 */
>>>>    	sched->heap_alloc_wq = alloc_workqueue("panthor-heap-alloc", WQ_UNBOUND, 0);
>>>> -	sched->wq = alloc_workqueue("panthor-csf-sched", WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
>>>> -	if (!sched->wq || !sched->heap_alloc_wq) {
>>>> +	sched->wq = alloc_workqueue("panthor-csf-sched", WQ_UNBOUND, 0);
>>>> +	sched->sched_wq = alloc_workqueue("panthor-drm-sched", WQ_MEM_RECLAIM, 0);
>>>
>>> The other one also needs MEM_RECLAIM, because you need work items
>>> queued to sched->wq to run to guarantee forward progress, and you need
>>> to guarantee forward progress to reclaim GPU mem.
>>
>> Ack, I had a feeling that might be the case.
>>
>> I will respin next week or so. Or if you tell me the global lock can be
>> easily dropped from .run_job I can drop and forget about it. Wider
>> context is that I am experimenting with kthread_worker conversion and
>> trying to polish a
>> somewhat-broken-but-showing-great-latency-improvements branch.
> 
> Yep, I know, your experimental branch is actually on my list of things
> to look at/test ;-).

Hold off a few days at least, there is a UAF in the branch Chia-I tested 
and I am in the process of reworking some details to eliminate that.

>> For that
>> I can kind of take either one global worker, or one worker per client
>> route for the RFC, no big deal either way for the prototype.
> 
> We probably want a worker per-prio (and possibly per-cpu), but certainly
> not one per-client, or you'll end up with the thread explosion that was
> addressed by the kthread -> workqueue transition.

Yeah I know, it is non-trivial, especially when different drivers are 
considered. There are multiple angles I am attacking that from and we 
can discuss it once I have something polished enough for sharing.

Just one of the things being the fact both panthor and I think xe 
currently serialize on the device global lock (per GuC CT lock in case 
of xe) so the whole point of per sched workers is questionable. I am yet 
to look at the other drivers to gain a fuller picture, but there is also 
VM BIND in panthor which is a problem.

> Also, I didn't look at your panthor changes in this branch yet, but if
> we're switching drm_sched to kthread workers, we probably want to
> transition most existing panthor works to kthread_work, because some FW
> events might need to processed for the GPU context to be unblocked, and
> if we keep queuing those to a regular workqueue, they will be lagging
> behing the HI_PRIO thread you have for HI_PRIO contexts.

Possibly yes. I glanced over some tick based machine so it is plausible 
that could be changed completely. For now the goal was to do a proof of 
concept and see if the numbers support it. And it seems the numbers are 
dramatically strong so I am cleaning it all up for an RFC.

Regards,

Tvrtko

