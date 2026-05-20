Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEE3CCD4F5E
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 06:46:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D9DC10EEFF;
	Wed, 20 May 2026 06:46:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="MPo/MyjF";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 079C210EEFF
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 06:46:07 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 72426C2B9FA;
 Wed, 20 May 2026 06:46:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id AC8436070E;
 Wed, 20 May 2026 06:46:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7F087107E8EB1; 
 Wed, 20 May 2026 08:45:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1779259562; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=dKcYje4RS7cFmYoZ2tIYKDA+VMl5+PAkjiozJ5zsCH4=;
 b=MPo/MyjFKZ6BLm7Xiy+fB0ERKTpIT0x6QG+V098ck6ZrRqCxnovmlWjPKem/Awa8nRtVV+
 I7TOtCWoxJEkX1bOZTr8+JUy26Fm7leRcwuQQFlxzJWJZbVOgmhNoDitsYwqnkKJqipDxb
 wiKdpc1Vmww38H2Xkj5bjaekS8bK8sdcWHRGOCiVYkeTHonfCOH8g8BKk+x2s8TPSUrDGA
 FEczjeTg5EUO/2/MDs29H+6Jq/BSFK9aNLeTpyFGmiUK4/rB4fFd68inDJvxE0BjyFkUBt
 q8c4k1nLmHbvNtJbKPg0Ce8TtFJzhug7firDgpkrVHalWizJUAcg2FPap/P3VA==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v7 04/23] drm: bridge: dw_hdmi: Hold bridge ref until
 connector cleanup
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, Liu Ying <victor.liu@nxp.com>, 
 Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>, 
 Chen-Yu Tsai <wens@kernel.org>, 
 Christian Hewitt <christianshewitt@gmail.com>, 
 Diederik de Haas <diederik@cknow-tech.com>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org
In-Reply-To: <e90eddfc-2f57-418a-ae05-43a411d72b99@kwiboo.se>
References: <20260518180206.2480119-1-jonas@kwiboo.se>
 <20260518180206.2480119-5-jonas@kwiboo.se>
 <177919241969.545972.18169905222569864569.b4-review@b4>
 <e90eddfc-2f57-418a-ae05-43a411d72b99@kwiboo.se>
Date: Wed, 20 May 2026 08:45:49 +0200
Message-Id: <177925954999.1337464.14745526881417951688.b4-reply@b4>
X-Mailer: b4 0.15.2
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

Hello Jonas,

On 2026-05-19 17:18 +0200, Jonas Karlman wrote:
> Hello Luca,
>
> On 5/19/2026 2:06 PM, Luca Ceresoli wrote:
> > On Mon, 18 May 2026 18:01:40 +0000, Jonas Karlman <jonas@kwiboo.se> wrote:
> >
> > Hello Jonas,
> >
> >>
> >> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> >> index b7bfc0e9a6b2..9d795c550f8a 100644
> >> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> >> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> >> @@ -2600,10 +2609,14 @@ static int dw_hdmi_connector_create(struct dw_hdmi *hdmi)
> >>
> >>  	drm_connector_helper_add(connector, &dw_hdmi_connector_helper_funcs);
> >>
> >> -	drm_connector_init_with_ddc(hdmi->bridge.dev, connector,
> >> -				    &dw_hdmi_connector_funcs,
> >> -				    DRM_MODE_CONNECTOR_HDMIA,
> >> -				    hdmi->ddc);
> >> +	ret = drm_connector_init_with_ddc(hdmi->bridge.dev, connector,
> >> +					  &dw_hdmi_connector_funcs,
> >> +					  DRM_MODE_CONNECTOR_HDMIA,
> >> +					  hdmi->ddc);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	drm_bridge_get(&hdmi->bridge);
> >
> > I'm not fully following the code paths, but both the report and the fix
> > make sense to me. Only I'd move the drm_bridge_get() before
> > drm_connector_init_with_ddc(), to avoid a short window where no reference
> > is held and the bridge might be destroyed before drm_bridge_get() is
> > called. I'm not sure this can happen, but it's better to write the code in
> > a way that clearly makes it impossible.
>
> dw_hdmi_connector_create() is only called from dw_hdmi_bridge_attach()
> so the bridge should already have a ref for the lifetime of this call.

Ah, that's true. So the patch is correct.

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

In case you send a new iteration, please add this extra explanation to the
commit message, similar to the above paragraph.

> I explicitly chose the placement after drm_connector_init_with_ddc()
> to ensure ref count is correctly balanced without having to add a
> drm_bridge_put() call in any error path. I.e. connector destroy() is
> only called when drm_connector_init_with_ddc() succeeds.
>
> This code/call is also planned to be removed in a future series,

In order to remove the !DRM_BRIDGE_ATTACH_NO_CONNECTOR case? That would be
welcome!

Luca

