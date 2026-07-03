Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B4D1C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 17:23:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFAAB10E64A;
	Fri,  3 Jul 2026 17:23:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mHcEqJFc";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48EB510F881
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 17:23:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7C86660051;
 Fri,  3 Jul 2026 17:23:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 103391F000E9;
 Fri,  3 Jul 2026 17:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783099395;
 bh=L7vzuknHFfPsc2PNRTgiTcPt7dap8p/LXgb5kahA0sc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mHcEqJFc+Bd8afVs8GB6c2TmBi20diFkRormRXXuSeZeJaPYY7W0FBeSZUWAB8b2s
 09ptQqSGKh4zkop2ZMTcvF3ypLkmB5O5EZomcf1WlMKHJ03w/ljmzRXzigGTOoFoVn
 1/a9nu1kuv2u3Oi1kmE2ZXQ6GvW5/CWjC0vutfXCu9wdYPimd6jJbaYFwzQvaNd+FI
 tF07bgT1Vk2xnXPzbVKWhBNjKAkZFnxGn4vGo/jqe9XM6ABzD9Laoxo3qyR6Sn/Xbq
 UbDpBIuR8ex7wsAB0rm0h65sUS7wCWU4qF2HGNXombeIzEhW8w8a2tv68jKncwzKxw
 I6TyfADOekzQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/10] drm/ttm: support using drm_exec during eviction v4
To: "Natalie Vock" <natalie.vock@gmx.de>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260703-ttm_2_drm_exec-v1-9-43685ac1286b@gmx.de>
References: <20260703-ttm_2_drm_exec-v1-0-43685ac1286b@gmx.de>
 <20260703-ttm_2_drm_exec-v1-9-43685ac1286b@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 17:23:14 +0000
Message-Id: <20260703172315.103391F000E9@smtp.kernel.org>
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
- [Critical] The drm_exec_lock_obj_report_dup helper fails to bypass the DR=
M_EXEC_IGNORE_DUPLICATES flag, causing premature unlocking and use-after-fr=
ee of already-reserved buffers.
- [Medium] The trylock_only and no_wait_gpu flags are ignored when ctx->exe=
c is set, forcing synchronous blocking locks during fast/non-blocking evict=
ion passes.
--

commit 013bce350b89f0772194d9c2194cd802f5e36ff2
Author: Christian K=C3=B6nig <christian.koenig@amd.com>

drm/ttm: support using drm_exec during eviction v4

Allow specifying a drm_exec object in TTMs operation context which is
used to lock objects during eviction.

This allows to handle deadlocks much more gracefully and with that
avoid returning -ENOMEM on heavily contended domains.

> diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_=
bo_util.c
> index a53b25e8c2967..96699532817c2 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo_util.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo_util.c

[ ... ]

> @@ -837,6 +838,8 @@ static bool ttm_lru_walk_trylock(struct ttm_bo_lru_cu=
rsor *curs,
>  	struct ttm_operation_ctx *ctx =3D curs->arg->ctx;
> =20
>  	curs->needs_unlock =3D false;
> +	if (ctx->exec)
> +		return false;

[Severity: Medium]
Will this force a blocking lock during fast/non-blocking eviction passes?

By returning false unconditionally when ctx->exec is set, we bypass the
trylock here.

Later in __ttm_bo_lru_cursor_next(), the added !arg->ctx->exec check
prevents skipping the buffer, forcing a fall-through to
ttm_lru_walk_ticketlock() which performs a blocking lock. This seems to
ignore the trylock_only and no_wait_gpu flags.

>  	if (dma_resv_trylock(bo->base.resv)) {
>  		curs->needs_unlock =3D true;

[ ... ]

> @@ -857,7 +860,9 @@ static int ttm_lru_walk_ticketlock(struct ttm_bo_lru_=
cursor *curs,
>  	struct ttm_lru_walk_arg *arg =3D curs->arg;
>  	int ret;
> =20
> -	if (arg->ctx->interruptible)
> +	if (arg->ctx->exec)
> +		ret =3D drm_exec_lock_obj_report_dup(arg->ctx->exec, &bo->base);
> +	else if (arg->ctx->interruptible)
>  		ret =3D dma_resv_lock_interruptible(bo->base.resv, arg->ticket);

[ ... ]

> @@ -937,12 +946,17 @@ static void ttm_bo_lru_cursor_cleanup_bo(struct ttm=
_bo_lru_cursor *curs)
>  {
>  	struct ttm_buffer_object *bo =3D curs->bo;
> =20
> -	if (bo) {
> -		if (curs->needs_unlock)
> +	if (!bo)
> +		return;
> +
> +	if (curs->needs_unlock) {
> +		if (curs->arg->ctx->exec)
> +			drm_exec_unlock_obj(curs->arg->ctx->exec, &bo->base);

[Severity: Critical]
Can this cause a use-after-free for already-reserved buffers?

Looking at drm_exec_lock_obj_report_dup() used in ttm_lru_walk_ticketlock(),
it passes false for the always_report_duplicates parameter:

drivers/gpu/drm/drm_exec.c:drm_exec_lock_obj_report_dup() {
    return __drm_exec_lock_obj(exec, obj, false);
}

If DRM_EXEC_IGNORE_DUPLICATES is set, it returns 0 instead of -EALREADY for
duplicate locks. When this happens, ttm_lru_walk_ticketlock() will see
ret =3D=3D 0 and set curs->needs_unlock =3D true.

Because of this, when ttm_bo_lru_cursor_cleanup_bo() runs, it sees
needs_unlock is true and calls drm_exec_unlock_obj() here, which unlocks
the object and drops its reference. This completely removes the buffer
from the caller's outer WW transaction.

> +		else
>  			dma_resv_unlock(bo->base.resv);
> -		ttm_bo_put(bo);
> -		curs->bo =3D NULL;
>  	}
> +	ttm_bo_put(bo);
> +	curs->bo =3D NULL;
>  }

[ ... ]

> @@ -1016,8 +1030,8 @@ __ttm_bo_lru_cursor_next(struct ttm_bo_lru_cursor *=
curs)
>  		if (ttm_lru_walk_trylock(curs, bo)) {
>  			bo_locked =3D true;
> =20
> -		} else if (!arg->ticket || arg->ctx->no_wait_gpu ||
> -			   arg->trylock_only) {
> +		} else if ((!arg->ticket || arg->ctx->no_wait_gpu ||
> +			    arg->trylock_only) && !arg->ctx->exec) {
>  			spin_unlock(lru_lock);
>  			ttm_bo_put(bo);
>  			spin_lock(lru_lock);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703-ttm_2_drm_=
exec-v1-0-43685ac1286b@gmx.de?part=3D9
