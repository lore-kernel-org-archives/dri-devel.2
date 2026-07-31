Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 874A0C55167
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 05:42:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CBE410E168;
	Fri, 31 Jul 2026 05:42:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oE9JEUtz";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F4C110E168
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 05:42:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 293C2600C8;
 Fri, 31 Jul 2026 05:42:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B36BB1F000E9;
 Fri, 31 Jul 2026 05:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785476568;
 bh=6/P95GWWqy8DQz2mslmo6x7WQMpSI3qSlzhcnLycm2g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=oE9JEUtz794uRKLhnbtEg5GUdG05ni0Z+yLUYUKLTcYoBvakP8hvixFGfRa17HyL1
 PvyhwXa7NSCRr2V1/mJb0GZYIGUC9rlRwz6Fg35CH8W2bm5jLaODWWNDAl269ov2q8
 IPnSrk2bjaDyNwfV0aBDEilpxveNY9lwfJdax9H0pAPAM3CmIB7Qx36OyopDsCm+X1
 CB+ffoNQFs+GnxMKMFD289MwsLs0rZnmA3Oz6r47Q40e3QlOtTYrkM+Ag5TglolCQn
 QLDzhigeUM6cVMsKjT4O83lYTBLAY4Lg5qg/JjuwdWCTItJCjYbEw+gn6m1MelD52P
 bZW8wjgdDJImQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ttm: Add error handling for ttm_pool_mgr_init()
To: =?utf-8?b?w5NzY2FyIE1lZ8OtYSBMw7NwZXo=?= <megia.oscar@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260731053047.24503-1-megia.oscar@gmail.com>
References: <20260731053047.24503-1-megia.oscar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 05:42:48 +0000
Message-Id: <20260731054248.B36BB1F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Missing resource cleanup in `ttm_global_init()` error paths leads =
to use-after-free and memory leaks.
- [High] `ttm_pool_mgr_init()` NULL pointer dereference on memory-less NUMA=
 nodes.
- [High] `ttm_pool_type_init()` ignores the return value of `list_lru_init(=
)`, leading to NULL pointer dereference on allocation failure.
--

--- Patch [1]: [PATCH] ttm: Add error handling for ttm_pool_mgr_init() ---
commit 2f605d6f8238add861f5522786f57313330623f4
Author: =C3=93scar Meg=C3=ADa L=C3=B3pez <megia.oscar@gmail.com>

ttm: Add error handling for ttm_pool_mgr_init()

This commit updates ttm_global_init() to check the return value of
ttm_pool_mgr_init(). If initialization fails, it now correctly jumps to the
error path to prevent the system from continuing with an invalid pool
manager state.

> diff --git a/drivers/gpu/drm/ttm/ttm_device.c b/drivers/gpu/drm/ttm/ttm_d=
evice.c
> index d3bfb9a696a74..c880a04303635 100644
> --- a/drivers/gpu/drm/ttm/ttm_device.c
> +++ b/drivers/gpu/drm/ttm/ttm_device.c
> @@ -96,7 +96,10 @@ static int ttm_global_init(void)
>  		>> PAGE_SHIFT;
>  	num_dma32 =3D min(num_dma32, 2UL << (30 - PAGE_SHIFT));
> =20
> -	ttm_pool_mgr_init(num_pages);
> +	ret =3D ttm_pool_mgr_init(num_pages);
> +	if (ret)
> +		goto out;
> +

[Severity: High]
This is a pre-existing issue, but looking into ttm_pool_mgr_init(), it
iterates over all possible nodes:

drivers/gpu/drm/ttm/ttm_pool.c:ttm_pool_mgr_init() {
    ...
    for_each_node(nid) {
        if (!page_pool_size) {
            u64 node_size =3D ttm_get_node_memory_size(nid);
    ...
}

And ttm_get_node_memory_size() directly dereferences NODE_DATA(nid):

drivers/gpu/drm/ttm/ttm_pool.c:ttm_get_node_memory_size() {
    pg_data_t *pgdat =3D NODE_DATA(nid);

    for (zone_type =3D 0; zone_type < MAX_NR_ZONES; zone_type++)
        managed_pages +=3D
            zone_managed_pages(&pgdat->node_zones[zone_type]);
    ...
}

Can this trigger a NULL pointer dereference on systems with memory-less NUMA
nodes since it uses for_each_node() instead of
for_each_node_state(nid, N_MEMORY)?

[Severity: High]
This is also a pre-existing issue, but further down in the pool manager
initialization, ttm_pool_type_init() calls list_lru_init() without checking
its return value:

drivers/gpu/drm/ttm/ttm_pool.c:ttm_pool_type_init() {
    ...
    list_lru_init(&pt->pages);
    ...
}

Since list_lru_init() can fail and return an error code like -ENOMEM, does
ignoring this return value leave the list_lru structure in an invalid state?

Could this lead to a crash later in ttm_pool_type_give() when list_lru_add()
attempts to use the unallocated internal node arrays?

[Severity: High]
This isn't a bug introduced by this patch, but if alloc_page() fails later
in ttm_global_init(), we jump to this same out label.

Looking at the out block:

out:
	if (ret && ttm_debugfs_root)
		debugfs_remove(ttm_debugfs_root);
	if (ret)
		--ttm_glob_use_count;
	mutex_unlock(&ttm_global_mutex);
	return ret;

Does this leave the mm_shrinker registered in the global shrinker list since
ttm_pool_mgr_fini() is never called in this error path?=20

If the driver module is subsequently unloaded, could the shrinker's callback
pointers point to freed module text and cause a use-after-free on the next
shrinker invocation?

>  	ttm_tt_mgr_init(num_pages, num_dma32);
> =20
>  	glob->dummy_read_page =3D alloc_page(__GFP_ZERO | GFP_DMA32 |

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731053047.2450=
3-1-megia.oscar@gmail.com?part=3D1
