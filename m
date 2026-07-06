Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F95C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 03:10:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50E6F89233;
	Mon,  6 Jul 2026 03:10:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="T21LHtmi";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13F0F89233
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 03:10:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6A2F0600BB;
 Mon,  6 Jul 2026 03:10:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0F421F000E9;
 Mon,  6 Jul 2026 03:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783307401;
 bh=5m4ozewHCywskFpKUwF+H5HvVMeOaK/qfuILK8+Zdso=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=T21LHtmi0lEBbvkJQtQWujg9FiSsNKM2LYFKfbekYxdCX5AWiq7vh723rx317VCp0
 bkTQMAnht7KN0hzliDfZ3phPLW7DOG+1Yt1zIHRibZoR27Kd2NtOk+nscqUOIxJp+e
 b5+llBKvkwfpVAD0VOlX64MdDAsImcP7l8ju7O7juyDSAd7rwrrD66c4RpVEbz1avD
 vMdMY3DxUJ4hX/1N8Lb1ur0MUV9FEyRaJ/PoS1Nb3RrSv0Krsdev1gHpVDp11vVCxw
 bDVn2D4RKy2znmXOIgReIpDPNLBl48iTK5VR+KXskgzU9xRVJZ/0j9q37pF90TgE2a
 dqUPtcjlXPstg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/10] ttm: add support for a module option to disable
 memcg integration
To: "Dave Airlie" <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com
In-Reply-To: <20260706024122.853329-10-airlied@gmail.com>
References: <20260706024122.853329-1-airlied@gmail.com>
 <20260706024122.853329-10-airlied@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 03:10:00 +0000
Message-Id: <20260706031000.D0F421F000E9@smtp.kernel.org>
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
- [Medium] The Kconfig option `DRM_TTM_MEMCG` lacks a `default y` directive=
, which silently disables TTM memcg accounting by default, contradicting th=
e intended behavior described in the commit message.

Pre-existing issues:
- [High] Explicitly zeroing `page->memcg_data` prior to uncharging skips th=
e memcg uncharge process, causing persistent `obj_cgroup` reference leaks a=
nd memcg counter leaks.
- [High] DMA-allocated pool pages bypass accounting but are unconditionally=
 moved between active/reclaim states, permanently underflowing `NR_GPU_ACTI=
VE` and leaking `NR_GPU_RECLAIM` stats.
--

commit 29deabc39c8a2c600d3de5d3662fd9003ff7aa7a
Author: Dave Airlie <airlied@redhat.com>

ttm: add support for a module option to disable memcg integration

This adds a kconfig and a module option to turn off ttm memcg
integration completely.

> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -257,6 +257,13 @@ config DRM_TTM_HELPER
>  	help
>  	  Helpers for ttm-based gem objects
> =20
> +config DRM_TTM_MEMCG
> +	bool "Enable TTM mem cgroup by default"
> +	depends on DRM_TTM
> +	depends on MEMCG

[Severity: Medium]
Does this Kconfig option need a "default y" directive? The help text and
commit message state that the feature is enabled by default, but without
it, the configuration will default to disabled in standard builds.

> +	help
> +	  Enable the memcg integration by default
> +

[ ... ]

> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_poo=
l.c
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
This isn't a bug introduced by this patch, but does the call to
mem_cgroup_move_gpu_page_reclaim() that immediately follows this code
corrupt the memcg stats for DMA pages?

When ttm_pool_uses_dma_alloc() is true, ttm_pool_alloc_page() bypasses
mem_cgroup_charge_gpu_page(), meaning NR_GPU_ACTIVE is never incremented.

However, when the page is added to the pool here in ttm_pool_type_give(),
it unconditionally calls mem_cgroup_move_gpu_page_reclaim(..., true), which
subtracts from NR_GPU_ACTIVE and adds to NR_GPU_RECLAIM.

Finally, when the shrinker frees the page, ttm_pool_free_page() bypasses
__free_pages_gpu_account(), so the RECLAIM stat is never decremented. Does
this permanently underflow NR_GPU_ACTIVE and leak NR_GPU_RECLAIM?

[ ... ]
> @@ -844,7 +862,7 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, st=
ruct ttm_tt *tt,
>  	bool allow_pools;
>  	struct page *p;
>  	int r;
> -	struct obj_cgroup *objcg =3D memcg_account ? tt->objcg : NULL;
> +	struct obj_cgroup *objcg =3D (ttm_memcg && memcg_account) ? tt->objcg :=
 NULL;
> =20
>  	WARN_ON(!alloc->remaining_pages || ttm_tt_is_populated(tt));
>  	WARN_ON(alloc->dma_addr && !pool->dev);

[Severity: High]
This is a pre-existing issue, but does explicitly zeroing page->memcg_data
prior to uncharging cause an obj_cgroup leak?

During backup restoration in ttm_pool_restore_commit():

	copy_highpage(restore->alloced_page + i, p);
	p->memcg_data =3D 0;
	__free_pages_gpu_account(p, 0, false);

And similarly during purging in ttm_pool_shrink():

	page->private =3D 0;
	page->memcg_data =3D 0;
	__free_pages_gpu_account(page, order, false);

Since __free_pages_gpu_account() relies on mem_cgroup_uncharge_gpu_page()
which requires memcg_data to locate the correct obj_cgroup, doesn't
clearing it beforehand cause the uncharge to silently fail, leaking the
stats and the reference?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706024122.8533=
29-1-airlied@gmail.com?part=3D9
