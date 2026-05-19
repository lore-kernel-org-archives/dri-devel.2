Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1BCACD4F57
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 10:38:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C74110EC22;
	Tue, 19 May 2026 10:38:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="QOdOdnBF";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C496410EC22
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 10:38:37 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id A9F03C2B9DB;
 Tue, 19 May 2026 10:39:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 80193606E9;
 Tue, 19 May 2026 10:38:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id EDBCC107E8AC4; 
 Tue, 19 May 2026 12:38:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1779187114; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=rGciLf3NjCBPoc0UQ4+x/z7o6dllLIML7luNF7S0QvE=;
 b=QOdOdnBFA3u8nc64QbRf7A4cZQCMLbAc551RI9YUbue/r1WzVdQ5EtZgEHuPO+pOOSoMqh
 dTkseuBv8AbZAWpyJ8ht1eeWIeX643g7mbJYlPRcJX9pyh3UuUrtx2da9nXgHR5jxVjbkX
 tTQFfsnQjJAjwRaSjiridai41ikNAHZHFfLT8cKRIZGnygRmlPBObukK0qv2XA283hMdXU
 DPsAIDx1faViqsF9f4vHV+6Y9a3ekjOnHtKpDmpNRXIsH1QzVC9oRjTQIwZDrSwZPLQrJf
 L6A1+xWoDhidqVjbFDRmITn8DpR1SbAQcwe+l/8GAKixjZMnkMBjsqo2iIZwfw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 19 May 2026 12:37:24 +0200
Subject: [PATCH 07/37] drm/display: bridge-connector: extract
 drm_bridge_connector_get_bridges()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-drm-bridge-hotplug-v1-7-45e2bdb3dfb4@bootlin.com>
References: <20260519-drm-bridge-hotplug-v1-0-45e2bdb3dfb4@bootlin.com>
In-Reply-To: <20260519-drm-bridge-hotplug-v1-0-45e2bdb3dfb4@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, Marek Vasut <marex@denx.de>, 
 Stefan Agner <stefan@agner.ch>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.15.2
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

To support bridge hotplug we will need better control over the steps
involved in the crm_connector creation, especially in terms of error
management. This will be complicated by the length and amount of return
points in this function. In preparation, split the code to grab the various
bridge pointers out to a separate function.

No functional changes. Just moving code around.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/display/drm_bridge_connector.c | 86 +++++++++++++++-----------
 1 file changed, 50 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index eb1912611cd6..97d9a4c6d166 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -772,44 +772,24 @@ static void drm_bridge_connector_put_bridges(struct drm_device *dev, void *data)
 	drm_bridge_put(bridge_connector->bridge_hdmi_cec);
 }
 
-/**
- * drm_bridge_connector_add_connector - add the drm_connector
- * @bridge_connector: drm_bridge_connector to add the drm_connector to
- *
- * Preconditions: the drm_bridge_connector is initialized (the
- * @bridge_connector->drm and @bridge_connector->encoder fields are
- * assigned at least)
- *
- * Returns a pointer to @bridge_connector on success, or a negative error
- * pointer otherwise.
- */
 static struct drm_bridge_connector *
-drm_bridge_connector_add_connector(struct drm_bridge_connector *bridge_connector)
+drm_bridge_connector_get_bridges(struct drm_bridge_connector *bridge_connector,
+				 int *connector_type,
+				 unsigned int *supported_formats,
+				 unsigned int *max_bpc,
+				 struct i2c_adapter **ddc,
+				 struct drm_bridge **panel_bridge,
+				 bool *support_hdcp)
 {
-	struct drm_connector *connector;
-	struct i2c_adapter *ddc = NULL;
-	struct drm_bridge *panel_bridge __free(drm_bridge_put) = NULL;
-	unsigned int supported_formats = BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444);
-	unsigned int max_bpc = 8;
-	bool support_hdcp = false;
-	int connector_type;
-	int ret;
+	struct drm_connector *connector = &bridge_connector->base;
 
 	/*
 	 * TODO: Handle doublescan_allowed and stereo_allowed.
 	 */
