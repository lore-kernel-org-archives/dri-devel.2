Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C79CBCD98CF
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 15:53:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E748A10EA73;
	Fri, 12 Jun 2026 15:53:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Z8S8P5jC";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4DD310EA75
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 15:53:04 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7554F497;
 Fri, 12 Jun 2026 17:52:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1781279552;
 bh=Xi4zr6K4kn0ZEMvzzLUuNwWw60sZlDm3SVBSJ/YtuQg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Z8S8P5jCFyTJtycXMMjLt/8TwqBV+eybltV90qrojoPBmml1+uvKj11t9HxOnmrmX
 B0MOPpBIJsPGPWeh/6ZHZB9OWAvNXvY5ERFpaziK2fsszUVeqh8fdo+0W8uJoicdOL
 p3qRuinDJo5SSUZ6aAxCQrkyjnpPiJHBcc8erDIg=
Date: Fri, 12 Jun 2026 18:53:01 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v3 4/7] drm/rcar-du: dsi: Support DSC in the pipeline
Message-ID: <20260612155301.GC1982714@killaraus.ideasonboard.com>
References: <20260515-rcar-du-dsc-v3-0-164157820498@ideasonboard.com>
 <20260515-rcar-du-dsc-v3-4-164157820498@ideasonboard.com>
 <20260611000324.GH1632628@killaraus.ideasonboard.com>
 <11f27d38-0224-4fce-a975-7c3f7d8d1d38@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <11f27d38-0224-4fce-a975-7c3f7d8d1d38@ideasonboard.com>
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

On Fri, Jun 12, 2026 at 02:56:11PM +0300, Tomi Valkeinen wrote:
> On 11/06/2026 03:03, Laurent Pinchart wrote:
> > On Fri, May 15, 2026 at 12:09:29PM +0300, Tomi Valkeinen wrote:
> >> Enabling DSI clocks on rcar-du needs some tricks as the DU dot clock is
> >> provided by the DSI. Thus, we call rcar_mipi_dsi_pclk_enable() from the
> >> crtc, when enabling the crtc.
> >>
> >> With DSC (added in upcoming patch) in the pipeline, between the DU and
> >> the DSI, the above call path is broken as the crtc tries to call
> >> rcar_mipi_dsi_pclk_enable() on the DSC.
> >>
> >> Adjust the rcar_mipi_dsi_pclk_enable() so that it detects the DSC, and
> >> in that case gets the next bridge from the DSC, which is the DSI.
> >>
> >> Signed-off-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
> >> ---
> >>   drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c | 36 +++++++++++++++++++++++--
> >>   1 file changed, 34 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c b/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c
> >> index 4ef2e3c129ed..085e229bcb0b 100644
> >> --- a/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c
> >> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c
> >> @@ -88,6 +88,8 @@ struct dsi_setup_info {
> >>   	const struct dsi_clk_config *clkset;
> >>   };
> >>   
> >> +static const struct drm_bridge_funcs rcar_mipi_dsi_bridge_ops;
> >> +
> >>   static inline struct rcar_mipi_dsi *
> >>   bridge_to_rcar_mipi_dsi(struct drm_bridge *bridge)
> >>   {
> >> @@ -844,15 +846,39 @@ static void rcar_mipi_dsi_atomic_disable(struct drm_bridge *bridge,
> >>   	rcar_mipi_dsi_stop_video(dsi);
> >>   }
> >>   
> >> +/*
> >> + * We need to skip the DSC bridge when we have DSC in between the DU and
> >> + * the DSI. We detect the DSI bridge via bridge->funcs, and assume the
> >> + * next_bridge is the DSI bridge. If this is not the case, the DT data
> >> + * is wrong (so it shouldn't really happen).
> >> + */
> >> +static struct drm_bridge *
> >> +rcar_mipi_dsi_resolve_bridge(struct drm_bridge *bridge)
> >> +{
> >> +	if (bridge->funcs != &rcar_mipi_dsi_bridge_ops)
> >> +		bridge = bridge->next_bridge;
> >> +
> >> +	if (!bridge || bridge->funcs != &rcar_mipi_dsi_bridge_ops)
> >> +		return NULL;
> >> +
> >> +	return bridge;
> >> +}
> > 
> > Hmmmm... It's quite a bit of a hack. It would be nicer to do this in
> > rcar_du_crtc.c instead, where we cache the dsi bridge pointer. The
> 
> It's actually cached in rcar_du_encoder.c, but used in rcar_du_crtc.c.
> 
> If I understand right, you'd like to do the DSC detection in 
> rcar_du_crtc, and skip the DSC, if needed, before calling 
> rcar_mipi_dsi_pclk_enable()?

That would be the idea, yes. Knowledge that there's a DSC in the
pipeline would be in the DU driver, not the DSI driver. I think it would
be better, as the DU driver is the one that should have an overall view
of the display pipeline.

> > question is how to then identify the right bridge, as we won't have
> > access to rcar_mipi_dsi_bridge_ops. Should this driver set the bridge
> > type field to DRM_MODE_CONNECTOR_DSI ?
> 
> I'm not sure how that would help. Or, I can, as the dsi driver does not 
> set the bridge type, so only DSC would set it. But isn't that even more 
> hacky?
> 
> Or did you rather mean that the DSI driver would set the bridge type, 
> and DSC would not? We can then do:
> 
> 		if (bridge->type != DRM_MODE_CONNECTOR_DSI)
> 			bridge = bridge->next_bridge;

Yes that's what I meant.

> in the crtc driver. This works. It's still a bit hacky, but I think the 
> chances of the code getting it wrong are quite low. If the output port 
> is RCAR_DU_OUTPUT_DSIx, then the next bridge must be rcar-dsi or 
> rcar-dsc, so it's all under our control. Also, it's less code than this 
> patch, so I'll go with that.

Thanks.

-- 
Regards,

Laurent Pinchart
