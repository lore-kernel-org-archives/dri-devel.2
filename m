Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39CBACD5BA3
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 10:39:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94D1010EC2C;
	Tue, 19 May 2026 10:39:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="mtyRsCSz";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FA3510EC2C
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 10:39:13 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 9BFCDC2B9DB;
 Tue, 19 May 2026 10:40:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 70AE2606E9;
 Tue, 19 May 2026 10:39:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 68DB3107E8AE0; 
 Tue, 19 May 2026 12:39:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1779187149; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=eS4OkpPo3Swd0wt5kHHS/3W+S57omlVkKazU9Pal7D8=;
 b=mtyRsCSzFmZ6Bh7It/Gd+7gkxzfBqnwhmdPUoj/0O6THnwURGcFPWO55bMlrEXQSk2igzA
 2Wal0KRnYQtVANEGKW/uQOq94KwNeponq3N+oVxrzwspsjykLBty6JhVXINru8ikhQSSGb
 X0/8Wge4LvUDfWPMpwTbeOiNknPPmF8La7NGB7xzkbOj8BpDkVVEqx1qpLZqyBZgs7O2Ba
 A7BJUNL477G/WFs7iO3TZ48jgcMxChcO9GhA6c2/+ritutWMIirEE4z7aCv83BkPxL7/VH
 8hYahm1ixjdAlHgjj8JiWpLfGY7Vk+oFdlX2rVExJqXKBtJs7t4JGDH8KtXcrw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 19 May 2026 12:37:32 +0200
Subject: [PATCH 15/37] drm/display: bridge-connector: allocate the
 connector dynamically
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-drm-bridge-hotplug-v1-15-45e2bdb3dfb4@bootlin.com>
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

Currently the drm_bridge_connector has an embedded drm_connector, so their
allocation lifetimes are tied to each other. This is insufficient to
support DRM bridge hotplugging, which requires the connector to be added
and removed dynamically at runtime multiple times based on hotplug/unplug
events while the drm_bridge_connector is persistent.

Moreover the drm_connector is exposed to user space and thus an ongoing
operation (e.g. an ioctl) might last for an arbitrarily long time even
after the hardware gets removed. This means a new connector might have to
be added when the previous one is still referenced by user space.

In preparation to handle hotplug, allocate the drm-connector dynamically,
to allow:

 * creating and destroying a connector multiple times during a single
   drm_bridge_connector lifetime
 * creating a new connector even though the previous one is still in use
   and thus still refcounted and not yet freed

This commit does not introduce the actions in the two bullets (it will
happen in a later commit), it only moves to dynamic APIs for connector
allocation and init.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/display/drm_bridge_connector.c | 156 ++++++++++++++++++-------
 1 file changed, 114 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index 1fd104f1647b..b4e2c8f1d32d 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (C) 2019 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
+ * Copyright (C) 2026 GE HealthCare
+ * Author: Luca Ceresoli <luca.ceresoli@bootlin.com>
  */
 
 #include <linux/export.h>
@@ -53,13 +55,24 @@
  */
 
 /**
- * struct drm_bridge_connector - A connector backed by a chain of bridges
+ * drm_bridge_connector_dynconn - wrapper struct for the dynamically
+ *                                created drm_connector
  */
