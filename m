Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 103A1C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:36:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37FF810E88B;
	Mon,  6 Jul 2026 10:36:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lZOlCZw8";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E494D10E88B
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 10:36:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5874E6138D;
 Mon,  6 Jul 2026 10:36:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D89451F000E9;
 Mon,  6 Jul 2026 10:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783334190;
 bh=NW3uYVub1y7guCzBPANeCUGWHcZNVr8AW4y8qHIzgaE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lZOlCZw8rug+SwV54DEtKPYisWQQn8sQFqTru2AJmtbdzZP+RjO1f2MYjk3ns/elu
 cQo3HsNKq+xinwkr6Dgc6gQnlhNzZ4rLvq/5FuWwcrnJ57eMfJzk8Dv0T/a6ARPgGu
 D2D0qNbA3ioGkkjAcEB6EX3j7PV38Y5kdzob+XW3gGU6Vw7y3rj7mqqRLQjp10sZ3m
 205JG+b5kavpHvQuhIhJiUphQZthylDotZNmapE1AdyhRjf63EtOElxYN54aWv8Ad6
 j2lEAvBHLMml78UH052xuunw84nxW9mIWjFNjZ2rg/jEGGYwnbD7qqoRT3OliU0DqL
 XmOy6hlwFraWA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/10] drm/ttm: support using drm_exec during
 eviction v4
To: "Natalie Vock" <nat@pixelcluster.dev>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260706-ttm_2_drm_exec-v2-9-4bf6bfc0d320@pixelcluster.dev>
References: <20260706-ttm_2_drm_exec-v2-0-4bf6bfc0d320@pixelcluster.dev>
 <20260706-ttm_2_drm_exec-v2-9-4bf6bfc0d320@pixelcluster.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 10:36:29 +0000
Message-Id: <20260706103629.D89451F000E9@smtp.kernel.org>
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
- [High] The logic change silently overrides `trylock_only` and `no_wait_gp=
u` flags when `ctx->exec` is provided, forcing blocking locks instead of tr=
ylocks.
--

commit 5fb376340fb1686ce3b629a364137351ecc0b343
Author: Natalie Vock <nat@pixelcluster.dev>

drm/ttm: support using drm_exec during eviction v4

Allow specifying a drm_exec object in TTMs operation context which is
used to lock objects during eviction.

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

[Severity: High]
Does returning false here when ctx->exec is set force the walk to bypass
trylocking and push the logic into a blocking fallback?

> =20
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

[Severity: High]
Does this perform a blocking WW mutex lock via drm_exec, completely ignoring
the trylock_only intent of the caller?

> +	else if (arg->ctx->interruptible)
>  		ret =3D dma_resv_lock_interruptible(bo->base.resv, arg->ticket);
>  	else
>  		ret =3D dma_resv_lock(bo->base.resv, arg->ticket);
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

[Severity: High]
Does negating the non-blocking flags when ctx->exec is present force the
walk to fall through to a blocking lock attempt?

This appears to silently override the trylock_only and no_wait_gpu flags.
When amdgpu_cs_bo_validate() triggers TTM eviction under memory pressure, it
passes an operation context with ctx->exec set. ttm_bo_evict_first() initia=
tes
its first pass with trylock_only =3D true to find an idle buffer.

Because of these changes, the walk bypasses the trylock_only check and falls
through to ttm_lru_walk_ticketlock(), which calls
drm_exec_lock_obj_report_dup() and performs a blocking WW mutex lock.

Could this cause the eviction to block and wait on the first busy buffer in
the LRU instead of skipping it, potentially breaking the two-pass eviction
strategy and leading to unnecessary command submission backoffs or
serialization of independent workloads?

>  			spin_unlock(lru_lock);
>  			ttm_bo_put(bo);
>  			spin_lock(lru_lock);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-ttm_2_drm_=
exec-v2-0-4bf6bfc0d320@pixelcluster.dev?part=3D9
