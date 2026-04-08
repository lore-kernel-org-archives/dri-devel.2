Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0290105D9B9
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 14:17:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14C2010E681;
	Wed,  8 Apr 2026 14:17:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="s6qyK+i3";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7381A10E681
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 14:17:21 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-703d-e500--2a1.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::2a1])
 by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 35CD41121;
 Wed,  8 Apr 2026 16:15:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1775657752;
 bh=3Bho4NJWklVctZpJLKGEsl+8sJES/JA2KlTVUBMWy2Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=s6qyK+i326qO08HC3hIQWV1w2TkGa+M1Pa/oQFq2qN5Pso0oAj+SjdIY6wBJmm2a1
 oMoeCEO3R2YPj1qPTF0RbGJmA67i9x9KRd0M7Y6UeUxRx9McSTupJboolwWMW6SlZv
 H+ye5vU/K2OWTzQjHSxPVM9dGbrIgGVRldgc+870=
Date: Wed, 8 Apr 2026 17:17:19 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: tomm.merciai@gmail.com, geert@linux-m68k.org,
 linux-renesas-soc@vger.kernel.org, biju.das.jz@bp.renesas.com,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v6 13/21] drm: renesas: rz-du: mipi_dsi: Add
 RZ_MIPI_DSI_FEATURE_GPO0R feature
Message-ID: <20260408141719.GB1965119@killaraus.ideasonboard.com>
References: <cover.1775636898.git.tommaso.merciai.xr@bp.renesas.com>
 <9e0f64dd5e1efb0d27219416121c91a19da96ebd.1775636898.git.tommaso.merciai.xr@bp.renesas.com>
 <20260408123102.GA1960713@killaraus.ideasonboard.com>
 <b8ded729-5c22-4a47-bfb7-8bffeed76e98@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b8ded729-5c22-4a47-bfb7-8bffeed76e98@bp.renesas.com>
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

