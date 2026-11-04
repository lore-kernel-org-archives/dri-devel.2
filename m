Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2D06096091
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 20:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YNufB7x+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B828710E0F8;
	Wed,  4 Nov 2026 20:47:17 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72CC710E00D;
 Wed,  4 Nov 2026 20:47:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 85AA160DA7;
 Wed,  4 Nov 2026 20:47:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17B721F000C1;
 Wed,  4 Nov 2026 20:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793825230;
 bh=45TWhjjzWvYigbnjZSdrj3yUD7opZpR0l3RRZatqyLE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YNufB7x+tLeTPX5RgLpDb9h2FGZNuNi8lPHXKU0YkL14RnlbSMi+K9gJV/LmJAhOH
 Jj/X+Z5/ogfH0GROqSWTHFHZm1Fwgl4wF7o6JYNRqr6QHBCulyCjzZI9kQ5S6ObSVy
 LdVHQwBrIMW6iRBVceCYotpT2MGpPclKF2QGm38WiFqbC/Na1L764DWYAKu0nfAO6Z
 BJXNx+0AMT+7Yh1hCRVhDcQtyd+UZVTxuEPTb6qiEkP+FlA5Jw4ZQjQDlTJfV7ll47
 +3JQQmKhvCF4FV4hNigoiNhZtkAqP4aHCpBNufeaJzmcF4RiNbVGXQ0mGu8+w4SOk7
 8eKyZyRrwLfpQ==
Message-ID: <sashiko-outbox-198028@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] drm/ttm, drm/xe: Introduce TTM_TT_FLAG_PARTIAL for
 partially backed-up tts
To: =?utf-8?b?VGhvbWFzIEhlbGxzdHLDtm0=?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261104201331.2462-4-thomas.hellstrom@linux.intel.com>
References: <20261104201331.2462-1-thomas.hellstrom@linux.intel.com>
 <20261104201331.2462-4-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 20:47:09 +0000
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
- [High] drm/ttm: DMA mapping leak in ttm_pool_backup() on -EBUSY after res=
tore abort
- [High] drm/ttm: ttm_tt_backup() leaves tt populated if backup fails at fi=
rst page
- [Medium] drm/xe: stale remaining_pages and shrinker counts on failed ttm_=
tt_restore()
--

commit fc282ba9ab604d69dff7ad175cd51a0231a6c0b3
Author: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>

drm/ttm, drm/xe: Introduce TTM_TT_FLAG_PARTIAL for partially backed-up tts

This commit introduces TTM_TT_FLAG_PARTIAL and ttm_tt::remaining_pages to
track partially backed-up ttm_tt objects so they stay on the normal LRU
and remain eligible for shrinker reclaim. It also adds
ttm_pool_restore_abort() to clean up interrupted restores before backup
and updates xe shrinker page accounting to track resident pages.

> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_poo=
l.c
> index 1bf37023fed66..8f05257e4f542 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c

[ ... ]

