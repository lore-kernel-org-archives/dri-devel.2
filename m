Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D339C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 22:03:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07C9E10E518;
	Thu,  2 Jul 2026 22:03:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RqP8Vmve";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 668DA10E518
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 22:03:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2BD2B409CF;
 Thu,  2 Jul 2026 22:03:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B16C81F000E9;
 Thu,  2 Jul 2026 22:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783029837;
 bh=hCttp3GnQgBx4ltkJVqUr65TyGGHiicRchY/4FAeB+s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RqP8Vmvev3j72Om17Ctj+VMYFYy4DUxedc9cAmUe92LDqzmFEsARGBDKgQH4iZ63i
 MQjoHOMO2m5iT9g1+HvRfhP94C01cdcfL7X3DT70MgzcHfb5SsW+l6ldoSLRqjTchM
 SyA8AqMrBLYwknXkqjB2kYZhr6hD21ogwxNCr+VjfGJq3pzAQ/iuaOgL8FS7FyxF5T
 r/d5miWkXziTkftr4czmOGIF6H99QeIZXPIqJzddYswfle30w0MJDgsSX9zeUo1cVa
 i63uEie4y17MFMLd7Y1KHKTPr0TylahKvwXr6jGFc6tmp0t9FcUDKRq+oyFVtmpRVk
 QpVqbgdkYCdQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/ttm: Account for NULL and handle pages in
 ttm_pool_backup
To: "Matthew Brost" <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260702214815.4009271-1-matthew.brost@intel.com>
References: <20260702214815.4009271-1-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 22:03:56 +0000
Message-Id: <20260702220356.B16C81F000E9@smtp.kernel.org>
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
- [High] Missing backup handle guard in the backup loop causes a kernel oop=
s when retrying a partially failed backup.
- [High] Double DMA unmap and mismatched unmap sizes on backup failure retr=
y.
--

commit 8838e9f25b3625ff2d46011f99d3a64b02d5abdf
Author: Matthew Brost <matthew.brost@intel.com>

drm/ttm: Account for NULL and handle pages in ttm_pool_backup

This patch modifies ttm_pool_backup to account for NULL pages and backup
handles in the dma/purge loop. It adds a dedicated writeback pass before
the dma/purge loop that walks allocations and skips NULL and handle entries,
issuing set_pages_array_wb() once per contiguous run.

> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_poo=
l.c
> index 3d5f2ae0a4564..ff043420d517d 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
[ ... ]
> @@ -1075,7 +1097,7 @@ long ttm_pool_backup(struct ttm_pool *pool, struct =
ttm_tt *tt,
>  			unsigned int order;
> =20
>  			page =3D tt->pages[i];
> -			if (unlikely(!page)) {
> +			if (unlikely(!page || ttm_backup_page_ptr_is_handle(page))) {
>  				num_pages =3D 1;
>  				continue;
>  			}
>
>  			order =3D ttm_pool_page_order(pool, page);
>  			num_pages =3D 1UL << order;
>  			if (tt->dma_address)
>  				ttm_pool_unmap(pool, tt->dma_address[i],
>  					       num_pages);

[Severity: High]
This isn't a bug introduced by this patch, but does this loop leave stale
DMA addresses in tt->dma_address[i]?

If the subsequent backup loop fails on the first page due to an allocation
failure in ttm_backup_backup_page():

    shandle =3D ttm_backup_backup_page(backup, page, flags->writeback, i, .=
..);
    if (shandle < 0) {
        ret =3D shandle;
        break;
    }

The variable shrunken remains 0, and TTM_TT_FLAG_BACKED_UP is never set.

Since the buffer object remains eligible for immediate retry by the shrinke=
r,
will the next pass trigger a double unmap on these same addresses?=20

Additionally, since ttm_pool_split_for_swap() zeroes page->private right
before the failure, will the retry incorrectly unmap order-0 pages instead
of their original multi-order sizes?

[ ... ]

>  	for (i =3D 0; i < num_pages; ++i) {
>  		s64 shandle;
> =20
>  		page =3D tt->pages[i];
>  		if (unlikely(!page))
>  			continue;
> =20
>  		ttm_pool_split_for_swap(pool, page);

[Severity: High]
This is a pre-existing issue, but is there a missing check for backup handl=
es
in this loop?

If a buffer object is partially backed up, and userspace accesses it to
trigger a page fault, the TTM_TT_FLAG_BACKED_UP flag is cleared.

If the buffer object is later targeted by the shrinker again, the earlier
loops in this function will correctly skip the existing backup handles due
to the newly added ttm_backup_page_ptr_is_handle() guards.

However, in this final backup loop, will the code extract an existing backup
handle, bypass the !page check, and pass the handle directly to
ttm_pool_split_for_swap(), resulting in an invalid pointer dereference?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702214815.4009=
271-1-matthew.brost@intel.com?part=3D1
