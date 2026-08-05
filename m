Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EF5AC55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 05:29:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C56D10E1A5;
	Wed,  5 Aug 2026 05:29:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UlWPRLmW";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0900510E1A5
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 05:29:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 92BD64168D;
 Wed,  5 Aug 2026 05:29:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 424AB1F000E9;
 Wed,  5 Aug 2026 05:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785907752;
 bh=2njeO35+a6pgtLT6/G79qP2mo8OzuJHZMyGsldPqV2I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UlWPRLmWHF9sdHiWMzLd6DU9pwRFcNiL7XLCHWqLv12BSlBtTNInqeAgkWGiNEcNh
 ylBrXjhK1uh3ozmzc956F91hpe5Pm9sfgsgwTFnY9lnLJQ4JCNae1NGt4vgt1j3IGI
 1XRgVI/YMUUfQctlXj8EqOlb9xPRxy66sprOkzXnlZNR8wN5uu8EJjlKugMEJqechW
 FtUjynOeI259GPvJtfaP+zy8IFT6LnO3XCG/OLZMMAqcLD0NmuHGWXxHwxjLVFYNzl
 /za7o29394dvAxkTV5oiyh2IFN9TGRcalh+5LSon0E9mM8IVq63MOj3yTnB8ThOand
 ejtjDG28JlhPQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/pagemap: Fix folio allocation fallback and
 use-after-put
To: "Matthew Brost" <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260805051744.3481873-1-matthew.brost@intel.com>
References: <20260805051744.3481873-1-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 05:29:11 +0000
Message-Id: <20260805052912.424AB1F000E9@smtp.kernel.org>
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
- [Medium] Unconditional use of __GFP_NOWARN suppresses OOM warnings for or=
der-0 allocations.
--

--- Patch [1]: [PATCH v2] drm/pagemap: Fix folio allocation fallback and us=
e-after-put ---
commit 8cbd3237a69e546db0a488ed740897837ca90e44
Author: Matthew Brost <matthew.brost@intel.com>

drm/pagemap: Fix folio allocation fallback and use-after-put

This commit fixes an issue where higher-order folio allocations lacking
warning suppression would spam the kernel log on failure. It adds a fallback
path to use order-0 allocations for the entire range if the higher-order
allocation fails. It also fixes a use-after-free issue when retrieving the
folio order after the page reference was dropped.

> diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
> index 15c78eca180b7..aeb8ba0017e5f 100644
> --- a/drivers/gpu/drm/drm_pagemap.c
> +++ b/drivers/gpu/drm/drm_pagemap.c
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

[Severity: Medium]
The commit message notes that __GFP_NOWARN is added to the higher-order
allocation, but does this unconditionally apply __GFP_NOWARN even when
order is 0?

If the source page is order-0, the primary allocation in
drm_pagemap_migrate_populate_ram_pfn() will use __GFP_NOWARN. If that
allocation fails, the subsequent fallback block is skipped because its
condition requires a non-zero order.

This means the function will jump directly to the free_pages error path
without logging any OOM warning for the failed order-0 allocation. Since
the fallback order-0 allocations explicitly use GFP_HIGHUSER without
__GFP_NOWARN, should the primary allocation also avoid __GFP_NOWARN when
order is 0?

> +
> +		if (!folio && order) {
> +			/*
> +			 * Higher-order allocation failed, fall back to

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805051744.3481=
873-1-matthew.brost@intel.com?part=3D1
