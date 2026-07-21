Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C92C4452B
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 20:02:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F202F10E042;
	Tue, 21 Jul 2026 20:01:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ikJu//RB";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4503610E042
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 20:01:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B93A243FA6;
 Tue, 21 Jul 2026 20:01:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5033F1F00A3A;
 Tue, 21 Jul 2026 20:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784664118;
 bh=ZzYpCza1cf7ZRS1K5GgXGq3ZkHF8A9Ks9VHvPi0KKhY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ikJu//RBNpPOmM7941qKlwsaRZetHRNTGzQxew6f1L3RbKt0mJzfV4tru14sSrgMu
 ybxqV/oBeMrE0fMsDeuGg0dmtti5yEaLjgsPKo95JjikKxw1QMM3MidRsvTa6NYofA
 lKtHFl4oavhDnPAwb7iSgp3WuZn+Qt2J7YJOZb2fEHuvoW/TnE8uuB9htRzjpvZr2g
 3XiileP997oae4xWFXALCzlA++cEyLRjyjpzHxaoXGRDb85LT6xU3mnnqJb+ggsn+P
 M0LJaUMWuN7a3S1T3IXq8lQUJ8oIBeiNypBHrE5XqbZ6Cz5e4CvdJkCUOXKG1Plcmp
 dsqvyIe7IaJOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 6/6] drm/ttm: Use common ancestor of evictor and
 evictee as limit pool
To: "Natalie Vock" <natalie.vock@gmx.de>
Cc: tj@kernel.org, mkoutny@suse.com, hannes@cmpxchg.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260721-dmemcg-aggressive-protect-v7-6-97c4b1014315@gmx.de>
References: <20260721-dmemcg-aggressive-protect-v7-0-97c4b1014315@gmx.de>
 <20260721-dmemcg-aggressive-protect-v7-6-97c4b1014315@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 20:01:57 +0000
Message-Id: <20260721200158.5033F1F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Unchecked ERR_PTR return from `dmem_cgroup_get_common_ancestor()` =
leads to kernel panic.
- [High] The patch bypasses memory protection (`dmem.min`) for the allocati=
ng cgroup's own buffers, causing self-cannibalization.
- [High] `dmem_cgroup_get_common_ancestor()` leaks a CSS reference and retu=
rns an error pointer instead of NULL.
- [High] Sleeping in atomic context via `kzalloc_obj()` inside an RCU read-=
side critical section.
--

--- Patch [6]: [PATCH v7 6/6] drm/ttm: Use common ancestor of evictor and e=
victee as limit pool ---
commit f795676aadfddedc450e8bf4becfe0e912e1b01e
Author: Natalie Vock <natalie.vock@gmx.de>
Subject: drm/ttm: Use common ancestor of evictor and evictee as limit pool

This commit updates TTM buffer eviction to calculate memory protection based
on the shared subtree of the evictor and evictee. It explicitly skips buffe=
rs
belonging to the same cgroup if trying to evict unprotected buffers, and se=
ts
the limit pool to the common ancestor for cross-cgroup evictions.

> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index ec0821e306da1..c843189f36088 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -627,11 +627,48 @@ static s64 ttm_bo_evict_cb(struct ttm_lru_walk *wal=
k, struct ttm_buffer_object *
>  {
>  	struct ttm_bo_evict_walk *evict_walk =3D
>  		container_of(walk, typeof(*evict_walk), walk);
> +	struct dmem_cgroup_pool_state *limit_pool, *ancestor =3D NULL;
> +	bool evict_valuable;
>  	s64 lret;
> =20
> -	if (!dmem_cgroup_state_evict_valuable(evict_walk->alloc_state->limit_po=
ol,
> -					      bo->resource->css, evict_walk->try_low,
> -					      &evict_walk->hit_low))
> +	/*
> +	 * If may_try_low is not set, then we're trying to evict unprotected
> +	 * buffers in favor of a protected allocation for charge_pool. Explicit=
ly skip
> +	 * buffers belonging to the same cgroup here - that cgroup is definitel=
y protected,
> +	 * even though dmem_cgroup_state_evict_valuable would allow the evictio=
n because a
> +	 * cgroup is always allowed to evict from itself even if it is protecte=
d.
> +	 */
> +	if (!evict_walk->alloc_state->may_try_low &&
> +			bo->resource->css =3D=3D evict_walk->alloc_state->charge_pool)
> +		return 0;

[Severity: High]
Does this logic bypass dmem.min memory protection for a cgroup's own buffer=
s?

When an allocation fails while a cgroup is below its min limit, may_try_low
is set to true. The first LRU pass skips this !may_try_low guard.

Later, dmem_cgroup_get_common_ancestor(charge_pool, charge_pool) returns
charge_pool, so limit_pool becomes charge_pool. When calling
dmem_cgroup_state_evict_valuable(charge_pool, charge_pool), the fast path:
if (limit_pool =3D=3D test_pool) unconditionally returns true.

Can this cause a cgroup to eagerly evict its own highly-protected memory
before evicting other cgroups' unprotected memory?

> +
> +	limit_pool =3D evict_walk->alloc_state->limit_pool;
> +	/*
> +	 * If there is no explicit limit pool, find the root of the shared subt=
ree between
[ ... ]
> +	 * calculation cannot distinguish direct siblings from unrelated subtre=
es and the
> +	 * calculated protection ends up wrong.
> +	 */
> +	if (!limit_pool) {
> +		ancestor =3D dmem_cgroup_get_common_ancestor(bo->resource->css,
> +							   evict_walk->alloc_state->charge_pool);
> +		limit_pool =3D ancestor;
> +	}

[Severity: High]
Can dmem_cgroup_get_common_ancestor() return an ERR_PTR here?

Under memory pressure, get_cg_pool_unlocked() inside
dmem_cgroup_get_common_ancestor() can fail and return ERR_PTR(-ENOMEM).

Because the if (!limit_pool) check above only guards against NULL, the error
pointer is passed down directly to dmem_cgroup_state_evict_valuable().

> +
> +	evict_valuable =3D dmem_cgroup_state_evict_valuable(limit_pool, bo->res=
ource->css,
> +							  evict_walk->try_low,
> +							  &evict_walk->hit_low);

[Severity: High]
Does this cause a kernel panic due to an invalid pointer dereference?

The unchecked ERR_PTR stored in limit_pool is passed into
dmem_cgroup_state_evict_valuable(), where limit_pool->cs will directly
dereference the error pointer.

> +	if (ancestor)
> +		dmem_cgroup_pool_state_put(ancestor);
> +
> +	if (!evict_valuable)
>  		return 0;


Additionally, looking at the implementation of dmem_cgroup_get_common_ances=
tor()
in kernel/cgroup/dmem.c which is called by this patch:

kernel/cgroup/dmem.c:dmem_cgroup_get_common_ancestor() {
    ...
	rcu_read_lock();
	ancestor_css =3D cgroup_e_css(ancestor_cgroup, &dmem_cgrp_subsys);
	if (css_tryget(ancestor_css))
		pool =3D get_cg_pool_unlocked(css_to_dmemcs(ancestor_css),
					    a->region);
	if (!pool)
		css_put(ancestor_css);
	rcu_read_unlock();

	return pool;
}

[Severity: High]
Does this code leak a CSS reference and improperly handle error pointers?

If get_cg_pool_unlocked() fails, it returns an error pointer. Since an error
pointer is truthy, the if (!pool) check evaluates to false.=20

Can this cause a CSS reference leak by skipping the css_put(), preventing
the cgroup from being fully destroyed, while also violating the API contract
by returning an ERR_PTR instead of NULL?

[Severity: High]
Is it safe to call get_cg_pool_unlocked() inside an RCU read-side critical
section?

dmem_cgroup_get_common_ancestor() acquires rcu_read_lock() before calling
get_cg_pool_unlocked(). If a new cgroup pool needs to be instantiated,
get_cg_pool_unlocked() drops its internal spinlock and calls:

kernel/cgroup/dmem.c:get_cg_pool_unlocked() {
    ...
			allocpool =3D kzalloc_obj(*allocpool);
    ...
}

Since kzalloc_obj() defaults to GFP_KERNEL when no flags are provided,
can this sleepable allocation inside the caller's RCU read-side critical
section cause system stalls or deadlocks?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-dmemcg-agg=
ressive-protect-v7-0-97c4b1014315@gmx.de?part=3D6
