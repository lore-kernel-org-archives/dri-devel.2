Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FCF606A330
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 14:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vvt8oMCD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAF6A10F6A6;
	Tue, 24 Nov 2026 14:50:10 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2A2D10F6A6
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 14:50:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C74E761F1E;
 Tue, 24 Nov 2026 14:50:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 502401F000D4;
 Tue, 24 Nov 2026 14:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795531800;
 bh=7yeF8WdjtKrHytSHn/g+PFK2ECdzaDd17tYw1BLOy2w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Vvt8oMCD2gnXKtZs3eSjul4ccG91Cx0kAsPZZ9oX0nKheCNcNAtqylO3MUxrNs/kG
 HUggXCfGxoU1EcUSwaYIKUgeIJpiTbHBgQFPo/nEArCZOc3olRRq1MTgBkmRntkgaD
 1rhKBwc+OpAGgHCZtGcKOFO5Hrg4u666h1IJurhRgfpzTR+NLRf1oYPM91QFWCocUY
 XIe0QlK/Z2IDqMxZt68KEBdiht7Hz+HBLoKvKmt7VisFy0eHZlyJhFtf1IQG4QzKBf
 qKNMrHBgej7KwZRimx7wuWQaJ2YJKJwnzXF6qXe3K6hXREe6FI56xCkWeRYg94uWit
 5DKiN6AZbe2aQ==
Message-ID: <sashiko-outbox-231373@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 1/2] drm/tilcdc: Implement state readout support
To: =?utf-8?b?TcOgeGltIFBlZHJhemEgUGFkaWxsYQ==?= <maximpedraza@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261124141908.443764-2-maximpedraza@gmail.com>
References: <20261124141908.443764-1-maximpedraza@gmail.com>
 <20261124141908.443764-2-maximpedraza@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 14:49:59 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential
issues to consider:
- [High] drm/tilcdc: atomic commit failure on readout fb without custom
  prepare_fb
- [High] drm/tilcdc: tilcdc_encoder_get_current_crtc() returns CRTC when
  raster is off
- [High] drm/tilcdc: missing DRM atomic state readout headers and
  symbols
- [Medium] drm/tilcdc: uninitialized stack mode and stale crtc_hskew in
  readout
- [Medium] drm/tilcdc: probe error after tilcdc_crtc_install_state()
  accesses unmapped MMIO
--

commit 971a5ab17852dfc54b7fed700c69635bf4fd3c19
Author: M=C3=A0xim Pedraza Padilla <maximpedraza@gmail.com>

drm/tilcdc: Implement state readout support

This commit implements DRM atomic state readout for tilcdc to reconstruct
the initial KMS mode, CRTC state, and primary plane framebuffer from the
LCDC raster registers when the bootloader leaves the display active.

> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c b/drivers/gpu/drm/tilcd=
c/tilcdc_crtc.c
> index f619b7a6e70d9..7040172b1a0db 100644
> --- a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
> +++ b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c

[ ... ]

> @@ -711,10 +716,204 @@ static void tilcdc_crtc_hw_reset(struct drm_crtc *=
crtc)

[ ... ]

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

[Severity: Medium]
Does drm_mode_copy(&mode, &adjusted) leave mode.head uninitialized on the
stack?

drm_mode_copy() saves and restores dst->head, which is later read by
memcmp(&state->mode, mode, sizeof(*mode)) in drm_atomic_set_mode_for_crtc().
Using drm_mode_init(&mode, &adjusted) would zero mode.head for the
on-stack mode.

Also, tilcdc_crtc_readout_mode() calls drm_mode_set_crtcinfo(&adjusted, 0)
while hskew is hsw, so clearing mode.hskew =3D 0 afterwards leaves
mode.crtc_hskew set to hsw unless mode.crtc_hskew is cleared or
drm_mode_set_crtcinfo(&mode, 0) is called again.

[ ... ]

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

[Severity: Medium]
What happens if drm_dev_register() fails in tilcdc_pdev_probe() after
tilcdc_crtc_install_state() has marked the CRTC enabled and taken a
runtime PM reference?

