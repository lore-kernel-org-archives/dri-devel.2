Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C92DFFF8868
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 13:45:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20CCA10EC94;
	Tue, 28 Apr 2026 13:45:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="kz+CYTnU";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77A2410E0D7
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 13:45:55 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-43d03db7f87so7821714f8f.3
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 06:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1777383954; x=1777988754; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2SyhFOLFL2dAJcka0XiLX/PMkANIMETJaY0FeR170e4=;
 b=kz+CYTnU0S1Rmob/cMXUqMcZ26pz7pz8GC/90nGGNc34K63SBjtsrKV/VktlddCjG/
 MXihyJL+32Mi3NvGgU3c4D1jKN+uBoo/cn20JXcX+51Fp0+gdpLG2/C7udOoOYYd2WHm
 oPEKXnM6U4MpFEJn98860zzA1HI5/psuZzOhH5kQCNq0iwFYFZXoLH82qY+1t4On6Ak+
 p31e3mmeQojNkEV5bt1S6UnDQikC+wTXA4LpCjfHAZj9l4yYKu3GXo4Ai/XHyOqBll8G
 6G3ks5ZQeWR1PfbLP+on6Y7oouFz51RyhwKB8EG2DxS44GwBk80Plylm7jlvh1tl5DiO
 ButA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777383954; x=1777988754;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2SyhFOLFL2dAJcka0XiLX/PMkANIMETJaY0FeR170e4=;
 b=WQ5+eRm8zL2xytksfivd82Q+RujXlan+f0IuYzu6mzPHhOJOBrJHK0rTMu+K94vQq1
 c2Wo+AAkt4oCqYEx97/fxdnuziyghrU0fz4u9RrOXUnjTGCIDIo6kbroGuXqvqnR/TzG
 PAz5CFoea8SqgKDCNOkzr1FiPeu2TM9G0u1ZTs6uTXPNf1Iopl15ifhQ0iYvtylrG7Mz
 ymKY/9Q0T1sXAbCFzKc84Y4dquC5ZFufvl+qqggf5AZO5sD2dH/CaF5VwXVd2Bw9j/H3
 eB2lyt09Ddk0C07CYF+4WatCCERDqpVceIFj16KL1hwaRKUWsOwkDxK0XSfO6Qq12h7m
 tb0A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9iM/3HinSmquXoxTqpqfzh8KYHrxMtBnM+ZYQGGvE+G7SQ5pMTaA7pQYAZmjNuAXR7BQnVasu+ujA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YygBwSYy4jnsZA8ExtPr3ynQlke6t8B+xZNQioAVE97BEQ9IMmS
 b+scdMMpJSmlQeye74SorPSpsKipD2mxQ1jmGxAPibJUR8P3Osp4SJM/BAmzhRvMErI=
X-Gm-Gg: AeBDieuVmO0JfTGOSnGXEGlgW3b+OhaGOo7DJjVVuUYeT3eSIkXPvdxVCyKm2voE4xi
 P09Q3UNTYEB8XB87lSvB0skYsYa5eJRIYygNAcEQ1TRG1mDAWcWHd2UZF1JxV+2yjETkm4KCz/B
 CcSBoXQQvUynHkA77eqZEN9caCyjhRNnTcr1bpxycGvGjmngMxpsEyT9eZJ1h6YoTa7PoWW0rp0
 2ONpMoppnOdNvz6Pq+bnB0Z/WoMggy9gtrlAGXyJHoNCCfev2TqwZgD7ZYy9eNb2I3bhkagjm1E
 WggX3PCTW2GXrb1Nd2+kxsCY/Frre2SNE0WAHVj8JWY3Bk7pjbDwmIu/TqgnejRV6WjX4WTNCxF
 MDgSyGMNVn93P0ALIGvWPJrWBO7ihA6gXHPljfRIQR0zhtKJv8S0cBT+Ej6coXdsZo2PV0DEE0O
 IEiyBN87S3SO/PL2lsMb43xGmT7aG/EK1cryjkopmDNXccjzgxvgBe19b3D7zd96wlCQ==
X-Received: by 2002:a05:6000:2308:b0:43d:50c:6f18 with SMTP id
 ffacd0b85a97d-44647dcf11amr5876815f8f.11.1777383953650; 
 Tue, 28 Apr 2026 06:45:53 -0700 (PDT)
Received: from [192.168.0.101] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4463cb59ebasm6516034f8f.8.2026.04.28.06.45.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Apr 2026 06:45:53 -0700 (PDT)
Message-ID: <5bd5ed0a-fef2-4bd4-b7a0-d263bcfb1c7f@ursulin.net>
Date: Tue, 28 Apr 2026 14:45:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/ttm: Issue direct reclaim at beneficial_order
To: Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Carlos Santa <carlos.santa@intel.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Daniel Colascione <dancol@dancol.org>
References: <20260421012608.1474950-1-matthew.brost@intel.com>
 <20260421012608.1474950-2-matthew.brost@intel.com>
 <30c84c41-192c-44ae-a614-2b9951c55727@ursulin.net>
 <d7dda563-280f-4126-a822-a3d43ce5048e@amd.com>
 <aekygVvRz7mu+elE@gsse-cloud1.jf.intel.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <aekygVvRz7mu+elE@gsse-cloud1.jf.intel.com>
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


