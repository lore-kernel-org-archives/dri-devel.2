Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94B4606A339
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 17:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iEq/Ekc5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A40C10F31B;
	Mon, 16 Nov 2026 17:13:01 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4896A10F314
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 17:12:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3930162923;
 Mon, 16 Nov 2026 17:12:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 657061F000C4;
 Mon, 16 Nov 2026 17:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794849172;
 bh=PhgXzIn35vcixoaA5km8b/KSrgGyfBVQpQg6+frhs6s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=iEq/Ekc5+SpRmImpgd5pq3r34Ko9E70dtlIXE1wR1Q9T+nhn9f1RK8XkMCC5nSxN3
 JyI7otKA60PwNSB4N7w2xHfJ24m+J5PYAAFwW9U5AmRwBA648P54sTvLPR/OhdN0p5
 lD08Sf17fxz5pDat/nkrl1WpJLntr36yC/Mto5u7ArdYQ6IyAu4amj+AJQnivvtkDE
 568lHrgyVUUDNOoOuYgDePCqIbaQ4syuG/E+hm1EE+UANKo8r3msoYP4pSBqW9OIX/
 Fmdd93blydhC4Gt8pp7JjhMYknfMd+3ZtedJ71TZC5fe2FEJWE3lTyG4o7Os/HFs9f
 R8iYM9scakA0A==
Date: Mon, 16 Nov 2026 18:12:50 +0100
From: Maxime Ripard <mripard@kernel.org>
To: =?utf-8?B?TcOgeGlt?= Pedraza Padilla <maximpedraza@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/4] drm/tilcdc: Implement state readout support
Message-ID: <avs2dagfmQkv00H0@houat>
References: <20261116142707.1299360-1-maximpedraza@gmail.com>
 <20261116142707.1299360-4-maximpedraza@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="zrdb4uywdzhprt7d"
Content-Disposition: inline
In-Reply-To: <20261116142707.1299360-4-maximpedraza@gmail.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--zrdb4uywdzhprt7d
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH 3/4] drm/tilcdc: Implement state readout support
MIME-Version: 1.0

On Mon, Nov 16, 2026 at 03:27:06PM +0100, M=E0xim Pedraza Padilla wrote:
> Reconstruct the display mode from the LCDC raster registers and read out
> the primary plane, to build the initial KMS state from what the bootloader
> left scanning out instead of resetting the controller. A splash drawn
> before Linux takes over stays on screen, and the first commit replaces it,
> with no modeset if it keeps the mode.
>=20
> The registers don't record everything:
> - The channel order isn't stored, so RGB is reported for the adopted
>   framebuffer. It doesn't change what's on screen.

You mean RGB vs BGR? It's not available anywhere in a register?

> - tilcdc_crtc_mode_fixup() is undone to get the requested mode, but a
>   positive sync can't be told from a mode that doesn't specify it. Such a
>   mode will be reported as different by the post-commit comparison.

That's suprising as well, the polairity of signals is typically stored
somewhere in a register.

