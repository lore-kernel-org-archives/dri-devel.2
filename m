Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2ED1C43458
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 03:12:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A21410E6FF;
	Sat, 11 Jul 2026 03:12:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OBB14Yzu";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8137310E6FF
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 03:12:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4CBDE408FE;
 Sat, 11 Jul 2026 03:12:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F40E1F000E9;
 Sat, 11 Jul 2026 03:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783739566;
 bh=p7NKV0plSrqzA5mI7keJvoc53RsE67obhEFJII74C2I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OBB14YzuXW6oSGmQkFdtyieorSwKAJ98oZ0NSeFkjT01/3Z4ZS06uxFE86EeGLefW
 KxthGYY4rJsQYIPIKe+cev/MY1HNV4yQJ7XGZpMU6JA3cfCrMZpQw9kRaVCt7cHZEk
 ci45tiWcR4Z5qfC6pGY6/+M3sHJk3EM8cS9PIj5OauLbToLNpt05pNpTXS1cSjVtXP
 teksl75df+yviCCPed22ZwmQS6A02onWLg2JSpur/wkJdfNgSSm+U1T4xijloKqF9r
 abe/VUqnsqu+OZzh51p+vfGOqA71B/2K+/XRX6Ejtzl2gIpRPy6O7dgQYnsx4DwgIF
 Rvy5tTNnquhFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/33] drm/ttm: Support defragmentation moves
To: "Matthew Brost" <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260711025619.2540575-6-matthew.brost@intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-6-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 03:12:45 +0000
Message-Id: <20260711031246.0F40E1F000E9@smtp.kernel.org>
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
- [Critical] Data loss due to `ttm_bo_move_memcpy` and driver hardware copy=
 routines ignoring `bo->defrag_old_tt`.
- [Critical] Asynchronous GPU copy Use-After-Free due to synchronous teardo=
wn on defrag move failure.
- [High] Victim BOs during multihop bounce moves are misclassified as defra=
g targets.
--

--- Patch [5]: [PATCH v3 05/33] drm/ttm: Support defragmentation moves ---
commit fba7dcbd46a60b9e14c15b0602b46ebb23a7bc37
Author: Matthew Brost <matthew.brost@intel.com>
Subject: drm/ttm: Support defragmentation moves

This commit introduces infrastructure to re-back an already-resident buffer
object with fresh pages at a more beneficial order. It stashes the old
backing in a new defrag_old_tt pointer and creates a fresh one during the
move.

> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -125,49 +125,133 @@ static int ttm_bo_handle_move_mem(struct ttm_buffe=
r_object *bo,
>  {
>  	struct ttm_device *bdev =3D bo->bdev;
>  	bool old_use_tt, new_use_tt;
> +	bool defrag;
>  	int ret;
> =20
>  	old_use_tt =3D !bo->resource || ttm_manager_type(bdev, bo->resource->me=
m_type)->use_tt;
>  	new_use_tt =3D ttm_manager_type(bdev, mem->mem_type)->use_tt;
> =20
> -	ttm_bo_unmap_virtual(bo);
> +	/*
> +	 * Only the BO that is the actual defrag target (moved in place via
> +	 * ttm_bo_validate(), evict =3D=3D false) is being defragmented. The sa=
me
> +	 * ctx->defrag is threaded into evictions triggered while allocating
> +	 * that target's new backing (ttm_bo_evict_alloc()), so guard against
> +	 * an unrelated victim BO (evict =3D=3D true) being misclassified as a
> +	 * defrag move and needlessly reallocating its backing.
> +	 */
> +	defrag =3D ctx->defrag && !evict && new_use_tt && bo->ttm &&
> +		 ttm_tt_is_populated(bo->ttm);

[Severity: High]
Are victim buffer objects misclassified as defragmentation targets during
multihop bounce moves?

When a victim BO's eviction requires a multihop bounce, ttm_bo_evict()
calls ttm_bo_bounce_temp_buffer(), which subsequently calls
ttm_bo_handle_move_mem() with evict =3D false.

If ctx->defrag is true from the surrounding defragmentation pass, this
condition will evaluate to true for the bounce move.

Could this unnecessarily reallocate the victim's backing, and subsequently
trigger the WARN_ON_ONCE below if a bounce is requested?

[ ... ]

> +	/*
> +	 * A defrag move deferred its virtual unmap until the new backing was
> +	 * successfully populated; tear the userspace mappings down now, before
> +	 * the move swaps in the new pages, so the next fault re-establishes
> +	 * them against the new backing.
> +	 */
> +	if (defrag)
> +		ttm_bo_unmap_virtual(bo);
> +
>  	ret =3D bdev->funcs->move(bo, evict, ctx, mem, hop);

[Severity: Critical]
Does this result in data loss if the driver falls back to the generic copy
routines?

If a driver opts into defragmentation via ctx->defrag =3D true,
ttm_bo_handle_move_mem() allocates a new TT backing (bo->ttm) and stashes
the old data in bo->defrag_old_tt before calling the driver's move callback.

If the driver falls back to the generic ttm_bo_move_memcpy() or uses a
hardware copy that directly relies on bo->ttm:

drivers/gpu/drm/ttm/ttm_bo_util.c:ttm_bo_move_memcpy() {
    ...
    dst_iter =3D ttm_kmap_iter_tt_init(&_dst_iter.tt, bo->ttm);
    ...
    src_iter =3D ttm_kmap_iter_tt_init(&_src_iter.tt, bo->ttm);
    ...
}

Won't both the source and destination initialize using the newly allocated
uninitialized bo->ttm, copying garbage onto itself, while the actual data
in bo->defrag_old_tt is ignored and eventually freed?

[ ... ]

>  out_err:
> -	if (!old_use_tt)
> +	if (bo->defrag_old_tt) {
> +		/* Failed defrag move: restore the original backing. */
> +		ttm_bo_tt_destroy(bo);

[Severity: Critical]
Can this synchronously free the backing memory while an asynchronous GPU co=
py
is still executing?

During a defrag move, the driver's move callback may launch an asynchronous
hardware copy to populate the new TT backing.

If a subsequent cleanup step fails (for example, ttm_bo_move_accel_cleanup()
returning -ENOMEM), the failure falls through to this out_err block.

If the memory is synchronously freed here using ttm_bo_tt_destroy(), won't
the GPU continue executing the copy into the now-freed system pages,
causing memory corruption?

> +		bo->ttm =3D bo->defrag_old_tt;
> +		bo->defrag_old_tt =3D NULL;
> +	} else if (!old_use_tt) {
>  		ttm_bo_tt_destroy(bo);
> +	}
> =20
>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260711025619.2540=
575-1-matthew.brost@intel.com?part=3D5
