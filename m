Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE81DCA5FA1
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 07:27:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B53310ED29;
	Tue, 29 Sep 2026 07:27:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="zUtWawuc";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70E6610ED29
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 07:27:51 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 8C60D4E410BA;
 Tue, 29 Sep 2026 07:27:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 56C1C601BD;
 Tue, 29 Sep 2026 07:27:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7A173102F1E1D; 
 Tue, 29 Sep 2026 09:27:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790666865; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=6z9//+D0Q6VMBTcc9ojEGZtfSdov1XXVNeeruScr3A0=;
 b=zUtWawucfhqE9LJMaIjV23h5QqOgTgci0S2/yjUEsAvPdCO6+bcMPxKW3dwUHIgc/dlDHx
 5I7l8Yg/Hj68EnIDUYKxmON+sEx9ElxKZIwM2kR31LlP61b/94Qkrq23jBaphNnrwKs20S
 S+stRQckkC6yK420QjVVmcJafrgIWE3JAUWRcCkZvA422vzZSW+RfAYUzjTJFwF9VSpQa7
 kww6z0UxwVbrMy4jFGgWYj6glw/rQUkcdAchSzs5Qhzh/QBOIjS/dgAh0Fi4oSTnV/7GHL
 SbBfslNPDNdkpmRMeIYgidzdyu0XQ6VG0OWSxpY8ucTWEpvnzYDlSxWjUShPyQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 29 Sep 2026 09:27:26 +0200
Message-Id: <DLRMF4TI56I2.3PTB24KN9ORJ3@bootlin.com>
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
To: "Arnd Bergmann" <arnd@kernel.org>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.22.0
References: <20260928161605.2271412-1-arnd@kernel.org>
In-Reply-To: <20260928161605.2271412-1-arnd@kernel.org>
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

Hello Arnd,

On Mon Sep 28, 2026 at 6:04 PM CEST, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> The devm_drm_of_get_bridge() declaration moved to drm_panel.h, but
> not all callers include this, which leads to build failures in
> some configurations:
>
> drivers/gpu/drm/imx/lcdc/imx-lcdc.c: In function 'imx_lcdc_probe':
> drivers/gpu/drm/imx/lcdc/imx-lcdc.c:404:18: error: implicit declaration o=
f function 'devm_drm_of_get_bridge' [-Wimplicit-function-declaration]
>   404 |         bridge =3D devm_drm_of_get_bridge(dev, dev->of_node, 0, 0=
);
>       |                  ^~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/verisilicon/vs_bridge.c: In function 'vs_bridge_init':
> drivers/gpu/drm/verisilicon/vs_bridge.c:306:16: error: implicit declarati=
on of function 'devm_drm_of_get_bridge' [-Wimplicit-function-declaration]
>   306 |         next =3D devm_drm_of_get_bridge(drm_dev->dev, drm_dev->de=
v->of_node,
>       |                ^~~~~~~~~~~~~~~~~~~~~~
>
> Include the new header in all files that need it.
>
> Fixes: aa8a8c7e4641 ("drm/bridge: panel: move all code to drm_panel.c")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for the very quick reaction to this regression! However I think we
should fix it differently.

I had definitely build-tested most if not all these drivers, and also
runtime tested a few. Now I realized the build failure actually happens
only in !OF defconfigs which I haven't build-tested (sorry about
that!). Here's why:

 * the affected drivers (all or most of them) include drm_of.h
 * drm_of.h does:
     #if IS_ENABLED(CONFIG_OF) && IS_ENABLED(CONFIG_DRM_PANEL_BRIDGE)
     #include <linux/of.h>
     #include <drm/drm_bridge.h>
     #include <drm/drm_panel.h>
     #endif
 * DRM_PANEL_BRIDGE is always set when DRM is set, so not a problem
 * drivers which don't depend on OF and don't include drm_panel.h now fail

Most of the drivers changed by this patch do 'depend on OF', so they are
not affected. So the patch could be trimmed significantly. But still I'm
not in favor of including drm_panel.h in the remaining drivers, because:

 * in the first place most/all of these drivers are now supposed to not use
   the drm_panel API anymore; thsy should just use the drm_bridge API

 * devm_drm_of_get_bridge() is now a deprecated [0], complicated way of
   calling of_drm_get_bridge_by_endpoint(), which is rightfully in
   drm_bridge.h
   * for this reason Documentation/drm/todo.rst says it must be removed [1]
   * removal is easy, so I plan to do it in a few weeks globally
   * after the removal all these #include <drm_panel.h> would have to
     be removed, but some might easily be forgotten