>=20
> If the raster isn't running there's nothing to adopt, and the CRTC and the
> plane are read out as disabled.
>=20
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: M=E0xim Pedraza Padilla <maximpedraza@gmail.com>
> ---
>  drivers/gpu/drm/tilcdc/tilcdc_crtc.c    | 173 ++++++++++++++++++++++++
>  drivers/gpu/drm/tilcdc/tilcdc_drv.c     |  22 ++-
>  drivers/gpu/drm/tilcdc/tilcdc_encoder.c |  29 +++-
>  drivers/gpu/drm/tilcdc/tilcdc_plane.c   | 106 +++++++++++++++
>  4 files changed, 325 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c b/drivers/gpu/drm/tilcd=
c/tilcdc_crtc.c
> index f619b7a6e70d..d5c34763bd96 100644
> --- a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
> +++ b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
> @@ -4,6 +4,7 @@
>   * Author: Rob Clark <robdclark@gmail.com>
>   */
> =20
> +#include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/of_graph.h>
> @@ -11,6 +12,8 @@
> =20
>  #include <drm/drm_atomic.h>
>  #include <drm/drm_atomic_helper.h>
> +#include <drm/drm_atomic_state_readout_helper.h>
> +#include <drm/drm_atomic_uapi.h>
>  #include <drm/drm_crtc.h>
>  #include <drm/drm_fb_dma_helper.h>
>  #include <drm/drm_fourcc.h>
> @@ -711,10 +714,180 @@ static void tilcdc_crtc_hw_reset(struct drm_crtc *=
crtc)
>  	pm_runtime_put_sync(dev->dev);
>  }
> =20
> +/*
> + * Reconstruct the adjusted mode from the LCDC raster registers. This is=
 the
> + * inverse of the register programming done in tilcdc_crtc_set_mode(): t=
he
> + * horizontal front/back porch and sync width are stored as (value - 1),=
 the
> + * pixels-per-line and lines-per-panel as (value - 1) as well, while the
> + * vertical front/back porch are stored verbatim. On the V2 controller a=
 few
> + * high order bits live in RASTER_TIMING_2.
> + *
> + * tilcdc_crtc_mode_fixup() always sets a HSYNC polarity and the skew, s=
o they
> + * can be told from the registers. A positive VSYNC can't be told from a=
 mode
> + * that doesn't specify it: the latter is assumed.
> + */
> +static int tilcdc_crtc_readout_mode(struct drm_crtc *crtc,
> +				    struct drm_display_mode *mode)
> +{
> +	struct drm_device *dev =3D crtc->dev;
> +	struct tilcdc_drm_private *priv =3D ddev_to_tilcdc_priv(dev);
> +	u32 t0, t1, t2, ctrl;
> +	u32 ppl, hsw, hfp, hbp;
> +	u32 lpp, vsw, vfp, vbp;
> +	unsigned long clk_rate;
> +	unsigned int clkdiv;
> +
> +	t0 =3D tilcdc_read(dev, LCDC_RASTER_TIMING_0_REG);
> +	t1 =3D tilcdc_read(dev, LCDC_RASTER_TIMING_1_REG);
> +	t2 =3D tilcdc_read(dev, LCDC_RASTER_TIMING_2_REG);
> +	ctrl =3D tilcdc_read(dev, LCDC_CTRL_REG);
> +
> +	/* Horizontal fields, low bits in TIMING_0, V2 high bits in TIMING_2. */
> +	ppl =3D (t0 >> 4) & 0x3f;
> +	hsw =3D (t0 >> 10) & 0x3f;
> +	hfp =3D (t0 >> 16) & 0xff;
> +	hbp =3D (t0 >> 24) & 0xff;
> +	if (priv->rev =3D=3D 2) {
> +		ppl |=3D ((t0 >> 3) & 0x1) << 6;
> +		hsw |=3D ((t2 >> 27) & 0xf) << 6;
> +		hfp |=3D (t2 & 0x3) << 8;
> +		hbp |=3D ((t2 >> 4) & 0x3) << 8;
> +	}
> +	mode->hdisplay =3D (ppl + 1) << 4;
> +	hsw +=3D 1;
> +	hfp +=3D 1;
> +	hbp +=3D 1;
> +
> +	/* Vertical fields, LPP high bit in TIMING_2 on V2. */
> +	lpp =3D t1 & 0x3ff;
> +	if (priv->rev =3D=3D 2 && (t2 & LCDC_LPP_B10))
> +		lpp |=3D 0x400;
> +	vsw =3D ((t1 >> 10) & 0x3f) + 1;
> +	vfp =3D (t1 >> 16) & 0xff;
> +	vbp =3D (t1 >> 24) & 0xff;
> +	mode->vdisplay =3D lpp + 1;
> +
> +	mode->hsync_start =3D mode->hdisplay + hfp;
> +	mode->hsync_end	  =3D mode->hsync_start + hsw;
> +	mode->htotal	  =3D mode->hsync_end + hbp;
> +
> +	mode->vsync_start =3D mode->vdisplay + vfp;
> +	mode->vsync_end	  =3D mode->vsync_start + vsw;
> +	mode->vtotal	  =3D mode->vsync_end + vbp;
> +
> +	/* Pixel clock is the functional clock divided by the CTRL divisor. */
> +	clkdiv =3D (ctrl & LCDC_CLK_DIVISOR_MASK) >> 8;
> +	clk_rate =3D clk_get_rate(priv->clk);
> +	if (!clkdiv || !clk_rate)
> +		return -EINVAL;
> +	mode->clock =3D (clk_rate / clkdiv) / 1000;

You need to give some leeway there. It's unlikely you'll ever going to
be an exact match for the mode being used due to clock rounding.

tilcdc_crtc_set_clk allows for a 5% (I think?) difference for example.

We handle that in tidss by looking for the closest rate match and see if
it falls into the specified tolerance
(dispc_find_closest_refresh_rate_from_clk). I always thought of it as
something that could be turned into a helper, and it's what you should
be using here.

> +	mode->flags |=3D t2 & LCDC_INVERT_HSYNC ? DRM_MODE_FLAG_NHSYNC :
> +						DRM_MODE_FLAG_PHSYNC;
> +	if (t2 & LCDC_INVERT_VSYNC)
> +		mode->flags |=3D DRM_MODE_FLAG_NVSYNC;
> +
> +	mode->hskew =3D hsw;
> +	mode->flags |=3D DRM_MODE_FLAG_HSKEW;
> +
> +	mode->type |=3D DRM_MODE_TYPE_DRIVER;
> +	drm_mode_set_name(mode);
> +	drm_mode_set_crtcinfo(mode, 0);
> +
> +	return 0;
> +}
> +
> +static int tilcdc_crtc_readout_state(struct drm_crtc *crtc,
> +				     struct drm_atomic_sro_state *state,
> +				     struct drm_crtc_state *crtc_state)
> +{
> +	struct drm_device *dev =3D crtc->dev;
> +	struct drm_display_mode adjusted =3D {}, mode;
> +	int ret;
> +
> +	pm_runtime_get_sync(dev->dev);
> +
> +	/* Nothing to adopt unless the bootloader left the raster running. */
> +	if (!(tilcdc_read(dev, LCDC_RASTER_CTRL_REG) & LCDC_RASTER_ENABLE))
> +		goto out;
> +
> +	ret =3D tilcdc_crtc_readout_mode(crtc, &adjusted);
> +	if (ret)
> +		goto err;
> +
> +	/* Undo tilcdc_crtc_mode_fixup(). */
> +	drm_mode_copy(&mode, &adjusted);
> +	mode.hskew =3D 0;
> +	mode.flags &=3D ~(DRM_MODE_FLAG_HSKEW | DRM_MODE_FLAG_NHSYNC |
> +			DRM_MODE_FLAG_PHSYNC);
> +	if (adjusted.flags & DRM_MODE_FLAG_PHSYNC)
> +		mode.flags |=3D DRM_MODE_FLAG_NHSYNC;
> +
> +	ret =3D drm_atomic_set_mode_for_crtc(crtc_state, &mode);
> +	if (WARN_ON(ret))
> +		goto err;
> +
> +	drm_mode_copy(&crtc_state->adjusted_mode, &adjusted);

The adjusted_mode handling should be fixed with v8 as well.

> +	crtc_state->active =3D true;
> +	crtc_state->enable =3D true;
> +
> +	/* The active plane is filled in by tilcdc_plane_readout_state(). */
> +
> +out:
> +	pm_runtime_put_sync(dev->dev);
> +	return 0;
> +
> +err:
> +	pm_runtime_put_sync(dev->dev);
> +	return ret;
> +}
> +
> +static void tilcdc_crtc_install_state(struct drm_crtc *crtc,
> +				      struct drm_crtc_state *crtc_state)
> +{
> +	struct tilcdc_crtc *tilcdc_crtc =3D to_tilcdc_crtc(crtc);
> +	struct drm_device *dev =3D crtc->dev;
> +	struct tilcdc_drm_private *priv =3D ddev_to_tilcdc_priv(dev);
> +
> +	if (!crtc_state->active)
> +		return;
> +
> +	/*
> +	 * The display is already scanning out the bootloader's image. Do what
> +	 * tilcdc_crtc_enable() and tilcdc_crtc_set_mode() would have done,
> +	 * without touching the raster: keep the controller powered, enable its
> +	 * interrupts and fill in the software state derived from the mode. A
> +	 * commit that doesn't change the mode relies on it, since no modeset
> +	 * will update it: set_scanout() uses crtc->mode for the DMA ceiling.
> +	 */
> +	pm_runtime_get_sync(dev->dev);
> +
> +	mutex_lock(&tilcdc_crtc->enable_lock);
> +
> +	drm_mode_copy(&crtc->mode, &crtc_state->mode);
> +	drm_mode_copy(&crtc->hwmode, &crtc_state->adjusted_mode);
> +	crtc->enabled =3D true;
> +	tilcdc_crtc->hvtotal_us =3D tilcdc_mode_hvtotal(&crtc->hwmode);
> +	tilcdc_crtc->lcd_fck_rate =3D clk_get_rate(priv->clk);
> +	tilcdc_crtc->last_vblank =3D ktime_get();
> +
> +	tilcdc_crtc_enable_irqs(dev);
> +
> +	drm_calc_timestamping_constants(crtc, &crtc->hwmode);
> +	drm_crtc_vblank_on(crtc);
> +
> +	tilcdc_crtc->enabled =3D true;
> +	mutex_unlock(&tilcdc_crtc->enable_lock);
> +}
> +
>  static const struct drm_crtc_funcs tilcdc_crtc_funcs =3D {
>  	.set_config     =3D drm_atomic_helper_set_config,
>  	.page_flip      =3D drm_atomic_helper_page_flip,
>  	.atomic_create_state =3D drm_atomic_helper_crtc_create_state,
> +	.atomic_sro_readout_state =3D tilcdc_crtc_readout_state,
> +	.atomic_sro_install_state =3D tilcdc_crtc_install_state,
> +	.atomic_sro_compare_state =3D drm_atomic_helper_crtc_compare_state,
>  	.atomic_duplicate_state =3D drm_atomic_helper_crtc_duplicate_state,
>  	.atomic_destroy_state =3D drm_atomic_helper_crtc_destroy_state,
>  	.enable_vblank	=3D tilcdc_crtc_enable_vblank,
> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc=
/tilcdc_drv.c
> index 1d6c9a423a41..ab88632919fa 100644
> --- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
> +++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
> @@ -12,6 +12,8 @@
> =20
>  #include <drm/clients/drm_client_setup.h>
>  #include <drm/drm_atomic_helper.h>
> +#include <drm/drm_atomic_state_readout.h>
> +#include <drm/drm_atomic_state_readout_helper.h>
>  #include <drm/drm_debugfs.h>
>  #include <drm/drm_drv.h>
>  #include <drm/drm_fbdev_dma.h>
> @@ -75,6 +77,12 @@ static const struct drm_mode_config_funcs mode_config_=
funcs =3D {
>  	.fb_create =3D drm_gem_fb_create,
>  	.atomic_check =3D tilcdc_atomic_check,
>  	.atomic_commit =3D drm_atomic_helper_commit,
> +	.atomic_sro_readout_state =3D drm_atomic_helper_sro_readout_state,
> +	.hw_reset =3D drm_mode_config_helper_hw_reset,
> +};
> +
> +static const struct drm_mode_config_helper_funcs mode_config_helper_func=
s =3D {
> +	.atomic_sro_build_state =3D drm_atomic_helper_sro_build_state,
>  };
> =20
>  static void modeset_init(struct drm_device *dev)
> @@ -86,6 +94,7 @@ static void modeset_init(struct drm_device *dev)
>  	dev->mode_config.max_width =3D priv->max_width;
>  	dev->mode_config.max_height =3D 2048;
>  	dev->mode_config.funcs =3D &mode_config_funcs;
> +	dev->mode_config.helper_private =3D &mode_config_helper_funcs;
>  }
> =20
>  #ifdef CONFIG_CPU_FREQ
> @@ -422,10 +431,19 @@ static int tilcdc_pdev_probe(struct platform_device=
 *pdev)
