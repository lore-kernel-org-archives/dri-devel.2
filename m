Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C73DC5AC7C
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 06:40:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96C0110E05D;
	Fri,  7 Aug 2026 06:40:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GJtXIqmx";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD1DC10E05D
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 06:39:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 80C0E410A7;
 Fri,  7 Aug 2026 06:39:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A5071F000E9;
 Fri,  7 Aug 2026 06:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786084799;
 bh=vn4/HY34D8Z3Ny+dhzTOHaleLtd/HYsGig27F3K6fhU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GJtXIqmx6axRtApjoVkAadKGK/4YQGUrQ+NAP15CSnXpVTGZMeZ1+kfAfmVh4Vh/s
 JdgzAC5HCliU0y9df2P5PpA8KEegW0nJO3ZzSjUTAgxxphhPBsbw1ZukGUgS2VEuco
 JB1lbJ1X9czfNqiPnaRhtNQjqjrVTgugduK6qkGNoBDNBx1Qei1jsGS/17u/MlMwmX
 FTASR2EbmVz/wu3FDUU/HEo3iYgb1yLhZbL7wf5KaMoHKx9B5G60lmRddK5AKwLfhP
 puapm9U1OZkmsuEa9I92I+dCXVdYv1Sr6Gx6BtPiW0O6NOUGVQ/Feq8UUPVgibMXU6
 0xIExqGIz5Jtg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] drm/pagemap: Prevent double migration of device pages
To: "Arvind Yadav" <arvind.yadav@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260807062627.2094357-1-arvind.yadav@intel.com>
References: <20260807062627.2094357-1-arvind.yadav@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 06:39:58 +0000
Message-Id: <20260807063959.3A5071F000E9@smtp.kernel.org>
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
- [High] Incorrect PFN array iteration skips unrelated folios when encounte=
ring tail pages.
--

--- Patch [1]: [PATCH v3] drm/pagemap: Prevent double migration of device p=
ages ---
commit 8b99d73a2bacb652ddc2b438316d6f18c0ebfb5e
Author: Arvind Yadav <arvind.yadav@intel.com>

drm/pagemap: Prevent double migration of device pages

A device-private folio migrated to system memory by a CPU fault can
remain reachable through the raw-PFN eviction path until migration
finalization drops the source reference.

> diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
> --- a/drivers/gpu/drm/drm_pagemap.c
> +++ b/drivers/gpu/drm/drm_pagemap.c
[ ... ]
> +static void drm_pagemap_retire_migrated_pages(unsigned long *src_pfns,
> +					      unsigned long npages)
> +{
> +	unsigned long i =3D 0;
> +
> +	while (i < npages) {
> +		struct page *page =3D migrate_pfn_to_page(src_pfns[i]);
> +		unsigned long nr =3D 1;
> +
> +		if (!page) {
> +			i++;
> +			continue;
> +		}
> +
> +		nr =3D folio_nr_pages(page_folio(page));
> +
> +		if ((src_pfns[i] & MIGRATE_PFN_MIGRATE) &&
> +		    is_device_private_page(page))
> +			drm_pagemap_page_set_flags(page,
> +						   DRM_PAGEMAP_ZDD_FLAG_MIGRATED);
> +
> +		i +=3D nr;

[Severity: High]
Does this iteration correctly handle tail pages? If src_pfns[i] points to a
tail page of a large folio (for instance, when a migration batch starts in
the middle of a large device-private folio due to unaligned VMA boundaries
or partial unmaps), folio_nr_pages() returns the total number of pages in
the entire large folio.

Advancing the array index by i +=3D nr will overshoot the remaining pages in
the array, skipping subsequent unrelated folios. This could prevent the
DRM_PAGEMAP_ZDD_FLAG_MIGRATED flag from being set on the skipped folios,
leaving them vulnerable to the exact double-migration soft lockups and RCU
stalls this patch aims to fix.

> +	}
> +}
> +
> +static void drm_pagemap_skip_retired_pages(unsigned long *src_pfns,
> +					   unsigned long npages)
> +{
> +	unsigned long i =3D 0;
> +
> +	while (i < npages) {
> +		struct page *page =3D migrate_pfn_to_page(src_pfns[i]);
> +		unsigned long nr =3D 1;
> +
> +		if (!page) {
> +			i++;
> +			continue;
> +		}
> +
> +		nr =3D folio_nr_pages(page_folio(page));
> +
> +		if ((src_pfns[i] & MIGRATE_PFN_MIGRATE) &&
> +		    is_device_private_page(page) &&
> +		    (drm_pagemap_page_get_flags(page) &
> +		     DRM_PAGEMAP_ZDD_FLAG_MIGRATED))
> +			src_pfns[i] &=3D ~MIGRATE_PFN_MIGRATE;
> +
> +		i +=3D nr;

[Severity: High]
Can this loop also skip unrelated folios if the current page is a tail
page? Using folio_nr_pages() to advance the array index from a tail page
has the same overshoot issue as above, potentially failing to clear the
MIGRATE_PFN_MIGRATE bit for migrated folios and leading to a
double-migration attempt.

> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807062627.2094=
357-1-arvind.yadav@intel.com?part=3D1
