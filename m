Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D212C88E77
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:45:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C503B10E3B8;
	Wed, 16 Sep 2026 13:45:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="IHySCgyn";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C6F910E382;
 Wed, 16 Sep 2026 13:45:56 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id DFF761A08D9;
 Wed, 16 Sep 2026 13:45:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id AF53C60337;
 Wed, 16 Sep 2026 13:45:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 49AE611C7B010; 
 Wed, 16 Sep 2026 15:45:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1789566352; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=zIb4y2X3SRcPHsShM1vvJKlerVb44YpM+iags7PiUSY=;
 b=IHySCgynSIjcSNwyDcWS/dY62ItmEToFIs+v+NKzNQQ43eo9e5f4ixT8jFpW8C4EEOuUGj
 7e/fcBCv7HT7U6T0B1RXl19QtYu5vLqJ1sYUPub9N1wS4kJDkHMWVch7SXEBFDn/Fqtj8w
 nz+t/XFMQPERJs7gpFK6xbJnFckWTBCvDXUrxI5usPIQWKr7O5ggp+m6DK5v3yLcyQelNW
 Ah7Jgu63RdOucGbReKSl/zLYYa1oQhd9ZcsA8Ux1/BeawM2PzQcJZPMkwnpvVsB8fuWNzk
 dhG1cM9OKY5IUOWqclorbOhOsDIIiUs9BATw78PORpXAkIlxHkNNTdoLZ6LsUA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Wed, 16 Sep 2026 15:45:25 +0200
Subject: [PATCH v3 01/19] drm: of: move drm_of_find_panel_or_bridge() from
 drm_of.c to drm_panel.c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-drm-bridge-every-panel-v3-1-83afb4f1a707@bootlin.com>
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

We want to move drm_panel.o from the main drm module to a new drm_panel
module, but there is one function in the drm module that calls into
drm_panel.c code:

  drm_of_find_panel_or_bridge() (drm_of.c, drm module)
     -> calls of_drm_find_panel (drm_panel.c, future drm_panel module)

Avoid this issue by moving drm_of_find_panel_or_bridge() to drm_panel.c.

Update Kconfig symbols of drivers calling drm_of_find_panel_or_bridge() to
select DRM_PANEL when this is not done already.

No functional changes, just moving code around.

Suggested-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/bridge/Kconfig          |  2 ++
 drivers/gpu/drm/bridge/analogix/Kconfig |  2 ++
 drivers/gpu/drm/drm_of.c                | 63 ---------------------------------
 drivers/gpu/drm/drm_panel.c             | 63 +++++++++++++++++++++++++++++++++
 drivers/gpu/drm/imx/dcss/Kconfig        |  1 +
 drivers/gpu/drm/ingenic/Kconfig         |  1 +
 drivers/gpu/drm/logicvc/Kconfig         |  1 +
 drivers/gpu/drm/mcde/Kconfig            |  1 +
 drivers/gpu/drm/pl111/Kconfig           |  1 +
 drivers/gpu/drm/rockchip/Kconfig        |  2 ++
 drivers/gpu/drm/stm/Kconfig             |  1 +
 drivers/gpu/drm/tidss/Kconfig           |  1 +
 drivers/gpu/drm/tve200/Kconfig          |  1 +
 include/drm/drm_of.h                    | 12 -------
 include/drm/drm_panel.h                 | 13 +++++++
 15 files changed, 90 insertions(+), 75 deletions(-)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index f2db7f60d40f..89e87460aefc 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -151,6 +151,7 @@ config DRM_LONTIUM_LT8912B
 config DRM_LONTIUM_LT9211
 	tristate "Lontium LT9211 DSI/LVDS/DPI bridge"
 	depends on OF
+	select DRM_PANEL
 	select DRM_PANEL_BRIDGE
 	select DRM_KMS_HELPER
 	select DRM_MIPI_DSI
