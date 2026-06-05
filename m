Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93412CD8C81
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 14:29:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A39C9112BAE;
	Fri,  5 Jun 2026 14:29:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="FZh+GZ8r";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3C2C11A8E8
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 14:29:31 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4393B1B9A;
 Fri,  5 Jun 2026 16:29:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1780669745;
 bh=sgma9xx/i7WxVMjTIPDg9O/kPeYmlUcLXiO3rUWnRTU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FZh+GZ8r98YZHB7IOeUK8oz1u8s2CU9uJdO1kl6UCF8dDRGc6jlL+5ZxzzmHapXWj
 tRFpoZbOxTdKx6oJrC80Ei+SNRWqFxnm3G+tK2Ko6FCksnf+uEQnawC0GLvfx7+1C4
 9WYRNcH6zYxh72sjyAmC128HZZp6PzqBNvmJYngQ=
Date: Fri, 5 Jun 2026 17:29:29 +0300
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
Subject: Re: [PATCH 05/76] drm/atomic-state-helper: Add
 drm_atomic_helper_bridge_create_state()
Message-ID: <20260605142929.GD84912@killaraus.ideasonboard.com>
References: <20260530-drm-no-more-bridge-reset-v1-0-875d828d31bc@kernel.org>
 <20260530-drm-no-more-bridge-reset-v1-5-875d828d31bc@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260530-drm-no-more-bridge-reset-v1-5-875d828d31bc@kernel.org>
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

On Sat, May 30, 2026 at 03:59:10PM +0200, Maxime Ripard wrote:
> The drm_atomic_helper_bridge_reset() helper is deprecated in favour
> of the new atomic_create_state callback.
> 
> Add drm_atomic_helper_bridge_create_state() as the counterpart helper
> for this new callback.

I'd write here that drivers will be converted to the new helper in
subsequent changes, and drm_atomic_helper_bridge_reset() then removed.

> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/drm_atomic_state_helper.c | 25 +++++++++++++++++++++++++
>  include/drm/drm_atomic_state_helper.h     |  2 ++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
> index f0688f2d83fe..b99dedbc4140 100644
> --- a/drivers/gpu/drm/drm_atomic_state_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_state_helper.c
> @@ -925,5 +925,30 @@ drm_atomic_helper_bridge_reset(struct drm_bridge *bridge)
>  
>  	__drm_atomic_helper_bridge_state_init(bridge_state, bridge);
>  	return bridge_state;
>  }
>  EXPORT_SYMBOL(drm_atomic_helper_bridge_reset);
> +
> +/**
> + * drm_atomic_helper_bridge_create_state - default &drm_bridge_funcs.atomic_create_state hook for bridges

Line wrap.

"default" is a bit misleading, I would assume it would be used by the
core if the .atomic_create_state() pointer was null. Maybe

 * drm_atomic_helper_bridge_create_state - Implementation of &drm_bridge_funcs.atomic_create_state
 *	for bridge drivers that do no subclass the state

But maybe that's a bit long. Up to you.

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> + * @bridge: bridge object
> + *
> + * Allocates and initializes pristine @drm_bridge_state.
> + *
> + * This is useful for drivers that don't subclass @drm_bridge_state.
> + *
> + * RETURNS:
> + * Pointer to new bridge state, or ERR_PTR on failure.
> + */
> +struct drm_bridge_state *
> +drm_atomic_helper_bridge_create_state(struct drm_bridge *bridge)
> +{
> +	struct drm_bridge_state *bridge_state;
> +
> +	bridge_state = kzalloc_obj(*bridge_state);
> +	if (!bridge_state)
> +		return ERR_PTR(-ENOMEM);
> +
> +	__drm_atomic_helper_bridge_state_init(bridge_state, bridge);
> +	return bridge_state;
> +}
> +EXPORT_SYMBOL(drm_atomic_helper_bridge_create_state);
> diff --git a/include/drm/drm_atomic_state_helper.h b/include/drm/drm_atomic_state_helper.h
> index cbc760598b9e..68c685ad330f 100644
> --- a/include/drm/drm_atomic_state_helper.h
> +++ b/include/drm/drm_atomic_state_helper.h
> @@ -103,6 +103,8 @@ drm_atomic_helper_bridge_duplicate_state(struct drm_bridge *bridge);
>  void drm_atomic_helper_bridge_destroy_state(struct drm_bridge *bridge,
>  					    struct drm_bridge_state *state);
>  void __drm_atomic_helper_bridge_state_init(struct drm_bridge_state *state,
>  					   struct drm_bridge *bridge);
>  struct drm_bridge_state *
> +drm_atomic_helper_bridge_create_state(struct drm_bridge *bridge);
> +struct drm_bridge_state *
>  drm_atomic_helper_bridge_reset(struct drm_bridge *bridge);
> 

-- 
Regards,

Laurent Pinchart
