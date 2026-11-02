Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339D8606B924
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=rMG4Lw/t
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99E0910EF38;
	Mon,  2 Nov 2026 14:37:06 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B535A10E618;
 Mon,  2 Nov 2026 14:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=M+QtftQCvQ7UorP2FMYX5X/lRNWLmJ6xnVMXJUAR41I=; t=1793630219; x=2108990219; 
 b=rMG4Lw/tM0eqOdrXiv7a7HuHoH1rOv8/hux2+AutoiywXftPfDsxFzWLq1MwJtYJ//FD6+cFYVD
 M7deWNadcswnXkm92oKgFQsqpoxgXeus3tiYDW6lMA4K4pRljMxw+cMvseVZlTnL5WcIe6fLFi/iF
 mVEbqoPxXT22MeHs/wnO7Zd1NoOz0gcozOHHvjZhz9uyzXC8f4bE+tPVA5Bo2T8aLIWSdwXYERdCQ
 7ANCBsGBCaJ8aXDBApBsQC13cpScO4GGt4TzUDY5Qgc4ySKw/orQ3TgZBidtq4C0B3URBDUIMWlTH
 Ztt6GHPmLdmw/Yd2aMQ+IPpmas+FYcsY5lrQ==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xNt9d-000DMy-13; Mon, 02 Nov 2026 15:36:57 +0100
Message-ID: <b982e952-072a-441a-b2a4-1bed8b8a9705@igalia.com>
Date: Mon, 2 Nov 2026 14:36:56 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/sched: Fix out of bounds entity priority check
To: phasta@kernel.org, dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 stable@vger.kernel.org
References: <20261021094227.48034-1-tvrtko.ursulin@igalia.com>
 <20261021094227.48034-2-tvrtko.ursulin@igalia.com>
 <45a8324481c367a69f25e8c395ff6784b441a834.camel@mailbox.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <45a8324481c367a69f25e8c395ff6784b441a834.camel@mailbox.org>
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 02/11/2026 10:46, Philipp Stanner wrote:
> On Wed, 2026-10-21 at 10:42 +0100, Tvrtko Ursulin wrote:
>> When the out of range priority at entity init time is clamped to the
>> number of run queues in the supplied scheduler the internal run-queue
>> priority needs to be adjusted as well.
>>
>> There is no impact since none of the drivers hit the clamping path, but
>> we still need to address it by moving the entity->rq_priority assignment
>> to after the clamping is done.
>>
>> Note that a lot of this will hopefully get removed once again when the
>> single run-queue simplification lands.
> 
> So this is no existing bug out there, but merely for formal
> correctness?

Yep.

