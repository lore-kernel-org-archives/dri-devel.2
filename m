Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B909BFF8867
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 13:42:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CD0410F01F;
	Wed, 29 Apr 2026 13:42:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="WLNb6D/4";
	dkim-atps=neutral
X-Greylist: delayed 518 seconds by postgrey-1.36 at gabe;
 Wed, 29 Apr 2026 13:42:18 UTC
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9624010F01E
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 13:42:18 +0000 (UTC)
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 3AF081FB70;
 Wed, 29 Apr 2026 15:33:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1777469617;
 bh=ZFHuOmltmFo8Rwni2y+lGo+CzUf7wYN17q7s/CcnxnM=; h=From:To:Subject;
 b=WLNb6D/4K8Sp57Kr3Ua0gfYVJN1Kb0QT3PRUh9sMP/h3wEvTvU/K5bTaHSPLp+Ngn
 bFFaYSWWz9C2TOsYHCvo9QyyWTgw4Tusv8iphsoxeBD6MvItiCVldUlFpRFAkz4lJ7
 3Vqs5yHtvsYLvcF00GKaSETZHlw2JS+xpNmp9uPt/N6XUBOd1nU70/Zxi0v4sgSZuz
 QMcyRYk/NHy8Hk7BbltkYcZXIwDz1IhfjXhGzVJdhk1NAB32U2QFHNELk3ognz51dh
 h79REnjTpwkSxPorFNaDVeKGA5iRkgZ7Q7iL2ce+3FbOcDC9wSN12BwDHRp695DIGI
 sDdqgV0+Ow3mg==
Date: Wed, 29 Apr 2026 15:33:33 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: max.oss.09@gmail.com, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Adrien Grassein <adrien.grassein@gmail.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, David Airlie <airlied@gmail.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Robert Foss <rfoss@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: lontium-lt8912b: Do not generate HFP
Message-ID: <20260429133333.GA68737@francesco-nb>
References: <20250728150059.2642055-1-max.oss.09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728150059.2642055-1-max.oss.09@gmail.com>
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

+Dmitry, Luca

Hello all,
how to get this patch considered and eventually merged? I see that this
is not moving since long.

Considering that Adrien Grassein is not visible on the mailing list
since 2022, and that I have various HW available that is using this
combination (on TI Sitara and Jacinto, on a DPI-DSI tc358768 bridge,
and NXP i.MX), I have access to the (little) documentation that is
available from Lontium I can propose myself as a maintainer here.

I assume being able to ack patches would help the maintenance here, or
is this just a glitch and a ping was enough?

Dmitry, Luca: looking at the recent commits you are the one who merged
the most patches on drivers/gpu/drm/bridge lately, what's you advise?

Francesco

On Mon, Jul 28, 2025 at 05:00:50PM +0200, max.oss.09@gmail.com wrote:
> From: Max Krummenacher <max.krummenacher@toradex.com>
> 
> The datasheet of lontium-lt8912b doesn't require blanking during
> the HFP period. Thus use LP during HFP.
> 
> Tested with a samsung-dsim (i.MX8 MM) and a tc358768 DPI to DSI bridge
> as the DSI host.
> 
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
> 
> ---
> 
>  drivers/gpu/drm/bridge/lontium-lt8912b.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/bridge/lontium-lt8912b.c b/drivers/gpu/drm/bridge/lontium-lt8912b.c
> index 3e49d855b364..760d89493276 100644
> --- a/drivers/gpu/drm/bridge/lontium-lt8912b.c
> +++ b/drivers/gpu/drm/bridge/lontium-lt8912b.c
> @@ -494,6 +494,7 @@ static int lt8912_attach_dsi(struct lt8912 *lt)
>  
>  	dsi->mode_flags = MIPI_DSI_MODE_VIDEO |
>  			  MIPI_DSI_MODE_LPM |
> +			  MIPI_DSI_MODE_VIDEO_NO_HFP |
>  			  MIPI_DSI_MODE_NO_EOT_PACKET;
>  
>  	ret = devm_mipi_dsi_attach(dev, dsi);
> -- 
> 2.42.0
> 
