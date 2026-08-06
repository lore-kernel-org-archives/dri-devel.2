Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12447C561E6
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 09:20:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9482210F16B;
	Thu,  6 Aug 2026 09:20:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Lq1o/DSv";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7608F10E2C8
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 09:20:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 130A241416;
 Thu,  6 Aug 2026 09:20:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF2571F00A3D;
 Thu,  6 Aug 2026 09:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786008003;
 bh=Pl1Keauj+9wL3Z/T5k5d7nPlT7RLaPnJMIKY5GslM8k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Lq1o/DSv/G6IiBlpIMz22uAe409QSPl3mljkkzFMLsJelJUC+IXyFOJYe1MJS05Rl
 X0/XimOMxmwZrmAWtdRLFfw7OIh1blF0EhbkBCH6ZrF1TSvUetBDWo/+7KtcMvl9O6
 HBm7dyipUXqyiITfk/Ei5SuxVJ3WJG1iZogCCd13UKatf9ipIbusw0VuCGu9J03ibs
 QQ8h/D3ohTdXoUcJCdP+j6/R0LY0e4hIqwL1wFfGs1Hwn3Dviulw9kADUiVf2WoFhd
 WX/EV7huw6sv4MagxuyuoRj1aBuxvdNcRp9soIo2b20wwXDPCtvqge6ie0f4wRDzUF
 j9qwmOSCuCEcQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] drm/nouveau: subscribe to channel-kill events on
 NV50 and newer
To: "Marek Czernohous" <mczernohous@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260806085228.1848994-3-mczernohous@gmail.com>
References: <20260806085228.1848994-1-mczernohous@gmail.com>
 <20260806085228.1848994-3-mczernohous@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 09:20:01 +0000
Message-Id: <20260806092002.BF2571F00A3D@smtp.kernel.org>
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
- [High] Asymmetric teardown of `chan->kill` event and `chan->fence` leads =
to a Use-After-Free if a channel kill event fires during channel destructio=
n.
- [High] Channel kill event can fire before `chan->fence` is fully initiali=
zed, leading to uninitialized spinlock and list head access.
--

--- Patch [2]: [PATCH v2 2/3] drm/nouveau: subscribe to channel-kill events=
 on NV50 and newer ---
commit 66f8740c572f7ea5ed5181be09ddea5061fdb648
Author: Marek Czernohous <marek@czernohous.de>

drm/nouveau: subscribe to channel-kill events on NV50 and newer

nouveau_channel_init() only subscribes to the channel-killed event for
FERMI_CHANNEL_GPFIFO and newer. This patch lowers the class gate to
NV50_CHANNEL_GPFIFO, ensuring that pending fences on a killed channel are
properly signalled for NV50/Tesla hardware.

> diff --git a/drivers/gpu/drm/nouveau/nouveau_chan.c b/drivers/gpu/drm/nou=
veau/nouveau_chan.c
> index 598513f604493..1db9fbd81f5c0 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_chan.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_chan.c
> @@ -363,7 +363,7 @@ nouveau_channel_init(struct nouveau_channel *chan, u3=
2 vram, u32 gart)
>  	if (ret)
>  		return ret;
> =20
> -	if (chan->user.oclass >=3D FERMI_CHANNEL_GPFIFO) {
> +	if (chan->user.oclass >=3D NV50_CHANNEL_GPFIFO) {

[Severity: High]
This is a pre-existing issue, but does expanding this subscription to NV50
expose it to a use-after-free during channel teardown?

During teardown, nouveau_channel_del() destroys the fence context before
unregistering the channel kill event:

nouveau_channel_del() {
    ...
    if (chan->fence)
        nouveau_fence(chan->cli->drm)->context_del(chan);
    ...
    nvif_event_dtor(&chan->kill);
}

The fence context is freed in nv10_fence_context_del() where chan->fence is
set to NULL non-atomically. If a channel kill event fires concurrently, cou=
ld
the asynchronous handler nouveau_channel_kill() read chan->fence locklessly
just before it is set to NULL and dereference the freed fence context inside
nouveau_fence_context_kill()?

[Severity: High]
This isn't a bug introduced by this patch, but is there also a race during
initialization where the kill event can fire before the fence context is fu=
lly
initialized?

In nouveau_channel_init(), the kill event is enabled early:

nouveau_channel_init() {
    ...
    if (ret =3D=3D 0)
        ret =3D nvif_event_allow(&chan->kill);
    ...
}

However, the fence context is created at the very end of the function:

nouveau_channel_init() {
    ...
    return nouveau_fence(drm)->context_new(chan);
}

Inside nv50_fence_context_new(), chan->fence is assigned via kzalloc before
the underlying lists and spinlocks are initialized by
nouveau_fence_context_new():

nv50_fence_context_new() {
    ...
    fctx =3D chan->fence =3D kzalloc_obj(*fctx);
    if (!fctx)
        return -ENOMEM;

    nouveau_fence_context_new(chan, &fctx->base);
}

If a kill event fires during this window, could nouveau_fence_context_kill()
attempt to acquire an uninitialized spinlock and traverse an uninitialized
list?

>  		DEFINE_RAW_FLEX(struct nvif_event_v0, args, data,
>  				sizeof(struct nvif_chan_event_v0));
>  		struct nvif_chan_event_v0 *host =3D

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806085228.1848=
994-1-mczernohous@gmail.com?part=3D2
