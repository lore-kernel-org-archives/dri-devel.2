Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D961CD6E7D
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 14:33:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 743D111A8FF;
	Fri,  5 Jun 2026 14:33:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="LPrk8VRd";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8009211A8F8
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 14:33:54 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 01F7B1B9A;
 Fri,  5 Jun 2026 16:33:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1780670008;
 bh=fKOydDY01wwLctiiCSC4TEDnSOZ+sGkGKApSf5FhRyk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LPrk8VRdRrBcaUMje9vTQYQZvnlVZ1eL1qVnc3Pa6j7tvNTfyZ9JsLRxYvITfzyOS
 TuosXAg2wLz+u1eMQLZqZN1ZENYU4lI0DX9ZcnzaorLiyGPCiMVe4XmAoCLS8ZeECb
 GK3aK+u7y6KdtHTAIzCl6vQmVUlE27tA9Y7ki7Z8=
Date: Fri, 5 Jun 2026 17:33:52 +0300
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
Subject: Re: [PATCH 24/76] drm/bridge: lvds-codec: Switch to
 atomic_create_state
Message-ID: <20260605143352.GF84912@killaraus.ideasonboard.com>
References: <20260530-drm-no-more-bridge-reset-v1-0-875d828d31bc@kernel.org>
 <20260530-drm-no-more-bridge-reset-v1-24-875d828d31bc@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260530-drm-no-more-bridge-reset-v1-24-875d828d31bc@kernel.org>
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

On Sat, May 30, 2026 at 03:59:29PM +0200, Maxime Ripard wrote:
> The drm_bridge_funcs.atomic_reset callback and its
> drm_atomic_helper_bridge_reset() helper are deprecated.
> 
> Switch to the atomic_create_state callback and its
> drm_atomic_helper_bridge_create_state() counterpart.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
>  drivers/gpu/drm/bridge/lvds-codec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/lvds-codec.c b/drivers/gpu/drm/bridge/lvds-codec.c
> index e6a7147e141b..d1135dc3b99f 100644
> --- a/drivers/gpu/drm/bridge/lvds-codec.c
> +++ b/drivers/gpu/drm/bridge/lvds-codec.c
> @@ -102,11 +102,11 @@ static const struct drm_bridge_funcs funcs = {
>  	.attach = lvds_codec_attach,
>  	.enable = lvds_codec_enable,
>  	.disable = lvds_codec_disable,
>  	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
>  	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
> -	.atomic_reset = drm_atomic_helper_bridge_reset,
> +	.atomic_create_state = drm_atomic_helper_bridge_create_state,
>  	.atomic_get_input_bus_fmts = lvds_codec_atomic_get_input_bus_fmts,
>  };
>  
>  static int lvds_codec_probe(struct platform_device *pdev)
>  {

-- 
Regards,

Laurent Pinchart
