Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8E0606A321
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 09:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U8qLljw9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D4B210FA1F;
	Wed, 25 Nov 2026 09:00:29 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9473610FA28
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 09:00:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0C2F34181A;
 Wed, 25 Nov 2026 09:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 813941F000C0;
 Wed, 25 Nov 2026 09:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795597221;
 bh=yWyhNCSEUqWNmq49pHM3W3w1nF6mnTann9Ki4puBzl0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=U8qLljw9dAIWtJT2tM1y83lpZrjqUGJ7R1n1i821Rj/arigj/DzImABFiR2pg7iqQ
 qePpN7+Z9KT0D5elAIhZcTjV5VVyzaowwxUSdKuvNIIL1w1oUn6qC5DmfWd6aKTI1D
 A3b+qacygl0W3XkoZXjsPedZHe2iT3xLsZZQCfHtEInSOXeKeQZSqbKXN7XvhkwhWK
 +AC88SguSq/WzroEx6iPoQlsHJ+5h+xC4FkdcsS/nzuzmfnBvEXhL24E9aGwPdwRzB
 CZbeTphwv5lKt/ShaShrgOlKBKYAe+AhJGYIqx8ik7f+F8M6Qwz55wdqbKbJBZCXam
 U1WYNp8eR4/WQ==
Message-ID: <sashiko-outbox-232965@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/2] drm/ttm: retain a reserve during idle pool reclaim
To: "Eduardo P. Gomez" <eduardoprocopiogomez@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261124222812.511867-3-eduardoprocopiogomez@gmail.com>
References: <20261124222812.511867-1-eduardoprocopiogomez@gmail.com>
 <20261124222812.511867-3-eduardoprocopiogomez@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 09:00:21 +0000
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
- [Medium] drm/ttm: unit mismatch between num_to_free and page_budget in
  ttm_pool_shrink()
- [Medium] drm/ttm: reserve underrun and spin in ttm_pool_shrink_idle()
  on in-flight dispose
--

commit 4e83ddb6cbf7cc0eb4ace5ed5228122c85cb44a0
Author: Eduardo P. Gomez <eduardoprocopiogomez@gmail.com>

drm/ttm: retain a reserve during idle pool reclaim

This commit adds a configurable per-NUMA-node page reserve that is
retained during idle TTM page pool reclaim.

> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_poo=
l.c
> index 6af8a9c894b4e..3aad264fa11f8 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
[ ... ]
> @@ -485,7 +491,8 @@ static struct ttm_pool_type *ttm_pool_select_type(str=
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
> @@ -497,6 +504,10 @@ static unsigned int ttm_pool_shrink(int nid, unsigne=
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

[Severity: Medium]
Should num_to_free also be converted from base pages to pt->order compound
list entries?

page_budget is shifted by pt->order, but num_to_free is passed directly to
list_lru_walk_node() as a count of compound entries.  In
ttm_pool_shrink_idle(), batch is 32, so when pt->order is 10 and
pages - reserve is large, a single ttm_pool_shrink() call can isolate and
free up to 32 order-10 allocations (128 MiB) under pool_shrink_rwsem
before re-checking pool_last_return or calling cond_resched().  Meanwhile,
ttm_pool_free() and ttm_pool_shrinker_scan() pass base-page counts (diff
and sc->nr_to_scan) as num_to_free with page_budget =3D 0, over-shrinking
high-order pools by a factor of 1 << pt->order.

Converting num_to_free from base pages to compound entries inside
ttm_pool_shrink() and passing min(batch, pages - reserve) from
ttm_pool_shrink_idle() would keep all callers in base-page units without
needing a separate page_budget parameter.

> @@ -513,7 +524,12 @@ static void ttm_pool_shrink_idle(struct work_struct =
*work)
>  	int nid;
> =20
>  	for_each_node_state(nid, N_MEMORY) {
> -		while (atomic_long_read(&allocated_pages[nid]) > 0) {
> +		unsigned long reserve =3D min(page_pool_idle_reserve,
> +					    pool_node_limit[nid]);
> +		long pages;
> +
> +		while ((pages =3D atomic_long_read(&allocated_pages[nid])) > 0 &&
> +		       pages > reserve) {
>  			unsigned long now =3D jiffies;
>  			unsigned long expires =3D READ_ONCE(pool_last_return) +
>  						pool_idle_delay;
> @@ -524,7 +540,7 @@ static void ttm_pool_shrink_idle(struct work_struct *=
work)
>  				return;
>  			}
> =20
> -			ttm_pool_shrink(nid, batch);
> +			ttm_pool_shrink(nid, batch, pages - reserve);
>  			cond_resched();
>  		}
>  	}

[Severity: Medium]
Can ttm_pool_shrink_idle() drain the pool below reserve and busy-spin when
another thread is concurrently disposing pages?

list_lru_walk_node() isolates a batch of entries from pt->pages onto a
local dispose list, while ttm_pool_dispose_list() decrements
allocated_pages[nid] one entry at a time across ttm_pool_free_page()
calls:

CPU0 (ttm_pool_shrinker_scan)     CPU1 (ttm_pool_shrink_idle)
ttm_pool_shrink()
  list_lru_walk_node()
    /* isolates pages to dispose */
                                  pages =3D atomic_long_read(&allocated_pag=
es[nid])
                                  /* still includes CPU0's isolated pages */
                                  ttm_pool_shrink(nid, batch, pages - reser=
ve)
                                    /* drains pt->pages below reserve */
  ttm_pool_dispose_list()
    atomic_long_sub(...)
    ttm_pool_free_page(...)

While CPU0 is freeing its dispose list (which on x86 issues per-entry
set_pages_wb() TLB shootdowns for WC/UC pages), allocated_pages[nid] stays
elevated above the number of pages still on pt->pages.  CPU1 computes
pages - reserve from that stale total and drains remaining pooled pages
below reserve.  If all pt->pages on the node become empty while CPU0's
in-flight dispose list still holds more than reserve pages, CPU1 loops
with ttm_pool_shrink() returning 0, repeatedly rotating shrinker_list
under pool_shrink_rwsem and shrinker_lock until CPU0 decrements
allocated_pages[nid] to or below reserve.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124222812.5118=
67-2-eduardoprocopiogomez@gmail.com?part=3D2
