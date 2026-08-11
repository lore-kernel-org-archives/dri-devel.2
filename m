Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DD01C5B56A
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 19:54:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B45C510ED77;
	Tue, 11 Aug 2026 19:54:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lmL8GtCO";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 384C010ED77
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 19:54:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A0361600AD;
 Tue, 11 Aug 2026 19:54:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CE1E1F000E9;
 Tue, 11 Aug 2026 19:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786478045;
 bh=jhn/SgroQoes6Fok1rrDaMrIZWRmguFPOEAZQP+vmIA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lmL8GtCO1bShQKtAvfNzJXnNW0yoIfGUqEAr7JXEpO4EqYR0zzC2A2SL+YM6lCrM4
 US1vgb5qYSPZU7ke04+bwa9bxdPegKButsBqEJcIV85BOEJtS5VRlbkpRvmEbPb6jb
 ZC3/In8qeu7YmfHexWoQYOqldHMky6p0nCePHdO0/vobodF35BKkUJyYZooK/n4Z9D
 oZSLsUMxWNTpkt40GmTKhj3C/wC3n6Z2gUXNV14id5Xs7XRuw+JO9AAn2v6Yo7oXki
 V0xFe8JBJyZQcY6nsr2tfOxTNQkdGwvmbeicD+n4+XRao+2P/d4QBKTDzWyJZ9UtVp
 YLYuV5gj/HdOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/6] ttm_pool_mgr_fini() does not destroy the list_lru
To: =?utf-8?b?w5NzY2FyIE1lZ8OtYSBMw7NwZXo=?= <megia.oscar@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260811194224.121597-6-megia.oscar@gmail.com>
References: <20260811194224.121597-1-megia.oscar@gmail.com>
 <20260811194224.121597-6-megia.oscar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Aug 2026 19:54:04 +0000
Message-Id: <20260811195405.3CE1E1F000E9@smtp.kernel.org>
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

New issues:
- [High] Destroying the global list_lru structures before removing the TTM =
debugfs files introduces a NULL pointer dereference vulnerability.

Pre-existing issues:
- [High] ttm_pool_shrink() leaks a read lock on pool_shrink_rwsem when shri=
nker_list is empty.
- [High] The `ttm_pool_shrinker_scan()` function can enter an infinite busy=
-loop if `allocated_pages` is positive but all `list_lru`s are empty.
--

--- Patch [5]: [PATCH v5 5/6] ttm_pool_mgr_fini() does not destroy the list=
_lru ---
commit 39533ac28eb17cc8fb3c32efa95aac77421f3675
Author: =C3=93scar Meg=C3=ADa L=C3=B3pez <megia.oscar@gmail.com>

ttm_pool_mgr_fini() does not destroy the list_lru

This commit adds list_lru_destroy() after ttm_pool_type_fini() to ensure
the list_lru structures are properly destroyed during pool manager teardown,
resolving a resource leak.

> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_poo=
l.c
> index 8d9891ea8c6aa..0d063df864f37 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> @@ -1678,16 +1678,7 @@ int ttm_pool_mgr_init(unsigned long num_pages)
>   */
>  void ttm_pool_mgr_fini(void)
>  {
[ ... ]
>  	shrinker_free(mm_shrinker);
> +	ttm_pool_type_fini_and_list_lru_destroy(NR_PAGE_ORDERS);

[Severity: High]
Does this introduce a race condition with debugfs?

Looking at the teardown sequence in ttm_global_release(), ttm_pool_mgr_fini=
()
is called before debugfs_remove(ttm_debugfs_root). This leaves a window
where the page_pool debugfs file remains accessible after the underlying
list_lru structures are completely destroyed.

If a user reads the page_pool debugfs file during this window,
ttm_pool_debugfs_globals_show() iterates over the global pool arrays and
calls list_lru_count(). Since list_lru_destroy() frees the internal nodes
array and sets lru->node to NULL, won't this result in a NULL pointer
dereference inside list_lru_count_node()?

This is a pre-existing issue, but I noticed a lock leak in ttm_pool_shrink()
that could be triggered during this same teardown window. When shrinker_list
is empty, ttm_pool_shrink() has an early return path:

drivers/gpu/drm/ttm/ttm_pool.c:ttm_pool_shrink() {
        down_read(&pool_shrink_rwsem);
        spin_lock(&shrinker_lock);
        if ((shrinker_list.prev =3D=3D &shrinker_list) && ...) {
                empty =3D 1;
        ...
        if (empty)
                return 0;
        ...
}

Since down_read(&pool_shrink_rwsem) is not released on this early return
path, won't this leak the read lock and cause a deadlock during subsequent
operations?

This is also a pre-existing issue, but the shrinker scan loop appears
vulnerable to an infinite busy-loop.

In ttm_pool_shrinker_scan(), there is a loop checking allocated_pages:

drivers/gpu/drm/ttm/ttm_pool.c:ttm_pool_shrinker_scan() {
        do
                num_freed +=3D ttm_pool_shrink(sc->nid, sc->nr_to_scan);
        while (num_freed < sc->nr_to_scan &&
               atomic_long_read(&allocated_pages[sc->nid]));
        ...
}

Meanwhile, ttm_pool_type_take() isolates pages from the LRU before
updating the counter:

drivers/gpu/drm/ttm/ttm_pool.c:ttm_pool_type_take() {
        ret =3D list_lru_walk_node(&pt->pages, ...);
        if (ret =3D=3D 1 && p) {
                atomic_long_sub(1 << pt->order, &allocated_pages[nid]);
        ...
}

During the window where a page is removed from the LRU but allocated_pages
has not yet been decremented, the LRU could be empty while allocated_pages
is still positive. If ttm_pool_shrinker_scan() runs concurrently and sees
ttm_pool_shrink() return 0, could it spin indefinitely without yielding the
CPU, especially since there is no cond_resched() inside the loop?

>  	WARN_ON(!list_empty(&shrinker_list));
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260811194224.1215=
97-1-megia.oscar@gmail.com?part=3D5
