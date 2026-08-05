Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D62AAC55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 04:57:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A6C610E14C;
	Wed,  5 Aug 2026 04:57:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bCFTf1JA";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0589910E14C
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 04:57:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E1306600B1;
 Wed,  5 Aug 2026 04:57:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA521F000E9;
 Wed,  5 Aug 2026 04:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785905828;
 bh=v5n4PPdgPhb9MrvJhJbvNiwkub12R8p6AAChuWEWOd8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bCFTf1JAYi+GUBTNgnFMBrFNy+u8vuhUd+t/a5cQIIQ/Jum7UPtzgAE2Xs4kbbEC/
 i1GglMqe33kVVlir5C2KhL0W6Cgs6bUslJj1vrgYDWoDIrzT+C0wfKjaC8g8azlYK0
 woNIIcIh0O4HNRhkCEjOyNOAl2zke0evnILYbAS6/EmsF8t9gCIZF06phagofvJ/Gk
 t2KAv2jOfQ6yX9JX1o9uOdrIM2yWA8WgPuv7OdKqGPo1dhOE0Ku+bRabMy/I+b5Awn
 PWEUaR9qVi17eaDnpLz6OMnhbYfHcW1LaPBYo8iUwOWNwduP4lkGGjNC3S2ep+FL/J
 Om4XMv4vM5IUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/pagemap: Fix folio allocation fallback and
 use-after-put
To: "Matthew Brost" <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260805044349.3474498-1-matthew.brost@intel.com>
References: <20260805044349.3474498-1-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 04:57:07 +0000
Message-Id: <20260805045708.6EA521F000E9@smtp.kernel.org>
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
- [Critical] The order-0 allocation fallback loop causes a heap buffer over=
flow and memory leaks when migrating a partial THP or when some subpages la=
ck the MIGRATE_PFN_MIGRATE flag.
--

--- Patch [1]: [PATCH] drm/pagemap: Fix folio allocation fallback and use-a=
fter-put ---
commit 0e0b48c51914bc3498ff387aa623528489adafed
Author: Matthew Brost <matthew.brost@intel.com>

drm/pagemap: Fix folio allocation fallback and use-after-put

This commit fixes a missing __GFP_NOWARN in higher-order folio allocations
and implements a fallback to order-0 allocations when THP allocation fails.
It also fixes a use-after-free issue where folio_order() was called after
dropping the page reference.

Cc: stable@vger.kernel.org

> diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
> index 15c78eca180b7..407c7546e168a 100644
> --- a/drivers/gpu/drm/drm_pagemap.c
> +++ b/drivers/gpu/drm/drm_pagemap.c
[ ... ]
> @@ -886,11 +886,34 @@ static int drm_pagemap_migrate_populate_ram_pfn(str=
uct vm_area_struct *vas,
> =20
>  		order =3D folio_order(page_folio(src_page));
> =20
> -		/* TODO: Support fallback to single pages if THP allocation fails */
>  		if (vas)
> -			folio =3D vma_alloc_folio(GFP_HIGHUSER, order, vas, addr);
> +			folio =3D vma_alloc_folio(GFP_HIGHUSER | __GFP_NOWARN, order, vas, ad=
dr);
>  		else
> -			folio =3D folio_alloc(GFP_HIGHUSER, order);
> +			folio =3D folio_alloc(GFP_HIGHUSER | __GFP_NOWARN, order);
> +
> +		if (!folio && order) {
> +			/*
> +			 * Higher-order allocation failed, fall back to
> +			 * order-0 allocations for the entire range covered
> +			 * by the original higher-order allocation, without
> +			 * setting MIGRATE_PFN_COMPOUND, until we move past
> +			 * that range.
> +			 */
> +			unsigned long nr =3D NR_PAGES(order);
> +			unsigned long j;
> +
> +			for (j =3D 0; j < nr; j++, i++, addr +=3D PAGE_SIZE) {
> +				folio =3D vas ?
> +					vma_alloc_folio(GFP_HIGHUSER, 0, vas, addr) :
> +					folio_alloc(GFP_HIGHUSER, 0);
> +				if (!folio)
> +					goto free_pages;
> +
> +				page =3D folio_page(folio, 0);
> +				mpfn[i] =3D migrate_pfn(page_to_pfn(page));

[Severity: Critical]
Can this fallback loop write past the end of the mpfn array?

If the migration request only covers a partial THP, or if we are near the
end of the npages limit, nr could be larger than the remaining entries=20
(npages - i). Since this loop unconditionally increments i and writes to=20
mpfn[i] nr times, it appears it could cause a heap buffer overflow.

Additionally, this loop doesn't check if the subpages have the
MIGRATE_PFN_MIGRATE flag set in src_mpfn. Can this cause memory leaks if we
allocate and assign order-0 folios for subpages that weren't actually
requested for migration and thus might not be cleaned up later?

> +			}
> +			continue;
> +		}
> =20
>  		if (!folio)
>  			goto free_pages;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805044349.3474=
498-1-matthew.brost@intel.com?part=3D1
