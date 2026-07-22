Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAEBBC4452D
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 04:58:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1356B10E402;
	Wed, 22 Jul 2026 04:58:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="I4JaQfaW";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 096E010E402
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 04:58:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 85CD74138B;
 Wed, 22 Jul 2026 04:58:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B2111F000E9;
 Wed, 22 Jul 2026 04:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784696283;
 bh=EsgHAZPh1m9+8AYdoRmaFnYgx0Ib/rOd3qn0UhH3TyE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=I4JaQfaWz5JP+/92eLhbzdQ8ojZ3mbcGgeeDIrwhDLwCyD1yji9PScHXZUagGBkl/
 gh3G0z4hUzyP9g8oDLSc9vvnlNtkAPqC3qJD1lgBnxTIpEzOOK8YENhebyR89TDQBA
 72yAPJqm7ylhnhpW8slKAxO8fCHVrxbZxuMrLKdLmqnWta2sC00qXHUveznvLe0UA4
 ermwOUJVrDRnQDDbWky/V4BH6W/MFttF5kG0ZfYO4hmh5JnPsmjrAYDsbhrGSmec5Q
 tjd2RzkW7RQccjocQP1Z/c+q5Jj19gM+QO/ka2+dcENv93DjjAqGqThjOfRMPwBWcn
 qysVfQxzKJcdg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] drm/ttm: allocate pool pages as compound (__GFP_COMP)
To: "Matthew Brost" <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260722044220.1110278-3-matthew.brost@intel.com>
References: <20260722044220.1110278-1-matthew.brost@intel.com>
 <20260722044220.1110278-3-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 04:58:00 +0000
Message-Id: <20260722045802.1B2111F000E9@smtp.kernel.org>
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
- [Critical] ttm_pool_split_for_swap() ignores the return value of folio_sp=
lit_driver_managed(), leading to severe buddy allocator corruption if the s=
plit fails.
- [High] Kconfig hazard: Forcing TRANSPARENT_HUGEPAGE via select bypasses c=
ritical architectural dependencies.
--

--- Patch [3]: [PATCH 3/3] drm/ttm: allocate pool pages as compound (__GFP_=
COMP) ---
commit dae665417eeff981f7bae0e75da08ad47a4dd0a0
Author: Matthew Brost <matthew.brost@intel.com>

drm/ttm: allocate pool pages as compound (__GFP_COMP)

This commit changes the non-DMA path in ttm_pool_alloc_page() to allocate
compound pages with __GFP_COMP instead of stashing the order in page->priva=
te.
It updates the backup, restore, and free paths to read the order via
folio_order() and split compound folios using folio_split_driver_managed().

> folio_split_driver_managed() lives in the THP split machinery
> (mm/huge_memory.c), which only builds when CONFIG_TRANSPARENT_HUGEPAGE
> is enabled. Drivers that drive the TTM shrinker and therefore reach the
> split path must select TRANSPARENT_HUGEPAGE.

[Severity: High]
Is it safe to force select TRANSPARENT_HUGEPAGE in drivers?

The Kconfig select directive forcefully enables the target symbol without
evaluating its dependencies. TRANSPARENT_HUGEPAGE strictly depends on
HAVE_ARCH_TRANSPARENT_HUGEPAGE and !PREEMPT_RT.=20

Using select could force THP on architectures that lack support, breaking
the build, or bypass the !PREEMPT_RT dependency and violate strict latency
requirements.

> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_poo=
l.c
> index 1bf37023fed66..364cc7ec7469c 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
[ ... ]
> @@ -493,15 +493,31 @@ static unsigned int ttm_pool_page_order(struct ttm_=
pool *pool, struct page *p)
>  static void ttm_pool_split_for_swap(struct ttm_pool *pool, struct page *=
p)
>  {
>  	unsigned int order =3D ttm_pool_page_order(pool, p);
> =20
>  	if (!order)
>  		return;
> =20
> -	split_page(p, order);
> -	nr =3D 1UL << order;
> -	while (nr--)
> -		(p++)->private =3D 0;
> +	if (ttm_pool_uses_dma_alloc(pool)) {
> +		pgoff_t nr;
> +
> +		/*
> +		 * DMA-alloc pages are not compound; split the plain
> +		 * higher-order allocation and clear the per-page private
> +		 * (which held the order for the non-compound case).
> +		 */
> +		split_page(p, order);
> +		nr =3D 1UL << order;
> +		while (nr--)
> +			(p++)->private =3D 0;
> +		return;
> +	}
> +
> +	/*
> +	 * The non-DMA path allocates compound folios (__GFP_COMP). Split the
> +	 * driver-owned, off-LRU, unmapped folio into order-0 folios so each
> +	 * page can be freed as soon as it has been backed up.
> +	 */
> +	folio_split_driver_managed(page_folio(p), 0);
>  }

[Severity: Critical]
Does this code handle split failures correctly?

If CONFIG_TRANSPARENT_HUGEPAGE is disabled, the fallback stub for
folio_split_driver_managed() unconditionally returns -EINVAL and the folio
remains an intact compound page. Because the return value is ignored,
callers like ttm_pool_backup() will incorrectly assume the split succeeded.

Will this corrupt the buddy allocator in ttm_pool_backup()? It follows the
split with this loop:

			ttm_pool_split_for_swap(pool, page);
			for (j =3D 0; j < nr_backed; j++)
				__free_pages_gpu_account(page + j, 0, false);

Calling __free_pages(page + j, 0) on a tail page of an active compound folio
redirects the refcount decrement to the head page, rapidly underflowing it.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722044220.1110=
278-1-matthew.brost@intel.com?part=3D3
