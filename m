Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 201F7C5AC7C
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 08:36:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A0AF10F412;
	Fri,  7 Aug 2026 08:36:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fji/6Q5q";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 665DB10F412
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 08:36:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6C34360A86;
 Fri,  7 Aug 2026 08:36:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 034891F000E9;
 Fri,  7 Aug 2026 08:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786091798;
 bh=SuTrIiv51itiWgHUgwTfj629GgbdBkddkFy2tue62tg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fji/6Q5qs725eHq8uGGEZNJdMMmXEliK7WUIExsDZtaFKJ7TvsOz8bTXFkjMogf0x
 mPcrIesYk1aPp/EKt1YjMSdR5w9BuLadLTSPc/kw8Gh4MEZFBTWhmf1pksmFkS7COH
 gTCrcIKPXWnoGI2eoAfiqUOv8fhbeHAOft59QWUsxZS6EWBFA/GusKt7xsb0UsT8T2
 cxj4D2MI38+BZSQUFvLtEJjmXlNWqARY/26iZuJS1yIlVSzwcm2AZ6PBtokzBQXg3u
 keihiOYPhIv3z6aMf7vLplLDelHWyYcE16FrV6GfBDlERnHwR/mZW8DnsOXHpHydwr
 MwF/1jEXONWNw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] drm/pagemap: Prevent double migration of device pages
To: "Arvind Yadav" <arvind.yadav@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260807081244.2229191-1-arvind.yadav@intel.com>
References: <20260807081244.2229191-1-arvind.yadav@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 08:36:37 +0000
Message-Id: <20260807083638.034891F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Double migration of device pages due to missing flag in peer-to-pe=
er migration.
- [High] DMA mappings are leaked on the error path because the destination =
PFN array is zeroed out before unmapping.
- [High] Use-after-free of folio metadata in the error path of `drm_pagemap=
_migrate_populate_ram_pfn`.
--

--- Patch [1]: [PATCH v4] drm/pagemap: Prevent double migration of device p=
ages ---
commit ddf1406cd4fcd17693eecb3abf05b87068425942
Author: Arvind Yadav <arvind.yadav@intel.com>
Subject: drm/pagemap: Prevent double migration of device pages

This patch addresses a double migration bug involving device-private folios.
It flags successfully migrated device folios using a low bit in their
zone_device_data before migration finalization, ensuring that raw-PFN
eviction paths skip them.

> --- a/drivers/gpu/drm/drm_pagemap.c
> +++ b/drivers/gpu/drm/drm_pagemap.c
[ ... ]
> @@ -1143,6 +1250,8 @@ int drm_pagemap_evict_to_ram(struct drm_pagemap_dev=
mem *devmem_allocation)
>  	if (err)
>  		goto err_free;
> =20
> +	drm_pagemap_skip_retired_pages(src, npages);
> +
>  	err =3D drm_pagemap_migrate_populate_ram_pfn(NULL, NULL, npages, &mpage=
s,
>  						   src, dst, 0);

[Severity: High]
This is a pre-existing issue, but does this call to
drm_pagemap_migrate_populate_ram_pfn() trigger a use-after-free on its error
path?

If page allocation fails inside drm_pagemap_migrate_populate_ram_pfn(), the
cleanup path jumps to the free_pages label:

free_pages:
	for (i =3D 0; i < npages;) {
		struct page *page =3D migrate_pfn_to_page(mpfn[i]);
		unsigned int order =3D 0;

		if (!page)
			goto next_put;

		put_page(page);
		mpfn[i] =3D 0;

		order =3D folio_order(page_folio(page));

Is it safe to read the folio_order metadata after put_page() has dropped the
reference and potentially freed the page? It looks like this could result in
garbage order values, leading to incorrect loop increments and missed clean=
ups.

>  	if (err || !mpages)
>  		goto err_finalize;
[ ... ]
> @@ -1173,6 +1282,7 @@ int drm_pagemap_evict_to_ram(struct drm_pagemap_dev=
mem *devmem_allocation)
>  	if (err)
>  		drm_pagemap_migration_unlock_put_pages(npages, dst);
>  	migrate_device_pages(src, dst, npages);
> +	drm_pagemap_retire_migrated_pages(src, npages);
>  	migrate_device_finalize(src, dst, npages);
>  	drm_pagemap_migrate_unmap_pages(devmem_allocation->dev, pagemap_addr, d=
st, npages,
>  					DMA_FROM_DEVICE, &state);

[Severity: High]
This is a pre-existing issue, but I am wondering if the peer-to-peer migrat=
ion
path is also vulnerable to this same double-migration bug?

Looking at drm_pagemap_migrate_to_devmem(), it finalizes the migration
without calling drm_pagemap_retire_migrated_pages() to set the flag on the
source folio:

err_aborted_migration:
	migrate_vma_pages(&migrate);

	for (i =3D 0; !err && i < npages;) {
...
	migrate_vma_finalize(&migrate);

Could a concurrent eviction select the same device folio, fail to skip it
since the migrated flag is missing, and attempt to migrate it again?

[ ... ]
> @@ -1303,6 +1413,7 @@ static int __drm_pagemap_migrate_to_ram(struct vm_a=
rea_struct *vas,
>  	if (err)
>  		drm_pagemap_migration_unlock_put_pages(npages, migrate.dst);
>  	migrate_vma_pages(&migrate);
> +	drm_pagemap_retire_migrated_pages(migrate.src, npages);
>  	migrate_vma_finalize(&migrate);
>  	if (dev)
>  		drm_pagemap_migrate_unmap_pages(dev, pagemap_addr, migrate.dst,

[Severity: High]
This is a pre-existing issue, but does this error path permanently leak DMA
mappings?

If an error occurs, drm_pagemap_migration_unlock_put_pages() is called, whi=
ch
zeroes out the migrate.dst array internally:

static void drm_pagemap_migration_unlock_put_pages(...)
{
...
		drm_pagemap_migration_unlock_put_folio(folio);
		migrate_pfn[i] =3D 0;
...
}

Then shortly after, we pass that same zeroed array to
drm_pagemap_migrate_unmap_pages().

Inside drm_pagemap_migrate_unmap_pages(), it retrieves the page:

		struct page *page =3D migrate_pfn_to_page(migrate_pfn[i]);

		if (!page || !pagemap_addr[i].addr || dma_mapping_error(...))
			goto next;

Since the array entries were zeroed, migrate_pfn_to_page(0) returns NULL,
causing the loop to bypass dma_unmap_page() entirely.

>  						npages, DMA_FROM_DEVICE,
>  						&state);
>  err_free:
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807081244.2229=
191-1-arvind.yadav@intel.com?part=3D1
