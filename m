Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EAADC55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 11:47:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B27DD10EE1D;
	Wed,  5 Aug 2026 11:47:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cbBtjEdt";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CF1310EE1C
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 11:47:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3EDB960A89;
 Wed,  5 Aug 2026 11:47:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE95C1F00A3A;
 Wed,  5 Aug 2026 11:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785930446;
 bh=rzmWpsKWB9us/Ov+X48oZvYHsQ3nwfkd/YhbUgPU+pw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cbBtjEdthp/vhpAbzcXV3zQDLg3jc3YW235ivDAHhrCh8RhRZw1LDNOxLd9N25qan
 swRYAuCvAoR/Xpc03Kpd4w3roiQqHO62PSs+qjg31tAycUgo4Pii/idlgaPxRxE0rX
 ato7kAwbLB1S7hIE6rpbcZ5RqEyzilMwGRpkFwH7VJfQzzNiU0v6QUxmP3UcY3uF6N
 tRI1Mf8H2mvsxj+npYvXqDF8kJPhvtS473kMnPDOlI1vMJlN/sZHP1Bsf+vwL3NnMy
 UoGdRypAyMhi0vfrfz5THfFASW9etNvf3Jfrqy8Z9ay5taKDN3g37KAGzH2uIAc9gq
 1pXbA3Xz/9e2g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] drm/pagemap: Fix folio allocation fallback and
 use-after-put
To: "Matthew Brost" <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260805113338.3742178-4-matthew.brost@intel.com>
References: <20260805113338.3742178-1-matthew.brost@intel.com>
 <20260805113338.3742178-4-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 11:47:25 +0000
Message-Id: <20260805114725.BE95C1F00A3A@smtp.kernel.org>
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
- [Critical] Data corruption due to incorrect source page population during=
 THP allocation fallback.

Pre-existing issues:
- [Critical] Out-of-bounds DMA read during partial THP migrations because f=
ull THP order is blindly encoded.
- [High] Unconditionally setting MIGRATE_PFN_COMPOUND on destination PFNs b=
reaks PTE-level migration and leaks THPs.
--

--- Patch [3]: [PATCH 3/4] drm/pagemap: Fix folio allocation fallback and u=
se-after-put ---
commit f92ba61577518de0d554e1323b18348b10e22b1a
Author: Matthew Brost <matthew.brost@intel.com>
Subject: drm/pagemap: Fix folio allocation fallback and use-after-put

This commit adds a fallback to order-0 allocations in
drm_pagemap_migrate_populate_ram_pfn() if higher-order folio allocation
fails without setting MIGRATE_PFN_COMPOUND. It also factors out source
page population into drm_pagemap_migrate_populate_src_pages() and fixes a
use-after-put when freeing pages.

> diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
> index 892b325fa99b8..7610e233d238c 100644
> --- a/drivers/gpu/drm/drm_pagemap.c
> +++ b/drivers/gpu/drm/drm_pagemap.c
[ ... ]
> @@ -383,6 +383,58 @@ drm_pagemap_migrate_map_system_pages(struct device *=
dev,
>  	return 0;
>  }
> =20
> +/**
> + * drm_pagemap_migrate_populate_src_pages() - Populate the source page a=
rray
> + * @pages: Array of source pages to populate
> + * @src_mpfn: Source array of migrate PFNs
> + * @dst_mpfn: Destination array of migrate PFNs
> + * @npages: Number of pages in the arrays
> + *
> + * Populate @pages with the device pages the copy callback is to read fr=
om.
> + *
> + * Entries are normally only populated at the head of each source folio,=
 with
> + * the copy callback deriving the rest of the folio from the order recor=
ded in
> + * the corresponding drm_pagemap_addr. That does not work where
> + * drm_pagemap_migrate_populate_ram_pfn() had to demote a higher-order s=
ource
> + * folio to order-0 destination folios: the drm_pagemap_addr entries are=
 then
> + * per-page, and the copy callback needs a source page for each of them.
> + * Populate every entry for those ranges.
> + *
> + * Note that the source folio itself is only split later, by
> + * migrate_vma_pages() / migrate_device_pages(), so its order cannot be =
used to
> + * detect the demotion - the destination has to be inspected instead.
> + */
> +static void drm_pagemap_migrate_populate_src_pages(struct page **pages,
> +						   unsigned long *src_mpfn,
> +						   unsigned long *dst_mpfn,
> +						   unsigned long npages)
> +{
> +	unsigned long i;
> +
> +	for (i =3D 0; i < npages;) {
> +		struct page *page =3D migrate_pfn_to_page(src_mpfn[i]);
> +		unsigned int order =3D 0;
> +		unsigned long j, nr;
> +
> +		if (!page) {
> +			i++;
> +			continue;
> +		}
> +
> +		order =3D folio_order(page_folio(page));
> +		nr =3D NR_PAGES(order);
> +
> +		if (order && !(dst_mpfn[i] & MIGRATE_PFN_COMPOUND)) {
> +			for (j =3D 0; j < nr && i + j < npages; j++)
> +				pages[i + j] =3D folio_page(page_folio(page), j);
                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^

[Severity: Critical]
Can this result in data corruption by incorrectly assigning the head page?

If migrate_vma_setup() is triggered by an unaligned VMA or partial migratio=
n,
it can collect a partial device-private THP and place a tail page in
migrate.src[0].

If the subsequent THP allocation fails and we fall back to order-0 allocati=
ons
without MIGRATE_PFN_COMPOUND, this loop handles the demotion. However, since
page_folio(page) returns the head page, j =3D 0 will assign the head page r=
ather
than the correct subpage offset indicated by the original tail page.

Could this cause user memory at the destination to be populated with the wr=
ong
data from the source?

> +		} else {
> +			pages[i] =3D page;
> +		}
> +
> +		i +=3D nr;
> +	}
> +}
[ ... ]
> @@ -875,6 +927,7 @@ static int drm_pagemap_migrate_populate_ram_pfn(struc=
t vm_area_struct *vas,
>  		struct page *page =3D NULL, *src_page;
>  		struct folio *folio;
>  		unsigned int order =3D 0;
> +		gfp_t gfp =3D GFP_HIGHUSER;
> =20
>  		if (!(src_mpfn[i] & MIGRATE_PFN_MIGRATE))
>  			goto next;
> @@ -890,12 +943,38 @@ static int drm_pagemap_migrate_populate_ram_pfn(str=
uct vm_area_struct *vas,
>  		}
> =20
>  		order =3D folio_order(page_folio(src_page));
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: Critical]
This is a pre-existing issue, but does this unconditionally skip ahead by t=
he
full THP order, ignoring the actual bounds of a partial migration?

