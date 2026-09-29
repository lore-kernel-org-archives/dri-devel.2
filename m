Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C51CFCA5FA1
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 10:39:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F3A810EE2F;
	Tue, 29 Sep 2026 10:39:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="y8iHsgOz";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A31BD10EE2E
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 10:39:30 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 5A6944E410B7;
 Tue, 29 Sep 2026 10:39:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 22DB3601BD;
 Tue, 29 Sep 2026 10:39:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 229EF103295E3; 
 Tue, 29 Sep 2026 12:39:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790678366; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=lGp4cm2Ao4TU3TW+1e8kXshs8WwzfjIeavwApsw+nKM=;
 b=y8iHsgOzqp61uI69hlHbnIn/SOZzJaK4I0ClIaNgnr4hF/z9198ioBh7DYqGI9U233L00z
 ityL4ZmohA70XfIBALxxdj3B2rfdgFw5h6ES+FCV6paHkLemgBSI3x91FGgUVtPSjFQeyn
 awOVxDv33Tk02Wpn0gJXsrG4zjWvZ7vOfP46TV0dXrZnS92da4hCDQV0ADHB2rxTk1oJIO
 B4eczD1RtoTAsKosdL9QrrjZjQxNEXqbYrMDSlOK9ko8dO0foldA0AsPlk8HEUKI0bRVI2
 bgZI7tvR2MpxS2FJuF8WpqbEdShvEiv9PnLK6GykO6Xvl+Ylz08gtDyawQ3+kw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 29 Sep 2026 12:39:09 +0200
Message-Id: <DLRQHX9JC9YJ.1HR59B2KFZ90L@bootlin.com>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>, "Arnd Bergmann"
 <arnd@kernel.org>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH] drm/bridge: add missing drm/drm_panel.h inclusions
Cc: "Arnd Bergmann" <arnd@arndb.de>, "Sasha Finkelstein" <k@chaosmail.tech>,
 "Janne Grunau" <j@jannau.net>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "Manikandan Muralidharan"
 <manikandan.m@microchip.com>, "Dharma Balasubiramani"
 <dharma.b@microchip.com>, "Nicolas Ferre" <nicolas.ferre@microchip.com>,
 "Alexandre Belloni" <alexandre.belloni@bootlin.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>, "Jagan Teki" <jagan@amarulasolutions.com>,
 "Andrzej Hajda" <andrzej.hajda@intel.com>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Robert Foss" <rfoss@kernel.org>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman"
 <jonas@kwiboo.se>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Liu Ying"
 <victor.liu@nxp.com>, "Frank Li" <Frank.Li@nxp.com>, "Sascha Hauer"
 <s.hauer@pengutronix.de>, "Pengutronix Kernel Team"
 <kernel@pengutronix.de>, "Fabio Estevam" <festevam@gmail.com>, "Douglas
 Anderson" <dianders@chromium.org>, "Philipp Zabel"
 <p.zabel@pengutronix.de>, "Chun-Kuang Hu" <chunkuang.hu@kernel.org>,
 "Matthias Brugger" <matthias.bgg@gmail.com>, "AngeloGioacchino Del Regno"
 <angelogioacchino.delregno@collabora.com>, "Rob Clark"
 <robin.clark@oss.qualcomm.com>, "Dmitry Baryshkov" <lumag@kernel.org>,
 "Abhinav Kumar" <abhinav.kumar@linux.dev>, "Jessica Zhang"
 <jesszhan0024@gmail.com>, "Sean Paul" <sean@poorly.run>, "Marijn Suijten"
 <marijn.suijten@somainline.org>, "Marek Vasut" <marex@denx.de>, "Stefan
 Agner" <stefan@agner.ch>, "Orson Zhai" <orsonzhai@gmail.com>, "Baolin Wang"
 <baolin.wang@linux.alibaba.com>, "Chunyan Zhang" <zhang.lyra@gmail.com>,
 "Jyri Sarha" <jyri.sarha@iki.fi>, "Tomi Valkeinen"
 <tomi.valkeinen@ideasonboard.com>, "Icenowy Zheng"
 <zhengxingda@iscas.ac.cn>, <dri-devel@lists.freedesktop.org>,
 <asahi@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <imx@lists.linux.dev>,
 <linux-mediatek@lists.infradead.org>, <linux-arm-msm@vger.kernel.org>,
 <freedreno@lists.freedesktop.org>
X-Mailer: aerc 0.22.0
References: <20260928161605.2271412-1-arnd@kernel.org>
 <DLRMF4TI56I2.3PTB24KN9ORJ3@bootlin.com>