@@ -498,6 +499,7 @@ config DRM_WAVESHARE_BRIDGE
 	tristate "Waveshare DSI bridge"
 	depends on OF
 	depends on BACKLIGHT_CLASS_DEVICE
+	select DRM_PANEL
 	select DRM_PANEL_BRIDGE
 	select DRM_KMS_HELPER
 	select DRM_MIPI_DSI
diff --git a/drivers/gpu/drm/bridge/analogix/Kconfig b/drivers/gpu/drm/bridge/analogix/Kconfig
index 57bb2daa5aaf..da156fd15764 100644
--- a/drivers/gpu/drm/bridge/analogix/Kconfig
+++ b/drivers/gpu/drm/bridge/analogix/Kconfig
@@ -6,6 +6,7 @@ config DRM_ANALOGIX_ANX6345
 	select DRM_DISPLAY_DP_HELPER
 	select DRM_DISPLAY_HELPER
 	select DRM_KMS_HELPER
+	select DRM_PANEL
 	select REGMAP_I2C
 	help
 	  ANX6345 is an ultra-low power Full-HD DisplayPort/eDP
@@ -32,6 +33,7 @@ config DRM_ANALOGIX_DP
 	depends on DRM
 	depends on OF
 	select DRM_DISPLAY_DP_AUX_BUS
+	select DRM_PANEL
 
 config DRM_ANALOGIX_ANX7625
 	tristate "Analogix Anx7625 MIPI to DP interface support"
diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
index 2b53124ded68..411f258d9f91 100644
--- a/drivers/gpu/drm/drm_of.c
+++ b/drivers/gpu/drm/drm_of.c
@@ -264,69 +264,6 @@ int drm_of_get_panel_orientation(const struct device_node *np,
 }
 EXPORT_SYMBOL_GPL(drm_of_get_panel_orientation);
 
-/**
- * drm_of_find_panel_or_bridge - return connected panel or bridge device
- * @np: device tree node containing encoder output ports
- * @port: port in the device tree node
- * @endpoint: endpoint in the device tree node
- * @panel: pointer to hold returned drm_panel, must not be NULL. On success
- *         the caller must call drm_panel_put() when done with the panel
- * @bridge: pointer to hold returned drm_bridge
- *
- * Given a DT node's port and endpoint number, find the connected node and
- * return either the associated struct drm_panel or drm_bridge device.
- *
- * This function is deprecated and should not be used in new drivers. Use
- * of_drm_get_bridge_by_endpoint() instead when not looking for a panel, or
- * devm_drm_of_get_bridge() otherwise.
- *
- * Returns zero if successful, or one of the standard error codes if it fails.
- */
-int drm_of_find_panel_or_bridge(const struct device_node *np,
-				int port, int endpoint,
-				struct drm_panel **panel,
-				struct drm_bridge **bridge)
-{
-	if (WARN_ON(!panel))
-		return -EINVAL;
-
-	*panel = NULL;
-	if (bridge)
-		*bridge = NULL;
-
-	/*
-	 * of_graph_get_remote_node() produces a noisy error message if port
-	 * node isn't found and the absence of the port is a legit case here,
-	 * so at first we silently check whether a graph is present in the
-	 * device-tree node.
-	 */
-	if (!of_graph_is_present(np))
-		return -ENODEV;
-
-	struct device_node *remote __free(device_node) =
-		of_graph_get_remote_node(np, port, endpoint);
-	if (!remote)
-		return -ENODEV;
-
-	*panel = of_drm_find_panel(remote);
-	if (!IS_ERR(*panel))
-		return 0;
-
-	*panel = NULL;
-
-	if (bridge) {
-		/* No panel found yet, check for a bridge next. */
-		*bridge = of_drm_find_bridge(remote);
-		if (*bridge)
-			return 0;
-
-		*bridge = NULL;
-	}
-
-	return -EPROBE_DEFER;
-}
-EXPORT_SYMBOL_GPL(drm_of_find_panel_or_bridge);
-
 enum drm_of_lvds_pixels {
 	DRM_OF_LVDS_EVEN = BIT(0),
 	DRM_OF_LVDS_ODD = BIT(1),
diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index f8f6082e637f..e1f8a4ff37d2 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -498,6 +498,69 @@ struct drm_panel *of_drm_find_panel(const struct device_node *np)
 	return ERR_PTR(-EPROBE_DEFER);
 }
 EXPORT_SYMBOL(of_drm_find_panel);
