Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4612105F7AE
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 14:11:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2330C10E120;
	Fri, 13 Mar 2026 14:11:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="krCYkfF/";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A706510E120
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 14:11:33 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso20193065e9.3
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 07:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1773411092; x=1774015892; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LafAaegGRU7i9rzjjUW1sBiK+ZDukEKzI9QIgeF8Beg=;
 b=krCYkfF/NwH8BN1ylARstu55OZfxucTKreW0efPHpJi+1dlSADO6WUWVctqBh1YtxY
 y+tVfzyO6EoxpnggW7kSRNXQR1O1yJ5yvXa4A/IhWYzWOi7+T9j3zkUeQeLhiasEpcuQ
 I+DrQL6jjyQp/d3BuHt5lu50PRMyfbt8VFwJRMENs948UqWOaWPfMeRMteKULCoEvue1
 J+t+R0To5Si1gmgJwlbOXodz6Gzx496K5JXG3mrpLSg0Xu4adhYj9Dz4r6BEZkVH0446
 zmOG6ZRupMMZdDHh/2I9vSJNoyuRNqlpo21LN17wj6i0WMvVg/JQwceJ6ntOSSiTHdn5
 Ir3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773411092; x=1774015892;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LafAaegGRU7i9rzjjUW1sBiK+ZDukEKzI9QIgeF8Beg=;
 b=qEVPGROtqOcjLxk3RMOLShHAjXyCF+H4M1YhzA+xF9wA9KEOR6Lm8kx+IpJCA2nOm2
 x1Hx5CNWCNise9fWSv71UwP3JznTD8jdNQu/bjFYK93G9hU6yirBKvPzeJCWokxB+X4R
 tIcmjmx1eMvSqa08WBj4HiFRbFYCx+MpcdEXNwC8ZZLruaEHd9jHNDO2K5M4FLzycIbj
 K5z3/0DFUUT0wd66zXBYve+oeaRrK9yIsmD5AvsUOx/8cPFKOSF32P0a/Xo21G7H2y5d
 8XiW5cJDyzrvDzBRA2GcnRdD14jtblv0RsoZDigHXqjI+ONauRZGysW7BNnM9no/meve
 +CVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6C26bK+BjRAuMczvX3hLz9cO8Zew9CPTvx948uZvtYfwVQejXyySEIWgOxpQ4ZFc8KBqDmdqybWM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxLfmaqUOAUF/C86FM3o+9W41nAliCEFBPeBUOHHG/nlLy8xMKe
 y0cfgLgVHspoz94ua2cBcTeOTZRqwrSAXg9ymeIkBBaRWIAiUZw9O3uwFLeZdAIr+1uVL/jW+Ut
 yCb5ArYY=
X-Gm-Gg: ATEYQzyv26psCrAlMY8YR0GwGB1GVvWP5UOTZK+0wns00eGyGd0yUDgOuH3CcI0uL5g
 kZndQwhyd9+2ofPM6sSoj1NYg7g/psmvwodWmCpnW6bZfZoh/tAVFgX1pSkExdpmSix0mWdlaH4
 nlS1A7Da+9uedoXAHsup8C0LmZJ8e0DzSuHz41i196rkVtOstIa0fbRvPikLuDdXTrsMXkDWnIb
 38nkShlwMty0JbAgnK+JYsQ7R2OKAIJ7Vgkjv+EpCnSpO9vbi51ZGsncBXY6wMdEDjB9+VUqEZ/
 EPx2WloTOY4LbDNiiuV9OHEqIAQphlS+m4wC32w0rOdvPDgpsjA4OkSswZS4uJFBx61S7Px22Dp
 YaCgvxXQQVZC5/Vj+C+uX093dU8krgzqB2HkycJYaK9BSHtJAWPU67lt71l0NFLuz42oiqRLOx9
 W1rG2XisJk8z5/ThMXPvDBqpXvoQ2P8fl1MJSKGIUwfYag
X-Received: by 2002:a05:600c:5247:b0:485:3c8f:e4c5 with SMTP id
 5b1f17b1804b1-485566fcaaemr55645355e9.17.1773411091876; 
 Fri, 13 Mar 2026 07:11:31 -0700 (PDT)
Received: from [192.168.0.101] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48557a732cesm21788415e9.12.2026.03.13.07.11.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 07:11:31 -0700 (PDT)
Message-ID: <cf522bc4-09ef-4e19-afc4-2c8a9d8a1abc@ursulin.net>
Date: Fri, 13 Mar 2026 14:11:30 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/6] drm/ttm: Use common ancestor of evictor and
 evictee as limit pool
