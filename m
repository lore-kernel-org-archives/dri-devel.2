Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA5D9CD6E79
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 14:19:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B75D11A8CA;
	Fri,  5 Jun 2026 14:19:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="TVRQtWJK";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6F9E11A8CA
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 14:19:06 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1F3D621CD;
 Fri,  5 Jun 2026 16:18:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1780669120;
 bh=Q2thrnfKxS5peTcvg3KqVYhvE7T6XxLOVr02ML903s8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TVRQtWJKOiMnAobf8HKY0KfnkE3r/BIpl/V1nHAVbxHkQjYskUGYynPTk6pKBk/ug
 3yCTJq++0XQnDNCBT06S7w7SFFglyFi/zkBeJKpxbh/21GcN/S/SDodH+vAmDwFakt
 CtFRPJR96gtzKtN8dn6ARBBdxFMs5Sg/yB/wun6k=
Date: Fri, 5 Jun 2026 17:19:04 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <lumag@kernel.org>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 01/76] drm/atomic-state-helper: Rename
 __drm_atomic_helper_bridge_reset()
Message-ID: <20260605141904.GB84912@killaraus.ideasonboard.com>
References: <20260530-drm-no-more-bridge-reset-v1-0-875d828d31bc@kernel.org>
 <20260530-drm-no-more-bridge-reset-v1-1-875d828d31bc@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260530-drm-no-more-bridge-reset-v1-1-875d828d31bc@kernel.org>
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

Hi Maxime,

Thank you for the patch.

On Sat, May 30, 2026 at 03:59:06PM +0200, Maxime Ripard wrote:
> __drm_atomic_helper_bridge_reset() is used to initialize a
> newly allocated drm_bridge_state, and is being typically called by the
> drm_bridge_funcs.atomic_reset implementation.
> 
> Since we want to consolidate DRM objects state allocation around the
> atomic_create_state callback that will only allocate and initialize a
> new drm_bridge_state instance, we will need to call
> __drm_atomic_helper_bridge_reset() from both the atomic_reset and
> atomic_create_state hooks.
> 
> To avoid any confusion, we can thus rename
> __drm_atomic_helper_bridge_reset() to
> __drm_atomic_helper_bridge_state_init().
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

With a missing chunk from 02/76 moved to this patch (see the review of
02/76),

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
>  drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c | 2 +-
>  drivers/gpu/drm/drm_atomic_state_helper.c           | 6 +++---
>  include/drm/drm_atomic_state_helper.h               | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> index 36c07b71fe04..4e3015d10a97 100644
> --- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> @@ -1927,11 +1927,11 @@ cdns_mhdp_bridge_atomic_reset(struct drm_bridge *bridge)
>  
>  	cdns_mhdp_state = kzalloc_obj(*cdns_mhdp_state);
>  	if (!cdns_mhdp_state)
>  		return NULL;
>  
> -	__drm_atomic_helper_bridge_reset(bridge, &cdns_mhdp_state->base);
> +	__drm_atomic_helper_bridge_state_init(bridge, &cdns_mhdp_state->base);
>  
>  	return &cdns_mhdp_state->base;
>  }
>  
>  static u32 *cdns_mhdp_get_input_bus_fmts(struct drm_bridge *bridge,
> diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
> index 07686e94aae0..c38e514f336f 100644
> --- a/drivers/gpu/drm/drm_atomic_state_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_state_helper.c
> @@ -884,27 +884,27 @@ void drm_atomic_helper_bridge_destroy_state(struct drm_bridge *bridge,
>  	kfree(state);
>  }
>  EXPORT_SYMBOL(drm_atomic_helper_bridge_destroy_state);
>  
>  /**
> - * __drm_atomic_helper_bridge_reset() - Initialize a bridge state to its
> + * __drm_atomic_helper_bridge_state_init() - Initialize a bridge state to its
>   *					default
>   * @bridge: the bridge this state refers to
>   * @state: bridge state to initialize
>   *
>   * Initializes the bridge state to default values. This is meant to be called
>   * by the bridge &drm_bridge_funcs.atomic_reset hook for bridges that subclass
>   * the bridge state.
>   */
> -void __drm_atomic_helper_bridge_reset(struct drm_bridge *bridge,
> +void __drm_atomic_helper_bridge_state_init(struct drm_bridge *bridge,
>  				      struct drm_bridge_state *state)
>  {
>  	memset(state, 0, sizeof(*state));
>  	__drm_atomic_helper_private_obj_create_state(&bridge->base, &state->base);
>  	state->bridge = bridge;
>  }
> -EXPORT_SYMBOL(__drm_atomic_helper_bridge_reset);
> +EXPORT_SYMBOL(__drm_atomic_helper_bridge_state_init);
>  
>  /**
>   * drm_atomic_helper_bridge_reset() - Allocate and initialize a bridge state
>   *				      to its default
>   * @bridge: the bridge this state refers to
> diff --git a/include/drm/drm_atomic_state_helper.h b/include/drm/drm_atomic_state_helper.h
> index f4b6d8833bc2..6a715d8e1f4a 100644
> --- a/include/drm/drm_atomic_state_helper.h
> +++ b/include/drm/drm_atomic_state_helper.h
> @@ -100,9 +100,9 @@ void __drm_atomic_helper_bridge_duplicate_state(struct drm_bridge *bridge,
>  						struct drm_bridge_state *state);
>  struct drm_bridge_state *
>  drm_atomic_helper_bridge_duplicate_state(struct drm_bridge *bridge);
>  void drm_atomic_helper_bridge_destroy_state(struct drm_bridge *bridge,
>  					    struct drm_bridge_state *state);
> -void __drm_atomic_helper_bridge_reset(struct drm_bridge *bridge,
> +void __drm_atomic_helper_bridge_state_init(struct drm_bridge *bridge,
>  				      struct drm_bridge_state *state);
>  struct drm_bridge_state *
>  drm_atomic_helper_bridge_reset(struct drm_bridge *bridge);

-- 
Regards,

Laurent Pinchart
