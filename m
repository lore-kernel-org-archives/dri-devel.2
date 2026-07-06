Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EAFBC43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 02:59:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90F0010E713;
	Mon,  6 Jul 2026 02:59:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VrYNd6HF";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02FA610E713
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 02:59:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 909FA42A7F;
 Mon,  6 Jul 2026 02:59:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBFC41F00A3A;
 Mon,  6 Jul 2026 02:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783306768;
 bh=hSvQSEbii60c/Xu+3Tx7KYMp/FUEhEr8Urglka/SiCw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VrYNd6HFCjIpC7jvMY05cPviMBc4aU0gGQrFTuz26sD6yX5cItI+58pD0lpXxtFom
 Urr0dBabeedbOA4q/nm4IHB16zI/0CYIvijgNXsarmchqQaKo60hX23ovgjNc1Ko6D
 JQjyW3d7YTuxOx5hx3UnG8OHdCBfyhwD2FlbZHtG/4cn8VjnY5kwEDegXVpWSTW5kN
 wVRp8WON1tSK89Hjd5E6hi7h9+BW8+wIc+QQc7sh7BQpvaoQpIW7trqxQOxAZMJ/o+
 sIldvQlupOjuV/pu+U8Ae8QU7LCuLf9l3rpzYDrqmWSSCEvNH0wSVAfn7a4wjbVaMC
 7nZpZFdPXGmLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/10] ttm/pool: enable memcg tracking and shrinker. (v3)
To: "Dave Airlie" <airlied@gmail.com>
Cc: mkoutny@suse.com, tj@kernel.org, dri-devel@lists.freedesktop.org,
 hannes@cmpxchg.org
In-Reply-To: <20260706024122.853329-6-airlied@gmail.com>
References: <20260706024122.853329-1-airlied@gmail.com>
 <20260706024122.853329-6-airlied@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 02:59:26 +0000
Message-Id: <20260706025927.BBFC41F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [Critical] Missing `list_lru_destroy` in `ttm_pool_type_fini` causes an e=
xploitable Use-After-Free during cgroup reparenting.
- [High] Missing `memcg_list_lru_alloc` for DMA32 pools and ignored allocat=
ion failures cause continuous `VM_WARN_ON` spam and broken isolation.
- [High] Clearing `page->memcg_data` before uncharging causes permanent mem=
cg charge leaks.
- [High] `pool_lru_get_page` frees write-combined or uncached pages directl=
y to the buddy allocator without restoring them to write-back, causing cach=
e aliasing.
- [High] `ttm_pool_check_objcg` hardcodes `GFP_KERNEL`, overriding caller c=
onstraints like `__GFP_RETRY_MAYFAIL`.
- [High] Unaccounted allocations from the pool permanently charge the old m=
emcg for active memory, breaking isolation.
- [Medium] `ttm_pool_shrinker_count` returns the global pool size rather th=
an the memcg-specific pool size, breaking memcg-aware reclaim heuristics.
--

commit 71c02307644b082161406f13e214b752caedbe33
Author: Dave Airlie <airlied@redhat.com>
Subject: ttm/pool: enable memcg tracking and shrinker. (v3)

This commit enables memcg tracking for the TTM pool backend and makes the
shrinker memcg aware. It also introduces logic to allow newer memcgs to
reparent and reuse pooled pages from parent memcgs.

[ ... ]
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
[ ... ]
> @@ -337,20 +340,56 @@ static enum lru_status take_one_from_lru(struct lis=
t_head *item,
[ ... ]
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

[Severity: High]
Does this direct call to __free_pages() bypass the required caching
restorations?

In pool_lru_get_page(), when mem_cgroup_move_gpu_page_reclaim() fails, the
page is freed directly to the buddy allocator. If the page came from a
write-combined or uncached pool, this skips the set_pages_wb() call normally
performed by ttm_pool_free_page().

Could this lead to cache aliasing issues and machine check exceptions on
architectures like x86 since the direct map caching attributes are not
restored to write-back?

[Severity: High]
Will unaccounted allocations permanently charge the previous memcg owner?

When a process not tracked by a memcg (or the root memcg) allocates memory
from the pool, pool_lru_get_page() passes a NULL objcg to
mem_cgroup_move_gpu_page_reclaim().=20

Looking at mm/memcontrol.c:mem_cgroup_move_gpu_page_reclaim(), if the new
objcg is NULL, it evaluates the condition (!new_objcg) as true and moves the
charge from NR_GPU_RECLAIM to NR_GPU_ACTIVE on the old memcg instead of
uncharging it.

Doesn't this leave the old memcg permanently charged for pages it no longer
owns while the root process uses them, breaking memcg isolation?

>  	}
> -	return p;
> +	*page_out =3D p;
> +	return ret;
> +}
[ ... ]
> @@ -403,6 +442,31 @@ static void ttm_pool_type_fini(struct ttm_pool_type =
*pt)
>  	ttm_pool_dispose_list(pt, &dispose);
>  }

