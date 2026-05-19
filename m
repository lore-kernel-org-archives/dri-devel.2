Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C05E3CD5BA3
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 10:40:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D20710EC48;
	Tue, 19 May 2026 10:40:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="yoXF7nFv";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C94910EC48
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 10:40:45 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id DB034C2B9E5;
 Tue, 19 May 2026 10:41:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id B014B606E9;
 Tue, 19 May 2026 10:40:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4C3AF107E8A20; 
 Tue, 19 May 2026 12:40:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1779187242; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=td7yo9XNS1lv1rXLaX8XcWtU3vhlD0VxXYz9PxW/V+o=;
 b=yoXF7nFvbpPJi1a+qgsb8Y5Du8LSUfy41GDr8QvcHAxISWnIX/ZkkfKjHvzyCIc4ZwI3AD
 XaCQD944dR8xIQP5vIlX6xYzD6G7Mxqz0EX9luiWXbwLlmGGTmSM8NMV+1sX+2IA7rD7Nr
 tHcdOS0wuDCH8vlxN1U3lFasNn8/Mn4a/IFMEE5aDHNprKYIHWxyz/NVXe1oQyChI4NdxC
 tM3BnpJYdIA1KUcgquVWYGanxcs8jXUQYIMXqdHlf/1yL4MmHhELy0Z+ijrtWXvnE5+5jZ
 h91bR6v2ibkfIbulGOfoD/Ot8nMo97kZuoDoAkF05rscBR1apCZZ3jDLh0vQOg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 19 May 2026 12:37:53 +0200
Subject: [PATCH 36/37] drm/display: bridge-connector: handle bridge hotplug
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-drm-bridge-hotplug-v1-36-45e2bdb3dfb4@bootlin.com>
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

The drm_bridge_connector is nowadays the recommended way to implement DRM
connectors when a chain of bridges is used, and as such it is the ideal
component to implement DRM bridge hotplug. Thus, let the
drm_bridge_connector be created once for the whole drm_encoder lifetime (as
it is now), but make it able of creating and destroying the DRM connector
reacting on bridge hot(un)plug events.

Unfortunately the current drm_bridge_connector_init() API is unable to
support DRM bridge hotplug because it returns a drm_connector, and with
hotplug the connector might start existing only later, and also be
destroyed and recreated multiple times.

So add a new API which is similar but returns a pointer to the
drm_bridge_connector, which is persistent, and supports bridge hotplug by
creating and destroying the drm_connector based on hotplug events.

Because drm_bridge_connector_init() is really a drmm function (it does only
drmm allocations), but without a drmm_ prefix, take this as an opportunity
to call the new function with the same name but a drmm_ prefix:
drmm_bridge_connector_init(). The old API can be replaced over time when
needed to support hotplug, and eventually be removed if unused.

The new drmm_bridge_connector_init() API differs from the old one in a few
aspects in order to support bridge hotplug:

 * if the bridge chain is not (yet) complete, returns successfully without
   adding a drm_connector (in this case the old API returns an error)
 * registers an event notifier block to be able of reacting to events
   related to bridge hotplug and create/destroy the drm_connector

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

I'm tempted to let drmm_bridge_connector_init() return int (0 or negative
error) instead of a struct drm_bridge_connector *, but I'm not sure whether
the drm_bridge_connector pointer may be useful in the future to invoke
actions on the bridge_connector after its creation. Opnions about this
would be welcome.
---
 drivers/gpu/drm/display/drm_bridge_connector.c | 157 +++++++++++++++++++++++++
 include/drm/drm_bridge_connector.h             |   2 +
 2 files changed, 159 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index b83da529cc7a..2ce6c04e2fc7 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -20,6 +20,7 @@
 #include <drm/drm_device.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_managed.h>
+#include <drm/drm_event_notifier.h>
 #include <drm/drm_modeset_helper_vtables.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
@@ -158,6 +159,10 @@ struct drm_bridge_connector {
 	 * destruction
 	 */
 	struct mutex dynconn_mutex;
+	/**
+	 * @drm_event_nb: notifier to receive DRM hotplug-related events
+	 */
+	struct notifier_block drm_event_nb;
 };
 
 static struct drm_bridge_connector_dynconn *
@@ -1037,6 +1042,19 @@ static int drm_bridge_connector_init_hdmi_audio_cec(struct drm_bridge_connector_
 	return 0;
 }
 
