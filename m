Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EBF606A32C
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 17:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=io0Xf+/y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F84B10FE9B;
	Wed, 25 Nov 2026 17:54:51 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B43CD10FE90
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 17:54:35 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 7967D1A1802;
 Wed, 25 Nov 2026 17:54:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 44C0760480;
 Wed, 25 Nov 2026 17:54:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0015D11E6B0D5; Wed, 25 Nov 2026 18:54:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795629268; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=DXSGE8zndzbOvx0I1VcqKxrraBhjgygWU5lIu97CM3Q=;
 b=io0Xf+/yoDo0TehiAHr/DSIC5GVPPwBKLeqyvcqJUW49v5lvs9coiM7UGM3KDE+qqvP8Mz
 dwXkr39b0lN/yczChB+veVFx4DxrZFRnnhmb1HW6HSawcbmNtrnQfjYUWqE5TUAuL2Ab+A
 QkbVOXM0jeWL9oC7NgHBxHzu/1N6rI7wHMelJYc5rsCh6f3OduTDXy3bUsWc29Dd8ivVjA
 A+Zx5TiHnBHS0irFzB0FvZQDNtLP1t70hn0A6EXbe084EkcpbdAZx4l3Ra8oLCIaN7j9/c
 Y9hnojQaGLyU/KQV2fTaGAqOUvt8IdQeFERZ4ZDrj3faFRzgVAYkZtmh8KfI2g==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Wed, 25 Nov 2026 18:50:45 +0100
Subject: [PATCH v4 32/32] drm/mxsfb/lcdif: enable bridge hotplug
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-drm-bridge-hotplug-v4-32-822722850492@bootlin.com>
References: <20261125-drm-bridge-hotplug-v4-0-822722850492@bootlin.com>
In-Reply-To: <20261125-drm-bridge-hotplug-v4-0-822722850492@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Douglas Anderson <dianders@chromium.org>, Marek Vasut <marex@denx.de>, 
 Stefan Agner <stefan@agner.ch>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Switch to the new drm_hotplug_helper() to handle bridge hotplugging:

 * use the new drm_hotplug_helper to handle hotplug, including finding
   the first bridge and attaching the bridge chain
 * use the connector add/remove callback to enable/disable HPD on
   added/removed connectors
 * move drm_kms_helper_poll_init() before creating the drm_hotplug_helper
   so that HPD polling is initialized before connectors can be hotplugged

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

Changes in v4:
- fix UAF when hot-plugged connectors implement HPD by using the new
  per-connector HPD enable/disable API

Changes in v3:
- Adapt to the v3 version of the drm_hotplug_helper, which also handles HPD

Changes in v2:
- Use the hotplug helper callback to enable HPD on the hotplugged connector
---
 drivers/gpu/drm/mxsfb/Kconfig     |  2 +-
 drivers/gpu/drm/mxsfb/lcdif_drv.c | 42 +++++++++++++++++++--------------------
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/mxsfb/Kconfig b/drivers/gpu/drm/mxsfb/Kconfig
index 31db7a824a93..ada9a9334ea4 100644
--- a/drivers/gpu/drm/mxsfb/Kconfig
+++ b/drivers/gpu/drm/mxsfb/Kconfig
@@ -34,7 +34,7 @@ config DRM_IMX_LCDIF
 	select DRM_PANEL
 	select DRM_PANEL_BRIDGE
 	select DRM_DISPLAY_HELPER
