Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25393C55ABF
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 09:29:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4721810E2F8;
	Thu,  6 Aug 2026 09:29:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Miiw8McB";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15CFC10E2F8
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 09:29:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3AABC60A8C;
 Thu,  6 Aug 2026 09:29:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF7DF1F000E9;
 Thu,  6 Aug 2026 09:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786008568;
 bh=o7znQNE8mS8ToNxTFjQrrLqkM5W6k01qYNDmxDZ25YI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Miiw8McBbWKR+/6h4S/eX/t+pFbq89TNfozZDGy2s/hILh2E/B/k+D3Zh8eVBRuDC
 q8AAwOnW2f/M1xGYvHNJzXCYH864B4XnlFEDz3jYf2YfGbiRLoLtTgZ3U0JipiKkTy
 rBr/DUtoIzxqrrcRXgJLW6uH8M3VJFC7Y5y+GnW/p8umBO/0eFGEtiPDWEXlPjHB3X
 7NezejKQoqGVbWwmyhnexrmRIdMa16JDZAc11fQwUhd0HCp9/W3yd+Qw9LlGJeDAAS
 Xb5Zfym99GsansRhY69S3lWcRSIQ0TC9KtJV435gpV8TBmjnlWVPKdhihdG0rnJMM8
 J/cI3SSXjtaNA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] drm/nouveau/fifo: add recovery path for Tesla
 cache_error/dma_pusher
To: "Marek Czernohous" <mczernohous@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260806085228.1848994-4-mczernohous@gmail.com>
References: <20260806085228.1848994-1-mczernohous@gmail.com>
 <20260806085228.1848994-4-mczernohous@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 09:29:28 +0000
Message-Id: <20260806092928.AF7DF1F000E9@smtp.kernel.org>
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
- [Medium] Race condition between nvkm_chan_del() and nv04_fifo_recover() l=
eaves a dangling pointer in wedge.chfault, allowing a newly allocated chann=
el to incorrectly inherit a fault streak.
--

--- Patch [3]: [PATCH v2 3/3] drm/nouveau/fifo: add recovery path for Tesla=
 cache_error/dma_pusher ---
commit 673f2147a13507bd6f62792657604b061ac497d7
Author: Marek Czernohous <marek@czernohous.de>

drm/nouveau/fifo: add recovery path for Tesla cache_error/dma_pusher

This commit adds a shared recovery helper, nv04_fifo_recover, for Tesla
chipset FIFO fault handling. It implements a two-tier recovery mechanism
that kills channels after a burst of faults and requests a device-wide
wedge event if faults continue.

> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/chan.c b/drivers/gp=
u/drm/nouveau/nvkm/engine/fifo/chan.c
> index 418a8918bcb8f..79774c6460f4f 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/chan.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/chan.c

[ ... ]

> @@ -275,6 +275,20 @@ nvkm_chan_del(struct nvkm_chan **pchan)
>  	nvkm_gpuobj_del(&chan->ramfc);
> =20
>  	if (chan->cgrp) {
> +		struct nvkm_fifo *fifo =3D chan->cgrp->runl->fifo;
> +
> +		/* Drop this channel's fault streak before the id is reused. */
> +		if (chan->id >=3D 0) {
> +			typeof(&fifo->wedge.chfault[0]) cf =3D
> +				&fifo->wedge.chfault[chan->id % NVKM_FIFO_KILL_CHID_MAX];
> +			unsigned long flags;
> +
> +			spin_lock_irqsave(&fifo->wedge.lock, flags);
> +			if (cf->owner =3D=3D chan)
> +				cf->owner =3D NULL;
> +			spin_unlock_irqrestore(&fifo->wedge.lock, flags);

[Severity: Medium]
Can a concurrent nv04_fifo_recover() race with this teardown and leave a
dangling pointer in cf->owner?

Because this is cleared before nvkm_chid_put() unlinks the channel, and
before chan->cgrp->lock is acquired, is it possible for the following
sequence to occur:

CPU1 in nvkm_chan_del():
    spin_lock_irqsave(&fifo->wedge.lock, flags);
    if (cf->owner =3D=3D chan)
        cf->owner =3D NULL;
    spin_unlock_irqrestore(&fifo->wedge.lock, flags);

CPU2 handling an interrupt in nv04_fifo_recover():
    chan =3D nvkm_chan_get_chid(...)=20
    ...
    spin_lock_irqsave(&w->lock, wflags);
    if (cf->owner !=3D chan || ...) {
        cf->owner =3D chan;
    }

CPU1 then calls nvkm_chid_put() unlinking the channel, and it is freed.

Would this leave the freed memory address in cf->owner, causing a newly
allocated channel that happens to reuse this address to incorrectly inherit
the previous channel's fault streak?

> +		}
> +
>  		nvkm_chid_put(chan->cgrp->runl->chid, chan->id, &chan->cgrp->lock);
>  		nvkm_cgrp_unref(&chan->cgrp);
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806085228.1848=
994-1-mczernohous@gmail.com?part=3D3
