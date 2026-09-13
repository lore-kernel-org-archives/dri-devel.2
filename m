Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE21C88E5C
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 20:23:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C0E410E188;
	Sun, 13 Sep 2026 20:23:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PaPFeLvS";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 903D410E188
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 20:23:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 59CA243CEE;
 Sun, 13 Sep 2026 20:23:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 120A81F000FF;
 Sun, 13 Sep 2026 20:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789331027;
 bh=EYVPymu7wal8vH63VXY6Navih4LH02MQ9LXIe29oaJ4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PaPFeLvSfiJE8u3qznpPOWKH+423WXwG2p/TPbCLFjkYn9DwnpYowb8cnJUD0hbwV
 kLNiA2bOB8T/6PaPh+OEget+wcByia0GHkoK2x/zCaE8ybN8LUVE1ngvyR8v0BZ/kC
 6G+E1efhFefpwLHCz8s0buRz3CNsqr8w9Ko+uiDqr98tQS/rRLO8O8Md9KN8//ywyT
 5e5OpdY7lTC+4oEY76pRjmD7XpJnLik78wOE6eg41Lt6doYu+l/t/nnwsQjFxLDa64
 ks4JoeMvpsF8YEsYL+eN5lzCsSCXQytEqY9Ky2coeBqjPYDbYjmwJtcy/IrwUljltv
 enfna1vKpyAVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/nouveau/fifo: use global nonstall event on
 legacy FIFO
To: "Risto Pajula" <or.pajula@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260913201225.5975-3-or.pajula@gmail.com>
References: <20260913201225.5975-1-or.pajula@gmail.com>
 <20260913201225.5975-3-or.pajula@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 20:23:46 +0000
Message-Id: <20260913202347.120A81F000FF@smtp.kernel.org>
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
- [Critical] If channel initialization fails early in `nvkm_chan_new_()`, t=
he cleanup path dereferences a NULL `chan->cgrp`.
--

commit 6a368e9f19db8e6f77b9767f67dd0d51b8625cd8
Author: Risto Pajula <or.pajula@gmail.com>

drm/nouveau/fifo: use global nonstall event on legacy FIFO

This commit changes the nonstall event registration to use the runlist ID
only when per-runlist nonstall interrupts are supported, falling back to
event index 0 for legacy FIFO implementations. This fixes an issue where
fence completion waits for an event that is never signalled.

> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/uchan.c b/drivers/g=
pu/drm/nouveau/nvkm/engine/fifo/uchan.c
> index d6a87cec21503..b96e841920320 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/uchan.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/uchan.c
> @@ -52,7 +52,8 @@ nvkm_uchan_uevent(struct nvkm_object *object, void *arg=
v, u32 argc, struct nvkm_
> =20
>  	switch (args->v0.type) {
>  	case NVIF_CHAN_EVENT_V0_NON_STALL_INTR:
> -		return nvkm_uevent_add(uevent, &runl->fifo->nonstall.event, runl->id,
> +		return nvkm_uevent_add(uevent, &runl->fifo->nonstall.event,
> +				runl->fifo->func->nonstall_ctor ? runl->id : 0,
>  				       NVKM_FIFO_NONSTALL_EVENT, NULL);
>  	case NVIF_CHAN_EVENT_V0_KILLED:
>  		return nvkm_uevent_add(uevent, &runl->chid->event, chan->id,

[Severity: Critical]
This is a pre-existing issue, but while reviewing the channel handling code=
, I
noticed a potential NULL pointer dereference if channel initialization fails
early.

In drivers/gpu/drm/nouveau/nvkm/engine/fifo/chan.c:nvkm_chan_new_():

    ret =3D nvkm_cgrp_new(runl, chan->name, vmm, fifo->func->cgrp.force,
                        &chan->cgrp);
    if (ret) {
        RUNL_DEBUG(runl, "cgrp %d", ret);
        return ret;
    }

If nvkm_cgrp_new() fails, chan->cgrp remains NULL but the error is returned
to the caller while leaving the partially initialized channel allocated.

The cleanup path in nvkm_chan_del() unconditionally executes the RAMFC clear
callback on the partially initialized channel object:

drivers/gpu/drm/nouveau/nvkm/engine/fifo/chan.c:nvkm_chan_del() {
    ...
    if (chan->func->ramfc->clear)
        chan->func->ramfc->clear(chan);
    ...
}

For hardware-specific implementations like nv04_chan_ramfc_clear() in
drivers/gpu/drm/nouveau/nvkm/engine/fifo/nv04.c, this directly dereferences
chan->cgrp:

    struct nvkm_memory *ramfc =3D
        chan->cgrp->runl->fifo->engine.subdev.device->imem->ramfc;

Could this lead to a kernel panic when a userspace program invokes the
NVIF_IOCTL_NEW ioctl to create a new channel and nvkm_cgrp_new() fails? This
seems reachable if a user provides an invalid channel group or during memory
pressure.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913201225.5975=
-1-or.pajula@gmail.com?part=3D2
