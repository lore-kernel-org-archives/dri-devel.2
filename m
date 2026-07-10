Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0CFAC43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 22:17:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 216C910F93B;
	Fri, 10 Jul 2026 22:17:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ncjBBwnp";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5674010F93B
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 22:17:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A8B6760052;
 Fri, 10 Jul 2026 22:17:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FB981F000E9;
 Fri, 10 Jul 2026 22:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783721863;
 bh=9mIhqJTL8UOWVtZmXBw/USVV5YYL9K4Jbzdv/hW9BFQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ncjBBwnpZlWC12Wky9GuYUUYuqfMprcP3ybPDo2uzEgiaypxhArNQbAO8H9ntYpdy
 zClb4C/S8LyRIvv0Al6cBrJdJ4B9VR00fo9qDZO+PbVNm/AcvnNn1a9k2X1zTexlIe
 vEJUCZb+I2FpU8sgHNkoUYcjA48a/wbs5AShffuzy0DvBkolKy7o4+dot+ZF7T8BfB
 tjS+QuuiJXmorvypva6RjuvsSLqhplesbbX+jRff4C8zdOQsDYEVhHsp+8c28V50u2
 fn1XOS6XZ97Zdr6wcw9gUAQIbS8q5+IbJcf349MSYP0PpHKPNfFrEBaildeshqOkAB
 qMMPsrRy2AE4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/33] drm/ttm: Bound page (re)allocation per
 defragmentation move
To: "Matthew Brost" <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260710215442.2444235-9-matthew.brost@intel.com>
References: <20260710215442.2444235-1-matthew.brost@intel.com>
 <20260710215442.2444235-9-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 22:17:42 +0000
Message-Id: <20260710221743.3FB981F000E9@smtp.kernel.org>
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
- [Critical] `ttm_pool_harvest_remaining()` fetches uninitialized `page->pr=
ivate` on tail pages when the defragmentation budget is exhausted, causing =
a NULL pointer dereference or buddy allocator corruption.
- [Critical] Double-free and Undefined Behavior in `ttm_tt_defrag_disown_bo=
rrowed()` when defragmenting pools that use `dma_alloc`.
- [Medium] Negative `defrag_bytes_remaining` disables the defragmentation b=
udget instead of treating it as exhausted, breaking batch budget tracking.
--

--- Patch [8]: [PATCH v2 08/33] drm/ttm: Bound page (re)allocation per defr=
agmentation move ---
commit 9447c53b431957799260b5fae41a105a050c3394
Author: Matthew Brost <matthew.brost@intel.com>
Subject: drm/ttm: Bound page (re)allocation per defragmentation move

This commit bounds page reallocations per defragmentation move to avoid
stalling concurrent work for unbounded stretches when dealing with very lar=
ge
objects. It introduces an optional per-move byte budget to allow a large
object to be upgraded in slices across successive moves.

> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_poo=
l.c
> index 5d2bbcce4eb89..a6847a16c47f1 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
[ ... ]
> @@ -885,14 +892,33 @@ static int ttm_pool_harvest_page(struct ttm_tt *old=
_tt, unsigned int order,
> =20
>  static int ttm_pool_harvest_remaining(struct ttm_pool *pool,
>  				      struct ttm_tt *old_tt, pgoff_t off,
> -				      struct ttm_pool_alloc_state *alloc)
> +				      struct ttm_pool_alloc_state *alloc,
> +				      bool *suboptimal)
>  {
> +	unsigned int beneficial =3D ttm_pool_beneficial_order(pool);
> +	pgoff_t bnr =3D 1UL << beneficial;
> +
>  	while (alloc->remaining_pages) {
>  		struct page *p =3D old_tt->pages[off];
>  		unsigned int order =3D ttm_pool_page_order(pool, p);

[Severity: Critical]
Does this code safely handle the case where off falls inside a multi-page
chunk rather than exactly on a chunk head?

During defragmentation, new_tt allocates chunks independently of old_tt's
chunk boundaries. When the budget is exhausted, ttm_pool_harvest_remaining()
is called with an off that may land on a tail page.

If this fetches a tail page, ttm_pool_page_order() will read its uninitiali=
zed
private field. For DMA pools, this uninitialized private field is cast to a
struct ttm_pool_dma pointer and dereferenced, causing a kernel panic. For
non-DMA pools, it evaluates to order 0, corrupting the chunk boundaries and
potentially leading to a double-free.

>  		pgoff_t nr =3D 1UL << order;
[ ... ]
> @@ -1106,10 +1172,23 @@ static int __ttm_pool_alloc(struct ttm_pool *pool=
, struct ttm_tt *tt,
>  		gfp_flags |=3D GFP_HIGHUSER;
> =20
>  	it.gfp_flags =3D gfp_flags;
> +	it.defrag_capped =3D it.defrag_old_tt && alloc->defrag_bytes_remaining =
> 0;

[Severity: Medium]
Will this properly cap the allocation if the budget is overdrawn and becomes
negative?

When the allocator decrements defrag_bytes_remaining by the size of the new=
ly
allocated chunks, a chunk can exceed the exact remaining budget, causing the
value to drop below zero.

If this overdrawn negative budget is passed to the next BO in the batch,
alloc->defrag_bytes_remaining > 0 will evaluate to false. The allocator will
then treat the negative budget as unlimited rather than exhausted, bypassing
the cap entirely and stalling concurrent work.

> =20
>  	for (it.order =3D ttm_pool_alloc_find_order(MAX_PAGE_ORDER, alloc);
[ ... ]

Additionally, looking at ttm_tt_defrag_disown_borrowed() in
drivers/gpu/drm/ttm/ttm_tt.c:

drivers/gpu/drm/ttm/ttm_tt.c:ttm_tt_defrag_disown_borrowed() {
    ...
    unsigned int order =3D sp ? ttm_pool_page_order_nodma(sp) : 0;
    pgoff_t nr =3D 1UL << order;
    ...
}

[Severity: Critical]
Is it safe to hardcode ttm_pool_page_order_nodma() here when defragmenting
pools that use dma_alloc?

Drivers that use dma_alloc pools (e.g., amdgpu, vmwgfx) store a pointer to a
struct ttm_pool_dma in the page->private field. Casting this pointer to an
integer order results in a huge bit shift, which destroys the array stride.
This silently fails to disown the shared pages, leading to an exploitable
use-after-free or double-free when the old tt is destroyed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710215442.2444=
235-1-matthew.brost@intel.com?part=3D8
