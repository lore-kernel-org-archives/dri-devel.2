Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB2DBC4451C
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 19:58:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2486410E3BB;
	Tue, 21 Jul 2026 19:58:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QnAi50m/";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 393E410E3BB
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 19:58:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 986E3601D9;
 Tue, 21 Jul 2026 19:58:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01B501F000E9;
 Tue, 21 Jul 2026 19:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784663931;
 bh=uVEjLx+kGcjg5qCzdkxXzaFMqgBZkt8cP+FhE8Kjqr4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QnAi50m/k9M1LcYIgLI5w/1bt3LWLZuEKN7QTVjwGy6CJoFvKlmvTklRTd+9ZJb4t
 6qtOQ5XwPO71tLolVW0bxzTUsao2NM+oY9N4WIpfWxwsyE9lUTKXrptHF4mLQ7Uluz
 MMKI6//vLU2GTsYc8DAw5rtDG8tVaeBNnq6ZxO6SkZhlws1lwk/x+8oEoYsFyOwW7o
 YI6SQ6K1cbMO02cLNizcLsGNB3ogHjGfb+01/vqLfQ/RsEO/ecsjoa7lMKQQxJhWlC
 Zp83i/Xsluh/hbF+tgL1iO9/lknr5/PsGxZw6Ow0kbc94jCb6DYEdfZt3L1STqo2w/
 brUxWclZd+hiQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/6] drm/ttm: Extract code for attempting allocation
 in a place
To: "Natalie Vock" <natalie.vock@gmx.de>
Cc: hannes@cmpxchg.org, tj@kernel.org, dri-devel@lists.freedesktop.org,
 mkoutny@suse.com
In-Reply-To: <20260721-dmemcg-aggressive-protect-v7-3-97c4b1014315@gmx.de>
References: <20260721-dmemcg-aggressive-protect-v7-0-97c4b1014315@gmx.de>
 <20260721-dmemcg-aggressive-protect-v7-3-97c4b1014315@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 19:58:50 +0000
Message-Id: <20260721195851.01B501F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Low] Incomplete refactoring: `ttm_bo_evict_cb` bypasses `ttm_bo_alloc_at=
_place`.
- [Low] Unreachable dead code in `ttm_bo_alloc_at_place` handling `-EAGAIN`.
- [Low] Unused parameter `ctx` in `ttm_bo_alloc_at_place`.
--

--- Patch [3]: [PATCH v7 3/6] drm/ttm: Extract code for attempting allocati=
on in a place ---
commit 6da6afe8040fede46543a08f8c3a3c9b15da624e
Author: Natalie Vock <natalie.vock@gmx.de>
Date:   Tue Jul 21 19:43:22 2026 +0000

    drm/ttm: Extract code for attempting allocation in a place
   =20
    Move all code for attempting allocation for a specific place to
    ttm_bo_alloc_place. With subsequent patches, this logic is going to get
    more complicated, so it helps readability to have this separate.

> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index 3980f376e3ba4..7192c15f2fcef 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c

[ ... ]

