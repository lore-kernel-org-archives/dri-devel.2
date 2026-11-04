Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B5C606AC03
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 20:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LLqRlc78
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C939C10E8E1;
	Wed,  4 Nov 2026 20:41:10 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90AB110E8CC;
 Wed,  4 Nov 2026 20:41:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4CEEF4367E;
 Wed,  4 Nov 2026 20:41:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0962F1F000C1;
 Wed,  4 Nov 2026 20:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793824864;
 bh=7sxGtz0RumWyxvGId1/tFbbUGK66diE1YrzU61K0DmI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LLqRlc78cZpHByDS0LgeupwZxPO8/sHJnJRjQLha4eVgsk6maVhzR9gZn7CYcETD7
 WPJboRnNSmuXevJJZ0aRY7RJ7PRQMXjXdKLqfHJR5XAM7QzP1psM3oJNVCO5OLg5KH
 C7m+AZgFwDk1olwQHkj2VmdnwnNofQH/HUahhm6R38g7/FaSdhN4kH6tUhvjmAS5hN
 UYFDrrpUaSaZ7fWpwyTFMxxb6GBOaIsr1QY/zrJOuOnXChpLkRv3s5c9z47lE5AWuP
 qeVdjhFXXo8gM05JBgIxyRiDQ6TrBh0cOs1syLgEYbHmRNxMxY4lvGEUvF/dn/QwzM
 VbjYUvXkakUrA==
Message-ID: <sashiko-outbox-198026@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] drm/ttm, drm/xe: Gate reserve-dipping backup
 retries on may_writeback
To: =?utf-8?b?VGhvbWFzIEhlbGxzdHLDtm0=?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261104201331.2462-5-thomas.hellstrom@linux.intel.com>
References: <20261104201331.2462-1-thomas.hellstrom@linux.intel.com>
 <20261104201331.2462-5-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 20:41:03 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] drm/ttm: unsplit high-order retry drains reserves in ttm_pool_back=
up()
- [High] drm/xe: premature scan termination in xe_shrinker_walk() and xe_bo=
_shrink()
- [High] drm/ttm: corrupted caching and DMA state in ttm_pool_backup() on p=
age-0 failure
--

commit 40d7831061e17e7b2e436a106ab6986d2645fa67
Author: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>

drm/ttm, drm/xe: Gate reserve-dipping backup retries on may_writeback

This commit gates shmem backup retries that dip into kernel memory reserves=
 on
a new may_writeback flag while separating direct swap writeback into
force_writeback, and threads both flags through TTM and the Xe shrinker.

> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_poo=
l.c
> index 8f05257e4f542..87c1ac39af94e 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
[ ... ]
> @@ -1256,7 +1260,9 @@ long ttm_pool_backup(struct ttm_pool *pool, struct =
ttm_tt *tt,
>  	else
>  		gfp =3D GFP_HIGHUSER;
> =20
> -	alloc_gfp =3D GFP_KERNEL | __GFP_HIGH | __GFP_NOWARN | __GFP_RETRY_MAYF=
AIL;
> +	/* Don't dip into kernel reserves unless @flags->may_writeback is set. =
*/
> +	alloc_gfp =3D GFP_KERNEL | __GFP_HIGH | __GFP_NOWARN |
> +		    __GFP_RETRY_MAYFAIL | __GFP_NOMEMALLOC;

[Severity: High]
When ttm_pool_backup() is called with flags->may_writeback set to false (su=
ch
as the initial pass of xe_shrinker_walk()), can an -ENOMEM failure on the
very first page leave tt with corrupted caching and DMA state?

Before entering the backup loop, ttm_pool_backup() converts all resident pa=
ges
of a non-partial tt with tt->caching !=3D ttm_cached to write-back via
set_pages_array_wb(), and unmaps and zeroes all tt->dma_address[] entries:

drivers/gpu/drm/ttm/ttm_pool.c:ttm_pool_backup() {
	if (!partial && tt->caching !=3D ttm_cached) {
		...
		if (run_count)
			set_pages_array_wb(&tt->pages[run_start], run_count);
	}
	...
	if (tt->dma_address || flags->purge) {
		...
			if (tt->dma_address && tt->dma_address[i]) {
				ttm_pool_unmap(pool, tt->dma_address[i],
					       num_pages);
				memset(&tt->dma_address[i], 0,
				       num_pages * sizeof(*tt->dma_address));
			}
	}
}

Because alloc_gfp now includes __GFP_NOMEMALLOC for all page orders (includ=
ing
order 0) and does not retry when flags->may_writeback is false,
shmem_read_folio_gfp() can fail with -ENOMEM on the first page (i =3D=3D 0,
nr_backed =3D=3D 0, shrunken =3D=3D 0), causing ttm_pool_backup() to return=
 -ENOMEM.

In ttm_tt_backup(), tt->page_flags is only updated when ret > 0:

drivers/gpu/drm/ttm/ttm_tt.c:ttm_tt_backup() {
	ret =3D ttm_pool_backup(&bdev->pool, tt, &flags);
	if (ret > 0) {
		tt->page_flags &=3D ~TTM_TT_FLAG_PRIV_POPULATED;
		...
		if (tt->remaining_pages) {
			tt->page_flags &=3D ~TTM_TT_FLAG_BACKED_UP;
			tt->page_flags |=3D TTM_TT_FLAG_PARTIAL;
		}
		...
	}
}

With TTM_TT_FLAG_PRIV_POPULATED still set and TTM_TT_FLAG_PARTIAL clear, wo=
n't
subsequent calls to ttm_tt_populate() see ttm_tt_is_populated(tt) as true a=
nd
return 0 without restoring WC/UC caching or DMA mappings, while
ttm_tt_unpopulate() -> ttm_pool_free() returns the write-back pages directly
into the WC/UC page pool and calls ttm_pool_unmap() on the zeroed
tt->dma_address[] entries?

> =20
>  	num_pages =3D tt->num_pages;
> =20
> @@ -1280,14 +1286,7 @@ long ttm_pool_backup(struct ttm_pool *pool, struct=
 ttm_tt *tt,
>  		order =3D ttm_pool_page_order(pool, page);
>  		npages =3D 1UL << order;
> =20
> -		/*
> -		 * We don't allow dipping kernel reserves for high order backup
> -		 */
> -		if (order)
> -			alloc_gfp |=3D __GFP_NOMEMALLOC;
> -		else
> -			alloc_gfp &=3D ~__GFP_NOMEMALLOC;
> -
> +		dip_reserves =3D false;
>  		/*
>  		 * Back up the compound atomically at its native order. If
>  		 * fault injection truncated num_pages mid-compound, skip
> @@ -1296,10 +1295,18 @@ long ttm_pool_backup(struct ttm_pool *pool, struc=
t ttm_tt *tt,
>  		if (unlikely(i + npages > num_pages))
>  			break;
> =20
> +retry:
>  		handle =3D ttm_backup_backup_folio(backup, page_folio(page),
> -						 order, flags->writeback, i,
> -						 gfp, alloc_gfp,
> -						 &nr_backed);
> +						 order, flags->force_writeback, i,
> +						 gfp, dip_reserves ?
> +						 alloc_gfp & ~__GFP_NOMEMALLOC :
> +						 alloc_gfp, &nr_backed);
> +		if (unlikely(handle =3D=3D -ENOMEM && !nr_backed &&
> +			     flags->may_writeback && !dip_reserves)) {
> +			dip_reserves =3D true;
> +			goto retry;
> +		}

[Severity: High]
If ttm_backup_backup_folio() fails with -ENOMEM on the first subpage
(!nr_backed) of a high-order compound page (order > 0), doesn't jumping
directly to retry re-invoke ttm_backup_backup_folio() at the full compound
order with __GFP_NOMEMALLOC cleared instead of splitting the compound into
order-0 pages first?

When system free memory is below normal zone watermarks during reclaim, the
initial __GFP_NOMEMALLOC allocation fails on subpage 0 with handle =3D=3D -=
ENOMEM
and nr_backed =3D=3D 0. Because ttm_pool_split_for_swap() is only called fu=
rther
down when nr_backed > 0 and nr_backed < npages, retrying at the original
order forces ttm_backup_backup_folio() to allocate up to 1 << order shmem
pages from kernel memory reserves before returning to ttm_pool_backup() whe=
re
the source compound page can finally be freed.

Should this path split a high-order page via ttm_pool_split_for_swap(pool,
page) and reset order =3D 0 and npages =3D 1 before retrying with reserves,=
 as
described in the struct ttm_backup_flags kerneldoc for may_writeback, so ea=
ch
order-0 subpage is backed up and freed before allocating the next shmem pag=
e?

[ ... ]
> diff --git a/drivers/gpu/drm/xe/xe_shrinker.c b/drivers/gpu/drm/xe/xe_shr=
inker.c
> index c86455ea08d18..c24f35cbc2358 100644
> --- a/drivers/gpu/drm/xe/xe_shrinker.c
> +++ b/drivers/gpu/drm/xe/xe_shrinker.c
> @@ -171,6 +171,7 @@ static int __xe_shrinker_walk(struct xe_shrinker *shr=
inker,
>  static int xe_shrinker_walk(struct xe_shrinker *shrinker,
>  			    struct ttm_operation_ctx *ctx,
>  			    const struct xe_bo_shrink_flags flags,
> +			    bool allow_writeback,
>  			    unsigned long to_scan, unsigned long *scanned,
>  			    unsigned long *freed)
>  {
> @@ -179,7 +180,8 @@ static int xe_shrinker_walk(struct xe_shrinker *shrin=
ker,
>  	int ret;
> =20
>  	swap(no_wait_gpu, ctx->no_wait_gpu);
> -	save_flags.writeback =3D false;
> +	save_flags.may_writeback =3D false;
> +	save_flags.force_writeback =3D false;
>  	ret =3D __xe_shrinker_walk(shrinker, ctx, save_flags, to_scan, scanned,
>  				 freed);
>  	swap(no_wait_gpu, ctx->no_wait_gpu);
> @@ -187,15 +189,32 @@ static int xe_shrinker_walk(struct xe_shrinker *shr=
inker,
>  		return ret;
> =20
>  	if (!ctx->no_wait_gpu) {
> +		/*
> +		 * Blocking is now tolerated: allow retrying a failed backup
> +		 * allocation using kernel reserves, but only if writeback is
> +		 * permitted at all in this gfp context (i.e. __GFP_IO is
> +		 * set); see @allow_writeback in xe_shrinker_scan().
> +		 */
> +		save_flags.may_writeback =3D allow_writeback;
>  		ret =3D __xe_shrinker_walk(shrinker, ctx, save_flags, to_scan, scanned,
>  					 freed);
>  		if (ret || *scanned >=3D to_scan)
>  			return ret;
>  	}
> =20
> -	if (flags.writeback)
> -		ret =3D __xe_shrinker_walk(shrinker, ctx, flags, to_scan, scanned,
> +	if (allow_writeback) {
> +		struct xe_bo_shrink_flags wb_flags =3D flags;
> +
> +		/*
> +		 * Writeback explicitly allowed: also force writeback on any
> +		 * retry so it actually relieves memory pressure instead of
> +		 * just growing dirty shmem.
> +		 */
> +		wb_flags.may_writeback =3D true;
> +		wb_flags.force_writeback =3D true;
> +		ret =3D __xe_shrinker_walk(shrinker, ctx, wb_flags, to_scan, scanned,
>  					 freed);
> +	}

[Severity: High]
Can xe_shrinker_walk() terminate after the first pass with 0 freed pages wh=
en
__GFP_NOMEMALLOC shmem allocations fail under memory pressure, without ever
reaching the passes that set may_writeback or force_writeback?

In xe_bo_shrink(), *scanned is incremented by the full old_remaining page
count before calling ttm_bo_shrink():

drivers/gpu/drm/xe/xe_bo.c:xe_bo_shrink() {
	old_remaining =3D ttm_tt_remaining_pages(tt);
	*scanned +=3D old_remaining;
	lret =3D ttm_bo_shrink(ctx, bo, (struct ttm_bo_shrink_flags)
			     {.purge =3D false,
			      .allow_move =3D true,
			      .may_writeback =3D flags.may_writeback,
			      .force_writeback =3D flags.force_writeback});
}

During the first pass of xe_shrinker_walk() (where save_flags.may_writeback=
 is
false), if shmem_read_folio_gfp() with __GFP_NOMEMALLOC fails with -ENOMEM =
on
an idle BO, ttm_pool_backup() stops without retrying and ttm_bo_shrink()
returns -EBUSY (or a partial count if it stopped mid-BO). In
__xe_shrinker_walk(), lret =3D=3D -EBUSY continues to the next BO on the LRU
while keeping old_remaining added to *scanned. Once Pass 1 returns,
*scanned >=3D to_scan is satisfied and xe_shrinker_walk() returns immediate=
ly
without running Pass 2 or Pass 3.

Additionally, if Pass 1 visits fewer than to_scan pages in idle BOs and
reaches Pass 2 with allow_writeback set to true, Pass 2 runs with
save_flags.may_writeback =3D true and save_flags.force_writeback =3D false.=
 Won't
Pass 2 dip into kernel memory reserves to grow dirty shmem without writeback
and satisfy *scanned >=3D to_scan before Pass 3 (where force_writeback =3D =
true)
can run?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104201331.2462=
-1-thomas.hellstrom@linux.intel.com?part=3D4
