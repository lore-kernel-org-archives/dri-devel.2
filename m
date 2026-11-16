Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6594A606A332
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 09:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=LtZX5IaF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE11410E9DE;
	Mon, 16 Nov 2026 09:18:05 +0000 (UTC)
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 070BE10E9DE
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 09:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
 Reply-To:Content-ID:Content-Description;
 bh=Z8vIOmbIt256h0sN5KP+ZCa71ev+Q0ASUR7JzYgKmR4=; t=1794820679; x=1796030279; 
 b=LtZX5IaF0uuBj9zVWhm3+8GI2nVMeKbcyFBTu++HKyrEi4ir/Nc/7dZDr16KjEPPLQGyjp5LX7r
 gikdQE+OeQEIV7x72+19MBctGSwmsCzojKm1A3hFTNvpuDmak8avttn2H2iKp/aypCXvwvwPaYPAk
 CyqMUoYV0lzjsS33Z5yp9ggH+1C1TDS/lQOBBjQGGUxAZm/yFzlve6eEm5avyzu05zjhAnRPZUYhS
 ENhDYbGdjQLTyvYFz9uRd3ggEhcPwnxdJgnwFH9T1msNuoejS7CWo4nMP0krIsNyZDID0SXfaG+n2
 H0Ernlkbiu28z02E3bdWF/XpgImaZlBe7cyg==;
Date: Mon, 16 Nov 2026 10:17:37 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Marek Vasut <marex@denx.de>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Dave
 Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH v5 12/13] drm/bridge: tc358762: Set DE_POL and DCLK_POL
 properly
Message-ID: <20261116101737.38caec27@kemnade.info>
In-Reply-To: <20261015-tc358762-fixes-v5-12-7cd721a6451b@ideasonboard.com>
References: <20261015-tc358762-fixes-v5-0-7cd721a6451b@ideasonboard.com>
 <20261015-tc358762-fixes-v5-12-7cd721a6451b@ideasonboard.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 15 Oct 2026 14:16:03 +0300
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> wrote:

> The driver hardcodes LCDCTRL_DCLK_POL and ~DE_POL, ignoring what the
> panel actuall wants. Fix this by looking at the
> bridge_state->output_bus_cfg.flags, and set the polarities correctly.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  drivers/gpu/drm/bridge/tc358762.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/tc358762.c
> index 33312300e606..e73be376e33c 100644
> --- a/drivers/gpu/drm/bridge/tc358762.c
> +++ b/drivers/gpu/drm/bridge/tc358762.c
> @@ -186,12 +186,15 @@ static void tc358762_enable(struct drm_bridge *bridge,
>  {
>  	struct tc358762 *ctx = bridge_to_tc358762(bridge);
>  	struct drm_connector_state *conn_state;
> +	struct drm_bridge_state *bridge_state;
>  	struct drm_crtc_state *crtc_state;
>  	struct drm_connector *connector;
>  	struct drm_display_mode *mode;
>  	u32 lcdctrl;
>  	int ret;
>  
> +	bridge_state = drm_atomic_get_new_bridge_state(state, bridge);
> +
>  	connector = drm_atomic_get_new_connector_for_encoder(state, bridge->encoder);
>  	conn_state = drm_atomic_get_new_connector_state(state, connector);
>  	crtc_state = drm_atomic_get_new_crtc_state(state, conn_state->crtc);
> @@ -243,7 +246,9 @@ static void tc358762_enable(struct drm_bridge *bridge,
>  	if (ctx->use_vtg)
>  		lcdctrl |= LCDCTRL_VTGEN;
>  
> -	lcdctrl |= LCDCTRL_DCLK_POL;
> +	/* Note: DCLK_POL affects pixdata, de and syncs */
> +	if (bridge_state->output_bus_cfg.flags & DRM_BUS_FLAG_PIXDATA_DRIVE_POSEDGE)
> +		lcdctrl |= LCDCTRL_DCLK_POL;
>  
>  	if (mode->flags & DRM_MODE_FLAG_PHSYNC)
>  		lcdctrl |= LCDCTRL_HSYNC_POL;
> @@ -251,6 +256,9 @@ static void tc358762_enable(struct drm_bridge *bridge,
>  	if (mode->flags & DRM_MODE_FLAG_PVSYNC)
>  		lcdctrl |= LCDCTRL_VSYNC_POL;
>  
> +	if (bridge_state->output_bus_cfg.flags & DRM_BUS_FLAG_DE_LOW)
> +		lcdctrl |= LCDCTRL_DE_POL;
> +
>  	tc358762_write(ctx, LCDCTRL, lcdctrl);
>  
>  	tc358762_write(ctx, PPI_STARTPPI, PPI_STARTPPI_STARTPPI);
> 

