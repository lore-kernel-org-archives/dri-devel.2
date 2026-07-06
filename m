Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B036CC43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 05:39:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04D9510E74C;
	Mon,  6 Jul 2026 05:39:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TFRdJ/iV";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F7DC10E74D
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 05:39:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E698D61383;
 Mon,  6 Jul 2026 05:39:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 596E21F000E9;
 Mon,  6 Jul 2026 05:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783316345;
 bh=DXGfie8bQ+w22GVWyZlz/MpIEH/bAizck1z3/apmdcI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TFRdJ/iVpQ1IcKGGRKEdeRK9m45Q3YPzigvSVWLXaoJ89vrdK0MN1ESrc5j0/KuEy
 /hXgMDu3mYi+xWG0IiZKowIwSS5sg5rme+4JmEpzxbY48MZTSM1QWGd55JKa2T13Di
 Q8ogVjuDRaETESbIpMgBXDCyMR8O4BhvFyQKAYUf/5rpKcUEw+xZ4v1uGl+N7iRnyY
 G9cB3vbhUj4myAu7z4wVeaEl5F15SE/yaIXvm8GEtifIlE0OxhHHP3krSlHIAUnNmz
 1BvzORWKLP/Oq+mUPvX8rcLwVqG1YzI3F7FgmFhSbS78z//17xF9KVHA/mwz2W/EcF
 TU9cZrllz9LgA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/10] ttm: add support for a module option to disable
 memcg integration
To: "Dave Airlie" <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org, hannes@cmpxchg.org, tj@kernel.org,
 mkoutny@suse.com
In-Reply-To: <20260706052330.1110909-10-airlied@gmail.com>
References: <20260706052330.1110909-1-airlied@gmail.com>
 <20260706052330.1110909-10-airlied@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 05:39:04 +0000
Message-Id: <20260706053905.596E21F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The memcg-aware shrinker count callback returns the global node po=
ol size instead of the memcg-specific pool size, severely distorting propor=
tional reclaim.
- [High] DMA-allocated pages permanently corrupt NR_GPU_ACTIVE and NR_GPU_R=
ECLAIM vmstat counters when added to and freed from the TTM pool.
--

commit 6e92a3554c189b1a664eb6626ab6f741e3bdc804
Author: Dave Airlie <airlied@redhat.com>

ttm: add support for a module option to disable memcg integration

This adds a kconfig and a module option to turn off ttm memcg
integration completely. When this is used, no object will ever end
up using memcg aware paths.

> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_poo=
l.c
> index 01b6ff2d81444..b7263d26c9902 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c

[ ... ]

> @@ -321,7 +339,7 @@ static void ttm_pool_type_give(struct ttm_pool_type *=
pt, struct page *p)
> =20
>  	INIT_LIST_HEAD(&p->lru);
>  	rcu_read_lock();
> -	list_lru_add(&pt->pages, &p->lru, nid, page_memcg_check(p));
> +	list_lru_add(&pt->pages, &p->lru, nid, ttm_memcg ? page_memcg_check(p) =
: NULL);
>  	rcu_read_unlock();
> =20
>  	atomic_long_add(num_pages, &allocated_pages[nid]);

[Severity: High]
This is a pre-existing issue, but does this path corrupt the NR_GPU_ACTIVE
and NR_GPU_RECLAIM vmstat counters for DMA-allocated pages?

In ttm_pool_alloc_page(), pages allocated via the DMA API bypass the
mem_cgroup_charge_gpu_page() call, so the NR_GPU_ACTIVE counter is never
incremented.

However, when these DMA pages are returned to the pool here in
ttm_pool_type_give(), the code unconditionally updates the stats by calling
mem_cgroup_move_gpu_page_reclaim(NULL, p, pt->order, true). Because the
page has no tracked memcg, this subtracts from the global node's
NR_GPU_ACTIVE (causing an underflow) and adds to NR_GPU_RECLAIM.

Furthermore, when the DMA page is ultimately freed from the pool:

drivers/gpu/drm/ttm/ttm_pool.c:ttm_pool_free_page() {
	if (!pool || !ttm_pool_uses_dma_alloc(pool)) {
		__free_pages_gpu_account(p, order, reclaim);
		return;
	}
	...
	dma_free_attrs(...);
}

It skips __free_pages_gpu_account() and is freed directly. Thus,
NR_GPU_RECLAIM is never decremented, causing a permanent and unbounded
leak of the global reclaim counter on the node.

[ ... ]

[Severity: High]
This is a pre-existing issue, but does the memcg-aware shrinker count
callback severely distort proportional reclaim by returning the global
pool size?

When the VM reclaims memory under a specific memory cgroup, it calls
ttm_pool_shrinker_count() with sc->memcg set:

drivers/gpu/drm/ttm/ttm_pool.c:ttm_pool_shrinker_count() {
	unsigned long num_pages =3D atomic_long_read(&allocated_pages[sc->nid]);

	return num_pages ? num_pages : SHRINK_EMPTY;
}

This unconditionally returns the global number of allocated pages on the no=
de
instead of the number of pages actually in the specified memcg's LRU list.

Could this cause the VM to vastly overestimate the amount of reclaimable
memory for any memcg under pressure (potentially reporting gigabytes of glo=
bal
pool pages as reclaimable by a small cgroup)?

It seems this would skew the proportional reclaim heuristics, causing the VM
to apply excessive pressure to this shrinker while under-pressuring other
memory caches.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706052330.1110=
909-1-airlied@gmail.com?part=3D9