In-Reply-To: <DLRMF4TI56I2.3PTB24KN9ORJ3@bootlin.com>
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

Hello,

On Tue Sep 29, 2026 at 9:27 AM CEST, Luca Ceresoli wrote:
> Hello Arnd,
>
> On Mon Sep 28, 2026 at 6:04 PM CEST, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> The devm_drm_of_get_bridge() declaration moved to drm_panel.h, but
>> not all callers include this, which leads to build failures in
>> some configurations:
>>
>> drivers/gpu/drm/imx/lcdc/imx-lcdc.c: In function 'imx_lcdc_probe':
>> drivers/gpu/drm/imx/lcdc/imx-lcdc.c:404:18: error: implicit declaration =
of function 'devm_drm_of_get_bridge' [-Wimplicit-function-declaration]
>>   404 |         bridge =3D devm_drm_of_get_bridge(dev, dev->of_node, 0, =
0);
>>       |                  ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/verisilicon/vs_bridge.c: In function 'vs_bridge_init':
>> drivers/gpu/drm/verisilicon/vs_bridge.c:306:16: error: implicit declarat=
ion of function 'devm_drm_of_get_bridge' [-Wimplicit-function-declaration]
>>   306 |         next =3D devm_drm_of_get_bridge(drm_dev->dev, drm_dev->d=
ev->of_node,
>>       |                ^~~~~~~~~~~~~~~~~~~~~~
>>
>> Include the new header in all files that need it.
>>
>> Fixes: aa8a8c7e4641 ("drm/bridge: panel: move all code to drm_panel.c")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Thanks for the very quick reaction to this regression! However I think we
> should fix it differently.
>
> I had definitely build-tested most if not all these drivers, and also
> runtime tested a few. Now I realized the build failure actually happens
> only in !OF defconfigs which I haven't build-tested (sorry about
> that!). Here's why:
>
>  * the affected drivers (all or most of them) include drm_of.h
>  * drm_of.h does:
>      #if IS_ENABLED(CONFIG_OF) && IS_ENABLED(CONFIG_DRM_PANEL_BRIDGE)
>      #include <linux/of.h>
>      #include <drm/drm_bridge.h>
>      #include <drm/drm_panel.h>
>      #endif
>  * DRM_PANEL_BRIDGE is always set when DRM is set, so not a problem
>  * drivers which don't depend on OF and don't include drm_panel.h now fai=
l
>
> Most of the drivers changed by this patch do 'depend on OF', so they are
> not affected. So the patch could be trimmed significantly. But still I'm
> not in favor of including drm_panel.h in the remaining drivers, because:
>
>  * in the first place most/all of these drivers are now supposed to not u=
se
>    the drm_panel API anymore; thsy should just use the drm_bridge API
>
>  * devm_drm_of_get_bridge() is now a deprecated [0], complicated way of
>    calling of_drm_get_bridge_by_endpoint(), which is rightfully in
>    drm_bridge.h
>    * for this reason Documentation/drm/todo.rst says it must be removed [=
1]
>    * removal is easy, so I plan to do it in a few weeks globally
>    * after the removal all these #include <drm_panel.h> would have to
>      be removed, but some might easily be forgotten
>
> So I see two option for a better fix:
>
>  * Option 1 -- fix the really affected drivers by switching from the
>    deprecated API to the one they recommended one. Based on quick analysi=
s
>    there are about 6.
>
>  * Option 2 -- a quick surgical fix:
>
>    In drm_of.h:
>
>      #if IS_ENABLED(CONFIG_OF) && IS_ENABLED(CONFIG_DRM_PANEL_BRIDGE)
>       #include <linux/of.h>
>       #include <drm/drm_bridge.h>
>      -#include <drm/drm_panel.h>
>       #endif
>      +#include <drm/drm_panel.h> /* Temporary for *_of_get_bridge() */
>
>    This can easily be tracked and reverted once all
>    devm_drm_of_get_bridge() users are converted to
>    of_drm_get_bridge_by_endpoint().
>
> I'm working right now on option 1, hoping to get a series in a few hours
> from now. I can switch to option 2 in case of unexpected issues with opti=
on
> 1, or if a fix "really right now" is wanted.

Done [0]. I found only 3 drivers affected, but I fixed all the others that
build without OF.

[0] https://lore.kernel.org/r/20260929-drm-fix-of_get_bridge-build-regressi=
on-v1-0-ccb7e602daad@bootlin.com

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