> @@ -1039,6 +1057,91 @@ void ttm_pool_drop_backed_up(struct ttm_tt *tt)
>  	ttm_pool_free_range(NULL, tt, ttm_cached, start_page, tt->num_pages);
>  }
> =20
> +/**
> + * ttm_pool_restore_abort() - Abort an ongoing restore of a partial tt
> + * @tt: The struct ttm_tt with an active restore.

[ ... ]

> +static void ttm_pool_restore_abort(struct ttm_tt *tt)
> +{
> +	struct ttm_pool_tt_restore *restore =3D tt->restore;
> +	pgoff_t i, nr, mid;

[ ... ]

> +	/*
> +	 * Don't DMA-unmap committed restored pages here; their DMA
> +	 * addresses are in tt->dma_address[] and the backup path
> +	 * will unmap them.
> +	 */
> +
> +	/* Convert non-cached committed pages to write-back. */
> +	mid =3D restore->snapshot_alloc.caching_divide - tt->pages;
> +#ifdef CONFIG_X86
> +	if (mid > 0 && tt->caching !=3D ttm_cached)
> +		set_pages_array_wb(tt->pages, mid);
> +#endif
> +
> +	kfree(restore);
> +	tt->restore =3D NULL;
> +
> +	for (i =3D 0, nr =3D 0; i < tt->num_pages; i++) {
> +		struct page *p =3D tt->pages[i];
> +
> +		if (p && !ttm_backup_page_ptr_is_handle(p))
> +			nr++;
> +	}
> +	tt->remaining_pages =3D nr;
> +}
> +
>  /**
>   * ttm_pool_backup() - Back up or purge a struct ttm_tt
>   * @pool: The pool used when allocating the struct ttm_tt.
> @@ -1071,10 +1174,13 @@ long ttm_pool_backup(struct ttm_pool *pool, struc=
t ttm_tt *tt,
>  	pgoff_t shrunken =3D 0;
>  	pgoff_t i, j, num_pages, npages;
>  	pgoff_t nr_backed;
> +	bool partial =3D ttm_tt_is_partial(tt);
> =20
>  	if (WARN_ON(ttm_tt_is_backed_up(tt)))
>  		return -EINVAL;
> =20
> +	ttm_pool_restore_abort(tt);
> +
>  	if ((!ttm_backup_bytes_avail() && !flags->purge) ||
>  	    ttm_pool_uses_dma_alloc(pool) || ttm_tt_is_backed_up(tt))
>  		return -EBUSY;

[Severity: High]
Can this leak DMA mappings for committed restored pages when
ttm_pool_backup() returns -EBUSY right after ttm_pool_restore_abort(tt)?

When a restore of a backed-up or partial ttm_tt (with tt->dma_address !=3D
NULL) fails after committing one or more pages via
ttm_pool_allocated_page_commit(), tt->pages[0 .. restore->alloced_pages - 1]
are populated and DMA-mapped in tt->dma_address[], and tt is marked
TTM_TT_FLAG_PARTIAL with tt->restore non-NULL.

When ttm_pool_backup() is later called by the shrinker, it calls
ttm_pool_restore_abort(tt), which intentionally leaves committed restored
pages DMA-mapped in tt->dma_address[] for the backup loop to unmap, and
frees tt->restore (setting tt->restore =3D NULL).

If ttm_pool_backup() then takes the early -EBUSY return (for example, when
swap space is exhausted so !ttm_backup_bytes_avail() && !flags->purge), the
DMA-unmap loop below is skipped. That leaves a partial tt with
tt->restore =3D=3D NULL while tt->pages[0 .. alloced_pages - 1] remain
DMA-mapped:

- On teardown, ttm_tt_fini() -> ttm_pool_drop_backed_up() sees
  tt->restore =3D=3D NULL and calls:

    ttm_pool_free_range(NULL, tt, ttm_cached, 0, tt->num_pages);

  Because pool is NULL, ttm_pool_unmap_and_free() skips ttm_pool_unmap()
  and frees the still-DMA-mapped pages back to the page allocator.

- On a subsequent restore, ttm_pool_restore_and_alloc() starts a fresh
  restore at index 0, and ttm_pool_restore_commit() frees the retained
  resident pages via __free_pages_gpu_account(p, 0, false) without
  DMA-unmapping them and overwrites tt->dma_address[].

> diff --git a/drivers/gpu/drm/ttm/ttm_tt.c b/drivers/gpu/drm/ttm/ttm_tt.c
> index b645a18181843..2b441bf41d927 100644
> --- a/drivers/gpu/drm/ttm/ttm_tt.c
> +++ b/drivers/gpu/drm/ttm/ttm_tt.c

[ ... ]

> @@ -289,7 +289,18 @@ long ttm_tt_backup(struct ttm_device *bdev, struct t=
tm_tt *tt,
>  	ret =3D ttm_pool_backup(&bdev->pool, tt, &flags);
>  	if (ret > 0) {
>  		tt->page_flags &=3D ~TTM_TT_FLAG_PRIV_POPULATED;
> -		tt->page_flags |=3D TTM_TT_FLAG_BACKED_UP;
> +		if (ret >=3D tt->remaining_pages)
> +			tt->remaining_pages =3D 0;
> +		else
> +			tt->remaining_pages -=3D ret;
> +
> +		if (tt->remaining_pages) {
> +			tt->page_flags &=3D ~TTM_TT_FLAG_BACKED_UP;
> +			tt->page_flags |=3D TTM_TT_FLAG_PARTIAL;
> +		} else {
> +			tt->page_flags &=3D ~TTM_TT_FLAG_PARTIAL;
> +			tt->page_flags |=3D TTM_TT_FLAG_BACKED_UP;
> +		}
>  	}
> =20
>  	return ret;

[Severity: High]
What happens if ttm_pool_backup() fails on the very first page after it has
already converted the pages to write-back and unmapped tt->dma_address[]?

In ttm_pool_backup(), for a populated tt (!partial), all pages are first
converted to write-back via set_pages_array_wb() (when tt->caching !=3D
ttm_cached), and all entries in tt->dma_address[] are DMA-unmapped via
ttm_pool_unmap() and zeroed via memset() before the folio backup loop
starts.

If ttm_backup_backup_folio() fails on the first page (i =3D=3D 0) with
nr_backed =3D=3D 0 (or fault injection truncates num_pages mid-compound on =
the
first compound page), ttm_pool_backup() breaks out of the loop with
shrunken =3D=3D 0 and returns a negative error code (or 0).

Because ttm_tt_backup() only clears TTM_TT_FLAG_PRIV_POPULATED and sets
TTM_TT_FLAG_PARTIAL when ret > 0, the tt remains marked
TTM_TT_FLAG_PRIV_POPULATED (and not TTM_TT_FLAG_PARTIAL) even though its
DMA mappings have been unmapped and zeroed and its pages have been
converted to write-back:

- Subsequent ttm_bo_populate() / ttm_tt_populate() calls see
  ttm_tt_is_populated(tt) =3D=3D true and return 0 without restoring DMA
  mappings or caching.
- A subsequent ttm_pool_backup() call sees !partial and calls
  set_pages_array_wb() a second time on pages that are already WB.
- Subsequent ttm_tt_unpopulate() -> ttm_pool_free() calls ttm_pool_unmap()
  on zeroed DMA addresses and returns the WB pages into the WC/UC pool via
  ttm_pool_type_give().

> @@ -300,10 +311,20 @@ int ttm_tt_restore(struct ttm_device *bdev, struct =
ttm_tt *tt,
>  {
>  	int ret =3D ttm_pool_restore_and_alloc(&bdev->pool, tt, ctx);
> =20
> -	if (ret)
> +	if (ret) {
> +		/*
> +		 * Let the shrinker reclaim pages made resident by the
> +		 * failed restore. remaining_pages is recounted on backup.
> +		 */
> +		if (ttm_tt_is_backed_up(tt) &&
> +		    ttm_pool_restore_has_resident(tt)) {
> +			tt->page_flags &=3D ~TTM_TT_FLAG_BACKED_UP;
> +			tt->page_flags |=3D TTM_TT_FLAG_PARTIAL;
> +		}
>  		return ret;
> +	}
> =20
> -	tt->page_flags &=3D ~TTM_TT_FLAG_BACKED_UP;
> +	tt->page_flags &=3D ~(TTM_TT_FLAG_BACKED_UP | TTM_TT_FLAG_PARTIAL);
> =20
>  	return 0;
>  }

