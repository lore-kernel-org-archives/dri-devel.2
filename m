Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA23BC982C1
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 09:51:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0F0610E721;
	Wed, 16 Sep 2026 09:51:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="FRdRqhXy";
	dkim-atps=neutral
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com
 [74.125.228.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0D4110E721
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 09:51:23 +0000 (UTC)
Received: by mail-ej2-f12.google.com with SMTP id
 a640c23a62f3a-c254f9f7dbfso97028666b.2
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 02:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1789552282; x=1790157082; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nCzlxrroVPQhOJrlEr3pnRC7pwnWFB68EuzKrxrdJ4s=;
 b=FRdRqhXyrvQP8Mf8I77nfZzmBoNHXy4VG8uUmBCLgs5+PYCf/FUhCNVjRuhM0Hz/T6
 4GOAtkKbc0XZEfkoJSA17+1jRC6+gWKhGxxeIuxSYas03iSYF0d44b2OhHnt1AnkMMl8
 CJmsLLQ4Rr6bajNN7EgD6gPXeqXlhQTekXcYDxLjKCeHK1GV/8kAK6xQSMgu9NBY3n2d
 XpAwmEr7dgWoJPk0EdrFrUswZveV6AD4duojifSfDQjCXTchQXCnGLHxPOpndkhpKmVX
 MXevBh/BSnGui75zFFBo43+e6CkKiIHMoQOdbZ8ZZz/J9IqJ9he6V7SoNA5NiXfnzYQv
 8GkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789552282; x=1790157082;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nCzlxrroVPQhOJrlEr3pnRC7pwnWFB68EuzKrxrdJ4s=;
 b=cCHvWQPrEFC372XUSyWKKbPy5UyBirir02tZW4w2t6WrHhcPtuBfalLtP0SaKNExG+
 lZNknta9N1Agycm25IxxwRebHFL5/vXF1rM/DxvluD9vtUFt6RkHqZDGH4NHMXOsUL7F
 2IYqXgnKfOWo6UY+aOCWtfMlqkYZ9qw6cbZJmsJ8sBmCvStym6bkj/lUjsxpt/vWe0vq
 98WI3q9hGsxFirIa2NcWcP243wXl/xNYYaEkHACTf6AcoTj0pixX2xwqJRhaMGXLWn8n
 QIFdslu49wQS0yFvxyJw5RlFkJA54P28yTCtS8EDXx9QNsYEJwoRC1c073QCwkb1LaZo
 VUvA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzmbQhi0ioyV3SET6Ff4YjGqcNI4S34Gd6Cjfyo/SSua0DkocAf7H48VbDelwZUkefWQ+3GjNmE480=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kbw60XE8GxJ1BgzACDA/nCM+AijlJiejn6eATsN6hHTLWNw8IG
 3U4p1eVd+6EbPpIS8oY32Bd940yfa0nyIVNxnHsHGikwebSOJApqkjq5YW8nEdHnYFs=
X-Gm-Gg: AYBFou3sX2hofwj66vkFm8TwlPgqdmkmAShgp9ZOVHPZtA35rmivjxf6rO2aBVQwBye
 +DGGj5xDyvCMwrt2KLgYfL2o16alpYvGzK1bIJ1lvyTl4ViChUXDLTTYUyIDfmwyizyJFD+ioxh
 v+fq/alQqcr61Kejc73Cvic9bqVlv4whrM1AgulOSls6/OPy8KBloSX3IHYSdNyQKPM7ZrtHwJR
 N6wmC8+8QhBJHwev1Bfjkw9+clgFdXrfHiukKNq/isbXKIsi/VT0BBvDr1Ki1FYbeICHD9/F3m9
 tax/D0eGv9yOW7/Y63+NcUl1TBsgkWgZVCDjwuw5+VFFzBHc28mUX3Yvpkya1qHDD0mmZHkyNl+
 GCbOt1X3PvxLvFkI7eyp1Y/ZqztO1ZCoBeSiOZFlcKISC5WGqOMlFI9hMdbA9P403ZSAF9Rs3qC
 M5DKsKdg7BYJtHUz+NnZ+nmHb+PN/voOta3Wd/Y8h0VAdApN6FKprJjuTFbL498EOUy78z9rdbU
 KFQYYlgQZOAXmQ=
X-Received: by 2002:a17:907:3e03:b0:c26:19de:9ae1 with SMTP id
 a640c23a62f3a-c29e5392d85mr123748966b.32.1789552281904; 
 Wed, 16 Sep 2026 02:51:21 -0700 (PDT)
Received: from [192.168.0.116] ([81.79.79.1]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c29de086960sm104447866b.1.2026.09.16.02.51.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2026 02:51:21 -0700 (PDT)
Message-ID: <0ea708d8-eef4-4245-8b49-fe47d30ca343@ursulin.net>
Date: Wed, 16 Sep 2026 10:51:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/i915: fix incorrect RCU teardown order
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
 rodrigo.vivi@intel.com
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260903113621.54660-1-christian.koenig@amd.com>
 <30c0848e-e8f6-4bb7-8505-89316158c49e@ursulin.net>
 <2030085d-5f14-4bd7-8694-dc8a6a2a25ed@amd.com>
 <0e10455a-a328-42a8-981f-43dbb46593a2@ursulin.net>
 <378d447a-a285-451c-b001-5c6dd6ea74b6@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <378d447a-a285-451c-b001-5c6dd6ea74b6@amd.com>
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


On 09/09/2026 08:24, Christian König wrote:
> On 9/8/26 09:25, Tvrtko Ursulin wrote:
>> On 07/09/2026 12:53, Christian König wrote:
>>> On 9/7/26 11:54, Tvrtko Ursulin wrote:
>>>>
>>>> On 03/09/2026 12:36, Christian König wrote:
>>>>> i915_gem_busy_ioctl uses dma_resv_for_each_fence_unlocked() to iterate
>>>>> over the fences in an GEM object without holding a reference but only
>>>>> the RCU read side lock.
>>>>>
>>>>> What can happen here is that the GEM object is destroyed concurrently
>>>>> while i915_gem_busy_ioctl is still running. This won't free the GEM
>>>>> objects memory, but still drops all the dma_fence references.
>>>>>
>>>>> Now when dma_resv_for_each_fence_unlocked() sees a destroyed dma_fence it
>>>>> assumes that a new fence list was installed and re-starts the loop.
>>>>>
>>>>> But in the case of a destroyed GEM object a new fence list is never
>>>>> installed, only the old one freed and therefore the iteration never
>>>>> finishes resulting in an endless loop.
>>>>
>>>> Only i915_busy can get into this failure mode? None of the other users of the iterator?
>>>
>>> Yes, at least as far as I can see.
>>>
>>> The problem is completely i915 specific because it is the only driver (I could find) which protects GEM objects by RCU.
>>>
>>>> Also, the reference counting series makes the fix irrelevant?
>>>
>>> No, that series just helped uncover the issue.
>>>
>>> Sashiko-bot correctly complained that i915 is dropping the new dma-resv reference to early resulting in potential use after free. And I was thinking wait a second when the dma_resv_fini() is called to early in the existing code then the dma_fence references are dropped to early as well... so that is an pre-existing bug.
>>>
>>> Before the commit mentioned in the fixes tag the i915_gem_busy_ioctl() could just return nonsense, but after that change it could result in an endless loop and that is problematic.
>>
>> Where is this sashiko report, associated with which patch I mean?
> 
> See the comment here https://patchwork.freedesktop.org/patch/748868/#comment_1379963:
> 
>>> @@ -159,8 +146,7 @@ static void dma_resv_release(struct kref *kref)
>>>   
>>>   	dma_resv_list_free(rcu_dereference_protected(obj->fences, true));
>>>   	ww_mutex_destroy(&obj->lock);
>>> -	if (obj->allocated)
>>> -		kfree(obj);
>>> +	kfree(obj);
>>>   }
>>
>> [Severity: Critical]
>> Does this synchronous free cause a use-after-free for concurrent lockless
>> RCU readers?
>>
>> In the i915 driver, GEM objects are destroyed using call_rcu() (via
>> __i915_gem_free_object_rcu). Lockless readers like i915_gem_busy_ioctl()
>> look up objects under rcu_read_lock() and access obj->base.resv.
>>
>> If an object shares its resv instance (e.g., via obj->shares_resv_from with
>> an i915_address_space), __i915_gem_free_object() drops the lock reference
>> synchronously via i915_vm_resv_put(). If that drops the last reference,
>> dma_resv_release() synchronously frees the memory here.
>>
>> However, the GEM object itself remains valid during the RCU grace period.
>> Can concurrent RCU readers dereference the already freed dma_resv pointer
>> when calling dma_resv_iter_begin(&cursor, obj->base.resv, ...) in
>> i915_gem_busy_ioctl()?

I guess the shared dma-resv part you will solve in the context of the 
reference counting series.
>> Is the dma_fence_get_rcu() inside dma_resv_iter_walk_unlocked() what triggers the endless restarts?
> 
> Yes, exactly that one. When it can't grab a fence reference it tries to get a new list, but when there isn't any new list it just tries that forever.
> 
>> It's been some time since I looked at the dma-resv walks.. but fences on the list have reference held so that can trigger either via dma_resv_fini() or dma_resv_replace_fences(), right?
> 
> No, dma_resv_replace_fences() replaces an old fence with a valid new one. So the loop never becomes endless.

What I was wondering about is that dma_resv_replace_fences() has no RCU 
protection so how does it co-operate with unlocked walks?

> Same for dma_resv_reserve_fences(), here we replace a whole list with a new one and make sure that we free up the old one only after an RCU grace period.
> 
> The problem happens only when drivers incorrectly call dma_resv_fini() while a call to dma_resv_for_each_fence_unlocked() is still ongoing at the same time. And that is pretty obviously a bug.
> 
>> If second is true then how does i915 having the dma-resv containing object RCU freed cause the problem?
> 
> I also considered setting obj->fences to NULL in dma_resv_fini() as alternative workaround, but that would break again when I try to reference count the dma_resv object in the future.
> 
> So I would need to free the dma_resv object RCU safe as well just because of the problem in i915 and that is not something I like to do when it is actually a trivial fix in i915.

Fix looks plausible to me but I still wonder of the implication any 
driver which would use  dma_resv_for_each_fence_unlocked would need to 
ensure a RCU grace before calling dma_resv_fini, no? I do not see it 
documented in dma_resv_for_each_fence_unlocked kerneldoc so if that is 
true we should add it.

For this patch:

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

There were some CI failures so I have queued a re-test. If things will 
look reasonable I will merge it.

Regards,

Tvrtko

>>>>> The solution is to drop the fence references only after the RCU grace
>>>>> period.
>>>>>
>>>>> The fixes tag is not necessary the patch introducing the problem, but the
>>>>> one making it so worse that we need to address it.
>>>>>
>>>>> This problem was pointed out by Sashiko-bot.
>>>>>
>>>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>>>> Fixes: 912ff2ebd695 ("drm/i915: use the new iterator in i915_gem_busy_ioctl v2")
>>>>> CC: stable@vger.kernel.org
>>>>> ---
>>>>>     drivers/gpu/drm/i915/gem/i915_gem_object.c | 2 +-
>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object.c b/drivers/gpu/drm/i915/gem/i915_gem_object.c
>>>>> index 5172d3982654..9e01f8b2079a 100644
>>>>> --- a/drivers/gpu/drm/i915/gem/i915_gem_object.c
>>>>> +++ b/drivers/gpu/drm/i915/gem/i915_gem_object.c
>>>>> @@ -89,6 +89,7 @@ struct drm_i915_gem_object *i915_gem_object_alloc(void)
>>>>>       void i915_gem_object_free(struct drm_i915_gem_object *obj)
>>>>>     {
>>>>> +    dma_resv_fini(&obj->base._resv);
>>>>>         return kmem_cache_free(slab_objects, obj);
>>>>>     }
>>>>>     @@ -144,7 +145,6 @@ void __i915_gem_object_fini(struct drm_i915_gem_object *obj)
>>>>>     {
>>>>>         mutex_destroy(&obj->mm.get_page.lock);
>>>>>         mutex_destroy(&obj->mm.get_dma_page.lock);
>>>>> -    dma_resv_fini(&obj->base._resv);
>>>>>     }
>>>>>       /**
>>>>
>>>
>>
> 