Before this change, drm_mode_config_reset() stopped the raster and left
tilcdc_crtc->enabled false during probe.  With state readout adopting an
active CRTC during drm_mode_config_reset(), a failure in drm_dev_register()
jumps to stop_poll, which uninstalls the IRQ, disables runtime PM while
the CRTC's runtime PM reference is still held, and destroys priv->wq.
When devres then cleans up in reverse order, priv->mmio is unmapped before
the drmm action tilcdc_crtc_destroy() calls tilcdc_crtc_shutdown() ->
tilcdc_crtc_off(), accessing unmapped MMIO registers and flushing the
destroyed workqueue.

> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc=
/tilcdc_drv.c
> index 1d6c9a423a410..53658fc8b1b2e 100644
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
> @@ -75,6 +77,13 @@ static const struct drm_mode_config_funcs mode_config_=
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
> +	.atomic_sro_install_state =3D drm_atomic_helper_sro_install_state,
>  };

[Severity: High]
Does this depend on an unmerged DRM atomic state readout series?

Neither drm/drm_atomic_state_readout.h nor
drm/drm_atomic_state_readout_helper.h exists in the tree, and the
atomic_sro_* callbacks, types, and helpers used across tilcdc_drv.c,
tilcdc_crtc.c, tilcdc_encoder.c, and tilcdc_plane.c are undeclared, so
CONFIG_DRM_TILCDC fails to build.

> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_encoder.c b/drivers/gpu/drm/ti=
lcdc/tilcdc_encoder.c
> index ac4b5beb2dd58..b3fe18f69f174 100644
> --- a/drivers/gpu/drm/tilcdc/tilcdc_encoder.c
> +++ b/drivers/gpu/drm/tilcdc/tilcdc_encoder.c

[ ... ]

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

[Severity: High]
Should tilcdc_encoder_get_current_crtc() return NULL when LCDC_RASTER_ENABLE
is not set?

When the raster is disabled at boot or after a commit disables the CRTC,
tilcdc_crtc_readout_state() and tilcdc_plane_atomic_readout_state() read
out the CRTC and plane as disabled, while tilcdc_encoder_get_current_crtc()
still returns the CRTC.  That links the connector and encoder to a CRTC
whose crtc_state->enable is false, producing an invalid atomic state and
failing post-commit state readout comparisons when the CRTC is disabled.

> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_plane.c b/drivers/gpu/drm/tilc=
dc/tilcdc_plane.c
> index eb0a5562421fd..f710310cece20 100644
> --- a/drivers/gpu/drm/tilcdc/tilcdc_plane.c
> +++ b/drivers/gpu/drm/tilcdc/tilcdc_plane.c

[ ... ]

> +	rfb =3D kzalloc_obj(*rfb);
> +	if (!rfb) {
> +		ret =3D -ENOMEM;
> +		goto err;
> +	}
> +	rfb->dma_addr =3D tilcdc_read(dev, LCDC_DMA_FB_BASE_ADDR_0_REG);
> +	fb =3D &rfb->base;
> +	fb->dev =3D dev;
> +	fb->format =3D info;
> +	fb->width =3D w;
> +	fb->height =3D h;
> +	fb->pitches[0] =3D w * (drm_format_info_bpp(info, 0) / 8);
> +	fb->offsets[0] =3D 0;
> +
> +	ret =3D drm_framebuffer_init(dev, fb, &tilcdc_plane_readout_fb_funcs);
> +	if (ret) {
> +		kfree(rfb);
> +		goto err;
> +	}

[Severity: High]
Will atomic commits that keep the readout framebuffer fail in
drm_atomic_helper_prepare_planes()?

Because rfb has no backing GEM object, fb->obj[0] is NULL.  tilcdc sets
DRIVER_GEM and leaves plane_helper_funcs.prepare_fb NULL, so any commit
that includes the primary plane without replacing rfb (such as disabling
and re-enabling the CRTC, or system suspend/resume) calls
drm_gem_plane_helper_prepare_fb() -> drm_gem_fb_get_obj(), which triggers
drm_WARN_ON_ONCE(dev, !fb->obj[plane]) and fails the commit with -EINVAL
before set_scanout() is reached.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124141908.4437=
64-1-maximpedraza@gmail.com?part=3D1
