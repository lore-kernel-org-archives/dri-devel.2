Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D11C5DF89
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 15:14:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A44910E08E;
	Fri, 21 Aug 2026 15:14:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="c4knpR7/";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AFC410E08E
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 15:14:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9302061126
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 15:14:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 352B91F000E9;
 Fri, 21 Aug 2026 15:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787325240;
 bh=i29Kgaq7RHNRCdAXRKO4npaY8gHr0xFH5ZDSYEFaVjo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=c4knpR7/gjvTs2ax3Nmu6tC92tliH6Qayx6266UIKsET4z/B7qyQWNcgtiXV49tiH
 QJh8o8qTVTaS6rfzijaOJqt0fvpuRZyMmTkNdPTS5MhhuyVHgMyxs5QOCSI9ihrNMh
 c/KVzocgoP4nipJvTltmnZbrS7OoJMmPdKv2z2MJO0XJYgEuC3hL8VxsT2Rx8y8Wld
 m2GV/isp9bhdSGNAdGeDauBwAMlOoRHup1DD2H0vVasuqrA/GLVtveAYv0N1LrXFQm
 g4Uv3nqEVik62YJo+REJhwaph/pzAtVGJ/asYKVeml3Ekslh7DXVZr9c56shwWyj8p
 nl6VMApjK+WUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 29/70] drm/tilcdc: Move hardware reset to CRTC creation
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-29-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
 <20260821-drm-no-more-crtc-reset-v1-29-fb793475c05a@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 15:13:59 +0000
Message-Id: <20260821151400.352B91F000E9@smtp.kernel.org>
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

New issues:
- [High] Moving the hardware reset logic to `tilcdc_crtc_create()` causes a=
n unconditional 500ms timeout and a potential fatal bus fault if the bootlo=
ader left the display enabled, because it waits for an interrupt before the=
 IRQ handler is registered.

Pre-existing issues:
- [High] The hardware reset sequence unconditionally writes to a V2-only in=
terrupt enable register, which fails to enable the framedone interrupt on V=
1 hardware and can cause register corruption.
--

--- Patch [29]: [PATCH 29/70] drm/tilcdc: Move hardware reset to CRTC creat=
ion ---
commit d53692ddb744ac620f653bb0b29134bf757b3e82
Author: Maxime Ripard <mripard@kernel.org>

drm/tilcdc: Move hardware reset to CRTC creation

The tilcdc crtc reset hook performs both atomic state initialization
and hardware-level register writes. This patch moves the hardware
reset sequence to the CRTC creation path since it is not related to
atomic state initialization.

[ ... ]

> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c b/drivers/gpu/drm/tilcd=
c/tilcdc_crtc.c
> index e07ecb36a27a8..910580c4dada6 100644
> --- a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
> +++ b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c

[ ... ]

> @@ -1005,5 +977,24 @@ int tilcdc_crtc_create(struct drm_device *dev)
> =20
>  	drm_crtc_helper_add(crtc, &tilcdc_crtc_helper_funcs);
> =20
> +	/* Turn the raster off if it for some reason is on. */
> +	pm_runtime_get_sync(dev->dev);
> +	if (tilcdc_read(dev, LCDC_RASTER_CTRL_REG) & LCDC_RASTER_ENABLE) {
> +		/* Enable DMA Frame Done Interrupt */
> +		tilcdc_write(dev, LCDC_INT_ENABLE_SET_REG, LCDC_FRAME_DONE);

[Severity: High]
This is a pre-existing issue, but does this write corrupt V1 hardware?

The LCDC_INT_ENABLE_SET_REG is specific to V2 hardware. On V1 hardware,
writing to this register accesses an undefined register address.

For V1, shouldn't the framedone interrupt be enabled via
LCDC_V1_FRAME_DONE_INT_ENA within LCDC_RASTER_CTRL_REG instead? This
unconditional write might fail to enable the interrupt on V1 controllers,
leading to a guaranteed timeout in the wait_event_timeout() call below.

> +		tilcdc_clear_irqstatus(dev, 0xffffffff);
> +
> +		tilcdc_crtc->frame_done =3D false;
> +		tilcdc_clear(dev, LCDC_RASTER_CTRL_REG, LCDC_RASTER_ENABLE);
> +
> +		ret =3D wait_event_timeout(tilcdc_crtc->frame_done_wq,
> +					 tilcdc_crtc->frame_done,
> +					 msecs_to_jiffies(500));

[Severity: High]
Will this unconditionally time out during boot if the bootloader left the
display enabled?

In the driver initialization sequence, tilcdc_crtc_create() executes before
the IRQ handler is registered in tilcdc_pdev_probe():

tilcdc_pdev_probe()
  ...
  ret =3D tilcdc_crtc_create(ddev);
  ...
  ret =3D tilcdc_irq_install(ddev, priv->irq);

Since the IRQ handler isn't registered yet when this code runs,
wait_event_timeout() will wait for an interrupt that cannot be handled,
causing a 500ms boot delay.

Could this also cause a kernel panic once the IRQ is finally registered?

When the timeout finishes, pm_runtime_put_sync() disables the device clocks,
leaving the unhandled interrupt pending in hardware. When
tilcdc_irq_install() later requests the IRQ, the handler will fire
immediately and attempt to read the status register while the IP's clocks
are gated, leading to an imprecise external abort.

> +		if (ret =3D=3D 0)
> +			drm_err(dev, "%s: timeout waiting for framedone\n",
> +				__func__);
> +	}
> +	pm_runtime_put_sync(dev->dev);
> +
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821-drm-no-mor=
e-crtc-reset-v1-0-fb793475c05a@kernel.org?part=3D29
