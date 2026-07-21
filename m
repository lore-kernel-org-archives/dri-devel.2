Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E601C44529
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 10:56:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F086110E323;
	Tue, 21 Jul 2026 10:56:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TRhXmFQD";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44D0010E323
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 10:56:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B39424116D;
 Tue, 21 Jul 2026 10:56:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C9541F000E9;
 Tue, 21 Jul 2026 10:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784631406;
 bh=c25DPx8ez4O1LbDq2tJ8pbPBjShImL+R9kvzr9EqUiI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TRhXmFQDF15trmEKEFteMRX1beeAHS8hPFuyUm5PUsTGb1yWuXk3kmhWVI3Dve3xJ
 73DpLKw9D3pi/CbZ/Dkcgi0KLlXC158QgvheBovD2tGYQQUPQBwoiHma6nUdTMSBJF
 07eZUiq6HVHvyz3nX4jd7W8sitbx6yvso2WGzJNone1F2VY+LxkSCzIZykdK7MLMKn
 RRT9+l+GFwleFUpqZJ6mbgRMXoBzhnrDd0B/6ik4IorbkHp295txi7Tcm5PEtoqcre
 ozxb64yOd7XXyUFWqPbGNbyhlZGAAQ/4LZe9E4AjwMQeqrMg/+Rx8Ew7kqC0XC2iPy
 TPlZM8ku/mPmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/pagemap: Guard HPAGE_PMD_ORDER use with
 CONFIG_ARCH_ENABLE_THP_MIGRATION
To: "Jan Stancek" <jstancek@redhat.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <84a35e16f72330d6e7b2d6e969040f36959e2dad.1784630290.git.jstancek@redhat.com>
References: <202607201914.LpAGsbXs-lkp@intel.com>
 <84a35e16f72330d6e7b2d6e969040f36959e2dad.1784630290.git.jstancek@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 10:56:45 +0000
Message-Id: <20260721105646.6C9541F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Aborting a migration mid-loop leaves raw device PFNs in the mi=
gration array, causing a bogus pointer dereference and kernel panic in migr=
ate_vma_pages().
--

--- Patch [1]: [PATCH] drm/pagemap: Guard HPAGE_PMD_ORDER use with CONFIG_A=
RCH_ENABLE_THP_MIGRATION ---
commit 66a306e51148532e3b7d883d3232632355c05797
Author: Jan Stancek <jstancek@redhat.com>

drm/pagemap: Guard HPAGE_PMD_ORDER use with CONFIG_ARCH_ENABLE_THP_MIGRATION

This commit fixes a compile error when both CONFIG_TRANSPARENT_HUGEPAGE
and CONFIG_HUGETLB_PAGE are disabled. It guards HPAGE_PMD_ORDER uses with
CONFIG_ARCH_ENABLE_THP_MIGRATION.

Link: https://lore.kernel.org/r/202607201914.LpAGsbXs-lkp@intel.com/

> diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
> index 15c78eca180b7..53a78752c8be3 100644
> --- a/drivers/gpu/drm/drm_pagemap.c
> +++ b/drivers/gpu/drm/drm_pagemap.c
[ ... ]
> @@ -763,7 +765,10 @@ int drm_pagemap_migrate_to_devmem(struct drm_pagemap=
_devmem *devmem_allocation,
>  		}
>  		migrate.dst[i] =3D migrate_pfn(migrate.dst[i]);
> =20
> +#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
>  		if (migrate.src[i] & MIGRATE_PFN_COMPOUND) {
> +			unsigned long j;
> +
>  			drm_WARN_ONCE(dpagemap->drm, src_page &&
>  				      folio_order(page_folio(src_page)) !=3D HPAGE_PMD_ORDER,
>  				      "Unexpected folio order\n");
> @@ -774,6 +779,7 @@ int drm_pagemap_migrate_to_devmem(struct drm_pagemap_=
devmem *devmem_allocation,
>  			for (j =3D 1; j < NR_PAGES(order) && i + j < npages; j++)
>  				migrate.dst[i + j] =3D 0;
>  		}
> +#endif
> =20
>  		drm_pagemap_get_devmem_page(page, order, zdd);

[Severity: Critical]
This is a pre-existing issue, but can the error path here leave raw device
PFNs in the migration array, causing a bogus pointer dereference in
migrate_vma_pages()?

In drm_pagemap_migrate_to_devmem(), ops->populate_devmem_pfn() populates
migrate.dst with sequential raw device PFNs. The loop processes these and
converts them into the migrate_pfn() format. If a migration batch fails
mid-loop:

		err =3D drm_pagemap_migrate_range(...);
		if (err) {
			npages =3D i + 1;
			goto err_finalize;
		}

The error path zeros out migrate.dst entries up to index i, and then
falls through to err_aborted_migration:

err_finalize:
	if (err)
		drm_pagemap_migration_unlock_put_pages(npages, migrate.dst);
err_aborted_migration:
	migrate_vma_pages(&migrate);

Because migrate_vma_pages() iterates up to the original migrate.npages,
unprocessed entries (where index > i) still contain unformatted raw PFNs.
Since PFNs are sequential, half of them are odd numbers, meaning bit 0
(MIGRATE_PFN_VALID) is set.

Will __migrate_device_pages() misinterpret these odd raw PFNs as valid
migration entries, leading to a dereference of a completely bogus
struct page pointer when it calls pfn_to_page()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/84a35e16f72330d6e7b=
2d6e969040f36959e2dad.1784630290.git.jstancek@redhat.com?part=3D1
