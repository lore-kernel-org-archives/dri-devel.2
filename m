Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11B98C55ABF
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 12:13:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52F5710F1C0;
	Thu,  6 Aug 2026 12:13:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SNe8YuTU";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A17010F1C4
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 12:13:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B5C5E41999;
 Thu,  6 Aug 2026 12:13:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 786C11F000E9;
 Thu,  6 Aug 2026 12:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786018401;
 bh=EjMI3UHGIC5wlFS4zPClDkPESGfoKQnQ2ovqZyq7ERQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SNe8YuTUaXQKq9wnZcApF/nzGiaqPadtQpgzzdz3vs3gh0k+8tmj0E8LOMIl9XaOV
 /lQ2ktW9Qts6YchHVJTWSOb7Vu5HD/R4DrRBoEdLlXwkMaSN2w8szl9UWk4VRUTyX1
 dB9rDLFK118rwvwMW4xVGHRzgMH6N1t5nj7zk7xO5zQ38/gW0CRDeBhx7cJmEUvVCd
 /BW+wuzCYOBPwkURqUYE6FiMSyL5DlJXXM3aidfiSFjy5mfX84UDxqMAAheSJxrqnw
 xjFtpRoBFYdwNB6K5Z/zQutAA4UHqFM2NHHx621aATZvckxkoacI5h6buWA78JtgiM
 5qdrnxXYZ9eIA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/pagemap: no need to recheck own pagemap in
 migrate_to_devmem
To: "Zhaoyu Liu" <liuzhaoyu.zackary@picoheart.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <anR3ksBglj78TJgp@hostpc>
References: <anR3ksBglj78TJgp@hostpc>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 12:13:21 +0000
Message-Id: <20260806121321.786C11F000E9@smtp.kernel.org>
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
- [High] The patch breaks the fast path when all pages are already on the t=
arget pagemap, causing valid no-op migrations to incorrectly fail with `-EB=
USY` instead of returning success (0).

Pre-existing issues:
- [Critical] On the error path of `drm_pagemap_migrate_range`, raw physical=
 frame numbers (PFNs) are left in `migrate.dst` and mistakenly interpreted =
as formatted `mpfn`s by `migrate_vma_pages()`, leading to memory corruption=
 and mapping uninitialized device memory.
- [High] The first and final migration loops incorrectly use `folio_order(p=
age_folio())` to determine the array iteration step, causing them to skip v=
alid entries in `migrate.src` when processing PTE-mapped Transparent Huge P=
ages (THPs).
--

--- Patch [1]: [PATCH] drm/pagemap: no need to recheck own pagemap in migra=
te_to_devmem ---
commit b14c2718135459228d814edbd8f0bdc7589c21d9
Author: Zhaoyu Liu <liuzhaoyu.zackary@picoheart.com>

drm/pagemap: no need to recheck own pagemap in migrate_to_devmem

This patch removes the own_pages count and the re-check for the source page
being on the same pagemap inside the migration loop. It also removes the
subtraction of own_pages from the final validation check.

> diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
> index 15c78eca180b7..6842eadee6df9 100644
> --- a/drivers/gpu/drm/drm_pagemap.c
> +++ b/drivers/gpu/drm/drm_pagemap.c

[ ... ]

> @@ -786,7 +779,6 @@ int drm_pagemap_migrate_to_devmem(struct drm_pagemap_=
devmem *devmem_allocation,
>  			goto err_finalize;
            ^^^^^^^^^^^^^^^^^^

[Severity: Critical]
This is a pre-existing issue, but does this error path cause memory
corruption?

If drm_pagemap_migrate_range() fails in the second loop, the local npages
variable is truncated (npages =3D i + 1) right before this goto, but
migrate.npages remains unchanged.

When migrate_vma_pages(&migrate) is called on the error path, it will
iterate over all original entries. For entries beyond the truncated npages,
migrate.dst still contains the raw PFNs populated earlier by
ops->populate_devmem_pfn().

If a raw PFN is odd, migrate_vma_pages() misinterprets the set bit 0 as
MIGRATE_PFN_VALID, shifts the raw PFN right by MIGRATE_PFN_SHIFT (6), and
uses the resulting random page pointer, which could cause severe memory
corruption.

>  		}
> =20
> -next:
>  		i +=3D NR_PAGES(order);
>  	}

[ ... ]

> @@ -822,7 +812,7 @@ int drm_pagemap_migrate_to_devmem(struct drm_pagemap_=
devmem *devmem_allocation,
>  		i +=3D nr_pages;
          ^^^^^^^^^^^^

[Severity: High]
This is a pre-existing issue, but does using folio order here incorrectly
skip entries in migrate.src for PTE-mapped Transparent Huge Pages?

Because MIGRATE_PFN_COMPOUND is not set for PTE-mapped THPs, the second
migration loop correctly increments by 1. However, this final loop and the
first counting loop use folio_order(page_folio(page)), which will increment
by the folio order (e.g., 512).

This inconsistency skips over the remaining 511 PTE entries in migrate.src,
inflating migrated_pages and masking migration failures. Userspace could
receive a success code even if some subpage migrations actually failed.

>  	}
> =20
> -	if (!err && migrated_pages < npages - own_pages) {
> +	if (!err && migrated_pages < npages) {
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
Does this change break the fast path when all pages are already on the
target pagemap?

If a migration is requested for a range where all device-private pages are
already on the target pagemap, the earlier check (own_pages =3D=3D npages) =
sets
err =3D 0 and jumps to err_aborted_migration.

Before this patch, migrated_pages (0) was not less than (npages - own_pages)
because own_pages was equal to npages, so the function successfully
returned 0.

With the patch removing `- own_pages`, the check evaluates to `0 < npages`
(which is true), so the fast path will now falsely abort with -EBUSY and
log "Raced while finalizing migration."

>  		drm_dbg(dpagemap->drm, "Raced while finalizing migration.\n");
>  		err =3D -EBUSY;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/anR3ksBglj78TJgp@ho=
stpc?part=3D1