> @@ -488,6 +488,62 @@ int ttm_bo_evict_first(struct ttm_device *bdev, stru=
ct ttm_resource_manager *man
>  	return ret;
>  }
> =20
> +struct ttm_bo_alloc_state {
> +	/** @limit_pool: Which pool limit we should test against */
> +	struct dmem_cgroup_pool_state *limit_pool;
> +};
> +
> +/**
> + * ttm_bo_alloc_at_place - Attempt allocating a BO's backing store in a =
place
> + *
> + * @bo: The buffer to allocate the backing store of
> + * @place: The place to attempt allocation in
> + * @ctx: ttm_operation_ctx associated with this allocation
> + * @force_space: If we should evict buffers to force space
> + * @res: On allocation success, the resulting struct ttm_resource.
> + * @alloc_state: Object holding allocation state such as charged cgroups.
> + *
> + * Returns:
> + * -EBUSY: No space available, but allocation should be retried with ttm=
_bo_evict_alloc.
> + * -ENOSPC: No space available, allocation should not be retried.
> + * -ERESTARTSYS: An interruptible sleep was interrupted by a signal.
> + *
> + */
> +static int ttm_bo_alloc_at_place(struct ttm_buffer_object *bo,
> +				 const struct ttm_place *place,
> +				 struct ttm_operation_ctx *ctx,
                                 ^^^^

[Severity: Low]
Is the ctx parameter needed here? It doesn't appear to be used anywhere wit=
hin
the body of ttm_bo_alloc_at_place().

> +				 bool force_space,
> +				 struct ttm_resource **res,
> +				 struct ttm_bo_alloc_state *alloc_state)
> +{
> +	bool may_evict;
> +	int ret;
> +
> +	may_evict =3D force_space && place->mem_type !=3D TTM_PL_SYSTEM;
> +
> +	ret =3D ttm_resource_alloc(bo, place, res,
> +				 force_space ? &alloc_state->limit_pool : NULL);
> +
> +	if (ret) {
> +		/*
> +		 * -EAGAIN means the charge failed, which we treat like an
> +		 * allocation failure. Therefore, return an error code indicating
> +		 * the allocation failed - either -EBUSY if the allocation should
> +		 * be retried with eviction, or -ENOSPC if there should be no second
> +		 * attempt.
> +		 */
> +		if (ret =3D=3D -EAGAIN)
                ^^^^

[Severity: Low]
Can ttm_resource_alloc() return -EAGAIN here? If it intercepts -EAGAIN
internally and converts it to -ENOSPC, this condition might be unreachable.

> +			return may_evict ? -EBUSY : -ENOSPC;
> +
> +		if (ret =3D=3D -ENOSPC && may_evict)
> +			return -EBUSY;
> +
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  /**
>   * struct ttm_bo_evict_walk - Parameters for the evict walk.
>   */
> @@ -503,12 +559,13 @@ struct ttm_bo_evict_walk {
>  	/** @evicted: Number of successful evictions. */
>  	unsigned long evicted;
> =20
> -	/** @limit_pool: Which pool limit we should test against */
> -	struct dmem_cgroup_pool_state *limit_pool;
>  	/** @try_low: Whether we should attempt to evict BO's with low watermar=
k threshold */
>  	bool try_low;
>  	/** @hit_low: If we cannot evict a bo when @try_low is false (first pas=
s) */
>  	bool hit_low;
> +
> +	/** @alloc_state: State associated with the allocation attempt. */
> +	struct ttm_bo_alloc_state *alloc_state;
>  };
> =20
>  static s64 ttm_bo_evict_cb(struct ttm_lru_walk *walk, struct ttm_buffer_=
object *bo)
> @@ -517,8 +574,9 @@ static s64 ttm_bo_evict_cb(struct ttm_lru_walk *walk,=
 struct ttm_buffer_object *
>  		container_of(walk, typeof(*evict_walk), walk);
>  	s64 lret;
> =20
> -	if (!dmem_cgroup_state_evict_valuable(evict_walk->limit_pool, bo->resou=
rce->css,
> -					      evict_walk->try_low, &evict_walk->hit_low))
> +	if (!dmem_cgroup_state_evict_valuable(evict_walk->alloc_state->limit_po=
ol,
> +					      bo->resource->css, evict_walk->try_low,
> +					      &evict_walk->hit_low))
                                              ^^^^

[Severity: Low]
Later in ttm_bo_evict_cb(), the code still calls ttm_resource_alloc()
directly:

	if (evict_walk->res)
		lret =3D ttm_resource_alloc(evict_walk->evictor, evict_walk->place,
					  evict_walk->res, NULL);

Should this have been updated to use the newly introduced
ttm_bo_alloc_at_place() as part of the refactoring?

>  		return 0;
> =20
>  	if (bo->pin_count || !bo->bdev->funcs->eviction_valuable(bo, evict_walk=
->place))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-dmemcg-agg=
ressive-protect-v7-0-97c4b1014315@gmx.de?part=3D3
