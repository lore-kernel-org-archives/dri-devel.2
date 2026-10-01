Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFFFCCA5FD2
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 12:43:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B55510E37C;
	Thu,  1 Oct 2026 12:43:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="2Yj+ODgK";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3759910E37C
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 12:43:19 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 0AD771A24DD;
 Thu,  1 Oct 2026 12:43:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id CB7AF60341;
 Thu,  1 Oct 2026 12:43:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 94E4E103280C2; 
 Thu,  1 Oct 2026 14:43:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790858595; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=HbnceyH8p/ykbzt4ziSQS3qiAWPQIZhyEXmEfD7Tvoo=;
 b=2Yj+ODgKsmRjRwRTe1XF1SZQ+BEdMkucvEXLlD+lCgzN8FNd6SYyY8ELMKnI2vbEiIo14b
 tw/08+M3OJS0SXlSvfw/LbZ8dNAuvvm9Q7B6s9iRBAtVQlHkGnEi+Yok2UdwCuz89tW2AC
 pgwmnf/fwD0C77e5y8an2iv+R+RGe+QvUdPQOspNiOnydwn1lQYCKvBpB6P5x9WT7x1JCa
 awjf4mFWpDAtXYtlvA+yZAsIN8JliUp+v6lfkeid89kpNIliZFomhrKem6VXpqpcXsUhpL
 ZCHUFakY3sPCsREYDVVE4aVoZnD6AyhZ1mPwE4nxt8PfDv6A6HwFw3DaigfB6w==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Thu, 01 Oct 2026 14:42:27 +0200
Subject: [PATCH RFC v2 05/24] drm/display: bridge-connector: use a dynamic
 connector
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-drm-bridge-hotplug-v2-5-8e34986dcb68@bootlin.com>
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

Currently the drm_bridge_connector uses drmm functions to add the
drm_connector. For bridge hotplug drmm allocations are not suitable because
a connector may have to be added and removed multiple times in the lifetime
of a card.

In preparation for bridge hotplug, use the dynamic variants of
drm_connector[_hdmi]_init() so the drm_connector can be removed without
removing the whole card.

| [TODO]
| - there is a hack about state creation, already discussed,
|   still to be sorted out
| - there are still 2 drmm calls to be converted to non-drmm:
|   drmm_connector_hdmi_cec_notifier_register() and
|   drmm_connector_hdmi_cec_register

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/display/drm_bridge_connector.c | 86 ++++++++++++++++++--------
 1 file changed, 59 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index 2aff745f0147..1c222e27767d 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -137,6 +137,18 @@ struct drm_bridge_connector {
 #define to_drm_bridge_connector(x) \
 	container_of(x, struct drm_bridge_connector, base)
 
+static void drm_bridge_connector_put_bridges(struct drm_bridge_connector *bridge_connector)
+{
+	drm_bridge_put(bridge_connector->bridge_edid);
+	drm_bridge_put(bridge_connector->bridge_hpd);
+	drm_bridge_put(bridge_connector->bridge_detect);
+	drm_bridge_put(bridge_connector->bridge_modes);
+	drm_bridge_put(bridge_connector->bridge_hdmi);
+	drm_bridge_put(bridge_connector->bridge_hdmi_audio);
+	drm_bridge_put(bridge_connector->bridge_dp_audio);
+	drm_bridge_put(bridge_connector->bridge_hdmi_cec);
+}
+
 /* -----------------------------------------------------------------------------
  * Bridge Connector Hot-Plug Handling
  */
@@ -267,6 +279,14 @@ drm_bridge_connector_color_format(const struct drm_connector_state *conn_state)
 	return conn_state->color_format;
 }
 
+static void drm_bridge_connector_dynconn_destroy(struct drm_connector *connector)
+{
+	struct drm_bridge_connector *bridge_connector = to_drm_bridge_connector(connector);
+
+	drm_connector_cleanup(connector);
+	drm_bridge_connector_put_bridges(bridge_connector);
+}
+
 static const struct drm_connector_funcs drm_bridge_connector_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.atomic_create_state = drm_bridge_connector_create_state,
@@ -275,6 +295,7 @@ static const struct drm_connector_funcs drm_bridge_connector_funcs = {
 	.debugfs_init = drm_bridge_connector_debugfs_init,
 	.oob_hotplug_event = drm_bridge_connector_oob_hotplug_event,
 	.color_format = drm_bridge_connector_color_format,
+	.destroy = drm_bridge_connector_dynconn_destroy,
 };
 
 /* -----------------------------------------------------------------------------
@@ -823,20 +844,6 @@ static const struct drm_connector_hdmi_cec_funcs drm_bridge_connector_hdmi_cec_f
  * Bridge Connector Initialisation
  */
 
