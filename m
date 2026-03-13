Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2422105F7A6
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 12:53:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0518F10EBDB;
	Fri, 13 Mar 2026 12:53:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="itxHp5Kl";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE28910EBDB
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 12:53:05 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4852ff06541so22099095e9.2
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 05:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1773406384; x=1774011184; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wUAXZOch+j8GBQV9ng35Tf6PnvC1xmx52FcG64eQxFc=;
 b=itxHp5Kly6LpxTHrnGreTPofYrrfGByMiASHH5t/gJOV4PCv8GWhPWuZctqc50kPvm
 H9YgidX+KbjfsVerl6+x83YwSLxasKAyJ8+HNWaxFI9cUgH1mKojDulurP8VvKvJoMRT
 Q/RdWwwn/CD5picxHeNDpKoT6qZLqF6stDw554u4LQvsEmcLPMz6nN7DWqrRX9d2kSbM
 BGQ4tPbGV3oKW75eKrmcGe7srMRBAFmEF5rpJwHvAx86i9s8pgnLM8GP/VdLc2DKCpIJ
 f9EvzyyTNHXciU3ldbaWxIP7a3hI5TCXFiwhhwsBAkSaQxM6Ezdln31T2EqJqt0KbSiE
 Kq2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773406384; x=1774011184;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wUAXZOch+j8GBQV9ng35Tf6PnvC1xmx52FcG64eQxFc=;
 b=egEdAFKdcwt/nieZCiymHVxjwBG92mcZEH2kJte9X1qmZwTlzXAl38GNL4iMON8FHf
 oY9wqp5g86vPiEIG9pJWJZU9W2PzDked76MUwKjz0iTaz1ewM8IGOguf1Wlb8V5P4oBV
 ZFe+xAYUXe1LYaWa6DRIHHVMJPo8PD6dg2VCwj5pNkDB4x2+DZfxIr0jajR5/uOhQdKU
 nuyg1M+qT0rQ3ZEPksU1Ba75DjvSCsuFIOU5KXLBkewI0eGI69R7OQYViMwDSKBrZJ31
 VnXITGZ1DuhXKuvYb0LlEEfnEHjTzbTHN5DMZQ8xEdM3WYO6QemxUiMTh2QOUYeF8I1H
 h1ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCV69CKd7AXCqOQhL+UQiPIuhUDSb5+/KLSDCjp360JgjFf7dwRHo98/0yq+WxSu0EqIe8MUP/iiGxw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzmLE7/gtaB4Gr5aIuQjyUnxxWlIR93sH6JfdRwrVIMnNAMt71q
 slRkHOBniAHgQhomT04+Ic8nl0sMJXnaks+rbs9R+44hMY0AE3/nfzsGtPDmfWern8w=
X-Gm-Gg: ATEYQzy1d001OUUoVylOUk2yNJ7fA/63dRHmzy9TxhpjRqTNcHzqciA8kZOrlPabW5z
 fyc4raYsy94heK8TTHPYTaOFwDI/G/9M9+7hrbZWQYPeNPqnydnF5wGootHDKOy6izfBgyPYY+W
 r9rhwtIdufgaBOjQymvDZdETLDszOcbwp3dybOiIZ25HC1e/FWP724Tfby6GIbdsXM8KrE8u9Tz
 htTHnWoegKBrz/AL7++M7u4grfNjBbmd6Yf9Lbqn5Qo79rDK7mmf2fxG8TDXi6KdimTst7OfxSB
 L/E/6dAYvIvpFOVXX0Iv9Y1RM/ZOsUob6azlhye52ldNLq28LNy60nRRU/EOcYoTBz9HdnFscBv
 f0WByicEjOhY3whv/EodV3+JetappR/Ioc/8yCUuQdFOKmSTdIlnpHIuz3x0nDonYsHLu/aYzHG
 oNnF0Yzt1S0R9zstRKRKf8XNncWD5yxbf0d5GI7SJ7Gph7
