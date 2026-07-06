Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 163D8C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 12:03:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7104010E930;
	Mon,  6 Jul 2026 12:03:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="IAizrK0N";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB3B510E930
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 12:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1p24W3l40HjHqdtstXnE1g2Vd30P3cEpjjfHRODytPs=; b=IAizrK0NcW7e7sqqtjIJsI82V7
 PYu88ZXJSRXxnPPCrkztmsVxgKiHcuAfcLPkKtfw8qM02GQlNjxBEHEgh848zVIZntX9HmmrnTntL
 ZdPPZRTY0DKmEcHeckJWYEvByJoL2SDdPAze/W4GBo6JikcGPJaabBjHkCz7CfDqwYPBr+Z+HGsMz
 UWHvK5YIw4wGMCkAHTDR4jjvNPZyvcjDebc0FOdkVgP1+8oMdoUoT7ULCCQBGp95U0YXRfu2jasDG
 Sz9KZmRmeWAjgldw3mREVmskg6FigyUv3c8RI/XZXdv3k4tnrwt4JaWYnjlIJEko61WykIcSKg1zp
 78QJ5G5Q==;
Received: from [90.240.106.137] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wgi2w-009iin-IK; Mon, 06 Jul 2026 14:03:34 +0200
Message-ID: <8aa9ffad-ece3-428b-b307-1d5f4136db73@igalia.com>
Date: Mon, 6 Jul 2026 13:03:33 +0100
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
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260702173127.3103af30@fedora-2.home>
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



On 02/07/2026 16:31, Boris Brezillon wrote:
> On Thu,  2 Jul 2026 15:37:39 +0100
> Tvrtko Ursulin <tvrtko.ursulin@igalia.com> wrote:
> 
>> Currently an unordered workqueue is used for the DRM scheduler which means
>> its concurrency is externally managed, and given there is one scheduler
>> instance per userspace queue, that means workqueue management logic is
>> within its rights to spawn many kernel threads to submit their respective
>> jobs.
>>
>> Problem there is that all run job callbacks are serialized on the device
>> global mutex,
> 
> I think we should address that instead, and either shorten the scope of
> the locked section, or make it so we don't make it a contention point
> for concurrent job submission from different contexts (with a rwsem
> instead of a lock, for instance).
> 
>> making the potential thread storm just causing lock
>> contention.
>>
>> If we add a separate ordered workqueue for the DRM scheduler integration
>> we can avoid this problem, since the ordered property directly expresses
>> the nature of the submission backend implementation.
> 
> Yep, except that's not how it was meant to work. The goal was to allow
> contexts to submit their jobs concurrently to the FW. The only reason we
> take the lock is to:
> 
> 1. make sure the context is still allowed to take jobs
> 2. kick the group scheduler if the context is not resident
> 
> For #1, I believe we can come up with either a lockless solution, or a
> solution where the lock protecting the state belongs to the group
> instead of being externally protected by the device-wide scheduler lock.
> 
> For #2, the rwsem approach, and narrowing down the locked section to
> just this part of the code should do the trick.

Out of curiosity how much CPU side parallelism you think is required to 
keep these GPUs fed? Both today (with the greater lock contention) and 
in the future (with the reduced contention) I guess would be interesting 
data points.

>> And considering the other user of this workqueue, the free job callback,
>> which is not globally serialized in this manner so could be thought to
>> potentially regress with this change, it should not be the case since
>> commit
>> a58f317c1ca0 ("drm/sched: Free all finished jobs at once")
>> made the DRM scheduler handle the cleanup of finished jobs more promptly.
> 
> I don't know if this change is a hard dep for what's coming next, but
> if it's not, I'd drop it. If it is, and the new kthread_work solution
> relies on this serialization, I guess I need to read more to understand
> why.

You mean this patch, "drm/panthor: Use separate workqueue for DRM 
scheduler"?

It is not strictly required. I could for example use the concurrent 
flavour of the drm_sched_worker I add later in the series. That would 
align with WQ_UNBOUND which is currently used, but then there is the 
question of how much parallelism is required and the fact dumb worker 
pool implementation from this RFC makes no attempt to spawn/retire 
threads on demand. It just picks four out of thin air kind of. Priority 
inheritance would still work but if picking a fix number of threads 
based on some criteria wouldn't be feasible I would need to work on a 
smarter worker pool implementation.

I could drop it, although the question would be when do you expect 
locking rework could realistically happen and, if not quick, what is the 
advantage of keeping the false parallelism.

