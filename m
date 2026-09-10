Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9E17C79F9F
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 07:17:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E507010F32D;
	Thu, 10 Sep 2026 07:17:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="X4ubh83p";
	dkim-atps=neutral
Received: from mail-m93200.xmail.ntesmail.com (mail-m93200.xmail.ntesmail.com
 [103.126.93.200])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 359EF10F32D
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 07:17:01 +0000 (UTC)
Received: from [127.0.0.1] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 4d3f9f7ab;
 Thu, 10 Sep 2026 15:16:57 +0800 (GMT+08:00)
Message-ID: <9e77b5c5-f1d9-484b-ae02-846fae1b3642@rock-chips.com>
Date: Thu, 10 Sep 2026 15:16:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] drm/rockchip: dw_dp: Attach "max bpc" connector
 property
To: Igor Paunovic <royalnet026@gmail.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Sandy Huang <hjc@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, Jani Nikula
 <jani.nikula@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Ville Syrjala <ville.syrjala@linux.intel.com>,
 Imre Deak <imre.deak@intel.com>, Ankit Nautiyal
 <ankit.k.nautiyal@intel.com>, dri-devel@lists.freedesktop.org
References: <20260909163206.36409-1-royalnet026@gmail.com>
 <20260909173542.14030-4-royalnet026@gmail.com>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <20260909173542.14030-4-royalnet026@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0aa08a2d43d903a7kunm43c471656ab21a
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZGUNJSFYfTE9PQx1PGE
 oeQ05WFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
 tIVUpLSEpKQk1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
 b=X4ubh83p0G7uLB3w+lrLYEOhoz65fWCAkqGrIJipe55SMi1B8b7sBWrETpX6u7mqZV2UtmXqL8GouAC77jFox9pATG10cszdwRxdBt7NlC4wL5cyIGKkBVncmcAe0Uhp8XJ7/wLWdFFNhrisczrU8ivzIKTni3OR0XOOoI2tWRk=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=Tpyr9lMkObRQjaiycSSz5ViShzTcyMZHhq0kg2XVVgw=;
 h=date:mime-version:subject:message-id:from;
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

Hello Igor,

On 9/10/2026 1:35 AM, Igor Paunovic wrote:
> The dw-dp bridge already filters candidate output formats on
> conn_state->max_bpc in dw_dp_bridge_atomic_get_output_bus_fmts() and
> validates the result against the link bandwidth, but the connector
> never exposes the "max bpc" property, so userspace cannot limit the
> bit depth. Attach the property with a range of 6 to 10, matching
> dw_dp_output_formats[]: the smallest entry is 6 bpc RGB and the
> deepest entries are 10 bpc.
> 
> drm_connector_attach_max_bpc_property() initializes
> connector->state->max_requested_bpc and therefore requires the
> connector to have a state. Rockchip binds its components before
> drm_mode_config_reset() runs, so the freshly created bridge connector
> does not have one yet - create the connector state before attaching
> the property, exactly like drmm_connector_hdmi_init() does for HDMI
> bridge connectors. The later drm_mode_config_reset() then re-creates
> the connector state, and the preceding patch makes
> drm_bridge_connector_create_state() restore max_requested_bpc from
> connector->max_bpc, so clients that never set the property (fbcon in
> particular) keep the full range instead of ending up with 0.
> 
> With the property attached, compositors such as KWin write "max bpc"
> on every atomic modeset; any in-range value is handled by the existing
> format filter and bandwidth checks.
> 
> Assisted-by: LLM checkpatch
> Signed-off-by: Igor Paunovic <royalnet026@gmail.com>
> ---
>  drivers/gpu/drm/rockchip/dw_dp-rockchip.c | 26 +++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c b/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
> index b23efb153c9e6..8ff27353b1417 100644
> --- a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
> @@ -112,6 +112,32 @@ static int dw_dp_rockchip_bind(struct device *dev, struct device *master, void *
>  				     "Failed to init bridge connector\n");
>  	}
>  
> +	/*
> +	 * The components are bound before drm_mode_config_reset() runs, so
> +	 * the connector has no state yet, but
> +	 * drm_connector_attach_max_bpc_property() requires one. Create the
> +	 * connector state first, like drmm_connector_hdmi_init() does.
> +	 */
> +	if (connector->funcs->atomic_create_state) {
> +		struct drm_connector_state *state;
> +
> +		state = connector->funcs->atomic_create_state(connector);
> +		if (IS_ERR(state)) {
> +			dw_dp_unbind(dp->base);
> +			return PTR_ERR(state);
> +		}
> +
> +		connector->state = state;
> +	} else if (connector->funcs->reset) {
> +		connector->funcs->reset(connector);
> +	}
> +
> +	ret = drm_connector_attach_max_bpc_property(connector, 6, 10);
> +	if (ret) {
> +		dw_dp_unbind(dp->base);
> +		return ret;
> +	}
> +
>  	return 0;
>  }
> 

I don't think this is the correct way to go.

I believe max_bpc should be handled in drm_bridge_connector_init(). 
Take a look at its implementation. HDMI already does max_bpc there, 
so DP should probably do something similar.

-- 
Best, 
Chaoyi
