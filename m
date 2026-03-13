Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E6E105F7AC
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 13:29:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33CAC10EC4F;
	Fri, 13 Mar 2026 13:29:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="sl6LZD5D";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07EA710EC4F
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 13:29:11 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso32935395e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 06:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1773408549; x=1774013349; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JRHdwoAhh6Z6VJ1IOXt8YpVwRbA24oij+up+nK+z+qQ=;
 b=sl6LZD5D2VCO9X93n/nCDQBCgyx2R/Fz9NIz3lo/nQq3XHoO4Lh7SsKe8ctpvexFCb
 BilcxhWvC0coOPWUCJUooWpTeQr58KqxWYkJlBVM39X/L0UnTS8DYaTMefD7qOLbdqFy
 Ur0KgMsJqrD4LKbztg2m6CkVL85nDqzfEljA9cU7L5Tf8n9yc1VWp48vuv0AO2ya5wUd
 qf+makoC53vKyHoaaDO4tGQmgNGrNczbLaYMY8LGOX+xUtSIqzX/RxsUbqiiBxuDk5TO
 LjkFVvYtyHgsdXxCPXYAAPJzdTVZzBdWQp1I/vwEZdoLFDzwznUlrddudn1dODdJfevF
 ns+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408549; x=1774013349;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JRHdwoAhh6Z6VJ1IOXt8YpVwRbA24oij+up+nK+z+qQ=;
 b=qLS9nHYJV17Zc4w7ndN6pkX9nOzt/p8i9TqNI1zZtJrLA4jNusxIRVvOYMxRFyjllp
 ER60YUbjaHR7wSDv+NUvAgTo4PDF/oRd3KYZeGbQNWoQMUSI6g6FTeWNMT7YSKUnE8tL
 uZI8/wmadt/cT5wM2wUOQRY+pPJN9AlzqyTFKqgJhANL3S18BXb4gSb7I81aSLEaUZ5N
 do6YOssIWgZSGM+HycaE6tvz7E5M28ZCAVPRN5kAfWOVC7aCPn2tt1w48Z7nxKkzO+vJ
 UAtrnHIMbLHoTc9LRthY0BaY3IYMu7hmxRfCc8xsnIk+h3l77eSCgAnPiqG2NE//C2zJ
 bS3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNW1gZ2t3v0HTCFxyAJNpasZ6SRF13fxTpWAUHFMx/M5ZVRxR7yYB7BBlMst2rv7XezK9bBgT+ESc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwzHNW7ckLzfVPMOVcuPx5xG7wbEVpBEubtn8D5RNhGgCXSh+pz
 an9808pc6zYKUxHSLSFlEIt7TVt8fPnsl7HpwS96QRtONwloCzZUnsF6GdX/cYrJfW4=
X-Gm-Gg: ATEYQzx8YMBHtfbGlcQynwOIZ0RxMLSa2G4Vs8X5tVUTdivaFc4Ht9WIBIx3gvqrBbA
 3p4xBkINXJHxOMYjhhkhjpwW8W2xBiLoEaZJlLZcufzfXravPJylHJKEK3bSNF/oyTH7y/3hM4B
 7S6Zt0jnLTrHAC6Y2oHh7uX0tk+yczb239fba8gLbAHn+LV4QAw3cKhTYpNHYDa59tZg1mjkLvc
 EMJLjXuELS7IsjAdrVGfzqWZv41kkAAs0CJ1G+xCV8MimSjPSln+pmF6FtMlIPdhwL5i/vmtQHT
 mSMeqHviSkdRm644phDRhbvWFLPcbvn1D7qStkUjdVczcIQVqGSO9TaHWEroy/A2GNrEU4qqQnL
 L11JqO1lP29SjxCyYtqtlV/KF8I3djmk4JH3VTjLVYUEeeOprqH2DVgwRYPkeeDB3VoeAyN5/qr
 aqZeGRBai4EgFM9lQswPZOXcYekmPfGpz6z1zjIHk1Wkws
X-Received: by 2002:a05:600c:2295:b0:483:a2b0:d210 with SMTP id
 5b1f17b1804b1-4854f56d693mr91452245e9.7.1773408549051; 
 Fri, 13 Mar 2026 06:29:09 -0700 (PDT)
