Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A4DEC43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 05:44:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9943410E754;
	Mon,  6 Jul 2026 05:44:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="V9vL03by";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A04110E754
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 05:44:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BEBB241971;
 Mon,  6 Jul 2026 05:44:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E5D11F000E9;
 Mon,  6 Jul 2026 05:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783316697;
 bh=OxHad1Zlj2oHqsG/iYkmnhxjQBvIRsVB21S7s9tqkRY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=V9vL03byF6y2eGC9R3W9qW+M6OhCnwwG/i/wAxO16CtvVlSnejwPlTgDGovVUimBK
 M6AkjG+cumUA3hS5HL1WqdGQU3BAoF23L/pGuX9vd7xQsLWFx2Rq4nr5nD+uporfCA
 Fcd59GDXK8MsVb3uArX5kU5Z4ChDPtu+0sjGNPhISa2Fm0MOt18yZH5D41w3A4NlT2
 pHGzH4TiJ8kv8ThOuyrslLNn6BgrnfAVG+uu4CwBTc0wAWAlD/tyJnkjUWkTmX8I6I
 9KsVFiDuaq3gYNw9LeetRTXlQYXDiQ7snHspH+sMEtTE3Y7xFjtNHss63oW6I9bwCi
 6PSCVrFrj66ng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/10] ttm/pool: enable memcg tracking and shrinker. (v3)
To: "Dave Airlie" <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org, hannes@cmpxchg.org, tj@kernel.org,
 mkoutny@suse.com
In-Reply-To: <20260706052330.1110909-6-airlied@gmail.com>
References: <20260706052330.1110909-1-airlied@gmail.com>
 <20260706052330.1110909-6-airlied@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 05:44:56 +0000
Message-Id: <20260706054457.5E5D11F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 10 potential issue=
(s) to consider:
- [Critical] Direct map caching attributes (WC/UC) are not restored to Writ=
e-Back (WB) when a page is freed due to a memcg charging failure.
- [High] Missing `list_lru_destroy()` causes global list corruption and Use=
-After-Free when TTM pools are destroyed.
- [High] ttm_pool_check_objcg fails to allocate memcg LRU entries for devic=
e-specific pools, breaking memcg-aware shrinking.
- [High] ttm_pool_shrinker_count returns the global pool count instead of t=
he memcg-specific count, breaking memcg reclaim proportionality.
- [High] A race condition in `ttm_pool_type_give()` allows the shrinker to =
free a page before local metadata updates finish.
- [High] Uncharged pages stolen from the root pool by accounted BOs are not=
 charged to the requesting memcg.
- [Medium] Ignoring `memcg_list_lru_alloc()` failure causes a `VM_WARN_ON` =
when freeing pages to the pool.
- [Medium] ttm_pool_check_objcg hardcodes GFP_KERNEL, ignoring the caller's=
 allocation context flags.
- [Medium] Missing `up_read(&pool_shrink_rwsem)` when `shrinker_list` is em=
pty in `ttm_pool_shrink`.
- [Low] Off-by-two loop bounds error in `ttm_pool_shrinker_scan()` causes r=
edundant scanning iterations.
--

commit 3d1a95525ccb3182a802e2681e222aef27971cef
Author: Dave Airlie <airlied@redhat.com>
Subject: ttm/pool: enable memcg tracking and shrinker. (v3)

This patch introduces memory cgroup (memcg) tracking and memcg-aware shrink=
ing
for the TTM page pool. It updates the LRU lists to operate in memcg mode and
allows pooled pages reparented to a higher memcg to be reused.

[ ... ]
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
[ ... ]
> @@ -317,12 +321,11 @@ static void ttm_pool_type_give(struct ttm_pool_type=
 *pt, struct page *p)
> =20
>  	INIT_LIST_HEAD(&p->lru);
>  	rcu_read_lock();
> -	list_lru_add(&pt->pages, &p->lru, nid, NULL);
> +	list_lru_add(&pt->pages, &p->lru, nid, page_memcg_check(p));
>  	rcu_read_unlock();
> =20
>  	atomic_long_add(num_pages, &allocated_pages[nid]);
> -	mod_lruvec_page_state(p, NR_GPU_ACTIVE, -num_pages);
> -	mod_lruvec_page_state(p, NR_GPU_RECLAIM, num_pages);
> +	mem_cgroup_move_gpu_page_reclaim(NULL, p, pt->order, true);

[Severity: High]
Can a background shrinker isolate and free this page before local metadata
updates finish? Calling list_lru_add() exposes the page to the global LRU.
If a shrinker frees it concurrently, the subsequent call to
mem_cgroup_move_gpu_page_reclaim() will dereference page_objcg(p) on a freed
page, causing a use-after-free regression.

