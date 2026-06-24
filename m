Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91755CDB481
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 14:52:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F083910E09F;
	Wed, 24 Jun 2026 14:52:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BmuYDrG8";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1217010E09F
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 14:52:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E36E8404B9;
 Wed, 24 Jun 2026 14:52:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B26581F00A3D;
 Wed, 24 Jun 2026 14:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782312741;
 bh=jJqVmmirP6Jdc2/h1LFcQD32J5vSzZp1QIRSOea/01Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BmuYDrG8DPGafvGhbZbXchjgiD4h5BvHO8QkzSZYkG7IB7avZAypbKlFImnTB+cVV
 ux504ORwb9ny4ZBntvFkl9zJevRrXPw2tWIj/zvAyE1xXBa37osYB73KKUBtYJjSLA
 l33aSxHsGddS7Mr8MBkdZfO8Fz3sRU8a4h5CLVlXpgVEBuISKpUdTuLIHPHAQ/Xxid
 HhWurnx+DaW1QMv5CdT3t3EaVz6dav4YxVL0bmwJzfqm7n8SmPonTSGMjAu6PXYcEU
 ovjtavxF+UDgdlvmFOPz4Q9iCnWkVMS1hmgEcjX9uAla1IBDt+cy8ukW7gQXmjbb4Z
 svwTe1DSgLyMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] gpu: ipu-v3: fail PRG channel setup when buffer fill
 times out
To: "Pengpeng Hou" <pengpeng@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260624143752.53943-1-pengpeng@iscas.ac.cn>
References: <20260624143752.53943-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 14:52:21 +0000
Message-Id: <20260624145221.B26581F00A3D@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Critical] A failed channel configuration sets `chan->used_pre =3D -1`, l=
eading to an out-of-bounds array access in the VBLANK interrupt handler.
- [High] The error path fails to restore the out-parameter `*eba`, causing =
the caller to program the hardware with a disabled SRAM address.

Pre-existing issues:
- [High] Sleeping functions are called from within a DRM plane atomic updat=
e callback.
- [High] The return value of pm_runtime_get_sync() is ignored, risking a sy=
nchronous external abort.
--

commit 026bb13a574603516c5e8a7270cb349020d87261
Author: Pengpeng Hou <pengpeng@iscas.ac.cn>

gpu: ipu-v3: fail PRG channel setup when buffer fill times out

ipu_prg_channel_configure() waits for both PRG double buffers to become
ready, but ignores readl_poll_timeout() failures. A timeout is therefore
reported as a successful configuration and chan->enabled is set even
though the hardware did not report ready buffers. Propagate the timeout
error.

> diff --git a/drivers/gpu/ipu-v3/ipu-prg.c b/drivers/gpu/ipu-v3/ipu-prg.c
> index d38d3ba54d722..ff32f4ca57cb4 100644
> --- a/drivers/gpu/ipu-v3/ipu-prg.c
> +++ b/drivers/gpu/ipu-v3/ipu-prg.c
> @@ -327,10 +327,22 @@ int ipu_prg_channel_configure(struct ipuv3_channel =
*ipu_chan,
>  	writel(val, prg->regs + IPU_PRG_REG_UPDATE);
> =20
>  	/* wait for both double buffers to be filled */
> -	readl_poll_timeout(prg->regs + IPU_PRG_STATUS, val,
> -			   (val & IPU_PRG_STATUS_BUFFER0_READY(prg_chan)) &&
> -			   (val & IPU_PRG_STATUS_BUFFER1_READY(prg_chan)),
> -			   5, 1000);
> +	ret =3D readl_poll_timeout(prg->regs + IPU_PRG_STATUS, val,
> +				 (val & IPU_PRG_STATUS_BUFFER0_READY(prg_chan)) &&
> +				 (val & IPU_PRG_STATUS_BUFFER1_READY(prg_chan)),
> +				 5, 1000);

[Severity: High]
This is a pre-existing issue, but does using readl_poll_timeout() here
cause us to sleep in an atomic context?

The macro internally uses usleep_range(), but ipu_prg_channel_configure()
is called from the DRM plane atomic update callback ipu_plane_atomic_update=
()
which runs in an atomic context where sleeping is forbidden.

Additionally, the pm_runtime_get_sync() call earlier in this function
can also sleep. Can we safely sleep here, or should this be avoided?

> +	if (ret) {
> +		val =3D readl(prg->regs + IPU_PRG_CTL);
> +		val |=3D IPU_PRG_CTL_BYPASS(prg_chan);
> +		writel(val, prg->regs + IPU_PRG_CTL);
> +
> +		val =3D IPU_PRG_REG_UPDATE_REG_UPDATE;
> +		writel(val, prg->regs + IPU_PRG_REG_UPDATE);
> +
> +		pm_runtime_put(prg->dev);

[Severity: High]
This isn't a bug introduced by this patch, but earlier in
ipu_prg_channel_configure() we call pm_runtime_get_sync(prg->dev)
without checking its return value.

If the device fails to power on and we proceed to access unpowered PRG
MMIO registers like IPU_PRG_STRIDE, will it trigger a synchronous
external abort?

> +		ipu_prg_put_pre(prg, prg_chan);

[Severity: Critical]
Could this regression cause the call to ipu_prg_put_pre() to lead to an
out-of-bounds array access later?

When this fails, ipu_prg_put_pre() correctly releases the PRE but sets
chan->used_pre to -1. However, because the caller ipu_plane_atomic_update()
in ipuv3-plane.c ignores the error, ipu_state->use_pre remains true.

On the next VBLANK interrupt, ipu_plane_atomic_update_pending() blindly
delegates to the PRG:

ipu_plane_atomic_update_pending(...) {
    if (ipu_state->use_pre)
        return ipu_prg_channel_configure_pending(ipu_plane->ipu_ch);
}

Which then executes:

ipu_prg_channel_configure_pending(...) {
    ...
    return ipu_pre_update_pending(prg->pres[chan->used_pre]);
}

Will accessing prg->pres[-1] panic the kernel?

> +		return ret;

[Severity: High]
If we return on this error path, does this regression leave the
out-parameter *eba pointing to the now-disabled PRE SRAM?

In the caller ipu_plane_atomic_update() in ipuv3-plane.c, the return
value is ignored:

ipu_plane_atomic_update(...) {
    ...
    ipu_prg_channel_configure(ipu_plane->ipu_ch, axi_id, width,
                              height, fb->pitches[0],
                              fb->format->format, fb->modifier,
                              &eba);
    ...
    ipu_cpmem_set_buffer(ipu_plane->ipu_ch, 0, eba);
}

Will this result in the IPU IDMAC fetching pixel data from a disabled
PRE SRAM buffer and potentially causing a bus hang?

> +	}
> =20
>  	pm_runtime_put(prg->dev);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624143752.5394=
3-1-pengpeng@iscas.ac.cn?part=3D1
