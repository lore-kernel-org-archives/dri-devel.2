Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8A4606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 03:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GCIY0Eb6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0266A10E8CB;
	Wed, 25 Nov 2026 03:01:06 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29EBE10E8E7
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 03:01:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6FD0360E91;
 Wed, 25 Nov 2026 03:00:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A982C1F000D1;
 Wed, 25 Nov 2026 03:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795575658;
 bh=ys4sRMBDOYPhZkcEKt4/EJWfbJU54UyiCBP0rCnZLCg=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=GCIY0Eb6UCXASta6cGvOHD2RmZL504NTW2kMszjkXNNw6aQ2bTQY9uOmrsU6rVOfI
 R14utyB/zHLMViOZ+mLxUbxCPHRd+SFHZY758RXKZR54Gb68wBU0ru7rY3FcUGqv+F
 Omu0Lg8ZbcADWO5Fgk/uMNrvpmdLIjiO52kPdqCHAKfF/PN3aJyOnyf+QBdJbuSYW5
 7pOzhBjQpLl2VNjcB68nBuY0azLuYUuBlJ4XFrWXoLI79nB+m00lBlC9CbeOF0T3Pk
 NX9OnTS+qT/wHQ0GjNtTRk6g5tPP8vGhNxeqHHzTyTlPR8LqCXQ85/XlF1uabwb8GP
 4VqR4Qdu25EiQ==
Message-ID: <sashiko-outbox-232432@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3] drm/ttm: reclaim excess pooled pages with
 batched write-back
To: "Eduardo P. Gomez" <eduardoprocopiogomez@gmail.com>,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261125024630.257843-1-eduardoprocopiogomez@gmail.com>
References: <20261125024630.257843-1-eduardoprocopiogomez@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 03:00:58 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] drm/ttm: unbounded busy-spin in ttm_pool_free() and
  ttm_pool_shrinker_scan()
- [Medium] drm/ttm: unscaled batch in ttm_pool_shrink_idle() biases
  high-order reclaim
--

commit a0eba1b6041ea9cb1a00634b848d2c76f8f265d4
Author: Eduardo P. Gomez <eduardoprocopiogomez@gmail.com>

drm/ttm: reclaim excess pooled pages with batched write-back

This commit adds a delayed work item to reclaim TTM pooled pages above a
per-node reserve and batches write-back caching conversions for order-0
WC and UC pages on x86.

> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_poo=
l.c
> index 1bf37023fed66..3c14577593eb2 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c

[ ... ]

