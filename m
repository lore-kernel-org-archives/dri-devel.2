Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BB38C5CFC1
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 07:03:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F7BD10E65D;
	Mon, 17 Aug 2026 07:03:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="g88g+vr0";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39A3F10E65D
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 07:03:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8D4F060120;
 Mon, 17 Aug 2026 07:03:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2099B1F000E9;
 Mon, 17 Aug 2026 07:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786950199;
 bh=1uNBOPtBj/iubqKxJr3Tr7Hj9KTHHNxmFkqCHAlk3Uo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=g88g+vr0O2bucFwY0OjHEbYxaGQHgDDyMZNkNpczSKvNjXET+AqfcEq8LAr/i1vbU
 sHTNrRzgBgWhJBVPDlEyORlf6J+MZTEbdFCYvAOSVruAs9JEMX2ksi3qsexn9uU5f7
 dueO1wOJjXGKV6di1DMwNLKyQdzRJ6050ZbWbvF04r+a4lPK7lUMFYu92xLIMb/gNi
 ZuwAEZujSHvPBa1emuQ7N0yQgavCL968SBpae9voxCzMQIk3WAyLoauQiJcZxM/Ea8
 DRuZsZdSNnuI8Fny1oCQdkxSje6or6u0MJ3gVj8GJLBhw3PMM1SvxEAvKKu+yYNGcF
 0fjBCznK0pDqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] drm/nouveau/dmem: pin VRAM for the whole registered
 range
To: "Junrui Luo" <moonafterrain@outlook.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260817-nouveau-fixes-v1-1-f518d0c735f3@outlook.com>
References: <20260817-nouveau-fixes-v1-0-f518d0c735f3@outlook.com>
 <20260817-nouveau-fixes-v1-1-f518d0c735f3@outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 07:03:18 +0000
Message-Id: <20260817070319.2099B1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Double unmap of DMA pages in nouveau_dmem_evict_chunk error path.
- [High] DMA mapping leak in device memory migration paths for THP folios.
- [High] Device memory migration completely broken due to invalid page_shif=
t in nouveau_pfns_map().
- [High] Splitting a THP folio will cause chunk->callocated to underflow.
- [High] NULL pointer dereference occurs in nouveau_dmem_chunk_alloc() when=
 migrating large folios if CONFIG_TRANSPARENT_HUGEPAGE is disabled.
- [Medium] Device memory leak of 508KB per chunk in nouveau_dmem_chunk_allo=
c() for non-THP allocations.
--

--- Patch [1]: [PATCH 1/2] drm/nouveau/dmem: pin VRAM for the whole registe=
red range ---
commit d125a5f88d0941299dc186384f431b1921ef50ed
Author: Junrui Luo <moonafterrain@outlook.com>

drm/nouveau/dmem: pin VRAM for the whole registered range