Received: from [192.168.0.101] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe20bb90sm18046479f8f.19.2026.03.13.06.29.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 06:29:08 -0700 (PDT)
Message-ID: <c1b8d304-09d3-47cf-a314-4a8777b85e6f@ursulin.net>
Date: Fri, 13 Mar 2026 13:29:07 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/6] drm/ttm: Be more aggressive when allocating below
 protection limit
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
 <20260313-dmemcg-aggressive-protect-v6-5-7c71cc1492db@gmx.de>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260313-dmemcg-aggressive-protect-v6-5-7c71cc1492db@gmx.de>
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
> When the cgroup's memory usage is below the low/min limit and allocation
> fails, try evicting some unprotected buffers to make space. Otherwise,
> application buffers may be forced to go into GTT even though usage is
> below the corresponding low/min limit, if other applications filled VRAM
> with their allocations first.
> 
> Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
> ---
>   drivers/gpu/drm/ttm/ttm_bo.c | 51 +++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 48 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index 4adc9b80cba4a..7300b91b77dd3 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -496,6 +496,10 @@ struct ttm_bo_alloc_state {
>   	struct dmem_cgroup_pool_state *limit_pool;
>   	/** @in_evict: Whether we are currently evicting buffers */
>   	bool in_evict;
> +	/** @may_try_low: If only unprotected BOs, i.e. BOs whose cgroup
> +	 *  is exceeding its dmem low/min protection, should be considered for eviction
> +	 */
> +	bool may_try_low;
>   };
>   
>   /**
> @@ -545,6 +549,42 @@ static int ttm_bo_alloc_at_place(struct ttm_buffer_object *bo,
>   		}
>   	}
>   
> +	/*
> +	 * cgroup protection plays a special role in eviction.
> +	 * Conceptually, protection of memory via the dmem cgroup controller
> +	 * entitles the protected cgroup to use a certain amount of memory.
> +	 * There are two types of protection - the 'low' limit is a
> +	 * "best-effort" protection, whereas the 'min' limit provides a hard
> +	 * guarantee that memory within the cgroup's allowance will not be
> +	 * evicted under any circumstance.
> +	 *
> +	 * To faithfully model this concept in TTM, we also need to take cgroup
> +	 * protection into account when allocating. When allocation in one
> +	 * place fails, TTM will default to trying other places first before
> +	 * evicting.
> +	 * If the allocation is covered by dmem cgroup protection, however,
> +	 * this prevents the allocation from using the memory it is "entitled"
> +	 * to. To make sure unprotected allocations cannot push new protected
> +	 * allocations out of places they are "entitled" to use, we should
> +	 * evict buffers not covered by any cgroup protection, if this
> +	 * allocation is covered by cgroup protection.
> +	 *
> +	 * Buffers covered by 'min' protection are a special case - the 'min'
> +	 * limit is a stronger guarantee than 'low', and thus buffers protected
> +	 * by 'low' but not 'min' should also be considered for eviction.
> +	 * Buffers protected by 'min' will never be considered for eviction
> +	 * anyway, so the regular eviction path should be triggered here.
> +	 * Buffers protected by 'low' but not 'min' will take a special
> +	 * eviction path that only evicts buffers covered by neither 'low' or
> +	 * 'min' protections.
> +	 */
> +	if (!alloc_state->in_evict) {
> +		may_evict |= dmem_cgroup_below_min(NULL, alloc_state->charge_pool);
> +		alloc_state->may_try_low = may_evict;
> +
> +		may_evict |= dmem_cgroup_below_low(NULL, alloc_state->charge_pool);

For some value of optimisation you could combine the two calls of 
dmem_cgroup_below_min/low into a single helper which returns both min 
and low, given how it is the only callers, saving a pair of function 
calls and tree traversing calculations. Or.. I am not sure if simply 
exporting dmem_cgroup_calculate_protection() and making it return 
page_counters would be okay, or a copy of them, or a new data structure 
would need to be added.

Anyway, that can be discussed separately. In the meantime this patch 
looks good to me:

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

> +	}
> +
>   	ret = ttm_resource_alloc(bo, place, res, alloc_state->charge_pool);
>   	if (ret) {
>   		if (ret == -ENOSPC && may_evict)
> @@ -657,8 +697,12 @@ static int ttm_bo_evict_alloc(struct ttm_device *bdev,
>   	evict_walk.walk.arg.trylock_only = true;
>   	lret = ttm_lru_walk_for_evict(&evict_walk.walk, bdev, man, 1);
>   
> -	/* One more attempt if we hit low limit? */
> -	if (!lret && evict_walk.hit_low) {
> +	/* If we failed to find enough BOs to evict, but we skipped over
> +	 * some BOs because they were covered by dmem low protection, retry
> +	 * evicting these protected BOs too, except if we're told not to
> +	 * consider protected BOs at all.
> +	 */
> +	if (!lret && evict_walk.hit_low && state->may_try_low) {
>   		evict_walk.try_low = true;
>   		lret = ttm_lru_walk_for_evict(&evict_walk.walk, bdev, man, 1);
>   	}
> @@ -679,7 +723,8 @@ static int ttm_bo_evict_alloc(struct ttm_device *bdev,
>   	} while (!lret && evict_walk.evicted);
>   
>   	/* We hit the low limit? Try once more */
> -	if (!lret && evict_walk.hit_low && !evict_walk.try_low) {
> +	if (!lret && evict_walk.hit_low && !evict_walk.try_low &&
> +			state->may_try_low) {
>   		evict_walk.try_low = true;
>   		goto retry;
>   	}
> 

