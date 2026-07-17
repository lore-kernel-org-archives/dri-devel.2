Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2373C4451C
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 12:22:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F294010F53D;
	Fri, 17 Jul 2026 12:22:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="tIC+ySsz";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08C8710F53D
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 12:22:22 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7A09C1337;
 Fri, 17 Jul 2026 14:21:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1784290884;
 bh=KC/MTNppPmvsxoG7oEAL0JWqaUV8QgDHm1Qegm/NhAM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tIC+ySszbPErHtri9MKLctyCpAe4lf1ZHZniZVeGQdeELRHo6yp9B34uPzO/lnxhW
 foF2bTF8wjdv/HT2S1inU7vxMkwsXk4w6wAm17iZh27gJCPR78gN4UTzUDtIFfzAZ/
 hFxazao3fUrb8z94X6/kCAM9Sc1LEk5JgNlnAgH0=
Date: Fri, 17 Jul 2026 15:22:19 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Johan Hovold <johan@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: dw-hdmi: fix i2c adapter leak on probe failure
Message-ID: <20260717122219.GC1926197@killaraus.ideasonboard.com>
References: <20260717090819.1630965-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260717090819.1630965-1-johan@kernel.org>
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

On Fri, Jul 17, 2026 at 11:08:19AM +0200, Johan Hovold wrote:
> Make sure to drop the i2c adapter device and module references before
> returning when detecting a malformed devicetree during probe.
> 
> Fixes: 80e2f97968b5 ("drm: bridge: dw-hdmi: Switch to regmap for register access")
> Cc: stable@vger.kernel.org	# 4.12
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 17d5caedb32e..9eb6cf8a321f 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -3389,7 +3389,8 @@ struct dw_hdmi *dw_hdmi_probe(struct platform_device *pdev,
>  			break;
>  		default:
>  			dev_err(dev, "reg-io-width must be 1 or 4\n");
> -			return ERR_PTR(-EINVAL);
> +			ret = -EINVAL;
> +			goto err_res;
>  		}
>  
>  		iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);

-- 
Regards,

Laurent Pinchart
