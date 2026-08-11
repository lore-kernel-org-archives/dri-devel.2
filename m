Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B001C5AC67
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 19:54:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFD8210ED7E;
	Tue, 11 Aug 2026 19:54:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BCqjx3qp";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F55510ED7D
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 19:54:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3AD79437EB;
 Tue, 11 Aug 2026 19:54:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E54FC1F000E9;
 Tue, 11 Aug 2026 19:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786478068;
 bh=SSk6d2TjyCnMes44tH2R6JhM8GdEUnwv8JWqvmr2MFg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BCqjx3qp4F0v/Ibux+T6huGyqzk93WdV+x04hGhLO0Qq70sjmXr4jCqwNL8fjwiSA
 ExRUBJldDYbZfP9p3IGl3QXD8panDXCc1J0RsDeNLvRp8X+uFRIwDLQs8JwdJalKnU
 WBc902QRflnWT4pxucVdlT8hDGj02CkRml8XxN8pyVhFKH4D4kVZAG0xjqINjt8IoQ
 8T6G6HyIabbgn9HDoK6ZANILTfFrY8ZWVRYZMkBHfQ/2fy+4wq4jOAt6cAX+CBCYdB
 ieMPhHHy0rhLvtbvwGragnv0ziTLun2tsaIzhcXMJhZObY8TjnzYsBPBOeh/Vpj6oR
 8XgwgVup40j/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/6] ttm_pool_fini() does not destroy list lru
To: =?utf-8?b?w5NzY2FyIE1lZ8OtYSBMw7NwZXo=?= <megia.oscar@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260811194224.121597-4-megia.oscar@gmail.com>
References: <20260811194224.121597-1-megia.oscar@gmail.com>
 <20260811194224.121597-4-megia.oscar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Aug 2026 19:54:27 +0000
Message-Id: <20260811195427.E54FC1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

Pre-existing issues:
- [High] ttm_pool_mgr_init() ignores the return value of ttm_pool_type_init=
(), which can lead to a NULL pointer dereference.
- [High] ttm_pool_shrink() leaks the pool_shrink_rwsem read lock when the s=
hrinker list is empty.
- [High] ttm_global_init() ignores the return value of ttm_pool_mgr_init().
- [High] ttm_device_init() ignores the return value of ttm_pool_init(), cau=
sing a potential NULL pointer dereference.
- [Medium] Missing list_lru_destroy() in ttm_pool_mgr_fini() causes a memor=
y leak for global pools on module unload.
- [Medium] Memory leak on the shrinker_alloc() error path in ttm_pool_mgr_i=
nit().
--

--- Patch [3]: [PATCH v5 3/6] ttm_pool_fini() does not destroy list lru ---
commit bab162cb05ce53ff29cbacb61b7c2543d1b98ecc
Author: =C3=93scar Meg=C3=ADa L=C3=B3pez <megia.oscar@gmail.com>
ttm_pool_fini() does not destroy list lru

This commit adds a missing call to list_lru_destroy() in ttm_pool_fini()
after calling ttm_pool_type_fini(). It ensures the list lru structures
are properly destroyed when finalizing a ttm pool.

> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_poo=
l.c
> index e116b83db1356..b95c6548adf7f 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> @@ -1331,6 +1331,17 @@ void ttm_pool_fini(struct ttm_pool *pool)
>  	 * that no shrinker is concurrently freeing pages from the pool.
>  	 */
>  	ttm_pool_synchronize_shrinkers();
> +
> +	for (i =3D 0; i < TTM_NUM_CACHING_TYPES; ++i) {
> +		for (j =3D 0; j < NR_PAGE_ORDERS; ++j) {
> +			struct ttm_pool_type *pt;
> +
> +			pt =3D ttm_pool_select_type(pool, i, j);
> +			if (pt !=3D &pool->caching[i].orders[j])
> +				continue;
> +			list_lru_destroy(&pt->pages);
> +		}
> +	}
>  }
>  EXPORT_SYMBOL(ttm_pool_fini);

[Severity: Medium]
This is a pre-existing issue, but does ttm_pool_mgr_fini() leak memory
on module unload?

