Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29BABC5B56A
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 19:55:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4005D10ED8B;
	Tue, 11 Aug 2026 19:55:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="d9D7ESr2";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68F2A10ED89
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 19:54:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4F22440C0B;
 Tue, 11 Aug 2026 19:54:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0583E1F000E9;
 Tue, 11 Aug 2026 19:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786478099;
 bh=67e3iERBHrS32McnBIivgcOtUKCdpEXV4yPYGbWlZ9w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=d9D7ESr2Y6ZaDVLsaLNoj170u6wLnNlxP7c17s/IUixhl96+nxeaWfbBqdW0JlJk+
 WzDoTIzNFzTQ5UwoivfEA2aExSDTs6fX0AEsMikzLLWiz0sepHHwPU9scPiJZsjoSp
 kbjFP4DtgZirI4xUlO1s0MloYy3nXklFeEMZT5rEPSm1h4IpLYdEB5FcR4NYVw4AwQ
 aXkQFPLfLr/iD3FEe3GPIXSSwhVO0ouGaizMRLYY/bgEL9zzO1iu7c56iFbuVE2TpF
 eQoTwXB0UAqMyRTCwOD+GJ+dZoLUDEkeglFxkp8YIBNQnjS1/viTW4bf5XaI2gp43q
 fBP7OVWLgnLyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/6] Memory leak error in qxl unbind
To: =?utf-8?b?w5NzY2FyIE1lZ8OtYSBMw7NwZXo=?= <megia.oscar@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260811194224.121597-2-megia.oscar@gmail.com>
References: <20260811194224.121597-1-megia.oscar@gmail.com>
 <20260811194224.121597-2-megia.oscar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Aug 2026 19:54:58 +0000
Message-Id: <20260811195459.0583E1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] Missing `up_read(&pool_shrink_rwsem)` on the early return path in =
`ttm_pool_shrink()` causes a lock leak and subsequent deadlocks.
- [High] Callers of `ttm_pool_init()` are not updated to check its new `int=
` return value, leading to NULL pointer dereferences on initialization fail=
ure.
- [Low] Assigning the `void` return value of `ttm_pool_type_init()` to an `=
int` variable causes a compilation failure.
- [Low] Reinventing `list_empty()` with direct manual pointer comparisons.

Pre-existing issues:
- [High] Missing `list_lru_destroy()` in normal pool teardown paths (`ttm_p=
ool_fini()` and `ttm_pool_mgr_fini()`) causes persistent memory leaks.
--

--- Patch [1]: [PATCH v5 1/6] Memory leak error in qxl unbind ---
commit 575a0762d1411d04c459167fe4dee31c7eee4aff
Author: =C3=93scar Meg=C3=ADa L=C3=B3pez <megia.oscar@gmail.com>

Memory leak error in qxl unbind

This commit attempts to fix a refcount corruption and memory leak in qxl
unbind by changing ttm_pool_init to return an error, checking for an empty
shrinker_list, and cleaning up list_lru structures on init failure.

Link: https://lore.kernel.org/lkml/20260727110212.64913-1-megia.oscar@gmail=
.com/
Link: https://lore.kernel.org/dri-devel/20260731053047.24503-1-megia.oscar@=
gmail.com/

> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_poo=
l.c
> index 1bf37023fed66..73284497cc785 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> @@ -457,13 +457,21 @@ static unsigned int ttm_pool_shrink(int nid, unsign=
ed long num_to_free)
>  	LIST_HEAD(dispose);
>  	struct ttm_pool_type *pt;
>  	unsigned int num_pages;
> +	int empty =3D 0;
> =20
>  	down_read(&pool_shrink_rwsem);
>  	spin_lock(&shrinker_lock);
> -	pt =3D list_first_entry(&shrinker_list, typeof(*pt), shrinker_list);
> -	list_move_tail(&pt->shrinker_list, &shrinker_list);
> +	if ((shrinker_list.prev =3D=3D &shrinker_list) && (shrinker_list.next =
=3D=3D &shrinker_list)) {

[Severity: Low]
Could we use list_empty(&shrinker_list) here instead of manually checking
the prev and next pointers?

> +		empty =3D 1;
> +	} else {
> +		pt =3D list_first_entry(&shrinker_list, typeof(*pt), shrinker_list);
> +		list_move_tail(&pt->shrinker_list, &shrinker_list);
> +	}
>  	spin_unlock(&shrinker_lock);
> =20
> +	if (empty)
> +		return 0;

[Severity: High]
Does this early return leak the pool_shrink_rwsem read lock?

The down_read(&pool_shrink_rwsem) is acquired at the beginning of the
function, but if the shrinker_list is empty, this path returns early
without calling up_read().

This can cause any subsequent attempt to acquire a write lock (such as in
ttm_pool_synchronize_shrinkers during module unload) to block indefinitely
and deadlock the system.

[ ... ]

> @@ -1231,10 +1251,13 @@ long ttm_pool_backup(struct ttm_pool *pool, struc=
t ttm_tt *tt,
>   *
>   * Initialize the pool and its pool types.
>   */
> -void ttm_pool_init(struct ttm_pool *pool, struct device *dev,
> +int ttm_pool_init(struct ttm_pool *pool, struct device *dev,

[Severity: High]
Are the callers of ttm_pool_init() updated to check this new int return
value?

For example, ttm_device_init() calls ttm_pool_init() but ignores the return
value. If ttm_pool_init() fails under memory pressure and cleans up the
lists, proceeding with driver initialization can cause a NULL pointer
dereference when subsequent allocations attempt to use the destroyed LRU
lists.

>  		   int nid, unsigned int alloc_flags)
>  {
> -	unsigned int i, j;
> +	unsigned int i, j, k;
> +	int ret;
> +	struct ttm_pool_type *initialized[TTM_NUM_CACHING_TYPES * NR_PAGE_ORDER=
S];
> +	unsigned int n_initialized =3D 0;

[ ... ]

> @@ -1251,23 +1274,28 @@ void ttm_pool_init(struct ttm_pool *pool, struct =
device *dev,
>  			if (pt !=3D &pool->caching[i].orders[j])
>  				continue;
> =20
> -			ttm_pool_type_init(pt, pool, i, j);
> +			ret =3D ttm_pool_type_init(pt, pool, i, j);

[Severity: Low]
Does this assignment cause a build failure?

It appears ttm_pool_type_init() is still defined as returning void, so
assigning its result to the int ret variable will break the build.

> +			if (ret)
> +				goto error;
> +
> +			initialized[n_initialized++] =3D pt;
>  		}
>  	}
> =20
> +	return 0;
> +
> +error:
> +	for (k =3D 0; k < n_initialized; ++k)
> +		ttm_pool_type_fini(initialized[k]);

[Severity: High]
This is a pre-existing issue, but does ttm_pool_type_fini() fail to destroy
the list_lru structures?

While ttm_pool_type_fini() drains the LRU via list_lru_walk(), it doesn't
call list_lru_destroy(&pt->pages). This causes a persistent memory leak of
the node arrays on every device unbind or module unload where the normal
pool teardown paths (like ttm_pool_fini and ttm_pool_mgr_fini) are used.

> +
> +	ttm_pool_synchronize_shrinkers();
> +
> +	for (k =3D 0; k < n_initialized; ++k)
> +		list_lru_destroy(&initialized[k]->pages);
> +
> +	return ret;
>  }
> +EXPORT_SYMBOL(ttm_pool_init);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260811194224.1215=
97-1-megia.oscar@gmail.com?part=3D1
