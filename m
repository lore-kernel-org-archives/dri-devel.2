Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41DE606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 16:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=BNDLCZeH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 557DD10E9E7;
	Thu, 26 Nov 2026 16:57:46 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D071810E9E7;
 Thu, 26 Nov 2026 16:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=3QYGTQ89m4JKYdxQpHjxu/zGzksEv6dmjmD+Bk4si38=; t=1795712259; x=2111072259; 
 b=BNDLCZeH/dSYdc9ICWDoI3gsx1r0ojqrKjo3HyRojVMYsstSW9SkyeDh0EoTU4YhoLIkfM9xoje
 NN1BVwpDYbySBBv43H5TLwVrNUBOpJNcIhs3rmA/iEfmoYyCZWu0ns6KUKod/BNs158ff6svPXUX3
 xOBp+QvMZjSP5OusfNJOrZ0vWP13XwgIX7sMojH+E+SzBvK6fEGdUIRTYP+NHCY71hNcqooR4DJzt
 9fxi/n+KAviEtdP7aZ169banmNSwtxrUf0CqzKAh87devSpjq4JSNG71KQStid5ar7+awPlYhO29U
 C4I1Z5vYcVERPOJLp/XSIHxdwl2Qrw+ygnpw==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xWcmv-00000004UQB-2yp0; Thu, 26 Nov 2026 17:57:37 +0100
Message-ID: <d5b03f06-7a35-4f51-a02d-ee594c669c36@igalia.com>
Date: Thu, 26 Nov 2026 16:57:36 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] drm/sched: Track sched fence scheduled and finished time
 directly
To: phasta@kernel.org, dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, amd-gfx@lists.freedesktop.org
References: <20261126154200.71180-1-tvrtko.ursulin@igalia.com>
 <f4c37f8d72c545dde2111bb8a3038ac05228800e.camel@mailbox.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <f4c37f8d72c545dde2111bb8a3038ac05228800e.camel@mailbox.org>
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


On 26/11/2026 15:59, Philipp Stanner wrote:
> On Thu, 2026-11-26 at 15:42 +0000, Tvrtko Ursulin wrote:
>> Philipp reports the current usage of overwriting the dma-fence timestamp
>> from the free_job worker is racy and unsafe due missing memory ordering
>> and especially with drivers which use own unordered submit workqueue for
>> the scheduler. Consider also that the timestamp field is the union in the
>> dma-fence object.
> 
> Yeah, the union thing is also something I realized during the last
> days. If that should ever be read misordered it would blow up the
> entire scheduling algorithm because the fence's callback-list pointer
> would be interpreted as a timestamp…

Algorithm? More like the kernel. :)

>> On top of these serious issue there is also a smaller problem where the
>> said race can cause GPU time overaccounting.
>>
>> Lets try and solve all issues in one swoop by stopping messing with
>> dma-fence internals and just track what we want in our own derived fence
>> object.
>>
>> We care about fence submit and finish times and by adding a dedicated
>> lock to manage them we can safely access both and adjust the former
>> without any races.
>>
>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> References: https://lore.kernel.org/dri-devel/20261119131830.2535266-2-phasta@kernel.org/
> 
> After this thread, I started investigating timestamp-ordering in fence.
> I have ideas how we might fix it and have started preparing patches,
> also one that would touch the scheduler. But yours here seems to do
> more of the heavy lifting.
> 
>> References: https://lore.kernel.org/dri-devel/20261117094324.8256-1-tvrtko.ursulin@igalia.com/
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Danilo Krummrich <dakr@kernel.org>
>> Cc: Matthew Brost <matthew.brost@intel.com>
>> Cc: Philipp Stanner <phasta@kernel.org>
>> Cc: amd-gfx@lists.freedesktop.org
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c    | 15 ++++----
>>   drivers/gpu/drm/scheduler/sched_entity.c   |  6 ++--
>>   drivers/gpu/drm/scheduler/sched_fence.c    | 20 +++++++++--
>>   drivers/gpu/drm/scheduler/sched_internal.h | 41 ++++++++++++++++++++++
>>   drivers/gpu/drm/scheduler/sched_main.c     |  8 ++---
>>   include/drm/gpu_scheduler.h                | 39 ++++++++++++++++++++
>>   6 files changed, 113 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> index 2f0349233695..1a6985283acc 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> @@ -171,21 +171,20 @@ static unsigned int amdgpu_ctx_get_hw_prio(struct amdgpu_ctx *ctx, u32 hw_ip)
>>   static ktime_t amdgpu_ctx_fence_time(struct dma_fence *fence)
>>   {
>>   	struct drm_sched_fence *s_fence;
>> +	ktime_t start, end;
>>   
>>   	if (!fence)
>>   		return ns_to_ktime(0);
>>   
>> -	/* When the fence is not even scheduled it can't have spend time */
>>   	s_fence = to_drm_sched_fence(fence);
>> -	if (!test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &s_fence->scheduled.flags))
>> -		return ns_to_ktime(0);
>> +	drm_sched_fence_get_times(s_fence, &start, &end);
>> +
>> +	/* When the fence is not even scheduled it can't have spend time */
>> +	if (!start)
>> +		return start;
>>   
>>   	/* When it is still running account how much already spend */
>> -	if (!test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &s_fence->finished.flags))
>> -		return ktime_sub(ktime_get(), s_fence->scheduled.timestamp);
>> -
>> -	return ktime_sub(s_fence->finished.timestamp,
>> -			 s_fence->scheduled.timestamp);
>> +	return ktime_sub(end ?: ktime_get(), start);
> 
> That's also a sequence I worked on.
> 
> First I wanted to fully lock dma_fence_timestamp() and use it here.