-	connector = &bridge_connector->base;
 	connector->interlace_allowed = true;
 	connector->ycbcr_420_allowed = true;
+	*connector_type = DRM_MODE_CONNECTOR_Unknown;
 
-	/*
-	 * Initialise connector status handling. First locate the furthest
-	 * bridges in the pipeline that support HPD and output detection. Then
-	 * initialise the connector polling mode, using HPD if available and
-	 * falling back to polling if supported. If neither HPD nor output
-	 * detection are available, we don't support hotplug detection at all.
-	 */
-	connector_type = DRM_MODE_CONNECTOR_Unknown;
 	drm_for_each_bridge_in_chain_scoped(bridge_connector->encoder, bridge) {
 		if (!bridge->interlace_allowed)
 			connector->interlace_allowed = false;
@@ -865,9 +845,9 @@ drm_bridge_connector_add_connector(struct drm_bridge_connector *bridge_connector
 			bridge_connector->bridge_hdmi = drm_bridge_get(bridge);
 
 			if (bridge->supported_formats)
-				supported_formats = bridge->supported_formats;
+				*supported_formats = bridge->supported_formats;
 			if (bridge->max_bpc)
-				max_bpc = bridge->max_bpc;
+				*max_bpc = bridge->max_bpc;
 		}
 
 		if (bridge->ops & DRM_BRIDGE_OP_HDMI_AUDIO) {
@@ -926,7 +906,7 @@ drm_bridge_connector_add_connector(struct drm_bridge_connector *bridge_connector
 		}
 
 		if (drm_bridge_is_last(bridge))
-			connector_type = bridge->type;
+			*connector_type = bridge->type;
 
 #ifdef CONFIG_OF
 		if (drm_bridge_is_last(bridge) && bridge->of_node)
@@ -934,20 +914,54 @@ drm_bridge_connector_add_connector(struct drm_bridge_connector *bridge_connector
 #endif
 
 		if (bridge->ddc)
-			ddc = bridge->ddc;
+			*ddc = bridge->ddc;
 
 		if (drm_bridge_is_panel(bridge)) {
-			drm_bridge_put(panel_bridge);
-			panel_bridge = drm_bridge_get(bridge);
+			drm_bridge_put(*panel_bridge);
+			*panel_bridge = drm_bridge_get(bridge);
 		}
 
 		if (bridge->support_hdcp)
-			support_hdcp = true;
+			*support_hdcp = true;
 	}
 
 	if (connector_type == DRM_MODE_CONNECTOR_Unknown)
 		return ERR_PTR(-EINVAL);
 
+	return bridge_connector;
+}
+
+/**
+ * drm_bridge_connector_add_connector - add the drm_connector
+ * @bridge_connector: drm_bridge_connector to add the drm_connector to
+ *
+ * Preconditions: the drm_bridge_connector is initialized (the
+ * @bridge_connector->drm and @bridge_connector->encoder fields are
+ * assigned at least)
+ *
+ * Returns a pointer to @bridge_connector on success, or a negative error
+ * pointer otherwise.
+ */
+static struct drm_bridge_connector *
+drm_bridge_connector_add_connector(struct drm_bridge_connector *bridge_connector)
+{
+	struct drm_connector *connector;
+	struct i2c_adapter *ddc = NULL;
+	struct drm_bridge *panel_bridge __free(drm_bridge_put) = NULL;
+	unsigned int supported_formats = BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444);
+	unsigned int max_bpc = 8;
+	bool support_hdcp = false;
+	int connector_type;
+	int ret;
+
+	connector = &bridge_connector->base;
+
+	bridge_connector = drm_bridge_connector_get_bridges(bridge_connector, &connector_type,
+							    &supported_formats, &max_bpc, &ddc,
+							    &panel_bridge, &support_hdcp);
+	if (IS_ERR(bridge_connector))
+		return bridge_connector;
+
 	if (bridge_connector->bridge_hdmi) {
 		if (!connector->ycbcr_420_allowed)
 			supported_formats &= ~BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR420);

-- 
2.54.0

