Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27453606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 14:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=Tog7+VH0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80E7810F3B1;
	Mon,  9 Nov 2026 14:45:58 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AFC610E7D2;
 Mon,  9 Nov 2026 14:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=h+GkudQWo+SK1Si/H8t6duIVnLCqHVmI1n70EBgg3BI=; t=1794235551; x=2109595551; 
 b=Tog7+VH0ZXE5Bn4jw2rfhtL182jP6m5xPrXN8fs6KQhqMXVZ0YjHDp57VUoziz+aAiJWa4Y8azP
 FQYduHDrlEW/Ox3lZ2MG7JeUK91E4YrYsdul8HvFv11u6k8va1aUxlyRwQ4yE6dqfZJWMDFrucxLK
 0902bqiBrJuAIXGbCxtG3EQ76zkTOiGMkbJLrDFMn9QkVKyfd+bOyuPbzKMJ8iNcNaHmT/oLoP+Kj
 uHulqrS9ZzUjWu2wmpQAU98X/dRIBnDGs9K+Xho6IQQrnnKiiA67Hw8bwWBDxPtvn4rbnDLJafeoy
 Gczr744T3UFczm3rc1jVyDIJnzv4zsGWQDsA==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xQQd2-007NMC-J0; Mon, 09 Nov 2026 15:45:48 +0100
Message-ID: <55a418ad-2d18-4996-be3d-833ee143eb1a@igalia.com>
Date: Mon, 9 Nov 2026 14:45:47 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] drm/amdgpu: Rework the
 amdgpu_job_stop_all_jobs_on_sched() hack
To: phasta@kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>,
 Matthew Brost <matthew.brost@intel.com>, Simona Vetter <simona@ffwll.ch>,
 Danilo Krummrich <dakr@kernel.org>
References: <20261106145702.61640-1-tvrtko.ursulin@igalia.com>
 <20261106145702.61640-6-tvrtko.ursulin@igalia.com>
 <e857e8e7edfe4c91aeda47478d6512a9d3ff5fe4.camel@mailbox.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <e857e8e7edfe4c91aeda47478d6512a9d3ff5fe4.camel@mailbox.org>
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
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 09/11/2026 12:46, Philipp Stanner wrote:
> On Fri, 2026-11-06 at 14:57 +0000, Tvrtko Ursulin wrote:
>> -/*
>> - * This is a duplicate function from DRM scheduler sched_internal.h.
>> - * Plan is to remove it when amdgpu_job_stop_all_jobs_on_sched is removed, due
>> - * latter being incorrect and racy.
>> - *
>> - * See https://lore.kernel.org/amd-gfx/44edde63-7181-44fb-a4f7-94e50514f539@amd.com/
>> - */
>>   static struct drm_sched_job *
>>   drm_sched_entity_queue_pop(struct drm_sched_entity *entity)
> 
> Why remove that comment? A reader will still wonder why a drm_sched
> function is defined here.

It effectively moved down in the diff.

>>   {
>> @@ -476,28 +469,66 @@ drm_sched_entity_queue_pop(struct drm_sched_entity *entity)
>>   	return container_of(node, struct drm_sched_job, queue_node);
>>   }
>>   
>> -void amdgpu_job_stop_all_jobs_on_sched(struct drm_gpu_scheduler *sched)
>> +static struct drm_sched_entity *
>> +get_entity_with_jobs(struct drm_gpu_scheduler *sched) __acquires(&entity->lock)
> 
> […]
> 
>> +retry:
>>   	for (i = DRM_SCHED_PRIORITY_KERNEL; i < sched->num_rqs; i++) {
>>   		struct drm_sched_rq *rq = sched->sched_rq[i];
>> +
>>   		spin_lock(&rq->lock);
>> -		list_for_each_entry(s_entity, &rq->entities, list) {
>> -			while ((s_job = drm_sched_entity_queue_pop(s_entity))) {
>> -				struct drm_sched_fence *s_fence = s_job->s_fence;
>> +		list_for_each_entry(entity, &rq->entities, list) {
>> +			/*
>> +			 * This can false negative, but so could the previous
>> +			 * approach of scanning the run-queues once when
>> +			 * nothing prevents userspace to queue more jobs.
>> +			 */
>> +			if (!spsc_queue_count(&entity->job_queue))
>> +				continue;
>>   
>> -				dma_fence_signal(&s_fence->scheduled);
>> -				dma_fence_set_error(&s_fence->finished, -EHWPOISON);
>> -				dma_fence_signal(&s_fence->finished);
>> +			/*
>> +			 * We must trylock because normal locking order is
>> +			 * entity then rq and here we already have rq locked
>> +			 * in order to be able to walk the entities.
>> +			 */
>> +			if (spin_trylock(&entity->lock)) {
>> +				/* Returns with a locked entity. */
>> +				spin_unlock(&rq->lock);
>> +				return entity;
> 
> Ah, now I understand.
> 
> Hmm. I guess considering the circumstances we're in that's the best-ish
> option we have?
> 
> I hope the AMD folks can't see technical blockers.

Yeah I think it's the best before AMD follows up with the promised 
complete rework of how this is handled.

I am hoping this hacky rework, assuming it is no more broken by the 
original, and that AMD can test it (I don't have the required hardware), 
can be a motivator. :)

>> +			} else {
>> +				/*
>> +				 * Busy entity - we will try again looking for a
>> +				 * window where trylock will succeed.
>> +				 */
>> +				spin_unlock(&rq->lock);
>> +				goto retry;
> 
> In classic anti-deadlock strategies, wouldn't you want some random
> delay here to avoid cycling?

I did not see a reason to not make this thread the most greedy it can 
be. Because the longer it runs the more potential for livelock has.

Same is true for the existing solution to be clear, but this patch does 
increase the window a bit by adding trylock and restart. I think. Or 
perhaps it is the same potential because all that is required in the 
current code is for an entity to keep submitting and 
amdgpu_job_stop_all_jobs_on_sched() never exits the pop loop. With this 
patch any entity doing a submit can trigger a re-scan of all entities, 
so any submitting anything new will be handled, until the time this 
loops needs to finish the re-scan is lower than the submit frequency. 
Hence I thought the faster it goes the better.

Regards,

Tvrtko

