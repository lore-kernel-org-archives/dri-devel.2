Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF923CD98C5
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 21:22:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 140D410E1DF;
	Wed, 10 Jun 2026 21:22:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="RvJBQda/";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9DE910E1DF
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 21:22:37 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id C49946DF;
 Wed, 10 Jun 2026 23:22:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1781126527;
 bh=E2+6uUwceDBbDTMJpVePzuCtqucnkDmk3KU2p2VCqw0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RvJBQda/9pjI65Pxze53N/t3dA+FUumF0Ihbj9yvXbQgzpa+RjCxoRs1cRuFdKD68
 GGlQLjzws0JqcMhdwEpcXbwswav8sW6jK05xyr9bapz4HC2Uk0m0LyvuAEkQYNC6OO
 bRNPUQG6PD51E1WC5/hR/D9acBLfQdrYmVHpvYSE=
Date: Thu, 11 Jun 2026 00:22:34 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: tomm.merciai@gmail.com, geert@linux-m68k.org,
 linux-renesas-soc@vger.kernel.org, biju.das.jz@bp.renesas.com,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v5 14/20] drm: renesas: rz-du: Add RZ/G3E support
Message-ID: <20260610212234.GA1632628@killaraus.ideasonboard.com>
References: <cover.1770996493.git.tommaso.merciai.xr@bp.renesas.com>
 <152f19a068fcdf27c063e845fe04a48a46c5b47e.1770996493.git.tommaso.merciai.xr@bp.renesas.com>
 <abq6ohQW-LPcmXgy@tom-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abq6ohQW-LPcmXgy@tom-desktop>
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Hi Tommaso,