When the module is unloaded, it calls ttm_pool_type_fini() to free the page=
s,
but it appears to miss calling list_lru_destroy() for the global pools:

drivers/gpu/drm/ttm/ttm_pool.c:ttm_pool_mgr_fini() {
	for (i =3D 0; i < NR_PAGE_ORDERS; ++i) {
		ttm_pool_type_fini(&global_write_combined[i]);
		...
	}
}

Will this permanently leak the memory allocated for the list_lru structures
during initialization?

[Severity: High]
This isn't a bug introduced by this patch, but does ttm_pool_mgr_init()
ignore the return value of ttm_pool_type_init()?

If list_lru_init() fails due to memory exhaustion, the pool's list_lru
remains uninitialized. The loop continues without aborting:

drivers/gpu/drm/ttm/ttm_pool.c:ttm_pool_mgr_init() {
	for (i =3D 0; i < NR_PAGE_ORDERS; ++i) {
		ttm_pool_type_init(&global_write_combined[i], NULL,
				   ttm_write_combined, i);
		...
	}
}

Later, when pages are freed, list_lru_add() might blindly dereference
a NULL lru->node array:

drivers/gpu/drm/ttm/ttm_pool.c:ttm_pool_type_give() {
	rcu_read_lock();
	list_lru_add(&pt->pages, &p->lru, nid, NULL);
	rcu_read_unlock();
}

Could this cause a kernel panic?

[Severity: High]
This is a pre-existing issue, but does ttm_pool_shrink() leak the
pool_shrink_rwsem read lock when the shrinker list is empty?

The read lock is acquired via down_read(&pool_shrink_rwsem). If the
shrinker_list is empty, it sets a flag and returns early without releasing
the lock:

drivers/gpu/drm/ttm/ttm_pool.c:ttm_pool_shrink() {
	down_read(&pool_shrink_rwsem);
	spin_lock(&shrinker_lock);
	if ((shrinker_list.prev =3D=3D &shrinker_list) && ...) {
		empty =3D 1;
	} else {
		...
	}
	spin_unlock(&shrinker_lock);

	if (empty)
		return 0;
}

Could this deadlock the system when subsequent attempts try to acquire
a write lock in ttm_pool_synchronize_shrinkers()?

[Severity: High]
This isn't a bug introduced by this patch, but does ttm_global_init() mask
initialization failures?

The return value of ttm_pool_mgr_init() is discarded:

drivers/gpu/drm/ttm/ttm_device.c:ttm_global_init() {
	ttm_pool_mgr_init(num_pages);
	ttm_tt_mgr_init(num_pages, num_dma32);
}

If ttm_pool_mgr_init() fails, mm_shrinker might be left as NULL, which
could break the memory reclaim subsystem for TTM pools. Should this error
be propagated?

[Severity: High]
This is a pre-existing issue, but does ttm_device_init() ignore the return
value of ttm_pool_init()?

If ttm_pool_init() fails, it cleans up its partial state and returns an err=
or
code, leaving bdev->pool uninitialized:

drivers/gpu/drm/ttm/ttm_device.c:ttm_device_init() {
	if (dev)
		nid =3D dev_to_node(dev);
	else
		nid =3D NUMA_NO_NODE;

	ttm_pool_init(&bdev->pool, dev, nid, alloc_flags);
}

During cleanup, ttm_device_fini() invokes ttm_pool_fini(), which calls
ttm_pool_type_fini(). This executes list_del(&pt->shrinker_list), which
might crash with a NULL pointer dereference because the list head was never
initialized. Can this lead to a crash on teardown?

[Severity: Medium]
This isn't a bug introduced by this patch, but is there a memory leak on
the shrinker_alloc() error path in ttm_pool_mgr_init()?

If shrinker_alloc() fails, the function returns directly:

drivers/gpu/drm/ttm/ttm_pool.c:ttm_pool_mgr_init() {
	mm_shrinker =3D shrinker_alloc(SHRINKER_NUMA_AWARE, "drm-ttm_pool");
	if (!mm_shrinker)
		return -ENOMEM;
}

Since the global pool types were already initialized dynamically, will
returning directly here permanently leak the list_lru memory allocated
for those pools?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260811194224.1215=
97-1-megia.oscar@gmail.com?part=3D3
