Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE25C43602
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 02:56:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A5AA10E717;
	Mon,  6 Jul 2026 02:56:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lsfrHlt9";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 164DD10E717
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 02:56:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5926C60018;
 Mon,  6 Jul 2026 02:56:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 552FC1F000E9;
 Mon,  6 Jul 2026 02:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783306605;
 bh=30qQkhTkI8jLm0e5t/k22P15f/yixqmRqfav1P509dE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lsfrHlt9gX4DYUMtAr/sQAOvBllir59eAEusWGiBovG1RBWKyGJoN84P+lzJ4wAvy
 U0jhw70kc5w82tNZRbkID1LxhzBHuti64GoEO9Fts/yxUd3PXc1lxcx9pRv+qmyXhy
 DxQsbiGX++12aiyFA7jx31luY0Att5tzRoTsY+6dkxZJn/qLTCH/k5I5MkZGujKYrx
 37Hh7Z9mXzU2fp+cxnqnBtE8twO1QScbgOKfrA8WT5qvB4y+RmImutMiSlyrL12gMs
 Sd5F8H1F/qPZtXNrgl/F0oNZotakwmsfTM6IYAIyvKINQXRDuwMiaGLWVB4pK8f2mp
 gQsmTXp9oZ+rQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/10] ttm/pool: initialise the shrinker earlier
To: "Dave Airlie" <airlied@gmail.com>
Cc: tj@kernel.org, mkoutny@suse.com, hannes@cmpxchg.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260706024122.853329-4-airlied@gmail.com>
References: <20260706024122.853329-1-airlied@gmail.com>
 <20260706024122.853329-4-airlied@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 02:56:43 +0000
Message-Id: <20260706025644.552FC1F000E9@smtp.kernel.org>
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

New issues:
- [Critical] Premature shrinker registration leads to kernel crash on empty=
 list traversal
- [High] Unhandled memory allocation failure in ttm_pool_mgr_init() leaves =
global memory pools uninitialized

Pre-existing issues:
- [Critical] Concurrent shrinker invocation during module teardown causes i=
nvalid pointer dereference
- [High] Missing error handling for list_lru_init_memcg() leading to NULL p=
ointer dereference
--

commit 979d1132acdad03dc6f5c6c5ed80def9a1603b9f
Author: Dave Airlie <airlied@redhat.com>

ttm/pool: initialise the shrinker earlier

Later memcg enablement needs the shrinker initialised before the list lru,
Just move it for now.

> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_poo=
l.c
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> @@ -1402,6 +1402,17 @@ int ttm_pool_mgr_init(unsigned long num_pages)
>  	spin_lock_init(&shrinker_lock);
>  	INIT_LIST_HEAD(&shrinker_list);
> =20
> +	mm_shrinker =3D shrinker_alloc(SHRINKER_NUMA_AWARE, "drm-ttm_pool");
> +	if (!mm_shrinker)
> +		return -ENOMEM;
> +

[Severity: High]
If shrinker_alloc() fails here and returns -ENOMEM, ttm_pool_mgr_init()
exits early before initializing global_write_combined, global_uncached, and
other pools.

Since the caller ttm_global_init() ignores the return value of
ttm_pool_mgr_init(), will this allow TTM initialization to continue with
uninitialized global pools, resulting in a NULL pointer dereference later
when list_lru_walk_one() accesses the zero-initialized list_lru structures?

> +	mm_shrinker->count_objects =3D ttm_pool_shrinker_count;
> +	mm_shrinker->scan_objects =3D ttm_pool_shrinker_scan;
> +	mm_shrinker->batch =3D TTM_SHRINKER_BATCH;
> +	mm_shrinker->seeks =3D 1;
> +
> +	shrinker_register(mm_shrinker);
> +

[Severity: Critical]
Does registering the shrinker at this point expose it before the
shrinker_list is populated by ttm_pool_type_init() in the loop below?

If the shrinker is invoked immediately, for example via memory pressure or
a debugfs write, ttm_pool_shrink() will perform list_first_entry() on an
empty shrinker_list:

ttm_pool_shrinker_scan()->ttm_pool_shrink() {
        spin_lock(&shrinker_lock);
        pt =3D list_first_entry(&shrinker_list, typeof(*pt), shrinker_list);
        list_move_tail(&pt->shrinker_list, &shrinker_list);
        spin_unlock(&shrinker_lock);
}

Could this result in a kernel panic by returning a garbage pointer from the
empty list and passing it to list_lru_walk_node()?

>  	for (i =3D 0; i < NR_PAGE_ORDERS; ++i) {
>  		ttm_pool_type_init(&global_write_combined[i], NULL,
>  				   ttm_write_combined, i);

[Severity: High]
This is a pre-existing issue, but is it safe to ignore the return value of
list_lru_init_memcg() called internally by ttm_pool_type_init()?

ttm_pool_type_init() {
        ...
        list_lru_init_memcg(&pt->pages, mm_shrinker);
}

If list_lru_init_memcg() fails due to system memory pressure and returns an
error code like -ENOMEM, pt->pages.node remains NULL while the pool type is
still added to the active lists. Could subsequent operations like
list_lru_add() dereference this NULL pointer?

[ ... ]

[Severity: Critical]
This is a pre-existing issue, but looking at the teardown path
in ttm_pool_mgr_fini(), the global pools are destroyed and removed from
shrinker_list before the shrinker is unregistered:

ttm_pool_mgr_fini() {
        for (i =3D 0; i < NR_PAGE_ORDERS; ++i) {
                ttm_pool_type_fini(&global_write_combined[i]);
                ...
        }
        shrinker_free(mm_shrinker);
}

If the shrinker is invoked concurrently during this window, it will again
execute list_first_entry() on an empty shrinker_list in ttm_pool_shrink().

Unlike ttm_pool_fini(), ttm_pool_mgr_fini() does not call
ttm_pool_synchronize_shrinkers() before destroying the pools. Does this
leave a window open for an invalid pointer dereference during module
teardown?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706024122.8533=
29-1-airlied@gmail.com?part=3D3
