Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86133C43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 22:03:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED74B10E1A5;
	Fri, 10 Jul 2026 22:03:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lm5sgBW5";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B21F010E1A5
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 22:03:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DD39B60051;
 Fri, 10 Jul 2026 22:03:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69BE11F000E9;
 Fri, 10 Jul 2026 22:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783721016;
 bh=2huPp9FzIed0nf12wOdSf4AEa9xz6+Q6pXaqc7r55Ls=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lm5sgBW5ChsGhtSjlXxpFykDy/uoVs/pjTwyF8yMEOlVbNf+eXOa15MoEOVULhn8P
 aizo5O7mn1V2ctrFlMgvVceml2RKVDwpywtFph9apOBLy+eAYH8ut/Xb2xC4Hb11+W
 +D2WXMuQo/GsqnfthbmjhvTPcQPdGu14O8iLKjwS9kQoscUtQaLwGWh1fgUG+U2s7t
 ZsVT5MqqiOX7M7OFp9B/tGFWpnl2JYMwlp/BZDyx8ThviFIWRyv0UZsvwFf4HkHccl
 CSEM8SiqApSFLPEHC1ZBREwy4yF9ekB5V3CAqJlDlwBa1O20Sn0OZHged9Pntm2OH9
 VH3kBZXrS12WQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/33] drm/ttm: Introduce ttm_pool_alloc_iter for
 __ttm_pool_alloc()
To: "Matthew Brost" <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260710215442.2444235-5-matthew.brost@intel.com>
References: <20260710215442.2444235-1-matthew.brost@intel.com>
 <20260710215442.2444235-5-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 22:03:35 +0000
Message-Id: <20260710220336.69BE11F000E9@smtp.kernel.org>
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
- [High] Calling `__fls()` with 0 causes undefined behavior when an allocat=
ion fulfills the exact remaining pages, potentially causing an infinite loo=
p.
--

--- Patch [4]: [PATCH v2 04/33] drm/ttm: Introduce ttm_pool_alloc_iter for =
__ttm_pool_alloc() ---
commit 5c371f076caffdc9b759a99aaeaf1a30e3ac5dd7
Author: Matthew Brost <matthew.brost@intel.com>

drm/ttm: Introduce ttm_pool_alloc_iter for __ttm_pool_alloc()
   =20
This commit factors the working state of the __ttm_pool_alloc loop into a
struct ttm_pool_alloc_iter. It pulls the per-order page acquisition into=20
smaller helpers to simplify the nested block and improve readability.

> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_poo=
l.c
> index 370d991c9882b..6826c8ae6fc56 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c

[ ... ]

> @@ -819,59 +903,28 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, =
struct ttm_tt *tt,
>  	else
>  		gfp_flags |=3D GFP_HIGHUSER;
> =20
> -	page_caching =3D tt->caching;
> -	allow_pools =3D true;
> -	for (order =3D ttm_pool_alloc_find_order(MAX_PAGE_ORDER, alloc);
> +	it.gfp_flags =3D gfp_flags;
> +
> +	for (it.order =3D ttm_pool_alloc_find_order(MAX_PAGE_ORDER, alloc);
>  	     alloc->remaining_pages;
> -	     order =3D ttm_pool_alloc_find_order(order, alloc)) {
> +	     it.order =3D ttm_pool_alloc_find_order(it.order, alloc)) {

[Severity: High]
This is a pre-existing issue, but does this loop increment expression
evaluate __fls(0) when the allocation exactly fulfills the request?

If the loop successfully allocates the final needed pages during an iterati=
on,
alloc->remaining_pages drops to 0 inside the loop body. The C for-loop
evaluates the increment expression before checking the loop condition, which
calls ttm_pool_alloc_find_order().

Inside ttm_pool_alloc_find_order(), this directly executes:
min_t(unsigned int, highest, __fls(alloc->remaining_pages))

Calling __fls(0) translates to __builtin_clzl(0), which is explicitly
undefined behavior in GCC and Clang.=20

Could this undefined behavior allow the compiler to assume
alloc->remaining_pages is always non-zero because it is passed to __fls,=20
potentially optimizing away the loop termination condition and causing an=20
infinite loop?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710215442.2444=
235-1-matthew.brost@intel.com?part=3D4