>  		goto unregister_cpufreq_notif;
>  	}
> =20
> -	drm_mode_config_reset(ddev);
> -
>  	drm_kms_helper_poll_init(ddev);
> =20
> +	/*
> +	 * Build the initial state from whatever the bootloader left running,
> +	 * instead of resetting the controller, so a splash drawn before Linux
> +	 * takes over is adopted rather than blanked.
> +	 */
> +	ret =3D drm_mode_config_create_initial_state(ddev);
> +	if (ret) {
> +		drm_err(ddev, "failed to create initial state: %d\n", ret);
> +		goto stop_poll;
> +	}
> +

That part is
https://lore.kernel.org/all/20261116-drm-no-more-config-reset-v2-43-0bb471f=
4d1e0@kernel.org/
with hw_reset that sashiko pointed out

It should really be there, but there's a circular dependency at the
moment between these two series that I'm not quite sure how to solve.

Hopefully, we will be able to merge the tidss create_initial_state
conversion and break that circular dependency.

Maxime

>  	ret =3D drm_dev_register(ddev, 0);
>  	if (ret)
>  		goto stop_poll;
> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_encoder.c b/drivers/gpu/drm/ti=
lcdc/tilcdc_encoder.c
> index ac4b5beb2dd5..b3fe18f69f17 100644
> --- a/drivers/gpu/drm/tilcdc/tilcdc_encoder.c
> +++ b/drivers/gpu/drm/tilcdc/tilcdc_encoder.c
> @@ -9,12 +9,34 @@
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_bridge.h>
>  #include <drm/drm_bridge_connector.h>
> +#include <drm/drm_crtc.h>
> +#include <drm/drm_encoder.h>
>  #include <drm/drm_of.h>
> -#include <drm/drm_simple_kms_helper.h>
> =20
>  #include "tilcdc_drv.h"
>  #include "tilcdc_encoder.h"
> =20
> +/*
> + * State readout needs to know which CRTC drives this encoder so the con=
nector
> + * can be tied back to it. tilcdc has a single CRTC, so return the one t=
he
> + * encoder was made possible for.
> + */
> +static struct drm_crtc *
> +tilcdc_encoder_get_current_crtc(struct drm_encoder *encoder)
> +{
> +	struct drm_crtc *crtc;
> +
> +	drm_for_each_crtc(crtc, encoder->dev)
> +		if (encoder->possible_crtcs =3D=3D drm_crtc_mask(crtc))
> +			return crtc;
> +
> +	return NULL;
> +}
> +
> +static const struct drm_encoder_funcs tilcdc_encoder_funcs =3D {
> +	.atomic_sro_get_current_crtc =3D tilcdc_encoder_get_current_crtc,
> +};
> +
>  static
>  int tilcdc_attach_bridge(struct drm_device *ddev, struct drm_bridge *bri=
dge)
>  {
> @@ -51,8 +73,9 @@ int tilcdc_encoder_create(struct drm_device *ddev)
>  	else if (IS_ERR(bridge))
>  		return PTR_ERR(bridge);
> =20
> -	encoder =3D drmm_simple_encoder_alloc(ddev, struct tilcdc_encoder,
> -					    base, DRM_MODE_ENCODER_NONE);
> +	encoder =3D drmm_encoder_alloc(ddev, struct tilcdc_encoder, base,
> +				     &tilcdc_encoder_funcs,
> +				     DRM_MODE_ENCODER_NONE, NULL);
>  	if (IS_ERR(encoder)) {
>  		drm_err(ddev, "drm_encoder_init() failed %pe\n", encoder);
>  		return PTR_ERR(encoder);
> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_plane.c b/drivers/gpu/drm/tilc=
dc/tilcdc_plane.c
> index eb0a5562421f..63d936d8cfc6 100644
> --- a/drivers/gpu/drm/tilcdc/tilcdc_plane.c
> +++ b/drivers/gpu/drm/tilcdc/tilcdc_plane.c
> @@ -4,17 +4,123 @@
>   * Author: Jyri Sarha <jsarha@ti.com>
>   */
> =20
> +#include <linux/pm_runtime.h>
> +
>  #include <drm/drm_atomic.h>
>  #include <drm/drm_atomic_helper.h>
> +#include <drm/drm_atomic_state_readout.h>
> +#include <drm/drm_atomic_state_readout_helper.h>
> +#include <drm/drm_crtc.h>
>  #include <drm/drm_fourcc.h>
>  #include <drm/drm_framebuffer.h>
> +#include <drm/drm_gem_framebuffer_helper.h>
> =20
>  #include "tilcdc_drv.h"
> +#include "tilcdc_regs.h"
> +
> +static const struct drm_framebuffer_funcs tilcdc_plane_readout_fb_funcs =
=3D {
> +	.destroy =3D drm_gem_fb_destroy,
> +};
> +
> +/*
> + * The RASTER_CTRL format bits only encode the pixel depth, not the chan=
nel
> + * order, so the RGB/BGR ambiguity is resolved in favour of the RGB vari=
ant.
> + * The panel wiring decides the actual order, so this only affects the f=
ormat
> + * reported for the adopted framebuffer.
> + */
> +static u32 tilcdc_plane_readout_format(struct drm_device *dev)
> +{
> +	u32 ctrl =3D tilcdc_read(dev, LCDC_RASTER_CTRL_REG);
> +
> +	if (!(ctrl & LCDC_V2_TFT_24BPP_MODE))
> +		return DRM_FORMAT_RGB565;
> +	if (ctrl & LCDC_V2_TFT_24BPP_UNPACK)
> +		return DRM_FORMAT_XRGB8888;
> +	return DRM_FORMAT_RGB888;
> +}
> +
> +static int tilcdc_plane_atomic_readout_state(struct drm_plane *plane,
> +					     struct drm_atomic_sro_state *state,
> +					     struct drm_plane_state *plane_state)
> +{
> +	struct drm_device *dev =3D plane->dev;
> +	const struct drm_format_info *info;
> +	struct drm_crtc_state *crtc_state;
> +	struct drm_framebuffer *fb;
> +	struct drm_crtc *crtc;
> +	unsigned int w, h;
> +	int ret;
> +
> +	pm_runtime_get_sync(dev->dev);
> +
> +	if (!(tilcdc_read(dev, LCDC_RASTER_CTRL_REG) & LCDC_RASTER_ENABLE))
> +		goto out;
> +
> +	if (dev->num_crtcs !=3D 1) {
> +		ret =3D -EINVAL;
> +		goto err;
> +	}
> +	crtc =3D list_first_entry(&dev->mode_config.crtc_list, struct drm_crtc,
> +				head);
> +
> +	crtc_state =3D drm_atomic_sro_get_crtc_state(state, crtc);
> +	if (!crtc_state) {
> +		ret =3D -ENODEV;
> +		goto err;
> +	}
> +
> +	/* The tilcdc primary plane always covers the whole active area. */
> +	w =3D crtc_state->adjusted_mode.hdisplay;
> +	h =3D crtc_state->adjusted_mode.vdisplay;
> +
> +	info =3D drm_format_info(tilcdc_plane_readout_format(dev));
> +	if (!info) {
> +		ret =3D -EINVAL;
> +		goto err;
> +	}
> +
> +	fb =3D kzalloc_obj(*fb);
> +	if (!fb) {
> +		ret =3D -ENOMEM;
> +		goto err;
> +	}
> +	fb->dev =3D dev;
> +	fb->format =3D info;
> +	fb->width =3D w;
> +	fb->height =3D h;
> +	fb->pitches[0] =3D w * (drm_format_info_bpp(info, 0) / 8);
> +	fb->offsets[0] =3D 0;
> +
> +	ret =3D drm_framebuffer_init(dev, fb, &tilcdc_plane_readout_fb_funcs);
> +	if (ret) {
> +		kfree(fb);
> +		goto err;
> +	}
> +
> +	plane_state->fb =3D fb;
> +	plane_state->crtc =3D crtc;
> +	plane_state->src_w =3D w << 16;
> +	plane_state->src_h =3D h << 16;
> +	plane_state->crtc_w =3D w;
> +	plane_state->crtc_h =3D h;
> +
> +	crtc_state->plane_mask |=3D drm_plane_mask(plane);
> +
> +out:
> +	pm_runtime_put_sync(dev->dev);
> +	return 0;
> +
> +err:
> +	pm_runtime_put_sync(dev->dev);
> +	return ret;
> +}
> =20
>  static const struct drm_plane_funcs tilcdc_plane_funcs =3D {
>  	.update_plane	=3D drm_atomic_helper_update_plane,
>  	.disable_plane	=3D drm_atomic_helper_disable_plane,
>  	.atomic_create_state =3D drm_atomic_helper_plane_create_state,
> +	.atomic_sro_readout_state =3D tilcdc_plane_atomic_readout_state,
> +	.atomic_sro_compare_state =3D drm_atomic_helper_plane_compare_state,
>  	.atomic_duplicate_state =3D drm_atomic_helper_plane_duplicate_state,
>  	.atomic_destroy_state =3D drm_atomic_helper_plane_destroy_state,
>  };
> --=20
> 2.39.5
>=20

--zrdb4uywdzhprt7d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJQEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCavs5kQAKCRAnX84Zoj2+
duUvAXi09VQWAyx1n6sc+WYu3FXqdnVIuNuo4JFssmhyv1zDTAal/OIxP4QLC0WV
FFKmEAF+MT8nWKWkMGFON5slaFpHeQRCHhDT01LD8DoQ7Zg1FqymE8DAy/2J7n4/
aS17XRky
=18jz
-----END PGP SIGNATURE-----

--zrdb4uywdzhprt7d--
