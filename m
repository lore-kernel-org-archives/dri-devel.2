Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83C36C43458
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 03:12:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E46A010E54B;
	Sat, 11 Jul 2026 03:12:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Wg5M+f+h";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3080010E54B
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 03:12:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8EDF160051;
 Sat, 11 Jul 2026 03:12:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B74E1F000E9;
 Sat, 11 Jul 2026 03:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783739529;
 bh=wa8hr/G+ntGTx+pbf6WTAwBD10PQK6BQu7AsPuQdJyQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Wg5M+f+hnXNegk2N7ugvGw+MUT/KgPR1vDY7ub7r2SrIKZkuT2+ItRiktrsle6OIR
 w5oo//75iED5X00XNdLth0mzpK/8zRMKDWn9OXcLCAw8FRWAc7YcOjWgBox5mcW+BV
 H9yDDf+YjZ8LnG38JmYSBx+JByb2kElaxkR/Wg8JU7kbGEO6cLEve/V0JVatedSbWw
 43wl3q4TMTglhehr0d0pm+Tm/d4xtyDNXx3qmaWPr/5Uu79TlBLZLHMmAqaMoBYZeB
 943cXJPBentt/FAp5fdGwnTrHjs5kUtjyDICEtUVsRsK+oG8/9vewhKcOJYHjpelbQ
 L7F5jHZbrm04Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/33] drm/ttm: Bound page (re)allocation per
 defragmentation move
To: "Matthew Brost" <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260711025619.2540575-9-matthew.brost@intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-9-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 03:12:08 +0000
Message-Id: <20260711031209.1B74E1F000E9@smtp.kernel.org>
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
- [Medium] Negative defrag budget values are incorrectly treated as unlimit=
ed instead of exhausted.
--

--- Patch [8]: [PATCH v3 08/33] drm/ttm: Bound page (re)allocation per defr=
agmentation move ---
commit 933e390472c0331c941d5caa6b241841ec7bb236
Author: Matthew Brost <matthew.brost@intel.com>

drm/ttm: Bound page (re)allocation per defragmentation move

This commit introduces a per-move byte budget to bound the reallocation
size during TTM object defragmentation. It updates the pool allocator to
track upgraded pages against this budget, stopping the upgrade process and
harvesting the remaining old pages once the budget is exhausted.

> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_poo=
l.c
> index 52f5e64f05ddc..1673e81b8df81 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c

[ ... ]

> @@ -1121,10 +1187,23 @@ static int __ttm_pool_alloc(struct ttm_pool *pool=
, struct ttm_tt *tt,
>  		gfp_flags |=3D GFP_HIGHUSER;
> =20
>  	it.gfp_flags =3D gfp_flags;
> +	it.defrag_capped =3D it.defrag_old_tt && alloc->defrag_bytes_remaining =
> 0;

[Severity: Medium]
Does this initialization correctly handle negative budget values?

If a caller uses the same ttm_operation_ctx for multiple defragmentation
moves, the first move that overshoots the budget can leave
defrag_bytes_remaining as a negative value.

When this negative value is passed to the next __ttm_pool_alloc() call,
the alloc->defrag_bytes_remaining > 0 check evaluates to false.

Will this disable the cap entirely (defrag_capped =3D false) and cause the
allocator to perform an unlimited upgrade, potentially reintroducing the
unbounded stall this budget was designed to prevent? Should this condition
be !=3D 0 instead to properly enforce negative or exhausted budgets?

>  	for (it.order =3D ttm_pool_alloc_find_order(MAX_PAGE_ORDER, alloc);
>  	     alloc->remaining_pages;
>  	     it.order =3D ttm_pool_alloc_find_order(it.order, alloc)) {

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260711025619.2540=
575-1-matthew.brost@intel.com?part=3D8
