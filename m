Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F17C531C9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 10:39:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 800D010F366;
	Fri, 24 Jul 2026 10:39:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="MxbYXGTv";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7376010F366
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 10:39:04 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 25EE7524;
 Fri, 24 Jul 2026 12:38:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1784889481;
 bh=Q4yNBPRBIx1D3lqZC83Z64WgzQW1tKnH/8t6iIPIxyM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MxbYXGTvvs1LY8pPOAe9cfgBf0s3vlBfyUF7iqeVpG6MTHLaE0Tg1m0/0TrA/EmNt
 W7Y7HFsBzsTmPTOnUNqQ76in7RlheqHz2WRdlw9r0xi54JWu4b8qZS53w/5AJElHX3
 NzlBsPp7RjEfdn4uffuyJ13Xrpd4qDouYRYOxTZY=
Date: Fri, 24 Jul 2026 13:39:01 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: phucduc.bui@gmail.com
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] drm/bridge: adv7511: use cache_only during power down
Message-ID: <20260724103901.GA1051157@killaraus.ideasonboard.com>
References: <20260724103235.57577-1-phucduc.bui@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260724103235.57577-1-phucduc.bui@gmail.com>
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

On Fri, Jul 24, 2026 at 05:32:35PM +0700, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> adv7511_power_on() and adv7511_power_off() restore the register state
> using regcache_mark_dirty() and regcache_sync(), but nothing prevents
> other code paths from accessing the registers over I2C while the chip
> is powered down.

Please give a detailed example of a scenario where that can happen, and
make sure you can reproduce the scenario and see the issue on your
hardware.

> Wrap the power-down window with regcache_cache_only() to prevent direct
> register accesses. It is unclear whether this is necessary or whether
> it could affect the CEC or packet sub-regmaps, so send this as an RFC.
> 
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
> ---
> 
> This RFC is related to the following patch series:
> https://lore.kernel.org/all/20260724100803.50169-1-phucduc.bui@gmail.com/
> 
>  drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> index 3e470366bce0..49da1806797b 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> @@ -323,6 +323,7 @@ static void adv7511_power_off(struct adv7511 *adv7511)
>  	__adv7511_power_off(adv7511);
>  	if (adv7511->info->has_dsi)
>  		adv7533_dsi_power_off(adv7511);
> +	regcache_cache_only(adv7511->regmap, true);
>  	adv7511->powered = false;
>  }
>  
> @@ -374,11 +375,13 @@ static void adv7511_power_on(struct adv7511 *adv7511)
>  	/*
>  	 * Most of the registers are reset during power down or when HPD is low.
>  	 */
> +	regcache_cache_only(adv7511->regmap, false);
>  	ret = regcache_sync(adv7511->regmap);
>  	if (ret) {
>  		dev_err(&adv7511->i2c_main->dev,
>  			"Failed to sync register cache: %d\n", ret);
>  		__adv7511_power_off(adv7511);
> +		regcache_cache_only(adv7511->regmap, true);
>  		return;
>  	}
>  

-- 
Regards,

Laurent Pinchart
