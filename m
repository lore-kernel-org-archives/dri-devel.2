Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B49B7C61DD3
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 08:13:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E436F10F473;
	Thu,  3 Sep 2026 08:13:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="lp8eSXHn";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E281710F474
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 08:13:56 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id A9FDD4E414F5;
 Thu,  3 Sep 2026 08:13:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 7C6DA602B8;
 Thu,  3 Sep 2026 08:13:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E198211C79ED7; 
 Thu,  3 Sep 2026 10:13:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1788423234; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=nQjs+UfNnx/R43LEv8b5bIBPNxqCBiBSpdUVP5znzuY=;
 b=lp8eSXHn+jWnSRLBw4cbnzFd8v+v24ukc5Y+qOpL2k6jHcHeKwIX7ft+2kl5yrpOqDs9tA
 x11WMtDyZeqsJ5Ra8SclDhUvyqPUIq+y3k4WLvJpsIWfLlFQHmxti39xvWOHAg6agEt9j0
 X3WKm25B9M8BI+rz0waElAxCTgjXa52Q8Ig2wPyQKHduhNEBvZSNALYMr8poJ0cdJHt0BC
 +Cszkt1kpSJEenbafpvJ1jyRKoh9GS9MR4x9TEjzKQZAg5mbzKsmHrZ2hWQySgYeHGp64r
 bX2jFkpnMZun6YWCxcqNnwYgxUMCPR/wiXbzXdiru3NkTgkOw1MoitlsskmfbA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Thu, 03 Sep 2026 10:11:21 +0200
Subject: [PATCH RFC v2 18/19] drm/tve200: don't create a panel_bridge
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-drm-bridge-every-panel-v2-18-2ab8ee24538e@bootlin.com>
References: <20260903-drm-bridge-every-panel-v2-0-2ab8ee24538e@bootlin.com>
In-Reply-To: <20260903-drm-bridge-every-panel-v2-0-2ab8ee24538e@bootlin.com>
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
Cc: Albert Esteve <aesteve@redhat.com>, 
 Anusha Srivatsa <asrivats@redhat.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
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
code (similar to an open-coded variant of drm_of_find_panel_or_bridge())
would lead to creating a second bridge for the same panel.

Update and simplify the code by just getting a reference to the
already-existing bridge.

And since of_drm_find_and_get_bridge() returns a refcounted bridge, take
care of putting the bridge reference.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/tve200/Kconfig      |  1 -
 drivers/gpu/drm/tve200/tve200_drm.h |  1 -
 drivers/gpu/drm/tve200/tve200_drv.c | 31 +++++++------------------------
 3 files changed, 7 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/tve200/Kconfig b/drivers/gpu/drm/tve200/Kconfig
index c0746ae8f703..afe243df4ebb 100644
--- a/drivers/gpu/drm/tve200/Kconfig
+++ b/drivers/gpu/drm/tve200/Kconfig
@@ -8,7 +8,6 @@ config DRM_TVE200
 	select DRM_BRIDGE
 	select DRM_CLIENT_SELECTION
 	select DRM_PANEL
-	select DRM_PANEL_BRIDGE
 	select DRM_KMS_HELPER
 	select DRM_GEM_DMA_HELPER
 	help
