Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F22A606A324
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 15:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=aE3GgeGo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEDC410E0E9;
	Wed, 11 Nov 2026 15:05:26 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8655710E0E9
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 15:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=H9/AkaoiJa+uWiTufWZ+L06ZCqcB2qDLCnYRAFG7bfs=; t=1794409521; x=2109769521; 
 b=aE3GgeGoKpmahUpSXS5QK4G02T9pI+5vPYZYxtBUvF9aFnuZig62ddF8tj6Xavt80L9+iOeBwd2
 NWD3HMYPAYO4tpX7sAX31eZsQ6GtMe6CNvAw3j6/8RPUZIBNK2PMK0lPZpn0sqqwiQUHtUmuX2Hsx
 AYp0G+dWkzf8GQy5PMyY+3ddjQ+FVQyQZwKn4Irj++6q3bwCFIanHfctDtFHtptV1HfrcDC290prh
 IVwzSBvqp8Y4+VQH1hEqmAswgjsfbuJxjeRPl7JveLrhXXpnqXNaWPeKzhqtZnlQpagFAW7opxlBD
 WxXuIXDX24Wi65yTgJ9WH+J92/gTaFuClwmQ==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xR9t0-008sMM-Gc; Wed, 11 Nov 2026 16:05:18 +0100
Message-ID: <0ff2a53b-377e-4839-88da-1c2b3c25b3eb@igalia.com>
Date: Wed, 11 Nov 2026 15:05:17 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/sched: Do not overaccount job runtime
To: phasta@kernel.org, dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, Gary Guo <gary@garyguo.net>,
 "Paul E. McKenney" <paulmck@kernel.org>
References: <20261111105921.38710-1-tvrtko.ursulin@igalia.com>
 <71ad23bcb3d48f771ce74270dbe4dfcf39827031.camel@mailbox.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <71ad23bcb3d48f771ce74270dbe4dfcf39827031.camel@mailbox.org>
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
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/11/2026 13:05, Philipp Stanner wrote:
> +Cc folks from my other RFC
> 
> On Wed, 2026-11-11 at 10:59 +0000, Tvrtko Ursulin wrote:
>> Currently the starting timestamp of the next job on the timeline is
>> adjusted to the end of a preceding job. This works if the next job has
>> been submitted while the preceding job was still executing, but not if it
>> was submitted in the window between it finishing and free job work running
>> the timestamp adjustment.
>>
>> This can happen because the run job and free job work items share the same
>> ordered workqueue and run job can easily submit the next job before the
>> free job gets a chance to run. This over accounting window is present
>> especially with single credit schedulers, but not limited too.
>>
>> Fix it by only adjusting the starting timestamp if it is not already after
>> the finish time of the preceding job.
>>
>> While at it move the logic to a helper to keep indendation at bay.
>>
>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> Fixes: 1774baa64f93 ("drm/scheduler: Change scheduled fence track v2")
> 
> In antoher mail you mentioned a userspace change which motivated this
> patch. What is that about, some performance issue? So you want it in
> all old kernels or not?

Not motivated but discovered while investigating job runtime accounting.

Whether is it worth backporting, assuming you mean cc: stable or not, 
and ignoring the fact it would get picked up anyway due Fixes:, I 
thought it is not worth it since the error per job would be very small 
(how much time between two queued work items on the same workqeueue). 
And despite it being accumulating, I *think*, relative to the actual GPU 
times it can never grow to be significant. It would require consistent 
significant spacing between run_job and free_job and/or super short GPU 
jobs. It did not feel worth explicitly putting cc: stable on the patch.
  >> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Danilo Krummrich <dakr@kernel.org>
>> Cc: Matthew Brost <matthew.brost@intel.com>
>> Cc: Philipp Stanner <phasta@kernel.org>
>> ---
>>   drivers/gpu/drm/scheduler/sched_main.c | 24 +++++++++++++++++++-----
>>   1 file changed, 19 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
>> index a030061d0390..136880fc193d 100644
>> --- a/drivers/gpu/drm/scheduler/sched_main.c
>> +++ b/drivers/gpu/drm/scheduler/sched_main.c
>> @@ -898,6 +898,24 @@ drm_sched_select_entity(struct drm_gpu_scheduler *sched)
>>   	return IS_ERR(entity) ? NULL : entity;
>>   }
>>   
>> +static void
>> +adjust_next_job_start(struct drm_sched_job *job, struct drm_sched_job *next)
> 
> Not nitty with that usually, but since literally all our functions
> always start with drm_sched_, this one should probably be
> drm_sched_job_XXX()

:shrug: for file local helpers I am not keen on long prefixes so it's 
just a habit. I can change it no problem.

> 
>> +{
>> +	struct dma_fence *next_scheduled = &next->s_fence->scheduled;
>> +	ktime_t ts;
>> +
>> +	if (!test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &next_scheduled->flags))
>> +		return;
>> +
>> +	/*
>> +	 * If the next job has been submitted while the previous one was still
>> +	 * running adjust it's starting timestamp to avoid accounting overlap.
>> +	 */
>> +	ts = dma_fence_timestamp(&job->s_fence->finished);
>> +	if (ktime_after(ts, next_scheduled->timestamp))
>> +		next_scheduled->timestamp = ts;
>> +}
>> +
>>   /**
>>    * drm_sched_get_finished_job - fetch the next finished job to be destroyed
>>    *
>> @@ -929,11 +947,7 @@ drm_sched_get_finished_job(struct drm_gpu_scheduler *sched)
>>   						typeof(*next), list);
>>   		if (next) {
>>   			/* make the scheduled timestamp more accurate */
>> -			if (test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT,
>> -				     &next->s_fence->scheduled.flags))
>> -				next->s_fence->scheduled.timestamp =
>> -					dma_fence_timestamp(&job->s_fence->finished);
> 
> Urgh, only now am I realizing that we just "conveniently" overwrite a
> fence's internal timestamp, relying on how dma_fence works internally.
> 
> Do you know what ordering is like btw for all of this?
> 
> This is the *next* job's scheduled fence, so this sounds suspiciously
> racy. Testing the bit and overwriting the timestamp, can't that race?

I have a feeling the code was assuming the default ordered workqueue 
ensures either run_job or free_job runs at a time. So seeing timestamped 
next fence guarantees free_job has exclusive right to the timestamp write.

That is not true though for the three drivers which use own unordered 
workqueues - pvr, nouveau and panthor.

If we look at the drm_sched_run_job_work():
...
	drm_sched_job_begin(sched_job);
  -> puts on a pending_list for free job to find
...
drm_sched_fence_scheduled(s_fence, fence);
  -> signals the scheduled fence
...

If free_job interleaves in the middle, so it sees the next job but it 
looks unscheduled it will skip the correction.

But that also means timestamp is yet to be written so there is no need 
to correct it. Super subtle but harmless if I am correct. At minium 
needs a big fat comment though.
> dma_fence_timestamp's cpu_relax() might serve as a barrier, but I can't
> see ordering between bit check and overwriting the timestamp?

Yes I think you are right. As said I think there is no real bug due race 
with unordered workqueues, but for formal correctness it would require a 
memory barrier after test_bit, or full blown locking.

Regards,

Tvrtko

> See my recent RFC where I strongly suspect that we have such race's
> with fences' error codes [1].
> 
> 
> P.
> 
> 
> [1] https://lore.kernel.org/dri-devel/20261110155817.1492359-3-phasta@kernel.org/