X-Received: by 2002:a05:600c:4e15:b0:485:3f1c:d887 with SMTP id
 5b1f17b1804b1-4855670e6e8mr48910125e9.26.1773406383716; 
 Fri, 13 Mar 2026 05:53:03 -0700 (PDT)
Received: from [192.168.0.101] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe2273d9sm19741899f8f.34.2026.03.13.05.53.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 05:53:03 -0700 (PDT)
Message-ID: <fd77dce5-39f9-446e-b78e-3304ca3de4ac@ursulin.net>
Date: Fri, 13 Mar 2026 12:53:02 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/6] drm/ttm: Split cgroup charge and resource
 allocation
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
 <20260313-dmemcg-aggressive-protect-v6-4-7c71cc1492db@gmx.de>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260313-dmemcg-aggressive-protect-v6-4-7c71cc1492db@gmx.de>
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
> Coupling resource allocation and cgroup charging is racy when charging
> succeeds, but subsequent resource allocation fails. Certain eviction
> decisions are made on the basis of whether the allocating cgroup is
> protected, i.e. within its min/low limits, but with the charge being
> tied to resource allocation (and uncharged when the resource allocation
> fails), this check is done at a point where the allocation is not actually
> charged to the cgroup.
> 
> This is subtly wrong if the allocation were to cause the cgroup to exceed
> the min/low protection, but it's even more wrong if the same cgroup tries
> allocating multiple buffers concurrently: In this case, the min/low
> protection may pass for all allocation attempts when the real min/low
> protection covers only some, or potentially none of the allocated
> buffers.
> 
> Instead, charge the allocation to the cgroup once and keep the charge
> for as long as we try to allocate a ttm_resource, and only undo the charge
> if allocating the resource is ultimately unsuccessful and we move on to
> a different ttm_place.
> 
> Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
> ---
>   drivers/gpu/drm/ttm/ttm_bo.c       | 66 ++++++++++++++++++++++++++------------
>   drivers/gpu/drm/ttm/ttm_resource.c | 48 +++++++++++++++++++--------
>   include/drm/ttm/ttm_resource.h     |  6 +++-
>   3 files changed, 85 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index 5cca0d6edbaf6..4adc9b80cba4a 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -490,8 +490,12 @@ int ttm_bo_evict_first(struct ttm_device *bdev, struct ttm_resource_manager *man
>   }
>   
>   struct ttm_bo_alloc_state {
> +	/** @charge_pool: The memory pool the resource is charged to */
> +	struct dmem_cgroup_pool_state *charge_pool;
>   	/** @limit_pool: Which pool limit we should test against */
>   	struct dmem_cgroup_pool_state *limit_pool;
> +	/** @in_evict: Whether we are currently evicting buffers */
> +	bool in_evict;
>   };
>   
>   /**
> @@ -520,28 +524,39 @@ static int ttm_bo_alloc_at_place(struct ttm_buffer_object *bo,
>   	bool may_evict;
>   	int ret;
>   
> -	may_evict = force_space && place->mem_type != TTM_PL_SYSTEM;
> -
> -	ret = ttm_resource_alloc(bo, place, res,
> -				 force_space ? &alloc_state->limit_pool : NULL);
> +	may_evict = !alloc_state->in_evict && force_space &&
> +		    place->mem_type != TTM_PL_SYSTEM;
> +	if (!alloc_state->charge_pool) {
> +		ret = ttm_resource_try_charge(bo, place, &alloc_state->charge_pool,
> +					      force_space ? &alloc_state->limit_pool
> +							  : NULL);
> +		if (ret) {
> +			/*
> +			 * -EAGAIN means the charge failed, which we treat
> +			 * like an allocation failure. Therefore, return an
> +			 * error code indicating the allocation failed -
> +			 * either -EBUSY if the allocation should be
> +			 * retried with eviction, or -ENOSPC if there should
> +			 * be no second attempt.
> +			 */
> +			if (ret == -EAGAIN)
> +				ret = may_evict ? -EBUSY : -ENOSPC;
> +			return ret;
> +		}
> +	}
>   
> +	ret = ttm_resource_alloc(bo, place, res, alloc_state->charge_pool);
>   	if (ret) {
> -		/*
> -		 * -EAGAIN means the charge failed, which we treat like an
> -		 * allocation failure. Therefore, return an error code indicating
> -		 * the allocation failed - either -EBUSY if the allocation should
> -		 * be retried with eviction, or -ENOSPC if there should be no second
> -		 * attempt.
> -		 */
> -		if (ret == -EAGAIN)
> -			return may_evict ? -EBUSY : -ENOSPC;
> -
>   		if (ret == -ENOSPC && may_evict)
> -			return -EBUSY;
> -
> +			ret = -EBUSY;
>   		return ret;
>   	}
>   
> +	/*
> +	 * Ownership of charge_pool has been transferred to the TTM resource,
> +	 * don't make the caller think we still hold a reference to it.
> +	 */
> +	alloc_state->charge_pool = NULL;
>   	return 0;
>   }
>   
> @@ -596,8 +611,9 @@ static s64 ttm_bo_evict_cb(struct ttm_lru_walk *walk, struct ttm_buffer_object *
>   
>   	evict_walk->evicted++;
>   	if (evict_walk->res)
> -		lret = ttm_resource_alloc(evict_walk->evictor, evict_walk->place,
> -					  evict_walk->res, NULL);
> +		lret = ttm_bo_alloc_at_place(evict_walk->evictor, evict_walk->place,
> +					     walk->arg.ctx, false, evict_walk->res,
> +					     evict_walk->alloc_state);

Oh I am glad this worked out. I will not go as far to say TTM eviction 
logic is now easy to follow but at least the new state machine logic is 
consolidated. Anyway, I went back and forth many many times and it all 
looks good to me.

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Btw have you looked at the TTM kunit tests? Does any cover the new paths 
or it would make sense to add some coverage with this series, or as a 
follow up?

Regards,

Tvrtko

>   	if (lret == 0)
>   		return 1;
>   out:
> @@ -636,6 +652,8 @@ static int ttm_bo_evict_alloc(struct ttm_device *bdev,
>   	};
>   	s64 lret;
>   
> +	state->in_evict = true;
> +
>   	evict_walk.walk.arg.trylock_only = true;
>   	lret = ttm_lru_walk_for_evict(&evict_walk.walk, bdev, man, 1);
>   
> @@ -666,6 +684,7 @@ static int ttm_bo_evict_alloc(struct ttm_device *bdev,
>   		goto retry;
>   	}
>   out:
> +	state->in_evict = false;
>   	if (lret < 0)
>   		return lret;
>   	if (lret == 0)
> @@ -798,6 +817,7 @@ static int ttm_bo_alloc_resource(struct ttm_buffer_object *bo,
>   				res, &alloc_state);
>   
>   		if (ret == -ENOSPC) {
> +			dmem_cgroup_uncharge(alloc_state.charge_pool, bo->base.size);
>   			dmem_cgroup_pool_state_put(alloc_state.limit_pool);
>   			continue;
>   		} else if (ret == -EBUSY) {
> @@ -806,11 +826,15 @@ static int ttm_bo_alloc_resource(struct ttm_buffer_object *bo,
>   
>   			dmem_cgroup_pool_state_put(alloc_state.limit_pool);
>   
> -			if (ret == -EBUSY)
> -				continue;
> -			else if (ret)
> +			if (ret) {
> +				dmem_cgroup_uncharge(alloc_state.charge_pool,
> +						bo->base.size);
> +				if (ret == -EBUSY)
> +					continue;
>   				return ret;
> +			}
>   		} else if (ret) {
> +			dmem_cgroup_uncharge(alloc_state.charge_pool, bo->base.size);
>   			dmem_cgroup_pool_state_put(alloc_state.limit_pool);
>   			return ret;
>   		}
> diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ttm/ttm_resource.c
> index 192fca24f37e4..a8a836f6e376a 100644
> --- a/drivers/gpu/drm/ttm/ttm_resource.c
> +++ b/drivers/gpu/drm/ttm/ttm_resource.c
> @@ -373,30 +373,52 @@ void ttm_resource_fini(struct ttm_resource_manager *man,
>   }
>   EXPORT_SYMBOL(ttm_resource_fini);
>   
> +/**
> + * ttm_resource_try_charge - charge a resource manager's cgroup pool
> + * @bo: buffer for which an allocation should be charged
> + * @place: where the allocation is attempted to be placed
> + * @ret_pool: on charge success, the pool that was charged
> + * @ret_limit_pool: on charge failure, the pool responsible for the failure
> + *
> + * Should be used to charge cgroups before attempting resource allocation.
> + * When charging succeeds, the value of ret_pool should be passed to
> + * ttm_resource_alloc.
> + *
> + * Returns: 0 on charge success, negative errno on failure.
> + */
> +int ttm_resource_try_charge(struct ttm_buffer_object *bo,
> +			    const struct ttm_place *place,
> +			    struct dmem_cgroup_pool_state **ret_pool,
> +			    struct dmem_cgroup_pool_state **ret_limit_pool)
> +{
> +	struct ttm_resource_manager *man =
> +		ttm_manager_type(bo->bdev, place->mem_type);
> +
> +	if (!man->cg) {
> +		*ret_pool = NULL;
> +		if (ret_limit_pool)
> +			*ret_limit_pool = NULL;
> +		return 0;
> +	}
> +
> +	return dmem_cgroup_try_charge(man->cg, bo->base.size, ret_pool,
> +				      ret_limit_pool);
> +}
> +
>   int ttm_resource_alloc(struct ttm_buffer_object *bo,
>   		       const struct ttm_place *place,
>   		       struct ttm_resource **res_ptr,
> -		       struct dmem_cgroup_pool_state **ret_limit_pool)
> +		       struct dmem_cgroup_pool_state *charge_pool)
>   {
>   	struct ttm_resource_manager *man =
>   		ttm_manager_type(bo->bdev, place->mem_type);
> -	struct dmem_cgroup_pool_state *pool = NULL;
>   	int ret;
>   
> -	if (man->cg) {
> -		ret = dmem_cgroup_try_charge(man->cg, bo->base.size, &pool, ret_limit_pool);
> -		if (ret)
> -			return ret;
> -	}
> -
>   	ret = man->func->alloc(man, bo, place, res_ptr);
> -	if (ret) {
> -		if (pool)
> -			dmem_cgroup_uncharge(pool, bo->base.size);
> +	if (ret)
>   		return ret;
> -	}
>   
> -	(*res_ptr)->css = pool;
> +	(*res_ptr)->css = charge_pool;
>   
>   	spin_lock(&bo->bdev->lru_lock);
>   	ttm_resource_add_bulk_move(*res_ptr, bo);
> diff --git a/include/drm/ttm/ttm_resource.h b/include/drm/ttm/ttm_resource.h
> index 33e80f30b8b82..549b5b796884d 100644
> --- a/include/drm/ttm/ttm_resource.h
> +++ b/include/drm/ttm/ttm_resource.h
> @@ -456,10 +456,14 @@ void ttm_resource_init(struct ttm_buffer_object *bo,
>   void ttm_resource_fini(struct ttm_resource_manager *man,
>   		       struct ttm_resource *res);
>   
> +int ttm_resource_try_charge(struct ttm_buffer_object *bo,
> +			    const struct ttm_place *place,
> +			    struct dmem_cgroup_pool_state **ret_pool,
> +			    struct dmem_cgroup_pool_state **ret_limit_pool);
>   int ttm_resource_alloc(struct ttm_buffer_object *bo,
>   		       const struct ttm_place *place,
>   		       struct ttm_resource **res,
> -		       struct dmem_cgroup_pool_state **ret_limit_pool);
> +		       struct dmem_cgroup_pool_state *charge_pool);
>   void ttm_resource_free(struct ttm_buffer_object *bo, struct ttm_resource **res);
>   bool ttm_resource_intersects(struct ttm_device *bdev,
>   			     struct ttm_resource *res,
> 

