Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 771BAC5AC82
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 07:21:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEAB110E186;
	Mon, 10 Aug 2026 07:21:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QiHgVPe/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48A9B10E186
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 07:21:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0CD8B42A6D;
 Mon, 10 Aug 2026 07:21:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C46581F000E9;
 Mon, 10 Aug 2026 07:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786346460;
 bh=R8AGGKJYO0+/xfC7g6I6KcdnEDmkKUbWkUR4ZudqXIo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QiHgVPe/JxVobOnNWO0F2MFYld3XlVv3kFBLraTwXEB5nc/ghMYxXxmGsYT0hW6r8
 sqNWWS471P+98bOfDbih7/cDSk1YlSM4sw6GGgkv1qAHWVxy2MlsYzP/oVYNcy6T+6
 Va4LtL8IFuzHqHx+VxFSjH0ezyYwSqd0iqzip7iGOcXNLPTiAVPbg7p9B8BOf8ib8e
 FoJgQRDHcCEj6g2fZEiKRWosfD9DHFB8vr4uII4OoCmkUgz/MAU5ORSOWLZ4Ra+iTS
 iG7hfdg7qvzRy0hcCTGgb0aTcVnwzyQgYwuVuffGf+8ZlQIWoWXIhrw0FDuC1QnjeY
 ZBPqPY59P6p+g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] drm/pagemap: Prevent double migration of device pages
To: "Arvind Yadav" <arvind.yadav@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260810070240.2721317-1-arvind.yadav@intel.com>
References: <20260810070240.2721317-1-arvind.yadav@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 07:21:00 +0000
Message-Id: <20260810072100.C46581F000E9@smtp.kernel.org>
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

New issues:
- [High] Incorrect PFN array iteration when encountering large folios cause=
s unrelated folios to be skipped, and leaves tail pages improperly processe=
d.

Pre-existing issues:
- [High] Out-of-bounds array write in `migrate_device_pfns()` when processi=
ng compound pages.
--

--- Patch [1]: [PATCH v5] drm/pagemap: Prevent double migration of device p=
ages ---
commit e82d028d2739c02084b327b5c44a4c4cb949a76c
Author: Arvind Yadav <arvind.yadav@intel.com>
Subject: drm/pagemap: Prevent double migration of device pages

This patch aims to prevent soft lockups caused by double migration of
device-private folios. It marks successfully migrated folios in their
zone_device_data and makes both CPU-fault and raw-PFN migration paths
skip folios carrying this flag.

> diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
> --- a/drivers/gpu/drm/drm_pagemap.c
> +++ b/drivers/gpu/drm/drm_pagemap.c
[ ... ]
> +static void drm_pagemap_skip_retired_pages(unsigned long *src_pfns,
> +					   unsigned long npages)
> +{
> +	unsigned long i =3D 0;
> +
> +	while (i < npages) {
> +		struct page *page =3D migrate_pfn_to_page(src_pfns[i]);
> +
> +		if (!page) {
> +			i++;
> +			continue;
> +		}
> +
> +		if ((src_pfns[i] & MIGRATE_PFN_MIGRATE) &&
> +		    is_device_private_page(page) &&
> +		    (drm_pagemap_page_get_flags(page) &
> +		     DRM_PAGEMAP_ZDD_FLAG_MIGRATED))
> +			src_pfns[i] &=3D ~MIGRATE_PFN_MIGRATE;
> +

[Severity: High]
Does advancing by folio_nr_pages() here leave tail pages improperly
processed?

By only clearing the MIGRATE_PFN_MIGRATE bit for src_pfns[i] (the head page)
and then skipping ahead, any subsequent tail pages in the src_pfns array
will remain flagged.

Downstream functions like migrate_vma_pages() process every array entry, so
they might see the un-cleared tail pages and attempt to migrate them
individually. Could this defeat the fix and trigger the double migration
lockups again?

Also, if the PFN array starts on a tail page due to VMA boundary clamping,
will advancing by the full folio_nr_pages() overshoot the folio's actual
footprint in the array and skip completely unrelated folios?

This same pattern appears in drm_pagemap_retire_migrated_pages() just above.
There are also pre-existing loops in drm_pagemap_evict_to_ram(),
__drm_pagemap_migrate_to_ram(), and drm_pagemap_migrate_populate_ram_pfn()
that advance using i +=3D NR_PAGES(order) and might suffer from this same
tail-page stepping issue.

> +		i +=3D folio_nr_pages(page_folio(page));
> +	}
> +}
[ ... ]
> @@ -1143,6 +1240,8 @@ int drm_pagemap_evict_to_ram(struct drm_pagemap_dev=
mem *devmem_allocation)
>  	if (err)
>  		goto err_free;
> =20
> +	drm_pagemap_skip_retired_pages(src, npages);
> +

[Severity: High]
This is a pre-existing issue, but does migrate_device_pfns() (called just
above this in drm_pagemap_evict_to_ram) lack bounds checking when processing
compound pages?

When the following loop in mm/migrate_device.c:migrate_device_pfns()
encounters a compound page, it zeroes out subsequent entries in the src_pfns
array up to the full size of the compound page:

mm/migrate_device.c:migrate_device_pfns() {
    ...
    for (j =3D 1; j < nr; j++)
        src_pfns[i+j] =3D 0;
    ...
}

If a large folio extends beyond the npages limit, such as when the caller
passes a clamped range or an unaligned array size, this loop will write
zeros past the end of the src_pfns allocation.

Could this corrupt adjacent memory, like the uninitialized dst array
allocated concurrently?

>  	err =3D drm_pagemap_migrate_populate_ram_pfn(NULL, NULL, npages, &mpage=
s,
>  						   src, dst, 0);
>  	if (err || !mpages)
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810070240.2721=
317-1-arvind.yadav@intel.com?part=3D1
