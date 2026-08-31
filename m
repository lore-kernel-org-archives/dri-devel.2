Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB904C61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 06:21:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3523E10E619;
	Mon, 31 Aug 2026 06:21:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LnjaowFl";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 612C710E619
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 06:21:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7E2D660120;
 Mon, 31 Aug 2026 06:21:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 086F61F000E9;
 Mon, 31 Aug 2026 06:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788157295;
 bh=RlRg9DUVLq6QH7dhsBg5uiGJPWSMNBplekIsCSXRQlc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LnjaowFlEvJ2X8868tZAEP69K99fAvynfnf2vkpNHTEBE+dzCy4TQAVnrPURGLeO/
 VN5ZpZHsq/akj8DqAbhqFWr0ZQNpVMwu+9RnS1LUDX0cfnlLRZP6WhKjDDcA+5beRW
 Zas3k52dRKG+sLSLlwa57NusL9EQ7fTtITCRRssdUeQSIUClFD+XdU5q6JGB8avZ4r
 C/CE62qxb8/PC6xNsxc1+cJpzka/MDsGUqgGUudT2sm3ttpzlBO0TOXQ93O5IRg9lM
 t3LraXj6QGvl/wLUjIqKOhbkclwhNGEjyOnWkC6gCYgYbfAl0fBHUXbsbF8x/PlnNb
 uXrRxz3gJRUkQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/pagemap: fix page undercount for compound src
 entries
To: "Junhua Shen" <Junhua.Shen@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831060743.70024-1-Junhua.Shen@amd.com>
References: <20260828083652.40855-1-Junhua.Shen@amd.com>
 <20260831060743.70024-1-Junhua.Shen@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 06:21:34 +0000
Message-Id: <20260831062135.086F61F000E9@smtp.kernel.org>
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
- [High] drm_pagemap_src_pfn_nr_pages relies on folio_order for valid pages=
, causing severe overcounting and skipped entries for PTE-mapped THPs, whic=
h masks migration failures.
--

commit bb0a5adb569e2e78382923dc4aeb9bb445b55021
Author: Junhua Shen <Junhua.Shen@amd.com>

drm/pagemap: fix page undercount for compound src entries

This commit factors out the page count decoding into a new helper function,=
=20
drm_pagemap_src_pfn_nr_pages(), to consistently handle compound source entr=
ies.=20
It ensures that entries with only MIGRATE_PFN_COMPOUND are correctly counte=
d=20
as HPAGE_PMD_NR base pages in both accounting loops of=20
drm_pagemap_migrate_to_devmem(). This prevents a potential spurious -EBUSY=
=20
in the final migration race check due to undercounting.

> diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
> index 892b325fa99b8..a31cc4f0af68c 100644
> --- a/drivers/gpu/drm/drm_pagemap.c
> +++ b/drivers/gpu/drm/drm_pagemap.c

[ ... ]

> @@ -554,6 +554,37 @@ static int drm_pagemap_migrate_range(struct drm_page=
map_devmem *devmem,
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
This is a pre-existing issue, but by factoring out this logic, the helper
perpetuates a flaw for PTE-mapped large folios (THPs). For a valid page
that is part of a PTE-mapped THP, this derives the step size from the folio
order rather than the migration entry flags.

Since migrate_vma tracks PTE-mapped THPs as independent order-0 entries
(each with MIGRATE_PFN_VALID but not MIGRATE_PFN_COMPOUND), will returning
the full large folio size here cause severe overcounting for these entries?

> +	} else if (src_pfn & MIGRATE_PFN_COMPOUND) {
> +		nr_pages =3D HPAGE_PMD_NR;
> +	}
> +
> +	if (src_page)
> +		*src_page =3D page;
> +
> +	return nr_pages;
> +}

[ ... ]

> @@ -818,10 +844,10 @@ int drm_pagemap_migrate_to_devmem(struct drm_pagema=
p_devmem *devmem_allocation,
>  	migrate_vma_pages(&migrate);
> =20
>  	for (i =3D 0; !err && i < npages;) {
> -		struct page *page =3D migrate_pfn_to_page(migrate.src[i]);
> -		unsigned long nr_pages =3D page ? NR_PAGES(folio_order(page_folio(page=
))) : 1;
> +		unsigned long src_pfn =3D migrate.src[i];
> +		unsigned long nr_pages =3D drm_pagemap_src_pfn_nr_pages(src_pfn, NULL);
> =20
> -		if (migrate.src[i] & MIGRATE_PFN_MIGRATE)
> +		if (src_pfn & MIGRATE_PFN_MIGRATE)
>  			migrated_pages +=3D nr_pages;
> =20
>  		i +=3D nr_pages;

[Severity: High]
This isn't a bug introduced by this patch, but because
drm_pagemap_src_pfn_nr_pages() returns the full folio order for PTE-mapped
THPs, won't this final verification loop in drm_pagemap_migrate_to_devmem()
step by 512 instead of 1?

If it steps by 512 for a PTE-mapped THP, it skips checking the
MIGRATE_PFN_MIGRATE flag for the remaining independent tail pages. If any
tail page failed to migrate, does this silently mask the migration failure
and falsely report complete success, risking data corruption and permanently
desynchronized CPU/GPU page tables?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831060743.7002=
4-1-Junhua.Shen@amd.com?part=3D1
