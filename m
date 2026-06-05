Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B49CD6E7D
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 14:14:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0516811A8BF;
	Fri,  5 Jun 2026 14:14:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="V4ktR92p";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C1D811A8BE
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 14:14:25 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 17E8B1B9A;
 Fri,  5 Jun 2026 16:13:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1780668838;
 bh=8D/2KO4b+Rfxis7X4IQhRn0RjL1DaaoS39QSQmlfw4g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=V4ktR92pc7oXZrgRBL/dT0jtIr0BItAj0mPGro4W7r2YDf7trotgGYq8HXX0deet6
 m/GD47L/AU0StHEF+6lbXGieDPOdSSbYX4weNjJ6JI304sKyLPUAfouhkAKp9u57y+
 8emHEqE6c6QaDs8V7FAq/xUUzPJi9smVg2pV9RHI=
Date: Fri, 5 Jun 2026 17:14:22 +0300
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
Subject: Re: [PATCH 02/76] drm/atomic-state-helper: Reorder
 __drm_atomic_helper_bridge_state_init() arguments
Message-ID: <20260605141422.GA84912@killaraus.ideasonboard.com>
References: <20260530-drm-no-more-bridge-reset-v1-0-875d828d31bc@kernel.org>
 <20260530-drm-no-more-bridge-reset-v1-2-875d828d31bc@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260530-drm-no-more-bridge-reset-v1-2-875d828d31bc@kernel.org>
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

On Sat, May 30, 2026 at 03:59:07PM +0200, Maxime Ripard wrote:
> The convention for state init helpers is to pass the state pointer
> as the first argument and the object pointer second.
> 
> __drm_atomic_helper_bridge_state_init() has them in the opposite
> order. Swap the arguments to follow the convention, and update the
> cdns-mhdp8546 caller.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
>  drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c | 2 +-
>  drivers/gpu/drm/drm_atomic_state_helper.c           | 8 ++++----
>  include/drm/drm_atomic_state_helper.h               | 4 ++--
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> index 4e3015d10a97..063f073034c1 100644
> --- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> @@ -1927,11 +1927,11 @@ cdns_mhdp_bridge_atomic_reset(struct drm_bridge *bridge)
>  
>  	cdns_mhdp_state = kzalloc_obj(*cdns_mhdp_state);
>  	if (!cdns_mhdp_state)
>  		return NULL;
>  
> -	__drm_atomic_helper_bridge_state_init(bridge, &cdns_mhdp_state->base);
> +	__drm_atomic_helper_bridge_state_init(&cdns_mhdp_state->base, bridge);
>  
>  	return &cdns_mhdp_state->base;
>  }
>  
>  static u32 *cdns_mhdp_get_input_bus_fmts(struct drm_bridge *bridge,
> diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
> index c38e514f336f..8f04eae7a754 100644
> --- a/drivers/gpu/drm/drm_atomic_state_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_state_helper.c
> @@ -886,19 +886,19 @@ void drm_atomic_helper_bridge_destroy_state(struct drm_bridge *bridge,
>  EXPORT_SYMBOL(drm_atomic_helper_bridge_destroy_state);
>  
>  /**
>   * __drm_atomic_helper_bridge_state_init() - Initialize a bridge state to its
>   *					default
> - * @bridge: the bridge this state refers to
>   * @state: bridge state to initialize
> + * @bridge: the bridge this state refers to
>   *
>   * Initializes the bridge state to default values. This is meant to be called
>   * by the bridge &drm_bridge_funcs.atomic_reset hook for bridges that subclass
>   * the bridge state.
>   */
> -void __drm_atomic_helper_bridge_state_init(struct drm_bridge *bridge,
> -				      struct drm_bridge_state *state)
> +void __drm_atomic_helper_bridge_state_init(struct drm_bridge_state *state,
> +					   struct drm_bridge *bridge)
>  {
>  	memset(state, 0, sizeof(*state));
>  	__drm_atomic_helper_private_obj_create_state(&bridge->base, &state->base);
>  	state->bridge = bridge;
>  }
> @@ -920,9 +920,9 @@ drm_atomic_helper_bridge_reset(struct drm_bridge *bridge)
>  
>  	bridge_state = kzalloc_obj(*bridge_state);
>  	if (!bridge_state)
>  		return ERR_PTR(-ENOMEM);
>  
> -	__drm_atomic_helper_bridge_reset(bridge, bridge_state);
> +	__drm_atomic_helper_bridge_state_init(bridge_state, bridge);

This hunk belongs to 01/76.

>  	return bridge_state;
>  }
>  EXPORT_SYMBOL(drm_atomic_helper_bridge_reset);
> diff --git a/include/drm/drm_atomic_state_helper.h b/include/drm/drm_atomic_state_helper.h
> index 6a715d8e1f4a..cbc760598b9e 100644
> --- a/include/drm/drm_atomic_state_helper.h
> +++ b/include/drm/drm_atomic_state_helper.h
> @@ -100,9 +100,9 @@ void __drm_atomic_helper_bridge_duplicate_state(struct drm_bridge *bridge,
>  						struct drm_bridge_state *state);
>  struct drm_bridge_state *
>  drm_atomic_helper_bridge_duplicate_state(struct drm_bridge *bridge);
>  void drm_atomic_helper_bridge_destroy_state(struct drm_bridge *bridge,
>  					    struct drm_bridge_state *state);
> -void __drm_atomic_helper_bridge_state_init(struct drm_bridge *bridge,
> -				      struct drm_bridge_state *state);
> +void __drm_atomic_helper_bridge_state_init(struct drm_bridge_state *state,
> +					   struct drm_bridge *bridge);
>  struct drm_bridge_state *
>  drm_atomic_helper_bridge_reset(struct drm_bridge *bridge);
> 

-- 
Regards,

Laurent Pinchart
