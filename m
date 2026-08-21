Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB0DBC5DF7D
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 15:33:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0165710F313;
	Fri, 21 Aug 2026 15:33:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RMUgO11f";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1888110F313
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 15:33:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 230616136E;
 Fri, 21 Aug 2026 15:33:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACF961F000E9;
 Fri, 21 Aug 2026 15:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787326429;
 bh=EygtpzmxjhXGEtEXgbOUrY50K/iSmv4uqOTmubnerlA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RMUgO11fS7I8vIm+BZMclkbfIH+NS6kKgu4yRSmG+I4HpFYMyrw8bjPF+2JncoHbc
 QQJ9XaRHR8GBRWDQ2XxaX4dfmz209psIxAic94BkazsXmCsvQitQd+AAebIjh0yZe4
 s+Sv5H+NIejob2/2UqxiBMBFUY8fm9cyA4X/nYnzMJa2tPm3ScDHtBrCmkPU1Gv0i9
 yjxZo2ER9odEZ3C0eJaBhRMRNe/sk/3ED77+csaeregF9CK+AvTlGvvEF6wjhnOb3a
 6qpfND0h7U7FXlWvnqb9Md9BX6AaIOiDVtdxTB64oT0sBDb7xillmKdGgMEkr+fepU
 F0Y0TRuYzTz7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/3] drm/nouveau: subscribe to channel-kill events on
 NV50 and newer
To: "Marek Czernohous" <mczernohous@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <178732578167.167481.2178147998794444181@gmail.com>
References: <178732578167.167481.5619512544301226563@gmail.com>
 <178732578167.167481.2178147998794444181@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 15:33:49 +0000
Message-Id: <20260821153349.ACF961F000E9@smtp.kernel.org>
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
- [High] `chan->fence` is published without memory barriers before its fiel=
ds and spinlock are fully initialized, exposing an uninitialized spinlock t=
o the concurrent channel kill event handler.
--

--- Patch [3]: [PATCH v4 3/3] drm/nouveau: subscribe to channel-kill events=
 on NV50 and newer ---
commit 526eef3958eedb0aae06aba1612c73d287cde11e
Author: Marek Czernohous <mczernohous@gmail.com>

drm/nouveau: subscribe to channel-kill events on NV50 and newer

This commit lowers the class gate for subscribing to channel-killed events
from FERMI_CHANNEL_GPFIFO to NV50_CHANNEL_GPFIFO. This enables NV50 and Tes=
la
to correctly receive channel error notifications and signal pending fences.

> diff --git a/drivers/gpu/drm/nouveau/nouveau_chan.c b/drivers/gpu/drm/nou=
veau/nouveau_chan.c
> index 605ce74c0d155..54e2202cb852f 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_chan.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_chan.c
> @@ -378,7 +378,7 @@ nouveau_channel_init(struct nouveau_channel *chan, u3=
2 vram, u32 gart)
>  	if (ret)
>  		return ret;
> =20
> -	if (chan->user.oclass >=3D FERMI_CHANNEL_GPFIFO) {
> +	if (chan->user.oclass >=3D NV50_CHANNEL_GPFIFO) {
>  		DEFINE_RAW_FLEX(struct nvif_event_v0, args, data,
>  				sizeof(struct nvif_chan_event_v0));
>  		struct nvif_chan_event_v0 *host =3D

[Severity: High]
This is a pre-existing issue, but this change exposes an existing race cond=
ition
to NV50.

By allowing the channel kill event in this block, the event can fire before=
 the
fence context is fully initialized later in nouveau_channel_init():

drivers/gpu/drm/nouveau/nouveau_chan.c:nouveau_channel_init() {
	...
	if (chan->user.oclass >=3D NV50_CHANNEL_GPFIFO) {
		...
		ret =3D nvif_event_allow(&chan->kill);
	}
	...
	ret =3D nouveau_fence(drm)->context_new(chan);
}

In nv84_fence_context_new() (and similarly in nv50_fence_context_new()), the
fence pointer is published without a memory barrier:

	fctx =3D chan->fence =3D kzalloc_obj(*fctx);

If a channel fault occurs and the kill event handler runs concurrently:

drivers/gpu/drm/nouveau/nouveau_chan.c:nouveau_channel_kill() {
	...
	if (fctx && smp_load_acquire(&fctx->ready))
		nouveau_fence_context_kill(fctx, -ENODEV);
}

Because chan->fence was published without a store release, can
smp_load_acquire() observe non-NULL for fctx but read stale, uninitialized
memory for fctx->ready?

If the stale memory evaluates to true, it would proceed to call
nouveau_fence_context_kill(), which acquires an uninitialized spinlock:

drivers/gpu/drm/nouveau/nouveau_fence.c:nouveau_fence_context_kill() {
	...
	spin_lock_irqsave(&fctx->lock, flags);
}

Could this lead to a kernel crash or deadlock?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178732578167.167481=
.5619512544301226563@gmail.com?part=3D3
