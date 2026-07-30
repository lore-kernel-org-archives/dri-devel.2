Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10CBBC54FD2
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 06:30:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 082B510E656;
	Thu, 30 Jul 2026 06:30:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HGcHiF9w";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 955FB10E656
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 06:30:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 25818431C5;
 Thu, 30 Jul 2026 06:30:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD2AE1F000E9;
 Thu, 30 Jul 2026 06:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785393010;
 bh=eVNW4aqTV6n6CIBLKslFrMbN3c9jVoRpqKEmBmBAfzU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HGcHiF9wQ3xgAXI8AIfVJ6/we5D66/qjQJDWp0jxCfyA+PDc6+/muyNkNbGc0Kc23
 R6mcXgL8VHSTvhwq6IYassZgeCuJG8VoGWgjQc/ycl+icX2aneLS7eiaRdJcwm+YLJ
 gOMJ6myBNG3J3DY5qMBQ9c5OFBVYtYM91GOWjvZ3SZSWSgIIuy05iQTqdfros6dlvR
 ZlIthAY+wwAqd3EfFIKJ6efkYmgxACG19qOznQ1V0nDoSomgT9suboIQ2xICa2SOYR
 sPcOeYkiTZrPe2iwBGJzUh4KZh81ffwpioUGdcDJv2/BvLPoDNe5pWHeFMrHx0+Gp0
 lAwTd23aAiBmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/pagemap: Remove unreachable code in
 drm_pagemap_migrate_to_devmem()
To: yaolu@kylinos.cn
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260730061635.132619-1-yaolu@kylinos.cn>
References: <20260730061635.132619-1-yaolu@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 06:30:09 +0000
Message-Id: <20260730063009.CD2AE1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] The patch removes a critical safeguard against unsupported same-pa=
gemap migrations, erroneously assuming it is unreachable. However, a discre=
pancy in loop iterations makes the safeguard highly reachable.

Pre-existing issues:
- [Critical] `drm_pagemap_migrate_to_devmem` unconditionally casts device p=
rivate pages to `drm_pagemap_zdd` without verifying they belong to `drm_pag=
emap`, leading to type confusion when migrating memory mapped from other dr=
ivers.
- [Critical] On error paths, `drm_pagemap_migrate_to_devmem` leaves raw dev=
ice PFNs uncleared in `migrate.dst`, causing `migrate_vma_pages()` to deref=
erence garbage pointers and panic.
- [Critical] `drm_pagemap_migrate_to_devmem` assumes that `ops->populate_de=
vmem_pfn` returns a contiguous 2MB block when the source page is a THP, lea=
ding to severe memory corruption if the device allocator returns fragmented=
 pages.
- [High] Iterating over `migrate.src` using `folio_order(page_folio(src_pag=
e))` incorrectly skips array elements for PTE-mapped THPs, ignoring partial=
 migration failures and inflating counters.
--

--- Patch [1]: [PATCH] drm/pagemap: Remove unreachable code in drm_pagemap_=
migrate_to_devmem() ---
commit bc70ff651e63ccc5d92c40ccbcee5813a9cda5f6
Author: Lu Yao <yaolu@kylinos.cn>

drm/pagemap: Remove unreachable code in drm_pagemap_migrate_to_devmem()

If it can satisfy the condition of "page_pgmap(src_page) =3D=3D pagemap
&& ! mdetails->can_migrate_same_pagemap", it will be return -EBUSY in
the precondition checks above the loop.

> diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
> index 15c78eca180b7..b2cade168cedc 100644
> --- a/drivers/gpu/drm/drm_pagemap.c
> +++ b/drivers/gpu/drm/drm_pagemap.c
> @@ -744,12 +744,6 @@ int drm_pagemap_migrate_to_devmem(struct drm_pagemap=
_devmem *devmem_allocation,
>  			struct drm_pagemap_zdd *src_zdd =3D
>  				drm_pagemap_page_zone_device_data(src_page);

[Severity: Critical]
This is a pre-existing issue, but does drm_pagemap_migrate_to_devmem() blin=
dly
cast device private pages to drm_pagemap_zdd without verifying they belong =
to
the drm_pagemap subsystem?

If a user maps device private memory from another driver (like Nouveau or
AMDGPU) and attempts to migrate it to a drm_pagemap-backed device, the page
will have a different pgmap->ops and its zone_device_data will point to a
driver-specific structure. Could dereferencing src_zdd->dpagemap then cause=
 a
type confusion, leading to arbitrary memory reads and kernel panics?

> =20
> -			if (page_pgmap(src_page) =3D=3D pagemap &&
> -			    !mdetails->can_migrate_same_pagemap) {
> -				migrate.dst[i] =3D 0;
> -				own_pages++;
> -				goto next;
> -			}

[Severity: High]
Is it safe to remove this safeguard?

The commit message claims this condition is caught in the first loop and
returns -EBUSY. However, the first loop calculates:

nr_pages =3D NR_PAGES(folio_order(page_folio(src_page)))

It then increments i by nr_pages, skipping entries in migrate.src for any
page belonging to a large folio, even if it is PTE-mapped.

This second loop increments i by HPAGE_PMD_ORDER only if
MIGRATE_PFN_COMPOUND is set; otherwise it increments by 1. Because of this
discrepancy, the second loop can iterate over pages that the first loop
completely skipped.

If a skipped page belongs to the same pagemap and
!mdetails->can_migrate_same_pagemap is true, doesn't removing this block
allow unsupported same-pagemap migrations to proceed, potentially causing
hardware state corruption or deadlocks?

[Severity: Critical]
This is a pre-existing issue, but does this loop assume
ops->populate_devmem_pfn returns a contiguous 2MB block when the source
page is a THP?

When MIGRATE_PFN_COMPOUND is set, the code sets order =3D HPAGE_PMD_ORDER
and overwrites migrate.dst[i + 1] through migrate.dst[i + 511] with 0.
It then calls drm_pagemap_get_devmem_page() which forcefully initializes
the next 511 contiguous physical pages as a compound folio.

If the device allocator returns a fragmented list of smaller pages (e.g.,
non-contiguous 4KB blocks), does this blindly initialize subsequent physical
pages, silently corrupting metadata of unrelated device memory and leaking
the non-contiguous device PFNs that were overwritten with 0?

>  			cur.dpagemap =3D src_zdd->dpagemap;
>  			cur.ops =3D src_zdd->devmem_allocation->ops;
>  			cur.device =3D cur.dpagemap->drm->dev;
> @@ -786,7 +780,6 @@ int drm_pagemap_migrate_to_devmem(struct drm_pagemap_=
devmem *devmem_allocation,
>  			goto err_finalize;
>  		}

[Severity: Critical]
This is a pre-existing issue, but does this error path leave raw device
PFNs uncleared in migrate.dst?

If drm_pagemap_migrate_range() fails at index i, the function truncates
the local npages variable to i + 1 and jumps to err_finalize.
drm_pagemap_migration_unlock_put_pages() clears only up to index i,
leaving elements from i + 1 to the original npages - 1 in migrate.dst
populated with raw device PFNs.

When the code falls through to err_aborted_migration and calls
migrate_vma_pages(&migrate), it iterates up to the original unmodified
migrate.npages. Could migrate_vma_pages() then dereference these garbage
pointers (if the raw PFN is odd), leading to a severe use-after-free and
kernel panic?

> =20
> -next:
>  		i +=3D NR_PAGES(order);

[Severity: High]
This is a pre-existing issue, but does iterating over migrate.src using
folio_order(page_folio(src_page)) in the loops incorrectly skip array
elements?

For PTE-mapped THPs, this assumes the next 2^order elements in the array
belong to the same folio, skipping up to 511 elements in the array and
completely missing validation of subsequent pages.

If migrate_vma_pages() fails to migrate one of the skipped pages, won't
the third loop miss this failure and incorrectly tally migrated_pages,
allowing the GPU to access un-migrated pages?

>  	}
> =20
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730061635.1326=
19-1-yaolu@kylinos.cn?part=3D1
