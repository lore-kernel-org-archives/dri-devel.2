Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6CC606A33A
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 14:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=DuyE3i+4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5E9C112498;
	Thu, 26 Nov 2026 14:33:22 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F89610E3DB
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 14:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=dSYr0gDzxpZoS/g912D0pV+YbhNiymAN9/od+L4le2A=; t=1795703596; x=2111063596; 
 b=DuyE3i+4hlNI0U4AozqLlXfUO9vxmX9QNX7DNhZnPGhrb4lQSooQ3uUGBfQSPnYwEV7Ni4QMlxp
 igQFrXbgDrQoVyeEJVGQzMpjzkqNQGsTc/gB91l/t4mmz0UAogUffeEX94rpKyNeInn9FxC4UamfV
 +RtTreVM/2UAza8N+qJdztsUOXAUK1fUQuIfiMIyPXm2C4pObsJZTyMCi3NXZO3JrHX8+3kmnW7rn
 lBPNQvgdmBLC3vUAuGIFloRc9NixfYV1bbdLvC4Ur2mHNbwHIgS548LZeUIXN/iiF4inj3Uv1ysQ/
 tY+nAJdJE2hAeI+GZfM+l4Xtdnbn6NByJS7g==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xWaXC-00000004Qrf-0xsx; Thu, 26 Nov 2026 15:33:14 +0100
Message-ID: <ec23b635-9cb4-4808-8ceb-3ab9f354b38e@igalia.com>
Date: Thu, 26 Nov 2026 14:33:13 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] drm/syncobj: Use scoped cleanup for
 drm_syncobj_array_wait_timeout syncobjs
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Fei Yu <fei.yu@intel.com>,
 =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
References: <20261126111117.67342-1-tvrtko.ursulin@igalia.com>
 <20261126111117.67342-4-tvrtko.ursulin@igalia.com>
 <6724627c-d211-44be-98d5-4ded6b663483@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <6724627c-d211-44be-98d5-4ded6b663483@amd.com>
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