+static bool drm_bridge_connector_pipeline_is_complete(struct drm_bridge_connector *bridge_connector)
+{
+	struct drm_bridge *last_bridge __free(drm_bridge_put) =
+		drm_bridge_chain_get_last_bridge(bridge_connector->encoder);
+
+	if (!last_bridge || !drm_bridge_is_tail(last_bridge)) {
+		drm_dbg_driver(bridge_connector->drm, "pipeline not (yet) fully connected");
+		return false;
+	}
+
+	return true;
+}
+
 /**
  * drm_bridge_connector_add_connector - add the drm_connector
  * @bridge_connector: drm_bridge_connector to add the drm_connector to
@@ -1153,6 +1171,79 @@ static int drm_bridge_connector_add_connector(struct drm_bridge_connector *bridg
 	return ret;
 }
 
+/*
+ * Propagate the attach chain and possibly add a drm_connector after a new
+ * drm_bridge is hot-plugged.
+ *
+ * The connector is added only if the pipeline is now complete. This could
+ * not be the case for various reasons:
+ *
+ * - the new bridge is just unrelated to our encoder
+ * - the new bridge is not be the next one in the pipeline
+ * - the new bridge is the next in the pipeline but the pipeline is not yet
+ *   complete
+ *
+ * All these cases are normal, not an error.
+ */
+static void drm_bridge_connector_try_complete(struct drm_bridge_connector *bridge_connector)
+{
+	int err;
+
+	/*
+	 * drm_connector already present, the new bridge must be for
+	 * another card
+	 */
+	if (bridge_connector->dynconn)
+		return;
+
+	/* Propagate the attach call chain to newly hotplugged bridge(s) */
+	struct drm_bridge *last_bridge __free(drm_bridge_put) =
+		drm_bridge_chain_get_last_bridge(bridge_connector->encoder);
+
+	/* Encoder chain empty? */
+	if (!last_bridge)
+		return;
+
+	err = last_bridge->funcs->attach(last_bridge, bridge_connector->encoder,
+					 DRM_BRIDGE_ATTACH_NO_CONNECTOR);
+	if (err)
+		return;
+
+	/* Add the connector if the pipeline is now complete */
+	if (drm_bridge_connector_pipeline_is_complete(bridge_connector))
+		drm_bridge_connector_add_connector(bridge_connector);
+}
+
+static int drm_bridge_connector_handle_event(struct notifier_block *nb,
+					     unsigned long event, void *data)
+{
+	struct drm_bridge_connector *bridge_connector =
+		container_of(nb, struct drm_bridge_connector, drm_event_nb);
+
+	switch (event) {
+	case DRM_MIPI_DSI_ATTACHED:
+		/* One or more bridges hot-plugged, try adding the drm_connector */
+		drm_bridge_connector_try_complete(bridge_connector);
+		break;
+	case DRM_BRIDGE_DETACHED:
+	{
+		/*
+		 * A bridge was unplugged, remove the drm_connector if it's
+		 * part of the same pipeline
+		 */
+		struct drm_bridge *bridge = (struct drm_bridge *)data;
+
+		if (bridge_connector->dynconn &&
+		    bridge->encoder == bridge_connector->encoder)
+			drm_bridge_connector_dynconn_release(bridge_connector);
+		break;
+	}
+	default:
+	}
+
+	return NOTIFY_DONE;
+}
+
 static void drm_bridge_connector_fini(struct drm_device *dev, void *res)
 {
 	struct drm_bridge_connector *bridge_connector = (struct drm_bridge_connector *)res;
@@ -1205,3 +1296,69 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 	return &bridge_connector->dynconn->connector;
 }
 EXPORT_SYMBOL_GPL(drm_bridge_connector_init);
+
+static void drm_bridge_connector_notifier_unregister(struct drm_device *dev, void *res)
+{
+	struct notifier_block *nb = (struct notifier_block *)res;
+
+	drm_event_notifier_unregister(nb);
+}
+
+/**
+ * drmm_bridge_connector_init - Initialise the bridge_connector for a chain
+ *                              of bridges, with bridge hotplug support
+ * @drm: the DRM device
+ * @encoder: the encoder where the bridge chain starts
+ *
+ * Allocate, initialise and register a &drm_bridge_connector with the @drm
+ * device. The connector is associated with a chain of bridges that starts at
+ * the @encoder. All bridges in the chain shall report bridge operation flags
+ * (&drm_bridge->ops) and bridge output type (&drm_bridge->type), and none of
+ * them may create a DRM connector directly.
+ *
+ * Also adds a drm_connector if the bridge chain is complete, otherwise the
+ * &drm_bridge_connector will still be successfully created but without
+ * adding a drm_connector. In both cases the &drm_bridge_connector will
+ * receive events notifying bridge hot-plug and hot-unplug and add or
+ * destroy the drm_connector accordingly.
+ *
+ * Returns a pointer to the new &drm_bridge_connector on success, or a
+ * negative error pointer otherwise.
+ */
+struct drm_bridge_connector *drmm_bridge_connector_init(struct drm_device *drm,
+							struct drm_encoder *encoder)
+{
+	struct drm_bridge_connector *bridge_connector;
+	int ret;
+
+	bridge_connector = drmm_kzalloc(drm, sizeof(*bridge_connector), GFP_KERNEL);
+	if (!bridge_connector)
+		return ERR_PTR(-ENOMEM);
+
+	mutex_init(&bridge_connector->dynconn_mutex);
+	bridge_connector->drm = drm;
+	bridge_connector->encoder = encoder;
+	bridge_connector->drm_event_nb.notifier_call = drm_bridge_connector_handle_event;
+
+	if (drm_bridge_connector_pipeline_is_complete(bridge_connector)) {
+		ret = drm_bridge_connector_add_connector(bridge_connector);
+		if (ret)
+			return ERR_PTR(ret);
+	}
+
+	ret = drmm_add_action_or_reset(drm, drm_bridge_connector_fini, bridge_connector);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ret = drm_event_notifier_register(&bridge_connector->drm_event_nb);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ret = drmm_add_action_or_reset(drm, drm_bridge_connector_notifier_unregister,
+				       &bridge_connector->drm_event_nb);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(drmm_bridge_connector_init);
diff --git a/include/drm/drm_bridge_connector.h b/include/drm/drm_bridge_connector.h
index 69630815fb09..1c78221c0857 100644
--- a/include/drm/drm_bridge_connector.h
+++ b/include/drm/drm_bridge_connector.h
@@ -10,6 +10,8 @@ struct drm_connector;
 struct drm_device;
 struct drm_encoder;
 
+struct drm_bridge_connector *drmm_bridge_connector_init(struct drm_device *drm,
+							struct drm_encoder *encoder);
 struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 						struct drm_encoder *encoder);
 

-- 
2.54.0