Commit c32287471077 ("gpu/drm/nouveau: enable THP support for GPU memory
migration") grew the device-private region that
nouveau_dmem_chunk_alloc() registers from DMEM_CHUNK_SIZE to
DMEM_CHUNK_SIZE * NR_CHUNKS, but left the VRAM buffer object backing that
region at DMEM_CHUNK_SIZE. This commit sizes the buffer object to the
region it backs.

Fixes: c32287471077 ("gpu/drm/nouveau: enable THP support for GPU memory mi=
gration")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>

> diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nou=
veau/nouveau_dmem.c
> index 9442ec6e1f6c1..356ff8f3c1b84 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
> @@ -325,8 +325,8 @@ nouveau_dmem_chunk_alloc(struct nouveau_drm *drm, str=
uct page **ppage,
>  	chunk->pagemap.ops =3D &nouveau_dmem_pagemap_ops;
>  	chunk->pagemap.owner =3D drm->dev;
> =20
> -	ret =3D nouveau_bo_new_pin(&drm->client, NOUVEAU_GEM_DOMAIN_VRAM, DMEM_=
CHUNK_SIZE,
> -				 &chunk->bo);
> +	ret =3D nouveau_bo_new_pin(&drm->client, NOUVEAU_GEM_DOMAIN_VRAM,
> +				 DMEM_CHUNK_SIZE * NR_CHUNKS, &chunk->bo);
>  	if (ret)
>  		goto out_release;

[ ... ]

> 	pfn =3D pfn_first;
> 	for (i =3D 0; i < NR_CHUNKS; i++) {
> 		int j;
>=20
> 		if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) || !is_large) {
> 			for (j =3D 0; j < DMEM_CHUNK_NPAGES - 1; j++, pfn++) {

[Severity: Medium]
This isn't a bug introduced by this patch, but does this loop skip and
leak pages?

The loop initialization runs NR_CHUNKS times, and its inner loop runs
DMEM_CHUNK_NPAGES - 1 times, continually incrementing pfn. This populates
exactly NR_CHUNKS * (DMEM_CHUNK_NPAGES - 1) pages into free_pages.

After the loop, 1 page is popped and returned to the caller, leaving the
remaining pages in free_pages. The rest of the pages at the end of the
allocated physical and VRAM region appear to be uninitialized and
permanently leaked.

[ ... ]

> 		} else {
> 			page =3D pfn_to_page(pfn);
> 			page->zone_device_data =3D drm->dmem->free_folios;
> 			drm->dmem->free_folios =3D page_folio(page);
> 			pfn +=3D DMEM_CHUNK_NPAGES;
> 		}
> 	}
>=20
> 	/* Move to next page */
> 	if (is_large) {
> 		*ppage =3D &drm->dmem->free_folios->page;

[Severity: High]
This is a pre-existing issue, but can this dereference a NULL pointer?

If migrate_vma_setup() sets MIGRATE_PFN_COMPOUND for large page cache
folios, is_large evaluates to true. If CONFIG_TRANSPARENT_HUGEPAGE is
disabled, the earlier condition evaluates to true and populates free_pages
instead of free_folios.

Immediately after, the code checks if (is_large) and attempts to
dereference drm->dmem->free_folios->page, which would still be NULL.


drivers/gpu/drm/nouveau/nouveau_dmem.c:nouveau_dmem_evict_chunk() {
    ...
        nouveau_dmem_copy_folio(chunk->drm,
            page_folio(migrate_pfn_to_page(src_pfns[i])),
            page_folio(dpage),
            &dma_info[i]);
    ...
        dma_unmap_page(chunk->drm->dev->dev, dma_info[i].dma_addr,
                dma_info[i].size, DMA_BIDIRECTIONAL);
    ...
}

[Severity: High]
This is a pre-existing issue, but does this lead to a double unmap of DMA
pages on error?

In nouveau_dmem_copy_folio(), if the internal copy fails, it calls
dma_unmap_page() but returns -EIO without clearing dma_info->dma_addr or
size.

The loop in nouveau_dmem_evict_chunk() ignores the return value from
nouveau_dmem_copy_folio() and proceeds. It then unconditionally loops over
all npages and calls dma_unmap_page() using dma_info[i].

For pages that failed to copy, wouldn't this unmap the same DMA address a
second time, potentially corrupting DMA API state?


drivers/gpu/drm/nouveau/nouveau_dmem.c:nouveau_dmem_migrate_to_ram() {
    ...
        dma_unmap_page(drm->dev->dev, dma_info.dma_addr, PAGE_SIZE,
                        DMA_BIDIRECTIONAL);
    ...
}

[Severity: High]
This is a pre-existing issue, but does this hardcoded PAGE_SIZE leak DMA
mappings for THP folios?

nouveau_dmem_copy_folio() maps destination pages using page_size(dpage),
which evaluates to the full size for THP folios, and stores this in
dma_info.size.

However, the cleanup paths in nouveau_dmem_migrate_to_ram() on success,
and nouveau_dmem_migrate_copy_one() on error, hardcode PAGE_SIZE when
calling dma_unmap_page().

Does this leave the remaining pages of the folio permanently mapped in the
IOMMU?


drivers/gpu/drm/nouveau/nouveau_dmem.c:nouveau_dmem_migrate_chunk() {
    ...
        nouveau_pfns_map(svmm, args->vma->vm_mm, args->start, pfns, i, orde=
r);
    ...
}

drivers/gpu/drm/nouveau/nouveau_svm.c:nouveau_pfns_map() {
    ...
    args->p.size =3D npages << page_shift;
    args->p.page =3D page_shift;
    ...
}

[Severity: High]
This is a pre-existing issue, but is the page_shift parameter incorrect
here?

In nouveau_dmem_migrate_chunk(), nouveau_pfns_map() is called with order
(which is 0 or 9) instead of the actual shift like PAGE_SHIFT (12 or 21).

In nouveau_pfns_map(), this parameter is used to populate args->p.size and
args->p.page. Because npages is the number of 4KB pages processed, if
order =3D 0 is passed, size evaluates to exactly the number of 4KB pages in
bytes, instead of the correct mapping size.

Does this cause the VMM IOCTL backend to reject the mapping payload due
to invalid sizes and shifts?


drivers/gpu/drm/nouveau/nouveau_dmem.c:nouveau_dmem_folio_split() {
    ...
static void nouveau_dmem_folio_split(struct folio *head, struct folio *tail)
    ...
}

drivers/gpu/drm/nouveau/nouveau_dmem.c:nouveau_dmem_folio_free() {
    ...
    WARN_ON(!chunk->callocated);
    chunk->callocated--;
    ...
}

[Severity: High]
This isn't a bug introduced by this patch, but does splitting a THP folio
cause an underflow of chunk->callocated?

When a large THP folio is allocated, it increments chunk->callocated by 1.
If the kernel splits this folio, nouveau_dmem_folio_split() is called for
each tail page.

However, nouveau_dmem_folio_split() does not appear to adjust
chunk->callocated to account for the newly split discrete pages.

When these split pages are subsequently freed, nouveau_dmem_folio_free()
will decrement chunk->callocated multiple times for what was originally
a single increment. Will this underflow chunk->callocated and trigger
the WARN_ON() checks?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817-nouveau-fi=
xes-v1-0-f518d0c735f3@outlook.com?part=3D1
