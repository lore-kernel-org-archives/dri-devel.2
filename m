Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0821C982C4
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:47:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CFE510E85C;
	Wed, 16 Sep 2026 13:47:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="b9FMJI36";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5AF210E6F2;
 Wed, 16 Sep 2026 13:47:04 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 91A22C5CD63;
 Wed, 16 Sep 2026 13:47:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 95CE160337;
 Wed, 16 Sep 2026 13:47:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B423011C7B03B; 
 Wed, 16 Sep 2026 15:46:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1789566418; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=cPET2NhrdD6HSvBQlq/W5IT0tYfRgFI87leV1mZtICo=;
 b=b9FMJI3689bW6Mbp3QP/ZTgl/CWUhb8O+HyJBznbODXELvvhwULKj8sn/RhTSRHvKohWrN
 IoclnNC1/3J4nwYlZTnTFwM3INfHr04fEmprfB1H0qwZmdsyVA0Xio+nEQY9AYX7dByIrV
 yzp6KnOX2F2QDWAMoOIy/ks3dPpzEZwNHvH7R9SJ6YlOL8aHTe5UmcZoEttoiXNE7o05Mh
 D6qvEGQ5zVOsTsPfXMt71MkYGQXtedfNhSpWJ+vENj5Abz1dgOKbBANkTXr1jdPKYO0NRn
 c9FWdb1D3hEnCMkxW9QebJz8Fh9o+t/4iSO/3myOXSqD+CBMjHhWPvghwb+94w==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Wed, 16 Sep 2026 15:45:33 +0200
Subject: [PATCH v3 09/19] drm/bridge: tc358767: don't create a panel_bridge
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-drm-bridge-every-panel-v3-9-83afb4f1a707@bootlin.com>
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
 drivers/gpu/drm/bridge/Kconfig    |  2 --
 drivers/gpu/drm/bridge/tc358767.c | 64 ++++++++++++---------------------------
 2 files changed, 20 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 89e87460aefc..4766ae85da17 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -402,8 +402,6 @@ config DRM_TOSHIBA_TC358767
 	select DRM_KMS_HELPER
 	select REGMAP_I2C
 	select DRM_MIPI_DSI
-	select DRM_PANEL
-	select DRM_PANEL_BRIDGE
 	help
 	  Toshiba TC358767 eDP bridge chip driver.
 
diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index ac83af7902cd..51f4baa62a53 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -35,7 +35,6 @@
 #include <drm/drm_edid.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_of.h>
-#include <drm/drm_panel.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
 
@@ -370,7 +369,6 @@ struct tc_data {
 	struct drm_dp_aux	aux;
 
 	struct drm_bridge	bridge;
-	struct drm_bridge	*panel_bridge;
 	struct drm_connector	connector;
 
 	struct mipi_dsi_device	*dsi;
@@ -1742,8 +1740,8 @@ static int tc_connector_get_modes(struct drm_connector *connector)
 		return 0;
 	}
 
-	if (tc->panel_bridge) {
-		num_modes = drm_bridge_get_modes(tc->panel_bridge, connector);
+	if (tc->bridge.next_bridge) {
+		num_modes = drm_bridge_get_modes(tc->bridge.next_bridge, connector);
 		if (num_modes > 0)
 			return num_modes;
 	}
@@ -1788,7 +1786,7 @@ tc_connector_detect(struct drm_connector *connector, bool force)
 	if (tc->hpd_pin >= 0)
 		return tc_bridge_detect(&tc->bridge, connector);
 
-	if (tc->panel_bridge)
+	if (tc->bridge.next_bridge)
 		return connector_status_connected;
 	else
 		return connector_status_unknown;
@@ -1809,10 +1807,10 @@ static int tc_dpi_bridge_attach(struct drm_bridge *bridge,
 {
 	struct tc_data *tc = bridge_to_tc(bridge);
 
-	if (!tc->panel_bridge)
+	if (!tc->bridge.next_bridge)
 		return 0;
 
-	return drm_bridge_attach(tc->bridge.encoder, tc->panel_bridge,
+	return drm_bridge_attach(tc->bridge.encoder, tc->bridge.next_bridge,
 				 &tc->bridge, flags);
 }
 
@@ -1825,9 +1823,9 @@ static int tc_edp_bridge_attach(struct drm_bridge *bridge,
 	struct drm_device *drm = bridge->dev;
 	int ret;
 
-	if (tc->panel_bridge) {
+	if (tc->bridge.next_bridge) {
 		/* If a connector is required then this driver shall create it */
-		ret = drm_bridge_attach(tc->bridge.encoder, tc->panel_bridge,
+		ret = drm_bridge_attach(tc->bridge.encoder, tc->bridge.next_bridge,
 					&tc->bridge, flags | DRM_BRIDGE_ATTACH_NO_CONNECTOR);
 		if (ret)
 			return ret;
@@ -2318,53 +2316,31 @@ static int tc_probe_dpi_bridge_endpoint(struct tc_data *tc)
 {
 	struct device *dev = tc->dev;
 	struct drm_bridge *bridge;
-	struct drm_panel *panel;
-	int ret;
 
 	/* port@1 is the DPI input/output port */
-	ret = drm_of_find_panel_or_bridge(dev->of_node, 1, 0, &panel, &bridge);
-	if (ret && ret != -ENODEV)
-		return dev_err_probe(dev, ret,
-				     "Could not find DPI panel or bridge\n");
-
-	if (panel) {
-		bridge = devm_drm_panel_bridge_add(dev, panel);
-		drm_panel_put(panel);
-		if (IS_ERR(bridge))
-			return PTR_ERR(bridge);
-	}
-
-	if (bridge) {
-		tc->panel_bridge = bridge;
-		tc->bridge.type = DRM_MODE_CONNECTOR_DPI;
+	bridge = of_drm_get_bridge_by_endpoint(dev->of_node, 1, 0);
+	if (IS_ERR(bridge))
+		return dev_err_probe(dev, PTR_ERR(bridge),
+				     "Could not find DPI bridge\n");
 
-		return 0;
-	}
+	tc->bridge.next_bridge = bridge;
+	tc->bridge.type = DRM_MODE_CONNECTOR_DPI;
 
-	return ret;
+	return 0;
 }
 
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
-
-	if (panel) {
-		struct drm_bridge *panel_bridge;
-
-		panel_bridge = devm_drm_panel_bridge_add(dev, panel);
-		drm_panel_put(panel);
-		if (IS_ERR(panel_bridge))
-			return PTR_ERR(panel_bridge);
+	bridge = of_drm_get_bridge_by_endpoint(dev->of_node, 2, 0);
+	if (IS_ERR(bridge) && PTR_ERR(bridge) != -ENODEV)
+		return dev_err_probe(dev, PTR_ERR(bridge), "Could not find DSI bridge\n");
 
-		tc->panel_bridge = panel_bridge;
+	if (!IS_ERR(bridge)) {
+		tc->bridge.next_bridge = bridge;
 		tc->bridge.type = DRM_MODE_CONNECTOR_eDP;
 	} else {
 		tc->bridge.type = DRM_MODE_CONNECTOR_DisplayPort;

-- 
2.55.0

