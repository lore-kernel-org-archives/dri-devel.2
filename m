Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27F72C5DF7D
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 15:35:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65D0D10F31A;
	Fri, 21 Aug 2026 15:35:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HfDwKvUw";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 234DB10F31A
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 15:35:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 60DDE6136E;
 Fri, 21 Aug 2026 15:35:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAA0E1F000E9;
 Fri, 21 Aug 2026 15:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787326547;
 bh=x7Y1LoV4lQAjus02t8XPDVi7lZIhF8gUdANtQTf61w0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HfDwKvUwXKaL9oygohCadOHQbMFbKx+S1alGxYFXwGzgnkl6zJ16zcZjYRDasLMxP
 0FNAx7J+YCyIpEfbKm3pvKe1nM3548uDs+Ahe2bsEohh1UhJqk9SYVmDm2EOibqjrC
 X5JMwDEqGVFou1QLZeSjNfdNupn2fXVT5ARYVcyGzkV29e48qvBYHSDfjn4g7vJqoX
 VE0GgRf3Q+zGgp0+DI91FfMPu/ydMp7PQehczZO47R+wbpX8JbwrS4jcs7+0GSps/h
 HvTIdTPNkRH9m3ZCoyK5yjAfv5PiLFeCsOK1LSG6RjwUGjhGpufrQwSc2FMkTxJWOj
 qqS0QXOy3OaXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/3] drm/nouveau: don't kill a fence context that is
 not ready yet
To: "Marek Czernohous" <mczernohous@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <178732578167.167481.4590474568281802870@gmail.com>
References: <178732578167.167481.5619512544301226563@gmail.com>
 <178732578167.167481.4590474568281802870@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 15:35:46 +0000
Message-Id: <20260821153546.EAA0E1F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] The newly introduced `ready` flag check can be bypassed because `c=
han->fence` is published without a release barrier by the backend allocator=
s, allowing a concurrent `nouveau_channel_kill()` to observe pre-initializa=
tion garbage.
- [High] A concurrent channel kill event can trigger a Use-After-Free if fe=
nce context initialization fails because the kill event is armed prior to f=
ull initialization.
--

--- Patch [2]: [PATCH v4 2/3] drm/nouveau: don't kill a fence context that =
is not ready yet ---
commit 566dba46ab74848a1cc990a88e4d8e18c316f52d
Author: Marek Czernohous <mczernohous@gmail.com>

drm/nouveau: don't kill a fence context that is not ready yet

This commit introduces a ready flag to the fence context to prevent the
kill handler from taking an uninitialized lock. It uses smp_store_release()
and smp_load_acquire() to hand over the context safely once it is fully
built. A channel killed during initialization is recorded and processed
once armed.

> diff --git a/drivers/gpu/drm/nouveau/nouveau_chan.c b/drivers/gpu/drm/nou=
veau/nouveau_chan.c
> --- a/drivers/gpu/drm/nouveau/nouveau_chan.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_chan.c
> @@ -43,9 +43,17 @@ module_param_named(vram_pushbuf, nouveau_vram_pushbuf,=
 int, 0400);
>  void
>  nouveau_channel_kill(struct nouveau_channel *chan)
>  {
> +	struct nouveau_fence_chan *fctx;
> +
>  	atomic_set(&chan->killed, 1);
> -	if (chan->fence)
> -		nouveau_fence_context_kill(chan->fence, -ENODEV);
> +
> +	/* Pairs with the smp_mb() in nouveau_fence_context_arm(). */
> +	smp_mb();
> +
> +	fctx =3D READ_ONCE(chan->fence);
> +	/* Pairs with the smp_store_release() there. */
> +	if (fctx && smp_load_acquire(&fctx->ready))

[Severity: High]
This is a pre-existing issue, but can we read pre-initialization garbage
for fctx->ready here?

Because chan->fence is published by backend allocators with a plain store
(e.g., chan->fence =3D kzalloc_obj(*fctx)), on weakly-ordered architectures,
this READ_ONCE() might observe the pointer before the allocator's zeroing
stores are visible. The smp_load_acquire() on fctx->ready doesn't prevent
reading pre-initialization garbage for the ready flag itself.

If ready is read as non-zero garbage, the kill handler would proceed to
acquire an uninitialized spinlock, potentially causing a kernel panic.

> +		nouveau_fence_context_kill(fctx, -ENODEV);
>  }

[ ... ]

> @@ -494,7 +502,12 @@ nouveau_channel_init(struct nouveau_channel *chan, u=
32 vram, u32 gart)
>  	}
> =20
>  	/* initialise synchronisation */
> -	return nouveau_fence(drm)->context_new(chan);
> +	ret =3D nouveau_fence(drm)->context_new(chan);
> +	if (ret)
> +		return ret;

[Severity: High]
This isn't a bug introduced by this patch, but could this error path lead
to a use-after-free if a concurrent channel kill event fires?

Earlier in nouveau_channel_init(), the kill event is armed:

drivers/gpu/drm/nouveau/nouveau_chan.c:nouveau_channel_init() {
    ...
		if (ret =3D=3D 0)
			ret =3D nvif_event_allow(&chan->kill);
    ...
}

If context_new() fails (e.g., due to VMA allocation failure), it cleans up
by freeing the fence context. If a hardware kill event fires concurrently,
nouveau_channel_kill() might read chan->fence before the error path clears
it. This would lead to a use-after-free when smp_load_acquire(&fctx->ready)
is evaluated on the freed pointer in the asynchronous kill handler.

> +
> +	nouveau_fence_context_arm(chan);
> +	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178732578167.167481=
.5619512544301226563@gmail.com?part=3D2
