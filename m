Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9CC606A32A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 11:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M+M3OK3d
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1D0910E4A3;
	Mon, 23 Nov 2026 11:07:33 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0BB910E4A3
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 11:07:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 562F4409D3;
 Mon, 23 Nov 2026 11:07:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F32D1F000E6;
 Mon, 23 Nov 2026 11:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795432047;
 bh=DKHpltpuTjnnQLiZ/Ai1c8nmsECa5rHnQiL1XcqN74w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=M+M3OK3df9XMgE4aQ+VKLf8xE0ss0pkbKppEeIcMwkJv8E7Du39WwQOV7MK64bgLb
 h4qADtTOsAlbeudZ59Ue6QwvtqT604pETsN7Y3gVLQyEcfS+KCXPxxUbIjCqpNcQzL
 YCuurPECD0Bxg2e6xZNV2Z6v+285EMPyogkWFn5ItKnNwf6+2vPbvEyNDlWiW4jl+l
 jQGO4cBsdgs98IYxwsTvRvmXjmxOYR60+civnPQp34IJ7RL3vAu/Mc2d/P3tN0leqL
 TjNlMRShjE4DT4tgKC1f0n2HBo6f28IopvQ+2gsxMJ47CiIQCkcTsD/8fShu1Ql10N
 CeFPPdpmf8MAw==
Date: Mon, 23 Nov 2026 12:07:24 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: michael@amarulasolutions.com, linux-amarula@amarulasolutions.com, 
 David Airlie <airlied@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Frank Li <Frank.Li@nxp.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Marek Vasut <marex@denx.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Simona Vetter <simona@ffwll.ch>, Stefan Agner <stefan@agner.ch>, 
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 6/8] drm/mxsfb: Implement hw state readout
Message-ID: <awQdObBL6kNzvBnj@houat>
References: <20261122153032.2782768-1-dario.binacchi@amarulasolutions.com>
 <20261122153032.2782768-7-dario.binacchi@amarulasolutions.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="x5h4dpsvgdc5hplh"
Content-Disposition: inline
In-Reply-To: <20261122153032.2782768-7-dario.binacchi@amarulasolutions.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--x5h4dpsvgdc5hplh
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH 6/8] drm/mxsfb: Implement hw state readout
MIME-Version: 1.0

On Sun, Nov 22, 2026 at 04:30:06PM +0100, Dario Binacchi wrote:
> +/* The overlay plane starts 64 bytes within the framebuffer */
> +#define MXSFB_AS_BUF_OFFSET	64
> +
> +/* Framebuffer read out from the hardware, without a GEM object */
> +struct mxsfb_readout_fb {
> +	struct drm_framebuffer base;
> +	dma_addr_t dma_addr;
> +};

It's not clear to me why you need to store dma_addr (and thus roll your
own framebuffer structure). Can you expand on that?

