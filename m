Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0368AC624A4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 08:11:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2884710E52B;
	Thu,  3 Sep 2026 08:11:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="BJlLrS9Y";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5381B10E52B
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 08:11:45 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 1FD231A1985;
 Thu,  3 Sep 2026 08:11:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id E6CD5602B8;
 Thu,  3 Sep 2026 08:11:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3CE0211C791C9; 
 Thu,  3 Sep 2026 10:11:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1788423098; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=05b7F7Hrky5smdfqg7ON/5g4roZyfLJRD1uAubvwvFU=;
 b=BJlLrS9Y0b0D8X08SmF5OOd7NP0AX3nMr348qxVtJmSdgn+uEyAd8VAcTSfIlrjQ7Z8k0L
 aO1DjCPkJlyQn+vz2rxNZ1G/CpR8pwDYnx49TypXSfpoxRIe2eLpDGEgTobXZZYMHhdqux
 9BW4Vw260E0fkPrvB2nR3/0aYkrD+cSZGWSeggbkjkO94NQndlZBL+J0SsvJXUppatc+Z5
 72+yzRMYBKFdZmNzVjcHDOtzx5pfoP7j131VVcfOEcqo38QDPQtEx4l2HTlam+CZ87cyn5
 EmkpsSQuHbxHBtLxyKNbb1QEFXLWuX8KKYpZczHyLEAW0D3JAlhRgtLQ9PEdcQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Thu, 03 Sep 2026 10:11:04 +0200
Subject: [PATCH RFC v2 01/19] drm: of: move drm_of_find_panel_or_bridge()
 from drm_of.c to bridge/panel.c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-drm-bridge-every-panel-v2-1-2ab8ee24538e@bootlin.com>
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

We want to move drm_panel.o from the main drm module to a new drm_panel
module, but there is one function in the drm module that calls into
drm_panel.c code:

  drm_of_find_panel_or_bridge() (in drm_of.c, drm module)
     -> calls of_drm_find_panel (in drm_panel.c, would-be the new drm_panel module)

Avoid this issue by moving drm_of_find_panel_or_bridge() to bridge/panel.c
(which is currently in the drm_kms_helper module).

As a result drm_kms_helper will depend on the new drm_panel module, which
is fine because there is no dependency of drm_panel on drm_kms_helper.

After this change, all drivers using drm_of_find_panel_or_bridge() will
have to select DRM_PANEL_BRIDGE (and DRM_PANEL, recursively). Add that for
affected drivers. While there, also add DRM_PANEL on drivers selecting
DRM_PANEL_BRIDGE.

No functional changes, just moving code around.

[AI used to add 'select DRM_PANEL[_BRIDGE]' for affected drivers]
Assisted-by: opencode:deepseek-v4-flash-0731
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/bridge/Kconfig          |  2 ++
 drivers/gpu/drm/bridge/analogix/Kconfig |  4 +++
 drivers/gpu/drm/bridge/panel.c          | 63 +++++++++++++++++++++++++++++++++
 drivers/gpu/drm/drm_of.c                | 63 ---------------------------------
 drivers/gpu/drm/fsl-dcu/Kconfig         |  1 +
 drivers/gpu/drm/imx/dcss/Kconfig        |  2 ++
 drivers/gpu/drm/ingenic/Kconfig         |  1 +
 drivers/gpu/drm/logicvc/Kconfig         |  2 ++
 drivers/gpu/drm/mcde/Kconfig            |  1 +
 drivers/gpu/drm/pl111/Kconfig           |  1 +
 drivers/gpu/drm/renesas/rcar-du/Kconfig |  1 +
 drivers/gpu/drm/rockchip/Kconfig        |  4 +++
 drivers/gpu/drm/stm/Kconfig             |  1 +
 drivers/gpu/drm/sun4i/Kconfig           |  1 +
 drivers/gpu/drm/tegra/Kconfig           |  1 +
 drivers/gpu/drm/tidss/Kconfig           |  2 ++
 drivers/gpu/drm/tve200/Kconfig          |  1 +
 include/drm/drm_bridge.h                | 12 +++++++
 include/drm/drm_of.h                    | 12 -------
 19 files changed, 100 insertions(+), 75 deletions(-)

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
index 57bb2daa5aaf..d07431788fcb 100644
--- a/drivers/gpu/drm/bridge/analogix/Kconfig
+++ b/drivers/gpu/drm/bridge/analogix/Kconfig
@@ -6,6 +6,8 @@ config DRM_ANALOGIX_ANX6345
 	select DRM_DISPLAY_DP_HELPER
 	select DRM_DISPLAY_HELPER
 	select DRM_KMS_HELPER
