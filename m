Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFE58C55ABF
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 06:29:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7DE310E28F;
	Thu,  6 Aug 2026 06:29:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FZWGLcNC";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29E6A10E28F
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 06:29:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BCA3340BFE;
 Thu,  6 Aug 2026 06:29:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74AC11F00A3A;
 Thu,  6 Aug 2026 06:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785997746;
 bh=ZDVKwe0tYfYuq8UUHc7YfyO53ZuAqx+bgTUppXsQ9Lk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FZWGLcNCtrOSv3VQ7ypEoR2wp04o8/+eXo1A5Cp8vG7jFqALvDeQeJ4LWa4rkxz24
 J5Q8saHU1dVYE3uIxKdKjfMgg2adaFwM1ysKHaKHXB9a4r0F1dmY6E1omdrjqn/C6V
 6UOevlE+xnKPCJxUsynX7+ddUOQJenuBmU+2rB0BwbHmf6f0qFi/KUBl73EbHlvrDQ
 SZwhqF1R6R7IrI6VC6GbtqvYLLS1R/ZYjLpcyO0M9G++W/WedrUQTJ8LYLcwjNrc5j
 o8ieudir/3spKzotWBZs3ESvYBP6f7DH790TK1Hp0oWM0z745cNOvlQwyt/5JM/sPE
 xTcbi5BrSpRdA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/pagemap: Prevent double migration of device pages
To: "Arvind Yadav" <arvind.yadav@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260806061126.1499149-1-arvind.yadav@intel.com>
References: <20260806061126.1499149-1-arvind.yadav@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 06:29:05 +0000
Message-Id: <20260806062906.74AC11F00A3A@smtp.kernel.org>
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
- [High] VMA virtual address changes (e.g., via mremap) break the retiremen=
t bitmap indexing, leading to massive memory allocation failures or infinit=
e page fault loops.
- [Medium] High-order kzalloc scaling with user-controlled VMA size is high=
ly susceptible to fragmentation failures.

Pre-existing issues:
- [High] Accessing folio metadata after dropping the page reference in the =
error path.
- [High] DMA mappings are leaked on error paths because the destination pag=
e array is cleared before unmapping.
--

--- Patch [1]: [PATCH v2] drm/pagemap: Prevent double migration of device p=
ages ---
commit 7672ff30a01aa092f294e4781fd86acb84ceecb0
Author: Arvind Yadav <arvind.yadav@intel.com>
drm/pagemap: Prevent double migration of device pages

A device page migrated to system memory by a CPU fault can remain
referenced after migration completes. During this window, raw-PFN eviction
can collect the same device PFN and migrate it again.

> diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
> --- a/drivers/gpu/drm/drm_pagemap.c
> +++ b/drivers/gpu/drm/drm_pagemap.c
> @@ -78,29 +85,38 @@ struct drm_pagemap_zdd {
>  static struct drm_pagemap_zdd *
> -drm_pagemap_zdd_alloc(struct drm_pagemap *dpagemap)
> +drm_pagemap_zdd_alloc(struct drm_pagemap *dpagemap, unsigned long start,
> +		      unsigned long npages)
>  {
>  	struct drm_pagemap_zdd *zdd;
> =20
> -	zdd =3D kmalloc_obj(*zdd);
> +	zdd =3D kzalloc(struct_size(zdd, retire_map, BITS_TO_LONGS(npages)),
> +		      GFP_KERNEL);

[Severity: Medium]
Does this allocation scale linearly with a user-supplied VMA size?

If a user maps a large region of device memory, this kzalloc request in
drm_pagemap_zdd_alloc() might require a high-order contiguous allocation.
This could fail easily on a fragmented system.

Would it be safer to use kvzalloc here instead?

[ ... ]

> @@ -875,32 +875,25 @@ static int drm_pagemap_migrate_populate_ram_pfn
>  	return 0;
> =20
>  free_pages:
>  	for (i =3D 0; i < npages;) {
>  		struct page *page =3D migrate_pfn_to_page(mpfn[i]);
>  		unsigned int order =3D 0;
> =20
>  		if (!page)
>  			goto next_put;
> =20
>  		put_page(page);
>  		mpfn[i] =3D 0;
> =20
>  		order =3D folio_order(page_folio(page));

[Severity: High]
This is a pre-existing issue, but can this dereference freed memory?

By the time folio_order() is called in the error path of
drm_pagemap_migrate_populate_ram_pfn(), the reference to page has already
been dropped via put_page(). This means the underlying folio metadata could
be freed or reused before it is read.

Should the order be cached before dropping the reference?

[ ... ]

> @@ -1295,10 +1295,12 @@ int drm_pagemap_evict_to_ram(struct drm_pagemap_d=
evmem *devmem_allocation)
>  err_finalize:
>  	if (err)
>  		drm_pagemap_migration_unlock_put_pages(npages, dst);
>  	migrate_device_pages(src, dst, npages);
> +	/* Raw-PFN eviction: array starts at allocation offset zero. */
> +	drm_pagemap_retire_migrated_pages(src, npages, 0);
>  	migrate_device_finalize(src, dst, npages);
>  	drm_pagemap_migrate_unmap_pages(devmem_allocation->dev, pagemap_addr, d=
st, npages,
>  					DMA_FROM_DEVICE, &state);

[Severity: High]
This is a pre-existing issue, but does this error path permanently leak DMA
mappings?

Looking at drm_pagemap_evict_to_ram(), if there is an error it calls
drm_pagemap_migration_unlock_put_pages(), which sets the entries in the dst
array to 0. When drm_pagemap_migrate_unmap_pages() subsequently runs using
the same dst array, it skips unmapping because the entries are now null.

Should the unmap occur before the array is zeroed?

[ ... ]

> @@ -1369,6 +1373,10 @@ static int __drm_pagemap_migrate_to_ram(struct vm_=
area_struct *vas,
>  	if (end > vas->vm_end)
>  		end =3D vas->vm_end;
> =20
> +	/* Keep the range within the ZDD allocation so retirement offsets stay =
valid. */
> +	start =3D max(start, zdd->range_start);
> +	end =3D min(end, zdd->range_start + (zdd->range_npages << PAGE_SHIFT));
> +
>  	migrate.start =3D start;
>  	migrate.end =3D end;
>  	npages =3D npages_in_range(start, end);

[Severity: High]
What happens if userspace moves the VMA to a different virtual address via
mremap?

If the VMA is moved to a higher address, clipping against the static
zdd->range_start in __drm_pagemap_migrate_to_ram() could result in start
being greater than end. This would cause an underflow in npages_in_range(),
leading to an extremely large kvcalloc attempt. If kvcalloc succeeds, the
migrate_vma_setup() loop immediately exits and returns 0 migrated pages,
which could result in an infinite page fault loop.

How should we handle moved VMAs here?

[ ... ]

> @@ -1433,6 +1435,8 @@ static int __drm_pagemap_migrate_to_ram(struct vm_a=
rea_struct *vas,
>  err_finalize:
>  	if (err)
>  		drm_pagemap_migration_unlock_put_pages(npages, migrate.dst);
>  	migrate_vma_pages(&migrate);
> +	drm_pagemap_retire_migrated_pages(migrate.src, npages,
> +					  (start - zdd->range_start) >> PAGE_SHIFT);
>  	migrate_vma_finalize(&migrate);
>  	if (dev)
>  		drm_pagemap_migrate_unmap_pages(dev, pagemap_addr, migrate.dst,
>  						npages, DMA_FROM_DEVICE,
>  						&state);

[Severity: High]
This is a pre-existing issue, but does this error path permanently leak DMA
mappings?

Looking at __drm_pagemap_migrate_to_ram(), similar to the issue above, if
there is an error it calls drm_pagemap_migration_unlock_put_pages() which
zeroes the migrate.dst array. The subsequent call to
drm_pagemap_migrate_unmap_pages() then skips unmapping because the entries
are null.

Should the unmap occur before the array is zeroed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806061126.1499=
149-1-arvind.yadav@intel.com?part=3D1