> +static void mxsfb_readout_fb_destroy(struct drm_framebuffer *fb)
> +{
> +	drm_framebuffer_cleanup(fb);
> +	kfree(container_of(fb, struct mxsfb_readout_fb, base));
> +}
> +
> +static const struct drm_framebuffer_funcs mxsfb_readout_fb_funcs =3D {
> +	.destroy =3D mxsfb_readout_fb_destroy,
> +};
> +
> +static dma_addr_t mxsfb_plane_get_dma_addr(struct drm_plane_state *pstat=
e)
> +{
> +	struct drm_framebuffer *fb =3D pstate->fb;
> +
> +	if (fb->funcs =3D=3D &mxsfb_readout_fb_funcs)
> +		return container_of(fb, struct mxsfb_readout_fb,
> +				    base)->dma_addr;
> +
> +	return drm_fb_dma_get_gem_addr(fb, pstate, 0);
> +}
> +
>  /* ---------------------------------------------------------------------=
--------
>   * CRTC
>   */
> @@ -418,7 +452,7 @@ static void mxsfb_crtc_atomic_enable(struct drm_crtc =
*crtc,
>  	mxsfb_crtc_mode_set_nofb(mxsfb, bridge_state, bus_format);
> =20
>  	/* Write cur_buf as well to avoid an initial corrupt frame */
> -	dma_addr =3D drm_fb_dma_get_gem_addr(new_pstate->fb, new_pstate, 0);
> +	dma_addr =3D mxsfb_plane_get_dma_addr(new_pstate);
>  	if (dma_addr) {
>  		writel(dma_addr, mxsfb->base + mxsfb->devdata->cur_buf);
>  		writel(dma_addr, mxsfb->base + mxsfb->devdata->next_buf);
> @@ -463,6 +497,114 @@ static void mxsfb_crtc_hw_reset(struct drm_crtc *cr=
tc)
>  	mxsfb_hw_put(mxsfb);
>  }
> =20
> +static bool mxsfb_is_running(struct mxsfb_drm_private *mxsfb)
> +{
> +	u32 mask =3D CTRL_RUN | CTRL_DOTCLK_MODE;
> +
> +	/* A controller being stopped keeps running until the end of frame */
> +	return (readl(mxsfb->base + LCDC_CTRL) & mask) =3D=3D mask;
> +}
> +
> +static int mxsfb_readout_mode(struct mxsfb_drm_private *mxsfb,
> +			      struct drm_display_mode *mode)
> +{
> +	const struct mxsfb_devdata *devdata =3D mxsfb->devdata;
> +	u32 ctrl, vdctrl0, vdctrl2, vdctrl3, reg;
> +	u16 hsync_len, vsync_len;
> +
> +	ctrl =3D readl(mxsfb->base + LCDC_CTRL);
> +	if (!(ctrl & CTRL_DOTCLK_MODE) || !(ctrl & CTRL_MASTER))
> +		return -EINVAL;
> +
> +	vdctrl0 =3D readl(mxsfb->base + LCDC_VDCTRL0);
> +	if (!(vdctrl0 & VDCTRL0_ENABLE_PRESENT) ||
> +	    !(vdctrl0 & VDCTRL0_VSYNC_PERIOD_UNIT) ||
> +	    !(vdctrl0 & VDCTRL0_VSYNC_PULSE_WIDTH_UNIT))
> +		return -EINVAL;
> +
> +	reg =3D readl(mxsfb->base + devdata->transfer_count);
> +	mode->hdisplay =3D TRANSFER_COUNT_GET_HCOUNT(reg);
> +	mode->vdisplay =3D TRANSFER_COUNT_GET_VCOUNT(reg);
> +
> +	mode->vtotal =3D readl(mxsfb->base + LCDC_VDCTRL1);
> +
> +	vdctrl2 =3D readl(mxsfb->base + LCDC_VDCTRL2);
> +	mode->htotal =3D VDCTRL2_GET_HSYNC_PERIOD(vdctrl2);
> +	hsync_len =3D (vdctrl2 >> devdata->hs_wdth_shift) & devdata->hs_wdth_ma=
sk;
> +	vsync_len =3D VDCTRL0_GET_VSYNC_PULSE_WIDTH(vdctrl0);
> +
> +	vdctrl3 =3D readl(mxsfb->base + LCDC_VDCTRL3);
> +	mode->hsync_start =3D mode->htotal - GET_HOR_WAIT_CNT(vdctrl3);
> +	mode->hsync_end =3D mode->hsync_start + hsync_len;
> +	mode->vsync_start =3D mode->vtotal - GET_VERT_WAIT_CNT(vdctrl3);
> +	mode->vsync_end =3D mode->vsync_start + vsync_len;
> +
> +	if (!mode->hdisplay || !mode->vdisplay ||
> +	    mode->hsync_start < mode->hdisplay ||
> +	    mode->vsync_start < mode->vdisplay)
> +		return -EINVAL;
> +
> +	mode->clock =3D DIV_ROUND_CLOSEST(clk_get_rate(mxsfb->clk), 1000);

Just like the other discussion for tilcdc, you need to be more flexible
than that and take clock rounding into account. We have a function to do
that for tidss, dispc_find_closest_refresh_rate_from_clk(), that would
be useful as a helper.

> +	/* An active low sync signal can't be told from an unspecified one */
> +	if (vdctrl0 & VDCTRL0_HSYNC_ACT_HIGH)
> +		mode->flags |=3D DRM_MODE_FLAG_PHSYNC;
> +	if (vdctrl0 & VDCTRL0_VSYNC_ACT_HIGH)
> +		mode->flags |=3D DRM_MODE_FLAG_PVSYNC;
> +
> +	mode->type |=3D DRM_MODE_TYPE_DRIVER;
> +	drm_mode_set_name(mode);
> +	drm_mode_set_crtcinfo(mode, 0);
> +
> +	return 0;
> +}
> +
> +static int mxsfb_crtc_readout_state(struct drm_crtc *crtc,
> +				    struct drm_atomic_sro_state *state,
> +				    struct drm_crtc_state *crtc_state)
> +{
> +	struct mxsfb_drm_private *mxsfb =3D to_mxsfb_drm_private(crtc->dev);
> +	struct drm_display_mode mode =3D {};
> +	int ret =3D 0;
> +
> +	mxsfb_hw_get(mxsfb);
> +
> +	if (!mxsfb_is_running(mxsfb))
> +		goto out;
> +
> +	ret =3D mxsfb_readout_mode(mxsfb, &mode);
> +	if (ret)
> +		goto out;
> +
> +	ret =3D drm_atomic_set_mode_for_crtc(crtc_state, &mode);
> +	if (ret)
> +		goto out;
> +
> +	drm_mode_copy(&crtc_state->adjusted_mode, &mode);
> +	crtc_state->active =3D true;
> +
> +out:
> +	mxsfb_hw_put(mxsfb);
> +	return ret;
> +}
> +
> +static void mxsfb_crtc_install_state(struct drm_crtc *crtc,
> +				     struct drm_crtc_state *crtc_state)
> +{
> +	struct mxsfb_drm_private *mxsfb =3D to_mxsfb_drm_private(crtc->dev);
> +
> +	if (!crtc_state->active)
> +		return;
> +
> +	/* Take the references mxsfb_crtc_atomic_enable() would have taken */
> +	mxsfb_hw_get(mxsfb);
> +	if (mxsfb->clk_disp_axi)
> +		clk_prepare_enable(mxsfb->clk_disp_axi);
> +	clk_prepare_enable(mxsfb->clk);
> +
> +	drm_crtc_vblank_on(crtc);
> +}
> +
>  static int mxsfb_crtc_enable_vblank(struct drm_crtc *crtc)
>  {
>  	struct mxsfb_drm_private *mxsfb =3D to_mxsfb_drm_private(crtc->dev);
> @@ -535,6 +677,9 @@ static const struct drm_crtc_funcs mxsfb_crtc_funcs =
=3D {
>  	.atomic_destroy_state =3D drm_atomic_helper_crtc_destroy_state,
>  	.enable_vblank =3D mxsfb_crtc_enable_vblank,
>  	.disable_vblank =3D mxsfb_crtc_disable_vblank,
> +	.atomic_sro_readout_state =3D mxsfb_crtc_readout_state,
> +	.atomic_sro_install_state =3D mxsfb_crtc_install_state,
> +	.atomic_sro_compare_state =3D drm_atomic_helper_crtc_compare_state,
>  };
> =20
>  static const struct drm_crtc_funcs mxsfb_crtc_with_crc_funcs =3D {
> @@ -546,6 +691,9 @@ static const struct drm_crtc_funcs mxsfb_crtc_with_cr=
c_funcs =3D {
>  	.atomic_destroy_state =3D drm_atomic_helper_crtc_destroy_state,
>  	.enable_vblank =3D mxsfb_crtc_enable_vblank,
>  	.disable_vblank =3D mxsfb_crtc_disable_vblank,
> +	.atomic_sro_readout_state =3D mxsfb_crtc_readout_state,
> +	.atomic_sro_install_state =3D mxsfb_crtc_install_state,
> +	.atomic_sro_compare_state =3D drm_atomic_helper_crtc_compare_state,
>  	.set_crc_source =3D mxsfb_crtc_set_crc_source,
>  	.verify_crc_source =3D mxsfb_crtc_verify_crc_source,
>  };
> @@ -554,8 +702,17 @@ static const struct drm_crtc_funcs mxsfb_crtc_with_c=
rc_funcs =3D {
>   * Encoder
>   */
> =20
> +static struct drm_crtc *
> +mxsfb_encoder_get_current_crtc(struct drm_encoder *encoder)
> +{
> +	struct mxsfb_drm_private *mxsfb =3D to_mxsfb_drm_private(encoder->dev);
> +
> +	return &mxsfb->crtc;
> +}
> +
>  static const struct drm_encoder_funcs mxsfb_encoder_funcs =3D {
>  	.destroy =3D drm_encoder_cleanup,
> +	.atomic_sro_get_current_crtc =3D mxsfb_encoder_get_current_crtc,
>  };
> =20
>  /* ---------------------------------------------------------------------=
--------
> @@ -587,7 +744,7 @@ static void mxsfb_plane_primary_atomic_update(struct =
drm_plane *plane,
>  									    plane);
>  	dma_addr_t dma_addr;
> =20
> -	dma_addr =3D drm_fb_dma_get_gem_addr(new_pstate->fb, new_pstate, 0);
> +	dma_addr =3D mxsfb_plane_get_dma_addr(new_pstate);
>  	if (dma_addr)
>  		writel(dma_addr, mxsfb->base + mxsfb->devdata->next_buf);
>  }
> @@ -603,7 +760,7 @@ static void mxsfb_plane_overlay_atomic_update(struct =
drm_plane *plane,
>  	dma_addr_t dma_addr;
>  	u32 ctrl;
> =20
> -	dma_addr =3D drm_fb_dma_get_gem_addr(new_pstate->fb, new_pstate, 0);
> +	dma_addr =3D mxsfb_plane_get_dma_addr(new_pstate);
>  	if (!dma_addr) {
>  		writel(0, mxsfb->base + LCDC_AS_CTRL);
>  		return;
> @@ -615,7 +772,7 @@ static void mxsfb_plane_overlay_atomic_update(struct =
drm_plane *plane,
>  	 * is understood, live with the 16 initial invalid pixels on the first
>  	 * line and start 64 bytes within the framebuffer.
>  	 */
> -	dma_addr +=3D 64;
> +	dma_addr +=3D MXSFB_AS_BUF_OFFSET;
> =20
>  	writel(dma_addr, mxsfb->base + LCDC_AS_NEXT_BUF);
> =20
> @@ -663,6 +820,182 @@ static void mxsfb_plane_overlay_atomic_disable(stru=
ct drm_plane *plane,
>  	writel(0, mxsfb->base + LCDC_AS_CTRL);
>  }
> =20
> +static int mxsfb_plane_readout_state(struct drm_plane *plane,
> +				     struct drm_atomic_sro_state *state,
> +				     struct drm_plane_state *plane_state,
> +				     u32 format, dma_addr_t dma_addr)
> +{
> +	struct mxsfb_drm_private *mxsfb =3D to_mxsfb_drm_private(plane->dev);
> +	struct drm_crtc *crtc =3D &mxsfb->crtc;
> +	struct drm_crtc_state *crtc_state;
> +	struct mxsfb_readout_fb *rfb;
> +	struct drm_framebuffer *fb;
> +	u32 reg;
> +	int ret;
> +
> +	crtc_state =3D drm_atomic_sro_get_crtc_state(state, crtc);
> +	if (!crtc_state)
> +		return -ENODEV;
> +
> +	rfb =3D kzalloc_obj(*rfb);
> +	if (!rfb)
> +		return -ENOMEM;
> +
> +	/* The planes can be neither scaled nor positioned */
> +	reg =3D readl(mxsfb->base + mxsfb->devdata->transfer_count);
> +
> +	rfb->dma_addr =3D dma_addr;
> +	fb =3D &rfb->base;
> +	fb->dev =3D plane->dev;
> +	fb->format =3D drm_format_info(format);
> +	fb->width =3D TRANSFER_COUNT_GET_HCOUNT(reg);
> +	fb->height =3D TRANSFER_COUNT_GET_VCOUNT(reg);
> +	fb->pitches[0] =3D fb->width * fb->format->cpp[0];
> +
> +	ret =3D drm_framebuffer_init(plane->dev, fb, &mxsfb_readout_fb_funcs);
> +	if (ret) {
> +		kfree(rfb);
> +		return ret;
> +	}
> +
> +	plane_state->fb =3D fb;
> +	plane_state->crtc =3D crtc;
> +	plane_state->visible =3D true;
> +	plane_state->crtc_w =3D fb->width;
> +	plane_state->crtc_h =3D fb->height;
> +	plane_state->src_w =3D fb->width << 16;
> +	plane_state->src_h =3D fb->height << 16;
> +	plane_state->src.x2 =3D plane_state->src_w;
> +	plane_state->src.y2 =3D plane_state->src_h;
> +	plane_state->dst.x2 =3D plane_state->crtc_w;
> +	plane_state->dst.y2 =3D plane_state->crtc_h;
> +
> +	crtc_state->plane_mask |=3D drm_plane_mask(plane);
> +
> +	return 0;
> +}
> +
> +static int
> +mxsfb_plane_primary_readout_state(struct drm_plane *plane,
> +				  struct drm_atomic_sro_state *state,
> +				  struct drm_plane_state *plane_state)
> +{
> +	struct mxsfb_drm_private *mxsfb =3D to_mxsfb_drm_private(plane->dev);
> +	u32 ctrl, ctrl1, format;
> +	dma_addr_t dma_addr;
> +	int ret =3D 0;
> +
> +	mxsfb_hw_get(mxsfb);
> +
> +	if (!mxsfb_is_running(mxsfb))
> +		goto out;
> +
> +	ctrl =3D readl(mxsfb->base + LCDC_CTRL);
> +	ctrl1 =3D readl(mxsfb->base + LCDC_CTRL1);
> +
> +	switch (ctrl & CTRL_WORD_LENGTH_MASK) {
> +	case CTRL_WORD_LENGTH_16:
> +		format =3D DRM_FORMAT_RGB565;
> +		break;
> +	case CTRL_WORD_LENGTH_24:
> +		/* Packed pixels are not supported */
> +		if (CTRL1_GET_BYTE_PACKAGING(ctrl1) =3D=3D 0x7) {
> +			format =3D DRM_FORMAT_XRGB8888;
> +			break;
> +		}
> +		fallthrough;
> +	default:
> +		ret =3D -EINVAL;
> +		goto out;
> +	}
> +
> +	dma_addr =3D readl(mxsfb->base + mxsfb->devdata->next_buf);
> +	ret =3D mxsfb_plane_readout_state(plane, state, plane_state, format,
> +					dma_addr);
> +
> +out:
> +	mxsfb_hw_put(mxsfb);
> +	return ret;
> +}
> +
> +static int
> +mxsfb_plane_overlay_readout_state(struct drm_plane *plane,
> +				  struct drm_atomic_sro_state *state,
> +				  struct drm_plane_state *plane_state)
> +{
> +	struct mxsfb_drm_private *mxsfb =3D to_mxsfb_drm_private(plane->dev);
> +	dma_addr_t dma_addr;
> +	u32 ctrl, format;
> +	bool alpha;
> +	int ret =3D 0;
> +
> +	mxsfb_hw_get(mxsfb);
> +
> +	if (!mxsfb_is_running(mxsfb))
> +		goto out;
> +
> +	ctrl =3D readl(mxsfb->base + LCDC_AS_CTRL);
> +	if (!(ctrl & AS_CTRL_AS_ENABLE))
> +		goto out;
> +
> +	alpha =3D (ctrl & AS_CTRL_ALPHA_CTRL_MASK) =3D=3D AS_CTRL_ALPHA_CTRL_EM=
BEDDED;
> +
> +	switch (ctrl & AS_CTRL_FORMAT_MASK) {
> +	case AS_CTRL_FORMAT_RGB444:
> +		format =3D DRM_FORMAT_XRGB4444;
> +		break;
> +	case AS_CTRL_FORMAT_ARGB4444:
> +		format =3D DRM_FORMAT_ARGB4444;
> +		break;
> +	case AS_CTRL_FORMAT_RGB555:
> +		format =3D DRM_FORMAT_XRGB1555;
> +		break;
> +	case AS_CTRL_FORMAT_ARGB1555:
> +		format =3D DRM_FORMAT_ARGB1555;
> +		break;
> +	case AS_CTRL_FORMAT_RGB565:
> +		format =3D DRM_FORMAT_RGB565;
> +		break;
> +	case AS_CTRL_FORMAT_RGB888:
> +		format =3D DRM_FORMAT_XRGB8888;
> +		break;
> +	case AS_CTRL_FORMAT_ARGB8888:
> +		format =3D DRM_FORMAT_ARGB8888;
> +		break;
> +	default:
> +		ret =3D -EINVAL;
> +		goto out;
> +	}
> +
> +	if (alpha !=3D drm_format_info(format)->has_alpha) {
> +		ret =3D -EINVAL;
> +		goto out;
> +	}
> +
> +	dma_addr =3D readl(mxsfb->base + LCDC_AS_NEXT_BUF) - MXSFB_AS_BUF_OFFSE=
T;
> +	ret =3D mxsfb_plane_readout_state(plane, state, plane_state, format,
> +					dma_addr);
> +
> +out:
> +	mxsfb_hw_put(mxsfb);
> +	return ret;
> +}
> +
> +static bool mxsfb_plane_compare_state(struct drm_plane *plane,
> +				      struct drm_printer *p,
> +				      struct drm_plane_state *expected,
> +				      struct drm_plane_state *actual)
> +{
> +	struct drm_crtc *crtc =3D expected->crtc;
> +
> +	/* The planes can't be read out while the controller is stopped */
> +	if (crtc && !crtc->state->active && !actual->fb)
> +		return true;

That one should be fixed in v9, and you can use the helper directly.

Maxime

--x5h4dpsvgdc5hplh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCawQeawAKCRAnX84Zoj2+
duMBAYDffQpP5knPNYl28GwB6FLsLf/BVXvnBYmd4awIpFVuCPBpBSeon7rvbmAE
55yz6nEBgL5O/59/ca3Iw9p3T10Z8wOBycf2wdUBTsBXzDz1HWhoOK+iiYact5GI
6RJdzCCTiw==
=4td7
-----END PGP SIGNATURE-----

--x5h4dpsvgdc5hplh--
