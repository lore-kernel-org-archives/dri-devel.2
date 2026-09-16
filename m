Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 920CFC88E5C
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:47:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFD5210E572;
	Wed, 16 Sep 2026 13:47:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="K0GCnw3i";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9759310E39A
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 13:47:10 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 6AD0C1A07A8;
 Wed, 16 Sep 2026 13:47:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 3525E60337;
 Wed, 16 Sep 2026 13:47:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 380E211C7B041; 
 Wed, 16 Sep 2026 15:46:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1789566426; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=jSm15aEu8LMTkgjEDcY83AKYO/FAhIifYcjSr+uceZs=;
 b=K0GCnw3iJUIIJEBk5d04XwNWx4yCPreArhb6pcIbW1Eow4P6spCGVFWsiku75QKgQrx9Oh
 NWU+WPKhHDIWxMmdy0H7m8SKMS1dFLT/y1+vBcbzk9fusVyuaZ7sc5L7DAiOIg5iAm6Xi2
 qz3qwJ4hHu9jGcatl1pSETQ7ZQVTuXyvSlB9h8QbhKLjaDNRQ98cXptgCTkZdxbFsJyuVB
 H4wFymq2C4ZEXJN6i36nC7YmXkm7Y9UuUq6yWzaJmHZt6gGXxg0zNBaNuj9wqS/gvs7n46
 PPHklhmhdxpd4FfudS0Hrj4KEenttlxJuUAnPdCuOKVyTvalRFk5aU9pF0eWew==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Wed, 16 Sep 2026 15:45:34 +0200
Subject: [PATCH v3 10/19] drm/bridge: waveshare-dsi: don't create a
 panel_bridge
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-drm-bridge-every-panel-v3-10-83afb4f1a707@bootlin.com>
References: <20260916-drm-bridge-every-panel-v3-0-83afb4f1a707@bootlin.com>
In-Reply-To: <20260916-drm-bridge-every-panel-v3-0-83afb4f1a707@bootlin.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Paul Cercueil <paul@crapouillou.net>, 
 Paul Kocialkowski <paulk@sys-base.io>, Linus Walleij <linusw@kernel.org>, 
 Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, Sean Paul <sean@poorly.run>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: Albert Esteve <aesteve@redhat.com>, 
 Anusha Srivatsa <asrivats@redhat.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-mips@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, asahi@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
 linux-tegra@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.16.0
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

Now a panel_bridge is automatically created for every drm_panel and the
panel-bridge API is just a deprecated wrapper to access it.

Update and simplify the code by just getting a reference to the
already-existing bridge using of_drm_get_bridge_by_endpoint().

As of_drm_get_bridge_by_endpoint() returns a refcounted bridge, take care
of putting the bridge reference by using bridge->next_bridge.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/bridge/waveshare-dsi.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/bridge/waveshare-dsi.c b/drivers/gpu/drm/bridge/waveshare-dsi.c
index 420f3b870a74..2c40bfef2b45 100644
--- a/drivers/gpu/drm/bridge/waveshare-dsi.c
+++ b/drivers/gpu/drm/bridge/waveshare-dsi.c
@@ -16,11 +16,9 @@
 #include <drm/drm_bridge.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_of.h>
-#include <drm/drm_panel.h>
 
 struct ws_bridge {
 	struct drm_bridge bridge;
-	struct drm_bridge *next_bridge;
 	struct backlight_device *backlight;
 	struct device *dev;
 	struct regmap *reg_map;
@@ -89,7 +87,7 @@ static int ws_bridge_bridge_attach(struct drm_bridge *bridge,
 {
 	struct ws_bridge *ws = bridge_to_ws_bridge(bridge);
 
-	return drm_bridge_attach(encoder, ws->next_bridge,
+	return drm_bridge_attach(encoder, ws->bridge.next_bridge,
 				 &ws->bridge, flags);
 }
 
@@ -150,7 +148,6 @@ static struct backlight_device *ws_bridge_create_backlight(struct ws_bridge *ws)
 static int ws_bridge_probe(struct i2c_client *i2c)
 {
 	struct device *dev = &i2c->dev;
-	struct drm_panel *panel;
 	struct ws_bridge *ws;
 	int ret;
 
@@ -164,14 +161,10 @@ static int ws_bridge_probe(struct i2c_client *i2c)
 	if (IS_ERR(ws->reg_map))
 		return dev_err_probe(dev, PTR_ERR(ws->reg_map), "Failed to allocate regmap\n");
 
-	ret = drm_of_find_panel_or_bridge(dev->of_node, 1, -1, &panel, NULL);
-	if (ret)
-		return dev_err_probe(dev, ret, "Failed to find remote panel\n");
-
-	ws->next_bridge = devm_drm_panel_bridge_add(dev, panel);
-	drm_panel_put(panel);
-	if (IS_ERR(ws->next_bridge))
-		return PTR_ERR(ws->next_bridge);
+	ws->bridge.next_bridge = of_drm_get_bridge_by_endpoint(dev->of_node, 1, -1);
+	if (IS_ERR(ws->bridge.next_bridge))
+		return dev_err_probe(dev, PTR_ERR(ws->bridge.next_bridge),
+				     "Failed to find remote bridge\n");
 
 	ws->backlight = ws_bridge_create_backlight(ws);
 	if (IS_ERR(ws->backlight)) {

-- 
2.55.0

