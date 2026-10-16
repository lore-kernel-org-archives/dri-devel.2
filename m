Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE564CCF2C0
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 18:05:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A49510E05C;
	Fri, 16 Oct 2026 18:05:50 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34EC710E1D7
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 18:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792173945; x=1823709945;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=rKL2KbHXPkPFlnB0EXwEUoHuPwk8Dhf5EcKLc4uGvm8=;
 b=CT/IOn2Jvj8L0cXVBO4DlT2P0zDICBig2RxcFC21d0e+SegGb94Hjn1v
 xENYcSScKvx1wrOvCRmNZBwKliS1kEoG0AOV0rKG+S3CAXOXDM/+nL1gE
 NTkIsGjAlq6QgyL8aLBuecaP+PdL6MALrd85lptyhVxchrRYl0wSAxnIX
 Ke3mYKt1w7kmIL8/w79dBEXYxCrFaAzcuO7+69dlohaZ6UoYR7ZIwJmyJ
 RoRdaqjSRf/tJqS9syHMKe6jXWKSHw9qmQL5BYoxZpx0cteXuirYf9/FS
 HMfq2QCdEoHS5RF/glsIfVzJOipyLs2mvJwkf5H6ESb8MUKGlWP3GuIQv A==;
X-CSE-ConnectionGUID: yqQT8gsrTpyHU9aw+U7WOA==
X-CSE-MsgGUID: vI/gFJqTSduJP+4cw5vrIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11937"; a="864353"
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="864353"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2026 11:05:44 -0700
X-CSE-ConnectionGUID: A9YLbN6LTPqI/CYzasvDjw==
X-CSE-MsgGUID: Nnof+pM5Q+m2FOxZfogWVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="3845630"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO [10.245.245.89])
 ([10.245.245.89])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2026 11:05:41 -0700
Message-ID: <2bb8d768-c8f2-4b2a-9a71-1194e1cbcbae@linux.intel.com>
Date: Fri, 16 Oct 2026 20:06:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 22/28] drm/bridge_connector: Implement hw readout for
 connector
To: Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jyri Sarha <jyri.sarha@iki.fi>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org
References: <20261015-drm-state-readout-v6-0-6cc02cd10998@kernel.org>
 <20261015-drm-state-readout-v6-22-6cc02cd10998@kernel.org>
Content-Language: en-US
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
In-Reply-To: <20261015-drm-state-readout-v6-22-6cc02cd10998@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hey,

For the series:
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>

Would really love it if atomic_sro.[ch] is renamed to atomic_state_readout.[ch], so
we have a better idea what it's about. :-)

2 things to note:
- Hardware readout may be succesful, but the resulting state may not be valid.
  Think for example a crtc with a DP-MST connector, but the DP-MST connector
  is not yet detected at time of readout. crtc_state is invalid because connector_mask = 0.

It would be awesome if DP-MST would be detected before this point. I'm not sure this is
actually possible but it would make fastboot work on DP-MST as well.

- Alternatively some hardware may be connected to the wrong plane. Older i915 cards had a
  flexible mapping of plane 1 being connected to crtc 1 or 2, but for optimal performance you'd
  want it to be plane 1 to crtc 2. BIOS chose plane 1 to crtc 1.

Kind regards,
~Maarten Lankhorst

