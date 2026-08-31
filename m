Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 737A0C61DFD
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 19:11:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC3E410E336;
	Mon, 31 Aug 2026 19:11:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="F2aZvcK3";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C34B10E336
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 19:11:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 452CD400A3
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 19:11:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 140331F000E9;
 Mon, 31 Aug 2026 19:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788203493;
 bh=Az6pV6NYxXZuvFewMxZ4VU1dHM9rGgsDWnGPqMQvsdM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=F2aZvcK30s0A4jB4kzzcfd2MyLLZQjf49j6JYE2/rx6RiqUGh039gfAxt1PvYCTlV
 IWQo6cB9zCJ2oonZcNY/6wUbRoH8ZZ9HikL06nk5qZy0zoWlDjuP5P28JG+JaGp1E/
 EOEiGwzGaoTtY3qI9tML33ZWN+9fraM+26mygfOqJRLEZ97aHnRBn92NossoL4iapC
 keuIiy1RYZHvhCBuW8jHXi1a8NlQfeeENhhPeOXyjNhUlPQCTyc7naFAzj+zL9p+DK
 p+f/kLZmqgkdJPNPzhD5SJS7OD8g/Q8mgXoTfcMW9720sNMY+q3c6Cl84YSoSojBy/
 jaKK7WJ2xVDiw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/13] drm/tilcdc: Move hardware reset to CRTC creation
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831-drm-no-more-crtc-reset-v2-4-4500d49a337f@kernel.org>
References: <20260831-drm-no-more-crtc-reset-v2-0-4500d49a337f@kernel.org>
 <20260831-drm-no-more-crtc-reset-v2-4-4500d49a337f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 19:11:32 +0000
Message-Id: <20260831191133.140331F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Low] Unused variable `priv` causes a compiler warning/error.

Pre-existing issues:
- [High] Missing explicit cancellation of `recover_work` leads to a potenti=
al Use-After-Free.
- [High] Missing return value check for `pm_runtime_get_sync()` before acce=
ssing hardware registers.
--

commit d111f5c86cb625a96553bb44ee58889cee8c25aa
Author: Maxime Ripard <mripard@kernel.org>

drm/tilcdc: Move hardware reset to CRTC creation

The tilcdc crtc reset hook performs both atomic state initialization
using drm_atomic_helper_crtc_reset() and hardware-level register
writes to disable the raster and clear IRQ status.

The hardware reset is not related to atomic state initialization, and
the reset hook is being converted to atomic_create_state which only
deals with state allocation. Move the hardware reset to the CRTC
creation path instead.

> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c b/drivers/gpu/drm/tilcd=
c/tilcdc_crtc.c
> index e07ecb36a27a8..b299d73ce3856 100644
> --- a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
> +++ b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
[ ... ]
> @@ -685,14 +685,12 @@ static void tilcdc_crtc_disable_vblank(struct drm_c=
rtc *crtc)
>  	spin_unlock_irqrestore(&tilcdc_crtc->irq_lock, flags);
>  }
> =20
> -static void tilcdc_crtc_reset(struct drm_crtc *crtc)
> +static void tilcdc_crtc_hw_reset(struct drm_crtc *crtc)
>  {
>  	struct tilcdc_crtc *tilcdc_crtc =3D to_tilcdc_crtc(crtc);
>  	struct drm_device *dev =3D crtc->dev;
>  	int ret;
> =20
> -	drm_atomic_helper_crtc_reset(crtc);
> -
>  	/* Turn the raster off if it for some reason is on. */
>  	pm_runtime_get_sync(dev->dev);
>  	if (tilcdc_read(dev, LCDC_RASTER_CTRL_REG) & LCDC_RASTER_ENABLE) {

[Severity: High]
This is a pre-existing issue, but is it safe to proceed with reading
LCDC_RASTER_CTRL_REG if pm_runtime_get_sync() fails?

If pm_runtime_get_sync() returns a negative error code (e.g. -EACCES) due to
a resume failure, the hardware may remain powered off. Accessing MMIO
registers on a powered-off or suspended device can cause a bus fault on ARM
platforms, leading to a synchronous external abort kernel panic.

Should we check the return value of pm_runtime_get_sync() here before
accessing the hardware?

[ ... ]
> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc=
/tilcdc_drv.c
> index 1d6c9a423a410..827f15d14fad9 100644
> --- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
> +++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
> @@ -249,9 +249,11 @@ static int tilcdc_pm_suspend(struct device *dev)
>  static int tilcdc_pm_resume(struct device *dev)
>  {
>  	struct drm_device *ddev =3D dev_get_drvdata(dev);
> +	struct tilcdc_drm_private *priv =3D ddev_to_tilcdc_priv(ddev);

[Severity: Low]
Does this code leave the priv variable unused?

It appears priv is declared and assigned here but never referenced,
which can cause a compiler warning.

> =20
>  	/* Select default pin state */
>  	pinctrl_pm_select_default_state(dev);
> +
>  	return  drm_mode_config_helper_resume(ddev);
>  }

I also noticed a separate regression outside the patch context in the driver
teardown path:

[Severity: High]
This isn't a bug introduced by this patch, but is it possible that the driv=
er
teardown fails to cancel the recover_work?

Looking at tilcdc_crtc_destroy() in tilcdc_crtc.c, the workqueue is flushed:

drivers/gpu/drm/tilcdc/tilcdc_crtc.c:tilcdc_crtc_destroy() {
    ...
	tilcdc_crtc_shutdown(priv->crtc);

	flush_workqueue(priv->wq);

	of_node_put(priv->crtc->port);
}

However, recover_work is queued on system_percpu_wq during sync loss events=
=20
in tilcdc_crtc_irq(), not on priv->wq. Since there is no explicit=20
cancel_work_sync(&tilcdc_crtc->recover_work) before the tilcdc_crtc=20
structure is ultimately freed, could this lead to a use-after-free if the=20
work executes after the CRTC state is destroyed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-drm-no-mor=
e-crtc-reset-v2-0-4500d49a337f@kernel.org?part=3D4
