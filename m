Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DED0CA5FCB
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 12:43:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB4D210E24D;
	Thu,  1 Oct 2026 12:43:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="S+1VkT7Y";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E4F710E24D
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 12:43:09 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 6070D1A18E7;
 Thu,  1 Oct 2026 12:43:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 322E760341;
 Thu,  1 Oct 2026 12:43:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C451D1032811B; 
 Thu,  1 Oct 2026 14:43:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790858585; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=TVnjYzkvuagpEKCsZ5XWhpT3Xm6tISGeO+ZmtZDI3fc=;
 b=S+1VkT7YmKhuYi1F7f3JXwOKcAnCCjimRiySrd+6yUbiAor0pa6GnbhQshFuEVmqktmH8C
 pua7TaB8v5mPKgeM3UTjBaMvStJAZRY4mrmccLznfDn02EqociXCsgxmmn5p3d5Cz6wgsh
 MptrTwkeYoQl2O+ZI58WuogA8qwDrenS7IJhEU4c9ITpAs+5/2vp+NPHYSk8gQqWAChQji
 G176Mzb9T0R1lHIhrmoL1ZaDO1lg5/0cilJF6LeRRySJVJyUYA5an+rTh5GwqMrBrvFNGV
 rHt+wYB+ViUIycxtzfkZj2adBxKs0wtlnU7gevG4llv62wxCinr+LwjzNSDqcg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Thu, 01 Oct 2026 14:42:25 +0200
Subject: [PATCH RFC v2 03/24] drm/display: bridge-connector: split code
 allocation from initialization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-drm-bridge-hotplug-v2-3-8e34986dcb68@bootlin.com>
References: <20261001-drm-bridge-hotplug-v2-0-8e34986dcb68@bootlin.com>
In-Reply-To: <20261001-drm-bridge-hotplug-v2-0-8e34986dcb68@bootlin.com>
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
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
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
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Currently drm_bridge_connector_init() does two things:

 * allocate and initialize the drm_bridge_connector
   (which embeds a drm_connector) using drmm
 * initialize and register the embedded drm_connector

For bridge hotplug drmm allocations are not suitable because a connector
may have to be added and removed multiple times in the lifetime of a card.

In preparation to support that, split out from drm_bridge_connector_init()
the code to allocate the drm_bridge_connector, so new (de)allocation code
can reuse all the initialization code.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/display/drm_bridge_connector.c | 62 ++++++++++++++++----------
 1 file changed, 38 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index 81f3e26f6fdf..41b51f0f13ae 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -837,27 +837,11 @@ static void drm_bridge_connector_put_bridges(struct drm_device *dev, void *data)
 	drm_bridge_put(bridge_connector->bridge_hdmi_cec);
 }
 
-/**
- * drm_bridge_connector_init - Initialise a connector for a chain of bridges
- * @drm: the DRM device
- * @encoder: the encoder where the bridge chain starts
- *
- * Create a new &drm_bridge_connector for the @drm device. The connector is
- * allocated, initialised, registered with the @drm device and attached to
- * @encoder.
- *
- * The connector is associated with a chain of bridges that starts at
- * the @encoder. All bridges in the chain shall report bridge operation flags
- * (&drm_bridge->ops) and bridge output type (&drm_bridge->type), and none of
- * them may create a DRM connector directly.
- *
- * Returns a pointer to the new connector on success, or a negative error
- * pointer otherwise.
- */
-struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
-						struct drm_encoder *encoder)
+static struct drm_connector *
+drm_bridge_connector_initialize(struct drm_bridge_connector *bridge_connector,
+				struct drm_device *drm,
+				struct drm_encoder *encoder)
 {
-	struct drm_bridge_connector *bridge_connector;
 	struct drm_connector *connector;
 	struct i2c_adapter *ddc = NULL;
 	struct drm_bridge *panel_bridge __free(drm_bridge_put) = NULL;
@@ -865,10 +849,6 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 	int connector_type;
 	int ret;
 
-	bridge_connector = drmm_kzalloc(drm, sizeof(*bridge_connector), GFP_KERNEL);
-	if (!bridge_connector)
-		return ERR_PTR(-ENOMEM);
-
 	ret = drmm_add_action(drm, drm_bridge_connector_put_bridges, bridge_connector);
 	if (ret)
 		return ERR_PTR(ret);
@@ -1154,4 +1134,38 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 
 	return connector;
 }
+
+/**
+ * drm_bridge_connector_init - Initialise a connector for a chain of bridges
+ * @drm: the DRM device
+ * @encoder: the encoder where the bridge chain starts
+ *
+ * Create a new &drm_bridge_connector for the @drm device. The connector is
+ * allocated, initialised, registered with the @drm device and attached to
+ * @encoder.
+ *
+ * The connector is associated with a chain of bridges that starts at
+ * the @encoder. All bridges in the chain shall report bridge operation flags
+ * (&drm_bridge->ops) and bridge output type (&drm_bridge->type), and none of
+ * them may create a DRM connector directly.
+ *
+ * Returns a pointer to the new connector on success, or a negative error
+ * pointer otherwise.
+ */
+struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
+						struct drm_encoder *encoder)
+{
+	struct drm_bridge_connector *bridge_connector;
+	struct drm_connector *connector;
+
+	bridge_connector = drmm_kzalloc(drm, sizeof(*bridge_connector), GFP_KERNEL);
+	if (!bridge_connector)
+		return ERR_PTR(-ENOMEM);
+
+	connector = drm_bridge_connector_initialize(bridge_connector, drm, encoder);
+	if (IS_ERR(connector))
+		return connector;
+
+	return connector;
+}
 EXPORT_SYMBOL_GPL(drm_bridge_connector_init);

-- 
2.55.0

