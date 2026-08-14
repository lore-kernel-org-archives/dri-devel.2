Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE161C5CFDB
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 14:07:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 527DA10F5F8;
	Fri, 14 Aug 2026 14:07:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="GfLApfCD";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CDBE10F5F8
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 14:07:02 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id EE0874E41210;
 Fri, 14 Aug 2026 14:07:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id BFB776046D;
 Fri, 14 Aug 2026 14:07:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E232811C4EDAB; 
 Fri, 14 Aug 2026 16:06:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1786716415; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=dT6AqRBbgI42Tlee7k0qD3Mg6uWqZG1Wn4SiXDAn13E=;
 b=GfLApfCDHtz13LkAvF2GtvMiVcXAJE+yu9aEpdtUlkoX8r6dQrrnikJHoEGvMRh7umijCG
 tBMxB0nnrj/FQQwVStpzsoyQ8ghHk0C47VTzE0LhvhV3PawtLovOb2SUaS7z745NUVFBu1
 aolP7JW8OQOaweJ+YuUCpq8ips8YY2UXzEKESp3NnSYrMLxSby1D4UPI5ed13zUE3iYf/h
 96DI1TeV62rSFJWhOpLHLXd6PRdm+5Hm2KfJy+OWWltOxpLJpuS9nf2ClTYMUrU14x5orW
 scD+5RtbvS+GaP2q9oO1yTvIkhJ2VRYjA6boTOwoFLKQ/b+lw5+r+88s1l141Q==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 14 Aug 2026 16:05:54 +0200
Subject: [PATCH 06/11] drm/bridge: tc358767: don't create a panel_bridge
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-drm-bridge-every-panel-v1-6-19cd5277cc8d@bootlin.com>
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
of putting the bridge reference on removal.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/bridge/tc358767.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index ac83af7902cd..d282db507d59 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -2347,24 +2347,15 @@ static int tc_probe_dpi_bridge_endpoint(struct tc_data *tc)
 static int tc_probe_edp_bridge_endpoint(struct tc_data *tc)
 {
 	struct device *dev = tc->dev;
-	struct drm_panel *panel;
-	int ret;
+	struct drm_bridge *bridge;
 
 	/* port@2 is the output port */
-	ret = drm_of_find_panel_or_bridge(dev->of_node, 2, 0, &panel, NULL);
-	if (ret && ret != -ENODEV)
-		return dev_err_probe(dev, ret,
-				     "Could not find DSI panel or bridge\n");
+	bridge = of_drm_get_bridge_by_endpoint(dev->of_node, 2, 0);
+	if (IS_ERR(bridge) && PTR_ERR(bridge) != -ENODEV)
+		return dev_err_probe(dev, PTR_ERR(bridge), "Could not find DSI bridge\n");
 
-	if (panel) {
-		struct drm_bridge *panel_bridge;
-
-		panel_bridge = devm_drm_panel_bridge_add(dev, panel);
-		drm_panel_put(panel);
-		if (IS_ERR(panel_bridge))
-			return PTR_ERR(panel_bridge);
-
-		tc->panel_bridge = panel_bridge;
+	if (!IS_ERR(bridge)) {
+		tc->panel_bridge = bridge;
 		tc->bridge.type = DRM_MODE_CONNECTOR_eDP;
 	} else {
 		tc->bridge.type = DRM_MODE_CONNECTOR_DisplayPort;
@@ -2607,6 +2598,7 @@ static void tc_remove(struct i2c_client *client)
 {
 	struct tc_data *tc = i2c_get_clientdata(client);
 
+	drm_bridge_put(tc->panel_bridge);
 	drm_bridge_remove(&tc->bridge);
 }
 

-- 
2.55.0