On 10/15/26 17:09, Maxime Ripard wrote:
> drm_bridge_connector allows to create a generic connector from a list of
> bridges.
> 
> However, it's a somewhat virtual connector, and relies on the bridges to
> implement its various capabilities.
> 
> What we actually want though is for the last bridge implementing
> hardware readout to fill the connector state from its own state.
> 
> Thus, implement a new op for bridge_connector to allow just
> that.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/display/drm_bridge_connector.c | 35 ++++++++++++++++++++++++++
>  include/drm/drm_bridge.h                       | 27 ++++++++++++++++++++
>  2 files changed, 62 insertions(+)
> 
> diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
> index 81f3e26f6fdf..dfc633bd8823 100644
> --- a/drivers/gpu/drm/display/drm_bridge_connector.c
> +++ b/drivers/gpu/drm/display/drm_bridge_connector.c
> @@ -8,10 +8,11 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/property.h>
>  #include <linux/slab.h>
>  
> +#include <drm/drm_atomic_sro_helper.h>
>  #include <drm/drm_atomic_state_helper.h>
>  #include <drm/drm_bridge.h>
>  #include <drm/drm_bridge_connector.h>
>  #include <drm/drm_connector.h>
>  #include <drm/drm_device.h>
> @@ -65,10 +66,18 @@ struct drm_bridge_connector {
>  	 * @encoder:
>  	 *
>  	 * The encoder at the start of the bridges chain.
>  	 */
>  	struct drm_encoder *encoder;
> +	/**
> +	 * @bridge_connector_hw_readout:
> +	 *
> +	 * The last bridge in the chain (closest to the connector) that
> +	 * provides hardware state readout support, if any (see
> +	 * &DRM_BRIDGE_OP_CONNECTOR_HW_READOUT).
> +	 */
> +	struct drm_bridge *bridge_connector_hw_readout;
>  	/**
>  	 * @bridge_edid:
>  	 *
>  	 * The last bridge in the chain (closest to the connector) that provides
>  	 * EDID read support, if any (see &DRM_BRIDGE_OP_EDID).
> @@ -242,10 +251,30 @@ drm_bridge_connector_create_state(struct drm_connector *connector)
>  							      conn_state);
>  
>  	return conn_state;
>  }
>  
> +static int
> +drm_bridge_connector_readout_state(struct drm_connector *connector,
> +				   struct drm_atomic_sro_state *state,
> +				   struct drm_connector_state *conn_state)
> +{
> +	struct drm_bridge_connector *bridge_connector =
> +		to_drm_bridge_connector(connector);
> +	struct drm_bridge *readout =
> +		bridge_connector->bridge_connector_hw_readout;
> +	int ret;
> +
> +	if (readout) {
> +		ret = readout->funcs->atomic_sro_connector_readout(readout, state, conn_state);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  static enum drm_connector_color_format
>  drm_bridge_connector_color_format(const struct drm_connector_state *conn_state)
>  {
>  	struct drm_bridge_connector *bridge_connector =
>  		to_drm_bridge_connector(conn_state->connector);
> @@ -268,10 +297,12 @@ drm_bridge_connector_color_format(const struct drm_connector_state *conn_state)
>  }
>  
>  static const struct drm_connector_funcs drm_bridge_connector_funcs = {
>  	.fill_modes = drm_helper_probe_single_connector_modes,
>  	.atomic_create_state = drm_bridge_connector_create_state,
> +	.atomic_sro_readout_state = drm_bridge_connector_readout_state,
> +	.atomic_sro_compare_state = drm_atomic_helper_connector_compare_state,
>  	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
>  	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
>  	.debugfs_init = drm_bridge_connector_debugfs_init,
>  	.oob_hotplug_event = drm_bridge_connector_oob_hotplug_event,
>  	.color_format = drm_bridge_connector_color_format,
> @@ -894,10 +925,14 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
>  		if (!bridge->interlace_allowed)
>  			connector->interlace_allowed = false;
>  		if (!bridge->ycbcr_420_allowed)
>  			connector->ycbcr_420_allowed = false;
>  
> +		if (bridge->ops & DRM_BRIDGE_OP_CONNECTOR_HW_READOUT) {
> +			drm_bridge_put(bridge_connector->bridge_connector_hw_readout);
> +			bridge_connector->bridge_connector_hw_readout = drm_bridge_get(bridge);
> +		}
>  		/*
>  		 * Ensure the last bridge declares OP_EDID or OP_MODES or both.
>  		 */
>  		if (bridge->ops & DRM_BRIDGE_OP_EDID || bridge->ops & DRM_BRIDGE_OP_MODES) {
>  			drm_bridge_put(bridge_connector->bridge_edid);
> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index fcccd8f6403d..7d6aaba0b82c 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
> @@ -935,10 +935,30 @@ struct drm_bridge_funcs {
>  	 */
>  	int (*dp_audio_mute_stream)(struct drm_bridge *bridge,
>  				    struct drm_connector *connector,
>  				    bool enable, int direction);
>  
> +	/**
> +	 * @atomic_sro_connector_readout:
> +	 *
> +	 * This optional hook initializes the &struct drm_connector_state
> +	 * based on hardware state.
> +	 *
> +	 * It is implemented by bridges that set the
> +	 * %DRM_BRIDGE_OP_CONNECTOR_HW_READOUT flag in their
> +	 * &drm_bridge.ops. When using drm_bridge_connector, the last
> +	 * bridge in the chain with this flag set will have its hook
> +	 * called to fill the connector state.
> +	 *
> +	 * RETURNS:
> +	 *
> +	 * 0 on success, a negative error code otherwise.
> +	 */
> +	int (*atomic_sro_connector_readout)(struct drm_bridge *bridge,
> +					    struct drm_atomic_sro_state *state,
> +					    struct drm_connector_state *conn_state);
> +
>  	/**
>  	 * @debugfs_init:
>  	 *
>  	 * Allows bridges to create bridge-specific debugfs files.
>  	 */
> @@ -1075,10 +1095,17 @@ enum drm_bridge_ops {
>  	 * @DRM_BRIDGE_OP_HDMI_SPD_INFOFRAME: The bridge supports
>  	 * &drm_bridge_funcs->hdmi_write_spd_infoframe and
>  	 * &drm_bridge_funcs->hdmi_clear_spd_infoframe callbacks.
>  	 */
>  	DRM_BRIDGE_OP_HDMI_SPD_INFOFRAME = BIT(10),
> +	/**
> +	 * @DRM_BRIDGE_OP_CONNECTOR_HW_READOUT: The bridge supports the
> +	 * &drm_bridge_funcs.atomic_sro_connector_readout callback to
> +	 * fill the connector state from the bridge's own hardware state
> +	 * during state readout.
> +	 */
> +	DRM_BRIDGE_OP_CONNECTOR_HW_READOUT = BIT(11),
>  };
>  
>  /**
>   * struct drm_bridge - central DRM bridge control structure
>   */
> 