-	select DRM_BRIDGE_CONNECTOR
+	select DRM_HOTPLUG_HELPER
 	help
 	  Choose this option if you have an LCDIFv3 LCD controller.
 	  Those devices are found in various i.MX SoC (i.MX8MP,
diff --git a/drivers/gpu/drm/mxsfb/lcdif_drv.c b/drivers/gpu/drm/mxsfb/lcdif_drv.c
index 2be5a76e936f..591653b39310 100644
--- a/drivers/gpu/drm/mxsfb/lcdif_drv.c
+++ b/drivers/gpu/drm/mxsfb/lcdif_drv.c
@@ -18,7 +18,7 @@
 #include <drm/clients/drm_client_setup.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
-#include <drm/drm_bridge_connector.h>
+#include <drm/drm_hotplug_helper.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_encoder.h>
 #include <drm/drm_fbdev_dma.h>
@@ -44,6 +44,19 @@ static const struct drm_mode_config_helper_funcs lcdif_mode_config_helpers = {
 	.atomic_commit_tail = drm_atomic_helper_commit_tail_rpm,
 };
 
+static void lcdif_hotplug_event(enum drm_hotplug_helper_event event,
+				struct drm_connector *connector)
+{
+	switch (event) {
+	case DRM_HOTPLUG_HELPER_CONNECTOR_ADDED:
+		drm_kms_helper_poll_enable_connector(connector);
+	break;
+	case DRM_HOTPLUG_HELPER_CONNECTOR_REMOVING:
+		drm_kms_helper_poll_disable_connector(connector);
+		break;
+	}
+}
+
 static int lcdif_attach_bridge(struct lcdif_drm_private *lcdif)
 {
 	struct device *dev = lcdif->drm->dev;
@@ -53,9 +66,8 @@ static int lcdif_attach_bridge(struct lcdif_drm_private *lcdif)
 		struct device_node *remote __free(device_node) =
 			of_graph_get_remote_port_parent(ep);
 		struct of_endpoint of_ep;
-		struct drm_bridge *bridge;
 		struct drm_encoder *encoder;
-		struct drm_connector *connector;
+		struct drm_hotplug_helper *hotplug_helper;
 		int ret;
 
 		if (!of_device_is_available(remote))
@@ -65,12 +77,6 @@ static int lcdif_attach_bridge(struct lcdif_drm_private *lcdif)
 		if (ret < 0)
 			return dev_err_probe(dev, ret, "Failed to parse endpoint %pOF\n", ep);
 
-		bridge = devm_drm_of_get_bridge(dev, dev->of_node, 0, of_ep.id);
-		if (IS_ERR(bridge))
-			return dev_err_probe(dev, PTR_ERR(bridge),
-					     "Failed to get bridge for endpoint%u\n",
-					     of_ep.id);
-
 		encoder = drmm_plain_encoder_alloc(lcdif->drm, NULL,
 						   DRM_MODE_ENCODER_NONE, NULL);
 		if (IS_ERR(encoder))
@@ -80,16 +86,10 @@ static int lcdif_attach_bridge(struct lcdif_drm_private *lcdif)
 
 		encoder->possible_crtcs = drm_crtc_mask(&lcdif->crtc);
 
-		ret = drm_bridge_attach(encoder, bridge, NULL, DRM_BRIDGE_ATTACH_NO_CONNECTOR);
-		if (ret)
-			return dev_err_probe(dev, ret,
-					     "Failed to attach bridge for endpoint%u\n",
-					     of_ep.id);
-
-		connector = drm_bridge_connector_init(lcdif->drm, encoder);
-		if (IS_ERR(connector))
-			return dev_err_probe(dev, PTR_ERR(connector),
-					     "Failed to init bridge_connector for endpoint%u\n",
+		hotplug_helper = drmm_hotplug_helper_init(encoder, lcdif_hotplug_event, ep);
+		if (IS_ERR(hotplug_helper))
+			return dev_err_probe(dev, PTR_ERR(hotplug_helper),
+					     "Failed to init hotplug_helper for endpoint%u\n",
 					     of_ep.id);
 	}
 
@@ -176,6 +176,8 @@ static int lcdif_load(struct drm_device *drm)
 	/* Start with vertical blanking interrupt reporting disabled. */
 	drm_crtc_vblank_off(&lcdif->crtc);
 
+	drm_kms_helper_poll_init(drm);
+
 	ret = lcdif_attach_bridge(lcdif);
 	if (ret)
 		return ret;
@@ -203,8 +205,6 @@ static int lcdif_load(struct drm_device *drm)
 		return ret;
 	}
 
-	drm_kms_helper_poll_init(drm);
-
 	drm_helper_hpd_irq_event(drm);
 
 	pm_runtime_enable(drm->dev);

-- 
2.56.1