-struct drm_bridge_connector {
+struct drm_bridge_connector_dynconn {
 	/**
-	 * @base: The base DRM connector
+	 * @bridge_connector: the owning bridge connector
 	 */
-	struct drm_connector base;
+	struct drm_bridge_connector *bridge_connector;
+	/**
+	 * @connector: the drm_connector exposed to user space
+	 */
+	struct drm_connector connector;
+};
+
+/**
+ * struct drm_bridge_connector - A connector backed by a chain of bridges
+ */
+struct drm_bridge_connector {
 	/**
 	 * @drm: The DRM device we belong to
 	 */
@@ -70,6 +83,10 @@ struct drm_bridge_connector {
 	 * The encoder at the start of the bridges chain.
 	 */
 	struct drm_encoder *encoder;
+	/**
+	 * @dynconn: The DRM connector added by the drm_bridge_connector
+	 */
+	struct drm_bridge_connector_dynconn *dynconn;
 	/**
 	 * @bridge_edid:
 	 *
@@ -137,8 +154,13 @@ struct drm_bridge_connector {
 	struct drm_connector_hdmi_funcs hdmi_funcs;
 };
 
-#define to_drm_bridge_connector(x) \
-	container_of(x, struct drm_bridge_connector, base)
+static struct drm_bridge_connector *to_drm_bridge_connector(const struct drm_connector *connector)
+{
+	const struct drm_bridge_connector_dynconn *dynconn =
+		container_of(connector, struct drm_bridge_connector_dynconn, connector);
+
+	return dynconn->bridge_connector;
+}
 
 static void drm_bridge_connector_put_bridges(struct drm_bridge_connector *bridge_connector)
 {
@@ -152,13 +174,6 @@ static void drm_bridge_connector_put_bridges(struct drm_bridge_connector *bridge
 	drm_bridge_put(bridge_connector->bridge_hdmi_cec);
 }
 
-static void drmm_bridge_connector_put_bridges(struct drm_device *dev, void *data)
-{
-	struct drm_bridge_connector *bridge_connector = (struct drm_bridge_connector *)data;
-
-	drm_bridge_connector_put_bridges(bridge_connector);
-}
-
 /* -----------------------------------------------------------------------------
  * Bridge Connector Hot-Plug Handling
  */
@@ -179,7 +194,7 @@ static void drm_bridge_connector_hpd_notify(struct drm_connector *connector,
 static void drm_bridge_connector_handle_hpd(struct drm_bridge_connector *bridge_connector,
 					    enum drm_connector_status status)
 {
-	struct drm_connector *connector = &bridge_connector->base;
+	struct drm_connector *connector = &bridge_connector->dynconn->connector;
 	struct drm_device *dev = bridge_connector->drm;
 
 	mutex_lock(&dev->mode_config.mutex);
@@ -299,6 +314,16 @@ static void drm_bridge_connector_reset(struct drm_connector *connector)
 							 connector->state);
 }
 
+static void drm_bridge_connector_dynconn_destroy(struct drm_connector *connector)
+{
+	struct drm_bridge_connector_dynconn *dynconn =
+		container_of(connector, struct drm_bridge_connector_dynconn, connector);
+
+	drm_connector_cleanup(connector);
+	drm_bridge_connector_put_bridges(dynconn->bridge_connector);
+	kfree(dynconn);
+}
+
 static const struct drm_connector_funcs drm_bridge_connector_funcs = {
 	.reset = drm_bridge_connector_reset,
 	.detect = drm_bridge_connector_detect,
@@ -308,6 +333,7 @@ static const struct drm_connector_funcs drm_bridge_connector_funcs = {
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 	.debugfs_init = drm_bridge_connector_debugfs_init,
 	.oob_hotplug_event = drm_bridge_connector_oob_hotplug_event,
+	.destroy = drm_bridge_connector_dynconn_destroy,
 };
 
 /* -----------------------------------------------------------------------------
@@ -777,7 +803,17 @@ static const struct drm_connector_hdmi_cec_funcs drm_bridge_connector_hdmi_cec_f
  * Bridge Connector Initialisation
  */
 
-static int drm_bridge_connector_get_bridges(struct drm_bridge_connector *bridge_connector,
+static void drm_bridge_connector_dynconn_release(struct drm_bridge_connector *bridge_connector)
+{
+	if (!bridge_connector->dynconn)
+		return;
+
+	drm_connector_unregister(&bridge_connector->dynconn->connector);
+	drm_connector_put(&bridge_connector->dynconn->connector);
+	bridge_connector->dynconn = NULL;
+}
+
+static int drm_bridge_connector_get_bridges(struct drm_bridge_connector_dynconn *dynconn,
 					    int *connector_type,
 					    unsigned int *supported_formats,
 					    unsigned int *max_bpc,
@@ -785,7 +821,8 @@ static int drm_bridge_connector_get_bridges(struct drm_bridge_connector *bridge_
 					    struct drm_bridge **panel_bridge,
 					    bool *support_hdcp)
 {
-	struct drm_connector *connector = &bridge_connector->base;
+	struct drm_bridge_connector *bridge_connector = dynconn->bridge_connector;
+	struct drm_connector *connector = &dynconn->connector;
 
 	/*
 	 * TODO: Handle doublescan_allowed and stereo_allowed.
@@ -937,6 +974,7 @@ static int drm_bridge_connector_get_bridges(struct drm_bridge_connector *bridge_
 
 static int drm_bridge_connector_init_hdmi_audio_cec(struct drm_bridge_connector *bridge_connector)
 {
+	struct drm_connector *connector = &bridge_connector->dynconn->connector;
 	int ret;
 
 	if (bridge_connector->bridge_hdmi_audio ||
@@ -951,7 +989,7 @@ static int drm_bridge_connector_init_hdmi_audio_cec(struct drm_bridge_connector
 
 		dev = bridge->hdmi_audio_dev;
 
-		ret = drm_connector_hdmi_audio_init(&bridge_connector->base, dev,
+		ret = drm_connector_hdmi_audio_init(connector, dev,
 						    &drm_bridge_connector_hdmi_audio_funcs,
 						    bridge->hdmi_audio_max_i2s_playback_channels,
 						    bridge->hdmi_audio_i2s_formats,
@@ -965,8 +1003,7 @@ static int drm_bridge_connector_init_hdmi_audio_cec(struct drm_bridge_connector
 	    bridge_connector->bridge_hdmi_cec->ops & DRM_BRIDGE_OP_HDMI_CEC_NOTIFIER) {
 		struct drm_bridge *bridge = bridge_connector->bridge_hdmi_cec;
 
-		ret = drmm_connector_hdmi_cec_notifier_register(&bridge_connector->base,
-								NULL,
+		ret = drmm_connector_hdmi_cec_notifier_register(connector, NULL,
 								bridge->hdmi_cec_dev);
 		if (ret)
 			return ret;
@@ -976,7 +1013,7 @@ static int drm_bridge_connector_init_hdmi_audio_cec(struct drm_bridge_connector
 	    bridge_connector->bridge_hdmi_cec->ops & DRM_BRIDGE_OP_HDMI_CEC_ADAPTER) {
 		struct drm_bridge *bridge = bridge_connector->bridge_hdmi_cec;
 
-		ret = drmm_connector_hdmi_cec_register(&bridge_connector->base,
+		ret = drmm_connector_hdmi_cec_register(connector,
 						       &drm_bridge_connector_hdmi_cec_funcs,
 						       bridge->hdmi_cec_adapter_name,
 						       bridge->hdmi_cec_available_las,
@@ -1009,13 +1046,20 @@ static int drm_bridge_connector_add_connector(struct drm_bridge_connector *bridg
 	int connector_type;
 	int ret;
 
-	connector = &bridge_connector->base;
+	struct drm_bridge_connector_dynconn *dynconn = kzalloc_obj(*dynconn);
+	if (!dynconn)
+		return -ENOMEM;
 
-	ret = drm_bridge_connector_get_bridges(bridge_connector, &connector_type,
+	dynconn->bridge_connector = bridge_connector;
+	connector = &dynconn->connector;
+
+	ret = drm_bridge_connector_get_bridges(dynconn, &connector_type,
 					       &supported_formats, &max_bpc, &ddc,
 					       &panel_bridge, &support_hdcp);
-	if (ret)
+	if (ret) {
+		kfree(dynconn);
 		return ret;
+	}
 
 	if (bridge_connector->bridge_hdmi) {
 		if (!connector->ycbcr_420_allowed)
@@ -1035,25 +1079,34 @@ static int drm_bridge_connector_add_connector(struct drm_bridge_connector *bridg
 			bridge_connector->hdmi_funcs.spd =
 				drm_bridge_connector_hdmi_spd_infoframe;
 
-		ret = drmm_connector_hdmi_init(bridge_connector->drm, connector,
-					       bridge_connector->bridge_hdmi->vendor,
-					       bridge_connector->bridge_hdmi->product,
-					       &drm_bridge_connector_funcs,
-					       &bridge_connector->hdmi_funcs,
-					       connector_type, ddc,
-					       supported_formats,
-					       max_bpc);
+		ret = drm_connector_hdmi_dynamic_init(bridge_connector->drm, connector,
+						      bridge_connector->bridge_hdmi->vendor,
+						      bridge_connector->bridge_hdmi->product,
+						      &drm_bridge_connector_funcs,
+						      &bridge_connector->hdmi_funcs,
+						      connector_type, ddc,
+						      supported_formats,
+						      max_bpc);
 	} else {
-		ret = drmm_connector_init(bridge_connector->drm, connector,
-					  &drm_bridge_connector_funcs,
-					  connector_type, ddc);
+		ret = drm_connector_dynamic_init(bridge_connector->drm, connector,
+						 &drm_bridge_connector_funcs,
+						 connector_type, ddc);
 	}
-	if (ret)
+	if (ret) {
+		drm_bridge_connector_put_bridges(dynconn->bridge_connector);
+		kfree(dynconn);
 		return ret;
+	}
+
+	/* From now on the connector is referenced and has to be put, not kfreed */
+
+	bridge_connector->dynconn = dynconn;
+
+	drm_bridge_connector_reset(connector);
 
 	ret = drm_bridge_connector_init_hdmi_audio_cec(bridge_connector);
 	if (ret)
-		return ret;
+		goto err_put;
 
 	drm_connector_helper_add(connector, &drm_bridge_connector_helper_funcs);
 
@@ -1072,9 +1125,25 @@ static int drm_bridge_connector_add_connector(struct drm_bridge_connector *bridg
 
 	ret = drm_connector_attach_encoder(connector, bridge_connector->encoder);
 	if (ret)
-		return ret;
+		goto err_put;
+
+	ret = drm_connector_dynamic_register(connector);
+	if (ret)
+		goto err_put;
 
 	return 0;
+
+err_put:
+	drm_connector_put(connector);
+	bridge_connector->dynconn = NULL;
+	return ret;
+}
+
+static void drm_bridge_connector_fini(struct drm_device *dev, void *res)
+{
+	struct drm_bridge_connector *bridge_connector = (struct drm_bridge_connector *)res;
+
+	drm_bridge_connector_dynconn_release(bridge_connector);
 }
 
 /**
@@ -1104,10 +1173,6 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 	if (!bridge_connector)
 		return ERR_PTR(-ENOMEM);
 
-	ret = drmm_add_action(drm, drmm_bridge_connector_put_bridges, bridge_connector);
-	if (ret)
-		return ERR_PTR(ret);
-
 	bridge_connector->drm = drm;
 	bridge_connector->encoder = encoder;
 
@@ -1115,6 +1180,13 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 	if (ret)
 		return ERR_PTR(ret);
 
-	return &bridge_connector->base;
+	ret = drmm_add_action_or_reset(drm, drm_bridge_connector_fini, bridge_connector);
+	if (ret)
+		return ERR_PTR(ret);
+
+	if (!bridge_connector->dynconn)
+		return ERR_PTR(-EINVAL);
+
+	return &bridge_connector->dynconn->connector;
 }
 EXPORT_SYMBOL_GPL(drm_bridge_connector_init);

-- 
2.54.0