+
+/**
+ * drm_of_find_panel_or_bridge - return connected panel or bridge device
+ * @np: device tree node containing encoder output ports
+ * @port: port in the device tree node
+ * @endpoint: endpoint in the device tree node
+ * @panel: pointer to hold returned drm_panel, must not be NULL. On success
+ *         the caller must call drm_panel_put() when done with the panel
+ * @bridge: pointer to hold returned drm_bridge
+ *
+ * Given a DT node's port and endpoint number, find the connected node and
+ * return either the associated struct drm_panel or drm_bridge device.
+ *
+ * This function is deprecated and should not be used in new drivers. Use
+ * of_drm_get_bridge_by_endpoint() instead when not looking for a panel, or
+ * devm_drm_of_get_bridge() otherwise.
+ *
+ * Returns zero if successful, or one of the standard error codes if it fails.
+ */
+int drm_of_find_panel_or_bridge(const struct device_node *np,
+				int port, int endpoint,
+				struct drm_panel **panel,
+				struct drm_bridge **bridge)
+{
+	if (WARN_ON(!panel))
+		return -EINVAL;
+
+	*panel = NULL;
+	if (bridge)
+		*bridge = NULL;
+
+	/*
+	 * of_graph_get_remote_node() produces a noisy error message if port
+	 * node isn't found and the absence of the port is a legit case here,
+	 * so at first we silently check whether a graph is present in the
+	 * device-tree node.
+	 */
+	if (!of_graph_is_present(np))
+		return -ENODEV;
+
+	struct device_node *remote __free(device_node) =
+		of_graph_get_remote_node(np, port, endpoint);
+	if (!remote)
+		return -ENODEV;
+
+	*panel = of_drm_find_panel(remote);
+	if (!IS_ERR(*panel))
+		return 0;
+
+	*panel = NULL;
+
+	if (bridge) {
+		/* No panel found yet, check for a bridge next. */
+		*bridge = of_drm_find_bridge(remote);
+		if (*bridge)
+			return 0;
+
+		*bridge = NULL;
+	}
+
+	return -EPROBE_DEFER;
+}
+EXPORT_SYMBOL_GPL(drm_of_find_panel_or_bridge);
 #endif
 
 /*
diff --git a/drivers/gpu/drm/imx/dcss/Kconfig b/drivers/gpu/drm/imx/dcss/Kconfig
index e014ed3ae66c..d278bebfc33c 100644
--- a/drivers/gpu/drm/imx/dcss/Kconfig
+++ b/drivers/gpu/drm/imx/dcss/Kconfig
@@ -6,6 +6,7 @@ config DRM_IMX_DCSS
 	select DRM_DISPLAY_HELPER
 	select DRM_BRIDGE_CONNECTOR
 	select DRM_GEM_DMA_HELPER
+	select DRM_PANEL
 	select VIDEOMODE_HELPERS
 	depends on DRM && ((ARCH_MXC && ARM64) || COMPILE_TEST)
 	help
diff --git a/drivers/gpu/drm/ingenic/Kconfig b/drivers/gpu/drm/ingenic/Kconfig
index 04ecfb0c5dd6..987ed42f6f7a 100644
--- a/drivers/gpu/drm/ingenic/Kconfig
+++ b/drivers/gpu/drm/ingenic/Kconfig
@@ -7,6 +7,7 @@ config DRM_INGENIC
 	depends on COMMON_CLK
 	select DRM_BRIDGE
 	select DRM_CLIENT_SELECTION
+	select DRM_PANEL
 	select DRM_PANEL_BRIDGE
 	select DRM_KMS_HELPER
 	select DRM_DISPLAY_HELPER
diff --git a/drivers/gpu/drm/logicvc/Kconfig b/drivers/gpu/drm/logicvc/Kconfig
index 579a358ed5cf..53bd1ae61c83 100644
--- a/drivers/gpu/drm/logicvc/Kconfig
+++ b/drivers/gpu/drm/logicvc/Kconfig
@@ -6,6 +6,7 @@ config DRM_LOGICVC
 	select DRM_KMS_HELPER
 	select DRM_KMS_DMA_HELPER
 	select DRM_GEM_DMA_HELPER
+	select DRM_PANEL
 	select REGMAP
 	select REGMAP_MMIO
 	help
diff --git a/drivers/gpu/drm/mcde/Kconfig b/drivers/gpu/drm/mcde/Kconfig
index 3516c8d2a5d9..6ebfb930cbfa 100644
--- a/drivers/gpu/drm/mcde/Kconfig
+++ b/drivers/gpu/drm/mcde/Kconfig
@@ -9,6 +9,7 @@ config DRM_MCDE
 	select DRM_CLIENT_SELECTION
 	select DRM_MIPI_DSI
 	select DRM_BRIDGE
+	select DRM_PANEL
 	select DRM_PANEL_BRIDGE
 	select DRM_KMS_HELPER
 	select DRM_GEM_DMA_HELPER
diff --git a/drivers/gpu/drm/pl111/Kconfig b/drivers/gpu/drm/pl111/Kconfig
index 82e918820950..20201ec20aa7 100644
--- a/drivers/gpu/drm/pl111/Kconfig
+++ b/drivers/gpu/drm/pl111/Kconfig
@@ -9,6 +9,7 @@ config DRM_PL111
 	select DRM_KMS_HELPER
 	select DRM_GEM_DMA_HELPER
 	select DRM_BRIDGE
+	select DRM_PANEL
 	select DRM_PANEL_BRIDGE
 	help
 	  Choose this option for DRM support for the PL111 CLCD controller.
diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
index e7f49fe845ea..1b4a87eeaf3f 100644
--- a/drivers/gpu/drm/rockchip/Kconfig
+++ b/drivers/gpu/drm/rockchip/Kconfig
@@ -124,6 +124,7 @@ config ROCKCHIP_LVDS
 	depends on PINCTRL && OF
 	select DRM_DISPLAY_HELPER
 	select DRM_BRIDGE_CONNECTOR
+	select DRM_PANEL
 	help
 	  Choose this option to enable support for Rockchip LVDS controllers.
 	  Rockchip rk3288 SoC has LVDS TX Controller can be used, and it
@@ -136,6 +137,7 @@ config ROCKCHIP_RGB
 	depends on PINCTRL
 	select DRM_DISPLAY_HELPER
 	select DRM_BRIDGE_CONNECTOR
+	select DRM_PANEL
 	help
 	  Choose this option to enable support for Rockchip RGB output.
 	  Some Rockchip CRTCs, like rv1108, can directly output parallel
diff --git a/drivers/gpu/drm/stm/Kconfig b/drivers/gpu/drm/stm/Kconfig
index 635be0ac00af..1e3205aa2c7e 100644
--- a/drivers/gpu/drm/stm/Kconfig
+++ b/drivers/gpu/drm/stm/Kconfig
@@ -6,6 +6,7 @@ config DRM_STM
 	select DRM_CLIENT_SELECTION
 	select DRM_KMS_HELPER
 	select DRM_GEM_DMA_HELPER
+	select DRM_PANEL
 	select DRM_PANEL_BRIDGE
 	select VIDEOMODE_HELPERS
 	select FB_PROVIDE_GET_FB_UNMAPPED_AREA if FB
diff --git a/drivers/gpu/drm/tidss/Kconfig b/drivers/gpu/drm/tidss/Kconfig
index 31ad582b7602..52a64fa1ad5d 100644
--- a/drivers/gpu/drm/tidss/Kconfig
+++ b/drivers/gpu/drm/tidss/Kconfig
@@ -7,6 +7,7 @@ config DRM_TIDSS
 	select DRM_DISPLAY_HELPER
 	select DRM_BRIDGE_CONNECTOR
 	select DRM_GEM_DMA_HELPER
+	select DRM_PANEL
 	help
 	  The TI Keystone family SoCs introduced a new generation of
 	  Display SubSystem. There is currently three Keystone family
diff --git a/drivers/gpu/drm/tve200/Kconfig b/drivers/gpu/drm/tve200/Kconfig
index a9d6fe535d88..c0746ae8f703 100644
--- a/drivers/gpu/drm/tve200/Kconfig
+++ b/drivers/gpu/drm/tve200/Kconfig
@@ -7,6 +7,7 @@ config DRM_TVE200
 	depends on OF
 	select DRM_BRIDGE
 	select DRM_CLIENT_SELECTION
+	select DRM_PANEL
 	select DRM_PANEL_BRIDGE
 	select DRM_KMS_HELPER
 	select DRM_GEM_DMA_HELPER
diff --git a/include/drm/drm_of.h b/include/drm/drm_of.h
index ebebed14c611..402f5db11e47 100644
--- a/include/drm/drm_of.h
+++ b/include/drm/drm_of.h
@@ -51,10 +51,6 @@ int drm_of_encoder_active_endpoint(struct device_node *node,
 				   struct of_endpoint *endpoint);
 int drm_of_get_panel_orientation(const struct device_node *np,
 				 enum drm_panel_orientation *orientation);
-int drm_of_find_panel_or_bridge(const struct device_node *np,
-				int port, int endpoint,
-				struct drm_panel **panel,
-				struct drm_bridge **bridge);
 int drm_of_lvds_get_dual_link_pixel_order(const struct device_node *port1,
 					  const struct device_node *port2);
 int drm_of_lvds_get_dual_link_pixel_order_sink(struct device_node *port1,
@@ -112,14 +108,6 @@ static inline int drm_of_get_panel_orientation(const struct device_node *np,
 	return -EINVAL;
 }
 
-static inline int drm_of_find_panel_or_bridge(const struct device_node *np,
-					      int port, int endpoint,
-					      struct drm_panel **panel,
-					      struct drm_bridge **bridge)
-{
-	return -EINVAL;
-}
-
 static inline int
 drm_of_lvds_get_dual_link_pixel_order(const struct device_node *port1,
 				      const struct device_node *port2)
diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
index b87323443f49..bf15e40fd796 100644
--- a/include/drm/drm_panel.h
+++ b/include/drm/drm_panel.h
@@ -33,6 +33,7 @@
 struct backlight_device;
 struct dentry;
 struct device_node;
+struct drm_bridge;
 struct drm_connector;
 struct drm_panel_follower;
 struct drm_panel;
@@ -337,11 +338,23 @@ int drm_panel_get_modes(struct drm_panel *panel, struct drm_connector *connector
 
 #if defined(CONFIG_OF) && defined(CONFIG_DRM_PANEL)
 struct drm_panel *of_drm_find_panel(const struct device_node *np);
+int drm_of_find_panel_or_bridge(const struct device_node *np,
+				int port, int endpoint,
+				struct drm_panel **panel,
+				struct drm_bridge **bridge);
 #else
 static inline struct drm_panel *of_drm_find_panel(const struct device_node *np)
 {
 	return ERR_PTR(-ENODEV);
 }
+
+static inline int drm_of_find_panel_or_bridge(const struct device_node *np,
+					      int port, int endpoint,
+					      struct drm_panel **panel,
+					      struct drm_bridge **bridge)
+{
+	return -EINVAL;
+}
 #endif
 
 #if defined(CONFIG_DRM_PANEL)

-- 
2.55.0

