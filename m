Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9218C44506
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 22:19:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5800C10E272;
	Fri, 10 Jul 2026 22:19:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YjTf0Bhr";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D234810E272
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 22:19:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3DB2660052;
 Fri, 10 Jul 2026 22:19:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDECD1F000E9;
 Fri, 10 Jul 2026 22:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783721996;
 bh=qmL2NVGLwbAsV+Q8BViUmysbDuZUAGPxfk42srT1TLk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YjTf0BhrYrki8cFhxwcgEMm3GvJbQ6yScLY/oREIDpRKnDklxnp2gTj54oASDDVfT
 utoJFaVPnTh9yCGr/KiSjrwsJChSkhIpPrV7osmyEknS18Bf6pdKKc18HvyEx2q7BR
 6JIs+4eXPrKAa5uFMA/V5G4Cg05uh291w3lsxl2XRYGnNlA/HjOp3g+YcqhycP0zUx
 1umbSORLI8RaBGTSbvYurGCwBiVsGJoC6hbk4C8ctOpqZJUilh/xLeFzvoL2t9eQa6
 QQ7j4WPpoXzNtZ2GKy16WaRpt0XiZEmalp+ZAHkvthSu/b7aISy6ON6qoEtOYjrRdM
 CVMCMvVKjtEUg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/33] drm/ttm: Harvest beneficial-order pages on
 defragmentation moves
To: "Matthew Brost" <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260710215442.2444235-8-matthew.brost@intel.com>
References: <20260710215442.2444235-1-matthew.brost@intel.com>
 <20260710215442.2444235-8-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 22:19:56 +0000
Message-Id: <20260710221956.BDECD1F000E9@smtp.kernel.org>
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
- [Critical] Defragmentation of DMA-allocated or external TTs causes massiv=
e out-of-bounds memory writes due to misinterpreting page private data as a=
n allocation order.
- [Critical] Misaligned chunks between the old and new TT lead to partial c=
hunk harvesting, resulting in a severe use-after-free.
- [High] If the driver's move callback returns `-EMULTIHOP`, the defragment=
ation rollback is bypassed, causing a permanent memory leak of the original=
 buffer object TT.
--

--- Patch [7]: [PATCH v2 07/33] drm/ttm: Harvest beneficial-order pages on =
defragmentation moves ---
commit 74e91ed102adee47c82989ab7b4f83fd70da47c2
Author: Matthew Brost <matthew.brost@intel.com>
drm/ttm: Harvest beneficial-order pages on defragmentation moves

A defragmentation move relocates a populated tt into a freshly allocated
one so that sub-beneficial-order chunks can be upgraded to the device's
beneficial order. Previously, if allocation could not complete entirely
at beneficial order, the move failed and all progress was discarded.
Instead, once allocation has successfully upgraded part of the object,
the remainder of the old tt is harvested to complete the new tt. Thread
the BO's old, still-populated tt into the page allocator via a new
ttm_operation_ctx::defrag_old_tt.

> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
[ ... ]
> @@ -218,10 +225,18 @@ static int ttm_bo_handle_move_mem(struct ttm_buffer=
_object *bo,
>  	if (defrag)
>  		ttm_bo_unmap_virtual(bo);
> =20
>  	ret =3D bdev->funcs->move(bo, evict, ctx, mem, hop);
>  	if (ret) {
>  		if (ret =3D=3D -EMULTIHOP)
>  			return ret;
>  		goto out_err;
>  	}
> =20
>  	if (bo->defrag_old_tt) {

[Severity: High]
If bdev->funcs->move() returns -EMULTIHOP, does returning immediately bypass
the out_err rollback path?

It looks like the original TT remains stashed in bo->defrag_old_tt instead =
of
being restored.

When the move is retried, it appears bo->defrag_old_tt would be overwritten
or cleared, causing the original buffer object TT and its unborrowed pages
to be permanently leaked.

> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_poo=
l.c
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
[ ... ]
> +static int ttm_pool_iter_reuse_old(struct ttm_pool_alloc_iter *it)
> +{
> +	unsigned int harvest_order;
> +	pgoff_t off;
> +	int r;
> +
> +	if (!it->defrag_old_tt || !it->beneficial_order)
> +		return TTM_POOL_ITER_FILL;
> +
> +	off =3D it->tt->num_pages - it->alloc->remaining_pages;
> +	harvest_order =3D ttm_pool_defrag_old_order(it->pool, it->defrag_old_tt,
> +						  off, &it->old_cursor);
> +
> +	if (harvest_order < it->beneficial_order &&
> +	    it->order >=3D it->beneficial_order)
> +		return TTM_POOL_ITER_FILL;
> +
> +	it->order =3D harvest_order;
> +	r =3D ttm_pool_harvest_page(it->defrag_old_tt, it->order, off, it->allo=
c);

[Severity: Critical]
What happens if the new TT allocation size is unaligned, causing the offset
into the old TT to land in the middle of a large chunk?

Could ttm_pool_iter_reuse_old() or ttm_pool_harvest_remaining() harvest a
partial chunk, such as just the tail page?

If it harvests a tail page, the page order would be read as 0 since the
private data is only populated on the head page.

> diff --git a/drivers/gpu/drm/ttm/ttm_tt.c b/drivers/gpu/drm/ttm/ttm_tt.c
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
Can defragmentation be initiated on a buffer object that uses a DMA-allocat=
ed
or external TT?

Looking at ttm_bo_handle_move_mem(), it does not appear to restrict
defragmentation to non-DMA pools.

If a DMA-allocated TT is defragmented, wouldn't ttm_pool_page_order_nodma()
incorrectly read the DMA pointer stored in the page private data as an
integer order?

This would result in a huge bitshift when calculating nr, which is then
used in the loop increment or the memset() calls, potentially causing severe
out-of-bounds memory writes.

> +		if (sp && tt->pages[i] =3D=3D sp) {
> +			if (!in_run) {
> +				run_start =3D i;
> +				in_run =3D true;
> +			}
> +		} else if (in_run) {
> +			memset(&tt->pages[run_start], 0,
> +			       (i - run_start) * sizeof(*tt->pages));

[Severity: Critical]
Following up on the potential for harvesting an unaligned tail page (noted =
in
ttm_pool.c), if ttm_pool_iter_reuse_old() harvested a tail page, wouldn't
this logic clear the pointer in the old TT for that tail page, but leave the
head page pointer intact?

When the old TT is eventually destroyed, wouldn't ttm_pool_free_range() free
the entire chunk back to the system (since the head page still indicates a
large order) while the tail page is still actively mapped and used by the n=
ew
TT, leading to a severe use-after-free regression?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710215442.2444=
235-1-matthew.brost@intel.com?part=3D7
