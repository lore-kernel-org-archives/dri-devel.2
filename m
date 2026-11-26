Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3C4606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 14:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=ck3NUlet
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2E3110E49E;
	Thu, 26 Nov 2026 14:22:16 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 579E810E49E
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 14:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=QjMzii+rjeF8oiTOgH1wjwZTlwvQ2jcM+M4VmxrUF3A=; t=1795702931; x=2111062931; 
 b=ck3NUletxVhYqRRjH3+W1BrcU0edQ/FW3vLN4UxAgEVRr7ftIkbzgdEmLXdUnC3Ojn7xGmMM989
 GqjqzojWin9OOJ7juzydZsmHVEawqUAvQXKCLytFcyGZAGSZay4LYcqrO0xcUCoHFrPO+F5Vg2SMm
 9FjQMa9lx4W56f1OnXRDG9D0bXXAS+1yccxvOZxTVz79FaXi8+Jow8AuhbdWQN2040QFQ6Ay0FRnk
 a6+OBNQyO/gnctfQa0zX/Kldtdwp/7bzKPrbSECDsuzGqLmg0ZxW04RARDy0puJxOHmuVCcvUfvyR
 Hwv5Kt/aRBeA4/uY2r+eUuSFTLj/r+x0vcYA==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xWaMT-00000004QcU-1sJ7; Thu, 26 Nov 2026 15:22:09 +0100
Message-ID: <03352665-de15-4ba3-a054-f5be65db67fa@igalia.com>
Date: Thu, 26 Nov 2026 14:22:08 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] drm/syncobj: Use scoped cleanup for
 drm_syncobj_array_wait_timeout points
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Fei Yu <fei.yu@intel.com>,
 =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
References: <20261126111117.67342-1-tvrtko.ursulin@igalia.com>
 <20261126111117.67342-3-tvrtko.ursulin@igalia.com>
 <38563e5c-5475-4afa-bf44-fccfc1037390@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <38563e5c-5475-4afa-bf44-fccfc1037390@amd.com>
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


On 26/11/2026 12:09, Christian König wrote:
> On 11/26/26 12:11, Tvrtko Ursulin wrote:
>> Use scoped cleanup for drm_syncobj_array_wait_timeout points array
>> allocation.
>>
>> This is a split out step towards converting the whole function with the
>> goal of simpler error handling and easier extending with a fast path in
>> the future.
>>
>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Fei Yu <fei.yu@intel.com>
>> Cc: Maíra Canal <mcanal@igalia.com>
>> ---
>>   drivers/gpu/drm/drm_syncobj.c | 27 ++++++++++-----------------
>>   1 file changed, 10 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
>> index 663d6cb8dbf8..bd3f9e74e678 100644
>> --- a/drivers/gpu/drm/drm_syncobj.c
>> +++ b/drivers/gpu/drm/drm_syncobj.c
>> @@ -193,6 +193,7 @@
>>    */
>>   
>>   #include <linux/anon_inodes.h>
>> +#include <linux/cleanup.h>
>>   #include <linux/dma-fence-unwrap.h>
>>   #include <linux/eventfd.h>
>>   #include <linux/export.h>
>> @@ -1052,8 +1053,8 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
>>   						  ktime_t *deadline)
>>   {
>>   	struct syncobj_wait_entry *entries;
>> +	u64 *points __free(kvfree) = NULL;
>>   	struct dma_fence *fence;
>> -	uint64_t *points;
>>   	uint32_t signaled_count, i;
>>   
>>   	if (flags & (DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT |
>> @@ -1063,23 +1064,18 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
>>   	}
>>   
>>   	points = kvmalloc_objs(*points, count);
>> -	if (points == NULL)
>> +	if (!points)
>>   		return -ENOMEM;
>>   
>> -	if (!user_points) {
>> -		memset(points, 0, count * sizeof(uint64_t));
>> -
>> -	} else if (copy_from_user(points, user_points,
>> -				  sizeof(uint64_t) * count)) {
>> -		timeout = -EFAULT;
>> -		goto err_free_points;
>> -	}
>> +	if (!user_points)
>> +		memset(points, 0, count * sizeof(u64));
>> +	else if (copy_from_user(points, user_points, sizeof(u64) * count))
>> +		return -EFAULT;
> 
> I would go a step further here and don't even allocate points when user_points is not given.
> 
> There are only two uses of points[i] below and that can easily be replaced by a single "points ? points[i] : 0" making the additional allocation superfluous for this use case.

I actually attempted to do this few years ago by dropping this temporary 
storage altogether and just reading the points as we go. I think your 
concern back then was potential extra overhead from copy_from_user done 
per point (and it cannot be get_user since 32-bit arm cannot do 64-bit 
get/put user).

The alternative of splitting into no user_points and user_points paths 
is something I would need to see how it would look. Lets have some 
conclusions on other patches and then see.

Tvrtko

>>   
>>   	entries = kvzalloc_objs(*entries, count);
>> -	if (!entries) {
>> -		timeout = -ENOMEM;
>> -		goto err_free_points;
>> -	}
>> +	if (!entries)
>> +		return -ENOMEM;
>> +
>>   	/* Walk the list of sync objects and initialize entries.  We do
>>   	 * this up-front so that we can properly return -EINVAL if there is
>>   	 * a syncobj with a missing fence and then never have the chance of
>> @@ -1198,9 +1194,6 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
>>   	}
>>   	kvfree(entries);
>>   
>> -err_free_points:
>> -	kvfree(points);
>> -
>>   	return timeout;
>>   }
>>   
> 

