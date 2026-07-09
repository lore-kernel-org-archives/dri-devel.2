Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3790C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 04:10:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2C0E10E681;
	Thu,  9 Jul 2026 04:10:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dZxKussW";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DBEA10E681
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 04:10:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BA18241AD0;
 Thu,  9 Jul 2026 04:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B6D1F000E9;
 Thu,  9 Jul 2026 04:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783570221;
 bh=K3w7yAns0gEU4dWp+5k4UYzJjMxTahJl6A8blChFjKI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dZxKussWiZ5+3hqdeynTw+DCWDch9m5VhhxiiCRA5ooQV20kezLhUKOBpRSKWGMjP
 0RbiRmAfKGGNpVFc6uyfyG+qhrRsBlRrMCiu4fX2YCW9CBUcGQt5awHv82Sw+mmRk1
 WzL2yMf4n4NfjqHJdrdF0CRyJKScIUmpQ+Rp5rdDt17M/gLPrniElbuLLHnZuJyCS8
 hPnyP4vamf5/Fesl9BiKAWDtGXNUv3ER5WMxoKlE0siNEx96/OQWWr7iEUYDlQMb9W
 GFJ1aVuR2dUwWrhXmKO1WdHpcJjOTyCpv37SauvgD+V7K2+2sFxuL6H6ceHH7nx5em
 ErTJ4bcJy36aA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7] cgroup/dmem: implement dmem.high soft limit with
 proactive reclaim
To: "Qiliang Yuan" <realwujing@gmail.com>
Cc: dri-devel@lists.freedesktop.org, hannes@cmpxchg.org, mkoutny@suse.com,
 tj@kernel.org
In-Reply-To: <20260709-feature-dmem-high-v7-1-de559e7e7768@gmail.com>
References: <20260709-feature-dmem-high-v7-1-de559e7e7768@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 04:10:20 +0000
Message-Id: <20260709041021.59B6D1F000E9@smtp.kernel.org>
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
- [High] Double put of `over_high_pool` reference on the `ttm_resource_allo=
c` error path leading to Use-After-Free.
- [High] Swallowed `-EDEADLK` error in `ttm_bo_proactive_evict_high()` brea=
ks the WW mutex backoff protocol.
- [Medium] Proactive reclaim bypasses parent `dmem.high` limits because the=
 ancestor chain is not evaluated.
--

--- Patch [1]: [PATCH v7] cgroup/dmem: implement dmem.high soft limit with =
proactive reclaim ---
commit cf68cf477adb57880cd824c91aad57538df44a76
Author: Qiliang Yuan <realwujing@gmail.com>

cgroup/dmem: implement dmem.high soft limit with proactive reclaim

This commit implements dmem.high as a proper soft limit following the
memory.high semantics. The limit is checked in the charge path on every
successful allocation, and proactive reclaim is triggered when usage
crosses the threshold.

Link: https://lore.kernel.org/r/20260531-feature-dmem-high-v6-1-20563ecd6dc=
7@gmail.com
Link: https://lore.kernel.org/r/20260531-feature-dmem-high-v5-1-1c6c532b26a=
9@gmail.com
Link: https://lore.kernel.org/r/20260530-feature-dmem-high-v4-1-ee7c6ec1c8d=
a@gmail.com
Link: https://lore.kernel.org/r/20260528-feature-dmem-high-v3-1-c642b34bcb2=
f@gmail.com
Link: https://lore.kernel.org/r/20260522-feature-dmem-high-v2-1-1d7d4a0fa5d=
a@gmail.com
Link: https://lore.kernel.org/all/20260520-feature-dmem-high-v1-1-97ca0cb7f=
95a@gmail.com

> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index bcd76f6bb7f02..bdfcfe5c7d1e2 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c

[ ... ]

> @@ -553,6 +556,38 @@ static const struct ttm_lru_walk_ops ttm_evict_walk_=
ops =3D {
>  	.process_bo =3D ttm_bo_evict_cb,
>  };
> =20
> +/*
> + * Proactive reclaim: evict one BO from a cgroup that exceeds its dmem.h=
igh
> + * soft limit.  Called after a successful charge that pushed usage over =
the
> + * high threshold.  Best-effort; allocation already succeeded (soft limi=
t).
> + */
> +static void ttm_bo_proactive_evict_high(struct ttm_device *bdev,
> +					struct ttm_resource_manager *man,
> +					const struct ttm_place *place,
> +					struct ttm_buffer_object *evictor,
> +					struct ttm_operation_ctx *ctx,
> +					struct ww_acquire_ctx *ticket,
> +					struct dmem_cgroup_pool_state *over_high_pool)
> +{
> +	struct ttm_bo_evict_walk evict_walk =3D {
> +		.walk =3D {
> +			.ops =3D &ttm_evict_walk_ops,
> +			.arg =3D {
> +				.ctx =3D ctx,
> +				.ticket =3D ticket,
> +				.trylock_only =3D !ticket,
> +			}
> +		},
> +		.place =3D place,
> +		.evictor =3D evictor,
> +		.res =3D NULL,
> +		.limit_pool =3D over_high_pool,
> +		.try_high =3D true,
> +	};
> +
> +	ttm_lru_walk_for_evict(&evict_walk.walk, bdev, man, 1);
> +}

