Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB0CCD98C5
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 09:19:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20F2510E30A;
	Mon, 15 Jun 2026 09:19:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="AkGYBH5+";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 763B810E30A
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 09:19:14 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8235C1E6;
 Mon, 15 Jun 2026 11:18:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1781515120;
 bh=7pnF6vbhipc5/ZDsAUAMs10wUOTE+lh7/ts9Pr31Pwg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=AkGYBH5+p+7BRF9FQ3H+qI8DoQKULNnakyPm2K1iTyvEvcalh5iWWwoSIdoHldHmq
 kFMDiduPjFm9S+Eawnjn0Ep71HnyAmVhM1cgNX5T1uWw/ZjKhLkojp1VdCdC0u764I
 jkJ+5CkAHGqh7rfKCHkLh8B8V0uRzaTDViFkp9Ac=
Date: Mon, 15 Jun 2026 12:19:11 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
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
Subject: Re: [PATCH v4 4/7] drm/rcar-du: dsi: Support DSC in the pipeline
Message-ID: <20260615091911.GB2821720@killaraus.ideasonboard.com>
References: <20260615-rcar-du-dsc-v4-0-93096a1b56a3@ideasonboard.com>
 <20260615-rcar-du-dsc-v4-4-93096a1b56a3@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260615-rcar-du-dsc-v4-4-93096a1b56a3@ideasonboard.com>
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

Hi Tomi,

Thank you for the patch.

On Mon, Jun 15, 2026 at 09:28:09AM +0300, Tomi Valkeinen wrote:
> Enabling DSI clocks on rcar-du needs some tricks as the DU dot clock is
> provided by the DSI. Thus, we call rcar_mipi_dsi_pclk_enable() from the
> crtc, when enabling the crtc.
> 
> With DSC (added in upcoming patch) in the pipeline, between the DU and
> the DSI, the above call path is broken as the crtc tries to call
> rcar_mipi_dsi_pclk_enable() on the DSC.
> 
> To solve this problem, add checks to rcar_du_crtc_atomic_enable() and
> rcar_du_crtc_atomic_disable() to detect the DSC via the bridge type, and
> skip the DCS bridge when needed.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
> ---
>  drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.c  | 18 ++++++++++++++++++
>  drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c |  1 +
>  2 files changed, 19 insertions(+)
> 
> diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.c
> index 6c07c406f725..f14fd89f9104 100644
> --- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.c
> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.c
> @@ -754,6 +754,15 @@ static void rcar_du_crtc_atomic_enable(struct drm_crtc *crtc,
>  	     (BIT(RCAR_DU_OUTPUT_DSI0) | BIT(RCAR_DU_OUTPUT_DSI1)))) {
>  		struct drm_bridge *bridge = rcdu->dsi[rcrtc->index];
>  
> +		/*
> +		 * When we have a DSC block between the DU and the DSI,
> +		 * the "bridge" points to the DSC. Detect the DSC by looking
> +		 * at the bridge type, and skip the DSC if the bridge is not
> +		 * the DSI bridge.
> +		 */
> +		if (bridge->type != DRM_MODE_CONNECTOR_DSI)
> +			bridge = bridge->next_bridge;
> +

Is there a reason you don't do this in rcar_du_encoder_init() instead ?
It would avoid running this code on every enable/disable.

>  		rcar_mipi_dsi_pclk_enable(bridge, state);
>  	}
>  
> @@ -796,6 +805,15 @@ static void rcar_du_crtc_atomic_disable(struct drm_crtc *crtc,
>  	     (BIT(RCAR_DU_OUTPUT_DSI0) | BIT(RCAR_DU_OUTPUT_DSI1)))) {
>  		struct drm_bridge *bridge = rcdu->dsi[rcrtc->index];
>  
> +		/*
> +		 * When we have a DSC block between the DU and the DSI,
> +		 * the "bridge" points to the DSC. Detect the DSC by looking
> +		 * at the bridge type, and skip the DSC if the bridge is not
> +		 * the DSI bridge.
> +		 */
> +		if (bridge->type != DRM_MODE_CONNECTOR_DSI)
> +			bridge = bridge->next_bridge;
> +
>  		/*
>  		 * Disable the DSI clock output, see
>  		 * rcar_du_crtc_atomic_enable().
> diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c b/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c
> index aaafee1c060b..f429f03a380c 100644
> --- a/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c
> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c
> @@ -957,6 +957,7 @@ static int rcar_mipi_dsi_host_attach(struct mipi_dsi_host *host,
>  
>  	/* Initialize the DRM bridge. */
>  	dsi->bridge.of_node = dsi->dev->of_node;
> +	dsi->bridge.type = DRM_MODE_CONNECTOR_DSI;
>  	drm_bridge_add(&dsi->bridge);
>  
>  	return 0;

-- 
Regards,

Laurent Pinchart
