Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9E17C88E5C
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:48:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D892110EAD6;
	Wed, 16 Sep 2026 13:48:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="q2GXSr3M";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0603510EAD6
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 13:48:19 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id C50F14E40727;
 Wed, 16 Sep 2026 13:48:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 98B0760337;
 Wed, 16 Sep 2026 13:48:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E1C4E11C7B035; 
 Wed, 16 Sep 2026 15:48:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1789566490; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=QjTr2Jmo4sllECWNzVI6O2II4pn3OSCLwMo1L497iBk=;
 b=q2GXSr3MBNevWtr1X4GL5najFiFRCky4UDT9+gVxjCXDZmeQnPUNB3iBKRW8SS5eMuwAH0
 e0RcOblp7qN+c50PtK5sZyWm7zvlBrfenS0ff+azzPN+fTSjdar7/YoOFPhzX2xzFO+ioP
 ZEgz69QYHQLGn8EMFMvl3NKPghhdfQu91EPTu7GXgpn3ln5u/vnxtTgNkfoTuHO2s/lf7O
 HXYgmH+GXJv/mSQTXZVJs1rsIiEwV0/ZzwEhCKGCkQPspx45LzvgFWd8XydFDzeoZeQvyW
 rLB8r/PtIndVeczq82GfGMwOXFL0P1Gv7id5bAIl9G04miXl2G84LDQQqs7VQg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Wed, 16 Sep 2026 15:45:42 +0200
Subject: [PATCH v3 18/19] drm/tve200: don't create a panel_bridge
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-drm-bridge-every-panel-v3-18-83afb4f1a707@bootlin.com>
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

And since of_drm_find_and_get_bridge() returns a refcounted bridge, take
care of putting the bridge reference.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/tve200/Kconfig      |  1 -
 drivers/gpu/drm/tve200/tve200_drm.h |  1 -
 drivers/gpu/drm/tve200/tve200_drv.c | 30 +++++++-----------------------
 3 files changed, 7 insertions(+), 25 deletions(-)

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
index 631a9f5d9aa6..708f8020667a 100644
--- a/drivers/gpu/drm/tve200/tve200_drm.h
+++ b/drivers/gpu/drm/tve200/tve200_drm.h
@@ -103,7 +103,6 @@ struct tve200_drm_dev_private {
 	struct drm_device *drm;
 
 	struct drm_connector *connector;
-	struct drm_panel *panel;
 	struct drm_bridge *bridge;
 	struct drm_plane plane;
 	struct drm_crtc crtc;
diff --git a/drivers/gpu/drm/tve200/tve200_drv.c b/drivers/gpu/drm/tve200/tve200_drv.c
index 63ca4a53fc4c..9874554e5065 100644
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
@@ -121,9 +113,6 @@ static int tve200_modeset_init(struct drm_device *dev)
 		goto out_bridge;
 	}
 
-	dev_info(dev->dev, "attached to panel %s\n",
-		 dev_name(panel->dev));
-
 	ret = drm_vblank_init(dev, 1);
 	if (ret) {
 		dev_err(dev->dev, "failed to init vblank\n");
@@ -136,8 +125,6 @@ static int tve200_modeset_init(struct drm_device *dev)
 	goto finish;
 
 out_bridge:
-	if (panel)
-		drm_panel_bridge_remove(bridge);
 	drm_mode_config_cleanup(dev);
 finish:
 	return ret;
@@ -233,8 +220,6 @@ static int tve200_probe(struct platform_device *pdev)
 	return 0;
 
 mode_config_cleanup:
-	if (priv->panel)
-		drm_panel_bridge_remove(priv->bridge);
 	drm_mode_config_cleanup(drm);
 clk_disable:
 	clk_disable_unprepare(priv->pclk);
@@ -248,10 +233,9 @@ static void tve200_remove(struct platform_device *pdev)
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