>  }
> =20
>  static enum lru_status take_one_from_lru(struct list_head *item,
[ ... ]
> @@ -337,20 +340,56 @@ static enum lru_status take_one_from_lru(struct lis=
t_head *item,
> +static int pool_lru_get_page(struct ttm_pool_type *pt, int nid,
> +			     struct page **page_out,
> +			     struct obj_cgroup *objcg,
> +			     struct mem_cgroup *memcg)
>  {
>  	int ret;
>  	struct page *p =3D NULL;
>  	unsigned long nr_to_walk =3D 1;
> +	unsigned int num_pages =3D 1 << pt->order;
> =20
> -	ret =3D list_lru_walk_node(&pt->pages, nid, take_one_from_lru, (void *)=
&p, &nr_to_walk);
> +	ret =3D list_lru_walk_one(&pt->pages, nid, memcg, take_one_from_lru, (v=
oid *)&p, &nr_to_walk);
>  	if (ret =3D=3D 1 && p) {
> -		atomic_long_sub(1 << pt->order, &allocated_pages[nid]);
> -		mod_lruvec_page_state(p, NR_GPU_ACTIVE, (1 << pt->order));
> -		mod_lruvec_page_state(p, NR_GPU_RECLAIM, -(1 << pt->order));
> +		atomic_long_sub(num_pages, &allocated_pages[nid]);
> +
> +		if (!mem_cgroup_move_gpu_page_reclaim(objcg, p, pt->order, false)) {
> +			__free_pages(p, pt->order);
> +			p =3D NULL;
> +		}

[Severity: Critical]
When mem_cgroup_move_gpu_page_reclaim() fails, calling __free_pages()
directly bypasses ttm_pool_free_page(). Does this skip restoring x86 direct
map cache attributes to Write-Back via set_pages_wb? Returning WC or UC pag=
es
to the kernel allocator could cause Machine Check Exceptions or data
corruption. Additionally, if the page was allocated via the DMA API, this
would leak the DMA mapping by skipping dma_free_attrs().

>  	}
> -	return p;
> +	*page_out =3D p;
> +	return ret;
> +}
> +
> +/* Take pages from a specific pool_type, return NULL when nothing availa=
ble */
> +static struct page *ttm_pool_type_take(struct ttm_pool_type *pt, int nid,
> +				       struct obj_cgroup *orig_objcg)
> +{
[ ... ]
> +	/*
> +	 * Attempt to get a page from the current memcg, but if it hasn't got a=
ny in it's level,
> +	 * go up to the parent and check there. This helps the scenario where m=
ultiple apps get
> +	 * started into their own cgroup from a common parent and want to reuse=
 the pools.
> +	 */
> +	while (!page_out) {
> +		ret =3D pool_lru_get_page(pt, nid, &page_out, orig_objcg, memcg);
> +		if (ret =3D=3D 1)
> +			break;
> +		if (!memcg)
> +			break;
> +		memcg =3D parent_mem_cgroup(memcg);
> +		if (!memcg)
> +			break;
> +	}

[Severity: High]
When taking an uncharged page from the root pool, does this loop pass it
downstream to be incorrectly handled as uncharged? In
mem_cgroup_move_gpu_page_reclaim(), an early exit for missing objcg skips
charging the new_objcg. This would allow an accounted buffer object to steal
uncharged pages from the root pool without being charged for them, bypassing
container memory limits.

> +
> +	mem_cgroup_put(orig_memcg);
> +	return page_out;
>  }
> =20
>  /* Initialize and add a pool type to the global shrinker list */
> @@ -360,7 +399,7 @@ static void ttm_pool_type_init(struct ttm_pool_type *=
pt, struct ttm_pool *pool,
>  	pt->pool =3D pool;
>  	pt->caching =3D caching;
>  	pt->order =3D order;
> -	list_lru_init(&pt->pages);
> +	list_lru_init_memcg(&pt->pages, mm_shrinker);

[Severity: High]
Since list_lru_init_memcg() registers the LRU lists to the global
memcg_list_lrus list, do we need a corresponding list_lru_destroy() in
ttm_pool_type_fini()? Without it, unloading a TTM device and freeing the po=
ol
memory could leave the LRU list linked in the global list, leading to a
use-after-free regression during subsequent memcg operations.

> =20
>  	spin_lock(&shrinker_lock);
>  	list_add_tail(&pt->shrinker_list, &shrinker_list);
[ ... ]
> +/*
> + * This function doesn't currently check dma32, because no driver using =
this
> + * support dma32. This should be added and debugged when that changes.
> + */
> +static void ttm_pool_check_objcg(struct obj_cgroup *objcg)
> +{
> +#ifdef CONFIG_MEMCG
> +	int r =3D 0;
> +	struct mem_cgroup *memcg;
> +	if (!objcg)
> +		return;
> +
> +	memcg =3D get_mem_cgroup_from_objcg(objcg);
> +	for (unsigned i =3D 0; i < NR_PAGE_ORDERS; i++) {
> +		r =3D memcg_list_lru_alloc(memcg, &global_write_combined[i].pages, GFP=
_KERNEL);

[Severity: Medium]
Could using GFP_KERNEL here unconditionally be unsafe? The caller
__ttm_pool_alloc() determines safe allocation flags (such as handling
gfp_retry_mayfail), but they are ignored here. This might trigger the OOM
killer unexpectedly or cause deadlocks if called from contexts where FS/IO
operations are unsafe.

> +		if (r)
> +			break;

[Severity: Medium]
Does ignoring the memcg_list_lru_alloc() failure here lead to a VM_WARN_ON
later? If the allocation fails due to memory pressure and we break early,
freeing pages to this LRU might cause list_lru_add() to fail finding the
memcg-specific list. This would fall back to the parent memcg and potential=
ly
break accurate tracking.

> +		r =3D memcg_list_lru_alloc(memcg, &global_uncached[i].pages, GFP_KERNE=
L);
> +		if (r)
> +			break;
> +	}

[Severity: High]
Is it intentional to only pre-allocate global_write_combined and
global_uncached here? The global_dma32_* pools and any device-specific cach=
ing
pools appear to be missing. Pages added to these uninitialized pools might =
hit
a VM_WARN_ON and fall back to the parent memcg, completely breaking
memcg-aware shrinking for them.

> +	mem_cgroup_put(memcg);
> +#endif
> +}
[ ... ]
>  /* Free pages using the per-node shrinker list */
> -static unsigned int ttm_pool_shrink(int nid, unsigned long num_to_free)
> +static unsigned int ttm_pool_shrink(int nid,
> +				    struct mem_cgroup *memcg,
> +				    unsigned long num_to_free)
>  {
>  	LIST_HEAD(dispose);
>  	struct ttm_pool_type *pt;
> @@ -448,7 +514,11 @@ static unsigned int ttm_pool_shrink(int nid, unsigne=
d long num_to_free)
>  	if (!pt)
>  		return 0;

[Severity: Medium]
If shrinker_list is empty and we return 0 early, does this leak the
pool_shrink_rwsem read lock? A missing up_read() here could eventually lead
to deadlocks when a writer tries to acquire the lock.

> =20
> -	num_pages =3D list_lru_walk_node(&pt->pages, nid, pool_move_to_dispose_=
list, &dispose, &num_to_free);
> +	if (!memcg) {
> +		num_pages =3D list_lru_walk_node(&pt->pages, nid, pool_move_to_dispose=
_list, &dispose, &num_to_free);
> +	} else {
> +		num_pages =3D list_lru_walk_one(&pt->pages, nid, memcg, pool_move_to_d=
ispose_list, &dispose, &num_to_free);
> +	}
>  	num_pages *=3D 1 << pt->order;
[ ... ]
> @@ -1214,10 +1288,14 @@ static unsigned long ttm_pool_shrinker_scan(struc=
t shrinker *shrink,
>  					    struct shrink_control *sc)
>  {
>  	unsigned long num_freed =3D 0;
> +	int num_pools;
> +	spin_lock(&shrinker_lock);
> +	num_pools =3D list_count_nodes(&shrinker_list);
> +	spin_unlock(&shrinker_lock);
> =20
>  	do
> -		num_freed +=3D ttm_pool_shrink(sc->nid, sc->nr_to_scan);
> -	while (num_freed < sc->nr_to_scan &&
> +		num_freed +=3D ttm_pool_shrink(sc->nid, sc->memcg, sc->nr_to_scan);
> +	while (num_pools-- >=3D 0 && num_freed < sc->nr_to_scan &&

[Severity: Low]
Does the num_pools-- >=3D 0 condition cause redundant scanning iterations? =
If
num_pools is 1, the loop executes for 1, 0, and -1, resulting in 3 iteratio=
ns
instead of 1. This would force redundant scanning of the same pools in the =
LRU
and waste CPU cycles.

>  	       atomic_long_read(&allocated_pages[sc->nid]));
> =20
>  	sc->nr_scanned =3D num_freed;
> @@ -1406,7 +1484,7 @@ int ttm_pool_mgr_init(unsigned long num_pages)
>  	spin_lock_init(&shrinker_lock);
>  	INIT_LIST_HEAD(&shrinker_list);
> =20
> -	mm_shrinker =3D shrinker_alloc(SHRINKER_NUMA_AWARE, "drm-ttm_pool");
> +	mm_shrinker =3D shrinker_alloc(SHRINKER_MEMCG_AWARE | SHRINKER_NUMA_AWA=
RE, "drm-ttm_pool");

[Severity: High]
With SHRINKER_MEMCG_AWARE enabled, the shrinker is expected to report the
number of objects owned by sc->memcg. However, ttm_pool_shrinker_count()
unconditionally returns the total number of pages in the global pool
(allocated_pages[sc->nid]). Could this falsely inflate the target memcg's
apparent footprint, tricking the VM into applying massive, disproportionate
reclaim pressure against it?

>  	if (!mm_shrinker)
>  		return -ENOMEM;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706052330.1110=
909-1-airlied@gmail.com?part=3D5
