Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B222C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 13:29:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCDA010E069;
	Thu,  9 Jul 2026 13:29:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="G+U7IBey";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C341410E069
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 13:29:47 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id C80344DC;
 Thu,  9 Jul 2026 15:28:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1783603736;
 bh=87lVA9V8V2lXzJG4XdXjKeodniJQa1uBXNGQb9jGZJM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=G+U7IBeynh0jeseXC7sX0Cab66rDpSjpSrjkesARwkWMCrBPYOGD+oFO5I8cXKNpH
 KWSqUmd2i/lYa4QRQnOiTE/SnPCn/5LcrMgIbxY7K6IiptWQa2Ou9JOjg0CdgkbYH9
 21B7ZZrgAFBUm1dhVLnI8VRuQct4TZsvOPpQnS0E=
Date: Thu, 9 Jul 2026 16:29:44 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Wojciech Dubowik <wojciech.dubowik@mt.com>
Cc: linux-kernel@vger.kernel.org, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2] drm/bridge: ti-sn65dsi83: Add reversed lvds lanes
 support
Message-ID: <20260709132944.GB1007225@killaraus.ideasonboard.com>
References: <20260709125810.340612-1-wojciech.dubowik@mt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260709125810.340612-1-wojciech.dubowik@mt.com>
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

On Thu, Jul 09, 2026 at 02:58:09PM +0200, Wojciech Dubowik wrote:
> From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> 
> The chip supports output lvds lanes in two orders, default <1 2 3 4>
> and <4 3 2 1>. Add parsing of an optional output lvds data-lanes
> property so we can inform chip that the lanes have been reversed.
> 
> Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> ---
> Changes in v2:
> - Parse existing data-lanes property instead of ading new DT
>   bindings

You still need to update the bindings to relax the ordering requirement
of the data-lanes property.

Does the device support less than 4 data lanes ? If not, the bindings
will also need to be updated to reflect that.

> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi83.c | 50 +++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> index 42b451432bbb..4945d4c960c4 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> @@ -148,6 +148,18 @@ enum sn65dsi83_lvds_term {
>  	OHM_200
>  };
>  
> +enum {
> +	NORMAL_LANE_MAPPING,
> +	REVERSE_LANE_MAPPING,
> +};
> +
> +#define DATA_LANES_COUNT	4
> +
> +static const int supported_data_lane_mapping[][DATA_LANES_COUNT] = {
> +	[NORMAL_LANE_MAPPING] = { 1, 2, 3, 4 },
> +	[REVERSE_LANE_MAPPING] = { 4, 3, 2, 1},
> +};
> +
>  enum sn65dsi83_model {
>  	MODEL_SN65DSI83,
>  	MODEL_SN65DSI84,
> @@ -163,6 +175,7 @@ struct sn65dsi83 {
>  	struct regulator		*vcc;
>  	bool				lvds_dual_link;
>  	bool				lvds_dual_link_even_odd_swap;
> +	bool				lvds_reverse_lanes_conf[2];
>  	int				lvds_vod_swing_conf[2];
>  	int				lvds_term_conf[2];
>  	int				irq;
> @@ -644,6 +657,10 @@ static void sn65dsi83_atomic_pre_enable(struct drm_bridge *bridge,
>  	regmap_write(ctx->regmap, REG_LVDS_LANE,
>  		     (ctx->lvds_dual_link_even_odd_swap ?
>  		      REG_LVDS_LANE_EVEN_ODD_SWAP : 0) |
> +		     (ctx->lvds_reverse_lanes_conf[CHANNEL_A] ?
> +		      REG_LVDS_LANE_CHA_REVERSE_LVDS : 0) |
> +		     (ctx->lvds_reverse_lanes_conf[CHANNEL_B] ?
> +		      REG_LVDS_LANE_CHB_REVERSE_LVDS : 0) |
>  		     (ctx->lvds_term_conf[CHANNEL_A] ?
>  			  REG_LVDS_LANE_CHA_LVDS_TERM : 0) |
>  		     (ctx->lvds_term_conf[CHANNEL_B] ?
> @@ -832,10 +849,12 @@ static int sn65dsi83_parse_lvds_endpoint(struct sn65dsi83 *ctx, int channel)
>  	u32 lvds_vod_swing_clk[2] = { 0, 1000000 };
>  	/* Set default near end terminataion to 200 Ohm */
>  	u32 lvds_term = 200;
> +	u32 data_lanes[DATA_LANES_COUNT];
>  	int lvds_vod_swing_conf;
>  	int ret = 0;
>  	int ret_data;
>  	int ret_clock;
> +	int i, j;
>  
>  	if (channel == CHANNEL_A)
>  		endpoint_reg = 2;
> @@ -854,6 +873,37 @@ static int sn65dsi83_parse_lvds_endpoint(struct sn65dsi83 *ctx, int channel)
>  		goto exit;
>  	}
>  
> +	ret_data = of_property_read_u32_array(endpoint, "data-lanes", data_lanes,
> +			ARRAY_SIZE(data_lanes));
> +	if (ret_data != 0 && ret_data != -EINVAL) {
> +		ret = ret_data;
> +		goto exit;
> +	}
> +
> +	if (!ret_data) {

I wish we could drop this check, but as the data-lanes property is not
documented as mandatory, I suppose not all device trees use it :-(

Could you, while at it, make the property mandatory in the bindings, to
ensure it gets specified in all future device trees (and fix in-tree
offenders, if any) ?

> +		for (i = 0; i < ARRAY_SIZE(supported_data_lane_mapping); i++) {
> +			for (j = 0; j < DATA_LANES_COUNT; j++) {
> +				if (data_lanes[j] != supported_data_lane_mapping[i][j])
> +					break;
> +			}
> +
> +			if (j == DATA_LANES_COUNT)
> +				break;
> +		}
> +
> +		switch (i) {
> +		case NORMAL_LANE_MAPPING:
> +			break;
> +		case REVERSE_LANE_MAPPING:
> +			ctx->lvds_reverse_lanes_conf[channel] = true;
> +			break;
> +		default:
> +			dev_err(dev, "invalid data lanes mapping\n");
> +			ret = -EINVAL;
> +			goto exit;
> +		}
> +	}
> +
>  	ret_data = of_property_read_u32_array(endpoint, "ti,lvds-vod-swing-data-microvolt",
>  					lvds_vod_swing_data, ARRAY_SIZE(lvds_vod_swing_data));
>  	if (ret_data != 0 && ret_data != -EINVAL) {

-- 
Regards,

Laurent Pinchart
