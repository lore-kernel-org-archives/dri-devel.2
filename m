Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60989C43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 22:09:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C325710E24C;
	Fri, 10 Jul 2026 22:09:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Wg45CZNv";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7ADD910E24C
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 22:09:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 13C4143895;
 Fri, 10 Jul 2026 22:09:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C21751F000E9;
 Fri, 10 Jul 2026 22:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783721350;
 bh=o1vlaGFqUtx1dljvH7GbgCi5mUlbS7cOE44RAatJe+w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Wg45CZNvMG+82+tdqzMfEmojtV3WGtz9wpdwHbRur7FD/UeyvaqPBs7AzXo4ZTb13
 rj5S7pFUkgUMuL2Im79vGDsls+CsFNy2SoeR7EiKA/TiIbhPvrDwyNKQXc12Z1bYHE
 HGWuRLp9Y1u3XnrMli6KZzu32YE3hDr99l9lSy8mGZS0I2SWv63hTshZqo7phEeB3v
 LMddmf/IdBFLDz8bZy5qdm8QydGrN/BuiQOyEwVnu6GGVSvkZWOnCISrNzN6NYU6C+
 iFbkXYM51YobbY2skMcVHYyHfhWJCW96aqjKm191cu7knNWET8Gzfym/wG1F0gfZKb
 qetUrsqjeNgmQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/33] drm/ttm: Preallocate beneficial-order defrag
 pages outside the lock
To: "Matthew Brost" <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260710215442.2444235-10-matthew.brost@intel.com>
References: <20260710215442.2444235-1-matthew.brost@intel.com>
 <20260710215442.2444235-10-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 22:09:09 +0000
Message-Id: <20260710220909.C21751F000E9@smtp.kernel.org>
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
- [Critical] Harvesting tail pages of a bisected chunk during defragmentati=
on leads to Use-After-Free.
- [High] Missing __GFP_NOWARN and __GFP_RETRY_MAYFAIL in best-effort preall=
ocation causes log spam and potential OOM killer invocation.
--

--- Patch [9]: [PATCH v2 09/33] drm/ttm: Preallocate beneficial-order defra=
g pages outside the lock ---
commit d825f68af024a3a3838c6e5d1ecfcf5ee8717374
Author: Matthew Brost <matthew.brost@intel.com>
Subject: drm/ttm: Preallocate beneficial-order defrag pages outside the lock

This commit introduces a mechanism to preallocate high-order pages outside
the DMA reservation lock during defragmentation moves. By using a prealloc
bag, it avoids stalling in direct reclaim or compaction while holding the
lock, improving concurrent rendering performance.

> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_poo=
l.c
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
[ ... ]
> @@ -929,6 +939,172 @@ static int ttm_pool_harvest_remaining(struct ttm_po=
ol *pool,
>  	return 0;
>  }
> =20
> +unsigned int ttm_pool_prealloc_order(struct ttm_pool *pool)
> +{
> +	return ttm_pool_beneficial_order(pool);
> +}
> +EXPORT_SYMBOL(ttm_pool_prealloc_order);
> +
> +/*
> + * Build the gfp flags used for the high-order, possibly reclaiming, ben=
eficial
> + * order page allocations, matching the in-line defrag alloc path.
> + */
> +static gfp_t ttm_pool_prealloc_gfp(struct ttm_pool *pool)
> +{
> +	gfp_t gfp =3D GFP_USER;
> +
> +	/*
> +	 * No highmem: prealloc applies caching in bulk via set_pages_array_*()
> +	 * on the kernel mapping, so the pages must be permanently mapped.
> +	 */
> +	if (ttm_pool_uses_dma32(pool))
> +		gfp |=3D GFP_DMA32;
> +
> +	return gfp;
> +}

[Severity: High]
Does this base GFP flag configuration risk invoking the OOM killer on a
fragmented system?

The preallocation performed in ttm_pool_prealloc_fill() appears to be an
opportunistic, best-effort operation:

ttm_pool_prealloc_fill() {
        ...
        struct page *p =3D ttm_pool_alloc_page(pool, gfp, order, false);

Without including __GFP_NOWARN and __GFP_RETRY_MAYFAIL here, a failure to
allocate these high-order pages will trigger aggressive reclaim. This could
unnecessarily invoke the OOM killer and spam the logs, even though the pool
can safely fall back to in-line allocation.

Should these suppression flags be added to the preallocation gfp mask?

[ ... ]
> @@ -1178,8 +1374,8 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, =
struct ttm_tt *tt,
>  	     alloc->remaining_pages;
>  	     it.order =3D ttm_pool_alloc_find_order(it.order, alloc)) {
>  		/*
> -		 * Out of defrag budget: harvest the rest of the old tt as-is and
> -		 * stop (the tt is re-queued if the remainder is still
> +		 * Out of defrag budget/prealloc: harvest the rest of the old tt
> +		 * as-is and stop (the tt is re-queued if the remainder is still
>  		 * sub-optimal).
>  		 */
>  		if (ttm_pool_iter_defrag_exhausted(&it)) {

[Severity: Critical]
Can this lead to memory corruption if the budget is exhausted while the
offset is misaligned with the chunks in the old tt?

If the budget is exhausted here, ttm_pool_iter_harvest_rest() will
call ttm_pool_harvest_remaining(), which reads the order from the
current page:

ttm_pool_harvest_remaining() {
        ...
        struct page *p =3D old_tt->pages[off];
        unsigned int order =3D ttm_pool_page_order(pool, p);

If off points to a tail page of a previously allocated larger chunk,
ttm_pool_page_order() will return 0 because the private field is 0 on tail
pages. This causes the code to falsely harvest it as an order-0 chunk. When
the old tt is later freed, it frees the entire large chunk from the head
page, leaving the new tt with pointers to freed memory.

> +			r =3D ttm_pool_iter_harvest_rest(&it);
> +			if (r)
> +				goto error_free_all;
> +			break;
> +		}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710215442.2444=
235-1-matthew.brost@intel.com?part=3D9