On 26/11/2026 12:11, Christian König wrote:
> On 11/26/26 12:11, Tvrtko Ursulin wrote:
>> Use scoped cleanup for drm_syncobj_array_wait_timeout entries array
>> allocation and syncobj cleanup.
>>
>> This converts the remaining parts of the function resulting in simpler
>> error handling and easier extending with a fast path in the future.
>>
>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Fei Yu <fei.yu@intel.com>
>> Cc: Maíra Canal <mcanal@igalia.com>
>> ---
>>   drivers/gpu/drm/drm_syncobj.c | 61 +++++++++++++++++++++++------------
>>   1 file changed, 40 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
>> index bd3f9e74e678..7d5c4e4e29b2 100644
>> --- a/drivers/gpu/drm/drm_syncobj.c
>> +++ b/drivers/gpu/drm/drm_syncobj.c
>> @@ -1044,6 +1044,31 @@ static void syncobj_wait_syncobj_func(struct drm_syncobj *syncobj,
>>   	list_del_init(&wait->node);
>>   }
>>   
>> +struct syncobj_wait_entries {
>> +	struct drm_syncobj **syncobjs;
>> +	struct syncobj_wait_entry *entries;
>> +	unsigned int count;
>> +};
>> +
>> +static void syncobj_wait_entries_free(struct syncobj_wait_entries *e)
>> +{
>> +	if (!e->entries)
>> +		return;
>> +
>> +	for (unsigned int i = 0; i < e->count; i++) {
>> +		drm_syncobj_remove_wait(e->syncobjs[i], &e->entries[i]);
>> +		if (e->entries[i].fence_cb.func)
>> +			dma_fence_remove_callback(e->entries[i].fence,
>> +						  &e->entries[i].fence_cb);
>> +		dma_fence_put(e->entries[i].fence);
>> +	}
>> +
>> +	kvfree(e->entries);
>> +}
>> +
>> +DEFINE_FREE(syncobj_wait_entries, struct syncobj_wait_entries,
>> +	    syncobj_wait_entries_free(&_T))
>> +
>>   static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
>>   						  void __user *user_points,
>>   						  uint32_t count,
>> @@ -1052,6 +1077,7 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
>>   						  uint32_t *idx,
>>   						  ktime_t *deadline)
>>   {
>> +	struct syncobj_wait_entries cleanup __free(syncobj_wait_entries) = {};
> 
> Oh that looks ugly, I would seriously not do it this way.
> 
> Replacing the extra kvfree() is ok put I would keep the ref-counting cleanup in the same function.

I assume you meant s/put/but/?

My main counter argument here will be that having a mixture of scope 
based cleanup and goto's would also not be great. Hence I opted to just 
convert it all.

Which part is for you the ugly one?

Regards,

Tvrtko

>>   	struct syncobj_wait_entry *entries;
>>   	u64 *points __free(kvfree) = NULL;
>>   	struct dma_fence *fence;
>> @@ -1076,6 +1102,11 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
>>   	if (!entries)
>>   		return -ENOMEM;
>>   
>> +	/* After this the entries cleanup is fully automatic. */
>> +	cleanup.syncobjs = syncobjs;
>> +	cleanup.entries = entries;
>> +	cleanup.count = count;
>> +
>>   	/* Walk the list of sync objects and initialize entries.  We do
>>   	 * this up-front so that we can properly return -EINVAL if there is
>>   	 * a syncobj with a missing fence and then never have the chance of
>> @@ -1091,12 +1122,10 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
>>   		if (!fence || dma_fence_chain_find_seqno(&fence, points[i])) {
>>   			dma_fence_put(fence);
>>   			if (flags & (DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT |
>> -				     DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE)) {
>> +				     DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE))
>>   				continue;
>> -			} else {
>> -				timeout = -EINVAL;
>> -				goto cleanup_entries;
>> -			}
>> +
>> +			return -EINVAL;
>>   		}
>>   
>>   		if (fence)
>> @@ -1115,7 +1144,7 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
>>   	if (signaled_count == count ||
>>   	    (signaled_count > 0 &&
>>   	     !(flags & DRM_SYNCOBJ_WAIT_FLAGS_WAIT_ALL)))
>> -		goto cleanup_entries;
>> +		return timeout;
>>   
>>   	/* There's a very annoying laxness in the dma_fence API here, in
>>   	 * that backends are not required to automatically report when a
>> @@ -1160,40 +1189,30 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
>>   				} else {
>>   					if (idx)
>>   						*idx = i;
>> -					goto done_waiting;
>> +					__set_current_state(TASK_RUNNING);
>> +					return timeout;
>>   				}
>>   			}
>>   		}
>>   
>>   		if (signaled_count == count)
>> -			goto done_waiting;
>> +			break;
>>   
>>   		if (timeout == 0) {
>>   			timeout = -ETIME;
>> -			goto done_waiting;
>> +			break;
>>   		}
>>   
>>   		if (signal_pending(current)) {
>>   			timeout = -ERESTARTSYS;
>> -			goto done_waiting;
>> +			break;
>>   		}
>>   
>>   		timeout = schedule_timeout(timeout);
>>   	} while (1);
>>   
>> -done_waiting:
>>   	__set_current_state(TASK_RUNNING);
>>   
>> -cleanup_entries:
>> -	for (i = 0; i < count; ++i) {
>> -		drm_syncobj_remove_wait(syncobjs[i], &entries[i]);
>> -		if (entries[i].fence_cb.func)
>> -			dma_fence_remove_callback(entries[i].fence,
>> -						  &entries[i].fence_cb);
>> -		dma_fence_put(entries[i].fence);
>> -	}
>> -	kvfree(entries);
>> -
>>   	return timeout;
>>   }
>>   
> 