>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> Fixes: 2fa4d8e2c109 ("drm/sched: Add fair scheduling policy")
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Danilo Krummrich <dakr@kernel.org>
>> Cc: Matthew Brost <matthew.brost@intel.com>
>> Cc: Philipp Stanner <phasta@kernel.org>
>> Cc: <stable@vger.kernel.org> # v7.2+
>> ---
>>   drivers/gpu/drm/scheduler/sched_entity.c | 27 +++++++++++-------------
>>   1 file changed, 12 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
>> index 7be0387bac3c..e12709b7bd0c 100644
>> --- a/drivers/gpu/drm/scheduler/sched_entity.c
>> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
>> @@ -130,10 +130,7 @@ int drm_sched_entity_init(struct drm_sched_entity *entity,
>>   
>>   	INIT_LIST_HEAD(&entity->list);
>>   	entity->guilty = guilty;
>> -	entity->priority = priority;
>>   	entity->last_user = current->group_leader;
>> -	entity->rq_priority = drm_sched_policy == DRM_SCHED_POLICY_FAIR ?
>> -			      DRM_SCHED_PRIORITY_KERNEL : priority;
>>   	entity->num_sched_list = num_sched_list;
>>   	entity->sched_list = num_sched_list > 1 ? sched_list : NULL;
>>   	RB_CLEAR_NODE(&entity->rb_tree_node);
>> @@ -144,25 +141,25 @@ int drm_sched_entity_init(struct drm_sched_entity *entity,
>>   		 * not to do this and to fix their DRM calling order.
>>   		 */
>>   		pr_warn("%s: called with uninitialized scheduler\n", __func__);
>> -	} else {
>> -		enum drm_sched_priority p = entity->priority;
>> -
>> +	} else if (priority >= sched_list[0]->num_user_rqs) {
>>   		/*
>>   		 * The "priority" of an entity cannot exceed the number of
>>   		 * run-queues of a scheduler. Protect against num_rqs being 0,
>>   		 * by converting to signed. Choose the lowest priority
>>   		 * available.
>>   		 */
>> -		if (p >= sched_list[0]->num_user_rqs) {
>> -			dev_err(sched_list[0]->dev, "entity with out-of-bounds priority:%u num_user_rqs:%u\n",
>> -				p, sched_list[0]->num_user_rqs);
>> -			p = max_t(s32,
>> -				  (s32)sched_list[0]->num_user_rqs - 1,
>> -				  (s32)DRM_SCHED_PRIORITY_KERNEL);
>> -			entity->priority = p;
>> -		}
>> +		dev_err(sched_list[0]->dev, "entity with out-of-bounds priority:%u num_user_rqs:%u\n",
>> +			priority, sched_list[0]->num_user_rqs);
>> +		priority = max_t(s32,
>> +				 (s32)sched_list[0]->num_user_rqs - 1,
>> +				 (s32)DRM_SCHED_PRIORITY_KERNEL);
>> +	}
>> +
>> +	entity->priority = priority;
>> +	entity->rq_priority = drm_sched_policy == DRM_SCHED_POLICY_FAIR ?
>> +			      DRM_SCHED_PRIORITY_KERNEL : priority;
> 
> I guess my main question regarding the code is why you moved those
> lines?
> 
>> +	if (sched_list[0]->sched_rq)
> 
> Couldn't that remain in a terminating `else`, reducing the git churn?

It could; the minimal diff would be:

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c 
b/drivers/gpu/drm/scheduler/sched_entity.c
index 7be0387bac3c..0dec0d22c997 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -160,6 +160,8 @@ int drm_sched_entity_init(struct drm_sched_entity 
*entity,
                                   (s32)sched_list[0]->num_user_rqs - 1,
                                   (s32)DRM_SCHED_PRIORITY_KERNEL);
                         entity->priority = p;
+                       entity->rq_priority = drm_sched_policy == 
DRM_SCHED_POLICY_FAIR ?
+                                             DRM_SCHED_PRIORITY_KERNEL 
: priority;
                 }
                 entity->rq = sched_list[0]->sched_rq[entity->rq_priority];
         }

But that leaves the "ugly" sequence of assigning prio back and forth, 
and even adds more ugliness to it by repeating the drm_sched_policy 
conditional:

	entity->priority = priority;
...
	entity->rq_priority = drm_sched_policy == DRM_SCHED_POLICY_FAIR ?
			      DRM_SCHED_PRIORITY_KERNEL : priority;
...
	} else {
		enum drm_sched_priority p = entity->priority;
...
		if (p >= sched_list[0]->num_user_rqs) {
...
			entity->priority = p;
+                       entity->rq_priority = drm_sched_policy == 
DRM_SCHED_POLICY_FAIR ?
+                                             DRM_SCHED_PRIORITY_KERNEL : p;

So I thought we can tidy in up in one go and end up with a completely 
streamlined and localised:

	} else if (priority >= sched_list[0]->num_user_rqs) {
...
		priority = max_t(s32,
				 (s32)sched_list[0]->num_user_rqs - 1,
				 (s32)DRM_SCHED_PRIORITY_KERNEL);
...
	entity->priority = priority;
	entity->rq_priority = drm_sched_policy == DRM_SCHED_POLICY_FAIR ?
			      DRM_SCHED_PRIORITY_KERNEL : priority;

I don't think there was any churn to this area so backporting shouldn't 
be a problem.

Regards,

Tvrtko

> 
>>   		entity->rq = sched_list[0]->sched_rq[entity->rq_priority];
>> -	}
>>   
>>   	init_completion(&entity->entity_idle);
>>   