On Wed, Apr 08, 2026 at 04:12:22PM +0200, Tommaso Merciai wrote:
> Hi Laurent,
> Thanks for your review.
> 
> On 4/8/26 14:31, Laurent Pinchart wrote:
> > On Wed, Apr 08, 2026 at 12:36:58PM +0200, Tommaso Merciai wrote:
> >> The MIPI DSI ip found in the RZ/G3E SoC select the video input clock
> >> based on the DU instance actually connected using the GPO0R register.
> >>
> >> Add this feature to the driver using `RZ_MIPI_DSI_FEATURE_GPO0R`, update
> >> the code accordingly to manage the vclk selection with the introduction
> >> of `rzg2l_mipi_dsi_get_input_port()`.
> >>
> >> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> >> ---
> >> v5->v6:
> >>   - Moved rzg2l_mipi_dsi_link_write() into rzv2h_mipi_dsi_dphy_init()
> >>     + comments from HW Manual.
> >>
> >> v4->v5:
> >>   - No changes.
> >>
> >> v3->v4:
> >>   - No changes.
> >>
> >> v2->v3:
> >>   - No changes.
> >>
> >> v1->v2:
> >>   - No changes.
> >>
> >>   .../gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c    | 71 +++++++++++++++++--
> >>   .../drm/renesas/rz-du/rzg2l_mipi_dsi_regs.h   |  3 +
> >>   2 files changed, 68 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> >> index be6dbf19a24e..947c8e15fc4b 100644
> >> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> >> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> >> @@ -37,7 +37,9 @@ MODULE_IMPORT_NS("RZV2H_CPG");
> >>   
> >>   #define RZG2L_DCS_BUF_SIZE	128 /* Maximum DCS buffer size in external memory. */
> >>   
> >> +#define RZ_MIPI_DSI_MAX_INPUT	2
> >>   #define RZ_MIPI_DSI_FEATURE_16BPP	BIT(0)
> >> +#define RZ_MIPI_DSI_FEATURE_GPO0R	BIT(1)
> >>   
> >>   struct rzg2l_mipi_dsi;
> >>   
> >> @@ -81,13 +83,14 @@ struct rzg2l_mipi_dsi {
> >>   	struct drm_bridge bridge;
> >>   	struct drm_bridge *next_bridge;
> >>   
> >> -	struct clk *vclk;
> >> +	struct clk *vclk[RZ_MIPI_DSI_MAX_INPUT];
> >>   	struct clk *lpclk;
> >>   
> >>   	enum mipi_dsi_pixel_format format;
> >>   	unsigned int num_data_lanes;
> >>   	unsigned int lanes;
> >>   	unsigned long mode_flags;
> >> +	u8 vclk_idx;
> >>   
> >>   	struct rzv2h_dsi_mode_calc mode_calc;
> >>   
> >> @@ -543,8 +546,8 @@ static int rzg2l_dphy_conf_clks(struct rzg2l_mipi_dsi *dsi, unsigned long mode_f
> >>   	unsigned long vclk_rate;
> >>   	unsigned int bpp;
> >>   
> >> -	clk_set_rate(dsi->vclk, mode_freq * KILO);
> >> -	vclk_rate = clk_get_rate(dsi->vclk);
> >> +	clk_set_rate(dsi->vclk[dsi->vclk_idx], mode_freq * KILO);
> >> +	vclk_rate = clk_get_rate(dsi->vclk[dsi->vclk_idx]);
> >>   	if (vclk_rate != mode_freq * KILO)
> >>   		dev_dbg(dsi->dev, "Requested vclk rate %lu, actual %lu mismatch\n",
> >>   			mode_freq * KILO, vclk_rate);
> >> @@ -687,6 +690,19 @@ static int rzv2h_mipi_dsi_dphy_init(struct rzg2l_mipi_dsi *dsi,
> >>   	rzg2l_mipi_dsi_phy_write(dsi, PLLCLKSET1R,
> >>   				 FIELD_PREP(PLLCLKSET1R_PLL_K, dsi_parameters->k));
> >>   
> >> +	/*
> >> +	 * From RZ/G3E HW manual (Rev.1.15) section 9.5.3 Operation,
> >> +	 * 9.5.3.1 Power on Reset and Initial Settings for All Operations.
> >> +	 * Figure 9.5-4 Power On/Off Sequence show that after writing to
> >> +	 * GPO0R.VICH register we need to wait for more than 1 x tp before
> >> +	 * writing to PLLENR.PLLEN.
> >> +	 *
> >> +	 * Note: GPO0R is a link register, not a PHY register. This setting
> >> +	 * is specific to RZ/G3E.
> >> +	 */
> >> +	if (dsi->info->features & RZ_MIPI_DSI_FEATURE_GPO0R)
> >> +		rzg2l_mipi_dsi_link_write(dsi, GPO0R, dsi->vclk_idx);
> >> +
> >>   	/*
> >>   	 * From RZ/V2H HW manual (Rev.1.20) section 9.5.3 Operation,
> >>   	 * (C) After write to D-PHY registers we need to wait for more than 1 x tp
> >> @@ -1005,6 +1021,37 @@ static int rzg2l_mipi_dsi_stop_video(struct rzg2l_mipi_dsi *dsi)
> >>   	return ret;
> >>   }
> >>   
> >> +static int rzg2l_mipi_dsi_get_input_port(struct rzg2l_mipi_dsi *dsi)
> >> +{
> >> +	struct device_node *np = dsi->dev->of_node;
> >> +	struct device_node *remote_ep, *ep_node;
> >> +	struct of_endpoint ep;
> >> +	bool ep_enabled;
> >> +	int in_port;
> >> +
> >> +	/* DSI can have only one port enabled */
> > 
> > Why is that ? The hardware supports dynamic input selection, why can't
> > it be supported at runtime ?
> 
> For runtime/dynamic you mean using DT overlay??
> like, remove:
> 
> Removing - DU0 --> DSI (input 0 | port@0 ) overlay and
> install  - DU1 --> DSI (input 1 | port@1 ) overlay and
> viceversa?

No, I mean configurable by userspace, with two CRTCs sharing one DSI
encoder.

> >> +	for_each_endpoint_of_node(np, ep_node) {
> >> +		of_graph_parse_endpoint(ep_node, &ep);
> >> +		if (ep.port >= RZ_MIPI_DSI_MAX_INPUT)
> >> +			break;
> >> +
> >> +		remote_ep = of_graph_get_remote_endpoint(ep_node);
> >> +		ep_enabled = of_device_is_available(remote_ep);
> >> +		of_node_put(remote_ep);
> >> +
> >> +		if (ep_enabled) {
> >> +			in_port = ep.port;
> >> +			break;
> >> +		}
> >> +	}
> >> +
> >> +	if (!ep_enabled)
> >> +		return -EINVAL;
> >> +
> >> +	dev_dbg(dsi->dev, "input port@%d\n", in_port);
> >> +	return in_port;
> >> +}
> >> +
> >>   /* -----------------------------------------------------------------------------
> >>    * Bridge
> >>    */
> >> @@ -1425,9 +1472,21 @@ static int rzg2l_mipi_dsi_probe(struct platform_device *pdev)
> >>   	if (IS_ERR(dsi->mmio))
> >>   		return PTR_ERR(dsi->mmio);
> >>   
> >> -	dsi->vclk = devm_clk_get(dsi->dev, "vclk");
> >> -	if (IS_ERR(dsi->vclk))
> >> -		return PTR_ERR(dsi->vclk);
> >> +	dsi->vclk[0] = devm_clk_get(dsi->dev, "vclk");
> >> +		if (IS_ERR(dsi->vclk[0]))
> >> +			return PTR_ERR(dsi->vclk[0]);
> >> +
> >> +	if (dsi->info->features & RZ_MIPI_DSI_FEATURE_GPO0R) {
> >> +		dsi->vclk[1] = devm_clk_get(dsi->dev, "vclk2");
> >> +		if (IS_ERR(dsi->vclk[1]))
> >> +			return PTR_ERR(dsi->vclk[1]);
> >> +
> >> +		ret = rzg2l_mipi_dsi_get_input_port(dsi);
> >> +		if (ret < 0)
> >> +			return dev_err_probe(dsi->dev, -EINVAL,
> >> +					     "No available input port\n");
> >> +		dsi->vclk_idx = ret;
> >> +	}
> >>   
> >>   	dsi->lpclk = devm_clk_get(dsi->dev, "lpclk");
> >>   	if (IS_ERR(dsi->lpclk))
> >> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi_regs.h b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi_regs.h
> >> index 2bef20566648..cee2e0bc5dc5 100644
> >> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi_regs.h
> >> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi_regs.h
> >> @@ -83,6 +83,9 @@
> >>   #define LINKSR_SQCHRUN1			BIT(4)
> >>   #define LINKSR_SQCHRUN0			BIT(0)
> >>   
> >> +/* RZ/G3E General Purpose Output 0 Register */
> >> +#define GPO0R				0xc0
> >> +
> >>   /* Tx Set Register */
> >>   #define TXSETR				0x100
> >>   #define TXSETR_NUMLANECAP		(0x3 << 16)

-- 
Regards,

Laurent Pinchart
