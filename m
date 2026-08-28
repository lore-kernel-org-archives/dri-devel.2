Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D6A6C61DC6
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 08:49:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C81210F2EF;
	Fri, 28 Aug 2026 08:48:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Oi7MNMj4";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4F1610F2E9
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 08:48:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2C31560213;
 Fri, 28 Aug 2026 08:48:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B417B1F000E9;
 Fri, 28 Aug 2026 08:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787906932;
 bh=Y+1iZhjPLeD65gsIYaD1Vu9TDKgpZClC0hbm6l284b4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Oi7MNMj4TKI0xKEBT9fhO4hzZFpQSPJCE6dFqzNJVrgVQ4g91vtMtrQIebNetSnXr
 p3cKHHgQwuVdduT6D3QRkmg4UWqZ1guG+d+Lx0am2BoedMaBvAT3HTNueTPY+gFwN6
 gRLLLsykcm6G1eTyLiW3hLV9XNJBVzx5kRKP4g42pfVzy480DcwNab0rdkMETIgTf0
 8a+k9GaHHZfs+q2UO1zK0H6wMBVL+gewAU68sHC6+rswJdEGCr1Y1me4uBUvG8IBPl
 UKeNzHPJkd45tEL+gscqz3WqWdfU1Xd5221WwUjLX+g0YCjbcjcuLbttmjHXOMhidH
 4r7KpgUgQ2+0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/pagemap: centralize migrate src base-page counting
To: "Junhua Shen" <Junhua.Shen@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260828083652.40855-1-Junhua.Shen@amd.com>
References: <20260828083652.40855-1-Junhua.Shen@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 08:48:52 +0000
Message-Id: <20260828084852.B417B1F000E9@smtp.kernel.org>
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
- [High] Incorrect base-page count calculation for large folios desynchroni=
zes migration loops and skips valid entries.
- [High] Permanent device memory leak on migration error path.
--

commit f9a15fc79a089e7970a0abb86569d6cf4a696964
Author: Junhua Shen <Junhua.Shen@amd.com>

drm/pagemap: centralize migrate src base-page counting

This commit factors out the base-page count calculation for migrate.src
entries into a new drm_pagemap_src_pfn_nr_pages function. It applies this
new helper to the accounting loops to consistently handle compound pages.

> diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
> index 892b325fa99b8..a31cc4f0af68c 100644
> --- a/drivers/gpu/drm/drm_pagemap.c
> +++ b/drivers/gpu/drm/drm_pagemap.c
> @@ -554,6 +554,37 @@ static int drm_pagemap_migrate_range(struct drm_page=
map_devmem *devmem,
[ ... ]
> +static unsigned long drm_pagemap_src_pfn_nr_pages(unsigned long src_pfn,
> +						   struct page **src_page)
> +{
> +	struct page *page =3D NULL;
> +	unsigned long nr_pages =3D 1;
> +
> +	if (src_pfn & MIGRATE_PFN_VALID) {
> +		page =3D migrate_pfn_to_page(src_pfn);
> +		if (page)
> +			nr_pages =3D NR_PAGES(folio_order(page_folio(page)));

[Severity: High]
This is a pre-existing issue, but does computing the stride using the backi=
ng
folio's size skip independent PTE entries? If a VMA maps a transparent huge
page (THP) via PTEs, migrate_vma_setup produces individual base-page entrie=
s.
However, using folio_order(page_folio(page)) returns the full compound order
(e.g., 512). The loops incrementing by this value would then skip the next
511 valid entries in the migrate.src array.

[Severity: High]
This is also a pre-existing issue related to the above, but does this create
a desync between the migration steps?=20

In the central loop in drivers/gpu/drm/drm_pagemap.c:drm_pagemap_migrate_to=
_devmem():

	for (i =3D 0; i < npages;) {
		unsigned int order =3D 0;
		...
		if (migrate.src[i] & MIGRATE_PFN_COMPOUND) {
			order =3D HPAGE_PMD_ORDER;
			...
		}
		...
		i +=3D NR_PAGES(order);
	}

Because order is 0 for PTE-mapped THPs here (MIGRATE_PFN_COMPOUND is false),
this central loop correctly strides by 1. However, the accounting loops that
use the new drm_pagemap_src_pfn_nr_pages() helper will stride by the full
folio size. Will this result in device pages being allocated and processed
here, but skipped in the accounting phases?

[Severity: High]
There is another pre-existing issue on the migration error path. Does
truncating npages cause device pages to be permanently leaked?=20

drivers/gpu/drm/drm_pagemap.c:drm_pagemap_migrate_to_devmem() {
	...
	err =3D ops->populate_devmem_pfn(devmem_allocation, npages, migrate.dst);
	...
	for (i =3D 0; i < npages;) {
		...
		err =3D drm_pagemap_migrate_range(...);
		if (err) {
			npages =3D i + 1;
			goto err_finalize;
		}
		...
	}
	...
err_finalize:
	if (err) {
		drm_pagemap_migration_unlock_put_pages(npages, migrate.dst);
		for (i =3D npages; i < npages_in_range(start, end); ++i)
			migrate.dst[i] =3D 0;
	}
	...
}

When drm_pagemap_migrate_range() fails, npages is truncated. The cleanup
code in err_finalize then only handles pages up to this truncated index.
The loop clearing migrate.dst[i] =3D 0 wipes the only references to the
remaining device pages originally allocated by ops->populate_devmem_pfn(),
ensuring they can never be freed. Could we avoid this by unlocking only
the processed pages while still freeing the remaining unprocessed device
pages?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828083652.4085=
5-1-Junhua.Shen@amd.com?part=3D1
