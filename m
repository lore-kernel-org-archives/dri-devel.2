Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97E7606A321
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 15:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=rBYogVyz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0876210E904;
	Wed, 25 Nov 2026 15:16:20 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 011B410E904
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 15:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=gzRgUp4mb3Oif1vfnFUv3/mwS1vMz1Xv29WTvy2ua1A=; t=1795619773; x=2110979773; 
 b=rBYogVyz3GNuKcr5jGaceK0MWNXWQYX71R8NMv4KAml6Nn97bqP2YxCsEbtpUM7rkkNc65cq/Hr
 dx3FSVUodPrMnbhdC1kNpY0fxPxxPBplrTeYvaS3Z+NXJrugMSO5RIHp5Qpqrijak1IopV5TImvdS
 HhLy83gqpZvnGz2BNbk/4QGZT+7EaFX5OYyH/sBb4y8TnM4gw4TeR09PYF1Lzcmct6gr+lJNcNKwN
 2ZR59nVASavOvhDxmE4eCka7c5FaA995MHH9LgTnN/DT+BxkR+iSpGBAoQkHPIhqdbycJGmPyH3MQ
 17jKL3nJxe2OrVVyLjY97WIssrjYIyTzsWWg==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xWEjE-000000040oj-0SkV; Wed, 25 Nov 2026 16:16:12 +0100
Message-ID: <b748acb9-e8c9-4622-8595-bb58c7e6d9ec@igalia.com>
Date: Wed, 25 Nov 2026 15:16:11 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/syncobj: Add a fast path to
 drm_syncobj_array_wait_timeout
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Fei Yu <fei.yu@intel.com>
References: <20261117103916.9101-1-tvrtko.ursulin@igalia.com>
 <20261117103916.9101-3-tvrtko.ursulin@igalia.com>
 <4f507f12-2b1a-4319-93a8-813f35b9da3e@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <4f507f12-2b1a-4319-93a8-813f35b9da3e@amd.com>
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


On 19/11/2026 10:57, Christian König wrote:
> On 11/17/26 11:39, Tvrtko Ursulin wrote:
>> Running the Cyberpunk 2077 benchmark we can observe that waiting on DRM
>> sycobjs is relatively hot, but the 96% of the calls are for a single
>> object. (~4% for two points, and never more than three points. While
>> a more trivial workload like vkmark under Plasma is even more skewed
>> to single point waits.)
>>
>> Therefore lets add a fast path to bypass the kcalloc/kfree and use a pre-
>> allocated stack array for those cases.
> 
> In general it seems valid to optimize that stuff, but I'm a bit concerned about the complexity and opportunity for coding errors which are hard to detect.
> 
> How about we have a macro which creates a guarded stack allocation which is either using the stack when it is small enough or kvzalloc_objs() as fallback?

Well it's doable, and I did sketch something up. I just need to test it 
a bit more and then I'll send out an RFC. But for now, as an advance 
"warning", whether or not it has more or less chance of adding bugs, we 
will see once the review starts. :)

Point being it is a larger change since I started by converting most of 
drm_syncobj.c to scoped cleanup first. Otherwise it did not make sense 
to me to have a mix of allocations. With those prep patches done it was 
much easier to add a macro as you suggest. Anyway, stay tuned.

Tvrtko

>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> Reviewed-by: Maíra Canal <mcanal@igalia.com> # v3
>> Cc: Fei Yu <fei.yu@intel.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> ---
>> v2:
>>   * Document rationale for stack array in a comment.
>>
>> v3:
>>   * Added DRM_SYNCOBJ_FAST_PATH_ENTRIES to avoid hardcoding fast path array
>>     size.
>>
>> v4:
>>   * Rebased to be standalone.
>>
>> v5:
>>   * Rebased for kzalloc_objs.
>>
>> v6:
>>   * Rebased for kvmalloc_objs and kvzalloc_objs.
>> ---
>>   drivers/gpu/drm/drm_syncobj.c | 44 ++++++++++++++++++++++++++---------
>>   1 file changed, 33 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
>> index 663d6cb8dbf8..b76b957b1fff 100644
>> --- a/drivers/gpu/drm/drm_syncobj.c
>> +++ b/drivers/gpu/drm/drm_syncobj.c
>> @@ -248,6 +248,14 @@ static void
>>   syncobj_eventfd_entry_func(struct drm_syncobj *syncobj,
>>   			   struct syncobj_eventfd_entry *entry);
>>   
>> +/*
>> + * Empirically vast majority of ioctls pass in a single syncobj (96%) and never
>> + * more than three points. Therefore implement a fast path with a small stack
>> + * array to avoid going into the allocator sometimes several times per
>> + * userspace rendered frame.
>> + */
>> +#define DRM_SYNCOBJ_FAST_PATH_ENTRIES 4
>> +
>>   /**
>>    * drm_syncobj_find - lookup and reference a sync object.
>>    * @file_private: drm file private pointer
>> @@ -1051,10 +1059,12 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
>>   						  uint32_t *idx,
>>   						  ktime_t *deadline)
>>   {
>> +	struct syncobj_wait_entry stack_entries[DRM_SYNCOBJ_FAST_PATH_ENTRIES];
>> +	u64 stack_points[DRM_SYNCOBJ_FAST_PATH_ENTRIES];
>>   	struct syncobj_wait_entry *entries;
>>   	struct dma_fence *fence;
>> -	uint64_t *points;
>>   	uint32_t signaled_count, i;
>> +	uint64_t *points;
>>   
>>   	if (flags & (DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT |
>>   		     DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE)) {
>> @@ -1062,24 +1072,33 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
>>   		lockdep_assert_none_held_once();
>>   	}
>>   
>> -	points = kvmalloc_objs(*points, count);
>> -	if (points == NULL)
>> -		return -ENOMEM;
>> +	if (count > ARRAY_SIZE(stack_points)) {
>> +		points = kvmalloc_objs(*points, count);
>> +		if (!points)
>> +			return -ENOMEM;
>> +	} else {
>> +		points = stack_points;
>> +	}
>>   
>>   	if (!user_points) {
>>   		memset(points, 0, count * sizeof(uint64_t));
>> -
>>   	} else if (copy_from_user(points, user_points,
>>   				  sizeof(uint64_t) * count)) {
>>   		timeout = -EFAULT;
>>   		goto err_free_points;
>>   	}
>>   
>> -	entries = kvzalloc_objs(*entries, count);
>> -	if (!entries) {
>> -		timeout = -ENOMEM;
>> -		goto err_free_points;
>> +	if (count > ARRAY_SIZE(stack_entries)) {
>> +		entries = kvzalloc_objs(*entries, count);
>> +		if (!entries) {
>> +			timeout = -ENOMEM;
>> +			goto err_free_points;
>> +		}
>> +	} else {
>> +		memset(stack_entries, 0, sizeof(stack_entries));
>> +		entries = stack_entries;
>>   	}
>> +
>>   	/* Walk the list of sync objects and initialize entries.  We do
>>   	 * this up-front so that we can properly return -EINVAL if there is
>>   	 * a syncobj with a missing fence and then never have the chance of
>> @@ -1196,10 +1215,13 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
>>   						  &entries[i].fence_cb);
>>   		dma_fence_put(entries[i].fence);
>>   	}
>> -	kvfree(entries);
>> +
>> +	if (entries != stack_entries)
>> +		kvfree(entries);
>>   
>>   err_free_points:
>> -	kvfree(points);
>> +	if (points != stack_points)
>> +		kvfree(points);
>>   
>>   	return timeout;
>>   }
> 