[Severity: High]
Does this code silently swallow WW mutex backoff requests?

When ttm_lru_walk_for_evict() is called with a ticket, it can return
-EDEADLK if a cyclic dependency is detected. Because
ttm_bo_proactive_evict_high() has a void return type and ignores the
return value of ttm_lru_walk_for_evict(), the top-level caller
(ttm_bo_alloc_resource) is not notified of the deadlock and will fail
to execute the required backoff sequence.

Could this regression lead to a hard deadlock?

[ ... ]

> @@ -737,7 +767,17 @@ static int ttm_bo_alloc_resource(struct ttm_buffer_o=
bject *bo,
>  			continue;
> =20
>  		may_evict =3D (force_space && place->mem_type !=3D TTM_PL_SYSTEM);
> -		ret =3D ttm_resource_alloc(bo, place, res, force_space ? &limit_pool :=
 NULL);
> +		{
> +			struct dmem_cgroup_pool_state *over_high_pool =3D NULL;
> +
> +			ret =3D ttm_resource_alloc(bo, place, res,
> +						 force_space ? &limit_pool : NULL,
> +						 &over_high_pool);
> +			if (!ret && over_high_pool)
> +				ttm_bo_proactive_evict_high(bdev, man, place, bo,
> +							    ctx, ticket, over_high_pool);
> +			dmem_cgroup_pool_state_put(over_high_pool);

[Severity: High]
Is there a use-after-free risk for over_high_pool on the error path?

If ttm_resource_alloc() encounters an error after successfully charging the
cgroup, it calls dmem_cgroup_pool_state_put(*ret_over_high_pool), but it
leaves the pointer value intact:

drivers/gpu/drm/ttm/ttm_resource.c:ttm_resource_alloc() {
    ...
    if (ret) {
        if (pool)
            dmem_cgroup_uncharge(pool, bo->base.size);
        if (ret_over_high_pool)
            dmem_cgroup_pool_state_put(*ret_over_high_pool);
        return ret;
    }
    ...
}

When it returns the error code, the caller (ttm_bo_alloc_resource) will
proceed to unconditionally call dmem_cgroup_pool_state_put(over_high_pool)
on the exact same pointer, causing a double-free regression.

Should ttm_resource_alloc() clear *ret_over_high_pool after putting the
reference on its error path?

> +		}
>  		if (ret) {
>  			if (ret !=3D -ENOSPC) {

[ ... ]

> diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
> index 4753a67d0f0f2..b322c8a7e2a67 100644
> --- a/kernel/cgroup/dmem.c
> +++ b/kernel/cgroup/dmem.c

[ ... ]

> @@ -685,6 +748,18 @@ int dmem_cgroup_try_charge(struct dmem_cgroup_region=
 *region, u64 size,
>  		goto err;
>  	}
> =20
> +	/*
> +	 * Charge succeeded. Check if usage now exceeds the soft high limit so
> +	 * the caller can trigger proactive reclaim to bring the cgroup back
> +	 * under its dmem.high threshold.
> +	 */
> +	if (ret_over_high_pool &&
> +	    page_counter_read(&pool->cnt) > READ_ONCE(pool->cnt.high)) {
> +		*ret_over_high_pool =3D pool;

[Severity: Medium]
Will this bypass proactive reclaim for parent cgroups?

The check here only evaluates whether the leaf pool (pool->cnt) exceeds
its own dmem.high limit. If the leaf is under its limit but a parent cgroup
is over its dmem.high soft limit, ret_over_high_pool remains NULL.

Should this walk the ancestor chain to enforce the hierarchical dmem.high
limits, similar to what is done in dmem_cgroup_state_evict_valuable()?

> +		css_get(&pool->cs->css);
> +		dmemcg_pool_get(*ret_over_high_pool);
> +	}
> +
>  	/* On success, reference from get_current_dmemcs is transferred to *ret=
_pool */
>  	*ret_pool =3D pool;
>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-feature-dm=
em-high-v7-1-de559e7e7768@gmail.com?part=3D1
