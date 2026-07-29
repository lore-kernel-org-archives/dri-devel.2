Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFBA4C54F51
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 13:02:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E58010E43A;
	Wed, 29 Jul 2026 13:02:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ljPZMEGU";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8139A10E43A
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 13:02:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 973AD600AB;
 Wed, 29 Jul 2026 13:02:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE251F00A3A;
 Wed, 29 Jul 2026 13:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785330158;
 bh=GEXiJdFIsbaAJVUabcIE5KT+/sSA/QenYym1uJZbam4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ljPZMEGUa0a8TyCfzfQ5WnuZ7jhEiuxVXN7pdw28XzN5MjjI326gjBiWjG2FltIye
 lOc9N5VfMwLgOKmLnYzuvbWMeSVRWqnQ6LqkxRew1u821u5SQ2RWL84q8pXN+uyBHa
 y5+kmfq/1Nb9sx3xGe9rJZAVR9kjHBkB6k/ySQ2eg8CPU5kra2EPo11XXD0a8UZTSE
 Lh4+nqk8+A+1Vu7TMtBnJWTAO+5dFxOSlHQ/GblxqkBGMh2joQxV6/rLUC2Jzn12GS
 LMbefOBRge+vvUr0G8O6pM0RzktRp/MEpHAGTFfUQe+YSZpybOU3XwWK5Qq4B/3k/d
 vC3cs2US1qdrQ==
From: sashiko-bot@kernel.org
Subject: Re: Patch "drm/ttm: Account for NULL and handle pages in
 ttm_pool_backup" has been added to the 6.18-stable tree
To: gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <2026072924-debate-parched-01e5@gregkh>
References: <2026072924-debate-parched-01e5@gregkh>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 13:02:37 +0000
Message-Id: <20260729130238.2CE251F00A3A@smtp.kernel.org>
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
- [High] Shmem backing pages (handles) are leaked during a purge operation.

Pre-existing issues:
- [High] If `ttm_pool_backup` fails partially, it results in a double unmap=
 of DMA addresses and mismatched unmap sizes, violating DMA API constraints.
- [High] Backing up a TT via `ttm_tt_backup` frees its physical pages to th=
e system but fails to decrement the TTM global `ttm_pages_allocated` counte=
r, causing a permanent accounting leak.
--

--- Patch [1]: Patch "drm/ttm: Account for NULL and handle pages in ttm_poo=
l_backup" has been added to the 6.18-stable tree ---
commit b4738a9fdee6c750a497cb7d46bafb43babc2b86
Author: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>
Subject: Patch "drm/ttm: Account for NULL and handle pages in ttm_pool_back=
up" has been added to the 6.18-stable tree

This commit updates ttm_pool_backup() to account for NULL pages and backup=
=20
handles when shrinking pages. It adds a dedicated writeback pass that skips=
=20
these entries and applies the same guard to the DMA unmap and purge loop.

Link: https://patch.msgid.link/20260702214815.4009271-1-matthew.brost@intel=
.com

> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_poo=
l.c
> index baf27c70a4193..01083720e4e7f 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
[ ... ]
> @@ -991,7 +1013,7 @@ long ttm_pool_backup(struct ttm_pool *pool, struct t=
tm_tt *tt,
>  			unsigned int order;
> =20
>  			page =3D tt->pages[i];
> -			if (unlikely(!page)) {
> +			if (unlikely(!page || ttm_backup_page_ptr_is_handle(page))) {
>  				num_pages =3D 1;
>  				continue;
>  			}

[Severity: High]
If this operation is a purge and ttm_backup_page_ptr_is_handle(page) is tru=
e,=20
does this skip the handle without freeing its underlying backup resources=20
(shmem folios)?

When ttm_pool_backup() is called by the shrinker with flags->purge =3D true=
=20
on a TT that has been partially or fully swapped to shmem, the new=20
ttm_backup_page_ptr_is_handle(page) check unconditionally skips the handles=
.=20

It seems it fails to call ttm_backup_drop(backup, handle) to free the=20
underlying shmem folio, leaving the handles stranded in tt->pages until the=
=20
BO is eventually destroyed.  Will this leak shmem folios?

> =20
>  			order =3D ttm_pool_page_order(pool, page);
>  			num_pages =3D 1UL << order;
>  			if (tt->dma_address)
>  				ttm_pool_unmap(pool, tt->dma_address[i],
>  					       num_pages);

[Severity: High]
This is a pre-existing issue, but does this partial failure path=20
lead to double DMA unmaps?

If ttm_pool_backup() fails partially (e.g., ttm_backup_backup_page() fails=
=20
on the first page), the function aborts and returns an error.  Because=20
shrunken =3D=3D 0, ttm_tt_backup() does not set TTM_TT_FLAG_BACKED_UP.=20

The loop here unmaps DMA addresses for all valid pages but does not clear=20
tt->dma_address[i] or tt->pages[i] unless flags->purge is true.  The=20
pages remain in tt->pages with uncleared DMA addresses.=20

When the TT is subsequently destroyed via ttm_tt_unpopulate(), it calls=20
ttm_pool_free_range(), which again calls ttm_pool_unmap() on the already=20
unmapped DMA addresses:

drivers/gpu/drm/ttm/ttm_pool.c:ttm_pool_unmap_and_free() {
    ...
    if (dma_addr)
        ttm_pool_unmap(pool, *dma_addr, nr);
    ...
}

Additionally, because the first page's order was cleared via=20
ttm_pool_split_for_swap(), will it be unmapped as 1 page instead of its=20
original mapped size, causing a mismatched unmap size?

[Severity: High]
This is a pre-existing issue, but does backing up a TT via ttm_tt_backup()=
=20
leak the TTM global ttm_pages_allocated counter?

When ttm_tt_backup() successfully backs up pages, it clears=20
TTM_TT_FLAG_PRIV_POPULATED and sets TTM_TT_FLAG_BACKED_UP without=20
decrementing the ttm_pages_allocated counter:

drivers/gpu/drm/ttm/ttm_tt.c:ttm_tt_backup() {
    ...
    tt->page_flags &=3D ~TTM_TT_FLAG_PRIV_POPULATED;
    tt->page_flags |=3D TTM_TT_FLAG_BACKED_UP;
    ...
}

Later, when the TT is destroyed, ttm_tt_unpopulate() checks=20
ttm_tt_is_populated():

drivers/gpu/drm/ttm/ttm_tt.c:ttm_tt_unpopulate() {
    ...
    if (!ttm_tt_is_populated(ttm))
        return;
    ...
}

Because the PRIV_POPULATED flag is clear, this function returns early and=20
fails to execute the atomic_long_sub(tt->num_pages, &ttm_pages_allocated)=20
decrement at the end of the function.  The backup cleanup path=20
(ttm_pool_drop_backed_up()) also never decrements this counter.  Does this=
=20
cause a permanent memory accounting leak?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/2026072924-debate-p=
arched-01e5@gregkh?part=3D1
