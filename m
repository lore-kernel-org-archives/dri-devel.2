Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1155BC5518F
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 08:44:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D53A10E911;
	Tue,  4 Aug 2026 08:44:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CHEgP5Vd";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC10A10E913
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 08:44:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4CBB960A71;
 Tue,  4 Aug 2026 08:44:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC3321F00A3A;
 Tue,  4 Aug 2026 08:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785833055;
 bh=Hp5IKlJ+B5dWx88dWAZGpSS/znrzf0raS+wi/FkjJPg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CHEgP5VduRhJn0rh9hB57MDdhMF7+71H7VUYtQKCAeyXvrDtvo4w3DhYFo6O0tuNt
 a4bnVFsP6EB7IbQLB23BiiW0fyZkxiUXCC2VajTLBQJDVxrO+aP+5r7V8rYRGrCiat
 XGxwBOofUW2Vc35s0ihWUDNn/9wBoZjhYJTM4K4/rhUOvda5m8uvcniKpjHMwVsKFg
 BG8TLB0t9+i6FVXNPcOCAMcJuBNWM9J2Z0UAMXiYYfYVIlEMtuXQGs4GgfjUiDovPL
 mLwycIBnmZiXYUkPoiNgEr+a4NNSy/IF5AEZj2q2vyZBpvD+74iwt4KqQ4R7A4nmrL
 oBcqGBI/8wp/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 4/6] drm/ttm: Split cgroup charge and resource
 allocation
To: "Natalie Vock" <natalie.vock@gmx.de>
Cc: tj@kernel.org, dri-devel@lists.freedesktop.org, mkoutny@suse.com,
 hannes@cmpxchg.org
In-Reply-To: <20260804-dmemcg-aggressive-protect-v8-4-07af96681bf8@gmx.de>
References: <20260804-dmemcg-aggressive-protect-v8-0-07af96681bf8@gmx.de>
 <20260804-dmemcg-aggressive-protect-v8-4-07af96681bf8@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 08:44:14 +0000
Message-Id: <20260804084414.CC3321F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Eviction walk continues to restrict evictions to a specific cgroup=
 even after its memory limit is satisfied, causing spurious allocation fail=
ures under global memory pressure.

Pre-existing issues:
- [Critical] dmem_cgroup_get_common_ancestor returns a pool without a CSS r=
eference, but the caller puts it using dmem_cgroup_pool_state_put which dro=
ps a CSS reference, leading to a CSS refcount underflow.
--

--- Patch [4]: [PATCH v8 4/6] drm/ttm: Split cgroup charge and resource all=
ocation ---
commit aa5cab6f4c763e172491a34bffbf1a67e37f5262
Author: Natalie Vock <nat@pixelcluster.dev>

drm/ttm: Split cgroup charge and resource allocation

This patch decouples resource allocation from cgroup charging to address=20
raciness when checking min/low cgroup limits during eviction. It charges=20
the allocation to the cgroup once and keeps the charge for the duration of
the resource allocation attempt.

> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index 1cdb2172d5924..3becddd2c43b8 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
[ ... ]
> @@ -518,18 +522,39 @@ static int ttm_bo_alloc_at_place(struct ttm_buffer_=
object *bo,
>  	bool may_evict;
>  	int ret;
> =20
> -	may_evict =3D force_space && place->mem_type !=3D TTM_PL_SYSTEM;
> -
> -	ret =3D ttm_resource_alloc(bo, place, res,
> -				 force_space ? &alloc_state->limit_pool : NULL);
> +	may_evict =3D !alloc_state->in_evict && force_space &&
> +		    place->mem_type !=3D TTM_PL_SYSTEM;
> +	if (!alloc_state->charge_pool) {
> +		ret =3D ttm_resource_try_charge(bo, place, &alloc_state->charge_pool,
> +					      force_space ? &alloc_state->limit_pool
> +							  : NULL);

[Severity: High]
If ttm_resource_try_charge() succeeds during an eviction callback (where
force_space is false), alloc_state->limit_pool is not cleared.

If the subsequent physical resource allocation still fails due to global
memory pressure, the eviction walk will continue.

Because alloc_state->limit_pool remains set, will the LRU walk continue to
only evict buffers from that specific cgroup, eventually causing a spurious
-ENOSPC failure if that cgroup has no more evictable buffers?

> +		if (ret) {
> +			/*
> +			 * -EAGAIN means the charge failed, which we treat
> +			 * like an allocation failure. Therefore, return an
> +			 * error code indicating the allocation failed -
> +			 * either -EBUSY if the allocation should be
> +			 * retried with eviction, or -ENOSPC if there should
> +			 * be no second attempt.
> +			 */
> +			if (ret =3D=3D -EAGAIN)
> +				ret =3D may_evict ? -EBUSY : -ENOSPC;
> +			return ret;
> +		}
> +	}
[ ... ]
> @@ -584,8 +609,10 @@ static s64 ttm_bo_evict_cb(struct ttm_lru_walk *walk=
, struct ttm_buffer_object *
> =20
>  	evict_walk->evicted++;
>  	if (evict_walk->res)
> -		lret =3D ttm_resource_alloc(evict_walk->evictor, evict_walk->place,
> -					  evict_walk->res, NULL);
> +		lret =3D ttm_bo_alloc_at_place(evict_walk->evictor,
> +					     evict_walk->place, false,
> +					     evict_walk->res,
> +					     evict_walk->alloc_state);

[Severity: Critical]
This is a pre-existing issue, but I noticed a potential refcount underflow
involving the ancestor pool earlier in ttm_bo_evict_cb().

dmem_cgroup_get_common_ancestor() explicitly drops its CSS reference before
returning the pool:

kernel/cgroup/dmem.c:dmem_cgroup_get_common_ancestor() {
    ...
    if (IS_ERR(pool))
        pool =3D NULL;
    css_put(ancestor_css);
    return pool;
}

However, in ttm_bo_evict_cb(), the ancestor pool is freed using
dmem_cgroup_pool_state_put():

    if (ancestor)
        dmem_cgroup_pool_state_put(ancestor);

Since dmem_cgroup_pool_state_put() calls css_put(&pool->cs->css), doesn't
this drop a CSS reference that the caller does not own, potentially leading
to a use-after-free of the cgroup subsystem state?

>  	if (lret =3D=3D 0)
>  		return 1;
>  out:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804-dmemcg-agg=
ressive-protect-v8-0-07af96681bf8@gmx.de?part=3D4