[ ... ]

> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> index 2afee1a6de668..6907b683dee07 100644
> --- a/drivers/gpu/drm/xe/xe_bo.c
> +++ b/drivers/gpu/drm/xe/xe_bo.c

[ ... ]

> @@ -676,20 +696,35 @@ static int xe_ttm_tt_populate(struct ttm_device *tt=
m_dev, struct ttm_tt *tt,
>  	    !(tt->page_flags & TTM_TT_FLAG_EXTERNAL_MAPPABLE))
>  		return 0;
> =20
> -	if (ttm_tt_is_backed_up(tt) && !xe_tt->purgeable) {
> +	/*
> +	 * A purgeable backed-up tt was purged and holds neither pages nor
> +	 * handles. Partial tts are never purgeable: madvise only marks
> +	 * populated tts purgeable, and the shrinker purges those fully.
> +	 */
> +	if ((ttm_tt_is_backed_up(tt) || ttm_tt_is_partial(tt)) &&
> +	    !xe_tt->purgeable) {
> +		pgoff_t remaining =3D ttm_tt_remaining_pages(tt);
> +		long backed_up_pages =3D tt->num_pages - remaining;
> +
>  		err =3D ttm_tt_restore(ttm_dev, tt, ctx);
> +		if (!err) {
> +			xe_tt->purgeable =3D false;
> +			xe_ttm_tt_account_add(ttm_to_xe_device(ttm_dev), tt,
> +					      backed_up_pages, !remaining);
> +			update_global_total_pages(ttm_dev, backed_up_pages);
> +		}
>  	} else {

[ ... ]

> @@ -1478,7 +1522,8 @@ long xe_bo_shrink(struct ttm_operation_ctx *ctx, st=
ruct ttm_buffer_object *bo,
>  	if (needs_rpm && !xe_pm_runtime_get_if_active(xe))
>  		goto out_unref;
> =20
> -	*scanned +=3D tt->num_pages;
> +	old_remaining =3D ttm_tt_remaining_pages(tt);
> +	*scanned +=3D old_remaining;
>  	lret =3D ttm_bo_shrink(ctx, bo, (struct ttm_bo_shrink_flags)
>  			     {.purge =3D false,
>  			      .writeback =3D flags.writeback,
> @@ -1486,10 +1531,7 @@ long xe_bo_shrink(struct ttm_operation_ctx *ctx, s=
truct ttm_buffer_object *bo,
>  	if (needs_rpm)
>  		xe_pm_runtime_put(xe);
> =20
> -	if (lret > 0) {
> -		xe_ttm_tt_account_subtract(xe, tt, tt->num_pages, 1);
> -		update_global_total_pages(bo->bdev, -(long)tt->num_pages);
> -	}
> +	xe_ttm_tt_account_shrunk(bo->bdev, tt, old_remaining);

[Severity: Medium]
When ttm_tt_restore() fails after making pages resident, doesn't leaving
tt->remaining_pages and the xe shrinker counters unupdated break shrinker
accounting and scanning?

When a fully backed-up tt (with tt->remaining_pages =3D=3D 0 and 0 pages
accounted in xe->mem.shrinker) fails in ttm_tt_restore() after committing
or restoring pages, ttm_tt_restore() transitions it to TTM_TT_FLAG_PARTIAL,
but tt->remaining_pages stays 0 until ttm_pool_restore_abort() runs during
backup, and xe_ttm_tt_populate() skips xe_ttm_tt_account_add() because
err !=3D 0:

1. Because the newly resident pages were never added via
   xe_ttm_tt_account_add(), xe_shrinker_count() does not see them and can
   return SHRINK_EMPTY if no other BOs are populated.
2. When xe_bo_shrink() (or xe_bo_shrink_purge()) runs on this BO, it reads
   old_remaining =3D ttm_tt_remaining_pages(tt) (which is still 0) and does
   *scanned +=3D old_remaining before calling ttm_bo_shrink() ->
   ttm_tt_backup() -> ttm_pool_backup() -> ttm_pool_restore_abort(). In
   xe_shrinker_scan(), if nr_scanned remains 0 while freed > 0, it will
   return SHRINK_STOP instead of freed:

   drivers/gpu/drm/xe/xe_shrinker.c:xe_shrinker_scan() {
       ...
       return nr_scanned ? freed : SHRINK_STOP;
   }
3. If the BO is destroyed via xe_ttm_tt_destroy() after a failed restore
   without an intervening backup attempt, or if a backup attempt in
   xe_bo_shrink() aborts the restore and increases tt->remaining_pages from
   0 to N (say, when only part of those N pages are backed up),
   xe_ttm_tt_account_shrunk() and xe_ttm_tt_destroy() will subtract pages
   that were never added in xe_ttm_tt_populate(), underflowing the shrinker
   counters.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104201331.2462=
-1-thomas.hellstrom@linux.intel.com?part=3D3
