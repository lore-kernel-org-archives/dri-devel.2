Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83CB9C55172
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 08:41:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F21B010E904;
	Tue,  4 Aug 2026 08:41:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jBaCTU/D";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2DD710E904
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 08:41:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 821D34115C;
 Tue,  4 Aug 2026 08:41:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 179841F000E9;
 Tue,  4 Aug 2026 08:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785832886;
 bh=spar4wDeIDU5eUW3hYPAfBUNxtx7ZKFHimQ3+HIvGIg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jBaCTU/Dcd3BcZmNgf+xA2Lkh+l3tOm5TpM4afQ6AEkmlbb3Fwwnnuqq0cwC6QftB
 uqboefWa/hXxNM4ELJ06R7/o02lfotWZmJwYLKIEz1PhNBq4pgmfRyMgYVcjomLAa2
 MvzSujuJwylC13OI3eSLCSA/u3ujDLGxqH+AYfN06YKbQMwolpK+Co8wzZqYlCpHXD
 qck/THTI4Dq5tHM+2O+BnHNwN6FN5PBmupWQZH4EtmdPhUejxQgwBlcF3HKxo4a5K2
 tOeajuQ0HiGuNWzPA8i2TkAkoLwCMDZ93IA22i4iVBnW3eO2RAGeTdF4KRNEttWb/9
 cs5dRSXOBYiHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/6] drm/ttm: Extract code for attempting allocation
 in a place
To: "Natalie Vock" <natalie.vock@gmx.de>
Cc: tj@kernel.org, mkoutny@suse.com, dri-devel@lists.freedesktop.org,
 hannes@cmpxchg.org
In-Reply-To: <20260804-dmemcg-aggressive-protect-v8-3-07af96681bf8@gmx.de>
References: <20260804-dmemcg-aggressive-protect-v8-0-07af96681bf8@gmx.de>
 <20260804-dmemcg-aggressive-protect-v8-3-07af96681bf8@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 08:41:22 +0000
Message-Id: <20260804084126.179841F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The synthetic `-EBUSY` signal collides with the native `-EBUSY` =
error code, causing unintended evictions and silent API contract changes.
--

--- Patch [3]: [PATCH v8 3/6] drm/ttm: Extract code for attempting allocati=
on in a place ---
commit 8416fd662f16adcc69fd20180c1e3da4cb94ac03
Author: Natalie Vock <nat@pixelcluster.dev>

drm/ttm: Extract code for attempting allocation in a place

This commit moves the logic for attempting buffer allocation for a specific
place into a separate ttm_bo_alloc_at_place() function. It uses a synthetic
-EBUSY return code to signal that eviction should be attempted.

> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index 3980f376e3ba4..1cdb2172d5924 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c

[ ... ]

> @@ -488,6 +488,51 @@ int ttm_bo_evict_first(struct ttm_device *bdev, stru=
ct ttm_resource_manager *man
> +static int ttm_bo_alloc_at_place(struct ttm_buffer_object *bo,
> +				 const struct ttm_place *place,
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
> +		if (ret =3D=3D -ENOSPC && may_evict)
> +			return -EBUSY;
> +
> +		return ret;

[Severity: Medium]
If ttm_resource_alloc() organically returns -EBUSY, will this native error =
be
passed up unmodified and collide with the synthetic -EBUSY eviction signal?

> +	}
> +
> +	return 0;
> +}

[ ... ]

> @@ -736,25 +782,25 @@ static int ttm_bo_alloc_resource(struct ttm_buffer_=
object *bo,
> -		may_evict =3D (force_space && place->mem_type !=3D TTM_PL_SYSTEM);
> -		ret =3D ttm_resource_alloc(bo, place, res, force_space ? &limit_pool :=
 NULL);
> -		if (ret) {
> -			if (ret !=3D -ENOSPC) {
> -				dmem_cgroup_pool_state_put(limit_pool);
> -				return ret;
> -			}
> -			if (!may_evict) {
> -				dmem_cgroup_pool_state_put(limit_pool);
> -				continue;
> -			}
> +		ret =3D ttm_bo_alloc_at_place(bo, place, force_space, res,
> +					    &alloc_state);
> =20
> +		if (ret =3D=3D -ENOSPC) {
> +			dmem_cgroup_pool_state_put(alloc_state.limit_pool);
> +			continue;
> +		} else if (ret =3D=3D -EBUSY) {
>  			ret =3D ttm_bo_evict_alloc(bdev, man, place, bo, ctx,
> -						 ticket, res, limit_pool);
> -			dmem_cgroup_pool_state_put(limit_pool);
> +						 ticket, res, &alloc_state);

[Severity: Medium]
Before this patch, if ttm_resource_alloc() returned a native -EBUSY, it was
directly returned to the caller since it was not -ENOSPC.

By treating any -EBUSY returned from ttm_bo_alloc_at_place() as a signal to=
 evict,
does this inadvertently cause an organic -EBUSY to trigger an unnecessary e=
viction
walk rather than propagating the error?

> +
> +			dmem_cgroup_pool_state_put(alloc_state.limit_pool);
> +
>  			if (ret =3D=3D -EBUSY)
>  				continue;
> -			if (ret)
> +			else if (ret)
>  				return ret;
> +		} else if (ret) {
> +			dmem_cgroup_pool_state_put(alloc_state.limit_pool);
> +			return ret;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804-dmemcg-agg=
ressive-protect-v8-0-07af96681bf8@gmx.de?part=3D3
