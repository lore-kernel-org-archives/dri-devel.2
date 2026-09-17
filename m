Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47DD3C982C1
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 07:59:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DBEC10EA5D;
	Thu, 17 Sep 2026 07:59:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="CO0q8k3U";
	dkim-atps=neutral
Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com
 [74.125.228.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5CED10EA5D
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 07:59:51 +0000 (UTC)
Received: by mail-ed2-f35.google.com with SMTP id
 4fb4d7f45d1cf-6aa135d6e97so865785a12.2
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 00:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1789631990; x=1790236790; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=FWe5NINIyTtJ7oo9COzDUzG8WoDWJmUyLYcbK9bO/4Y=;
 b=CO0q8k3Uxqdk0blwKhinCs5mCrLA13X+r5Abydkl9MGyoh2KZfK2VeVW7/wld9wLdu
 DU/XEExcNA6hDYc3ITFy648qjnQizawfz53pUwqPaAUZmaYg0Exzs5t4KhQc6mlDgL/y
 JfGsaFdDFYmC6MlQz2Oy1fn250xYKbKUuFqZdMwdpGIDAno8e84TPkJT+rttONSC7deu
 ZZCRhwPfolulRdtp+HRagKTi81us2mPgadvcq7L5tSqEhoILMlgf3VUCmS4pnmAAfeyo
 UGEDxnVd4m6uHnSAPoqoIm/g61NxUfqDyUfsTLwbgivqHYnVeyVyeq48elGAnXQ1HHhe
 HB5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789631990; x=1790236790;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FWe5NINIyTtJ7oo9COzDUzG8WoDWJmUyLYcbK9bO/4Y=;
 b=Ib3x3v5lQyDJSmibswHFeuX9dpobd5/tK+Rd8zLan4a7rQr+0J+Rer17WL7JXi3TSQ
 6eNrhlu7jiumEDvsoIszdadYLO6nAvnON9jkKt0RslhwnEcx8IOh+sFK3fmrZZx7QlCr
 NhGwEbt61M0awsJ6josB3eDwQqrNHeiJhNY20ztUvfw99yfyJEDVM6T7t9fsZbJowQQY
 QKZpG0NGtUl3Nri9mPT8ZwmC7GPDWCSnv70p2aOeRZfcAlCV1KqGbdIWsLlZaAEXEGM/
 +TxSUlgb17ad0KFLyXoAMDrJ2ttm93PJgUI1PZyuY32HPbIiUXjQmZBtWLlawEmwUMkf
 /UPg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzKDyaecJc0v4iakbd0j0XB6gMLgP1PBut/0oHQmE6RPxGcYXtNicEprTKnX4ljD7Sf04bC6NaXl5I=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mQFOAklgtLL/oFQPjDBDLJg/xa7RABMSlsk5tp7Cffd7XpOygn
 sifbC/kaA3XPQF3aw2ydMDs/ANv1kRsUnJcHc19oPwGlWhoOPtNSTPWlJlA/cxsyEGTD+OplL8+
 FcSV1mcg=
X-Gm-Gg: AYBFou3xOgayyq2DuujHqokFEdCLEhU5XruPi/5Zk6hFcq3qXEPtUWfHxlmBGBsA7v5
 sChKu6zk+NK88VUZArQgKUbSOKZaDNrYfgKCKLnvMqtEc7d6oMgEB8vYNK9QFwdF9XBHCI4r8b+
 bqmIqZJSBggH86jBrv61JG8TGRkKoP33s18iaYfup+TZeBBWbpf2IRE3vyH/Vw9pXFYA62bFHwT
 IM1Em1zMgWVnd4IycM86tF7WP4A39VUfNJHyRBtqcbPonWXtb278p/gSyE7doXOgYnl+AgzNai9
 0baNjNMsFhO5MAIcsCYkOCSn6AzsfKo1ArYtn7oWt2/iJeDIuozNuwVlNtqYL3g+l6hHjQFzNVq
 9S/odK19j5WKyc3lt7qOeT+hV/6YpcNQvTUx9U0XINFWTyWok4dnqV3pZslMh7Xg2DvHMBm7WI3
 WqB0jCDnbxzsc4Skdz/LtxbIlKB1yKi5ltu7Oj0rKYdc7AeeRtRyE2iheYTO1k7sGQkn/XUmR1B
 KoToT9vEWk4Frk=
X-Received: by 2002:a05:6402:460c:b0:6a6:8dd:c76b with SMTP id
 4fb4d7f45d1cf-6aa22247992mr8971968a12.1.1789631989758; 
 Thu, 17 Sep 2026 00:59:49 -0700 (PDT)
Received: from [192.168.0.116] ([81.79.79.1]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6aa1d29a1bdsm3354280a12.26.2026.09.17.00.59.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Sep 2026 00:59:49 -0700 (PDT)
Message-ID: <c8776f7c-6a49-4f8a-9b29-d96dada73723@ursulin.net>
Date: Thu, 17 Sep 2026 08:59:48 +0100
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
 <0ea708d8-eef4-4245-8b49-fe47d30ca343@ursulin.net>
 <120a913c-2522-4601-a17a-708778de2036@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <120a913c-2522-4601-a17a-708778de2036@amd.com>
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


On 16/09/2026 13:53, Christian König wrote:
> On 9/16/26 11:51, Tvrtko Ursulin wrote:
> ...
>>>> [Severity: Critical]
>>>> Does this synchronous free cause a use-after-free for concurrent lockless
>>>> RCU readers?
>>>>
>>>> In the i915 driver, GEM objects are destroyed using call_rcu() (via
>>>> __i915_gem_free_object_rcu). Lockless readers like i915_gem_busy_ioctl()
>>>> look up objects under rcu_read_lock() and access obj->base.resv.
>>>>
>>>> If an object shares its resv instance (e.g., via obj->shares_resv_from with
>>>> an i915_address_space), __i915_gem_free_object() drops the lock reference
>>>> synchronously via i915_vm_resv_put(). If that drops the last reference,
>>>> dma_resv_release() synchronously frees the memory here.
>>>>
>>>> However, the GEM object itself remains valid during the RCU grace period.
>>>> Can concurrent RCU readers dereference the already freed dma_resv pointer
>>>> when calling dma_resv_iter_begin(&cursor, obj->base.resv, ...) in
>>>> i915_gem_busy_ioctl()?
>>
>> I guess the shared dma-resv part you will solve in the context of the reference counting series.
> 
> Yes, of course.
> 
>>>> Is the dma_fence_get_rcu() inside dma_resv_iter_walk_unlocked() what triggers the endless restarts?
>>>
>>> Yes, exactly that one. When it can't grab a fence reference it tries to get a new list, but when there isn't any new list it just tries that forever.
>>>
>>>> It's been some time since I looked at the dma-resv walks.. but fences on the list have reference held so that can trigger either via dma_resv_fini() or dma_resv_replace_fences(), right?
>>>
>>> No, dma_resv_replace_fences() replaces an old fence with a valid new one. So the loop never becomes endless.
>>
>> What I was wondering about is that dma_resv_replace_fences() has no RCU protection so how does it co-operate with unlocked walks?
> 
> Hui?
> 
> dma_resv_replace_fences() asserts on holding the reservation lock and uses dma_resv_list_set() to update the entry with the replacement. dma_resv_list_set() then uses RCU_INIT_POINTER().

Never mind, on retrospect I think it is fine. I wasn't grasping the 
consequences of the outer rcu_read_lock() in i915_gem_busy_ioctl() to 
how this interacts with the restart detection.

> Could be that using rcu_assign_pointer() instead of RCU_INIT_POINTER() would be better, but apart from that I don't see why that shouldn't be correctly RCU protected.
>>> Same for dma_resv_reserve_fences(), here we replace a whole list with a new one and make sure that we free up the old one only after an RCU grace period.
>>>
>>> The problem happens only when drivers incorrectly call dma_resv_fini() while a call to dma_resv_for_each_fence_unlocked() is still ongoing at the same time. And that is pretty obviously a bug.
>>>
>>>> If second is true then how does i915 having the dma-resv containing object RCU freed cause the problem?
>>>
>>> I also considered setting obj->fences to NULL in dma_resv_fini() as alternative workaround, but that would break again when I try to reference count the dma_resv object in the future.
>>>
>>> So I would need to free the dma_resv object RCU safe as well just because of the problem in i915 and that is not something I like to do when it is actually a trivial fix in i915.
>>
>> Fix looks plausible to me but I still wonder of the implication any driver which would use  dma_resv_for_each_fence_unlocked would need to ensure a RCU grace before calling dma_resv_fini, no? I do not see it documented in dma_resv_for_each_fence_unlocked kerneldoc so if that is true we should add it.
>>
>> For this patch:
>>
>> Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>
>> There were some CI failures so I have queued a re-test. If things will look reasonable I will merge it.
> 
> Please let me know when it landed in drm-tip since I want to rebase on that.

It passed CI and is in drm-tip now.

Regards,

Tvrtko

> 
> Thanks,
> Christian.
> 
>>
>> Regards,
>>
>> Tvrtko
>>
>>>>>>> The solution is to drop the fence references only after the RCU grace
>>>>>>> period.
>>>>>>>
>>>>>>> The fixes tag is not necessary the patch introducing the problem, but the
>>>>>>> one making it so worse that we need to address it.
>>>>>>>
>>>>>>> This problem was pointed out by Sashiko-bot.
>>>>>>>
>>>>>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>>>>>> Fixes: 912ff2ebd695 ("drm/i915: use the new iterator in i915_gem_busy_ioctl v2")
>>>>>>> CC: stable@vger.kernel.org
>>>>>>> ---
>>>>>>>      drivers/gpu/drm/i915/gem/i915_gem_object.c | 2 +-
>>>>>>>      1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object.c b/drivers/gpu/drm/i915/gem/i915_gem_object.c
>>>>>>> index 5172d3982654..9e01f8b2079a 100644
>>>>>>> --- a/drivers/gpu/drm/i915/gem/i915_gem_object.c
>>>>>>> +++ b/drivers/gpu/drm/i915/gem/i915_gem_object.c
>>>>>>> @@ -89,6 +89,7 @@ struct drm_i915_gem_object *i915_gem_object_alloc(void)
>>>>>>>        void i915_gem_object_free(struct drm_i915_gem_object *obj)
>>>>>>>      {
>>>>>>> +    dma_resv_fini(&obj->base._resv);
>>>>>>>          return kmem_cache_free(slab_objects, obj);
>>>>>>>      }
>>>>>>>      @@ -144,7 +145,6 @@ void __i915_gem_object_fini(struct drm_i915_gem_object *obj)
>>>>>>>      {
>>>>>>>          mutex_destroy(&obj->mm.get_page.lock);
>>>>>>>          mutex_destroy(&obj->mm.get_dma_page.lock);
>>>>>>> -    dma_resv_fini(&obj->base._resv);
>>>>>>>      }
>>>>>>>        /**
>>>>>>
>>>>>
>>>>
>>>
>>
> 