So I see two option for a better fix:

 * Option 1 -- fix the really affected drivers by switching from the
   deprecated API to the one they recommended one. Based on quick analysis
   there are about 6.

 * Option 2 -- a quick surgical fix:

   In drm_of.h:

     #if IS_ENABLED(CONFIG_OF) && IS_ENABLED(CONFIG_DRM_PANEL_BRIDGE)
      #include <linux/of.h>
      #include <drm/drm_bridge.h>
     -#include <drm/drm_panel.h>
      #endif
     +#include <drm/drm_panel.h> /* Temporary for *_of_get_bridge() */

   This can easily be tracked and reverted once all
   devm_drm_of_get_bridge() users are converted to
   of_drm_get_bridge_by_endpoint().

I'm working right now on option 1, hoping to get a series in a few hours
from now. I can switch to option 2 in case of unexpected issues with option
1, or if a fix "really right now" is wanted.

[0] https://lore.kernel.org/lkml/20260916-drm-bridge-every-panel-v3-7-83afb=
4f1a707@bootlin.com/
[1] https://lore.kernel.org/lkml/20260916-drm-bridge-every-panel-v3-8-83afb=
4f1a707@bootlin.com/

Luca

> ---
>  drivers/gpu/drm/adp/adp_drv.c                    | 1 +
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c | 1 +
>  drivers/gpu/drm/bridge/chipone-icn6211.c         | 1 +
>  drivers/gpu/drm/bridge/imx/imx-ldb-helper.c      | 1 +
>  drivers/gpu/drm/bridge/ite-it6263.c              | 1 +
>  drivers/gpu/drm/bridge/microchip-lvds.c          | 1 +
>  drivers/gpu/drm/bridge/nwl-dsi.c                 | 1 +
>  drivers/gpu/drm/bridge/nxp-ptn3460.c             | 1 +
>  drivers/gpu/drm/bridge/parade-ps8622.c           | 1 +
>  drivers/gpu/drm/bridge/parade-ps8640.c           | 1 +
>  drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c    | 1 +
>  drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c   | 1 +
>  drivers/gpu/drm/bridge/tc358762.c                | 1 +
>  drivers/gpu/drm/bridge/tc358764.c                | 1 +
>  drivers/gpu/drm/bridge/tc358775.c                | 1 +
>  drivers/gpu/drm/bridge/ti-dlpc3433.c             | 1 +
>  drivers/gpu/drm/bridge/ti-sn65dsi83.c            | 1 +
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c            | 1 +
>  drivers/gpu/drm/drm_bridge.c                     | 1 +
>  drivers/gpu/drm/imx/ipuv3/imx-ldb.c              | 1 +
>  drivers/gpu/drm/imx/ipuv3/parallel-display.c     | 1 +
>  drivers/gpu/drm/imx/lcdc/imx-lcdc.c              | 1 +
>  drivers/gpu/drm/mediatek/mtk_dpi.c               | 1 +
>  drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c         | 1 +
>  drivers/gpu/drm/mxsfb/lcdif_drv.c                | 1 +
>  drivers/gpu/drm/sprd/sprd_dsi.c                  | 1 +
>  drivers/gpu/drm/tidss/tidss_oldi.c               | 1 +
>  drivers/gpu/drm/tilcdc/tilcdc_encoder.c          | 1 +
>  drivers/gpu/drm/verisilicon/vs_bridge.c          | 1 +
>  29 files changed, 29 insertions(+)
>
> diff --git a/drivers/gpu/drm/adp/adp_drv.c b/drivers/gpu/drm/adp/adp_drv.=
c
> index fdf0e6316175..eb67c6fe9c01 100644
> --- a/drivers/gpu/drm/adp/adp_drv.c
> +++ b/drivers/gpu/drm/adp/adp_drv.c
> @@ -16,6 +16,7 @@
>  #include <drm/drm_gem_dma_helper.h>
>  #include <drm/drm_gem_framebuffer_helper.h>
>  #include <drm/drm_of.h>
> +#include <drm/drm_panel.h>
>  #include <drm/drm_print.h>
>  #include <drm/drm_probe_helper.h>
>  #include <drm/drm_vblank.h>
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c b/drivers/g=
pu/drm/atmel-hlcdc/atmel_hlcdc_output.c
> index e8aea905fb10..d16945ebb2f5 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
> @@ -15,6 +15,7 @@
>  #include <drm/drm_bridge.h>
>  #include <drm/drm_encoder.h>
>  #include <drm/drm_of.h>
> +#include <drm/drm_panel.h>
>  #include <drm/drm_print.h>
>  #include <drm/drm_simple_kms_helper.h>
>
> diff --git a/drivers/gpu/drm/bridge/chipone-icn6211.c b/drivers/gpu/drm/b=
ridge/chipone-icn6211.c
> index 4ec50fb63aba..fc4a49b2b246 100644
> --- a/drivers/gpu/drm/bridge/chipone-icn6211.c
> +++ b/drivers/gpu/drm/bridge/chipone-icn6211.c
> @@ -6,6 +6,7 @@
>
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_of.h>
> +#include <drm/drm_panel.h>
>  #include <drm/drm_print.h>
>  #include <drm/drm_mipi_dsi.h>
>
> diff --git a/drivers/gpu/drm/bridge/imx/imx-ldb-helper.c b/drivers/gpu/dr=
m/bridge/imx/imx-ldb-helper.c
> index 6149ba141a38..018fedb0162c 100644
> --- a/drivers/gpu/drm/bridge/imx/imx-ldb-helper.c
> +++ b/drivers/gpu/drm/bridge/imx/imx-ldb-helper.c
> @@ -13,6 +13,7 @@
>
>  #include <drm/drm_bridge.h>
>  #include <drm/drm_of.h>
> +#include <drm/drm_panel.h>
>  #include <drm/drm_print.h>
>
>  #include "imx-ldb-helper.h"
> diff --git a/drivers/gpu/drm/bridge/ite-it6263.c b/drivers/gpu/drm/bridge=
/ite-it6263.c
> index 21ac8e58b9d2..12a23bb45c84 100644
> --- a/drivers/gpu/drm/bridge/ite-it6263.c
> +++ b/drivers/gpu/drm/bridge/ite-it6263.c
> @@ -26,6 +26,7 @@
>  #include <drm/drm_crtc.h>
>  #include <drm/drm_edid.h>
>  #include <drm/drm_of.h>
> +#include <drm/drm_panel.h>
>  #include <drm/drm_probe_helper.h>
>
>  /* ---------------------------------------------------------------------=
--------
> diff --git a/drivers/gpu/drm/bridge/microchip-lvds.c b/drivers/gpu/drm/br=
idge/microchip-lvds.c
> index dd4ffc9f4df3..53291cde0636 100644
> --- a/drivers/gpu/drm/bridge/microchip-lvds.c
> +++ b/drivers/gpu/drm/bridge/microchip-lvds.c
> @@ -24,6 +24,7 @@
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_bridge.h>
>  #include <drm/drm_of.h>
> +#include <drm/drm_panel.h>
>  #include <drm/drm_print.h>
>  #include <drm/drm_probe_helper.h>
>  #include <drm/drm_simple_kms_helper.h>
> diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nw=
l-dsi.c
> index 09992529f3d8..f7043dcd76cb 100644
> --- a/drivers/gpu/drm/bridge/nwl-dsi.c
> +++ b/drivers/gpu/drm/bridge/nwl-dsi.c
> @@ -27,6 +27,7 @@
>  #include <drm/drm_bridge.h>
>  #include <drm/drm_mipi_dsi.h>
>  #include <drm/drm_of.h>
> +#include <drm/drm_panel.h>
>  #include <drm/drm_print.h>
>
>  #include <video/mipi_display.h>
> diff --git a/drivers/gpu/drm/bridge/nxp-ptn3460.c b/drivers/gpu/drm/bridg=
e/nxp-ptn3460.c
> index f9eff8bfceb7..489704df6145 100644
> --- a/drivers/gpu/drm/bridge/nxp-ptn3460.c
> +++ b/drivers/gpu/drm/bridge/nxp-ptn3460.c
> @@ -15,6 +15,7 @@
>  #include <drm/drm_crtc.h>
>  #include <drm/drm_edid.h>
>  #include <drm/drm_of.h>
> +#include <drm/drm_panel.h>
>  #include <drm/drm_print.h>
>  #include <drm/drm_probe_helper.h>
>
> diff --git a/drivers/gpu/drm/bridge/parade-ps8622.c b/drivers/gpu/drm/bri=
dge/parade-ps8622.c
> index 3a2ec482037d..ff24aa647028 100644
> --- a/drivers/gpu/drm/bridge/parade-ps8622.c
> +++ b/drivers/gpu/drm/bridge/parade-ps8622.c
> @@ -19,6 +19,7 @@
>  #include <drm/drm_bridge.h>
>  #include <drm/drm_crtc.h>
>  #include <drm/drm_of.h>
> +#include <drm/drm_panel.h>
>  #include <drm/drm_print.h>
>  #include <drm/drm_probe_helper.h>
>
> diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bri=
dge/parade-ps8640.c
> index 56b48f8feab6..425985f2398d 100644
> --- a/drivers/gpu/drm/bridge/parade-ps8640.c
> +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
> @@ -20,6 +20,7 @@
>  #include <drm/drm_edid.h>
>  #include <drm/drm_mipi_dsi.h>
>  #include <drm/drm_of.h>
> +#include <drm/drm_panel.h>
>  #include <drm/drm_print.h>
>
>  #define PAGE0_AUXCH_CFG3	0x76
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/=
drm/bridge/synopsys/dw-mipi-dsi.c
> index 5dd475fcaacf..11233d2d7385 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> @@ -30,6 +30,7 @@
>  #include <drm/drm_mipi_dsi.h>
>  #include <drm/drm_modes.h>
>  #include <drm/drm_of.h>
> +#include <drm/drm_panel.h>
>  #include <drm/drm_print.h>
>
>  #define HWVER_131			0x31333100	/* IP version 1.31 */
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c b/drivers/gpu=
/drm/bridge/synopsys/dw-mipi-dsi2.c
> index c0d89dd767ce..5b4f4c823d48 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c
> @@ -24,6 +24,7 @@
>  #include <drm/drm_bridge.h>
>  #include <drm/drm_mipi_dsi.h>
>  #include <drm/drm_of.h>
> +#include <drm/drm_panel.h>
>  #include <drm/drm_print.h>
>
>  #define DSI2_PWR_UP			0x000c
> diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/t=
c358762.c
> index 76564d5e4f69..c9e5bbc5dcd0 100644
> --- a/drivers/gpu/drm/bridge/tc358762.c
> +++ b/drivers/gpu/drm/bridge/tc358762.c
> @@ -23,6 +23,7 @@
>  #include <drm/drm_crtc.h>
>  #include <drm/drm_mipi_dsi.h>
>  #include <drm/drm_of.h>
> +#include <drm/drm_panel.h>
>  #include <drm/drm_print.h>
>  #include <drm/drm_probe_helper.h>
>
> diff --git a/drivers/gpu/drm/bridge/tc358764.c b/drivers/gpu/drm/bridge/t=
c358764.c
> index 049215e65988..311de8797402 100644
> --- a/drivers/gpu/drm/bridge/tc358764.c
> +++ b/drivers/gpu/drm/bridge/tc358764.c
> @@ -18,6 +18,7 @@
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_mipi_dsi.h>
>  #include <drm/drm_of.h>
> +#include <drm/drm_panel.h>
>  #include <drm/drm_print.h>
>
>  #define FLD_MASK(start, end)    (((1 << ((start) - (end) + 1)) - 1) << (=
end))
> diff --git a/drivers/gpu/drm/bridge/tc358775.c b/drivers/gpu/drm/bridge/t=
c358775.c
> index 203dc738ecef..e7ea47307a50 100644
> --- a/drivers/gpu/drm/bridge/tc358775.c
> +++ b/drivers/gpu/drm/bridge/tc358775.c
> @@ -26,6 +26,7 @@
>  #include <drm/drm_bridge.h>
>  #include <drm/drm_mipi_dsi.h>
>  #include <drm/drm_of.h>
> +#include <drm/drm_panel.h>
>  #include <drm/drm_probe_helper.h>
>
>  #define FLD_VAL(val, start, end) FIELD_PREP(GENMASK(start, end), val)
> diff --git a/drivers/gpu/drm/bridge/ti-dlpc3433.c b/drivers/gpu/drm/bridg=
e/ti-dlpc3433.c
> index c9f789e30687..21922878e60e 100644
> --- a/drivers/gpu/drm/bridge/ti-dlpc3433.c
> +++ b/drivers/gpu/drm/bridge/ti-dlpc3433.c
> @@ -10,6 +10,7 @@
>
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_of.h>
> +#include <drm/drm_panel.h>
>  #include <drm/drm_print.h>
>  #include <drm/drm_mipi_dsi.h>
>
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/brid=
ge/ti-sn65dsi83.c
> index eb5b249cc43c..cc6c4c89d468 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> @@ -45,6 +45,7 @@
>  #include <drm/drm_bridge_helper.h>
>  #include <drm/drm_mipi_dsi.h>
>  #include <drm/drm_of.h>
> +#include <drm/drm_panel.h>
>  #include <drm/drm_print.h>
>  #include <drm/drm_probe_helper.h>
>
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/brid=
ge/ti-sn65dsi86.c
> index 48b83df9aed6..de16afa99b91 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> @@ -32,6 +32,7 @@
>  #include <drm/drm_edid.h>
>  #include <drm/drm_mipi_dsi.h>
>  #include <drm/drm_of.h>
> +#include <drm/drm_panel.h>
>  #include <drm/drm_print.h>
>  #include <drm/drm_probe_helper.h>
>
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index e7f9e6d58927..e50737432071 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -36,6 +36,7 @@
>  #include <drm/drm_encoder.h>
>  #include <drm/drm_file.h>
>  #include <drm/drm_of.h>
> +#include <drm/drm_panel.h>
>  #include <drm/drm_print.h>
>
>  #include "drm_crtc_internal.h"
> diff --git a/drivers/gpu/drm/imx/ipuv3/imx-ldb.c b/drivers/gpu/drm/imx/ip=
uv3/imx-ldb.c
> index 63d6a1e7c1bd..317db4d9b898 100644
> --- a/drivers/gpu/drm/imx/ipuv3/imx-ldb.c
> +++ b/drivers/gpu/drm/imx/ipuv3/imx-ldb.c
> @@ -25,6 +25,7 @@
>  #include <drm/drm_bridge_connector.h>
>  #include <drm/drm_managed.h>
>  #include <drm/drm_of.h>
> +#include <drm/drm_panel.h>
>  #include <drm/drm_print.h>
>  #include <drm/drm_probe_helper.h>
>  #include <drm/drm_simple_kms_helper.h>
> diff --git a/drivers/gpu/drm/imx/ipuv3/parallel-display.c b/drivers/gpu/d=
rm/imx/ipuv3/parallel-display.c
> index eb75827394f8..966649bc6dc6 100644
> --- a/drivers/gpu/drm/imx/ipuv3/parallel-display.c
> +++ b/drivers/gpu/drm/imx/ipuv3/parallel-display.c
> @@ -17,6 +17,7 @@
>  #include <drm/drm_bridge_connector.h>
>  #include <drm/drm_managed.h>
>  #include <drm/drm_of.h>
> +#include <drm/drm_panel.h>
>  #include <drm/drm_probe_helper.h>
>  #include <drm/drm_simple_kms_helper.h>
>  #include <drm/bridge/of-display-mode-bridge.h>
> diff --git a/drivers/gpu/drm/imx/lcdc/imx-lcdc.c b/drivers/gpu/drm/imx/lc=
dc/imx-lcdc.c
> index c67fe80b8115..cac50a002004 100644
> --- a/drivers/gpu/drm/imx/lcdc/imx-lcdc.c
> +++ b/drivers/gpu/drm/imx/lcdc/imx-lcdc.c
> @@ -14,6 +14,7 @@
>  #include <drm/drm_gem_dma_helper.h>
>  #include <drm/drm_gem_framebuffer_helper.h>
>  #include <drm/drm_of.h>
> +#include <drm/drm_panel.h>
>  #include <drm/drm_print.h>
>  #include <drm/drm_probe_helper.h>
>  #include <drm/drm_simple_kms_helper.h>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediate=
k/mtk_dpi.c
> index 0e4f430de983..b73d76a40c6c 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -27,6 +27,7 @@
>  #include <drm/drm_edid.h>
>  #include <drm/drm_encoder.h>
>  #include <drm/drm_of.h>
> +#include <drm/drm_panel.h>
>
>  #include "mtk_ddp_comp.h"
>  #include "mtk_disp_drv.h"
> diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c b/drivers/gpu/drm/m=
sm/disp/mdp4/mdp4_kms.c
> index 9b1d1982e683..df5fed30718e 100644
> --- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
> +++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
> @@ -8,6 +8,7 @@
>
>  #include <drm/drm_bridge.h>
>  #include <drm/drm_bridge_connector.h>
> +#include <drm/drm_panel.h>
>  #include <drm/drm_vblank.h>
>
>  #include "msm_drv.h"
> diff --git a/drivers/gpu/drm/mxsfb/lcdif_drv.c b/drivers/gpu/drm/mxsfb/lc=
dif_drv.c
> index e2173c4d6fc2..ba14b20cb038 100644
> --- a/drivers/gpu/drm/mxsfb/lcdif_drv.c
> +++ b/drivers/gpu/drm/mxsfb/lcdif_drv.c
> @@ -27,6 +27,7 @@
>  #include <drm/drm_mode_config.h>
>  #include <drm/drm_module.h>
>  #include <drm/drm_of.h>
> +#include <drm/drm_panel.h>
>  #include <drm/drm_probe_helper.h>
>  #include <drm/drm_vblank.h>
>
> diff --git a/drivers/gpu/drm/sprd/sprd_dsi.c b/drivers/gpu/drm/sprd/sprd_=
dsi.c
> index 23b0e1dc547a..260d1682c8a7 100644
> --- a/drivers/gpu/drm/sprd/sprd_dsi.c
> +++ b/drivers/gpu/drm/sprd/sprd_dsi.c
> @@ -12,6 +12,7 @@
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_bridge.h>
>  #include <drm/drm_of.h>
> +#include <drm/drm_panel.h>
>  #include <drm/drm_probe_helper.h>
>
>  #include "sprd_drm.h"
> diff --git a/drivers/gpu/drm/tidss/tidss_oldi.c b/drivers/gpu/drm/tidss/t=
idss_oldi.c
> index 5eb749f495d5..7e77b4af36d0 100644
> --- a/drivers/gpu/drm/tidss/tidss_oldi.c
> +++ b/drivers/gpu/drm/tidss/tidss_oldi.c
> @@ -15,6 +15,7 @@
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_bridge.h>
>  #include <drm/drm_of.h>
> +#include <drm/drm_panel.h>
>
>  #include "tidss_dispc.h"
>  #include "tidss_dispc_regs.h"
> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_encoder.c b/drivers/gpu/drm/ti=
lcdc/tilcdc_encoder.c
> index ac4b5beb2dd5..5fb0e8e1e829 100644
> --- a/drivers/gpu/drm/tilcdc/tilcdc_encoder.c
> +++ b/drivers/gpu/drm/tilcdc/tilcdc_encoder.c
> @@ -10,6 +10,7 @@
>  #include <drm/drm_bridge.h>
>  #include <drm/drm_bridge_connector.h>
>  #include <drm/drm_of.h>
> +#include <drm/drm_panel.h>
>  #include <drm/drm_simple_kms_helper.h>
>
>  #include "tilcdc_drv.h"
> diff --git a/drivers/gpu/drm/verisilicon/vs_bridge.c b/drivers/gpu/drm/ve=
risilicon/vs_bridge.c
> index dc7c85b07fe3..586f1bd7d7b5 100644
> --- a/drivers/gpu/drm/verisilicon/vs_bridge.c
> +++ b/drivers/gpu/drm/verisilicon/vs_bridge.c
> @@ -15,6 +15,7 @@
>  #include <drm/drm_connector.h>
>  #include <drm/drm_encoder.h>
>  #include <drm/drm_of.h>
> +#include <drm/drm_panel.h>
>  #include <drm/drm_print.h>
>  #include <drm/drm_simple_kms_helper.h>
>





--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