+	select DRM_PANEL
+	select DRM_PANEL_BRIDGE
 	select REGMAP_I2C
 	help
 	  ANX6345 is an ultra-low power Full-HD DisplayPort/eDP
@@ -32,6 +34,8 @@ config DRM_ANALOGIX_DP
 	depends on DRM
 	depends on OF
 	select DRM_DISPLAY_DP_AUX_BUS
+	select DRM_PANEL
+	select DRM_PANEL_BRIDGE
 
 config DRM_ANALOGIX_ANX7625
 	tristate "Analogix Anx7625 MIPI to DP interface support"
diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
index 02388a3de626..83be09641582 100644
--- a/drivers/gpu/drm/bridge/panel.c
+++ b/drivers/gpu/drm/bridge/panel.c
@@ -560,4 +560,67 @@ struct drm_bridge *drmm_of_get_bridge(struct drm_device *drm,
 }
 EXPORT_SYMBOL(drmm_of_get_bridge);
 
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
+
 #endif
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
diff --git a/drivers/gpu/drm/fsl-dcu/Kconfig b/drivers/gpu/drm/fsl-dcu/Kconfig
index 0e0f910ceb9f..7f0e851e8508 100644
--- a/drivers/gpu/drm/fsl-dcu/Kconfig
+++ b/drivers/gpu/drm/fsl-dcu/Kconfig
@@ -7,6 +7,7 @@ config DRM_FSL_DCU
 	select DRM_GEM_DMA_HELPER
 	select DRM_KMS_HELPER
 	select DRM_PANEL
+	select DRM_PANEL_BRIDGE
 	select REGMAP_MMIO
 	select VIDEOMODE_HELPERS
 	select MFD_SYSCON if SOC_LS1021A
diff --git a/drivers/gpu/drm/imx/dcss/Kconfig b/drivers/gpu/drm/imx/dcss/Kconfig
index e014ed3ae66c..aa2a20ef5910 100644
--- a/drivers/gpu/drm/imx/dcss/Kconfig
+++ b/drivers/gpu/drm/imx/dcss/Kconfig
@@ -6,6 +6,8 @@ config DRM_IMX_DCSS
 	select DRM_DISPLAY_HELPER
 	select DRM_BRIDGE_CONNECTOR
 	select DRM_GEM_DMA_HELPER
+	select DRM_PANEL
+	select DRM_PANEL_BRIDGE
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
index 579a358ed5cf..7d2c0a460eec 100644
--- a/drivers/gpu/drm/logicvc/Kconfig
+++ b/drivers/gpu/drm/logicvc/Kconfig
@@ -6,6 +6,8 @@ config DRM_LOGICVC
 	select DRM_KMS_HELPER
 	select DRM_KMS_DMA_HELPER
 	select DRM_GEM_DMA_HELPER
+	select DRM_PANEL
+	select DRM_PANEL_BRIDGE
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
diff --git a/drivers/gpu/drm/renesas/rcar-du/Kconfig b/drivers/gpu/drm/renesas/rcar-du/Kconfig
index 840305fdeb49..051b0967008c 100644
--- a/drivers/gpu/drm/renesas/rcar-du/Kconfig
+++ b/drivers/gpu/drm/renesas/rcar-du/Kconfig
@@ -47,6 +47,7 @@ config DRM_RCAR_LVDS
 	depends on PM
 	select DRM_KMS_HELPER
 	select DRM_PANEL