On 22/04/2026 21:41, Matthew Brost wrote:
> On Wed, Apr 22, 2026 at 09:41:54AM +0200, Christian König wrote:
>> On 4/22/26 09:32, Tvrtko Ursulin wrote:
>>>
>>> On 21/04/2026 02:26, Matthew Brost wrote:
>>>> Triggering kswap at an order higher than beneficial_order makes little
>>>> sense, as the driver has already indicated the optimal order at which
>>>> reclaim is effective. Similarly, issuing direct reclaim or triggering
>>>> kswap at a lower order than beneficial_order is ineffective, since the
>>>> driver does not benefit from reclaiming lower-order pages.
>>>>
>>>> As a result, direct reclaim should only be issued with __GFP_NORETRY at
>>>> exactly beneficial_order, or as a fallback, direct reclaim without
>>>> __GFP_NORETRY at order 0 when failure is not an option.
>>>>
>>>> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>>>> Cc: Carlos Santa <carlos.santa@intel.com>
>>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>> Cc: Huang Rui <ray.huang@amd.com>
>>>> Cc: Matthew Auld <matthew.auld@intel.com>
>>>> Cc: Matthew Brost <matthew.brost@intel.com>
>>>> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>>>> Cc: Maxime Ripard <mripard@kernel.org>
>>>> Cc: Thomas Zimmermann <tzimmermann@suse.de>
>>>> Cc: David Airlie <airlied@gmail.com>
>>>> Cc: Simona Vetter <simona@ffwll.ch>
>>>> CC: dri-devel@lists.freedesktop.org
>>>> Cc: Daniel Colascione <dancol@dancol.org>
>>>> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
>>>> ---
>>>>    drivers/gpu/drm/ttm/ttm_pool.c | 4 ++--
>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
>>>> index 26a3689e5fd9..8425dbcc6c68 100644
>>>> --- a/drivers/gpu/drm/ttm/ttm_pool.c
>>>> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
>>>> @@ -165,8 +165,8 @@ static struct page *ttm_pool_alloc_page(struct ttm_pool *pool, gfp_t gfp_flags,
>>>>         * Do not add latency to the allocation path for allocations orders
>>>>         * device tolds us do not bring them additional performance gains.
>>>>         */
>>>> -    if (beneficial_order && order > beneficial_order)
>>>> -        gfp_flags &= ~__GFP_DIRECT_RECLAIM;
>>>> +    if (order && beneficial_order && order != beneficial_order)
>>>> +        gfp_flags &= ~__GFP_RECLAIM;
>>>>          if (!ttm_pool_uses_dma_alloc(pool)) {
>>>>            p = alloc_pages_node(pool->nid, gfp_flags, order);
>>>
>>> I missed this conversation so don't know if this was discussed -
> 
> I meant to CC you here, but missed including you.
> 
>>> having less of 64k pages is not a concern? I mean slightly higher TLB pressure etc on hardware which supports this PTE size.
>>
>> At least for AMD GPUs 64k doesn't matter at all.
>>
> 
> Same on Intel GPUs for system memory mappings - it is either 4k or 2M
> GPU pages. VRAM can we 64k pages but that isn't involved here.
> 
>> There was a large push from the Windows side to use that size, but we have more than enough evidence to prove that this size is actually completely nonsense for almost all use cases.
>>
>> I have no idea how we ended up with that in the first place.
>>
>> It could be that there is still HW out there which can only handle that size, but in that case such HW should just set beneficial_order to 64k.
>>
> 
> Or we move to a table config if we find drivers have multiple
> beneficial_orders.

Or a bitmask of direct reclaim orders?

I am not saying it is required to be "smarter" than this patch does it, 
for AMD and Intel apparently isn't, but for other drivers I don't know 
so it does need looking into.

Regards,

Tvrtko

> 
>>> Also, does clearing __GFP_RECLAIM disable compaction completely and is that wanted?
>>
>> Oh good point, most likely not.
>>
> 
> Without completely reverse engineering the core MM, I'm not sure here.
> 
> I just read the kernel doc for __GFP_KSWAPD_RECLAIM [1] and this to
> indicate if this is clear compaction won't be entered.
> 
> Matt
> 
> [1] https://elixir.bootlin.com/linux/v7.0/source/include/linux/gfp_types.h#L198
>   
>> Regards,
>> Christian.
>>
>>>
>>> Regards,
>>>
>>> Tvrtko
>>>
>>

