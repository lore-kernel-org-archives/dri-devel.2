Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D5AD103E197
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 15:25:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B949510E708;
	Wed, 18 Mar 2026 15:25:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="I4w94R6l";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2221610E708
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 15:25:37 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-703d-e500--2a1.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::2a1])
 by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 9F349460;
 Wed, 18 Mar 2026 16:24:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1773847462;
 bh=EvRalwX2ntkbXZJQ1JFLu87v3wLuX2lWaocS5pxY0iY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=I4w94R6lkXRcA8DjzP/FlxDWi6EjYqb7DT1HbLjRytTyzKpp/uq485r7z5sSVf5wA
 MuPWFMGC6Bz4mAfUJ6ISl+ZTtsMy/DRbsegEAfnO3OfyjRLFXKhHwpShI0JU45q7fN
 IIXH2xXaj43xmwZKTP97oOlugpTNb208oHdCcAGU=
Date: Wed, 18 Mar 2026 17:25:33 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
 Linus Walleij <linusw@kernel.org>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] drm: rcar-du: encoder: convert to
 of_drm_find_and_get_bridge()
Message-ID: <20260318152533.GA633439@killaraus.ideasonboard.com>
References: <20260318-drm-bridge-alloc-getput-drm_of_find_bridge-4-v3-0-10f502520357@bootlin.com>
 <20260318-drm-bridge-alloc-getput-drm_of_find_bridge-4-v3-3-10f502520357@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260318-drm-bridge-alloc-getput-drm_of_find_bridge-4-v3-3-10f502520357@bootlin.com>
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

Hi Luca,

Thank you for the patch.

On Wed, Mar 18, 2026 at 10:39:37AM +0100, Luca Ceresoli wrote:
> of_drm_find_bridge() is deprecated. Move to its replacement
> of_drm_find_and_get_bridge() which gets a bridge reference, and ensure it
> is put when done.
> 
> We need to handle the two cases: when a panel_bridge is added and when it
> isn't. So:
> 
>  * in the 'else' case a panel_bridge is not added and bridge is found: use
>    of_drm_find_and_get_bridge() to get a reference to the found bridge
>  * in the 'then' case a panel_bridge is found using a devm function which
>    already takes a refcount and will put it on removal, but we need to take
>    another so the following code in this function always get exactly one
>    reference that it needs to put
> 
> In order to put the reference, add the needed drm_bridge_put() calls in the
> existing cleanup function.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>  drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.c | 28 ++++++++++++++++++-----
>  drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.h |  1 +
>  drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c     |  2 ++
>  3 files changed, 25 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.c
> index 7ecec7b04a8d..5789fc75092f 100644
> --- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.c
> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.c
> @@ -51,7 +51,7 @@ int rcar_du_encoder_init(struct rcar_du_device *rcdu,
>  {
>  	struct rcar_du_encoder *renc;
>  	struct drm_connector *connector;
> -	struct drm_bridge *bridge;
> +	struct drm_bridge *bridge __free(drm_bridge_put) = NULL;
>  	int ret;
>  
>  	/*
> @@ -69,20 +69,26 @@ int rcar_du_encoder_init(struct rcar_du_device *rcdu,
>  
>  		bridge = devm_drm_panel_bridge_add_typed(rcdu->dev, panel,
>  							 DRM_MODE_CONNECTOR_DPI);
> -		if (IS_ERR(bridge))
> -			return PTR_ERR(bridge);
> +		if (IS_ERR(bridge)) {
> +			// Inhibit the cleanup action on an ERR_PTR

C-style comments.

Shouldn't drm_bridge_put() be extended to be a no-op when called on an
ERR_PTR ?

> +			ret = PTR_ERR(bridge);
> +			bridge = NULL;
> +			return ret;
> +		}
> +

A comment here would be good.

		/*
		 * The reference taken by devm_drm_panel_bridge_add_typed() is
		 * released automatically. Take a second one for the __free()
		 * when this function will return.
		 */

> +		drm_bridge_get(bridge);
>  	} else {
> -		bridge = of_drm_find_bridge(enc_node);
> +		bridge = of_drm_find_and_get_bridge(enc_node);
>  		if (!bridge)
>  			return -EPROBE_DEFER;
>  
>  		if (output == RCAR_DU_OUTPUT_LVDS0 ||
>  		    output == RCAR_DU_OUTPUT_LVDS1)
> -			rcdu->lvds[output - RCAR_DU_OUTPUT_LVDS0] = bridge;
> +			rcdu->lvds[output - RCAR_DU_OUTPUT_LVDS0] = drm_bridge_get(bridge);

Line wrap.

>  
>  		if (output == RCAR_DU_OUTPUT_DSI0 ||
>  		    output == RCAR_DU_OUTPUT_DSI1)
> -			rcdu->dsi[output - RCAR_DU_OUTPUT_DSI0] = bridge;
> +			rcdu->dsi[output - RCAR_DU_OUTPUT_DSI0] = drm_bridge_get(bridge);

Same.

>  	}
>  
>  	/*
> @@ -135,3 +141,13 @@ int rcar_du_encoder_init(struct rcar_du_device *rcdu,
>  
>  	return drm_connector_attach_encoder(connector, &renc->base);
>  }
> +
> +void rcar_du_encoder_cleanup(struct rcar_du_device *rcdu)
> +{
> +	int i;

i is never negative, make it unsigned.

> +
> +	for (i = 0; i < RCAR_DU_MAX_LVDS; i++)

Use ARRAY_SIZE() here.

> +		drm_bridge_put(rcdu->lvds[i]);
> +	for (i = 0; i < RCAR_DU_MAX_DSI; i++)

Same here.

I have tested the patch and it seems to behave fine.

> +		drm_bridge_put(rcdu->dsi[i]);
> +}
> diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.h b/drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.h
> index e5ec8fbb3979..b2b5e93f30f8 100644
> --- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.h
> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.h
> @@ -25,5 +25,6 @@ struct rcar_du_encoder {
>  int rcar_du_encoder_init(struct rcar_du_device *rcdu,
>  			 enum rcar_du_output output,
>  			 struct device_node *enc_node);
> +void rcar_du_encoder_cleanup(struct rcar_du_device *rcdu);
>  
>  #endif /* __RCAR_DU_ENCODER_H__ */
> diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c
> index 60e6f43b8ab2..82d16a999ee6 100644
> --- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c
> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c
> @@ -836,6 +836,8 @@ static void rcar_du_modeset_cleanup(struct drm_device *dev, void *res)
>  
>  	for (i = 0; i < ARRAY_SIZE(rcdu->cmms); ++i)
>  		platform_device_put(rcdu->cmms[i]);
> +
> +	rcar_du_encoder_cleanup(rcdu);
>  }
>  
>  int rcar_du_modeset_init(struct rcar_du_device *rcdu)
> 

-- 
Regards,

Laurent Pinchart