diff --git a/drivers/gpu/drm/tve200/tve200_drm.h b/drivers/gpu/drm/tve200/tve200_drm.h
index 5420b52ea16b..426c936819fd 100644
--- a/drivers/gpu/drm/tve200/tve200_drm.h
+++ b/drivers/gpu/drm/tve200/tve200_drm.h
@@ -105,7 +105,6 @@ struct tve200_drm_dev_private {
 	struct drm_device *drm;
 
 	struct drm_connector *connector;
-	struct drm_panel *panel;
 	struct drm_bridge *bridge;
 	struct drm_simple_display_pipe pipe;
 
diff --git a/drivers/gpu/drm/tve200/tve200_drv.c b/drivers/gpu/drm/tve200/tve200_drv.c
index 8d0e7c7c82e8..d5afed45cf43 100644
--- a/drivers/gpu/drm/tve200/tve200_drv.c
+++ b/drivers/gpu/drm/tve200/tve200_drv.c
@@ -65,7 +65,6 @@ static int tve200_modeset_init(struct drm_device *dev)
 {
 	struct drm_mode_config *mode_config;
 	struct tve200_drm_dev_private *priv = dev->dev_private;
-	struct drm_panel *panel;
 	struct drm_bridge *bridge;
 	int ret;
 
@@ -77,19 +76,10 @@ static int tve200_modeset_init(struct drm_device *dev)
 	mode_config->min_height = 240;
 	mode_config->max_height = 576;
 
-	ret = drm_of_find_panel_or_bridge(dev->dev->of_node,
-					  0, 0, &panel, &bridge);
-	if (ret && ret != -ENODEV)
-		return ret;
-	if (panel) {
-		bridge = drm_panel_bridge_add_typed(panel,
-						    DRM_MODE_CONNECTOR_Unknown);
-		drm_panel_put(panel);
-		if (IS_ERR(bridge)) {
-			ret = PTR_ERR(bridge);
-			goto out_bridge;
-		}
-	} else {
+	bridge = of_drm_get_bridge_by_endpoint(dev->dev->of_node, 0, 0);
+	if (IS_ERR(bridge) && PTR_ERR(bridge) != -ENODEV)
+		return PTR_ERR(bridge);
+	if (IS_ERR(bridge) || !drm_bridge_is_panel(bridge)) {
 		/*
 		 * TODO: when we are using a different bridge than a panel
 		 * (such as a dumb VGA connector) we need to devise a different
@@ -100,6 +90,8 @@ static int tve200_modeset_init(struct drm_device *dev)
 		goto out_bridge;
 	}
 
+	bridge->type = DRM_MODE_CONNECTOR_Unknown;
+
 	ret = tve200_display_init(dev);
 	if (ret) {
 		dev_err(dev->dev, "failed to init display\n");
@@ -113,13 +105,9 @@ static int tve200_modeset_init(struct drm_device *dev)
 		goto out_bridge;
 	}
 
-	priv->panel = panel;
 	priv->connector = drm_panel_bridge_connector(bridge);
 	priv->bridge = bridge;
 
-	dev_info(dev->dev, "attached to panel %s\n",
-		 dev_name(panel->dev));
-
 	ret = drm_vblank_init(dev, 1);
 	if (ret) {
 		dev_err(dev->dev, "failed to init vblank\n");
@@ -132,8 +120,6 @@ static int tve200_modeset_init(struct drm_device *dev)
 	goto finish;
 
 out_bridge:
-	if (panel)
-		drm_panel_bridge_remove(bridge);
 	drm_mode_config_cleanup(dev);
 finish:
 	return ret;
@@ -229,8 +215,6 @@ static int tve200_probe(struct platform_device *pdev)
 	return 0;
 
 mode_config_cleanup:
-	if (priv->panel)
-		drm_panel_bridge_remove(priv->bridge);
 	drm_mode_config_cleanup(drm);
 clk_disable:
 	clk_disable_unprepare(priv->pclk);
@@ -244,10 +228,9 @@ static void tve200_remove(struct platform_device *pdev)
 	struct drm_device *drm = platform_get_drvdata(pdev);
 	struct tve200_drm_dev_private *priv = drm->dev_private;
 
+	drm_bridge_put(priv->bridge);
 	drm_dev_unregister(drm);
 	drm_atomic_helper_shutdown(drm);
-	if (priv->panel)
-		drm_panel_bridge_remove(priv->bridge);
 	drm_mode_config_cleanup(drm);
 	clk_disable_unprepare(priv->pclk);
 	drm_dev_put(drm);

-- 
2.55.0