Right, I though as long as we need to lock something we might as well 
lock our own thing and then no need to come up with API. Existing 
dma_fence_timestamp is also a quite an ugly function.

> But guess what, I then couldn't use it because amdgpu_ctx_fence_time()
> is called under fctx lock, which is the same as the fence lock ->
> deadlock.

Obviously then you need an unlocked version of the API! :D

> […]
> 
>>   void drm_sched_fence_scheduled(struct drm_sched_fence *fence,
>>   			       struct dma_fence *parent)
>>   {
>> +	ktime_t now = ktime_get();
>> +	unsigned long flags;
>> +
>>   	/* Set the parent before signaling the scheduled fence, such that,
>>   	 * any waiter expecting the parent to be filled after the job has
>>   	 * been scheduled (which is the case for drivers delegating waits
>> @@ -74,14 +77,26 @@ void drm_sched_fence_scheduled(struct drm_sched_fence *fence,
>>   	if (!IS_ERR_OR_NULL(parent))
>>   		drm_sched_fence_set_parent(fence, parent);
>>   
>> -	dma_fence_signal(&fence->scheduled);
>> +	spin_lock_irqsave(&fence->ts_lock, flags);
>> +	fence->start_ts = now;
>> +	spin_unlock_irqrestore(&fence->ts_lock, flags);
> 
> I get what you are doing here. I think it'll work, and also it's
> partially necessary because we should not overwrite a dma_fence's
> timestamp.
> 
> Nevertheless, it seems that you don't use dma_fence_timestamp() at all
> anymore. Not even in amdgpu above.

Yep, that's another benefit. As said, it's one ugly function.

> So we are then tempted to wonder what dma_fence->timestamp is even good
> for anymore, and if we're running danger of re-implementing parts of
> the fence functionality in sched_fence?

Same as the pesky timeline and driver names. It's ABI courtesy of 
sync_file. :(

> 
> Christian?
> 
>> +
>> +	dma_fence_signal_timestamp(&fence->scheduled, now);
> 
> You write the fence timestamp, but it seems it's not read anymore since
> sched_fence now does that? IOW, whom are you setting the timestamp for,
> who will ever evaluate it who shouldn't instead evaluate the time
> stamps of sched_fence?

This is not really required, it could have stayed as dma_fence_signal. 
It's only so the two timestamps are aligned, but again, it would have no 
ill effect if they were different.

> 
>>   }
>>   
>>   void drm_sched_fence_finished(struct drm_sched_fence *fence, int result)
>>   {
>> +	ktime_t now = ktime_get();
>> +	unsigned long flags;
>> +
>>   	if (result)
>>   		dma_fence_set_error(&fence->finished, result);
>> -	dma_fence_signal(&fence->finished);
>> +
>> +	spin_lock_irqsave(&fence->ts_lock, flags);
>> +	fence->finished_ts = now;
>> +	spin_unlock_irqrestore(&fence->ts_lock, flags);
>> +
>> +	dma_fence_signal_timestamp(&fence->finished, now);
> 
> input from Christian will be needed; just recently we were envisioning
> to reduce the number of signal-functions.
> 
> If you can wait a few days I would also like to present an RFC for the
> memory ordering in dma_fence_timestamp().

Sure. The over-accounting race I found is not that big deal for now.

Tvrtko

