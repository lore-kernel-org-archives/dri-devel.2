Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF5710F9951
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 15:32:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E49BA10E4D2;
	Wed,  8 Apr 2026 15:32:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="nMmNdY+D";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12DEF10E4D2
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 15:32:10 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id CE4C2C5AA98;
 Wed,  8 Apr 2026 15:32:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 7A275603CB;
 Wed,  8 Apr 2026 15:32:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id EEF0B104500FE; 
 Wed,  8 Apr 2026 17:32:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1775662327; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=D6wwHgL4qxNF79DvLc8v4w9tKYZJfLiounJZIjveOxw=;
 b=nMmNdY+D3FB5AotrSzWu5hFDk78Cvx19H94Y4pPl1dMf9s4HovskEJENJpWKX662jX+z8o
 ie29LisVRCb5D4mDW1sedWF4B/HVAaQeptSxY2uVyYU4lRcauYdmaQ19COi2Alq4NKKr0r
 Ci7pWzkDrIPeYqlUvrBfSoU0Svn5+t2iP6gjSJYhhr1ElW6LP05xLv90FiFj5aJt5R/f7d
 OtEZ/akpIHNwzsxcZGOqa7+5cfKyNWYVaps3oBHAl0kCreC1gC6Jk+6/NAYLyKZR/UfwVI
 TmoE6hVsjzgbVXC9+SHJLKuQfw28wBvwYCEksmQCu653nDQ2PvqRp1i4E7EIlw==
Message-ID: <161bd1c9-4015-4d56-95ad-7e5c4d57d7aa@bootlin.com>
Date: Wed, 8 Apr 2026 17:32:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/bridge: ti-sn65dsi83: fix CHA_DSI_CLK_RANGE
 rounding
To: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Frieder Schrempf <frieder.schrempf@kontron.de>, Marek Vasut <marex@denx.de>,
 Linus Walleij <linusw@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260226-ti-sn65dsi83-dual-lvds-fixes-and-test-pattern-v1-0-2e15f5a9a6a0@bootlin.com>
 <20260226-ti-sn65dsi83-dual-lvds-fixes-and-test-pattern-v1-1-2e15f5a9a6a0@bootlin.com>
From: Louis Chauvet <louis.chauvet@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260226-ti-sn65dsi83-dual-lvds-fixes-and-test-pattern-v1-1-2e15f5a9a6a0@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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



On 2/26/26 17:16, Luca Ceresoli wrote:
> The DSI frequency must be in the range:
> 
>    (CHA_DSI_CLK_RANGE * 5 MHz) <= DSI freq < ((CHA_DSI_CLK_RANGE + 1) * 5 MHz)
> 
> So the register value shouldpoint to the lower range value, but
> DIV_ROUND_UP() rounds the division to the higher range value, resulting in
> an excess of 1 (unless the frequency is an exact multiple of 5 MHz).
> 
> For example for a 437100000 MHz clock CHA_DSI_CLK_RANGE should be 87 (0x57):
> 
>    (87 * 5 = 435) <= 437.1 < (88 * 5 = 440)
> 
> but current code returns 88 (0x58).
> 
> Fix the computation by removing the DIV_ROUND_UP().
> 
> Fixes: ceb515ba29ba ("drm/bridge: ti-sn65dsi83: Add TI SN65DSI83 and SN65DSI84 driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>   drivers/gpu/drm/bridge/ti-sn65dsi83.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> index f6736b4457bb..d2a81175d279 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> @@ -351,9 +351,9 @@ static u8 sn65dsi83_get_dsi_range(struct sn65dsi83 *ctx,
>   	 *  DSI_CLK = mode clock * bpp / dsi_data_lanes / 2
>   	 * the 2 is there because the bus is DDR.
>   	 */
> -	return DIV_ROUND_UP(clamp((unsigned int)mode->clock *
> -			    mipi_dsi_pixel_format_to_bpp(ctx->dsi->format) /
> -			    ctx->dsi->lanes / 2, 40000U, 500000U), 5000U);
> +	return clamp((unsigned int)mode->clock *
> +		     mipi_dsi_pixel_format_to_bpp(ctx->dsi->format) /
> +		     ctx->dsi->lanes / 2, 40000U, 500000U) / 5000U;

If you need to do a v2, I think it could be nice to introduce one or two 
intermediate variable to allow a human to read this line:

required_bitrate = pixel_clock * bpp;
lane_rate = required_bitrate / lanes / 2;
return clamp(lane_rate) / 5000;

With or without this:

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

>   }
>   
>   static u8 sn65dsi83_get_dsi_div(struct sn65dsi83 *ctx)
> 

