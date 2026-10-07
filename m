Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A84B5CA5FFC
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 12:59:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0693210E475;
	Wed,  7 Oct 2026 12:59:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RXPcQFPu";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 897C510E592
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 12:59:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 77DFA601FB;
 Wed,  7 Oct 2026 12:59:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 124CC1F0089E;
 Wed,  7 Oct 2026 12:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791377969;
 bh=kyvqBToQHK1trTzq/7IHGLwVwYdGbRIIVud1zICd66w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RXPcQFPuAwNo3LLGNVseunDb77gW9bBAqvGZTUe9LaMwRISXYmub0ctCkQmqalkgY
 i28hI9BFYpdiSRUqsKMjr/sgRw7FIHgyGGpTbmVmNPwOfUbdaHtNf3MYTmfdFRppZn
 shFemn8uvRmwmxq+jW/0giuBrQv9isyJtId/frm8Cv/JVRxzX7Ur3CqPYUUf7THwn/
 S6Wue4J2tnERtuNb716gOGCfULCEgCoRz1fnBIPaVlTtTSh3kC0INremXMs+fssSE3
 1jI796Fvl9m/vhEatUoH1vdNN293KPz2NTJaY1IK+HMsyJUgnupRHrdI6+wRVGXbZd
 CGCHJ9wkVRGSQ==
Message-ID: <sashiko-outbox-163018@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/exec: don't immediately add prelocked obj to array
 of locked objs
To: =?utf-8?b?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261007124657.9664-1-christian.koenig@amd.com>
References: <20261007124657.9664-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 12:59:28 +0000
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
- [High] drm/exec: silent unlock of shared dma_resv when ignoring duplicates
--

commit ffbebd24a9a712b1b60d1b56c904b2fe3d32a8d5
Author: Christian K=C3=B6nig <ckoenig.leichtzumerken@gmail.com>

drm/exec: don't immediately add prelocked obj to array of locked objs

This commit defers adding a prelocked object to the array of locked objects
until the driver explicitly requests it again. This prevents holding the la=
st
reference to objects that are about to be destroyed if they are never
requested again in a dynamic locking loop.

> diff --git a/drivers/gpu/drm/drm_exec.c b/drivers/gpu/drm/drm_exec.c
> index 2453ec41360f4..a910b0ad17ce4 100644
> --- a/drivers/gpu/drm/drm_exec.c
> +++ b/drivers/gpu/drm/drm_exec.c
> @@ -118,6 +127,14 @@ EXPORT_SYMBOL(drm_exec_fini);
>  bool drm_exec_cleanup(struct drm_exec *exec)
>  {
>  	if (likely(!exec->contended)) {
> +
> +		/*
> +		 * The contended and prelocked object might never given to
> +		 * drm_exec_lock_obj() again. This can happen when the object
> +		 * is about to be cleaned up and we now hold the last reference
> +		 * to it. Make sure that we don't unecessarily keep it around.
> +		 */
> +		drm_exec_drop_prelocked(exec);

[Severity: High]
Could this unconditionally unlock a shared dma_resv that was successfully
locked for another object?

If the locking loop is dynamic and object B becomes prelocked due to
contention, its dma_resv is locked. During the retry, if the driver requests
object A (which shares the same dma_resv as B) but does not request B again,
this will unlock B's dma_resv at the end of the loop, which also unlocks A.

[ ... ]

> @@ -212,35 +229,31 @@ int drm_exec_lock_obj(struct drm_exec *exec, struct=
 drm_gem_object *obj)
>  	if (exec->prelocked =3D=3D obj) {
>  		drm_gem_object_put(exec->prelocked);
>  		exec->prelocked =3D NULL;
> -		return 0;
> -	}
> +	} else {
> +		if (exec->flags & DRM_EXEC_INTERRUPTIBLE_WAIT)
> +			ret =3D dma_resv_lock_interruptible(obj->resv,
> +							  &exec->ticket);
> +		else
> +			ret =3D dma_resv_lock(obj->resv, &exec->ticket);
> +
> +		if (unlikely(ret =3D=3D -EDEADLK)) {
> +			drm_gem_object_get(obj);
> +			exec->contended =3D obj;
> +			return -EDEADLK;
> +		}
> =20
> -	if (exec->flags & DRM_EXEC_INTERRUPTIBLE_WAIT)
> -		ret =3D dma_resv_lock_interruptible(obj->resv, &exec->ticket);
> -	else
> -		ret =3D dma_resv_lock(obj->resv, &exec->ticket);
> +		if (unlikely(ret =3D=3D -EALREADY) &&
> +		    exec->flags & DRM_EXEC_IGNORE_DUPLICATES)
> +			return 0;

[Severity: High]
Does this skip adding object A to the locked objects array if its shared
dma_resv is already locked by the prelocked object B?

If DRM_EXEC_IGNORE_DUPLICATES is set, dma_resv_lock(A->resv) returns -EALRE=
ADY
because B (the prelocked object) holds the lock. This early return of 0
implies A is safely locked, but A is never added to exec->objects.

Combined with drm_exec_drop_prelocked() in drm_exec_cleanup(), B's dma_resv
will be unlocked. The driver will then proceed with its operations believin=
g A
is locked, but its dma_resv has been silently unlocked. Can this lead to da=
ta
races or use-after-free for A?

> -	if (unlikely(ret =3D=3D -EDEADLK)) {
> -		drm_gem_object_get(obj);
> -		exec->contended =3D obj;
> -		return -EDEADLK;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007124657.9664=
-1-christian.koenig@amd.com?part=3D1