> @@ -452,7 +532,8 @@ static struct ttm_pool_type *ttm_pool_select_type(str=
uct ttm_pool *pool,
>  }
> =20
>  /* Free pages using the per-node shrinker list */
> -static unsigned int ttm_pool_shrink(int nid, unsigned long num_to_free)
> +static unsigned int ttm_pool_shrink(int nid, unsigned long num_to_free,
> +				    unsigned long page_budget)
>  {
>  	LIST_HEAD(dispose);
>  	struct ttm_pool_type *pt;
> @@ -464,6 +545,10 @@ static unsigned int ttm_pool_shrink(int nid, unsigne=
d long num_to_free)
>  	list_move_tail(&pt->shrinker_list, &shrinker_list);
>  	spin_unlock(&shrinker_lock);
> =20
> +	/* A list entry represents a whole compound allocation. */
> +	if (page_budget)
> +		num_to_free =3D min(num_to_free, ((page_budget - 1) >> pt->order) + 1);
> +
>  	num_pages =3D list_lru_walk_node(&pt->pages, nid, pool_move_to_dispose_=
list, &dispose, &num_to_free);
>  	num_pages *=3D 1 << pt->order;
> =20
> @@ -473,6 +558,46 @@ static unsigned int ttm_pool_shrink(int nid, unsigne=
d long num_to_free)
>  	return num_pages;
>  }
> =20
> +/* Trim excess pooled pages when the fixed reclaim window expires. */
> +static void ttm_pool_shrink_idle(struct work_struct *work)
> +{
> +	const unsigned long batch =3D 1UL << (MAX_PAGE_ORDER / 2);
> +	size_t nr_types;
> +	int nid;
> +
> +	spin_lock(&shrinker_lock);
> +	nr_types =3D list_count_nodes(&shrinker_list);
> +	spin_unlock(&shrinker_lock);
> +
> +	for_each_node_state(nid, N_MEMORY) {
> +		unsigned long reserve =3D min(page_pool_idle_reserve,
> +					    pool_node_limit[nid]);
> +		long pages =3D atomic_long_read(&allocated_pages[nid]);
> +		unsigned long budget;
> +		size_t empty =3D 0;
> +
> +		if (pages <=3D 0 || pages <=3D reserve)
> +			continue;
> +
> +		/* Bound freed pages and scans that make no progress. */
> +		budget =3D pages - reserve;
> +		while (budget && empty < nr_types && pages > 0 && pages > reserve) {
> +			unsigned long freed;
> +
> +			freed =3D ttm_pool_shrink(nid, batch, min(budget, pages - reserve));
> +			budget -=3D min(budget, freed);
> +			empty =3D freed ? 0 : empty + 1;
> +			cond_resched();
> +			pages =3D atomic_long_read(&allocated_pages[nid]);
> +		}

[Severity: Medium]
Should num_to_free in ttm_pool_shrink() also be scaled down by pt->order, or
should batch be expressed in base pages?

ttm_pool_shrink_idle() passes a fixed batch of 32 LRU entries to
ttm_pool_shrink(), which scales page_budget by pt->order but leaves
num_to_free unscaled unless it exceeds page_budget.  Each rotation across
shrinker_list therefore drains at most 32 base pages (128 KiB) from an
order-0 pool before moving it to the tail of all 44+ pool types, but up to
32 compound allocations (64 MiB at order-9 or 128 MiB at order-10) from a
high-order pool.  This disproportionately evicts high-order pages from the
128 MiB idle reserve and forces 43 empty list_lru walks and lock cycles for
every 32 pages freed from a single active order-0 pool.

[ ... ]

> @@ -978,13 +1103,14 @@ int ttm_pool_restore_and_alloc(struct ttm_pool *po=
ol, struct ttm_tt *tt,
>  void ttm_pool_free(struct ttm_pool *pool, struct ttm_tt *tt)
>  {
>  	int nid =3D ttm_pool_nid(pool);
> +	unsigned long limit =3D pool_node_limit[nid];
> +	long pages;
> =20
>  	ttm_pool_free_range(pool, tt, tt->caching, 0, tt->num_pages);
> =20
> -	while (atomic_long_read(&allocated_pages[nid]) > pool_node_limit[nid]) {
> -		unsigned long diff =3D atomic_long_read(&allocated_pages[nid]) - pool_=
node_limit[nid];
> -		ttm_pool_shrink(nid, diff);
> -	}
> +	while ((pages =3D atomic_long_read(&allocated_pages[nid])) > 0 &&
> +	       pages > limit)
> +		ttm_pool_shrink(nid, pages - limit, 0);
>  }
>  EXPORT_SYMBOL(ttm_pool_free);
> =20
> @@ -1309,7 +1435,7 @@ static unsigned long ttm_pool_shrinker_scan(struct =
shrinker *shrink,
>  	unsigned long num_freed =3D 0;
> =20
>  	do
> -		num_freed +=3D ttm_pool_shrink(sc->nid, sc->nr_to_scan);
> +		num_freed +=3D ttm_pool_shrink(sc->nid, sc->nr_to_scan, 0);
>  	while (num_freed < sc->nr_to_scan &&
>  	       atomic_long_read(&allocated_pages[sc->nid]));

[Severity: Medium]
Can ttm_pool_free() and ttm_pool_shrinker_scan() busy-spin when the
remaining counted pages on a node are in flight?

This patch moves atomic_long_add(&allocated_pages[nid]) before
list_lru_add() in ttm_pool_type_give(), and in ttm_pool_free_wb_batch()
keeps pages isolated from pt->pages across set_pages_array_wb() (which takes
cpa_lock and runs cross-CPU TLB shootdowns) before decrementing
allocated_pages[nid].

CPU0 (pool_idle_work)             CPU1
ttm_pool_shrink_idle()
  ttm_pool_shrink()
    list_lru_walk_node()
    /* pt->pages now empty */
    ttm_pool_free_wb_batch()
      set_pages_array_wb()
                                  ttm_pool_free()
                                    while (allocated_pages[nid] > limit)
                                      ttm_pool_shrink() -> 0
                                      /* spins on shrinker_lock */
      atomic_long_dec(...)

Unlike ttm_pool_shrink_idle(), neither ttm_pool_free() nor
ttm_pool_shrinker_scan() bounds consecutive empty scans with
empty < nr_types or calls cond_resched().  While in-flight pages keep
allocated_pages[nid] above limit (or above 0 in the shrinker), a concurrent
caller spins through shrinker_list acquiring and releasing pool_shrink_rwsem
and shrinker_lock, which can cause severe lock contention or soft-lockups if
the thread holding the in-flight batch is preempted.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125024630.2578=
43-1-eduardoprocopiogomez@gmail.com?part=3D1
