Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE80DCD98ED
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 08:17:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B53C10EEAD;
	Wed, 17 Jun 2026 08:17:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="QXYBGAOJ";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7273A10EEAD
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 08:17:47 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9C72543;
 Wed, 17 Jun 2026 10:17:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1781684231;
 bh=O1xOVyR8Ro+pXWqhTME17XcjkCqS0pf/9oQT6u5PaqQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QXYBGAOJccfTg7J9CW3WGbC9XYu70ihnDSvRLwZh0p4svbhqA1H7bPsZJsIYLy/sz
 b5/rfWNMCV3lYnpSzcn0f/wPhOOi7c3qKSjyU5rby8DeE3rx1i2U4lw7rLSkjJvDvn
 CFiYxqyyXIpMj8JiY0d+lm9Cs+9vm6lqgkaxr1vU=
Date: Wed, 17 Jun 2026 11:17:44 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Damon Ding <damon.ding@rock-chips.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v1] drm/bridge: of-display-mode-bridge: Fix missing
 static const for the bridge funcs
Message-ID: <20260617081744.GD3054789@killaraus.ideasonboard.com>
References: <20260617080755.186368-1-damon.ding@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260617080755.186368-1-damon.ding@rock-chips.com>
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

On Wed, Jun 17, 2026 at 04:07:55PM +0800, Damon Ding wrote:
> Add static qualifier for of_display_mode_bridge_funcs to resolve the
> sparse warning:
> 
> drivers/gpu/drm/bridge/of-display-mode-bridge.c:54:25: sparse: sparse:
> symbol 'of_display_mode_bridge_funcs' was not declared. Should it be
> static?
> 
> Also mark the structure const as required by devm_drm_bridge_alloc()
> parameter type constraints.
> 
> Fixes: ba2db93cf3d5 ("drm/bridge: Move legacy bridge driver out of imx directory for multi-platform use")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202606170744.FUStcWaB-lkp@intel.com/
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
>  drivers/gpu/drm/bridge/of-display-mode-bridge.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/of-display-mode-bridge.c b/drivers/gpu/drm/bridge/of-display-mode-bridge.c
> index cb15713f3a79..e66dae168fd0 100644
> --- a/drivers/gpu/drm/bridge/of-display-mode-bridge.c
> +++ b/drivers/gpu/drm/bridge/of-display-mode-bridge.c
> @@ -51,7 +51,7 @@ static int of_display_mode_bridge_get_modes(struct drm_bridge *bridge,
>  	return 0;
>  }
>  
> -struct drm_bridge_funcs of_display_mode_bridge_funcs = {
> +static const struct drm_bridge_funcs of_display_mode_bridge_funcs = {
>  	.attach = of_display_mode_bridge_attach,
>  	.get_modes = of_display_mode_bridge_get_modes,
>  };

-- 
Regards,

Laurent Pinchart
