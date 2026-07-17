Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD26C44520
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 12:20:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11ABC10F53C;
	Fri, 17 Jul 2026 12:20:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="kLTaWeiT";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAA6510F53C
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 12:20:38 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id D3800664;
 Fri, 17 Jul 2026 14:19:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1784290781;
 bh=YOVxSWiQL0aN807/SUl2kDGbkC7l6+xHHkmC1CBtUV0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kLTaWeiTH4uB2CjLg6ezM596tR2YuHRKYCqXnFBGwJE1amk6D1hhUCEQ3NIDLjRXz
 +Lumt58oVlS9OrxmA6SDszT2OwrMPROIS0BMSLBxB59wWHPQXXjv8EwTuLYbQur7BA
 rvhgxM2BJpfjMwPWBcJ6mqWorPte3iDzb9Zw2sBI=
Date: Fri, 17 Jul 2026 15:20:35 +0300
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
 stable@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 "H. Nikolaus Schaller" <hns@goldelico.com>,
 Dmitry Baryshkov <lumag@kernel.org>
Subject: Re: [PATCH] drm/bridge: display-connector: fix i2c adapter leak on
 probe failure
Message-ID: <20260717122035.GB1926197@killaraus.ideasonboard.com>
References: <20260717085716.1619275-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260717085716.1619275-1-johan@kernel.org>
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

Hi Johan,

Thank you for the patch.

On Fri, Jul 17, 2026 at 10:57:16AM +0200, Johan Hovold wrote:
> Make sure to drop the i2c adapter device and module references on failed
> regulator and enable gpio lookup (and regulator enable) during probe
> (e.g. on probe deferral).
> 
> Note that of_get_i2c_adapter_by_node() does not return error pointers,
> but i2c_put_adapter() can handle a NULL argument so the error pointer
> check at remove works even if it is misleading.

I've already sent a fix for this, see

https://lore.kernel.org/dri-devel/20260705213542.28987-3-laurent.pinchart+renesas@ideasonboard.com/

> Fixes: 2e2bf3a5584d ("drm/bridge: display-connector: add DP support")
> Fixes: 6de79dd3a920 ("drm/bridge: display-connector: add ddc-en gpio support")
> Fixes: 6eb6b6f0a012 ("drm/bridge: display-connector: handle hdmi-pwr supply")
> Cc: stable@vger.kernel.org	# 5.12
> Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> Cc: H. Nikolaus Schaller <hns@goldelico.com>
> Cc: Dmitry Baryshkov <lumag@kernel.org>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/gpu/drm/bridge/display-connector.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/display-connector.c b/drivers/gpu/drm/bridge/display-connector.c
> index 16c0631adeb1..c38de5518211 100644
> --- a/drivers/gpu/drm/bridge/display-connector.c
> +++ b/drivers/gpu/drm/bridge/display-connector.c
> @@ -208,6 +208,13 @@ static int display_connector_get_supply(struct platform_device *pdev,
>  	return PTR_ERR_OR_ZERO(conn->supply);
>  }
>  
> +static void display_connector_put_ddc(void *_ddc)
> +{
> +	struct i2c_adapter *ddc = _ddc;
> +
> +	i2c_put_adapter(ddc);
> +}
> +
>  static int display_connector_probe(struct platform_device *pdev)
>  {
>  	struct display_connector *conn;
> @@ -328,6 +335,12 @@ static int display_connector_probe(struct platform_device *pdev)
>  			of_node_put(phandle);
>  			if (!conn->bridge.ddc)
>  				return -EPROBE_DEFER;
> +
> +			ret = devm_add_action_or_reset(&pdev->dev,
> +						       display_connector_put_ddc,
> +						       conn->bridge.ddc);
> +			if (ret)
> +				return ret;
>  		} else {
>  			dev_dbg(&pdev->dev,
>  				"No I2C bus specified, disabling EDID readout\n");
> @@ -403,9 +416,6 @@ static void display_connector_remove(struct platform_device *pdev)
>  		regulator_disable(conn->supply);
>  
>  	drm_bridge_remove(&conn->bridge);
> -
> -	if (!IS_ERR(conn->bridge.ddc))
> -		i2c_put_adapter(conn->bridge.ddc);
>  }
>  
>  static const struct of_device_id display_connector_match[] = {

-- 
Regards,

Laurent Pinchart