+	select DRM_PANEL_BRIDGE
 	select RESET_CONTROLLER
 
 config DRM_RCAR_USE_MIPI_DSI
diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
index e7f49fe845ea..0b20f472dbd1 100644
--- a/drivers/gpu/drm/rockchip/Kconfig
+++ b/drivers/gpu/drm/rockchip/Kconfig
@@ -124,6 +124,8 @@ config ROCKCHIP_LVDS
 	depends on PINCTRL && OF
 	select DRM_DISPLAY_HELPER
 	select DRM_BRIDGE_CONNECTOR
+	select DRM_PANEL
+	select DRM_PANEL_BRIDGE
 	help
 	  Choose this option to enable support for Rockchip LVDS controllers.
 	  Rockchip rk3288 SoC has LVDS TX Controller can be used, and it
@@ -136,6 +138,8 @@ config ROCKCHIP_RGB
 	depends on PINCTRL
 	select DRM_DISPLAY_HELPER
 	select DRM_BRIDGE_CONNECTOR
+	select DRM_PANEL
+	select DRM_PANEL_BRIDGE
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
diff --git a/drivers/gpu/drm/sun4i/Kconfig b/drivers/gpu/drm/sun4i/Kconfig
index b56ba00aabca..32c30e08cf5c 100644
--- a/drivers/gpu/drm/sun4i/Kconfig
+++ b/drivers/gpu/drm/sun4i/Kconfig
@@ -7,6 +7,7 @@ config DRM_SUN4I
 	select DRM_GEM_DMA_HELPER
 	select DRM_KMS_HELPER
 	select DRM_PANEL
+	select DRM_PANEL_BRIDGE
 	select REGMAP_MMIO
 	select VIDEOMODE_HELPERS
 	help
diff --git a/drivers/gpu/drm/tegra/Kconfig b/drivers/gpu/drm/tegra/Kconfig
index 8a3b16aac5d6..fdcb10a4c7b5 100644
--- a/drivers/gpu/drm/tegra/Kconfig
+++ b/drivers/gpu/drm/tegra/Kconfig
@@ -14,6 +14,7 @@ config DRM_TEGRA
 	select DRM_KMS_HELPER
 	select DRM_MIPI_DSI
 	select DRM_PANEL
+	select DRM_PANEL_BRIDGE
 	select FB_DMAMEM_HELPERS if DRM_FBDEV_EMULATION
 	select TEGRA_HOST1X
 	select INTERCONNECT
diff --git a/drivers/gpu/drm/tidss/Kconfig b/drivers/gpu/drm/tidss/Kconfig
index 31ad582b7602..863930ecda1e 100644
--- a/drivers/gpu/drm/tidss/Kconfig
+++ b/drivers/gpu/drm/tidss/Kconfig
@@ -7,6 +7,8 @@ config DRM_TIDSS
 	select DRM_DISPLAY_HELPER
 	select DRM_BRIDGE_CONNECTOR
 	select DRM_GEM_DMA_HELPER
+	select DRM_PANEL
+	select DRM_PANEL_BRIDGE
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
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 58fff047f43b..c5b82e6946f5 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -1507,6 +1507,10 @@ struct drm_bridge *devm_drm_of_get_bridge(struct device *dev, struct device_node
 					  u32 port, u32 endpoint);
 struct drm_bridge *drmm_of_get_bridge(struct drm_device *drm, struct device_node *node,
 					  u32 port, u32 endpoint);
+int drm_of_find_panel_or_bridge(const struct device_node *np,
+				int port, int endpoint,
+				struct drm_panel **panel,
+				struct drm_bridge **bridge);
 #else
 static inline struct drm_bridge *devm_drm_of_get_bridge(struct device *dev,
 							struct device_node *node,
@@ -1523,6 +1527,14 @@ static inline struct drm_bridge *drmm_of_get_bridge(struct drm_device *drm,
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
 
 void devm_drm_put_bridge(struct device *dev, struct drm_bridge *bridge);
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

-- 
2.55.0

