Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A76C1C55172
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 08:53:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DA8A10E914;
	Tue,  4 Aug 2026 08:53:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LsDJq8oJ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF9EC10E914
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 08:53:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F3D88600AA;
 Tue,  4 Aug 2026 08:53:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C6D01F000E9;
 Tue,  4 Aug 2026 08:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785833619;
 bh=cCfkrmczswlEh6QlebbVem3EWobN5N81QfEY5gWcpu4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LsDJq8oJUt5Gm9LALRrMXCvRaVxWea9FisruQZcORmzjv+BWkikEDSK0axdNKrk2u
 DMeB23XFXQfNzhqQvBOGVEKq89isBZNbGSv1aFhA8qjaKvEKej9REGWzKA06JgBgY6
 STV9Eg60gVCm/kI7Hehn5gUDi7YBGkVTj8l1fnVvDvLtzhOZ7tPUARANDPepgA09Ao
 f5DNxT36c12Gshsp8Xxd8Pfy5MWfZnZPO5vgQLN49BfssoYzhGy/u2GzEYylFPZKWV
 vrb15CDVVwJ8xo3H9+2QDkJzOH292jShswZEAXru2BCaxdXzD0OxzLtYr3O8J1FUjN
 PHtp4Iql0FhfA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 6/6] drm/ttm: Use common ancestor of evictor and
 evictee as limit pool
To: "Natalie Vock" <natalie.vock@gmx.de>
Cc: dri-devel@lists.freedesktop.org, hannes@cmpxchg.org, tj@kernel.org,
 mkoutny@suse.com
In-Reply-To: <20260804-dmemcg-aggressive-protect-v8-6-07af96681bf8@gmx.de>
References: <20260804-dmemcg-aggressive-protect-v8-0-07af96681bf8@gmx.de>
 <20260804-dmemcg-aggressive-protect-v8-6-07af96681bf8@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 08:53:38 +0000
Message-Id: <20260804085339.5C6D01F000E9@smtp.kernel.org>
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
- [Critical] Refcount underflow and use-after-free of cgroup subsystem stat=
e (css).
- [High] GFP_KERNEL allocation while holding a dma_resv lock causes lockdep=
 warnings and potential deadlocks.
--

--- Patch [6]: [PATCH v8 6/6] drm/ttm: Use common ancestor of evictor and e=
victee as limit pool ---
commit 80190cfff36182bea4c8b3f724df7df584bfc3b3
Author: Natalie Vock <nat@pixelcluster.dev>

drm/ttm: Use common ancestor of evictor and evictee as limit pool
   =20
When checking if buffers should be skipped for eviction due to dmem.low
protection, this patch calculates the protection from the shared ancestor
of the evictor and evictee instead of the root cgroup. This prevents
breaking prioritization of sibling cgroups.

> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index 6bbea148838e4..79c96aba4bf49 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
[ ... ]
> @@ -628,11 +628,48 @@ static s64 ttm_bo_evict_cb(struct ttm_lru_walk *wal=
k, struct ttm_buffer_object *
>  {
>  	struct ttm_bo_evict_walk *evict_walk =3D
>  		container_of(walk, typeof(*evict_walk), walk);
> +	struct dmem_cgroup_pool_state *limit_pool, *ancestor =3D NULL;
> +	bool evict_valuable;
>  	s64 lret;
> =20
[ ... ]
> +	if (!limit_pool) {
> +		ancestor =3D dmem_cgroup_get_common_ancestor(bo->resource->css,
> +							   evict_walk->alloc_state->charge_pool);

[Severity: High]
Does this allocation path trigger a deadlock?

ttm_bo_evict_cb() is executed via ttm_lru_walk_for_evict() which holds the
dma_resv lock of the buffer object (acquired via
ttm_bo_lru_for_each_reserved_guarded).

When calling dmem_cgroup_get_common_ancestor(), it can end up in
get_cg_pool_unlocked() which does a GFP_KERNEL allocation if the ancestor
pool does not exist:

kernel/cgroup/dmem.c:get_cg_pool_unlocked() {
	...
	allocpool =3D kzalloc_obj(*allocpool);
	...
}

Using GFP_KERNEL while holding a dma_resv lock can trigger direct memory
reclaim, which in turn can invoke GPU shrinkers.

Those shrinkers will attempt to acquire dma_resv locks, leading to a
potential deadlock.

> +		limit_pool =3D ancestor;
> +	}
> +
> +	evict_valuable =3D dmem_cgroup_state_evict_valuable(limit_pool, bo->res=
ource->css,
> +							  evict_walk->try_low,
> +							  &evict_walk->hit_low);
> +	if (ancestor)
> +		dmem_cgroup_pool_state_put(ancestor);

[Severity: Critical]
Does this cause a refcount underflow and use-after-free of the cgroup
subsystem state (css)?

dmem_cgroup_get_common_ancestor() acquires and returns a pool reference but
explicitly drops its temporary css reference before returning:

kernel/cgroup/dmem.c:dmem_cgroup_get_common_ancestor() {
	...
	if (IS_ERR(pool))
		pool =3D NULL;
	css_put(ancestor_css);
	return pool;
}

However, dmem_cgroup_pool_state_put() is designed to balance
dmem_cgroup_try_charge() and drops both a pool reference and a css referenc=
e.

Since dmem_cgroup_get_common_ancestor() did not acquire an extra css refere=
nce
for the caller, the css_put() in dmem_cgroup_pool_state_put() causes an
underflow.

This can lead to premature freeing of the css, resulting in a use-after-free
and memory corruption.

> +
> +	if (!evict_valuable)
>  		return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804-dmemcg-agg=
ressive-protect-v8-0-07af96681bf8@gmx.de?part=3D6