If migrate_vma_setup() processes an unaligned VMA range backed by a device =
THP,
it collects tail pages and npages will be smaller than the THP size. This c=
ode
unconditionally allocates a THP matching the source's full order, and then
later in this loop advances the index by the full order:

    i +=3D NR_PAGES(order);

When drm_pagemap_migrate_map_system_pages() subsequently encodes the full
compound order into the DMA address, the driver's copy_to_ram callback reads
the full THP size starting from the tail page.

Could this lead to an out-of-bounds physical memory read and potential memo=
ry
corruption if the copy exceeds the source physical allocation boundaries?

> +		if (order)
> +			gfp |=3D __GFP_NOWARN;
> =20
> -		/* TODO: Support fallback to single pages if THP allocation fails */
>  		if (vas)
> -			folio =3D vma_alloc_folio(GFP_HIGHUSER, order, vas, addr);
> +			folio =3D vma_alloc_folio(gfp, order, vas, addr);
>  		else
> -			folio =3D folio_alloc(GFP_HIGHUSER, order);
> +			folio =3D folio_alloc(gfp, order);
> +
> +		if (!folio && order) {
> +			/*
> +			 * Higher-order allocation failed, fall back to
> +			 * order-0 allocations for the entire range covered
> +			 * by the original higher-order allocation, without
> +			 * setting MIGRATE_PFN_COMPOUND, until we move past
> +			 * that range.
> +			 */
> +			unsigned long nr =3D NR_PAGES(order);
> +			unsigned long j;
> +
> +			gfp &=3D ~__GFP_NOWARN;
> +			for (j =3D 0; j < nr && i < npages; j++, i++, addr +=3D PAGE_SIZE) {
> +				folio =3D vas ?
> +					vma_alloc_folio(gfp, 0, vas, addr) :
> +					folio_alloc(gfp, 0);
> +				if (!folio)
> +					goto free_pages;
> +
> +				page =3D folio_page(folio, 0);
> +				mpfn[i] =3D migrate_pfn(page_to_pfn(page));
> +			}
> +			continue;
> +		}
> =20
>  		if (!folio)
>  			goto free_pages;
                ^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
This is a pre-existing issue, but does the code shortly after this point
unconditionally set MIGRATE_PFN_COMPOUND on the destination PFNs?

drm_pagemap_migrate_populate_ram_pfn() has the following sequence further d=
own:

    if (order)
        mpfn[i] |=3D MIGRATE_PFN_COMPOUND;

When migrate_vma_setup() processes a PTE-mapped THP or an unaligned range,
it doesn't set MIGRATE_PFN_COMPOUND in the source PFN array. Because this
function unconditionally sets it on the destination and skips subsequent en=
tries
by advancing the loop index by the full order, it creates a mismatch.

Will migrate_vma_pages() see mismatched flags, fall back to PTE-by-PTE
mapping, and skip the remaining entries because they are zeroed out, leaving
the VMA partially unmapped and leaking the newly allocated THPs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805113338.3742=
178-1-matthew.brost@intel.com?part=3D3
