Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65556CD6E55
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 09:14:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87ECC113C97;
	Wed,  3 Jun 2026 09:14:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="NrKadQyG";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BDE4113C95
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 09:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=De/H9v3P+lfJ2i1wRPydbhaI86jUHQUvPbwvrzdNMps=; b=NrKadQyGVMB2w/jp3uIEeexYCn
 Hs7Xrwh7t+Ckdwa1x9iBLGYyWWAmGbjcIWi2s30TfoeWqP74lzf7PgLTRV6ci5Mc8E5zVZB9zERLE
 WWPipO3fcrx/Nk8YXcnZVPzgbDMtwIMbot6QGyvJMk2LcIBWudAMvPmm9/debZvdxUgw8bwdwgrhB
 WweuQi1RilW5olcGceMnyWl2/iHoFa0aiqFuQzALy+Hxz2r5W/KWNOy0R609t50iYlZMxnzUAbmIf
 mgE9eI0cZlFTfLOfRObKK0y/V4hx+NwSoh79l+SWN2aL7Y3byGXQF+lZDCndRkB3uOqVR3NSS2sAy
 Qj9aF+MA==;
Received: from [90.240.106.137] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wUhg4-00C67g-7L; Wed, 03 Jun 2026 11:14:20 +0200
Message-ID: <1ddf1427-e0ee-4891-9af6-028cd559b161@igalia.com>
Date: Wed, 3 Jun 2026 10:14:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/sched: Remove redundant entity->rq initialization and
 checks
To: phasta@kernel.org, dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>
References: <20260602153339.43453-1-tvrtko.ursulin@igalia.com>
 <4e7e282983939dd64b9303d53302e6806361076c.camel@mailbox.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <4e7e282983939dd64b9303d53302e6806361076c.camel@mailbox.org>
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


On 03/06/2026 09:37, Philipp Stanner wrote:
> On Tue, 2026-06-02 at 16:33 +0100, Tvrtko Ursulin wrote:
>> Commit
>> 28c5bf28763d ("drm/sched: Disallow initializing entities with no schedulers")
>> failed to notice clearing of entity->rq in drm_sched_entity_init() is now
> 
> By clearing you also mean the setting to NULL?
> 
> I'd just use "initialization" consistently, like in the commit title.

It is initialized properly a bit lower down so clearing is I think more 
accurate.

>> redundant and can be removed.
>>
>> Given that entity->rq can now never be NULL, we also remove two impossible
>> checks, from drm_sched_entity_kill() and drm_sched_entity_flush()
>> respectively.
>>
>> Similarly, we can also remove the !entity->rq check in
>> drm_sched_job_init(). And for the better, given that the error message, if
>> it ever triggered, would have dereferenced the yet un-initialized job->
>> sched (only initialized later in drm_sched_job_arm()). This appears to
>> have been theoretically broken ever since commit
>> 56e449603f0a ("drm/sched: Convert the GPU scheduler to variable number of run-queues")
>> .
>>
>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Danilo Krummrich <dakr@kernel.org>
>> Cc: Matthew Brost <matthew.brost@intel.com>
>> Cc: Philipp Stanner <phasta@kernel.org>
>> ---
>>   drivers/gpu/drm/scheduler/sched_entity.c | 11 ++---------
>>   drivers/gpu/drm/scheduler/sched_main.c   |  9 ---------
>>   2 files changed, 2 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
>> index 4ebb513255ed..c51101ec70c1 100644
>> --- a/drivers/gpu/drm/scheduler/sched_entity.c
>> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
>> @@ -129,7 +129,6 @@ int drm_sched_entity_init(struct drm_sched_entity *entity,
>>   		return -ENOMEM;
>>   
>>   	INIT_LIST_HEAD(&entity->list);
>> -	entity->rq = NULL;
> 
> It would seem that has always been redundant because of the memset(0)
> directly above.

True, ever since 1decbf6bb0b4 ("drm/sched: Fix entities with 0 rqs."). 
Just that in this patch the redundant is focusing on:

   entity->rq = NULL;
...
   entity->rq = &sched_list[0]->rq;

Good enough or you want a respin and if so in what flavour?

Regards,

Tvrtko

> 
>>   	entity->guilty = guilty;
>>   	entity->priority = priority;
>>   	entity->last_user = current->group_leader;
>> @@ -280,9 +279,6 @@ void drm_sched_entity_kill(struct drm_sched_entity *entity)
>>   	struct drm_sched_job *job;
>>   	struct dma_fence *prev;
>>   
>> -	if (!entity->rq)
>> -		return;
>> -
>>   	spin_lock(&entity->lock);
>>   	entity->stopped = true;
>>   	drm_sched_rq_remove_entity(entity->rq, entity);
>> @@ -329,14 +325,11 @@ EXPORT_SYMBOL(drm_sched_entity_kill);
>>    */
>>   long drm_sched_entity_flush(struct drm_sched_entity *entity, long timeout)
>>   {
>> -	struct drm_gpu_scheduler *sched;
>> +	struct drm_gpu_scheduler *sched =
>> +		container_of(entity->rq, typeof(*sched), rq);
>>   	struct task_struct *last_user;
>>   	long ret = timeout;
>>   
>> -	if (!entity->rq)
>> -		return 0;
>> -
>> -	sched = container_of(entity->rq, typeof(*sched), rq);
>>   	/*
>>   	 * The client will not queue more jobs during this fini - consume
>>   	 * existing queued ones, or discard them on SIGKILL.
>> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
>> index 818d3d4434b5..d2ca01b31ee4 100644
>> --- a/drivers/gpu/drm/scheduler/sched_main.c
>> +++ b/drivers/gpu/drm/scheduler/sched_main.c
>> @@ -588,15 +588,6 @@ int drm_sched_job_init(struct drm_sched_job *job,
>>   		       u32 credits, void *owner,
>>   		       uint64_t drm_client_id)
>>   {
>> -	if (!entity->rq) {
>> -		/* This will most likely be followed by missing frames
>> -		 * or worse--a blank screen--leave a trail in the
>> -		 * logs, so this can be debugged easier.
>> -		 */
>> -		dev_err(job->sched->dev, "%s: entity has no rq!\n", __func__);
>> -		return -ENOENT;
>> -	}
>> -
>>   	if (unlikely(!credits)) {
>>   		pr_err("*ERROR* %s: credits cannot be 0!\n", __func__);
>>   		return -EINVAL;
> 
> But overall a very nice cleanup
> 
> 
> P.

