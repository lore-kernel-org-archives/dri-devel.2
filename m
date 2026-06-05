Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AAB0CD8C81
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 14:43:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2EB211A91D;
	Fri,  5 Jun 2026 14:43:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="h80lBYou";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4968F11A915
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 14:42:16 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id A5F071B9A;
 Fri,  5 Jun 2026 16:41:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1780670509;
 bh=3c9S6AvqIZGjec3iXpOoWc8DyJUHYUclh6bFa6A6ccE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=h80lBYouIcgb3ySELnvZ7QPqlB7XVV+zKmCBKhIu3iGbJFnCra3EstIFBtArQ/srU
 KpAhqzT5wiSeirmDXToJStHEi23ociSVN1ZZ1rqpk/PneYOekaGsgIiMrOQv+Dkypa
 OVFb+65pZtr17PW8HNbitTATvlg+85EfIYt+tOQY=
Date: Fri, 5 Jun 2026 17:42:13 +0300
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
Subject: Re: [PATCH 76/76] drm/bridge: Remove atomic_reset support
Message-ID: <20260605144213.GP84912@killaraus.ideasonboard.com>
References: <20260530-drm-no-more-bridge-reset-v1-0-875d828d31bc@kernel.org>
 <20260530-drm-no-more-bridge-reset-v1-76-875d828d31bc@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260530-drm-no-more-bridge-reset-v1-76-875d828d31bc@kernel.org>
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

On Sat, May 30, 2026 at 04:00:21PM +0200, Maxime Ripard wrote:
> There are no remaining users of the atomic_reset hook. Remove it
> from the core.

Removal of the .atomic_reset() operation needs to be moved here. With
that,

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/drm_bridge.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index ef06c1aa509a..945c48a985a4 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -498,14 +498,11 @@ static struct drm_private_state *
>  drm_bridge_atomic_create_priv_state(struct drm_private_obj *obj)
>  {
>  	struct drm_bridge *bridge = drm_priv_to_bridge(obj);
>  	struct drm_bridge_state *state;
>  
> -	if (bridge->funcs->atomic_create_state)
> -		state = bridge->funcs->atomic_create_state(bridge);
> -	else
> -		state = bridge->funcs->atomic_reset(bridge);
> +	state = bridge->funcs->atomic_create_state(bridge);
>  	if (IS_ERR(state))
>  		return ERR_CAST(state);
>  
>  	return &state->base;
>  }
> @@ -516,12 +513,11 @@ static const struct drm_private_state_funcs drm_bridge_priv_state_funcs = {
>  	.atomic_destroy_state = drm_bridge_atomic_destroy_priv_state,
>  };
>  
>  static bool drm_bridge_is_atomic(struct drm_bridge *bridge)
>  {
> -	return (bridge->funcs->atomic_create_state ||
> -		bridge->funcs->atomic_reset);
> +	return bridge->funcs->atomic_create_state != NULL;
>  }
>  
>  /**
>   * drm_bridge_attach - attach the bridge to an encoder's chain
>   *

-- 
Regards,

Laurent Pinchart
