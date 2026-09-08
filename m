Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2071C79F99
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 07:25:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D86B710EA80;
	Tue,  8 Sep 2026 07:25:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="r277bWVY";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C6FB10EA81
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 07:25:10 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-49b96837ca3so34190555e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 00:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1788852308; x=1789457108; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Son9M0C6+OxuLDVknpMWeFb2KEgyFAzhj1mXN7qmr24=;
 b=r277bWVY3KIf8KLEKAmLZxcvBmqLv+3jSymjJ2ycRdUMK5UkwpT3ffda7BnnzN6rFH
 dXlsR86KGARAUTmZstmrPVlxvd6cUuY9kU05W9rWGTfre23O1lCKghR1FtCVy8NiAX5N
 BI9iKm69iATF0aMdthkzVM8IE8PXsPs6Kzxy6V4byFZgFvqnYM92kotLLAsbdhSw0H0X
 a12HA1ULD9F26FO0LVHqHcTf3xJq91inwhN7ruQlmD0t/VBir5kQsQPU9GkQOLUbDViI
 TBctVqsGKBi8gSnChayotaG6IDt7vcqvgzwzgrllQvH+O/y4lLJiW39HzN6Fkejs+VI8
 6s1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788852308; x=1789457108;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Son9M0C6+OxuLDVknpMWeFb2KEgyFAzhj1mXN7qmr24=;
 b=CXoBNjjAgXBOsdV/F9NOLgYJPUncKgMCA+LKBSsz8dJSYmLKUzgXl5uqShuRaVaqg7
 a2ReW/QzyeJnInFshrJ5bk4uw0003ASML0Xk5WXRaAgvB5sNHI7uVkCAWSrEOr0hnKRm
 ppgx64kKjSqVN65Ke84A5shDduZlEKUmOt+wRJSp8xmzDDpL0kcGc6LwAw3opnJtlOHY
 NHnbBQUYcsf5aHJkC1G65omNnhOK8PnJspgAK0A0JIsU+MSXqi3FYAanuTVYQNLhIxLz
 dZMycCvgh5gucW1FEi5v4PdEb9p52Bc2Bcwb4j2aLcTD2d2xYOf0a4uatDken/zuMwIg
 UncQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw5C6scGzyKJ3SH72V10JanWcbzshjfOy2zyXAXYK7uB8BJw5uE6L8Oh3s5RwX6npq2NKKKnBP7FwU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k0j8E60Vs5+D+SGmcqgfoitnAGJgdo5LAmzd6wHH5z3pmTdsGr
 ofjW9bAt28EBNqmOysseTjAoT+/uxB6QkdnW1hWcQLnm8QzS/3leYTumZvrlF9EAJYnf7A188t6
 hL02ADyo=
X-Gm-Gg: AYBFou3Ll5hSHwWrTsVLYatkaWzyepHEYIuwU3zMsqpxRElGpRPgLIm1asVyCcpn7gf
 /k8Mr/QdGVrHur/PVZXgRKjCMlF9eyhudVropo3g/GHXIqT39NKnWN1XES4nKcPgCxtkXLWazAr
 90sBFFRinmwrGlon7fJTYE7GQsVk7UsXApPSi3JttYohVdGdD2uGKLqpEi75/2OC+eGKRaXQ0rZ
 HteGqF6Mhu6CInDhO8NhF+JLLOZ1WhqkjRJ5stQZhDtbSfDqYsNNPrlBGpUD4/wBB5qKlRTSj64
 TS9pTrNDuGJ9dp4sTYVSq4WVmgSo77V81ISAOQdwcUE1KU2W/Q8OnYu/BdrFk7YIHI28/dd6G69
 v9+c4SYKWGzOIb/I6aVmRXm/NHu2Xftuz78yt5XSYqyr6Za/HmRiEkp60/DBmPGz43S307ol2t3
 nQGCQI0vgh+97MONo3Ev9qubsYXadkb+9XpzGA7HjgxlNmreCkw+NdA+mjXIFBsjV2ZwkfX1OIa
 wRZ
X-Received: by 2002:a05:600c:1549:b0:499:a5fc:2087 with SMTP id
 5b1f17b1804b1-49cf81f47e6mr283840725e9.6.1788852307954; 
 Tue, 08 Sep 2026 00:25:07 -0700 (PDT)
