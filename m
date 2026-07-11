Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E789C43458
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 03:16:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DB5F10E70F;
	Sat, 11 Jul 2026 03:16:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Xae01we1";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B97C10E707
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 03:16:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1483041346;
 Sat, 11 Jul 2026 03:16:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB7E11F000E9;
 Sat, 11 Jul 2026 03:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783739761;
 bh=aGfMSWxEm12+es2GtddVvqpxk4jok4+PsR0HDiiloTQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Xae01we1PKe85xufDfDeQlegkJyHUZfrexYl4Vc0Cgp8tDGHDJRoOWeN/YrVGccVt
 X6uqtnm2O1M/ntjsu06E/JbNeNzluFgOWsuj5IrgSbC03TykDUSR7Fssofemf7tnTl
 ke19q9aX7mpvMilIWfi92FzuE/wEXcpeBcRpY8Y1RVnOslt0ALz3cGGxKq1OMplkJ4
 ZrCj6S76pN6ZbLrPfPU6gQDLe/70ZASWJI5dzAzTsGp0QGLBQOSbIoXVSlqQUNDXlX
 ZwdkH4MVIzfqXz9q891W9Rk/C6OddvxYUPrPo4D6MbrRMhHmwu+q2KvGI+eBx/zo6O
 bQdFo+zG/cNXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 07/33] drm/ttm: Harvest beneficial-order pages on
 defragmentation moves
To: "Matthew Brost" <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260711025619.2540575-8-matthew.brost@intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-8-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 03:16:00 +0000
Message-Id: <20260711031600.CB7E11F000E9@smtp.kernel.org>
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
- [Critical] Defragmentation of DMA-alloc or external buffer objects causes=
 out-of-bounds memory corruption.
- [Low] Comment falsely documents non-existent capping and prealloc logic.
--

--- Patch [7]: [PATCH v3 07/33] drm/ttm: Harvest beneficial-order pages on =
defragmentation moves ---
commit 6003b76a02bde0abed96778f39a94035b5bc6acd
Author: Matthew Brost <matthew.brost@intel.com>

drm/ttm: Harvest beneficial-order pages on defragmentation moves
   =20
A defragmentation move relocates a populated tt into a freshly allocated
one so that sub-beneficial-order chunks can be upgraded to the device's
beneficial order.

> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_poo=
l.c
> index 2598d2f33767e..52f5e64f05ddc 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c

[ ... ]

> +static int ttm_pool_harvest_remaining(struct ttm_pool *pool,
> +				      struct ttm_tt *old_tt, pgoff_t off,
> +				      struct ttm_pool_alloc_state *alloc)
> +{
> +	/*
> +	 * @off is always an old-tt chunk head here, never a tail page, so
> +	 * reading the per-chunk order below is safe. This holds because:
> +	 *  - Old chunks are self-aligned: greedy largest-power-of-two fill
> +	 *    places an order-k chunk at a 2^k-aligned offset, so any
> +	 *    beneficial-order-aligned offset is a chunk boundary.
> +	 *  - Fresh defrag allocations are capped at the beneficial order (see
> +	 *    ttm_pool_iter_acquire_page()), so they advance @off in beneficial
> +	 *    steps and never overshoot into the middle of a larger old chunk;
> +	 *    super-beneficial old chunks are always harvested whole by
> +	 *    ttm_pool_iter_reuse_old().
> +	 *  - We are only reached once the defrag budget/prealloc is exhausted,
> +	 *    which in the capped/prealloc config leaves @off beneficial-aligned
> +	 *    (or, in the sub-beneficial tail, already walking old boundaries).
> +	 */

[Severity: Low]
Are the invariants described in this comment block referring to code that i=
s=20
missing from this series?

The documentation states that allocations are capped and references=20
ttm_pool_iter_acquire_page(), but that function does not appear to contain =
any
capping logic.

The comment also refers to a defrag budget/prealloc exhaustion, but those
mechanisms do not seem to be present in the code.

> +	while (alloc->remaining_pages) {
> +		struct page *p =3D old_tt->pages[off];

[ ... ]

> diff --git a/drivers/gpu/drm/ttm/ttm_tt.c b/drivers/gpu/drm/ttm/ttm_tt.c
> index b645a18181843..2388ff794a594 100644
> --- a/drivers/gpu/drm/ttm/ttm_tt.c
> +++ b/drivers/gpu/drm/ttm/ttm_tt.c

[ ... ]

> +void ttm_tt_defrag_disown_borrowed(struct ttm_tt *tt, const struct ttm_t=
t *src)
> +{
> +	pgoff_t i =3D 0, run_start =3D 0;
> +	bool in_run =3D false;

[ ... ]

> +	while (i < tt->num_pages) {
> +		struct page *sp =3D src->pages[i];
> +		unsigned int order =3D sp ? ttm_pool_page_order_nodma(sp) : 0;
> +		pgoff_t nr =3D 1UL << order;

[Severity: Critical]
Can this lead to a massive out-of-bounds memset and memcpy when
defragmentation targets a dma-alloc pool or externally allocated buffer obj=
ect?

If a defragmentation move is initiated in ttm_bo_handle_move_mem() on a=20
buffer object using a dma-alloc pool or with TTM_TT_FLAG_EXTERNAL set, page=
=20
private data often contains a kernel pointer or arbitrary foreign data=20
instead of an allocation order.

Since ttm_pool_page_order_nodma() treats this data as an integer, the=20
resulting order calculation would yield an astronomically large chunk size=
=20
for nr. This size is then used in the memset operation immediately below,=20
and in the memcpy operation within ttm_pool_harvest_page():

drivers/gpu/drm/ttm/ttm_pool.c:ttm_pool_harvest_page() {
    ...
    memcpy(alloc->pages, &old_tt->pages[off], nr * sizeof(*alloc->pages));
    ...
}

Does ttm_bo_handle_move_mem() need validation to block defragmentation=20
on these configurations?

> +
> +		if (sp && tt->pages[i] =3D=3D sp) {
> +			if (!in_run) {
> +				run_start =3D i;
> +				in_run =3D true;
> +			}
> +		} else if (in_run) {
> +			memset(&tt->pages[run_start], 0,
> +			       (i - run_start) * sizeof(*tt->pages));

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260711025619.2540=
575-1-matthew.brost@intel.com?part=3D7
