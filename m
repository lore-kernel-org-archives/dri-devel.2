Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD53606A8B9
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 09:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=nJhl3dYP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17B5810ED2A;
	Mon, 16 Nov 2026 09:06:56 +0000 (UTC)
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA6C710ED2A
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 09:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
 Reply-To:Content-ID:Content-Description;
 bh=ydUjmXlLo3pPex5I6P/1tBqOJR5Q2KNo2lGVDYqsy2s=; t=1794820010; x=1796029610; 
 b=nJhl3dYPuVYYCQshgYd60Qph7sAMnuTAf0j6RJDQpQJf04jcFvmk+qpuM/ARN+tikBpWAW2JxrI
 bjMNK2SHnzIjAh/8HL0njq5Qkdy3QCDBwqMfnJv/m2aVcsR3ciM2v5cHVH6UQwcSbeFqndJEOnxbS
 qTo5p+z9i23ZdIJiScjaoDkQMHtb+kIE/KBY35TjeNQATCSDg661Xjoa8fFfeqlFJcGfxhjsEvDn8
 M7QVs60dVFIZXyG10pW/TwgjdmPqJ4ofsapUI6Evf+ryGEsDerav2AzMIBgMPAIeYBBgTmnr761/p
 36FS6jRzfy4cqRw3xK4M6FmeanUndWOmN7Gw==;
Date: Mon, 16 Nov 2026 10:06:42 +0100
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
Subject: Re: [PATCH v5 11/13] drm/bridge: tc358762: Drop
 drm_bridge_funcs.mode_set
Message-ID: <20261116100642.5d61e34b@kemnade.info>
In-Reply-To: <20261015-tc358762-fixes-v5-11-7cd721a6451b@ideasonboard.com>
References: <20261015-tc358762-fixes-v5-0-7cd721a6451b@ideasonboard.com>
 <20261015-tc358762-fixes-v5-11-7cd721a6451b@ideasonboard.com>
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

On Thu, 15 Oct 2026 14:16:02 +0300
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> wrote:

> drm_bridge_funcs.mode_set is deprecated. Drop it and get the
> drm_display_mode from the atomic state.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  drivers/gpu/drm/bridge/tc358762.c | 26 ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/tc358762.c
> index a91cf159ba27..33312300e606 100644
> --- a/drivers/gpu/drm/bridge/tc358762.c
> +++ b/drivers/gpu/drm/bridge/tc358762.c
> @@ -98,7 +98,6 @@ struct tc358762 {
>  	struct regulator *regulator;
>  	struct drm_bridge *panel_bridge;
>  	struct gpio_desc *reset_gpio;
> -	struct drm_display_mode mode;
>  	bool pre_enabled;
>  	int error;
>  	bool use_vtg;
> @@ -186,9 +185,18 @@ static void tc358762_enable(struct drm_bridge *bridge,
>  			    struct drm_atomic_commit *state)
>  {
>  	struct tc358762 *ctx = bridge_to_tc358762(bridge);
> +	struct drm_connector_state *conn_state;
> +	struct drm_crtc_state *crtc_state;
> +	struct drm_connector *connector;
> +	struct drm_display_mode *mode;
>  	u32 lcdctrl;
>  	int ret;
>  
> +	connector = drm_atomic_get_new_connector_for_encoder(state, bridge->encoder);
> +	conn_state = drm_atomic_get_new_connector_state(state, connector);
> +	crtc_state = drm_atomic_get_new_crtc_state(state, conn_state->crtc);
> +	mode = &crtc_state->mode;
> +
>  	/*
>  	 * DPIENABLE has reset default of 1. Make sure we don't output on
>  	 * DPI until we have finished the coniguration.
> @@ -213,7 +221,7 @@ static void tc358762_enable(struct drm_bridge *bridge,
>  	if (ctx->use_vtg) {
>  		struct videomode vm = { 0 };
>  
> -		drm_display_mode_to_videomode(&ctx->mode, &vm);
> +		drm_display_mode_to_videomode(mode, &vm);
>  
>  		tc358762_write(ctx, LCDC_HSR_HBPR,
>  			       vm.hsync_len | (vm.hback_porch << 16));
> @@ -237,10 +245,10 @@ static void tc358762_enable(struct drm_bridge *bridge,
>  
>  	lcdctrl |= LCDCTRL_DCLK_POL;
>  
> -	if (ctx->mode.flags & DRM_MODE_FLAG_PHSYNC)
> +	if (mode->flags & DRM_MODE_FLAG_PHSYNC)
>  		lcdctrl |= LCDCTRL_HSYNC_POL;
>  
> -	if (ctx->mode.flags & DRM_MODE_FLAG_PVSYNC)
> +	if (mode->flags & DRM_MODE_FLAG_PVSYNC)
>  		lcdctrl |= LCDCTRL_VSYNC_POL;
>  
>  	tc358762_write(ctx, LCDCTRL, lcdctrl);
> @@ -265,15 +273,6 @@ static int tc358762_attach(struct drm_bridge *bridge,
>  				 bridge, flags);
>  }
>  
> -static void tc358762_bridge_mode_set(struct drm_bridge *bridge,
> -				     const struct drm_display_mode *mode,
> -				     const struct drm_display_mode *adj)
> -{
> -	struct tc358762 *ctx = bridge_to_tc358762(bridge);
> -
> -	drm_mode_copy(&ctx->mode, mode);
> -}
> -
>  static const struct drm_bridge_funcs tc358762_bridge_funcs = {
>  	.atomic_post_disable = tc358762_post_disable,
>  	.atomic_pre_enable = tc358762_pre_enable,
> @@ -282,7 +281,6 @@ static const struct drm_bridge_funcs tc358762_bridge_funcs = {
>  	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
>  	.atomic_create_state = drm_atomic_helper_bridge_create_state,
>  	.attach = tc358762_attach,
> -	.mode_set = tc358762_bridge_mode_set,
>  };
>  
>  static int tc358762_parse_dt(struct tc358762 *ctx)
> 