Received: from [192.168.0.116] ([81.79.79.1]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4858e239862sm29144012f8f.9.2026.09.08.00.25.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2026 00:25:07 -0700 (PDT)
Message-ID: <0e10455a-a328-42a8-981f-43dbb46593a2@ursulin.net>
Date: Tue, 8 Sep 2026 08:25:06 +0100
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
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <2030085d-5f14-4bd7-8694-dc8a6a2a25ed@amd.com>
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


On 07/09/2026 12:53, Christian König wrote:
> On 9/7/26 11:54, Tvrtko Ursulin wrote:
>>
>> On 03/09/2026 12:36, Christian König wrote:
>>> i915_gem_busy_ioctl uses dma_resv_for_each_fence_unlocked() to iterate
>>> over the fences in an GEM object without holding a reference but only
>>> the RCU read side lock.
>>>
>>> What can happen here is that the GEM object is destroyed concurrently
>>> while i915_gem_busy_ioctl is still running. This won't free the GEM
>>> objects memory, but still drops all the dma_fence references.
>>>
>>> Now when dma_resv_for_each_fence_unlocked() sees a destroyed dma_fence it
>>> assumes that a new fence list was installed and re-starts the loop.
>>>
>>> But in the case of a destroyed GEM object a new fence list is never
>>> installed, only the old one freed and therefore the iteration never
>>> finishes resulting in an endless loop.
>>
>> Only i915_busy can get into this failure mode? None of the other users of the iterator?
> 
> Yes, at least as far as I can see.
> 
> The problem is completely i915 specific because it is the only driver (I could find) which protects GEM objects by RCU.
> 
>> Also, the reference counting series makes the fix irrelevant?
> 
> No, that series just helped uncover the issue.
> 
> Sashiko-bot correctly complained that i915 is dropping the new dma-resv reference to early resulting in potential use after free. And I was thinking wait a second when the dma_resv_fini() is called to early in the existing code then the dma_fence references are dropped to early as well... so that is an pre-existing bug.
> 
> Before the commit mentioned in the fixes tag the i915_gem_busy_ioctl() could just return nonsense, but after that change it could result in an endless loop and that is problematic.

Where is this sashiko report, associated with which patch I mean?

Is the dma_fence_get_rcu() inside dma_resv_iter_walk_unlocked() what 
triggers the endless restarts? It's been some time since I looked at the 
dma-resv walks.. but fences on the list have reference held so that can 
trigger either via dma_resv_fini() or dma_resv_replace_fences(), right? 
If second is true then how does i915 having the dma-resv containing 
object RCU freed cause the problem?

Regards,

Tvrtko

>>> The solution is to drop the fence references only after the RCU grace
>>> period.
>>>
>>> The fixes tag is not necessary the patch introducing the problem, but the
>>> one making it so worse that we need to address it.
>>>
>>> This problem was pointed out by Sashiko-bot.
>>>
>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>> Fixes: 912ff2ebd695 ("drm/i915: use the new iterator in i915_gem_busy_ioctl v2")
>>> CC: stable@vger.kernel.org
>>> ---
>>>    drivers/gpu/drm/i915/gem/i915_gem_object.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object.c b/drivers/gpu/drm/i915/gem/i915_gem_object.c
>>> index 5172d3982654..9e01f8b2079a 100644
>>> --- a/drivers/gpu/drm/i915/gem/i915_gem_object.c
>>> +++ b/drivers/gpu/drm/i915/gem/i915_gem_object.c
>>> @@ -89,6 +89,7 @@ struct drm_i915_gem_object *i915_gem_object_alloc(void)
>>>      void i915_gem_object_free(struct drm_i915_gem_object *obj)
>>>    {
>>> +    dma_resv_fini(&obj->base._resv);
>>>        return kmem_cache_free(slab_objects, obj);
>>>    }
>>>    @@ -144,7 +145,6 @@ void __i915_gem_object_fini(struct drm_i915_gem_object *obj)
>>>    {
>>>        mutex_destroy(&obj->mm.get_page.lock);
>>>        mutex_destroy(&obj->mm.get_dma_page.lock);
>>> -    dma_resv_fini(&obj->base._resv);
>>>    }
>>>      /**
>>
> 

