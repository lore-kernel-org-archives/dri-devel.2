Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 353D4C5AC82
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 09:52:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E14B10E6EA;
	Mon, 10 Aug 2026 09:51:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aAYjQZ5e";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CC6210E6EA
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 09:51:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 27A6A42E4F;
 Mon, 10 Aug 2026 09:51:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD5701F000E9;
 Mon, 10 Aug 2026 09:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786355517;
 bh=ULSQMoMCiSaEOOLZSXj0/cajC4id9pwkEbtrgiElQLo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aAYjQZ5eceBNB0d+Kd/TDZLrnJL2bpaPnnD/3jWiHxTN0gY2SZEyRxvfPrzsn/V0L
 pMgExWD+e+LkN0LqAHXaWDGxBXWVio8XrUESmORwmZ3o7G6FrvStetDgKlwU0bTpcT
 zQ7CWQFdURvqk3IFPnGFxQHlH1FwZVGWJ6FdUThsLx9eUunfRUh2cVpnYvKC9ERt8I
 oxhiMx0nOSfzTdCu1B1423Hh88W+mIxIUjFyjxF8ZeRS9tLZ2+oVALnZE9kTYcN/SH
 TREJHHHEE9xWHLV++KBmGKInB3ZPE7VRDCQBbTad9MUVH/PsuMkzRrIyoAcWl6zPon
 E6lO6seSX/vkw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6] drm/pagemap: Prevent double migration of device pages
To: "Arvind Yadav" <arvind.yadav@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260810092845.2776097-1-arvind.yadav@intel.com>
References: <20260810092845.2776097-1-arvind.yadav@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 09:51:55 +0000
Message-Id: <20260810095156.DD5701F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Data race on folio->page.zone_device_data due to non-atomic read-m=
odify-write.

Pre-existing issues:
- [Critical] Out-of-bounds write in migrate_device_pfns and migrate_device_=
range.
- [High] Use-after-free when accessing page metadata after dropping the ref=
erence.
- [High] DMA mappings are leaked in error paths because unmapping is skippe=
d when the PFN array is zeroed.
--

--- Patch [1]: [PATCH v6] drm/pagemap: Prevent double migration of device p=
ages ---
commit 8398dc4cfadc132c4a2fb375e9dd9f211e6bb842
Author: Arvind Yadav <arvind.yadav@intel.com>
drm/pagemap: Prevent double migration of device pages

A device-private folio migrated to system memory by a CPU fault can
remain reachable through the raw-PFN eviction path until migration
finalization drops the source reference.

> diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
> --- a/drivers/gpu/drm/drm_pagemap.c
> +++ b/drivers/gpu/drm/drm_pagemap.c

[ ... ]

> +static void drm_pagemap_page_set_flags(struct page *page,
> +				       unsigned long flags)
> +{
> +	struct folio *folio =3D page_folio(page);
> +	unsigned long old;
> +
> +	if (WARN_ON_ONCE(flags & ~DRM_PAGEMAP_ZDD_FLAG_MASK))
> +		return;
> +
> +	old =3D (unsigned long)folio_zone_device_data(folio);
> +	folio_set_zone_device_data(folio, (void *)(old | flags));
> +}

[Severity: High]
Can this non-atomic read-modify-write race with concurrent lockless readers?

If a CPU fault handler calls __drm_pagemap_migrate_to_ram() and reads this
pointer locklessly via drm_pagemap_page_zone_device_data(), and this functi=
on
updates it concurrently, could the lack of READ_ONCE()/WRITE_ONCE() protect=
ion
result in a torn pointer read and subsequent pointer corruption?

[ ... ]

> @@ -1148,6 +1253,8 @@ int drm_pagemap_evict_to_ram(struct drm_pagemap_dev=
mem *devmem_allocation)
>  	if (err)
>  		goto err_free;
> =20
> +	drm_pagemap_skip_retired_pages(src, npages);
> +
>  	err =3D drm_pagemap_migrate_populate_ram_pfn(NULL, NULL, npages, &mpage=
s,
>  						   src, dst, 0);

[Severity: Critical]
This is a pre-existing issue, but does migrate_device_pfns() (called just
before this snippet) have an out-of-bounds write if the migrated memory ran=
ge
ends midway through a large folio?

Looking at migrate_device_pfns() in mm/migrate_device.c:

	for (j =3D 1; j < nr; j++)
		src_pfns[i+j] =3D 0;

Since the inner loop doesn't check if i + j < npages, if a caller passes an
array of pfns where the last elements belong to a large folio, this clears
subsequent elements past the end of the src_pfns array, potentially corrupt=
ing
adjacent memory like the dst array.

[Severity: High]
This is also a pre-existing issue, but is there a use-after-free in the err=
or
cleanup path of drm_pagemap_migrate_populate_ram_pfn() called here?

When cleaning up after a failure, the code drops the page reference and then
immediately accesses its metadata to determine the loop advancement step:

drm_pagemap_migrate_populate_ram_pfn() {
...
free_pages:
	...
	put_page(page);
	mpfn[i] =3D 0;

	order =3D folio_order(page_folio(page));
...
}

If put_page() drops the last reference and frees the page, isn't the
subsequent call to folio_order(page_folio(page)) accessing freed memory?

[ ... ]

> @@ -1308,6 +1418,7 @@ static int __drm_pagemap_migrate_to_ram(struct vm_a=
rea_struct *vas,
>  	if (err)
>  		drm_pagemap_migration_unlock_put_pages(npages, migrate.dst);
>  	migrate_vma_pages(&migrate);
> +	drm_pagemap_retire_migrated_pages(migrate.src, npages);
>  	migrate_vma_finalize(&migrate);
>  	if (dev)
>  		drm_pagemap_migrate_unmap_pages(dev, pagemap_addr, migrate.dst,

[Severity: High]
This is a pre-existing issue, but are DMA mappings leaked in this error pat=
h?

If an error occurs, drm_pagemap_migration_unlock_put_pages() is called
which zeroes out the migrate.dst array:

drm_pagemap_migration_unlock_put_pages() {
	...
	drm_pagemap_migration_unlock_put_folio(folio);
	migrate_pfn[i] =3D 0;
	...
}

Subsequently, drm_pagemap_migrate_unmap_pages() is called to unmap the DMA
addresses, but it explicitly skips entries where the page is NULL:

drm_pagemap_migrate_unmap_pages() {
	...
	if (!page || !pagemap_addr[i].addr || dma_mapping_error(dev, pagemap_addr[=
i].addr))
		goto next;
	...
}

Since all pages in the array were just zeroed, migrate_pfn_to_page() will
return NULL for all of them, bypassing the unmap and leaving the DMA mappin=
gs
orphaned.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810092845.2776=
097-1-arvind.yadav@intel.com?part=3D1