Regards,

Tvrtko

> 
>>
>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> Cc: Boris Brezillon <boris.brezillon@collabora.com>
>> Cc: Liviu Dudau <liviu.dudau@arm.com>
>> Cc: Steven Price <steven.price@arm.com>
>> ---
>> v2:
>>   * Actually create an unordered wq.
>>   * Put back WQ_MEM_RECLAIM to sched->wq.
>> ---
>>   drivers/gpu/drm/panthor/panthor_sched.c | 26 +++++++++++++++++--------
>>   1 file changed, 18 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
>> index 2bee1c92fb9e..f4dfd82ad8a8 100644
>> --- a/drivers/gpu/drm/panthor/panthor_sched.c
>> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
>> @@ -147,13 +147,11 @@ struct panthor_scheduler {
>>   	struct panthor_device *ptdev;
>>   
>>   	/**
>> -	 * @wq: Workqueue used by our internal scheduler logic and
>> -	 * drm_gpu_scheduler.
>> +	 * @wq: Workqueue used by our internal scheduler logic.
>>   	 *
>>   	 * Used for the scheduler tick, group update or other kind of FW
>>   	 * event processing that can't be handled in the threaded interrupt
>> -	 * path. Also passed to the drm_gpu_scheduler instances embedded
>> -	 * in panthor_queue.
>> +	 * path.
>>   	 */
>>   	struct workqueue_struct *wq;
>>   
>> @@ -166,6 +164,14 @@ struct panthor_scheduler {
>>   	 */
>>   	struct workqueue_struct *heap_alloc_wq;
>>   
>> +	/**
>> +	 * @sched_wq: Workqueue used for the DRM scheduler.
>> +	 *
>> +	 * Workqueue used for drm_gpu_scheduler instances embedded in
>> +	 * panthor_queue.
>> +	 */
>> +	struct workqueue_struct *sched_wq;
>> +
>>   	/** @tick_work: Work executed on a scheduling tick. */
>>   	struct delayed_work tick_work;
>>   
>> @@ -3488,7 +3494,7 @@ group_create_queue(struct panthor_group *group,
>>   {
>>   	struct drm_sched_init_args sched_args = {
>>   		.ops = &panthor_queue_sched_ops,
>> -		.submit_wq = group->ptdev->scheduler->wq,
>> +		.submit_wq = group->ptdev->scheduler->sched_wq,
>>   		/*
>>   		 * The credit limit argument tells us the total number of
>>   		 * instructions across all CS slots in the ringbuffer, with
>> @@ -4078,6 +4084,9 @@ static void panthor_sched_fini(struct drm_device *ddev, void *res)
>>   	if (sched->heap_alloc_wq)
>>   		destroy_workqueue(sched->heap_alloc_wq);
>>   
>> +	if (sched->sched_wq)
>> +		destroy_workqueue(sched->sched_wq);
>> +
>>   	for (prio = PANTHOR_CSG_PRIORITY_COUNT - 1; prio >= 0; prio--) {
>>   		drm_WARN_ON(ddev, !list_empty(&sched->groups.runnable[prio]));
>>   		drm_WARN_ON(ddev, !list_empty(&sched->groups.idle[prio]));
>> @@ -4168,12 +4177,13 @@ int panthor_sched_init(struct panthor_device *ptdev)
>>   	 * allocate memory, and fail the tiling job if none of these
>>   	 * countermeasures worked.
>>   	 *
>> -	 * Set WQ_MEM_RECLAIM on sched->wq to unblock the situation when the
>> -	 * system is running out of memory.
>> +	 * Set WQ_MEM_RECLAIM on sched->wq and wq->sched_wq to unblock the
>> +	 * situation when the system is running out of memory.
>>   	 */
>>   	sched->heap_alloc_wq = alloc_workqueue("panthor-heap-alloc", WQ_UNBOUND, 0);
>>   	sched->wq = alloc_workqueue("panthor-csf-sched", WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
>> -	if (!sched->wq || !sched->heap_alloc_wq) {
>> +	sched->sched_wq = alloc_ordered_workqueue("panthor-drm-sched", WQ_MEM_RECLAIM);
>> +	if (!sched->wq || !sched->heap_alloc_wq || !sched->sched_wq) {
>>   		panthor_sched_fini(&ptdev->base, sched);
>>   		drm_err(&ptdev->base, "Failed to allocate the workqueues");
>>   		return -ENOMEM;
> 

