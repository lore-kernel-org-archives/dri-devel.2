Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79DF1C5CFDB
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 14:07:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5CBB10F5FC;
	Fri, 14 Aug 2026 14:07:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="zD2lVxK/";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E9FB10F5FC
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 14:07:05 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 740FD1A163D;
 Fri, 14 Aug 2026 14:07:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 489F36046D;
 Fri, 14 Aug 2026 14:07:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 02C4B11C4EDAF; 
 Fri, 14 Aug 2026 16:06:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1786716423; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=W47g4Q+NYk342rCC6QpiuRC+u7VsigF4CoJiynORV1Y=;
 b=zD2lVxK/VXoKuOuAbtULGsk9nbiSaPBmFJLXxe4bs81JWRPnhaZn7vmRdR2Y7FbhJKCn9K
 a0n6r9jpHe7jgIfLI3EpJKiCydHJWRceaHvsMfMS9Qu2UkMd7Ud9TOKeLEg/Y/8+aYeCti
 ZVfN6jkCHJxui+c7KIncPZCSSpRbBXUI/sN+EsuZvToq5oQO7eEwOXGx3phhuIpgoutpE2
 0l16xqQXmCQdnZh05mezWRssxshA3ZpTiyiOQfsyPmOsKqTZVBjVYP9iRimdGElmEQIHqO
 sETv5AGk3bWFThYa8URcUtUr3kqWrXzo6+iAJbciMu0cdQCmpmT1lQM80UUaEw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 14 Aug 2026 16:05:55 +0200
Subject: [PATCH 07/11] drm/bridge: waveshare-dsi: don't create a panel_bridge
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-drm-bridge-every-panel-v1-7-19cd5277cc8d@bootlin.com>
References: <20260814-drm-bridge-every-panel-v1-0-19cd5277cc8d@bootlin.com>
In-Reply-To: <20260814-drm-bridge-every-panel-v1-0-19cd5277cc8d@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Linus Walleij <linusw@kernel.org>, 
 Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
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

Now a panel_bridge is automatically created for every drm_panel, so this
panel-only call to drm_of_find_panel_or_bridge() would lead to creating a
second panel_bridge for the same panel.

Fix and simplify the code by just getting a reference to the
already-existing panel_bridge using of_drm_get_bridge_by_endpoint().

As of_drm_get_bridge_by_endpoint() returns a refcouncted bridge, take care
of putting the bridge reference by using bridge->next_bridge.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/bridge/waveshare-dsi.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/bridge/waveshare-dsi.c b/drivers/gpu/drm/bridge/waveshare-dsi.c
index 420f3b870a74..b79a1d32e679 100644
--- a/drivers/gpu/drm/bridge/waveshare-dsi.c
+++ b/drivers/gpu/drm/bridge/waveshare-dsi.c
@@ -20,7 +20,6 @@
 
 struct ws_bridge {
 	struct drm_bridge bridge;
-	struct drm_bridge *next_bridge;
 	struct backlight_device *backlight;
 	struct device *dev;
 	struct regmap *reg_map;
@@ -89,7 +88,7 @@ static int ws_bridge_bridge_attach(struct drm_bridge *bridge,
 {
 	struct ws_bridge *ws = bridge_to_ws_bridge(bridge);
 
-	return drm_bridge_attach(encoder, ws->next_bridge,
+	return drm_bridge_attach(encoder, ws->bridge.next_bridge,
 				 &ws->bridge, flags);
 }
 
@@ -150,7 +149,6 @@ static struct backlight_device *ws_bridge_create_backlight(struct ws_bridge *ws)
 static int ws_bridge_probe(struct i2c_client *i2c)
 {
 	struct device *dev = &i2c->dev;
-	struct drm_panel *panel;
 	struct ws_bridge *ws;
 	int ret;
 
@@ -164,14 +162,10 @@ static int ws_bridge_probe(struct i2c_client *i2c)
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
+				     "Failed to find remote panel\n");
 
 	ws->backlight = ws_bridge_create_backlight(ws);
 	if (IS_ERR(ws->backlight)) {

-- 
2.55.0

