Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80DC4C5AD7B
	for <dri-devel@archiver.kernel.org>; Sun,  9 Aug 2026 17:04:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA52110E126;
	Sun,  9 Aug 2026 17:04:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="j2ItyCRJ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3E7510E126
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 17:04:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 48A1A41B0E;
 Sun,  9 Aug 2026 17:04:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 007951F000E9;
 Sun,  9 Aug 2026 17:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786295065;
 bh=Z3qbR6feuwzRaPQMtjcfZuaGPcTSzia7FiIaE8jX/4A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=j2ItyCRJov2wmbcmzpe0KfFHZyLOgFxHZdFpblBULqexMf4yyAsFTljC5rMFeP1xy
 yy79pdQEZnmZETpYS2wDcg62xS4rkRPkOjmZ/krvYd6yEi1rTzb1zJHZiQLR4vUw1e
 uYopaaeYw2FwAN1ndcO9J4Zbt/7xVboKQyeZLPZA1ygwZjac9KB3T+ZlRbebAzHesy
 myoLcBEimAAvqpCRO1CTuHWD/B2sryNzwtcDUqpf5duKxyZM1dk6LCJRzYaI4nPqU2
 /BTLAdey/zhrbrPj369OZR3HxvjvfUG8s2YirtlRlmrZTkvTyP2SEEL5sAzVfCGyG9
 +fJE2uDtsTGZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] Memory leak error in qxl unbind
To: =?utf-8?b?w5NzY2FyIE1lZ8OtYSBMw7NwZXo=?= <megia.oscar@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260809165326.164763-1-megia.oscar@gmail.com>
References: <20260809165326.164763-1-megia.oscar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Aug 2026 17:04:24 +0000
Message-Id: <20260809170425.007951F000E9@smtp.kernel.org>
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
- [Critical] The patch adds error cleanup to `ttm_pool_mgr_init()` (freeing=
 the shrinker and destroying pools), but the caller (`ttm_global_init()`) i=
gnores its return value. This leads to double-frees and NULL pointer derefe=
rences during teardown.
- [High] `ttm_pool_init()` ignores the newly added return value of `ttm_poo=
l_type_init()`, resulting in guaranteed NULL pointer dereferences during te=
ardown if initialization fails.
- [High] Lockless TOCTOU data race on `shrinker_list` emptiness check in `t=
tm_pool_shrink()` leads to invalid pointer dereference and memory corruptio=
n.
--

--- Patch [1]: [PATCH v4] Memory leak error in qxl unbind ---
commit ed37ece8c0ad50e1a16deff6653abfe2c17eb1a0
Author: =C3=93scar Meg=C3=ADa L=C3=B3pez <megia.oscar@gmail.com>
Subject: Memory leak error in qxl unbind

This commit addresses an OOM leak and refcount corruption in qxl unbind.
It adds proper cleanup and error propagation for list_lru_init() failures
during TTM pool initialization to ensure pool types are not left orphaned.

Link: https://lore.kernel.org/lkml/20260727110212.64913-1-megia.oscar@gmail=
.com/
Link: https://lore.kernel.org/dri-devel/20260731053047.24503-1-megia.oscar@=
gmail.com/

> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_poo=
l.c
> index 1bf37023fed66..6821fadf1a8d0 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> @@ -374,17 +374,23 @@ static struct page *ttm_pool_type_take(struct ttm_p=
ool_type *pt, int nid)
>  }
> =20
>  /* Initialize and add a pool type to the global shrinker list */
> -static void ttm_pool_type_init(struct ttm_pool_type *pt, struct ttm_pool=
 *pool,
> +static int ttm_pool_type_init(struct ttm_pool_type *pt, struct ttm_pool =
*pool,
>  			       enum ttm_caching caching, unsigned int order)

[Severity: High]
Since this function now returns an error code instead of void, do all calle=
rs
check the new return value?

Looking at ttm_pool_init() in drivers/gpu/drm/ttm/ttm_pool.c:

    ttm_pool_type_init(pt, pool, i, j);

If ttm_pool_type_init() returns an error, pt->shrinker_list remains
zero-initialized. Later, when ttm_pool_fini() calls ttm_pool_type_fini(),
it unconditionally runs:

    list_del(&pt->shrinker_list);

Will this cause a NULL pointer dereference on the zero-initialized list head
during teardown?

[ ... ]
> @@ -458,6 +464,9 @@ static unsigned int ttm_pool_shrink(int nid, unsigned=
 long num_to_free)
>  	struct ttm_pool_type *pt;
>  	unsigned int num_pages;
> =20
> +	if ((shrinker_list.prev =3D=3D &shrinker_list) && (shrinker_list.next =
=3D=3D &shrinker_list))
> +		return 0;
> +
>  	down_read(&pool_shrink_rwsem);
>  	spin_lock(&shrinker_lock);
>  	pt =3D list_first_entry(&shrinker_list, typeof(*pt), shrinker_list);

[Severity: High]
Is it safe to check if shrinker_list is empty without holding shrinker_lock?

If the list becomes empty between this check and acquiring shrinker_lock
(for example, if a concurrent thread calls ttm_pool_type_fini() during
device teardown), list_first_entry() will execute on an empty list.

This would return a pointer to the list head itself cast to a struct
ttm_pool_type pointer, which could lead to memory corruption when
list_move_tail() and list_lru_walk_node() are invoked on this invalid
pointer.

Could this check be safely moved inside the critical section?

[ ... ]
> @@ -1506,15 +1576,53 @@ int ttm_pool_mgr_init(unsigned long num_pages)
>  	spin_lock_init(&shrinker_lock);
>  	INIT_LIST_HEAD(&shrinker_list);
> =20
> +	mm_shrinker =3D shrinker_alloc(SHRINKER_NUMA_AWARE, "drm-ttm_pool");
> +	if (!mm_shrinker)
> +		return -ENOMEM;
> +
>  	for (i =3D 0; i < NR_PAGE_ORDERS; ++i) {
> -		ttm_pool_type_init(&global_write_combined[i], NULL,
> +		ret =3D ttm_pool_type_init(&global_write_combined[i], NULL,
>  				   ttm_write_combined, i);
> -		ttm_pool_type_init(&global_uncached[i], NULL, ttm_uncached, i);
> +		if (ret) {
> +			ttm_pool_type_fini_and_list_lru_destroy(i);
> +			shrinker_free(mm_shrinker);
> +			return ret;
> +		}

[Severity: Critical]
If ttm_pool_mgr_init() fails here, does the caller properly handle the
returned error?

If the caller (ttm_global_init()) ignores this error and continues executio=
n,
mm_shrinker is left pointing to freed memory while execution proceeds.

Then during module unload, ttm_pool_mgr_fini() unconditionally calls:

    shrinker_free(mm_shrinker);
    ttm_pool_type_fini_and_list_lru_destroy(NR_PAGE_ORDERS);

Could this lead to a double-free of mm_shrinker and potential NULL pointer
dereferences on the partially destroyed list structures?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260809165326.1647=
63-1-megia.oscar@gmail.com?part=3D1