On Wed, Mar 18, 2026 at 03:45:54PM +0100, Tommaso Merciai wrote:
> On Fri, Feb 13, 2026 at 05:27:40PM +0100, Tommaso Merciai wrote:
> > The RZ/G3E Soc has 2 LCD controller (LCDC), contain a Frame Compression
> > Processor (FCPVD), a Video Signal Processor (VSPD), Video Signal
> > Processor (VSPD), and Display Unit (DU).
> > 
> > LCDC0 supports DSI and LVDS (single or dual-channel) outputs.
> > LCDC1 supports DSI, LVDS (single-channel), and RGB outputs.
> > 
> > Depending on the selected output, the correct SMUX2 clock parent must be
> > chosen based on the requested duty cycle:
> > 
> >  - Index 0 for LVDS -> CDIV7_DSIx_CLK (DUTY H/L=4/3, 4/7 duty cycle)
> >  - Index 1 for DSI/DPAD -> CSDIV_2to16_PLLDSIx (symmetric 50% duty cycle)
> > 
> > To support this behavior, introduce the `RZG2L_DU_FEATURE_SMUX2_DSI_CLK`
> > feature flag and extend the `rzg2l_du_device_info` structure to include a
> > features field. Also, add a new helper function `rzg2l_du_has()` to check
> > for feature flags.
> > 
> > Add support for the RZ/G3E SoC by introducing:
> >  - `rzg2l_du_r9a09g047_du_info` structure
> >  - The `renesas,r9a09g047-du` compatible string
> > 
> > Additionally, introduce the missing output definitions
> > `RZG2L_DU_OUTPUT_LVDS{0,1}`.
> > 
> > Introduce `rzg2l_du_crtc_atomic_check()` helper to store the routes from
> > the CRTC output to the DU outputs.
> > 
> > Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > ---
> > v4->v5:
> >  - Fixed RG2L_DU_FEATURE_SMUX2_DSI_CLK to RZG2L_DU_FEATURE_SMUX2_DSI_CLK,
> >    update commit body accordingly.
> >  - Added features field documentation.
> > 
> > v3->v4:
> >  - No changes.
> > 
> > v2->v3:
> >  - No changes.
> > 
> > v1->v2:
> >  - Instead of using clk-provider API to select the right parent clock,
> >    based on the outputs. Just set the correct duty cycle based on the
> >    output, this reflects at CPG lvl to select the right parent.
> >  - Updated commit message accordingly.
> > 
> >  drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c | 48 +++++++++++++++++++
> >  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c  | 26 ++++++++++
> >  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h  | 12 +++++
> >  3 files changed, 86 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
> > index 6e7aac6219be..cc35dd409e3e 100644
> > --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
> > +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
> > @@ -64,11 +64,32 @@
> >  static void rzg2l_du_crtc_set_display_timing(struct rzg2l_du_crtc *rcrtc)
> >  {
> >  	const struct drm_display_mode *mode = &rcrtc->crtc.state->adjusted_mode;
> > +	struct rzg2l_du_crtc_state *rstate =
> > +		to_rzg2l_crtc_state(rcrtc->crtc.state);
> >  	unsigned long mode_clock = mode->clock * 1000;
> >  	u32 ditr0, ditr1, ditr2, ditr3, ditr4, pbcr0;
> >  	struct rzg2l_du_device *rcdu = rcrtc->dev;
> >  
> >  	clk_prepare_enable(rcrtc->rzg2l_clocks.dclk);
> > +
> > +	if (rzg2l_du_has(rcdu, RZG2L_DU_FEATURE_SMUX2_DSI_CLK)) {
> > +		struct clk *clk_parent;
> > +
> > +		clk_parent = clk_get_parent(rcrtc->rzg2l_clocks.dclk);
> > +
> > +		/*
> > +		 * Request appropriate duty cycle to let clock driver select
> > +		 * the correct parent:
> > +		 * - CDIV7_DSIx_CLK (LVDS path) has DUTY H/L=4/3, 4/7 duty cycle.
> > +		 * - CSDIV_2to16_PLLDSIx (DSI/RGB path) has symmetric 50% duty cycle.
> > +		 */
> > +		if (rstate->outputs == BIT(RZG2L_DU_OUTPUT_LVDS0) ||
> > +		    rstate->outputs == BIT(RZG2L_DU_OUTPUT_LVDS1))
> > +			clk_set_duty_cycle(clk_parent, 4, 7);
> > +		else
> > +			clk_set_duty_cycle(clk_parent, 1, 2);
> > +	}
> > +
> 
> I’d appreciate any feedback/suggestions regarding this.
> Thank you in advance for your time.

Sorry for the very late reply.

I've taken time to analyse the clock tree, and I think the way you model
it makes sense. As the SMUX2_DSI[01]_CLK clocks are used by the LCD,
LVDS and DSI blocks, I may have selected the duty cycle in the LVDS and
DSI drivers personally. I wonder if it would lead to simpler code (you
wouldn't need to implement rzg2l_du_crtc_atomic_check()) here for
instance. In any case, it does not affect the DT bindings, so it could
be changed later too.

Do you need further feedback on this ?

> FYI this commit is related to [0]
> 
> [0] https://patchwork.kernel.org/project/linux-renesas-soc/patch/53c8d9e7fde7b176e05503a72af81e74c7a8a1c1.1770996493.git.tommaso.merciai.xr@bp.renesas.com/
> 
> Kind Regards,
> Tommaso
> 
> >  	clk_set_rate(rcrtc->rzg2l_clocks.dclk, mode_clock);
> >  
> >  	ditr0 = (DU_DITR0_DEMD_HIGH
> > @@ -248,6 +269,32 @@ static void rzg2l_du_crtc_stop(struct rzg2l_du_crtc *rcrtc)
> >   * CRTC Functions
> >   */
> >  
> > +static int rzg2l_du_crtc_atomic_check(struct drm_crtc *crtc,
> > +				      struct drm_atomic_state *state)
> > +{
> > +	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state,
> > +									  crtc);
> > +	struct rzg2l_du_crtc_state *rstate = to_rzg2l_crtc_state(crtc_state);
> > +	struct drm_encoder *encoder;
> > +
> > +	/* Store the routes from the CRTC output to the DU outputs. */
> > +	rstate->outputs = 0;
> > +
> > +	drm_for_each_encoder_mask(encoder, crtc->dev,
> > +				  crtc_state->encoder_mask) {
> > +		struct rzg2l_du_encoder *renc;
> > +
> > +		/* Skip the writeback encoder. */
> > +		if (encoder->encoder_type == DRM_MODE_ENCODER_VIRTUAL)
> > +			continue;
> > +
> > +		renc = to_rzg2l_encoder(encoder);
> > +		rstate->outputs |= BIT(renc->output);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static void rzg2l_du_crtc_atomic_enable(struct drm_crtc *crtc,
> >  					struct drm_atomic_state *state)
> >  {
> > @@ -296,6 +343,7 @@ static void rzg2l_du_crtc_atomic_flush(struct drm_crtc *crtc,
> >  }
> >  
> >  static const struct drm_crtc_helper_funcs crtc_helper_funcs = {
> > +	.atomic_check = rzg2l_du_crtc_atomic_check,
> >  	.atomic_flush = rzg2l_du_crtc_atomic_flush,
> >  	.atomic_enable = rzg2l_du_crtc_atomic_enable,
> >  	.atomic_disable = rzg2l_du_crtc_atomic_disable,
> > diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > index 0fef33a5a089..3c20471fdbea 100644
> > --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > @@ -51,6 +51,29 @@ static const struct rzg2l_du_device_info rzg2l_du_r9a07g044_info = {
> >  	}
> >  };
> >  
> > +static const struct rzg2l_du_device_info rzg2l_du_r9a09g047_du_info = {
> > +	.features = RZG2L_DU_FEATURE_SMUX2_DSI_CLK,
> > +	.channels_mask = BIT(0),
> > +	.routes = {
> > +		[RZG2L_DU_OUTPUT_DSI0] = {
> > +			.possible_outputs = BIT(0),
> > +			.port = 0,
> > +		},
> > +		[RZG2L_DU_OUTPUT_LVDS0] = {
> > +			.possible_outputs = BIT(0),
> > +			.port = 1,
> > +		},
> > +		[RZG2L_DU_OUTPUT_LVDS1] = {
> > +			.possible_outputs = BIT(0),
> > +			.port = 2,
> > +		},
> > +		[RZG2L_DU_OUTPUT_DPAD0] = {
> > +			.possible_outputs = BIT(0),
> > +			.port = 3,
> > +		},
> > +	},
> > +};
> > +
> >  static const struct rzg2l_du_device_info rzg2l_du_r9a09g057_info = {
> >  	.channels_mask = BIT(0),
> >  	.routes = {
> > @@ -64,6 +87,7 @@ static const struct rzg2l_du_device_info rzg2l_du_r9a09g057_info = {
> >  static const struct of_device_id rzg2l_du_of_table[] = {
> >  	{ .compatible = "renesas,r9a07g043u-du", .data = &rzg2l_du_r9a07g043u_info },
> >  	{ .compatible = "renesas,r9a07g044-du", .data = &rzg2l_du_r9a07g044_info },
> > +	{ .compatible = "renesas,r9a09g047-du", .data = &rzg2l_du_r9a09g047_du_info },
> >  	{ .compatible = "renesas,r9a09g057-du", .data = &rzg2l_du_r9a09g057_info },
> >  	{ /* sentinel */ }
> >  };
> > @@ -74,6 +98,8 @@ const char *rzg2l_du_output_name(enum rzg2l_du_output output)
> >  {
> >  	static const char * const names[] = {
> >  		[RZG2L_DU_OUTPUT_DSI0] = "DSI0",
> > +		[RZG2L_DU_OUTPUT_LVDS0] = "LVDS0",
> > +		[RZG2L_DU_OUTPUT_LVDS1] = "LVDS1",
> >  		[RZG2L_DU_OUTPUT_DPAD0] = "DPAD0"
> >  	};
> >  
> > diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
> > index 58806c2a8f2b..480a7bdfcd66 100644
> > --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
> > +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
> > @@ -20,8 +20,12 @@
> >  struct device;
> >  struct drm_property;
> >  
> > +#define RZG2L_DU_FEATURE_SMUX2_DSI_CLK	BIT(0)	/* Per output mux */
> > +
> >  enum rzg2l_du_output {
> >  	RZG2L_DU_OUTPUT_DSI0,
> > +	RZG2L_DU_OUTPUT_LVDS0,
> > +	RZG2L_DU_OUTPUT_LVDS1,
> >  	RZG2L_DU_OUTPUT_DPAD0,
> >  	RZG2L_DU_OUTPUT_MAX,
> >  };
> > @@ -42,10 +46,12 @@ struct rzg2l_du_output_routing {
> >  
> >  /*
> >   * struct rzg2l_du_device_info - DU model-specific information
> > + * @features: device features (RZG2L_DU_FEATURE_*)
> >   * @channels_mask: bit mask of available DU channels
> >   * @routes: array of CRTC to output routes, indexed by output (RZG2L_DU_OUTPUT_*)
> >   */
> >  struct rzg2l_du_device_info {
> > +	unsigned int features;
> >  	unsigned int channels_mask;
> >  	struct rzg2l_du_output_routing routes[RZG2L_DU_OUTPUT_MAX];
> >  };
> > @@ -73,6 +79,12 @@ static inline struct rzg2l_du_device *to_rzg2l_du_device(struct drm_device *dev)
> >  	return container_of(dev, struct rzg2l_du_device, ddev);
> >  }
> >  
> > +static inline bool rzg2l_du_has(struct rzg2l_du_device *rcdu,
> > +				unsigned int feature)
> > +{
> > +	return rcdu->info->features & feature;
> > +}
> > +
> >  const char *rzg2l_du_output_name(enum rzg2l_du_output output);
> >  
> >  #endif /* __RZG2L_DU_DRV_H__ */

-- 
Regards,

Laurent Pinchart