-static void drm_bridge_connector_put_bridges(struct drm_device *dev, void *data)
-{
-	struct drm_bridge_connector *bridge_connector = (struct drm_bridge_connector *)data;
-
-	drm_bridge_put(bridge_connector->bridge_edid);
-	drm_bridge_put(bridge_connector->bridge_hpd);
-	drm_bridge_put(bridge_connector->bridge_detect);
-	drm_bridge_put(bridge_connector->bridge_modes);
-	drm_bridge_put(bridge_connector->bridge_hdmi);
-	drm_bridge_put(bridge_connector->bridge_hdmi_audio);
-	drm_bridge_put(bridge_connector->bridge_dp_audio);
-	drm_bridge_put(bridge_connector->bridge_hdmi_cec);
-}
-
 static struct drm_connector *
 drm_bridge_connector_initialize(struct drm_bridge_connector *bridge_connector,
 				struct drm_device *drm,
@@ -849,10 +856,6 @@ drm_bridge_connector_initialize(struct drm_bridge_connector *bridge_connector,
 	int connector_type;
 	int ret;
 
-	ret = drmm_add_action(drm, drm_bridge_connector_put_bridges, bridge_connector);
-	if (ret)
-		return ERR_PTR(ret);
-
 	bridge_connector->encoder = encoder;
 
 	/*
@@ -1053,17 +1056,21 @@ drm_bridge_connector_initialize(struct drm_bridge_connector *bridge_connector,
 				drm_bridge_connector_scrambler_disable;
 		}
 
-		ret = drmm_connector_hdmi_init(drm, connector,
-					       &drm_bridge_connector_funcs,
-					       &bridge_connector->hdmi_funcs,
-					       connector_type, ddc);
+		ret = drm_connector_hdmi_dynamic_init(drm, connector,
+						      &drm_bridge_connector_funcs,
+						      &bridge_connector->hdmi_funcs,
+						      connector_type, ddc);
 	} else {
-		ret = drmm_connector_init(drm, connector,
-					  &drm_bridge_connector_funcs,
-					  connector_type, ddc);
+		ret = drm_connector_dynamic_init(drm, connector,
+						 &drm_bridge_connector_funcs,
+						 connector_type, ddc);
 	}
-	if (ret)
-		return ret;
+	if (ret) {
+		drm_bridge_connector_put_bridges(bridge_connector);
+		return ERR_PTR(ret);
+	}
+
+	/* From now on the connector is referenced and has to be put */
 
 	if (bridge_connector->bridge_hdmi_audio ||
 	    bridge_connector->bridge_dp_audio) {
@@ -1113,6 +1120,9 @@ drm_bridge_connector_initialize(struct drm_bridge_connector *bridge_connector,
 
 	drm_connector_helper_add(connector, &drm_bridge_connector_helper_funcs);
 
+	if (!connector->state)
+		connector->state = drm_bridge_connector_create_state(connector);
+
 	if (bridge_connector->bridge_hpd)
 		connector->polled = DRM_CONNECTOR_POLL_HPD;
 	else if (bridge_connector->bridge_detect)
@@ -1130,9 +1140,26 @@ drm_bridge_connector_initialize(struct drm_bridge_connector *bridge_connector,
 	if (ret)
 		return ERR_PTR(ret);
 
+	ret = drm_connector_dynamic_register(connector);
+	if (ret)
+		return ERR_PTR(ret);
+
 	return connector;
 }
 
+static void drm_bridge_connector_fini(struct drm_bridge_connector *bridge_connector)
+{
+	drm_connector_unregister(&bridge_connector->base);
+	drm_connector_put(&bridge_connector->base);
+}
+
+static void drmm_bridge_connector_fini(struct drm_device *dev, void *res)
+{
+	struct drm_bridge_connector *bridge_connector = (struct drm_bridge_connector *)res;
+
+	drm_bridge_connector_fini(bridge_connector);
+}
+
 /**
  * drm_bridge_connector_init - Initialise a connector for a chain of bridges
  * @drm: the DRM device
@@ -1155,6 +1182,7 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 {
 	struct drm_bridge_connector *bridge_connector;
 	struct drm_connector *connector;
+	int ret;
 
 	bridge_connector = drmm_kzalloc(drm, sizeof(*bridge_connector), GFP_KERNEL);
 	if (!bridge_connector)
@@ -1164,6 +1192,10 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 	if (IS_ERR(connector))
 		return connector;
 
+	ret = drmm_add_action_or_reset(drm, drmm_bridge_connector_fini, bridge_connector);
+	if (ret)
+		return ERR_PTR(ret);
+
 	return connector;
 }
 EXPORT_SYMBOL_GPL(drm_bridge_connector_init);

-- 
2.55.0

