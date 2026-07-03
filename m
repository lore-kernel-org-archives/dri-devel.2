Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E0B2C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 17:11:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6001910E643;
	Fri,  3 Jul 2026 17:11:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oSdQ+noC";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0815D10E643
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 17:11:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E51BE4109B;
 Fri,  3 Jul 2026 17:10:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AFCA1F00A3A;
 Fri,  3 Jul 2026 17:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783098659;
 bh=kcF9+32+7Qk+3CwsSaGCwLuVuN1fcJYyMnKFJA+I1PA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=oSdQ+noCUvPRBkT6gJJHLPQkvUonUxHPgN7Ns6nl8TqCcQGnvyessh/jummbw9KSQ
 OAemIWRskNkacAYc8f+/aOGaC5vP2Jb6Vze6dBpiQwpLJPYz6cONrTWEG6QNu1aawz
 JoO9xYy0nEdMRkGYaY1Sf5KO1TZoMkcKb2HD/eUWxRskTEJSYg+HhiweZZ2rDr3qDY
 ZXB62A8qJw740fdrwxL/NGOf1yEKGMu7OE911UjxfmimJ9oP963i+0K+pwEvWJ/x/d
 nKc6Z2etEHprIvJ+8QsPaNjJ6x5h5ZYXF/PvBFzlkYOVu7o/OjRwMEB5NP6Axj65vk
 3qJb6YW4dbXYQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/10] drm/xe: remove workaround for TTM internals
To: "Natalie Vock" <natalie.vock@gmx.de>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260703-ttm_2_drm_exec-v1-8-43685ac1286b@gmx.de>
References: <20260703-ttm_2_drm_exec-v1-0-43685ac1286b@gmx.de>
 <20260703-ttm_2_drm_exec-v1-8-43685ac1286b@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 17:10:58 +0000
Message-Id: <20260703171059.9AFCA1F00A3A@smtp.kernel.org>
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
- [Critical] Locking `ttm_bo->base.resv` while unlocking `&ttm_bo->base._re=
sv` causes deadlocks and kernel panics for objects with shared reservation =
locks.
- [High] Execution continues unlocked if `dma_resv_trylock()` fails, leadin=
g to unsafe fence modification and panics.
--

commit 4a41e0d0f5b4b25aaadf25f72a1d222898154844
Author: Christian K=C3=B6nig <christian.koenig@amd.com>

drm/xe: remove workaround for TTM internals

This commit removes a workaround for TTM internals in
xe_ttm_bo_release_notify(). It replaces the custom
xe_ttm_bo_lock_in_destructor() function with a direct call to
dma_resv_trylock().

> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> index 5843f850339c7..34eae56716076 100644
> --- a/drivers/gpu/drm/xe/xe_bo.c
> +++ b/drivers/gpu/drm/xe/xe_bo.c

[ ... ]

> @@ -1680,8 +1655,11 @@ static void xe_ttm_bo_release_notify(struct ttm_bu=
ffer_object *ttm_bo)
>  	bo =3D ttm_to_xe_bo(ttm_bo);
>  	xe_assert(xe_bo_device(bo), !(bo->created && kref_read(&ttm_bo->base.re=
fcount)));
> =20
> -	if (!xe_ttm_bo_lock_in_destructor(ttm_bo))
> -		return;
> +	/*
> +	 * This should never fail since there are no other references to the BO
> +	 * any more.
> +	 */
> +	WARN_ON(!dma_resv_trylock(ttm_bo->base.resv));

[Severity: Critical]
Does this cause a locking mismatch between ttm_bo->base.resv and
&ttm_bo->base._resv?

For imported dma-buf objects, ttm_bo->base.resv points to the exporter's
shared reservation lock, while &ttm_bo->base._resv points to the local unus=
ed
reservation object.

The trylock now uses ttm_bo->base.resv, but the subsequent fence replacement
loop and the unlock in the same function still operate on &ttm_bo->base._re=
sv:

	dma_resv_for_each_fence(&cursor, &ttm_bo->base._resv,
				DMA_RESV_USAGE_BOOKKEEP, fence) {
		...
	}
	dma_fence_put(replacement);

	dma_resv_unlock(&ttm_bo->base._resv);

Can this lead to the shared exporter lock being successfully acquired but n=
ever
unlocked (causing a deadlock), followed by a call to unlock the unheld local
_resv ww_mutex (triggering an immediate kernel panic)?

[Severity: High]
Is it safe to continue execution unconditionally if dma_resv_trylock() fail=
s?

The previous implementation safely returned early if the lock failed. The n=
ew
implementation wraps the trylock in a WARN_ON(), which only logs a warning =
and
does not abort control flow.

For imported BOs, the reservation lock is shared with the exporter and other
drivers, meaning the lock can legitimately be contended and the trylock can
fail. Will this allow execution to proceed unconditionally to modify fences
and unlock the reservation without actually holding the lock?

> =20
>  	/*
>  	 * Scrub the preempt fences if any. The unbind fence is already

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703-ttm_2_drm_=
exec-v1-0-43685ac1286b@gmx.de?part=3D8