[Severity: Critical]
Is list_lru_destroy() required here to prevent a use-after-free during
cgroup reparenting?

When a DRM driver unbinds or the TTM module is unloaded, ttm_pool_type_fini=
()
cleans up the pool type but does not call list_lru_destroy(). The list_lru
structures remain registered in the global memcg_list_lrus list.=20

If a memory cgroup is subsequently deleted, memcg_reparent_list_lrus()
iterates over this global list and accesses the freed memory. Can we add a
call to list_lru_destroy(&pt->pages) to safely unregister it?

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
> +		if (r)
> +			break;
> +		r =3D memcg_list_lru_alloc(memcg, &global_uncached[i].pages, GFP_KERNE=
L);
> +		if (r)
> +			break;
> +	}

[Severity: High]
Can skipping the global_dma32_* pools here cause kernel warning spam and
broken tracking?

The loop in ttm_pool_check_objcg() explicitly allocates list_lrus for
global_write_combined and global_uncached pools, but skips the DMA32
variants.=20

If a driver using DMA32 pools frees a page to the pool, list_lru_add() will
attempt to add it to the memcg's list. Because the list wasn't allocated,
lock_list_lru_of_memcg() fails to find the list, triggers a
VM_WARN_ON(!css_is_dying), and escalates to the parent memcg. Could this be
triggered trivially by userspace interacting with DMA32 DRM drivers inside a
memory cgroup?

[Severity: High]
Is it safe to use a hardcoded GFP_KERNEL allocation flag here?

The __ttm_pool_alloc() caller might operate under strict constraints, passi=
ng
a ttm_operation_ctx that sets gfp_retry_mayfail to avoid deadlocks with the
GPU shrinker.

Because ttm_pool_check_objcg() uses GFP_KERNEL directly instead of
propagating the caller's allocation flags, it drops constraints like
__GFP_RETRY_MAYFAIL and __GFP_NOWARN. Might this allow the allocator to blo=
ck
indefinitely or invoke the OOM killer while critical DRM locks are held?

> +	mem_cgroup_put(memcg);
> +#endif
> +}
[ ... ]
> @@ -612,6 +682,7 @@ static int ttm_pool_restore_commit(struct ttm_pool_tt=
_restore *restore,
>  			 */
>  			ttm_pool_split_for_swap(restore->pool, p);
>  			copy_highpage(restore->alloced_page + i, p);
> +			p->memcg_data =3D 0;
>  			__free_pages_gpu_account(p, 0, false);
>  		}

[Severity: High]
Does clearing p->memcg_data before uncharging cause the memcg charge to lea=
k?

By explicitly setting p->memcg_data =3D 0 here, the subsequent call to
__free_pages_gpu_account() -> mem_cgroup_uncharge_gpu_page() cannot identify
which memcg to uncharge, since page_objcg(page) will return NULL.

Wouldn't this make the uncharge a no-op, permanently leaking the memcg GPU
charge counters and the obj_cgroup reference?

[ ... ]
> @@ -1402,7 +1482,7 @@ int ttm_pool_mgr_init(unsigned long num_pages)
>  	spin_lock_init(&shrinker_lock);
>  	INIT_LIST_HEAD(&shrinker_list);
> =20
> -	mm_shrinker =3D shrinker_alloc(SHRINKER_NUMA_AWARE, "drm-ttm_pool");
> +	mm_shrinker =3D shrinker_alloc(SHRINKER_MEMCG_AWARE | SHRINKER_NUMA_AWA=
RE, "drm-ttm_pool");

[Severity: Medium]
How does the shrinker count callback handle specific memory cgroups now that
it is memcg aware?

This registers the shrinker with SHRINKER_MEMCG_AWARE. The VM subsystem will
now call the count_objects callback (ttm_pool_shrinker_count) for specific
memory cgroups under pressure, passing sc->memcg.

However, ttm_pool_shrinker_count() ignores sc->memcg and always returns the
global pool size via atomic_long_read(&allocated_pages[sc->nid]). Could this
cause inefficient and disproportionate reclaim pressure, as a memcg with ze=
ro
TTM pages is falsely reported as holding the global amount?

>  	if (!mm_shrinker)
>  		return -ENOMEM;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706024122.8533=
29-1-airlied@gmail.com?part=3D5
