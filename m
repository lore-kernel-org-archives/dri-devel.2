Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE96110775EB
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 17:40:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 221A510E02A;
	Wed, 18 Mar 2026 17:40:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="jVX5SNkC";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D91610E02A
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 17:40:03 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-703d-e500--2a1.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::2a1])
 by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 88D7B460;
 Wed, 18 Mar 2026 18:38:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1773855528;
 bh=AfoBKJ899kYDC02RCdrWGnp38KlkLKQkFxjJaZg3Z0M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jVX5SNkCqRiiVm1FzFn2Awdxhb9SvVwO1DTVKpsoLXblHvzYdeXoEKJ1WHXR69X6o
 +HX488OEcUAkSJZ8qCVsgs4W1kNBEZ5J/M+uRvdQlUU9g7E7fqAOh6dlFIJqMXmb/g
 3YI85z0ZEsKFdRAp5wDNwNZ8uDCQiE35jUQbl8Po=
Date: Wed, 18 Mar 2026 19:40:00 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Tomi Valkeinen <tomi.valkeinen@ti.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Sam Ravnborg <sam@ravnborg.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/bridge: display-connector: trigger initial HPD
 event for DP
Message-ID: <20260318174000.GK633439@killaraus.ideasonboard.com>
References: <20260314-dp-connector-hpd-v1-0-786044cedc17@oss.qualcomm.com>
 <20260314-dp-connector-hpd-v1-2-786044cedc17@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260314-dp-connector-hpd-v1-2-786044cedc17@oss.qualcomm.com>
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

Hi Dmitry,

Thank you for the patch.

On Sat, Mar 14, 2026 at 02:43:12AM +0200, Dmitry Baryshkov wrote:
> If the DisplayPort drivers use display-connector for the HPD detection,
> the internal HPD state machine might be not active and thus the hardware
> might be not able to handle cable detection correctly. Instead it will
> depend on the externall HPD notifications to set the cable state,
> bypassing the internal HPD state machine (for example this is the case
> for the msm DP driver).
> 
> However if the cable has been plugged before the HPD IRQ has been
> enabled, there will be no HPD event coming. The drivers might fail
> detection in such a case. Trigger the HPD notification after enabling
> the HPD IRQ, propagating the cable insertion state.

The explanation makes sense, but it sounds like to could apply the same
way to HDMI. What am I missing ?

Also, wouldn't it be better if the DRM core interrogated the state of
the HPD signal when enabling HPD, instead of relying on all drivers to
implement something similar as this patch ?

> Fixes: 2e2bf3a5584d ("drm/bridge: display-connector: add DP support")
> Reported-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/bridge/display-connector.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/display-connector.c b/drivers/gpu/drm/bridge/display-connector.c
> index 6bb1134f75c3..f7a5bfd9c075 100644
> --- a/drivers/gpu/drm/bridge/display-connector.c
> +++ b/drivers/gpu/drm/bridge/display-connector.c
> @@ -12,6 +12,7 @@
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/workqueue.h>
>  
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_bridge.h>
> @@ -25,6 +26,8 @@ struct display_connector {
>  
>  	struct regulator	*supply;
>  	struct gpio_desc	*ddc_en;
> +
> +	struct work_struct	hpd_work;
>  };
>  
>  static inline struct display_connector *
> @@ -92,15 +95,29 @@ static void display_connector_hpd_enable(struct drm_bridge *bridge)
>  	struct display_connector *conn = to_display_connector(bridge);
>  
>  	enable_irq(conn->hpd_irq);
> +
> +	if (conn->bridge.type == DRM_MODE_CONNECTOR_DisplayPort)
> +		schedule_work(&conn->hpd_work);
>  }
>  
>  static void display_connector_hpd_disable(struct drm_bridge *bridge)
>  {
>  	struct display_connector *conn = to_display_connector(bridge);
>  
> +	if (conn->bridge.type == DRM_MODE_CONNECTOR_DisplayPort)
> +		cancel_work_sync(&conn->hpd_work);
> +
>  	disable_irq(conn->hpd_irq);
>  }
>  
> +static void display_connector_hpd_work(struct work_struct *work)
> +{
> +	struct display_connector *conn = container_of(work, struct display_connector, hpd_work);
> +	struct drm_bridge *bridge = &conn->bridge;
> +
> +	drm_bridge_hpd_notify(bridge, display_connector_detect(bridge));
> +}
> +
>  static const struct drm_edid *display_connector_edid_read(struct drm_bridge *bridge,
>  							  struct drm_connector *connector)
>  {
> @@ -395,6 +412,8 @@ static int display_connector_probe(struct platform_device *pdev)
>  		conn->bridge.ops |= DRM_BRIDGE_OP_DETECT;
>  	if (conn->hpd_irq >= 0)
>  		conn->bridge.ops |= DRM_BRIDGE_OP_HPD;
> +	if (conn->hpd_irq >= 0 && type == DRM_MODE_CONNECTOR_DisplayPort)
> +		INIT_WORK(&conn->hpd_work, display_connector_hpd_work);
>  
>  	dev_dbg(&pdev->dev,
>  		"Found %s display connector '%s' %s DDC bus and %s HPD GPIO (ops 0x%x)\n",
> 

-- 
Regards,

Laurent Pinchart