To: Natalie Vock <natalie.vock@gmx.de>, Maarten Lankhorst <dev@lankhorst.se>, 
 Maxime Ripard <mripard@kernel.org>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Christian Koenig <christian.koenig@amd.com>,
 Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20260313-dmemcg-aggressive-protect-v6-0-7c71cc1492db@gmx.de>
 <20260313-dmemcg-aggressive-protect-v6-6-7c71cc1492db@gmx.de>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260313-dmemcg-aggressive-protect-v6-6-7c71cc1492db@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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


On 13/03/2026 11:40, Natalie Vock wrote:
> When checking whether to skip certain buffers because they're protected
> by dmem.low, we're checking the effective protection of the evictee's
> cgroup, but depending on how the evictor's cgroup relates to the
> evictee's, the semantics of effective protection values change.
> 
> When testing against cgroups from different subtrees, page_counter's
> recursive protection propagates memory protection afforded to a parent
> down to the child cgroups, even if the children were not explicitly
> protected. This prevents cgroups whose parents were afforded no
> protection from stealing memory from cgroups whose parents were afforded
> more protection, without users having to explicitly propagate this
> protection.
> 
> However, if we always calculate protection from the root cgroup, this
> breaks prioritization of sibling cgroups: If one cgroup was explicitly
> protected and its siblings were not, the protected cgroup should get
> higher priority, i.e. the protected cgroup should be able to steal from
> unprotected siblings. This only works if we restrict the protection
> calculation to the subtree shared by evictor and evictee.
> 
> Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
> ---
>   drivers/gpu/drm/ttm/ttm_bo.c | 43 ++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 40 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index 7300b91b77dd3..df4f4633a3a53 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -628,11 +628,48 @@ static s64 ttm_bo_evict_cb(struct ttm_lru_walk *walk, struct ttm_buffer_object *
>   {
>   	struct ttm_bo_evict_walk *evict_walk =
>   		container_of(walk, typeof(*evict_walk), walk);
> +	struct dmem_cgroup_pool_state *limit_pool, *ancestor = NULL;
> +	bool evict_valuable;
>   	s64 lret;
>   
> -	if (!dmem_cgroup_state_evict_valuable(evict_walk->alloc_state->limit_pool,
> -					      bo->resource->css, evict_walk->try_low,
> -					      &evict_walk->hit_low))
> +	/*
> +	 * If may_try_low is not set, then we're trying to evict unprotected
> +	 * buffers in favor of a protected allocation for charge_pool. Explicitly skip
> +	 * buffers belonging to the same cgroup here - that cgroup is definitely protected,
> +	 * even though dmem_cgroup_state_evict_valuable would allow the eviction because a
> +	 * cgroup is always allowed to evict from itself even if it is protected.
> +	 */
> +	if (!evict_walk->alloc_state->may_try_low &&
> +			bo->resource->css == evict_walk->alloc_state->charge_pool)
> +		return 0;

Hm.. should this hunk go into the previous patch?

> +
> +	limit_pool = evict_walk->alloc_state->limit_pool;
> +	/*
> +	 * If there is no explicit limit pool, find the root of the shared subtree between
> +	 * evictor and evictee. This is important so that recursive protection rules can
> +	 * apply properly: Recursive protection distributes cgroup protection afforded
> +	 * to a parent cgroup but not used explicitly by a child cgroup between all child
> +	 * cgroups (see docs of effective_protection in mm/page_counter.c). However, when
> +	 * direct siblings compete for memory, siblings that were explicitly protected
> +	 * should get prioritized over siblings that weren't. This only happens correctly
> +	 * when the root of the shared subtree is passed to
> +	 * dmem_cgroup_state_evict_valuable. Otherwise, the effective-protection
> +	 * calculation cannot distinguish direct siblings from unrelated subtrees and the
> +	 * calculated protection ends up wrong.
> +	 */
> +	if (!limit_pool) {
> +		ancestor = dmem_cgroup_get_common_ancestor(bo->resource->css,
> +							   evict_walk->alloc_state->charge_pool);
> +		limit_pool = ancestor;
> +	}
> +
> +	evict_valuable = dmem_cgroup_state_evict_valuable(limit_pool, bo->resource->css,
> +							  evict_walk->try_low,
> +							  &evict_walk->hit_low);
> +	if (ancestor)
> +		dmem_cgroup_pool_state_put(ancestor);
> +
> +	if (!evict_valuable)

This part is probably better reviewed by someone more familiar with the 
dmem controller. One question I have though is whether this patch is 
independent from the rest of the series or it really makes sense for it 
to be last?

Regards,

Tvrtko

>   		return 0;
>   
>   	if (bo->pin_count || !bo->bdev->funcs->eviction_valuable(bo, evict_walk->place))
> 

